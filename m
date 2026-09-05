Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE63AC79F8B
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F5C10E5DF;
	Sat,  5 Sep 2026 10:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZMzUJ3C9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C1310E5E1
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCm2dkJ7uB8fDR36NUMp4qFAFqp8n3B5QciMXF4wHXHRIkFnf7i2g54BLgjwGkQkyRoXemy8FenQsadUhiiztmAZ9g9ukhGeUA0EB1L0znvjF/uu9Itku6y1666s1Kuu59wie4GA++Kr8v44YONNAvTbhRJtLFzUyh89TKjGecfxCQn3ELhr3xvyfsgMeE3zzIpqpY4lW5h0DJmOJOBB4oiovirluR9Eq7Bbxq0DA4gTbpoKZGQmIVg/sZXD+CleevtFoTzRO4Jzjoqc8eWk3v80E40ALt2w1OUoEyu/aFjRRpE6Feg27uX8sz2BB0/mqd5ijB2WivVFA3CcK92D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNbpmhyziy5T8VwTEXh5h4DFk01rXH/rYsJp8Jy61xc=;
 b=qHUZTIwrqlShkK2bv+P/F6uizFBW6EESQ/a38Oxqv12zWLDaE8XQHTciNq9glzRHCHobb0c6srPcy2nlte3rVUHFwSImj+JCxhPgwgxfosZfQUCLEVvcxZj5y9/qklYNqIVacJ0SNg/GYZvqs9YLm5HzCoNuIkcin82oQ9XfJ/DbqQZiLMDvUpIEvdCyTBFxNHSmPlSXt90rnsYnXZWDaZIDHcq2GIqQoYBEYEo3lewL3cuQ6siE4Stqtv0uzZAH/a5yd+acpfv3/Hnnm+KE/nApkijKZmKiNZrYiUziqE2tqECMeAEqzaN8ivA8JGDGnXlPmOaOLxlDlP/1bFdaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNbpmhyziy5T8VwTEXh5h4DFk01rXH/rYsJp8Jy61xc=;
 b=ZMzUJ3C9qPjKoYzXV/Zsd0ccpDbXqyuruGboGTHllLHHClIiFatCFaKMmkubiMGCM6dhxf39BpCjknB0ePWnGysoZWSpQG4eDctmtjXsqnatnLNrwhajaubV9MTOVoOku7qR4g+qdxzrSLbSwZ41VZBgs8MJn9o9+WRY4mFM6C4=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by DS2PR12MB880722.namprd12.prod.outlook.com (2603:10b6:8:404::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:33 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::11) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:33 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:32 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 12/13] drm/amdgpu: Use common doorbell helpers in nbio v7_11_4
Date: Sat, 5 Sep 2026 18:05:37 +0800
Message-ID: <20260905100538.12877-13-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS2PR12MB880722:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d789be8-96ca-4bde-b113-08df0b355d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 02DaJ5qXJPn/W4nJnuoAeL+yFuGwHF2MmjQ69OoPxPScEcXcZG3Js5SgvrmNR2v11EgOZRxLxX2qQo7AiOSPIWIGj05AR2A1JvE8ECHmsp/PIe5bfWRhGXa9qOGP++Hi66Hu5p0uHZg/UDRVsKZKOdko7CU9lByR3SIbwr3RIZc9jP9V6Bb5TJLcGB8k5VkibAzo87ktb7A2gW8OIQ2Oy/g1x6ZhXe8nTTGbhWRUVr4xz3UPPJiIRujnQS8TG0QdmlhB/xqmdzbc319XBifOqT1nlTzxfMwsnGU1SND266nOfmaxvmtz9IJMldCdB/6DVYi+gZV8CIqz6acImy+riciHKrwlOgsUbzyv1epwLa1zoJX011d5Lnx/qeY4b/O7AgG7+Wb5uSCTR7aOgc3NNg8oab0DAtRv+PH+EHKMiAce+heitZc0jNFk7seLVi1Hnk+CPwz/LqydD8bMFlQ5+c0PRQ2opsKZQhrELtH0LawYi4/AZ9B24GL4rMVfGLBOmWlhm7t98bnnz+vxF6xtyzWpm9oz6WiYDEsMhQQy4xqw0XW0+afdanqJ3b2PEFXf/vd5j6MD4yC8nVWOSuwEU1FRpnINvle4VDSTH4RNSOUAbGTc4ETcoa/FwkyDzHZz3ORYytffHC9eLdVIeOyuDiKDUgCQ0dsLOdldw4Ms6/tEBq8hnR5QmEy5gDbFcoqHQM9m2YNA836RfrsCc7hAmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r3SlGH7IQVyKkd61qWYCiAIEvpnLFgbuNdcf6zaJ7VfX6YO2SqR5BoqdLcdY3GL6aiXLHDSFHRN6vzAXpMvY8hwUT79sLQxuymAYYxUjqF1e2WCngjBYqOqfnpvhVVunN/GUwk7of3BaK6JjKlpF1+ApgUz9yOpGNcp26mcYZAtRWTZGpBE3+zfIOmfwRiNvA2Mm6Gc4gf4+KPRPqwy/BcwCBs0FKv2S/4mJnTHe8hv03VPEXjGXmyYKYav48FKdIGDqEsoYi6y5uzy/fm+OGvFVoohP+euoLvLVTM50pD3XcgEzP/cfRDasvkfRiVYd1zcIcTFG0aOv+GnS8JxyBR0zG++6og08sXqJ91uwfpkF1/tU3av6INXxWlosCxyEbGAORV02YM4CIB07lShkPRJktalHUUIwEejBm4VlBqhdbc/DUGofOgHA2FK5LvnK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:33.6990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d789be8-96ca-4bde-b113-08df0b355d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB880722
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

