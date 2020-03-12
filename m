Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4291C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953F9206E7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OErCF13k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953F9206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6231C6EAB8;
	Thu, 12 Mar 2020 13:29:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49716EAB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 13:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3jT3mls25HVl9loRuaZCgzDcuV7lic3G7Xd5iWK7QPeu2I77KQjwccflK/soLUGnif0XsdJvivQbrKL0OIFi0dPvH7lyEFvz2pIs4JG5XjHDBGPrn7mNu1Tcd1CKCksssAsXICuIxGA5Sjco0Cp5+QHLKUPrhbEXEjaX7uqfKhXa7dgnVNq7Js0os/1B3DsD/sALcUO4oF6hjQrv8raM2KPE4ZDLTTQsi6XdJCQYejVTwvLT0uwcbkGIDdEQF/iuz+47hbM4KcEvAqakI+dn2GuLVgsRslKx7+nXJO4Zfxvuysmd8eP1lnJqF2NTfHB7bGZIbghm/uul+comaYXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucExssuy4q0A0OHaFPDc9k9kR/6wZdHPo3Jj2XFA3X8=;
 b=UFJL6LFjuqEf+X/F+2SMoBNr/bCQJUyhE3wnNxptz0FTwygmSQn2ZZ31TU9k34tbt1EiR+IoyGECI7bVvMiXfs4eXCDUbKwPec9hz3ECJj95QrDkstFauTZ8UvMgbGqmFgBo7+B62TTu3kun8CaVv880LtFIXQczr1AGD/ryHDuUbXxOP+rIZkbuVICDXQgKYytT9eZUcUP92LAj5RS4zYLPfnizLojnlLtUmXiLBfqh1uF5SO6uczfEtt7XrzYHyNVcvamUe1D1qKLraEgBJmnsTuzvEI8igFnV6pF4MNQhV3BgpnLag3bEJTiyncJObNGGg3k9jASKOE0PANQIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucExssuy4q0A0OHaFPDc9k9kR/6wZdHPo3Jj2XFA3X8=;
 b=OErCF13kcnw5PqkR+6D2KPgAx8slJlR5Ef9UfZ9bbtjlq6fmz+TxEoEhnaUPpznU3tBenWLg7WHWs1zQgt2PDzzR41rCSe7L2bEwIt6A4908H/AQ/Hs1GM5Ds3dEdI8LCvOCw7oMJCi1tbiFduQxVv6UJ7ENuR6VK6dn0MBGln8=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 13:29:43 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::3147:1ea1:8fcf:2cf4%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 13:29:43 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Topic: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
Thread-Index: AQHV+F8U5L7Se/dMEkmUhlnvgqMGdahE0m3QgAAWNICAAAoKMA==
Date: Thu, 12 Mar 2020 13:29:43 +0000
Message-ID: <MN2PR12MB39337488AD56095F5B5F4A6484FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <20200312111203.81500-1-christian.koenig@amd.com>
 <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
 <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
