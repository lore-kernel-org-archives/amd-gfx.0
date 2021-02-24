Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA5C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BAF64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BAF64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6894489DAB;
	Wed, 24 Feb 2021 22:19:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F3E89DAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKkPrnlrdW94bahu7ZDVZT+CVDRhx8n4o9WZtJo43vqZfC2a6ieHxxqiP55ivkF4DaLQq/snLi8O90v55YBnmOpD+uAs0y017dw/g3NRC166M/oxBC0YLMyeTTyNVC5RRrtqCdA22hT9Ztv4kxJhiYZfTXoqnN+CWOr8hhE8AOAdtgIgUIs5Cj4FGAx1m8F5VPwzxIz5JImHKs7o+ojVx16ertrhAgptC58T8ac/aNILgpB0xbl8TWq4NOAdhurMv2FDF7odzwzGAaOJBV2xZ8oNmiosWCJjxgobMQ0BJe080inb0SJ6VQFcJ3JAeywiHNsTF6ECe6pbjtLgD6F7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i35kKMfxrQoCxTMVO48SiTiVgLAaS7mrEI7DqmVoIpc=;
 b=i6SPY7hefp9nS4GfngQcquoy1oEXWlizrtie7Z771eh+L/XlQtLvVySzlSquefL0ntyJKm0G4/+eULInwQBjAu9EkftNjU2lwAk+P2Tva+WWGK8dQJRn08iy/qRr7zQiqkFXP4VS/ELp7RZC1FQ4uG45TdFQYrL877TmNbEqUpDp5QujT46DDKOtlAfSZe6jHg/hJ+4FYII3wqQESB6Qp/7GMs+W0r02DjYzYt2K9XUQsUaRlIDy+vzbCPKdAJFXYUs/WSvhI2xsaDsyDsRs4rU2tXMR8CzBf9HtnnqaWJHTlvxmWCK18/45C/Eee5w87YFDDG/NU1THskOu3s9/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i35kKMfxrQoCxTMVO48SiTiVgLAaS7mrEI7DqmVoIpc=;
 b=OEjQlm0FyZ7RuYuFWI/JnmIiGLtMeUuu1GFEQXn/Vv5vSQ02SuL9Y9hAULGt/xbHEF+E2m8OQUfSSPHEYfS+XL/Tf8yyHm+Wr1Xuqo4YOYKCmLUKeAtMdflO8oKz7JQL/yEzoLamZHhalGjY6KOXeAyw+YKK53tYZ+E4IxvZQ+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 010/159] drm/amd/include: add ip offset header for aldebaran
 (v5)
Date: Wed, 24 Feb 2021 17:16:30 -0500
Message-Id: <20210224221859.3068810-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03403e4c-8aed-409a-84c9-08d8d9123de4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174DC6E9B07E9854F76FD99F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GQcL793sJqt0P4sM98LBilBvSfTzJf94m1Q+WNxv+CrHhvfrrwG2jAIX4BsriqUc5/HF6SNu+f5IETyfTkaeMVKU7/oWrv71kMXZ0gruIsu7hJktNXZdznWd5mY0ZVKiVDJK/WrgShi+TuGtDRBYYSeHrIjdSsXeiOPl8B7czUYT4FRqSj9CRXFeJWjiyO+/wxI4T/wuGxFjNadBA0Swpl0rrJiR3KhgsKLeOjYAWBRKtOYhoq7AG1FllVh+ryQiGcCi2VkK3JJovYsrlGsuwFJCsh9kdjuy5SJ1VtlQ0zuQUuwPFzz6kxCmWdyvfUSU11Hug6METyt7Krh2l1AjrHgLTN4y7WXwuAbZ2s0DHTVYQt7ItAjG6sDlkrWRpRWnNlljEUbGtRaXOpYNcJpNgZfVpJLbaBguwvxY5UGNsYMta48MFxFl0pHPZBCKUhBb5uy+JRhQZFd1JmnoyVaUjJ8geHWsm4C2PpdfDt3Nn91OaP/v+U9zWTTLhPP/daTU1AVsv0EsesgYRain+htRQ85ljh5gn1fo+2E836gBk27nKzFn+rlRn2fbH+6uL/VAQTtG+7E+vqIBXJdA/6/yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(30864003)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pahKx6pQ4ilSKPCSVm6bMgFjYzfOVgxGpJsZEfOkGyLwtE9jUOxR439+5gCi?=
 =?us-ascii?Q?ck3Ff1YGhaijZsz2wpIMme66qrHc0yU2u5F9f9Rt7rrudsfzTvgfLSJBzGps?=
 =?us-ascii?Q?RgiBPgvlnLm7V8MzznkYYqNwIa284gVpWEKGRjF/cpDfbAV1QV1VjupabjHa?=
 =?us-ascii?Q?8KOgl7j0A1nN/uNaSCOLNnd/7MWFzTGCP5tw0EgHzDmfMKqYGO4ig8UNRMK4?=
 =?us-ascii?Q?19VGEuuIsm4JZE7lWpyh+DqNJ+7lU7iO3rFonOs+QO7y2lrA78Jdc/R5czCO?=
 =?us-ascii?Q?sNl37cKLFWj1VFgFOp7mxh6K94yA5A7lg+f8xuLrgfP1y5zr/xNXFFRAoBLh?=
 =?us-ascii?Q?cPaqMguuTpI2iSiIZDI52gvDzcdyvX0j3M1dDY+kce9MT0+/r30WBZRh+z62?=
 =?us-ascii?Q?eIeklk9njUxqoRlmrDLV5/1hCaaZ5T5J6WmPgYcs5rB+COTzwxyvcw24MRer?=
 =?us-ascii?Q?ErymQuJCAtJNO+nbhq+uhrkiTapXvBddbS7sKdNa8IT1J+0cGE3mXC3SnJkH?=
 =?us-ascii?Q?LWMARAk2SLLCDwNrUcGB/yK9XgEWZhSgCT0465AkjmBr35Y+okh+5QCdaySY?=
 =?us-ascii?Q?BX6xXaMaqtcQPIXwS+UuvEAlKOh6mQOPaFQdq6QvvXyTb5IXnU/UNzLFueMG?=
 =?us-ascii?Q?I3FATQoOEuAkKQonAw0ELrVx8kf8dZJTlKfqCGMWRYobsyeFujiGZMf9AWuN?=
 =?us-ascii?Q?Jk0OmAouV4CwhCexT+1jvTY2Ud5IY4rHVmBTKUCYJ26s3TzcX0AbK6SUzDt4?=
 =?us-ascii?Q?Bz/zrWA8y1pC4uc4nas/1rNS4FzvYbAk/sC6s5twXWQRB9r2do329FjJVGzS?=
 =?us-ascii?Q?nKy0Au9ZqEXRYQb1nlg9au+UJtoWz1HU9zy7eY89mtG/EHYnupm3jjC4qlHF?=
 =?us-ascii?Q?/RbsaCC9GPF6BurdBzEbroxgiuJed5WV4FCgekLQfLkhGGPHpmU96HY18G2M?=
 =?us-ascii?Q?mH3AvBbvopvJE//sQ/ET7wSeX/kKSLUYDSUbIXdEGBrho8mJ0I5ZeZWaqK2N?=
 =?us-ascii?Q?NrcLW/972Sz4Ifd4AGddgeHVOx4dSj14CkPoSU0B0p05Hjt/qpoh13RtoSlU?=
 =?us-ascii?Q?xctm+R8cPofkXzzoNis69duKgUaSSgSXl5L1+lDoom+1uDjgXSDVim+mQGyt?=
 =?us-ascii?Q?XeDTDnfU5CVJ1zZZRkijJEBWNnCNcAQ/IGwZSQwysX8mbkPQtZ2B1QURGHSM?=
 =?us-ascii?Q?qw6tLhlulgRYAtLebafhKGVk7X5k2DGKZO5dvDrdzNOrkVqr5uXdn4gqRsvB?=
 =?us-ascii?Q?T9FT+IJZ6l0OQIzYJO7O0nqY08yyQRmtbpFs8kLVT3ETZLSekh1tEAAyot5I?=
 =?us-ascii?Q?HQQsi+Qh8ZBWwv0rTPXv70ie?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03403e4c-8aed-409a-84c9-08d8d9123de4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:24.7425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mnB00oP2+jOruLtJliUb3RloAok5WhugqCA3YH/GWo2iuAZZu8Q9iyvMkFTmOa8Qrl7slYC6nNrvb5IumdDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Evan Quan <evan.quan@amd.com>, Le Ma <le.ma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

v1: re-use arct ip base offset array for aldebaran (Le)
v2: create aldebaran ip base offset array for major ip
blocks (Hawking)
v3: re-use arct VCN ip base offset array for aldebaran
(James)
v4: correct MP1 ip base offset array (Hawking)
v5: update VCN ip base offset array to aldebaran one
(Hawking)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Le Ma <le.ma@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/aldebaran_ip_offset.h | 1738 +++++++++++++++++
 1 file changed, 1738 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/aldebaran_ip_offset.h

