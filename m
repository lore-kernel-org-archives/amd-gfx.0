Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB22C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A052082E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wURLTzQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A052082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFB56E885;
	Mon, 16 Dec 2019 20:30:27 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C87F6E885
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0xyWUon17ktJgok1zmGzKJMwXYyGycC0qWHab9y/EhSSe+TeBjZQuVPjK9ev2n3ZZ63aYGJSznCwBBua30SZrOeRZtfbD3ox2iH/nmqVw/KpsRrIJiMKo2Nd7BtyEVRmt4vg3w0YRXSpCqWG4qMdfWaxSRestH6XTwD9ntUNr689uhPHjrJY0JWwC4rIRXSG8me0a4t/L2Y4NV0akKLhPxEz/KTz5djYriWXE+WEw/PgroyDRbGNStFRJmgJnxyOr3Rm43I8et526oKSJK2f+aFQDIrxcPLf/TBuMLmDkTSo3lb7NmlU2//FWDFC/bSs/kV4J1QVQqpxmYBOd1b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYJPsH4LtvumGQPgLqzld675GT1BZfFyUXVb5XEDWAU=;
 b=cPL3hZ/jpRVi+budMW6sU5gXN+3pFEJf2mBjIYZNLSBFEFM/nDo4IlZir52WZ/B4Pynw+DUwyxRf1v5l5OivkWFLmAaz5/knoyuJiFHxr6hsjWa6RAvzih1J08n4OM+oEUv6K2Tzx+8mOm8pt9GM9iFtjfXmCUoU/5SAHlj7ZdoCtnMVl97+teevLgSIhkjVyQxHQUnmhWAfvRM5Gjip5rRStdRv0LCdSdIm5PkQKV9X9S090N6YMm4N7ufoikRwg+J1KKjR+CwWKvSEipyezxez3+vkZHjHVklowLgA7WViXcVztf+PTKWCRd+g1/w1e34ecPEwMZzWJHKZSPCxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYJPsH4LtvumGQPgLqzld675GT1BZfFyUXVb5XEDWAU=;
 b=wURLTzQdLX1x9avnjP/dVgWUYlmmL3tZOQBr73rwSs/p3S8aZ0K5EWBPhAEwhSCcgKTO6zC8C/lQU9/KK5WAGlWC7nIc3WnkWGYdO26xvpVs+S0hSp6Y66DaCS8cKr+R4d7q5SxGpvtgrEMRpIanRUwUAqZ9+u0QgcVGhjnBZbw=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2483.namprd12.prod.outlook.com (52.132.10.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 20:30:23 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c%6]) with mapi id 15.20.2516.018; Mon, 16 Dec 2019
 20:30:23 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
Thread-Topic: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
Thread-Index: AQHVtDTnbQc4pijKkkmPChd9gyJJP6e9M7oAgAABrX2AAACmoA==
Date: Mon, 16 Dec 2019 20:30:23 +0000
Message-ID: <BL0PR12MB25805C25583DA92303DC7CDB80510@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191216171834.217251-1-alexander.deucher@amd.com>
 <20191216171834.217251-2-alexander.deucher@amd.com>
 <d9b19564-79b4-6044-8b0d-5dba5adf6982@gmail.com>
 <CADnq5_M1N8Bs1-FH+TpqbDWRXk+bcEx9=+Q8+qr=Bv5NbXwwjw@mail.gmail.com>
 <e9a5d212-9392-8a3b-0afa-3fd1ee0390f5@gmail.com>
