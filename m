Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F41F8A171
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5264910E8B3;
	Thu, 16 Apr 2026 13:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tkvr5SLw";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA75F10E8B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLEEaq/OUFTN45gjW9bzmOaXD74gJGeiW2ws0h5uDsGrrqWg9Ms2penSCYM26mQtaWeof/ZOQLhn1KUeA5b+Mdyg83q5qFZUFKDxrtguIIky+2p9ZTiuxfowUIunJt2eE4v4xs4QoxWcq2jof8MixH32t5cQf306NIOR8tW5kY9QrAJkUN5tUuzvsbBV9XoTLznw27HgBOivDACR/EiOcAQZEhA5/sgQC1qr3/aVFFqHpZzUp7p1ebyEKhnWH0zBblXyyoaj0rJ7q9hjDo+BJSMBGknu4aPbeXooQvhE7dpSPKLDSrYbvWRgoJqBzLdSbUgk5nvnB9MQfzbbZADexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9tLJ8ScqNbGkH2lUmlPAiVm8BPpimlx+v4wj9UWfdA=;
 b=pVVjt+ZKqFzsGx85ScoaxaxFj57szEw9Ykwh/5QHc37tbXkF+ipXFFHmyFwvYJS97QpCwTmZEwzpwFkWN4N5Vuncx0Cv94VYkbetL5kpojPX8RvjN+G2dSHExseZmBbEHx7+EssJxvE8znkUuKJqie5Dk/UjomX0M7gQg/GlKUvWv2potU0UyFrtrHw0f6Qy4IV7Pzlflov8/hf2eKOAFq9udTKkE1bB8j0fpv9K6MNVABOChaV4D0Not0KFQdEJn7lkTqErszBtQXmn0G4HX7LAC/ag3saPdpum8YJ+QLT0NDvEzf8POzPQiGzWnMlDwY5usLNifX6g2j+UFxfa3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9tLJ8ScqNbGkH2lUmlPAiVm8BPpimlx+v4wj9UWfdA=;
 b=Tkvr5SLwfn/RpNmpP0Qk/x1oz96QhRV62qCXWfziBxGCu1/TX0UrI8XinpkAL0twxhDz2bd1OIu/C0Je9xbYDhCosF9G4kAeSJ1LuDK78xc9YBM8Vt4eZV1ZEaLGA95pIwZftOAKwSTZZLACi3PTFHPsXusFDd9/cWu4PCvP+oY=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 16 Apr
 2026 13:40:36 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 13:40:36 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
Thread-Topic: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
Thread-Index: AQHczVyb/ZJo5cnsmEyDtmdRYDIlarXhqoewgAAGdICAAAFiQA==
Date: Thu, 16 Apr 2026 13:40:36 +0000
Message-ID: <BL1PR12MB58987979B7D6C6B455D0B36085232@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260416045025.1825888-1-perry.yuan@amd.com>
 <BL1PR12MB58981E8785647FE677A7165F85232@BL1PR12MB5898.namprd12.prod.outlook.com>
 <CADnq5_NJGsGhP4vSrihAKPpey0hBAfKResXqq_mf3yk6Q5Pw5w@mail.gmail.com>
