Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD77C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F5B61928
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F5B61928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA7B6EB18;
	Sat, 20 Mar 2021 04:18:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3956EB18
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTIgOj9hj1XpDpTp9A7l8tmYgWu8yoe7tA6crEEOKG2SUSCA+DfVsZydFSpvQQmkreMRVTKmlzcuxdE4mxj8+pt2LXK92uvdmYau7auOVJ32YrxXt3fwrE0x/HzaEx2hRTFxVv9edSjUpfAunh0peTtHHBNRjH5IjBydCVY+ja1RyGC2wjb52xhZe62PkJLh+lspo537r9O2IwAvnSphSbpLHzcaLSw+6kY2YqfN4ISLds9cy1KiCZKptDfyqvYSQRYiq2qWcdYCA/MvkQ+4wyIK7ID7I7eUgOg9fa1oSGdQz8SyS4MjmEXs56AmVsl93+Nq8vo34LLpXVv7YO+Nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222IK2aaxZcyVqVjQvrdUmXWo/gRZ3Zo0JCQbYyzyf0=;
 b=Tk0jvBAuFdTBEQ6wSazba9wNELxTEbTVuVYlX3DmwQjrKTPYm/aR+ciC6Vyu0LNG8x/GKVOZVZ85MZmhc5OEiRYWXP0effXJS601x87cuTRqa5V8+0OXCECS8yahkT5ltnS9nslfIA4+wjbTfW2Cx7QN9Vxa5aoRIa7PpOPSPrGKEb3azOEjwBqBRvEhytINQ/l9IGxt8iDUXIzXs7RLhJ/hY+gbnb6lcgrO/JNfxmiPWACCv4HSAX90rVr5oZcVTF4zparIrdo7c1+9b1wGpfNGiWYtGzwY/F2H84O99vE7B6CENBU1MzbzOrj2SWIsiHJp6dlGNKK74jDQTJ4VIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222IK2aaxZcyVqVjQvrdUmXWo/gRZ3Zo0JCQbYyzyf0=;
 b=UgyoYqp51EjvUJHpKIqWxaXI1HUxa900gasIMonc2EKQp13OvQ/May/CewafsKkVuoCgKwU90c9bhSf/faX0iRcrbaTQ8e7+nYLeWOYNmJYc7JckiYBitc6Tziie1Wr3obhgSCw+tJdkOtizjeQ0P0RC0qPEcqZyYyL6rFRqwrk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:18:48 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:18:48 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/14] drm/amd/display: hide VGH asic specific structs
