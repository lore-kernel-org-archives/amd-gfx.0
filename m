Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB95FCF9C7D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B72710E7C5;
	Thu, 20 Nov 2025 18:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AFfHB4zp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640110E7C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tv6g9Wc/J4CoGJASxQJ21AjMb5M8CmqLM91ntcnpKiblIsjpK9FAZL+KHrXUgqPnYM/E5ozwpcwCbtbv60QA9M5/2FBLRRQHzO1YUgvpW8ASKR44DxUutl+mDZbWh72xdi20qNor0L9GOwIGIE8mzYCrkITaeEhSDYiLx4NXdareZsib3tZLndy/pbQdwGGu/AnWiotG6ZMAQy4MtI8L9qPalfFgyA4PpMmQ5n4ypl9KuOoctJZosKzplLdVX2c4C6reHTC+uNVWoOVdGp5buc00U3hOJ2flTQWwrPRaeYsL2ZZdb8qC4TfhKGBfZqiKqxkJU3/QKOmGK5EbARejDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKD382caRB4TXj+OPz0s/qjOambp1HX2EU2o82tUGtU=;
 b=Uv6W/NTGMo28Ueoii2a9iyIhIxLGi0riSJNwzvOHAYUGCUESu7ho1UtW4XvCq5E+LA+OlVezdCuhGgzpuwHSx2T9PsAYsqu6hdmnOKRgkB0fSQ+tTYFGT8izzWZ9JGKyfxgaRctgL5khDSnO/tdYV1qb37IH4XqNu7msZ1jn9LOh5jCb74aj9lUK9ajXSmqxM0v/lgnI1PRRFRRdn85LBvnl3p5w3Esvy2h5JEl3ZEIpGRrgjJHvYwpg3vTyVUEcWsAKcB4Z1LIwD5NSJ8PLSopABCpjpuH7gIxwq8TFaTkETG/wG2pO0P+63vNW6gH8wNLin+uREYle+gFt1ktrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKD382caRB4TXj+OPz0s/qjOambp1HX2EU2o82tUGtU=;
 b=AFfHB4zpqlffzL3ELbQAqc+FksgiylxWH705fe1FnfYDzF4h1RABwYc2NC52eS7jEkHKmNYh+io+cAbAkWaM34qHGLUenzfPWyi4nammZxhoHZ+nSaMDeN//d2ePDxr5FP+LMTo04db+TId1H5DPNxbGMgyxgWgRq2He6wCKKvE=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:23:17 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::3d) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:23:16 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:23:13 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 26/26] drm/amd/display: Promote DC to 3.2.360
