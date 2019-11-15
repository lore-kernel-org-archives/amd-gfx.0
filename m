Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC841C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B3A20674
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B3A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DD86E0A5;
	Fri, 15 Nov 2019 16:46:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5B66E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1xSYLv+QKFYA6ogYAww1LmiraaNrLTh7hEegMJlqOgxZr64xDH21I+xMwgnjL7Zz1pRAjrKcLCm/hri1XaT6N7YELBzGT68pmCEpVUQWb6Szy/ricX9OVPAtShPzPOl0oRap7Upv8MCdHPhSH5XmNN+YjF6jpOlNXNGFPMgr7bPAoz4/ZfroOYVt9UJTwhleHbVy8Da8APlVPziHPxj2DogQ9VDWfkl6ob5SV/rsbACzYM9bO/lMCf9o4RaZu9nxGrK3pRMVOn+I+f5Epy7nNqlSnsxl2XmlttyP4TLkg0fOEkdId8zEwffD0MXK8PdmAhvSeg4WBkmokbjFadmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNXJKz6knsvMhkyqI0+dc8ALmPq+GdgWecyz1IXX4eQ=;
 b=YAAW6um3dvwl3qEIaXYYPBFZPNNs/aJOOrwfy7ZEg0M+Om/062aaxi4w1ZwUnHpOybsQaF2JJCR5OvFkwFMb8QwffwUp0veEuBCosd/fsK//nqOys+cmluef+E1X+agPHREokwxitT6A/tekc5uE+qssXyfjQqRCiNz0FvuXGKPCt8kd0NRRgSPDag9dOKCPHCjctIyEoGkPrj0vKy1IEZFVAPEzbwZhjP9tIz3SvUIneLv2EDx2t9KB+RK4yGrq2TyFRL4W1fmn8Eupo6PRuU9WzQINDuUj+tGqMruDIG5ziG7SYPouewsj0cgRxht3I6XsS0j/24WjCv7CV0UMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3102.namprd12.prod.outlook.com (20.178.241.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 16:46:47 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.023; Fri, 15 Nov 2019
 16:46:47 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable gfxoff when using register read
 interface
Thread-Index: AQHVmwq/in9OCtzEpUCFWEfsKe4IV6eMcnQS
Date: Fri, 15 Nov 2019 16:46:47 +0000
Message-ID: <93CD6C6F-21F7-4BCA-AC65-FDC37AF896E3@amd.com>
References: <20191114164148.2304223-1-alexander.deucher@amd.com>,
 <20191114164148.2304223-2-alexander.deucher@amd.com>
In-Reply-To: <20191114164148.2304223-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.93.227.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d070afb6-7d7f-4e42-8e48-08d769eb6790
x-ms-traffictypediagnostic: MN2PR12MB3102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31021E9DFFFA233B8767D56789700@MN2PR12MB3102.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:169;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(6506007)(53546011)(66476007)(64756008)(229853002)(478600001)(8676002)(1411001)(966005)(99286004)(14454004)(186003)(7736002)(25786009)(11346002)(446003)(305945005)(4326008)(86362001)(6916009)(91956017)(76116006)(476003)(81166006)(2906002)(81156014)(316002)(486006)(54906003)(26005)(102836004)(6486002)(6246003)(36756003)(2616005)(76176011)(8936002)(6116002)(6306002)(6512007)(71200400001)(71190400001)(3846002)(5660300002)(256004)(14444005)(66446008)(6436002)(66556008)(33656002)(66946007)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3102;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIi3L4F9dGb7+Lh8Um3SHlOvpS46alAD/cDQli/b+1HoX6wBRM9nrM2BVxGSVHAxmqK26oR3TtSr17hrXZSp8GBmeg+UNImMeaV7w7Uj9bmr0Ecvg6kZgMUqP27j73FShaU6hDVSqVUgVOGyHxFQ5rVi6IvGlGxVMJ/RZQJZSVBmg0DkfZmmjPaF4oJ+XN3UtVlFPvLzmvtlFfujs263Cmjfy4+CQHJbVaaOZ5rghVHJpWnpCUL9iTyBLofCxvEXnCuemANOE3Jem4wPABfshlwFExyZGV4d6izLVwaGryYpKX6RCBzIcHZmq0QKr2ejf/qSU94X43kuAdzHfa9NKjsHTsIUxV2XM78lJvvLcgCev86bofKP5oB9AgVoJ2/DiyQtqlfkvU/oRyW7lg4OeVzkhjj76W0dXmybbzHW0gk/Q3xMUSn4IEYQTayvI+CD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d070afb6-7d7f-4e42-8e48-08d769eb6790
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 16:46:47.0982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FfC55U1SEEMFzfn3nbeBp6jup9nnbl9YNOUGYcMFJDLu80U3fyJtfvDpkf/Wh2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNXJKz6knsvMhkyqI0+dc8ALmPq+GdgWecyz1IXX4eQ=;
 b=gNrXxlyOpTIfKrAaLxtDAmOIOAqPWfVbi+q2FBbAw+ruwaBM0ZhHfA6bVUHcnyUyp4CMivlweHy2LJpyDEBoLo4FakCoojKOexw9iWrKcZwMYy4ksutlp+zmRbumMPo1ZtJCHTSIkLjp2XU+oXsmu06vQ3F2mwONkP5vRjHHLUQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115164647.K9xQmlhAp3ST6t7DOzPyVmoT-ZKijXzPlOq_WjInbJE@z>

