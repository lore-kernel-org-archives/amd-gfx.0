Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF8CC47425
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8840220754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hidYzecB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8840220754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EEE6E8D0;
	Thu,  1 Oct 2020 18:24:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547F96E8CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 18:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6IQKU1EbVQeRYGQVycgVi+gylP5N61z/d6XNGnKbW7CCZkPhNJzkSODmMXvuQAvJ5cK6PJB3h5YWxJvM2CK5hZlveAHusvOEA73He5P8P6G6f30HKi0xmuqtLfrCvJ1e/XthjBHzAhO+MM7PfiijBT7vElqYAeLZwVCtMpXNaj6EaFgmlDVBWL9ldzIEqpOFJ/urJIREtOECi20fZUGSfqgBq5q/VIc1axQ7xsls2yhUTlDLtJLDVsaT/xAe301vZXYcY2Id3fSdYzy833qvQmaU7o4IySAy/BtdsgYI0wXif8769LaStMvJEURx7qscxMA5ucP2y9OyexIjrKAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZWcFaouzPqa/8xjsPyxiZLaZKZuZrH8lh4HDwxUoZM=;
 b=LvocoVMnYdUnHzOhe+HAScBwd0MxUz5BtpBg2mArWJLJPmIQYXU1lCxrftZklGRNNM7EsO5DBL+zC8sR74ukcJ4QM1xvIwlTUtYVft62KhzB2QVSPClUIU2y8ljMRD6BaFSysRdztBu//p3XaFl2za7Lznqjh0F3+M5jlN+6GgVUL7G6t6cKG55ZvmaslQhH/iDC4yYFgulG+9caGdNFCsNdgeAXqOqayUM3K+qNoJ5K5fq1LXMyx/xKEupvAgDzuKl7k9TK+EUjllT8c4StrMrPj/jW9TWLi2QIFYnzGcmqUZsCnC0yDyBMLwyOkjpha6MEcvXcKljrM88JY0/4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZWcFaouzPqa/8xjsPyxiZLaZKZuZrH8lh4HDwxUoZM=;
 b=hidYzecBlCnHU5VJJ4ik2X1Tvyi92x7LtOMAo/Oh3Nkn+GmIZWEPWxqMAopkKnFItcr0HnuLhY1i1nXVsgakaMA8aZnMeVeBugZIMY/035NfwWMIY1Q51wa+h0K6YV6LUAuVauBmSuoXOQfXeVCYR4qJdJ9YkoMBNTrHaC6mpqM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 1 Oct
 2020 18:24:41 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591%4]) with mapi id 15.20.3433.038; Thu, 1 Oct 2020
 18:24:41 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdkfd: Move first_wave bit in gfx10 trap handler
Date: Thu,  1 Oct 2020 13:24:07 -0500
Message-Id: <20201001182408.3960-3-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001182408.3960-1-jay.cornwall@amd.com>
References: <20201001182408.3960-1-jay.cornwall@amd.com>
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jc-d.amd.com (165.204.77.1) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Thu, 1 Oct 2020 18:24:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a1a9605-8224-46b7-b22f-08d8663742bc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44461437F20732ABFD19552787300@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTUgINsFdXF36IdAcDd7utsiRczKbTf45pMQlcmTZfJpZkQMjaFhYwZNenuNpTHWDVByLnttatxFHkJ7NCeT3jID/wo3Xm3J7p3Hoa408ydtFnX/3ZV97yWuwPa2lGwnEJLkmAVqGljxCUuAV6q0mNUKlqcqjTwAYl45h3R9ioTQ9h9b5+x/9zQC39nZERzMdOjkhyOMB4miU6OYAD1shh2zzlZC+i/Ns/hlX1381qII6uBEOocf8q5vsSuOfs/9RBfAgDbxaMfB4R3guQFrXjBAbNAp1VuCilf5t3J+/RXTu2UzJxwxBp0h3IyY+TX0vzBe4a2Mm8MD2gZsetLz6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66556008)(16526019)(1076003)(66476007)(186003)(36756003)(4326008)(66946007)(26005)(5660300002)(2616005)(8676002)(86362001)(6916009)(6666004)(83380400001)(52116002)(7696005)(8936002)(2906002)(44832011)(6486002)(478600001)(956004)(54906003)(316002)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0n+jcQJasPYoKpkv8+qbIlyrmipd4XPGRjQyrKEJ38t4pOaGBh81LryFHCCtyRUN+r2Ycm4bN02exsN3RUokL64/GLlONnDJ6LoHj0cMK1brOC8iMB8bbsGDTZ0cBMgyqz6bx/pMcYvmKWVGScd8GNPqVs0DATP6S8q/SwDe1AvG0I9dwySl6TiwnsMA8kUnp8/Gw03AGHBCD/V6kmug6D9aQafLs3r7xN6QD0fmmD7YUYeLi0fjHqZ/vKGs28lcjqOqFaXHLkK4sHMoDS9L9WyPnSS9Qkmlri99blSz62i72WsOiJYur4PLmLq4u80vZ3zpN80YHkcLh2H3gPTwOtDHjULz89HZAxOfsN18xPHrJrVWo5Rbie9MHsG3nl7G8GdcDEsWQf55KGbMbqnyz6HZTYRuLqm0MdOD3yBtPmnYLZmGOG2yIR+wx7fZbtf5+BFNhjtwd0fukS6qri7/Jdz4dNzo4bj43N6ry60s2acOYubf1jVata8X/U7gKx/NcTcp/iY1Rx3owrj8xopMOwA6s2Vz9pahM0mimhatvuUisBKjaEPP0EHLal9IirQLY0vmFQZ/7LTChmHr5Dj11cZawpSdczp3S94xgpqn+429jeOro7ard3XzuhMJdNZ2JY3on7HB0p7z23qCN9UJfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a9605-8224-46b7-b22f-08d8663742bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:24:41.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoAobanOA1ZqgIVKFuI8ONRQf7Da4wrGapxefgZtQG6Nz0SFZ0ty8z0BXYMwba7yuk7Mfc8+PdjZlxb71sMzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
Cc: Jay Cornwall <jay.cornwall@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Save first_wave bit from exec_hi to ttmp1. This allows the high bits
of exec_lo/exec_hi (which hold a 48-bit address) to be cleared in a
follow-up patch.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 596 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  14 +-
 2 files changed, 310 insertions(+), 300 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 9f435c777ba0..9c903c38dd74 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -665,7 +665,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
