Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2565C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 04:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E37B21739
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 04:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E37B21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEAE6E10E;
	Tue, 19 Nov 2019 04:14:00 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720043.outbound.protection.outlook.com [40.107.72.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B1A6E10E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 04:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwFzv3tscrp7ubdu4M9yZeqJE0xj+yTTJiRH6kXnvIIEx7jBpkhyt1b7sTS/Ewe3q1IUr5jNUrGXiQPeIzGCT+alzsY4rK1Ef7qrNLavQZW0NNaZjibzRnBX3lIGyPicBQyF4M8v3cs0CkCWXlQoLuLGcOLZ248CbeIPz6aXnOa1z/6KRPMHFaRFb0ntky9IRMiulMKzZfNywgDfwf6AR3uBjfDXQn+b3PCTSBAFIKbxSpjRwYj9DNHLsoM34zVFF5ukeD7Y6jfEVRfFz24gMNt0SaBfESI4UZWQkADjWAM0ZU43wG93arQTvWPOPcu89Yem+XtmchhEKAxu2jTFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hghnS0tQdwPfOlhux1NCQQkhBcpZdCMDEb7wmUW+Wlw=;
 b=UBUF7kfSZRLOZoy02I/IhYhTSRxDVxKpYSU8CwwwlJuKv4754ZLWM0IzKG6spoR5BNPvFdIwmrEPZ/i3j4vqlrz7TA5x0+42xOwq7rL/jeL3Vnr9u+zPU5Iqc8oBJrV5vFTWSaXQ7C35VztIKIdobmZNg1sk7Nbx7g0IFoHDTR0B+apFPOPmr2hU2A1G2GGCW6qW+nb8w+Ocnw6WvWmN01JMNhm86Z3ENqTPeusmFife5UDrrXLF+km1Rb/3xh9gwTgjVwd8PZCmrGIgc7Ri6jEAXRN8vce4KvROcHXK52yivc8Sj7JY48Uxipb7Ihr7Skqnopffoex+apS4D8lvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1833.namprd12.prod.outlook.com (10.175.90.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 04:13:57 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 04:13:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: add missing header file declaration
Thread-Topic: [PATCH] drm/amd/powerplay: add missing header file declaration
Thread-Index: AQHVno1/ZuSAZhm/r0yQvXC9+i5FsqeR4lTw
Date: Tue, 19 Nov 2019 04:13:56 +0000
Message-ID:
 <DM5PR12MB141874B82D1012E250A09F63FC4C0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191119035712.22785-1-evan.quan@amd.com>
In-Reply-To: <20191119035712.22785-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68dc48df-b989-4e3e-39fa-08d76ca6e5b3
x-ms-traffictypediagnostic: DM5PR12MB1833:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18339215EEAABE6EC1465638FC4C0@DM5PR12MB1833.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(13464003)(189003)(199004)(5660300002)(8676002)(52536014)(14454004)(8936002)(478600001)(81156014)(81166006)(966005)(6116002)(3846002)(316002)(86362001)(2906002)(66556008)(110136005)(25786009)(66946007)(66476007)(66446008)(99286004)(54906003)(33656002)(64756008)(7736002)(305945005)(9686003)(102836004)(6506007)(53546011)(446003)(71200400001)(66066001)(4326008)(71190400001)(74316002)(6306002)(11346002)(14444005)(256004)(26005)(186003)(55016002)(486006)(6436002)(229853002)(7696005)(6246003)(2501003)(476003)(76116006)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1833;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGb++O4mW6456/tG6Ff+xg+VHge6e/LkXlLWNIwlGxR0aaiI7tiEom4hG4fKQz/LWDmdlUI5Vde2KkamUM5Ouw9FkUYy73TtSWdzL7+tW8HF6TyP6lKabc3pbgdedYc/hxKHEXJJEXcblVsNfX4TAizWyynPlK7yTXflz4DrHSmFBiggP/0cNNpPZM+EI7SLVZYK9pOW6ttLw/ZauRkSCiefbbIKJH/v9MtBhcUNcadrfjCrWdu9X9RKh3i5AALB+xKnhPUD/K8+u3EmHIjrvBrcUETi2nBxRL78qWzbgFT5GaWYg/BWbtl9GbFTpw8jj941J3/MawAxvziUdYtBYrrp+UcCQ/ieq1+M/7usiTsG4zSUs17FtVxqOIGt+1ZRhOtGq+jVinD72vJRQgQkYQTG7FVsUrMnQwA/9DyPjT7TpDuoWvuQrwNc+VYfsS+PSoNNeiGodUHq4KtN61OQ042vHg47ID1O2/Tyb47Ydf8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dc48df-b989-4e3e-39fa-08d76ca6e5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 04:13:56.9833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJxj6cgB4cmGhQUyhDyutL7USULe9CZJdtsobkw1x0sRdHlWNphFtsv97NgGq1K7zCE8/rJb25WTGxf/pRy69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hghnS0tQdwPfOlhux1NCQQkhBcpZdCMDEb7wmUW+Wlw=;
 b=TGJUjGpyQqtQ41aLE6nHGUfuwwYPQumV8N3912DhbLMU5c3wer63cYCEUaF11wVNPILe22afsbBlEuE3yFyd3UIAaZpCpyq+ZSu2VlKDF/+XqXaBZF2l+7OGnnsperP9gqjDcnFRLmrveL2Fw570OcUsZtwaLprmYUyijiz4CjM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119041356.tIOSLznUWxhm6L5edQ0QSfqEzAJH1mjZcGyEyZPWAJc@z>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRXZh
biBRdWFuDQpTZW50OiAyMDE55bm0MTHmnIgxOeaXpSAxMTo1Nw0KVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBMaXUs
IEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wb3dl
cnBsYXk6IGFkZCBtaXNzaW5nIGhlYWRlciBmaWxlIGRlY2xhcmF0aW9uDQoNClRoaXMgY2FuIGZp
eCB0aGUgY29tcGlsZSBlcnJvcnMgYmVsb3c6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9wb3dlcnBsYXkvc211X3YxMV8wLmM6IEluIGZ1bmN0aW9uIOKAmHNtdV92MTFfMF9iYWNvX3Nl
dF9zdGF0ZeKAmToNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9zbXVf
djExXzAuYzoxNjc0OjI3OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g
4oCYYW1kZ3B1X3Jhc19nZXRfY29udGV4dOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1k
ZWNsYXJhdGlvbl0NCiAgc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2Nv
bnRleHQoYWRldik7DQogICAgICAgICAgICAgICAgICAgICAgICAgICBeDQpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBsYXkvc211X3YxMV8wLmM6MTY3NDoyNzogd2FybmluZzog
aW5pdGlhbGl6YXRpb24gbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3Qg
Wy1XaW50LWNvbnZlcnNpb25dDQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBs
YXkvc211X3YxMV8wLmM6MTY5MjoxOTogZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRlciB0byBp
bmNvbXBsZXRlIHR5cGUg4oCYc3RydWN0IGFtZGdwdV9yYXPigJkNCiAgIGlmICghcmFzIHx8ICFy
YXMtPnN1cHBvcnRlZCkgew0KDQpDaGFuZ2UtSWQ6IEkxMjQyZTY0ZTgyNzE1Nzc0YjhlMjkzMTUz
MDc0OTc4MmI5MTA3ZTMyDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCAx
ICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCmluZGV4IDhiMWM0MTY0YTFmNi4uZjY3Nzc0M2NiNTEx
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQpAQCAtMzcs
NiArMzcsNyBAQA0KICNpbmNsdWRlICJzb2MxNV9jb21tb24uaCINCiAjaW5jbHVkZSAiYXRvbS5o
Ig0KICNpbmNsdWRlICJhbWRfcGNpZS5oIg0KKyNpbmNsdWRlICJhbWRncHVfcmFzLmgiDQogDQog
I2luY2x1ZGUgImFzaWNfcmVnL3RobS90aG1fMTFfMF8yX29mZnNldC5oIg0KICNpbmNsdWRlICJh
c2ljX3JlZy90aG0vdGhtXzExXzBfMl9zaF9tYXNrLmgiDQotLSANCjIuMjQuMA0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5n
IGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
