Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF82C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD61661159
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD61661159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2ED6F890;
	Fri,  4 Jun 2021 18:16:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5666F891
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 18:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a51GMs6tZ57kb/fL6Ci81eoEClA2tPKJoJzrcp2M7KZJZFWIsmgx5QP7teA+sRMmyPEwMPyLVKXxhjWC3J+iwueu/U43YM5qghU8qOwtiLPo4zqSBihnHbyDDEapUC3vDi2kUbPVGAAqQCc/OfrlfpXy8qaTCAXGPwhK4NhgSRAQr81UDg97QZrrIqi4FoBcdDvCXiutWemBAtnqU3j9cvHKAV0zYOi0lqaqOKaS5y0Z16m0DwRDE2qoLsDfbvV5Vk5EQwJ7ILuIo8krPFQnqQQN1j93f9x1+E6v1IhSyZzwMYiP0zY+vCySKa0JiLoH75j1D8lpduDmfJu8B6cK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WF+E7sp9ZpfZhBCqpGVZNgZHgICzp907LkVnvHpHtc=;
 b=ZaINGzLU8JAmohBMlki1UiKalwcNTUsGzGMF4hLR09e/0BkTv5KfclnCG/jwMinjslhux0MnG3HxRmzm/3vUruuCCuVPDEUaV50BnDVpoD+chVwBbnfzOfuRanbQaiHfcYul65+/AgkJ+JdRRm2wZ0fMM4VUXLHDm4T17gub+xuU16xl52lc4kklrAFALE7WsIdcOcM8Bz8Rr7Ze/7ZVyF+8do8aDVL/daPm8RG0ROPHy84m73RLVfXeiVkdYb2BvEU2L+lEPBAykPNhHpTKixQEYR0XekIx208SQ/satK7EyTJOZNX917x4b1gnAwyBTH3ly+CWF8qulqdjdMMt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WF+E7sp9ZpfZhBCqpGVZNgZHgICzp907LkVnvHpHtc=;
 b=M28dLnbsYnqO++ZG+0vjKeoy7wd5ys7iSnsFU8YQgzXptToA8HsUUGhR8MJBdgfDiqIsx/UQCn18943g5nRadv4OlI/HiJ/pUrpHVTO48RnM89jLN8FRd6JIKJxmq1+h59VF9l3pfC9qtj0Pekcji/cBgl12Xzy/Z7qHE7W1K1g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 18:16:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 18:16:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/dc: fix DCN3.1 Makefile for PPC64
