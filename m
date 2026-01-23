Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5D9D6CFBD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 06:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511AF10E1E8;
	Fri, 23 Jan 2026 06:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3IxG8IL";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9C010E1E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 06:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7JXWsv1CVZnLXS6Ci4y87NaIuN0/pfkWUqRpSrwUyYt5mEMBPkz+JKIfKbxrUl2y0C8PAV4XR7Gqgx/L3LAQtBPFRYYNo+tknyKkt4EXzafmg7EbSWwYyEKK0LXXRFWjSKPTpVgWM41MujznR8ONJ1cqyaVKal5oAtNDt8pFitfUrKZBnQjuOFmt1NS6nBnfGdjPAhJ3c8krQ+gYUWKaSQxx6e1XMsIBRKQmJwFfGe/hI+AvNEU5LY8MLKcxlOM8t2JIwb7xs54sq6WcEszMkWe8ezbvlZOFYU2sOpgsgRKs7Eozv9bCfI8oXI3JXXSqvTu93qW7Ho3ZRE4KI1c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJj0TmrJm+VceAw2JUT3y0eAlSiVH+7AXsTrikmp9BQ=;
 b=r8ni8Z/wUhAoDumaPNTnsF4MW1PJEXhLhlN1cunBuiQ2mpdwmTr2iHfzlcWwO9spUEhHc5l4MAEUXCK+WaIeuiFRmufXWIMPsKBkmCH82wMTW71SnuhfDSKwxiTSYAFNj9YGoKM4JNNl2W4C4QknNqomuKODdRZ9Nt2eZej6XvVnZdFPpYUoFQPfYzUJi2X7sUAn7N696bSjna9fp4e6AIHRGkHSjbt4VT/JUXYpKNlJKpKRvufokKgsJdrpvp8/Nu3AHe8ehBmWlOq1XIivtZaAluEmI/bHgS3t1Cjgi2bPcOhRzILt3Q8uJ369QowtSImlBpe23XqS4h2Q0TnZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJj0TmrJm+VceAw2JUT3y0eAlSiVH+7AXsTrikmp9BQ=;
 b=C3IxG8ILI54+W0WF2dycbMWaXVJ5oFeFy4riujr9W3a9NMiGlNSnay37yFs73CRrBxJ+rBPtKgipZxqDyKaAt82XNRQxO6fiBwH3cKLlvoopxk59VQNJ0ghuO/kBmV3ItDhYscAxwtx7aY+eKX3YOhikrQ/x2uCPRYOqhks8cLw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 06:06:55 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:06:55 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 0/7] Refactor smu feature bit implementation
Thread-Topic: [PATCH v2 0/7] Refactor smu feature bit implementation
Thread-Index: AQHcidQH0oRt+fI1/keriKAgBvex+7VeBG8AgAFE1IA=
Date: Fri, 23 Jan 2026 06:06:55 +0000
Message-ID: <DS7PR12MB60711C3B536F8AEEE75ED34B8E94A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
 <d7f45afa-5c79-4b98-824e-9ca0adbb60f5@amd.com>
