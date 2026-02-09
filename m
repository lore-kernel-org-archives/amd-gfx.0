Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454CFE81BBE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CAF10E3E6;
	Mon,  9 Feb 2026 13:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKJ68UgD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1015010E3E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ttdu4HcIVtB5XaTRBPEeZMzVhSKvPo5vqx0EjI+yU+ZINK9XG2o7nzYaDzu7PFoyCCyOijdAFRFcyjpLGD5ivx2Om0/gt79/UQ0IFSY90X1q6eRI31ZnZlzoGIXsynJFMOHDuRq9b9yPNmZ45toBdpTNMTtse5dQ4Wkjx/0Jo2QBEELeUXmMcODsWHDi97F4G7aYfrbB7dILZl6PVxfTWHXE7CSGpmUHt1z+SAewdyFaIXYfFoK/sxF+Q2UwSm9Ox2pGVke+Xe3H7LizUO2rqfpCDV5fxGedv/IUgeEcwvOF5z+Sm9HfRUJnauXY+/U3F6k8sLLYkBX4HHyB/mwJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=jM8SH8BLiMtRoGpJZqFSMXZuDrO9PRen4i6K+ySF3XaQ8HyZK7ASvRUnEsga8hXcD74FMlpZNM46p20bhubyYIYEDOySnwYCnLcHBLcrQqDpG7gHFoA3iq9CIgS3mwl1UEZy0ynSHo+ZO8z/G13qMvypDhrKiEgqfVjPAgTD7plpzaY8d3g93AW3Eb89hw1QkyWOUwA9gpHJhmqGoYxEXg1texPZzwQB7P7xPOjZvP0H/PVYREWPXw5SG/ri7L9kolI4x62+H91GdkErLkYY/LgboMXNtdQ2hCTw5p4hlE+Bt6i4YD/RSgUYeEMzjgarUwfpugmS9261mUSF8dVH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=GKJ68UgD8bz8Yv6PoodXRlE3AtNny2PlvJYhxDntkn4dlthKPOO3ZPbhIq6YafgFva4LiHkCC+DMyGF5M5kBziZBnDxrnfWhCEJziv19mIPgO3568JZ02PAbOS1vjG3p7qnyfrZSxpNceqW27x3un/92i3iQ5Zsr9pAtJJfgof4=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 13:04:57 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d8) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:57 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:55 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Mon, 9 Feb 2026 13:04:12 +0000
