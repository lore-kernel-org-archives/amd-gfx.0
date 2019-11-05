Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55CBCA9EC7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 05:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC7120818
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 05:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC7120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3733B6E8FB;
	Tue,  5 Nov 2019 05:56:31 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720057.outbound.protection.outlook.com [40.107.72.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD866E8FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 05:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeBC3Vll9roKvFUhG/jNjK8/THVfoalhfdInsA/o/ZCTuBEBWEocFYNtuNH0Zsk24QfEi+o5yT6UpYGh0puAcdz+rBXsagR8wMunMZqpGVgeMSLIZDWFkUemcmYA92UFRnSyjwcbmp3areMEJpAKWsEJ7cYUkc6ReFDCca1HLIkaADMMwZJhmfA2b4Fu32bBhbxJZm/gRjFuh5zYJKc69Lg0q2DtcLxc026b28qQJ6vY4lYVbr2L2c0U1G335zF3WN9/Um0KgW45vEDsp0BRsVom396HxP/ugFkM5SMRxXMZloxZnt2KqKzL4WX9eHSdXVT840aYluwBqQ1XRLES6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEoNH4BwL+aiU+Ovx+Gwjl/YYqbOLhm4OBft7Hh70B8=;
 b=KqzCRcIBvl8w9JYp1lnkiCHunI3hb/GK1hdf4F15Pvexc4DbX2OBMgXt74nTJkrCPiHn3derM10mGGA2f3Xk1lesPBR8aUR2rtaP4L4g4eaOCWqec3KxWIMaJmpuEI4oYhNOLzDooOhOn6sKjHYj6VInM0zH4NY4iOVTX8JuzkaQ8OgE+VsGYGe12UEATAfq6wqasDnPmR6LHnYp5hKtuTiRz5ERjUhP+8aH2Tu739VC1R+qNHpf2JcLaUbX8Bm5po3ghkf6qLV9PS4t9/S1RS8qeHhZLxbSLcN359p8G66LAO9TrB5OA536osqpwXngBuX1WpIPNQ0Q1ojEpLMv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB2960.namprd12.prod.outlook.com (20.179.82.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 05:56:28 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9973:de2e:58b4:282a]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9973:de2e:58b4:282a%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 05:56:28 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH libdrm] tests/amdgpu: enable dispatch/draw tests for Renoir
Thread-Topic: [PATCH libdrm] tests/amdgpu: enable dispatch/draw tests for
 Renoir
