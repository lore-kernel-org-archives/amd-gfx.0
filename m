Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1090C35254
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 17:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A1220842
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 17:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yPd7KC1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A1220842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380796E9CD;
	Mon, 10 Feb 2020 17:56:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C066E21F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 17:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXNkSflyE+CNwmdnh1pYnOqY2B/JilcPsCYoGc/p39w3I4xdFFOFVbhanRop/1HMstpFh5qutdetCZoNqYstWzYEzBJPrCWFtpkFcLW5VN5w/zQbppE0rDV+qjFGffC2OEbj67VK57FnCvc8EYeZKrXL7qtmJYH8yhQ0dkujL1L6fe7ICUdwxLGd/Rv1hGCasY8uR9kOBZqLsKyZtTtvZBaf8zNdcz5fpruy29VCgrQkspzukWziZ+vfIQYq8+9HsWFazdkHKVIXSCSq86VWnjD4yCDnc3iq04XnH23s106Pa7oVcvDZHMqUpcRZRoKdxrT0ckCG9wLE2jnIm2fPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoXm1ieBs8M1/Rl6O4oOmwrP2xz3pTLM1kEDmBbQbv0=;
 b=a/xV3nspil03iihEcaRxxYddUMpeO/e0dYGobB5Lwg+AXVQ7B5i+hq3zPGGPsfKkh8y02gai7syThwynhTz1PE6ogOpTiggwbQfF3xiViyXewZyV3h2Eas9K/b4jBffmQFUfdPigdWUtbD7TeG/LPTy3hFDC8QG/AvDyVtoudKM6hQoTLh/dW66vbKPioXymb6qYcZ3j0uvDJPkl+NIeszfwJ1QIrrV0Qbq7IYTrWi4fVc0GTMm0f5RS0jbLa397N9fwZw5QjGaB6uwfkN6fRa9iWwiH29+bFOlGRpYzbgJRMKdQnHbhxL+M8F7HtWkaO/LDtNL6WUedLVVn83W4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoXm1ieBs8M1/Rl6O4oOmwrP2xz3pTLM1kEDmBbQbv0=;
 b=yPd7KC1MVr2ROXGzxqFc1/MzXNZXC7oM/SO8lRhU7t2dR4gF9mr1r69VJs2x1ZaDrf8WUL9/KvZK7pStB2yub5FJQFum1hc94Aefv3WubyeW6CukrkKonv0LNfavvd5n04LHUCs+ObA+oALj1M/xCS3JxWmnLk5WRsT7DdbtVUo=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB4039.namprd12.prod.outlook.com (20.180.6.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 17:56:06 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 17:56:05 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix dtm unloading
Thread-Topic: [PATCH] drm/amd/display: fix dtm unloading
Thread-Index: AQHV4CVB3qCSkAYcqUmWOOrcAlm9p6gUtnDO
Date: Mon, 10 Feb 2020 17:56:05 +0000
Message-ID: <8E5553CA-1AB0-4125-BAB7-DF810E6B9446@amd.com>
References: <20200210151733.6861-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200210151733.6861-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [116.227.24.105]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fce98da-e325-4632-9fff-08d7ae52803e
x-ms-traffictypediagnostic: CH2PR12MB4039:|CH2PR12MB4039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4039EB5E3C3B91ADBB22326AFE190@CH2PR12MB4039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(81166006)(8676002)(478600001)(186003)(81156014)(33656002)(6862004)(45080400002)(6486002)(66446008)(66556008)(26005)(316002)(8936002)(36756003)(66946007)(64756008)(66476007)(37006003)(6512007)(6636002)(2616005)(54906003)(76116006)(91956017)(86362001)(5660300002)(4326008)(53546011)(6506007)(2906002)(966005)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4039;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/z4+J0f4qiOs9m3pS913cewLeqGfw6PXkWur4Fx6YpNP07dET9l/OL5YYR/gF241VKwkNcMPvLuAOvk+o/s/6uPqxnAm4yoJZVXhOWT9wJZyvyGPGlATPjY5t3jm3NEku9vJ6ownoFFZBmAr0AyuxEl281joH+yq98JsshOu569i6lOeGbvja2jLqV36UzgUNFOvv/le3EvbPi2efbntb6ZGOeMW1hf1OTwr9p5pVIsUXHA507zjNmPhQGE4dYYmxtkEcOPi7UTGe3iHGvyFYHLxIBVWWa9+TE06Dh4ubJbjypRbnnwM2uYJ52NkBIW3GN+Vs5yjMO6EkHG9fWHZvFSgm4+O1uWa6jcCGq4wE0QtY/3HW308siTss1pnTt1PZwsjYnhnqAoeD4/2sxzDnHtQ0QUHEXen/IKMCteaCR9fGBhnnBhmRJiA/6YaPAH8rBBDEJAgg7btHTlmQfbktpyzJ1wEzCCGU8U1cOarbAAojJ+P/wUdFEriGIf6oWhW6ZVpVVItYAm0EezISxbug==
x-ms-exchange-antispam-messagedata: qxnMGM8AQqIcp/WhsW7pwSYlIzm+kkm0pqzG7L+dCt4yVUtnmlAoye3tSklB+0bHzrp+E7LQJHoMxKwR1NZslzlSoREYIpfv/tD7ByvY03nnuuW1LMu/YJC0AK+zp1OHHH94TeMFjZSGtAeCsYQKHg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fce98da-e325-4632-9fff-08d7ae52803e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 17:56:05.7264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fea7S49jXBSvfhgsvm117vajIeTIfyrSVf/eI8SgncxhiCX0Tk+QD2Z6L+5BW57R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCj4gT24gRmViIDEw
LCAyMDIwLCBhdCAyMzoxNywgQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0Lkxha2hhQGFt
ZC5jb20+IHdyb3RlOg0KPiANCj4g77u/dGhlcmUgd2FzIGEgdHlwZSBpbiB0aGUgdGVybWluYXRl
IGNvbW1hbmQuDQo+IA0KPiBXZSBzaG91bGQgYmUgY2FsbGluZyBwc3BfZHRtX3VubG9hZCgpIGlu
c3RlYWQgb2YgcHNwX2hkY3BfdW5sb2FkKCkNCj4gDQo+IEZpeGVzOiAxNDNmMjMwNTMzMzMgKCJk
cm0vYW1kZ3B1OiBwc3AgRFRNIGluaXQiDQo+IFNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExh
a2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBpbmRleCA5MzlhMTE0NjA1
YzAuLmExNmM4MTAxZTI1MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYw0KPiBAQCAtMTAxMyw2ICsxMDEzLDMwIEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9pbml0
aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0KPiAgICByZXR1cm4gMDsNCj4gfQ0KPiAN
Cj4gK3N0YXRpYyBpbnQgcHNwX2R0bV91bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQo+
ICt7DQo+ICsgICAgaW50IHJldDsNCj4gKyAgICBzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21k
Ow0KPiArDQo+ICsgICAgLyoNCj4gKyAgICAgKiBUT0RPOiBieXBhc3MgdGhlIHVubG9hZGluZyBp
biBzcmlvdiBmb3Igbm93DQo+ICsgICAgICovDQo+ICsgICAgaWYgKGFtZGdwdV9zcmlvdl92Zihw
c3AtPmFkZXYpKQ0KPiArICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiArICAgIGNtZCA9IGt6YWxs
b2Moc2l6ZW9mKHN0cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwKSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAg
aWYgKCFjbWQpDQo+ICsgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsgICAgcHNwX3By
ZXBfdGFfdW5sb2FkX2NtZF9idWYoY21kLCBwc3AtPmR0bV9jb250ZXh0LnNlc3Npb25faWQpOw0K
PiArDQo+ICsgICAgcmV0ID0gcHNwX2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLCBwc3At
PmZlbmNlX2J1Zl9tY19hZGRyKTsNCj4gKw0KPiArICAgIGtmcmVlKGNtZCk7DQo+ICsNCj4gKyAg
ICByZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+IGludCBwc3BfZHRtX2ludm9rZShzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKQ0KPiB7DQo+ICAgIC8qDQo+IEBAIC0x
MDM3LDcgKzEwNjEsNyBAQCBzdGF0aWMgaW50IHBzcF9kdG1fdGVybWluYXRlKHN0cnVjdCBwc3Bf
Y29udGV4dCAqcHNwKQ0KPiAgICBpZiAoIXBzcC0+ZHRtX2NvbnRleHQuZHRtX2luaXRpYWxpemVk
KQ0KPiAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiAtICAgIHJldCA9IHBzcF9oZGNwX3VubG9hZChw
c3ApOw0KPiArICAgIHJldCA9IHBzcF9kdG1fdW5sb2FkKHBzcCk7DQo+ICAgIGlmIChyZXQpDQo+
ICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gLS0gDQo+IDIuMTcuMQ0KPiANCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5n
IGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0w
MiU3QzAxJTdDRmVpZmVpLlh1JTQwYW1kLmNvbSU3QzA4NGRjNWMxY2U3NzRiNThiOWI4MDhkN2Fl
M2M2MDE5JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE2
OTQ0NjY4MzgxODc3MCZhbXA7c2RhdGE9N3VIczAlMkJaYTBQcllYZEVtaHJTZldlWGxoMDczTjJQ
WU83Tjg3U0g5dk80JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
