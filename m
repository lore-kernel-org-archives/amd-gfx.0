Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39890C5ACD6
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 08:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10E92076C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 08:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CwZTqLEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10E92076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9596E879;
	Wed, 18 Mar 2020 08:01:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988E56E879
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 08:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7X2vPseE7TLWExlUKt6CMd05JaQKersC68s52vV2BPlIwoU8PVXIMzWJCTkIObvK8rlnnIziT+HBzy37SDMdg+B0oQyfBTBO1XHfeNI/khVD7jzxrFO2jq+VhxPlTAXSwLnztCOTgnX39YUq4rIvl+uBFAVLMbpOopGanBIoPOzAk/lzkgkeHQFV4Ay0Dlr/3EeBTzC5iwq5tSStPOGnIT0m6a+l5lGzZu2zS3gCe22Ahl9dB10LSIsQpw929DzInNvZlxmU6m3l6QiupMUlrc7CN7NsvpHYiDtM2I+VvOYZy9MgLCXXIPPnO97neNNKtcL9MzbY+zozFhSKpJtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2WwmjoQNufr33PnAxHERgSEMWovWdMoggUgRgU0opc=;
 b=JIrPJcugPKQn54mHlWvllplzA3ElG757zsHGc5JayRplEpH++Y5l+Nz2m4+y9/gHvY3aFB0s/8VODJkGEciSy1/9bMAa5frjnnDxtK3yPiNFay4uZqeubx7QCUz9e+UH3w4evnwBDhJ/eG9hLnhbPBDp3VMBtsq3+mRyPeLpCit0uyFpq/ccnDVpPM2zjkn1y2ZZqwS5Ea7kARwCmwg3PJtrTWPL32aqvv0MMvk7xnsfElyFUbFy5U0IpwPcixmuHk51Wzq28cEBTjE1v6WkPHrZCzGcMfG+FVYz3+Y1RbRpOBwU7ChLUPZ/QW0/EBAPTXIkN99GHl/jK09u5h/2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2WwmjoQNufr33PnAxHERgSEMWovWdMoggUgRgU0opc=;
 b=CwZTqLEvKGkcVyOjHzhe8ZD08vZewq2vcynTJCZ+PqKmUUT2CPJN7L2Bcx3vm70q5hqu/bounMcZkiLxlEzHB7ArLwSN4Kgnj9l+pRVo25zl+vH8nm9YXBleLpGPaGnKV51NHCHgmQllJdm2o0hSK6Qg7XdEnEvmyoOWCu1ila4=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Wed, 18 Mar
 2020 08:00:58 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.023; Wed, 18 Mar 2020
 08:00:58 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
Thread-Topic: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close v2
Thread-Index: AQHV+5X3ADP5utKBi0OFbus/9mmiFahN/N2AgAACrIA=
Date: Wed, 18 Mar 2020 08:00:58 +0000
Message-ID: <CD744AEA-A602-4E04-B754-CF21019A65D5@amd.com>
References: <20200316132235.82022-1-christian.koenig@amd.com>
 <9e4b394a-59e3-cae7-1dd2-63c0a692cefb@gmail.com>
