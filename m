Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AF3E9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC6510E7D6;
	Thu,  5 Feb 2026 06:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLBJ8qgT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB7210E387
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbAtyw7Wrv25sZpIoEUcXPqv7rcw+bLy3DgBedZQEi2PffKmUB36mPlZIAWcAcvD5i/svTKvqGiCoFCJ8MfuF9o+xTMo/yvR5/PusLMZ+USgXBLoIunjwtiAYfC+tYyL6NxUaDp7VErQfGjZJZKATRv5to/GzlhIU957Qvf3kXZYAI4G/mnY28OCIhZ+oX8Mge9ig48n9rqOwht0CW8QhzAR01guYSQthgNfhsYpYydj7/o+c3dlLXuMX7c1amlEOXKhXiJYTNHgiP7wlK9Lm6AUUmUw9zcut6wlr6oA+WQzopNh597xmol1/H4uCWdyuunP8HOFu/2CTm3j9EBt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZycJtWc8MkUz9c7TWMEZYW+8DhMHdQTQuoQbp90ppZM=;
 b=qafLyKdq2S3LeqnlSHk5aFp/68BaRDZOz7PXIxlGvxOeVoJ6D9jVI7ij9rOXfvWJk9OJtAdlAF2i7wYU8tKuEKx/+sPj0ZAqOCncK3h6CKQXNzoCOa8GRZFiDhQLgWYKdbOLdwN2ghteGb+t06othD2h4Ac4j1te+1MRxDFTscOJQSYROHWhlto5xEduycTUDxTks8AMp/xxfClMEpNLuj9OM7eOrFjPdjEN+uBLydzgvTLCJchtqWNmcVUPrZKCs1oSwYf6MNN5RKNmN6J1bNNhdBNPpMYEB3Om0XnensR68LiI0cdbFMonGdbm+kw8g5+gfuN98dKixrHbKtkT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZycJtWc8MkUz9c7TWMEZYW+8DhMHdQTQuoQbp90ppZM=;
 b=VLBJ8qgTFDXY4qCdVx//P8RWBZ/cY1zI8RUGbfxHkVxparxiKgJZFxCw15xCjApGLI93UcexKILgyJIJZW6OelpUeW595G+OF3YPHobPEnL+tyjrSGaqY4NO0/74y0QNWyjrnIs/c2/tmryrs67arK9a0QtsNDt4pq6nEiEyrME=
Received: from PH7PR17CA0016.namprd17.prod.outlook.com (2603:10b6:510:324::19)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 06:52:00 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::a3) by PH7PR17CA0016.outlook.office365.com
 (2603:10b6:510:324::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:59 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:57 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 14/22] drm/amdkfd: Optimize PTL locking to fix potential
 deadlock
