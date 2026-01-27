Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A6D25934
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 05:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04EC10E075;
	Tue, 27 Jan 2026 05:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B7AghkNz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD10D10E075
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 05:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoB/UCML/5cbAN1Kc8Cls2DjFjzj+PQvHrSTJfffO3Qbb3ELlVt2AC6QPnTzRK24shOrAVVAzDE6ivDKSqmIGEMjvmVrTz6W6MzMkvB/b4FWvEosyH/DLKSP2Zp9s5zYh3ryfplQyibPlw1gq5j7AZXOFGisAtbd73hw7I6BQHjFGgHB6uaE+YFm4DzI14dMyYsZgdynp9QJzv3kAO+vekObQjhG3krQZQczNrrBlRKLo2aPeGpEvlp5aO9SG+sQt0ca3TqqZ0rgN+xcopZ8cEd9Jwjzb7H9hemrs7usvCerIY/GZgwRiLI9e9eiyIb9HehCE/ZHRO065OfcDgJQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFRRqk9xvXj30KeamAuoDK33kreYdLRpzOhQr3Pzf1I=;
 b=VqKXgUR2B5fVjhp5GdIiTYz4S8utt21hvb1WpYOZUcnzH7oUXH0rZpcbbxTRNljmpKf8N56QiyfSVXOCJZVj/fkfwOQatTlH3QnMiPJZRXAqHP8LOCDFVKe+yIsFBvMsW/1VMEwNngrhbAoDRQQ8jtuffqxI/K2j+ypLEugK1ImojmafEPjYev91JuLQlEtj9YuSr3DTLy53t0jezSF1JcqGtG8wqwLGc0qPpbP6dtUG5Q5PdIeSCfsi7TgBUo+gdxyZoYC9wyP6KVZGuDzRxQ9E3YT0a07CjO0ej7adcmBRGkzijbWiw4wvy8vKSUynL4irc05LhTTnyhTJeWvaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFRRqk9xvXj30KeamAuoDK33kreYdLRpzOhQr3Pzf1I=;
 b=B7AghkNzNwtmurMOzDAbyetq7Hgu4Ct++7FCNIEFv6+ZrrFvIxlrq6pm7BC7YGh5P0OHRg+ZY9V7+4OZz3S9sokN8F/GAPHYZO45rB5qKMXHsy09JapYbDt6T0rnZIPGzaIFGfV9JV2LqOfwf3oqhyJ9fs0M+Cp5Tuz12NrHWFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Tue, 27 Jan 2026 05:44:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 05:44:13 +0000
