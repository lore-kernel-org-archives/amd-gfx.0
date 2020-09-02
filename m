Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A41C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C7020767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tw9tXb2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C7020767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9CE6E4BA;
	Wed,  2 Sep 2020 13:02:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D9F6E4BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 13:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvAdUAEcTbabMkDayL5KthQb5AqPaCwrXHJWeUvJ/EeZEz2QXPb1i1e3SLfTDN8GZMXkFLUS1YYXpQId0dWb/xlLaEwKbfjq9G6NQeTleXQOh/Dw0/83I61gZtDRi+jy9CJRPnKilw5Gk070MAAsQWHqYncQ+tuQ2qz9McvypoI/O7zD+9bxNCFULiS5KTCJK7jqCuwmkDFqad/6KJhjNDXQfXayFBLdMZRIJUlEK4GnMRtgTJ2BPexXElhzmsTTrMmJNA5S1BPCtwr3MwZRT8OzrHqj6ZG7ioHKDdledCJe7g5ijBACnYzFKLm1zYJUqyCLrWPABNXMfgoe7rS7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GLRKa0CMSKM1WnGeSewmKU8Scd3U/ahfFVHiJg0RU=;
 b=IkUx0mjSliQwvyrX1PaPUDUcpBpslxqsts4gA/VQ2F+HTeGI0jHoS4zfOTHfOPJImeXkq4WhBm14KzaBSEx3C0VjhWTCiG/L6eXmH8NPPqqIycQaeNuoz/pC2jRvK8LymksvODRmsNSk4own3OR9hm3DgsW8S3gAcjsFtVn78G00owRrrV0RC+EWkDtwN5ko7XeFJWbKNgtwvsuzUoJUX4dGC7NpdFbWH7f+ugLy0J4lPEGNCfq3TDGvzYv4yRukx8Ksyr5o0GtFrixSLR60ZgPJS/KNtmVefQ/lG6TZ1KiXG7SybQFBzzo5sm5ejshT/nC4fw8zh0H8tCW2CXogqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GLRKa0CMSKM1WnGeSewmKU8Scd3U/ahfFVHiJg0RU=;
 b=Tw9tXb2/W4aS2F1yXg9AWx4ylF47XD0bYiGoZCYOTJt9RUf7o5OWmXZo5byj7GH2X9uiTVUGEuNTrh3+m5RpX7olFMRobM4j5kJPhK2Hi0o3e3qTR/edX+dqmBs0BQclO6o5xby5HX2yZo8DO7GVa/BgJCbdHVVN0mvU1lkwSa8=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 13:02:39 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 13:02:39 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation
