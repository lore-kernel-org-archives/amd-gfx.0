Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB7BC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AF0206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AF0206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974B06E182;
	Wed,  6 Nov 2019 06:28:42 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB24C6E182
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duu2n+bBmiZn6kWoxY+1NS0jKufyVR17apq4OIKfgNny6HVvjTZhfpxq0G+uqDNvFatNYz4SBZWiqYI4Ey1Cz0WsV6Z4WAokrKxnvDihuKOWY/OyE4z8tPMcbAQuL4KiuNaoPiL+RjdE6SofSZomjXld0dR843PW0z8O0Y7M4uV7a+VhdWBKim0qsBOmgbJO+BenLgUMO0EZwqBg6gM11wsorvE/bLVs4VLxTrwmMfo+TAtjHjE/sHNzX4Kn8KL/nTFS204zkwtZ0jkKImNxHsNUa+3l1cwHfhlLabC+jrUG4WdgZE1Hp1Ox07bE3YlnMdNn9vIFMtrvswADHRvgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZOmF9kZMFdm3mpi+1YSSurIi95pxa3fId2jRt0lCgg=;
 b=Nsg3NRYolLYCvWlhartzENfrXcSx2CuV6ob946J/sx7dL2HLnDnBFg1HUhCdOpBJbWAHubuuBPNWwNrSHZ9MnDUlgQRGPpOFRHhzpBsJB00oAu/5xQot64nXrvYGMY1OhN5Lb0druxzn2IwN5EUB6rUiqXDusb2QMLR1Cw3QnZ+NrdCR4LmjIgdrUCS/eUBY3JWKdoBY5Z8ZfMmixvXcWXLWq9zKx6zI80z2FyiSqevXS2xtsz0DoLWoWpqKkcjqY4O+z+esxt1us4sGuoSB4846L4FSSzFuRVFl23awtOhq3XTreofQXHXqsf7Z+8nAeyA9ow04ZoTHjFee7V8ttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 06:28:38 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 06:28:38 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Topic: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Index: AQHVlGrBJT+Rb0LvoUyv2c5IYs5XAad9rdGQ
Date: Wed, 6 Nov 2019 06:28:38 +0000
Message-ID:
 <MN2PR12MB2975A3DFE6CCED7BB3D6D2748F790@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bf68280-b8db-4481-8ba0-08d762828f25
x-ms-traffictypediagnostic: MN2PR12MB3088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3088EA4C6F85131F9A4154C68F790@MN2PR12MB3088.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(13464003)(199004)(53754006)(189003)(256004)(66556008)(110136005)(66446008)(66476007)(64756008)(33656002)(76116006)(316002)(6116002)(6246003)(6506007)(2906002)(26005)(229853002)(2501003)(76176011)(66946007)(102836004)(8676002)(52536014)(5660300002)(55016002)(3846002)(6436002)(9686003)(7696005)(14454004)(186003)(8936002)(14444005)(476003)(11346002)(446003)(486006)(71200400001)(25786009)(478600001)(74316002)(81156014)(66066001)(81166006)(7736002)(86362001)(305945005)(99286004)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3088;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zxh9xrnyn27WdcAjSc5K3kKtqVNoyZeDuA68zV21Vh4WE6FZX626b+q5aVVHTyQVz3YEP1MYHbexzulbgLqPtnsF4RO8jrNo97Sw1TzSEB77Kpl8rCtl53s3LaT65v412BN+nCpjXxFc0hEw431+wWNB/lbW5VI+Rq0/NrqxH0+Pg9B7rHtXv+lgbS/N0gtMB/7FjYICwzcYFDe7gZRVZDhM0XT97U/Ac6qpNMui+tfNTtpJYtNvOxxotewv0UC79yHddUMlAFl7s5yuA7SkF49kuEmCw/gvV2pDlYz6tzduui5AOWDcEjoIJLuSuFVV9dAEHmI4MzfufFqMrACGKQyzlIWVY/bzMh6TqT0dzY4nc83O4C27Fsyc4wg9abWDVEEjcIdu8M57vScSsSFKHrJuR3e1d20/2wya4JZiDj0QNk/vVjIQefltmpv5R0X
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf68280-b8db-4481-8ba0-08d762828f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 06:28:38.1348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ5VHXxD7PH2imRmlHkBLqD2q4SsduzCqtEiEeok/KrPcV8vDXqrdQ+CWu2rmKC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZOmF9kZMFdm3mpi+1YSSurIi95pxa3fId2jRt0lCgg=;
 b=CsD0rjNIeaLnjz084RrODpVcE2y2i+tsRp7XdkZA/3Q7ddFKmAW/3qDSiNDXh7ybY2a5RDE0CuQlM3hKgep1GouzPoyAkaMzMna/cLNI7Jl0IIYcwe1FenAVDt4IJ337m/m9oSR47GR36Ol/G++cQAo4CzkriTnjEgMnzDFqs3c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
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
Message-ID: <20191106062838.rh2fa99kHnuwi1K5h2KDcKRNo50TV1prZvDKrNm5Xuk@z>

SGkgYWxsLAogICAgUGxlYXNlIGhlbHAgdG8gcmV2aWV3IHRoaXMuIFRoaXMgaXMgdG8gZml4IGRy
aXZlciByZWxvYWQgaXNzdWUuCgpCZXN0IHdpc2hlcwpFbWlseSBEZW5nCgoKPi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj5Gcm9tOiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Cj5T
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDYsIDIwMTkgMjoyNCBQTQo+VG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj5DYzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT4K
PlN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogTmVlZCB0byBkaXNhYmxlIG1zaXggd2hlbiB1
bmxvYWRpbmcgZHJpdmVyCj4KPkZvciBkcml2ZXIgcmVsb2FkIHRlc3QsIGl0IHdpbGwgcmVwb3J0
ICJjYW4ndCBlbmFibGUgTVNJIChNU0ktWCBhbHJlYWR5IGVuYWJsZWQpIi4KPgo+U2lnbmVkLW9m
Zi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+LS0tCj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgMiArLQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj5iL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pcnEuYwo+aW5kZXggNmYzYjAzZi4uMzBkNTQwZCAxMDA2NDQKPi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwo+KysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2lycS5jCj5AQCAtMzExLDcgKzMxMSw3IEBAIHZvaWQgYW1kZ3B1X2ly
cV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+IAkJZHJtX2lycV91bmluc3RhbGwo
YWRldi0+ZGRldik7Cj4gCQlhZGV2LT5pcnEuaW5zdGFsbGVkID0gZmFsc2U7Cj4gCQlpZiAoYWRl
di0+aXJxLm1zaV9lbmFibGVkKQo+LQkJCXBjaV9kaXNhYmxlX21zaShhZGV2LT5wZGV2KTsKPisJ
CQlwY2lfZnJlZV9pcnFfdmVjdG9ycyhhZGV2LT5wZGV2KTsKPiAJCWlmICghYW1kZ3B1X2Rldmlj
ZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkKPiAJCQlmbHVzaF93b3JrKCZhZGV2LT5ob3RwbHVnX3dv
cmspOwo+IAl9Cj4tLQo+Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
