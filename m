Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD441C33CAA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 07:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A821D21734
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zbY0soYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A821D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501E96EBB7;
	Tue, 21 Jan 2020 07:32:10 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700042.outbound.protection.outlook.com [40.107.70.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD446EBB7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 07:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF3VxBnLLIfZp74J5AnyhA4udRtrzqWnG2WH+0wO55/DrDfkKbjKiAzylArqXSskIp/eghb7aj8ULjiRfL97NUN57OAX+X9HGqkj3Lp0vOhu48IudqWV2yoq5YaCWUVDOkwzSW+HdOcDfTN0tal5bvtHlJ5teylCTsfnbuWCb5+qdIdFvlHdvUWfvUFrGNLQf6ftZyuGHxsKPeOX1HE8elX+0boJoWxBgo8HqClV5sRpc2FvGRNx9b4sYxKMgnmjJ78/qOg3jP9DHR+IY4NKdxMZmBzAPlx5DEVYOr2NSaYu9NJss6aDPKL7yiDuxf/1Xen6DBUxFUEeA+K9Dy9vUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUa88zpeFJZO75ZBXJdj4Zx4bHzUZ5qoShQbSsYtEpQ=;
 b=l4oa/TDqYP/DD8+eS1YSiEWYI3XcD7ph/8h6u4Cf//pAS8G60ShZofRpsfaJFkfJL4kWrEh40E0sVGGQRyT8YML35NJ9ifxhtdKuMYECpVZIYkGaQRmQN7tbwwD3bADKfcorUDeIR0LHzfwIfxiAo/aFTJYaOA96a5/3lOW6YQKuUl6NUsBtb0njlngBPq2XLJW+r2xrnFonc/XY8UqPlsfjir1b42kDMU30N2kE7xwLUI40PT3EN4AoAqUTRYtgDDkFv7KxzQEoroRrpLvUtCj+45kp+055GqAHlPmCGULmgeSrIL1lursLZSjDxqsnPMr89hUdEgzxZat8g47euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUa88zpeFJZO75ZBXJdj4Zx4bHzUZ5qoShQbSsYtEpQ=;
 b=zbY0soYuJ3CMaEigS/8VeWONa0DlhfQ9qmXNB+GjdNV6JQ33/zUQTVLF6ZIZCT4AyXz4d77PzxlqILm2SmBDr56VJqm/Z5eSaMBawaPcSVBAL7lj2szoTJscUosGw9mLZE4Go9g0RJ4XpcsHhvgwGsFPrfFuTWcgCEd9k1YRLzs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1897.namprd12.prod.outlook.com (10.175.91.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Tue, 21 Jan 2020 07:32:05 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 07:32:05 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training(V2)
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200121022206.5223-1-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b4f70898-0d48-f09a-046f-d312082432f6@amd.com>
Date: Mon, 20 Jan 2020 21:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200121022206.5223-1-tianci.yin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0030.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0030.eurprd06.prod.outlook.com (2603:10a6:208:ab::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 07:32:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60633640-df86-4d4f-5466-08d79e44037f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1897:|DM5PR12MB1897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB189758EC8ABE9E0656FC2136830D0@DM5PR12MB1897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(31696002)(16526019)(186003)(6486002)(66574012)(52116002)(2906002)(5660300002)(66556008)(86362001)(66476007)(316002)(66946007)(54906003)(478600001)(31686004)(4326008)(6666004)(36756003)(81166006)(81156014)(8676002)(2616005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1897;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eC8/jQmr4GNTuG54Xy31uqf94XLQPimEq0HrAhGBZByg05qWIH53g3goB4horbjwSusXs+KW0PCAZN76ibjzXi8UgZlA42QE4qPeW1zVl4u8xuTK+jMSZPSXBC/1gFI7WE5M6se3yWLsbrx1sEwrp9R69a42vtwIZPOwlstv069mzrY88IXTR3+W2yF6XL6rdrCOEBag4MZAy+Q1P35YJ8QLEpz0Gs28daGqW2Vl/Im1YJZlZzF4cFQ7i0ik9QoWzHcocfa2m8epX0W7sib6rFcxuAngwFaB57dh6STSN82Rywxd+zKRYCBNgEqiq82la7R2KryXdxHAXqQBKKk0hFcyxpYHOSfkf5Ywp4KuID5/x9IEXG+zCiJQ9f/gdNjbGPid0Z21QnqJp5ptB7NUdr1+6c3hsY5qXjOLYHhL319pTuKO+nHpj9Zjo0Ta6UnB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60633640-df86-4d4f-5466-08d79e44037f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 07:32:05.2964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0uP18t+j2xtDaRDAAYXBntVssZ9sLkh8/BQkXYPb+sroMLCE/QCk0GSZVtTlkch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1897
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDEuMjAgdW0gMDM6MjIgc2NocmllYiBUaWFuY2kgWWluOgo+IEZyb206ICJUaWFuY2ku
WWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPgo+Cj4gW3doeV0KPiBJbiBHRERSNiBCSVNUIHRyYWlu
aW5nLCBhIGNlcnRhaW4gbW91bnQgb2YgYm90dG9tIFZSQU0gd2lsbCBiZSBlbmNyb2FjaGVkIGJ5
Cj4gVU1DLCB0aGF0IGNhdXNlcyBwcm9ibGVtcyhsaWtlIEdUVCBjb3JydXB0ZWQgYW5kIHBhZ2Ug
ZmF1bHQgb2JzZXJ2ZWQpLgo+Cj4gW2hvd10KPiBTYXZpbmcgdGhlIGNvbnRlbnQgb2YgdGhpcyBi
b3R0b20gVlJBTSB0byBzeXN0ZW0gbWVtb3J5IGJlZm9yZSB0cmFpbmluZywgYW5kCj4gcmVzdG9y
aW5nIGl0IGFmdGVyIHRyYWluaW5nIHRvIGF2b2lkIFZSQU0gY29ycnVwdGlvbi4KPgo+IENoYW5n
ZS1JZDogSTA0YThhNmU4ZTYzYjM2MTlmN2M2OTNmZTY3ODgzYjIyOWNiZjNjNTMKPiBTaWduZWQt
b2ZmLWJ5OiBUaWFuY2kuWWluIDx0aWFuY2kueWluQGFtZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBvbmUgYW5kIApS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBm
b3IgcGF0Y2ggIzIuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oIHwgIDIgKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3BzcF92MTFfMC5jICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKystLS0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKPiBpbmRleCAzMjY1NDg3Yjg1OWYu
LjYxMTAyMTUxNGM1MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmgKPiBAQCAtMTcyLDYgKzE3Miw4IEBAIHN0cnVjdCBwc3BfZHRtX2NvbnRleHQgewo+ICAgI2Rl
ZmluZSBNRU1fVFJBSU5fU1lTVEVNX1NJR05BVFVSRQkJMHg1NDUzNDk0Mgo+ICAgI2RlZmluZSBH
RERSNl9NRU1fVFJBSU5JTkdfREFUQV9TSVpFX0lOX0JZVEVTCTB4MTAwMAo+ICAgI2RlZmluZSBH
RERSNl9NRU1fVFJBSU5JTkdfT0ZGU0VUCQkweDgwMDAKPiArLypEZWZpbmUgdGhlIFZSQU0gc2l6
ZSB0aGF0IHdpbGwgYmUgZW5jcm9hY2hlZCBieSBCSVNUIHRyYWluaW5nLiovCj4gKyNkZWZpbmUg
R0REUjZfTUVNX1RSQUlOSU5HX0VOQ1JPQUNIRURfU0laRQkweDIwMDAwMDAKPiAgIAo+ICAgZW51
bSBwc3BfbWVtb3J5X3RyYWluaW5nX2luaXRfZmxhZyB7Cj4gICAJUFNQX01FTV9UUkFJTl9OT1Rf
U1VQUE9SVAk9IDB4MCwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
cHNwX3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwo+IGlu
ZGV4IDY4NWRkOTc1NGM2Ny4uYWMxNzNkMmViODA5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvcHNwX3YxMV8wLmMKPiBAQCAtOTcxLDEwICs5NzEsMTMgQEAgc3RhdGljIGludCBwc3Bf
djExXzBfbWVtb3J5X3RyYWluaW5nX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gICAg
Ki8KPiAgIHN0YXRpYyBpbnQgcHNwX3YxMV8wX21lbW9yeV90cmFpbmluZyhzdHJ1Y3QgcHNwX2Nv
bnRleHQgKnBzcCwgdWludDMyX3Qgb3BzKQo+ICAgewo+IC0JaW50IHJldDsKPiAtCXVpbnQzMl90
IHAyY19oZWFkZXJbNF07Cj4gICAJc3RydWN0IHBzcF9tZW1vcnlfdHJhaW5pbmdfY29udGV4dCAq
Y3R4ID0gJnBzcC0+bWVtX3RyYWluX2N0eDsKPiAgIAl1aW50MzJfdCAqcGNhY2hlID0gKHVpbnQz
Ml90KiljdHgtPnN5c19jYWNoZTsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcHNw
LT5hZGV2Owo+ICsJdWludDMyX3QgcDJjX2hlYWRlcls0XTsKPiArCXVpbnQzMl90IHN6Owo+ICsJ
dm9pZCAqYnVmOwo+ICsJaW50IHJldDsKPiAgIAo+ICAgCWlmIChjdHgtPmluaXQgPT0gUFNQX01F
TV9UUkFJTl9OT1RfU1VQUE9SVCkgewo+ICAgCQlEUk1fREVCVUcoIk1lbW9yeSB0cmFpbmluZyBp
cyBub3Qgc3VwcG9ydGVkLlxuIik7Cj4gQEAgLTk4OSw3ICs5OTIsNyBAQCBzdGF0aWMgaW50IHBz
cF92MTFfMF9tZW1vcnlfdHJhaW5pbmcoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90
IG9wcykKPiAgIAkJcmV0dXJuIDA7Cj4gICAJfQo+ICAgCj4gLQlhbWRncHVfZGV2aWNlX3ZyYW1f
YWNjZXNzKHBzcC0+YWRldiwgY3R4LT5wMmNfdHJhaW5fZGF0YV9vZmZzZXQsIHAyY19oZWFkZXIs
IHNpemVvZihwMmNfaGVhZGVyKSwgZmFsc2UpOwo+ICsJYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vz
cyhhZGV2LCBjdHgtPnAyY190cmFpbl9kYXRhX29mZnNldCwgcDJjX2hlYWRlciwgc2l6ZW9mKHAy
Y19oZWFkZXIpLCBmYWxzZSk7Cj4gICAJRFJNX0RFQlVHKCJzeXNfY2FjaGVbJTA4eCwlMDh4LCUw
OHgsJTA4eF0gcDJjX2hlYWRlclslMDh4LCUwOHgsJTA4eCwlMDh4XVxuIiwKPiAgIAkJICBwY2Fj
aGVbMF0sIHBjYWNoZVsxXSwgcGNhY2hlWzJdLCBwY2FjaGVbM10sCj4gICAJCSAgcDJjX2hlYWRl
clswXSwgcDJjX2hlYWRlclsxXSwgcDJjX2hlYWRlclsyXSwgcDJjX2hlYWRlclszXSk7Cj4gQEAg
LTEwMjYsMTEgKzEwMjksMzggQEAgc3RhdGljIGludCBwc3BfdjExXzBfbWVtb3J5X3RyYWluaW5n
KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCBvcHMpCj4gICAJRFJNX0RFQlVHKCJN
ZW1vcnkgdHJhaW5pbmcgb3BzOiV4LlxuIiwgb3BzKTsKPiAgIAo+ICAgCWlmIChvcHMgJiBQU1Bf
TUVNX1RSQUlOX1NFTkRfTE9OR19NU0cpIHsKPiArCQkvKgo+ICsJCSAqIExvbmcgdHJhaW5nIHdp
bGwgZW5jcm9hY2ggY2VydGFpbiBtb3VudCBvZiBib3R0b20gVlJBTSwKPiArCQkgKiBzYXZpbmcg
dGhlIGNvbnRlbnQgb2YgdGhpcyBib3R0b20gVlJBTSB0byBzeXN0ZW0gbWVtb3J5Cj4gKwkJICog
YmVmb3JlIHRyYWluaW5nLCBhbmQgcmVzdG9yaW5nIGl0IGFmdGVyIHRyYWluaW5nIHRvIGF2b2lk
Cj4gKwkJICogVlJBTSBjb3JydXB0aW9uLgo+ICsJCSAqLwo+ICsJCXN6ID0gR0REUjZfTUVNX1RS
QUlOSU5HX0VOQ1JPQUNIRURfU0laRTsKPiArCj4gKwkJaWYgKGFkZXYtPmdtYy52aXNpYmxlX3Zy
YW1fc2l6ZSA8IHN6IHx8ICFhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcikgewo+ICsJCQlEUk1f
RVJST1IoInZpc2libGVfdnJhbV9zaXplICVsbHggb3IgYXBlcl9iYXNlX2thZGRyICVwIGlzIG5v
dCBpbml0aWFsaXplZC5cbiIsCj4gKwkJCQkgIGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSwK
PiArCQkJCSAgYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIpOwo+ICsJCQlyZXR1cm4gLUVJTlZB
TDsKPiArCQl9Cj4gKwo+ICsJCWJ1ZiA9IHZtYWxsb2Moc3opOwo+ICsJCWlmICghYnVmKSB7Cj4g
KwkJCURSTV9FUlJPUigiZmFpbGVkIHRvIGFsbG9jYXRlIHN5c3RlbSBtZW1vcnkuXG4iKTsKPiAr
CQkJcmV0dXJuIC1FTk9NRU07Cj4gKwkJfQo+ICsKPiArCQltZW1jcHlfZnJvbWlvKGJ1ZiwgYWRl
di0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIsIHN6KTsKPiAgIAkJcmV0ID0gcHNwX3YxMV8wX21lbW9y
eV90cmFpbmluZ19zZW5kX21zZyhwc3AsIFBTUF9CTF9fRFJBTV9MT05HX1RSQUlOKTsKPiAgIAkJ
aWYgKHJldCkgewo+ICAgCQkJRFJNX0VSUk9SKCJTZW5kIGxvbmcgdHJhaW5pbmcgbXNnIGZhaWxl
ZC5cbiIpOwo+ICsJCQl2ZnJlZShidWYpOwo+ICAgCQkJcmV0dXJuIHJldDsKPiAgIAkJfQo+ICsK
PiArCQltZW1jcHlfdG9pbyhhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkciwgYnVmLCBzeik7Cj4g
KwkJYWRldi0+bmJpby5mdW5jcy0+aGRwX2ZsdXNoKGFkZXYsIE5VTEwpOwo+ICsJCXZmcmVlKGJ1
Zik7Cj4gICAJfQo+ICAgCj4gICAJaWYgKG9wcyAmIFBTUF9NRU1fVFJBSU5fU0FWRSkgewoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
