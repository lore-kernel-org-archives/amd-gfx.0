Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73956C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 03:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3910520678
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 03:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ATjdbdSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3910520678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32436E82D;
	Wed, 15 Apr 2020 03:05:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1736E82E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 03:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiIbj0CesulcqrIF5MvAaQ10ijXtaXDL3Z4fwOvIpBaph5Jkl04wK3mAFTpigbzNis+XXV+367Cp/D9BgvFcxl11dIL66c3JcbM0ATflMoPM+/jL2ubaz+Ui6ZDVhU/qwG187P4BlhiYyrVaLoXKu96c83NGCYBz0CV/JlW/5lP+q77eQ/4/Q3LSD+4jV1hVKItBx16jNFO+wXFMEbb2vxPiyRrvu6FudKfkGEsp8G6/AgIryMnrNeiF9cAXwH/Tr4LFY+JREhv+qq4EpxFoaiIWiPVRHZFQzbRfu2xrHlmaNQYECFnYS2NEYtfpMDJb29xkoo1LRlH1xBDgV3r5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xaku3exCrlKsFgPgRFi/6OSTQ8bJXMZnGo1JyX2ufo=;
 b=YOVTOFppGBV5M4f2S1CQusPsidOf06DGZk8UKrefok34Kzihw9RDkV9NF6JxzkqLklTGM/eHqkeFnWzaa5L58KQuYmm10FSuZIV7athjGew0Vdeigh9jIZIzPu1dJZQka73pZzT8CGqF/cpu/AAj2g5ARHvDmB/XpG93tm2kSCFLTmJyshPQJS7JA+UWOLxl04w0tlDFa40yw8suezSuy1dE2luM3Eh2k8jBKqnbMTMqoybWkU7Qo5I5YBViRevrdsMN6o0iLXv4wu44M0OPdETHUaKGO9EI9/TgISyEzCL82E+NgdbnS4/WqCKIVxxVfGir4Ecou7gk4Vb2rpR1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xaku3exCrlKsFgPgRFi/6OSTQ8bJXMZnGo1JyX2ufo=;
 b=ATjdbdSOhlhA5E9jDjINkeekk6AdRJkmkW14hFi69+mhwgs6aflK6o3jKMUf8VI/Rvu3W5Uec2X0wCf6ZWYOBb3HOrTOESw1Wi5+8bL27moxY+Gg6XT26cBjBnkt9sJ+sO0VwJQP8N4JapGCzhdqL21MlQlOw3M/0xfjq5+0Vqs=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB3472.namprd12.prod.outlook.com (2603:10b6:208:d2::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Wed, 15 Apr
 2020 03:05:19 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d%8]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 03:05:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElUqac/lQTGQcE++S/h2otY2oah4q6YAgAAISgCAAAIWAIAAyQ3Q
