Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80961C0219F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC2310E3E5;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgGPo4RL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016D310E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV/i7bGCaxN/YuwDoFJ+ey0+86lqzND3vyUxf9yEztbhwNgGYVGA4Wl5r+ROcstLUlRjXzYEfWvqR+zTTa3FNA5asPFX/WsVLMRv3Qh899vON6O6r/I88s/UnuSd6I32C4Le7p2JOnQWrE21+aYQQ2DiQFuQe5F/LFMMHPRLnIb2wago5bgHsf0SZgU9FbOH20cY1ZW91lpqZw69U02AOLYjzLDl7rKNTwL7zbTMPmOZEvAAj3z9DdgPf44tBWWvGYgyxs5tcnNHjL4FweOlEk4Yw194EOaw7i3g6fgDBXufOGcDMvFTVjiV0ewUuNhi/NBuvsEXyDc8/r9xUrb2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3ZLdjuHcp/1ocw2kBEb9FeaH7jFExdZ9cLriQUPQk0=;
 b=bvGjKUF2Zv0omjTEEh4160ArIm6uvZhjvPGgt1WE7YwkS0l4p+tiqBU6LtAwdubw8/z+W5wUqsc8+AMoknXfqFENH3r0BZvV+CJXqORz7j1aT29Vv0P4k3+ciaUqlN5RH3RwBKaNik4+TBK3EX9F9tcqRvBz/IF32OJLRNQoJmSf6UM+s5LAk/sMp1tOXkaeuLL0uodm6DrL2hOZNHgzG+QdKTg7tDOhO0sto/OMvKkPW2GegfnJPDV1vP7DplICQu/r6hQsY/lIR18iv097s3q1Km0/FjhmzIFmxUlPV6RbyvK4yiwwwJm5U04Anr67I0r0nhSsKDcqjJAvN25zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3ZLdjuHcp/1ocw2kBEb9FeaH7jFExdZ9cLriQUPQk0=;
 b=cgGPo4RLC5YZ7WdC3xy74kbamBo21WfjpbySCNETUFNlW4aHDX9/qg8Mp1d1nz22bHbTGrIPlQj7ooXvFGrvyoGXQlu8oWUpoCqCSOtJmlQrgcySi/tzAlgnvaat7Po9jYyEA8a9/cVhIclpJWdqfLnXFufDThu4nrwnH3fHGYQ=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 16:58:27 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::65) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/44] drm/amdgpu/vcn4.0: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:34 -0500
Message-ID: <20250131165741.1798488-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6915ff09-7745-4e5b-a59a-08dd42187ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1mn60FhnMT5515oXsx81wkbn2M0ESbF2DyAWPPybBuxjNaxojEd+95mGRGmG?=
 =?us-ascii?Q?Jdbddyfn9eJbFlYXy/0ijhZGJBk2doWN7T5x+SSI606V2VjPzHrAeJyzfiJh?=
 =?us-ascii?Q?X2IJusfJzMRPHR4j7E3DUk7ZTu4zd05Z/ENiQvkyt4Im+kIb+/kstVpILyjq?=
 =?us-ascii?Q?4VFpYH4aK8IaG7hraQyDuNg6EhAqIXAh7h+EWpWlSGekfMiKUX3SNnw+BWAV?=
 =?us-ascii?Q?YuTGfJtQjjPvBuuJrw3UYGcUPfEgb3GAFltElYFbmLmvk7shVLa5TP6oymrF?=
 =?us-ascii?Q?hkod+P2ttw0EJdmMbZ6XGGEuybyugC5Pc5DpduRhmI7Hgh6195zT6wfT3Fhh?=
 =?us-ascii?Q?vj9tS2iPhW2qbe9/nAE8oOc9/+2JQ55WzHqdUJyPkNxNBmmxr7TbYIV7IMD2?=
 =?us-ascii?Q?jomAP+5UESbLb4R2wyq3pLFihtlicIhqZDcGUf/YSqc6bST7lvHCeOECDvw6?=
 =?us-ascii?Q?wRIpfMi+ptrgyV6KIfouoEAEA7d11lUBqznfY8cIpCSjBouWS6n9WL1UP2C9?=
 =?us-ascii?Q?zuc5OiqrFD43xgeAAmTh6312xCKAooY0cN1ueLGhNT9jdQ4Begcpal5luald?=
 =?us-ascii?Q?rRFO5RVO7lkHxHjiOE0OtYZkocn+ZmtlHR7FCGavsbc/1Y/IywCYPDzEBu0A?=
 =?us-ascii?Q?d8ev586fXMkzIst+m82xReS0Mz6Hx9op1VraVPgUPkh/X2ofVSsUxHndfZ7m?=
 =?us-ascii?Q?QnZ2Gpd0fj6Nq1b4cmz2JVMFM59taLXGwK3P/JY/y8P5jBfzH7EbcnF6E5Gd?=
 =?us-ascii?Q?NU6LZxae9O9m74Q5oRNUYeh+LLT+28te30OCDtoXIabVwRU7gXNijFRKJLGF?=
 =?us-ascii?Q?acYe9OiThMYbHDqpAPujPYaTYs48u5s2rDwRvbwRNIhWOa8l25zwsvSpefDP?=
 =?us-ascii?Q?MS4aO5Bb2NU/pSCzffpla5ZVkb5nmG6IE+FBzpSm7GJ0Lp/VnawqS+MZh6Lr?=
 =?us-ascii?Q?84ZG2hGO6h42qvCD055aWvcZKuOqSRkIATxTUmqrb7+KhWUv4tNtrVPwqwk1?=
 =?us-ascii?Q?fEF8FVWQU4Tq6kiH6cQVcAcxprswKOfdBt9E3xz2yXE6jjgrzpM4RbhhoIzS?=
 =?us-ascii?Q?OuRIPjyaXzn5hW5FW6Hrhg4RvL/DWSe3Y1BPPsvxoNJY2no24jSkNduhFiiq?=
 =?us-ascii?Q?hU2kWLsAlbcEQZyYqwYf+0goDWesFtqTrah26W2931JdTO9XTRq8MOGgI6kp?=
 =?us-ascii?Q?qJ2aR/fe5C1szrXtpXgpMVI1pi/Dq8m0spbGH8CnhmkjDXPgIRrTABXip0Zb?=
 =?us-ascii?Q?iaAkVbSFtTOwpj2L+XXbRajyESbMPxy86sypspN1Qsu0U3WFr26DgxSqKb5n?=
 =?us-ascii?Q?LQ9fNhwEGBHkfMKdsT+Dc/5HLBIU30JdUzqOVFv/5hjrJbUjTE8GGayHPUc0?=
 =?us-ascii?Q?SL372/3MNHS/cdfl3m0e/kNyt6TrNq1jXgRc2IHmcmEtZNeWbwiiVT5c88hV?=
 =?us-ascii?Q?5WEOT5hU+KgjD/BfTbYRbB29fgE9B+Kqa6c4VgxAIdW9kZBjUtq/sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:26.3837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6915ff09-7745-4e5b-a59a-08dd42187ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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
2.48.1

