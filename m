Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C0CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA9521855
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA9521855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D496F86D;
	Fri,  1 Nov 2019 20:30:28 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7215E6F86D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hX4drXPVh0ZaX1GI/8To/m74tY85E9RMfcyP+OuBgJdNDfGTqjt6gjJiqQV9I2IeOQ/pXq4znrVMqEOMOfIWKxhq7WGGP4dTuZzf40smCDPXH9PvT+9w4OcwQipFw1SKnemg7/alBWTqVeAvxJKi1wg8QZiuiZBU4UjYMXidYtan7zIbQ/YqXtZtVzdL0lzStIV7mo4udRwGsHEki1y5eiRmn3UqQJwvCtICJxQLIPpCM8ZDCd0XWsVj4hCMk2C4LXT//Dz9MsI2q0esotBzsfbMJNIKNnBJ3uZmXO5Jn7XOFN3EpW3Y8djnuJpcg1lJjDalEr1UsOr/4ubVo3jCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOHDI/DHIlG9c8YOAIX9+6bZV2x9vap/qj/z9OO9dYE=;
 b=E/vqMaslXg3Ic0zGAYsHGrT6ZBp2zK2NkEFTH7Efho6eDp1APBGzjxH6os+HUq2ubFJ7u2aAGskCHOkyAbZmuTUsHaIE080cy5SjiejyS5c+0M5EmiYuSpdPThJ7VIqVeymDvrJsP+nRU6Hz/CJxspV85fikpXc72njmC0EduqYpwo6fW3Tprc3w0UWm0Awpdog8JOp7OdOwgE13X1ZJqfuy8bNEpHWza1WgoW6NpqJDZ8sT53IoRStoH2quxwOG3C0rr8IgEJOVZnf7JFXa0UfzumaaQib2fc2bkXZD2W6xt2J6Kfw86N+TsSuFJIEp9fGqyOHjTYTiOnrvFx/TeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB2499.namprd12.prod.outlook.com (10.172.111.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 20:30:24 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::f894:3184:4c1:10e5]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::f894:3184:4c1:10e5%11]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:30:23 +0000
From: Harry Wentland <hwentlan@amd.com>
To: Neil Mayhew <neil@neil.mayhew.name>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Show resolution correctly in mode validation
 debug output
Thread-Topic: [PATCH] drm/amdgpu: Show resolution correctly in mode validation
 debug output
Thread-Index: AQHVj1WAxIZ7lKfuT0q6lVf9vKs7rqd2bw+AgAAJuACAAE7sAA==
Date: Fri, 1 Nov 2019 20:30:23 +0000
Message-ID: <54c04faf-9a38-12e6-fa1f-1343c785a027@amd.com>
References: <20191030185837.8766-1-neil@neil.mayhew.name>
 <e970ad7b-3ca6-a6a4-ebf0-83b5f6b3b153@amd.com>
 <1b3d267d-7d0a-1fbb-44c5-89d1695e3733@neil.mayhew.name>
In-Reply-To: <1b3d267d-7d0a-1fbb-44c5-89d1695e3733@neil.mayhew.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
x-clientproxiedby: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0634e1a-7758-478f-6745-08d75f0a5278
x-ms-traffictypediagnostic: BN6PR1201MB2499:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR1201MB2499CB36C2885BAA8B86C4748C620@BN6PR1201MB2499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(66066001)(305945005)(256004)(31686004)(2501003)(31696002)(110136005)(6116002)(2906002)(2616005)(58126008)(99286004)(65806001)(71190400001)(3846002)(186003)(71200400001)(14444005)(4001150100001)(7736002)(5660300002)(486006)(52116002)(76176011)(66476007)(66946007)(64756008)(229853002)(66556008)(66446008)(26005)(446003)(8936002)(966005)(11346002)(65956001)(6506007)(386003)(36756003)(316002)(6486002)(53546011)(476003)(8676002)(81166006)(6436002)(6306002)(14454004)(478600001)(102836004)(6246003)(6512007)(81156014)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2499;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4lH2piMjufndaXhJDcKe61hmZ5XtGNN+3g/M6213x+S8C0HA5VGHltDaBzg5vCVEGcAW4+ftcrSNL8xO+j3ndn+IGObgc60Afs+g6OQ7AkvNNOCsgLWG2Ap4WYDYVgWN7Ilwvx0S35ZfZGRKgC4wFJ7TlbLHiznDSwpy+O0aUvjEr67/01X+Fm29MFy84MrRrEPuBfHVrWm7emp4++84kQFdKfhOeuOHnjZ5kiGq/zAcPJ0rWO0Z3lK+WL6Y5LhgxRe58tkXEZfLbNAvtDNvskve20dzM3qjpiUiTnIQybRTKGBN/Mo5VLMwP1Krhu6gD4/0CPA057dQbXhtCLxq3hgFZsmamGvyHYiQYoY9zzvnqsDgVmL8R1LgweVuKe+YoiYonkMIabgMkAcqwbNFlEtMaKzo442kjy/bgISL/mzcPHZTiTJr8Z3B/+P/rYdFi3KQUaIVd39gT1d4DBmX7B/EaDeZTJ9ecZxzSbvcDE=
x-ms-exchange-transport-forked: True
Content-ID: <A8A7739FD334A74EB15A9FC295065A4F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0634e1a-7758-478f-6745-08d75f0a5278
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:30:23.7926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91I73HLT7QcXoxrfLCFPlL6Lls0J0LE+YSymSvMijALk1MTjoZE1B2XpsQSP4Wz/M9/2ctE1FrijoShnh8TAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOHDI/DHIlG9c8YOAIX9+6bZV2x9vap/qj/z9OO9dYE=;
 b=abytbZVuIjBKhZC46Q8WVIO8Oo6dQ4gJWNrCpKev3GsSdMnhpoOa4QDknR88nXn4vJ+H73a5bfEm5du0U0pBLu8j6XiWUpbWjEa3Sf0bp3pLhNrMZwruGRO0xw6IWKj3yhaveDjKj6GEbHbKzCc6TalP0O3vPfGfIRfuDhdAkxo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Message-ID: <20191101203023.GgsZ2EZwVd6rXXnVGPJ5U_BXJ1hrVmhNkSJYLzVqlrQ@z>

