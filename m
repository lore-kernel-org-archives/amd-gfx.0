Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298DC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C185F20732
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 09:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C185F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896086E2E2;
	Fri, 15 Nov 2019 09:39:34 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C926E317
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 09:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di4eDG5e5yp8wI//Cmi7g+Ev0/V4hb4oniif3JsTURrx3Zht3nuFBo5RD4jWBuX7j/LbWdCPN8Kxp8wI6Ki/YQQ9IIubru2bkx3+dyv0R6+BYOGuUrYEmMEmnj7QdVvA+0h3Z+WtjVqLP7HOKAj13DRP5S9lyKRNs2rVKR9jftlbUPfju+Yo1XR2tbGhglWlv4wQRuEB+6KM7KMx/baEG5s68HMgopWDNLM18HXdFOz1i8S0I1ID/VXgD7M7Q2iJYDm4aiHUmRtRBUzM33dsDkmPJgwJCqUvHP3vLBMTU1hTSj4z62gBqaF2kVcb5bKcmXp4df/VF0h7z3MLbDkUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vOcNY/wS0TJ9QLzj/SMCFuwGcwbUIUqjIm8t5m4RSk=;
 b=IK/hmStexBlq2qE9Q37YPNYvQb+dT2Y9ztNmqG6KewKqj3gcz+MCKRzK5/qfywM1V78c3eNGV9jgz1yEq5AHsEOZ405IA5tq8DfdGwErZbtgLuroyG9E7n16yM/F1dh+JZt6bMiXKLS0jeOl/3Z9pNGQ4Bn5U9ZgxO/QccSZ+PJrkE0oY6XY2GXXIJCw0Nnf1Zsrp0iRmCGvdLrMa7U2uYHlW0MpXwDnmPc+2FpiomNkT+qv+U5pfBHo+3PgjbY5mnitgOxBJJ76eGk+ivngpxqnw/7C2R+tC+Mb/1nRXcQSm9FmUVZVC7Rd42HY+p1qQnaEJrZG1T27zH5ehOaAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3583.namprd12.prod.outlook.com (20.178.241.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 15 Nov 2019 09:39:30 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::fd53:64a7:a2:715b%5]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 09:39:30 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
Thread-Topic: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
Thread-Index: AdWbmHVg4HH/Wt2jQYS7tySpdTGaHA==
Date: Fri, 15 Nov 2019 09:39:30 +0000
Message-ID:
 <MN2PR12MB3309733309CD294F522314FDEC700@MN2PR12MB3309.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8386bcd4-4216-4f96-39d0-08d769afb711
x-ms-traffictypediagnostic: MN2PR12MB3583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3583B2BCDFC60BA87293EB84EC700@MN2PR12MB3583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(229853002)(6862004)(81166006)(66446008)(486006)(8676002)(3846002)(66946007)(76116006)(81156014)(71200400001)(71190400001)(66476007)(66556008)(66066001)(2906002)(55016002)(6116002)(14444005)(256004)(6246003)(8936002)(186003)(6436002)(6636002)(33656002)(74316002)(64756008)(305945005)(476003)(54906003)(9686003)(478600001)(7736002)(316002)(99286004)(25786009)(102836004)(7696005)(26005)(86362001)(5660300002)(6506007)(14454004)(4326008)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3583;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3DkuxtSVMk3Thg6qNnGDlEZOnwgkKXEnZT+JxeJxQe1tGoLYazCCAbxsjR5U6q1Ht4FlUVHPNvoR2cHe2gSX43afkN4gist8VShxLQ2VFSCLGM6wL7egutJqT71K/fOniGfiuWHSiAzDj2kzmjs0Rg8ZboWLa4N5iouyabYCDH9zPzW6UrGHeAKu/QodpfvWGaL+8sYBA9I3Atmau0uffP8bTi27QS83XYRE9//8bWA+VNkXOnNeZwBg3dYrULWahs5lz2+bw6xHNYh0o01Ha+g74YYnSrpEqEoKr2XIjlMU+ziIjZuHH+YTx8EhU9/kkE+nYXCOQqAJq+raZ+6RNB4BHf2MvPT8A1AMUcLIpRtjH440WHEQJwycoXgUGQvfxJxJAI0FHIcEOuNiWL/YnMfbu5iT9R1lRcZDrlmsJ2GpsW6AOORI+5uWMsaR3W0N
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8386bcd4-4216-4f96-39d0-08d769afb711
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 09:39:30.6468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avNbhe4YBlZxe8KlD1bGTc1ZySbWzTwq+ZFXBA1XVnpw4j+85gTqdYbfrtRnEj3I2I9vn+g37ZgvdlaAVB5+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vOcNY/wS0TJ9QLzj/SMCFuwGcwbUIUqjIm8t5m4RSk=;
 b=GDirtp3wRns+UnLiQbP9MKp1hdWqxBPAsVxM+KEdJSsoXAGsm5gBBiqV3LhvIg0Eqjg3Ue8qSrgGzlRuMuJiKT+M0uz35dgzmIxwecanJi1G+gDVsMCY6M3uPJy/3tUTJv9X+ron3tE3YWr+4IkqnoRXq4xajrgRSCeC8PTlnME=
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
Message-ID: <20191115093930.DtkBdIbXRNKmA1f3Yi_JPXALtY5tLvnS3hDuSSpwqs4@z>

