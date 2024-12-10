Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA79E77184
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A902D10EA05;
	Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2WL82I+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F37B10E9FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaimzTkdhqrrBOzkDKCGM0eFt+ORWt7MSoVOWgACKbYEMuJVUUKzX1jTod2dui2bzK7T0chw09iaLHdEekVg9My4aA2n1nIIHwbMPG51tUqFDP/CgDX78HxAVvTzXjDr94p5T2IpbRiiVEKa5OxkmEwhcLSLGje2PzpTRlugDyGwZxEIIaOBPEkUbYFS7RVbQJsXu0h58Kio875UiickYJ355jBNilCPMN1R3KzUwTCOAdA7BJDYhwPDUW9fLmChtgvypPGl+22W1g9S8DL2MoQYvJWjaOi5OWXC7WYQwtxqV2rb1uMlHM8twyMbi6wcWVtVquBquxr8R+oinrTfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXhEjuUCGeHDAXLrKiGab6veP+tPnrzwZujVKikZOoQ=;
 b=JeVGmA89eD0zY2ZzLSO1Q1cSO0Of44hYIUOwNIWveENj6Gf4LXWiL6pFdYZh0mKtMXghMuicn6XzkwKkNnWcUTNaGcNsd6ptJKi1RSZXVUjdz5a2GlDnyovA51FORiBe+9WXFR9VmGGgaygQkitVGgs7CV5luYPJzfrhmBic0FVJ33GmikSOp3rOr+nQO21xU0xAYEdUOeiOtbga4lT/0RtT7PTFzVmQGhmC+w+YcEPBUbv4KcQUAd6nvrjjiZ5M7w0ITeKFJhy13q9RcUnSW30rF20AyClGqq51sMtfFWyS+W2Udtf6exFaQ9EBAWmXf3dyRtjFRgQ5h9VNpPdEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXhEjuUCGeHDAXLrKiGab6veP+tPnrzwZujVKikZOoQ=;
 b=t2WL82I+eM9tzBgdKmMv/Jv1nHtuZh4HMo7q+w05DiZbjX3gz6cY51UE85B6Kk+g2m82M48M4psjkdMXdjPMRhAm666CQWdvpXd/8ObqBsFYJYrB7KuJq7zrXQCDXyVJgI80JtmkCM/7izsIX0XkXjbOqLzMqR6zXabtmn1qHAI=
Received: from MN2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:c0::28)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:54:18 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:c0:cafe::1c) by MN2PR05CA0015.outlook.office365.com
 (2603:10b6:208:c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Tue,
 10 Dec 2024 22:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/48] drm/amdgpu/vcn4.0.3: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:28 -0500
Message-ID: <20241210225337.75394-40-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd1938a-9251-4cc1-918e-08dd196d9348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6pUsupvR9O4TNVMdLKhoJ5AK36r4VUDNIjggW/v00nlziEbXSSljrrkg5vdP?=
 =?us-ascii?Q?CgRkbx3SKgaAGn1Str20TpWu75gc1C5jyAru3YYw/DB1Vyj+GOqrfLEhvZFz?=
 =?us-ascii?Q?yznYYF64b6XFSZYLgZwcDgFRtt0UgQnpxqvYPYsL35F4ZWxjqYfx+dXOku9n?=
 =?us-ascii?Q?0NS8oyViz9BZy6B4H/YtUuluLHX1ZVqNjA3Mez8YjT5Xq/lGf5gQ4MQXSDMo?=
 =?us-ascii?Q?GgZWsHi3niy7uoBXLaE4OUCfWBrFWBTHLmEwa3WoWpuxQDJV8+vAJx4ubevQ?=
 =?us-ascii?Q?NH6Xh63z2UGN2rPIr2Ze2FwAur5DzCQnL0kEqZdBcd4ClcdcLaurIRmbKW+k?=
 =?us-ascii?Q?tyyvhTNvyYJN3DNDqcXT38XewgsgZ2YN83Cqc1qPd8BVlSSrDMS1FLzxddQR?=
 =?us-ascii?Q?kTLUgPPU/lBPj93HgE9Izxb9qCfXU+o4sN8Y8qqdKj2Iq0n16NKEqn0brUlA?=
 =?us-ascii?Q?O9Awlbhhi5ewkLMyFhV9+Z9WRWR7ELXmK5czuTcRTB61Uy1hSdE35pflyWfp?=
 =?us-ascii?Q?MHbCbba3nRjeL9vMT8kJDcF3x232AUb7ELttC9zGmQWbN3y6MahJeNv08Bzc?=
 =?us-ascii?Q?yH7TsZhQXGjXxLsOe9LYQO7uNuZhLAzjdh9wJ+ld85wMDIZcEJXiVRbusek0?=
 =?us-ascii?Q?g9BoKK72r2fxeejz3gAF7a4Ui7dCs8u9oEJgIPETLGHFB5AD/ruTK8+MgEcq?=
 =?us-ascii?Q?SqsUf5tX2Rz45cMrHFLCYTcoHCS0H/fbO0vK22KQ6JG2WvtvV0jXcPi8L0qZ?=
 =?us-ascii?Q?zVbsuqSRg21B1K8HjKixbPweXHu03TjztTQ5a51i+G+5rNR97hgjBS1/FvNQ?=
 =?us-ascii?Q?jvxzkcqcxDG877huRZewKQ+C2WiISuX3P/LbIsFVydvQ6yJsDwydHBVPlvm5?=
 =?us-ascii?Q?aVn77i3HvJezXXAAvG0O09nkcKWA1iqdGRdmoMoBjjzoOtzHwKB4ZiJjUT//?=
 =?us-ascii?Q?DOjsrhjwAIPPf3uavz41lRtOmZWaqTSNrFNX0M7jHOz/wPdbzNy65J9qf1OC?=
 =?us-ascii?Q?dJr2qEjq5tZuozXGMveRYJucV8Hb76k838OX14pyy5Mb024URL3ZqYfeyllr?=
 =?us-ascii?Q?EvLIv592i3u/vXcaTlLEIwC4krSbO8mq5nh5IJdO66EkFLTqd3o5bzPUHNWl?=
 =?us-ascii?Q?E5gs793DlhxVnCwuHFDEqj5embxutnxAYX6jLCjrjp1BcqPSp1++HQ21yPHr?=
 =?us-ascii?Q?sD3ShYmKskfGkcHMAVmEcgQRsRCS5xDg55GyCtnz6V29Ztb5xWcMe6utIhyU?=
 =?us-ascii?Q?rxZx1DCwgOXJYKB9eR3dAh2fIYZxSzzv43jLRbEograQ0ZjpayXlwT4gr7Vg?=
 =?us-ascii?Q?Vzw+SqMcSebcboiyz6LM+UkEzXOKUD02pn6FDmP+EOTSK5p4+nCC7NCYq6/X?=
 =?us-ascii?Q?0+JTFkdXQajyr9op3gVi5fb3gqHwFEy1VpS9Lm80fdC7Cx0puw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:16.8833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd1938a-9251-4cc1-918e-08dd196d9348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b6e1466f4635c..01d58d3def237 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -89,8 +89,6 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1713,29 +1711,6 @@ static int vcn_v4_0_3_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
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
  * vcn_v4_0_3_set_interrupt_state - set VCN block interrupt state
  *
@@ -1893,7 +1868,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.is_idle = vcn_v4_0_3_is_idle,
 	.wait_for_idle = vcn_v4_0_3_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
-	.set_powergating_state = vcn_v4_0_3_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v4_0_3_dump_ip_state,
 	.print_ip_state = vcn_v4_0_3_print_ip_state,
 };
-- 
2.47.1

