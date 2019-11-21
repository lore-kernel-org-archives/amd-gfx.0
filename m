Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D748C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 08:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4937520718
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 08:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4937520718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359D26EB9F;
	Thu, 21 Nov 2019 08:31:40 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820059.outbound.protection.outlook.com [40.107.82.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4946EB9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 08:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXn0P5RO7TQ9xxXeIv39hIyo4HOEjsn05EX3EjrJZ3QgWBFpLzoJ9tz1p8NtTLvSK1d0Esl4UENX8a4MvTegRDUzaC2/QLRkbhL83H4qgNJp/N6cj2rDYqe3ydG+S0jcs3W9zl9yUbI2sqCgPi+OgYG8tPBX0hsKcFDzDZrd+hBHJYJNr2XSLWQQEp/rZYPlIobHGRzJ/Il3Dby9thf/5RbSevISZGekNJTZwb/lovHegycRgA0xG5xHzITAT/TiKK7qAthkH+T0pz3cW8yad00GMnBiH9pEmKe9Y6Fzs4Urm4xMxKFaccpgKUx596DSC2nuN/q1lQz/MntdIbBsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d+V63TeaY+1D7UGK8fiSOLFYi/GJTPJFhrkv7Feb7M=;
 b=lyEiEfYbl4E/PY5fA8Y8zD5AqGqtB2ks9tl3M72NV8ah0nPu3pyC00xreS1CAGEpMcHqsRpkv82R53i97WYnBanGuMH0AXi9Ob8otQtgON2Vyph9TGM7RGiiutMAt9d5QnS447wa2IjzL4+E34pmaNHuuEhEv2VRig/KyQDgq5YdnQQC1G/qhFeNCXl/jb5OwYVtst+9QIXKR0NireejAIlr+BIkruL284/1N0k2TNGjmkIslGNvyV4zBnZXjStvaW134mqSGOm9MhvzcCIlC+bbFH+Nq68T8T2m7+oa/5gGKaLpHw2+toiZipZRACsUhOvejJFGjAz4kAUsv6CreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4062.namprd12.prod.outlook.com (10.255.224.207) by
 MN2PR12MB2925.namprd12.prod.outlook.com (20.179.81.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 08:31:36 +0000
Received: from MN2PR12MB4062.namprd12.prod.outlook.com
 ([fe80::b1d2:7223:ddd7:f29f]) by MN2PR12MB4062.namprd12.prod.outlook.com
 ([fe80::b1d2:7223:ddd7:f29f%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:31:35 +0000
From: "Li, Ching-shih (Louis)" <Ching-shih.Li@amd.com>
To: "Li, Ching-shih (Louis)" <Ching-shih.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Thread-Topic: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
Thread-Index: AQHVmp3lH4Mx28xYgEWmfAjOoACxF6eVVmeQ
Date: Thu, 21 Nov 2019 08:31:34 +0000
Message-ID:
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
In-Reply-To: <20191114034212.1106-1-Ching-shih.Li@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.68.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07b70ed2-382a-449a-803d-08d76e5d3860
x-ms-traffictypediagnostic: MN2PR12MB2925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2925D6F3D0AFBEDE79B6DB42AA4E0@MN2PR12MB2925.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(47660400002)(189003)(199004)(13464003)(66946007)(66556008)(64756008)(66446008)(66066001)(99286004)(66476007)(256004)(14444005)(14454004)(76116006)(54906003)(110136005)(478600001)(305945005)(316002)(7736002)(5660300002)(74316002)(446003)(71200400001)(71190400001)(11346002)(25786009)(86362001)(3846002)(76176011)(7696005)(81166006)(6506007)(53546011)(8936002)(81156014)(6246003)(8676002)(2501003)(9686003)(55016002)(186003)(6436002)(26005)(229853002)(2906002)(4326008)(6116002)(52536014)(33656002)(102836004)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2925;
 H:MN2PR12MB4062.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wskYW2JmESh0oJUczwZhKNebgpJ24kMBNB1CaHp+sXlN1ZQI/AQjqbXf/DeogMSZNxdT3Oax18DJiRXZy5DWE2VrO6Lpu7U0//SZTL3ViA5xImJiTzLlObE+Dp1wgh3BuNBX9ESoYwmUxDwSrFz9HaOUkVR9+pzBG7/gYrjzZZrEsRK4BoVcIC43TPY0NX29Ct5Wu6PnM8geyF/9d9MGtaMLKQBqsfcxQjtOJAvljNHrgIqPVwF+ZNR+lD4Y2rn/OxkXJKaLHvE7IHcKWNI317BVpH9FE/ygdVAAiC5fWnSqSPhLNUqT0dO+nPccLH8tDLB4UREZBARVRNe010SBc9UAXGMcJzNGiDof98/2RzlFsGjen7N7boX6L/OX7Rpspw1omZ+/YcyE6ahz/VfA09H/5SJg1jbyTOYnNeHzQfhDIUGDRrVyEbfaUsTcGoIm
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b70ed2-382a-449a-803d-08d76e5d3860
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 08:31:34.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oe7fnMseVeJZkUop1pSZuKZJca9wxMueO9zp0nzKCODhtXZzzUxyoYjffpWlqy1KXQX3N24fIBo75VPksv4Faw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d+V63TeaY+1D7UGK8fiSOLFYi/GJTPJFhrkv7Feb7M=;
 b=f21B9L9tbpgyzusEL78Ld7cTDcLs3GLAgi6+WKMH7Uc417a1MhIbO/Pxfem4q9SXfet7zD4sLAx+iGn0U35cy8dFQ2xqaU5X79ED/zRJmeSNrJ/OjDcuWcqbsZY39p1ktahdgu6WC+Tiru4cHYs0FpsLnrs6w6T3rSjvNL9ryc8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ching-shih.Li@amd.com; 
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121083134.MahAg90it6qQsCis_r11i6Ex76Z2ta8dtzNfQNhpcgg@z>

SGkgcmV2aWV3ZXJzLAoKV2hhdCBpcyB0aGUgcmV2aWV3IHJlc3VsdCBmb3IgdGhpcyBwYXRjaD8g
Q3VzdG9tZXIgaXMgcHVzaGluZyBvbiB0aGlzIGNoYW5nZSB0byBtZXJnZS4gVEtTIGZvciB5b3Vy
IGF0dGVudGlvbi4KCkJSLApMb3VpcwoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTog
TG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4gClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJl
ciAxNCwgMjAxOSAxMTo0MiBBTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6
IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBXZW50
bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgQ2hpbmctc2hpaCAoTG91
aXMpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+ClN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZC9k
aXNwbGF5OiBGaXggQXBwbGUgZG9uZ2xlIGNhbm5vdCBiZSBzdWNjZXNzZnVsbHkgZGV0ZWN0ZWQK
CltXaHldCkV4dGVybmFsIG1vbml0b3IgY2Fubm90IGJlIGRpc3BsYXllZCBjb25zaXN0ZW50bHks
IGlmIGNvbm5lY3RpbmcgdmlhIHRoaXMgQXBwbGUgZG9uZ2xlIChBMTYyMSwgVVNCIFR5cGUtQyB0
byBIRE1JKS4KQnkgZXhwZXJpbWVudHMsIGl0IGlzIGNvbmZpcm1lZCB0aGF0IHRoZSBkb25nbGUg
bmVlZHMgMjAwbXMgYXQgbGVhc3QgdG8gYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24sIGFmdGVy
IGl0IHNldHMgSFBEIHNpZ25hbCBoaWdoLgoKW0hvd10KV2hlbiByZWNlaXZpbmcgSFBEIElSUSwg
ZGVsYXkgMzAwbXMgYXQgdGhlIGJlZ2lubmluZyBvZiBoYW5kbGVfaHBkX2lycSgpLgpUaGVuIHJ1
biB0aGUgb3JpZ2luYWwgcHJvY2VkdXJlLgpXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgdGhlIHBy
b2JsZW0gY2Fubm90IGJlIHJlcHJvZHVjZWQuCldpdGggb3RoZXIgZG9uZ2xlcywgdGVzdCByZXN1
bHRzIGFyZSBQQVNTLgpUZXN0IHJlc3VsdCBpcyBQQVNTIHRvIHBsdWcgaW4gSERNSSBjYWJsZSB3
aGlsZSBwbGF5aW5nIHZpZGVvLCBhbmQgdGhlIHZpZGVvIGlzIGJlaW5nIHBsYXlpbmcgc21vb3Ro
bHkuClRlc3QgcmVzdWx0IGlzIFBBU1MgYWZ0ZXIgc3lzdGVtIHJlc3VtZXMgZnJvbSBzdXNwZW5k
LgoKU2lnbmVkLW9mZi1ieTogTG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNSArKysr
KwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IDBhZWY5MmI3YzAzNy4u
NWI4NDRiNmE1YTU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTEwMjUsNiArMTAyNSwxMSBAQCBzdGF0aWMgdm9pZCBoYW5k
bGVfaHBkX2lycSh2b2lkICpwYXJhbSkKIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gY29ubmVj
dG9yLT5kZXY7CiAJZW51bSBkY19jb25uZWN0aW9uX3R5cGUgbmV3X2Nvbm5lY3Rpb25fdHlwZSA9
IGRjX2Nvbm5lY3Rpb25fbm9uZTsKIAorCS8qIFNvbWUgbW9uaXRvcnMvZG9uZ2xlcyBuZWVkIGFy
b3VuZCAyMDBtcyB0byBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbgorCSAqIGFmdGVyIHRob3Nl
IGRldmljZXMgZHJpdmUgSFBEIHNpZ25hbCBoaWdoLgorCSAqLworCW1zbGVlcCgzMDApOworCiAJ
LyogSW4gY2FzZSBvZiBmYWlsdXJlIG9yIE1TVCBubyBuZWVkIHRvIHVwZGF0ZSBjb25uZWN0b3Ig
c3RhdHVzIG9yIG5vdGlmeSB0aGUgT1MKIAkgKiBzaW5jZSAoZm9yIE1TVCBjYXNlKSBNU1QgZG9l
cyB0aGlzIGluIGl0J3Mgb3duIGNvbnRleHQuCiAJICovCi0tCjIuMjEuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
