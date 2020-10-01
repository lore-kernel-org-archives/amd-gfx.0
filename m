Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC26DC4727E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3564F20754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h/vJkxHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3564F20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13E46E17B;
	Thu,  1 Oct 2020 18:24:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8CD6E17B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 18:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiVs8xuV9t42///w+TGX4YF/PT7HdO/b1A6t+jKz8ph8ZXiRAatY3fjA2u7w3WgikIUmaY7EwERka8JeZf3tB/JESIlCX7PA0SZKUZFiL0bmRNxmNKDJHqMPOnaScdOEgjjsrkPM3git699YwnLYvHBE8PWptx95rSSu7u1M1annAKwTBve5Gy8osmPv5IOE8RSl1E2uHgS5m6boGWIyfZVQ1mqCjl05uTN1bdU07DUgH56tYelVVs+pvS/eSKjGhWM+zh2MEIXxpIdg4ZMYnpaiJ2fuiNFztTMrGP8p351OrZqOkh4iLgZavLLtNwkLfdkZuADNZYtZg7bpMCFKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq6K3lV5oIeX232r+Y4F1E3rkGZMOsUj0RCWRb81xmU=;
 b=E7T/Nn/8UWpwYypzPkfKdX0IAkNXCmBUp5W/C65F5RKBMazhgvjD0ZERQ0outvrVy0lF07NmWfkoswqB6VKA0eEe3e4LYtFmfD6HuJmSfUovD/W7an57zVZ2ECw0qBestFEbhzbi//HucOQO+F/qrzXdSx33JPzqlhfLTIn4fw9e2Q8x8vJ/yNdkx6tZ8fDMNcWf3UyVI4nL8bC81hvMw8ZiIU5bvvQXh6G9rSC9tMamJvrqAl6Jz3CpO7pLYj6YzaBFqBoHOfjdlH2jXJkNruYVvO80CYMcSUPr7SmjrEcqbbSJ3hyDRtoVgOBeinwGqXahnkG4unS9n3qGgxcb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq6K3lV5oIeX232r+Y4F1E3rkGZMOsUj0RCWRb81xmU=;
 b=h/vJkxHP4CK5ownZbd4n6CPD6Hg+4dYMNCXyI9Sx1U1lAPS076MwErUqwKwK1jkbyUuYqtnD0rwiRGohwaA3fuRHBFrcfXikqFu4dF5QQX1gtM8nRthPz705LJWVgkSC0JjPF9hzfWJB3it6mpBJZ2u//ZIQdcqvcLHk+R439MU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 1 Oct
 2020 18:24:38 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591%4]) with mapi id 15.20.3433.038; Thu, 1 Oct 2020
 18:24:38 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdkfd: Remove legacy code from trap handler
