Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C91CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C957B20874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C957B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE7A6EA62;
	Wed, 30 Oct 2019 15:06:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A9F6EA62
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 15:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxp/+ZaIBzGCX7FfG6TMelyNEYZDxG48NcCYrcVYTWHWxIfTdYKgdeFuLEMfTNHFJjoXk+2refp0UIEpBQM+pK+bShddWZsHVhbDv97apzdueDGrCs0noFzjQbHSPCS2645LscvNB0ZwTcxlgsiu7ekhrZGKfXf9iFAwd3mhZdbG1vNzrfbmXynvB0kW+n1BtT27hB7+V4Tk+m6pmw+GZHe+M9qSkOiSVTVfLC3SHEw/r3ooh4zQcIyPJzElmjtOxJAxBCPl7DUyxj1vuaH8HWH7Y10XiCkemwshFyZTo5vVNq9aPF0zdtcAPxIFR/LnWAHtGSADUv6VvnBeKG6n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPvZoUqstF40TMe2DXT/hYPzo2U5BdQPNcQznZ4+qZc=;
 b=SyC6pQVcHOGSAM1P0Grgm52r+JQxZNHC01fQ5iYd1X/79126wr/gU6ej9H0Xh/yL3nJH5bqlmifdg3GyAC0wTwDJZk7uVmNwoyTcXLcRqrATB8MN9GZgFtRhBm2mvqFy4fxSdcSdRa0UtqoQ8v6ez/H/06DxEWRYH8H6tWXBXx/rOZ58KZkLHa3gj16V380dT5vAx6glxnRWeqfNIhMq5yH+POp3vKqM/do2K2xF4EIaysFFXz61c3lQ57izYrKTQDOBEMTOpdRBSyyNPhzl5NabnSrAihEqYOTCcP5dGFZdrQrVZO1LrBqoLiHYVAchQ3+fS9ZOeDKXKYEF7kDSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1837.namprd12.prod.outlook.com (10.175.55.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 15:06:24 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 15:06:24 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "S, Shirish"
 <Shirish.S@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Topic: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Index: AQHVjwJaqXgdXzZy206qemuwuHylYady+S4AgABP+wA=
Date: Wed, 30 Oct 2019 15:06:24 +0000
Message-ID: <4dcbd84e-a44d-fe79-d6b7-986e86d507d4@amd.com>
References: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
 <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
In-Reply-To: <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64074cbf-7b8d-46e6-89cd-08d75d4abb1e
x-ms-traffictypediagnostic: MWHPR12MB1837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1837A683D51B45AD2F41BA2DEA600@MWHPR12MB1837.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(6506007)(5660300002)(6246003)(86362001)(31696002)(3846002)(186003)(6116002)(14454004)(71200400001)(71190400001)(386003)(4326008)(102836004)(53546011)(66066001)(26005)(6636002)(478600001)(6512007)(52116002)(66446008)(64756008)(66556008)(6436002)(66946007)(36756003)(76176011)(316002)(81156014)(229853002)(81166006)(476003)(256004)(110136005)(305945005)(66574012)(2906002)(8676002)(7736002)(486006)(11346002)(446003)(31686004)(99286004)(25786009)(8936002)(2616005)(14444005)(6486002)(66476007)(192303002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1837;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKEP8NfZs6Y4fT3khp5OBmjv7ajwrlIH/NTLkK5ZE2i8dK00SkXHEOq8Vt7hWmU+vVeQ9RoQ53nJQ9vXtyv5/YFYiP8CvjCljIGcOlRMysmUYEagCHDQVD2BaD5VeXatNVGIS6lwTnLtq2IVnx01ZBDCIVXcKgR0NK6a45Yp9e+I8GSm1W7wBtDIWuK8Nh3MB6rd360AjiwUlV0QkPU9WSa+/6Kx+88zXGVlQinjm8MRIl0c4VwQM0wZ7RxYUyURSFG08Cy5eouDg+ezopmI7UbD3edniVTqAtsOq40+hPhnqJMcXyazbi7XSnljzrZBRqJLB0WiGWo9Vjb4KejB0b6Lkgj4lVGo0bH/ZtiVTN/rCJhrvy+DlxTQITGNCYnjs7Z6VggOdY/FDsgWVV6+Fyl01WcWSAJxZZNsOY2lU4pgmJaqmPz43qAkQdb2j/kY
Content-ID: <6713154F9D62E84E83669C94FA6C2E34@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64074cbf-7b8d-46e6-89cd-08d75d4abb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 15:06:24.7097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwpF196nj6LDN9+h0LT/56VelmJXKoCG8mAtG5w2U+JRPYHFz2pv9/ZbtveeOj7bcsDkz0Ti0PStuoGat83LbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1837
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPvZoUqstF40TMe2DXT/hYPzo2U5BdQPNcQznZ4+qZc=;
 b=3nkMcClr2dgjCS8L8leVrR7T+rsGFWybncGtxUtlYRYtFS+/Kg9XBt7XWhYgcsVltZqJdVCXnVOkvSRW9RHAokp/P5FDYgn8iNY//zvNFV8Z1BeEWEXuDUffltXFpgymdTEddcH8HKru6FsQibt+XS8u2KplXPs4Ab9YqafPha8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Message-ID: <20191030150624.Q842ZSgEAvhda9hQOo1KT1VzamDCb77EeG2pNHDmU28@z>

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
Pg0KDQpBbmRyZXkNCg0KT24gMTAvMzAvMTkgNjoyMCBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3Jv
dGU6DQo+IEFtIDMwLjEwLjE5IHVtIDEwOjEzIHNjaHJpZWIgUywgU2hpcmlzaDoNCj4+IFtXaHld
DQo+Pg0KPj4gZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbSBkcm1fc2NoZWRfZW50
aXR5X2ZpbmkNCj4+IHdoaWxlIEdQVSByZXNldCBpcyBpbiBwcm9ncmVzcyBkZWZlYXRzIGFsbCB0
aGUgcHVycG9zZSBvZg0KPj4gZHJtX3NjaGVkX3N0b3AtPmt0aHJlYWRfcGFyay4NCj4+IElmIGRy
bV9zY2hlZF9lbnRpdHlfZmluaS0+a3RocmVhZF91bnBhcmsoKSBoYXBwZW5zIEFGVEVSDQo+PiBk
cm1fc2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVy
DQo+PiAodGhpcmQpIHRocmVhZCB0byBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdp
bGwgYmUNCj4+IHBpY2tlZCB1cCBieSB0aGUgdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCBhbmQg
dHJ5IHRvIHN1Ym1pdA0KPj4gdG8gSFcgYnV0IGZhaWwgYmVjYXVzZSB0aGUgSFcgcmluZyBpcyBk
ZWFjdGl2YXRlZC4NCj4+DQo+PiBbSG93XQ0KPj4gZ3JhYiB0aGUgcmVzZXQgbG9jayBiZWZvcmUg
Y2FsbGluZyBkcm1fc2NoZWRfZW50aXR5X2ZpbmkoKQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNo
aXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gUGF0Y2ggaXRzZWxmIGlzIFJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+DQo+
IERvZXMgdGhhdCBhbHNvIGZpeCB0aGUgcHJvYmxlbXMgeW91IGhhdmUgYmVlbiBzZWVpbmc/DQo+
DQo+IFRoYW5rcywNCj4gQ2hyaXN0aWFuLg0KPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCA1ICsrKystDQo+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4gaW5kZXggNjYxNGQ4YS4uMmNkYWYzYiAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jDQo+PiBAQCAtNjA0LDgg
KzYwNCwxMSBAQCB2b2lkIGFtZGdwdV9jdHhfbWdyX2VudGl0eV9maW5pKHN0cnVjdCBhbWRncHVf
Y3R4X21nciAqbWdyKQ0KPj4gICAgCQkJY29udGludWU7DQo+PiAgICAJCX0NCj4+ICAgIA0KPj4g
LQkJZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsgaSsrKQ0KPj4gKwkJZm9yIChpID0gMDsg
aSA8IG51bV9lbnRpdGllczsgaSsrKSB7DQo+PiArCQkJbXV0ZXhfbG9jaygmY3R4LT5hZGV2LT5s
b2NrX3Jlc2V0KTsNCj4+ICAgIAkJCWRybV9zY2hlZF9lbnRpdHlfZmluaSgmY3R4LT5lbnRpdGll
c1swXVtpXS5lbnRpdHkpOw0KPj4gKwkJCW11dGV4X3VubG9jaygmY3R4LT5hZGV2LT5sb2NrX3Jl
c2V0KTsNCj4+ICsJCX0NCj4+ICAgIAl9DQo+PiAgICB9DQo+PiAgICANCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
