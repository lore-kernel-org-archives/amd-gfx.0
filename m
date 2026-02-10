Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D82EA811C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD23710E57F;
	Tue, 10 Feb 2026 13:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ec0FrtPg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E3D10E57F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8D2sJSb/87JJiEBTR4PLwZX6vAS2X5FOCza/ImkzAq/zEH2wM6fv0IH8AZTMZwfBnNVNAV5CAQoNxx0dTxH7ZzTlv7Ak90QHoySAcoAf9u8hMpXXh2/RbydNlwEb8FIc+ugI1rJowXXNT+ZoTjuq0ZHi0ZcIcWmtmpDVE7E3hwCPpAVDVNdGg3p2H8b2fefkPn398seT/hb0O+0gm87+QMUr7JpIdMHCcf+F6RCR1XyBUMQV7NHHFZK9l3yNgYELJxSeCaH1zZrUqRCYsUTONyUmd9WKQGSAWa0u61FX1vl0NzIGCux+t9VD/s97RTZvKV2TMtZVjnmVRmOQzQQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWEQlrLxUV8GYWE2Q5gmWTitx/WEpClumWE3m7+8Dmw=;
 b=cx9CVLZmgzzCqRhID1JsWito4i5c+aJOOaEQ3WY7TlgXEqh5pWzguAS0XlprSuWX/+WiQJj5mMz0JRLXvhGdL1qjH0ZLRgV99feM0Op+wcKar57RaRM9CBVq3Q1kRG9Kb3byDJWMi6OMQ59YMr3tmV0I4Zit3zysn7TohMc6Dree42TztgVnEdUoPwOtaVlfSqIjzHYMUknrsrPBQHn+d/ODZxaVU82ZSvwbeOpKqHF/UU48GVpbhTgRGzk1RavYxYe5GzMUoob6ayAMv2p7tuKK3A5+0FfQXBacZl/BX1ScMOu/9p5o9rvl5CfUNnTxDfxka7lxGvq0CPdoQiv/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWEQlrLxUV8GYWE2Q5gmWTitx/WEpClumWE3m7+8Dmw=;
 b=ec0FrtPgYgl4nVK0UjXcSaU215LRoZc9LzH0XKu30juOCGDBmb/uY1ujSdlXfIEa4vMUCflPB5oONDBppmo7hARY23pK5snk2ET78vjZ77T8r6RCGIoGoKJFl2lWXEn8pKqV9TqtRKCkoqW87hp4gmxj3bd6S8oMhHjJiWcOGJY=
Received: from CH2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:4e::27)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:54:52 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::16) by CH2PR02CA0017.outlook.office365.com
 (2603:10b6:610:4e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:54:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:51 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:42 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 04/18] drm/amd/display: Expose functions of other dcn use
