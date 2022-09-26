Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73FAC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF40A10E47C;
	Mon, 26 Sep 2022 15:03:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68A010E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEpsXOKTYev8WE9Gg6v/VtpESLr8aYYtdMRbMfnfovXY7jsxJ0KvCvdtqEPWWzz1gARQHnK/7lAOPkOLcRicndIxOm6F/cNJ022eLHWSsB0A6HAcU4ltJZQda4b4xg1frDhcWXTO8t66MxjHkz0QN/Gw9cKGtnpeLKYxHW7P1WjfddRYxMr7aB2hGwQcMmJJUlsawFszVhdhsX6FocOuJd6Z0kVMJA3ugAdQt3epQcxNuJaq4bPmngEiBxuob5gES1UyEaZLpFAwMKrXVyze1PCN1QEtI8aOxT+W/ufo3qiN1fT5E2WoAF+mWl6KuSRNHBcgXdDFKoFHIn+XvqoRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NQjuZgQIZhmX2wE/3zuzG4+iSD6eFA61n35RA8DuqI=;
 b=dA9SFkDlzKR0h9ehMhl9gFCoIpbO8HscwEndzm9ypJOzUDYpgBEhhhGQrXIpW29DkhwXc+M5spJw5RsDA1UPHWzhbucums+M0JyKf3Mt79Vw5qupMJSM1vrnN/tkSLxSyDjUb0tHItpfDwub8sR+fmv66f/S+k3kbD9A9ucmOZ7zln2QSDtMhtTC/hing+mID5AbHRMqsg+TnFWNOb+u5+MN8Nja0/7G7VAgJ3jGMF4vAJTTx3nmtGDi43HfSwqSukB42TM1qK2+V/eCVE7gbjvwx7EiTmYD+jhSbnCLPXnZ08vv1k9WgSJSpqmlfcCyZEVjnC4B+OZyl30oQN3YoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQjuZgQIZhmX2wE/3zuzG4+iSD6eFA61n35RA8DuqI=;
 b=nUGNBnEmTmlxCHfFJAR/8SPlz3+WyXDPBH2EM77drC3ctarbF/5mpl2Vgh0a2OterFvggnEDRTNrVBPyfk4hMBIUB2vcKp8/zK+H+TN8PKBChENEvXzDMv6pD6EmmnMt8QDJ25DoDy4qlQYSvY31HKMSUJJfgc4ZXA/cDc5/Rtw=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:03:13 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b5) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:12 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:11 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/5] drm/amdgpu: set GPU workload via ctx IOCTL
Date: Mon, 26 Sep 2022 17:02:50 +0200
Message-ID: <20220926150252.18635-4-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926150252.18635-1-shashank.sharma@amd.com>
References: <20220926150252.18635-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c78dc3-7228-4556-7ba0-08da9fd03bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZHc8eIO0w6sbOPdmTNQQMZkeI09vkfz8sZierYBYyzK2toFRpQ7j3XzBHhyn7iAEIn96yAjk4XKduQE/9Pe5IP01dBnYmIHd5+NEXUviRzBAWvau9BgHayR9mXUkTVyYiPwXRQaXzdtNWyQS+5Rx1ihdlk8bTK1a0hlFS69ljnD1jnp14/yevZfl8s/sbQAALh/nCiQVcHQmh9IVj9y+mccjPMW7NGQQGhygm+/pKje1+JWBWvKbWPyp8AL/e7i4hQFl0M5ZDsXNR5tLq+T1Hs6MYykkYrHRCgIwHzbjwPZtW8HdoKOHTazxkYECR/1/vlQmz33u/9B38iv/E1P5D6MJhEWvVld7PsNF3oi+qqYfs7kgWOoCCJkMeMj82FLToQ2qs3vqGl0bDmcGB1plufkhl/4VFlmeODX7HXL8qwlbSPbypTMzUPnZONOGQvssT4YcP5kaLDyPTbwUgmKTLpTvB5CK5GFLTmlQ6+xVAygFjEi1HPUSYlHwGJ860NG7roMk2tf275+bs9qMS5fOxpG7O/sqeYS1fYEZh/XCw4q7FXEmEpcCQBAzoC5XJYRyYi/7/CUx4us2c287jzxAAbe5714eJzD4hlJ+DCCl2lI8yUrqFD1AOxvleTINuD+GcUp2mj4QoO2uYd+CH8zkitDOg9cRdXQEd3s2bTApnN6wRSV6vqOtqmsHVR0f3yBlUuZlOHeikTl4hpnrvbZzscSxmUGaKUFkfTWgReYJj/cKbdE9emo2LAVK+Pz5I4PpYuODWjx5raPbuwiIPcqiza0OL/Ej5nVXP/jEGLxPIEw3De62eTBIQ0xhL+KjvZl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(356005)(81166007)(36860700001)(40460700003)(86362001)(4326008)(70206006)(8676002)(70586007)(316002)(6916009)(54906003)(2906002)(36756003)(5660300002)(8936002)(41300700001)(44832011)(2616005)(16526019)(47076005)(1076003)(426003)(336012)(186003)(7696005)(6666004)(40480700001)(26005)(82310400005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:12.9505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c78dc3-7228-4556-7ba0-08da9fd03bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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
Cc: amaranath.somalapuram@amd.com, Alex Deucher <alexandar.deucher@amd.com>,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds new IOCTL flags in amdgpu_context_IOCTL to get
and set GPU workload profile. These calls will allow a user to
switch to a GPU power profile which might be better suitable to
its workload type. The currently supported workload types are:
    "None": Default workload profile
    "3D": Workload profile for 3D rendering work
    "Video": Workload profile for Media/Encode/Decode work
    "VR": Workload profile for VR rendering work
    "Compute": Workload profile for Compute work

The workload hint flag is saved in GPU context, and then its
applied when we actually run the job.

Cc: Alex Deucher <alexandar.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 56 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8ee4e8491f39..5a116e5bb6a9 100644
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
 
@@ -633,11 +634,41 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_ctx_workload_profile(struct amdgpu_device *adev,
+				       struct amdgpu_fpriv *fpriv, uint32_t id,
+				       bool set, u32 *profile)
+{
+	struct amdgpu_ctx *ctx;
+	struct amdgpu_ctx_mgr *mgr;
+	u32 workload_hint;
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
+	if (set) {
+		workload_hint = *profile;
+		ctx->workload_mode = workload_hint;
+	} else {
+		*profile = adev->pm.workload_mode;
+	}
+
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
@@ -681,6 +712,27 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
 		break;
+	case AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE:
+		if (args->in.flags & ~AMDGPU_CTX_WORKLOAD_HINT_MASK)
+			return -EINVAL;
+		r = amdgpu_ctx_workload_profile(adev, fpriv, id, false, &wl_hint);
+		if (!r)
+			args->out.workload.flags = wl_hint;
+		break;
+	case AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE:
+		if (args->in.flags & ~AMDGPU_CTX_WORKLOAD_HINT_MASK)
+			return -EINVAL;
+		wl_hint = args->in.flags & AMDGPU_CTX_WORKLOAD_HINT_MASK;
+		if (wl_hint > AMDGPU_CTX_WORKLOAD_HINT_MAX)
+			return -EINVAL;
+		r = amdgpu_ctx_workload_profile(adev, fpriv, id, true, &wl_hint);
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

