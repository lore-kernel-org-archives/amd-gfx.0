Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA5C43141
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6127620740
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6127620740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212B26E2E8;
	Fri, 15 Nov 2019 09:44:14 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED846E2E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 09:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIYPh3EXs4SdY//saxDaSeySp5rNgpfsLMy2xD5jyT0wiRDArmYb6UNlR3t1dXc3gi3UdfIVaNyQl/F7LH+bnSKobSIcUW8kg6kyp3Fo76OWVm0aD6PGqFuD7OUZCQnrW/NxuvplPD6UtS8PbC0bBLwkgTemjnejmMmbP3rG7v+l6FqXDdDDhabEPn+2UxSQl9xXKhfBW00mh1U+1dJYm9TIQyVexCYCxe3L/syMSBBumKvcQQi0srWATt6UpsXLiIu3+cJ15CANDSSPRytI84xht5F45ItOxS6m7KSWtEuTsvMLKIlhU36iDSFDg35RbReDZhMeYkP/PDcytV5dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehR7q8O9rMMK5gPDgrpibf+CnqsRkp7yCC8I7oH+GTs=;
 b=jluZoNbMWp08ckUeDr/w8T9I4sbQNUFqbfDRYh5rsbJnMuk4My+l/AAcX+PF+i3jD83zoFJrr5HMDryscdpgJnF1YXYn4OtaNq+TR1AHDxXpP+FGoHeZ37tuZtrF/vG/PB0efzykwNT2GV6pWdUVP5mC9Ek/P/B1czgSIH4g8crVAgOVQxDXpd3uEePk4rPlFCnvP9wqMePJt/l730DWV2vLmu/YioxI8TpNwK1mUn40P6PGMwrYHmQKW6+s3oRFPTbEukwVxvphlrmFWCdcvdfV2eTZGWK3nOjIilbxMwsV86DEvwTWIY4vBnkmqDhbPeaTpmD4aBnNEiGjjl8/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3583.namprd12.prod.outlook.com (20.178.241.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 15 Nov 2019 09:44:11 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 09:44:11 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 09/12] tests/amdgpu: add atomic_mem cp_packet to verify
 the secure buffer
Thread-Topic: [PATCH 09/12] tests/amdgpu: add atomic_mem cp_packet to verify
 the secure buffer
Thread-Index: AQHVm2XCWhirzU9Kb0+DdfYGUXDwwaeMgY8A
Date: Fri, 15 Nov 2019 09:44:11 +0000
Message-ID:
 <MN2PR12MB3309FD25B0FD713A4E207A08EC700@MN2PR12MB3309.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6edf9ef6-c8fa-4c60-07b1-08d769b05ea0
x-ms-traffictypediagnostic: MN2PR12MB3583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3583AA2F42FDBCDC8F47ECD8EC700@MN2PR12MB3583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(74316002)(64756008)(446003)(33656002)(9686003)(478600001)(305945005)(54906003)(476003)(8936002)(6436002)(6636002)(186003)(26005)(76176011)(25786009)(99286004)(102836004)(7696005)(86362001)(6506007)(5660300002)(52536014)(14454004)(4326008)(7736002)(316002)(11346002)(6246003)(486006)(8676002)(229853002)(6862004)(66446008)(81166006)(6116002)(55016002)(2906002)(66066001)(15650500001)(14444005)(256004)(66946007)(81156014)(76116006)(3846002)(66556008)(71190400001)(71200400001)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3583;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHDa/KhyK9CNU3FHrGOYfwzy/mn3SKx4M89/GJ8GHca0erWTAom7mlBB0TiEL8dm4x27+j6LT9CjJIRdKFhi8ycuci0Dk7lsXmrkRY1Ru+j//5uSKQyBgw2TALkefNY4iVftFgAdcKuOnXY4C+YQFvVdisC547a2DQL4GbgFJubarZ+rbSx8tR2nCmsUsp7UcvaVowTGxiVwQN8bOMJ8y/ZgLB+Kp5M0ca1tFF/hC+6Gnl/oFVCEwCRPg9fBY/+srPaaN1dHq9PQZ5edmtw5SEsikGhVaZF8lKnP7s5Z1isXFyH76Gc5MshLnvioQfxI3buNO9dFHRPS0KrxFBdPv+NVbsA6KuUzI87xEl4GnNxX4wI2/Jlbdw1ZOa/uu0p5/uGnNtwDDrEDS0fhSTuTI4X0PZJQvV5x4+aUnoES7hCGQP6g84qBJNy/6CtXYOqg
Content-ID: <69687A36FB67FB44A59455115CE1CDDD@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edf9ef6-c8fa-4c60-07b1-08d769b05ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:44:11.7641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V43JTBGvC0swu/cFjlS5aSz3aJaIgEoC0XJRREh4x9ZzwVxAWvL1VGnmoQ793dTvg5XaUnA7E9jy2Wbm1cFAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehR7q8O9rMMK5gPDgrpibf+CnqsRkp7yCC8I7oH+GTs=;
 b=1eMvGip510Y1NI4gkzQteidp3OHSCE/EibiYTvuS+xRSU1VoeQdZPfHQ/0qeVwmP9Xw4+PhrSvknrWX25BG766CzAihFNUqeqp3ZsfLRfi0Bm5vJNbL/FA6cLRTJ4Ingq7KLii8LouX82tNQAOr9N6YcTOIQZaY0LF8hDiExi44=
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
Message-ID: <20191115094411.4Nq2xz7vZK7S24hUQbhNfUjMF9UISKWCXbD1iiZfJ-E@z>

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
