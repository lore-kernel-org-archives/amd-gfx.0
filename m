Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934EDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 02:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0A010EB25;
	Wed, 22 Jun 2022 02:26:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2476D10EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 02:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFBBwl/stT8KbumSIbHSU4aCp+U23y+euPVsXd6MC+bzVRfdbyOi/iFIWAGrhlRcuGQrRntitoPwzxSrtc2tXAZSGXZ/fjohr7Q4bP2C9LG8FSNWxYKZk9TFjm6hg+phnqZzqg56YnMjUxQL3sfoTAbP1vpR0tZe0yG2hU7hRSwL19Jzqog2FmX6yKjx/XROjgSH5xUBQZPNcw9CN37mDH/HRTbwmHkD9j/f7rUAfWeIi4afeDRRHYVYzFJWaNPdrZo55TOWvkqovOAB++cbC0O0UJAHf+HpBrvEPWvOxAlP2tKbJqU8WeCL3IFcre6ysFlJlaeCfgEbIloau9ciuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Eb+yzhRkhZblUNYWXXg4u/f1CLX8m1PLmKSG8RBYs=;
 b=EMmNLyu/hzO6lNwM+9am+v2pvin/FGFVkyU6G+O4PRJP/ERSlyWjd8923smqcwmWMyAJ9BGWuuqmB29oGLBHnqmb/QWf2i+3dkgyCMf2jb605gUodoDH8OnRZw8kDyqQIYTaOnBatAX2KJSO7GIIS48v+hgsyoEZIPKjTw/Yj++hKFr3RqqbttXDV1IiEVnyh+Gna4p/Q+b/bQTTF35mjxBr1qYy6TllzS8dwxkUEuJ3Xlqn+STSeAWqDIvh4ysEui6vyglTEkTK1J/5O2dDDmwxP4jav3ZC/+4wXPtYXXMoqJEasqr9Yex1m4ZNmQdwi7U5cylMn0HnAx8qXK9mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Eb+yzhRkhZblUNYWXXg4u/f1CLX8m1PLmKSG8RBYs=;
 b=hfeRI6nyPpgjdWy+GkHFI+eax0aT8UDrqZhHR0nZZvBpTtm2dagyo2MEYFJVTs11cYjTY8k4C1cYKzSqytFvke4dSIo9TeXkiRusFq3a/82xmK9qLiO5QKuFKnTQWUp7vhtS2qYmltSksSPoarbq4ZZSsUQsawjN91+SPN1dlyw=