Build and program doorbell entry control values through the common
NBIO helpers while preserving the existing nbio v7_11_4 client
routing and field values.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c | 307 +++++++++++++---------
 1 file changed, 184 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
index 8bae45c9ddfd..9e60613addc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
@@ -27,6 +27,89 @@
 #include "nbif/nbif_4_10_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static const struct amdgpu_nbio_doorbell_layout
+nbio_v7_11_4_doorbell_layout = {
+	.ctrl = {
+		.enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_ENABLE),
+		.awid = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWID),
+		.fence_enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_FENCE_ENABLE),
+		.range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_OFFSET),
+		.range_size = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_SIZE),
+		.disable_64bit = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS),
+		.deduct_range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET),
+		.drop = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_DROP_EN),
+		.awaddr_31_28 = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE),
+	},
+};
+
+static void nbio_v7_11_4_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbio_v7_11_4_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(
+		NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL);
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP];
+	entries->num_entries = 1;
+	entries->entry[0].port = 0;
+	entries->entry[0].ctrl_reg = ctrl_base;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+	entries->num_entries = 1;
+	entries->entry[0].port = 1;
+	entries->entry[0].ctrl_reg = ctrl_base + 2;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = 1;
+	entries->entry[0].port = 2;
+	entries->entry[0].ctrl_reg = ctrl_base + 4;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC];
+	entries->num_entries = 1;
+	entries->entry[0].port = 3;
+	entries->entry[0].ctrl_reg = ctrl_base + 6;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+	entries->num_entries = 1;
+	entries->entry[0].port = 4;
+	entries->entry[0].ctrl_reg = ctrl_base + 8;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE];
+	entries->num_entries = 1;
+	entries->entry[0].port = 5;
+	entries->entry[0].ctrl_reg = ctrl_base + 10;
+}
+
 static void nbio_v7_11_4_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -66,81 +149,62 @@ static void nbio_v7_11_4_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
-	if (instance == 0) {
-		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
-
-		if (use_doorbell) {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_ENABLE,
-						       0x1);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWID,
-						       0xe);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
-						       doorbell_index);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       doorbell_size);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-						       0x3);
-		} else {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       0);
-		}
-
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-			     doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xe,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	if (instance != 0)
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }
 
 static void nbio_v7_11_4_vcn_doorbell_range(struct amdgpu_device *adev,
 					   bool use_doorbell, int doorbell_index,
 					   int instance)
 {
-	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0x4,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+		.awaddr_31_28 = 0x4,
+	};
+	u32 ctrl;
 
 	if (instance)
 		return;
 
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWID,
-					       0x4);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       8);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
-					       0x4);
-	} else {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       0);
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VCN, 0,
+			NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-		     doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN, 0, &ctrl, NULL);
 }
 
 static void nbio_v7_11_4_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -148,46 +212,54 @@ static void nbio_v7_11_4_vpe_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xf,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0xf,
+	};
+	u32 ctrl;
+
 	if (instance)
 		return;
 
-	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
-
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWID,
-					       0xf);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       doorbell_size);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
-					       0xf);
-	} else {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       0);
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance,
+			NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance, &ctrl, NULL);
 }
 
 static void nbio_v7_11_4_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	fields.awid = 0x3;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, NULL);
+
+	fields.awid = 0x6;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC, 0, &ctrl, NULL);
 }
 
 static void nbio_v7_11_4_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -223,38 +295,25 @@ nbio_v7_11_4_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 static void nbio_v7_11_4_ih_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_ENABLE,
-						  0x1);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWID,
-						  0x0);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
-						  doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  2);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-						  0x0);
-	} else {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  0);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 2,
+	};
+	u32 ctrl;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-		     ih_doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }
 
 static void nbio_v7_11_4_ih_control(struct amdgpu_device *adev)
@@ -336,6 +395,8 @@ static void nbio_v7_11_4_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	nbio_v7_11_4_init_doorbell_entry_registers(adev);
+
 	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
 	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
-- 
2.17.1