Date: Sat, 20 Mar 2021 09:46:44 +0800
Message-Id: <20210320014656.23350-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:18:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 879374b5-9e93-4f00-8cbf-08d8eb57425e
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47044C2CD214D2CF47B65CD897679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vKLlwR5jOhqo1zm5o6QfPV5BWEmUZM67PsXcA1vUlAFwbrsOhJeR+H1n1dE5/8srSSDICGDzb6dDxlOwaf8Wes7Adv0H6Sb34sEAZiAo5XlWNm1OJWjyiDngetpFlvEqFC7K09D37hnuU5KXURkhKcs3yJyt6jDv9hmSqQ9BJRoBpO+nKqLxHeD+DWaKR9pgu/Zq2VyYOr338tezmFNPudc9PgFdtfIsJNw9lvHJNmedZ3sv5cn6xVLIE3/w+2TulrS99u6hFafRqDkhBaD+02HmSlhitSyWXHG8wE3PHAA+dJcTFMG23WnCmwd8FRk5fZdGSmEHecoiBybDGJWXZcQaLGcqEivRSywZ8Dyg0Z6W/VfEqmH8Sd1ReZE6UEvtQTEmQXcgDqmlTtfMKx3hLbs5jlrpdZQ0V8+1ECT6Cufeabj0jXuNE4e0M/AXhnIvCCGyxnTj0cQYKIRsK8vUreuv/kY+cQwyso7vUmBk1BGZdzli35l3HFP7FT+e4jb0Bvw+VsCLN72M5yGvQMiqp+MxGbH7RPlTFw2q9yNJEMLkYN6DLoWQuUn9laRy+672MKok3SpIkvFPPGQ9C/JEykku2eqGkc7MXpqqTynEdcXU+5SPoqPG5tM7525fOlPop4DPDRAtVx8CrRHVooqmiPTuMPBUZlzi9vEm1TinAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(30864003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ADxWnYzNaaJkPyo6xj/Zdc3u5PvmW2ubl5CeTeGc7X9xP3vIUID+U6BCVDR8?=
 =?us-ascii?Q?jLrDj2mpLaMgaLV8ww+84E5lUFokBn/a6KOu5bRVVWCT8UCxHT6AvmI1LBXK?=
 =?us-ascii?Q?9uad62i8SpVHBuYGlIOb3QLbyTgTSDNku+epOuMfcP/qz+bdgNbT52VbObZ9?=
 =?us-ascii?Q?7Tr129MYL6ALT8pNNViCWbxSerOAzV+6kTwtR2ocAe9KJkQqfkw9ry5NvyIb?=
 =?us-ascii?Q?R62GSLb811+db2icRrl4vvEEF3tNin310m9I35axZo0MytL/YCK7t4xDOIWJ?=
 =?us-ascii?Q?Z9aiJ2vvSiKn7lLM97d4nr2xXs4efbeqFCd3utRSzqnri40qIx+paYC8TyLs?=
 =?us-ascii?Q?orff0OZsms5dsNmucfT7u1UI72JyijYQpoc4B9jGry0u0CBttciW+KrxxHda?=
 =?us-ascii?Q?ECaey0fiVLTOp/z/RDPV6pgEmTwIIpd0qvf59E74vcMtQ4nYItTvt584Ghe7?=
 =?us-ascii?Q?me9dRLzBRkGWBqIQD7VQxBJxUapHekwFa42KOUppRfLBTxDQwG777lzIhoKR?=
 =?us-ascii?Q?sujxelRZzqrRbAjQpGIGLny6SK5fm9DInIyAyq4Iz32YgdnFckPS9hJ+q1wL?=
 =?us-ascii?Q?iB+Jp7NaLtlRCgNxbf5TdkthXfL81WhR4edtrVBR09s8xl0pW5kwP94tfQYw?=
 =?us-ascii?Q?olomH+s28Jn5Ucj8H0seH72m0gWX+mwxS61n5hRxzQe8rgnOT8TRDF0gmH44?=
 =?us-ascii?Q?PrpWdKv+Gwn3cmFc7QQxt0mB4luOowgr7b37v/7rgGLLDDmsntRgCoPwnklx?=
 =?us-ascii?Q?ZJMQ1IvPtbLB/HneSPV9yAh1AFLrWI+CGHcWQWkWnL11nHZx6fdh2cWvlIYp?=
 =?us-ascii?Q?8gDVnv5aGp8F/82FigK4sCB8xJrM+fc8Cxu2ou+3Y4FL0TOMP8J6MqCL3beS?=
 =?us-ascii?Q?o6yuA8GGwOsPUizfjzLPkWVG/lAIX0CB/JUab3ZQcgfLa50hiSwXnxP4zS1x?=
 =?us-ascii?Q?IwG43YZw9h/73tSfUXIaLrh3zATQ7X4MZoIIngSRTp3MkIAGQ2SZ+Wg6cmRF?=
 =?us-ascii?Q?dt7f1O5bfU2vRgvLuUkAAROzXUSoL/IGBzo6vBqgKyLBsM7+i2He1yEJk3jI?=
 =?us-ascii?Q?VEXQWuPF3UO6TdOCDSPCdUYYMQLP8WZqFuYXBNuY+yl/FxnQIR2Y6rajArDv?=
 =?us-ascii?Q?xEm8iQz6kFkINK7qZAqJHmat1rhM9YBRfqkKg8psVqj2sAOESe1HLNAVrLMp?=
 =?us-ascii?Q?fv9qPOBnSXc6eOo+8C39mqxoMEHedNy67vA2frX7Wn7NsMOoecB1vhhXle3n?=
 =?us-ascii?Q?lHNzi7vhiCFCDcMmn/zLPhiJvosFBJcdLZBbyWG8O47NZEaNXUG7UcNjGu6q?=
 =?us-ascii?Q?YSyalFvAirWGUw7eoXwQ0raJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879374b5-9e93-4f00-8cbf-08d8eb57425e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:18:48.4977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rj2CtA4f7YPzrP0eINWiAL8cfpfAzbUGsqb5W5Pom7a0mFtnkH0SThV89wVTAcmg6BF5g0Ekp8YL+pXGVJU+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

The pmfw structs are specific to the asic and should not be
present in base clk_mgr struct

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 116 +++++++++++++-----
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 101 +++++++--------
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  28 ++---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   9 --
 5 files changed, 147 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index f7c728d4f50a..203150dd37f6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -125,87 +125,135 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 {
 	struct hw_asic_id asic_id = ctx->asic_id;
 
-	struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
-
-	if (clk_mgr == NULL) {
-		BREAK_TO_DEBUGGER();
-		return NULL;
-	}
-
 	switch (asic_id.chip_family) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-	case FAMILY_SI:
+	case FAMILY_SI: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
-		break;
+		dce_clk_mgr_construct(ctx, clk_mgr);
+	}
 #endif
 	case FAMILY_CI:
-	case FAMILY_KV:
+	case FAMILY_KV: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 		dce_clk_mgr_construct(ctx, clk_mgr);
-		break;
-	case FAMILY_CZ:
+		return &clk_mgr->base;
+	}
+	case FAMILY_CZ: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 		dce110_clk_mgr_construct(ctx, clk_mgr);
-		break;
-	case FAMILY_VI:
+		return &clk_mgr->base;
+	}
+	case FAMILY_VI: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 		if (ASIC_REV_IS_TONGA_P(asic_id.hw_internal_rev) ||
 				ASIC_REV_IS_FIJI_P(asic_id.hw_internal_rev)) {
 			dce_clk_mgr_construct(ctx, clk_mgr);
-			break;
+			return &clk_mgr->base;
 		}
 		if (ASIC_REV_IS_POLARIS10_P(asic_id.hw_internal_rev) ||
 				ASIC_REV_IS_POLARIS11_M(asic_id.hw_internal_rev) ||
 				ASIC_REV_IS_POLARIS12_V(asic_id.hw_internal_rev)) {
 			dce112_clk_mgr_construct(ctx, clk_mgr);
-			break;
+			return &clk_mgr->base;
 		}
 		if (ASIC_REV_IS_VEGAM(asic_id.hw_internal_rev)) {
 			dce112_clk_mgr_construct(ctx, clk_mgr);
-			break;
+			return &clk_mgr->base;
+		}
+		return &clk_mgr->base;
+	}
+	case FAMILY_AI: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
 		}
