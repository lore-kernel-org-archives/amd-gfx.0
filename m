Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D37C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 03:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208262071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 03:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208262071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A0389D58;
	Tue, 26 Nov 2019 03:11:19 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740075.outbound.protection.outlook.com [40.107.74.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5253F89D58
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 03:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5aQ6cYiQSFbhRf7k98pNBPtEzd6IZaSkFaFKDx0wyAZfqXROFEUyxCRhzTB/qdLld2VXvQVqac/3iUcuLFz8muIqVgOwA1fvSJydBctzsCeZ/apsWsNUMGVOI3O6L6+xo007wz7/VxsCwYIeBlal4WzRbN3mesq7PKL+kkhFQi/i7/jNQg9Al+Mv+PYp4/hVvjNc/NdDl3pQt/gDCYNbI7GHSn8wcSNR9ucexiEAhLPZ+pp9z4/IiJ9phjN57/iHhOTBtK1wt2QmMCJDui5vvtOJHFcOyoAThtG97EnOMTLfx/t9Z2fdyzfD+nsIPZcbibjy+/A9CUM4eIxeWar4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbEU2aH0LGqi4d2f0js8JHsPXdEdIZLJTNbx8/lW/WQ=;
 b=ep+0E2RBhP/grcXyBD+FSeOfnK1Rd0oitP0EmNxRcyA+k55svertS7j+f5yvlreHsXTQ5TKkpHRlr+7IEer8X2ZNjLXeeJ2FP8cz6DE2U9QW53pEKYVfkGOjSTzVzC6Qijxhi6rW0kqIKDJR7VRvJwW0uQcy59uoyjBHWGc6CSdwPcnHWP16nvx16E71trbF/fxEYj7xAnYnSCMCjrijZJHBsGQkK1Pob47iXkXX6Xc6QpMbMP905uzsBJ9Ih+aXQEpE5N/GQq6XBDPSMiQH+kMKepWuawErvAT1eyiEtFQPsGwXrnsh0M8i5otRVOBCBPYDQCTaFGLl4hOK7t+MlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3679.namprd12.prod.outlook.com (10.255.86.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 03:11:16 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 03:11:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: flag vram lost on baco reset for VI/CIK
Thread-Topic: [PATCH] drm/amdgpu: flag vram lost on baco reset for VI/CIK
Thread-Index: AQHVo6s15LuyhD07bkaaQDFXCeYlbKecxspw
Date: Tue, 26 Nov 2019 03:11:16 +0000
Message-ID:
 <MN2PR12MB334444E864912858AB31DE4FE4450@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191125161239.347655-1-alexander.deucher@amd.com>
In-Reply-To: <20191125161239.347655-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a88607bd-b204-4219-9995-00008d42f44c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-26T03:10:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74429744-0276-42b6-6a95-08d7721e4d3f
x-ms-traffictypediagnostic: MN2PR12MB3679:|MN2PR12MB3679:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36792F42E2BEE2DD110B3E9CE4450@MN2PR12MB3679.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(13464003)(305945005)(8936002)(2501003)(81156014)(81166006)(66946007)(76116006)(66446008)(71200400001)(110136005)(2906002)(5660300002)(52536014)(3846002)(316002)(66066001)(71190400001)(26005)(6116002)(66556008)(64756008)(8676002)(66476007)(6436002)(14454004)(446003)(99286004)(11346002)(229853002)(45080400002)(6246003)(25786009)(478600001)(966005)(14444005)(256004)(6306002)(6506007)(33656002)(4326008)(53546011)(55016002)(76176011)(102836004)(186003)(7736002)(7696005)(74316002)(86362001)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3679;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exCqLBRlsz8EwFYh/8yeJ0HQV3vKx/i2n5eR3hyv5ojibX9Ad9lbsWBM7dS0Lz4OC45m4vmg9hyWS8aT+rBeZxurrHOCzDOp6eu9GDfJbIfOvntjbHtcITDtnsmq5UkLWuv1OVdw2lngY5DShFt+cc9O5AHixoU3glXhpafXFlOEInrTvXBz8P7OrsbbW25w51ixMCtRaCeb5fUJ1KFHDaP89dzy8ggfdy4cUhGtMp5MvfTXpk/ISvAnndZn57wonoSnMhP6TIwMwzqH4W47NxSMscFGQ68iDizS8+tlPAC6KXd4fdn8Ia+1SPI3Ku/F2QCuFfLzQlyKz3WdEsr1/4jVNxqbBCvst2G6oecgQwZb+Na1dYpejy3yef0Ra/RcIAUsXGgCQ2FiIxA2Yu1NM0nip7GRCet3CKfHVUtZ9HJB0+t8g3XIZ9QIOQpFgggzA5WYknuB0eQr2pvmjYlj9VhcURzzcpdBnzdCgcauShk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74429744-0276-42b6-6a95-08d7721e4d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 03:11:16.5922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsrhBJ9f8451QnimeHJCKEpRFWUXGkqPrttKy/ptlTsO/MsPCCC4Lrz3Jy34g3qQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbEU2aH0LGqi4d2f0js8JHsPXdEdIZLJTNbx8/lW/WQ=;
 b=ssTEeRd5DPvNmYfzWsUu6Wl46AdgSyNI7bLAzA9E/7Pd5qVGP/lwo6iuDQwxTbunHW8w3niG8uZglx6XLdbig6WRHBgQzDX4e6D5G6CacFt5Cs4RRAfw0XJdEb8SEEHr9HR9HN1hTrxyNfLz9qsCJu5pZNYTj5PaLvf+HOVAYkg=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126031116.RBT4k8Dn6x2JlALGv7vvma5TDu8QiTV7eM8uHkBX6WM@z>

QWNrZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciAyNiwgMjAxOSAxMjoxMyBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmbGFnIHZyYW0gbG9zdCBv
biBiYWNvIHJlc2V0IGZvciBWSS9DSUsNCj4gDQo+IFZJL0NJSyBCQUNPIHdhcyBpbmZsaWdodCB3
aGVuIHRoaXMgZml4IGxhbmRlZCBmb3IgU09DMTUvTlYuDQo+IEFkZCB0aGUgZml4IHRvIFZJL0NJ
SyBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Np
ay5jIHwgNyArKysrKy0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgIHwgNyAr
KysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYw0KPiBpbmRleCA5NjhiYzcwNmI5
NGQuLjFkZmU0YTEzMzdjZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvY2lrLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMNCj4gQEAg
LTEzNjMsMTAgKzEzNjMsMTMgQEAgc3RhdGljIGludCBjaWtfYXNpY19yZXNldChzdHJ1Y3QgYW1k
Z3B1X2RldmljZQ0KPiAqYWRldikgIHsNCj4gIAlpbnQgcjsNCj4gDQo+IC0JaWYgKGNpa19hc2lj
X3Jlc2V0X21ldGhvZChhZGV2KSA9PSBBTURfUkVTRVRfTUVUSE9EX0JBQ08pDQo+ICsJaWYgKGNp
a19hc2ljX3Jlc2V0X21ldGhvZChhZGV2KSA9PSBBTURfUkVTRVRfTUVUSE9EX0JBQ08pIHsNCj4g
KwkJaWYgKCFhZGV2LT5pbl9zdXNwZW5kKQ0KPiArCQkJYW1kZ3B1X2luY192cmFtX2xvc3QoYWRl
dik7DQo+ICAJCXIgPSBzbXU3X2FzaWNfYmFjb19yZXNldChhZGV2KTsNCj4gLQllbHNlDQo+ICsJ
fSBlbHNlIHsNCj4gIAkJciA9IGNpa19hc2ljX3BjaV9jb25maWdfcmVzZXQoYWRldik7DQo+ICsJ
fQ0KPiANCj4gIAlyZXR1cm4gcjsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIGlu
ZGV4IDg3MWMwYjhjNmIwYi4uZTRmNDIwMWIzYzM0DQo+IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZpLmMNCj4gQEAgLTgwNCwxMCArODA0LDEzIEBAIHN0YXRpYyBpbnQgdmlfYXNpY19yZXNl
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gew0KPiAgCWludCByOw0KPiANCj4gLQlp
ZiAodmlfYXNpY19yZXNldF9tZXRob2QoYWRldikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKQ0K
PiArCWlmICh2aV9hc2ljX3Jlc2V0X21ldGhvZChhZGV2KSA9PSBBTURfUkVTRVRfTUVUSE9EX0JB
Q08pIHsNCj4gKwkJaWYgKCFhZGV2LT5pbl9zdXNwZW5kKQ0KPiArCQkJYW1kZ3B1X2luY192cmFt
X2xvc3QoYWRldik7DQo+ICAJCXIgPSBzbXU3X2FzaWNfYmFjb19yZXNldChhZGV2KTsNCj4gLQll
bHNlDQo+ICsJfSBlbHNlIHsNCj4gIAkJciA9IHZpX2FzaWNfcGNpX2NvbmZpZ19yZXNldChhZGV2
KTsNCj4gKwl9DQo+IA0KPiAgCXJldHVybiByOw0KPiAgfQ0KPiAtLQ0KPiAyLjIzLjANCj4gDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWUNCj4gZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
DQo+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDZXZhbi5xdWFuJTQwYW1kLmNvbSU3QzhhNTgwMjZi
NjZkMjQ4YjI3ZQ0KPiAyMjA4ZDc3MWMyNTUxOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzElN0M2MzcNCj4gMTAyOTUxODE0MjAwNjE3JmFtcDtzZGF0YT03bEtOZkc4
TnB6QktzbEtJb092c2V5bDJhd2xNMURjeFNObnR2JTJGDQo+IFVBQ2p3JTNEJmFtcDtyZXNlcnZl
ZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
