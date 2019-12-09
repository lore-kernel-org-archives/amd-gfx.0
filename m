Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4488C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79290206E0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79290206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E22889AF3;
	Mon,  9 Dec 2019 21:25:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E89989AF3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 21:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIUPOQd+bcoOFw7ZgzochhQEyHPMopb6PwjyAPQEpcMAarmEePShe6nfxgx4PoBTBbhyKpf9OtkTP0adD6vf947N8hFeKe5UT4awYcVbBi1pja0KIgO5MFzq3Qi4g8cCD9eI5qO1Ij3pYjidWWVesy8QuMBUCRrhkGc5S+YjNdRJiwJhItQdcVKPHHvkfj+25bVBe+ezLuwU+Nw4JN02au9ZGF7vTQpThyUWDz46Igo/d4X1tl4JMfNU3XBmCzWuN8Ni/ThlFC+PRQ/yGksFeCD9hDLHdn73v/vWCsonwg3GZ+B3qjJ/e9jctHwl8W2IsOj8/GiqgJ4uAbtzTx3m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJkYaQClmfrYIUgY5G/WTz7r/U7Ser/snpGlk0I5umk=;
 b=SbxYlINr0zkPnuBHqlEA/oNp3mETESJrtnO09Zt1mVfQwEHzte0MYY3+EAvk18VwP0g9xyon376VhhcYIUlf28Gq8dVgvf70IxdK3W5U6D5cCbTyMIxOzPM+LXVqdVphqewbD87bodtZHHLp6SvpvhCbq9O8v3ZqQHamAshK3fmHLlJP6K2SGlXCf8PqvEdPN+dUgn9VF7ZLdbtwcfTy7ebVxtV5xKi8svU1I+2wiACrb3aMV52qiN97+tY9vR9A+jiktlIrwau5u64W6aNugz38gc/UW1KRQcK6Lsd8vMuHyiqlZPB70Kxk2bIb70CjyOHQ+wEpA7U6B1wwtBbS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1528.namprd12.prod.outlook.com (10.172.67.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 21:25:01 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:25:01 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix VCN2.x number of irq types
To: amd-gfx@lists.freedesktop.org
References: <20191209211048.6937-1-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <453ef488-b0af-f77f-8656-fc76a33a6052@amd.com>
Date: Mon, 9 Dec 2019 16:24:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20191209211048.6937-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95af89ce-a96d-40f3-b9bc-08d77cee3fec
X-MS-TrafficTypeDiagnostic: CY4PR12MB1528:
X-Microsoft-Antispam-PRVS: <CY4PR12MB152891630B1787C3DFABDAA2E4580@CY4PR12MB1528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(52116002)(230700001)(6512007)(229853002)(316002)(6916009)(31696002)(53546011)(36916002)(6506007)(2616005)(478600001)(8936002)(66556008)(66476007)(2906002)(36756003)(5660300002)(8676002)(81156014)(31686004)(81166006)(305945005)(66946007)(6486002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1528;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4Y+H9VhTqx36FdRQCI6yRiCKrjt6GbvT6igwX+9HYVN24cpg0dagkvy9pVbNvhKup0MAMwZmkkUte1HIv3PI27lyLYULo77Z30kPKe5HcKI0LYWkeqVohlL75pGbV90cBySi0tbMeA7Nq7uVRWFKhjMAP49TJbqudbDdn1dqXshxLjM0wKmXakLBq8OBklgPPzDFJjadH1UHp5ZXyWlU5otbvDK+LcurnKly1GIhRqnH4qn50PajNKxaPJiPP7feqBb7nLGMidXQA2bc4DFQoqIpAdcb2HLCqyr7MXdWzHgxVkytovd47msjdpaXeFPzrJDjkxGqmYI3p+0cuwWMwyRFE2YNZEFjtRtXOWPSIm7aFgafbbE2Z0yarhQ+F8YPdXZYufI4LZ4GJA7H1XN2k0xZKiejvMUVzWF4w0j/PpGsNg14E9QDRJU919U1rg2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95af89ce-a96d-40f3-b9bc-08d77cee3fec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 21:25:01.4782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz0U7SQr/vaPC8dIHfi4O3z7xXGPqoEw8QS7QWKiNkz1GL0H12QKoGyQ2uKej9JH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJkYaQClmfrYIUgY5G/WTz7r/U7Ser/snpGlk0I5umk=;
 b=Ekhsa2mvLrAnqpCl6Bq+Yfc3zQgg4TsfXb4Gb0MiJdTgp5aro++nOHggI011gN4+zA1D2peS30gEKMqJxlYO3TSkjQEjPRyN+ln89TtjdTwkc7QqRIFXhxBoWk9nG8zXeFOfxLAd/Nhirtz3s9vp0/Tog6/VjPvEqyATh/XZcLQ=
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+IGZvciB0aGUgc2VyaWVz
CgpPbiAyMDE5LTEyLTA5IDQ6MTAgcC5tLiwgTGVvIExpdSB3cm90ZToKPiBUaGUgSlBFRyBpcnEg
dHlwZSBoYXMgYmVlbiBtb3ZlZCB0byBpdHMgb3duIHN0cnVjdHVyZQo+Cj4gU2lnbmVkLW9mZi1i
eTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YyXzAuYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92Ml81LmMgfCAyICstCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92Y25fdjJfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYwo+IGlu
ZGV4IDU2NDkxOTBjYjYyOS4uZDc2ZWNlMzhjOTdiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjJfMC5jCj4gQEAgLTE3ODgsNyArMTc4OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgYW1kZ3B1X2lycV9zcmNfZnVuY3MgdmNuX3YyXzBfaXJxX2Z1bmNzID0gewo+ICAgCj4gICBz
dGF0aWMgdm9pZCB2Y25fdjJfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+ICAgewo+IC0JYWRldi0+dmNuLmluc3QtPmlycS5udW1fdHlwZXMgPSBhZGV2LT52Y24u
bnVtX2VuY19yaW5ncyArIDI7Cj4gKwlhZGV2LT52Y24uaW5zdC0+aXJxLm51bV90eXBlcyA9IGFk
ZXYtPnZjbi5udW1fZW5jX3JpbmdzICsgMTsKPiAgIAlhZGV2LT52Y24uaW5zdC0+aXJxLmZ1bmNz
ID0gJnZjbl92Ml8wX2lycV9mdW5jczsKPiAgIH0KPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzUuYwo+IGluZGV4IDQyZDZiOWYwNTUzYi4uZjY3ZmNhMzhjMWE5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCj4gQEAgLTExMzgsNyArMTEzOCw3IEBA
IHN0YXRpYyB2b2lkIHZjbl92Ml81X3NldF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkg
ewo+ICAgCQlpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCj4gICAJCQlj
b250aW51ZTsKPiAtCQlhZGV2LT52Y24uaW5zdFtpXS5pcnEubnVtX3R5cGVzID0gYWRldi0+dmNu
Lm51bV9lbmNfcmluZ3MgKyAyOwo+ICsJCWFkZXYtPnZjbi5pbnN0W2ldLmlycS5udW1fdHlwZXMg
PSBhZGV2LT52Y24ubnVtX2VuY19yaW5ncyArIDE7Cj4gICAJCWFkZXYtPnZjbi5pbnN0W2ldLmly
cS5mdW5jcyA9ICZ2Y25fdjJfNV9pcnFfZnVuY3M7Cj4gICAJfQo+ICAgfQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
