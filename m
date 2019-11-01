Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B324CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F4821734
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F4821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130E26F821;
	Fri,  1 Nov 2019 15:13:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690054.outbound.protection.outlook.com [40.107.69.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72A26F821
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 15:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0oLgio/uGrWW+RAIsnLO0y9sc7ciInS0gQMKSMgZ9flCyWLC4Scglwj7fmki+ZTM6Bh0//3rniueDbpEn0heBHyrUuYaMYijoJ6rWCdcgPRi7327X68/5q4nyBRlRGECHAF4DMQdOHTAK5tMcR0RZc9nONdbp/Qd598kd3jtK0T3uhMG8Erj+nt8KNqFwQvg5/XXFUYAdOoJuo97CKXHkwecqmhePbD7R3LQLn/AQYMqGxutmZWB+rOZ5Npfpw/KyoR+fA7VfplmNB2eQeCo2IegAYT/k5rIhTKy1X2Wu2DZOapqU8WINteVKZ6mTAPfVglRkyN/oCRCUWx6o1GuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/afZcogfG0WPQUSqY7MCnHzpUgsUoZjfr454+mQ98xw=;
 b=B0w2+Y5r5S/Q0/Xr/0Ppg6b51hROUPP87dhP5RjBsWVzPNf407vzNPcTqAqF3KdY51jD7AbkU4bzSHYEWbfOqnTeKeCG5l1Avi2+FBueK48SGYrKXOwmYJphfYx2PpJZdq84QHJBXs6LU2pJUppMgFBq2oTGCJscxDfYFSMmDUCxLl8VyG7EoILJYrfjabGApkTEVswkkO9oNc55mySLP50km62Sg334b+w430oMVCAmnyhxDNtJTU/wdV9CLUtavrQefivSmDsd/9JYcF2FNA+Mq9AH1d3Y7ivVUVElA92qTk963+Q7FtxTbQ8puRCFISAn7eSjE6cmQeC7hk2a+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB2931.namprd12.prod.outlook.com (20.179.67.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 15:13:32 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05%6]) with mapi id 15.20.2408.018; Fri, 1 Nov 2019
 15:13:32 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Need to free discovery memory
Thread-Topic: [PATCH] drm/amdgpu: Need to free discovery memory
Thread-Index: AQHVkJPWY/t8lcSqm0W6qjgV8rCNb6d2anMu
Date: Fri, 1 Nov 2019 15:13:32 +0000
Message-ID:
 <BN8PR12MB36021054CEA4EF2DD94CFEE989620@BN8PR12MB3602.namprd12.prod.outlook.com>