Received: from MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 02:26:38 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::64) by MW4PR04CA0306.outlook.office365.com
 (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Wed, 22 Jun 2022 02:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 02:26:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 21:26:34 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update GFX11 cs settings
Date: Wed, 22 Jun 2022 10:25:55 +0800
Message-ID: <20220622022556.35736-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 943c0bff-f853-4c76-9ec4-08da53f6a2bd
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5456:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5456EC8DE587A767C6E9D5D1E4B29@SJ0PR12MB5456.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX6LVwU5cMHtBoTdz1NJiEWCxK/m9krAI/M9O8X7TQweL+IUR77xgCcJx+/bqMG42sIlUYFHadaakuOEFINfxUwvFyU51SXRYOJjf/ATgENBrB7CbhGh++1P7JxgoEPUtXgfugHz+31EFDN2rTuKbEMlyjQFuc/Oo0hHL4uVwJJYf/Spd5NgrIsL7007sT3YhjYYNPhOYRk5c+QQ/fh9b4qfuoMvEaaRl3t5t4AqB9gCcF30NenCZz085EPgx4aAO34vIPliCrUmtQp9hH7efwKKOPcEB4qWhoHjV7JpwNC5ZXGPrNX4D/CJlqAxQJbadIUAUU9SbMlj5R9rIbDWo4brRktoO39SR5X+lD1/DpXUpW+S06kbkK0QBrVg2nDCZp9bd/4nxSPrB8bnjcsQ235zeQHrKMcGcneMlbMelOllF6KK9S+S/Rus+hd61igr91unyiCfwm5BkT/eD4c/vINhLznJ4cDIx7DClOpdQaDF1KeSNySF6iXZTGFanJjtuQcbS9vFQnkJjaNnHNzqKC4K1QPqT6/OgWnZQzKzIdJXtCjRjNFQ7OSplBMuLllfuKlt+9DwPKttAS/vJkrgQQZsIm1/ESUIN4JO+s+klaW0Ve1A3akXtyeqDCh0ZO9oiz1FdCd8+C0KacIJ2Ap7+ZVgYL5/heuhsXq+j1oyPSk7gH/uMMNyc1f1uaMVDKZaNHa+6dfBWBHchGTFYDxYD14zMO5h8+GKb3UfYHvl6hiyDIwrfMVqaBqgf9q9l6sd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(4326008)(8936002)(6666004)(82310400005)(26005)(44832011)(426003)(41300700001)(40480700001)(82740400003)(54906003)(6916009)(15650500001)(2906002)(36860700001)(86362001)(47076005)(70586007)(36756003)(40460700003)(186003)(1076003)(2616005)(70206006)(478600001)(336012)(81166007)(316002)(7696005)(356005)(30864003)(8676002)(16526019)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 02:26:38.2024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943c0bff-f853-4c76-9ec4-08da53f6a2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update GFX11 cs related settings.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: If99a46ef4178fb4cd686008038923d3b15efa452
---
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h | 307 +++++++++---------
 1 file changed, 158 insertions(+), 149 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h
index f3852b59b1d6..a8b29d33c464 100644
--- a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx11.h
@@ -39,7 +39,7 @@ static const unsigned int gfx11_SECT_CONTEXT_def_1[] =
     0x00000000, // DB_DEPTH_CLEAR
     0x00000000, // PA_SC_SCREEN_SCISSOR_TL
     0x40004000, // PA_SC_SCREEN_SCISSOR_BR
-    0x00000000, // DB_DFSM_CONTROL
+    0, // HOLE
     0x00000000, // DB_RESERVED_REG_2
     0x00000000, // DB_Z_INFO
     0x00000000, // DB_STENCIL_INFO
@@ -50,7 +50,7 @@ static const unsigned int gfx11_SECT_CONTEXT_def_1[] =
     0x00000000, // DB_RESERVED_REG_1
     0x00000000, // DB_RESERVED_REG_3
     0x00000000, // DB_SPI_VRS_CENTER_LOCATION
-    0x00000000, // DB_VRS_OVERRIDE_CNTL
+    0, // HOLE
     0x00000000, // DB_Z_READ_BASE_HI
     0x00000000, // DB_STENCIL_READ_BASE_HI
     0x00000000, // DB_Z_WRITE_BASE_HI
@@ -270,29 +270,29 @@ static const unsigned int gfx11_SECT_CONTEXT_def_2[] =
     0x00000000, // PA_SC_FSR_EN
     0x00000000, // PA_SC_FSR_FBW_RECURSIONS_X
     0x00000000, // PA_SC_FSR_FBW_RECURSIONS_Y
-    0x00000000, // PA_SC_VRS_RATE_FEEDBACK_VIEW
+    0, // HOLE
     0x00000000, // PA_SC_VRS_OVERRIDE_CNTL
     0x00000000, // PA_SC_VRS_RATE_FEEDBACK_BASE
     0x00000000, // PA_SC_VRS_RATE_FEEDBACK_BASE_EXT
     0x00000000, // PA_SC_VRS_RATE_FEEDBACK_SIZE_XY
     0x00000000, // PA_SC_BINNER_OUTPUT_TIMEOUT_CNTL
-    0, // HOLE
+    0x00000000, // PA_SC_VRS_RATE_CACHE_CNTL
     0, // HOLE
     0, // HOLE
     0x00000000, // PA_SC_VRS_RATE_BASE
     0x00000000, // PA_SC_VRS_RATE_BASE_EXT
     0x00000000, // PA_SC_VRS_RATE_SIZE_XY
-    0x00000000, // PA_SC_VRS_RATE_VIEW
-    0xffffffff, // VGT_MAX_VTX_INDX
-    0x00000000, // VGT_MIN_VTX_INDX
-    0x00000000, // VGT_INDX_OFFSET
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // VGT_MULTI_PRIM_IB_RESET_INDX
     0x00550055, // CB_RMI_GL2_CACHE_CONTROL
     0x00000000, // CB_BLEND_RED
     0x00000000, // CB_BLEND_GREEN
     0x00000000, // CB_BLEND_BLUE
     0x00000000, // CB_BLEND_ALPHA
-    0x00000000, // CB_DCC_CONTROL
+    0x00000000, // CB_FDCC_CONTROL
     0x00000000, // CB_COVERAGE_OUT_CONTROL
     0x00000000, // DB_STENCIL_CONTROL
     0x01000000, // DB_STENCILREFMASK
@@ -470,8 +470,8 @@ static const unsigned int gfx11_SECT_CONTEXT_def_2[] =
     0x00000000, // SPI_BARYC_CNTL
     0, // HOLE
     0x00000000, // SPI_TMPRING_SIZE
-    0, // HOLE
-    0, // HOLE
+    0x00000000, // SPI_GFX_SCRATCH_BASE_LO
+    0x00000000, // SPI_GFX_SCRATCH_BASE_HI
     0, // HOLE
     0, // HOLE
     0, // HOLE
@@ -545,7 +545,7 @@ static const unsigned int gfx11_SECT_CONTEXT_def_4[] =
     0x00000000, // PA_STEREO_CNTL
     0x00000000, // PA_STATE_STEREO_X
     0x00000000, // PA_CL_VRS_CNTL
-    0x00000000, // PA_SIDEBAND_REQUEST_DELAYS
+    0, // HOLE
     0, // HOLE
     0, // HOLE
     0, // HOLE
@@ -658,30 +658,30 @@ static const unsigned int gfx11_SECT_CONTEXT_def_4[] =
     0x00000000, // PA_SU_POINT_MINMAX
     0x00000000, // PA_SU_LINE_CNTL
     0x00000000, // PA_SC_LINE_STIPPLE
-    0x00000000, // VGT_OUTPUT_PATH_CNTL
-    0x00000000, // VGT_HOS_CNTL
+    0, // HOLE
+    0, // HOLE
     0x00000000, // VGT_HOS_MAX_TESS_LEVEL
     0x00000000, // VGT_HOS_MIN_TESS_LEVEL
-    0x00000000, // VGT_HOS_REUSE_DEPTH
-    0x00000000, // VGT_GROUP_PRIM_TYPE
-    0x00000000, // VGT_GROUP_FIRST_DECR
-    0x00000000, // VGT_GROUP_DECR
-    0x00000000, // VGT_GROUP_VECT_0_CNTL
-    0x00000000, // VGT_GROUP_VECT_1_CNTL
-    0x00000000, // VGT_GROUP_VECT_0_FMT_CNTL
-    0x00000000, // VGT_GROUP_VECT_1_FMT_CNTL
-    0x00000000, // VGT_GS_MODE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // VGT_GS_ONCHIP_CNTL
     0x00000000, // PA_SC_MODE_CNTL_0
     0x00000000, // PA_SC_MODE_CNTL_1
     0x00000000, // VGT_ENHANCE
-    0x00000100, // VGT_GS_PER_ES
-    0x00000080, // VGT_ES_PER_GS
-    0x00000002, // VGT_GS_PER_VS
-    0x00000000, // VGT_GSVS_RING_OFFSET_1
-    0x00000000, // VGT_GSVS_RING_OFFSET_2
-    0x00000000, // VGT_GSVS_RING_OFFSET_3
-    0x00000000, // VGT_GS_OUT_PRIM_TYPE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // IA_ENHANCE
 };
 static const unsigned int gfx11_SECT_CONTEXT_def_5[] =
