Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A58C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9536160F9D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9536160F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7BA6EC25;
	Tue, 19 Oct 2021 15:57:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4086EC31
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfv+mjyhkuMGlVaUvCiPp20eLYilNChdZJ4oeM+mDKM+jkYjEGX7GTr4dShBM3UVvGvSfuRBP9srDsVatBafOrot/9kYRUq4B19Y7kYwycLlXwCKiZ7cQfhi82r8b+c2rZXiGNPN9wF+hIuinEENrIWBTFKrZnjb2mmBnyfB8FAyI/NKSvNkR5buuw0PP47BFOrPOJmHLSCfzm8he+rtXT/+1x8DzSeqFa6f+ClX2zE20hb2urJtGdo3e/yFTWkiKn1BsSV2Ewx5x1Jah/ctvpb4cwQztb2AokRRlT2J3JkH3wyITZsMbmMMOVGnf6bD42KluDzV61uRK33kk0OZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EC2r7c5lhPQopInwZyzANvx4dWgn1KKVbdSfZ+gXv8=;
 b=fFOUKBIOO2L3RZwZX8Ne1aw1OBm824NN/RFxicSs45A0OSPLC9CsHlPrnD4yEncSTaO350t50hDo4SGBFi3Z9WFIjtyVC/dwzTe50GvyjHiiZSk7Ym2C3x90pFgNCKUdBHg18CHtNcrgxqdq/mgD0H4pIpV4n+UJJjD82avtfJPm6Zf39oCmLISbSz81MkhxLzjUR7Dgl8nqfehnqnWZAs05HYnhJKKnDMTOkvg84KqGwT29Oekxa9z74iSKpaDAIMdXiitsk3eMG09aNZR6MhRJeBUBBovlqvCGn4hcoVfKtOaG+csP37PfEKvjZC7tpEmQF+75Vv3PQldd/7bfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EC2r7c5lhPQopInwZyzANvx4dWgn1KKVbdSfZ+gXv8=;
 b=OKRd2gMj2Pu41dxCnoqjW67CnBT9QB8op1W5qwoyO3DrnLyeYgdOIxY3l7XFOJ295kT8e9RumdqxuyYK+kWsZuMAs4RuxkG+HtLxbcHJk+SNiwvsnWswhNarjFleCt6nzbRK1DC3IzQ2MlqeUljOlv7iX6Vf1jsWu+H0V7tZkF4=
Received: from MWHPR18CA0047.namprd18.prod.outlook.com (2603:10b6:320:31::33)
 by CY4PR1201MB0165.namprd12.prod.outlook.com (2603:10b6:910:1c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 15:57:05 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::31) by MWHPR18CA0047.outlook.office365.com
 (2603:10b6:320:31::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 15:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:57:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 10:57:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Consolidate VCN firmware setup code
Date: Tue, 19 Oct 2021 11:56:44 -0400
Message-ID: <20211019155644.338589-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9295a5d-90c1-4852-aab3-08d9931918f1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0165:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01653A8B5EBED66A5480EEC0F7BD9@CY4PR1201MB0165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRBV8EXUeil5PTd0MIyWZURAMV4L984T9KRKiAGVtuhFeGJk8wrHuWvZeAE5rSQk1YaDAnC/xh4Rlq5P9JvB/71+9gNuKrTMPYPYRRm1TBOz3JbxOs/X1IzoXwDJH2TvvdB4kMWrWYwMbCEKxLRb3mmakJHVGPwchuGOuKK8HN2CbpbLQQ5C4B+6kphYyMPMmh7Df4O/9ZDaLcJHxjOgHagSUBd/qI25fgeStYHNJMKTWYHS58gwKXDDUpwrEgVKF197v8Fao+KO9QUzny+qV0t+nzKovVEqj7BryHn1j8ShRevh7wOeI0EeS1T+Lo4NQG1crb5p6f1NP7ofH+bdl9GPyuUapczgSVdSHZefkerWuVLo6Ddt7C/ceUQWT0Kt3eEeXKE0RRY6hI6EgK4JXZEPZgD5OK6vivi32b2K4thFkYvmtScqWYMRt/lKo/wl8GG521hEUxgHoPXO0vBr2ER65oKfdhxFn4hxXzbz6rDsBCuVniPSmhySzsGGouClB43f7tu6j2LfP5aNoLtaOWI2wvBz9sQtC6eYx7Rgw6tNQ32H9wi0O5bSwmz/9ldn32rhNKArJnhIPLulyg3tVQ96BOuKh9yktiRgbUHz0R90EkqChR0vpQcpxHiUudFgh4z2cLfi+jR+/aAx/9Lx/2F7Cloe0Js4FMJ6iQLlIE/QfjWYx+l47inOIuTiIHJnuiAVmc0A54aoTDMMcgfu2i4uhMBfGK1EvRXYsxRq2f0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(82310400003)(70206006)(1076003)(336012)(47076005)(2616005)(83380400001)(2906002)(7696005)(70586007)(86362001)(426003)(4326008)(16526019)(5660300002)(316002)(356005)(26005)(8936002)(8676002)(36756003)(508600001)(81166007)(36860700001)(6916009)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:57:05.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9295a5d-90c1-4852-aab3-08d9931918f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0165
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

Roughly the same code was present in all VCN versions.
Consolidate it into a single function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 10 +---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 +---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +-------------------
 6 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c7d316850570..dc823349f870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -949,3 +949,28 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 		return AMDGPU_RING_PRIO_0;
 	}
 }
+
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+{
+	int i;
+	unsigned int idx;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		const struct common_firmware_header *hdr;
+		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			if (i == 0)
+				idx = AMDGPU_UCODE_ID_VCN;
+			else
+				idx = AMDGPU_UCODE_ID_VCN1;
+			adev->firmware.ucode[idx].ucode_id = idx;
+			adev->firmware.ucode[idx].fw = adev->vcn.fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+		}
+		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 795cbaa02ff8..bfa27ea94804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -310,4 +310,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index ad0d2564087c..d54d720b3cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -111,15 +111,7 @@ static int vcn_v1_0_sw_init(void *handle)
 	/* Override the work func */
 	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 091d8c0f6801..3883df5b31ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -115,15 +115,7 @@ static int vcn_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 59f469bab005..44fc4c218433 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -139,22 +139,7 @@ static int vcn_v2_5_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-		if (adev->vcn.num_vcn_inst == VCN25_MAX_HW_INSTANCES_ARCTURUS) {
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		}
-		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e311303a5e01..57b62fb04750 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,7 +123,6 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
-	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -131,24 +130,7 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			if (i == 0)
-				idx = AMDGPU_UCODE_ID_VCN;
-			else
-				idx = AMDGPU_UCODE_ID_VCN1;
-			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.fw;
-			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		}
-		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
-- 
2.31.1

