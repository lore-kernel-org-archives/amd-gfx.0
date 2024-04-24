Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A7C10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC60113C14;
	Wed, 24 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YRnWN+UA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E15113C12
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BODp8fWxu074QZU1BwZs5yeGAYwjIvwf8pUftSvWjVO+Mken74ArwCzqamRGcososqMHXs9dJ1z7vNBiclDNUPSnT4tdDagmlWeaQVe0OGAjMHn6PXjIdRnvDNFojTMzVCpk6tkrlVyTCANFDj5oiM2KINzS3QqhkTPICK5sJHYjYGPp7D+jHYtuUyB5Ro0rwP5kuNVJ4K8BiuSM6v08hjv473z/Auc5687hbTUnKVana07DHrXO5QKDD/Ed0xG8dL0t3OAJWNEGV4ChtkBUlK0bfh9azkJzqM46lJCcuAlDH2AHTJQYx+YO2ikwI1QR7JWAiTxjz0gCys/HzjLGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvJHdkC/fgJb8Uf9JqQeHUz8zysgb5G7w0KLsLww3xc=;
 b=RGpekq0fVW1W/wdnGYfuxPzxuoVDKQMp38vLHZFzq1okbHQR6v35/v/G61mGnXWsrG6eds3b/9tBoMafjbfBcuPxby0UzC4va5djiC2lQNkfvRDw/SUvKvrxEC4cPJDpvVJhYNo9lyNcr3lgZd/JqBnnshYldvHyP56QZCO6NqvsDMos1xIwBqWhsU/HtnK2SIa434CmeyKJk3gOLAtyzz5bPUD8sfbr7iZaO/U02Eya0HcKeAc+8l9EPTrB3aMA7cspaMp5V3NSnq7MFlFPgbJ3T+0W+BEehHrYTWK1rT4be3mc21BPbd6akfZoqgMo/ekpAB9mYdqE5qrT7RgTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvJHdkC/fgJb8Uf9JqQeHUz8zysgb5G7w0KLsLww3xc=;
 b=YRnWN+UAcgLjkghfTnARxX/CViYwNksH8vDSxyJwqhDd+b50nChWFQMqMxga/t2Kl7KbSeEPZqeFGaY4YGhaN5adQOrj1HC59ShoA9Xf1rGQyHJrD0wpJawYJwT34ODVBuBHWhfI/T79oF2I09mQ/TrRBx3uys/greDDJvU7KN0=
Received: from BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:30 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::61) by BY5PR13CA0014.outlook.office365.com
 (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.10 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 1/5] drm/amdgpu: Support contiguous VRAM allocation
Date: Wed, 24 Apr 2024 11:27:45 -0400
Message-ID: <20240424152814.9608-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
References: <20240424152814.9608-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8817cf-eff4-42d4-7949-08dc647355a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YQfOdBX3ZERaL2WJTeer2J9JEAjD6LDWdZY5Ov79jnOn16Mk600Qdr3fDTn7?=
 =?us-ascii?Q?DsL54yaf7OsygvP8kpi2KQT1qIJZFQawh0YgBsCGKh67CRapE+tbcmRiHetn?=
 =?us-ascii?Q?VKw+4clD/m/qPM2E37tY3he1SNk6u4OTB37W1JPODG49xdxbekZLNVhkhvVy?=
 =?us-ascii?Q?5SF+V4roumSOAj+hC6tNoI9+pE61BPjfvhSuU7scWTZeb/TLj3TLqkc/aMpc?=
 =?us-ascii?Q?Mt0ohAaQaqa3CmKRCpa6nYc+rNybNr4fo7FjcCMtSYxvaErkYDhebGV0HEJX?=
 =?us-ascii?Q?PG9mP3NdideKz1Nzsd+fqIjuO2+CUJcv8Oj92Tsx+87HEIVurVgun6blMvd7?=
 =?us-ascii?Q?pujPweQoxddwpes8NrLrl4D7D2AEbm0+0rXJfT8XbHBUxvnJHVWOxqSNkjnb?=
 =?us-ascii?Q?TjW0BQA78N0YuOCLcFu/vD7fKHXRFkyZfusDFOVG20ZSIReQs3CeUSTIpFfS?=
 =?us-ascii?Q?3CwYXinJHWFs/VEEWymRotCm3fGl9psSd7+yEWMS5iVPAbUwwGZ2UDbkEZ6O?=
 =?us-ascii?Q?jEjz+Yqi6VNYoS01WG6l4qw4CBBzNyVUBaT02RfrAB9mE+praEr3kzW9XPWD?=
 =?us-ascii?Q?KX/CDxlMQgFVjB5pZV6Mk4PHq7Hg2eyLMuFesdvbPlk5f/HtmApwtQKs6UXc?=
 =?us-ascii?Q?N5KnRiydBlLvri1FA7725rw62t4NQ5ww6yAePsSGshr7siPZeEcceiUSClAv?=
 =?us-ascii?Q?Ov4MAajLFopwjSazPh1ElGGi37uoEvRKg+KvXcU3qzNYi8lXj316G9WCj/0F?=
 =?us-ascii?Q?ulobzLzw+v4JPeSt7BrwTAeCAtSgmGSabiO1Snh9U3tgI3q4+x3JMJhV1+fP?=
 =?us-ascii?Q?4AlEK6rz6u5xOQearRbEKyFX7aX7YLstbD7d0QJMqWULfrav0qIHwzFJ9tOi?=
 =?us-ascii?Q?8i7d53uNEnzJ18UFOvE0LnFmX7pHm1+R4Cr4ul2MIJILsrZWm/S+POxrbHas?=
 =?us-ascii?Q?mRkMgb5Gg1xWtJsUC39vaotb15GLTpudwdEPTikjncM3LxOKkPaMYhHUUijC?=
 =?us-ascii?Q?jGb1kwNylgrie0TeX2zq4x6tqrE8RJL5//72uqdn5XIA01v+dvHruDd0dFgv?=
 =?us-ascii?Q?NMpksU8wY6XQt39lRFB10w3FQCarM5ogLJB1a3s47XUeXYjvADxXIKSP19Nj?=
 =?us-ascii?Q?v0NpTmw4Fn662GfjJ0snk3Pj3Tg05PpLQgBAn4oVI2BDR666lPesG5AlH9Za?=
 =?us-ascii?Q?dILM+Sx+Ye5MLy7q5jNIwcbdCHSdhcRnxRP26Y5nJv7OU3BbmLGbaEa3dXLf?=
 =?us-ascii?Q?S2jbYC5KwlDuobDTbSL83E0KZxUI+nMZ1jUpMGu29Ax85TlD9j4wMg1ZtmqG?=
 =?us-ascii?Q?ojZNgGdJWKdC3sUTYbhuOFYQFUyR8nasFYYHmRpHWwFNjtwY2b2k+m08FXR4?=
 =?us-ascii?Q?jzqxBrC/I2SjMd2I13LtUbDFOx/b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:29.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8817cf-eff4-42d4-7949-08dc647355a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
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

RDMA device with limited scatter-gather ability requires contiguous VRAM
buffer allocation for RDMA peer direct support.

Add a new KFD alloc memory flag and store as bo alloc flag
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
VRAM buddy allocator to get contiguous VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 include/uapi/linux/kfd_ioctl.h                   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f672205243e0..02d66faaade5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..d09c4a18e571 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

