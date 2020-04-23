Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B0C55186
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49E92076C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qv9w2FNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E92076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879086E49C;
	Thu, 23 Apr 2020 09:28:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670D86E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM7063NiT19tGumq4UqNkLw57rzwPRzDkXY8lOg38UidI0QfrLw+n0p6nWaIG+/iks7sxdXPNiJVYEdtEsCzPlTabtybOdMmNX2WqmDrR2kD9tUU7FSHP+IGHB6hNE3qLxfitJ8RTVjtWZArQy2HVgLKbopUREJknGOyqQLC51xkp9csvCjIPinyCVOcKdhOq2T0C33AnmI2SfVreUe9S7BS1l35ow9hkLqYGtw9Dp3BKlxetch7tnE0wPqHwu6TgaylIiZSWNfvlaXaXUZqEXSc8Vlr9cepuoek7yTgRRTfLOtMCEWScvJRvOJpqOFj7U4RQ7uExx2XFzVg3Eu3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PNW/Z+vIspKyv1C4C/TTbaDX+SznmuA0HALUKE00aQ=;
 b=EiHdQ5ho+//uHHRoDiFkPop0xBcdYDLHd2bcUNGO4+qQy4Mn58wtnAOtJt7QRE48NHekDIGpqKosXdXNfTL7q7dMFhnbTfJodXqqkXk7PwM7/rsL3143vtsUWTwwuf5wHiXHWx4cmvaaUMXqYd4FNEqn1UInM/ORXmbD4s8tVlHglHIorpRlSzWWsGiEeCkH/ehJpjMoiqPhRg5qyJcK9Mm/cLACqqCAur0TJiUthDmUDT5tRxIePnhTw5WCDJNYijQl9F6Vm9cj6Ds/aOQ1J8UIau/eVr2LvS0/sJ1M4JPx1Uy1l/X+Ra1ZXicknwXKdxsdTHTw2GiXNWqoa2cY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PNW/Z+vIspKyv1C4C/TTbaDX+SznmuA0HALUKE00aQ=;
 b=Qv9w2FNdpF7asI1DbpQ4BEErmG/OJtsEbk35y6nPCK8vC8ze4QiUv16tg9UTfLiWINX8RcWM7Guti+R2UXShfPRuvdj/k+wv6TnySPZJR3iBW8xwIry789y+hb9Hj3q6MD8XjaIMTolNRkbtmPxVMotEjQuy13xQwcy8YclEozw=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 09:28:48 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 09:28:48 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: drop the unused local variable
Thread-Topic: [PATCH 2/2] drm/amdgpu: drop the unused local variable
Thread-Index: AQHWGU3htaGd/gPKtUWR+i1PGvk9y6iGcCoQ
Date: Thu, 23 Apr 2020 09:28:48 +0000
Message-ID: <MN2PR12MB3039FC2867324639A5A9AC19E5D30@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
 <1587632511-12504-2-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1587632511-12504-2-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b07eaa24-0bb8-427b-b726-08d7e768ba61
