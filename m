Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF47ACA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AE220663
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3533F6E1CF;
	Thu, 24 Oct 2019 10:12:53 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740075.outbound.protection.outlook.com [40.107.74.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768046E1CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMBoJDUTC9WIzvzBC7Vklchqg51Wv59rXSCGoAqz69MJFz7DRNd57q9om8NA0yN1Sr1bEMSZCwkBHO9rpY//orpUZeGasbhbGcOL/tw1kymgjxNyckPcbIHjf5475+TxNT5GwG1JUI6eRtQmql4Rk0g/Qr8aPjCQuwEmGxSv3l1l8Akq0hY3ljzhtfjkIN1lFwOOaaNBfBcHUIK5by1GR3I5xWkdoQAMbg8QnbjPQCRXWKNP7FheT3IDJM0my4WHaZS4aYBIHYO4Hc3KgBHlT8CoC4yCgMXYGiy4wcDmBnvQN2BON95DlbgFvygYq1kBoX2Ktt/2sCQ8xvZ8gGI0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM0xor6pxCO3VnZOwLMi/+S17OWqpgC4NxEJFJOrKF8=;
 b=m8Y6Au2dDe1j0iqxH9LFJITlVy2Lu9PAeeCCTmMVi0owNZEzfIGdesF3Ke8HH/vUbyvk/ab/SCWAkukTBxsj9ocMEv1J8EzrOALmeTX077B/CldfCv9xOn25lKZNGzkt3kUN8BldZBo97qq9IUTKGqmu8hzlLu1Cs2aedPIABkIVcJJr4ft3f7ndZ+jDQnh4sa5FhS8C0O4kinMqHSrCDDXhT9SKbrBJ2U9BuO5AJcim1hFv9UTs4cR8yM0VwUSAY7FvarvVGj48YalWxFSCC3B9NlgTHJCs3QPmKxqrrPWTmzxLJzuhAQlzqq4jVh4w1BKPnBc4+P7vfVzovtfZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB3925.namprd12.prod.outlook.com (52.132.231.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 10:12:47 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::b528:bdc9:94c9:ff0]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::b528:bdc9:94c9:ff0%6]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 10:12:47 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx10: update gfx golden settings for
 navi14
Thread-Index: AQHVilNBjxR2P5xkxEeowf/vI55V36dpklmw
Date: Thu, 24 Oct 2019 10:12:46 +0000
Message-ID:
 <CH2PR12MB37671C7C33787D8C5E987986FE6A0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20191024101004.17247-1-tianci.yin@amd.com>
 <20191024101004.17247-2-tianci.yin@amd.com>
