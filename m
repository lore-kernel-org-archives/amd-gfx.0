Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B40CCA9ECF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 03:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2954721D7D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 03:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2954721D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C706E136;
	Mon,  4 Nov 2019 03:41:21 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02AA6E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 03:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZbN+0w92Nf03zCrp/XvBmoEhj8jkTWPsbxHhT7mvzxDSRejiZDoUVfm7aVI+8oaWioWKg1nXjDavnY+n6t12DYUeiD9PA4eQKKg9fhOgPC7xNSVfSyBtfK8bHoR/UCWEypSetHVudHFzyVQSp9PqFM1O3QEk/sCCjaFPqC0ksrA2glFxVymd0uzNEOypLmIBIVhM92YvVU/oSQFF8lUkvBiWtuyki9yotxT2yAPYpq64169IcDizP0PjJkdkKnTTbFSl8cBEJOoWGjKb+6rV2BONf3sf4ltKlmw0oxOko0ynZWNVJrncBK/Ct5psg7/HgTnVNt2/JPiJ2i+JLqHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S28n3vk9rZYo3nxY4VrE7WNnISaCV+LHzM4y4fvx+Ls=;
 b=Y9NvDyl2f3YNyVC9LuQA0vTGH4L5NWuOlTf/EvSNhvZR9Fi+62URm8rkjUcFoHYHLEG304uK2FPpoI1ZI5JU8etP+ctwxose4PrKdRsR2FSoFmKeiE/Ms9ZouItOlv46NOFci4jwFVCnSBpcJ+o4esTGVJg6HHX2qTrmGxFevoj88kIRJMPePTC0C5a1orxyX0GzEsxOekEr9xfUe+UokRAaM6fAKF6jC1+HFggOKB4YN6J/LZKaSYxBuQaS9mpPwcRA9zkj6Nt/iUBZ9s6nEKMQEEaLYxIDFClwJIaT9PzJ3RSb99n/i+nZ7W6+SwgjMA5XNVZTS/WepaTwf3H7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3920.namprd12.prod.outlook.com (10.255.237.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 03:41:17 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b8c3:da4d:83b7:3c3f]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b8c3:da4d:83b7:3c3f%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 03:41:17 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Need to free discovery memory
Thread-Topic: [PATCH v2] drm/amdgpu: Need to free discovery memory
Thread-Index: AQHVkrxwmqiaI+ylrEeYoE3eeQyK/Kd6XSd+
Date: Mon, 4 Nov 2019 03:41:16 +0000
Message-ID:
 <MN2PR12MB3087E540D23C1A98B8269239897F0@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <1572836597-31265-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1572836597-31265-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79e10bfc-4a02-4497-e3e8-08d760d8d943
x-ms-traffictypediagnostic: MN2PR12MB3920:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39208627F3E513CCDD84869D897F0@MN2PR12MB3920.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:61;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(478600001)(33656002)(966005)(6246003)(9686003)(2906002)(74316002)(99286004)(256004)(76116006)(66476007)(66556008)(64756008)(55016002)(66446008)(66946007)(7696005)(52536014)(11346002)(446003)(486006)(476003)(14454004)(66066001)(76176011)(229853002)(86362001)(316002)(102836004)(26005)(6436002)(3846002)(91956017)(2501003)(6506007)(8676002)(53546011)(6116002)(71200400001)(5660300002)(7736002)(305945005)(6306002)(25786009)(110136005)(186003)(81166006)(71190400001)(81156014)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3920;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPAjf44sLw/kPVQGRRRq8OEWKDuaHIGN3/627xgtKLuCFJ7Fp50VQoSevZwYxPOK2iEYkzIelUmVDqX1JXkeA1H2IWTkY0C0l0QaxL8ZrjC2y7M2g3QuDwHBQsKnPlyrT7Pt84+GmHWoiThlBrVQTFZSjwZQZ3jQ4dbnw7TkjZwxh4il5g3Zkt7hBLDaHBki+XB4aGp01woAu5a/tDLjoVUUgi6rycnLzU696kyuNlkokivn9T+hBx5a+PAmIIk8Oua0o2jMJjGDVIXuj3/QvJyjueMeLAnrQpcSNrGDGSMWRzKWdp6fsXj8DgAAyH5unLkW9Li8U23EEgSe4VmkuBeG1DD0upq9nMeUNFJs7rGIO1liyldLv4PV3SjGVrvqW0rRFQVGWhyf6O3odgdSDNPQLOtP/qtKimc0d2bb+Qs+uYdBzsmTW4fICnfNay/G2SYiZmwdcwaURoAi7cdd6JjYluaUlgpJjur/61Mtmlk=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e10bfc-4a02-4497-e3e8-08d760d8d943
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 03:41:16.9152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VlNYJkR3FMG3zrUMakNqHXEOD2Y6/A23ZPZ+8+YyRueWPG6oAmVhLUrM9TPEFBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S28n3vk9rZYo3nxY4VrE7WNnISaCV+LHzM4y4fvx+Ls=;
 b=ycYnUiNptHEm4VXwIJ4lZ5GGd4+YL2xSla6CA/63r27ZiIgX+XaG6nhP9Dn59gC7NBXans269wYF6EAOiufHoGZU0zTA6V+OBsPaUyp1y8JhkwatyfhMEm3aidz4x780ijf1BqRv5ZeAdwvm3SnMC8VUsyRWaclPOO+OcjG4PU0=
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
Message-ID: <20191104034116.wdqvU5TDfcl0XnZc5kDH4SROhztygn9Hul_mAXG-Xb8@z>

