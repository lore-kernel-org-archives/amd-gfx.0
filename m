Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F2C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 21:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B0F206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 21:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B0F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8186E419;
	Thu, 14 Nov 2019 21:20:00 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690050.outbound.protection.outlook.com [40.107.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0686E419
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 21:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIPPbrKbMIf0fNSbx0yKJ/qUjHP+C2qJ7obR1rAXHnkPy8/tXi9sJaVSnx23l/sMT6al1g7l4dU4WsSR9HAuxB/ss9PEqt46grqFsc+vQ098b2i7k5sjTQWUz44lrjr+RB8hXyjvD4RYrX+rwDIixseaR9Fyf+bhg24888rABvTMqYvMTMrxldryCxx/1xhhsgXCb9ooD5byRyxIhYQ4ut6KicMbMr8m/7woEpxJPhIXVUQ1VnaFOoGATCH3n997toefD+xzt7u6pVev35054mgg028YB9ikcZNYbxz9u9lZsGS0rRjWIokApOVySfxAiD+JgGJTCdByV+bwqM0gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C7MwDHW6DOsirsKaiIqJ7hraa5EWoWj+TA5qW4OWAY=;
 b=NB55H5TCgE0HaljRAWyD0UeM+lJe+2zwBNBtJWCN/gMsKsnbkR+Qg48mttEkEb7K92EIY629ATuz2tJPFex3iU53r56gC8aIGI8vXosnVGH6prRZLFfbefEG/cx8iof1uhXyf2Bbd8SrqbytpU5J/4OtYW/T1DNM24XfEdBmCzo0h6uLnRQjrykbdRlAlxiOWUFQDpWYDIOqmYlnhX3kQ6grGLG4xtuVS3eqAbScQjvfJvTWxBUdFHXMtiedpgwDqMUNCb8ddx8fUkpjuSQG4asYYBlw/Z1SB+WFX3KKIt6Tls666Fb/HcdFd5crU3nDLVCF/vz3t2WhYIaFiGK/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) by
 DM5PR12MB1434.namprd12.prod.outlook.com (10.168.238.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 14 Nov 2019 21:19:57 +0000
Received: from DM5PR12MB2405.namprd12.prod.outlook.com
 ([fe80::30bf:4864:7a7e:cfc1]) by DM5PR12MB2405.namprd12.prod.outlook.com
 ([fe80::30bf:4864:7a7e:cfc1%7]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 21:19:57 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/dsc: Use 32-bit integers for some DSC parameter
 calculations
Thread-Topic: [PATCH 2/2] drm/dsc: Use 32-bit integers for some DSC parameter
 calculations
Thread-Index: AQHVmlWcx1ljPnWBHkyWFQQkg25tPaeLLdNQ
Date: Thu, 14 Nov 2019 21:19:57 +0000
Message-ID:
 <DM5PR12MB2405C3A53FF6EAC45FD7C3F3EE710@DM5PR12MB2405.namprd12.prod.outlook.com>
References: <20191113190728.26645-1-mikita.lipski@amd.com>
 <20191113190728.26645-2-mikita.lipski@amd.com>
In-Reply-To: <20191113190728.26645-2-mikita.lipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47156e96-246e-4857-1d12-08d769486689
x-ms-traffictypediagnostic: DM5PR12MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB14349F2797280744D7F489C6EE710@DM5PR12MB1434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(13464003)(199004)(189003)(66476007)(74316002)(66446008)(66556008)(64756008)(66946007)(66066001)(6116002)(86362001)(3846002)(25786009)(2501003)(4326008)(76116006)(2906002)(6246003)(478600001)(5660300002)(52536014)(7736002)(305945005)(186003)(26005)(476003)(446003)(486006)(6436002)(11346002)(256004)(9686003)(55016002)(99286004)(102836004)(7696005)(6506007)(53546011)(76176011)(81156014)(316002)(14454004)(33656002)(229853002)(71200400001)(71190400001)(81166006)(8676002)(8936002)(54906003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1434;
 H:DM5PR12MB2405.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6u2tLVwGMkyJ0OsholqdhvZ0dLGBVhztqFFhMxdv9EAW3pMjEGXFNiyr4waawRaEVVIfbv0Qeh9YRFOW7pZU08NFRPn0z6wvkPC2FdeSUObuaikkKxZTRIKk6lXdGJUqUhx8PWFI486HTaed9rnkVA1GcsUYYW4F3WWmOryvw5DxixnpC4fu2Fndfnq4UGoer1Od6ocGp9aDTmf7DOkWgHIBllrBQNX6SUUJV6jH2hJl62EZtTC2dRIsHdMcEbEXZN1AfxpjsvpG2MP5FzcTV/p9/atdsZKMfT0TgjQfKDmXhdByww7Wf5P/wgJzo0PqU+qKrmA9Vxvi8FGIrBLetyHcD7uWr2IXw5Lq66xDd4yxATr/eEexguWFV77vVJqRQwhSEDuaG+U74OvGfIvBwxf+snsaHeLvsurA5jAkEC8NhPKcDEvYEJILGIZf3GF
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47156e96-246e-4857-1d12-08d769486689
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 21:19:57.3049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3wCYuZxV/6pJ2se2FvPjbJB/25oSLGHHqlT/Z1TTbhUlgwMcUHBwUsIAwITUiM6IfoABoiBs0BTMdXBiRAOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C7MwDHW6DOsirsKaiIqJ7hraa5EWoWj+TA5qW4OWAY=;
 b=wWPBb7rPMXnSEv8wCWXfFr7ipt5o6AvnFL1YRyWz9XuHmfvNqmL1JgzPq7Wqazc9fbVJlcFLzdkDxPlb3aVRKBpPqNoQ0X8OBkKoiMEkTlRHj+RHUzs6PI/J37C1k21VLh8zNe8444mUV+aCfI7ycL88YTb9wCW/3sP9ZbnR0jw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nikola.Cornij@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>, "Lipski,
 Mikita" <Mikita.Lipski@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114211957.uBIbeTSTO3otKTTvVXSg-46tXkhjelJW939h4XwpzUc@z>

TG9va3MgZ29vZCB0byBtZQoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogbWlraXRh
LmxpcHNraUBhbWQuY29tIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+IApTZW50OiBOb3ZlbWJlciAx
MywgMjAxOSAyOjA3IFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogV2Vu
dGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQ29ybmlqLCBOaWtvbGEgPE5pa29sYS5Db3Ju
aWpAYW1kLmNvbT47IG1hbmFzaS5kLm5hdmFyZUBpbnRlbC5jb207IExpcHNraSwgTWlraXRhIDxN
aWtpdGEuTGlwc2tpQGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9kc2M6IFVzZSAz
Mi1iaXQgaW50ZWdlcnMgZm9yIHNvbWUgRFNDIHBhcmFtZXRlciBjYWxjdWxhdGlvbnMKCkZyb206
IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KClt3aHldClRoZXJlIGFyZSBh
IGZldyBEU0MgUFBTIHBhcmFtZXRlcnMsIHN1Y2ggYXMgc2NhbGVfaW5jcmVtZW50X2ludGVydmFs
LCB0aGF0IGNvdWxkIG92ZXJmbG93IDE2LWJpdCBpbnRlZ2VyIGlmIG5vbi1EU0Mtc3BlYy1jb21w
bGlhbnQgY29uZmlndXJhdGlvbiB3YXMgdXNlZC4gVGhlcmUgaXMgYSBjaGVjayBpbiB0aGUgY29k
ZSBhZ2FpbnN0IHRoYXQsIGhvd2V2ZXIgMTYtYml0IGludGVnZXIgaXMgdXNlZCB0byBzdG9yZSB0
aG9zZSB2YWx1ZXMsIHdoaWNoIGludmFsaWRhdGVzIHRoZSBjaGVjaywgbGV0dGluZyBpbnZhbGlk
IGNvbmZpZ3VyYXRpb25zIHRocm91Z2guCgpbaG93XQpVc2UgMzItYml0IGludGVnZXJzIGZvciB0
aGUgYWZmZWN0ZWQgRFNDIFBQUyBwYXJhbWV0ZXJzIGNhbGN1bGF0aW9ucwoKU2lnbmVkLW9mZi1i
eTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBN
aWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2RybV9kc2MuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kc2MuYyBpbmRl
eCA3OWM3MWUzZmM5NzMuLjc0ZjM1MjdmNTY3ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2RybV9kc2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jCkBAIC0yOTcsNiArMjk3
LDkgQEAgaW50IGRybV9kc2NfY29tcHV0ZV9yY19wYXJhbWV0ZXJzKHN0cnVjdCBkcm1fZHNjX2Nv
bmZpZyAqdmRzY19jZmcpCiAJdW5zaWduZWQgbG9uZyBmaW5hbF9zY2FsZSA9IDA7CiAJdW5zaWdu
ZWQgbG9uZyByYnNfbWluID0gMDsKIAl1bnNpZ25lZCBsb25nIG1heF9vZmZzZXQgPSAwOworCXUz
MiBuZmxfYnBnX29mZnNldDsKKwl1MzIgbnNsX2JwZ19vZmZzZXQ7CisJdTMyIHNjYWxlX2luY3Jl
bWVudF9pbnRlcnZhbDsKIAogCWlmICh2ZHNjX2NmZy0+bmF0aXZlXzQyMCB8fCB2ZHNjX2NmZy0+
bmF0aXZlXzQyMikgewogCQkvKiBOdW1iZXIgb2YgZ3JvdXBzIHVzZWQgdG8gY29kZSBlYWNoIGxp
bmUgb2YgYSBzbGljZSAqLyBAQCAtMzY0LDI4ICszNjcsMzIgQEAgaW50IGRybV9kc2NfY29tcHV0
ZV9yY19wYXJhbWV0ZXJzKHN0cnVjdCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcpCiAJCSAqIGhl
bmNlIHdlIG11bHRpcGx5IGJ5IDJeMTEgZm9yIHByZXNlcnZpbmcgdGhlCiAJCSAqIGZyYWN0aW9u
YWwgcGFydAogCQkgKi8KLQkJdmRzY19jZmctPm5mbF9icGdfb2Zmc2V0ID0gRElWX1JPVU5EX1VQ
KCh2ZHNjX2NmZy0+Zmlyc3RfbGluZV9icGdfb2Zmc2V0IDw8IDExKSwKKwkJbmZsX2JwZ19vZmZz
ZXQgPSBESVZfUk9VTkRfVVAoKHZkc2NfY2ZnLT5maXJzdF9saW5lX2JwZ19vZmZzZXQgPDwgCisx
MSksCiAJCQkJCQkJKHZkc2NfY2ZnLT5zbGljZV9oZWlnaHQgLSAxKSk7CiAJZWxzZQotCQl2ZHNj
X2NmZy0+bmZsX2JwZ19vZmZzZXQgPSAwOworCQluZmxfYnBnX29mZnNldCA9IDA7CiAKIAkvKiAy
XjE2IC0gMSAqLwotCWlmICh2ZHNjX2NmZy0+bmZsX2JwZ19vZmZzZXQgPiA2NTUzNSkgeworCWlm
IChuZmxfYnBnX29mZnNldCA+IDY1NTM1KSB7CiAJCURSTV9ERUJVR19LTVMoIk5mbEJwZ09mZnNl
dCBpcyB0b28gbGFyZ2UgZm9yIHRoaXMgc2xpY2UgaGVpZ2h0XG4iKTsKIAkJcmV0dXJuIC1FUkFO
R0U7CiAJfQogCisJdmRzY19jZmctPm5mbF9icGdfb2Zmc2V0ID0gKHUxNiluZmxfYnBnX29mZnNl
dDsKKwogCWlmICh2ZHNjX2NmZy0+c2xpY2VfaGVpZ2h0ID4gMikKLQkJdmRzY19jZmctPm5zbF9i
cGdfb2Zmc2V0ID0gRElWX1JPVU5EX1VQKCh2ZHNjX2NmZy0+c2Vjb25kX2xpbmVfYnBnX29mZnNl
dCA8PCAxMSksCisJCW5zbF9icGdfb2Zmc2V0ID0gRElWX1JPVU5EX1VQKCh2ZHNjX2NmZy0+c2Vj
b25kX2xpbmVfYnBnX29mZnNldCA8PCAKKzExKSwKIAkJCQkJCQkodmRzY19jZmctPnNsaWNlX2hl
aWdodCAtIDEpKTsKIAllbHNlCi0JCXZkc2NfY2ZnLT5uc2xfYnBnX29mZnNldCA9IDA7CisJCW5z
bF9icGdfb2Zmc2V0ID0gMDsKIAotCWlmICh2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgPiA2NTUz
NSkgeworCWlmIChuc2xfYnBnX29mZnNldCA+IDY1NTM1KSB7CiAJCURSTV9ERUJVR19LTVMoIk5z
bEJwZ09mZnNldCBpcyB0b28gbGFyZ2UgZm9yIHRoaXMgc2xpY2UgaGVpZ2h0XG4iKTsKIAkJcmV0
dXJuIC1FUkFOR0U7CiAJfQogCisJdmRzY19jZmctPm5zbF9icGdfb2Zmc2V0ID0gKHUxNiluc2xf
YnBnX29mZnNldDsKKwogCS8qIE51bWJlciBvZiBncm91cHMgdXNlZCB0byBjb2RlIHRoZSBlbnRp
cmUgc2xpY2UgKi8KIAlncm91cHNfdG90YWwgPSBncm91cHNfcGVyX2xpbmUgKiB2ZHNjX2NmZy0+
c2xpY2VfaGVpZ2h0OwogCkBAIC00MDIsMTAgKzQwOSwxMCBAQCBpbnQgZHJtX2RzY19jb21wdXRl
X3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9kc2NfY29uZmlnICp2ZHNjX2NmZykKIAkJICogYXMg
KE5mbEJwZ09mZnNldCArIFNsaWNlQnBnT2Zmc2V0KSBoYXMgMTEgYml0IGZyYWN0aW9uYWwgdmFs
dWUsCiAJCSAqIHdlIG5lZWQgZGl2aWRlIGJ5IDJeMTEgZnJvbSBwc3REc2NDZmcgdmFsdWVzCiAJ
CSAqLwotCQl2ZHNjX2NmZy0+c2NhbGVfaW5jcmVtZW50X2ludGVydmFsID0KKwkJc2NhbGVfaW5j
cmVtZW50X2ludGVydmFsID0KIAkJCQkodmRzY19jZmctPmZpbmFsX29mZnNldCAqICgxIDw8IDEx
KSkgLwotCQkJCSgodmRzY19jZmctPm5mbF9icGdfb2Zmc2V0ICsKLQkJCQl2ZHNjX2NmZy0+bnNs
X2JwZ19vZmZzZXQgKworCQkJCSgobmZsX2JwZ19vZmZzZXQgKworCQkJCW5zbF9icGdfb2Zmc2V0
ICsKIAkJCQl2ZHNjX2NmZy0+c2xpY2VfYnBnX29mZnNldCkgKgogCQkJCShmaW5hbF9zY2FsZSAt
IDkpKTsKIAl9IGVsc2UgewpAQCAtNDEzLDE0ICs0MjAsMTYgQEAgaW50IGRybV9kc2NfY29tcHV0
ZV9yY19wYXJhbWV0ZXJzKHN0cnVjdCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcpCiAJCSAqIElm
IGZpbmFsU2NhbGVWYWx1ZSBpcyBsZXNzIHRoYW4gb3IgZXF1YWwgdG8gOSwgYSB2YWx1ZSBvZiAw
IHNob3VsZAogCQkgKiBiZSB1c2VkIHRvIGRpc2FibGUgdGhlIHNjYWxlIGluY3JlbWVudCBhdCB0
aGUgZW5kIG9mIHRoZSBzbGljZQogCQkgKi8KLQkJdmRzY19jZmctPnNjYWxlX2luY3JlbWVudF9p
bnRlcnZhbCA9IDA7CisJCXNjYWxlX2luY3JlbWVudF9pbnRlcnZhbCA9IDA7CiAJfQogCi0JaWYg
KHZkc2NfY2ZnLT5zY2FsZV9pbmNyZW1lbnRfaW50ZXJ2YWwgPiA2NTUzNSkgeworCWlmIChzY2Fs
ZV9pbmNyZW1lbnRfaW50ZXJ2YWwgPiA2NTUzNSkgewogCQlEUk1fREVCVUdfS01TKCJTY2FsZUlu
Y3JlbWVudEludGVydmFsIGlzIGxhcmdlIGZvciBzbGljZSBoZWlnaHRcbiIpOwogCQlyZXR1cm4g
LUVSQU5HRTsKIAl9CiAKKwl2ZHNjX2NmZy0+c2NhbGVfaW5jcmVtZW50X2ludGVydmFsID0gKHUx
NilzY2FsZV9pbmNyZW1lbnRfaW50ZXJ2YWw7CisKIAkvKgogCSAqIERTQyBzcGVjIG1lbnRpb25z
IHRoYXQgYml0c19wZXJfcGl4ZWwgc3BlY2lmaWVzIHRoZSB0YXJnZXQKIAkgKiBiaXRzL3BpeGVs
IChicHApIHJhdGUgdGhhdCBpcyB1c2VkIGJ5IHRoZSBlbmNvZGVyLAotLQoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
