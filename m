Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71F3C982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 11:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0536B10E88E;
	Fri, 18 Sep 2026 11:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJMr990Z";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C111010E88E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 11:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nn7Js55OM8aaYHW51G95fIIihIRGXNHHKjitiu9T7KuhKwU8bKfplks+UKI1L1qxODc7PI+XH+jNdj61lITv1Yg30X9+8GyXrAXMEV6FERJDXyOvS9McluifmMNYBjuYm4URTfrOlHuYugGjQSwbls1eL41akuczIO0V4b0uYqqZhLwgDXEo165tE7jOvKZtefXwdehTCLbjtz7JvsH1z0buPGtmshd2vrk9MQCObOyVkZnhBkYloYuxqG8xoJ3EYaS/8kQzEGhNzUc1nCPur7GfjC5jVzlF9b2Hiiv9CcR181KNTacCmq6sDDy3QBdHw/VLkYtb2cLE5hDuP3GxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4VArP2yC5VpecNjZRM8fsFhn8iZUqerDl2/ndI27RU=;
 b=UR3H1rjz7Y46ELI7y1sr+ZvD8fTnRrFOFy+EwCWpeNTHxV5wiZdRz+sho6QIAwcBesfsHIJDggcgUTMG079GS+N5o1sJAuypX+65GGSFDo/ak3YMpAHaTKhcjI8C2kkt8DkbK3HFem00dEK4MSie2wRGXVyd+ISzebAmwFC7X4HXZJ5hJyuPQD2P2bgMsCquiqpWHg4KRJFSGvcvLDP97dPpaOIdIk6I7H6LIGfO4pQcptdkuau2KW+SQKuh5IGZQtm/F0GfPYAqLexf8/Fou2vYW66qSckhklDINB9DlUp59mDQRBGaANK2qmt4yw7pmUlxnIO1Y1an4GoqXPtmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4VArP2yC5VpecNjZRM8fsFhn8iZUqerDl2/ndI27RU=;
 b=MJMr990Z0l+MNFi4c6D1UH347iZZZ5ncBg1O39HKrC6gy1r9W2NNSb6+ciSVy+4oy07rVbD9osOyXu7YSxHqh9/vwCGeETxOQqm2qGWraNhxydupkPLC8zLv1CYXM6xYV5x1mOTDT7UcDSofCEeMCUv4vHK+K7buHDMNCjV6P58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:57:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 11:57:30 +0000
