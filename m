Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD6C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 03:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5A12073B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 03:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5A12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335366E978;
	Thu,  5 Dec 2019 03:25:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FEE6E978
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 03:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGgZcc3wGOWybQvdYR5YMpcedZ5I8LWOTBrS3Gc1wc9ux+rbCuweuHaPhIkjAn8z8T4G89nh0FrbIIikj1P9fhmehdGJK+PVsQY7g6ennev6qa2JX8DRroWXOdfkvKAE5tpfHDiNVcU2LNpMxolOZFORtqHCKKagflZ6IRw3VS74krlYwYTxxc3g7BdcBL8QUhRUwY6IBWCHZJHkgABSbVqwbT9IISl5zzt4eUp9imk4TpULZccQ2l9Vj7ALlNN/aP9Yx2WVcq8x5QhUSbntXFqhKKGMjn0Un1f6nlFitZ4PX+PF5NL1a5zDloEy5qybwfow1lCCkaaZ11h9hOSsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfeW7PiK9tiTjJpa/zGQoPJdpLuv6zfEJ50ERu7y6l0=;
 b=Xv8Q7EjCVSXIjhkdNSr2TM/EedfAjtVKH9M7Xiaa2I83xbDpMCtAKRvySLg80gNd5SIVmuy/bM2VQ9cVJzv/N3y6RMc/Uf8iPmvgPf0eJh54vH8sZTztBon7dVSPC0tqDvwo8x27cZ3GlpFSCnzNgbjZGzsb43YGXzEvQ5xUo++hxYerQaYfVM6mQ1pwpyFrwc8znvPjge9eqzHHMLcxaS788uy+41pf5hzEP/FXdw2rxREnMUVNLPKQhAWyTHasitDgqtASdUD92sbsl5brPFs9W/etLM91P+7+YRXlD+BZ+uGVAmo9ShRrmfwWLcVxsUtnMMU7xLcmzH/C0VxUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3677.namprd12.prod.outlook.com (10.255.86.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 03:25:38 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 03:25:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add header line for power profile on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: add header line for power profile on Arcturus
Thread-Index: AQHVqxlp+CYVpT3UbE6VoGAlAmWydKeq4L4g
Date: Thu, 5 Dec 2019 03:25:37 +0000
Message-ID: <MN2PR12MB334402AD66DC195DE6B7ABAAE45C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191205030901.1283646-1-alexander.deucher@amd.com>
In-Reply-To: <20191205030901.1283646-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c3ae6c40-9ba8-4382-af8d-0000f4d912f4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-05T03:24:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1db5ec6-8567-4882-ae3e-08d77932cc4a
x-ms-traffictypediagnostic: MN2PR12MB3677:|MN2PR12MB3677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3677F5773CD002B459DAECFAE45C0@MN2PR12MB3677.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(13464003)(51914003)(189003)(199004)(966005)(5660300002)(229853002)(14454004)(8936002)(76176011)(8676002)(45080400002)(52536014)(7696005)(11346002)(498600001)(55016002)(6306002)(9686003)(6436002)(71190400001)(3846002)(6116002)(71200400001)(86362001)(7736002)(66446008)(26005)(74316002)(66946007)(76116006)(2501003)(25786009)(66476007)(305945005)(99286004)(66556008)(4326008)(6246003)(33656002)(186003)(102836004)(81166006)(53546011)(81156014)(6506007)(110136005)(2906002)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3677;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lvqEpRu+mJrTYeOC/K2IhaXvixCdGxtp+7TEK2SkT1g0r8aSpIW3GbLlz3N5HdeaFabPBRtxdeM8lMRpMzoeUc6EAShC1OMZsj3uB4labU0ifMelSLG0nrv91B4OKWqelFmX6goM4dh0g0jsRGredY5giUf79WPal1CbRX2e5YMG+3CgdpT/DxSTbbZRfqKGZPtFRX+0Ay6h5701zmuXcdIgFsRiqYcnV29PS3xXC2I1UJOiBb3vpZp1MwYDlAkIDAoUAU94ZJjAR5lbc48SrebzV49/xgYNMXrMnLJMY1aa1EGd4NcYUBFYb+TItv/Lc23nvlQeMPQZxfga8q6ztt2ATMxzHcqMvrmXV2wkLwj16yqhVWuQ1KEPEWZ+5XZly15biQk4si7LLBZswYD4+Zt+lAGRl8dd3Hvr+4r9468yUh6wg2Lbq1moUPdO5AssJOHS/3KNo4V55A3goESvaEQnEpg7aZsDczGXj7/99c6bnuLnV+wBhL055ZPzy5xwQNC6+QoGp9GYIYZ5KCVWraP+Im8q4Jmgb+a+Rwz9UXPBxjLRF0vZH5mBuTlpG2k
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db5ec6-8567-4882-ae3e-08d77932cc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 03:25:37.7997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2JYaHwCbDRbUUPIoMSqOm7xu03FFMOu+4EksWAuNkooBrRKXEEOFAfTZLQV09JB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfeW7PiK9tiTjJpa/zGQoPJdpLuv6zfEJ50ERu7y6l0=;
 b=jhbjeWgUEZ5Jbaqx6G6N6qQJbYW4QYkcwOS/3MePRNAr8RYNkBJfENf8WlfqSP1H0u2MFQozgVqou9C4AygT9DWc5g+6BoZ/R63/EsADTqAFg5nxpibexNF20UFaroiJaEIwRfYoTLdn8cDBXE/1cCQUNbGN5g4O+aLy9auZKS4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGZvciB0aGUgZml4LiBSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1k
LmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0K
PiBEZXVjaGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA1LCAyMDE5IDExOjA5IEFNDQo+
IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IGFkZCBoZWFkZXIgbGluZSBmb3IgcG93ZXIgcHJvZmlsZSBvbiBBcmN0dXJ1cw0KPiAN
Cj4gU28gdGhlIG91dHB1dCBpcyBjb25zaXN0ZW50IHdpdGggb3RoZXIgYXNpY3MuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCA1
ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYw0KPiBpbmRleCAzZjEz
OTg2ZDhlNTAuLjE5OWM5NmNhYTg4MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYXJjdHVydXNfcHB0LmMNCj4gQEAgLTEzMjAsMTIgKzEzMjAsMTcgQEAgc3RhdGlj
IGludCBhcmN0dXJ1c19nZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdA0KPiBzbXVfY29udGV4
dCAqc211LA0KPiAgCQkJCQkiVlIiLA0KPiAgCQkJCQkiQ09NUFVURSIsDQo+ICAJCQkJCSJDVVNU
T00ifTsNCj4gKwlzdGF0aWMgY29uc3QgY2hhciAqdGl0bGVbXSA9IHsNCj4gKwkJCSJQUk9GSUxF
X0lOREVYKE5BTUUpIn07DQo+ICAJdWludDMyX3QgaSwgc2l6ZSA9IDA7DQo+ICAJaW50MTZfdCB3
b3JrbG9hZF90eXBlID0gMDsNCj4gDQo+ICAJaWYgKCFzbXUtPnBtX2VuYWJsZWQgfHwgIWJ1ZikN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArCXNpemUgKz0gc3ByaW50ZihidWYgKyBzaXpl
LCAiJTE2c1xuIiwNCj4gKwkJCXRpdGxlWzBdKTsNCj4gKw0KPiAgCWZvciAoaSA9IDA7IGkgPD0g
UFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NOyBpKyspIHsNCj4gIAkJLyoNCj4gIAkJICogQ29u
diBQUF9TTUNfUE9XRVJfUFJPRklMRSogdG8NCj4gV09SS0xPQURfUFBMSUJfKl9CSVQNCj4gLS0N
Cj4gMi4yMy4wDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlDQo+IGRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLQ0KPiBnZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2V2YW4ucXVhbiU0MGFt
ZC5jb20lN0M4ZWNlOWJkNDg2OTM0ZWFjOWINCj4gZGIwOGQ3NzkzMDg1MjQlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3DQo+IDExMTEyMTcwMzkwMTkzMiZh
bXA7c2RhdGE9bFVacHJZc1R6cSUyRmNnd3dYSkl3YU9uTWY0NTgzbzhhVUs4UDUNCj4gQ1lYWWpy
TSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
