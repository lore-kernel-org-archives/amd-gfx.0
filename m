Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3DC47423
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5151E20754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C+1x8Aax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5151E20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CED6E8C4;
	Thu,  1 Oct 2020 18:24:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80676E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 18:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5g/jcKfn1al2sVMEFcMl/SM9AjtLhupIjGBIEINnovUK2kaRRVuJLoOqsOVG0pbS+jsi+n6lLNX3AwIGgDrKxfeNNHiw5ddD7kVvierO0E9J8NR3lUAR/36HD6WvztXSgbYVlfS322sqDjr4SBAE05vaCfcLBFY/wpNDV9hPH8qrdaPirbRvgwwJrDFT/cs1kIcVssia74GoOfvhqt+cI0UhcL9CKQ8BznnuAvztF3eSYOc/mEZITxWsZAZ8sqC+WGqjTnVE+ZETlzd4Ja8bluaf6zHckzD/h5Ydul2SJQzZWuU4S04D9AzlMIDNs3f/pEgOeLcx4FkzpHeFwvt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G94KorH8gEVtRxcRHMTzZXU6AAVxW44H3txPwdldbQ8=;
 b=I/cyeDrp7bbVRJjl1pUDFI3XluNu0qaOiBmX3LZFCk+NBFAKJ1J6t9Va6XfRE9HlmdO5rZpD8Fl9/WbtEcJGSOsIa0O/yLYCeSFTGPSBZuwSH/hiogCJF6tHoSJsh2r2rpM+gIOHCxPq6JQOxKWQK86v7EDDDJbuQy0pKwkFpmags8mFOAlIRFnXBdbdViyJf+y7TUOtX0KdzfhKQPmXdCBuirGyA1wQWRMW0GqQ7tGRUzAzsmkc/AQbETQdlPWIKC2lKSmSn9PXJV70iI0aOXvKjWvK1auzw0Q9uHgG6bkimEvbNsBRM++GjLhXgAuAbwaJaeDtfbUj8aKoXmyIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G94KorH8gEVtRxcRHMTzZXU6AAVxW44H3txPwdldbQ8=;
 b=C+1x8AaxxjPGUOFQxt35ANDJu4FMkMuav+V3j7zIrFsTtcZR6mzk01qOg+4JuUxy3jM9cbIh+8KYagwvma3bP2SqMspODApstyvaiWI/rFrG6OKxLo6DXHbPVrmVRSGXSUNB6/ipTFGUkMjeNx58bh9/fkwDVuV+abkO1+hZF7M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 1 Oct
 2020 18:24:39 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591%4]) with mapi id 15.20.3433.038; Thu, 1 Oct 2020
 18:24:39 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdkfd: Remove duplicated code from trap handler
Date: Thu,  1 Oct 2020 13:24:06 -0500
Message-Id: <20201001182408.3960-2-jay.cornwall@amd.com>
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
 Transport; Thu, 1 Oct 2020 18:24:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 384352d6-88b6-4e63-aba5-08d866374222
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB444626E4D4428A6F8205022687300@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUj/+/Nozu28sUErjtpRgdoPimOMmQlnv04EPFacOFk8U+le4IhmvXz5uvBmoIqUs7LtrPD/ZEjoelX6Ag+DBl5PnLDAMcZsd/ajqIU81M+57xVhLjfX/WRyb74apmJ7r43z48eOAGiAlI9HnXFBBKSDJCNbeBpXQkKcwZ0YYOMuRn1xKuJ5Pk8Xcznfx0BeISwZLh91KekpPbdLUFrAb/DiVuwXr6M1rqpw5GLNznJTP+0XzksJ2okVFGBjCpP1MOJkzkCG9e7vSD99q8WyTOyrVLOJqf/B8mzIILJ6KU9/pHYVAU7m9SifFgp/A5mC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66556008)(16526019)(1076003)(66476007)(186003)(36756003)(4326008)(66946007)(26005)(5660300002)(2616005)(8676002)(86362001)(6916009)(6666004)(83380400001)(52116002)(7696005)(8936002)(2906002)(44832011)(6486002)(478600001)(956004)(54906003)(316002)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SguEcGyvhg+nduDVZYTioONN9eJ5chV5qeO6e+YOl/+hg/+xY6RKUW9T7QHHxFId0VxsLLsVGAVkvB5AaNCxkTPCza/vU8I2HCZAGQOAfYNFu+yUjkDv4nFrmNq/1Dxbj4+YAmBPCgWZeWJxu+t4bMh7xTHsmXGXI5MYnzVNkMs4IFYA6cP6mlxu3TS2wMIAfTotqQzerRzUlVbCPQFt7RGoyAXPraVHeggT/69zw7wSwTcYgvz4X3vRKZjTsFrFiRf32XRk6X4NUdbgbWhT5sN3LyDpVZfEoQRTH3K1oYiIQVwk4NhyupF7Hz50uCrotzVnwwSr7ksPWs0dj99iHp1wWkcu/oUcaLgVXh/rueA94iFlqHb8bEnWfZdFCyIXW6h3Mu6bI/z9vYFEln3gqzfLHHtqzEvuoUcAm5B1FexaNu66U2+U3H1/2o0k7DLDkYf1iaGCIUCG2QkWf/CwF3Rci4sQpvO5ofig7+VYtssrIlC2rwJBo/ZYMepps6Xjzm0zOWTTbmU7xc0tW8BVf0WXH6OekPMjRkdm/BxrGdgQ0jY5pkBG3ES5pLs2wNORpn6+fSXm47z6iMEznrikh575xUNClcAee8BHmOAREfxw9Knl2J0HhXqmlh6f0iUO9ebbiyZsB55wyR/N+LJKyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384352d6-88b6-4e63-aba5-08d866374222
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:24:39.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8V67Lhy0PqcuYYhwSuoMfovo1QN4zWv4/1+3KfjDw6zkEd5N9HwVESpuIKlhOes+zKDqy8yPZnJh4gW9yTqQA==
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

