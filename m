Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4AC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 01:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CFE21882
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 01:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CFE21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5696F829;
	Fri,  8 Nov 2019 01:54:59 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720065.outbound.protection.outlook.com [40.107.72.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D75D16F82B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 01:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gonTyHTMq/uDqBqVAwPs64oUxhspMMRhbWDm/0Id7AwfnzboCqEPM4d3qjv1Otfb9bP/7RbC4QbKjuPAm95W8gM0Y3Tea+MMI7ZWAOC/zg3gnzUjNuUyQbbU2tns8WxxaimfBp9OX1Ev3wK+Pid+fzpH55H73R7DJS1I05pIvJtKxc/Jdx2J2zuR2NeE0qVn8nHcbXymePyCzmGbjF/qnyJsAt5cddT+IVzrSd6JH47oFkEadjg4m8BzkGw3ZpCpGF/fGB8mRkdw89CzY1fpY9HPAtFHV1/n6rMkK5taUz27dDkmw3/kWphQQwssYemiXwwLddaBsxMtsAWy+pK33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkgkw9cSJSP1EKe2OZbLdrmDiR3AwrVnW/j/p3zfPlc=;
 b=Ptp3RVTSlE/IkHWqvqYZwGnEQmKMLFKVPcnvcqpj+JON+S9giNfnDnCBZWljlJhneR1F9Z+tWH7SyAIkAHTHtqLzK1I1WfGVZwV8aC74R102YDBFXOwmTLHM0SxX236kujCx7/efFTXCSICpbjt8VcATWo8NfMTN4PdBQMvcHhBvOrn7gRbzzx0PbyiXfMyA4lMSBP6a5N7BcRX0tk6LENrEGOAnbN7FLbmTQjn4cGIIKzGaWIxYXNXzWCL+/duJAsaIIhXguAWwX+NNhaAq24GyeXAGPCqCGM7fITtYoOKS9FdgBkf9eubh6BqXGZZNeXafp+8v58SIjY4VUmh17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 8 Nov 2019 01:54:56 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 01:54:56 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: allow direct upload save restore list for raven2
Thread-Topic: [PATCH] drm/amdgpu: allow direct upload save restore list for
 raven2
Thread-Index: AQHVldeFrE70cIKU1UicTyTAEATq3w==
Date: Fri, 8 Nov 2019 01:54:56 +0000
Message-ID: <20191108015432.11840-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:2e::21) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 289a168e-858e-4e36-70c4-08d763eea74e
x-ms-traffictypediagnostic: MN2PR12MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3663B8DB82C0EDBB14305CE2FD7B0@MN2PR12MB3663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(66066001)(86362001)(316002)(186003)(110136005)(66946007)(64756008)(4326008)(66556008)(6116002)(2906002)(3846002)(36756003)(6636002)(2501003)(486006)(66446008)(5660300002)(99286004)(4744005)(1076003)(25786009)(476003)(26005)(14444005)(71190400001)(305945005)(6506007)(2616005)(7736002)(386003)(66476007)(71200400001)(81166006)(8676002)(52116002)(6486002)(81156014)(102836004)(256004)(50226002)(478600001)(6436002)(8936002)(6512007)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ii2ixZIovf5RPquSVNUjJ/MtfNruYNEZovInF4WalfUg3rUXmv7anf3dxuePKwPpPPOkVQvuVuds4ekqJMR5lhmTR29yzkDe2ar/xLKyXemaShn4VaiGmj3y0/k5L9tHXhRbuPzpXIW9DfkHJoddAj0K2ogOpLmzk+qlEVYvnOcLvJNe9rzdbLlJ4wTMSrCIhn03llaOqmDEoLpY0EpBX+AymP2709FNlP94YDiOWgngncoMQsh6/2PVTFZF+KYdbZCFjd+vqfd3cePe/U7Pn+eLXr3WA6EsXjuIc/Cd0lwNr+oKA9UETRNcGoDjKQdV/q0gcJIEIXwJWYXd7PvwxJYnZp3muPc1rgKuuklDOm6dwPqoPD9E+7GsiKKO3B+Qh/gUKLBGCbhPf/0saIwRLVzjRTRm63mDHaHalnIOGBhT1wzoO7F6n63oZpIOH3yC
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289a168e-858e-4e36-70c4-08d763eea74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 01:54:56.2473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUGPNd0Hw0xl88ifOScVn10EXrcrMg6MJ+wijPMreSYrkGAzQfsWXM+gexB+BjHz+tlXrmVo6Iq/8kWXW9bBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkgkw9cSJSP1EKe2OZbLdrmDiR3AwrVnW/j/p3zfPlc=;
 b=oLV10+kkpSWwiNwKhZRiZRg6i+KikFyZPELgBZxTvFj/dpaZ88tfKYMBde3AcxtEuHyGFnRahJoQ7iejEvjDmSRrvGuJqpcJqxcPCe5+r83O5tVg8Rmfe1nhdjpRvAwliKantmjg1xZBGe1tJQqxoYaCH25BgiEJjScARYb2Rfs=
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
Message-ID: <20191108015456.pBbhtTvXs8T9eh4D-8aVmYcrn9VKJaFuDGPoOyFM9pg@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KCkl0IHdpbGwgY2F1c2UgbW9k
cHJvYmUgYXRvbWJpb3Mgc3R1Y2sgcHJvYmxlbSBpbiByYXZlbjIgaWYgaXQgZG9lc24ndAphbGxv
dyBkaXJlY3QgdXBsb2FkIHNhdmUgcmVzdG9yZSBsaXN0IGZyb20gZ2Z4IGRyaXZlci4KU28gaXQg
bmVlZHMgdG8gYWxsb3cgZGlyZWN0IHVwbG9hZCBzYXZlIHJlc3RvcmUgbGlzdCBmb3IgcmF2ZW4y
CnRlbXBvcmFyaWx5LgoKQ2hhbmdlLUlkOiBJMWZlY2UxYjljNjFmN2ExM2VlYzk0OGYzNGViNjBh
OTEyMDA0NmJjMgpTaWduZWQtb2ZmLWJ5OiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0ICsrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCA0ZWQzMWU5YTM5OGMuLmRkZTk3MTNjMWQ2NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0yNzI5LDcgKzI3MjksOSBA
QCBzdGF0aWMgdm9pZCBnZnhfdjlfMF9pbml0X3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCSAqIEFuZCBpdCdzIG5lZWRlZCBieSBnZnhvZmYgZmVhdHVyZS4KIAkgKi8KIAlpZiAoYWRl
di0+Z2Z4LnJsYy5pc19ybGNfdjJfMSkgewotCQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBf
VkVHQTEyKQorCQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTEyIHx8CisJCSAgICAo
YWRldi0+YXNpY190eXBlID09IENISVBfUkFWRU4gJiYKKwkJICAgICBhZGV2LT5yZXZfaWQgPj0g
OCkpCiAJCQlnZnhfdjlfMV9pbml0X3JsY19zYXZlX3Jlc3RvcmVfbGlzdChhZGV2KTsKIAkJZ2Z4
X3Y5XzBfZW5hYmxlX3NhdmVfcmVzdG9yZV9tYWNoaW5lKGFkZXYpOwogCX0KLS0gCjIuMTcuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
