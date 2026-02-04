Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F1E8B394
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E269810E619;
	Wed,  4 Feb 2026 03:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TU3N+S99";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A3010E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0x4iEY0sOwwhtJTtb394TnKbAvzluBJFLnyHOr2tRHRrnwTIRkDi37aFXYlXltjgMvLS3n+Jw9SMy4p259sx+bDcn3DZZBG0QboY5cDFhf66V4IrUsfoADnwQoVpP+12QY2voqVLVOMGE/UG9IBaGZDXGHJU0uec9qikcMNDQB8+pfsH8wWs0FfmDCiFWrwJC26DJOawaR2CLIm8MBB9W/6FrM1mnvYnsngg38iG5m5LMnWLt9UW8Io7ttKKZYYzT+g/NR2FjYK93BLhk7nbPpqv2CLGgWyNEkUl0epRSrccIliyPxchzUkzsRXSlbo8RytEzwISxbZTaVQU5b/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mOZZsQZHyO5+eky5sQZMv91bcmcV+LPbJFoDYhyCdI=;
 b=apv4XdMkmHzC58v55d6q01VG2CsU2zgf/cHAiziyKAP8HFnrDSuCGlZu9EydX4t7nesLJrjaZb1Mk8AdHWfA6wSXabtwJ+H0eyvbtWFWvYiY0PC8O2sWKmjBU4y/bu7K/nZhSqry1mQd581AJQtXVmgg0vEBcQt/u21brd3nCAEtN1jKd3PRUnp4uTeM8T8xVaU1p3xhBmgES9HQ1xN2U+HOexISXIXAYkuhnvP2A0UT3UwtfcgYXGx4P0VIQqMsjk2+doWyEbeOvV3mkIwZ2+MdY7fK/fkZIOGNF/wqNeSkfLpuNqKw3i6HdOqenXUlFP9f88GXeuKM3vriCReKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mOZZsQZHyO5+eky5sQZMv91bcmcV+LPbJFoDYhyCdI=;
 b=TU3N+S99fWRi/nUnMeHGYLnqFJ93BdxbYAv4XzLUoBKUebZyYAJLkDFW+phQfh6Uc+vHICCa43HDQ7rthceNXa/DuanV/sTuin5cmr900zH9QfBEX5JkKjT7cHX4r07u9E+ndohw0muPX356QuvZUpTIKZ8f/SXCS/AmyvKHjgY=
Received: from CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 03:07:03 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::50) by CH2PR17CA0030.outlook.office365.com
 (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:07:03 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:07:02 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 12/13] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Wed, 4 Feb 2026 03:06:19 +0000
