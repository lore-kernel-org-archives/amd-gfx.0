Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6ECC38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 03:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C410D206F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 03:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWhIVpQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C410D206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4555D6E064;
	Wed, 22 Apr 2020 03:17:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706436E064
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 03:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GctInHLL8SdvO9NAMiD94xXgmLRLDQ69FHA5RDraWI3MZKq55LeydeSV3PXwbFDaOlg0C0tXWQBTvWHxz7DgLGGDEKD4ZtgBy0cTw+iBkWT3L8iIoCwy4Y424UMsD4N8JL7xnpqrWikkGMqZUgSBZshbMA1ySpHQrKaTe5nqmHmstdaqlt5rbo3HqibIYzd5wxd/ObWi6IQqAaLPvJbq5+vnr62vPuKhvnerPxY1x249UcDVM9XmGT4SaqIMKvv05VlhH/rTNqNjgOTrAqPkfW2jzMrz52LXTK8M+nb4TUD2MpnqH4RreMIpcY5PYUbOd39Mb3IuOk7SoZOK1J5CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2l7EGa+xZI4RvavkeyxB+bOmF7RVragR9WaMCNKIfk=;
 b=SXP2T7liAI3txj69nsgZh/EGS4A3xNbx/t/qJa8p291DCC2mCjMUXSYhEKp3O3JfscJ97j6F81j+0vomBR32sDWk8vULb8STMusAHMIRHvI/q2cyJpO3icQFnBmP06NNar/awZwVXuAZ1Ktdlor2u7vV6fZvWGrQu6HZ8eb+OI0K8/6V5BLOd4JDwga/F4syzOzIdCzuSgVK5b0c1bqISKOOaMaMf2IfY4qpbN/geD+iC1CHJHPdas1oBPDmlV62CSHwku6S9GQ0o8u3gvRgwXrPs/qBpyZfKqZBpWJ1bKjRLcpyDzfVDnsHlAT2D0PbU/Hj7ZvxbP6bU3Kt6Sj5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2l7EGa+xZI4RvavkeyxB+bOmF7RVragR9WaMCNKIfk=;
 b=yWhIVpQkO4HBI2olOjR/6EqGt27yTBfQjWCbFJNRZv38y2scKdFxw0DkE7Feth5UE6IpLWLy+I4BgnRhPhG3o/srx40E8mQcclC0smCKm2j7yxNrHORYc0uVePQ8+15nKRDnDMElyJ49eovkS+KHj6BHA1FgGANNItga2DGuJUo=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 03:17:37 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 03:17:37 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
