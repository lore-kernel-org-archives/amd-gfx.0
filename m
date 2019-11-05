Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AACC5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25696214B2
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 23:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25696214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D306EB8E;
	Tue,  5 Nov 2019 23:48:32 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680077.outbound.protection.outlook.com [40.107.68.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ECB6EB8E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 23:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdPTVUMpmY0zlwwKe0y3g62Ss/NUNXS8ttws0wyie8RtLcsDy6LtwLOQ45GeMKw/p9GstZb0BkR/Uzxy3dTDynUTzmm3qC15Plzxu11ORc7yRnYj2Cd8qF6C0jxa64MQTcabG7Ia00Hfh+VlU9Kpwk+D2jqlqBhG4pJZO5BCYzVaXMgjvWbI1sKSMRxFWJ1mq9QFFvPLs/gAOCeflHOqewioYIUNUpRGpvkt9Wu5c6zahNXqVeeE+z3oOHbs8dEgVugx9AgCKvmY3I+0L/pgebNhRPX+InF0GbZY2vbuv5fZvRqLaYGc6CU72BWuFZGynpbcDJw1WPHlGYRn5N5fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrrREc6daUDN+CNuO9XSQhRHH5z1PFEUS9E+ZVLwI+w=;
 b=BVeWNcKeRsREEX4SI4Ha9nL9Gt1GSqY4jRXCBRLKcE3UTrB+rUP4dpzPibHpqm1ye4J9DewI4g424Ig3NYB5/1ygrvvZ8iceHvW5KqFslQqRmB3F2V/KEz4polqA14Lk9/EzKxNM74vUlLM7RiwwbQAFd96qa6FfmmEXzxzQTh4K8cwG/OENv/lm+yE+vyQ6oaDuLlQRgreeDmJVSfVGwwD/Jfq0nl1LyBzQP1QZUUxcHVeBCKTdYOXOaupJF8MSvHJnMkTpLQ0ufNtKMjhW+RyDea/3Gfspn+HPy5nuppKcahCHx7S0jeP+UUTBbXWtiJD54tEncRAJoVzA2b9naA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1167.namprd12.prod.outlook.com (10.169.201.15) by
 MWHPR12MB1405.namprd12.prod.outlook.com (10.169.206.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 23:48:28 +0000
Received: from MWHPR12MB1167.namprd12.prod.outlook.com
 ([fe80::f5c4:1556:7f1d:f9b7]) by MWHPR12MB1167.namprd12.prod.outlook.com
 ([fe80::f5c4:1556:7f1d:f9b7%12]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 23:48:28 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92ad9MuYAgAAL0YA=
Date: Tue, 5 Nov 2019 23:48:28 +0000
Message-ID: <968d3fe1-4faf-f003-3ec4-10fd5c35cdd8@amd.com>
References: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
 <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
In-Reply-To: <CADnq5_NDEXUD84z8srp8NNMNvDVwLNZsZUSek=U2hMwkDKxaNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [99.244.177.93]
x-clientproxiedby: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To MWHPR12MB1167.namprd12.prod.outlook.com
 (2603:10b6:300:8::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 430ab1fa-c864-43d1-2f34-08d7624aa7c8
x-ms-traffictypediagnostic: MWHPR12MB1405:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB14055C97AB4A31919E9F0FD4827E0@MWHPR12MB1405.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(76176011)(65806001)(54906003)(1411001)(102836004)(31686004)(66066001)(446003)(6506007)(476003)(11346002)(5660300002)(65956001)(14444005)(256004)(3846002)(6246003)(4326008)(25786009)(2906002)(966005)(478600001)(305945005)(6116002)(7736002)(53546011)(36756003)(6916009)(86362001)(186003)(14454004)(386003)(6486002)(6436002)(486006)(2616005)(229853002)(71190400001)(31696002)(8676002)(316002)(8936002)(81166006)(81156014)(66946007)(66556008)(66446008)(52116002)(99286004)(64756008)(66476007)(58126008)(71200400001)(6512007)(6306002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1405;
 H:MWHPR12MB1167.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKe4nD7TiS5cZhKI2uNu3c0//umbWlPf1/Fnx8fWPlDA4qoFGmAWPVAo0oyhy5mSFuBj2WwNRN6MlE4a8JfvnKTOOiQRK0mPd0EhQQiz9NOzCrxeH3BgtKZMD8HUz8f9zvUwtziADeNhNpuWbwtAAg8dppbN7ntGdUv3Kn3y5HIrMqoYeC6CfYcAvVvgdCKogBIbNaYvmY3mQ+BoGH00ZhI9hTaLBgrweI9yMOrQFj46KxvzE0H4rwFfUVcO9b7/3aym43sZMQQfZQWPoBHlcokXEbBYmXMNDRD9tfK5U16HJtrXGiIInemhO67gjpHHPTqn4WXn/Tuw/rtG926bOWl/qL8l8e+E1ZO3t49RHIWqiRb6XWNNqsJ0tZhEywtbvd+S7+KpZPtM0MIS/veZA5jaFmRuz+S1cCoeyEegWp7uNl/D5PJPVb0LMl/oHUE5QhGrjLyDEOC6bNcJGBzrSK1Zzswm3sKMq00riTeLcv8=
Content-ID: <4C2FB2670BF5474D9CB879C6D0644E2F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430ab1fa-c864-43d1-2f34-08d7624aa7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 23:48:28.1639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80zZk2ibaWVjPSFXNpzajmW8E1yopsGuJOeEp1ynucKzlueEosV9N2FFHzPa7wAhIymULyNO9bnkKMSWluXobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrrREc6daUDN+CNuO9XSQhRHH5z1PFEUS9E+ZVLwI+w=;
 b=sEkfd9KF1fHW5LyB9rNHnNCvTSZfAsFfzLgW5mmcyUwdwvs1foBEcFGfwKuZLX4xO9Ql/ADABOUWFCiSV/zm8YKHfh8AsHkVAHrzbK8SMYmLiXrZgaXF97JUoarwLlX5e6OZjGnXpDLHCIC9WZ42ngX2H7K9bA5SWF5Lt9KStxs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Jiang,
 Jerry \(SW\)" <Jerry.Jiang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105234828.KLjZ7Xmnbm1LGyVzqEIZqKsKBf66f_ZqJIEpKet_O5s@z>

DQpPbiAyMDE5LTExLTA1IDY6MDYgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBUdWUs
IE5vdiA1LCAyMDE5IGF0IDU6MjYgUE0gSHVhbmcsIEppbkh1aUVyaWMNCj4gPEppbkh1aUVyaWMu
SHVhbmdAYW1kLmNvbT4gd3JvdGU6DQo+PiBVc2luZyB1bmlmaWVkIFZCSU9TIGhhcyBwZXJmb3Jt
YW5jZSBkcm9wIGluIHNyaW92IGVudmlyb25tZW50Lg0KPj4gVGhlIGZpeCBpcyBzd2l0Y2hpbmcg
dG8gYW5vdGhlciByZWdpc3RlciBpbnN0ZWFkLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMg
SHVhbmcgPEppbmh1aUVyaWMuSHVhbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMTkgKysrKysrKysrKysrKysrKy0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4+IGluZGV4IDgyOWQ2MjMuLmU0
NGEzZWEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiBA
QCAtMzg4NSw5ICszODg1LDIyIEBAIHN0YXRpYyB1aW50NjRfdCBnZnhfdjlfMF9nZXRfZ3B1X2Ns
b2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAgICAgICB1aW50
NjRfdCBjbG9jazsNCj4+DQo+PiAgICAgICAgICBtdXRleF9sb2NrKCZhZGV2LT5nZnguZ3B1X2Ns
b2NrX211dGV4KTsNCj4+IC0gICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DQVBUVVJF
X0dQVV9DTE9DS19DT1VOVCwgMSk7DQo+PiAtICAgICAgIGNsb2NrID0gKHVpbnQ2NF90KVJSRUcz
Ml9TT0MxNShHQywgMCwgbW1STENfR1BVX0NMT0NLX0NPVU5UX0xTQikgfA0KPj4gLSAgICAgICAg
ICAgICAgICgodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09V
TlRfTVNCKSA8PCAzMlVMTCk7DQo+PiArICAgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJ
UF9WRUdBMTAgJiYgYW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikpIHsNCj4+ICsgICAgICAgICAg
ICAgICB1aW50MzJfdCB0bXAsIGxzYiwgbXNiLCBpID0gMDsNCj4+ICsgICAgICAgICAgICAgICBk
byB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaSAhPSAwKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1ZGVsYXkoMSk7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1JFRkNMT0NLX1RJTUVTVEFNUF9N
U0IpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgbHNiID0gUlJFRzMyX1NPQzE1KEdDLCAw
LCBtbVJMQ19SRUZDTE9DS19USU1FU1RBTVBfTFNCKTsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIG1zYiA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX01T
Qik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpKys7DQo+PiArICAgICAgICAgICAgICAg
fSB3aGlsZSAodW5saWtlbHkodG1wICE9IG1zYikgJiYgKGkgPCBhZGV2LT51c2VjX3RpbWVvdXQp
KTsNCj4+ICsgICAgICAgICAgICAgICBjbG9jayA9ICh1aW50NjRfdClsc2IgfCAoKHVpbnQ2NF90
KW1zYiA8PCAzMlVMTCk7DQo+PiArICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAg
V1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DQVBUVVJFX0dQVV9DTE9DS19DT1VOVCwgMSk7DQo+
PiArICAgICAgICAgICAgICAgY2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBt
bVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTFNCKSB8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAo
KHVpbnQ2NF90KVJSRUczMl9TT0MxNShHQywgMCwgbW1STENfR1BVX0NMT0NLX0NPVU5UX01TQikg
PDwgMzJVTEwpOw0KPj4gKyAgICAgICB9DQo+IElzIHRoZXJlIGEgcmVhc29uIHdlIGNhbid0IHVz
ZSB0aGUgc2FtZSByZWdzIG9uIGJhcmUgbWV0YWwgYW5kIFNSLUlPVj8NCj4gICBJJ2QgbGlrZSB0
byBtaW5pbWl6ZSB0aGUgZGVsdGFzIGlmIHBvc3NpYmxlLg0KDQpBcyBKZXJyeSdzIHJlcXVlc3Qs
IHRoaXMgY2hhbmdlIHdpbGwgYXZvaWQgUDEgcG9saWN5IHByb3RlY3Rpb24gb24gDQpSTENfR1BV
X0NMT0NLX0NPVU5UX0xTQi9NU0IuDQoNCkVyaWMNCg0KPg0KPiBBbGV4DQo+DQo+PiAgICAgICAg
ICBtdXRleF91bmxvY2soJmFkZXYtPmdmeC5ncHVfY2xvY2tfbXV0ZXgpOw0KPj4gICAgICAgICAg
cmV0dXJuIGNsb2NrOw0KPj4gICB9DQo+PiAtLQ0KPj4gMi43LjQNCj4+DQo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QNCj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
