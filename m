Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AE606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tcC+Hum1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B99210E4F6;
	Tue, 27 Oct 2026 23:22:08 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 195C110F898
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGuBjlPJEPyqdvmldcPoBJ3ULu2kRo/Hl9+8Yh0nGZa9IPMqA1wCqJvojFdCJ3Jz2+NseE8ugjEk3nhallTgBAZZyI9PtQpZNK70Xvmt9YvRJTO8keuJa2DPLQ1Z6SiSYhydxFjLdrRy75zMBPGi9C58mNK6sNW/6dvrGAsR6X54KIT3+FOs2FSu16mRG7zO+HYlZR7aYE1PewFracMD57zHU487sBBMBxZU5s7IQ18avtmQtKKDvz7XE1K95krw3DHJkK6O1Cht8lj/U7ahqTOQ94ZUd8Uw2PreG1vXYD36nDYhsgTGcAphZOBndp2OVYMz06xJUvyK6KhK8USDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTI2ACJ9w54EKgCb0WfXG3hKXE0fUE55D5bl/yeQ9+M=;
 b=tMTAmb0RsID2lRIxi44upbMGfXNBgHIYNLquHALzlDvS1RPXCBWI3fqAm6fVRlZ4mjyF9c5zRj7nut5DR5Upnl53MCOczFDe5ffaUjr6+g1Q+YOU5w+kVu3OQldHc5/1iwTuI7217iT+3/lrRQzzKWFGEvesmlsATYManVJzQkPofIrxamozesGXNj8AkDPHzuedTFl31DGlrz+pOdZBhVNOkdWL4nkF40pQ9SocOpJF5jS9q+KGMGutq3R3hHy+QP1IA8k/i6YoqXN33huEDyZME0wAh/Pr9q6Cit8zMAInNaxniRDZ6QpQdzCgfqt/QpfoD3egTihe1eWObmIRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTI2ACJ9w54EKgCb0WfXG3hKXE0fUE55D5bl/yeQ9+M=;
 b=tcC+Hum1YakmYSuD73n2kB3pHDe5uzbvwgoDmRrlvnpLUvVwizi5oh/x2KySlefbknbfVAMF+XgCr/pC4BiTTgWpRoSWWYQgaXg4WWpzOJGOf05z86lX5jcPixXHouFEeU+R5eHCycOmrITDYs0MqL+n5RTvGgsdnK2i9IuWmHQ=
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 23:21:58 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::9f) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:21:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:21:58 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:21:56 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 07/28] drm/amd/display: Configure alternate-channel apertures
Date: Tue, 27 Oct 2026 17:17:03 -0600
Message-ID: <20261027232005.2879750-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: a9641734-ff85-423b-00c7-08df3481190a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|261026121527099003|11063799006|56012099006|261022075727099003|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|3023799007|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 9BP+ahq9Ndz2b/zr5o5gesRZBNcaxSywitU6GTL/1TgCSoZfOiRp8jJdltqHJtp9a3zLmM06h4wwumegzXRE9U7KH6az2ouX5t6nF0BVkXV4RqpgvdpXBUJbRcKCwoMX7CbzqkdQW2LfjdkLYXNHw6Bdfwash5bd9V0SZ+ywWS7BrRMJdUmq7eVNATfek3JwuYSuPJFTSjRZ8uTm6kTkBEVybXEwRjL1hT5X9bPp1eLsjDp1N4wMH2XMf1ZHNRnjk+eCHT+m0RXjewezzMt2TbvxRDBJ3losSz2t73v9+citHIljuF5a8u+X+FYFRFn1yfS9xWFJ860a6KyQ3kGI2fyTJOPzEPfm1t1uopV4uK/QCjUk2WUS1xjAN9dPZHAYTEjkjfb05CMSi06qzdslR4EihiApaOjRv4uZT+B27to3lnEHkaDE/ostdyUs9Ju6gf2L1svuVnqmU0jNN2qCtuoThl6+X8loeV+QPmxGhELRAGMCOOh5p/YtoiwV4cO15Gpk32XRpRordk5VBL8DauCTJhoFtue5UbfBqpLjaoxurFXgtHS7Dn8T710JusHR4x2IH9HwuG897WbIcAnZ9z3gClqO9+JGuEvseDC0cZd0qiPR+aDvuhUZR7MPAbDboiPhPVjm4ONbq2Mr5bRwB2B71HE53eppewJte3/XAXJH9wVWM/RRDJSiz+9ZfU7/GYR/SrmxjYmZvkRmIs9E+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(261026121527099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qrAoEZWHU/Obh+AOsAKn5maaev7tfvsbtl5nF/W/ogy+Ix3SNXHArLCctED0pbMbCDKqfvls39adejrBCMejDvPowqMY7/rVW8SNX7IOv3uk6sICUWtBCs5VxNatWEESnB43mkewTb7a7zgifAKwJ/FEFiUcuw0JETpm7198fWJZk3eEtW6tf7/KzefOzJwv4y0yGAkRqpGY7PSUNW/sU2MaYY+zeOXplWkQx5pDoNx6KXpsW95XVQA5AB7Ods0ZSfyUyhlpNCSHsEDMHWdcPppbwzJFMfuTiF5n/7QwsNt0Rq6FZoqlLsjN2STcXUpTKSv7tyICpWjVTtrbYHEtDT0pspil38b3vj0sYXJeuMhrkE2cS0MnrTbMLlcdMdn9h8JeZEXyhNLbphW3EZFvIuiPr3EMccN+D/3JvdAZyFk7V7ytL1e1+Rfw9ylBlYKQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:21:58.4889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9641734-ff85-423b-00c7-08df3481190a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY]
Alternate channel P-State switching enables in-frame P-State changes by
streaming scanout from carved DRAM apertures on one memory channel set
while the other is optimized.

