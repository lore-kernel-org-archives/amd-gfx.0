Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E79C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B4110E181;
	Mon,  6 Jul 2026 18:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jd9Cpzfr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A577B10E181
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNEykwPlwbZRHhYyDKxBy4ipJ/nQhzr17dfybKf+bT2BvX4cE8ZiEt4eA/b4FPx3qkUw237VWQBAE2zHxacsmpRoRoqZ3G+zv0c3jkIapR1s2dylcN+yez/CMWXFhfCFKILLHEFbsmxkDOQmczwE0RLHXFqke/eXTXtWVoFDHMf5xtdEOoieygjKkhoiTiizYrdhEyS7i3qP6ns77eGRM9byS+T8C7B9B4dBJuVOkfCu0FKLN5D6qoAQ2eOg0hrkV6IQaETWRxWBTz4WXRKFRA4aVutREY5slwglOiSnBxEaxjGvIGv0ilAI1WPr5HYrkEn257a0jLZaTWh799aeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpK10pr3sudgOtYjdWCVHlUn/gthQ/aKajGMEWcBUTc=;
 b=jkZTKWzVsuxzGMOqMaMszDJZsX47xgYdJqn1clfhOjpcbEadLzaQYoIjX7AHhDjY8KpKYXjfDmolvW1XE2He6mh9M6DTRXltRvoP/VRm9LoSO30cCQxNeinH6Sa3lyAW3sIqBpn3/o7DJRfeiK+AehwEwqFVQzBe85YRbvnsLBaza+iw31iGiNSyK/6AzM33wJdlwJByeF340Q1F6WAYdFGpzHcX7U0u9aIZWVR8SvCsyaI9CqJDc5qhtJ643LSSf7YXBOLVhAlLb+RpVDziqELBXxaL/ibP/otxpKxH6qKBu+L1MJyj7FKVmhadQNurfp6DJRGXTHod3vre65fddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpK10pr3sudgOtYjdWCVHlUn/gthQ/aKajGMEWcBUTc=;
 b=jd9Cpzfrd7IiptoPmV8TsiCxIrgaNPGyFWaZFmskgWVpBHtSL6KiijZtG6gTqil4yO0G1/UK0gvCa7byiObkX3ah0/+SD+DXcdNEUk3sKhXJ7BqWVf48WhvedKqZCMLliNnyIoP5lOu7fxbrsWHr9fFs1915l+v5RWXc1aVoHz8=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 18:04:49 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 18:04:49 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Shetaia,
 Amir" <Amir.Shetaia@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Topic: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Index: AQHdCXUtrYxinPp64U66GHiN0PlGWLZcCLKwgAAc7ICABKbRIA==