Date: Thu, 20 Nov 2025 11:03:22 -0700
Message-ID: <20251120181527.317107-27-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c052aa-51fe-4dd9-5cf3-08de2861dfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLPqLzimp+1HMO7UKScl5dG6AlSTE4f6HLeuat21CUxNT/u0Oti/zusbp9Uk?=
 =?us-ascii?Q?LhOTUjjOtv3qsDqW3UusoaPDmxQxJ80z9wk9sUo720SagT+KxCAbOaxXjHjp?=
 =?us-ascii?Q?hKjEvckSHjURiLyit73uFUbBZLmAWNg/MTbdW1yU0BdBZp7k7mvOvMWZ1oUJ?=
 =?us-ascii?Q?ssWMmlhga2SasMq2vJIyS53ycUIaTq1C9fFrrDIiQ9p4dYTUbfLhr7HFCc47?=
 =?us-ascii?Q?NSN2wRHsiDKaW/zLrtYQ1oM3rm8VoobWjtxEGdpV0yEd12Ir60qKPhWDrGes?=
 =?us-ascii?Q?CXxgSUmuenRgyS0mVxrhTllgtqts1CfOmi+OshYN4QUsIyrLxjX1QiCgapL2?=
 =?us-ascii?Q?5E8RIuO+0PhB3K/BPKFoI3dKpGLTJIsZTRGvyhr+39RZRWbMUXrtrJssF8Rk?=
 =?us-ascii?Q?jCLNMsr/oxS02tVWWCkBIxCGdzZmd93/Kk2ReP240MAoOnTznyrxSX47G3yN?=
 =?us-ascii?Q?NuzxYftUbkfJj4j2R6ATG1T7wNeVn9o4BuWl9JkHgg/o5KdIgpQDWsmWVogR?=
 =?us-ascii?Q?S1MOl5SJzYa82adkG8uilZGc+NASZeAdqGD50N34oxlLGdasMi/MpRGzKjwZ?=
 =?us-ascii?Q?AXuJPSMUgLobNo2GmiPZIYIymhvC+Z2BgX0muvHK0ZzOyuO+yo7cf6WTmJMv?=
 =?us-ascii?Q?lrRcRxNEtb31SnJ5a6TyRrxT8y8HkazObEyqcPcax5Zkm4kApaJeknFdLPZH?=
 =?us-ascii?Q?mLOP0LZwhXU7JZPCdFiOgVOulPwqBmsGfnRGog83xllSuNdpvFIsmikY6VP9?=
 =?us-ascii?Q?bNAZowlg9Nc5eF+QAdImQh9o+31PT/0s3rqoeRNpqnL5eqFizYjs0C5NKr1d?=
 =?us-ascii?Q?foz0KqmMmalr7dUpUc0ss/GDVAW67nnDv5qD0At0tk+5iNbSR5dWWb6Wn2jM?=
 =?us-ascii?Q?fnvoJIW1uyABtyylZTpOEnHt/k5g5EkQN+EP+jogDtgaA+L2P/CVzbnPYx/T?=
 =?us-ascii?Q?TXe1eItxLK0h4wMObZlKaLPxhSsqJrrRmuGbYgqLekickAaRHzhEn1Yoicaq?=
 =?us-ascii?Q?aCflgyXticF+SQ/J3sSWGa90bs9a5SsZzpkTaWlXVZl3uVJzePlE3QKgdKZc?=
 =?us-ascii?Q?1AYpORKl45L4RJwvVA1AhPZYy/SXGpUfP+mhlXsHRwJOUFJaJraoGr0u2t3+?=
 =?us-ascii?Q?k/PlW+3Vn7+PZPlKnBcfJiqa7lKt1qN5kI7cW+8nJccnDCw/n+fjbgQXtoG4?=
 =?us-ascii?Q?RfNK/nSjMtG4IL4rVElZ17uqAm8eUi8keUJ4UMVSWR5EJKd+Kns94t985zyg?=
 =?us-ascii?Q?w9BZaMf4F9ZnX/gUzmVRv2PHMJR3PUVcmWtlPRikwypgtom1QSucrd77YfPm?=
 =?us-ascii?Q?EP4sdac29/CnED3UKfPf2pwEols1H3aPA+Rz6RjZJW2BtE7640HLNf+MGfIZ?=
 =?us-ascii?Q?JzzDeI1xIQ3WvR2//+BpISDFvX3/T4fWtGksXf4kClZoI0HhlGZUZx8RwhHU?=
 =?us-ascii?Q?WOpzhYGyhadXbc8Xn8nBX4I07k2gEQAe2ujwm+uNtWjCACVsIoaAy3M/cdb9?=
 =?us-ascii?Q?in0MJ91P0DU7vXcYDyA6RgBm+AlEGqsIbMAXzVZqo2p6DNSYut9E3QdQmvuA?=
 =?us-ascii?Q?UAgHrB8AjnhThmh5D7M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:23:16.0686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c052aa-51fe-4dd9-5cf3-08de2861dfa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
- Add additional checks for PSP footer size
- Correct DSC padding accounting
- Check ATOM_DEVICE_CRT2_SUPPORT in dc_load_detection
- Drop FPU flags from dml21_wrapper.c
- Permit DC_FP_START/END only in non-FP compilation units
- Add cursor offload abort to the new HWSS path
- Move dml2_create and init to the non-FPU dml2_wrapper
- Move dml2_validate to the non-FPU dml2_wrapper
- Rename dml2_wrapper.c to dml2_wrapper_fpu.c
- Increase EDID read retries
- Correct comment style
- Move CONNECTOR_ID_PCIE into switch/case
- Drop needless check for link->link_id.id
- Improve readability of link_detect_sink_signal_type
- Don't change brightness for disabled connectors
- Write default Vesa Aux backlight control in dmub
- Refactor panel replay dc libs
- Revise VSC SDP header for Panel Replay
- Fix sending redundant enable command to dmub
- Parse debug flag to PR FW
- Add AS-SDP v2 support for eDP feature
- Refactor panel replay set dmub cmd flow
- Improve HDMI info retrieval
- Check NULL before accessing

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 531d4a4c9326..60c5d8627bc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.359"
+#define DC_VER "3.2.360"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

