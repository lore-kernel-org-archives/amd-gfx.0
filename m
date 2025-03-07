Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93258C28B30
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0E110EBD6;
	Fri,  7 Mar 2025 15:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXgpB9tN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA6710EBD3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3E+6P1ROsdOKbIwacnQQwV1iMeDvimpsDiHY5gwup+LPkOdh4teIu7N4gUBcUvlCxIFd6zre1wsvWo1B3ggGJAALa3s51kvs/GXp1ucqOLlLq0cX/Aq0yqifPAD+sHY7Z95OmXoBwzpknH4vrheDn3S1FGkOZtPoR3qbXHtas5ByKCvaLyMMwTs+vHRZYBjCEmN6jDNVc2rh52cAQza6t+mEnfvY96n0yxGDDNTht4QEx60M8tfep2DFTqE3s96Yg7Z1Dwj7t2yaV7WsyvWgNuU8G1d3ZdTncAcchPtnG40paYMmUttYIntF5UVtMv33ErJT8uIyajnT6UBp8bBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=YSDNjeJc8bPH/Tk1uhgG3ES6RQVFFcfmBSJeAZ5ZkeeIRO53JFrXI2qKQpNEYugJwD2MXEuX45o+yjRXNoLtnCbkipiTQKiZdiAg6TmNtEfHD+w2CZZj1MiRk2760Nl4LbmUca1DNXIWEA15gJrvnd0JEBJsfVc+TJiRB1Fo0vP2/i64RghPVxr0DKe7CzP94Ca1xmLfpZyRj7wfMzyYLZ19sjjTM8H8kL4QAlOeABo3nZwjYZNBSJwe8f4NUUUzYi1bfjHBAcgpzy/RQqkFnd7uTiZW3gbHjqvEpl9sZMEvjC5nR5AfTQqhZMcD4rLfEGv4to4Vgtv0/O7MuQdxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=DXgpB9tNBFXwwTUXr7hZVoB6QMDygaiI+RRIer9mVVWaOlfHYu+Moz9xoEKrOJLvcDzdZp2Nx/6UMtxGVpXJSIUhgFY66tZf799Mymt0JRJAF0vIiSkwb/2+Zq3d2ELwwbfnKAc0KvrbhC8SQyLJfQsAMLan7+Mds//3xW8vgKM=
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 15:16:25 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::12) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Fri,
 7 Mar 2025 15:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
Date: Fri, 7 Mar 2025 10:16:04 -0500
Message-ID: <20250307151605.946109-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdd413b-8368-48a4-cdd5-08dd5d8b06c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DuvzUenXFj444YPA0C2XXnwPo3yXyLpsWMVaOmBa0e44kC0G5hGBOU/NjhSo?=
 =?us-ascii?Q?qD5DFJZTYI1NEQv2ruNOTQc/LPdu22mcbiXCHXZUAC379SpD4pD8oWXsG/Il?=
 =?us-ascii?Q?A7qZ5PwOFTIaLX+yo1eH/MGN0i2TITJ+ZvS2TGdl4m4Vju92K0Y/3yabsQs5?=
 =?us-ascii?Q?9AMmYceLw04i655eIh9wLAy4lUqfwzf7tDQFP/OmQzek7qeVdjYF+Imj3Lsa?=
 =?us-ascii?Q?EBqLjvdNzqcvJGyPrSD9DzNjWe1dG1MeiWS1cWwyM0RQghpYA8EN5DD2U9qq?=
 =?us-ascii?Q?7WBOVX+mPIzSj9OxZ5qkTlRhwvTTKrrOe1Gv8PM5ScmCb7SyrDYWMjYZ9CCd?=
 =?us-ascii?Q?9Sno6vdf4X0IgChOhl0iLpInnr8VAUjX6Gg249RAh+GkANQC/agkddVidbpm?=
 =?us-ascii?Q?fafY4+n+1o2JEzzgV8YZTw7jlQuiQcS8r8bupw/1LmIU/Pka6ygHSENXGJVO?=
 =?us-ascii?Q?hL57WoRP6t0WwlUpsjWUNuFLvxWqWFFBXpKy7867LR/nYZLZG1F3yjmRytj/?=
 =?us-ascii?Q?ca8MuicMjfEHzI2oGgtn05CUHndEaL+WFKRf7si2gncob8HVQVNQ6B9dy/VN?=
 =?us-ascii?Q?ZtGuys+AdwW50Is6mZplhliw98x1wPU7mFS5P/yNr7UYfESfgBTFyEbV0FRu?=
 =?us-ascii?Q?Q10dyw4LKSumCC+xladodZDvNAoRLFJvU5bh4Sqtn/nvudaXJx5VKXVEgbd6?=
 =?us-ascii?Q?Ic3IAEvRQCWx3U8KiYXv8LtjyU9W9fB9nkpTbppz07DZ1SJY4MOzGmWFdPhb?=
 =?us-ascii?Q?FuhqQ1yrrm234dm9fEiV2D4CzIc4mNp+pZ5Oy2BaqUiCMcY/zTjGit7QdqE5?=
 =?us-ascii?Q?YkDC3SmP48hcGzeECAEFPfV0E7e8VgY6Hp8v93VgWZEwsz5DKkLz3XFKi1Dq?=
 =?us-ascii?Q?jX0dM7AD8p8+MqC4c/QFhiRCYNXHvKuVWG/6DKtXpg9JRicozt4f2qRyq875?=
 =?us-ascii?Q?zvkv1zzpRiNL0xbWXNN6Q7vdNEGtHEH7gExTSQSZTSGLPaGscrmXWXB7VBf2?=
 =?us-ascii?Q?Z1jbVluKGARr3Xmlk798Uy7qbpOuortMsK58A02vl/VWFXy5BzL1YN2qQdu/?=
 =?us-ascii?Q?+lFPsqWEixEBQzZooRfho0tO8q0TGJQohVUy0M5XOiwkLzJcMWi95ugWex6o?=
 =?us-ascii?Q?oKSkoVmVCAOxbpZVImz805S/gSOL2enehA8v4iWDr7IV5XlUL9rYLh6atj1S?=
 =?us-ascii?Q?WU44ldxIJ+cKrdw9GpbXyG6CGGwI+BD52iKNjOuiddNSjvzkG6LBXkrL3W3O?=
 =?us-ascii?Q?AIiGliXdyLeX/Rngz1zN1DHGkwDn2FUJqFWVcRU03kvhv53cJ4YKtBf5XjeB?=
 =?us-ascii?Q?G6vskGf++VMmSpya5zfwgBfU3YZQ04I1DkqFGBMfpMn6l4XpxNDCzdBjVLHb?=
 =?us-ascii?Q?Gl4C/nfeAyvJ5TU1P6MuTLjTU8xXEa9dKwBlkVgsTwUBwH2FTv71EiqXPEOM?=
 =?us-ascii?Q?woJq9DaNgbZBV0KrWBFqxK+/cooa+skXjKJNuwtQ1XLeHsZSH/3xrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:25.1408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdd413b-8368-48a4-cdd5-08dd5d8b06c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3aa4fec4d9e4a..bcc72737f8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
 		return r;
@@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

