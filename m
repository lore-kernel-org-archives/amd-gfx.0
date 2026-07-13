Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E89C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 07:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C898410E569;
	Mon, 13 Jul 2026 07:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3lRtiRG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C08810E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 07:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC+yQQRP/6z9vK+K/JF3qWtVf5TLwTqT1phUUjvMlmjI/OvVe8HsLuEJdYApG2tpijAFGuLjfZH6esF/dZIZ4m5UpAbE/ETqxPkfcOT7rsV9nFQ6CJPwehYr7ZPP+eQR18lB9FDufXaGmauP2n3uw5wRSk0DG1FvUS92ukhlMDx+yNvJ9Soqnzm9wcii5MKQGCeh9xXt9ewmH698Nm+xPR4xcnpuCHLMKZAflFNlfrXvmplR75j4EJB9BI1aZrU7PVr9ge0Zuf0Slx+UTrUpWzl22Ji10TGBdp+iE66JUD8JlQS5MtUUE+yR6B0xMU8XydTSkhu2fPNc8mMhTgnK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYWYDX4MPRDZQQ0v5Qx5WajTu2CN+dxTgvYJ1xtYjUk=;
 b=j7pf/k8oDmkzm1EYsGHluhhlvmxyyRf0HKtMS2hzT8g8uIKDGPyE6OS17scr1wh0xBLvAT30lm2P/ZWSGlNvGS9YVRztuDL7xADOIpvKSX9TBBFXLmh1gNu9rqRRh71StZRV6jjMIrxCYTvEpohlpb/5zpdEzZtWt+LIG3r3133VK4LxNSGCqBiXxYSqwG6JB9sp8zO34IX2P6nujSrpN3jejoLA7W7vRyaqn7f8FtuynZENqP4hx8N75CEjoqZZLPca0TMGhu+tawsTvbmEOmhnRUdz78DrBneGUlV7KbdyOkS+DMjgeMtGDapz84Bc+wacDC34OX8xto97tkucsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYWYDX4MPRDZQQ0v5Qx5WajTu2CN+dxTgvYJ1xtYjUk=;
 b=d3lRtiRGbtUQKB6X1A9rjSHZ0DFsDGOlxCHcCZfiErSHN01nVwTmev0qyXO9GaseoOUGLPdh9TZPn2C7FvuI+MloYNMRHWy6TNlc+Z+LF/E4ufS8EYokXse72n7WI3zBKK5evW5D9RRTvvesnLvPlPnq74+nyuAEDEcDkRpLjX0=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.19; Mon, 13 Jul 2026 07:06:58 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 07:06:58 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, John
 Olender <john.olender@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Topic: [PATCH] drm/amd/pm: Fix pp_entries_max() bios check
Thread-Index: AQHdEoAu5kk8xWOkZESufTPc44VTJrZrANOAgAAGYxA=
Date: Mon, 13 Jul 2026 07:06:57 +0000
Message-ID: <DM4PR12MB574809955E76FF59A02E5C048EFA2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260713042902.2220454-1-asad.kamal@amd.com>
 <BN9PR12MB521171370A960563DAEE885C82FA2@BN9PR12MB5211.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB521171370A960563DAEE885C82FA2@BN9PR12MB5211.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: KevinYang.Wang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-13T06:41:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|DS4PR12MB9563:EE_
