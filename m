Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE90D374AD
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6C210EBC5;
	Fri,  5 Dec 2025 21:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kfqr2pEV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F3C10EBC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abvQKqcfkU17zACHIeR95470tWvVjX4oqqI+L5tI5I+QETtfQIaCSezXCqjkH5CKTo6aMI+mBEjeArP9sqyeahcb1NcIilE2eqNyAP8wjaX+WBJWiO3ENJ530LXnm2UvnE6fV5J5Bvoegj+I5puznXglsh7Jb0PQkxug4pl4Glsl6Rr0qZP0Pez9JbLOigO1FVB9iiOqakyvywk3OGm/iTN6nSnvZqNmfYGFJMfGq2P2sBttvehNxFUBbqXhmnyhXL2VwGRSY0URXS9GnmDnyE6sjH4bzG/oKdtKcwHkOPG4I2ByNXatmavSQlyZU+1y/gmbchc+/puy5/BuC+Fo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djayriVqp72n8jQmwcURfKXWuxD5zZgIA/pv/NNugsM=;
 b=a55r3MXro0wJJB9rcAvAriUvnUEcD5nwBtFJ8j0jVWlVpdrxUzw+L9K3Vg+mB21gb2zaOMy936LfyMGXYB+ZHJJB2dtiiQMLdb7MCBFAQ3luZdJn47oEfHlGURQNp4gR/ATC3v3hQYq6rchiExzRQEtU5n64tZHCgcRgKL+YABg/c3axp7+4ANSxP8QXcOEd7fKrJ0BuIBF76eKN/W+goFmwnryz2D+IQ/Poo30n886K8na03Wdv1HFW1fNNm02npGxrhxIqGHdtbumi0qBKxT7G9fXuEpVBWDtFJaED0RxzSpYeel2V9t531NFoHTjtMiRTH9+TXWHaWZQNLYJJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djayriVqp72n8jQmwcURfKXWuxD5zZgIA/pv/NNugsM=;
 b=Kfqr2pEV64q7j2rg83elBy18TPKYopaU3u7ifwI4kuApUB+nslrs1CYTDqHKUQEjjUeGg0olrhhMEROd5k9DeKq9EoCu10BatqvqVcYQDLKN3w6ADJELOhIk2h9ehcD2Nageh+X6LmPoVuYvQ7VLnloVxyVRchbx6u6TU02OhoE=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 21:49:47 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::f3) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:47 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Export gfx_v12_1_xcp_func
