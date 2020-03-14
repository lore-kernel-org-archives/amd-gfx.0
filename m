Return-Path: <SRS0=+uvl=47=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49018C0044D
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Mar 2020 13:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E954C20774
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Mar 2020 13:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SdaJ4fE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E954C20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18D06E1D2;
	Sat, 14 Mar 2020 13:06:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40B46E1D2
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Mar 2020 13:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcbrYzTbVG43vASTp9XCXPb2B3POOZrdfWKjb56Ax99NRns0qQqXL2HgkNfUiAKvF6DOSeHuGNOf8aA3aWHOZsB4yEmh3NNri5ywEmQrjLhF+NPGS8QElKC9LJfULSKBrR2NxfbTWjKgxaRPTHmEP0OmyySsyLxTmSzz1MJLaMMK40ssPB7GZyyKR4Da0/7fmEzpKTKlAT7f+yMF1C5kN8KMb1MP0lcy7gcPKrKgOR8lVG1jnz2mDg6t6YeUhlqJz83wPSDkiwioDQGqXbs76zwCIJWi61OWSoGmzcKBOyLov4cYkxfvmXGba/gTFWcWYvx7/8t848aHhV5AaGZRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ozlyWzLcivx+zAEqOhZZqyDVMmqIy8dkAZdEfrvNUk=;
 b=X4S+1dsRkiQZCk9kIDV517YkbjmLW4ld38x4r5HXHlI12TaELadzxt8qKpyUxVp4DEBZPOkW8uPEZeHPt0wXki8sRv6DMI7KwSNmIdP2gQ3AbOMp+gG6BDCo2t03IQ+qqmeUBmNpvZkToS2tnDAvOCuTk5d+oE7B7/iDk8LZgpmr4u44Cf9vP95ummGo1jXB4DYcIMyE3S+fHhbjFjovFIkDIxQhFXyXHFIFUrBVoaw7e+m3Lt+Rz40X7zmStqDt7M5WqQj8d2Df8Ny7hiLfU8fCp1qtOJl/Fj0Hj9CPjhNSnrlAd8IkRad+QOKWYKdq8MrE1lfHZHNCvM9lPA+dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ozlyWzLcivx+zAEqOhZZqyDVMmqIy8dkAZdEfrvNUk=;
 b=SdaJ4fE0TrmkpoYjzdNBTs0+dQrrYZQhp6/iFxkwdpAqlXv09qlXV2XjyuVFz1BXbc1Fg3Z2SN0NUxzJl3CQv6t11BvAJS2cfIvv+4H4orKDhLXuWjxhEhGn4CCKAvNnfk27d/RPPnGSu5XvVsezsAc+2bdo22oYg96jhMbFsCE=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2606.namprd12.prod.outlook.com (2603:10b6:805:6e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Sat, 14 Mar
 2020 13:06:39 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.023; Sat, 14 Mar 2020
 13:06:39 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: unref pt bo after job submit
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: unref pt bo after job submit
Thread-Index: AQHV+VHad+KweJcFf0OxibDUTbuNqKhGyTCAgAAIQ4CAAT60AA==
Date: Sat, 14 Mar 2020 13:06:39 +0000
Message-ID: <F3699385-BC6C-4C99-B058-802B567F9B51@amd.com>
References: <20200313160933.10394-1-xinhui.pan@amd.com>
 <20200313160933.10394-3-xinhui.pan@amd.com>
 <2b38aa48-40c1-2830-0005-2ddca7672535@amd.com>
 <0b809d9d-8e25-46c0-9799-09a36f15a37c@amd.com>
In-Reply-To: <0b809d9d-8e25-46c0-9799-09a36f15a37c@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d700012-64c4-4046-5569-08d7c81888a9
x-ms-traffictypediagnostic: SN6PR12MB2606:|SN6PR12MB2606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2606CC47923EE731F6C801CB87FB0@SN6PR12MB2606.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(6512007)(6862004)(26005)(6486002)(478600001)(86362001)(2906002)(71200400001)(6506007)(53546011)(4326008)(66574012)(66446008)(91956017)(76116006)(2616005)(186003)(6636002)(8676002)(81156014)(81166006)(66476007)(36756003)(54906003)(316002)(37006003)(5660300002)(8936002)(66556008)(64756008)(66946007)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2606;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqthTA1aTWMRownptR1UUB/ct0eZ1oJ7Dpv8PKTgElfDWbGikty/du8E57gZcMSNML6IaPoF2iJ7gdgsxViJ0YAsk1x/4cCUbzbBaOokxgy2F3+YXWxiP6I+Y2G/izRFzbBUrIHEJxgbjaRIP6m3BFn36Kr6cpWxQW9IsNhv74+ZTi8F+SE/XhPuWsfVM06+KRKMtAbunjRdhu7xIk+p/erDgn/ydW1l3dqQziriUC08mSpnP9Cj5ry9w96Iuz/d3b6fPUj9tv/ulrbKEbfP0zJ9EEJs9KgW+kFeXd8CPkYvirojIiu7ke+3IKa4hbXlZnEwP07pkb63AFdKWkanhiCdow6jIjYXLfj5WDZCoTSnKmFh8vSSCqyZCDy9aSwlgRHrI8HiVcReTbYU0soMAD+CG3hbwARAZisPTPbhJf8L/jNxWM4yOeMe2fIRGVsg
x-ms-exchange-antispam-messagedata: sbnmRtJYoGwfgWEMxRYyJXqkNRRntyvGl+AkDrohpAK0s5C2QoBTuYjV1Gieust39mEk3CkwXJO3tHnK0uPuswY9HXWU4CjkFQA7lKwpB8dRmND1AsJva2h/sQDwqBrVor6z6gAM+ooUD7rzrJ1orA==
Content-ID: <5BB02CC112A5F347A21AF58F810DD071@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d700012-64c4-4046-5569-08d7c81888a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 13:06:39.2344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PmuBZx+yB4tI4CBfA2scHoE5CKX54JtdSORXXMXYF/nyDzwO80YiqCN2rcgRurL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aGksIEFsbA0KSSB0aGluayBJIGZvdW5kIHRoZSByb290IGNhdXNlLiBoZXJlIGlzIHdoYXQgaGFw
cGVuZWQuDQoNCnVzZXI6IGFsbG9jL21hcHBpbmcgbWVtb3J5DQoJIAlrZXJuZWw6IHZhbGlkYXRl
IG1lbW9yeSBhbmQgdXBkYXRlIHRoZSBibyBtYXBwaW5nLCBhbmQgdXBkYXRlIHRoZSBwYWdlIHRh
YmxlDQoJCQktPiBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcNCgkJCQktPiBhbWRncHVfdm1f
dXBkYXRlX3B0ZXMNCgkJCQkJLT4gYW1kZ3B1X3ZtX2FsbG9jX3B0cw0KCQkJCQkJLT4gYW1kZ3B1
X3ZtX2NsZWFyX2JvIC8vIGl0IHdpbGwgc3VibWl0IGEgam9iIGFuZCB3ZSBoYXZlIGEgZmVuY2Uu
IEJVVCBpdCBpcyBOT1QgYWRkZWQgaW4gcmVzdi4NCnVzZXI6IGZyZWUvdW5tYXBwaW5nIG1lbW9y
eQ0KCQlrZXJuZWw6IHVubWFwcGluZyBtbWVvcnkgYW5kIHVkcGF0ZSB0aGUgcGFnZSB0YWJsZQ0K
CQkJLT4gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nDQoJCQlzeW5jIGxhc3RfZGVsYXkgZmVu
Y2UgaWYgZmxhZyAmIEFNREdQVV9QVEVfVkFMSUQgLy8gb2Ygc291cmNlIHdlIGRpZCBub3Qgc3lu
YyBpdCBoZXJlLCBhcyB0aGlzIGlzIHVubWFwcGluZy4NCgkJCQktPiBhbWRncHVfdm1fdXBkYXRl
X3B0ZXMNCgkJCQkJLT4gYW1kZ3B1X3ZtX2ZyZWVfcHRzIC8vIHVucmVmIHBhZ2UgdGFibGUgYm8u
DQoNClNvIGZyb20gdGhlIHNlcXVlbmNlIGFib3ZlLCB3ZSBrbm93IHRoZXJlIGlzIGEgcmFjZSBi
ZXR3ZW4gYm8gcmVsZWFzaW5nIGFuZCBibyBjbGVhcmluZy4NCmJvIG1pZ2h0IGhhdmUgYmVlbiBy
ZWxlYXNlZCBiZWZvcmUgam9iIHJ1bm5pbmcuDQoNCndlIGNhbiBmaXggaXQgaW4gc2V2ZXJhbCB3
YXlzLA0KMSkgc3luYyBsYXN0X2RlbGF5IGluIGJvdGggbWFwcGluZyBhbmQgdW5tYXBwaW5nIGNh
c2UuDQogQ2hyaXMsIHlvdSBqdXN0IHN5bmMgbGFzdF9kZWxheSBpbiBtYXBwaW5nIGNhc2UsIHNo
b3VsZCBpdCBiZSBvayB0byBzeW5jIGl0IGFsc28gaW4gdW5tYXBwaW5nIGNhc2U/DQoNCjIpIGFs
d2F5cyBhZGQgZmVuY2UgdG8gcmVzdiBhZnRlciBjb21taXQuIA0KIHRoaXMgaXMgZG9uZSBieSBw
YXRjaHNldCB2NC4gQW5kIG9ubHkgbmVlZCBwYXRjaCAxLiBubyBuZWVkIHRvIG1vdmUgdW5yZWYg
Ym8gYWZ0ZXIgY29tbWl0Lg0KDQozKSBtb3ZlIHVucmVmIGJvIGFmdGVyIGNvbW1pdCwgYW5kIGFk
ZCB0aGUgbGFzdCBkZWxheSBmZW5jZSB0byByZXN2LiANClRoaXMgaXMgZG9uZSBieSBwYXRjaHNl
dCBWMS4gDQoNCg0KYW55IGlkZWFzPw0KDQp0aGFua3MNCnhpbmh1aQ0KDQo+IDIwMjDlubQz5pyI
MTTml6UgMDI6MDXvvIxLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PiDlhpnpgZPvvJoNCj4gDQo+IFRoZSBwYWdlIHRhYmxlIGlzIG5vdCB1cGRhdGVkIGFuZCB0aGVu
IGZyZWVkLiBBIGhpZ2hlciBsZXZlbCBQREUgaXMgdXBkYXRlZCBhbmQgYmVjYXVzZSBvZiB0aGlz
IHRoZSBsb3dlciBsZXZlbCBwYWdlIHRhYmxlcyBpcyBmcmVlZC4NCj4gDQo+IFdpdGhvdXQgdGhp
cyBpdCBjb3VsZCBiZSB0aGF0IHRoZSBtZW1vcnkgYmFja2luZyB0aGUgZnJlZWQgcGFnZSB0YWJs
ZSBpcyByZXVzZWQgd2hpbGUgdGhlIFBERSBpcyBzdGlsbCBwb2ludGluZyB0byBpdC4NCj4gDQo+
IFJhdGhlciB1bmxpa2VseSB0aGF0IHRoaXMgY2F1c2VzIHByb2JsZW1zLCBidXQgYmV0dGVyIHNh
dmUgdGhhbiBzb3JyeS4NCj4gDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo+IEFtIDEz
LjAzLjIwIHVtIDE4OjM2IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6DQo+PiBUaGlzIHNlZW1zIHdl
aXJkLiBUaGlzIG1lYW5zIHRoYXQgd2UgdXBkYXRlIGEgcGFnZSB0YWJsZSwgYW5kIHRoZW4gZnJl
ZSBpdCBpbiB0aGUgc2FtZSBhbWRncHVfdm1fdXBkYXRlX3B0ZXMgY2FsbD8gVGhhdCBtZWFucyB0
aGUgdXBkYXRlIGlzIHJlZHVuZGFudC4gQ2FuIHdlIGVsaW1pbmF0ZSB0aGUgcmVkdW5kYW50IFBU
RSB1cGRhdGUgaWYgdGhlIHBhZ2UgdGFibGUgaXMgYWJvdXQgdG8gYmUgZnJlZWQgYW55d2F5Pw0K
Pj4gDQo+PiBSZWdhcmRzLA0KPj4gICBGZWxpeA0KPj4gDQo+PiBPbiAyMDIwLTAzLTEzIDEyOjA5
LCB4aW5odWkgcGFuIHdyb3RlOg0KPj4+IEZyZWUgcGFnZSB0YWJsZSBibyBiZWZvcmUgam9iIHN1
Ym1pdCBpcyBpbnNhbmUuDQo+Pj4gV2UgbWlnaHQgdG91Y2ggaW52YWxpZCBtZW1vcnkgd2hpbGUg
am9iIGlzIHJ1bm5pZy4NCj4+PiANCj4+PiB3ZSBub3cgaGF2ZSBpbmRpdmlkdWFsaXplZCBibyBy
ZXN2IGR1cmluZyBibyByZWxlYXNpbmcuDQo+Pj4gU28gYW55IGZlbmNlcyBhZGRlZCB0byByb290
IFBUIGJvIGlzIGFjdHVhbGx5IHVudGVzdGVkIHdoZW4NCj4+PiBhIG5vcm1hbCBQVCBibyBpcyBy
ZWxlYXNpbmcuDQo+Pj4gDQo+Pj4gV2UgbWlnaHQgaGl0IGdtYyBwYWdlIGZhdWx0IG9yIG1lbW9y
eSBqdXN0IGdvdCBvdmVyd3JpdGVkLg0KPj4+IA0KPj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4+PiBDYzogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQu
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0NCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDMgKysrDQo+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+PiBpbmRleCA3MzM5ODgzMTE5NmYuLjM0NmUyZjc1MzQ3
NCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+Pj4g
QEAgLTkzNyw2ICs5MzcsMjEgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+ICAgICAgIHJldHVybiByOw0KPj4+ICAgfQ0KPj4+
ICAgK3N0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3pvbWJpZV9ibyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCj4+PiArICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkNCj4+PiArew0K
Pj4+ICsgICAgc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnk7DQo+Pj4gKw0KPj4+ICsgICAgd2hp
bGUgKCFsaXN0X2VtcHR5KCZ2bS0+em9tYmllcykpIHsNCj4+PiArICAgICAgICBlbnRyeSA9IGxp
c3RfZmlyc3RfZW50cnkoJnZtLT56b21iaWVzLCBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0LA0KPj4+ICsg
ICAgICAgICAgICAgICAgYmFzZS52bV9zdGF0dXMpOw0KPj4+ICsgICAgICAgIGxpc3RfZGVsKCZl
bnRyeS0+YmFzZS52bV9zdGF0dXMpOw0KPj4+ICsNCj4+PiArICAgICAgICBhbWRncHVfYm9fdW5y
ZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOw0KPj4+ICsgICAgICAgIGFtZGdwdV9ib191bnJl
ZigmZW50cnktPmJhc2UuYm8pOw0KPj4+ICsgICAgfQ0KPj4+ICt9DQo+Pj4gKw0KPj4+ICAgLyoq
DQo+Pj4gICAgKiBhbWRncHVfdm1fZnJlZV90YWJsZSAtIGZyZSBvbmUgUEQvUFQNCj4+PiAgICAq
DQo+Pj4gQEAgLTk0NSwxMCArOTYwLDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X3Zt
X2ZyZWVfdGFibGUoc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkpDQo+Pj4gICB7DQo+Pj4gICAg
ICAgaWYgKGVudHJ5LT5iYXNlLmJvKSB7DQo+Pj4gKyAgICAgICAgbGlzdF9tb3ZlKCZlbnRyeS0+
YmFzZS52bV9zdGF0dXMsDQo+Pj4gKyAmZW50cnktPmJhc2UuYm8tPnZtX2JvLT52bS0+em9tYmll
cyk7DQo+Pj4gICAgICAgICAgIGVudHJ5LT5iYXNlLmJvLT52bV9ibyA9IE5VTEw7DQo+Pj4gLSAg
ICAgICAgbGlzdF9kZWwoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cyk7DQo+Pj4gLSAgICAgICAgYW1k
Z3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsNCj4+PiAtICAgICAgICBhbWRn
cHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvKTsNCj4+PiAgICAgICB9DQo+Pj4gICAgICAga3Zm
cmVlKGVudHJ5LT5lbnRyaWVzKTsNCj4+PiAgICAgICBlbnRyeS0+ZW50cmllcyA9IE5VTEw7DQo+
Pj4gQEAgLTE2MjQsNiArMTYzOCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9t
YXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+ICAgICAgIHIgPSB2bS0+dXBk
YXRlX2Z1bmNzLT5jb21taXQoJnBhcmFtcywgZmVuY2UpOw0KPj4+ICAgICBlcnJvcl91bmxvY2s6
DQo+Pj4gKyAgICBhbWRncHVfdm1fZnJlZV96b21iaWVfYm8oYWRldiwgdm0pOw0KPj4+ICAgICAg
IGFtZGdwdV92bV9ldmljdGlvbl91bmxvY2sodm0pOw0KPj4+ICAgICAgIHJldHVybiByOw0KPj4+
ICAgfQ0KPj4+IEBAIC0yODA3LDYgKzI4MjIsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPj4+ICAgICAgIElO
SVRfTElTVF9IRUFEKCZ2bS0+aW52YWxpZGF0ZWQpOw0KPj4+ICAgICAgIHNwaW5fbG9ja19pbml0
KCZ2bS0+aW52YWxpZGF0ZWRfbG9jayk7DQo+Pj4gICAgICAgSU5JVF9MSVNUX0hFQUQoJnZtLT5m
cmVlZCk7DQo+Pj4gKyAgICBJTklUX0xJU1RfSEVBRCgmdm0tPnpvbWJpZXMpOw0KPj4+ICAgICAg
ICAgICAvKiBjcmVhdGUgc2NoZWR1bGVyIGVudGl0aWVzIGZvciBwYWdlIHRhYmxlIHVwZGF0ZXMg
Ki8NCj4+PiBAQCAtMzExOSw2ICszMTM1LDggQEAgdm9pZCBhbWRncHVfdm1fZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pDQo+Pj4gICAgICAgfQ0K
Pj4+ICAgICAgICAgYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBOVUxMKTsNCj4+PiArICAg
IGFtZGdwdV92bV9mcmVlX3pvbWJpZV9ibyhhZGV2LCB2bSk7DQo+Pj4gKw0KPj4+ICAgICAgIGFt
ZGdwdV9ib191bnJlc2VydmUocm9vdCk7DQo+Pj4gICAgICAgYW1kZ3B1X2JvX3VucmVmKCZyb290
KTsNCj4+PiAgICAgICBXQVJOX09OKHZtLT5yb290LmJhc2UuYm8pOw0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+Pj4gaW5kZXggYjU3MDVmY2ZjOTM1Li45YmFmNDRm
YTE2ZjAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmgNCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0K
Pj4+IEBAIC0yNjksNiArMjY5LDkgQEAgc3RydWN0IGFtZGdwdV92bSB7DQo+Pj4gICAgICAgLyog
Qk8gbWFwcGluZ3MgZnJlZWQsIGJ1dCBub3QgeWV0IHVwZGF0ZWQgaW4gdGhlIFBUICovDQo+Pj4g
ICAgICAgc3RydWN0IGxpc3RfaGVhZCAgICBmcmVlZDsNCj4+PiAgICsgICAgLyogQk8gd2lsbCBi
ZSBmcmVlZCBzb29uICovDQo+Pj4gKyAgICBzdHJ1Y3QgbGlzdF9oZWFkICAgIHpvbWJpZXM7DQo+
Pj4gKw0KPj4+ICAgICAgIC8qIGNvbnRhaW5zIHRoZSBwYWdlIGRpcmVjdG9yeSAqLw0KPj4+ICAg
ICAgIHN0cnVjdCBhbWRncHVfdm1fcHQgICAgIHJvb3Q7DQo+Pj4gICAgICAgc3RydWN0IGRtYV9m
ZW5jZSAgICAqbGFzdF91cGRhdGU7DQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
