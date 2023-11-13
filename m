Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7325C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 06:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AB410E156;
	Mon, 13 Nov 2023 06:52:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5154C10E156
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 06:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxVD4zs3rHv+T1xBUDeSzM5bK8d6zI5U2mL3PgxJbeJ004gH7FPctiS0JgRkPkv4oDXyQRUnZxKUFiRrRLVXIhc7q0yBjZY040t1yfouA3P0D0JleF6FWi7Y5OCpaQjJSPtvdgEeehr+JvEwogL1yWcgi+kUkgwd66nn8E+msYyMAXjYu/hFglSgk2RfuXaFxC3lOSHebaf9jIMYv7i+Lshe9DAHF0jIKxaKgmNqs0z2cAE2p4ooocoVG9EFyeBSRLjtHTOgGHsKl73XDPrnsP826laJYABtIjwUM9tuXRZiNhxHqIUw+5WBsWCodnL4mVmQkhq/0g/+vpBHrUQrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ouha/6tI/t5haQITStAS5uvZ2kzPS1qn9a1Ej2MJAs=;
 b=knqgeaxHJ/kLIYQs5aObgSIOlIp5bEhYrUS9MBHgCC6noASWuNMAYYyl0AQL87aGA6CDgJa8kGV8Ngt7Qo1Esb9JgPBgUE0k9iqEHfRQ415gCjwxFD76afrw4xMVWDKjMRELVK1m2KWcSBtinbWXHNClsba+wWBkou01sJ0y90maBG7Ew6SMH1qlrO0GQV9jdMnXZll9YuUYYk/KXGcRQ/TSLw/4EKdRCAFhvSGdo8q2W9prFnr5Za1+rBxZE4EaP5nsvKpPiktmkv0/MnwmqYkWla80VnUed9MxgNaF3Txuh1aGSDCRpCR8pBWVEYSlE5M5zUZZWsd+GUFwg8cVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ouha/6tI/t5haQITStAS5uvZ2kzPS1qn9a1Ej2MJAs=;
 b=3Kcc4RglP6hDfTjCh9VXAuSLG5b+RXcdhgcKa0dxvAf6u2I6XHpSQv28Lfkp6BPoyAyNRVAUzrGaDbcLRfEqU3jaMg2NUeMr+3rHnfzJmgrGuZt5OIvIrqLQMJPNq7PA1uCSc366/GtW/P74PtejJq5SW49WgeJ4/P7CB7q6THE=
Received: from CY5PR15CA0189.namprd15.prod.outlook.com (2603:10b6:930:82::7)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 06:52:00 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::c8) by CY5PR15CA0189.outlook.office365.com
 (2603:10b6:930:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 06:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Mon, 13 Nov 2023 06:52:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 00:51:56 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix err_data null pointer issue in amdgpu_ras.c
Date: Mon, 13 Nov 2023 14:51:29 +0800
Message-ID: <20231113065129.649893-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 42420aee-ec2e-4a09-e541-08dbe4150937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PW/s2QZvFwKbLp+d8oYx1Wdy5iLbVHFDK+KRwwOIpkYOFnwV1bDndNeyA8vwBt7G5erEFIoI0b8vWp6xJDDc2zTIWqIQPuqevI/wcRhlZqTpmX4C3yJNNjHIDYgaJjqRVU0TjjXPSPLRtMRXuZam4dgT7CP58QHk9bMOfeLLQDFiu5pXI9jEZr0YnCnlR9Gmo1bRvXoxrpGCXtAjFERDPxCX9m9u88wP3P4CeGXrJ0b+fcpv29rE7D4Zqvw/W6geQKUSBXviy6hCjItNBu0PBr6jEjrggMZFPGz5iWQwAt5NQOwieDNIkNWJQsDBuow80xSFcbuIlWp9dt7F8guaLuNn2/UPAfTaxGxrds7JELmdf6RqVd/39PpWXzo3zFdirXYvwKvlqj57wmIUm5s6Xam7ulESsTt3nuZEOhmUIgWjTDtaYPnmP/5rraCx/3/8rZ6L9wAD0byXmjYu2wxtgTuWrsSSnJvRwwF2gdao8TXExZCk6iZWzE4W1Am0OHVLShNHazyFjMJobGIBPQvRUbCQN4R7nbrh+RJXf3BuHG1dipQDON9LSLvaUlP9iriGNBnMzIvWBeczkXRB+6RHKnTXc9NduPmHiz6fqmLJFRGPBPfTum0Qhbtspu5gjvMgkNTuYmA1LEHhAxv3xTnmpmWXAzNvAmyANTO12Tcdq2MOKcb2qDQ1nYgqYPJsGg0vW3VhF+0qk9r4FsOlSeH5fTDorUlbmaEfsnzV8rTrTLhE3t54mzK08cUgu8iSYeTnpneC0QsMfNujV/Th4x3UAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(16526019)(426003)(336012)(1076003)(26005)(7696005)(6666004)(2616005)(36860700001)(83380400001)(47076005)(5660300002)(4326008)(8936002)(8676002)(4744005)(2906002)(41300700001)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 06:52:00.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42420aee-ec2e-4a09-e541-08dbe4150937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Hawking.zhang@amc.com, candice.li@amd.com,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix err_data null pointer issue about err_data in amdgpu_ras.c

Fixes: b752e18f33f1 ("drm/amdgpu: Support multiple error query modes")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1372380d2423..13ccc4cc36c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1188,7 +1188,7 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 			}
 
 			if (block_obj->hw_ops->query_ras_error_count)
-				block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+				block_obj->hw_ops->query_ras_error_count(adev, err_data);
 
 			if ((info->head.block == AMDGPU_RAS_BLOCK__SDMA) ||
 			    (info->head.block == AMDGPU_RAS_BLOCK__GFX) ||
-- 
2.34.1

