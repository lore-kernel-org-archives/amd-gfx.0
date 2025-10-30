Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0624CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 13:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D98710E990;
	Thu, 30 Oct 2025 13:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfyMQ51m";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D8310E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 13:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEDIrNOFi0n9I0pZnr71uWS0RBoNOdyGObNT9GYEDIQ578rHXNPk2URxZZAwrbFlNAuTc3Le4FslwBduJX4rRKcrTLzNnnGRSJVNGm+Us9CLka3QgpoiNX5ttBgWP7a52z2NcHlA8FDTY2VZQW3VDciSqFHs81FRIIR5EXQbJK2l4QrGRAyrX0wLbUcRrJf9Dtyp6tjBG8pUuwpE/CzIqk5DGCwwE12LGYbtoXS9IXepBKpHouE7wawamQf15pg7tG+JsmOBQP9sN63rH/p70XhnfXbmCTCYdtAVfzY20UOqcHW5lhMHzN6z9EpuxStqUgl2W7vYX8GKMsrB5XhXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7jutiyICPDsGvCqKT96+7l+z503Psnk+NBnhxSic2g=;
 b=smaukgTbWcOC3yMAQfXGQ/xjZ9XwxmsDXZ3BlrEvmCoT3fveQrrzbrlUqxV4AB3uDwXZsg/55jW1gWrb5X51KwxqfGKbZajxdmZ1CPJe1GtLS3aEtwesoQeT8CJ7+R8ZGQ0lKppRnSGPOyNPkEgTKuPfRfTOETfeybTZMyPfiep56al0T9icN65wbeNK627P/uVYp8yhTte7hi2r5x0z9sbDn0uVN89eJ7a/8wET05B2Wbc/B8Fh2uRBFzW50ijjHfuUjLudkqPCZchgf/uRSii1oRve6wZ1laaInvm1QD6xRuLrKJVddC3qdda0Qg2YuWDBR+F43YG022HzS729AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7jutiyICPDsGvCqKT96+7l+z503Psnk+NBnhxSic2g=;
 b=dfyMQ51mIobDWJAcHm2IRwnO+89DICZPBXGZxAhllB19jXvV5Y4zN/EVazryfdqREcaUstD+MBWffAz4SF+rgDLRHzpG9MZhgfuYOW0M64RptnedPEJJct0fw5bA+BQ3cpVt15tbpk6ntxT5NYE/kM3cBlCg7ll2MxRTJ0UtkSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:56:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 13:56:45 +0000
