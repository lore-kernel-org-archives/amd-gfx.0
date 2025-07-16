Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA6C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6BD10E7A0;
	Wed, 16 Jul 2025 11:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VheEeQ28";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90A810E7A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIdQDUNkrIuLFq8yUAuoZXUGPnzBxvRSHqHrqPN9qoHm9yQ3UMdVAkluV9tXxeKy2M8fnPlxRiRiotY9prs2uJLS4yY0jAA0MdBXsHXHSshEGJW65eCz0WVaXithp9IK0k2Hc6u54spJX1phKAGSuNNx/6ddKuKnOMmwuhhQ5oLApH1ppg6hx+UFkDFqpyUgtnJz22MyoFS04A6fFkkIZm5URQ8bE/VJJV/H+JVtfQgqhIVEdEbevrbxx09ayseEvCGPpVVYhCW1Y05uYKynF+citeAHZT/BR2wnOo13mTPT/pw3wLn1FgSK7LAM90O5oPAVa4gsdjWCrWrSX7/sfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSf2AlKbHP0QOC66askqyIcUHE1jk960p/IzG4AnAFQ=;
 b=uO1RQD1U9qWFYKQ/R0qKNcAz2lV0DZLnAupZizveeR5l08J6woCqJ8AtZDgyf1iUSAy7xRfU4+ggFORjMy7BECfCGStJavrT6WPHyOjUZizmx8le2lFPPXxi+lxHXcxAwefr6hrP76aHQdmB42mAqhoWav4+OwZ4Zc7D7EpCPMD6u9GpNDjpBssFfW6dLCvgw7F3M3n1WlNNmWn0/zPIw+eGYuY4F1y5sJE3/ZSvWyBjjJSgrdWdO8tX+oPjr4cGINHjwW1x6pmhLZHjLscsAilDdB0u0HkcoFCsWis/nv3xtRPZ55zsL1+16krXlyXAh+YHYF/lLM4xhYe4QRq6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSf2AlKbHP0QOC66askqyIcUHE1jk960p/IzG4AnAFQ=;
 b=VheEeQ28jDdXb3uSQQWQ6MOTLfgT3PhXEfbOBEeqDIZhTq4xcfI8uKrmrzqQztegdbPPFfl2VQMW2gAVBPw41l/3J8L/RzafGzP5oekPn+c7UP1wxTjNFHM+t6/CG8bYe3Shb2l3rxliEHu4T2pNmCqFEo/s0IA/+ECFvabDevw=
Received: from SJ0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:a03:3a0::7)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 11:00:52 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ba) by SJ0PR03CA0242.outlook.office365.com
 (2603:10b6:a03:3a0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Wed, 16 Jul 2025 11:00:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:41 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v4 09/11] drm/amdgpu: add mes userq reset callback
