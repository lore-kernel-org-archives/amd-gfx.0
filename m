Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2837C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 14:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEAA10E2BD;
	Wed, 16 Jul 2025 14:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ptw6sn/7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C8510E2BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 14:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spEZZr2KhC0AJkAvQQoVI9gqI9o12VJ8pljxMz95ICHuuRtOWWy76ZTEm1IR6ZLx49seolXuUoYoMz2hHD3pytfoRrn/2vuKdyv/2bcQi4KBmlzS9H5yAAqkFmqHwW+rV49yKtZQZDe70eo6vyDfGjW7x/XCP3dQk4s1Yvk5LHvtnOiTQNlNxhDabWLhM+5sMFfftEZDoQkaJ9F/yng995wQzUpRerWNjj2kJgTAQiJw61jyowMFVV6GQK2kG/lv/BlCRkTxde1/fMOncekfkj4qsJflX6lp70oDSvHR3c5vJ1RPt1yT12y2Cp7K4Zvm+MJ7AgatMOfddcR/9QzwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhLylX1Il6yJFdpgh3gG10bRDeT0CKlIg5tjTleklt0=;
 b=qs8KEMwHwbHOkYLz7lhknshogyn+/f0g9LnLxtEPmdUdHqSoVwevU1BPhhhIo/8BDWt7aRnu9iDZvEQELraGVFx3iYEpxYH/smJ5NDWxADXB6ONvvHIe/83KDBgkeHQ2MD16lt9a8d3ZuK9qqsKMPjqQmPNph+GdjiFlf3xMsVGzVTzjeQj6YGS+f/yLguPj7kVnLhZUobfCPoSq83mEOLlKbl3qF2UDvVHocFeYT75Czx25dm6r6oXwVMfnllt9vRveZ05ec3FThwkEIk1cVTzXKuxF8ESd/4CUKivy636k2nGIqJKuM7z3le6+nSAe25E8oxYpRJjaYMltaPZlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhLylX1Il6yJFdpgh3gG10bRDeT0CKlIg5tjTleklt0=;
 b=Ptw6sn/7srn89exBYPCGSETnE+T4iOfDc3W9GMhzflKnbOMjFW2X/ndmd5cmMjQILLt3A6LAVGp14Fx95F2uw38fIdvh5KnVY28NZA4CdYL1LOSWMyGeQVs2/qlSBliphB3A7c0ZDw7jlzeI9Ny3O87USifRtRX9W8wZBTKVA+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 14:59:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 14:59:02 +0000
