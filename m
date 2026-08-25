Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F6C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 06:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0821510E5D7;
	Tue, 25 Aug 2026 06:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPOcxw/Z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A5A10E5D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPKfvW5ZlfQD3a7mIxZJBCfsEzzePMZX0fxqMNx5bXvaDN5rRQtGP+rL6TA9tC5GX4kEtjZYxuZ9GeQF9l5SybgRoeA47fyNxOmkRt62q9uDwq3C4OltOO7ABqT8kLaCcqvvYQ0jj9YHRnL4TRo4SWBiID5oevpY+ZVEvwex/EGuw1NfFkZ2ZrZJ4H5Oqj2jhP4u5anvG7pIeU/dVADfZpooEPbZ5NHryBoQpnAEKluDDWvGKF/qvg04kbeooxB7Mqof/B3k2pZIcHEzMf68/liRaRSxCC0Tj7fuHl3a9u0Jlr9iKxsMzUWGT6/jKXl5nlCGfwPlHjx5DE1ganHA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia1de/zs6ZjAyQwIQyMN+zr6pyoREaofO7tFut4/4lI=;
 b=CHoWNBOrxiU9GFjGG54WR4nVgp1SR8d8c+5d/sPEi2OJT4MyRJqk0vQAA7iPwKTxng9m/IcxCIsW7cXJJDBol+L/XMpH32J4J4SJ84xHbJ3A+SjNRbkG+3s3+Wk4QgLzgPotWu85sWtM8UawBIp9xaRm7lb9lhILDYoOyqeQbpwVqCfY0vXS1zQveYY+mbd4niQWwNX+bebFvGfhnBW0Khot1fO0uwKqOFQ6UwdViU/N2oU365Kwlt/jE3DFnjkcDql7lZTjsetBaYyXLNh3B1/SbvPEgxMmmk3L06D1CFWiSKyvmwbCwT/5HaEYCftKewlmyaZd3QOThA+jXeZT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia1de/zs6ZjAyQwIQyMN+zr6pyoREaofO7tFut4/4lI=;
 b=QPOcxw/Z9Fio0hOBIjH71/GbzE6hPVi23fjzZfHpR3jEMAK4xkRLRmRMwtFU8jPYvVkc6d/DbMkXglQumwa0eUYaHvITjTxqr/5c3PlcyWgx3jZ5Fv6fzVNL9LH2VbYHlWFOt/iPVlSPWyRK7fI1FL5oarNvKumPsm08gzq/D8M=
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DSVPR12MB999173.namprd12.prod.outlook.com (2603:10b6:8:38a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 06:47:21 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:47:15 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Hosur, Priya"
 <Priya.Hosur@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAimNSy0DaRHqEWNXLojL12vwbas30oAgAGDLoA=
Date: Tue, 25 Aug 2026 06:47:14 +0000
Message-ID: <PH7PR12MB779458D6EFD35B99A32C0A3193AF2@PH7PR12MB7794.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <39ce25a7-c20b-4513-9ac1-3b636e3af6a5@amd.com>
In-Reply-To: <39ce25a7-c20b-4513-9ac1-3b636e3af6a5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T06:45:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7794:EE_|DSVPR12MB999173:EE_
x-ms-office365-filtering-correlation-id: 47703c1c-4ef2-4e63-3fc4-08df0274b2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: ZiaIdkJhyq9dHK+KpBJjV0G67BfAMe+EVNtSIS8Oz/bsTGw3S2EUQsiTyKj6rpzFpcfrr31KYIU9FqwKS6YWHZ3rOpCkOIcDrCT+hgI5mY/j/rwXNFJqwL5qar7oEvBH5GtDkgOk842uzWQrCC5wXtqaSJJRRPj3sqByVkOr/ZZTw+ywmzdxnZVyX127EVb7mqmkSiqLm336cXJtxzEUr78GZYXsYbJYAFZVEhWf7uM6HhlECzQiDTVxmPfLuUCyFVwptcdga6wCtbL2iBhsDKvXoekE7/VaL114pVSVryR525hTyZNFjDQojVaqRkeuTT+vRVPP8LYEvyeC5zFghV1c01C0UPWpt1aWCn5mMewsfzF2BcGwghq0+WBtf4Fm7TU4YFYj1Eusdr+tgMiy/d7T4FxBEx3OMsnpp7STwB/cYpPWMY0duwxKwbhJhznzVlZt6xXyToGGoDWAE0298nTJMt6KkIsKuihrc8OIp2GZkxJUqXV6LAlsewUibUwq2x/XA/KpXPzj2DCLR/WLzK4o/TR1txtVAE6KMp9bvcdMOMksFRJ5HPRIQjVJWUPO2aGOb3bHgc45k/xUqZqVkYA6wOPo1SdJVRObodMG+QjYxe3n8PEdueQQmFOj7MwsYiLx7LXcxH44QR1Z1XaIuRnt+wVbkRGihLqIikE7aS/+FLQglYR1TS04uS+CurKoM7o7EYwGL+JKZeEC8B/xpZFiRAPuscal1XU6xcawr3rHtn55HsltyeVT1AFRP6cd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TExIWXM5b2hSUVFpUEhOMHQ0V2h6SWwrMWZvOGV0VTJZUnhuWE0zaGs4OU1W?=
 =?utf-8?B?Tk5TZEIrNVNhZnRjK0oyQnlWajI2V09OU0k5NGczanVLaXpnSmRmTDdtOXZY?=
 =?utf-8?B?RGxwMGNmaHhOV2dkV0pESERKYU9odEIwK2NwYk5KYWJORlAzK0ZIbG42T1M1?=
 =?utf-8?B?c285bGYxL3JjOWxIeURDY3RoQUo4SlBnRUZsdkl3QW5OWU92R2cvVzlRdEhB?=
 =?utf-8?B?cDcxVGt2ejJwbzdFMHp1TkJ3eDNmcWtmTTd2ZEVDRUVrR01sSGp0N2xLZWNI?=
 =?utf-8?B?dkl2OG81VllVRTY5RGR2LzZnRW9nZEJhVW1hWmY0eURxd09UTUtCNThMSFJV?=
 =?utf-8?B?Q3QweEFOcVEzaERwb2YvSUZBTUw4aGhNc0t4UGJVRFVGZzR6WXlNMHY2ZnRq?=
 =?utf-8?B?UmFBQXgyZWlLR0lDTHhadUhoSFNEcHl5cmgwcnBoTkFVOERyQmp3a3F0WVFh?=
 =?utf-8?B?QlhkYk1pTlRPZi83QUxxWUlLd05ReFk2blllRGRCaDhwN0orL2NiUDg0VStN?=
 =?utf-8?B?ZnMzTTdJcWhWaFRDeENvYVJMaG5jSm1DQ3MybzArUkI4YTFoc1N3UCtGMTIx?=
 =?utf-8?B?UUVIcUdsZTRxL2JRTHR2TVJFZnFPRU52SnNZY0ROY3RMSnAzSitBQjRrcGhz?=
 =?utf-8?B?bk1XRkNyNGVoVExyU2NEeUJ4USswRzJkRHhlZTZlY2VMeXEvTjRXUDhuRFdF?=
 =?utf-8?B?czVZRE9GcXViUEpObDZuU2J3QVFtRGc1QTRhVlRndXplcGIxYVllYWpUZ3p6?=
 =?utf-8?B?ck8rYytPOWNxcWVNL21tUGNYL2tJSks3VFJ2OWR2Nk94MWdTcmk2QUlKdnVI?=
 =?utf-8?B?ZnBsVkZmM2hwTnRlL20veFRvOGpBRi9uWEd0YktzMktEMXRrMjh5dmZFM2FM?=
 =?utf-8?B?eHdsV0I5ZkFVK2NWbUhnNXFKZDFpWHQ1MHFwUHpISk1GeXd6a2ZEeCtUeklL?=
 =?utf-8?B?YnNPMGpnMjBJeVNtWGRGcExTcE5xQVBYYkIvOVZ0dXVVMG0xU3RkK1VLNTY4?=
 =?utf-8?B?Q09NZ1U3OWF2dldTVVljbWlxL242NHpvcW50K2pUbCtvd2tEbEJtbDJXeEdj?=
 =?utf-8?B?OGUxNUlYRzgwZkMrZ0h1dFZ4K3NNalVzdnFOODlmTEQ2dXhtenh3Wkt6NExm?=
 =?utf-8?B?eGkxS3Eyc1I2QkcxbFZ4VFVkekRqb2oyWkNXTTVIdyt1TGc3SC9ZbUNUblRl?=
 =?utf-8?B?d0RTcUVseFl5T2hQVlBFZm05KzM0N1k5Ui94V0RHbFdqZGJBRGxTeVBSTkxj?=
 =?utf-8?B?ZmtRN0dlUGFvWW1TOHA3TEJkd3BYZHhJNmRGRW1TM3FMSjI4TFJpanRVVkdt?=
 =?utf-8?B?Q1lqQ2ExTEFSTU1YWk5zN0dLeDZiR0RYRUc5TUxOSVc4c3JFZWtDRkw2VEc1?=
 =?utf-8?B?Nk9ObDZUY3F2a1dpYnlLK1FQc0hxbTBuWTV3V0pUWTRGcU5iN2pxcmZZSjlG?=
 =?utf-8?B?TDM3cUtxNGRJTXZ4N0psQmI4bzRTaFUxNlp6dFpSZ2IxWFQydG9zYlJKYy9X?=
 =?utf-8?B?RHFTekIrY2pEUTQ3YW0rUkI4WVVreDZqbStWLzFOcFB5bk9XSjJNREJaSWhz?=
 =?utf-8?B?SEUxaW8vdDlvbEFtdDlsZEEyanRpZ3NOaWpZQnJZL1ZzOUh4KzJpaFRGcXlh?=
 =?utf-8?B?NkR6THVpUHdTTWZtbEF6YUxWR0FYRGNsWE9WZ1J0ZjB5bXR2VmdKRzc1RTFP?=
 =?utf-8?B?d2Y1Y2hyZ1VQV2NCUVN3R05RbVg1NDdNUW9HZUcvdTZFbnFRRFg1V1RaNmdl?=
 =?utf-8?B?ZGdteitpOTlWdEM1anZHa0t3NTI2K1l2UFFaVUtnRkF1TEZPSWE4U21JSEph?=
 =?utf-8?B?T0dxNTZMTHIvUW00SkZ1QmdJYnFsQkQvUjk4by9Ud24yaTVmV3B3Z1NwN1Fp?=
 =?utf-8?B?L0tkeTNlL0g0Q2JPc2JWTHBGaXlxNGFUUk5Oci9mbGl4V1VzTUN1OTdQS09I?=
 =?utf-8?B?cmxicEZrdnJVZDh2WFNMTnRZak5wV0dxeGgyREF2empGQVB5ZGpncVljNWZ5?=
 =?utf-8?B?SFY2ZmRKWGZaNk0wblNRNlBwVnoyMWI0MEpibWo3SjI2aUdCMTFZMDFSb1V2?=
 =?utf-8?B?b2ZsWUlQaGZCQ2RzRXJ1eWlhZkFNclIwc0pOL3JRYmVOQkNkQm1SWEZWU2c2?=
 =?utf-8?B?Q1gza1MvQTRPWjM4dmVvWmFOQ0VvbzhRWW9vY1NYNjI2cVZMd3dMVVBURmtk?=
 =?utf-8?B?THhHNGltUFJEb0RYTjh5NlBnVlZqS0ZJWHZhZFJNVSt6eUpWdWVlemVXOFhD?=
 =?utf-8?B?ODkvaEFja2FrVGtnZVpQZlhPYmY5QjhiamU1ZzlVN0daVFNuWVVhZHZHdndk?=
 =?utf-8?Q?3xVsF+AAPGFa/6j4Q0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47703c1c-4ef2-4e63-3fc4-08df0274b2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:47:14.5745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKNl4wyxcYahuHM6dqA4gTsNzmaxJsoTbRpdVzifAL5Wet6qqhPZDgVbTBKu1Ld1VzP4JbWVAURRJuQtCAV7NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999173
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

QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEF1Z3Vz
dCAyNCwgMjAyNiAxOjA5IFBNDQpUbzogSG9zdXIsIFByaXlhIDxQcml5YS5Ib3N1ckBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQu
Y29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGl1LCBTaGFv
eXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCkNjOiBW
aXNod2FrYXJtYSwgUHJhdGlrIDxQcmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbT47IEdvcGFsYWty
aXNobmFuLCBWZWVyYWJhZGhyYW4gKFZlZXJhKSA8VmVlcmFiYWRocmFuLkdvcGFsYWtyaXNobmFu
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZHJtL2FtZGdwdTogQWRkIFRM
QiBmbHVzaCBhZnRlciBNRVMgdXNlciBxdWV1ZSB1bm1hcA0KDQpPbiA4LzE0LzI2IDE4OjE4LCBQ
cml5YSBIb3N1ciB3cm90ZToNCj4gU2ltaWxhciB0byB0aGUgS0ZEIGZpeCwgTUVTIGRvZXMgbm90
IHBlcmZvcm0gaGVhdnktd2VpZ2h0IFRMQg0KPiBpbnZhbGlkYXRpb24gYWZ0ZXIgdW5tYXBwaW5n
IHVzZXIgcXVldWVzLiBBZGQNCj4gYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKCkgYWZ0
ZXIgTUVTIHVubWFwIHN1Y2NlZWRzIGluDQo+IGFtZGdwdV91c2VycV91bm1hcF9oZWxwZXIoKSB0
byBlbnN1cmUgaW4tZmxpZ2h0IG1lbW9yeSBhY2Nlc3Nlcw0KPiBjb21wbGV0ZSBiZWZvcmUgbWVt
b3J5IGlzIGZyZWVkIG9yIG1pZ3JhdGVkLg0KPg0KPiBDaGFuZ2UtSWQ6IEk5NGZlMmM4NDU0Nzcy
M2I2YjczODE2Y2U4ZDcyN2E1NGJkNzczYTZhDQo+IFNpZ25lZC1vZmYtYnk6IFByaXlhIEhvc3Vy
IDxQcml5YS5Ib3N1ckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gaW5kZXggNmQzZWQ1NWU5YWI0Li45ZmNmMTVkNjliN2IgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IEBAIC0zNzUsNiArMzc1LDEyIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX3VubWFwX2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X3VzZXJt
b2RlX3F1ZXVlICpxdWV1ZSkNCj4gICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgdHJhY2VfYW1kZ3B1X3VzZXJxX3N0YXRlX2NoYW5nZWQocXVldWUsIEFNREdQ
VV9VU0VSUV9TVEFURV9VTk1BUFBFRCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZS0+
c3RhdGUgPSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQ7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAvKg0KPiArICAgICAgICAgICAgICAgICAgICAgICogSGVhdnktd2VpZ2h0IFRMQiBmbHVz
aCBhZnRlciBNRVMgdW5tYXBzIHF1ZXVlIHRvIGVuc3VyZQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICogaW4tZmxpZ2h0IG1lbW9yeSBhY2Nlc3NlcyBjb21wbGV0ZSBiZWZvcmUgbWVtb3J5IGlz
IGZyZWVkL21pZ3JhdGVkLg0KPiArICAgICAgICAgICAgICAgICAgICAgICogTUVTIGRvZXMgbm90
IGRvIHRoaXMgYXV0b21hdGljYWxseSB1bmxpa2UgSFdTLg0KPiArICAgICAgICAgICAgICAgICAg
ICAgICovDQo+ICsgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJf
cGFzaWQoYWRldiwgcXVldWUtPnZtLT5wYXNpZCwgMiwgdHJ1ZSwNCj4gKzApOw0KDQpBYnNvbHV0
ZWx5IGNsZWFyIE5BSyB0byB0aGlzLg0KDQpUaGUgTUVTICptdXN0KiBndWFyYW50ZWUgdGhhdCBp
biBmbGlnaHQgbWVtb3J5IGFjY2Vzc2VzIGFyZSBjb21wbGV0ZWQgYmVmb3JlIGl0IHVubWFwcyB0
aGUgcXVldWUgb3Igb3RoZXJ3aXNlIHdlIHJ1biBpbnRvIG1hc3NpdmUgcHJvYmxlbXMuDQoNCkZs
dXNoaW5nIG91dCBhbnkgVk0gY2hhbmdlcyBieSBpbnZhbGlkYXRpbmcgdGhlIFRMQiBkb2Vzbid0
IGNoYW5nZSBhbnl0aGluZyBvbiB0aGF0Lg0KDQpJIHRyaWVkIHRoaXMgY2hhbmdlIGR1cmluZyBz
dXNwZW5kIGJ1dCBpdCBkaW50IGhlbHAgdGhlIGNhc2Ugb2YgdGxiIGludmFsaWRhdGlvbiBpc3N1
ZXMgdGhhdCB3ZSBhcmUgZmFjaW5nLg0KDQpyZWdhcmRzDQpTdW5pbCBLaGF0cmkNCg0KUmVnYXJk
cywNCkNocmlzdGlhbi4NCg0KPiAgICAgICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KDQo=
