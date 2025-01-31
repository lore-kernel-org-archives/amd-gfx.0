Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A72C02197
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C7310E3D8;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXoZY1Lj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F73010E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOAiKBuH9KBgJq7rcojQVBc2dh5n61Goe8BY3XICK9yRUvwsjGIYkp4ZjFzxAgWyENJGbEYWgaMbj+81FNf5Q8VVdxzQx/DBFnggKjz9gMIDu7kcZE04kSUapyRiEde6O+lfehHDYt0bP/Fpcaibj9F92KM2hi+vFaMyW3mpgRTQiMk4OshsEN08PRU92uXUu66MrcAcbeyE9MzIVoDJP3WdYl/c4cQ4aprUlkkEkqTXexL43vH0Zx8zDTK/inqWM+iYZuHQCW9XkzOFR8bGm4Gw/SF0Go6MK5nNMsBUPiR883aap3muSCA1KAvw4EKMsF3DPfdcU3R3LsnZRh9Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXE5uBkqqVp65P6ZAhF8a31gMdSbR1M6LVjvpqp4rnw=;
 b=T7n8mSiaFkV6aYQMsKUhat6H7G0b36zSVFd2qG1VOcpREj1sZFtvf57cXx2XoFjf3FGxm+2tC0ZJH4lxyTEvVJrwx8GuNa/AvI61ySETzXA+p4rMNeeKdMufjfmxECmlSDBe42mf30hWs8sZPGRB0muJJZzQ/QJbtRokCXv+eNl2udQev1/guTmMmc3b9uRMmeiua3N/5AYe9A6swWmyIKuZ4ul/ldiM9BjrD5miUI1kmeeNbRourdkxUqGSY+BdM8IifK9gyjb/rK2ZSz/bwxXf9KmIC6+h3fYiSLGjGzFW20jl6IVx2V5gSAY5rDtSPe2bkA95dtMpjsBVcdfy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXE5uBkqqVp65P6ZAhF8a31gMdSbR1M6LVjvpqp4rnw=;
 b=NXoZY1LjDqGcLUThbIR7RvaZWxxamjMG59xybDXmZMN9t8ZBuJ3Sa9dPtheFup9G9PjNJI+c3muDlXAicXLb5O0+/MSJ/T1FphZ7iTL4Yi2VOyOqSfZeEoaY07JH6eN1+iThm8rsQsMaNrDmqIAvZmuy0N8ItGZrjJXn2jR1Pd0=
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:18 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::a2) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/44] drm/amdgpu/vcn2.5: add set_pg_state callback
Date: Fri, 31 Jan 2025 11:57:21 -0500
Message-ID: <20250131165741.1798488-26-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3093c3b9-7e3e-466f-46c5-08dd421875d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukV9P2x1xaQnLM8EssAR2OiRA6gInDJ46PMsyNVtqMUZeKPc7UtmLxzxzeZa?=
 =?us-ascii?Q?IHvQw1xjDSVcHF2l68ilCJvH/W0zNRCFBItl8u5mZMi5sDgQIerPtpookyWW?=
 =?us-ascii?Q?EL74a7Bo0ntGUTeMxC8VU0GozztxzybjLhFzYKuuCgZrjk7lK88abuMbTjNs?=
 =?us-ascii?Q?mlPnsTKLZT4wXzkNiws5wFVKE/hqFuEhbum3hi8wGiIGOEGrNCOEalNADAV7?=
 =?us-ascii?Q?/OVou0Rj/n2jL3aCHd6JxWrBnYV4wHZPSdpRjby3LjZXjlG5GOz/bbU1AIZZ?=
 =?us-ascii?Q?iF5l959ROLV8PJW7AtaSHqhPIx23KUkrgLOTIsSOonYssiNTfFZu630QinrU?=
 =?us-ascii?Q?zXT5ptyCWQlxns7CGPAh38mXdmPF4/Qz6GuWR0bxgZ7YNWMgTjbtSIfFUF7D?=
 =?us-ascii?Q?onevWEUKw/VLbOE02l78BG+n39B/DJA8eQrSM36jaHTJjKxXPBrtUSNqY5oX?=
 =?us-ascii?Q?G2Nqh+aNjMyxoX494YVA9DpQ9eKJFprMN2bFAtF99xcU3/rL1EnhQpvRe5Gq?=
 =?us-ascii?Q?120r+y0yQvJS1o+5SpIRUEIenUt4M9ZH/Xljc8impGNJP7e0658OOJIZZliX?=
 =?us-ascii?Q?2d/ukiuwjtMNC/7NZ0njG/496MLYu01rjoWkkmFuN2iLygtvSuaqtXQNUfu4?=
 =?us-ascii?Q?n5VuXEM65KDfi6ajz+CeVtEzpGmjyceHrhWGeKBGGFC2WjWeeww/JtF2VGbx?=
 =?us-ascii?Q?kEhyS1kaHC10AV9Pk6iTz2Og8FRqLfHh/MPyXlNlwGk896rzL6kzl7pUF8Xw?=
 =?us-ascii?Q?9doAWy45ecf7VlpcU9yhxENmJLupeJh7EoK2Hfx4K6V8fqejXnqyNDqP3woR?=
 =?us-ascii?Q?8rnFLACmc+GEPNwjXvbNHFLU+wQiuda74+63ehyq5KTl9o12GfLaUAytAc4U?=
 =?us-ascii?Q?uAIuimExPUmOD/gbZQMNZvWnrQD8o46C92vWaw+ZSrNyCz+sF+zwyA0Owhi8?=
 =?us-ascii?Q?h0IWUjClKinoWco1GS20YlOSGEJJhwqPOYGXJvInXwoEHSI0D9/2atMT8Gb8?=
 =?us-ascii?Q?FmwpqxYvZbZ+dTopP0+xZt33v4SKz25nJ/t9djDXVtfi6yi3NSFucq70uwfj?=
 =?us-ascii?Q?rB1rtbH8jR2ZvzyqgELqg5aetRo/iQONpkZwhKfopFP5Laysv4GU9JYJMHjP?=
 =?us-ascii?Q?i5rge1Z+Eux3PbnTohVKT6k69PeoRmQchZUL1IMMPPIKgI2ZWUtp7pnp6C48?=
 =?us-ascii?Q?1K2OoOXh7dv6MS9WpP8/ieflbzarsyifHnysmQth+NLORA64PMNki45nt0wn?=
 =?us-ascii?Q?EjuEwOcjbzhDYs/7QUlL1EgPYv9m/25JcUf/A9qe3aOEYg34SeB5aAL39f2+?=
 =?us-ascii?Q?U9CGzixyaeA8U5vhsYqnYyG3RRrHv/pOFIzsQIdoKhuEPB3P3+1jpSBrst/+?=
 =?us-ascii?Q?BhFnu+DbEPsmZUZ9Mdgd8TUiuFZMAjD6QLEYNRFnkzhwSo2gLHNck8ay/FgD?=
 =?us-ascii?Q?v3ocUG11c0UwH5nPX8voiuJ3tbuhPxuFpaxkHWRKXvU9KKCecCTHQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:17.9206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093c3b9-7e3e-466f-46c5-08dd421875d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

Rework the code as a vcn instance callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 37 +++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d5921a954948e..f5889d1bd0d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,9 +95,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
-static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i);
+static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
@@ -150,6 +149,8 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_ras_funcs(adev);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].set_pg_state = vcn_v2_5_set_pg_state;
+
 		r = amdgpu_vcn_early_init(adev, i);
 		if (r)
 			return r;
@@ -400,18 +401,20 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		cancel_delayed_work_sync(&vinst->idle_work);
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+		    (vinst->cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1844,18 +1847,16 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
-					       enum amd_powergating_state state,
-					       int i)
+static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				 enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+	struct amdgpu_device *adev = vinst->adev;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev->vcn.inst[i].cur_state)
+	if (state == vinst->cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1864,7 +1865,7 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_5_start(vinst);
 
 	if (!ret)
-		adev->vcn.inst[i].cur_state = state;
+		vinst->cur_state = state;
 
 	return ret;
 }
@@ -1875,9 +1876,11 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
-							   state, i);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		ret |= vinst->set_pg_state(vinst, state);
+	}
 
 	return ret;
 }
-- 
2.48.1

