Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AE9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 17:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA1E10F20F;
	Thu, 19 May 2022 17:15:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26A310EED3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 17:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJL5Yd4hwe/V11yt/QHWHwXSY6PA8R97V08ujOY3HBaOrVrrXVcuN2GHKOsK9CmW4qppGCByEs/uuVmf6Qup35ECERbpuP2QYePMpQ4IGUgdNrrabT9pQpgDaPyhKVAF7Atm58Xgo/Rh3U8JqWQ3bkAeRP4E8HvT/NbwERceeJsKyC3vKuGEsbQH170QMYwDDpjqOQA/DDYIFDn85M373xtsJgVAYGTePL7MzqkUV4R3uaRcQI5gP91zEvIg9xI7UlPopQd65XBtq6H0/gxiACYvIivA7QsZUVRBAcFTOCujqbGCa6wfUwg1+27+b+4t7QJU87LEs3L44nlGmNzhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep/JplXyeeWfJ6wLby4yDe5U9eelu0nZMI7I5mSGpaQ=;
 b=F8ii8+lXZmjwL+L7MlBmKBkDMgob7itzd2lFp1lZRVRVdnG2+EEqtDnqoOy3CZnuUno0dShkuH8V4jrKVtadyIYmldpKFcAyPHehItFqeOykBpQLCsOpEtAW412NY5jF4flDlv1VUVUMbjgYlmtqoZqsJyv627A8ZzZBqH4+6E7ktWpMPBoiGXSja2hUbSz01uoF2UeROuDNp05caba05eT0AKX/f1GgCFdcq5Yx4q7pjccPmKQrWGJrd2TCZhqiLbEbw38mMY3sx8jw9THDOaLAE63rspYVBcGFRd7GLIYL2e4lA7TgdC294xcfu3S/k7+L8PKeXHcAWwlnuolYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep/JplXyeeWfJ6wLby4yDe5U9eelu0nZMI7I5mSGpaQ=;
 b=W/iUiXzXpcGoFyllqEUIhTtjnu9cqdHCkDA/tvndkelYmxtrMUxWpeYh3ltXS65z0NIyYVisfZeGz+qqQ80gfv4MQbd9kSXHpG0oNP13mHAOMLf2+gfErp2RTOnpl93oSO1LWOGauQGp4hzJpIk2346WVO1lwlnPn2pX569yXaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1475.namprd12.prod.outlook.com (2603:10b6:405:4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 17:15:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 17:15:44 +0000
Message-ID: <70b6b8a7-1fbd-79a6-975c-9aa0d1445514@amd.com>
Date: Thu, 19 May 2022 13:15:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519143446.74326-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220519143446.74326-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63f7de78-57e4-46a6-ae39-08da39bb355d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1475:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1475BE160B53D6690A43AAB892D09@BN6PR12MB1475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edNIQwF5H3QLYfuQf6/ZmFlV9SRkXtY6IJEgl+aLYBept/JvMarw/vP5OWzD5eYouDfnEEVu0cmLQV73chkUET9TRRcmNjMSI4oxwBDWvZ2aMvaFoHYtddU7Rih3VBQTPq3yl1ScqUjill/zH6HNwAV6OFeARpWEiixlNXaGojLb1RMtagAdmaz/bUDkNVdXjgWn6mOn+ziKR1ensWKrwh0rergqqg9bRhF4/ar/oQkDsTlp9bEyGjo0UCBRU8jgOFAeTcRhr4UdCQu1VsJCtbDMCLiVx+niPzgMhdjv2T/Le7a7orbrYsCJK+aYQGE91RTfFWyrLqnYQNuSYo2Xs51mLi+vYGRxK18SFuP1ggwSJICfAxAoIQ/5XObRwYuj6SQPTF7B5WgN/9OD9m8IvC3dVm9X1z9paRw3X+9Lcimz+IWWFOHVKcTxkH4Gk+wZ52yh49EAG+LYIVFWazGpkedxY+a5A1OjxEZSrP3H6QESS4FtEE1JxNGyUlf0HqqtQLzdR/JXfKsgkqGvnPZO50eG5qARRjYoe6vzIOMSA1gtdVJNWplUwUgBrgKNDAtVPX7fNLs3OSwBeSX5PVeJjbv4A+oWqhmsBhxOYvWmEFV5E+kg4iT+lCQ9C9o4ktvxSRI/Iyl9uCD4ztKjxlhgOUiV7Lr+XTHw2N1VpfBzVfo8ljcTfzOZuQTcZKdxwCP0QjcNYF47Wie/2nhTj9CZYjtad00N3C0pRurXNEHsZYtLWtGG8MNau7jVaOs8gfOe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(31696002)(86362001)(508600001)(8936002)(316002)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(186003)(38100700002)(36756003)(31686004)(2906002)(6486002)(6506007)(26005)(5660300002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUwwa21CUWc2dWsxL0FFc0JjSGVZTVNybGw4aytIZC9VN1RmeEt2d1dLN2FI?=
 =?utf-8?B?SEp1MEJaazI3WTBhUlNHNUxXWmVyNzlXRDNwN3hxMWNTTVpGdFgvYUdkczh5?=
 =?utf-8?B?azd2aW9GMVV4bHlDb2VwLzFLazJYWW9XMC85UlpJb2JTUnhudFlUb2pmaENL?=
 =?utf-8?B?dzFFTjlTV2lVczlJWlM5WGtDUUJ4c1ZYRFhRdlZ1eHVySWVrUDhPYnBpSnha?=
 =?utf-8?B?T1FEeWNmU0JzSHJPWVRuSk44WHdjUmJsSjhLak5IaGdRNlNqbjNMTzRWcnNj?=
 =?utf-8?B?NmkxWGFBZSsyTkxQZE80M3JNQkNCS1lGZXBFOGRwSTR3ZjlSa1VWYTdHa1pE?=
 =?utf-8?B?VmVhaGV6bTdPZW1hM0FoWTdMVENLSkhINWcvYVAzd0c3NkQxV3NxdGNLOWl5?=
 =?utf-8?B?MEpUTXRJQzdEUTRwZVd2T3ZRY2dvTTArSXFjUExlVGxVRjlYaFNYTjQ5V1ps?=
 =?utf-8?B?Y1NONERCUjRjelBYUFdWNnhMQXdPL2I3dWVRWXlhWjJCcmEyMHYxKzViN0gw?=
 =?utf-8?B?ZVJJSU9DVzZ6dG5KNXhzbTc0bkpYY0t5ZmpxMGhDYlNCV0pyQjJEMDVOVmRj?=
 =?utf-8?B?eXRqMlRlV3ljazQvZ2hBdytqQ3VJWFlWOG83czcxQ3JLd1ZmbFNkTE0xc3Ry?=
 =?utf-8?B?Vmk0ZUZVQmtvNnI3VnhUWWNBOFRtdFJhV2RoNmpVQTZ2S1NPeHMvYk40UHRz?=
 =?utf-8?B?b2pqWW5laG5TYmYwbnYrR0t0NmZKdTRqRWUzc0RSdTJHREw4TEhsMFdZU2lz?=
 =?utf-8?B?bXBNb0wwakU0c3kweXE5YzRjb044bU1WZ2RvV095MXFZVllBcHA0bnF2UnRY?=
 =?utf-8?B?WEpJL1JFRkM0ZEo2UUhlOHRLQ1pjdEZwY3JoeVhoUW9hQmQxODV0Nm5tMnh3?=
 =?utf-8?B?KzNRWUZtejZkajZFclI0bVBwdlRvM3lpZGg3dGxHMm5LQ09TZC85ZDJUc1VN?=
 =?utf-8?B?ZkhhRlZLc0UvNklQcGp5SWFHTyt6THQ1d2FRc0QyZ01yUVc2STBQcXJhL2hn?=
 =?utf-8?B?dHBkOHJsVUxzRXJrVWowbHR4NC9hZjJ1dzkzbFArSmJVdVlkUHJISkFxVW04?=
 =?utf-8?B?T1RNK0tpZ3hKazl5WHd0bVhDeS80UFZSRjNFZXBUQzNDc1pIb3NidXVwaEVZ?=
 =?utf-8?B?MnlnUldRbWEwbGdoUVFrcWVrK3ZpbXZ4UkxUZjJCZ0JLZCtrR2hYTmpNbG5X?=
 =?utf-8?B?Mm1US3E0QlV0SEpQOXRjL3NGVGRBSVRteXhucXBlUFVMekVxc09vVE1KTW9J?=
 =?utf-8?B?TDNpS3IyUnRaODMyaWFNMU9YbUFsTmJhbDd4YzZHQ05uREZyMHk3TXhQd3VK?=
 =?utf-8?B?OWpKQU1MKzAyQXJHaFIxNFZBQnZWcUNiUjhTOTdyYXI0T3JRY0p0Ry96STV2?=
 =?utf-8?B?eTJzRGZUVEtzeVpEblFzM0xQYW41WC9HZW1TWHh2ZEdJQ1VONkpiZEVPTHZu?=
 =?utf-8?B?SjE3RFp3bnpxZmZwWVJYSXJSVi9lMW9seE9CRUE1SEQyRlFCTGxDRUs3VE91?=
 =?utf-8?B?SE5DWDBaTm1yZkZaM25ueGFYU1VIS3h4V2RxazR1eTRKYjNMMUM2R0ZZaE5x?=
 =?utf-8?B?SWNjaTF3c0Z5eXBZek5zVmhqa0dZY0tXblVjeVE5TkgvZEFpZ1BFejFXZDFJ?=
 =?utf-8?B?dXRrZlUxNjlGZzNQbHFXNVUwSmpZQVV2dW11b2dCK2JudEVxWDArUndzU2Ro?=
 =?utf-8?B?OVJ1UXN1bGRUeWNOc0ZncENzZy9pWUJVc1gxZzN3S09yY3RrcWQyWDlyTi9G?=
 =?utf-8?B?L2QvbFRyS2ZJOGVYbWpUYTdXcDRaazJneGlZZGhxZ3d6ZkxYTHZjcFdTSzl2?=
 =?utf-8?B?cDVKN2VvOE85REVUckVBZFpCTzRIWDAvNGxBZ1BLbGhSVmRKNGZwTXpXV2tn?=
 =?utf-8?B?K3FMOTFFeTVBeWNnMUhtV3NjVktkWWphelQvUEhNc1lJbll3YXhiYUZsRUVa?=
 =?utf-8?B?RWhvZkJwcFh0U0tlS2hMRzlVL2RwS0ErV0dnUTFxYTI5MDRROUM3K09Ccm1Y?=
 =?utf-8?B?UEFMZkR4cTJQeVlCOXliaXBzTzRNbExHUE5qZjlhOGJQS3gxR2xUMmdscHk3?=
 =?utf-8?B?Z3RtZFZZUWhlcUZjSUF1NmN2V2hmdEZtamc2MjV6SWI1bEhJOXZZUG4zbDZP?=
 =?utf-8?B?ZlBoN3RtMlhlRTdqV1hQVUNkLzdwUklRSjVzRmZFdVBLanMwMGVTTUpwYTZG?=
 =?utf-8?B?VnE5T0NZRjBUNWpCVUdDcjZ6Y3U4aVc3M28xSXpFaGNMUlJ2M3piNVY1R0dQ?=
 =?utf-8?B?bzF2dlExNDFkcG1ta2tsNGRzUm5DSk00dHlnYXhBMXpoRy9Ed3ZvQUsrbWFo?=
 =?utf-8?B?K2FaU0luREhXOE5GMzJPQm8yRWVHaWhJRGhwTE9XRU5WanBnUjhHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f7de78-57e4-46a6-ae39-08da39bb355d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 17:15:44.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T4GWOPHsHauSvzPdYaWR4xfSKK0/I0dfltA6FIc70M2jVTG/jqvbwVZwefGy4bxneJNq92uxmcMdhiJNHGvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1475
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


Am 2022-05-19 um 10:34 schrieb Alex Deucher:
> The current somewhat strange logic is in place because certain
> GL unit tests for large textures can cause problems with the
> OOM killer since there is no way to link this memory to a
> process.  The problem is this limit is often too low for many
> modern games on systems with more memory so limit the logic to
> systems with less than 8GB of main memory.  For systems with 8
> or more GB of system memory, set the GTT size to 3/4 of system
> memory.

Well, I've been railing against this limit for years, and was always 
told it's unchangeable for reasons. So we found other ways to use more 
system memory in ROCm. Good to see that I'm no longer the only one who 
thinks this GTT limit is a problem.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4b9ee6e27f74..daa0babcf869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	/* Compute GTT size, either bsaed on 3/4th the size of RAM size
>   	 * or whatever the user passed on module init */
>   	if (amdgpu_gtt_size == -1) {
> +		const u64 eight_GB = 8192ULL * 1024 * 1024;
>   		struct sysinfo si;
> +		u64 total_memory, default_gtt_size;
>   
>   		si_meminfo(&si);
> -		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -			       adev->gmc.mc_vram_size),
> -			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
> -	}
> -	else
> +		total_memory = (u64)si.totalram * si.mem_unit;
> +		default_gtt_size = total_memory * 3 / 4;
> +		/* This somewhat strange logic is in place because certain GL unit
> +		 * tests for large textures can cause problems with the OOM killer
> +		 * since there is no way to link this memory to a process.
> +		 * The problem is this limit is often too low for many modern games
> +		 * on systems with more memory so limit the logic to systems with
> +		 * less than 8GB of main memory.
> +		 */
> +		if (total_memory < eight_GB) {
> +			gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> +					   adev->gmc.mc_vram_size),
> +				       default_gtt_size);
> +		} else {
> +			gtt_size = default_gtt_size;
> +		}
> +	} else {
>   		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> +	}
>   
>   	/* Initialize GTT memory pool */
>   	r = amdgpu_gtt_mgr_init(adev, gtt_size);
