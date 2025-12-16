Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022D4D637B6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3570310E894;
	Tue, 16 Dec 2025 21:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCMYVUhv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB3E10E856
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1G7q6/visfuLR/OZ+dAfE7i+nYfTgeEvlv0mmPcnJ8DIA7HEOD1cupR0Aq62Jq6senDDxxXa0aCU5IKGBoY5DEDPJB9WZ6N4gD8r1LyVCijOX+7XIJsg4r1OFBzzT5kQrEaFP8mTnaFoZIzbJWUlPCLodOSm7fznbZ1P8OjH5GSv/+SLOEVePcCJBQoskjt68XXwIqmkdkUE4C8//4gNrG4J2Wu/CoPz9QUWOeBgfwOryWWXQY77oCPEDLowzb4HyWrWuVVJonOrddneOoImA3pYM+jjgw59STYFKDaT8PqcVknwCUwuftK5sCWMUkrFZ3HlTV76hXMoDEQHsr/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7oM7HqI0NxEFw5eggUBY4PQTOvTAXGyq1OAR1sim4=;
 b=iFWhXPJ2HDPDCK1H7iH0ZmXB0KrEwsjC9XZt2m1yA59J/k8E05OQz8/OIU2V1Ql6t9DcGhyj2xVfnMWv6sqrx1ZVjUbqS1lNCCJKGcIsFfhop4WWJ2tLG4kQEfzbaan7sKj6cQ2HCeumE4IONe3frTMT0gxUZQJOsEnkMS3KbQZNb38586t9plvW7mCKKA1zXr4z2jz2R6PdpoCId0A/pWByXc3fcFJnQebLbYTEEJI7m9XTerA0bwtUqEVrUYizjyQ2KRcB1tTdKqjQb/SQQXP+piexMA0oUCiM82o42KJGgrpgVOgNpVT2PZbg2dKTbACb71HxvfV2/KkfF/e75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7oM7HqI0NxEFw5eggUBY4PQTOvTAXGyq1OAR1sim4=;
 b=FCMYVUhvSZIdTuAK1LRphdJ6BBpWoRuoCRqfmmbtitrdeOygMIGq6bQEeDPA0ILPhNjXeRp6vrIsxLMeOVjQO4nFaMvnEkgrgGIaYIxGVJn9RBdeifZ44YNf6eS3O7YSnRZa1fBS3Sf0LgNInhuvpb8KcFZoNXZBv+GPDrdGaWE=
