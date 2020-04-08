Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B106C2D0EC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 02:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276E2206BE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 02:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nfQb5SwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276E2206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8E76E192;
	Wed,  8 Apr 2020 02:27:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0756C6E192
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 02:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUQlbetO+fzj+b17t0ekf2W84O5aLkk/0x8i5QdoTx723rW/jjiA8EyhEuCk/wKx4GqVvNceZDv9ten5S2uioItPN1jfHzrEKQMn3OZxnD66ZlzvK3+cDjcTP/7KBMbAP6drMMXVkX8wbCh0E3OhTejt5bHj4tN6s6BhY62TXx2nBWaLgSzFNs5no7lK9dDNLkDpUeCYkRW/pFBx97Om038rdZTsTnx+B1IotByyAPJjk3YG6Py+n523c4R27SZ5syaHkU9rR+ELc5VbALRCMwjKROZnjF6cbEVL4jZFCSQSer85v6cR7U12zv5+cN4p6UIHjVNcvfXw26BQE+ctGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKWESue8XBjacYHRXJbyBs/wnU+io95fpdUH+AD3u3o=;
 b=GxFq3Fccn5pcflK7y8qgFqzpeSM5Aka2qVAcniyVm8FQtr2z/BD88EvUyvR096MB2Y6PowDu2nfk7Kt9FYY6XanaVnfI/TLPjrMn3UmwEEM/Rxp18ZFGDpeccAkt6fEzznR2Npa238DPBi1BRSRVzfqy+KH7cP+UX+pa5Sc47TRdV+Hf80m6Z3EVT+FqEFoWyYqqB/GxSon7/HNrbIGWtVMaE6oIPQkUKizYAf2UNjbGFzyksQRjSyPJDz3L9qLoMwYAbZl6iln9NAVZMTiuXWTWRY/S8wHbpIXyCiVZXCTg2Iz2cHxTGDcu1ndbqsFwNaFrHCl8VFjqimkqtcBmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKWESue8XBjacYHRXJbyBs/wnU+io95fpdUH+AD3u3o=;
 b=nfQb5SwHgBkFzO3jKIMLHX0HRNhMYolfvaRq6OnOJ8JclgleYuU5cC0p9yP0b00X/CO/TCsYJqqsyhacWnTuuRWImh+gu57S7AMObuExIEXVpGH/qocyTUXJYroQlrZYmR2T4snAUe1Ql+SPtHRlyCHRhtHsOrWbFqsrEvS6KqA=
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Wed, 8 Apr
 2020 02:27:38 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 02:27:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Topic: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Index: AQHWCW1+xKCgFizMkEyLyz6Szs7fQqht06sAgACm7jA=
