Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA69C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 01:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FBC2072D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 01:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SOCWx17i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FBC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0775D6E1ED;
	Tue, 31 Mar 2020 01:59:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F7E6E1ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 01:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBYGe/roru2t5zU9dnSVdBWOsoCVPckNUfKJjYyvWA2zUI/krebCUhsx4RK7zxT4NvHR6EOw9R4p35TTWqclcNc7f2CiH+9KSZ98E68TMPoD1Yq5nhnwTNZWREhCT8L0TB7RbNHdebxyTP63upwoYm7uDNmkMjlRYZX9qWGopTgJgx7EG+uDs6n8WajE9AaHJsIByQQr/GydZspQcItEQ4T2/wJax7rDGVvf3RRBnv54QqpGtv43AwRE91W5JS++nBFKTZs+OmLUEgEVAdResGnvoMH+K3AVikPfNF0zNjd3cCz6jbLq02HLm+NOGsmB2WNnfD6XdJ2fXghlCx1ypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGSIbTnTH8S5xQ3yp7seLTMKA0YN3S4vFi5nIuDw0j4=;
 b=SWAyh2ZZ4+MN0x4buDmsA+h2kIE1O0/AVYV7faw8QVR8cngBpPrh+SOKpwg1FskqE6yuMpl/nmEUFREhUEIdclrLLGZFwTyAUyelEFtcU5Z1mbxLsTFcE04FDVmKLRV2TYxjHZUCiavO11XafRkUQpUAov8Ny7osfgwsVneKJUWTJzdMbmTVAi1j65dg6f1/M9BscTY8tL2jzjc87SA9wVF79aWMibuOLOBwg7ZGY3C8ulK7PifpHH6wroLHMDBnvS4s1D4OHKPzUNS3Buwegv3QgG+h1kba+HOr0vo8/KG33tMTMT8YaXpvF67KMnOVLb5HmHUIPj5mDuYZxLupCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGSIbTnTH8S5xQ3yp7seLTMKA0YN3S4vFi5nIuDw0j4=;
 b=SOCWx17iRz5CJkjOTMvYR/E0pJkSsPDBwfTGSjJa1Ox7zdS7w9/OetdNK0/FK0TjEySZbx323YJYTAlGPqmlxcDJ0vnJWm+4QlImjHiFvgeDCvSdrhJZbRhdfiJD1eSSPYTi488mERWpJY1Rprtv4d1lbktsPxNGRf9DmcInXnE=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 01:59:30 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::8815:8e06:d0f2:c41e]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::8815:8e06:d0f2:c41e%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 01:59:30 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
 v2