Message-ID: <5e1d6abb-3e12-4d3d-b4f4-0659eba79be9@amd.com>
Date: Fri, 18 Sep 2026 13:57:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Add second-level trap handler
 infrastructure
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Samuel Pitoiset <hakzsam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-2-srinivasan.shanmugam@amd.com>
 <f7edaea8-f172-4573-952f-6a85d1302d8f@amd.com>
 <e25c9ad5-a211-44d5-9b71-9e403dfb7426@amd.com>
 <2bff4151-c6c5-493d-9ad7-c7d886cc7dc8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2bff4151-c6c5-493d-9ad7-c7d886cc7dc8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e09e40a-ffd5-404f-8a05-08df157c0469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7xT3rhozNjAg0b6hb9xaLNoZgBPdAXw9uH/BKFhZ5y9TIiTw4VlSElV7mAKwtudi8P38WKRbSHzQCVddes9ksCwxFxkNCiUWVimrql4BxgqecuezQy77J3JYitbRloQJOSWJexbu8F3WP0JjqLPF5PavTpjgaxHk9s6EwAr+02z6xNlwDzTX9HaI5r0VZo81u1qUjMTEMKvdl/cHjjgo8J2TvDmAqsT9wgKTyfqXTckFPWhb031hmh4KqCuBvrpgoMmkP14Ylb6SEeNnmD7AUE/YtZpgymucb59ClyxJwHdBK6LT3ywvB2lqR7K0It2NiLrmUSE2xf2Pp4VGlGMjXGNVD5S2DkJmAAOEzwKBu+U5hct/byelMrMQkFKAC1xIOFgCQmdmW+ZGMde0OW8LP0OL9UdGWfVIz6ZDfkG4cOqreb8TfqMcSkrNh7a711LnoPCyIfF0S9SNBR11Z4vDWw6AD6Qb8zJ5HP2HExkIkLyw2whWj+7YfIfz+DIgfLGsYobdzg+ykEcDTu4UvQSV6eekuAJ9VWhqmRMUXGcOWPLGqFGe98N6BWodgVtTvhSw4asTpB86DWlLM0NtwBH8Erqxao5rQiiS8fAtRZ6THrIZdSPXzp3SqizfSn7gzVso3rljjWaHYjy187F7VHopOPLfkhDgjyKm2g0k8vT9yCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clA2MXVscGZxODlDRUVCUys1WDdGclNHZ2xoZVpXTCtJZDdUcVVDTU1tVGE3?=
 =?utf-8?B?R3NrYlZpUFAvVTE3bzh6NGQ4UjUzeTdINFNJNmhXNmRnZStWM1RXQW90Tkp6?=
 =?utf-8?B?OTBVUmhqVlhNcHZ2eUxRTEZtSm1qUFhSOG83TjBKNDQzMXhnUitjakVMOGcr?=
 =?utf-8?B?SHMzOElFUk04QXIvSDhQa0hqak9GamZsbGVleHRqZW5NamZkNmE0VnhoOTBW?=
 =?utf-8?B?eEswMFQ3eE9FTC93NHViMlF3cDdjeG9acThXeVQ2MlBIZUlGdTBha1kvT01C?=
 =?utf-8?B?MjJOVzlHS3llWHhLQnVDeWdoZ0R5RXhkejJGR1JUUUM5T1ZFUW5oZEk4bnYr?=
 =?utf-8?B?aFJjNllocWMvZGxrZEZFQTJrb2J2dWd5S1VkWHQ0ZFBDRSt4eEtpVHcyd3R1?=
 =?utf-8?B?UkMzVmRIWXV6d1dhZUFIM09SL3lZNW40YWV2OHYweTJHMUs0dys3U2hualhM?=
 =?utf-8?B?V25tUGgxK0dQVGdxWVJ1Z1FWUEhRdldmSlFxNktqbDQvdmIzdjZhZS9WcHoz?=
 =?utf-8?B?V1BNbUI4bTZBNWk0S3RXZ2ppRWxEWWF4VC9ZK3AzWkpDc2dPbWd3UXJEQ0ps?=
 =?utf-8?B?UllyUEhFNW1BaTRFMWRJL09oNVBtOXNyanJFT1JRZk5Qd3BzZ3Q0S3h3c2Nj?=
 =?utf-8?B?YVQ5ekEzYkY1U3ZUeUprYTJBQXJQbllHNFF4ZWJ6dWxzMk5NdUpzM0s0ZWk5?=
 =?utf-8?B?cHpjTmJ1N0h2c3Y5MFBqdVdrcEN4dVNEMWc3WmUvTlcvbXdSSVlLTldTaFJr?=
 =?utf-8?B?WnNEK21sQk9FRithbmUyTmhGNE1MWEZiS0tveGFLaDlVS1VyQ09xRExRNnhi?=
 =?utf-8?B?K0EzclJJc3Fub0NqS0FISVdzNFE4amNsQXFhbGxDWUFDa01Fc2lIcUkxUytN?=
 =?utf-8?B?RFo0RXIxamdYUDVkWGE1Qy9DUkUwMk94YWVaUWpBZUh0T0tMMVQ3K2RDMUJY?=
 =?utf-8?B?Q2M3UkN0WWl1cGJEZS9VUVl1UEh6OGhLTzdaNzdpOTFsd1B3bE9NRUsyaGlk?=
 =?utf-8?B?L1RiczRMc1ZuNnFtRWs0TTNZVnl6RGFILytnUDhIUmNYNmdTZGhrdERrNVBz?=
 =?utf-8?B?WE1OenI4ZGdkMzVMWjdhTVBVNmd3SWQxU1BTRW9BS29uWFl1Y1FpQTdTdHEy?=
 =?utf-8?B?bUhRWDhsV2tSTGpYRDRoUlJUMjE5ZXRlVG4xcktvdHJ3RituRy9XcHIrWUlF?=
 =?utf-8?B?WmFnNFovNFYxcGJRL3ZUVU5wYlY2Um9ST09idUVmRGJsa3hIaHZtb3NqYmsx?=
 =?utf-8?B?VkhJNDZNaGxrUTQxTWszQWVRTzIrc2pISHIyUlIwM003MGdLMU8vQnlTTzVu?=
 =?utf-8?B?WTJZOU5HSEI0MHB0dm5teDg1WHRRUzdON1lxNDJrK21pbnlLbmc3a1JkYVky?=
 =?utf-8?B?d0VVMThNWEFwTklYQ2Y5R3NxbXdDYmV0bWpCRndiQ3UxOVhVekQxOTA4bmlO?=
 =?utf-8?B?R3BGekNicml0T25RQ2NHNEtZc3JFaGVsRFFwMnpkUzROMjliRUJXaGMvNG9P?=
 =?utf-8?B?NjZGam5lcXFwNlp3TEtNMm92VDB0NjVMc0lyQkR1aVAwSC9KVHQ5L1ZvRGZE?=
 =?utf-8?B?WldJb3JHZS93c2V0amRhTHNPT2xvanhRbkxva1MySjk3QkdaRG9ENTJXUER6?=
 =?utf-8?B?ZUFWN0VKeVVaRmRCSlorU1JEL21HZnhNK3N2RlA0M1B0RGlTRDNtS0RNQ204?=
 =?utf-8?B?QmFxUnh0YXZrV1pWY084UE5xQll3STRuRHlNR2VEQzkrM2EweGhBc2Q4a1cr?=
 =?utf-8?B?TDBDdC9jOTMwWTRYR1BDbGMyNkxwdE5WUzYwWmZvZWFrTDZ1cGhlSGgzQnRn?=
 =?utf-8?B?bHFaNm1QR2tqRmNWeXIyNFN3Q3d6a2FMU2hvYW9IWkVrY0MrQnBVQ1dxM1RK?=
 =?utf-8?B?WWRaeTQvRFdFRldQKzhiclpXMzR1bzNqWTM0dWxSZWVZYTdONDJUT3hOSHBE?=
 =?utf-8?B?bmZSejNuRHdYd0xPam54WFpXbGliZUliYjljT20vcmliU081RS90SWRaZ2V3?=
 =?utf-8?B?UHlWemxHWm56UlJXNXhxUTlvZy9zMitpem1qeElPNVdoSU9vS2dhekFuS3RO?=
 =?utf-8?B?SDNUdlhSSjQ4djRTK1oxV2N1MHBua21YeForZFJIYjVlaGh1eEZGYmdkOUdx?=
 =?utf-8?B?WEdpeko5UGkybDhaTms4Um5kV1VSRFBzUis2WlVrN3I4Y05Scm9sR0JqR1Jy?=
 =?utf-8?B?VnVxS3Q1TjVaN0tVNHJ4YWpqYmlDWStYdjFKQ3ZnS0JCcGMwQ2w0dzNtdnJE?=
 =?utf-8?B?NWNacFpuU2xIR1dHL1VvcXlkZi95cFhSNWJjSzlDYnR5WkRoUWhSVXg4MXZM?=
 =?utf-8?Q?jFsASmyZWcvfAlkq0s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e09e40a-ffd5-404f-8a05-08df157c0469
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:57:30.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr+P/AY+LXe1EqWUH7V4bTiIhUWLZQHdwEg+G+bJAX0+rPEV1F5k8sme3O6zh/Gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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