Thread-Index: AQHVk53DtEQSGrSsJ0eG9XiWwUVY3A==
Date: Tue, 5 Nov 2019 05:56:27 +0000
Message-ID: <20191105055606.27936-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5a92f7b-01ae-446c-1521-08d761b4e600
x-ms-traffictypediagnostic: MN2PR12MB2960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29608B863F94BE46021E9B8AFD7E0@MN2PR12MB2960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(6436002)(256004)(26005)(14454004)(8676002)(81156014)(6116002)(86362001)(4326008)(36756003)(6512007)(6486002)(2501003)(476003)(50226002)(66066001)(478600001)(486006)(5660300002)(3846002)(64756008)(6916009)(316002)(386003)(6506007)(5640700003)(186003)(99286004)(2616005)(2906002)(1076003)(81166006)(2351001)(66446008)(66476007)(71200400001)(71190400001)(305945005)(66946007)(8936002)(52116002)(66556008)(102836004)(7736002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2960;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eigK+/glilno3psPOP+y/cLfPfgXsCPy+1L3ovNzUeqiIPz1P1I4zjtsY/HK4mEUjME2ETSXYAt1leorKE0Wd+glOBXaIMrzxVvE2v9H4XVPeeb2KeC1eVLL+KFJp/9clHC5a0/nUGDTLucEOCP01AHipFUzE+jRiS5mU/S0MzHBI2AQL0LEhc60D8o1hPnbffs5ba6GxfptUmeOwHPi/cFMSoFPlFSOGWSDvUJ1PaYX4z3cGxUKUJhD1fSFhYbEnmz1CF1FJnadWbt0SxpTA2TJC/jwNOW8qC5mAhxycQMf3H4qrknD7tzAovnhrL+QnGtvaRgZxPWE67K3UtULnj2S5qcwhv5sIvLg71nvPev91B4Azxk7BEx2PmQDh9VnmXREw7UkbL8WGoRkaAS/0RpyWdvj8bdMV+MoO11prXKZfSx0MD0iz2x5/kv3LkTA
Content-ID: <15B2D3EBABCA6C43A6FB1E190921B210@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a92f7b-01ae-446c-1521-08d761b4e600
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 05:56:27.9725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ01QLyA2JaGjtn6S/6PFkOXUmRGePfMthmI5JvGQgHmSysVSeOvM4gDEVyBDiTacH2rTgB778E73BN/0zLolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEoNH4BwL+aiU+Ovx+Gwjl/YYqbOLhm4OBft7Hh70B8=;
 b=BXrvbw3i7sE+HMXroYSDWdndroqaH5N3WaCqEoewpkL7p02a+db3K1rGX99Bku4xkx3egviRPbkiEpCaiQ3nI3nArLcE8W1AK+jQkAhkhPuEt0JUmThL6z2jwOKAzV2KhtayQwC6qfCc9En4ZaoXTn+3LXqrj3XbXlJINRn2ego=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105055627.yDSKAMzhafydWb3wpRjeC_pJu6mW-Ow3UgOGMLVHGCE@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NCg0KSXQgY2FuIHJ1biBkaXNw
YXRjaC9kcmF3IHRlc3RzIG9uIG5ldyByZW5vaXIgY2hpcHMuIFNvIGl0IG5lZWRzIHRvDQplbmFi
bGUgZGlzcGF0Y2gvZHJhdyB0ZXN0cyBmb3IgUmVub2lyIGFnYWluLg0KDQpDaGFuZ2UtSWQ6IEkz
YTcyYTRiYmZlMGZjNjYzZWUwZTNlNThkOGU5YzMwNGY1MTNlNTY4DQpTaWduZWQtb2ZmLWJ5OiBj
aGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IEZsb3JhIEN1aSA8
ZmxvcmEuY3VpQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xz
YWtAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0K
LS0tDQogdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgfCAxNiArLS0tLS0tLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rl
c3RzLmMNCmluZGV4IGU3NWI5ZDBkLi5hNTdkY2JiNCAxMDA2NDQNCi0tLSBhL3Rlc3RzL2FtZGdw
dS9iYXNpY190ZXN0cy5jDQorKysgYi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYw0KQEAgLTU5
MiwyMCArNTkyLDYgQEAgaW50IHN1aXRlX2Jhc2ljX3Rlc3RzX2luaXQodm9pZCkNCiANCiAJZmFt
aWx5X2lkID0gZ3B1X2luZm8uZmFtaWx5X2lkOw0KIA0KLQlpZiAoZ3B1X2luZm8uYXNpY19pZCA9
PSAweDE2MzYpIHsNCi0JCWlmIChhbWRncHVfc2V0X3Rlc3RfYWN0aXZlKCJCYXNpYyBUZXN0cyIs
DQotCQkJCQkgICAiRGlzcGF0Y2ggVGVzdCIsDQotCQkJCQkgICBDVV9GQUxTRSkpDQotCQkJZnBy
aW50ZihzdGRlcnIsICJ0ZXN0IGRlYWN0aXZhdGlvbiBmYWlsZWQgLSAlc1xuIiwNCi0JCQkJQ1Vf
Z2V0X2Vycm9yX21zZygpKTsNCi0NCi0JCWlmIChhbWRncHVfc2V0X3Rlc3RfYWN0aXZlKCJCYXNp
YyBUZXN0cyIsDQotCQkJCQkgICAiRHJhdyBUZXN0IiwNCi0JCQkJCSAgIENVX0ZBTFNFKSkNCi0J
CQlmcHJpbnRmKHN0ZGVyciwgInRlc3QgZGVhY3RpdmF0aW9uIGZhaWxlZCAtICVzXG4iLA0KLQkJ
CQlDVV9nZXRfZXJyb3JfbXNnKCkpOw0KLQl9DQotDQogCXJldHVybiBDVUVfU1VDQ0VTUzsNCiB9
DQogDQpAQCAtMjk5Miw3ICsyOTc4LDcgQEAgdm9pZCBhbWRncHVfbWVtc2V0X2RyYXcoYW1kZ3B1
X2RldmljZV9oYW5kbGUgZGV2aWNlX2hhbmRsZSwNCiAJcmVzb3VyY2VzWzFdID0gYm9fc2hhZGVy
X3BzOw0KIAlyZXNvdXJjZXNbMl0gPSBib19zaGFkZXJfdnM7DQogCXJlc291cmNlc1szXSA9IGJv
X2NtZDsNCi0JciA9IGFtZGdwdV9ib19saXN0X2NyZWF0ZShkZXZpY2VfaGFuZGxlLCAzLCByZXNv
dXJjZXMsIE5VTEwsICZib19saXN0KTsNCisJciA9IGFtZGdwdV9ib19saXN0X2NyZWF0ZShkZXZp
Y2VfaGFuZGxlLCA0LCByZXNvdXJjZXMsIE5VTEwsICZib19saXN0KTsNCiAJQ1VfQVNTRVJUX0VR
VUFMKHIsIDApOw0KIA0KIAlpYl9pbmZvLmliX21jX2FkZHJlc3MgPSBtY19hZGRyZXNzX2NtZDsN
Ci0tIA0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
