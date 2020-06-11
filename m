Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658FBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 04:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7822072E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 04:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GFJW4/4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7822072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4F36E892;
	Thu, 11 Jun 2020 04:09:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143426E892
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 04:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwr2A9vSu0BKJ7JcCJC76ZgTLkkSeg+XMrKaPV12LOIm8DGeG9kfcPHRP7WA5HEQsxmUpu1iQqPDSv2GoUZIuLdzX2jY6O8tnJ9MfgpdWi3WlDOvTjzi2l+Gx9lhM8j32QFDsytxEhNFzZIRz5H8MSamXbSrwC8Mz+p55BP7AUF45H3iNU64dWGQH8c3xnsA4N0JiCStJBv3cfhf5zka1ghlj68EQdd/kJL4XTS/zoKHdoGIeCkeWQhvNLVjPslfgZzrciAQqPwaNWkP6BrKySX5TUE4wUPtkcyEerCb9KwcEqRAYZ9GXlZdJwalAJoRUYMA2XP4SxOsYGFg085fuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNeNxwHkej+SkljsLkmZOGP8jHLvcWzb0Y8gF0dhA7Y=;
 b=isQVIPFX10x36EwxdsqW1rQ6Ac2UUZNov/8nsNUIR27UkJAcBsNhv0TK7MHRfUcOlDWFDotbBvT29caozF7g2yNoT2CYS/1AWjrQ+TwbIasqJb3Y/FyTCO8qlE+6U9JnvYg8Ev7hAjG+dbQFQNcAkoUk1QKUh4ivUfUQayGEdBqJNktfpCXQ9Glnm4UcGukiY18XGuJ02i6jKik8/ZCWG+lcwNNQiPhYJrP47RWQsf7+4iAUDK0pSkWHN5xp6KQ1kOrsiiZtqqOR2VPvLZU+N0xdxEaSaXvVbsw1dKGGby7COz6p4vw3fmzDiCRlf5338+d0uTfPKu3XMx9Cs3XM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNeNxwHkej+SkljsLkmZOGP8jHLvcWzb0Y8gF0dhA7Y=;
 b=GFJW4/4f4nU9qD6qbNdpRwVVqPHRcXAy82TxhVrf1lNYkzCtgIEYgfygRVyfuoiR06N2lhj3y4D+RQveB+1/ENXx8/IwkeAjkf6Y27wxNy+x2MnbbH7V11UxEf1lxDUFy5nEho5WIOWrv3ZlkeblGokdlL2GKwVAR2bCMn59OAw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Thu, 11 Jun 2020 04:09:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 04:09:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Reconfigure ULV for gfx9 server SKUs
