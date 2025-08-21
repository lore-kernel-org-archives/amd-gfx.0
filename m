Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3BDCA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 15:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE9410E9CD;
	Thu, 21 Aug 2025 15:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1PqMW++";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E0510E079
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 15:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlCIx1GrvOVfFneIiGv6cyvmpFpFkmNIG0EG3MyWvsQpGN918ud70bEwO304bP5mpieu1SYbiN2I4QHFjM4cM+c8im030p7jaMahumGnzm0HE2tzzCoNC8Q9Eh2o1QcXsMFjvtML4Ryyd3UUF7QwEW6ZQN6ev5yUcYNSAP05aq4qi4Vz8B6EXJw6/5Q/f2IOa8+vSlFFSy72Ba5WLlzWTn5Xmf0jec0xGRMuViFxh9c1Q4zqqkaQ5UY9I1OvoONmfwsIsb7lkYw8QDpCurfFuVkD88aAPxWegqY5hoPVUmKRTllKJd6v0Y+PNHkNj8HX34wMLo4Fnr0CBn/lQU59OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeDHRJadCK6JwcdDtq7xKrDd7QiNnA9MaJJm+rfkzw0=;
 b=xsKsU6Ugo1h0YD8orqU50XKOirHLVJEvHh35FFvTkv7XrfJrKvbhEGlXpySoX0KwmOv8lEtofpDeQDEEVYrdOxXDW82k5FEkh9D4Tc1Y5i1UYbyuH2OxeNtO0Kebj2/mAhVSlGvvui6G/qbHfUWliRYadVJmELt3/qhlhC3Cs1054mywpS5kRjq+tNM1vIDn30DW86S+neJAi0vntAh965CRoBPEn7AoXOezgeoLNg76I40BcmSkk2ODOHZyWw5r+skeWJFgij+2QbmgbHoSWeE7hTpcfL5MsLt877ETY0XrknmOJcFtOHuPRqRhlpHla896UDaaLtjXVPvsRSgmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeDHRJadCK6JwcdDtq7xKrDd7QiNnA9MaJJm+rfkzw0=;
 b=z1PqMW++pIfNrUoZrixkAZ1cOBRc1eLdK9yfyGiHAb0i0nOvUdsPfCWq3myzEdxlHVzg99C71cQ5IRaV0dPDx3UnBfXFxsh4fWD8OscvTUPqLakat+FBDEb6iSQuq/X9Hm5hq0io3csWuClPi6uswX7Q37XYA6/lT2ytbLwOxiA=
