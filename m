Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1295EC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 07:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D36410E346;
	Tue,  9 May 2023 07:47:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F6C10E346
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 07:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5wynlMR1cdr/iaETizcTeMf6WSbmWOA16bbCPWQAEh+HOGL+1NvBg6nlYuisYqrwfNcnADvYqyqSH563dfx3eiJ737wNuLl/aNUib5sourl4oxBNSh//WybdOEX7+Xy7TM0YLsFseXe6KJiUa50za94vbFuMQtZpVt5W3KwFUm2oGOstr0sq0QLLNrFBK2FggtI9Bzt5Bpk1ZRNJjBD17kwfpX3xLbxOuplAx30R5ED/a+81F/gvvVE7VIt9lCsS0e9Yf3rP5vL1QL+stbuFwURe02Q9rRjDNJsJKNvylxz8hkQx868ytlntlKMx8Zmkoq24bi2sgIvFwAgXTQ5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/NcNiUPtUS4AkDZTlJKBFpVDmayITunQ0eJeXvinLw=;
 b=hr0P/lcYypYEodb7rlc0Px4faFxBs1hkiDzfB/VSJGzuW42lyxv7WSP13fAPGNjR2InXu/nGwhBpBChbnZI0UrCBVU7HphS11GF7SXgwsqs5n3kmPHACgkX5fOLhdRbZfJ4+oU4+JeV6X/1gNgY9QqcvEazCt6OxIT2u4nXD2thljTDeoJPdVcm+otGKiTc9d02PQmQWRs8OH89UzJ91U6T0PlbyC8wKdTUw4Blu28rtqeRdOBJ03Rabzn5KrBEJd2qYE01dtb/AGP1XN5Tv3oE9CGs8yDWgjUPdixv0EpyFcwq24EPYIt5x4hD18z5xED1suTZmC3blG9KKQ1i9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/NcNiUPtUS4AkDZTlJKBFpVDmayITunQ0eJeXvinLw=;
 b=wnESigbQ+yoEpW1/XRfI/1C9pAdBH6gbG1CevxQgpz5AmlcZd2kMNt0pTWaGHSuejLrwNcCSeWTtEW1LIEwEHDsMIMQ3ge7hKJoOvdN8q2mv7TGrZ+Medw/udg9x+z5P6lv0Qnps6iXg84TcstWVAYwQv6K4nYz77tPVrvci6G8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 07:47:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8%3]) with mapi id 15.20.6363.027; Tue, 9 May 2023
 07:47:09 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Topic: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Index: AQHZgjc2SxURAdutlkqm9PBxXXmqh69Ri4YAgAAEwBA=
Date: Tue, 9 May 2023 07:47:09 +0000
Message-ID: <DM5PR12MB2469B1CBDC8A7DC73DC8456EF1769@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230509052906.2142723-1-guchun.chen@amd.com>
 <f26cecb7-737b-9236-8d10-4abf7749e757@amd.com>
