Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A91C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4441B205C9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4441B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6A36E338;
	Fri, 15 Nov 2019 09:56:49 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680081.outbound.protection.outlook.com [40.107.68.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD086E338
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 09:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPt1PPTGpvV0lkNNI7z5EDj23iK/s4xuMcT0EKaHrjmaTFDqkzayO8c0jLv0OJvZ/i4BpBAsc5bCpTDDeX6fsAYw3jUWoHkgaCdfYElmZ3okjJFCDTF/Hb7dtbmOgYlbjMu3TPPA/EwdMyhaT/aWd3f24jyBkK7gC+u1yoBM/FUXT/4Ag5iCsZhWJ64neqhMuq8oSeVQaGxPNpCpGL9Ytt1uY7QFu6HIb0M6Wvz4mTVDSUlfcbY2LsnfITCpOis4ro0wofEt+wV3tVzhOtGySHyJA/9vS1gaeKS/ksEiAxTiYXDU3Uc0UisIfy+P6B+4qmg6SO5UXQD3vp6FPOP9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAiYvYlkePfUF8fSRP5P34yFOoKRAI3ik93B8NiafOM=;
 b=DhgM+ybyl87GpYuBEJw5mz/Q4I46iDEchHPP6nwQJ0IllQ01o1ANd5A91J2rGbuoF5aIWdJbk02fZxrL4+MWvz/OWt+Izq+MzEXtF+k5K87FRJAlxuMi7f2j1lijeLHJAGELBVustkOD7rPPTQ8h8DtcLn+BqVkYxEzC3nHYyuEOQr10lrVloUwKSE+hUV9d1wMFa2PN+WBRDbsBHgMiBZ/dqFu1fBSVTyW/M4MtRx3Dq+RewqclS5UOLYsyeQ14MHDibZ38aRz8DKuWgpBzRoGn2wOPFPNTSi/e7wIW1F0puw9Tdw3+0sl/eWUSjwsFo2yhAix0DlbnE4fgV1c0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4109.namprd12.prod.outlook.com (52.135.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 09:56:46 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 09:56:46 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 08/12] tests/amdgpu: expand secure param for exec_cs_helper
Thread-Topic: [PATCH 08/12] tests/amdgpu: expand secure param for
 exec_cs_helper
Thread-Index: AQHVm2XAYOwuXkygZkmzDUlCv54otaeMhUGA
Date: Fri, 15 Nov 2019 09:56:46 +0000
Message-ID:
 <MN2PR12MB33095349A96C23BC1862AC96EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-8-git-send-email-aaron.liu@amd.com>
In-Reply-To: <1573788895-3936-8-git-send-email-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2430.004)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94844b37-2a48-494e-e7ff-08d769b2207c
x-ms-traffictypediagnostic: MN2PR12MB4109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4109591E139F714F93AD6E4EEC700@MN2PR12MB4109.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(6436002)(478600001)(14454004)(14444005)(256004)(102836004)(6116002)(6246003)(99286004)(25786009)(2906002)(3846002)(7696005)(446003)(11346002)(305945005)(74316002)(7736002)(71200400001)(71190400001)(76116006)(6636002)(26005)(186003)(76176011)(6506007)(486006)(476003)(52536014)(86362001)(5660300002)(81156014)(316002)(4326008)(33656002)(66946007)(66066001)(66446008)(6862004)(229853002)(66556008)(55016002)(9686003)(8936002)(8676002)(64756008)(54906003)(81166006)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4109;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VRqxw3R+yAqXnKHslfvV+VUdvDV1GFjehai6ZOGRYCiIa/uB4eQdFoTFzF5ANl1JLzaciGChPU4nYAuwbc8/Zq3HsDDm0B6/L/W/em15pAir1zV0oqhKD+YrEn34bctwtxRRHaixTGfXRiI7BPZu1a14uwvKrXMLXq9M4WawvW4vxSiROorrsgw31QaSx6DMmLpoStOhONvWt8nAfyCH2l5Z005S6u7eKgUA0QBGlEPiI65ZKJkMEYlOT9WqHw27mQ/fVqY2wKFYyyMSVXRDtKRvKfSQ+5KxqJnG7tEJcc9Ioj2C9K29wTjWLaUr+KyUVc/GkNxxLgrI/tI/Ij9Xuw34+jSo5yXJk35AOzteHrbOeiK1OPMsk+r5TK9IO1TmvRWLXaFniQmrWeceRpke3AGup6bN6OXPHXQcEm5qj6GYvNsg7QKM6UfJJTQgI9hY
Content-ID: <20D1C2DAE195DF43A16197553C4B4649@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94844b37-2a48-494e-e7ff-08d769b2207c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:56:46.5586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFUqrsfMxWfNu5OaGoE1PLubD7fdRyLyKeUJGB7oI5nceplVRix2mlzciPHZKxngu/zJdBWSqvp0l72bNeWiFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAiYvYlkePfUF8fSRP5P34yFOoKRAI3ik93B8NiafOM=;
 b=ekMe6+JC7SlIq1OGkVRCLwOqTnKlun9bZANio4i9nkRXt11c+M3/VgvhJOSpJ7XOauMUwiNrZlVnoaGQPEMJAVZsayStptxkwCE5RAJrCxvGInw/dj4PFF+zDP+a2CfFfvZwiHQmrU+/HbasOzYRfuCCht7Il9vvTqACFrW0lno=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
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
Cc: "Olsak, Marek" <Marek.Olsak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115095646.yBW0ItEy4igyvA6LJiNCl8Azf-S92NoWWEUD4bbne0Y@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTFBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBUaGlzIHBhdGNoIGV4cGFuZHMgc2VjdXJlIHBhcmFtIGZvciBhbWRncHVfdGVzdF9leGVj
X2NzX2hlbHBlcl9yYXcuCj4gVGhlIGZsYWcgaXMgdHJhbnNmZXJlZCB0byBrZXJuZWwgd2l0aCBj
cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPgoKQWNr
ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cgo+IC0tLQo+ICB0ZXN0cy9hbWRn
cHUvYmFzaWNfdGVzdHMuYyB8IDggKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L2Jh
c2ljX3Rlc3RzLmMgYi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwo+IGluZGV4IDUxNTQ4MTIu
Ljk1NmJlOTMgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKPiArKysg
Yi90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwo+IEBAIC0xMjkwLDcgKzEyOTAsOCBAQCBhbWRn
cHVfdGVzdF9leGVjX2NzX2hlbHBlcl9yYXcoYW1kZ3B1X2RldmljZV9oYW5kbGUgZGV2aWNlX2hh
bmRsZSwKPiAgCQkJICAgICAgIHVpbnQzMl90ICpwbTRfc3JjLCBpbnQgcmVzX2NudCwKPiAgCQkJ
ICAgICAgIGFtZGdwdV9ib19oYW5kbGUgKnJlc291cmNlcywKPiAgCQkJICAgICAgIHN0cnVjdCBh
bWRncHVfY3NfaWJfaW5mbyAqaWJfaW5mbywKPiAtCQkJICAgICAgIHN0cnVjdCBhbWRncHVfY3Nf
cmVxdWVzdCAqaWJzX3JlcXVlc3QpCj4gKwkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2NzX3JlcXVl
c3QgKmlic19yZXF1ZXN0LAo+ICsJCQkgICAgICAgYm9vbCBzZWN1cmUpCj4gIHsKPiAgCWludCBy
Owo+ICAJdWludDMyX3QgZXhwaXJlZDsKPiBAQCAtMTMyNCw2ICsxMzI1LDcgQEAgYW1kZ3B1X3Rl
c3RfZXhlY19jc19oZWxwZXJfcmF3KGFtZGdwdV9kZXZpY2VfaGFuZGxlIGRldmljZV9oYW5kbGUs
Cj4gIAlpYl9pbmZvLT5zaXplID0gcG00X2R3Owo+ICAKPiAgCWlic19yZXF1ZXN0LT5pcF90eXBl
ID0gaXBfdHlwZTsKPiArCWlic19yZXF1ZXN0LT5mbGFncyA9IHNlY3VyZSA/IDEgOiAwOwo+ICAJ
aWJzX3JlcXVlc3QtPnJpbmcgPSBpbnN0YW5jZTsKPiAgCWlic19yZXF1ZXN0LT5udW1iZXJfb2Zf
aWJzID0gMTsKPiAgCWlic19yZXF1ZXN0LT5pYnMgPSBpYl9pbmZvOwo+IEBAIC0xMzc0LDcgKzEz
NzYsNyBAQCBhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUg
Y29udGV4dF9oYW5kbGUsCj4gIAlhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcl9yYXcoZGV2aWNl
X2hhbmRsZSwgY29udGV4dF9oYW5kbGUsCj4gIAkJCQkgICAgICAgaXBfdHlwZSwgaW5zdGFuY2Us
IHBtNF9kdywgcG00X3NyYywKPiAgCQkJCSAgICAgICByZXNfY250LCByZXNvdXJjZXMsIGliX2lu
Zm8sCj4gLQkJCQkgICAgICAgaWJzX3JlcXVlc3QpOwo+ICsJCQkJICAgICAgIGlic19yZXF1ZXN0
LCBmYWxzZSk7Cj4gIH0KPiAgCj4gIHZvaWQKPiBAQCAtMTQ2Niw3ICsxNDY4LDcgQEAgYW1kZ3B1
X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKGFtZGdw
dV9kZXZpY2VfaGFuZGxlCj4gIAkJCWFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVscGVyX3JhdyhkZXZp
Y2UsIGNvbnRleHRfaGFuZGxlLAo+ICAJCQkJCQkgICAgICAgaXBfdHlwZSwgcmluZ19pZCwgaSwg
cG00LAo+ICAJCQkJCQkgICAgICAgMSwgcmVzb3VyY2VzLCBpYl9pbmZvLAo+IC0JCQkJCQkgICAg
ICAgaWJzX3JlcXVlc3QpOwo+ICsJCQkJCQkgICAgICAgaWJzX3JlcXVlc3QsIHNlY3VyZSk7Cj4g
IAo+ICAJCQkvKiB2ZXJpZnkgaWYgU0RNQSB0ZXN0IHJlc3VsdCBtZWV0cyB3aXRoIGV4cGVjdGVk
ICovCj4gIAkJCWkgPSAwOwo+IC0tIAo+IDIuNy40Cj4gCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