Date: Wed, 8 Apr 2020 02:27:37 +0000
Message-ID: <MN2PR12MB3536834FA1D028F7C9371D67FBC00@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <0233f59a-a225-75c0-22f6-7c61e3b70475@amd.com>
In-Reply-To: <0233f59a-a225-75c0-22f6-7c61e3b70475@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7f2f8437-70af-400b-bb2d-000065d10233;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-08T01:40:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a0ebc35-5ec9-44e6-6cde-08d7db6467d3
x-ms-traffictypediagnostic: MN2PR12MB4375:|MN2PR12MB4375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4375CC604FED561E54896CEDFBC00@MN2PR12MB4375.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39850400004)(366004)(396003)(4326008)(7696005)(66946007)(52536014)(53546011)(110136005)(66476007)(66556008)(81166006)(6636002)(6506007)(86362001)(76116006)(478600001)(66446008)(54906003)(64756008)(316002)(2906002)(55016002)(71200400001)(8676002)(26005)(9686003)(186003)(33656002)(8936002)(15650500001)(81156014)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7mTMg5uWZCJ0WiX3k4MQJVyWnC6s1EYn59qACWVbomgMN86YWuYwfSENf03RCvH/wTbqgsSPWMeyPUDvd4kBN8GMQz7lFXq0fjzxWfGyrj/UkYD4DTLRSV62V3LuMp5/VeUgLyz4UMyhIr1uUEACZTh05Xw3zpbIo2EsJHIImgQGlDNjjTNRY6S5qlj9pPtjg6SABsOpzq2j8cndH363msPeN4WRdZ1zi3GjMcUKqHmISDomPUAUDA8ToosJ3tvrHkFoV4HJ8Uipdbi7ST7TqlLitekiZyMaTZqD/Vgdzl0qcvOn+dBqH1ve+9UJHxrMQhT9VXj/RqzqzmEll/c8fcIB5yfYgDmUANEb4z2JV4mnxqtpjORdR93nMcfhGHTD28EAknWJKNzzOBfXJ8U3Fnkyd5HhHntIaJj8yOAFItxw3pDj0Ep+ki/yO1AdeFu
x-ms-exchange-antispam-messagedata: S4VevJrUEyT3w4UjhMH862j5Qu5RuOjiGe4wKUmlG6322aHZ7QnL677f5xxrCsvzCrDGjUvD8p6hCGxQ43V8Xr/SMeX6fkWQYXYMsgg0dcI4MTPoh0y/6JUq5+WnuwenHXHOzJF4q3YnoPfZi1Cg4Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ebc35-5ec9-44e6-6cde-08d7db6467d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 02:27:37.9507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDS4mL4uObc/CGuA+ELgs7DHPI3H+WRJOqPalawH/+KhCcanjIISpkckVqF5323A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCA3LCAyMDIw
IDExOjQzIFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5j
b20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBRdWFuLCBFdmFuDQo+IDxFdmFuLlF1YW5AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogZml4IGdmeCBoYW5nIGR1cmluZyBzdXNwZW5kIHdpdGggdmlkZW8NCj4g
cGxheWJhY2sNCj4gDQo+IFNvcnJ5LCBJIG1pc3NlZCB0aGlzIGVtYWlsIHRocmVhZCBiZWNhdXNl
IHRoZSBzdWJqZWN0IHNlZW1lZCBpcnJlbGV2YW50IHRvDQo+IG1lLiBJIHN0aWxsIGRvbid0IGdl
dCB3aHkgdGhpcyBpcyBjYXVzaW5nIGEgcHJvYmxlbSB3aXRoIHN1c3BlbmQvcmVzdW1lIHdpdGgN
Cj4gdmlkZW8gcGxheWJhY2suDQo+IA0KPiBUaGUgZnVuY3Rpb25zIHlvdSdyZSBjaGFuZ2luZyBh
cmUgbW9zdGx5IHVzZWQgd2hlbiBydW5uaW5nIHdpdGhvdXQgSFdTLg0KPiBUaGlzIHNob3VsZCBv
bmx5IGJlIHRoZSBjYXNlIGR1cmluZyBicmluZy11cHMgb3Igd2hpbGUgZGVidWdnaW5nIEhXUyBp
c3N1ZXMuDQo+IE90aGVyd2lzZSB0aGV5J3JlIG9ubHkgdXNlZCBmb3Igc2V0dGluZyB1cCB0aGUg
SElRLiBUaGF0IG1lYW5zIGluIG5vcm1hbA0KPiBvcGVyYXRpb24sIHRoZXNlIGZ1bmN0aW9ucyBz
aG91bGQgbm90IGJlIHVzZWQgZm9yIHVzZXIgbW9kZSBxdWV1ZSBtYXBwaW5nLA0KPiB3aGljaCBp
cyBoYW5kbGVkIGJ5IHRoZSBIV1MuDQpbUHJpa2VdICBUaGlzIGlzc3VlIGNhdXNlZCBieSBpbXBy
b3Blcmx5IGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXIgQ1BfSFFEX0FDVElWRSANCnVuZGVyIEdGWCBl
bnRlciBDR1BHIGR1cmluZyBwZXJmb3JtIGRlc3Ryb3kgTVFEIGF0IHRoZSBzdGFnZSBvZiBhbWRr
ZmQgc3VzcGVuZC4gDQoNCkZvciB0aGlzIHNvbHV0aW9uIG1heSBoYXZlIGFuIGV4Y2Vzc2l2ZSBn
dWFyZCBmb3Igc29tZSBNUUQgc2V0dXAgYW5kIG9jY3VweSBjaGVjay4gDQpJdCdzIGxpa2VseSBh
IHBvdGVudGlhbCBjb21tb24gaXNzdWUgYW5kIGhhdmUgZHJhZnRlZCB2MiBwYXRjaCB0byBkaXNh
YmxlIEdGWCBDR1BHIA0KZGlyZWN0bHkgYmVmb3JlIHBlcmZvcm0gYW1kZ3B1IHN1c3BlbmQgb3B0
LiANCg0KVGhhbmtzLA0KUHJpa2UNCg0KPiBSYXksIEkgdmFndWVseSByZW1lbWJlciB3ZSBkaXNj
dXNzZWQgdXNpbmcgS0lRIGZvciBtYXBwaW5nIHRoZSBISVEgYXQNCj4gc29tZSBwb2ludC4gRGlk
IGFueW9uZSBldmVyIHByb3Bvc2UgYSBwYXRjaCBmb3IgdGhhdD8NCj4gDQo+IFRoYW5rcywNCj4g
wqAgRmVsaXgNCj4gDQo+IEFtIDIwMjAtMDQtMDMgdW0gMTI6MDcgYS5tLiBzY2hyaWViIFByaWtl
IExpYW5nOg0KPiA+IFRoZSBzeXN0ZW0gd2lsbCBiZSBoYW5nIHVwIGR1cmluZyBTMyBhcyBTTVUg
aXMgcGVuZGluZyBhdCBHQyBub3QNCj4gPiByZXNwb3NlIHRoZSByZWdpc3RlciBDUF9IUURfQUNU
SVZFIGFjY2VzcyByZXF1ZXN0IGFuZCB0aGlzIGlzc3VlIGNhbg0KPiA+IGJlIGZpeGVkIGJ5IGFk
ZGluZyBSTEMgc2FmZSBtb2RlIGd1YXJkIGJlZm9yZSBlYWNoIEhRRCBtYXAvdW5tYXANCj4gPiBy
ZXRyaXZlIG9wdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPg0KPiA+IFRlc3RlZC1ieTogTWVuZ2JpbmcgV2FuZyA8TWVuZ2JpbmcuV2Fu
Z0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dmeF92OS5jIHwgNiArKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyAgICAgICAgICAgICB8IDQgKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jDQo+ID4gaW5kZXggZGY4NDFjMi4u
ZTI2NTA2MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dmeF92OS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiA+IEBAIC0yMzIsNiArMjMyLDcgQEAgaW50IGtnZF9n
ZnhfdjlfaHFkX2xvYWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZA0KPiAqbXFkLCB1aW50MzJf
dCBwaXBlX2lkLA0KPiA+ICAJdWludDMyX3QgKm1xZF9ocWQ7DQo+ID4gIAl1aW50MzJfdCByZWcs
IGhxZF9iYXNlLCBkYXRhOw0KPiA+DQo+ID4gKwlhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21v
ZGUoYWRldik7DQo+ID4gIAltID0gZ2V0X21xZChtcWQpOw0KPiA+DQo+ID4gIAlhY3F1aXJlX3F1
ZXVlKGtnZCwgcGlwZV9pZCwgcXVldWVfaWQpOyBAQCAtMjk5LDYgKzMwMCw3IEBAIGludA0KPiA+
IGtnZF9nZnhfdjlfaHFkX2xvYWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLCB1aW50
MzJfdCBwaXBlX2lkLA0KPiA+DQo+ID4gIAlyZWxlYXNlX3F1ZXVlKGtnZCk7DQo+ID4NCj4gPiAr
CWFtZGdwdV9nZnhfcmxjX2V4aXRfc2FmZV9tb2RlKGFkZXYpOw0KPiA+ICAJcmV0dXJuIDA7DQo+
ID4gIH0NCj4gPg0KPiA+IEBAIC00OTcsNiArNDk5LDcgQEAgYm9vbCBrZ2RfZ2Z4X3Y5X2hxZF9p
c19vY2N1cGllZChzdHJ1Y3Qga2dkX2Rldg0KPiAqa2dkLCB1aW50NjRfdCBxdWV1ZV9hZGRyZXNz
LA0KPiA+ICAJYm9vbCByZXR2YWwgPSBmYWxzZTsNCj4gPiAgCXVpbnQzMl90IGxvdywgaGlnaDsN
Cj4gPg0KPiA+ICsJYW1kZ3B1X2dmeF9ybGNfZW50ZXJfc2FmZV9tb2RlKGFkZXYpOw0KPiA+ICAJ
YWNxdWlyZV9xdWV1ZShrZ2QsIHBpcGVfaWQsIHF1ZXVlX2lkKTsNCj4gPiAgCWFjdCA9IFJSRUcz
MihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbUNQX0hRRF9BQ1RJVkUpKTsNCj4gPiAgCWlmIChh
Y3QpIHsNCj4gPiBAQCAtNTA4LDYgKzUxMSw3IEBAIGJvb2wga2dkX2dmeF92OV9ocWRfaXNfb2Nj
dXBpZWQoc3RydWN0IGtnZF9kZXYNCj4gKmtnZCwgdWludDY0X3QgcXVldWVfYWRkcmVzcywNCj4g
PiAgCQkJcmV0dmFsID0gdHJ1ZTsNCj4gPiAgCX0NCj4gPiAgCXJlbGVhc2VfcXVldWUoa2dkKTsN
Cj4gPiArCWFtZGdwdV9nZnhfcmxjX2V4aXRfc2FmZV9tb2RlKGFkZXYpOw0KPiA+ICAJcmV0dXJu
IHJldHZhbDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTU0MSw2ICs1NDUsNyBAQCBpbnQga2dkX2dm
eF92OV9ocWRfZGVzdHJveShzdHJ1Y3Qga2dkX2RldiAqa2dkLA0KPiB2b2lkICptcWQsDQo+ID4g
IAl1aW50MzJfdCB0ZW1wOw0KPiA+ICAJc3RydWN0IHY5X21xZCAqbSA9IGdldF9tcWQobXFkKTsN
Cj4gPg0KPiA+ICsJYW1kZ3B1X2dmeF9ybGNfZW50ZXJfc2FmZV9tb2RlKGFkZXYpOw0KPiA+ICAJ
aWYgKGFkZXYtPmluX2dwdV9yZXNldCkNCj4gPiAgCQlyZXR1cm4gLUVJTzsNCj4gPg0KPiA+IEBA
IC01NzcsNiArNTgyLDcgQEAgaW50IGtnZF9nZnhfdjlfaHFkX2Rlc3Ryb3koc3RydWN0IGtnZF9k
ZXYgKmtnZCwNCj4gdm9pZCAqbXFkLA0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyZWxlYXNlX3F1ZXVl
KGtnZCk7DQo+ID4gKwlhbWRncHVfZ2Z4X3JsY19leGl0X3NhZmVfbW9kZShhZGV2KTsNCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYw0KPiA+IGluZGV4IDFmZWEwNzcuLmVlMTA3ZDkgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBAQCAtMzUzMyw2ICszNTMzLDcgQEAg
c3RhdGljIGludCBnZnhfdjlfMF9raXFfaW5pdF9yZWdpc3RlcihzdHJ1Y3QNCj4gYW1kZ3B1X3Jp
bmcgKnJpbmcpDQo+ID4gIAlzdHJ1Y3QgdjlfbXFkICptcWQgPSByaW5nLT5tcWRfcHRyOw0KPiA+
ICAJaW50IGo7DQo+ID4NCj4gPiArCWFtZGdwdV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShhZGV2
KTsNCj4gPiAgCS8qIGRpc2FibGUgd3B0ciBwb2xsaW5nICovDQo+ID4gIAlXUkVHMzJfRklFTEQx
NShHQywgMCwgQ1BfUFFfV1BUUl9QT0xMX0NOVEwsIEVOLCAwKTsNCj4gPg0KPiA+IEBAIC0zNjI5
LDYgKzM2MzAsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2tpcV9pbml0X3JlZ2lzdGVyKHN0cnVj
dA0KPiBhbWRncHVfcmluZyAqcmluZykNCj4gPiAgCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpDQo+
ID4gIAkJV1JFRzMyX0ZJRUxEMTUoR0MsIDAsIENQX1BRX1NUQVRVUywgRE9PUkJFTExfRU5BQkxF
LA0KPiAxKTsNCj4gPg0KPiA+ICsJYW1kZ3B1X2dmeF9ybGNfZXhpdF9zYWZlX21vZGUoYWRldik7
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTM2MzcsNiArMzYzOSw3IEBA
IHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfa2lxX2ZpbmlfcmVnaXN0ZXIoc3RydWN0DQo+IGFtZGdwdV9y
aW5nICpyaW5nKQ0KPiA+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2
Ow0KPiA+ICAJaW50IGo7DQo+ID4NCj4gPiArCWFtZGdwdV9nZnhfcmxjX2VudGVyX3NhZmVfbW9k
ZShhZGV2KTsNCj4gPiAgCS8qIGRpc2FibGUgdGhlIHF1ZXVlIGlmIGl0J3MgYWN0aXZlICovDQo+
ID4gIAlpZiAoUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUNQX0hRRF9BQ1RJVkUpICYgMSkgew0KPiA+
DQo+ID4gQEAgLTM2NjgsNiArMzY3MSw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfa2lxX2Zpbmlf
cmVnaXN0ZXIoc3RydWN0DQo+IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiA+ICAJV1JFRzMyX1NPQzE1
X1JMQyhHQywgMCwgbW1DUF9IUURfUFFfV1BUUl9ISSwgMCk7DQo+ID4gIAlXUkVHMzJfU09DMTVf
UkxDKEdDLCAwLCBtbUNQX0hRRF9QUV9XUFRSX0xPLCAwKTsNCj4gPg0KPiA+ICsJYW1kZ3B1X2dm
eF9ybGNfZXhpdF9zYWZlX21vZGUoYWRldik7DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
