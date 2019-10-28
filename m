Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5150CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A5C20650
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 06:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5C20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CBF6E38A;
	Mon, 28 Oct 2019 06:07:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5546E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 06:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ5J9k3JTPGB3Yk4Ndyifj7HL+JzgCjkeCGFkaGSjUn6x3p7yfEkBkaKZAtorbOdAu915X+C+2mtzzR2tjfGoLu5vcqPKHeqvqPk4BgxzC0a6rdheKEgEXPVaKFT87GxxKGE6QnCEHKmgYTsTGx0tCfnH1KAD0RauJ8Ld5bfrSKmF3Ry7WSMgX6KDUVOArfH7Y6OuIQ8KHUNSsNjPtuIVbuBHGEkUa4MXQzmalnVsil+TkD0tayOVebOFpPYdGKpxi1pWXXFK4nynD3qsRJuexCN9SODneOygEPU4vKGbScqsId6QhF8JIqePHGy14xWtL4MnXRrloD67hl1RRbD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3biWeCE8p9GDhG1jfsgLei6s1jORTb7l3RQRt3mNuJs=;
 b=O4I26TTzLsbBc8+iJcxSGtaDvXGM4GzxXMrJJFiz7GOuV9Rf8ho9iwAvJrWCehv1XzCNvK3Ui59qe5Fwr0FntpEFbXANdUM0tJR+6Idqc48/Km+EHyzsXxNqgLHba5DiCWEdoOaTD1553Oaoks88yKpYDhtgONzEeJwaBOdoHOQoCgWpg6HdvrKJLJzTCejN9uVQcU9MYkUN4nwN2DwCihFW8fX9zatRNsZoFuDNqMhz/RrrbhGKY+pmAjG52jPTeqkqbm3kRdbG6pf8LhyEIdU7ZHc3mpH9CCkg4ymGOPAXz/zb1CqPl9XQg0Kua33z9v6QU/a+ag1ZbxRi7j/D7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3934.namprd12.prod.outlook.com (10.255.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 06:07:06 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 06:07:06 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Topic: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Index: AQHViyRUHE5+TcRLx02/7aID0dGjk6drWJ4QgAQBqACAAME5AA==
Date: Mon, 28 Oct 2019 06:07:06 +0000
Message-ID:
 <MN2PR12MB33099769189751D17A09853CEC660@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
 <MN2PR12MB3309AD7F0E9B0911A7AC9C5CEC650@MN2PR12MB3309.namprd12.prod.outlook.com>
 <MN2PR12MB3069CB862732575D4F9835BF9D660@MN2PR12MB3069.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3069CB862732575D4F9835BF9D660@MN2PR12MB3069.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2387.009)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90c2b675-914a-4453-b3a6-08d75b6d0f55
