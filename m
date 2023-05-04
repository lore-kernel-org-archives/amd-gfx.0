Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC884C77B78
	for <amd-gfx@archiver.kernel.org>; Thu,  4 May 2023 15:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D65C10E14A;
	Thu,  4 May 2023 15:51:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9DB10E14A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 May 2023 15:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTJkBqRRIVwWfB6glEJCA+JbVTTb+jHcVwuQTK2N1xWP64mmcUv7+c7W+2iPhYRJgJqjz7f4rbF5vGL4+e8dHPtcF0muYQJpiJJXleIxmKK974aWvuoQfOCQklAKCFh1yssQjGo6MjQyQbS7AP8203bEUHfZvXySDz/eZxVm+/d0ikD+Hhik30U5f26mbWzRXI3AMpBOZ3dD8DTMdW03lka26I4PVOowFwcdnKITj4xYaTMw0T8EZXmCHkW9lNbWD0PbMfEoY0FKw092I87IvPttoFOVFfdNfY5F+NfKX9WQ+dVNyIg3M/NoEL3clBfW0hRogjGA/oJ3HtZ38V5LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJG8PCDKrCrauFXBi9tZs5mmZ6AIa8hgynPoYxbXlsI=;
 b=afwyHUDZGAnrz68sQ8bkEZbmwwSq0mJqtzhwp9C4O/KlsWFt+RJem7D5T+rJGZrf3MhzFYYMQ+2LH2rw7TsxC7H5BkQhP5fHgKX5WPrrCnMNcHGvHJV+CV+ZuBnai3JlES2xaqQI0A0bQjZaNIQuAS+RfOrUuaIvXoPUHNR4RK2F53US3r/L33WHnzM/qGy6uafaKT/7gtp9RIdnqPnIwlxh79EoovLZJT7Kn48Gel/bCxK1bblqF1z5xSdjTTD1p6aRZbMCdDYx2Iy3Eyd3HGHjn+tVjm0K7ntmWUJ2oHfju15TtbiePLdMqLGUtbpkVnQP3pwb6R+kkchyESBQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJG8PCDKrCrauFXBi9tZs5mmZ6AIa8hgynPoYxbXlsI=;
 b=P+yFBPqg+XMf9ui9/scWO6pRaszf3gxszYsunhT2PiV4thMEYnck4paOFiPpS2iRIjn4Cwq0vMavbq66r4HS249BTj2bqukewWD/ke5woX0COOCRL2JeJwEGuIndurHqs+GijYc0ZgmAAL3isrjcQkJHegTKjGKv2UtDNPv/OT0=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Thu, 4 May 2023 15:51:22 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::59) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.11 via Frontend
 Transport; Thu, 4 May 2023 15:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 15:51:22 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 10:51:19 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: adjust vmhub flush tlb iteration to fit the
 new GFXHUB/MMHUB layout
Date: Thu, 4 May 2023 23:50:23 +0800
Message-ID: <20230504155023.1415369-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230504155023.1415369-1-yifan1.zhang@amd.com>
References: <20230504155023.1415369-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c12f333-bb17-4392-0bd7-08db4cb768a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8cZ3uqWdbenPvSw5Wb2LVzJ0WvjMWAZD8Za0qFMohlQljctUrb1CiV/uGz9GM9MAtdeiMTqtqliNjz1JjG/+fLUnE4Q1zeAllK7GqecGwadowf4M90fYMBHnWFWuRL64G8PAYYXIXpyA8l2u0KbVx7Tq77lqt7smOrDLv9rjQ0HqUL9lY0xBQAk3Lb7B9rpXPyvStRFn46kMWb2vxLK8XU+2+Xy1IUhUYWVCLwfbEXzgLBfQIjh/hfv8vw3+1j8Y00tz9RicI+ffVlguxEog6FeyqJplu168d7ZL0A8vakeke9yoSIbTD5+Ulp30fYNO3UoVjo9rFsiqRq/fD5DisCvCohB3of3Sa8rm9dXRbIqyiA6ZhPVD5ythkf9kuRS5Dp3a6L4Vnh4KNdSiaeKF3pUZqmeHKhCfC9rZnMg48tFZtp+R7u/A3rY/Usny0eKbvnM2CXGHVbUgrHetvWfKFG+6w15ENO0KWhzTHLg1/RGWeIrTdv8qaxg15zXIE7/B2dmGACEwbBmeAGd7LF3wJIHADFrqKFg6/P8EbL2g2YlWyCbTUpLhnjd14hESwFf1rO4jOn4p2KeKg4fggDIdgPtAAjyzNWUDJv0/zbd6LQK/w2B6gSEYAMLniZiM9Py5OI0hYwLRn52JBgyAB9kJyGY2oJVxoevyFTZKc2NB14xXvo2iSNVykw+K3V+0Rt224fnM6UR0UurgvBP+hWcYKY+8s+p0mub801AeAzVOeM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(54906003)(478600001)(81166007)(41300700001)(356005)(316002)(8936002)(8676002)(82740400003)(6916009)(4326008)(70206006)(70586007)(36860700001)(2616005)(16526019)(336012)(2906002)(83380400001)(426003)(6666004)(7696005)(26005)(1076003)(186003)(36756003)(47076005)(82310400005)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 15:51:22.0386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c12f333-bb17-4392-0bd7-08db4cb768a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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
Cc: Alexander.Deucher@amd.com, le.ma@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

tlb flush has to be changed for the new mmhub layout

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 10 +++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 01cb89ffbd56..2383db399c95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -160,6 +160,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
 	uint64_t flags = 0;
 	int idx;
+	struct amdgpu_vmhub *hub;
 
 	if (!adev->gart.ptr)
 		return;
@@ -182,8 +183,11 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	}
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		hub = &adev->vmhub[i];
+		if (hub->vmhub_funcs)
+			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	}
 
 	drm_dev_exit(idx);
 }
@@ -258,14 +262,18 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 {
 	int i;
+	struct amdgpu_vmhub *hub;
 
 	if (!adev->gart.ptr)
 		return;
 
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
-	for (i = 0; i < adev->num_vmhubs; i++)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		hub = &adev->vmhub[i];
+		if (hub->vmhub_funcs)
+			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 90cf79f8ddde..3ee7f5e067fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -331,6 +331,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	bool ret;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_vmhub *hub;
 
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq[0].ring_lock);
@@ -362,9 +363,12 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
-					gmc_v11_0_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
+				for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+					hub = &adev->vmhub[i];
+					if (hub->vmhub_funcs)
+						gmc_v11_0_flush_gpu_tlb(adev, vmid,
+								i, flush_type);
+				}
 			} else {
 				gmc_v11_0_flush_gpu_tlb(adev, vmid,
 						AMDGPU_GFXHUB(0), flush_type);
-- 
2.37.3