On 9/18/26 06:09, SRINIVASAN SHANMUGAM wrote:
...
>>>> +	/*
>>>> +	 * Build an iosys_map for the TMA CPU mapping. On dGPUs the TMA BO
>>>> +	 * may be placed in VRAM and accessed via MMIO (PCI BAR). Check
>>>> +	 * TTM_BO_MAP_IOMEM_MASK to select the correct write accessor.
>>>> +	 */
>>>> +	if (cwsr->tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>> +		iosys_map_set_vaddr_iomem(&cwsr->tma_map,
>>>> +					  (void __iomem *)cpu_addr);
>>>> +	else
>>>> +		iosys_map_set_vaddr(&cwsr->tma_map, cpu_addr);
>>>> +
>>> Clear NAK to that hack. Please use ttm_bo_vmap() instead if you need an iosys_map.
>>
>> Hi Christian,
>>
>> Thanks. One clarification regarding using |ttm_bo_vmap()| here.
>>
>> The per-VM TMA BO is unpinned and can be moved/evicted. Currently |amdgpu_bo_move_notify()| calls |amdgpu_bo_kunmap()|, so the existing |amdgpu_bo_kmap()| mapping is dropped before a move.
>>
>> If we replace it with |ttm_bo_vmap()| and keep the returned |iosys_map| in the trap object, should we also handle unmapping/remapping it across BO moves, or would you prefer mapping it only around the TMA accesses?
>>
> Since the per-VM TMA BO is unpinned and movable, keeping the |ttm_bo_vmap()| mapping in the trap object would require us to invalidate/remap it whenever the BO moves.
> 
> To avoid maintaining a long-lived mapping for an evictable BO, I'm thinking of using |ttm_bo_vmap()| only around the TMA CPU accesses while the BO is reserved, and calling |ttm_bo_vunmap()| before releasing the reservation.
> 
> This should also avoid leaving a stale |iosys_map| after BO migration.
> 
> Does that sound like the preferred approach?

Good question, I think we should just temporary map the trap handler to patch in the addresses.

That happens most likely only once during application startup, so it isn't time critical or anything.

Regards,
Christian.

> 
> Thanks,
> Srini
> 
> 

