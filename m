Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75854C3ABA5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1B110EA6E;
	Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvnA7X8V";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA73510EA6C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxFpsfSgjfzttsaLY42catiG8tCJLjikhvwDDMUVaCr8BZLZ0JcwKTNBlzLqngIVg3RuNiFNojqP1f6u/tz95laETICPG+sXOVO6YfiOTiRgZlKOXDaTRrc2AJkghR9L0uK5nt4HDYp8sUqNYNQhSilhfASCK1Q9utQhArl0qzSJCs8N0XSxc5zOHgNIQimZ1ColDewhJLibO2mwhBAOVNNh3ESjUrrD3ewKOlQIYnBBzLn74aoA5PzanKQjcMla90h8/C2MhqbMer1BFvHsNR9Bgp4mvCOIUEEE7VHKDBQKS9T5QuHh05QjjXKRX/kNySeGb5tfx4yXvfGM7mMOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB289UFUYZO93ZvyLV5YzRIRrYFtZlzUzKdmTZ6MivQ=;
 b=cVKglSmfmCT51dKE1mg07AUnUeXcL7WCBnf48UIlKoONvop0dE7mOKJAX1PUZJR3fGTQmFxy18CNgSdsAHbHUmnjzfwLQ1h/KG2rfPaKbWsnRbNn7Q6vWHeJi8Xze7mR6U8ZQDOR1TyPCoEkCeyWfrPvjjyJQObPnB7ZE8Opuai0CIC4kvEA0lfuSAWXfgGtw1uuMBy4EQWPeuVfDkcB+koOgGU/mORNnexw1bjalUf6X22BulEIYiLmoaUjfFPhl6paRr5hDuNkCig2QA2SzxZ7NxKrf8zGMtqb4z31I+THBkbcoKS03+q+6LmV0ZrYG3TndBF1Bw0yh0vU23dQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB289UFUYZO93ZvyLV5YzRIRrYFtZlzUzKdmTZ6MivQ=;
 b=GvnA7X8VhyPnVBLNu0SR6TDcVQb9bLmj9i/oFX09ENxOE0ZqKInOkUp0XVrj2K1vUc5ji19ozBqOJmUOrcYElixYAoH1gSHeZFtppG1zLYASG9GDchQtkoDKz75g5v4Wf+4dzo97DNp8/VDdqoIYINWniif9atnk6hzsE9yM4M8=
