Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15379D637B5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B18A10E895;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MI7hABCP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFCB10E88E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udA60f5a+9KtemuLVgD0ta6nlMcBypT0t065ZtyaZ+30RX38pZ2HgvP2D8PaMbM3b/GCnAY/LEqP4trPA1HxVOKagilNxZw+JWG5krQ5hRH/J2UTuXBt768goE27KbED/M7nF9khI+nL8rhhYjM5chOkwMzGGG7X1uoGTEsWT6TsEE9Hc1gev/Avi7q9Hr0HZwM42aG8RV/RSmIOWHkY4rFhe++VJZifIqrRSYkt8Q4MLW96CURoGoGQFcRebUtEXENK10pWgbemW7ysHTMNI18mXsK7CBHAK0U9U3OjfkbAglOEQWeEEeT0RxqSm61wdR2gvFhF3DQQV1qCbfDG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtppLAUjC7fK+r2hw+HeShOqWW2Jn8031EdkA/0fWFk=;
 b=Hs31Z0Kkpe1UskiAtISQXs/R13IfZKHsZCyBWcv+VQDE5ODEmqFNIKC7lG5Y3AHNCOmvVJRkmGWFepWfwHGkn+657FJMXBYwLKUSdxoG/YnEV8SSN67tzIlnfSQKNMywNv52SUyMjudD11pMHpy6mugUfDnepoooRmbxfbrOs4+8dyEz5m0CTa/rEP4189CJN/3ngRPb62lGPCgRdlPdme9bPxIVtCslW6/xt69dC/D198JOSbbXk+UJC0k+JhDTW2y3v8PxUqKfxgbrn9fu1x6Z5GbDDiJfSmxaTVqRCZg2FnF9DsSIzDFNnVYZTA4zferFlotz/8u3FYeMtqAIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtppLAUjC7fK+r2hw+HeShOqWW2Jn8031EdkA/0fWFk=;
 b=MI7hABCPf5s9yIp4YzYS6q4iPeWAcimMOzOY+a0OCbEpXc9gN+fzj9g8mE33hfjp96Xl77SM7Kd56rAIan2aRg/IEQS+7NyuAhqurxCghITDbhwA1hesYuP5x5aRDUvkX2TTSObhMcWbnRyYjuKE9xcB3RYf6RFEHPqY32UYQaI=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:12 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::5f) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:12 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12_1
Date: Tue, 16 Dec 2025 16:03:40 -0500
Message-ID: <20251216210349.1963466-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 020f4eae-25ee-4340-2469-08de3ce6aa05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+jK7SY/jVbjoQrd8MvGmEMUrytKHkcHSDUo5wCIzg7hLK5kb+MXYQ2Fs4sDI?=
 =?us-ascii?Q?yKbLGD8EBoKB97UgcvK5ueeiGKQlsaQ46o7Bgc1ro8TdRq0ukBSGdkDKC+wU?=
 =?us-ascii?Q?03Bjbh6l6XwiHZ8Wgumm5TlDmX1CwCY8MWSnNH3i42pR5rFs2GGXMb1TKTgS?=
 =?us-ascii?Q?ZU5VPo/+SmviXkmMqrelHdBBJ2S3qlL3KuQ19/f0itn5tnRlgLjv6mF3BQXj?=
 =?us-ascii?Q?acGGdv7E4Nss5AgUUeGO0QPcuxJE+ZFbkcHzT9T3b8Y42yyDpzYZv2j1BRNt?=
 =?us-ascii?Q?P2hfc8nR0/GleLxS1EgcPkJREezoS9ZOm0W27obBAPB9Ssce0QE23nLXyScM?=
 =?us-ascii?Q?QxHZhYb9fSEEJm6RHjx1C2lrAEewS2xwLFZVmuwYUmJVFOuPWf41ddiAmb4f?=
 =?us-ascii?Q?3q3eGxaOOMqdj7GgPt8cDEM7PMYMJxmhBCdyc8da6AiHbz8QNbTkb+LC8A7s?=
 =?us-ascii?Q?p4J/9Q1QBx+SBk0VBQ1OipmiBuO3Mp6phFsYT5LRDvdGFnJJLsEnKrDdnLQp?=
 =?us-ascii?Q?Nyfpb2roUKzR7tI4KX1NHczRgVQr6/rYBy2uJHqMKKCbayOSHuM8w7Ff2n5O?=
 =?us-ascii?Q?mrRYBZvTGzsohLl2vBe6L/za5mNTQIqd2XDTPW73YZYl/pu/QcjJADPGYcWh?=
 =?us-ascii?Q?iffMI2EwNNOxYU+3Ov6vDwksBpOApcVBnHO9uVVZIiTIJciIv0D2VXADC5GA?=
 =?us-ascii?Q?g3g83mGWfDoFsxDaVU4BZIgwXB0UL5VzG7a23kHIJqAHgaAxr1w9xYXEr9WO?=
 =?us-ascii?Q?BZUFn+FHP8w1p9Od4jbz14ZH6K2/TlGYb/jqVg7yqTZyvDSSPrARwEuYfjOQ?=
 =?us-ascii?Q?LSkdU02XZp2fKATSlPRws3U51kath5rBzHC/tyOIWAfXP9Ih72DVYlIN30km?=
 =?us-ascii?Q?v/QSUb+5AvgYkCWgp6mxYyyjdleZMBNmyKszx89uuDs39O0CVmQvcMF1TQ80?=
 =?us-ascii?Q?7Io2R38IARYJWLrZiFQlhEdAuMMCXG2iq4I0rwPkbyQ9cAsYD4sWyOSfk68l?=
 =?us-ascii?Q?5HIeT1zq87EFP6DrtFJ5y0Fqh0vgqQ4S76IpAv05Gv0Rlr7XDofZoT1Yr41r?=
 =?us-ascii?Q?Pp5OYr84HDfdt2AH7DitU0kP2jqHcd9sO94S/FHwcEXckQEe/P9F+nlovANu?=
 =?us-ascii?Q?ATQKs8PTNfzvpX5l8AjU4/4Gc4vdlQ8Ed+SgZ+nLCTYbRuUhoLVuZdWXgrvx?=
 =?us-ascii?Q?MzPQexed6u7AnrxzEnc1mwPTrYrO4EJfpRkK+izvGhYGH0IOChH/v0QDKq2c?=
 =?us-ascii?Q?SRQ2ljnKTLQtCt7KBHe94CCr+UWPP19r1FZJH0Ft38HrZl5+1VUK9CaA+kWm?=
 =?us-ascii?Q?vFt1CehSjAvadna5xQhBN5oHwLjBYxOZspkqGg+c17+fIy+aUvRjSV2e+D/D?=
 =?us-ascii?Q?8h+0wJ6oF+Eg6P7eYCIq/wM51a+44JyFoG6cmckTqvVOhG4QZnR9FJjanBgM?=
 =?us-ascii?Q?yekVJCbhCtYt9NaHvrJkxReTerU4tlaZ2tJGKLmM3tRvtFtSCFICFrTr/KiF?=
 =?us-ascii?Q?HJg4ncMZLWWIZbTqFsfzD3YX965VsWOARjkVZVc+/gOhQHTovcjgcJYA+qF7?=
 =?us-ascii?Q?r4KvsoBbdUygaizVNIQLcVy4JfW5Q/M0EtJNvuWm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:12.5359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f4eae-25ee-4340-2469-08de3ce6aa05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 28 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 50 ++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index d32e88cace6a2..ef6e550ce7c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -369,6 +369,34 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