Date: Thu,  1 Oct 2020 13:24:05 -0500
Message-Id: <20201001182408.3960-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.17.1
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
 Transport; Thu, 1 Oct 2020 18:24:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c62837d5-a2d7-4cae-eadc-08d866374183
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB444676BAF6EC11CEAA2C872587300@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwUy71TUQrakejRxIh+W4uofSzFY5IW1jiQfVSZSNMC5flIzIOnxdS7WjXFu0GvWLCwecOjkUZ3jCQi7Xj5LNZb1Mz/ijpT4CxoXESWY+CMjOF0ObK9pn+tRu9y6OBPsbhI/KQLKoDIfr8/kGyesEpTNAfdno7kDQ4IeWLClvdxnX9KHLw2A2pYDRfLit99DIAccMKevCNXqndW/EGcchKsnFEB296W4inb/DfyIyJ4CUAdD++Qphw1SAxVHgJGXOTNVjmYXYOZekiEZm3wv5j9DfxgRqS/itXVYTJSIroVNf1vmiLh6pXc1R3dii1P1qh7rO0oAkEWXLeN5bJ0UIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66556008)(16526019)(1076003)(66476007)(186003)(36756003)(4326008)(66946007)(26005)(5660300002)(2616005)(8676002)(86362001)(6916009)(6666004)(83380400001)(52116002)(7696005)(8936002)(2906002)(44832011)(6486002)(478600001)(956004)(54906003)(316002)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SN5wL6nQTyYuAhIRkqJ8ZOaNs9HKFK6um+u6PEVamdONuZnbiCzwgD7Hfmdo3xMTzswr5gh/tocXMNRJCU56kGMUZxW2pQPRYSC6FsK1HIe6rD1pD8l8x6evRrlF7vVM6pn91KlE4WKzfdiLo0c5REMIvqJoJfupxhWZlxzZeQx1AloYNz/ANHZZ4wz9jGJA2R45uoHIJSu/QTpbS9+s3OQp/MjPrhGqIZUF/f0z11gzPF3zXqbAbGTLrQzvDvzhJTkb6CoUMzauFQIUwOfCH8DOo3dH/hbmphqMNnXNrY3zAUWuBhS69MhSTdV8Pui5mDB09upI/nmfxCtDYtrLEF9+TkHa4QVT550SDTC6I7zlUnHGaXP6+2SCaRDAWy1Hz3KPXzODoCizXkzVXPeMmNIsvapNIRak9qQJQgJsQSHt6UukkOUrM/doXc8NaAdWEXWJVX2mAgF6WnPnQQzuHECbbsbTr1kLh9djkc0sKTrIElBNzXljGxHPTj98bokmNN4DOeGngkRNDSVcbaKgdddRKX3y22RHpGDfAWSel2vfa3uMwhhEQr0734ddlkd9W5YMpFZWFFmTEWIJPhXx46mitC+C2CPC570DTSZftNyblyyxe4C15+iXfaWPcwx+cWqXht0z4WceE2iwwwCTPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62837d5-a2d7-4cae-eadc-08d866374183
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:24:38.7030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDdSa5yOhB25itkfHtfvdYDbxZIAHlWIxo9VMOx0qVZlNeck2DXYDO8Z4xr9wdFmVbz4qQRJVBf0BchDfSTvyA==
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

