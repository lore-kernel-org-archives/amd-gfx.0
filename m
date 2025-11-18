Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011EFCF2564
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597EF10E53A;
	Tue, 18 Nov 2025 22:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="euO6G4ak";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8C210E53A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMj4hzj2eQ654TZXqGaFPNZ45pxZAB99bmeG9PNXInaTdYR1UyI68kmHe1iZKegLEEnCZdEPP07o4K0yqyLfUzT8Q2ZA1sMWi2T2kQdSCmzScTCWVRguWSTeWHehR+3FSYp3+2gyEk4NYxIYSSGOPeJBXyIBClih1UB1HSikUhGxfpTHH/oToBq1GQYqm3HUVy2zNWziegCl6qQNm8WZ5I3OhGw3EBNWVjFecSds7fjs27/+RaAW8rtDZXGIaCmeu/dInk8U1GN1zYDcyDvoXDWZRBQrNL9eV0W/D3YXcqzg0kvWjQn9OrqrINwmBbQoiVX3igvT+QTJHJPJng1xBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIVmiiX6ybHr07ggByh8FminhrulSf7PsMMSkzYAkJ0=;
 b=lUPAgO1iv6nN5A2iZ4merCxTKMEAiRZ+b+wvEXGdMTWYJRdiKExFOriob3DeJgaZshBnHIogFP0/TX/OE/cNcJOp+IPgr32Cw60o5p5xiJ4NBrgWXdzSS4VPrMUYUh4olYjyDtaBF+T7qlvHsCFXVuLhiJIlsZlzxMh8f5yNXKW1D1VGROap8rVfOMLbA51B6xy4Enb4BWdTw29d4eco+QfJihIkcEaWvQudSiE/wYLPy3By2EI0IUESBtsOmpXRc541pjbYNsxyZskex6LBEP4oO6NmSGW5/FLGZXRXaIHEzacCVhfoU1dvYW462THkxRypMsauRiMijSj0dj33EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIVmiiX6ybHr07ggByh8FminhrulSf7PsMMSkzYAkJ0=;
 b=euO6G4ak4N2HD2owWrMm1CYXnAoHTPDxZhnlcNUT23aq6QAd7feFpe9SOk+adpKJllVx1HMb2n501NzzAnbYPLovqLa+VyT2bNbs+AnkeGUcaDBP9WdlhqTYSPmk+kOXCHF75EOzAnIj8duHVmPsj5AOQoX7Da0Q4qwF7JQ5BOc=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 22:54:57 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::f4) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:54:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:54:55 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Add rlcv firmware for frontdoor loading.
