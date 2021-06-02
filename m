Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1045C4709B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC8F61C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC8F61C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4A06EDE3;
	Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FF66EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/dLDmvp9hixuv1snNpZ6a+b6+mEjxlNfSafXmMjdvwSqT0hPTSkBVbI0fSwQJiAXmEkFO/yXgJx58ipsMPoCakMXW3tLRBdBosGeSm5THn1mragc9USwvMPpfGjCx7radYwRvJjrNxAFHtDO39q8bVC2SpcMAWVEPnBUsWBOZXSA/IBYzG2AzetrtWXEmnkS+q5T3N9Q6bhEkSKAqLpq1XUDHNQDJnoir3lMSbFr8SuLC+oPNh2LqrDDz1HJxzQV5X++wt6vOjk/c4immPc/l2dqEinSgVRAQr/D2oMQ7PHQEqF7jcxyj0Nb0s/Kr50bgTrOwBwebq+SxH7qEmQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FTARA0D2oV0R1p3zPHPH7/cHBbH17oy//2ML07+V9k=;
 b=Sm4hjssf2CXjWHFqfM+o8EamoMKorPpW2bqIXyUht52p1fyJVxXFOeJuodM+8oQ1Iik9iK05OM3ZzvsyHoXoT+vXHVrXrAuGedQdU9gg5fV+0FNB9PmWuaGlUKfZoZsyhH60OKy9iGSsNc2U1dMuFZya1rdPcOyJe3wzYnKLRAxXQgKezohKT+PExvlImif93fA9H92FbVU5OWu08RvW7N6+tLyxkZur+cZqMmj5aBt5CTxQ2XBErVaNC8FedO/J8goQ2kxXWAzqvGp29bSWA84fc7NyiC9P1HE+D5HeEAQRflA8G+llbuyHIyzX2De8Rk36pNKznhTms/zJF9t7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FTARA0D2oV0R1p3zPHPH7/cHBbH17oy//2ML07+V9k=;
 b=bH0C8c9lchNJh0XoKRy7EUrliuyJg08lFoKjCJ3sfNk+8a2ZKEOp4L467eQ5IfC0+H/aSLmkkMgtQ/gOQ46N2ihmr7JcyFink6P18AA96mhsMPJ+0+tBBP4WfZBh92pprNzT/mrNbwMuHeDblvNYirZle9gh5yqSU2xAPlxfd3M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 74/89] drm/amd/display: Add DCN3.1 OPTC
