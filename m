Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6159C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB95208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 07:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gj+RwaNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB95208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E911789C83;
	Tue, 21 Jul 2020 07:58:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5DF89C83
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 07:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPYdwiXvOMbuGCe9yuUwZ0SUDZNLdQSXaNX/kInDbnw9rTu0+fGc58sJ3/U0w9G5GpfJMsLxAEyWw2clIQLr185gE1uzauL5Fu5ylhFRzXxTBU8Um9pOcEyO9vGG4nkN+FtVZi0uyw+ACPbVw7Xk0sDIJk42SHGuJeBglhmBtkLVUOpHGm29A2D9FOslRm4Ci6owkMqWNWLU3CkXdJVPEb2eBBZt4kBfejaLqfFjpwGhVXIsRrW5BuisXHmr2mOqXHkPRieggrT+cbUD6g0UdEoBI/w+q5Hrr3TVwTXS+upwBlg+Y43r1Zu/XrlBx19iOHq3Zpkfuazc6IrOaAAOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn+TM9s7krl3XQ1W1BreyUYUT3d7UydO1Xjql6QqJIQ=;
 b=hXUyolw3H/K2ZCRtymcEPPkPXFqmEWtiw9nZshJDECK2/pk7FMfb04KIXqHkBPghpOA3P93qbdYP4K69669g3F+tOdc7fhFU9Pk4D3EIyFWvrz9WsE2/OZO58qlFepSkdIrSb69M28W7Xa6JgYiVTbHx5mUrRJzFd94JZmGsfgtMpzoGeHoXTaPIdxpEdlPLmYSHc8J60a9WWD7RWfcoYnLVT053XgRol6964cOQUODLvk/Q6eNeWSCfUjS0yLrU+vlMD449cVJL05KFxgTJUmQWkQWxJ7d7HcgJMMewozikJ5VJmUjeyE7MxccOlLxEYWcHdIaNBoM7xKCtVoGe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn+TM9s7krl3XQ1W1BreyUYUT3d7UydO1Xjql6QqJIQ=;
 b=gj+RwaNQRvpfBUAhxvqPIvU5K6gl2Iea09TbQlqKiFn38f6lOiIAZR904+OGp0YRSE1C/263VWNZ6kg20RXy4a2g/ZCn1MFB/jtWZSsoPkoYaAcOmAny/xhoPVEqy/AC0+rP4s2/TQaArGftmJMKsY3KZUMTEahQWsC59nhM0MY=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 07:58:25 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 07:58:25 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogc2tpcCBpbnZhbGlk?=
 =?gb2312?Q?_msg_when_smu_set_mp1_state?=
Thread-Topic: [PATCH] drm/amd/powerplay: skip invalid msg when smu set mp1
 state
Thread-Index: AQHWXyhjO0n+xCr5A0uIR3CLthbdBakRnGiAgAAKQgA=
Date: Tue, 21 Jul 2020 07:58:25 +0000
Message-ID: <MWHPR12MB1854FB6E2ABEDF5AA67C0EE7EF780@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20200721062952.1255025-1-likun.gao@amd.com>
 <CH2PR12MB4326CEFA5554F7C91B6AC1ADEA780@CH2PR12MB4326.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4326CEFA5554F7C91B6AC1ADEA780@CH2PR12MB4326.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:e0:a67e:8600:cc2e:5ea:6f2b:6b41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c143a314-9a5c-4ec0-35f4-08d82d4bd8f3