-		break;
-	case FAMILY_AI:
 		if (ASICREV_IS_VEGA20_P(asic_id.hw_internal_rev))
 			dce121_clk_mgr_construct(ctx, clk_mgr);
 		else
 			dce120_clk_mgr_construct(ctx, clk_mgr);
-		break;
-
+		return &clk_mgr->base;
+	}
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	case FAMILY_RV:
+	case FAMILY_RV: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
+
 		if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev)) {
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			break;
+			return &clk_mgr->base;
 		}
 
 		if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			break;
+			return &clk_mgr->base;
 		}
 		if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
 			rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
-			break;
+			return &clk_mgr->base;
 		}
 		if (ASICREV_IS_RAVEN(asic_id.hw_internal_rev) ||
 				ASICREV_IS_PICASSO(asic_id.hw_internal_rev)) {
 			rv1_clk_mgr_construct(ctx, clk_mgr, pp_smu);
-			break;
+			return &clk_mgr->base;
 		}
-		break;
+		return &clk_mgr->base;
+	}
+	case FAMILY_NV: {
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
-	case FAMILY_NV:
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
 		if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			break;
+			return &clk_mgr->base;
 		}
 		if (ASICREV_IS_DIMGREY_CAVEFISH_P(asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			break;
+			return &clk_mgr->base;
 		}
 		dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-		break;
-
+		return &clk_mgr->base;
+	}
 	case FAMILY_VGH:
