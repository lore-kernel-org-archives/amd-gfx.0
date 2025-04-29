Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F4C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 18:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C43210E025;
	Tue, 29 Apr 2025 18:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQt3ncTp";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FFE10E025
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 18:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVpl5Y4JRzf7PkpSOVEdS5s8X0KvUkVw0TXG4b6TwMdBNpa6LN3ed67vCpWBHboNKsm+h9zkhhdFdCgb6N3N4cAN0KGtHPGdAbDjFiRCB2xJ+xGbR1EUV1eDAjaVy2AaS08lYbnrPj/3hK4UwcHql2v20nREQcXwelFaNkFF/oas3hSt/9Koj/8yM4ePtpve7BsVkKfznwf9eqhUCX01RvwPbZA+omnsxWdkcL4F062joBoSx8S6j9HHtFpbeUTvuUWpZ9JXtoBnUBmEpjG3rRJ0BPnOt2o3HYj83iYXV2rbEbeTH04Ilx0yTvmECUUIxbFlSYgF/vZZNyV8EHIgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ydaizW3KgaEozZ2fGjCfRwXlHBgHeX1VMHrT1pUVqA=;
 b=vEEK1RjQwEp85pCX9NgYd4b95wxup7+4v5Ll9TbfDYtsqhBMb2KO+YTTHvsYcNJDcB+W/Tm7kXXWynj1UdH9/nnAZibs7hxJVaPZ6/2JA7MPBRx4xr9SXfY6f+vaeBMfa8rAqLJ2ndyIIeDKK4p/WgNAriK4P2xtauQ30Ps0ucSIWYl3Nx68ozdbZgFoVZcwQL8YUyzHGTwadgtYcWAuQQp9Mp9PTltbpGdGL3QACliYUdcsHIPCxYpZtWdPwN4rlzrPQNOaxc8HeoQjuERjtpQAMpDEy72aqCpEVR3J7Fpk3k0DTrqcLkWxDX/IpR9uzxPBCjtuiyI/QVfFGbSJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ydaizW3KgaEozZ2fGjCfRwXlHBgHeX1VMHrT1pUVqA=;
 b=iQt3ncTpNvVOxlu6aXYbyjQ7ZoRN83X06E2Gb6k8+GC7nUOOOCX8w4nm2DULE6+Sf8S9PGGK77O755eonP3V3sglCdgcrlAqJRxhIeXgDOkE43b+XEASpIoXb2qLOinRVRpraQU7Yrgl5VP7HZMMg3EbGL1vq/3MYHdd6veL33I=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 18:56:41 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 18:56:41 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Chen, Michael"
 <Michael.Chen@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Topic: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Index: AQHbuIN/8vHW9/64KkWJ6JoSL6ig1rO682WAgAAHZwCAAAQigA==
Date: Tue, 29 Apr 2025 18:56:41 +0000
Message-ID: <CH0PR12MB53724E7D012C8D79AB497A5AF4802@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
 <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
 <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
