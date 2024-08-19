Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601D0C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCC110E2EA;
	Mon, 19 Aug 2024 19:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIsiGXA2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EE110E2EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrr5SmBGjYli3Gr82b58cA8Tg5cFg6OZbFY8vM34X9BEkBnYl+4Xe0qqyWFifyslE5eLr9KYTSdTjEZEvBztAbyF51FUE4E21cbBP8aJfu9P0ZgQ/Qja21kWfPOlONFOn5adESjSySwOujvbl+qnNmJ9S63nS8YqtLxvLJDWjBKCR2Rqtn7v84+yc7iZWoRgRB7zdZjG+4zY0EsJKl0bFNhsTdmJg+7S/Dv4FWIhVtNCu3I8+hxYx7LA5USRCqk0Q2C4tR0brs5MZdwiYDuX0XHbNhs40PGdJLCh86M5KvWlhKtuBQM5VaYIUQ0tVhgh1zF9rDbAGjYIqCCJ+0mOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PosfunlXIe9BSPl5eBsM2LrDyN5w/Z3l/84JXmKpcsM=;
 b=Br97yT6RqSTRGKp1OszC9ceBvnWCEXDO2QY/rG86N7p2puuJT5qJowVWLL6rQR+nbb93yM+FA199SdtGFKe1a8AlZSdS8rBHOLvTk1BJWQcgvbWp90oae61tZ4MWL+t4u/Gp0EBuqelnH4OSqTkOKNQlq0rTXQO4bWjR4KJXh9ljM+LJ/xWCpuYQl5PEJdsjQKJzBzvvx+miUymNtU7TPAzl3isemw7/Pbb7qSnVL6QIMlMsfnZ8f/vEy9WcBFwQj2luSV5TWITe3tEPCpAwVH8T1oymoEM9tejY1mK5SdleHNYB6LfAq69DNnbyTluXpKCf7hUB9B6ERKKsoP7M2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PosfunlXIe9BSPl5eBsM2LrDyN5w/Z3l/84JXmKpcsM=;
 b=bIsiGXA2udjLXRXEuRKUHwkc6deAeqoHwLnIfcebHZaYpa+js4JTfTGaCXcfURkuGQYigBHnohB3AeivBHHS40aHEpyUNzBAeyC18kMBG6AM40LNPdn/pXUtqM+S0/Np8pzTz3cCtO88B55olgJfsJ6DdbJ33nHTEJgLxYkYusw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:07:18 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:07:18 +0000
Message-ID: <69f071f8-6374-4404-87ef-e1e3d5edd748@amd.com>
Date: Mon, 19 Aug 2024 15:07:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amd: Introduce additional IPS debug flags
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hamza.mahfooz@amd.com, roman.li@amd.com,
 aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com, chiahsuan.chung@amd.com
