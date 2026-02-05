Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E5FE91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECB510E7CC;
	Thu,  5 Feb 2026 06:52:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LuG/ablQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6468410E7CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktuYtOVA5gg2vjnMLztzkfaMYZU+crYpIOMaxBaVH1bjWDLGEVEm5o6c1/Gyyvmznpa2JOa/hKi1x4O10SgwD7LsKA2O+Lzme9xffdExD6zGy6mpYRdvMMIdUpl8yKgp+ooHxRD1P0Imrpes0hd49CJu/8JasWPMYCCSIgmycj2piF8zXuTnZ7TOBaFUz3ZqOPPKvKK516BD9N8P2l+ZYblbZ4M3SChybsWsmsNCFGNOnLcdlDONkKkVLuEosoXelaWy9SbiN9RaoDoTcU77QmRpxEtm5hReB+J0gdSUHE3WwdO6wfjnYDPa+Ll57b5A709zkJBNiHY8AOsX7wzI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84/YDdVIeOWGyh0YmYEl7j0KZXT+zKfnbR0G4cg8v2M=;
 b=mWM4DqKGYER5zxq9x0kXyZKM1tEKXPYYHaoYQnudXX+A1WF1O13LeKa36L8vmXDn8UhvPgU3pUUUrM5c6zY3XYvtRXgsaksDCgZo7A7IQQJPnBPbMCMwH3K9qYPZyZ9101qbapzt/U0bWLSTHkBgZT1ohPk9e/X3OZoIVDBp+slZQTmR4+kLExWzTwVwTMIHEnL/cQ61vnpntr0FD4rAPML22ebbxWPMebqMqOSt8zxtzpGrhI3IagBiyRhnK+f5GPGohTz81Bmot7MPHvc0AZDrn1dXtf7A9FS7m952SsKaw3t+h/if6uB9breYJ6bnQ9q2I8i7LmU7vMmEt7L9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84/YDdVIeOWGyh0YmYEl7j0KZXT+zKfnbR0G4cg8v2M=;
 b=LuG/ablQRUHbwQXJkRvtReFAAw8CysUm+S1cArVrA7o2n1HdIR7UrJfImKeNFlG51YNSxBfcN5zuXllT9h8IDgNZiM3tTa4dwbEGPKddSivI2OHmjLqK8nKJNSzInCxvFEuwjOlYTTVnlPgibekQ03GkZOHfk3dAzzi75bg7elA=
Received: from CY5P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::36) by
 BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:51:55 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::f4) by CY5P221CA0061.outlook.office365.com
 (2603:10b6:930:4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:54 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:53 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 11/22] drm/amdkfd: Add PTL control IOCTL Option and unify
 refcount logic
