Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1524FE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411E710E9E2;
	Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAJ2D5zY";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0434A10E9D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7pbWmj+14YEJ5DOfpjD9tG+/C/G5yRtSodAHIOylKkzNYjkCFxo5GzyTml/11jhF+i4KDbj6FVmJBgclzw8D4U8Egf5ehpgANDM8gh9sg6y94vuSPULunOdBuzV0DdOuSxFJHbOzNSQexrcDDWgaOMFka62y7A52RMfrX1+DDFuE6CN1Jw8AesXa5I39Avmj/Y/vAPgnqG/ttMQUQgyeV8Hrz90Q2y4qsSIRkMF7ACQKRH0V6DEZQeI1TIoBpodOs7ZWZcZamZxzZnLG/eBh6q6A/+19BWmWtUASKBWYRz/6uEqDnAE8s3I4G4DQPo/Lyto5K6FLqN9h5OscbQJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX0Jjkr6gtPqTaVRxLOKmQolxTVW0BdfRDbZMQ/MjeA=;
 b=qkhI+BEjbjZvl6hMQL6i8xA6H7OmK5UE/1OG2eUh7bE2IR/5pjA1+GJaa6caSbUX/6bemJF5OwLYXhhqeuMmAPxtpViPnwko38dfiG/Ig1MW9fqIck6xlj5cUo9vDvqkhx8QypLRD5clcQE4Ys9O9VYR4CxRlg7dc6sHqXPhBsTn2Xt8kkPpFn79FBkO4swihbB3ZPD9//6mv9UbjG1lm4xhwLhb1UNCegYBJiEJqj0J/tSuAyPjPtxt/Ejs5neDJLgvbuBpbfABkPrCZXrQDHF+cqY57ufBr6+xMlYIFh7Hjhr1DYKDgbvzsru6jah9M6BbNYHzuuXjokylc0CdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX0Jjkr6gtPqTaVRxLOKmQolxTVW0BdfRDbZMQ/MjeA=;
 b=AAJ2D5zYUKdZ89+nJAavDNIGG/wwICZ9kaAianERhw2HE963DnHm5JWKSBfvNM2AEMbMlTkBnNceVG4pA7+csTPQ2auHOuIN4c6C8X21G2sV5gUmeLOgt8DTWy0MkEc1CgKLASXsCZeTg+OhhFVk9GZG4TtR9zfkZLcRKohZL7Y=
Received: from BN9PR03CA0228.namprd03.prod.outlook.com (2603:10b6:408:f8::23)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:01 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::8d) by BN9PR03CA0228.outlook.office365.com
 (2603:10b6:408:f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Tue,
 10 Dec 2024 22:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:53:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/48] drm/amdgpu/vcn: move more instanced data to vcn_instance