In-Reply-To: <d7f45afa-5c79-4b98-824e-9ca0adbb60f5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T06:06:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB7768:EE_
x-ms-office365-filtering-correlation-id: 4670cb63-e846-436f-d8a8-08de5a459c45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?OVNqTjJyMFFmbXpFWHBaa21iMnRvN2pRUDQyY0Rkc2c1VDc3TVJNa0Jqb0JV?=
 =?utf-8?B?N1AxTm1uQVpkTWRXbDFtSnNmeFZ6TEdlZFZZdXFMSDlpK1BDaVFSK3VjSHg1?=
 =?utf-8?B?dDQ1d24wYytZRFg0ZjJDZ1NuZkxFbHVJUDRyUzBpUGhnbkY3T0dmRUtxOFh5?=
 =?utf-8?B?TkErTkJxODVleDJXN1FGdmQ4VDBycVhJVWxXNmZBbDVLaFdoMmw2Sks2ZlRi?=
 =?utf-8?B?eENBN1UrTnFuK1NMVDAvQk5RZnd6MlovbnRDbzR1RFdBam84SHFzRkg0T0FG?=
 =?utf-8?B?STNTR05iNE5SUmtGOFRIY0YxNFBaaWg5MElZQjN2V2lsV0l2SUN4ZS8yNElU?=
 =?utf-8?B?VXVsTEZiODhwcW45bnZCOGpzYkZEK3NzaHl5TWJ6akY2WVIrd0ZZTExLUGdY?=
 =?utf-8?B?NkhYYyttWW9mZnZ2OGJCWW8zRy9pZVlMSXdNaDgvZXhBS294V3dpNHZTUmF1?=
 =?utf-8?B?bkg4ZEJlZ05XUUJRMngvRWsxekpEdzFWZHFOaXQydHRJL1lJbTdJUHUrRkli?=
 =?utf-8?B?eStmYjdXa3FOTWJlb2Y4eTZETlQ2U0VaZnFDWEIweG1vNXFMTG9JcjFuR3F2?=
 =?utf-8?B?Y2ZkaVBkZWJydnU3Z3hYUkJKRkVRMU93cW41eUgrQk5TRTdkTHZ2NFNxWk4w?=
 =?utf-8?B?bVc3bm1FV2VKcUFiSXd3ajRrbU1tcEx6U3NmZmFmNXI0V0VEM1p3RDVUZ280?=
 =?utf-8?B?WWJGN2JLL0NUdnZsN1ZlV1RMYkdWQnBtUUhZL1JVV0dMR2N4SmhZVXFnKzNU?=
 =?utf-8?B?dEhBYVBBU1ArMjlLdFByWGRvd1lQU3ZqYjF2MGU0dUtVMHpGR3JLTHdXVDQ0?=
 =?utf-8?B?YnVBWURkNW9mejM5ajB5TnNweCtDb0MzeTZqcVQ1UlZZNWhMS2tRVjZ1Wkk1?=
 =?utf-8?B?WmFTV202em1HWjJXTlFqU2xPS1Q4aUN2TFZKQ2lGWVJCVGNJbjk5a3RWTDNl?=
 =?utf-8?B?bHZaSVJUT2ZsdHNYLzBONnBkRXJ3VXhGem5FMjc3VE5nZmZjQU1CaTdwQTUz?=
 =?utf-8?B?K1N3bEJha3hIZERSbVpDR2ZZSEFMU0xGV2t3eTUwSlkveE5SM3FKL0I3K1lx?=
 =?utf-8?B?UnczNHQ0WjNFUVJ0cCs3VCtIMVJudzNYY1FLblRoMmVWZmZhYk55QzUzempJ?=
 =?utf-8?B?UVFSK1dycWhqSTg0VE5HM25SSW9NZVcrcUZjdG9zTTV6a3RxZm9IZXJ1SWJW?=
 =?utf-8?B?SkNKT1d5TTlqcjdlMEpVcDM3YTJCb0RZTWlIbUtQcng2dzBZZ0NxOXV0MFQv?=
 =?utf-8?B?M2FTZ1pOdEVxakFjcmpkVXhKd3d3dlYxdDZBMmFiTjBJUDZXbGdmV295ZHBy?=
 =?utf-8?B?T1NTY2pucjI5Zjl3VGZjWlo1YW04MXJiTTdBWXBkZVhkRVNZSEY3aEtQS0dv?=
 =?utf-8?B?NGIyNHBiMCtvdnJyMGh2elgzeDVvaG5LMG43SnpNQ3ZUcER2M3M3eUxQTTdR?=
 =?utf-8?B?R3gzbTNaSjduR0xBbms0TE5VVjZKVkdYTXIra1ZzNUV4QUdjcGlKUnl6WFJM?=
 =?utf-8?B?dEpYVjZwM2g4c0JYbGZ1a1hkdExRTEZML1drKzMvVUxmdXNVWjROR2N2L2M0?=
 =?utf-8?B?ZWJaWk43Rk03djlLSWJOL2pHUmdCYUN3ODMzSjhuY0cvRCtOamJZWkFaZEJC?=
 =?utf-8?B?bWtCQW8yV0hWVXlGMjA0VHA4QytiQW5qZkpzM055L3EzVGgzZFZKSFlXQkN6?=
 =?utf-8?B?aVE4Q3N6S1JXVm5KTElUdWtnWEpPaElmbDREWlpRaTRpalhLWURqbWxJRDJO?=
 =?utf-8?B?dEQyVFhMVXc5aHFXNXVlcC9XS2tyOXhYS29SU2I2MElQYmw4SEhvNkYzZFdj?=
 =?utf-8?B?SDFDUS9xN2llTFJGOGltMWdqeGtackpSYTNwOWl4OVlycjgwWXorYTVBQ0hz?=
 =?utf-8?B?eDEzMXluQUVrOGh5OFVrdlp1TE11eHhyZTBxdzlyTHhld08rTHNTRUkrZ0Mx?=
 =?utf-8?B?R09paFpKZFB2T253ZGs5b0JBZG1ocXI1dkN6N0t4T0R2bjNpOHVxeXdKd1F1?=
 =?utf-8?B?ZjRhazc2OFlBb2pwYS81eTFxUEp5dU03eG9Pek1IZ3BVa0M5ZlQrY3RtS3Fz?=
 =?utf-8?B?WDRKcGY4dHkwT21aTS9MR2xuczY3cWpsTXEwUHZxdlNvWWwzMzNzVXF2TGxX?=
 =?utf-8?B?Wkd2OXlhNFJLZ3lINWxyK3VkSGE3ZWR5RWRRMzlZWkJSTkhlNFQxTDJheDNw?=
 =?utf-8?Q?s7iHZdDCY2hqbbiYTs204V0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlpsTFNhUUFHcE5aTHN6OTVlSUJDTjMzZFJVRTJURjJYR2pOQjZldkwwUU9t?=
 =?utf-8?B?dkptMlk1aldEWWkwQ0dkclU4Z2x0MEtTcUR4QUYvWjA2S3dnbXhpUnRCNnp6?=
 =?utf-8?B?c3ZkYnVNV3kvalNqRW92Q0Vuanl6MkhwUEdjeWpJMTYranZzWGxQK3VvVDZQ?=
 =?utf-8?B?WFUvei9lcVZ5b3IvbUljM2pxajBFRjQ4YWlDWEZVVkxBT3dNRWpEQzd4NXla?=
 =?utf-8?B?WWhsUlZ1NG10WTA5b2NzUE1HcXQzN3dzUk1lZWZoa1hhNDBQVVVzUXNVcDdB?=
 =?utf-8?B?M3F1T3JZWWU0VC9ZTGQrRHE3dmFwejZHOFN2cmV6NGJ6ZmFZK2FTekpVcnBh?=
 =?utf-8?B?dStnWHhOeVU0Y1EwaVZVSTl1M3hUcWVtUGozelNuMWNrTGkzY2l3b3BZL0Fl?=
 =?utf-8?B?dXRkT2VMZDB6SkpGeFdTRHlFYjYwM2d6dU94alhNNWZWdjZFR2hoenNLc2lZ?=
 =?utf-8?B?TXVUbG5veWZIUWJmbzN3YVU3NTJYV1FlWDBLbjNuWElNanlVdG5ySUV0RVdv?=
 =?utf-8?B?a2U5c0VlVVFvZG41ckVWcHgvbnptV0ZmcytjOHlZUE9URzJlQ215M0RUMzl6?=
 =?utf-8?B?ZWNNSHo5ek1GVXhRRjZ1K215MFlrQTNrR2NpM1VHbkpTOENsODJ1QUhsZUI3?=
 =?utf-8?B?RGU4R3czMCt2M2VWNExKZkJ5cWZUL25vVEw0UG9HUXpLSFVrYzN2b2F6ZVBI?=
 =?utf-8?B?THN1dU81b2x3Si81cmoyUVVOREN3S2RCNGFmZW5EN1Fuclk1OHhJRzNCTW9Y?=
 =?utf-8?B?dkQ5OTJsWGQxeS90YzdoM0dJU3I1V05oTTdZaUpKU0VwZHVoVUZJRFdCQU4r?=
 =?utf-8?B?azNyOU5LUTBjbmtmOXp3Z0JCTnMrWUhIRTVjZkZtT3pxWUdHcjJNeWM0LzZq?=
 =?utf-8?B?Y014dDZweFBGdUlva1FTN2ozRXVuWlB5WGhXR01yVnhwcy9zWG53TnN6R25o?=
 =?utf-8?B?dkduVkdXNUw3Tko4VHQ2RkUyUnJYNXVrSHR1bXMvVDdpZ2szcnU4RkplRGh6?=
 =?utf-8?B?YzJWSUZvdldKVUdPeUxYdFhsRElkandvaFFuV0lqSzUyNmtuUlFTUGFSMlVq?=
 =?utf-8?B?cjhGUmZsZXpjVzhyNWN5eS9uTHU1N09FeG1zOWZoOUY2Y2VnMkJZUldZclRx?=
 =?utf-8?B?OE44NDQ0WDd0S09vK2tWTDZOZ2hnWXJrVU5tdmdNVWlXVXE1NkN6WURsVWdO?=
 =?utf-8?B?R29tWDQwUU1kMkdHUFViWHU5UWVtNjdyR0xnbFUyakI1c2ZuNGI4SmRqTzNn?=
 =?utf-8?B?eGZQMlVhbjFrZTU1RW5IOEZBdjIvVVpKaUpqUzNMTXI2YVcrTHhhVGt6Zk5C?=
 =?utf-8?B?T29TZ1d4enlhZ0taV1BTZGZEa2JzYlE2OFJNSjQ5MFM5RDRPQVMyc2RPQmhS?=
 =?utf-8?B?eHR2N0lMVWxwcjZXcXJKYzh3VkdiZWw1T3RVZ0g2ek1WU1FjVDdvbXFvU2V6?=
 =?utf-8?B?NkxvSE5odzlaWWRaS1E0WDZCUDZEV3B5M09jTkZOZ1hlUnFyZllHVkRrNXVR?=
 =?utf-8?B?eDRmaTJPdmRrZFlYdzhwc2RhV0lGNm1pNnU5THJkV1Vud01uTFJ5bGJJdjJS?=
 =?utf-8?B?L1FNT2hHVmx3Ykx1amZVN3NkUzZVV05DWUs0RDBCVGQ2aG9NVDNCclBzYnpO?=
 =?utf-8?B?VjNpc0hQSEVuVzBIYXQ2NFJsUnpFUVBOeEpOZTRXWXNONFBYWkVuYVpJbEtu?=
 =?utf-8?B?dTNKMTJGU3FJamJyQ3h2aVRrVER6bGd0TllEMW9kREM1ZlIvQWdOeVBnaFR6?=
 =?utf-8?B?alh4b2RDdlBGaDA4TndXbVFuVER2RlRRRXB0eTlyZnIzSy9ubXpFMXVkZndJ?=
 =?utf-8?B?TVVLN1JKUVF4WEdmNUVpeFVnZVI0c2d6VlRUTXRydXgxSTBNYXJTM1Y0TWov?=
 =?utf-8?B?RXc5WUZJUGVOREhETDFvazlkdDhYdzJYZ2VjZXhJQmhpanZ4Zmx4ZEpXL0pU?=
 =?utf-8?B?Q20vT2l0NVpBR3pOZHBraElwa21HMkNydG52dXJnVFd4WDlRNlhkd0tQUS9y?=
 =?utf-8?B?dFR0cDg3QmhQbUtRcVJXRWt1UmREeDIrcHNha3pJZWNDWDdyS3BId1VUaHg3?=
 =?utf-8?B?R1hzcVN4c0NCK0M4WDlka0dUTHBlZ050QzdYQnVHaWlVY2hYdndaZlZuVGUx?=
 =?utf-8?B?cW80eEFUcjdXQUNwNXlzelBPUUUvMyszcFBJeGtmemJQQk9jUjJKVVV1OG9m?=
 =?utf-8?B?Z2gzOFdRWTgva25Xa2haTmtReVBtNHJ2Tm5oemtNMXpiZmkySjBUYjlBc1FM?=
 =?utf-8?B?bi9RMHM0Nk1vTnZBSHByUVpZMUhVZU5lN0xuLy9yZFJ4bWsrT2xjeEJISFVs?=
 =?utf-8?Q?3SOqcBJ3nTsyTVk9Km?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4670cb63-e846-436f-d8a8-08de5a459c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:06:55.3645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq6lNAUrSQ1ujs2yifgSTxePlb51LreyyJnDWn7cZK/GAKOUibVlYVEFCLX0cCDtzDBzdka0basezOljlvj18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KU2VyaWVzIGlzDQoNClJldmlld2VkLWJ5OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5j
