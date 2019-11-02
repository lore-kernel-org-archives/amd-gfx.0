Return-Path: <SRS0=roBy=Y2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F9FCA9ECF
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE92721855
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2019 01:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92721855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC786F8A8;
	Sat,  2 Nov 2019 01:23:25 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820075.outbound.protection.outlook.com [40.107.82.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61AC76F8A8
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Nov 2019 01:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGIRhHZ9gwRiZFHU83CJjNtZfS4iKmW0ACxKjFf+ZTIpS0rwm7QwBMzigrGbovrosQKst9F0IsAEJWMcoHfZ/+dpv0gmmShCjeG8t6XcKK3Zrv1FzVz4HgUKcqy3+ZH0qPLPZZnV4gOqCIDXvij3rzLgVxn6qKbK8odLhNAS/YzPUW468dVdQrLrLoSCoS/hM05BfFbkjnnMyxNOVWbV26BpUtQI631wbhOZHOGpDsCywaXLvZcJvoL3hvIbhYlalui0Zg0uOwsyVU1bk2PHkGaTn0oh3Wh8XP0q6/GoypwA+nR+4HqoABZD/4kY9hWpUgVQCq7cGh3+0EufUpzCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AABsKgzutJ1YAjJujjXpImPHu+rl7VyyEefjY2DfnPM=;
 b=O666el+fUmIAF4qDDuIcZi/PIWMllSNTfkbqe+gGXZ9ceI26yPdW56WnFX684XDgNypqHVxwOEr5SYMSgkUmX5oiFy4vt3JSX6GckgAXJMAclevR3qJOmNGyUYJIKuCQDU05Yaa4SkiXeQrXczRfxlbDw/QnKjh6NbGddXU4hFfp0dZS34XyQVbQTVoRnr7mvxILin+WZ1oZJP9Yf4AE2K0xwfpegKUOgKmmPMbkqVfTNB6A0maz6owINrbwZ9OYMkCSun6aPUCZ0jlRZMnxr4+E5Ic3CZ8SaDrMbYQcQHoiME/kg3LmLWsHnp7T/5FYwLpCJa7UTeACrlS5adIyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2339.namprd12.prod.outlook.com (52.132.11.148) by
 BL0PR12MB2548.namprd12.prod.outlook.com (52.132.29.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 2 Nov 2019 01:23:20 +0000
Received: from BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::b807:6ac3:d720:5b56]) by BL0PR12MB2339.namprd12.prod.outlook.com
 ([fe80::b807:6ac3:d720:5b56%5]) with mapi id 15.20.2387.027; Sat, 2 Nov 2019
 01:23:20 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Topic: [PATCH] drm/amd/display: Add ENGINE_ID_DIGD condition check for
 Navi14
Thread-Index: AQHVkRtJPzPseCXxv0iiGbLb2otyPad3FY3Q
Date: Sat, 2 Nov 2019 01:23:19 +0000
Message-ID:
 <BL0PR12MB2339B22CD38213ABB2CA34B6FD7D0@BL0PR12MB2339.namprd12.prod.outlook.com>
References: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3466484A8A36F85A0F3C8F289E7D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:fea8:3c60:111:e505:7c5e:39ee:d355]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03b6c7ea-f777-4285-104e-08d75f333f01
x-ms-traffictypediagnostic: BL0PR12MB2548:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25480696BCE3C569682B283DFD7D0@BL0PR12MB2548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(13464003)(189003)(199004)(6116002)(102836004)(66446008)(33656002)(446003)(8936002)(7736002)(8676002)(305945005)(99286004)(64756008)(186003)(7696005)(4326008)(81156014)(46003)(14444005)(74316002)(66556008)(6636002)(256004)(81166006)(6306002)(6436002)(76176011)(55016002)(66476007)(486006)(9686003)(53546011)(6506007)(52536014)(11346002)(25786009)(476003)(966005)(71190400001)(76116006)(66946007)(71200400001)(2906002)(2501003)(229853002)(54906003)(5660300002)(316002)(6246003)(110136005)(86362001)(478600001)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2548;
 H:BL0PR12MB2339.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SoDGhjyz9QqENZ8jtYtkeK/SDIwLXesoA/P1uVotKOgiMxsVTolNXNq6Ceobhroe4TRYDpX0Q+7K2/YBkSmEPRHnhI17Ura9vlmkN8qIZR91vj2lma3HBcAErsKOGlrwOkA1xkx5itQ4P1zXN7BzZ0O7qboq6NmtBNhRn3DxQcOhh755w3pCSR51DdolRawUcSiQyz/iy9zHAIDF3lh8PHlRABmNFWPXR6BU3g57D2bCFeHGbAkn10S7n+CmNtbFRsbiUYXw+cYXM7U4j/wQ6ARAxWHOsy1ygd3n3MnCs4KC6kVh90XSflGhCMa2qcAN1U+0oIiIyLIhmM3Q6fgwN/QDejNsqzS7VkbAoiNrGdP8sy1cbijnj8GgNASI38OHz8cmaYaWorNO2SKG02PV7XCB//V7ZsQNMw7tE4FhmEOCREt9LOhfmaQInnY4GH7S5Osfrp6ualeT04RkYf4/Xu0YoEN0ZUk6tNUu/3BBJ3s=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6c7ea-f777-4285-104e-08d75f333f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 01:23:20.0200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkUrOpFizkHw7PhpNaKTL+/LTpbYnbrGjKZU4w/Px3lsoZ3TQ+oFWApqv4sOx/8B7ACByykkiPyHagjILi6J/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AABsKgzutJ1YAjJujjXpImPHu+rl7VyyEefjY2DfnPM=;
 b=zghAO2UFJrP1DUSCj4Piipdg3v9vlnjM1SHfkuPJN7+w83bjySRDFTNYrcKLUrhQgjgdhpEqLELSsb4I/X4AkuehwcSgkcF1cc3uOKs7Fgs2MzCuIZ/F3/JRV8xUFu1j238PnZNc3ZggS2IjBmo9/bQ5BDwHhsZWMJf7qx9wQCI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hersenxs.wu@amd.com; 
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
Message-ID: <20191102012319.5xT-NpVrxTAzu36YPVge4uXkM8X8HWWALeUGBdn_TBE@z>

