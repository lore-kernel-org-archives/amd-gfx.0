Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F39EB271F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C498E10E0AE;
	Tue, 10 Feb 2026 21:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hn1vveiD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D7810E609
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdvMfYm4Ao2JDoNtq/sf7J+tJiDjakNVKoqhpmjmsu2yJlL2ceS08f/sMUPEdR8w+ZwYLAIF30hOteq569QovCUUv5PlZe4Szk+W+oQQmn4igIHkExelhaDpzZOdCgrpsKbrNlJHf3y1Pc2O9857DNZSj9CNOjmHNHyndtuAUAB2D6hJqASgqK/7ThjRxSHqxVsjDeMKryyN+wlV4XylUYd0t0bDy5o6aRzSxf0q6tcZwES9FiHgHTEYEs1flkZWsfxOH9V7Sb52wGnAPSX6U3XUWQw3GFY90uS9C+qhPPgoo6I3DFAhEIl+LM8eZNAe6aFNc+NQJM1hL3pvE8yE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPXNStym2x95/VLOHKjxLWD+MbONa1FwG3+cpDxUxJg=;
 b=PI1dSdlktpqYWAKdxioSR7y2Pbe6RS1meRY7YfX/Xwv4mUcNHXlgE+0UT5e94IHFrq6KmJDsmChm+NYrHL/1ik2XL1gNmkHFe9ryBpunwQ/IebXw9HJsUrOfNci8rp6k/w4EWleb1NChCByR0i945JXBrQ/JyuLFAMCT5kYjDHTaiE/QPDc9/AgPc6Zcu3WagY7wQ5rsGhlk7mW8FCiXxzRLC0gw7BscjIlJavLm/0NEiBqtOEwm7N89lXp6ScttRiG4a37iqvPPHUSNlmlD0IBnpZGz+btsUIIjeROVrKahmMoa3mhu2zd//lPnoMtqbbzxKMq59hVCmai5g5ujsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPXNStym2x95/VLOHKjxLWD+MbONa1FwG3+cpDxUxJg=;
 b=hn1vveiD0pmjcl4qKpcQjK84bWlUxb9UfHXFA2I0vZNPFER8MuiBx0DgyPRai0lWAxJCbkblGvdc7l9NXAU2NomppzRSadQcS2oZBYOPs4Pfhbg2+0FRhXiwssBYnBC8xp/Et3W9ID9fX7ZjLbHCqJB07O7L3ffG0Cca26QhOnI=
Received: from SJ0PR05CA0101.namprd05.prod.outlook.com (2603:10b6:a03:334::16)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 21:48:11 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::66) by SJ0PR05CA0101.outlook.office365.com
 (2603:10b6:a03:334::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.7 via Frontend Transport; Tue,
 10 Feb 2026 21:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:10 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:02 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 13/14] drm/amdgpu/umsch: userq suspend and resume context
