Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B89C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5F8611AE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E5F8611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750F16E8A8;
	Tue, 19 Oct 2021 20:11:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF2F6E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 20:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGPgloFDw9EE/N5e2tVn0l5m86ScZAcEENpzgPWfNQT6JwvW1AzVA7q+6UlHohkjVDIlnqx489eWuS8n3MgsG9uOi+BoG07EN77MT2QCY9FUajUnW4/zXKH2fpPcFAwyvVzvTwsL18X05FYaq693xq0ZIm97hLrFLJ2Z0kK8PpqOUkSc3b12jQTdZAydNEGoGu2h1nsMNZLqvGDnQAmEejjstoaI/2fsE3dRiBjoYWdkxuKEzbcZUvTr9kFyiu3jxlYoizKx8h9fKJBVQQH3X8qfEhGT5gJfxJTYM4kIicwYo2HiULo6VsewxWXDOzm43ZkrDiS0khiJ35A/sm8lDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4LkQMKzbAiJTqkfWEmoX0aGJWC4ROValH326KSFtPg=;
 b=f9AdDwLrEnqxdv5QUCrhrtL3+wXo1wdRgqMZGqtaDseIpDuPNi0t6hmMsGHJmjCjkgYntjku0+Y+rGrGqM5+U7soWQZgQ7jqVHCLntsay+nPp+7KsEqwUQ7EdUQHN735oSt3tm6LNI3GmMxF/tELnIOvghcBHqiQegzvM3sxkTdo1cBJOACyqIWeymRKaF0/gP6mhw3IYjboY3pMfOziM28D8f6743uIxjzzqMxwLBiNAJgF2QLJasqoKglUr8sQq/AeTA4OSOvUEjkbGVL9CVO18ljvuDjShZDQCyDreGOekkgWmbdz6CCr7x7Di8nQXrSH//eXsFTibSwStcH+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4LkQMKzbAiJTqkfWEmoX0aGJWC4ROValH326KSFtPg=;
 b=KJSamWM3BdT0L4oiaLn8OrHFVBWquCU+o1SGXgowleBuzhDMJlYNpLaT8o/o4zKYzXddfpRU/SI04w3CyMi1WYnjpaX6+JlWzUIaYspl4naBgCHl89qM1qmu74H5s03F/QnIE+zVdrPGih+v3qlqcDRWMGqdE33QXxsIzI0JuEY=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 20:11:00 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::55) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 20:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 20:10:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 15:10:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Consolidate VCN firmware setup code
Date: Tue, 19 Oct 2021 16:10:42 -0400
Message-ID: <20211019201044.426871-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019201044.426871-1-alexander.deucher@amd.com>
References: <20211019201044.426871-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 587b62ed-2d85-4cad-56c2-08d9933c9177
X-MS-TrafficTypeDiagnostic: BY5PR12MB5557:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5557E5C088D1ACEF3B5ACCFBF7BD9@BY5PR12MB5557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sk9hye8xFgxq1IiG/B4cGWHuxR18yn1lxeAhrX8vqomZY/p+RWYt86UOn07XibLnxyYirCQqJkCLkapVdMhM2Ia5rfgYQBJQGiSiADYBOMRWbur3fYzGY7Pb2t9mSuQZncMaQvACdDWtOB3JubEIK0PKqHq8AnBMxEuAy2VtHzu+NyB+QSEXlfl/5QllbSDlLTGujehyD0DEgg+RmwV3MjbLHsh5KfnLQ4iXCWYdupzL+X1nt5qBwPOKyxgLI1bA/8plS7bsmHk1kY+rMcdQKQGStBlkcPMCne3UUK1lRAdI+Vmvc+lHlRADiIJLU6dvK1aSaFAM6ELNxOFNNMCcN+XVC3Zc3l3M3WE1Mu3YBeZ5IX2YrLgMPezCVJZPlXxJ1m3dK8XSz2TBXBMp6VGoyGuXwJA7Ml3rMPgg4mKS9vwAdAT47y3WiVHCO3Vv58L5viWusTyE03QnSklinM6+raDfVJHBkb7tFvY5VxxTcbWOx/Ibf+r1FsVASUcu8YqQuuIt5KjA8g/1DtV+cF4G5ZZBuO2e/SYxy9vJ4Sd+rZUPz5IozILQ6p7CWdK2nokC6iI7KAv3wQc03+JS+50cIWGFl0gnZhwdxWptFE/SdtI/f/P9/wtYhd86JiiqSKPBSCDk9rkvDuStGOwpOY5spp49j+7XPfBKIHMaQOAVKhs5CjCJT2X6pfI44k8YlMred4OwVjTLlnaEBgtsrd7AU7ApI/BobaCKUf5efulong=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(4326008)(316002)(81166007)(54906003)(82310400003)(26005)(70586007)(83380400001)(6916009)(8676002)(86362001)(186003)(47076005)(16526019)(356005)(5660300002)(6666004)(8936002)(2616005)(336012)(508600001)(36860700001)(2906002)(70206006)(36756003)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:10:59.6994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587b62ed-2d85-4cad-56c2-08d9933c9177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5557
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

v2: use AMDGPU_UCODE_ID_VCN + i, check if num_inst >= 2

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 10 +--------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 +--------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 +---------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 17 +---------------
 6 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c7d316850570..2658414c503d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -949,3 +949,30 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
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
+			/* currently only support 2 FW instances */
+			if (i >= 2) {
+				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+				break;
+			}
+			idx = AMDGPU_UCODE_ID_VCN + i;
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
index 49752574a13c..57b62fb04750 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,7 +123,6 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
-	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -131,21 +130,7 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			idx = AMDGPU_UCODE_ID_VCN + i;
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

