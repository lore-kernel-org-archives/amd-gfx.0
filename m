Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB4BCCF2D5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 10:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0371810E3E4;
	Mon, 19 Jan 2026 10:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XjsiFFll";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA7110E3E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 10:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruMkdHI1DAdYEpwg/jO5xXdPbRfykqzXWJJjpuHf3K2hvmafdeTjLwZbnCEhW7GpFjHZjeXWBNP3zyHCQS94p8/esoyAoB6RtC+RKZgZ3ffrbxhfv+EOYXfS8L9Bjzu3fSh9VI280Yk9FHtDnug3uSbomlWRyEe/dIXKRZ+vTITdHhyssxKRwIbSyJ9RhKqLydbNr/jGi4B01S3pYvbju87ozux56QxYThgvw1FcmAw1kUZ2+xLDaBFeqBOmr/DLDJgl95iHUdqLYIF7KpfoXkjjshhGqZdOMTd6xLDPmxIEtebzOsYPhW5iCOIqHay1Qh+WKla81bJ4uMlgETdUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHyyufBKuBkUVta0Rn0Veg6Zploh0ajFL5zCRGD1Qqo=;
 b=sUbHR2wcHdjWn2uRjzgYQbBrhEckGh/I+NEvmoe1FM31ELG9TI6etBtjgSDmKezdDzg+nSeeh3He4Kmn4TJUe+6blxQ2mrITBajxq3z37yNK3kJFeqOZT07pBvRj/tnFUFplb3eVzZoG2IYs7Wct4g/pIYB9VEqhLGwQY2kw9aT5od3e6VWavhYWzkFKEjSMfmUdSBMMc+DwUXayOg7D1S+p6PhdbEvdzBmefqWRFemmVNx6bqgThNyvJ0CuTDZpQzkEmHELy8VWYWEXe/IjY/wsumltScZLhMPP3/PaHdIa+KOzSdTyRKEIzCXa5Nz7cuSjCN2JtpADAnL7FgNFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHyyufBKuBkUVta0Rn0Veg6Zploh0ajFL5zCRGD1Qqo=;
 b=XjsiFFllLxvsdk1JCYRffG+t8CHxylir7brC5gjlLvvYANaqhF7/gjxDf8Yi1EMjMJ08faEuWsKSozvwCYEaDVOwVA6XwUQHZpot2ylTJL7HpbMhIzB4+VAqQcJcmjk9/Igl/7vB9TiMiVrvbVScguqnT2pPOUFGXfyM9UvnOLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Mon, 19 Jan
 2026 10:33:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:33:14 +0000