Date: Tue, 10 Feb 2026 21:49:57 +0800
Message-ID: <20260210135353.848421-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 170a7d73-d61a-4693-640e-08de68abf674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CjpzvzTqyXlXlbsH/wkbsK8SdLuAT0BndIYCuDLUep9wPVTzCASXzx/piaHm?=
 =?us-ascii?Q?41BkcWw3stJHaVIJnWzAU0buZ3msVlbfRMZzIHBG0/trP8FE6V6d0WarCe1h?=
 =?us-ascii?Q?7IzV243311HUFnX37nkDl5HtWcYxWxNUKDvtmkrBc1VSTFd2HAWXNMt8vNO2?=
 =?us-ascii?Q?I2h8u/4Zi3hI6EmnId5Jd/QwWqhf+XM9Fgs4EldgMu2mCVU7O/ZRM6DZabKA?=
 =?us-ascii?Q?6LTKYY/oWFnd/ItlzyvhkNYpF+WZqwtSY5xPO/kNzhIVgkAe6fA+LXN+JuVs?=
 =?us-ascii?Q?3Jf5eElL8iAbvAd4YuZUCs7k/SRhnQ6WXIag4a1woEIOTxBayRQFzZ4uRlHZ?=
 =?us-ascii?Q?8+ZbKNXbrSZIDHPVhPkZDwHWCl9X1dtxVAvK4CTHNMMxmrK+NZcZJk8to22s?=
 =?us-ascii?Q?O2Z340J5/gR85DggxooV38JeBIE6hFdMMyvVtKG1IOUUccaeVd4s7YLDTYcu?=
 =?us-ascii?Q?Y8pujESPK0+FgXTWTWd6vV6cuasXEUs9yUg6BDIDEb8x3PIBmpWjgozZ5gUM?=
 =?us-ascii?Q?2+1j8tO2lk9+8sn/TTWYMYslHufjqu5oAiT+A+0tF3HdUR7rdJ5AbjVr8BmI?=
 =?us-ascii?Q?N9HqWLytwQQEXUb3K4xQ8ARBzs7OdtQ+BBDL1rRYo4jHpdpeeMuJC6niResL?=
 =?us-ascii?Q?Vk11hgnvkuUdaaVuKwLaqbyXbIauAYtRs9GsA2bkg1MXZXMNyinArnmvp67n?=
 =?us-ascii?Q?jEU6BMsgYSvS3OJ5idoy4RnxEE2rqSrJCjHinvKOiz5tsmjRQKNOGI4BNc9c?=
 =?us-ascii?Q?XA96sG9XFYFvkTD5UswD+oonv6uuoi7AiUldJ+t7pfImvSQi3lZSNtnpCeRf?=
 =?us-ascii?Q?y8v6CCZRnGTe5HOy/WuKvGn0igJ9eYe+FSbm6YriediIa9pdsHtZEK7Rt8Zi?=
 =?us-ascii?Q?xjfXo9+aAo47wkgrU/hN8DTuQV6XNrqED57aoOE6izVADAM09d7jrciWUEQU?=
 =?us-ascii?Q?eOHuqY23ftRJKJCcYebuGFFirH2yo7vjw1mG9BqNT62jn/6czo1F587wcvqX?=
 =?us-ascii?Q?vWPXziUOcxjsNGFaf06qNud1Dn/YlDksGOKH3wq7xDfocZOdFBcSYLv99hB/?=
 =?us-ascii?Q?YOV3/vyvQldi7cSR3evA2e5/y/0rDJHgVIbZseebwk5JCvkSMODfx0vqMlx8?=
 =?us-ascii?Q?Pv/S1tVNhSTtxLSM7lhpK+PqywRinPPLr/npycr/o7diu9Quo9vFdM2fW6y6?=
 =?us-ascii?Q?5oYjWBk4cKNzQD1mRbsMz+tIrE19coTTacTLW9k31ICMPPUQ55wUCgDgLnok?=
 =?us-ascii?Q?iUTNnG6GUtOHC4HN9v1Y0n4tXOJE4dCU9k1VAXZ0WtgohPT/2rcFWYHrcajU?=
 =?us-ascii?Q?uoyMeIyO06tXZaIJa3u40TiBcYSLI5YYa4ZRENVBCUkzBaCcjZmdhYQVonYR?=
 =?us-ascii?Q?QUhppbxKJ56ZsWxZOUxEweJ9moQtQe3sJtd6CICqYquNVntVZjRza+tIZq35?=
 =?us-ascii?Q?w9nK37gJpo0rit2AZt9vryCatbMRnXDyDiAKxu21NBtKXYxQl0+dKktZwf8r?=
 =?us-ascii?Q?pCMAGSK1SEsDV1M6l91aDmMqHhnA6spG26ygOJSS8N6Elk4DrFE6QjvxT+JY?=
 =?us-ascii?Q?ts4xmBcROMnw5jq6VGbF8YoaHWkRwb2dMl1+yRD6LRnBYO3tm9nvpsf8yaVt?=
 =?us-ascii?Q?QlYCz105dsC45UPeu6+fPo/xPlyxtJgxvYXdScRuvsOhdNZWTIMUEFgzVXw+?=
 =?us-ascii?Q?Gx83Pg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2VMJuAlJzMYgBy7sExsKsXeBB5JRfXsx7oEqHjm56U2b5/wskQWgQMCNF8S4SFP+yiNxtxzWSHE6In0AzIm6yP0hRDEAg5coyc6sBOsd76LnOoSmr9v4JvnStEhFKUxohoDhq4IlFMpQ+ricNwHu7RsbcbygZp5JAGFkaMNBVz/LecW8T8w74vTyMmu6y+s1c2e3Aue8EBpUoZQa4DL6EvVmVowEjLpjZBP1HyCoyX27DN6nLM4szPfOZ5x0dj7govf/7sCNjPD+72r3wuv23XGzdPed5pQjHWRqhhP/8ZSRD0i9G6M6fGD2PCxX49SrG8Yvdi/udt2qEDLWODLbxoLstLeRIQLomGZn9jrblBzon3Ud607woP23TEGy00KXufMKAtC/ekLQwZDGy1gEhrV2AetzTNxFYf1Qudj1/rHyCwC1h9KadVkC4Jhi6+kL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:54:51.6305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170a7d73-d61a-4693-640e-08de68abf674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & HOw]
