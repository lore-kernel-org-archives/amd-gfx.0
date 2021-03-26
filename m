Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC1C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A915B61A2A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A915B61A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2585A6F4B8;
	Fri, 26 Mar 2021 22:06:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE356F4B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuXw7YCabIXK3YYIlwOsP0yD0d4M2r2LWHu3Uidx4EZNdVIsweFH3/MKXZHSSlEBZesf03tsXKHjk6dMoXzqdBOVjljBlikin+rPpQdAf/ms3dSyBMePtvUrH+tJroLWfwWP25LW6xEmACbWHd22tKQC58XbQmd2FRLvI83Sj33zcZG5j1zj9dImwo1RWdearYkTm/PqR8o1v6N055cEetgTPSz4UAFZ5hY7DvEWiJvE87sThiGLptSW+i44QN5bgESO+nfEy0sxMoUjqWymTE9n1c6mPdLstjuSwtZB3IkUqJDb9G0UgftNvs1wR0BWSp31atSYjeMivdjZyOfcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ+gqh0t7kynpy4k+fs0fdQco0reqHTnOdHNS4srXWw=;
 b=XgbR/g35d2RmhNNDSj/mOH1/QEjjx8N47IPuZ8gONuy1U0Whd3hNC3K592eZUf8+51Hxc4DB/PPwhmwhMM7LMdyRcDukVjAajFACtuBYLlPdMPNZNDK61Yfq3LF5wIvKe3dlY/m84iZUnBWgk9Gr4SHi9drXFVSH0RpqKfHegrOnaam1l154f1jssNIbxbvG3/UmBtdz6RVLmySZpke+fblYe5BhIvgjErmX5VzS4C1BcpDtVPP8ucKWXfpYwMbBJqIxYba3DXzddUwkaKwtiHaQRS+QY3iPpyrV9Tx9cVWAmWyuHBVzsE/PKjVHwTJxdLO//sAtkBOO0XV2af+7kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ+gqh0t7kynpy4k+fs0fdQco0reqHTnOdHNS4srXWw=;
 b=hrlrHGtNcoXqnziaTEMCPWkCazGDz03TyZBCWNp6Tle3Cq50nekYVz+c3AoZ4YbwJ51wE6d9z+ylR6ikeIqyb0i2XhhnZiGdYXEw/VgvU9PRNZwnWqsvladrjVkUkmcEps0pRF8fCUzgI8v7di5cAkUoimOv4mKOP479V7lZuIw=