@@ -695,37 +695,36 @@ static const unsigned int gfx11_SECT_CONTEXT_def_6[] =
 };
 static const unsigned int gfx11_SECT_CONTEXT_def_7[] =
 {
-    0x00000000, // VGT_MULTI_PRIM_IB_RESET_EN
     0x00000000, // VGT_DRAW_PAYLOAD_CNTL
     0, // HOLE
-    0x00000000, // VGT_INSTANCE_STEP_RATE_0
-    0x00000000, // VGT_INSTANCE_STEP_RATE_1
-    0x000000ff, // IA_MULTI_VGT_PARAM
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // VGT_ESGS_RING_ITEMSIZE
-    0x00000000, // VGT_GSVS_RING_ITEMSIZE
+    0, // HOLE
     0x00000000, // VGT_REUSE_OFF
-    0x00000000, // VGT_VTX_CNT_EN
+    0, // HOLE
     0x00000000, // DB_HTILE_SURFACE
     0x00000000, // DB_SRESULTS_COMPARE_STATE0
     0x00000000, // DB_SRESULTS_COMPARE_STATE1
     0x00000000, // DB_PRELOAD_CONTROL
     0, // HOLE
-    0x00000000, // VGT_STRMOUT_BUFFER_SIZE_0
-    0x00000000, // VGT_STRMOUT_VTX_STRIDE_0
     0, // HOLE
-    0x00000000, // VGT_STRMOUT_BUFFER_OFFSET_0
-    0x00000000, // VGT_STRMOUT_BUFFER_SIZE_1
-    0x00000000, // VGT_STRMOUT_VTX_STRIDE_1
     0, // HOLE
-    0x00000000, // VGT_STRMOUT_BUFFER_OFFSET_1
-    0x00000000, // VGT_STRMOUT_BUFFER_SIZE_2
-    0x00000000, // VGT_STRMOUT_VTX_STRIDE_2
     0, // HOLE
-    0x00000000, // VGT_STRMOUT_BUFFER_OFFSET_2
-    0x00000000, // VGT_STRMOUT_BUFFER_SIZE_3
-    0x00000000, // VGT_STRMOUT_VTX_STRIDE_3
     0, // HOLE
-    0x00000000, // VGT_STRMOUT_BUFFER_OFFSET_3
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0, // HOLE
     0, // HOLE
     0, // HOLE
@@ -745,10 +744,10 @@ static const unsigned int gfx11_SECT_CONTEXT_def_7[] =
     0x00000000, // VGT_TESS_DISTRIBUTION
     0x00000000, // VGT_SHADER_STAGES_EN
     0x00000000, // VGT_LS_HS_CONFIG
-    0x00000000, // VGT_GS_VERT_ITEMSIZE
-    0x00000000, // VGT_GS_VERT_ITEMSIZE_1
-    0x00000000, // VGT_GS_VERT_ITEMSIZE_2
-    0x00000000, // VGT_GS_VERT_ITEMSIZE_3
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // VGT_TF_PARAM
     0x00000000, // DB_ALPHA_TO_MASK
     0, // HOLE
@@ -759,11 +758,22 @@ static const unsigned int gfx11_SECT_CONTEXT_def_7[] =
     0x00000000, // PA_SU_POLY_OFFSET_BACK_SCALE
     0x00000000, // PA_SU_POLY_OFFSET_BACK_OFFSET
     0x00000000, // VGT_GS_INSTANCE_CNT
-    0x00000000, // VGT_STRMOUT_CONFIG
-    0x00000000, // VGT_STRMOUT_BUFFER_CONFIG
-};
-static const unsigned int gfx11_SECT_CONTEXT_def_8[] =
-{
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // PA_SC_CENTROID_PRIORITY_0
     0x00000000, // PA_SC_CENTROID_PRIORITY_1
     0x00001000, // PA_SC_LINE_CNTL
@@ -797,126 +807,126 @@ static const unsigned int gfx11_SECT_CONTEXT_def_8[] =
     0x00100000, // PA_SC_CONSERVATIVE_RASTERIZATION_CNTL
     0x00000000, // PA_SC_NGG_MODE_CNTL
     0x00000000, // PA_SC_BINNER_CNTL_2
-    0x0000001e, // VGT_VERTEX_REUSE_BLOCK_CNTL
-    0x00000020, // VGT_OUT_DEALLOC_CNTL
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR0_BASE
-    0x00000000, // CB_COLOR0_PITCH
-    0x00000000, // CB_COLOR0_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR0_VIEW
     0x00000000, // CB_COLOR0_INFO
     0x00000000, // CB_COLOR0_ATTRIB
-    0x00000000, // CB_COLOR0_DCC_CONTROL
-    0x00000000, // CB_COLOR0_CMASK
-    0x00000000, // CB_COLOR0_CMASK_SLICE
-    0x00000000, // CB_COLOR0_FMASK
-    0x00000000, // CB_COLOR0_FMASK_SLICE
-    0x00000000, // CB_COLOR0_CLEAR_WORD0
-    0x00000000, // CB_COLOR0_CLEAR_WORD1
+    0x00000000, // CB_COLOR0_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR0_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR1_BASE
-    0x00000000, // CB_COLOR1_PITCH
-    0x00000000, // CB_COLOR1_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR1_VIEW
     0x00000000, // CB_COLOR1_INFO
     0x00000000, // CB_COLOR1_ATTRIB
-    0x00000000, // CB_COLOR1_DCC_CONTROL
-    0x00000000, // CB_COLOR1_CMASK
-    0x00000000, // CB_COLOR1_CMASK_SLICE
-    0x00000000, // CB_COLOR1_FMASK
-    0x00000000, // CB_COLOR1_FMASK_SLICE
-    0x00000000, // CB_COLOR1_CLEAR_WORD0
-    0x00000000, // CB_COLOR1_CLEAR_WORD1
+    0x00000000, // CB_COLOR1_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR1_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR2_BASE
-    0x00000000, // CB_COLOR2_PITCH
-    0x00000000, // CB_COLOR2_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR2_VIEW
     0x00000000, // CB_COLOR2_INFO
     0x00000000, // CB_COLOR2_ATTRIB
-    0x00000000, // CB_COLOR2_DCC_CONTROL
-    0x00000000, // CB_COLOR2_CMASK
-    0x00000000, // CB_COLOR2_CMASK_SLICE
-    0x00000000, // CB_COLOR2_FMASK
-    0x00000000, // CB_COLOR2_FMASK_SLICE
-    0x00000000, // CB_COLOR2_CLEAR_WORD0
-    0x00000000, // CB_COLOR2_CLEAR_WORD1
+    0x00000000, // CB_COLOR2_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR2_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR3_BASE
-    0x00000000, // CB_COLOR3_PITCH
-    0x00000000, // CB_COLOR3_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR3_VIEW
     0x00000000, // CB_COLOR3_INFO
     0x00000000, // CB_COLOR3_ATTRIB
-    0x00000000, // CB_COLOR3_DCC_CONTROL
-    0x00000000, // CB_COLOR3_CMASK
-    0x00000000, // CB_COLOR3_CMASK_SLICE
-    0x00000000, // CB_COLOR3_FMASK
-    0x00000000, // CB_COLOR3_FMASK_SLICE
-    0x00000000, // CB_COLOR3_CLEAR_WORD0
-    0x00000000, // CB_COLOR3_CLEAR_WORD1
+    0x00000000, // CB_COLOR3_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR3_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR4_BASE
-    0x00000000, // CB_COLOR4_PITCH
-    0x00000000, // CB_COLOR4_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR4_VIEW
     0x00000000, // CB_COLOR4_INFO
     0x00000000, // CB_COLOR4_ATTRIB
-    0x00000000, // CB_COLOR4_DCC_CONTROL
-    0x00000000, // CB_COLOR4_CMASK
-    0x00000000, // CB_COLOR4_CMASK_SLICE
-    0x00000000, // CB_COLOR4_FMASK
-    0x00000000, // CB_COLOR4_FMASK_SLICE
-    0x00000000, // CB_COLOR4_CLEAR_WORD0
-    0x00000000, // CB_COLOR4_CLEAR_WORD1
+    0x00000000, // CB_COLOR4_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR4_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR5_BASE
-    0x00000000, // CB_COLOR5_PITCH
-    0x00000000, // CB_COLOR5_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR5_VIEW
     0x00000000, // CB_COLOR5_INFO
     0x00000000, // CB_COLOR5_ATTRIB
-    0x00000000, // CB_COLOR5_DCC_CONTROL
-    0x00000000, // CB_COLOR5_CMASK
-    0x00000000, // CB_COLOR5_CMASK_SLICE
-    0x00000000, // CB_COLOR5_FMASK
-    0x00000000, // CB_COLOR5_FMASK_SLICE
-    0x00000000, // CB_COLOR5_CLEAR_WORD0
-    0x00000000, // CB_COLOR5_CLEAR_WORD1
+    0x00000000, // CB_COLOR5_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR5_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR6_BASE
-    0x00000000, // CB_COLOR6_PITCH
-    0x00000000, // CB_COLOR6_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR6_VIEW
     0x00000000, // CB_COLOR6_INFO
     0x00000000, // CB_COLOR6_ATTRIB
-    0x00000000, // CB_COLOR6_DCC_CONTROL
-    0x00000000, // CB_COLOR6_CMASK
-    0x00000000, // CB_COLOR6_CMASK_SLICE
-    0x00000000, // CB_COLOR6_FMASK
-    0x00000000, // CB_COLOR6_FMASK_SLICE
-    0x00000000, // CB_COLOR6_CLEAR_WORD0
-    0x00000000, // CB_COLOR6_CLEAR_WORD1
+    0x00000000, // CB_COLOR6_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR6_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR7_BASE
-    0x00000000, // CB_COLOR7_PITCH
-    0x00000000, // CB_COLOR7_SLICE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR7_VIEW
     0x00000000, // CB_COLOR7_INFO
     0x00000000, // CB_COLOR7_ATTRIB
-    0x00000000, // CB_COLOR7_DCC_CONTROL
-    0x00000000, // CB_COLOR7_CMASK
-    0x00000000, // CB_COLOR7_CMASK_SLICE
-    0x00000000, // CB_COLOR7_FMASK
-    0x00000000, // CB_COLOR7_FMASK_SLICE
-    0x00000000, // CB_COLOR7_CLEAR_WORD0
-    0x00000000, // CB_COLOR7_CLEAR_WORD1
+    0x00000000, // CB_COLOR7_FDCC_CONTROL
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR7_DCC_BASE
     0, // HOLE
     0x00000000, // CB_COLOR0_BASE_EXT
@@ -927,22 +937,22 @@ static const unsigned int gfx11_SECT_CONTEXT_def_8[] =
     0x00000000, // CB_COLOR5_BASE_EXT
     0x00000000, // CB_COLOR6_BASE_EXT
     0x00000000, // CB_COLOR7_BASE_EXT
-    0x00000000, // CB_COLOR0_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR1_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR2_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR3_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR4_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR5_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR6_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR7_CMASK_BASE_EXT
-    0x00000000, // CB_COLOR0_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR1_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR2_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR3_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR4_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR5_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR6_FMASK_BASE_EXT
-    0x00000000, // CB_COLOR7_FMASK_BASE_EXT
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
+    0, // HOLE
     0x00000000, // CB_COLOR0_DCC_BASE_EXT
     0x00000000, // CB_COLOR1_DCC_BASE_EXT
     0x00000000, // CB_COLOR2_DCC_BASE_EXT
@@ -976,8 +986,7 @@ static const struct cs_extent_def gfx11_SECT_CONTEXT_defs[] =
     {gfx11_SECT_CONTEXT_def_4, 0x0000a1ff, 158 },
     {gfx11_SECT_CONTEXT_def_5, 0x0000a2a0, 2 },
     {gfx11_SECT_CONTEXT_def_6, 0x0000a2a3, 1 },
-    {gfx11_SECT_CONTEXT_def_7, 0x0000a2a5, 66 },
-    {gfx11_SECT_CONTEXT_def_8, 0x0000a2f5, 203 },
+    {gfx11_SECT_CONTEXT_def_7, 0x0000a2a6, 282 },
     { 0, 0, 0 }
 };
 static const struct cs_section_def gfx11_cs_data[] = {
-- 
2.29.0