Expose some functions for later dcns to reuse

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 15 +++++----------
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c  | 10 +++++-----
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.h  | 10 ++++++++++
 .../drm/amd/display/dc/optc/dcn35/dcn35_optc.c    |  6 +++---
 .../drm/amd/display/dc/optc/dcn35/dcn35_optc.h    |  9 +++++++++
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 663a18ee5162..3063b6ab32e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -595,16 +595,6 @@ void dccg401_set_dp_dto(
 
 	bool enable = false;
 
-	if (params->otg_inst > 3) {
-		/* dcn401 only has 4 instances */
-		BREAK_TO_DEBUGGER();
-		return;
-	}
-	if (!params->refclk_hz) {
-		BREAK_TO_DEBUGGER();
-		return;
-	}
-
 	if (!dc_is_tmds_signal(params->signal)) {
 		uint64_t dto_integer;
 		uint64_t dto_phase_hz;
@@ -612,6 +602,11 @@ void dccg401_set_dp_dto(
 
 		enable = true;
 
+		if (!params->refclk_hz) {
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+
 		/* Set DTO values:
 		 * int = target_pix_rate / reference_clock
 		 * phase = target_pix_rate - int * reference_clock,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index d11afd1ce72a..941dce439e97 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -41,7 +41,7 @@
 #define FN(reg_name, field_name) \
 	hubbub2->shifts->field_name, hubbub2->masks->field_name
 
-static void dcn401_init_crb(struct hubbub *hubbub)
+void dcn401_init_crb(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -1110,7 +1110,7 @@ bool hubbub401_get_dcc_compression_cap(struct hubbub *hubbub,
 	return true;
 }
 
-static void dcn401_program_det_segments(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg)
+void dcn401_program_det_segments(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -1147,7 +1147,7 @@ static void dcn401_program_det_segments(struct hubbub *hubbub, int hubp_inst, un
 	}
 }
 
-static void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase)
+void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -1170,7 +1170,7 @@ static void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned comp
 	}
 }
 
-static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
+void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
@@ -1192,7 +1192,7 @@ static void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst)
 	}
 }
 
-static bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower)
+bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
index b1d9ea9d1c3d..f48715544429 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.h
@@ -194,6 +194,11 @@ bool hubbub401_get_dcc_compression_cap(
 		const struct dc_dcc_surface_param *input,
 		struct dc_surface_dcc_cap *output);
 
+bool dcn401_program_arbiter(
+	struct hubbub *hubbub,
+	struct dml2_display_arb_regs *arb_regs,
+	bool safe_to_lower);
+
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
 	const struct dcn_hubbub_registers *hubbub_regs,
@@ -203,4 +208,9 @@ void hubbub401_construct(struct dcn20_hubbub *hubbub2,
 	int pixel_chunk_size_kb,
 	int config_return_buffer_size_kb);
 
+void dcn401_program_det_segments(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_seg);
+void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
+void dcn401_wait_for_det_update(struct hubbub *hubbub, int hubp_inst);
+void dcn401_init_crb(struct hubbub *hubbub);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 0953acbcc6d4..5aafd0eedf66 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -270,7 +270,7 @@ static bool optc35_get_crc(struct timing_generator *optc, uint8_t idx,
 	return true;
 }
 
-static bool optc35_configure_crc(struct timing_generator *optc,
+bool optc35_configure_crc(struct timing_generator *optc,
 				 const struct crc_params *params)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -437,7 +437,7 @@ void optc35_set_drr(
 	REG_WRITE(OTG_V_COUNT_STOP_CONTROL2, 0);
 }
 
-static void optc35_set_long_vtotal(
+void optc35_set_long_vtotal(
 	struct timing_generator *optc,
 	const struct long_vtotal_params *params)
 {
@@ -524,7 +524,7 @@ static void optc35_set_long_vtotal(
 	}
 }
 
-static void optc35_wait_otg_disable(struct timing_generator *optc)
+void optc35_wait_otg_disable(struct timing_generator *optc)
 {
 	struct optc *optc1;
 	uint32_t is_master_en;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index 5c2cb1f27783..82e0818c8f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -90,4 +90,13 @@ void dcn35_timing_generator_set_fgcg(struct optc *optc1, bool enable);
 
 void optc35_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
+void optc35_set_long_vtotal(
+	struct timing_generator *optc,
+	const struct long_vtotal_params *params);
+
+bool optc35_configure_crc(struct timing_generator *optc,
+				 const struct crc_params *params);
+
+void optc35_wait_otg_disable(struct timing_generator *optc);
+
 #endif /* __DC_OPTC_DCN35_H__ */
-- 
2.43.0

