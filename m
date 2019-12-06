Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500AC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4F424676
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4F424676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FF76E171;
	Fri,  6 Dec 2019 04:20:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB626E171
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 04:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMBwI6JPmXJutYFZru6O+BG0H8AhEwfOe5pA5rH3ktNnRgGtkYgKQU3Xj0npu1eEdaiOZojik+Xpp2yZZdUudb1PQq3KCnsZDLJLRXDzrXR2IVygLRRbPdfOFEEzJiJ+Fhh00bGyekg7nqOSn8I/RdshtPf/RPD9lwi2yxN1B8+UJvomiwTJUYTirrDmmNzXkSal3dGbK66M9051fp6i9xTaOchz9UixQ5zLk2g4YLg9kjI2MPy6ojFrPzLsNU6DjVzZ28siXrHHswa77E6+SFhY66Kmbuny8hwJWRzky7VbNq6LzDC70hWbyfMIRkwMIDwzgjstmCSgzMzr/1gutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ctI+DKSL1CycTBGDv+Z9CsVp2s4kPWeitPemY/PVlE=;
 b=kMmSoTU1yuhgSn/x8zqaw9C8Ur8JyAJIcVeiUp7npExnZ/HEWYqz+sk8hrVtWjutQOZ1qKbZF5X0Ry8S/Yr6jWzc7wwZ0HvpexmAByR4uZhV5iORv/91YlHKIjS9fN2mVH9fMEZ6/UVgRTW28fKb6Dw4hlDJlzUxgV71EP1JfeDeDOZgDK1t8G9MHiDI88tU+sZhFR/E1dkGYicMY1i7JoCI0WOs6ZzAPw7i9zEamsAKJhwtB1DOkp9EiSFZC9b89huwOyAZU0E+t2KLZvIl1tdIVjGu3wtIQNG5dt/fKKTXlBTOgIGKRMX2+FgQcRtqhJYD7JXDDxAoLHo/HwnqDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB2926.namprd12.prod.outlook.com (20.179.84.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 04:19:56 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::48df:615a:93a3:6f74]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::48df:615a:93a3:6f74%7]) with mapi id 15.20.2495.026; Fri, 6 Dec 2019
 04:19:56 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Topic: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Index: AQHVq+ZrUvuVS2+uWE6ARdBRB2Tug6esgQfJ
