Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8134FC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6918B10E7BA;
	Mon, 26 Sep 2022 21:41:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8502910E7BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWg4HHwHCusXpnNFPJsto0TB1b7Ai8j8aV1Us7OLzMDCUo4+uJAgpMDoL4U0QBuz7W4nWmozaAK1DtIexI+26/yiYqOVb0Z/KNaiBNWlehUpPODBgbyJMnNTy8wF8Q3woyJyDJmLY19gOeh1DtbZDan15G+NhyknZiXJQpyo4LEMb3Q358UP/8MRPDboRIWwjzkznxDNLAZyZ1VzrTW4L8f4Wjb+OzrhpldZcPw7Gd9fp6tV2FTTpKrZpGm+6W2Gl1he8g3Nd6qxOBgHjuuuemb88XDPFRkY9iY6zS+grdKv7C3Xmf2V0s/ear3U2pM5QwuT+SSDVw4JlX10oveL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5SdASlfPzwbzgPxZBOTEBWlvVwIChC8GBu9X7pZ6SE=;
 b=TrOLAthgiB4uKdUfAtOr8iZ9NKPyS0eq0eAF/hsVcsx4kF2+lSEQS9ax2KUi3aCwAwm0VjVO7O6Kox1olcabqFgiAnYsurXKSICd0hHut9lO5XlpDC40PychGNPSkKgYmU/MUWasZ4Qhx24KkeNGR/kS9Pw0lomit4i7Mf07CzLFlRNdeBfUmb7jIpczfLh30VIM2zRrR7dtIQ4tuz8RIFwky0UrQtTz0xP0ersjd3SfcrLmE8peUsmlUIR1UkfdCbquO6CyBR2fQiVVSGHL0/sAZvAR5oiaVXTMjY0ZbScY86KB1sR+P407UBhMKB4SSFT5Nb+GE0pSK55sFIbwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5SdASlfPzwbzgPxZBOTEBWlvVwIChC8GBu9X7pZ6SE=;
 b=d2LOyLvwtCJ9Nl/dmgx94KekDvb32BbanlxK+f0pcT45WoEXCV3XeSa87xM3B3gLo5FJ9IjE4eYBbTVFjw16dg7HLhkWtmWmO50J4XRWipe4KGXEpDYWXRvwrFCe3jaOEUqxte3+KpIwyyG+YOnUAyyckR/8I13WpyB4T4M9+sM=
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 21:41:13 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::12) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 21:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:41:13 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:40:41 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/5] drm/amdgpu: set GPU workload via ctx IOCTL
Date: Mon, 26 Sep 2022 23:40:12 +0200
Message-ID: <20220926214014.5450-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2becfeec-a605-43d8-624d-08daa007d59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtfkkDCrHggBbCd1F7GzSg0tFzoDPh3cLLjtpTteRzIWpoS+sDoZ0peUjVgKrhj8d1j8eQ78Et1wTl1zFXl5kTakZbUuIH3BRecrOomtJxPzTpVnnQocPUHFocoIDjjNScSA7kRdsj67oOIDYVevZnU9pLFD8xDFDIXzZuIYzqvx4jPAsv+DzCr4vW5PmMC5HWCyLgd+svWaKCAtcoU/ZwHkg8jK16qKfxa5sTlCMRvgZvYG7SfbsJv0SCXgV/1bM5IUmaXkQtEp9rOMasSUSGC3npXoXhPZ25qT2o5ULV6hD3jvY/bsN7na5+nJ8zNDnEe3sSg6dwPMdzgXGqE3aDlQ+kMLgcwQBq2tAXvwGUL1ITTjw79wnQQJrDqcoijAOUhV4pI5F2hynuqCmMalIL3rLfHoqYZT9UPlNI09hBjyTeZSS8cTvGYOYGQb0FMpUm8qyLczrs9F6W++GKOc4ih0V1JnpJTc99S42vLVGA0UEswWsWjOA6G5gP89yZCtBa2xU6sgkZek1564R+DVcvzu2+y5f5LorJBU+Zcf4bZrwHcXN5riP4o34T+jjEppkHjTIhmSJJCd8/s5MyvEH+88HYJ9FOXV6nQAFdF7kgVBMlw+au0cjfHEZEE1ZznHReAHU9cSuCoYG9PzjTdySaqC+Pjm3DpGHHPK4O69I3aW80sLr4IKBKeEJDbWGkeU/q6qBeFOzpYruEhbBD9qBV2+rZ6mi6Z3Yab2AGEhPDLlGiuK8qUDAZizEzW/8kHQR12b88/iyShQDWmEfUCIfLOaGcCtXjFyfw1eYPBAaVrgh9W6ugbxiRduIqU34BYq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(7696005)(86362001)(82310400005)(6666004)(70586007)(44832011)(4326008)(8936002)(2906002)(316002)(6916009)(54906003)(26005)(41300700001)(2616005)(1076003)(40480700001)(478600001)(16526019)(186003)(82740400003)(36756003)(83380400001)(426003)(336012)(47076005)(81166007)(70206006)(356005)(36860700001)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:41:13.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2becfeec-a605-43d8-624d-08daa007d59d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds new IOCTL flags in amdgpu_context_IOCTL to set
GPU workload profile. These calls will allow a user to switch
to a GPU power profile which might be better suitable to its
workload type. The currently supported workload types are:
    "None": Default workload profile
    "3D": Workload profile for 3D rendering work
    "Video": Workload profile for Media/Encode/Decode work
    "VR": Workload profile for VR rendering work
    "Compute": Workload profile for Compute work