Date: Thu, 5 Feb 2026 14:51:19 +0800
Message-ID: <20260205065130.654921-11-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BL4PR12MB9535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4825cb61-a8d2-4c40-8df7-08de64830c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMEZevbqjCGmzfTcdrpC8qQxifRPOtvLdx/yfYjo5k+DFpixHvaaG8AVuGGS?=
 =?us-ascii?Q?Q+p2FNaGEHuwGtXboiMarAK/yqIrPn+oojHJWhPMQyV08jyX0/Fo2Kw2/p1U?=
 =?us-ascii?Q?bOeCqvRt+kXV3rlvgNKeF9EGgJT6Hf4BTS95EFRY0JgSB0DI7Uamv7XwoG9I?=
 =?us-ascii?Q?8E1Dupwjz2Ldbuog5UZRttiTYt7l9Xytr5uon3+TaW3AKtEkXss0A5fBQERR?=
 =?us-ascii?Q?6yCuDW2/wijUaaSzlN9exJ4VcjFB8XNhxT2JOjU1DyLxGS8n7ssrTpnpG6d7?=
 =?us-ascii?Q?xQ0Jv/W3kzWBQpJ4Na/XW1WmQNmYOOSYVk7/Pnl/QY9h0JKJhZkkw61ZAqun?=
 =?us-ascii?Q?+HMUHj5L0PUnyQnW4eKqn83ZCTY4DJFE8oDmUCu+tuclIueQ8nESfST2x2ac?=
 =?us-ascii?Q?wBLHDwm+2Y4mVeO6qv1ktgFnmGFeZ7YdoC+AtBIsDYwMiHruFqpQFVCeG325?=
 =?us-ascii?Q?CPAqs9gz3epYOOuI27GydBkBV+6A+qfOE0rf8133HlmRwp4NBqEQdH6zHsfN?=
 =?us-ascii?Q?BltE6eU1xyXJl4gpYQ77ZKUgeKdb6Y7562AC7ddjZ+v+hbPsm5bogZ534DV7?=
 =?us-ascii?Q?J039MPAR83M5XHj+orPqkKCoRXZLf8FNHtmPLEG5lHpHvH+Je3G89rQDciz+?=
 =?us-ascii?Q?NjJsj4oJbtbxgebDI63YtmYK8bI1uGWKKZKbGaSgMh8kxJPo+q8SCVlCReE5?=
 =?us-ascii?Q?ACxYfw9iDpZKUXLvj93d5IdOl4YMHJm2CaXo065DY7I45V/Mii8IOFUl/EOB?=
 =?us-ascii?Q?EqTL6/Z6/yndoRnCd2TY7IlIF20vBLDS7xfkdUjsXh/Ady7WVxaElPNZLGea?=
 =?us-ascii?Q?zboIgvqyet1DnpyUpCIixrWpUdhj/U7nolYR9scXDjOmUiBr3uFMYczPVqeh?=
 =?us-ascii?Q?tBTaOzcTA8b0o2ffhAIy8Ak7dzC09ifeWvGNli9vUGDnLswrl2ienMmQ/599?=
 =?us-ascii?Q?Q3RaP+LIgWWtdwVNNMoAdmmzhwTNzhFiQS7f0ckvcmUWur7hciz4TT7cDdiZ?=
 =?us-ascii?Q?eZX3MOK5Nqzmtn5k1UangnpdpcESZxaYEyykxbmQj9x1lAHFdQNTG2Oz3mcC?=
 =?us-ascii?Q?ZFsIhGUSAJxia84BN6T0M0cCBN1TaVtI51gq7I3N+ow1VsO5P0HHSiqAbMOy?=
 =?us-ascii?Q?HcvsQBqqQu3tCS/TCa8zgbRVRYJ7ezpYMVmXk0XNQ9h9ln6bIu43p9NLU0KU?=
 =?us-ascii?Q?jUZiqYU82wy5mF1FpT0l6MgTpj8b+YdARlzOEaNhUgZwv48aw2Fpu0C84TO3?=
 =?us-ascii?Q?oVHtRaZ2tsQ00fHgK0hS3CtJ6oNnlIjg7UMTuzWrD8OmfQIW+BVEtf9ahF3X?=
 =?us-ascii?Q?4GFhpxaYH/5eXLQCqJ+oeGu+fY8fDOYAd8TMTVqPh+cFhrVpf1gOJeOGqhcM?=
 =?us-ascii?Q?+CDdx0SMe+JOxrgk2MqDUJgjuVfILlWxAFVXmBceOrX4kUMx3eA2+Cm+f46F?=
 =?us-ascii?Q?hl5H6G0YWejBVQQInfC3ZzZaurEcRZHm4NLPpx24YPT/3iYjnB6iVUl9CaDF?=
 =?us-ascii?Q?XZz3Ka0Y6cvHKTYxQOkYj0XvArWEKgqEvRKzpmu3RosW4uzJ4GbGkeQ2hgtp?=
 =?us-ascii?Q?Zd6moFsVuySG1p4MaQq9cCoaaaJ/fiedeacSVzd09FDcQhpr7FfvwX+DRLSm?=
 =?us-ascii?Q?FoFsr/Pask9pJjT04vzKwawq8gIGMoKhTBLcI0hahw0XoclG463pa4MzwHFx?=
 =?us-ascii?Q?4AgTfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6on/wWHQje8heCupcrjT0YITwGI7L/S6b2i5Krvmv68+7iSNdL8nufv7HcSqKLwnKdWaLzTOKwckkKxlqH5Pi5qJc1/ngz9kcRUSaANmtCaYP6sK3qf8m+rZfBw6Ar08DZqI5wHn58ykgGbRrTfJrU22bMknBA9nN99WZf2SRxIZuiYfaXjrQsvqRVHtBHGSqcQ6zb1K0km+wil+Lgt/lPhjY6zAwgbqb3U9bGKCYkQZHNLesRojp/qpoUS6nb451geB/XCq8nsxyyRHjlVFQjDPKVAM3rujqgVoMNEgerwA3rGb4lR560RHpBQQoA9dI3WIL/ikb03F3mYns9NXX6HcxirWX7L5Pj4tZMFJrNF26598P+Xp0WsdwS6UMkIsg3rRoECwCth5O0H8o4Tc6rRTSVBFdHE8WAg2cwIuN/hoShffr95piJ3ICtDhdeid
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:54.7208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4825cb61-a8d2-4c40-8df7-08de64830c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535
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

