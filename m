Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A65CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7987D20650
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7987D20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412A36EB08;
	Wed, 23 Oct 2019 15:27:24 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790052.outbound.protection.outlook.com [40.107.79.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5746EB08
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 15:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsuRgMfHAJJiwPSctYjzo17RgxsZHJRZo+vF2pHlZhyf5wJdCTmlOrXCrSHQ2lRoUY3wbdLycGyu/BidI/jAFppyOwZKxjq58Y5Jr7jliUjNyY65GtnCg8jyJQputaWxcR7xX6m89Vc5o19ZoHCwjwNIIn5/zkDIRW12A1eGyIWhAnsdC9oJTbjivElKzOWm4uU7xFl4dZtLsLt+/VVnI9p0SBSQ7TirToA0UdBAF8byTYNcaICKoPi8u5ZaXK/uETzb4DKVhpHMs9iDEKEqxuh5Q1MZPBcSP/pULRg4GHNXa7h+cF0315i12j7u054mPbfOdksCxiPeikh2AH8uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v42AehYLAlSOSiVmfws12cIzbqcIDAJwqKp0qRa+Ko=;
 b=L50y5Z7bjVmLybPYkpPCVfPkS7M0RQkHbcUjnwdB1GdmID0F8mL3C8WgXCtzI65XJxT74t8zKkcmwW5H22u6hjjFitJXr+Tf0aR+vYksd1g/uWJb920p/WiRz4uLjh1uk+jMe+BO4lSwct7vVHzplrv8D2l0aHIQBdPl8LKzpb9GAGQDfFaO6Wz2or23KE30HjVVpZJt8mtrGSzcNILc0+TqC+rvl7jdD+b1dP41OUa8IUnDawTj3jvk6+NwMEENZnjtqVoiEgpSzwcEFKi+2sQ3uVZkv5+ruKKPTLuM1SUuIkW66PTmf/eJSi6vsXeqpN1gX0fARhMxU0h3XULOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2517.namprd12.prod.outlook.com (52.132.208.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 15:27:21 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c516:21e2:1024:c2f1]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c516:21e2:1024:c2f1%4]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 15:27:21 +0000
From: Nirmoy <nirmodas@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Nirmoy Das
 <nirmoy.aiemd@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_gfx_kiq_free_ring
Thread-Topic: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_gfx_kiq_free_ring
Thread-Index: AQHVia8lsG4uyERFzEaAeJTa/EQdQKdoV9aAgAABfoA=
Date: Wed, 23 Oct 2019 15:27:21 +0000
Message-ID: <a177beed-e7a4-df24-e3f2-97c86b9d3a88@amd.com>
References: <20191023143517.57753-1-nirmoy.das@amd.com>
 <b1569003-1b14-d71d-32b8-3695677189ac@amd.com>