Date: Tue, 18 Nov 2025 17:54:39 -0500
Message-ID: <20251118225440.3613071-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225440.3613071-1-alexander.deucher@amd.com>
References: <20251118225440.3613071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fb37a0-76d3-4aab-c807-08de26f57ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YKwU9bYyT3AGl/iwaxA0Xd/QnihMi5nPbonXmAAliUHWjm0rp43YJkJB9f18?=
 =?us-ascii?Q?9BorVOv2/eTh6OmsF1dcGc2jVf56tFV1MXqOkp/H8pQS4B/ER+uC1fkotUxz?=
 =?us-ascii?Q?WwmMlWozUMOhlNdgKK94FgWJncVeonyQY2Fb1J3lnQUqqt5VjmO2i2k0Vb2E?=
 =?us-ascii?Q?cNYTekhSIv4GM3WuDvdoKBZYRgF6BTKwqHlZJnZCoSzIhrRj/YBK31E77BsD?=
 =?us-ascii?Q?DCJvmIBxqYB+rqoU4NRTcIOSrWeZjYlAudgJ2Ge74zhQu0E0nvkHMupvlf7e?=
 =?us-ascii?Q?QX/ARNiuz8xEYdycd6TIX2qTfRWiV9FSKPz3l3wu97jWc2KckGWz58B3gWk8?=
 =?us-ascii?Q?ZfxiyYw4/Pupp1HER45hbI70lWV1hbavEUnZHH8plWANk0wbjyU/7fs+2jzJ?=
 =?us-ascii?Q?e8XG7964X4PY5e0F5NOy2twbHi+bfGiZfDKkxqYd5CCwY6r8SDZdssM7gLFs?=
 =?us-ascii?Q?w2XTuMIQ9hpxqE0UzFKzzsLQxWjkZwexMsH+06Ccz6uaJNCeQRT8KiMRq/Tc?=
 =?us-ascii?Q?3VZGeqM4vhsAT+QFSuj+Ei1PrE1NBLvP6wnS2dxWNo1m5MvZRJHnQAW3mmWW?=
 =?us-ascii?Q?f/JpvloB0TtDtkASP4INzw+lHINBV4gkQqXj3WGrvJLquonfFGkdAxZnNzBq?=
 =?us-ascii?Q?GvW8SXHvjYkdXzmPNInVLjwS6/vEQG/oxlztCASFMdgVFiMDcaNdi5vN1ikg?=
 =?us-ascii?Q?6FlWPZCmN8ki7pcX9SSDqerKxamnKRZD3Ow9Q6b9f17D+NJ15Qj+jAbJ5txA?=
 =?us-ascii?Q?4MeXo6qsZa2bK431wNBLm8u1ceOTPmTPGVVARATs+ioNR0tYXwY21FpOUCQf?=
 =?us-ascii?Q?Gxh6vfQCywTUFiDkbks67R74TotScsA8qMRn62PYSJ6Q5oWYoFJVFsYM/UT2?=
 =?us-ascii?Q?7aK4U6DHcHITiWprn82trUtcwcklovXnZM0WhjUjtsGjhtBmwXMD6/qwaD5Q?=
 =?us-ascii?Q?3NzdX98EBJpX01qwB60UDa2k8jTT3kfiu9ybu84ndec3sD5Q6CFb0AUnkRIu?=
 =?us-ascii?Q?4YH/Q135efTc6/blcPF+OpDu5ykonD4/uw0dIFelpC+QHfcIl8EBt2jMOdTV?=
 =?us-ascii?Q?F7si81BgKOlj/5FWuwmfoLGoA2F/eT4bxei1KvqIFxSccqO94C5ly5YVaFP4?=
 =?us-ascii?Q?LIfBC3eJ14YHT6Yp4yAoLG+Xa4CgZ1uh1+GgfECnJoVs/U+gdKh9xv1rA1Tv?=
 =?us-ascii?Q?3gCNOHESbIaRldIWIbFrS9V3DZ6svpgMgIBLwM44dvhwElhfmU2X4xqjmvZq?=
 =?us-ascii?Q?la+qJFXjgKAI6qxwxj1GJSjp+r59XiJzZ2xm90hONxLyF/HEyMTLAAQq/dAJ?=
 =?us-ascii?Q?15mqcsDxizOcs/q70fJhqwPuLgmlJZw2jclbPP3JqRjdqtxRYL2IVeWowhsj?=
 =?us-ascii?Q?jRL7w3qm0g3Y8O0lkjOl812gs0FCDmHJqshvuNAM02MQSuGtVv5tur8foUm+?=
 =?us-ascii?Q?BLlub5gUiAvGg6jLnpyNL+dDO1GjCLtHfz3mEUaSI4njUjQitKJD5zziaIRa?=
 =?us-ascii?Q?zevVd3zMX5Tbd5ofdtCX1fghoINVi1l2M0NKjr9DMeqa/aw2KY16PrBtryCh?=
 =?us-ascii?Q?7omQLfBYgY+uBH6aTyQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:54:56.9109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb37a0-76d3-4aab-c807-08de26f57ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

From: Feifei Xu <Feifei.Xu@amd.com>

Rlcv is required to be loaded for frontdoor.

1. Add 2 rlcv ucode ids:
    AMDGPU_UCODE_RLC_IRAM_1 and AMDGPU_UCODE_RLC_DRAM_1

2. Add rlc_firmware_header_v2_5 for above 2 rlcv headers.