In-Reply-To: <e9a5d212-9392-8a3b-0afa-3fd1ee0390f5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-16T20:30:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=56fa4eaf-9c34-4879-bf2a-00009c7eff79;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-16T20:30:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4cac94c1-e5bd-4779-bf1f-0000969c2810
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80ba4ee4-8cbf-44cf-9287-08d78266c735
x-ms-traffictypediagnostic: BL0PR12MB2483:|BL0PR12MB2483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB248388A87AD3627CFAE9745780510@BL0PR12MB2483.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(13464003)(199004)(110136005)(33656002)(9686003)(5660300002)(15650500001)(8936002)(54906003)(316002)(64756008)(66556008)(81166006)(81156014)(26005)(4326008)(7696005)(8676002)(966005)(66476007)(66574012)(66946007)(86362001)(76116006)(2906002)(45080400002)(53546011)(6506007)(71200400001)(55016002)(52536014)(478600001)(186003)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2483;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QujKSjFuS2EoW+NEKgEL2VX+zwFpJ/JO0WZ59pUyIeoKtPccym9ENF1EfyKvo0fAk8ttb03g2t9Mj+DyrRU94s3WReZSzHvHwPxM7XKem7HlEPUeGEZQoBQfrj3hb0w3+ja9z/dAZpCbCZ9DBn/solQySv1mUQ+CGzriyjGT5zaoNL2jUyO7ZW7WiDU3+V7qD9LEGoodeL08Dj2VIWq9VtNc4hgbmtzf6Jbskbqp5fX4yG1kgBOj/flhMikPtmEHzaHW/Ryk9DwkNCeAhn2DTazJa0FE3QJehTA5qzrUDeURo/D201IZ4l5F0vfZOMyx8nH/RElOXeoswM6d/9UgHru3W0aUMaRykDN1jOgBV0ogzkVWZW4eaDYS6vQAu+XvzQSl998cfHNv9n+n0yz6DwF1SwxvjETR9G9HYwh6fk2NltiTXJ0yGRBijSttzfa1ecm1VbRIYN2xgJxhiw6QgtW9JFLyyRgsF3m8oAOVNV0bo4KjGZHy9J6O4dbR1HaQuH/NAuIWEwjSJZcN1eUk1ieBzuXJrUWAiZOPp5QDMa4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ba4ee4-8cbf-44cf-9287-08d78266c735
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 20:30:23.5377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2oUTkXWy5hZXMrLnRP5pg5akeZvbYMmCiPZapCHjfdfghxjZogjLX+I56dB1mMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2483
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmVnYXJkcywNCk9haw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IENocmlzdGlhbiBLw7ZuaWcNClNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTYsIDIwMTkgMzoyNSBQ
TQ0KVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGRybS9hbWRncHUvcG1f
cnVudGltZTogdXBkYXRlIHVzYWdlIGNvdW50IGluIGZlbmNlIGhhbmRsaW5nDQoNCkFtIDE2LjEy
LjE5IHVtIDIxOjIyIHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiBPbiBNb24sIERlYyAxNiwgMjAx
OSBhdCAzOjE5IFBNIENocmlzdGlhbiBLw7ZuaWcgDQo+IDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiBBbSAxNi4xMi4xOSB1bSAxODoxOCBzY2hyaWViIEFsZXgg
RGV1Y2hlcjoNCj4+PiBJbmNyZW1lbnQgdGhlIHVzYWdlIGNvdW50IGluIGVtaXQgZmVuY2UsIGFu
ZCBkZWNyZW1lbnQgaW4gcHJvY2VzcyANCj4+PiBmZW5jZSB0byBtYWtlIHN1cmUgdGhlIEdQVSBp
cyBhbHdheXMgY29uc2lkZXJlZCBpbiB1c2Ugd2hpbGUgdGhlcmUgDQo+Pj4gYXJlIGZlbmNlcyBv
dXRzdGFuZGluZy4gIFdlIGFsd2F5cyB3YWl0IGZvciB0aGUgZW5naW5lcyB0byBkcmFpbiBpbiAN
Cj4+PiBydW50aW1lIHN1c3BlbmQsIGJ1dCBpbiBwcmFjdGljZSB0aGF0IG9ubHkgY292ZXJzIHNo
b3J0IGxpdmVkIGpvYnMgDQo+Pj4gZm9yIGdmeC4gIFRoaXMgc2hvdWxkIGNvdmVyIHVzIGZvciBs
b25nZXIgbGl2ZWQgZmVuY2VzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNiArKysrKy0NCj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgDQo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4+IGluZGV4IDM3N2Zl
MjBiY2UyMy4uZTllZmVlMDRjYTIzIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4+PiBAQCAtMzQsNiArMzQsNyBAQA0KPj4+ICAgICNpbmNs
dWRlIDxsaW51eC9rcmVmLmg+DQo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4+PiAg
ICAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1
bnRpbWUuaD4NCj4+Pg0KPj4+ICAgICNpbmNsdWRlIDxkcm0vZHJtX2RlYnVnZnMuaD4NCj4+Pg0K
Pj4+IEBAIC0xNTQsNyArMTU1LDcgQEAgaW50IGFtZGdwdV9mZW5jZV9lbWl0KHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywgc3RydWN0IGRtYV9mZW5jZSAqKmYsDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgIHNlcSk7DQo+Pj4gICAgICAgIGFtZGdwdV9yaW5nX2VtaXRfZmVuY2UocmluZywgcmlu
Zy0+ZmVuY2VfZHJ2LmdwdV9hZGRyLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNlcSwgZmxhZ3MgfCBBTURHUFVfRkVOQ0VfRkxBR19JTlQpOw0KPj4+IC0NCj4+PiArICAgICBw
bV9ydW50aW1lX2dldF9ub3Jlc3VtZShhZGV2LT5kZGV2LT5kZXYpOw0KPj4+ICAgICAgICBwdHIg
PSAmcmluZy0+ZmVuY2VfZHJ2LmZlbmNlc1tzZXEgJiByaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNl
c19tYXNrXTsNCj4+PiAgICAgICAgaWYgKHVubGlrZWx5KHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0
ZWQoKnB0ciwgMSkpKSB7DQo+Pj4gICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqb2xk
OyBAQCAtMjM0LDYgKzIzNSw3IEBAIHN0YXRpYyANCj4+PiB2b2lkIGFtZGdwdV9mZW5jZV9zY2hl
ZHVsZV9mYWxsYmFjayhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQo+Pj4gICAgYm9vbCBhbWRn
cHVfZmVuY2VfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQo+Pj4gICAgew0KPj4+
ICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2ZlbmNlX2RyaXZlciAqZHJ2ID0gJnJpbmctPmZlbmNlX2Ry
djsNCj4+PiArICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7DQo+
Pj4gICAgICAgIHVpbnQzMl90IHNlcSwgbGFzdF9zZXE7DQo+Pj4gICAgICAgIGludCByOw0KPj4+
DQo+Pj4gQEAgLTI3NCw2ICsyNzYsOCBAQCBib29sIGFtZGdwdV9mZW5jZV9wcm9jZXNzKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZykNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIEJVRygpOw0K
Pj4+DQo+Pj4gICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+Pj4gKyAgICAg
ICAgICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGFkZXYtPmRkZXYtPmRldik7DQo+Pj4g
KyAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChhZGV2LT5kZGV2LT5kZXYp
Ow0KPj4gQXJlIHlvdSBzdXJlIHRoaXMgaXMgb2s/IEtlZXAgaW4gbWluZCB0aGF0IHRoaXMgZnVu
Y3Rpb24gaXMgY2FsbGVkIGluIA0KPj4gaW50ZXJydXB0IGNvbnRleHQuDQo+IEFjY29yZGluZyB0
bzoNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGd3d3Lg0KPiBrZXJuZWwub3JnJTJGZG9jJTJGRG9jdW1lbnRhdGlvbiUy
RnBvd2VyJTJGcnVudGltZV9wbS50eHQmYW1wO2RhdGE9MDIlDQo+IDdDMDElN0NvYWsuemVuZyU0
MGFtZC5jb20lN0M3MDA4Y2Y1MzczMDk0MTYwNTUyYjA4ZDc4MjY2MDMyZCU3QzNkZDg5NjENCj4g
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTIxMjQ3MDgyMDc4OTk3JmFt
cDtzZGF0YT1rZlVLYw0KPiBkdzBQU1hXc3BPQmZYUVQ2QkY0cjRxM202NGNQTWJrWDd4ak9hQSUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPiBpdCdzIG9rIHRvIGNhbGwgdGhvc2UgaW4gYW4gaW50ZXJydXB0
IGNvbnRleHQuDQoNCkluIHRoaXMgY2FzZSB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uDQoNCltPYWtdIFllcywgcG1f
cnVudGltZV9wdXRfYXV0b3N1c3BlbmQgY2FsbHMgX19wbV9ydW50aW1lX3N1c3BlbmQgaW4gdGhl
IHJwbWZsYWdzIHNldCB0byBSUE1fQVNZTkMgZmxhZyBzbyBpdCBjYW4gYmUgY2FsbGVkIGluIGF0
b21pYyBjb250ZXh0Lg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gQWxleA0KPg0KPj4gQ2hyaXN0aWFu
Lg0KPj4NCj4+PiAgICAgICAgfSB3aGlsZSAobGFzdF9zZXEgIT0gc2VxKTsNCj4+Pg0KPj4+ICAg
ICAgICByZXR1cm4gdHJ1ZTsNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdA0KPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q29hDQo+IGsuemVuZyU0
MGFtZC5jb20lN0M3MDA4Y2Y1MzczMDk0MTYwNTUyYjA4ZDc4MjY2MDMyZCU3QzNkZDg5NjFmZTQ4
ODRlNjANCj4gOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTIxMjQ3MDgyMDc4OTk3JmFt
cDtzZGF0YT1PSWVEdmJhUmFSNGxNSg0KPiAxbXVuS0lNa2hHd1FwU3F4cm9OaElQSkdtcXg2YyUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NvYWsuemVuZyU0MGFtZC5jb20lN0M3MDA4
Y2Y1MzczMDk0MTYwNTUyYjA4ZDc4MjY2MDMyZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzAlN0M2MzcxMjEyNDcwODIwNzg5OTcmYW1wO3NkYXRhPU9JZUR2YmFSYVI0
bE1KMW11bktJTWtoR3dRcFNxeHJvTmhJUEpHbXF4NmMlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
