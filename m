Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ADC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 14:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DA410FACC;
	Wed, 22 Jun 2022 14:48:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD88110FACC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 14:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXlcJsTGdLh/RdzEjsfP54LhwVC9T3LUI3HvZB4BX+GPl8zY3N/KcjHcv6U2NWHkfyL06aubnjCeaw0xxzE/4Vjcf9bqmsL2YC8gwfw3m9gN+fS5lE3YxdFU2fl0+T1aF1Z1v3oM8rEc22AtHRE25dPIrygHyLOLiiKTqOEnHGTDcSmRhnlF0sJ/fQ6E11OR7sfqonQnCkviQDvG8j/8CLpDXtfuBWSHVMC11ky8li1y+JQenZWwd0DsZxmJymupqFmxvnmEMrlF1FH+cuC1YDCb7BvmBrKle5NxYxSpNONIzCi/DnEfb7G2WP40U1roYCKPnxoTSlkmFEKOPMLatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRIlXN8r0vHrwKZKHbqZxi9hqP8W089SvkhB4GnGkpE=;
 b=XKBfbYr1JzPnD591wAnml96vFn/4L8f1xv9HJ/J3CLYtyXBwtD+aGeVvG58c1cZEbou1c8L+T/4wKwJyF4UhQTEjHIPeNtZCrA3WwfX9lPhLBGepVmx0nzREIWtVmU8SQq8FuQaXhfCVW2YGWzhmWP73E2/Qa0ejNS176IdxQ2Wr+t3azQngl2pjGajcKvBs82FxZJJ8FTfWnGP2zPxuGS+Tj73SA+/vADmlpfl8U4r9fljH1T9UkWdxrZ73g1pHipG3/LuoESwKGH6UWLv083vsRM9FvMuxnvv5I+P4BnMN4y1h4ZIrCdFJ6XdBgyUe9xSrF35BL9c20jByalSsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRIlXN8r0vHrwKZKHbqZxi9hqP8W089SvkhB4GnGkpE=;
 b=5W0Xj1EXhr7Oso0w1AN+xmFS8aBUlSKh6vgQI5Y/FzbJOqUrqq2fBrC4ERzhKYt+b0geQ1HDtjObLMh0UeI4+NkAGbyvsHjj4KUPNj6ygNQ6/5GnJnUrJBwPVUuK8gSMJhrVMQH8EDXSatr4AWvv4nNS/FIMLC52D3cCQYuktlk=
