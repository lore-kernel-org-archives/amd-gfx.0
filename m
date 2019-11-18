Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7397C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FB120727
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FB120727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3D76E4AB;
	Mon, 18 Nov 2019 12:00:30 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800081.outbound.protection.outlook.com [40.107.80.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23F36E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 12:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFt5Flg/86ZuOOZCLGsagbLbOEQr+UDG9ZirIDWTQ8GUB5FN/IKndDDj9kcu5tcGnCIqhkAyAHL5w7MMEO90AMt6WBiI0CGXVg5seCljQl3xLSU88IJr4AogMqhKXIGSJRgJ+f3Buy8tNS0GlW70BxcKna63GKIzK2oUOOCxPY42mkee/7zwyBzeLuQ7b1kX6GCDgzAQCK0iCMUKg7noqFmg5S1UznMEWe+JKIYv2RMMrTcNEysNIy/iHfHy7cCoD6gmzAMkxvqCoVSeRqJZ4guqxF9CLfaXbZMX89bZ70zrQ0jjY6bBD3LuDWUCyLMD/mWTKgHPIaSLCY4VayKpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfX0lEptuRazU5W6dlQCZiF8Sfb/Nt77L6NfmmgcCc0=;
 b=TTzt/2phdPoBKeTCDg9qkxqxCFT28A5suCx1JlZ35q7/pwbi9umfYWhPx8pGZ9tn3+X0G0ZqCkiKkj0tK1Y9m54paLGA+Af50XkQRcsp/YtPu1vf/xtcFUxPg/rKhv+PuPFe7uzQ1/vFs5G6sjQ81qM1FsWgsN17HLmllqStNmo6jyQ0ZyrFqY7skUiV3AlKpXT6gVbViDR7Co78hx4CmloqbaonlCrza5O9WJExXJfBM0I56HFR6FljfyMNcv+OKAo0eE/tT2pB1tRBqjGAHGeOovpYAXxi0thBM+mzyk+wlh3uW0d6B+d18F90FKT+KYbeJd+tCQu1Ie0zQUIdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (20.178.242.91) by
 MN2PR12MB3824.namprd12.prod.outlook.com (10.255.238.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 12:00:26 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::14a3:7a94:4244:2c38]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::14a3:7a94:4244:2c38%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 12:00:26 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: put cancel dealyed work at first
Thread-Topic: [PATCH] drm/amdgpu: put cancel dealyed work at first
Thread-Index: AQHVnek+IPlKzH+mm06RqP0JESh4OaeQy9MAgAAGe6A=
Date: Mon, 18 Nov 2019 12:00:26 +0000
Message-ID:
 <MN2PR12MB30397D75F1EFD4318924603DE54D0@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20191118082149.16712-1-yttao@amd.com>
 <03d55ea8-8825-c65a-7193-9a0f11776595@amd.com>
In-Reply-To: <03d55ea8-8825-c65a-7193-9a0f11776595@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40a4a8bb-54d4-4d9e-7766-08d76c1ee61b
x-ms-traffictypediagnostic: MN2PR12MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3824361A3A14666E47F11482E54D0@MN2PR12MB3824.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(13464003)(189003)(199004)(478600001)(66556008)(64756008)(66446008)(76176011)(9686003)(55016002)(66946007)(7696005)(102836004)(53546011)(6246003)(14444005)(256004)(6506007)(6436002)(4326008)(6862004)(6116002)(71190400001)(71200400001)(66066001)(3846002)(2906002)(33656002)(229853002)(86362001)(81166006)(81156014)(8936002)(8676002)(66476007)(76116006)(476003)(11346002)(446003)(74316002)(486006)(305945005)(7736002)(6636002)(186003)(5660300002)(26005)(25786009)(52536014)(316002)(14454004)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3824;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UpJlqE+hjpTDKEg1Yh5HhwAKi7pDODOTszWcMBJy4mAfY8fFsNh/3snaoxUhYgPp5IoXAwPH/XtdewAR10cFiwLjZBPJ+zZAaCM0TDCesg0tsz6ETih1C3ndcVKutWaNWIMQXpkGuzQRrik+SWVGK7BZ+XFxecAbSLnn+4xPBtQ0Wp+jzQBLWgvyCPrl9B1jMs/yBYe4W75yVnbPimRfdXiaJoIl4bC/vLMMA//rW9krFFUA6gxQNF2pGMNgebJ5wSSzV32gfRpCuQ7RPSbpiJ+SMVq7HpkVCRal8rSW7SnXRFL/JYbuKYcVVFCRpf5YMCN6SHzX4FMruJCt7ErlPVjP064ym6ZszR35AJlPysHnkCswMGTIAFBs47n0Q/zAHNedOT4WHj+oRGdTld8O/OClGumEsDxQCom1hcpJOdUjDC1daJEL94TY14iTzrA
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4a8bb-54d4-4d9e-7766-08d76c1ee61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 12:00:26.0863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBgJKvkjYj5ACaFxaVs25mKi3mIdCiCll/0o/5EbJW2pT857yiCcC7+IcidfWf36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3824
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfX0lEptuRazU5W6dlQCZiF8Sfb/Nt77L6NfmmgcCc0=;
 b=DoQYyjQjWQ9YGque8YynN659I5GZNS0KdROJtCGmDAdeiQGL7DcfDzoMHKkw3bKTvA5n23QALg4LbTaQUodUkAkocbIP6WPo0KtYEyDkverZkeQSpoQbqYvvIamtdEX77dYFWkToV+nywWKJ0DUjIUL1fKPt0hyKwB63mDJilho=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
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
Message-ID: <20191118120026.Yi1CY5QVfYOv6z-0h-Saeb1syhc7WxalsGc1i-W0HeQ@z>

SGkgIENocmlzdGlhbg0KDQpUaGFua3MsIEkgZ290IGl0LCBJIHdpbGwgdXNlIGZsdXNoX2RlbGF5
ZWRfd29yayB0byByZXBsYWNlIGNhbmNlbGluZy4NCg0KQmVzdCBSZWdhcmRzDQpZaW50aWFuIFRh
bw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTHmnIgxOOaXpSAxOToz
Mg0KVG86IFRhbywgWWludGlhbiA8WWludGlhbi5UYW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcHV0
IGNhbmNlbCBkZWFseWVkIHdvcmsgYXQgZmlyc3QNCg0KR29vZCBjYXRjaCwgYnV0IEkgd291bGQg
c3RpbGwgcHJlZmVyIHRvIHVzZSBmbHVzaF9kZWxheWVkX3dvcmsoKSBpbnN0ZWFkIG9mIGNhbmNl
bGluZyBpdC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMTguMTEuMTkgdW0gMDk6MjEg
c2NocmllYiBZaW50aWFuIFRhbzoNCj4gVGhlcmUgaXMgb25lIHJlZ3Jlc3Npb24gZnJvbSAwNDJm
M2Q3Yjc0NWNkNzZhYSBhbmQgb25lIGltcHJvdmVtZW50IA0KPiBoZXJlLg0KPiAtcmVncmVzc2lv
bjoNCj4gcHV0IGZsdXNoX2RlbGF5ZWRfd29yayBhZnRlciBhZGV2LT5zaHV0ZG93biA9IHRydWUg
d2hpY2ggd2lsbCBtYWtlIA0KPiBhbWRncHVfaWhfcHJvY2VzcyBub3QgcmVzcG9uc2UgdGhlIGly
cSBBdCBsYXN0LCBhbGwgaWIgcmluZyB0ZXN0cyB3aWxsIA0KPiBiZSBmYWlsZWQganVzdCBsaWtl
IGJlbG93DQo+DQo+IFtkcm1dIGFtZGdwdTogZmluaXNoaW5nIGRldmljZS4NCj4gW2RybV0gRmVu
Y2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGdmeCBbZHJtXSBGZW5jZSBmYWxsYmFj
ayANCj4gdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjAgW2RybV0gRmVuY2UgZmFsbGJh
Y2sgdGltZXIgZXhwaXJlZCBvbiANCj4gcmluZyBjb21wXzEuMS4wIFtkcm1dIEZlbmNlIGZhbGxi
YWNrIHRpbWVyIGV4cGlyZWQgb24gcmluZyBjb21wXzEuMi4wIA0KPiBbZHJtXSBGZW5jZSBmYWxs
YmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgY29tcF8xLjMuMCBbZHJtXSBGZW5jZSANCj4gZmFs
bGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjEgYW1kZ3B1IDAwMDA6MDA6MDcu
MDogDQo+IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVz
dCBmYWlsZWQgb24gY29tcF8xLjEuMSAoLTExMCkuDQo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtk
cm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQg
b24gY29tcF8xLjIuMSAoLTExMCkuDQo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1
X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gY29tcF8x
LjMuMSAoLTExMCkuDQo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3Jpbmdf
dGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gc2RtYTAgKC0xMTApLg0K
PiBhbWRncHUgMDAwMDowMDowNy4wOiBbZHJtOmFtZGdwdV9pYl9yaW5nX3Rlc3RzIFthbWRncHVd
XSAqRVJST1IqIElCIHRlc3QgZmFpbGVkIG9uIHNkbWExICgtMTEwKS4NCj4gYW1kZ3B1IDAwMDA6
MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0
ZXN0IGZhaWxlZCBvbiB1dmRfZW5jXzAuMCAoLTExMCkuDQo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6
IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWls
ZWQgb24gdmNlMCAoLTExMCkuDQo+IFtkcm06YW1kZ3B1X2RldmljZV9kZWxheWVkX2luaXRfd29y
a19oYW5kbGVyIFthbWRncHVdXSAqRVJST1IqIGliIHJpbmcgdGVzdCBmYWlsZWQgKC0xMTApLg0K
Pg0KPiAtaW1wcm92ZW1lbnQ6DQo+IEluIGZhY3QsIHRoZXJlIGlzIGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYyBpbiB0aGlzIGZ1Y250aW9uIFNvIHRoZXJlIA0KPiBpcyBubyBuZWVkIHRvIGludm9r
ZSBmbHVzaF9kZWxheWVkX3dvcmsgYmVmb3JlIA0KPiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMu
IEp1c3QgcHV0IGNhbmNlbCBhdCBmaXJzdA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRh
byA8eXR0YW9AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgNCArLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCAxN2JlNjM4OWFkZjcuLmEyNDU0YzNlZmM2NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAt
MzEwOSwxMCArMzEwOSw5IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiAgIAlpbnQgcjsNCj4gICANCj4gICAJRFJNX0lORk8oImFtZGdwdTog
ZmluaXNoaW5nIGRldmljZS5cbiIpOw0KPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRl
di0+ZGVsYXllZF9pbml0X3dvcmspOw0KPiAgIAlhZGV2LT5zaHV0ZG93biA9IHRydWU7DQo+ICAg
DQo+IC0JZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5kZWxheWVkX2luaXRfd29yayk7DQo+IC0N
Cj4gICAJLyogZGlzYWJsZSBhbGwgaW50ZXJydXB0cyAqLw0KPiAgIAlhbWRncHVfaXJxX2Rpc2Fi
bGVfYWxsKGFkZXYpOw0KPiAgIAlpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRp
YWxpemVkKXsNCj4gQEAgLTMxMzAsNyArMzEyOSw2IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJYWRldi0+ZmlybXdhcmUuZ3B1X2lu
Zm9fZncgPSBOVUxMOw0KPiAgIAl9DQo+ICAgCWFkZXYtPmFjY2VsX3dvcmtpbmcgPSBmYWxzZTsN
Cj4gLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRfaW5pdF93b3JrKTsN
Cj4gICAJLyogZnJlZSBpMmMgYnVzZXMgKi8NCj4gICAJaWYgKCFhbWRncHVfZGV2aWNlX2hhc19k
Y19zdXBwb3J0KGFkZXYpKQ0KPiAgIAkJYW1kZ3B1X2kyY19maW5pKGFkZXYpOw0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
