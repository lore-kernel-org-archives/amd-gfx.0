Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7319C61CE8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613F210E572;
	Wed, 28 May 2025 04:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JxRhoLrK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98EF10E54F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaOXAGosFQDWVx9jP4Qf7T+Y9DCgQYxhFAvjfT23+zf7rFCtlPPdxcjI3X4c10J5z0A1GFeCILMSC2kIS4luu4EKza6pGcvvN5yvmZx8x71OUJ6tbgBWrApXHrLw3vD/SBc206+KJqLfcKKJQo5Zm0iLxJAX1j0RjV6g97c8SUAi60MxAPHjMtW++B0jc8YnYpYa2eldr2ClVuoWKHsPKxAz+43CopgekPwninqmxZs4IqI52kHc1TtxwcYsauFFf23V7k12PezYrj0zWH0aYOmWPEupoeWoA6RPdyH9o0Cr9P6x5XhLBzAlBAZo/9T9LKBaJCiqdQmo7SC912bgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erAQSEvIueEQg/ay3+IoRqe/RYkysffxmGuP5AiBaQc=;
 b=EcMw7Ig+DqfFB2JM1JvZSZeEnBy3Vm7y0PcNejSIi882LMXn2sqjFdX56WDEQhVgQiPUGg9A8zXX7Z/In08XKY8anwiMzZUqPYvprFu4jUkkmmFB6CBS05hM7g65WQXZddYaDaquAt0LNGLWwrPc7oTsNLPD3U4rTZ7BT5rrMVoHOxdavXwIvFS+gpUfXIodOhRHAANe7OJvECRF4Jt0+fiWE7QxPlJ9s8MbnIAerDRooTjODMdu4iFHxqKozpdv36a3JbFMkA1vFt7tdYeC/6dsBojVlvqjRG88LdqhLYnP+JRSez5cQcrbM0KtjG7wWOCi6FP+1K1acX/7/tSzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erAQSEvIueEQg/ay3+IoRqe/RYkysffxmGuP5AiBaQc=;
 b=JxRhoLrKZXKZIDviK4VdkwkOoivjLLb/GVc5DxbIkAY6Wx9AINF6vy00nXWZgtnryJC/lfgKP8ayQEPLdilib7E/n42LBUYASgHSG0Z6em4gCN7QcQX3c6rFjnuThq7upDw5YhI2jZDlEhLmHSQoIjXkrzVhEk9Ocxdk92V8V0w=
Received: from DS7PR05CA0038.namprd05.prod.outlook.com (2603:10b6:8:2f::23) by
 MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Wed, 28 May 2025 04:19:36 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::e3) by DS7PR05CA0038.outlook.office365.com
 (2603:10b6:8:2f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 04:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/19] drm/amdgpu: pad ring in amdgpu_ib_schedule
