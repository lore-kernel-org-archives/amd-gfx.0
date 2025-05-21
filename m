Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F8C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB9210EAB2;
	Wed, 21 May 2025 15:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2f8SmFre";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA9010E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMpQd+vgM5Hq7GWQx5Ybt1w+6RvQ1B2RJCjvLFIj05DmbKcV8SHGIZcqRq592MuXY+ZtCLLwN52ziIzz8tRusTnnAcAb8LGNYIeM2v5/xnnJ7ErBmFlhTI3U1QwIs/O4DVLWYxYLaY6Cwc0F451tX5c0h7KxBYjTWLlDMihGPMbFFBaL+vHxP0WqF85KRyrzTxwayBmjGboyD9LpMRIGmXs9Pzrsj9oniAgesKmLyfCm1TtEDhKsa+I4yUevLS+Qb70dptu56npzmESRcQVLVtrC8RcodjgLSWjGeKGGB0mBpAuSMDBd/VABNyHmlV/Cy0pEivM1RIIh138nFeRJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=Al2eHPFd+UpEfka/bmVaX4YNW4SZqRzs8mF/mXQC3QT5DBNI3uB7BuNpEyQ9vsqSMPTbe266Wu83jcbAvs1HvL1O4GOxZUdHcphkm4dbktVObiEGYPAVXRl5wWnkp5Zr7KZH/2vp6KuALH2hFunTwsOrmbYaJ0/XOTmcPi02UdvStj70pQIB0bagFdQ07mKweP/9SqEURtchhmET6zwD5Xxoom636wFO1Csczms5gjKn8YNRcWqS85h3uAM3jpGMhoPfhgtneEp11fSHGZBR5Wcdz3adBtNtiR3YAxSRtcCySeATcdT2lKLL5OBVaO2UzIUGY9eTKNwt9kznOs/oHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F1NUq5kbbjmVOcP5bMYv+43Db2/AkN2VOnSlRaqTfQ=;
 b=2f8SmFrex0DvxhqD4kboXr2YqwhpvLX9IkweZ3ISR8Sq0CQqRbiyc1siWmE0Fq5qXDkdty/RYFE9t9sn8dYwSS3d6XoHlt95iM0w85z9ieJ77E3YYIy8xfOQWXM9dyeyrIvmNgj7igeD0qYVEU/NwmUVpBiJ0/phqDbrG5Dcfak=
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 15:29:45 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.4 via Frontend Transport; Wed,
 21 May 2025 15:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu/gfx11: enable legacy enforce isolation
Date: Wed, 21 May 2025 11:29:18 -0400
Message-ID: <20250521152923.401945-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 4184a9a7-8fb2-4851-6e9c-08dd987c4f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?994+mpx2hLbKjBMQ/RhFpv9J0/bTpAwU/LNrf5gGCqWBoxXnZnLhfkYhhpUw?=
 =?us-ascii?Q?c6cX1Xt7HOCyxl5nOGNJBGl/dKsereZjnvN/mwk6DWRS7VH7XnZv+yde1LjB?=
 =?us-ascii?Q?JVerfTzH2XVQE6Rl/Il2CKglsVpOq0lIIo0lzoXUBR8Ldu/bXRskbw3lwSsi?=
 =?us-ascii?Q?6/1kLTjnSJ3eawbKuAt9F7ghxmGLvuGQSYYchSUgD55KwcQW74b/+8HMen4+?=
 =?us-ascii?Q?Ch6HNrdmYbnOERVnWzOz1MxIcvTPPZI9J1rzEvhms91qP6D5GrnM0gVuCqDV?=
 =?us-ascii?Q?2lqgJiotAqqzNJz9toGONW5vkPAXN60KluFX2dmOVNhqNuu89VLXOW70GmFY?=
 =?us-ascii?Q?dM56nzj4q4QQhBwNSGIAfl8YEAzpZWc/g4pdZh/i5VgSRHmOwExzdoKouPjc?=
 =?us-ascii?Q?65gP4uX3YbIsnirJCFJ6RiUMmb3CYZ6ErufWFjMJ8wUXh3+soYFoHCOmi2ET?=
 =?us-ascii?Q?LgV3MPY+TXTmPMViRPHGZW0NKnizQ0y1NgA2FtUXYHla6iI75jPyOKgmNzoz?=
 =?us-ascii?Q?O1awCM2Jj5XujFJh9F4IZuWz4f+8Sb5p87tR9Uhnu4nWFhjLFgGfG3sly8HE?=
 =?us-ascii?Q?qF6OItT0kWzwdvYr4lCsb2MSsl+JrsvD3za4aaWD6CKFg8+VnDezXNMJnfBa?=
 =?us-ascii?Q?do2hzCg4qJDKVLze1hYWhy2WA9K2jTgoNJIgbvdiYJdDR4dnZj0hjese/HCz?=
 =?us-ascii?Q?Ze5ZJKJT+f6+1fnhNgHOilZt6jBg3RSoyWcoQ+7F69cOcddN7CD+rDhVC3KQ?=
 =?us-ascii?Q?eKuX2/YD2jf0Al4rJKbtFXtX+YkuDEDcudQVjWE4VyqMvB9mz4s36/3cP/tX?=
 =?us-ascii?Q?LStWeLWvwhGHB0sDcJEla8gCRJTgDqG510YHSiaXWJ59U/lMpO0gd0xezTSJ?=
 =?us-ascii?Q?uzq2gnQ+HnLvsJMrkuBvB88wWv+E9DWvYTExX1Fxf7d1CYjXxnv8pmZeoZfR?=
 =?us-ascii?Q?1Wrj1UUeY2egRUJ49OpAO9bFxlsyt8L4JlucO/3Vw1PbUf7C+a0b055fZd2L?=
 =?us-ascii?Q?wuR1R2cRTYLUsYPyHHnHsKNwxXbHb2NU1kgcPxCqfP1GWjG1061jm2Vmjs4I?=
 =?us-ascii?Q?XvhlKzg7r3NR9tlqxIQpuuIzkRT/RGObzzBYDBKcL3YFiJNIGjyBdqxrKIiE?=
 =?us-ascii?Q?UsX6DqQ+t/kEwLh0v5oVe4VbUUV4g18PgOmshPUtdKJzSUcfoo/4ybqXRe3r?=
 =?us-ascii?Q?fH7HWCmCk6S7sv4Gap+QxP+4kX+0O6KvhE5A6ltn7S1IeSRESgB6iWcrPKHQ?=
 =?us-ascii?Q?0glASkhwRRDLN/7pXMmPjt9LPHk54+bF1MnlEgXqpPas28Mg3H+Rf8IJ6GUN?=
 =?us-ascii?Q?U2Jq+T1VXkiRHiYYRCXc2wf2tlLFIfokaWSV+s9lZixqP95RjiLnx2OAXO6o?=
 =?us-ascii?Q?/XndYm2hLAEmuQIVppJ6EB98kVC23JQoCghGRTnGZMor9ULNVWRLSEehLSRF?=
 =?us-ascii?Q?K/rI2tfkSwWa95JuclcCHNzj2BK1X2k4FNy3RpjRSYYFy4AiXKFk73eOwnz1?=
 =?us-ascii?Q?Irs3xZGPcg50mGm4e90VeF72g3oihOLDV8Wc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:43.0488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4184a9a7-8fb2-4851-6e9c-08dd987c4f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..39374c87738b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5189,6 +5189,15 @@ static void gfx_v11_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

