Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E3FC8303F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 06:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0912410E6FD;
	Wed, 27 Aug 2025 06:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VCBdoHbo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D26310E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 06:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik7I5cp3nZAWitbLUP92apgRZpVGFj+mnCqiFyAmSs9UQH1yz1mYs/zSZPDdTYboRK6h7FCxH4HYRyOGAz8lnvfSlRlFkITC6DFwjMT0AxC3vsO0DXlmfYlusCo8gm6AbiZGA5KAOuLhuQEZ0p2gmPzkMoUVWOqt0pm6CYHQfSdZL2qvbx5CtdkP9YGWQ8NDbB7F5TxugJxFcpU8s6NdjU3g7BzTONmv4ivCbAAKiog4cqjFYVI1hz9rIv9LBwYd1+bcijClZk6dBX99YPCu/yc2lpIW9t/+HtVJfZMw+p+bgN4z5seuB85q9YuMc9k/j3wK1lztK0Pd/NniRTfysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWhhoG95mPEQv0/1V7yleCq12OGXhr0qTm9zorL15lk=;
 b=KNeO9WfeODNMFV+OdhY1Og2TWKy7qmaSerE/SOpIDJCeyrnEcinNTdp0QTN84gwJ1FzTfWwohqp+wHDU+oosR8ALS0ByxPhcyFil271D+viBJ+FntOVQca5G8YyJTK3x7lj3c6pMbygh0AHJ558miGWF4Pzmw8B1GPzJxSJB0AI5xru2KjnWsMjXmoOkMH96boPlQEH8u221pmNHlFj9AqYCwukDonkEUNmNyT+5Pbe2ZrQXp2NJHrG5L4t5mxv57VE9kuSW+yX9mp3b3AJrFsDnozWX166+OdrZu8Bj94eN475z3hPNIg42bdNXEvDL8KDOU9OgtP7Go+WH+Sisbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWhhoG95mPEQv0/1V7yleCq12OGXhr0qTm9zorL15lk=;
 b=VCBdoHboOoio+QfPmsX5brvMfIErwFtY4e6fvR81F68DmUNNW6GcWaewedjA+vL6Wyn+kQCFnx0ItrjniYUIcm4agI2cSGEfOlE+MkOmo2sA7dzYmr/ab3ZWkVhXEp/p3o6IfEaSE0/l03vB+7OUuJQ1maoDjYxrPBuaD+LoT3Y=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 06:14:52 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Wed, 27 Aug 2025
 06:14:51 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/userq: fix error handling of invalid doorbell
Thread-Topic: [PATCH] drm/amdgpu/userq: fix error handling of invalid doorbell
Thread-Index: AQHcE4AH7X5i3u+qG0uXF8IEEe7x+LR1Ji6AgADma1A=
Date: Wed, 27 Aug 2025 06:14:51 +0000
Message-ID: <DM4PR12MB51527424F7FCE066A2333B75E338A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250822161515.1089247-1-alexander.deucher@amd.com>
 <CADnq5_OXrEs8uJVobzufB8E4tZjTDnx-vT6Crr_+4_=PX3Sq0Q@mail.gmail.com>
