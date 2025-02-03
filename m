Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CB8C0219A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 21:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E798D10E57C;
	Mon,  3 Feb 2025 21:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dq4M7fbc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB87410E57C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 21:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUTtuPOLa37EaBmWM+b/gdKvMzR41s/ILbHfGVMuaTmg2x4G0wf5J5BYXAVoV2kPoi7Cojprw/FKeTOrrwXAcBln/0iVtVZjyj2ZeRc1YfLrMAYJY8omDrmhURU3YfscCBhsH37gwj5PwFqXA7wfsqF/SiIccQH4yl5G/0noibyfWuin0H1wFTOD58GwjI6NVzgRGcnYhceQfhm2QVfYkka8iLph3V0EoRyjYPCFoTyD/wQLS4nFqoazaqVBE/RHCQ6H8Mx5Z3ShrgFhHh6VASngyCIuvfaHPMOJCUpIVUlm9h7sZxga8ufjYBscTIa86oEmz1QTYvh/f8Wa2pd/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hg0zPIrcuvK23SUDmZbVaAgUURgaBENxDAgBXjenbc=;
 b=vDK4gkJvMxuemcTmB/u8qolwNjUd+p+qttx2H2lWjirXuuP+BIWkWOdv0Tx5g+c1OaIy4tgb03jyPPbijiRpY6HXvKVwuJ6gIQMfVyDGNU2b0mRPx8/sSL5pvqGzZaL6UmiBvNiVc6bduzhcnHIjNNbRXoy4yGjf511fEhGE8Hr+k2UL/s/XT9TAq744qpTS93wRgsvaf3fm06eaT2lITjcb91H2eUGvlZW4e7ZFwHHRMHyrz7P+06MjT7axoyBO9jk8wOpBTwZftZVNZmmwbVdU2z7weOzcus0qLSlYkGUZXbb69vGkxFJyDXQFRgeZ94tuEmYTFICBrUTlhUM/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hg0zPIrcuvK23SUDmZbVaAgUURgaBENxDAgBXjenbc=;
 b=dq4M7fbcTq3AW/7ltYryuo/67OE22/WO8L+swQBw/hGEKOFIAs2S2mmfgDQJVywkJdDdf6sNhZLWqfylPVQlmd+u4+4Vlk150iNBjVGMKTkKjrJ4AHQjChpsbJLPCA2tSsveBSiZkKABsZCVf5m6SYOcvJanBblg0nSQpbLqpGg=
