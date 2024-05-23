Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8BEC25B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C0810F2B0;
	Thu, 23 May 2024 19:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Po+yATtR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AF810F2A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dObou3WilYbtOm5yQN/lOU4WoMTB533e4MqZUJnRozg7hjW31WqKhtQgZmKMRR03nmCbsVm65t9NGNyVBo0BHsA7tFRfungQ3EUz4tTC+nxUmcKrLg7ECqUtqwPeclNkfgjBvFWljD0VzCdoQxZ/rYzpcl2iSXWtqDjAEdNd7HuWpGLJDeExErxLlJsKAfivgq7avcGHrW8fRzEYOIoQUxxC23j8rhBG9AAzVzN6mAs3wM4dwAGEdfSCDmM99DEGwwD6X9veSYK4DznIpcWOYExAhPXljfbHjJElPMYz0/uW+oCPx3CYGXlsUBhuCnVyHNhxX8MUBOIeVWwoIgAT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgZYyDpMavl1iJ6dxCW9Dx0aYJ5PcJLRNM1vLN524AQ=;
 b=OIyOsIzMOxp75aG/O6tAheu48T5NcNRX/FHx0ywBDcgH0IQOOARIJ74w0rR78e/X2H7O1ndLdh95fvyYxOySqG0RrE6Kh/TpSZjWobXcr/omReIrOyH/LiG8VpGkfvHbGHmg52wpbQxvYhpuhkiI3T9hqeZD61W6hWJPi8k98f8/n08AHBYyl2+DfNSjZJut3AgegFo14yeT6z0n6pru5BJh635zW24GdJJULk+8ZFg0JeHGtl+uar2B7+l6pq545cpfm5hyTp3s81W8QU8dKeBfd8wtDRhcE/m8Lrtmfcs0/9QxCcFCXUQUCuw57dDp7AIhx4PtiUsEaKFnJcMmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgZYyDpMavl1iJ6dxCW9Dx0aYJ5PcJLRNM1vLN524AQ=;
 b=Po+yATtRbFMX+pPi9N37YvFyb0RT/dmwTczDHcsDQ3fHkwqYqvicu3zfe/I8hbAU9uiPhcZfjhCZeJWg5xNH5MMNb9gLU/EqWZEf6phg08nCTIybYIbpFGmwZhqHvRSsgWD0Zk8nckrcN+L2NRxFR/O6BPKvwxX5Lp5k4108GAU=
Received: from BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) by CY8PR12MB8195.namprd12.prod.outlook.com
 (2603:10b6:930:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:21:27 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2a01:111:f403:f901::) by BL6PEPF0001640C.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21 via Frontend
 Transport; Thu, 23 May 2024 19:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:24 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Enable copying of bounding box data
 from VBIOS DMUB