Date: Tue, 10 Dec 2024 17:52:59 -0500
Message-ID: <20241210225337.75394-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: a437b3c7-0b73-4c05-9ccc-08dd196d897a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QOs1jjsqqPzoeCb7NiydKahm8/ec9msAbEX6Z/P0xVHOSphjRpLDYhJjbMG6?=
 =?us-ascii?Q?gcvHSwrFBkBFTsWkI33dqjs7jAD6MaTX3KNdbP3+3QR4/uqAbgT0zptzP6+/?=
 =?us-ascii?Q?ZAE3/HyypMPKgApV7qt822U9Tra2V3oolxrvHsIFzKZKpwwDmcnjaNmYM48x?=
 =?us-ascii?Q?x3kugrUGWUbQvw/iA7xgn30tTKGBVljnp0KKscVCxHR6/42MfBVjhcJmhOJA?=
 =?us-ascii?Q?fD+NwnbPkuNBtbNrW4MN3fZjps1GcA6yfXnheOpY5e8eVf2ayaVTls+dsw/3?=
 =?us-ascii?Q?Z4kHy/7BVGw/sc5jxu+8WlguH+JHzmVSZZ7pNF1b6gHbXT8vPbYwViuHf7QG?=
 =?us-ascii?Q?Eo8Ze+y9QUxdiwIx0f9oI3OhuB51hg8axfLsP/CtRsIi4+K3nrSUsYVcbyW4?=
 =?us-ascii?Q?abEAz8LZweuwEjG4nDP9niIARg1x+TUSJ0EV8XzuXoaH115jNG0DzozwIS1Z?=
 =?us-ascii?Q?3uZWs4/KT0wXap13ajF4we6OBEdCWgbJlsURuEM0ft60VXrzxiJYvd3xsDuJ?=
 =?us-ascii?Q?994Z3+lIoMFXvAr6+T7VkhCSjE2/u29FxFvU6lJnDg1l5fGGFvzdnFQwsRMI?=
 =?us-ascii?Q?bX+Lst+blbL8KRPT4Swud/hznBU9h5o1PomFPoMnFztqB/Tco08jawGsaVFR?=
 =?us-ascii?Q?xYX6cNRZ6UVwpMNzGJ8R5NRcQ+M74NAfOLDrZNEtoUiKsBsEb9HoyOcTDUZN?=
 =?us-ascii?Q?tRH+apFkZtzK16mvJh5RDR6mUM/0Yj6mJudZw6USvrc7YGQkqXiWygKA2td8?=
 =?us-ascii?Q?EkQL7+ngfaW477NwlIT52NWR3S3bgHKO1+9F0HNPerTqUtScYBhsfcwfA+i+?=
 =?us-ascii?Q?yjLMjU7BpSko5pmPnpxEFqT0dBwFeKOsvUKs5mCW1ktt5T7+3vlESAz/HRy8?=
 =?us-ascii?Q?xShfwS6V6h6KIBLaUywKaiaR1Zbzo39M63RUP8ly+W/iVlD+Anf9XjULtybH?=
 =?us-ascii?Q?sXCdUfVBKbBe4ZKwoLblxV28zlvQAYaT6q9mA0i0nryozVGXSLs5YxxaA8PL?=
 =?us-ascii?Q?0kgr0SNJLGDuRWNsxFtrIvPcmFE9yX55Tt3m+Per2M12Wg48d1396+QfFTGf?=
 =?us-ascii?Q?UqbAfFYxGTn3P2os2i50zZYvmJzVB+03CnHDET2MNpktW5gP8IsgLFcLNoA7?=
 =?us-ascii?Q?/cl+iv3GRcfTSOkznrK6fJCAwN/39/X9Gc8I9pFxUehUmmCr6v1F7BQ3ndEy?=
 =?us-ascii?Q?wqvOIDrrhxWsPr8qURQkP88LuJ4ZlC8nfSrUfkazygPZJZXgKukjKlDi7jVx?=
 =?us-ascii?Q?zu2c2j+CcleAsBD0clX/4iYXdrwehe+HXHU2iAlk04cPuyZmr/9F90o1wa0c?=
 =?us-ascii?Q?NOoEUnz/X5LGFBjDrZUp45UJgvp0gG4Yy2KEaVEHdWASSCujnjdJvhtT9c0C?=
 =?us-ascii?Q?OTlQjFt7r8BzpXhmfVKxnCHOvyPMxbtzGZ4S2O3CZ+qPbiSc9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:00.4497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a437b3c7-0b73-4c05-9ccc-08dd196d897a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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

Move more per instance data into the per instance structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 196 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  17 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  42 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  92 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  51 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  67 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  19 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  18 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |   8 +-
 13 files changed, 279 insertions(+), 267 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8a2e3df945197..5204d1217cec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -480,7 +480,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
-			for (j = 0; j < adev->vcn.num_enc_rings; j++)
+			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
 				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
 					++num_rings;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 224d2aeb88d13..c9c12654cc418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -127,93 +127,88 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
 		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
 		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
