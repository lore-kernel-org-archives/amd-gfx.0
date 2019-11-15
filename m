Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C61C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C563720709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C563720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E9F6F3F0;
	Fri, 15 Nov 2019 03:35:46 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476B66F3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV7tzVc0d1EY0GYzWGMgyhubXqdkFxrMoW1DXFIsxVn8yYC/PCSwWBBTo8wXhq2qbRWaK33SrpmybWgJEMz26xpx6NtVufcL8t1+MQwj9tbkfWUK0afb1Dxk3qd8zzA1S3+XYpomu6XICc4vAs3x7RxMSahUo5veyqLIIHfp5u/U4d1brvPcDKrtJ4Dtw7DhVpp71VSgo8VRKU1H2/yrVwd0XQSiFT4+4XxcbgOhkP5rlLoId3QKuRIvn59vvNqI9nHyr7wWTMSSKt7QWlzO0xiLRJJXZUgck+ezhZ5B+5IckCdUrnmDpJKAh1TSAB2jCX9vAVIbZmDdMa5clLmuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su/UDckO1eF5ze1GC5OUKRUAyqXMxA0IRlW48tS+b4w=;
 b=dE/su/hQmMHcxJ4KMcK/GtLTCTEduU2yNTIz/MzZJtXFyhYmyv+2m2+Yh6Q35gOcsJabS2zI7TKDtx3bmBH0941YgMHshKS+xNl+eMEjlU8qqo/6X+WUYVvZqJYKjnqV6m/gzbS8oep1Fxb93Is0+JDm2Pu6Y2blX16hq+spXVtn8owOhgZN6xnh17at59BxFHXAJAonuDH7Ksiwz2jTv7MOYRSFr3z/5OcCc4jjwzrsiUSGZrfwHxG3JtC4tukJVzdn92yDGU+VG8pHTDX0fkQGmnLKk5XKIEXI9+RtX0pInFtCguDzjKs6fSlSyUCxH9AJQ4ZGV7UCKIEm4+TTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:42 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:42 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/12] tests/amdgpu: add atomic_mem cp_packet to verify the
 secure buffer
Date: Fri, 15 Nov 2019 11:34:52 +0800
Message-Id: <1573788895-3936-9-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc706f4c-ad3a-45c5-8640-08d7697ce475
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36631CA41FB26AC0F74FB9D9F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(15650500001)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aicitFKvyC29jhCR3ZmvnJMyfKytHyddcQBX+j2QTO2H2J0VqaGWolkZ/g4g2Ai0tpo3P0FNF6avA0QgZhtgTp2cJYJ6qLlSVvJT258mDcLMCIMxefZjXgB/4P4N/E6gW+XTmtMRbI/UJeqQFYlaQv7GVgS9BlkogkflP+8Mbs3mI/sACO/PPV/BKrxkRWQg2OvW4DAaZt5LUWNtrNhOT5Dw2c39a2/lTMqYxATL2RPhfFR7onIHPmlUzyCbHt2ltfV2l21kYymTiT0//eDVOXVZ5FBsh4js+DqA3zFWSJ+jjnsRja45EHdc33ud9adda2S3nWZPWIwViGMKY8UdHqRRI439Ff8WHK1UU2XGDDVEX7fsgOKVY0FqTcw1cM/KzBbX3tESPLg/Zn3UW0GP/QU/M83OCSAGsDY95sfVXIoCPTCsgRs35mzw9OZ7t5Ns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc706f4c-ad3a-45c5-8640-08d7697ce475
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:42.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROsR92L36Hh4+sa2FZKGIlgmy9nBXTfOhuMoiH0bpkC4BeAiJm+tKR7XFAn1Cw8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su/UDckO1eF5ze1GC5OUKRUAyqXMxA0IRlW48tS+b4w=;
 b=oDgLOAaJ+tnBu7QJ8oZnX68pK3z9aVbOAS+fJv3NRiLe+drgcqpvrb4+tYptq4O09hbRR5vjQp26D5eoJCCoSWuTE150OKAOuhegJeexelgl85CHjh1bDM2q+vRndX2x3Rj+/YzTDCYnSVQhIaM0ULG+GzPWNrIo83/oYwVagts=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Luben.Tuikov@amd.com, Alexander.Deucher@amd.com, Leo.Liu@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033452.Y-lhm7TDZp1hWWCjCXWbvr-qQgFgwUx5-H0IdSBCLl4@z>