UGxlYXNlIHVzZSAnZHJtL2FtZGdwdS9kaXNjb3Zlcnk6ICcgcHJlZml4IGluIGNvbW1pdCBtZXNz
YWdlIHRvIGxldCB1cyBlYXNpbHkgdHJhY2sgYWxsIGRpc2NvdmVyeS1yZWxlYXRlZCBjaGFuZ2Vz
LgpPdGhlciB0aGFuIHRoaXMsIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBYaWFvamllIFl1YW4gPHhp
YW9qaWUueXVhbkBhbWQuY29tPgoKQlIsClhpYW9qaWUKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gb24gYmVoYWxmIG9mIEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNv
bT4KU2VudDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDE5IDExOjAzIEFNClRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogRGVuZywgRW1pbHkKU3ViamVjdDogW1BBVENIIHYyXSBk
cm0vYW1kZ3B1OiBOZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeQoKV2hlbiB1bmxvYWRpbmcg
ZHJpdmVyLCBuZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4KClNpZ25lZC1vZmYtYnk6IEVt
aWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMKaW5kZXggMjhiMDlmNi4uN2NiZTZkOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwpAQCAtMjEwNiw5ICsyMTA2LDYgQEAgdm9pZCBhbWRncHVfdHRtX2xhdGVfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKICAgICAgICB2b2lkICpzdG9sZW5fdmdhX2J1
ZjsKICAgICAgICAvKiByZXR1cm4gdGhlIFZHQSBzdG9sZW4gbWVtb3J5IChpZiBhbnkpIGJhY2sg
dG8gVlJBTSAqLwogICAgICAgIGFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+c3RvbGVuX3Zn
YV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7Ci0KLSAgICAgICAvKiByZXR1cm4gdGhl
IElQIERpc2NvdmVyeSBUTVIgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLwotICAgICAgIGFtZGdwdV9i
b19mcmVlX2tlcm5lbCgmYWRldi0+ZGlzY292ZXJ5X21lbW9yeSwgTlVMTCwgTlVMTCk7CiB9Cgog
LyoqCkBAIC0yMTIxLDcgKzIxMTgsMTAgQEAgdm9pZCBhbWRncHVfdHRtX2Zpbmkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCgogICAgICAgIGFtZGdwdV90dG1fZGVidWdmc19maW5pKGFkZXYp
OwogICAgICAgIGFtZGdwdV90dG1fdHJhaW5pbmdfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cisg
ICAgICAgLyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1lbW9yeSBiYWNrIHRvIFZSQU0g
Ki8KKyAgICAgICBhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1vcnks
IE5VTEwsIE5VTEwpOwogICAgICAgIGFtZGdwdV90dG1fZndfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRl
dik7CisKICAgICAgICBpZiAoYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIpCiAgICAgICAgICAg
ICAgICBpb3VubWFwKGFkZXYtPm1tYW4uYXBlcl9iYXNlX2thZGRyKTsKICAgICAgICBhZGV2LT5t
bWFuLmFwZXJfYmFzZV9rYWRkciA9IE5VTEw7Ci0tCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
