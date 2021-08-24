Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03794C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86566124B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B86566124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCFF89E5F;
	Tue, 24 Aug 2021 06:11:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9443589E5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRiszhQkXbyY2LehPTaRbc1zCsf+K4E6D+VUxZEbSJ6G61X/FMePZDQEtizs57Py5InkWQwl5I1vXRcZnSsHZxyRXQjU5lBsaVs117xPmupz4uvsZ9rtx+soafsqZaAmG4lDWSkq0avEs3njtiuhilDPcoO2xnFn4d3A4FFKPEiD0UPKMWAD7qXM9dXrJbBNbvsE4jrejArxQByLGa++l4mToNZ9CFBzNqqAncP0nNOBFQp6QscHIv1eiSbW/Na43Bod8q87G6uaCB761MSDG4P9OhgXoRxZyOaePhq6GLqNTAEdASV58feI6SC4lSnGmXeJ3HnO/KzsvE2KGCwDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QKV56vujsLCpro+EI23REe3vcBsa65GFQJvB8kP7GI=;
 b=S7X7ycnHwPMWhsoTn3eZ6mws2rY3vEVld9uSj4JN0OmRc3YLXJqd4MNtDlFfUHyWcd79a1FER7i4/ujcqw67ujuDcowVqb7pZ7jw7m0b19NqWArmMXkxfNmcf6n2BCjNj0b7cTKKYK0A7qveJNXs+WHYJeaWd3DSBPIchTPUlTAmIfErN4k2uUITcwriCpzF5et7WQlI/U2xXQJ6myv8JdIgPT8ndGqvX+/v+drk2THCIQRRCkQStnZna0Sz63ul4hHhW7befdYfciqKkdH2kQNMAOdRbY4QiOiY4TeHcDyg4icqXw7WEEnhgimQJoK3ZDO5HzBLWGDyWXDq81qwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QKV56vujsLCpro+EI23REe3vcBsa65GFQJvB8kP7GI=;
 b=EOSW0y9DHJMKvnTmkY8JQMOJwjLJkuFH5x5wiEpgFXwkrG5M0LFZuU7Mv3LO++m6wbb8wdeCGIMt+/faBvC1M1Ho1UJiFsGh/IXwY4QldxfKjh/Tj6EDMuRbt7Ay85BAXqPrd0nM4mWwkf9Msgx3SG9fEe7UPo5WyXJVHx+9i8s=
Received: from DM5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:4:15::13) by
 BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Tue, 24 Aug 2021 05:56:20 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::a5) by DM5PR16CA0027.outlook.office365.com
 (2603:10b6:4:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 05:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:56:19 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:56:15 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/vcn/vce:schedule encode job based on priorrity
Date: Tue, 24 Aug 2021 11:25:10 +0530
Message-ID: <20210824055510.1189185-5-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824055510.1189185-1-satyajit.sahu@amd.com>
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0afee6-75a1-448c-a483-08d966c3e4e1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41790C0301961A46C9AAF121F5C59@BY5PR12MB4179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZOwDD93fVkssZyBXCOJINiLXeqA3h4WIQZSrPPKEHe0gXJpDPgrS5gaSkNEh57YkX9gYfcvNv2z2LV4dhU/6JaJ5zxl8M2AtApGE29Fq7FvgBVPG9SyW6FZS73HvWvbd2/aS2pZniaOjla4yP2ZaRcN3gGclgMMLgwaWob0io/su5QCNIUWBwbegMLkNUtu58PCFvNiy6hJiEuo1eZNlkxgaWzk4gcojK//ZkSEyJR/tgmilLulbwJv2OIV6JdenkE/psq6Uu02yMaz9NgPLF32qgWrzEkyht9dbBksFBBMjH28lRSWS1vnY9PoKDxl9x3FCE6192RdQJVecsYgs9kpOMx0Z+HnChUOjqx+4o6DIE/tLgNpdgHyxqS5w/jialzNCbKy6Mv8RBrfTqu0Bc00jFVvBtL2Jv0jK4chfa7DOZzWMXtvUGGShZMhQUy0KuXJaVDT84l3EBEdfMbCEE2Tycy9SpGdm/5v+HVohUkaAcaKTIh9N4oCiW/FEf2ChajxN1M8G1+bZS1VAMpLnaej0YhjsekKDIJIVwcR8X97y5Tm3/2fy9b/m3W3+oVNObtySyygVU3tANSTNcEojKk5z8g5QENwYGBHe1Cf6kjiubd5l52cjz4WznA8E/LuN6xYPoLn+SU1WDwTNsScFMWG26OryujsD5V1ZEeXXBxoEYLURou0Fk3CqaXkAG89gYdAY0OGY56mZBqiO910PUg69n8C115CH7MY2hv66/a3CdqBUG9gbE/mC532LwVQrhpu7FlW9FMefYekJCqOGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(26005)(7696005)(5660300002)(186003)(6666004)(86362001)(2616005)(44832011)(83380400001)(2906002)(16526019)(1076003)(54906003)(82310400003)(478600001)(34020700004)(81166007)(8936002)(356005)(36860700001)(336012)(426003)(70586007)(70206006)(6916009)(36756003)(316002)(4326008)(82740400003)(47076005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:56:19.3355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0afee6-75a1-448c-a483-08d966c3e4e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
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

Schedule the encode job properly in the VCE/VCN encode
rings based on the priority set by UMD.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 40 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 ++--
 8 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e7a010b7ca1f..adc11bb81787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -73,15 +73,49 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
 	}
 }
 