IB_STS bits are saved/restored in both PC and ttmp11 along different
code paths. Use ttmp11 on both paths to remove redundant code.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 764 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  94 +--
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm |  66 +-
 3 files changed, 424 insertions(+), 500 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index aa2de525b2e0..9f435c777ba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -274,14 +274,14 @@ static const uint32_t cwsr_trap_gfx8_hex[] = {
 
 
 static const uint32_t cwsr_trap_gfx9_hex[] = {
-	0xbf820001, 0xbf820240,
+	0xbf820001, 0xbf82023e,
 	0xb8f8f802, 0x89788678,
 	0xb8eef801, 0x866eff6e,
 	0x00000800, 0xbf840003,
 	0x866eff78, 0x00002000,
 	0xbf840016, 0xb8fbf803,
 	0x866eff7b, 0x00000400,
-	0xbf85003b, 0x866eff7b,
+	0xbf85003a, 0x866eff7b,
 	0x00000800, 0xbf850003,
 	0x866eff7b, 0x00000100,
 	0xbf84000c, 0x866eff78,
@@ -290,34 +290,33 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x866eff6e, 0x00000400,
 	0xbf84fffb, 0x8778ff78,
 	0x00002000, 0x80ec886c,
-	0x82ed806d, 0xb8eef807,
-	0x866fff6e, 0x001f8000,
-	0x8e6f8b6f, 0x8977ff77,
-	0xfc000000, 0x87776f77,
-	0x896eff6e, 0x001f8000,
-	0xb96ef807, 0xb8faf812,
-	0xb8fbf813, 0x8efa887a,
-	0xc0071bbd, 0x00000000,
-	0xbf8cc07f, 0xc0071ebd,
-	0x00000008, 0xbf8cc07f,
-	0x86ee6e6e, 0xbf840001,
-	0xbe801d6e, 0xb8fbf803,
-	0x867bff7b, 0x000001ff,
-	0xbf850002, 0x806c846c,
-	0x826d806d, 0x866dff6d,
-	0x0000ffff, 0x8f6e8b77,
-	0x866eff6e, 0x001f8000,
-	0xb96ef807, 0x86fe7e7e,
-	0x86ea6a6a, 0x8f6e8378,
-	0xb96ee0c2, 0xbf800002,
-	0xb9780002, 0xbe801f6c,
+	0x82ed806d, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8977ff77,
+	0xfc000000, 0x87777a77,
+	0xba7ff807, 0x00000000,
+	0xb8faf812, 0xb8fbf813,
+	0x8efa887a, 0xc0071bbd,
+	0x00000000, 0xbf8cc07f,
+	0xc0071ebd, 0x00000008,
+	0xbf8cc07f, 0x86ee6e6e,
+	0xbf840001, 0xbe801d6e,
+	0xb8fbf803, 0x867bff7b,
+	0x000001ff, 0xbf850002,
+	0x806c846c, 0x826d806d,
 	0x866dff6d, 0x0000ffff,
-	0xbefa0080, 0xb97a0283,
-	0xb8fa2407, 0x8e7a9b7a,
-	0x876d7a6d, 0xb8fa03c7,
-	0x8e7a9a7a, 0x876d7a6d,
-	0xb8faf807, 0x867aff7a,
-	0x00007fff, 0xb97af807,
+	0x8f7a8b77, 0x867aff7a,
+	0x001f8000, 0xb97af807,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e8378, 0xb96ee0c2,
+	0xbf800002, 0xb9780002,
+	0xbe801f6c, 0x866dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8977ff77,
+	0xfc000000, 0x87777a77,
+	0xba7ff807, 0x00000000,
 	0xbeee007e, 0xbeef007f,
 	0xbefe0180, 0xbf900004,
 	0x877a8478, 0xb97af802,
@@ -562,7 +561,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0x701d0300, 0x807c847c,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffef,
-	0xbf9c0000, 0xbf8200cf,
+	0xbf9c0000, 0xbf8200c7,
 	0xbef4007e, 0x8675ff7f,
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
@@ -655,12 +654,8 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 	0xc00b1c37, 0x00000050,
 	0xc00b1d37, 0x00000060,
 	0xc0031e77, 0x00000074,
-	0xbf8cc07f, 0x866fff6d,
-	0xf8000000, 0x8f6f9b6f,
-	0x8e6f906f, 0xbeee0080,
-	0x876e6f6e, 0x866fff6d,
-	0x04000000, 0x8f6f9a6f,
-	0x8e6f8f6f, 0x876e6f6e,
+	0xbf8cc07f, 0x8f6e8b77,
+	0x866eff6e, 0x001f8000,
 	0xb96ef807, 0x866dff6d,
 	0x0000ffff, 0x86fe7e7e,
 	0x86ea6a6a, 0x8f6e837a,
@@ -670,7 +665,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
 };
 
 static const uint32_t cwsr_trap_nv1x_hex[] = {
-	0xbf820001, 0xbf8201c5,
+	0xbf820001, 0xbf8201c6,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -681,13 +676,13 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x876eff7b, 0x00000100,
 	0xbf840002, 0x8878ff78,
 	0x00002000, 0x8a77ff77,
-	0xff000000, 0xb96ef807,
-	0x876fff6e, 0x02000000,
-	0x8f6f866f, 0x88776f77,
-	0x876fff6e, 0x003f8000,
-	0x8f6f896f, 0x88776f77,
-	0x8a6eff6e, 0x023f8000,
-	0xb9eef807, 0xb97af812,
+	0xff000000, 0xb97af807,
+	0x877bff7a, 0x02000000,
+	0x8f7b867b, 0x88777b77,
+	0x877bff7a, 0x003f8000,
+	0x8f7b897b, 0x88777b77,
+	0x8a7aff7a, 0x023f8000,
+	0xb9faf807, 0xb97af812,
 	0xb97bf813, 0x8ffa887a,
 	0xf4051bbd, 0xfa000000,
 	0xbf8cc07f, 0xf4051ebd,
@@ -697,366 +692,362 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 	0x877bff7b, 0x000001ff,
 	0xbf850002, 0x806c846c,
 	0x826d806d, 0x876dff6d,
-	0x0000ffff, 0x906e8977,
-	0x876fff6e, 0x003f8000,
-	0x906e8677, 0x876eff6e,
-	0x02000000, 0x886e6f6e,
-	0xb9eef807, 0x87fe7e7e,
+	0x0000ffff, 0x907a8977,
+	0x877bff7a, 0x003f8000,
+	0x907a8677, 0x877aff7a,
+	0x02000000, 0x887a7b7a,
+	0xb9faf807, 0x87fe7e7e,
 	0x87ea6a6a, 0xb9f8f802,
 	0xbe80226c, 0x876dff6d,
 	0x0000ffff, 0xbefa0380,
-	0xb9fa0283, 0xb97a2c07,
-	0x8f7a9a7a, 0x886d7a6d,
-	0xb97a03c7, 0x8f7a997a,
-	0x886d7a6d, 0xb97a0647,
-	0x8f7a987a, 0x886d7a6d,
-	0xb97af807, 0x877aff7a,
-	0x00007fff, 0xb9faf807,
-	0xbeee037e, 0xbeef037f,
-	0xbefe0480, 0xbf900004,
-	0xbf8e0002, 0xbf88fffe,
-	0xb97b02dc, 0x8f7b997b,
-	0x887b7b7f, 0xb97a2a05,
-	0x807a817a, 0xbf0d997b,
-	0xbf850002, 0x8f7a897a,
-	0xbf820001, 0x8f7a8a7a,
-	0x877bff7f, 0x0000ffff,
-	0x807aff7a, 0x00000200,
-	0x807a7e7a, 0x827b807b,
-	0xf4491c3d, 0xfa000050,
-	0xf4491d3d, 0xfa000060,
-	0xf4411e7d, 0xfa000074,
-	0xbef4037e, 0x8775ff7f,
-	0x0000ffff, 0x8875ff75,
-	0x00040000, 0xbef60380,
-	0xbef703ff, 0x10807fac,
-	0xbef1037c, 0xbef00380,
-	0xb97302dc, 0x8f739973,
-	0x8873737f, 0xb97bf816,
-	0xba80f816, 0x00000000,
-	0xbefe03c1, 0x907c9973,
-	0x877c817c, 0xbf06817c,
-	0xbf850002, 0xbeff0380,
-	0xbf820002, 0xbeff03c1,
-	0xbf82000b, 0xbef603ff,
-	0x01000000, 0xe0704000,
-	0x705d0000, 0xe0704080,
-	0x705d0100, 0xe0704100,
-	0x705d0200, 0xe0704180,
-	0x705d0300, 0xbf82000a,
+	0xb9fa0283, 0x8a77ff77,
+	0xff000000, 0xb97af807,
+	0x877bff7a, 0x02000000,
+	0x8f7b867b, 0x88777b77,
+	0x877bff7a, 0x003f8000,
+	0x8f7b897b, 0x88777b77,
+	0x8a7aff7a, 0x023f8000,
+	0xb9faf807, 0xbeee037e,
+	0xbeef037f, 0xbefe0480,
+	0xbf900004, 0xbf8e0002,
+	0xbf88fffe, 0xb97b02dc,
+	0x8f7b997b, 0x887b7b7f,
+	0xb97a2a05, 0x807a817a,
+	0xbf0d997b, 0xbf850002,
+	0x8f7a897a, 0xbf820001,
+	0x8f7a8a7a, 0x877bff7f,
+	0x0000ffff, 0x807aff7a,
+	0x00000200, 0x807a7e7a,
+	0x827b807b, 0xf4491c3d,
+	0xfa000050, 0xf4491d3d,
+	0xfa000060, 0xf4411e7d,
+	0xfa000074, 0xbef4037e,
+	0x8775ff7f, 0x0000ffff,
+	0x8875ff75, 0x00040000,
+	0xbef60380, 0xbef703ff,
+	0x10807fac, 0xbef1037c,
+	0xbef00380, 0xb97302dc,
+	0x8f739973, 0x8873737f,
+	0xb97bf816, 0xba80f816,
+	0x00000000, 0xbefe03c1,
+	0x907c9973, 0x877c817c,
+	0xbf06817c, 0xbf850002,
+	0xbeff0380, 0xbf820002,
+	0xbeff03c1, 0xbf82000b,
 	0xbef603ff, 0x01000000,
 	0xe0704000, 0x705d0000,
-	0xe0704100, 0x705d0100,
-	0xe0704200, 0x705d0200,
-	0xe0704300, 0x705d0300,
-	0xb9702a05, 0x80708170,
-	0xbf0d9973, 0xbf850002,
-	0x8f708970, 0xbf820001,
-	0x8f708a70, 0xb97a1e06,
-	0x8f7a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
-	0xbef603ff, 0x01000000,
-	0xbefe037c, 0xbefc0370,
-	0xf4611c7a, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xbefe037c, 0xbefc0370,
-	0xf4611b3a, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xbefe037c, 0xbefc0370,
-	0xf4611b7a, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xbefe037c, 0xbefc0370,
-	0xf4611bba, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xbefe037c, 0xbefc0370,
-	0xf4611bfa, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xbefe037c, 0xbefc0370,
-	0xf4611e3a, 0xf8000000,
-	0x80708470, 0xbefc037e,
-	0xb97af803, 0xbefe037c,
-	0xbefc0370, 0xf4611eba,
+	0xe0704080, 0x705d0100,
+	0xe0704100, 0x705d0200,
+	0xe0704180, 0x705d0300,
+	0xbf82000a, 0xbef603ff,
+	0x01000000, 0xe0704000,
+	0x705d0000, 0xe0704100,
+	0x705d0100, 0xe0704200,
+	0x705d0200, 0xe0704300,
+	0x705d0300, 0xb9702a05,
+	0x80708170, 0xbf0d9973,
+	0xbf850002, 0x8f708970,
+	0xbf820001, 0x8f708a70,
+	0xb97a1e06, 0x8f7a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0xbef603ff,
+	0x01000000, 0xbefe037c,
+	0xbefc0370, 0xf4611c7a,
+	0xf8000000, 0x80708470,
+	0xbefc037e, 0xbefe037c,
+	0xbefc0370, 0xf4611b3a,
+	0xf8000000, 0x80708470,
+	0xbefc037e, 0xbefe037c,
+	0xbefc0370, 0xf4611b7a,
 	0xf8000000, 0x80708470,
 	0xbefc037e, 0xbefe037c,
-	0xbefc0370, 0xf4611efa,
+	0xbefc0370, 0xf4611bba,
 	0xf8000000, 0x80708470,
-	0xbefc037e, 0xb971f801,
+	0xbefc037e, 0xbefe037c,
+	0xbefc0370, 0xf4611bfa,
+	0xf8000000, 0x80708470,
+	0xbefc037e, 0xbefe037c,
+	0xbefc0370, 0xf4611e3a,
+	0xf8000000, 0x80708470,
+	0xbefc037e, 0xb97af803,
 	0xbefe037c, 0xbefc0370,
-	0xf4611c7a, 0xf8000000,
+	0xf4611eba, 0xf8000000,
+	0x80708470, 0xbefc037e,
+	0xbefe037c, 0xbefc0370,
+	0xf4611efa, 0xf8000000,
 	0x80708470, 0xbefc037e,
-	0xb971f814, 0xbefe037c,
+	0xb971f801, 0xbefe037c,
 	0xbefc0370, 0xf4611c7a,
 	0xf8000000, 0x80708470,
-	0xbefc037e, 0xb971f815,
+	0xbefc037e, 0xb971f814,
 	0xbefe037c, 0xbefc0370,
 	0xf4611c7a, 0xf8000000,
 	0x80708470, 0xbefc037e,
-	0xb9702a05, 0x80708170,
-	0xbf0d9973, 0xbf850002,
-	0x8f708970, 0xbf820001,
-	0x8f708a70, 0xb97a1e06,
-	0x8f7a8a7a, 0x80707a70,
-	0xbef603ff, 0x01000000,
-	0xbefb0374, 0x80747074,
-	0x82758075, 0xbefc0380,
-	0xbf800000, 0xbe802f00,
-	0xbe822f02, 0xbe842f04,
-	0xbe862f06, 0xbe882f08,
-	0xbe8a2f0a, 0xbe8c2f0c,
-	0xbe8e2f0e, 0xf469003a,
-	0xfa000000, 0xf469013a,
-	0xfa000010, 0xf469023a,
-	0xfa000020, 0xf469033a,
-	0xfa000030, 0x8074c074,
-	0x82758075, 0x807c907c,
-	0xbf0aff7c, 0x00000060,
-	0xbf85ffea, 0xbe802f00,
-	0xbe822f02, 0xbe842f04,
-	0xbe862f06, 0xbe882f08,
-	0xbe8a2f0a, 0xf469003a,
-	0xfa000000, 0xf469013a,
-	0xfa000010, 0xf469023a,
-	0xfa000020, 0x8074b074,
-	0x82758075, 0xbef4037b,
+	0xb971f815, 0xbefe037c,
+	0xbefc0370, 0xf4611c7a,
+	0xf8000000, 0x80708470,
+	0xbefc037e, 0xb9702a05,
+	0x80708170, 0xbf0d9973,
+	0xbf850002, 0x8f708970,
+	0xbf820001, 0x8f708a70,
+	0xb97a1e06, 0x8f7a8a7a,
+	0x80707a70, 0xbef603ff,
+	0x01000000, 0xbefb0374,
+	0x80747074, 0x82758075,
+	0xbefc0380, 0xbf800000,
+	0xbe802f00, 0xbe822f02,
+	0xbe842f04, 0xbe862f06,
+	0xbe882f08, 0xbe8a2f0a,
+	0xbe8c2f0c, 0xbe8e2f0e,
+	0xf469003a, 0xfa000000,
+	0xf469013a, 0xfa000010,
+	0xf469023a, 0xfa000020,
+	0xf469033a, 0xfa000030,
+	0x8074c074, 0x82758075,
+	0x807c907c, 0xbf0aff7c,
+	0x00000060, 0xbf85ffea,
+	0xbe802f00, 0xbe822f02,
+	0xbe842f04, 0xbe862f06,
+	0xbe882f08, 0xbe8a2f0a,
+	0xf469003a, 0xfa000000,
+	0xf469013a, 0xfa000010,
+	0xf469023a, 0xfa000020,
+	0x8074b074, 0x82758075,
+	0xbef4037b, 0xbefe03c1,
+	0x907c9973, 0x877c817c,
+	0xbf06817c, 0xbf850002,
+	0xbeff0380, 0xbf820001,
+	0xbeff03c1, 0xb97b4306,
+	0x877bc17b, 0xbf840044,
+	0xbf8a0000, 0x877aff73,
+	0x04000000, 0xbf840040,
+	0x8f7b867b, 0x8f7b827b,
+	0xbef6037b, 0xb9702a05,
+	0x80708170, 0xbf0d9973,
+	0xbf850002, 0x8f708970,
+	0xbf820001, 0x8f708a70,
+	0xb97a1e06, 0x8f7a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0x8070ff70,
+	0x00000080, 0xbef603ff,
+	0x01000000, 0xd7650000,
+	0x000100c1, 0xd7660000,
+	0x000200c1, 0x16000084,
+	0x907c9973, 0x877c817c,
+	0xbf06817c, 0xbefc0380,
+	0xbf850012, 0xbe8303ff,
+	0x00000080, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8c0000, 0xe0704000,
+	0x705d0100, 0x807c037c,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0xbf0a7b7c, 0xbf85fff4,
+	0xbf820011, 0xbe8303ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8c0000, 0xe0704000,
+	0x705d0100, 0x807c037c,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000100,
+	0xbf0a7b7c, 0xbf85fff4,
 	0xbefe03c1, 0x907c9973,
 	0x877c817c, 0xbf06817c,
-	0xbf850002, 0xbeff0380,
-	0xbf820001, 0xbeff03c1,
-	0xb97b4306, 0x877bc17b,
-	0xbf840044, 0xbf8a0000,
-	0x877aff73, 0x04000000,
-	0xbf840040, 0x8f7b867b,
-	0x8f7b827b, 0xbef6037b,
-	0xb9702a05, 0x80708170,
-	0xbf0d9973, 0xbf850002,
-	0x8f708970, 0xbf820001,
-	0x8f708a70, 0xb97a1e06,
-	0x8f7a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
-	0x8070ff70, 0x00000080,
-	0xbef603ff, 0x01000000,
-	0xd7650000, 0x000100c1,
-	0xd7660000, 0x000200c1,
-	0x16000084, 0x907c9973,
+	0xbf850004, 0xbef003ff,
+	0x00000200, 0xbeff0380,
+	0xbf820003, 0xbef003ff,
+	0x00000400, 0xbeff03c1,
+	0xb97b2a05, 0x807b817b,
+	0x8f7b827b, 0x907c9973,
 	0x877c817c, 0xbf06817c,
-	0xbefc0380, 0xbf850012,
-	0xbe8303ff, 0x00000080,
-	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
-	0x01000000, 0xbf8c0000,
-	0xe0704000, 0x705d0100,
-	0x807c037c, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000080, 0xbf0a7b7c,
-	0xbf85fff4, 0xbf820011,
-	0xbe8303ff, 0x00000100,
-	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
-	0x01000000, 0xbf8c0000,
-	0xe0704000, 0x705d0100,
-	0x807c037c, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000100, 0xbf0a7b7c,
-	0xbf85fff4, 0xbefe03c1,
-	0x907c9973, 0x877c817c,
-	0xbf06817c, 0xbf850004,
-	0xbef003ff, 0x00000200,
-	0xbeff0380, 0xbf820003,
-	0xbef003ff, 0x00000400,
-	0xbeff03c1, 0xb97b2a05,
-	0x807b817b, 0x8f7b827b,
-	0x907c9973, 0x877c817c,
-	0xbf06817c, 0xbf850017,
+	0xbf850017, 0xbef603ff,
+	0x01000000, 0xbefc0384,
+	0xbf0a7b7c, 0xbf840037,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0xe0704000, 0x705d0000,
+	0xe0704080, 0x705d0100,
+	0xe0704100, 0x705d0200,
+	0xe0704180, 0x705d0300,
+	0x807c847c, 0x8070ff70,
+	0x00000200, 0xbf0a7b7c,
+	0xbf85ffef, 0xbf820025,
 	0xbef603ff, 0x01000000,
 	0xbefc0384, 0xbf0a7b7c,
-	0xbf840037, 0x7e008700,
+	0xbf840020, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xe0704000,
-	0x705d0000, 0xe0704080,
-	0x705d0100, 0xe0704100,
-	0x705d0200, 0xe0704180,
+	0x705d0000, 0xe0704100,
+	0x705d0100, 0xe0704200,
+	0x705d0200, 0xe0704300,
 	0x705d0300, 0x807c847c,
-	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffef,
-	0xbf820025, 0xbef603ff,
-	0x01000000, 0xbefc0384,
-	0xbf0a7b7c, 0xbf840020,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
+	0xb97b1e06, 0x877bc17b,
+	0xbf84000c, 0x8f7b837b,
+	0x807b7c7b, 0xbefe03c1,
+	0xbeff0380, 0x7e008700,
 	0xe0704000, 0x705d0000,
-	0xe0704100, 0x705d0100,
-	0xe0704200, 0x705d0200,
-	0xe0704300, 0x705d0300,
-	0x807c847c, 0x8070ff70,
-	0x00000400, 0xbf0a7b7c,
-	0xbf85ffef, 0xb97b1e06,
-	0x877bc17b, 0xbf84000c,
-	0x8f7b837b, 0x807b7c7b,
-	0xbefe03c1, 0xbeff0380,
-	0x7e008700, 0xe0704000,
-	0x705d0000, 0x807c817c,
-	0x8070ff70, 0x00000080,
-	0xbf0a7b7c, 0xbf85fff8,
-	0xbf820146, 0xbef4037e,
-	0x8775ff7f, 0x0000ffff,
-	0x8875ff75, 0x00040000,
-	0xbef60380, 0xbef703ff,
-	0x10807fac, 0xb97202dc,
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
+	0x807c817c, 0x8070ff70,
+	0x00000080, 0xbf0a7b7c,
+	0xbf85fff8, 0xbf82013d,
+	0xbef4037e, 0x8775ff7f,
+	0x0000ffff, 0x8875ff75,
+	0x00040000, 0xbef60380,
+	0xbef703ff, 0x10807fac,
+	0xb97202dc, 0x8f729972,
+	0x8872727f, 0x876eff7f,
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
-	0xb9f9f816, 0x876f7bff,
-	0xfffff800, 0x906f8b6f,
-	0xb9efa2c3, 0xb9f3f801,
-	0xb96e2a05, 0x806e816e,
-	0xbf0d9972, 0xbf850002,
-	0x8f6e896e, 0xbf820001,
-	0x8f6e8a6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x876fff6f,
-	0x0000ffff, 0xf4091c37,
-	0xfa000050, 0xf4091d37,
-	0xfa000060, 0xf4011e77,
-	0xfa000074, 0xbf8cc07f,
-	0x876fff6d, 0xfc000000,
-	0x906f9a6f, 0x8f6f906f,
-	0xbeee0380, 0x886e6f6e,
-	0x876fff6d, 0x02000000,
-	0x906f996f, 0x8f6f8f6f,
-	0x886e6f6e, 0x876fff6d,
-	0x01000000, 0x906f986f,
-	0x8f6f996f, 0x886e6f6e,
+	0xb9eef815, 0xbefc036f,
+	0xbefe0370, 0xbeff0371,
+	0x876f7bff, 0x000003ff,
+	0xb9ef4803, 0xb9f9f816,
+	0x876f7bff, 0xfffff800,
+	0x906f8b6f, 0xb9efa2c3,
+	0xb9f3f801, 0xb96e2a05,
+	0x806e816e, 0xbf0d9972,
+	0xbf850002, 0x8f6e896e,
+	0xbf820001, 0x8f6e8a6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x876fff6f, 0x0000ffff,
+	0xf4091c37, 0xfa000050,
+	0xf4091d37, 0xfa000060,
+	0xf4011e77, 0xfa000074,
+	0xbf8cc07f, 0x906e8977,
+	0x876fff6e, 0x003f8000,
+	0x906e8677, 0x876eff6e,
+	0x02000000, 0x886e6f6e,
 	0xb9eef807, 0x876dff6d,
 	0x0000ffff, 0x87fe7e7e,
 	0x87ea6a6a, 0xb9faf802,
@@ -1067,14 +1058,14 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
 };
 
 static const uint32_t cwsr_trap_arcturus_hex[] = {
-	0xbf820001, 0xbf8202bc,
+	0xbf820001, 0xbf8202ba,
 	0xb8f8f802, 0x89788678,
 	0xb8eef801, 0x866eff6e,
 	0x00000800, 0xbf840003,
 	0x866eff78, 0x00002000,
 	0xbf840016, 0xb8fbf803,
 	0x866eff7b, 0x00000400,
-	0xbf85003b, 0x866eff7b,
+	0xbf85003a, 0x866eff7b,
 	0x00000800, 0xbf850003,
 	0x866eff7b, 0x00000100,
 	0xbf84000c, 0x866eff78,
@@ -1083,34 +1074,33 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x866eff6e, 0x00000400,
 	0xbf84fffb, 0x8778ff78,
 	0x00002000, 0x80ec886c,
-	0x82ed806d, 0xb8eef807,
-	0x866fff6e, 0x001f8000,
-	0x8e6f8b6f, 0x8977ff77,
-	0xfc000000, 0x87776f77,
-	0x896eff6e, 0x001f8000,
-	0xb96ef807, 0xb8faf812,
-	0xb8fbf813, 0x8efa887a,
-	0xc0071bbd, 0x00000000,
-	0xbf8cc07f, 0xc0071ebd,
-	0x00000008, 0xbf8cc07f,
-	0x86ee6e6e, 0xbf840001,
-	0xbe801d6e, 0xb8fbf803,
-	0x867bff7b, 0x000001ff,
-	0xbf850002, 0x806c846c,
-	0x826d806d, 0x866dff6d,
-	0x0000ffff, 0x8f6e8b77,
-	0x866eff6e, 0x001f8000,
-	0xb96ef807, 0x86fe7e7e,
-	0x86ea6a6a, 0x8f6e8378,
-	0xb96ee0c2, 0xbf800002,
-	0xb9780002, 0xbe801f6c,
+	0x82ed806d, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8977ff77,
+	0xfc000000, 0x87777a77,
+	0xba7ff807, 0x00000000,
+	0xb8faf812, 0xb8fbf813,
+	0x8efa887a, 0xc0071bbd,
+	0x00000000, 0xbf8cc07f,
+	0xc0071ebd, 0x00000008,
+	0xbf8cc07f, 0x86ee6e6e,
+	0xbf840001, 0xbe801d6e,
+	0xb8fbf803, 0x867bff7b,
+	0x000001ff, 0xbf850002,
+	0x806c846c, 0x826d806d,
 	0x866dff6d, 0x0000ffff,
-	0xbefa0080, 0xb97a0283,
-	0xb8fa2407, 0x8e7a9b7a,
-	0x876d7a6d, 0xb8fa03c7,
-	0x8e7a9a7a, 0x876d7a6d,
-	0xb8faf807, 0x867aff7a,
-	0x00007fff, 0xb97af807,
+	0x8f7a8b77, 0x867aff7a,
+	0x001f8000, 0xb97af807,
+	0x86fe7e7e, 0x86ea6a6a,
+	0x8f6e8378, 0xb96ee0c2,
+	0xbf800002, 0xb9780002,
+	0xbe801f6c, 0x866dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xb8faf807,
+	0x867aff7a, 0x001f8000,
+	0x8e7a8b7a, 0x8977ff77,
+	0xfc000000, 0x87777a77,
+	0xba7ff807, 0x00000000,
 	0xbeee007e, 0xbeef007f,
 	0xbefe0180, 0xbf900004,
 	0x877a8478, 0xb97af802,
@@ -1417,7 +1407,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0x701d0300, 0x807c847c,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7c, 0xbf85ffeb,
-	0xbf9c0000, 0xbf8200fb,
+	0xbf9c0000, 0xbf8200f3,
 	0xbef4007e, 0x8675ff7f,
 	0x0000ffff, 0x8775ff75,
 	0x00040000, 0xbef60080,
@@ -1532,12 +1522,8 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 	0xc00b1c37, 0x00000050,
 	0xc00b1d37, 0x00000060,
 	0xc0031e77, 0x00000074,
-	0xbf8cc07f, 0x866fff6d,
-	0xf8000000, 0x8f6f9b6f,
-	0x8e6f906f, 0xbeee0080,
-	0x876e6f6e, 0x866fff6d,
-	0x04000000, 0x8f6f9a6f,
-	0x8e6f8f6f, 0x876e6f6e,
+	0xbf8cc07f, 0x8f6e8b77,
+	0x866eff6e, 0x001f8000,
 	0xb96ef807, 0x866dff6d,
 	0x0000ffff, 0x86fe7e7e,
 	0x86ea6a6a, 0x8f6e837a,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index c3344acdb094..69721aea57b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -62,15 +62,10 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT		= 11
 var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE		= 21
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK		= 0x800
 
-var SQ_WAVE_IB_STS_RCNT_SHIFT			= 16
 var SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT		= 15
 var SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT		= 25
-var SQ_WAVE_IB_STS_REPLAY_W64H_SIZE		= 1
 var SQ_WAVE_IB_STS_REPLAY_W64H_MASK		= 0x02000000
-var SQ_WAVE_IB_STS_FIRST_REPLAY_SIZE		= 1
-var SQ_WAVE_IB_STS_RCNT_SIZE			= 6
 var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x003F8000
-var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG	= 0x00007FFF
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
 
@@ -88,13 +83,6 @@ var S_SAVE_BUF_RSRC_WORD3_MISC			= 0x10807FAC
 var S_SAVE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 
-var S_SAVE_PC_HI_RCNT_SHIFT			= 26
-var S_SAVE_PC_HI_RCNT_MASK			= 0xFC000000
-var S_SAVE_PC_HI_FIRST_REPLAY_SHIFT		= 25
-var S_SAVE_PC_HI_FIRST_REPLAY_MASK		= 0x02000000
-var S_SAVE_PC_HI_REPLAY_W64H_SHIFT		= 24
-var S_SAVE_PC_HI_REPLAY_W64H_MASK		= 0x01000000
-
 var s_sgpr_save_num				= 108
 
 var s_save_spi_init_lo				= exec_lo
@@ -125,11 +113,6 @@ var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_WAVE_SIZE					= 25
 
-var S_RESTORE_PC_HI_RCNT_SHIFT			= S_SAVE_PC_HI_RCNT_SHIFT
-var S_RESTORE_PC_HI_RCNT_MASK			= S_SAVE_PC_HI_RCNT_MASK
-var S_RESTORE_PC_HI_FIRST_REPLAY_SHIFT		= S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-var S_RESTORE_PC_HI_FIRST_REPLAY_MASK		= S_SAVE_PC_HI_FIRST_REPLAY_MASK
-
 var s_restore_spi_init_lo			= exec_lo
 var s_restore_spi_init_hi			= exec_hi
 var s_restore_mem_offset			= ttmp12
@@ -198,19 +181,7 @@ end
 L_FETCH_2ND_TRAP:
 
 #if ASIC_TARGET_NAVI1X
-	// Preserve and clear scalar XNACK state before issuing scalar loads.
-	// Save IB_STS.REPLAY_W64H[25], RCNT[21:16], FIRST_REPLAY[15] into
-	// unused space ttmp11[31:24].
-	s_andn2_b32	ttmp11, ttmp11, (TTMP11_SAVE_REPLAY_W64H_MASK | TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK)
-	s_getreg_b32	ttmp2, hwreg(HW_REG_IB_STS)
-	s_and_b32	ttmp3, ttmp2, SQ_WAVE_IB_STS_REPLAY_W64H_MASK
-	s_lshl_b32	ttmp3, ttmp3, (TTMP11_SAVE_REPLAY_W64H_SHIFT - SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT)
-	s_or_b32	ttmp11, ttmp11, ttmp3
-	s_and_b32	ttmp3, ttmp2, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-	s_lshl_b32	ttmp3, ttmp3, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
-	s_or_b32	ttmp11, ttmp11, ttmp3
-	s_andn2_b32	ttmp2, ttmp2, (SQ_WAVE_IB_STS_REPLAY_W64H_MASK | SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK)
-	s_setreg_b32	hwreg(HW_REG_IB_STS), ttmp2
+	save_and_clear_ib_sts(ttmp14, ttmp15)
 #endif
 
 	// Read second-level TBA/TMA from first-level TMA and jump if available.
@@ -237,13 +208,7 @@ L_EXCP_CASE:
 	s_and_b32	ttmp1, ttmp1, 0xFFFF
 
 #if ASIC_TARGET_NAVI1X
-	// Restore SQ_WAVE_IB_STS.
-	s_lshr_b32	ttmp2, ttmp11, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
-	s_and_b32	ttmp3, ttmp2, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-	s_lshr_b32	ttmp2, ttmp11, (TTMP11_SAVE_REPLAY_W64H_SHIFT - SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT)
-	s_and_b32	ttmp2, ttmp2, SQ_WAVE_IB_STS_REPLAY_W64H_MASK
-	s_or_b32	ttmp2, ttmp2, ttmp3
-	s_setreg_b32	hwreg(HW_REG_IB_STS), ttmp2
+	restore_ib_sts(ttmp14, ttmp15)
 #endif
 
 	// Restore SQ_WAVE_STATUS.
@@ -259,19 +224,7 @@ L_SAVE:
 	s_setreg_b32	hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
 #if ASIC_TARGET_NAVI1X
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_RCNT_SHIFT, SQ_WAVE_IB_STS_RCNT_SIZE)
-	s_lshl_b32	s_save_tmp, s_save_tmp, S_SAVE_PC_HI_RCNT_SHIFT
-	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT, SQ_WAVE_IB_STS_FIRST_REPLAY_SIZE)
-	s_lshl_b32	s_save_tmp, s_save_tmp, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT, SQ_WAVE_IB_STS_REPLAY_W64H_SIZE)
-	s_lshl_b32	s_save_tmp, s_save_tmp, S_SAVE_PC_HI_REPLAY_W64H_SHIFT
-	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
-	s_getreg_b32	s_save_tmp, hwreg(HW_REG_IB_STS)			//clear RCNT and FIRST_REPLAY and REPLAY_W64H in IB_STS
-	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG
-
-	s_setreg_b32	hwreg(HW_REG_IB_STS), s_save_tmp
+	save_and_clear_ib_sts(s_save_tmp, s_save_trapsts)
 #endif
 
 	/* inform SPI the readiness and wait for SPI's go signal */