T24gRnJpLCBOb3YgMTUsIDIwMTkgYXQgMTE6MzQ6NTBBTSArMDgwMCwgTGl1LCBBYXJvbiB3cm90
ZToKPiBJbiBrZXJuZWwsIGNzLT5pbi5mbGFncyBpcyB1c2VkIGZvciBUTVouIEhlbmNlIGxpYmRy
bSBzaG91bGQgdHJhbnNmZXIgCj4gdGhlIGZsYWcgdG8ga2VybmVsLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+Cj4gLS0tCj4gIGFtZGdwdS9hbWRncHUu
aCAgICB8IDQgKysrLQo+ICBhbWRncHUvYW1kZ3B1X2NzLmMgfCA0ICsrKysKPiAgMiBmaWxlcyBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
YW1kZ3B1L2FtZGdwdS5oIGIvYW1kZ3B1L2FtZGdwdS5oIGluZGV4IGY0NWY5ZjcuLmFlZTNmM2Qg
Cj4gMTAwNjQ0Cj4gLS0tIGEvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvYW1kZ3B1L2FtZGdwdS5o
Cj4gQEAgLTM0Miw3ICszNDIsOSBAQCBzdHJ1Y3QgYW1kZ3B1X2NzX2ZlbmNlX2luZm8gewo+ICAg
KiBcc2EgYW1kZ3B1X2NzX3N1Ym1pdCgpCj4gICovCj4gIHN0cnVjdCBhbWRncHVfY3NfcmVxdWVz
dCB7Cj4gLQkvKiogU3BlY2lmeSBmbGFncyB3aXRoIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gKi8K
PiArCS8qKiBTcGVjaWZ5IGZsYWdzIHdpdGggYWRkaXRpb25hbCBpbmZvcm1hdGlvbgo+ICsJICog
MC1ub3JtYWwsIDEtdG16Cj4gKwkgKi8KPiAgCXVpbnQ2NF90IGZsYWdzOwo+ICAKPiAgCS8qKiBT
cGVjaWZ5IEhXIElQIGJsb2NrIHR5cGUgdG8gd2hpY2ggdG8gc2VuZCB0aGUgSUIuICovIGRpZmYg
LS1naXQgCj4gYS9hbWRncHUvYW1kZ3B1X2NzLmMgYi9hbWRncHUvYW1kZ3B1X2NzLmMgaW5kZXgg
NDM3YzRhNC4uNmY3MDc3MSAKPiAxMDA2NDQKPiAtLS0gYS9hbWRncHUvYW1kZ3B1X2NzLmMKPiAr
KysgYi9hbWRncHUvYW1kZ3B1X2NzLmMKPiBAQCAtMjU0LDYgKzI1NCwxMCBAQCBzdGF0aWMgaW50
IGFtZGdwdV9jc19zdWJtaXRfb25lKGFtZGdwdV9jb250ZXh0X2hhbmRsZSBjb250ZXh0LAo+ICAJ
bWVtc2V0KCZjcywgMCwgc2l6ZW9mKGNzKSk7Cj4gIAljcy5pbi5jaHVua3MgPSAodWludDY0X3Qp
KHVpbnRwdHJfdCljaHVua19hcnJheTsKPiAgCWNzLmluLmN0eF9pZCA9IGNvbnRleHQtPmlkOwo+
ICsJLyogaW4ga2VybmVsLCBfcGFkIGlzIHVzZWQgYXMgZmxhZ3MKPiArCSAqICNkZWZpbmUgQU1E
R1BVX0NTX0ZMQUdTX1NFQ1VSRSAgICAgICAgICAoMSA8PCAwKQo+ICsJICovCj4gKwljcy5pbi5f
cGFkID0gKHVpbnQzMl90KWlic19yZXF1ZXN0LT5mbGFnczsKCl9wYWQgaXMgbm90IGdvb2QgaGVy
ZS4gQmVjYXVzZSBpdCdzIHVzZWQgdG8gcGFzcyB0aGUgZmxhZ3MgdG8gaW5wdXQgcGFyYW0uCgpJ
dCdzIGJldHRlciB0byByZW5hbWUgIl9wYWQiIGluIGRybV9hbWRncHVfY3NfaW4gYXMgImZsYWdz
IiBoZXJlLgoKVGhhbmtzLApSYXkKCj4gIAlpZiAoaWJzX3JlcXVlc3QtPnJlc291cmNlcykKPiAg
CQljcy5pbi5ib19saXN0X2hhbmRsZSA9IGlic19yZXF1ZXN0LT5yZXNvdXJjZXMtPmhhbmRsZTsK
PiAgCWNzLmluLm51bV9jaHVua3MgPSBpYnNfcmVxdWVzdC0+bnVtYmVyX29mX2liczsKPiAtLQo+
IDIuNy40Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
