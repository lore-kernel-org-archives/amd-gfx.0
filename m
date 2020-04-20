Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04765C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C655720672
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AHRvnJZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C655720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD926E529;
	Mon, 20 Apr 2020 12:38:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1136E529
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 12:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+MAjZLcUcqIdRWADjzD3n7vrTshlmNefWrQameHZ/2ABTSZbKaX0QCWTRy0ZwOCMD7IXuItdAG7GFXrJhg63m+vfO4cMMIFtXJJlo8RCiCt0/sBJSoDJaxP1d76TtO4pVnrvWZ6plZ7CkH7hrhGeOApZVvcNcaOECGewvB6H74oey3LvXqiy7Ho89q7rHrghnvE5i3jxi7tusiJA031l7AYJ6JVd2bn8QW+4asDj2n8/1TvZt6XSV/0jjswm/EFZhrEBMnqr19ol16NYqmC5/xDK3F7bofttrsMjsKKQ58C8d2tCauXL0ZJq9qMKSACRd/NQdd50ulMJ4rxi/Lhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtClyjgRcK1dq1gq5925ER1G7utpSg0W2havYWM3+s=;
 b=X90EWQuoedZHerNabTxUBzhI8b8JDmWO3ypwyLBwpaBZOc5S41V42x3ZJ55OXGJEoQrynOZT0MI8Ap5sAPrcre8CL0N2xTLxYHg78TbKEFU977V/p68bx0JddLzueGaHyMGWKl9g2MLkpO47cz4f7RvghgdoXgPlGcBGZDmafIo6OMLcmAUA2Z4pn3OPRWLPraseBQGJsbj2jYXkepj76CKdjbipMVieyR5gCmZxUcBgag3tN7TJJaj45kk/+S52JqFcJiaJhKjTIJ0YMhWOPeTQ9i/3V63HlaRj3f/2j58ZQqNe8vJ+AL9AnyxHcXH2rQqhtDykE7s+DscZznIFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJtClyjgRcK1dq1gq5925ER1G7utpSg0W2havYWM3+s=;
 b=AHRvnJZIOqXhGA6/vxYvk3hsSCAYNjJDm0bVNJCV0CDwC/ZoN8a3vRkN0YGFHRU+J3Js/OHAky1ARuUqy5slgR94efDAO+Dr78J9x37wD9sAc0Y/Cb9QG8+zA/sSLlAC3JI1XjP1WQI4WA+AwfXWPoxWPksIqhzvSQuawIvge94=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 12:38:45 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 12:38:45 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update spm register through mmio
