Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63068C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121EC206A2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MiMEtfnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121EC206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1C06E0E3;
	Tue,  2 Jun 2020 06:12:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626D46E0E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 06:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV9sTQy86cD/bB5fBb2WA05nYlbTjL0itcwynDhcM8P4XdRW3CqAmEM8WUEpd/EbtvkWef6ynDZFINXNkZ1S+5AWfZizRMprBAVQDIjxSxhRYncdB5yj2yRDzCRHSgyl5KtEFSZjhPbjC0fPmZbd9vciiCBuZHgK1cblQ1F85IzLZiiVlfRombe1Ig7LcoRCNIEFtC2dS7vcMiT/rwiRdWfEk2QbGuM5Ey7UfIAPera8UmNz8RVwK+lBPHfWHEkSZ2LVuc7l3h1oK9mzLjufxyB+7iMIB3GAn2tux5KhGuSQU4A+wjKdDi7xLoX9YetJiXUgwUpjpVjh0/JEa4wb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa9zW73FlB1Qc6I73zAfSX4RP2Ez6yk0fMCK6cBcpTQ=;
 b=DTkGmwQ+jBTBP7XA7MUIHEeuCQCWq+/5/GioqEyMM1dwer53zmCRoty4aSq5kdDiSZDFvlBcyhvtZZH0AQvNyrv4nU/T8ImkAyGxtiZXjxZSX7gF7UOqrN1bxZD3t8El012ihPznwT7HKKssjGdXeS8Xd/awQosQqss+3i824UVcKo6tPE6U34eocJsBSEF3MdK5cRyNEUCxQoIsKxtSLMvsV/GK+PbcUO3MNAfcT9Uph96jM9rmGDaAn4Sk5bXGYTXF3fj9MdBt1MIKwdPIXhAYJZTExxpyJNQG7GHGELxSGq8AoIiV9+XUpDNjlTQozqegOeM6/c6Ycv4DhYeQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa9zW73FlB1Qc6I73zAfSX4RP2Ez6yk0fMCK6cBcpTQ=;
 b=MiMEtfnZO3m3kjJDw0ZZs4A//akBMfyZxkuCXCI3uLVqYa0PWoGgD27ADc5REb1dNIPICsr1k7q0iO/Fca3aqqKU7BaGT4FPkwR2z1EnQHywA8myh5trkACyZpLPkcT+j24pika/HF5PEAzSjZA19zUwgXPfL9xF8fqPze449Tg=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2984.namprd12.prod.outlook.com (2603:10b6:a03:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 06:12:14 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 06:12:14 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove RAS's useless code