Date: Fri, 5 Dec 2025 16:49:22 -0500
Message-ID: <20251205214926.146844-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecbc8f6-0b55-4b73-d4fc-08de344835c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jJSd1jSmwX56X0hYs0/DHFFosXSQN4UJ6t/HfAj+xetuDkclV+v42om2edPm?=
 =?us-ascii?Q?rVXKYzoe/a2RUPZYmf/k8HCJ4VCIUWzfUoq0dzELreXPbW6QqPMleQUuhmDP?=
 =?us-ascii?Q?oBUyG0PzsEuh2QcvqUKODXzRiodsmzdl1vH/6Y3A5rGDDTk/EgTq4kxgyAll?=
 =?us-ascii?Q?Y9wylP6Et9AbT2YrUSc9b20cp+Z5J4qQxOkuLynnCGTU6KAYV6oTbHGHe6E0?=
 =?us-ascii?Q?RUYTjNij7LoZh1i90GU1kCu9klkLnAOlkBFDS4+sh6yXEWAQz8oFPSU+PEOy?=
 =?us-ascii?Q?qDePAtmTeLCepWN29yRRVzr8j5i5LG811AK7UKyq3UIdjF9M2P220htfvKWy?=
 =?us-ascii?Q?6BLOC/FGWvhF1vx4JRMYEMvLL+SMRDF4L3LmNotiziI+u3pplx4PEv3DZ2C5?=
 =?us-ascii?Q?wEHl3CCLCh4deO8UXfXDYVdYErTyjdTeG6ABiD3shrzxuM9GMsgRsrKVH3D0?=
 =?us-ascii?Q?1sdiFOMz8Z9XziZpbXIXwQgd+jz9QP/1iiVX0SmJRT5Amxi04FH/XXDhGHMI?=
 =?us-ascii?Q?ChzLIA136/QId1bF1DeoNaL+ltKUbV62fyfmmIGgpdjmyE2yzKUxVALxWX8i?=
 =?us-ascii?Q?yajl+OlHdEQk2eXy7uheUvM4yC+fX8S1n+JAB0Q5tZIrwJ8iq7oJeQEce+aC?=
 =?us-ascii?Q?edQyXYlJxhedZsM2h1m61V8GxEtUwgB1Pbc4I+zGotz7zeiJoXMe78SvLVZw?=
 =?us-ascii?Q?psCWuL6uljtqKqEJPX5DPkDzCGAn4OcxgzklQ3aGwLoyiNSVPhYzgZIC4xpd?=
 =?us-ascii?Q?Nqxr+eidPNfVoOhyAl5LAZmmA24mPeYs8e96PAui8i8EGiHHKVnHhb06gViU?=
 =?us-ascii?Q?sEuL2wy/zZpmS3dRbjuBACEe3k/CCcVH7byDQ7cti2S/aV9mQncZk4DvDGbh?=
 =?us-ascii?Q?DDrXmgVhTruo79VyHpJW3QWUNRpW3ONwemJcgl9867IYmWLu5fD/4mR86ySz?=
 =?us-ascii?Q?rtz3uSnkrV73EaY19hc+qv63trzK7hRMvLvBXGBwyxidSmdCj0edgiDm9jFr?=
 =?us-ascii?Q?E3zq7mAub8HBCrOq7VUKQNAlwJ0h4HPaGjPVM68JI9//dERD5eCPutdtJDaw?=
 =?us-ascii?Q?UGMubnD2nMI4JTV9944rOhhbt28QmXQOSYl+9nO6YJl1XJzJxHc2dNlosc4W?=
 =?us-ascii?Q?QPuhHRGcTJAIB+sTG/h6H+veeAQPmAmiYEv1Kg8Vhh78+J8/0FhnDskAjo+x?=
 =?us-ascii?Q?GLGiAlk7Btc8ko8rhKUQzsMTwY4ZXj7+S9jAZDfqOQ5s/TaVVJEsZEHHNk4L?=
 =?us-ascii?Q?LAzoPmHVEP9fCbfl62uw5EMLhXjWQEHCAzxivrgpwbCe4xLKpk/wJJor6ozC?=
 =?us-ascii?Q?DG9kQnzZbf+B3Tjimc4vM0ymzBxtUZqTKSftIu3xyYKxpm1GK8BfbPlPw7Rh?=
 =?us-ascii?Q?qvsU3E2iFGW4amd+uCSuNIHsWHRqAqkrY3aRLPI+wblNP7HXLC9Z35WNjdVQ?=
 =?us-ascii?Q?xYn2E1rx84ObQ/h1LCdmww5l27p3JR5uBfRtWh9VBUCrkV/lbjLHOCmfxx1Z?=
 =?us-ascii?Q?Br+ltofNDxtt6SA6/fxtZT21BBW04FLBGVvlB9hTmm+5dKk5Z3rrNQzFd6SG?=
 =?us-ascii?Q?ItrJDA8P9VFIYPnmBKM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:47.6579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecbc8f6-0b55-4b73-d4fc-08de344835c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To be used by soc v1_0 xcp manager

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.h b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.h
index 8e18e583eff73..684d93a1e2f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.h
@@ -26,4 +26,6 @@
 
 extern const struct amdgpu_ip_block_version gfx_v12_1_ip_block;
 
+extern struct amdgpu_xcp_ip_funcs gfx_v12_1_xcp_funcs;
+
 #endif
-- 
2.51.1