Thread-Index: AQHWgSFt5UBymSTD/E+wKYXXCRwzJalVUGcA
Date: Wed, 2 Sep 2020 13:02:39 +0000
Message-ID: <BFD95252-9F9E-431A-8284-4751698332DB@amd.com>
References: <20200902120557.2229-1-christian.koenig@amd.com>
In-Reply-To: <20200902120557.2229-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dc4418d-30c5-4bc3-d438-08d84f407897
x-ms-traffictypediagnostic: SA0PR12MB4527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB45272ED169C15EB19566A34F872F0@SA0PR12MB4527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8iqaHWiEC4C1478H+3hYLQO+yj9CLyH4PbJ7mKqB7hTbRw9qUs6OdwNcg3TwMWrHmAdMVYvNITD4QQ2XTSaFfJuwww3fLYgk2gh+c21cQGKqAiQm9yiWN7CwVEOV5SpWEyPr2LB4oBnbLb2GuUfPyc9O42cZZmVOztFaOqw6WgkydcDSD1OwWdR7e9H3sOkcoU7W9IkoKHivBOcwPi2dVNYw2nTYy+mOuueRhjWyiWYgwl0Pc+pmm/+cLaQoWhIrctEwc2wls46O1KgtiSCfy/BRLJmnIS7oWrV3jZrsfvqJs/xpDsWFiCceMf3VM3sDTBuA0gtnXeR6EZ3C5s9NA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(2616005)(4326008)(6512007)(6506007)(316002)(66476007)(6486002)(66946007)(66556008)(71200400001)(76116006)(33656002)(64756008)(91956017)(5660300002)(66446008)(26005)(86362001)(83380400001)(8676002)(66574015)(36756003)(6916009)(2906002)(478600001)(54906003)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: su+KwybpkLPY1lcYOUeJ7UVT7AjEuZXGtOLBVDk0hpjOohOeCa9OUnY2zXzGUQ0gs7x3yCB9sOn66FsxGjzWdSkk2jlSd4pIFZeiTq4HKCfzfV5ldCeD36dOCWQ9D3cBDIxbSCPsH4otnwRTWzkP8SIw6ZpTtXgnLGrLodULKSAoYQGMB9mTheFMgieQ9ljbUD7fju/C3geiTBdLIPCLMFuHuQbGPc3hSdaenLhSpzizQCFxZaCOVQGw10EEE4dsyugMePbDqxASdlGp6+mnm8IJghiSlokQbxqwr+vNPUtkeaPx9mJqIRrfjsTvDHhsvKlazUe5yBSJa4gXsmUOmhHzuLtRdlGuUCmMgkuhRF3k3/7yLNgPTSwS9QUXvxb9nWDQ0VXi/fx2BNjlkXgXzDu7Vn1bJS3UNkRv51kcXT6i6U6qh7k/7575ho/IAEkCfgOZ+r8QuwSB/DkA/jA1ZdnOsfSGMS1vguxIRmhhSiEEYSEPyOe94dHy7tffnHqn+KTAm/Q06qlBJ+FBUOTMWjHT3607WOJPn6iqAaIQRxcycH1SBr6qdMHmuDm2la/L9iHfk6siQJc1CHHpM3WqVJpYSlS1/jZO6gRVnZzUEScy4Fgt30SBVt8j1bxIOUUJzRRPltPR+Yj/abK/Q5RkbA==
Content-ID: <C3E01D33F659EE42A2515533205FDD4B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc4418d-30c5-4bc3-d438-08d84f407897
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 13:02:39.1223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0WUJngqK8n3nW7SQWXG52x4OkzPTV6t+gI0I7F4wxSM+63XLFROKM3v2FPRuEif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDnmnIgy5pelIDIwOjA177yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gQ2FsY3VsYXRlIHRoZSBj
b3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBydW4gYWZ0ZXIgdGhlDQo+
IHBhZ2VfYWRkcmVzcyBhcnJheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gRml4ZXM6IDFlNjkxZTI0NDQ4NyBkcm0v
YW1kZ3B1OiBzdG9wIGFsbG9jYXRpbmcgZHVtbXkgR1RUIG5vZGVzDQo+IC0tLQ0KPiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDMgKystDQo+IDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IDhiYzIyNTM5MzliZS4uOGFhOTU4NGMxODRmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtMTY5Nyw3
ICsxNjk3LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7
DQo+IAkJfSBlbHNlIHsNCj4gCQkJYWRkciA9IDA7DQo+IC0JCQltYXhfZW50cmllcyA9IFM2NF9N
QVg7DQo+ICsJCQltYXhfZW50cmllcyA9ICgobWFwcGluZy0+bGFzdCAtIG1hcHBpbmctPnN0YXJ0
KSA+Pg0KPiArCQkJCSAgICAgICBBTURHUFVfR1BVX1BBR0VfU0hJRlQpICsgMTsNCg0Kc2hvdWxk
IGl0IGJlIGxpa2UgYmVsb3c/DQptYXhfZW50cmllcyA9IChtYXBwaW5nLT5sYXN0IC0gbWFwcGlu
Zy0+c3RhcnQgKyAxIC0gcGZuKSAqIEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7DQoNCmxh
c3QgYW5kIHN0YXJ0IGFyZSBhbHJlYWR5IHBmbnMuIHdoeSBzdGlsbCA+PiBBTURHUFVfR1BVX1BB
R0VfU0hJRlQ/IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQoNCj4gCQl9DQo+IA0KPiAJCWlmIChw
YWdlc19hZGRyKSB7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