-	}
-
-	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-		adev->vcn.indirect_sram = true;
-
-	/*
-	 * Some Steam Deck's BIOS versions are incompatible with the
-	 * indirect SRAM mode, leading to amdgpu being unable to get
-	 * properly probed (and even potentially crashing the kernel).
-	 * Hence, check for these versions here - notice this is
-	 * restricted to Vangogh (Deck's APU).
-	 */
-	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
-		const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
-
-		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
-		     !strncmp("F7A0114", bios_ver, 7))) {
-			adev->vcn.indirect_sram = false;
-			dev_info(adev->dev,
-				"Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.inst[i].indirect_sram = true;
+
+		/*
+		 * Some Steam Deck's BIOS versions are incompatible with the
+		 * indirect SRAM mode, leading to amdgpu being unable to get
+		 * properly probed (and even potentially crashing the kernel).
+		 * Hence, check for these versions here - notice this is
+		 * restricted to Vangogh (Deck's APU).
+		 */
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
+			const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
+
+			if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
+					 !strncmp("F7A0114", bios_ver, 7))) {
+				adev->vcn.inst[i].indirect_sram = false;
+				dev_info(adev->dev,
+					 "Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
+			}
 		}
-	}
 
-	/* from vcn4 and above, only unified queue is used */
-	adev->vcn.using_unified_queue =
-		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
-
-	hdr = (const struct common_firmware_header *)adev->vcn.inst[0].fw->data;
-	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
-
-	/* Bit 20-23, it is encode major and non-zero for new naming convention.
-	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
-	 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
-	 * is zero in old naming convention, this field is always zero so far.
-	 * These four bits are used to tell which naming convention is present.
-	 */
-	fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
-	if (fw_check) {
-		unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
-
-		fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
-		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
-		enc_major = fw_check;
-		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
-		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
-		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
-			enc_major, enc_minor, dec_ver, vep, fw_rev);
-	} else {
-		unsigned int version_major, version_minor, family_id;
+		/* from vcn4 and above, only unified queue is used */
+		adev->vcn.inst[i].using_unified_queue =
+			amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
+
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
+		adev->vcn.inst[i].fw_version = le32_to_cpu(hdr->ucode_version);
+		adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
+
+		/* Bit 20-23, it is encode major and non-zero for new naming convention.
+		 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
+		 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
+		 * is zero in old naming convention, this field is always zero so far.
+		 * These four bits are used to tell which naming convention is present.
+		 */
+		fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
+		if (fw_check) {
+			unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
+
+			fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
+			enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
+			enc_major = fw_check;
+			dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
+			vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
+			DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
+				 enc_major, enc_minor, dec_ver, vep, fw_rev);
+		} else {
+			unsigned int version_major, version_minor, family_id;
 
-		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
-		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
-		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
-			version_major, version_minor, family_id);
-	}
+			family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
+			version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
+			version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
+			DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
+				 version_major, version_minor, family_id);
+		}
 
-	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
-		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+		bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
+		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
+			bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
-	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
-		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
-		log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
-	} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
-		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
-		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
-	} else {
-		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
-		log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
-	}
-
-	bo_size += fw_shared_size;
+		if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
+			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
+			log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
+		} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
+			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
+			log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
+		} else {
+			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
+			log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
+		}
 
-	if (amdgpu_vcnfw_log)
-		bo_size += AMDGPU_VCNFW_LOG_SIZE;
+		bo_size += fw_shared_size;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+		if (amdgpu_vcnfw_log)
+			bo_size += AMDGPU_VCNFW_LOG_SIZE;
 
 		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_VRAM |
@@ -239,7 +234,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
 		}
 
-		if (adev->vcn.indirect_sram) {
+		if (adev->vcn.inst[i].indirect_sram) {
 			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
 					AMDGPU_GEM_DOMAIN_VRAM |
 					AMDGPU_GEM_DOMAIN_GTT,
@@ -277,15 +272,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 
 		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
 
 		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
 		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
+		mutex_destroy(&adev->vcn.inst[j].vcn1_jpeg1_workaround);
 	}
 
-	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
-
 	return 0;
 }
 
@@ -404,12 +398,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
-	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
+	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.using_unified_queue) {
+	    !adev->vcn.inst[i].using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (fence[i] ||
@@ -418,7 +412,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, i, &new_state);
+		adev->vcn.inst[i].pause_dpg_mode(adev, i, &new_state);
 	}
 
 	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