In-Reply-To: <b1569003-1b14-d71d-32b8-3695677189ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0034.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::47) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2003:c5:8f27:de00:c969:d2a3:58fe:c8db]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c08e8611-753a-479c-4a30-08d757cd7f3f
x-ms-traffictypediagnostic: DM5PR12MB2517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2517FABF04812EB827D9FB7E8B6B0@DM5PR12MB2517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(6436002)(66556008)(66946007)(64756008)(66446008)(5660300002)(31686004)(7736002)(6486002)(478600001)(66476007)(25786009)(229853002)(6246003)(6636002)(71190400001)(71200400001)(256004)(6116002)(305945005)(31696002)(2906002)(54906003)(6506007)(316002)(386003)(46003)(186003)(486006)(110136005)(6512007)(52116002)(76176011)(102836004)(4326008)(8676002)(36756003)(99286004)(81156014)(81166006)(476003)(2616005)(11346002)(8936002)(446003)(14454004)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2517;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgP5YCuWOGMevmHlWuN4yxLPX83NtMVD5D0levjPzDRmYYNc+lI0ix3UUKxMfGPw/PNxL+IIu1G6z7gzQ6uW91zJ+cy7z6QWX5ithDEwS8GBx+BuyhCxlIhwsIiuOMFz3kFMrAmGDBwLaY7J+HGGr5XpWb9GvbaoGHT6zyA9JTRSxyBP/6TgRX0yYL/6YppY2uZac1HBZjwP30zGj5NMGsD0ImceKDy9/tv3lX4KUEI9JahA0v2+JrM+pxK7n1UFgK4w0t58Dk65BHNdZsl1H/g0a55gskWcNj81trJWTZs4qbLUPV10X2UgRAV4wMqYzElWfUL+BzpEjNBvnnr0lmzakii1cwlsGcFcH7UmXEdbkeZhEv0vXgzUz0qOD/8QewpkKCag6/2/6BjeDQXJlf85HyeilnUz0lP+Xi3740SItfBBpwe1XVOiFdjlYxw0
Content-ID: <23123D15D765D849BD7D9DFCBBE98B72@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08e8611-753a-479c-4a30-08d757cd7f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 15:27:21.2290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFQQjctn8PqNKPt8BJ5vlsF9eg++zxeBbQ2VeIpwkxznW13p2LZnSmwC+B/6Zj1LZ+bHtcWVarOa80SkhX3MWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2517
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v42AehYLAlSOSiVmfws12cIzbqcIDAJwqKp0qRa+Ko=;
 b=Cp6Zbfz4y0f8FM1gMaWVmGExAs3JuKXka9acFcjuYZS3xMws6zzlAHXsx7BvpPxommFMB33NiztL42ptdDK9R1L2u0m2y6hEQtRebp4qFH4IC9xOMzsVZPU1AGYFLG3snIQZrnj8qj21vClEWq/lxLb6VwiKs43KIvDbVMktU6A=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023152721.4CV7tvn2hQVAKt7vcy3lH1hxzT9OYD5BOGtAf56bomY@z>