U2VjdXJlIGJ1ZmZlciBpcyBvbmx5IGFibGUgdG8gYmUgcmVhZCB3aXRoIHRydXN0ZWQgaXAgYmxv
Y2suClNvIHdlIG5lZWQgdXNlIEdGWCBpcCB0byByZWFkIGl0IGJhY2sgaW5zdGVhZCBvZiBDUFUu
ClN0ZXBzOgoxLiB1c2Ugd3JpdGVfZGF0YSBwYWNrZXQgdG8gd3JpdGUgMHhkZWFkYmVhZiB0byBz
ZWN1cmUgYnVmZmVyLAoyLiB1c2UgYXRtb2ljX21lbSBwYWNrZXQgYW5kIEFUT01JQ19DTVBTV0FQ
X1JUTl8zMiBvcGNvZGUgdG8gY29tcGFyZQp0aGUgY21wX2RhdGEoMHhkZWFkYmVhZikgdG8gdGhl
IHdyaXR0ZW4gZGF0YSB3aGljaCBoYXMgYmVlbiBlbmNyeXB0ZWQuCklmIHRoZSByZXN1bHQgaXMg
ZXF1YWwsIHRoZW4gb3ZlcndyaXRlIHRoZSBzcmNfZGF0YSgweDEyMzQ1Njc4KSB0byB0aGUKc2Vj
dXJlIGJ1ZmZlciBhbmQgcmV0dXJuIGRpcmVjdGx5LiBPdGhlcndpc2UgbG9vcCBhZ2FpbiB1bnRp
bCBnZnggdGltZW91dAphbmQgdGhlIHNlY3VyZSBidWZmZXIgZGF0YSB1bmNoYW5nZWQuCgpTaWdu
ZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPgotLS0KIHRlc3RzL2FtZGdw
dS9iYXNpY190ZXN0cy5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUv
YmFzaWNfdGVzdHMuYwppbmRleCA5NTZiZTkzLi45MDcyMzdlIDEwMDY0NAotLS0gYS90ZXN0cy9h
bWRncHUvYmFzaWNfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwpAQCAt
MTYwLDYgKzE2MCwyMCBAQCBDVV9UZXN0SW5mbyBiYXNpY190ZXN0c1tdID0gewogCQkgKiAyIC0g
Y2UKIAkJICovCiAKKyNkZWZpbmUJUEFDS0VUM19BVE9NSUNfTUVNCQkJCTB4MUUKKyNkZWZpbmUg
ICAgIFRDX09QX0FUT01JQ19DTVBTV0FQX1JUTl8zMiAgICAgICAgICAweDAwMDAwMDA4CisjZGVm
aW5lICAgICBBVE9NSUNfTUVNX0NPTU1BTkQoeCkgICAgICAgICAgICAgICAoKHgpIDw8IDgpCisg
ICAgICAgICAgICAvKiAwIC0gc2luZ2xlX3Bhc3NfYXRvbWljLgorICAgICAgICAgICAgICogMSAt
IGxvb3BfdW50aWxfY29tcGFyZV9zYXRpc2ZpZWQuCisgICAgICAgICAgICAgKi8KKyNkZWZpbmUg
ICAgIEFUT01JQ19NRU1fQ0FDSEVQT0xJQ0FZKHgpICAgICAgICAgICgoeCkgPDwgMjUpCisgICAg
ICAgICAgICAvKiAwIC0gbHJ1LgorICAgICAgICAgICAgICogMSAtIHN0cmVhbS4KKyAgICAgICAg
ICAgICAqLworI2RlZmluZSAgICAgQVRPTUlDX01FTV9FTkdJTkVTRUwoeCkgICAgICAgICAgICAg
KCh4KSA8PCAzMCkKKyAgICAgICAgICAgIC8qIDAgLSBtaWNyb19lbmdpbmUuCisJCQkgKi8KKwog
I2RlZmluZQlQQUNLRVQzX0RNQV9EQVRBCQkJCTB4NTAKIC8qIDEuIGhlYWRlcgogICogMi4gQ09O
VFJPTApAQCAtMTQ3Miw4ICsxNDg2LDMzIEBAIGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3Jp
dGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hhbmRsZQogCiAJCQkv
KiB2ZXJpZnkgaWYgU0RNQSB0ZXN0IHJlc3VsdCBtZWV0cyB3aXRoIGV4cGVjdGVkICovCiAJCQlp
ID0gMDsKLQkJCXdoaWxlKGkgPCBzZG1hX3dyaXRlX2xlbmd0aCkgewotCQkJCUNVX0FTU0VSVF9F
UVVBTChib19jcHVbaSsrXSwgMHhkZWFkYmVhZik7CisJCQlpZiAoIXNlY3VyZSkgeworCQkJCXdo
aWxlKGkgPCBzZG1hX3dyaXRlX2xlbmd0aCkgeworCQkJCQlDVV9BU1NFUlRfRVFVQUwoYm9fY3B1
W2krK10sIDB4ZGVhZGJlYWYpOworCQkJCX0KKwkJCX0gZWxzZSBpZiAoaXBfdHlwZSA9PSBBTURH
UFVfSFdfSVBfR0ZYKSB7CisJCQkJbWVtc2V0KCh2b2lkKilwbTQsIDAsIHBtNF9kdyAqIHNpemVv
Zih1aW50MzJfdCkpOworCQkJCXBtNFtpKytdID0gUEFDS0VUMyhQQUNLRVQzX0FUT01JQ19NRU0s
IDcpOworCQkJCS8qIGF0b21pYyBvcGNvZGUgZm9yIDMyYiB3LyBSVE4gYW5kIEFUT01JQ19TV0FQ
Q01QX1JUTgorCQkJCSAqIGNvbW1hbmQsIDEtbG9vcF91bnRpbF9jb21wYXJlX3NhdGlzZmllZC4K
KwkJCQkgKiBzaW5nbGVfcGFzc19hdG9taWMsIDAtbHJ1CisJCQkJICogZW5naW5lX3NlbCwgMC1t
aWNyb19lbmdpbmUKKwkJCQkgKi8KKwkJCQlwbTRbaSsrXSA9IChUQ19PUF9BVE9NSUNfQ01QU1dB
UF9SVE5fMzIgfAorCQkJCQkJCUFUT01JQ19NRU1fQ09NTUFORCgxKSB8CisJCQkJCQkJQVRPTUlD
X01FTV9DQUNIRVBPTElDQVkoMCkgfAorCQkJCQkJCUFUT01JQ19NRU1fRU5HSU5FU0VMKDApKTsK
KwkJCQlwbTRbaSsrXSA9IDB4ZmZmZmZmZmMgJiBib19tYzsKKwkJCQlwbTRbaSsrXSA9ICgweGZm
ZmZmZmZmMDAwMDAwMDAgJiBib19tYykgPj4gMzI7CisJCQkJcG00W2krK10gPSAweDEyMzQ1Njc4
OworCQkJCXBtNFtpKytdID0gMHgwOworCQkJCXBtNFtpKytdID0gMHhkZWFkYmVhZjsKKwkJCQlw
bTRbaSsrXSA9IDB4MDsKKwkJCQlwbTRbaSsrXSA9IDB4MTAwOworCQkJCWFtZGdwdV90ZXN0X2V4
ZWNfY3NfaGVscGVyX3JhdyhkZXZpY2UsIGNvbnRleHRfaGFuZGxlLAorCQkJCQkJCWlwX3R5cGUs
IHJpbmdfaWQsIGksIHBtNCwKKwkJCQkJCQkxLCByZXNvdXJjZXMsIGliX2luZm8sCisJCQkJCQkJ
aWJzX3JlcXVlc3QsIHRydWUpOwogCQkJfQogCiAJCQlyID0gYW1kZ3B1X2JvX3VubWFwX2FuZF9m
cmVlKGJvLCB2YV9oYW5kbGUsIGJvX21jLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