Date: Wed, 15 Apr 2020 03:05:19 +0000
Message-ID: <MN2PR12MB40785C6264E06349DAC18DB2FCDB0@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
In-Reply-To: <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Changfeng.Zhu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T03:05:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c49aabf-e335-4b21-ae1f-0000b7e4fce9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T03:05:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3c60d790-dd24-4810-97df-000015248a06
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 764f801d-61dc-44e6-36a4-08d7e0e9d4b6
x-ms-traffictypediagnostic: MN2PR12MB3472:|MN2PR12MB3472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB347260F38EF82723A9FB9E92FCDB0@MN2PR12MB3472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(6506007)(81156014)(86362001)(9686003)(316002)(66946007)(8936002)(45080400002)(26005)(4326008)(186003)(8676002)(478600001)(76116006)(7696005)(53546011)(83080400001)(33656002)(55016002)(52536014)(5660300002)(2906002)(966005)(66476007)(64756008)(66556008)(71200400001)(110136005)(66446008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KilkZIfNqGrbRbawzBOCerjyzqm7j3hOXxmiH/H/Dg1keAeRQPa3hrNLscg1ruliaNARopAXQXV0b2UmTJ6h/lG+45rMunkZykYvqBuMDFprwJQw0aSaII/iUgmtesKFi7+KjVM0tZTp+UPNknvb3EuvgWDtR9kp/gNLCWQSznXpP9CQCYpkFeDOIK3qDMajUyJtE5I3aPKC3R8zalOJ7Agv5HFx3jMzotph7aPt6M8qfZHhBijWth/AH6T/6GABsgDLSDfAtkC39e5f8qm8/W0Ug+v3M9Ap/+MsVHto+hzjczPLDZahsIrsH3yyQFP+C+cBQrL7tFcf4q2n3P3jrV/r38H61WNlcmzlfSzlh2aX9z6Jldugz+WR86rgsQAiP/QVonEzFBHhVR4bQv4fxX9o/7uCw6Ye/MyvaL1P5fwa6NBIkkGrzQKjn8E8xrOOiQ8UNzuY0OCjRbOAiFozoKijkB9sPZmK6jCHo8v8j/y517iMkprQUAFFbt2lL+K9KBoPxIICVnknrs1mkDEzag==
x-ms-exchange-antispam-messagedata: TRnkroekICZPDuIgj1/VLMx43GdnUWRItUGcRR2zcjXwqJgx5YfEfIabVLKN7xvnpH6+RXMfj+BKcOyveSGXtoyD8Sx6r+fJ8HItTIRGwSqECg0WXDLceKYYL5BBgPsMy7B58RAG7MwKINobCplV6A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764f801d-61dc-44e6-36a4-08d7e0e9d4b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 03:05:19.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNbiaObXkHk+QHoNq8zHs1qYplD8iENpJSJTzPRuVjKoeGPGiM1R5OlQNUGJMCS3vlZvSXKzXj5yipcbyh/GnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3472
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGlzIGFjdHVhbGx5IGludHJvZHVjZWQgYXQgdmVyeSBlYXJseSBzdGFnZSB3ZSBlbmFibGVkIEdG
WE9GRiBmb3IgdGhlIGZpcnN0IHRpbWUgb24gUmF2ZW4gcGxhdGZvcm0uIEF0IHRoYXQgdGltZSBn
ZnhvZmYgY2FuJ3Qgd29yayB3aXRoIFZpZGVvIHBsYXkgYmFjayAodGhpcyBpcyBnZW5lcmFsIGlz
c3VlIGFjcm9zcyBhbGwgT1NlcykuIFNvIHdlIGRpc2FibGVkIGdmeG9mZiB3aGVuIHRoZXJlIGlz
IHdvcmtsb2FkIG9uIFZDTi4NCg0KRm9yIG1vc3QgQVNJQ3MsIGl0IHNoYWxsIGJlIHJlbW92ZWQu
IFRoZSBvbmx5IGNvbmNlcm4gaXMgc29tZSBvbGQgUmF2ZW4gcGxhdGZvcm0gd2hlcmUgdGhlIHJs
YyBmdyBmaXhlcyBhcmUgbm90IGF2YWlsYWJsZS4gDQoNCkkgaGFkIGEgcXVpY2sgY2hhdCB3aXRo
IEBaaHUsIENoYW5nZmVuZyB3aG8gd2lsbCBoYXZlIGEgcXVpY2sgdmFsaWRhdGlvbiBvbiBoaXMg
b2xkIFJhdmVuIHBsYXRmb3JtIHNvIHRoYXQgd2UgY2FuIHNhZmVseSByZW1vdmUgdGhpcyB3b3Jr
YXJvdW5kIGZpbmFsbHkuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+IA0KU2VudDogVHVl
c2RheSwgQXByaWwgMTQsIDIwMjAgMjM6MDANClRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVy
QGdtYWlsLmNvbT47IFpodSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPjsgWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPjsgWmh1LCBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdmNuOiBmaXggZ2Z4b2ZmIGlzc3Vl
DQoNCitIYXdraW5nDQoNCkhpIEhhd2tpbmcsDQoNCmNhbiB3ZSBkcm9wIHRoaXMgV0E/DQoNClRo
YW5rcyENCg0KSmFtZXMNCg0KT24gMjAyMC0wNC0xNCAxMDo1MiBhLm0uLCBKYW1lcyBaaHUgd3Jv
dGU6DQo+ICtSZXgNCj4NCj4gVGhpcyBpcyBpbnRyb2R1Y2UgYnkgYmVsb3cgcGF0Y2guDQo+DQo+
IGNvbW1pdCAzZmRlZDIyMmY0YmY3ZjRjNTZlZjQ4NTQ4NzJhMzlhNGRlMDhmN2E4DQo+IEF1dGhv
cjogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPg0KPiBEYXRlOsKgwqAgRnJpIEp1bCAyNyAxNzow
MDowMiAyMDE4ICswODAwDQo+DQo+IMKgwqDCoCBkcm0vYW1kZ3B1OiBEaXNhYmxlIGdmeCBvZmYg
aWYgVkNOIGlzIGJ1c3kNCj4NCj4gwqDCoMKgIHRoaXMgcGF0Y2ggaXMgYSB3b3JrYXJvdW5kIGZv
ciB0aGUgZ3B1IGhhbmcNCj4gwqDCoMKgIGF0IHZpZGVvIGJlZ2luL2VuZCB0aW1lIGlmIGdmeCBv
ZmYgaXMgZW5hYmxlZC4NCj4NCj4gwqDCoMKgIFJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxS
ZXguWmh1QGFtZC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+DQo+IE9uIDIwMjAtMDQtMTQgMTA6MjIgYS5t
LiwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIgMTQsIDIwMjAgYXQgODowNSBB
TSBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPiB3cm90ZToNCj4+PiBUdXJuIG9mZiBnZnhv
ZmYgY29udHJvbCB3aGVuIHZjbiBpcyBnYXRlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgOCArKysrKy0tLQ0KPj4+IMKgIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4+PiBpbmRleCBkYWIzNGY2Li5h
YTlhN2E1IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uYw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
Yw0KPj4+IEBAIC0zNjksOSArMzY5LDExIEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3Vz
ZShzdHJ1Y3QgDQo+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpIGNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmYWRldi0+dmNuLmlkbGVfd29yayk7DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgIG11dGV4
X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7DQo+Pj4gLcKgwqDCoMKgwqDCoCBhbWRncHVf
Z2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4+PiAtwqDCoMKgwqDCoMKgIGFtZGdwdV9kZXZp
Y2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsDQo+Pj4gQU1EX0lQX0JMT0NLX1RZUEVf
VkNOLA0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRF
KTsNCj4+PiArwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uY3VyX3N0YXRlID09IEFNRF9QR19T
VEFURV9HQVRFKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dm
eF9vZmZfY3RybChhZGV2LCBmYWxzZSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwNCj4+PiBBTURf
SVBfQkxPQ0tfVFlQRV9WQ04sDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4+PiArwqDCoMKgwqDCoMKgIH0NCj4+
Pg0KPj4gV2h5IGFyZSB3ZSB0b3VjaGluZyBnZnhvZmYgd2l0aCBWQ04/wqAgV2FzIHRoaXMgYSBs
ZWZ0b3ZlciBmcm9tIGJyaW5nIA0KPj4gdXA/wqAgQ2FuIHdlIGp1c3QgZHJvcCBhbGwgb2YgdGhp
cyBnZnhvZmYgc3R1ZmYgZnJvbSBWQ04gaGFuZGxpbmc/wqAgSSANCj4+IGRvbid0IHNlZSB3aHkg
dGhlcmUgd291bGQgYmUgYSBkZXBlbmRlbmN5Lg0KPj4NCj4+IEFsZXgNCj4+DQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKcKg
wqDCoCB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRwZ19w
YXVzZV9zdGF0ZSBuZXdfc3RhdGU7DQo+Pj4gLS0NCj4+PiAyLjcuNA0KPj4+DQo+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGkNCj4+PiBzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJQ0KPj4+IDdDSmFtZXMuWmh1JTQwYW1kLmNvbSU3QzNkZDkx
MzVjNzE3YTRiMzAxMWUzMDhkN2UwN2Y1MmI2JTdDM2RkODk2MWZlDQo+Pj4gNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIyNDcwOTc2MzM5MTg0NSZhbXA7c2RhdGE9WSUyQnQN
Cj4+PiBzSlFOQjFUWENROXY4NkRXJTJGMEZDNjNnT1NIc2Z6elpGdTBNRHZDSHclM0QmYW1wO3Jl
c2VydmVkPTANCj4+Pg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