Date: Thu, 23 May 2024 19:20:27 +0000
Message-ID: <20240523192027.50630-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ce0327-0b45-42f2-c0be-08dc7b5d89ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E/FGDIyJaGHe7qEYHhMsQi5nDT3wKYC3lKS60zKE+gHwmR/VC5pw7WtBnWX4?=
 =?us-ascii?Q?XpseSgni8DcF9ZX6yDukvza1ZiCwUsLdKyCBxLdCQ9jFTjJZUS5Y8SIfTafe?=
 =?us-ascii?Q?QpfldZ+4RN6PETdrYwsYXYs2xqvmHmG50+vUyLoRzwrImkaA3T9Fd0TEPkmt?=
 =?us-ascii?Q?JmwZUeFzYfW1m13WKoPnPqcK1WcLdyETMyMvgtUBkGCRxxMXtvL+OuCWziDq?=
 =?us-ascii?Q?rAvUQwti1pRipRioKpUpjHtkpStD6tAIaaDCnyeeZeS5iH96S30hh3svZgWA?=
 =?us-ascii?Q?w7xup9c/rcG6Hj0FjpKm7hipYAApmOlJu7ZUmr9Sd5OEi8LtawwORYDzOv8f?=
 =?us-ascii?Q?Rk5+QZdmMyLBFxcaMvkUro6mh7q8dk937JkjnaUWrDSrOOfcceSj7QnX/LDY?=
 =?us-ascii?Q?uQtVC3u7a+n5okIPyMT2pqrHXu9v1eUdiJcbtBqnSOZP0EYg641Zy6flNNWc?=
 =?us-ascii?Q?/FfGL2pTMQjCaW7DDNFyP90cJaJMx2fbhVGwQiMXVwp62CaWmwXy2fj6IwZs?=
 =?us-ascii?Q?q8dpsR3cJ9fJkQWdWt7u4O4Ig/XSQ7fl9p2EAQdQZuBbuUXviMJHSW8axYNH?=
 =?us-ascii?Q?Y5oze+tMCZZIb34ksWl68IidHsjbUJ9U1pyoxeC6X/LgA3mTCl7jZbfLmhdn?=
 =?us-ascii?Q?RJAICZJijz+crXr1exMvj2XrUipzVUw0AtBshTmT9pRW3VtTYZgoQm1d2RJa?=
 =?us-ascii?Q?iMRk4QurWsFZvPpGtOSiK8QYYKLKt+9vBoqbNrgNR39b6dLeqwNrPhuno2oP?=
 =?us-ascii?Q?bLnmLHJtZQI+y8rMafuL0L88ifhGOjrq2s9onX3vbpAm1tI8/1aGdBG9LKnw?=
 =?us-ascii?Q?rpBjAKYJcnL87HR5/rLqoUYIde5CEm0JWPLAmMdth8xCXHFGd4MadfhCnwWQ?=
 =?us-ascii?Q?dufyBKERSJYm2enKCqfUSSnOnkHhosIj2kx61u2I+8xocrGrK/cvAcQqIxai?=
 =?us-ascii?Q?8nB3PV5Xj5taGVs3ZajnwY+lfAin0+Pls1cPsQa/g3tw1NHdnDKjTJeD4Hn2?=
 =?us-ascii?Q?D67fsn4PrJoHcZxWmUWNlM9G7JgsncL1yAtpPuNlKNeNegRa5bkSWRpYXeEh?=
 =?us-ascii?Q?FeL9hjKU9jlOPdYkErwEoqoAFOQv79jsEg3T79UU62CgZ32mgsP0tSyWUC+y?=
 =?us-ascii?Q?RYKkk/221lp86uyhayfYcyBW8oEPvD+fD7vW8NnlsLW6k+yvsa2uZvGpi9j7?=
 =?us-ascii?Q?5wRMCdBCHDusejQ1Rw0+h1Nynd3ugQYm+DzFhosm7UiHapMuCadEs7B84zfW?=
 =?us-ascii?Q?prgm/6MwHZZREcbrIiH5kO/1nYcZ6gS3gmz5xLSSl4r/SVLuEmICP89PfvHH?=
 =?us-ascii?Q?SbazOmPnG9VwqDQjc3PQgMCtmKUL7HB6OTclqVVG+YCROzsg3yLqPZWq/c76?=
 =?us-ascii?Q?FMx23sDutBguysptM16NLwGj0EaW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:25.1274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ce0327-0b45-42f2-c0be-08dc7b5d89ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

Allocate some memory, send the address in chunks to dmub, and finally
ask it to copy the bounding box data into the newly allocated memory.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 121 ++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  24 +---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |   6 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 7 files changed, 146 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bb4573603479..74accbcaae28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1627,6 +1627,117 @@ static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 	}
 }
 
+void*
+dm_allocate_gpu_mem(
+		struct amdgpu_device *adev,
+		enum dc_gpu_mem_alloc_type type,
+		size_t size,
+		long long *addr)
+{
+	struct dal_allocation *da;
+	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
+		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
+	int ret;
+
+	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
+	if (!da)
+		return NULL;
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				      domain, &da->bo,
+				      &da->gpu_addr, &da->cpu_ptr);
+
+	*addr = da->gpu_addr;
+
+	if (ret) {
+		kfree(da);
+		return NULL;
+	}
+
+	/* add da to list in dm */
+	list_add(&da->list, &adev->dm.da_list);
+
+	return da->cpu_ptr;
+}
+
+static enum dmub_status
+dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
+				 enum dmub_gpint_command command_code,
+				 uint16_t param,
+				 uint32_t timeout_us)
+{
+	union dmub_gpint_data_register reg, test;
+	uint32_t i;
+
+	/* Assume that VBIOS DMUB is ready to take commands */
+
+	reg.bits.status = 1;
+	reg.bits.command_code = command_code;
+	reg.bits.param = param;
+
+	cgs_write_register(adev->dm.cgs_device, 0x34c0 + 0x01f8, reg.all);
+
+	for (i = 0; i < timeout_us; ++i) {
+		udelay(1);
+
+		/* Check if our GPINT got acked */
+		reg.bits.status = 0;
+		test = (union dmub_gpint_data_register)
+			cgs_read_register(adev->dm.cgs_device, 0x34c0 + 0x01f8);
+
+		if (test.all == reg.all)
+			return DMUB_STATUS_OK;
+	}
+
+	return DMUB_STATUS_TIMEOUT;
+}
+
+static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
+{
+	struct dml2_soc_bb *bb;
+	long long addr;
+	int i = 0;
+	uint16_t chunk;
+	enum dmub_gpint_command send_addrs[] = {
+		DMUB_GPINT__SET_BB_ADDR_WORD0,
+		DMUB_GPINT__SET_BB_ADDR_WORD1,
+		DMUB_GPINT__SET_BB_ADDR_WORD2,
+		DMUB_GPINT__SET_BB_ADDR_WORD3,
+	};
+	enum dmub_status ret;
+
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(4, 0, 1):
+		break;
+	default:
+		return NULL;
+	}
+
+	bb =  dm_allocate_gpu_mem(adev,
+				  DC_MEM_ALLOC_TYPE_GART,
+				  sizeof(struct dml2_soc_bb),
+				  &addr);
+	if (!bb)
+		return NULL;
+
+	for (i = 0; i < 4; i++) {
+		/* Extract 16-bit chunk */
+		chunk = ((uint64_t) addr >> (i * 16)) & 0xFFFF;
+		/* Send the chunk */
+		ret = dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 30000);
+		if (ret != DMUB_STATUS_OK)
+			/* No need to free bb here since it shall be done unconditionally <elsewhere> */
+			return NULL;
+	}
+
+	/* Now ask DMUB to copy the bb */
+	ret = dm_dmub_send_vbios_gpint_command(adev, DMUB_GPINT__BB_COPY, 1, 200000);
+	if (ret != DMUB_STATUS_OK)
+		return NULL;
+
+	return bb;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1748,6 +1859,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	retrieve_dmi_info(&adev->dm);
 
