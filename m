Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A05C49EAD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 09:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF02217F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 09:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF02217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210416E97D;
	Tue,  5 Nov 2019 09:44:48 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720083.outbound.protection.outlook.com [40.107.72.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFC26E97D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 09:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZO5Jx37ffB69YedRDuglPf0Yu4E58PTFptAW/T6JpcV1IVH5LAirPp5XkbNkxeUSqi9xAJNt1wAhFiZ2jc65uBEM/9iBGZRFtgdksYz+xSPbzoJzH9nd9tFnpEvyMiCAAYS+ODV0dDkM9qfeku1wZQQk10cXrfzIw0/k4oIc6gcPocVvFd07myfmTzDcwfkVXh0qooafXLPh/FvLxpQip0waMlXHaLfE+t5zGSgqlyNPDzqsgJzHMSCY5I8e+yUdH0NanK0+uqNvLEARmraUsbeYdl4Z3pvT9ulHmWgZ8QmCe2bBChzQLzYA/fZ0aj2ZYPFIhFsM1RC4vFnfx1Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeSQdxbHQHSWSthq+oCJf+QM19tcW5gPsG69DC51MMI=;
 b=Be5xCk5mUeiRMzb/qs/n+oZXDDWcz7BmCpznor+d3AGiyfzV7RWmzBXpAgQqGTs8V/Z0iRNdsMX2tsKkOny6Jd0hRFKLO0SyIs6x1VajLBQE4eQJS3SzSt7AGYQqdHKAcEDx//2UIh/jEUTYrYab9iE50yX+6iNJWOF6h+cGsV4jgUd/RAmbP40t9pfBmUz0Ggb1Dqa+a6QQalEdOFnEBJcdPpaILWQitx4jEbF3Z0N4LvAF6xol75N4CIxUhalaKpe87N8qgKvfurOufSga3VRZTQ/MG+Q13HjakDI4eFo76g7wPIhZksnCnxckQLJqGN4WXM2GawIDzf2r7YL/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3582.namprd12.prod.outlook.com (20.178.243.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:44:45 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::1179:cf99:3822:58dd]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::1179:cf99:3822:58dd%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:44:45 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface
 header
Thread-Topic: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface
 header
Thread-Index: AQHVk7Ivu79ePOc7RkGMR+VD1ySeGKd8U9cA
Date: Tue, 5 Nov 2019 09:44:45 +0000
Message-ID:
 <MN2PR12MB428519310AFCEBB71DF948DAF67E0@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <20191105082218.19972-1-evan.quan@amd.com>
In-Reply-To: <20191105082218.19972-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1613a5c-05bc-4106-100d-08d761d4ca64
x-ms-traffictypediagnostic: MN2PR12MB3582:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3582B6ABA976AE40A73DA1A7F67E0@MN2PR12MB3582.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(13464003)(486006)(6246003)(478600001)(14454004)(99286004)(6506007)(76176011)(7696005)(86362001)(53546011)(110136005)(26005)(9686003)(316002)(102836004)(74316002)(186003)(5660300002)(14444005)(476003)(229853002)(71190400001)(25786009)(52536014)(71200400001)(2906002)(6436002)(7736002)(66066001)(76116006)(15650500001)(81166006)(6116002)(3846002)(55016002)(305945005)(33656002)(2501003)(446003)(8936002)(66446008)(966005)(8676002)(66476007)(6306002)(81156014)(66556008)(64756008)(11346002)(256004)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3582;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOSH/oBeIXGASHZQqiarHO72JUbsYKhi6Ympep4lTCgoe4S8L9apxZUqkLZE1iAvDHK0NMAp4pt4NMEfVaS0uS8Rz6IzCEBN6hKBd0006wWADuojIdU3ABuAkwYXuwPiCv1f3SkM4uLGiR+ne3OziuSD1mKtHrzojbEMBSz+OCdbFbxy1tY9nFEZZB3hgwfw7pl7wQZi236CreRpPKjW7+jIcGvbwv3mQ5UL6O4DKNTth3dmlEolBjUl/NAEM1awP0aKNExAlJXuUvap7DkdLUQw2Wq2P9PsBbM6fVyOSz7l5r5eFup73N+xVD3xfH296420agFVBfx1QgSOyIiR7eW7umcwfMPqhliT9RHPs9ycoQ6hfppRHRP7rjh13JH5HV9gHh9qKFlVQyp5eZHgC/E3kfII7ikYVErVce4QiWaIxVtR2FPuJbkjudGWfmWIDkeaAPyAJb9xH/Nm0pVV/drkc3dEGqcnNGwxZHf/sHE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1613a5c-05bc-4106-100d-08d761d4ca64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:44:45.2153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHqxKgsr0AmVRrhmdZb+ht+UrRg+wIlKHyOTAYzdu9LHnxxY+ozpmnQvuT9WX2lu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3582
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeSQdxbHQHSWSthq+oCJf+QM19tcW5gPsG69DC51MMI=;
 b=VHij33HuszfPlW8cm0e1QAZ/5MpBx90YHJuIucsrbvHqz8bhzNVlolyrpzpBQ2ol/Ydeo0DmdiTAQz1HkdRONuZzXh8M7Ah6ORbejLlYoZ0gE5V8HBlSc1Qem28Xenv3DlURtyE4RKs+c0L4vLn61qlPc5/KmIAK0Ek6Wl6sWgE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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
Message-ID: <20191105094445.Z_jEG1a-jYgVWDuk96DczxEkyvETyRxP8pqJ_GYzvUw@z>

UmV2aWV3ZWQtYnk6IExlIE1hIDxMZS5NYUBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gT24gQmVoYWxmIE9mIFF1YW4sIEV2YW4NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUs
IDIwMTkgNDoyMyBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogUXVh
biwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93
ZXJwbGF5OiB1cGRhdGUgQXJjdHVydXMgZHJpdmVyLXNtdSBpbnRlcmZhY2UgaGVhZGVyDQoNClRv
IGZpdCB0aGUgbGF0ZXN0IFNNVSBmaXJtd2FyZS4NCg0KQ2hhbmdlLUlkOiBJYjE5N2U2MTg2MTI3
MTIxYjRhZTI3NjYzOWZhNjY2NzcwOTRhN2QwMQ0KU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxl
dmFuLnF1YW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2lu
Yy9zbXUxMV9kcml2ZXJfaWZfYXJjdHVydXMuaCB8IDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmggICAgICAgICAgICAgICAgfCAyICstDQogMiBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJpdmVyX2lmX2FyY3R1
cnVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJpdmVyX2lm
X2FyY3R1cnVzLmgNCmluZGV4IDg4NmI5YTIxZWJkOC4uYTg4NmYwNjQ0ZDI0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9hcmN0
dXJ1cy5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211MTFfZHJp
dmVyX2lmX2FyY3R1cnVzLmgNCkBAIC0xNTksNyArMTU5LDcgQEANCiAvL0ZJWE1FIG5lZWQgdXBk
YXRpbmcNCiAvLyBEZWJ1ZyBPdmVycmlkZXMgQml0bWFzaw0KICNkZWZpbmUgRFBNX09WRVJSSURF
X0RJU0FCTEVfVUNMS19QSUQgICAgICAgICAgICAgICAweDAwMDAwMDAxDQotI2RlZmluZSBEUE1f
T1ZFUlJJREVfRU5BQkxFX1ZPTFRfTElOS19WQ05fRkNMSyAgICAgIDB4MDAwMDAwMDINCisjZGVm
aW5lIERQTV9PVkVSUklERV9ESVNBQkxFX1ZPTFRfTElOS19WQ05fRkNMSyAgICAgMHgwMDAwMDAw
Mg0KIA0KIC8vIEkyQyBDb25maWcgQml0IERlZmluZXMNCiAjZGVmaW5lIEkyQ19DT05UUk9MTEVS
X0VOQUJMRUQgICAgICAgICAgIDENCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9pbmMvc211X3YxMV8wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9p
bmMvc211X3YxMV8wLmgNCmluZGV4IDg4ZWU2NjY4MzI3MS4uMzYwMjhlOWQxMDExIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oDQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgNCkBAIC0yNyw3
ICsyNyw3IEBADQogDQogI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9JTlYgMHhGRkZG
RkZGRiAgI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9WRzIwIDB4MTMgLSNkZWZpbmUg
U01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fQVJDVCAweDBGDQorI2RlZmluZSBTTVUxMV9EUklWRVJf
SUZfVkVSU0lPTl9BUkNUIDB4MTANCiAjZGVmaW5lIFNNVTExX0RSSVZFUl9JRl9WRVJTSU9OX05W
MTAgMHgzMyAgI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9OVjEyIDB4MzMgICNkZWZp
bmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxNCAweDM0DQotLQ0KMi4yMy4wDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
