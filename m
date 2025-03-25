Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBAC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 04:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991D710E37A;
	Tue, 25 Mar 2025 04:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X7moLt/T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07EF10E37A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 04:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq4qpCFg4U7bwDFPDB5NuLWHdUGKejCSCDA6W4loSXM7zYA9SFt2qN2IjnFC6+dSw5Ab1y/qOZ+zQV2DhFF4c945Gq+twFUcILIhp+rGrnWpnDIMksnHC/fpe/k/SvWy245JskwDGCSZlz6qISulB6V/ph8C7adDPV6aoj6CcHDe1+JL+v4XEme9zZy1q/ZAwDPfa007ElIRyJeWsD1gEBhugXkWvlTGFcmcVjxgpnMxLjwayP458ndZT/oWfaOGfmfN4k/fFz8AkaBkNr/0GKac8yFavFLGoVtW0OX0nGw9QD370NpFbkaAJp7EcKbLt3UyyDnQbbKrLXXg0AiBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19od+9xV5yYNGjdXvzc6KPAFdSeKeFu5IXaIxOwWvNA=;
 b=Q+Og7EyFusQ/QeB9Ukepbe2VQn2PL/66ihVOQ2WURYaCQZ40K3wQNDfI5b8QFL0nWvzKuQWgISJ4r8kKL0B6xWPxpF9XqatsBls4jSG55AYWSpEsraMtkaTU+bodNI/G+SeSue7OcR85dGLJa/A/ngGbkRgz/3c2u8E5LWrQMDWcs3/C2FEoMMgUiouLR33gGymUv3IzPb0aJi+vSNKiLytKDpuQayBOyPxQYXAPrkwMpbGaZNCdksMgzsROdBYmbzZBvGKA+3Ahb5A6thxCkAeLMoy1PW2FOjbyaQY5Cvab/d2Z4OiKxKMI2KufL7PJMfbTWoJAif44CCLO9U3tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19od+9xV5yYNGjdXvzc6KPAFdSeKeFu5IXaIxOwWvNA=;
 b=X7moLt/Th9e8a2CsgejDSjbMmIZCv2815lxboKwt/6YvTzHin63YNCq/CdwLCDSYCPakfPleTUx5Nir+aO888490UP0xcEY+KUX4vcky6h8EqkwwAlQxlEylc+r3/4BRwtbbHNlRvmtCCTiLu6bZYaYK4sprMW0nbINl0yVt7Xs=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 04:36:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 04:36:27 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: =?utf-8?B?VG9tYXN6IFBha3XFgmE=?= <tomasz.pakula.oficjalny@gmail.com>
CC: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
Thread-Topic: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting
 support for SMU 14.0.2
Thread-Index: AQHblecZ0V94ASVXaE6Oa/n51BMfm7N5vn6QgACOugCAAGOFAIAAAdyAgACjA2CAB4ClgIAAfBKw
Date: Tue, 25 Mar 2025 04:36:27 +0000
Message-ID: <DM4PR12MB516540EA11DBB4E08C4003DE8EA72@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
 <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
 <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmxwYYRRzv28ETV_fVF2z=saUuSjaY0Z3aTiEefyq9BKYw@mail.gmail.com>