-	0xbf820001, 0xbf8201c6,
+	0xbf820001, 0xbf8201ca,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -710,24 +710,25 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xb9faf807, 0xbeee037e,
 	0xbeef037f, 0xbefe0480,
 	0xbf900004, 0xbf8e0002,
-	0xbf88fffe, 0xb97b02dc,
-	0x8f7b997b, 0x887b7b7f,
-	0xb97a2a05, 0x807a817a,
-	0xbf0d997b, 0xbf850002,
-	0x8f7a897a, 0xbf820001,
-	0x8f7a8a7a, 0x877bff7f,
-	0x0000ffff, 0x807aff7a,
-	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xf4491c3d,
-	0xfa000050, 0xf4491d3d,
-	0xfa000060, 0xf4411e7d,
-	0xfa000074, 0xbef4037e,
-	0x8775ff7f, 0x0000ffff,
-	0x8875ff75, 0x00040000,
-	0xbef60380, 0xbef703ff,
-	0x10807fac, 0xbef1037c,
-	0xbef00380, 0xb97302dc,
-	0x8f739973, 0x8873737f,
+	0xbf88fffe, 0x877aff7f,
+	0x04000000, 0x8f7a857a,
+	0x886d7a6d, 0xb97b02dc,
+	0x8f7b997b, 0xb97a2a05,
+	0x807a817a, 0xbf0d997b,
+	0xbf850002, 0x8f7a897a,
+	0xbf820001, 0x8f7a8a7a,
+	0x877bff7f, 0x0000ffff,
+	0x807aff7a, 0x00000200,
+	0x807a7e7a, 0x827b807b,
+	0xf4491c3d, 0xfa000050,
+	0xf4491d3d, 0xfa000060,
+	0xf4411e7d, 0xfa000074,
+	0xbef4037e, 0x8775ff7f,
+	0x0000ffff, 0x8875ff75,
+	0x00040000, 0xbef60380,
+	0xbef703ff, 0x10807fac,
+	0xbef1037c, 0xbef00380,
+	0xb97302dc, 0x8f739973,
 	0xb97bf816, 0xba80f816,
 	0x00000000, 0xbefe03c1,
 	0x907c9973, 0x877c817c,
@@ -757,8 +758,9 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbefc037e, 0xbefe037c,
 	0xbefc0370, 0xf4611b3a,
 	0xf8000000, 0x80708470,
-	0xbefc037e, 0xbefe037c,
-	0xbefc0370, 0xf4611b7a,
+	0xbefc037e, 0x8a7aff6d,
+	0x80000000, 0xbefe037c,
+	0xbefc0370, 0xf4611eba,
 	0xf8000000, 0x80708470,
 	0xbefc037e, 0xbefe037c,
 	0xbefc0370, 0xf4611bba,
@@ -819,8 +821,8 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xbeff0380, 0xbf820001,
 	0xbeff03c1, 0xb97b4306,
 	0x877bc17b, 0xbf840044,
-	0xbf8a0000, 0x877aff73,
-	0x04000000, 0xbf840040,
+	0xbf8a0000, 0x877aff6d,
+	0x80000000, 0xbf840040,
 	0x8f7b867b, 0x8f7b827b,
 	0xbef6037b, 0xb9702a05,
 	0x80708170, 0xbf0d9973,
@@ -892,169 +894,168 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0xe0704000, 0x705d0000,
 	0x807c817c, 0x8070ff70,
 	0x00000080, 0xbf0a7b7c,