Message-ID: <283b02db-3038-4e6c-b577-a9fa02741b1b@amd.com>
Date: Tue, 27 Jan 2026 11:14:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/amdgpu: Add ioctl support for cwsr params
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com,
 "Yat Sin, David" <David.YatSin@amd.com>, Lancelot.Six@amd.com
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-10-lijo.lazar@amd.com>
 <CADnq5_M6Mi5SJi_AYKhdmwacxumeTUrRHMrKazQxEM4v=utS7w@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_M6Mi5SJi_AYKhdmwacxumeTUrRHMrKazQxEM4v=utS7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e644b53-70a3-45b9-4cc1-08de5d6719eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG5IeTIrUiswSkk2U0p5UEtQOGFIUU55YWpuSTVmU2JVb2lVeHhjS1NZejMr?=
 =?utf-8?B?R2N3N3AvZldoR2tZQjlRVEhTMHluVkhKSFJENXdRY2VwU0FYRnZhbDJRcFJ4?=
 =?utf-8?B?UWJaYVhqVTBMN1A4T2o4NkdYWGRsejNtRlkrTTZhN1dLeXoxeGVLeVR5dnZm?=
 =?utf-8?B?c2RSMUkwNEZwYW5TbGtLT3lxNjF0T0xkK3hERXBXbWdXSzg2WXdYa0J4SFV6?=
 =?utf-8?B?Sld5OHd4MVEyaGdtSmxWOFFaQSt4UGQwUy8ydnRaM1hkQnhNcGpjN0pPM1hp?=
 =?utf-8?B?eEJrU3VxL2tjOE9NZ24xNUZVQnlDOWpMSnAvOG9tQUkzZWo2YkZWNm5VUG1E?=
 =?utf-8?B?WFRmeXk2QTRZakNOVTNtV3czemwwVW40N2xDZTEyU0RvWG9hRmY3RlNkejdU?=
 =?utf-8?B?UTh0anhtVll0akJ0NmhTRVlaV0g5djNadHk2VjdHazNRVitDejhCR2ZVUnJ3?=
 =?utf-8?B?d29RL0lsOFc2RExLUFZhRGx0YTlCakFjNSs3YkVwdGhBUUl4M0tXeWg3cU8w?=
 =?utf-8?B?SUtMMUlYbXJvbVhNemRleVJJNFh5eGJKOGIvN1JLS2lGZXNXN0pHT3ZUWThn?=
 =?utf-8?B?V1JVSWRINXI1eU5ocnRzWGpKVjFpTU9ydERZbU9Wait3cEl4K2JabE5wZ21m?=
 =?utf-8?B?aGtpQzUvSmFPc1lUM2xmR0M1ZlBYemkwUXFBY1liSEc3Y3ZTZ0dncVU4QmxO?=
 =?utf-8?B?emt2WWE4ay9lMzlnb0ZCZWJUQk5MbUV5b3k4L1pmOWJlT0lwaTZ6UlNsWGR0?=
 =?utf-8?B?eThpK2d2UGIyMTdMeUlQKzEvT2krM2RMRFlZN2JxUzVGZG5xbjU5d2E5cXpW?=
 =?utf-8?B?MDMwYlJWNEhVWDdsU2tyYW15eWpadDNYeUxCZnpmcW1PbWhLaWNCMWhObjA2?=
 =?utf-8?B?cFJXc2pWUnZlRzhjdVFmNjJQMXYwaTFkclFUc2R4V1h0TDI0SXUvdGtJd01Z?=
 =?utf-8?B?V3VPNEtEcGNzU3dVVXNhRlF1SnROc0c0WENIZDVjNmZFRmJkZHFtck1DR1Jk?=
 =?utf-8?B?ZFpjWm4rbE05aG81OEdJcEdTU3ptY005aDVRVWZHUTl3eEpGQnFUU2FsblEy?=
 =?utf-8?B?MWVZbkFVb2FjRFhNOVVUSS9BMDd3QnZaU1ppNmhMMDBmWmI5Z25DK3FHcmdB?=
 =?utf-8?B?L01HN3RPOGpkNDdVQ2V1QzVtQkdQcXlGSnZlY3IxUGdKeXVmZlYxeVNFUTFD?=
 =?utf-8?B?UGZ5bnhEcXNMWGdiRS90VGpaTUw2QjRLUWZjbTYxaDhmQWR3NlBVYzB0akhs?=
 =?utf-8?B?dHNNRUFQdGJaRjJUN0dIcGhHbGp5VFk1ckdrL1dSRWF5TU9ReTRoR2Y2ZDZR?=
 =?utf-8?B?S01ZakJhRkdDMEc3cHdXMVZSRVJMUTZVTEJ6aTQvNWFCSjN0MDZQTHl1dk83?=
 =?utf-8?B?MldrZEdwVUEya3EvN0hpOXZqNlF5N2p1RVV0SFYrVUpSaDRIYjdiMUZlcDEx?=
 =?utf-8?B?TWVkRjZJVFliMktjSGE5RytKa2UrWEdhMzc3M3hOMmNUQk53NC9jN1RSTU1T?=
 =?utf-8?B?bnRNazZPUjc5NlVuUFpleHhxU3EyeWFPNWpwNzRsRlB0c203Zjl6Q1piaHZ2?=
 =?utf-8?B?NzB1ejYraDBjZGRObThTYmowZWFhSzNNOTEzOURWbGNMMTRQQzl1amZMYlcv?=
 =?utf-8?B?VzJreHZLNEhKYmpiR1d4M2ZVOFZXaWdmNGxEdDA2OWhsRVg4Y2FZZ00yelZM?=
 =?utf-8?B?T1pZZiszVkNUeUhrZ2FiOU5LbHY4YktZZVNaTXBWMzAvZ3lCMENTdnJ5UElZ?=
 =?utf-8?B?TXQ4QUN2L2J0TG9yOGJDQVRDRytkOWIranczWE5xM3p2MzFqYXJxRnIwK1VO?=
 =?utf-8?B?aUFLZmE0aHMzT3FuMk9TdVh6R3A2eDRYSUtnbC92ZzhKUFJkTTVxbDFxQUZM?=
 =?utf-8?B?RmRMVzZVUzYvZEtUTGN6MEdIT2x2NDVMSTJPNE5yLzl5NzdZcW9Lb2loa0NF?=
 =?utf-8?B?a2NVdjg1YlJudUdraktZTnNhekZlMi9Kdk4zbkxiYm95V0lid040bUF3WklV?=
 =?utf-8?B?QzJwU0lTeXlta09aSlBGbWtBdVRUb3dpL3RkazE3MHcwSHZna01Gd0pyR2lx?=
 =?utf-8?B?a0NNYVlsdmYxQ0NDQTBFL3MyY1VJcmZwVG5IWGJ1M3pTQlczMy9ucjNpQUVK?=
 =?utf-8?Q?Dep7dWuSpQW7mA9xHu0MSKMMF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpSVk5XMjhiSHNSbGdMaGRBRXUrZjh5TzUvZFhobklNSWRVNmFHd3pTNnRQ?=
 =?utf-8?B?Qi95aUFGb09QcWJ1Y3pPc05NYU1iNWxFTXZ5dk5qL3lRNkZ3WTJ1ZXI5MUht?=
 =?utf-8?B?MjRhRGtucjZZQWIxTUZkTkExSXViR3JPeTIxc0FxbmJ6SWdYN2ZPUFVheWpi?=
 =?utf-8?B?QlQ4NkNXUzVuYnR4aml5bkpBUmdLQkgvMU9pL25lZFp5ZVRQN2R1WGNuajB5?=
 =?utf-8?B?TVZ6cnFEYmYvOTRHNng5YnNLMGU4clN6VDJxS041OU9razhWYjFEYVFFSTgr?=
 =?utf-8?B?YWdTZncrZWNmdStLOHFJVm1vMUJ5U3l6eWYzckpDdU5MSHVyWHlzbmFvNkgr?=
 =?utf-8?B?dXMyVTN2UTl1dEhlRnRzNno0UXZhOGZ4MGRoWHdqZmR0RkpxcjRBYVllMFo1?=
 =?utf-8?B?L1p0T0g1ellpZFllSkRpUFJ5NDdyZ0pobzhkb05DaC9SaG5wWDNYUTdHQTV2?=
 =?utf-8?B?MW9qT3JIVzhqdC8vaUpoSk9EVUxmdmVRMGpVaXZDVHhPVVR5bldUKzV3TzBQ?=
 =?utf-8?B?YmFuUE5xVXZlWk9lZG9MU2p4VjltbUlsR1dzZ3M3cXQ1cWN3ekFBUDZ5MW1w?=
 =?utf-8?B?aGJ1aldMTjFITEd3ZkFPOVh6WXJ6WitMWXdmdzJDS2FIZUd0K0VjYnZoTVZE?=
 =?utf-8?B?Q3NUQW8raFFGcHM1YmVLRlVKRmtPNm1OaWo5OWVCQlJORUc1SHlSNGsvcDdq?=
 =?utf-8?B?ekM2aUJwdDJiczh3VE1TalZNSFhtSW1vem5aR3QwanpveldQNmROaDM0dXBw?=
 =?utf-8?B?ZlhjdVBYdUZ3RHZ1cDJUYlkwalVxWFdlVjc4V0o5c0U4dHQrQndVNFJQVHhK?=
 =?utf-8?B?RHZRRTMzMzV5TTFyblZKSHJ6dTVOdVdFT2d3OXEvMFM1aEhRenRLT21kUE5k?=
 =?utf-8?B?dCs4M2hwOEdnTlkrcXlvMzhNVTg2TVFZeEdFRUpRT29WSkxQNklnOXpmcU9O?=
 =?utf-8?B?ejIzL0wyTnAxMWNtOSs3aEo0OFpqa2RpS2FzUWNveWY5bHd5bFJiOC9GS3pT?=
 =?utf-8?B?MjA1eWVrQzhrVWFSeXVmcW1tUE4vSnkxbnlzcHhHbnVoMnk1L2JoMmxuQW41?=
 =?utf-8?B?WVBnOG11eEovOHVmUHB2bVMvNkkwdVJ5MkYwN1pIN3JDYTB1UEZJNXFzZHpk?=
 =?utf-8?B?dVhpOTRsb05ha2xJTGV3NFFFZXNuZ0FCTDVEY0E0MERvL3VPMmZ6bzRFNFFG?=
 =?utf-8?B?N0RaOEdKZGhwRGN2V3RiYVhGS2pNNjhhZTRGT0dmR2VlRkprNVowV204QkE4?=
 =?utf-8?B?ZkhKdjdZeHN2SzRKVGpvTzJjQk43RnM1VTlMTmE3anBheDB1cTRUeEdmYkpm?=
 =?utf-8?B?UVMvUEl0ZkY3aUt3MUxROVRUdFM5a205QU9TeHQ5emlsRjZGdkFUOXRsSVND?=
 =?utf-8?B?dUF4ejEzLzNvRUxaRHBMdGpXWXlmVnlTSUQ2NTVaNFQ2MU9sVk4zRDdnR0oy?=
 =?utf-8?B?bjF3ZFFWV3NGSlluOGd4TEVUVVd0VmFTdm92cDRCQUlpS3VaamNMY1JFUXIz?=
 =?utf-8?B?MDJGeXVHUlFzY0lSRGkxWFEvSTVxQVMrd1ViS1JSWEVUOC83Qmd0cm9qRStC?=
 =?utf-8?B?UTVNSUM4Y1o4aE9VZjdxN01PeTBoTFZzNnl4bCtLSFRXZmhSaTZweGlsSXRw?=
 =?utf-8?B?bmhtVFVUUzM0alJYeW54bmRmT29ORTNDR3FuaCs5NGdWUldNakkySjlIaDVM?=
 =?utf-8?B?cUVRY0c1MXRpT0xUcWtQd1VrVDZYcUdHWUhleFFNRGU5aWpqODBjUTZzN0NN?=
 =?utf-8?B?YmxtRmI2dFg0YXVIK0U0ZkhTbW80cWdJckp6eXg1OFQ0WFpnUTZaYmFUODhS?=
 =?utf-8?B?OVRWQlN6aWg5YzRMYkZoTnRnam00OUJvRkx5V2FoRDlLOXdTVkRnWWh3eitr?=
 =?utf-8?B?ekNQc0U4RUc5bEFHdEYrUWFTYUxJdHZnVUJHQXNpR0IxL3lGZGt5Z3k1My9V?=
 =?utf-8?B?a2kwRjMvWEtTdWV0RTJZZVVSUDdZc2VpRTAzbVJ3VHcxQlJUOW5HZExQVWZP?=
 =?utf-8?B?akF6clZ5WUNHcWdBMmRrUUM4WjB6akxGazNMZFZGbjV2TW96cHJtcTZmWUlB?=
 =?utf-8?B?aVJ3MXJYQjVnb0luV29CN3lSNjVCZ0IzZEFKc3JCcHVUS3VVYmtZcVpQZ0VZ?=
 =?utf-8?B?UERQeWYvSkFEUFpEKzFTbEc3Z0xuS3VjVkw1OEZFbUZaU0xFeWxQREhSU2cw?=
 =?utf-8?B?bVFYS3MyaTBVaEZueDhtajI3MjhUc0dWT0xsTjRHVnJCM3V5akcxaXRoRktS?=
 =?utf-8?B?eDUxUlRXbEVDMEI0Q2xEMEsrWUQ1cmY1bG1YY3YrSWJld09VK0YzTHpZTG1p?=
 =?utf-8?B?R241ZERRSjZ3eFlnNjh6OU8rUjlYbUJ2WThvbHUwN1RKUFI0TGZVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e644b53-70a3-45b9-4cc1-08de5d6719eb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 05:44:13.2308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofX/fR5Piue9AmzxzRnjkHa6IQgO0AKoNmZV5gMqfYbOyMAQGcrb1uxPTF4E5wPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
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



