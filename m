Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C21E8B39D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C6B10E351;
	Wed,  4 Feb 2026 04:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="onkgkhtB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B71210E53D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POw85lMpypueioslqozzIjpvcWvHAFymzIFXHgI1LTfFVVBHj8gic+mNc5FxnnBcxLCP9X7zRkvyyEsvSA7zGpadompsYYNbZ3UlZshuRtguc3qgza95UWwkQju4hKy+0PpLSYcRW+vDj8Vpt3bquuihGsYiQ3N0xLSXhJMPKSiKVYeKA9BBNEsDwfQdHf5F+7D3XPRH7V2a5JNYYLkFO99Sg7U9wF1TGjUECxCUMXQyan5xKxqy1FPy040Nyl1VvxmJkY3PhEv1C02wqqUeDDucX69Urb426symR0z1OdJB03xOobjBFGhqcqtLfO+clVLcYx4lpFeKWkf1JltirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mOZZsQZHyO5+eky5sQZMv91bcmcV+LPbJFoDYhyCdI=;
 b=KECWVFnOBeGDaCjtKIuqjdH3S2iW2Rm9hu3TzI97dHqIe8lcR9yQxp7vISfIzIpNp9ZpFu8CQQ99WXZ6XMHQb2c+JxPlIRX70fxIE8kulmZA1GzNH21j/gi8+PN81waf6wWN2wYNgMIHx4+zBOWVTGjN+OKKuNoBvDange+5+/zY2MkOGB1H0x1yJCjcuZrK4P2z3f6bSWVEkoPb3HdaVG3OIzV7njkm2xO9LzOHXQPCDgtXmwr/1BGtgjYraRMdST9HYyqHAhAXbwlJeTleJpErm2Ll7lxYzLel48XsKIFHZPiur5RR77zbHxJN49yjqMALqX8X508P7HqKtxdeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mOZZsQZHyO5+eky5sQZMv91bcmcV+LPbJFoDYhyCdI=;
 b=onkgkhtBI3mTDQXPmVYy4QtqOfXlZug+nDtpmYiT1xHoxDj0k20/8C3x52bA9a/k709/Hv0Q3MOhcRrKChb7IP3MbnVdmI0rPYZx0qp7rMfMKJ94/tM8fxBPMjGHZLILeGn9YMogo7RYe62nAn+MCbP5pbL6MzQ6aBcpKttJqQ0=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:44:14 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::8f) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:13 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:09 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Wed, 4 Feb 2026 04:43:37 +0000