@@ -456,7 +450,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.using_unified_queue) {
+	    !adev->vcn.inst[ring->me].using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -466,7 +460,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 			unsigned int fences = 0;
 			unsigned int i;
 
-			for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+			for (i = 0; i < adev->vcn.inst[ring->me].num_enc_rings; ++i)
 				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
 
 			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
@@ -475,7 +469,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
+		adev->vcn.inst[ring->me].pause_dpg_mode(adev, ring->me, &new_state);
 	}
 	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
 }
@@ -487,7 +481,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
 	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
-	    !adev->vcn.using_unified_queue)
+	    !adev->vcn.inst[ring->me].using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
@@ -511,7 +505,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.scratch9, 0));
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -576,14 +570,14 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
 	ib->ptr[1] = addr;
-	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
 	ib->ptr[3] = addr >> 32;
-	ib->ptr[4] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
 	ib->ptr[5] = 0;
 	for (i = 6; i < 16; i += 2) {
-		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
+		ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 0);
 		ib->ptr[i+1] = 0;
 	}
 	ib->length_dw = 16;
@@ -746,7 +740,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	uint32_t ib_pack_in_dw;
 	int i, r;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -759,7 +753,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (adev->vcn.using_unified_queue) {
+	if (adev->vcn.inst[ring->me].using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -778,7 +772,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -876,7 +870,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	uint64_t addr;
 	int i, r;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -890,7 +884,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -912,7 +906,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -943,7 +937,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	uint64_t addr;
 	int i, r;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -957,7 +951,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -979,7 +973,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (adev->vcn.using_unified_queue)
+	if (adev->vcn.inst[ring->me].using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -1396,7 +1390,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
 	struct dentry *root = minor->debugfs_root;
 	char name[32];
 
-	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.using_unified_queue)
+	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.inst[0].using_unified_queue)
 		return;
 	sprintf(name, "amdgpu_vcn_sched_mask");
 	debugfs_create_file(name, 0600, root, adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index b83136451d674..a5256769f8ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -316,6 +316,15 @@ struct amdgpu_vcn_inst {
 	struct mutex		vcn_pg_lock;
 	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
+	unsigned		fw_version;
+	unsigned		num_enc_rings;
+	bool			indirect_sram;
+	struct amdgpu_vcn_reg	 internal;
+	struct mutex		vcn1_jpeg1_workaround;
+	int (*pause_dpg_mode)(struct amdgpu_device *adev,
+			      int inst_idx,
+			      struct dpg_pause_state *new_state);
+	bool using_unified_queue;
 };
 
 struct amdgpu_vcn_ras {
@@ -324,24 +333,16 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	unsigned		num_enc_rings;
-	bool			indirect_sram;
-
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
-	struct amdgpu_vcn_reg	 internal;
-	struct mutex		vcn1_jpeg1_workaround;
 
 	unsigned	harvest_config;
-	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
 
 	struct ras_common_if    *ras_if;
 	struct amdgpu_vcn_ras   *ras;
 
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
-	bool using_unified_queue;
 
 	/* IP reg dump */
 	uint32_t		*ip_dump;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 8031406e20ff9..901a2ecce89e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -607,12 +607,12 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	int		cnt = 0;
 
-	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
+	mutex_lock(&adev->vcn.inst->vcn1_jpeg1_workaround);
 
 	if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_dec))
 		DRM_ERROR("JPEG dec: vcn dec ring may not be empty\n");
 
-	for (cnt = 0; cnt < adev->vcn.num_enc_rings; cnt++) {
+	for (cnt = 0; cnt < adev->vcn.inst->num_enc_rings; cnt++) {
 		if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_enc[cnt]))
 			DRM_ERROR("JPEG dec: vcn enc ring[%d] may not be empty\n", cnt);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 406886f13566a..1bc027b2f6d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -105,7 +105,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->vcn.num_enc_rings = 2;
+	adev->vcn.inst->num_enc_rings = 2;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
 	vcn_v1_0_set_enc_ring_funcs(adev);
@@ -138,7 +138,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* VCN ENC TRAP */
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN, i + VCN_1_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
 					&adev->vcn.inst->irq);
 		if (r)