@@ -933,21 +886,7 @@ L_RESTORE_HWREG:
 	s_waitcnt	lgkmcnt(0)
 
 #if ASIC_TARGET_NAVI1X
-	s_and_b32	s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_RCNT_MASK
-	s_lshr_b32	s_restore_m0, s_restore_m0, S_SAVE_PC_HI_RCNT_SHIFT
-	s_lshl_b32	s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_RCNT_SHIFT
-	s_mov_b32	s_restore_tmp, 0x0
-	s_or_b32	s_restore_tmp, s_restore_tmp, s_restore_m0
-	s_and_b32	s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_FIRST_REPLAY_MASK
-	s_lshr_b32	s_restore_m0, s_restore_m0, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-	s_lshl_b32	s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT
-	s_or_b32	s_restore_tmp, s_restore_tmp, s_restore_m0
-	s_and_b32	s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_REPLAY_W64H_MASK
-	s_lshr_b32	s_restore_m0, s_restore_m0, S_SAVE_PC_HI_REPLAY_W64H_SHIFT
-	s_lshl_b32	s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT
-	s_or_b32	s_restore_tmp, s_restore_tmp, s_restore_m0
-
-	s_setreg_b32 	hwreg(HW_REG_IB_STS), s_restore_tmp
+	restore_ib_sts(s_restore_tmp, s_restore_m0)
 #endif
 
 	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
