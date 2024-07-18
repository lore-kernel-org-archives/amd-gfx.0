Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5901CC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AB510E8BE;
	Thu, 18 Jul 2024 14:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y+qyIUO5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C5C10E8BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDW1/8Dee1rtatCDg+0eXvU/smRJSABJf3QB69XxWMINeQVdVeTDAffv03Jj5UF5l54KLey3b1xpIcgvfrQKvZBpS82/vnTAbF9NLMdSa2+XShrEqyeAC0xBDGqK3OZCMixOENcwQQ1F0pY/yjHtenJIRoYbm+dqJNmJy0u3hSGYwYwPV1cn6VGSPzOMYmlNsKySUy10l/4+kHD9RdRveW3qY5DVr0HyTAzObDMBz81I+YNY7VIZAIQ1dlSCVwblWc4dHJP+W+/ddUuiKnpw4KAfXeVp5pAbE4L7fG4vtqcPaoeskfjvxqxm06yFcMFOUeStyCh9QX2frIOZLOg5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgt8c5Z7jM2GWj8ruyVv07L4ctbt0quT2lBE2j6h0hw=;
 b=WHzntMTQQ+eU4q2ASE+OB1t633E5JCTsKESH2V4oX3X70N8WqjHCtCne9cAeLyyb02J5ZTrh5mGk3df5OB3e/PedpsmvF6SuyZVhvOYsyquraZ35QO7b7X745LdzccpGnWGus+wipdqSkh9tA9v67Ge7YP336WMX3l9JoNBw0dTi6E639MDPbOY1SnMiC4FPuwBrd190zwp49AjHW5lpDq9VEUFuB3BSqG/oHXBrZ4tV1HVKRRZAra5+b01wU4BqjjGBP3ENOjf6YI24XaxcSsC3H72fLaNA6Jh0PGKT8ubcN7sqywJJ7D3UydqN7iDYSTyP5ggPSrRjNivCn26f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgt8c5Z7jM2GWj8ruyVv07L4ctbt0quT2lBE2j6h0hw=;
 b=Y+qyIUO5gi9KCYSSlFfMISWlaViwEvmnSkvYeVxkKUBKjMiCGH471wJEQEPbq5iMPEggaezmYH1bkyh5xxncYd03o1DUF3X1LcNDZ+h+GdwyqDKNAC620Yln+RrzIH6DdkCpLBRKqHAU0hocM3THVBvYAua3KLZsSjOZoz/Q7Ew=
Received: from BL0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:207:3c::40)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:07:55 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::20) by BL0PR02CA0027.outlook.office365.com
 (2603:10b6:207:3c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/34] drm/amdgpu/mes12: add API for legacy queue reset