Message-ID: <43166a3a-4b51-4c33-a3b7-7872b9b9da59@amd.com>
Date: Wed, 16 Jul 2025 16:58:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
 <CADnq5_NYhPa+6gUqeJsvXkqtkwwkWmv=F70Wv96L+CEA-AGE1w@mail.gmail.com>
 <6d19ad87-6091-477c-a1ee-ddb224a63fe1@igalia.com>
 <CADnq5_PFKKdDOnX7np+31jDfmf17=PNSFoFtmHk+XSPqRjnf4Q@mail.gmail.com>
 <a07c4db8-a775-4036-a30e-8266c02283df@igalia.com>
 <83463d64-b0dc-43e7-b098-b978c44756da@amd.com>
 <3ba4e401-149a-4bb2-8725-1e4fd58f3288@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3ba4e401-149a-4bb2-8725-1e4fd58f3288@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f94211-d5a6-4d71-4758-08ddc4794d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVZzT0FqWFljOW1DZE51UDVhS0dWRFhJcXJ1cWRsYUVKZTdWUEozU0FkTXMr?=
 =?utf-8?B?N3ZYYlp0QmcyVUh3L25JM09oZ2lzSDJYT0kxem9hbm9NR1lJNmxIMmt5OEdB?=
 =?utf-8?B?bjFoK2g4c3lkMllnMEZRNDVLc01DUWpwbS83RFUrUkFuUmV1NkdiYUsydXpp?=
 =?utf-8?B?YmQ5Q3l0Z0hJM0Y4ZTcrRXFVUkdaTlNGeHh1VzdLMWVILzgwcXl3S0lCdnVx?=
 =?utf-8?B?TkpQbEMva3pkVzc3NFZoZUdVeDgvQkdFYi9TR2dndmlxUTJlcUNOY0MwU3RH?=
 =?utf-8?B?YjFtcnBEYm9acjBlK3k4Ym56ZGE2U240NGVMRkJCNlVrTGx3bjJLVUdwS0lz?=
 =?utf-8?B?b1gyVjNnZU5wK2twK3Y0NXVhaDBVQUN0b2dGZlpvK3VjbUgzNU9JaTUyM1Fv?=
 =?utf-8?B?V1V2ZjVvSUtlQ2FWVUxSdjRUWmpKSjBIYy8zT3RqZTVNbjNvUHBoTmZidUFp?=
 =?utf-8?B?MC9ReHdyMlhmcnZzVGw5c3FlUUtVcWNhemZzdzhPUEU1WmFUUGFnZncraG1J?=
 =?utf-8?B?dmRZYXZJK2ZHRnk0NmZoT1RxYlRwSU9WZ056c1M5d3NDSGx6QXhGR1NuOWNj?=
 =?utf-8?B?RjRBUlNxVFFRTnNIV3cwM3IvZkZWNUpnbmViTzgzaEtXa1A1OUM5R0F2cCtS?=
 =?utf-8?B?MDdZdkpXSW1LZlY5TDdHdXZ1UTVGc2JsVXFWRHZucWRoR0xSMVZNbHNXOFR0?=
 =?utf-8?B?RDBESGl6VENOUlUybktWWTljZFJ6TkJFYU5SeTZnU2NRckpGYjZDMHZjWTBY?=
 =?utf-8?B?S0tMZ3RQQmhLTHFDRjFYR05WbFp4UnZITHNPR2tSQmJUNlBYSjJtaFhIYWxi?=
 =?utf-8?B?Y09TVVhneTVIcTVnd0ExV2d6T3B6RUhXZTZ0b0o1ZVJIeXRWRWhDd3h3clpN?=
 =?utf-8?B?Ri9RTU1Fc3NUejJtUm5zYmIvdGJjUTRKd1pGUWtFcWtzU0pJRlBMNlZubFlX?=
 =?utf-8?B?Q2RoUlM3Ym9VODMzSktxMWZMVjJhYmJJZWhaaGkwUVRUeXMwMFVBTkRnUk53?=
 =?utf-8?B?WHpvdEEyT042dkNISERCSUJBSUF2VGRYV3h2eXdFaVlxU3c3YXc5MW5vQklr?=
 =?utf-8?B?cDZWcGZ4c3FEMy9iZ2sxM1gycTZTT0FyRE9FaERQTC9PUHJiLzFySGF3OUlh?=
 =?utf-8?B?am9qelVjSkptZkg4SnZBVE1FRDkwSzR4VjZxRmdmUGg5eVpPb1M2T1JQcVpN?=
 =?utf-8?B?Qk1EMExNWU1iTDl1S2dKK3VYNGp4MU1SZXpSLzRXb3NLaUtHbmRDL2Rja0Vi?=
 =?utf-8?B?ZUlWOWRIa1FGZjArWFFNMXVYWkNidGxTUEEva0dUTnFYTUtzSml6RlhTU0Vm?=
 =?utf-8?B?K2dMK0tpRUxWSlJueUFTTGxQMlVZT0k0VnJSM1FXOEtHYlhnUmhURDkycHNy?=
 =?utf-8?B?WEU1M0NvdmJGNWFJNXp5MVJneHU4Y2gzazhEMXRYejdCbzBhUFZmNjE3U2FP?=
 =?utf-8?B?TEY5aitCRWlBK2lXTmVtRjI3ZUpGc0txc01vd0lFcm4wMWxrSUd2VGhNakdo?=
 =?utf-8?B?b3VQN25WSlRzZURQQlh0VFFDTUJuRUZ3czh6VTU5aktiVHN3RW12UnJzTXRC?=
 =?utf-8?B?VmVhWVIrNFZSMy83YkJNc055b1R5WEVqSUYrVkxLYmhSZWZyYU5tTVQ1c0w5?=
 =?utf-8?B?aEZQNE9uRVZyamRlYUNHTElLTkxZWVNQVmV6NXNsUVlqQSt0Uk1zUzBjV3ZP?=
 =?utf-8?B?TjliTFZVdG1uZHNBWTFqdUFtZzZjUm9BUDlWYURnN1d2UFVoMFJOWEVNbzBj?=
 =?utf-8?B?UlVmWXFZQnRXdDZOSXNVSkY2MUVsc2syd0JXTVdCZGg4NVpiOWwzRnFkWlFD?=
 =?utf-8?B?bU1lYnlWTUYzQ0x1VUU4MGRUTS9LWlJlM0FQOW9QVjljNmZOZUVFM09iVzJR?=
 =?utf-8?B?Mlg2MmEwYStKa0o3R2FnK3oyN0h2WThKRzNmRW5ORFdZWUxsd0VtNUt0R3JH?=
 =?utf-8?Q?wLHfJQnALPE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVsclh4QnB5NDJSSHJnNU5GVVRZK1kvenk2cnFCUU5tcWVpM1cyNnZMQjQ1?=
 =?utf-8?B?S1VrTDkrZlZhaU5EZCtGdm1UaU8vTEIvV3ZOT0kwWUYzQ0ZRQmpMR1EzZnk4?=
 =?utf-8?B?SWFvemhTdmQwaE9RNzd5RklYUUwwZERYcDF5TkEzUTJzT0F4S0NXOEhkaEpt?=
 =?utf-8?B?aFV6cnhRd2hLUjNVNVBYNE5Wb1ZZTFEzakJIRUZqK240dVBWbnl5TDMyWkEr?=
 =?utf-8?B?S3hlZEhHOHdCc3pXa0x3Wkl4bnNiTnBrNEcyZGRjOFhLVFlob1BHak5adGdF?=
 =?utf-8?B?QnRqTmxlc2dBYmJLY0NUQ1cxZkdJU0g5NDJLU1hGR3JqbUtFM1R3QkFxUFNz?=
 =?utf-8?B?dVZld0JGbnFoSVBSK0RoNUoyVmplSzVvdFpmK0thWjBaNC92VGZaTnJnT2hK?=
 =?utf-8?B?L1R4UGtSZ1ZESVFpSDRlcWVkNGJ6YkZkUjRTejFseVlwVU1hMEpJdFJGVUJO?=
 =?utf-8?B?RXJjSi8zU3lwZXJ5RWVpZXRTeXRzRlVLV1RicC9aRzBreWlwOFo2SEs5dk0r?=
 =?utf-8?B?N1ZNUzVyU096NGtHM3NsZDBFS2dSV3praGNqMmk1YjJmYXc2T2U5c2IxZThu?=
 =?utf-8?B?eGJrZTUvSTNuSm1OaFpKRXNTTVJ4aFhTOWRlUFV5emIxN3Q1WFhqQVNabFNY?=
 =?utf-8?B?RGl3amthNkpvNWNKTTVyeHFjYXBLMTRraUdXeEp5c3hITTZkYS9vWFF1WVNV?=
 =?utf-8?B?V2k0WEhiRGlJdHphOG05RTUzNEo0dGR3TUU2V2NUdENRRWtEYUs1ak9pbVll?=
 =?utf-8?B?QWxSbE1SaVEwMjBEbzJ2VERyUkpuVktINXptbExZTllBZm1TWDRaL2t4SVUy?=
 =?utf-8?B?Nnhwc3JCUU9CaFo2ME05Wm9IVHhGT0JQeFN6NW9EN3ZlQXRJWFRsUGhPeGov?=
 =?utf-8?B?MkZhcDR4V3FTcllscTNzVG1wZFRXVEUzUDUzZWhPaFB3Mkgrak9BZWVXU1ZL?=
 =?utf-8?B?SGQzcS9DdEhaRDQ0V3hTTTNqL3B4bUFpd1NsRUxnS0JjWHRlckdXaUFhKzhQ?=
 =?utf-8?B?RmdUUk9YMk5STUhkSk9qWEphdHpwVEQzNUt2UjRlNHViTmJOdlRkYkIvd2do?=
 =?utf-8?B?NHlFM0M5VWJCNUpmYmprOUlhMnJjb0hjOHpWa2lmTWNjOFB0Zzk3R0ZhSDg0?=
 =?utf-8?B?RzhUR3o0WTZORDVCdkVDZURaV2VVK0xoWkFCNEdUM0VCZkVNbXllcWFHTUJK?=
 =?utf-8?B?bnVnY1FubTZ0T3lYNmFscVNXZTVxMVVlN0xPTUlCNENRckdQakMvbmMybkh4?=
 =?utf-8?B?TnZLL0hDdTNCOEhDQURsNit6Z3lFRkMvSWhZc0tDODVnL1gzSHQ2OXdkTG5k?=
 =?utf-8?B?VDBKenBEUGtJZHJGejZUbldySk9YbGlCczRIZmRCQXR6cDhyamVYakUybHIr?=
 =?utf-8?B?NHNwMWdBOGI0WlZLc1FMWkVkS041V1VUb2NvRHJOYk40SjdFd0U5UUJjRUJx?=
 =?utf-8?B?V1AvLzh0NXRWVmhxSW5DNldId0hPT3pBTEhkSnNTbzJqUEYvbEJIK3dUMThz?=
 =?utf-8?B?eEdQSkt3dis5MWpTNzJVTmhIQTVIZVorNGRWOG5DcmFoTnVENWtQVWg3ZGFO?=
 =?utf-8?B?YlRTU3BRWTd1STVlSmF0VnlWTDczdy9GeXRRV05jMHN3NlNXVys2aUdFa0hw?=
 =?utf-8?B?aWdpQy9UUEhRT28veTRKM3hKUVlRU00wUHFQU3pycm05b09kWU12NFFGVnlo?=
 =?utf-8?B?QmNOcjZNMkoyTi9WQTlIZjc4MUZaWFd5emdrM3ptbndSWXM3T2xQVlYvSlR2?=
 =?utf-8?B?eVE4T2NYdnUxZVRZR3llZExYbGFwYUQ5YXpXS21xcXVMTHRCS2t1QzRmNzZG?=
 =?utf-8?B?RTYrOHJjaFJCMUU5ZFl6RjhPeXlLbW1CQlpMMHkwNlkrUndCR1hoQVVKZkRo?=
 =?utf-8?B?SEJkWXZ4Ny9PSGVQT1c5R3B1OFZ3N0N4ZlJ5MHRYWGJoMFZtVUQrZkwzbjd2?=
 =?utf-8?B?WEc3dHZLNElyQUFtQVBaZERHeDJMWmVoQTY0U3VkZUFjQTNVOEhsbG1rRXZB?=
 =?utf-8?B?UVAwOUgxOHJWT3ovYURNM0ljNWRuRkFZZmpESktORnMzQk8yaEtRemttY2xa?=
 =?utf-8?B?SURlMXNNU2dvYzVFZkVZUDhXbEtWcXd2Sm82SHFDWU9xRDFUT1dTUWFVam4w?=
 =?utf-8?Q?QYa5rEkEi+aSVhWL0/QimGrAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f94211-d5a6-4d71-4758-08ddc4794d78
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:59:02.9106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxuYHvu89pEuABnRI2r0hvq/ln0dWzmqkSl79q5q0qpSTcbfIVB+FX4n1SZ+iito
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