-		if (ASICREV_IS_VANGOGH(asic_id.hw_internal_rev))
+		if (ASICREV_IS_VANGOGH(asic_id.hw_internal_rev)) {
+			struct clk_mgr_vgh *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
+
+			if (clk_mgr == NULL) {
+				BREAK_TO_DEBUGGER();
+				return NULL;
+			}
 			vg_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			return &clk_mgr->base.base;
+		}
 		break;
 #endif
 	default:
@@ -213,7 +261,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 		break;
 	}
 
-	return &clk_mgr->base;
+	return NULL;
 }
 
 void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index aadb801447a7..b47e3558e176 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -32,9 +32,8 @@
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 
-
-
 #include "vg_clk_mgr.h"
+#include "dcn301_smu.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -50,11 +49,14 @@
 
 /* Macros */
 
+#define TO_CLK_MGR_VGH(clk_mgr)\
+	container_of(clk_mgr, struct clk_mgr_vgh, base)
+
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
 
 /* TODO: evaluate how to lower or disable all dcn clocks in screen off case */
-int vg_get_active_display_cnt_wa(
+static int vg_get_active_display_cnt_wa(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -377,7 +379,7 @@ void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
 	s->dprefclk_khz = sb.dprefclk * 1000;
 }
 
-void vg_enable_pme_wa(struct clk_mgr *clk_mgr_base)
+static void vg_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
@@ -449,15 +451,16 @@ static void vg_build_watermark_ranges(struct clk_bw_params *bw_params, struct wa
 }
 
 
-void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
+static void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct watermarks *table = clk_mgr_base->smu_wm_set.wm_set;
+	struct clk_mgr_vgh *clk_mgr_vgh = TO_CLK_MGR_VGH(clk_mgr);
+	struct watermarks *table = clk_mgr_vgh->smu_wm_set.wm_set;
 
 	if (!clk_mgr->smu_ver)
 		return;
 
-	if (!table || clk_mgr_base->smu_wm_set.mc_address.quad_part == 0)
+	if (!table || clk_mgr_vgh->smu_wm_set.mc_address.quad_part == 0)
 		return;
 
 	memset(table, 0, sizeof(*table));
@@ -465,9 +468,9 @@ void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 	vg_build_watermark_ranges(clk_mgr_base->bw_params, table);
 
 	dcn301_smu_set_dram_addr_high(clk_mgr,
-			clk_mgr_base->smu_wm_set.mc_address.high_part);
+			clk_mgr_vgh->smu_wm_set.mc_address.high_part);
 	dcn301_smu_set_dram_addr_low(clk_mgr,
-			clk_mgr_base->smu_wm_set.mc_address.low_part);
+			clk_mgr_vgh->smu_wm_set.mc_address.low_part);
 	dcn301_smu_transfer_wm_table_dram_2_smu(clk_mgr);
 }
 
@@ -625,7 +628,7 @@ static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_ta
 	return 0;
 }
 
-void vg_clk_mgr_helper_populate_bw_params(
+static void vg_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
 		const struct vg_dpm_clocks *clock_table)
