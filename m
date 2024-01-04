Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCAEC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 05:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E0710E38E;
	Thu,  4 Jan 2024 05:25:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4CE10E38E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 05:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO0oJ9hsFO5EIo9LeTDMq5avG9Yi5qqHY2Fk7v1JAqTVsnRVBVWBSz/vGg6p2mOhQqiXVahq48aYyhKltrH120Z47NjorlAqrLXps0fjWXiPJRxMEmC0NQu50WxH+9C36sBdReIIDeSLnNs4AuXQdDbExDMyWyZFx0STy/sWQF0z8rM8WeHOKicS2W0jThg23yyhCiqsPU6eVCJJ9Q5NanQboUvniM06EmC8VrdAQxeisN8ze/OBfg7Uw/04h/6gVgAqm3eMNgqjuAUcxmzgHBrFm4gT8uyD1mUMjS440FgvcxybUnhhbXQ48EcdCYOWyr+3o2VJ4/IQT+/HxtVZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zX7ophvBLomFdvPAefgHHiXeUT4FJTJs5qhmDBAcng=;
 b=g6deX1W6BhGJMjYLLDucPgiC5TlaD6UyiDMEJI7IhRaWEMHTyjgehOUaqg6w7km+fCUXKn0K1098WUqCbltg+kVRPDuDDwCyDumTrKJWTny/TIC8Tg5OONo6FVPfUnOSL6b2zwEEzjyKQUJb6W0DqqENZjky4F+MmXn4+BrqYBHdQuteQta/NUEBEJvYvWgp3VecQ8bHaYYpCSHKpy795NQdleFHgNzlhul6uJZHZXyeSJ9raWVXFnnpy9npxJ1G8M5h2wJpcizX8qGAKr22tu8t2063xMpwqK9/y67a0k/PMPKoBb3nKTHNoV8YHZIy0RrQcek0bvQ1ZcBnuJGXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zX7ophvBLomFdvPAefgHHiXeUT4FJTJs5qhmDBAcng=;
 b=pje4/PigBfrGqEHZjnquhW1jcj94XszoHpgdDGiK4LIFWMcrHWk2BsB5AOROjmjANhT4cuEhLpVQ/PDFwFRIRmoRFDxDC6yhKVImWkY7nfkL3KGfY9xGDSkpy6FOp4laeqKAFEneOiTCfHpqL0GQtgD23KQBD3LVemlye5dVpNs=
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 05:25:30 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::79) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Thu, 4 Jan 2024 05:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 05:25:30 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 23:25:28 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Drop unnecessary sentences about CE and deferred
 error.