Message-ID: <c0b8da75-7f89-4fd1-8d98-79f47e2a2f6a@amd.com>
Date: Mon, 19 Jan 2026 11:33:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
To: "Liang, Prike" <Prike.Liang@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c264a6-70f5-444d-fac1-08de57462685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnlzWUxsejJJdENjaUY3anRFNzlXcTYrUGZNb05DT3E5TENKSnJKRWY5R1U5?=
 =?utf-8?B?Y3htRFJHeUxPZ0lMS1JNR0hvRGVBeC9JdzFoZUU5bHJJUEFVd1FZdXhLdzZw?=
 =?utf-8?B?UnlaMHQ3dDdURCtDUU0xNWlmV2NpeHJVQy9WelVUNEpBMVB3Q2hCSGlFNUlQ?=
 =?utf-8?B?SHU1eGk4emhWREwxOTgxekVYYmExQ0RRdEMwdVNVTGwwMlFEM2NhUWRLVGd1?=
 =?utf-8?B?S0VrSXNyeC8wMHQyb2JTYktOSGN1em4wR3JpazNLYTNJeklLMGMwNE5DbHRM?=
 =?utf-8?B?R2gzME92SHcvWTVMeVJDb1VtZ04zQlRwcjVRUEdldmFqNVgyVkwxcHJka2NH?=
 =?utf-8?B?Tjh4T1hRalh3YnlYSGx5bTRQQWhxNjdsTkwzcEVVa0ZKejEzdEIzRHVLQlAz?=
 =?utf-8?B?RXdJM2FMU0xndTB0VGxYei9OL2pMZ1Q1YjBaOWMyQ3Ard0RlVjRyUTNTMjZm?=
 =?utf-8?B?b0NacjE2VktWbHIxdElFZjRTZjNDSXpNMzhwdERST0xXc1pvK1U1SDBydHdP?=
 =?utf-8?B?cy9VckNmenVyQkpiekltRHFhakJjbjAvR1dZRVEvenhld2V1WUUxOFNVZk5G?=
 =?utf-8?B?WlUyOC92N3BnNGdiT3JuRVo1R29xZFhidDVSS1oyRU80NnZYT2xvMTgvOE54?=
 =?utf-8?B?dlE1QmcveEJDUTNobjZwZkd2RmJWZ0k5YkFuOVZhU2JhS20rdnBtT0ZNcWZK?=
 =?utf-8?B?N0t3bmpQMVJydW5xTnNKVm80Y05xWW51OUFrbEFxWjc5THhabXJ6cldjRURB?=
 =?utf-8?B?d0VWaW5oOUVlTFFBdnN0Tk1RZzdlSTlGS2E0UGRsdFEvczk3WGlvVDRwZzRO?=
 =?utf-8?B?RTRaMzM1OHZmclh0RHVzSHdDaDVaN1ZwVEd6TEdsQ1ZtcFlXbUxjZEZQZ2ha?=
 =?utf-8?B?am1HSXFqQ050UVRsRE5BTDlRekJaUzhKTTJrbTBmd1BwWXJTT1BKTnZ0Nk1U?=
 =?utf-8?B?UnZPck5zZEJnanFmKy91dlRXcmFXYWw1WU9jS1I4MXF2Y2N0SkRxa0tEcGlP?=
 =?utf-8?B?bG10K25nelF2NGVYMENkdGw5UGhPKzBGbExzVWhVZHBMSzl0MnN5SHNpMGkz?=
 =?utf-8?B?WTBmV2tPUVV6L1FnYW5hSTgxS3JGU2l4Mk5MaXlvUFBRWExTc2ZmTi9CWU90?=
 =?utf-8?B?THl4U2tLOFk3eFZaeXRJclBGdFQ5aVhQaUNXNWg4OXlJaUFaUGZ6QmxJcVBP?=
 =?utf-8?B?eGZ0R0VaRW1HSGl5dFhkMzZFdzV0SE52V055eDZBVzVHTksvb0VyR2s5bnp1?=
 =?utf-8?B?OFlqeExvVnBUN0JQeURiRTVSVnRjdlhIU1ViVzJoZE0yWE9zak1yOG1hM0Jk?=
 =?utf-8?B?d2xEYUVYaUc1d21kZ2drcXJMd3VxOHo3MUNEVlp5bXpKT0ZMUVgxMXJsL2Z4?=
 =?utf-8?B?MWd3cXUyOTVEcUlGTHBnSkZlY0hXSkQ1ci9XbEM1RDhnWHpjaG5WNXBCellv?=
 =?utf-8?B?cnFNYWFaN2lGNWV6L2VFbE9iWnIyWm9MUm5KSWc4RXFRNS9qc0xWQXRkTnRt?=
 =?utf-8?B?UUxhVlF2dzhDNVZUZ2JuaFRzODVjblBjbVpHblM5YktoejVqN3hyL0FsZnM5?=
 =?utf-8?B?aHZTemdEaThtbTAxWFdwckZqdjZNREg4VUw2OHd3MHRpUXl5L0t0VitTKzBU?=
 =?utf-8?B?NjhTRE9XekdsbityNTVqVDIySXN5TmlyeUprZ2VUQWxBMVJJdk9KK2JmMUk4?=
 =?utf-8?B?dFdZR01ubmVaUjBvYzFFTmQvdE1XNW1ZQmxpdEZacXZQdmF4NldUWDlDM213?=
 =?utf-8?B?Z0tRUFNGRWFEWDBIeWRzOTdSbGpnVnRCWUpNMjdveG5LOUhkcFRoL2xtN1lJ?=
 =?utf-8?B?YXFoMmcyclp5dzZzY0VxSDVrbFRKQUxmWlhjWVQzWnBDZ2ZhdFUzck5tVTVL?=
 =?utf-8?B?TWd3VjF2UjAwVTloN0hGSFZGcnNiak42OHNGdml6T0w1NmZkMlBvVXVucUZq?=
 =?utf-8?B?YU82VVpBbkZxMWxCQkpacHQrUFNPYnp2K2RkYTJrS0ZRUG9Pc1h0M3JYQnR5?=
 =?utf-8?B?YllsU0x0WWN6b2pIMmlQOU9DSVlja2NKejlGK1ROZjRCSVZybmd1bFAxWUpS?=
 =?utf-8?B?MnBxZmpXMk5LalY3THZjWVVMR01hbzZJODNlSlkyL2xFeXhGVnlYRWdHUUF0?=
 =?utf-8?Q?VMtE5i64IE2D5b/OON9ReS4hd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFOTUN4bEQ3K1lZOHBub2hlYWJWTXJoVnVoR2NpYkxqYTBPRWRnMTAwamhN?=
 =?utf-8?B?YTZsYnB1blQrdDJ5b1lRdXZzYy9UcG0vSyt4TS80WjBxVThsK1FiSk8vZkJ6?=
 =?utf-8?B?eXhpekJNdTVYY2pHRVF0M1kzWTQrOURqd0NJb1gwMG9rVFR2S2FLbVduZXlk?=
 =?utf-8?B?U3B3Z3JZWXJtR0QzcENlVkp4THlURVROWkdHd3RyTTd5SEVPUVR2ckJ1TW5q?=
 =?utf-8?B?eUVicDlSUGdLYzl2c1Q3Q3VGRlBqSTh6bithbjVybFp0V0NWSWlnc0tyRUJU?=
 =?utf-8?B?R3YrSUdQczVZdkw5Q0FBaVFFVW9IdTB2V2dTM0dqV3A1aFV5SzFjNGgyQXA4?=
 =?utf-8?B?dGljL0tPN3JEVUVsdzZxSHlTbEFkYlVZOUJBZElyNEZTNWFnakpBbTdrSDlS?=
 =?utf-8?B?SkdVVVdxZnM4T2k0bG1lM2xzdkkxb2F5RHQybFZFQWJrMlgwK2FoN2c0NSs1?=
 =?utf-8?B?MW1qbmgyK01zUytGU3ZXdmhKbFVXRXJlOWJtTHRiYlFIcVV2aEJBZ1d3NGNB?=
 =?utf-8?B?dTdaenYwOWtIWHVrQS9KMlNQUHNZeWxVUHQwSExBaFZ6Y3NiWURQZlpseWx5?=
 =?utf-8?B?Mk9aVUJrQWdlSlpod2MwMitTbllVc1kyMm9Mbnc1d3RsOE5qNEtET1FmaDF5?=
 =?utf-8?B?bTd4akxwNzJud0VIUUZyV1IrSnd5WlRNcjkzTDF1T1FVUGxOczNQaXI3Y1NN?=
 =?utf-8?B?SGlLbUVMUm5zN0NjWmg3VUFzQkNWTWlpMEhOcm5iV0VGdHpvbnNKT0dIaXZG?=
 =?utf-8?B?N093Zkk3TndBcVpJSEppaWExOFlNa0ZRSGpoUmNISnllWFQ2YmhkNHpVZVQ4?=
 =?utf-8?B?RmxPMitZK2N1bGFGZHg5cStsOHF3ejRGLy9XSm9nUk03allJVG54SDJWY3JZ?=
 =?utf-8?B?R0xhd1J4OWhZWitLbFlnUWZRbGsyMmduT1hyTDNSL1pqR2pINllaQzMzUDBD?=
 =?utf-8?B?TXVDV2tQNmdlNkhhRVRKbzdQMTZjdTQwYmFmTDhnaElyM3pRYThqSzM4STAw?=
 =?utf-8?B?NDczMm1lZC8rbTkyelJMa2VrSm96KzczbDZVRldmN0JTWDVkREY4Y0RrcE1Y?=
 =?utf-8?B?a290SHRLTHdyRXJ5ajl6d1FEQU04V204cG5tNXhzMVovbHJuNkl5MC85bHNL?=
 =?utf-8?B?VzA1TnNhUmRDZDlQdkVDQ0xRUjdzUFF4OEJKQ0Fpc1NHdVlrNXlmYTlqeHRU?=
 =?utf-8?B?cEZSQjlNQmY5UlVhYTdFTjBYRDl5R0F2bWJVdFRlc2JsNG01SXppczNYb0wx?=
 =?utf-8?B?VmVaU3BOOUgvNm9vZUhXZ3krN3NyLzRRWFptNFlFci95OC9zSzQ4MzNSemE2?=
 =?utf-8?B?dHBHNzEzeDJlUEpkY0ZhQ2MzRWc3MXJKSjZva1Nibk1wdGVHRndVVXRsR28r?=
 =?utf-8?B?MDVQN25JenhudCtkWXk5SzdzMzJ5aTBoekx4WXJTdlgzWEdoM3g3cTk0Q1g0?=
 =?utf-8?B?MEZXejV2WlJJSWt4VEtBNldsSW9pM0ptN05nc2tBOVdINkJoRFNvUE5zMy9q?=
 =?utf-8?B?MW0rbnRUWGFxSEpEVHI2K0VId2dFbUVkT1llSy94WUtNSmRscUV0LzREbEZ2?=
 =?utf-8?B?ZFBZR05NNVhDK29FMjg3RE15NHNvaFZEL0ErOTlFY0cvTXEvWTBUT0JpU21L?=
 =?utf-8?B?ekx4NUVDa1FvTm1nWVc0Vkt6SGQ3bGllVWlTeHV3M1JaYy9ibVE3dHcrOFk1?=
 =?utf-8?B?K3cyNU0wZE8xbXpnTnVlaGFUaXdlS3ZsSzNYK1hUVFpVTW5nNzUzRWFWN1A2?=
 =?utf-8?B?NEdPdFVhRyt2R3FoaUswT1Evdm9zMzJwMFRvOXh5enhjRjBsYWZFUUZTSVpF?=
 =?utf-8?B?TGVaZFRWT3FGdXBuejJ2MDNYVkFnU28vaHFJWXNwTmdWWHlZOXRUWC95N3hF?=
 =?utf-8?B?UURxUW9MeENnZlU3YklDZXhwbm54Y0JGdG1OMHIxKzd6R2RnNFQzWW5TSjk1?=
 =?utf-8?B?UFVtWXhpdTN1Wmh1ZllNcEEzNHJYaG5RWXh3N1lsSy9saytNN2I2cjNlRjRv?=
 =?utf-8?B?NTFmZ3JETjVxNjN4UlFQOU5MYmJraHFrcEtHaDJpZ2laUTZEMTVOUmZFM0pm?=
 =?utf-8?B?a04wWDZaRkYrZzdEanRaSHlOcDNNZER1K3ZCYWxsM21sT1U4R3ppK1F3SzFp?=
 =?utf-8?B?RUtJNVV6aVVudVNlTGtUMnRvTXY5aGJ5MkhISloyL1BXaSsxZmVEV1U4SHRq?=
 =?utf-8?B?ZGQrMWpET2dSdytDbEJFU1I3UE1rRWtRN3kvVjFwejZRT3JqNHIyWExXZWZY?=
 =?utf-8?B?QXVrU3orNmVrZUM3dGVHU3RTQlJGUjBqaHVBUFFtQ0ZiWjc4b3BmVk5nWGMx?=
 =?utf-8?Q?PnbrYFh9wqj4rGiHpQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c264a6-70f5-444d-fac1-08de57462685
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:33:14.0637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxBoes5remG9Dyr+0WQV170qmheP2tT6QMLllPTsKUpV/0KoMeElwooExZinXilG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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

