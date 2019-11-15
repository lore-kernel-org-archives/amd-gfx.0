Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8E4C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2082073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2082073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4896E33F;
	Fri, 15 Nov 2019 10:06:54 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820079.outbound.protection.outlook.com [40.107.82.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1536E33F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 10:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghHKVKdrgukFYhuEJzRRlszwuk3LbL79WcRX9WqztKwW/ATAPTeDXphlX8wVwX4Kn6X//jR4V1LJIzI2vqUjlAb4xxWe+cT37bE1BmCo54+GoRrY5wM6dsy8eXHC4FjS+cHBoJ8QgPl81Z0brQGonvwdiCOBVqVQPAfUl2fEvUyMzTEAKWTp2JKfcgWb6vWq7VnBr+BQVgNHA8B2mOzX85h6yusfqjY56K0cn1FbnfimRd/67c66poVAxDMUGHcGEM2+PkS+YtD++q2xLPrmV8H/ZVQgmvsCAYw1tpTOaeCatho7kFw8KbUYmbdd4gDRoaLfXz/Qbckl2Zkc/PG8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5UEANBYgkPyhOiFpAQ2aPmnaRTK36Ht7HiPPiELh1M=;
 b=F/acwFwcCee78emBy8MlRkka2EMZyZMY+l+3MpDH65vuScd5y1TARuZI7CiXzXTz+JIIRlsHDOs9tvCoZ2zUWpyHcRdgwiOVdnRkMS7YOqZHHd9CvUz553p4ML153hLWh+kPMciMLYTFu4IlAwHJIZYcH+3qViWgpfAG0jzliKaGsVxRsJgk7vqKrzOKgIaoyhrK6bfKFk+MteuY6d/YYXF0CXfGBxO+P3qw/hY1Lwe68P7KEnz/sSMeQrtsovQKMSOQVVMlEtOANfCclpDfmIegaThx8Fqf29sPqF9jpcGYiBiJahbHnfaNt8MQWcVEbrizD5LItdQZZDLUvVHLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 10:06:50 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 10:06:50 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 10/12] tests/amdgpu: add test to submit a gfx command with
 secure context
Thread-Topic: [PATCH 10/12] tests/amdgpu: add test to submit a gfx command
 with secure context
Thread-Index: AQHVm2XE+FCUbn5+eEOf8V2eTG0PJqeMiBGA
Date: Fri, 15 Nov 2019 10:06:49 +0000
Message-ID:
 <MN2PR12MB330923D11E08F0DC172F8F1DEC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-10-git-send-email-aaron.liu@amd.com>