x-ms-traffictypediagnostic: MWHPR1201MB0048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB004848ABBB5FA24F600FF40CEF780@MWHPR1201MB0048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +yg69rCzqzIGuaFbphdtNZKNqRSO/L5h0dKFl0m+3HUb42AaqNOlRS1nEq0qOoSik69ikHgxSacOPHrNj8ovZjCppdjtU1IllaMw0dNB55WYTmOz/Wdh6ALZ2auV3+aZjshMsxQUXeIkzerZQ91ki6g582R8vr+nejA+LcWy9Bh9JOwbtEC5RdOvUgGflZEHYJZY4PLyeKwm5twyjuWOeH1UQRF+phiLzOhvrir4i8rEsZR1x+csM+PaFWB2oPQQoz4IquZ/TfQPg+ym5UNprhA55g4ThmwyJiAQdZ07YIblIxOtCgvBpIzvWU3V1IIScQrVE+5jn5GT6PvF453t1tOksodey70qgqUostIsJgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(966005)(5660300002)(478600001)(71200400001)(45080400002)(52536014)(9686003)(76116006)(8936002)(33656002)(186003)(55016002)(7696005)(224303003)(86362001)(4326008)(66946007)(54906003)(6506007)(64756008)(83380400001)(53546011)(110136005)(66446008)(316002)(66476007)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 95s+ECe1dG5bM+YzExsyyOFmS5M0TwSUmyUaNLx187lLwd4Kr3kqoDYzu8tPHAwOYdHSQoI7JZSTQl2j0qkpEKzZa9AuEb4kJofQbvefUi/bckcTdgbr7tKfp3PQB129KfDAltYS9dE3UAVq9YCra5TX/kIV6lMaWC9/MfWLmvO2IKQlTg+tcjGThkFGJXCBPHtUbVO0MvUq4b1dfoI1ab0prWEGh5UVYbLgfJn4Y9TKaP62Wr/OLBHY5d7UbY3tryH1IYPZTRr/2x3ylAlPIlc02BBZgS9Gi08kXycCAijnH8Zhl6gAUW1nPW8PrP9lc37cGOuGvDqgRNcEDuz0j2Ehj3NK+UFJVVnmGHL5KbO7uZkT2aJmUfPf+AUT9xHY9lb4KGlb0ULijiX7Q/ha1rbWjuEx9+yN/HYMFbI9+swgpIP9B9Bpd8FcsZj5bix74PIsOCjyMC+t5UL+P+ubfRxRs9l3ESZl6ggyz4MSgzlQswh5ERD0j6oPO4516lBxcaILAycEZ/7sOxn6dXJE4KR4fbqDBatRldCpfCXMFAw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c143a314-9a5c-4ec0-35f4-08d82d4bd8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 07:58:25.7120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udKywoNjyMQe3ZRxr7T4akHNPT71lcfd200DxgRMNelJ+EiyBGDuZ/f4HoYhrENW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Sheng, Wenhui" <Wenhui.Sheng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm90IHN1cmUgd2hldGhlciB0aGVyZSBoYXZlIGFueSBjYXNlIHRoYXQgbmVlZCB0byBkZWFsIHdp
dGggdGhhdCBzaXR1YXRpb24gaWYgc29tZSBtc2cgbm90IGZvdW5kIGV4Y2VwdCB0aGUgc2V0IG1w
MSBzdGF0ZSBtZXNzYWdlLiBJZiBoYW5kbGUgaXQgaW4gc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0
aF9wYXJhbSBhbGwgdGhlIG1lc3NhZ2Ugbm90IGZvdW5kIHdpbGwgYmUgc2tpcHBlZC4NCkFuZCB0
aGUgbG9naWMgcmV0dXJuIGluZGV4ID09IC1FQUNDRVMgPyAwIDogaW5kZXg7IG9ubHkgc2tpcHBl
ZCB0aGUgYmFkIHJldHVybiB2YWx1ZSB0aGF0IHRoZSBtc2cgd2FzIGZvdW5kIGJ1dCBub3QgdmFs
aWQgaW4gdmYgbW9kZS4gSWYgdGhlIG1lc3NhZ2Ugbm90IGZvdW5kLCBpdCB3aWxsIHN0aWxsIHJl
dHVybiBhbiBiYWQgdmFsaWQuDQoNClJlZ2FyZHMsDQpMaWt1bg0KDQotLS0tLdPKvP7Urbz+LS0t
LS0NCreivP7IyzogQ2hlbiwgSmlhbnNvbmcgKFNpbW9uKSANCreiy83KsbzkOiAyMDIwxOo31MIy
McjVIDE1OjA2DQrK1bz+yMs6IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCrOty806IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQu
Y29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBTaGVuZywgV2VuaHVpIDxXZW5o
dWkuU2hlbmdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQrW98ziOiBSRTogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogc2tpcCBpbnZhbGlkIG1zZyB3
aGVuIHNtdSBzZXQgbXAxIHN0YXRlDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCg0KVGhlbiB3aHkgd2UgZG9uJ3QgaGFuZGxlIGl0IGRpcmVj
dGx5IGluIHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0gd2hlcmUgaXMgbW9yZSBuZWFy
IHRvIHRoZSBzb3VyY2Ugb2YgdGhlIHByb2JsZW0uDQpBbmQgdGhlcmUgaXMgc2ltaWxhciBsb2dp
YyBhbHJlYWR5Lg0KaWYgKGluZGV4IDwgMCkNCnJldHVybiBpbmRleCA9PSAtRUFDQ0VTID8gMCA6
IGluZGV4Ow0KDQpSZWdhcmRzLA0KSmlhbnNvbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgTGlrdW4gR2FvDQpTZW50OiBUdWVzZGF5LCBKdWx5IDIxLCAyMDIwIDI6MzAg
UE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEdhbywgTGlrdW4gPExp
a3VuLkdhb0BhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBTaGVuZywg
V2VuaHVpIDxXZW5odWkuU2hlbmdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBza2lwIGlu
dmFsaWQgbXNnIHdoZW4gc211IHNldCBtcDEgc3RhdGUNCg0KRnJvbTogTGlrdW4gR2FvIDxMaWt1
bi5HYW9AYW1kLmNvbT4NCg0KU29tZSBhc2ljIG1heSBub3Qgc3VwcG9ydCBmb3Igc29tZSBtZXNz
YWdlIG9mIHNldCBtcDEgc3RhdGUuDQpJZiB0aGUgcmV0dXJuIHZhbHVlIG9mIHNtdV9zZW5kX3Nt
Y19tc2cgaXMgLUVJTlZBTCwgdGhhdCBtZWFucyBpdCBmYWlsZWQgdG8gc2VuZCBtc2cgdG8gc21j
IGFzIGl0IGNhbiBub3QgbWFwIGFuIHZhbGlkIG1lc3NhZ2UgZm9yIHRoZSBBU0lDLiBBbmQgd2l0
aCB0aGF0IGNhc2UsIHNtdV9zZXRfbXAxX3N0YXRlIHNob3VsZCBiZSBza2lwcGVkIGFzIHRob3Nl
IEFTSUMgd2FzIGluIGZhY3QgZG8gbm90IHN1cHBvcnQgZm9yIHRoYXQuDQoNClNpZ25lZC1vZmYt
Ynk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+DQpDaGFuZ2UtSWQ6IEkzMWI0MGI4NzUz
MmExZDc1NDliMjYxNTVkNGVjODE0NWI1ZTNmMTAxDQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0K
aW5kZXggYjE5N2RjYWVkMDY0Li4yMzdkOGFiOGI0MGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KQEAgLTE1OTAsNiArMTU5MCw5IEBAIGludCBzbXVf
c2V0X21wMV9zdGF0ZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgIH0NCg0KIHJldCA9IHNtdV9z
ZW5kX3NtY19tc2coc211LCBtc2csIE5VTEwpOw0KKy8qIHNvbWUgYXNpY3MgbWF5IG5vdCBzdXBw
b3J0IHRob3NlIG1lc3NhZ2VzICovIGlmIChyZXQgPT0gLUVJTlZBTCkgcmV0IA0KKz0gMDsNCiBp
ZiAocmV0KQ0KIGRldl9lcnIoc211LT5hZGV2LT5kZXYsICJbUHJlcGFyZU1wMV0gRmFpbGVkIVxu
Iik7DQoNCi0tDQoyLjI1LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDSmlhbnNvbmcuQ2hlbiU0MGFtZC5jb20l
N0MzMDdiNDMyNjUzMGQ0YThhZmI1YzA4ZDgyZDNmODc3YyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczMDkwOTgxOTgwMTQ5NDQmYW1wO3NkYXRhPW1uWkZ0
c3Q4ZzR5eHFPalllb0FtRnVRdlZuOFk3ajR0cGYlMkZQTHZhVEN0OCUzRCZhbXA7cmVzZXJ2ZWQ9
MA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
