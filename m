Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B43C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7BD2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7BD2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E2589CE0;
	Fri, 15 Nov 2019 10:07:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA0C89CE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 10:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njoBtpyJO4Io6nQkCDrIh5bdM/zDUHsehZ8ozgLx65jAAUTG/s09FtqXR9FauN2TNF/w9juBArVddEYiSk4Wf6ZWF8rw/tzzhSTE8xSJZHK4hLq97s68q6zqAUTN0hH2ynUDfnCA7bOl4v5mm4YtsV1unnGLhHOHcdJTBiWbp9bQxGcRbdlwEpG0p+CVKa1yY45GCOAbVbIU/oN2YCHSyPZCr/3qyXU1uNuPrbpQq+LELKC0EwYYW9fBegu82Fovviqqmv9srspvs0h4roO/U9I0tLBN/fTt4Yg3prU6cSRC/KOf9YASobLO4xPWsGvTJzf/WvDTxACwL0ft2JUa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HehcxzhxZkDvzik1FpOrs3k+9/LeWl2Ifg6/jUytlLc=;
 b=hRMdnHGNibnyGygyvs3WaVb4+DsfhPf6WqqqnEsZ6Zm13p/UBsOSwMWYga62B0Z7Fr0Os+cRZAigj+7oNbR737pr4wWTUVPyCGBfVPBTp9IoFVfCmexZq3pZjJ++gQV9v8CuGZX6DV5q5T9RWnRipMfUUx3TbeRQuczDeZf2LkdMdYWWrJDbixrrQTNGmDzG2DuSl0T4PoqeGXfYzDO1qePOmU3XPk0V85q1iI4c8q3U/MSmfhGWfSqVsGeVgJZZrhWa1Gx6aWVsuN/XitAp8dvfDq7svIifhxC02Nj2z+D31VEXzit4+c3DPn1DgxiC9QsSyS1SnpGXHWSlmDDWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3981.namprd12.prod.outlook.com (10.255.237.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 10:07:33 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 10:07:33 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 12/12] tests/amdgpu: add test to submit a sdma command
 with secure context
Thread-Topic: [PATCH 12/12] tests/amdgpu: add test to submit a sdma command
 with secure context
Thread-Index: AQHVm2XIfMNI6AQSFUySl3KT175pYqeMiDmA
Date: Fri, 15 Nov 2019 10:07:32 +0000
Message-ID:
 <MN2PR12MB33096C5AEA6FD6946663F8F4EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-12-git-send-email-aaron.liu@amd.com>