On 16.07.25 16:06, Tvrtko Ursulin wrote:
> 
> On 16/07/2025 14:00, Christian König wrote:
>> On 16.07.25 14:51, Tvrtko Ursulin wrote:
>>>>>>>> be disabled once GFX/SDMA is no longer active.  In this particular
>>>>>>>> case there was a race condition somewhere in the internal handshaking
>>>>>>>> with SDMA which led to SDMA missing doorbells sometimes and not
>>>>>>>> executing the job even if there was work in the ring.
>>>>>>>
>>>>>>> Thank you, more or less than what I assumed.
>>>>>>>
>>>>>>> But in this case there should be no harm in holding GFXOFF disabled
>>>>>>> until the job completes (like this patch)? Only a win to avoid the SMU
>>>>>>> communication latencies while unit is powered on anyway.
>>>>>>
>>>>>> The extra latency is only on the CPU side, once the
>>>>>> amdgpu_ring_commit() is called the SDMA engine is already working.
>>>>>
>>>>> It is on the CPU side but can create bubbles in the pipeline, no? Is
>>>>> there no scope with AMD to have GFX and SDMA jobs depend on each other?
>>>>> Because, as said, I've seen some high latencies from the GFXOFF disable
>>>>> calls.
>>>>
>>>> The SDMA job is already executing at that point.  The allow gfxoff
>>>> message to the firmware shouldn't come until later because it's
>>>> handled by a delayed work thread from end_use().  If you have multiple
>>>> submissions to SDMA within the delay window, the begin_use() and
>>>> end_use() will just be ref count handling and won't actually talk to
>>>> the firmware.
>>>
>>> I followed up with testing a bunch more games, and is it turns out, Cyberpunk 2077 is the only one which has this submission patterns where default GFX_OFF_DELAY_ENABLE is regularly defeated.
>>>
>>> There, around 1.2 times per second the SDMA submissions miss that 100ms hysteresis and cause a CPU latency over 100us (I only measured when >100us and ignored the rest). Average latency is ~400us and max is ~2ms. So IMHO quite bad.
>>
>> What exactly does Cyberpunk do to hit that? Are those SDMA page table updates, clears or userspace submissions?
> 
> I will have to look into that to provide an answer.

