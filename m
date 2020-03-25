Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B2EC2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E4C20774
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K+88IGI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4C20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49B86E804;
	Wed, 25 Mar 2020 18:08:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352BE6E804
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 18:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S22KQVUXca9clwpZVjikjgoVHQ+cd+XThABhokL+W+jcQq8nh1BTiiG/TQ09dH7q8ZaBk8nBdwcT8l8glq0THUqTOc3kibt4igLx7qcwhYZ8JhqbHB++gvZqF3K5XcHW2jVxSpAxmFpGCBdq4Zt+DV0Lhxs+wp4LGkdsIFMhWe2U0MCqDmndTNcfmDGYHM7aTQ02dVJP1rV0POmtbeRnxoJODJ1vT+d/Pri+rva2D77F4vxjnsy4XOFL/r2QT6auP6TwlqhZcb3Bn8a/Wh2yAANgr6TAdtJsxGzNuWueRZIiWOC2vhyiX6OliCCq9UMloA5ZGyfD0cbVCpWyI07Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/wTgPPnqvWU8Made4WaInEClZ6hV+6dXeC9JsBbGGM=;
 b=jfcfds2tc3l/sB9oXI7qUjtfMVIGdbj7cb0Lfq9tY3Wh5k4uZoHirDGxRpQJB04NYJOzpbcLE0PxNHDkMY6sBt14HKLsGUuJdhu9KrgIAKumdbRjHBQHBU4JzUq+2aEr0/zIXKGbrMJtcjCJhm0R6Rt+1uspGdm6nEf0aGr0fgfRMxinuiRAgT17NtHouMHmGGWsef1K0+c0d4NAeUUTQQHjShBYvGgtriIMIJofb1MXMPPNzusTmI0Y5MTEnT33d3b7Dh6/72sKldeqaeh1mVg2FqWn7sOTnQEW+jyXiUxOIBDkyjVde/WWschzuqGO96gIs7IdbKrnutXzKVlcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/wTgPPnqvWU8Made4WaInEClZ6hV+6dXeC9JsBbGGM=;
 b=K+88IGI7a0/34m0J51VmsGo0Xod/t5yY+mc7LsAo7cl+3nj0XmURmiPrI+XF2mBA5J+bHHNVRvyIfUL8SyVGTJydgbY6Bd5iV239CodAIA5OH8dKlhqysZQurB6EgWQzcFIhSQv3FiZtFnS5IxUedeX8D/0LGzCZzSPKaRvo6rc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 25 Mar 2020 18:08:51 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 18:08:51 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/amdgpu: Move PWR_MISC_CNTL_STATUS to its own
 header