On 24-Jan-26 2:21 AM, Alex Deucher wrote:
> On Thu, Jan 22, 2026 at 5:52 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
>> address for save/restore buffer, and size allocated. They are supported
>> only for user compute queues.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++----
>>   include/uapi/drm/amdgpu_drm.h              | 16 ++++++++++++++++
>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 7ad8297eb0d8..2765317f04df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -343,16 +343,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>
>>                  if (amdgpu_cwsr_is_enabled(adev)) {
>>                          cwsr_params.ctx_save_area_address =
>> -                               userq_props->ctx_save_area_addr;
>> -                       cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
>> -                       cwsr_params.ctl_stack_sz = userq_props->ctl_stack_size;
>> -
>> +                               compute_mqd->ctx_save_area_va;
>> +                       cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
>> +                       cwsr_params.ctl_stack_sz = compute_mqd->ctl_stack_size;
>>                          r = amdgpu_userq_input_cwsr_params_validate(
>>                                  queue, &cwsr_params);
>>                          if (r) {
>>                                  kfree(compute_mqd);
>>                                  goto free_mqd;
>>                          }
>> +                       userq_props->ctx_save_area_addr =
>> +                               compute_mqd->ctx_save_area_va;
>> +                       userq_props->ctx_save_area_size =
>> +                               compute_mqd->ctx_save_area_size;
>> +                       userq_props->ctl_stack_size =
>> +                               compute_mqd->ctl_stack_size;
>>                  }
>>
>>                  kfree(compute_mqd);
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index c178b8e0bd3f..b7a858365174 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -460,6 +460,22 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>>           * to get the size.
>>           */
>>          __u64   eop_va;
>> +       /**
>> +        * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
>> +        * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
>> +        * to get the size. This includes control stack, wave context and debugger memory.
>> +        */
>> +       __u64 ctx_save_area_va;
>> +       /**
>> +        * @ctx_save_area_size:  Total size (in bytes) allocated for save/restore buffer.
>> +        * Use AMDGPU_INFO IOCTL to get the size.
>> +        */
>> +       __u32 ctx_save_area_size;
>> +       /**
>> +        * @ctl_stack_size: Size (in bytes) of control stack region in the save/restore buffer.
>> +        * Use AMDGPU_INFO IOCTL to get the size.
>> +        */
>> +       __u32 ctl_stack_size;
> 
> Does it matter where the ctl_stack is within the save area?
> 

This is the legacy way. Probably, this can be avoided. Adding David and 
Lancelot.

Hi David/Lancelot,

Do you have the background of userspace passing back control stack size?

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c#L260

Can driver assume that context save area takes care of everything and 
assume that user allotted as per the right control stack size?

Thanks,
Lijo

> Alex
> 
>>   };
>>
>>   /* userq signal/wait ioctl */
>> --
>> 2.49.0
>>

