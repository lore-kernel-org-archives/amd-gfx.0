Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42F7C2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 04:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CB210E3C4;
	Fri,  7 Aug 2026 04:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypxQ5loD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2AF10E3C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 04:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ombvDcVxmlxJ6LnTkwzBQltn5Qx+1QFsfK1K6U2UZigNgbKg/IU9NlwT1UUg4jlg8PnvI7v+pYy5WRFugGmDd0zhQ0PTiDLV5pGHHBaK032wvXaEo1c0FOB56cpAhenS6hBj9pesj8VO8/+smpIDElJLKNOqi5GL/Hq+pfuii12X5mmKJYH8fGC0NA3vT1/ui4pTjaiCVj0YFRZ1s/fvohNiNeMcj2LVxTKggeKbkQzE1hydZeGNfGpBLsWZ8ALx8y+JVgIvxvYqJ307NWdX69YcpnWthRqs9o1ez9zedR82wx3q3XHK3hLb0y2DOK/VHd+bl1A4XD/7Y47qTBjZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP94Qze2Kt7zx4cKPvpJN83rdJ6zLetKvG7HA2+vY7Q=;
 b=DlUKK71uKBfKHDS+mFit7QtLoJuvGYLd+Lu95fCzxDTBsVzha1mXwZmk0bIk2CM7V9pLT0ZwTDt9m5QalYwVxDkFCf8QH0dZcir4kBjvNixl29Kh/1YCrhrIXoMjCFjU7tcHLdPXZ9TtJqCkKo7pQ3M1oXbJfqZV0ZVzC00vAidNfj01NhL3iyvIQ/Mc86qOG1TW+S8LQjLc0sV8ftpunT7JCq/oJ0I4f4nZwEJ9zUUTvxTUw0lrkD+gTSgjXQm2DNuJQAJ3ROXo05H7MzQRbilAfy5wIOSmRC8nV6S5/7Mzf1blbCBminXScg4VSBdYWAYroPwHmMa0/XDaRgMC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP94Qze2Kt7zx4cKPvpJN83rdJ6zLetKvG7HA2+vY7Q=;
 b=ypxQ5loDumG+k0oYyypKdcXA8zmCkfygl/xYs2w1VGgpSGIuaLarsniloegZ4G4gM+5mB8WSPvow22Hx1XCEWSdle1SGmjCYXR7NmJnvh3okhyrAWVbGjE/Syd9gd8rfsxReGkIgpz1kEegoEnYnLl/1ODTR1qfIeKE++bQg/RU=
