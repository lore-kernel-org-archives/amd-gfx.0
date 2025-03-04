Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D741C282D0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 10:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C5A10E585;
	Tue,  4 Mar 2025 10:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gnis3bqy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB36810E585
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 10:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohjICgIb/O/a3k+vWp/yEZzcgVwNzTpiPlUMKpH8/Gmo+jdFKh6H55m7iMpf+jIq9xguFVh6NEO2BPLLLuZxnZ1dml+7ZvowVF7ZrOfBkinQam70jQrnfB+T3vgYwONphsbwRphKpuI7a0nIrhnX7o84Xai6zfxG1Rn6U7KKcpbLrYxzB/v6I6pzDs5PGVAWkXXV13LsGd0qJLeNf4IVKzIK30xyzj+GR1ePSYTDFMSkVr2dr+BrGG/CBU1sJQn9CS7wNYVTWQXohZLQo5DaLPIXSRFw3aWQAcrkP6SIJlXwmHDPj8feZkM+hpRPHRuZKA0OCxnewebOUhL62wGx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwri/Mf1JYPqoYaDZADY+JJgHTa58YA7YVaI3iC0qTU=;
 b=BIdQeMnz+R89g5nEUq//4BDbzTxuHJJebE4nJhAiJPWs2G0bBjHlgty2bWibwWdgVIwFkE8LKiouy8K5VP74xlo06D1i4CLLW63Woa6pc7sSwrFwwaaPjDD4dM08di8FlEOwI3HeSB37S96H2znzV6KhhNfcf5gdsynTxv3nQ9uojcwmbAIoluwjVMO6waYe2JFOg7++NnCYR4KNM2bL6UfYz6yN6o6GFwGP9ejYlh7sFO6SWYEWr9+BpOZBZJ5+em6AwnThBoN+Y5dQDfdzDXVFMVhAH5QJo04G+g7dCXE2w5+tMmDBbvPcGT0pv4mik31LL9Zge1VH00zCZyyU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwri/Mf1JYPqoYaDZADY+JJgHTa58YA7YVaI3iC0qTU=;
 b=Gnis3bqy80wRNU/sRPuOTmyd8lSeU/eXgC2BztpcD5SlQvwWj5P6AoJVwHYqJ5KvTVgMQqDvTg4f85XIrJ0h8OzNU9+rgHzgCjmWYFl48OiC5mampE50Zmu90VuRgZXGwYC2cyrvi77ObQU+MmlEvRQSZ9epZhKukB2JBAHusog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 10:38:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:38:24 +0000