Received: from MN0P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::10)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:10 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::37) by MN0P223CA0023.outlook.office365.com
 (2603:10b6:208:52b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Cleanup gmc_v12_1 after 6.16 merge
Date: Tue, 16 Dec 2025 16:03:37 -0500
Message-ID: <20251216210349.1963466-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: ce76b088-1d38-4c41-17b3-08de3ce6a8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRxPwUVmPf5UcyjmgO4MT/f569lf7bJr2Yax6LQkFZHNkXzVr5c93ewDtrDb?=
 =?us-ascii?Q?+bOqCcUoRTWzN/K2XBeIS8yekDQpa4TuFIwow6YYGQAc4H4AlojhpDzR8rOx?=
 =?us-ascii?Q?oQA5RjAcLEYSylEZ8uHu3U0MJGxuqyRObBgKBSos0rPLLeaA5OVpwSHbDmwb?=
 =?us-ascii?Q?eDsWYEU5zucmPy4WPhLuCXBM4Zrt3p62vPonqQGy2+NkskkyVvrrfvvParhl?=
 =?us-ascii?Q?6xgkHirlzXIT15xflil8HHet2KDxqSLAvB4bQ061FEqCA/d3H/p7tJmAtLpm?=
 =?us-ascii?Q?32R/1Umu8+63lijl/FW1Kn6WZOdg4piyOtHqHCpatZo48DKrMtiG7GXph18z?=
 =?us-ascii?Q?q+8E2vicm/5Zjx3b5MAfMuB4ICCL4RkGPqpndHo3EoDaRkC40tlIGK5rpS4k?=
 =?us-ascii?Q?k4QvtpHV7f/OrAdekYHw+0NlpUJewTLzZrD1aCblyyA2BWUgni+dsSDoAdny?=
 =?us-ascii?Q?/Xbpv4n+WwM3nefSIwtzb8bJAQeC0AAnNzXaov1Cr7GhzvVLHf9ShlhlbCjQ?=
 =?us-ascii?Q?sj9H1lDX5QlwJftbS73C67B62AY527VwMGYv0IKWi/KwQJGdZLIfC5gnBuf5?=
 =?us-ascii?Q?WEYfLnJ353EeZHm5/LsZbFFgm0VdqxZMG3jzMpMBoMorYXPPpmYGq1h04VKj?=
 =?us-ascii?Q?0C8kg6xyRKAf+Ki+SGVyjYCYhTO3/MkrktaPd5T7Lv7KfZlWPfFrdTP7SMpI?=
 =?us-ascii?Q?fUey9O8xCMZSz5vPaFak9YVS5gGUG3uEEbw1w8eb4pigT7hsGE2WMLbJEbyb?=
 =?us-ascii?Q?8CwLljIxXAwsUrb6irjTT5jbCPl1HeNTljx0WD9hpUTzWSXheb5nnDL4nKEp?=
 =?us-ascii?Q?pjVLg70GC17vSVcGG4ARIiyQmlHpK2gerTQxEp8J0IMin7TmAxeh5VQEAqiP?=
 =?us-ascii?Q?YHHiaN1Grv8XnW6TYCRfuZhBynNK1zwZvJ5V2WogLFOFM3DT0dMxq8tsrpqh?=
 =?us-ascii?Q?RQioqsU6S3YDcD0mQEmZKjoCu1go72G2CwcVF9pDPnmzozQa8e15RMQf47vG?=
 =?us-ascii?Q?KsRsfm4G+13QaHZK/OnN/CpeG/mX/eJr1+Wadch2I19wZQOyeWLWOa+4h675?=
 =?us-ascii?Q?lubCGhmNE8dHjYwGQZ2OQhqIRjkoQqk4XAXy4gA3aFzFECnd2V0Gd/FdcUxX?=
 =?us-ascii?Q?bwbF5gRrPT+juWJJUMAsDsZBVvLMRXI7I0AZX7i7qQ7VoaeUco4vRbhuCBqR?=
 =?us-ascii?Q?ejKln340VfyqaadqpfbfzXAV8+VJRlYfLl2TE9SNv0gY9uTfB86pS+JSdGKM?=
 =?us-ascii?Q?/rivZze8hjCR5QSCVxk6qsStT51uJde19DqdhhCYccASpVjwJQYKtF5OuEiU?=
 =?us-ascii?Q?9dRNGERifejucJ35cn3oAjtVeh1k6Yl2gzTLX/GqldKjPwFBeX7jtbv9GFMb?=
 =?us-ascii?Q?CHoYS0jjmNIOxSnbOVXWmwmlADm3ai9qhwpqbaV/AoRUecsrfad0TVqiwX9M?=
 =?us-ascii?Q?i9fyRWYCAsbqN8QaiuKTn+FeU3FBr3ZP0lUqQ8oEBQLLeksdgdKRzhkJq/tW?=
 =?us-ascii?Q?B7cThNClj5vUIOLu7s52FuPTR2t/+6Wg0OpkR+7/t6moT/EUs8EIRBG1bZ9Y?=
 =?us-ascii?Q?nKGNNAIxll11Ld2buRc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:10.5372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce76b088-1d38-4c41-17b3-08de3ce6a8d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
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

From: Mukul Joshi <mukul.joshi@amd.com>

After the 6.16 merge, some changes not applicable to GFX 12.1 were
added in the gmc_v12_1_get_vm_pte function. Additionally, add the
case for MTYPE RW for GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 3c6b6c6f0cfc6..d32e88cace6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -562,28 +562,14 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 	default:
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
 		break;
+	case AMDGPU_VM_MTYPE_RW:
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_RW);
+		break;
 	case AMDGPU_VM_MTYPE_UC:
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 		break;
 	}
 
-	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
-		*flags |= AMDGPU_PTE_NOALLOC;
-	else
-		*flags &= ~AMDGPU_PTE_NOALLOC;
-
-	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
-		*flags |= AMDGPU_PTE_SNOOPED;
-		*flags |= AMDGPU_PTE_SYSTEM;
-		*flags |= AMDGPU_PTE_IS_PTE;
-		*flags &= ~AMDGPU_PTE_VALID;
-	}
-
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
-
 	if ((*flags & AMDGPU_PTE_VALID) && bo)
 		gmc_v12_1_get_coherence_flags(adev, bo, flags);
 }
-- 
2.52.0

