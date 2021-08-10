Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 07:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2204E60EFF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 07:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2204E60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A927B89F2D;
	Tue, 10 Aug 2021 07:10:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE2289F2D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 07:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2fTj1tQi83U7as8LImsziPzo6U+0XP9hU5zvxdVThOMSkDPdeFnV5I4srIzih6KOnQHUrddII+Z2aClsN5xcY33/w3eUsTIW8BxbquDp40N5AHh+x64WoBu7BV2rDVcTKhztmJUdlIFtHfoIX7Pz7w2IRJ0HBpIv7kxV5Mk8xpPOLCHK5dtSPkqsSVjzoNwZkY+YdeoXxzu95qUom9crL6GIsJp1XtjanDgA+kwRpsBVpCRh0lZZYf3tBLSAD53K3DBNtPlzgHsvm+bts36SzRVefo0+AndK0ceNaYNdQM3P+P5Sc4xTpPPOId8DhqRrk+LlDepF5GLqoGOH3IP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35X4WQGf3C7kUWzaIEewoSFB3yHs55fLn1ZZ+Znb33o=;
 b=WSof+ysLVr3GNe1E1uYw+8UQWaBtb2GmmCOOBFVXqZ1DZu4x+38LQtsiGm94A8vDDC/wwlyqaNWxl1udxtsAXkwSxKFlHfA++NNYak0DZYHfzjHHbiTD7YbmrCCWhe0qOT1GQMtCuqbw8uoD75wjk6bbTJxl3Xu5iTTD/bASMWgaVaFbA9PZ7ptsr21eHE1a1e2yFfywIKJscItT6WAeRFpjFS18Kr2M+35cgMXHISUV24OOBcqUh/o24lBW/X5+SElWnrOShtgCyJCAmZZbxFbJjWk9SQW25fcYzaxIrRbx0/Esty+eWbs2aqv2U89I9LGEZybMXsjV10gOS0zyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35X4WQGf3C7kUWzaIEewoSFB3yHs55fLn1ZZ+Znb33o=;
 b=hCPRWNZcGT+TB1eABpLWblLkJDJ/d2DukY1zd/E1OCmGMvg6gnDsm9K+XHByAQX/80MAK6qspeIP/gp1GNyr4XZ7fQQ8Gbmgu2slLRydj7W3NhR0GaTe4ed62VLfUMZoo2KDUHWjlRvEuqaE+Fd5wXPhwx8Kv3jNIb8qBnSb9bM=
Received: from BN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:e6::10)
 by BYAPR12MB2871.namprd12.prod.outlook.com (2603:10b6:a03:13d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 07:10:15 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::5e) by BN0PR03CA0005.outlook.office365.com
 (2603:10b6:408:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Tue, 10 Aug 2021 07:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 07:10:15 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 02:10:13 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <leo.liu@amd.com>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
Date: Tue, 10 Aug 2021 12:39:54 +0530
Message-ID: <20210810070954.4480-1-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9542dff8-7a30-41f6-7318-08d95bcde727
X-MS-TrafficTypeDiagnostic: BYAPR12MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2871390A849FFA1202ACF565F5F79@BYAPR12MB2871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBO/kFKlb3Y0S13sQ65tEEhZle9yLcpLy2NtPlGTnXwRSn/h3P22SUTpAgYNfxhA7U8t5zVUBSnIn6wLRAsuK4WdEf0sqeB8VC6foA0M7eCAlrFwA+LUiLTfcdqeeYaHSLn5dAXXEFm1mSdMyGGB2mwY6k1e4EVh4yntX5n3GIFIjERo2u3Ul1gDElwcIrbRvoWoCimJ2nigx5DpNzgcEwPZ9CChQRqzrDApHOg2knCrCg8KJY8B4xrpVXcnXeOWAKlExMcJBmru0zvNOSoxSQm9YCMeUdWj/+vFWO/mp5pX89V+tWHsH7irSIsoLoX/PbycYkoJwTSQhos+69fy61w6BnFhZnI0pCaGK3mpsONlfworb/MZYUTqgZYWlmsjnDlnK22hGQpAH8ErgZKdtOotbPZ8vLyYuj2vmfJrpB9aaqfrd7JjEtrjjfrr0NaCvo4gLCF92VH+jnaUOWea2Tz8sA3oRX7bXyJxYh7eWzN7akux+sfHC1IaSFZ70pMDvJL2Q2px/cCHYitdwmZ+2XbUZD337f7vEtiCW26yRmq1RF2+JKCbws+ko5Ca7L8OPzipGUHt0Ul06FNP11Z+qrhHZTcotz638PJEtdajTJMDijPn9VIlVd9e9wVbyc3Y1z2DzAkEkDs7HY5wrZ7TDKlPaOisMTzlsRsfqZ8uY5MlseHOxpRQsJPgX7/+wvUaGLgzqLilE43Gdvdc8SGsD2RP1U4hllzOfoZW9hq+NDt9KEJc9l5ke+0DlFunfD971m87xxVQki4W9ITOVpo//g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(26005)(478600001)(6666004)(7696005)(47076005)(186003)(16526019)(86362001)(426003)(54906003)(4326008)(336012)(6862004)(37006003)(316002)(36860700001)(2906002)(8936002)(8676002)(70586007)(356005)(6636002)(70206006)(5660300002)(81166007)(44832011)(2616005)(30864003)(36756003)(82740400003)(82310400003)(34020700004)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:10:15.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9542dff8-7a30-41f6-7318-08d95bcde727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
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

VCN and VCE support multiple queues with different priority.
Use differnt encoder queue based on the priority set by UMD.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
 13 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e7a010b7ca1f..b0ae2b45c7c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -73,15 +73,44 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
 	}
 }
 
