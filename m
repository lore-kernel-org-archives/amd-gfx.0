Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC3C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 09:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5037910E9E5;
	Fri,  9 May 2025 09:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ry5Td5I0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA7D10E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 09:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKl7sjOxTtDvZq9m9/zJOodnFtPfgX2f5keX8rSeeyVs7UCEcuRhm6LL9qoVDd/Uetx1FqpC9+Q4D2Ia+ZqkH8/h+VDsqp5j/SSjjrsDI2MX0JrTCKLOTZ2BG0cETCnz4EZ0xOSRb7HwQwiu/ocOdBqLfUuMY8daNwYUMMBVOn4NYXq3+vU/gb8AfidcW4hf1B9KqiP7aPH7wKm5LxW1JBnaSNljeZB+c/s8YSqq5Jx95eK1rFZaS4Rbk0ToxaIzR+6soLyNIaAwguoGknbJTvwFWkpg5O0yAkLaLf1SYN7HjPvjuuaVox2c9iujNsB+sLDOSByFSAESySiz8qAtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P6yBeP7zeGGYqNjEG9IOZAaKW0iXywRXZCe2weVFb0=;
 b=SPh1GSMU338v1SZ8yaSkjQbJSk1wUtrIxCSVOmYLlVSqeHIHuuIfMdYSHEW97LmFaa7x21iHNG3ei80mF5Ab8BrmL4DSAyjU9oQKVG5ZfyqfON9WPbntJHcA0Mvn9tUJTRP4i6q6G3VnOHMra7TWuGkAlr3ZDNj2Qf3ZCIuexdnQ5JJMlKBjrXxszhZkyScdC02RlOj2+9SV5tgr3qn4CO4Q9barKzSXb0LaLJvPKUD87bmQCjQIU3CJP7TJo0YLv6/AeOoYqecqgESkCXGeMhvm1wrZxUSzZoMsE3w+QYJRR481EdNIT9T9J8QXMgKVbYZ8XAYDfOSGyzdqpyRjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P6yBeP7zeGGYqNjEG9IOZAaKW0iXywRXZCe2weVFb0=;
 b=ry5Td5I0PaQbWydzdw3QUTFokh0RUC36KpOfjativyoOTHKDMENPbc1c848mTUVZSEMVqcwqz7TbqcNIMApRdinz1GlFeKVxgT/Znr2Pme68oyxIMAqKMErUK86okC8zV9nO8kaJRtDBTcG2BJSQglhuCPdRl+2H56VIaOcBg2k=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 09:22:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::28) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 09:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 09:22:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 04:22:17 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 9 May 2025 04:22:16 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix user queue deadlock by reordering mutex
 locking