Date: Thu, 18 Jul 2024 10:07:02 -0400
Message-ID: <20240718140733.1731004-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 160f924b-6302-4ed8-1cbc-08dca7330492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r3gmVXaw7AZL+sDnOtRNCghRk1BhCitEB/nfclcdEfVljNrgvt0dxEb0XUDx?=
 =?us-ascii?Q?eNPlmvnzr/axzvI/8AgVA52LCBEhZBg4Rk6/p5C2AfME0nOJl22GhNcFZUil?=
 =?us-ascii?Q?nMlEb4lgFZ5tbbC04KIuOMZ+DYJY1f0cA6DzI46oGLaXZ30yqxcGg6eiqpEU?=
 =?us-ascii?Q?0IRXF3Piv+TuegaCCtrV1rvI9T3+GikafRGmuiA7xkQ/b8auVoKp7kyx7mrU?=
 =?us-ascii?Q?J9WslD16EwfdTjukwoHT4R//CeLpbM+Vk6ofnZ8hWVGKt3EzTn0unBdKS59F?=
 =?us-ascii?Q?Q4WuLUNd2UYHL82Z4z7ScwcjHLKLBK/YewCC4Bfm6x2YwTmLJl8LA3uJ9Fho?=
 =?us-ascii?Q?T/A0FcObHBPZHSBsvGztO/943LfskkIyyQCiBw4PSn9u7gYRyhj07x/PoQ4Z?=
 =?us-ascii?Q?6bplZBuU5unCVuQVAAycO6++kaiHNL7uMA+gh6Gq2RXWYg18/js5DUGWH7N/?=
 =?us-ascii?Q?18nrHKDeTWfQgWYe+wY6ETv9Cmd6ug1pzGW9W50tKH+M321AyWhH1f7DEkGU?=
 =?us-ascii?Q?TqqN7CFMht+BB7xQUWwZ3aeCMQ6LdpfD0Wb/tiR7bUBBa0+ZUUZLgQo8kNu0?=
 =?us-ascii?Q?MRBNJBjrmVxs7H0rTFqD0KQL4xUVoR/q5luqiBk63cD9sgt6vfU4uP+GQ0ic?=
 =?us-ascii?Q?IwYsz1CMuAgw0nJxC3t7hGXl+3CkbFwqwaVji+5JcPQX3pKituuNKDUyERs3?=
 =?us-ascii?Q?YvltIa5fXD8pKac0QZiBfaqQOoNWENVEbAeSDf3dUG2MiHU1XyO6zuML0Bdc?=
 =?us-ascii?Q?dXe6ML/q9qEXcv/tEEZFu0h8NMPIC5RJwa3AEkuYnKgUnnaxVxbFC3XNN6G1?=
 =?us-ascii?Q?tfC36Kq9vWbtj74/ucIF416HXJWMJGxzCGZ7BKi0vJhtw8mSnRWdQ9WjqXWu?=
 =?us-ascii?Q?cvbSLtKjLfbAK3i4nGTFOL2+ljrfG18vTq/bUtqyTSCS2lloE5TO2TD2Q7MX?=
 =?us-ascii?Q?TjWPmcu7s2aZC3KTiiDWpN5vsj0cvVSq3U3S18aY7zNNoYvRGvQaruy8AcXx?=
 =?us-ascii?Q?UTvbOdw1wkxlH+trgU1BCdd3Hg320b8zjm8+MuABo9I8DmMC2nmiuZTRI6yb?=
 =?us-ascii?Q?y4xKwLjbKKZfH4KG98/4QTNA/2DtujwZ3OLrBgblhqBlA1KQs+sB01f7wkUa?=
 =?us-ascii?Q?cwCVLnwRZrYZpZwa+PREBmSxx+fOVHYJkibLjjXSi0mXcz4tCTLo6K1B260W?=
 =?us-ascii?Q?tWqkB3XAYLdtmye7Aj3TyRlT1sUC0QbbDISwlxVw9gO1LJ1oDoVHNv846Klh?=
 =?us-ascii?Q?eTkAId9cyfRpfHGQ5sCwI0/FfmriMPLxL+QfbQun09JgFVwsQczCz13mfV0A?=
 =?us-ascii?Q?kvjbdHKDgDzrCFp3vB2X4LbQsRZ8qAsSb208CsTZqf0IPcdEAYcP+TsiOqUY?=
 =?us-ascii?Q?q0006MN3kZxGkEQE/9QfrCr/eXO8JBJlaB9iCqEUsFDalfP+DlNDCN/xd3Nr?=
 =?us-ascii?Q?0PFYYadwB0YNwGXuQRZoeNaHwa6WH5Ew?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:54.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160f924b-6302-4ed8-1cbc-08dca7330492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
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

Add API for resetting kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c9f74231ad59..14b8c88fb0e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -634,6 +634,38 @@ static void mes_v12_0_enable_unmapped_doorbell_handling(
 	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
 }
 
+static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
+					struct mes_reset_legacy_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+
+	if (mes_reset_queue_pkt.queue_type == MES_QUEUE_TYPE_GFX) {
+		mes_reset_queue_pkt.reset_legacy_gfx = 1;
+		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
+		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
+		mes_reset_queue_pkt.mqd_mc_addr_lp = input->mqd_addr;
+		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
+		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
+		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else {
+		mes_reset_queue_pkt.reset_queue_only = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	}
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -642,6 +674,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.suspend_gang = mes_v12_0_suspend_gang,
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
+	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

