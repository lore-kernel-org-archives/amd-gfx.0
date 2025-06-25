Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52037C7EE32
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA62610E817;
	Wed, 25 Jun 2025 21:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAaDuYcT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DFE10E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaiwoXAp2mnCHOYvrh0e/mqAqGtcDm51kwelSv8Z2ESC+DYA9axh1WLajryA7m4Ti5IVrz9lS2hZehWj/8GKnOM1GausNAK/eoWGeYRTnrgsQP7Wo1UYEr3omRkGdfVgXXRAIWFO3ZS8sWreBRcVBxdrJaaTultbHJxUvENyYgzidG2Prm7FQSySmG2OJeyy81YjXwTLjoT3pkCdN17VgpacZHamRG1U13fwuxKEWAwhWRAy0GdmskOO3/RewSaYMmc6MKeu7umD9VT+qMq5v8yduHcGKJXS1hD5uT+Uc31W+dFxXKHbSx3Q7rHwNqvctnyV5goxb2E20vzZhlRTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=ul6AHPto1+NYCXxbNJLCMuO0d2OeT1XLFfpXSXMsL/mHRBIAn1DBsD4Ud2sAnEKcxmHT8UYhmn6Wm1gFwQRb7cCT7YgrppA+XMnb6OXpXfrA+RqmvPG5ULqubwJ7JzO9SWF1VkfJd2wLrZAJgiAboJy1A+LyOm2HvZj2sXQ0o+lS7wLd93xjFp1YclTlx70iZPX2VmcigYAqIpUZ8C/DGEgimdiRipIJMOjaXg0WXZTVZHcXK2/Phij2PjKwaK69ak7f9VAuZwZUhHiIhmP1G+tbDn7sPz1mJlRz+wBpxhPGYQZnr4gwH2/8Hd+foSXWk68O0toXCzLNu9zQ52zQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=IAaDuYcTZKYqnz0FFWUtttsNTS5koI2cWHBijJe2mbdiT0vo7Efp38gkIWPVksYm6TkspTaJz2pWl3R9f8Qld+Fzvi9SlZK98IfGV3h/1GiuUsjWgmDtLEHTJUO6euyWMM5qBv2iqGpn5+CXSNRVqkJoMqL+L7XGtchwpsNDERk=
Received: from BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48) by
 DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Wed, 25 Jun 2025 21:07:11 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::8b) by BYAPR01CA0035.outlook.office365.com
 (2603:10b6:a02:80::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 24/30] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:32 -0400
Message-ID: <20250625210638.422479-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfe27a8-e155-48ef-8318-08ddb42c4093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TgpP+UIvEGGOl9gfQvA4+tUbsiykXcNO37E7gS7V9peWJI+3rRgE+RdhWhTV?=
 =?us-ascii?Q?bZDb2tFMVbSg1ayE6H+advkJM8WgvRwgY+GuGhkEANoWUgxuTWTkCmEMUP5J?=
 =?us-ascii?Q?bQ/0ZmlfFdLDuQK/XzGzh2h2BaKxP18uAY/YVIj1Bpek8IUo4VAyBLYfevTG?=
 =?us-ascii?Q?Ik1sDJmmC8L2mU7u+YrrVks2tr+C7mPxpe5VBk16VwypXfjdDJ0B/93WxteT?=
 =?us-ascii?Q?5ln2IuCvhXEYI0Nyyp0pR+ouEK5cYE66DujvN2PxojLCXDibNWI8mUKNtpGJ?=
 =?us-ascii?Q?oTstHfbDjFPaGu5ydsokELSi6kSmZmkKWKZjKKbYc9jBVhrtODtpDXVZGiLn?=
 =?us-ascii?Q?dzjJWpT2H+wY+/aOTQtnJI0+cgmbt0jKsQvN65Jz1ovZ3LQzocpQmxLByGsF?=
 =?us-ascii?Q?iD2IAPQf+WfE1qTOZ85sz0aeM/+/WqQH+cAogTeyocwlKJhGVJqiYFJygPam?=
 =?us-ascii?Q?7b0tBg7iBSHEQUSb61Rv+pOHtR+ISJCtUxzW7DVaG3YbVdDRCpXfFxya0UeN?=
 =?us-ascii?Q?RzLbMuF0/SuWnOHT0cJUbBMPBF3OEtI5UFvqEeVjlsGxGAcwPt2qgtMgrmUM?=
 =?us-ascii?Q?kRE9q1UjbSwRgkcmVk60NEkrKNu1BiJDciEvqUg3WcmRBsbEdMnicXC3JxVA?=
 =?us-ascii?Q?yYRNa/WFU6xW3+jGqCKgOfHOnFsOKIaGMDxc39/birnDrTR/WAxRK7kDLcg4?=
 =?us-ascii?Q?WO1uPuFiruxWc6u05OzFgzlqhEqz8Q073WwHmVSHK8WAKrH/fM2hNAtREMHs?=
 =?us-ascii?Q?mteZ867w0xTpwrWgA4Wh0JY6jCCHZGV/Qpb2J8MFxGGKDiaanzKIeM5K6U/O?=
 =?us-ascii?Q?bFLOIn31aER1SSbSzquEw7a2NUciTe/VPZs4PBTyvMIvVtCf36veQgMv0G6E?=
 =?us-ascii?Q?jRsHoXxrfmRQg0aPDEJPUmic3AAP3RAM3NsvCyiSgxSjfx4+PI2oaN0VB167?=
 =?us-ascii?Q?xAAnCaRs45Jgaf7W1Wqi6WUCdVAYBa1qEqfmu/BiDoXXfZ287eMY8cqgGu7s?=
 =?us-ascii?Q?RxrbE3JauPNENju15ldypMi8hN1F3f6Z2Fu3SiHKXRqBqI9A9Y2lGdg/nVoq?=
 =?us-ascii?Q?DoTOnmLYQqNZYTbUckhHvdhj44iUWT0r9mJZwt1/OXYPJToo2cc5pmZY6/3a?=
 =?us-ascii?Q?FNIVmxZ8BDKJdsGQgfevmkXQVoycKAXKNysaEV0Pi1kdqdF1SpHBt1WTrSsj?=
 =?us-ascii?Q?7bAYT+6UpKIBwMThAjGatE+4Qum5nhBqPSJYu2dd/oUzkfN241Z1EGgMsuJM?=
 =?us-ascii?Q?iR+bQZmR2lHQMxfCr+AGxkzVXMTMxpDKkzDq9xurZ78BoDJAbIxkq4WYUGW2?=
 =?us-ascii?Q?CX11oL+qvf46I6vFmGEhuvfZSTwAJpJCE5YH2K0lXhL+c1Rz4AOZso89GePu?=
 =?us-ascii?Q?rWtahXvD19Zsp1vmZuGQBzQCC3XbmRvcPfNZjAfm3R2SGwQgNYO4wAEwszSA?=
 =?us-ascii?Q?Y/ARAkQVwSraCp89YMRmg6XQ2V+/yj/ZM8rHHEryNk37MSVgs2u/qe6Rswpb?=
 =?us-ascii?Q?bx0SGwVmuIUf/YVs4qpxKu7lr1Yg4H+9DUEF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:11.0089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfe27a8-e155-48ef-8318-08ddb42c4093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.50.0

