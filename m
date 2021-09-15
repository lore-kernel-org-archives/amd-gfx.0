Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A82DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D12560698
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D12560698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C075B6EA18;
	Wed, 15 Sep 2021 20:12:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167F26EA18
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 20:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvpZcaBaJPl/rFHCds7hyd57BKEzxKCEPhlKVD3uKkps14M6dflUx4MCl44S++BhC2ecA6XBoTJVPhxWD8BYKTDqTp+yBCsdUBUV86ra5QDQYPMyFY54f+27uDDwkNntA231lFT/6M0xNMEYvli5lGtIR8w1Yj6HTj8j2mQEY1ybKYJ59zfL1Lh+iKM4RkeRJ32qLiCp5WibvEgzTyYSWtkCBfnTziHK4zDr9xpBi7ebUlbILb/5FBXAG7iAd1DXNtkZyG02pCXYzJS6OMJWZq0hmkbdFRnE8dCf8LXoe7nz6hFMbhlN9U8viuQmsiHAgKuwEbGq7b17tl2pWglEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EYjD7mlqyMEnZWGf9beb+IERGU855mbyB7xLRgFRMuY=;
 b=bI2zVFN6oqmPJzUAgsIZagAs0emHieCB1ciGuJmLlWx0pJnNxyid0rh5ew+Nb0XnO0y0jFUiA6G3kShQr4Zh4DXqUn2da4RWFQCpiryf3H7CjSr+TSVv1uLhjywR4Sz1ptv+p11931YmLXype8ReYK+B7wsTUQDv2d2rtPmZZF7H0k7e7NIgR/hSoV4AsdfOYQy+2WmfcvarJu4vbqwLp6MOOnF2xA3AkV3+Qff8Tq/0vs1FLXIjrI12ZXoJDABoT+AHZf25ZyWkFhgyhnQBMY1fvrkTjC7I13tcciG6S/3PbKLQVmZxTWukXBjLR3DeM6f7ftxwUqcSvIT06+LzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYjD7mlqyMEnZWGf9beb+IERGU855mbyB7xLRgFRMuY=;
 b=UqzGzg1WAlUrEYrO9Etk1VxuiQaJJcE1dUMlDb2WLZn0P0eYgq9/d6X8tBgzCYFDWHwb8qmrHmcCbrEja3kBqnh/86Fq/tCV3OocNNpUtKt+J8yQiLTpj19HHANS3+CGtri0l0jF4EUsfp60rjDRQRxvR8n6QiqNHBY/AbmERAQ=
Received: from BN6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:404:8e::23)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 20:12:17 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::34) by BN6PR21CA0013.outlook.office365.com
 (2603:10b6:404:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.0 via Frontend
 Transport; Wed, 15 Sep 2021 20:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 20:12:17 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 15:12:15 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <nicholas.kazlauskas@amd.com>,
 <alexander.deucher@amd.com>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH] drm/amd/display: Fix crash on device remove/driver unload
Date: Wed, 15 Sep 2021 16:11:50 -0400
Message-ID: <20210915201150.476919-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c185c075-4e35-4d0d-5b10-08d978851d9a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:
X-Microsoft-Antispam-PRVS: <SA0PR12MB43675D00ADDC1D5F1A368A9FEADB9@SA0PR12MB4367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQdgCYLY6IPbAW3uPCUeIrQLxOiI8EpPVKX0RfV9bKIoBCKNFxU0OWWO0bYunQySPTZMUMiOIEziUqk4n30tIZclx7raG05cELg+GzhQwGDQomW7DfwRcXvXxq5ZBq/xOFaTFLBXRmNWdfX3ieyg82AZXU7D4CjxZ6u/yZCS1CZ9ilSN+4RZvcdlvs6US6sA170U4FYlSXSx1ZPWBMxCUqs8LibHO8+rVSDQbem7MV6gHiw5I6NZS1RZY70ppOCabdrXkZxKqBrnleQzHmXAPBV4xymyDi/6QjQaFM/lqs5LYeeKZihIr4gMbm1+ZUTc3f55Mgt1Kk+o5CYg3UdeKaPKtfglfln48iP5xh4tA4wORBB4THqef2LIKR5JsQnVPva59ciftRNfpsasJqHap4bQc8hdO7deTB4DOBMMaHgfejrJbAin8bSiCmKRNpjh4yxgWPBRarebEos7b+jQkhbc3rnkXm8yDMaV4Kh8UNacAtDksRz/5oJIeNh01pJ6UH04eo+4IrBFE7AK7w9P0/kMTlYRcMwdyob4UT3yA+oLomfLMWTGIGPe9ipmOjRKMjbHFBAjEwllI+H+6dvwqruXNWYQnO8LcT9/NGjPufU17WxeAxH+/XxEYVL+CPbbLwSk+ycDjV3GnOCy1dnfgU04ag0acjffaCi0SG6HLbDD3OT8AOxBpsqL53T/zECHBNJjrfkLlVIByOa/t0urn7M0zbWHIvv+s4Xs+3sf7RY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(26005)(86362001)(16526019)(47076005)(6666004)(44832011)(186003)(6916009)(7696005)(36756003)(5660300002)(2906002)(70586007)(81166007)(82310400003)(83380400001)(478600001)(356005)(82740400003)(426003)(70206006)(336012)(36860700001)(316002)(8936002)(1076003)(8676002)(4326008)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 20:12:17.1844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c185c075-4e35-4d0d-5b10-08d978851d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why:
DC core is being released from DM before it's referenced
from hpd_rx wq destruction code.

How: Move hpd_rx destruction before DC core destruction.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d3679bd6b29..1c0547bb09de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1572,6 +1572,18 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 				      &adev->dm.dmub_bo_gpu_addr,
 				      &adev->dm.dmub_bo_cpu_addr);
 
+	if (adev->dm.hpd_rx_offload_wq) {
+		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+			if (adev->dm.hpd_rx_offload_wq[i].wq) {
+				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
+				adev->dm.hpd_rx_offload_wq[i].wq = NULL;
+			}
+		}
+
+		kfree(adev->dm.hpd_rx_offload_wq);
+		adev->dm.hpd_rx_offload_wq = NULL;
+	}
+
 	/* DC Destroy TODO: Replace destroy DAL */
 	if (adev->dm.dc)
 		dc_destroy(&adev->dm.dc);
@@ -1590,18 +1602,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.freesync_module = NULL;
 	}
 
-	if (adev->dm.hpd_rx_offload_wq) {
-		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
-			if (adev->dm.hpd_rx_offload_wq[i].wq) {
-				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
-				adev->dm.hpd_rx_offload_wq[i].wq = NULL;
-			}
-		}
-
-		kfree(adev->dm.hpd_rx_offload_wq);
-		adev->dm.hpd_rx_offload_wq = NULL;
-	}
-
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 
-- 
2.25.1

