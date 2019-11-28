Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5CC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5952051A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5952051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7BF56E5EC;
	Thu, 28 Nov 2019 02:21:33 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800075.outbound.protection.outlook.com [40.107.80.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FE86E5EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFwLnLCBUAS/TgKQFxXkCZT8MO/XeQJ1VF1Z3VMqJE3Pb7CGXAudK/qjEBuRK2qKgxqpNMefaP1qx6yJPEBwQWc/F+QlO2gLGhBKy+Gnpa6vPAS0LVA8+/3jsCSE9XUBpaYvnpwMci8RErAIAuVqDXwMX9TtKOaf3fNwQMy1524fUH7zxf+ZOKH1NvGoXb0+Av24y4xT1UdA+4iNPK0J1HxYf0+RoUpAN63PvJ63HbarG7B7dlcFR7Lb35Jt1S4CbIZ9wGHjmdlMkhcUw22KEoV4pTnbegSb2zRUG5g1WkTl7wM+NzDrc+q+IODMeTzyrJr6aTj0RuvPiSqBh5Esuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1somLRSx8FBkFUTgRF+Gz2uJX42mPDWPbh/3i6qGw=;
 b=BOzcFO3pN1eFbr6KMrL4ctxyvvmbnWfm0KCAbWPQzfnTu1IHjHKlukK4uoU4AxlH1pAa2yttA2iX5eNGlr7KbCJcBtPCf9rDG5vzbZY3fadMcaFmCGAcWfyh8juSpxZSNUh6ImBlw7w9ZE+cbz1n68/aOeF2NF8+FfagDTAvGmfsjyGU090MaCOl4KuwC/FF9yQOYtDk2nkwBxP+FjaYkck+F2sOAfLrcZrvJuVl3ypfBseOMQqEcxal9u0dDqvnVicP2BT+Yr/Yb1OTOQKxbid+F7St+vuAbSQIvLTwhbA2wTmrYfxo15gOw+SFjxBD52QM7PROXO3RAj94wxQrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:21:31 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:21:31 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Topic: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Index: AQHVpE+6OFp3RqEVEU2buxGtwbSBnaef3G9w
Date: Thu, 28 Nov 2019 02:21:31 +0000
Message-ID:
 <MN2PR12MB393364068B1A041D93BC826D84470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 088a8ebc-259a-4b9d-c898-08d773a9aede
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-microsoft-antispam-prvs: <MN2PR12MB4256633858BE94EA175F80A484470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(5640700003)(6506007)(11346002)(229853002)(6436002)(66066001)(53546011)(9686003)(5660300002)(55016002)(6246003)(99286004)(446003)(316002)(86362001)(26005)(52536014)(2501003)(186003)(14454004)(33656002)(2351001)(2906002)(256004)(76116006)(3846002)(6116002)(478600001)(71200400001)(71190400001)(25786009)(66946007)(6916009)(64756008)(66476007)(66556008)(66446008)(81166006)(8936002)(81156014)(8676002)(14444005)(102836004)(74316002)(7696005)(76176011)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ci8yQPJrTlu6zECbQbpsHSnV5XFF48x5xTsgARwat2XZWaepDt9dFIlbtYpeHjjY9sfhmWwyfLvtkfat95k3jcAzWwLbV1s+yznMG00eYW/820w+NqpOU33elWCl8OKijeZHeZV0mbXzb8CxiK7qM+vCXnzT/nF6Jdo2MaYJNW6MOhE8Zhv8l3on1KFng62VB6kyrv09Ad/srPXRysP9cvD9Ix8ctXmQFLMcAhGuJcrwU/Hob9Wp5o20FbIxaxcdGYJMO8xOXg3NKoaspiJHLRFmZeDkx3XIVjyMqgekKyacCKp0JAWF2SLuiuWheBzYaoeMj9tbXK5Zea2tfRofiXJg0qFxBIUcivRwRf7QDG79IJ5T2uH5DCiZvW0HSayLJuis+sQFUfURcKEug65f/sBHnco3dki73w6/ClbrsIW+TwVqmrYb3DfOZuYmD/D/
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a8ebc-259a-4b9d-c898-08d773a9aede
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:21:31.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckXbqJ4BDn3p8V55vrlurtbcGN4En3Ef/aZmXfekZ2M4PBnPtLDCvU4+bIF8WSim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1somLRSx8FBkFUTgRF+Gz2uJX42mPDWPbh/3i6qGw=;
 b=z8wRkm/HgBB1/GXrqEQ4hkQjnholdTcUcIBVwEPGL+bbRf1OT1tnWsjM/lKiiTFWOXhDqAK3JYoKUGQMzKTqkYiCxPUHHULUnMvGqgUsb3dTF0cJPD6FZeJfZxRJcMGaJhitBCDXzEXsM+FNQXbv7OZvufFg1bsVB4vGOueA09Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Message-ID: <20191128022131.E1Pks2giqX5WBXPEnLNXOy3VrtBTUfeh-AR_UjnaosM@z>

cGluZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk1vbmsgTGl1fEdQVSBW
aXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9t
OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4gClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI2
LCAyMDE5IDc6NTAgUE0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBMaXUs
IE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSCAzLzVdIGRybS9hbWRncHU6
IGRvIGF1dG9sb2FkIHJpZ2h0IGFmdGVyIE1FQyBsb2FkZWQgZm9yIFNSSU9WIFZGCgpzaW5jZSB3
ZSBkb24ndCBoYXZlIFJMQ0cgdWNvZGUgbG9hZGluZyBhbmQgbm8gU1JsaXN0IGFzIHdlbGwKClNp
Z25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jCmluZGV4IDk2YTZiMDAuLmI2NWZkYTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKQEAgLTE0OTAsOCArMTQ5MCw3IEBAIHN0YXRpYyBpbnQgcHNwX25w
X2Z3X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJCQlyZXR1cm4gcmV0OwogCiAJCS8q
IFN0YXJ0IHJsYyBhdXRvbG9hZCBhZnRlciBwc3AgcmVjaWV2ZWQgYWxsIHRoZSBnZnggZmlybXdh
cmUgKi8KLQkJaWYgKHBzcC0+YXV0b2xvYWRfc3VwcG9ydGVkICYmIHVjb2RlLT51Y29kZV9pZCA9
PQotCQkJQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1RfU1JNX01FTSkgeworCQlpZiAo
cHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQgJiYgdWNvZGUtPnVjb2RlX2lkID09IChhbWRncHVfc3Jp
b3ZfdmYoYWRldikgPyBBTURHUFVfVUNPREVfSURfQ1BfTUVDMiA6IEFNREdQVV9VQ09ERV9JRF9S
TENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pKSB7CiAJCQlyZXQgPSBwc3BfcmxjX2F1dG9sb2FkKHBz
cCk7CiAJCQlpZiAocmV0KSB7CiAJCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gc3RhcnQgcmxjIGF1
dG9sb2FkXG4iKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
