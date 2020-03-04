Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA0C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B822072A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 09:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UQMHy4jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B822072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDEB89E52;
	Wed,  4 Mar 2020 09:36:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C401F89E52
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 09:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/fp3d/geeT029fMFbiihy9dvf34hHbGDwfymcyNeOZ2UiB5pbUjKSsKn4tJBAlMPbS2Omf7ua21295bpSETNJlCFNSyrFDXdl8XfAI7dRL6o1a1cvZ89gbrFzPzxYaisg/6pkugr1A4EDWO8851KlBvMuWNx3J7FV8Xb6ApSa40Qietu9f8/AE+qJfLMx9OoKu0AUEgD25y6aBV5dWjaq7aw+b1ZYcVYdKd/mcyecPKutOposNCfKeAmjuGd0HdfGzJ918KaS9llGCnWoYBUdn6T+N/97d8Hp/eE1KHCXp9TJxNK7VF67OSkKpQpWdJ9B1XiyQRROMn5Wuwk22wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDGwOGfr8wVo1EUjsTo1k5XuOUPyt6Q9VuEKoC22C8Q=;
 b=C4+C88EqTmqDWfPu7GOH/Yli8vO2hrA7Bi/aDxFjdNrD7ndAEcsniTC/gqdcsvLX8Kh9/azj97PkznK3jLlbW7x57hmW379pZq1cchNgUMRA055rCosRbVLpcnjF6uiqmo1wco6DeARmAeyC0cgAO/Z4MyegCktB++twVDCT4XWBeOKqlkoC38W6Rn+hE4rxEzEeQ0Xl9lPakwlP0OemEZJG2ceeGncz3XxhWNLDRyX/OQ/92jbPySx5rtBLPld0cA+W5/dhPaYszSJCPaD70RMAqnLn6FBAv7+YRD4Hdn6izzN7qmZq6fh56m7Y3c9ucGSPMUrwD/ktFQ1/ialyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDGwOGfr8wVo1EUjsTo1k5XuOUPyt6Q9VuEKoC22C8Q=;
 b=UQMHy4jIpzuI9r7Qa95KrxPU2Y8ywHthqM/WZrxzv0yV4SQiyZbVoZDZh4D5w7z2WR9huDna8kE3i71bSyCIsYW4li6uJd78yFJiN+4ZPx3QWMsw95IGElWv9ZbaMGenuLCfzUf538GC0GJ2nX8C8k204foeeVaQN7KL6/X1Cn4=