Date: Thu, 4 Jan 2024 13:25:09 +0800
Message-ID: <20240104052509.3771116-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ff55c3-84c1-4e85-3ee5-08dc0ce5911f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aahorITSfLWuDbvZaHazC2FjT/ZFAtaAcoL0KJccjFoLbhZP6a3NM5o3kukxp6hLDU/FGdM/AYLbVFIaWLV1hPn/93IPgrS/vH1sCAwzNhDpXnCZxVY5UU84ayhKdKIvRjZzRGZ1LaecAu27+MhJGm+/2DNr9bSAT5jyPoZOtpX8M18qqsdDu9tNXsaxAUJ+pJ53kcdGlFZ6o2INxVCHe1YV6WNkU0Fia8FNjwKAHjOMaxd89dYGh0Zib4Naf+Ut/DjoOgu6wRrBuS5XI4D7ozlrIyBSCB3UCXA0BweQoch9ivyJZ6a5ZOEMXMAhpxGbxgOr2RFsp1rP4T9HMZ+4qB2nFv85fX858vDDNUefNilU7aShyMZqgyphcDgqhytDHvJaBQK1VwMBk5vXof6mwfHpf8oeKv1pMi/fojKlX0CAmbsdalOi1dIqxOeeAKcqdECClVQV4nmSQWASECFvzrRmVFKsqtOyNU7xM8WJ6nxNQxy3biF57sehosnBnmIdOrcVbhsUBQq3tWKmhzaBvdCxzEyJ6COujDWmB/sfveOteNrVn07Kjm4urOldRV93PquY7Mw2oF/IFQVAW8GIWO4utQqGSdLaHThZZNWOXA6BDMPV68sEQGVFgQs5q7Rnxs+aSQTCKep46bJU8Zidbph778hV1EWp8tDtSjsCUvmakHRwGg5n++C+wDTYNAGStTuXEY/nYzE79u5wdWsp5/MYlFBrm+YeCEkCRVzvgU0UycdKg++TpvF8qRXVdiHTQ/2pEW6k1XWOpYgM9gY79Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(26005)(336012)(83380400001)(426003)(2616005)(6916009)(47076005)(8936002)(41300700001)(44832011)(4326008)(8676002)(6666004)(478600001)(5660300002)(316002)(36860700001)(2906002)(7696005)(70586007)(16526019)(70206006)(82740400003)(356005)(36756003)(81166007)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:25:30.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ff55c3-84c1-4e85-3ee5-08dc0ce5911f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove "no user action is needed" for correctable and deferred error
to avoid confusion.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++---------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  |  3 +--
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |  2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b21eadd7c975df..caf00df669bf7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1069,8 +1069,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 			mcm_info = &err_info->mcm_info;
 			if (err_info->ce_count) {
 				dev_info(adev->dev, "socket: %d, die: %d, "
-					 "%lld new correctable hardware errors detected in %s block, "
-					 "no user action is needed\n",
+					 "%lld new correctable hardware errors detected in %s block\n",
 					 mcm_info->socket_id,
 					 mcm_info->die_id,
 					 err_info->ce_count,
@@ -1082,8 +1081,7 @@ static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
 			err_info = &err_node->err_info;
 			mcm_info = &err_info->mcm_info;
 			dev_info(adev->dev, "socket: %d, die: %d, "
-				 "%lld correctable hardware errors detected in total in %s block, "
-				 "no user action is needed\n",
+				 "%lld correctable hardware errors detected in total in %s block\n",
 				 mcm_info->socket_id, mcm_info->die_id, err_info->ce_count, blk_name);
 		}
 		break;
@@ -1139,16 +1137,14 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
 			   adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
 				 "%ld correctable hardware errors "
-				 "detected in %s block, no user "
-				 "action is needed.\n",
+				 "detected in %s block\n",
 				 adev->smuio.funcs->get_socket_id(adev),
 				 adev->smuio.funcs->get_die_id(adev),
 				 ras_mgr->err_data.ce_count,
 				 blk_name);
 		} else {
 			dev_info(adev->dev, "%ld correctable hardware errors "
-				 "detected in %s block, no user "
-				 "action is needed.\n",
+				 "detected in %s block\n",
 				 ras_mgr->err_data.ce_count,
 				 blk_name);
 		}
@@ -1978,7 +1974,7 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 				struct amdgpu_iv_entry *entry)
 {
 	dev_info(obj->adev->dev,
-		"Poison is created, no user action is needed.\n");
+		"Poison is created\n");
 }
 
 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 6d24c84924cb5d..19986ff6a48d7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -401,8 +401,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 			if (err_data.ce_count)
 				dev_info(adev->dev, "%ld correctable hardware "
-						"errors detected in %s block, "
-						"no user action is needed.\n",
+						"errors detected in %s block\n",
 						obj->err_data.ce_count,
 						get_ras_block_str(adev->nbio.ras_if));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 25a3da83e0fb97..e90f3378080345 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -597,8 +597,7 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 
 			if (err_data.ce_count)
 				dev_info(adev->dev, "%ld correctable hardware "
-						"errors detected in %s block, "
-						"no user action is needed.\n",
+						"errors detected in %s block\n",
 						obj->err_data.ce_count,
 						get_ras_block_str(adev->nbio.ras_if));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 530549314ce46c..a3ee3c4c650feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -64,7 +64,7 @@ static void umc_v6_7_query_error_status_helper(struct amdgpu_device *adev,
 	uint64_t reg_value;
 
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
-		dev_info(adev->dev, "Deferred error, no user action is needed.\n");
+		dev_info(adev->dev, "Deferred error\n");
 
 	if (mc_umc_status)
 		dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
-- 
2.25.1