+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
+{
+	switch (prio) {
+	case DRM_SCHED_PRIORITY_HIGH:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case DRM_SCHED_PRIORITY_VERY_HIGH:
+		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	}
+}
+
+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
+{
+	switch (prio) {
+	case DRM_SCHED_PRIORITY_HIGH:
+		return AMDGPU_VCE_ENC_PRIO_HIGH;
+	case DRM_SCHED_PRIORITY_VERY_HIGH:
+		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	}
+}
+
 static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
 						 enum drm_sched_priority prio,
 						 u32 hw_ip)
 {
 	unsigned int hw_prio;
 
-	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
-			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
-			AMDGPU_RING_PRIO_DEFAULT;
+	switch(hw_ip) {
+	case AMDGPU_HW_IP_COMPUTE:
+		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
+		break;
+	case AMDGPU_HW_IP_VCN_ENC:
+		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
+		break;
+	case AMDGPU_HW_IP_VCE:
+		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
+		break;
+	default:
+		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
+	}
 	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
 	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
 		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c7d28c169be5..2b6b7f1a77b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = get_vce_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 3b82fb289ef6..5ce182a837f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = get_vce_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 90910d19db12..c085defaabfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
 	}
 
 	for (i = 0; i < adev->vce.num_rings; i++) {
+		unsigned int hw_prio = get_vce_ring_prio(i);
+
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		if (amdgpu_sriov_vf(adev)) {
@@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
 				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
 		}
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 284bb42d6c86..a41b2c40487e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
+
 		ring = &adev->vcn.inst->ring_enc[i];
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c546db..9729a383786b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
 	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
+
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
 		if (!amdgpu_sriov_vf(adev))
@@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 888b17d84691..9eca70d3ff30 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
 			return r;
 
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+			unsigned int hw_prio = get_vcn_enc_ring_prio(i);
+
 			ring = &adev->vcn.inst[j].ring_enc[i];
 			ring->use_doorbell = true;
 
@@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
 			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
 			r = amdgpu_ring_init(adev, ring, 512,
 					     &adev->vcn.inst[j].irq, 0,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
+					     hw_prio, NULL);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 47d4f04cbd69..926c9f4bfc21 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -227,6 +227,8 @@ static int vcn_v3_0_sw_init(void *handle)
 			return r;
 
 		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			unsigned int hw_prio = get_vcn_enc_ring_prio(j);
+
 			/* VCN ENC TRAP */
 			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
 				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
@@ -242,8 +244,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			}
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     AMDGPU_RING_PRIO_DEFAULT,
-					     &adev->vcn.inst[i].sched_score);
+					     hw_prio, &adev->vcn.inst[i].sched_score);
 			if (r)
 				return r;
 		}
-- 
2.25.1