Date: Fri,  4 Jun 2021 14:16:29 -0400
Message-Id: <20210604181630.1205152-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:208:178::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Fri, 4 Jun 2021 18:16:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f20257c1-f2e2-441a-af01-08d92784e8d4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44883CEA6041C651D40002B8F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52Yf78ePtrkGwPeqSMMugqjifnHWbmhvQoE/7BUfRp9PazRuy86Eq03aitbR4VUUzWXyASfIc7lA8cjkQsqPgi4UTfGQ4pc4OTQrwXNSI2sPEfgbY2ofmG3DgdJAL7P5mfEJnGv/1S9S4bTAnWsZ4LtzroxWY0e9JECqSt7u1fh7rFKLIc9GXMPdodMmlbJQlINgZjySnxEMOo1q/RnNSo5B3BAAz93OyVSsTGQrpf4ifApWbSeTY5Bp1l5zOVfvSqGTw2F+nhv2BL+cMYw7jfgTQbKqtQj4dGlQDfq7F4ppIJmC/v3A0eWGrrBWIeGLj9097Rh0+tXiC9N4EnQybZST7RqyRckNwWHSsIysiLZLY6ZtXrCg6rlJmxSQf3DMEgz7ln1HKnAAlPWZi/thm2rkmLNeEU1WYuZz/gwXastvBG9zk3BfRhDtKvBobikuRHvbC+kb9CAOe0gU/sNIMcGU5qo99O1h4Gw0v2QHxKjLJ0V6TeVuvWLjaeZUcwo/lcUMEUUOQ7VtADTpyJsPsjVoAsV9cG4KrZPMzJU/4z8odV3lMZfOW4Li++JorI/fBEHQQd9eH2fg9UW6dXOtN2ELODczkwWER/lE25yawpjG2N9zq1YByHPPosg2SQZF6qgfkew3OK/7R6hLHQc2L5Cz65APPOm36iA+qa4QuzUkgfkGT7i6WYtuNI/xR/8F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(6512007)(498600001)(38350700002)(38100700002)(8676002)(6506007)(1076003)(8936002)(52116002)(2616005)(956004)(16526019)(66946007)(83380400001)(2906002)(6916009)(26005)(186003)(6486002)(36756003)(5660300002)(6666004)(86362001)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yx5BHSFMECi11a85ymjkwMWG7J0/7e8cwzniS+t68wx/Y6mZYIJe8ZnSGiq3?=
 =?us-ascii?Q?B7eR7fl6ZtXCWLJkxq91z1jERTshJkZ8lAJqqxlfLt9exQU90JaxKEtEOiiG?=
 =?us-ascii?Q?jbfqObkHXOix9R1vH232aDEqiBm8P+8CKsCKeH74Na/vaTDrPg8nP+IZ+oHB?=
 =?us-ascii?Q?cILm1NSgL3JdjNgn8XQgNhEGdbU6scZQFKhPKwb4n3m4Pi/WJfcum3WZHE4n?=
 =?us-ascii?Q?9mMvLjK5Eu5/AFL9dRL6TupoFxbHlLAc8v2WBiu7Puu4MzR2mZYG09nuZcq6?=
 =?us-ascii?Q?d9X1evxwl1/NAaWSnkinjePwgBt3OnPNSraQYNiL/KDg784giNdnbtZQB7hY?=
 =?us-ascii?Q?TvsZRDJb8rFXjjAv0iAsuoz248+YXZT3h5+2Ny2Wbk9CBEY077t5IKv5Rxdr?=
 =?us-ascii?Q?w3fnRQW18c4m5Xz8taFBVuYybneSUl1GXUtWXFL79W8fHkuFFG1qoJeiJ9gA?=
 =?us-ascii?Q?QwSsirCWaFLEwalb0j51XVjeHG0MH7zSBxdkrpscLOpjJGmvVKR4ywe1TVI8?=
 =?us-ascii?Q?xd18cHoBxwQjwhz9w3Pg1rcmUTXCK5RGCE4qZAvUuyC7z2DF8xR6IpvLY4n9?=
 =?us-ascii?Q?UCFjIm/c2ysCkfNnrR/wIbWLWPDyU4xPiPmp0139JWMX9O8Wrvlj5wmcEpzR?=
 =?us-ascii?Q?uuWKgs0KrzQzgHLiHjXRptZRAn8nxBJILChnmjmEM+RkVhBqKzhloeMc60dL?=
 =?us-ascii?Q?/MN5kCBKI+8F7Ypl+/O81UiJsJ7SQ4EJ+Q19lABzyF50LfuFtGO4TRGfOQ23?=
 =?us-ascii?Q?QsiZg5OyCQVK7GRXmqic50A5ewrwXKu01bTFCymvIEJSS3JXrviAT/I53UJJ?=
 =?us-ascii?Q?RMj+Fys4QYQR2uPZbZ/d8hvFwrxqPPnjye/w+PphpocnhPCx+H/ZI06FARjc?=
 =?us-ascii?Q?3Hl3zaC/KVCitKjZ+9OENnEhe0OhPmSl3C9MkRpDOIak213ypbhSRdbXKkoK?=
 =?us-ascii?Q?jGBYLydo9yFwVYXqbRPUgd+6+yOwDusIexD3DL+OA6NXs8zYacqNLgRd9Uh9?=
 =?us-ascii?Q?R9Us0zcZ6swpI/T02rVYRE9hM8/3i3hQQfsJUtpKQ66yvStjBuA/6pyPTg+R?=
 =?us-ascii?Q?JvFQNmO3hO94c4Jg2v72kFsBo23xkEKjVgcO2CZJyqOY20N6O1yhc5Byn6wb?=
 =?us-ascii?Q?C8J2X8A1sdS4XuZgUyloLD6cvq/b2y+wyShFWBcbA8loMRxiRW4C12zItQrT?=
 =?us-ascii?Q?Vcdc9+GZBCOunXpncQduOgN1kLAZadunWB2PKCsRt6BrlfMeeVgfvpojP4Jw?=
 =?us-ascii?Q?twrvOf4oXhIYOntLYZNMVUXEtZC1BZHzGH6t2RwLCM8UCPkWgqJAPsdspqO7?=
 =?us-ascii?Q?dKY84Zq3CvDN9KAdSOXVFVsu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20257c1-f2e2-441a-af01-08d92784e8d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 18:16:44.6667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtwY24I5TKHVDOrX75oFobVo/xHQU5IXOJqO1NHkobI3fWenZkhLwbzABr99LI2WNx9nsrt4dvbTZTMul43UIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Port the necessary changes from previous DCN versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 439b95d4c120..5dcdc5a858fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -13,12 +13,19 @@
 DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
 	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o
 
-CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -msse
+ifdef CONFIG_X86
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o := -mhard-float -maltivec
+endif
 
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn31/dcn31_resource.o += -mhard-float
 endif
 
 ifdef IS_OLD_GCC
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