Introduce a new IOCTL option to allow userspace explicit control over
the Peak Tops Limiter (PTL) state for profiling

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 89 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  5 +-
 include/uapi/linux/kfd_ioctl.h           |  7 ++
 6 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 0a2f8d33a0ad..1af641ae9a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -476,6 +476,8 @@ struct psp_context {
 	enum amdgpu_ptl_fmt		ptl_fmt2;
 	bool				ptl_enabled;
 	bool				ptl_hw_supported;
+	/* PTL disable reference counting */
+	atomic_t			ptl_disable_ref;
 };
 
 struct amdgpu_psp_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d94bf21db281..472e2f41fed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2395,6 +2395,8 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 
 	adev->psp.ptl_hw_supported = true;
 
+	atomic_set(&adev->psp.ptl_disable_ref, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 285219781939..6457c5703f99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1785,6 +1785,88 @@ int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 	return ret;
 }
 
+int kfd_ptl_disable_request(struct kfd_process_device *pdd,
+		struct kfd_process *p)
+{
+	struct amdgpu_device *adev;
+	int ret = 0;
+
+	if (!pdd)
+		return -ENODEV;
+
+	adev = pdd->dev->adev;
+	mutex_lock(&p->mutex);
+
+	if (pdd->ptl_disable_req)
+		goto out;
+
+	if (atomic_inc_return(&adev->psp.ptl_disable_ref) == 1) {
+		ret = kfd_ptl_control(pdd, false);
+		if (ret) {
+			atomic_dec(&adev->psp.ptl_disable_ref);
+			dev_warn(pdd->dev->adev->dev,
+					"failed to disable PTL\n");
+			goto out;
+		}
+	}
+	pdd->ptl_disable_req = true;
+
+out:
+	mutex_unlock(&p->mutex);
+	return ret;
+}
+
+int kfd_ptl_disable_release(struct kfd_process_device *pdd,
+		struct kfd_process *p)
+{
+	struct amdgpu_device *adev;
+	int ret = 0;
+
+	if (!pdd)
+		return -ENODEV;
+
+	adev = pdd->dev->adev;
+	mutex_lock(&p->mutex);
+	if (!pdd->ptl_disable_req)
+		goto out;
+
+	if (atomic_dec_return(&adev->psp.ptl_disable_ref) == 0) {
+		ret = kfd_ptl_control(pdd, true);
+		if (ret) {
+			atomic_inc(&adev->psp.ptl_disable_ref);
+			dev_warn(pdd->dev->adev->dev,
+					"failed to enable PTL\n");
+			goto out;
+		}
+	}
+	pdd->ptl_disable_req = false;
+
+out:
+	mutex_unlock(&p->mutex);
+	return ret;
+}
+
+static int kfd_profiler_ptl_control(struct kfd_process *p,
+		struct kfd_ioctl_ptl_control *args)
+{
+	struct kfd_process_device *pdd;
+	int ret;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	mutex_unlock(&p->mutex);
+
+	if (!pdd)
+		return -ENODEV;
+
+	if (args->enable == 0)
+		ret = kfd_ptl_disable_request(pdd, p);
+	else
+		ret = kfd_ptl_disable_release(pdd, p);
+
+	return ret;
+}
+
 static int criu_checkpoint_process(struct kfd_process *p,
 			     uint8_t __user *user_priv_data,
 			     uint64_t *priv_offset)