Date: Wed,  2 Jun 2021 12:48:53 -0400
Message-Id: <20210602164908.2848791-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 041bf041-b85a-4a12-463d-08d925e6813d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453461D5CD0B9160A85D0A14F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gb0KWZdhlyeJ1pFVRzPznkxvhNm5ixOgJCdtAcAYOAIZxdNHb9g+x6IL46NDKeRvrNeGhDlAgk6nYbeE7qAScVtc3ODsmAyD+s+G4IZJHQp0Ph+n+ZqEkCjwph+jbpuOasmWWLsluajb3xvjh7wAqMyYGAyqONy99KRUxqIUa5T725vlya7w1ZVYloq7pLpvZ2MJNdHSDlYoLXtPsxz1fS6dyqJam1vABSy9Ct+xLcj9JzGS4r7HRK9d/u/3WNfvFtJd7iFFLHoMkj+a28/yFTdpEw46hRF12rm7j3r6yK2Sv1L9OE5gQbuz1Q7dL4dXWMf9FJ2U61VJXV8dT5NDpmuItxkHfRh3f0jMCZDIEFhXIWB+nrS8B4G94rqOQ4Lowld/TMCZpMYfJleh5+Utk06MdRIkChbvjJEch+9/nT16jhYmeVOVKvDFDXQjmQ/hrYU2jxvjHjrsOPSeUZ3gN7MfXpax5LY/97FixaRyWdbkMGHBqkl6hqWoT02DLQxQvYFlA4yx97ITKjBRVP4qO05DydeThaXWuUzN6AVwyOrh06JHRnAblzTuF8E+5rOQ/RV1fhZlPQ8Y+7bGIOWAE0iaqZ/+5ol4tcKNLZkJSypW9/51dpvZq9j+6uXbK2zmBUgZcg0vtcrgzrSC+cKIm3pVEDE6Kt6y79Mhrin9F58FqVFuSlsY3l3Zw5pwhqqf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dtlwt/9qWN7nuuTF3cUaVXC/6vX0pzhGPC2sor2ZIdrtMlBURyhKC9g4mG8h?=
 =?us-ascii?Q?Myir8n6DEWCTXfaHHzyJkoXjpQbyBRGApbUpszyYe1dw6QSVugWXEYhp/byY?=
 =?us-ascii?Q?g2hxuNlsLX5trdS+q8afxoNdf0wheVQ3S3L4s/X/reJds62WdHuEIwf25Wnm?=
 =?us-ascii?Q?7KtrPZw5eKHp7FUmIfeZCNWZVzey2pLY7cbCHQ0GRy71zxBaB0u+3jvMscuY?=
 =?us-ascii?Q?KqJU012SvEnAlvHjdPp578i5Fb5xVAMOh2y06TYCoM+0OQRa0PghOvKpwmww?=
 =?us-ascii?Q?4NFvchDKS0NtV1d9XHOOP20tp5SS7E0za4faKbNA9rKs6nzFsYoVdmskmeua?=
 =?us-ascii?Q?I5aiLWaxZuW3r7kEVUvkD7iubP0i+Zm/evwbUn7PjI1xI1oEAEIYwPj+e6Q2?=
 =?us-ascii?Q?YxXsJKodhSmyOyx3TpoXe0VKc2SjHIu0dIUh+nouiEKJnNKVbg2AIG5VVlkr?=
 =?us-ascii?Q?H92P7vD+njhwPKfwDXCNjD2pExKoLZ9Uq0lbv7AkKRHBg/OmiJRlKwVasnej?=
 =?us-ascii?Q?bRHkHIsDr+w7+j7Zc2HohYqHozaYHifdZxL7jAMf/6S2vrSajb6lVq2nWxs4?=
 =?us-ascii?Q?iTkva3OTLAkdJgT9JibTnJtBjR9jHpMuVLcGAPALAJyeZdnyks3jmeo+bf8M?=
 =?us-ascii?Q?aUyCx1z3mRBKKZZWsxVDsjX1E5zv+EFQA/Pzk4jGyS8WnR8G+u7agigyZ0+k?=
 =?us-ascii?Q?7avHKYPwcKxYfWzCzBmPXdJNu+SzufiZt6T7VMGlmWcwH4szO3lgecn85GpH?=
 =?us-ascii?Q?u0b1VayX+JlFDMpl0c8UANXfiLhLVAQz8ACCiX5ihAeGAEvGlIeWRu/xfj99?=
 =?us-ascii?Q?MybabAojjp+6fPsCwJaWaw6T7ouPwGkLIhH0NjsEDOVdtd2SjNTlkRLDRV01?=
 =?us-ascii?Q?pzjIX/1SUdmWxMs53FW+aVz3EtWTrUYQvMBtXZx0r/RAgzdixyTYsvtkrTGT?=
 =?us-ascii?Q?+493uQrbQx5tH8pcDJEyk3um654YDP+jmABh0X3K6tiC38Rd3Ttx6e/XIj6f?=
 =?us-ascii?Q?wBaT8rmCQ4P50Av4nIkJJDVShyoqjFBokViHXyF3mdYgaMHoa0eZdI+6l4IP?=
 =?us-ascii?Q?pdgrbP04LSWJkZxvOEdhTCX0RrJgRIxWRmi5dfstfiKt3g2DcvMqWcgrIWDo?=
 =?us-ascii?Q?4rITb8dK63g9ZCOpmD73yKTbMUOhpcGs2vsiJWxP4Rc+KQLFBW4zJ55jLIJW?=
 =?us-ascii?Q?wo0dZHj3QJuCnb9plQslx5hVOo4tFn40zVC6WdP4UGfSSljnnWsEiTq5ufE1?=
 =?us-ascii?Q?fIBqSUUvKvkW8cVrRkZir6gHKk51IXxwrbe1PyfW7vSZ+6AoBH+wPJ+8xklp?=
 =?us-ascii?Q?7RQ6mwC2C/LdeEEc0d/tLHud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041bf041-b85a-4a12-463d-08d925e6813d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:19.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3pBYK3ITg3kKSrFgkDgn4k8tut7CCMJeng/MheY7oIkTaZkoRpciy3AqbhlQGNPgtJyJ8wU4h5ulSNgDzOXWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Add support for programming the DCN3.1 OPTC (Output Timing Controller)

