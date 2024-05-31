Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27FC27C50
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA2610E6CE;
	Fri, 31 May 2024 16:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A73XIq4N";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BDB10E080
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPCyFd3Lp2qYIxczBnXo58PemK4DQGnm7N/LG8snXiKqMwB3LwTmftcjveQgmB689Wtq2mJT4REvxFmGxef9RbUMQtw/PKvXUkFTpmxcPBu/Q387SRb7LHOS5L7+cXbsNaVrIl4Pd5QQ7QA7O34Ofcik0hUJcIDWs/CH7cZ6Z6lpgFsk9p0BHyx56GABuRal4h0as0WWQ074ZeXeXlRNJEu5sy3gaO329LLR/5O5/yYI/XlbdigwV5CyfjFOOpxKZ+7YTMCso9Udod4ROuBGRkhEWc+S6UjhN9Kzk9MbHMXg8RGstnw2C89TeIob5wZeut4Ddh6xpDG6QZTsIzykMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEhL+wK3PC7kaVeLra9jcX7o3AbBoZY6SoCEeq38SOU=;
 b=L8uS6o+f/wkktj3VKE4xTNb6FVcMrklnLz/2cvjIEbgft/WfZXETNTfaL+L1CjpQevdh/apL7uBtJDx6MogsQXOorRo6x+YB+ojpbDvYokpH3je9MZD4T1pj13snYn7z3yWnDg85vIFkE4undrNq5tnc1nVcR7/92SblVMzB74wtIlmz97rJGWqtuyLYrFK0+GvWf11x1CR6AfV2hH/W4S347fMv44HEJvZIO38aUilJLSu9l8qcoe2Pxahvd4Aat40OLsEqKnBq3WMgjQwHD6+tg4qt20Gk9hhfl8gQYEDQKF3FuMqJjPeub3yY0w4tQvXtKGUICi8q/4e5p1Oxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEhL+wK3PC7kaVeLra9jcX7o3AbBoZY6SoCEeq38SOU=;
 b=A73XIq4NymiuRCw0Ki7u74keFK8NLVFH3JSKXrOxYuYhwcm2qZeNmY2VIB2I7bUvlgSR6ZuWNVvIPvHjp8I0ScwNQNPhOSj9FKGwTN1/i/VGCSbvxE1mhFC1KHe8GG9Ft0FCQ7y/HB/oW0MrR3xnpeUuJO3qACctbyu0qMP4vw0=
