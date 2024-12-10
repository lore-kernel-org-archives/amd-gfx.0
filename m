Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723C3E77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C584610E9F5;
	Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4efMrGII";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDF310E9E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSSY4eDAMm5odttVZwhZ7vCmn7LVst1s//2TJLCoqQsfoUSKT3MXWRTpgssqhp77Cw5no208gzlYa4vHxDdRMa40Ht2lsQwlpbSEj02w4zqJro1i6wDMqFzKUjEfLSquRj5HhXJ/FtvT11K59UVag5pE+OWdgNxhh5kvqZZa2R+RDXtUVDW9SmqSmikPrp/TEY32bVC/ixKEPx4rKku+pae96VKgRN9k5Z1yqa78I3BrZRjok36t42mEgoJ465ahJ+aQC+C8lDFlRk+ByJYleJ5JrOMP2ugVMMYH97g3XoaXrC0ceE3MYkSdDZ+iKhGnipZa+SE+wkOqtdF/Y2S8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28rQaX6ahKgUR5YcpQHH29dhzP1h6s4LbyEiRTKc1Lw=;
 b=e1cBGHZDeZ87zXJ0WhdBb3Rs0htuTqLj7tjgKVnUBzb8sjn7Kvhk6Ox+sCEyFCO2qb6UimjW3orAZplZmv80KHmnrh/nECy6PRJXxwlPrhgpAMkamGJHxQYjixRSDoThysyztMIK2+O+v1JLAqJwDkIYvf84v0fNeMgyWAvNbwxnKbzy1n23HJxCABSkZpO6zRhSKRi5cG48P930OgZ1GSRLTTXx8lsturuMpn6POvwnyYZcknvDOq7Vnfz297jhYzB0k4Fx/McQErX+tYbvMXQZawToIzWE1U+LFQ6BqBPXiRxFIIyMDFRKDrU73jkivTeaofFBFOXXQrSevw0xsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28rQaX6ahKgUR5YcpQHH29dhzP1h6s4LbyEiRTKc1Lw=;
 b=4efMrGIIHjOknasQMZaC3ozgJr/5oZzhVsnyjfQbNK2bAN6gogbfZO82To0+py6aivi076KurXSV0gPe49KzsXjCcJnbRxxCozgw8mJdQKBJbCtWYsVHTI+RcDQcQwLBirdREHt/i934JrO7FPFKQKTxH87ZIdg6zqkWopewGWE=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 22:54:13 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::d3) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 22:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/48] drm/amdgpu/vcn: use per instance callbacks for idle
 work handler