3. Add 2 types in psp_fw_gfx_if interface interacting with asp:
    GFX_FW_TYPE_RLX6_UCODE_CORE1 - RLCV IRAM
    GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1 - RLCV DRAM BOOT

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c   | 37 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 34 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 12 ++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  2 ++
 6 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b0191635c8f21..0c32d27cf2b34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2719,6 +2719,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_RLC_DRAM:
 		*type = GFX_FW_TYPE_RLC_DRAM_BOOT;
 		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		*type = GFX_FW_TYPE_RLX6_UCODE_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		*type = GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1;
+		break;
 	case AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS:
 		*type = GFX_FW_TYPE_GLOBAL_TAP_DELAYS;
 		break;
@@ -2887,6 +2893,8 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 		amdgpu_ucode_print_gfx_hdr(hdr);
 		break;
 	case AMDGPU_UCODE_ID_RLC_G:
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
 		hdr = (struct common_firmware_header *)adev->gfx.rlc_fw->data;
 		amdgpu_ucode_print_rlc_hdr(hdr);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 5aa830a02d80b..572a60e1b3cbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -515,6 +515,40 @@ static void amdgpu_gfx_rlc_init_microcode_v2_4(struct amdgpu_device *adev)
 	}
 }
 
+static void amdgpu_gfx_rlc_init_microcode_v2_5(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_5 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_5 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlc.rlc_1_iram_ucode_size_bytes =
+		le32_to_cpu(rlc_hdr->rlc_1_iram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_1_iram_ucode = (u8 *)rlc_hdr +
+		le32_to_cpu(rlc_hdr->rlc_1_iram_ucode_offset_bytes);
+	adev->gfx.rlc.rlc_1_dram_ucode_size_bytes =
+		le32_to_cpu(rlc_hdr->rlc_1_dram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_1_dram_ucode = (u8 *)rlc_hdr +
+		le32_to_cpu(rlc_hdr->rlc_1_dram_ucode_offset_bytes);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.rlc_1_iram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM_1];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_IRAM_1;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.rlc_1_iram_ucode_size_bytes, PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.rlc_1_dram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM_1];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_DRAM_1;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.rlc_1_dram_ucode_size_bytes, PAGE_SIZE);
+		}
+	}
+}
+
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor)
@@ -545,6 +579,7 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 		amdgpu_gfx_rlc_init_microcode_v2_3(adev);
 	if (version_minor == 4)
 		amdgpu_gfx_rlc_init_microcode_v2_4(adev);