Thread-Topic: [PATCH] drm/amdgpu: update spm register through mmio
Thread-Index: AQHWFxBe1cMFStlrQ0iiMEnk/q0TvqiB8w2g
Date: Mon, 20 Apr 2020 12:38:44 +0000
Message-ID: <MN2PR12MB3039204F5C83BCF03F805AA6E5D40@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200420123646.5955-1-yttao@amd.com>
In-Reply-To: <20200420123646.5955-1-yttao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e9446f8-0383-427e-cd1a-08d7e527c403
x-ms-traffictypediagnostic: MN2PR12MB4438:|MN2PR12MB4438:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4438E63E27C4267E66DF5F97E5D40@MN2PR12MB4438.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(76116006)(66476007)(64756008)(66446008)(5660300002)(66946007)(66556008)(8676002)(4326008)(8936002)(81156014)(110136005)(7696005)(71200400001)(52536014)(316002)(33656002)(15650500001)(186003)(26005)(9686003)(86362001)(55016002)(6506007)(53546011)(478600001)(6636002)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ICxnUhRDkd6IxnaWm/r6BXNRzGTQ+QeavSN4bDsLyORKj2/KuR9XG5MJPvEv6uYPhrK042RzsTbGoeoEN8RDVNdJMEHQJOU9Lc1FKcHhld7EErm+nIKO0GuE7VfftVqNBHGsQpaA4DAp07QiIpojotgLSj1Y1ZjtW4j0ph6JBDGYvIX5G8CWSLDYyBohB36j74470Ni8rjpTzkDKY5atcWoWP/5dbS6dAqePAQ3CaVxerCPasO/BBUWCq4vgxZJqILHI6yyUQUuSieLiXWJT7Oo08jbDFVbxj49gkLpNWnFU2NfM9BASch4rt5Gqmy6YnaaJSpdFG8PXXmhAjgMsaXfnC7v9KTZyzpcBLH3tnQmKgrh9Wji9ZUnODUvdlRJ6vyW6IEFxbVuoiQPd91sOSbs+LtlPkuqAIdhdE86Sq2hLh+RCS2GnVnf8hKYn0s7
x-ms-exchange-antispam-messagedata: ATYuG00L566oVKKK6HqmSxPpeS7lJdAt1NgDR2TJ+opPafuClRVlgnFYbiTu5w9U88IgxkDaQKTvVgDDBWKk1CIIFhIkr8hXE0TZJ7iTIaXdKcL3To4m+KMmRXsy6P/jJFA4xkEw+UXN7yCrDhZ8Nw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9446f8-0383-427e-cd1a-08d7e527c403
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 12:38:44.9474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDEfxp2Rr3ehfNSq98J/dS0itgrXY4/v7hlTvZGRT132sDH7LeUWcimwJHGT5T0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWRkIE1vbmsNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlpbnRpYW4gVGFv
IDx5dHRhb0BhbWQuY29tPiANClNlbnQ6IDIwMjDE6jTUwjIwyNUgMjA6MzcNClRvOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgbW9uay5saXVAYW1kLmNvDQpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFRhbywgWWludGlhbiA8WWludGlhbi5U
YW9AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogdXBkYXRlIHNwbSByZWdp
c3RlciB0aHJvdWdoIG1taW8NCg0KQWNjb3JkaW5nIHRvIFVNRCBkZXNpZ24sIG9ubHkgcnVubmlu
ZyBwZXJmb3JtYW5jZSBhbmFseXNpcyBiZW5jaG1hcmsganVzdCBsaWtlIFJHUCwgR1BBIGFuZCBz
byBvbiBuZWVkIHRvIHVwZGF0ZSBzcG0gcmVnaXN0ZXIgYW5kIG90aGVycyB3aWxsIG5vdCBzdXBw
b3J0IHRoaXMgZmVhdHVyZS4NClRoZXJlZm9yZSwgd2UgY2FuIGRpcmVjdGx5IGFjY2VzcyBzcG0g
cmVnaXN0ZXIgdGhyb3VnaCBtbWlvLg0KDQpTaWduZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0
YW9AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
ICAgIHwgNCArKystDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgICAg
fCA0ICsrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgICB8IDQg
KystLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1X2NvbW1vbi5oIHwgMyArKysN
CiA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQppbmRleCBhY2NiYjM0ZWE2NzAuLjgy
MGY1NjBhZGMzMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KQEAg
LTEwODMsNyArMTA4Myw5IEBAIGludCBhbWRncHVfdm1fZmx1c2goc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iLA0KIAlib29sIHVwZGF0ZV9zcG1fdm1pZF9u
ZWVkZWQgPSAoam9iLT52bSAmJiAoam9iLT52bS0+cmVzZXJ2ZWRfdm1pZFt2bWh1Yl0gIT0gTlVM
TCkpOw0KIAlpbnQgcjsNCiANCi0JaWYgKHVwZGF0ZV9zcG1fdm1pZF9uZWVkZWQgJiYgYWRldi0+
Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKQ0KKwlpZiAoKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikgfHwgYW1kZ3B1X3Bhc3N0aHJvdWdoKGFkZXYpIHx8DQorCSAgICAgYW1kZ3B1X3NyaW92
X2lzX3BwX29uZV92ZihhZGV2KSkgJiYNCisJICAgIHVwZGF0ZV9zcG1fdm1pZF9uZWVkZWQgJiYg
YWRldi0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKQ0KIAkJYWRldi0+Z2Z4LnJsYy5m
dW5jcy0+dXBkYXRlX3NwbV92bWlkKGFkZXYsIGpvYi0+dm1pZCk7DQogDQogCWlmIChhbWRncHVf
dm1pZF9oYWRfZ3B1X3Jlc2V0KGFkZXYsIGlkKSkgeyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYw0KaW5kZXggMGEwM2UyYWQ1ZDk1Li5iZmI4NzNmMDIzYzcgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC03MDMyLDEyICs3MDMyLDEyIEBAIHN0
YXRpYyB2b2lkIGdmeF92MTBfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHVuc2lnbmVkIHZtaWQpICB7DQogCXUzMiBkYXRhOw0KIA0KLQlkYXRhID0gUlJFRzMy
X1NPQzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQorCWRhdGEgPSBSUkVHMzJfU09DMTVf
Tk9fS0lRKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQogDQogCWRhdGEgJj0gflJMQ19TUE1f
TUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0s7DQogCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01D
X0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1J
RF9fU0hJRlQ7DQogDQotCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRh
dGEpOw0KKwlXUkVHMzJfU09DMTVfTk9fS0lRKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0
YSk7DQogfQ0KIA0KIHN0YXRpYyBib29sIGdmeF92MTBfMF9jaGVja19ybGNnX3JhbmdlKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
CmluZGV4IDg0ZmNmODQyMzE2ZC4uNTE0ZWZjNGZlMjY5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYw0KQEAgLTQ5NTAsMTIgKzQ5NTAsMTIgQEAgc3RhdGljIHZvaWQgZ2Z4
X3Y5XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25l
ZCB2bWlkKSAgew0KIAl1MzIgZGF0YTsNCiANCi0JZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwg
bW1STENfU1BNX01DX0NOVEwpOw0KKwlkYXRhID0gUlJFRzMyX1NPQzE1X05PX0tJUShHQywgMCwg
bW1STENfU1BNX01DX0NOVEwpOw0KIA0KIAlkYXRhICY9IH5STENfU1BNX01DX0NOVExfX1JMQ19T
UE1fVk1JRF9NQVNLOw0KIAlkYXRhIHw9ICh2bWlkICYgUkxDX1NQTV9NQ19DTlRMX19STENfU1BN
X1ZNSURfTUFTSykgPDwgUkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfX1NISUZUOw0KIA0K
LQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBkYXRhKTsNCisJV1JFRzMy
X1NPQzE1X05PX0tJUShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOw0KIH0NCiANCiBz
dGF0aWMgYm9vbCBnZnhfdjlfMF9jaGVja19ybGNnX3JhbmdlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVfY29t
bW9uLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNV9jb21tb24uaA0KaW5kZXgg
Yzg5M2M2NDVhNGIyLi41NmQwMmFhNjkwYTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNV9jb21tb24uaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTVfY29tbW9uLmgNCkBAIC0zNSw2ICszNSw5IEBADQogI2RlZmluZSBSUkVHMzJfU09D
MTUoaXAsIGluc3QsIHJlZykgXA0KIAlSUkVHMzIoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBd
W2luc3RdW3JlZyMjX0JBU0VfSURYXSArIHJlZykNCiANCisjZGVmaW5lIFJSRUczMl9TT0MxNV9O
T19LSVEoaXAsIGluc3QsIHJlZykgXA0KKwlSUkVHMzJfTk9fS0lRKGFkZXYtPnJlZ19vZmZzZXRb
aXAjI19IV0lQXVtpbnN0XVtyZWcjI19CQVNFX0lEWF0gKyByZWcpDQorDQogI2RlZmluZSBSUkVH
MzJfU09DMTVfT0ZGU0VUKGlwLCBpbnN0LCByZWcsIG9mZnNldCkgXA0KIAlSUkVHMzIoKGFkZXYt
PnJlZ19vZmZzZXRbaXAjI19IV0lQXVtpbnN0XVtyZWcjI19CQVNFX0lEWF0gKyByZWcpICsgb2Zm
c2V0KQ0KIA0KLS0NCjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
