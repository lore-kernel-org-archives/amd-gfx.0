Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 04:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE6C60230
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 04:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE6C60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E2D6E19C;
	Mon, 22 Feb 2021 04:03:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B0F6E19C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 04:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnvId16qSzjb7C/hZX7mTL12Dqlgnk5NrTEYe0JlYQY/6sIrc/3WUey5nQVFHi/B8hsEiXeRK4PyHZs4U7cXqmZ/1Mvqr5YuciQlCXTYVpUYPUqu98YkSnkEhsKHx2SF3oemiqI3SDYjLFwaot4H7l+cN1ebzcD82PLBXrXqROYsmKT3I8Xg+FG2jB9KrKl4eN6NK+wFeaWZ/diP7GxkzJ/ctkvsWalb66bejDyhbO/qEnbwLMyjuBaEcOdrfTsEaeF8asDsXKGytsSuERG+IcYQ+XoskJD4tzpouqzpvSBkCepb7U77CVcxYPOsc0WFo2PN6QiGNZrk6ZckwxzEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfq9wBZyxvj9IyJUBQ4JBCfJLCJwGoraycvhn3n7DXY=;
 b=CsuplY99orP0JgUhatwTISQDaP7o32O40uuVitr9KPbxLbNVVetT119UCw+yLd0R7vyzG74wy8IWslrqm98p2rX/vkY6+CJj8VqM6gyOA8CMzEFN1xZgc723NUF3noQAL7hDPfGF6XsXPnL1CJn2c/sCRdigGIcl0q8IOChhIlhB71wWa2DJn91h0GKT04oElCoWp80hJR0wz0nBNizbDHkRl3ZWS+HMtXEcAvIb7ULnPUuwHZQGM40HZzHQf/LRAKWA7uHCX7giti+VRue0y8A5p2sgBkiW63f09XqQYDk4jPmK+PQ0D5yymlg3qblpfhXN6d+FGlvq7WKX+hyLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfq9wBZyxvj9IyJUBQ4JBCfJLCJwGoraycvhn3n7DXY=;
 b=pb6JIND+KPaw6LcHLYVy6pHD14KMloBUP5RK61Xn3qYlfsbU4N/8D+zUqdgNsgiAznI7oP5Bz793FF/YGWBucMIbGJsmp+X7m3LIKhF0AlgLEUWXzCcWDFPiYUBK47EBZUYW6cOpfSyyTXQ59LEfLMhDU8ISB+UGvGQoTf+Gl3k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Mon, 22 Feb 2021 04:03:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 04:03:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: correct gpu metrics related data structures