Received: from MWHPR1201MB2479.namprd12.prod.outlook.com (2603:10b6:300:df::9)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 09:36:02 +0000
Received: from MWHPR1201MB2479.namprd12.prod.outlook.com
 ([fe80::4016:eacd:d50a:4d2d]) by MWHPR1201MB2479.namprd12.prod.outlook.com
 ([fe80::4016:eacd:d50a:4d2d%3]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 09:36:02 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
Thread-Topic: [PATCH] drm/amdgpu: correct ROM_INDEX/DATA offset for VEGA20
Thread-Index: AQHV8gcPstPElIgC8k6kQ6xAOBt8gag4LCqg
Date: Wed, 4 Mar 2020 09:36:02 +0000
Message-ID: <MWHPR1201MB2479C318F928136A6C3DA98791E50@MWHPR1201MB2479.namprd12.prod.outlook.com>
References: <20200304092649.6109-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200304092649.6109-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-04T09:35:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0d19f788-d5e5-4a9d-8960-00006d36e552;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-04T09:35:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 41960f37-7ba0-4957-a926-00001f629d73
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Candice.Li@amd.com; 
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b719ed49-2823-4034-9345-08d7c01f7433
x-ms-traffictypediagnostic: MWHPR1201MB2558:|MWHPR1201MB2558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2558C9A3378784A28FEF076891E50@MWHPR1201MB2558.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(66476007)(64756008)(66556008)(26005)(2906002)(55016002)(9686003)(66446008)(478600001)(76116006)(66946007)(8676002)(81166006)(81156014)(8936002)(4326008)(86362001)(186003)(7696005)(110136005)(33656002)(52536014)(53546011)(6506007)(71200400001)(5660300002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB2558;
 H:MWHPR1201MB2479.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHl7GG7fCUFlnnKI7FYLL9o6nFHkKxQokHXzIdxTKxD4z75OUNq/gB8np+Yq482+iLMKsTjlT11Cm5WJenbg19zf2wJyfYFTov+dE9iW5+KGkRXbBLAbM5xXDoxIocVCqAjypBKwtOvYGq1Fmx2xIZl94SNmWlCcizF51LbRcqpkb7ZIeR+NYxJ1Ar0vCT7CS1A2U/zOg17ym1iWLGdziuQysQmZInTk24GyApHEn3BAxfYiwIraYWTL0jAnboq6gr4Zzue/A8CiK5KUzt79GwbCieVmYd/3ZxMMtHgJrie/d2vZ/oXvgfJ6LS6xwV7EQcWY20gC9b8Zp+HPPOmTMpN0fejy+rjzxt9toqQ1kQq+6FsviYF2Vz2VoJysaxEQtpX1cRZbqkECUubOt+PPE+mo7E7FGlgNziQrtxJYgPRi35NSFzae+3U2R/wMRYk0
x-ms-exchange-antispam-messagedata: hSiQ9zSJ88FPjaJYA+M644JPdHKet7HzSGtbaid5eyi3ll8OVWFVT7G22HzJstukysCRE6VsrhfHW6h9flASl7mu67zw25D8xZ27xWyHboLVo2k2S17P/6Wz3wo1Lp59w4CEgSaeMfsAYUuKmveKCw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b719ed49-2823-4034-9345-08d7c01f7433
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 09:36:02.0961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4uwVIVf4xcIwTi/wXfO16g5hq0vA+pqrsYIO1vcRmZqwTQBolHekm8tJv+UzfUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
ZXN0ZWQtYnk6IENhbmRpY2UgTGkgPENhbmRpY2UuTGlAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBD
YW5kaWNlIExpIDxDYW5kaWNlLkxpQGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+IA0KU2VudDog
MjAyMMTqM9TCNMjVIDE3OjI3DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExp
LCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+DQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogY29ycmVjdCBS
T01fSU5ERVgvREFUQSBvZmZzZXQgZm9yIFZFR0EyMA0KDQpUaGUgUk9NQ19JTkRFWC9EQVRBIG9m
ZnNldCB3YXMgY2hhbmdlZCB0byBlNC9lNSBzaW5jZSBmcm9tIHNtdWlvX3YxMSAodmVnYTIwL2Fy
Y3R1cnVzKS4NCg0KU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDI1ICsr
KysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQppbmRleCA2
YjcxNzY5MWQ1NTQuLmY1ZTExYTU2MTU4YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMNCkBAIC04OSw2ICs4OSwxMyBAQA0KICNkZWZpbmUgSERQX01FTV9QT1dFUl9DVFJMX19SQ19N
RU1fUE9XRVJfQ1RSTF9FTl9NQVNLCTB4MDAwMTAwMDBMDQogI2RlZmluZSBIRFBfTUVNX1BPV0VS
X0NUUkxfX1JDX01FTV9QT1dFUl9MU19FTl9NQVNLCQkweDAwMDIwMDAwTA0KICNkZWZpbmUgbW1I
RFBfTUVNX1BPV0VSX0NUUkxfQkFTRV9JRFgJMA0KKw0KKy8qIGZvciBWZWdhMjAvYXJjdHVydXMg
cmVnaXRlciBvZmZzZXQgY2hhbmdlICovDQorI2RlZmluZQltbVJPTV9JTkRFWF9WRzIwCQkJCTB4
MDBlNA0KKyNkZWZpbmUJbW1ST01fSU5ERVhfVkcyMF9CQVNFX0lEWAkJCTANCisjZGVmaW5lCW1t
Uk9NX0RBVEFfVkcyMAkJCQkJMHgwMGU1DQorI2RlZmluZQltbVJPTV9EQVRBX1ZHMjBfQkFTRV9J
RFgJCQkwDQorDQogLyoNCiAgKiBJbmRpcmVjdCByZWdpc3RlcnMgYWNjZXNzb3INCiAgKi8NCkBA
IC0zMDQsNiArMzExLDggQEAgc3RhdGljIGJvb2wgc29jMTVfcmVhZF9iaW9zX2Zyb21fcm9tKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCAgew0KIAl1MzIgKmR3X3B0cjsNCiAJdTMyIGksIGxl
bmd0aF9kdzsNCisJdWludDMyX3Qgcm9tX2luZGV4X29mZnNldDsNCisJdWludDMyX3Qgcm9tX2Rh
dGFfb2Zmc2V0Ow0KIA0KIAlpZiAoYmlvcyA9PSBOVUxMKQ0KIAkJcmV0dXJuIGZhbHNlOw0KQEAg
LTMxNiwxMSArMzI1LDIzIEBAIHN0YXRpYyBib29sIHNvYzE1X3JlYWRfYmlvc19mcm9tX3JvbShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJZHdfcHRyID0gKHUzMiAqKWJpb3M7DQogCWxl
bmd0aF9kdyA9IEFMSUdOKGxlbmd0aF9ieXRlcywgNCkgLyA0Ow0KIA0KKwlzd2l0Y2ggKGFkZXYt
PmFzaWNfdHlwZSkgew0KKwljYXNlIENISVBfVkVHQTIwOg0KKwljYXNlIENISVBfQVJDVFVSVVM6
DQorCQlyb21faW5kZXhfb2Zmc2V0ID0gU09DMTVfUkVHX09GRlNFVChTTVVJTywgMCwgbW1ST01f
SU5ERVhfVkcyMCk7DQorCQlyb21fZGF0YV9vZmZzZXQgPSBTT0MxNV9SRUdfT0ZGU0VUKFNNVUlP
LCAwLCBtbVJPTV9EQVRBX1ZHMjApOw0KKwkJYnJlYWs7DQorCWRlZmF1bHQ6DQorCQlyb21faW5k
ZXhfb2Zmc2V0ID0gU09DMTVfUkVHX09GRlNFVChTTVVJTywgMCwgbW1ST01fSU5ERVgpOw0KKwkJ
cm9tX2RhdGFfb2Zmc2V0ID0gU09DMTVfUkVHX09GRlNFVChTTVVJTywgMCwgbW1ST01fREFUQSk7
DQorCQlicmVhazsNCisJfQ0KKw0KIAkvKiBzZXQgcm9tIGluZGV4IHRvIDAgKi8NCi0JV1JFRzMy
KFNPQzE1X1JFR19PRkZTRVQoU01VSU8sIDAsIG1tUk9NX0lOREVYKSwgMCk7DQorCVdSRUczMihy
b21faW5kZXhfb2Zmc2V0LCAwKTsNCiAJLyogcmVhZCBvdXQgdGhlIHJvbSBkYXRhICovDQogCWZv
ciAoaSA9IDA7IGkgPCBsZW5ndGhfZHc7IGkrKykNCi0JCWR3X3B0cltpXSA9IFJSRUczMihTT0Mx
NV9SRUdfT0ZGU0VUKFNNVUlPLCAwLCBtbVJPTV9EQVRBKSk7DQorCQlkd19wdHJbaV0gPSBSUkVH
MzIocm9tX2RhdGFfb2Zmc2V0KTsNCiANCiAJcmV0dXJuIHRydWU7DQogfQ0KLS0NCjIuMTcuMQ0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
