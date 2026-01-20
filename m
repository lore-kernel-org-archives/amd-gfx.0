Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A1FD2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD1710E567;
	Tue, 20 Jan 2026 07:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IXg3b2r2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDD310E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFaamaYnKmsJCUrATfMjHZxGhlqdDNz7DH/nEcX+uNbYUxcvKzI0KmMgnfhDsmQKjAb/v/WglLJZ0ZXDzUV4vhNJAH5gqQep1jbi8y2JJeUNV/EPcce1+rnGF3OGKjtctk+noVtCGh3y2u0+12tn3ULHX/GGRoTTejDJwmtj85dHTlzKzBvGJplFhvqlkvxAF0GV3tYeCv4rkHVrX53t2ViGza9MBONYQZ61jO3VdD+O8uJTBmtZ48+SbxORRS/0rKYXNfzAFj0g6+zKQuS/BMqKUCAgLVQwcugG5DH9O0nSN6eiGRteRXxitEW3oEA5RbSQnySQHRig06GvWo9opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDCkNzHlsnjCqaEn/Vs70IE67G1XZ62ykXptXo3qMpI=;
 b=K6CaF7MqZ5Qnjle6ADbHeBehK/BML/k07CSGDK7zv73K6TJaQm92B50Tj09Gi+D+L57JgXNc0fN01NxrlX9gRgd0TTcA3dDsQZnCklsrE5CnpUR1EbPAIwogDUKUd+vft1lRWuBEiL9MYguVtZoJ1Hlh2l3slCzYCmhZ7vL92Fpk4nOqPurLew8IshaqXdqd3u1skHGqE16dk9p9pkJtRZhSWvtR6ayuO/hzBoEDM5UDgG/V4iW6Ev2bPpiFs7WpZDwv9uGfO/eoe6oTGExWzj7auVgswrwZvBADfGRNyOguc6rzLyBLeCpEXa4ezsPDkFigyk/iXi51fC1WlZ99hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDCkNzHlsnjCqaEn/Vs70IE67G1XZ62ykXptXo3qMpI=;
 b=IXg3b2r2Vk2awCjmplsnrB0prnOhIsCaa0aUKBs2iVnBMQYwSoIrJTQxbj616T1jJnQgBHLpwWkXPYgtmmMGBtdaAHTUjFhafYofRIGV3MLJd6DspxsYEqNAtZHVHH5hWtD2FqBiuHgFppvNOGGNlwoY11GSKNAzrcK104aLU+k=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:19 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::e6) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 13/15] drm/amdgpu: Move pcie lock to register block