References: <20240816225754.156098-1-sunpeng.li@amd.com>
 <d7564130-4f0f-49f4-954e-dbc108de0019@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <d7564130-4f0f-49f4-954e-dbc108de0019@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::6) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e70de7-63d9-4eaf-472a-08dcc08224ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RtYTVnWEJtUUFGNFZKRWg2OVF4ZWV1ZFY2ZGNocWx0aisyazVqMDNMcUdy?=
 =?utf-8?B?bFZUTUoyZzFLd3E0dHEvUFVtZy9sNTludW1wYzFIY0dGWERYZDEwRCtRenFL?=
 =?utf-8?B?U0Q3SFZqWkVKTytUTVkyVWM5ZkxwZmtsbGRjYXltZWdIQlRHd0xIYS9Fank2?=
 =?utf-8?B?UEo1bk14Qmk5VGF6QkdhcWxTRGZtWjRLdnRQQXNmR3MwdURVRHI5ZldveDIw?=
 =?utf-8?B?eTZRWlVRVlQzc09DYVZoZFo0NDRhaHRlbnIwRXRvN3pOTDNodGZORHNNbEsz?=
 =?utf-8?B?cmZobFUyU0pyNGdsd3owOFA0OWF0Tmpab3hVZHUvNklUWTJGYVVOSU80cjVB?=
 =?utf-8?B?OFh0bkFRczJQUElHU09UREs2TFRibXBrSnRJeGNBcU9ad3hpeTVWWE1SQU0y?=
 =?utf-8?B?azhSenMwcjlTN09HSnBySVpCcEpPVHlHZzRmVTVFbXVnaVZOcGtNK1dSSG4w?=
 =?utf-8?B?TVJLTzdSTktRWkpGMVhIU2FPVDFLM3hBSE4wa2ZFeDEvNkRab0g3QlkwYlZ5?=
 =?utf-8?B?SEtqV0pHVWlORFRwc1dNbFo3UVJDTDk1Z0xOUFM0c3VMUURHZWpWbWRpbUNM?=
 =?utf-8?B?TEVnU1FMb2RkSFJuWWtEV0M2RG1DK21qdE9HL2pDekF3d3NBOVNmdXpnTzBw?=
 =?utf-8?B?SjFTbm9oVTUvZUV6SW9ZVHBnSnpOdmd1blBLQVJ1N0c0SllsUDZHU0hiN1lM?=
 =?utf-8?B?RWIrMmhaQmJEOVJSTC83THpKSEtlayt2b3ZObk1JV2MyMldGZ2N6bkVhMUJH?=
 =?utf-8?B?S0lTUnNqK2VtUjI4QnFOaDBLOVQ4djB5S1FkaWUyazJWQmo5UGdGdUl6dksr?=
 =?utf-8?B?SC81VldIRUJoWFFQbmpRRlBYTDRVa0RTckdwTGttVWo3cDEwTlYyVjF2STNT?=
 =?utf-8?B?WVY2NStBZ3lGRllQK3NMcDVudUttSEIwLy9oZnN5ZHp5dTNyeXRNWlVieHc1?=
 =?utf-8?B?NlZaRG8wT3lwdG9NdEJFeGFXbi9hVzJaM1grV1JScW0vckR1cEc3cnZraXNh?=
 =?utf-8?B?ek00NE53VU5KL25kd0R1cWgxYmJ4Zm9nVk9kc2pHYXhiTEQ4RFRaNFNleFg4?=
 =?utf-8?B?YmtBeVdQMTZmVjFGSTRhSDc1aVlTazhZdXRjR3dkYnRkcnJlMmZKUTJEaG1U?=
 =?utf-8?B?Y0ZxNlA3UGxXZ2kvbWFXcWNhSHF3Nm1PRC9YTXNVSjBhZEZwMHdPNkJ6WWor?=
 =?utf-8?B?cE9ZSWhrVzFDVjFhT1NQREN3QlNuZUZyMGJHVCtZYWEvK2g2VEpJSjRKWGxu?=
 =?utf-8?B?Yk1nT2h4MDJXZE5mT0ZvSzM2NWpnSVVOU3UwSDRZUVRLUVJyUFFlck81QlVP?=
 =?utf-8?B?eWw1OWlKRnNhaWc5VXNuQVdSSVE3eGkrNmM5NDc4RVFGZzBxcCtyMXNreHBm?=
 =?utf-8?B?SFFTeTA3YnVnTTBMSmpkRFhRZGlJQkRyak5lNU1rVU9lNjIraFprUktlYzlJ?=
 =?utf-8?B?d09oeEhDNTN3dVNtRTRMY0UyaVMrM3pFZ01KMytWU2t6Y1U4TGVyb3pYNWtI?=
 =?utf-8?B?TnplVjdlaG5lYVRSK29pOWNHUmY0NkRaempGbDkwSHp0MnJkaE9YdkxWNldu?=
 =?utf-8?B?cUJ6dzR4MFdENUc0ekJUZ2VRMTdkY2d4UStiQlhDTU40ZC81ZzN3TytvSy9x?=
 =?utf-8?B?dnZSeithSlhvQmlKYVJXWEtXNnIzTkVLTnczREJFNk9TQ3BpQnBFSjhwMWRq?=
 =?utf-8?B?UVBjeU83OG8rSU14cXE0VHdYWjUwTVhVbHR3S3RNY0E0MENjemRlUG1nNTNO?=
 =?utf-8?B?ZFhqVm9FNGh2SUllMEk1UTdGQU9SQ2c4SWpaZlJqVnU1YXJlSHFEKzh3Si83?=
 =?utf-8?B?S0lQVjBNTTVLQkJ2VlcvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXB2L3NtcW4rMUxTZkVXS3h4dlZ6QUhydlp1aXVPOFlxb0lWcVArYkxEc3k0?=
 =?utf-8?B?QXZORVU4NS9OU0ZHVHlVeE1VUXgzd3BBbCthNEVncXJxVEpqdXJ4M1ZVVUxv?=
 =?utf-8?B?Sk4vb0E4cGRFakYreUJPUHZoZ1RXekVQQmR6SWQrNUJkVTR0Y3ROR2hIWDkv?=
 =?utf-8?B?QmI3cHlPT1hSWVVlUTRLQS9sbHV1cWlJTVZSTU5uMFhGSFRXeFZJWHFmTHIw?=
 =?utf-8?B?TDNkWlQ5WUN4YXZ4aWZkallPRTRqZjVUR2dYQUpwRmdoTnFaeDVJNHJEK3dm?=
 =?utf-8?B?WkZMWkVncWNMRGtxQXIrUmtmME44T3ZYRDNRVU52ZzFZcGVQSm0zTURSUURj?=
 =?utf-8?B?aFJzYmp1M09vai9IWWJ0RmpHc251d3JSNGEvWnFlb280Sm5VWmMvaEVndXZZ?=
 =?utf-8?B?bmRSNTRCWTBreHRodGlqSEZwRzVSdS8ra3Q2b2IrSzNuRjF4MzRFaWprUTR5?=
 =?utf-8?B?NDhQSWNZUEYycUhXT21BQXQ0MGk2NjQrVFpXeHBRUDR5TUxDSC9nVW14SUVS?=
 =?utf-8?B?N3d2RDlPR2FyNWx1bWRaWDdnSFM1eDk2aVY2b29hRm95c2VtZU9FcXlGRHF5?=
 =?utf-8?B?anNWMGxVNkpVREtuWEw3YmRkR0cvL2JnZnRtQ0xrQWlLUGdmRzlaNVRtUHk1?=
 =?utf-8?B?ODRXM2FiKzBPWks3TTFmNDdwZjRtcVVyL2tONkpjV1BVek5CeWoybFYvVnIy?=
 =?utf-8?B?YmxuWGJ2TEhEOXIrWngwdlB0cEFiak02OXlaUEU1aHpjMVAwT3Jmdld5bXJy?=
 =?utf-8?B?NjNEQTBsalV5WGV5alU0cTJjQVo0eDVFM28rcG9rbkVQbmVyZmkwTlc1bVBt?=
 =?utf-8?B?YVZOZzVLRDZsOFdLUW5waUR0c2pPU2hvU2NUZmorVjY0WlhSeWZ4ZUt2UXhG?=
 =?utf-8?B?ZXpET0J6M240VXpGZ3ZKODFYT3JtQ29iUmpGOEJJN3RoQWR3c0dNemdzMnl4?=
 =?utf-8?B?R2Jkb1VkbE5xYzgrR3UxcFExTGNQaDFlRjZwQlQ4amRSRk1qVG1EZjRxdnYy?=
 =?utf-8?B?WEYvcUY4aWtsZjBlWUlBdjlES0pRWkJXM0l5eDVtMVdtTkl6WDJyWDFESTI2?=
 =?utf-8?B?c3FuZFBrZHJRbUJhZkg1ZXJMbFdJaUVGVXozdnhQWnFnMkRVNTJqSTAzWUsx?=
 =?utf-8?B?Q0ZLcTNMWlRkaC8zQmlGRjVlSHAxT0RPalp0V2cyK1MxWlo0U09nNzFyTE1W?=
 =?utf-8?B?YlFBWDhZZXgyQkFJcFNLSUUxUFVlZUdtOTZmcGtYY2FMeVR4aGZId29BVUFw?=
 =?utf-8?B?VUUxUmxtdVhaeHdaYVJyM2JZTithdUlUS3pjZUU4U1ZpbHdIVDRxeSs1TXc5?=
 =?utf-8?B?b2JDSUlDQitsR3VvZDRMTGlnOGgxckJNcE1tVEJ3d1VDZkt3Uy9EQ2x1SFVZ?=
 =?utf-8?B?azdRVE5KS2Rad2NBYzNqaVdRVTFtZjdlZ1ZYQkx0aHlBYnRrWndoaFM3c20y?=
 =?utf-8?B?MDcwZU13TnR3QmI2eVdYNUQ3cnJyYjlvVkxSRndsQ0dNWVEydDhxTFZNQm1s?=
 =?utf-8?B?QnVkSlF5bTNtdUM5VnFya2tmOG9vcklRMTM1YmtTUzVxdTl0VkVMN05idFBE?=
 =?utf-8?B?b0dLWG01L3JTZFBTdDJCc2pTK2dBNjIzMjdqbnNYdCtXU2cwWlNNNm5DZHlN?=
 =?utf-8?B?TmdNa2VnNlJPa3lQVXNXYnRBelFDTW9qbkJlSy9OcnFGODNjL2VubFRISWU5?=
 =?utf-8?B?NWdFcCs4MTMyeXpWNHFyaU0vRncxMnZnZjhsbHlZWG9WZTc5a2s2OTFXcXdW?=
 =?utf-8?B?NVdjdFNld1M2Z2xLOFZ2d2VrU3hlUTM5VmlTQmZvTWNmWHZhRG9qaFpxeFhM?=
 =?utf-8?B?dWNxVnhkU0xWa2xEZC9wQVgyb2hMYksyNml0VXVFQzdoZ0hOc3JEcjdXRDk3?=
 =?utf-8?B?UFpPNm5HNmk1L0FUYXVzOGJaMk5kTUVFNEdnYW9XNC85M2JIY0ZESEtjc1F4?=
 =?utf-8?B?dkZPVDRhVDlaMkhlSWNmZ1JuT3VNWEdDcFNnaFJ2NUlrSVFQU2FETUJjcEdm?=
 =?utf-8?B?T3Z3N0szbE9IaHNheHlIdnd0Yk5oTW1jVlBUN3BIMWI2STF4SlVMM21TNU9H?=
 =?utf-8?B?akN6aDdvODNiRExyQzdRcWJzaTRFaUkzT2xUaU9pYm5naTB5RHFxcTd4VU1C?=
 =?utf-8?Q?cbA0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e70de7-63d9-4eaf-472a-08dcc08224ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:07:18.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4ATa+v2iIh4+XbDStJFtG7aLrR2BqYv7N7xMw3crJjODqd0P/yB4oWH7e8kuODX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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