Date: Tue, 10 Dec 2024 17:53:21 -0500
Message-ID: <20241210225337.75394-33-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab3664d-55e2-45f7-df1e-08dd196d9175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MGW9CQ9daUBA09rNZ5YF6kRzmy62BN5YJgg5hCuq6wE9p8ItgBluv60OymDn?=
 =?us-ascii?Q?nrNmEAUnnIn+/Z/E9sUMnkryW0mteT8ioCR8UQGZGYi6WLFikONa3hen2i0Y?=
 =?us-ascii?Q?6Y9ckWVAmdfYnVdt3dlbbeqZKgQCYBmA2VGXRGkPcErtx6PktGAqESkyamwh?=
 =?us-ascii?Q?k8rjWGH1AD65wWSg6gX0hcl+ez7tzMAgwa7PSCrku4Z5btlRMN4Y9ba3Zydv?=
 =?us-ascii?Q?5MqhGuR2R+DHXCcbK5k1D/ufrAknvvCC/kVUuIBElDzthtet3hdACR6nzjeZ?=
 =?us-ascii?Q?xBAVgp/aYLVvXBghU92q0XQO8ouq6gKYWf3cl4ygYb+KZ7zXZzf57Z9fFucn?=
 =?us-ascii?Q?NMaj1a6TbRdyRSQnBuryLRi/FwRxUm9TqIHicfnKRzNqlOiIcr5LFSJ3L6iN?=
 =?us-ascii?Q?Ikhw5w9eiGaBkCJWxtWXRa/8Mro/BEjPyeIk4f9Om9giSKHrsZHQVmq7u7h3?=
 =?us-ascii?Q?xi4vp7x0g6zuoA/eoA5QzNpRt6PANHOcjYOs8qZLSoXsPhbg/zoWNBRepLCF?=
 =?us-ascii?Q?guZ2JJPHteqNIvMbSwjxEyKMKcm8C/2XnQomjA9Spznjj57qLDMyrXIFy8oS?=
 =?us-ascii?Q?NaF0vqcBKj8A1uVJZmTvF3N6x+R37EH9UCY48Qvbkh/X4xa8/2OZ+t4EgNrz?=
 =?us-ascii?Q?zhQZRLpDzcURJitav/6APtc7O+WtDuLcjlcXK2O+NCI06D/45/lxvTr1eH5P?=
 =?us-ascii?Q?xbElT/12bCvHf0iNQ8n+HlBiHkYZIufAJYz2Pkwoqx0Xy68phSLqPNw9B4Aq?=
 =?us-ascii?Q?7f7VvPzmIlSAdys1WsjbbpNDp0vWmEbKBEn3dQWTfiBA4qIOkHLdIAl94DSu?=
 =?us-ascii?Q?NwM6zqR3TzhKXFcTAwjcYZfq6mbmeVa0dJlT2jC6ZF75x8wPkCME2FLIqNCL?=
 =?us-ascii?Q?Bfj05ezQ+Q7lnWXdFbcLuPGNYGxsXi5QcL58T+sX1s705rmF5ux1fgwOZ8TG?=
 =?us-ascii?Q?qMIMAFfQTbKQzNcuqI4CQMOnDq0Bp4ajrwdPkN+WjoX5XJ2NMUodwRyF5gBg?=
 =?us-ascii?Q?cwJPEHvyCSxfWQbdwm4KqtJU+Z5ouy2aSo2E0R/yiwUQ4ZWjxzpylgp/V79V?=
 =?us-ascii?Q?7KAA4jKBB/FtbkaN20gEyCTQcOaiH5t6pj1Ef1YBUDa/b4JyXhR2Cc75UhFE?=
 =?us-ascii?Q?4uX4MMZ6EpJtV81LYv80PyCNFNiegV2bx2Q5Hwqw6VUG6qFxI1YWwZKcNMms?=
 =?us-ascii?Q?k159TSuRsKHvv1rcWVgMdfikYvkcoB6LxkAXmYlD4DuhD5MdPMsEVqkVmQfn?=
 =?us-ascii?Q?mbuiq9R3besSNSchDyuPv/DTQ3cXHMYRqlT12fdKMAGgdJ8yjvHpU27vk5j7?=
 =?us-ascii?Q?vja004N1cSDToT9o/4hUBPMD1LdSBE4yb+JXV97X3nU2rREqaecqRI/8ImzZ?=
 =?us-ascii?Q?al6G+qS7rD8y/WqPfi9iEuTmoFLYXJ/CJR49qndOn17+dR7frg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:13.8247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab3664d-55e2-45f7-df1e-08dd196d9175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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

Use the vcn instance power gating callbacks rather than
the IP powergating callback.  This limits power gating to
only the instance in use rather than all of the instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 750cee0a8f184..04a95365b7095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -424,8 +424,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-						       AMD_PG_STATE_GATE);
+		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    false);
 		if (r)
@@ -438,45 +437,45 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 	int r = 0;
 
-	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
+	atomic_inc(&vcn_inst->total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
+	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
 
-	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-					       AMD_PG_STATE_UNGATE);
+	mutex_lock(&vcn_inst->vcn_pg_lock);
+	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-	    !adev->vcn.inst[ring->me].using_unified_queue) {
+	    !vcn_inst->using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
-			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
+			atomic_inc(&vcn_inst->dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
 		} else {
 			unsigned int fences = 0;
 			unsigned int i;
 
-			for (i = 0; i < adev->vcn.inst[ring->me].num_enc_rings; ++i)
-				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
+			for (i = 0; i < vcn_inst->num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[i]);
 
-			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
+			if (fences || atomic_read(&vcn_inst->dpg_enc_submission_cnt))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev->vcn.inst[ring->me].pause_dpg_mode(&adev->vcn.inst[ring->me], &new_state);
+		vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
 	}
-	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
+	mutex_unlock(&vcn_inst->vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
-- 
2.47.1

