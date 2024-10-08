Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CCDCF0435
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B171910E5DF;
	Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VERVQq06";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B91610E5DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK/9c0nyRvAHOK/CWXW0F27MiKilvhmzR+F8Oqe0UaXVeS5LxHR9K8cBzWD87Ud+wj4RnHq5STu1q9bZ3iIkb5tWrViFUwajgLAaMADuaKtw1NBzSMgMG5b6Pa7p3bliY/jeCBe268ec+2BRxk7J2G20R3QgjkbhhSKjQhuU+bAGqwsAIQG4MonNMwGxXXSItE25zUk24HDV6q6O7PoWLKiVJxTOgHV2JXuQkHzpMuCZg8o92emh3DjrPAUL4a9M1+HLWAPtbnLijyStZ3WqfvKZhdx/spwCmLpDabrkiW2dLJeGiqRFAxArifa6SfV13Ms7xAhr4z7HlzIDUCDWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOJjsrfy4akpTBFSfy1W+jQjQTEB9rXzw4WkUIT4Hh0=;
 b=SqGPo8y7cQqs/10yvAJ+HEGnG8oSWNGiTOewNxhm9ngnkzW0KgpYIgpEOERKZmMzkCbEMwLR12r3mO/7OoBABGk19cARwXoFhFMiYcFXIHDcp6LbhDFZi1xXAomHoza4uoQVIpmeXa5GNFXgHfFHeBamN/4uVvI3XhpNsYa7Wr+bY6G/V+gEhcx2PftqfwmPAf+X96URxcrQcy+0EVODqkiKbmZCLBNW7kP/12yboGxGaOwJOWkaLLJFNIJk1rAbSwJMYQxjGptlbB45bath+sJO7modmufV/1ySdgZSYeHV2m7OCvsk6sO3fzYxDj3UVIbq3NddDHQbzDbenRBMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOJjsrfy4akpTBFSfy1W+jQjQTEB9rXzw4WkUIT4Hh0=;
 b=VERVQq06TijCnCG16TDhoZPIPGSANoPdbqLMcAQ5azlfRospnsccW/jdjao9zs5YwdQ6Lv/x+dk8IxZ+Eosp549hF5fXBNAAQjkiuDWAK1ToukmrLypTyEUrX+Jr1tadrharxxrWuyJibfQe/IEBMtzQ3aWpOmpgwc8+uzoAwAg=
Received: from CH0PR03CA0400.namprd03.prod.outlook.com (2603:10b6:610:11b::20)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 21:16:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::b0) by CH0PR03CA0400.outlook.office365.com
 (2603:10b6:610:11b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:32 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:28 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 26/32] drm/amdgpu: setup_ucode for each vcn instance