Received: from BN0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:408:142::6)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 14:48:12 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::c) by BN0PR08CA0001.outlook.office365.com
 (2603:10b6:408:142::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 14:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 14:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 09:48:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: reduce stack size in
 dml32_ModeSupportAndSystemConfigurationFull()
Date: Wed, 22 Jun 2022 10:47:56 -0400
Message-ID: <20220622144756.1890683-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b84133-a27c-40a4-5aaf-08da545e3b4d
X-MS-TrafficTypeDiagnostic: DS7PR12MB5911:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5911A99B76C5BC6E69760E4BF7B29@DS7PR12MB5911.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6BhYUTOi6AYuG/wpk1ctPYdz6KoFDnUsi7pqHenXU8txg4lHjzVbyYxtFMXmf0tEx3Ty0ZApTY1tkEeGPIQ6ExEJKTIJZiiBKDHpMKxXHAG5KIK/e0bsfeRNqmkSrMipALjCcCv5kjrSewAlNhH0Wq50t5FFvjLZCVFL/CKSlPargH48+DsXlfNx5ihffOfTRM6tJpeYcuWo2dAqQORba5Zo0lnzy/aYPdPKhpbGFCAPwMmLatz7ZAJNpUVebqbjvJz2heFGG8eZUCSXmVv++LTrjucEvot08ds8YAL4bwf1F87Y/FaORIjIauffFeWJpB+XM+cxcXHYpVarAWloc+TP7d3cnkvbHi6dhWFS8kkogEM5arJUiRbpBQwHMTWdd7O/GzQd0efGBV5A9irqUVsy9uns112lDO9wEVSSK9ePxQMlIzF2sz7lwYxzWAH8f1/2xZJoSJB3pjkihpR3ZFmd4iBSBAAEc7S4heI2jJvBgLrKQJk8XdrzJhiR94zkDibsUrzXYY1kNYgaDHVD9TNKObYdNAe/F0SWGV2CnLqXVmiL+mea3A1w5In1SRILOCt5Lo1XLUA2RS4RuFskF33KaqRb9UCtyqElGR/rDIiXsqgfi0MzuYQEUJdwPG+9wnQDedgwjPcx7VsJmtZdU/lVj+i5TxjE5idd4tKwFqoiqEvK6IHtDkfBALcZ7h5JPN+oszHuR6037iYJxZw0kzNsUsyTWB3gfa+pEh57PGk4Hxx5H5fWwgZGQcdzX8OmpHEytevmkRud8v+CZPUQkf+SXbhvaB3vzv06XOZHpWM0YBfrnD4g8PZR/Il0qN24Nf2+1zPlgpzDCjIMQkLUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(40470700004)(46966006)(30864003)(83380400001)(36756003)(40480700001)(82310400005)(4326008)(19627235002)(70586007)(8936002)(54906003)(478600001)(70206006)(8676002)(2906002)(6916009)(316002)(40460700003)(5660300002)(41300700001)(16526019)(2616005)(26005)(1076003)(186003)(356005)(426003)(82740400003)(336012)(47076005)(36860700001)(7696005)(81166007)(86362001)(6666004)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 14:48:12.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b84133-a27c-40a4-5aaf-08da545e3b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo
 Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move more stack variable in to dummy vars structure on the heap.

Fixes stack frame size errors:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3833:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 3833 | } // ModeSupportAndSystemConfigurationFull
      | ^

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 77 ++++++++-----------
 .../drm/amd/display/dc/dml/display_mode_vba.h |  3 +-
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 510b7a81ee12..7f144adb1e36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1660,8 +1660,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
-	bool dummy_boolean[2];
-	unsigned int dummy_integer[1];
+	unsigned int dummy_integer[4];
 	bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
 	bool MPCCombineMethodAsPossible;
 	enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
@@ -1973,10 +1972,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5], /* Long            DETBufferSizeInKByte[]  */
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6], /* Long            DETBufferSizeY[]  */
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
-			&dummy_boolean[0], /* bool           *UnboundedRequestEnabled  */
-			&dummy_integer[0], /* Long           *CompressedBufferSizeInkByte  */
+			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
+			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
 			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
-			&dummy_boolean[1]); /* bool           *ViewportSizeSupport */
+			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
 
 	MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
 	MPCCombineMethodAsPossible = false;
@@ -2506,7 +2505,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	//
 	for (i = 0; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			bool dummy_boolean_array[1][DC__NUM_DPP__MAX];
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 				mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
 				mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
@@ -2570,7 +2568,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.DETBufferSizeCThisState,
 					&mode_lib->vba.UnboundedRequestEnabledThisState,
 					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
-					dummy_boolean_array[0],
+					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
 					&mode_lib->vba.ViewportSizeSupport[i][j]);
 
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
@@ -2708,9 +2706,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			}
 
 			{
-				bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
-				unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
-
 				dml32_CalculateVMRowAndSwath(
 						mode_lib->vba.NumberOfActiveSurfaces,
 						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
@@ -2733,32 +2728,32 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						/* Output */
 						mode_lib->vba.PTEBufferSizeNotExceededPerState,
 						mode_lib->vba.DCCMetaBufferSizeNotExceededPerState,
-						dummy_integer_array[0],
-						dummy_integer_array[1],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1],
 						mode_lib->vba.dpte_row_height,
 						mode_lib->vba.dpte_row_height_chroma,
-						dummy_integer_array[2],
-						dummy_integer_array[3],
-						dummy_integer_array[4],
-						dummy_integer_array[5],
-						dummy_integer_array[6],
-						dummy_integer_array[7],
-						dummy_integer_array[8],
-						dummy_integer_array[9],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[8],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[9],
 						mode_lib->vba.meta_row_height,
 						mode_lib->vba.meta_row_height_chroma,
-						dummy_integer_array[10],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[10],
 						mode_lib->vba.dpte_group_bytes,
-						dummy_integer_array[11],
-						dummy_integer_array[12],
-						dummy_integer_array[13],
-						dummy_integer_array[14],
-						dummy_integer_array[15],
-						dummy_integer_array[16],
-						dummy_integer_array[17],
-						dummy_integer_array[18],
-						dummy_integer_array[19],
-						dummy_integer_array[20],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[11],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[12],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[13],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[14],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[15],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[16],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[17],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[18],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[19],
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[20],
 						mode_lib->vba.PrefetchLinesYThisState,
 						mode_lib->vba.PrefetchLinesCThisState,
 						mode_lib->vba.PrefillY,
@@ -2772,9 +2767,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.MetaRowBytesThisState,
 						mode_lib->vba.use_one_row_for_frame_this_state,
 						mode_lib->vba.use_one_row_for_frame_flip_this_state,
-						dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
-						dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
-						dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
+						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
 			}
 
 			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
