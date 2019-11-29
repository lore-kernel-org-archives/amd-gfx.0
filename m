Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D67C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17AC21774
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AC21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575546E899;
	Fri, 29 Nov 2019 09:24:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BACE6E899
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRA4lD0c5n3NYcmLjE2S/vegxT2ud8jRyMfhxLl3VTzr0IvoFzE4zIrULNvV0Wk0lQqAIGHQWWDevLBqL52aJO85c6cUo7qtpjqTUMtWoXgLQTJumIWqBcvsAMHSx795Nvw/mSJHf3PGjlHq9MS9mADNp5zFnAUPR3anM9sRGp7SVCEHInutzXSq1nKd+lCHIEHr+Jm4fcveSblxCTS9gLrwjUJDRdmGY+ZWZdat7eVOMuFy0I69kqTxmbRpHpBvpH9iQq0IBeJ03pH1qJKg8dLVrUjkxGDEk1jm9hKsoh7e1ApTPTuhE3KyAETTxfI2RXBqvFNfbF3//q4fftWbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vLIAh/CR1Q7Y0lcbEWHOTenlLHFPSEihdfhMwG3Xzc=;
 b=Y8hLEwlthTthWHLrCFGdsaK0VB8exr8OXjbt3xD8AvNf7kaUxsyyftI3UJ7zpemMaW6GHLSYyChQk30TZlESYs7UIkcviP7CDpdp3ZFrCarWwHEfIj3gnLgTX5B4KUKbNH9MnSIacMvfjFX8/h5u3TwpSscPbb3e87UDEfkGd3XHGucGVLd8wATPR4GQaWEJZA9Qyvx/iBjCElpCSatijRk3EgbtlD3ANHeCmqKP2vHbXwC4UyG795kh5scRQjfncOvKrQRDdwtJzZeE5m1Rwyimdn7/7FwMnqWPwsbnV6xrUYYr0I9nwBNFnraL0ICOvW48oa1Rihc3yylv60eurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:23:57 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:23:57 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpo5MI8MlYXFVxEaZ238/KW/rXaeh1OYAgAAAgWCAAAZYgIAABCWAgAAAQWA=
Date: Fri, 29 Nov 2019 09:23:57 +0000
Message-ID: <MN2PR12MB3933037335669310C4A0002184460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB39330EA36530757CE5F3D0B784460@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM5PR12MB1418A6FEA53EDF93DCB472EFFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB141820DC9911BB959FD04C35FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB141820DC9911BB959FD04C35FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-29T09:21:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=abc06a29-8711-4f88-a7f8-000034df0fa2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 146beefe-91d5-4dd1-1cb6-08d774addc64
x-ms-traffictypediagnostic: MN2PR12MB3663:|MN2PR12MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3663D7C0952C529959FDB3F384460@MN2PR12MB3663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(13464003)(189003)(199004)(102836004)(76176011)(76116006)(7696005)(110136005)(256004)(45080400002)(6436002)(6506007)(14454004)(66066001)(446003)(6246003)(26005)(11346002)(53546011)(186003)(66946007)(66556008)(52536014)(71190400001)(5660300002)(71200400001)(66446008)(66476007)(229853002)(966005)(9686003)(86362001)(478600001)(55016002)(64756008)(6306002)(2906002)(8936002)(33656002)(316002)(81156014)(7736002)(305945005)(8676002)(25786009)(99286004)(74316002)(2501003)(81166006)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgu7Np5bKpSt+a8ec/Vx0/Deq8KXPG3gCwwS0uTQnPTljult3Fp1Qp98DFT0ftVJz+nd1fZ5ygkYlSUub0wDDdPeQKCl8Yt0EK2Tt4n4kiY9W3+S7y82q+P6Jpmjz8OraXfZ6dJ2xswyOcZ/Bl46gj1jyCKfRzXFXD/sI1CqkDfJdXbOSzgP5E/8gaEdqtXwNIke/xmJmrwRUY6ZOpJbkroJQMaBCN87bib4YzBfgYBiAVGmdwD9iC7G3PDd88HAGNFTYJ5xuPT2FcyJNbVWjznQfq44LD/zJpTDLaNdinOQJPxdlJgXyG70bfUV/NkhIwMbt6e7lkwM5qs7ClJ/AwoUh/FlfGyGp7jyQu6XScB++aV6AwLZrLfpuQ+ruqqIN9HE74tQdBM6PSQvgKAbdO999RGvTrA8b1gpYiBBm/nyzHDrsg+90v1C4WucwrZYjuYQLZxhWAmBeQrLUMg8h6ByKbgXc+/nvDvmxdaaTWQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146beefe-91d5-4dd1-1cb6-08d774addc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:23:57.0787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHvR7xd+XOXNxLqSqe7JKh2rL+isqQBoSKE+2QIo9/EkSP+vsC0JtNxRuzBeTHB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vLIAh/CR1Q7Y0lcbEWHOTenlLHFPSEihdfhMwG3Xzc=;
 b=FCbslhX0T4N6Ia14TWo7V6+pAzd/QQ3P+UAlhKR+sfIsg/Llkc4bKfpURHUozYrtsJkikr3hKKCEZu5CDfj8t4Vk2qeQXM4X3JL92j/M0oyuNJY7Li0/VwW8zazBb7h5NBegH5g0ApIL+x8UvlyO0w12yiFl0kdKk/Yl/lmy9sg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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