References: <1572599256-24993-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1572599256-24993-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2309257e-abe3-49ea-ed35-08d75ede0f15
x-ms-traffictypediagnostic: BN8PR12MB2931:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2931DE7781025E31FA4294AE89620@BN8PR12MB2931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(25786009)(110136005)(305945005)(256004)(86362001)(81166006)(6436002)(229853002)(7736002)(8676002)(74316002)(446003)(966005)(81156014)(53546011)(76176011)(102836004)(14454004)(8936002)(14444005)(186003)(66066001)(486006)(476003)(6506007)(11346002)(26005)(99286004)(7696005)(478600001)(5660300002)(71190400001)(6246003)(52536014)(3846002)(9686003)(55016002)(71200400001)(2501003)(316002)(64756008)(2906002)(91956017)(66446008)(66946007)(76116006)(66476007)(66556008)(6306002)(6116002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2931;
 H:BN8PR12MB3602.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOOIbvatZychF23y9DGPfI2GleymAayDtDMFFgH/QpcQ5h0gdTgpyvEMwmPTYvEvyhEQ3RXoWde3ZBUn+exqvQusNzr0EBKASYNBB5nhvN8nVn/iRyxqs+9mNnNNVgRchcj3TEHW16SftYc+hOlwYVWxuMbCjb/4U8Nu4/jSsO9csZw9soZzQn8kClnFX3HFvifHJN3xCWbWriB6HAUu50wvgpv5WdGs2pci5JBqnVIkdPox/Vflst/RnZ0GLvoju6L5JIRq8yEYfFtUq1xJGffn7LefS+ox6jG5+n5VgYBA2YYUVHVd+5nH/iBzW6Khg1MEpue/30Wm/OhWkT6qVi8g8GHLLSHjPrnsWS5DiL7whJ8AtVSJVtwuZRee5/qw69h6EkJBJhxM9l43Yn8OeLm5VSiF/c4pwIiU1klGfURz812Qvc+UmC+0xmSZiOqUlUzbdQMsIZhUETnXFBmBE+ZlSO6uhiUXKdbBy6HTun0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2309257e-abe3-49ea-ed35-08d75ede0f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:13:32.3631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9dBw2W1r6/WYfkI+qlWAfoPL2QjPmH02MJHFjdPlXNuLtNliSKglgOEftOaY7W0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2931
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/afZcogfG0WPQUSqY7MCnHzpUgsUoZjfr454+mQ98xw=;
 b=VXF6vx3Sxl467+diOeHc3q5pUlPffcrth5Bd/rutGhZZa5XTFQSSWMQu11hKwnrK7JbR5Xl89SZ+WCcuEP1loYk56IzJ+HRdU9rRFpRe3pwuVGnVxg3StDHtmsmllL1Thg6U+Srm2znlGS+tA59RsC/pVrFfhIwnuSEIUo7F/hg=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101151332.y355XcqM8N5ytzRJP5_sok6beeU1AnJWXrKLQtMRaKQ@z>

SGkgRW1pbHksCgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuCgpJIHRoaW5rIGZyZWVpbmcgRGlz
Y292ZXJ5IFRNUiBibyBzaG91bGQgYmUgcHV0IGF0IGFtZGdwdV90dG1fZmluaSgpIGluc3RlYWQg
b2YgYW1kZ3B1X3R0bV9sYXRlX2luaXQoKSBiZWNhdXNlIHVubGlrZSBWR0Egc3RvbGVuIGJvLCB0
b3VjaGluZyBQU1AtcHJvdGVjdGVkIERpc2NvdmVyeSBUTVIgYm8gd2lsbCBjYXVzZSBHUFUgaGFu
Zy4gVGhlcmVmb3JlLCBpdCBzaG91bGQgYmUgcmVzZXJ2ZWQgYWNyb3NzIHRoZSBsaWZlLWN5Y2xl
IG9mIGFtZGdwdSBkcml2ZXIuCgpQbGVhc2Uga2luZGx5IHNlbmQgdjIgcGF0Y2ggd2l0aCB0aGlz
IGNoYW5nZS4KCkJSLApYaWFvamllCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IG9uIGJlaGFsZiBvZiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+ClNlbnQ6IEZy
aWRheSwgTm92ZW1iZXIgMSwgMjAxOSA1OjA3IFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogRGVuZywgRW1pbHkKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBOZWVk
IHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeQoKV2hlbiB1bmxvYWRpbmcgZHJpdmVyLCBuZWVkIHRv
IGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4KClNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5
LkRlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
IHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmluZGV4IDlmMmE4OTMuLjUwZDZl
ZDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpAQCAtMTA5MSw4ICsxMDkx
LDExIEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfZmluaSh2b2lkICpoYW5kbGUpCiAgICAgICAg
YW1kZ3B1X2dlbV9mb3JjZV9yZWxlYXNlKGFkZXYpOwogICAgICAgIGFtZGdwdV92bV9tYW5hZ2Vy
X2ZpbmkoYWRldik7CgotICAgICAgIGlmIChnbWNfdjlfMF9rZWVwX3N0b2xlbl9tZW1vcnkoYWRl
dikpCisgICAgICAgaWYgKGdtY192OV8wX2tlZXBfc3RvbGVuX21lbW9yeShhZGV2KSkgewogICAg
ICAgICAgICAgICAgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5zdG9sZW5fdmdhX21lbW9y
eSwgTlVMTCwgJnN0b2xlbl92Z2FfYnVmKTsKKyAgICAgICAgICAgICAgIC8qIHJldHVybiB0aGUg
SVAgRGlzY292ZXJ5IFRNUiBtZW1vcnkgYmFjayB0byBWUkFNICovCisgICAgICAgICAgICAgICBh
bWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5VTEwsIE5VTEwp
OworICAgICAgIH0KCiAgICAgICAgYW1kZ3B1X2dhcnRfdGFibGVfdnJhbV9mcmVlKGFkZXYpOwog
ICAgICAgIGFtZGdwdV9ib19maW5pKGFkZXYpOwotLQoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