Date: Tue, 10 Feb 2026 16:47:28 -0500
Message-ID: <20260210214729.80964-14-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab363cc-bff8-4905-4815-08de68ee15a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I+EipxbLEy9lO+tIbXRphUIb6Zj+KzpVdG/d9L2TlSZnrC42/MKnjGXXc67d?=
 =?us-ascii?Q?1+Yn5BmMS53hdHNEqbfYG7EGsgF3sSKV4wexnx2envlwiG7sKHNpuFy3n9KC?=
 =?us-ascii?Q?xBTdOCP2MlJLC3Qkcao21HhxIaZ3pKH+42PKbcbYJZMHzO6K0uYD/NzbIk+F?=
 =?us-ascii?Q?6BbbIqjgEpZDVCNRtFGKDg5WFXJMRmEjQDXIk1LOF1x7McHLmyFa9u5LJSXu?=
 =?us-ascii?Q?RBDEmFpB8Wxs3sIUd/AROh26bje8rS1GuqtdXytXSK9i3HHRvAv0JrrpEkgi?=
 =?us-ascii?Q?NE8bDK3tc63PhrqQ7xYPZu61VAEFJQKVWacsosbMfbO7XyCFxyw0ZQgZHnDo?=
 =?us-ascii?Q?OwzOgv1cEdoOWWbQTNVVGObW8VptkCYxE1oabcRnacss9Q2Pg3G63vLarltt?=
 =?us-ascii?Q?u2apjfBf962R+DpgnQzf6qg7MniUntGt+kOGeck65eIMZabOJVwt5N9Fw3tC?=
 =?us-ascii?Q?0d2DgBF+sHa207gMfRaSNj5ZTkhgBUjuqiWmcKPiNX8WsKbkgT68Q0RJ25rd?=
 =?us-ascii?Q?x1C+5dQixPTUE3vkj9A9+f0WIr+edoOKVepKshnpIhITIZ5BKBMbCB2SMr6e?=
 =?us-ascii?Q?fpD9Sxl6C8KHByvFk5SFpc9lp+lYXvAFJDmaYyyIxmxy6Ia5dPUONVlrHP6O?=
 =?us-ascii?Q?KfKLtwst72uotjZlaBx+imFC6aCbfdpuzBc4/3y8+5WrSuFORqk35IQch/MV?=
 =?us-ascii?Q?/ondbDxUgIiNBiXTK8Ik4jUSL8idgmUwRT5b8V9CMBKjGikk9rJvidnrvNcE?=
 =?us-ascii?Q?jwBVarmRuquHyoxnfue6QUrTwTrKIuTDqbWr7S0TTELwf4kGBQvt67x5Amj3?=
 =?us-ascii?Q?JXGNTIVMLsYQvNuDRQ86Yi1p4W70BGyBM+6v+xT6jI2G2vVDQzzL9FqbNaRQ?=
 =?us-ascii?Q?eTmTPjxA7iKn/f9PbbpPBc0AGM6jI5s04V0xIfQ5iCM1cpSiCH5UdaIPVI+1?=
 =?us-ascii?Q?AiKou8nMFBtrhzfqFOIgKTandivuFUMM0LbynK0fCbM3+sG5zrZuaNr8jkSY?=
 =?us-ascii?Q?kYx4jLKUDGvnSiFk0/oyXKslxIk/I9L2PvrSvZPXD/IrrE9AWj8X0d+c5shc?=
 =?us-ascii?Q?EdSYBhcOATfNJwAumuhxcICaPiEDG7vxBptoxAqJBPfz9FljOfykoutXoreV?=
 =?us-ascii?Q?rPWGbE3GiHA5U+E4RAr6/yYjmBxsAaSAACFR1Lig+7+b1EejHo5W2WMRXX46?=
 =?us-ascii?Q?fqU3ZnUVxkV9bEL2Y6WWea+3YHBU/Ljs34ztS3+BNiNWdj8so146hnpx9jAS?=
 =?us-ascii?Q?03x2HTUsUxiCiZYBh0iuDuaakMd5gJN02cU/PO9miH+sBLr1Z2rj42pnCMyA?=
 =?us-ascii?Q?TMmlyisJLZ9mo+FCnSNNMv3gJAtd/37RBaAjsPoGQ7YIWHS1OjYILh4N93SF?=
 =?us-ascii?Q?bRRFzQLny0P2101KV1147JMyNxNQQXa6id2QEZiBPCEA7dFlbw7/VrkPIfev?=
 =?us-ascii?Q?OsGpiJE85/LgLLEFtWM3D095lq4KgrL3b3dRMkM0Ei6X0ahddDcpG2yjfSa9?=
 =?us-ascii?Q?PmXDK+30pAmle9JkbEVklpg9IjAKcKN9gp6ljofAxKKDneiYaGEW1yaaBeGA?=
 =?us-ascii?Q?LJTexPa42gBrfLPZRhmnufLLyvDveQySLRrkc/BlO2qxUtyUvulMz13tAk9g?=
 =?us-ascii?Q?O5ncRJkPM0aQfBvdponotSaS0slG73DGuvoQL7qIZjX2+2XpRoqVxCpB/CXY?=
 =?us-ascii?Q?hxpfuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1XFLZXRvB41y/F8onPv7vTRKIVY6ztXloVe6L/Z24FlbgbmpNHkBFBs4bDuIIWhl8ouniHKuRXZaSQ7fBepvq9HLmDEiosE32U/yTltVkevkhErG1tPoglSFbkJBCyrugWl/aRZtoDB9Ftmus7SBkMkLHbWS3OwpaYpx30+F9ndKo5H+o0rs1I126M8wYv49zumdHCJIidrY3zPgNLaG5KAJ/mqovFWa0ygk7WYMDBikl00BnyLYRoSQA0r6c1Bwei25pvCQyqVEg+SD+CVHXrEWH0oP2vPTqaarNQODZFDe3YhQaGrNZWmXAqb8eCfrDIazxTAjrHe3OljOaGyu8d4xwpifCUH3ln+Aw9srMcQN0QVlHavS5IxI+wM5j0OR3FeR4cywQD1q4aL60pN5rn2Xbd774t2pOqJGJU/XTrv88fH5n4stSOiujetaswIy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:10.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab363cc-bff8-4905-4815-08de68ee15a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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

