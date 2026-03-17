Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909B8F3380B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D01C10E510;
	Tue, 17 Mar 2026 07:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MCpkKVvY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A3A10E510
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anKHXkBN/XMfsTXAzSqkZecDksBDkW1CH983Lhv1nrbCRWmrD7lPmg8Z+JH1SgyU4fZUfXul2sc8TlpZ1mC6Kizgz4JWxcopPXMV0qdHg+oMFbTWCpphoAigp3NLohBqDP+gIOtlJJEHlT6g+ygGSNQPl/H+imtfQPLr0B7LYUrJr9vsbQs18QT1Oi3qUC9BFiLDuNKt91kMbGPANBArpTJXW8fExOY9YbNpwB/0Ya4QZYFSHotFGYtCpHBM6lEeoBDuPnLH1/Aytf3zMZ34hwAbAoBXHXyxA1UVH/rRs4C0nnaoa7/djpYN5rTKkPav7WPE4VYfr6qiO88xHaicbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XReyvw5lj4CJaCKNoCmdGjCkGFiCkK7mMLFLLB5+pE=;
 b=HT2wqcGS+CvGetxhktqgsSl6vlGWCbiZtNYlS5SuXkVPvJDxSbs0b5bEwBYOd17MlWXyRKRy8sjLM95SNRve8Hdd1yh36zY9WzOTQ6OIvtC0+K5mlQtKnZ02axnzUiTYdK6A9pc2eJW7/y13kSZ1FcOM4FQNC1RnAcjJuCuqWmyWUsup6DF+pTrsytd2eMiUVCwQHqWeuhC7TO+CaFp9uF/Xy4CY7U3VYhdz8vnzyyqYurimpy6GlTw57UFwXjuWGgcLAJel1QD1d/CBmiJfSjkHUB6cDkMPAHvYEE8ZUk//o0yabxMwFQ3vRhlJR49MC/GA3ZSJ3LI1P7YH7VnYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XReyvw5lj4CJaCKNoCmdGjCkGFiCkK7mMLFLLB5+pE=;
 b=MCpkKVvYRl/mzS6AKGHDiwOkiNbiLINVAfFXUmJBSrJJUvb+/3whSFKbDGfFE9gyQSipDjTrcSfHPBd9pRY0Xuo9ls3Vnfy7MRA3AJoc2HNBLjhSRR2Wi1X7S2jx4PR9XihQ7xDIGGt6rjkRrbJNTaliSmjvnqE9MZPZFRr4A2Q=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 07:48:14 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:335:cafe::ff) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 07:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Tue, 17 Mar 2026 07:48:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 02:48:12 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 17 Mar 2026 02:48:05 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: validate fence_count in wait_fences ioctl
Date: Tue, 17 Mar 2026 15:47:26 +0800
Message-ID: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 325b1597-fd3e-4bc7-ff1d-08de83f98b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: EjESBEUDyW51SbcfV2xZdEl7QW9RaA5mMKLyLMaDXng9LRW7STfiGMhwc2Kc0KA/O2O1GeYG4tYuNsPqhPb9nE4cWbUD18uPn/lT701KnZrz9Mf45IYbCdqarnRZJBAVmnIte6qZS05oV2ZqH6srRnx0UmegdmppOopbDpfzdV/kuXG2bdcpXWKTvKp/Xljj/8gquMwwDVWykikQSz8msSwRZ9pbzlKQGjhsPe/+D9+y9O29WLzQEHkykfq5Q5gk7f3rvjHH8eCMmI8rnZ+lGx8RZmVJ5YPgwalKjVSJYiXBrd8JIGQWpj0V0c7PKIFOFnbntQWZjSqqPRHyvz8wheLq57LZEh00AnONZ33M1oGGAK35OTrBhZF9uGldYINmp+EvowyOgzmydNkRT73aZfu2tXmCyq5oaEWdKLW2DkvR7bYjeYGfu5UbPnGd2SBOqUMMjb+vW2fNbbS+So8+DuuZt+S/Tjp/ai2CHMKcEGJ0q/d50cy9MqO2Hryk9BLHXJ+OhycQgj0FcHi63X4sM0aDYLVn605Vob3jOIu9G039orLwTS/z7RQfXERIGYAgZ8TPQ1Lv/Cqk2Kz1XDMrwCU+Ly5a7ZuMhwJOc6GQEj3b+C2YnjBnF6w2zdqE6JrFlaN4RoleFygpb3yGX72kzL+0lsx5AFjzOr/usBuCAytWR0mT+nQq6FZ6bf7NsAyaXmbtu09YcEz/3Qe+S64GzCv4xzB8WLIvY1AmDW1C2F1koig0kFZsiiA7J9+o9+e9B4aHOlo8CfDA7htR+k5zxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2JgXMZ9knZP4d+qy10chYCuLjO8QNKC1BtkVIYv7CxZWYBWJwZRJNvRpuJVyYaLhXi1h4EsZ2M8r33DNJ1U8gpmIgpoyC0fZaqw9ak6LRFi4B8blZZRcziuP4kdFLIHNZaZnVY6Gzx2nTV299ef3fuuFn38OD7GiCuj5YpEmAoDKSawjqe2BRFaJmAZ1+NPtkRPDxO+TNIAhS/hzXtUyTWKEt9wwoc+nzko3VX6BC5slDlJeu0r+DZqNNXiztL3AjpT/+AaIr3IKGGysr1sY7++VW5gSEW2VCu3BmxPVlghsZBnMTUEmD8ocv5auRxHe1BVp4pd6AW65DOj12TF5w7t6kRKiVj3EB3OUR6C5+ALCbSH/E+XCE+yoXmyGXympIJvW6YH0lLmei8Hx+gcwt3jsy1IxRRco6mgp0EMyEV96yagJ2r50X0Nu+nXH9T9G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:48:13.5184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325b1597-fd3e-4bc7-ff1d-08de83f98b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
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