Message-ID: <20260204044338.96093-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: cf50cefa-c2a5-4d01-1697-08de63a80be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XmYecFlXOPUpci8EiKed36wN38/Dzj624FFSOMA3VL5LdlupBf/OBM+9x0yi?=
 =?us-ascii?Q?Gp+4rW8kNF7pcrwkCnum3n+iEcnQdp9gRixZ7+SWugc2nQKkMlTouTWdcD4u?=
 =?us-ascii?Q?AeudyqxtjX068dewTJtA27Pgwvuqm9rx+S0jhpNUUtA6XhIA6t+6aTiE7EBp?=
 =?us-ascii?Q?eMy+nfgAPU9ec4POMSigiehqD6VT/ORZqZwlav7p+nbbZ63Z4/TKou0PhCB1?=
 =?us-ascii?Q?MSuFh2DblS+x+J6PEJM/EcOWOMCeHZc+4+84WEGxLTwU2TpQMsHgYD8jewoD?=
 =?us-ascii?Q?4ddHnhEcMbzL/Jttkl7YKBt8DCriUefmRvo39WYRyhrSXVKoflj5unZ9M6bE?=
 =?us-ascii?Q?0yGja0JsX3IQnEESG6J9jHyaRoe8yHOQscITCA4Dr8HxoKfYLNr9ZhFAvPHn?=
 =?us-ascii?Q?UxHYIGOr81XAQEUFoS1cxdsEHVf1TC/7QQsAi/KqZCpeZtBuqGK+Ki8czBVp?=
 =?us-ascii?Q?G1/TgztDviG/hnlFyr7Uy7tOek51TFE7F2IUvDbFu5qodpWLRpT4uGesVO7d?=
 =?us-ascii?Q?gO7L7RNzeqNnXpk38bj5DkPzKMWbHrUZq81wSnjINIERat9k2/A9z8PFw2Ul?=
 =?us-ascii?Q?0qCN/Pyq9F+cUwefZASu7/fBbCNq4swWnxxoU5ikScJPfCG3PWGv/39MJ1qs?=
 =?us-ascii?Q?1UrqoyAJH1SC9Ur4NFQHkDI903m5ZBHNVIXfWTANes1fkSMPlidiGbCVpppY?=
 =?us-ascii?Q?f0+MiQoIoVLlnrqej3hDukA52XqwuvsWXjOLB7a6lGJ7JOAiHXsd9xcGOIlN?=
 =?us-ascii?Q?MuWp/EHWxdgoZUS5HoXgdFHo3MEGBQSwPbpQd1Bt1CxjljzuYeM9kOY3bI5E?=
 =?us-ascii?Q?VsGGBDvbLtAZMri7pRWg3Uya8+TbHoh5lT8Tdrz3ixNQ6ONfD/CIGERtLVMl?=
 =?us-ascii?Q?0bA1y2h3TDkFPCkMNKeeUbNutmEUp8sNU9M8EsJmiNDcYvzIQ3kWGxXSYH9Y?=
 =?us-ascii?Q?R5QiCROcUXeMb8zJ6b9z6l377fqPFmRLtr9+liHJkxy8utgUyLOJfUoGhW/8?=
 =?us-ascii?Q?iIe/tyTP850yFWlyff7xPOPPoms2PGsoiZzUxhSSnkB00p9Ctnto/nrMet0L?=
 =?us-ascii?Q?dPGGPm7xkHfJ4NtLVJl4vLpVn7vXEkkGC+i3RsYYkiRmvK4r6tNt67yv6MKt?=
 =?us-ascii?Q?Fc3cgcdzpLpk7EfDLi7Ke7SNk9TMr8CYC/ZYtZt6Zfc8GFcQTw4NYzHwcXp5?=
 =?us-ascii?Q?rZTA9Cqs3e/pzH0eFj4JIZ/qZNi0VemMXF6iD/r7YwjsX+kLCt8Bw0/4N7Eo?=
 =?us-ascii?Q?6x1PgoMMovKM+HkR62pry2lbEO7w2DPfjjRUm6eAoX6L7ggX1OZEcduMN4Vf?=
 =?us-ascii?Q?HiEwya7HtEBp50Djr5Uqw5JBVSkfX6xxuhMkkzbeoAWXKjCiH88/bsVO2jf3?=
 =?us-ascii?Q?/HgGDg17fUpPRchMhS7bcvVF4S9zSOM35/8BjktR1WLSTxQ5vNdaT3P63xnM?=
 =?us-ascii?Q?cFftMdXBnAwZqNy7PMx9jwlQ0W8hJ5Vdv/NlsFjgn94tEZJr520OBUDbhSYH?=
 =?us-ascii?Q?f6aVhLfvUGij2yXrepklEL+azLYMqT2NSbA/tVMF5fqA6R0QGlEnP+zGQpyL?=
 =?us-ascii?Q?zopPwwzxtrWo2JDiQZ5yRk1qIx6HN9vdJ5nKamCqJcm46WBVmOERloL+ULfi?=
 =?us-ascii?Q?itKj2PDJDeCQUeDIj993INAh4h0zFQm36VZt+q5zEtnJD9SRNYKptVritZte?=
 =?us-ascii?Q?ugNpGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rFg8ezxkBh5bbqUvzGGnhH1OnAWuSARmRtIY5k3MQq3at4P6/xvTTjD0e1NNVbgPApVZbsAM9kiXvkl9qKZBXRZHrO2tFoGKLAyvW/o/gNAM9dqiuScCkt0psTIfHZid3kLMY/lmmNtxmIGIfXpK0tEancQ52gW7EYgrOWJTNEPGQb6alDSKVUdvTrC9tOikAHw9BandNapnzhLHt7U43UCyWW1S09vXn8s/JXiphHHOosWhjm/n9Fnk+WQo8llfvaPXt8XVssgIGSVljA9QUP8m6qew01ocHxEBQXPi2o174ZGH4TzyMYU26eWwcsYiIOGQKKy81N4zm+26erV1Zw7wJ18c2LqSxUfKxb0HV8VnVVroGYDRvbDpIfAS3Y9OV6vlsgxYFxPwGLZeyl42SK2C2v90UwaPx+vswWSXHh6P66c8+lDBDPLdS73H24if
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:13.7791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf50cefa-c2a5-4d01-1697-08de63a80be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