-	0xbf85fff8, 0xbf82013d,
+	0xbf85fff8, 0xbf82013c,
 	0xbef4037e, 0x8775ff7f,
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
 	0xbef703ff, 0x10807fac,
 	0xb97202dc, 0x8f729972,
-	0x8872727f, 0x876eff7f,
-	0x04000000, 0xbf840034,
+	0x876eff7f, 0x04000000,
+	0xbf840034, 0xbefe03c1,
+	0x907c9972, 0x877c817c,
+	0xbf06817c, 0xbf850002,
+	0xbeff0380, 0xbf820001,
+	0xbeff03c1, 0xb96f4306,
+	0x876fc16f, 0xbf840029,
+	0x8f6f866f, 0x8f6f826f,
+	0xbef6036f, 0xb9782a05,
+	0x80788178, 0xbf0d9972,
+	0xbf850002, 0x8f788978,
+	0xbf820001, 0x8f788a78,
+	0xb96e1e06, 0x8f6e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef603ff,
+	0x01000000, 0x907c9972,
+	0x877c817c, 0xbf06817c,
+	0xbefc0380, 0xbf850009,
+	0xe0310000, 0x781d0000,
+	0x807cff7c, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7c, 0xbf85fff8,
+	0xbf820008, 0xe0310000,
+	0x781d0000, 0x807cff7c,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7c,
+	0xbf85fff8, 0xbef80380,
 	0xbefe03c1, 0x907c9972,
 	0x877c817c, 0xbf06817c,
 	0xbf850002, 0xbeff0380,
 	0xbf820001, 0xbeff03c1,
-	0xb96f4306, 0x876fc16f,
-	0xbf840029, 0x8f6f866f,
-	0x8f6f826f, 0xbef6036f,
-	0xb9782a05, 0x80788178,
-	0xbf0d9972, 0xbf850002,
-	0x8f788978, 0xbf820001,
-	0x8f788a78, 0xb96e1e06,
-	0x8f6e8a6e, 0x80786e78,
-	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef603ff, 0x01000000,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbefc0380,
-	0xbf850009, 0xe0310000,
-	0x781d0000, 0x807cff7c,
-	0x00000080, 0x8078ff78,
-	0x00000080, 0xbf0a6f7c,
-	0xbf85fff8, 0xbf820008,
-	0xe0310000, 0x781d0000,
-	0x807cff7c, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7c, 0xbf85fff8,
-	0xbef80380, 0xbefe03c1,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbf850002,
-	0xbeff0380, 0xbf820001,
-	0xbeff03c1, 0xb96f2a05,
-	0x806f816f, 0x8f6f826f,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbf850021,
-	0xbef603ff, 0x01000000,
-	0xbeee0378, 0x8078ff78,
-	0x00000200, 0xbefc0384,
-	0xe0304000, 0x785d0000,
-	0xe0304080, 0x785d0100,
-	0xe0304100, 0x785d0200,
-	0xe0304180, 0x785d0300,
-	0xbf8c3f70, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807c847c,
-	0x8078ff78, 0x00000200,
-	0xbf0a6f7c, 0xbf85ffee,
-	0xe0304000, 0x6e5d0000,
-	0xe0304080, 0x6e5d0100,
-	0xe0304100, 0x6e5d0200,
-	0xe0304180, 0x6e5d0300,
-	0xbf820032, 0xbef603ff,
+	0xb96f2a05, 0x806f816f,
+	0x8f6f826f, 0x907c9972,
+	0x877c817c, 0xbf06817c,
+	0xbf850021, 0xbef603ff,
 	0x01000000, 0xbeee0378,
-	0x8078ff78, 0x00000400,
+	0x8078ff78, 0x00000200,
 	0xbefc0384, 0xe0304000,
-	0x785d0000, 0xe0304100,
-	0x785d0100, 0xe0304200,
-	0x785d0200, 0xe0304300,
+	0x785d0000, 0xe0304080,
+	0x785d0100, 0xe0304100,
+	0x785d0200, 0xe0304180,
 	0x785d0300, 0xbf8c3f70,
 	0x7e008500, 0x7e028501,
 	0x7e048502, 0x7e068503,
 	0x807c847c, 0x8078ff78,
-	0x00000400, 0xbf0a6f7c,
-	0xbf85ffee, 0xb96f1e06,
-	0x876fc16f, 0xbf84000e,
-	0x8f6f836f, 0x806f7c6f,
-	0xbefe03c1, 0xbeff0380,
+	0x00000200, 0xbf0a6f7c,
+	0xbf85ffee, 0xe0304000,
+	0x6e5d0000, 0xe0304080,
+	0x6e5d0100, 0xe0304100,
+	0x6e5d0200, 0xe0304180,
+	0x6e5d0300, 0xbf820032,
+	0xbef603ff, 0x01000000,
+	0xbeee0378, 0x8078ff78,
+	0x00000400, 0xbefc0384,
 	0xe0304000, 0x785d0000,