In-Reply-To: <1573788895-3936-10-git-send-email-aaron.liu@amd.com>
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
x-ms-office365-filtering-correlation-id: 0c81e5bc-1ef5-4297-42e0-08d769b3882e
x-ms-traffictypediagnostic: MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37439FED2CC6DEB221407900EC700@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(7736002)(446003)(305945005)(71190400001)(71200400001)(6436002)(55016002)(3846002)(6116002)(74316002)(2906002)(26005)(102836004)(6636002)(186003)(229853002)(99286004)(76176011)(54906003)(256004)(14444005)(6506007)(9686003)(52536014)(25786009)(81156014)(81166006)(478600001)(86362001)(6862004)(8936002)(8676002)(33656002)(5660300002)(66556008)(64756008)(66946007)(66446008)(7696005)(14454004)(6246003)(66476007)(476003)(66066001)(76116006)(316002)(11346002)(486006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3743;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTTqkc4dQ1wlpuhzWggNRIfrh5Trho7xg9/OdzgIc0Wm52xf0NvDCQZfT3+hx77Dd7bPGXOPqlMWDpfNJmtLCEkx5Ps8odu6vJ6Iypm5GeuKxffUFBA2ELeHU7E5ZlovdoBAB39Kr2s6RGQEKMELRO+5Px/khhvQnkJGJEKHDV/5/s8mJgoa9mBfBkZaHbBTJYtNButK8nw8oN67AzdruqmZka4VMpzESl95p86vbe7wFqRgAkb6ZcD1mV4tKNH+CSJ4kVWXGHWsXFNiPKuXrjaYHdV0YQGSp9o6xmT+K3VDYbcKQ+3mD2HsQsdr3ROJHWdh7xuV49ClPfF0uoo2b98Kec7GoAaqpr0pbShND/wNn0aAkF5bwDEHQueg9T7uQpZJGDoPyS/iFqMwvq77r9rcJ9sBcSI5UHGahf/ZYx+b1Nt1uN9nY7AlEs2cb7IN
Content-ID: <EAD357C13432E94285A2909160FBAF65@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c81e5bc-1ef5-4297-42e0-08d769b3882e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:06:49.9970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXA8ua4t3WtNnGT+pmNh/qmrGzhJFW4Iw9BTs4lmDGch9EHwlGeVRzHIUgNhIjB3usT0BY0DAAWl2WB/OYkCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5UEANBYgkPyhOiFpAQ2aPmnaRTK36Ht7HiPPiELh1M=;
 b=nNTnFMB9NNoBjtCibMNCo7PJriNMRtEe3vDRXZU9OARCQzuwGdLJau/0vZUIYrabk4i1KFD5kDg+Nnw1dm379sCcn8kqdO8E0rOBsXud2V6BTU+oOvmTab7uE9BPwo2Ajv246N8VXEsPrNhQqcU4IcdY2U+URbMc4WUDsMZjEZI=
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
Message-ID: <20191115100649.fTkt6abTfTYEacADl2bjZtRm0uczYa-cTmyCIpoVO1Q@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTNBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBUaGlzIHBhdGNoIGlzIHRvIHRlc3QgdGhlIGNvbW1hbmQgc3VibWlzc2lvbiB3aXRoIHNl
Y3VyZSBjb250ZXh0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFt
ZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KCj4gLS0t
Cj4gIHRlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jIHwgOSArKysrKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUv
c2VjdXJpdHlfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gaW5kZXgg
YTM4MDdlZS4uMGJiNGFkMiAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvc2VjdXJpdHlfdGVz
dHMuYwo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9zZWN1cml0eV90ZXN0cy5jCj4gQEAgLTMyLDYgKzMy
LDcgQEAgc3RhdGljIHVpbnQzMl90IG1ham9yX3ZlcnNpb247Cj4gIHN0YXRpYyB1aW50MzJfdCBt
aW5vcl92ZXJzaW9uOwo+ICAKPiAgc3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5X2FsbG9jX2J1
Zl90ZXN0KHZvaWQpOwo+ICtzdGF0aWMgdm9pZCBhbWRncHVfc2VjdXJpdHlfZ2Z4X3N1Ym1pc3Np
b25fdGVzdCh2b2lkKTsKPiAgCj4gIENVX0JPT0wgc3VpdGVfc2VjdXJpdHlfdGVzdHNfZW5hYmxl
KHZvaWQpCj4gIHsKPiBAQCAtNzUsNiArNzYsNyBAQCBpbnQgc3VpdGVfc2VjdXJpdHlfdGVzdHNf
Y2xlYW4odm9pZCkKPiAgCj4gIENVX1Rlc3RJbmZvIHNlY3VyaXR5X3Rlc3RzW10gPSB7Cj4gIAl7
ICJhbGxvY2F0ZSBzZWN1cmUgYnVmZmVyIHRlc3QiLCBhbWRncHVfc2VjdXJpdHlfYWxsb2NfYnVm
X3Rlc3QgfSwKPiArCXsgImdyYXBoaWNzIHNlY3VyZSBjb21tYW5kIHN1Ym1pc3Npb24iLCBhbWRn
cHVfc2VjdXJpdHlfZ2Z4X3N1Ym1pc3Npb25fdGVzdCB9LAo+ICAJQ1VfVEVTVF9JTkZPX05VTEws
Cj4gIH07Cj4gIAo+IEBAIC0xMTMsMyArMTE1LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1
cml0eV9hbGxvY19idWZfdGVzdCh2b2lkKQo+ICAJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFu
ZGxlLCBib19tYywgNDA5Nik7Cj4gIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7Cj4gIH0KPiArCj4g
K3N0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9nZnhfc3VibWlzc2lvbl90ZXN0KHZvaWQpCj4g
K3sKPiArCWFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRo
X3NlY3VyZShkZXZpY2VfaGFuZGxlLAo+ICsJCQkJCQkJCSAgQU1ER1BVX0hXX0lQX0dGWCwKPiAr
CQkJCQkJCQkgIHRydWUpOwo+ICt9Cj4gLS0gCj4gMi43LjQKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
