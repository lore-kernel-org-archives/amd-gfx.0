Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3CFC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE80206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE80206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F8272E53;
	Wed,  4 Dec 2019 10:23:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D73172E89
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 10:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWaNNOozNvyDD1uX8d4NSmwXG6WGFlWSY97SwAaf4TTkbHWTuF6GPmnVtsSAoD0Yy8stnbVMJZ/oyjvWQi1EqQSViNlbe7iEZUw7sWA+RnhpPHZscQ7XkOGxRJWZrW769Pu93eYY5SZktlM4lxJ9EHiDYhBHL4t61A4erHHznQ2i8IMm7PteAh7JQzF51T8meYKgKJXVEJAlG1bQwLUVUm3qLbE1oMGRFijtuj895HXdb8GMRsnB5QGIev8dcIT2YANMQX3HWoybzIQJiIxfSQgdXCdp453KawqdwhWDTg1QuKgI0stvMB3UlNrzKk5aCBv8K1H4P2I3tYUfHikNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQM0kpMmk2/nnQm0+ahAs6McAhqldIaqoyVWI+fOfM=;
 b=nzjew5S7BqIzn5vjJZYchcXcuag4lFAMLkalEEk3e5KEPzvnXVCupZ1JbHwke2jrk/Q2atju9OVIjmdn53ONhYOQfJrc0hJw1I92zd0/Ux1gGEiX6Ry300LSNHfu2Y0RgqQ/TUfC1x/oz7LJDcuogiRfiF2ZT4nbFrjhlYRk9Ra8ohVaEeAEZglXD68h2Mpei2N1qWVJQTT9qoO5KozQjxQlGSlvKED3vHtNqo0Z9Gcjg6D8dcqOqlTlfmoG5CjdZBa6BlYuHaJRnYVg3hwxBFyxMh6Ln2rmiEvsK2iUO/joNSdVFge4T5E/PdUvYdf8P6gmzp2T7h4YSb3RM1bSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3693.namprd12.prod.outlook.com (10.255.86.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 4 Dec 2019 10:23:43 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 10:23:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Index: AQHVqojGekXYeKBlhE+3Id60qbAq36epwhsAgAACJKA=
Date: Wed, 4 Dec 2019 10:23:43 +0000
Message-ID: <MN2PR12MB3344B8AB04DE38812A955E80E45D0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191204095339.25497-1-evan.quan@amd.com>
 <20191204095339.25497-2-evan.quan@amd.com>
 <CDE97C86-24CB-45A6-8913-97CD34C8127E@amd.com>
In-Reply-To: <CDE97C86-24CB-45A6-8913-97CD34C8127E@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a512807f-aac1-409e-adbe-0000712a4011;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-04T10:21:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7e2d23c-4b79-43d9-7e45-08d778a40a46
x-ms-traffictypediagnostic: MN2PR12MB3693:|MN2PR12MB3693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36938AF662115B52AA141FF0E45D0@MN2PR12MB3693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(13464003)(316002)(15650500001)(3846002)(6862004)(45080400002)(4326008)(52536014)(478600001)(8676002)(7696005)(14454004)(6116002)(11346002)(26005)(8936002)(229853002)(25786009)(966005)(186003)(74316002)(305945005)(71190400001)(7736002)(71200400001)(66556008)(102836004)(6506007)(5660300002)(76116006)(66446008)(76176011)(66946007)(86362001)(64756008)(6636002)(53546011)(33656002)(6436002)(9686003)(6306002)(55016002)(99286004)(81156014)(6246003)(2906002)(81166006)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3693;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ehhCLb9ctBSJvvCQHd+HOmKbxLcgOshGqSwFHT4cQEYPsn5OsQ7be4JARL7VeIXO3clpC2aJFI30hQYzYJJYdyK5vHvVAsyel1Nz7gwCBg11jFyTKM6o3D6bbBaCpANL9LcZnBRlV8UdgSXUxtDwM1Oc2LUjkZr/0UdcnGEvZbb4nkayjAXcOPDG5wQTEBU4LG9crwdaNfBKcTYfzKvv81UDTCiB68LP/wouPu4gIDSPsBFAf8Hyxg7pBKiTrG0sAVLmve8jmxU1OLJcZYPQJ/nzHqk+OqFBTIIWo6Se/hHWU9NF1nqmfiGDlZmcbjuC2kkdKIfNnNwY2XLnG3putxV+gW+sv08RSCzNjtARXft8EdMZSVHf4iBq+0UdbonQFC4w06bYnsiu6imTyZSEjlAFoXYSo3pZuS7HA1awX1wA/pH9wVEAkDgyHjq60ingCZaMXOQw3+KxSrsDhOi4xDh+X8B/1b0cYzGBSaK/bMAXSUqCrlghYdLo9eDbvJvt
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e2d23c-4b79-43d9-7e45-08d778a40a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 10:23:43.4718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDxdhOio1NdJIxNTbr7bWBXGCt6jXUpbrwCq4Y2LxP4tliCBYYcQGVgvotqdC0oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQM0kpMmk2/nnQm0+ahAs6McAhqldIaqoyVWI+fOfM=;
 b=gJDrt01j3lVB6iFwAwPZLVqBNyQPro5kRcaQQrxn7rDAlYM2cfZS5p7HzONt/iSRQgbjWMrqwm3HpGS3yhIaioEY4Zpkrqh7NPD4yj1ORYaW7ge8pKROGy0qCSvmvsbKR3tTePIJJpYfEFb/mhSSWbm3OLWjS2uTWdMJLUs2gC8=
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGFib3J0IG9wZXJhdGlvbiBpcyBhZGRlZCBpbiBzbXVfdjExXzBfc2VuZF9tc2dfd2l0aF9w
YXJhbS4NCkFuZCBmb3Igc211X3YxMV8wX3dhaXRfZm9yX3Jlc3BvbnNlLCB5ZXMsIGl0J3Mgb25s
eSBjb2RlIGZhY3RvcmluZy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBEZWNlbWJlciA0LCAyMDE5IDY6MTQgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBh
bWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzJdIGRybS9hbWQvcG93ZXJwbGF5OiBwcmUtY2hlY2sgdGhlIFNNVSBzdGF0
ZSBiZWZvcmUNCj4gaXNzdWluZyBtZXNzYWdlDQo+IA0KPiBIaSBFdmFuLA0KPiBUaGUgb3JpZ2lu
YWwgZGVzaWduIGlzIGFsc28gYWJvcnRpbmcgc2VuZGluZyB0aGUgbWVzc2FnZSBiZWNhdXNlIG9m
IGEg4oCYYnJlYWvigJkNCj4gdGhlcmUuDQo+IFlvdXIgcGF0Y2ggaXMgZm9yIGNvZGUgZmFjdG9y
aW5nPw0KPiBUaGFua3MuDQo+IA0KPiA+IOWcqCAyMDE55bm0MTLmnIg05pel77yM5LiL5Y2INTo1
M++8jEV2YW4gUXVhbiA8RXZhbi5RdWFuQGFtZC5jb20+IOWGmQ0KPiDpgZPvvJoNCj4gPg0KPiA+
IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4gPg0KPiA+IEFib3J0IHRoZSBtZXNzYWdlIGlz
c3VpbmcgaWYgdGhlIFNNVSB3YXMgbm90IGluIHRoZSByaWdodCBzdGF0ZS4NCj4gPg0KPiA+IENo
YW5nZS1JZDogSWRhOWY5MTFlMDUxZjZlNzhkZTRmNDc1OTU2Yzc4NjM3ZTU2ZTZlYTMNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIHwgMTYgKysrKysrKyst
LS0tLS0tLQ0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jIHwg
MTYgKysrKysrKystLS0tLS0tLQ0KPiA+IDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdV92MTFfMC5jDQo+ID4gaW5kZXggMzI1ZWM0ODY0ZjkwLi5kODRjN2Y1ZmIwMWEg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8w
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0K
PiA+IEBAIC02OCwxNSArNjgsMTMgQEAgc3RhdGljIGludCBzbXVfdjExXzBfd2FpdF9mb3JfcmVz
cG9uc2Uoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICAgICAgIGZvciAoaSA9IDA7
IGkgPCB0aW1lb3V0OyBpKyspIHsNCj4gPiAgICAgICAgICAgICAgICBjdXJfdmFsdWUgPSBSUkVH
MzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKTsNCj4gPiAgICAgICAgICAgICAg
ICBpZiAoKGN1cl92YWx1ZSAmIE1QMV9DMlBNU0dfOTBfX0NPTlRFTlRfTUFTSykgIT0gMCkNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gY3VyX3ZhbHVlID09IDB4MSA/IDAgOiAtRUlPOw0KPiA+ICsNCj4gPiAgICAg
ICAgICAgICAgICB1ZGVsYXkoMSk7DQo+ID4gICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAvKiB0
aW1lb3V0IG1lYW5zIHdyb25nIGxvZ2ljICovDQo+ID4gLSAgICAgICBpZiAoaSA9PSB0aW1lb3V0
KQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVUSU1FOw0KPiA+IC0NCj4gPiAtICAgICAg
IHJldHVybiBSUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKSA9PSAweDEg
PyAwIDoNCj4gLUVJTzsNCj4gPiArICAgICAgIHJldHVybiAtRVRJTUU7DQo+ID4gfQ0KPiA+DQo+
ID4gaW50DQo+ID4gQEAgLTkyLDkgKzkwLDExIEBAIHNtdV92MTFfMF9zZW5kX21zZ193aXRoX3Bh
cmFtKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgICAgICAgICAgICAgIHJldHVy
biBpbmRleDsNCj4gPg0KPiA+ICAgICAgICByZXQgPSBzbXVfdjExXzBfd2FpdF9mb3JfcmVzcG9u
c2Uoc211KTsNCj4gPiAtICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHByX2Vy
cigiZmFpbGVkIHNlbmQgbWVzc2FnZTogJTEwcyAoJWQpIFx0cGFyYW06IDB4JTA4eA0KPiByZXNw
b25zZSAlI3hcbiIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICBzbXVfZ2V0X21lc3NhZ2Vf
bmFtZShzbXUsIG1zZyksIGluZGV4LCBwYXJhbSwgcmV0KTsNCj4gPiArICAgICAgIGlmIChyZXQp
IHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJyKCJNc2cgaXNzdWluZyBwcmUtY2hlY2sgZmFp
bGVkIGFuZCAiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiU01VIG1heSBiZSBub3QgaW4g
dGhlIHJpZ2h0IHN0YXRlIVxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gKyAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgV1JFRzMyX1NPQzE1KE1QMSwgMCwgbW1NUDFf
U01OX0MyUE1TR185MCwgMCk7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3NtdV92MTJfMC5jDQo+ID4gaW5kZXggN2Y1ZjdlMTJhNDFlLi5hNjM4MzI2YmExYjcg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8w
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYw0K
PiA+IEBAIC01NiwxNSArNTYsMTMgQEAgaW50IHNtdV92MTJfMF93YWl0X2Zvcl9yZXNwb25zZShz
dHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSkNCj4gPiAgICAgICAgZm9yIChpID0gMDsgaSA8IGFk
ZXYtPnVzZWNfdGltZW91dDsgaSsrKSB7DQo+ID4gICAgICAgICAgICAgICAgY3VyX3ZhbHVlID0g
UlJFRzMyX1NPQzE1KE1QMSwgMCwgbW1NUDFfU01OX0MyUE1TR185MCk7DQo+ID4gICAgICAgICAg
ICAgICAgaWYgKChjdXJfdmFsdWUgJiBNUDFfQzJQTVNHXzkwX19DT05URU5UX01BU0spICE9IDAp
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGN1cl92YWx1ZSA9PSAweDEgPyAwIDogLUVJTzsNCj4gPiArDQo+ID4g
ICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPiA+ICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAg
LyogdGltZW91dCBtZWFucyB3cm9uZyBsb2dpYyAqLw0KPiA+IC0gICAgICAgaWYgKGkgPT0gYWRl
di0+dXNlY190aW1lb3V0KQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVUSU1FOw0KPiA+
IC0NCj4gPiAtICAgICAgIHJldHVybiBSUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQ
TVNHXzkwKSA9PSAweDEgPyAwIDoNCj4gLUVJTzsNCj4gPiArICAgICAgIHJldHVybiAtRVRJTUU7
DQo+ID4gfQ0KPiA+DQo+ID4gaW50DQo+ID4gQEAgLTgwLDkgKzc4LDExIEBAIHNtdV92MTJfMF9z
ZW5kX21zZ193aXRoX3BhcmFtKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgICAg
ICAgICAgICAgIHJldHVybiBpbmRleDsNCj4gPg0KPiA+ICAgICAgICByZXQgPSBzbXVfdjEyXzBf
d2FpdF9mb3JfcmVzcG9uc2Uoc211KTsNCj4gPiAtICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAg
ICAgICAgICAgIHByX2VycigiRmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAweCV4LCByZXNwb25zZSAw
eCV4LCBwYXJhbQ0KPiAweCV4XG4iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgaW5kZXgs
IHJldCwgcGFyYW0pOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAg
ICBwcl9lcnIoIk1zZyBpc3N1aW5nIHByZS1jaGVjayBmYWlsZWQgYW5kICINCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICJTTVUgbWF5IGJlIG5vdCBpbiB0aGUgcmlnaHQgc3RhdGUhXG4iKTsN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgICBXUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwLCAwKTsNCj4g
Pg0KPiA+IC0tDQo+ID4gMi4yNC4wDQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+ID4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0DQo+ID4gcy5mcmVl
ZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0YT0w
MiU3QzAxJTdDS2UNCj4gPg0KPiBubmV0aC5GZW5nJTQwYW1kLmNvbSU3QzEzODNmMjY2MWI1ODRl
MDRlZGY5MDhkNzc4OWZlYWY1JTdDM2RkODk2MQ0KPiBmZTQ4OA0KPiA+DQo+IDRlNjA4ZTExYTgy
ZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMTA1MDA1NTEwMzY0MzgmYW1wO3NkYXRhPVFRDQo+IFJZ
OGRzaVQlDQo+ID4gMkJQaW81SSUyQiUyRjNFcnFMbllRTHh0NmhjeVhIZWRVNzltdVRJJTNEJmFt
cDtyZXNlcnZlZD0wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