Date: Wed, 28 May 2025 00:19:05 -0400
Message-ID: <20250528041914.5844-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 762ac7ea-7244-4990-0b71-08dd9d9edad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ylBvwn3J4IrbHHMSSB0+tL35qgGdkOiYyMAOai8RKZwAlgVK5tLj0TtSbSgG?=
 =?us-ascii?Q?V5GOMKARSo5SKKl25QdoLCnHVh7iXmhLKtKhwYpwDVVoBs8V/evDjSPq3BES?=
 =?us-ascii?Q?zCG9EQEDtXh0vdSfUoefR5kcT4jgw2Bxb96xa+tEcfBlM3/bT3AfQlKi3Elj?=
 =?us-ascii?Q?ugEajE9HotcWLvdFRWuNRCUyyJ2k2xxKiIsQm8YkFWRGZkvsol8ECdFelrgG?=
 =?us-ascii?Q?IsuHiuz6KUiG7ra2bANaThiM0fZ8daFXYqZCl4zBMlgdK8fMOVG3Z0+cPdrv?=
 =?us-ascii?Q?843gVesIkX0sW5ujHNmG/O0zvZE56HcbKlIBOwnVNcFMVMyt39qcFf1IDuB3?=
 =?us-ascii?Q?SFlCfUIsLXtKlI6OVcWoE2KcVmNIw+/zzXl40qou/1FTUc4IVUUxF9u52MhL?=
 =?us-ascii?Q?sEKuNLpp589mjG0yMkQYEG0eh7zA9yTARwSYLN+a3OHi9owSmSsxfbm2GCtr?=
 =?us-ascii?Q?m4N0Fe9IoGKSN/Z9fFYzKLyY2bGwny184uzeJMr5jttzA43cIwr8mD2x0L2y?=
 =?us-ascii?Q?Yl0FAc9lXpkS6QnMMZNZcZvk5gkIS0NPONviEoXuO1a76jwn8yUGgvOA/vql?=
 =?us-ascii?Q?epSVFGAA7TqvSCAAgahN2s/k612wjzbJKmw1ngvC73FWRAskL1L72Ej80Mrv?=
 =?us-ascii?Q?c6aQ7BYN+L8GtbrWuWeD6bnK07qoCuCJnvim8kItHl+z8pv0/W+k7Pcke+lr?=
 =?us-ascii?Q?g7FSQcx7qE0kR8JEpUH5fd2qP/4U3Yy8e8VUl2hwN/b63BevzNiZhZOw9lxd?=
 =?us-ascii?Q?IEVR+wbEPLcqwZGXf+wzxzHEXQnpPS7exOcX1xWtX4t0Z4NpsPrzoy0qz3/M?=
 =?us-ascii?Q?JYiOM4QXJrQu+MJf8ztoPhXol9qu/fgUIayPauUVxps+3e3EPKxjl3GwWfUl?=
 =?us-ascii?Q?coGYPp0nYIW/QZLSENvssq9bihQUBIZMYbgxYIEAsxAHqFhuf7rxibZWzCrj?=
 =?us-ascii?Q?yEQSrc6mQkNvmso6LbMVjjPBLdoigwKrQmKtwBn685lkogWdCMJNNFzsg6aa?=
 =?us-ascii?Q?trnp+vQY1MUna9aVY85SDuwxxmzmEOSJg88Hihdkh1+SgIpUPYiBMeuIZVKm?=
 =?us-ascii?Q?dADx948JYZeY7AlUWNQDttElNaCdleZXs84XW5c1a0g5Q80vSCIwnCdbNJtH?=
 =?us-ascii?Q?Z0Pl67dvNPLolKI+gisejXCL/idrGy8la6F1Hb8BTFnH2USHRFTZvk1UGznl?=
 =?us-ascii?Q?elVATTocij1IahFG848Yx118kB8T72JBbXjKH2qcy6ZUMD7daB2acd2tDw3L?=
 =?us-ascii?Q?sptBMJNM/3GgN/anbqECNnQjX2pvrLWz8ZK5dkKSXqtvuEON3GoJQXmEJWlE?=
 =?us-ascii?Q?eoVp7GZIstLJ/Z/dZQ37TqXix9i4NmGpC82rldjYTIJq6bbCrqxGmTN0Vy7V?=
 =?us-ascii?Q?9Ah+YWAOFjU/u63FvcFKWvFGWIosRQwOc9P8bv9KrDQ3Cu/P+RI4ZATBoIge?=
 =?us-ascii?Q?tZf5zlbn4M08yJKIZD5+kSfqR6DGyQeB3AqkuAC6omVpXWydJ26kz7yC6KVw?=
 =?us-ascii?Q?m9jN+9DloLPXWUS1I8OjmVXBMwZUEXwgbnxH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:35.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762ac7ea-7244-4990-0b71-08dd9d9edad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

We'll want to include the padding in the wptr count
for resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..3e05e8bfaca4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -304,6 +304,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_pad_to_fetch_size(ring);
+
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 	return 0;
-- 
2.49.0

