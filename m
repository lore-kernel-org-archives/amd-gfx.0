Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C7C3DA4B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A6B10E552;
	Tue, 16 Jul 2024 02:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6Rtdz6x";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EFF10E552
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjyfbhfWL47q9FL5c8s8EtV/HnzKacJTQy8IvsOymV9eT/Xo4u0WuxkJjDrxsS+wewO781H+TZMw1xUVpz9SXDPz5dr93G3fTj7m4TxkgXEtacq2lgWuncthZBXbRXzVy7UZAf7/t9ScTxWi4BWNavoMq1AX/or2pi0ACx+KhO3OZrYEgN8s3uG6tNUPKLnxiwwgsPeqVRaQDMKyY2IIlaOsPUuFuIdOYa+T95resrxOSi7V8WqP3Pbb/CBRIbIaTttFyUTpM679T2YODLbphVquzsQrbE+E0NvoxUlG9psdkSPctBdBOsu+317qB9r70mwhUBPZibcFF7WcEbaueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uITT4xGxZWjKRRc3bLwrm+Mvm9o4VbRWYXDk37FZlMk=;
 b=VQr6vUp9N/4xu7w3Pyro/H5tEfDy6HUnt8Qfb0GzoaMy0Pd6iRD77z3AhNzKXUCWNSvbHWO++dVkUZDS4b7JoWqoQI20oXHEMS6ZczceOB4Tu0+6dDfeGpo7Iz/T869fd0jqejP4OfFRDQvIdyuT2GFgIksE2P3cnfYPh4NOzld9LvcyQ0cizW2o7JhOkB3qQhjAS7FN54KDETJQes5KhCAkqSQHPPYVbzzGJ7y3DhL/fPXG6fw0KHsNUx/eKIe2Ao5fGf9QxgAaTSkcguV8RDJ1enEItxfcv/LgfJbqgos8eD99RgqCj4jBVFQLMxP6NI2Q0G01CoeUYuExEs4o0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uITT4xGxZWjKRRc3bLwrm+Mvm9o4VbRWYXDk37FZlMk=;
 b=B6Rtdz6xbcJCO1NFU6yfsCb4xnFZDLFZeP/oW+p8aL/mM1qkWoqwpCU/+sZa2bQaT83ofxZtDj32zo7Qq06g3qMc4447+HOOHuKxH/HVPhokLN0MhbkqSxSrH0aJWL1st+ZpjPyZQZGAtr2lWqZV22Q6ygR62LtzUDUbbDq53Hg=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:31:58 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::b6) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 02:31:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 6/6] Documentation/amdgpu: Fix duplicate declaration
