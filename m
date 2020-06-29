Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 14:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0660D23D5A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hPtig0C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0660D23D5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB63889DDD;
	Mon, 29 Jun 2020 14:02:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499B189DDD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 14:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0yh7aEmWzaAWgJrbHbXeKjdLp3+eeZiC837bhPHn3qEllSJOBYBEacYtY4auNa5Z5lOGr3sFOUlVIPej14X9ww3L/x21ITxyBLJxPhegBcKq8SwKDycXNUgXm+cQuTOY/8BOmWOA7G5J2oGyzan43QTrZA21CQBAkcYPCOU28vIy+rrJqtkCpqghLATH7yFsngFBn8pI03Vp4yhyXypuQUhw8NwEd+BRzQEkJHh3BkkbD/W+y+tSVSo252YeTVJ0PMOT8kJpgwZkFYhEVda3GcnNLGckAXfc9os8Q0+k2dElaieEtghe/DEQoEcuQITEPmFiGSEA/SFPY34NjB1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDH4U0urZlC5qRPcGvxaVzvXmJiZxKsbl7MzhvAv00=;
 b=DZmMnyocwbnOaJwwUYn279eWc//yZVqYM/9BuzMSPHenEkWSGldDaF+vGiClQ2xeXWyd4oCydJM3joxCZK/kRfvhX4pmya9s1ik6Wbyx1dQupwn6DZ9Nl4qEb3WnxngTYb9Sd+Q8P6qxG9LkYwIId3MMBtaBh9jEF/CexSJVaJMG51veFghdO5tXK6zXBl3r1epBym4EIjfOmwx1BfGa8iRs159zC7Mfb3HJsCNqYibHBBcUwa1fYE6y38m0nQ0qYT7GdlPJqQz+5bDeuFkVy3AJhRemtPPOudKj1jDT3ut/O3EVkMc3qqR1MftkKqSLd6xfgQ8Q99Ujo2YfgsXAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDH4U0urZlC5qRPcGvxaVzvXmJiZxKsbl7MzhvAv00=;
 b=hPtig0C+xmJ+5wjruZkfwlNNneEiu7epbMNH81Rw30AIwKj+p1Rt82B4v83sD4Sd9Bpp+Jxtw1Aiv/ker76rxakpX8R6fdk6XgA2c3QuysgBRXMYWzPgT1pkKacPk0GQL3jLX60im8W44lOe8U6wkDr9QZimhgzb2gTpmk9hBWs=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Mon, 29 Jun
 2020 14:02:14 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 14:02:13 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: make IB test synchronize with init for
 SRIOV(v2)
Thread-Topic: [PATCH] drm/amdgpu: make IB test synchronize with init for
 SRIOV(v2)
Thread-Index: AQHWTfisCB5rOH9fAE2HKRmL21nA6KjvV6CAgABHzjA=
Date: Mon, 29 Jun 2020 14:02:13 +0000
Message-ID: <DM5PR12MB17085E00F5C49A565DDCD2F4846E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1593423339-2773-1-git-send-email-Monk.Liu@amd.com>
 <4c827264-1dd7-b977-0bea-d0ab8db82898@gmail.com>