UMSCH supports context suspend and resume whenever buffer
evection and restore is initiated.

Using new function format due to api change (David)

V2 - remove powergating call as it is not needed for resume
     use drv_err() instead of DRM_ERROR()

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 52 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h | 24 +++++++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 66 ++++++++++++++++++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 5a9589b56534..20e9b81fbe06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -656,6 +656,56 @@ static void amdgpu_umsch_destroy_queue(struct amdgpu_usermode_queue *queue)
 	mutex_unlock(&umsch->mutex_hidden);
 }
 
+static int amdgpu_umsch_queue_preempt(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct amdgpu_userq_obj *sfence = &queue->suspend_fence_obj;
+	struct umsch_suspend args;
+	int r;
+
+	memset(&args, 0, sizeof(struct umsch_suspend));
+	args.context_csa_addr = ctx->gpu_addr + PAGE_SIZE;
+	args.suspend_fence_addr = sfence->gpu_addr;
+	args.suspend_fence_value = umsch->ring.fence_drv.sync_seq + 1;
+
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = umsch->funcs->suspend_queue_ctx(umsch, &args);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		dev_err(adev->dev, "Failed to suspend queue for IP %d err %d.\n",
+			queue->queue_type, r);
+
+	return r;
+}
+
+static int amdgpu_umsch_queue_restore(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_umsch_mm *umsch = &adev->umsch_mm;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	struct umsch_resume args;
+	int r;
+
+	memset(&args, 0, sizeof(struct umsch_resume));
+	args.context_csa_addr = ctx->gpu_addr + PAGE_SIZE;
+	if (queue->queue_type == AMDGPU_HW_IP_VCN_ENC)
+		args.engine_type = UMSCH_SWIP_ENGINE_TYPE_VCN;
+
+	args.resume_option = RESUME_CONTEXT;
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = umsch->funcs->resume_queue_ctx(umsch, &args);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		dev_err(adev->dev, "Failed to resume queue for IP %d err %d.\n",
+			queue->queue_type, r);
+
+	return r;
+}
+
 void amdgpu_umsch_fwlog_init(struct amdgpu_umsch_mm *umsch_mm)
 {
 #if defined(CONFIG_DEBUG_FS)
@@ -781,4 +831,6 @@ const struct amdgpu_userq_funcs userq_umsch_4_0_funcs = {
 	.mqd_destroy = amdgpu_umsch_destroy_queue,
 	.map = amdgpu_umsch_userq_map,
 	.unmap = amdgpu_umsch_userq_unmap,
+	.preempt = amdgpu_umsch_queue_preempt,
+	.restore = amdgpu_umsch_queue_restore,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index 6b827c92e817..cbe1ec7363a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -41,6 +41,11 @@ enum UMSCH_CONTEXT_PRIORITY_LEVEL {
 	CONTEXT_PRIORITY_NUM_LEVELS
 };
 
+enum UMSCH_RESUME_OPTIONS {
+	RESUME_CONTEXT = 0,
+	RESUME_ENGINE_SCHEDULE = 1,
+};
+
 struct umsch_mm_set_resource_input {
 	uint32_t vmid_mask_mm_vcn;
 	uint32_t vmid_mask_mm_vpe;
@@ -117,6 +122,20 @@ struct MQD_INFO {
 	uint32_t vmid;
 };
 
+struct umsch_suspend {
+	uint64_t context_csa_addr;
+	uint64_t suspend_fence_addr;
+	uint32_t suspend_fence_value;
+	uint32_t context_csa_array_index;
+};
+
+struct umsch_resume {
+	enum UMSCH_RESUME_OPTIONS resume_option;
+	uint64_t context_csa_addr;
+	enum UMSCH_SWIP_ENGINE_TYPE engine_type;
+	uint32_t context_csa_array_index;
+};
+
 struct amdgpu_umsch_mm;
 
 struct umsch_mm_funcs {
@@ -132,6 +151,11 @@ struct umsch_mm_funcs {
 	int (*ring_start)(struct amdgpu_umsch_mm *umsch);
 	int (*ring_stop)(struct amdgpu_umsch_mm *umsch);
 	int (*ring_fini)(struct amdgpu_umsch_mm *umsch);
+	int (*suspend_queue_ctx)(struct amdgpu_umsch_mm *umsch,
+			    struct umsch_suspend *input);
+	int (*resume_queue_ctx)(struct amdgpu_umsch_mm *umsch,
+			    struct umsch_resume *input);
+
 };
 
 struct amdgpu_umsch_mm {
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 60d1fdfb2af5..c1e47ea8e82a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -411,6 +411,70 @@ static int umsch_mm_v4_0_remove_queue(struct amdgpu_umsch_mm *umsch,
 	return 0;
 }
 
+static int umsch_mm_v4_0_suspend_context(struct amdgpu_umsch_mm *umsch,
+				      struct umsch_suspend *input_ptr)
+{
+	union UMSCHAPI__SUSPEND suspend = { 0 };
+	struct amdgpu_device *adev = umsch->ring.adev;
+	int r;
+
+	suspend.header.type = UMSCH_API_TYPE_SCHEDULER;
+	suspend.header.opcode = UMSCH_API_SUSPEND;
+	suspend.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	suspend.context_csa_addr = input_ptr->context_csa_addr;
+	suspend.suspend_fence_addr = input_ptr->suspend_fence_addr;
+	suspend.suspend_fence_value = input_ptr->suspend_fence_value;
+
+	suspend.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
+	suspend.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
+
+	r = amdgpu_umsch_mm_submit_pkt(umsch, &suspend.max_dwords_in_api,
+				       API_FRAME_SIZE_IN_DWORDS);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_query_fence(umsch);
+	if (r) {
+		dev_err(adev->dev, "UMSCH suspend queue: Failed ret %d\n", r);
+		return r;
+	}
+
+	return r;
+}
+
+static int umsch_mm_v4_0_resume_context(struct amdgpu_umsch_mm *umsch,
+				      struct umsch_resume *input_ptr)
+{
+	union UMSCHAPI__RESUME resume = { 0 };
+	struct amdgpu_device *adev = umsch->ring.adev;
+	int r;
+
+	resume.header.type = UMSCH_API_TYPE_SCHEDULER;
+	resume.header.opcode = UMSCH_API_RESUME;
+	resume.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	resume.resume_option = (enum UMSCH_RESUME_OPTION)input_ptr->resume_option;
+	resume.context_csa_addr = input_ptr->context_csa_addr;
+	resume.engine_type = (enum UMSCH_ENGINE_TYPE)input_ptr->engine_type;
+
+	resume.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
+	resume.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
+
+	r = amdgpu_umsch_mm_submit_pkt(umsch, &resume.max_dwords_in_api,
+				       API_FRAME_SIZE_IN_DWORDS);
+	if (r)
+		return r;
+
+	r = amdgpu_umsch_mm_query_fence(umsch);
+	if (r) {
+		dev_err(adev->dev, "UMSCH resume queue: Failed ret %d\n", r);
+		return r;
+	}
+
+	return r;
+}
+
 static int umsch_mm_v4_0_set_regs(struct amdgpu_umsch_mm *umsch)
 {
 	struct amdgpu_device *adev = container_of(umsch, struct amdgpu_device, umsch_mm);
@@ -431,6 +495,8 @@ static const struct umsch_mm_funcs umsch_mm_v4_0_funcs = {
 	.ring_init = amdgpu_umsch_mm_ring_init,
 	.ring_start = umsch_mm_v4_0_ring_start,
 	.ring_stop = umsch_mm_v4_0_ring_stop,
+	.suspend_queue_ctx = umsch_mm_v4_0_suspend_context,
+	.resume_queue_ctx = umsch_mm_v4_0_resume_context,
 };
 
 void umsch_mm_v4_0_set_funcs(struct amdgpu_umsch_mm *umsch)
-- 
2.43.0