If it's some kernel work we could consider using the light weight DMA instead, but we never fully exposed that yet.

> 
>>> And the vast majority of those latencies come from the SMU request. Only very rarely someone hits the mutex contention path.
>>>
>>> So that was the motivation for the RFC. I suppose I could have also proposed to increase the hysteresis, but holding the GFXOFF disabled for the duration of the job sounded preferable for power consmuption.
>>>
>>> Anyway, given I only found Cyberpunk 2077 suffers from this I guess it maybe isn't to interesting to upstream for you guys. Then again it is limited to specific old SKU so maybe it should not be that controversial either? Only that Christian NAKed tying it to job lifetime. So I don't know, AMDs call.
>>
>> Well what you could do is to take a look if we couldn't simplify the SMU and/or adjust the GFX_OFF_DELAY_ENABLED.
> 
> SMU stuff, as far as I can follow it, ends up with simply sending some messages to the firmware. So I am not sure what and how could be optimised there.

Well how does the SMU wait for the HW to complete the request? IIRC the SMU interface is not really made to be used like this.

It could be that we can improve quite a bit there.

> Increasing GFX_OFF_DELAY_ENABLED would work, if large enough, but I think it could be bad for power usage, depending on the workload.
> 
>> On the other hand why does it help to keep GFXOFF disabled while running the SDMA job?
> 
> Only because I tied it to both GFX and SDMA.

Got it. Yeah that is not really something we should do.

> 
> RFC does this:
> 
> 1) Marks SDMA as "needs GFXOFF workaround".
> 2) Propagates "needs GFXOFF workaround" to adev if any active ring has it set.
> 3) If adev has it set, it grabs and extra GFXOFF disable for GFX, COMPUTE and SDMA submissions, and marks those jobs as "hold GFXOFF".
> 4) Releases the GFXOFF when marked jobs are "completed" (well freed, since completion is IRQ context so hard).
> 
> AFAIU from what Alex said I understood the parts of the chip handling GFX and SDMA (not sure about compute) are under the same "power gating domain" (right name?).

Correct yes, and both power and clock gating domain is the right term to use for this.

> What would you suggest to log power use during the game? Something like once per second or so?

For the game the power difference is probably so small that it isn't measurable.

The real issue are things like battery life for laptop where you only make a GFX submission every few milliseconds on the GFXOFF clock gates or even power gates the whole block in between.

This is all done inside the GPU because the extra round trip to the kernel driver on the CPU takes to long and draws to much extra power in the long term.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 

