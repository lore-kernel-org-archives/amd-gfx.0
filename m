Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B42C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 01:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE85F206DB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 01:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE85F206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8383589EA6;
	Mon,  9 Dec 2019 01:45:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7563089EA6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 01:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvVI0frV2ysFzEbPVZzWKKGakxSSdlLG2E7VRPLj1uA1dzAO2qX6VGjQzLggFoAY0uKBQEYhvVLmXzKcegIWnlXJDWeRxG38yhG+QPla4pV2SxWSAcgyrD4Y0EuZZbqVq3UOcjiFfOWpYbBDGJuxYuS1uW7Qwo9AYvVKO+vrwSWtqBFLI5jhRewH6OWPQq7TGao+bDuk+VuQDxQd2kjqzLJwttBg2NH1uHQGH5kgDloc9+cV5na/YASa7ES2LtoFCAxktcpkr/oejHzn6g0+8yAV4TAQomt/JHUfb7UXvLEPOGI/7ZDoB5jWmyUy4vxdvTkeMm2LfnqOyfL8sxgPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgO6tCZcam0jB4c7HTkWFAf9wjk1VTLWXmypkW2g1dQ=;
 b=YiWtWkifbu9JSHxl2/sITN3/mFcA5+8L0JAhCHEvFtbdABjsIptb5SXkIZNYMf+pVVbAy5lStP4Hh27+PWy1t73POUrTIZqagjJW0UCJbqguIlGX1Kz/rQq3ScDL4ExfzPHtTPg+UV8V0z6u4JD3ivhnsMoGVlOV5yjDQW3/NlM1rjMfMYIKM8esy8R5bcKrPK2Sg82/blrTMcZ7T5W+PT+agyop1B+NzAV90L+aQV3eXvDbrFoKAeliU2KkUvo1UjBoIHAUEnEoDbVgn6QCb4uKd0tEU44ResWB1CUqyCutN4faMfSHZTpIz80VjFzWUtM8L8vZoJ4vIwl5oc3W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3136.namprd12.prod.outlook.com (20.178.244.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 9 Dec 2019 01:45:32 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 01:45:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Topic: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Index: AQHVq+ZJE1hWgUWOaEOP8kMPy7HFC6etIr2AgAPp7hA=
Date: Mon, 9 Dec 2019 01:45:31 +0000
Message-ID: <MN2PR12MB33442FD59440B428C2F7BFF9E4580@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191206033543.3131-1-evan.quan@amd.com>
 <CADnq5_M+90MX=04BZC5skrjE3pQUVNXmAjEhVxSf6EiNhufYFg@mail.gmail.com>
In-Reply-To: <CADnq5_M+90MX=04BZC5skrjE3pQUVNXmAjEhVxSf6EiNhufYFg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=678e924c-7ce0-4c40-8668-00005a0f569b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-09T01:44:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bec32ee1-35db-4779-762a-08d77c497a4b
x-ms-traffictypediagnostic: MN2PR12MB3136:|MN2PR12MB3136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3136B6C3854BE0649BE56857E4580@MN2PR12MB3136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(13464003)(189003)(199004)(64756008)(66446008)(66556008)(66476007)(99286004)(4326008)(76116006)(66946007)(55016002)(7696005)(76176011)(229853002)(102836004)(45080400002)(5660300002)(6916009)(966005)(6506007)(53546011)(478600001)(52536014)(86362001)(33656002)(305945005)(26005)(8936002)(74316002)(8676002)(81166006)(81156014)(186003)(71190400001)(54906003)(316002)(9686003)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3136;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fn9bdKC9hCMcHW44lpW37je89TzGxb32XjNzQt+0Olzp2NLbW4fUXQNSXOhAv2n3vmQ62HoF0TNbLSG7FJPII6aAbC5D1u5+yFdmaXgHDDDcqoRtph2g4t3mjTsudx7FktUO6iqCPhLMkF35Z5UrKJOnk6XS8zr73MWuMnoMYBdl1HSYhN86lpNe/Vqd9xtwdx7E9sX/Ds0lCWk3Qlkir2aJeiyS9OG+832dBH4/zOYbmjcFgHU5YOS1MVTU7zjsFWmBcj76qPJHK7yW2gMrGyfbxrLSu9CCT4wspa4Awq5+AFHgrn3l4TAqVqWszWIo3RT1Nrg0v9rrcwY2JvHPvi4P5tCu5LByZkaQpcc4sGzWPqk8UoKa2uFC36xmm+LPnNvgVvCaZWtqAr7+GtZsIqY45Xuq4WBCVZRM86oqcC1cu3XEAuu4axYuxH+RjGMiODcF9TknmfCnFtaqEX9eBEgBz1WYAwqmyNXav3r3v78Txy9M5mXwks1v5EFpybOq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec32ee1-35db-4779-762a-08d77c497a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 01:45:31.9998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlhYVfluP80oOiHhMw+502Hx7ApRKiSj0BuqfiwBrNZv4wdqd6Bika7fU0Sq1LeN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgO6tCZcam0jB4c7HTkWFAf9wjk1VTLWXmypkW2g1dQ=;
 b=PlHPR6C2fr44fTSXjqJAJBYMVVJctauwhDhscaKwJA0IPS0spaSLDe3F6teCb3IaQGP0ogY0fzFjWH/fh6dU6e5fJoRrvVs98c8Zpy8ycIvT4yFZmCZ3OvBuLgwPYYDm8ujHa3n7nHx5W+QjiLy5rgMDMyCu6Ofgknhok3o2XL4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzLiBKdXN0IHNlbnQgb3V0IGEgVjIuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgRGVjZW1iZXIgNiwgMjAxOSA5OjU5IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFu
LlF1YW5AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+OyBMdW8sIFpoaWdhbmcNCj4gPFpoaWdhbmcuTHVvQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBjbGVhciBWQklPUyBzY3JhdGNocyBv
biBiYWNvIGV4aXQNCj4gDQo+IE9uIFRodSwgRGVjIDUsIDIwMTkgYXQgMTA6MzYgUE0gRXZhbiBR
dWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIGlzIG5lZWRlZCBm
b3IgY29taW5nIGFzaWMgaW5pdCBvbiBwZXJmb3JtaW5nIGdwdSByZXNldC4NCj4gPg0KPiA+IENo
YW5nZS1JZDogSWYzNjcxYTI0ZDIzOWUzZDI4ODY2NWZhZGFhMmM0MGM4N2Q1ZGE0MGINCj4gPiBT
aWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDYgKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCj4gPiBpbmRleCAzOWVjMDZhZWU4
MDkuLmFiODA5ZGY3YmMzNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9zbXVfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3NtdV92MTFfMC5jDQo+ID4gQEAgLTE2NTksNiArMTY1OSwxMiBAQCBpbnQgc211X3YxMV8w
X2JhY29fc2V0X3N0YXRlKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9iYWNv
X3N0YXRlIHN0YXRlKQ0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9IGVsc2Ug
ew0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSBzbXVfc2VuZF9zbWNfbXNnKHNtdSwgU01VX01T
R19FeGl0QmFjbyk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBXUkVH
MzJfU09DMTUoTkJJTywgMCwgbW1CSU9TX1NDUkFUQ0hfNiwgMCk7DQo+ID4gKyAgICAgICAgICAg
ICAgIFdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJT1NfU0NSQVRDSF83LCAwKTsNCj4gDQo+IFBs
ZWFzZSB1c2U6DQo+IFdSRUczMihhZGV2LT5iaW9zX3NjcmF0Y2hfcmVnX29mZnNldCArIDYsIDAp
OyBXUkVHMzIoYWRldi0NCj4gPmJpb3Nfc2NyYXRjaF9yZWdfb2Zmc2V0ICsgNywgMCk7IFNvIHdl
IGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQgYXNpYyBzcGVjaWZpYw0KPiBzY3JhdGNoIHJlZ2lz
dGVyIG9mZnNldHMuDQo+IA0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgYmlmX2Rvb3JiZWxs
X2ludHJfY250bCA9IFJFR19TRVRfRklFTEQoYmlmX2Rvb3JiZWxsX2ludHJfY250bCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSUZfRE9PUkJF
TExfSU5UX0NOVEwsDQo+ID4NCj4gPiBET09SQkVMTF9JTlRFUlJVUFRfRElTQUJMRSwgMCk7DQo+
ID4gLS0NCj4gPiAyLjI0LjANCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCj4gPiBzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdD
MDElN0Nldg0KPiA+DQo+IGFuLnF1YW4lNDBhbWQuY29tJTdDYzhjYzhjMTBmODFhNDdhNzlmY2Yw
OGQ3N2E1NDZmMzMlN0MzZGQ4OTYxZmU0DQo+IDg4NGU2DQo+ID4NCj4gMDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzExMjM3NTM2OTQ2MjA2MiZhbXA7c2RhdGE9Y01WbkkNCj4gJTJCa1NB
c1cNCj4gPiAxcmt3UGUlMkJwQlBLSFdESVdPRTlCciUyRkRFcFplakVPWkElM0QmYW1wO3Jlc2Vy
dmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
