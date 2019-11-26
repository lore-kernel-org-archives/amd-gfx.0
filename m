Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC913C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 01:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FCA2068F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 01:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FCA2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBE26E1BE;
	Tue, 26 Nov 2019 01:06:59 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730052.outbound.protection.outlook.com [40.107.73.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACC56E1BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 01:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvBjJ0uedCM20LsThkhEzaYzXuUPF6S63i7wsle7aqLv6Rx9Oj1QBDcHFpUC052jiVcQv90Wmj7M/O9a8zgXy9O9rMjD3yN0I7JsgEF8rq9qQjPOtMq2KXamTwmNg5o1lzLHmVzz0moy2l04WY6xfEsk1FiPkHwYXnE484tebxbMUHkqbR1rQDqpt7IRYek0rTisJKgTHZhJCbi+nzNnp4PUk5UMflTBWlDRKB5r8m7kB+G/FJhJJlwZmn7LbtYMqY0ALhGrVyXjRx1mcnYqdZfb61jwE/juyRkxlEBsCqgwvBeeQmstkTAT5/EOFYIj6at0KiDIg5Gg8xRREZKMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZPblrHfMFEHQh42ytfZkwNjfpc+v2PGSqMGEwoaPds=;
 b=YnHEYLyBB+b/FPv38fdnrxc2tSNQLTv425eTmDMKb8erhjYWq9gZ034rhEYtnJt5Urvi+8VJ0xbLsmgFiNnsW4j539+jFjVwDVayeJyrr6h9/E1rcfczh/Sx+71VJEx3JFXoVVTnTjT+nropa2AL+Yfv7x95CHgR3KxdlSekquN8rnRnPcroW3N6XmR41t38OscPyMTON74XQnNbOmGFvtqO0qW5P1b7tBJ5dRPCP20IDsrH+45C9Pbxxm3XIJVKEznQVKwDANcfxI5R5sBoY8BwODLMf1GmMrq6TzlBvp65wyOWmSzaCd86woNk1tQI4rS2aOOhd31dhxQluDYyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 01:06:52 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f5af:90ff:e4a8:9f65]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f5af:90ff:e4a8:9f65%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 01:06:52 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Optimize KFD page table reservation
Thread-Topic: [PATCH 1/1] drm/amdgpu: Optimize KFD page table reservation
Thread-Index: AQHVo8eO7tnYpD5ri06D6WIdDxeUtKeco52g
Date: Tue, 26 Nov 2019 01:06:52 +0000
Message-ID:
 <SN6PR12MB28005F46AE7B69AADAFE4F6D87450@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20191125193526.19803-1-Felix.Kuehling@amd.com>
In-Reply-To: <20191125193526.19803-1-Felix.Kuehling@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 717a6b94-80d1-439e-410c-08d7720cec26
x-ms-traffictypediagnostic: SN6PR12MB2784:|SN6PR12MB2784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2784869CD9AD2A383BB8F10587450@SN6PR12MB2784.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(189003)(199004)(13464003)(6436002)(8936002)(76176011)(66556008)(64756008)(66066001)(53546011)(446003)(316002)(11346002)(14454004)(7696005)(66446008)(9686003)(256004)(99286004)(86362001)(66476007)(14444005)(66946007)(478600001)(55016002)(2906002)(52536014)(76116006)(7736002)(305945005)(71200400001)(6506007)(102836004)(74316002)(33656002)(229853002)(6246003)(26005)(25786009)(3846002)(6116002)(186003)(110136005)(5660300002)(81166006)(2501003)(8676002)(81156014)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2784;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7vGN8d5Fz2/AfmcH+GBUmtLJAoe1NCuoW7TbKChrLBJHudjIJcEo1pRUbKsHvfQCle/u4qg0KD90lsU0QpoGKig0Dfmi98OISdhmZaY21uj2eEqYHkmjA/opesHZ98lHR52G4Nsb9lkKfouYjTNIu4obuU93aNGIJkPF+BbG/guzl7PsEsYfSOVOyp/b+xTtoHZm5mtkReL6LHc+ZhzQfbxoyXvryl1Vk1gwoYgN153DuLX2wbKSTAHtxBpfUPgJlsnupz551/9m02/r4vQ0NC4LLNHMsl51NUh7kj8wvQCASp5OdObDxi5YnEfZMJAvFhDmaMnHFvx16YV+V2redtSBqEkxvtnvRrfWuo7K76N+GhB4MNDFLUChVTxRHqpw81oU/Or7X04DX0hvhwHPbuOM9LpTgo6QFxaQxHwjZCKhiioT4xJJNwZnQdbja85
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a6b94-80d1-439e-410c-08d7720cec26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 01:06:52.2329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDiekIqGR0fEiHndJw9durmmJD4qPIXjCRAog6oY+V2hRFNCIpON79UiLsJ5ITyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZPblrHfMFEHQh42ytfZkwNjfpc+v2PGSqMGEwoaPds=;
 b=BmS9P9aXae/jZGGvp7tPoEE4TiRzKibO5+PdexGGE0P5hTsHGTKUTiAnjrzb13397/XjPrgAbFgohKYiR4ghHuqDQOK2CSfEtdrLUrQlrCE7jCXHqix/RhGoAkzhwflUywLLFVGjE/H9SzWFyHe2SoyDhhGd/Mtt96qX/Kl2lJw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
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
Message-ID: <20191126010652.k4egNL-VD9Z3lwp1OiI9lmXIu607YKuSVc_Vx3xVqeM@z>