In-Reply-To: <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ef301677-c0d1-4fc8-a9dc-558081cbb569;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T18:53:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS4PR12MB9587:EE_
x-ms-office365-filtering-correlation-id: b12db5ae-6ae2-4d2b-04d9-08dd874f942e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0N5MkpWdEZXTWV4VlIreVBiT3NDQUdDTTdOa2paWkFncEZzK3FwWEROS0hk?=
 =?utf-8?B?d1gyUE5QYWtXTXdoWXFDTGh6aDBaYWpMNEhWbzRxclpzK0NPN3ZaUkxsYjJ5?=
 =?utf-8?B?clBzRElJMGtlR1dyaWNPMTI1S1NZaTBCSjcvcXQzQVVyWWFuRllTeHJ0MFNv?=
 =?utf-8?B?RTRKV2xQek1mYlQrUmtsTDgvVzdWbTZBSlROdnBnTWNMd0Z2c2RHVjVLNkNM?=
 =?utf-8?B?RUFGOS8yR0djV2VteHE3UklxYkVweTdTdythV09ORmhqVzdxeitxOGw4cjVw?=
 =?utf-8?B?S1ZKNXRWTVBhaUxPYllXVmhPazlXak9jWVhOeWdLV0didWVQTWVOeDhpdVdV?=
 =?utf-8?B?cFNudElvNjN3NUVwa0ROdnBpSGw3R29VU3dVTTFKVkhTV09PcVNCUHdUalY3?=
 =?utf-8?B?RkpjQTlFdldNWUdBTHZvSndSanRHVkp1S3c4Mm8wT3pQMGhodjJPMDNnV0x5?=
 =?utf-8?B?NjdnMUtibTJiRTlXNmpoc3RJbEhxVjBaRVZPclc4NVJ4bTJPb3R0bFI1Mm9Y?=
 =?utf-8?B?dC9IcVprTVk2KzBTaURGZHY3STNySmpWdTRXTVk1ekpSTWk3K2JBOHFNVnlw?=
 =?utf-8?B?N1ZmQnhwWTh0aDZWZDZtUzA5Wko2ZDdhUVY3N2M1OTc5V3FQemptM0xua3JO?=
 =?utf-8?B?VnJ1NEtFNXBKbjh3VzhFV0VOTVc4KzhiV0RaN25qWHB6dy83MVYyR1ZiMzNK?=
 =?utf-8?B?Y1FERkRxbGRTRS8wdnd6NUJadnFjOUI3S2owUkgzSFF0QjBDdTFHOHRVUXlm?=
 =?utf-8?B?KzZmbE45Q3lwVUEybUtwejRJWnJFOW93WHFqcjFsYmFZdE81a2xOTXlQcXhB?=
 =?utf-8?B?S0crSFBNdmMwbTZQVVhLalNzZHMvOFJSc1N0aC9VQ3c5N1V1cU05TGdDVERn?=
 =?utf-8?B?R0RiRGMrU2xvNEM3M3BrMjlKUTJ6b2kwWlgvbGRVaXpOcjJOWlJVWTBIMmtR?=
 =?utf-8?B?NkZEUUlTUmdnUGtyYXNDZDl5bHI4Z012K3ZRTjBoc2s1aHppam5kdmRXOU55?=
 =?utf-8?B?bnh2YUFVZFpYUmEvZE5weUFVYWRRNnI3RDBkRzlkdGpScWxGbW1VOWVmTks2?=
 =?utf-8?B?a0FhNG8vRnhlamsyck82UDc2Wk5IM1ZFVGhGUnlFMmF4TnEveE56d3JXbUVD?=
 =?utf-8?B?aklzRHpwUGdEL2ZLMU5SL2VMcGo2NUNFZGVqYUUvNEh5Yk5lMWlpcnhZcEZy?=
 =?utf-8?B?L09SYXdxK0s1Y1dSSGt4Kzh5ZjYrbmVWSVpLeVdxS0pYSGJjNHZ1RUcvT1RI?=
 =?utf-8?B?Tnh3Y2hsSkZZU3ViTVE5aC9rN2pYMDVlR2JvQVlNdWNnZ2ZkWGR6NFdTQkg3?=
 =?utf-8?B?Ykk3NFc3aVc2aFlLWGEvdXdNRDlKK0hFM3ZpNHQ0S2d1clJQRGFNVGJmc1du?=
 =?utf-8?B?eE9DcXlWSHUvWkNEeFFNOXpjaXZOMVBzOFdJM0VCT01YYzlTY1p4SjdnMHd3?=
 =?utf-8?B?Z3pFc2VucEM2eDRhQWppM2YxVkE2enFYRmU4WklEVzN0UTFBaWZmRXR4UWlk?=
 =?utf-8?B?QkVrOElYZjZGQnVpcStmNlhMUi84aWhJdkxCeXZRK3ZhV2ZueVo2M3lvc3ln?=
 =?utf-8?B?RDNjY1RSSWNiY3VIRU9uQmF5YzFUR0ZBYVNtY2xjVnU5aW1CZVVaMEZ2MjFN?=
 =?utf-8?B?NnF1MjNmR2tmbVllOEJUZkMxbDhTSW9venpNYmZXdndmTE1rcG94bUJ3U2NE?=
 =?utf-8?B?SFcraURvTVJrZ0FpTHlQeFZhZTRkaXRmelRBOU54T2xaWEMyZHJIdE14WFFv?=
 =?utf-8?B?N05MaXhoQktuc3h1TnlpTTdiWElnZU44N0dzblFWN3Q1MFUrMUg4SGRIcmhQ?=
 =?utf-8?B?b0lzU2wrQk5YRU16VEE0dmw4cURKWDhoSmw3SnYrYXgvajcvejAzRzBoRlh5?=
 =?utf-8?B?WnhjdStjZFBCeTgzNGV3TW02ZHVqYWUrUjA0S0tqdzJEcERKbnR5OURPeVdD?=
 =?utf-8?B?WDgvRllVaU02dTdsaHcwTGJJRXNHTDRxbmR1RkpZdzhRdUozeURmVWtQYzlD?=
 =?utf-8?Q?FGD663LgVpWGv6q4DtviOPXBWz+z1M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1F0VGpZeFo5STJKd0tGWHZMYUdYUm16M0pVemY0ZEN6UFVlMFZXejZiSmlz?=
 =?utf-8?B?dzNobjY4U2dRMFFxaUhqeEoxeSt4TkNyRDJtYTZ0M2NBSUJTZEVkenJsQ3BN?=
 =?utf-8?B?QVl2SkZXNDBRMVU1dmNrWlNPaUdlZTcwZVk5czVqODlaMlBJWHJFZ1N0Ukxz?=
 =?utf-8?B?ODZIZHl1Nm5pZDJhbXFHNC81cjNMbXh4NkllWG5HT2tycm1XQnBkTUMwRFNO?=
 =?utf-8?B?aEg1a3VyVTQ4Qm96WHkwbnBUMGRodm95bjFHTjNhQmlMdFB5Rmx0dUpSWHhS?=
 =?utf-8?B?d2tPS1dIQVJ1T1ZYQ2dWYWJ3QTBheUNVWTJwYmZvMEh5SEUxbEdqOTNKVEdm?=
 =?utf-8?B?MTRaVXN2N1VyWnhsMitWN3A4V2VRNHBwOGZQR3N3NUF5S25SeVZLUVJZZXdt?=
 =?utf-8?B?dmxVUm9tQThhaGd0TjAxTWxuZGNFdzVZR21nelZSK3dYNUpUTm9DVHo2d2E5?=
 =?utf-8?B?TVZqbE9NTzl2UVJaQStaVlIvSSt2UWxYOEgwcEdNcm44emoyazE1NncxL0RE?=
 =?utf-8?B?Q0wyU3NzQitLNlh6YVhJcE01cVpFYkRrVG1yMXFwQTdFLzBYNTR2RGtBTWlF?=
 =?utf-8?B?NW04N0wvY0x1WGFFWFVtN3krNWMzTWxMT2xzZFc4aWJpOFk0UUJOSUgxT0p6?=
 =?utf-8?B?dUFTK3NRdHpKOGpWOUQwSmhtYnhjOWhyZlJxQTdsYnNKQjFwa2pnc0h5YW82?=
 =?utf-8?B?d3RiVzl0RnU4ZHZ6ZXRvM3BLSnBVdnBYUVJOeWZXMGlpcE1FWlprOTFyejJB?=
 =?utf-8?B?ZjV1QitMTjdiUUxXSGMxcmd5Rjg0Y0UxaG82em9UbUt3SWd6Y0VudllWbUlX?=
 =?utf-8?B?SG40Y2V3N2UzdVI1SjZhTkRUdmdtN3RBNGE4bVVVNEtsdTk5eUIyeHF3MHlx?=
 =?utf-8?B?VkZ5a1lJV1pTdUpkWmxQUGZVYndFNkxONEdhTGRoZ3NudmFkc1hidmg0bjBl?=
 =?utf-8?B?VEhhNHZhS2lUZ285YUZyTHI3WGtMUVJDTnFjYm1hbTRwek1iTlFxQXpiclNx?=
 =?utf-8?B?VUNpbHVlTURIWlUzUDZld2ZjaHRZWUlKYnlrU3JkK05SK2hsa0FBTGVWYzJX?=
 =?utf-8?B?VzN2d2lHWHM2Y0FoYW5iVFB3QTVIbXhBdFdNL2dORi9SVjl0Tjl3RC8rYWhm?=
 =?utf-8?B?VWVqaXNKNjFPREsxMElSYzVQYkF5ZXJ5VUxFSGZtTmRIamsvazl4SUxoQ1VL?=
 =?utf-8?B?QlZyNzBjTE83djZHRTdldDRNdVUxdDBkeDZjbFQxS3BDQkVXQW5IT0syZmFT?=
 =?utf-8?B?aThFSDIrd3VGOHBtOEQ5TCt4U05qc0FiTFdEUEVKM1BSL3Vsb0tqd1h0Vitr?=
 =?utf-8?B?dENRc3NNNVE2RlNEWWhUSWF6SWdmYTNXaS9TQ3kxMWkvMStLUVJEMzBrK05V?=
 =?utf-8?B?SnJOVWdqdHVER1hqTmZmc2ltYTFEVHprQUNHemwwa1N1RHdsd1FjUXFZeGc0?=
 =?utf-8?B?ZG9RdjZMbzFrYUJhcGxnY0N2eTZ3cE9SRzJxODNjRlFKREZ3dzFsdTJhQUln?=
 =?utf-8?B?aDFSTjlidU1XMVVya212N2hNelpoTm5BYWdCeHVFLzU1Sm1HYU9xdkQxRlVa?=
 =?utf-8?B?Q2JiMFFmWUlhbElFOW5xQ3JnaU4xYnhJNTYyeS9jNFRLOCtSUjNKTnFXdE1L?=
 =?utf-8?B?dWNxVTlKYnpPQjdyQUh6VjV5OGdQeTV3WktMd0IvT0JJaGZ2WUlqMml6VjJD?=
 =?utf-8?B?bWJRdHBRSlQ5SUhjd01jVFBpSllydWN4NXkzU012SS9QcDRiYnkzZWx6V1lu?=
 =?utf-8?B?bDBidU1UcWt4TC9aM2diR1lpWlhYSnNEaGdLTzJEQlNkMWNHOVI4STdzWTFY?=
 =?utf-8?B?SWxOMG01eWY3MkMwOHlCZHhvcGNQQkQ4emhvbTRWc25NNU5Qc25FVlBNZVIr?=
 =?utf-8?B?V3dVR0ppWEkzVVRzS2JVTmhUb29WSWcwcHVZclBKSDEvV3hZcXlrUGljMGJ6?=
 =?utf-8?B?ZWhvOEZFN1dCdVQxeEpTV1UvTU5UVEpiZEtpeTFyd0VPY2RNTG5SMzYzUXlk?=
 =?utf-8?B?a1RWaldKUS9OdE03VStORSt2eUc2SmxIaWlMZzNBUTFOSUQ2bEY1Mm5NMXNl?=
 =?utf-8?B?VE1qTG9vd09qWGc4dWk5cEJvd3lyN21Va0ZwVkdFd2UyTXVmRG4wK2hhdkl5?=
 =?utf-8?Q?LnLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12db5ae-6ae2-4d2b-04d9-08dd874f942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 18:56:41.4572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfHjGr8uRchZie/JZMMHxxEPJGqN2BPoZfyBKPbNS8oJAdGLt1ZuUTiMvGnivTRB6gH7FExWtYYzoefonFWF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587
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
Cg0KQ29ycmVjdGx5ICwgdGhlIGdhbmcgc3VibWlzc2lvbiByZWxhdGVkIHN0dWZmIG9ubHkgdXNl
ZCBmb3Igc2NoZWR1bGVyIHBpcGUgLCBraXEgaXMgZm9yIHVzZWQgZm9yIGtlcm5lbCBkcml2ZXIg
b25seSBhbmQgIHNob3VsZCBub3QgZXhwb3NlIHRvIHRoZSAgdXNlciBxdWV1ZS4NCg0KUmVnYXJk
cw0KU2hhb3l1bi5saXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBB
bGV4IERldWNoZXINClNlbnQ6IFR1ZXNkYXksIEFwcmlsIDI5LCAyMDI1IDI6MzkgUE0NClRvOiBD
aGVuLCBNaWNoYWVsIDxNaWNoYWVsLkNoZW5AYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+OyBMaWFuZywgUHJpa2Ug
PFByaWtlLkxpYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDUvOF0gZHJtL2FtZGdw
dS9tZXMxMjogYWRkIHN1cHBvcnQgZm9yIHNldHRpbmcgZ2FuZyBzdWJtaXQNCg0KT24gVHVlLCBB
cHIgMjksIDIwMjUgYXQgMjoyM+KAr1BNIENoZW4sIE1pY2hhZWwgPE1pY2hhZWwuQ2hlbkBhbWQu
Y29tPiB3cm90ZToNCj4NCj4gW1B1YmxpY10NCj4NCj4NCj4NCj4NCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gb24gYmVoYWxmIG9mDQo+IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAyOCwgMjAyNSA1OjIwIFBN
DQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBLaGF0cmksIFN1bmlsDQo+IDxTdW5pbC5LaGF0cmlAYW1kLmNvbT47IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDUvOF0gZHJt
L2FtZGdwdS9tZXMxMjogYWRkIHN1cHBvcnQgZm9yIHNldHRpbmcgZ2FuZw0KPiBzdWJtaXQNCj4N
Cj4gRW5hYmxlIGEgcHJpbWFyeSBhbmQgc2Vjb25kYXJ5IHF1ZXVlIHRoYXQgc2NoZWR1bGUgdG9n
ZXRoZXIuDQo+DQo+IHYyOiBmaXggb2Zmc2V0IG9mIGFwaV9zdGF0dXMgKFByaWtlKQ0KPg0KPiBB
Y2tlZC1ieTogU3VuaWwgS2hhdHJpIDxzdW5pbC5raGF0cmlAYW1kLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMgfCAyOA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gaW5kZXggZjlmMmZiYzBhNzE2
Ni4uNTdkOGI3ODIxMGY5ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbWVzX3YxMl8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3Yx
Ml8wLmMNCj4gQEAgLTg3OSw2ICs4NzksMzMgQEAgc3RhdGljIGludCBtZXNfdjEyXzBfcmVzZXRf
aHdfcXVldWUoc3RydWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIG9mZnNldG9mKHVuaW9uIE1FU0FQSV9fUkVTRVQsIGFwaV9zdGF0dXMpKTsNCj4gfQ0KPg0K
PiArc3RhdGljIGludCBtZXNfdjEyXzBfc2V0X2dhbmdfc3VibWl0KHN0cnVjdCBhbWRncHVfbWVz
ICptZXMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbWVz
X3NldF9nYW5nX3N1Ym1pdF9pbnB1dA0KPiArKmlucHV0KSB7DQo+ICsgICAgICAgdW5pb24gTUVT
QVBJX19TRVRfR0FOR19TVUJNSVQgbWVzX2dhbmdfc3VibWl0X3BrdDsNCj4gKyAgICAgICBpbnQg
cGlwZTsNCj4gKw0KPiArICAgICAgIG1lbXNldCgmbWVzX2dhbmdfc3VibWl0X3BrdCwgMCwgc2l6
ZW9mKG1lc19nYW5nX3N1Ym1pdF9wa3QpKTsNCj4gKw0KPiArICAgICAgIG1lc19nYW5nX3N1Ym1p
dF9wa3QuaGVhZGVyLnR5cGUgPSBNRVNfQVBJX1RZUEVfU0NIRURVTEVSOw0KPiArICAgICAgIG1l
c19nYW5nX3N1Ym1pdF9wa3QuaGVhZGVyLm9wY29kZSA9IE1FU19TQ0hfQVBJX1NFVF9HQU5HX1NV
Qk1JVDsNCj4gKyAgICAgICBtZXNfZ2FuZ19zdWJtaXRfcGt0LmhlYWRlci5kd3NpemUgPSBBUElf
RlJBTUVfU0laRV9JTl9EV09SRFM7DQo+ICsNCj4gKyAgICAgICBtZXNfZ2FuZ19zdWJtaXRfcGt0
LnNldF9nYW5nX3N1Ym1pdC5nYW5nX2NvbnRleHRfYWRkciA9DQo+ICsgICAgICAgICAgICAgICBp
bnB1dC0+cHJpbWFyeV9nYW5nX2NvbnRleHRfYWRkcjsNCj4gKyAgICAgICBtZXNfZ2FuZ19zdWJt
aXRfcGt0LnNldF9nYW5nX3N1Ym1pdC5zbGF2ZV9nYW5nX2NvbnRleHRfYWRkciA9DQo+ICsgICAg
ICAgICAgICAgICBpbnB1dC0+c2Vjb25kYXJ5X2dhbmdfY29udGV4dF9hZGRyOw0KPiArDQo+ICsg
ICAgICAgaWYgKG1lcy0+YWRldi0+ZW5hYmxlX3VuaV9tZXMpDQo+ICsgICAgICAgICAgICAgICBw
aXBlID0gQU1ER1BVX01FU19LSVFfUElQRTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAg
ICAgICBwaXBlID0gQU1ER1BVX01FU19TQ0hFRF9QSVBFOw0KPg0KPiBJIHRoaW5rIHRoaXMgcGFj
a2V0IHNob3VsZCBiZSBhbHdheXMgc3VibWl0dGVkIHRvDQo+IEFNREdQVV9NRVNfU0NIRURfUElQ
RSwgc2FtZSBwaXBlIGFzIGluIG1lc192MTJfMF9hZGRfaHdfcXVldWUgd2hlcmUgdGhlIHF1ZXVl
IGlzIGNyZWF0ZWQuDQo+IFRoaXMgaXMgYmVjYXVzZSBIV1Mgb24gQU1ER1BVX01FU19LSVFfUElQ
RSBkb2VzIG5vdCBoYXZlIHRoZSBxdWV1ZSBpbmZvcm1hdGlvbi4NCg0KU291bmRzIGxpa2UgdGhl
IHJlc2V0IHF1ZXVlIGZ1bmN0aW9uIGFuZCB0aGUgbWFwIGFuZCB1bm1hcCBsZWdhY3kgcXVldWVz
IHNob3VsZCBhbHNvIGJlIGNoYW5nZWQ/DQoNCkFsZXgNCg0KPg0KPiArDQo+ICsgICAgICAgcmV0
dXJuIG1lc192MTJfMF9zdWJtaXRfcGt0X2FuZF9wb2xsX2NvbXBsZXRpb24obWVzLCBwaXBlLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAmbWVzX2dhbmdfc3VibWl0X3BrdCwgc2l6ZW9mKG1l
c19nYW5nX3N1Ym1pdF9wa3QpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZih1
bmlvbiBNRVNBUElfX1NFVF9HQU5HX1NVQk1JVCwNCj4gK2FwaV9zdGF0dXMpKTsgfQ0KPiArDQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9tZXNfZnVuY3MgbWVzX3YxMl8wX2Z1bmNzID0g
ew0KPiAgICAgICAgICAuYWRkX2h3X3F1ZXVlID0gbWVzX3YxMl8wX2FkZF9od19xdWV1ZSwNCj4g
ICAgICAgICAgLnJlbW92ZV9od19xdWV1ZSA9IG1lc192MTJfMF9yZW1vdmVfaHdfcXVldWUsIEBA
IC04ODgsNg0KPiArOTE1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfbWVzX2Z1bmNz
IG1lc192MTJfMF9mdW5jcyA9IHsNCj4gICAgICAgICAgLnJlc3VtZV9nYW5nID0gbWVzX3YxMl8w
X3Jlc3VtZV9nYW5nLA0KPiAgICAgICAgICAubWlzY19vcCA9IG1lc192MTJfMF9taXNjX29wLA0K
PiAgICAgICAgICAucmVzZXRfaHdfcXVldWUgPSBtZXNfdjEyXzBfcmVzZXRfaHdfcXVldWUsDQo+
ICsgICAgICAgLnNldF9nYW5nX3N1Ym1pdCA9IG1lc192MTJfMF9zZXRfZ2FuZ19zdWJtaXQsDQo+
ICB9Ow0KPg0KPiAgc3RhdGljIGludCBtZXNfdjEyXzBfYWxsb2NhdGVfdWNvZGVfYnVmZmVyKHN0
cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiAtLQ0KPiAyLjQ5LjANCj4NCg==
