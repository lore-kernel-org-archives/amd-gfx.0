Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41CC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A86721783
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 08:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A86721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73326EA7B;
	Tue, 12 Nov 2019 08:49:55 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680054.outbound.protection.outlook.com [40.107.68.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3B16EA7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 08:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov/jfjQs8LdJhmaf6CxT5x3dKO1GDnplg6PdtUORDU8FESfg9LGEuCRbg8bx42N/mpPi0QPX+IEsiLilENgi+G+CmqCtbJEFFkNqgPX3l7F5RxMdV2tGK6NmzTLrd3yOCtYrCpJt+IevgOefsGJDhZZWUa9NqBQLn/v6sJ/qAlB1vigGSVR47cFT9onvwU2Stp8T6hsxAzwBrBcisK4YtxsYRwzCwySTT4cOl7dkE7sjhOb7O3SeyXpt26Lu2DcpD6nunfCmEFe0X/0FPvFF71UQwKc6nZL8KBlLwBujKbT+Q2X1i7HykgRT95/yFDhX8ftjoLADahKawNbTlrnc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I0It1ppcipV1EB7TmaT7nEft5IX//kzqiTUvP1G9Nw=;
 b=I8lGATLzCFI1l8p9QD1pmJ58kQBhJxw3+NRVHwjZm1vECTylbqS3wcoxmoUPRSjzpskrGK0E6QA2IWwDk6kWbkGliHOv+uffckDRnR7xtRP802GSaEsMDvl3t4iMPMd1s2BiGoF6KqWoKyWhsBlT6P0vXHl+IvTZ5zfBSgkTjhI4tJfmd088z88lXMawvOOgq2DjsyPTRXe0HCzS7TpEIu8wFB7oLYa4EcNAtX33SsudpM0jekegv/YbA3puCey6cPFGfqv3Sm+LHUthrZjVs1I4ucdxCk1+2yQgfyYcN3bdkf82+xTHuyQXmW8L+iZhYEW30STfOMa7uhOtevmrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3853.namprd12.prod.outlook.com (10.255.236.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Tue, 12 Nov 2019 08:49:53 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::111:5294:f151:3846%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 08:49:53 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: issue BTC on Navi during SMU setup
Thread-Topic: [PATCH] drm/amd/powerplay: issue BTC on Navi during SMU setup
Thread-Index: AQHVmSOjtTUyE6W/rEKDzc8u8K3e0KeHOecw
Date: Tue, 12 Nov 2019 08:49:53 +0000
Message-ID:
 <MN2PR12MB3598B198EB87A7C5E942F0B08E770@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191112063654.5360-1-evan.quan@amd.com>
In-Reply-To: <20191112063654.5360-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2687ab21-f498-41e4-c40c-08d7674d495a
x-ms-traffictypediagnostic: MN2PR12MB3853:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3853AC9E05909A6EA564B9DE8E770@MN2PR12MB3853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(13464003)(316002)(71200400001)(71190400001)(52536014)(6246003)(8676002)(2906002)(5660300002)(66574012)(81166006)(81156014)(6116002)(3846002)(486006)(8936002)(86362001)(2501003)(229853002)(55016002)(6306002)(9686003)(102836004)(66946007)(4326008)(26005)(7696005)(53546011)(6506007)(76176011)(99286004)(66446008)(64756008)(476003)(11346002)(66556008)(76116006)(446003)(186003)(66476007)(110136005)(66066001)(14444005)(7736002)(256004)(33656002)(6436002)(966005)(478600001)(305945005)(14454004)(25786009)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3853;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvPHJKxjjkRhemuJho0I53KuulIf1A4wTHpI3ixKzFygml/eOsqYubjcjonSpAArQFZATl31O76+fLpXf19HOQiCJtW5U4cSfNaT/pBzqFFcGJiMoU8MSqw7rGvxSg5OXE15VVMELIpzvnEikhf+DFP3kApEOsvabUah0/zk1JBGSKVBPWCcsZRZic9n0PpKeaBBYu1H66lizHi9nEl2N+lLjIWgXOQbTpLcVuTN+CBOfoHykfZX2LQU8T17b71RS0JHZ+vquFrgPVeVUgGkPmPyksdO4EL2mR4EeUwemWeP6/5OqVCYCUI3KkepIdTSaewzahmKK7yG9Qbo6gaUlHjRBU2ayN35BwYSe0snFIe6rvoGh2JuZ8bS4Jt9H9pTyeFZwbEvpVpgkqqrM6GEquVRg41628I1x4/v9pHczW5ZaejLxAZ1XDzGsoAdSp2BfxM4gM10A6PMsx6fTB8BvcnML4guMfVGd3PHihIiWm4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2687ab21-f498-41e4-c40c-08d7674d495a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 08:49:53.5993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ2LqBVr1pJBqdFfC+Z3aM59Yfa7Fdlxs2goMlWqQ1vMTCsPizIKy5oTQMZPKAEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I0It1ppcipV1EB7TmaT7nEft5IX//kzqiTUvP1G9Nw=;
 b=pVeVRhDL7tEpHMwBlZLDaHfLN4krkTfcUkp48QhDUKOIbabnGGTGN9jk7prxSsl9XSn5XPBX/nAagGZO9sNTxAtA+x8giQxdPBeARbC8cpg1Q5kEIY5fX12WKNSJq/cvfnJkaFrNy7ChHKw2E2VGvC1suOCDtP5mrrRjuPoHKXU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112084953.CWy9ID7v6wDR3MzP0Mqw_nOya8_vBYVAUZD4rO2aI_0@z>

UmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBFdmFuIFF1YW4NClNlbnQ6IFR1ZXNk
YXksIE5vdmVtYmVyIDEyLCAyMDE5IDI6MzcgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KQ2M6IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kL3Bvd2VycGxheTogaXNzdWUgQlRDIG9uIE5hdmkgZHVyaW5nIFNNVSBzZXR1
cA0KDQpbQ0FVVElPTjogRXh0ZXJuYWwgRW1haWxdDQoNClJ1bkJUQyBpcyBhZGRlZCBmb3IgTmF2
aSBBU0lDIG9uIGhhcmR3YXJlIHNldHVwLg0KDQpDaGFuZ2UtSWQ6IEkxYzA0YjQ4MWVkMTRkNWYx
MmMyMGI3YjBkNTkyYjYyYTY1ODg5ZTRhDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jIHwgMTEgKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3Bw
dC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jDQppbmRleCAw
MTBiZTIxYmVlNWIuLjQzM2FjYjBmNDU5ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvbmF2aTEwX3BwdC5jDQpAQCAtMTY1Miw2ICsxNjUyLDE2IEBAIHN0YXRpYyBpbnQgbmF2
aTEwX3VwZGF0ZV9wY2llX3BhcmFtZXRlcnMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogICAg
ICAgIHJldHVybiByZXQ7DQogfQ0KDQorc3RhdGljIGludCBuYXZpMTBfcnVuX2J0YyhzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSkgew0KKyAgICAgICBpbnQgcmV0ID0gMDsNCisNCisgICAgICAgcmV0
ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUnVuQnRjKTsNCisgICAgICAgaWYgKHJl
dCkNCisgICAgICAgICAgICAgICBwcl9lcnIoIlJ1bkJ0YyBmYWlsZWQhXG4iKTsNCisNCisgICAg
ICAgcmV0dXJuIHJldDsNCit9DQoNCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3Mg
bmF2aTEwX3BwdF9mdW5jcyA9IHsNCiAgICAgICAgLnRhYmxlc19pbml0ID0gbmF2aTEwX3RhYmxl
c19pbml0LCBAQCAtMTc0MSw2ICsxNzUxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwcHRhYmxl
X2Z1bmNzIG5hdmkxMF9wcHRfZnVuY3MgPSB7DQogICAgICAgIC5nZXRfZHBtX3VsdGltYXRlX2Zy
ZXEgPSBzbXVfdjExXzBfZ2V0X2RwbV91bHRpbWF0ZV9mcmVxLA0KICAgICAgICAuc2V0X3NvZnRf
ZnJlcV9saW1pdGVkX3JhbmdlID0gc211X3YxMV8wX3NldF9zb2Z0X2ZyZXFfbGltaXRlZF9yYW5n
ZSwNCiAgICAgICAgLm92ZXJyaWRlX3BjaWVfcGFyYW1ldGVycyA9IHNtdV92MTFfMF9vdmVycmlk
ZV9wY2llX3BhcmFtZXRlcnMsDQorICAgICAgIC5ydW5fYnRjID0gbmF2aTEwX3J1bl9idGMsDQog
fTsNCg0KIHZvaWQgbmF2aTEwX3NldF9wcHRfZnVuY3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUp
DQotLQ0KMi4yNC4wDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
