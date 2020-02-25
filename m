Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31B1C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F682082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1nbwndXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F682082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A816EB45;
	Tue, 25 Feb 2020 17:01:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E65B6E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 17:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feincd2sbU+TxGaVOVeDGyppdbmmLf3bvJ2OFpQft4sCcgsee+CRPM2GVPmgigbAVzeEeJp7xyKa1n1C3O3UKJOndUXHo8s6vZ4MAYjzB3mpGxKNouGJpV4pDebGw0zolqWtAJayp995drgHR9LiDMgoaixo721gDIWfq7OWCRbI6M78W149fHM0xcUOCLkEnj4xcAHx/j/+CLUnQ9uEm3SZ0flxTADet/jji/hr0rkeVngIvI1pf7JXPARqV/EbzjKeIMX9dAgrx4ndmYHfviNjqRHDy2zdYbfrVS4gxAXY2ABNIuMN6Ww2CQxynH+ga6nHc9xzGCstW4abN6h57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic2Eheb4mB5k257wElc5MkDAUvER7sXSX2aNbwqBFTs=;
 b=gFzBRS09Ry8bHWbbI/rp9hwimyzknER6XEyoO8JzYMqMokh4jhen1AkWdJzFOILgCUevXUGxFzydwCOGskjPWkMKRxGZj54FsxzOieRlEYRIiXGHZQfG0Xeeu6D4l07LW3CCiNv/k7wjaT4ef7E+HKI8ce2RWa/wOUvGlCgbWasE0tmlncXvonEM+1PPCMv/PdJgexub4CtL1ljuMUqVqX+dPYNkY+C/0UO2B3PsR5CZjGWgEAh+t7K7Yx2L8Us7foMTgzyBn/biQIGdLbJKj0OXw6KRTloicXQb1yTFpUj4VyuryoBxHfXONn7VipMiagS9kJWzfxA8nIzHNlwuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic2Eheb4mB5k257wElc5MkDAUvER7sXSX2aNbwqBFTs=;
 b=1nbwndXfGJ+C+ReSSpYYq4XoX53/SsbPEGIDF9/Ibu6MIczg/cSleB4yDL8864XXezKuozGpR8Dgx5534KWJnWR1FnJ94I1EmV9G1C19PXmylKrOouHkgc3YkM6uPqMj2KWrUeG/Qov4/fVAFoV458lPsn5FUeixtfC8HY/E0cw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 17:01:52 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:01:52 +0000
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tom.stdenis@amd.com, luben.tuikov@amd.com, Marek.Olsak@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219150251.123917-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fff826e7-bc6c-7387-43b7-c268862341fa@amd.com>
Date: Tue, 25 Feb 2020 12:01:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200219150251.123917-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: DM6PR14CA0051.namprd14.prod.outlook.com
 (2603:10b6:5:18f::28) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.50.63.88] (104.129.159.211) by
 DM6PR14CA0051.namprd14.prod.outlook.com (2603:10b6:5:18f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 17:01:49 +0000
X-Originating-IP: [104.129.159.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3f0cb3e-0ba8-4d06-5964-08d7ba146937
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:|DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490718C0C076F39AC5715DA92ED0@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(44832011)(66574012)(478600001)(31696002)(36756003)(66476007)(66556008)(31686004)(66946007)(2616005)(16576012)(6486002)(2906002)(6666004)(26005)(5660300002)(15650500001)(8936002)(316002)(81166006)(8676002)(52116002)(53546011)(16526019)(86362001)(956004)(186003)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2490;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQIdyLIacQoqhGL5p3PvDDc7bMQyFyNm5QPOiQ2Q6kTWB4QeGgdco9P1HZdGAO4li4Waoi64FNBJt7OqfWyHBfqyyGrq8yCP2p19XP0d+87QWX8etqQqC415y7BqnbRY1JFUb3Opy6FM9Eqvoh7H6y2yuwWL9cM58zPnEC3YdsxpwsnXlvkGGIc+ssvt+8foPVh//A9hjSZ1Ev89fLLpruZL704E6pboMVbFcU7WJr9Yr+M9qCc2Wlb/SsdRblJN6MtWemPlDS5tHn158I+K9qbZOOEEDTALxP/mwmgpKZSW02yKqljkBR2D8ZZ9GojOo+Q6s28vcOkXIi1nY7SQbmx4NNmB9PhRDJRaCdxWRyFm4wHfYeDFh2uFz8zrtal1R83Fcwwj8p0ZgGL4I1swpaCipS0veIeVHxOOYov3xX4FZQJYeQOrrtlOo+s67QZo
X-MS-Exchange-AntiSpam-MessageData: KehokdfX9tkBZWexb08hOyeg+MB1HMdeUrUkJZ4vLdHpT6tlkAnAk5JHV3ol4Dg2rfWziQw/fpRe6pG7dgUxfRgtFmmrTuQnYi7XNasTMg+Q62QvJixEuOVOIQlQ0aOWNmSJUvx2UHjMxsfmgHxf5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f0cb3e-0ba8-4d06-5964-08d7ba146937
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 17:01:52.6640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRVEHZ2wlbRqdTMN9/VesoVYh5pTJRO5/nFgE5Pao/+Nvnjvo5LHK1fB5jo62OuY87seLZGuTeW3wt1PFrPU7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0xOSAxMDowMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBZGQgdXBkYXRl
IGZlbmNlcyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBwaW5nIEJPcy4KPgo+IE90aGVyd2lzZSBQ
RHMgZnJlZWQgZHVyaW5nIHRoZSBtYXBwaW5nIHdvbid0IHdhaXQgZm9yCj4gdXBkYXRlcyB0byBm
aW5pc2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0aW9ucy4KPgo+IHYyOiByZWJhc2VkIG9uIGRybS1t
aXNjLW5leHQKPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KPiBGaXhlczogOTBiNjljZGM1ZjE1OSBkcm0vYW1kZ3B1OiBzdG9wIGFk
ZGluZyBWTSB1cGRhdGVzIGZlbmNlcyB0byB0aGUgcmVzdiBvYmoKClJldmlld2VkLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxNCArKysrKysrKysrKystLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGQxNjIzMWQ2YTc5MC4uZWY3M2Zh
OTRmMzU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAt
NTg4LDggKzU4OCw4IEBAIHZvaWQgYW1kZ3B1X3ZtX2dldF9wZF9ibyhzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSwKPiAgIHsKPiAgIAllbnRyeS0+cHJpb3JpdHkgPSAwOwo+ICAgCWVudHJ5LT50di5ibyA9
ICZ2bS0+cm9vdC5iYXNlLmJvLT50Ym87Cj4gLQkvKiBPbmUgZm9yIFRUTSBhbmQgb25lIGZvciB0
aGUgQ1Mgam9iICovCj4gLQllbnRyeS0+dHYubnVtX3NoYXJlZCA9IDI7Cj4gKwkvKiBUd28gZm9y
IFZNIHVwZGF0ZXMsIG9uZSBmb3IgVFRNIGFuZCBvbmUgZm9yIHRoZSBDUyBqb2IgKi8KPiArCWVu
dHJ5LT50di5udW1fc2hhcmVkID0gNDsKPiAgIAllbnRyeS0+dXNlcl9wYWdlcyA9IE5VTEw7Cj4g
ICAJbGlzdF9hZGQoJmVudHJ5LT50di5oZWFkLCB2YWxpZGF0ZWQpOwo+ICAgfQo+IEBAIC0xNTkx
LDYgKzE1OTEsMTYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCX0K
PiAgIAo+ICsJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+ICsJCXN0cnVjdCBhbWRn
cHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOwo+ICsKPiArCQlpZiAoIWRtYV9mZW5jZV9p
c19zaWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQo+ICsJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwg
dm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPiArCj4gKwkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFs
ZWQodm0tPmxhc3RfZGVsYXllZCkpCj4gKwkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFz
dF9kZWxheWVkLCB0cnVlKTsKPiArCX0KPiArCj4gICAJciA9IHZtLT51cGRhdGVfZnVuY3MtPnBy
ZXBhcmUoJnBhcmFtcywgb3duZXIsIGV4Y2x1c2l2ZSk7Cj4gICAJaWYgKHIpCj4gICAJCWdvdG8g
ZXJyb3JfdW5sb2NrOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
