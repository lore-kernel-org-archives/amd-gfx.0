Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CDCCA9EB5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 16:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E270A2080F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 16:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E270A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C116E60A;
	Mon,  4 Nov 2019 16:52:44 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62376E44D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 16:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEs4HkZB1vrPiLPkzhw/fDte8Y+MXQVDsI07c2UvXoKo1F6yGO0R++ijfA7iGsJaH4iZuxLZspWj8QtK5G4Z7YHU7pSzO0ydsVf+k1ILtCtfxbxeOAUgT+3+NHTy5ARbMJ0BTC7DTtFZLKaSnXfTerKgCraXSmrVpwvGOxcCHHR86qnfnQMr5YNkU0v9YArAljYuJ6J19PQbH0xzLUdFz4ywPdkftpTnvqi+dnKE9EneaM8+bG9NYvk8wOOS8oo6dJM0i+8mVt+XyLmIuPD2t+6tGaYgcMJDdn2zC3KXYL11cZ70PFaWHUHDbKtXq3qcRhNhsev9EFaEM+hiZTVo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vf7uCWRq7AH/lk7XUlatRp83zvKBupLgWDy9GdQYfw=;
 b=HLb3iEwTb0xOXnY1koNoJNPQOoXF7ucIVD5oz9EPeJk8n3bA1qtJsH3Nj+SfFngkdbtN89sz9m3bULzmbty37qsa0IqLVvimkekr94zA+XIzEIKP19V76l0FFK2XZSWFzIy3yd8blbWKPQcdyV40N36cV5DzcD1X3E+MaXhRrlEfP3w1u5XKA3Mmvh0zpQN/BKZTO1Rq7oDjmcKppEvhfgNQSBsg8sl35v5iUWVxp7HMaF5YrkiN1R1OQBJQf9LNNyNRvY9P+GkvhmwAA4iSpZCL5nG4NK1IiC2QZmSECfKsr0Ma7Dwp7RS8R2kCGZvjbrncbQqW2foT3Jwod4/wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3621.namprd12.prod.outlook.com (20.178.54.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 16:52:40 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 16:52:40 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wu, Hersen" <hersenxs.wu@amd.com>
Subject: Re: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Topic: [PATCH] drm/amd/display: remove "setting DIG_MODE twice"
 workaround
Thread-Index: AQHVkymI1xwlEiK2sE2bB6BNavcbhqd7OjOA
Date: Mon, 4 Nov 2019 16:52:40 +0000
Message-ID: <9d0a0e07-f68a-8e93-3003-f19ca056b2ff@amd.com>
References: <DM6PR12MB3466E5EF19CE8BBD78AC6BBE9E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3466E5EF19CE8BBD78AC6BBE9E7F0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aee42e57-02ff-4a68-4721-08d761476773
x-ms-traffictypediagnostic: BYAPR12MB3621:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3621AA552FF2BDA5ABD13AC5EC7F0@BYAPR12MB3621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(52116002)(99286004)(2906002)(25786009)(66066001)(478600001)(6116002)(3846002)(7736002)(6486002)(6636002)(2501003)(229853002)(256004)(6512007)(6306002)(5660300002)(31686004)(86362001)(31696002)(81166006)(71190400001)(71200400001)(446003)(11346002)(2616005)(476003)(66556008)(66476007)(66446008)(64756008)(966005)(66946007)(8676002)(81156014)(6246003)(14454004)(305945005)(8936002)(186003)(6436002)(316002)(26005)(76176011)(102836004)(110136005)(386003)(6506007)(53546011)(36756003)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3621;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1X+yRWUe6G1c/AHLJDFl6BDUZUTlvnpesBCR0uI1EgcxuEY1voDg+lutyLkiRGvDfm8PTxrx3sut4eD2rQ+1ctG9rWkp4wMOTtRz220egsTrjVtkNwLXYRXkkWO4eit7VGqKfg+Lr8E3Dm5ovsHi0bR+phICxcJm/tAAMhx09w5wshh3sqpztkehSDcBD+foNpWzJpkpYkwnpZx0DZoqX/PCQ8Trz2xqBqHFbb/KfNOJ78Q7mvhmyNBfMA7DtoXx28vOcv+Hpdnm9dcquhp6G4BF6p4jxvNTQ4gLar4JV/rdDI+hZQo4UAP6b7FANHIYycC6ZA4HijgzqkLawA9LedJLtFPPNEYOTuHSJQu/kEQ2WAlfYPRu6LqDptQTHSmNT3fVQyybR08qdYfpsveSwTqE/VanUbiPYIE/C6k1dzBVlFZMOZGy4WMCVbzeOu0+cfHLIgtg9a67if9VwPkqExlDl9EN36DEnDx1ZLNTAI=
Content-ID: <5996FD494BF6AB47B2CCF5EE7DCBFA09@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee42e57-02ff-4a68-4721-08d761476773
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 16:52:40.4643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +f+MQHjSD1/VonkW4jH6XLb3Jjm6GXZh2t5VG7WNQ3uZmje90hHYU6flPOnBPL63WW+nLHQOJ+prIFBejeeBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3621
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vf7uCWRq7AH/lk7XUlatRp83zvKBupLgWDy9GdQYfw=;
 b=Z/XxXZLK5fB8Z4EVwYRZec7+5NY6+bhKaDKLxEiML3iwZJkaIE65pdteOej/YZQqC5EcGD6lzZhWoJi1UE0MjI9aRB/IrJwXJh4PTr1GCKIQt7g7NVV797ZKj2mNuM0TcWbSIlgi6esba1QMDNfh5u9AyiC/IueZjwTdJWJUMwo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191104165240.dm0B4Pw7jC5HvWetdnIK0QcR-Kl5Evd1NYKH-hugLWI@z>

T24gMjAxOS0xMS0wNCAxMTowNiBhLm0uLCBMaXUsIFpoYW4gd3JvdGU6DQo+IFtXaHldDQo+IFRo
ZSByb290IGNhdXNlIG9mIE5hdmkxNCBIRE1JIHBpbmsgc2NyZWVuIGlzc3VlIGhhcyBiZWVuIGZv
dW5kLg0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIHNldCBESUdfTU9ERSB0d2ljZSBhbnltb3JlLg0K
PiANCj4gW0hvd10NCj4gUmVtb3ZlICJzZXR0aW5nIERJR19NT0RFIiB0d2ljZSB3b3JrYXJvdW5k
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+DQoNClBs
ZWFzZSB1c2UgZ2l0IHRvIHJldmVydCB0aGUgY29tbWl0IGluc3RlYWQ6DQoNCmVnLg0KDQpnaXQg
cmV2ZXJ0IDxTSEE+DQoNClRoZW4gYWRkIHRoZSByZWFzb25pbmcgdG8gdGhlIHJldmVydCBjb21t
aXQgbWVzc2FnZS4NCg0KVGhhbmtzLA0KDQpOaWNob2xhcyBLYXpsYXVza2FzDQoNCj4gLS0tDQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgOSAtLS0t
LS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4gaW5kZXggY2M5NGMx
YTczZGFhLi4xMmJhNmZkZjg5YjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4gQEAgLTMwMjcsMTUgKzMwMjcsNiBAQCB2b2lkIGNv
cmVfbGlua19lbmFibGVfc3RyZWFtKA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIENPTlRST0xMRVJfRFBfVEVTVF9QQVRURVJOX1ZJREVPTU9ERSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDT0xPUl9ERVBUSF9VTkRFRklORUQp
Ow0KPiANCj4gLSAgICAgICAgICAgICAgIC8qIFRoaXMgc2Vjb25kIGNhbGwgaXMgbmVlZGVkIHRv
IHJlY29uZmlndXJlIHRoZSBESUcNCj4gLSAgICAgICAgICAgICAgICAqIGFzIGEgd29ya2Fyb3Vu
ZCBmb3IgdGhlIGluY29ycmVjdCB2YWx1ZSBiZWluZyBhcHBsaWVkDQo+IC0gICAgICAgICAgICAg
ICAgKiBmcm9tIHRyYW5zbWl0dGVyIGNvbnRyb2wuDQo+IC0gICAgICAgICAgICAgICAgKi8NCj4g
LSAgICAgICAgICAgICAgIGlmICghZGNfaXNfdmlydHVhbF9zaWduYWwocGlwZV9jdHgtPnN0cmVh
bS0+c2lnbmFsKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3RyZWFtLT5saW5rLT5saW5r
X2VuYy0+ZnVuY3MtPnNldHVwKA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cmVhbS0+bGluay0+bGlua19lbmMsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cGlwZV9jdHgtPnN0cmVhbS0+c2lnbmFsKTsNCj4gLQ0KPiAgICNpZmRlZiBDT05GSUdfRFJNX0FN
RF9EQ19EU0NfU1VQUE9SVA0KPiAgICAgICAgICAgICAgICAgIGlmIChwaXBlX2N0eC0+c3RyZWFt
LT50aW1pbmcuZmxhZ3MuRFNDKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZGNf
aXNfZHBfc2lnbmFsKHBpcGVfY3R4LT5zdHJlYW0tPnNpZ25hbCkgfHwNCj4gLS0NCj4gMi4yMS4w
DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KPiAN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