Date: Wed, 25 Mar 2020 14:08:39 -0400
Message-Id: <20200325180839.469615-2-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325180839.469615-1-tom.stdenis@amd.com>
References: <20200325180839.469615-1-tom.stdenis@amd.com>
X-ClientProxiedBy: BN6PR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:404:e3::17) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR19CA0055.namprd19.prod.outlook.com (2603:10b6:404:e3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 18:08:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5f4b58a-8e73-43f1-1672-08d7d0e792c7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:|DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114867368DE07BFBF6CA7882F7CE0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(6916009)(6486002)(81156014)(81166006)(66946007)(5660300002)(1076003)(66556008)(66476007)(8676002)(478600001)(8936002)(36756003)(2906002)(16526019)(6666004)(956004)(86362001)(186003)(316002)(2616005)(7696005)(52116002)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iT2hLKfDLbikp9OJ+/j0W1LDV86b+xAfRTl+LXHpqvxDHroLKwTEzL4yXs5+agWGiMm9Lzz5cA+uGyBvCW+NnbozdPraqPpHBDpvmpDr6h7N8Wb/kYrVH4Q8o0rnw1aDHOOzsMTZzNgwpesKfP7LZj/sbZj2ClXHg+l4NKzMq978Yb5SEHpmYeqB75MBA61R95Vo6lwz7VrsYsj/hfbIIzz0wBg4AmueqtsB7kjzdVX73exLsZA+jt/Ast7z78uaytmonEChlb5lZyGGPjLfWkWVpJ1xGMjTeKfBUd9Tq0cUhO1UENSfTkOLRmjxU0yRG7pDicveX1xzIJFbLxG7Lpfs/tYOzUP9emRNYiCMQnGTH3KEyYNOX3Poeh+JsL59Vqn3yXl/QoVy0vn+4T9nTc0UY+Lgc/UwkBCtkBbp7jHg9eUmWWqXj3BK174/7AyC
X-MS-Exchange-AntiSpam-MessageData: 7sfVIhe2s1O5EON4Sq/UzRkz7GA7DvJvtcCZFV8C2hPe4oKLQX9gHqXY1eBv8OjKkeJue2j5V4JAi54hniQwnZ+FbcKDwldFVx45vXMitxpDIkr6DtN+RlIaYe9hufqbwNtv6BOmqrXMJs0lSkblZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f4b58a-8e73-43f1-1672-08d7d0e792c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 18:08:51.7467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayQtwBP16cpG0H+2PEpDo1YZdymI086izv3BG75fSWfrpL6UI1YMkTEDXDGxrRgWxtOTIPVNTAs5T6Gv0VN3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The register is part of the PWR block not the GC block.  Move to
its own header.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../amd/include/asic_reg/gc/gc_9_1_offset.h   |  2 --
 .../amd/include/asic_reg/gc/gc_9_1_sh_mask.h  |  5 ----
 .../include/asic_reg/pwr/pwr_10_0_offset.h    | 27 +++++++++++++++++
 .../include/asic_reg/pwr/pwr_10_0_sh_mask.h   | 30 +++++++++++++++++++
 4 files changed, 57 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
index ad61ffb0fd97..030e0020902b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
@@ -159,8 +159,6 @@
 #define mmCP_DE_LAST_INVAL_COUNT_BASE_IDX                                                              0
 #define mmCP_DE_DE_COUNT                                                                               0x00c4
 #define mmCP_DE_DE_COUNT_BASE_IDX                                                                      0
-#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
-#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                0
 #define mmCP_STALLED_STAT3                                                                             0x019c
 #define mmCP_STALLED_STAT3_BASE_IDX                                                                    0
 #define mmCP_STALLED_STAT1                                                                             0x019d
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
index 6cc63562fd55..13bfc2e6e16f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
@@ -801,11 +801,6 @@
 //CP_DE_DE_COUNT
 #define CP_DE_DE_COUNT__DRAW_ENGINE_COUNT__SHIFT                                                              0x0
 #define CP_DE_DE_COUNT__DRAW_ENGINE_COUNT_MASK                                                                0xFFFFFFFFL
-//PWR_MISC_CNTL_STATUS
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
-#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
-#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
 //CP_STALLED_STAT3
 #define CP_STALLED_STAT3__CE_TO_CSF_NOT_RDY_TO_RCV__SHIFT                                                     0x0
 #define CP_STALLED_STAT3__CE_TO_RAM_INIT_FETCHER_NOT_RDY_TO_RCV__SHIFT                                        0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
new file mode 100644
index 000000000000..e87c359ea1fe
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_offset.h
@@ -0,0 +1,27 @@
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
+#ifndef _pwr_10_0_OFFSET_HEADER
+#define _pwr_10_0_OFFSET_HEADER
+
+#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
+#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h
new file mode 100644
index 000000000000..8a000c21651c
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/pwr/pwr_10_0_sh_mask.h
@@ -0,0 +1,30 @@
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
+#ifndef _pwr_10_0_SH_MASK_HEADER
+#define _pwr_10_0_SH_MASK_HEADER
+
+//PWR_MISC_CNTL_STATUS
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
