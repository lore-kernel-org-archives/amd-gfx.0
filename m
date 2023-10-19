Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3336BCDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 07:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E4810E496;
	Thu, 19 Oct 2023 07:15:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F089410E496
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 07:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxVzDeIlaJdSkW3QuAPLRonnpEckE6FIqCu6TRV+zDyIXxp9NkUu3dmB3Pbco0WuZV7MLlam4VRjCyZbM/qCn81zNA6W/KjIEK7bqmC3OKMRTHowkJ7nMScMSQgfUMO2JhvjRt6E5zmxL+4YtRIrtf4ncvNJti+Cyj0Je5VeSl0zl917/+zD+kQlKE0JXjgT8Jj3/8JCHutY3/CaK/5Eyu8o3N9GpQW7dBG11rK6NjWltN7lCqg/w9bwgXB07q9rYvLnV/UXyOQGUcuiUilwkwF4OhIPfWjV2N2OBdAXdxeshjzcF6NuxHPT7H4Ybhul1YuCZ7fvysH7upp3KjTkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hsApaXtsG3h9e2G5WYJR0S9eY99Fp5TB3WlcqmvAdo=;
 b=ijo7EiueR9JnEzjv+7e1jTFPCwgHy55EcBkY5S4gFwe/lTW0S8iHdB3EienwINOET3mjOZbOdGcZ69g1eyDX7sqDjqbs4r3kAzkodKnjZYhHBA3GkH1F+5ZYyKR13A77kmDj+nxT+bT0C5/W7tR/rbr0ge3BFj0mUNX8Oi7hgG/rPiN34e7ltrkwQNQfd61dZxr6VGA2Z0f2AzT8wvB8ut0pv7E7o/cB3LDovUOz5PSGSO5FDFbQsRErYupn49o/jyiuqh8vB2f2Lt2/yiWy6aXddA3pUm1KfW5/QzYScwpNr1edQg3WIhooxMPkIm+q7PK3n9Ox+D54vJlGv5LNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hsApaXtsG3h9e2G5WYJR0S9eY99Fp5TB3WlcqmvAdo=;
 b=Z3B15RXwlZbPaR/F0tDqJd+FyWnOL3Rq3V7JmUNLqu+Wp3PsXGFcoMnpbAxW7ooDP4qI+sMfVuJe8nPXmqTsRD99dmBiDVLK7jfG/0qwTaBcLie4V0d7/Z6gGaMK5T9AxhQh/8Hx11RfZw0EnTarCOoJXCaBHBXDfqexqZIl0ro=
Received: from DM6PR17CA0016.namprd17.prod.outlook.com (2603:10b6:5:1b3::29)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 07:15:43 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a0) by DM6PR17CA0016.outlook.office365.com
 (2603:10b6:5:1b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 07:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 07:15:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 02:15:41 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix typo for amdgpu ras error data print
Date: Thu, 19 Oct 2023 15:15:28 +0800
Message-ID: <20231019071528.982386-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: e34e4d40-a158-44d2-1983-08dbd07334ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYYPG1QZezEzCTxBa8r4nH3eKmO4jSPpi1JaWzdibwfVkIe9I6qO9rrBijTdaGMkIdPV/KZbDwtPoOiwanraTccNtiZNJZ72fXCI58WONBNytGgv8xo7kQ+X7719rC0WKKys+Vw1ZjEJFuZWZqSlcFGxB4l/SoJm1ezuwOimtaAcWZkUz5nb3WBWYS3E8L4CZQt91jxPM5ktWMN41dNgmcydCq2jzlpLMU9xZjhUKQMIJexn8mSFkPirmiNaadE7DRIbsm2dWUAJ6JM2y/gPN6D03tLnieo5oN0Qo2Y87l9CEQlOnPedRIA2xOjT7cJYBxLe1JflIJ7PfTeSDjsX9EegY98T1EaQBGQUjjHag+Ew7dyA53Y/ni32TlZKtpv/hP4mf4IJ8J9W6nUWHlbcAhmww3HkmQQOwCIQofrnF0Q1+0+r8fxneMSYPBFeVZKQVXZTuPoUfwMZgvXyeK7zc8L5NiMUFdTmTONl8eBqOFVJWFsbxSQM9otK+EuziaBV7tCWcufp85p8gxOy5LlCQcrp5KYvqkT3x8eis2EVxy65rW2Cd75t/sx/Dcdh6PPV7o6gXwHAGaufyH89Q7zKyFV2nL50+G8zRCwF3HoK0sj+9YkyFVXGRmGCFdHfMa/Rzs7kOUJQSylOWEgDPEYVubQ76P5akUAA8ATJwWnxULjpORZ34hUu8ic72O9TShtOtx4ILq9YPH8gzj6Ik/MYoocp6QSUvsHW+uvzYa8b+M4FP+OTTL9jpRDnXlxSUzUHVSxtJjlJqji8pLMiOlxTVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(5660300002)(40460700003)(40480700001)(36756003)(2616005)(81166007)(2906002)(70586007)(1076003)(6916009)(316002)(41300700001)(86362001)(70206006)(8936002)(4326008)(8676002)(54906003)(478600001)(7696005)(6666004)(426003)(336012)(356005)(16526019)(26005)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:15:42.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34e4d40-a158-44d2-1983-08dbd07334ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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

typo fix.

Fixes: d479ef0d5fbd ("drm/amdgpu: add ras_err_info to identify RAS error source")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c7f8dcb3b4d2..5b831ba0ebb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1038,7 +1038,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 			 ras_mgr->err_data.ue_count, blk_name);
 	else
 		dev_info(adev->dev, "%ld correctable hardware errors detected in %s block\n",
-			 ras_mgr->err_data.ue_count, blk_name);
+			 ras_mgr->err_data.ce_count, blk_name);
 
 	for_each_ras_error(err_node, err_data) {
 		err_info = &err_node->err_info;
@@ -1055,7 +1055,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 				 "%lld correctable hardware errors detected in %s block\n",
 				 mcm_info->socket_id,
 				 mcm_info->die_id,
-				 err_info->ue_count,
+				 err_info->ce_count,
 				 blk_name);
 		}
 	}
-- 
2.34.1

