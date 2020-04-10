Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D5C352B6
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 04:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE2920936
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 04:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tTvexIIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2920936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2550F6EC55;
	Fri, 10 Apr 2020 04:18:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5286EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 04:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDx39feZY6W3NGcqkPwDQvDF05KSoxPaMRe09Ls3lZ++j/W5sFBW1Sj/epYoa1Y01mRHMLaJ4lRjVxf12TGfb3DcEgzPRq2uceoWW1TlZqjE9qIUrNa9MisdrXWPX2mI7DNMVI6aiBBawA6TuDagMbGJUPjo8ZH+yLoDPHysOjUBwvVSzIe41PrxIJUM5XFwbL84NTZwcVU3I9IRH+MFOUONi0AIumW+3FCYOKcK1Nt+ygkbmPhI07BA/ybYRmE24/ZcL669ELcxdKkUVQDVPSb21qM7JKv71D6k7hZ2N2oacFgHYLo5+cBe5Yrm6t4/SvF3xN51mqYGM0Nv61LJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38h+bbDbOLpLUsxIvFMArKv+uTEYM7YOB2MGgifHowk=;
 b=aJdiblk3AUQ0ud6A2FMjjMZ+CKSiF4q8R4j9OtCy6MNAgyJLgKwT4bxDC8XHbrDyEM35FD6WmL3fcvu+g2nvg/TaPnTfYyFbT5IfmPP311/1Y0gP4BLOr4+2tqlfEVcmwwO06eKW0lzGYx2bhwIyquefkwsXT6tGG9PyMP7NYOQbUuyBf83Z5PX6HI+WbesYSZdWUvxgo7Lelx3JiwTQHruwE6V7LtMQOCuAvjfE4SAof40t4K4s0mLXvcqLke/vgM2/JOWXUYX+hU/a3zIiMJW8lqpei+TXH5Cx9miHXl5tirIMn2Ckc7gJIc1ucfADtZ0JbYmqVVIYNjgKqaFmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38h+bbDbOLpLUsxIvFMArKv+uTEYM7YOB2MGgifHowk=;
 b=tTvexIIwwCwLWzNJGy1DFVEV/XrxoyVp8vOzVSJWYB8L3maljw9Zdj3w7k1hHccZ+ZQtxn1zxJI1g3eFBole1VzCzCVDZYdQhtyqOv+rISH/C4PddWiAXky1d7IRggPOy4rZ4jXElPUHa9jAD07PDr+eCg0zEmaWJHvlChz0tG4=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 04:18:02 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 04:18:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Topic: [PATCH] drm/amdgpu: add uncorrectable error count print in UMC
 ecc irq cb