Message-ID: <f295a68b-c1b0-4109-9369-71d9b80a6e44@amd.com>
Date: Tue, 4 Mar 2025 11:38:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove unnecessary cpu domain validation
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
Cc: jamesz@amd.com
References: <20250303184508.2277310-1-James.Zhu@amd.com>
 <71929ed1-6c22-47dc-9f9a-a4bc15b21629@amd.com>
 <f487c2da-fa5f-4186-a556-005617d603b5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f487c2da-fa5f-4186-a556-005617d603b5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 970e0a17-7f45-4195-bf99-08dd5b08b0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVo5VDFBSlN2dnlMb3FHTGFVd3lDQkh0bTZvY1FKVVhQRjVpVzVMQlBJaVBr?=
 =?utf-8?B?bFBkY1NRVnJoZXBVRGRab1dDNitqTUVFYmNwUTlZZzc1WVBxbVRPMTN0bk5k?=
 =?utf-8?B?azhRUW05bHdpSUZ0VDNBc3JFQS9ZSDA0TjhUWWx2TGRDK1J0ZEZmNE9KVnhT?=
 =?utf-8?B?U1Nxai9PMUdLaWQwZHZhT01zMUxCdXA1TkdsckswNis4YzhHYnl5VlhjVlBl?=
 =?utf-8?B?SS9yQS9GTHlva3VMUDZkQUF6U09vMHM2MytLanBpQUlycnR5WmpDVENGeUxG?=
 =?utf-8?B?MXIya29naVFPRHpHNThBQUs4Znoxbkh6WHBPSExGRFcxdTBYZUFoWUFCYzc1?=
 =?utf-8?B?V0pGT0E1V1FxWnNaeVZFaGdrdzVKVGROY1dIM1p4K3g4SWFjKzgwS3Q5Ykw0?=
 =?utf-8?B?bkxRdG5Vd1duV0l0V2pORG9aVkZ1aXlwV3RXaUwyRVkxZDBCMmVPeDZ4MGFr?=
 =?utf-8?B?NTJnT0NxS3l5Mk9OcVZKS3dIbFN5RzExNFFJVDNKeUpjWGpVTFRVZEtuZWZ6?=
 =?utf-8?B?cUVFajg4UmZtY2xTSU9nemdwNExkb0RVTE9FcytlUzhyODFCSEtRUVNOakVH?=
 =?utf-8?B?UFBzL1ZMQi9jdTVacXc5YnVYWEFwbEF4Ym81ODRWaWs3RWM2VUNLU1R3MkZF?=
 =?utf-8?B?bFhpdHJUcm0vMlRpSHd4LzFNeGN2aFZPK0p6bGVqcFYvb0xjbjhaQmpGaVZa?=
 =?utf-8?B?bFh0MTdwQ3ZDM1ZhajFNQ0M3MERKZnlpN1A3TzZMYnBBdkRncFBhZ0Z5UnNx?=
 =?utf-8?B?VTd6V3V4akMwRHBDUnN5bWdhSFRsbFk0Q05sRG9CMmQ2UVZud0F1TEw3WDNY?=
 =?utf-8?B?T2ROWVpwTDYwWnVjVW44L3puRE9NdGFEOElOQmx2TGZNZlF2UG0yZXlHQm9s?=
 =?utf-8?B?UE55bkxWazA1N3FTUlFpSlkvUEE5NjZUK2duOHgrMlpGQ1d0cXg5RkI2aDJV?=
 =?utf-8?B?VTNER0Z2Tk4yd1dBVlk3V3BaZ0N5QS8ybE11bzc5VTVBdFNMamZqaXlIWElE?=
 =?utf-8?B?RXVuSmtIUW1WeVZGVUx0TkRHc3N6TG14OFM5Y0pMb1VQUXVVM25MRUJxNHd6?=
 =?utf-8?B?b2I1S3VlWEVFQ09meG11ZFBSWmp3YytXZVVuZFZZRUZWZzV4V2oyazFTZzFy?=
 =?utf-8?B?UHIxWHRMUFhJVWF6SFNIczA1b2puaWo1Q0hqbU5TV3hlNThFa0FhQTNELzh1?=
 =?utf-8?B?S3JpTytIaTNBUkNVTDZUYWtnWGtBRnpQclppRFVRbURxNEUySDhoUnFmV1Mw?=
 =?utf-8?B?aERDUmdKL3psWGorMUl0QWQ0T0dHVTVIa042Skx4bGNCVjlodGtKQWpDSUJS?=
 =?utf-8?B?L1JWYVZhUVdwd3BtWHN3eXJ3SFJGMUNpLzNvYkVUR3lmczk3LzVOTFVqWnFn?=
 =?utf-8?B?S1hJc3hPQUVITFRMekozNjhQWm9wNWw2QjFXR2xaRGM5b1ZWWHVNUGxiK3Bm?=
 =?utf-8?B?RUxyTGNzMiszVFBFaGRDMXhaVmFCamxiZ3Z0eWsyWUdMemRETWhpbkFwMCtH?=
 =?utf-8?B?VFBrSlRMa2RhWEp0ZzZZc2ZPSDl2VnRSSnI2SmZCMTh1OUNjb3dqZDVhcm9S?=
 =?utf-8?B?bE1MeElhTVNNczNOdUtLSktVSml4UmtuL0U0cy9GS2pzTHpDdmFCOWc3UTR1?=
 =?utf-8?B?azhNVjhUTzhIRFo5bjVnNThUdU13YmpCRlJnQXM0bjJYWTBiRGN0cGFoU01u?=
 =?utf-8?B?TE9wdTFIZ21sTW11M3pYdHEzdUxkL2EydStKM3UzUkpwNFNvQXBFclUyOWZ0?=
 =?utf-8?B?Zm5MVEZuVUFaSW5qTkwyeFFKbjkvYjBscWRtN01BUCtuUVRZQXkzVlU3S29M?=
 =?utf-8?B?YkJoK3BzcjhaV3hRK1FrMGwwTTlHN04yaFpLVVd0VjlNRkE2OWQ4TXZEMEpp?=
 =?utf-8?Q?KblPVwp+M+ijT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJ4QlJ0NWpWZCtIMGVpZGZxbld5Y2VXNTNKdG5WNFBIeFJ0YWw3WDBBc1U2?=
 =?utf-8?B?V2lQVTlaQ1ZBYTAyRUZuMmNPUWE3TGFPaDE4WmNQcUZaTDRrTnAzOVZjMDdH?=
 =?utf-8?B?OU1YSmp0TzVKZUFDU0c5V04rWldZUnRxNEZWWUxTNE1IV0kxSE0vVE53OTFJ?=
 =?utf-8?B?Y0pFVHlKSXZuRTlJTEo2MlQxOEdRNTQrL2JLUGhIMWdNMWIvQjlUUU0rakh4?=
 =?utf-8?B?WUVIcDNzUVVnbi8rN1lYdlMrRWhENWUwblAyVzdZemNwazkyTGJCVlV2c3Zr?=
 =?utf-8?B?dVdxQzVyYjg2QXF6b3BteTlzSkZjL0NyZXA4ekJ0RCtESjUyMXAzRWIwSzMz?=
 =?utf-8?B?UUxwOVVJRWVOanNrcDFob2RFc2FyS0dERkszYk1tYjhCWlpYbUNEdlFkOXBt?=
 =?utf-8?B?b0wxMXRvcmdlOUZ3KzlRQlhENmE2UE5DUFpDSzhxUGxxY0dYa0JScHBlUWlz?=
 =?utf-8?B?ZmowQUtlbGFEUGZYMmdMMkloemdsaGU1ZkdraXAyeWlySlFIODRtRXMxZUlK?=
 =?utf-8?B?azlzdXdtQ2w1TnFOS3A4WnJscGFRckxkT2lYeUFsdWdQbGVCZFU3bXJkUmNn?=
 =?utf-8?B?dGRqU052d2xmaURDaHAzQVp4RWl0aXVVa0J4Zzh1cXRxSEp4dUo5RHNVSEtW?=
 =?utf-8?B?UU03Lys0YUFJS1RqWEwvaDJKR0lNV2ZPYXdXSy92UzFLVkwxbUJtL3dlMFk3?=
 =?utf-8?B?V1VFUnZnUTdmRm9ZSGNibjVOWmg0SXZieHN5Yk5neSs5S0ZXY0g2TisvYXhX?=
 =?utf-8?B?dkRCNzJLK2cwYk5pUmhOVmNzQmx1U2s3MVgvNzdIV3JTV1U0OHRldDFNNStv?=
 =?utf-8?B?azhPbDRMY0tEM0Q4RVBzcjlYL0QyY242RGU2eFZabVhBcUNmdXlsZitWRkpM?=
 =?utf-8?B?dkNTV3Z5Z0ptVW9DQmRBT2hkS1p6T3prNzFROEdqRFZvRUhWeitWYTRlQ213?=
 =?utf-8?B?Tkp0emxLNmE2bFByN3MvQkx4UVljRy9LZVUxWi82T2YzUk4wMGc2b1M5c2tR?=
 =?utf-8?B?MEMyWTNiaUhpZU5UTWtJcmFUY0NwcGxsdkV4MTU2TDFFQ3l0RWlqcVo2T1Yx?=
 =?utf-8?B?YUNXa3FjZnVBSzFOVmVib2dFWFlqd2FyUEVmV25jYUFTNC9kQjRNUFJMZUtG?=
 =?utf-8?B?c1A5SG85T1A2dC9YdG82cngxcXhMZ3UySmNvMFkrTDhpaU9BWDdsS05DUTNi?=
 =?utf-8?B?RndudFByNW9GK1RNRTZEZXBsRTYwb0xXdVBZcjFzU21CdkJvMnljeEhUZUh3?=
 =?utf-8?B?b3RtWE40L2tHdWVrbUUxdDVxMzh0bGJUNFhERTdIbThTOHUvT05JZmdCZCtp?=
 =?utf-8?B?KzdFbjdNMC9Dc2htY0hMYlN4WHkyQjdHSFZPajhPOWxXNkxlSGlkcks4SEFV?=
 =?utf-8?B?VTN4QVVyNk9ObEcyUTYydS9jaU8rRk9ySGF3UDBJeFNTS2lNbDVONFMwLzlk?=
 =?utf-8?B?ai9sRHJtdXFnWFFTd0J2U3VINFAvd3VLQmpSeE8xK2cwaXczNDhsSWV6OHZE?=
 =?utf-8?B?RUg1aVRieDI4WjU2eldEMGUreWNkMFl4eGVxT0JDcFZtUGF2RHFwbERsaS9i?=
 =?utf-8?B?SmVuc0p6bnkrWW82TDlsdVdVY1RYaThyeGxFK0J6Y1NaczlORkRpN0daZGE1?=
 =?utf-8?B?UXRjZDN6QWR4M1FkTG5aMWVNVnpYRUtGUFJZVmtRWmhEd2RRcS9WNE1lWExY?=
 =?utf-8?B?ZjcyU1hXVmh0SUlqWUNFWmxkRXIybXNlTGg4M0I5YlpMcXBIUVJDNGNuZzFN?=
 =?utf-8?B?T2xQdms5SGR2Y2cxaklUWVh6MHBiTnJma1prWkVEc212dW1kZ3dzc0E1VEo4?=
 =?utf-8?B?Q05vbW4xbFBCUG1zajA1TU0vMEllV3dPaHFNQyt0cjBsWGNrYXJCbVlUamVF?=
 =?utf-8?B?bWo0c0JiS2RtNjNjbk1MNG1DMExlWVNPcHd3S0VFQUg4YUlKQ1VsOUdWb2RD?=
 =?utf-8?B?WHNUd2M5cWIzQkxtMGJkZjY1cGVhZEUyeEFRYzRWNjZsNXgyL3lkdEhQV25D?=
 =?utf-8?B?YlhHWHpIS1kzMnpFaTEybjN2Z281ZlZlcXhxWlVNYWt2dHB4UXZTUjNBQzl2?=
 =?utf-8?B?TVd3UGo4a1hJVlUwYjMwQmxPZktwczc4WEFFSHJ5WmN5Nk9hL0ZhdGE4a0J0?=
 =?utf-8?Q?pHq6LGr5UXE+69TDJ5iGqv0L7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970e0a17-7f45-4195-bf99-08dd5b08b0ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:38:24.5897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA4TlmZ17s5l8qzvL9h/eh/YUwHVk2tENOeLEdp0ktMOq8P9MQb7uME3ThoUuJW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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



Am 03.03.25 um 22:01 schrieb Felix Kuehling:
> On 2025-03-03 13:48, Christian König wrote:
>> Am 03.03.25 um 19:45 schrieb James Zhu:
>>> before move to GTT domain.
>> That might not be unnecessary. We sometimes intentionally move BOs to the CPU domain to invalidate all VM mappings.
> We discussed this in our VM sync meeting this morning, and I wasn't 100% sure either. In this case it's causing a nearly live-lock of mutual evictions when two processes share the same BO and have both their eviction fences on the shared reservation object.
>
> I was thinking the VM invalidation should be taken care of by the DMABuf move notifier, so this explicit invalidation seemed redundant. Is there a way we can test or otherwise verify that we're not missing anything?

We used this hack to validate into system domain and then GTT for userptrs, but I can't think of any reason to do this for DMA-buf imports.

Regards,
Christian.

>
> Thanks,
>   Felix
>
>
>> Christian.
>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>>>  1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 62ca12e94581..2ac6d4fa0601 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -595,12 +595,6 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>>>  {
>>>  	struct ttm_operation_ctx ctx = {.interruptible = true};
>>>  	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>> -	int ret;
>>> -
>>> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> -	if (ret)
>>> -		return ret;
>>>  
>>>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>  	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