Date: Tue, 20 Jan 2026 12:27:47 +0530
Message-ID: <20260120065931.1300054-14-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: cc56b935-eb94-4dd2-a101-08de57f19233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qxF3qXuYSIcf4vwHPuyAVQTZDAUJnSPE8TdtqvabwA1wGbstmYD+4qaSXmqM?=
 =?us-ascii?Q?Iz2av/c/rVwWDnhRlVcIDWALHpYfvu0RvSdxjqFczLzfgoylZfs7DVon9OzU?=
 =?us-ascii?Q?mMNBGQ25h4QsjjpaRLl6H2h1eDsrVeS+v19jcEdh/IKSSI6AJ3TBRd+MUV5T?=
 =?us-ascii?Q?0A0g7lGZgaIuJC5JREveJBzwlt3DWi330Tp4q2dTYmPJYyJwuw/d+kkrs6MD?=
 =?us-ascii?Q?/tsLle9BXst9DQOUgq+6ekEGgCGrlJDsfFaV6UFWTlIaS1+eDXUPdIijLTWU?=
 =?us-ascii?Q?5bmJ1YGWkGMIb7vENT+7mrq5DbrHXq7tzrslFOev4aOj9fSEDKrzlYU68QUZ?=
 =?us-ascii?Q?tYKAA4Ty2vdNsNMCwk79Csw9ZW7Jncvv0RV13CA9/adEjOrtOdiwzb8nwcbE?=
 =?us-ascii?Q?G0k5opMAeG8G3efpgygGq61cGZ0ea5L7ZV9G4n+z3GOptE/DS36637IPS7My?=
 =?us-ascii?Q?MH3OL0OFqziUPXL6KZOwAJIfRUhUqm6k24VSuT84h4iNXoKdzPrV1NKT4uUs?=
 =?us-ascii?Q?O8KKah+CXYjzm8KLShOHNl4hbuA6pazfW3umo4jscsVIGAw8CHIrVknS/4K7?=
 =?us-ascii?Q?8GTpZicz6el6JE9wEsD/l69tB24tHEdAZ44guJvynTjwvYBzlU2tE5mFossf?=
 =?us-ascii?Q?+qSJG2ARvCvSlbDAVCUNvn95Tmar6Cym/DMoBmhgx6pncNpjygRLolpPKHwW?=
 =?us-ascii?Q?LaOw1EChfUyPxJ40CBPEm3+2/sy71TNoD6vvVYbraeojA4s/LT9utP7FQrWX?=
 =?us-ascii?Q?HnYG8Gw5RMSQMMyPN3ZrxKefvsr7iXSuB2pFL9iwlWN/y2NnGPEynYcQ5mj2?=
 =?us-ascii?Q?eG5NCcFuzo7mmuYSYTZUWP3VheBdJMvsuUheT1uFmGymOOwxGPB/S/YkP5RG?=
 =?us-ascii?Q?rIYnhm0zU1Iv9aHfBFzQj7BsIYEgXM3ohXw/A/CaJAVNb0s7K0NatKGgQw7n?=
 =?us-ascii?Q?Jwx/6KX8TF/bN9VAjl5cYQME/U09lWQO91geGPZz3XUPQZPLJ1XfSMMxvTK2?=
 =?us-ascii?Q?sSYWQagbfyapjk9Ez5qvbms4eWicDjJDUINtZ5uE3oFEW4GiTHkGbncSTYyh?=
 =?us-ascii?Q?b2+QGHWx6FvMXvItriPtkxXgOsn5tpyd5mPoFfhyQM+qNa5fB7gkUIP38OGd?=
 =?us-ascii?Q?9sbTsc2VOkrR4g4uTj7toATRQqScCebFnhuMHXq5qFj4Jp0Ufj0ZEDFPftX1?=
 =?us-ascii?Q?PaX/ijB/9VjX/RpMlq+QW/FeCgS6V32hWAZJexq0yhQHSvKKJCob4HgJB9Jc?=
 =?us-ascii?Q?PEO8tysWx1kJWCWMtUmqtp2osV0hjVEyQuUtizefDzoJWFIYxrBwAvjattsM?=
 =?us-ascii?Q?SS8IrX/N2i9lyBmHsxwRTK/3kD9lthgJW45Qor8W1piqHSwZvTRS4VHHCqxF?=
 =?us-ascii?Q?OBMU9IoLkXB0CWJ8pMaWHKTKn8ePujeILl6Hpx8mV/0HNNnbhqMuPKIsZqol?=
 =?us-ascii?Q?kZFJu89HYdP8izXWI46ncBIlyF6oOvnY7Qife45+O7aeYgy5TxccDRPp7U5h?=
 =?us-ascii?Q?EGStTUr46oqPXI3CG14VWuZaHZLTxPaFMpVRirBJ+mD8de6wxRKSUcWu47XF?=
 =?us-ascii?Q?YVSW4X4TcxUgOvd9goJoIJEiwVmPGnZgyZ66JiGcEFVtIZJ1xGEfrNd6r2dr?=
 =?us-ascii?Q?lKZgBJ7ttO5pyM988U0o4JpNV5XgHpRhtond09iF1i4cTa5D58H4U1S8l7Xk?=
 =?us-ascii?Q?gE7Hzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:18.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc56b935-eb94-4dd2-a101-08de57f19233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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

Move pcie register access lock to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 41 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |  8 ++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          | 20 ++++-----
 drivers/gpu/drm/amd/amdgpu/si.c               | 32 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vi.c               |  8 ++--
 8 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index aef36ba57886..dc985c755795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -894,8 +894,6 @@ struct amdgpu_device {
 	struct amdgpu_mmio_remap        rmmio_remap;
 	/* Indirect register access blocks */
 	struct amdgpu_reg_access reg;
-	/* protects concurrent PCIE register access */
-	spinlock_t pcie_idx_lock;
 	struct amdgpu_doorbell		doorbell;
 
 	/* clock/pll info */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ab4b99823a1..ac7b46681acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3751,7 +3751,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 
 	spin_lock_init(&adev->mmio_idx_lock);
-	spin_lock_init(&adev->pcie_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 0e2722e3722e..a996ab1254a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -59,6 +59,7 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	adev->reg.audio_endpt.rreg = NULL;
 	adev->reg.audio_endpt.wreg = NULL;
 
+	spin_lock_init(&adev->reg.pcie.lock);
 	adev->reg.pcie.rreg = NULL;
 	adev->reg.pcie.wreg = NULL;
 	adev->reg.pcie.rreg_ext = NULL;
@@ -526,14 +527,14 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr)
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
 	writel(reg_addr, pcie_index_offset);
 	readl(pcie_index_offset);
 	r = readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	return r;
 }