RG8geW91IG1lYW4gdGhlIGNvZGUgcGF0aCBvZiAiIGlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5
cGUgIT0gQU1ER1BVX0ZXX0xPQURfUFNQKSAiICwgaWYgc28gYWxyZWFkeSBoYW5kbGVkIA0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmlydHVh
bGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+IA0KU2VudDogRnJpZGF5LCBO
b3ZlbWJlciAyOSwgMjAxOSA1OjIyIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8y
XSBkcm0vYW1kZ3B1OiBmaXggR0ZYMTAgbWlzc2luZyBDU0lCIHNldA0KDQpbQU1EIFB1YmxpYyBV
c2VdDQoNCkJUVywgUGxlYXNlIGFsc28gbWFrZSB0aGUgY2hhbmdlIGZvciBiYWNrZG9vciBsb2Fk
aW5nIGNvZGUgcGF0aCBhcyB3ZSBuZWVkIHRoYXQgZm9yIGZ1cnRoZXIgQVNJQyBicmluZyB1cC4g
VGhhbmtzLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogWmhhbmcsIEhhd2tpbmcgDQpTZW50OiAyMDE55bm0MTHmnIgyOeaXpSAxNzowOA0K
VG86IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogZml4IEdGWDEwIG1p
c3NpbmcgQ1NJQiBzZXQNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQ0KDQpUaGUgZ2Z4MTAgUEcgYW5kIGdmeG9mZiBhcmUgZnVsbHkgY29udHJv
bGxlZCBieSBSTEMgYW5kIFNNVSBmdyBhbmQgZG9uJ3QgbmVlZCBkcml2ZXIgdG8gYmUgaW52b2x2
ZWQgYW55bW9yZS4gU28gdGhlIGxlZ2FjeSBwcm9ncmFtaW5nIGZvciBnZnhfaWRsZV90aHJlc2hv
bGQuZXRjIHdpbGwgbm90IGJlIGFwcGxpZWQgdG8gZ2Z4MTAuIA0KDQpNb3JlIGFnZ3Jlc3NpdmVs
eSwgbGV0J3MgZHJvcCBnZnhfdjEwXzBfaW5pdF9wZyBhbmQganVzdCBpbml0IGNzYi4gDQoNClJl
Z2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBN
b25rIDxNb25rLkxpdUBhbWQuY29tPiANClNlbnQ6IDIwMTnlubQxMeaciDI55pelIDE2OjQ3DQpU
bzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogZml4
IEdGWDEwIG1pc3NpbmcgQ1NJQiBzZXQNCg0KRm9yIG5vdyBpbml0X3BnKCkgaXMgZ29vZCBlbm91
Z2ggZm9yIGJhcmUtbWV0YWwgYW5kIFNSLUlPViwgYnV0IGNoZWNrb3V0IEdGWDksIHRoZXJlIGFy
ZSBtb3JlIGpvYnMgaW4gaW5pdF9wZygpLCBzbyBpbiB0aGUgZnV0dXJlIEknZCBleHBlY3QgdGhl
cmUgd2lsbCBiZSBNb3JlIGxpbmVzIGNvbWUgaW50byBpbml0X3BnKCkgb24gZ2Z4MTAgYW5kIGJ5
IHRoYXQgdGltZSBJIG5lZWQgdG8gbW9kaWZ5IGluaXRfcGcoKSAsIA0KDQpTbyBJTUhPIHRoZSBi
ZXN0IHdheSBpcyB1c2UgaW5pdF9jc2IoKSBmcm9tIHRoZSBiZWdpbm5pbmcgDQoNClRoYW5rcw0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1
YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiANClNlbnQ6IEZyaWRheSwg
Tm92ZW1iZXIgMjksIDIwMTkgNDo0MyBQTQ0KVG86IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBHRlgx
MCBtaXNzaW5nIENTSUIgc2V0DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0NCg0KSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBpbnRyb2R1Y2Ug
U1JJT1Ygc3BlY2lmaWMgcGF0aCBoZXJlLiBUaGUgZ2Z4X3YxMF8wX2luaXRfcGcgc2hvdWxkIGJl
IGdvb2QgZW5vdWdoIHRvIGNvdmVyIGJvdGggYmFyZS1tZXRhbCBhbmQgdmlydHVhbGl6YXRpb24g
Y2FzZS4gDQoNCllvdSBjYW4gZHJvcCB0aGUgdGxiIGZsdXNoIGluIHRoYXQgZnVuY3Rpb24gaWYg
dGhhdCdzIHlvdXIgbWFqb3IgY29uY2Vybi4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTW9uayBMaXUNClNlbnQ6IDIwMTnlubQxMeac
iDI55pelIDE2OjI0DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUs
IE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1
OiBmaXggR0ZYMTAgbWlzc2luZyBDU0lCIHNldA0KDQpzdGlsbCBuZWVkIHRvIGluaXQgY3NiIGV2
ZW4gZm9yIFNSSU9WDQoNClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA4ICsrKysr
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4IDc0ZWRmZDkuLjIzMGU4
YWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0xODc0LDE0
ICsxODc0LDE2IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpICB7DQogCWludCByOw0KIA0KLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpKQ0KLQkJcmV0dXJuIDA7DQotDQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0g
QU1ER1BVX0ZXX0xPQURfUFNQKSB7DQogCQlyID0gZ2Z4X3YxMF8wX3dhaXRfZm9yX3JsY19hdXRv
bG9hZF9jb21wbGV0ZShhZGV2KTsNCiAJCWlmIChyKQ0KIAkJCXJldHVybiByOw0KIA0KKwkJaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KKwkJCWdmeF92MTBfMF9pbml0X2NzYihhZGV2KTsN
CisJCQlyZXR1cm4gMDsNCisJCX0NCisNCiAJCXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsN
CiAJCWlmIChyKQ0KIAkJCXJldHVybiByOw0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2hhd2tp
bmcuemhhbmclNDBhbWQuY29tJTdDYzM0M2FmYTlhYTIzNGNiYjgyNzUwOGQ3NzRhNTcyNjglN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA2MTI3Mjc3MzUz
MDg2JmFtcDtzZGF0YT1LdCUyRmQxNjgwUmMzbHlGd3o0bmc1ZUE3SnhpWVdqZjF3aERCcGZuSHpU
SnMlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