Message-ID: <20260204030621.33369-12-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ab8796-5725-4dc0-958f-08de639a78f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1UDY2beRuI+1pwg/CFMFkCbt80idtvoI9wzCwfVOWp1OeuYHhHShkilj0fGl?=
 =?us-ascii?Q?95XXsZL9+6PThBZLTo3wT2L9s1xR2rG/EYZnMJVNzFP61Q6t+qSpUItEOcnq?=
 =?us-ascii?Q?0hGEyYRvS/y3rESCR1s92w5PUIkfT8OEh3Ou2XQ/6gcxNxvLeMJyezhH/6MW?=
 =?us-ascii?Q?eLgYqaTOhw3pL8hMGNDeIEzpV7kpgXMf0j/AHauGIpdUWy8SgDsRXhXSb0S9?=
 =?us-ascii?Q?lNNDErTJJXzDIbeBMftekf9alaPvQY5oGJKmimscbG4dZOFTGqaL5QPLPfO1?=
 =?us-ascii?Q?yu0/OIQKTDaaH4r3S4w1pxGSmLJFHEoKcjpk1dQ8V20Ce0X6oyd2VsN+DKdh?=
 =?us-ascii?Q?VcwkbHAIesNQePEU7X3OSyaVvtT6XKA2BDxnwZFgVQ/M9Gx48V6HDz/l0IHI?=
 =?us-ascii?Q?Nqen3K7sXhvroiwYkzhK7VTM9DmPgdMjoFa09e6ffY7rMkApwQJylujgEosH?=
 =?us-ascii?Q?bhdE8cz4V5BTq3zjvSnNPFO7I9mIFeyrj1GreeiGk7GLjVc0qNeM2hmJkRHD?=
 =?us-ascii?Q?JrLgBdWBiaabXQCc8s4gRujxoMGdkxRgIhR2wIMxkVzvf1c1DgEwQ/ctrTj3?=
 =?us-ascii?Q?E5qUaNwJ4RDHPx9t0CERcS4Egch0DGQk4QXPmtFzguDfDvBAx3Jc2QZ827g5?=
 =?us-ascii?Q?orr+3zt9xWqnIiV5EXqiQYK/W4xBqEacx07GouqF9CmT3gyLo2KOphGJDv0q?=
 =?us-ascii?Q?qbFI/KIPabmQjGBI+0zq5QegSyDJI3FD0iRrR7e0ZLrrSq1q2NCB/HiRKdvK?=
 =?us-ascii?Q?IBRxgCqLuP0T2/jcTbwP7HqJSTopi0qkG40W47yLkAt1sXq24MJhWtP/a/f4?=
 =?us-ascii?Q?yngsNKPiZQ+xP1dxCj30uWjdpL245pTQTguwWH51IWuS7ZsFnvDZ8eaoPHEh?=
 =?us-ascii?Q?azkYUzM5U6u94egJWwln1HYkSIohpqctsIBdEa0lH1kyBYMJwOJCZfC5++D2?=
 =?us-ascii?Q?S7LwCzPMy4VkAssoyD/zVsdi3QU8A6RnFRbn7cG7aL3Id0LIFbhteLNU1uWV?=
 =?us-ascii?Q?4vU7TKPmIr/NcXTqVSkYOmB705ANdiayXnMwT7v/iODstxzfqhiVHNhLLcuA?=
 =?us-ascii?Q?AprEJWRCvSDVEWPz1864KWiG+Kq0Z23SDXogoeq6wWk3kGjAjjDowgLJ0pOj?=
 =?us-ascii?Q?8MhEfwRE9YeaVZTLfPXvH+iX4cUmf2K3AxxbX52w9qAYZ8v0NpYuGiQxZNYo?=
 =?us-ascii?Q?3i1DvUUpnEAyY8V6P7+8TLeKC9S9iHggX7+GwnzcZGmUeEKjaJrN01B9Jr/g?=
 =?us-ascii?Q?he+AqXEaytHXkQhh+ZcyOL/mKU6hwH2SEMaW4F/qN0KglTgVHc2u/OUoFyJ0?=
 =?us-ascii?Q?Tntr35TFRNFFuJoGTJtehrBIxLfWrzPDCfZjR1FVljbusWXK6Tyx/b5F6TO0?=
 =?us-ascii?Q?Isb9tn5GubK2ZWttXZ8EMJ1y1bDmr6Sl99E9kHIZUrQVlecptUeUaWU0jfB7?=
 =?us-ascii?Q?cDd2eD6ZzBBXZ8JNwq84i4dsxWHB3jKLLYU3tovuS9o6Ka0Et3+ywlAYhh5F?=
 =?us-ascii?Q?UIe3LP8VdGQmcCiyGs/x8S1pdG4W/7ybIMIvK2JtkT2UHTzekLKrRlz+7mqs?=
 =?us-ascii?Q?2buqCdIeTmw6kg/M2uMHtHWWylFXp2VYp6zP7vJjS8pSCZJGBqPRFZ6e6b5j?=
 =?us-ascii?Q?R0tXK3LKNPAnZKga/27MVqJXWmMD/Oiy/Kny9ggfpLjY1FQyJZ6AVTpZ/40D?=
 =?us-ascii?Q?sI7Vhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n8NYZ7KEkxyvYBxKM04AmQwQxdXxxUEEtkMMA6PQ6oT3kq3f/nakckrjyi+IwrwndJNfctY+4qBwP4lWqgGh1eLhfjys73cHWEClmGy+uhOuRfMaiFx/j+M5KnnoffMOpae93R2mGxe2sejLKVr+PSAQpcu2ZD6P5uXXeuoEsPig5z7AWytgOrQY/T/P4ndqUoBVJVBOSA3TBzmcbKpRj16blpWfXI9yH4HaiACpiJ3ssze2Z65OJPXGSQwZp4l5ZG4hvrcHCrHr2I9cv6CI0hnHDizrDkp3wG1Ud23fDQl/uUI8uCrZi3XG2Oav+MBBNRYQqp3np8/3NMlDjPIk3vntSsm9tAAi4yTm2GTwY8qStWix3QhzV1OUcVg9ROckK9idzrhdgvq3iuwcGq/OexD4MhvqaVoXZwyclKvE5Ripotk+nYW892F2W13mbeyD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:07:03.7985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ab8796-5725-4dc0-958f-08de639a78f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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

Enable GFXOff for GC 11.5.4

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 79d132fc8ca9..8122a5cacf07 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -839,9 +839,28 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(11, 5, 4):
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
                break;
 	default:
-- 
2.43.0

