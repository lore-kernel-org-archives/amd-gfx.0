Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4331077605
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 18:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4111E10E70E;
	Wed, 18 Mar 2026 18:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+DyXlpS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EEC10E72E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiIUODZ0kw2GQw9likwEA5H38EQxTx0vD2QLn37NW+5dJicrol1D0C8tDrRSgZl/sA27Usq5wf1MfytPIxBggybYAIzFZGWsJsL0eZ7iVYN3OSE7JNWyKTS88M7Sb/NV6q0SwBQFU5J5wCr3LsIlcPqbaJiCd9SveETq0fvB3rD5n5/EfVRtJBN+bAKng01dabr37GhMPxEF3zRImM/AlxQ5t4oeCkLBHxldvQboKlCAye1+2p52Akrwb08KHClw8jnJQqya8RLkwgqYJeZDg0025quMZ87MilhdepazDJIc45v3u54phh/uhzV/uirgZTvWmm/wq2K0pUGjehWNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdGdL+e9CTG8Cld7H9WMADvItk4zAU+KUpwb/UnaNKE=;
 b=rwPmx2+CphXjk4LMckPW0oubjMTjuC5wXTochWTNfPaMpguUozUz3Mhpo0OyvrB7BiPYlq3RuOyLGpjZ/Dtdf2Jf4Mbyv3tQssPqeQJnbHomMu/OqFUn3tfUiEU7TdOwfZYtZRnPsSSObMxV/EabevJRCZyPfVxhjbvziFF1TD0Mhj1qPOid2N7nKH2i53fjSX2TwwLWY5n/IojwHZH6xt53JZpoVaOC4t76aKArN5ycIYjox6c031KqNFlD1krS2g4YUOndb60U01ssAoZ733CK3yL0/+Sf5hfAQQArsA7aMGP+40vOURDgbshG0B+YKIPxwB43aJ1IZMzR1/OX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdGdL+e9CTG8Cld7H9WMADvItk4zAU+KUpwb/UnaNKE=;
 b=h+DyXlpSSqwzUx8djnOyskhVGyYVUcN/TLctpS0aoLluz8cFyZxaVqisxYAVxYSXtgSrRWgC0kSnO2EvW6mptFMWdJ6X7Fq1zzdzC/232EgkM9hc7QJtzvLvp2+z3IMm0z7PtWhUDC77Q2zp7uqc9Aiaw+TNh1dQIWr5YJm66Z0=
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 18 Mar
 2026 18:36:20 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::fa) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 18:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 18:36:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 13:36:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 13:36:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 13:36:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Wed, 18 Mar 2026 14:36:04 -0400
Message-ID: <20260318183604.16505-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318183604.16505-1-alexander.deucher@amd.com>
References: <20260318183604.16505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: bab5ccc5-4756-4f7a-58f7-08de851d3fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dUW2yW2c8lFIPYj8MOhtC6cwSYbD8p+fpeo7cKmdxkMqdG8mMbj3YyzeVrjkXOXFqjCgEcicawNi4f2q30Hw8kFUTL/WObeNfBz6Yc06yhbHs7mf/2CW+VW1FVPfgEPTTpF8AHnILQVCzyatC/GCm/ZNITp72mrhi54mOQBBSJxoeLelgF+oNlY6K7pIq6BAqVptm8z4R3SRCnwjqzboNaqzwu2ucb1uXO1IGcAj14KGVq5mPAdCmCkHcJHcc2v+ittcrCZxc4y2PI/v4HbEN2liYhTmT8IcH31Y3KTp/WknUud/N+UcPNRD150t6hkFZxq7zt8LRcvb6DC6qK4SrfBstZHXGXibWWPm7QAaDk7DFtueBQYKfJe/CpgfVC4HJcOXuYo87Ncng9bfJqWcWp262fkXp6ybLQAsY8pIkLlttaiS8ao9uXbzMWzwD5vQePGKMRawQ3RuxjZySLpkpIA5MV4oTokD+XfxBDchN0zAaG70HQtA+tf7K6vvNOApp+/hMCJr4JfS/pTKcSc40mliaGdmvmyrYJh5iZpGk4ywxMSY5maTJ8dlZIINKNKkjEazWJ4wf+nP43RVs14W3mE7Xz0Sorb4f3ILVYutLu1Czjy6DolCYxvZpuEPdU/4inxIHRCbXUkR+tOPABea0T9eCP+d4DrV/riV9Y/f/rMz/EvPVyzr+fhXgA8nqbtwhTxmaUcklNfNWwcsCF6U0FbCy+vyYlJtR3vH9dEZU3L5A7Z5RMnAA37nfGudB3s0z/arydyhEWEscEnN544d6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xcAmAPywzpoD+BhoRa4AJH5fw7qo8BL4C5YXUTU1IRJArHCcnERkFhxbq02RuTCH54E2O72aMM3/MFzDhspvRFRxWGP0hMpsyhfWo3TXlmOOug7CHPyp4AnBKIh+dumHt5YKhQQhHxMwJIu9Bbj179kaWuEMCSLSSs5bpzn2Scon1Hw+3U0WjkYvkTlUaFT001Eni5ktL5wJxxlaWfAWfKHcp6E6rABblhwUUUuSmcymm5RyBWfZpg1GML82LKQgLePlN5avvjvKpILOTo7Axwcry2kVDc8r10PFVmLzZaxu12Y771L4AiLpTbHJIMMe+X4aRLSm1RGiSrzYJil4OcYF8uJOp0lxbAnmBkbiIC7hgQ9VkRrbywtrJqxoLY14C9pCrMXQByr6z/CIta+YDnGCdGyvKnyiCUJRlQUGdmE6jYwc3qwd0zh8AF5fQdZf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:36:20.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5ccc5-4756-4f7a-58f7-08de851d3fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
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

Mark the entity as guilty so the ctx query IOCTL returns
the correct state.  Align with adapter resets.
This only makes sense now that the CS IOCTL no longer
returns early on a guilty context.  Without that patch,
this would break userspace.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cd0707737a29b..dd9b649cf88e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (job->vm)
+			drm_sched_increase_karma(&job->base);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* Start the scheduler again */
-- 
2.53.0