Date: Mon, 22 Feb 2021 12:03:28 +0800
Message-Id: <20210222040329.1280956-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 04:03:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a579414f-fa15-48a8-0e25-08d8d6e6dca8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124BD06E40AD4A794E0E2DAE4819@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oj2/QI1vC5BccdIc558x1LI0AMzBFpbtTdXNs1L17LejfhJ34zQqxht/nAKvtiXhfbwo0HQv2QBs6ZTUrthMkfaPDdm8xBiL0lSlPRidmA3hKd9ZrDxEq2gkqMbXvZPEMZAR5rVrgLGfobs2jk1zUZi4BhWPGv3l8bM9tjpFqx4xrHTBfU0cJMqSdRVCGqZOTtZdimUZ1wiehF/VDMvQIGLX85WMfTyDeYx4uKVUyZG/lSgacWQ+Ig0gdnBAZ7btpiug/aPrG+cfyt3N2PTwPlyIwZbcEMMowQFEKDhcSMyGKXrVQVf8hcYMDyvHZeZ5PcGyLyC/NHr4leWysUHwe8V+s6jhWxw1cD/8tb2ohBPJFPS58A/i6Jig0jjOHthpzrOnlyK6ds9rreG5eTChbX5KJ8dvFmR2yuqBPqVD5bNR2OG4TXDLsq1mPqtWK4xVRGt/Y5/gRwHY86fpgVuXO6fWYta+8EYEL3SGz4o2o4DCAtO+x4htHuOn+iz2EFJKjXXJIoKDKbSyWRqc5SpLCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(2906002)(8676002)(6666004)(8936002)(5660300002)(478600001)(1076003)(6916009)(66556008)(4326008)(66476007)(6486002)(36756003)(44832011)(316002)(86362001)(956004)(186003)(7696005)(66946007)(26005)(52116002)(16526019)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dVytJSuRY3XU3sJsEB0Sy2Kt/42J8d5kxXqeBQUA4bque8hpdUAEAFacjISr?=
 =?us-ascii?Q?14Hajok7WtMWg2GfFxRKyJBzCJlLvZlPkEzLD+pws+vpO0AGpHHurNjnrqBS?=
 =?us-ascii?Q?T0EUWWUPRdYbUiJFuwJCttHUCGAIZnjCZTrsY6Kw+oC1SiilCitLIe1ItaAd?=
 =?us-ascii?Q?A+GjwDl5vzJeeBQtP8u8FM3bESjrO9jQ//AzvLLmUZM+4fpPEpFwz7Ust22Y?=
 =?us-ascii?Q?KeaS2udknIZ+j8ycMf0F5TajDCcBB82401bGceXt7Z5LOGbPLFwHLuPk9y/n?=
 =?us-ascii?Q?lWONacuzMJfnf0zZVeBopzVkDMdACbhYKP9wqKeDrwv23etuFTaLz1iVeEVg?=
 =?us-ascii?Q?2M+zqKfJvH4D7L1s+t1sX9cMKQD29kG/gaUGUiXZ0HtJ5AB4ZNEywNNgUVJ0?=
 =?us-ascii?Q?dbGZedL3hcEdYNG2rm/9kuaMNAg5oAuP3w8QsThJ4oX6bSFZv1tXEYeCM206?=
 =?us-ascii?Q?mcmTGJpHcK4+5HEqqMlIkkYPCwtSYovfKHllXTQJjCpGN+s28doANZrLzH43?=
 =?us-ascii?Q?CdmTEWhO4KbM/5NeYfbYSzx+DptSsQF6RK6+QnfgD1xDBYZqUUI8tTGZT1IY?=
 =?us-ascii?Q?mzbMqfMEX2GXAtD7Pw0RnFf+S5HeEYfD4I6MjNrIiqYqE2OnpWEIKHaqi1F2?=
 =?us-ascii?Q?/vQ93Fob3NCmCr//iMX20Yd6b3Y5WA8GOPP60Kzw9J5jjWd6+Iw4qCmCvKVu?=
 =?us-ascii?Q?KE/xXUiBaAEnP3TgxwleVSWJzcE1pAGpPEwOR1C21UoWhdGRWY5HnZ3sap+v?=
 =?us-ascii?Q?7kzR3gOVHTPTzdunt11ukVZnGfT1KQVaAwniVF90QHuKfQcQoTK25zt08Uk7?=
 =?us-ascii?Q?Cy5QJyu3RBmNpcjgwlg3YVxtr2af2aXk13rqVCv+xbO9YTF/l3XYUpc92Q6i?=
 =?us-ascii?Q?fyqy5lBAZtFH6YkrqANXMBTgyaTxU+cWHnBhJd4QIWYmUOfsb2GrZfXswf+q?=
 =?us-ascii?Q?JmZco6dpf66t8EEpZFaw8SVTpsjjpMWrFtJu7+raEQM4vHj1SiO6OamJr/UI?=
 =?us-ascii?Q?SOogpFU1xLREC6LGqYZdEYddTP9nxIPu+KaO4AgfwYs+cAdy1GYKeE1VH6ES?=
 =?us-ascii?Q?XhxEouDTywLLpjk3hMmClNt81+J8pwmPXiBO3Il9sVDT9x3FVVzuYsJWW8P1?=
 =?us-ascii?Q?n+MS8zvml98y/qi3eP0nF4tX2nOANYP2HzpcuQi7il3ECi74LspYIwd0ocDo?=
 =?us-ascii?Q?bwTRINGV0Tg8YENZJQedazTq8kVUwADtBEd89tbC1K72mCRQKZ3vuq2Bhm4x?=
 =?us-ascii?Q?O/yhOMjGxdaxqFx/RXROljvfd6pPvqsqkH1bHIOJ4KW+bH/2HmAJhByjkNoY?=
 =?us-ascii?Q?Pq8Fvcdx+S2lDQ/WRVZ0gLHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a579414f-fa15-48a8-0e25-08d8d6e6dca8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 04:03:50.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZlNM2qbitC6iboyHckXPygXM25IqyKoX27vrzshBRpXSSC1qsE2U7LOxkeLim4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make sure they are naturally aligned.