+	0xe0304100, 0x785d0100,
+	0xe0304200, 0x785d0200,
+	0xe0304300, 0x785d0300,
 	0xbf8c3f70, 0x7e008500,
-	0x807c817c, 0x8078ff78,
-	0x00000080, 0xbf0a6f7c,
-	0xbf85fff7, 0xbeff03c1,
-	0xe0304000, 0x6e5d0000,
-	0xe0304100, 0x6e5d0100,
-	0xe0304200, 0x6e5d0200,
-	0xe0304300, 0x6e5d0300,
-	0xbf8c3f70, 0xb9782a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0x80f8ff78,
-	0x00000050, 0xbef603ff,
-	0x01000000, 0xbefc03ff,
-	0x0000006c, 0x80f89078,
-	0xf429003a, 0xf0000000,
-	0xbf8cc07f, 0x80fc847c,
-	0xbf800000, 0xbe803100,
-	0xbe823102, 0x80f8a078,
-	0xf42d003a, 0xf0000000,
-	0xbf8cc07f, 0x80fc887c,
-	0xbf800000, 0xbe803100,
-	0xbe823102, 0xbe843104,
-	0xbe863106, 0x80f8c078,
-	0xf431003a, 0xf0000000,
-	0xbf8cc07f, 0x80fc907c,
-	0xbf800000, 0xbe803100,
-	0xbe823102, 0xbe843104,
-	0xbe863106, 0xbe883108,
-	0xbe8a310a, 0xbe8c310c,
-	0xbe8e310e, 0xbf06807c,
-	0xbf84fff0, 0xba80f801,
-	0x00000000, 0xbf8a0000,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807c847c,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7c, 0xbf85ffee,
+	0xb96f1e06, 0x876fc16f,
+	0xbf84000e, 0x8f6f836f,
+	0x806f7c6f, 0xbefe03c1,
+	0xbeff0380, 0xe0304000,
+	0x785d0000, 0xbf8c3f70,
+	0x7e008500, 0x807c817c,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7c, 0xbf85fff7,
+	0xbeff03c1, 0xe0304000,
+	0x6e5d0000, 0xe0304100,
+	0x6e5d0100, 0xe0304200,
+	0x6e5d0200, 0xe0304300,
+	0x6e5d0300, 0xbf8c3f70,
 	0xb9782a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
 	0x8f6e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
+	0x80f8ff78, 0x00000050,
 	0xbef603ff, 0x01000000,
-	0xf4211bfa, 0xf0000000,
-	0x80788478, 0xf4211b3a,
+	0xbefc03ff, 0x0000006c,
+	0x80f89078, 0xf429003a,
+	0xf0000000, 0xbf8cc07f,
+	0x80fc847c, 0xbf800000,
+	0xbe803100, 0xbe823102,
+	0x80f8a078, 0xf42d003a,
+	0xf0000000, 0xbf8cc07f,
+	0x80fc887c, 0xbf800000,
+	0xbe803100, 0xbe823102,
+	0xbe843104, 0xbe863106,
+	0x80f8c078, 0xf431003a,
+	0xf0000000, 0xbf8cc07f,
+	0x80fc907c, 0xbf800000,
+	0xbe803100, 0xbe823102,
+	0xbe843104, 0xbe863106,
+	0xbe883108, 0xbe8a310a,
+	0xbe8c310c, 0xbe8e310e,
+	0xbf06807c, 0xbf84fff0,
+	0xba80f801, 0x00000000,
+	0xbf8a0000, 0xb9782a05,
+	0x80788178, 0xbf0d9972,
+	0xbf850002, 0x8f788978,
+	0xbf820001, 0x8f788a78,
+	0xb96e1e06, 0x8f6e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0xbef603ff,
+	0x01000000, 0xf4211bfa,
 	0xf0000000, 0x80788478,
-	0xf4211b7a, 0xf0000000,
-	0x80788478, 0xf4211c3a,
+	0xf4211b3a, 0xf0000000,
+	0x80788478, 0xf4211b7a,
 	0xf0000000, 0x80788478,
-	0xf4211c7a, 0xf0000000,
-	0x80788478, 0xf4211eba,
+	0xf4211c3a, 0xf0000000,
+	0x80788478, 0xf4211c7a,
 	0xf0000000, 0x80788478,
-	0xf4211efa, 0xf0000000,
-	0x80788478, 0xf4211e7a,
+	0xf4211eba, 0xf0000000,
+	0x80788478, 0xf4211efa,
 	0xf0000000, 0x80788478,
-	0xf4211cfa, 0xf0000000,
-	0x80788478, 0xf4211bba,
+	0xf4211e7a, 0xf0000000,
+	0x80788478, 0xf4211cfa,
 	0xf0000000, 0x80788478,
-	0xbf8cc07f, 0xb9eef814,
 	0xf4211bba, 0xf0000000,
 	0x80788478, 0xbf8cc07f,