-
+	if (version_minor == 5)
+		amdgpu_gfx_rlc_init_microcode_v2_5(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 3e2d2e333907d..32408574548dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -311,6 +311,8 @@ struct amdgpu_rlc {
 	u32 save_restore_list_srm_size_bytes;
 	u32 rlc_iram_ucode_size_bytes;
 	u32 rlc_dram_ucode_size_bytes;
+	u32 rlc_1_iram_ucode_size_bytes;
+	u32 rlc_1_dram_ucode_size_bytes;
 	u32 rlcp_ucode_size_bytes;
 	u32 rlcv_ucode_size_bytes;
 	u32 global_tap_delays_ucode_size_bytes;
@@ -326,6 +328,8 @@ struct amdgpu_rlc {
 	u8 *save_restore_list_srm;
 	u8 *rlc_iram_ucode;
 	u8 *rlc_dram_ucode;
+	u8 *rlc_1_iram_ucode;
+	u8 *rlc_1_dram_ucode;
 	u8 *rlcp_ucode;
 	u8 *rlcv_ucode;
 	u8 *global_tap_delays_ucode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e96f24e9ad571..1ab61e7b35db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -166,6 +166,8 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 			container_of(rlc_hdr_v2_2, struct rlc_firmware_header_v2_3, v2_2);
 		const struct rlc_firmware_header_v2_4 *rlc_hdr_v2_4 =
 			container_of(rlc_hdr_v2_3, struct rlc_firmware_header_v2_4, v2_3);
+		const struct rlc_firmware_header_v2_5 *rlc_hdr_v2_5 =
+			container_of(rlc_hdr_v2_2, struct rlc_firmware_header_v2_5, v2_2);
 
 		switch (version_minor) {
 		case 0:
@@ -287,6 +289,26 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 			DRM_DEBUG("se3_tap_delays_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_offset_bytes));
 			break;
+		case 5:
+			/* rlc_hdr v2_5 */
+			DRM_INFO("rlc_iram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_size_bytes));
+			DRM_INFO("rlc_iram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_offset_bytes));
+			DRM_INFO("rlc_dram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_size_bytes));
+			DRM_INFO("rlc_dram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_offset_bytes));
+			/* rlc_hdr v2_5 */
+			DRM_INFO("rlc_1_iram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_size_bytes));
+			DRM_INFO("rlc_1_iram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_offset_bytes));
+			DRM_INFO("rlc_1_dram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_size_bytes));
+			DRM_INFO("rlc_1_dram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_offset_bytes));
+			break;
 		default:
 			DRM_ERROR("Unknown RLC v2 ucode: v2.%u\n", version_minor);
 			break;
@@ -631,6 +653,10 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RLC_IRAM";
 	case AMDGPU_UCODE_ID_RLC_DRAM:
 		return "RLC_DRAM";
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		return "RLC_IRAM_1";
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		return "RLC_DRAM_1";
 	case AMDGPU_UCODE_ID_RLC_G:
 		return "RLC_G";
 	case AMDGPU_UCODE_ID_RLC_P:
@@ -911,6 +937,14 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = adev->gfx.rlc.rlc_dram_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlc_dram_ucode;
 			break;
+		case AMDGPU_UCODE_ID_RLC_IRAM_1:
+			ucode->ucode_size = adev->gfx.rlc.rlc_1_iram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_1_iram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_RLC_DRAM_1:
+			ucode->ucode_size = adev->gfx.rlc.rlc_1_dram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_1_dram_ucode;
+			break;
 		case AMDGPU_UCODE_ID_RLC_P:
 			ucode->ucode_size = adev->gfx.rlc.rlcp_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlcp_ucode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 6349aad6da35b..f316776fe950a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -300,6 +300,15 @@ struct rlc_firmware_header_v2_4 {
     uint32_t se3_tap_delays_ucode_offset_bytes;
 };
 
+/* version_major=2, version_minor=5 */
+struct rlc_firmware_header_v2_5 {
+	struct rlc_firmware_header_v2_2 v2_2;
+	uint32_t rlc_1_iram_ucode_size_bytes;
+	uint32_t rlc_1_iram_ucode_offset_bytes;
+	uint32_t rlc_1_dram_ucode_size_bytes;
+	uint32_t rlc_1_dram_ucode_offset_bytes;
+};
+
 /* version_major=1, version_minor=0 */
 struct sdma_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -449,6 +458,7 @@ union amdgpu_firmware_header {
 	struct rlc_firmware_header_v2_2 rlc_v2_2;
 	struct rlc_firmware_header_v2_3 rlc_v2_3;
 	struct rlc_firmware_header_v2_4 rlc_v2_4;
+	struct rlc_firmware_header_v2_5 rlc_v2_5;
 	struct sdma_firmware_header_v1_0 sdma;
 	struct sdma_firmware_header_v1_1 sdma_v1_1;
 	struct sdma_firmware_header_v2_0 sdma_v2_0;
@@ -512,6 +522,8 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
 	AMDGPU_UCODE_ID_RLC_IRAM,
 	AMDGPU_UCODE_ID_RLC_DRAM,
+	AMDGPU_UCODE_ID_RLC_IRAM_1,
+	AMDGPU_UCODE_ID_RLC_DRAM_1,
 	AMDGPU_UCODE_ID_RLC_P,
 	AMDGPU_UCODE_ID_RLC_V,
 	AMDGPU_UCODE_ID_RLC_G,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 73f87131a7e9f..e8f768638fd59 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -299,6 +299,8 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_RS64_MEC_P1_STACK               = 95,   /* RS64 MEC stack P1        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P2_STACK               = 96,   /* RS64 MEC stack P2        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P3_STACK               = 97,   /* RS64 MEC stack P3        SOC21   */
+	GFX_FW_TYPE_RLX6_UCODE_CORE1                = 98,   /* RLCV_IRAM                MI      */
+	GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1            = 99,   /* RLCV DRAM BOOT           MI      */
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_VPE                             = 102,
-- 
2.51.1

