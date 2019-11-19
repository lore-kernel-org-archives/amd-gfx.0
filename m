Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00268C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 05:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C502B22317
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 05:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C502B22317
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7832C6E159;
	Tue, 19 Nov 2019 05:07:12 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730051.outbound.protection.outlook.com [40.107.73.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B366E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 05:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCmwbUw9YmOPI66adDc0VQf+lRl14lo72uxtVd5ul281o/5dfaj7FSYS+OZY+PsTWTPyr89dgL1Gi7km34xU+Gr0uG+GM4YialUoLfq0wG+Jsy7O3X8LT5k9DDzST7CvP76jpWIr6PotxgclhJckdsnq8pQzR1CXPQQGdIq2xFmnPz6Bgk5Gk5i9HIxDWMO55HCvwDeU7zByYiNpIhZvGODhjNv74LaxXWmDONrHtIZ54tuxT81PuhbFdhuLnID6SgtIK4rA9DbDwtUTyKRrEe9nrybTqWu1ikUD3kKlObd1x5NUjcrkIrNrwIdwnjzSKjbVmQr5faWW/wlBMF+vSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl23OkLrd/VY0KmqV0yje9IceGKuB/dyJmCSChMRMbU=;
 b=Y/0APA9WB28yB5mmeHU/RxErnHB9hfYpOxwhBlm8+pUjWAoAQJjB7Sib4xCZ1Ki8locmffdCgW3+czi+ehA1jq50TSgCEgh0zLRGWiO98dE4oAWfkOoTnnEnHDxaYQgtH4nriAoRYCM9oRhhil0cYWBFTHotPRO85K263JrMey78+cOwIf37eMwXKVcUOHZBWsQv6HNQ03Kjgj7mMBSbeC0xAuiu9c3ge/neP+ZDZPXZo+9q0P0Qhnq7oPRowERmMzbYZ1m08AqO4mpo6Qmz+Vs5cdjpLyAf5xvZW+1SHEiD6I/J4nrYZKTQjkw3f7rwH1RV0dbntDy1TxpuJo81pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3325.namprd12.prod.outlook.com (20.178.243.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 05:07:09 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 05:07:09 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: add missing header file declaration
Thread-Topic: [PATCH] drm/amd/powerplay: add missing header file declaration
Thread-Index: AQHVno16RmoDf2Luu0a8ULlEM+lz2aeR8Shg
Date: Tue, 19 Nov 2019 05:07:09 +0000
Message-ID:
 <MN2PR12MB3838E67FEF8CE5DDF15BD016F04C0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <20191119035712.22785-1-evan.quan@amd.com>
In-Reply-To: <20191119035712.22785-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1a4d1fb-085c-41f8-c4d8-08d76cae549d
x-ms-traffictypediagnostic: MN2PR12MB3325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB332541FB4DAAD5326533B93BF04C0@MN2PR12MB3325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(13464003)(189003)(199004)(8936002)(2906002)(33656002)(25786009)(99286004)(6116002)(52536014)(8676002)(11346002)(446003)(3846002)(66446008)(66946007)(66476007)(66556008)(64756008)(71190400001)(71200400001)(7696005)(486006)(66066001)(478600001)(476003)(76176011)(6246003)(14454004)(86362001)(2501003)(102836004)(305945005)(5660300002)(7736002)(6436002)(9686003)(256004)(6506007)(53546011)(55016002)(81156014)(14444005)(81166006)(110136005)(76116006)(186003)(74316002)(316002)(229853002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3325;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6kw58RRCsle00NmwhPTHEYiK7g9yz71W4qmaeuV5sp16gztS511Pg/z2Bfs4uux1kdFM9Q4JrnmvDJDFxhMvK6EzwecnZ58NwwZTpxNsy78Wvm4eQHAHqQMws7yK+Nj6qZ1I2mwGG5VCe+Ecg93mnLzW0tJEPfNDO958rHb/qBT+JfA+V0rpX8isqIAZzMwuv0EpPa+3vaaxfkx64p5nG8LmYsWYkZ0HxX9i6Tvp5cXYi0dU6pzIgSMFYCry7naRp/k72qILGpjLymHWyTToauv84DH32hchPbzAYvY5iqss0eD1eVVgWQQFhMyLA8n3dRbOa2i3n7WxMA1XpAIvS8Jsmg9atRxSc1WQJWV+ZGOi+GKgnTpX64LK3eunLvGskZ1owlVUT6MgwVHi8736+6V4bZgp85Lg5FiefUpiz0DJ+gooX5w1a+LeXgPpAvj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a4d1fb-085c-41f8-c4d8-08d76cae549d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 05:07:09.3520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0+D1ms8U3D/ZFWK7kNxqwnyXay0c7jI2wmdYLofakr/SBCI/9sIVi/hnnzLsluj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3325
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl23OkLrd/VY0KmqV0yje9IceGKuB/dyJmCSChMRMbU=;
 b=t/l+ZDheC5cka5Y0kR7JiuYaFJsG5AfFmiFWEwWHZM0Q5SP2e0g6xCdC9V3jZ2YVguJgWcsZBPRojCoTIzokLzHhxxxeBR68/ovAXlrw9viyx9c6mRW/wZBCqn20XuBgUdH7vSVRIbEA/0sNNUMJ4XaT4hLc6Pck2s+SM6aDqpA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Message-ID: <20191119050709.Tib-hWAl6lTCRm5SQRPoMajMfor-3W0NYFWdeMdCUPY@z>

QWNrZWQtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQoNCkJSLA0KQWFyb24gTGl1
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUXVhbiwgRXZhbiA8RXZh
bi5RdWFuQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDE5IDExOjU3
IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1LCBBYXJv
biA8QWFyb24uTGl1QGFtZC5jb20+OyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogYWRkIG1pc3NpbmcgaGVhZGVyIGZp
bGUgZGVjbGFyYXRpb24NCj4gDQo+IFRoaXMgY2FuIGZpeCB0aGUgY29tcGlsZSBlcnJvcnMgYmVs
b3c6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9zbXVfdjExXzAu
YzogSW4gZnVuY3Rpb24NCj4g4oCYc211X3YxMV8wX2JhY29fc2V0X3N0YXRl4oCZOg0KPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvc211X3YxMV8wLmM6MTY3NDoyNzog
ZXJyb3I6DQo+IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGFtZGdwdV9yYXNf
Z2V0X2NvbnRleHTigJkgWy1XZXJyb3I9aW1wbGljaXQtDQo+IGZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQ0KPiAgIHN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFk
ZXYpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9zbXVfdjExXzAuYzoxNjc0OjI3OiB3YXJuaW5nOg0KPiBp
bml0aWFsaXphdGlvbiBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBb
LVdpbnQtY29udmVyc2lvbl0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93ZXJw
bGF5L3NtdV92MTFfMC5jOjE2OTI6MTk6IGVycm9yOg0KPiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIg
dG8gaW5jb21wbGV0ZSB0eXBlIOKAmHN0cnVjdCBhbWRncHVfcmFz4oCZDQo+ICAgIGlmICghcmFz
IHx8ICFyYXMtPnN1cHBvcnRlZCkgew0KPiANCj4gQ2hhbmdlLUlkOiBJMTI0MmU2NGU4MjcxNTc3
NGI4ZTI5MzE1MzA3NDk3ODJiOTEwN2UzMg0KPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdV92MTFfMC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQo+IGluZGV4
IDhiMWM0MTY0YTFmNi4uZjY3Nzc0M2NiNTExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiBAQCAtMzcsNiArMzcsNyBAQA0KPiAgI2luY2x1ZGUg
InNvYzE1X2NvbW1vbi5oIg0KPiAgI2luY2x1ZGUgImF0b20uaCINCj4gICNpbmNsdWRlICJhbWRf
cGNpZS5oIg0KPiArI2luY2x1ZGUgImFtZGdwdV9yYXMuaCINCj4gDQo+ICAjaW5jbHVkZSAiYXNp
Y19yZWcvdGhtL3RobV8xMV8wXzJfb2Zmc2V0LmgiDQo+ICAjaW5jbHVkZSAiYXNpY19yZWcvdGht
L3RobV8xMV8wXzJfc2hfbWFzay5oIg0KPiAtLQ0KPiAyLjI0LjANCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