@@ -565,7 +566,7 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
 		pcie_index_hi = 0;
 	}
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 	if (pcie_index_hi != 0)
@@ -586,7 +587,7 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
 		readl(pcie_index_hi_offset);
 	}
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	return r;
 }
@@ -609,7 +610,7 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
@@ -621,7 +622,7 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
 	writel(reg_addr + 4, pcie_index_offset);
 	readl(pcie_index_offset);
 	r |= ((u64)readl(pcie_data_offset) << 32);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	return r;
 }
@@ -641,7 +642,7 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
 		pcie_index_hi =
 			adev->nbio.funcs->get_pcie_index_hi_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 	if (pcie_index_hi != 0)
@@ -671,7 +672,7 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
 		readl(pcie_index_hi_offset);
 	}
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	return r;
 }
@@ -694,7 +695,7 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
@@ -702,7 +703,7 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
 	readl(pcie_index_offset);
 	writel(reg_data, pcie_data_offset);
 	readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
@@ -721,7 +722,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
 	else
 		pcie_index_hi = 0;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 	if (pcie_index_hi != 0)
@@ -743,7 +744,7 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
 		readl(pcie_index_hi_offset);
 	}
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 /**
@@ -764,7 +765,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
 	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
 	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 
@@ -778,7 +779,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
 	readl(pcie_index_offset);
 	writel((u32)(reg_data >> 32), pcie_data_offset);
 	readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
@@ -796,7 +797,7 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
 		pcie_index_hi =
 			adev->nbio.funcs->get_pcie_index_hi_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
 	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
 	if (pcie_index_hi != 0)
@@ -828,7 +829,7 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
 		readl(pcie_index_hi_offset);
 	}
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
@@ -839,11 +840,11 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
 	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, reg * 4);
 	(void)RREG32(address);
 	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -854,12 +855,12 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, reg * 4);
 	(void)RREG32(address);
 	WREG32(data, v);
 	(void)RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 791b3e50ac9c..dc0e81cef3b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -56,6 +56,7 @@ struct amdgpu_reg_ind_blk {
 };
 
 struct amdgpu_reg_pcie_ind {
+	spinlock_t lock;
 	amdgpu_rreg_t rreg;
 	amdgpu_wreg_t wreg;
 	amdgpu_rreg_ext_t rreg_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index a4461574f881..29954c7d61b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -154,11 +154,11 @@ static u32 cik_pcie_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(mmPCIE_INDEX, reg);
 	(void)RREG32(mmPCIE_INDEX);
 	r = RREG32(mmPCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -166,12 +166,12 @@ static void cik_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(mmPCIE_INDEX, reg);
 	(void)RREG32(mmPCIE_INDEX);
 	WREG32(mmPCIE_DATA, v);
 	(void)RREG32(mmPCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 static u32 cik_smc_rreg(struct amdgpu_device *adev, u32 reg)
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 621aeca53880..7e7e6c389895 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -51,7 +51,7 @@ static uint64_t df_v3_6_get_fica(struct amdgpu_device *adev,
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, smnDF_PIE_AON_FabricIndirectConfigAccessAddress3);
 	WREG32(data, ficaa_val);
 
@@ -61,7 +61,7 @@ static uint64_t df_v3_6_get_fica(struct amdgpu_device *adev,
 	WREG32(address, smnDF_PIE_AON_FabricIndirectConfigAccessDataHi3);
 	ficadh_val = RREG32(data);
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	return (((ficadh_val & 0xFFFFFFFFFFFFFFFF) << 32) | ficadl_val);
 }
@@ -74,7 +74,7 @@ static void df_v3_6_set_fica(struct amdgpu_device *adev, uint32_t ficaa_val,
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, smnDF_PIE_AON_FabricIndirectConfigAccessAddress3);
 	WREG32(data, ficaa_val);
 
@@ -84,7 +84,7 @@ static void df_v3_6_set_fica(struct amdgpu_device *adev, uint32_t ficaa_val,
 	WREG32(address, smnDF_PIE_AON_FabricIndirectConfigAccessDataHi3);
 	WREG32(data, ficadh_val);
 
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 /*
@@ -102,12 +102,12 @@ static void df_v3_6_perfmon_rreg(struct amdgpu_device *adev,
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, lo_addr);
 	*lo_val = RREG32(data);
 	WREG32(address, hi_addr);
 	*hi_val = RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 /*
@@ -124,12 +124,12 @@ static void df_v3_6_perfmon_wreg(struct amdgpu_device *adev, uint32_t lo_addr,
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, lo_addr);
 	WREG32(data, lo_val);
 	WREG32(address, hi_addr);
 	WREG32(data, hi_val);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 /* same as perfmon_wreg but return status on write value check */