diff --git a/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h b/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
new file mode 100644
index 000000000000..644ffec2b0ce
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
@@ -0,0 +1,1738 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _aldebaran_ip_offset_HEADER
+#define _aldebaran_ip_offset_HEADER
+
+#define MAX_INSTANCE                                        7
+#define MAX_SEGMENT                                         6
+
+struct IP_BASE_INSTANCE {
+    unsigned int segment[MAX_SEGMENT];
+};
+
+struct IP_BASE {
+    struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
+};
+
+static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C20, 0x02408C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
+                                        { { 0x00016E00, 0x02401C00, 0, 0, 0, 0 } },
+                                        { { 0x00017000, 0x02402000, 0, 0, 0, 0 } },
+                                        { { 0x00017200, 0x02402400, 0, 0, 0, 0 } },
+                                        { { 0x0001B000, 0x0242D800, 0, 0, 0, 0 } },
+                                        { { 0x0001B200, 0x0242DC00, 0, 0, 0, 0 } },
+                                        { { 0x00017E00, 0x0240BC00, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DBGU_IO0_BASE = { { { { 0x000001E0, 0x0240B400, 0, 0, 0, 0 } },
+                                        { { 0x00000260, 0x02413C00, 0, 0, 0, 0 } },
+                                        { { 0x00000280, 0x02416000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0x07C00000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE GC_BASE = { { { { 0x00002000, 0x0000A000, 0x02402C00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE IOAGR0_BASE = { { { { 0x02419000, 0x056C0000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE IOAPIC0_BASE = { { { { 0x00A00000, 0x0241F000, 0x050C0000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE IOHC0_BASE = { { { { 0x00010000, 0x02406000, 0x04EC0000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE L1IMUIOAGR0_BASE = { { { { 0x0240CC00, 0x05200000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE L1IMUPCIE0_BASE = { { { { 0x0240C800, 0x051C0000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE L2IMU0_BASE = { { { { 0x00007DC0, 0x00900000, 0x02407000, 0x04FC0000, 0x055C0000, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MMHUB_BASE = { { { { 0x0001A000, 0x02408800, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE PCIE0_BASE = { { { { 0x02411800, 0x04440000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x00012540, 0x0040A800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA1_BASE = { { { { 0x00001860, 0x00012560, 0x0040AC00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA2_BASE = { { { { 0x00013760, 0x0001E000, 0x0042EC00, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA3_BASE = { { { { 0x00013780, 0x0001E400, 0x0042F000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SDMA4_BASE = { { { { 0x000137A0, 0x0001E800, 0x0042F400, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x03440000, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x00054000, 0x02425800, 0, 0, 0 } },
+                                        { { 0x00094000, 0x000D4000, 0x02425C00, 0, 0, 0 } },
+                                        { { 0x00114000, 0x00154000, 0x02426000, 0, 0, 0 } },
+                                        { { 0x00194000, 0x001D4000, 0x02426400, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
+                                        { { 0x00007A00, 0x00009000, 0x02445000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE WAFL0_BASE = { { { { 0x02438000, 0x04880000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE WAFL1_BASE = { { { { 0, 0x01300000, 0x02410800, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE XGMI0_BASE = { { { { 0x02438C00, 0x04680000, 0x04940000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE XGMI1_BASE = { { { { 0x02439000, 0x046C0000, 0x04980000, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE XGMI2_BASE = { { { { 0x04700000, 0x049C0000, 0, 0, 0, 0 } },
+                                        { { 0x04740000, 0x04A00000, 0, 0, 0, 0 } },
+                                        { { 0x04780000, 0x04A40000, 0, 0, 0, 0 } },
+                                        { { 0x047C0000, 0x04A80000, 0, 0, 0, 0 } },
+                                        { { 0x04800000, 0x04AC0000, 0, 0, 0, 0 } },
+                                        { { 0x04840000, 0x04B00000, 0, 0, 0, 0 } },
+                                        { { 0, 0, 0, 0, 0, 0 } } } };
+
+
+#define ATHUB_BASE__INST0_SEG0                     0x00000C20
+#define ATHUB_BASE__INST0_SEG1                     0x02408C00
+#define ATHUB_BASE__INST0_SEG2                     0
+#define ATHUB_BASE__INST0_SEG3                     0
+#define ATHUB_BASE__INST0_SEG4                     0
+#define ATHUB_BASE__INST0_SEG5                     0
+
+#define ATHUB_BASE__INST1_SEG0                     0
+#define ATHUB_BASE__INST1_SEG1                     0
+#define ATHUB_BASE__INST1_SEG2                     0
+#define ATHUB_BASE__INST1_SEG3                     0
+#define ATHUB_BASE__INST1_SEG4                     0
+#define ATHUB_BASE__INST1_SEG5                     0
+
+#define ATHUB_BASE__INST2_SEG0                     0
+#define ATHUB_BASE__INST2_SEG1                     0
+#define ATHUB_BASE__INST2_SEG2                     0
+#define ATHUB_BASE__INST2_SEG3                     0
+#define ATHUB_BASE__INST2_SEG4                     0
+#define ATHUB_BASE__INST2_SEG5                     0
+
+#define ATHUB_BASE__INST3_SEG0                     0
+#define ATHUB_BASE__INST3_SEG1                     0
+#define ATHUB_BASE__INST3_SEG2                     0
+#define ATHUB_BASE__INST3_SEG3                     0
+#define ATHUB_BASE__INST3_SEG4                     0
+#define ATHUB_BASE__INST3_SEG5                     0
+
+#define ATHUB_BASE__INST4_SEG0                     0
+#define ATHUB_BASE__INST4_SEG1                     0
+#define ATHUB_BASE__INST4_SEG2                     0
+#define ATHUB_BASE__INST4_SEG3                     0
+#define ATHUB_BASE__INST4_SEG4                     0
+#define ATHUB_BASE__INST4_SEG5                     0
+
+#define ATHUB_BASE__INST5_SEG0                     0
+#define ATHUB_BASE__INST5_SEG1                     0
+#define ATHUB_BASE__INST5_SEG2                     0
+#define ATHUB_BASE__INST5_SEG3                     0
+#define ATHUB_BASE__INST5_SEG4                     0
+#define ATHUB_BASE__INST5_SEG5                     0
+
+#define ATHUB_BASE__INST6_SEG0                     0
+#define ATHUB_BASE__INST6_SEG1                     0
+#define ATHUB_BASE__INST6_SEG2                     0
+#define ATHUB_BASE__INST6_SEG3                     0
+#define ATHUB_BASE__INST6_SEG4                     0
+#define ATHUB_BASE__INST6_SEG5                     0
+
+#define CLK_BASE__INST0_SEG0                       0x00016C00
+#define CLK_BASE__INST0_SEG1                       0x02401800
+#define CLK_BASE__INST0_SEG2                       0
+#define CLK_BASE__INST0_SEG3                       0
+#define CLK_BASE__INST0_SEG4                       0
+#define CLK_BASE__INST0_SEG5                       0
+
+#define CLK_BASE__INST1_SEG0                       0x00016E00
+#define CLK_BASE__INST1_SEG1                       0x02401C00
+#define CLK_BASE__INST1_SEG2                       0
+#define CLK_BASE__INST1_SEG3                       0
+#define CLK_BASE__INST1_SEG4                       0
+#define CLK_BASE__INST1_SEG5                       0
+
+#define CLK_BASE__INST2_SEG0                       0x00017000
+#define CLK_BASE__INST2_SEG1                       0x02402000
+#define CLK_BASE__INST2_SEG2                       0
+#define CLK_BASE__INST2_SEG3                       0
+#define CLK_BASE__INST2_SEG4                       0
+#define CLK_BASE__INST2_SEG5                       0
+
+#define CLK_BASE__INST3_SEG0                       0x00017200
+#define CLK_BASE__INST3_SEG1                       0x02402400
+#define CLK_BASE__INST3_SEG2                       0
+#define CLK_BASE__INST3_SEG3                       0
+#define CLK_BASE__INST3_SEG4                       0
+#define CLK_BASE__INST3_SEG5                       0
+
+#define CLK_BASE__INST4_SEG0                       0x0001B000
+#define CLK_BASE__INST4_SEG1                       0x0242D800
+#define CLK_BASE__INST4_SEG2                       0
+#define CLK_BASE__INST4_SEG3                       0
+#define CLK_BASE__INST4_SEG4                       0
+#define CLK_BASE__INST4_SEG5                       0
+
+#define CLK_BASE__INST5_SEG0                       0x0001B200
+#define CLK_BASE__INST5_SEG1                       0x0242DC00
+#define CLK_BASE__INST5_SEG2                       0
+#define CLK_BASE__INST5_SEG3                       0
+#define CLK_BASE__INST5_SEG4                       0
+#define CLK_BASE__INST5_SEG5                       0
+
+#define CLK_BASE__INST6_SEG0                       0x00017E00
+#define CLK_BASE__INST6_SEG1                       0x0240BC00
+#define CLK_BASE__INST6_SEG2                       0
+#define CLK_BASE__INST6_SEG3                       0
+#define CLK_BASE__INST6_SEG4                       0
+#define CLK_BASE__INST6_SEG5                       0
+
+#define DBGU_IO0_BASE__INST0_SEG0                  0x000001E0
+#define DBGU_IO0_BASE__INST0_SEG1                  0x0240B400
+#define DBGU_IO0_BASE__INST0_SEG2                  0
+#define DBGU_IO0_BASE__INST0_SEG3                  0
+#define DBGU_IO0_BASE__INST0_SEG4                  0
+#define DBGU_IO0_BASE__INST0_SEG5                  0
+
+#define DBGU_IO0_BASE__INST1_SEG0                  0x00000260
+#define DBGU_IO0_BASE__INST1_SEG1                  0x02413C00
+#define DBGU_IO0_BASE__INST1_SEG2                  0
+#define DBGU_IO0_BASE__INST1_SEG3                  0
+#define DBGU_IO0_BASE__INST1_SEG4                  0
+#define DBGU_IO0_BASE__INST1_SEG5                  0
+
+#define DBGU_IO0_BASE__INST2_SEG0                  0x00000280
+#define DBGU_IO0_BASE__INST2_SEG1                  0x02416000
+#define DBGU_IO0_BASE__INST2_SEG2                  0
+#define DBGU_IO0_BASE__INST2_SEG3                  0
+#define DBGU_IO0_BASE__INST2_SEG4                  0
+#define DBGU_IO0_BASE__INST2_SEG5                  0
+
+#define DBGU_IO0_BASE__INST3_SEG0                  0
+#define DBGU_IO0_BASE__INST3_SEG1                  0
+#define DBGU_IO0_BASE__INST3_SEG2                  0
+#define DBGU_IO0_BASE__INST3_SEG3                  0
+#define DBGU_IO0_BASE__INST3_SEG4                  0
+#define DBGU_IO0_BASE__INST3_SEG5                  0
+
+#define DBGU_IO0_BASE__INST4_SEG0                  0
+#define DBGU_IO0_BASE__INST4_SEG1                  0
+#define DBGU_IO0_BASE__INST4_SEG2                  0
+#define DBGU_IO0_BASE__INST4_SEG3                  0
+#define DBGU_IO0_BASE__INST4_SEG4                  0
+#define DBGU_IO0_BASE__INST4_SEG5                  0
+
+#define DBGU_IO0_BASE__INST5_SEG0                  0
+#define DBGU_IO0_BASE__INST5_SEG1                  0
+#define DBGU_IO0_BASE__INST5_SEG2                  0
+#define DBGU_IO0_BASE__INST5_SEG3                  0
+#define DBGU_IO0_BASE__INST5_SEG4                  0
+#define DBGU_IO0_BASE__INST5_SEG5                  0
+
+#define DBGU_IO0_BASE__INST6_SEG0                  0
+#define DBGU_IO0_BASE__INST6_SEG1                  0
+#define DBGU_IO0_BASE__INST6_SEG2                  0
+#define DBGU_IO0_BASE__INST6_SEG3                  0
+#define DBGU_IO0_BASE__INST6_SEG4                  0
+#define DBGU_IO0_BASE__INST6_SEG5                  0
+
+#define DF_BASE__INST0_SEG0                        0x00007000
+#define DF_BASE__INST0_SEG1                        0x0240B800
+#define DF_BASE__INST0_SEG2                        0x07C00000
+#define DF_BASE__INST0_SEG3                        0
+#define DF_BASE__INST0_SEG4                        0
+#define DF_BASE__INST0_SEG5                        0
+
+#define DF_BASE__INST1_SEG0                        0
+#define DF_BASE__INST1_SEG1                        0
+#define DF_BASE__INST1_SEG2                        0
+#define DF_BASE__INST1_SEG3                        0
+#define DF_BASE__INST1_SEG4                        0
+#define DF_BASE__INST1_SEG5                        0
+
+#define DF_BASE__INST2_SEG0                        0
+#define DF_BASE__INST2_SEG1                        0
+#define DF_BASE__INST2_SEG2                        0
+#define DF_BASE__INST2_SEG3                        0
+#define DF_BASE__INST2_SEG4                        0
+#define DF_BASE__INST2_SEG5                        0
+
+#define DF_BASE__INST3_SEG0                        0
+#define DF_BASE__INST3_SEG1                        0
+#define DF_BASE__INST3_SEG2                        0
+#define DF_BASE__INST3_SEG3                        0
+#define DF_BASE__INST3_SEG4                        0
+#define DF_BASE__INST3_SEG5                        0
+
+#define DF_BASE__INST4_SEG0                        0
+#define DF_BASE__INST4_SEG1                        0
+#define DF_BASE__INST4_SEG2                        0
+#define DF_BASE__INST4_SEG3                        0
+#define DF_BASE__INST4_SEG4                        0
+#define DF_BASE__INST4_SEG5                        0
+
+#define DF_BASE__INST5_SEG0                        0
+#define DF_BASE__INST5_SEG1                        0
+#define DF_BASE__INST5_SEG2                        0
+#define DF_BASE__INST5_SEG3                        0
+#define DF_BASE__INST5_SEG4                        0
+#define DF_BASE__INST5_SEG5                        0
+
+#define DF_BASE__INST6_SEG0                        0
+#define DF_BASE__INST6_SEG1                        0
+#define DF_BASE__INST6_SEG2                        0
+#define DF_BASE__INST6_SEG3                        0
+#define DF_BASE__INST6_SEG4                        0
+#define DF_BASE__INST6_SEG5                        0
+
+#define FUSE_BASE__INST0_SEG0                      0x00017400
+#define FUSE_BASE__INST0_SEG1                      0x02401400
+#define FUSE_BASE__INST0_SEG2                      0
+#define FUSE_BASE__INST0_SEG3                      0
+#define FUSE_BASE__INST0_SEG4                      0
+#define FUSE_BASE__INST0_SEG5                      0
+
+#define FUSE_BASE__INST1_SEG0                      0
+#define FUSE_BASE__INST1_SEG1                      0
+#define FUSE_BASE__INST1_SEG2                      0
+#define FUSE_BASE__INST1_SEG3                      0
+#define FUSE_BASE__INST1_SEG4                      0
+#define FUSE_BASE__INST1_SEG5                      0
+
+#define FUSE_BASE__INST2_SEG0                      0
+#define FUSE_BASE__INST2_SEG1                      0
+#define FUSE_BASE__INST2_SEG2                      0
+#define FUSE_BASE__INST2_SEG3                      0
+#define FUSE_BASE__INST2_SEG4                      0
+#define FUSE_BASE__INST2_SEG5                      0
+
+#define FUSE_BASE__INST3_SEG0                      0
+#define FUSE_BASE__INST3_SEG1                      0
+#define FUSE_BASE__INST3_SEG2                      0
+#define FUSE_BASE__INST3_SEG3                      0
+#define FUSE_BASE__INST3_SEG4                      0
+#define FUSE_BASE__INST3_SEG5                      0
+
+#define FUSE_BASE__INST4_SEG0                      0
+#define FUSE_BASE__INST4_SEG1                      0
+#define FUSE_BASE__INST4_SEG2                      0
+#define FUSE_BASE__INST4_SEG3                      0
+#define FUSE_BASE__INST4_SEG4                      0
+#define FUSE_BASE__INST4_SEG5                      0
+
+#define FUSE_BASE__INST5_SEG0                      0
+#define FUSE_BASE__INST5_SEG1                      0
+#define FUSE_BASE__INST5_SEG2                      0
+#define FUSE_BASE__INST5_SEG3                      0
+#define FUSE_BASE__INST5_SEG4                      0
+#define FUSE_BASE__INST5_SEG5                      0
+
+#define FUSE_BASE__INST6_SEG0                      0
+#define FUSE_BASE__INST6_SEG1                      0
+#define FUSE_BASE__INST6_SEG2                      0
+#define FUSE_BASE__INST6_SEG3                      0
+#define FUSE_BASE__INST6_SEG4                      0
+#define FUSE_BASE__INST6_SEG5                      0
+
+#define GC_BASE__INST0_SEG0                        0x00002000
+#define GC_BASE__INST0_SEG1                        0x0000A000
+#define GC_BASE__INST0_SEG2                        0x02402C00
+#define GC_BASE__INST0_SEG3                        0
+#define GC_BASE__INST0_SEG4                        0
+#define GC_BASE__INST0_SEG5                        0
+
+#define GC_BASE__INST1_SEG0                        0
+#define GC_BASE__INST1_SEG1                        0
+#define GC_BASE__INST1_SEG2                        0
+#define GC_BASE__INST1_SEG3                        0
+#define GC_BASE__INST1_SEG4                        0
+#define GC_BASE__INST1_SEG5                        0
+
+#define GC_BASE__INST2_SEG0                        0
+#define GC_BASE__INST2_SEG1                        0
+#define GC_BASE__INST2_SEG2                        0
+#define GC_BASE__INST2_SEG3                        0
+#define GC_BASE__INST2_SEG4                        0
+#define GC_BASE__INST2_SEG5                        0
+
+#define GC_BASE__INST3_SEG0                        0
+#define GC_BASE__INST3_SEG1                        0
+#define GC_BASE__INST3_SEG2                        0
+#define GC_BASE__INST3_SEG3                        0
+#define GC_BASE__INST3_SEG4                        0
+#define GC_BASE__INST3_SEG5                        0
+
+#define GC_BASE__INST4_SEG0                        0
+#define GC_BASE__INST4_SEG1                        0
+#define GC_BASE__INST4_SEG2                        0
+#define GC_BASE__INST4_SEG3                        0
+#define GC_BASE__INST4_SEG4                        0
+#define GC_BASE__INST4_SEG5                        0
+
+#define GC_BASE__INST5_SEG0                        0
+#define GC_BASE__INST5_SEG1                        0
+#define GC_BASE__INST5_SEG2                        0
+#define GC_BASE__INST5_SEG3                        0
+#define GC_BASE__INST5_SEG4                        0
+#define GC_BASE__INST5_SEG5                        0
+
+#define GC_BASE__INST6_SEG0                        0
+#define GC_BASE__INST6_SEG1                        0
+#define GC_BASE__INST6_SEG2                        0
+#define GC_BASE__INST6_SEG3                        0
+#define GC_BASE__INST6_SEG4                        0
+#define GC_BASE__INST6_SEG5                        0
+
+#define HDP_BASE__INST0_SEG0                       0x00000F20
+#define HDP_BASE__INST0_SEG1                       0x0240A400
+#define HDP_BASE__INST0_SEG2                       0
+#define HDP_BASE__INST0_SEG3                       0
+#define HDP_BASE__INST0_SEG4                       0
+#define HDP_BASE__INST0_SEG5                       0
+
+#define HDP_BASE__INST1_SEG0                       0
+#define HDP_BASE__INST1_SEG1                       0
+#define HDP_BASE__INST1_SEG2                       0
+#define HDP_BASE__INST1_SEG3                       0
+#define HDP_BASE__INST1_SEG4                       0
+#define HDP_BASE__INST1_SEG5                       0
+
+#define HDP_BASE__INST2_SEG0                       0
+#define HDP_BASE__INST2_SEG1                       0
+#define HDP_BASE__INST2_SEG2                       0
+#define HDP_BASE__INST2_SEG3                       0
+#define HDP_BASE__INST2_SEG4                       0
+#define HDP_BASE__INST2_SEG5                       0
+
+#define HDP_BASE__INST3_SEG0                       0
+#define HDP_BASE__INST3_SEG1                       0
+#define HDP_BASE__INST3_SEG2                       0
+#define HDP_BASE__INST3_SEG3                       0
+#define HDP_BASE__INST3_SEG4                       0
+#define HDP_BASE__INST3_SEG5                       0
+
+#define HDP_BASE__INST4_SEG0                       0
+#define HDP_BASE__INST4_SEG1                       0
+#define HDP_BASE__INST4_SEG2                       0
+#define HDP_BASE__INST4_SEG3                       0
+#define HDP_BASE__INST4_SEG4                       0
+#define HDP_BASE__INST4_SEG5                       0
+
+#define HDP_BASE__INST5_SEG0                       0
+#define HDP_BASE__INST5_SEG1                       0
+#define HDP_BASE__INST5_SEG2                       0
+#define HDP_BASE__INST5_SEG3                       0
+#define HDP_BASE__INST5_SEG4                       0
+#define HDP_BASE__INST5_SEG5                       0
+
+#define HDP_BASE__INST6_SEG0                       0
+#define HDP_BASE__INST6_SEG1                       0
+#define HDP_BASE__INST6_SEG2                       0
+#define HDP_BASE__INST6_SEG3                       0
+#define HDP_BASE__INST6_SEG4                       0
+#define HDP_BASE__INST6_SEG5                       0
+
+#define IOAGR0_BASE__INST0_SEG0                    0x02419000
+#define IOAGR0_BASE__INST0_SEG1                    0x056C0000
+#define IOAGR0_BASE__INST0_SEG2                    0
+#define IOAGR0_BASE__INST0_SEG3                    0
+#define IOAGR0_BASE__INST0_SEG4                    0
+#define IOAGR0_BASE__INST0_SEG5                    0
+
+#define IOAGR0_BASE__INST1_SEG0                    0
+#define IOAGR0_BASE__INST1_SEG1                    0
+#define IOAGR0_BASE__INST1_SEG2                    0
+#define IOAGR0_BASE__INST1_SEG3                    0
+#define IOAGR0_BASE__INST1_SEG4                    0
+#define IOAGR0_BASE__INST1_SEG5                    0
+
+#define IOAGR0_BASE__INST2_SEG0                    0
+#define IOAGR0_BASE__INST2_SEG1                    0
+#define IOAGR0_BASE__INST2_SEG2                    0
+#define IOAGR0_BASE__INST2_SEG3                    0
+#define IOAGR0_BASE__INST2_SEG4                    0
+#define IOAGR0_BASE__INST2_SEG5                    0
+
+#define IOAGR0_BASE__INST3_SEG0                    0
+#define IOAGR0_BASE__INST3_SEG1                    0
+#define IOAGR0_BASE__INST3_SEG2                    0
+#define IOAGR0_BASE__INST3_SEG3                    0
+#define IOAGR0_BASE__INST3_SEG4                    0
+#define IOAGR0_BASE__INST3_SEG5                    0
+
+#define IOAGR0_BASE__INST4_SEG0                    0
+#define IOAGR0_BASE__INST4_SEG1                    0
+#define IOAGR0_BASE__INST4_SEG2                    0
+#define IOAGR0_BASE__INST4_SEG3                    0
+#define IOAGR0_BASE__INST4_SEG4                    0
+#define IOAGR0_BASE__INST4_SEG5                    0
+
+#define IOAGR0_BASE__INST5_SEG0                    0
+#define IOAGR0_BASE__INST5_SEG1                    0
+#define IOAGR0_BASE__INST5_SEG2                    0
+#define IOAGR0_BASE__INST5_SEG3                    0
+#define IOAGR0_BASE__INST5_SEG4                    0
+#define IOAGR0_BASE__INST5_SEG5                    0
+
+#define IOAGR0_BASE__INST6_SEG0                    0
+#define IOAGR0_BASE__INST6_SEG1                    0
+#define IOAGR0_BASE__INST6_SEG2                    0
+#define IOAGR0_BASE__INST6_SEG3                    0
+#define IOAGR0_BASE__INST6_SEG4                    0
+#define IOAGR0_BASE__INST6_SEG5                    0
+
+#define IOAPIC0_BASE__INST0_SEG0                   0x00A00000
+#define IOAPIC0_BASE__INST0_SEG1                   0x0241F000
+#define IOAPIC0_BASE__INST0_SEG2                   0x050C0000
+#define IOAPIC0_BASE__INST0_SEG3                   0
+#define IOAPIC0_BASE__INST0_SEG4                   0
+#define IOAPIC0_BASE__INST0_SEG5                   0
+
+#define IOAPIC0_BASE__INST1_SEG0                   0
+#define IOAPIC0_BASE__INST1_SEG1                   0
+#define IOAPIC0_BASE__INST1_SEG2                   0
+#define IOAPIC0_BASE__INST1_SEG3                   0
+#define IOAPIC0_BASE__INST1_SEG4                   0
+#define IOAPIC0_BASE__INST1_SEG5                   0
+
+#define IOAPIC0_BASE__INST2_SEG0                   0
+#define IOAPIC0_BASE__INST2_SEG1                   0
+#define IOAPIC0_BASE__INST2_SEG2                   0
+#define IOAPIC0_BASE__INST2_SEG3                   0
+#define IOAPIC0_BASE__INST2_SEG4                   0
+#define IOAPIC0_BASE__INST2_SEG5                   0
+
+#define IOAPIC0_BASE__INST3_SEG0                   0
+#define IOAPIC0_BASE__INST3_SEG1                   0
+#define IOAPIC0_BASE__INST3_SEG2                   0
+#define IOAPIC0_BASE__INST3_SEG3                   0
+#define IOAPIC0_BASE__INST3_SEG4                   0
+#define IOAPIC0_BASE__INST3_SEG5                   0
+
+#define IOAPIC0_BASE__INST4_SEG0                   0
+#define IOAPIC0_BASE__INST4_SEG1                   0
+#define IOAPIC0_BASE__INST4_SEG2                   0
+#define IOAPIC0_BASE__INST4_SEG3                   0
+#define IOAPIC0_BASE__INST4_SEG4                   0
+#define IOAPIC0_BASE__INST4_SEG5                   0
+
+#define IOAPIC0_BASE__INST5_SEG0                   0
+#define IOAPIC0_BASE__INST5_SEG1                   0
+#define IOAPIC0_BASE__INST5_SEG2                   0
+#define IOAPIC0_BASE__INST5_SEG3                   0
+#define IOAPIC0_BASE__INST5_SEG4                   0
+#define IOAPIC0_BASE__INST5_SEG5                   0
+
+#define IOAPIC0_BASE__INST6_SEG0                   0
+#define IOAPIC0_BASE__INST6_SEG1                   0
+#define IOAPIC0_BASE__INST6_SEG2                   0
+#define IOAPIC0_BASE__INST6_SEG3                   0
+#define IOAPIC0_BASE__INST6_SEG4                   0
+#define IOAPIC0_BASE__INST6_SEG5                   0
+
+#define IOHC0_BASE__INST0_SEG0                     0x00010000
+#define IOHC0_BASE__INST0_SEG1                     0x02406000
+#define IOHC0_BASE__INST0_SEG2                     0x04EC0000
+#define IOHC0_BASE__INST0_SEG3                     0
+#define IOHC0_BASE__INST0_SEG4                     0
+#define IOHC0_BASE__INST0_SEG5                     0
+
+#define IOHC0_BASE__INST1_SEG0                     0
+#define IOHC0_BASE__INST1_SEG1                     0
+#define IOHC0_BASE__INST1_SEG2                     0
+#define IOHC0_BASE__INST1_SEG3                     0
+#define IOHC0_BASE__INST1_SEG4                     0
+#define IOHC0_BASE__INST1_SEG5                     0
+
+#define IOHC0_BASE__INST2_SEG0                     0
+#define IOHC0_BASE__INST2_SEG1                     0
+#define IOHC0_BASE__INST2_SEG2                     0
+#define IOHC0_BASE__INST2_SEG3                     0
+#define IOHC0_BASE__INST2_SEG4                     0
+#define IOHC0_BASE__INST2_SEG5                     0
+
+#define IOHC0_BASE__INST3_SEG0                     0
+#define IOHC0_BASE__INST3_SEG1                     0
+#define IOHC0_BASE__INST3_SEG2                     0
+#define IOHC0_BASE__INST3_SEG3                     0
+#define IOHC0_BASE__INST3_SEG4                     0
+#define IOHC0_BASE__INST3_SEG5                     0
+
+#define IOHC0_BASE__INST4_SEG0                     0
+#define IOHC0_BASE__INST4_SEG1                     0
+#define IOHC0_BASE__INST4_SEG2                     0
+#define IOHC0_BASE__INST4_SEG3                     0
+#define IOHC0_BASE__INST4_SEG4                     0
+#define IOHC0_BASE__INST4_SEG5                     0
+
+#define IOHC0_BASE__INST5_SEG0                     0
+#define IOHC0_BASE__INST5_SEG1                     0
+#define IOHC0_BASE__INST5_SEG2                     0
+#define IOHC0_BASE__INST5_SEG3                     0
+#define IOHC0_BASE__INST5_SEG4                     0
+#define IOHC0_BASE__INST5_SEG5                     0
+
+#define IOHC0_BASE__INST6_SEG0                     0
+#define IOHC0_BASE__INST6_SEG1                     0
+#define IOHC0_BASE__INST6_SEG2                     0
+#define IOHC0_BASE__INST6_SEG3                     0
+#define IOHC0_BASE__INST6_SEG4                     0
+#define IOHC0_BASE__INST6_SEG5                     0
+
+#define L1IMUIOAGR0_BASE__INST0_SEG0               0x0240CC00
+#define L1IMUIOAGR0_BASE__INST0_SEG1               0x05200000
+#define L1IMUIOAGR0_BASE__INST0_SEG2               0
+#define L1IMUIOAGR0_BASE__INST0_SEG3               0
+#define L1IMUIOAGR0_BASE__INST0_SEG4               0
+#define L1IMUIOAGR0_BASE__INST0_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST1_SEG0               0
+#define L1IMUIOAGR0_BASE__INST1_SEG1               0
+#define L1IMUIOAGR0_BASE__INST1_SEG2               0
+#define L1IMUIOAGR0_BASE__INST1_SEG3               0
+#define L1IMUIOAGR0_BASE__INST1_SEG4               0
+#define L1IMUIOAGR0_BASE__INST1_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST2_SEG0               0
+#define L1IMUIOAGR0_BASE__INST2_SEG1               0
+#define L1IMUIOAGR0_BASE__INST2_SEG2               0
+#define L1IMUIOAGR0_BASE__INST2_SEG3               0
+#define L1IMUIOAGR0_BASE__INST2_SEG4               0
+#define L1IMUIOAGR0_BASE__INST2_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST3_SEG0               0
+#define L1IMUIOAGR0_BASE__INST3_SEG1               0
+#define L1IMUIOAGR0_BASE__INST3_SEG2               0
+#define L1IMUIOAGR0_BASE__INST3_SEG3               0
+#define L1IMUIOAGR0_BASE__INST3_SEG4               0
+#define L1IMUIOAGR0_BASE__INST3_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST4_SEG0               0
+#define L1IMUIOAGR0_BASE__INST4_SEG1               0
+#define L1IMUIOAGR0_BASE__INST4_SEG2               0
+#define L1IMUIOAGR0_BASE__INST4_SEG3               0
+#define L1IMUIOAGR0_BASE__INST4_SEG4               0
+#define L1IMUIOAGR0_BASE__INST4_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST5_SEG0               0
+#define L1IMUIOAGR0_BASE__INST5_SEG1               0
+#define L1IMUIOAGR0_BASE__INST5_SEG2               0
+#define L1IMUIOAGR0_BASE__INST5_SEG3               0
+#define L1IMUIOAGR0_BASE__INST5_SEG4               0
+#define L1IMUIOAGR0_BASE__INST5_SEG5               0
+
+#define L1IMUIOAGR0_BASE__INST6_SEG0               0
+#define L1IMUIOAGR0_BASE__INST6_SEG1               0
+#define L1IMUIOAGR0_BASE__INST6_SEG2               0
+#define L1IMUIOAGR0_BASE__INST6_SEG3               0
+#define L1IMUIOAGR0_BASE__INST6_SEG4               0
+#define L1IMUIOAGR0_BASE__INST6_SEG5               0
+
+#define L1IMUPCIE0_BASE__INST0_SEG0                0x0240C800
+#define L1IMUPCIE0_BASE__INST0_SEG1                0x051C0000
+#define L1IMUPCIE0_BASE__INST0_SEG2                0
+#define L1IMUPCIE0_BASE__INST0_SEG3                0
+#define L1IMUPCIE0_BASE__INST0_SEG4                0
+#define L1IMUPCIE0_BASE__INST0_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST1_SEG0                0
+#define L1IMUPCIE0_BASE__INST1_SEG1                0
+#define L1IMUPCIE0_BASE__INST1_SEG2                0
+#define L1IMUPCIE0_BASE__INST1_SEG3                0
+#define L1IMUPCIE0_BASE__INST1_SEG4                0
+#define L1IMUPCIE0_BASE__INST1_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST2_SEG0                0
+#define L1IMUPCIE0_BASE__INST2_SEG1                0
+#define L1IMUPCIE0_BASE__INST2_SEG2                0
+#define L1IMUPCIE0_BASE__INST2_SEG3                0
+#define L1IMUPCIE0_BASE__INST2_SEG4                0
+#define L1IMUPCIE0_BASE__INST2_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST3_SEG0                0
+#define L1IMUPCIE0_BASE__INST3_SEG1                0
+#define L1IMUPCIE0_BASE__INST3_SEG2                0
+#define L1IMUPCIE0_BASE__INST3_SEG3                0
+#define L1IMUPCIE0_BASE__INST3_SEG4                0
+#define L1IMUPCIE0_BASE__INST3_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST4_SEG0                0
+#define L1IMUPCIE0_BASE__INST4_SEG1                0
+#define L1IMUPCIE0_BASE__INST4_SEG2                0
+#define L1IMUPCIE0_BASE__INST4_SEG3                0
+#define L1IMUPCIE0_BASE__INST4_SEG4                0
+#define L1IMUPCIE0_BASE__INST4_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST5_SEG0                0
+#define L1IMUPCIE0_BASE__INST5_SEG1                0
+#define L1IMUPCIE0_BASE__INST5_SEG2                0
+#define L1IMUPCIE0_BASE__INST5_SEG3                0
+#define L1IMUPCIE0_BASE__INST5_SEG4                0
+#define L1IMUPCIE0_BASE__INST5_SEG5                0
+
+#define L1IMUPCIE0_BASE__INST6_SEG0                0
+#define L1IMUPCIE0_BASE__INST6_SEG1                0
+#define L1IMUPCIE0_BASE__INST6_SEG2                0
+#define L1IMUPCIE0_BASE__INST6_SEG3                0
+#define L1IMUPCIE0_BASE__INST6_SEG4                0
+#define L1IMUPCIE0_BASE__INST6_SEG5                0
+
+#define L2IMU0_BASE__INST0_SEG0                    0x00007DC0
+#define L2IMU0_BASE__INST0_SEG1                    0x00900000
+#define L2IMU0_BASE__INST0_SEG2                    0x02407000
+#define L2IMU0_BASE__INST0_SEG3                    0x04FC0000
+#define L2IMU0_BASE__INST0_SEG4                    0x055C0000
+#define L2IMU0_BASE__INST0_SEG5                    0
+
+#define L2IMU0_BASE__INST1_SEG0                    0
+#define L2IMU0_BASE__INST1_SEG1                    0
+#define L2IMU0_BASE__INST1_SEG2                    0
+#define L2IMU0_BASE__INST1_SEG3                    0
+#define L2IMU0_BASE__INST1_SEG4                    0
+#define L2IMU0_BASE__INST1_SEG5                    0
+
+#define L2IMU0_BASE__INST2_SEG0                    0
+#define L2IMU0_BASE__INST2_SEG1                    0
+#define L2IMU0_BASE__INST2_SEG2                    0
+#define L2IMU0_BASE__INST2_SEG3                    0
+#define L2IMU0_BASE__INST2_SEG4                    0
+#define L2IMU0_BASE__INST2_SEG5                    0
+
+#define L2IMU0_BASE__INST3_SEG0                    0
+#define L2IMU0_BASE__INST3_SEG1                    0
+#define L2IMU0_BASE__INST3_SEG2                    0
+#define L2IMU0_BASE__INST3_SEG3                    0
+#define L2IMU0_BASE__INST3_SEG4                    0
+#define L2IMU0_BASE__INST3_SEG5                    0
+
+#define L2IMU0_BASE__INST4_SEG0                    0
+#define L2IMU0_BASE__INST4_SEG1                    0
+#define L2IMU0_BASE__INST4_SEG2                    0
+#define L2IMU0_BASE__INST4_SEG3                    0
+#define L2IMU0_BASE__INST4_SEG4                    0
+#define L2IMU0_BASE__INST4_SEG5                    0
+
+#define L2IMU0_BASE__INST5_SEG0                    0
+#define L2IMU0_BASE__INST5_SEG1                    0
+#define L2IMU0_BASE__INST5_SEG2                    0
+#define L2IMU0_BASE__INST5_SEG3                    0
+#define L2IMU0_BASE__INST5_SEG4                    0
+#define L2IMU0_BASE__INST5_SEG5                    0
+
+#define L2IMU0_BASE__INST6_SEG0                    0
+#define L2IMU0_BASE__INST6_SEG1                    0
+#define L2IMU0_BASE__INST6_SEG2                    0
+#define L2IMU0_BASE__INST6_SEG3                    0
+#define L2IMU0_BASE__INST6_SEG4                    0
+#define L2IMU0_BASE__INST6_SEG5                    0
+
+#define MMHUB_BASE__INST0_SEG0                     0x0001A000
+#define MMHUB_BASE__INST0_SEG1                     0x02408800
+#define MMHUB_BASE__INST0_SEG2                     0
+#define MMHUB_BASE__INST0_SEG3                     0
+#define MMHUB_BASE__INST0_SEG4                     0
+#define MMHUB_BASE__INST0_SEG5                     0
+
+#define MMHUB_BASE__INST1_SEG0                     0
+#define MMHUB_BASE__INST1_SEG1                     0
+#define MMHUB_BASE__INST1_SEG2                     0
+#define MMHUB_BASE__INST1_SEG3                     0
+#define MMHUB_BASE__INST1_SEG4                     0
+#define MMHUB_BASE__INST1_SEG5                     0
+
+#define MMHUB_BASE__INST2_SEG0                     0
+#define MMHUB_BASE__INST2_SEG1                     0
+#define MMHUB_BASE__INST2_SEG2                     0
+#define MMHUB_BASE__INST2_SEG3                     0
+#define MMHUB_BASE__INST2_SEG4                     0
+#define MMHUB_BASE__INST2_SEG5                     0
+
+#define MMHUB_BASE__INST3_SEG0                     0
+#define MMHUB_BASE__INST3_SEG1                     0
+#define MMHUB_BASE__INST3_SEG2                     0
+#define MMHUB_BASE__INST3_SEG3                     0
+#define MMHUB_BASE__INST3_SEG4                     0
+#define MMHUB_BASE__INST3_SEG5                     0
+
+#define MMHUB_BASE__INST4_SEG0                     0
+#define MMHUB_BASE__INST4_SEG1                     0
+#define MMHUB_BASE__INST4_SEG2                     0
+#define MMHUB_BASE__INST4_SEG3                     0
+#define MMHUB_BASE__INST4_SEG4                     0
+#define MMHUB_BASE__INST4_SEG5                     0
+
+#define MMHUB_BASE__INST5_SEG0                     0
+#define MMHUB_BASE__INST5_SEG1                     0
+#define MMHUB_BASE__INST5_SEG2                     0
+#define MMHUB_BASE__INST5_SEG3                     0
+#define MMHUB_BASE__INST5_SEG4                     0
+#define MMHUB_BASE__INST5_SEG5                     0
+
+#define MMHUB_BASE__INST6_SEG0                     0
+#define MMHUB_BASE__INST6_SEG1                     0
+#define MMHUB_BASE__INST6_SEG2                     0
+#define MMHUB_BASE__INST6_SEG3                     0
+#define MMHUB_BASE__INST6_SEG4                     0
+#define MMHUB_BASE__INST6_SEG5                     0
+
+#define MP0_BASE__INST0_SEG0                       0x00016000
+#define MP0_BASE__INST0_SEG1                       0x00DC0000
+#define MP0_BASE__INST0_SEG2                       0x00E00000
+#define MP0_BASE__INST0_SEG3                       0x00E40000
+#define MP0_BASE__INST0_SEG4                       0x0243FC00
+#define MP0_BASE__INST0_SEG5                       0
+
+#define MP0_BASE__INST1_SEG0                       0
+#define MP0_BASE__INST1_SEG1                       0
+#define MP0_BASE__INST1_SEG2                       0
+#define MP0_BASE__INST1_SEG3                       0
+#define MP0_BASE__INST1_SEG4                       0
+#define MP0_BASE__INST1_SEG5                       0
+
+#define MP0_BASE__INST2_SEG0                       0
+#define MP0_BASE__INST2_SEG1                       0
+#define MP0_BASE__INST2_SEG2                       0
+#define MP0_BASE__INST2_SEG3                       0
+#define MP0_BASE__INST2_SEG4                       0
+#define MP0_BASE__INST2_SEG5                       0
+
+#define MP0_BASE__INST3_SEG0                       0
+#define MP0_BASE__INST3_SEG1                       0
+#define MP0_BASE__INST3_SEG2                       0
+#define MP0_BASE__INST3_SEG3                       0
+#define MP0_BASE__INST3_SEG4                       0
+#define MP0_BASE__INST3_SEG5                       0
+
+#define MP0_BASE__INST4_SEG0                       0
+#define MP0_BASE__INST4_SEG1                       0
+#define MP0_BASE__INST4_SEG2                       0
+#define MP0_BASE__INST4_SEG3                       0
+#define MP0_BASE__INST4_SEG4                       0
+#define MP0_BASE__INST4_SEG5                       0
+
+#define MP0_BASE__INST5_SEG0                       0
+#define MP0_BASE__INST5_SEG1                       0
+#define MP0_BASE__INST5_SEG2                       0
+#define MP0_BASE__INST5_SEG3                       0
+#define MP0_BASE__INST5_SEG4                       0
+#define MP0_BASE__INST5_SEG5                       0
+
+#define MP0_BASE__INST6_SEG0                       0
+#define MP0_BASE__INST6_SEG1                       0
+#define MP0_BASE__INST6_SEG2                       0
+#define MP0_BASE__INST6_SEG3                       0
+#define MP0_BASE__INST6_SEG4                       0
+#define MP0_BASE__INST6_SEG5                       0
+
+#define MP1_BASE__INST0_SEG0                       0x00016000
+#define MP1_BASE__INST0_SEG1                       0x00DC0000
+#define MP1_BASE__INST0_SEG2                       0x00E00000
+#define MP1_BASE__INST0_SEG3                       0x00E40000
+#define MP1_BASE__INST0_SEG4                       0x0243FC00
+#define MP1_BASE__INST0_SEG5                       0
+
+#define MP1_BASE__INST1_SEG0                       0
+#define MP1_BASE__INST1_SEG1                       0
+#define MP1_BASE__INST1_SEG2                       0
+#define MP1_BASE__INST1_SEG3                       0
+#define MP1_BASE__INST1_SEG4                       0
+#define MP1_BASE__INST1_SEG5                       0
+
+#define MP1_BASE__INST2_SEG0                       0
+#define MP1_BASE__INST2_SEG1                       0
+#define MP1_BASE__INST2_SEG2                       0
+#define MP1_BASE__INST2_SEG3                       0
+#define MP1_BASE__INST2_SEG4                       0
+#define MP1_BASE__INST2_SEG5                       0
+
+#define MP1_BASE__INST3_SEG0                       0
+#define MP1_BASE__INST3_SEG1                       0
+#define MP1_BASE__INST3_SEG2                       0
+#define MP1_BASE__INST3_SEG3                       0
+#define MP1_BASE__INST3_SEG4                       0
+#define MP1_BASE__INST3_SEG5                       0
+
+#define MP1_BASE__INST4_SEG0                       0
+#define MP1_BASE__INST4_SEG1                       0
+#define MP1_BASE__INST4_SEG2                       0
+#define MP1_BASE__INST4_SEG3                       0
+#define MP1_BASE__INST4_SEG4                       0
+#define MP1_BASE__INST4_SEG5                       0
+
+#define MP1_BASE__INST5_SEG0                       0
+#define MP1_BASE__INST5_SEG1                       0
+#define MP1_BASE__INST5_SEG2                       0
+#define MP1_BASE__INST5_SEG3                       0
+#define MP1_BASE__INST5_SEG4                       0
+#define MP1_BASE__INST5_SEG5                       0
+
+#define MP1_BASE__INST6_SEG0                       0
+#define MP1_BASE__INST6_SEG1                       0
+#define MP1_BASE__INST6_SEG2                       0
+#define MP1_BASE__INST6_SEG3                       0
+#define MP1_BASE__INST6_SEG4                       0
+#define MP1_BASE__INST6_SEG5                       0
+
+#define NBIO_BASE__INST0_SEG0                      0x00000000
+#define NBIO_BASE__INST0_SEG1                      0x00000014
+#define NBIO_BASE__INST0_SEG2                      0x00000D20
+#define NBIO_BASE__INST0_SEG3                      0x00010400
+#define NBIO_BASE__INST0_SEG4                      0x0241B000
+#define NBIO_BASE__INST0_SEG5                      0x04040000
+
+#define NBIO_BASE__INST1_SEG0                      0
+#define NBIO_BASE__INST1_SEG1                      0
+#define NBIO_BASE__INST1_SEG2                      0
+#define NBIO_BASE__INST1_SEG3                      0
+#define NBIO_BASE__INST1_SEG4                      0
+#define NBIO_BASE__INST1_SEG5                      0
+
+#define NBIO_BASE__INST2_SEG0                      0
+#define NBIO_BASE__INST2_SEG1                      0
+#define NBIO_BASE__INST2_SEG2                      0
+#define NBIO_BASE__INST2_SEG3                      0
+#define NBIO_BASE__INST2_SEG4                      0
+#define NBIO_BASE__INST2_SEG5                      0
+
+#define NBIO_BASE__INST3_SEG0                      0
+#define NBIO_BASE__INST3_SEG1                      0
+#define NBIO_BASE__INST3_SEG2                      0
+#define NBIO_BASE__INST3_SEG3                      0
+#define NBIO_BASE__INST3_SEG4                      0
+#define NBIO_BASE__INST3_SEG5                      0
+
+#define NBIO_BASE__INST4_SEG0                      0
+#define NBIO_BASE__INST4_SEG1                      0
+#define NBIO_BASE__INST4_SEG2                      0
+#define NBIO_BASE__INST4_SEG3                      0
+#define NBIO_BASE__INST4_SEG4                      0
+#define NBIO_BASE__INST4_SEG5                      0
+
+#define NBIO_BASE__INST5_SEG0                      0
+#define NBIO_BASE__INST5_SEG1                      0
+#define NBIO_BASE__INST5_SEG2                      0
+#define NBIO_BASE__INST5_SEG3                      0
+#define NBIO_BASE__INST5_SEG4                      0
+#define NBIO_BASE__INST5_SEG5                      0
+
+#define NBIO_BASE__INST6_SEG0                      0
+#define NBIO_BASE__INST6_SEG1                      0
+#define NBIO_BASE__INST6_SEG2                      0
+#define NBIO_BASE__INST6_SEG3                      0
+#define NBIO_BASE__INST6_SEG4                      0
+#define NBIO_BASE__INST6_SEG5                      0
+
+#define OSSSYS_BASE__INST0_SEG0                    0x000010A0
+#define OSSSYS_BASE__INST0_SEG1                    0x0240A000
+#define OSSSYS_BASE__INST0_SEG2                    0
+#define OSSSYS_BASE__INST0_SEG3                    0
+#define OSSSYS_BASE__INST0_SEG4                    0
+#define OSSSYS_BASE__INST0_SEG5                    0
+
+#define OSSSYS_BASE__INST1_SEG0                    0
+#define OSSSYS_BASE__INST1_SEG1                    0
+#define OSSSYS_BASE__INST1_SEG2                    0
+#define OSSSYS_BASE__INST1_SEG3                    0
+#define OSSSYS_BASE__INST1_SEG4                    0
+#define OSSSYS_BASE__INST1_SEG5                    0
+
+#define OSSSYS_BASE__INST2_SEG0                    0
+#define OSSSYS_BASE__INST2_SEG1                    0
+#define OSSSYS_BASE__INST2_SEG2                    0
+#define OSSSYS_BASE__INST2_SEG3                    0
+#define OSSSYS_BASE__INST2_SEG4                    0
+#define OSSSYS_BASE__INST2_SEG5                    0
+
+#define OSSSYS_BASE__INST3_SEG0                    0
+#define OSSSYS_BASE__INST3_SEG1                    0
+#define OSSSYS_BASE__INST3_SEG2                    0
+#define OSSSYS_BASE__INST3_SEG3                    0
+#define OSSSYS_BASE__INST3_SEG4                    0
+#define OSSSYS_BASE__INST3_SEG5                    0
+
+#define OSSSYS_BASE__INST4_SEG0                    0
+#define OSSSYS_BASE__INST4_SEG1                    0
+#define OSSSYS_BASE__INST4_SEG2                    0
+#define OSSSYS_BASE__INST4_SEG3                    0
+#define OSSSYS_BASE__INST4_SEG4                    0
+#define OSSSYS_BASE__INST4_SEG5                    0
+
+#define OSSSYS_BASE__INST5_SEG0                    0
+#define OSSSYS_BASE__INST5_SEG1                    0
+#define OSSSYS_BASE__INST5_SEG2                    0
+#define OSSSYS_BASE__INST5_SEG3                    0
+#define OSSSYS_BASE__INST5_SEG4                    0
+#define OSSSYS_BASE__INST5_SEG5                    0
+
+#define OSSSYS_BASE__INST6_SEG0                    0
+#define OSSSYS_BASE__INST6_SEG1                    0
+#define OSSSYS_BASE__INST6_SEG2                    0
+#define OSSSYS_BASE__INST6_SEG3                    0
+#define OSSSYS_BASE__INST6_SEG4                    0
+#define OSSSYS_BASE__INST6_SEG5                    0
+
+#define PCIE0_BASE__INST0_SEG0                     0x02411800
+#define PCIE0_BASE__INST0_SEG1                     0x04440000
+#define PCIE0_BASE__INST0_SEG2                     0
+#define PCIE0_BASE__INST0_SEG3                     0
+#define PCIE0_BASE__INST0_SEG4                     0
+#define PCIE0_BASE__INST0_SEG5                     0
+
+#define PCIE0_BASE__INST1_SEG0                     0
+#define PCIE0_BASE__INST1_SEG1                     0
+#define PCIE0_BASE__INST1_SEG2                     0
+#define PCIE0_BASE__INST1_SEG3                     0
+#define PCIE0_BASE__INST1_SEG4                     0
+#define PCIE0_BASE__INST1_SEG5                     0
+
+#define PCIE0_BASE__INST2_SEG0                     0
+#define PCIE0_BASE__INST2_SEG1                     0
+#define PCIE0_BASE__INST2_SEG2                     0
+#define PCIE0_BASE__INST2_SEG3                     0
+#define PCIE0_BASE__INST2_SEG4                     0
+#define PCIE0_BASE__INST2_SEG5                     0
+
+#define PCIE0_BASE__INST3_SEG0                     0
+#define PCIE0_BASE__INST3_SEG1                     0
+#define PCIE0_BASE__INST3_SEG2                     0
+#define PCIE0_BASE__INST3_SEG3                     0
+#define PCIE0_BASE__INST3_SEG4                     0
+#define PCIE0_BASE__INST3_SEG5                     0
+
+#define PCIE0_BASE__INST4_SEG0                     0
+#define PCIE0_BASE__INST4_SEG1                     0
+#define PCIE0_BASE__INST4_SEG2                     0
+#define PCIE0_BASE__INST4_SEG3                     0
+#define PCIE0_BASE__INST4_SEG4                     0
+#define PCIE0_BASE__INST4_SEG5                     0
+
+#define PCIE0_BASE__INST5_SEG0                     0
+#define PCIE0_BASE__INST5_SEG1                     0
+#define PCIE0_BASE__INST5_SEG2                     0
+#define PCIE0_BASE__INST5_SEG3                     0
+#define PCIE0_BASE__INST5_SEG4                     0
+#define PCIE0_BASE__INST5_SEG5                     0
+
+#define PCIE0_BASE__INST6_SEG0                     0
+#define PCIE0_BASE__INST6_SEG1                     0
+#define PCIE0_BASE__INST6_SEG2                     0
+#define PCIE0_BASE__INST6_SEG3                     0
+#define PCIE0_BASE__INST6_SEG4                     0
+#define PCIE0_BASE__INST6_SEG5                     0
+
+#define SDMA0_BASE__INST0_SEG0                     0x00001260
+#define SDMA0_BASE__INST0_SEG1                     0x02445400
+#define SDMA0_BASE__INST0_SEG2                     0
+#define SDMA0_BASE__INST0_SEG3                     0
+#define SDMA0_BASE__INST0_SEG4                     0
+#define SDMA0_BASE__INST0_SEG5                     0
+
+#define SDMA0_BASE__INST1_SEG0                     0
+#define SDMA0_BASE__INST1_SEG1                     0
+#define SDMA0_BASE__INST1_SEG2                     0
+#define SDMA0_BASE__INST1_SEG3                     0
+#define SDMA0_BASE__INST1_SEG4                     0
+#define SDMA0_BASE__INST1_SEG5                     0
+
+#define SDMA0_BASE__INST2_SEG0                     0
+#define SDMA0_BASE__INST2_SEG1                     0
+#define SDMA0_BASE__INST2_SEG2                     0
+#define SDMA0_BASE__INST2_SEG3                     0
+#define SDMA0_BASE__INST2_SEG4                     0
+#define SDMA0_BASE__INST2_SEG5                     0
+
+#define SDMA0_BASE__INST3_SEG0                     0
+#define SDMA0_BASE__INST3_SEG1                     0
+#define SDMA0_BASE__INST3_SEG2                     0
+#define SDMA0_BASE__INST3_SEG3                     0
+#define SDMA0_BASE__INST3_SEG4                     0
+#define SDMA0_BASE__INST3_SEG5                     0
+
+#define SDMA0_BASE__INST4_SEG0                     0
+#define SDMA0_BASE__INST4_SEG1                     0
+#define SDMA0_BASE__INST4_SEG2                     0
+#define SDMA0_BASE__INST4_SEG3                     0
+#define SDMA0_BASE__INST4_SEG4                     0
+#define SDMA0_BASE__INST4_SEG5                     0
+
+#define SDMA0_BASE__INST5_SEG0                     0
+#define SDMA0_BASE__INST5_SEG1                     0
+#define SDMA0_BASE__INST5_SEG2                     0
+#define SDMA0_BASE__INST5_SEG3                     0
+#define SDMA0_BASE__INST5_SEG4                     0
+#define SDMA0_BASE__INST5_SEG5                     0
+
+#define SDMA0_BASE__INST6_SEG0                     0
+#define SDMA0_BASE__INST6_SEG1                     0
+#define SDMA0_BASE__INST6_SEG2                     0
+#define SDMA0_BASE__INST6_SEG3                     0
+#define SDMA0_BASE__INST6_SEG4                     0
+#define SDMA0_BASE__INST6_SEG5                     0
+
+#define SDMA1_BASE__INST0_SEG0                     0x00001860
+#define SDMA1_BASE__INST0_SEG1                     0x02445800
+#define SDMA1_BASE__INST0_SEG2                     0
+#define SDMA1_BASE__INST0_SEG3                     0
+#define SDMA1_BASE__INST0_SEG4                     0
+#define SDMA1_BASE__INST0_SEG5                     0
+
+#define SDMA1_BASE__INST1_SEG0                     0x0001E000
+#define SDMA1_BASE__INST1_SEG1                     0x02446400
+#define SDMA1_BASE__INST1_SEG2                     0
+#define SDMA1_BASE__INST1_SEG3                     0
+#define SDMA1_BASE__INST1_SEG4                     0
+#define SDMA1_BASE__INST1_SEG5                     0
+
+#define SDMA1_BASE__INST2_SEG0                     0x0001E400
+#define SDMA1_BASE__INST2_SEG1                     0x02446800
+#define SDMA1_BASE__INST2_SEG2                     0
+#define SDMA1_BASE__INST2_SEG3                     0
+#define SDMA1_BASE__INST2_SEG4                     0
+#define SDMA1_BASE__INST2_SEG5                     0
+
+#define SDMA1_BASE__INST3_SEG0                     0x0001E800
+#define SDMA1_BASE__INST3_SEG1                     0x02446C00
+#define SDMA1_BASE__INST3_SEG2                     0
+#define SDMA1_BASE__INST3_SEG3                     0
+#define SDMA1_BASE__INST3_SEG4                     0
+#define SDMA1_BASE__INST3_SEG5                     0
+
+#define SDMA1_BASE__INST4_SEG0                     0
+#define SDMA1_BASE__INST4_SEG1                     0
+#define SDMA1_BASE__INST4_SEG2                     0
+#define SDMA1_BASE__INST4_SEG3                     0
+#define SDMA1_BASE__INST4_SEG4                     0
+#define SDMA1_BASE__INST4_SEG5                     0
+
+#define SDMA1_BASE__INST5_SEG0                     0
+#define SDMA1_BASE__INST5_SEG1                     0
+#define SDMA1_BASE__INST5_SEG2                     0
+#define SDMA1_BASE__INST5_SEG3                     0
+#define SDMA1_BASE__INST5_SEG4                     0
+#define SDMA1_BASE__INST5_SEG5                     0
+
+#define SDMA1_BASE__INST6_SEG0                     0
+#define SDMA1_BASE__INST6_SEG1                     0
+#define SDMA1_BASE__INST6_SEG2                     0
+#define SDMA1_BASE__INST6_SEG3                     0
+#define SDMA1_BASE__INST6_SEG4                     0
+#define SDMA1_BASE__INST6_SEG5                     0
+
+#define SMUIO_BASE__INST0_SEG0                     0x00016800
+#define SMUIO_BASE__INST0_SEG1                     0x00016A00
+#define SMUIO_BASE__INST0_SEG2                     0x02401000
+#define SMUIO_BASE__INST0_SEG3                     0x03440000
+#define SMUIO_BASE__INST0_SEG4                     0
+#define SMUIO_BASE__INST0_SEG5                     0
+
+#define SMUIO_BASE__INST1_SEG0                     0
+#define SMUIO_BASE__INST1_SEG1                     0
+#define SMUIO_BASE__INST1_SEG2                     0
+#define SMUIO_BASE__INST1_SEG3                     0
+#define SMUIO_BASE__INST1_SEG4                     0
+#define SMUIO_BASE__INST1_SEG5                     0
+
+#define SMUIO_BASE__INST2_SEG0                     0
+#define SMUIO_BASE__INST2_SEG1                     0
+#define SMUIO_BASE__INST2_SEG2                     0
+#define SMUIO_BASE__INST2_SEG3                     0
+#define SMUIO_BASE__INST2_SEG4                     0
+#define SMUIO_BASE__INST2_SEG5                     0
+
+#define SMUIO_BASE__INST3_SEG0                     0
+#define SMUIO_BASE__INST3_SEG1                     0
+#define SMUIO_BASE__INST3_SEG2                     0
+#define SMUIO_BASE__INST3_SEG3                     0
+#define SMUIO_BASE__INST3_SEG4                     0
+#define SMUIO_BASE__INST3_SEG5                     0
+
+#define SMUIO_BASE__INST4_SEG0                     0
+#define SMUIO_BASE__INST4_SEG1                     0
+#define SMUIO_BASE__INST4_SEG2                     0
+#define SMUIO_BASE__INST4_SEG3                     0
+#define SMUIO_BASE__INST4_SEG4                     0
+#define SMUIO_BASE__INST4_SEG5                     0
+
+#define SMUIO_BASE__INST5_SEG0                     0
+#define SMUIO_BASE__INST5_SEG1                     0
+#define SMUIO_BASE__INST5_SEG2                     0
+#define SMUIO_BASE__INST5_SEG3                     0
+#define SMUIO_BASE__INST5_SEG4                     0
+#define SMUIO_BASE__INST5_SEG5                     0
+
+#define SMUIO_BASE__INST6_SEG0                     0
+#define SMUIO_BASE__INST6_SEG1                     0
+#define SMUIO_BASE__INST6_SEG2                     0
+#define SMUIO_BASE__INST6_SEG3                     0
+#define SMUIO_BASE__INST6_SEG4                     0
+#define SMUIO_BASE__INST6_SEG5                     0
+
+#define THM_BASE__INST0_SEG0                       0x00016600
+#define THM_BASE__INST0_SEG1                       0x02400C00
+#define THM_BASE__INST0_SEG2                       0
+#define THM_BASE__INST0_SEG3                       0
+#define THM_BASE__INST0_SEG4                       0
+#define THM_BASE__INST0_SEG5                       0
+
+#define THM_BASE__INST1_SEG0                       0
+#define THM_BASE__INST1_SEG1                       0
+#define THM_BASE__INST1_SEG2                       0
+#define THM_BASE__INST1_SEG3                       0
+#define THM_BASE__INST1_SEG4                       0
+#define THM_BASE__INST1_SEG5                       0
+
+#define THM_BASE__INST2_SEG0                       0
+#define THM_BASE__INST2_SEG1                       0
+#define THM_BASE__INST2_SEG2                       0
+#define THM_BASE__INST2_SEG3                       0
+#define THM_BASE__INST2_SEG4                       0
+#define THM_BASE__INST2_SEG5                       0
+
+#define THM_BASE__INST3_SEG0                       0
+#define THM_BASE__INST3_SEG1                       0
+#define THM_BASE__INST3_SEG2                       0
+#define THM_BASE__INST3_SEG3                       0
+#define THM_BASE__INST3_SEG4                       0
+#define THM_BASE__INST3_SEG5                       0
+
+#define THM_BASE__INST4_SEG0                       0
+#define THM_BASE__INST4_SEG1                       0
+#define THM_BASE__INST4_SEG2                       0
+#define THM_BASE__INST4_SEG3                       0
+#define THM_BASE__INST4_SEG4                       0
+#define THM_BASE__INST4_SEG5                       0
+
+#define THM_BASE__INST5_SEG0                       0
+#define THM_BASE__INST5_SEG1                       0
+#define THM_BASE__INST5_SEG2                       0
+#define THM_BASE__INST5_SEG3                       0
+#define THM_BASE__INST5_SEG4                       0
+#define THM_BASE__INST5_SEG5                       0
+
+#define THM_BASE__INST6_SEG0                       0
+#define THM_BASE__INST6_SEG1                       0
+#define THM_BASE__INST6_SEG2                       0
+#define THM_BASE__INST6_SEG3                       0
+#define THM_BASE__INST6_SEG4                       0
+#define THM_BASE__INST6_SEG5                       0
+
+#define UMC_BASE__INST0_SEG0                       0x00014000
+#define UMC_BASE__INST0_SEG1                       0x00054000
+#define UMC_BASE__INST0_SEG2                       0x02425800
+#define UMC_BASE__INST0_SEG3                       0
+#define UMC_BASE__INST0_SEG4                       0
+#define UMC_BASE__INST0_SEG5                       0
+
+#define UMC_BASE__INST1_SEG0                       0x00094000
+#define UMC_BASE__INST1_SEG1                       0x000D4000
+#define UMC_BASE__INST1_SEG2                       0x02425C00
+#define UMC_BASE__INST1_SEG3                       0
+#define UMC_BASE__INST1_SEG4                       0
+#define UMC_BASE__INST1_SEG5                       0
+
+#define UMC_BASE__INST2_SEG0                       0x00114000
+#define UMC_BASE__INST2_SEG1                       0x00154000
+#define UMC_BASE__INST2_SEG2                       0x02426000
+#define UMC_BASE__INST2_SEG3                       0
+#define UMC_BASE__INST2_SEG4                       0
+#define UMC_BASE__INST2_SEG5                       0
+
+#define UMC_BASE__INST3_SEG0                       0x00194000
+#define UMC_BASE__INST3_SEG1                       0x001D4000
+#define UMC_BASE__INST3_SEG2                       0x02426400
+#define UMC_BASE__INST3_SEG3                       0
+#define UMC_BASE__INST3_SEG4                       0
+#define UMC_BASE__INST3_SEG5                       0
+
+#define UMC_BASE__INST4_SEG0                       0
+#define UMC_BASE__INST4_SEG1                       0
+#define UMC_BASE__INST4_SEG2                       0
+#define UMC_BASE__INST4_SEG3                       0
+#define UMC_BASE__INST4_SEG4                       0
+#define UMC_BASE__INST4_SEG5                       0
+
+#define UMC_BASE__INST5_SEG0                       0
+#define UMC_BASE__INST5_SEG1                       0
+#define UMC_BASE__INST5_SEG2                       0
+#define UMC_BASE__INST5_SEG3                       0
+#define UMC_BASE__INST5_SEG4                       0
+#define UMC_BASE__INST5_SEG5                       0
+
+#define UMC_BASE__INST6_SEG0                       0
+#define UMC_BASE__INST6_SEG1                       0
+#define UMC_BASE__INST6_SEG2                       0
+#define UMC_BASE__INST6_SEG3                       0
+#define UMC_BASE__INST6_SEG4                       0
+#define UMC_BASE__INST6_SEG5                       0
+
+#define VCN_BASE__INST0_SEG0                       0x00007800
+#define VCN_BASE__INST0_SEG1                       0x00007E00
+#define VCN_BASE__INST0_SEG2                       0x02403000
+#define VCN_BASE__INST0_SEG3                       0
+#define VCN_BASE__INST0_SEG4                       0
+#define VCN_BASE__INST0_SEG5                       0
+
+#define VCN_BASE__INST1_SEG0                       0x00007A00
+#define VCN_BASE__INST1_SEG1                       0x00009000
+#define VCN_BASE__INST1_SEG2                       0x02445000
+#define VCN_BASE__INST1_SEG3                       0
+#define VCN_BASE__INST1_SEG4                       0
+#define VCN_BASE__INST1_SEG5                       0
+
+#define VCN_BASE__INST2_SEG0                       0
+#define VCN_BASE__INST2_SEG1                       0
+#define VCN_BASE__INST2_SEG2                       0
+#define VCN_BASE__INST2_SEG3                       0
+#define VCN_BASE__INST2_SEG4                       0
+#define VCN_BASE__INST2_SEG5                       0
+
+#define VCN_BASE__INST3_SEG0                       0
+#define VCN_BASE__INST3_SEG1                       0
+#define VCN_BASE__INST3_SEG2                       0
+#define VCN_BASE__INST3_SEG3                       0
+#define VCN_BASE__INST3_SEG4                       0
+#define VCN_BASE__INST3_SEG5                       0
+
+#define VCN_BASE__INST4_SEG0                       0
+#define VCN_BASE__INST4_SEG1                       0
+#define VCN_BASE__INST4_SEG2                       0
+#define VCN_BASE__INST4_SEG3                       0
+#define VCN_BASE__INST4_SEG4                       0
+#define VCN_BASE__INST4_SEG5                       0
+
+#define VCN_BASE__INST5_SEG0                       0
+#define VCN_BASE__INST5_SEG1                       0
+#define VCN_BASE__INST5_SEG2                       0
+#define VCN_BASE__INST5_SEG3                       0
+#define VCN_BASE__INST5_SEG4                       0
+#define VCN_BASE__INST5_SEG5                       0
+
+#define VCN_BASE__INST6_SEG0                       0
+#define VCN_BASE__INST6_SEG1                       0
+#define VCN_BASE__INST6_SEG2                       0
+#define VCN_BASE__INST6_SEG3                       0
+#define VCN_BASE__INST6_SEG4                       0
+#define VCN_BASE__INST6_SEG5                       0
+
+#define WAFL0_BASE__INST0_SEG0                     0x02438000
+#define WAFL0_BASE__INST0_SEG1                     0x04880000
+#define WAFL0_BASE__INST0_SEG2                     0
+#define WAFL0_BASE__INST0_SEG3                     0
+#define WAFL0_BASE__INST0_SEG4                     0
+#define WAFL0_BASE__INST0_SEG5                     0
+
+#define WAFL0_BASE__INST1_SEG0                     0
+#define WAFL0_BASE__INST1_SEG1                     0
+#define WAFL0_BASE__INST1_SEG2                     0
+#define WAFL0_BASE__INST1_SEG3                     0
+#define WAFL0_BASE__INST1_SEG4                     0
+#define WAFL0_BASE__INST1_SEG5                     0
+
+#define WAFL0_BASE__INST2_SEG0                     0
+#define WAFL0_BASE__INST2_SEG1                     0
+#define WAFL0_BASE__INST2_SEG2                     0
+#define WAFL0_BASE__INST2_SEG3                     0
+#define WAFL0_BASE__INST2_SEG4                     0
+#define WAFL0_BASE__INST2_SEG5                     0
+
+#define WAFL0_BASE__INST3_SEG0                     0
+#define WAFL0_BASE__INST3_SEG1                     0
+#define WAFL0_BASE__INST3_SEG2                     0
+#define WAFL0_BASE__INST3_SEG3                     0
+#define WAFL0_BASE__INST3_SEG4                     0
+#define WAFL0_BASE__INST3_SEG5                     0
+
+#define WAFL0_BASE__INST4_SEG0                     0
+#define WAFL0_BASE__INST4_SEG1                     0
+#define WAFL0_BASE__INST4_SEG2                     0
+#define WAFL0_BASE__INST4_SEG3                     0
+#define WAFL0_BASE__INST4_SEG4                     0
+#define WAFL0_BASE__INST4_SEG5                     0
+
+#define WAFL0_BASE__INST5_SEG0                     0
+#define WAFL0_BASE__INST5_SEG1                     0
+#define WAFL0_BASE__INST5_SEG2                     0
+#define WAFL0_BASE__INST5_SEG3                     0
+#define WAFL0_BASE__INST5_SEG4                     0
+#define WAFL0_BASE__INST5_SEG5                     0
+
+#define WAFL0_BASE__INST6_SEG0                     0
+#define WAFL0_BASE__INST6_SEG1                     0
+#define WAFL0_BASE__INST6_SEG2                     0
+#define WAFL0_BASE__INST6_SEG3                     0
+#define WAFL0_BASE__INST6_SEG4                     0
+#define WAFL0_BASE__INST6_SEG5                     0
+
+#define WAFL1_BASE__INST0_SEG0                     0
+#define WAFL1_BASE__INST0_SEG1                     0x01300000
+#define WAFL1_BASE__INST0_SEG2                     0x02410800
+#define WAFL1_BASE__INST0_SEG3                     0
+#define WAFL1_BASE__INST0_SEG4                     0
+#define WAFL1_BASE__INST0_SEG5                     0
+
+#define WAFL1_BASE__INST1_SEG0                     0
+#define WAFL1_BASE__INST1_SEG1                     0
+#define WAFL1_BASE__INST1_SEG2                     0
+#define WAFL1_BASE__INST1_SEG3                     0
+#define WAFL1_BASE__INST1_SEG4                     0
+#define WAFL1_BASE__INST1_SEG5                     0
+
+#define WAFL1_BASE__INST2_SEG0                     0
+#define WAFL1_BASE__INST2_SEG1                     0
+#define WAFL1_BASE__INST2_SEG2                     0
+#define WAFL1_BASE__INST2_SEG3                     0
+#define WAFL1_BASE__INST2_SEG4                     0
+#define WAFL1_BASE__INST2_SEG5                     0
+
+#define WAFL1_BASE__INST3_SEG0                     0
+#define WAFL1_BASE__INST3_SEG1                     0
+#define WAFL1_BASE__INST3_SEG2                     0
+#define WAFL1_BASE__INST3_SEG3                     0
+#define WAFL1_BASE__INST3_SEG4                     0
+#define WAFL1_BASE__INST3_SEG5                     0
+
+#define WAFL1_BASE__INST4_SEG0                     0
+#define WAFL1_BASE__INST4_SEG1                     0
+#define WAFL1_BASE__INST4_SEG2                     0
+#define WAFL1_BASE__INST4_SEG3                     0
+#define WAFL1_BASE__INST4_SEG4                     0
+#define WAFL1_BASE__INST4_SEG5                     0
+
+#define WAFL1_BASE__INST5_SEG0                     0
+#define WAFL1_BASE__INST5_SEG1                     0
+#define WAFL1_BASE__INST5_SEG2                     0
+#define WAFL1_BASE__INST5_SEG3                     0
+#define WAFL1_BASE__INST5_SEG4                     0
+#define WAFL1_BASE__INST5_SEG5                     0
+
+#define WAFL1_BASE__INST6_SEG0                     0
+#define WAFL1_BASE__INST6_SEG1                     0
+#define WAFL1_BASE__INST6_SEG2                     0
+#define WAFL1_BASE__INST6_SEG3                     0
+#define WAFL1_BASE__INST6_SEG4                     0
+#define WAFL1_BASE__INST6_SEG5                     0
+
+#define XGMI0_BASE__INST0_SEG0                     0x02438C00
+#define XGMI0_BASE__INST0_SEG1                     0x04680000
+#define XGMI0_BASE__INST0_SEG2                     0x04940000
+#define XGMI0_BASE__INST0_SEG3                     0
+#define XGMI0_BASE__INST0_SEG4                     0
+#define XGMI0_BASE__INST0_SEG5                     0
+
+#define XGMI0_BASE__INST1_SEG0                     0
+#define XGMI0_BASE__INST1_SEG1                     0
+#define XGMI0_BASE__INST1_SEG2                     0
+#define XGMI0_BASE__INST1_SEG3                     0
+#define XGMI0_BASE__INST1_SEG4                     0
+#define XGMI0_BASE__INST1_SEG5                     0
+
+#define XGMI0_BASE__INST2_SEG0                     0
+#define XGMI0_BASE__INST2_SEG1                     0
+#define XGMI0_BASE__INST2_SEG2                     0
+#define XGMI0_BASE__INST2_SEG3                     0
+#define XGMI0_BASE__INST2_SEG4                     0
+#define XGMI0_BASE__INST2_SEG5                     0
+
+#define XGMI0_BASE__INST3_SEG0                     0
+#define XGMI0_BASE__INST3_SEG1                     0
+#define XGMI0_BASE__INST3_SEG2                     0
+#define XGMI0_BASE__INST3_SEG3                     0
+#define XGMI0_BASE__INST3_SEG4                     0
+#define XGMI0_BASE__INST3_SEG5                     0
+
+#define XGMI0_BASE__INST4_SEG0                     0
+#define XGMI0_BASE__INST4_SEG1                     0
+#define XGMI0_BASE__INST4_SEG2                     0
+#define XGMI0_BASE__INST4_SEG3                     0
+#define XGMI0_BASE__INST4_SEG4                     0
+#define XGMI0_BASE__INST4_SEG5                     0
+
+#define XGMI0_BASE__INST5_SEG0                     0
+#define XGMI0_BASE__INST5_SEG1                     0
+#define XGMI0_BASE__INST5_SEG2                     0
+#define XGMI0_BASE__INST5_SEG3                     0
+#define XGMI0_BASE__INST5_SEG4                     0
+#define XGMI0_BASE__INST5_SEG5                     0
+
+#define XGMI0_BASE__INST6_SEG0                     0
+#define XGMI0_BASE__INST6_SEG1                     0
+#define XGMI0_BASE__INST6_SEG2                     0
+#define XGMI0_BASE__INST6_SEG3                     0
+#define XGMI0_BASE__INST6_SEG4                     0
+#define XGMI0_BASE__INST6_SEG5                     0
+
+#define XGMI1_BASE__INST0_SEG0                     0x02439000
+#define XGMI1_BASE__INST0_SEG1                     0x046C0000
+#define XGMI1_BASE__INST0_SEG2                     0x04980000
+#define XGMI1_BASE__INST0_SEG3                     0
+#define XGMI1_BASE__INST0_SEG4                     0
+#define XGMI1_BASE__INST0_SEG5                     0
+
+#define XGMI1_BASE__INST1_SEG0                     0
+#define XGMI1_BASE__INST1_SEG1                     0
+#define XGMI1_BASE__INST1_SEG2                     0
+#define XGMI1_BASE__INST1_SEG3                     0
+#define XGMI1_BASE__INST1_SEG4                     0
+#define XGMI1_BASE__INST1_SEG5                     0
+
+#define XGMI1_BASE__INST2_SEG0                     0
+#define XGMI1_BASE__INST2_SEG1                     0
+#define XGMI1_BASE__INST2_SEG2                     0
+#define XGMI1_BASE__INST2_SEG3                     0
+#define XGMI1_BASE__INST2_SEG4                     0
+#define XGMI1_BASE__INST2_SEG5                     0
+
+#define XGMI1_BASE__INST3_SEG0                     0
+#define XGMI1_BASE__INST3_SEG1                     0
+#define XGMI1_BASE__INST3_SEG2                     0
+#define XGMI1_BASE__INST3_SEG3                     0
+#define XGMI1_BASE__INST3_SEG4                     0
+#define XGMI1_BASE__INST3_SEG5                     0
+
+#define XGMI1_BASE__INST4_SEG0                     0
+#define XGMI1_BASE__INST4_SEG1                     0
+#define XGMI1_BASE__INST4_SEG2                     0
+#define XGMI1_BASE__INST4_SEG3                     0
+#define XGMI1_BASE__INST4_SEG4                     0
+#define XGMI1_BASE__INST4_SEG5                     0
+
+#define XGMI1_BASE__INST5_SEG0                     0
+#define XGMI1_BASE__INST5_SEG1                     0
+#define XGMI1_BASE__INST5_SEG2                     0
+#define XGMI1_BASE__INST5_SEG3                     0
+#define XGMI1_BASE__INST5_SEG4                     0
+#define XGMI1_BASE__INST5_SEG5                     0
+
+#define XGMI1_BASE__INST6_SEG0                     0
+#define XGMI1_BASE__INST6_SEG1                     0
+#define XGMI1_BASE__INST6_SEG2                     0
+#define XGMI1_BASE__INST6_SEG3                     0
+#define XGMI1_BASE__INST6_SEG4                     0
+#define XGMI1_BASE__INST6_SEG5                     0
+
+#define XGMI2_BASE__INST0_SEG0                     0x04700000
+#define XGMI2_BASE__INST0_SEG1                     0x049C0000
+#define XGMI2_BASE__INST0_SEG2                     0
+#define XGMI2_BASE__INST0_SEG3                     0
+#define XGMI2_BASE__INST0_SEG4                     0
+#define XGMI2_BASE__INST0_SEG5                     0
+
+#define XGMI2_BASE__INST1_SEG0                     0x04740000
+#define XGMI2_BASE__INST1_SEG1                     0x04A00000
+#define XGMI2_BASE__INST1_SEG2                     0
+#define XGMI2_BASE__INST1_SEG3                     0
+#define XGMI2_BASE__INST1_SEG4                     0
+#define XGMI2_BASE__INST1_SEG5                     0
+
+#define XGMI2_BASE__INST2_SEG0                     0x04780000
+#define XGMI2_BASE__INST2_SEG1                     0x04A40000
+#define XGMI2_BASE__INST2_SEG2                     0
+#define XGMI2_BASE__INST2_SEG3                     0
+#define XGMI2_BASE__INST2_SEG4                     0
+#define XGMI2_BASE__INST2_SEG5                     0
+
+#define XGMI2_BASE__INST3_SEG0                     0x047C0000
+#define XGMI2_BASE__INST3_SEG1                     0x04A80000
+#define XGMI2_BASE__INST3_SEG2                     0
+#define XGMI2_BASE__INST3_SEG3                     0
+#define XGMI2_BASE__INST3_SEG4                     0
+#define XGMI2_BASE__INST3_SEG5                     0
+
+#define XGMI2_BASE__INST4_SEG0                     0x04800000
+#define XGMI2_BASE__INST4_SEG1                     0x04AC0000
+#define XGMI2_BASE__INST4_SEG2                     0
+#define XGMI2_BASE__INST4_SEG3                     0
+#define XGMI2_BASE__INST4_SEG4                     0
+#define XGMI2_BASE__INST4_SEG5                     0
+
+#define XGMI2_BASE__INST5_SEG0                     0x04840000
+#define XGMI2_BASE__INST5_SEG1                     0x04B00000
+#define XGMI2_BASE__INST5_SEG2                     0
+#define XGMI2_BASE__INST5_SEG3                     0
+#define XGMI2_BASE__INST5_SEG4                     0
+#define XGMI2_BASE__INST5_SEG5                     0
+
+#define XGMI2_BASE__INST6_SEG0                     0
+#define XGMI2_BASE__INST6_SEG1                     0
+#define XGMI2_BASE__INST6_SEG2                     0
+#define XGMI2_BASE__INST6_SEG3                     0
+#define XGMI2_BASE__INST6_SEG4                     0
+#define XGMI2_BASE__INST6_SEG5                     0
+
+#endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