-	0xb9eef815, 0xbefc036f,
-	0xbefe0370, 0xbeff0371,
-	0x876f7bff, 0x000003ff,
-	0xb9ef4803, 0xb9f9f816,
-	0x876f7bff, 0xfffff800,
-	0x906f8b6f, 0xb9efa2c3,
-	0xb9f3f801, 0xb96e2a05,
-	0x806e816e, 0xbf0d9972,
-	0xbf850002, 0x8f6e896e,
-	0xbf820001, 0x8f6e8a6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x876fff6f, 0x0000ffff,
-	0xf4091c37, 0xfa000050,
-	0xf4091d37, 0xfa000060,
-	0xf4011e77, 0xfa000074,
-	0xbf8cc07f, 0x906e8977,
-	0x876fff6e, 0x003f8000,
-	0x906e8677, 0x876eff6e,
-	0x02000000, 0x886e6f6e,
-	0xb9eef807, 0x876dff6d,
-	0x0000ffff, 0x87fe7e7e,
-	0x87ea6a6a, 0xb9faf802,
-	0xbe80226c, 0xbf810000,
+	0xb9eef814, 0xf4211bba,
+	0xf0000000, 0x80788478,
+	0xbf8cc07f, 0xb9eef815,
+	0xbefc036f, 0xbefe0370,
+	0xbeff0371, 0x876f7bff,
+	0x000003ff, 0xb9ef4803,
+	0xb9f9f816, 0x876f7bff,
+	0xfffff800, 0x906f8b6f,
+	0xb9efa2c3, 0xb9f3f801,
+	0xb96e2a05, 0x806e816e,
+	0xbf0d9972, 0xbf850002,
+	0x8f6e896e, 0xbf820001,
+	0x8f6e8a6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x876fff6f,
+	0x0000ffff, 0xf4091c37,
+	0xfa000050, 0xf4091d37,
+	0xfa000060, 0xf4011e77,
+	0xfa000074, 0xbf8cc07f,
+	0x906e8977, 0x876fff6e,
+	0x003f8000, 0x906e8677,
+	0x876eff6e, 0x02000000,
+	0x886e6f6e, 0xb9eef807,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0xb9faf802, 0xbe80226c,
+	0xbf810000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
@@ -1533,7 +1534,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx10_hex[] = {
-	0xbf820001, 0xbf8201c7,
+	0xbf820001, 0xbf8201cb,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -1560,21 +1561,22 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xb9fa0283, 0xbeee037e,
 	0xbeef037f, 0xbefe0480,
 	0xbf900004, 0xbf8cc07f,
+	0x877aff7f, 0x04000000,
+	0x8f7a857a, 0x886d7a6d,
 	0xb97b02dc, 0x8f7b997b,
-	0x887b7b7f, 0xb97a2a05,
-	0x807a817a, 0xbf0d997b,
-	0xbf850002, 0x8f7a897a,
-	0xbf820001, 0x8f7a8a7a,
-	0x877bff7f, 0x0000ffff,
-	0x807aff7a, 0x00000200,
-	0x807a7e7a, 0x827b807b,
-	0xbef4037e, 0x8775ff7f,
-	0x0000ffff, 0x8875ff75,
-	0x00040000, 0xbef60380,
-	0xbef703ff, 0x10807fac,
-	0xbef1037c, 0xbef00380,
-	0xb97302dc, 0x8f739973,
-	0x8873737f, 0xbefe03c1,
+	0xb97a2a05, 0x807a817a,
+	0xbf0d997b, 0xbf850002,
+	0x8f7a897a, 0xbf820001,
+	0x8f7a8a7a, 0x877bff7f,
+	0x0000ffff, 0x807aff7a,
+	0x00000200, 0x807a7e7a,
+	0x827b807b, 0xbef4037e,
+	0x8775ff7f, 0x0000ffff,
+	0x8875ff75, 0x00040000,
+	0xbef60380, 0xbef703ff,
+	0x10807fac, 0xbef1037c,
+	0xbef00380, 0xb97302dc,
+	0x8f739973, 0xbefe03c1,
 	0x907c9973, 0x877c817c,
 	0xbf06817c, 0xbf850002,
 	0xbeff0380, 0xbf820002,
@@ -1601,8 +1603,9 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbefc0380, 0xd7610002,
 	0x0000f871, 0x807c817c,
 	0xd7610002, 0x0000f86c,
-	0x807c817c, 0xd7610002,
-	0x0000f86d, 0x807c817c,
+	0x807c817c, 0x8a7aff6d,
+	0x80000000, 0xd7610002,
+	0x0000f87a, 0x807c817c,
 	0xd7610002, 0x0000f86e,
 	0x807c817c, 0xd7610002,
 	0x0000f86f, 0x807c817c,
@@ -1688,7 +1691,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbf820001, 0xbeff03c1,
 	0xb97b4306, 0x877bc17b,
 	0xbf840044, 0xbf8a0000,
-	0x877aff73, 0x04000000,
+	0x877aff6d, 0x80000000,
 	0xbf840040, 0x8f7b867b,
 	0x8f7b827b, 0xbef6037b,
 	0xb9702a05, 0x80708170,
@@ -1761,162 +1764,161 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x705d0000, 0x807c817c,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7c, 0xbf85fff8,
-	0xbf820134, 0xbef4037e,
+	0xbf820133, 0xbef4037e,
 	0x8775ff7f, 0x0000ffff,
 	0x8875ff75, 0x00040000,
 	0xbef60380, 0xbef703ff,
 	0x10807fac, 0xb97202dc,
-	0x8f729972, 0x8872727f,
-	0x876eff7f, 0x04000000,
-	0xbf840034, 0xbefe03c1,
-	0x907c9972, 0x877c817c,
-	0xbf06817c, 0xbf850002,
-	0xbeff0380, 0xbf820001,
-	0xbeff03c1, 0xb96f4306,
-	0x876fc16f, 0xbf840029,
-	0x8f6f866f, 0x8f6f826f,
-	0xbef6036f, 0xb9782a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0x8078ff78,
-	0x00000080, 0xbef603ff,
-	0x01000000, 0x907c9972,
-	0x877c817c, 0xbf06817c,
-	0xbefc0380, 0xbf850009,
-	0xe0310000, 0x781d0000,
-	0x807cff7c, 0x00000080,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7c, 0xbf85fff8,
-	0xbf820008, 0xe0310000,
-	0x781d0000, 0x807cff7c,
-	0x00000100, 0x8078ff78,
-	0x00000100, 0xbf0a6f7c,
-	0xbf85fff8, 0xbef80380,
+	0x8f729972, 0x876eff7f,
+	0x04000000, 0xbf840034,
 	0xbefe03c1, 0x907c9972,
 	0x877c817c, 0xbf06817c,
 	0xbf850002, 0xbeff0380,
 	0xbf820001, 0xbeff03c1,
-	0xb96f2a05, 0x806f816f,
-	0x8f6f826f, 0x907c9972,
-	0x877c817c, 0xbf06817c,
-	0xbf850021, 0xbef603ff,
-	0x01000000, 0xbeee0378,
+	0xb96f4306, 0x876fc16f,
+	0xbf840029, 0x8f6f866f,
+	0x8f6f826f, 0xbef6036f,
+	0xb9782a05, 0x80788178,
+	0xbf0d9972, 0xbf850002,
+	0x8f788978, 0xbf820001,
+	0x8f788a78, 0xb96e1e06,
+	0x8f6e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0xbefc0384, 0xe0304000,
-	0x785d0000, 0xe0304080,
-	0x785d0100, 0xe0304100,
-	0x785d0200, 0xe0304180,
-	0x785d0300, 0xbf8c3f70,
-	0x7e008500, 0x7e028501,
-	0x7e048502, 0x7e068503,
-	0x807c847c, 0x8078ff78,
-	0x00000200, 0xbf0a6f7c,
-	0xbf85ffee, 0xe0304000,
-	0x6e5d0000, 0xe0304080,
-	0x6e5d0100, 0xe0304100,
-	0x6e5d0200, 0xe0304180,
-	0x6e5d0300, 0xbf820032,
+	0x8078ff78, 0x00000080,
+	0xbef603ff, 0x01000000,
+	0x907c9972, 0x877c817c,
+	0xbf06817c, 0xbefc0380,
+	0xbf850009, 0xe0310000,
+	0x781d0000, 0x807cff7c,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7c,
+	0xbf85fff8, 0xbf820008,
+	0xe0310000, 0x781d0000,
+	0x807cff7c, 0x00000100,
+	0x8078ff78, 0x00000100,
+	0xbf0a6f7c, 0xbf85fff8,
+	0xbef80380, 0xbefe03c1,
+	0x907c9972, 0x877c817c,
+	0xbf06817c, 0xbf850002,
+	0xbeff0380, 0xbf820001,
+	0xbeff03c1, 0xb96f2a05,
+	0x806f816f, 0x8f6f826f,
+	0x907c9972, 0x877c817c,
+	0xbf06817c, 0xbf850021,
 	0xbef603ff, 0x01000000,
 	0xbeee0378, 0x8078ff78,
-	0x00000400, 0xbefc0384,
+	0x00000200, 0xbefc0384,
 	0xe0304000, 0x785d0000,
-	0xe0304100, 0x785d0100,
-	0xe0304200, 0x785d0200,
-	0xe0304300, 0x785d0300,
+	0xe0304080, 0x785d0100,
+	0xe0304100, 0x785d0200,
+	0xe0304180, 0x785d0300,
 	0xbf8c3f70, 0x7e008500,
 	0x7e028501, 0x7e048502,
 	0x7e068503, 0x807c847c,
-	0x8078ff78, 0x00000400,
+	0x8078ff78, 0x00000200,
 	0xbf0a6f7c, 0xbf85ffee,
-	0xb96f1e06, 0x876fc16f,
-	0xbf84000e, 0x8f6f836f,
-	0x806f7c6f, 0xbefe03c1,
-	0xbeff0380, 0xe0304000,
-	0x785d0000, 0xbf8c3f70,
-	0x7e008500, 0x807c817c,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7c, 0xbf85fff7,
-	0xbeff03c1, 0xe0304000,
-	0x6e5d0000, 0xe0304100,
-	0x6e5d0100, 0xe0304200,
-	0x6e5d0200, 0xe0304300,
-	0x6e5d0300, 0xbf8c3f70,
+	0xe0304000, 0x6e5d0000,
+	0xe0304080, 0x6e5d0100,
+	0xe0304100, 0x6e5d0200,
+	0xe0304180, 0x6e5d0300,
+	0xbf820032, 0xbef603ff,
+	0x01000000, 0xbeee0378,
+	0x8078ff78, 0x00000400,
+	0xbefc0384, 0xe0304000,
+	0x785d0000, 0xe0304100,
+	0x785d0100, 0xe0304200,
+	0x785d0200, 0xe0304300,
+	0x785d0300, 0xbf8c3f70,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807c847c, 0x8078ff78,
+	0x00000400, 0xbf0a6f7c,
+	0xbf85ffee, 0xb96f1e06,
+	0x876fc16f, 0xbf84000e,
+	0x8f6f836f, 0x806f7c6f,
+	0xbefe03c1, 0xbeff0380,
+	0xe0304000, 0x785d0000,
+	0xbf8c3f70, 0x7e008500,
+	0x807c817c, 0x8078ff78,
+	0x00000080, 0xbf0a6f7c,
+	0xbf85fff7, 0xbeff03c1,
+	0xe0304000, 0x6e5d0000,
+	0xe0304100, 0x6e5d0100,
+	0xe0304200, 0x6e5d0200,
+	0xe0304300, 0x6e5d0300,
+	0xbf8c3f70, 0xb9782a05,
+	0x80788178, 0xbf0d9972,
+	0xbf850002, 0x8f788978,
+	0xbf820001, 0x8f788a78,
+	0xb96e1e06, 0x8f6e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000050, 0xbef603ff,
+	0x01000000, 0xbefc03ff,
+	0x0000006c, 0x80f89078,
+	0xf429003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc847c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0x80f8a078,
+	0xf42d003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc887c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0xbe843104,
+	0xbe863106, 0x80f8c078,
+	0xf431003a, 0xf0000000,
+	0xbf8cc07f, 0x80fc907c,
+	0xbf800000, 0xbe803100,
+	0xbe823102, 0xbe843104,
+	0xbe863106, 0xbe883108,
+	0xbe8a310a, 0xbe8c310c,
+	0xbe8e310e, 0xbf06807c,
+	0xbf84fff0, 0xba80f801,
+	0x00000000, 0xbf8a0000,
 	0xb9782a05, 0x80788178,
 	0xbf0d9972, 0xbf850002,
 	0x8f788978, 0xbf820001,
 	0x8f788a78, 0xb96e1e06,
 	0x8f6e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000050,
 	0xbef603ff, 0x01000000,
-	0xbefc03ff, 0x0000006c,
-	0x80f89078, 0xf429003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc847c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0x80f8a078, 0xf42d003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc887c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0xbe843104, 0xbe863106,
-	0x80f8c078, 0xf431003a,
-	0xf0000000, 0xbf8cc07f,
-	0x80fc907c, 0xbf800000,
-	0xbe803100, 0xbe823102,
-	0xbe843104, 0xbe863106,
-	0xbe883108, 0xbe8a310a,
-	0xbe8c310c, 0xbe8e310e,
-	0xbf06807c, 0xbf84fff0,
-	0xba80f801, 0x00000000,
-	0xbf8a0000, 0xb9782a05,
-	0x80788178, 0xbf0d9972,
-	0xbf850002, 0x8f788978,
-	0xbf820001, 0x8f788a78,
-	0xb96e1e06, 0x8f6e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef603ff,
-	0x01000000, 0xf4211bfa,
+	0xf4211bfa, 0xf0000000,
+	0x80788478, 0xf4211b3a,
 	0xf0000000, 0x80788478,
-	0xf4211b3a, 0xf0000000,
-	0x80788478, 0xf4211b7a,
+	0xf4211b7a, 0xf0000000,
+	0x80788478, 0xf4211c3a,
 	0xf0000000, 0x80788478,
-	0xf4211c3a, 0xf0000000,
-	0x80788478, 0xf4211c7a,
+	0xf4211c7a, 0xf0000000,
+	0x80788478, 0xf4211eba,
 	0xf0000000, 0x80788478,
-	0xf4211eba, 0xf0000000,
-	0x80788478, 0xf4211efa,
+	0xf4211efa, 0xf0000000,
+	0x80788478, 0xf4211e7a,
 	0xf0000000, 0x80788478,
-	0xf4211e7a, 0xf0000000,
-	0x80788478, 0xf4211cfa,
+	0xf4211cfa, 0xf0000000,
+	0x80788478, 0xf4211bba,
 	0xf0000000, 0x80788478,
+	0xbf8cc07f, 0xb9eef814,
 	0xf4211bba, 0xf0000000,
 	0x80788478, 0xbf8cc07f,
-	0xb9eef814, 0xf4211bba,
-	0xf0000000, 0x80788478,
-	0xbf8cc07f, 0xb9eef815,
-	0xbefc036f, 0xbefe0370,
-	0xbeff0371, 0x876f7bff,
-	0x000003ff, 0xb9ef4803,
-	0x876f7bff, 0xfffff800,
-	0x906f8b6f, 0xb9efa2c3,
-	0xb9f3f801, 0xb96e2a05,
-	0x806e816e, 0xbf0d9972,
-	0xbf850002, 0x8f6e896e,
-	0xbf820001, 0x8f6e8a6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x876fff6f, 0x0000ffff,
-	0xf4091c37, 0xfa000050,
-	0xf4091d37, 0xfa000060,
-	0xf4011e77, 0xfa000074,
-	0xbf8cc07f, 0x876dff6d,
-	0x0000ffff, 0x87fe7e7e,
-	0x87ea6a6a, 0xb9faf802,
-	0xbe80226c, 0xbf810000,
+	0xb9eef815, 0xbefc036f,
+	0xbefe0370, 0xbeff0371,
+	0x876f7bff, 0x000003ff,
+	0xb9ef4803, 0x876f7bff,
+	0xfffff800, 0x906f8b6f,
+	0xb9efa2c3, 0xb9f3f801,
+	0xb96e2a05, 0x806e816e,
+	0xbf0d9972, 0xbf850002,
+	0x8f6e896e, 0xbf820001,
+	0x8f6e8a6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x876fff6f,
+	0x0000ffff, 0xf4091c37,
+	0xfa000050, 0xf4091d37,
+	0xfa000060, 0xf4011e77,
+	0xfa000074, 0xbf8cc07f,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0xb9faf802, 0xbe80226c,
+	0xbf810000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 69721aea57b6..06947a8767c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -83,6 +83,9 @@ var S_SAVE_BUF_RSRC_WORD3_MISC			= 0x10807FAC
 var S_SAVE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 
+var S_SAVE_PC_HI_FIRST_WAVE_MASK		= 0x80000000
+var S_SAVE_PC_HI_FIRST_WAVE_SHIFT		= 31
+
 var s_sgpr_save_num				= 108
 
 var s_save_spi_init_lo				= exec_lo
@@ -245,6 +248,11 @@ L_SLEEP:
 	s_waitcnt	lgkmcnt(0)
 #endif
 
+	// Save first_wave flag so we can clear high bits of save address.
+	s_and_b32	s_save_tmp, s_save_spi_init_hi, S_SAVE_SPI_INIT_FIRST_WAVE_MASK
+	s_lshl_b32	s_save_tmp, s_save_tmp, (S_SAVE_PC_HI_FIRST_WAVE_SHIFT - S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT)
+	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
+
 	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
 	// ttmp SR memory offset : size(VGPR)+size(SGPR)+0x40
 	get_wave_size(s_save_ttmps_hi)
@@ -331,7 +339,8 @@ L_SAVE_HWREG:
 
 	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
 	write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offset)
