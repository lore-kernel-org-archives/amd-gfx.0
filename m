Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD964C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A48F2071B
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A48F2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7DF89C1F;
	Mon, 18 Nov 2019 09:50:50 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730041.outbound.protection.outlook.com [40.107.73.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B3789C1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 09:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SywKZr11hscSHfkkGMXlEBVK8R3XvfJQTcTu4137AWS1WgRUNFhTwzWD2Etro9vMtVQSTkWGWv+YKwV0ZyIqS96nEfWg16EXIoOLMSlnfwNhSUKAt1bW56QcR8WSKWdCVSKSiJWb+D6VSqeO0yPIw4RXRvRx4l2pGk0qg2peuM199iK00jAFdu9+Mp9hW+hW/PL1HqQCA1sJ8Nt/rJUkikn2J4GM5XYc2DErOrGbVtdOAYm3O9RMWh7hjdUHxeqwA9zC2+aGNy9xqCTie6k1z3AoYAicVCSVzayHPP1IMdwktTd4U7iTzaGK3bO+POnSCubl1lSuk/1fLfhjtT33aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8qjmlMyFVj2FWwO7X5wynFhC7KfXZMRcG9w5zzgE8o=;
 b=hgBm4eVih5b9mCGQWd0f79k+tdm8gK9xt9HHqqZbSoP6OSE0vZV4k/6tclAF0Li/7Qmf3UOaDPdIVL8bXs33rw+zjEHRKa2SrpjF6zJQhtrSj2GS1n2chd4zcudG/iGxM0p0lKYwpKGdYJcMRz0Odapnl0+iYT/yfrrJhTByMBstQOcw3nkORUC3594A9ewvggd9rbczmqAB7v//Hb0LFJYvlmnh3Lz3GjsX8Px2mxoHBSu/pSfloqsTM8o3rX3qpO6Pv3oJjiw3E5o3OGvN0XcHb/R4GVsn9TygwF3FTE6pZuYOXmubeAZhvXmwsZHxvToYL26EmKyOhGHaEOEF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5SPR01MB01.namprd12.prod.outlook.com (10.167.107.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 09:50:44 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:50:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: add Arcturus baco reset support
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: add Arcturus baco reset support
Thread-Index: AQHVnfF7JpbNKrKBx0GBu6yAQAm4xaeQr0og
Date: Mon, 18 Nov 2019 09:50:44 +0000
Message-ID:
 <DM5PR12MB1418A9E4BEDD3B3D07176F8DFC4D0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191118092019.11127-1-evan.quan@amd.com>
 <20191118092019.11127-2-evan.quan@amd.com>
In-Reply-To: <20191118092019.11127-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56e1c33f-d11f-4542-d184-08d76c0cc7d2
x-ms-traffictypediagnostic: DM5SPR01MB01:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5SPR01MB01EE2737CFF8978465C914FC4D0@DM5SPR01MB01.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(13464003)(199004)(189003)(25786009)(9686003)(14454004)(6306002)(966005)(55016002)(476003)(71200400001)(66476007)(446003)(71190400001)(99286004)(478600001)(6246003)(11346002)(76176011)(305945005)(14444005)(7696005)(7736002)(486006)(6506007)(256004)(8676002)(26005)(81156014)(81166006)(3846002)(6116002)(76116006)(74316002)(2906002)(186003)(4326008)(102836004)(86362001)(2501003)(316002)(53546011)(8936002)(66446008)(110136005)(64756008)(66556008)(229853002)(5660300002)(33656002)(52536014)(66946007)(66066001)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5SPR01MB01;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zW9Fk1QGxvjn2VnqCLpgXkWESCeUEIo5bcDrPrPGRAIOsnX+Kpkrl3IPcfOvhwCOlVAdtOHF/bghF6jNc42lV5lg3sPDeXXZ8z8d3W2wGxlwSGUSgXvtRgSr2g/tJVG8AvUsaoj4EnXEE1uxXr7m1mIWO+TLpO8WXr6nFoo9a0LAyibFfe4KizLXk8kC90fJQtVum2SCfYaY9ojyod66Q/gBuy2b26gPHQ3LH3PSOIe8m8O1/IO7qwT781ANLDP+f513kN/bErwetyoWhvQhYJKPIp0E/y3rjVzvhVayofLaMii6lMU7cDx5Umrko9fsZyNHlLhQlj3rGC1udMunqw/HAuFskYE0ct/TcesV+Uzbj6B7biiFzHii2C6hWJSJjni0b55J0KAkG7ChbRaMe3nC1Uus37W3hu9BNXhDxZwu6HcaPJ9nsMbRxCxvPv/4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e1c33f-d11f-4542-d184-08d76c0cc7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:50:44.3074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98AftzJLyWLHWGgQs8V+kUXH9XXdsW0tfRjzSQOP/PNBrXEsOSKNEO7Es8tUyGE1AeCX2JzQVu/9ZOK4A+kADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB01
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8qjmlMyFVj2FWwO7X5wynFhC7KfXZMRcG9w5zzgE8o=;
 b=NrF/fIBCMPUZr4CYO/qrYIh2g97E+rroKn6LJ/ThRGOP4nL8uRQBnbbuLOxZAT5VLkQXf+tqB8vWYL4XQQ0OdWeUm0tWyACGAT1pPwKKw95hfihxZJWMHlCh2xQiZ/koJ4BC33/oqixAfOoj8MyP0G0b3T8lVtIrPk/HJOmW/7c=
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118095044.kdl12-14m5FLluzTB9zlEVh5kSuimrQgPxuJO0WJf_k@z>

U2VyaWVzIGlzDQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBFdmFuIFF1YW4NClNlbnQ6IDIwMTnlubQxMeaciDE45pelIDE3OjIwDQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1k
LmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgQXJjdHVy
dXMgYmFjbyByZXNldCBzdXBwb3J0DQoNCkVuYWJsZSBiYWNvIHJlc2V0IHN1cHBvcnQgb24gQXJj
dHVydXMuDQoNCkNoYW5nZS1JZDogSTdiNjkwMTZlZTBkMjM4ZTBmY2IzMjNhYTEwMjE1ZTI5OTI0
YTZjYTYNClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jICAgICAgICAgICB8ICAxICsNCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyB8ICA3ICsrKysrKysN
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyAgICB8IDE0ICsrKysr
KysrKystLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCmluZGV4IGIyNWU5ZWNhNWQzMS4u
ODZjZmVlNTI4ZDNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KQEAgLTU2NSw2
ICs1NjUsNyBAQCBzb2MxNV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiAJCXJldHVybiBBTURfUkVTRVRfTUVUSE9EX01PREUyOw0KIAljYXNlIENISVBfVkVH
QTEwOg0KIAljYXNlIENISVBfVkVHQTEyOg0KKwljYXNlIENISVBfQVJDVFVSVVM6DQogCQlzb2Mx
NV9hc2ljX2dldF9iYWNvX2NhcGFiaWxpdHkoYWRldiwgJmJhY29fcmVzZXQpOw0KIAkJYnJlYWs7
DQogCWNhc2UgQ0hJUF9WRUdBMjA6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
cmN0dXJ1c19wcHQuYw0KaW5kZXggNThjN2M0YTMwNTNlLi4xYWYwYjFhYjZmNzAgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMNCkBAIC00OTUsNiAr
NDk1LDcgQEAgc3RhdGljIGludCBhcmN0dXJ1c19zdG9yZV9wb3dlcnBsYXlfdGFibGUoc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUpICB7DQogCXN0cnVjdCBzbXVfMTFfMF9wb3dlcnBsYXlfdGFibGUg
KnBvd2VycGxheV90YWJsZSA9IE5VTEw7DQogCXN0cnVjdCBzbXVfdGFibGVfY29udGV4dCAqdGFi
bGVfY29udGV4dCA9ICZzbXUtPnNtdV90YWJsZTsNCisJc3RydWN0IHNtdV9iYWNvX2NvbnRleHQg
KnNtdV9iYWNvID0gJnNtdS0+c211X2JhY287DQogCWludCByZXQgPSAwOw0KIA0KIAlpZiAoIXRh
YmxlX2NvbnRleHQtPnBvd2VyX3BsYXlfdGFibGUpDQpAQCAtNTA3LDYgKzUwOCwxMiBAQCBzdGF0
aWMgaW50IGFyY3R1cnVzX3N0b3JlX3Bvd2VycGxheV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSkNCiANCiAJdGFibGVfY29udGV4dC0+dGhlcm1hbF9jb250cm9sbGVyX3R5cGUgPSBwb3dl
cnBsYXlfdGFibGUtPnRoZXJtYWxfY29udHJvbGxlcl90eXBlOw0KIA0KKwltdXRleF9sb2NrKCZz
bXVfYmFjby0+bXV0ZXgpOw0KKwlpZiAocG93ZXJwbGF5X3RhYmxlLT5wbGF0Zm9ybV9jYXBzICYg
U01VXzExXzBfUFBfUExBVEZPUk1fQ0FQX0JBQ08gfHwNCisJICAgIHBvd2VycGxheV90YWJsZS0+
cGxhdGZvcm1fY2FwcyAmIFNNVV8xMV8wX1BQX1BMQVRGT1JNX0NBUF9NQUNPKQ0KKwkJc211X2Jh
Y28tPnBsYXRmb3JtX3N1cHBvcnQgPSB0cnVlOw0KKwltdXRleF91bmxvY2soJnNtdV9iYWNvLT5t
dXRleCk7DQorDQogCXJldHVybiByZXQ7DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMV8wLmMNCmluZGV4IDcxZTJiYmUyNWNmNi4uMjM4ZDU4NDgwNWIzIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQpAQCAtMTY0MSw3ICsx
NjQxLDkgQEAgYm9vbCBzbXVfdjExXzBfYmFjb19pc19zdXBwb3J0KHN0cnVjdCBzbXVfY29udGV4
dCAqc211KQ0KIAlpZiAoIWJhY29fc3VwcG9ydCkNCiAJCXJldHVybiBmYWxzZTsNCiANCi0JaWYg
KCFzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVfQkFDT19CSVQpKQ0KKwkv
KiBBcmN0dXJ1cyBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgYml0IG1hc2sgKi8NCisJaWYgKHNtdV9m
ZWF0dXJlX2lzX3N1cHBvcnRlZChzbXUsIFNNVV9GRUFUVVJFX0JBQ09fQklUKSAmJg0KKwkgICAh
c211X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0JBQ09fQklUKSkNCiAJCXJl
dHVybiBmYWxzZTsNCiANCiAJdmFsID0gUlJFRzMyX1NPQzE1KE5CSU8sIDAsIG1tUkNDX0JJRl9T
VFJBUDApOyBAQCAtMTcxMywxMSArMTcxNSwxNSBAQCBpbnQgc211X3YxMV8wX2JhY29fc2V0X3N0
YXRlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRlIHN0YXRlKQ0K
IA0KIGludCBzbXVfdjExXzBfYmFjb19yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkgIHsN
CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQogCWludCByZXQgPSAw
Ow0KIA0KLQlyZXQgPSBzbXVfdjExXzBfYmFjb19zZXRfYXJtZDNfc2VxdWVuY2Uoc211LCBCQUNP
X1NFUV9CQUNPKTsNCi0JaWYgKHJldCkNCi0JCXJldHVybiByZXQ7DQorCS8qIEFyY3R1cnVzIGRv
ZXMgbm90IG5lZWQgdGhpcyBhdWRpbyB3b3JrYXJvdW5kICovDQorCWlmIChhZGV2LT5hc2ljX3R5
cGUgIT0gQ0hJUF9BUkNUVVJVUykgew0KKwkJcmV0ID0gc211X3YxMV8wX2JhY29fc2V0X2FybWQz
X3NlcXVlbmNlKHNtdSwgQkFDT19TRVFfQkFDTyk7DQorCQlpZiAocmV0KQ0KKwkJCXJldHVybiBy
ZXQ7DQorCX0NCiANCiAJcmV0ID0gc211X3YxMV8wX2JhY29fc2V0X3N0YXRlKHNtdSwgU01VX0JB
Q09fU1RBVEVfRU5URVIpOw0KIAlpZiAocmV0KQ0KLS0NCjIuMjQuMA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QN
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
