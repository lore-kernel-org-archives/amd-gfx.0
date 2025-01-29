Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11FAC0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE1310E72E;
	Wed, 29 Jan 2025 03:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ttFGRe5o";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1FA10E72E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoVfaIQE+N6t3ftSbHcmR/0v/8ZzsPmYuNW96owhYp9x/Jr9jFJBD0oPCBrnPbU8yQN7YLBmbdG1nVuoKSGg/fTUiyeOKNaTp1SF5m2EYp1Ys9SbxyxH2OYftbcwi9Ee6ZJWBo6K3upBHw8KadlUnHjtxeVGN/74cSnj4uP19GRZazOsubl0J2HmNnER3nflbX/C5jGgNrRuXKc+EqlmJ2eHMfexAkarGt27VPSkrFiB0qFPdoB5jaXFgHjHG9OZYdnnrc1OPVhlG/5m4lj1BiM+rs92BEibFNvnWRnqeVyehTlL8V+zFB3PEqm0aP0iS2A+Pr4bUZW92G3I/DX/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lsh2FzV2p0MiMNeEQz4fCBbBcHks8xWdyl8JUkyNnc=;
 b=pElKEDEyB2G0HVhgpuHdbmVVmNqQkX5p3UPrKhOxRLbkjKcAwwSf9U7cTFNP5BSWb9x7wiKXqO6hangpirxTphy3bWcAhNkCBi5wrlS8Is2AfEjOIF4nN+pGNfo5jaBkXHg7kEDdJGcM+Xh98rWYLhgb9bKeQWYEcMc0qG6dgoE4PpzWI+qrJXlNq+HdOzdV8BiBBf71gjZyjAQLsFAN6X7xlT0lsgZ6fDTkeTq021/G77BB0hxm4s3XURd5XW5zjT3RbG9GAfOdhW9op+2dxDqMP+WMaywG771K7q93fzJGEF1yGHiDQBJpoEpiLqFkLivMgslscqU7GNiDy3aAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lsh2FzV2p0MiMNeEQz4fCBbBcHks8xWdyl8JUkyNnc=;
 b=ttFGRe5o36G+18sVrtJyFOTEOo40NIvvc6EiOBfaDltkAC5PM+2V5w2RLHI9xkY/xVD7W4D43h/+zR+SsbdIbrDXQH4J/aHjrcPedUGh5aTrSdKwfLzsnbQ6yT4YqH4t3l+4y+yg/iNZ1Esl/z3lly4iwrzzMZ1c2aJE36Q1r1c=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 03:05:30 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::2f) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Wed,
 29 Jan 2025 03:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 03:05:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 21:05:26 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Muhammad
 Ahmed" <muhammad.ahmed@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Alvin
 Lee" <alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Enable odm 4:1 when debug key is set