Message-ID: <eca41583-a659-4415-addc-7c74665a7032@amd.com>
Date: Thu, 30 Oct 2025 14:56:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu/vce1: Implement VCE1 IP block
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-11-timur.kristof@gmail.com>
 <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
 <18151c2a64164be39f257a407752a5f5dab1eb82.camel@gmail.com>
 <3c44c0eb-b60d-44af-987d-c29edd3991b7@amd.com>
 <846c7fb4e4bc53cba45f089ead9c44b3e00a59b5.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <846c7fb4e4bc53cba45f089ead9c44b3e00a59b5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cd0a8b-9f03-445e-39df-08de17bc2957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hwS3h5WjdVV1k1cnBCUDdjK0M5NzhuR1lGWjI1dEVqQVk1NU5vZ1BQY3Av?=
 =?utf-8?B?RE1GTXFjUHdsUFIrYkxwSzB3djEvZGpXTHlUZ1FXcjIybXlDeTdiZVhoRDVp?=
 =?utf-8?B?TFhKVXh6NTgrVDV5MEhKWWplTVlCcnltSm1Cb2N2cWloL2VqenpFbHFjQ1My?=
 =?utf-8?B?cTBzSzdVZW0xSDZsdVg3ekt6dVBwQmtNZEVZOVMvV0RhV3pxc25EaVYyOFBM?=
 =?utf-8?B?ZUZ4SHlhRC9XbW45V3JIRDJCUnBBWmhLYW1lSVVmNG1neEpKUVZ5Rlp3anZt?=
 =?utf-8?B?NmJWcTBYWG9ybGZhY3lXSWdCRDAzU1hWSXJtc0RIWWFKdlpwWCtseUtGeDJv?=
 =?utf-8?B?VE0rM1ZLUVdPQlVOOStKU25WS2ExbTN0S2FvbW1ta2kxZVpLV2dnUkpKVytW?=
 =?utf-8?B?NkQ2K1FpdDNSZUg4UytMV3RjMTRZZ3A4TW5hczErWnhTR3Yvb0QwRGIvR0JE?=
 =?utf-8?B?S2cvQ1RVKzJtRkpxa05XVEVoNnI0ZGE0OS85SkN2Mnoxalpla2NKZkNRYVM0?=
 =?utf-8?B?cENDTy9SVFphR3YvcnhoNnVReWorNGJrT3JVbUtrQmNyc1RZQUZvVkhBSWhZ?=
 =?utf-8?B?UTgzMTJBSkF5WGxnanFOZjRPbjFuR2VSRFkycnZTYTR0OVV6dmEvT2ViaDds?=
 =?utf-8?B?U1V0NXI1ZGFRcEJxRUtvZ0NKWm50VHhYM2FvWVZDaUJYeTBKZVkzMnBEVGZt?=
 =?utf-8?B?WnNiSUduUER2WXcxa0hPWlBZSm5PcERzMExTQVpUVVE2TXRSdXhtZkxSNlFv?=
 =?utf-8?B?NUV6TWNBRnB6Q25sT2ZoTnFHSmJYRmhxN1M4Y2RTNnJnOHNhaFlxelFSRGZS?=
 =?utf-8?B?VHFTRHNCdEVzazRpeFlPdW1aZW9RUnNsVzZCeWtmanhSc21UQW5Ya1RuTEx4?=
 =?utf-8?B?RFZVeWxZaXp6aVY3TEJxZE1BcXdNNFhyOFFjY1BMc0FCOWlvM3JiRDh5QnVC?=
 =?utf-8?B?TnlxMXl3YTR4TGpDdSt0bnQyS1hZUU1XTTFUQ2FLMlhuNDl5STBwOU1pa3NM?=
 =?utf-8?B?NHROVi9MMGI5eGg3OHRXbldVZ1laeTVGREs2WXdPUzlzTG1GSVFFVnQ4RUMv?=
 =?utf-8?B?RUVodWxOSm12S0RMZ3NhVFlIallCVUthampJaXJKSGtZQ2VhejFCYlo0U3Rv?=
 =?utf-8?B?bjh3VnpMZDhWOW1KaktjNTVjZ1NzQzlkTThJc3FmUWZJdHBOU0lrbURaaHRK?=
 =?utf-8?B?K1ZxQlEzWmxKSlVNa0F3VmVNaCtPVHNEYVhQME9zZitVaTByaGlxekdmLzVk?=
 =?utf-8?B?MnRRa0I2cytuSjJ2Zyt2bk9KMUs4dkFWeG5QY21lY0hvU25VZ2UzOUFwemdO?=
 =?utf-8?B?UkoxTUZuZnZRc3UyWVVJMmhaUVpXZzJYVDJaRjRxdnM3T3JqYkRLWUp3RFdH?=
 =?utf-8?B?VVJuU2JRdkNRNExsOTBNcnNsa1dLWXdwT05WeWs4Wm9aYjFVZVV1NUpXWTFr?=
 =?utf-8?B?Q0EvZlpGUDBSNVZNZ0JXcmloMWVPbUZkSmFVZVVtZ1NiU3pzTUh5aG50TFJy?=
 =?utf-8?B?U1JzOElWd3NNRlNURkh3bWsyOFp1bFRsaE04SjFjTzBsYU9aY3ZvK2xjaVVw?=
 =?utf-8?B?YUgxd1JmT0F2RnBlTVJicUpDWHR0Q3MzU0lNTTZKMmY5RCtVMGpiUXkxNWU0?=
 =?utf-8?B?REZudEE2ZS9wMk50aGZlRys4YkNGaEF1SFJ2L0NXck12eTBJTXNIQjMraDF6?=
 =?utf-8?B?ZEorVkJldjlUTWRpM1hld2FJdmVBRitaUXdJNmJKUzZCSG9UUHpnNjRDU0dC?=
 =?utf-8?B?c3J0SVpXc09mMzM2cWpTSjlyMm41VHhLSE5TVjN0Q2hoZHNHRlYvTWcraXNn?=
 =?utf-8?B?bnVmU01LOVF6eTB5c0dQL01VZTdxUzdSeWN5SWQvdEZQWlZOS2FtZ2NzS05O?=
 =?utf-8?B?ekRaWENqZ2tILzZXTTMvcjA2T0JSc0orVEVkL1BmYldmSnN4NzBFdTdXYlg3?=
 =?utf-8?Q?vi9Z/K6xaR+1YHPUGAT4tmlsCWWQPeRX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtjazJLOVBvdExPOTR4a2pBdURUVk1WODBXdWpLQTZDZHN5QUpTNC9MRVZQ?=
 =?utf-8?B?MmI4RzZqOE9hNnkzZUwvSVg3QU5vMm8xMXlEWTliUTl3TnkzUWtudFF4a1JI?=
 =?utf-8?B?dExhVWtrYjRCSGxmYzFaSVNER01EdTBmeWptNWwvck4weEwvZUtWaGVKbWho?=
 =?utf-8?B?TWRxVnN4TndqUDFkWWpvY215ZEhybHRQSXdwSjBJcWJYMVN6YlQ3cjMybVZq?=
 =?utf-8?B?TmpiWWYyVXJnSmUvajkrQzhIb2R0NFVNajJldWdqeWtIUVdrd2d0MDZ5YTVo?=
 =?utf-8?B?ZXR3MGFtRDl0RDRPdUwyak1tbENxL2ZMUnpaT3phYTM5eVlPem1HMHcycVZI?=
 =?utf-8?B?VXMySXdxNVI0SkZRVUVFcTJ2MENPckJFSkRhb002WHZpNldLQmR6TVZSRlBz?=
 =?utf-8?B?dlViZ2ptNlBWMG1sREZiZi9CVmFkM0JPakQzdnkzOEVIVS9MdlZvWVU5QnFR?=
 =?utf-8?B?bURpcjA4OU9FbmVBcFJGZUpjSlRJdDdSMEdQUkRBVnM0MFQ5QWhWTVhyWEh4?=
 =?utf-8?B?Zy9iMUxBTUNEMGV4RW1veGlON1I5RG5wUC9uMmhwdGNXZjlSQjhWVHB4NnBK?=
 =?utf-8?B?Lzd6RnhTSmdCSCtFUXNqbVRibWZPWjdkS29IZ2hsZkFqQjRNeDJ6SVpOSFc0?=
 =?utf-8?B?UGtKamlqRnZYb3B0ZEJFTWpGZnhsc3VmRi81ZjYwb1YyQW5JR0gyVDZxbnlQ?=
 =?utf-8?B?WGN0YXZ4UVRmRzdwL09PTlNDc3MyUEVYVXp2enB0S3BwanRKVE94VUNpWlp6?=
 =?utf-8?B?ZGJ0TDZSQ1IvYjJHd0NacyttRVNuY3F3ZEFKaElPYStTbUMyMFk4SEVUSURk?=
 =?utf-8?B?bVJNMkU3ZkNlbkxiM3YzNS84c0ZCWURTZ0Z3RldZWnRwRGpiZndjU3hIQVpi?=
 =?utf-8?B?bzQvMmlEV1d6OTRZVmIrYXp1ekRacjVmLzMzejlPMzRKNlJDL04wdW9XeVdN?=
 =?utf-8?B?bHNmU01TNkQ4dU1HSHk2MUNOc0xKRk1rVlllb1l0eDBmWjEreCt5dUliZlZa?=
 =?utf-8?B?UEZmRS80MnZzbHJaSlpmMDQ3aklSbm5hVW54d3o5OVZkZTZYcHlQeW5uR1Nj?=
 =?utf-8?B?VGVqUUhjUDNDTUNjbjFFMldNQUd2d3NJZk5MRi9XaURwRWM2aFNiTUpYZGoz?=
 =?utf-8?B?ZCtaSHBWOURaQTRIOE9LYzg4bk9nWGQ1MnJsS1JmSk5xcklLSXcrYms4RHVp?=
 =?utf-8?B?NEU5bXliQTJ3TkVXWHBnSDNPRXlDbGN2dEs0ZElaZTRtMjJFVklyVkVjbjJN?=
 =?utf-8?B?UXdzUmVFZXVKRnVxTE93TXRCYVhkNndkRlRBcEIrRWRxbS9sM1RyVmZYay9x?=
 =?utf-8?B?TUE2V2RnUDFWNytGWjRpSmxIWU93S2ZUeHQyakZ5VjZaM1Yvc1pJaFZTOXdZ?=
 =?utf-8?B?SHg2TjVZM2xhWDRlZVorOGpER2xkdHB6OUtMV05obWE2ejcwZVRneFRkU2tu?=
 =?utf-8?B?T3BGanh1d040K2NreVFDSGprMVVKbzRjaGk1WEFOWnN6djBlYnBYLzFxSS9P?=
 =?utf-8?B?VDJOZVppTVQrdFBjZmVKNExhd2JzMk1HVUpEOG81Mk44ZEhxT2o1S3h3Z0Za?=
 =?utf-8?B?TStxUTRQdHE3ZU5zc0hGZ09uNU0vdUN5Y3lDa2FQd1k0LzRuMlc3UmZtYmNx?=
 =?utf-8?B?ejB4RWVBeGQ5OTBqdWlBbFdkWVk1VVZnVDdXR0pmSDRuSWs4azVNWWU1YzRX?=
 =?utf-8?B?RUs0aStic2I4cDRocTdVbnJhMmNFL1ZGSkM4Y3dkaU5sZzlzaEZyakR3Q1Fk?=
 =?utf-8?B?bHBRSkkrZUJRM2tSQTFtOE9JSWNzTUk5dHQ3N3pLZ3p5c21RdCthZ1RKZ0NM?=
 =?utf-8?B?K2ZvM2hLdmFUUEQxdHVyN0xXNWpITGtzRFJuOTVaaHVHN0lMOHFvbWxkVFkv?=
 =?utf-8?B?THlJOWtsQzdXWjJxdEMzSUZQazdQTmJjVEQxRXlDcFhXZmFGSDdLUlNGYzFx?=
 =?utf-8?B?T0o5UnREN0Y5VTQ4V3Q1MWsxOTFiQ3hnZ2NhMml0YkowY3JicmtjeHZwYlJT?=
 =?utf-8?B?cS9GdzJHekJkSkNIZCt0eDQyREFDZUt3Vlh1ekhnVDEvejY4QVp4d29WZDlq?=
 =?utf-8?B?WkhYV3JwWFJmNlp0YWdMUkJ5TE9vclYyOUN1QU1QZlljbmZBNjhoS0M4MnZl?=
 =?utf-8?Q?LpEBRKb1PViy/BQTPZXvMbsxh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cd0a8b-9f03-445e-39df-08de17bc2957
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:56:45.0037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WRyyDQ3zU2PsI9Aq3CZ8ka5sxYcdGRjbDA8VkUQkGEwoJxCgZfd548axGUIYJUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