In-Reply-To: <CAFqprmxwYYRRzv28ETV_fVF2z=saUuSjaY0Z3aTiEefyq9BKYw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6dec810a-c703-4fd4-9c79-a427aff395a2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-25T04:33:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DS0PR12MB6534:EE_
x-ms-office365-filtering-correlation-id: dfb79ccc-d0e1-4ed7-71a9-08dd6b569b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWlORzVKVSt3QU5VN1NmUmRoaTJwdmREbEE3bmV1ZXN3L0p2bXFwWUZVWGlw?=
 =?utf-8?B?RFFVYTFWZ0RWdFIyclYyOW91WjQ4aW1aKzk0U1FTWVcreTJzTGFhaERCbVQ5?=
 =?utf-8?B?Y0kwU0JvRWdIZThFTDVjeElVazZDT051ZFRTdVJ5V3dVTEFrMVdDQjMxYi83?=
 =?utf-8?B?NU85TWdDRURFd1V0RXlpWTVQMitBbmxFaFFDb2x2ZmRmZy9SYmUrSklFUVU3?=
 =?utf-8?B?VXRiK3lFM09naURWdVRydktKWHAxeHNnRTFwYW5IQ2NhaTViNHY0K21kVlFY?=
 =?utf-8?B?UUlnMXBwNVBjVnJialFEdXdUZ09TR1diZG5mekg5VFFQODZSUGVLdmNSeU1C?=
 =?utf-8?B?am8rYWVNRklQOWJNOGh5VSs4RXVSa2V0Wi9mVjdJdEhDcXBPelNjNE9MV2xo?=
 =?utf-8?B?T2d4ZGt3RTRac1o2YVN3RVVYWEtRWld2NW85bXNjbzlYeU1NQnJ2Q2FoYS9t?=
 =?utf-8?B?MzJDK1N0bE1xWGQ3WUZLeWNDM3lzdmo0dFpjQ0ZKQkhxd1dIZmNXREIvbWRk?=
 =?utf-8?B?aGg3SGN2WUtBSjFTL3ltQW1aYmNvRmZIRUxPaGVsWm9IZndsS3BFR09oMExn?=
 =?utf-8?B?UTlJcUtSelg1KzJuSmp2R2pocGh5NnRwLzJ1VWExRmM3c2NTSEVGZjIvdWNk?=
 =?utf-8?B?RkRRNmcyalBiMlNBTlBCQkpYZnhhcGJqd3ZYNW5rZUlOV0xRa3U0eTh2cWhF?=
 =?utf-8?B?TTZQUEc0UXJQWWdlQ0lWNCtDMGlBQUpSN1FDOVZWaUNKa2dOTWFSL2hSbWhp?=
 =?utf-8?B?a09EaWZKWmtnS1c5aEhhOXhOUUlPMk92eWtrcEhUS0dOT2FYWWlabmZVeWFz?=
 =?utf-8?B?aXE5UmpqN3ZFZk5YaXZVdGJOREUzTEVUbWlYUHNWZGM0THBZT0J4a2FXQkZG?=
 =?utf-8?B?YUtMdTE5SDE3TGlWQVhNQlVjdGI1ODh6bHF5WTdMUTZueFFUMUc3NzFXenpw?=
 =?utf-8?B?MVpTanNmSTZRMWhTM2lUNUUzYm9SbjdJcnZxOHE4eloxWTB6ZFh0cCttbmlK?=
 =?utf-8?B?emdMdEovN2x5TFc1cHdEN2FMbFVncG5ZY0licTJNRXdBMHVTdk55bkFRenpO?=
 =?utf-8?B?b3VjOU4wZFo4Q0FoYlBNQjFoTmJBUTJrRy9OMEQ4TkRpTmdwZVYyOFgzVlJU?=
 =?utf-8?B?NXIveGs0WXJGWUluWWtWS3laVEJXUGhHTit5ZXE5ZFhsN0RhMXhnUTlYMTl2?=
 =?utf-8?B?T0N3MVdnQno1MGdTREVXRm0xRzhUdzV2OTlhdWJvbkhWczMwQjdJYXMxRWxi?=
 =?utf-8?B?QWQ3RXEvSVh2QVhNUitKTHpoMisxSXlmNnZqbmphcytBSEtyNWZoNCsvRGhX?=
 =?utf-8?B?QkIyR3ZWcmFPdXJJVzNMeVpqdWZwUHZuL3V4WEJNM25jVzRYZHc0aUF0cnlR?=
 =?utf-8?B?QlkvK2ZldVJlait0SUUzeEtjUVJMZmk2aUt4NDJiN2pHUmNJeTk0eEM4SmYx?=
 =?utf-8?B?TVMxdEU5SlpaY3ArdndqY25DT0xlM1NBb1lnTnlhdlQydzEyUTh4U1RDei9V?=
 =?utf-8?B?blNXc0hhV05YSXpIUDRvVTZ2YVFnUEMrNmt2a01Gc2lrMjQvRUtOeWlMTGlw?=
 =?utf-8?B?VlNlWml2ZktmY0wwc0RLaTZnOERFd2ZFZHNPa2FJQ0JJckw1OExJYlo1TmU2?=
 =?utf-8?B?QUJQM0RQdnRudDJGRHB4QlVlblNyaS95UXlCUFRkZm5tc1dQWFVQa08wdVhB?=
 =?utf-8?B?NzNaclN1eGdxWU41SzlsZ1BKdW1pSGs4WGVLT2JhU2JDYkhQR2xUNmI2L3k0?=
 =?utf-8?B?bm5DYSt0YXJxSG82bGZrYk9rZ3dNM0lzL2VTanJtdFllSFBZTnZvMXIvd3ND?=
 =?utf-8?B?VVZ1NWduTG1ESzkrZDBYOWVFRk9lTWxSY0cyNTZsRkh3VUFQdG56RnF5VTdI?=
 =?utf-8?B?bUZsY2hNUVUxUHEvV1ZLbkF6d2RMY1dPWHhaVnRBaXZzdm8xSk9qUFFiYXdk?=
 =?utf-8?Q?lKbfTDKqocz4HNSJ28XcnkqXCmDsaVQ5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmlPbWJhOHBjcExFMlZtckVXYVBZOEFxQ1lmV05Rd0dOZlFTNGszdGhLNXhI?=
 =?utf-8?B?cHkzS1hHbHJPMlM1Z2EwYjYyV2NXK1RxeFVjQ2lHeXJRVWtDUTBmSC82bzdC?=
 =?utf-8?B?ak9PK2MzOW1yQjd4dUMramV1clM5RnJYcm5waXczdC9rT3ljQTVqWlFsNXFS?=
 =?utf-8?B?MDFVZUpJNmRyRkxjSUF3aUhQTnNhMC9FeThVMHhCNVFsNnl4T2QyMEw5cEI5?=
 =?utf-8?B?MmMyVTY5WWoyRUliRGFUU1hBWVZSU2hPZkVxUktNNmtUcjc4MDdIaXk5R3Zx?=
 =?utf-8?B?K1F4bVhXQlFlWEgzWTdLNDhGblhZZThVMFhlRklTbFh6RTI4dmhlRHdSSmNF?=
 =?utf-8?B?SGk4MmlIQ3BYa0E3U1JmTUVnZFBWSkxoVHQ5WGtld3pKS1dSb1diWUFhN2ln?=
 =?utf-8?B?SWpGR0ZmQVEyWFIvSWwxeFFUOXZ6NkNQYnZ2UzlLZGhZMHVrU2c2b0NycEFV?=
 =?utf-8?B?OGQ0UzZQR3E2VXR4b1FjY3JjeURsdlRMNGJualFnMmFjRzAzb3pld0luUENX?=
 =?utf-8?B?NlR4czJYZnp5MjhwOGVwNE5MdDRoNVhYOWZZYndyZmRlVDFUdlR1ZTdUYXU1?=
 =?utf-8?B?MXlYbVlrM0xqU1JjTFk3Z2MwTWpGdnZTdnN5bFY2OThTeDhNaWxiQXVXSUpB?=
 =?utf-8?B?UVRvMTZ4aC9jdXU2cnAyYVRaK3VaZVgzUHhvTzlDalhSaWZCM2Rwdnh6VUZS?=
 =?utf-8?B?TWQ3QTJpOUZmQTJaU1p6eVN4bjRDOVQ2UU5pb1Y2RndtRDFDNi9IVzMyUnVM?=
 =?utf-8?B?azhUQ2toSThoN2ZBb1VBK1hjQWlYZm5hbDExNEZwTkR3UENqUGhQNXorK0x3?=
 =?utf-8?B?bjZDb3RublZ2RVpLZmU4c0ZkcTM1TUsyK2JOeXhERVFhM3FJU2ZTUVlydlQ4?=
 =?utf-8?B?Njh2d0JqTUlxVjVzTGJ4VnZja2tKWHFrTWJScnlocTdya3FXMGZWeG1FMExK?=
 =?utf-8?B?NHp2UFYwdEZJQzRZNUsrV2R0cDc1NllUaEErYlE4RVFZY3ErYy94Q2dGUlNJ?=
 =?utf-8?B?eGh2NUJKaEwrTjllZGlsNEF0SUhjOHczMWVRY1RyYndMMWJTNmJoYnJsdmVV?=
 =?utf-8?B?TnVWdXVWRTl4QWhqa2xPNURCT0ljeUErak9VcGd5VnRVZ0RJRGY1OXFtQjUv?=
 =?utf-8?B?d1BNc2h1WE1zdUYyYk9lVDRheGdCeU5Wb24ycnRsUlJYK3MvdWRoQ2tMWllX?=
 =?utf-8?B?bWZUdW5UQkNIb21GQldJWTByZGJIUGY4dlQ4L2RIUXd6aXpxSFJVWUxKeXdl?=
 =?utf-8?B?NVpnSzJhUWJ1djBNVU53aFByaERvMVpQRUdLelZFM1E3RU8rWFZwMWs0Z3pG?=
 =?utf-8?B?cjRlMERmK3F2Wk5NRnI0aVA2aytTdktkTjVqNTdNSFpzR1FCejhiZGFzQnVq?=
 =?utf-8?B?MVQzUlpwSEtOZ1hXYnlYYUtnTG1DOGJ3dlp2eWhTajhiOG1kQmV6RC9WcCts?=
 =?utf-8?B?K3lVaU1QMm0rdGZhK1JIUHpVY0F5enhuSnJKTC9zeUEvSXcxYzJyM1lQUHBa?=
 =?utf-8?B?NHJSL2tNSWhDSWtiS21za1liY2Q3M2RNMkd2QmhqZlNWN0Z5NTdaRXRSdTRU?=
 =?utf-8?B?YzA3NWxXektzS2E3QWpGamxmUGhsVVY1amhVQURYeW9PaEVGV0dVekFsVVNP?=
 =?utf-8?B?cnQ0WXI1MkMxN3NsNy9ySytGT3FhR0Y3QWpZS0xGQ2NJdzQrM3ZXTUFLaTg5?=
 =?utf-8?B?aDlQRXl0aVk1aUhqK2FEMEs1KzFJUnpiL0hLMlUvOHN3d3laYjNJTFN0WUw1?=
 =?utf-8?B?ME5yME85cjQyYmc4NUxkK3RLYmJXRXVCVGl2cVZWUHZXSVRQYTdoVmdhRW1V?=
 =?utf-8?B?QVdHeDVtMXNvc1hSMnNObkFEdTVialo2QXZYZjY3amlBblVNLzUwajdUeThS?=
 =?utf-8?B?RlJnRk5vcW9rRjRXK2xxbng4a1dEeUZjRGdHWmp2aGpsWVM5WGZGTXBlNGRS?=
 =?utf-8?B?bk41ZVVFVTMzc3Z3RDQ2d2lLaUxFQ0NPSEFxM3ZBTy9tNmRoNTZyMnV0cXpC?=
 =?utf-8?B?WFBIVW5hdVJhRndsN1BzYmRUMEhLdGphUWtvbUxYMHk0SlBjYzdNL0t3YWFq?=
 =?utf-8?B?WnZ1d0lYaDZOaCsrbGpHK2sxQ2lLd0tyOWx1VStjaU1VL2xXNkk2ZWVUVHBS?=
 =?utf-8?Q?/dhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb79ccc-d0e1-4ed7-71a9-08dd6b569b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 04:36:27.1452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlPAT6OCjd4vYb0SwTHdBR/DbYeVabFvHfyACt6cXglcJLRq7Myh5ZZo5jZoMYge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