T24gMjAxOS0xMS0wMSAxMTo0NyBhLm0uLCBOZWlsIE1heWhldyB3cm90ZToNCj4gT24gMjAxOS0x
MS0wMSA5OjEzIGEubS4sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOg0KPj4gT24gMjAxOS0xMC0zMCAy
OjU4IHAubS4sIG5laWxAbmVpbC5tYXloZXcubmFtZSB3cm90ZToNCj4+PiBGcm9tOiBOZWlsIE1h
eWhldyA8bmVpbEBuZWlsLm1heWhldy5uYW1lPg0KPj4gVGhpcyByZXF1aXJlcyB5b3VyIFNpZ25l
ZC1vZmYtYnkuIFNlZSBbMV0uDQo+Pg0KPj4gV2l0aCB0aGF0IGZpeGVkIHlvdXIgY2hhbmdlIGxv
b2tzIGdvb2QgYW5kIGlzDQo+PiBSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+DQo+Pg0KPj4gWW91IGNhbiBzaW1wbHkgcmVwbHkgdG8gdGhpcyBlbWFp
bCB3aXRoIHlvdXIgU2lnbmVkLW9mZi1ieSBhbmQgSSBjYW4gYWRkDQo+PiBpdCB3aGVuIG1lcmdp
bmcsIG9yIHlvdSBjYW4gc2VuZCBhIHYyIHBhdGNoIHdpdGggeW91ciBTaWduZWQtb2ZmLWJ5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTmVpbCBNYXloZXcgPG5laWxAbmVpbC5tYXloZXcubmFtZT4N
Cj4gDQoNClRoYW5rcyBhbmQgdGhhbmtzIGZvciB5b3VyIGZpeC4gQXBwbGllZC4NCg0KSGFycnkN
Cg0KPiBUaGFua3MsIEhhcnJ5Lg0KPiANCj4+IFsxXQ0KPj4gaHR0cHM6Ly93d3cua2VybmVsLm9y
Zy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI3NpZ24teW91
ci13b3JrLXRoZS1kZXZlbG9wZXItcy1jZXJ0aWZpY2F0ZS1vZi1vcmlnaW4NCj4+DQo+PiBIYXJy
eQ0KPj4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyB8IDIgKy0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4+PiBpbmRleCBhNTJmMGIxM2EyYzguLmY4MDJj
Nzg0ZTZmNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPj4+IEBAIC00MTE0LDggKzQxMTQsOCBAQCBlbnVtIGRy
bV9tb2RlX3N0YXR1cyBhbWRncHVfZG1fY29ubmVjdG9yX21vZGVfdmFsaWQoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lYw0KPj4+ICAJCXJlc3VsdCA9IE1PREVfT0s7DQo+Pj4gIAllbHNlDQo+
Pj4gIAkJRFJNX0RFQlVHX0tNUygiTW9kZSAlZHglZCAoY2xrICVkKSBmYWlsZWQgREMgdmFsaWRh
dGlvbiB3aXRoIGVycm9yICVkXG4iLA0KPj4+IC0JCQkgICAgICBtb2RlLT52ZGlzcGxheSwNCj4+
PiAgCQkJICAgICAgbW9kZS0+aGRpc3BsYXksDQo+Pj4gKwkJCSAgICAgIG1vZGUtPnZkaXNwbGF5
LA0KPj4+ICAJCQkgICAgICBtb2RlLT5jbG9jaywNCj4+PiAgCQkJICAgICAgZGNfcmVzdWx0KTsN
Cj4+PiAgDQo+Pj4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