In-Reply-To: <CADnq5_OXrEs8uJVobzufB8E4tZjTDnx-vT6Crr_+4_=PX3Sq0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T06:14:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN0PR12MB5858:EE_
x-ms-office365-filtering-correlation-id: 904c057a-c933-4896-097c-08dde5310896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkUxMkprSWJOdlpSYlRvMnRiUDhiWUZnSjJXT3poRUhOSnRTeDBreDh5c1Nj?=
 =?utf-8?B?QjZBbk9WQXhQdnpIQ2hud09yZEROdFAveCtkWkJxQTJacWQwZ0JPcm9KTFNx?=
 =?utf-8?B?ekxLZUh6QUNuVlpBSkUzL0dsc0x4YWhoUHJvT2pvayt5NEExNXRkbzh4VEdG?=
 =?utf-8?B?Vi9LLzZyMENhUmNYc2pXQUlQK3IvUU9ZWHlHZzYzU3gzbzUvRFNOTTM2enVD?=
 =?utf-8?B?SGxtYThtbWFpa1c1c2p3MnlDMGh4d25lYi9kanpMd1d6MXVnY1F4SHZDK0JF?=
 =?utf-8?B?T1JBVTZZSVBFY3MrMUZPTVZpRDVGaHkzK0RyVVl6cWRLRmJ6eHRjcDNoZ1BL?=
 =?utf-8?B?VlgzdmlrZm9mVXhHK3EwT09td1hrR0l5c3BFRUtMV25NbmZjUTBwUnFxMi8r?=
 =?utf-8?B?ZHpyNTN5WkZ2bzdXL0pyUlRJUllCMXpvNHgvdzN0ZGczR0hyOHY3amdSWkRq?=
 =?utf-8?B?YjBvL21IUmw3M0VWQmVOdDhEYytvK29rMkgxWWtjT21PaWVuY0dBS05BdmZ6?=
 =?utf-8?B?V0RPLzE1bGFYMUlZUUU5enNBODFZdGs5dGhycWhsMGdRMFJsTlpjNFlpdDNL?=
 =?utf-8?B?dldRZGh3bWtzUStldnp2TGR4VjFndXhjRHlUVTNleDhTY0hJSTNDWThZMWdw?=
 =?utf-8?B?RkUrR3FJWlMwOHNJek5HTld4NXl3UHRGV1g1eXhvUDRFa0szUXNDamdiOVlT?=
 =?utf-8?B?V0pCRzYyS1czeHdFa1FLUzZ5NUFlNlprVjUyYy9ueWhRRnp3cC9WdExUT2Fs?=
 =?utf-8?B?bmhZc0NVV3NRUXZOTGhoZjRXakdzR0J4Rkx6TExsNHpvN2dDS0wrYjBycDFr?=
 =?utf-8?B?YUdQR3BqMHc5MTAyaENNRFhmcXdpSWc5QWpRd3cyc1Fxa01WYXlGRW9xdEZq?=
 =?utf-8?B?THBsNEgybUZWOFk5MWFWY1JDVC9lYUNlTnE5Y3VUWmE5eTdaVFpINEdSQThN?=
 =?utf-8?B?U1R0MFZNNzJyemFraHhZNmwxK09yRDNYZ3NibFJCMiszdXN4aWZscFZtNTN0?=
 =?utf-8?B?eTZNM2cwZ09EODlSYThXdjIxUDRhN0ozQ0VCUTJ1STEvTW5UZnk4eEtSaTcz?=
 =?utf-8?B?SWlDSnRQclIyYzJmc2NuVlFrUEZSTnd3dXFYTllrSVNkaWFrbGtYay9JM1pW?=
 =?utf-8?B?ZjU5TW43ZTFWWUUxMm1YeDF4Z2I3SEVHM09sMkFKdGVRNnk0YmdaT1hjSWF3?=
 =?utf-8?B?NW1MSU5tckRBU3FJV21ISFh5dWJqMkRHanhycmFWYXJLQkpSd2hINzIvalM3?=
 =?utf-8?B?WUZFZnFKVkxNSUtZOHN2R3J2cFZkNEFlcm5xVXBvelMvWUNMcmVMcHRJWS85?=
 =?utf-8?B?N0w0WlUyQjY3M3dWSlFKbUcvVEc4LzhVL2RQby92ZU05d3YxOVQzZllCd01o?=
 =?utf-8?B?WEMyeXZUM1I1c05XRVJ3YmFORzFIL3VaallDQU5xc1J0d2VMNTdZc0NGV08v?=
 =?utf-8?B?ZW9wQ1hZU01hMFF4bm52WDFCWmc1YXJHNVdsZlQxL1d5UjRxa0NvZmhuYUth?=
 =?utf-8?B?TlNBc25zaDNHbWswa01zeklXUXNSMzd0dHVIL1MrdjlBTENWQ09mVkdud2VS?=
 =?utf-8?B?RDFPRHhFdEoyMGlDTVc0cm9NK3E1S3RGVlEzZWEvZkhHOEtjOGg1aWdrUmJi?=
 =?utf-8?B?aXU2dnNPMklhMUtwZThGdDNHczAwU0FPTjRDR25lV1hQUk91aE10YlFSRy9W?=
 =?utf-8?B?VlpaeFpiMTVETWoyVHVPZFoxZUhMSk9EN0dGU3BtM0IxRDUwMmY0OGxlZ1Fq?=
 =?utf-8?B?eXErMUxaK3pSYUVCSkFaWWFLUnVxc2ZEajF3emRXUnBkVHlKZlE5M1d4cGUy?=
 =?utf-8?B?ZFNGQ29BMDVieUlkYUxBSmVHSG5UVjBLanVjd1hmWjZjQzhlU1I4SmU1MFcr?=
 =?utf-8?B?aDE5ODlNME5XRE1kNVlDakFjOUhzM25RRGk3V0dYYUEvc21NcGM4YXpSS2xk?=
 =?utf-8?B?djRQdHdjTDA5QjAxY1pmbXFTRTcxUWR6K0F2RGVpUkJsWFA4UG51UEs5TnNz?=
 =?utf-8?Q?ldRfO0TufNQ4313Ak33PI3uVroJmcs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUVoTDA1OURmSmJmWG4yYnFtZnBiWHR1cEhzeDlyL1Y1VUdXcHE4MDk2SUFx?=
 =?utf-8?B?eldoYjBoNlF0ZnVoK2dPcGxBSm9GODVnQk93em5teitYRDdPNkJXQ3BkUjBa?=
 =?utf-8?B?V1pabjk0QWovWDQ2a3F1bWpIRkRNcmR5VkhXSTRETElnaU5NYlhzQUp0djJw?=
 =?utf-8?B?QVUwam95WVhFVTJxbmE0OENVTkhOZTRkVkhKZTJvSmhtVGZ0blJKNU1xUS9x?=
 =?utf-8?B?ZXNOY3JSZCt4Q0V1Y1BFcnlsUEMwUVNTVDN3aWRiQkliaDRuWFF3UlE0REJr?=
 =?utf-8?B?UWJtZmFKNU12N2h0RDM5SXpEbjJiU01QblVMakZwT3hROVRZTUl4VHVmdndt?=
 =?utf-8?B?YmVYckZ6RXIzcU9oUEx3WDFMeXhTeHFXSEFWQ09meHljaEh1bDVRZ1EwV3Fk?=
 =?utf-8?B?ZGdjU3RUWkVwa0FQYjN4U2NWTVErVURUbXVzTWJvQTBmQXBvdCtGR0FEeDI2?=
 =?utf-8?B?RnBaZGJTL2Voa05WU0JpTjZMQVZIaGlKRUExMDJaNnluajdWc2wvR0ZJdGxv?=
 =?utf-8?B?eDdZcW10aDdoeU5DOVR6UEpsWGZ1M3VMdXl1bGQ3RWJjUUtOaDg0V0pyU0ZL?=
 =?utf-8?B?b3lXVmVWVTJON0NyOGk1WXB4cTlkRlMxY2dkeHprUEwwNVRUTEpDWlFKMkJ1?=
 =?utf-8?B?em42TU5odG4xbnhvZVNRNlo5L1ZNVVh2NlIyN1htRVVqM2RNWmVHNEtBbXYy?=
 =?utf-8?B?c1VLTTVGVHJBMmZrM01jMWp6eWNLTGFIRW9vNWlGZXVQNXI1Y0lWNXhtM1VB?=
 =?utf-8?B?Tkh2Y3FQSjNicGlUUHl1Y2RrTmRUK3Fnd1QwbG9vYWl2MzAxbW1EZjhRSW1H?=
 =?utf-8?B?eTEyRjh4ZlNwK0VBMjY2dGd0WGQrNVZDOFg4MW5KaElUbGwyTWVteFEwUzJS?=
 =?utf-8?B?eGRSajFHWE9HK3k4Y1J2RUlBdy9iWTlWMm15OHlJZFdZTExBVzl1UEU0RlZT?=
 =?utf-8?B?dHNsUGoxaDcxUStoTHd6Z2dVdTVFRzNPUFE3ZHdvQnM5eXhCK2l3RGdqY1JV?=
 =?utf-8?B?NlFOTkxqdFZyNGN0Rlh5R2Z1K29oMWRXZGZSNUtmK1lidHRVZysyc1Vmemdh?=
 =?utf-8?B?amJBSFlZclFybW1oUnlaejNnSnhRK1VtdUZCc21US2ZvUjhHSldLZExRalRC?=
 =?utf-8?B?QWppRHJZNThnWVVLTVdIb0N0Mnp4UW5MMVo4M29YSDlQTklxUVRhQTFVYUZk?=
 =?utf-8?B?SEpSZFdwcEVkWjIyTHA2MzVocHk0c3RyZ3RyclZrYkxMTm94MzJuYUpORzZa?=
 =?utf-8?B?RmRka25id1JHc2dldi9FaElmdG9UYitzYkY3YmlDa1o4b08rSm84dk5HdGZi?=
 =?utf-8?B?K2ZIVDhFZCsweTNieENaWWZITU45M2pSaGg4TFYyM0dSL3Z2SVV2ckwyaVhE?=
 =?utf-8?B?TytKRTRYQVl2UU4rREx2TE9UbFA3MCtxYUNnakRiWTdPa0VTRUxGSlRUanUy?=
 =?utf-8?B?NlZpUitOV2ZyTFUzSjUrS2RNNFhxUTNaZHFuMklrUmUyZ1J2UmRqRkljZTYy?=
 =?utf-8?B?WlhielFoeTBrY3JYRU1sR0o2RitLQncrZTlrcFhkU2psL01VNDRQejBwRDYy?=
 =?utf-8?B?SHdHZFFTcUJmS1Jtenk0TmdhSjJIVHkrY3dYYlp5TE1YU2FUNzhjN3FLdld6?=
 =?utf-8?B?K1ArdXpDbXpvbURsMVVFZHdsdzg5c2NEVHd6SDMrZ295Y2JWN2dTK1N5YjQ4?=
 =?utf-8?B?Wjlpcnl6SW93UUhEdVJsN0dyNVJCRFY2QUxDMVEycCtMMm5IanhlMm5aM0kz?=
 =?utf-8?B?QkJ6dHgra0tkbHgvejVOeE44eHIxdnplU2wwRzg3Ty8xVGM1anN0bDg0Mlgr?=
 =?utf-8?B?K1VDN1VHKzBpVDJ6b3U1ZnJKcjBsVDROb3d6NmYzRkNDc3FSNFEyL1VidHYy?=
 =?utf-8?B?RjFvWVc1UkJuSStLcjZuc1JlQ3dqTitpSFRtdDM2ZUQvZjBBREh5Z2RXMTNk?=
 =?utf-8?B?NmltcDZRempNRzdTRW42SXFaUjZyWUZoOEY1SkswUHQ3TGcrMTN1RTFvZzFM?=
 =?utf-8?B?R1hPcFpOTHhHbGRsc0dLRzlhTmd2NFd4RXhyUW5paG4yZllvWXEyZ2xRZFpm?=
 =?utf-8?B?T2JjZE5Ga3daOUFVb1pKaVVaWjFoc1owWEE3djRkOGVoNGNZRis3OGcySG9y?=
 =?utf-8?Q?V6h4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904c057a-c933-4896-097c-08dde5310896
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 06:14:51.6344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rESDVvffvIWIiQbzoMaVYt7swTpaqrwgHPO43K+nSBsAHe2IZmkN7gIZpiVkZ6pct3KS6CtjEkC91seObjJ7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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
Cg0KVGhpcyBwYXRjaCBpcyBSZXZpZXdlZC1ieTogIkplc3NlLnpoYW5nQGFtZC5jb20iDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBX
ZWRuZXNkYXksIEF1Z3VzdCAyNywgMjAyNSAxMjoyOSBBTQ0KVG86IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS91c2VycTogZml4IGVycm9y
IGhhbmRsaW5nIG9mIGludmFsaWQgZG9vcmJlbGwNCg0KUGluZz8NCg0KT24gRnJpLCBBdWcgMjIs
IDIwMjUgYXQgMTI6MzPigK9QTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+IHdyb3RlOg0KPg0KPiBJZiB0aGUgZG9vcmJlbGwgaXMgaW52YWxpZCwgYmUgc3VyZSB0byBz
ZXQgdGhlIHIgdG8gYW4gZXJyb3Igc3RhdGUgc28NCj4gdGhlIGZ1bmN0aW9uIHJldHVybnMgYW4g
ZXJyb3IuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnEuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IGluZGV4IDQyNDgz
MTk5N2NiMWEuLjI4MjQyZWMyMjE1ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jDQo+IEBAIC00MjYsNiArNDI2LDcgQEAgYW1kZ3B1X3VzZXJxX2Ny
ZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIHVuaW9uIGRybV9hbWRncHVfdXNlcnEgKmFyZ3Mp
DQo+ICAgICAgICAgaWYgKGluZGV4ID09ICh1aW50NjRfdCktRUlOVkFMKSB7DQo+ICAgICAgICAg
ICAgICAgICBkcm1fZmlsZV9lcnIodXFfbWdyLT5maWxlLCAiRmFpbGVkIHRvIGdldCBkb29yYmVs
bCBmb3IgcXVldWVcbiIpOw0KPiAgICAgICAgICAgICAgICAga2ZyZWUocXVldWUpOw0KPiArICAg
ICAgICAgICAgICAgciA9IC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICBnb3RvIHVubG9jazsN
Cj4gICAgICAgICB9DQo+DQo+IC0tDQo+IDIuNTAuMQ0KPg0K
