Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E339C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA802073B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA802073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0376E330;
	Fri, 15 Nov 2019 09:55:30 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740071.outbound.protection.outlook.com [40.107.74.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8B06E330
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 09:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8gWV5FJxsYKXz9GoH0qXNU9WotCURr5u86mZChZ39F98xtkVMS7PqtFDNcjrk+Fpn8pNNoOQHdfSwh16S/zhKWDxLhwQCLTnH8l63Icp0ba0p8lq1gl0o/UR3h5akj0tVbfEp/g7aVcaMwXhxAhLbxvPLhU9eV3mzBT+4sshzLAB2O95m1jLu3KgpMFRoGCAHDCgLBUThMCq5MRvecqJobrgfjv6qlRz3vfkQp47qo+u9PyNcHM+FH6TXWPtXv/rVahha9JQS9US4YJG352/zPnK/681Ua3SHSruG4DNqyCId2ETplfNFID72Yf14/67IithpITJ8e8Crj1sMhd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAiYvYlkePfUF8fSRP5P34yFOoKRAI3ik93B8NiafOM=;
 b=gWHCalzFefWvLZ2+1PHOL2PT3Sg1jiFWFVrCK+CH1ghTlpwEVJvnk/3lG8/kPxEV0+FhT8JBrnkV3+AwghSwkIAnT22zEo1Z6QtSb5FMWrmspOuw5NwnWgwlTHKgxdA8tf67dQp3zEaGtrw+FNe4utIAdRZ0v0LlpqTZLnP/KF5wuACXaxfxOPVftqqW6elpZgo+as0++LEl/lz9/AnluFjcokJkbqhfMXPGlHDU4Frtq8EzwoqnNIgjh7HkjYV72h0PaCraoU9Zid23KhFHi7DDaFDnDrGrDXLU7kdOtfj+b3FkjyLlgUEHysPWp/Lh4ZPobPb/SyuWKWPbjOMthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4109.namprd12.prod.outlook.com (52.135.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 09:55:27 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 09:55:27 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 08/12] tests/amdgpu: expand secure param for exec_cs_helper
Thread-Topic: [PATCH 08/12] tests/amdgpu: expand secure param for
 exec_cs_helper
Thread-Index: AQHVm2XAYOwuXkygZkmzDUlCv54otaeMhOAA
Date: Fri, 15 Nov 2019 09:55:27 +0000
Message-ID:
 <MN2PR12MB33093E5ED305A790F3D328E6EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 0546be6c-f99a-487e-4541-08d769b1f127
x-ms-traffictypediagnostic: MN2PR12MB4109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4109B146A1F1BB406D258E54EC700@MN2PR12MB4109.namprd12.prod.outlook.com>
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
x-microsoft-antispam-message-info: vyJpd4eNmg2UiUbQ5B9YKoZ6GnEfBw86HM9MjQsGAXzQNzdO5+a5qHUDeM/44I/zfwb+JvcSBEtYF7Soji54KpXoHhCJI5scvyVFjn15lcOmcicFfM4u9XmGi9G6lVJMj/MXqSukBI+kB4Ct8w4oQUIVV5CUbLE1MvfNQsPOrq0hyj/hpBCAQNJ76BzG8d0qgmxzxZuSYf4IfrkfiNube/GVOYLnXkvDPSdeG1WkVRdsMVUt+2S7ZTlPqV7nJGCI4mhNYMyksm366qjfuk2D141UvtxNe+S9eYKzajgoXym/opYtYIuMnkydTonhT8pQRzg8bSriff6zmEirhUHTmYlIEJ5QpEpJuZwCHw9CcH3WsUNIb+kX1BYtvtMtnCz2xlJpYz9uLFpIGpwd/NOtO3O7YaJawAXyCm41wuJTv6RGRFpsba7Jm6qWO6msoq51
Content-ID: <BE7734A18FDD6F418A17857ACB62F7C1@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0546be6c-f99a-487e-4541-08d769b1f127
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:55:27.0825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjCK6fqNYy6fHX8G29zxnFK+2YcROKPg+P5r/VOeBwLYZ82g62pOGjSKf5L6fNX+XqpQ2wRp1ibve0bu41IQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAiYvYlkePfUF8fSRP5P34yFOoKRAI3ik93B8NiafOM=;
 b=rz9rOuobyHoD4+jCDwXVw8genz2bm86CRodn0CKR6jPLH2NyU/LaUFpBn8rIfeTqdK4zHMYsI3H/hOAHds71bHPkd+k1Ayv4/53k9h64yaWYCGDqtw7HrSQDvWegibu+9kki6Wcgj+zAXXtOvf4pqySJIu59HypniXmuxFSZjiM=
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
Message-ID: <20191115095527.xCSWCF8BrGu_ygDnp_P-anGh89JiLyt_quu-2GJxo9k@z>

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