@@ -703,7 +706,7 @@ static struct vg_dpm_clocks dummy_clocks = {
 
 static struct watermarks dummy_wms = { 0 };
 
-void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+static void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct smu_dpm_clks *smu_dpm_clks)
 {
 	struct vg_dpm_clocks *table = smu_dpm_clks->dpm_clks;
@@ -725,39 +728,39 @@ void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 
 void vg_clk_mgr_construct(
 		struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr,
+		struct clk_mgr_vgh *clk_mgr,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
 	struct smu_dpm_clks smu_dpm_clks = { 0 };
 
-	clk_mgr->base.ctx = ctx;
-	clk_mgr->base.funcs = &vg_funcs;
+	clk_mgr->base.base.ctx = ctx;
+	clk_mgr->base.base.funcs = &vg_funcs;
 
-	clk_mgr->pp_smu = pp_smu;
+	clk_mgr->base.pp_smu = pp_smu;
 
-	clk_mgr->dccg = dccg;
-	clk_mgr->dfs_bypass_disp_clk = 0;
+	clk_mgr->base.dccg = dccg;
+	clk_mgr->base.dfs_bypass_disp_clk = 0;
 
-	clk_mgr->dprefclk_ss_percentage = 0;
-	clk_mgr->dprefclk_ss_divider = 1000;
-	clk_mgr->ss_on_dprefclk = false;
-	clk_mgr->dfs_ref_freq_khz = 48000;
+	clk_mgr->base.dprefclk_ss_percentage = 0;
+	clk_mgr->base.dprefclk_ss_divider = 1000;
+	clk_mgr->base.ss_on_dprefclk = false;
+	clk_mgr->base.dfs_ref_freq_khz = 48000;
 
-	clk_mgr->base.smu_wm_set.wm_set = (struct watermarks *)dm_helpers_allocate_gpu_mem(
-				clk_mgr->base.ctx,
+	clk_mgr->smu_wm_set.wm_set = (struct watermarks *)dm_helpers_allocate_gpu_mem(
+				clk_mgr->base.base.ctx,
 				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				sizeof(struct watermarks),
-				&clk_mgr->base.smu_wm_set.mc_address.quad_part);
+				&clk_mgr->smu_wm_set.mc_address.quad_part);
 
-	if (clk_mgr->base.smu_wm_set.wm_set == 0) {
-		clk_mgr->base.smu_wm_set.wm_set = &dummy_wms;
-		clk_mgr->base.smu_wm_set.mc_address.quad_part = 0;
+	if (clk_mgr->smu_wm_set.wm_set == 0) {
+		clk_mgr->smu_wm_set.wm_set = &dummy_wms;
+		clk_mgr->smu_wm_set.mc_address.quad_part = 0;
 	}
-	ASSERT(clk_mgr->base.smu_wm_set.wm_set);
+	ASSERT(clk_mgr->smu_wm_set.wm_set);
 
 	smu_dpm_clks.dpm_clks = (struct vg_dpm_clocks *)dm_helpers_allocate_gpu_mem(
-				clk_mgr->base.ctx,
+				clk_mgr->base.base.ctx,
 				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				sizeof(struct vg_dpm_clocks),
 				&smu_dpm_clks.mc_address.quad_part);
@@ -771,21 +774,21 @@ void vg_clk_mgr_construct(
 
 	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
 		vg_funcs.update_clocks = dcn2_update_clocks_fpga;
-		clk_mgr->base.dentist_vco_freq_khz = 3600000;
+		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
 	} else {
 		struct clk_log_info log_info = {0};
 
-		clk_mgr->smu_ver = dcn301_smu_get_smu_version(clk_mgr);
+		clk_mgr->base.smu_ver = dcn301_smu_get_smu_version(&clk_mgr->base);
 
-		if (clk_mgr->smu_ver)
-			clk_mgr->smu_present = true;
+		if (clk_mgr->base.smu_ver)
+			clk_mgr->base.smu_present = true;
 
 		/* TODO: Check we get what we expect during bringup */
-		clk_mgr->base.dentist_vco_freq_khz = get_vco_frequency_from_reg(clk_mgr);
+		clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
 		/* in case we don't get a value from the register, use default */
-		if (clk_mgr->base.dentist_vco_freq_khz == 0)
-			clk_mgr->base.dentist_vco_freq_khz = 3600000;
+		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
+			clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
 
 		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
 			vg_bw_params.wm_table = lpddr5_wm_table;
@@ -793,36 +796,38 @@ void vg_clk_mgr_construct(
 			vg_bw_params.wm_table = ddr4_wm_table;
 		}
 		/* Saved clocks configured at boot for debug purposes */
-		vg_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
+		vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 	}
 
-	clk_mgr->base.dprefclk_khz = 600000;
-	dce_clock_read_ss_info(clk_mgr);
+	clk_mgr->base.base.dprefclk_khz = 600000;
+	dce_clock_read_ss_info(&clk_mgr->base);
 
-	clk_mgr->base.bw_params = &vg_bw_params;
+	clk_mgr->base.base.bw_params = &vg_bw_params;
 
-	vg_get_dpm_table_from_smu(clk_mgr, &smu_dpm_clks);
+	vg_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 	if (ctx->dc_bios && ctx->dc_bios->integrated_info) {
 		vg_clk_mgr_helper_populate_bw_params(
-				clk_mgr,
+				&clk_mgr->base,
 				ctx->dc_bios->integrated_info,
 				smu_dpm_clks.dpm_clks);
 	}
 
 	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
-		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				smu_dpm_clks.dpm_clks);
 /*
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment) && clk_mgr->smu_ver) {
+	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment) && clk_mgr->base.smu_ver) {
 		 enable powerfeatures when displaycount goes to 0
 		dcn301_smu_enable_phy_refclk_pwrdwn(clk_mgr, !debug->disable_48mhz_pwrdwn);
 	}
 */
 }
 
-void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
+void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
 {
-	if (clk_mgr->base.smu_wm_set.wm_set && clk_mgr->base.smu_wm_set.mc_address.quad_part != 0)
-		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
-				clk_mgr->base.smu_wm_set.wm_set);
+	struct clk_mgr_vgh *clk_mgr = TO_CLK_MGR_VGH(clk_mgr_int);
+
+	if (clk_mgr->smu_wm_set.wm_set && clk_mgr->smu_wm_set.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr_int->base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+				clk_mgr->smu_wm_set.wm_set);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
index b5115b3123a1..7255477307f1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
@@ -25,29 +25,25 @@
 
 #ifndef __VG_CLK_MGR_H__
 #define __VG_CLK_MGR_H__
+#include "clk_mgr_internal.h"
 
-int vg_get_active_display_cnt_wa(
-		struct dc *dc,
-		struct dc_state *context);
+struct watermarks;
 
-void vg_enable_pme_wa(struct clk_mgr *clk_mgr_base);
+struct smu_watermark_set {
+	struct watermarks *wm_set;
+	union large_integer mc_address;
+};
+
+struct clk_mgr_vgh {
+	struct clk_mgr_internal base;
+	struct smu_watermark_set smu_wm_set;
+};
 
 void vg_clk_mgr_construct(struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr,
+		struct clk_mgr_vgh *clk_mgr,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
 
 void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
-#include "dcn301_smu.h"
-void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base);
-
-void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
-		struct smu_dpm_clks *smu_dpm_clks);
-
-void vg_clk_mgr_helper_populate_bw_params(
-		struct clk_mgr_internal *clk_mgr,
-		struct integrated_info *bios_info,
-		const struct vg_dpm_clocks *clock_table);
-
 #endif //__VG_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index e62f931fc269..7123151ed60f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -55,7 +55,6 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "virtual/virtual_stream_encoder.h"
-#include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn20/dcn20_dccg.h"
 #include "dcn21/dcn21_dccg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 3a29f379d0c8..4e94f2dec572 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -264,14 +264,6 @@ struct clk_mgr_funcs {
 	void (*get_memclk_states_from_smu)(struct clk_mgr *clk_mgr);
 };
 
-struct dpm_clocks;
-struct wartermarks;
-
-struct smu_watermark_set {
-	struct watermarks *wm_set;
-	union large_integer mc_address;
-};
-
 struct clk_mgr {
 	struct dc_context *ctx;
 	struct clk_mgr_funcs *funcs;
@@ -283,7 +275,6 @@ struct clk_mgr {
 	struct clk_state_registers_and_bypass boot_snapshot;
 	struct clk_bw_params *bw_params;
 	struct pp_smu_wm_range_sets ranges;
-	struct smu_watermark_set smu_wm_set;
 };
 
 /* forward declarations */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
