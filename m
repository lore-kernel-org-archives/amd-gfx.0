Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01BDC43141
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9402073B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9402073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A516E33E;
	Fri, 15 Nov 2019 10:03:29 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820045.outbound.protection.outlook.com [40.107.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B226E33E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 10:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMh7gM3FPnzTaZ4XUAntqzhgiNlxWiBN/HgTGRSjknkgXkDR6iYe3IT4rqqM9dxkSHBSJUjdiPvP24YdWXNZ+gbIXDg78v+XiLMRuLCxNWKXsVZRxceNWBiP/vFzdPaxvaalwTlXPA/nKjH6Yx5LGjhS0QED/+kaym1ugv9etZOO0mg8J8B5GspS3YhJazNCNcPdOt5GwHDBDtTIChUNhX/hSfyNGgUFJBdkXD4DSmSgABiF17fcgeKAqMvKXASIRRP2d/PeHl+yOI9Ntl1k+IaHUw7N1G7asPrJzIOeae3Zx4BbBNBpv1jRkinguWGFcFH2ZtMB2JCgxkj4Xw3kdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1rRQqK/0XI4XjKbmUO2I4WLWkLwqQ75VXGMRrwrnkY=;
 b=jJmEl9hotNXETHKDnmIpoUSXIpWbnoXbRDyLvdMZv6rBt5pws1GjB/OThpizeerLH19WoO+kP0vMtEdV+WtRqun5xeKM25mmnXrl7vOQdDEAa3pnN9F+98U1vQeG0141aK0Q9e8ae8lJFFNyXya1BjToT2ZRU6yWdM9P+sQJIdWZW9e3vYpLfguX4ia0GdyQAppqOe0CqQpGDZ8bsiQZb9+0VdNEfTnEc8kFV4ghEBLkN1u8MBI/jGRCF7SPjiFiYYkEcRSvfsur3eAgqk2Jrp2oaDtm6WnNBpFb3Gl8zcaPxSTGFNHUeIZBZtvym/eVPjORROEQby+a5svyqKTEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 10:03:26 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 10:03:26 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 11/12] tests/amdgpu: add atomic dma command to verify the
 secure buffer
Thread-Topic: [PATCH 11/12] tests/amdgpu: add atomic dma command to verify the
 secure buffer
Thread-Index: AQHVm2XGdy6SXzg+gUiTf0Bz7DbpnqeMhxgA
Date: Fri, 15 Nov 2019 10:03:25 +0000
Message-ID:
 <MN2PR12MB3309E58E3EF55C934D72457DEC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-11-git-send-email-aaron.liu@amd.com>
