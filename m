Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3F8FB5EA0
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 01:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7051E10E3CA;
	Tue, 17 Mar 2026 01:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NlDEsQzN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8489F10E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 01:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYlT7jfqW/TT14+xjbysegO9XhGU4jbfMyaKqqZRI1+A2jbcqwQ0j49wlhbl+enmVcePiSezBVp1yTDjsmJ47Zg5n68pgqJwUSaxYN8dZ8bhT1ysqCiGhZrlGFV+t1D5fmgr8uZjY5yuBE04TRSJ6YFZIDngtkVql6Lu34198k8qBgLclc/j1tHpDNfyuM7F+R2gr9pQOJcE3Ryx27BiZ1vYebNn/i5MygK+bnqW0WTzIVtxf8EMM6DChzLzdlWIcBA4evu1kttzqDVxAfSwaf93+ycU3Spt/672zhhwC9mgbbWrxqrFy3+ezuFO1IwMkQ94qnaD+pSf3vTv3fyo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reHHg4B/TUd/ZxnG0p/LjDdaJ5NHWG62PzdJ3idYoSE=;
 b=pCXjURAsxQI90Fg01m8ujE7ZaKihUmc+ovb5+Z7GQB47Pbbeg79zqQO1Co/tCb/d9XAOaH9oMOm87ZRkFzd9nfBugcTEz/gE907rwRYDPUFcLsxufsan4g179si20wE2o+N3ZGMhbFo5ZKmTRlpQzH1q08gtIcATX/yeFK/2dEhwWSyXkL/kRGLEUvdYQNnoEUr6JwIdLYe+NQhI0hAB57dDgPU/pwauEwwOEYt2AevwLCyCcZVL0jXzS1oDj7IHzsjF88cKCDoyd7C6H3u42BlAAqxiZCAkTR2dMA6VizmpOvXUaWhs2Tpu9VZjPi9JUphEL2guislAbQGrFaq5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reHHg4B/TUd/ZxnG0p/LjDdaJ5NHWG62PzdJ3idYoSE=;
 b=NlDEsQzNqvtpFSe3dfSdZvT3yJWwY9L50d2ik2i7Zf3qlcszkaTNRXIDT3y8TXxeZzOATA3JLXCxzL1ZM3MI7hL1RT/L+wnQS3rar3JE3j6h89T/jsGrpBB7UC+Za0t+F3kR65o4Z8NrNpEyiLRxxO7VZVIwYsZCrhoFyiDVuKs=
Received: from SA9PR11CA0009.namprd11.prod.outlook.com (2603:10b6:806:6e::14)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 01:17:23 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::d8) by SA9PR11CA0009.outlook.office365.com
 (2603:10b6:806:6e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 01:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 01:17:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 20:17:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 20:17:21 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 16 Mar 2026 20:17:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: validate fence_count in wait_fences ioctl
Date: Tue, 17 Mar 2026 09:17:04 +0800
Message-ID: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 47143291-94e1-4c93-cf70-08de83c2f0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: w50ENEupdPU3F7CAObsPkGtIRzhL5xvZJub55d+6fDN1o0E777G4ePz3TMDjn3Sxa0Zv9Gx2ipgAr6spyomz/tLWec7vUntNosIjBaSEevunIs0FyJidjdzDotVbvtEQYhMpfQnImfNLfOkiak5TWdDhhAHDCpl6iQeT9TJ4Wgo99JL0o1l+Dixb44Ro5/MgUTigD7BPL3MpsMHQyfoXGRAtal216up6C0Ems3BqnKETKNDcrPbox2j76VmFLtvSjYhlT6cckWpNRpCl64xjxvWK3RYllf/pIgu/FIJfF9+Ilc271rXQeUau/kOsxm/2GkIgjUznXYvFz/H5JYWilshDO8i8c3PDn5zzA+e+uZ8sH1YsRliJobbzAglcJGay/Fff4TE4HKltnOoq8EY5c+Hdx0DgE/7QFFikI2m+5aUYVSSkTXNPTaS2oeaXT1CGcMBHpWC9zDPGZU26agO5dEWFDuvv4b2eiBa5AZICXzih/ZGUvKV5SNAvksAixc2I3Qw8KgoSInSB9fWBopTHYpLlC9fkYseAMvQ4q0m+0yHK/pYkRZdR9+sHYpa9YpzfaA8Ib70/taI8aSb9zjkoV0sQY7OUPS5w1Z4AsKw0UoJTJoeo5f45r9ZOWuaKloBfV6O4ub+4tG39/wvmTC85yj+1di5xJGycVz+/voaMXUgtpUgsESk3cCOnGNvhUthf/6Wp+U4SEH+vISaJs0GiCJX+hdMEYxrtEQ9MlZd8+UI6l18BU6GiILVEcuE/NMxGpDCbH3Z5M+vVtRShbyf/Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXwjUgZk1MX0J8ayRr25MetnyKVWk9MnLjG+RQJVwO+m93A06Zau8lWGZe3Oa/ZvowYEw3/F3QDh1/1bFSIEN9We3R8CUJvCEIG/c9EEG+etBG122QYgjaJ4tsIPyhDqNdi6vy4kcg5F6IRvl5/V8bzQ0THY/z4PuUz+EWF/be8J4EwB7TAhuGfMfY25lWpDGLDWzJCJ46rvgF9qcEpo+eSzNsMkWHtMffNxU0BvnyoDVfA6/SdFWWKhxWGtlMgRPd3QJAezIL7wHffglC2S5fS4KcK4ayLOQ94TcOTrIK/U9CGxEfMzYOgrVV8Iq/vKAU3pkIGutFbC4x6fvo0Izut15K3hc33tWfG/6hwPslUY2YUp/o4h0HQVdMv/dmlCJDG0o+9CcBQ+N7GsfJzUc0McDia+F5kFQHyI7aYqmv5frEwER6Ls2GbUnOBR5EFN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:17:22.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47143291-94e1-4c93-cf70-08de83c2f0e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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

Add an early parameter check in amdgpu_cs_wait_fences_ioctl() to reject
a zero fence_count with -EINVAL.

dma_fence_wait_any_timeout() requires count > 0. When userspace passes
fence_count == 0, the call propagates down to dma_fence core which does
not expect a zero-length array and triggers a WARN_ON.

Return -EINVAL immediately so the caller gets a clear error instead of
hitting an unexpected warning in the DMA fence subsystem.

No functional change for well-formed userspace callers.

v2:
- Reworked commit message to clarify the parameter validation rationale
- Removed verbose crash log from commit description
- Simplified inline code comment

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b8d23a9f6dd3..22aafa969b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1743,6 +1743,13 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 	struct drm_amdgpu_fence *fences;
 	int r;
 
+	/*
+	 * fence_count must be non-zero; dma_fence_wait_any_timeout()
+	 * does not accept an empty fence array.
+	 */
+	if (!wait->in.fence_count)
+		return -EINVAL;
+
 	/* Get the fences from userspace */
 	fences = memdup_array_user(u64_to_user_ptr(wait->in.fences),
 				   wait->in.fence_count,
-- 
2.49.0

