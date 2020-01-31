Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9CC35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0212082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bC0Bbda9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0212082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE25B6FC37;
	Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578606FC34
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrhoKePf+QdJI7ntiwTwDNcYMe0MB6T6Dc3CXYzlknSDz1jEQj9qoq/AzVe2QcujFrMeFuGCYNrfJDAZJT7ZROarLq6JkwswrUAMkHbn6bN7LuJK1CDVi/exp+2xhPcQ6fMny7gyVNdpu6ehbNrlZyal5BvZfusQ7y9DfQzxAiMDXoT0Hg5DhnPTbqic5i2ZZwf7YkAXWR/iVMEv2fkVlvVGrYXUB+AhcnFx2kh8/RuXAZhCBiGS6n8ntuixdnbhIxvO4FVf1CFPaW8J32KwoIUWSECsGEGV0FWu4XcTCetFJiQ8MAuvP/AAFzf8V+pgmhfmrIAnDn2mbaF2KGc0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gcwwc4J5Z5rB3Ritux11m8PRE7FNszD1MJ2XwMbmVc=;
 b=nHhFVXikvOwPUpH/TWA8/+rZMAYD4ySpuWSnfbEGFsrzNyLf8UfzPX9i3eRAZgAZcGOajRXCZRC9esP3OKwISupKWSeOjHW0J/D7Jh/REBTFmaXZZ5qpad9iBbw2Axvnyn0l2Pb3jF+Z7KKU4vs9rPdIRhJ2PCtRh7kUUWuh7LhAD09hH+GpGe4DWk7TNN0tnmjBOCluRCpmcrWhIGeUte0IBqVvf6wl2FfPNeOcc0f/tvSb2Dy5LnXvM+OYB8CF6XM+oHw7n7qwauwIvLtX7OOa3OAmVrDgIJIyetTlG6W/hs2zDcZg5HTOSzszyewnULqrrRKSVxQnQsWuM7UTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gcwwc4J5Z5rB3Ritux11m8PRE7FNszD1MJ2XwMbmVc=;
 b=bC0Bbda9oLKmZ+PiFINmSV2P+F9I61aRglENxo8L4dDRIs7bVNl6zaEJTNqC7NK7AV+LDJhzPbxAX+5h2wyqrEjZSaQTZwDJMKPpxbL0tYZ7j/UBpNDZEJ+47EKcyFBbCHWUbvNvxswXxgkHA50NElSx/a/dB1gFryNtS0vG/zo=
Received: from DM3PR12CA0081.namprd12.prod.outlook.com (2603:10b6:0:57::25) by
 MWHPR12MB1871.namprd12.prod.outlook.com (2603:10b6:300:10b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:09 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by DM3PR12CA0081.outlook.office365.com
 (2603:10b6:0:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:08 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:03 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:03 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Fix various issues found by compiler
 warning as errors
Date: Fri, 31 Jan 2020 17:16:18 -0500
Message-ID: <20200131221643.10035-9-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(199004)(189003)(2906002)(70206006)(478600001)(36756003)(81166006)(81156014)(70586007)(8936002)(54906003)(316002)(8676002)(356004)(4326008)(7696005)(1076003)(5660300002)(2616005)(336012)(426003)(26005)(186003)(6666004)(86362001)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1871; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06cb7f1-9002-479a-1ea8-08d7a69b4ff1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1871:
X-Microsoft-Antispam-PRVS: <MWHPR12MB187171C986A604F2CB0E5A59F9070@MWHPR12MB1871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMMnHVtLJ9tkVtKKb/pmkud8ijuDmQtCVhHg8Yp9GSdcwl0AWKhi28qPuBR9Z8wDcFB2YRTQ9QPqOM7Uakr5NKq37anFS65g0gZ7czSJ8OCizGL0gPgagKNpS7fGHz09MGhja5tucqDLJFLFf8iDBRXl3wWYQpFPavApjV8MqJBo6RRnniI7UMtivMBpmQS4PD26C2/cryFBVgq8BxN0RAqQMMoW6o5MUNTgvbW/ZY2KrwAlFhsjftWXxIabABHXa4WtIqHyFoFxkRbG1CPHPjVIqyv7STJb/3QewOggS0D5pdiPXsD0RizM79bmuXw5DS5vyYf6+0mI9V0QkNhRMvRNVr+XRX2tTm5Sxl++ITytc1CZohu5ZHseA/Fy5WByfD49twuOZBaD7bsuAs0ueQqIVBvjEiQVJyhckZq4DVvltIaupEsn3WNNgXmDfGww
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:08.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06cb7f1-9002-479a-1ea8-08d7a69b4ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Diagnostics team reported various issues found when enabling warnings as errors

[How]
Fix implicit conversions

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h               | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8ff0f5b7104b..07b9aa1d01af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3681,7 +3681,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			struct pipe_ctx *odm_pipe;
 			enum controller_dp_color_space controller_color_space;
 			int opp_cnt = 1;
-			int count;
+			uint16_t count = 0;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 658f81e757e9..1f5446321112 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -189,7 +189,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int min_vblank_lines;
 	unsigned int dppclk_delay_subtotal;
 	unsigned int dispclk_delay_subtotal;
-	unsigned int dcfclk_cstate_latency;
+	double dcfclk_cstate_latency;
 	unsigned int dppclk_delay_scl;
 	unsigned int dppclk_delay_scl_lb_only;
 	unsigned int dppclk_delay_cnvc_formatter;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 459f95f52486..f30ab4916242 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -25,16 +25,15 @@
 #ifndef __DC_DWBC_H__
 #define __DC_DWBC_H__
 
+#include "dal_types.h"
 #include "dc_hw_types.h"
 
-
 #define DWB_SW_V2	1
 #define DWB_MCIF_BUF_COUNT 4
 
 /* forward declaration of mcif_wb struct */
 struct mcif_wb;
 
-enum dce_version;
 
 enum dwb_sw_version {
 	dwb_ver_1_0 = 1,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