In-Reply-To: <20191024101004.17247-2-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c311b4e-6bc5-48e3-131f-08d7586ab7e9
x-ms-traffictypediagnostic: CH2PR12MB3925:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3925858AA81F376881AFAFF1FE6A0@CH2PR12MB3925.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(13464003)(8936002)(3846002)(6116002)(14454004)(2906002)(52536014)(6436002)(7696005)(76176011)(6506007)(99286004)(66446008)(53546011)(64756008)(66556008)(476003)(66946007)(66476007)(11346002)(446003)(486006)(102836004)(26005)(71200400001)(76116006)(71190400001)(186003)(74316002)(5660300002)(2501003)(9686003)(6306002)(55016002)(14444005)(305945005)(256004)(6246003)(7736002)(8676002)(81156014)(86362001)(316002)(81166006)(25786009)(966005)(33656002)(478600001)(15650500001)(4326008)(229853002)(66066001)(54906003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3925;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVPHJFMbbrXIyWMoT/fOk63y1Q9RYteaCTli7PQFFAqozsPXNYuVGNHkTVkYkHxcXEqb9e9XHWC8ZLeAxAQPse6iUO8xK+JBX4GbTv0AcF4TR3HPJVlUS0og5Ck0BUh+l8O8d08dhWyZmucy+xTpv6jCwsANBrZrM+NMdHdI36lZjj/Mt0YkFvnEtuAJhlpdEXPFLCbua6389ZB4s8ZWoyNbo/s7Tk+hZQ2PtsFn0EBHs9iVVOKWDBmsspuuy2LXjh/aZiMDFE2dS+FCRuCAtMTsYbYfHHUsvhV/BEMQwB4bRhBwIU4UY0vzrQAaZfZjaOElSYc3a+sNgfN+LMZGRbAMVmjQc4jRG55bEIZdIFzRwEaCa+XOw5yKGsp0daK1rwF/Z1MzgehCLh9fFsEx8awQTO+IJ8W2eDW4V2ZPTo+RX/VnvN3IeN82MNfip2ZO9xb7AYaVVvnWb0oxYxwlMJzZG6mFbWar2mb6kiAHZA8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c311b4e-6bc5-48e3-131f-08d7586ab7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 10:12:46.9658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v6N8bJ2oXamIxMwbeRQd6CUTdz+lBDNo8M7QfskajljxlZgBzNhJroAEiG51HOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM0xor6pxCO3VnZOwLMi/+S17OWqpgC4NxEJFJOrKF8=;
 b=yh9Bo7CUy4HhtqBE4pOBqQqZfJeYdjaOc+y7SUm9rh7MIQl5wZC7zPnqCyG2sAQiIYrynuR9aAhRpRTu8zBWWDqSPJUQZBxJwQqaGP73T9FBBt1MpAy/Y9FD38gEnqJ2mUWJxSTjdOmgEIREOw2j9gqJgQTl0mLKItQ2Re4G0B8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024101246.0py5subH040KD_n-GNTR9pyOZ_eCIxOgBk3fILglLD0@z>

U2VyaWVzIGlzIHJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KDQpU
aGFua3MsDQpGZWlmZWkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBU
aWFuY2kgWWluDQpTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNCwgMjAxOSA2OjEwIFBNDQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBYdSwgRmVpZmVpIDxGZWlmZWkuWHVA
YW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWXVhbiwgWGlhb2ppZSA8
WGlhb2ppZS5ZdWFuQGFtZC5jb20+OyBZaW4sIFRpYW5jaSAoUmljbykgPFRpYW5jaS5ZaW5AYW1k
LmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBb
UEFUQ0ggMi8zXSBkcm0vYW1kZ3B1L2dmeDEwOiB1cGRhdGUgZ2Z4IGdvbGRlbiBzZXR0aW5ncyBm
b3IgbmF2aTE0DQoNCkZyb206ICJUaWFuY2kuWWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPg0KDQp1
cGRhdGUgcmVnaXN0ZXJzOiBtbUNHVFRfU1BJX0NMS19DVFJMDQoNCkNoYW5nZS1JZDogSWIyNTM5
YWFlMWZiMGQwMDEyNzhiN2Y4OWM5MGFkNjI5NmY5ZmI4NWYNClNpZ25lZC1vZmYtYnk6IFRpYW5j
aS5ZaW4gPHRpYW5jaS55aW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KaW5k
ZXggMTFlODYzYzRjNDBiLi4yMmQwZmFkZTljNzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMNCkBAIC0xNDAsNyArMTQwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBz
b2MxNV9yZWdfZ29sZGVuIGdvbGRlbl9zZXR0aW5nc19nY18xMF8xXzFbXSA9DQogCVNPQzE1X1JF
R19HT0xERU5fVkFMVUUoR0MsIDAsIG1tQ0JfSFdfQ09OVFJPTF80LCAweGZmZmZmZmZmLCAweDAw
M2MwMDE0KSwNCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX0dTX05HR19D
TEtfQ1RSTCwgMHhmZmZmOGZmZiwgMHhmZmZmODEwMCksDQogCVNPQzE1X1JFR19HT0xERU5fVkFM
VUUoR0MsIDAsIG1tQ0dUVF9JQV9DTEtfQ1RSTCwgMHhmZmZmMGZmZiwgMHhmZmZmMDEwMCksDQot
CVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tQ0dUVF9TUElfQ0xLX0NUUkwsIDB4YzAw
MDAwMDAsIDB4YzAwMDAxMDApLA0KKwlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNH
VFRfU1BJX0NMS19DVFJMLCAweGNkMDAwMDAwLCAweDBkMDAwMTAwKSwNCiAJU09DMTVfUkVHX0dP
TERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NRX0NMS19DVFJMLCAweGY4ZmYwZmZmLCAweDYwMDAw
MTAwKSwNCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NRR19DTEtfQ1RS
TCwgMHg0MDAwMGZmMCwgMHg0MDAwMDEwMCksDQogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0Ms
IDAsIG1tQ0dUVF9WR1RfQ0xLX0NUUkwsIDB4ZmZmZjhmZmYsIDB4ZmZmZjgxMDApLA0KLS0gDQoy
LjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