+	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f) {
+		struct mes_inv_tlbs_pasid_input input = {0};
+		input.xcc_id = inst;
+		input.pasid = pasid;
+		input.flush_type = flush_type;
+
+		/* MES will invalidate hubs for the device(including slave xcc) from master, ignore request from slave */
+		if (!amdgpu_gfx_is_master_xcc(adev, inst))
+			return;
+
+		input.hub_id = AMDGPU_GFXHUB(0);
+		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+
+		if (all_hub) {
+			/* invalidate mm_hub */
+			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
+				input.hub_id = AMDGPU_MMHUB0(0);
+				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			}
+			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
+				input.hub_id = AMDGPU_MMHUB1(0);
+				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			}
+		}
+		return;
+	}
+
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 17d7b1731b9ce..7b8c670d0a9ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -108,6 +108,7 @@ static const char *mes_v12_1_opcodes[] = {
 	"SET_SE_MODE",
 	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
+	"INVALIDATE_TLBS",
 };
 
 static const char *mes_v12_1_misc_opcodes[] = {
@@ -854,6 +855,54 @@ static int mes_v12_1_reset_legacy_queue(struct amdgpu_mes *mes,
 }
 #endif
 
+static int mes_v12_inv_tlb_convert_hub_id(uint8_t id)
+{
+	/*
+	 * MES doesn't support invalidate gc_hub on slave xcc individually
+	 * master xcc will invalidate all gc_hub for the partition
+	 */
+	if (AMDGPU_IS_GFXHUB(id))
+		return 0;
+	else if (AMDGPU_IS_MMHUB0(id))
+		return 1;
+	else if (AMDGPU_IS_MMHUB1(id))
+		return 2;
+	return -EINVAL;
+
+}
+
+static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
+				    struct mes_inv_tlbs_pasid_input *input)
+{
+	union MESAPI__INV_TLBS mes_inv_tlbs;
+	int xcc_id = input->xcc_id;
+	int inst = MES_PIPE_INST(xcc_id, AMDGPU_MES_SCHED_PIPE);
+	int ret;
+
+	if (mes->enable_coop_mode)
+		xcc_id = mes->master_xcc_ids[inst];
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
+	ret = mes_v12_inv_tlb_convert_hub_id(input->hub_id);
+	if (ret < 0)
+		return -EINVAL;
+	mes_inv_tlbs.invalidate_tlbs.hub_id = ret;
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, AMDGPU_MES_KIQ_PIPE,
+			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
+			offsetof(union MESAPI__INV_TLBS, api_status));
+
+}
+
 static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.add_hw_queue = mes_v12_1_add_hw_queue,
 	.remove_hw_queue = mes_v12_1_remove_hw_queue,
@@ -863,6 +912,7 @@ static const struct amdgpu_mes_funcs mes_v12_1_funcs = {
 	.resume_gang = mes_v12_1_resume_gang,
 	.misc_op = mes_v12_1_misc_op,
 	.reset_hw_queue = mes_v12_1_reset_hw_queue,
+	.invalidate_tlbs_pasid = mes_v12_1_inv_tlbs_pasid,
 };
 
 static int mes_v12_1_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.52.0