x-ms-traffictypediagnostic: MN2PR12MB3293:|MN2PR12MB3293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3293ACB9347188E90A1233FEE5D30@MN2PR12MB3293.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(8936002)(76116006)(4326008)(316002)(66446008)(66476007)(5660300002)(64756008)(66946007)(33656002)(7696005)(9686003)(186003)(55016002)(53546011)(2906002)(66556008)(8676002)(6506007)(52536014)(45080400002)(81156014)(71200400001)(110136005)(478600001)(966005)(26005)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfH9XDTFQPocRJ4Oc7gGVcJ6474joNd9ANS6CdAkAQKto3htXWObbTa54Gw+n2Mz3Ey3mBuFO/Cj7O3E+MS2lvXp1aCtWG0QnZQzwsoPwLPlxrEPLAMA4gaNfrbgwnEXc1bVkdx0PMcOp7kp1JLicXVdE9vYVGpkDKWCnKGYXmu1b324W1aqMI5ColVyUcP7v6A+uy8lQxjJ4ywdM/0V7ZCDkm6J6Y181aCdE1mLspHCmRG3gLw6BkKYAuLkImsnS2LwMwKu4P9y18mLP/iz7mYvWWsGbs2MWSGkI/1zlqE3MaQxoYPDyEIjumFJn+Uxh9BjIla15vvzwnKMJbgdubE24uWvOqHQsSEv5SAdxbYyDOljNuKQMRMkjLNgC881l96qCns2T7ltKt6+cLnSG7TOhkDZ1NRq7Coa8acYy5X3U74/ANxn3jJAnUolQdC4SbqqeH3itxWCHK2unsWua6D8b7MqM2QPQKFw24c/mfk=
x-ms-exchange-antispam-messagedata: mQJs0W3KR5YyQYEah7Pzs67cR8aQ8ySi0XUVxKVOOoPDWY565rT9W2FO9bCXP3gGtuIo6WkM4alAVAdZtsIpbVG++IzNWnu6wlthPbBSVVzDi8JBeBBEKKfq2RGuLHwM08NhzQn2b8GsmwQjieyrcw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07eaa24-0bb8-427b-b726-08d7e768ba61
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 09:28:48.4076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGEb85ZI0bOtyzmIxdedHDaWM5TxFa7jlO7aFe9ZobiQ4KTlHlk4PKFX3P9Gcvc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgIEhhd2tpbmcNCg0KQ2FuIHlvdSBoZWxwIGFsc28gcmVtb3ZlIHRoZSBzYW1lIGxvY2FsIHZh
cmlhYmxlIGtpcSBmb3IgZ2Z4X3YxMF8wX3JpbmdfZW1pdF9ycmVnPyBUaGFua3MgaW4gYWR2YW5j
ZS4NCkFmdGVyIHRoYXQgLCBSZXZpZXdlZC1ieTogWWludGlhbiBUYW8gPHlpbnRpYW4udGFvQGFt
ZC5jb20+DQoNCg0KDQpCZXN0IFJlZ2FyZHMNCllpbnRpYW4gVGFvDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIEhhd2tpbmcgWmhhbmcNClNlbnQ6IDIwMjDE6jTUwjIzyNUg
MTc6MDINClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1k
Z3B1OiBkcm9wIHRoZSB1bnVzZWQgbG9jYWwgdmFyaWFibGUNCg0KbG9jYWwgdmFyaWFibGUga2lx
IHdvbid0IGJlIHVzZWQgaW4gZnVuY3Rpb24gZ2Z4X3Y4XzBfcmluZ19lbWl0X3JyZWcNCg0KQ2hh
bmdlLUlkOiBJNjIyOTk4N2M4Y2U0M2ZmMGQ1NWUxZmFlMTVlZGU5Y2IwODI3Zjc2ZA0KU2lnbmVk
LW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDEgLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KaW5k
ZXggOGRjOGU5MC4uOTY0NDYxNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8w
LmMNCkBAIC02Mzk1LDcgKzYzOTUsNiBAQCBzdGF0aWMgdm9pZCBnZnhfdjhfMF9yaW5nX2VtaXRf
cnJlZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IHJlZywNCiAJCQkJICAgIHVp
bnQzMl90IHJlZ192YWxfb2ZmcykNCiB7DQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
cmluZy0+YWRldjsNCi0Jc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOw0K
IA0KIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfQ09QWV9EQVRBLCA0
KSk7DQogCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDAgfAkvKiBzcmM6IHJlZ2lzdGVyKi8NCi0t
DQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpo
dHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMl
M0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQt
Z2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N5aW50aWFuLnRhbyU0MGFtZC5jb20lN0MzZTM1MWViZGQ3
ZmY0NTI1OWU2MTA4ZDdlNzY1MDJkMCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNk
JTdDMCU3QzAlN0M2MzcyMzIyOTMzMzI2MDEzNzYmYW1wO3NkYXRhPWRIMm8lMkJsOSUyRmpxelAy
SUlONDNxSURyYnBtbVFwWGpQd2dHdnlhQWMlMkIxTDglM0QmYW1wO3Jlc2VydmVkPTANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
