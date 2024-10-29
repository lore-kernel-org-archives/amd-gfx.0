Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D287D2AB1F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 11:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835E810E253;
	Tue, 29 Oct 2024 11:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WvkS4d2u";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54E5A10E253
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 11:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFgq5J9KgkgpVsBN4UzyCrmonRk4I8KAXeBsmFOYUwnfffV3geWcc7C4QsX/NbN5T9QVH1+8KkoBhr0anL0Hv/qvrdZX5/AS/smTGoosiB5hAt5y+gcRTR3teVEYOzWAk1+fclHsbd+HfpUMQ9Hm57rnMKpAvAus6AB95w04tMvjoZgro6696ZVdwp8XaDBAcekHHqN5lSiTmYX2NiI62uF+db59qs1RyOu7oivJSE4ypJ1uMJi6AhQWDW3I5Vj5Fz7ML4HiYbt1W4kZaccFALqaX3482u6MiaG+1Hmxa4v28K21mcXeTdI2zyAY3FGOdSDXLKxwCI3dE45puszWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzXyTsoOoAoR3yTF1AoaKRDM0wN7Js5Tp1VpWXh2JKc=;
 b=GRMxuAtz/0mhBaUyruvIHHzOrsv4Yk5Z/Co9lFxzwlXJbIy0kLhf1lXBxLYw0FjUk9lGGBIREYUyUZVUUaqetkXEIWnFp+C/MaZKaJ2Axm8XDVGzaTjht9Ydvk43ZqdkhDiIpzsoC5IZxRI8067TpumOgmd27724Qh3tBiYgFLHyLV8QJ4HnK6GiX4o4aa+mB6e9K0UysJp2gYoPbMOPO3b3MB7ZMvtMpxz6QB1af7mr6zk8xcBhhPPFh/ZbspZq183UDNKy502Yt6iEtISr0nMUidFNz8WyXIJfjirxb9g2IF2/GaYneKXIoC1FmKmLbsoHNokqDtOIARHgg2HucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzXyTsoOoAoR3yTF1AoaKRDM0wN7Js5Tp1VpWXh2JKc=;
 b=WvkS4d2ud46MfBcGP1vVA7Lsrts3jkawu9HQv6a6R6TxC7jtjhnAj1ImS9QdlvVxAE4sPjnGBirxuI4oH7hzOllgMsUf3KmgjVezvRKbVTXnClcN0QUFz+lhtVPcB5iGZyfRp86w12cwJxx16MkSzNx48BTWH9udDREekuKfUK8=
Received: from BYAPR06CA0051.namprd06.prod.outlook.com (2603:10b6:a03:14b::28)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Tue, 29 Oct 2024 11:00:59 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::44) by BYAPR06CA0051.outlook.office365.com
 (2603:10b6:a03:14b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 11:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 11:00:59 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 06:00:55 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] drm/amdgpu: add userq specific kernel config for fence
 ioctls