x-ms-office365-filtering-correlation-id: 3b966ae3-b61f-4f81-8e1d-08dee0ad5429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|4143699003|3023799007|38070700021|56012099006;
x-microsoft-antispam-message-info: txOyB/GgXWPHm/LkOI9xFRQZqqC0U23UqxAqSw28DOFxG2szpzrNu3JLBoshuT1z4K/Lv7gCipQVcRAWIhi123/V/EOhaf549uMpz+kaZClpaI3qJLMDPLxVCx4BjrF1WtapMyEplCNCVjmsPfwT3tp8G7f6lK9Cswn8tJCjKsE07bLT8KdRKnMI2NwBXTio25f+6qV2LiddIfXnAFjqVojV5IH9/2TvMw6ASKOifT32cAvDJlROYsYIaDeozgugdYVQZLUgkCQRTUvDdXd0MqH57h1v2ApPh+YAVjOxo0YwMeu+RV77CvoZhUhXRNt7j6tIjzQK3R4g+E+IZbtDm6V9gef33iQQgidgum6TgvYKPIpk9eEdGaWZ8J1ZpwRwHpbcMHjcz1hkUDU8vfn9FuUKiWGp8mCRiBjqWt7KOfWCUn9CUsOWJQToFnbo5o6pajqJAO5b/4z/fNL4efSB0RWZAUelpwlhd012azSZ8FFQ3P9DRz1thw2ReR642ipFm5JpgPLaHev7VtoBIMzwQPoXICEFk8qSXzF/3jRe/0LF3DrZM+zK+HNJgDqmnNEfh2O/y1BOaqw0aJxbtWVOKiy1yM+Vi7WvPSd9LEvlJ0NyKzxApNSgks2na6H8h2ISDw2CxLxgon/I+RnkJTY6jGIKwMjvubS7IXPHWjkSO8TzQ0Evkv0JNy0PS9zdKVntYXUViIJOiSw2Ypy3DlRefgqoWgrCYoHX6RmN/rpcJZ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2dDTCtkR0Z4R0F4T1pFbkhjNXhCb0djQTZvMWFPZFpncWF4U1ZEb3J3N3Fz?=
 =?utf-8?B?QW95NTRhVXM1VlFkUnVjYlE1Y1BraGlGUGF4bWtvTmlmMkMxL0RrVFQwdVd3?=
 =?utf-8?B?UWN3Z2tsN3owck00ZFYrUlNENngzZWYzUmhZWm10aTJWT3hZTE93VGJqMXRl?=
 =?utf-8?B?ZzI2NlNrb2k4YW1mTTdGVmEvUHVzWlJTUUYvck9mK0lyY3RISkJwdEd4bnNt?=
 =?utf-8?B?SHZtbDZqYXVHKzNGSG9wbHdkS1p6ZTltWlZ4NS9VckNCcUNYK1FyNmxQTElW?=
 =?utf-8?B?MFZGVFJQTVpkTVVUaWFiTkRSNS8xajQrR093eHdZWnhFVlJGanUxK2F6Y01m?=
 =?utf-8?B?ZFVXMnJRL0NubUZsWWZRNnRzU3JHamNVYndKY1VQak5pQVZudTBMT3A2bEs4?=
 =?utf-8?B?a0dOYkoyM24zNWFCdjYzaDJ5YmRDQnkyTkhWMTZzRURDWEJZZ3RiM1ZpWDll?=
 =?utf-8?B?MXVHdklnaGRHS0xxUmdQVXNFanVPL0dlREV2WlU3a0JSa0FndEhiY25kS1Fr?=
 =?utf-8?B?cnBYRmNqMTFwdkVPOFhmS05VeGRoU1JzY3VXeElsWUlFV3IxTjVUWEdBTXNx?=
 =?utf-8?B?SzNMRnFtVDVSVmc1aDg3SVBiR0Z1VnhBaXdrOWVhVEYrR081aHNzZ2RMc1dZ?=
 =?utf-8?B?L09NOGQwY1krTDR4ZUQrdWJ0RHZtcFZ3Y2gxMW9NU2l3SVZYelpLNkwwSEtx?=
 =?utf-8?B?dVc4bHRuelBkZzVVSWVmQnpIK2daRnBkM01sOUt5RzQwek1DMlZyNm56NFdC?=
 =?utf-8?B?S1pHOHl1LzVuSS9pMXg3OFZYdUp6anNZajlDT3NTTjdPYk4rVEFWUkc4ekg0?=
 =?utf-8?B?NU9hRXFvZkt6MUxJZ0VQaXhuTU1HdzQ5WWcyVmlkclAzM2NQQUdzMGExVEo4?=
 =?utf-8?B?eGpCUDJpVUJiRS8vd3g0TUIwaXkvbk9SRHg2UFYxSW14cXpMRG4ya3prUXZE?=
 =?utf-8?B?SFlVdTd0M0c5M1pKMi9adTVQVFdrd09kY0tLRXdKeFZPdEEyK3lSL2NITXU1?=
 =?utf-8?B?MWxFUnV2SlBiTHh4RVBLdGRXd1ZVOE9sY2xxNkx5UktKY3lEMlZsckVkY1Fz?=
 =?utf-8?B?UzFsQXFHRUNPYXcwbmdVall0am1iZTFOb3FhekNlNXdMZGk0Qlp4SGxTdW5T?=
 =?utf-8?B?QzF1UFRod2x6cFpvN3Y2TDd2TEdZMEFKbEdXV09pZUo1Y1QzaklPUCtwZGds?=
 =?utf-8?B?eFg2c3VWQWhFZTZrdjdsdXF4azdic01LSHJjZ0pJeW5HVCtRY0RnYWMvZk9G?=
 =?utf-8?B?S0tqL3l6ZHUvQnJkTVNSMDJLSThTQXFVZ1NHT3pJdmFMMEdZdkhHVVNpNlZS?=
 =?utf-8?B?UWpFUGUzZ0VZS3JwQllBV0dJRFZ5UCt0YnNvcytVS0c1N28zdEJoeG5ZeTRh?=
 =?utf-8?B?RlozYUxnNkV0cUxYVnBaSS9IT1pNci9aRHU2akpyOGFwb3lnZjRDR3RLT0tr?=
 =?utf-8?B?bVpoZ1NaWHlKWTRqaThkRGFueFhabUtHeFNicWhCaTNMbHl4T3ZoRzFvS2Mr?=
 =?utf-8?B?UnpSWFZPOFVzOUMwT1RpTWRpVzBxSDdVQ0FBc0RHa1gxb081RVU0UWlpaEQx?=
 =?utf-8?B?Tml3UGdEb2M0UXh6NFkwZVBWVHRoSlR5QzV2NUNnbHhrYXVibWppa01oTy9s?=
 =?utf-8?B?REZIRGFLeGQ3dVBxeVE4SSs2NEE3N1dmcmZKL2pWME5sWmovV0hXeitRTzFh?=
 =?utf-8?B?a2I1NmVMbWkwTlVqUmJ6WDRzV1htK2tGeWtjQklrQllTdG4rODRseFhCS3Nx?=
 =?utf-8?B?cTEwSGt5ZWFtc0drbk04MjA2b1hLQi9WaThZaHZYZXNBV3U0ZGkySFhtcWtB?=
 =?utf-8?B?YmpIT1A2SlZrWnVtWGZ4SldYa0lRT01IS09sVytaTEl5UG5yQ0JaUjJCNUwx?=
 =?utf-8?B?WmZUVUNSSWd6b0ZTYVl5aUJIaDR0U2wwZ0ozdWVnVHdFVEo5ZFduY3AyU2RS?=
 =?utf-8?B?Y2ZCc2JmWXRxRlhLZ2d2eldxeXhvWkdpOWRFNTF2cVZNUVRPWFVDRWVaaEg0?=
 =?utf-8?B?dmlXZFRFUUFBa3ZOR2h3LzdmaXF4TXBsWXppdzBvWWxKa3g5aFFxUnFRODZa?=
 =?utf-8?B?TzJOTzdPRnRNQncraEdoeVhya2RhZThmVGlXRVRtU0RBbmN4Y2JVdjdlVHFP?=
 =?utf-8?B?TmFSdFpMb0ExVDhGU2hoN1grSU5EVkxrVVFZZ0o4YUNDRUxVY2hJWEIvN1hU?=
 =?utf-8?B?cUkrNHc2VTdVbUZQVXBiQTMxaU1yRkRKeTd4V2RyR0pSYllwSEU1Tk5JQ3o3?=
 =?utf-8?B?b2pMeUhueS9hL2VGaHBlaFFaK3BhZGJ2bzBFbzZnN3o2SUFHYk4zMlZiSytW?=
 =?utf-8?Q?ZJh5tuYp6IAOKMW/ef?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b966ae3-b61f-4f81-8e1d-08dee0ad5429
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 07:06:57.8684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+iJtQ8tAABZNooik8KTI1VhNLmogE0YKI8dB6olf7UpgnBsXhMUAyI/9/2PNG5khcUNewJ0AVxAHmYUDxyT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
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