-	write_hwreg_to_mem(s_save_pc_hi, s_save_buf_rsrc0, s_save_mem_offset)
+	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
+	write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
 	write_hwreg_to_mem(s_save_exec_lo, s_save_buf_rsrc0, s_save_mem_offset)
 	write_hwreg_to_mem(s_save_exec_hi, s_save_buf_rsrc0, s_save_mem_offset)
 	write_hwreg_to_mem(s_save_status, s_save_buf_rsrc0, s_save_mem_offset)
@@ -440,7 +449,7 @@ L_SAVE_LDS_NORMAL:
 	s_cbranch_scc0	L_SAVE_LDS_DONE						//no lds used? jump to L_SAVE_DONE
 
 	s_barrier								//LDS is used? wait for other waves in the same TG
-	s_and_b32	s_save_tmp, s_wave_size, S_SAVE_SPI_INIT_FIRST_WAVE_MASK
+	s_and_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
 	s_cbranch_scc0	L_SAVE_LDS_DONE
 
 	// first wave do LDS save;
@@ -1002,7 +1011,6 @@ end
 function get_wave_size(s_reg)
 	s_getreg_b32	s_reg, hwreg(HW_REG_IB_STS2,SQ_WAVE_IB_STS2_WAVE64_SHIFT,SQ_WAVE_IB_STS2_WAVE64_SIZE)
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
-	s_or_b32	s_reg, s_save_spi_init_hi, s_reg			//share with exec_hi, it's at bit25
 end
 
 function save_and_clear_ib_sts(tmp1, tmp2)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
