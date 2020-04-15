Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43654C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 02:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB2320732
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 02:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KEuo6uUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB2320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912F889BB3;
	Wed, 15 Apr 2020 02:11:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3850089BB3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 02:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZEO983hfmco8mJTxInMHOU+EdkJPj4BkFYBsVInUWoQZdeDOQm1WpgJ52jtZ4SiDlVi+M+VT2973Bf6z2mE1lVnsA1CzVAdZiVqIWFthKMTMqZRyQo3rUIJZ6s+MjadMxfdzJRWZpRSo/mGUq50Tl0FcO6QOKfgh8hXDzl+l82ScrlHW2DXxT6a6/YoO7iK5KzT5HNcsvzLVbFzjc532ks6LcG1dq3b7ZfhCgKfQKx4p5oVUB1cK9cda9y01/7swPM2lPGqgGU+75iq3G0DKFS9MQmdIhoif6KZJ7V6TIFNyyXFKJ0Dhz0+FMlsGtUy2gKIzwSuJoobjcQTiWZXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kb/DTglIc2KOurO1RwZ1yecTwL7Cy5mptCiPjWMjC4=;
 b=X8B34Tmj57JTc6nvk2zAoneLyQ703zEutDJALfh9EIH1DyKkYeTBfzqqItmIO87VTg0GNYzvisLfqtmT6G5pYGqsOZi1v1hP+FehSxtmw2/KzwTkJJ30IztSzBimzYtnb4C/5pBAnyhvrnyS4JJoXuGCQOcAaytBJpIScK/w6bU+xPl6DzXuAMzfe4jnDF1Rne3auovBp/gtfx7rOx/l8yTkcC4kw96GabVvl8XRUX6wX22IaxetKHiPMftUUCjR0UNVPOFB+5VSQXja6Y0wPg/cdd/vChz9daXSr7QAd4cfRQu01fY3sRv56zI7U3YzzrD4Rh3XPDBU0Yx8b0WY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kb/DTglIc2KOurO1RwZ1yecTwL7Cy5mptCiPjWMjC4=;
 b=KEuo6uUUJMkcrH1uQDCYyn5u0YTzPairo3bXuOiNIZ+rAWZDRMWFiBXtZU9Tkn1mXOdhiOt5I/+tnrpkuxiVkiuEKEk3fRrHiwzaO3Ok7YO4UPfhQb5aUEP4XPqu3io/cwRQfnOBSlEKvlBiIPV6maTPBh2pnCSYl1rDi7jSz/w=
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 02:11:40 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 02:11:39 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElT5MMa9hF5D/kyPXcmir4uROah4q6cAgAAISgCAAAIWAIAAu5gw
Date: Wed, 15 Apr 2020 02:11:39 +0000
Message-ID: <MN2PR12MB28968609F3BC15F64232D3CAFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
In-Reply-To: <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T02:11:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39c7a867-0d14-422e-9b6b-000073985680;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T02:11:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7e82afe0-8cca-442f-9bce-0000974fab6f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef392d06-8f95-4daa-7d8a-08d7e0e25591
x-ms-traffictypediagnostic: MN2PR12MB4063:|MN2PR12MB4063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4063F876B784098E0EF5CC27FDDB0@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(26005)(81156014)(55016002)(66476007)(83080400001)(8676002)(86362001)(4326008)(71200400001)(6636002)(5660300002)(186003)(8936002)(53546011)(9686003)(76116006)(966005)(64756008)(66556008)(478600001)(45080400002)(33656002)(66446008)(110136005)(316002)(2906002)(52536014)(7696005)(66946007)(6506007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRZXupRJ4Qz8nCHNPxVh+2mwZirRy+zzax/m57rWf4QzF7OaJi/CVyQoF3hqq6ipmx/oiShadGl9m5cRLrosKyrGk9IeRUIaMRMS+Zqv3gNarH7t++twbCRuI10ijzrdEulhhkkCT35G7f4BL6Xbm1B44PLLyhKRJqUGHhwWAD8FgoGSwZpOuzJujIoTg9tcv2RUaTLX9NUdq5OGX3991XCNENvsRpSy1sh9n7FzR11PGwHbF1TwpuKDC3AHal4ICnNw8GgcJr5TKBelcZmeV4o6Aik61XtfwXSeOSKWBOPA+j9AuensNSxVHBwKNoOpy5uLpFQhrnnZcRwJkKptJLKjaVLsZlp3irLGFWrEj47M4wPgtgmFCqD63qeBVuTPvR67unZNnm+UZPqwRnbiUphGiNkNnR08oXqLTGQ8YDDteD7Sv7581bfZYWcAVhrnwbV42xBGptp+iLbcoOzzTfkBynRVj7f1aQN7lg95oFrBLsu6/dS2qiGyfNQ53iTJr52yh9O4mrTRh7z29X2EDA==
x-ms-exchange-antispam-messagedata: ZVDu41OOuEyH6iN8N+O48W3btzHgWya2CP/8KgBBz/+2lU0i3In82Zun0ebkdybG3mC9/PifmECD6Fx6ji11kwJb/c834HAu/y957XUE8U628I8mjW3v9C4Msp3I0vUGNzlCS5eTRjJk6TDi2e5Vvg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef392d06-8f95-4daa-7d8a-08d7e0e25591
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 02:11:39.7864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pYjgB3A4Ll6Ize8jeJE0FY8ko1Ns+0lPUtYvHRUXCqVg3vGTqw51iSvDnPNK3S84Q1heBgjQy+h+nqdhc7D4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQor
UmF5DQoNCkJSLA0KQ2hhbmdmZW5nLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+IA0KU2VudDogVHVlc2RheSwgQXByaWwg
MTQsIDIwMjAgMTE6MDAgUE0NClRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT47IFpodSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPjsgWmh1LCBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdmNuOiBmaXggZ2Z4b2ZmIGlzc3VlDQoNCitIYXdr
aW5nDQoNCkhpIEhhd2tpbmcsDQoNCmNhbiB3ZSBkcm9wIHRoaXMgV0E/DQoNClRoYW5rcyENCg0K
SmFtZXMNCg0KT24gMjAyMC0wNC0xNCAxMDo1MiBhLm0uLCBKYW1lcyBaaHUgd3JvdGU6DQo+ICtS
ZXgNCj4NCj4gVGhpcyBpcyBpbnRyb2R1Y2UgYnkgYmVsb3cgcGF0Y2guDQo+DQo+IGNvbW1pdCAz
ZmRlZDIyMmY0YmY3ZjRjNTZlZjQ4NTQ4NzJhMzlhNGRlMDhmN2E4DQo+IEF1dGhvcjogUmV4IFpo
dSA8UmV4LlpodUBhbWQuY29tPg0KPiBEYXRlOsKgwqAgRnJpIEp1bCAyNyAxNzowMDowMiAyMDE4
ICswODAwDQo+DQo+IMKgwqDCoCBkcm0vYW1kZ3B1OiBEaXNhYmxlIGdmeCBvZmYgaWYgVkNOIGlz
IGJ1c3kNCj4NCj4gwqDCoMKgIHRoaXMgcGF0Y2ggaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgZ3B1
IGhhbmcNCj4gwqDCoMKgIGF0IHZpZGVvIGJlZ2luL2VuZCB0aW1lIGlmIGdmeCBvZmYgaXMgZW5h
YmxlZC4NCj4NCj4gwqDCoMKgIFJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFt
ZC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+DQo+DQo+IE9uIDIwMjAtMDQtMTQgMTA6MjIgYS5tLiwgQWxleCBE
ZXVjaGVyIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIgMTQsIDIwMjAgYXQgODowNSBBTSBKYW1lcyBa
aHUgPEphbWVzLlpodUBhbWQuY29tPiB3cm90ZToNCj4+PiBUdXJuIG9mZiBnZnhvZmYgY29udHJv
bCB3aGVuIHZjbiBpcyBnYXRlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8
SmFtZXMuWmh1QGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jIHwgOCArKysrKy0tLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4+PiBpbmRleCBkYWIzNGY2Li5hYTlhN2E1IDEw
MDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0K
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPj4+IEBA
IC0zNjksOSArMzY5LDExIEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3Qg
DQo+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+
dmNuLmlkbGVfd29yayk7DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmFk
ZXYtPnZjbi52Y25fcGdfbG9jayk7DQo+Pj4gLcKgwqDCoMKgwqDCoCBhbWRncHVfZ2Z4X29mZl9j
dHJsKGFkZXYsIGZhbHNlKTsNCj4+PiAtwqDCoMKgwqDCoMKgIGFtZGdwdV9kZXZpY2VfaXBfc2V0
X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsDQo+Pj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLA0KPj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4+PiAr
wqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uY3VyX3N0YXRlID09IEFNRF9QR19TVEFURV9HQVRF
KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3Ry
bChhZGV2LCBmYWxzZSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1
X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwNCj4+PiBBTURfSVBfQkxPQ0tf
VFlQRV9WQ04sDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4+PiArwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4gV2h5
IGFyZSB3ZSB0b3VjaGluZyBnZnhvZmYgd2l0aCBWQ04/wqAgV2FzIHRoaXMgYSBsZWZ0b3ZlciBm
cm9tIGJyaW5nIA0KPj4gdXA/wqAgQ2FuIHdlIGp1c3QgZHJvcCBhbGwgb2YgdGhpcyBnZnhvZmYg
c3R1ZmYgZnJvbSBWQ04gaGFuZGxpbmc/wqAgSSANCj4+IGRvbid0IHNlZSB3aHkgdGhlcmUgd291
bGQgYmUgYSBkZXBlbmRlbmN5Lg0KPj4NCj4+IEFsZXgNCj4+DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKcKgwqDCoCB7DQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRwZ19wYXVzZV9zdGF0
ZSBuZXdfc3RhdGU7DQo+Pj4gLS0NCj4+PiAyLjcuNA0KPj4+DQo+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9uYW0xMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGkNCj4+
PiBzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wMiU3QzAxJQ0KPj4+IDdDSmFtZXMuWmh1JTQwYW1kLmNvbSU3QzNkZDkxMzVjNzE3YTRi
MzAxMWUzMDhkN2UwN2Y1MmI2JTdDM2RkODk2MWZlDQo+Pj4gNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzIyNDcwOTc2MzM5MTg0NSZhbXA7c2RhdGE9WSUyQnQNCj4+PiBzSlFO
QjFUWENROXY4NkRXJTJGMEZDNjNnT1NIc2Z6elpGdTBNRHZDSHclM0QmYW1wO3Jlc2VydmVkPTAN
Cj4+Pg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