Date: Fri, 6 Dec 2019 04:19:56 +0000
Message-ID: <BB0A14B8-3288-4EE0-8352-162F81477E1A@amd.com>
References: <20191206033543.3131-1-evan.quan@amd.com>
In-Reply-To: <20191206033543.3131-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [240e:e0:f826:ef18:818a:cd59:e565:6ce2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ae34303-803c-4c44-3dcf-08d77a038cd4
x-ms-traffictypediagnostic: MN2PR12MB2926:|MN2PR12MB2926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB292619A42DEF3A53EA764B07895F0@MN2PR12MB2926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(33656002)(66946007)(86362001)(11346002)(91956017)(66446008)(64756008)(66556008)(66476007)(2616005)(6506007)(186003)(36756003)(4326008)(2906002)(76116006)(25786009)(53546011)(71200400001)(71190400001)(6636002)(5660300002)(8676002)(81156014)(102836004)(54906003)(37006003)(316002)(76176011)(99286004)(14444005)(8936002)(81166006)(6512007)(966005)(14454004)(6862004)(6486002)(45080400002)(229853002)(478600001)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2926;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gvxd9OzAIm7FdsMYLC5uYe070wNB7BT6bEk2ATtBSH0FWp+4Iuow3kvHTvk9EeMuWUUsz//BPK7da97LpMvxFqF+aJ3fmjQd5zuRPaoEeuQbYwD3H1oM98s70H0wQtbNjd2XDGCYamtLfZ1uC+mJdnHLiZ/xV03S1ZXfWgaw7v2vYk5D6H9IV92SyyKpRcu7Wi4GBh+4qcgnIanfOZb6UjNzhGR80NqcBKMOn2anA6kFgWB0ZBS8CDHjeMg0Kt47KNsvVvtl/ctwtpS/wdA5Adry4xGEiKrqB3hqRkTq58ZlSSItrLwhoG01pqKN5iJTNLe4shIXPIIaLtdbCLoJ/Ewmiffq/kJ6NbZmc9pZvP5pQrCoVueWicuKT2lTahjUWacLrcgExnzKJTxzAyQe+g6tXvLzJKcp+rRIrh8D1CeZaD+oR/5EiakSQicMwAF7hVzypZOv0DEqSLJURgLGTCxm7+3Iixb6JY5O5v0jjfg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae34303-803c-4c44-3dcf-08d77a038cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 04:19:56.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ma5+k725TIIk315cPr/MpNZxyxYueSpa5HfIPST79cgZM/i2Lt5tFQPXsbjSmPW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2926
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ctI+DKSL1CycTBGDv+Z9CsVp2s4kPWeitPemY/PVlE=;
 b=is7/ltpbNExY5l9qPF7hFqtjFXiN+PeENnqqqdXmhdcYHtrQr6asBxzucr6skaFU94Ob9qg5UV+eAOmUTOSAWLzfFMNG60teIFCEa5WQzZQJHfMBuc4HpLmTiG3e+4bMn2fWIPhthsMXGYNsBCLP9PDqmhYMvrkkL0f9poPWxOY=
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRXZhbiwKCkp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgbWF5IEkga25vdyB3aGF0IGlzc3VlIGFy
ZSB5b3UgdHJ5aW5nIHRvIGZpeD8KSSB1c2VkIHRvIHNlZSB2YmlvcyBwb3N0IGZhaWx1cmUgKGhh
bmdzIGluIGF0b21iaW9zIGluaXQgdGFibGUpIGFmdGVyIGJhY28gZXhpdCBvY2Nhc2lvbmFsbHkg
b24gbmF2aS4KCkJSLApYaWFvamllCgo+IE9uIERlYyA2LCAyMDE5LCBhdCAxMTozNyBBTSwgRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gd3JvdGU6Cj4gCj4gVGhpcyBpcyBuZWVkZWQgZm9y
IGNvbWluZyBhc2ljIGluaXQgb24gcGVyZm9ybWluZyBncHUgcmVzZXQuCj4gCj4gQ2hhbmdlLUlk
OiBJZjM2NzFhMjRkMjM5ZTNkMjg4NjY1ZmFkYWEyYzQwYzg3ZDVkYTQwYgo+IFNpZ25lZC1vZmYt
Ynk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Cj4gLS0tCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCA2ICsrKysrKwo+IDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X3YxMV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEx
XzAuYwo+IGluZGV4IDM5ZWMwNmFlZTgwOS4uYWI4MDlkZjdiYzM1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKPiBAQCAtMTY1OSw2ICsxNjU5LDEyIEBA
IGludCBzbXVfdjExXzBfYmFjb19zZXRfc3RhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGVu
dW0gc211X2JhY29fc3RhdGUgc3RhdGUpCj4gICAgICAgIH0KPiAgICB9IGVsc2Ugewo+ICAgICAg
ICByZXQgPSBzbXVfc2VuZF9zbWNfbXNnKHNtdSwgU01VX01TR19FeGl0QmFjbyk7Cj4gKyAgICAg
ICAgaWYgKHJldCkKPiArICAgICAgICAgICAgZ290byBvdXQ7Cj4gKwo+ICsgICAgICAgIFdSRUcz
Ml9TT0MxNShOQklPLCAwLCBtbUJJT1NfU0NSQVRDSF82LCAwKTsKPiArICAgICAgICBXUkVHMzJf
U09DMTUoTkJJTywgMCwgbW1CSU9TX1NDUkFUQ0hfNywgMCk7Cj4gKwo+ICAgICAgICBiaWZfZG9v
cmJlbGxfaW50cl9jbnRsID0gUkVHX1NFVF9GSUVMRChiaWZfZG9vcmJlbGxfaW50cl9jbnRsLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgQklGX0RPT1JCRUxMX0lOVF9DTlRMLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgRE9PUkJFTExfSU5URVJSVVBUX0RJU0FCTEUsIDApOwo+IC0tIAo+IDIu
MjQuMAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q1hpYW9qaWUuWXVhbiU0MGFtZC5jb20lN0M2ODJjMTQy
ZWYzMDc0OGJiZDAwNTA4ZDc3OWZkNmY4MiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxMTIwMDIyMDg5Mjc3MzMmYW1wO3NkYXRhPWJhamFhajNDdzJJeFc1
blJ1Y2czRlhVamN5SWk1MGtDU1BRN2VrbnFrNG8lM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
