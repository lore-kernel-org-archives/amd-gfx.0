Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EDCA9ECF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067C521855
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067C521855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E866E343;
	Sat,  2 Nov 2019 01:18:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD0B6E343
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Nov 2019 01:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4uz+LP76CCz1iKqzTWyff9lklEPFOdYEd2zJXbKkrhEBzO9labmRkS5vbf7GB1pXpghMWJa0HeHWSb6Sh5oz0ptGq9P1eiv2RGhiqPIPC/+KvY1QPZIATpD1b88egD22H61lsIq8FZdelVXBo5nNZDbHCikv/UXnSG86rNTuhUShzjRxdZMFFcN0U+SPHgTueqDu60XAAArF0GJa6mrWALHoXhdZttaurKOsYi5e/vFBEV5oc4tN4vi2pZnnEShaqJOySkI0cW39t2M/iLOuo59uZiCvmuy8HPlxvP49uYxX9QglD3przhC0ZoAKPK3kADpn5PfVhxifs+GInH/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odc6TMh06ECBP0HRcu6TwG3l2vmGmWi7BFXm7Kkl76Y=;
 b=VIDRB77lbibplbamTnKz0dQRH+vn3VTLAJM1T8qtlHN46XepPE2JdTs3c4P3ieVXG5tij4QUKkfiApjRp7m75t2vTzQj5lwwmrscq4vs80qNqk0eyXa2Op+bnOoyyRuV4xJNSwC1k7DDiUWviPkwpEDotBeL+60QMxU/USchH53U1bW8vAtNtTnQ4Mcw8NF+l1rruB/Tnx5y7dT5Yj92Exxz3zRcHfgQrXK3rlTazgf/6W0htQh4UpPvL6rfbX7cryk4yuDqp/jbl9UP8MtdH4nZSkVzkapXg0bRcWOvlnbQz/OhCdTKf4VsnCUYD+dProy1zft1xDVgJB7c+KmF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3193.namprd12.prod.outlook.com (20.179.105.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sat, 2 Nov 2019 01:18:10 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::b5f1:6693:1573:ab1e]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::b5f1:6693:1573:ab1e%6]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 01:18:10 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Liu, Zhan"
 <Zhan.Liu@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for Navi14
Thread-Topic: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Index: AQHVkRtJPzPseCXxv0iiGbLb2otyPQ==
Date: Sat, 2 Nov 2019 01:18:09 +0000
Message-ID:
 <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 346a558b-9f2c-4ba5-ebd9-08d75f32862b