Received: from MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:07:57 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com (2603:10b6:303:8e::4)
 by MW4PR03CA0049.outlook.office365.com (2603:10b6:303:8e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25 via Frontend Transport; Fri, 31 May 2024 16:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Fri, 31 May 2024 16:07:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: support for DCC feature
Date: Fri, 31 May 2024 12:07:34 -0400
Message-ID: <20240531160735.3547360-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531160735.3547360-1-alexander.deucher@amd.com>
References: <20240531160735.3547360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6508fb77-0c22-4069-75ef-08dc818bd5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gMi/vFCX1/4BvbX3I4e1hw9/rkfrpPWcqLcaBVvi08CBMtbgW9JG4/zGE76P?=
 =?us-ascii?Q?sIHFd7O2OW7CRbQhK3CZ2Oo7UCpU2l0kO7Ng6kGH/52UNFD3mpRrRRwspPl5?=
 =?us-ascii?Q?P26fAnb+02N68c24LP3cORrFv1ZKDr9AAVjngyfkWEisZEf+oWc5cNyPyshJ?=
 =?us-ascii?Q?wiLyCESfaC8kkb8O4tpuSKUaryBSORhgcaSrhGCVumTuTv2ep1sGGuMFH55f?=
 =?us-ascii?Q?04CT3jWaefE91yCbJ8Q6QZol43E4/heRZAZmGzZ/qBfloEAJ0dHXzyRv8Wcq?=
 =?us-ascii?Q?2keUz7AIUmBzps2ZS2RPlyaqx+xJM/dVBR6wljedTt4sKik24G78A7FiDa8C?=
 =?us-ascii?Q?ae4L4zvtc2HTjE9JBYArt0wYpJqmCLezYQb7CEnTAHb6fDlSO1reFkM4a9CV?=
 =?us-ascii?Q?MpqCfxNYE+ZPUtA9dlCWPdl8E8JW2JxoUHLnKdlnTH38f+Aa8Ryi4dGPzLIC?=
 =?us-ascii?Q?ogpBwDXUUXPA04hmfvbnQbnAoNUWbC9EOJr2xRgUX6cGP9VasiD4zXp7pakH?=
 =?us-ascii?Q?ChEY3F1/uGkdWGpo4/aFCAEnWK4uBG2e/84y17sBPyUEc7EWqf7pnoruD0zZ?=
 =?us-ascii?Q?+B3aLV4xfonY8Uy08qsg1X+7lzeCqgvGnUyDqSG6YvVUdqmW0jaf6216N3TU?=
 =?us-ascii?Q?6uIkNwag/O4Ej6wCz2TxvqeM32rnTIlCEYHsvf4ChnpqoWW6918hRQ+92sRl?=
 =?us-ascii?Q?RLoWPdYWh1EcQOzq937DWP4Rt0bKDAKmWxkj6GkYRroWhdNQzo8MWBAiovLz?=
 =?us-ascii?Q?oVoZCpr3Nj62v40Lu78MYkgKpqn6Z8dElDB4FXDzJSf4Hh6dLgWJa0mo3jLi?=
 =?us-ascii?Q?Af3cDMAhO4CvWntZjABFQdP0yiCkWzz6s2wv4oI7WgIPSlR4TP4RPFkW6xBe?=
 =?us-ascii?Q?O3PhbeN+f/SX5wuDnAywlz4V2n6VFC5o6Vy3CVKZCCA8bk7b7pxLmHe/wdbc?=
 =?us-ascii?Q?R+/caC7uLnAMAKq053N8X7Ldq+0S0Sd/EB/dx2MojiBVbWFgE4AfOGg/U5+Y?=
 =?us-ascii?Q?PCcBkxXgeKFJQEofgnhKb8yVJESlphUaIK99cVejZFx7AkxVLF/r+48qeaU/?=
 =?us-ascii?Q?z46OWx8v3GdxZHfYT6oSvh8/G/Jfm16XmwGCCkgNXt1L0NHno2+3soXa6IdX?=
 =?us-ascii?Q?JVuUU3/10eQV6NuU7PJdqf6qh5DKXTQ8bpbVus4nHzdTqD44SXbzBhPFNqp9?=
 =?us-ascii?Q?6C+LOoVD8halYLROKtol6TU/CXpZNot7/bgLRFqAAsFA4ZxtTpVbmPqeeMtU?=
 =?us-ascii?Q?ibUHqzVksyMAhwwYOzRFrNvu8Za2U5ZnheBVZft6SbFAaqiJpqv1v/oyfwbH?=
 =?us-ascii?Q?ge8ytJACY4vjQ2C03+rD9jPI/UdufrjtmqWA2xmT28ik4UM65K7fxC9WuC1Q?=
 =?us-ascii?Q?yuf3/jx9X93X9IlFIrl46DJjFv1L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:07:56.6531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6508fb77-0c22-4069-75ef-08dc818bd5d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

From: Likun Gao <Likun.Gao@amd.com>

Deal with AMDGPU_GEM_CREATE_GFX12_DCC to set DCC bit
when needed.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3b67809a59bc..1f22b4208729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -334,6 +334,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
 		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
 		      AMDGPU_GEM_CREATE_ENCRYPTED |
+		      AMDGPU_GEM_CREATE_GFX12_DCC |
 		      AMDGPU_GEM_CREATE_DISCARDABLE))
 		return -EINVAL;
 
@@ -341,6 +342,11 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
+	if ((flags & AMDGPU_GEM_CREATE_GFX12_DCC) &&
+	    ((amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)) ||
+	     !(args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)))
+		return -EINVAL;
+
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 6b0b59f819c9..1896f9ed1ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -531,6 +531,9 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 	is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
 		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
 
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+		*flags |= AMDGPU_PTE_DCC;
+
 	/* WA for HW bug */
 	if (is_system || ((bo_adev != adev) && coherent))
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
-- 
2.45.1

