Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39FC4741F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FAC20754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lvE3+pLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FAC20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9538B6E8CD;
	Thu,  1 Oct 2020 18:24:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9EC6E8D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 18:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQEGZS1cj99jPmlMJQz3nVLf4Puq6UpoaJTI/1b5tGtc71NSacSR95+EsGUNkfs+AmRuE2XE87zuLsocTaYV0HF674Vu0QpSvS9wTfD/q5/ALBi3u9y+Q4gtdrJTDZ6MQEwRSdrebqKeCZdAifDNkfwTKNWgI+SbfZ3+Fh7BZ2MHFNbUEsHb8AESH8QHZgCNHxTBJM9vjoR3tJH7/t664jWpUlvChHv3fkxxk11jhY/Rv5Q0RQAGWgmVhVBJPmKqS9C0K4UWxf5tE9ttgFBN55nPEeAeT5fGC0ZD14Tj5DeV8vt7fTssTfPkt6TkdxsjoZUnX7QkiuZ40V7FqqBlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8/eteteZ235G57594m8ziH97XuzjMAaCAuWWYa5rP0=;
 b=XqOBLSY2U2Dicirme4ocq/9F0zD2H7ttBDZbzB5zyl6BPfJ6ltJnWURv2eDo99gHTv9BNAElFMOqhmDYhenjFpS3n232W0bn/gZJCijhqQ8HC6uA4dFh4ScDz68nOxQ6B3kzBQ3VrQUramwhYeYVBt+HS5Pa0JC9HZCPvL4Pz7+giPFmv8UMtvNILFSmvPVQVLk6egidjLTdSDCs5fFrUoSpd5WD8Wx9ZKudJejgshH1dtB7Jzwv14VAlmdn6diILg6aMR3t6WvJ8gL2Bx0sC8cNa6BOlw3O+FyujFh1B13cz1XpXS3CukbYQVNQdGlmSnz0rrYAtRBXOtui3qOlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8/eteteZ235G57594m8ziH97XuzjMAaCAuWWYa5rP0=;
 b=lvE3+pLnREvFzZXDmrMGSuzHHuJtlaRGscdqf0JLOvoqduNDhsYIFBaxDsmaPg2E+y5G/dbwUNcUEaIxVP5+zCjvLn6mmvEYx2w79EniEGQdMBegVMWWoOddj0KtkxyKVGQpOd9gTLr8UHtCbQCh5G8TNRqP6e1tkTjToyzIXvA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 1 Oct
 2020 18:24:42 +0000
Received: from SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591]) by SN6PR12MB2688.namprd12.prod.outlook.com
 ([fe80::f013:7c04:babd:3591%4]) with mapi id 15.20.3433.038; Thu, 1 Oct 2020
 18:24:42 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdkfd: Save TTMPs on all ASICs in gfx10 trap handler
