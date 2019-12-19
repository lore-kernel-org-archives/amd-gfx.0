Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB59C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 01:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59656218AC
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 01:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ss0V1U3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59656218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D917D6E0F3;
	Thu, 19 Dec 2019 01:49:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBE76E0F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 01:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beJaf7R1VHJmJiXl9HAuvG36eV8iCW98vqwLdev6Tg+KaUfosP9YM9g04f7krEAVo3UabSbOpjzVY3gVAcK3FxQ6nDzwHxnHkCDzd1tzsJGaL/fIc59FEWhTTuMQ3gr0JQXRbMcOtWZO/XOCiJ9LrPzX/AMEGLivT6Wxn1ZBcz/tNNn2yfB2U6rX1c9MwhIwEi7Izlv453e8TX8KO6o0bX2v7jWbmUDm9J0GpZ1UkRTrDapazB7pzWBMNpX+A1qtJcOMVAERouM3oU+fcy6+3S77EbFe59K6j00oENOZFdzWSHsnJ3Qs530/R299Id8gJ1Ic/KRxaR94WCN8s3f2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZn6DFOlQuNmby2f4oSZVBH2gIm83fwa+Q6KxVqqk9o=;
 b=Izc5WAUVYd2KpnOYE4RXV7wKlVDZBnXWuJjpvgpae5Gq+99RMNGGL5bJfgQBWODru2XlY6ECUVkPufmDM6Byc96h6P/0T9aro7tzLFHR2A12h8HNCTE8Ca3G4H4dpwKAabCCzh0ajfTByFchM8GBD1tRMwj/qwTYvek/MhJH62RXuNrcEuKoXAqLe+VkaxlNwNed7DAuXpX6Yz8etqdutSDQdd1MjBAVY+6hzDqdFqRS8372hKhMMiguWb43A4hEM/pfT6PUZW/P85kvn/JBxFvboAjtLlVLpHHvBCiQ3SWGU20panvbF6v86JwhkvDN3eGi5Hp2+bBHgH631bIrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZn6DFOlQuNmby2f4oSZVBH2gIm83fwa+Q6KxVqqk9o=;
 b=ss0V1U3/RZgCueAFuTP/vudHNoYBTS6SH6T2Nsrd0ly3FBcxOs0n1d35tHZgZtjssy9tIyxYLOpwYfWa1HHpV/8/Ta/Rh7qGswMX7UF3M1h/B2jZxE/M6B11UFS3jqxoohcqUpnLLvPYD6QlN/kNSmKKFQ51wRMB0BTbQmZuHeI=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3664.namprd12.prod.outlook.com (10.255.86.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 01:48:58 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 01:48:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correctly report gpu recover status
Thread-Topic: [PATCH] drm/amdgpu: correctly report gpu recover status
Thread-Index: AQHVtVLbEC9VyQhDAUqS0faLhdVmqqe/qDeAgAEGf7A=
Date: Thu, 19 Dec 2019 01:48:58 +0000
Message-ID: <MN2PR12MB3344EA5ABA08AA3C3DB61DA8E4520@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191218032534.28482-1-evan.quan@amd.com>
 <5ae5f01d-e7cd-d6b4-2433-90c03809e1b3@gmail.com>
In-Reply-To: <5ae5f01d-e7cd-d6b4-2433-90c03809e1b3@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=db2391dc-079f-4b57-b0e4-0000d0d5fef0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T01:36:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b02e4d19-924a-464f-2327-08d784259d4c
x-ms-traffictypediagnostic: MN2PR12MB3664:|MN2PR12MB3664:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3664819E54D12681559960E7E4520@MN2PR12MB3664.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(13464003)(199004)(189003)(86362001)(66946007)(478600001)(71200400001)(64756008)(66556008)(66476007)(66446008)(52536014)(5660300002)(76116006)(66574012)(186003)(26005)(53546011)(6506007)(2906002)(7696005)(33656002)(316002)(55016002)(9686003)(110136005)(8936002)(8676002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3664;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1U1y6PKa4nGzzzisf4xHHnSGOTlsUJ/6itDI57spH3L8//bHSzAOD8Y+kqqN2KGSuFQKxSzQUt6X4GflL2fWW/1MQbUv3krHVUOa46gTb5S4r7ZQI3mjosHmoVYwBnk6ahrrnKi+3dZnAhbTiFzzQHRBQJU2i46HgyOU1WtViEca4/xHN1B3dna9s9XwF4thB1R1JhtnVSOsTLr6jfEqwZkqDmN9Vx4SGNY84r26TXDlZSUSfk2WKIqlcYBJRuGpU2B4xd6WlhUfULt3a15UQqe08J/eLdI8W/egmBCOB92OVDRpD3G1uDQAzsFgnK8MJuFUSloXhULpTR9tTyg/XqkW4W+l6er4lPdRx2KhYpdzuNVRApf0CGVX2q8lQK9sUDkqGTcyTdSNUqM9iU1+mWte4LI1n/2nWhP4o8qqBEM/FqSuUnrPj6eaYk1fcIOMBfr6QjBHqlDga8iBkPkDoRhrbUtZYDXUip9U5Qj19CylQTdKLN1BA2/7HDl/yhdi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02e4d19-924a-464f-2327-08d784259d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 01:48:58.2744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +89beR1VjW8pDePl378N9jmCNz3/8+YZSLB4DbZSb1iUSrpMfoGQnJPMIwJI7pvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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

SGkgQ2hyaXN0aWFuLA0KDQpIZXJlIGlzIHNvbWUgYmFja2dyb3VuZCBmb3IgdGhpcyBjaGFuZ2U6
DQpJJ20gZGVidWdnaW5nIGEgcmFuZG9tIGZhaWx1cmUgaXNzdWUgb24gYmFjbyByZXNldC4NCkkg
dXNlZCBhIHdoaWxlIGxvb3AgdG8gcnVuIHRoZSBjb250aW51b3VzIGJhY28gcmVzZXQgdGVzdHMg
YW5kIGhvcGUgaXQgY2FuIGV4aXQgaW1tZWRpYXRlbHkgb24gZmFpbHVyZSBvY2N1cnJlZC4NCkhv
d2V2ZXIsIGR1ZSB0byB3cm9uZyByZXR1cm4gdmFsdWUsIGl0IGRpZCBub3QuIEFuZCBhcyB5b3Ug
Y2FuIGltYWdlLCB0aGUgZmFpbHVyZSBzY2VuZSB3YXMgcnVpbmVkLg0KDQpJIGNhbiBhZGQgdGhp
cyAic2VxX3ByaW50ZihtLCAiZ3B1IHJlY292ZXIgJWRcbiIsIHIpOyIuDQpCdXQgc3RpbGwgd2hh
dCBJIGNhcmUgbW9yZSh3aGljaCBpcyBhbHNvIHRoZSBlYXNpZXN0IHdheSB0byBtZSkgaXMgdGhl
IGNvcnJlY3QgcmV0dXJuIHZhbHVlIG9mIHRoZSBBUEkuDQoNClJlZ2FyZHMsDQpFdmFuDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2Vu
aWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVy
IDE4LCAyMDE5IDU6NTcgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogY29ycmVjdGx5IHJlcG9ydCBncHUgcmVjb3ZlciBzdGF0dXMNCj4gDQo+IEFtIDE4
LjEyLjE5IHVtIDA0OjI1IHNjaHJpZWIgRXZhbiBRdWFuOg0KPiA+IEtub3dpbmcgd2hldGhlciBn
cHUgcmVjb3Zlcnkgd2FzIHBlcmZvcm1lZCBzdWNjZXNzZnVsbHkgb3Igbm90IGlzDQo+ID4gaW1w
b3J0YW50IGZvciBvdXIgQkFDTyBkZXZlbG9wbWVudC4NCj4gPg0KPiA+IENoYW5nZS1JZDogSTBl
M2NhNGRjYjY1YTA1M2ViMjZiYzU1YWQ3NDMxZTRhNDJlMTYwZGUNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA0ICstLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gPiBpbmRleCBlOWVmZWUw
NGNhMjMuLjVkZmY1YzBkZDg4MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mZW5jZS5jDQo+ID4gQEAgLTc0Myw5ICs3NDMsNyBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9kZWJ1Z2ZzX2dwdV9yZWNvdmVyKHN0cnVjdA0KPiBzZXFfZmlsZSAqbSwgdm9pZCAqZGF0
YSkNCj4gPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2X3ByaXZhdGU7
DQo+ID4NCj4gPiAgIAlzZXFfcHJpbnRmKG0sICJncHUgcmVjb3ZlclxuIik7DQo+ID4gLQlhbWRn
cHVfZGV2aWNlX2dwdV9yZWNvdmVyKGFkZXYsIE5VTEwpOw0KPiA+IC0NCj4gPiAtCXJldHVybiAw
Ow0KPiA+ICsJcmV0dXJuIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoYWRldiwgTlVMTCk7DQo+
IA0KPiBOQUssIHdoYXQgd2UgY291bGQgZG8gaGVyZSBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4g
ciA9IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoLi4uLik7DQo+IHNlcV9wcmludGYobSwgImdw
dSByZWNvdmVyICVkXG4iLCByKTsNCj4gDQo+IEJ1dCByZXR1cm5pbmcgdGhlIGVycm9yIGNvZGUg
ZnJvbSB0aGUgR1BVIHJlY292ZXJ5IHRvIHVzZXJzcGFjZSBkb2Vzbid0IG1ha2UNCj4gdG8gbXVj
aCBzZW5zZS4NCj4gDQo+IENocmlzdGlhbi4NCj4gDQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZHJtX2luZm9fbGlzdCBhbWRncHVfZGVidWdmc19mZW5jZV9saXN0W10g
PSB7DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