In-Reply-To: <1573788895-3936-12-git-send-email-aaron.liu@amd.com>
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
x-ms-office365-filtering-correlation-id: 4a6b1ef0-5d7e-4366-fe81-08d769b3a1c0
x-ms-traffictypediagnostic: MN2PR12MB3981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB398152917B54C6B68E156599EC700@MN2PR12MB3981.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(189003)(199004)(446003)(478600001)(54906003)(102836004)(25786009)(8936002)(26005)(6506007)(11346002)(186003)(316002)(229853002)(66556008)(64756008)(52536014)(66946007)(76116006)(81166006)(81156014)(8676002)(5660300002)(486006)(4326008)(476003)(66476007)(6116002)(3846002)(7736002)(66066001)(74316002)(6636002)(66446008)(14454004)(2906002)(7696005)(33656002)(86362001)(6436002)(71190400001)(71200400001)(9686003)(6246003)(6862004)(14444005)(55016002)(99286004)(305945005)(76176011)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3981;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLWs6x2MGVfh5DnmubaPBbmwdAL17MWKeRzaxr1CrHeEE1cJKK+FrKlII3qR4s9Dtahp908jfBkQ3Z8BIeTQWDrsx56b5SnvSARRT/fIVZG/5/wXDDdDnOmZaXGHn9EDCUzXLKdkmHGv3a+OMfBmsbr1dRHtaTev3CAKrIlRdEcA5CtK/0Af68WLH83ezSZDFQJ3kBZTdsnFAr/U9N3Ko3M6R5KFXnWwUxC7WQjwhPCoVbYT/iTdFzSFtcrtpfcgNaDGx14N1axTFFVIG5CR+kVKxLt7OeMj5evcK+M+3/xIP03s5jCJ6P31qv4miIAooB76vgrYnZzOXVBKPy2Ov9WOUh2Kr00ErDp4U6CHpSdF00nyOnRw0bnDJsUJJr5tvj0DaN0UAE+1OlBudQGsAOu+CL8T8PB0JoRyW+GXBdrrK3uSYKV/Uu4MszKtkwEj
Content-ID: <907875A79CA2AB4E9BB2034FB8FC50DE@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6b1ef0-5d7e-4366-fe81-08d769b3a1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:07:32.8417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IHOwRBUbVYQYeELrGOEQx0ta0lBPgS+nEyVk97GizGiBQmvEWUydgN9TfGQGv5X/kXnC6UBQMA3B3EHbto99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HehcxzhxZkDvzik1FpOrs3k+9/LeWl2Ifg6/jUytlLc=;
 b=p7lkVt5LC4B8RGjGLxOfvug0Fya0sPNzcRjk1sDcydReTYf8s05lb91gDEhApbPRyduw3sp05iLwDq5qxOAVnVwuerekAP3XVjlUqVRe8S+mNHeridazgtQU0NsJtREPjOhb+Tl0zgDnjDFibZRurNqp5x9Oo15TNUw/xpwTA7o=
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
Message-ID: <20191115100732.VPiA8g2e9ZJVA4mp2gxYNKGbT8QieJRtO1GNauQHNds@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTVBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBUaGlzIHBhdGNoIGFkZCB0ZXN0IHRvIHN1Ym1pdCBhIHNkbWEgY29tbWFuZCB3aXRoIHNl
Y3VyZSBjb250ZXh0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KCj4gLS0t
Cj4gIHRlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIHwgMTAgKysrKysrKysrKwo+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRn
cHUvc2VjdXJpdHlfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gaW5k
ZXggMGJiNGFkMi4uZWIyMzlmNCAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvc2VjdXJpdHlf
dGVzdHMuYwo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gQEAgLTMzLDYg
KzMzLDggQEAgc3RhdGljIHVpbnQzMl90IG1pbm9yX3ZlcnNpb247Cj4gIAo+ICBzdGF0aWMgdm9p
ZCBhbWRncHVfc2VjdXJpdHlfYWxsb2NfYnVmX3Rlc3Qodm9pZCk7Cj4gIHN0YXRpYyB2b2lkIGFt
ZGdwdV9zZWN1cml0eV9nZnhfc3VibWlzc2lvbl90ZXN0KHZvaWQpOwo+ICtzdGF0aWMgdm9pZCBh
bWRncHVfc2VjdXJpdHlfc2RtYV9zdWJtaXNzaW9uX3Rlc3Qodm9pZCk7Cj4gKwo+ICAKPiAgQ1Vf
Qk9PTCBzdWl0ZV9zZWN1cml0eV90ZXN0c19lbmFibGUodm9pZCkKPiAgewo+IEBAIC03Nyw2ICs3
OSw3IEBAIGludCBzdWl0ZV9zZWN1cml0eV90ZXN0c19jbGVhbih2b2lkKQo+ICBDVV9UZXN0SW5m
byBzZWN1cml0eV90ZXN0c1tdID0gewo+ICAJeyAiYWxsb2NhdGUgc2VjdXJlIGJ1ZmZlciB0ZXN0
IiwgYW1kZ3B1X3NlY3VyaXR5X2FsbG9jX2J1Zl90ZXN0IH0sCj4gIAl7ICJncmFwaGljcyBzZWN1
cmUgY29tbWFuZCBzdWJtaXNzaW9uIiwgYW1kZ3B1X3NlY3VyaXR5X2dmeF9zdWJtaXNzaW9uX3Rl
c3QgfSwKPiArCXsgInNkbWEgc2VjdXJlIGNvbW1hbmQgc3VibWlzc2lvbiIsIGFtZGdwdV9zZWN1
cml0eV9zZG1hX3N1Ym1pc3Npb25fdGVzdCB9LAo+ICAJQ1VfVEVTVF9JTkZPX05VTEwsCj4gIH07
Cj4gIAo+IEBAIC0xMjIsMyArMTI1LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9n
Znhfc3VibWlzc2lvbl90ZXN0KHZvaWQpCj4gIAkJCQkJCQkJICBBTURHUFVfSFdfSVBfR0ZYLAo+
ICAJCQkJCQkJCSAgdHJ1ZSk7Cj4gIH0KPiArCj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0
eV9zZG1hX3N1Ym1pc3Npb25fdGVzdCh2b2lkKQo+ICt7Cj4gKwlhbWRncHVfY29tbWFuZF9zdWJt
aXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUoZGV2aWNlX2hhbmRsZSwKPiAr
CQkJCQkJCQkgIEFNREdQVV9IV19JUF9ETUEsCj4gKwkJCQkJCQkJICB0cnVlKTsKPiArfQo+IC0t
IAo+IDIuNy40Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