@@ -1065,3 +1004,28 @@ function get_wave_size(s_reg)
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
 	s_or_b32	s_reg, s_save_spi_init_hi, s_reg			//share with exec_hi, it's at bit25
 end
+
+function save_and_clear_ib_sts(tmp1, tmp2)
+	// Preserve and clear scalar XNACK state before issuing scalar loads.
+	// Save IB_STS.REPLAY_W64H[25], RCNT[21:16], FIRST_REPLAY[15] into
+	// unused space ttmp11[31:24].
+	s_andn2_b32	ttmp11, ttmp11, (TTMP11_SAVE_REPLAY_W64H_MASK | TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK)
+	s_getreg_b32	tmp1, hwreg(HW_REG_IB_STS)
+	s_and_b32	tmp2, tmp1, SQ_WAVE_IB_STS_REPLAY_W64H_MASK
+	s_lshl_b32	tmp2, tmp2, (TTMP11_SAVE_REPLAY_W64H_SHIFT - SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT)
+	s_or_b32	ttmp11, ttmp11, tmp2
+	s_and_b32	tmp2, tmp1, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
+	s_lshl_b32	tmp2, tmp2, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+	s_or_b32	ttmp11, ttmp11, tmp2
+	s_andn2_b32	tmp1, tmp1, (SQ_WAVE_IB_STS_REPLAY_W64H_MASK | SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK)
+	s_setreg_b32	hwreg(HW_REG_IB_STS), tmp1
+end
+
+function restore_ib_sts(tmp1, tmp2)
+	s_lshr_b32	tmp1, ttmp11, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+	s_and_b32	tmp2, tmp1, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
+	s_lshr_b32	tmp1, ttmp11, (TTMP11_SAVE_REPLAY_W64H_SHIFT - SQ_WAVE_IB_STS_REPLAY_W64H_SHIFT)
+	s_and_b32	tmp1, tmp1, SQ_WAVE_IB_STS_REPLAY_W64H_MASK
+	s_or_b32	tmp1, tmp1, tmp2
+	s_setreg_b32	hwreg(HW_REG_IB_STS), tmp1
+end
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
index 0008eb7d1ef4..2f54c2ca06b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
@@ -61,10 +61,8 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE	=   21
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK	=   0x800
 var SQ_WAVE_TRAPSTS_XNACK_ERROR_MASK	=   0x10000000
 
