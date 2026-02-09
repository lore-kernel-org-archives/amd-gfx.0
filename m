Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE17FEF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5AA10E2B5;
	Mon,  9 Feb 2026 04:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lHSsO9Ci";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120F610E2B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVPNPLnMF+FE1CrgcBH6jAhJCjHrVAuVamEXQ5lojIS58n9iHeZxCrVU0ZegRBCMXK7CwhyQYo1grekdRzdpscoVlvi0ikw14RRubGrg18VXB8XR3VL60GN2aq86mWqHLdUdxCeMK+1tbM8Ffod7wrIhfCsTMameqBOD2Qi8MSdznbV3D26jhBfjFvs7d6QHqkZ9EhHEbhF5AJq0QJexB3Q2ZtZ6z2mlTuojc2VLG1wcAvJ+Cuk9DqxlFfq126N6z6zzRqKoijfki9Ns2JD58Z9ke+ZoYEXQHVSVKVRLDoF+vf50bgJ04qAQD+LjZvDnzyZKSTZR1m3zA5SxsHwpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=Rq/mWjYPWgWS+TONVoLemWrQRULbrVF36aBK1Df/dfRP1B7oICiTjeOTo5Ti37Svni9J2+ROlZbx9A0MGCD6v57AnG4/ET/67off7mcRXFMGm09BQ9sYbz8DSDq2EdmkXv2EkukRlkG/JR0Q7zcysQvW2vphfRmvANjHF3AXArzx8mYsjfoNQ3ISiK3AyaZILR6zOiHlyhxcYD8aEtKQLCLK3cdC2s25HPjSHXSksd/y824S+toagMkvVj/zu1pxur+MG0988WmQ6nDHEuCBpkAW4bN7xLWEQIh7ucwpNQyD/kgDjOLst+HU4edy8TL/nBtAsrumSSPUHH+nH9uRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=lHSsO9CilNZnnUle9w+DVxFFqfQRTQH+76QQJZhJ489W/D4BqEdDyfsk13fkdcxSRjACAIAJdBTAPe+sUmaGHYXt/SdRa6sRULCJpIeJtR99+rBJeejZmpIF1hqZnp5AZmgQnolqtKaoxUnD8b7fSFaUpiiQNQh1PLMxr7Eib10=