SGkgQWxleCwKCklNSE8sIGRyaXZlciBzZW5kaW5nIERpc2FsbG93X0dmeG9mZiBtZXNzYWdlIHRv
IFNNVSBkb2Vzbid0IG1lYW4gZ2Z4IGJsb2NrIHdpbGwgYmUgaW1tZWRpYXRlbHkgcG93ZXJlZCB1
cCwgc28gSSdtIG5vdCBzdXJlIE1NSU8gcmVnaXN0ZXIgYWNjZXNzIHdpbGwgYmUgc3VjY2Vzc2Z1
bCB3aXRoaW4gdGhpcyB0aW1lIHdpbmRvdyhtYXliZSBHUkJNIGFjY2VzcyB3aWxsIGJlIHBlbmRp
bmcgdW50aWwgZ2Z4IGJsb2NrIGlzIHBvd2VyZWQgdXA/KQoKSWYgeW91IGFyZSBub3QgaW4gYSBo
dXJyeSB0byBjb21taXQgdGhpcyBmaXgsIEkgY2FuIHZlcmlmeSBvbiBteSBOYXZpIGJvYXJkcyBu
ZXh0IE1vbmRheS4KCkJSLApYaWFvamllCgo+IE9uIE5vdiAxNSwgMjAxOSwgYXQgMTI6NDQgQU0s
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiAKPiBXaGVuIGdm
eG9mZiBpcyBlbmFibGVkLCBhY2Nlc3NpbmcgZ2Z4IHJlZ2lzdGVycyB2aWEgTU1JTwo+IGNhbiBs
ZWFkIHRvIGEgaGFuZy4KPiAKPiBCdWc6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MjA1NDk3Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9rbXMuYyB8IDYgKysrKystCj4gMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfa21zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMK
PiBpbmRleCA2ZGRlYTc2MDdhZDAuLjVmM2IzYTcwNWIyOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiBAQCAtNjU5LDE1ICs2NTksMTkgQEAgc3RhdGljIGlu
dCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBz
dHJ1Y3QgZHJtX2ZpbGUKPiAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ICAgICAgICBhbGxv
Y19zaXplID0gaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50ICogc2l6ZW9mKCpyZWdzKTsKPiAKPiAt
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW5mby0+cmVhZF9tbXJfcmVnLmNvdW50OyBpKyspCj4g
KyAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4gKyAgICAgICAgZm9y
IChpID0gMDsgaSA8IGluZm8tPnJlYWRfbW1yX3JlZy5jb3VudDsgaSsrKSB7Cj4gICAgICAgICAg
ICBpZiAoYW1kZ3B1X2FzaWNfcmVhZF9yZWdpc3RlcihhZGV2LCBzZV9udW0sIHNoX251bSwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8tPnJlYWRfbW1yX3JlZy5kd29yZF9vZmZz
ZXQgKyBpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJlZ3NbaV0pKSB7Cj4gICAg
ICAgICAgICAgICAgRFJNX0RFQlVHX0tNUygidW5hbGxvd2VkIG9mZnNldCAlI3hcbiIsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIGluZm8tPnJlYWRfbW1yX3JlZy5kd29yZF9vZmZzZXQgKyBp
KTsKPiAgICAgICAgICAgICAgICBrZnJlZShyZWdzKTsKPiArICAgICAgICAgICAgICAgIGFtZGdw
dV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7Cj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFV
TFQ7Cj4gICAgICAgICAgICB9Cj4gKyAgICAgICAgfQo+ICsgICAgICAgIGFtZGdwdV9nZnhfb2Zm
X2N0cmwoYWRldiwgdHJ1ZSk7Cj4gICAgICAgIG4gPSBjb3B5X3RvX3VzZXIob3V0LCByZWdzLCBt
aW4oc2l6ZSwgYWxsb2Nfc2l6ZSkpOwo+ICAgICAgICBrZnJlZShyZWdzKTsKPiAgICAgICAgcmV0
dXJuIG4gPyAtRUZBVUxUIDogMDsKPiAtLSAKPiAyLjIzLjAKPiAKPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