Thread-Topic: [PATCH] drm/amdgpu: remove RAS's useless code
Thread-Index: AQHWOKLXAq8tp6hu/UGCrdtkkgjei6jE1uVA
Date: Tue, 2 Jun 2020 06:12:13 +0000
Message-ID: <BYAPR12MB2888870B105218BF323FB9BCB08B0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200602055811.21651-1-guchun.chen@amd.com>
In-Reply-To: <20200602055811.21651-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-02T06:07:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=41208b3e-ff26-40db-aef8-00000c5ea4ce;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-02T06:12:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0818509c-69bf-4bc8-b28e-000007d58d96
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.232.44.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e3a7b97-060a-45f2-7ca2-08d806bbe4e2
x-ms-traffictypediagnostic: BYAPR12MB2984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2984242AF6F46EAF6AD5483DB08B0@BYAPR12MB2984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4T/ZyXxhiT2KyPXo58Svg2qNSvTfcttCoaC+Ydtde7mHEsviRF3fQM4SQNWJ0porGSZHCVvWDPrirkfor7sHx7cl+AZ6TnQh/ZIlkeQz8dliK8SYQVEuDazxxcdtG39TFVfzJIpet+S8sW9Uo2xly/d7qpWg6PAmJlhFZVdej3bP1M888ls1tniS9FwCO+gk12j6Bw86yrspZAbfegNAQ1trHFwLMSuRFFoWUP1jmF3Hu+hDkeJocS8svFxJxGK7PqvP8Kq6VU/Q/D7nUS8zoUYandfpP6/5HfbwddMqTawYTw6x2NbtLsjhTE90ahCUzOG0/JvlS7bJ6XdjWa0Gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(110136005)(8936002)(478600001)(52536014)(316002)(2906002)(86362001)(186003)(66476007)(66446008)(76116006)(64756008)(7696005)(26005)(66556008)(53546011)(8676002)(6506007)(66946007)(33656002)(71200400001)(83380400001)(55016002)(6636002)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: aIQBQK55r1ZT4J/eO5n+/SPd5acrsdYhAdQvMzuKD9abOL9PFEuAtdt2S7aaISAdLEBV5StI7109O9m6NYosj8fuy4SZZtvmYfI1KJViwUgMeNXtTbrufpE5IwFEz70uWYJVFpemEnZnsAZtXBm6txxKd7+DKKhog1fdZorOPbZ+2S1jWarXOFcPQrt6fL3wWfqUalWKbs6quNJxbkBjs6hL0eKnr+ZrKLI7NMJsiM5zWHicJlKTglv33VQXbJKmou+UBonJgH7T0RiA5VMZEVZHNinl0ikXXoGfhPLUThhS7Kyo/223GoqdwdTCyEII4ZdKlMvIRPg3QEsu6ZgPfOq4enAa+RYcmxZmQ0S5HEr5T0dWKvy9y/3kz70MLsLfZ0oqmlikSpvbQ9hLVQaNnnwMMUDTCKUrtKOa+2ADZsrP3pEpBKCEQ0xODdhVkjleolzYeakMxaB9Kg6FgPVBem8Z+2+e1nGljcefj21UbQc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3a7b97-060a-45f2-7ca2-08d806bbe4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 06:12:13.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjlq1szlUf3uTkS8vUdL2KX2nxLc7qPp6HiTTEEkiu5/CLskEGPZke4pPEzKVsyu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2984
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpJIHRoaW5rIHRoZSByZWFsIHJlYXNvbiBpcyB3ZSBoYXZlICIg
Kmh3X3N1cHBvcnRlZCAmPSBBTURHUFVfUkFTX0JMT0NLX01BU0s7IiBhbHJlYWR5LCBidXQgdGhl
IHBhdGNoIGlzOg0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIEd1Y2h1biA8R3Vj
aHVuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogMjAyMMTqNtTCMsjVIDEzOjU4DQo+IFRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksDQo+IERlbm5p
cyA8RGVubmlzLkxpQGFtZC5jb20+OyBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQu
Y29tPg0KPiBDYzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlbW92ZSBSQVMncyB1c2VsZXNzIGNvZGUNCj4gDQo+IE1v
ZHVsZSBwYXJhbWV0ZXIgYW1kZ3B1X3Jhc19tYXNrIGhhcyBiZWVuIGludm9sdmVkIGluIHRoZSBj
YWxjdWxhdGlvbiBvZg0KPiByYXMgc3VwcG9ydCBjYXBhYmlsaXR5LCBzbyBkcm9wIHRoaXMgcmVk
dW5kYW50IGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNo
ZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gaW5kZXggNzliYjA1ZDc5
MWJjLi4zMzdiZjJkYTdiZGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMNCj4gQEAgLTE5MDIsOCArMTkwMiw2IEBAIGludCBhbWRncHVfcmFzX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAJCQlnb3RvIGVycl9vdXQ7DQo+ICAJfQ0KPiAN
Cj4gLQlhbWRncHVfcmFzX21hc2sgJj0gQU1ER1BVX1JBU19CTE9DS19NQVNLOw0KPiAtDQo+ICAJ
aWYgKGFtZGdwdV9yYXNfZnNfaW5pdChhZGV2KSkgew0KPiAgCQlyID0gLUVJTlZBTDsNCj4gIAkJ
Z290byBlcnJfb3V0Ow0KPiAtLQ0KPiAyLjE3LjENCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