On 1/19/26 06:27, Liang, Prike wrote:
> [Public]
> 
> In order to avoid being blocked by the lock issue on some older GFX, I will push the patch to amd-staging-drm-next.
> If you have any concerns, please let me know.

I only had a coding style comment on the patch and also gave my rb with that as well.

So if you haven't pushed it yet please fix what I've pointed out. Otherwise it is not much of an issue.

Regards,
Christian.

> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, Prike
>> Sent: Monday, January 19, 2026 9:58 AM
>> To: Timur Kristóf <timur.kristof@gmail.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
>> Dan Carpenter <dan.carpenter@linaro.org>
>> Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
>>
>> [Public]
>>
>> Thank you for the fix. Could you please add the following the tags?
>>
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> | Closes: https://lore.kernel.org/r/202601190121.z9C0uml5-lkp@intel.com/
>>
>> Reviewed-by: Prike Liang <Prike.Liang@amd.com>
>>
>> Regards,
>>       Prike
>>
>>> -----Original Message-----
>>> From: Timur Kristóf <timur.kristof@gmail.com>
>>> Sent: Sunday, January 18, 2026 8:58 PM
>>> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>;
>>> Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>> Subject: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
>>>
>>> When a function holds a lock and we return without unlocking it, it
>>> deadlocks the kernel. We should always unlock before returning.
>>>
>>> This commit fixes suspend/resume on SI.
>>> Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.
>>>
>>> Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 0e67fa4338ff..4fa24be1bf45 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -769,7 +769,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>>> amdgpu_device *adev, uint16_t pasid,
>>>       struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>>>       unsigned int ndw;
>>> -     int r, cnt = 0;
>>> +     int r = 0, cnt = 0;
>>>       uint32_t seq;
>>>
>>>       /*
>>> @@ -782,7 +782,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>>> amdgpu_device *adev, uint16_t pasid,
>>>       if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
>>>
>>>               if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
>>> -                     return 0;
>>> +                     goto error_unlock_reset;
>>>
>>>               if (adev->gmc.flush_tlb_needs_extra_type_2)
>>>                       adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev,
>>> pasid, @@ -797,7 +797,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>>> amdgpu_device *adev, uint16_t pasid,
>>>               adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>>>                                                        flush_type, all_hub,
>>>                                                        inst);
>>> -             r = 0;
>>>       } else {
>>>               /* 2 dwords flush + 8 dwords fence */
>>>               ndw = kiq->pmf->invalidate_tlbs_size + 8;
>>> --
>>> 2.52.0
> 

