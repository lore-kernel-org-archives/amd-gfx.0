Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B5CC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C72A11339F;
	Tue, 23 Apr 2024 13:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGWaZJF/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F243C11339F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldhie8PKsmhEgYvKyOcU6b/BlaD8Dk+Gh2CLFf1Li9rZ0vehPIpovp15MeejWmcrmY/Eik7x1QQ2tUO7zfKz4QHCH2u4BoTjVxMXY+la5quBnugCdOAJis7t2dH8QtjxUPjOMleTPw/xH/n/KSduXx+yXX8YTCdrcP/jVYBTlINfVh+8DCZDZWvG5aBszthdLtnAFGwgAgdaArHRY7/2gDfZO0fF//pBgxm1V4ytDCegMWIMsFEGUKVkgMKSSxPwPJY98xQHeUEKWQDqkP5nFkjzrqiI13weVeZHoCd36hFUuvvmcLvmw6i+4QTJe4gMdWxYj2texCqndghnD87wQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=GWOdOXzb+wzI4BZXz9cEbIcGMrFDYYXSKkG5oQNzknRrfRmtghtLXGpa8FEqiialRXOdYcvVvTqEuFLmqMM4H+ocmECin2x1sKuAk/JSQjRvD3cBzQBjt4jyfy+m1kY+DUeCtNcEiCO9DnGqHNlWC/kNOsutqo/HcV7yuqR00u1+PBzbk4DOa9QeONYOAMaL5eFtLPNcbqdfBrQtz0tXIGuISYQlNqT8sSub2gmYYT/Um7gSa3FbniSbz8LMcXUYuurh5qc8RzC0max1KAyYxDLtG7TTk576WmCTPNQdVeOyju7UKMnetuKN2J0ntQRGHsLcqRaOk+1Pn3MjaYLgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUDDe9KirG2+gWOuw5cy6LoOZeXQLJth0ruXyfu8qM=;
 b=bGWaZJF/MO/gTiHfghelBzbqpEzMEE4nKfPZB2MDDqpajG2W75L92e0rs1CJ2HBNdXguJx1Kc+7Zccc7pD203jO2m6mroI6GQ6XPaAgTz/Sg4UsNwQBGX9XfVja28ocoVUeS9m7z0CXT9x+QEhk+LdGBHvKynH3hO8jfVQbPBIM=
Received: from CH2PR18CA0032.namprd18.prod.outlook.com (2603:10b6:610:55::12)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:05:40 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::31) by CH2PR18CA0032.outlook.office365.com
 (2603:10b6:610:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 1/7] drm/amdgpu: Support contiguous VRAM allocation
Date: Tue, 23 Apr 2024 09:04:44 -0400
Message-ID: <20240423130450.25200-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423130450.25200-1-Philip.Yang@amd.com>
References: <20240423130450.25200-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a870f20-4d92-4559-ac90-08dc6396138c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lk0f66oHaZeq9Fe4GpV1OSp+p9jYva4D3fpbWxWuMrBllLEPr15Sw37z6dSq?=
 =?us-ascii?Q?UNHP4U+oc9ZxjLR3UBH8aOpk/TXwqZ2stR88awfsqpnWO+qJOjpg0HPtMEmt?=
 =?us-ascii?Q?EJ5smDAnE5kSLASWeTT/g5ELUorSnqU0KFJ3txMcvg9NQ+t5ZY4CU1TGl0on?=
 =?us-ascii?Q?etqiX8Oropc60vX5fOOBtvpbKAWHA/jiZaqtjRh/W3BrnwN1tla73aOt5wDp?=
 =?us-ascii?Q?hMLkVdOBdQnf7QbN29HVDnkYX5KrlM6UElFxYU3fhZz8XgvrO4qm45Cf8fEs?=
 =?us-ascii?Q?YtJtptN6uEDbAK7w1yggP6UHkB4nKSCYCr0xe3KnlZ5NuwnpMLH3cTO47d1K?=
 =?us-ascii?Q?T7/8E04HaBG7lg6a7cKxblQiPIiONrFHYF2crcLTtawFoMuqawtDj5IF0wuw?=
 =?us-ascii?Q?OEYyaxhF4HEH/7aaqi1uW8UGAFEE4NxxV6Ghx329B+t5dq/ZeVEyrAryOLtA?=
 =?us-ascii?Q?LoctNPbyLd298pBd62HJsBHsu3CGOMoywVWoFQR/FkUvJO+c9471ywOXOwZo?=
 =?us-ascii?Q?wiL8IHIVyFLW7lVxYzXi+t/+xflM6ELGamA26ecRnCUB6RMqBXHKarSMj3Bf?=
 =?us-ascii?Q?4P113W2xjFOvgVhsQ9n12F+3NgocPinG/XnIi2QTjDjLUPNlFyzw+DmOUNTA?=
 =?us-ascii?Q?oVd64ln5NOXjt6fa5+3ZR1/5GhdKpOQrNZScHtOdIcLsGTgRnrRZnDRx0/It?=
 =?us-ascii?Q?cAiD68QfHNwQ/B4uNTp63ke4WlqNhbwGIHpRgZYSKv7tjOhKoM7lUPzktQ84?=
 =?us-ascii?Q?irgB+/xPxbCnb47TQWfTTKp3czPyU7EMW2wpGSuvBEhbAFHGMY6aB3Br4O3l?=
 =?us-ascii?Q?i6g4C6uhWZn3NcSH4x4Xid2N6ohyQq4JSMeHvQ7bIdzq3Qi0WzsGiXz+Seeb?=
 =?us-ascii?Q?3b4JdimhO/gXNCRWgrf9I/1M6Xn6yerY2QfLLI0WrznnUlxS6CZ7gd5+ne9P?=
 =?us-ascii?Q?9QI0494CtIZaXO10XjQ5xjA9duufR79tqbmOMD7C4tZgoHbNVvXUsKQqLTqc?=
 =?us-ascii?Q?HhfF6qzN/I2VTmYoGm8/G2nouAsEjwg17D9q4PfhOP494mJReWTJjCIPYOZP?=
 =?us-ascii?Q?MVX43hZUMo20eq57a/KKnQqupJ54rzgPkgicGIJXEcub4E2U+0/YWcRzeomd?=
 =?us-ascii?Q?Jx3f/ViF+ik3OPAF9uNcX8AFATXyj+nXF2K5gPSRdUFVhe4nokRcR78QII7U?=
 =?us-ascii?Q?bpxCdKhbSFHTW7k/f/atlnZDiE8zXwDpITkdlW8mWunlPLiBIeDkAz/d8WeV?=
 =?us-ascii?Q?Bdait4zRj3oSqWz7f4viA9YT7cUhFYRAoLWEN1WigAsnAHjq8+pG7Xx5NpSh?=
 =?us-ascii?Q?MrtMdpM76s/fqJWibTPnnfIYcfNsvNvuJIB4d5/kFVHVz6gfzw8+pnOl5fNM?=
 =?us-ascii?Q?u8DLVt8ra6FU3ih8bCvJDjq6+zZc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:40.3373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a870f20-4d92-4559-ac90-08dc6396138c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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
index 0ae9fd844623..ef9154043757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+
+			/* For contiguous VRAM allocation */
+			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
+				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		}
 		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
 					0 : fpriv->xcp_id;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 2040a470ddb4..c1394c162d4e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
+#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
-- 
2.43.2