Message-ID: <20260209130413.118291-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: d13010d9-90f4-4d5e-07c2-08de67dbd336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZVLeQ82B/uJp6WOCxYuyQ7t6DwvkGeWDfJWdam+eta+h8zu4Q+8ArHuBgbr2?=
 =?us-ascii?Q?c5xtkUqmwYr5DR3CmYuBNk2pjV/mB9wK/Q0YQMSTUhkKW98/MxrYo/oruw3b?=
 =?us-ascii?Q?h32Z5Df8qFW7uVi7iWnTMhUtBIwicD6QvMTfaeDizxt2VkYVxfZ0pJN3RSLJ?=
 =?us-ascii?Q?7y0CyTswpy5yKZFbbpGSYwjW9tYEkDz8lbjjhupirtTbT22g3e4hJPTGVd4u?=
 =?us-ascii?Q?5vMNepJGzo7H67Tbyw4+QZ2CS8TjaMlImRTD9/P7w84adEaN4AmfqMNWRIAV?=
 =?us-ascii?Q?xqnUjInbvstZVdPuAJkE63p9ULd0xzqQnXp3ovqUHVGDM8lETAhUm6kMIVAe?=
 =?us-ascii?Q?kN/GzYoBQNjClAzo9OBzTa3kByV8pmLgKD7stUdjXjCqF/2p31uTx4BLUPwk?=
 =?us-ascii?Q?M13dcorDufhzMf5sW63BTwjkb+DgxR6M+hVJ0RdTl29EdXN8SZQsPioBsX44?=
 =?us-ascii?Q?4aktWav9C0YFcpjF7xRaOU1eAS9XL8ihOTGMQo05dCJQQOQNgjlUg2Q2jWl5?=
 =?us-ascii?Q?G9ZoKJkLWz7WSZPDZx932xrHHXWejnWUeC4vFCAPkv3eGQdkDMhlzV0LhtMs?=
 =?us-ascii?Q?R9MKHr6TuL7pRyROe1fHZzrPghtvcrT641v68F9+csS7/foVtSKc9H+KSYMh?=
 =?us-ascii?Q?kpaFpDO4dA0cCdFNXGfDAx0d3PWS/rJnh4Xy3gzP9sv5qZ1cOCuLJpnCiBgn?=
 =?us-ascii?Q?6xInC1YGxG78DxPeVGxaNmOEjKuWbmjhJDQ5/iW0Hx+g6i+aRvbeXgWndQLi?=
 =?us-ascii?Q?ajbPQyrLGVO7tO9DzecyyJWqIaQ8j1iG3dcXi3YjSDiVY9/I/6Qy/fwzBsXZ?=
 =?us-ascii?Q?UMtk1JVQGwEx6Wb2JXfEpQXqE/Tr7AymXIyig2d/o+E5N4a2RIjz5MHfePDA?=
 =?us-ascii?Q?XM2HXtmBSrHu93ZDLwcPcsqnDlzdMocLJv1FRDF5+5D2RAXc//S9Pniv7nFZ?=
 =?us-ascii?Q?iima3FiyJGG9vguT4+/8APDC++fxiNLeD+2JxpyjL1MDSCk4HzDS/SWjqEJb?=
 =?us-ascii?Q?tfAtjU/jbbH4+QgIa8H9e7KrUEm/y/T8KOJ/E681nHzOBBNhQ4/njaAtxAnJ?=
 =?us-ascii?Q?5ycIpQPtkDgVI3NfnQN44CigxY7R6kSyffYyTnlDgxkDQSSgsgWt/SIfO6kc?=
 =?us-ascii?Q?hjIS6kSJICNSRqU6S9lFIdk0IM/YQx5+J/S611nRwOuOcMO0n4CpN4rTaB8F?=
 =?us-ascii?Q?3Me3xz7c1FmbhH1LF1fWrKfl4U/6WqX8llDMfxBWmCXZi3YS7BoKXTjFCTNa?=
 =?us-ascii?Q?HyfzJEOepHvqXEZp4EDSvvMrARGe19b2UuP3skn/vgbYsr3nI1OwmEQrHFic?=
 =?us-ascii?Q?nK8H+9ETJeYqYVJsGhWMxvUnXYUVzveOCC7xi01CUcsNUhpk9FPi9AkVaDn0?=
 =?us-ascii?Q?/R0rQ6NLSd1WQIzh5DIJ7xbF1xoruW+2wDfU8VVR7g8DwVgnWfJIryaAYtA5?=
 =?us-ascii?Q?VmGbBwqsRsLdqpRUFFSoGNoGfw3X28qII1osc6edvuDL652FxzZu1ofKecxP?=
 =?us-ascii?Q?OwSrSvwW95ZF6vWt0HaOlKpsy0eYBvOl0H4Qm/EYO+tvDrfcwdVKsHo/1Ziy?=
 =?us-ascii?Q?EBsBunP7nL+g8ui2tR08SrDEAodC86wK7mi5lWJEdoGQlJVSLep80qWeX2cW?=
 =?us-ascii?Q?w7cA/vRPaiU67xkYgMpc9YEcf5QJmoWQL9yqnDfiVn/bS9YudWjWKaOSHmoM?=
 =?us-ascii?Q?TCtuzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kejQ84930jBD7OAhdkOce0O4fbTNbmbIpLlR053s0tIbl/uoUk0/nTpB0VhK4NWMlFSMWvLuuU6HgNsi4gxrRESuyeX+hQtxxWboRVEvMoM3ExbXyQhP76fbJYESzbnQDTxUN1B2vlWZfF14+sa8Kyme5Bjk77dh8/jNVB+/hd7yFkD2NF/7JJXAGt1MLSv8plYhB8SIiZnFN3tOTLPLVCOkU7JT42bSRJbjDnlexpeuclOHVhUVhL9vPEPzy1CLhw2QhnqV1tD4/F3oE5+bNNFNo48v83HNQHqlQBlJ/HC66sdljJp7rCq5A3Owy1xZk/lKVlHLmP0lsL1RZpWjK3DjB5LDsE2zNTvLIgU0uv+B1paQsPBbnWMNO1A2LVBjukAKoeyMqqsz32c0dS+oqMSRb78pneLBudePzklh2FznyL0KHtephVRDuYkdpUUm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:57.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13010d9-90f4-4d5e-07c2-08de67dbd336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

