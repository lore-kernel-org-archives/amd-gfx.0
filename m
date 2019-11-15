Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C5C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 17:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166DD2072D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 17:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166DD2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD68A6E323;
	Fri, 15 Nov 2019 17:03:03 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790077.outbound.protection.outlook.com [40.107.79.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD1F6E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 17:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnzrrkoNHFZVERhl02SC0lAa3e0PUIV0mESIkrYW9nsF6uMoP7QTKz2gOkXnnpbGBqjSFxTpnQLhtXL79EMS7v2jzfAol3bE2C1W/czlTVekXFO/xU+QEEsPvlkD0eSwaXZQnKOuaCTrPI1K1MxKeW779TLVmDhrjPEUqnPbl1VTehWj4siVHDYDnkJGOXt7QrEBhE42lxEJ/jb2U1T6hPg97/bgI3t9HqJ1vBjLEtpo2fU8Q4d2zIh53hY/gRqkYKTryeT+JbvqBRqmf3OksyM5LkiLICi4hRS/J7D8pISG/XkKN0lXFB28MW7I6E5DYB7/ZhFbdzYpBvOrP7r3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO6UPVKr/GYqh1Wd8ZbGnJbzwVklKSiy9mxQeIZ4+S4=;
 b=cNF42PuDOY6Cum7/hhmxD0OhB/F9sbU2jF0PZ9kf28AaAihYoJ+DPYqDQb8LWv+71aw1L8pzz1zk2Hlcr1pw+UB0VbSEG4xoRM06jWFiqULQWbcFZgz+FMdhOLnTNj0dAzyGOTG2Khxwx7PkZWovQFV4eToZqpCT0nfcF+SKEgeoh1tKYP0fPpcD5KKz3uvPn+SSqWMawuUL3qV+8xUBEvr9fLB8kaKr7oD6x3EIRquhfVRmvjwucyZ9Z0Q9USO8jc5mVh04+Ku5y2iDgDAeC65ZJ0OOEM1GnAr+EKOqjiF6iQ94n6Ub0BOMCEXlA0LPO1e0mq+aY0i0J0xwdLEeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3840.namprd12.prod.outlook.com (10.255.239.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.24; Fri, 15 Nov 2019 17:02:59 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.023; Fri, 15 Nov 2019
 17:02:59 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Index: AQHVmwq/in9OCtzEpUCFWEfsKe4IV6eMcnQSgAABkYCAAAL2lA==
Date: Fri, 15 Nov 2019 17:02:59 +0000
Message-ID: <7F901A1C-E7F6-40A1-ACFE-630ECCA24104@amd.com>
References: <20191114164148.2304223-1-alexander.deucher@amd.com>
 <20191114164148.2304223-2-alexander.deucher@amd.com>
 <93CD6C6F-21F7-4BCA-AC65-FDC37AF896E3@amd.com>,
 <CADnq5_McjfD_ZJHa_RFzfRuxFzjSkG7C1S1VhtYNPHH_f9MViA@mail.gmail.com>
In-Reply-To: <CADnq5_McjfD_ZJHa_RFzfRuxFzjSkG7C1S1VhtYNPHH_f9MViA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.93.227.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce69b701-7041-4f50-327f-08d769edab0a
x-ms-traffictypediagnostic: MN2PR12MB3840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB384023856D9DCF5CEEFE9DDE89700@MN2PR12MB3840.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(52314003)(316002)(53546011)(66446008)(71200400001)(478600001)(64756008)(66066001)(5660300002)(71190400001)(66556008)(3846002)(66476007)(6916009)(186003)(6306002)(6512007)(6246003)(7736002)(305945005)(11346002)(6436002)(256004)(446003)(2616005)(229853002)(14444005)(6116002)(86362001)(14454004)(476003)(33656002)(6506007)(102836004)(486006)(966005)(4326008)(66946007)(2906002)(6486002)(81166006)(81156014)(26005)(8676002)(1411001)(76176011)(8936002)(99286004)(54906003)(76116006)(91956017)(25786009)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3840;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoBSwWW2kLnS4FE+NkJ7PF3WA5MEr7zoxhiTRtrCEPgeg4C22zafiDf3yqcR2BynFaoBP30g77UN5mlfY1UkRqxPogu7UEo/7EttCsdJKS7tFxKc+YNDINeQogpKU//i4fQYdNWU/4fIPg2iN3ln9LXA/O0nO9vrK+Kh3i/mv4wxE2ylw650TqO+fAw56OevzJtORX2b0GbbwtG8fTachSz47uyYNQH+BLWXKvJvp8Vg9HGrTIafUOvxQVo/5ckCrfv24uenrD10ECkVzOAlgv1u4kWtDZZsRqKr69tBDqffWEil11z51+MyIqI8+vvGUW7kuCQANF2y9hdDSq+jD92hOOY0BNmgqZ1p0Y5voIulDtaT6jFjoA6Y/xBFUNNtZlLzFWb72JUzZV3jlHEhLBWX9ocB/4uVgcA9Z+yOM5jr7w5A2Se+5u/KjwevAKzR
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69b701-7041-4f50-327f-08d769edab0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 17:02:59.1903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8D3lQt3XdWnJ4+DecXFzsNLjOwV9EUOcA7w3l6esGZGUNOS2b5jiY33PBlMcQ/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO6UPVKr/GYqh1Wd8ZbGnJbzwVklKSiy9mxQeIZ4+S4=;
 b=k+8DNPp45N58v+fXxmXwKNYOlZMESIqnJeaPv+i62EaGjEwytFkeGq18BJOvvgpMUp5zLx7VRinJCFE+02yq4MwkQ/yKjw6hUSEsUlzd44s1rAdNNBGASzNkM07TTlqL/iB4ApC2psjQrbhKXqicqxb5yXPikm40cqiVLwOIc18=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115170259.gFe6CF8IeEZMGbS9OT20z802lu2rWpAha_GpyK1voPw@z>

WWVzLiBJSVJDLCBzb21lIGFzaWNzJyBhbWRncHVfZ2Z4X2N0cmwoKSBpcyBpbXBsZW1lbnRlZCBh
cyBzeW5jaHJvbm91cyAodXBvbiBmdW5jdGlvbiByZXR1cm5zLCBnZnggYmxvY2sgaXMgZ3VhcmFu
dGVlZCB0byBiZSBpbiBwb3dlci11cCBzdGF0ZSkuIEFueXdheSwgbGV0IG1lIGNvbmZpcm0gYWJv
dXQgdGhhdCBzb29uLgoKQlIsClhpYW9qaWUKCj4gT24gTm92IDE2LCAyMDE5LCBhdCAxMjo1MiBB
TSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+IAo+PiBPbiBG
cmksIE5vdiAxNSwgMjAxOSBhdCAxMTo0NiBBTSBZdWFuLCBYaWFvamllIDxYaWFvamllLll1YW5A
YW1kLmNvbT4gd3JvdGU6Cj4+IAo+PiBIaSBBbGV4LAo+PiAKPj4gSU1ITywgZHJpdmVyIHNlbmRp
bmcgRGlzYWxsb3dfR2Z4b2ZmIG1lc3NhZ2UgdG8gU01VIGRvZXNuJ3QgbWVhbiBnZnggYmxvY2sg
d2lsbCBiZSBpbW1lZGlhdGVseSBwb3dlcmVkIHVwLCBzbyBJJ20gbm90IHN1cmUgTU1JTyByZWdp
c3RlciBhY2Nlc3Mgd2lsbCBiZSBzdWNjZXNzZnVsIHdpdGhpbiB0aGlzIHRpbWUgd2luZG93KG1h
eWJlIEdSQk0gYWNjZXNzIHdpbGwgYmUgcGVuZGluZyB1bnRpbCBnZnggYmxvY2sgaXMgcG93ZXJl
ZCB1cD8pCj4+IAo+PiBJZiB5b3UgYXJlIG5vdCBpbiBhIGh1cnJ5IHRvIGNvbW1pdCB0aGlzIGZp
eCwgSSBjYW4gdmVyaWZ5IG9uIG15IE5hdmkgYm9hcmRzIG5leHQgTW9uZGF5Lgo+IAo+IFRoYXQg
d291bGQgYmUgZ3JlYXQuICBNYXliZSB3ZSBjYW4gYWRkIGEgZGVsYXkgaW4gdGhhdCBmdW5jdGlv
biB0bwo+IHRha2UgdGhhdCBpbnRvIGFjY291bnQ/Cj4gCj4gVGhhbmtzIQo+IAo+IEFsZXgKPiAK
Pj4gCj4+IEJSLAo+PiBYaWFvamllCj4+IAo+Pj4gT24gTm92IDE1LCAyMDE5LCBhdCAxMjo0NCBB
TSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Pj4gCj4+PiBX
aGVuIGdmeG9mZiBpcyBlbmFibGVkLCBhY2Nlc3NpbmcgZ2Z4IHJlZ2lzdGVycyB2aWEgTU1JTwo+
Pj4gY2FuIGxlYWQgdG8gYSBoYW5nLgo+Pj4gCj4+PiBCdWc6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA1NDk3Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+PiAtLS0KPj4+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDYgKysrKystCj4+PiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+PiAKPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPj4+IGluZGV4IDZkZGVhNzYwN2FkMC4uNWYzYjNhNzA1
YjI5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2tt
cy5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPj4+
IEBAIC02NTksMTUgKzY1OSwxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVj
dCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZQo+Pj4gICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOwo+Pj4gICAgICAgYWxsb2Nfc2l6ZSA9IGluZm8tPnJlYWRfbW1y
X3JlZy5jb3VudCAqIHNpemVvZigqcmVncyk7Cj4+PiAKPj4+IC0gICAgICAgIGZvciAoaSA9IDA7
IGkgPCBpbmZvLT5yZWFkX21tcl9yZWcuY291bnQ7IGkrKykKPj4+ICsgICAgICAgIGFtZGdwdV9n
Znhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+Pj4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8IGlu
Zm8tPnJlYWRfbW1yX3JlZy5jb3VudDsgaSsrKSB7Cj4+PiAgICAgICAgICAgaWYgKGFtZGdwdV9h
c2ljX3JlYWRfcmVnaXN0ZXIoYWRldiwgc2VfbnVtLCBzaF9udW0sCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW5mby0+cmVhZF9tbXJfcmVnLmR3b3JkX29mZnNldCArIGksCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJlZ3NbaV0pKSB7Cj4+PiAgICAgICAgICAgICAg
IERSTV9ERUJVR19LTVMoInVuYWxsb3dlZCBvZmZzZXQgJSN4XG4iLAo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgaW5mby0+cmVhZF9tbXJfcmVnLmR3b3JkX29mZnNldCArIGkpOwo+Pj4gICAg
ICAgICAgICAgICBrZnJlZShyZWdzKTsKPj4+ICsgICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9v
ZmZfY3RybChhZGV2LCB0cnVlKTsKPj4+ICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4+
PiAgICAgICAgICAgfQo+Pj4gKyAgICAgICAgfQo+Pj4gKyAgICAgICAgYW1kZ3B1X2dmeF9vZmZf
Y3RybChhZGV2LCB0cnVlKTsKPj4+ICAgICAgIG4gPSBjb3B5X3RvX3VzZXIob3V0LCByZWdzLCBt
aW4oc2l6ZSwgYWxsb2Nfc2l6ZSkpOwo+Pj4gICAgICAga2ZyZWUocmVncyk7Cj4+PiAgICAgICBy
ZXR1cm4gbiA/IC1FRkFVTFQgOiAwOwo+Pj4gLS0KPj4+IDIuMjMuMAo+Pj4gCj4+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWls
aW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