Date: Wed, 16 Jul 2025 18:59:29 +0800
Message-ID: <20250716110011.1670654-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7966a4eb-c781-402a-10c6-08ddc4580778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2rbyG0c1mvKewwZMSFnNqe9RdqQnh/HwNh6oivSH+tcHBZVdDi6k8i7Dr5U8?=
 =?us-ascii?Q?KTU1690+tLg7IKDH6bq9h2z2SGIvxNsAY4RxETwu230S2BXzYlLo/vj3tdqf?=
 =?us-ascii?Q?m79JTBVTqX7UO7VVSp0D81uA2HUAODsAaEU759Hq+WobcxHz5BiMHao3mvD/?=
 =?us-ascii?Q?AHXHltRH3SaJRB/LA71wfSaSw6UnDXTUdgKjMuJJGqChk6+Ly8DFb/0aOWuR?=
 =?us-ascii?Q?tJeeHFBjDIAxZ1lizMMKLnsPlnM+Frod/ZVoMrBhseYKdoDgRQMd44+5Unks?=
 =?us-ascii?Q?/D8Tm2/4N7srnxfhGt3kZ6KAzZt1X2TKxxcSn3e48QbswqZj9egGxDxf+pNb?=
 =?us-ascii?Q?6+Lm2Iq+sIQTzTMCmLj2nYEQs9q65MbQe2MyIFpizaXtqHk8hLQIWzf/DEYS?=
 =?us-ascii?Q?VgdzCSp5O3Q+ZP7oIA9189/wG51DpAyT8Xe+gaGGmhlZsBauhbJ4ldUaqXVj?=
 =?us-ascii?Q?BN6ER9MPVJEh/0j0TCEDLBmt5ezXKhRslhciIASZGYfHhZLk4/cyK23LnAP1?=
 =?us-ascii?Q?rIFk4lR8YGizufD/GjrR3caHomUKdlqF2If+ZCf34zDrsIrEod7S/OuPr7rm?=
 =?us-ascii?Q?4VC/H0RxaSdmHwJ7yA+emQsLLboXlOr+ZDAE62JPhNOK7BgT+4Ucs6OS8GtL?=
 =?us-ascii?Q?DgV1YFnVe/uevJgYshkCGALz5d6aA/9n8bE2MjA+czNVUY0NqPpVD3FvkKsY?=
 =?us-ascii?Q?YCzVMtX2wZVM1waN7sEOIctBhGumMh88/UZNA3/wo1UAwRaxleERj7MYW7Ji?=
 =?us-ascii?Q?xO/yPd4lsCdbQWSpVqKMtQY/fIXjgDmLG08evdNf7vpciPvfSIEsGa5NE11+?=
 =?us-ascii?Q?5TNeqVfIQR93kMX7Ghadofz48NtROOB+CQfIj3/nA6MTfX4FXPsHcOGNO1aV?=
 =?us-ascii?Q?5GlgxOGWhFcgGu4MN1K7Tr4Wqp0Dr3Y8X/5bTCJ3UTWwP7MQveGVqZVe2Jdr?=
 =?us-ascii?Q?ygg2YOmqblMk/pP7NXLHJxHkrZa+Ax/8SHdMDacU5cV3Xe2UEuc0J0ilQmdV?=
 =?us-ascii?Q?E0rxGI3767tPcJ8YbK1QO6jyBN8aWBY1CfmWuoGW24Sj24NpdG26zMFle9ku?=
 =?us-ascii?Q?c07Fg5cy7AoLb5UK658go/frn1Qhv/AgheIwwRyOUWS8S4Gib2aVaEuUy5ST?=
 =?us-ascii?Q?a9nbGP0zI4EqRRJC2Xk9II55Q+Y6yj1pv93p2m2XFArQ8mbqRzLff+aqchiA?=
 =?us-ascii?Q?sfjbLZ7vcwLZwun4UIKfVIf9RxGVdnQ96zzq/pPg2iht4vQUdmLr9oujotma?=
 =?us-ascii?Q?O1Q36OJCwRHoatM3yEsUImA2GDZ+TuH+uUc9lAGSXQjnKWZNCa1u+j5loumK?=
 =?us-ascii?Q?mEteiuKEocPjdP66SDAgwfC/D3AHzgAXybClmBZda12QKG5qLnLIS9snw6Hg?=
 =?us-ascii?Q?NJLSRxdDaB0EtEfJqVCceQviSx8SXEeJEfmKOVm4LxWADT0aHCPx9mnj2hFd?=
 =?us-ascii?Q?TsDF2wWZOu6zPnvVW9xuKguFnCtDqSR71GOQcrBK65gaJJEVA7zgGuY6u6tW?=
 =?us-ascii?Q?Xy05/wPxE6HO1OCDTeQc/bM9HPliA1CiMhhx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:51.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7966a4eb-c781-402a-10c6-08ddc4580778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

Used to reset a hung queue.

v2: enabling MMIO path for compute queue resets (Jesse)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 64aa749c58c5..3bcd1b0b3192 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,36 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	struct userq_hang_info *hang_info = &queue->hang_info;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+	if (queue->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		queue_input.me_id = hang_info->me;
+		queue_input.pipe_id = hang_info->pipe;
+		queue_input.queue_id = hang_info->queue;
+		queue_input.use_mmio = true;
+	}
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

