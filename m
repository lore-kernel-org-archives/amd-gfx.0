Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E6BEE208F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3814210E749;
	Fri,  6 Feb 2026 11:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A8VAHI2w";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F5510E748
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWWw8jJAvNfnaO3iMly9KLic0oW/CdnnETkdu1dMvD1hsRSGep08tKl9di7PGmjUDXtt4mrC+urCJNPkLVWuRjBMHdcAiDs3B1BSP5jWMMp/aXPyEkP32VEwycEpI2MpPvzUu1P9rXlfRkZoaSeUnPOthQKG42KZdoRzaQgWoXPK53a6MsY1Ecx9oTQpDQlBj+X1crr3qmFaI5hR/cCvYCmdOgBkuomxqLa4UJu7oA3M8ce55UCxC/opMRgZj+Qm15moxl61oN52fv18z3zpdLc/VBm0vLWqRGOw9guh8W53xNSGyHzjWq2U1oC+VNCj1dK293Qp/+owAc5PW39oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=oBN5jWW8Icc+AwQPZ2eb2eQVo9AV9c+I85SSbFrdsTm8VqxqqnnedxMlDanqDJYRL6xbb54UnH8VhtEEXof/oR6WiBsx8qJapFfJRgzLyZwzhmHksyTPFO52/7zpm9wcB/JuVylXkcx5Fssn08us/HQm5+GOA2c51kctr4pfiDeaip+AUmfW7zmlWjzhrJ9JNz5LJleZjsJZeMTwa3zuj7NswGGpeRUxXsSZu7pZpzN4RqUeOGB0VqkYBUQCrMUFfnXWjEzkhdk6C3FhlV5FN3Anj2niE4EIqCsK8P99WW3vUYCMCYuS4ZPKWH6/hfosGIpGrzqbw+YOiJ6K+tKgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=A8VAHI2wvARo+aeKJwo0Fan2KvVYZFF+ZKnUl7bgDG84ZsUThNKzxSEeE7b533BCotynvnV5UP2vAWtRTYta+vzBdaoRahaMcmLUdxm1E7Kn3UNy75+9i+7MqnOPDoz00Scs6FWORVB1hdiHkmfUxOVe3mvzNS/mo87Qe4OlT8g=
Received: from MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 11:25:23 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::d3) by MN2PR14CA0004.outlook.office365.com
 (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:23 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:20 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v3 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Fri, 6 Feb 2026 11:24:47 +0000
Message-ID: <20260206112449.45381-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 7015ae92-ced4-46f5-a0fe-08de65726b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ej2xw64/lvwJXMYwCBBQEBbvnJSh9JcI+VhmmxJdct+oF+wYm3vY64hUidan?=
 =?us-ascii?Q?Dr6ge376J4dSLifT8dOZ3YGhSQ5Ah6kuMRZa09YaEueIHkt7yFgjUh9zzSCT?=
 =?us-ascii?Q?obmHxtTmI6n+891t16mZL3fbXJ/QWGAY5e5cg2U0mYZEL0pGZA33KyiWW5nZ?=
 =?us-ascii?Q?BsMH6rIBSstJDuHc9HBzLGiJht/6x/bD/XCrsvXPbyJs0uQJ7S2GM18Ghy+h?=
 =?us-ascii?Q?NVD6IdW4vN58sMzbLCWABiObbycefj/16ROa9QpV1Wy15Jx2lKHtEU1CRXuE?=
 =?us-ascii?Q?CFK5PyIdhpzCkSn2FDZ1fEh+p3sk2+wDuTcakgXoGDh4KdsJvxd4rFXLZPrw?=
 =?us-ascii?Q?ZYnuYMiHVHA0JA3i9JIgaQ1jQHTQW0Ay4kQfBSlP8iT5oi1liFQNcumOxext?=
 =?us-ascii?Q?Ga5BlDFq/hor7IhqEK+IQQNaRv3NituUDss5GXYreBDjPenUguhqcuz451E7?=
 =?us-ascii?Q?vAxcZINAZaJpGzMKzbNwwDYI04fPyCG9gzz+/x5lCW/kSXAGhojnu1QhQDL2?=
 =?us-ascii?Q?AvDZ+8a2NXq9/YDZkUjmDyX2geJESkurCfbxBhnLeLbGJ3ESiE6aaMaFr9jP?=
 =?us-ascii?Q?Vq9pvVNXq2dtD4vxBVJQbi56MrFqwzuHywHBY4kUK/L7aVf35KFpiYhizXuS?=
 =?us-ascii?Q?kPHPxGBUxgorYdoNqngBRAa2bFv6HeDa1vWQs9j9FmR9vF3GaTa0TwBVaZpG?=
 =?us-ascii?Q?zaPmoq4NLGgJTIbevDSoQmKd9tRlNTI+KStuMuzyQq9BmEN2PQWtYMrKsJY1?=
 =?us-ascii?Q?NyDdnOAsdn4Q8MHlMoY8NKGh3VHwuo3gMvQsXQ+cXyordwHWy7t7BtOjfdNQ?=
 =?us-ascii?Q?1nJz+pIqiIAr1r3Q8rT/ZpyIJvLU3yPnaf/ehLL8ATEjJ21RIJbV0DpAE1Gt?=
 =?us-ascii?Q?OHrPNRjwDuxxiNnQaA+rAMfaXRzTmXsCt8a4exjBmGtuD23vH224k4cAopSI?=
 =?us-ascii?Q?VnovQ6vlYi+ynUHz18XWiKD+thvgek7c9CRrcE2N5YDj0JfONRxNW9dCroWA?=
 =?us-ascii?Q?5+3IbODr7Ln6yv3s8SdSKAMPTP+6iu+0BOZzC3XaCgTMbKJ9C3vqmc9394rl?=
 =?us-ascii?Q?dIGBJOfDKN3khccCN9VlFeKpci4hzTSlN7dezwMHAzwHTVkgR0NnLLie/48f?=
 =?us-ascii?Q?xWR7JvjLJb/fOPXWXXf2AdFLpjMqnrogRDNB37KnO/C+DcYucbdj8nlLk5e5?=
 =?us-ascii?Q?1WvCkxTf04bWI+aoUodQeNPQyBa5mMDtShKWWYcbyDqRxCxFu/75kkmNIT50?=
 =?us-ascii?Q?qKiy25q207xXcD1oOBWVeO5JndG7AEw2+8Er5P5gSHkq2a0zZLMzKFUlBJSH?=
 =?us-ascii?Q?nTjAb661uUJ0uSGHgEx1cpp3f2wl/3shTE1/of+t4nvHDZ4geEW0qNOZaDyQ?=
 =?us-ascii?Q?x6VAaCOq+/0EtxqA+9m++F+3gNTMax6xGIFylZNbMJ1AS0IeIhiFFfP8S9B6?=
 =?us-ascii?Q?P9LQ3aoN2/SyrKiZQZnq6PedQqGJcCUtg7dQQ+TR75ZxSLk3PZ2djGLfJ3++?=
 =?us-ascii?Q?6Hd3pVFoNt0iFFJNmtLKnVoRh5LhwSawRQsi7wPwnTRYNIn3uM3wQYY2owkH?=
 =?us-ascii?Q?1bSgwYjJ2LQPqhEfXf3c5gWGHF27W6iar2+zIoKvJh9IYF5eidQzjGIxbGI1?=
 =?us-ascii?Q?PPWcKEluRZFkgFWVsLTZiScdex1LNhlKUlA3M5kuAX/6WeU1RyqtfVVJkk0B?=
 =?us-ascii?Q?6HlzmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MP83eal/ZFsxYQYECvqTkgLKf0gZeRfRD3bAAOT+Y4U6JuDwUUIqEPkIvXHkySqeWHf7+HgaNDGDFc24UgFSesxpZ1KITMG/51fevE2wfhyhuY6OfHmYZ7YN7ud7Qkofen8zbKFFCaeCoLCTlHXd0dKRzvlnxpGMqAT9n44xObSr1G5307s+URkfqlpAskiA19cyRREb3tCRJSKZ0BM8JtInwScMwJmpYMJzrX2l5NySZx8DK4CMW3zsrlkSo/XWR5j69XZvEVTO7byHx0BQuUQ7WuT/aOyjz861vB8Ik30+ZzNVttCWH0vaWCvYmK9GlY3D7NPFnhK2Q6q5ltw7K2wklQ12Zge7fSA0nYY7zS7G7En7dFy5A/Jgzm13NQcN4vlAzD3BQtWVcJo/3zKzXzwe9zn/o8LfmMcuEyEdVybCHPIVGRqGNKPFCDsfi4oD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:23.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7015ae92-ced4-46f5-a0fe-08de65726b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