Thread-Topic: [PATCH] drm/amdgpu: Reconfigure ULV for gfx9 server SKUs
Thread-Index: AQHWP34Uk9MoCuX+F0+/KyUXRCJDAajSzUpn
Date: Thu, 11 Jun 2020 04:09:44 +0000
Message-ID: <04882ED1-7E10-40E9-BAF0-A55340F49D8D@amd.com>
References: <20200610232117.182296-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20200610232117.182296-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.104.212.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eadca612-5dd7-46e0-afbc-08d80dbd4613
x-ms-traffictypediagnostic: DM6PR12MB2826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2826D30B1F9327BAA2129E02FC800@DM6PR12MB2826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCyClCGOyyPnGOHWm1qLiv6+ARp7GFVY2atbxVWspeVLyrg2ErVsO1d2OADb3z59O5KTcW8WVjXAVHwFHDkFN3sKt6CKYBiKqMEUariUdLsuU5nLHcWq9CcyRuzww/i/T5Siy1xMLAmvyRMuqDwiY4Y249w28LjTYMWCNGS3ff8pABBvj3PZcTDBeONBOthY1ponhHW2+wnHDQtl97W8J2+86hJQPgLKnhTEEOqnuD7hbEyF5te+2y6RZK6kY3+UB79AF74YgUV+4FKZyPgvdhUTTwWWQQUY0QMpkuNMt66NO+BbUww+9cHD7SGBjcfyTu19yc+LhHO7WW8ymtSHhfKQiyM3tM/7dceqE1WEBTM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(6862004)(4326008)(86362001)(6506007)(53546011)(6486002)(26005)(2906002)(2616005)(33656002)(186003)(8676002)(64756008)(91956017)(8936002)(66946007)(478600001)(71200400001)(45080400002)(36756003)(5660300002)(37006003)(66476007)(316002)(76116006)(6636002)(6512007)(66446008)(66556008)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tpFOO1cDJrgzS3td0aMVbp7jZjDoeK8bNFHRICTZxs8RXrjoXcWkdZzG7pme1D8DMsAMoTPFJvZNZOg0h7Lvo5npxgN5vDnwy1PoDmjAJDojk8Ksgv4UhLerQsCD6KL8+uhnTAFyrdh76vQlJzZaHk8r1yViKCENfI83vIdRdUqSEW/76GZ4L8Locuq0P6Xfjn1J+Y2Cj8vuHOj3pJ15v0n+5AJb3jBr91P+6awg658GFXkczybI4C/QNdJQ6C6I17EMCaDKO2pSKxQbiQeLDVEfTzV5MVbFuqrUhtzBRli83CuwCyIWz3AiVlYe+z4mqGQqbNCtBXtmnUff3OTwZEjPKJFuKvfZnZXH7Di8fakEGoT73pGMDzIYk8V+oUd+VC8CIDVyU1Ao9MT9IUZ9y4v4vKK7RIYevg54sinqhrHywDv0bg+u99TvWeLlvWcpMHToQh9qulbXHraA2388q0HJW34RcVWqgIdDjAyudAGYN/cVkd7PleFfChSrDDAa
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadca612-5dd7-46e0-afbc-08d80dbd4613
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 04:09:44.7186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQ3UBtkpYOY7hlZvZ3JK4fDoFtq64LYCcqI5p1MtFJRsOHC4m3wtQvdYkJezCfTBF/Eb6g08E+cxws4TUEn/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
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

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcgDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBPbiBKdW4gMTEsIDIw
MjAsIGF0IDA3OjIyLCBKb3NlcGggR3JlYXRob3VzZSA8Sm9zZXBoLkdyZWF0aG91c2VAYW1kLmNv
bT4gd3JvdGU6DQo+IA0KPiDvu79TRE1BIFVMViBjYW4gYmVuZWZpdCBsb3ctcG93ZXIgbW9kZXMs
IGJ1dCBjYW4gc29tZXRpbWVzIGNhdXNlDQo+IGxhdGVuY3kgaW5jcmVhc2VzIGluIHNtYWxsIFNE
TUEgdHJhbnNmZXJzLiBTZXJ2ZXIgU0tVcyBoYXZlIGENCj4gZGlmZmVyZW50IHRyYWRlLW9mZiBz
cGFjZSBpbiB0aGlzIGRvbWFpbiwgc28gdGhpcyBjb25maWd1cmVzDQo+IHRoZSBzZXJ2ZXIgU0tV
cycgVUxWIGh5c3RlcmVzaXMgdGltZXMgZGlmZmVyZW50bHkgdGhhbiBjb25zdW1lcg0KPiBTS1Vz
Jy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmVhdGhvdXNlIDxKb3NlcGguR3JlYXRo
b3VzZUBhbWQuY29tPg0KPiBDaGFuZ2UtSWQ6IElmYzMzYWE4NTc3MTRjNGMyMDliMTlhNWQ0NGUw
YTA1YzQ3OGRiMTk1DQo+IC0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0
XzAuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAz
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAu
Yw0KPiBpbmRleCAyZjFmNDdkZTk2MzQuLjU4MzgyNjQ2ZDk2MiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMNCj4gQEAgLTUwNSw2ICs1MDUsMzYgQEAgc3RhdGlj
IHZvaWQgc2RtYV92NF8wX2luaXRfZ29sZGVuX3JlZ2lzdGVycyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCj4gICAgfQ0KPiB9DQo+IA0KPiArc3RhdGljIHZvaWQgc2RtYV92NF8wX3NldHVw
X3VsdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gK3sNCj4gKyAgICBpbnQgaTsNCj4g
Kw0KPiArICAgIC8qDQo+ICsgICAgICogVGhlIG9ubHkgY2hpcHMgd2l0aCBTRE1BdjQgYW5kIFVM
ViBhcmUgVkcxMCBhbmQgVkcyMC4NCj4gKyAgICAgKiBTZXJ2ZXIgU0tVcyB0YWtlIGEgZGlmZmVy
ZW50IGh5c3RlcmVzaXMgc2V0dGluZyBmcm9tIG90aGVyIFNLVXMuDQo+ICsgICAgICovDQo+ICsg
ICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsNCj4gKyAgICBjYXNlIENISVBfVkVHQTEwOg0K
PiArICAgICAgICBpZiAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4Njg2MCkNCj4gKyAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgY2FzZSBDSElQX1ZFR0EyMDoN
Cj4gKyAgICAgICAgaWYgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDY2YTEpDQo+ICsgICAgICAg
ICAgICBicmVhazsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiArICAgIGRlZmF1bHQ6DQo+ICsgICAg
ICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+
c2RtYS5udW1faW5zdGFuY2VzOyBpKyspIHsNCj4gKyAgICAgICAgdWludDMyX3QgdGVtcDsNCj4g
Kw0KPiArICAgICAgICB0ZW1wID0gUlJFRzMyX1NETUEoaSwgbW1TRE1BMF9VTFZfQ05UTCk7DQo+
ICsgICAgICAgIHRlbXAgPSBSRUdfU0VUX0ZJRUxEKHRlbXAsIFNETUEwX1VMVl9DTlRMLCBIWVNU
RVJFU0lTLCAweDApOw0KPiArICAgICAgICBXUkVHMzJfU0RNQShpLCBtbVNETUEwX1VMVl9DTlRM
LCB0ZW1wKTsNCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4gc3RhdGljIGludCBzZG1hX3Y0XzBfaW5p
dF9pbnN0X2N0eChzdHJ1Y3QgYW1kZ3B1X3NkbWFfaW5zdGFuY2UgKnNkbWFfaW5zdCkNCj4gew0K
PiAgICBpbnQgZXJyID0gMDsNCj4gQEAgLTE4MTMsNiArMTg0Myw4IEBAIHN0YXRpYyBpbnQgc2Rt
YV92NF8wX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpDQo+ICAgICAgICAuY2IgPSBzZG1hX3Y0XzBf
cHJvY2Vzc19yYXNfZGF0YV9jYiwNCj4gICAgfTsNCj4gDQo+ICsgICAgc2RtYV92NF8wX3NldHVw
X3VsdihhZGV2KTsNCj4gKw0KPiAgICBpZiAoYWRldi0+c2RtYS5mdW5jcyAmJiBhZGV2LT5zZG1h
LmZ1bmNzLT5yZXNldF9yYXNfZXJyb3JfY291bnQpDQo+ICAgICAgICBhZGV2LT5zZG1hLmZ1bmNz
LT5yZXNldF9yYXNfZXJyb3JfY291bnQoYWRldik7DQo+IA0KPiAtLSANCj4gMi4yMC4xDQo+IA0K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0NoYXdraW5nLnpoYW5nJTQwYW1kLmNvbSU3Q2I2MzhmNGUxNjY2
YzRhYWNhMTlkMDhkODBkOTUwOGQ4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzI3NDI4MTc4NzY1ODQyMiZhbXA7c2RhdGE9UVpzbGVrJTJCSnZsaWZHbkdX
cnJKdSUyQndCamo5M2V3ME52Q2dVVW05VFBORWclM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