Received: from BYAPR07CA0073.namprd07.prod.outlook.com (2603:10b6:a03:12b::14)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Mon, 28 Apr
 2025 21:21:12 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::84) by BYAPR07CA0073.outlook.office365.com
 (2603:10b6:a03:12b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Date: Mon, 28 Apr 2025 17:20:47 -0400
Message-ID: <20250428212050.1098434-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: cebdeb1d-a088-4bda-5bd7-08dd869a99ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCXiuJ1JtYMEFTvCY0puPWXq6Um+wTOzCznc8bhNGu4Kh11YavOTzNvl8bUh?=
 =?us-ascii?Q?iCSHjW7Isi5Ma898eBYxSMyhOgYtPxg3DHRQioy6O5ALaHZ/817FxsE3FAsm?=
 =?us-ascii?Q?lqJGyBGhxSpso3gQCoucIi2GSZ9kbJNFxqyPVry+/D+dUTH+RTpYA5Fs26jw?=
 =?us-ascii?Q?rtp4DiKqcgGmYJVg+Bl1E98MZPOHxIbHHhCwrnigQmK+yV21REfVsEYKLyug?=
 =?us-ascii?Q?KwLiIfTHiI9p/RPQ5uB+15WvTMajzQl9tGlqJjeo3e8wDISKXRvJBIW2bnE3?=
 =?us-ascii?Q?5gO9vE8WbFo06xbi8VHd0IEa+yhFv2m0z/YmJHTRyciNqsWuYOTl0JYN+zUO?=
 =?us-ascii?Q?Kn0GOrdAmEdIb9jg6FM2DmilfWOjeusikEvMhMNIeV2HUd+QPpNQMUx3+aJD?=
 =?us-ascii?Q?UulM2yVYWVkcRA+Ditjjf2cN/8um5CUMPPS2JIRBqozQEVKlOds+4QcxeUBk?=
 =?us-ascii?Q?iofqHvFPU/1JAUZ24EC11SI8DhahOvg4Z4cs27KTabjHYHBgS1Z/vTTJUVFL?=
 =?us-ascii?Q?sX3HkBzuvx+YsZrYnOBXXOZT8mVAu2u/uGZfXU7FBx17QU1G0YocwJqpxHXC?=
 =?us-ascii?Q?wiW5hdo9KWc2Cw0ZLxoS0qdL9pix2HYyzL4qeHd4HI4696TfT/Q1dyjql8zO?=
 =?us-ascii?Q?zWisLTLsXA9M/d16IrqZFek9neO7wk51hr+A8Ii2YZaCEtZm2C4w0EJ7zLU/?=
 =?us-ascii?Q?q4UxYCOfl8rtd7l7ctrEPdS0/n1y40NqEzvYIMAxsEYjzMWiET6D26+9zKaG?=
 =?us-ascii?Q?9LVcyTKcvtUbgV/yX1qdvSxWt1z0y4TcVXsm8YkwyOolZ4OUv9Ujn+Xvklm5?=
 =?us-ascii?Q?mznzQFULtJ95H9TN7KNYhOZ5XMioTXK5PvGxcW4NH0vk4Lm4vdHtcluopcFb?=
 =?us-ascii?Q?EDQ2qZFCQT7bi6oXqP+cssn2Dn4vuq2JshO9RcDOXrS4ip7uRhlS833Hv5ob?=
 =?us-ascii?Q?KXnm+GZTLKsBvrc1GEW28r5dpyLCH6TTDe7t/55eH0O5KHo5Bg58b1uaZ50r?=
 =?us-ascii?Q?X0V1mXecAxT+qSSeje+cveuMGhn/X5dimvu35oJe7kQc1tLFJRblwcwxuNXg?=
 =?us-ascii?Q?4bcCPrg2/21u1wvNEtRc93H8s+xnMWXsY597Zq6MxCIzXKN3qcoWAyBY8Nzx?=
 =?us-ascii?Q?dPCZguY1vGUzBMdG4eucuCfnttah8sJD+OVKVYTMUa9nLJJnalYzCaMaE1ni?=
 =?us-ascii?Q?HBEQJvq6hUvljsrzHkf2kYntxDkJmoWxE0yJpRrXVOBhgHnTVYu+/rbVs3UP?=
 =?us-ascii?Q?p2eCiJFQZ21joo8bdk9U3bDEbxwJqwEFi8RZhxVqt0NnfqHV6BcFfjujgH+L?=
 =?us-ascii?Q?Lj05cGeA4ELal0DvquCY8xU4PGoCjB3ief/kI8UaKrUyMolDVQR7W2TmpTga?=
 =?us-ascii?Q?HNgQh9+V9+dBQ5rLBUE6EMrbzm2m7kdSml9qVJMgzwcv6cYmhMQ40eN8ZBhf?=
 =?us-ascii?Q?umC774xcCnMpqecKPsgQV0n9J6RV4NvA5dTNEQhZHZ+pVoiqEjEVnqIQ1oQx?=
 =?us-ascii?Q?WbWxIudT6kzaQKGx1+hAuAZ8vCl9wMhqaoaj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:11.8593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebdeb1d-a088-4bda-5bd7-08dd869a99ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f9f2fbc0a7166..57d8b78210f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -879,6 +879,33 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+	int pipe;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
+
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -888,6 +915,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_hw_queue = mes_v12_0_reset_hw_queue,
+	.set_gang_submit = mes_v12_0_set_gang_submit,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.49.0

