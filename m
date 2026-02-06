Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A32EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AD510E7AB;
	Fri,  6 Feb 2026 14:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ngzeLXTa";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAFC10E7AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVhCdV5PtyubzBSHdSBIjnyTrxwTVi3fkkpdhLret3GOMmC8Y+Mq5anhs7qcIw8FToUtoKDQPTsnH5tU9SSBVipkCmBwMtdvdDrfn8FzRu9QCPPl9ZrTgNvQyFuv30sJvJWfZHRpdII2LZmJOUMDHK1FpNezBzstk3TlvqFZHDwi3zQMmQmsbOXvRcHBFpCAeJoCyL+QIMfGJ3VHo2VZuzjOqcYLoZRGmqFPSVIWJMzcWY6n96Gqg1sOH5CFeaXsVzSZMTJ7WKAh7EMp8zPc+Bd87QQp3tJLcRyhwD7FZY0p2FKoa7bL1lBn/lqflb9AE5A1JikB2SHxI3osrVl6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=d9sdSF+WuuwaQLZlnZMaWlX+t7DQij8lveennvOFKKbI+XIq9iMXHFFiEx23Cgfq0fyP00lIlM8Kqesd/0v1sbZUmkss1zNMUlTSg+SAYHrUYm81VwVcy1ahZWXSFXsHuTCF6fn4leq7evZjBheSNyHuAzbUfWCsvbkKgYSmvR6MesbU4As8qPhmmjdyrr0n5nbi6MmiHTctFK5FBYR1gNn6Gr6PPyJu86tyYLza1+2FLuwYfGtaaMpZuRcQr4XBDxqN+LhPZrSjSzNXKdRR8Ko5QjC2lDkFPZf9/PbzIAK3iJa5h6/titxqle9vTXtcwMir5rDQEryFdCid+VeguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=ngzeLXTaxoM2yRnWDVkOBR1hjX1gxXT+3GqvAwTva3jmMy5NQBOebEjTTAzaYuX/DoE0n+HIi7sOtogqVSk/GTyRDOHYz+taC9d8bm2UNwYxEOZQXyrSurvPtis0Rr+JLXjUVVYKd2dMjr7Tf9ECu3OUXVYVNibT350aeIHxv20=
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:01:39 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::7b) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:38 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:36 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Fri, 6 Feb 2026 14:00:47 +0000
Message-ID: <20260206140049.105294-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: d7527f78-3030-4e6c-5c0f-08de65883f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/UftQTH90LEkULHHh+rAS/heFW+gwWESaNEfApebJFVEskwInuWE/IorFcl?=
 =?us-ascii?Q?r5N/BQw1i3gZbApj1XYx3/5OaPBWSb3STxcdIwyaJBY45tI0FeoNk6kRF1Ir?=
 =?us-ascii?Q?VaeJRtFBrtfjFYH1J23yospFn5CuF/e85O9gFriUy0GX1MZKXSf8bYojNiO/?=
 =?us-ascii?Q?49jHhVTh8MSylXo9A0i7ymIQQhxXS+A1OmP6iTy2lwPCEyZhnKbr2+g1FUJD?=
 =?us-ascii?Q?q0/aBrC1J5iVp1vK1StioYybwJJspAa/2+j3q4fGnBBycDqebi0Vcl50XwPL?=
 =?us-ascii?Q?jNI+3Tv2vSYQRqaMeTNMOh1R2ekEvyxEi4SkIHO+/W+bbVnLqDAIJs3FQN4Y?=
 =?us-ascii?Q?gTw5cQC06QZM+PIXd60hWmLImu1Y+cFaCF4rjjRXXtFykNawlexP3lVtyBuS?=
 =?us-ascii?Q?2wR9JeLu1zBrfLzX1viBQbRe8ROj7/URa5WSsSybGcm0mPjtoskVCFek+X/E?=
 =?us-ascii?Q?B1qMZzME1L/mbJNcxpn2jmzpvo0Pp75kqBvb9PULUcBDjFfjblpANuAdS3s+?=
 =?us-ascii?Q?2ZL9jmACJqmcCuuCestiJd/FNtLoYd00W7+A6cFhxOBOU92jtIknZsaRKPyh?=
 =?us-ascii?Q?Gq+G1mohNFB3yHKAIdVhKNOX6V1XYIShTvOro4mk/4VIVOQxxaTfhbzIPrKy?=
 =?us-ascii?Q?F1Cn7ujFIirNt5OoyRlF63XLaUPvuneIOmbeEB1WFS0D4gpPLHZ3Ox7ZNajP?=
 =?us-ascii?Q?A+ao7/ysDQg9NHx6Dd5LqOx4o2n2hOr+TDboGEw49o/ltRgfhgS/i6Zu4R2z?=
 =?us-ascii?Q?+e4/Z5jjqb5x9bDq2AEfccEjy1oU+fO1NxIYmZxilU15wkdH8j1QrzklrogU?=
 =?us-ascii?Q?kr2VrKOFnOgiTJoJtUx0gloS2Z653kOEMnYB9pGxJhWri3qQlfZwr11FGuSz?=
 =?us-ascii?Q?Vh2tzX2omRnAQSrUXXRe4oUrwCviTUU0pyhxbiNCqmyZ6IQEdUKsRYlsc6H6?=
 =?us-ascii?Q?Rab62a7VYK0NjsTSiEC/wm+BLtGtHjhPJy8uqgLemAJvmmg4J1C+RhR93vG5?=
 =?us-ascii?Q?7Ebnjd1N/yISbLz0yvbvYMBnydXMRruxm7tVWOH3Dcw8rb2vxHW68PbptR5v?=
 =?us-ascii?Q?gq6cZg/8NFKXeBsvYqznyNfhq9d8ijeN+wXw2OGNaf5vw4I7ENqmR8J4dgmI?=
 =?us-ascii?Q?qKLkYgJK+vovdEnRpfDwqiTbZzmbiy6BWLXIdlNc2jKxQUie3mnoaVd7oJH2?=
 =?us-ascii?Q?wXrczXL2KF+LyUOaeCmYNT/1k5z8zoT0g5YmkeIZ7Ae+NFo50GmHg2TZJaX7?=
 =?us-ascii?Q?pmjSHaKOp50N65agrUa0ucNRIfVeJEb9xY2mTJLl/auWqnUudCKQX/wSfUVR?=
 =?us-ascii?Q?YzTNA9Y5yIjTm/opvhZyzwVVUmkqRFs1XfXNRcmOs+M9MI+pETPIS8pILauy?=
 =?us-ascii?Q?aULMEYHci2t74ra6fH2eZXdli2mZn8UnJ038yZ90Eul9j2Lq9wfdn3WUvgHy?=
 =?us-ascii?Q?N3F6HUG/3HYsC8Ivdi72K8cZyEe9GN5lesTRaJPhLaYA0CWsRslxyQCmFzid?=
 =?us-ascii?Q?ToVlExXNUlsIzI6bH8tjGd1CxWhcYLgG4EzxI5ar2lz44xsTEnIK/7VsLTJP?=
 =?us-ascii?Q?SjgFH0d7VMPmr1V1x5DfDTqNSFQkWhPPVpnP8ixCB1Km7encBPjrIOlMOpJw?=
 =?us-ascii?Q?qhARqWLOx8tqnMk6foVYi7bOPXaD/7Jun3YfWGN1crALYG+lY0P7nqFm2jJY?=
 =?us-ascii?Q?lQqomw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TGh2l1PNQcM+a7/6SRAUV6HP4Uz4gG/HzXllRRnXkqTk9jsZZo356Cku22E8FQeJeT9g46ZrfnPnlF7rNa51rdL9tKT0XZghNRipVABfmyK3Y8EgEWsbBgdRyi6xFo36fTcQr3LQP16yhQK8XhP4gVO/R+qTgpAGBe4wmWM/muqFjXsBPtOpvgjkV1Yn94mtM5ymGCl23Ff0pdrzkNw8QmOqBseNNFg1LGmkBMc/XlzotH1ybAGbLpZ4YjZhs3uvM2RBOk4/ddAwlaj9OoY0RJDOsYq466ktNQmFrjDriR5FNYimpaFoclN/E7C+0z+pJ7a+zY1mg3St/4XkGYJ+VvDGOX6OUCS1m9qCVPdZ6Jy2AmotK2jLCgisoB+j5Fbr00CJOSz7ti5CqeILI+hekh3ofkNAjCJ/FqgN8NmjASrpGalDaBm/wl5lrwth0YK/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:38.3747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7527f78-3030-4e6c-5c0f-08de65883f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