Thread-Index: AQHWBoEOYFxpR7MdWkezY1izxRYKuKhh8wSA
Date: Tue, 31 Mar 2020 01:59:30 +0000
Message-ID: <71A3CE90-345D-49DC-B2D9-BB684CEDF605@amd.com>
References: <20200330105035.105045-1-christian.koenig@amd.com>
In-Reply-To: <20200330105035.105045-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 297f75da-95f0-4a18-813f-08d7d51726d8
x-ms-traffictypediagnostic: SN1PR12MB2560:|SN1PR12MB2560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB256088DAFDBA97E6A9A7D76287C80@SN1PR12MB2560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(2616005)(186003)(26005)(71200400001)(66556008)(91956017)(5660300002)(478600001)(66946007)(76116006)(66476007)(36756003)(8936002)(64756008)(66446008)(4326008)(2906002)(6486002)(81156014)(6916009)(6512007)(8676002)(86362001)(316002)(66574012)(6506007)(33656002)(54906003)(81166006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6+tEiOPZKOhHubVmTOgc4maS9p2UDusicp6ZtmAqHMnZ0HVtdBhz/uqEMFP0pJZeXChdoFDttfuTyIwPhmElzwI2DoZhw8aGI6fKHuWIwnZlxTMcSnZL//EyJQhhNPWuGPXUPvv2HMmWb8ij4MdTyPvRz0W3jY7dCAuoYZh/8ErpXsaYRLPLRX56THSfgHPFjvLGs3IROsqAOs/n/lB/plX1okUL0WVbo7mliyIizr7LtdCWGzD0g6CFNWi4HkzQZ4i+4fVmvL877dkf/LlGOCKxjxhNPctzrcjIerLyUGFzmTbxA6EbG4MGiLAaimMLAgDVt84e9Y/YBuN8gm6VKKAtZfiZAAMIGJuFLlVqLAq2mhm8CCyhsjX/fk+5rJ42Iaf43u2T0dja7I+aH4LSzCUJY2Mx+frMq4DmNdBt3VidUpilJI/b8ziO1MU0vO1
x-ms-exchange-antispam-messagedata: jIzm51D5zHzRvOEp5KCewUcLKWFVqhPj+6hebIgWyNbxaKFLgDj7xogPpN3cbkZsiOjCel/ITuZTcqm9/OGRtmIgAxJgRI24W22vjUeX8iLN/XHT1hp9wZ1vx8t60CbyOLFU/sfPBCGTvOBcmkiUdQ==
Content-ID: <8B1512668C4CB4459A17A38753B3A78A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297f75da-95f0-4a18-813f-08d7d51726d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 01:59:30.6992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iuG+iTHk4VuBpmRfBzHqXeoacUoySZpSz+cfYDjWULOdbHAwyi0ZEkoO0cSSMwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCg0KDQo+IDIwMjDl
ubQz5pyIMzDml6UgMTg6NTDvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4g5YaZ6YGT77yaDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGNh
bid0IGFkZCB0aGUgY2xlYXIgZmVuY2UgdG8gdGhlIEJPDQo+IHdoZW4gdGhlcmUgaXMgYW4gZXhj
bHVzaXZlIGZlbmNlIG9uIGl0IHNpbmNlIHdlIGNhbid0DQo+IGd1YXJhbnRlZSB0aGUgdGhlIGNs
ZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlDQo+IGV4Y2x1c2l2ZSBvbmUuDQo+IA0K
PiBUbyBmaXggdGhpcyByZWZhY3RvciB0aGUgZnVuY3Rpb24gYW5kIGFsc28gYWRkIHRoZSBleGNs
dXNpdmUNCj4gZmVuY2UgYXMgc2hhcmVkIHRvIHRoZSByZXN2IG9iamVjdC4NCj4gDQo+IHYyOiBm
aXggd2FybmluZw0KPiB2MzogYWRkIGV4Y2wgZmVuY2UgYXMgc2hhcmVkIGluc3RlYWQNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCj4gLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQx
ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZW0uYw0KPiBpbmRleCA1YmVjNjZlNmIxZjguLmEwYmU4MDUxM2U5NiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiBAQCAtMTYxLDE2ICsxNjEs
MTcgQEAgdm9pZCBhbWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
Km9iaiwNCj4gDQo+IAlzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnkgdm1fcGQ7DQo+IAlzdHJ1
Y3QgbGlzdF9oZWFkIGxpc3QsIGR1cGxpY2F0ZXM7DQo+ICsJc3RydWN0IGRtYV9mZW5jZSAqZmVu
Y2UgPSBOVUxMOw0KPiAJc3RydWN0IHR0bV92YWxpZGF0ZV9idWZmZXIgdHY7DQo+IAlzdHJ1Y3Qg
d3dfYWNxdWlyZV9jdHggdGlja2V0Ow0KPiAJc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmE7DQo+
IC0JaW50IHI7DQo+ICsJbG9uZyByOw0KPiANCj4gCUlOSVRfTElTVF9IRUFEKCZsaXN0KTsNCj4g
CUlOSVRfTElTVF9IRUFEKCZkdXBsaWNhdGVzKTsNCj4gDQo+IAl0di5ibyA9ICZiby0+dGJvOw0K
PiAtCXR2Lm51bV9zaGFyZWQgPSAxOw0KPiArCXR2Lm51bV9zaGFyZWQgPSAyOw0KPiAJbGlzdF9h
ZGQoJnR2LmhlYWQsICZsaXN0KTsNCj4gDQo+IAlhbWRncHVfdm1fZ2V0X3BkX2JvKHZtLCAmbGlz
dCwgJnZtX3BkKTsNCj4gQEAgLTE3OCwyOCArMTc5LDMyIEBAIHZvaWQgYW1kZ3B1X2dlbV9vYmpl
Y3RfY2xvc2Uoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosDQo+IAlyID0gdHRtX2V1X3Jlc2Vy
dmVfYnVmZmVycygmdGlja2V0LCAmbGlzdCwgZmFsc2UsICZkdXBsaWNhdGVzKTsNCj4gCWlmIChy
KSB7DQo+IAkJZGV2X2VycihhZGV2LT5kZXYsICJsZWFraW5nIGJvIHZhIGJlY2F1c2UgIg0KPiAt
CQkJIndlIGZhaWwgdG8gcmVzZXJ2ZSBibyAoJWQpXG4iLCByKTsNCj4gKwkJCSJ3ZSBmYWlsIHRv
IHJlc2VydmUgYm8gKCVsZClcbiIsIHIpOw0KPiAJCXJldHVybjsNCj4gCX0NCj4gCWJvX3ZhID0g
YW1kZ3B1X3ZtX2JvX2ZpbmQodm0sIGJvKTsNCj4gLQlpZiAoYm9fdmEgJiYgLS1ib192YS0+cmVm
X2NvdW50ID09IDApIHsNCj4gLQkJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7DQo+ICsJ
aWYgKCFib192YSB8fCAtLWJvX3ZhLT5yZWZfY291bnQpDQo+ICsJCWdvdG8gb3V0X3VubG9jazsN
Cj4gDQo+IC0JCWlmIChhbWRncHVfdm1fcmVhZHkodm0pKSB7DQo+IC0JCQlzdHJ1Y3QgZG1hX2Zl
bmNlICpmZW5jZSA9IE5VTEw7DQo+ICsJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7DQo+
ICsJaWYgKCFhbWRncHVfdm1fcmVhZHkodm0pKQ0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+IA0K
PiAtCQkJciA9IGFtZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsNCj4gLQkJ
CWlmICh1bmxpa2VseShyKSkgew0KPiAtCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRv
IGNsZWFyIHBhZ2UgIg0KPiAtCQkJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxu
Iiwgcik7DQo+IC0JCQl9DQo+ICsJZmVuY2UgPSBkbWFfcmVzdl9nZXRfZXhjbChiby0+dGJvLmJh
c2UucmVzdik7DQo+ICsJYW1kZ3B1X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7DQo+ICsJZmVu
Y2UgPSBOVUxMOw0KPiANCj4gLQkJCWlmIChmZW5jZSkgew0KPiAtCQkJCWFtZGdwdV9ib19mZW5j
ZShibywgZmVuY2UsIHRydWUpOw0KPiAtCQkJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiAtCQkJ
fQ0KPiAtCQl9DQo+IC0JfQ0KPiArCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0s
ICZmZW5jZSk7DQo+ICsJaWYgKHIgfHwgIWZlbmNlKQ0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+
ICsNCj4gKwlhbWRncHVfYm9fZmVuY2UoYm8sIGZlbmNlLCB0cnVlKTsNCj4gKwlkbWFfZmVuY2Vf
cHV0KGZlbmNlKTsNCj4gKw0KPiArb3V0X3VubG9jazoNCj4gKwlpZiAodW5saWtlbHkociA8IDAp
KQ0KPiArCQlkZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICINCj4gKwkJ
CSJ0YWJsZXMgb24gR0VNIG9iamVjdCBjbG9zZSAoJWxkKVxuIiwgcik7DQo+IAl0dG1fZXVfYmFj
a29mZl9yZXNlcnZhdGlvbigmdGlja2V0LCAmbGlzdCk7DQo+IH0NCj4gDQo+IC0tIA0KPiAyLjE3
LjENCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
