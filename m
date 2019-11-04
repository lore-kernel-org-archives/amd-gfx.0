Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE98CA9EB5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 19:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE36206BA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 19:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE36206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAF76E854;
	Mon,  4 Nov 2019 19:49:59 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720052.outbound.protection.outlook.com [40.107.72.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900A76E854
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 19:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Q+cOXAaVkcKFV+eRZSQiL1YQiN3WmA50vEWIZ/b+sEb247W8Mrt5pslojGUIXa31wffXtZYM4F/e8zgSNjRTC4vAU7jR0Mt9GyDzzPcq0kD12Jq+fcmCLiLCV2Jx0XD6hdxSLRCtsX9cMxjz3kb1YNPLixZ90ooAEa44c66zYfHMhDEaLQrsfatbhkhTEQejXzQLAcTVtfV/7SDj3pMvzA38MXBDJd2lOuUefokkbxu6Z8nJEGGpTTRKiJTSPjD5sLuOGHIs25ZOAUCVhdzhAy40P+W9fIwAEfxGzeyWBvpy/HFHW3zRanVDB6d3EGmpgHZk0bkHKl2n5op7WLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgpjZqNVzkZXhciQPfzE7wbcZmnAkFXAgCgFTY+kLlk=;
 b=QYmr7r77pNnflNrG6DDM4fmb+BtO94Aq3/FBJbKWg+ibx2pRy+CemB7DBhWZkQAgfIXa7c+LjGypbgkz5UqLcZDNFzPOTCgiW2/VEpZvVF8IO+5v4FTNDv2JDKO3uOrHwUqNLD9KU93zpDXHWX5iig8WLvcZdfPce5d0RjEx/jaMCi65KyBEr2DGEExYPk3C6jFTJLjHyWxq0P5ulPcLSq1aUx/7ughVUDtpRqFbXoGWO/LS+TMn/93s0f1wNzWwaEtnPzLoziTGf1hY37eDcL7kcBnP8tdQuh4NaxWdmdj9DaAcTUV4XSVxy0c8xABRmPqwgJs57+v1gutXfeubfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB2908.namprd12.prod.outlook.com (20.179.71.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 19:49:57 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::4831:3ea2:2d94:66d3%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 19:49:57 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>
Subject: RE: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Topic: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Index: AQHVkymI1xwlEiK2sE2bB6BNavcbhqd7OjOAgAAAKyA=
Date: Mon, 4 Nov 2019 19:49:56 +0000
Message-ID:
 <DM6PR12MB34661BBB5BF6989CF63389D19E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <DM6PR12MB3466E5EF19CE8BBD78AC6BBE9E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <9d0a0e07-f68a-8e93-3003-f19ca056b2ff@amd.com>
In-Reply-To: <9d0a0e07-f68a-8e93-3003-f19ca056b2ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4485963e-f398-4682-7bd0-08d761602b7e
x-ms-traffictypediagnostic: DM6PR12MB2908:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29087041D69FE508442C99309E7F0@DM6PR12MB2908.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(13464003)(199004)(189003)(5660300002)(86362001)(81156014)(53546011)(7696005)(26005)(52536014)(102836004)(6506007)(9686003)(99286004)(66556008)(66476007)(66946007)(64756008)(6306002)(66446008)(76116006)(305945005)(7736002)(2906002)(476003)(486006)(81166006)(55016002)(76176011)(8936002)(316002)(71190400001)(71200400001)(6636002)(256004)(6246003)(186003)(11346002)(74316002)(966005)(446003)(14454004)(8676002)(25786009)(3846002)(6116002)(2501003)(478600001)(66066001)(33656002)(6436002)(229853002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2908;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TWj5sEGg4909d2pPs45MdkpDQqNpupRdhWOOs8XFjvcJOblGnu0m4DFRRq2KHXsgapNr0TkQG6RgwU55vu3GoSvBIc7IiLJa5o+ikwO/g9jE2WwqxiFsUDVm2Y++X0cKKQT9JU9nATxqipMzftgtMdFMNExv8SH/HeiDWMH/TrgGDSRnf3ZjgTl+XXSIFMBPIaqMS+ws3fukbbfhznP0mV4OyqoK96ZTSOa1x7UlKxDFp0XKwkaUAQ9ssuniP3Wr16+Ybys1W7bU3dNZOLvtmlPJXl3GPawKhS3ZpYMCLJ80ToAxTAQkSOrQKCcLLPZxWYZCLTrWVG8rq76Bq9XSferNLtDbKLVtMS3MZfBHLKGVfocUjEH67ptkm/nvZtCU2sccobSqt3/hTyESqj652/hpR8mN/Gl70rK5clEwt67kNP8syZfhfNb5jgzWQN8OGtJFKHvFqDH52ba9zvLLMBOYJvUCHq9jBrHtiY2boo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4485963e-f398-4682-7bd0-08d761602b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 19:49:56.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5Hur82XG3pD+pF4hQiwvyVACsMzcgf9BAgofH95PVgsxBdhfWVoMcR5UOFwQA7B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgpjZqNVzkZXhciQPfzE7wbcZmnAkFXAgCgFTY+kLlk=;
 b=Wfi+XkWC45T3+r5ncL3EkbZizRUz5w38rx4ffqKo4bVQokLEr9opqsyBvoOqzP/AsUmg7wLQVFj3y5SgMR4OsHcVy9VJ/061+uW9tVgJFe8TUoKwa4/6AwsIRcg0oGW/8DF9I5aG2ovKQJeV2NmKgt1IZaepPayMg1lvz/UjtoU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Message-ID: <20191104194956.5xrC_z6aErFaxeaGTNVzz-ztd-RY35FUh3I0gKBaK74@z>

VGhhbmsgeW91IE5pY2sgZm9yIHRoZSBhZHZpY2UuIEkganVzdCByZXZlcnRlZCB0aGUgb3JpZ2lu
YWwgY29tbWl0Lg0KDQpaaGFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogS2F6bGF1c2thcywgTmljaG9sYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4NCj4g
U2VudDogMjAxOS9Ob3ZlbWJlci8wNCwgTW9uZGF5IDExOjUzIEFNDQo+IFRvOiBMaXUsIFpoYW4g
PFpoYW4uTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgV3UsDQo+
IEhlcnNlbiA8aGVyc2VueHMud3VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZC9kaXNwbGF5OiByZW1vdmUgInNldHRpbmcgRElHX01PREUgdHdpY2UiDQo+IHdvcmthcm91
bmQNCj4gDQo+IE9uIDIwMTktMTEtMDQgMTE6MDYgYS5tLiwgTGl1LCBaaGFuIHdyb3RlOg0KPiA+
IFtXaHldDQo+ID4gVGhlIHJvb3QgY2F1c2Ugb2YgTmF2aTE0IEhETUkgcGluayBzY3JlZW4gaXNz
dWUgaGFzIGJlZW4gZm91bmQuDQo+ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBzZXQgRElHX01PREUg
dHdpY2UgYW55bW9yZS4NCj4gPg0KPiA+IFtIb3ddDQo+ID4gUmVtb3ZlICJzZXR0aW5nIERJR19N
T0RFIiB0d2ljZSB3b3JrYXJvdW5kLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbiBMaXUg
PHpoYW4ubGl1QGFtZC5jb20+DQo+IA0KPiBQbGVhc2UgdXNlIGdpdCB0byByZXZlcnQgdGhlIGNv
bW1pdCBpbnN0ZWFkOg0KPiANCj4gZWcuDQo+IA0KPiBnaXQgcmV2ZXJ0IDxTSEE+DQo+IA0KPiBU
aGVuIGFkZCB0aGUgcmVhc29uaW5nIHRvIHRoZSByZXZlcnQgY29tbWl0IG1lc3NhZ2UuDQo+IA0K
PiBUaGFua3MsDQo+IA0KPiBOaWNob2xhcyBLYXpsYXVza2FzDQo+IA0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgOSAtLS0tLS0t
LS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPiA+IGluZGV4
IGNjOTRjMWE3M2RhYS4uMTJiYTZmZGY4OWI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPiA+IEBAIC0zMDI3LDE1ICszMDI3
LDYgQEAgdm9pZCBjb3JlX2xpbmtfZW5hYmxlX3N0cmVhbSgNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIENPTlRST0xMRVJfRFBfVEVTVF9QQVRURVJOX1ZJREVP
TU9ERSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTE9S
X0RFUFRIX1VOREVGSU5FRCk7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgLyogVGhpcyBzZWNv
bmQgY2FsbCBpcyBuZWVkZWQgdG8gcmVjb25maWd1cmUgdGhlIERJRw0KPiA+IC0gICAgICAgICAg
ICAgICAgKiBhcyBhIHdvcmthcm91bmQgZm9yIHRoZSBpbmNvcnJlY3QgdmFsdWUgYmVpbmcgYXBw
bGllZA0KPiA+IC0gICAgICAgICAgICAgICAgKiBmcm9tIHRyYW5zbWl0dGVyIGNvbnRyb2wuDQo+
ID4gLSAgICAgICAgICAgICAgICAqLw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoIWRjX2lzX3Zp
cnR1YWxfc2lnbmFsKHBpcGVfY3R4LT5zdHJlYW0tPnNpZ25hbCkpDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgc3RyZWFtLT5saW5rLT5saW5rX2VuYy0+ZnVuY3MtPnNldHVwKA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyZWFtLT5saW5rLT5saW5rX2VuYywNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpcGVfY3R4LT5zdHJlYW0tPnNpZ25h
bCk7DQo+ID4gLQ0KPiA+ICAgI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RTQ19TVVBQT1JUDQo+
ID4gICAgICAgICAgICAgICAgICBpZiAocGlwZV9jdHgtPnN0cmVhbS0+dGltaW5nLmZsYWdzLkRT
Qykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZGNfaXNfZHBfc2lnbmFsKHBp
cGVfY3R4LT5zdHJlYW0tPnNpZ25hbCkgfHwNCj4gPiAtLQ0KPiA+IDIuMjEuMA0KPiA+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gYW1kLWdmeCBt
YWlsaW5nIGxpc3QNCj4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KPiA+DQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