In-Reply-To: <CADnq5_NJGsGhP4vSrihAKPpey0hBAfKResXqq_mf3yk6Q5Pw5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-16T13:40:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH7PR12MB6588:EE_
x-ms-office365-filtering-correlation-id: 324ce4bf-0fdb-4838-1b34-08de9bbdbda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: RgoyElygTGTuVznRLr1XB2XSRrpNwFkFzwjfvolm98xk1VMZZe57AeGGxZkRInLBFjDG2W72kCVyzWZYwopqcyI34TJjE5IfpEvxIsQtmA67Lx5YqZP0d0c8P54JWkdtp27M/5+3KPhT3bp4eFcLo48wFVfbFudbowIG8Gn+ge0+3YEWyko3Sw/Fi/GnCcyFt+MmqLbIYuXe0rMZawMd8sKCYDoV5E+XOUE8zbNb4GpFgEx81x0eyRMgDMWpRJAQm7GNV2xFGwrDZ4JJAP1l4bE8jvhKh9yHBGPW7bp9hWI9wVK7crswAf75Ebwh2BATGGKYVhLib3abBwpsYdkkX1VV3oHlDhJmpuZGmYulbBgWICcgu8hX9JfrWze6dPe4KGnIcx8MT76IveftONy5SzQcL1PkrjU2CggH6OMd2VjeABu/913ZC8Zxvb6uMyXx10xNTi0JR9+p5U9KhuUpXQlNJa4sAGnGB8NUfC4S+ourojHXpzbDVIxKcueL4L8T2lpqHtuWIZw0s1jnfyupRFpEsjqMEbNt/Fxcgu5Xo9lhGbkgRTQ3q6d2KUCJMJatvTwyL+Sps7nJzRv/SAn9Km7b77GOAix26hHCUHiuAvZ8AA1wXNShqpVEY2D9U+HWYsa5Upb3D6Dib+EvGbiS41MO/3T8kj3TRM6PNxv+pgug+nopaEfl02/STtaIGHNNG0ul8uux1qFlp6kaCtl6OFwKl/D/heu7P6Poz7zKuD25SQbODvEk2ol6ST68W7iExbrqGMON02/827wfNoy60cnCcwpdSvxeSIGIeTelE3Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGhhck0vdHMyd1VnU3FBUk5Kd1VHQzA0bnlDWXJlWUI0RVhDenFKaldpUXNE?=
 =?utf-8?B?VkhWQ3RyTGZhdTVkRHFFU1ZpeU5Jb3lZTzFoYi83WU5XZ1VRVFI2NWhZc3BI?=
 =?utf-8?B?OVBHVTlMYVhTNzZyZHBvUVd0N1VKK0ZTUVl4eFRCVXVmWW5GREE2aGhDWnlq?=
 =?utf-8?B?TFR4VjBvQXQvcGI3TmFIVERxM0VzSDFkbk5zb1pYZFJmdDRsT1U5MnhQSmJm?=
 =?utf-8?B?MkJmVVRGTVlGS293eERFUlBMc3FiekZpbWozRVBiVXJlM1UvVkIrOFhCQXpO?=
 =?utf-8?B?bk5CMGVJZDFhQWJkNUpGcUlzeWp4NDc4TDNsTE9PM3NiZ1ZSRk9lY3JGQlpn?=
 =?utf-8?B?TXBKQjNISDE5K2FMMXA2MWZZMDBpcWFRZ05mY1pIbFBucEx4a0p5MWZVajd2?=
 =?utf-8?B?cG00dU5mTzNwTVFlSkF5c3FKRW12cnVEU09DalpKN0FhRk1yVCsrRjhwUGtx?=
 =?utf-8?B?VTFPakhXNlJVTDZOWStRWnpDUHRBU3BBeXVVMU1OZSs2Z0FJVE5vNW5tOGlL?=
 =?utf-8?B?L1V1anpEaW1Gam5pV3gwQWJzb1Z1bzNOQnJGV2JkRUNLWHo0NnNqRnhOTStM?=
 =?utf-8?B?TlRBcTdxTUl3VVZROCs1ZjUvZG5VL1h0QjR3eW05Z2x0b3kweW1mdFBWeEVF?=
 =?utf-8?B?TFNyVWZ4aGMxbGllM0lsWDlKazhpaUlwcjJvVHlYVzVTRjFXQXpMNEJ3ZmV5?=
 =?utf-8?B?MWdYU3ZjUTA0azg2RWlRU3dXZUV0YVptZktNcUJvVTV1MWFJSXArcllOYUZa?=
 =?utf-8?B?V1VVV2g1ekVjMEdldWI0K0dTV1Z6eW51K0RLN1RweXhGQ0Zsc2JhNTUzcDA4?=
 =?utf-8?B?SS85YkZaYWZCZ3QrYTlobmgxWVdwT2c3TWI3endjdkZGR0xON0pXMGc4SVhE?=
 =?utf-8?B?ZER6eEU0MUlzck1QS3FINFlqdVRzbjVRVDQ5RERKTEh5Y2xOVlVBeGN6WHZ0?=
 =?utf-8?B?VXc2cXl6VGdudDZqcGtYQ20yS0lLMzg1OFFVTEJrWEp4V2ZsK0h4RU1XM20w?=
 =?utf-8?B?QmswMy9kc1FpdElhZUVoNmMxU0YyNmxRYnFGTnVBZ3ptVmxKTjNPWXk5dGN0?=
 =?utf-8?B?eDEvWStRblBBTHNqYTIyVkZQY3hhakVxTVNWNmdKSGpMV2Z3MXFGakxDOW9M?=
 =?utf-8?B?bG80MVpBTk1SbGlETCtKWEhLWVU2Y1o2aGE3bWJVc0JUWmZET2Fxa0tMMHph?=
 =?utf-8?B?MmYySGRKcGZZb3JrVmQ1aVhjVEpRUTlLMk9DcTFia3JvNE1YSFpiWXBpMXRn?=
 =?utf-8?B?ZzNJQW5IWnl6RVNEREI5VUJLb2VleUs3cmFYMTEyaVlvU012T0xoZ1MvdVIx?=
 =?utf-8?B?WVJKT200blVjNVJOaGEwR1RXQngzMG1YOGRXSVI3akZDZXpoMmJoOElMR1Vi?=
 =?utf-8?B?WnhWa1BTRHhVUWFyZFRxNTFXOVZOWTNublNhSkNpd293Z1pvUS9vclcvUXdR?=
 =?utf-8?B?Z3JLNlAwcnlHRm1iU3pubjRlV3NEamxSTFRXemg4ZndWSjlPQjg4OVcxWFBD?=
 =?utf-8?B?alVxWkZJdnFvcURFbGl0VEZrU2I5amV5ci9DYlN1MUh1cjB2b3RrYmMwQ1NC?=
 =?utf-8?B?Zy8yb0pTcG1wMEVQSnZmYlVuZllodEo5enprQUZBeGJqMXV0eTFJK3BDa2FF?=
 =?utf-8?B?ZEx0ZS81MnlHNEV1T3FyOXcreDdSZUhqN3FZanhkbHlZa253K1RpY1hUZk5Z?=
 =?utf-8?B?Q0o2bHgxTG1OSDBGRDZTV2M0MzdkYkprRWJIcFU5UG5QN2c3YVZ3dTB6WFZs?=
 =?utf-8?B?dUVack9KL0p3Y0cwNTlzcWdQeFRNekdSS2xISGI1bVUvVEFyaXlOK29xT3Rn?=
 =?utf-8?B?SWNGVEM1NVRxdzBURzF0UW9TMmd5S1llQ1lqNmtWdUpTOUlqK1ZVZ3liMngw?=
 =?utf-8?B?M2lpdngzNzJoWmhSeGM1QjdicWtydTZFZnd4bTUrQ0tzSU5xU09oSERQdlRX?=
 =?utf-8?B?Q3RlKzhWMVVxQ0MzaUE3c2EwendKeFVady9PaXNjUEVxdlI5RkV1MUxNL3h1?=
 =?utf-8?B?a1hWRnBnSkdPNlJBK0huTFY3TmFMM2RseWJJYVMxL1BxaWcvaFBTSVA5aVVK?=
 =?utf-8?B?aVhDZ1k0TURDZVg3ZU5EY1l2WDRxQ2JiRkZDR0lFcUNMQkVFMmhpUDU4Q2lT?=
 =?utf-8?B?Q0RWcjZQWXRzOFBuVVB1NStoTDFvRTl1Ui9HOHExZko5ZmNVYUZtTVlkdVZS?=
 =?utf-8?B?QnRUcVJRM2pWVkJRaVJ3eVpweXJpY3BpRDU5OXc2U3A1QXFqV2l5dXFMM3NX?=
 =?utf-8?B?Y3grc0ZWeGZ5OEgwZm42YUhmZTNZSmxrSFFUQlFWcnF2Mml1MjVnZ1V5UWpt?=
 =?utf-8?Q?rFvP0bttRfv5sYL5Be?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324ce4bf-0fdb-4838-1b34-08de9bbdbda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:40:36.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/bkUdG4tp4OjOeriDx6oME6e5vnFVsAyaVShVPQ0LIlI+H/QNFht3prramonghct0fvU9FhhRx7K4ZcHD6HAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