VGhhbmtzIFVwZGF0ZWQgYW5kIHB1c2hlZCB0b8KgIGJyYWhtYSBIRUFEOnJlZnMvZm9yL2FtZC1z
dGFnaW5nLWRybS1uZXh0DQoNCk9uIDEwLzIzLzE5IDU6MjEgUE0sIEtvZW5pZywgQ2hyaXN0aWFu
IHdyb3RlOg0KPiBNYXliZSBzYXkgcGFyYW1ldGVyIGluc3RlYWQgb2YgdmFyaWFibGUgaW4gdGhl
IHN1YmplY3QuDQo+DQo+IEFtIDIzLjEwLjE5IHVtIDE2OjM1IHNjaHJpZWIgTmlybW95IERhczoN
Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4NCj4gQXBh
cnQgZnJvbSB0aGF0IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+DQo+PiAtLS0NCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguYyB8IDMgKy0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2Z4LmggfCAzICstLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMgIHwgMiArLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAu
YyAgIHwgMiArLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAg
IHwgMiArLQ0KPj4gICAgNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPj4g
aW5kZXggMDY5NTE1ZjU3YzJhLi5jOWQxZmFkYTYxODggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPj4gQEAgLTMxOSw4ICszMTksNyBAQCBpbnQgYW1k
Z3B1X2dmeF9raXFfaW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAg
CXJldHVybiByOw0KPj4gICAgfQ0KPj4gICAgDQo+PiAtdm9pZCBhbWRncHVfZ2Z4X2tpcV9mcmVl
X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPj4gLQkJCSAgICAgIHN0cnVjdCBhbWRn
cHVfaXJxX3NyYyAqaXJxKQ0KPj4gK3ZvaWQgYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZykNCj4+ICAgIHsNCj4+ICAgIAlhbWRncHVfZGV2aWNlX3diX2Zy
ZWUocmluZy0+YWRldiwgcmluZy0+YWRldi0+dmlydC5yZWdfdmFsX29mZnMpOw0KPj4gICAgCWFt
ZGdwdV9yaW5nX2ZpbmkocmluZyk7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dmeC5oDQo+PiBpbmRleCAzNWVmZjllNmNlMTYuLjQ1OWFhOTA1OTU0MiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+PiBAQCAtMzMwLDggKzMzMCw3
IEBAIGludCBhbWRncHVfZ2Z4X2tpcV9pbml0X3Jpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQo+PiAgICAJCQkgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4+ICAgIAkJCSAg
ICAgc3RydWN0IGFtZGdwdV9pcnFfc3JjICppcnEpOw0KPj4gICAgDQo+PiAtdm9pZCBhbWRncHVf
Z2Z4X2tpcV9mcmVlX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPj4gLQkJCSAgICAg
IHN0cnVjdCBhbWRncHVfaXJxX3NyYyAqaXJxKTsNCj4+ICt2b2lkIGFtZGdwdV9nZnhfa2lxX2Zy
ZWVfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOw0KPj4gICAgDQo+PiAgICB2b2lkIGFt
ZGdwdV9nZnhfa2lxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPj4gICAgaW50
IGFtZGdwdV9nZnhfa2lxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPj4gaW5kZXggOGZjYTZhYjVmYThmLi5h
YzQzYjFhZjY5ZTMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMNCj4+IEBAIC0xNDQzLDcgKzE0NDMsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9zd19maW5p
KHZvaWQgKmhhbmRsZSkNCj4+ICAgIAkJYW1kZ3B1X3JpbmdfZmluaSgmYWRldi0+Z2Z4LmNvbXB1
dGVfcmluZ1tpXSk7DQo+PiAgICANCj4+ICAgIAlhbWRncHVfZ2Z4X21xZF9zd19maW5pKGFkZXYp
Ow0KPj4gLQlhbWRncHVfZ2Z4X2tpcV9mcmVlX3JpbmcoJmFkZXYtPmdmeC5raXEucmluZywgJmFk
ZXYtPmdmeC5raXEuaXJxKTsNCj4+ICsJYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKCZhZGV2LT5n
Zngua2lxLnJpbmcpOw0KPj4gICAgCWFtZGdwdV9nZnhfa2lxX2ZpbmkoYWRldik7DQo+PiAgICAN
Cj4+ICAgIAlnZnhfdjEwXzBfcGZwX2ZpbmkoYWRldik7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMNCj4+IGluZGV4IGE3ZmUwZWEyNGQxZi4uZTRjNjQ1ZGE0ZTI4IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPj4gQEAgLTIxMDMsNyAr
MjEwMyw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfc3dfZmluaSh2b2lkICpoYW5kbGUpDQo+PiAg
ICAJCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0pOw0KPj4gICAg
DQo+PiAgICAJYW1kZ3B1X2dmeF9tcWRfc3dfZmluaShhZGV2KTsNCj4+IC0JYW1kZ3B1X2dmeF9r
aXFfZnJlZV9yaW5nKCZhZGV2LT5nZngua2lxLnJpbmcsICZhZGV2LT5nZngua2lxLmlycSk7DQo+
PiArCWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nKTsNCj4+ICAg
IAlhbWRncHVfZ2Z4X2tpcV9maW5pKGFkZXYpOw0KPj4gICAgDQo+PiAgICAJZ2Z4X3Y4XzBfbWVj
X2ZpbmkoYWRldik7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4+IGlu
ZGV4IGRkMzQ1ZmNlZGI5Ny4uOWZlOTVlNzY5M2Q1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4gQEAgLTIxNTMsNyArMjE1Myw3IEBAIHN0YXRpYyBpbnQg
Z2Z4X3Y5XzBfc3dfZmluaSh2b2lkICpoYW5kbGUpDQo+PiAgICAJCWFtZGdwdV9yaW5nX2Zpbmko
JmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0pOw0KPj4gICAgDQo+PiAgICAJYW1kZ3B1X2dmeF9t
cWRfc3dfZmluaShhZGV2KTsNCj4+IC0JYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKCZhZGV2LT5n
Zngua2lxLnJpbmcsICZhZGV2LT5nZngua2lxLmlycSk7DQo+PiArCWFtZGdwdV9nZnhfa2lxX2Zy
ZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nKTsNCj4+ICAgIAlhbWRncHVfZ2Z4X2tpcV9maW5p
KGFkZXYpOw0KPj4gICAgDQo+PiAgICAJZ2Z4X3Y5XzBfbWVjX2ZpbmkoYWRldik7DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
