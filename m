Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29C9EC01D4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 12:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E9210E07E;
	Mon, 23 Mar 2026 12:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LfaWKiAv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945FE10E401
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+zbSPgjZ/k0HPgU54vrLpwewWaD3Q4T6rpQFxbFNtWLnD/qwlzgD2vuJzY5BzSGwlsu2r0lsFf83SohUcJpGsOmm7l5Uz8nc+s4X1F8b0V7pEi6K5YUQrxbu0ANyRYfBt7U1NNgRUJUY6BcxZ/bgKnL258HT689RtuvXWTkZ7fJO3nquhAX6DydmZGUcLiZYlXRK485pw7DC9E4h1v68eWsLW7cSGfPrju5MKQTH3qPNLbfPzRRgA6d7ADn3TJqQeNy4TCllclJykpWPOV02rkPhLFTveXUaI4JRRZ4IELCoX006jU5zS37BiuVxgZhFkZUaUgsQ4pm5VNSF9iNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLCAEXzj0BiBW/JvP+Gp3bF3ujFfOCk4TL5k9mXnaVg=;
 b=RVRkkcGkRS2s2G0H1srgdn8NSIPVZS3eT87uotc4qEEwGBa1b4BuvsTRtk6aMIFoFb2W1ToQb+1Tk3hOoRkL4NP4zSkLwl27mRKxrAC7I2CblkjgB/mN8kjDs7Md/mAjLYCXo4mQO2S5FloAY6ahrXqOsZUbiFtQqlC4Ty16L1TL7KmzgMMo6MesCijACkzWTLcXyXJZwQMucYc71mlJDSEjmyhEIZdXiOEwdY5Vhmb/GehuycE66K2y+HRNKFZ4cDVQChLek7asEPx7Uw9shWSrH8wQxzhZQ981FNhGeVaUs6yZUuHf3+uPMI7zltIOOQX+E9I8slzOq+0MBPZV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLCAEXzj0BiBW/JvP+Gp3bF3ujFfOCk4TL5k9mXnaVg=;
 b=LfaWKiAvfRYzg2hq824rrY6yJiLepOuMAm0DC4Ui1hKgmHdsjyPwRAnohsrWxCFa+gVTnmZOT8haK3glNuo17pNcm8j16miHN3EvSxXa5ONCD7KSCE4AtpNf1s/Vt8O9Z/41pvcWWqM/t0xHuOLY0abW8oqherY51u/yYfN0kxA=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:14:27 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 12:14:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the idr allocation flags
Thread-Topic: [PATCH] drm/amdgpu: fix the idr allocation flags
Thread-Index: AQHcuqCWr21HdKy090yi0eNHNjQrP7W74MQAgAAmtwA=
Date: Mon, 23 Mar 2026 12:14:26 +0000
Message-ID: <PH7PR12MB60006CEADD1F895156C60120FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260323083923.3348059-1-Prike.Liang@amd.com>
 <1b28c112-c9c5-417d-b9e7-088100cbd22d@amd.com>