Received: from BYAPR06CA0047.namprd06.prod.outlook.com (2603:10b6:a03:14b::24)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 15:20:48 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::e3) by BYAPR06CA0047.outlook.office365.com
 (2603:10b6:a03:14b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 15:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 15:20:47 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 10:20:46 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Date: Thu, 21 Aug 2025 11:20:33 -0400
Message-ID: <20250821152033.790477-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BN3PR12MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: d282bb1b-97f5-4794-3838-08dde0c64e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0TsxFBZOgaH49esQ7fvm4dcChwU/p5bMIuZZuVBzNW1qxnVwUpmkXggDUeJm?=
 =?us-ascii?Q?iwyM32VdELFY69g81snU5x85Lxb6htrhIxQCkgJZuy+USccGlTCujnpKcrC7?=
 =?us-ascii?Q?lvsZdAl+NwNEeHFI0fnmj1+1jzn7qDZELhHYOT6K0dztC//YD7pcuGR8izLv?=
 =?us-ascii?Q?GODkxwqPP8x4KwM6lm8bhWWgR/qqT8UeXim4vSIa1ichPpTc8dAbYgbw1+jj?=
 =?us-ascii?Q?Efzr4kfEKf2zaxXOQdfBxCibJRKjn5YJgo//DSc+iOMYFeA74/Z3MKqmnOhs?=
 =?us-ascii?Q?doNJz775Kf4IVutdv1+m7BmsC4t5KLg5OnmdUVtlg6sGZq3g20NE3lh+0RCl?=
 =?us-ascii?Q?SdfdRcGjyCEg4ukv+zu0b0PxHM5APWRY1m4GF1jlhgNS8TZ3/uFcx07wRurO?=
 =?us-ascii?Q?HPqaVU/Dd8g7J6Lq30PAGtD9ETPPJftt5sVxB8G8OboLytW+N02vOu0C8Ogb?=
 =?us-ascii?Q?rEgxecdStv9KmWqZ+ZcWuaS8tEYrnJLhW30eZm2l8oMpbj+N2xOIRGmBkI95?=
 =?us-ascii?Q?8fxxxqzJ51TUD97W1k47ZY2gtwn71wfcLACl+5G8clOdQQBAPaHw0Nptv8rd?=
 =?us-ascii?Q?90sPegjnh+70Xovd9YKF6AhkmM7G+t+YmtN+po/hCZx8BsNMBsZfcqNc3y7X?=
 =?us-ascii?Q?lXbOy05BNZj6JXDGedaq6jieSjWmuFRl4zs5US3NFBQpNSG3ce2Cx+Ef8vZZ?=
 =?us-ascii?Q?6qP69msjU2fQQWVH9cKm9dMaUYjsqRnT5UzCEdQKmJC+bJ0otzZkwTU1F0le?=
 =?us-ascii?Q?C/tYGavp4q2n8WlStc6sy/CQRo0/LFhcTI/QMxJxJdxhd/SxIpZUYz4isUzp?=
 =?us-ascii?Q?nrYbO9cJc85m3dctdhs+hq3vvPNfg2erBa0ppOnawIESFMsKKKppNupzGs0W?=
 =?us-ascii?Q?PLVu0q6klS9DsB+O8jGkOrlnzV8VfvJ+zqpRbGahSOJupdV1wirg26P9+JcR?=
 =?us-ascii?Q?2wZ0LuJeGD3YHePtirvF9aR718ck38cq9Dpoa2BEaquxI/1QLV49FxL7Dfxw?=
 =?us-ascii?Q?U0agLjBbtAXH/wUAL86MTcVjkGyvbDddljp5KvmkYKl5K/PMBrF7gttcNAA6?=
 =?us-ascii?Q?njmTJ1RzsbTiMbbN+PKWRX0fT0+uQmkhWXadfJ4m6rIiHp70rpCxZkA7yZWA?=
 =?us-ascii?Q?WwdHLvAKJUMa6U0FJz4RTRX1qWRf3t/oRVpjzWSdYdZBNw231cWzdkB+wITD?=
 =?us-ascii?Q?2pQfSLFuXU800o3qhnuHs3a2XTF0qxsPNFhaPm6xYkQmxK6ejj4UG+EzG2Zw?=
 =?us-ascii?Q?8YAfVdVru0iNd2M3la/b8WRv2p79xuqwmh7qfL7ZYsdiu26tSAhutkXsXleW?=
 =?us-ascii?Q?8F/HuMLKU9tuF/fA/R3cp7BMtXlFFRhLgR9bJ2Lq7J43jAeRkxwjRxZHXNqA?=
 =?us-ascii?Q?kPnYrw5tcdM4OxYyHNaZmI82eDjqNDhBuuVUGAreb66l5uKitVHzC3VlwLdT?=
 =?us-ascii?Q?8g5CQGYUpKop7iUTYzzoMrr2iU/hl1RpK1FCf0xMaAcQaExYoUEWqxK2UxH5?=
 =?us-ascii?Q?ZBHBCqrjYW7pyuXKAohoWH4dQ2hHpyIHNQ3XOnLibD6cvsxcHLwdS4K9XmL8?=
 =?us-ascii?Q?Bk3SH+C7buJFyUp/Xac=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:20:47.4940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d282bb1b-97f5-4794-3838-08dde0c64e2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593
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

From MES version 0x81, it provide the new API INV_TLBS that support
invalidate tlbs with PASID.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 27 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 20 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 43 +++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index c0d2c195fe2e..46235b8726f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -280,6 +280,30 @@ struct mes_reset_queue_input {
 	bool                               is_kq;
 };
 
+enum amdgpu_mes_hub_id {
+	AMDGPU_MES_GC_HUB0 = 0,
+	AMDGPU_MES_GC_HUB1 = 1,
+	AMDGPU_MES_GC_HUB2 = 2,
+	AMDGPU_MES_GC_HUB3 = 3,
+	AMDGPU_MES_GC_HUB4 = 4,
+	AMDGPU_MES_GC_HUB5 = 5,
+	AMDGPU_MES_GC_HUB6 = 6,
+	AMDGPU_MES_GC_HUB7 = 7,
+	AMDGPU_MES_MM_HUB00 = 8,
+	AMDGPU_MES_MM_HUB01 = 9,
+	AMDGPU_MES_MM_HUB02= 10,
+	AMDGPU_MES_MM_HUB03 = 11,
+	AMDGPU_MES_MM_HUB10 = 12,
+	AMDGPU_MES_MM_HUB11 = 13,
+};
+
+struct mes_inv_tlbs_pasid_input {
+	uint32_t        xcc_id;
+	uint16_t        pasid;
+	uint8_t         hub_id;
+	uint8_t         flush_type;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -367,6 +391,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
+			      struct mes_inv_tlbs_pasid_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index feb92e107af8..b5be6c7838aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -339,6 +339,26 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x81) {
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+		input.hub_id = AMDGPU_GFXHUB(0);
+		/* MES will invalidate all gc_hub for the device from master */
+		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+		if (all_hub) {
+			/* Only need to invalidate mm_hub now */
+			for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+				if (i < AMDGPU_MMHUB0_START)
+					continue;
+				input.hub_id = i;
+				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			}
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..6740383f7721 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_0_misc_opcodes[] = {
@@ -879,6 +880,47 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_inv_tlb_convert_hub_id(enum amdgpu_mes_hub_id id)
+{
+	int mes_hub_id = id;
+	/*
+	 * MES doesn't support invalidate gc_hub on slave xcc individually
+	 * master xcc will invalidate all gc_hub for the partition
+	 */
+	if (id == 0)
+		return 0;
+	if (id < AMDGPU_MMHUB0_START)
+		return -EINVAL;
+
+	mes_hub_id -= AMDGPU_MMHUB0_START - 1;
+	/* gfx12 only support maximum one mmhub */
+	return (mes_hub_id > 1) ? -EINVAL: mes_hub_id;
+}
+static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
+				    struct mes_inv_tlbs_pasid_input *input)
+{
+	union MESAPI__INV_TLBS mes_inv_tlbs;
+
+	memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
+
+	mes_inv_tlbs.header.type = MES_API_TYPE_SCHEDULER;
+	mes_inv_tlbs.header.opcode = MES_SCH_API_INV_TLBS;
+	mes_inv_tlbs.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_inv_tlbs.invalidate_tlbs.inv_sel = 0;
+	mes_inv_tlbs.invalidate_tlbs.flush_type = input->flush_type;
+	mes_inv_tlbs.invalidate_tlbs.inv_sel_id = input->pasid;
+
+	/*convert amdgpu_mes_hub_id to mes expected hub_id */
+	mes_inv_tlbs.invalidate_tlbs.hub_id = mes_v12_inv_tlb_convert_hub_id(input->hub_id);
+	if (mes_inv_tlbs.invalidate_tlbs.hub_id < 0)
+		return -EINVAL;
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
+			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
+			offsetof(union MESAPI__INV_TLBS, api_status));
+
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +930,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.34.1