Change-Id: I496a5b79158bdbd2e17f179098939e050b2ad489
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h        | 11 ++++++-----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                |  4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  8 ++++----
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 828513412e20..3a8f64e1a10c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -332,9 +332,9 @@ struct amd_pm_funcs {
 };
 
 struct metrics_table_header {
-	uint16_t			structure_size;
-	uint8_t				format_revision;
-	uint8_t				content_revision;
+	uint32_t			structure_size;
+	uint16_t			format_revision;
+	uint16_t			content_revision;
 };
 
 struct gpu_metrics_v1_0 {
@@ -385,8 +385,9 @@ struct gpu_metrics_v1_0 {
 	uint16_t			current_fan_speed;
 
 	/* Link width/speed */
-	uint8_t				pcie_link_width;
-	uint8_t				pcie_link_speed; // in 0.1 GT/s
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed; // in 0.1 GT/s
+	uint8_t				padding[2];
 };
 
 struct gpu_metrics_v2_0 {
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 50dd1529b994..f4e7a330f67f 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -284,11 +284,11 @@ int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 
 int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu);
 
-int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
-int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c0753029a8e2..95e905d8418d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -52,8 +52,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static uint16_t link_speed[] = {25, 50, 80, 160};
 
 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask);
@@ -2117,7 +2117,7 @@ static int vega12_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-static int vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
+static uint16_t vega12_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
 {
 	uint32_t width_level;
 
@@ -2137,7 +2137,7 @@ static int vega12_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
 		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-static int vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
+static uint16_t vega12_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
 {
 	uint32_t speed_level;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 87811b005b85..3d462405b572 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -57,8 +57,8 @@
 
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static uint16_t link_speed[] = {25, 50, 80, 160};
 
 static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 {
@@ -3279,7 +3279,7 @@ static int vega20_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-static int vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
+static uint16_t vega20_get_current_pcie_link_width(struct pp_hwmgr *hwmgr)
 {
 	uint32_t width_level;
 
@@ -3299,7 +3299,7 @@ static int vega20_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
 		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-static int vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
+static uint16_t vega20_get_current_pcie_link_speed(struct pp_hwmgr *hwmgr)
 {
 	uint32_t speed_level;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 60ef63073ad4..86af9832ba9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -99,8 +99,8 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 #define mmCG_THERMAL_STATUS_ARCT		0x90
 #define mmCG_THERMAL_STATUS_ARCT_BASE_IDX	0
 
-static int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static int link_speed[] = {25, 50, 80, 160};
+static uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
+static uint16_t link_speed[] = {25, 50, 80, 160};
 
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
@@ -2134,7 +2134,7 @@ int smu_v11_0_get_current_pcie_link_width_level(struct smu_context *smu)
 		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
 }
 
-int smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_width(struct smu_context *smu)
 {
 	uint32_t width_level;
 
@@ -2154,7 +2154,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu)
 		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
-int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
+uint16_t smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	uint32_t speed_level;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