Thread-Index: AQHWDuvs2CeYvPYiZkyw1SCSax4+4Khxv+xA
Date: Fri, 10 Apr 2020 04:18:02 +0000
Message-ID: <BYAPR12MB2888C4A6EA061C0A031D14F8B0DE0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200410035528.27347-1-guchun.chen@amd.com>
In-Reply-To: <20200410035528.27347-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-10T04:18:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7f57c989-c88e-4323-b70b-0000f4c33553;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-10T04:18:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6c5fa94c-7af8-4b87-a2fd-0000f077d9ce
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [218.79.249.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d243c94-d180-4005-0809-08d7dd062905
x-ms-traffictypediagnostic: BYAPR12MB2774:|BYAPR12MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2774BDDE2D11BA227ADCDAF9B0DE0@BYAPR12MB2774.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(33656002)(2906002)(55016002)(66446008)(66476007)(76116006)(316002)(66556008)(64756008)(110136005)(66946007)(53546011)(478600001)(71200400001)(9686003)(8936002)(6506007)(6636002)(5660300002)(81156014)(52536014)(8676002)(26005)(7696005)(186003)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmigUjlyK3Awu8up/f+s9t3HMdygvrKD4WsoNXJ0AMsqiVtSof06noclIXJ9zmOUEvvSSzhXf6bdqUaVMqn/+DI8SWnC4mRAarqNVkNQ+IxeorPtAlyP+kDPryjPT4tuikUUN97+3v2Ji1WAztXpPnnWv7qui8lPqdi2g8pWphzpxvh/cgZKuqsVnJYG/DZ9dZwO9aHp807Ra05H690F7A6Ug/ogIQ7Yn9q6YgOJn2YUujcM/npcd89Tx1ZFgsStgTGFi6jOf7KEQrd+zloua9N5NrUG8hGj6y3jskeEWkEQvQxRNSnMY3uMUCovjaiZ51OerUTY9dJV5jOCrkSsgfFyNt/u6SonDKOhH2zcme02BmI1vGmhHR/PPBTr6mlXH122VZPf/hq5UlvN+n/jefM3TTL0x74SSPYhW9R8W4XloW0Va+QiDGpBLhUnRBq3
x-ms-exchange-antispam-messagedata: RbYacS14kiYQuCAsoptwnO5Qq7wMyq9u9g2CL9/XFpx/XWkKP8Gmd3BnNq/t83V+hRcBLF7OjrQVg/FUSe5g+sIc4NW/bIm+l+J7LW2Yna58VitCIJo3nc7h6GXjwnMffkPemrUaX9DNIojEpjA2zQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d243c94-d180-4005-0809-08d7dd062905
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 04:18:02.1713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQQ26TFczwza8SIem4rTg7a+Z3094uoQ6tYDw7Ntg4Eu2saF4+d1Xv9Phhykg7ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT4NCj4gU2VudDogMjAyMMTqNNTCMTDI1SAxMTo1NQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBM
aSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IFpob3UxLCBUYW8NCj4gPFRhby5aaG91MUBh
bWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT4NCj4gQ2M6IENo
ZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kZ3B1OiBhZGQgdW5jb3JyZWN0YWJsZSBlcnJvciBjb3VudCBwcmludCBpbiBVTUMNCj4gZWNj
IGlycSBjYg0KPiANCj4gVW5jb3JyZWN0YWJsZSBlcnJvciBjb3VudCBwcmludGluZyBpcyBtaXNz
ZWQgd2hlbiBpc3N1aW5nIFVNQyBVRSBpbmplY3Rpb24uDQo+IFdoZW4gZ29pbmcgdG8gdGhlIGVy
cm9yIGNvdW50IGxvZyBmdW5jdGlvbiBpbiBHUFUgcmVjb3ZlciB3b3JrIHRocmVhZCwNCj4gdGhl
cmUgaXMgbm8gY2hhbmNlIHRvIGdldCBjb3JyZWN0IGVycm9yIGNvdW50IHZhbHVlIGJ5IGxhc3Qg
ZXJyb3IgaW5qZWN0aW9uIGFuZA0KPiBwcmludCwgYmVjYXVzZSB0aGUgZXJyb3Igc3RhdHVzIHJl
Z2lzdGVyIGlzIGF1dG9tYXRpY2FsbHkgY2xlYXJlZCBhZnRlciByZWFkaW5nDQo+IGluIFVNQyBl
Y2MgaXJxIGNhbGxiYWNrLiBTbyBhZGQgc3VjaCBtZXNzYWdlIHByaW50aW5nIGluIFVNQyBlY2Mg
aXJxIGNiIHRvIGJlDQo+IGNvbnNpc3RlbnQgd2l0aCBvdGhlciBSQVMgZXJyb3IgaW50ZXJydXB0
IGNhc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5j
IHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMNCj4gaW5kZXggZjRkNDA4NTUxNDdi
Li4yNjdmN2MzMGY0ZGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91bWMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dW1jLmMNCj4gQEAgLTEyMSw2ICsxMjEsOSBAQCBpbnQgYW1kZ3B1X3VtY19wcm9jZXNzX3Jhc19k
YXRhX2NiKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiANCj4gIAkvKiBvbmx5IHVu
Y29ycmVjdGFibGUgZXJyb3IgbmVlZHMgZ3B1IHJlc2V0ICovDQo+ICAJaWYgKGVycl9kYXRhLT51
ZV9jb3VudCkgew0KPiArCQlkZXZfaW5mbyhhZGV2LT5kZXYsICIlbGQgdW5jb3JyZWN0YWJsZSBl
cnJvcnMgZGV0ZWN0ZWQgaW4NCj4gVU1DIGJsb2NrXG4iLA0KPiArCQkJZXJyX2RhdGEtPnVlX2Nv
dW50KTsNCj4gKw0KPiAgCQlpZiAoZXJyX2RhdGEtPmVycl9hZGRyX2NudCAmJg0KPiAgCQkgICAg
YW1kZ3B1X3Jhc19hZGRfYmFkX3BhZ2VzKGFkZXYsIGVycl9kYXRhLT5lcnJfYWRkciwNCj4gIAkJ
CQkJCWVycl9kYXRhLT5lcnJfYWRkcl9jbnQpKQ0KPiAtLQ0KPiAyLjE3LjENCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