Received: from DM5PR16CA0035.namprd16.prod.outlook.com (2603:10b6:4:15::21) by
 DM6PR12MB2923.namprd12.prod.outlook.com (2603:10b6:5:180::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 26 Mar 2021 22:06:04 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::94) by DM5PR16CA0035.outlook.office365.com
 (2603:10b6:4:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:02 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:01 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: Interface for LTTPR interop
Date: Fri, 26 Mar 2021 18:05:23 -0400
Message-ID: <20210326220534.918023-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15922451-5ec9-436a-b082-08d8f0a358d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29239E86ADB9DA3D18631823EB619@DM6PR12MB2923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnmTQhxlfdF4sPDOediBqOQmDLX0nXm6qFsvOlhh/YjoccGLWddi827fIxC+vw16X/nu3jdTT1ssiCrXe5hNVDN53vf5CM+AiF8E2pa2Ml6l27E1xf7xHtsNXsOkr/ksQ/KFCs+4y8ghA5e57n7HYL3EKfk1rAnr3SMivtKUiraZl6hf8o2uDWX0mkOJ8cJ1wbEpF4Fk0dirZpwAl1YlvXBFDT7+EU1h4KMtCoyqH1X+/0w4xt3FzDw/Pu4ufhL/kOALYVIv4ZsA7sAK3+IOFYTqQpMrUPOiBeAL5AwP7kUM+aBmSIB5ZlxXGWhcYmiLH1VIW+QMdNppQ/HWToz8Vzb+UuNO0zV8V57PHh1mMa2aG795V4F6X3JbMZxMsaChsot7eQlOV3cx4Mk+m48e/sBl+piovmkdRBXjmheM5P8PxYme0s+aHJUyJqYvbMGJSElm9K3GEX5S8vEuxqZtkxGvK/qSUPnkMLOXvGcobEkztyg2QCXXXlBAsAXAyIGRL0aDfQh1codbWtW5sbOVbcQdB7nGFcQ808ZeoR2Q25XYTbxaZbqL+i6JPgZXQkY/MJBmvgqUyTg21DC2QV54V3q7wvq7MLsbWOVVjTXOHIx5fLcncYFbJRM76M6EGjxQ05EYL+Bc5X5Mrsi1VX5UMX3wo1gvTlMGQSMG+A0jRwuZu7bSn0sEehcBaCHCmVEr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(54906003)(26005)(4326008)(86362001)(6916009)(356005)(186003)(7696005)(316002)(81166007)(1076003)(5660300002)(478600001)(8936002)(82310400003)(6666004)(47076005)(8676002)(36860700001)(426003)(2616005)(82740400003)(336012)(70586007)(70206006)(2906002)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:03.2796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15922451-5ec9-436a-b082-08d8f0a358d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
The logic to toggle LTTPR transparent/non-transparent requires 2 flags
provided by BIOS

[HOW]
Repurpose the interface to get dce caps so both LTTPR querying functions
can use them.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 75 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  3 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |  1 +
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 2ee0c6fc069a..d79f4fe06c47 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -916,7 +916,7 @@ static enum bp_result bios_parser_get_soc_bb_info(
 	return result;
 }
 
-static enum bp_result get_lttpr_caps_v4_1(
+static enum bp_result get_disp_caps_v4_1(
 	struct bios_parser *bp,
 	uint8_t *dce_caps)
 {
@@ -935,12 +935,12 @@ static enum bp_result get_lttpr_caps_v4_1(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+	*dce_caps = disp_cntl_tbl->display_caps;
 
 	return result;
 }
 
-static enum bp_result get_lttpr_caps_v4_2(
+static enum bp_result get_disp_caps_v4_2(
 	struct bios_parser *bp,
 	uint8_t *dce_caps)
 {
@@ -959,12 +959,12 @@ static enum bp_result get_lttpr_caps_v4_2(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+	*dce_caps = disp_cntl_tbl->display_caps;
 
 	return result;
 }
 
-static enum bp_result get_lttpr_caps_v4_3(
+static enum bp_result get_disp_caps_v4_3(
 	struct bios_parser *bp,
 	uint8_t *dce_caps)
 {
@@ -983,12 +983,12 @@ static enum bp_result get_lttpr_caps_v4_3(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+	*dce_caps = disp_cntl_tbl->display_caps;
 
 	return result;
 }
 
-static enum bp_result get_lttpr_caps_v4_4(
+static enum bp_result get_disp_caps_v4_4(
 	struct bios_parser *bp,
 	uint8_t *dce_caps)
 {
@@ -1007,7 +1007,52 @@ static enum bp_result get_lttpr_caps_v4_4(
 	if (!disp_cntl_tbl)
 		return BP_RESULT_BADBIOSTABLE;
 
-	*dce_caps = !!(disp_cntl_tbl->display_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
+	*dce_caps = disp_cntl_tbl->display_caps;
+
+	return result;
+}
+
+static enum bp_result bios_parser_get_lttpr_interop(
+	struct dc_bios *dcb,
+	uint8_t *dce_caps)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	enum bp_result result = BP_RESULT_UNSUPPORTED;
+	struct atom_common_table_header *header;
+	struct atom_data_revision tbl_revision;
+
+	if (!DATA_TABLES(dce_info))
+		return BP_RESULT_UNSUPPORTED;
+
+	header = GET_IMAGE(struct atom_common_table_header,
+						DATA_TABLES(dce_info));
+	get_atom_data_table_revision(header, &tbl_revision);
+	switch (tbl_revision.major) {
+	case 4:
+		switch (tbl_revision.minor) {
+		case 1:
+			result = get_disp_caps_v4_1(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE);
+			break;
+		case 2:
+			result = get_disp_caps_v4_2(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE);
+			break;
+		case 3:
+			result = get_disp_caps_v4_3(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE);
+			break;
+		case 4:
+			result = get_disp_caps_v4_4(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE);
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
 
 	return result;
 }
@@ -1031,16 +1076,20 @@ static enum bp_result bios_parser_get_lttpr_caps(
 	case 4:
 		switch (tbl_revision.minor) {
 		case 1:
-			result = get_lttpr_caps_v4_1(bp, dce_caps);
+			result = get_disp_caps_v4_1(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
 			break;
 		case 2:
-			result = get_lttpr_caps_v4_2(bp, dce_caps);
+			result = get_disp_caps_v4_2(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
 			break;
 		case 3:
-			result = get_lttpr_caps_v4_3(bp, dce_caps);
+			result = get_disp_caps_v4_3(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
 			break;
 		case 4:
-			result = get_lttpr_caps_v4_4(bp, dce_caps);
+			result = get_disp_caps_v4_4(bp, dce_caps);
+			*dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
 			break;
 		default:
 			break;
@@ -2670,6 +2719,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.get_disp_connector_caps_info = bios_parser_get_disp_connector_caps_info,
 
 	.get_lttpr_caps = bios_parser_get_lttpr_caps,
+
+	.get_lttpr_interop = bios_parser_get_lttpr_interop,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 1b957c60156b..67abda44eb1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -153,6 +153,9 @@ struct dc_vbios_funcs {
 	enum bp_result (*get_lttpr_caps)(
 			struct dc_bios *dcb,
 			uint8_t *dce_caps);
+	enum bp_result (*get_lttpr_interop)(
+			struct dc_bios *dcb,
+			uint8_t *dce_caps);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 82b3cd89b383..c77ed38c20fb 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1079,6 +1079,7 @@ enum dce_info_caps_def
   DCE_INFO_CAPS_ENABLE_INTERLAC_TIMING   =0x08,
   // only for VBIOS
   DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE	 =0x20,
+  DCE_INFO_CAPS_VBIOS_LTTPR_TRANSPARENT_ENABLE = 0x40,
 };
 
 /* 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
