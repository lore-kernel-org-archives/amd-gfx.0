Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9922E7718D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2297610E9F6;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z4Q1D2s/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302E210E9F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiTIrA33npTqU3l20r0DJJxbcPX22Xjmd5V1rdl/zZJt4m4ScLk2i19BCquQ0RK09ZzsBCTz3N4UEm7lvPGPCoBPTNtAFlqfOBpjIjKwRRwBXcCvX0vi+Ut61QbY558GZLVhASUy3TsHGuAwVdVaTfsfA1ulIOZf9EwIdo6UDBVwRsoUst9jm1KezDFU8F33crOdcNFSeuolykmhmJ2EP/qM61/yW7oJ8wZAQHOXE/yYZcR/JxElj13bUV0uAsoAfFjVbgM+u/j6fhq4N2wZ8YkHHXsfk0u7LJTA1JNKw2fseP2IiOlVX+e/HAcVJoWWjx608ON/FoG889JH71dlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RN1FhMT0dwn9TyJwXnwVE9FegAxFeaFm7cT3kCueBU=;
 b=O6PDjRqgVJGagrnyHLDGE5klZgkiGFFt567QixCxUBgG4DI2QbPyUgHAB5obGQ9Iq1ng54GYZFkfAyKKRniMLvG0yck0PgrYc7jtxFdaMhMFM4uvFK0KBzFSAH1kT9Ky7LYkJgL1rn0RsV+mVsFMAsFV2NW/KyzK1iNybI8hmqf1nbbgZRszCMF9HfXwWbzHQqxRit9y7yPH7KssaovPaVklLsy0lc3UpZn1MbBGdKm8xSDpnka0wtPNV8AKx07ktlvBAeTBvKPykIDlm3+JSarCcNiEiZ4Jj25GArRBJcW9KW7WzJkqg/CAu4PKsWaO3e8oVLZlZBGWIcn+TtO1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RN1FhMT0dwn9TyJwXnwVE9FegAxFeaFm7cT3kCueBU=;
 b=z4Q1D2s/UykSX1H/RHDsg7keOty3Hj74vLtdOWMvccDgbfBe6rqdwRtiybw2vWM0KLvEORjSS0ZJV0EYquPzZn4b72Gd9dSxyfrFzusxHrOofmMfzdGrlNvUJwKAoae6vHAODxSwNRstFlm7kykEZAcStCZVEAYtA7+162iZiuo=
Received: from MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43) by
 BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 22:54:16 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::cf) by MN2PR01CA0030.outlook.office365.com
 (2603:10b6:208:10c::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Tue,
 10 Dec 2024 22:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/48] drm/amdgpu/vcn4.0: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:27 -0500
Message-ID: <20241210225337.75394-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a819270-ab7e-45cb-7078-08dd196d9334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2muYDQ1CvXxKUhFNkxdPKGfzZ4pjQvCjBG35wBOGytsxoPrfk8MtWE2V1X9g?=
 =?us-ascii?Q?ROJnsYp4p6gm1fwZ6PxcEBqVgR+1zjEEixkWZ9+xjHFuUZZQfw/7Q2G2spmI?=
 =?us-ascii?Q?bur+NdoE+gJuiKcqVepv9XgjlI8iA6vPCX+U2apcPKed6309Uf4XXOVGnMh5?=
 =?us-ascii?Q?W8k+oKoqN2at0xFvDPnkSffgAXec7qb4o5JVF9Re5pQrb5ZBQFcHfZWk0dPw?=
 =?us-ascii?Q?mbKQeVRtfJJI+Lxh3AUwGVF7pr5QyJ+48+KXfyT+NU1Tx76JXr/5nAsdb39O?=
 =?us-ascii?Q?KPCGoER4IHV+ewOS+3osHlX5XFS6ZkXXl9t9zgUUOZmmaxMIsxf0X3sn7KMI?=
 =?us-ascii?Q?r25IzHEQEf7kzDveIgCounJiEzfS7SlFZQlYiiFJOXXZZJ+zgINq9ekGbOq/?=
 =?us-ascii?Q?CRZ/h6PSSv/tc5VgXJQ1mlhkn1zP3YP0B+5NR0J+zWAk4aQG23MCuWUtrmGb?=
 =?us-ascii?Q?28LC2dhCAXT+UMR83/Nzhb8shw5gnp1ERc4gATtSDXY2NOnZV/9rO5bcpxHG?=
 =?us-ascii?Q?A+7VgQxpsLUezMIZyJOwNgU7JlKXxiEU3XB/3qxBtKIvzkR8gBjqdb+eLJ95?=
 =?us-ascii?Q?92tbrvnpDNfyIOxlFEoRT2P1Yjbk12tPencdZS9Y6wVZPh/6lcd1Gko1XQxT?=
 =?us-ascii?Q?I7ua3loYBQiG1vDl/vA2vi7Q3A57KPi1RetLXe/EC6LqHfNYXndcrGc4RrrD?=
 =?us-ascii?Q?j8lwD+sCGzaxbzatDwF+demE78djf917y5qYe/7mODrXkSXDJpLw/EPy6RvZ?=
 =?us-ascii?Q?Vke1Y/oXDaKEK4GyDv7UeE4nDZHdpMIyjixYdDHED+RHVwpJHEK3NNNdnme2?=
 =?us-ascii?Q?qCKZAthUTZfYX9KW9m9atwWS7n7cneeAPyG9/8bINqQdQzUcN+/YDO+B3IWf?=
 =?us-ascii?Q?A7eEzROjKcPgH4id0ATW9bXpRRRWoOlbduUS8zWvO3gJvvNAHhFWN88Y+ybB?=
 =?us-ascii?Q?ec+Qq6pTQkMDO3Vk+kf2Kn9T1og0fPMdoj8HIPsNq/4JYLGtRmiF+8+7NwbX?=
 =?us-ascii?Q?Oj6kNvcdK0Zph+w9i94UOPNadIrMkfWPjyEFNdj6e8hw4qov93+LLF58hlr4?=
 =?us-ascii?Q?FQ674crdEGtX+/+OWfT2Z5ThL4V7jQaQAhJAF3jHQmtokVLvmYJANQFf3Sg6?=
 =?us-ascii?Q?7F76YZx3RpUc+hSonBk7j4Nz4m1QzkvBVZx3nCrmHNgsFXMJ4ZXsKZr0iUKw?=
 =?us-ascii?Q?JHZckQRHQ74pmAFiFf7SrmRHvjFATo91IZoYaypjo+2Zsr/8Pfq4zEok2JMS?=
 =?us-ascii?Q?E0v4Hvh8nEixUyoD5QUla22qbCoAu9yCSe7r1U2B2itqFTW5Mqdg9vQY4F4G?=
 =?us-ascii?Q?9FjCLUKB1UqRw+TgymUYUMmNxaNRIzdUbEEb+hVrFqbvUjRhL1DrGUEWYBAg?=
 =?us-ascii?Q?rb+VrZFFSJRxSBNPOcp0EUC/8lNX9anlk08WnGvXB07RWo0FWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:16.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a819270-ab7e-45cb-7078-08dd196d9334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 790b533605849..fe93d65a7684d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -98,8 +98,6 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -2109,29 +2107,6 @@ static int vcn_v4_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v4_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
  *
@@ -2300,7 +2275,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.is_idle = vcn_v4_0_is_idle,
 	.wait_for_idle = vcn_v4_0_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_set_clockgating_state,
-	.set_powergating_state = vcn_v4_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v4_0_dump_ip_state,
 	.print_ip_state = vcn_v4_0_print_ip_state,
 };
-- 
2.47.1

