Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D250C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5258D2072E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x7MKC36N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5258D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D62C89C99;
	Mon,  6 Jan 2020 19:16:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEF389C99
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 19:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cyc3hF1H8wgCQiSH5NQvRUpyBryTrjYvxt6sXAZa3pkPQQ/dBby5zyazgxHaNHPWu7ZUAg+H17nWp3AvL/91422txgezGEl4An2Cyl9QoGv8ej6I0H+xnJPaQhPzxFYk23oDl3BZ34ayOJDpFR+rMSmJqYzzNwucxFtCtFc9MycMi08lNSpCyf51gRCG+AMWKurY7NXXPqX28hwqnVhV8ujTTtYF2iESdxI0CYmBXFZMyg52Hpsuo1I2mtePWN5IgKIcPFejdPqDc7hhaWVywhzvaLBKRHR7NqaGFhQ1Xi7SkrrMtAovskY7X0oVp6gje9KTRV0dEHTzEenXF6THnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlRuu4f0DLNf7MmynpSDdNc9FJkOSpONGc4b4PsGVCo=;
 b=i9kxgBdAfo1Ttfk+eiDZ0hJYFPggti3NP8Set7JM+40RpuJtRlW5e3XdMQpMRHFwOZwGFy/ZnV2IhvAiSz5xfGkgerHM8J6Zfkdli924+JwxrHygL9fiINAkRxrImrKARqD/8qoxjvPqzZkUnvUtO1KNs+ZyOtQTn1v6r6o7YuSD8HhTpQtxoT2IR/EA2Ffum5c8bOod5gcGRnE1C62RuiKPBE9x8Qo/QBJ/fYNdJ+NpsHObabqcgTgAKBHRvbG3QfYQbf1rjxv+x89Od6S/eeawXXQugv8Si/SwCrhdiY9t0LHmpFbSwTNXq0imESRQtSL3xnATLXpg1UgHDSG/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlRuu4f0DLNf7MmynpSDdNc9FJkOSpONGc4b4PsGVCo=;
 b=x7MKC36NiANTPLAyk4Z/b0Agtqn0gSd8pYgd4q/LBdRj2ksmiDeXf4xdXexQwz5BmKEipPwnsDqPHVAhEqKMW45qBZCcx0oPDwCBNgJ8k00SmNPczySK84x/kSnLiXCU+Ycsu1tgespIfqjKOkJWdMQLNG2l1wLX4QtlR5qmwuw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (10.174.105.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Mon, 6 Jan 2020 19:16:34 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 19:16:34 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: use common invalidation engine
 helper
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200106183506.692030-1-alexander.deucher@amd.com>
 <20200106183506.692030-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <d3d6accb-bc1b-5543-219a-2dbdcedfe997@amd.com>
Date: Mon, 6 Jan 2020 14:16:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200106183506.692030-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 19:16:34 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 982dce44-244d-448a-6217-08d792dcf1d4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:|DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00253D7ADC6BAC823A734BB3923C0@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(8676002)(6486002)(81166006)(81156014)(8936002)(2906002)(2616005)(66556008)(66946007)(956004)(5660300002)(66476007)(31686004)(16526019)(36756003)(16576012)(4326008)(316002)(36916002)(86362001)(31696002)(52116002)(44832011)(53546011)(26005)(186003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0025;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXR2lVFgLWkM7f8Mrof90WVGj3NX0JZPpdnkgXZMfof/OpuHxmooZjzWR4VIp7jWlNxUxcQozkq7cN11rZpRvBN7I8WOCnG9mA/oh6RI3oUtXkkQ79tqoZGC0r/tVjyiJc4t1IUDo7xb9/fZcRb+5bplQjuPQkH+ITkjsmbUZoA861NHUy9pMLNsNTsr0Xp6DGP6Imetq+e1oTCXJVT9T3HoYHEkCYWzd3suoz+YJstDnROB5lpH96u6ep1N87RbP+pN8TAA/56B4K5NEuCFCCxrBubIGsmYDPbm0DwsTB3ThbxccExmbwwlQez/rreGoSeuwQdVELGf8oJriYFR0VOZkqCZeKJabl4TEOFQIV8NRWrruLMGOhnT9WVziG8rFj0Qs91HejJ6/OLtKArrg5ZdBI1WWdPYCr9b5h803ijoJupwfKzrjjX35GgfZyXj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982dce44-244d-448a-6217-08d792dcf1d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 19:16:34.5611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH4ZRKBMelT47w2yKKZ5KV9IjUSeEDuXnj9vWhiMOGGhZAdbBGiUqyhg3dt+R35e+H8+h6UoUD0PSCD2xYSU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBpcwoKQWNrZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgoKSSBkb24ndCByZWFsbHkga25vdyB3aHkgdGhlIG1hc2sgd2FzIGRpZmZlcmVudCBv
biBHRlh2MTAuIEkgc3VzcGVjdCBpdCAKd2FzIGxhemluZXNzL3NpbXBsaWNpdHkgb2Ygbm90IGhh
dmluZyB0aGUgZ2FwIGF0IGVuZ2luZXMgMiwzLiBJZiB3ZSAKZG9uJ3QgaGF2ZSBhcyBtYW55IHJp
bmdzIG9uIEdGWHYxMCBBU0lDcyB3ZSBwcm9iYWJseSBkb24ndCBuZWVkIGVuZ2luZXMgMCwxLgoK
UmVnYXJkcywKIMKgIEZlbGl4CgpPbiAyMDIwLTAxLTA2IDE6MzUgcC5tLiwgQWxleCBEZXVjaGVy
IHdyb3RlOgo+IFJhdGhlciB0aGFuIG9wZW4gY29kaW5nIGl0LiAgVGhpcyBhbHNvIGNoYW5nZXMg
dGhlIGZyZWUgbWFza3MKPiB0byBiZXR0ZXIgcmVmbGVjdCB0aGUgdXNhZ2UgYnkgb3RoZXIgY29t
cG9uZW50cy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KPiAtLS0KPgo+IFdlIGFsd2F5cyBzdGFydGVkIGF0IGludmFsaWRhdGlvbiBl
bmdpbmUgNCBvbiBnbWMxMC4gIFdhcyB0aGVyZSBhCj4gcmVhc29uIGZvciB0aGF0PyAgSSB3b3Vs
ZCBoYXZlIGZpZ3VyZWQgaXQgd291bGQgZm9sbG93IHRoZSBzYW1lCj4gbW9kZWwgYXMgb2xkZXIg
YXNpY3MuICBJIGNhbiBtYWtlIHRoaXMgbW9yZSBmbGV4aWFibGUgaWYgc28uCj4KPgo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgIDIgKy0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jICB8IDE5ICsrKystLS0tLS0tLS0tLS0tLS0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBpbmRleCBkNjkwMWIyNzQ3
OTAuLjU4ODRhYjU5MDQ4NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ21jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMKPiBAQCAtMzM1LDcgKzMzNSw3IEBAIHZvaWQgYW1kZ3B1X2dtY19yYXNfZmluaShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIH0KPiAgIAo+ICAgCS8qCj4gLQkgKiBUaGUgbGF0
ZXN0IGVuZ2luZSBhbGxvY2F0aW9uIG9uIGdmeDkgaXM6Cj4gKwkgKiBUaGUgbGF0ZXN0IGVuZ2lu
ZSBhbGxvY2F0aW9uIG9uIGdmeDkvMTAgaXM6Cj4gICAJICogRW5naW5lIDIsIDM6IGZpcm13YXJl
Cj4gICAJICogRW5naW5lIDAsIDEsIDR+MTY6IGFtZGdwdSByaW5nLAo+ICAgCSAqICAgICAgICAg
ICAgICAgICAgICBzdWJqZWN0IHRvIGNoYW5nZSB3aGVuIHJpbmcgbnVtYmVyIGNoYW5nZXMKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IGluZGV4IGY1NzI1MzM2YTVmMi4u
ZGE5NzY1ZmY0NWQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192MTBfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMK
PiBAQCAtNTY0LDIyICs1NjQsMTEgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCj4gICBzdGF0aWMgaW50IGdtY192MTBfMF9sYXRlX2luaXQodm9pZCAqaGFu
ZGxlKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICopaGFuZGxlOwo+IC0JdW5zaWduZWQgdm1faW52X2VuZ1tBTURHUFVfTUFYX1ZN
SFVCU10gPSB7IDQsIDQgfTsKPiAtCXVuc2lnbmVkIGk7Cj4gLQo+IC0JZm9yKGkgPSAwOyBpIDwg
YWRldi0+bnVtX3JpbmdzOyArK2kpIHsKPiAtCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBh
ZGV2LT5yaW5nc1tpXTsKPiAtCQl1bnNpZ25lZCB2bWh1YiA9IHJpbmctPmZ1bmNzLT52bWh1YjsK
PiAtCj4gLQkJcmluZy0+dm1faW52X2VuZyA9IHZtX2ludl9lbmdbdm1odWJdKys7Cj4gLQkJZGV2
X2luZm8oYWRldi0+ZGV2LCAicmluZyAldSglcykgdXNlcyBWTSBpbnYgZW5nICV1IG9uIGh1YiAl
dVxuIiwKPiAtCQkJIHJpbmctPmlkeCwgcmluZy0+bmFtZSwgcmluZy0+dm1faW52X2VuZywKPiAt
CQkJIHJpbmctPmZ1bmNzLT52bWh1Yik7Cj4gLQl9Cj4gKwlpbnQgcjsKPiAgIAo+IC0JLyogRW5n
aW5lIDE3IGlzIHVzZWQgZm9yIEdBUlQgZmx1c2hlcyAqLwo+IC0JZm9yKGkgPSAwOyBpIDwgQU1E
R1BVX01BWF9WTUhVQlM7ICsraSkKPiAtCQlCVUdfT04odm1faW52X2VuZ1tpXSA+IDE3KTsKPiAr
CXIgPSBhbWRncHVfZ21jX2FsbG9jYXRlX3ZtX2ludl9lbmcoYWRldik7Cj4gKwlpZiAocikKPiAr
CQlyZXR1cm4gcjsKPiAgIAo+ICAgCXJldHVybiBhbWRncHVfaXJxX2dldChhZGV2LCAmYWRldi0+
Z21jLnZtX2ZhdWx0LCAwKTsKPiAgIH0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
