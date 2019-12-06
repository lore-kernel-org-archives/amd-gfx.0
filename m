Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03BC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4010924685
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010924685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E556EA6E;
	Fri,  6 Dec 2019 08:03:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4D36E049
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 08:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYnR81pVH/6ozevrXz8TOc0PX6wgLkncnjQJaYEZWOq/ZQnLvo8DeLJeHE4Y+AcXcri9UjnDeiFm6J6KJHETXeOBDbbfEIMag27k0Xy6Nwcum7+6ahzLQtZEtwzi622T+OIDB36lDLUUY6eWUqoe8A3t8ogEOxRXhjhOvgQmy9c+JQ2FMB5JsdTeBi0n4MkewvzzrBr2eqeT3penogL9ByuAKgFueFp+ml7AXkgbSCC+AwhsmtrLA6KGUj4y+omMXwJItmZHcXIaw5TB7223fb+gzG0PvE58BAwSwCg4UxcllD0ogjM8xBpkKfqjUzu8GPsdR5dMLPyY/FVedZMjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjE1PkbDDQ7eQ15z6hHDRdFknik7Xu523WkVt1KMF6k=;
 b=ft07lqMFUzSA/3I6K6F7C624a073mJRJwBoUO5yTqtBbkWCYhhacdS51KwNJPpsZCW5Hf00ED0ZYHUjI5CbiX67KxR2p3xK2HbiBMMIquV+vje+5JGTMgA47gnQyzlsZa/uaNeqj7vzsaEcugdQbBXHwRKnLsh/6l2Kbv+EjrKDmVBECRd/TSviN6NJ3qRn4cEhWhdGIR8ihy+uUR0Our0DglHClMRZO1oX1A0Dks1i5cze/kEFaFjx83ruhTmynZUTLfH26cJql/CixXKWxiBj6I8Zq5oTeD+KSb1gGCmgaEeY7qlSazoQvQcx0hC1e0om3buzbD/PFQRfxw4kmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3304.namprd12.prod.outlook.com (20.179.93.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 08:03:54 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 08:03:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] tests/amdgpu: Fix unused function warning
Thread-Topic: [PATCH 2/3] tests/amdgpu: Fix unused function warning
Thread-Index: AQHVq+425IHVfUEtikaYMjbSTtFOW6esvobQ
Date: Fri, 6 Dec 2019 08:03:53 +0000
Message-ID: <BYAPR12MB2806E067D3B177DCE07A3AA0F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
 <ef63cf555221724a49c7f926c57786cae559fe77.1575606273.git.luben.tuikov@amd.com>