In-Reply-To: <1b28c112-c9c5-417d-b9e7-088100cbd22d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-23T12:12:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|BY5PR12MB4068:EE_
x-ms-office365-filtering-correlation-id: 5303fab8-93f3-411c-a1f4-08de88d5ba5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: IummkdrrKAsTJEasEtlzVMpW/i7EHy6FvocwdCeKIGbCkyLK3wybmm4kvc2KKC/gOMcFxmO2zZZyLnqJoMRjDFG8dclhqX8iXGlIDCChUqRX6bpTQxoMnb2vtTc9LgQPwE1ltTkwgZfEV5Tcbrz4S0qRxD0d56QflNEu2aLxGN9Dam7UKRN4nRHbFOU00ycdKU0jr/pUHvAWLzkFg2VDiuJ4fOToPpVJlyRSetd66groq088f2O308Ojod1Q+J5V5Je9O2AxpeL09dVdVRertUUErZmhTss7gO9sBeEbEmGQ+BKnv7QGp+1FF5rgmPl1J5SWpaEjv/nWMnwR1runP52bdWlGRL0J2nOWVcuNVHQGgHtKkgh2yOQX1zLI+sgbk1XGc3nMesqCckt9ZEmKtTiNZFSdNkxgBGj1QLr0kSP0ONvxhhaWZgp3hnQfaFrAwMw0Iax98a0jsYCqMxvlRNJkygZNc4DPnqC0UWzVamAWB8VHi7XS0xxaYJId3it+vKVPwr2QSJmXNMfM/3bhSoV6eK5CR2ZPMTNyFUDzmJiV6cilyULgbeX3/oY6VYCrQY4VzGG51iBOmS7wq9f9ZpusHhdGbkN1qrNGHL1j1yu/AOyDe8tJBR19JFYYb854jEsNrllu/JC8xbAUr+h20BNjr3M82zX2K8vdXM0DVgfOaskdeoEWsW8C1TOO0J/khCykzxKuRSi6ksDnOk/gCrhIYFxiV8QB6F8yiqqGRUPkwjYu0n9l0ZJPxxn+Xlrs8nQpsWzdAPbDyeI2+UdMHtX4dJ13lv5Wxax1NYxe96E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3k5c3oydkxUeUl1cE0xNnBKSXpod2xQTkZ1NEhDU0UxTFp4ODBFZEN4VGw1?=
 =?utf-8?B?UWF0dmRXRVJQNnhSVlY4NEtreGxZYmc4Y1BwSm92S2cxQ0dMWjJBWEN0T1Bh?=
 =?utf-8?B?aTZKQnVrUlVFcEEyWEVteWMrbWNkQklHNUJIRjE2QU8wK1lLdkNNWTM4aHFs?=
 =?utf-8?B?bTJ0eHpaQ1I4Ym9nT0d0OEplZ2J6aVVvY3UzVzZwbkxZRkhnRGhYQk04UmlO?=
 =?utf-8?B?YlVUeG1XN3R3QUhyeVMxMEg0bTAzVFkxMmJrcmNCcHNqbVhOd3ZlNkpKZmRG?=
 =?utf-8?B?cW8ycVdMRjU1NmFkUTlRTHZXaXQ2VXdUNjBlMzY0Zjh4aTZBbkhocitoV2lw?=
 =?utf-8?B?Y0lvV3phQmhVUUgxZWcrT0J1L21qTG1nZHFWaEpwNkRJL3pNbGxaZkovSWxJ?=
 =?utf-8?B?UWxnQ2dQUGN1dTJ5YXdaZ0tGN1pTNVluMjdTaEdTU05MTzk2TFg0OVRTM0Zl?=
 =?utf-8?B?dXNnS0RYaDFOSVlxY0RPeGhrSzVrdThCelFHSHFpWlczNkRlNW9tcHlGYkYr?=
 =?utf-8?B?YVpmUC9RWXlFbFl1OTU4TXJ3azhRVjcwQ1FsTkZ6OWZCZTdUekdKRDd6dHFY?=
 =?utf-8?B?eGFvdDc1R3REekhEa2Z3bXFoSkVEZ3AvMjFQRVNULzFVRTVhWHU1ZTYxYXkv?=
 =?utf-8?B?eEhKam53OTQ0NWU0OWlCcFlEWGtrUmR2ZEhjMEtIQytxWU41OUpxUnBqSG9h?=
 =?utf-8?B?ZnQycmIxaER1WWROT2UrUWhONUpCNzBPYU9HVGFJeTNablh2RDdJcHY2U20y?=
 =?utf-8?B?SjIveTF5Ky9JVk0xR1pUaGFIQVR6ZnRoRGNPYzFvMDhsTVhuWlRBRUJOcmJX?=
 =?utf-8?B?OXVJNUdXYmNlZ1hBMVZEODlPZ3hwOVhteHlFaWZEY0piV2lRSzJGSURGclVY?=
 =?utf-8?B?czE0SFNyTDk1V0FZZmRwR1VucEE2SGMyRDVxbGV2TEZWTmJOYWtMYXBmL3dV?=
 =?utf-8?B?VytIZXhtTHBLQkdZTytlSzRvbHNrMnk4em40eXNtRGpwdStmdllJVU1oa2s4?=
 =?utf-8?B?S2paYVcyZVRMblBDWE1LN3pFNnF4N0d4d0RJamJGc3JrUnIzL1plOGc4VkFs?=
 =?utf-8?B?QXNFUE11RnRyeTRDajdSc3ZWdkVMU1ZQZFNrdE5Oc0REcHAxSVowNUhnNUJF?=
 =?utf-8?B?dnBHN2k2ZHhneEdIM0R2eHl2NzZuUkJGVTk2VTJnbTRqdXFUUWxpQ0pQUWlm?=
 =?utf-8?B?SnVSb3JHMjFPSEtxSCtZdGJhb1FybFNMT1doUE9teFhmU016TU51TEdwMFlJ?=
 =?utf-8?B?VTNHU045RHlWYjdVeGhUY3Q0Qzdja3AzNDI1d24vaEVDY3hVUFVkVW5yMVNm?=
 =?utf-8?B?aXVBRkJUSFRHMEMzRkNmSENwb1FMQ3VhZzFlWnNQMzc1SEE0T0drVmpVKzBs?=
 =?utf-8?B?dzBiZkt2RmQzaDJoWXpkbG9CaG1aS1FaRExqUHFCa01qOExlQjFuWVZucnZ2?=
 =?utf-8?B?VGQyNWFiVnZzdllqdWk1ZHNFZU81d0hIa2k5amJDMlAwZlcxU2NQbVFrR2Nv?=
 =?utf-8?B?U1U1c1dkZGZKQWV2VU1MelRXUEVYK2Ixb3BRam1KMUMrMDJWV1N5WWEzamxv?=
 =?utf-8?B?a2sxMTFoaU96QkFGZGdGU1M3SCtQN2JZWWhLN2haZVk1bmJtMEJRWDN0YnVk?=
 =?utf-8?B?Z3RWdktsSWNTY1c2bEszOVpEUWVXWExvT1RMMzBBV0NpNE5kNi8rY2d1aGxJ?=
 =?utf-8?B?SVpXdDRIQUNmUitCVmVpWW1uRktsMUYwTzVlZjhNa29jc2xzSmY4SU1aTVg0?=
 =?utf-8?B?OWZrV3NhREIwRVpaQ1BhTDJTRFUyWGJJdU55TG1iZ1dDVTZpZ05zVE00dWF1?=
 =?utf-8?B?azZCYXFBS3dlb2J2RkIrdmJWVXdHNnNDY0tVV1RBemIzTWdWenV3K2JPdmpZ?=
 =?utf-8?B?Mm1IZmVyUGtHSkZOOTJBVnhDbmJTWTVuOUIvYStqTnRlWjJjYWpYdjEzVHRE?=
 =?utf-8?B?aTZFQ2xOYmx3Y25Pa0lKamw0eWxjMmVEQkw4N3FYV0JXM05uS25acHhreU1k?=
 =?utf-8?B?V3ZMQTI1WjM4Q3grOHZKcFdlVW1IOVRHOWtMd1l6Z1hhMVVscWtBTkZWVjJ4?=
 =?utf-8?B?ZjY0N05TK2t5eDFvYThXN2JYOHRkc1oxeWdlZTlNRG1FZnZDZjUxTjV6Mms5?=
 =?utf-8?B?Z0tUMjdyMnNYVHRJdHFsTGxkaUd1Z2tkaEtBK1V4M2lOZ0RNNEZIZW1rWlV1?=
 =?utf-8?B?YkdvRXVFZlMray93N2NxNDZsYzJPQzA2UGdPaTlVT2RZcjBxK2xRMytwQ1hr?=
 =?utf-8?B?ZmpHbkRncFFkQitVazJDMHZ0NUQ3ZVZCeGlvUVRQK01JMVE4cURCc2lTSnVR?=
 =?utf-8?Q?/kf6MjoHd3Rm5v/1fy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5303fab8-93f3-411c-a1f4-08de88d5ba5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 12:14:26.9147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lTC6ciNe1UFdrWMB4EyYHs0eNfms9NvspLrQO7OmMupDgDHY7FmsLbGF9pnZZKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMywgMjAyNiA1OjU0IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgSHVhbmcsIEppbkh1aUVyaWMNCj4gPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IHRoZSBpZHIgYWxsb2NhdGlvbiBmbGFn
