Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5543C52D5D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9B220801
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SKVoASJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9B220801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358D16E8D8;
	Thu, 27 Feb 2020 14:19:24 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D796E8D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfPjVTk2y/uVUKa/lH9baUbcc2CpvLH89hjeHdb2XCMMY89jjW3ANliQ+tCv6I+Suj+sekEqUubG5J2IfFzl2lapX4oepmnQ8fjtjpgY8Arm81XGzTMqiKA2g7jyNp4TfeXUeYVVO9ylCW+S/MZNVLipK0ndw/YOuHx3HzBl7Wk9BA0TIIjYRaBF6OyLR6fVJPZ5cyIFChDCqm9AUyhR+TNjLIbipJ+ltk5xpn6ckHWfabuQmQ+hUuFaF60i4kdRzS0vdML3QgqfcmwJE3ZcoZz998yqywVUE3yHSRHDVJZzzpS44+1lz/5Gb0HRUe+EzeMTqOTD6aZYQruoH5Vk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D3qi+zDDIKhcAoVOw7kUnq8tAlvs0mY8Ys0LqE8I+8=;
 b=LIVIvhHMBFdD2KteM3/BD35JhMZuCwt9dVqIWRGxfPhA7rgDX479QslsJ1fBQiUzhhzUXCphvfiE5I0pCPNWduYHiDc2mNSBYYiEoe03Jm2bnzbuTNUdVTMsU8KFWSB+PVKm/aGWnZJkTvXo9BzQos107/BnJDp2GDQ5hAQ5nrDdxPq43sGTFUPxlcesYpf9RTmf8ZS8kbkIZCvrYjC1yTcg3mh8GTY7zc1LdQr9zoHWPMQ6C8DCtDmPfqkICem1U1KOuHplkpEGSuXwJliY22ouhRCOr1Fs5RbeOe+HX6lqWjrEfn9uKidZg03HN2NiEwWBh4UGH9yxwoiidrvArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6D3qi+zDDIKhcAoVOw7kUnq8tAlvs0mY8Ys0LqE8I+8=;
 b=SKVoASJTRXAMz7FDAW1ZNLKjgsvGAm5IJSuBn0Y5ap55ZV12BwjnSJR4OofhHLKbzkaLTmUdm8qNj6e1/yPFRzrPgUAg2aeUuwnby9UV508AY9IkzvaJGd4U42cpHUU4dEc4297CowUWq79H8Wa/OPX+GEsTJqkd3bfjFRQpZ8c=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB2880.namprd12.prod.outlook.com (2603:10b6:208:106::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Thu, 27 Feb
 2020 14:19:19 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::7cc0:785c:ea66:ef94%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:19:19 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: miss to remove pp_sclk file
Thread-Topic: [PATCH] drm/amdgpu: miss to remove pp_sclk file
Thread-Index: AQHV7XfKlgPY3GtFokys5x/SwvavQKgvFmqAgAAAP4A=
Date: Thu, 27 Feb 2020 14:19:19 +0000
Message-ID: <MN2PR12MB30396020E4E32647022C9EF3E5EB0@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200227141118.3271-1-yttao@amd.com>
 <a0cce90e-3b77-3983-fa11-848bf1df748d@amd.com>
In-Reply-To: <a0cce90e-3b77-3983-fa11-848bf1df748d@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e55d9b9c-91bd-448f-7597-08d7bb9008cf
x-ms-traffictypediagnostic: MN2PR12MB2880:|MN2PR12MB2880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2880CB12D5AE2603700281A7E5EB0@MN2PR12MB2880.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(26005)(5660300002)(9686003)(71200400001)(33656002)(8936002)(478600001)(110136005)(81166006)(4326008)(8676002)(55016002)(6506007)(81156014)(6636002)(53546011)(52536014)(86362001)(66946007)(316002)(64756008)(66476007)(66446008)(2906002)(76116006)(186003)(7696005)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2880;
 H:MN2PR12MB3039.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39gvZSM+XligMB+2y6/ae13Qq7rQfICLFGfzwwTzQPjMWF8ORJDA7DiHEuc6Lle3+i+T1dfRrtdaVI+rj/VmWTIpgXx2xn0R/+4Q58t1VPPkazQ+6ftVw/5S+Zh+HdYcwc01NVtfRXmVVQvKKgVl7xo5YVywnwIHJGhcJpjRzBbMmWg0AAir6FFS/aUWZ424ZFqqBu3irM5ccj96ZlR1zIsI1LQulZKUY8q1NMFIPF0cC72pUHKEYnRcps0KNmsW9JAWDaSchYSNiqd0IL+cQ1TNk+1E8gpOB9e7qQznhjypE6DfRNLFfBLBs4ool8zLFDog6CgdgVgzbCRfYykgeWs2J41vKBIMVQFW4xGMGVPE8LEy5cIuw3RC1muOPJwDuCl6e2+khGOsNC7ApH8Hd3X3Nd54BStJuahkts39K3Kj9IzsVHRZ99H7UBGFKhCB
x-ms-exchange-antispam-messagedata: T9fybm+QIeHQJDfJwdLptnNShK42uanTnwVXTWfnMcuz0mYr7MJS7QCNAShxGeB5i/exlcU9tCkUnf/3jiQOds6i+tEe2P8sLPL4wIScjOTR3pVzqjVTgrrzQRtIyRXKgoLPrxAMKxOxIutHzD+K2Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d9b9c-91bd-448f-7597-08d7bb9008cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:19:19.1324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfCuEB98iZ4OHGjZXi+WfstEkCDW8Lg2I6An8QYafttdjcRHtqgpp/dhLuXwNJ5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2880
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgIENocmlzdGlhbg0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3DQoNCg0KSGkgIEFs
ZXgNCg0KDQpDYW4geW91IGhlbHAgdG8gcmV2aWV3IGl0PyBUaGFua3MgaW4gYWR2YW5jZS4NCg0K
DQpCZXN0IFJlZ2FyZHMNCllpbnRpYW4gVGFvDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gDQpTZW50
OiAyMDIw5bm0MuaciDI35pelIDIyOjE4DQpUbzogVGFvLCBZaW50aWFuIDxZaW50aWFuLlRhb0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBtaXNzIHRvIHJlbW92ZSBwcF9zY2xrIGZpbGUNCg0KQW0gMjcuMDIuMjAgdW0g
MTU6MTEgc2NocmllYiBZaW50aWFuIFRhbzoNCj4gTWlzcyB0byByZW1vdmUgcHBfc2NsayBmaWxl
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29tPg0KDQpMb29r
cyByZWFzb25hYmxlIHRvIG1lLCBidXQgQWxleCBjYW4gcHJvYmFibHkgYmV0dGVyIGp1ZGdlLg0K
DQpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jIHwgMSAr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQo+IGluZGV4IDlkZWZmOGNjOTcyMy4uYTQzZmMxYzhmZmQw
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYw0KPiBAQCAtMzQ3
MSw2ICszNDcxLDcgQEAgdm9pZCBhbWRncHVfcG1fc3lzZnNfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gICAJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRy
X3BwX2N1cl9zdGF0ZSk7DQo+ICAgCWRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYsICZkZXZf
YXR0cl9wcF9mb3JjZV9zdGF0ZSk7DQo+ICAgCWRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYs
ICZkZXZfYXR0cl9wcF90YWJsZSk7DQo+ICsJZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwg
JmRldl9hdHRyX3BwX3NjbGspOw0KPiAgIA0KPiAgIAlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+
ZGV2LCAmZGV2X2F0dHJfcHBfZHBtX3NjbGspOw0KPiAgIAlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRl
di0+ZGV2LCAmZGV2X2F0dHJfcHBfZHBtX21jbGspOw0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
