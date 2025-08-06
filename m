Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776C9C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFCD10E704;
	Wed,  6 Aug 2025 02:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llEl7Y+V";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FD210E704
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSfp3lrTzOTLty6OSKTw5SRb6I5DJ6mAOaDbnCqSbEH6W3tdLh4hUwMGS9Y19ILFa25b7fQvs4bF7eoaLgs67Y9Xb9J81CgOWcvly1UWtaeHbMXZqNstKDixSZoSpfE/657o8ZzI0KX8tF3bgrcc32dLDMqfMntb2vyCtaLmNZEuGsAI/cYRfOOI+7h3D6bMhxZPrcMDj9QCci+aa6cK2UoL9+F77Tt4MWkxfaXI/Pv7aN80STRXSjyt1Ib5l4Id3oHrBFiyvB2mabl/7I8K0aks0TdUbm7pYEQbXjzkhQkDXJI66Te3ch1UmcxHhEdOOnOXUVmjdCrglijeFTAVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=CVTu9chme7qYr49CR3aau6c/MAAr9VanINNSO3qXtCjC4RS1isBAlm+pR9USAjMmkjVWNYW+lpJt2A4DQXqUanbb2pDXXP3COFJtUutxgJeF0Az/+/0tCDQTXgTwDphlRiwi3flafOsAF8oGm1njgPavTzk+0eSN5Cg/M/5cLucOXhHSia/H3vB1ioTrhuQGKReA/i9OH71ibHVax+F61bby0+xmN0NIxQZnc7Ybte+sarzJo2Rj9y3Xtq6cmJtW1xDwROPwcAgBZkLYs/ENzII7tDzPZsiiAwlQCxv4XDhVWfy/7YrtTjqsJdzQKb+l+tJR4AafGsdX3ANuGikZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdTlMrdQ63wOTWZG0i8a1tsZL2cS2BSA7Qs4lT99uYY=;
 b=llEl7Y+VLxzHteJvbx1ytiWi9C6eYuo4IUrG9Yxhq7YSMqW358OGVJMCQ1WVfhxvb5jZF0MOTbTE9tZnq8dY6ZKx0OGyLTNbkGe8y2okX8qoADtRNj72bDO4RCuYldBLHaKTN02yebuJLSLUo6RD/gVtfRoDlbFivyw0LrqrWbg=
Received: from BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::16)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 02:28:38 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::7a) by BL1P223CA0034.outlook.office365.com
 (2603:10b6:208:5b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 02:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:28:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:28:37 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:28:30 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v7 03/11] drm/amd/amdgpu: Implement MES suspend/resume gang
 functionality for v12
