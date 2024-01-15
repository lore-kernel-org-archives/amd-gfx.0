Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C482BC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 12:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5671E10E28F;
	Mon, 15 Jan 2024 12:04:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09C810E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 12:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agTNvcZofp8JweCmiCv76tL1W0/ZPfKGcyvlOET9XwiakJKFgUZuUESpJsUv4MWSmVu8V4CP0yhepWcQRytpvRScZXASiB5ZiI2BiYUqhdqQ6hqqKcBj5IXxHMN+97eTWyNqJuJpjxxM5gWVCmcRw3fEF4pej79bP+yV77pn6sXleoJRWdRM5SefWIfIVSglAwkm3nf1tzffHD2PQH36qWs9Z4jN6mWjvebeGGUs7ZK7D4Li6yIpGUm1leGXIIeBWYXvMZdMTs23wk7uXCpJ1lO1okkh3HrKwKU7u92dBWKdhYKlhKswF6QTIvXLOCUeXOf6FjUhSUUgMD6zsTiOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azAkQK6peE1HBXLnUtU3lImGS8GpJnVFq+IIfnrpE5U=;
 b=SOvrapZxItjtjM8oz+L2rvwQi7l4Kw4OrptjfbaHjfE4sKhn/y6Cink9VvJ2+8V1DVtwfhuxBZuyGRtDT2VTNtKR94Hmfm2D7DLWWWJSdxXXmWB3ElsHTgra70SbeZ47OT70qBK92uty90w4LU3F9sDEmHDFnOMQAy97eAzMF803jL/saqlmPlbUE6ukQnJKTtXUy8FUZ0kTimCB58XtpwBb2LjID8HuXAx4rlakd2O6A4jrMkFrOa+5PkMP8PJSAGeGkk5zApQIzrUlQ4ElIRbar6+7FJatJIgObit6b8fLuvwls+QlDqdlLv5THg5eT5Hn3GpPMmHXQqz3Le5qLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azAkQK6peE1HBXLnUtU3lImGS8GpJnVFq+IIfnrpE5U=;
 b=bllDBEdprsf7DtK83EmYiq18OlooWSBfbUCp7fniSTe89574kEkqPdN5pzBM635RkrxutA91mx9xKFoVIm5OnUROf6AhMaCy0Kwp8NMDZe9vj5fzgY3Tjzjmy3u3r6Dk5U9HzMOGytcxzRcq17aIHKVp/eBBHMlyLSCuIfumJ4E=
Received: from CY5PR22CA0051.namprd22.prod.outlook.com (2603:10b6:930:1d::27)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Mon, 15 Jan
 2024 12:04:09 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::b7) by CY5PR22CA0051.outlook.office365.com
 (2603:10b6:930:1d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 12:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 15 Jan 2024 12:04:09 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 06:04:07 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix sdma ecc irq unbalanced issue
Date: Mon, 15 Jan 2024 20:03:18 +0800
Message-ID: <20240115120318.936129-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 12aff0d9-c844-4838-ad53-08dc15c214b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUN3ExfktWsnECruzEXOOjWJ8oqIKBxBke6WvM9RZhktJnOp+ObJqi88/vY4/2O5qhUEq7gZLkZnUREXJ4xY29xqw8BLjhzIkBXRgzZgWbkUyYiSYxxaYMF06xGzHSCIKmCwo9IeigqLJbvocJrRoCLuGyLi4Zk6uecez2QZjI1AQ0I+59ucRShB9LQJj3mc/s1WFbYMRj17ayD4f1Vbtfs2ZeG5CigHwWO5KbuSMsfNYWW/BtjJNMbVtKml2UiRFMM+mzr9dhtJRJJgfQq9twNU9fStUGw1zSqCkrMhmvqCjVlhPar8xzbY0gfQCAfLgncHpxqz52EfDQoVFdGwVAUPNkh0Ilt86Wg1PC4TkumPoIiakQTHADUfcKtOaTjJFybpkn2o2JpIM+e8B5IfqSogWFjy01uS4AR1ePM7rMjClhcSQfp1oU8hyLhURvmFW4CVaZKUBIU7oHOER5hYpa05oBnpJFuhnNspNq0LOzzmHGTkj2c+ZjINns1iZaLPwanLDisGM46jXTk6hVpZl6Pc52XbWncVTAor/a3xPHnlEf3uoC7VXoHgjFowGEt4R3Cjn4TtgFxeJj6ot2617bt3P+dDCE2aCQIOCGESUpW7C15OiHkfNt5YVXHh5CwUaJa3Q1pcVCGqlDjqpGST2yZrCrHB6RhtMJk+VJH+yLwYXP//kBvxSigaZvkndqPMdcJdpKEX2kOAK1Ww7Pkk8GEzTvJWnBM5ZKhjd9N59nqEywFvEw+STi/0GuQkdYIhJLb/WBUZ76tgq8QpRPTDVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(81166007)(7696005)(6666004)(1076003)(26005)(336012)(36756003)(2616005)(16526019)(356005)(86362001)(41300700001)(36860700001)(47076005)(83380400001)(82740400003)(478600001)(426003)(5660300002)(8936002)(4326008)(40480700001)(8676002)(40460700003)(54906003)(70206006)(70586007)(316002)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 12:04:09.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aff0d9-c844-4838-ad53-08dc15c214b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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
Cc: Yang Wang <kevinyang.wang@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix sdma ecc irq unblanced issue when do mode2 reset.

Fixes: 90b87f67124a ("drm/amdgpu: add sdma v4.4.2 ACA support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4bb055eacad5..fec5a3d1c4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2267,21 +2267,12 @@ static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 {
 	int r;
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
+	r = amdgpu_sdma_ras_late_init(adev, ras_block);
 	if (r)
 		return r;
 
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
-				&sdma_v4_4_2_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
+	return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
+				   &sdma_v4_4_2_aca_info, NULL);
 }
 
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
-- 
2.34.1