Date: Tue, 28 Jan 2025 20:04:45 -0700
Message-ID: <20250129030453.2129085-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: c249b009-eb0c-4724-d5f7-08dd4011c96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+G1ckpndLPwvtN5WcTbzNi0Ec5yNnNOjbHasTegsCcBLsq6fcd/At/iAumrc?=
 =?us-ascii?Q?EU+aIhThe2usRzTh4MkAbsY6E3543s7nOtNA/7v3qkjSdCEbp9ZsUylUBlBy?=
 =?us-ascii?Q?9rc9Gk/ZYEYagpAGFDQZ1DH18HUK+auXs6YEcO1AzvYyShBUgUqt4BroW7Ex?=
 =?us-ascii?Q?PnHEoSEa+o4gY7GvikhVDuI94HUCgekUxdEI5PdKH2fzI5LIf87PDQciyj+R?=
 =?us-ascii?Q?2CurUWK/GVsxdbkubcoZViG2tvjgd9RabM+j2S12shXpEbFnTJA2UJYqnjVv?=
 =?us-ascii?Q?JngPgf5W0KxmiKbBqVT/GSqIDeqiFrgOzpswvTqQeigPONWy7si9rbTH/4ed?=
 =?us-ascii?Q?AK7awdBOW3eeBWQJ01SU70vOKptvP4CDxkbnNf9hg38AJdJ3B0mDA+pv6hPU?=
 =?us-ascii?Q?xtRObiY23/wf4sAcMd+R0xUYIZ5EIpNzp6NQEcgsG67EGzaHir+Xhs7d5hll?=
 =?us-ascii?Q?YBCMrJgcXSXB6ZRXRYbJm3KlgpmoIs05WKa1op05BpYib8bi7H3KSgg2KbT0?=
 =?us-ascii?Q?DAdvv7uKCT8OgX+wPooPcKgDm41nm2mguHBsFAuiiw6Wb3tWf853sVprkWq6?=
 =?us-ascii?Q?0VKIXL9N9ijMtP+jSO4xOp+MZHaQwETN1qfA/4J/LdRdtydAe3ucIxBWwOE2?=
 =?us-ascii?Q?XnSZxQkNN/9AYqirCCWtPuflHPHHVFioplVmhLlsRCWOTXMd6QWccFyNBmOO?=
 =?us-ascii?Q?C83Y08h/xIrVFYgkqGrtG6tjh2t4+s2yEi8n3QlgFabbTMYxy58W+h0gjEJV?=
 =?us-ascii?Q?XO2kSak4mzCupcp+SudHkfFnEhqGV/1ZuliOe4OeZXck6Frkf9dVv9hbZcJv?=
 =?us-ascii?Q?HAcd0oRmESI2Sfa5uVXn4UhoQMm/wKukyMNSoeFMsZvFRK5EPRi7fxSJ4j2e?=
 =?us-ascii?Q?50dTrzs4dQM8u5fPadPeXvolsaMGfSkr1n5oh0tPg6sqUiwcmcdAvEY/cwTl?=
 =?us-ascii?Q?5cpEKEBfwwh+b9Pmgcp2KAwRK1I1Y0P/Ei2wsuP6U1xPWnkXNJ2PkDCwCcUL?=
 =?us-ascii?Q?ZHdzd7tfQSepxo5mmxxDJ5+rce0Ki1E48INzPaF2KTh3W5N4x9P1vk6zebfq?=
 =?us-ascii?Q?CEMCGQwpUa+xR6M3ZjLoygM84yvPWumRfq0526WLDmYDZv9wzJwVDPTIBrMg?=
 =?us-ascii?Q?jiI6kOeaoouqQ7Iimy1rha+Gb+6CAG3KKmdnAuh3wyn96gkH19Oq5UvHKZoE?=
 =?us-ascii?Q?LZYhh6NkMbktOPQ+rmu8aCPYMhzXM5oeCyVAKjiCZ+N8I8u+X9243XzRc3ML?=
 =?us-ascii?Q?rr9jgcaxkOhtVNoXtGEQSc/VpIQ6Xw3o8yCipFF/gfZRby4mRiuNJFD/0i7F?=
 =?us-ascii?Q?/B6RVuhCsiEaKnhgCCM0sw1xBrIPWmGeW3zvjDapoMgfbfw5f2VfYOIM7SqA?=
 =?us-ascii?Q?CmF1sBOmusAPpQLrg7eNCwscU58etwJSUgqEE58vIg6ZKnIVCs43+v9/6lqa?=
 =?us-ascii?Q?ilxW4h4s03ac9AW5t5/LY6tk+bkYGucXK08BEx81G1huoK3Qi3sXauHJY2TR?=
 =?us-ascii?Q?w4bpHXDWPBixArI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:05:29.3178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c249b009-eb0c-4724-d5f7-08dd4011c96e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

From: Muhammad Ahmed <muhammad.ahmed@amd.com>

[WHAT]
odm 4to1 is enabled when debug key is set.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Muhammad Ahmed <muhammad.ahmed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 21f637ae4add..5ed117e11aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -409,6 +409,9 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 	}
 
+	if (dc->debug.force_odm_combine_4to1)
+		context->bw_ctx.dml.ip.odm_combine_4to1_supported = true;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-- 
2.43.0