Thread-Topic: [PATCH] drm/amdgpu: change how we update mmRLC_SPM_MC_CNTL
Thread-Index: AQHWF+hRdJn/fw4A6kKtQ8NbXBTUfaiEeRbg
Date: Wed, 22 Apr 2020 03:17:36 +0000
Message-ID: <MN2PR12MB3039623545203A6A979D66CFE5D20@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200421142236.41131-1-christian.koenig@amd.com>
In-Reply-To: <20200421142236.41131-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56678bd4-f085-4f80-7317-08d7e66bb517
x-ms-traffictypediagnostic: MN2PR12MB4158:|MN2PR12MB4158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4158C82473D51F45608A3DE9E5D20@MN2PR12MB4158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(186003)(15650500001)(86362001)(2906002)(5660300002)(66476007)(66556008)(76116006)(66946007)(66446008)(71200400001)(64756008)(6506007)(8936002)(8676002)(33656002)(26005)(478600001)(7696005)(110136005)(316002)(55016002)(9686003)(53546011)(52536014)(66574012)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQ6N7hrKvSgG2sf1o1N3zuP2ZEmm9m+A0zkFqeaSk1UFcUD+FpX5FIwKCu5cwtXSkbFGU5FNOfcrncBpeZq0xkjSWtG7iKP5rdkAiNThMCdjPpIuAwDQgE/6spZu6kX/zLl1vTTU68tP3jSo9ru4H2Wi5EAogD4/ZyKgRFf/Cyc/cYG203Y8LRnU8BU5V0z/xChYrplAJMbx0fMF5SIb2MKH3vNyBORggU42rhMZXNM/aWHnC4EfPZBlp5acZcW/Px3CQEpQpDyGObjJAKoDukLjjIDfukmCGLPQQyHdffaUEA3D9QYiQNluV9c8xmXe8bCkaO5MlpkhYXyGhrke8ZWqY9XVkZWMeksA0vt2ML9lAcJftUe7cmB6EgewgBaDUcTxteQYfYGMLi8XMKqTCBZ2sweeIs3Y5pc6yDU82IT8sDtrDgwlC/4fPsLXm1NY
x-ms-exchange-antispam-messagedata: /Tkj64PD5DKdRbA3/ZSNeMO5CfpvuWdRv1B17kJ7tYN2k0P8aTlvj2H90EgUL6YHd6dGpzJhxyQiFKxJUcdsX57xBRy1IWbugm4CaMiVYBVvf/qxbxr8O4yZr5fJ14V4fCm7fT7RpW7pLzkCfLR22g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56678bd4-f085-4f80-7317-08d7e66bb517
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 03:17:36.8567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MK6M9b6/HHXWlhlhLWgYlyWzZdxmDvMg9ChkDD4AGFwxXZOKnhZJif0s4xinlKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IFlpbnRpYW4gVGFvIDx5aW50aWFuLnRhb0BhbWQuY29tPg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDogMjAyMOW5tDTmnIgyMeaXpSAyMjoyMw0KVG86IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IEhlLCBKYWNvYiA8SmFjb2IuSGVAYW1kLmNvbT47
IFRhbywgWWludGlhbiA8WWludGlhbi5UYW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGNoYW5nZSBob3cgd2UgdXBk
YXRlIG1tUkxDX1NQTV9NQ19DTlRMDQoNCkluIHBwX29uZV92ZiBtb2RlIGF2b2lkIHRoZSBleHRy
YSBvdmVyaGVhZCBhbmQgcmVhZC93cml0ZSB0aGUgcmVnaXN0ZXJzIHdpdGhvdXQgdGhlIEtJUS4N
Cg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxMyAr
KysrKysrKysrLS0tICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICB8IDEw
ICsrKysrKysrLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgIHwgMTMg
KysrKysrKysrKy0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4IDBh
MDNlMmFkNWQ5NS4uNTYwZWMxYzI5OTc3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jDQpAQCAtNzAzMCwxNCArNzAzMCwyMSBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF91
cGRhdGVfZ2Z4X2Nsb2NrX2dhdGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiANCiBz
dGF0aWMgdm9pZCBnZnhfdjEwXzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCB1bnNpZ25lZCB2bWlkKSAgew0KLQl1MzIgZGF0YTsNCisJdTMyIHJlZywgZGF0YTsN
CiANCi0JZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwpOw0KKwly
ZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7DQorCWlmIChh
bWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQ0KKwkJZGF0YSA9IFJSRUczMl9OT19LSVEo
cmVnKTsNCisJZWxzZQ0KKwkJZGF0YSA9IFJSRUczMihyZWcpOw0KIA0KIAlkYXRhICY9IH5STENf
U1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLOw0KIAlkYXRhIHw9ICh2bWlkICYgUkxDX1NQ
TV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSykgPDwgUkxDX1NQTV9NQ19DTlRMX19STENfU1BN
X1ZNSURfX1NISUZUOw0KIA0KLQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRM
LCBkYXRhKTsNCisJaWYgKGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikpDQorCQlXUkVH
MzJfU09DMTVfTk9fS0lRKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7DQorCWVsc2UN
CisJCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOw0KIH0NCiAN
CiBzdGF0aWMgYm9vbCBnZnhfdjEwXzBfY2hlY2tfcmxjZ19yYW5nZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQppbmRleCBmYzZj
MmYyYmM3NmMuLmE5YmNjMDBmNDM0OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmMNCkBAIC01NjE1LDEyICs1NjE1LDE4IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3VwZGF0
ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkgIHsN
CiAJdTMyIGRhdGE7DQogDQotCWRhdGEgPSBSUkVHMzIobW1STENfU1BNX1ZNSUQpOw0KKwlpZiAo
YW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSkNCisJCWRhdGEgPSBSUkVHMzJfTk9fS0lR
KG1tUkxDX1NQTV9WTUlEKTsNCisJZWxzZQ0KKwkJZGF0YSA9IFJSRUczMihtbVJMQ19TUE1fVk1J
RCk7DQogDQogCWRhdGEgJj0gflJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01BU0s7DQogCWRh
dGEgfD0gKHZtaWQgJiBSTENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBSTENfU1BN
X1ZNSURfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQogDQotCVdSRUczMihtbVJMQ19TUE1fVk1JRCwg
ZGF0YSk7DQorCWlmIChhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQ0KKwkJV1JFRzMy
X05PX0tJUShtbVJMQ19TUE1fVk1JRCwgZGF0YSk7DQorCWVsc2UNCisJCVdSRUczMihtbVJMQ19T
UE1fVk1JRCwgZGF0YSk7DQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3JsY19m
dW5jcyBpY2VsYW5kX3JsY19mdW5jcyA9IHsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jDQppbmRleCA1NGVkZWQ5YTZhYzUuLmM3ZGUxMDg2OWM4MSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMNCkBAIC00OTUwLDE0ICs0OTUwLDIxIEBAIHN0YXRpYyBpbnQg
Z2Z4X3Y5XzBfdXBkYXRlX2dmeF9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQogDQogc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCB2bWlkKSAgew0KLQl1MzIgZGF0YTsNCisJdTMyIHJl
ZywgZGF0YTsNCiANCi0JZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NO
VEwpOw0KKwlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCk7
DQorCWlmIChhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQ0KKwkJZGF0YSA9IFJSRUcz
Ml9OT19LSVEocmVnKTsNCisJZWxzZQ0KKwkJZGF0YSA9IFJSRUczMihyZWcpOw0KIA0KIAlkYXRh
ICY9IH5STENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLOw0KIAlkYXRhIHw9ICh2bWlk
ICYgUkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSykgPDwgUkxDX1NQTV9NQ19DTlRM
X19STENfU1BNX1ZNSURfX1NISUZUOw0KIA0KLQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQ
TV9NQ19DTlRMLCBkYXRhKTsNCisJaWYgKGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikp
DQorCQlXUkVHMzJfU09DMTVfTk9fS0lRKEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7
DQorCWVsc2UNCisJCVdSRUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEp
Ow0KIH0NCiANCiBzdGF0aWMgYm9vbCBnZnhfdjlfMF9jaGVja19ybGNnX3JhbmdlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LA0KLS0NCjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
