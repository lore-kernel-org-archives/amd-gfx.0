Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6197C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9236A2071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236A2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EE16E486;
	Tue, 26 Nov 2019 19:33:48 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10C76E488
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 19:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjo1VirGTy9ajEDdXrCo6eA7AHARcj05+wFJZ2Eplgu1vZLasrqfCTfr1jFdATfb7DSsRNLPNIGcsXGjE+TCseaI2fMECdpbg9sW07vGIRqvLMMGqbzn0uIDq/1ExQU+1kRP+/BTXUKz5u1QN11Vtb5WtBIc++cOjkTw+0M8G+wagMR60IDavgb8wpx06XPAqBsdPk/gysA4pAfFYrN+ZfZsvSX6/n97Jk4+QoqJkdrSmCtybpXQyIYGWF+kzal+B1+EUSY/6M3LS10a7qUPP0ltR83zXCBDA8uvvQbHyg+fdXDPGzrw5vNokpC1DSr6p8aTv8swogf5ioWoTbYv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX2tE1uoXhkKT7A+L6u4KeKfnmNEmaMfzeVd/sR4RKA=;
 b=CgiOFa6iuax1eHrkSZAtqGkJwzE2x8cSPBdP2kbrb2gBhyWaEa38w3L9jvKB69wWPziSV7NtTpA0ac6HtSXmzuMOKevzBWy4LSDZACxkfyg3UGwjVlSjbqr0f67UkbdgM/w1ko3isM4BCShgcrbt11Loud9F6TCFVolermkPQJ4ZJlyjtglbbpTZ7lAwYRjypnD6C5RYdaTFWSGp/aI+Awn2O8Udhv3AHq2ZeVszps9KakIL2Zp6P8DnUlcBkDQSbIDcSnXe47skilwLT4JewLfbULR01KtHlg8fp68hxozvvQ3tCItSN2/Z0gpvLFSMFBHLC0qLa3OtgfuA3tCBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 19:33:45 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:33:45 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/gfx: Increase dispatch packet number
Date: Tue, 26 Nov 2019 14:33:38 -0500
Message-Id: <1574796818-11648-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
References: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7957cc6c-ea1f-4389-aada-08d772a78d5d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:|CY4PR12MB1798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB179831CA8319B3948A5FB7AFE4450@CY4PR12MB1798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5660300002)(2361001)(99286004)(66946007)(2616005)(66476007)(66556008)(6506007)(305945005)(186003)(26005)(36756003)(386003)(7736002)(51416003)(6116002)(16586007)(3846002)(76176011)(4326008)(50466002)(316002)(48376002)(6486002)(52116002)(8936002)(6666004)(478600001)(2906002)(8676002)(6436002)(81166006)(81156014)(66066001)(6916009)(446003)(6512007)(47776003)(11346002)(2351001)(25786009)(86362001)(14454004)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1798;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsPh3YNkv34EXFgSF1ocATVLt7qsNboC2X7aXEs26LqtDzcyQr2QxLlfJDrywdEuki9Sm41qPWPy1eOxrhLrBV66S8AegCsSRxifgnIZBY+oLFUbINEPGmTTsd0lOSGCSIue16Nx+L7VK1iD587nl8Q/bVfVLF/P57t1F9hSYLFdHwzlLdJv275orIxxstkwRTilnxe8XEfrsts8wu5CFSUUd0NkvBE3niVfKup3RXqNko1ALbvxESvFve54yelOpj+clsvk/Ldpj08I1Bnn8evyIAgj4zfMW5R7/rNolJc+2tzh4w3qbIGgeS2N14FWFlKVCs1MPKoWR28HIc7enyUtGPwxhtElsQIuv+VDgiu+2j85fG5uLQPDDkoPUjrA5h3pC8Q/+eq4oDkZ391jGyZrrcGZqmnJ0xGFMD1FmI8GNa8FGzvQnScw3MJFdF1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7957cc6c-ea1f-4389-aada-08d772a78d5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 19:33:45.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig3VSQYYIEjuSDs9jRD0XIG3zSdOZmSGTZZGCrAl31sl8Iv9RLS0+m66atdhWL67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX2tE1uoXhkKT7A+L6u4KeKfnmNEmaMfzeVd/sR4RKA=;
 b=Fi8A+2heC+h07fCnhMNjlHgU2u1m/6GS9M5r3ffctzv1UChPp/qiS+BvPY+HRNcRXSPRpiAKnYY2oPOQUTmBMeYf2bfyLeedx27jc9ZTCfBLkA7KCFg3t8e/lsGDV/74UH7DbaUnEy9EP54+z9qBjG2ZXciGfF/MUSFTsab4ZiA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: jamesz@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126193338.PT3At_a9L1CSirI6PYARd4_Xcs9B0TtCcff9R7gdrRE@z>

Rm9yIEFyY3R1cnVzLCBpbmNyZWFzZSBkaXNwYXRjaCBwYWNrZXQgbnVtYmVyIHRvIHN0cmVzcyBz
Y2hlZHVsZXIuCgpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggZGMzOGRmOC4uZTkwNWFjNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC00MTQ2LDcgKzQxNDYsNyBAQCBzdGF0aWMgaW50
IGdmeF92OV8wX2RvX2VkY19ncHJfd29ya2Fyb3VuZHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAKIAkvKiB3cml0ZSBkaXNwYXRjaCBwYWNrZXQgKi8KIAlpYi5wdHJbaWIubGVuZ3RoX2R3
KytdID0gUEFDS0VUMyhQQUNLRVQzX0RJU1BBVENIX0RJUkVDVCwgMyk7Ci0JaWIucHRyW2liLmxl
bmd0aF9kdysrXSA9IDEyODsgLyogeCAqLworCWliLnB0cltpYi5sZW5ndGhfZHcrK10gPSAyNTY7
IC8qIHggKi8KIAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0gMTsgLyogeSAqLwogCWliLnB0cltp
Yi5sZW5ndGhfZHcrK10gPSAxOyAvKiB6ICovCiAJaWIucHRyW2liLmxlbmd0aF9kdysrXSA9CkBA
IC00MTc0LDcgKzQxNzQsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2RvX2VkY19ncHJfd29ya2Fy
b3VuZHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAkvKiB3cml0ZSBkaXNwYXRjaCBw
YWNrZXQgKi8KIAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0gUEFDS0VUMyhQQUNLRVQzX0RJU1BB
VENIX0RJUkVDVCwgMyk7Ci0JaWIucHRyW2liLmxlbmd0aF9kdysrXSA9IDEyODsgLyogeCAqLwor
CWliLnB0cltpYi5sZW5ndGhfZHcrK10gPSAyNTY7IC8qIHggKi8KIAlpYi5wdHJbaWIubGVuZ3Ro
X2R3KytdID0gMTsgLyogeSAqLwogCWliLnB0cltpYi5sZW5ndGhfZHcrK10gPSAxOyAvKiB6ICov
CiAJaWIucHRyW2liLmxlbmd0aF9kdysrXSA9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