-var SQ_WAVE_IB_STS_RCNT_SHIFT		=   16			//FIXME
 var SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT	=   15			//FIXME
 var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x1F8000
-var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG	= 0x00007FFF	//FIXME
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK		=   0x800
 
@@ -78,11 +76,6 @@ var S_SAVE_BUF_RSRC_WORD3_MISC		=   0x00807FAC		//SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT
 var S_SAVE_SPI_INIT_FIRST_WAVE_MASK	=   0x04000000		//bit[26]: FirstWaveInTG
 var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT	=   26
 
-var S_SAVE_PC_HI_RCNT_SHIFT		=   27			//FIXME	 check with Brian to ensure all fields other than PC[47:0] can be used
-var S_SAVE_PC_HI_RCNT_MASK		=   0xF8000000		//FIXME
-var S_SAVE_PC_HI_FIRST_REPLAY_SHIFT	=   26			//FIXME
-var S_SAVE_PC_HI_FIRST_REPLAY_MASK	=   0x04000000		//FIXME
-
 var s_save_spi_init_lo		    =	exec_lo
 var s_save_spi_init_hi		    =	exec_hi
 
@@ -112,11 +105,6 @@ var S_RESTORE_BUF_RSRC_WORD3_MISC	    =	S_SAVE_BUF_RSRC_WORD3_MISC
 var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK	    =	0x04000000	    //bit[26]: FirstWaveInTG
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT	    =	26
 