In-Reply-To: <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95057623-a30a-444d-953f-08d7c6896cbc
x-ms-traffictypediagnostic: MN2PR12MB3680:|MN2PR12MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3680994628A120EF3EF33F5E84FD0@MN2PR12MB3680.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(199004)(2906002)(86362001)(966005)(33656002)(45080400002)(478600001)(81166006)(81156014)(66946007)(66574012)(26005)(71200400001)(186003)(64756008)(76116006)(53546011)(6506007)(52536014)(66446008)(66556008)(66476007)(8676002)(9686003)(55016002)(110136005)(7696005)(8936002)(316002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3680;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 969geIkslsxgLhTzF3/uAAt7FigIpjR2VanXtpctdfLFjVYCTfrodyd5zd5yumoKn+DesGXr7KC0lEFKacnbHbAOLhGCZZGTPMmig7D3JpU+SETLE6VzWPkSiRc095zUX9cSqYB3149OMP5WBEV/8OKX46cmnng5K+lPjw4IzY/r4ZK32enI0jYdZQqLRvKDcOsYu99irSZhWrns229jZVgqZQifGt3ZBNCCR80nkwObuk7L2BIFQ6pu4fi1lz5RkrFUQn24/4FvXpA5KSjYKri8aJMjzVffy0wqD+XYj+XZ9Nr4eu2OFnmdSD6xvU2p2V1AiK9sZpbUH/J0i4ZBUfgMo0plf9wlCI+GNgrPYtN7PY2ut3bfJ183RxpHAVO4upy2ICjvOTF81+adDyQ9wWrK9cA3LN3JoEopU3sqXnVUUwGqOQUwXjYrWQch+MYN+b8vwe6QDdkSDfMGSI+jBrLb5Ky0bzGy0WB8KAyu5QE+nzdgGchiZpWdkaXyLtjD4TrjTnn0QdWj2w/t/P8cq/1n97Ozao6Y202Icsmo/lPhCPQglt4MdzHe9d0Qb7t9cEz/T16xxklJmgTafb1SFu1OCp+hFw1BPlqDSu+8fktGSn32h+2I42SRMBPh4i/h
x-ms-exchange-antispam-messagedata: uVig5D1skOAkQcph6OUJpY1ik1j9qhRA3q+nDz1EMYzaGV0frXdoIs4f55XMZcYHOZzESwrHsSUhQMTtNuXpC33/IofP1Ho0qQvyHbXHT/Nf7JCSIZ/8AkUloEpBB3pjcg9X8eNqFYlt9GLE7KuW9Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95057623-a30a-444d-953f-08d7c6896cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 13:29:43.2202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk6tt20yCWOoVfzjEMZlK8jZTyOkfDwSlthjnpuS+I03hoqsAoveDFwOaT/dynL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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

Pj4gTm93IHdoYXQgaGFwcGVucyBpcyB0aGF0IGNsZWFyaW5nIHRoZSBWTSBwYWdlIHRhYmxlcyBy
dW5zIGFzeW5jaHJvbm91c2x5IHRvIHRoZSBleGNsdXNpdmUgZmVuY2Ugd2hpY2ggbW92ZXMgdGhl
IGJ1ZmZlciBhcm91bmQuDQoNClRoZSBhbWRncHVfdm1fY2xlYXJfZnJlZWQgIGlzIGFscmVhZHkg
a2lja2VkIG9mZiBiZWZvcmUgeW91IHdhaXQgZm9yIHRoZSBleGNsdXNpdmUgZmVuY2Ugc2lnbmFs
ZWQsICB3aHkgeW91IGNhbiBhdm9pZCBjbGVhcmluZyBQVCBub3Qgb3ZlcmxhcCB3aXRoIHRoZSAi
bW92ZSIgYWN0aW9uIGFmdGVyIHlvdSBpbnRyb2R1Y2UgYSAiIGRtYV9yZXN2X3dhaXRfdGltZW91
dF9yY3UiDQoqYWZ0ZXIqIHRoZSBhbWRncHVfdm1fY2xlYXJfZnJlZWQgKCkgPw0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9u
IFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBUaHVy
c2RheSwgTWFyY2ggMTIsIDIwMjAgODo1MCBQTQ0KVG86IExpdSwgTW9uayA8TW9uay5MaXVAYW1k
LmNvbT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGFuZCBj
bGVhbnVwIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlDQoNCiBGcm9tIHRoZSBzZW1hbnRpYyB0aGUg
ZG1hX3Jlc3Ygb2JqZWN0IGNvbnRhaW5zIGEgc2luZ2xlIGV4Y2x1c2l2ZSBhbmQgbXVsdGlwbGUg
c2hhcmVkIGZlbmNlcyBhbmQgaXQgaXMgbWFuZGF0b3J5IHRoYXQgdGhlIHNoYXJlZCBmZW5jZXMg
Y29tcGxldGUgYWZ0ZXIgdGhlIGV4Y2x1c2l2ZSBvbmUuDQoNCk5vdyB3aGF0IGhhcHBlbnMgaXMg
dGhhdCBjbGVhcmluZyB0aGUgVk0gcGFnZSB0YWJsZXMgcnVucyBhc3luY2hyb25vdXNseSB0byB0
aGUgZXhjbHVzaXZlIGZlbmNlIHdoaWNoIG1vdmVzIHRoZSBidWZmZXIgYXJvdW5kLg0KDQpBbmQg
YmVjYXVzZSBvZiB0aGlzIFhpbmh1aSByYW4gaW50byBhIHJhcmUgcHJvYmxlbSB0aGF0IFRUTSB0
aG91Z2h0IGl0IGNvdWxkIHJldXNlIHRoZSBtZW1vcnkgd2hpbGUgaW4gcmVhbGl0eSBpdCB3YXMg
c3RpbGwgaW4gdXNlLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpBbSAxMi4wMy4yMCB1bSAx
MjozMCBzY2hyaWViIExpdSwgTW9uazoNCj4gQ2FuIHlvdSBnaXZlIG1vcmUgZGV0YWlscyBhYm91
dCAiIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUgdGhlIGNsZWFyIGZlbmNlIHdpbGwgY29tcGxldGUg
YWZ0ZXIgdGhlIGV4Y2x1c2l2ZSBvbmUuIiA/DQo+DQo+IFRoYW5rcw0KPg0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IE1vbmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlv
biBUZWFtIHxBTUQNCj4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIA0KPiBDaHJpc3RpYW4gSz9uaWcNCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEyLCAyMDIw
IDc6MTIgUE0NCj4gVG86IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZp
eCBhbmQgY2xlYW51cCBhbWRncHVfZ2VtX29iamVjdF9jbG9zZQ0KPg0KPiBUaGUgcHJvYmxlbSBp
cyB0aGF0IHdlIGNhbid0IGFkZCB0aGUgY2xlYXIgZmVuY2UgdG8gdGhlIEJPIHdoZW4gdGhlcmUg
aXMgYW4gZXhjbHVzaXZlIGZlbmNlIG9uIGl0IHNpbmNlIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUg
dGhlIGNsZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlIGV4Y2x1c2l2ZSBvbmUuDQo+
DQo+IFRvIGZpeCB0aGlzIHJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgd2FpdCBmb3IgYW55IHBv
dGVudGlhbCBleGNsdXNpdmUgZmVuY2Ugd2l0aCBhIHNtYWxsIHRpbWVvdXQgYmVmb3JlIGFkZGlu
ZyB0aGUgc2hhcmVkIGNsZWFyIGZlbmNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQxICsrKysrKysrKysrKysrKy0tLS0tLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+IGluZGV4
IDQyNzcxMjVhNzllZS4uMDc4MjE2MmZiNWYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jDQo+IEBAIC0xNjEsMTAgKzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9n
ZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCANCj4gZHJtX2dlbV9vYmplY3QgKm9iaiwNCj4gICANCj4g
ICAJc3RydWN0IGFtZGdwdV9ib19saXN0X2VudHJ5IHZtX3BkOw0KPiAgIAlzdHJ1Y3QgbGlzdF9o
ZWFkIGxpc3QsIGR1cGxpY2F0ZXM7DQo+ICsJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxM
Ow0KPiAgIAlzdHJ1Y3QgdHRtX3ZhbGlkYXRlX2J1ZmZlciB0djsNCj4gICAJc3RydWN0IHd3X2Fj
cXVpcmVfY3R4IHRpY2tldDsNCj4gICAJc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmE7DQo+IC0J
aW50IHI7DQo+ICsJbG9uZyByOw0KPiAgIA0KPiAgIAlJTklUX0xJU1RfSEVBRCgmbGlzdCk7DQo+
ICAgCUlOSVRfTElTVF9IRUFEKCZkdXBsaWNhdGVzKTsNCj4gQEAgLTE4MiwyNCArMTgzLDMyIEBA
IHZvaWQgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2Uoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmos
DQo+ICAgCQlyZXR1cm47DQo+ICAgCX0NCj4gICAJYm9fdmEgPSBhbWRncHVfdm1fYm9fZmluZCh2
bSwgYm8pOw0KPiAtCWlmIChib192YSAmJiAtLWJvX3ZhLT5yZWZfY291bnQgPT0gMCkgew0KPiAt
CQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsNCj4gKwlpZiAoIWJvX3ZhIHx8IC0tYm9f
dmEtPnJlZl9jb3VudCkNCj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPiAgIA0KPiAtCQlpZiAoYW1k
Z3B1X3ZtX3JlYWR5KHZtKSkgew0KPiAtCQkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxM
Ow0KPiArCWFtZGdwdV92bV9ib19ybXYoYWRldiwgYm9fdmEpOw0KPiArCWlmICghYW1kZ3B1X3Zt
X3JlYWR5KHZtKSkNCj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPiAgIA0KPiAtCQkJciA9IGFtZGdw
dV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsNCj4gLQkJCWlmICh1bmxpa2VseShy
KSkgew0KPiAtCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRvIGNsZWFyIHBhZ2UgIg0K
PiAtCQkJCQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7DQo+IC0JCQl9
DQo+ICAgDQo+IC0JCQlpZiAoZmVuY2UpIHsNCj4gLQkJCQlhbWRncHVfYm9fZmVuY2UoYm8sIGZl
bmNlLCB0cnVlKTsNCj4gLQkJCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsNCj4gLQkJCX0NCj4gLQkJ
fQ0KPiAtCX0NCj4gKwlyID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2Up
Ow0KPiArCWlmIChyIHx8ICFmZW5jZSkNCj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPiArDQo+ICsJ
ciA9IGRtYV9yZXN2X3dhaXRfdGltZW91dF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIGZhbHNlLCBm
YWxzZSwNCj4gKwkJCQkgICAgICBtc2Vjc190b19qaWZmaWVzKDEwKSk7DQo+ICsJaWYgKHIgPT0g
MCkNCj4gKwkJciA9IC1FVElNRURPVVQ7DQo+ICsJaWYgKHIpDQo+ICsJCWdvdG8gb3V0X3VubG9j
azsNCj4gKw0KPiArCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOw0KPiArCWRtYV9m
ZW5jZV9wdXQoZmVuY2UpOw0KPiArDQo+ICtvdXRfdW5sb2NrOg0KPiArCWlmICh1bmxpa2VseShy
KSkNCj4gKwkJZGV2X2VycihhZGV2LT5kZXYsICJmYWlsZWQgdG8gY2xlYXIgcGFnZSAiDQo+ICsJ
CQkidGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7DQo+ICAgCXR0bV9ldV9i
YWNrb2ZmX3Jlc2VydmF0aW9uKCZ0aWNrZXQsICZsaXN0KTsgIH0NCj4gICANCj4gLS0NCj4gMi4x
Ny4xDQo+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3QNCj4gcy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NNbw0KPiBuay5MaXUlNDBhbWQuY29tJTdD
MjY3MzBlNTZjNWI5NDRmOGNiYjQwOGQ3YzY4M2Q0YTElN0MzZGQ4OTYxZmU0ODg0ZTYwDQo+IDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE5NjE0MTgxNTkyOTkxNSZhbXA7c2RhdGE9eVA1
WWMxQldZV1M5M2YNCj4gMGhIRVJVZkVDbVNod3lRNWZiTWtoQ2VHODJuNk0lM0QmYW1wO3Jlc2Vy
dmVkPTANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
