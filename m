Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A26C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 05:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E96E10E75A;
	Wed, 26 Jun 2024 05:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RHAlAZxj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B103710E75A
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 05:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJoHqukd86DE8nzfQ+fo+TrxIjhzjRXa7HKEeJ4120pxVR13hDs8jWyG0azlC/9/rsTmPADsZBDLJGwWfCRO+g9cs6Ut8mFJiwES0k52JmlNMCmyI4OVY2yHXGSMJAaiCNHtowtsqa5x/9UrZR0UxqLCVCG07perz34CA9KG31KYO6YlQk8/DZAYNBnt7UXFhUc2NO+sYX5/5E6Qmh2Xon4ZJdth8VkzQZxAQlay1Snm34R4Fys+EaeltTvOHiNNKMljE935BSZCOmjATNBHlo0XAdCMSn1KogWyOxdqVM6MI+pw7erIWyrU+Y6hXPVva7cu9PNZidiJZ78s6miDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKfO34OvMRIhptbKDLta2vqk9EXtjF5cYHyBwdUSvKg=;
 b=nwFlY2QZkHyV7STS2AH5R9+Qpbursq4rh1FlfEkisvA0wofBM6k/+SxfZsmI/Dew3PRXMWqNmu07F1nDr3SF9zwIZ7Cl/8LLNdeWX7CgyLODDTrkQTmSPdhQV6pSY3XOOn+GYmWZrCapVHfl9M8Od34VR57vNnI0oF/iR+qr05MxA0CL/vVhbLcdLO1Ek59XcNyeQwyl2Wg3VrwIawpdGRfMld9nOI19XvP0A5YiCZLImW1yhCntYmK0845XRSPtYc7cODOQjLuUBUcZIh3s5l0sadT3n6n2SbYkx91Jgjz4aGrgk6YgSu5rBlPUwhpfHJXJE+RUBuvE7qf1Dtxyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKfO34OvMRIhptbKDLta2vqk9EXtjF5cYHyBwdUSvKg=;
 b=RHAlAZxjPK4CZ+Rygd6vwtcuhXQ656HmV9HvsckrcozX9qHdgxDWQXTdNL8xrTJmyUJ3yz2hxaOZ2/cTshMDJWoiZHJKiB7rHY5vfovYpj7ZLN2UcoI4gmC4gMhRrnezh7CpSFHONP//yf7fdphZZW8Z6sbHQR+MP5rZINTkVtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Wed, 26 Jun
 2024 05:38:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 05:38:39 +0000