-var S_RESTORE_PC_HI_RCNT_SHIFT		    =	S_SAVE_PC_HI_RCNT_SHIFT
-var S_RESTORE_PC_HI_RCNT_MASK		    =	S_SAVE_PC_HI_RCNT_MASK
-var S_RESTORE_PC_HI_FIRST_REPLAY_SHIFT	    =	S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-var S_RESTORE_PC_HI_FIRST_REPLAY_MASK	    =	S_SAVE_PC_HI_FIRST_REPLAY_MASK
-
 var s_restore_spi_init_lo		    =	exec_lo
 var s_restore_spi_init_hi		    =	exec_hi
 
@@ -220,15 +208,7 @@ L_NOT_ALREADY_HALTED:
 
 L_FETCH_2ND_TRAP:
     // Preserve and clear scalar XNACK state before issuing scalar reads.
-    // Save IB_STS.FIRST_REPLAY[15] and IB_STS.RCNT[20:16] into unused space ttmp11[31:26].
-    s_getreg_b32    ttmp2, hwreg(HW_REG_IB_STS)
-    s_and_b32       ttmp3, ttmp2, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-    s_lshl_b32      ttmp3, ttmp3, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
-    s_andn2_b32     ttmp11, ttmp11, TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK
-    s_or_b32        ttmp11, ttmp11, ttmp3
-
-    s_andn2_b32     ttmp2, ttmp2, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-    s_setreg_b32    hwreg(HW_REG_IB_STS), ttmp2
+    save_and_clear_ib_sts(ttmp14)
 
     // Read second-level TBA/TMA from first-level TMA and jump if available.
     // ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