Date: Wed, 6 Aug 2025 10:24:48 +0800
Message-ID: <20250806022816.1050823-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c83db9-f5a3-4bae-1ab3-08ddd490f337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUBzqk2MA1B+33n3T5k+W5Ki0vZ9259QWQ5AOzT7n4g/T1qqTIfojn/sG6O6?=
 =?us-ascii?Q?Y6P3x8FjOOXSYKF5LlVUciV0a3N1z7LDpGZBe2z2h8AvKhfdrX0NgNr3REHC?=
 =?us-ascii?Q?E17WH1yulvW7s4qMUo0mrWGd/caLSIm9rMC7y0E3RU7QlgeaIJUF9mcsLa0D?=
 =?us-ascii?Q?bi4jLNjXCSQUD3nmPoCGZUWIxNC4RHWzhuK4LAebEhI3MTWrufyDqfbNJMOg?=
 =?us-ascii?Q?vTopcEld2TYSTRzvhSMNR9JfLgUb0piN4wj+X7MyNxci9hN/gsTuxh8qC7ME?=
 =?us-ascii?Q?6B7jMASxRonQjlazaGG0Id8EGkbx0/wThzmVWHnQEdlCWBs2sl5pq1WSBegA?=
 =?us-ascii?Q?LoO3IGtvdL/vN3pA4xH63pWjwkwpHwTcqMZ4zvEGsB015OkJotSdTopjbEsM?=
 =?us-ascii?Q?LvHHG1qw13LHUcN2E41yGlXO/yZPRvXyTFcdrjCXqcC1ZAV9GWdIH4QHP1eR?=
 =?us-ascii?Q?Qg6xRFqp/Py6ceIazcU9e0tCS2JCY6QgXKgFhptAm3MVD4URsXekI3gFIJQ2?=
 =?us-ascii?Q?Z1Q0w5+6+uQzgu64vTo89Zbon5mv3JPN/LLDEw524FgcsraWdW4h2FOx7bVV?=
 =?us-ascii?Q?WtOhV+oqF1WaaWvDLroV12+5WgjPnGtNNTd19fP5jVuh2KVyhc7FI/clCAwP?=
 =?us-ascii?Q?15ZOY/P/WIxbF0CaFEaYi6bdOmlm4367UdnEw1245eFzJascLLSCO5s2tngp?=
 =?us-ascii?Q?UVjJkIUd4lRNcE6Fgz8VQj9t8upMf8/uFSIwAzfs1vfIIlpqOahzMCnV0mjs?=
 =?us-ascii?Q?TiQKFxsMZs1H+wlnXRCendVVMAaTtkt3vqRJdObN1oWkQARViYv7Cjk0SYav?=
 =?us-ascii?Q?+PpCvWUjm+HUxBf6pJHepw53z/J6LqUQ+hcGUUU/oqaznSLggY8nz9WjLnP0?=
 =?us-ascii?Q?H+i4ybPsrGvS2tQRm2h4rQae/lcFY+us86lx267UA/mzwdC/CtX33fo/SDNk?=
 =?us-ascii?Q?7c81iBiNQsSrubqhjruSpfGiOuXbKDKwklQa6/j1d4dxQhatbU7VUcRgAco3?=
 =?us-ascii?Q?R9v3DzNQtb48ypdDPKz7nyqLLkjc+Q1Zq2tuku+xwb4SLOVgiqNqKXxqq7E9?=
 =?us-ascii?Q?ws2+Jd7HOkXxvd4vvYV3ZsXSSDpObE9GEqa9ui0D5/xnhn8Vb3pG/p72BjYa?=
 =?us-ascii?Q?c+gCc3Ohj0vxqhQDMjOz/SYlw0OoIcCua5Ob3qi0lGdaa7cAlYlfJdizSAJR?=
 =?us-ascii?Q?n3dcLi9YNeTldKya61peXSZ+xLfiIlHmItWEd731obP0ZbB3iTwFjcaUYRR1?=
 =?us-ascii?Q?GsGG0j2Ho4eBSm3y0yA6YCByZEYzefMNlHioxNi8EKmjXg5yZbXlQ5b0YgJ9?=
 =?us-ascii?Q?NZIHvPFmLsmC4i1Ag4pJZX/z1skRbNnAhkBmfcD2Yc+Wr7TBpVg1Zqc+s+QQ?=
 =?us-ascii?Q?/00X9a+947mL9zuiJD7LI0U2OlGbOnL7Ker3oHtCvHA862tkcISk67odd444?=
 =?us-ascii?Q?0Lfg+W/NFfYaYS8/An8Xvvr728luuGrAvi/Ry5eWD3fckH07AhQxIHDq22L2?=
 =?us-ascii?Q?8hcYf7hilT4Lw71sp32jLweehlDMbljhfZ0b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:28:37.6898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c83db9-f5a3-4bae-1ab3-08ddd490f337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

This commit implements the actual MES (Micro Engine Scheduler) suspend
and resume gang operations for version 12 hardware. Previously these
functions were just stubs returning success.

v2: Always use AMDGPU_MES_SCHED_PIPE

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 6b222630f3fa..24c61239b25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -567,13 +567,41 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
-- 
2.49.0

