Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DBFC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED7C20803
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 10:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED7C20803
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504956E0F5;
	Wed,  4 Dec 2019 10:48:00 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720052.outbound.protection.outlook.com [40.107.72.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705386E0F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 10:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5E1Kd62/bY7Dx+Eeu1AVYR5ig3Oot03r1M1yBgs5tvH8c4kbENF+uOYH9Bb3WU1sKGhw0XXcrvhLsg15HLqaQQS14oxBtoUgfiXXB5XKuW2SMqWfi6dAohi8Vyxxj7vdvjkczi5/mHO2v7F2Pp9GyrR69vtd2di1JTn771kUISY+uThzmAOyc1B1QHlOmMM0m5FUB3KGYlnd+b2xJ4CUXSTP3v23UYeIzAuqZqEUlgvOdV90zldoeUwD8++MXMgv2IoIR+u6AcYzXQkiHYvy9zqZqIyTDrcUgk/hvyODH9BxJw+eycyyK3cN0HDiDsSGQwFJmtAgVy2GozRtYlkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r998TXFnuC2pqxb1JVREV+2Xnsq2ZK9bBEIJ0KttW9c=;
 b=n2QMKBrYeU18Kr/gVtT990w8kyUPEIjtPK3+0+vEpAVAo6F3+t8NsE547266KsvixEbw6e2mRaeOwtyK7I4Gjy+hdmUSWDLpbs3okN6NNpCeGpAzuGOLkomi/4i6+cvGiCIMb9lvo9z5wDUYNK4sb08zB0QWkJe0amWWeZt18DR7CK27zNRrJ6BlmOvA7c5ELOzP1EcrNPvW4exidllfQYMFGetWnBNbBzxwfKMWLwqeCtPLbwyOtBJ4+r7bSUIu36fHjxqb6L/RltYmHp0rTtEAmK2WoKqfkypYbyfh30MFG2VT9VGcX81IoaEFv6sxG0AQyx8pLhKaykfPY55Prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3982.namprd12.prod.outlook.com (10.255.238.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 10:47:54 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 10:47:54 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Topic: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before
 issuing message
Thread-Index: AQHVqojJa1r3rCrDAkKyOg7DBmduB6epwhqAgAACo4CAAAbAgA==
Date: Wed, 4 Dec 2019 10:47:54 +0000
Message-ID: <67CE166A-CF82-4B52-A440-A37CB876261C@amd.com>
References: <20191204095339.25497-1-evan.quan@amd.com>
 <20191204095339.25497-2-evan.quan@amd.com>
 <CDE97C86-24CB-45A6-8913-97CD34C8127E@amd.com>
 <MN2PR12MB3344B8AB04DE38812A955E80E45D0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344B8AB04DE38812A955E80E45D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.88.26.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3844360-30b4-4874-5df8-08d778a76af5
x-ms-traffictypediagnostic: MN2PR12MB3982:|MN2PR12MB3982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3982E8F0CE4BD3D45531012B8E5D0@MN2PR12MB3982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(189003)(199004)(13464003)(45080400002)(7110500001)(2616005)(33656002)(229853002)(14454004)(5660300002)(99286004)(966005)(2420400007)(66446008)(6862004)(4326008)(6246003)(478600001)(86362001)(15650500001)(6486002)(6116002)(316002)(6436002)(3846002)(37006003)(186003)(53546011)(26005)(11346002)(6506007)(7736002)(102836004)(81166006)(8676002)(8936002)(2906002)(81156014)(76176011)(66556008)(54896002)(6306002)(6512007)(36756003)(71200400001)(71190400001)(6636002)(64756008)(76116006)(91956017)(25786009)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3982;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmQL4BLU/MUF8PLJWTzVfPS9pfVBhsbDkS26rq/yLurfwjU5A50XT50li/6jFIOMTV4seoPHcJ0DaJMfSoClrNmDeoLYYav6DgLthvylo+DwP3quUZeD5si14jp92Err93p0yNaU1nHbwUihqgvtnSzyxWXxEeT2eycr0ekrt/QpoxtfjQNY2G07I3LD4cNVN1hp95w9ywqfYyF3iaEYSmj/LMVr9eshdrTugKSACafqHJsnXAXe0A6ChLn6zzH767E/ZZp/DKWstWnuYMd3iTpj+Kvxb+0kUlLk3QbukYsZ0PB/ozp3xZWtTHyR4+NhM9Ik4XPp7gGVAeHDsD0zziHN8jafvgvzDxnuFBc1BLF6a8bqcmfk0vA731k8GueyWR4cvq9PGliPYfpqx5KzfQyp7Bx4EL3judObd7pLH/+ljVoqOc7c9SpQ/+5fw7iP1uH4XOzE+/ZZKYtpBAIwlsiAYtjn407AgdMazdV0tPYnOzHfKchJuRAMlq8/BdVIjFCxl4P1P5Qxyr9Jc7YBmyeE26Xrg0IVA+d0DukfgZo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3844360-30b4-4874-5df8-08d778a76af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 10:47:54.4362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebgcPgRH0HTPjbHzB/DwpOqd2LCaw0TAyd7sXaROovCMmj3ENfqoLPN94xHjiPsu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3982
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r998TXFnuC2pqxb1JVREV+2Xnsq2ZK9bBEIJ0KttW9c=;
 b=PK6VryN8YxiaGlKy7cDWhfMhk8DIMBV1qo/aPExbUIXajQXWeoRXzJc9Jq09n3iBVuZ4oruU9ow3vex8llCbbY7lIYIVVnOyDfx6GNdtLgUNckf2ZhwNPmkOK2OD6gQ//9DynUrzWXPRCVTDfyHRDofmVqg9086Hv+piDsOOOh8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0794466893=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0794466893==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_67CE166ACF824B52A440A37CB876261Camdcom_"

--_000_67CE166ACF824B52A440A37CB876261Camdcom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

R290IGl0LiBUaGFua3MuDQpSZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdA
YW1kLmNvbTxtYWlsdG86a2VubmV0aC5mZW5nQGFtZC5jb20+DQoNCtTaIDIwMTnE6jEy1MI0yNWj
rM/Czuc2OjIzo6xRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbTxtYWlsdG86RXZhbi5RdWFu
QGFtZC5jb20+PiDQtLXAo7oNCg0KVGhlIGFib3J0IG9wZXJhdGlvbiBpcyBhZGRlZCBpbiBzbXVf
djExXzBfc2VuZF9tc2dfd2l0aF9wYXJhbS4NCkFuZCBmb3Igc211X3YxMV8wX3dhaXRfZm9yX3Jl
c3BvbnNlLCB5ZXMsIGl0J3Mgb25seSBjb2RlIGZhY3RvcmluZy4NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPG1h
aWx0bzpLZW5uZXRoLkZlbmdAYW1kLmNvbT4+DQpTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDQs
IDIwMTkgNjoxNCBQTQ0KVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPG1haWx0bzpF
dmFuLlF1YW5AYW1kLmNvbT4+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFp
bHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCAy
LzJdIGRybS9hbWQvcG93ZXJwbGF5OiBwcmUtY2hlY2sgdGhlIFNNVSBzdGF0ZSBiZWZvcmUNCmlz
c3VpbmcgbWVzc2FnZQ0KDQpIaSBFdmFuLA0KVGhlIG9yaWdpbmFsIGRlc2lnbiBpcyBhbHNvIGFi
b3J0aW5nIHNlbmRpbmcgdGhlIG1lc3NhZ2UgYmVjYXVzZSBvZiBhIKGuYnJlYWuhrw0KdGhlcmUu
DQpZb3VyIHBhdGNoIGlzIGZvciBjb2RlIGZhY3RvcmluZz8NClRoYW5rcy4NCg0K1NogMjAxOcTq
MTLUwjTI1aOsz8LO5zU6NTOjrEV2YW4gUXVhbiA8RXZhbi5RdWFuQGFtZC5jb208bWFpbHRvOkV2
YW4uUXVhbkBhbWQuY29tPj4g0LQNCrXAo7oNCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0K
DQpBYm9ydCB0aGUgbWVzc2FnZSBpc3N1aW5nIGlmIHRoZSBTTVUgd2FzIG5vdCBpbiB0aGUgcmln
aHQgc3RhdGUuDQoNCkNoYW5nZS1JZDogSWRhOWY5MTFlMDUxZjZlNzhkZTRmNDc1OTU2Yzc4NjM3
ZTU2ZTZlYTMNClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb208bWFp
bHRvOmV2YW4ucXVhbkBhbWQuY29tPj4NCi0tLQ0KZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvc211X3YxMV8wLmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQpkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjEyXzAuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCjIgZmlsZXMgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KaW5kZXggMzI1ZWM0ODY0ZjkwLi5kODRjN2Y1
ZmIwMWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEx
XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCkBA
IC02OCwxNSArNjgsMTMgQEAgc3RhdGljIGludCBzbXVfdjExXzBfd2FpdF9mb3JfcmVzcG9uc2Uo
c3RydWN0DQpzbXVfY29udGV4dCAqc211KQ0KICAgICAgZm9yIChpID0gMDsgaSA8IHRpbWVvdXQ7
IGkrKykgew0KICAgICAgICAgICAgICBjdXJfdmFsdWUgPSBSUkVHMzJfU09DMTUoTVAxLCAwLCBt
bU1QMV9TTU5fQzJQTVNHXzkwKTsNCiAgICAgICAgICAgICAgaWYgKChjdXJfdmFsdWUgJiBNUDFf
QzJQTVNHXzkwX19DT05URU5UX01BU0spICE9IDApDQotICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBjdXJfdmFsdWUgPT0gMHgxID8g
MCA6IC1FSU87DQorDQogICAgICAgICAgICAgIHVkZWxheSgxKTsNCiAgICAgIH0NCg0KICAgICAg
LyogdGltZW91dCBtZWFucyB3cm9uZyBsb2dpYyAqLw0KLSAgICAgICBpZiAoaSA9PSB0aW1lb3V0
KQ0KLSAgICAgICAgICAgICAgIHJldHVybiAtRVRJTUU7DQotDQotICAgICAgIHJldHVybiBSUkVH
MzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKSA9PSAweDEgPyAwIDoNCi1FSU87
DQorICAgICAgIHJldHVybiAtRVRJTUU7DQp9DQoNCmludA0KQEAgLTkyLDkgKzkwLDExIEBAIHNt
dV92MTFfMF9zZW5kX21zZ193aXRoX3BhcmFtKHN0cnVjdA0Kc211X2NvbnRleHQgKnNtdSwNCiAg
ICAgICAgICAgICAgcmV0dXJuIGluZGV4Ow0KDQogICAgICByZXQgPSBzbXVfdjExXzBfd2FpdF9m
b3JfcmVzcG9uc2Uoc211KTsNCi0gICAgICAgaWYgKHJldCkNCi0gICAgICAgICAgICAgICBwcl9l
cnIoImZhaWxlZCBzZW5kIG1lc3NhZ2U6ICUxMHMgKCVkKSBcdHBhcmFtOiAweCUwOHgNCnJlc3Bv
bnNlICUjeFxuIiwNCi0gICAgICAgICAgICAgICAgICAgICAgc211X2dldF9tZXNzYWdlX25hbWUo
c211LCBtc2cpLCBpbmRleCwgcGFyYW0sIHJldCk7DQorICAgICAgIGlmIChyZXQpIHsNCisgICAg
ICAgICAgICAgICBwcl9lcnIoIk1zZyBpc3N1aW5nIHByZS1jaGVjayBmYWlsZWQgYW5kICINCisg
ICAgICAgICAgICAgICAgICAgICAgIlNNVSBtYXkgYmUgbm90IGluIHRoZSByaWdodCBzdGF0ZSFc
biIpOw0KKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgIH0NCg0KICAgICAgV1JF
RzMyX1NPQzE1KE1QMSwgMCwgbW1NUDFfU01OX0MyUE1TR185MCwgMCk7DQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYw0KYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYw0KaW5kZXggN2Y1ZjdlMTJhNDFlLi5hNjM4
MzI2YmExYjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
djEyXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMN
CkBAIC01NiwxNSArNTYsMTMgQEAgaW50IHNtdV92MTJfMF93YWl0X2Zvcl9yZXNwb25zZShzdHJ1
Y3QNCnNtdV9jb250ZXh0ICpzbXUpDQogICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190
aW1lb3V0OyBpKyspIHsNCiAgICAgICAgICAgICAgY3VyX3ZhbHVlID0gUlJFRzMyX1NPQzE1KE1Q
MSwgMCwgbW1NUDFfU01OX0MyUE1TR185MCk7DQogICAgICAgICAgICAgIGlmICgoY3VyX3ZhbHVl
ICYgTVAxX0MyUE1TR185MF9fQ09OVEVOVF9NQVNLKSAhPSAwKQ0KLSAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gY3VyX3ZhbHVlID09
IDB4MSA/IDAgOiAtRUlPOw0KKw0KICAgICAgICAgICAgICB1ZGVsYXkoMSk7DQogICAgICB9DQoN
CiAgICAgIC8qIHRpbWVvdXQgbWVhbnMgd3JvbmcgbG9naWMgKi8NCi0gICAgICAgaWYgKGkgPT0g
YWRldi0+dXNlY190aW1lb3V0KQ0KLSAgICAgICAgICAgICAgIHJldHVybiAtRVRJTUU7DQotDQot
ICAgICAgIHJldHVybiBSUkVHMzJfU09DMTUoTVAxLCAwLCBtbU1QMV9TTU5fQzJQTVNHXzkwKSA9
PSAweDEgPyAwIDoNCi1FSU87DQorICAgICAgIHJldHVybiAtRVRJTUU7DQp9DQoNCmludA0KQEAg
LTgwLDkgKzc4LDExIEBAIHNtdV92MTJfMF9zZW5kX21zZ193aXRoX3BhcmFtKHN0cnVjdA0Kc211
X2NvbnRleHQgKnNtdSwNCiAgICAgICAgICAgICAgcmV0dXJuIGluZGV4Ow0KDQogICAgICByZXQg
PSBzbXVfdjEyXzBfd2FpdF9mb3JfcmVzcG9uc2Uoc211KTsNCi0gICAgICAgaWYgKHJldCkNCi0g
ICAgICAgICAgICAgICBwcl9lcnIoIkZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMHgleCwgcmVzcG9u
c2UgMHgleCwgcGFyYW0NCjB4JXhcbiIsDQotICAgICAgICAgICAgICAgICAgICAgIGluZGV4LCBy
ZXQsIHBhcmFtKTsNCisgICAgICAgaWYgKHJldCkgew0KKyAgICAgICAgICAgICAgIHByX2Vycigi
TXNnIGlzc3VpbmcgcHJlLWNoZWNrIGZhaWxlZCBhbmQgIg0KKyAgICAgICAgICAgICAgICAgICAg
ICAiU01VIG1heSBiZSBub3QgaW4gdGhlIHJpZ2h0IHN0YXRlIVxuIik7DQorICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCisgICAgICAgfQ0KDQogICAgICBXUkVHMzJfU09DMTUoTVAxLCAwLCBt
bU1QMV9TTU5fQzJQTVNHXzkwLCAwKTsNCg0KLS0NCjIuMjQuMA0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCnMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGYW1kLQ0KZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NLZQ0KDQpubmV0aC5GZW5nJTQw
YW1kLmNvbTxodHRwOi8vNDBhbWQuY29tPiU3QzEzODNmMjY2MWI1ODRlMDRlZGY5MDhkNzc4OWZl
YWY1JTdDM2RkODk2MQ0KZmU0ODgNCg0KNGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzExMDUwMDU1MTAzNjQzOCZhbXA7c2RhdGE9UVENClJZOGRzaVQlDQoyQlBpbzVJJTJCJTJGM0Vy
cUxuWVFMeHQ2aGN5WEhlZFU3OW11VEklM0QmYW1wO3Jlc2VydmVkPTANCg0KDQo=

--_000_67CE166ACF824B52A440A37CB876261Camdcom_
Content-Type: text/html; charset="gb2312"
Content-ID: <D774D1D7A0C1B6448471CE70AB14F391@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
Got it. Thanks.
<div class=3D"">Reviewed-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.fen=
g@amd.com" class=3D"">kenneth.feng@amd.com</a></div>
<div class=3D""><br class=3D"">
<div style=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D"">=D4=DA 2019=C4=EA12=D4=C24=C8=D5=A3=AC=CF=C2=CE=E76:23=A3=
=ACQuan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" class=3D"">Evan.Quan=
@amd.com</a>&gt; =D0=B4=B5=C0=A3=BA</div>
<br class=3D"Apple-interchange-newline">
<div class=3D"">
<div class=3D"">The abort operation is added in smu_v11_0_send_msg_with_par=
am.<br class=3D"">
And for smu_v11_0_wait_for_response, yes, it's only code factoring.<br clas=
s=3D"">
<br class=3D"">
<blockquote type=3D"cite" class=3D"">-----Original Message-----<br class=3D=
"">
From: Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com" class=3D"">=
Kenneth.Feng@amd.com</a>&gt;<br class=3D"">
Sent: Wednesday, December 4, 2019 6:14 PM<br class=3D"">
To: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" class=3D"">Evan.Qua=
n@amd.com</a>&gt;<br class=3D"">
Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" class=3D"">amd-gfx@lis=
ts.freedesktop.org</a><br class=3D"">
Subject: Re: [PATCH 2/2] drm/amd/powerplay: pre-check the SMU state before<=
br class=3D"">
issuing message<br class=3D"">
<br class=3D"">
Hi Evan,<br class=3D"">
The original design is also aborting sending the message because of a =A1=
=AEbreak=A1=AF<br class=3D"">
there.<br class=3D"">
Your patch is for code factoring?<br class=3D"">
Thanks.<br class=3D"">
<br class=3D"">
<blockquote type=3D"cite" class=3D"">=D4=DA 2019=C4=EA12=D4=C24=C8=D5=A3=AC=
=CF=C2=CE=E75:53=A3=ACEvan Quan &lt;<a href=3D"mailto:Evan.Quan@amd.com" cl=
ass=3D"">Evan.Quan@amd.com</a>&gt; =D0=B4<br class=3D"">
</blockquote>
=B5=C0=A3=BA<br class=3D"">
<blockquote type=3D"cite" class=3D""><br class=3D"">
[CAUTION: External Email]<br class=3D"">
<br class=3D"">
Abort the message issuing if the SMU was not in the right state.<br class=
=3D"">
<br class=3D"">
Change-Id: Ida9f911e051f6e78de4f475956c78637e56e6ea3<br class=3D"">
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" class=3D"=
">evan.quan@amd.com</a>&gt;<br class=3D"">
---<br class=3D"">
drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;--------<br class=3D"">
drivers/gpu/drm/amd/powerplay/smu_v12_0.c | 16 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;--------<br class=3D"">
2 files changed, 16 insertions(&#43;), 16 deletions(-)<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br class=3D"">
b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br class=3D"">
index 325ec4864f90..d84c7f5fb01a 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br class=3D"">
@@ -68,15 &#43;68,13 @@ static int smu_v11_0_wait_for_response(struct<br cl=
ass=3D"">
</blockquote>
smu_context *smu)<br class=3D"">
<blockquote type=3D"cite" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fo=
r (i =3D 0; i &lt; timeout; i&#43;&#43;) {<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);<br class=
=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) !=3D 0)<br class=
=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br class=
=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return cur_v=
alue =3D=3D 0x1 ? 0 : -EIO;<br class=3D"">
&#43;<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;udelay(1);<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* timeout means wrong logic */<br clas=
s=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (i =3D=3D timeout)<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;return -ETIME;<br class=3D"">
-<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return RREG32_SOC15(MP1, 0, mmMP1_SMN=
_C2PMSG_90) =3D=3D 0x1 ? 0 :<br class=3D"">
</blockquote>
-EIO;<br class=3D"">
<blockquote type=3D"cite" class=3D"">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;return -ETIME;<br class=3D"">
}<br class=3D"">
<br class=3D"">
int<br class=3D"">
@@ -92,9 &#43;90,11 @@ smu_v11_0_send_msg_with_param(struct<br class=3D"">
</blockquote>
smu_context *smu,<br class=3D"">
<blockquote type=3D"cite" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return index;<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D smu_v11_0_wait_for_response(smu=
);<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret)<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;pr_err(&quot;failed send message: %10s (%d) \tparam: 0x%08x<br c=
lass=3D"">
</blockquote>
response %#x\n&quot;,<br class=3D"">
<blockquote type=3D"cite" class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;smu_get_message_name(smu, msg), index, param, ret);<br class=
=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret) {<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;pr_err(&quot;Msg issuing pre-check failed and &quot;<br clas=
s=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;SMU may be n=
ot in the right state!\n&quot;);<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;return ret;<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_9=
0, 0);<br class=3D"">
<br class=3D"">
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br class=3D"">
b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br class=3D"">
index 7f5f7e12a41e..a638326ba1b7 100644<br class=3D"">
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br class=3D"">
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br class=3D"">
@@ -56,15 &#43;56,13 @@ int smu_v12_0_wait_for_response(struct<br class=3D"=
">
</blockquote>
smu_context *smu)<br class=3D"">
<blockquote type=3D"cite" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fo=
r (i =3D 0; i &lt; adev-&gt;usec_timeout; i&#43;&#43;) {<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;cur_value =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);<br class=
=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;if ((cur_value &amp; MP1_C2PMSG_90__CONTENT_MASK) !=3D 0)<br class=
=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br class=
=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return cur_v=
alue =3D=3D 0x1 ? 0 : -EIO;<br class=3D"">
&#43;<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;udelay(1);<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* timeout means wrong logic */<br clas=
s=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (i =3D=3D adev-&gt;usec_timeout)<b=
r class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;return -ETIME;<br class=3D"">
-<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return RREG32_SOC15(MP1, 0, mmMP1_SMN=
_C2PMSG_90) =3D=3D 0x1 ? 0 :<br class=3D"">
</blockquote>
-EIO;<br class=3D"">
<blockquote type=3D"cite" class=3D"">&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;return -ETIME;<br class=3D"">
}<br class=3D"">
<br class=3D"">
int<br class=3D"">
@@ -80,9 &#43;78,11 @@ smu_v12_0_send_msg_with_param(struct<br class=3D"">
</blockquote>
smu_context *smu,<br class=3D"">
<blockquote type=3D"cite" class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return index;<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D smu_v12_0_wait_for_response(smu=
);<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret)<br class=3D"">
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;pr_err(&quot;Failed to send message 0x%x, response 0x%x, param<b=
r class=3D"">
</blockquote>
0x%x\n&quot;,<br class=3D"">
<blockquote type=3D"cite" class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;index, ret, param);<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret) {<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;pr_err(&quot;Msg issuing pre-check failed and &quot;<br clas=
s=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;SMU may be n=
ot in the right state!\n&quot;);<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;return ret;<br class=3D"">
&#43; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">
<br class=3D"">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_9=
0, 0);<br class=3D"">
<br class=3D"">
--<br class=3D"">
2.24.0<br class=3D"">
<br class=3D"">
_______________________________________________<br class=3D"">
amd-gfx mailing list<br class=3D"">
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" class=3D"">amd-gfx@lists.f=
reedesktop.org</a><br class=3D"">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist<br=
 class=3D"">
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-<br class=3D"">
</blockquote>
gfx&amp;amp;data=3D02%7C01%7CKe<br class=3D"">
<blockquote type=3D"cite" class=3D""><br class=3D"">
</blockquote>
nneth.Feng%<a href=3D"http://40amd.com" class=3D"">40amd.com</a>%7C1383f266=
1b584e04edf908d7789feaf5%7C3dd8961<br class=3D"">
fe488<br class=3D"">
<blockquote type=3D"cite" class=3D""><br class=3D"">
</blockquote>
4e608e11a82d994e183d%7C0%7C0%7C637110500551036438&amp;amp;sdata=3DQQ<br cla=
ss=3D"">
RY8dsiT%<br class=3D"">
<blockquote type=3D"cite" class=3D"">2BPio5I%2B%2F3ErqLnYQLxt6hcyXHedU79muT=
I%3D&amp;amp;reserved=3D0<br class=3D"">
</blockquote>
</blockquote>
<br class=3D"">
</div>
</div>
</blockquote>
</div>
<br class=3D"">
</div>
</body>
</html>

--_000_67CE166ACF824B52A440A37CB876261Camdcom_--

--===============0794466893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0794466893==--