Date: Thu, 5 Feb 2026 14:51:22 +0800
Message-ID: <20260205065130.654921-14-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 962819a8-ccb2-4f9a-7207-08de64830f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6B4lv6RFjCit+UREWJRm6wMENGAaktNS9chPrJoq0xZ+zmZ69Pwfh+wPeWzw?=
 =?us-ascii?Q?aX7bJy1bcfbShBx3ygjQsSaOJl+WgkLOp4HCnzcFbwsmImgDPSIVCZPp1Io7?=
 =?us-ascii?Q?nHUqGwTgyHKYh92/A9FveFa1g1qUk6UfdN9V8AlqTOqem9ovyI1Khumwvheq?=
 =?us-ascii?Q?uxrdhbzGd1z1n0i0UrFMo3J2jo0Z3khv19iQQtjKCzjUGKvcMTQdwG45+vSV?=
 =?us-ascii?Q?QlLFZg82IvI8MPKekKUSdQJq/6ZzQGMfvwZTpzIMwf2ZdBdMOh/grkqsVvUX?=
 =?us-ascii?Q?L5BRMN+oidRc8nvS7dYn3C2RTjHO/KbadWuqxUO8ngRUQqQUXwNSPaGG3iZ0?=
 =?us-ascii?Q?wajA+HR7WNUib9qKPbiC1JR8awI6uxYFuK4+TADEw1TkfxtyBafrM0VB7SRJ?=
 =?us-ascii?Q?QYwLD4Mzgawe4u5AHFDVAKtjd6l6g4XUWhKbkw7ubVTZAqg6AbCv7pc4l7pN?=
 =?us-ascii?Q?0D3itjED5e5bGBjKB9C1qIBV0u+TnLo8rd3gDxnxSrA1F+0ZUo7/PWeWZBux?=
 =?us-ascii?Q?E3FrJV3+WBZhYTAqSg5nba2vyMKuTIx9RK9TvQr47htkf1KoMUt0kKOoHXlW?=
 =?us-ascii?Q?qmb/GjSlYQLl4hozdzqxshFTDpQHUsgAH01s70xsBdtsDOIF4AltMbnG6dEr?=
 =?us-ascii?Q?3rhwvHJva1YnsVLjpwVTMiFG00ZvGXxp1Xts39q1NdQvmWdFsfBTFx97jFEF?=
 =?us-ascii?Q?Qc+j/CCt+nfxlqambTitSIa2CDTxxybAMwdQJeCYyRM5OgFL3HdG9mqpaDk8?=
 =?us-ascii?Q?gcEwZI1nzNQqoEokOKs1ScBysntCKUcbXFmsMdy05HbjN/0QFfpJrR95C/+J?=
 =?us-ascii?Q?peQg/2XVY3zBB18P4QuMQjiEHLAY33AM2p+vPgNhJLsXAXK0QqS6hx8fRSSc?=
 =?us-ascii?Q?kqrigz3Rrolxime7skU1JJ2x+AsvbuKwLe1VIaNdQyAiEP6tnvalEsawxTrK?=
 =?us-ascii?Q?q7O8al7Ur/AduYJ8g+cfR09bB4N2IkZG5EMiTWS9Lfd8WhsLQ14W94rD5Ka2?=
 =?us-ascii?Q?yqqK0VUhmODkUpKmgGQJGkRUS/A9HDv+Zm1NsJPtotYfkWtUWvfUGHGfLWqz?=
 =?us-ascii?Q?r84/q/0bQx79ixjufDJxDuJDTnoF6sEijlAOkJe5C/SDovk1c3uaOIrX8DQ+?=
 =?us-ascii?Q?1P8BJByvaW/tBaumY0wEn7oSe+3nfIkCWpb9+fL+sjJf5durVceXZq6ZfYg/?=
 =?us-ascii?Q?U55iK/2AA73fBNcmbFc+zaiGjqhw0vyZLc51vMMPoqkLd7P2qp0MBW96tLDQ?=
 =?us-ascii?Q?lMAt78hUYEsFP4V6iRiYmwhAZhDTBzzf2f2b4VY1vf1sGejm8CYu2IyCnfXJ?=
 =?us-ascii?Q?EqfZ5JhzfS6MmBIPT/gbGQ4fqFi6WA0ikUA9KfE9Kh9RHP3NtdNRa6maJ6zK?=
 =?us-ascii?Q?crYewvroqGF8WEV0mw2L8GJCJsJ2NVc5ZdQeZ6sHXi/Or8BvHxaJt5m2riwT?=
 =?us-ascii?Q?rcVurFdykXdUNqgBqaFjCeYMHJ/RiPtO48lrORDAbi+QbByY2C4rCl3yQ/bC?=
 =?us-ascii?Q?LRuq/Cbt9o52M4mUAdBnAFg84f17u00dBnSbhKvNKPzMBUztenXzIgM1CxfG?=
 =?us-ascii?Q?Lv0ORqEiFDAPaIObwmopVQRZN1sxBMQnmH/RWztolUAyEyvi2WABA6FYKC+0?=
 =?us-ascii?Q?yN5jV8TBxeP+/+KwzLk7ldR0/CeDe6WsQ/gcICFdI1Xe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XqI61QtShvHInvk1U1UfFeJQEzTVDT1v18tX9GPd/34DFa6zxlPqfMRN9E22kJwzqr38MGvk2V3OuLP8AA0CJUMEPsXCG5yyrQIsACZ9Wmzy/4G48K9nb3mqYtnPLI9m6/tsFzDi1eoAzMU7R22lTNgZoz4j8lgzOwArTLIJIvYl3zpuvav5swLQ3v5FbG4D+yzMCUDEG498cpt0wv3GYGIk6Qgon71ZLJ2dLYHnZzV8D/IccT2B8EchvEsB7tFvbYYHnJKkibRlwqYayTDlejjfMMIeXWEsynzS2wZ6C41uBnZOfr7VjXunkCqB6a4uunfpwBTsU1GgyHghzxppQ+dtdsmI53FEao1noyeZVGBpdHVzDLgME0I0ZEI6LximHVKOvRcaCctjBZ/7LvRawv+yzNo1Zx/t0hB5dWw6APvhKqB3SZ9RP/Li6O2tHtHo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:59.7390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962819a8-ccb2-4f9a-7207-08de64830f97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