The workload hint flag is saved in GPU context, and then its
applied when we actually run the job.

V3: Create only set_workload interface, there is no need for
    get_workload (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 42 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8ee4e8491f39..937c294f8d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -27,6 +27,7 @@
 #include "amdgpu.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ctx_workload.h"
 #include <linux/nospec.h>
 
 #define to_amdgpu_ctx_entity(e)	\
@@ -328,7 +329,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 		return r;
 
 	ctx->stable_pstate = current_stable_pstate;
-
+	ctx->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
 	return 0;
 }
 
@@ -633,11 +634,34 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_ctx_set_workload_profile(struct amdgpu_device *adev,
+				       struct amdgpu_fpriv *fpriv, uint32_t id,
+				       u32 workload_hint)
+{
+	struct amdgpu_ctx *ctx;
+	struct amdgpu_ctx_mgr *mgr;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	ctx = idr_find(&mgr->ctx_handles, id);
+	if (!ctx) {
+		mutex_unlock(&mgr->lock);
+		return -EINVAL;
+	}
+
+	ctx->workload_mode = workload_hint;
+	mutex_unlock(&mgr->lock);
+	return 0;
+}
+
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp)
 {
 	int r;
-	uint32_t id, stable_pstate;
+	uint32_t id, stable_pstate, wl_hint;
 	int32_t priority;
 
 	union drm_amdgpu_ctx *args = data;
@@ -681,6 +705,20 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
 		break;
+	case AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE:
+		if (args->in.flags & ~AMDGPU_CTX_WORKLOAD_HINT_MASK)
+			return -EINVAL;
+		wl_hint = args->in.flags & AMDGPU_CTX_WORKLOAD_HINT_MASK;
+		if (wl_hint > AMDGPU_CTX_WORKLOAD_HINT_MAX)
+			return -EINVAL;
+		r = amdgpu_ctx_set_workload_profile(adev, fpriv, id, wl_hint);
+		if (r)
+			DRM_ERROR("Failed to set workload profile to %s\n",
+				amdgpu_workload_profile_name(wl_hint));
+		else
+			DRM_DEBUG_DRIVER("Workload profile set to %s\n",
+				amdgpu_workload_profile_name(wl_hint));
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cc7c8afff414..6c8032c3291a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -58,6 +58,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
+	uint32_t			workload_mode;
 };
 
 struct amdgpu_ctx_mgr {
-- 
2.34.1