Date: Fri, 9 May 2025 17:21:13 +0800
Message-ID: <20250509092215.3667971-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5b1873-c3ee-4332-9ba8-08dd8edb003f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KzrvurOxCnK9Xy8NUVvgr/64+r6G1lsmpRV2pI2qRK4gi5zp7MYRHh8UWdyo?=
 =?us-ascii?Q?Hp4Lq4dwYI246oEpWv4pJv0a7cR6Uq+RksXxC8uuBIeSSXVvFFIw5ztgbioy?=
 =?us-ascii?Q?gObM8gNOTYiuxA55fa52KjV4mV6/H1FLeih60MK4CD+QvzjUiCgSd/BkgNo0?=
 =?us-ascii?Q?xrbqQLeroFNq/ejIjMfM65nnfx8GfbiJtw8VgEKzpdpXtfejToV1qs7YCfRh?=
 =?us-ascii?Q?ei2SrMLF2tfqY5ohkNwDkITbuiM0p3jIFqyqMYOnoo/Ij4up8LCuQf2eF+ms?=
 =?us-ascii?Q?kLHkBRz3fImh8mZhpEbqLfKo/PLU1bnBYbCLMzjNrk6nfgfB1VA24pgrGF1a?=
 =?us-ascii?Q?W3u96q/D6inocsCgdP0XSER6dB4q7MHvEcoHBJ32XwNTjV8CJjFqDhSunJIi?=
 =?us-ascii?Q?bPMK+KsFOo/d6jqjRvot9fjwxUyJOvYyD62+VzGhhfdOB4uw4eKkVuD2e7LC?=
 =?us-ascii?Q?9LM2RPvmRLL/J9a2deBWvSvztzvPesTyJqpI8ZC1oNHJk+G1d1k8qYWB5v5Z?=
 =?us-ascii?Q?SvCWUMSb+pO6Ws6tlIfrUEseaK/Wtca5+rl9Y5jcqjWVW49sXaGj7pl1z+ii?=
 =?us-ascii?Q?BITZM09+xzqswwkfg96RN1MFLfstCN/vKZ9oDKlt1cSzSuZwhSYA6wjngcIF?=
 =?us-ascii?Q?CVrPRhScY2lnZGJN9N+nNtggEM7ZDLI1tDYKiByWUrTBAce0Ng+CWmCmjUYm?=
 =?us-ascii?Q?GBetrTK5LmIZtuRtq2j6+iKCP1XkbWabm8Xvp4g4bChEjAqMADBUmh0B+BtY?=
 =?us-ascii?Q?0GraG6P75hZoD3oS/At4YhlsUHtGzfVARKcq9TLp6QvU9ceb7wO1iyNHRMhl?=
 =?us-ascii?Q?BRQWFOT43lVZK4cAH9i+2dlB5zgeEV79EFI3yalFctmDKKkiNckk4UwkhMpx?=
 =?us-ascii?Q?uL2ESVFnqKMxM63UgpDojKAe4zQKRS5hXdIu0VKrkccQGg92Old3V0Yy2R2J?=
 =?us-ascii?Q?773zbdIY5LALuW3eW2WjwbaqI1j4BQyPndnVNQ6RYxHgv8XaHKoVyHHOKsWF?=
 =?us-ascii?Q?9DmUDBbGQYyCBKI3o1KLzpkX4e+2vPd+9ielJReu6IadFakUb7RZaBU+4vMz?=
 =?us-ascii?Q?71SAQcj0mN201YXeHahwxcutL8JmDe+oUQEsAVQjUddhtt/ckOzYrkBEDEkR?=
 =?us-ascii?Q?3Ms0QAp0A6mvTxZpP/RlmoHJWORwE47/kClQOgL31fbAzFuv5n03Bq0R+fza?=
 =?us-ascii?Q?S8HEiNZsIOHjJr2YxPWKTUZHfUO/NE27OJjaV7QgahgZ+/sEomekGNPozcrn?=
 =?us-ascii?Q?8AWUJeW5Hw5aznyyGJywswsv4FhNNOSWlPUto/tv09KNlNgh426cO70ChW0o?=
 =?us-ascii?Q?Umt+3eplwJgD6qkL2GX/xDbgh6R/Ajjp8HU9cVYWJpeMIa6U4AyUIKBLOQW7?=
 =?us-ascii?Q?c/lwWPWMrJ1/9KjBZFr/8BPRtMkZLl+Ru6D2LigjqpJcHp6/Pdnm0vMga5fa?=
 =?us-ascii?Q?OKQCVNaksMybxwZ0nU1kzE5P+ljd8oF/4WMgcuDrGVGS1kKQ/zzZvNH+ugss?=
 =?us-ascii?Q?spvFDuXSHvTrDuOuitjIR5M4Vd4MMPlkCfGi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:22:20.8871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5b1873-c3ee-4332-9ba8-08dd8edb003f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

This resolves a deadlock between user queue management and GPU reset
paths by enforcing consistent lock ordering.

The deadlock occurred when:

1. Process exit path (amdgpu_userq_mgr_fini) would:
   - Take uqm->userq_mutex
   - Then try to take adev->userq_mutex for list operations

2. GPU reset path (amdgpu_userq_pre_reset) would:
   - Take adev->userq_mutex first (for list traversal)
   - Then take uqm->userq_mutex

The solution establishes a strict top-down locking order:
1. Always take adev->userq_mutex before any uqm->userq_mutex
2. Maintain this order consistently across all code paths

Changes made:
- Reordered locking in amdgpu_userq_mgr_fini() to take device lock first
- Kept existing proper order in amdgpu_userq_pre_reset()
- Simplified the fini flow by removing redundant operations

This prevents circular dependencies while maintaining thread safety
during both normal operation and GPU reset scenarios.

Fixes: e274db8c826 ("drm/amdgpu: store userq_managers in a list in adev")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1c0ddec06280..0f1cb6bc63db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -879,22 +879,23 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
+	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
 		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
 	}
-	mutex_lock(&adev->userq_mutex);
+
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		if (uqm == userq_mgr) {
 			list_del(&uqm->list);
 			break;
 		}
 	}
-	mutex_unlock(&adev->userq_mutex);
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_unlock(&userq_mgr->userq_mutex);
+	mutex_unlock(&adev->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
-- 
2.49.0