ATC and MTYPE fields do not exist in gfx9 or later.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 93 ++++++-------------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 28 +-----
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm | 30 +-----
 3 files changed, 30 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index affbca7c0050..aa2de525b2e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -274,7 +274,7 @@ static const uint32_t cwsr_trap_gfx8_hex[] = {
 
 
 static const uint32_t cwsr_trap_gfx9_hex[] = {
-	0xbf820001, 0xbf820248,
+	0xbf820001, 0xbf820240,
 	0xb8f8f802, 0x89788678,
 	0xb8eef801, 0x866eff6e,
 	0x00000800, 0xbf840003,
@@ -336,10 +336,6 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
 	0xbef700ff, 0x00807fac,
-	0x867aff7f, 0x08000000,
-	0x8f7a837a, 0x87777a77,
-	0x867aff7f, 0x70000000,
-	0x8f7a817a, 0x87777a77,
 	0xbef1007c, 0xbef00080,
 	0xb8f02a05, 0x80708170,
 	0x8e708a70, 0xb8fa1605,
@@ -566,15 +562,11 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x701d0300, 0x807c847c,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffef,
-	0xbf9c0000, 0xbf8200da,
+	0xbf9c0000, 0xbf8200cf,
 	0xbef4007e, 0x8675ff7f,
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
 	0xbef700ff, 0x00807fac,
-	0x866eff7f, 0x08000000,
-	0x8f6e836e, 0x87776e77,
-	0x866eff7f, 0x70000000,
-	0x8f6e816e, 0x87776e77,
 	0x866eff7f, 0x04000000,
 	0xbf84001e, 0xbefe00c1,
 	0xbeff00c1, 0xb8ef4306,
@@ -669,18 +661,16 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x876e6f6e, 0x866fff6d,
 	0x04000000, 0x8f6f9a6f,
 	0x8e6f8f6f, 0x876e6f6e,
-	0x866fff7a, 0x00800000,
-	0x8f6f976f, 0xb96ef807,
-	0x866dff6d, 0x0000ffff,
-	0x86fe7e7e, 0x86ea6a6a,
-	0x8f6e837a, 0xb96ee0c2,
-	0xbf800002, 0xb97a0002,
-	0xbf8a0000, 0x95806f6c,
-	0xbf810000, 0x00000000,
+	0xb96ef807, 0x866dff6d,
+	0x0000ffff, 0x86fe7e7e,
+	0x86ea6a6a, 0x8f6e837a,
+	0xb96ee0c2, 0xbf800002,
+	0xb97a0002, 0xbf8a0000,
+	0xbe801f6c, 0xbf810000,
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
-	0xbf820001, 0xbf8201cd,
+	0xbf820001, 0xbf8201c5,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -740,10 +730,6 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
 	0xbef703ff, 0x10807fac,
-	0x877aff7f, 0x08000000,
-	0x907a837a, 0x88777a77,
-	0x877aff7f, 0x70000000,
-	0x907a817a, 0x88777a77,
 	0xbef1037c, 0xbef00380,
 	0xb97302dc, 0x8f739973,
 	0x8873737f, 0xb97bf816,
@@ -911,15 +897,11 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x705d0000, 0x807c817c,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7c, 0xbf85fff8,
-	0xbf820151, 0xbef4037e,
+	0xbf820146, 0xbef4037e,
 	0x8775ff7f, 0x0000ffff,
 	0x8875ff75, 0x00040000,
 	0xbef60380, 0xbef703ff,
-	0x10807fac, 0x876eff7f,
-	0x08000000, 0x906e836e,
-	0x88776e77, 0x876eff7f,
-	0x70000000, 0x906e816e,
-	0x88776e77, 0xb97202dc,
+	0x10807fac, 0xb97202dc,
 	0x8f729972, 0x8872727f,
 	0x876eff7f, 0x04000000,
 	0xbf840034, 0xbefe03c1,
@@ -1075,18 +1057,17 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x886e6f6e, 0x876fff6d,
 	0x01000000, 0x906f986f,
 	0x8f6f996f, 0x886e6f6e,
-	0x876fff7a, 0x00800000,
-	0x906f976f, 0xb9eef807,
-	0x876dff6d, 0x0000ffff,
-	0x87fe7e7e, 0x87ea6a6a,
-	0xb9faf802, 0xbe80226c,
-	0xbf810000, 0xbf9f0000,
+	0xb9eef807, 0x876dff6d,
+	0x0000ffff, 0x87fe7e7e,
+	0x87ea6a6a, 0xb9faf802,
+	0xbe80226c, 0xbf810000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
-	0xbf820001, 0xbf8202c4,
+	0xbf820001, 0xbf8202bc,
 	0xb8f8f802, 0x89788678,
 	0xb8eef801, 0x866eff6e,
 	0x00000800, 0xbf840003,
@@ -1148,11 +1129,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x8675ff7f, 0x0000ffff,
 	0x8775ff75, 0x00040000,
 	0xbef60080, 0xbef700ff,
-	0x00807fac, 0x867aff7f,
-	0x08000000, 0x8f7a837a,
-	0x87777a77, 0x867aff7f,
-	0x70000000, 0x8f7a817a,
-	0x87777a77, 0xbef1007c,
+	0x00807fac, 0xbef1007c,
 	0xbef00080, 0xb8f02a05,
 	0x80708170, 0x8e708a70,
 	0x8e708170, 0xb8fa1605,
@@ -1440,15 +1417,11 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x701d0300, 0x807c847c,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffeb,
-	0xbf9c0000, 0xbf820106,
+	0xbf9c0000, 0xbf8200fb,
 	0xbef4007e, 0x8675ff7f,
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
 	0xbef700ff, 0x00807fac,
-	0x866eff7f, 0x08000000,
-	0x8f6e836e, 0x87776e77,
-	0x866eff7f, 0x70000000,
-	0x8f6e816e, 0x87776e77,
 	0x866eff7f, 0x04000000,
 	0xbf84001f, 0xbefe00c1,
 	0xbeff00c1, 0xb8ef4306,
@@ -1565,18 +1538,16 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x876e6f6e, 0x866fff6d,
 	0x04000000, 0x8f6f9a6f,
 	0x8e6f8f6f, 0x876e6f6e,
-	0x866fff7a, 0x00800000,
-	0x8f6f976f, 0xb96ef807,
-	0x866dff6d, 0x0000ffff,
-	0x86fe7e7e, 0x86ea6a6a,
-	0x8f6e837a, 0xb96ee0c2,
-	0xbf800002, 0xb97a0002,
-	0xbf8a0000, 0x95806f6c,
-	0xbf810000, 0x00000000,
+	0xb96ef807, 0x866dff6d,
+	0x0000ffff, 0x86fe7e7e,
+	0x86ea6a6a, 0x8f6e837a,
+	0xb96ee0c2, 0xbf800002,
+	0xb97a0002, 0xbf8a0000,
+	0xbe801f6c, 0xbf810000,
 };
 
 static const uint32_t cwsr_trap_gfx10_hex[] = {
-	0xbf820001, 0xbf8201cf,
+	0xbf820001, 0xbf8201c7,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -1615,10 +1586,6 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x0000ffff, 0x8875ff75,
 	0x00040000, 0xbef60380,
 	0xbef703ff, 0x10807fac,
-	0x877aff7f, 0x08000000,
-	0x907a837a, 0x88777a77,
-	0x877aff7f, 0x70000000,
-	0x907a817a, 0x88777a77,
 	0xbef1037c, 0xbef00380,
 	0xb97302dc, 0x8f739973,
 	0x8873737f, 0xbefe03c1,
@@ -1808,15 +1775,11 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x705d0000, 0x807c817c,
 	0x8070ff70, 0x00000080,
 	0xbf0a7b7c, 0xbf85fff8,
-	0xbf82013c, 0xbef4037e,
+	0xbf820134, 0xbef4037e,
 	0x8775ff7f, 0x0000ffff,
 	0x8875ff75, 0x00040000,
 	0xbef60380, 0xbef703ff,
-	0x10807fac, 0x876eff7f,
-	0x08000000, 0x906e836e,
-	0x88776e77, 0x876eff7f,
-	0x70000000, 0x906e816e,
-	0x88776e77, 0xb97202dc,
+	0x10807fac, 0xb97202dc,
 	0x8f729972, 0x8872727f,
 	0x876eff7f, 0x04000000,
 	0xbf840034, 0xbefe03c1,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 5081f91190b8..c3344acdb094 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -35,8 +35,6 @@
 
 var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
 
-var SQ_WAVE_STATUS_INST_ATC_SHIFT		= 23
-var SQ_WAVE_STATUS_INST_ATC_MASK		= 0x00800000
 var SQ_WAVE_STATUS_SPI_PRIO_MASK		= 0x00000006
 var SQ_WAVE_STATUS_HALT_MASK			= 0x2000
 
@@ -76,9 +74,6 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG	= 0x00007FFF
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
 
-var SQ_BUF_RSRC_WORD1_ATC_SHIFT			= 24
-var SQ_BUF_RSRC_WORD3_MTYPE_SHIFT		= 27
-
 // bits [31:24] unused by SPI debug data
 var TTMP11_SAVE_REPLAY_W64H_SHIFT		= 31
 var TTMP11_SAVE_REPLAY_W64H_MASK		= 0x80000000
@@ -90,10 +85,6 @@ var TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK		= 0x7F000000
 var S_SAVE_BUF_RSRC_WORD1_STRIDE		= 0x00040000
 var S_SAVE_BUF_RSRC_WORD3_MISC			= 0x10807FAC
 
-var S_SAVE_SPI_INIT_ATC_MASK			= 0x08000000
-var S_SAVE_SPI_INIT_ATC_SHIFT			= 27
-var S_SAVE_SPI_INIT_MTYPE_MASK			= 0x70000000
-var S_SAVE_SPI_INIT_MTYPE_SHIFT			= 28
 var S_SAVE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 
@@ -130,10 +121,6 @@ var s_save_ttmps_hi				= s_save_trapsts
 var S_RESTORE_BUF_RSRC_WORD1_STRIDE		= S_SAVE_BUF_RSRC_WORD1_STRIDE
 var S_RESTORE_BUF_RSRC_WORD3_MISC		= S_SAVE_BUF_RSRC_WORD3_MISC
 
-var S_RESTORE_SPI_INIT_ATC_MASK			= 0x08000000
-var S_RESTORE_SPI_INIT_ATC_SHIFT		= 27
-var S_RESTORE_SPI_INIT_MTYPE_MASK		= 0x70000000
-var S_RESTORE_SPI_INIT_MTYPE_SHIFT		= 28
 var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_WAVE_SIZE					= 25
@@ -326,12 +313,6 @@ L_SLEEP:
 	s_or_b32	s_save_buf_rsrc1, s_save_buf_rsrc1, S_SAVE_BUF_RSRC_WORD1_STRIDE
 	s_mov_b32	s_save_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes) although not neccessarily inited
 	s_mov_b32	s_save_buf_rsrc3, S_SAVE_BUF_RSRC_WORD3_MISC
-	s_and_b32	s_save_tmp, s_save_spi_init_hi, S_SAVE_SPI_INIT_ATC_MASK
-	s_lshr_b32	s_save_tmp, s_save_tmp, (S_SAVE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)
-	s_or_b32	s_save_buf_rsrc3, s_save_buf_rsrc3, s_save_tmp		//or ATC
-	s_and_b32	s_save_tmp, s_save_spi_init_hi, S_SAVE_SPI_INIT_MTYPE_MASK
-	s_lshr_b32	s_save_tmp, s_save_tmp, (S_SAVE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)
-	s_or_b32	s_save_buf_rsrc3, s_save_buf_rsrc3, s_save_tmp		//or MTYPE
 
 	s_mov_b32	s_save_m0, m0
 
@@ -674,12 +655,7 @@ L_RESTORE:
 	s_or_b32	s_restore_buf_rsrc1, s_restore_buf_rsrc1, S_RESTORE_BUF_RSRC_WORD1_STRIDE
 	s_mov_b32	s_restore_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes)
 	s_mov_b32	s_restore_buf_rsrc3, S_RESTORE_BUF_RSRC_WORD3_MISC