@@ -166,18 +166,18 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->vcn.internal.scratch9 = adev->vcn.inst->external.scratch9 =
+	adev->vcn.inst->internal.scratch9 = adev->vcn.inst->external.scratch9 =
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_SCRATCH9);
-	adev->vcn.internal.data0 = adev->vcn.inst->external.data0 =
+	adev->vcn.inst->internal.data0 = adev->vcn.inst->external.data0 =
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0);
-	adev->vcn.internal.data1 = adev->vcn.inst->external.data1 =
+	adev->vcn.inst->internal.data1 = adev->vcn.inst->external.data1 =
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1);
-	adev->vcn.internal.cmd = adev->vcn.inst->external.cmd =
+	adev->vcn.inst->internal.cmd = adev->vcn.inst->external.cmd =
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD);
-	adev->vcn.internal.nop = adev->vcn.inst->external.nop =
+	adev->vcn.inst->internal.nop = adev->vcn.inst->external.nop =
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
 
 		ring = &adev->vcn.inst->ring_enc[i];
@@ -189,7 +189,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	adev->vcn.pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
+	adev->vcn.inst->pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
 
 	if (amdgpu_vcnfw_log) {
 		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
@@ -253,7 +253,7 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
@@ -1833,7 +1833,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, i;
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i)
 		fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1849,7 +1849,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(adev, 0, &new_state);
 	}
 
 	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
@@ -1872,7 +1872,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 	struct	amdgpu_device *adev = ring->adev;
 	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
-	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
+	mutex_lock(&adev->vcn.inst->vcn1_jpeg1_workaround);
 
 	if (amdgpu_fence_wait_empty(ring->adev->jpeg.inst->ring_dec))
 		DRM_ERROR("VCN dec: jpeg dec ring may not be empty\n");
@@ -1898,7 +1898,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		struct dpg_pause_state new_state;
 		unsigned int fences = 0, i;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i)
 			fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
 
 		if (fences)
@@ -1916,14 +1916,14 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
+		adev->vcn.inst->pause_dpg_mode(adev, 0, &new_state);
 	}
 }
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
 	schedule_delayed_work(&ring->adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
-	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
+	mutex_unlock(&ring->adev->vcn.inst->vcn1_jpeg1_workaround);
 }
 
 static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -2057,11 +2057,11 @@ static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		uint32_t reg = amdgpu_ib_get_value(ib, i);
 		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
 
-		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
+		if (reg == PACKET0(p->adev->vcn.inst->internal.data0, 0)) {
 			msg_lo = val;
-		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
+		} else if (reg == PACKET0(p->adev->vcn.inst->internal.data1, 0)) {
 			msg_hi = val;
-		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
+		} else if (reg == PACKET0(p->adev->vcn.inst->internal.cmd, 0)) {
 			r = vcn_v1_0_validate_bo(p, job,
 						 ((u64)msg_hi) << 32 | msg_lo);
 			if (r)
@@ -2146,7 +2146,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i)
 		adev->vcn.inst->ring_enc[i].funcs = &vcn_v1_0_enc_ring_vm_funcs;
 }
 
@@ -2157,7 +2157,7 @@ static const struct amdgpu_irq_src_funcs vcn_v1_0_irq_funcs = {
 
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->vcn.inst->irq.num_types = adev->vcn.num_enc_rings + 2;
+	adev->vcn.inst->irq.num_types = adev->vcn.inst->num_enc_rings + 2;
 	adev->vcn.inst->irq.funcs = &vcn_v1_0_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f445ae4013598..9f408f466851c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -110,9 +110,9 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		adev->vcn.num_enc_rings = 1;
+		adev->vcn.inst->num_enc_rings = 1;
 	else
-		adev->vcn.num_enc_rings = 2;
+		adev->vcn.inst->num_enc_rings = 2;
 
 	vcn_v2_0_set_dec_ring_funcs(adev);
 	vcn_v2_0_set_enc_ring_funcs(adev);
@@ -145,7 +145,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* VCN ENC TRAP */
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
 				      i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
 				      &adev->vcn.inst->irq);
