Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A76C2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 04:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5F4222C3
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 04:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h46GhUYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5F4222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC666E178;
	Fri,  3 Jan 2020 04:20:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13D56E178
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 04:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJlNLY91gfStmGzzxVuRRaWhaiLxogEWQAJrIsP84IzlGKQt2iFxbnk4F9bi9imaDlq5J0Uxxn5lb4zsDPw+XY1OIr8oe9rTRypCnbum2BzXumBZww9XqWVUOgCGH5Qb2bHoKlX9o8SEPnwPnh+BrOiiXzdqH4emz85wZ2k77yCeOEdnGkyLmeElpenq+Ur4qE8m0etKpie5pRNMcQeCgv9xEENf7MPa9SPdYZ1yU/2YAQlG/HX8TyYw9IyFkZI5lBeJDy4QJ6ogrZ5EiDkSGe6yzC5no9z6Zv5XVZSQVjqQVj+jfHhop9ZuHArH/D3CWp5BkPAb1yI24fi+hAktlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBUbRk4kNTux7q+NeZbcvPxfsPuaT7LY7ul8omtZ1RU=;
 b=aYUOp9oaXruHhkKqtn9BtguLWUldZjGBUpKcJBSjq6y2Ub25eRUoXcoT4Cygh0rce9ZMbA697MT+kaupQMYEj7j444OgpHiJHb1Xq1YenpBBYCyYlVr4L8izUNoXGYuV3F6+jieKatbh/+BUjf/0z0zcI1a03+tkXIJxeEd/3MlSdAKVqONX5dc4gmbUkf4ofFVVcylxuc8s6djBHBTb2LgmO+HCPJpVIy9aXqxhlxNXRq0h2cLFqme9aCfZtLUvp/cTgwJMROfH0AnrDOFJlUABpOmygSjLjwFds94yfsSG2gVqi7xsHgZjTZx7WEo7GW7IftKIn0sv2jmx114ZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBUbRk4kNTux7q+NeZbcvPxfsPuaT7LY7ul8omtZ1RU=;
 b=h46GhUYbG9CvYHmvfz0/gHFEkpzXJjHdqfViwmtT08woaMmyCTXfbtV1Vp4HdnSHqZiIKk75Ol6mejBHh37/3bNmuofWAxBVFLgNevrG2RU+6HslJg2Song/O5UflYRNnkY4unrTB541cvFNrUha1x8obQFF5TkYbj0lD61YuFA=
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2637.namprd12.prod.outlook.com (52.135.101.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Fri, 3 Jan 2020 04:20:37 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:20:37 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
Thread-Topic: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
Thread-Index: AQHVq3F28zljgCPQK0qWG8lPvapYGKe1rQWAgACO0gCAIkQ9oA==
Date: Fri, 3 Jan 2020 04:20:37 +0000
Message-ID: <SN6PR12MB26214131AB40026EB0D05382FD230@SN6PR12MB2621.namprd12.prod.outlook.com>
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
 <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
 <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
In-Reply-To: <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T04:20:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c4991732-da67-4b51-a0ec-00001f2fc3a8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T04:20:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f1bd66a7-6022-4a7c-a55b-0000e76ec437
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9fea398-8138-44fb-0ec8-08d790044912
x-ms-traffictypediagnostic: SN6PR12MB2637:|SN6PR12MB2637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26374CA1D1669A3071F2FD39FD230@SN6PR12MB2637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(13464003)(43544003)(54094003)(189003)(199004)(26005)(64756008)(5660300002)(76116006)(52536014)(6636002)(66556008)(66446008)(66946007)(66476007)(186003)(110136005)(66574012)(8936002)(55016002)(33656002)(53546011)(9686003)(81166006)(81156014)(8676002)(7696005)(6506007)(2906002)(71200400001)(478600001)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2637;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kj0BRxJUmnsfgElwixc1gp9rjK1bVydlDiEaRR6+Xq7FnR5TgtBZUj9EyrwFkryTxKBi1pR9lrscpNeN/kn5BXNTHOML1hiq4nscTiE3IGpRmiBjXG4iwcKs7VpBCjea/ysPUrMRTjdD2zVrfPm+rsZCK5u5mQMHWqbc5XWDJekQgZUmOECWpq7HqTYfOq2Q24AP2iq3elA411l0+tufWiadyU+duYzJhwMq9eYJf61peAJx4UscPdI4lwdBjiHJY8UxCIxa29AHM3RvGEaKXi5kR5dcZZRCYkJmYDv9NGMw1msbCEjytVpVHnl6a9Sho2vf7yqueBUe8sqZ509t47H5Ck3m//+VYwnmobJAqhbp+LEfHt4RcgIhoAJgyPW8cQ4qW9lqaFOg7oxI1CLjn+hvj7HtLoKgD8CIWn/0QYVkIYQ55ioz3PczmDnmzjpuwl54owPJYlb2O9C76RJiIGU4wLbE0vNLVyzAnIjhtbnJPw5Z4XGXhgO3V7v9KKF9nwN7XQ4tN8r7xE+JXinW2uZo9ti+5cON7d/cQhpO2o8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fea398-8138-44fb-0ec8-08d790044912
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 04:20:37.4754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DrTXp7SCQbZoezeI1YizP/+EwPMVz8pnxQTkgzYWqb5Vi5ecVF7B4ulcCmCyJd0b6ggHBzcBCft0MTbA8GgOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBDaHJpc3RpYW4sIA0KSSB3b25kZXIgaWYgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGludG8g
dGhpcyB3YXJuaW5nLiANClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIHNvbWV0aGluZyB3
ZSBjb3VsZCBoZWxwIHdpdGguDQoNClJlZ2FyZHMsDQpBbGVqYW5kcm8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMiwgMjAxOSAyOjUy
IEFNDQpUbzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNv
bT47IFNpZXJyYSBHdWl6YSwgQWxlamFuZHJvIChBbGV4KSA8QWxleC5TaWVycmFAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1OiBpbW1lZGlhbGx5IGludmFsaWRh
dGUgUFRFcw0KDQpbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNCkhpIEZlbGl4LA0KDQp5ZWFo
LCBJJ3ZlIGFsc28gZm91bmQgYSBjb3JuZXIgY2FzZSB3aGljaCB3b3VsZCByYWlzZSBhIHdhcm5p
bmcgbm93Lg0KDQpOZWVkIHRvIHJld29yayBob3cgZGVwZW5kZW5jaWVzIGZvciB0aGUgUFRFIHVw
ZGF0ZSBhcmUgZ2VuZXJhdGVkLg0KDQpHb2luZyB0byB0YWtlIGNhcmUgb2YgdGhpcyBpbiB0aGUg
bmV4dCBmZXcgZGF5cywgQ2hyaXN0aWFuLg0KDQpBbSAxMi4xMi4xOSB1bSAwMToyMCBzY2hyaWVi
IEZlbGl4IEt1ZWhsaW5nOg0KPiBIaSBDaHJpc3RpYW4sDQo+DQo+IEFsZXggc3RhcnRlZCB0cnlp
bmcgdG8gaW52YWxpZGF0ZSBQVEVzIGluIHRoZSBNTVUgbm90aWZpZXJzIGFuZCB3ZSdyZSANCj4g
ZmluZGluZyB0aGF0IHdlIHN0aWxsIG5lZWQgdG8gcmVzZXJ2ZSB0aGUgVk0gcmVzZXJ2YXRpb24g
Zm9yIA0KPiBhbWRncHVfc3luY19yZXN2IGluIGFtZGdwdV92bV9zZG1hX3ByZXBhcmUuIElzIHRo
YXQgc3luY19yZXN2IHN0aWxsIA0KPiBuZWVkZWQgbm93LCBnaXZlbiB0aGF0IFZNIGZlbmNlcyBh
cmVuJ3QgaW4gdGhhdCByZXNlcnZhdGlvbiBvYmplY3QgYW55IA0KPiBtb3JlPw0KPg0KPiBSZWdh
cmRzLA0KPiAgIEZlbGl4DQo+DQo+IE9uIDIwMTktMTItMDUgNTozOSwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToNCj4+IFdoZW4gYSBCTyBpcyBldmljdGVkIGltbWVkaWFsbHkgaW52YWxpZGF0ZSB0
aGUgbWFwcGVkIFBURXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTcgKysrKysrKysrKysrKysrKy0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGluZGV4IDgzOWQ2ZGYzOTRmYy4u
ZTU3ODExM2JmZDU1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jDQo+PiBAQCAtMjU2NSw2ICsyNTY1LDcgQEAgdm9pZCBhbWRncHVfdm1fYm9faW52YWxpZGF0
ZShzdHJ1Y3QgDQo+PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBhbWRncHVfYm8gKmJvLCBib29sIGV2aWN0ZWQpDQo+PiAgIHsNCj4+ICAgICAgIHN0
cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsNCj4+ICsgICAgaW50IHI7DQo+PiAgICAg
ICAgIC8qIHNoYWRvdyBibyBkb2Vzbid0IGhhdmUgYm8gYmFzZSwgaXRzIHZhbGlkYXRpb24gbmVl
ZHMgaXRzIA0KPj4gcGFyZW50ICovDQo+PiAgICAgICBpZiAoYm8tPnBhcmVudCAmJiBiby0+cGFy
ZW50LT5zaGFkb3cgPT0gYm8pIEBAIC0yNTcyLDggKzI1NzMsMjIgDQo+PiBAQCB2b2lkIGFtZGdw
dV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAgICAg
ICBmb3IgKGJvX2Jhc2UgPSBiby0+dm1fYm87IGJvX2Jhc2U7IGJvX2Jhc2UgPSBib19iYXNlLT5u
ZXh0KSB7DQo+PiAgICAgICAgICAgc3RydWN0IGFtZGdwdV92bSAqdm0gPSBib19iYXNlLT52bTsN
Cj4+ICsgICAgICAgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRi
by5iYXNlLnJlc3Y7DQo+PiArDQo+PiArICAgICAgICBpZiAoYm8tPnRiby50eXBlICE9IHR0bV9i
b190eXBlX2tlcm5lbCkgew0KPj4gKyAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJv
X3ZhOw0KPj4gKw0KPj4gKyAgICAgICAgICAgIGJvX3ZhID0gY29udGFpbmVyX29mKGJvX2Jhc2Us
IHN0cnVjdCBhbWRncHVfYm9fdmEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIGJhc2Up
Ow0KPj4gKyAgICAgICAgICAgIHIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGJvLT50Ym8uYmFzZS5yZXN2ICE9IHJlc3YpOw0K
Pj4gKyAgICAgICAgICAgIGlmICghcikgew0KPj4gKyAgICAgICAgICAgICAgICBhbWRncHVfdm1f
Ym9faWRsZShib19iYXNlKTsNCj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiArICAg
ICAgICAgICAgfQ0KPj4gKyAgICAgICAgfQ0KPj4gICAtICAgICAgICBpZiAoZXZpY3RlZCAmJiBi
by0+dGJvLmJhc2UucmVzdiA9PQ0KPj4gdm0tPnJvb3QuYmFzZS5iby0+dGJvLmJhc2UucmVzdikg
ew0KPj4gKyAgICAgICAgaWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0gcmVzdikg
ew0KPj4gICAgICAgICAgICAgICBhbWRncHVfdm1fYm9fZXZpY3RlZChib19iYXNlKTsNCj4+ICAg
ICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgfQ0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