-	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_ATC_MASK
-	s_lshr_b32	s_restore_tmp, s_restore_tmp, (S_RESTORE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)
-	s_or_b32	s_restore_buf_rsrc3, s_restore_buf_rsrc3, s_restore_tmp	//or ATC
-	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_MTYPE_MASK
-	s_lshr_b32	s_restore_tmp, s_restore_tmp, (S_RESTORE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)
-	s_or_b32	s_restore_buf_rsrc3, s_restore_buf_rsrc3, s_restore_tmp	//or MTYPE
+
 	//determine it is wave32 or wave64
 	get_wave_size(s_restore_size)
 
@@ -971,8 +947,6 @@ L_RESTORE_HWREG:
 	s_lshl_b32	s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT
 	s_or_b32	s_restore_tmp, s_restore_tmp, s_restore_m0
 
-	s_and_b32	s_restore_m0, s_restore_status, SQ_WAVE_STATUS_INST_ATC_MASK
-	s_lshr_b32	s_restore_m0, s_restore_m0, SQ_WAVE_STATUS_INST_ATC_SHIFT
 	s_setreg_b32 	hwreg(HW_REG_IB_STS), s_restore_tmp
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index 75f29d13c90f..0008eb7d1ef4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -31,8 +31,6 @@ var SINGLE_STEP_MISSED_WORKAROUND   =	1		    //workaround for lost MODE.DEBUG_EN
 /**************************************************************************/
 /*			variables					  */
 /**************************************************************************/