x-ms-traffictypediagnostic: MN2PR12MB3934:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3934E50DE54641E12BAFA814EC660@MN2PR12MB3934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(13464003)(3846002)(14454004)(256004)(14444005)(186003)(6862004)(9686003)(4326008)(6116002)(6306002)(446003)(76176011)(55016002)(476003)(86362001)(8676002)(11346002)(7696005)(74316002)(6436002)(229853002)(7736002)(305945005)(486006)(6246003)(66066001)(81166006)(8936002)(102836004)(81156014)(316002)(966005)(25786009)(52536014)(6636002)(26005)(66476007)(66946007)(15650500001)(64756008)(66556008)(66446008)(5660300002)(6506007)(53546011)(76116006)(71190400001)(71200400001)(478600001)(99286004)(33656002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3934;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWfQzl0tPHnQW2zaqugTAvHyf8/oCqvs7eRY5Uk7QAGnb8M9guIFps9pdaB9zcL8fWLHloDEqEw4h1A5RZ4JlNrH+Hx9ZNJUZ0NAQBEc+Ugx1TYq/8Eyn7x/FYJtydM1mSlIq8aEQ7oP0SipPFw6FyROLu+uUAvmV2q0bf9pmCQgT8gbiti58yGhzAlgX09Yvo2j4+PjzHX9WV7DbUP/ZggcoqrLvvjbhmdcBrxNbx7jy+Y1RzPjAk8ppAe1w27o0E0+T3EYrI/Hk2oatSvIONzyzcbVrJu57mNGI7e0cEw8fkX+DyhXswzX6TqXCoy+HTOMSEGOS9+d6xsZUryb+njNCGYHp15udeja0Ac+OZyIY8tmQoderziTcd4AQRoxLLUosdGmxIKjqgvSShxsLWqZIPM6Mms8jtoeNVWmcma7TTDTsdpOpoLOmKVL/QrJumTkcssbNu1aanezAVJXmhFay0N7Q3tI2xDsJYLQiRw=
Content-ID: <6F00A64E80309A4F9102CDB2D7F91A2F@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c2b675-914a-4453-b3a6-08d75b6d0f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 06:07:06.1643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woUtsN2n9xx+JiJufaZgWtxr3eiNSLKf8Ym/eo/iYLQU7czrdX40ohg0uclzvKj+hzTRjcZNmyEqCqiX7oKGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3biWeCE8p9GDhG1jfsgLei6s1jORTb7l3RQRt3mNuJs=;
 b=ZxDAJ04+LNrLXh3BWgUL/Y4+pi6HdysKDCsfJmaZ8m5AtmwAUQhWBrgelkbG74vbzjgRzNmn8viFld9yfbMeXJuod0tjon/tPcdZyVNHr+i3i09+6ZmUR9x7QuNQYFzjSdUYSKY5RrJmesDajHlPwAR1BnCHrXrTDRtyKzSQY1s=
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028060706.swPqPUDoQxNmXsWURPYuKiWz1nFiTY2HhukHjR8E88Q@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgMTA6MzQ6NTRBTSArMDgwMCwgR29uZywgQ3Vycnkgd3Jv
dGU6Cj4gSGkgUmF5Ogo+IAo+IEJlY2F1c2UgSSBmb3VuZCB0aGF0IGVuYWJsZSBDR1BHIGZvciBh
bGwgQVBVIGluIHNtdV9yZXN1bWUgYXQgMGQyZTliMTA0MjhhNgoKSSBzZWUsIHRoYW5rcy4KClBh
dGNoIGlzIFJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgoKPiAKPiBj
b21taXQgMGQyZTliMTA0MjhhNmMyNjFjOTlmMmQ5ODJiZTc3NDVmMzVlZWY5Nwo+IEF1dGhvcjog
UHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+Cj4gRGF0ZTogICBUdWUgT2N0IDE1IDE3
OjExOjQ5IDIwMTkgKzA4MDAKPiAKPiAgICAgZHJtL2FtZGdwdTogZml4IFMzIGZhaWxlZCBhcyBS
TEMgc2FmZSBtb2RlIGVudHJ5IHN0dWNrZWQgaW4gcG9sbG9pbmcgZ2Z4IGFjcQo+IAo+ICAgICBG
aXggZ2Z4IGNncGcgc2V0dGluZyBzZXF1ZW5jZSBmb3IgUkxDIGRlYWRsb2NrIGF0IHNhZmUgbW9k
ZSBlbnRyeSBpbiBwb2xsaW5nIGdmeCByZXNwb25zZS4KPiAgICAgVGhlIHBhdGNoIGNhbiBmaXgg
VkNOIElCIHRlc3QgZmFpbGVkIGFuZCBEQUwgZ2V0IGRpc3BhbHkgY291bnQgZmFpbGVkIGlzc3Vl
Lgo+IAo+ICAgICBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNv
bT4KPiAgICAgUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IGluZGV4IGFj
ZWM2OWI3NDczNC4uZTJhMDNmNDExZDZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IEBAIC0xMzUwLDYgKzEzNTEsOSBAQCBzdGF0aWMgaW50IHNt
dV9yZXN1bWUodm9pZCAqaGFuZGxlKQo+ICAgICAgICAgaWYgKHJldCkKPiAgICAgICAgICAgICAg
ICAgZ290byBmYWlsZWQ7Cj4gCj4gKyAgICAgICBpZiAoc211LT5pc19hcHUpCj4gKyAgICAgICAg
ICAgICAgIHNtdV9zZXRfZ2Z4X2NncGcoJmFkZXYtPnNtdSwgdHJ1ZSk7Cj4gKwo+ICAgICAgICAg
bXV0ZXhfdW5sb2NrKCZzbXUtPm11dGV4KTsKPiAKPiAgICAgICAgIHByX2luZm8oIlNNVSBpcyBy
ZXN1bWVkIHN1Y2Nlc3NmdWxseSFcbiIpOwo+IAo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
Cj4gRnJvbTogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+IAo+IFNlbnQ6IEZyaWRheSwg
T2N0b2JlciAyNSwgMjAxOSA5OjI2IFBNCj4gVG86IEdvbmcsIEN1cnJ5IDxDdXJyeS5Hb25nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBHb25nLCBDdXJyeSA8
Q3VycnkuR29uZ0BhbWQuY29tPgo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJw
bGF5OiBEaXNhYmxlIGdmeCBDR1BHIHdoZW4gc3VzcGVuZCBzbXUKPiAKPiBXaHkgZG8geW91IGRp
c2FibGUgQ0dQRyBmb3IgYWxsIEFQVT8KPiAKPiBUaGFua3MsCj4gUmF5Cj4gCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgY2hlbiBnb25nCj4gU2VudDogRnJpZGF5LCBP
Y3RvYmVyIDI1LCAyMDE5IDc6MDcgUE0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBDYzogR29uZywgQ3VycnkgPEN1cnJ5LkdvbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG93ZXJwbGF5OiBEaXNhYmxlIGdmeCBDR1BHIHdoZW4gc3VzcGVuZCBzbXUK
PiAKPiBpZiBubyBkaXNhYmxlIGdmeCBDR1BHIHdoZW4gc3VzcGVuZCBzbXUsIGVuYWJsaW5nIGdm
eCBDR1BHIHdpbGwgZmFpbCB3aGVuIHJlc3VtZSBzbXUuCj4gCj4gUGxhdGZvcm06IFJlbm9pcgo+
IGRtZXNnIGxvZyBpbmZvcm1hdGlvbjoKPiAKPiBbICAxNTEuODQ0MTEwIF0gYW1kZ3B1OiBbcG93
ZXJwbGF5XSBTTVUgaXMgcmVzdW1pbmcuLi4KPiBbICAxNTEuODQ0MTE2IF0gYW1kZ3B1OiBbcG93
ZXJwbGF5XSBkcG0gaGFzIGJlZW4gZGlzYWJsZWQgWyAgMTUxLjg0NDYwNCBdIGFtZGdwdTogW3Bv
d2VycGxheV0gRmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAweDJmLHJlc3BvbnNlIDB4ZmZmZmZmZmIg
cGFyYW0gMHgxIFsgIDE1MS44NDQ2MDUgXSBhbWRncHU6IFtwb3dlcnBsYXldIFNNVSBpcyByZXN1
bWVkIHN1Y2Nlc3NmdWxseSEKPiAKPiBTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5Lmdv
bmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1
X3NtdS5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IGluZGV4IDI2OTIzYWEu
LjRlNDY4YjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jCj4gQEAgLTEzNTEsNiArMTM1MSw4IEBAIHN0YXRpYyBpbnQgc211X3N1c3BlbmQodm9pZCAq
aGFuZGxlKQo+ICAJaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX05BVkkxMCAmJgo+ICAJICAg
IGFkZXYtPmdmeC5ybGMuZnVuY3MtPnN0b3ApCj4gIAkJYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3Rv
cChhZGV2KTsKPiArCWlmIChzbXUtPmlzX2FwdSkKPiArCQlzbXVfc2V0X2dmeF9jZ3BnKCZhZGV2
LT5zbXUsIGZhbHNlKTsKPiAgCj4gIAlyZXR1cm4gMDsKPiAgfQo+IC0tCj4gMi43LjQKPiAKPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