Date: Mon, 6 Jul 2026 18:04:49 +0000
Message-ID: <BL3PR12MB6425480A86F7104104D58B0DEEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <BL3PR12MB6425244AF10CABCDF2A131D3EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3281153.KVeVyVuyWN@timur-max>
In-Reply-To: <3281153.KVeVyVuyWN@timur-max>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T17:48:38.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DS0PR12MB9421:EE_
x-ms-office365-filtering-correlation-id: dca08054-0f9f-49ab-9d23-08dedb8911f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|38070700021|56012099006|11063799006|921020|4143699003;
x-microsoft-antispam-message-info: u7hrtZuWf3EG8/VauUlXVn1rvOVOQ7CgAIn+QZC+tu1ZO0gU02Uem3ppT+rXWT9uPEIOSyRRH6Nm2xHLKQ56N07GO/vqs8bfWpnFJnAXmqNqFl4/5s9Ge/mhN9bVEjtwVu6IGwVJo/e4YbSMzADESZnvcvIbxZcodIKyIrYVBzVLEwkO9e/Enlv57BKK8JlakxTQenab8l8sue80nP8j9Rv2htBgNM2C8yfSsY0wCMnxssve3CvSFhQBCFbO/Ce3V3xISv0c3hzheBi8RlFz278DUuqzs3lKfxZuf8ZuqEeUBsEEcFtKNmbB2v4G7dTDgZeqTtEfqpCMzgFX/XxCj7QI8Q2C2LfUYrVaBkgUF/3S/3pCa7j1aTBkXK64/oqoV37EoBsiPV34BlimBdKvM+A37luJQw9ob6BTERI9n2uXWSLoc0XTAjGQXkn8qGEheeSDIc0QOwJ4+QbtPzRk/IJQwzuR4LjngddLPJew9XtmgLeowvsd7SYl85+X/ZRPNBvCg8zYAvz2N75e6nhxCVTc/ORxNSb6mWROxvuEfsCzUqHPm8EmO18/c2jHZVW+NULoESy40ulZAYN4822aokuyGVgG4/Nt8boSSkDizB/tJZEuWGEgSIZsdDnsV53jOT5dYLCLboHR5k0dLWjDTccC6dms3pWXmyL+kRih3HS9oofC+BtQU/CMTaJClP3AVXtQ8orTh2oNI8Wi88Md+9CxwgpvaOMN4Alw2MUPPVRt8OiFexargrBQD56v2QdL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(921020)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0x0OU80bi80aVdtRzhmbkF6QW8yQnVBejdGMitIUkpBMUFVbittaldWOWow?=
 =?utf-8?B?dWg0RWRTeGRCcG1LaElCek90Sk56VWlJcHgyWStGTHVSOXkvOElmYmJQbGda?=
 =?utf-8?B?K01mMERFMTRsaVdTMHU2K0RMc2ZGRHdNK0hjOTBYTUFjYlZicG9HTVowUy82?=
 =?utf-8?B?b29STUc4OHEzYlRUNzJPL2JBY3JnRlJYeEoxVE9wMGFiUlhWclhKSzBqUFNT?=
 =?utf-8?B?TWRDV2pOUFREUjBVYUd2bTVoN05aUnVDYmptOUtwTXJNYnpGVW53VC9lWi9L?=
 =?utf-8?B?RFQyVUpvTDRxMFhuSDk2Uzl2bk05QmliV05kMm55Ris4RG5MRnp2Qy9kSHlZ?=
 =?utf-8?B?ZjcvQUsyM2pDOWJ4OElqbVRQQ0hYOS94a3gwNTRvWUxnNEFMbU1FUytONUhx?=
 =?utf-8?B?aGVLVU5rRWFpL05tOG9lZDVYT29BSUxFa0xaRGZsWWFzWU1zaXhRRmF6bVR4?=
 =?utf-8?B?T1dJUGJEcGZzUGRqUHU3K2lvdnQweDVvcE1RVlZBdUplU2VRLzF6MEJGcWQ1?=
 =?utf-8?B?QWJSSHR4U2lvTmhWTC9XZ1ZCOC9rN1NobnYwSmIyajRra01QbFpwOHZ0QjFI?=
 =?utf-8?B?cDhxaFpzSjV6SVdoQ2R0bWNFcXhSMkhDcXNBc1hOUEVzb1ByTlJCZXVHbjgv?=
 =?utf-8?B?MzBlTko4SFB5V1I4YnN0OEZKVS9sRThhZHg2OURVYmo3eWl0OFdrSmM5U2lx?=
 =?utf-8?B?ZGg0eHJyWWpSalo1TmpNNCthVTkwUUdSUTZQZ29kUEhHbVZTcE9ZSTdsMnRN?=
 =?utf-8?B?aHFvemUxNjVEcVJMWEw3Y0dqN1VVSWVzbVV6QkRTTWROaVJrZ0ZPeXpoLzc0?=
 =?utf-8?B?TlRSSkFsVEtxRFU4bFZFMTdzY2hVblU5U25WWm9QMzRQS0ZwVnFvakZSaWRZ?=
 =?utf-8?B?emFJbHlHT0xWYk0wNWFGNU5VajMzTXE0djllZnJHeExjVlpkM0VUaERCTUJE?=
 =?utf-8?B?T3o0OEJjdEpKMXhiN2FUMEJtQVNOYUpycFVVNWdCdkNrUk5NNklwM1YzcHVl?=
 =?utf-8?B?SHJlSnIzNTVZRldpWTVtemhqNEYrTHFhZy9YelNXd1ZHUS9NNDhHMG4xMGVh?=
 =?utf-8?B?Mm42bmkwYlVWcDBrM1ZrM3AwejZIZkNwM1ZwSVYvYms4eHBvTGc2R05ibkJU?=
 =?utf-8?B?eW9yVWVlWmVUcUNqRElQY0ZkVWVOanZyM1kyZzZsU3MxV2xDaUMxS0x5ckFK?=
 =?utf-8?B?bVNWZVZ5Sm9mN2lZTm9TNndLREpuUGNObHNNMkh2b0U1TXVBZW5kbGhGZkVU?=
 =?utf-8?B?SVdhSEwvcXFLRnFhMHJJL1JORmRtRXNyK2pteEJvSUFrdi96S3RLdkE2RjNy?=
 =?utf-8?B?d0JZVnNKTzZqazZMaE4ySHJVenMra3lNeGRyczUwQzUvRUc1K2czYk85NlE2?=
 =?utf-8?B?VXJtVkxBcXUwTm1WRWJaU2JQK3YyYVN4SUNtOUdMZThVNXRaenVIdUhFZ1U1?=
 =?utf-8?B?bzZRVnR1MkdWRHRNVDhGVkpXRTJHSEh5UEtwNmY0WXcyQWFFKzBtZ3hhek8x?=
 =?utf-8?B?Y2liRGtacE5yemZqbGVpYm9OYXZ4akZmRE9MZUREdWhCUXAxdFNIbmNYMkpM?=
 =?utf-8?B?TE00eVhma1hubkhoSGl1UlU1WGppNFZSRDFLQXhteU9yYUZObUFCNWNCd3JK?=
 =?utf-8?B?bCtycjNVOHZMMnNDSnRyRGYvYjh5WS9QbmxleXFQMmdma05vV003WDNRVHNu?=
 =?utf-8?B?eGZaU25Ubjh0M3VxNURwZEk1OWhoODJkQ3RNUDVUVzQyUTV1ZkFlOUJkNjBW?=
 =?utf-8?B?aERzL1dlaUxpR1ZJWDFTMGpPMW11QWRJWUcvckVOcXloSnRHVFgxUWRmWU0w?=
 =?utf-8?B?bVFLVVN2bTlmMG13NDN3MXdWZUEzeEpVQUdZaTMxVVJCck5XU0htSEQxcXZt?=
 =?utf-8?B?SHFuR0F2N25LV0dla0ZubjFqcVpodEhRMU9FRExoR0NRQTRWVW5xUnNNb3RD?=
 =?utf-8?B?TU5vcm0xbzVNOUNuYlpaVFBDMXBsNHVtdXp1T21aUHVvZmlZM08xeTdyWVUv?=
 =?utf-8?B?eC9VRHZKS1RDWGZQMkpPNStoZk8wd3dFR3ByUnFvQ3N5MDVIZWxjTUVGSlB4?=
 =?utf-8?B?RzVKeDRRNXNPWTMwYVBjMEJaekJMOHptaWtCdkRiVUxQYVBRQ3hLcklTeFBB?=
 =?utf-8?B?d05obm5GWS9yODI5SUs4TzNjNHc1NVhGYlozK1lSemRzditOWmtBOWdFK3FM?=
 =?utf-8?B?bFlJN3JmODVkdCt4MVQwYXFXUVVONml3VGZ3cHM0VUVmcVcrK2pWS3dMc21S?=
 =?utf-8?B?R0drRmloODFCL2xTLzc4ak1rcldPRjgxMU9yclRTeWtmWDlvbnEwTXl1eUx4?=
 =?utf-8?Q?uAnpXVRUzXIB8kRsLa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca08054-0f9f-49ab-9d23-08dedb8911f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 18:04:49.0655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEk539F+FiU4Ixk4JSz1YDJmllwDTRItNCZs67UmqywV7iv1sU6a/fyHdY4ne7svOR6kk2P0Gk8baYY+mmEL1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVs
eSAzLCAyMDI2IDI6NDcgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTmF0YWxpZSBWb2NrIDxu
YXRhbGllLnZvY2tAZ214LmRlPjsgU2hldGFpYSwNCj4gQW1pciA8QW1pci5TaGV0YWlhQGFtZC5j
b20+OyBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29tPjsNCj4gTGltb25jaWVsbG8sIE1h
cmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgVHZydGtvIFVyc3VsaW4NCj4gPHR1cnN1
bGluQHVyc3VsaW4ubmV0PjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
PjsgTGF6YXIsIExpam8NCj4gPExpam8uTGF6YXJAYW1kLmNvbT47IEhlLCBTaXdlaSA8U2l3ZWku
SGVAYW1kLmNvbT47IFlhbmcsIFBoaWxpcA0KPiA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEpvc2hp
LCBNdWt1bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMS8x
NF0gZHJtL2FtZGdwdS9paDYuMDogVXNlIE1NSU8gQUNLIGZvciByZXRyeQ0KPiBDQU0gb24gSUgg
Ni4wDQo+DQo+IE9uIDIwMjYuIGrDumxpdXMgMy4sIHDDqW50ZWsgMTk6NDY6MDMga8O2esOpcC1l
dXLDs3BhaSBuecOhcmkgaWTFkSBKb3NoaSwgTXVrdWwNCj4gd3JvdGU6DQo+ID4gQU1EIEdlbmVy
YWwNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+ID4gU2VudDog
V2VkbmVzZGF5LCBKdWx5IDEsIDIwMjYgMTI6MTcgUE0NCj4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+ID4gPiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPjsgTmF0YWxpZSBWb2NrIDxuYXRhbGllLnZvY2tAZ214LmRlPjsNCj4gPiA+IFNo
ZXRhaWEsIEFtaXIgPEFtaXIuU2hldGFpYUBhbWQuY29tPjsgTWFyZWsgT2zFocOhaw0KPiA+ID4g
PG1hcmFlb0BnbWFpbC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+Ow0KPiA+ID4gVHZydGtvIFVyc3VsaW4gPHR1cnN1bGluQHVyc3VsaW4ubmV0Pjsg
S3VlaGxpbmcsIEZlbGl4DQo+ID4gPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IExhemFyLCBM
aWpvDQo+ID4gPExpam8uTGF6YXJAYW1kLmNvbT47IEhlLCBTaXdlaSA8U2l3ZWkuSGVAYW1kLmNv
bT47IFlhbmcsIFBoaWxpcA0KPiA+ID4gPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBKb3NoaSwgTXVr
dWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+ID4gPiBDYzogVGltdXIgS3Jpc3TDs2YgPHRpbXVy
LmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIDExLzE0XSBkcm0vYW1k
Z3B1L2loNi4wOiBVc2UgTU1JTyBBQ0sgZm9yIHJldHJ5IENBTQ0KPiA+ID4gb24gSUgNCj4gPiA+
IDYuMA0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gVGhlIGRvb3JiZWxsIGlzIG5vdCB3b3Jr
aW5nIG9uIE5hdmkgMzEuDQo+ID4gPiBVc2UgdGhlIElIX1JFVFJZX0NBTV9BQ0sgcmVnaXN0ZXIu
DQo+ID4NCj4NCj4gSGkgTXVrdWwsDQo+DQo+ID4gSSB0aGluayB0aGUgZG9vcmJlbGwgcGF0aCBp
cyBub3QgZW5hYmxlZCBmb3IgSUggQ0FNIHNvIHRoYXTigJlzIHByb2JhYmx5DQo+ID4gdGhlIHJl
YXNvbiBpdHMgbm90IHdvcmtpbmcuDQo+ID4gSSB0aGluayB3ZSBuZWVkIGFuIHVwZGF0ZSB0byB0
aGUgTkJJTw0KPiA+IGloX2Rvb3JiZWxsX3JhbmdlKCkgZnVuY3Rpb24gdG8gZW5hYmxlIHRoZSBk
b29yYmVsbCBwYXRoLg0KPg0KSGkgVGltdXIsDQoNCj4gQ2FuIHlvdSBwbGVhc2UgYmUgbW9yZSBz
cGVjaWZpYyBhbmQgZWxhYm9yYXRlIG9uIHdoYXQgd2UgbmVlZCB0byBkbyBvbiB0aGUNCj4gTkJJ
Tw0KPiBpaF9kb29yYmVsbF9yYW5nZSgpIGZ1bmN0aW9uPw0KDQpUaHJvdWdoIE5CSU8sIHdlIHJv
dXRlIHRoZSBkb29yYmVsbCB0byB0aGUgY29ycmVjdCBIVyBibG9jay4NClRoYXQgaXMgY3VycmVu
dGx5IG5vdCBlbmFibGVkL2RvbmUgZm9yIHRoZSBJSCBDQU0gZG9vcmJlbGwuDQpTbywgeW91IGJh
c2ljYWxseSBuZWVkIHRvIGVuYWJsZSBpdCBpbnNpZGUgaWhfZG9vcmJlbGxfcmFuZ2UoKSBmdW5j
dGlvbi4NCg0KPkFsc28sIGNhbiB5b3Ugc2F5IHdoaWNoIE5CSU8gdmVyc2lvbiBpcyB1c2VkDQo+
IGZvciBmb3IgTmF2aSAzIGFuZCBOYXZpIDQgR1BVcz8NCj4NCk5hdmkzIC0tPiBOQklPIHY0LjMg
KG5iaW9fdjRfMy5jKQ0KTmF2aTQgLS0+IE5CSU8gdjYuMy4xIChuYmlmX3Y2XzNfMS5jKQ0KDQpJ
IGFtIHdvcmtpbmcgb24gdGhlIGNoYW5nZSB0aGF0IHlvdSBuZWVkIHRvIGVuYWJsZSB0aGUgZG9v
cmJlbGwgcGF0aCBmb3IgTmF2aTR4IGZpcnN0Lg0KT25jZSB0aGF0IGlzIHdvcmtpbmcsIEkgY2Fu
IHNlbmQgeW91IGEgdGVzdCBwYXRjaCBmb3IgZW5hYmxpbmcgaXQgb24gTmF2aTN4Lg0KDQpSZWdh
cmRzLA0KTXVrdWwNCg0KDQo+ID4gSGF2aW5nIHNhaWQgdGhhdCwgd2UgaW50ZW5kIHRvIHVzZSBk
b29yYmVsbHMgb24gYWxsIEFTSUNzIHRvIGFjayBJSA0KPiA+IENBTXMgdGhhdCBzdXBwb3J0IHJl
dHJ5IGZhdWx0cy4NCj4NCj4gSSdtIE9LIHdpdGggdGhhdCwgaWYgdGhlIGRvb3JiZWxsIHJlYWxs
eSB3b3JrcyBvbiB0aGVzZSBHUFVzLg0KPg0KPiBUaGFua3MgJiBiZXN0IHJlZ2FyZHMsDQo+IFRp
bXVyDQo+DQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+DQo+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5jIHwgOCArKysrKysrLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
PiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9paF92Nl8wLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhf
djZfMC5jDQo+ID4gPiBpbmRleCA2NWU1ZDIxNzUzZjkuLmE5N2M4NWIwY2I5OSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2loX3Y2XzAuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5jDQo+ID4gPiBAQCAtMzA3LDYg
KzMwNywxMSBAQCBzdGF0aWMgaW50IGloX3Y2XzBfZW5hYmxlX3Jpbmcoc3RydWN0DQo+ID4gPiBh
bWRncHVfZGV2aWNlICphZGV2LA0KPiA+ID4NCj4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4N
Cj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiArc3RhdGljIHZvaWQgaWhfdjZf
MF9yZXRyeV9jYW1fYWNrKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzINCj4gPiA+ICtj
YW1faW5kZXgpIHsNCj4gPiA+ICsgICAgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAsIHJlZ0lIX1JF
VFJZX0NBTV9BQ0ssIGNhbV9pbmRleCk7IH0NCj4gPiA+ICsNCj4gPiA+DQo+ID4gPiAgLyoqDQo+
ID4gPg0KPiA+ID4gICAqIGloX3Y2XzBfaXJxX2luaXQgLSBpbml0IGFuZCBlbmFibGUgdGhlIGlu
dGVycnVwdCByaW5nDQo+ID4gPiAgICoNCj4gPiA+DQo+ID4gPiBAQCAtODA3LDcgKzgxMiw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2loX2Z1bmNzDQo+ID4gPiBpaF92Nl8wX2Z1bmNz
ID0gew0KPiA+ID4NCj4gPiA+ICAgICAgIC5nZXRfd3B0ciA9IGloX3Y2XzBfZ2V0X3dwdHIsDQo+
ID4gPiAgICAgICAuZGVjb2RlX2l2ID0gYW1kZ3B1X2loX2RlY29kZV9pdl9oZWxwZXIsDQo+ID4g
PiAgICAgICAuZGVjb2RlX2l2X3RzID0gYW1kZ3B1X2loX2RlY29kZV9pdl90c19oZWxwZXIsDQo+
ID4gPg0KPiA+ID4gLSAgICAgLnNldF9ycHRyID0gaWhfdjZfMF9zZXRfcnB0cg0KPiA+ID4gKyAg
ICAgLnNldF9ycHRyID0gaWhfdjZfMF9zZXRfcnB0ciwNCj4gPiA+ICsgICAgIC5yZXRyeV9jYW1f
YWNrID0gaWhfdjZfMF9yZXRyeV9jYW1fYWNrLA0KPiA+ID4NCj4gPiA+ICB9Ow0KPiA+ID4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4gIHN0YXRpYyB2b2lkIGloX3Y2XzBfc2V0X2ludGVycnVwdF9mdW5j
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi41
NC4wDQo+ID4NCj4gPg0KPg0KPg0KPg0KDQo=