-var SQ_WAVE_STATUS_INST_ATC_SHIFT  = 23
-var SQ_WAVE_STATUS_INST_ATC_MASK   = 0x00800000
 var SQ_WAVE_STATUS_SPI_PRIO_SHIFT  = 1
 var SQ_WAVE_STATUS_SPI_PRIO_MASK   = 0x00000006
 var SQ_WAVE_STATUS_HALT_MASK       = 0x2000
@@ -70,9 +68,6 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG	= 0x00007FFF	//FIXME
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK		=   0x800
 
-var SQ_BUF_RSRC_WORD1_ATC_SHIFT	    =	24
-var SQ_BUF_RSRC_WORD3_MTYPE_SHIFT   =	27
-
 var TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT	=   26			// bits [31:26] unused by SPI debug data
 var TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK	=   0xFC000000
 
@@ -80,10 +75,6 @@ var TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK	=   0xFC000000
 var S_SAVE_BUF_RSRC_WORD1_STRIDE	=   0x00040000		//stride is 4 bytes
 var S_SAVE_BUF_RSRC_WORD3_MISC		=   0x00807FAC		//SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT_FLOAT, (0 for MUBUF stride[17:14] when ADD_TID_ENABLE and BUF_DATA_FORMAT_32 for MTBUF), ADD_TID_ENABLE
 