@@ -3197,7 +3192,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 					DmlPipe myPipe;
-					unsigned int dummy_integer;
 
 					mode_lib->vba.TWait = dml32_CalculateTWait(
 							mode_lib->vba.PrefetchModePerState[i][j],
@@ -3294,7 +3288,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
-							&dummy_integer,         							    // unsigned int   *VUpdateOffsetPix
+							&dummy_integer[0],         							    // unsigned int   *VUpdateOffsetPix
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
 				}
@@ -3323,7 +3317,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 
 				{
-					double dummy_single[2];
 					dml32_CalculatePrefetchBandwithSupport(
 							mode_lib->vba.NumberOfActiveSurfaces,
 							mode_lib->vba.ReturnBWPerState[i][j],
@@ -3346,8 +3339,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.UrgentBurstFactorCursorPre,
 
 							/* output */
-							&dummy_single[0],   // Single  *PrefetchBandwidth
-							&dummy_single[1],   // Single  *FractionOfUrgentBandwidth
+							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
+							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],   // Single  *FractionOfUrgentBandwidth
 							&mode_lib->vba.PrefetchSupported[i][j]);
 				}
 
@@ -3457,7 +3450,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					}
 
 					{
-						double dummy_single[2];
 						dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
 								mode_lib->vba.ReturnBWPerState[i][j],
 								mode_lib->vba.ImmediateFlipRequirement,
@@ -3480,8 +3472,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 								mode_lib->vba.UrgentBurstFactorCursorPre,
 
 								/* output */
-								&dummy_single[0], //  Single  *TotalBandwidth
-								&dummy_single[1], //  Single  *FractionOfUrgentBandwidth
+								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0], //  Single  *TotalBandwidth
+								&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1], //  Single  *FractionOfUrgentBandwidth
 								&mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
 					}
 
@@ -3534,7 +3526,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
 
 			{
-				unsigned int dummy_integer[4];
 				dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 						mode_lib->vba.USRRetrainingRequiredFinal,
 						mode_lib->vba.UsesMALLForPStateChange,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 9ad49ad38814..10ff536ef2a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -196,7 +196,7 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
 };
 
 struct dml32_ModeSupportAndSystemConfigurationFull {
-	unsigned int dummy_integer_array[8][DC__NUM_DPP__MAX];
+	unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
 	double dummy_double_array[2][DC__NUM_DPP__MAX];
 	DmlPipe SurfParameters[DC__NUM_DPP__MAX];
 	double dummy_single[5];
@@ -207,6 +207,7 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
 	double DSTYAfterScaler[DC__NUM_DPP__MAX];
 	double DSTXAfterScaler[DC__NUM_DPP__MAX];
 	double MaxTotalVActiveRDBandwidth;
+	bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
 };
 
 struct dummy_vars {
-- 
2.35.3