Date: Mon, 15 Jul 2024 20:27:28 -0600
Message-ID: <20240716023022.100811-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b11bdd-804a-4a80-8d94-08dca53f769b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lbw6b3xxd1YIFtInbzLPR/zbr8oRSfMaGLz1NPA1b+xMlN6lNV1PkXMFYHTM?=
 =?us-ascii?Q?9gsOW7QVFbkZifgoS1w7AIziyLm0nE1syA8lCDgsCRA+COE4vhlbIZPFptVo?=
 =?us-ascii?Q?6GRNiQLNhp94R10+jQS1ojydgHwo5/aiF6GM3/HJc/gG4fkvcu4MeOMjYiAt?=
 =?us-ascii?Q?3wR8zxPwxJu9OFg9yh8HmPXXJLBEyPF1cXIrFFgjarN1pzAC9Gth5mFE79Vy?=
 =?us-ascii?Q?h878SnrB/7cL4btiJDvlhPLpStZ0xsxdBUGkq/6DiEC1+V2JsHA0xYiI1beH?=
 =?us-ascii?Q?8f/kQnX6Q7ueXaDvZWN9HJnVrPjK/KhzpVc7LYL+wgGnzy1tJXZEE7gkoxrz?=
 =?us-ascii?Q?SLjva22vobvTgERUGdK3kLCDlhwGklgrWXKNXBHENqQOt/9QKwsmr0SlIjjR?=
 =?us-ascii?Q?DkyuIFaQbN9YWEbGNsF2JRfhnRWhLJf3TG20fbEuV14aipSi67zS3UHMsqOG?=
 =?us-ascii?Q?sGn7UGKuB4SYmr9HvlbeJ/hJqInIJs0Wb+ZA+42MVUx5LQRLIPBzR8JDnnQt?=
 =?us-ascii?Q?DPJx+wTSUS5eq312UCg9fUuhNxOIciidQYlyPxe1PY2MhvI2thIxwn/uEVHq?=
 =?us-ascii?Q?vg7XSAjIYGEzVI0KgGisHjEElwEHYWwytYOME1QDPNaaQAs8Haq2X2Y1/uU4?=
 =?us-ascii?Q?jiM/8Y5pSHDedQc9kaQRrrbBHmW/W+Y4iUTGQjsQxtIAuxdU3Yx9NoRayBMi?=
 =?us-ascii?Q?kwR8qYmKDDwwS+EKbuyiG04B7t+a27lKuiQNV7gQhqlO63AbEQOxPWLytb54?=
 =?us-ascii?Q?g7i2D0YjptplEtQMkdDOEImfA6kRHj5b713j/bzd/ryot9qVVJK0RWWuzPvg?=
 =?us-ascii?Q?xHzGctcZhZPqFsBSzLBDBbVyH5cXsDUhSUv45dtt5Dfh6yY0GEkdGcsKTw0n?=
 =?us-ascii?Q?FVZxcfQbqVgQuVAyHU8zFUoyWsDiJY9ktWAVs24evyhixZbB+yjrU1zmSXA2?=
 =?us-ascii?Q?JUy9oKl8hVNbjg6uhp+kLGAqOp35cYI22ps23A9jIOfHrnagW5iPZI49f6Yd?=
 =?us-ascii?Q?rcLXwYkYKaMM9t3tarF4PS+0X7U/6a2ZtDevr08uDkMi8psZskEqTvcXa5KS?=
 =?us-ascii?Q?Dj4FrYSuBBQigC+xlCTW1vhMAd/+RFjAsGKxeLe2MlUb/PDW8NMCE0VvQxIe?=
 =?us-ascii?Q?ShyVTHObpw9/gSz5gEAAgzqAQnS8GbTfatDgsJJYTNqTohkSuph2dM0OgRGY?=
 =?us-ascii?Q?615fxXHiV/5guH2mATONgINPWMSInv1nmj1f8wlj/aEtSw66ohdzzO74a7e1?=
 =?us-ascii?Q?OCg4m2URGnKMNERT/oxy8G2u9cJyqdDM01i8i6IJthifeSWpBUsybvOg88xk?=
 =?us-ascii?Q?9/CBCSfbqZz2HyDk2ULKJv/KxLakd52z7hPTcRrWTnaVYQIcU5k/70qq/i2a?=
 =?us-ascii?Q?eZgWmyHZ41e2HjYV09lKrSwogIB3xN6Ezh20zQo+dyPWGIKkLJRG6+js/a4v?=
 =?us-ascii?Q?LwU515EzUKSxRm//14Z1KS0zw/s7Rs7b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:57.0415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b11bdd-804a-4a80-8d94-08dca53f769b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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

Address the below kernel doc warning:

Documentation/gpu/amdgpu/display/display-manager:134:
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C
declaration, also defined at gpu/amdgpu/display/dcn-blocks:101.
Declaration is '.. c:struct:: mpcc_blnd_cfg'.
Documentation/gpu/amdgpu/display/display-manager:146:
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C
declaration, also defined at gpu/amdgpu/display/dcn-blocks:3.
Declaration is '.. c:enum:: mpcc_alpha_blend_mode'.

To address the above warnings, this commit uses the 'no-identifiers'
option in the dcn-blocks to avoid duplication with the previous use of
this function doc in the display-manager file. Finally, replaces the
deprecated ':function:' in favor of ':identifiers:'.

Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst      | 1 +
 Documentation/gpu/amdgpu/display/display-manager.rst | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index f80df596ef5c..5e34366f6dbe 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -34,6 +34,7 @@ MPC
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
    :internal:
+   :no-identifiers: mpcc_blnd_cfg mpcc_alpha_blend_mode
 
 OPP
 ---
diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index 67a811e6891f..b269ff3f7a54 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -132,7 +132,7 @@ The DRM blend mode and its elements are then mapped by AMDGPU display manager
 (MPC), as follows:
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :functions: mpcc_blnd_cfg
+   :identifiers: mpcc_blnd_cfg
 
 Therefore, the blending configuration for a single MPCC instance on the MPC
 tree is defined by :c:type:`mpcc_blnd_cfg`, where
@@ -144,7 +144,7 @@ alpha and plane alpha values. It sets one of the three modes for
 :c:type:`MPCC_ALPHA_BLND_MODE`, as described below.
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :functions: mpcc_alpha_blend_mode
+   :identifiers: mpcc_alpha_blend_mode
 
 DM then maps the elements of `enum mpcc_alpha_blend_mode` to those in the DRM
 blend formula, as follows:
-- 
2.43.0

