Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD859C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 19:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC639206D9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 19:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC639206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D82E6E176;
	Thu,  5 Dec 2019 19:31:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E876E176
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 19:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQLO9q0sWHL5AbxSwZt9Y6/t1MPylgbQ84Rm4oq6g4Y2UUd3cStR8JeyKy8aG+BDKpdwoGpZo80O8dqKuZkdNG/001WmMkzXB9N9IaAYNrYSr83qxzZNzAKWAi3zMbhxqhR+wHguJz0Fq89prwROEVLIqApuyJM7MWb5OpjYwb2gi7X6chtoujZ9KQaFp38d2Sd643IZTYbsX+3K8CFp1y10eP2xio9kCq+Vi5+A/fIU5B620Q9pWakUHXOHU//JWIc4Mb0lKA4zUTQu9M0f9ZrHvzTvT38zFyI5DKwl4Xu4cjVKLrRuHke2MhVLgG6Ppe9MS7cidRy5aHCpUYGxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0tIe56V8SugOyQ+vKuqXKegUwGiZ1MGpzOfPpfsbsw=;
 b=dkuR+TQbTHMFzZXEAVEBRRaXu0HBM1hAbXBe6QJObHr8F23YUScfVj3/X8E254uEjsItYrfjYXoy8fAbt9nkVnhvU5jVDazH7XVubZkRRaciVWWBxydpJAG/Mv6DB39gGrJajk4fMgfULG7RpYAyzrOGWWUvAUWcX1OMQ05wxqO5h/qxNc4RSBwRVh1mpsF4BFbi6+RGOmIoQOlYA6EteMdxElcwuVkj5CqyvUvH5kqM/sRjQEb72w2UOtmJLDTVZLSLvCSpFKw9pbD4R35wANcYD/C+bY+Uw6GBLEszjHe//qPiaW0oOeWG9kmp3EXt9seLznWvHB80AbQOP7EWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1792.namprd12.prod.outlook.com (10.175.56.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 19:31:37 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 19:31:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix BACO entry failure in NAVI10.
Thread-Topic: [PATCH] drm/amdgpu: Fix BACO entry failure in NAVI10.
Thread-Index: AQHVq6JXg5PFnAAvLUOJEiU6bBnsmqer7c1Q
Date: Thu, 5 Dec 2019 19:31:36 +0000
Message-ID: <MWHPR12MB135851D4C3208C93E17D1C2CF75C0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <1575574175-20765-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1575574175-20765-1-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8a2afb4-7f7e-4c5d-af1a-08d779b9beac
x-ms-traffictypediagnostic: MWHPR12MB1792:|MWHPR12MB1792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1792CCEB44237B616C98A999F75C0@MWHPR12MB1792.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(13464003)(189003)(199004)(66476007)(316002)(66946007)(4326008)(66446008)(64756008)(110136005)(66556008)(8676002)(81156014)(81166006)(76116006)(305945005)(52536014)(11346002)(26005)(25786009)(102836004)(186003)(53546011)(6506007)(33656002)(74316002)(14444005)(229853002)(71200400001)(5660300002)(14454004)(8936002)(7696005)(71190400001)(478600001)(76176011)(2906002)(9686003)(55016002)(99286004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1792;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Um4wyxHTaDTWya14zeeojCCSNVU57wIS0HMsGdR06jtMvx17Sd3ulB/tVQ+6egW+5Ew7Rmm4E4zXARIfILSWCcdCzVi5va3jYV9t639G2mZXwQQQctsy6E4ZWCqznEK4th3+5kHb5FeeEGcQWOXJg+0Ai5dYMHQZKm4Tb9Ww+CJzUbekQ1YR7oLlt0792BRmQ37OQtgIqWySHaJqDYkLKqso3wSDHpLh+tC9c2JIK82/vALRoXrWSZTBkgLxu9eRTLH+CB41XgpTE43aFiKRvNqjo/utqqWP/cx0pgGSKQrrzMCCdQYumw/+x3Fe80VcqDN7fcwCLpiq1Vh6nOlPD3O0CfOe8qcaihMKhTV82RldzrN0vyMCCt4ICUzEtpqe14Av084OVQQFh8hF9G18U+jBQht4LUG7DMOiYA7bZICaUKBiQ5Re0tBjfTcfVaXFUzmzDQiIv8/Xo6Beklz5iFipMc6WhsxbpUu+NgVTjkMNdWU4amTCHNrEIIaGlRZ7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a2afb4-7f7e-4c5d-af1a-08d779b9beac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 19:31:37.0043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uE5Wq2w3y/J8Y4/tIZFqoYwQYeTO+GrrE8jhISWd4pieZPh6tTy8Q47KdalzBHhleebh+bfHlKwOgsx8m0ESdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0tIe56V8SugOyQ+vKuqXKegUwGiZ1MGpzOfPpfsbsw=;
 b=VB3DZCyLJttGONXu9MiOt300F4snxbZNy7868G4N8mALu4jKFFzI0BRo2dQx9CygKUzrr7zdaHAdaRb33N/K6C6Aa43pOtcZYFT4jNEVSpcwxJRtd5FzTKnZmYfXmMc04uyD5TaGeHSMmZEtzBLris7J6snHUttDIJRJPihWUSc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEFuZHJleSBHcm9kem92c2t5IDxh
bmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA1LCAy
MDE5IDI6MzAgUE0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgR3JvZHpvdnNreSwK
PiBBbmRyZXkgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+Cj4gU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBGaXggQkFDTyBlbnRyeSBmYWlsdXJlIGluIE5BVkkxMC4KPiAKPiBCQUNPIGZl
YXR1cmUgbXVzdCBiZSBrZXB0IGVuYWJsZWQgdG8gYWxsb3cgZW50cnkgaW50byBCQUNPIHN0YXRl
IGluIFNNVQo+IGR1cmluZyBydW50aW1lIHN1c3BlbmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpUZXN0ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCj4gaW5kZXggYzMwZjlhMi4uNmRkZGQ3OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKPiBAQCAtMTM4Myw3
ICsxMzgzLDcgQEAgc3RhdGljIGludCBzbXVfc3VzcGVuZCh2b2lkICpoYW5kbGUpCj4gIAlpZiAo
cmV0KQo+ICAJCXJldHVybiByZXQ7Cj4gCj4gLQlpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0ICYmIGJh
Y29fZmVhdHVyZV9pc19lbmFibGVkKSB7Cj4gKwlpZiAoYmFjb19mZWF0dXJlX2lzX2VuYWJsZWQp
IHsKPiAgCQlyZXQgPSBzbXVfZmVhdHVyZV9zZXRfZW5hYmxlZChzbXUsCj4gU01VX0ZFQVRVUkVf
QkFDT19CSVQsIHRydWUpOwo+ICAJCWlmIChyZXQpIHsKPiAgCQkJcHJfd2Fybigic2V0IEJBQ08g
ZmVhdHVyZSBlbmFibGVkIGZhaWxlZCwgcmV0dXJuCj4gJWRcbiIsIHJldCk7Cj4gLS0KPiAyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