In-Reply-To: <1573788895-3936-11-git-send-email-aaron.liu@amd.com>
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
x-ms-office365-filtering-correlation-id: 31126d44-6490-4c30-8e3d-08d769b30e9b
x-ms-traffictypediagnostic: MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3743BD85686242D13CD64924EC700@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(7736002)(446003)(305945005)(71190400001)(71200400001)(6436002)(55016002)(3846002)(6116002)(74316002)(2906002)(26005)(102836004)(6636002)(186003)(229853002)(99286004)(76176011)(54906003)(256004)(14444005)(6506007)(9686003)(52536014)(25786009)(81156014)(81166006)(478600001)(86362001)(6862004)(8936002)(8676002)(33656002)(5660300002)(66556008)(64756008)(66946007)(66446008)(7696005)(14454004)(6246003)(66476007)(15650500001)(476003)(66066001)(76116006)(316002)(11346002)(486006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3743;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgYR42fQJ27jfNlyFHgDBBA2eJ4SwrpKUmvtWSdwmKVcdExa4wvoORTQPcVZwPtLdLd/d34gws43rH326J+v8h2xzShovcwO7w4uBhbZ3lhq5jviDcmUebf4/AUqQF1PU3RNO1MG7Kuv3I/PQir/mzFONDs8z8DLhB4Aiqv6tti0nlcB87fcFgoPVLgQgH2p67N51hV3VJmxnPQJtHfSjyOIvpDnb++i/l9DvQgj+ZGGGYdQ4ZTfG9Yh8uH/Yu/mVcx4KKV2pyX1+ppOVOPB9M2KyhexTaztWn4BvIAu6sDDLmr0y5AI5yk5IVUFxOO4GZkpY0yQL6cQW6DlZZyCIC3Jwh8Q9vHa2H8iSvRCoLn8xbNxGAlG9+LaKsxq/b+nm8a8LCEQxBP/LpCepE+GoeNhElCtHZYHJdbywfqT600RtLZyLo48zvlOp4nfmOqh
Content-ID: <56E46DF4C2978B4BB28B3C186B2F143D@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31126d44-6490-4c30-8e3d-08d769b30e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:03:25.9903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwibzF6x9oDhO8AzHXPReWnLgjKYrFOfgHsInkAhg/CyIcciWe2mQn2DpptZx6Zc2GpbHYLSYzvA9JP4yfOefg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1rRQqK/0XI4XjKbmUO2I4WLWkLwqQ75VXGMRrwrnkY=;
 b=JYcPSYl/QkF1nKbhKDVi7bMcPVLLu/K9Z8HFGzv+fM7a1soNKv830XbRs5b5akIb1OQ6X7ylDmczj/aPVn2u3ojPRfYcwHitWKRPyTjozzbWhbXNeZLCTibJ54iH4RPK07HbQhyAcK5k0ASFFCaKf1F3sifsDR9bk2j0JOAIUJA=
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
Message-ID: <20191115100325.BC3FoUKvDW087YtPrgqZ-x9gSqm-MZkW9z89Juux3p8@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTRBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBETUEncyBhdG9taWMgYmVoYXZpciBpcyB1bmxpa2UgR0ZYLElmIHRoZSBjb21wYXJpbmcg
ZGF0YSBpcyBub3QKPiBlcXVhbCB0byBkZXN0aW5hdGlvbiBkYXRhLAo+IEZvciBHRlgsIGxvb3Ag
YWdhaW4gdGlsbCBnZnggdGltZW91dChzeXN0ZW0gaGFuZykuCj4gRm9yIERNQSwgbG9vcCBhZ2Fp
biB0aWxsIHRpbWVyIGV4cGlyZWQgYW5kIHRoZW4gc2VuZCBpbnRlcnJ1cHQuCj4gU28gdGVzdGNh
c2UgY2FuJ3QgdXNlIGludGVycnVwdCBtZWNoYW5pc20uCj4gV2UgdGFrZSBhbm90aGVyIHdheSB0
byB2ZXJpZnkuIFdoZW4gdGhlIGNvbXBhcmluZyBkYXRhIGlzIG5vdAo+IGVxdWFsIHRvIGRlc3Rp
bmF0aW9uIGRhdGEsIG92ZXJ3cml0ZSB0aGUgc291cmNlIGRhdGEgdG8gdGhlIGRlc3RpbmF0aW9u
Cj4gYnVmZmVyLiBPdGhlcndpc2UsIG9yaWdpbmFsIGRlc3RpbmF0aW9uIGRhdGEgdW5jaGFuZ2Vk
Lgo+IFNvIGlmIHRoZSBib19jcHUgZGF0YSBpcyBvdmVyd3JpdHRlbiwgdGhlIHJlc3VsdCBpcyBw
YXNzZWQuCj4gCj4gU3RlcHM6Cj4gMS4gdXNlIGxpbmVhciB3cml0ZSBwYWNrZXQgdG8gd3JpdGUg
MHhkZWFkYmVhZiB0byBzZWN1cmUgYnVmZmVyLAo+IDIuIHVzZSBhdG1vaWMgcGFja2V0IGFuZCBB
VE9NSUNfQ01QU1dBUF9SVE5fMzIgb3Bjb2RlIHRvIGNvbXBhcmUKPiB0aGUgY21wX2RhdGEoMHhk
ZWFkYmVhZikgdG8gdGhlIHdyaXR0ZW4gZGF0YSB3aGljaCBoYXMgYmVlbiBlbmNyeXB0ZWQuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4KPiAtLS0KPiAg
dGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVz
dHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gaW5kZXggOTA3MjM3ZS4uNWU2ODdl
MyAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwo+ICsrKyBiL3Rlc3Rz
L2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gQEAgLTEwOSw2ICsxMDksMjAgQEAgQ1VfVGVzdEluZm8g
YmFzaWNfdGVzdHNbXSA9IHsKPiAgI2RlZmluZQlTRE1BX09QQ09ERV9DT1BZCQkJCSAgMQo+ICAj
ICAgICAgIGRlZmluZSBTRE1BX0NPUFlfU1VCX09QQ09ERV9MSU5FQVIgICAgICAgICAgICAgICAg
MAo+ICAKPiArI2RlZmluZQlTRE1BX09QQ09ERV9BVE9NSUMJCQkJICAxMAo+ICsjCQlkZWZpbmUg
U0RNQV9BVE9NSUNfTE9PUCh4KSAgICAgICAgICAgICAgICgoeCkgPDwgMCkKPiArICAgICAgICAv
KiAwIC0gc2luZ2xlX3Bhc3NfYXRvbWljLgo+ICsgICAgICAgICAqIDEgLSBsb29wX3VudGlsX2Nv
bXBhcmVfc2F0aXNmaWVkLgo+ICsgICAgICAgICAqLwo+ICsjCQlkZWZpbmUgU0RNQV9BVE9NSUNf
VE1aKHgpICAgICAgICAgICAgICAgICgoeCkgPDwgMikKPiArCQkvKiAwIC0gbm9uLVRNWi4KPiAr
CQkgKiAxIC0gVE1aLgo+ICsJICAgICAqLwo+ICsjCQlkZWZpbmUgU0RNQV9BVE9NSUNfT1BDT0RF
KHgpICAgICAgICAgICAgICgoeCkgPDwgOSkKPiArCQkvKiBUQ19PUF9BVE9NSUNfQ01QU1dBUF9S
VE5fMzIgMHgwMDAwMDAwOAo+ICsJCSAqIHNhbWUgYXMgUGFja2V0IDMKPiArCQkgKi8KPiArCj4g
ICNkZWZpbmUgR0ZYX0NPTVBVVEVfTk9QICAweGZmZmYxMDAwCj4gICNkZWZpbmUgU0RNQV9OT1Ag
IDB4MAo+ICAKPiBAQCAtMTQwOCw2ICsxNDIyLDcgQEAgYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lv
bl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKGFtZGdwdV9kZXZpY2VfaGFuZGxlCj4g
IAlzdHJ1Y3QgYW1kZ3B1X2NzX3JlcXVlc3QgKmlic19yZXF1ZXN0Owo+ICAJdWludDY0X3QgYm9f
bWM7Cj4gIAl2b2xhdGlsZSB1aW50MzJfdCAqYm9fY3B1Owo+ICsJdWludDMyX3QgYm9fY3B1X29y
aWdpbjsKPiAgCWludCBpLCBqLCByLCBsb29wLCByaW5nX2lkOwo+ICAJdWludDY0X3QgZ3R0X2Zs
YWdzWzJdID0gezAsIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQ307Cj4gIAlhbWRncHVf
dmFfaGFuZGxlIHZhX2hhbmRsZTsKPiBAQCAtMTQ2MCw4ICsxNDc1LDkgQEAgYW1kZ3B1X2NvbW1h
bmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKGFtZGdwdV9kZXZp
Y2VfaGFuZGxlCj4gIAkJCQkJCQkJICBzZG1hX3dyaXRlX2xlbmd0aCk7Cj4gIAkJCQllbHNlCj4g
IAkJCQkJcG00W2krK10gPSBTRE1BX1BBQ0tFVChTRE1BX09QQ09ERV9XUklURSwKPiAtCQkJCQkJ
CSAgICAgICBTRE1BX1dSSVRFX1NVQl9PUENPREVfTElORUFSLCAwKTsKPiAtCQkJCXBtNFtpKytd
ID0gMHhmZmZmZmZmZiAmIGJvX21jOwo+ICsJCQkJCQkJICAgICAgIFNETUFfV1JJVEVfU1VCX09Q
Q09ERV9MSU5FQVIsCj4gKwkJCQkJCQkgICAgICAgc2VjdXJlID8gU0RNQV9BVE9NSUNfVE1aKDEp
IDogMCk7Cj4gKwkJCQlwbTRbaSsrXSA9IDB4ZmZmZmZmZmMgJiBib19tYzsKPiAgCQkJCXBtNFtp
KytdID0gKDB4ZmZmZmZmZmYwMDAwMDAwMCAmIGJvX21jKSA+PiAzMjsKPiAgCQkJCWlmIChmYW1p
bHlfaWQgPj0gQU1ER1BVX0ZBTUlMWV9BSSkKPiAgCQkJCQlwbTRbaSsrXSA9IHNkbWFfd3JpdGVf
bGVuZ3RoIC0gMTsKPiBAQCAtMTUxMyw2ICsxNTI5LDQxIEBAIGFtZGdwdV9jb21tYW5kX3N1Ym1p
c3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hhbmRs
ZQo+ICAJCQkJCQkJaXBfdHlwZSwgcmluZ19pZCwgaSwgcG00LAo+ICAJCQkJCQkJMSwgcmVzb3Vy
Y2VzLCBpYl9pbmZvLAo+ICAJCQkJCQkJaWJzX3JlcXVlc3QsIHRydWUpOwo+ICsJCQl9IGVsc2Ug
aWYgKGlwX3R5cGUgPT0gQU1ER1BVX0hXX0lQX0RNQSkgewo+ICsJCQkJLyogcmVzdG9yZSB0aGUg
Ym9fY3B1IHRvIGNvbXBhcmUgKi8KPiArCQkJCWJvX2NwdV9vcmlnaW4gPSBib19jcHVbMF07Cj4g
KwkJCQltZW1zZXQoKHZvaWQqKXBtNCwgMCwgcG00X2R3ICogc2l6ZW9mKHVpbnQzMl90KSk7Cj4g
KwkJCQkvKiBhdG9taWMgb3Bjb2RlIGZvciAzMmIgdy8gUlROIGFuZCBBVE9NSUNfU1dBUENNUF9S
VE4KPiArCQkJCSAqIGxvb3AsIDEtbG9vcF91bnRpbF9jb21wYXJlX3NhdGlzZmllZC4KPiArCQkJ
CSAqIHNpbmdsZV9wYXNzX2F0b21pYywgMC1scnUKPiArCQkJCSAqLwo+ICsJCQkJcG00W2krK10g
PSBTRE1BX1BBQ0tFVChTRE1BX09QQ09ERV9BVE9NSUMsCj4gKwkJCQkJCQkgICAgICAgMCwKPiAr
CQkJCQkJCSAgICAgICBTRE1BX0FUT01JQ19MT09QKDEpIHwKPiArCQkJCQkJCSAgICAgICBTRE1B
X0FUT01JQ19UTVooMSkgfAo+ICsJCQkJCQkJICAgICAgIFNETUFfQVRPTUlDX09QQ09ERShUQ19P
UF9BVE9NSUNfQ01QU1dBUF9SVE5fMzIpKTsKPiArCQkJCXBtNFtpKytdID0gMHhmZmZmZmZmYyAm
IGJvX21jOwo+ICsJCQkJcG00W2krK10gPSAoMHhmZmZmZmZmZjAwMDAwMDAwICYgYm9fbWMpID4+
IDMyOwo+ICsJCQkJcG00W2krK10gPSAweDEyMzQ1Njc4Owo+ICsJCQkJcG00W2krK10gPSAweDA7
Cj4gKwkJCQlwbTRbaSsrXSA9IDB4ZGVhZGJlYWY7Cj4gKwkJCQlwbTRbaSsrXSA9IDB4MDsKPiAr
CQkJCXBtNFtpKytdID0gMHgxMDA7Cj4gKwkJCQlhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcl9y
YXcoZGV2aWNlLCBjb250ZXh0X2hhbmRsZSwKPiArCQkJCQkJCWlwX3R5cGUsIHJpbmdfaWQsIGks
IHBtNCwKPiArCQkJCQkJCTEsIHJlc291cmNlcywgaWJfaW5mbywKPiArCQkJCQkJCWlic19yZXF1
ZXN0LCB0cnVlKTsKPiArCQkJCS8qIERNQSdzIGF0b21pYyBiZWhhdmlyIGlzIHVubGlrZSBHRlgK
PiArCQkJCSAqIElmIHRoZSBjb21wYXJpbmcgZGF0YSBpcyBub3QgZXF1YWwgdG8gZGVzdGluYXRp
b24gZGF0YSwKPiArCQkJCSAqIEZvciBHRlgsIGxvb3AgYWdhaW4gdGlsbCBnZnggdGltZW91dChz
eXN0ZW0gaGFuZykuCj4gKwkJCQkgKiBGb3IgRE1BLCBsb29wIGFnYWluIHRpbGwgdGltZXIgZXhw
aXJlZCBhbmQgdGhlbiBzZW5kIGludGVycnVwdC4KPiArCQkJCSAqIFNvIHRlc3RjYXNlIGNhbid0
IHVzZSBpbnRlcnJ1cHQgbWVjaGFuaXNtLgo+ICsJCQkJICogV2UgdGFrZSBhbm90aGVyIHdheSB0
byB2ZXJpZnkuIFdoZW4gdGhlIGNvbXBhcmluZyBkYXRhIGlzIG5vdAo+ICsJCQkJICogZXF1YWwg
dG8gZGVzdGluYXRpb24gZGF0YSwgb3ZlcndyaXRlIHRoZSBzb3VyY2UgZGF0YSB0byB0aGUgZGVz
dGluYXRpb24KPiArCQkJCSAqIGJ1ZmZlci4gT3RoZXJ3aXNlLCBvcmlnaW5hbCBkZXN0aW5hdGlv
biBkYXRhIHVuY2hhbmdlZC4KPiArCQkJCSAqIFNvIGlmIHRoZSBib19jcHUgZGF0YSBpcyBvdmVy
d3JpdHRlbiwgdGhlIHJlc3VsdCBpcyBwYXNzZWQuCj4gKwkJCQkgKi8KPiArCQkJCUNVX0FTU0VS
VF9OT1RfRVFVQUwoYm9fY3B1WzBdLCBib19jcHVfb3JpZ2luKTsKCkkgdGhpbmsgd2UgY2FuIGFk
ZCBvbmUgbW9yZSB0ZXN0IGZvciB0aGUgY2FzZSB0aGF0IG92ZXJ3cml0ZSB0aGUgc291cmNlCmRh
dGEgdG8gdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlci4KClRoYW5rcywKUmF5Cgo+ICAJCQl9Cj4gIAo+
ICAJCQlyID0gYW1kZ3B1X2JvX3VubWFwX2FuZF9mcmVlKGJvLCB2YV9oYW5kbGUsIGJvX21jLAo+
IC0tIAo+IDIuNy40Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