cw0KPg0KPg0KPg0KPiBPbiAzLzIzLzI2IDA5OjM5LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBG
aXggdGhlIElEUiBhbGxvY2F0aW9uIGZsYWdzIGJ5IHVzaW5nIGF0b21pYyBHRlAgZmxhZ3MgaW4N
Cj4gPiBub27igJFzbGVlcGFibGUgY29udGV4dHMgdG8gYXZvaWQgdGhlIF9fbWlnaHRfc2xlZXAo
KSBjb21wbGFpbnQuDQo+ID4NCj4gPiAgIDI2OC4yOTAyMzldIFtkcm1dIEluaXRpYWxpemVkIGFt
ZGdwdSAzLjY0LjAgZm9yIDAwMDA6MDM6MDAuMCBvbg0KPiA+IG1pbm9yIDAgWyAgMjY4LjI5NDkw
MF0gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkDQo+ID4gY29udGV4
dCBhdCAuL2luY2x1ZGUvbGludXgvc2NoZWQvbW0uaDozMjMgWyAgMjY4LjI5NTM1NV0gaW5fYXRv
bWljKCk6DQo+ID4gMSwgaXJxc19kaXNhYmxlZCgpOiAwLCBub25fYmxvY2s6IDAsIHBpZDogMTc0
NCwgbmFtZTogbW9kcHJvYmUgWw0KPiA+IDI2OC4yOTU3MDVdIHByZWVtcHRfY291bnQ6IDEsIGV4
cGVjdGVkOiAwIFsgIDI2OC4yOTU4ODZdIFJDVSBuZXN0DQo+ID4gZGVwdGg6IDAsIGV4cGVjdGVk
OiAwIFsgIDI2OC4yOTYwNzJdIDIgbG9ja3MgaGVsZCBieSBtb2Rwcm9iZS8xNzQ0Og0KPiA+IFsg
IDI2OC4yOTYwNzddICAjMDogZmZmZjhjM2E0NGFiZDFiOCAoJmRldi0+bXV0ZXgpey4uLi59LXs0
OjR9LCBhdDoNCj4gPiBfX2RyaXZlcl9hdHRhY2grMHhlNC8weDIxMCBbICAyNjguMjk2MTAwXSAg
IzE6IGZmZmZmZmZmYzFhNmVhNzgNCj4gKGFtZGdwdV9wYXNpZF9pZHJfbG9jayl7Ky4rLn0tezM6
M30sIGF0OiBhbWRncHVfcGFzaWRfYWxsb2MrMHgyNi8weGUwIFthbWRncHVdDQo+ID4gWyAgMjY4
LjI5NjQ5NF0gQ1BVOiAxMiBVSUQ6IDAgUElEOiAxNzQ0IENvbW06IG1vZHByb2JlIFRhaW50ZWQ6
IEcgICAgIFUgICAgIE9FDQo+IDYuMTkuMC1jdXN0b20gIzE2IFBSRUVNUFQodm9sdW50YXJ5KQ0K
PiA+IFsgIDI2OC4yOTY0OThdIFRhaW50ZWQ6IFtVXT1VU0VSLCBbT109T09UX01PRFVMRSwNCj4g
W0VdPVVOU0lHTkVEX01PRFVMRQ0KPiA+IFsgIDI2OC4yOTY0OTldIEhhcmR3YXJlIG5hbWU6IEFN
RCBNYWpvbGljYS1STi9NYWpvbGljYS1STiwgQklPUw0KPiA+IFJNSjEwMDlBIDA2LzEzLzIwMjEg
WyAgMjY4LjI5NjUwMV0gQ2FsbCBUcmFjZToNCj4gPg0KPiA+IEZpeGVzOiBlNmQ3NjVkZTNkNmIg
KCJkcm0vYW1kZ3B1OiBwcmV2ZW50IGltbWVkaWF0ZSBQQVNJRCByZXVzZSBjYXNlIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiA+IGluZGV4IDY0
NGU0MTNhNGU2OS4uMmY1NTIzNTJlMDQ2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiA+IEBAIC02OSw3ICs2OSw3IEBAIGludCBhbWRncHVfcGFz
aWRfYWxsb2ModW5zaWduZWQgaW50IGJpdHMpDQo+ID4NCj4gPiAgICAgc3Bpbl9sb2NrKCZhbWRn
cHVfcGFzaWRfaWRyX2xvY2spOw0KPiA+ICAgICBwYXNpZCA9IGlkcl9hbGxvY19jeWNsaWMoJmFt
ZGdwdV9wYXNpZF9pZHIsIE5VTEwsIDEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAxVSA8PCBiaXRzLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDFVIDw8IGJpdHMsIEdGUF9BVE9NSUMpOw0KPg0KPiBXZSBzaG91bGQgYXZvaWQgdXNpbmcg
R0ZQX0FUT01JQyBoZXJlIGFuZCByYXRoZXIgcmVwbGFjZSB0aGUgc3BpbmxvY2sgd2l0aCBhDQo+
IG11dGV4Lg0KT0ssIEkgd2lsbCBjaGVjayB0aGF0IHdoZXRoZXIgY2FuIHVzZSBhIG11dGV4IGZv
ciB0aGUgaWRyIGFsbG9jYXRpb24gaW4gb3RoZXIgcGxhY2VzLg0KDQo+IFJlZ2FyZHMsDQo+IENo
cmlzdGlhbi4NCj4NCj4gPiAgICAgc3Bpbl91bmxvY2soJmFtZGdwdV9wYXNpZF9pZHJfbG9jayk7
DQo+ID4NCj4gPiAgICAgaWYgKHBhc2lkID49IDApDQoNCg==