Cg0KSGkgVG9tYXN6LA0KV2UgY2FuIG9ubHkgaGF2ZSB6ZXJvIHJwbSBvbi9vZmYgc2V0dGluZy4N
CkFmdGVyIGNvbmZpcm1hdGlvbiwgdGhlIGZhbiBzdG9wIHRlbXBlcmF0dXJlIHNldHRpbmcgaXMg
bm90IGV4cG9zZWQgdG8gYWxnaW4gd2luZG93cyBkcml2ZXIuDQpTbyB0aGUgZncgYWx3YXlzIHBp
Y2sgdGhlIGRlZmF1bHQgdmFsdWUuIEkga25vdyBpdCBtYXkgYmUgbm90IHJlYXNvbmFibGUgYnV0
IGl0IGlzIHRoZSB0cnV0aC4NClRoYW5rcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFRvbWFzeiBQYWt1xYJhIDx0b21hc3oucGFrdWxhLm9maWNqYWxueUBnbWFpbC5jb20+
DQpTZW50OiBUdWVzZGF5LCBNYXJjaCAyNSwgMjAyNSA1OjA5IEFNDQpUbzogRmVuZywgS2VubmV0
aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZC9wbTog
YWRkIHplcm8gUlBNIHN0b3AgdGVtcCBPRCBzZXR0aW5nIHN1cHBvcnQgZm9yIFNNVSAxNC4wLjIN
Cg0KQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KDQoNCk9uIFRodSwgMjAgTWFyIDIwMjUgYXQgMDM6Mzgs
IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4g
VGhhbmtzIFRvaG1hc3ouDQo+IEkgY29uZmlybWVkIHRoYXQgdGhpcyBjaGFuZ2UgaXMgbm90IGlu
IHRoZSBsYXRlc3QgZHJpdmVyLWlmIGZpbGUuDQo+IEhvd2V2ZXIsIHRoaXMgaXMgYSBmdyBpbnRl
cmZhY2UgcHJvdmlkZWQgYnkgZmlybXdhcmUgdGVhbSwgd2UgY2FuIG5vdCBjaGFuZ2UgaXQuDQo+
IFRoYXQgbWVhbnMgdGhlIGludGVyZmFjZSBpcyBkaWZmZXJlbnQgYmV0d2VlbiB0aGUgc211MTMg
YW5kIHNtdTE0Lg0KPiBMZXQgbWUgY2hlY2sgYW5kIGdldCBiYWNrIHRvIHlvdS4NCg0KSGkhDQoN
Ckp1c3QgY2hlY2tpbmcgaW4gaWYgeW91IGhhZCB0aGUgdGltZSB0byBmb2xsb3cgdXAgd2l0aCBm
aXJtd2FyZS4NCkFsdGhvdWdoIGl0IHdvcmtzIHdpdGhvdXQgaXNzdWVzLCBpZiB0aGVyZSdzIGEg
bmVlZCB0byB3YWl0IGEgbG9uZyB0aW1lIHRvIGdldCB0aGlzIGNvbmZpcm1lZCBtYXliZSBJIHNo
b3VsZCBqdXN0IHNwbGl0IHRoaXMgaW50byB0d28gc2VwYXJhdGUgcGF0Y2hlcyBhbmQgd2UgY291
bGQgZ2V0IGF0IGxlYXN0IHRoZSBaZXJvIFJQTSBvbi9vZmYgc2V0dGluZyBtZXJnZWQ/DQoNClRo
YW5rcywNClRvbWFzeg0K