HW Blocks:

    +--------+
    |  MPC   |
    +--------+
        |
        v
    +-------+
    |  OPP  |
    +-------+
        |
        v
    +--------+
    |  OPTC  |
    +--------+
        |
        v
    +--------+       +--------+
    |  DIO   |       |  DCCG  |
    +--------+       +--------+

There are no changes to OPP or MPC for DCN3.1, so the diagram will
include them in this patch.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  11 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 287 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h | 259 ++++++++++++++++
 .../amd/display/dc/inc/hw/timing_generator.h  |   4 +
 5 files changed, 563 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 677663cc7bff..9bc97e9c48c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -968,6 +968,17 @@ void optc1_set_drr(
 	}
 }
 
+void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_SET(OTG_V_TOTAL_MAX, 0,
+		OTG_V_TOTAL_MAX, vtotal_max);
+
+	REG_SET(OTG_V_TOTAL_MIN, 0,
+		OTG_V_TOTAL_MIN, vtotal_min);
+}
+
 static void optc1_set_test_pattern(
 	struct timing_generator *optc,
 	/* TODO: replace 'controller_dp_test_pattern' by 'test_pattern_mode'
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index cabfe83fd634..a6b74907fe8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -666,6 +666,8 @@ void optc1_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params);
 
+void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
+
 void optc1_set_static_screen_control(
 	struct timing_generator *optc,
 	uint32_t event_triggers,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
new file mode 100644
index 000000000000..a4b1d98f0007
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -0,0 +1,287 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dcn31_optc.h"
+
+#include "dcn30/dcn30_optc.h"
+#include "reg_helper.h"
+#include "dc.h"
+#include "dcn_calc_math.h"
+
+#define REG(reg)\
+	optc1->tg_regs->reg
+
+#define CTX \
+	optc1->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name) \
+	optc1->tg_shift->field_name, optc1->tg_mask->field_name
+
+static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
+		struct dc_crtc_timing *timing)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
+			/ opp_cnt;
+	uint32_t memory_mask = 0;
+	int mem_count_per_opp = (mpcc_hactive + 2559) / 2560;
+
+	/* Assume less than 6 pipes */
+	if (opp_cnt == 4) {
+		if (mem_count_per_opp == 1)
+			memory_mask = 0xf;
+		else {
+			ASSERT(mem_count_per_opp == 2);
+			memory_mask = 0xff;
+		}
+	} else if (mem_count_per_opp == 1)
+		memory_mask = 0x1 << (opp_id[0] * 2) | 0x1 << (opp_id[1] * 2);
+	else if (mem_count_per_opp == 2)
+		memory_mask = 0x3 << (opp_id[0] * 2) | 0x3 << (opp_id[1] * 2);
+	else if (mem_count_per_opp == 3)
+		memory_mask = 0x77;
+	else if (mem_count_per_opp == 4)
+		memory_mask = 0xff;
+
+	if (REG(OPTC_MEMORY_CONFIG))
+		REG_SET(OPTC_MEMORY_CONFIG, 0,
+			OPTC_MEM_SEL, memory_mask);
+
+	if (opp_cnt == 2) {
+		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
+				OPTC_NUM_OF_INPUT_SEGMENT, 1,
+				OPTC_SEG0_SRC_SEL, opp_id[0],
+				OPTC_SEG1_SRC_SEL, opp_id[1]);
+	} else if (opp_cnt == 4) {
+		REG_SET_5(OPTC_DATA_SOURCE_SELECT, 0,
+				OPTC_NUM_OF_INPUT_SEGMENT, 3,
+				OPTC_SEG0_SRC_SEL, opp_id[0],
+				OPTC_SEG1_SRC_SEL, opp_id[1],
+				OPTC_SEG2_SRC_SEL, opp_id[2],
+				OPTC_SEG3_SRC_SEL, opp_id[3]);
+	}
+
+	REG_UPDATE(OPTC_WIDTH_CONTROL,
+			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+
+	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
+	optc1->opp_count = opp_cnt;
+}
+
+/**
+ * Enable CRTC
+ * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ */
+static bool optc31_enable_crtc(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
+	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, optc->inst);
+
+	/* VTG enable first is for HW workaround */
+	REG_UPDATE(CONTROL,
+			VTG0_ENABLE, 1);
+
+	REG_SEQ_START();
+
+	/* Enable CRTC */
+	REG_UPDATE_2(OTG_CONTROL,
+			OTG_DISABLE_POINT_CNTL, 2,
+			OTG_MASTER_EN, 1);
+
+	REG_SEQ_SUBMIT();
+	REG_SEQ_WAIT_DONE();
+
+	return true;
+}
+
+/* disable_crtc - call ASIC Control Object to disable Timing generator. */
+static bool optc31_disable_crtc(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	/* disable otg request until end of the first line
+	 * in the vertical blank region
+	 */
+	REG_UPDATE(OTG_CONTROL,
+			OTG_MASTER_EN, 0);
+
+	REG_UPDATE(CONTROL,
+			VTG0_ENABLE, 0);
+
+	/* CRTC disabled, so disable  clock. */
+	REG_WAIT(OTG_CLOCK_CONTROL,
+			OTG_BUSY, 0,
+			1, 100000);
+
+	return true;
+}
+
+static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_UPDATE_2(OTG_CONTROL,
+			OTG_DISABLE_POINT_CNTL, 0,
+			OTG_MASTER_EN, 0);
+
+	REG_UPDATE(CONTROL,
+			VTG0_ENABLE, 0);
+
+	/* CRTC disabled, so disable  clock. */
+	REG_WAIT(OTG_CLOCK_CONTROL,
+			OTG_BUSY, 0,
+			1, 100000);
+
+	return true;
+}
+
+static void optc31_set_drr(
+	struct timing_generator *optc,
+	const struct drr_params *params)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	if (params != NULL &&
+		params->vertical_total_max > 0 &&
+		params->vertical_total_min > 0) {
+
+		if (params->vertical_total_mid != 0) {
+
+			REG_SET(OTG_V_TOTAL_MID, 0,
+				OTG_V_TOTAL_MID, params->vertical_total_mid - 1);
+
+			REG_UPDATE_2(OTG_V_TOTAL_CONTROL,
+					OTG_VTOTAL_MID_REPLACING_MAX_EN, 1,
+					OTG_VTOTAL_MID_FRAME_NUM,
+					(uint8_t)params->vertical_total_mid_frame_num);
+
+		}
+
+		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
+
+		/*
+		 * MIN_MASK_EN is gone and MASK is now always enabled.
+		 *
+		 * To get it to it work with manual trigger we need to make sure
+		 * we program the correct bit.
+		 */
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_V_TOTAL_MIN_SEL, 1,
+				OTG_V_TOTAL_MAX_SEL, 1,
+				OTG_FORCE_LOCK_ON_EVENT, 0,
+				OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
+		// Setup manual flow control for EOF via TRIG_A
+		optc->funcs->setup_manual_trigger(optc);
+
+	} else {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
+
+		optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	}
+}
+
+static struct timing_generator_funcs dcn31_tg_funcs = {
+		.validate_timing = optc1_validate_timing,
+		.program_timing = optc1_program_timing,
+		.setup_vertical_interrupt0 = optc1_setup_vertical_interrupt0,
+		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
+		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
+		.program_global_sync = optc1_program_global_sync,
+		.enable_crtc = optc31_enable_crtc,
+		.disable_crtc = optc31_disable_crtc,
+		.immediate_disable_crtc = optc31_immediate_disable_crtc,
+		/* used by enable_timing_synchronization. Not need for FPGA */
+		.is_counter_moving = optc1_is_counter_moving,
+		.get_position = optc1_get_position,
+		.get_frame_count = optc1_get_vblank_counter,
+		.get_scanoutpos = optc1_get_crtc_scanoutpos,
+		.get_otg_active_size = optc1_get_otg_active_size,
+		.set_early_control = optc1_set_early_control,
+		/* used by enable_timing_synchronization. Not need for FPGA */
+		.wait_for_state = optc1_wait_for_state,
+		.set_blank_color = optc3_program_blank_color,
+		.did_triggered_reset_occur = optc1_did_triggered_reset_occur,
+		.triplebuffer_lock = optc3_triplebuffer_lock,
+		.triplebuffer_unlock = optc2_triplebuffer_unlock,
+		.enable_reset_trigger = optc1_enable_reset_trigger,
+		.enable_crtc_reset = optc1_enable_crtc_reset,
+		.disable_reset_trigger = optc1_disable_reset_trigger,
+		.lock = optc3_lock,
+		.is_locked = optc1_is_locked,
+		.unlock = optc1_unlock,
+		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
+		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
+		.enable_optc_clock = optc1_enable_optc_clock,
+		.set_drr = optc31_set_drr,
+		.set_vtotal_min_max = optc1_set_vtotal_min_max,
+		.set_static_screen_control = optc1_set_static_screen_control,
+		.program_stereo = optc1_program_stereo,
+		.is_stereo_left_eye = optc1_is_stereo_left_eye,
+		.tg_init = optc3_tg_init,
+		.is_tg_enabled = optc1_is_tg_enabled,
+		.is_optc_underflow_occurred = optc1_is_optc_underflow_occurred,
+		.clear_optc_underflow = optc1_clear_optc_underflow,
+		.setup_global_swap_lock = NULL,
+		.get_crc = optc1_get_crc,
+		.configure_crc = optc2_configure_crc,
+		.set_dsc_config = optc3_set_dsc_config,
+		.set_dwb_source = NULL,
+		.set_odm_bypass = optc3_set_odm_bypass,
+		.set_odm_combine = optc31_set_odm_combine,
+		.get_optc_source = optc2_get_optc_source,
+		.set_out_mux = optc3_set_out_mux,
+		.set_drr_trigger_window = optc3_set_drr_trigger_window,
+		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
+		.set_gsl = optc2_set_gsl,
+		.set_gsl_source_select = optc2_set_gsl_source_select,
+		.set_vtg_params = optc1_set_vtg_params,
+		.program_manual_trigger = optc2_program_manual_trigger,
+		.setup_manual_trigger = optc2_setup_manual_trigger,
+		.get_hw_timing = optc1_get_hw_timing,
+};
+
+void dcn31_timing_generator_init(struct optc *optc1)
+{
+	optc1->base.funcs = &dcn31_tg_funcs;
+
+	optc1->max_h_total = optc1->tg_mask->OTG_H_TOTAL + 1;
+	optc1->max_v_total = optc1->tg_mask->OTG_V_TOTAL + 1;
+
+	optc1->min_h_blank = 32;
+	optc1->min_v_blank = 3;
+	optc1->min_v_blank_interlace = 5;
+	optc1->min_h_sync_width = 4;
+	optc1->min_v_sync_width = 1;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
new file mode 100644
index 000000000000..d8ef2f0d0c95
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -0,0 +1,259 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_OPTC_DCN31_H__
+#define __DC_OPTC_DCN31_H__
+
+#include "dcn10/dcn10_optc.h"
+
+#define OPTC_COMMON_REG_LIST_DCN3_1(inst) \
+	SRI(OTG_VSTARTUP_PARAM, OTG, inst),\
+	SRI(OTG_VUPDATE_PARAM, OTG, inst),\
+	SRI(OTG_VREADY_PARAM, OTG, inst),\
+	SRI(OTG_MASTER_UPDATE_LOCK, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL0, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL4, OTG, inst),\
+	SRI(OTG_DOUBLE_BUFFER_CONTROL, OTG, inst),\
+	SRI(OTG_H_TOTAL, OTG, inst),\
+	SRI(OTG_H_BLANK_START_END, OTG, inst),\
+	SRI(OTG_H_SYNC_A, OTG, inst),\
+	SRI(OTG_H_SYNC_A_CNTL, OTG, inst),\
+	SRI(OTG_H_TIMING_CNTL, OTG, inst),\
+	SRI(OTG_V_TOTAL, OTG, inst),\
+	SRI(OTG_V_BLANK_START_END, OTG, inst),\
+	SRI(OTG_V_SYNC_A, OTG, inst),\
+	SRI(OTG_V_SYNC_A_CNTL, OTG, inst),\
+	SRI(OTG_CONTROL, OTG, inst),\
+	SRI(OTG_STEREO_CONTROL, OTG, inst),\
+	SRI(OTG_3D_STRUCTURE_CONTROL, OTG, inst),\
+	SRI(OTG_STEREO_STATUS, OTG, inst),\
+	SRI(OTG_V_TOTAL_MAX, OTG, inst),\
+	SRI(OTG_V_TOTAL_MIN, OTG, inst),\
+	SRI(OTG_V_TOTAL_CONTROL, OTG, inst),\
+	SRI(OTG_TRIGA_CNTL, OTG, inst),\
+	SRI(OTG_FORCE_COUNT_NOW_CNTL, OTG, inst),\
+	SRI(OTG_STATIC_SCREEN_CONTROL, OTG, inst),\
+	SRI(OTG_STATUS_FRAME_COUNT, OTG, inst),\
+	SRI(OTG_STATUS, OTG, inst),\
+	SRI(OTG_STATUS_POSITION, OTG, inst),\
+	SRI(OTG_NOM_VERT_POSITION, OTG, inst),\
+	SRI(OTG_M_CONST_DTO0, OTG, inst),\
+	SRI(OTG_M_CONST_DTO1, OTG, inst),\
+	SRI(OTG_CLOCK_CONTROL, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT0_CONTROL, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT0_POSITION, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT1_CONTROL, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT1_POSITION, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT2_CONTROL, OTG, inst),\
+	SRI(OTG_VERTICAL_INTERRUPT2_POSITION, OTG, inst),\
+	SRI(OPTC_INPUT_CLOCK_CONTROL, ODM, inst),\
+	SRI(OPTC_DATA_SOURCE_SELECT, ODM, inst),\
+	SRI(OPTC_INPUT_GLOBAL_CONTROL, ODM, inst),\
+	SRI(CONTROL, VTG, inst),\
+	SRI(OTG_VERT_SYNC_CONTROL, OTG, inst),\
+	SRI(OTG_GSL_CONTROL, OTG, inst),\
+	SRI(OTG_CRC_CNTL, OTG, inst),\
+	SRI(OTG_CRC0_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC0_DATA_B, OTG, inst),\
+	SRI(OTG_CRC0_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SR(GSL_SOURCE_SELECT),\
+	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
+	SRI(OTG_GLOBAL_CONTROL2, OTG, inst),\
+	SRI(OTG_GSL_WINDOW_X, OTG, inst),\
+	SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
+	SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
+	SRI(OTG_DSC_START_POSITION, OTG, inst),\
+	SRI(OTG_DRR_TRIGGER_WINDOW, OTG, inst),\
+	SRI(OTG_DRR_V_TOTAL_CHANGE, OTG, inst),\
+	SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
+	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
+	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
+	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
+	SRI(OTG_CRC_CNTL2, OTG, inst),\
+	SR(DWB_SOURCE_SELECT)
+
+#define OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)\
+	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_OFFSET, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_WIDTH, mask_sh),\
+	SF(OTG0_OTG_VREADY_PARAM, VREADY_OFFSET, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, OTG_MASTER_UPDATE_LOCK, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_START_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_END_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_START_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_END_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, OTG_MASTER_UPDATE_LOCK_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_Y, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A_CNTL, OTG_H_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL, OTG_V_TOTAL, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_START_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_OUT_MUX, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EYE_FLAG_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_DISABLE_STEREOSYNC_OUTPUT_FOR_DP, mask_sh),\
+	SF(OTG0_OTG_STEREO_STATUS, OTG_STEREO_CURRENT_EYE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_EN, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_V_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_STEREO_SEL_OVR, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MIN, OTG_V_TOTAL_MIN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MIN_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MAX_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_FORCE_LOCK_ON_EVENT, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_SET_V_TOTAL_MIN_MASK, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MIN_EN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MAX_EN, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_CLEAR, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_MODE, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_PIPE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_RISING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FALLING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_POLARITY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FREQUENCY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_DELAY, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_CLEAR, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_EVENT_MASK, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_FRAME_COUNT, OTG_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_BLANK, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_ACTIVE_DISP, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_HORZ_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_VERT_COUNT, mask_sh),\
+	SF(OTG0_OTG_NOM_VERT_POSITION, OTG_VERT_COUNT_NOM, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO0, OTG_M_CONST_DTO_PHASE, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO1, OTG_M_CONST_DTO_MODULO, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_BUSY, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_EN, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_ON, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_GATE_DIS, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_END, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_POSITION, OTG_VERTICAL_INTERRUPT1_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_POSITION, OTG_VERTICAL_INTERRUPT2_LINE_START, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_EN, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_CLEAR, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_AUTO_FORCE_VSYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL0_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL1_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL2_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
+	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
+	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG3_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
+	SF(ODM0_OPTC_MEMORY_CONFIG, OPTC_MEM_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DSC_MODE, mask_sh),\
+	SF(ODM0_OPTC_BYTES_PER_PIXEL, OPTC_DSC_BYTES_PER_PIXEL, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_DSC_SLICE_WIDTH, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_SEGMENT_WIDTH, mask_sh),\
+	SF(DWB_SOURCE_SELECT, OPTC_DWB0_SOURCE_SELECT, mask_sh),\
+	SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
+	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh)
+
+void dcn31_timing_generator_init(struct optc *optc1);
+
+#endif /* __DC_OPTC_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 9ff68b67780c..a77eb9cd049f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -173,6 +173,9 @@ struct timing_generator_funcs {
 
 	bool (*enable_crtc)(struct timing_generator *tg);
 	bool (*disable_crtc)(struct timing_generator *tg);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	bool (*immediate_disable_crtc)(struct timing_generator *tg);
+#endif
 	bool (*is_counter_moving)(struct timing_generator *tg);
 	void (*get_position)(struct timing_generator *tg,
 				struct crtc_position *position);
@@ -223,6 +226,7 @@ struct timing_generator_funcs {
 	void (*enable_advanced_request)(struct timing_generator *tg,
 					bool enable, const struct dc_crtc_timing *timing);
 	void (*set_drr)(struct timing_generator *tg, const struct drr_params *params);
+	void (*set_vtotal_min_max)(struct timing_generator *optc, int vtotal_min, int vtotal_max);
 	void (*set_static_screen_control)(struct timing_generator *tg,
 						uint32_t event_triggers,
 						uint32_t num_frames);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