+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
+{
+	switch (prio) {
+	case DRM_SCHED_PRIORITY_HIGH:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case DRM_SCHED_PRIORITY_KERNEL:
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
+	case DRM_SCHED_PRIORITY_KERNEL:
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
+	if (hw_ip == AMDGPU_HW_IP_COMPUTE)
+		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
+	else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
+		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
+	else if (hw_ip == AMDGPU_HW_IP_VCE)
+		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
+	else
+		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
 	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
 	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
 		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b7d861ed5284..4087acb6b8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
 {
 	switch (amdgpu_priority) {
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		*prio = DRM_SCHED_PRIORITY_HIGH;
+		*prio = DRM_SCHED_PRIORITY_KERNEL;
 		break;
 	case AMDGPU_CTX_PRIORITY_HIGH:
 		*prio = DRM_SCHED_PRIORITY_HIGH;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1ae7f824adc7..9d59ca31bc22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
+
+enum vce_enc_ring_priority get_vce_ring_prio(int index)
+{
+	switch(index) {
+	case 0:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	case 1:
+		return AMDGPU_VCE_ENC_PRIO_HIGH;
+	case 2:
+		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index d6d83a3ec803..f5265f385890 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -32,6 +32,13 @@
 
 #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
 
+enum vce_enc_ring_priority {
+	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCE_ENC_PRIO_HIGH,
+	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCE_ENC_PRIO_MAX
+};
+
 struct amdgpu_vce {
 	struct amdgpu_bo	*vcpu_bo;
 	uint64_t		gpu_addr;
@@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
 
+enum vce_enc_ring_priority get_vce_ring_prio(int index);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6780df0fb265..ca6cc07a726b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	return r;
 }
+
+enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
+{
+	switch(index) {
+	case 0:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	case 1:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case 2:
+		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d74c62b49795..bf14ee54f774 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -290,6 +290,13 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
+enum vcn_enc_ring_priority {
+	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCN_ENC_PRIO_HIGH,
+	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCN_ENC_PRIO_MAX
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
+enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
 
 #endif
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
index 121ee9f2b8d1..f471c65d78bc 100644
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
index f4686e918e0d..06978d5a93c7 100644
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
index e0c0c3734432..fba453ca74fa 100644
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
index 3d18aab88b4e..f5baf7321b0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
 			return r;
 
 		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			unsigned int hw_prio = get_vcn_enc_ring_prio(j);
+
 			/* VCN ENC TRAP */
 			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
 				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
@@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
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