@@ -175,25 +175,25 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
 
-	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
 	adev->vcn.inst->external.scratch9 = SOC15_REG_OFFSET(UVD, 0, mmUVD_SCRATCH9);
-	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
 	adev->vcn.inst->external.data0 = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0);
-	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
 	adev->vcn.inst->external.data1 = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1);
-	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
 	adev->vcn.inst->external.cmd = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD);
-	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+	adev->vcn.inst->internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
 	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
 
 		ring = &adev->vcn.inst->ring_enc[i];
@@ -210,7 +210,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	adev->vcn.pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
+	adev->vcn.inst->pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
 
 	r = amdgpu_virt_alloc_mm_table(adev);
 	if (r)
@@ -292,7 +292,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		ring->sched.ready = false;
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
@@ -981,7 +981,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
+		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indirect_sram);
 
 	vcn_v2_0_disable_static_power_gating(adev);
 
@@ -1421,9 +1421,9 @@ void vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
 }
 
@@ -1438,7 +1438,7 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst->internal.cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_END << 1));
 }
 
@@ -1458,7 +1458,7 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 	WARN_ON(ring->wptr % 2 || count % 2);
 
 	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.nop, 0));
+		amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.nop, 0));
 		amdgpu_ring_write(ring, 0);
 	}
 }
@@ -1479,25 +1479,25 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 	struct amdgpu_device *adev = ring->adev;
 
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.context_id, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
 	amdgpu_ring_write(ring, seq);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
 	amdgpu_ring_write(ring, addr & 0xffffffff);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_FENCE << 1));
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
 	amdgpu_ring_write(ring, 0);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
 	amdgpu_ring_write(ring, 0);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_TRAP << 1));
 }
@@ -1520,14 +1520,14 @@ void vcn_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_vmid, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.ib_vmid, 0));
 	amdgpu_ring_write(ring, vmid);
 
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_bar_low, 0));
+	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_low, 0));
 	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_bar_high, 0));
+	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_high, 0));
 	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_size, 0));
+	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_size, 0));
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
@@ -1536,16 +1536,16 @@ void vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
 	amdgpu_ring_write(ring, reg << 2);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
 	amdgpu_ring_write(ring, val);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.gp_scratch8, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.gp_scratch8, 0));
 	amdgpu_ring_write(ring, mask);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_REG_READ_COND_WAIT << 1));
 }
@@ -1570,13 +1570,13 @@ void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
 	amdgpu_ring_write(ring, reg << 2);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
 	amdgpu_ring_write(ring, val);
 
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_WRITE_REG << 1));
 }
@@ -1777,9 +1777,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
 		return r;
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
 	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
-	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.scratch9, 0));
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1863,7 +1863,7 @@ static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 	adev->vcn.inst->ring_dec.wptr_old = 0;
 	vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i) {
 		adev->vcn.inst->ring_enc[i].wptr = 0;
 		adev->vcn.inst->ring_enc[i].wptr_old = 0;
 		vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
@@ -1989,7 +1989,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
 			AMDGPU_VCN_CONTEXT_SIZE);
 
