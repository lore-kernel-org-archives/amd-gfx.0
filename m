Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3BBC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 19:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8D120748
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 19:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8D120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC236E183;
	Mon, 25 Nov 2019 19:35:57 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790082.outbound.protection.outlook.com [40.107.79.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132CE6E17C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 19:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELhSSbgMDQPXwquFSpKruUuq+0d06mSLsWn4RfE8YCiPdt2wYit+DGE0MOfcQ0UoJjD3VzfgFG7p7cyTkl0CvIS8YWef1sXlWFEeDalUudvuG0okc1BKqs+TfL4UlJQlyBBPhzlLwSp9XwluA/F1+PT3XGS3fUcKHoj4P2RRzfxm/WswyT735m652oapGYWyIClKmhr5eGHFb8lCfEcvdX09nZe5j5PyWSiJurmOrm4FzHdK6aXTd56pP/LbzBBpGameYqDMUhnn6h7aQOYjDtIApkDiorNGtxSA4+4YJlIDErY4Fo3aQk627la3QAennj4nztqtO0Oq4R7uyTaTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mX3n1kyrXVJNOxPjLcoziUBUSr8hHhTWuuwAz/3nRY=;
 b=KfUard2Wvry5rfcvYsNWV60xUgRFygxiJFyvwOtq1/w3aXS+UBKqYK+9PyW/XDuMsiaJmAdLxv+NJfj6wkbfOT6AjAZJFlTfqxP0E6rhDOj9vy7OHo+lXxAEqT0N+DBibIE8zsygXOrUQNigkQgMKbfK8bpWLhV9NsGG8SsRlOqIfRIQpnq9OTkXf13psaFtUb7/eTCKtKmStOFpDA1m1KdnskZOeNNf92xPGenHHvbch2rFDmYLIaQZ52ryc1HeJMNWanSDThiGIz1GJywBRxo82Hq70YMa7f0AKPsxuNF2sZNPnHGQG6bAzpLsIE4DbgaF+PLVY+GprM5eywcZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 19:35:54 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 19:35:54 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Xinhui.Pan@amd.com
Subject: [PATCH 1/1] drm/amdgpu: Optimize KFD page table reservation
Date: Mon, 25 Nov 2019 14:35:26 -0500
Message-Id: <20191125193526.19803-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 487b0528-3a30-458b-602b-08d771deaff3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:|DM6PR12MB2969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2969C350F9C0F19D25C0D720924A0@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(86362001)(2616005)(81156014)(81166006)(66946007)(50226002)(8936002)(386003)(66476007)(66066001)(5660300002)(2906002)(50466002)(2870700001)(316002)(3846002)(6116002)(47776003)(1076003)(6436002)(99286004)(14454004)(14444005)(36756003)(6486002)(26005)(52116002)(25786009)(478600001)(66556008)(6506007)(8676002)(6636002)(6666004)(48376002)(186003)(6512007)(51416003)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2969;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9DIGEKJDUra0TuQkr2HZq6CXzY1rAXpacHsF76lTYFubZZ73R5pafV57Q/2K0pYAVGAVVykfa2sxAuweAltoeXLBImngxRezy8wUUi61KGat/Dlgu/7RHhhdq1iSi+N2dBld4Up5vkEijUEF805V2CX56gMeM1fDdV2VqbI490QBkvo6ed0qwN6KhusP2brZA4rqFDLN+CRoGWynj9TpkHYzV6xNMhL7rprFC05kXRDYQt4XJpFhRD2kBiELuoPtzTuK4/Yz7tKzOsqNkRWKW5Bj9cBOJpOf4HMiYcR0/GdEasgPo19jIEek+kO1CgR8136MKWw4OHOI7lsamv7NxzoQC3zyZR/xScoRDXNuS9PEs1Zg0or7dz005ZcmHP7xAuX7Gopxrh63aIkTg6IOEwhMj7u1iijLu2x9r4OiRsngMgbne4QLSq63FmV5SCE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487b0528-3a30-458b-602b-08d771deaff3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 19:35:54.7054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYpM0W2jXhZTUz2ebK337aK7Di112j4BF1AuvKJv2Vg6kywwErAtUiwKAmaPKzxTyg/GBWzvOH989kbL5tYD2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mX3n1kyrXVJNOxPjLcoziUBUSr8hHhTWuuwAz/3nRY=;
 b=i0jCab/nDZgVXqKo1DlfhlgBtbmVlJ5GUfaHLg06fY8NBzhaL+0CosJ6SlATJ7SoncL/rWEhLdQUsscbvClGmzPIm6F39a9EnGPei+TbGBD4o2W4IjsWZ4XmndC89L970TRnZNqPjMhBAXdCkinfI4jMSUNHkzgfwn0yVXSibqE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125193526.N2Dlt5cZlV2hGptmTJ0le2jndwThZg6yXgnn_6aivrE@z>

QmUgbGVzcyBwZXNzaW1pc3RpYyBhYm91dCBlc3RpbWF0ZWQgcGFnZSB0YWJsZSB1c2UgZm9yIEtG
RC4gTW9zdAphbGxvY2F0aW9ucyB1c2UgMk1CIHBhZ2VzIGFuZCB0aGVyZWZvcmUgbmVlZCBsZXNz
IFZSQU0gZm9yIHBhZ2UKdGFibGVzLiBUaGlzIGFsbG93cyBtb3JlIFZSQU0gdG8gYmUgdXNlZCBm
b3IgYXBwbGljYXRpb25zIGVzcGVjaWFsbHkKb24gbGFyZ2Ugc3lzdGVtcyB3aXRoIG1hbnkgR1BV
cyBhbmQgaHVuZHJlZHMgb2YgR0Igb2Ygc3lzdGVtIG1lbW9yeS4KCkV4YW1wbGU6IDggR1BVcyB3
aXRoIDMyR0IgVlJBTSBlYWNoICsgMjU2R0Igc3lzdGVtIG1lbW9yeSA9IDUxMkdCCk9sZCBwYWdl
IHRhYmxlIHJlc2VydmF0aW9uIHBlciBHUFU6ICAxR0IKTmV3IHBhZ2UgdGFibGUgcmVzZXJ2YXRp
b24gcGVyIEdQVTogMzJNQgoKU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIHwgMTUgKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwppbmRleCBhMWVkOGE4ZTM3NTIuLmU0M2E5NTUxNGI0
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYwpAQCAtMTA1LDExICsxMDUsMjQgQEAgdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX2luaXRf
bWVtX2xpbWl0cyh2b2lkKQogCQkoa2ZkX21lbV9saW1pdC5tYXhfdHRtX21lbV9saW1pdCA+PiAy
MCkpOwogfQogCisvKiBFc3RpbWF0ZSBwYWdlIHRhYmxlIHNpemUgbmVlZGVkIHRvIHJlcHJlc2Vu
dCBhIGdpdmVuIG1lbW9yeSBzaXplCisgKgorICogV2l0aCA0S0IgcGFnZXMsIHdlIG5lZWQgb25l
IDggYnl0ZSBQVEUgZm9yIGVhY2ggNEtCIG9mIG1lbW9yeQorICogKGZhY3RvciA1MTIsID4+IDkp
LiBXaXRoIDJNQiBwYWdlcywgd2UgbmVlZCBvbmUgOCBieXRlIFBURSBmb3IgMk1CCisgKiBvZiBt
ZW1vcnkgKGZhY3RvciAyNTZLLCA+PiAxOCkuIFJPQ20gdXNlciBtb2RlIHRyaWVzIHRvIG9wdGlt
aXplCisgKiBmb3IgMk1CIHBhZ2VzIGZvciBUTEIgZWZmaWNpZW5jeS4gSG93ZXZlciwgc21hbGwg
YWxsb2NhdGlvbnMgYW5kCisgKiBmcmFnbWVudGVkIHN5c3RlbSBtZW1vcnkgc3RpbGwgbmVlZCBz
b21lIDRLQiBwYWdlcy4gV2UgY2hvb3NlIGEKKyAqIGNvbXByb21pc2UgdGhhdCBzaG91bGQgd29y
ayBpbiBtb3N0IGNhc2VzIHdpdGhvdXQgcmVzZXJ2aW5nIHRvbworICogbXVjaCBtZW1vcnkgZm9y
IHBhZ2UgdGFibGVzIHVubmVjZXNzYXJpbHkgKGZhY3RvciAxNkssID4+IDE0KS4KKyAqLworI2Rl
ZmluZSBFU1RJTUFURV9QVF9TSVpFKG1lbV9zaXplKSAoKG1lbV9zaXplKSA+PiAxNCkKKwogc3Rh
dGljIGludCBhbWRncHVfYW1ka2ZkX3Jlc2VydmVfbWVtX2xpbWl0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQl1aW50NjRfdCBzaXplLCB1MzIgZG9tYWluLCBib29sIHNnKQogeworCXVp
bnQ2NF90IHJlc2VydmVkX2Zvcl9wdCA9CisJCUVTVElNQVRFX1BUX1NJWkUoYW1kZ3B1X2FtZGtm
ZF90b3RhbF9tZW1fc2l6ZSk7CiAJc2l6ZV90IGFjY19zaXplLCBzeXN0ZW1fbWVtX25lZWRlZCwg
dHRtX21lbV9uZWVkZWQsIHZyYW1fbmVlZGVkOwotCXVpbnQ2NF90IHJlc2VydmVkX2Zvcl9wdCA9
IGFtZGdwdV9hbWRrZmRfdG90YWxfbWVtX3NpemUgPj4gOTsKIAlpbnQgcmV0ID0gMDsKIAogCWFj
Y19zaXplID0gdHRtX2JvX2RtYV9hY2Nfc2l6ZSgmYWRldi0+bW1hbi5iZGV2LCBzaXplLAotLSAK
Mi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