Message-ID: <a3d9274f-3b46-42aa-850e-94372be1b8c4@amd.com>
Date: Wed, 26 Jun 2024 07:38:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write in gfx_v9_4_3
To: Jane Jian <Jane.Jian@amd.com>, Lijo.Lazar@amd.com, Haijun.Chang@amd.com,
 Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240626030129.2551363-1-Jane.Jian@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240626030129.2551363-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c67a6d-b85f-43c0-0cb5-08dc95a23b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTJXZ1NzWVM2VnJlbTg5QzJwNDgxeFZ2Z01UdGh3bGwxRkM4VnVzMHo4cHRE?=
 =?utf-8?B?KzNwV09oR2h1UlBjcXJlZFZKWDlDOXhuMTFVb3I4NmJNWDBYb2xkWmxiRW9C?=
 =?utf-8?B?UHpnSHBKSHdIdHZKNTBCakFjMnF1RUM4a2JpYWMzdXZ5RVdPODZScTJOK1Zu?=
 =?utf-8?B?K3pyd3BPWnI0cFR4RkYycEV6emFTMkpRZUFLSWg0OHp4QUtoYUNxN1VLYXFM?=
 =?utf-8?B?UitXS0RPWXViVmhBWElmTTU5ekxFSVh0ZlROV2dobG1Ed0FkNFRIYVJlMi9B?=
 =?utf-8?B?OUszNGtENFR0aGZlYkVkZFJRWHQ3UjNkOG5DQ0hwWHM3RGVUT1VWenJVVDYz?=
 =?utf-8?B?T2FQQUxMc3NGSVVML1dNMGNiNFRVTXpYbWx6d3lXS3ptRUtVVGRZV0s5YStJ?=
 =?utf-8?B?UEtOcVI3bjRJMVRGR1ZOYkxxdXZPZFREbGtjbWU1ek5jM0xGcW1qaThORjhR?=
 =?utf-8?B?VUFYSzh4WHhWd01LaEh2YW1kR21iazlXdVlRY0sxRzVEazdyT2JhUmcwcm8z?=
 =?utf-8?B?QWUyVythZW5pY3JxWUVaU0JldHFCRE4yb3FMOE5NM1JQZVNFVFlDZy9GeTNX?=
 =?utf-8?B?SEdMZlhySGpaVm94RUtlNitFUmRHdEpJOW52YTZCSE5TODdwZTE0c1Y5aGpB?=
 =?utf-8?B?YXE2WHFGN1J6ZHg3Q2xwcnV5VWpETnhYTW4vOWR4OEpwTWZiUXJpa0d5eFJ1?=
 =?utf-8?B?L1QzSkZLeFdXejNVSENBeStXZW42VWZoUlQ0N2RNVUVaZ1d6Z01yUkI5ZzRu?=
 =?utf-8?B?UHZDN1J4SkQ2QUNBOUtER3ByS2o1UDA5RHcrM3FuUlJkSXMwZXJ0WlgvRHEw?=
 =?utf-8?B?UmVXVHJFeFBWa1lMRFVzNk5rVTd6OHBNZndVTlA3WHFLNHVzQjBZZUxUK1F2?=
 =?utf-8?B?RHp0bzlWdGhsdDhzT1FNNkVCZ3hSUjZPWXFBM1VjOWlNWVlUdUp5RFJOb0hv?=
 =?utf-8?B?SU9SRCtjZER6dkl3ckxuMHlpRnRtajhvUG9KSXpNa3I4UmJtNzlsakdiVnow?=
 =?utf-8?B?Q0tNeGRpelJkRzUxMVBvQ29uSHlkcjVkenE2NlZuWFNtMGpkTVh1cW8wRjVM?=
 =?utf-8?B?NWMrQ1V0a1JFbmMzSzh3aE9EcUxYNHMzck5hYnVzVFZ5OFZySTMrMXhSaUpz?=
 =?utf-8?B?aGZheUFZNEEvK2tIL2FPMnVxeVh4dEZsMkhPWnZoZnFNaU1SV1liQlJWMWZY?=
 =?utf-8?B?Rm1sYmRoTVpwNTRWRTRyQjFOY0FHYVFrMXBNUFd6VHZpRGtUVlh6SkRHVEEr?=
 =?utf-8?B?eXFvUEd1K0R4QlFJUmx2ZkpuZG4wenp6WVhQSlNULzNqcmZQM2ZiN1FTL0VR?=
 =?utf-8?B?TCtpT1d1Q25wYXNTREVXSURmVy82Q1lxWC9jZFh1bGpRVzZrOHl4Sk10NVB3?=
 =?utf-8?B?RmM1d09DajllTjFJd1Bhb3NpZmp5cTYvVEQ1R256ZW92L3ZTZDZya2JtcUcy?=
 =?utf-8?B?S0dRN3V4L1FqL1JLTVEvUFh2anMySFpNWU1RdzRaSXNJMmc0K0tOVmRGTlp5?=
 =?utf-8?B?cnVPKzVvYW5KU2RudUVwazY2dEZFak40Y0FVYWFQRnlaTjE1L09FL3lQVUFz?=
 =?utf-8?B?NDNOSEJoMjFZMk1MWm1SQytaU2tDVFp1dHVWbkJmd2UwZEhHV2JLNDhFQVRv?=
 =?utf-8?B?akF6dldUUzhtYTliM2NWaDZEZXl3VDBwRDNGUkdNWmZ0V2ozV0REcldrNXRw?=
 =?utf-8?B?UUUrUUl2dC82cWV1cUtON3N2VWZoRXJNWld0bi91TkVJYzNmUEwwak5kVDQw?=
 =?utf-8?Q?mf/aiBsZQHW5qdn+TxgTQGBhEJjkepMoZ50vimu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(1800799022)(366014)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGMwMGNNWjVoZjNzTlpmMHBzMHdPNkxHeC9BaW1BVnVzZjRZaFRreTFlWFg2?=
 =?utf-8?B?MG5GaS9SQUU2bXF0dzBiRytKVDFja2xmZ2ZoTnpjQjZTd0RobXMvNUdoNis0?=
 =?utf-8?B?c0VmTEYzZWMzYzl1RGpHWEZ0TGpZM3BTMS83UE9BNHNGUmNEb3o4ZFpZbnVr?=
 =?utf-8?B?K3hOWVZBQTZja2pleVJETW45ektoOWtzMkxzQmg0MnRaeUIrb1JkSU5rbGlo?=
 =?utf-8?B?dlN6ZFBlclZuNEdUV29uNjZNYkZNRktGUnlVQlQrRnNROVAzSmduRlFrcW5v?=
 =?utf-8?B?eGIwL1ZXQmRvM0pUVGEvLzgzd3NZYS9XejdveHo5VHBSelVhL0xET3VsTTV1?=
 =?utf-8?B?WWNqU2doNlRlVmxIckQ1UVVsZ1QvYndON0hKVU9pQm1VOGg0T0kwaXRxZWI3?=
 =?utf-8?B?SnRDOG1DcDEzazQweVNKMW5lV1BCa3pGMGtVNURVM2ZrK3lreWU0Mm1wS3hT?=
 =?utf-8?B?clZOdTBpVVZxdkdaelA0b3FJd25jZXVmRzZEeVgrb3g4dVhqTk1YbDVkelNS?=
 =?utf-8?B?SzA0Wi8zc1N3U2swN1NOVlZSeG9PR0Ntb2M0YlNJTE9ZOUZNb1FDbmh4anBj?=
 =?utf-8?B?b3AyT1lFaDhIWjNiR2h3L1RxMzg3R1hUV2h2QUxnY2swYWV4NzZFSE1Yano0?=
 =?utf-8?B?NVVBaDdkYkZPRGdQZFp1SDlYMisrN05CeURSbkR4d2JMV1pSR0NoTHM5N25z?=
 =?utf-8?B?STl1SDJsU1BBRC91MDBiY0JxRlBmaXF6NGFQZXNrVjRURHVBeEl5QWlpbXQ1?=
 =?utf-8?B?UUFDOXBTSWUyYXpReHdPVUFsbmdjWVY2c20vMGNVaEVrQ3N3d2U0Sk95WmdM?=
 =?utf-8?B?Nk4vak80RlNWc1Yva3ZQRDFwM2dEUWk0V1E0Q1VQZVFZYTBsY255d2ZrZmhF?=
 =?utf-8?B?cERUZHFQMEE1MW11U0lXRzFBcUN4YmRnM0ttdnhsM3B0ZE8zbFZTd3lLT2tu?=
 =?utf-8?B?UXd0Q1RWbTNjRlZIZ0VldGVpUWtqZUNxRlZSSGNOYXZIY21HcnBuOG9yMGJ4?=
 =?utf-8?B?Mkx1bEZUZFh0Q3phRk5XZ1JYb3liWGpGUmNWWWtKYlk1WXlHT3BFSkFpME5U?=
 =?utf-8?B?Wlc2K3hyNDlUTU5ZUU90M1V2dDlGT2lHSUhKc0RDRHlnUG1EaG0wYmQwaTkr?=
 =?utf-8?B?ZStDa3JmcWd5WkdmMGloaTRnZlV2dG45Ri9CSFU0Y1c0V3FUcmhxand2V2s1?=
 =?utf-8?B?dUZIUm52QnB4dmhpRUorVUZLS2gvQnVvcm5ZaVRETkVhT0Z6YlJpcjNmS0V0?=
 =?utf-8?B?R3ZxVHJUWnkyOTRHQUxacnhMZkdYcXlJdEwxTjAxSjFyTEwvNmYrRFRQZUVl?=
 =?utf-8?B?dnYxTERTaEpDaWF3ckNFK3JoSTBuRnpSWWJlb2J3NDAxbXROekZqb05Xemx1?=
 =?utf-8?B?VngxMEtQME8vcnVTaEhDR2tCYytxa3hwUDFzeUJwUzFEem5Pc3ZVUWJZZlVL?=
 =?utf-8?B?VHVwTjd6ejFia0V5M0djUHU4N1d6QjF1M2xPa1J3NWFzamF0VW5ISTVDVU50?=
 =?utf-8?B?Ym5pU0tGeE1wRTQyUjk0cC92cWNVN1BXWENTQTdBNkVDdURqbHFRMTlDa2RZ?=
 =?utf-8?B?RFIrT291amZQakU5bitCV3FReTBQWjRHa0JhUTVEV29nZzFRV1hnQ1RkQ21L?=
 =?utf-8?B?amE5VktJUWtDR0xqeDdMR0JLaFlXbmQrU2JHVDROcURjK21lOHZZRmErUmV2?=
 =?utf-8?B?TTduZHJod2pSWHd1eDlhRVZEZTFPTEsybDg3U2RPMDdrUmF4TlFlQlIzbmZN?=
 =?utf-8?B?c0dhSnhoNDlEcjVybDZQbVg5bnM5UytRODhHUWFtTXdoMVZvdWJsdHVYMFZk?=
 =?utf-8?B?bGRiNHFTQndjaGtPbGZTb0FGQTN1aXVpSDRGRGo4YVNnZUNWd3RBdW9LVDRF?=
 =?utf-8?B?Qk50Njl2TWJ0NnpOclhFSzI2SWJkK1pWcFFEV09RMkhGVm13SEtDNS9QdCtq?=
 =?utf-8?B?WElRNGRmN0xXaHlQNCtHZG9JVEpEek9RZktmZEFxU1YyS1ppbzY3S3p5c2V4?=
 =?utf-8?B?QTRlUURFZW1YV2FwT24rM1NHTXozb2g3Um5iMlZXUG5vL0xqR3ZRa1V0c3VY?=
 =?utf-8?B?WFRxRVdoSHNzMHJ6cVV4ZEdVTFZLMGNvM0lqZU1HdG1JV1Q4VDMvT2FteHl3?=
 =?utf-8?Q?BX5k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c67a6d-b85f-43c0-0cb5-08dc95a23b27
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:38:39.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUBr1ogH6eOMQ5C/jKouElOgF8VozvrgBK4gqyM6nXVsagmcK6TJMExex88yIzF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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

