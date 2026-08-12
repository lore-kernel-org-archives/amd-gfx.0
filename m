Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D52AC5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 07:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2419E10E3E0;
	Wed, 12 Aug 2026 07:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y32NxT4O";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD0710E3E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 07:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuWWGC1SHbOsffdqDqsjdtBX4YJXpyinDiWoZpql/QdcJIRbCjdBCWqgm94jhGNIOoE5qPWtiKh2chqUTk4PZEg1uHEMR5EYkJt1jSytfnxRx+0JGy5r0NGVQQB+N+LBFtWATrlQrP/59uEOSm+CakwUTy5mYKciOZb9+GiXxRmGiLIAYkunnFC2EuNmAhDd0+xtVT2lNJi9M/+OimwGRCuBVdKPk31bXpGlm5CwSMtjTHIa4k3dxfjhMBxCLdmXXZ54bu3TLXupccb/IlZRFsPnuOlbe9Z1V7U3pwJ9EiTTs15sJo8VvMAk/AgmbV5gwcUpyShm00gB0FW7A8M0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EWHiRgXGBctOiOs0h+vAqH/BbbWIvNyG32t032zxuA=;
 b=K8EZJL8yMnCBhOj+/OMhixZo4nYyyEbR5cTwUKUv0p68cEbzUY8ibo8+pnYc3H4Wljp3bFSugD7IFtjRGAhEKmg8VVfhG0fclnxmHjy2SIhgMjr4oSCI10IdE4dlcRhBm75jZ4Whtch5IFrVB46jE4nURJ/Yue6ERhLYsrIEPk+IeQqpzg56E5p6IYuH1Knqf2HMPFrUD7YW+7B6co/YUh7nmavhGnOrpcRxsFqIVOieBEfzS0xfl21RtlaI9126/O3D2exsI/rW1iCmI/uYaUK1VcFkgXrFKFFGy13mbkPG8Dyt3UmOQgNmIRBl73TefV7VaBazA9+IOXeleRJTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EWHiRgXGBctOiOs0h+vAqH/BbbWIvNyG32t032zxuA=;
 b=y32NxT4O590E5Z+SzZL9thks5Pp0TCJUEzUiGcF3nuQwf+jIFCHMyVjr9mUbGbZj59M0/yBiuqiaVIH2O1Z5L/zRtjGlcE4btwTsZKLMC3VbpYD5XNp325977Cvkt9ql42dzVu4CxLg9HcAOms1KA/g3iBU4gOgX+Z1XyzgZiAM=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 07:14:32 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::9a) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 07:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 07:14:31 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 02:14:29 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Prerona Ghosh <Prerona.Ghosh@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
Date: Wed, 12 Aug 2026 15:14:14 +0800
Message-ID: <20260812071414.1066241-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 363080b0-2795-44e6-9f67-08def8415b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +5c+7DJHxjdulOBF/Wj04WK8fP4Vkabf7wpWckKrlJVNE61jAPEYDNTyGmfanCWSaFTh9ZI5FVE/3ksCn0UvtBbHMRgK+tYQQnIPQWfeiM44Z4MTLB8mWlQmKo71Lbq5LVa85XA/LTSbUyMwFxKUi1oBXN2oa1RBYz/mh76plur55wNo756j4Bwsgg5S3GTOiCdAZqTemTW8TMtRevZdMZZOyQTvf6uD/0xlGm0GKdF4fnF2zQyy8szFdhrE0DkrEwQZOw8m1BjNBpZCPY3d0Bzm9uD5hgiLzs+mmno55By0O6FvVHhmoyhAtq2AHahnvK+FGKHixOYX2OruM3qtnmGQqw/FE1Owx/OwySCh6RGKY7aVP2r9vihPc0O8IbWeRZdFDOVhTbJ7e6uByxbJZlo/4l9HmICedj7RImaJZi4rX8VFffgP5+zE5IhguotWoJT0R0VBxMgRYxYlQo3HaPAYKS78/VIUkTYm9CpkmnpZWSMa0N+W/MxSXPXl2pRxzOrUMGTstDoSpbmiE7BWIonjgnATLh3KNwvKWNvN3eqetY6tFOzW5RAl9oaQRrgAIHaTkKhsRoroLWxiQQYrRL02WM2Eh1Brli4O+fhKHrCkHwzru8Yq1143FIwPI14QdHr9c5k4ucI+9gr+ROjeL8L325JcOi8aYX8JN4S2lg7Pdm5cj5w5UlrWHlQ0RhOFYu3j42OOyxn94VinBUt2iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TIiEDJLXAWS7sKEnXgsk7UvWrCQz19N8flAgFsnNljh0RVOQ3ZDZY16IKKwMc34HCrzQek0qRMt13uEd+nhXcjxX2EXyhEi5JlJXYRXiJhfDe6e4/05F7KxMCS11imsFhfawlGHfNju5VxqKebhv5944otERwfVK+f6sF84sN+wWz5TRK6MYQJtLAnD9EaHnCR6U4clwO1qmQst8vE/mqXA5gGpFh9KxKEFBxW0QWiJy+hHOTJRPTtGXb42OdXOd6yg7RYnv+HQkltNLkWh3KMmEZBytN9P6+3dOL3aDIT/XgnMHLAQ77J8LMbtsIXrtVboyS2K7N2Qxfa37CtrPB4cGA1E9STXA7tfAjkse41xmJsoZ3J5ZDiOhD47PTVTg1ZEWNLkrxUvkUuUeUrRujpaDtnbZmdtAAJU/hUe1ejj3aaxsHZthQ8i6F+kDdyMv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 07:14:31.9809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363080b0-2795-44e6-9f67-08def8415b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

From: Prerona Ghosh <Prerona.Ghosh@amd.com>

DMA-buf imports are created unbound and land on the VM idle list, so
neither amdgpu_vm_validate() nor amdgpu_userq_bo_validate() ever binds
them. Only the BO list of a command submission does, and a VM using user
queues never runs amdgpu_cs. AMDGPU_GEM_VA then programs PTEs from a
TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALID, and the first GPU
access faults.

Validate imports in amdgpu_gem_object_open() instead, while the BO is
already reserved by the drm_exec context. Graphics and compute VMs now
follow the same rule, and a BO that cannot be bound fails the ioctl
rather than handing out a handle that only maps to faulting PTEs.

v3: validate inside amdgpu_gem_object_open (Christian)

Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Assisted-by: Claude:claude-opus-5.0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1c2..261218cb57a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -271,6 +271,20 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		++bo_va->ref_count;
 	}
 
+	/* Imports are created unbound and land on the VM idle list, so neither
+	 * amdgpu_vm_validate() nor an amdgpu_cs BO list ever binds them for a
+	 * VM that submits through user queues. AMDGPU_GEM_VA would then program
+	 * PTEs from a TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALID.
+	 */
+	if (drm_gem_is_imported(obj)) {
+		struct ttm_operation_ctx ctx = { false, false };
+
+		amdgpu_bo_placement_from_domain(abo, abo->allowed_domains);
+		r = ttm_bo_validate(&abo->tbo, &abo->placement, &ctx);
+		if (r)
+			goto out_unlock;
+	}
+
 	drm_exec_fini(&exec);
 
 	/* Validate and add eviction fence to DMABuf imports with dynamic
-- 
2.43.0