x-ms-traffictypediagnostic: DM6PR12MB3193:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3193A73FFD1F94EBA72BB8479E7D0@DM6PR12MB3193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(316002)(25786009)(26005)(33656002)(66066001)(81156014)(81166006)(8676002)(7696005)(99286004)(110136005)(86362001)(14454004)(3846002)(4326008)(102836004)(74316002)(5660300002)(66946007)(186003)(53546011)(7736002)(305945005)(6506007)(76116006)(476003)(2906002)(66476007)(71190400001)(71200400001)(55016002)(966005)(54906003)(6436002)(6116002)(2501003)(8936002)(9686003)(256004)(6306002)(66556008)(52536014)(14444005)(6636002)(64756008)(66446008)(91956017)(486006)(478600001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3193;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcF+Cj6FXZQa4clLnTjeHHwewgvL7gwuw29wUFaKlgHsl3PsYf+XS/z7L35t6nCnSJ5QGgBPYL3zoAGOp/My+a7eReEe6oeeF8DOgMRKrLV4/H1ddRmu5USghZVoiarg+kcrfGGy2dmxvvqPyz7+qm9uhoLXxkecwyj3YpRQXRnB6iBymKBuYAhH4KoHrIOXp1KQkrYh0LXYJVTtyjkx3nyiN4N7VYq1v0uZGiQG+vwm/mnKDK2iTgsDLlIKM8/uyV6qEVEHRUtUH28WBQR705aD6rLoXWz/lLCmpj9UmfAi15Pw25oFiLpKC3EOoBScaz6c0Ov4oT8WZKWhBRI0Y4xEeu9fI8S6WWOujUbMC47/JXb5ldCfx3nHIyKIbbWUIx86tNk+UlPMcAii/0XbDiH85zda1qYnqHRgY55f1kLfCuccQuj7gmaT1mGOsEhGciSPXKmBxVXlaa4Oyfv1aIfWMlCG+bDiBt4DOxMk3S8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a558b-9f2c-4ba5-ebd9-08d75f32862b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 01:18:09.8584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0J9oJga1ruDQA0t/r/E+ythNHGtAWkz+UJPhU7yJXZX2+nn1uL6h3XMb40Nc5g2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odc6TMh06ECBP0HRcu6TwG3l2vmGmWi7BFXm7Kkl76Y=;
 b=4SzuP161UzkWZekxhkLOBZ4DcP+O+LG469rnHJMi6oMtxrNweBYm/eW1plrL2abalRo8U738HqFnmaN/XyRytgem/3a3XYZ8A519VAqLlZqhntCGDUIyt1eNyI153mlUiUkdlKynnARyui1+jDMwzQVkF64Icq7gLKUC9g+BiTg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Yeh, Eagle" <Eagle.Yeh@amd.com>, "Lazare, Jordan" <Jordan.Lazare@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191102011809.deT5LIZW7lbLhprCjfKywInTFSei__Btqa3USUJZa1w@z>

RnJvbTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+CkRhdGU6IEZyaSwgMSBOb3YgMjAxOSAy
MToxMDoxNyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lO
RV9JRF9ESUdEIGNvbmRpdGlvbiBjaGVjayBmb3IgTmF2aTE0CgpbV2h5XQpOYXZpMTAgaGFzIDYg
UEhZLCBidXQgTmF2aTE0IG9ubHkgaGFzIDUgUEhZLCB0aGF0IGlzCmJlY2F1c2UgdGhlcmUgaXMg
bm8gRU5HSU5FX0lEX0RJR0QgaW4gTmF2aTE0LiBXaXRob3V0CnRoaXMgcGF0Y2gsIG1hbnkgSERN
SSByZWxhdGVkIGlzc3VlcyAoZS5nLiBIRE1JIFMzCnJlc3VtZSBmYWlsdXJlLCBIRE1JIHBpbmsg
c2NyZWVuIG9uIGJvb3QpIHdpbGwgYmUKb2JzZXJ2ZWQuCgpbSG93XQpJZiBlbmdfaWQgaXMgbGFy
Z2VyIHRoYW4gRU5HSU5FX0lEX0RJR0QsIHRoZW4KYWRkIGVuZ19pZCBieSAxLgoKU2lnbmVkLW9m
Zi1ieTogWmhhbiBsaXUgPHpoYW4ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKaW5kZXggOTI0YzJlMzAzNTg4Li5jZjg4NjQ4
M2UzODAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9k
Y24yMF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9yZXNvdXJjZS5jCkBAIC0xMTUyLDYgKzExNTIsOSBAQCBzdHJ1Y3Qgc3RyZWFtX2Vu
Y29kZXIgKmRjbjIwX3N0cmVhbV9lbmNvZGVyX2NyZWF0ZSgKICAgICAgICBpZiAoIWVuYzEpCiAg
ICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKCisgICAgICAgaWYgKGVuZ19pZCA+PSBFTkdJTkVf
SURfRElHRCkKKyAgICAgICAgICAgICAgIGVuZ19pZCsrOworCiAgICAgICAgZGNuMjBfc3RyZWFt
X2VuY29kZXJfY29uc3RydWN0KGVuYzEsIGN0eCwgY3R4LT5kY19iaW9zLCBlbmdfaWQsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3RyZWFtX2VuY19yZWdzW2VuZ19p
ZF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc2Vfc2hpZnQsICZz
ZV9tYXNrKTsKLS0KMi4yMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwoKYW1kLWdmeCBtYWlsaW5nIGxpc3QKCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