Am 26.06.24 um 05:01 schrieb Jane Jian:
> [WHY]
> sriov has the higher bit violation when flushing tlb
>
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Lijo has a better technical understanding of the background than I do, 
so he should have the last word.

But this looks like I would have expected it to look like so feel free 
to add Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8d8763ebe027..87a6a610e467 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -55,6 +55,14 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
>   #define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
>   #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
>   
> +#define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
> +#define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
> +#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
> +#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
> +
> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
> +	(offset & 0xFFFF)
> +
>   struct amdgpu_gfx_ras gfx_v9_4_3_ras;
>   
>   static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
> @@ -217,9 +225,24 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static uint32_t gfx_v9_4_3_normalize_xcc_reg_offset(uint32_t reg)
> +{
> +	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
> +
> +	/* If it is an XCC reg, normalize the reg to keep
> +	   lower 16 bits in local xcc */
> +
> +	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
> +		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
> +		return normalized_reg;
> +	else
> +		return reg;
> +}
> +
>   static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
>   				       bool wc, uint32_t reg, uint32_t val)
>   {
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>   	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
>   				WRITE_DATA_DST_SEL(0) |
> @@ -234,6 +257,8 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>   				  uint32_t addr1, uint32_t ref, uint32_t mask,
>   				  uint32_t inv)
>   {
> +	addr0 = gfx_v9_4_3_normalize_xcc_reg_offset(addr0);
> +	addr1 = gfx_v9_4_3_normalize_xcc_reg_offset(addr1);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>   	amdgpu_ring_write(ring,
>   				 /* memory (1) or register (0) */
> @@ -2725,6 +2750,8 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 0 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
> @@ -2742,6 +2769,8 @@ static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
>   {
>   	uint32_t cmd = 0;
>   
> +	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
> +
>   	switch (ring->funcs->type) {
>   	case AMDGPU_RING_TYPE_GFX:
>   		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;

