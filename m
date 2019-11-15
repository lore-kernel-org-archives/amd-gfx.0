Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC3FC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2C42073B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2C42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA506E342;
	Fri, 15 Nov 2019 10:04:23 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820055.outbound.protection.outlook.com [40.107.82.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29B76E342
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 10:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH9D/xH3WDn732RGBlcIyszd4/GyxxDX4LuIWRV+vr4NpQ5gOK7PAdHvD1LC2131/6hv/k4bYf2qywkrqz/l6yhz8LzOIoeaAelmJbtpQtjzV7XWfIVJJOrGAEUtLyuaErPv3/Wn3V5DXl0PPtlTZVQuqJ+Qdqzds02XTeA+XaPgUOC40lIieDpZ3kOspKplW+a4W4g0o+NCgDg+SLoeMOT1TOgGdmOQ11mfpCtHc2Av5tuYv89lW/7lnXTKQkHPpbmz8RJ3dB3SXjiXMRcRwCnKYuFlZnb/YGj8uzDMffS5/lw5Wx5YMV021YNOCdpxGlJDG4LrIHhfABaxh7UhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehR7q8O9rMMK5gPDgrpibf+CnqsRkp7yCC8I7oH+GTs=;
 b=SQ3oL/mjtXyKv7ME31mbEeBWWExHbd+9PsFAmoLBjRBfvItHmOi5GS0ETVga9gc/jr9Z6q3wyi9BFNqbcl1NcIzISrIrv1NaRre+3karBPICmgWOO7VtCcNTW9If0TRgyEApn1/DuLsKoEBkA+Nb6K0QKBhxLBcNWDmbcBKz3TZpKpMBYcIHYOtlp4mxBzFu4k89qHpaGeaRSrdaeaTotcz6s0p2wNbN3SFiTt+y0R9D4Zv3hLXFcQRvjwhLt5I3v2klG7wBxl5hJDLL3bmENCIAWxM/J411dB15hypR+6FQh+eSulgM5XnsV/f9dpGqHLjzX8rhow2lrSQ56Ed77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3743.namprd12.prod.outlook.com (10.255.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 10:04:21 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 10:04:21 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 09/12] tests/amdgpu: add atomic_mem cp_packet to verify
 the secure buffer
Thread-Topic: [PATCH 09/12] tests/amdgpu: add atomic_mem cp_packet to verify
 the secure buffer
Thread-Index: AQHVm2XCWhirzU9Kb0+DdfYGUXDwwaeMh1gA
Date: Fri, 15 Nov 2019 10:04:21 +0000
Message-ID:
 <MN2PR12MB33098EF169D3CEC38A4F00C9EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-9-git-send-email-aaron.liu@amd.com>
In-Reply-To: <1573788895-3936-9-git-send-email-aaron.liu@amd.com>
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
x-ms-office365-filtering-correlation-id: 52d6a954-834a-438e-f52e-08d769b32faa
x-ms-traffictypediagnostic: MN2PR12MB3743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3743C77961E7DDA97ED672ADEC700@MN2PR12MB3743.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
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
x-microsoft-antispam-message-info: 8CPtZp82TnDtjPUM6Vr9InE25H4x1biuoLZAkW7ayCZsltsVF3Vf3jzyvEZudF/sxXFGJykXMl91JMsRE7QPLMw6E3SaZaLG0voMf8w5tBooE/wdKyupmx3nma+9o7pP533c79je2CePlWda+Foi3oeYzeoip9jSMeWM7hHfPwG+DiGygLe6jeYNpDcIKJjngvUjRdtYo1SQREVIXGTOhCDlQDWtHPCzgEabgCMZC42KKetKP5NenbvBm22JIsjC8fGmrg3LcEr2jldX+urRxCZ/53OipKLU2vz6Ydp7Yz4gnSNE+qaEDegDBdwUkcdAk2+XOiflHC4uAMqeZ9DQSc5bLbAHvAs3UyBNvW/32Yr2mTnx86KJaH/WSAgcKCLB1K60IAereVPMtN7zu6Oo6e9+U1Daqq/zb773HAfu5VgTS0QeZQGXAxZJiJNfNuVP
Content-ID: <30855559CDB4B146BD3489A2E3C191AB@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d6a954-834a-438e-f52e-08d769b32faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:04:21.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7juMLg/dg6Ff1Jh4T74G/QZq0C506gJaJ4ylkgmzTBZ6ADpqk90yBoY/3RldQAga4VeqPk9mApUoJqlWyA+cmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehR7q8O9rMMK5gPDgrpibf+CnqsRkp7yCC8I7oH+GTs=;
 b=QgZnE0KMxMQDW1IW3C4cnezEGAFC73nIVlX4Yrgz+NjKkQ62xPcyPfgdwtVHcWqnet3SmgwJ7YEjSoYipBuxogka2V6SnryZJaOqRUIGlfXS5DbrYCRvn0KfczBF8NQGRichrTX6aeZBJKrXS4IxALpGhe814ZTOeTJ0p3Jqiko=
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
Message-ID: <20191115100421.q-7IxddguopPsz7KOr1agKI-4eZibgo8crAaywRUVso@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTJBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBTZWN1cmUgYnVmZmVyIGlzIG9ubHkgYWJsZSB0byBiZSByZWFkIHdpdGggdHJ1c3RlZCBp
cCBibG9jay4KPiBTbyB3ZSBuZWVkIHVzZSBHRlggaXAgdG8gcmVhZCBpdCBiYWNrIGluc3RlYWQg
b2YgQ1BVLgo+IFN0ZXBzOgo+IDEuIHVzZSB3cml0ZV9kYXRhIHBhY2tldCB0byB3cml0ZSAweGRl
YWRiZWFmIHRvIHNlY3VyZSBidWZmZXIsCj4gMi4gdXNlIGF0bW9pY19tZW0gcGFja2V0IGFuZCBB
VE9NSUNfQ01QU1dBUF9SVE5fMzIgb3Bjb2RlIHRvIGNvbXBhcmUKPiB0aGUgY21wX2RhdGEoMHhk
ZWFkYmVhZikgdG8gdGhlIHdyaXR0ZW4gZGF0YSB3aGljaCBoYXMgYmVlbiBlbmNyeXB0ZWQuCj4g
SWYgdGhlIHJlc3VsdCBpcyBlcXVhbCwgdGhlbiBvdmVyd3JpdGUgdGhlIHNyY19kYXRhKDB4MTIz
NDU2NzgpIHRvIHRoZQo+IHNlY3VyZSBidWZmZXIgYW5kIHJldHVybiBkaXJlY3RseS4gT3RoZXJ3
aXNlIGxvb3AgYWdhaW4gdW50aWwgZ2Z4IHRpbWVvdXQKPiBhbmQgdGhlIHNlY3VyZSBidWZmZXIg
ZGF0YSB1bmNoYW5nZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgoKPiAt
LS0KPiAgdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgfCA0MyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYmFzaWNf
dGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gaW5kZXggOTU2YmU5My4uOTA3
MjM3ZSAxMDA2NDQKPiAtLS0gYS90ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYwo+ICsrKyBiL3Rl
c3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gQEAgLTE2MCw2ICsxNjAsMjAgQEAgQ1VfVGVzdElu
Zm8gYmFzaWNfdGVzdHNbXSA9IHsKPiAgCQkgKiAyIC0gY2UKPiAgCQkgKi8KPiAgCj4gKyNkZWZp
bmUJUEFDS0VUM19BVE9NSUNfTUVNCQkJCTB4MUUKPiArI2RlZmluZSAgICAgVENfT1BfQVRPTUlD
X0NNUFNXQVBfUlROXzMyICAgICAgICAgIDB4MDAwMDAwMDgKPiArI2RlZmluZSAgICAgQVRPTUlD
X01FTV9DT01NQU5EKHgpICAgICAgICAgICAgICAgKCh4KSA8PCA4KQo+ICsgICAgICAgICAgICAv
KiAwIC0gc2luZ2xlX3Bhc3NfYXRvbWljLgo+ICsgICAgICAgICAgICAgKiAxIC0gbG9vcF91bnRp
bF9jb21wYXJlX3NhdGlzZmllZC4KPiArICAgICAgICAgICAgICovCj4gKyNkZWZpbmUgICAgIEFU
T01JQ19NRU1fQ0FDSEVQT0xJQ0FZKHgpICAgICAgICAgICgoeCkgPDwgMjUpCj4gKyAgICAgICAg
ICAgIC8qIDAgLSBscnUuCj4gKyAgICAgICAgICAgICAqIDEgLSBzdHJlYW0uCj4gKyAgICAgICAg
ICAgICAqLwo+ICsjZGVmaW5lICAgICBBVE9NSUNfTUVNX0VOR0lORVNFTCh4KSAgICAgICAgICAg
ICAoKHgpIDw8IDMwKQo+ICsgICAgICAgICAgICAvKiAwIC0gbWljcm9fZW5naW5lLgo+ICsJCQkg
Ki8KPiArCj4gICNkZWZpbmUJUEFDS0VUM19ETUFfREFUQQkJCQkweDUwCj4gIC8qIDEuIGhlYWRl
cgo+ICAgKiAyLiBDT05UUk9MCj4gQEAgLTE0NzIsOCArMTQ4NiwzMyBAQCBhbWRncHVfY29tbWFu
ZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUoYW1kZ3B1X2Rldmlj
ZV9oYW5kbGUKPiAgCj4gIAkJCS8qIHZlcmlmeSBpZiBTRE1BIHRlc3QgcmVzdWx0IG1lZXRzIHdp
dGggZXhwZWN0ZWQgKi8KPiAgCQkJaSA9IDA7Cj4gLQkJCXdoaWxlKGkgPCBzZG1hX3dyaXRlX2xl
bmd0aCkgewo+IC0JCQkJQ1VfQVNTRVJUX0VRVUFMKGJvX2NwdVtpKytdLCAweGRlYWRiZWFmKTsK
PiArCQkJaWYgKCFzZWN1cmUpIHsKPiArCQkJCXdoaWxlKGkgPCBzZG1hX3dyaXRlX2xlbmd0aCkg
ewo+ICsJCQkJCUNVX0FTU0VSVF9FUVVBTChib19jcHVbaSsrXSwgMHhkZWFkYmVhZik7Cj4gKwkJ
CQl9Cj4gKwkJCX0gZWxzZSBpZiAoaXBfdHlwZSA9PSBBTURHUFVfSFdfSVBfR0ZYKSB7Cj4gKwkJ
CQltZW1zZXQoKHZvaWQqKXBtNCwgMCwgcG00X2R3ICogc2l6ZW9mKHVpbnQzMl90KSk7Cj4gKwkJ
CQlwbTRbaSsrXSA9IFBBQ0tFVDMoUEFDS0VUM19BVE9NSUNfTUVNLCA3KTsKPiArCQkJCS8qIGF0
b21pYyBvcGNvZGUgZm9yIDMyYiB3LyBSVE4gYW5kIEFUT01JQ19TV0FQQ01QX1JUTgo+ICsJCQkJ
ICogY29tbWFuZCwgMS1sb29wX3VudGlsX2NvbXBhcmVfc2F0aXNmaWVkLgo+ICsJCQkJICogc2lu
Z2xlX3Bhc3NfYXRvbWljLCAwLWxydQo+ICsJCQkJICogZW5naW5lX3NlbCwgMC1taWNyb19lbmdp
bmUKPiArCQkJCSAqLwo+ICsJCQkJcG00W2krK10gPSAoVENfT1BfQVRPTUlDX0NNUFNXQVBfUlRO
XzMyIHwKPiArCQkJCQkJCUFUT01JQ19NRU1fQ09NTUFORCgxKSB8Cj4gKwkJCQkJCQlBVE9NSUNf
TUVNX0NBQ0hFUE9MSUNBWSgwKSB8Cj4gKwkJCQkJCQlBVE9NSUNfTUVNX0VOR0lORVNFTCgwKSk7
Cj4gKwkJCQlwbTRbaSsrXSA9IDB4ZmZmZmZmZmMgJiBib19tYzsKPiArCQkJCXBtNFtpKytdID0g
KDB4ZmZmZmZmZmYwMDAwMDAwMCAmIGJvX21jKSA+PiAzMjsKPiArCQkJCXBtNFtpKytdID0gMHgx
MjM0NTY3ODsKPiArCQkJCXBtNFtpKytdID0gMHgwOwo+ICsJCQkJcG00W2krK10gPSAweGRlYWRi
ZWFmOwo+ICsJCQkJcG00W2krK10gPSAweDA7Cj4gKwkJCQlwbTRbaSsrXSA9IDB4MTAwOwo+ICsJ
CQkJYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXJfcmF3KGRldmljZSwgY29udGV4dF9oYW5kbGUs
Cj4gKwkJCQkJCQlpcF90eXBlLCByaW5nX2lkLCBpLCBwbTQsCj4gKwkJCQkJCQkxLCByZXNvdXJj
ZXMsIGliX2luZm8sCj4gKwkJCQkJCQlpYnNfcmVxdWVzdCwgdHJ1ZSk7Cj4gIAkJCX0KPiAgCj4g
IAkJCXIgPSBhbWRncHVfYm9fdW5tYXBfYW5kX2ZyZWUoYm8sIHZhX2hhbmRsZSwgYm9fbWMsCj4g
LS0gCj4gMi43LjQKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