b20+DQoNClRoYW5rcyAmIFJlZ2FyZHMNCkFzYWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBUaHVyc2Rh
eSwgSmFudWFyeSAyMiwgMjAyNiA0OjE0IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS2FtYWwsIEFzYWQgPEFz
YWQuS2FtYWxAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIFJlZmFjdG9yIHNtdSBmZWF0dXJlIGJp
dCBpbXBsZW1lbnRhdGlvbg0KDQo8cGluZz4NCg0KT24gMjAtSmFuLTI2IDExOjQyIEFNLCBMaWpv
IExhemFyIHdyb3RlOg0KPiBQcmVzZW50bHkgYSA2NC1iaXQgYml0bWFzayBpcyB1c2VkIHRvIHJl
cHJlc2VudCB0aGUgUE0gZmVhdHVyZXMNCj4gZW5hYmxlZC9zdXBwb3J0ZWQgYnkgU09DLiBUaGUg
bnVtYmVyIG9mIGZlYXR1cmVzIGhhcyBncm93biB0byBuZWFybHkNCj4gNjQgYW5kIGNvdWxkIGV4
dGVuZCBiZXlvbmQgdGhhdC4gSW5zdGVhZCBvZiB1c2luZyBhIDY0LWJpdCBtYXNrLA0KPiBpbXBs
ZW1lbnQgYSBkYXRhIHN0cnVjdHVyZSBhcm91bmQgYml0bWFwIGFuZCBtb3ZlIHRoZSBpbXBsZW1l
bnRhdGlvbiB0byB1c2UgdGhlIGRhdGFzdHJ1Y3R1cmUgaW5zdGVhZCBvZiBkaXJlY3RseSBvcGVy
YXRpbmcgb24gNjQtYml0IGJpdG1hc2suDQo+DQo+IHYyOg0KPiAgIFVzZSB0b19hcnIzMiBpbnN0
ZWFkIG9mIGRpcmVjdCBhc3NpZ25tZW50DQo+DQo+IExpam8gTGF6YXIgKDcpOg0KPiAgICBkcm0v
YW1kL3BtOiBBZGQgc211IGZlYXR1cmUgYml0cyBkYXRhIHN0cnVjdA0KPiAgICBkcm0vYW1kL3Bt
OiBBZGQgc211IGZlYXR1cmUgaW50ZXJmYWNlIGZ1bmN0aW9ucw0KPiAgICBkcm0vYW1kL3BtOiBS
ZW1vdmUgdW51c2VkIGxvZ2ljIGluIFNNVXYxNC4wLjINCj4gICAgZHJtL2FtZC9wbTogSW5pdGlh
bGl6ZSBhbGxvd2VkIGZlYXR1cmUgbGlzdA0KPiAgICBkcm0vYW1kL3BtOiBVc2UgZmVhdHVyZSBi
aXRzIGRhdGEgc3RydWN0dXJlDQo+ICAgIGRybS9hbWQvcG06IENoYW5nZSBnZXRfZW5hYmxlZF9t
YXNrIHNpZ25hdHVyZQ0KPiAgICBkcm0vYW1kL3BtOiBBZGQgZGVmYXVsdCBmZWF0dXJlIG51bWJl
ciBkZWZpbml0aW9uDQo+DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVf
c211LmMgICAgIHwgIDQ4ICsrLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9p
bmMvYW1kZ3B1X3NtdS5oIHwgMjA0ICsrKysrKysrKysrKysrKysrLQ0KPiAgIC4uLi9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMS9hcmN0dXJ1c19wcHQuYyB8ICAzMyArKy0NCj4gICAuLi4vYW1k
L3BtL3N3c211L3NtdTExL2N5YW5fc2tpbGxmaXNoX3BwdC5jICAgfCAgMjQgKystDQo+ICAgLi4u
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL25hdmkxMF9wcHQuYyAgIHwgMTE5ICsrKysrLS0t
LS0NCj4gICAuLi4vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jICAgfCAx
MTYgKysrKystLS0tLQ0KPiAgIC4uLi9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjEx
XzAuYyAgICB8ICAgNSArLQ0KPiAgIC4uLi9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS92YW5n
b2doX3BwdC5jICB8ICAyOSArLS0NCj4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTIv
cmVub2lyX3BwdC5jICAgfCAgIDQgKy0NCj4gICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9h
bGRlYmFyYW5fcHB0LmMgICAgfCAgMzcgKystLQ0KPiAgIC4uLi9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzAuYyAgICB8ICAgNiArLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jICB8ICA1OCArKystLQ0KPiAgIC4uLi9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF8xMl9wcHQuYyB8ICAyMCArLQ0KPiAgIC4uLi9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF80X3BwdC5jICB8ICAzNCArLS0NCj4gICAuLi4vZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNV9wcHQuYyAgfCAgMjkgKy0tDQo+ICAgLi4u
L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzZfcHB0LmMgIHwgIDM5ICsrLS0NCj4g
ICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyAgfCAxMDMgKysr
KystLS0tDQo+ICAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTMveWVsbG93X2NhcnBfcHB0LmMg
IHwgIDI5ICstLQ0KPiAgIC4uLi9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzAu
YyAgICB8ICAgNiArLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8w
X3BwdC5jICB8ICAzMyArLS0NCj4gICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0
XzBfMl9wcHQuYyAgfCAgNjkgKystLS0tDQo+ICAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTE1L3NtdV92MTVfMC5jICAgIHwgICA2ICstDQo+ICAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211
MTUvc211X3YxNV8wXzBfcHB0LmMgIHwgIDMzICstLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211X2Ntbi5jICAgICAgICB8ICA4MiArKystLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmggICAgICAgIHwgICAyICstDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfaW50ZXJuYWwuaCAgIHwgICAyICstDQo+ICAgMjYgZmls
ZXMgY2hhbmdlZCwgNjYyIGluc2VydGlvbnMoKyksIDUwOCBkZWxldGlvbnMoLSkNCj4NCg0K