+	if (adev->dm.bb_from_dmub)
+		init_data.bb_from_dmub = adev->dm.bb_from_dmub;
+	else
+		init_data.bb_from_dmub = NULL;
+
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
 
@@ -2305,6 +2421,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	adev->dm.bb_from_dmub = dm_dmub_get_vbios_bounding_box(adev);
+
 	return 0;
 }
 
@@ -2334,6 +2452,9 @@ static int dm_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	kfree(adev->dm.bb_from_dmub);
+	adev->dm.bb_from_dmub = NULL;
+
 	kfree(adev->dm.dmub_fb_info);
 	adev->dm.dmub_fb_info = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a01f3f5bf2c0..94fc4c15d2db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -578,6 +578,11 @@ struct amdgpu_display_manager {
 	 * Guards access to DPIA AUX
 	 */
 	struct mutex dpia_aux_lock;
+
+	/*
+	 * Bounding box data read from dmub during early initialization for DCN4+
+	 */
+	struct dml2_soc_bb *bb_from_dmub;
 };
 
 enum dsc_clock_force_state {
@@ -964,4 +969,9 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 
 int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth);
 struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev);
+
+void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
+						  enum dc_gpu_mem_alloc_type type,
+						  size_t size,
+						  long long *addr);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6d0f78b9ec0c..8eb2f10f2c38 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1045,30 +1045,8 @@ void *dm_helpers_allocate_gpu_mem(
 		long long *addr)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct dal_allocation *da;
-	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
-		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
-	int ret;
-
-	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
-	if (!da)
-		return NULL;
-
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
-				      domain, &da->bo,
-				      &da->gpu_addr, &da->cpu_ptr);
-
-	*addr = da->gpu_addr;
-
-	if (ret) {
-		kfree(da);
-		return NULL;
-	}
-
-	/* add da to list in dm */
-	list_add(&da->list, &adev->dm.da_list);
 
-	return da->cpu_ptr;
+	return dm_allocate_gpu_mem(adev, type, size, addr);
 }
 
 void dm_helpers_free_gpu_mem(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3a2101b052ea..1526ab0b4884 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1014,6 +1014,11 @@ static bool dc_construct(struct dc *dc,
 
 	dc->dcn_ip = dcn_ip;
 
+	if (init_params->bb_from_dmub)
+		dc->dml2_options.bb_from_dmub = init_params->bb_from_dmub;
+	else
+		dc->dml2_options.bb_from_dmub = NULL;
+
 	if (!dc_construct_ctx(dc, init_params)) {
 		dm_error("%s: failed to create ctx\n", __func__);
 		goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 31e3371b1b2e..d0ed01ac460d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1067,6 +1067,8 @@ struct dchub_init_data {
 	bool dchub_info_valid;
 };
 
+struct dml2_soc_bb;
+
 struct dc_init_data {
 	struct hw_asic_id asic_id;
 	void *driver; /* ctx */
@@ -1099,6 +1101,7 @@ struct dc_init_data {
 	uint32_t *dcn_reg_offsets;
 	uint32_t *nbio_reg_offsets;
 	uint32_t *clk_reg_offsets;
+	struct dml2_soc_bb *bb_from_dmub;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 37998f2c0b14..9f641ffdc924 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -26,7 +26,11 @@ static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_
 		break;
 	case DCN_VERSION_4_01:
 	default:
-		soc_bb = &dml2_socbb_dcn401;
+		if (config->bb_from_dmub)
+			soc_bb = config->bb_from_dmub;
+		else
+			soc_bb = &dml2_socbb_dcn401;
+
 		qos_params = &dml_dcn401_soc_qos_params;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index dcb4e6f4d916..20b3970c0857 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -236,6 +236,7 @@ struct dml2_configuration_options {
 
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
+	struct dml2_soc_bb *bb_from_dmub;
 };
 
 /*
-- 
2.39.2

