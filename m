Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC94C001B0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 22:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF4B10E3CD;
	Wed,  5 Jul 2023 22:59:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F7910E3CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 22:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQs1m7p9IbA9GAV+/MjbTJOBZ8lhBc4Z2PNXu5w9lUHIH3fRrH7eZJccIgCOQBMZGlgDxR+E7FhEnTYavx91MJPQbj4bjAwly/uNQXHSvf3NHFGDHPkWOkIC1z7n/5PbsYtyY5793tbJ1jHHY7jw3aXuwzl2XNdKmvPjPWSzxiS4kMVfDAFypB1Bo5bx+nOOgLqBRZdOjTKUIWCSC3goOjfYp5sDG/KTKlxy8yYE51T7T851CfkNvNdJkrmUo7C5BFc2OMi3hLpCo8WqQ35XIWzOQ3/QH0QURwQJ5XE0EDTqLhKPSbIJzyazP//259NJfK7ctaHmTnyHFa4VZTzvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVCtQ4bMw2rR7PJdFIxymAf2KI/opIK0vbJGHUhCKrg=;
 b=CJeAkk4FUgo4Mfd6VwOw6EsYXI/eP9jlIrFDRVkhMwKcq7W+T2r17QDqrzpOJ5Hdiw3SAgY9WPB/mscEiRPChZfme62Dj8jEcVN0hoWZCUbvUWrOWYv4XfHxi1QUrcgvENe4jEpkqUvlkGbqJLYa4s6a0WZowKl3C35/BDx8p89T5BLr3chrbfXEFPETeOIuTbt52M6Nq1MccncAhISs7Zt/lO3yJEqKqAQdNq9838xtD2jRWmQbdix/GizpOaYd/t4J0pC0pe9knme02E2MqLzd+31Wpd5fTQBo7bFyIZoI+jEdiITTgaYVLsfevKqNmcszueLYRa9vAE95xntmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVCtQ4bMw2rR7PJdFIxymAf2KI/opIK0vbJGHUhCKrg=;
 b=Qi8jdA0sRw/a61Indkb5i5d0M6Wr0ZVtC1AtOjw6OY0BuIE393YnCBT6WFd8dn5nzWBQ24u99cpbMJcUrXKeQ/gM4j09yo0cGD28AncFVVhVSEfu7JWplrHGdIHM5WW3Sl8ZCgh9QDRIsrolMYDmDrb+tWgKtvsLz8svtd5Ek0c=
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 22:58:57 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::a8) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.22 via Frontend
 Transport; Wed, 5 Jul 2023 22:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 5 Jul 2023 22:58:57 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 5 Jul 2023 17:58:55 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: enable watch points globally for gfx943
Date: Wed, 5 Jul 2023 18:56:54 -0400
Message-ID: <20230705225655.299335-5-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705225655.299335-1-jinhuieric.huang@amd.com>
References: <20230705225655.299335-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 47eec887-972d-4efd-e275-08db7dab6a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/Yg83vEv5jRUb7yISlfNXcTg8g1aAyIALQ0opO+W3ZwDeGndpeBOAa6wbqpCxAbVVCoO8L2UdmSUZtMfBwfta77eCyeK+0EjDoyeSwkkqiZ8bbLY+wNCwBrCwXuuzcihxZNpwLxdu5D228k+waJXe16/0kMNKClClUDd1Fn9Ck1NYCbwzO+bfNRHx/0sGvY3PYvClpCzbgYECXI4A+eqNxSRPtJ+KJCFxF+KZwR7ZWWpKQ7DJiBytjuEqcckkWB2ljbfyJW0Ciyrfy3rQmuKTcXbRrKIQCZkONINx1toThN6I5cpXq/ZgZXaPSd++zLZFqcjPdQWcrjMnt3z3Q3hMDTcB3bwyWCkX7SoGLHvC+QedQPJFzFAQ/KfFiU84qUXLTXICnQlaWHjXv6tPRGU9uzcdR8Bb/U1nOfkd+YBCb8S7/Siq9hh9atZ5qMbrMjN1TsvWDClHGBJdSk+4c1UuL65e6umM1YZpXUrVZKgy0tynPrsbBHV4+NMJ8KoxuMyVc9ZlFK/fSmlYZ0Dki/pi2u0T0x28+TBshOW7XT5YShMrgBG4briRpruvXrgHMJDpNeUlq+Nu6whJE3dl4XsJI4/NS/o1G2Hw59E7k9EArCbkHVMixLtBkg34NAsnjM3u/1EpQjaZPenJuh6B4Uk7OZSH7pE+8uSoeY4/MbsANcN5L5HpR7lfbBy418a6VUn9tPPZ4rX7YvOzFfhiHtOBmou3szBsjbEtgkRdHwNFw3pGpDPyyRL/pWbIqvh/MuNXmNOJSGQi5NWx77/tuupA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(8676002)(2616005)(2906002)(70206006)(40480700001)(70586007)(8936002)(16526019)(1076003)(26005)(186003)(336012)(41300700001)(40460700003)(82740400003)(81166007)(356005)(426003)(4326008)(316002)(6916009)(36756003)(47076005)(7696005)(36860700001)(54906003)(478600001)(82310400005)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 22:58:57.5635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47eec887-972d-4efd-e275-08db7dab6a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Felix
 Kuehling <felix.kuehling@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Set watch points for all xcc instances on GFX943.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c  |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 16 ++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index c0546db91579..d9357a61bf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -480,11 +480,13 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_high);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
 			watch_address_low);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index dcc49183364b..b4ec809c8892 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -413,7 +413,8 @@ static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_
 int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t watch_id)
 {
-	int r;
+	int xcc_id, r;
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
 		return -EINVAL;
@@ -425,10 +426,11 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
 							watch_id,
-							0);
+							xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -447,7 +449,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t *watch_id,
 					uint32_t watch_mode)
 {
-	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	int xcc_id, r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+	uint32_t xcc_mask = pdd->dev->xcc_mask;
 
 	if (r)
 		return r;
@@ -461,14 +464,15 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	}
 
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
+	for_each_inst(xcc_id, xcc_mask)
+		pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
 				pdd->dev->adev,
 				watch_address,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
 				pdd->dev->vm_info.last_vmid_kfd,
-				0);
+				xcc_id);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
-- 
2.34.1