UmVhbGx5IGNvb2wgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFu
QGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywg
RmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogMjAxOeW5tDEx5pyIMjbml6Ug
MzozNQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBQYW4sIFhpbmh1aSA8WGlu
aHVpLlBhbkBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDEvMV0gZHJtL2FtZGdwdTogT3B0aW1p
emUgS0ZEIHBhZ2UgdGFibGUgcmVzZXJ2YXRpb24NCg0KQmUgbGVzcyBwZXNzaW1pc3RpYyBhYm91
dCBlc3RpbWF0ZWQgcGFnZSB0YWJsZSB1c2UgZm9yIEtGRC4gTW9zdCBhbGxvY2F0aW9ucyB1c2Ug
Mk1CIHBhZ2VzIGFuZCB0aGVyZWZvcmUgbmVlZCBsZXNzIFZSQU0gZm9yIHBhZ2UgdGFibGVzLiBU
aGlzIGFsbG93cyBtb3JlIFZSQU0gdG8gYmUgdXNlZCBmb3IgYXBwbGljYXRpb25zIGVzcGVjaWFs
bHkgb24gbGFyZ2Ugc3lzdGVtcyB3aXRoIG1hbnkgR1BVcyBhbmQgaHVuZHJlZHMgb2YgR0Igb2Yg
c3lzdGVtIG1lbW9yeS4NCg0KRXhhbXBsZTogOCBHUFVzIHdpdGggMzJHQiBWUkFNIGVhY2ggKyAy
NTZHQiBzeXN0ZW0gbWVtb3J5ID0gNTEyR0IgT2xkIHBhZ2UgdGFibGUgcmVzZXJ2YXRpb24gcGVy
IEdQVTogIDFHQiBOZXcgcGFnZSB0YWJsZSByZXNlcnZhdGlvbiBwZXIgR1BVOiAzMk1CDQoNClNp
Z25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMTUg
KysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KaW5kZXggYTFlZDhhOGUzNzUyLi5lNDNhOTU1MTRiNDEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KQEAgLTEw
NSwxMSArMTA1LDI0IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9pbml0X21lbV9saW1pdHMo
dm9pZCkNCiAJCShrZmRfbWVtX2xpbWl0Lm1heF90dG1fbWVtX2xpbWl0ID4+IDIwKSk7ICB9DQog
DQorLyogRXN0aW1hdGUgcGFnZSB0YWJsZSBzaXplIG5lZWRlZCB0byByZXByZXNlbnQgYSBnaXZl
biBtZW1vcnkgc2l6ZQ0KKyAqDQorICogV2l0aCA0S0IgcGFnZXMsIHdlIG5lZWQgb25lIDggYnl0
ZSBQVEUgZm9yIGVhY2ggNEtCIG9mIG1lbW9yeQ0KKyAqIChmYWN0b3IgNTEyLCA+PiA5KS4gV2l0
aCAyTUIgcGFnZXMsIHdlIG5lZWQgb25lIDggYnl0ZSBQVEUgZm9yIDJNQg0KKyAqIG9mIG1lbW9y
eSAoZmFjdG9yIDI1NkssID4+IDE4KS4gUk9DbSB1c2VyIG1vZGUgdHJpZXMgdG8gb3B0aW1pemUN
CisgKiBmb3IgMk1CIHBhZ2VzIGZvciBUTEIgZWZmaWNpZW5jeS4gSG93ZXZlciwgc21hbGwgYWxs
b2NhdGlvbnMgYW5kDQorICogZnJhZ21lbnRlZCBzeXN0ZW0gbWVtb3J5IHN0aWxsIG5lZWQgc29t
ZSA0S0IgcGFnZXMuIFdlIGNob29zZSBhDQorICogY29tcHJvbWlzZSB0aGF0IHNob3VsZCB3b3Jr
IGluIG1vc3QgY2FzZXMgd2l0aG91dCByZXNlcnZpbmcgdG9vDQorICogbXVjaCBtZW1vcnkgZm9y
IHBhZ2UgdGFibGVzIHVubmVjZXNzYXJpbHkgKGZhY3RvciAxNkssID4+IDE0KS4NCisgKi8NCisj
ZGVmaW5lIEVTVElNQVRFX1BUX1NJWkUobWVtX3NpemUpICgobWVtX3NpemUpID4+IDE0KQ0KKw0K
IHN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF9yZXNlcnZlX21lbV9saW1pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCiAJCXVpbnQ2NF90IHNpemUsIHUzMiBkb21haW4sIGJvb2wgc2cpDQog
ew0KKwl1aW50NjRfdCByZXNlcnZlZF9mb3JfcHQgPQ0KKwkJRVNUSU1BVEVfUFRfU0laRShhbWRn
cHVfYW1ka2ZkX3RvdGFsX21lbV9zaXplKTsNCiAJc2l6ZV90IGFjY19zaXplLCBzeXN0ZW1fbWVt
X25lZWRlZCwgdHRtX21lbV9uZWVkZWQsIHZyYW1fbmVlZGVkOw0KLQl1aW50NjRfdCByZXNlcnZl
ZF9mb3JfcHQgPSBhbWRncHVfYW1ka2ZkX3RvdGFsX21lbV9zaXplID4+IDk7DQogCWludCByZXQg
PSAwOw0KIA0KIAlhY2Nfc2l6ZSA9IHR0bV9ib19kbWFfYWNjX3NpemUoJmFkZXYtPm1tYW4uYmRl
diwgc2l6ZSwNCi0tDQoyLjI0LjANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