@@ -253,10 +233,7 @@ L_NO_NEXT_TRAP:
 L_EXCP_CASE:
     s_and_b32	ttmp1, ttmp1, 0xFFFF
 
-    // Restore SQ_WAVE_IB_STS.
-    s_lshr_b32      ttmp2, ttmp11, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
-    s_and_b32       ttmp2, ttmp2, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
-    s_setreg_b32    hwreg(HW_REG_IB_STS), ttmp2
+    restore_ib_sts(ttmp14)
 
     // Restore SQ_WAVE_STATUS.
     s_and_b64       exec, exec, exec // Restore STATUS.EXECZ, not writable by s_setreg_b32
@@ -277,16 +254,7 @@ L_SAVE:
     s_mov_b32	    s_save_tmp, 0							    //clear saveCtx bit
     s_setreg_b32    hwreg(HW_REG_TRAPSTS, SQ_WAVE_TRAPSTS_SAVECTX_SHIFT, 1), s_save_tmp	    //clear saveCtx bit
 
-    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_RCNT_SHIFT, SQ_WAVE_IB_STS_RCNT_SIZE)		    //save RCNT
-    s_lshl_b32	    s_save_tmp, s_save_tmp, S_SAVE_PC_HI_RCNT_SHIFT
-    s_or_b32	    s_save_pc_hi, s_save_pc_hi, s_save_tmp
-    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT, SQ_WAVE_IB_STS_FIRST_REPLAY_SIZE)   //save FIRST_REPLAY
-    s_lshl_b32	    s_save_tmp, s_save_tmp, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-    s_or_b32	    s_save_pc_hi, s_save_pc_hi, s_save_tmp
-    s_getreg_b32    s_save_tmp, hwreg(HW_REG_IB_STS)					    //clear RCNT and FIRST_REPLAY in IB_STS
-    s_and_b32	    s_save_tmp, s_save_tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK_NEG
-
-    s_setreg_b32    hwreg(HW_REG_IB_STS), s_save_tmp
+    save_and_clear_ib_sts(s_save_tmp)
 
     /*	    inform SPI the readiness and wait for SPI's go signal */
     s_mov_b32	    s_save_exec_lo, exec_lo						    //save EXEC and use EXEC for the go signal from SPI