Release profiler_lock before calling kfd_ptl_disable_request
and kfd_ptl_disable_release to resolve potential deadlock
Introduce a dedicated adev->psp.ptl_mutex to protect PTL state
instead of relying on the KFD process mutex. This optimization
ensures thread safety independent of the process lock hierarchy.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 12 ++++++++----
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6e422da88b7e..aae2f850b044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4442,6 +4442,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
+	mutex_init(&adev->psp.ptl_mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2b197cdefe31..682a0e4adafd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1260,6 +1260,15 @@ int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
 		return -EINVAL;
 
+	/*
+	 * Add check to skip if state and formats are identical to current ones
+	 */
+	if (req_code == PSP_PTL_PERF_MON_SET &&
+			psp->ptl_enabled == *ptl_state &&
+			psp->ptl_fmt1 == ptl_fmt1 &&
+			psp->ptl_fmt2 == ptl_fmt2)
+		return 0;
+
 	cmd = acquire_psp_cmd_buf(psp);
 
 	cmd->cmd_id                     = GFX_CMD_ID_PERF_HW;
@@ -1334,19 +1343,24 @@ static ssize_t ptl_enable_store(struct device *dev,
 	else
 		return -EINVAL;
 
+	mutex_lock(&psp->ptl_mutex);
 	fmt1 = psp->ptl_fmt1;
 	fmt2 = psp->ptl_fmt2;
 	ptl_state = enable ? 1 : 0;
 
 	cur_enabled = READ_ONCE(psp->ptl_enabled);
-	if (cur_enabled == enable)
+	if (cur_enabled == enable) {
+		mutex_unlock(&psp->ptl_mutex);
 		return count;
+	}
 
 	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
+		mutex_unlock(&psp->ptl_mutex);
 		return ret;
 	}
+	mutex_unlock(&psp->ptl_mutex);
 
 	return count;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 1af641ae9a02..1ab7255718df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -478,6 +478,7 @@ struct psp_context {
 	bool				ptl_hw_supported;
 	/* PTL disable reference counting */
 	atomic_t			ptl_disable_ref;
+	struct mutex			ptl_mutex;
 };
 
 struct amdgpu_psp_funcs {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5fda0efe5469..bccb857c81c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1802,7 +1802,7 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 		return -ENODEV;
 
 	adev = pdd->dev->adev;
-	mutex_lock(&p->mutex);
+	mutex_lock(&adev->psp.ptl_mutex);
 
 	if (pdd->ptl_disable_req)
 		goto out;
@@ -1819,7 +1819,7 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = true;
 
 out:
-	mutex_unlock(&p->mutex);
+	mutex_unlock(&adev->psp.ptl_mutex);
 	return ret;
 }
 
@@ -1833,7 +1833,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		return -ENODEV;
 
 	adev = pdd->dev->adev;
-	mutex_lock(&p->mutex);
+	mutex_lock(&adev->psp.ptl_mutex);
 	if (!pdd->ptl_disable_req)
 		goto out;
 
@@ -1850,7 +1850,7 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 	pdd->ptl_disable_req = false;
 
 out:
-	mutex_unlock(&p->mutex);
+	mutex_unlock(&adev->psp.ptl_mutex);
 	return ret;
 }
 
@@ -3340,6 +3340,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
+			mutex_unlock(&kfd->profiler_lock);
 			if (pdd->dev->adev->psp.ptl_hw_supported) {
 				status = kfd_ptl_disable_request(pdd, p);
 				if (status != 0)
@@ -3347,6 +3348,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 						"Failed to lock device %d for profiling, error %d\n",
 						gpu_id, status);
 			}
+			return status;
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3355,6 +3357,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
+		mutex_unlock(&kfd->profiler_lock);
 
 		if (pdd->dev->adev->psp.ptl_hw_supported) {
 			status = kfd_ptl_disable_release(pdd, p);
@@ -3363,6 +3366,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 						"Failed to unlock device %d for profiling, error %d\n",
 						gpu_id, status);
 		}
+		return status;
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
-- 
2.34.1