Date: Tue, 8 Oct 2024 17:15:47 -0400
Message-ID: <20241008211553.36264-27-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: a52f10fc-3787-4338-8d66-08dce7de7c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vq5LWiGtuj/mgx5+lkICXdX9NBd4CX6cZaU6DG3U2gHDV8ELSFB99HvLJkM/?=
 =?us-ascii?Q?AH3VbhKEJ3YA9VV2w58VzdWBGTyy/6QWU/s46XDjflqxyXqM7NKFm/rWMjFQ?=
 =?us-ascii?Q?SLBfRwhI3wBMYQD9CQbj2Ic+GeJrlDuCaY00oVMRO6cZZXJfm4chQ995BNuD?=
 =?us-ascii?Q?xIHVE2ZOvqA7MJCmE2IK15xdAC/1qrziBL8FtVKnsdIGMi9ff8clre3Z1WOo?=
 =?us-ascii?Q?fOcXvGCSQDhK2Aq4OSXhY3ZXVlXlsg+cEeXTFokChCEAeyp5TE9EcRVIVB/j?=
 =?us-ascii?Q?j37nYvIlCoYlhdvrFVvJE6wZh244QGAd+FPxBM/Owid83vurhrKhIpIppZam?=
 =?us-ascii?Q?HIeobWX3ryNRasB3Yegq/DsaW7EHajHB/B10AiYxDMRS05W5dY7R6LCfb+v+?=
 =?us-ascii?Q?48lkAczR0YuIn9Z/U+QMfhXanveAFCrODXcr+qbk/xIghW0VlREjZQKgyCm2?=
 =?us-ascii?Q?BXCVC71GijradfcOTStNqsIDMo1S5+m2u2XhlblrNJZA5mgriwm/WbKt3MpO?=
 =?us-ascii?Q?0jaR5Z8FXhI68c9Jjv+K9yQlFE5AtqlNB+RIf7V3Otjvz31EM/PwVEetxq1J?=
 =?us-ascii?Q?cwhPR/p9BxBeoRN+XEV81nJZHSi3V0xLRnYgg2CKx7l4gcIwOhb/In66CLD4?=
 =?us-ascii?Q?5LLHIgLJizM5yzmTaj8YWe9UUN3BVrus7z/9g144BSJd0ucwvnCT665anJKB?=
 =?us-ascii?Q?9U2acVqCbZaztCUCCdRkNR11TU7TdT31aTeKBe3HS/4BmAB6sJ+FU2f8NU8k?=
 =?us-ascii?Q?JCPUOeEzE1CBVGojYf9SpvJNge785X1ty5Edi4vCEfsLZcF5kshRssu+9/dm?=
 =?us-ascii?Q?Ki2hprg3Re3Z/4M9cVJtyj6vRk6ZLOd1olzVEM+V+NGV8mFqEHQl2AsqcYzT?=
 =?us-ascii?Q?B4xTdOUfRQjG8BjspOK4p0A7WtkaqHjzNN4qIpj33l2Ol6Xpgor8xppQNiMu?=
 =?us-ascii?Q?TFnQRA5XWGIWtmrGhJ/guaFj+xwTGLut/BPVPMFdWDb/QfqYgwrN1AjlkmsT?=
 =?us-ascii?Q?dtAmkvNcNUWDeh17Zkspq19PTEWdjxOrIKiZJGkmOL/HQeZ1JWDUptiuCv9k?=
 =?us-ascii?Q?n3SmIXGuUtU+uBuCszq0hU9CQnlUO9iiMuZka4cg/5g8a3jFabvIg9T1pHe7?=
 =?us-ascii?Q?ueyxKmWA8uOWrgf1KdXmnUEbKsbbNaIxEkGaPyY/jf7VuF9dRG95WKuxWqP3?=
 =?us-ascii?Q?Wyoia5VD7aJFpKsCMRHcWP6I2ZRyDi9KH+9Lxse211K7XQbyahCnmxkfGhDQ?=
 =?us-ascii?Q?4Ecj6fsQXDEOPEqx+mSWQnvlqkb8QzVdOP7ZfmhjhjXuM92NnNKI74m5m6q8?=
 =?us-ascii?Q?N+fAqkcZQyDWFmtDDDMpI4p6TotwjpS9c/BikW9wrumOITnRj+Sdlv+4PO0J?=
 =?us-ascii?Q?N1Ds7NE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:32.9051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f10fc-3787-4338-8d66-08dce7de7c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_setup_ucode(), and perform
setup ucode ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  2 +-
 10 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 67081fb4e96d..e442430e7e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1044,34 +1044,31 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 	}
 }
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst)
 {
-	int i;
 	unsigned int idx;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			/* currently only support 2 FW instances */
-			if (i >= 2) {
-				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
-				break;
-			}
-			idx = AMDGPU_UCODE_ID_VCN + i;
-			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			    IP_VERSION(4, 0, 3))
-				break;
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		/* currently only support 2 FW instances */
+		if (inst >= 2) {
+			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+			return;
 		}
+		idx = AMDGPU_UCODE_ID_VCN + inst;
+		adev->firmware.ucode[idx].ucode_id = idx;
+		adev->firmware.ucode[idx].fw = adev->vcn.inst[inst].fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			IP_VERSION(4, 0, 3))
+			return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 72341b7027a2..88f46a7d02de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -505,7 +505,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
-void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int inst);
 
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 11153ca0c3d9..ab06c4173b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -154,7 +154,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Override the work func */
 	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d36ab4368a25..59c6458c99af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,7 +159,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 963086b47b1d..d90aa2a9f94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -189,7 +189,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 098a523073b8..3547798ec335 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -172,7 +172,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index bdc3f37fe44a..eec9d4a0a0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -180,7 +180,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c44adeb4494c..f78c006aec27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -137,7 +137,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index dd392b787790..31f05f377ffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -142,7 +142,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9fdb91fa86c..c0746684eea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -126,7 +126,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	amdgpu_vcn_setup_ucode(adev);
+	amdgpu_vcn_setup_ucode(adev, inst);
 
 	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
-- 
2.34.1

