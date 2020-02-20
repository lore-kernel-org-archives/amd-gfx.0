Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1373DC11D05
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48B5207FD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 15:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IK5gPirB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48B5207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1ADA6EDB4;
	Thu, 20 Feb 2020 15:25:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E876EDB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 15:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw+zkH4jpWZVh1sVwF8Gv99B6g4ZAehYRdweuAXIljueKNtBqKhbKnQzy/AdqaCXx3K4uYJX8M62D0/FuJMQZhgJTQWBe3mPP/bTDim81sPZ0nyp9cKmMmzrH0NCOEFZuzBGKxevYZjy3RlyVfrv348+fGdA8GQkvSrzO7sDn85C/8FY8AJkjIxB9JtgdZdMViFJovjSxhnkZBfLmZLeDI5ceZuIe0r+HLS2hscxw7z8uj3B10IctIwPzli1w+7QRQdbQZWcf8ovlKo35//oBl6n9Gn0Rizxw8ovuhBnM4ACqFfQ02imwPjw1GmvJHMokARZfEME9o5sU8Busqm6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zce5G63pyScY6lQgwbghQcs28mrEL4wUhv+ZL3cxRg=;
 b=YsIIMEH7FLswUNh9BaB+Z80Cdb6uuu0nquxor7+r58L/iP2f7IetMi8EGdH8IYxZV/VlZPoLK3yzOvxA5SQVoNOikDYt1K4xZYwACbwyxHY4sxOFIXBwvVkKV9To91sA/09mqNeIbFAqethQcsZXjGZRH/nPvtXARECAjimKE9/9a1tnoz5pHlGz1UuNuUD6ZrFBYmfwfc56ucXkIh6ejzaIvKs4LaP4pJbvdks2WupEVd3ZcOikqXuSCI3oPwghLnkq3y+FFDmdNdLf6yCvDxM4qrvgpPtZeHuPK8B8hlh4asSk5wCHT7UG8rH5kaUszW60dLBtVnMpqKBXrstq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zce5G63pyScY6lQgwbghQcs28mrEL4wUhv+ZL3cxRg=;
 b=IK5gPirBs8EDdL5qRgcqAlA8FDHJ5dVrsPb1S41IqKmJ2wHH10FGVCmbvtPRge/GbJuneET59tqNGnuxe+e5wG8ykORb5Cr+vEDmKVhK3HPAFr0qCHlFxCn9zAY4UG07QtbOIg9crygG4Xh+N6tdkpewm51edyydM0+XGh9tf6M=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (10.255.174.140) by
 DM6PR12MB4338.namprd12.prod.outlook.com (20.180.252.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 15:25:39 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 15:25:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGEgYnVn?=
 =?utf-8?Q?_NULL_pointer_dereference?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBv?=
 =?utf-8?Q?inter_dereference?=
Thread-Index: AQHV5tpejmUZxmzr8E+/dIkRGLqWv6giDTkAgABJr4CAAArysIABY3CAgABGJdCAAAqScIAAHXiAgAABfwCAAADTwIAAAHBg
Date: Thu, 20 Feb 2020 15:25:39 +0000
Message-ID: <DM6PR12MB39310E13C0CFFC2BDBC5A44E84130@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
 <DM6PR12MB39317635C3FB63265B9216D084130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <DM6PR12MB39317F37CBE569725C00ABD284130@DM6PR12MB3931.namprd12.prod.outlook.com>
 <a8e8df99-aaed-5c0a-10ee-7cb63861c283@amd.com>
 <c778adb5-1ded-3b66-3f74-120f3388d611@amd.com>
 <DM6PR12MB3931DCBEB1DC6C722605E6F484130@DM6PR12MB3931.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3931DCBEB1DC6C722605E6F484130@DM6PR12MB3931.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaa666e5-3121-4013-c5c9-08d7b6192477
x-ms-traffictypediagnostic: DM6PR12MB4338:|DM6PR12MB4338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43380228C81634AEABB40C0B84130@DM6PR12MB4338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:235;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(66556008)(64756008)(86362001)(66446008)(76116006)(33656002)(66946007)(81156014)(316002)(7696005)(66476007)(110136005)(8936002)(6506007)(81166006)(53546011)(478600001)(52536014)(26005)(224303003)(9686003)(55016002)(2940100002)(71200400001)(45080400002)(186003)(5660300002)(2906002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4338;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrPA/aorwalgSYruGWJ5QNJPFYSgX2NAOJxX6/+ygx5dLTTACuZnBW8jtZSyIMmEyNxXWLM+TtwnrobWJ3nTAOTA6F8Mf8aaEEwvRaTopksX1XpPo0KKBgoTcyBtmYuTqMaOhtDbkI4qAkVRgmG0xDZu9nftp6u7r3afuZleKwJcOjOGVNgEPiCQ5Q2vVx4Wvnufwkuc93yX9RaJkGQB3RSZ+ss6UQ+1MAEG9Ve2puz6SqJxMh0kUeKhDlO2NGMcxmxbmLo8VILQCQvi40ap69uhdtgnHG0KSpemG17MUrv8d0cF7cHUCDhXrSqFXkj0Yyf84WepW+NYxs8qkRfgVJ8/w3vrkLeW/BSBYiCHgfwKyrTK2V17NbRBt/azlkhvkd0bLx3Ghdw3RYhcXsN5K2EJljee6j2Op2IkyO/SWJvTcPi+u73Y3BWjp8wVWJJfuJmL6em31WtL5ydFytIOUlGP6cgLL7T17fKqHWJYyNqd/S0dkOlxkTTQrR4f/UUZSmRq9JD9kc2xzFpGNZ8nkrOP5SH1xQ9VLzhzsfLAPWnhYWOb6KqSfxYKP7O6le7gcLBE9hHeJWXEENhwehlsi2rG+j0T+0AqAyZz0h4BaXi6weyLW8WQdIWy18cAYvdU
x-ms-exchange-antispam-messagedata: ofreB1cgVfbq+OwJsCKgy1La1I9bQ87woVk8yl+ftXociBSu7VjUDns9EeyqBoSBVjuEuUjLzjs64qZtSziP0wRiHsO82FWnemEPJfmitFU+e9BqMbgnN5fYWkVFJ3lY7Vo9opX6mUzEkhm56WHU1Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa666e5-3121-4013-c5c9-08d7b6192477
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 15:25:39.6732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+HmP8P8nCni44e3GuqOVNWIXeYisdhFgPUxs+5DJdUwtMTiYSG2wgLdhhRHjPwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

SXNuJ3QgZnJvbSBtZS4uLiBkYW1uIGtleWJvYXJkIA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0t
DQrlj5Hku7bkuro6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IOS7o+ihqCBMaXUsIE1vbmsNCuWPkemAgeaXtumXtDogMjAyMOW5tDLmnIgyMOaXpSAyMzoy
NA0K5pS25Lu25Lq6OiBEYXMsIE5pcm1veSA8TmlybW95LkRhc0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCuS4u+mimDog5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZHJt
L2FtZGdwdTogZml4IGEgYnVnIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KDQpJIGRvbid0IGtu
b3cNCg0KVGhlIHBhdGNoIGlzIGZyb20gbWUsIEkganVzdCB0aGluayB0aGUgcGF0Y2ggaXMgZHJv
cHBpbmcgYSB2bSB1cGRhdGUgd2hpY2ggbG9va3Mgbm90IHBlcmZlY3QgdG8gbWUNCg0KLS0tLS3p
gq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiDku6PooaggTmlybW95DQrlj5HpgIHml7bpl7Q6IDIwMjDlubQy
5pyIMjDml6UgMjM6MjENCuaUtuS7tuS6ujogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlDQoNCkhpIE1vbmssDQoNCkhvd8KgIGNhbiBJIHJlcHJvZHVjZSB0
aGlzIGJ1ZyA/DQoNClJlZ2FyZHMsDQoNCk5pcm1veQ0KDQpPbiAyLzIwLzIwIDQ6MTUgUE0sIE5p
cm1veSB3cm90ZToNCj4NCj4gT24gMi8yMC8yMCAyOjM1IFBNLCBMaXUsIE1vbmsgd3JvdGU6DQo+
PiBTb3JyeSwgbXkgcHJldmlvdXMgaWRlYSBzdGlsbCBsZWF2ZSBSUSBudWxsLCBwbGVhc2UgY2hl
Y2sgaWYgYmVsb3cgDQo+PiBtZXRob2Qgd29ya3M6DQo+Pg0KPj4gMjkgc3RhdGljIHN0cnVjdCBk
cm1fc2NoZWRfcnEgKg0KPj4gMTMwIGRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQoc3Ry
dWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkNCj4+IDEzMSB7DQo+PiAxMzLCoMKgwqDCoCBz
dHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9IE5VTEw7DQo+PiAxMzPCoMKgwqDCoCB1bnNpZ25lZCBp
bnQgbWluX2pvYnMgPSBVSU5UX01BWCwgbnVtX2pvYnM7DQo+PiAxMzTCoMKgwqDCoCBpbnQgaTsN
Cj4+DQo+PiAxMzUNCj4+IMKgwqDCoMKgwqDCoMKgIFdoaWxlICghbXV0ZXhfdHJ5bG9jayguLi4u
KSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU2xlZXAoKQ0KPiBXZSBjYW4ndCBkbyB0aGF0
IGRybV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQgaXMgaW4gYW5vdGhlciANCj4gbW9kdWxl
KGRybSBzY2hlZHVsZXIpIGluZGVwZW5kZW50IG9mIGFtZGdwdQ0KPj4gMTM2wqDCoMKgwqAgZm9y
IChpID0gMDsgaSA8IGVudGl0eS0+bnVtX3JxX2xpc3Q7ICsraSkgew0KPj4gMTM3wqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkID0NCj4+IGVudGl0eS0+cnFf
bGlzdFtpXS0+c2NoZWQ7DQo+PiAxMzgNCj4+IDEzOcKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlbnRp
dHktPnJxX2xpc3RbaV0tPnNjaGVkLT5yZWFkeSkgeyAvL3dlIHRha2UgdGhlIA0KPj4gZ3B1IHJl
c2V0IG11dGV4IGxvY2ssIHNvIG5vdyBzY2hlZC0+cmVhZHkgd29uJ3QgYmUgc2V0IHRvICJub3Qg
cmVhZHkiDQo+PiAxNDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFJNX1dBUk4oInNjaGVkJXMg
aXMgbm90IHJlYWR5LCBza2lwcGluZyIsDQo+PiBzY2hlZC0+bmFtZSk7DQo+PiAxNDHCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiAxNDLCoMKgwqDCoMKgwqDCoMKgIH0NCj4+
IDE0Mw0KPj4gMTQ0wqDCoMKgwqDCoMKgwqDCoCBudW1fam9icyA9IGF0b21pY19yZWFkKCZzY2hl
ZC0+bnVtX2pvYnMpOw0KPj4gMTQ1wqDCoMKgwqDCoMKgwqDCoCBpZiAobnVtX2pvYnMgPCBtaW5f
am9icykgew0KPj4gMTQ2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbl9qb2JzID0gbnVtX2pv
YnM7DQo+PiAxNDfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnEgPSBlbnRpdHktPnJxX2xpc3Rb
aV07DQo+PiAxNDjCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IDE0OcKgwqDCoMKgIH0NCj4+DQo+PiDC
oMKgwqDCoMKgwqDCoCBNdXRleF91bmxvY2soLi4uKQ0KPj4NCj4+IDE1MA0KPj4gMTUxwqDCoMKg
wqAgcmV0dXJuIHJxOw0KPj4gMTUyIH0NCj4+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCj4gcy5mcmVlZGVza3RvcC5v
cmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Ntbw0K
PiBuay5saXUlNDBhbWQuY29tJTdDMzYzNWZjOGJhYTRkNGI5MDM4NzEwOGQ3YjYxODgwNjklN0Mz
ZGQ4OTYxZmU0ODg0ZTYwDQo+IDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODA4ODY2
MTI1MzY1MSZhbXA7c2RhdGE9S2kwU211bFBFU0xJajcNCj4gZEd5VDEwQmUwelh1bmdLNFU5ZlhP
TnA0NU5qYUElM0QmYW1wO3Jlc2VydmVkPTANCj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1k
LmNvbSU3QzgxYWQ3ZDk1OWU3YTRlZDk3MmJiMDhkN2I2MThmYzQxJTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3ODA5MDczODgxMTA5MSZhbXA7c2RhdGE9
N0JBZlZOUUtJOTJNYnc3QjJrQlJZb0VuTTJPeER3dGVkdSUyRk03cjZjSlo0JTNEJmFtcDtyZXNl
cnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
YW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0Ntb25rLmxpdSU0MGFtZC5jb20lN0M4MWFkN2Q5NTllN2E0ZWQ5
NzJiYjA4ZDdiNjE4ZmM0MSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2MzcxNzgwOTA3Mzg4MTEwOTEmYW1wO3NkYXRhPTdCQWZWTlFLSTkyTWJ3N0Iya0JSWW9F
bk0yT3hEd3RlZHUlMkZNN3I2Y0paNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