-		for (r = 0; r < adev->vcn.num_enc_rings; ++r) {
+		for (r = 0; r < adev->vcn.inst->num_enc_rings; ++r) {
 			ring = &adev->vcn.inst->ring_enc[r];
 			ring->wptr = 0;
 			MMSCH_V2_0_INSERT_DIRECT_WT(
@@ -2178,7 +2178,7 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
 
-	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+	for (i = 0; i < adev->vcn.inst->num_enc_rings; ++i)
 		adev->vcn.inst->ring_enc[i].funcs = &vcn_v2_0_enc_ring_vm_funcs;
 }
 
@@ -2189,7 +2189,7 @@ static const struct amdgpu_irq_src_funcs vcn_v2_0_irq_funcs = {
 
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->vcn.inst->irq.num_types = adev->vcn.num_enc_rings + 1;
+	adev->vcn.inst->irq.num_types = adev->vcn.inst->num_enc_rings + 1;
 	adev->vcn.inst->irq.funcs = &vcn_v2_0_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1d3780a2d8513..a3bac39e4c9db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -121,11 +121,13 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = 2;
 		adev->vcn.harvest_config = 0;
-		adev->vcn.num_enc_rings = 1;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			adev->vcn.inst[i].num_enc_rings = 1;
 	} else {
 		u32 harvest;
 		int i;
@@ -134,13 +136,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
 				adev->vcn.harvest_config |= 1 << i;
+			adev->vcn.inst[i].num_enc_rings = 2;
 		}
 		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
 					AMDGPU_VCN_HARVEST_VCN1))
 			/* both instances are harvested, disable the block */
 			return -ENOENT;
-
-		adev->vcn.num_enc_rings = 2;
 	}
 
 	vcn_v2_5_set_dec_ring_funcs(adev);
@@ -176,7 +177,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		/* VCN ENC TRAP */
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
 			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
 				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
 			if (r)
@@ -205,22 +206,22 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
-
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+
+		adev->vcn.inst[j].internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
 		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
 		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
 		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
 		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+		adev->vcn.inst[j].internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
 		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
 
 		ring = &adev->vcn.inst[j].ring_dec;
@@ -240,7 +241,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
 			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
 
 			ring = &adev->vcn.inst[j].ring_enc[i];
@@ -268,6 +269,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -276,9 +280,6 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
-
 	r = amdgpu_vcn_ras_sw_init(adev);
 	if (r)
 		return r;
@@ -369,7 +370,7 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 			if (r)
 				return r;
 
-			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
 				ring = &adev->vcn.inst[j].ring_enc[i];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
@@ -1018,7 +1019,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
@@ -1746,7 +1747,7 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
 			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
 			adev->vcn.inst[j].ring_enc[i].me = j;
 		}
@@ -1917,10 +1918,10 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13b9ed96cccda..fabe4d75a7f6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -127,11 +127,13 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 		adev->vcn.harvest_config = 0;
-		adev->vcn.num_enc_rings = 1;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			adev->vcn.inst[i].num_enc_rings = 1;
 
 	} else {
 		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
@@ -139,11 +141,13 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 			/* both instances are harvested, disable the block */
 			return -ENOENT;
 
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-		    IP_VERSION(3, 0, 33))
-			adev->vcn.num_enc_rings = 0;
-		else
-			adev->vcn.num_enc_rings = 2;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+			    IP_VERSION(3, 0, 33))
+				adev->vcn.inst[i].num_enc_rings = 0;
+			else
+				adev->vcn.inst[i].num_enc_rings = 2;
+		}
 	}
 
 	vcn_v3_0_set_dec_ring_funcs(adev);
@@ -198,22 +202,22 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
 
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
 		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
 		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
 		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
 		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+		adev->vcn.inst[i].internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
 		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
 
 		/* VCN DEC TRAP */
@@ -227,7 +231,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev)) {
-			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
+			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1);
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
@@ -239,7 +243,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
 
 			/* VCN ENC TRAP */
@@ -251,7 +255,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->use_doorbell = true;
 			if (amdgpu_sriov_vf(adev)) {
-				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
+				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1) + 1 + j;
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
@@ -277,6 +281,9 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -284,8 +291,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 	}
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
 
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
@@ -373,7 +378,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 				ring->sched.ready = true;
 			}
 
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
 				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 					ring->sched.ready = false;
@@ -401,7 +406,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			if (r)
 				return r;
 
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
@@ -1153,7 +1158,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
 	vcn_v3_0_disable_static_power_gating(adev, i);
@@ -1433,7 +1438,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 			mmUVD_VCPU_CACHE_SIZE2),
 			AMDGPU_VCN_CONTEXT_SIZE);
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 			ring = &adev->vcn.inst[i].ring_enc[j];
 			ring->wptr = 0;
 			rb_addr = ring->gpu_addr;