In-Reply-To: <9e4b394a-59e3-cae7-1dd2-63c0a692cefb@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1fa76b5-48c9-4a74-8db5-08d7cb127e4f
x-ms-traffictypediagnostic: SN6PR12MB2766:|SN6PR12MB2766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2766B8047633FA32D8A068B587F70@SN6PR12MB2766.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(76116006)(91956017)(66476007)(64756008)(66446008)(6486002)(66556008)(66946007)(478600001)(6512007)(316002)(81166006)(81156014)(8676002)(36756003)(6506007)(5660300002)(54906003)(86362001)(8936002)(66574012)(4326008)(2906002)(2616005)(71200400001)(6916009)(33656002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2766;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 97K2q+/PqGAq12poCJ35Ru7zxxwd+d2LZHqtQUqFMAmQs5kDltD+NB84UA6og1X5uTDqOFUSLfX6DVe+mx1+pAY9uqECowwN8s7wDT5vtXBXPoLgoxft/YQhImqbyw3G8UVWf8QgNKLiXd9v1YRBFWF7Gc2KEPOGNLrg9e/4kSJKvgxUlG/wyCKTvOQ17L37oKl/XcO7OzbnCHMNmIliBOAY/N8UzS7C5xqyzqQp+Zh7zHdmMfH28wo/N/9gvRS3/2x1OjI3U1bDyRB0cV3biRogc5e4usyzw2umr1J3ZbVo5z0EqHW9/T94Q7JFNr3sIUtrw4TWzL4TWWqixqCr6af1G6h6IJDmetwF2buXKxv3GMzMW0JT4CAktAXEoxvcjyQ7iLecmnzKi96EOQCT3ypvXB+qzgWkFuRKnJ8xSiPn6b0seRm968b00JxiLQBg
x-ms-exchange-antispam-messagedata: fpa5XgYiRA0ABUPk5lRjF445DDNG/i0jxYPikmfNa5s96FTKVLqxdS0NGpPDLapxkTVTgEpyIbGfz+hDbY446+meKTCSFSO5YzShrgZjMIQb8R5bcFtrNPnhMYSqPu7e2A+pXXScN2bpoEMnzN5L4g==
Content-ID: <ACA3D04CAED13D4FA472978BA89A382B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fa76b5-48c9-4a74-8db5-08d7cb127e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 08:00:58.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C39MaFsf7zpjinoby+YfkwdA0qOq1Reer0XzTnRTcJMpKKvoNtcwEjHX0uxVUChS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB3b25kZXIgaWYgaXQgcmVhbGx5IGZpeCBhbnl0aGluZyB3aXRoIHN1Y2ggc21hbGwgZGVsYXku
IGJ1dCBpdCBzaG91bGQgYmUgbm8gaGFybSBhbnl3YXkuDQoNClJldmlld2VkLWJ5OiB4aW5odWkg
cGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQoNCj4gMjAyMOW5tDPmnIgxOOaXpSAxNTo1Me+8jENo
cmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiDlhpnpgZPv
vJoNCj4gDQo+IFBpbmc/IFhpbmh1aSBjYW4gSSBnZXQgYW4gcmIgZm9yIHRoaXM/DQo+IA0KPiBU
aGFua3MsDQo+IENocmlzdGlhbi4NCj4gDQo+IEFtIDE2LjAzLjIwIHVtIDE0OjIyIHNjaHJpZWIg
Q2hyaXN0aWFuIEvDtm5pZzoNCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgY2FuJ3QgYWRkIHRo
ZSBjbGVhciBmZW5jZSB0byB0aGUgQk8NCj4+IHdoZW4gdGhlcmUgaXMgYW4gZXhjbHVzaXZlIGZl
bmNlIG9uIGl0IHNpbmNlIHdlIGNhbid0DQo+PiBndWFyYW50ZWUgdGhlIHRoZSBjbGVhciBmZW5j
ZSB3aWxsIGNvbXBsZXRlIGFmdGVyIHRoZQ0KPj4gZXhjbHVzaXZlIG9uZS4NCj4+IA0KPj4gVG8g
Zml4IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0aW9uIGFuZCB3YWl0IGZvciBhbnkgcG90ZW50aWFs
DQo+PiBleGNsdXNpdmUgZmVuY2Ugd2l0aCBhIHNtYWxsIHRpbWVvdXQgYmVmb3JlIGFkZGluZyB0
aGUNCj4+IHNoYXJlZCBjbGVhciBmZW5jZS4NCj4+IA0KPj4gdjI6IGZpeCB3YXJuaW5nDQo+PiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
YyB8IDQzICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjYg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4+IGluZGV4IDViZWM2NmU2YjFmOC4uNDljOTFkYWMzNWEw
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5j
DQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4+IEBA
IC0xNjEsMTAgKzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqb2JqLA0KPj4gICAgCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSB2
bV9wZDsNCj4+ICAJc3RydWN0IGxpc3RfaGVhZCBsaXN0LCBkdXBsaWNhdGVzOw0KPj4gKwlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7DQo+PiAgCXN0cnVjdCB0dG1fdmFsaWRhdGVfYnVm
ZmVyIHR2Ow0KPj4gIAlzdHJ1Y3Qgd3dfYWNxdWlyZV9jdHggdGlja2V0Ow0KPj4gIAlzdHJ1Y3Qg
YW1kZ3B1X2JvX3ZhICpib192YTsNCj4+IC0JaW50IHI7DQo+PiArCWxvbmcgcjsNCj4+ICAgIAlJ
TklUX0xJU1RfSEVBRCgmbGlzdCk7DQo+PiAgCUlOSVRfTElTVF9IRUFEKCZkdXBsaWNhdGVzKTsN
Cj4+IEBAIC0xNzgsMjggKzE3OSwzNiBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0
cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLA0KPj4gIAlyID0gdHRtX2V1X3Jlc2VydmVfYnVmZmVy
cygmdGlja2V0LCAmbGlzdCwgZmFsc2UsICZkdXBsaWNhdGVzKTsNCj4+ICAJaWYgKHIpIHsNCj4+
ICAJCWRldl9lcnIoYWRldi0+ZGV2LCAibGVha2luZyBibyB2YSBiZWNhdXNlICINCj4+IC0JCQki
d2UgZmFpbCB0byByZXNlcnZlIGJvICglZClcbiIsIHIpOw0KPj4gKwkJCSJ3ZSBmYWlsIHRvIHJl
c2VydmUgYm8gKCVsZClcbiIsIHIpOw0KPj4gIAkJcmV0dXJuOw0KPj4gIAl9DQo+PiAgCWJvX3Zh
ID0gYW1kZ3B1X3ZtX2JvX2ZpbmQodm0sIGJvKTsNCj4+IC0JaWYgKGJvX3ZhICYmIC0tYm9fdmEt
PnJlZl9jb3VudCA9PSAwKSB7DQo+PiAtCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsN
Cj4+ICsJaWYgKCFib192YSB8fCAtLWJvX3ZhLT5yZWZfY291bnQpDQo+PiArCQlnb3RvIG91dF91
bmxvY2s7DQo+PiAgLQkJaWYgKGFtZGdwdV92bV9yZWFkeSh2bSkpIHsNCj4+IC0JCQlzdHJ1Y3Qg
ZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7DQo+PiArCWFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9f
dmEpOw0KPj4gKwlpZiAoIWFtZGdwdV92bV9yZWFkeSh2bSkpDQo+PiArCQlnb3RvIG91dF91bmxv
Y2s7DQo+PiAgLQkJCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7
DQo+PiAtCQkJaWYgKHVubGlrZWx5KHIpKSB7DQo+PiAtCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAi
ZmFpbGVkIHRvIGNsZWFyIHBhZ2UgIg0KPj4gLQkJCQkJInRhYmxlcyBvbiBHRU0gb2JqZWN0IGNs
b3NlICglZClcbiIsIHIpOw0KPj4gLQkJCX0NCj4+ICAtCQkJaWYgKGZlbmNlKSB7DQo+PiAtCQkJ
CWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOw0KPj4gLQkJCQlkbWFfZmVuY2VfcHV0
KGZlbmNlKTsNCj4+IC0JCQl9DQo+PiAtCQl9DQo+PiAtCX0NCj4+ICsJciA9IGFtZGdwdV92bV9j
bGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsNCj4+ICsJaWYgKHIgfHwgIWZlbmNlKQ0KPj4g
KwkJZ290byBvdXRfdW5sb2NrOw0KPj4gKw0KPj4gKwlyID0gZG1hX3Jlc3Zfd2FpdF90aW1lb3V0
X3JjdShiby0+dGJvLmJhc2UucmVzdiwgZmFsc2UsIGZhbHNlLA0KPj4gKwkJCQkgICAgICBtc2Vj
c190b19qaWZmaWVzKDEwKSk7DQo+PiArCWlmIChyID09IDApDQo+PiArCQlyID0gLUVUSU1FRE9V
VDsNCj4+ICsJaWYgKHIpDQo+PiArCQlnb3RvIG91dF91bmxvY2s7DQo+PiArDQo+PiArCWFtZGdw
dV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOw0KPj4gKwlkbWFfZmVuY2VfcHV0KGZlbmNlKTsN
Cj4+ICsNCj4+ICtvdXRfdW5sb2NrOg0KPj4gKwlpZiAodW5saWtlbHkociA8IDApKQ0KPj4gKwkJ
ZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFnZSAiDQo+PiArCQkJInRhYmxl
cyBvbiBHRU0gb2JqZWN0IGNsb3NlICglbGQpXG4iLCByKTsNCj4+ICAJdHRtX2V1X2JhY2tvZmZf
cmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOw0KPj4gIH0NCj4+ICANCj4gDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