Date: Tue, 29 Oct 2024 16:30:39 +0530
Message-ID: <20241029110039.12005-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 564b6802-d0d4-474f-d2df-08dcf808f8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6zJRAc4EyPD4XTVRWAIbQIiJXldRpE/gA6PEzvGydYnArK6lsP/3f+dSO8SW?=
 =?us-ascii?Q?ns6Y3yQhXnjrLIhTEdOZjTPzLKt8/zjlB3CmkWsTshQ4SJ+gvuf9JF46D8In?=
 =?us-ascii?Q?NZkht8dRVIOCbCk2HIxdQHhC6eGIy3VDST0CAVxsh+umNcNQYq7jhNjNDomw?=
 =?us-ascii?Q?SS9lKb6WvvwHKDHnHL7r+4pCqM0JH0GpPdE6fJwWJZxO19jfrHTd7jc457Sp?=
 =?us-ascii?Q?UlNwptmpQFGtqhHGbG7LznQyj2sqKrBWNnxJLb5ZyAVXI+M6Lfrg5KAoX5E9?=
 =?us-ascii?Q?DuoOkp8MNN4vJ1wNmFm7rfwKgFTCH12K+xeLYz1fa/pEQ3410du2j52eZo22?=
 =?us-ascii?Q?ap0ulZ5E1eee2XvC7ZFEF5Hfgg9f9cMwv/YUzdq2Zk6/OvISF121AJK40K3O?=
 =?us-ascii?Q?bm5y5dk5tsRMn/Y+lsnH0xukt2nfi2+yksRLZXVpNvWMDjpD6SZTLHcWKHV6?=
 =?us-ascii?Q?SYmoWeY34ZGfO/nVHGXyJttzlYlmYRaruP6i5NAZVmUdZWaX96tsmXFDjJnT?=
 =?us-ascii?Q?EjBhLLruK4KlsT8UEjhbfbtwnvsrdw4hZQXFSSpLz2QHeXxZH1UqhpbOznB0?=
 =?us-ascii?Q?jIRonXK3nXCW/uk3Su7J1Qyh/guya8kb+eTfFRLu4QUIlC6x/2I8CYWnLplY?=
 =?us-ascii?Q?oFconcQufgFJbO+cTqhlKaGfFCktYCS8JCYdrt0huE0vVXmMIKUG7yLq5rmF?=
 =?us-ascii?Q?CAonAVHdGKugIFggV4kCZE++XEPum5gcftlF+mnyc7NTYrkITpY0xQyvS2R1?=
 =?us-ascii?Q?rF+i48FbeD6oNN8BJDxLlVB3y+pdKvHUVrvLd7+GK2EussbSlLhgubc1pkOR?=
 =?us-ascii?Q?9QYFlS6qHBOU3MoI7DivH1qv83J/0FhzR0Nirk/JYzMieSQo/taI90cmjW+o?=
 =?us-ascii?Q?zyYumBod7FjTXxc68d0Py+YrBp5DHMV1jbe41334MklPPD1xwieU6CPyd5Pt?=
 =?us-ascii?Q?Tu6GWhghRHJYYV1cx0iGaqOoESPPePV/6OjZLhmRQTDQocnGkWjel6c1rNFs?=
 =?us-ascii?Q?xFiAzZWtdal7kVK9pZgy0LC3AayzQ/KMIYk0SvJErSVZ/Zc3Y9SbWBD3VsqQ?=
 =?us-ascii?Q?UjbHjXv44K+gT+1CSsmQaVGtYcSGWNuyUezU5CN7we7T7hSsXndc/l2tv+dn?=
 =?us-ascii?Q?NUnh90aljKGcMCr0cp3oXULMdQ7X31jCzxwDZgqIUINqOpKiOhlHyB6i3hvJ?=
 =?us-ascii?Q?xuJEnOLx38VHAGpThwB32sX4mi+NwURWeEPI7yixwNKNynmQpiyqhLfxRaIk?=
 =?us-ascii?Q?49o3X91wGYz/8F4i/g7F/qan32HbFoUyr+KDX/GHiQ7k0sJp1o3kY5Q1fhLG?=
 =?us-ascii?Q?opyqBC/yNTcWmOV8t/xB/eEp5snDoBrwVLA3OGobC8nXKgSyxzV34y+cVFJK?=
 =?us-ascii?Q?NuEJUejVCeNESASyY4ccl7CUT7Di7dnhe+4TVxXcv6Voe4I95Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 11:00:59.6919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564b6802-d0d4-474f-d2df-08dcf808f8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

Keep the user queue fence signal and wait IOCTLs in the
kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.

v2(Christian):
  - Remove the userq specific config added for kernel queues fence init
    function.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 279dece6f6d7..bec53776fe5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.release = amdgpu_userq_fence_release,
 };
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
@@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
+#else
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	return 0;
+}
+#endif
 
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
@@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
+#else
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	return 0;
+}
+#endif
-- 
2.34.1

