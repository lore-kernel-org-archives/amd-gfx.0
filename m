Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A374FC83000
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261A910E81B;
	Wed, 25 Jun 2025 21:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QenkzBO1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF40510E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS0GJF+Y77o40PPQJu3gtQqSH1BTRff6aWU1IEGK4gYypAoBhAtFbGDEQuJ2K/VXeTEpqCWjP0j6FaclQWszMnBl2oRTRwVKnjWRplXyXAgoa4LZvqGhKNOhGaeayRNossXxSSOSiEKJdduSQs85HhHQvS+kRkmxazKaOrcIj5qH6pVBj8XedqCmg+eedooP3MVL/c9DdAoYKl0rCVUNNnj8XvydMP9GEmlVMH6U0u6nsPz510F7AZhci65QNhDM+OouBAb92gi/NCVk7IY5G4sy+pqsEDA2ZJoee2bEelHbpyaYu2zCHbDkEQEIoIAjQeOb4bhei1MvZh/RMonMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=w0794HTwyisMnplP5ZVM5wNEARCMG2ZwyFZQBH2xX5M0wPPZFxNwZL+4VGQ7eNZNnYDYxC7v6TI2XIk4Gjx661kDf1rD22t7WORlyCecGP+kb2TTTw0H2L8Xk29ntMAXJsl/YBpIlCO5hYE5YKY2eQeGJgT/ymbDJx1dXza6Bsp7GAhg3DkffXh3EHnPHyxcgfHSu6tSXXT1YhqHnGRjknu7UHv4qqNDItf5Rr+GT4Jw8zweK4nVvuNTlQFHxl99MxKmtEi0Co7MBAqmo8oYVR3A3B0eNsjoXRZl71GoTsVke4B1EkZK/nNhCOXMzaAQ40KzpaeT2zuVwUefResmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsPlGovU2seiUeHIviEap44EdQp40oMVXT0tNjVoXM=;
 b=QenkzBO13931zdXBwIdEbDrUdN71Mm/XSUipiib3EAWg4uOL3xTnLjWV4OAcJnGJzM9SdxOeoDiZHtl7j33x/7lMzCVX0O0nQo4t5U4NfTl8v3ZFwo/9mhItNRNfycmKfZbW5zMsp4hZ9N9gs9T2TG8IEVyQw7KkVb5/0UnD0s4=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 21:07:13 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::e1) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 21:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 30/30] drm/amdgpu/vcn3: implement ring reset
Date: Wed, 25 Jun 2025 17:06:38 -0400
Message-ID: <20250625210638.422479-31-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb596e5-ee51-4ef4-a50d-08ddb42c4194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LZO17oZrYV3sS1NZwn2CCgDUjtCT5uNaBPAXMDpu/1xw5RdzUrVhHKchs+dY?=
 =?us-ascii?Q?1fUUeMqNVdS+17T+HUBEtZEYIwZrbN970YvrVfHiificu9wfXWkyYeoYL0n7?=
 =?us-ascii?Q?Jj15Nhd2BoU88MCn8mFANPRibN713avNpAwnGiTP6DXXpqgEtlCHquZ9o4aX?=
 =?us-ascii?Q?N44KiyooPOcjF+yy1KTHzULYj8VCC+6wQgjeP39/DRG+hSxu7msyiT2YYbYG?=
 =?us-ascii?Q?VIomJeQbFD/PI7a6tMrRbsijUaS4A0A5ZcjkKPuLXz50MXYi2S4F60QPBytZ?=
 =?us-ascii?Q?sypr3yfbXPcBZckMm7Eg/IZIKHV5lHWCN4lf786yYOfO2fXc1eNF5fyexXY4?=
 =?us-ascii?Q?SYrUoANn7dBxAcr2NT3d35msJDmPRhwMqdcoBK/18bYohglnzFUPpNgmend9?=
 =?us-ascii?Q?dbH1dfWVznmb+pThwSHvP6XhBhGXXkILGvzVbuVcy+6jNiLGgvU4NJXDIDHA?=
 =?us-ascii?Q?D2VJTQXbC296o4U5+i6zkPF9UnldaQnt0K+zzsEbtdZqRdq3JYdFFbFroOcS?=
 =?us-ascii?Q?5dsTt+U2+mfh6DoRzupc2d7e9tx3OMJJfj4lK6j2NEeQNwQ7udAlpQUmsVnr?=
 =?us-ascii?Q?uRhCPGi4mXoZpNpPRpS7ELRd4KtocchYMMlkT98888tJpK6XBypxkzK53DPR?=
 =?us-ascii?Q?AAVgy9PnKLo8Kb2IcC3CJ2jwXRNrE6ba2flkNXo1OsMeCWXmVK4UIntQMg2Y?=
 =?us-ascii?Q?PZ+rH6DYnPYnf1nGBHdQXTwVUAu+8aKU76AF1xtLBHoh/O6p2+nm8Jw4Rw82?=
 =?us-ascii?Q?sHvfUFeh2lZgBxJdNIiDuoYo/pVvNy+3Acs63E9ShOsuoRhfdDlcpu7orH62?=
 =?us-ascii?Q?Qst46267tWX3/8q9brB4VUhODU7x/YAgz7I5RopBB4o49uWIZ4L6feRXkmQZ?=
 =?us-ascii?Q?NN1y2yt2YLdsEFqhgYG3R5pS8qSPVeMpTN5ycRP5KPkWkp0Uqd5gVKoaZQnZ?=
 =?us-ascii?Q?OCNOJTwJL4Tr9IZAgYyAan4M9KI8kOjb+gjThXDhEXLZa3hfl4qo/DRpIh10?=
 =?us-ascii?Q?AenRkkF8OVTK6c4Vjxav6hb5ua8h3S0zcTfWNH3ifnsAFJqBUeTNodebi542?=
 =?us-ascii?Q?fYRpeICLx9JoEzIYhj80gJKmEixUpfU6cK6vwzI5MyX/nHBhLXdz3DTVbBJr?=
 =?us-ascii?Q?m0kgbIcLfehPMobYQkGC4nugJT/lzqaas8ncj/64YXgPls2EYZCubG2b58Ke?=
 =?us-ascii?Q?UayGHnC1KjHQ2qZVlTIcb7VpFQI+DRSKziJyw6rTW33NSKjw/0/qZr5YbKWL?=
 =?us-ascii?Q?AgypK6SAf12+hItfthYmSyjftksr4sd+byOiQBW+UiFMIAd82KZs4kE2wFOB?=
 =?us-ascii?Q?dcZDtt3ppH/+oqR86LLpVIp8QVrjjohN6HOj05sMukm3K/OeBZyLbNq8wGpr?=
 =?us-ascii?Q?in5kitevXytBJIOAaCI9cK6BA+Chz5CwqelthbTFUEuTot2EHWA+3C+Idu6l?=
 =?us-ascii?Q?Pdh0vxjheQfyi3xdnc6c4/oYiZGuois6urmpZ2JayurtndZa65c7U3d0uoTE?=
 =?us-ascii?Q?FWBC7tsxteQapoMg7fHeyhF4LlUtLZNJ7OWc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:12.6945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb596e5-ee51-4ef4-a50d-08ddb42c4194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..dd015bc6fd0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -2033,6 +2035,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2134,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2168,15 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	vcn_v3_0_stop(vinst);
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	vcn_v3_0_start(vinst);
+	return 0;
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