[HOW]
Read both aperture regions from IP discovery, translate their
addresses for DMUB and DML2, and populate their base and size fields.

Cc: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index b0325d686b28..614709fe11a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -160,6 +160,68 @@ bool dm_register_dmub_notify_callback(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(dm_register_dmub_notify_callback);
 
+
+/**
+ * dm_get_alt_channel_pstate_switch_aperture - Set the vactive p-state switch apertures.
+ * @adev: amdgpu device containing the discovered apertures
+ * @hw_params: DMUB hardware parameters to populate
+ *
+ * Reads both apertures before populating the DMUB parameters and DML2 config.
+ * Translates their base addresses into MC space for DML2. If either aperture
+ * is unavailable, the feature remains disabled.
+ */
+static void
+dm_get_alt_channel_pstate_switch_aperture(struct amdgpu_device *adev,
+					   struct dmub_srv_hw_params *hw_params)
+{
+	static const u32 region_ids[] = {
+		G7_PSTATE_APERTURE1_ID,
+		G7_PSTATE_APERTURE2_ID,
+	};
+	struct mem_reserved_info apertures[ARRAY_SIZE(region_ids)];
+	u64 aperture_mc_bases[ARRAY_SIZE(region_ids)];
+	u32 i;
+	int r;
+
+	/* Region IDs 5 and 6 identify the p-state switch apertures 1 and 2.
+	 * Do not publish partial aperture configuration if either lookup fails.
+	 */
+	for (i = 0; i < ARRAY_SIZE(region_ids); i++) {
+		r = amdgpu_discovery_get_mem_reserved_region_by_id(adev,
+								region_ids[i], &apertures[i]);
+		if (r) {
+			drm_warn(adev_to_drm(adev),
+				 "P-state switching during vactive unavailable: aperture %u lookup failed (%d)\n",
+				 region_ids[i], r);
+			return;
+		}
+
+		if (!apertures[i].reserved_region_size ||
+		    apertures[i].reserved_region_size >= (0xfffULL << 20)) {
+			drm_warn(adev_to_drm(adev),
+				 "P-state switching during vactive unavailable: aperture %u has invalid size\n",
+				 region_ids[i]);
+			return;
+		}
+
+		/* DML2 requires the reserved-region base in MC address space. */
+		aperture_mc_bases[i] = apertures[i].reserved_region_start +
+			adev->gmc.fb_start - adev->vm_manager.vram_base_offset;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(region_ids); i++) {
+		hw_params->soc_fb_info.alt_channel_region_base[i] = aperture_mc_bases[i];
+		hw_params->soc_fb_info.alt_channel_region_size[i] =
+			apertures[i].reserved_region_size;
+		/* DML consumes the MC base address bits [47:16]. */
+		adev->dm.dc->dml2_options.alt_ch_cfg.region_base_addr_47_16[i] =
+				(u32)(aperture_mc_bases[i] >> 16);
+		adev->dm.dc->dml2_options.alt_ch_cfg.region_size_bytes[i] =
+				(u32)apertures[i].reserved_region_size;
+	}
+}
+
+
 int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -261,6 +323,7 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 	memset(&hw_params, 0, sizeof(hw_params));
 	hw_params.soc_fb_info.fb_base = adev->gmc.fb_start;
 	hw_params.soc_fb_info.fb_offset = adev->vm_manager.vram_base_offset;
+	dm_get_alt_channel_pstate_switch_aperture(adev, &hw_params);
 
 	/* backdoor load firmware and trigger dmub running */
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
-- 
2.53.0