W1B1YmxpY10NCg0KQWggcGVyZmVjdCwgdGhhbmtzIGZvciBjbGFyaWZ5aW5nLiBUaGVuIHllYWgg
d2UncmUgYWxsIGdvb2QuDQoNCiBLZW50DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAxNiwgMjAyNiA5OjM1IEFNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50
LlJ1c3NlbGxAYW1kLmNvbT4NCj4gQ2M6IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJt
L2FtZGtmZDogZml4IHByb2ZpbGVyIGlvY3RsIGNvbW1hbmQgbnVtYmVyDQo+DQo+IE9uIFRodSwg
QXByIDE2LCAyMDI2IGF0IDk6MzTigK9BTSBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1k
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVy
bmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gTm90IHN1cmUgaWYgc29tZXRoaW5nIGdp
dCBnb3QgbWVzc2VkIHVwIGhlcmUsIGJ1dCBpdCBsb29rcyBsaWtlIHlvdSdyZSByZW1vdmluZw0K
PiA+ID4gLSNkZWZpbmUgQU1ES0ZEX0NPTU1BTkRfU1RBUlRfMiAgICAgICAgICAgICAgIDB4ODAN
Cj4gPiA+IC0jZGVmaW5lIEFNREtGRF9DT01NQU5EX0VORF8yICAgICAgICAgMHg4Nw0KPg0KPiBU
aGF0J3Mgb24gcHVycG9zZS4gIFRob3NlIHdlcmUgbm90IHN1cHBvc2VkIHRvIGJlIGhlcmUgdG8g
YmVnaW4gd2l0aC4NCj4NCj4gQWxleA0KPg0KPiA+DQo+ID4gIEtlbnQNCj4gPg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBQZXJyeQ0KPiBZdWFuDQo+
ID4gPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjYgMTI6NTAgQU0NCj4gPiA+IFRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+ID4g
PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBk
cm0vYW1ka2ZkOiBmaXggcHJvZmlsZXIgaW9jdGwgY29tbWFuZCBudW1iZXINCj4gPiA+DQo+ID4g
PiBNb3ZlIGBBTURLRkRfSU9DX1BST0ZJTEVSYCBmcm9tIHRoZSBzZWNvbmRhcnkgaW9jdGwgcmFu
Z2UgdG8gdGhlDQo+ID4gPiBwcmltYXJ5IHVwc3RyZWFtIHJhbmdlIGF0IGAweDI4YCBhbmQgYnVt
cCBgQU1ES0ZEX0NPTU1BTkRfRU5EYCB0bw0KPiA+ID4gYDB4MjlgLg0KPiA+ID4NCj4gPiA+IEZp
eGVzOiA0YWJlOWZkMWU3NjMgKCJBZGQga2ZkX2lvY3RsX3Byb2ZpbGVyIHRvIGNvbnRhaW4gcHJv
ZmlsZXIga2VybmVsIGRyaXZlcg0KPiA+ID4gY2hhbmdlcyIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ID4gPiBTdWdnZXN0ZWQtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
IGluY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaCB8IDkgKysrLS0tLS0tDQo+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oIGIvaW5jbHVkZS91
YXBpL2xpbnV4L2tmZF9pb2N0bC5oDQo+ID4gPiBpbmRleCBkYTkzZGFhMzI4M2MuLjFhOTRkNTEy
ZGYzNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaA0K
PiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2tmZF9pb2N0bC5oDQo+ID4gPiBAQCAtMTcx
MSwxMyArMTcxMSwxMCBAQCBzdHJ1Y3Qga2ZkX2lvY3RsX3Byb2ZpbGVyX2FyZ3Mgew0KPiA+ID4g
ICNkZWZpbmUgQU1ES0ZEX0lPQ19DUkVBVEVfUFJPQ0VTUyAgICAgICAgICAgIFwNCj4gPiA+ICAg
ICAgICAgICAgICAgQU1ES0ZEX0lPKDB4MjcpDQo+ID4gPg0KPiA+ID4gLSNkZWZpbmUgQU1ES0ZE
X0NPTU1BTkRfU1RBUlQgICAgICAgICAweDAxDQo+ID4gPiAtI2RlZmluZSBBTURLRkRfQ09NTUFO
RF9FTkQgICAgICAgICAgIDB4MjgNCj4gPiA+IC0NCj4gPiA+ICAjZGVmaW5lIEFNREtGRF9JT0Nf
UFJPRklMRVIgICAgICAgICAgICAgICAgICBcDQo+ID4gPiAtICAgICAgICAgICAgIEFNREtGRF9J
T1dSKDB4ODYsIHN0cnVjdCBrZmRfaW9jdGxfcHJvZmlsZXJfYXJncykNCj4gPiA+ICsgICAgICAg
ICAgICAgQU1ES0ZEX0lPV1IoMHgyOCwgc3RydWN0IGtmZF9pb2N0bF9wcm9maWxlcl9hcmdzKQ0K
PiA+ID4NCj4gPiA+IC0jZGVmaW5lIEFNREtGRF9DT01NQU5EX1NUQVJUXzIgICAgICAgICAgICAg
ICAweDgwDQo+ID4gPiAtI2RlZmluZSBBTURLRkRfQ09NTUFORF9FTkRfMiAgICAgICAgIDB4ODcN
Cj4gPiA+ICsjZGVmaW5lIEFNREtGRF9DT01NQU5EX1NUQVJUICAgICAgICAgMHgwMQ0KPiA+ID4g
KyNkZWZpbmUgQU1ES0ZEX0NPTU1BTkRfRU5EICAgICAgICAgICAweDI5DQo+ID4gPg0KPiA+ID4g
ICNlbmRpZg0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+DQo=