@@ -3250,7 +3332,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
-			kfd_ptl_control(pdd, false);
+			kfd_ptl_disable_request(pdd, p);
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3259,7 +3341,8 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
-		kfd_ptl_control(pdd, true);
+		kfd_ptl_disable_release(pdd, p);
+
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
@@ -3302,6 +3385,8 @@ static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p, void *d
 		return 0;
 	case KFD_IOC_PROFILER_PMC:
 		return kfd_profiler_pmc(p, &args->pmc);
+	case KFD_IOC_PROFILER_PTL_CONTROL:
+		return kfd_profiler_ptl_control(p, &args->ptl);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 164f69924a3d..48347065b9cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -872,6 +872,8 @@ struct kfd_process_device {
 	bool has_reset_queue;
 
 	u32 pasid;
+	/* Indicates this process has requested PTL stay disabled */
+	bool ptl_disable_req;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -1609,6 +1611,10 @@ static inline bool kfd_is_first_node(struct kfd_node *node)
 
 /* PTL support */
 int kfd_ptl_control(struct kfd_process_device *pdd, bool enable);
+int kfd_ptl_disable_request(struct kfd_process_device *pdd,
+		struct kfd_process *p);
+int kfd_ptl_disable_release(struct kfd_process_device *pdd,
+		struct kfd_process *p);
 
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5114ac4da5b9..882080dc4925 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1115,7 +1115,6 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
 	mutex_lock(&pdd->dev->kfd->profiler_lock);
 	if (pdd->dev->kfd->profiler_process == p) {
 		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
-		kfd_ptl_control(pdd, true);
 		pdd->dev->kfd->profiler_process = NULL;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
@@ -1133,6 +1132,10 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
 			pdd->dev->id, p->lead_thread->pid);
 		kfd_process_profiler_release(p, pdd);
+
+		if (pdd->ptl_disable_req)
+			kfd_ptl_disable_release(pdd, p);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 8db0c474a769..d48c407e9ee5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1572,6 +1572,7 @@ enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
 	KFD_IOC_PROFILER_PC_SAMPLE = 1,
 	KFD_IOC_PROFILER_VERSION = 2,
+	KFD_IOC_PROFILER_PTL_CONTROL = 3,
 };
 
 /**
@@ -1583,10 +1584,16 @@ struct kfd_ioctl_pmc_settings {
 	__u32 perfcount_enable;   /* Force Perfcount Enable for queues on GPU */
 };
 
+struct kfd_ioctl_ptl_control {
+	__u32 gpu_id; /* user_gpu_id */
+	__u32 enable; /* set 1 to enable PTL, set 0 to disable PTL */
+};
+
 struct kfd_ioctl_profiler_args {
 	__u32 op;						/* kfd_profiler_op */
 	union {
 		struct kfd_ioctl_pmc_settings  pmc;
+		struct kfd_ioctl_ptl_control   ptl;
 		__u32 version;				/* KFD_IOC_PROFILER_VERSION_NUM */
 	};
 };
-- 
2.34.1