-var S_SAVE_SPI_INIT_ATC_MASK		=   0x08000000		//bit[27]: ATC bit
-var S_SAVE_SPI_INIT_ATC_SHIFT		=   27
-var S_SAVE_SPI_INIT_MTYPE_MASK		=   0x70000000		//bit[30:28]: Mtype
-var S_SAVE_SPI_INIT_MTYPE_SHIFT		=   28
 var S_SAVE_SPI_INIT_FIRST_WAVE_MASK	=   0x04000000		//bit[26]: FirstWaveInTG
 var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT	=   26
 
@@ -118,10 +109,6 @@ var s_save_ttmps_hi	    =	s_save_trapsts		//no conflict
 var S_RESTORE_BUF_RSRC_WORD1_STRIDE	    =	S_SAVE_BUF_RSRC_WORD1_STRIDE
 var S_RESTORE_BUF_RSRC_WORD3_MISC	    =	S_SAVE_BUF_RSRC_WORD3_MISC
 
-var S_RESTORE_SPI_INIT_ATC_MASK		    =	0x08000000	    //bit[27]: ATC bit
-var S_RESTORE_SPI_INIT_ATC_SHIFT	    =	27
-var S_RESTORE_SPI_INIT_MTYPE_MASK	    =	0x70000000	    //bit[30:28]: Mtype
-var S_RESTORE_SPI_INIT_MTYPE_SHIFT	    =	28
 var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK	    =	0x04000000	    //bit[26]: FirstWaveInTG
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT	    =	26
 
@@ -338,12 +325,6 @@ L_SAVE:
     s_or_b32	    s_save_buf_rsrc1,	s_save_buf_rsrc1,  S_SAVE_BUF_RSRC_WORD1_STRIDE
     s_mov_b32	    s_save_buf_rsrc2,	0									//NUM_RECORDS initial value = 0 (in bytes) although not neccessarily inited
     s_mov_b32	    s_save_buf_rsrc3,	S_SAVE_BUF_RSRC_WORD3_MISC