In-Reply-To: <4c827264-1dd7-b977-0bea-d0ab8db82898@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.87.147.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b093fe70-c3c3-4154-9c05-08d81c350668
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23606F1C3E3F79200C67711F846E0@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSY/U0Qs7CX0kaSHcNpDNKW1bZE/XDfQPG8/LMB/L4p08ZeIK4WUAKnOHO1BYGOftkaJEMmqE+0fgMQSNsDVVIzCaRxcAKppGnjfrmXbThlflrRh0nKDz/FPrsI8DVgMV6KH6DmcHaO+U3gbXddIriuhN2aH0d2NakfLl35iF4OuM2YgqPvAqrR3SmXHH1sRdn0yutzW1t0L7YJrNTlL0tX7wIFeoQXpS/fI167XE1AcAyhfcHEWxyhhbnFMvGxs7gi4CeDBUoJnI6UHqlHWM3AMQqcdGXZnh2TlWB/PRt4oXqREa/z/MXBi7UyFTJb/xQqmwOijJMM/0jOoM4a6Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(71200400001)(83380400001)(7696005)(55016002)(316002)(9686003)(86362001)(110136005)(53546011)(8936002)(478600001)(6506007)(8676002)(66556008)(66476007)(64756008)(76116006)(66446008)(186003)(33656002)(26005)(66946007)(52536014)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XDYD9k7oiqj99cfiizG5yM+GMi7DDC/tLHJ8qO4L7An8gsL1msJZVon/4KqB3DHbDI/xPTGnxo5yvyU0L75RslWgoLZVQrnF8z3iga3u4pWlUsyOZDBFluUFItD4Iedaj1kKaZAaOORePdj/kZao1ePNqeEyC50I+BzKnOcpRwbAk3316CZpRVMJYFHDIcZfqWivU+UpH7OkJFbeFlp7OrBz821Xe53iaTkuFQjsg8F/CzD3UOxfLtLsUKcqAEQSIDhHPGe+7AMhCY/fGaU6itZxKaVbVe9NuGyY2W6Zxc+k+Sb68u+kqyi+NLMLDzaGwGrOB07OJnoxepJ2P06Bzd8IQVsnPp9uynkaFFYBpMeirQnLjnohRpR/8PgMM+pqkbDlKXZ+dA7AYTQhDlUcBJEDA/8AVMU8IFTinbb6g27Etiq2lo/bLQOqSHb113la1uF9YZUwNSDLflNtypbqCsR5eMICUT+xaAavLFMFpOI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b093fe70-c3c3-4154-9c05-08d81c350668
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 14:02:13.8029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdurYvyxXT71Oy6sXQKMpDuRnBOqyY7Vbt0QaFIYjLUpMKY8a6SGta40Hv+jI0hB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2UnZCBiZXR0ZXIgbm90IGxldCB0aGUgZmx1c2ggYWZ0ZXIgc3lzZnMgY3JlYXRpb24gb3RoZXJ3
aXNlIHRoZXJlIGlzIGNoYW5jZSB0aGF0IHVzZXIgdXNlIHN5c2ZzIHRvIHRvdWNoIGhhcmR3YXJl
IGJlZm9yZSB0aGUgSUIgdGVzdCBkb25lIGFuZCBpbnRyb2R1Y2UgaGVhZGFjaGUgaXNzdWVzIA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmly
dHVhbGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiAN
ClNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA1OjQ0IFBNDQpUbzogTGl1LCBNb25rIDxNb25r
LkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IG1ha2UgSUIgdGVzdCBzeW5jaHJvbml6ZSB3aXRoIGluaXQg
Zm9yIFNSSU9WKHYyKQ0KDQpBbSAyOS4wNi4yMCB1bSAxMTozNSBzY2hyaWViIE1vbmsgTGl1Og0K
PiBpc3N1ZToNCj4gb3JpZ2luYWxseSB3ZSBraWNrb2ZmIElCIHRlc3QgYXN5bmNocm9ub3VzbHkg
d2l0aCBkcml2ZXIncyBpbml0LCB0aHVzIA0KPiB0aGUgSUIgdGVzdCBtYXkgc3RpbGwgcnVubmlu
ZyB3aGVuIHRoZSBkcml2ZXIgbG9hZGluZyBkb25lIChtb2Rwcm9iZSANCj4gYW1kZ3B1IGRvbmUp
Lg0KPiBpZiB3ZSBzaHV0ZG93biBWTSBpbW1lZGlhdGVseSBhZnRlciBhbWRncHUgZHJpdmVyIGxv
YWRlZCB0aGVuIEdQVSBtYXkgDQo+IGhhbmcgYmVjYXVzZSB0aGUgSUIgdGVzdCBpcyBzdGlsbCBy
dW5uaW5nDQo+DQo+IGZpeDoNCj4gZmx1c2ggdGhlIGRlbGF5ZWRfaW5pdCByb3V0aW5lIGF0IHRo
ZSBib3R0b20gb2YgZGV2aWNlX2luaXQgdG8gYXZvaWQgDQo+IGRyaXZlciBsb2FkaW5nIGRvbmUg
cHJpb3IgdG8gdGhlIElCIHRlc3QgY29tcGxldGVzDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1vbmsg
TGl1IDxNb25rLkxpdUBhbWQuY29tPg0KDQpNYXliZSBkbyB0aGlzIGV2ZW4gYWZ0ZXIgc3lzZnMg
YW5kIFBNVSBpbml0LCBidXQgZWl0aGVyIHdheSBBY2tlZC1ieTogDQpDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQo+IGluZGV4IDQ1N2Y1ZDIuLjdhNGU5NjUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTMyOTUsNiArMzI5NSw5
IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+
ICAgCXF1ZXVlX2RlbGF5ZWRfd29yayhzeXN0ZW1fd3EsICZhZGV2LT5kZWxheWVkX2luaXRfd29y
aywNCj4gICAJCQkgICBtc2Vjc190b19qaWZmaWVzKEFNREdQVV9SRVNVTUVfTVMpKTsNCj4gICAN
Cj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiArCQlmbHVzaF9kZWxheWVkX3dvcmso
JmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsNCj4gKw0KPiAgIAlyID0gc3lzZnNfY3JlYXRlX2Zp
bGVzKCZhZGV2LT5kZXYtPmtvYmosIGFtZGdwdV9kZXZfYXR0cmlidXRlcyk7DQo+ICAgCWlmIChy
KSB7DQo+ICAgCQlkZXZfZXJyKGFkZXYtPmRldiwgIkNvdWxkIG5vdCBjcmVhdGUgYW1kZ3B1IGRl
dmljZSBhdHRyXG4iKTsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