In-Reply-To: <ef63cf555221724a49c7f926c57786cae559fe77.1575606273.git.luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T08:03:51Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8a916046-9212-4d7d-bc3a-0000b4a589ea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-06T08:03:51Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c8cd9cb8-f985-4689-8b7c-0000d0510eb7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff5632df-3703-4fde-dc83-08d77a22d641
x-ms-traffictypediagnostic: BYAPR12MB3304:|BYAPR12MB3304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3304F739901A589F092BC135F15F0@BYAPR12MB3304.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(13464003)(189003)(199004)(11346002)(102836004)(33656002)(186003)(229853002)(26005)(76176011)(305945005)(81166006)(8676002)(53546011)(6506007)(64756008)(66556008)(76116006)(2906002)(110136005)(66476007)(7696005)(81156014)(5660300002)(8936002)(54906003)(55016002)(66446008)(86362001)(9686003)(66946007)(99286004)(74316002)(71200400001)(71190400001)(25786009)(478600001)(14444005)(52536014)(45080400002)(316002)(966005)(14454004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3304;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vj77OfUNzM72spHUbWFEYh6VMs64LPAa32CABo6lnh+9dgSf2kSecol1sPn6+MexW6hgJeQ0dfD5/5/R2y+sji3IEVp1aShKD1pvPBrb9EkQDiCCzomyPCqfOM03H+1LFxesW7LmFoKqy+b6ezXOTb+ISrXip02JSfM/gUCcWCuY5k6m/w+z/fJ68lTrSz1gAZNYBHrMB1HqifOEGGl/bxLwsOJ9D9vlfJPjKCAatDiV1lRuhSrbmC/idylJ2g499EHt5A2XWyLqjymEREoytMYut6U3RYGC8Wh5IsVlJiwzd3umYZvnbcg0jZwFa2aLOpyhnIPYM+1CEOdWX6VcWMBkhB/y9XvdmQhD4rqHg3p5bwwotK6T6gvT/MoX1UHTtXZdoCDvJdNP7/STqEXyVEerBAvQSvxxa2x5d5W2Qrmmxr689tuLeQdvO5wdWhCj2Gr+X3kKSclFGmDoc1ZnBPkK5ko4fAZPaZq+5tzF/+bOjai4r4/YTdVmvVARPlVcUFA2uqSvD4TcYfkdVnGJg6dx+9R2WzqU+XH1lUEJ0fQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5632df-3703-4fde-dc83-08d77a22d641
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 08:03:53.6932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfXarjXkVVK2wLzOTq4FK38p2IJyucSB9nrYE1kj4XLcs5fBNABfjZikuVr+f2c2Z9OJ941tD8b7DwC+XfJQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjE1PkbDDQ7eQ15z6hHDRdFknik7Xu523WkVt1KMF6k=;
 b=JnJEhaQDFWlFB16wzrAxql8egLyV7mNm2Phms7xTlEfRFEIb0AXAX1vGMFXoSnS2zvqwlMOJftlHrWAdngIgA5a43FwIKBneO2LBP6KS2VNC26gIqVqcSW5/BidQFTzD7LArpGKD6b/GXxByc5sTjSicOk9lWgX/soGry17hUWc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMdWJlbiBUdWlrb3YNClNl
bnQ6IEZyaWRheSwgRGVjZW1iZXIgNiwgMjAxOSAxMjozMiBQTQ0KVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDIv
M10gdGVzdHMvYW1kZ3B1OiBGaXggdW51c2VkIGZ1bmN0aW9uIHdhcm5pbmcNCg0KVGhpcyBwYXRj
aCBmaXhlczoNCi1XdW51c2VkLWZ1bmN0aW9uDQoNClNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtv
diA8bHViZW4udHVpa292QGFtZC5jb20+DQotLS0NCiB0ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMg
fCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUv
cmFzX3Rlc3RzLmMgaW5kZXggZDcxNGJlNzMuLjRjMzk1MzgyIDEwMDY0NA0KLS0tIGEvdGVzdHMv
YW1kZ3B1L3Jhc190ZXN0cy5jDQorKysgYi90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMNCkBAIC03
MDksNiArNzA5LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19kaXNhYmxlX3Rlc3Qodm9pZCkN
CiAJfQ0KIH0NCiANCisjaWZkZWYgQU1ER1BVX1JBU19URVNUDQpbR3VjaHVuXU1heWJlIGl0J3Mg
bW9yZSBmaW5lIHRvIG5hbWUgaXQgdG8gQU1ER1BVX1JBU19FTkFCTEVfVEVTVD8gQU1ER1BVX1JB
U19URVNUIGlzIG9uZSBtb3JlIGdlbmVyaWMgbWFjcm8sIHdoaWNoIGNvdmVycyBhbGwgc3ViLXRl
c3RzIGxpa2UgcXVlcnkvaW5qZWN0L2VuYWJsZS9kaXNhYmxlIHRlc3QgLg0KDQogc3RhdGljIHZv
aWQgYW1kZ3B1X3Jhc19lbmFibGVfdGVzdCh2b2lkKSAgew0KIAlpbnQgaTsNCkBAIC03MTcsNiAr
NzE4LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19lbmFibGVfdGVzdCh2b2lkKQ0KIAkJYW1k
Z3B1X3Jhc19mZWF0dXJlc190ZXN0KDEpOw0KIAl9DQogfQ0KKyNlbmRpZg0KIA0KIHN0YXRpYyB2
b2lkIF9fYW1kZ3B1X3Jhc19pcF9pbmplY3RfdGVzdChjb25zdCBzdHJ1Y3QgcmFzX2luamVjdF90
ZXN0X2NvbmZpZyAqaXBfdGVzdCwNCiAJCQkJCXVpbnQzMl90IHNpemUpDQpAQCAtODgxLDcgKzg4
Myw3IEBAIENVX1Rlc3RJbmZvIHJhc190ZXN0c1tdID0gew0KIAl7ICJyYXMgcXVlcnkgdGVzdCIs
CWFtZGdwdV9yYXNfcXVlcnlfdGVzdCB9LA0KIAl7ICJyYXMgaW5qZWN0IHRlc3QiLAlhbWRncHVf
cmFzX2luamVjdF90ZXN0IH0sDQogCXsgInJhcyBkaXNhYmxlIHRlc3QiLAlhbWRncHVfcmFzX2Rp
c2FibGVfdGVzdCB9LA0KLSNpZiAwDQorI2lmZGVmIEFNREdQVV9SQVNfVEVTVA0KIAl7ICJyYXMg
ZW5hYmxlIHRlc3QiLAlhbWRncHVfcmFzX2VuYWJsZV90ZXN0IH0sDQogI2VuZGlmDQogCUNVX1RF
U1RfSU5GT19OVUxMLA0KLS0NCjIuMjQuMC4xNTUuZ2Q5ZjZmM2I2MTkNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0
DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdD
Z3VjaHVuLmNoZW4lNDBhbWQuY29tJTdDNzQ3YzZkYjM2ZDFhNGNiZjUzNmMwOGQ3N2EwNTU1MmIl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTEyMDM1Njcy
MTU1MTE0JmFtcDtzZGF0YT05eFRlTnNDNWJMUERYb2d4VnVGbkpoUmxyQ3dJdUQ5Rm01MlgwMjN3
Vng0JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