@@ -863,17 +831,7 @@ end
     s_load_dword    ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 glc:1
     s_waitcnt	    lgkmcnt(0)
 
-    //reuse s_restore_m0 as a temp register
-    s_and_b32	    s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_RCNT_MASK
-    s_lshr_b32	    s_restore_m0, s_restore_m0, S_SAVE_PC_HI_RCNT_SHIFT
-    s_lshl_b32	    s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_RCNT_SHIFT
-    s_mov_b32	    s_restore_tmp, 0x0										    //IB_STS is zero
-    s_or_b32	    s_restore_tmp, s_restore_tmp, s_restore_m0
-    s_and_b32	    s_restore_m0, s_restore_pc_hi, S_SAVE_PC_HI_FIRST_REPLAY_MASK
-    s_lshr_b32	    s_restore_m0, s_restore_m0, S_SAVE_PC_HI_FIRST_REPLAY_SHIFT
-    s_lshl_b32	    s_restore_m0, s_restore_m0, SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT
-    s_or_b32	    s_restore_tmp, s_restore_tmp, s_restore_m0
-    s_setreg_b32    hwreg(HW_REG_IB_STS),   s_restore_tmp
+    restore_ib_sts(s_restore_tmp)
 
     s_and_b32 s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff	//pc[47:32]	   //Do it here in order not to affect STATUS
     s_and_b64	 exec, exec, exec  // Restore STATUS.EXECZ, not writable by s_setreg_b32
@@ -1008,3 +966,19 @@ function set_status_without_spi_prio(status, tmp)
     s_nop           0x2 // avoid S_SETREG => S_SETREG hazard
     s_setreg_b32    hwreg(HW_REG_STATUS, SQ_WAVE_STATUS_PRE_SPI_PRIO_SHIFT, SQ_WAVE_STATUS_PRE_SPI_PRIO_SIZE), status
 end
+
+function save_and_clear_ib_sts(tmp)
+    // Save IB_STS.FIRST_REPLAY[15] and IB_STS.RCNT[20:16] into unused space ttmp11[31:26].
+    s_getreg_b32    tmp, hwreg(HW_REG_IB_STS)
+    s_and_b32       tmp, tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
+    s_lshl_b32      tmp, tmp, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+    s_andn2_b32     ttmp11, ttmp11, TTMP11_SAVE_RCNT_FIRST_REPLAY_MASK
+    s_or_b32        ttmp11, ttmp11, tmp
+    s_setreg_imm32_b32 hwreg(HW_REG_IB_STS), 0x0
+end
+
+function restore_ib_sts(tmp)
+    s_lshr_b32      tmp, ttmp11, (TTMP11_SAVE_RCNT_FIRST_REPLAY_SHIFT - SQ_WAVE_IB_STS_FIRST_REPLAY_SHIFT)
+    s_and_b32       tmp, tmp, SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK
+    s_setreg_b32    hwreg(HW_REG_IB_STS), tmp
+end
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