@@ -143,7 +143,7 @@ static int df_v3_6_perfmon_arm_with_status(struct amdgpu_device *adev,
 	address = adev->nbio.funcs->get_pcie_index_offset(adev);
 	data = adev->nbio.funcs->get_pcie_data_offset(adev);
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(address, lo_addr);
 	WREG32(data, lo_val);
 	WREG32(address, hi_addr);
@@ -153,7 +153,7 @@ static int df_v3_6_perfmon_arm_with_status(struct amdgpu_device *adev,
 	lo_val_rb = RREG32(data);
 	WREG32(address, hi_addr);
 	hi_val_rb = RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 
 	if (!(lo_val == lo_val_rb && hi_val == hi_val_rb))
 		return -EBUSY;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 4aadb7a19a2a..c26cb3e8bff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1027,11 +1027,11 @@ static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(AMDGPU_PCIE_INDEX, reg);
 	(void)RREG32(AMDGPU_PCIE_INDEX);
 	r = RREG32(AMDGPU_PCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -1039,12 +1039,12 @@ static void si_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(AMDGPU_PCIE_INDEX, reg);
 	(void)RREG32(AMDGPU_PCIE_INDEX);
 	WREG32(AMDGPU_PCIE_DATA, v);
 	(void)RREG32(AMDGPU_PCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 static u32 si_pciep_rreg(struct amdgpu_device *adev, u32 reg)
@@ -1052,11 +1052,11 @@ static u32 si_pciep_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(PCIE_PORT_INDEX, ((reg) & 0xff));
 	(void)RREG32(PCIE_PORT_INDEX);
 	r = RREG32(PCIE_PORT_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -1064,12 +1064,12 @@ static void si_pciep_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(PCIE_PORT_INDEX, ((reg) & 0xff));
 	(void)RREG32(PCIE_PORT_INDEX);
 	WREG32(PCIE_PORT_DATA, (v));
 	(void)RREG32(PCIE_PORT_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 static u32 si_smc_rreg(struct amdgpu_device *adev, u32 reg)
@@ -2380,10 +2380,10 @@ static inline u32 si_pif_phy0_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(EVERGREEN_PIF_PHY0_INDEX, ((reg) & 0xffff));
 	r = RREG32(EVERGREEN_PIF_PHY0_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -2391,10 +2391,10 @@ static inline void si_pif_phy0_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(EVERGREEN_PIF_PHY0_INDEX, ((reg) & 0xffff));
 	WREG32(EVERGREEN_PIF_PHY0_DATA, (v));
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 static inline u32 si_pif_phy1_rreg(struct amdgpu_device *adev, u32 reg)
@@ -2402,10 +2402,10 @@ static inline u32 si_pif_phy1_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(EVERGREEN_PIF_PHY1_INDEX, ((reg) & 0xffff));
 	r = RREG32(EVERGREEN_PIF_PHY1_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -2413,10 +2413,10 @@ static inline void si_pif_phy1_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32(EVERGREEN_PIF_PHY1_INDEX, ((reg) & 0xffff));
 	WREG32(EVERGREEN_PIF_PHY1_DATA, (v));
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 static void si_program_aspm(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 7d1f9a25b109..a256320b92f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -299,11 +299,11 @@ static u32 vi_pcie_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32_NO_KIQ(mmPCIE_INDEX, reg);
 	(void)RREG32_NO_KIQ(mmPCIE_INDEX);
 	r = RREG32_NO_KIQ(mmPCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 	return r;
 }
 
@@ -311,12 +311,12 @@ static void vi_pcie_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.pcie.lock, flags);
 	WREG32_NO_KIQ(mmPCIE_INDEX, reg);
 	(void)RREG32_NO_KIQ(mmPCIE_INDEX);
 	WREG32_NO_KIQ(mmPCIE_DATA, v);
 	(void)RREG32_NO_KIQ(mmPCIE_DATA);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.pcie.lock, flags);
 }
 
 static u32 vi_smc_rreg(struct amdgpu_device *adev, u32 reg)
-- 
2.49.0