Received: from BN9PR03CA0597.namprd03.prod.outlook.com (2603:10b6:408:10d::32)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 21:44:10 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::e3) by BN9PR03CA0597.outlook.office365.com
 (2603:10b6:408:10d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:44:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 15:44:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: manually control gfxoff for CS
Date: Mon, 3 Feb 2025 16:43:45 -0500
Message-ID: <20250203214349.1400867-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203214349.1400867-1-alexander.deucher@amd.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6316f808-a460-45f2-884e-08dd449be481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BcnfVlhID/+r1/4PXyj/NKTBYdw9NrGw7emTie6HQnr+wjrrXIoYbXNlaJcq?=
 =?us-ascii?Q?vLxtjGxi44x6xGzZ7Drw8yxoovpTpBlTOfE3ZcfoKpN1CVZeii5+0UWl/cU2?=
 =?us-ascii?Q?UKF/iB6yPQPOx+feixKzXAsXKMVjKvc6pTKsfXBdDb5LuayRucpNIjXyviR9?=
 =?us-ascii?Q?bSxoZT7X149NcpDtnAULjPcH3TOXjRq6uGZ8R/ghaXn+BtmofQyl6QS9cZEt?=
 =?us-ascii?Q?+k6sSCboeJjFLcgakbhIx80LX5CFNqnMbe+PU8JVE0iKygOcRK9uY4pzENvM?=
 =?us-ascii?Q?VNcV7PPe0uKWtJMox3w5GOaEmL2wSDa624O5yUCb3qxy8Ag89D0k//pDCTKG?=
 =?us-ascii?Q?xvmQAvf23HTOhQXWQs6ze4aSKePa6WHgzZO+ItiyR8Fa8RIqzQm+tHRATrLu?=
 =?us-ascii?Q?EpicwroztVWJXnM4k2FLSS4be9TDoWMEjljAwWf0TqzLfs6gXaSXnL4Xyezy?=
 =?us-ascii?Q?loBoM+jMGlDEFoujT3boQ4iX40ZCttvMTE/Z8JUm8gMcttlRtWsiuaIsWB58?=
 =?us-ascii?Q?bCQaXRTqFBMz0sJ+jrKqKnq+0vrXE/rSWd4CLnIBeNJDtKiGjx7mRliMG0mO?=
 =?us-ascii?Q?CRnU+2lhHGClQs+3k6ufUd35N+NLqhyMipLQAK/Q/ng8mcjnQqJTAZcTOPl0?=
 =?us-ascii?Q?NRo8xtsdffKyh/Wmmy+4rbKD+I0NiOkobMloK8SkMJT5Af7QiyfjPSv3PXGP?=
 =?us-ascii?Q?c29ZWIWDyeq1vaQg3jl5hggIkGT3IR9Jdo5nDd8aurkHYjd/9KefdATrx4Jw?=
 =?us-ascii?Q?X8Q2j9V7pCUL9rWZJAVaQVWfv0ph+RIUg+QvLniQFTHRF8TW00NLXaZW+Qyp?=
 =?us-ascii?Q?vRzaBKILkwMHrTJdXwMfoEtCXlLeoq7H4aV/uwafTy/tCxHZVT0ehJu7c+Ic?=
 =?us-ascii?Q?I/ZVAcR8qoNCnF1mJAYPW+AqyEfzK9SlW6V24a8Pd5yIS7Me2H6cHtFpZeis?=
 =?us-ascii?Q?c0+kKNv+d3RONKuROLCk2YdaocKilRIFoNs82Ej4dalBLiPTKa6gm7wLzkAv?=
 =?us-ascii?Q?3Cs9NuqrltKKLd44IRy4Xa3Qhq/dYtXzzVQdBZSmTRZLUlY+a7LeciPgu2p9?=
 =?us-ascii?Q?+7S1x0PlwmVdiy6/0H0O+LXHDw3+SVAPtoJo7+N1Qu4oTVZ2dBhsaiTKuRUL?=
 =?us-ascii?Q?88Q/QEVxX3UCDH//mSwIeaL/pw9F84exBq66frT5vnIEdZ0odwc4BWO0zAgt?=
 =?us-ascii?Q?b89FXn6hfJnBwxGN2LMPCdvK20rj1ABR4LPizpzxfFuH+6hXPqq81eZKgXl7?=
 =?us-ascii?Q?zEws/UGsdETIgIRyqK9n1oLHx1vwrNFodkmofueon6nPJYeB+baIiyDvwESO?=
 =?us-ascii?Q?v470i1MuBSVnErFTA/fzCDOSdaMvY+XI3bOTZLZ0dgajWdZst2EIZBk+kj9t?=
 =?us-ascii?Q?40N+POLWMd2oCMlX0ap1kh4AtPBSL/YuFab5uNP4wkfMBKXpXut00dpKoDvG?=
 =?us-ascii?Q?9T2heAl/5Cv/gU3mztemiRRWV796R41s0Eie01SS9s9YTHAz4v+QmWfG9ze0?=
 =?us-ascii?Q?30RdNS3klIl/UO0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:44:10.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316f808-a460-45f2-884e-08dd449be481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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

Manually disallow and then allow gfxoff in begin_use
and end_use to avoid any potential FW races when
ringing the doorbell.  There are no known issues
with gfxoff that this solves, but it shouldn't hurt anything
and shouldn't affect power usage since we are only
toggling it around the doorbell update.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index db5cc060de853..9ec2f5fb252a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5331,14 +5331,14 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	amdgpu_gfx_profile_ring_begin_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
 }
 
 static void gfx_v12_0_ring_end_use(struct amdgpu_ring *ring)
 {
+	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
 	amdgpu_gfx_profile_ring_end_use(ring);
-
 	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
 }
 
-- 
2.48.1