Received: from CH5PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610:1f0::23)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 04:57:27 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7f) by CH5PR05CA0011.outlook.office365.com
 (2603:10b6:610:1f0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Mon,
 9 Feb 2026 04:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:27 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:25 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Mon, 9 Feb 2026 04:56:48 +0000
Message-ID: <20260209045649.59979-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc02ce8-dbc1-49e8-1e65-08de6797b906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7M7M8CsHyQeLZghdkKIg8UAy5J0xXH/rhTVbuKI63UYIL8vReZu7tSJF6yLC?=
 =?us-ascii?Q?Qgkw6K1OuxdDfthPeIKiZNuuH+wW7iFPRFXPSnDgvpPQ3N1wtiNLRmcKycFR?=
 =?us-ascii?Q?hd4sxvYqF9/JYcmGnZ0VSAjXAqQxQFAyL9fEB5U9pGkJDLQYFIQWaamiR41q?=
 =?us-ascii?Q?iT+/VltxGlHjFSRKnk+/7W9243aqZ8WiMJ87Jg3IRT5OBhNwomjXL5quihDu?=
 =?us-ascii?Q?xMFsuAuai+yCyyuTM1Yq39loIB1Bg082zamS1kZiB0WOvmUJgc0c8q/GRJut?=
 =?us-ascii?Q?SiBQacN4JkB80tHkVWu10hKGGqdC8T2oGPfDAeux8J2QZV4kVDpvaAR03Q9L?=
 =?us-ascii?Q?V+G1O3bZ8WpRbNTuSHxq2LWuR3bB1FN8mxQiZwiM4b54Jy1olJ6VW1Aq+KK2?=
 =?us-ascii?Q?8JrO5L0W2mqX9n9tkKAyyLUgaoqGHYIHSsuqFKn7sJ0SdyBR2HCy6XHmHTJI?=
 =?us-ascii?Q?tuXQyHSQGZWim490FaQMS6x3soHaQneCCninARzmKOTuIqxZsMWvmTJygLEZ?=
 =?us-ascii?Q?w0VYs6m+dxipudUrAVutBFE0McvrzHXaGrWUcK25hsZrqpSdXU5F1XpCyMcr?=
 =?us-ascii?Q?qqEtB3yvfdWjuQMYKqKuxx5SIlQk9hLmpzzXn3llbO2hApNL9OMFwU+p2GnA?=
 =?us-ascii?Q?9KapFEM0hCHir8X9zE3kMijhzfh50L3ReCPQiEqVsa2ZfKvNfBxdt2I4t+Jg?=
 =?us-ascii?Q?gkaz/ci+b7nvXaYKteWJFiHfr5IIwT+ndjeas8BHu+luH3QHNbxaEzNkh4oc?=
 =?us-ascii?Q?rqANr1XM9oY3F4QF/IyqSqfIXOf5bSBYJwwyMUJp9m/0qsBgEbgZYx/I1Kof?=
 =?us-ascii?Q?zM9X/T9dEze9oTp0yQj+tn9ZDTaf741l2OzlQ75K1ygiQH8jEc+t1xlHUorc?=
 =?us-ascii?Q?rLFZqJxh/kXn0LpwvOTFeJ0etc91F1vkqJBnibmqSXecmQAZzvoKpOJDTDvn?=
 =?us-ascii?Q?Q951dq5GbqFkAry6A9Sb+zN7BIG+h2j261BGS93elYEyhWyFrPJYkle+l8AG?=
 =?us-ascii?Q?KR3iXGr7zdJgpEqgR4sJA+NK63zKZyGNg6o0aigpCYL7m37E7eMgJVfxICGf?=
 =?us-ascii?Q?gGJE4R78CPyhLGeg57G2Q2h7lyqMtCfSh9f9hIjG38imGbTMgMIWxYg1c0Lo?=
 =?us-ascii?Q?bnTc9NkknANdzxEqyt+cIWiL0w5XA1I54jztWjAmfNNLRt+E3yFMjKImaBhH?=
 =?us-ascii?Q?RQjvwiH/LpMYbi0GZRgEg5crdpzqZLzC0+xZd/B0sWlomvs1NDUuEzTgt+2e?=
 =?us-ascii?Q?cOO8K/6gcADIHTL58slQMH/hEL1PAOE52V/lkKkl9WK4LXp6NHEwy7M5MLP1?=
 =?us-ascii?Q?b/x80oXnR6QN/NtWzQaU7hm7WWoz4dRg+1HKe5ztUmzbPzHJFqKGaXWdnPoH?=
 =?us-ascii?Q?dRsm52nChcM6PKIC/Sc4wgrDPeTCak4/0ZEOrbm3+yd2BUZ0N0Xyuase5THV?=
 =?us-ascii?Q?SGwzy17YoT90TF14jbpfNx8D0dvBDDAm2pVctEMEfGAG3jhMj9rYdFl4lenl?=
 =?us-ascii?Q?lAN9pagsgAwISiac0bWm9OElsBYOsnKMjsKpoVTal42F7GizbKWnDkACPEGS?=
 =?us-ascii?Q?4uDuZAiw1Ilz9MlhsygQoPZX7IMNG/D0n6ta1Cn8FsTqGYcNBGjYO+fjJLHz?=
 =?us-ascii?Q?h4qVXowjFyHQ+aXNtiiMoMRFxv5fx3BXG8G9XRloMhnP5sv5TMKXhJrgyj0L?=
 =?us-ascii?Q?aQWvNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VSLJ67t6w6Pz98iON46CLZ6Ohjx4RsVqI1lascqvgtqnO5XBnpEYYDSSz9NqjLp5zFyvrvdEPIbidj5q6S0EwU0cVWSPOhKE2tYmuM3/HzxWkrXAhuVG0eeDvV5G9FPfj/jvn1WN/YS46gYWDOGT8BegItA7JV4eWM8HDngp1D8sBiGDONL0zBjCQ90rKSr9dGmFvU9ySJcPiOMCRx3c8BBAIWX0mc/E/vzYSbYJsXZFKrgFe3Z7uHzrmrMMC3q+VW9nNJ7Ei3lKEejz4Y7npfvM/DIQ+egvMQmeDgm+zmApCbcBUQTl9A9m0fo1YK/zwzowbTTJfIVNKcT7dr8B9+pfYqU7a/H5mVCCiaXjmSLDyZvwBtUOS1S6FVcxOhxykDKZabAZIDJzXgdHZ23nyjogejWywpGriOx2Z25wofiMNAzNZ1mcdth/9Ce1A5lX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:27.4576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc02ce8-dbc1-49e8-1e65-08de6797b906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
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