@@ -1921,11 +1926,11 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		uint32_t reg = amdgpu_ib_get_value(ib, i);
 		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
 
-		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
+		if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data0, 0)) {
 			msg_lo = val;
-		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
+		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data1, 0)) {
 			msg_hi = val;
-		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
+		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.cmd, 0) &&
 			   val == 0) {
 			r = vcn_v3_0_dec_msg(p, job,
 					     ((u64)msg_hi) << 32 | msg_lo);
@@ -2089,7 +2094,7 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
 			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
 			adev->vcn.inst[i].ring_enc[j].me = i;
 		}
@@ -2255,7 +2260,7 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index dbbeeffc90726..ee87594fafa60 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -129,8 +129,9 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* re-use enc ring as unified ring */
-	adev->vcn.num_enc_rings = 1;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
 
 	vcn_v4_0_set_unified_ring_funcs(adev);
 	vcn_v4_0_set_irq_funcs(adev);
@@ -214,7 +215,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev))
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i *
+				(adev->vcn.inst[i].num_enc_rings + 1) + 1;
 		else
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
 		ring->vm_hub = AMDGPU_MMHUB0(0);
@@ -226,6 +228,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		vcn_v4_0_fw_shared_init(adev, i);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 	}
 
 	/* TODO: Add queue reset mask when FW fully supports it */
@@ -238,8 +243,6 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 
 	r = amdgpu_vcn_ras_sw_init(adev);
 	if (r)
@@ -1111,7 +1114,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
 	vcn_v4_0_disable_static_power_gating(adev, i);
@@ -2172,10 +2175,10 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
 
-		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1a939fdcc8fea..2d88f4c0537e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -115,9 +115,11 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	/* re-use enc ring as unified ring */
-	adev->vcn.num_enc_rings = 1;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
 
 	vcn_v4_0_3_set_unified_ring_funcs(adev);
 	vcn_v4_0_3_set_irq_funcs(adev);
@@ -195,6 +197,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		vcn_v4_0_3_fw_shared_init(adev, i);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
 	/* TODO: Add queue reset mask when FW fully supports it */
@@ -207,9 +212,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
-
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
 		r = amdgpu_vcn_ras_sw_init(adev);
 		if (r) {
@@ -1132,7 +1134,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 	/* set VCN status busy */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f6b347fcdb7ed..0700a5f96084c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -115,9 +115,11 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	/* re-use enc ring as unified ring */
-	adev->vcn.num_enc_rings = 1;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
 	vcn_v4_0_5_set_unified_ring_funcs(adev);
 	vcn_v4_0_5_set_irq_funcs(adev);
 
@@ -173,7 +175,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev))
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						i * (adev->vcn.num_enc_rings + 1) + 1;
+						i * (adev->vcn.inst[i].num_enc_rings + 1) + 1;
 		else
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 						2 + 8 * i;
@@ -198,6 +200,9 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -206,9 +211,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
-
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
@@ -1014,7 +1016,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
 	vcn_v4_0_5_disable_static_power_gating(adev, i);
@@ -1624,7 +1626,7 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c5d59edf3a482..eeb3c9875ad50 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -98,9 +98,11 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	/* re-use enc ring as unified ring */
-	adev->vcn.num_enc_rings = 1;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
 
 	vcn_v5_0_0_set_unified_ring_funcs(adev);
 	vcn_v5_0_0_set_irq_funcs(adev);
@@ -184,15 +186,15 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			adev->vcn.inst[i].pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
 	}
 
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
-
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
 	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
@@ -791,7 +793,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	/* disable VCN power gating */
 	vcn_v5_0_0_disable_static_power_gating(adev, i);
@@ -1367,7 +1369,7 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 259f2fdef8aaa..79ed4855c85a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -58,9 +58,11 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	/* re-use enc ring as unified ring */
-	adev->vcn.num_enc_rings = 1;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
 
 	vcn_v5_0_1_set_unified_ring_funcs(adev);
 	vcn_v5_0_1_set_irq_funcs(adev);
@@ -590,7 +592,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 
-- 
2.47.1