In-Reply-To: <f26cecb7-737b-9236-8d10-4abf7749e757@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MW4PR12MB7191:EE_
x-ms-office365-filtering-correlation-id: b837b5b2-5cd0-4d5f-4d4b-08db506197dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mtwD8Ri+TVvG8PDWMHbijFkLG2yaVX6rTG//istT3KV8/kkQtqYfdMIL2XkjIeXqimpPgvcUznfl/fGkUwm77DcXL5nYgNlL8x8w1Fbvnf0YBilmIr+X6dx76si9JFtt0MEOHF4tnBqcEf/JL3GVpTlc0PpZN887KNryg8NUpPtGzKOqgaVGoTBnymzqzw2wcK4lecXVOk3jQwbFcOdBA3J5K24umK3ClhxIzme2to6lE+o20JMUfgoEt5Qx0UstghPFNQn8FzNaeJibEfu4HNuZqmYGqBph9d0ZdMrN41sTwmD+Xxc8nX1WFVirM/FzTlinleEOYUHM1S1hfZ9fTMyuS11FhuHGyPjjQZ+DeSX/K5XH1/nYqfWTT8N68Q7qBtUftB+afQFMFe6vgSGic9YlkCgTa9B3TRqgbDpbjLBut2OjLsjf9G8hq6w5HxbOCtBec7t9QTTwwrvS2PiHOBMd+2x98RZjCWCB0YJjV5SLQDU8z84iYGSacQVXu588Y/A2OhAuKpmo5aLMiuI93ghFtPTcvBfNqQ9+Zk5cuSflIZ88C1SaFwEK82LRQgp6sviFudG8Qmkc621pcnW/2DJNE3/Rrs/KuOn5udwwSc9evH6yiliuuGhu1ogF0M+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(83380400001)(38070700005)(55016003)(33656002)(86362001)(122000001)(38100700002)(7696005)(71200400001)(478600001)(2906002)(66946007)(76116006)(66556008)(66476007)(316002)(66446008)(64756008)(6636002)(110136005)(8676002)(8936002)(52536014)(5660300002)(41300700001)(9686003)(6506007)(186003)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3NsbEUwcVkzUW4rRTdmNmd1QmtTQ0VUZGdYbW5NcThmYnA0bHQzSzQweThp?=
 =?utf-8?B?bzhMdTVFWGwxUHdRMzUyTHhBS1BaQUxZZTE1SDlnZlBZVHFvNU0yT1BTN01O?=
 =?utf-8?B?dk81SjFxYTFsV3kxb2FOdm1QZkVqUHpsYU14YTJ0aW9MRjR2bnJwL1Qwajkx?=
 =?utf-8?B?aTZoMGEzbGcwSkNqNGVKeVYrMVRsYmV6UURyUktjMEtEc0pZdmRHVG1XNnVS?=
 =?utf-8?B?NFBQYTJLM1gvUWIrNFoyb3l0WTRnRElraCtkQS9BbDFyL3hKK3dZNzI0Nmp4?=
 =?utf-8?B?VUJzaG9Hb1hrS3FhdjlkMSttb2Y2bW0yRXlObUFpVVZOTG4weWFFWGczSGdU?=
 =?utf-8?B?QjJ2QTJudVdJVnM2elU0MjhESVIvVHJmRUpYZVcrZVNpSmlvOUhUOWZTVkV0?=
 =?utf-8?B?OWtVQ2JUNEhsNVpqZnRiN0RNc2hpWVd0U0E3am1lUldqWGYwbm5tcnBFSW5l?=
 =?utf-8?B?WUthK2F6RFppb0JXNCs4NjdoME1HUjBITHJyOFhIREJya21Rb1lBcDBaVTBp?=
 =?utf-8?B?Sit5aWNDYld6S0hvYVladllYVUpTRTRXbEVQK3Zid2x0ckk4dzhxb1VJeXY3?=
 =?utf-8?B?YXBZb1RwS2VVTGlBUXVMU0RLTTh1OTVBM0RoSnYza01QY1FlUXVERkIrK1RU?=
 =?utf-8?B?NEV0MUkyNVJvZGFDaGJFbkszNWtGbmlqS2k2ckM5LzlCZ3NuNEdEOXhSUmdW?=
 =?utf-8?B?a3lNTE1CcHNiTE9TYzNzdVBhR1laa2JtK09DVGs1TlBxeFBWc1p0SlFWT2Jx?=
 =?utf-8?B?YVNFcDhLbXQrdEJDTTNuUWwxOEkzVU56ekZyc092SmgzOTVOSmI3VE81VTJC?=
 =?utf-8?B?dmQrWmJvUEFqYWt0M05taXVNMzRmV3ZCTWlYQ2dxL3dkQ3lIZmZQbURVNUFm?=
 =?utf-8?B?UEdJR3g2OG4vaGZXVDg0czJUbU5vbzNoMVJzVXZuMDJXSEtrNjZhK3g0V3hO?=
 =?utf-8?B?Z0R4aWs5Y1BFN3hJOHYxMXlaRWI2OE81bGtLSy9hQlo5ZVVDS0NNc2RVOG0y?=
 =?utf-8?B?R3I2cWdQYjlZYzY1QU1Qek5sMmVuVjYyVnZ4MjZiZnU2VVlHMW9QS0NYc242?=
 =?utf-8?B?RFNKL1NDWlplNnRrWTBCSTBmQ1JocjVOdEFSbHFCL05WdVFkWmdKUFpBZ1pj?=
 =?utf-8?B?clJhcG15bW1mZlJxNVByYkt2V1JRK20vTXFVdGVOSWhmRVJjZkhhbi9UcmE2?=
 =?utf-8?B?TFFaa21hSHQweC9EQlZETWZCbktlelcyQmt1Ty96VU1YZVlWN0hjbTdHOTNp?=
 =?utf-8?B?ZDZyaTkweml6cUNaR1pERUtmVTR1TkNZK2tBQ0p1d3JuWXhqMlNYdXNvZzM5?=
 =?utf-8?B?UU5JNGttQmlOektPdDVqTFVZR3FWMk9VQ0tmQkdaRlZqeDdPb0pnbi9aYTdm?=
 =?utf-8?B?LzJscmVYVXN2U0d5VDFSeVNLdGkxeS9wYUJib2N5UmpoSklUTHBqbzdaRW1F?=
 =?utf-8?B?alpNbkJVU0NYMkRJVldWSVVobDNTNkUrRjh4RlhRMWF2cGZ0WmJjbHlXT2sw?=
 =?utf-8?B?aXZyRTNTRGpLcXREckh3T3NEM2VCeXdoN2RGQk5LbWErUW5WT2t4bm9jQ1F1?=
 =?utf-8?B?c1FOTUlWSjgzUGZHcjRjTFd4YjN6MEtkd2Q0QmltaWJmQmJ0MDNXQWJ5VU9x?=
 =?utf-8?B?SGMzaE4rTmpoZTh6dkRKTHIxVzFOQ1BsT0NHT1F2KytVa29nSzNiS0k2RnQ5?=
 =?utf-8?B?RjVxVXY3cWtXOUY0WGd3OUZ4QkN0UXYzRVlNdnVJR3FvZ1kwdUxBZE00MXlO?=
 =?utf-8?B?SEIzVm9meEVpdk9wZ1gwczdseU1lOWVCTUx1a3dLcFFwd3MwWm5Dd1V3bHcy?=
 =?utf-8?B?NVFWUlpaVkpHdldsd2FhZmRMR25ncEEzejdYMEJBWjhSdE1GK2tFa25lK2M2?=
 =?utf-8?B?cmgrYlJURFdSS2VCNjd6NW5OSTFUalNabnhjN0hmbzQ3MEhSclo5Q2F5TTJa?=
 =?utf-8?B?b0NvbjAyUmRXQUpyNmlzRW4xWmovNW45eUZHM2VRZ1E5UXFVa0R4V256WlRP?=
 =?utf-8?B?VzhSWitrQ3poRy9XZE9XUUl6U2pmRWpaZDRCWTFqWjg5S2x5cEprd0pPRkR0?=
 =?utf-8?B?SERIUTJPQ3NxMFozQ1dsdDhyRFUyQXc3Q081Uk1DNDVqeVBHbGI3VGY5RG82?=
 =?utf-8?Q?LffI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b837b5b2-5cd0-4d5f-4d4b-08db506197dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 07:47:09.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZBE4/gL3P/aiToZvOpVm6gLJNUIQ+FBpZZag88v2nAHjQCIAUnfNtujPzA3MtDvSOvvK1At/EzaPNslCkZA7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWF5IDksIDIwMjMgMzoyOSBQTQ0K
PiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsg
UXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWQvcG06IGF2b2lkIHBvdGVudGlhbCBVQlNBTiBpc3N1ZSBvbiBsZWdhY3kNCj4gYXNpY3MN
Cj4gDQo+IA0KPiANCj4gT24gNS85LzIwMjMgMTA6NTkgQU0sIEd1Y2h1biBDaGVuIHdyb3RlOg0K
PiA+IFByZXZlbnQgZnVydGhlciBkcG0gY2FzdGluZyBvbiBsZWdhY3kgYXNpY3Mgd2l0aG91dCBv
ZF9lbmFibGVkIGluDQo+ID4gYW1kZ3B1X2RwbV9pc19vdmVyZHJpdmVfc3VwcG9ydGVkLiBUaGlz
IGNhbiBhdm9pZCBVQlNBTiBjb21wbGFpbiBpbg0KPiA+IGluaXQgc2VxdWVuY2UuDQo+ID4NCj4g
PiB2MjogYWRkIGEgbWFjcm8gdG8gY2hlY2sgbGVnYWN5IGRwbSBpbnN0ZWFkIG9mIGNoZWNraW5n
IGFzaWMNCj4gPiBmYW1pbHkvdHlwZQ0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBFdmFuIFF1YW4g
PGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNo
dW4uY2hlbkBhbWQuY29tPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfZHBtLmMgfCA5ICsrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRn
cHVfZHBtLmMNCj4gPiBpbmRleCA4NjI0NmY2OWRiZTEuLjRiMjhmZDYyZWQ3YSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gQEAgLTM2LDYgKzM2LDggQEAN
Cj4gPiAgICNkZWZpbmUgYW1kZ3B1X2RwbV9lbmFibGVfYmFwbShhZGV2LCBlKSBcDQo+ID4NCj4g
PiAoKGFkZXYpLT5wb3dlcnBsYXkucHBfZnVuY3MtPmVuYWJsZV9iYXBtKChhZGV2KS0NCj4gPnBv
d2VycGxheS5wcF9oYW5kbGUsDQo+ID4gKGUpKSkNCj4gPg0KPiA+ICsjZGVmaW5lIGlzX2xlZ2Fj
eV9kcG0oYWRldikgKChhZGV2KS0+cG93ZXJwbGF5LnBwX2hhbmRsZSA9PSAoYWRldikpDQo+ID4g
Kw0KPiANCj4gRm9yIGNvbnNpc3RlbnQgbmFtaW5nLCB5b3UgbWF5IHVzZSBhbWRncHVfZHBtX2lz
X2xlZ2FjeV9kcG0oKS4NCg0KV2lsbCB1cGRhdGUgaXQgYmVmb3JlIHB1c2hpbmcuIFRoYW5rcyBm
b3IgeW91ciByZXZpZXcuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KPiBSZWdhcmRsZXNzLA0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4gDQo+IFRo
YW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIGludCBhbWRncHVfZHBtX2dldF9zY2xrKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBib29sIGxvdykNCj4gPiAgIHsNCj4gPiAgIAljb25zdCBzdHJ1
Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jczsNCj4g
QEANCj4gPiAtMTQ2Nyw4ICsxNDY5LDExIEBAIGludCBhbWRncHVfZHBtX2lzX292ZXJkcml2ZV9z
dXBwb3J0ZWQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAJfSBlbHNlIHsN
Cj4gPiAgIAkJc3RydWN0IHBwX2h3bWdyICpod21ncjsNCj4gPg0KPiA+IC0JCS8qIFNJIGFzaWMg
ZG9lcyBub3QgY2Fycnkgb2RfZW5hYmxlZCAqLw0KPiA+IC0JCWlmIChhZGV2LT5mYW1pbHkgPT0g
QU1ER1BVX0ZBTUlMWV9TSSkNCj4gPiArCQkvKg0KPiA+ICsJCSAqIGRwbSBvbiBzb21lIGxlZ2Fj
eSBhc2ljcyBkb24ndCBjYXJyeSBvZF9lbmFibGVkIG1lbWJlcg0KPiA+ICsJCSAqIGFzIGl0cyBw
cF9oYW5kbGUgaXMgY2FzdGVkIGRpcmVjdGx5IGZyb20gYWRldi4NCj4gPiArCQkgKi8NCj4gPiAr
CQlpZiAoaXNfbGVnYWN5X2RwbShhZGV2KSkNCj4gPiAgIAkJCXJldHVybiBmYWxzZTsNCj4gPg0K
PiA+ICAgCQlod21nciA9IChzdHJ1Y3QgcHBfaHdtZ3IgKilhZGV2LT5wb3dlcnBsYXkucHBfaGFu
ZGxlOw0K