-    s_and_b32	    s_save_tmp,		s_save_spi_init_hi, S_SAVE_SPI_INIT_ATC_MASK
-    s_lshr_b32	    s_save_tmp,		s_save_tmp, (S_SAVE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)	    //get ATC bit into position
-    s_or_b32	    s_save_buf_rsrc3,	s_save_buf_rsrc3,  s_save_tmp						//or ATC
-    s_and_b32	    s_save_tmp,		s_save_spi_init_hi, S_SAVE_SPI_INIT_MTYPE_MASK
-    s_lshr_b32	    s_save_tmp,		s_save_tmp, (S_SAVE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)	    //get MTYPE bits into position
-    s_or_b32	    s_save_buf_rsrc3,	s_save_buf_rsrc3,  s_save_tmp						//or MTYPE
 
     //FIXME  right now s_save_m0/s_save_mem_offset use tma_lo/tma_hi  (might need to save them before using them?)
     s_mov_b32	    s_save_m0,		m0								    //save M0
@@ -673,12 +654,6 @@ L_RESTORE:
     s_or_b32	    s_restore_buf_rsrc1,    s_restore_buf_rsrc1,  S_RESTORE_BUF_RSRC_WORD1_STRIDE
     s_mov_b32	    s_restore_buf_rsrc2,    0										    //NUM_RECORDS initial value = 0 (in bytes)
     s_mov_b32	    s_restore_buf_rsrc3,    S_RESTORE_BUF_RSRC_WORD3_MISC
-    s_and_b32	    s_restore_tmp,	    s_restore_spi_init_hi, S_RESTORE_SPI_INIT_ATC_MASK
-    s_lshr_b32	    s_restore_tmp,	    s_restore_tmp, (S_RESTORE_SPI_INIT_ATC_SHIFT-SQ_BUF_RSRC_WORD1_ATC_SHIFT)	    //get ATC bit into position
-    s_or_b32	    s_restore_buf_rsrc3,    s_restore_buf_rsrc3,  s_restore_tmp						    //or ATC
-    s_and_b32	    s_restore_tmp,	    s_restore_spi_init_hi, S_RESTORE_SPI_INIT_MTYPE_MASK
-    s_lshr_b32	    s_restore_tmp,	    s_restore_tmp, (S_RESTORE_SPI_INIT_MTYPE_SHIFT-SQ_BUF_RSRC_WORD3_MTYPE_SHIFT)   //get MTYPE bits into position
-    s_or_b32	    s_restore_buf_rsrc3,    s_restore_buf_rsrc3,  s_restore_tmp						    //or MTYPE
 
     /*	    global mem offset		*/
 //  s_mov_b32	    s_restore_mem_offset, 0x0				    //mem offset initial value = 0
@@ -898,8 +873,6 @@ end
     s_lshr_b32	    s_restore_m0, s_restore_m0, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
     s_lshl_b32	    s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT
     s_or_b32	    s_restore_tmp, s_restore_tmp, s_restore_m0
-    s_and_b32	    s_restore_m0, s_restore_status, SQ_WAVE_STATUS_INST_ATC_MASK
-    s_lshr_b32	    s_restore_m0, s_restore_m0, SQ_WAVE_STATUS_INST_ATC_SHIFT
     s_setreg_b32    hwreg(HW_REG_IB_STS),   s_restore_tmp
 
     s_and_b32 s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff	//pc[47:32]	   //Do it here in order not to affect STATUS
@@ -909,8 +882,7 @@ end
 
     s_barrier							//barrier to ensure the readiness of LDS before access attempts from any other wave in the same TG //FIXME not performance-optimal at this time
 
-//  s_rfe_b64 s_restore_pc_lo					//Return to the main shader program and resume execution
-    s_rfe_restore_b64  s_restore_pc_lo, s_restore_m0		// s_restore_m0[0] is used to set STATUS.inst_atc
+    s_rfe_b64 s_restore_pc_lo					//Return to the main shader program and resume execution
 
 
 /**************************************************************************/
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