On 2024-08-19 10:41, Harry Wentland wrote:
> 
> 
> On 2024-08-16 18:57, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> Idle power states (IPS) describe levels of power-gating within DCN. DM
>> and DC is responsible for ensuring that we are out of IPS before any DCN
>> programming happens. Any DCN programming while we're in IPS leads to
>> undefined behavior (mostly hangs).
>>
>> Because IPS intersects with all display features, the ability to disable
>> IPS by default while ironing out the known issues is desired. However,
>> disabing it completely will cause important features such as s0ix entry
>> to fail.
>>
>> Therefore, more granular IPS debug flags are desired.
>>
>> [How]
>>
>> Extend the dc debug mask bits to include the available list of IPS
>> debug flags.
>>
>> All the flags should work as documented, with the exception of
>> IPS_DISABLE_DYNAMIC. It requires dm changes which will be done in
>> later changes.
>>
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
>>   drivers/gpu/drm/amd/include/amd_shared.h      | 59 ++++++++++++++++++-
>>   2 files changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index dd8353283bda3..a18ecf8607232 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1864,6 +1864,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   
>>   	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
>>   		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
>> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS_DYNAMIC)
>> +		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
>> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
>> +		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
>> +	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
>> +		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>>   	else
>>   		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>>   
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>> index f5b725f10a7ce..6c12ca954a53e 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -61,7 +61,7 @@ enum amd_apu_flags {
>>   * acquires the list of IP blocks for the GPU in use on initialization.
>>   * It can then operate on this list to perform standard driver operations
>>   * such as: init, fini, suspend, resume, etc.
>> -*
>> +*
>>   *
>>   * IP block implementations are named using the following convention:
>>   * <functionality>_v<version> (E.g.: gfx_v6_0).
>> @@ -251,19 +251,76 @@ enum DC_FEATURE_MASK {
>>   	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
>>   };
>>   
>> +/**
>> + * enum DC_DEBUG_MASK - Bits that are useful for debugging the display driver.
>> + */
>>   enum DC_DEBUG_MASK {
>> +	/* @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting */
> 
> This function has a kernel doc but these enum docs are not
> using /**. Would be nice to fix that. Not sure if we're generating
> kernel docs for this enum.
> 
> Harry

Ack, htmldoc didn't generate the docs for these. v2 incoming.
- Leo

> 
>>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>> +
>> +	/* @DC_DISABLE_STUTTER: If set, disable memory stutter mode */
>>   	DC_DISABLE_STUTTER = 0x2,
>> +
>> +	/* @DC_DISABLE_DSC: If set, disable display stream compression */
>>   	DC_DISABLE_DSC = 0x4,
>> +
>> +	/*
>> +	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
>> +	 */
>>   	DC_DISABLE_CLOCK_GATING = 0x8,
>> +
>> +	/* @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU */
>>   	DC_DISABLE_PSR = 0x10,
>> +
>> +	/*
>> +	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
>> +	 * if mclk switch in vblank is possible
>> +	 */
>>   	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>> +
>> +	/* @DC_DISABLE_MPO: If set, disable multi-plane offloading */
>>   	DC_DISABLE_MPO = 0x40,
>> +
>> +	/* @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA */
>>   	DC_ENABLE_DPIA_TRACE = 0x80,
>> +
>> +	/*
>> +	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
>> +	 * does not default to it.
>> +	 */
>>   	DC_ENABLE_DML2 = 0x100,
>> +
>> +	/* @DC_DISABLE_PSR_SU: If set, disable PSR SU */
>>   	DC_DISABLE_PSR_SU = 0x200,
>> +
>> +	/* @DC_DISABLE_REPLAY: If set, disable Panel Replay */
>>   	DC_DISABLE_REPLAY = 0x400,
>> +
>> +	/*
>> +	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
>> +	 * If more than one IPS debug bit is set, the lowest bit takes
>> +	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
>> +	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
>> +	 * precedence.
>> +	 */
>>   	DC_DISABLE_IPS = 0x800,
>> +
>> +	/*
>> +	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
>> +	 * *except* when driver goes into suspend.
>> +	 */
>> +	DC_DISABLE_IPS_DYNAMIC = 0x1000,
>> +
>> +	/*
>> +	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
>> +	 * there is an enabled display. Otherwise, enable all IPS.
>> +	 */
>> +	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
>> +
>> +	/*
>> +	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
>> +	 */
>> +	DC_FORCE_IPS_ENABLE = 0x4000,
>>   };
>>   
>>   enum amd_dpm_forced_level;
> 