SGkgWmhhbiwKClRoZSBmdW5jdGlvbiBpcyBzaGFyZWQgYnkgTlYxMCwxMiwxNC4KClBsZWFzZSBh
ZGQgQVNJQyBJRCBjaGVjayAgZm9yIHRoZSBESUcgRCBza2lwLiAKClRoYW5rcyEKSGVyc2VuCgoK
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogTGl1LCBaaGFuIDxaaGFuLkxpdUBhbWQu
Y29tPiAKU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAyMDE5IDk6MTggUE0KVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLYXpsYXVza2FzLCBOaWNob2xhcyA8TmljaG9sYXMuS2F6
bGF1c2thc0BhbWQuY29tPjsgTGFraGEsIEJoYXdhbnByZWV0IDxCaGF3YW5wcmVldC5MYWtoYUBh
bWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQuY29tPjsgTGl1LCBaaGFuIDxaaGFuLkxp
dUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47
IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFd1LCBIZXJzZW4gPGhl
cnNlbnhzLnd1QGFtZC5jb20+OyBadW8sIEplcnJ5IDxKZXJyeS5adW9AYW1kLmNvbT4KQ2M6IFll
aCwgRWFnbGUgPEVhZ2xlLlllaEBhbWQuY29tPjsgTGF6YXJlLCBKb3JkYW4gPEpvcmRhbi5MYXph
cmVAYW1kLmNvbT4KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBFTkdJTkVf
SURfRElHRCBjb25kaXRpb24gY2hlY2sgZm9yIE5hdmkxNAoKRnJvbTogWmhhbiBsaXUgPHpoYW4u
bGl1QGFtZC5jb20+CkRhdGU6IEZyaSwgMSBOb3YgMjAxOSAyMToxMDoxNyAtMDQwMApTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogQWRkIEVOR0lORV9JRF9ESUdEIGNvbmRpdGlvbiBj
aGVjayBmb3IgTmF2aTE0CgpbV2h5XQpOYXZpMTAgaGFzIDYgUEhZLCBidXQgTmF2aTE0IG9ubHkg
aGFzIDUgUEhZLCB0aGF0IGlzIGJlY2F1c2UgdGhlcmUgaXMgbm8gRU5HSU5FX0lEX0RJR0QgaW4g
TmF2aTE0LiBXaXRob3V0IHRoaXMgcGF0Y2gsIG1hbnkgSERNSSByZWxhdGVkIGlzc3VlcyAoZS5n
LiBIRE1JIFMzIHJlc3VtZSBmYWlsdXJlLCBIRE1JIHBpbmsgc2NyZWVuIG9uIGJvb3QpIHdpbGwg
YmUgb2JzZXJ2ZWQuCgpbSG93XQpJZiBlbmdfaWQgaXMgbGFyZ2VyIHRoYW4gRU5HSU5FX0lEX0RJ
R0QsIHRoZW4gYWRkIGVuZ19pZCBieSAxLgoKU2lnbmVkLW9mZi1ieTogWmhhbiBsaXUgPHpoYW4u
bGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2Rj
bjIwX3Jlc291cmNlLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9y
ZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jl
c291cmNlLmMKaW5kZXggOTI0YzJlMzAzNTg4Li5jZjg4NjQ4M2UzODAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCkBA
IC0xMTUyLDYgKzExNTIsOSBAQCBzdHJ1Y3Qgc3RyZWFtX2VuY29kZXIgKmRjbjIwX3N0cmVhbV9l
bmNvZGVyX2NyZWF0ZSgKICAgICAgICBpZiAoIWVuYzEpCiAgICAgICAgICAgICAgICByZXR1cm4g
TlVMTDsKCisgICAgICAgaWYgKGVuZ19pZCA+PSBFTkdJTkVfSURfRElHRCkKKyAgICAgICAgICAg
ICAgIGVuZ19pZCsrOworCiAgICAgICAgZGNuMjBfc3RyZWFtX2VuY29kZXJfY29uc3RydWN0KGVu
YzEsIGN0eCwgY3R4LT5kY19iaW9zLCBlbmdfaWQsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmc3RyZWFtX2VuY19yZWdzW2VuZ19pZF0sCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmc2Vfc2hpZnQsICZzZV9tYXNrKTsKLS0KMi4yMS4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwoKYW1kLWdmeCBt
YWlsaW5nIGxpc3QKCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCgpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