Date: Thu,  1 Oct 2020 13:24:08 -0500
Message-Id: <20201001182408.3960-4-jay.cornwall@amd.com>
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
 Transport; Thu, 1 Oct 2020 18:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38968346-67ee-4c02-8fed-08d866374428
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44467AB5529CAAE11173775F87300@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYMsuDSSxM9fzdnhWLaiWWs0MDP46aLrZ9xJTH+1zqYp64bsYAfBDXTGwxiveGkDVw3O1R7RnkrNJ6cZwftYeP3X3GZ/L658o71M8FeSnRC4na9QLRlvqobwQ1Ia7+RzPq9XNOCTeSj8ZRa3RrDRl0SY6CNpdO7vYuxWdbpjokad/u6FrGuKlkQtX3rvtpK6zzfzs37A00aakD+hO/mZ96OPHjqpYi+7cYz2PkQ5Z6EuQHHnrFPYpq+de2CX1/y5nclAUI177p600N2cL/tENsupGKrnxSwqV0JjoIfLvKZN4R7OQ5b+f5NXf3SbP6zLWeukf5jDG+1L9c+7MPUy9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2688.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66556008)(16526019)(1076003)(66476007)(186003)(36756003)(4326008)(66946007)(26005)(5660300002)(2616005)(8676002)(86362001)(6916009)(6666004)(83380400001)(52116002)(7696005)(8936002)(2906002)(44832011)(6486002)(478600001)(956004)(54906003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pAfkoKdjHT8/Ym83kIEdTExFK4Rm0lxZKbBzH7nbNnyRdWLDggO16HI9c2NxKJVt2W2c+pDEg/u2pxtUhVtztPMA+1tfsEd0TNGwLEcy6jJYC80mLNWPFU2RTpPjmhJ2AkFxYUcbuaV1UFg3wgmf0yvf+ZZnGdkKOXJPrshRi15tVPi98a68gq3t73X3S0rha5hoZ2NvDcWiWGyptpeVCUWZcyQUn1NrfGwVRgY9ICT/POCIN+jb2QS7XyfujVOS/p4S6f8KgzbimezDRxDJGkSYAUXA14NhaAMqM+D1plVgJNdJ4rICDeCkBDsRfx99rEiOFrcP01Hdh2F8qt9p//RjyIQxSIhS5zFZG7eZ/d/X0KEPbHdyMrsNkUNzxapUX7JrxMZ6SOSl2ObVeCw6jGhgxAZu0P+rNEYu+mqm3y4It/32/7kTIUH093HIa8hPkp1bqBfD6nY4xuf9676sr0n8sCFDmi5Do1QdIOQGeD1AxSeE430ilw7tpxK6PcjoIF+kUr2IRrLTkJYuydh/FdwqsI74Wn/+7Q6wAbI+DKfxq2jfwPkoFRXjU1acePm93Xu4sHKcdnFrmbeuxsnRGxLrODX5ptua4jupPqrbi3BAfBg3hF7DZfar6Jox/JoPDZo2uQRzM4S9W4hB8D3EHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38968346-67ee-4c02-8fed-08d866374428
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:24:42.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOlziXSqvF/r5F09hV/C2ffK30PPUnw/WlA1o7YNhLNbqEhXBVKcXCyD9mvg1uC0ZLDSUsyuyp0RUUUPzRxbdQ==
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

Trap temporary GPRs are not currently saved/restored on ASICs
without scalar store instructions. They contain data useful to a
user-mode debugger.

Use vector store instructons to save TTMPs on these ASICs.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Laurent Morichetti <laurent.morichetti@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 119 ++++++++++--------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  46 ++++++-
 2 files changed, 114 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 9c903c38dd74..d674f6d798f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -1534,7 +1534,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx10_hex[] = {
-	0xbf820001, 0xbf8201cb,
+	0xbf820001, 0xbf8201f5,
 	0xb0804004, 0xb978f802,
 	0x8a788678, 0xb96ef801,
 	0x876eff6e, 0x00000800,
@@ -1563,6 +1563,11 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0xbf900004, 0xbf8cc07f,
 	0x877aff7f, 0x04000000,
 	0x8f7a857a, 0x886d7a6d,
+	0xbefa037e, 0x877bff7f,
+	0x0000ffff, 0xbefe03c1,
+	0xbeff03c1, 0xdc5f8000,
+	0x007a0000, 0x7e000280,
+	0xbefe037a, 0xbeff037b,
 	0xb97b02dc, 0x8f7b997b,
 	0xb97a2a05, 0x807a817a,
 	0xbf0d997b, 0xbf850002,
@@ -1570,58 +1575,74 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 	0x8f7a8a7a, 0x877bff7f,
 	0x0000ffff, 0x807aff7a,
 	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xbef4037e,
-	0x8775ff7f, 0x0000ffff,
-	0x8875ff75, 0x00040000,
-	0xbef60380, 0xbef703ff,
-	0x10807fac, 0xbef1037c,
-	0xbef00380, 0xb97302dc,
-	0x8f739973, 0xbefe03c1,
-	0x907c9973, 0x877c817c,
-	0xbf06817c, 0xbf850002,
-	0xbeff0380, 0xbf820002,
-	0xbeff03c1, 0xbf82000b,
+	0x827b807b, 0xd7610000,
+	0x00010870, 0xd7610000,
+	0x00010a71, 0xd7610000,
+	0x00010c72, 0xd7610000,
+	0x00010e73, 0xd7610000,
+	0x00011074, 0xd7610000,
+	0x00011275, 0xd7610000,
+	0x00011476, 0xd7610000,
+	0x00011677, 0xd7610000,
+	0x00011a79, 0xd7610000,
+	0x00011c7e, 0xd7610000,
+	0x00011e7f, 0xbefe03ff,
+	0x00003fff, 0xbeff0380,
+	0xdc5f8040, 0x007a0000,
+	0xd760007a, 0x00011d00,
+	0xd760007b, 0x00011f00,
+	0xbefe037a, 0xbeff037b,
+	0xbef4037e, 0x8775ff7f,
+	0x0000ffff, 0x8875ff75,
+	0x00040000, 0xbef60380,
+	0xbef703ff, 0x10807fac,
+	0xbef1037c, 0xbef00380,
+	0xb97302dc, 0x8f739973,
+	0xbefe03c1, 0x907c9973,
+	0x877c817c, 0xbf06817c,
+	0xbf850002, 0xbeff0380,
+	0xbf820002, 0xbeff03c1,
+	0xbf820009, 0xbef603ff,
+	0x01000000, 0xe0704080,
+	0x705d0100, 0xe0704100,
+	0x705d0200, 0xe0704180,
+	0x705d0300, 0xbf820008,
 	0xbef603ff, 0x01000000,
-	0xe0704000, 0x705d0000,
-	0xe0704080, 0x705d0100,
-	0xe0704100, 0x705d0200,
-	0xe0704180, 0x705d0300,
-	0xbf82000a, 0xbef603ff,
-	0x01000000, 0xe0704000,
-	0x705d0000, 0xe0704100,
-	0x705d0100, 0xe0704200,
-	0x705d0200, 0xe0704300,
-	0x705d0300, 0xb9702a05,
-	0x80708170, 0xbf0d9973,
-	0xbf850002, 0x8f708970,
-	0xbf820001, 0x8f708a70,
-	0xb97a1e06, 0x8f7a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0xbef603ff,
-	0x01000000, 0x7e000280,
-	0x7e020280, 0x7e040280,
-	0xbefc0380, 0xd7610002,
-	0x0000f871, 0x807c817c,
-	0xd7610002, 0x0000f86c,
-	0x807c817c, 0x8a7aff6d,
-	0x80000000, 0xd7610002,
-	0x0000f87a, 0x807c817c,
-	0xd7610002, 0x0000f86e,
+	0xe0704100, 0x705d0100,
+	0xe0704200, 0x705d0200,
+	0xe0704300, 0x705d0300,
+	0xb9702a05, 0x80708170,
+	0xbf0d9973, 0xbf850002,
+	0x8f708970, 0xbf820001,
+	0x8f708a70, 0xb97a1e06,
+	0x8f7a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
+	0xbef603ff, 0x01000000,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefc0380,
+	0xd7610002, 0x0000f871,
 	0x807c817c, 0xd7610002,
-	0x0000f86f, 0x807c817c,
-	0xd7610002, 0x0000f878,
-	0x807c817c, 0xb97af803,
+	0x0000f86c, 0x807c817c,
+	0x8a7aff6d, 0x80000000,
 	0xd7610002, 0x0000f87a,
 	0x807c817c, 0xd7610002,
-	0x0000f87b, 0x807c817c,
-	0xb971f801, 0xd7610002,
-	0x0000f871, 0x807c817c,
-	0xb971f814, 0xd7610002,
-	0x0000f871, 0x807c817c,
-	0xb971f815, 0xd7610002,
-	0x0000f871, 0x807c817c,
-	0xbeff0380, 0xe0704000,
-	0x705d0200, 0xb9702a05,
+	0x0000f86e, 0x807c817c,
+	0xd7610002, 0x0000f86f,
+	0x807c817c, 0xd7610002,
+	0x0000f878, 0x807c817c,
+	0xb97af803, 0xd7610002,
+	0x0000f87a, 0x807c817c,
+	0xd7610002, 0x0000f87b,
+	0x807c817c, 0xb971f801,
+	0xd7610002, 0x0000f871,
+	0x807c817c, 0xb971f814,
+	0xd7610002, 0x0000f871,
+	0x807c817c, 0xb971f815,
+	0xd7610002, 0x0000f871,
+	0x807c817c, 0xbefe03ff,
+	0x0000ffff, 0xbeff0380,
+	0xe0704000, 0x705d0200,
+	0xbefe03c1, 0xb9702a05,
 	0x80708170, 0xbf0d9973,
 	0xbf850002, 0x8f708970,
 	0xbf820001, 0x8f708a70,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 06947a8767c6..fbe3992d1c2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -253,6 +253,20 @@ L_SLEEP:
 	s_lshl_b32	s_save_tmp, s_save_tmp, (S_SAVE_PC_HI_FIRST_WAVE_SHIFT - S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT)
 	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
 
+#if NO_SQC_STORE
+	// Trap temporaries must be saved via VGPR but all VGPRs are in use.
+	// There is no ttmp space to hold the resource constant for VGPR save.
+	// Save v0 by itself since it requires only two SGPRs.
+	s_mov_b32	s_save_ttmps_lo, exec_lo
+	s_and_b32	s_save_ttmps_hi, exec_hi, 0xFFFF
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	s_mov_b32	exec_hi, 0xFFFFFFFF
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] slc:1 glc:1
+	v_mov_b32	v0, 0x0
+	s_mov_b32	exec_lo, s_save_ttmps_lo
+	s_mov_b32	exec_hi, s_save_ttmps_hi
+#endif
+
 	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
 	// ttmp SR memory offset : size(VGPR)+size(SGPR)+0x40
 	get_wave_size(s_save_ttmps_hi)
@@ -262,7 +276,27 @@ L_SLEEP:
 	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_spi_init_lo
 	s_addc_u32	s_save_ttmps_hi, s_save_ttmps_hi, 0x0
 
-#if ASIC_TARGET_NAVI1X
+#if NO_SQC_STORE
+	v_writelane_b32	v0, ttmp4, 0x4
+	v_writelane_b32	v0, ttmp5, 0x5
+	v_writelane_b32	v0, ttmp6, 0x6
+	v_writelane_b32	v0, ttmp7, 0x7
+	v_writelane_b32	v0, ttmp8, 0x8
+	v_writelane_b32	v0, ttmp9, 0x9
+	v_writelane_b32	v0, ttmp10, 0xA
+	v_writelane_b32	v0, ttmp11, 0xB
+	v_writelane_b32	v0, ttmp13, 0xD
+	v_writelane_b32	v0, exec_lo, 0xE
+	v_writelane_b32	v0, exec_hi, 0xF
+
+	s_mov_b32	exec_lo, 0x3FFF
+	s_mov_b32	exec_hi, 0x0
+	global_store_dword_addtid	v0, [s_save_ttmps_lo, s_save_ttmps_hi] inst_offset:0x40 slc:1 glc:1
+	v_readlane_b32	ttmp14, v0, 0xE
+	v_readlane_b32	ttmp15, v0, 0xF
+	s_mov_b32	exec_lo, ttmp14
+	s_mov_b32	exec_hi, ttmp15
+#else
 	s_store_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_save_ttmps_lo, s_save_ttmps_hi], 0x50 glc:1
 	s_store_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_save_ttmps_lo, s_save_ttmps_hi], 0x60 glc:1
 	s_store_dword   ttmp13, [s_save_ttmps_lo, s_save_ttmps_hi], 0x74 glc:1
@@ -303,7 +337,9 @@ L_SAVE_4VGPR_WAVE32:
 
 	// VGPR Allocated in 4-GPR granularity
 
+#if !NO_SQC_STORE
 	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+#endif
 	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128
 	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*2
 	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:128*3
@@ -314,7 +350,9 @@ L_SAVE_4VGPR_WAVE64:
 
 	// VGPR Allocated in 4-GPR granularity
 
+#if !NO_SQC_STORE
 	buffer_store_dword	v0, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+#endif
 	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256
 	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*2
 	buffer_store_dword	v3, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1 offset:256*3
@@ -361,9 +399,13 @@ L_SAVE_HWREG:
 	write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
 
 #if NO_SQC_STORE
-	// Write HWREG/SGPRs with 32 VGPR lanes, wave32 is common case.
+	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
+	s_mov_b32       exec_lo, 0xFFFF
 	s_mov_b32	exec_hi, 0x0
 	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset slc:1 glc:1
+
+	// Write SGPRs with 32 VGPR lanes. This works in wave32 and wave64 mode.
+	s_mov_b32       exec_lo, 0xFFFFFFFF
 #endif
 
 	/* save SGPRs */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