QU1EIEdlbmVyYWwNCg0KSGkgQFdhbmcsIFlhbmcoS2V2aW4pLA0KDQpXaWxsIHJlbW92ZSB0aGUg
Y2FzdCBiZWZvcmUgcHVzaGluZy4NCg0KVGhhbmtzICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5X
YW5nQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEp1bHkgMTMsIDIwMjYgMTI6MTMgUE0NClRvOiBL
YW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCkNjOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IFpoYW5n
LCBNb3JyaXMgPFNoaXd1LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBKb2huIE9sZW5kZXIgPGpvaG4ub2xlbmRlckBnbWFpbC5j
b20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL3BtOiBGaXggcHBfZW50cmllc19tYXgo
KSBiaW9zIGNoZWNrDQoNCkFNRCBHZW5lcmFsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS2FtYWwsIEFzYWQgPEFzYWQuS2FtYWxAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKdWx5IDEzLCAyMDI2IDEyOjI5IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFpoYW5nLCBI
YXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+
OyBaaGFuZywgTW9ycmlzDQo+IDxTaGl3dS5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsNCj4gV2FuZywgWWFuZyhLZXZpbikgPEtl
dmluWWFuZy5XYW5nQGFtZC5jb20+OyBLYW1hbCwgQXNhZA0KPiA8QXNhZC5LYW1hbEBhbWQuY29t
PjsgSm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvcG06IEZpeCBwcF9lbnRyaWVzX21heCgpIGJpb3MgY2hlY2sNCj4NCj4gQ29t
bWl0IDNjZmU0MzM2MzA1MCAoImRybS9hbWQvcG06IFVzZSB1cGxvYWRlZCBzaXplIGZvciBsZWdh
Y3kgY3VzdG9tDQo+IFBQVGFibGUiKSBjaGFuZ2VkIHBwX2RwbV9zZXRfcHBfdGFibGUoKSB0byBr
bWVtZHVwIHRoZSB1cGxvYWRlZCBidWZmZXINCj4gZGlyZWN0bHkgYW5kIHNldCBzb2Z0X3BwX3Rh
YmxlX3NpemUgdG8gdGhlIHVwbG9hZGVkIHNpemUuICBBcyBhIHJlc3VsdA0KPiBzb2Z0X3BwX3Rh
YmxlIG5vdyBwb2ludHMgdG8gYW4gYWxsb2NhdGlvbiBjb21wbGV0ZWx5IG91dHNpZGUNCj4gYWRl
di0+YmlvcywgbWFraW5nIHRoZSB1bmNvbmRpdGlvbmFsIHBwX2VuZCA+IGJpb3NfZW5kIGNoZWNr
IGluDQo+IHBwX2VudHJpZXNfbWF4KCkgYWx3YXlzIHRydWUgZm9yIGN1c3RvbSBQUCB0YWJsZXMg
4oCUIHNpbGVudGx5IHJldHVybmluZw0KPiAwIGFuZCBicmVha2luZyBQUCB0YWJsZSBvdmVycmlk
ZXMgdmlhIHN5c2ZzLg0KPg0KPiBGaXggdGhpcyBieSBjb25kaXRpb25pbmcgdGhlIEJJT1MgY29u
dGFpbm1lbnQgY2hlY2sgb24NCj4gaGFyZGNvZGVfcHBfdGFibGUgYmVpbmcgTlVMTC4gIGhhcmRj
b2RlX3BwX3RhYmxlIGlzIHplcm8taW5pdGlhbGlzZWQNCj4gKGt6YWxsb2MpIGFuZCBvbmx5IHNl
dCB3aGVuIGEgY3VzdG9tIHRhYmxlIGlzIHVwbG9hZGVkIHZpYSBzeXNmcywgc286DQo+DQo+ICAg
LSBoYXJkY29kZV9wcF90YWJsZSA9PSBOVUxMOiBWQklPUyBwYXRoIOKAlCBlbmZvcmNlIHBwX2Vu
ZCA8PSBiaW9zX2VuZA0KPiAgICAgdG8gcmVqZWN0IGEgbWFsaWNpb3VzIFZCSU9TIGluZmxhdGlu
ZyB1c1N0cnVjdHVyZVNpemUgcGFzdCB0aGUgQklPUw0KPiAgICAgaW1hZ2UuDQo+DQo+ICAgLSBo
YXJkY29kZV9wcF90YWJsZSAhPSBOVUxMOiBjdXN0b20gdXBsb2FkIHBhdGgg4oCUIHNraXAgdGhl
IGJpb3NfZW5kDQo+ICAgICBjaGVjaywgc29mdF9wcF90YWJsZV9zaXplIGlzIHRoZSBrZXJuZWwt
c3VwcGxpZWQgdXBsb2FkIHNpemUgYW5kIGlzDQo+ICAgICBhbHJlYWR5IHRydXN0ZWQuDQo+DQo+
IEZpeGVzOiBlMzBiM2UzYWI1MWEgKCJkcm0vYW1kZ3B1L3BtOiBhZGQgcHBfZW50cmllc19tYXgo
KSBoZWxwZXIiKQ0KPiBSZXBvcnRlZC1ieTogSm9obiBPbGVuZGVyIDxqb2huLm9sZW5kZXJAZ21h
aWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaW5jL2h3bWdyLmgg
fCAxNSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9pbmMvaHdtZ3IuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJw
bGF5L2luYy9od21nci5oDQo+IGluZGV4IDdlYmMxMzQ0MDIzZi4uYTIzZTAxOTIxODQyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9pbmMvaHdtZ3IuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9pbmMvaHdtZ3IuaA0KPiBA
QCAtODMzLDE0ICs4MzMsMTcgQEAgc3RhdGljIGlubGluZSB1aW50MzJfdCBwcF9lbnRyaWVzX21h
eChjb25zdA0KPiBzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCB2b2lkICpzdWJfdGFibGUsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBoZHJfc2l6ZSwgc2l6ZV90IHJlY19zaXplKSAg
ew0KPiAtICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqKWh3bWdyLQ0KPiA+YWRldjsNCj4gLSAgICAgY29uc3QgY2hhciAqYmlvc19lbmQgPSAo
Y29uc3QgY2hhciAqKWFkZXYtPmJpb3MgKyBhZGV2LT5iaW9zX3NpemU7DQo+IC0gICAgIGNvbnN0
IGNoYXIgKnBwX2VuZCAgID0gKGNvbnN0IGNoYXIgKilod21nci0+c29mdF9wcF90YWJsZQ0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICsgaHdtZ3ItPnNvZnRfcHBfdGFibGVfc2l6ZTsN
Cj4gKyAgICAgY29uc3QgY2hhciAqcHBfc3RhcnQgPSAoY29uc3QgY2hhciAqKWh3bWdyLT5zb2Z0
X3BwX3RhYmxlOw0KPiArICAgICBjb25zdCBjaGFyICpwcF9lbmQgICA9IHBwX3N0YXJ0ICsgaHdt
Z3ItPnNvZnRfcHBfdGFibGVfc2l6ZTsNCj4gICAgICAgY29uc3QgY2hhciAqZW50cmllcyAgPSAo
Y29uc3QgY2hhciAqKXN1Yl90YWJsZSArIGhkcl9zaXplOw0KPg0KPiAtICAgICBpZiAocHBfZW5k
ID4gYmlvc19lbmQpDQo+IC0gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgIGlmICghaHdt
Z3ItPmhhcmRjb2RlX3BwX3RhYmxlKSB7DQo+ICsgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKilod21nci0+YWRldjsNCj4g
KyAgICAgICAgICAgICBjb25zdCBjaGFyICpiaW9zX2VuZCA9IChjb25zdCBjaGFyICopYWRldi0+
YmlvcyArIGFkZXYtDQo+ID5iaW9zX3NpemU7DQoNClRoZSB0d28gZXhwbGljaXQgdHlwZSBjYXN0
cyBhcmUgdW5uZWNlc3NhcnkgYXMgSSBrbm93OyBwbGVhc2UgZG91YmxlLWNoZWNrIHRoaXMgcGFy
dC4NCg0KQXBhcnQgaXMgTEdUTSAsIHRoZSBwYXRjaCBpcw0KUmV2aWV3ZWQtYnk6IFlhbmcgV2Fu
ZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCj4gKw0K
PiArICAgICAgICAgICAgIGlmIChwcF9lbmQgPiBiaW9zX2VuZCkNCj4gKyAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiArICAgICB9DQo+ICAgICAgIGlmICghcmVjX3NpemUgfHwgZW50
cmllcyA+PSBwcF9lbmQpDQo+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgIHJldHVy
biAodWludDMyX3QpKChwcF9lbmQgLSBlbnRyaWVzKSAvIHJlY19zaXplKTsNCj4gLS0NCj4gMi40
Ni4wDQoNCg0K