Received: from CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 04:19:42 +0000
Received: from CYXPR12MB9443.namprd12.prod.outlook.com
 ([fe80::49ca:bb98:444a:d992]) by CYXPR12MB9443.namprd12.prod.outlook.com
 ([fe80::49ca:bb98:444a:d992%7]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 04:19:42 +0000
From: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
To: "Milind Sardeshpande, Shubhankar" <Shubhankar.MilindSardeshpande@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable GFXOFF functionality for SMU IP v15.0.5
Thread-Topic: [PATCH] drm/amdgpu: Enable GFXOFF functionality for SMU IP
 v15.0.5
Thread-Index: AQHdJacfKOiosK3rC0+VHk5Yrx142baSWMIA
Date: Fri, 7 Aug 2026 04:19:42 +0000
Message-ID: <CYXPR12MB9443824DB37011C9B3AF20C280D12@CYXPR12MB9443.namprd12.prod.outlook.com>
References: <20260806132526.2810055-1-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260806132526.2810055-1-Shubhankar.MilindSardeshpande@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: CYXPR12MB9443.namprd12.prod.outlook.com
 (15.21.0292.011)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9443:EE_|SJ0PR12MB7068:EE_
x-ms-office365-filtering-correlation-id: 3cb98a7a-8579-4640-620d-08def43b1ad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: n4Lr3+dIjc71b6M4seRNOolFYWPHckUkEuDJV0u0Trk7RqwG++gL9X621QNuZ3fDzZAu3U+P49kGwI6N8GJ0/Z4cMrblzUDdGoqmJPOYow/F6NsW8f92S+PCJ1tBXBGYuMaR5Oiua42GU/8v4M0KUnIYwnzuEyyUDzCsTspCnR4FkQ1NWcU3CPs/IcIOcgYLkq//BIIrowZbJeEvW1X9qa3+6eueujAlrr6TPBMVqtXPyQRTQhFg4aR1AP6X7yFeypAw718rUdd1Lr94Wl11V0RfLX0M7814jryi72RZFMT9ZoqI4IUzxhAr8bu5/dO4bmK9yd61i0ZGQCETROJz6Fn2TYArl4bIMUW/yVe7nCux1z37CdOFTDf+WrjGoPlNwEEwZYiYDj8B7NVcopT4IGjotrtxSaMEoSWf7eRqhEH7UKeoSPwaQZQFRpjx/T4WgblmAnOjDx9jTZynTRhhtQZ+eU0qM14vKLB+ju3fmEHYYsJOT3mlfj38jK01/WhUD1RKnuv2vmIl/QxhqeBG4jEowTTfW0xA65V35AE8HJtvxAWQiKvAOhTq6iYCMFJ0CNlbOTXCIAc5S9ZWt7EyCwohbrgutYC5zqhVIcp9sNBBzUT4I9gkUIPamMNRSVzuq+Yh5f/JX1Tk06HJH125XIkLC3dLhkk2ncZu2LYXMEoo5TqKPh/mEeuSniKGsfoqFIQGMz2UYW7Q93nCYpjH5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9443.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFJnOUdTU2xkc3I2d0lrdGpTaDdpWkxZS1VsSi9BbFJBZStsRWxZL1Ywc2tC?=
 =?utf-8?B?ZExBbVJNNi8rMjJzRWNBb3llNWZSNlI1Y3lGdGFNejlVdXl1V1F3dkYxWEpU?=
 =?utf-8?B?bW0zOWJ6NThXOGVZSGpLY2l4WXBzS1QrQ2lEVmxqZzZzcmN2SVh5NU1PN0h4?=
 =?utf-8?B?WUtjYjE1NWwzWnREcE8yS1Q2N2JEWFFBUUovMkhiNG1TVTd3ZGRJVnhqekU1?=
 =?utf-8?B?RnNjclh5NDg2RWxSNUcxdXlFYmM0VWgyMVpHMDNkb2p3dDVQWmc4ZWh6LzBv?=
 =?utf-8?B?Y0d1dGhXazlCU3FOK0JvS1dWRzJYNE9XQ3RZQlRQZm5oWXZOV2JOczQ0UmtC?=
 =?utf-8?B?S29yNVp5RGlKVXhyeG52NlpFYlBwR0d4cG41alhKZ09WclBnbFZrV24rMXBs?=
 =?utf-8?B?SFkveUJnRkZ2WmRaVjVzMEVoT29FRkRuSTVLc2dtWmxreHhsNE1RMG5Mekg4?=
 =?utf-8?B?QWg4amt4WDFwNVNuK2svdCsvWDZRZ1g1cFQ1R3gyNXQxdmNWenMzMEoxdUQw?=
 =?utf-8?B?aXBmYllXWWMrVzh2MUU5eEp3cXhqK0F5dm5xWFErRm1KV2p3N0lwT2ZDaStM?=
 =?utf-8?B?WW5aTHFxWEtEZnNRNXdsN0NpeU5PNnZPMWhudllCWGxFeXh2UjRUU3BDNVRS?=
 =?utf-8?B?YXBtanNoTXpSYko0ZUJoc3YyT1JUUWsxaS8wSFJBZW53VnAvMGozTEJJVk1D?=
 =?utf-8?B?QWVQSG11YmFTelJvazdLR2VRYnMwREpiM3pHNkFES0gwSGZpSHVtUW1JWjNj?=
 =?utf-8?B?T3JQUUVRS3lPZXE0NEpyQVhVM2J6bzk0eWwvSUlZc042OXoyZTBvV2pmU2RF?=
 =?utf-8?B?MVhFaFB4bkY1K2hvRkdpczRJQ01jdExLL0x5U2wwdGxuNmlGT1ZWNDIwZnFs?=
 =?utf-8?B?d1pSczd6cDVjZlpUNVg2THlSZlFaWFVkenI2bUFLV08zZlVDbm5QZDIxLzNC?=
 =?utf-8?B?MStCOHNCT1FUaHZoR0FWS1Z4ZkxhWGdIL0dwZ2JBcGhsdWpKaFJkUTdKQjY5?=
 =?utf-8?B?ckkzZmdJY1I0ejl6WVhXUS9kYlFYVGtGT1U0R0ZFZ3NsYzFrUC9UYUdnWS9F?=
 =?utf-8?B?OUVXVzc4KzlxWFdETS9RQXpsUDJSTDJiYWVSMjRVbDlrMEttVml5Tm8yYmI3?=
 =?utf-8?B?Q2VoUzdveTcrMjliWThiOGFuWnNnemQzMWJGMUhOK0JaRDgrcjZGWjFKNGJO?=
 =?utf-8?B?ZEdvcEV6S0I5SW1pMm5sUmorampSSjlncGgzTVA3dlpVbGxxejUvWU9vQlAr?=
 =?utf-8?B?STdPRzArM3h1UHpYQ1pVREhJOVdPb2xJL09hWk80TTVKQmJaR3BBYzNXSXZ2?=
 =?utf-8?B?QVpuUzIxTHB4UGhSOCtVWGpRaStrRHE5RzhCSzg3VjF1N25ReEtxSGJtQXZz?=
 =?utf-8?B?VEpCWGlMWCtScTcvZXpTVkVtS1l2bXZpVjB0SHU2d2NCVWx1a3llTk8vRFZv?=
 =?utf-8?B?WnBiSmhLYUdWejRpR3dFSFd6OE1YZEpyb2lra3VkK2NXRXpmQU92djZZZUt5?=
 =?utf-8?B?Zm1NSXpQOVlOYnVybHN4ZFJ5U0Y0QVVTKzU0U2JJSG5reHJTQitxS3BHOEN2?=
 =?utf-8?B?ZWxlS2pZMCt5NUl4TGlYaUhIcXpkMVBJRWp4bUc4d1RGMnVrRXBUdFlubWt1?=
 =?utf-8?B?KzlYVXZDS3R0aWhZaURjVzdEUUVPMVlDT3ZyM2tUUHhrQnFSZFMzY1JQSDM0?=
 =?utf-8?B?NG5PN1hHUUU1K1RGOFNBZnhPNTBFVFAybUlTU09MVFpOa2lCTlF3Z0JVQmtK?=
 =?utf-8?B?UVQ5dWxvN1djN25RZmpmNzQ0RGNxL3NKWENyR1o1ZmFZNGpMdWozaE96ZkI4?=
 =?utf-8?B?cXlEU2Iwb1M4emhVeEJRR1g5ZUQxRllKUklUalpCZnpldmE1ak0xeVp5UlBn?=
 =?utf-8?B?R1dlbWJFeG5BbXArcU5adlNlTW5GWkdpS3BISWt1R2gxOTBBVy9DOWhBdm1L?=
 =?utf-8?B?OE9kWFVRdU9DY0FxaXgwOTBFYUdxblRHWFJEOGxPcFNYRkt5T2lMZ3pkKzBZ?=
 =?utf-8?B?ZGZjSWRGcWNyNWxNZHZGLzMrUWU3R1dSb1BMcVhhNERjcVBhby9VVnhuY3dE?=
 =?utf-8?B?YTN0TWhUV0duRllYdDhab01WdlE4cFRtaTdEUm5rbzg4SlZzMkdHWEtRZmF0?=
 =?utf-8?B?OXQ4YUJPQi92ekFtNS92SnRuZk52UEpIMHpCcG9uTlhIY01Ubjgwaml4R1N4?=
 =?utf-8?B?NkRaWmpvaEw2aktJa2wyQ05nWGJUTWg0bldncEdRcy9ZMmJ4NVlzclE1K092?=
 =?utf-8?B?TlMwcVkveXVweUNGa1Z4cWxrblhqMVN1QkxxRUNKYjFwc0ZIenRMTGpyd2o0?=
 =?utf-8?Q?bVJBEWUqvUWE1St/Md?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7685DFBAC8C9645B86ACF75F6DADE40@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9443.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb98a7a-8579-4640-620d-08def43b1ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 04:19:42.3249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiwyYe2UaIUcguMhvHr9q07XZML9gGXffkfVSlNvgUKTkgh6fFtx4XLN/auMaSdWKHQGSxMVvSRdKNTYN4DGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

DQpPbiAwNi0wOC0yMDI2IDE4OjU0LCBTaHViaGFua2FyIE1pbGluZCBTYXJkZXNocGFuZGUgd3Jv
dGU6DQo+IEFkZCBjbG9ja2dhdGluZyBhbmQgcG93ZXJnYXRpbmcgZmxhZ3MgZm9yIEdDIDExLjUu
Ng0KPiBhbmQgYWxsb3cvZGlzYWxsb3cgR0ZYT0ZGIGZvciBTTVUgMTUuMC41DQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFNodWJoYW5rYXIgTWlsaW5kIFNhcmRlc2hwYW5kZSA8U2h1Ymhhbmthci5NaWxp
bmRTYXJkZXNocGFuZGVAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBQcmF0aWsgVmlzaHdha2FybWEg
PFByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MyMS5jICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKy0tDQo+
ICAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE1L3NtdV92MTVfMC5jICAgIHwgIDEgKw0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+IGluZGV4IDFmOWE5YzQ2Mzc3YS4uNWE2
Yzg0YzgwMmY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2My
MS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCj4gQEAgLTgy
NSw4ICs4MjUsMjUgQEAgc3RhdGljIGludCBzb2MyMV9jb21tb25fZWFybHlfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAJCWFkZXYtPmV4dGVybmFsX3Jldl9pZCA9
IGFkZXYtPnJldl9pZCArIDB4MTsNCj4gICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAJY2Fz
ZSBJUF9WRVJTSU9OKDExLCA1LCA2KToNCj4gLQkJYWRldi0+Y2dfZmxhZ3MgPSAwOw0KPiAtCQlh
ZGV2LT5wZ19mbGFncyA9IDA7DQo+ICsJCWFkZXYtPmNnX2ZsYWdzID0gQU1EX0NHX1NVUFBPUlRf
R0ZYX0NHQ0cgfA0KPiArCQkJQU1EX0NHX1NVUFBPUlRfR0ZYX0NHTFMgfA0KPiArCQkJQU1EX0NH
X1NVUFBPUlRfR0ZYX01HQ0cgfA0KPiArCQkJQU1EX0NHX1NVUFBPUlRfR0ZYX0ZHQ0cgfA0KPiAr
CQkJQU1EX0NHX1NVUFBPUlRfUkVQRUFURVJfRkdDRyB8DQo+ICsJCQlBTURfQ0dfU1VQUE9SVF9H
RlhfUEVSRl9DTEsgfA0KPiArCQkJQU1EX0NHX1NVUFBPUlRfR0ZYXzNEX0NHQ0cgfA0KPiArCQkJ
QU1EX0NHX1NVUFBPUlRfR0ZYXzNEX0NHTFMgfA0KPiArCQkJQU1EX0NHX1NVUFBPUlRfTUNfTUdD
RyB8DQo+ICsJCQlBTURfQ0dfU1VQUE9SVF9NQ19MUyB8DQo+ICsJCQlBTURfQ0dfU1VQUE9SVF9I
RFBfTFMgfA0KPiArCQkJQU1EX0NHX1NVUFBPUlRfSERQX0RTIHwNCj4gKwkJCUFNRF9DR19TVVBQ
T1JUX0hEUF9TRCB8DQo+ICsJCQlBTURfQ0dfU1VQUE9SVF9BVEhVQl9NR0NHIHwNCj4gKwkJCUFN
RF9DR19TVVBQT1JUX0FUSFVCX0xTIHwNCj4gKwkJCUFNRF9DR19TVVBQT1JUX0lIX0NHIHwNCj4g
KwkJCUFNRF9DR19TVVBQT1JUX0JJRl9NR0NHIHwNCj4gKwkJCUFNRF9DR19TVVBQT1JUX0JJRl9M
UzsNCj4gKwkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9HRlhfUEc7DQo+ICAgCQlh
ZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweGQwOw0KPiAgIAkJYnJlYWs7
DQo+ICAgCWNhc2UgSVBfVkVSU0lPTigxMSwgNywgMCk6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE1L3NtdV92MTVfMC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxNS9zbXVfdjE1XzAuYw0KPiBpbmRleCAxNGQwZWIyOTZhMDAuLjRj
MDIzNjE5NmRlNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxNS9zbXVfdjE1XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTE1L3NtdV92MTVfMC5jDQo+IEBAIC01ODMsNiArNTgzLDcgQEAgaW50IHNtdV92MTVfMF9nZnhf
b2ZmX2NvbnRyb2woc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlKQ0KPiAgIA0K
PiAgIAlzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE1QMV9IV0lQLCAwKSkgew0KPiAg
IAljYXNlIElQX1ZFUlNJT04oMTUsIDAsIDApOg0KPiArCWNhc2UgSVBfVkVSU0lPTigxNSwgMCwg
NSk6DQo+ICAgCWNhc2UgSVBfVkVSU0lPTigxNSwgMCwgOSk6DQo+ICAgCQlpZiAoIShhZGV2LT5w
bS5wcF9mZWF0dXJlICYgUFBfR0ZYT0ZGX01BU0spKQ0KPiAgIAkJCXJldHVybiAwOw0K