On 10/30/25 14:47, Timur Kristóf wrote:
> On Thu, 2025-10-30 at 12:12 +0100, Christian König wrote:
>> On 10/29/25 23:48, Timur Kristóf wrote:
>>>>> +	ASSERT(adev->vce.vcpu_bo);
>>>>
>>>> Please drop that.
>>>
>>> Sure, but can you say why?
>>
>> ASSERT either uses BUG_ON() or WARN_ON().
>>
>> BUG_ON() will crash the kernel immediately and WARN_ON will warn,
>> continue and then crash.
>>
>> The justification for a BUG_ON() is to prevent further data
>> corruption and that is not the case here.
> 
> Thanks for explaining that. Technically the vcpu_bo should never be
> NULL, so I think I'll just go with your original suggestion and remove
> the assertion.
> 
>>
>> What you can do is to use something like "if (WARN_ON(...)) return -
>> EINVAL;".
>>
>>>>
>>>>> +
>>>>> +	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
>>>>> +	if (r) {
>>>>> +		dev_err(adev->dev, "%s (%d) failed to reserve
>>>>> VCE
>>>>> bo\n", __func__, r);
>>>>> +		return r;
>>>>> +	}
>>>>> +
>>>>> +	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, (void
>>>>> **)&cpu_addr);
>>>>> +	if (r) {
>>>>> +		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>>>> +		dev_err(adev->dev, "%s (%d) VCE map failed\n",
>>>>> __func__, r);
>>>>> +		return r;
>>>>> +	}
>>>>
>>>> That part is actually pretty pointless the cpu addr is already
>>>> available as adev->vce.cpu_addr.
>>>
>>> I don't think so. amdgpu_vce_resume actually unmaps and unreserves
>>> the
>>> VCE BO, so I think we need to map and reserve it again if we want
>>> to
>>> access it again. Am I misunderstanding something?
>>
>> Yeah, I see. But that is a totally pointless leftover from radeon as
>> well which we should probably be removed.
>>
>> The VCE BO needs to stay at the same location before and after resume
>> since the FW code is not relocateable once started.
>>
>> So we need to keep it pinned all the time and so can keep it CPU
>> mapped all the time as well.
> 
> Right, that makes a lot of sense. I can do it, but I'd like to be
> careful about it because it sounds like this would affect all VCE
> versions and not just VCE1.
> 
> Do you prefer that I add a patch to this series to deal with that, or
> would it be better to do that after this series lands?

Add a patch early into the series to clean that up.

It should be a pretty straight forward change and I can throw it into our CI system which should have plenty of HW still using VCE (Polaris/Vega/MI*).

Thanks,
Christian.

> 
> Thanks & best regards,
> Timur
> 

