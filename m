Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D38EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 14:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8908610E637;
	Fri, 16 Jun 2023 14:24:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DB610E637
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 14:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee2bT4BQQ2u+lRI/ocARM/hZ46LYJeb0qDi0q8IsQoqr8PnQxeywgtaW1v02toN47UFb0CZCj4aYj/vdAQKcRBCQ47l/lQA8tCftErZV4rptMobL5uCEdBDl2cRIviDprLC/IphKD5/S+oJzcLYgX+dHe9mThRoQUklrQLQqb85n3yuwJYs6pBt/yEwcn7FVEzdogqCBMb8siwt5S5UGT6RHXUnskokBzk/FgRrEV0Sim/pAtGSMXI+VxcHjEjZAQWoTbkZxkrDx0+43SdHi2Q+yPIzZ4y9cKbr05Kcfwq37R3B6bFzOYKj6UlcPIpGxfXZ1DmhVizqYlBj7WUs5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFqguYt8ytnT2JELbeidPgVTiTz94dJLhPRnOBTntLM=;
 b=koskoSgCDgX95G0SSxrf4zSIjfOhqKwQXNnuucCvnEpbduv0yJrpCW/jiOinxmdDWj0hNDeQWrLukYosP9Y2cfD/Jh4tbVgRKLXirn+1mIA6KoYIKdqbRkVVV9sJ1ZTu3zC85IIK8d1nWU4aUghvqGLbDXuYMLLOtPUR7f/BQs0IWsnnhjGzQuDkGfpBtg8UdmFOPNDAbA8kOzPRpQ8nL+sB886OwxOZ8QQRiopIxqwRchGdYNCHYWX8IQdAmaktc7UG+kYPYPOserSfdTgUtCTkv6fchSNHqkoOndX/I4TBdBgN+Q2Xch+M356zTVENbEo4341HsVmI9oHGiMLxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFqguYt8ytnT2JELbeidPgVTiTz94dJLhPRnOBTntLM=;
 b=yAWO3mfasaeavbDIBXhrEu8VDqMYv2lTYAXlqB6Hxu3y7ZIvRE0LJFOHnZvh5ztbwiakLX4Bx3IzACXebCSCdhiHh1N5LtUVb856nFOKKsd4shJtkujpUY9ER+QtDXeeZ+f8oQHQ/cFQ8geaALv4/gpynx4qmw6E95B3T+mlDlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 14:24:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 14:24:30 +0000
Message-ID: <1e69b39b-b12c-8e14-fb47-f01a068706cf@amd.com>
Date: Fri, 16 Jun 2023 10:24:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Modify for_each_inst macro
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230616102340.1665822-1-lijo.lazar@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230616102340.1665822-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a82c85-ed8e-4169-b675-08db6e7565c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aP+/3hEYEdZKSnsGWS5cmOuzw4JWUAV9iHJE0/ZHK8MSkoJfFtJ7t0qAjbh8xIj/RpZrayZsgToHiVMz0PWQObz7hncVhSD8iWvbhOT2+S6xZhEgivtKfoEcfJPoQwLqv5m4MM8ENuQCyoysavxpFby7nh1Nv4AlSF24L54kjRrDgnMrVMPIfElS46qbFl8k5fOPZeJ9ZywkGw8mrf5BvP4Tr3RuiLSBatvz9OUx5BDEP6kuvqA4VU066PWvf8/OYDxyCnrwNF+gpc+wQ+bS9IjANL07JXfXkErAl2BZoeBB9gb/D6hNq8l39Ul7xAggcSXJ8si5AhnwLyNwvOSnEdoaLMEn69VjG7ytuC/ggegmBM8REDg7ppKtEvSKTCSiZsMi43igtDXb9kjPPTgJhbmaG5r7LkJjrX5N3idGwxhr0S8XT3M+xkzIap13FEt2+O7PVffkgD52a1R6G4V8GKs7u9p0jeEdRELM1mCcLKrL2J/CNQ6Vchj6OaG6rC7dtDJoGijTqce4+eq4v8x07WTdnvk9RgpGzBasheLzGWqOkluytgRRwAQqsJckqVxYF9JI53/HQNWE+tIxh8OtkRY8xKejQx+2utyw/Vnxgm/VqiJWo6p9f4CI1lHsgqKgwYhgyw70SNkR5sjILKTo4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(31686004)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(44832011)(41300700001)(8676002)(66556008)(66946007)(4326008)(66476007)(83380400001)(2616005)(186003)(36756003)(478600001)(6512007)(26005)(6506007)(6486002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBhRkpUaGlWQ0ZaYTV2OEZZWTRleDAvN1BEejJjb2s0azNzOSt5d0FRTW1F?=
 =?utf-8?B?VEw0RGhkSDZwSXBudjBqc2VwRjVRb2xGbkhXWUVaVEVlak53TkVvNzJQVlFi?=
 =?utf-8?B?bE12M2tCMklsWGVCc0hBY0ZSMG5XbFZjbUk5ZXJ0V0xVSFd6bWUwNG1WR0lq?=
 =?utf-8?B?WWc3Z0QxN2puRGYrYUloQ2dVaWE0T2JRbUloajdxUFJqUkM5cUt2Sm9LQ2NS?=
 =?utf-8?B?NGwvQitRbHlobE45KzhvWkRNZ0lhb0hnQ3duSksvMjRpTGZzQUdhVXdkeXhH?=
 =?utf-8?B?NldXbVF2UUtreHp1RkRqUnNUdkRSbkNwdk40ckpienVLNjNFNGRKTlFrM1Zq?=
 =?utf-8?B?em5FSnJRZVdROWtUUmcrTnlEY3pIUEVoUWFJQUdOcmV1dk5tUG1OOVM4bmt4?=
 =?utf-8?B?am1zU3VJMVh5UkFBVXJVRWNtdFVGZFY3NldIQUFSSTJlU2tNcWEzQ0ltZVd6?=
 =?utf-8?B?OWVXYm9FOEhGN0RFaWxiRFFHd0RHbjJselI1VERuSUh5ekhBRlRML044eVV5?=
 =?utf-8?B?d3c3N3dWdWIxZGt6NWNrQWl0NTZhRG53dFlVa3pnbXoxVkZvMHNLR2J2RCty?=
 =?utf-8?B?Rm4zOXR3bVdYTTc5aEgzZFU2eHI0NElQbnFtcFU2Nnc2RzR2dFFTNVFqTlp5?=
 =?utf-8?B?V1ZoQnk2MDhEb2JjS3lTZDBvNTZRTHo4UEVhSXczWHE2RzZOSjRMSENGL1kw?=
 =?utf-8?B?Nk14NVR1WGJzbDRuVjh1bTU1VzM4bG1lMUVsVmdYY1d6V3RyRWMzY1N5eENH?=
 =?utf-8?B?TFkzNkxkMGlMVVV5QlM2dEJFMVo1RHMvNGNLL25ialVpeEcyTHdXRCs4K2lK?=
 =?utf-8?B?UG8zRTJrRUNDVlhMT3VhbHM3TUN5dEZHdFdIeGg5eW5WOENIV2J1S2ZNOCtL?=
 =?utf-8?B?NS9sNGZjMExJSkZNM1VsWlNvaTNVMHdlcU9HRVBVK3UxUml0eFdKV3RibXJH?=
 =?utf-8?B?L2c3bWJhRzUxd1BZcFA2U2k2LzZKQTlhZHJnZnk4dEUzbTh2V2JGOThxcFdt?=
 =?utf-8?B?T251RVIwUk1vaEtFSHQrajZMNThrZXkzMnNCWFNZdk9kOHVsR3pmWjlmRFJ3?=
 =?utf-8?B?NXd1eklVaU9PcVFnRmNqV2JFZk84cUoxem11Qkh2K2MyMzRDQ2FtN0tBWEl5?=
 =?utf-8?B?K0ZwQWY4Mm1LSmZzeUVJZmJQM1BJT280alRzWjdpSHNaejlWRHlndUMyWlkz?=
 =?utf-8?B?NnBCcnMvd3FBUXRweCtCZldiUFZEY2psVG9Ua0hsSGJudHlpUlNWSUZJZWVn?=
 =?utf-8?B?U0FqcUI1UVFrMjVyZmlFcFVOOEV4ZjlpbXJrblVkTnI3U0dnZ3RmZkIxbGsy?=
 =?utf-8?B?SXVmMGlpMUtTaFFIYmRtdEtvOVhZckd4Y3JaQjhNZFFGdDI5OGZtSDhlZEFZ?=
 =?utf-8?B?RlVqcHArVVlGT09lRGsveUp2Tkc4d0oyNXVIeldmUEpRbFZNVFdKU1RoWnJB?=
 =?utf-8?B?dCtoaXJIOXJ3V1lmQmtvZnFkSHgrNjNETzNydUpLWmNFbVJ6ejM4SkQwZ2ZT?=
 =?utf-8?B?Z2UrMnhXZ3VjWDNvVFMwRU44c0k2clVQcmNQZmNvRE5kd3BhVUY3K0RsTEF5?=
 =?utf-8?B?ck9wdHRob1ZLQzNLTXJnNjVNa2xQdGFSMTNWN2N5WFQxMFlpZUhIWDlqRUVK?=
 =?utf-8?B?MnV4UHlZWHNaWEV2Rmt1bDh3T3FGOWRoNHBFM2RZb2VzbGkwaVIrUUY2TXZG?=
 =?utf-8?B?RjhzbVBqVTJEZjUxQXFTaXMyNEN4eEpUdFlEK3N0YUl0Qk1zdG5JQWtTUmNh?=
 =?utf-8?B?eVZzMWFDTjZUQ0M5K1B5MzFtL091UHRpWE5acnZJOVRYRDU0NnQ0ZWZqdFRQ?=
 =?utf-8?B?K2RVbUw3NWFVbEVWMGhHdjhncDhuK284OFV1YWMwUGJTNFU0cldqUyt1Vy9H?=
 =?utf-8?B?cVA2dTFiekdhbTFHYU5YMUxKRFhwTFVoOStwZHNyQmFPRlpmbUtiWDcvb0xK?=
 =?utf-8?B?MHZ2LzVuNVBIYlRpc25UYWg4WkNXSjVsYnhBSld3aFFid3VJQll0aTM0MmRj?=
 =?utf-8?B?QkcvU200dGhxQWU1ZUJUVllUOVA3em1vYzFiNDA1M3dYN1dCRFBSRDJoV1Jl?=
 =?utf-8?B?R3IyTElKb25pMGVvMlgzUTRlaEo3eGhnUWpIZXQ3VEsydkJqRlhDaENWU0hJ?=
 =?utf-8?Q?fjsQCeldRVKMXhAXxJ/J/OAQi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a82c85-ed8e-4169-b675-08db6e7565c0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:24:30.2151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/xxA0AfB+tCxpIm1ijZu2fkAPpbn53X+a47jBf4OTMc1sNgOUKTGVtO5tMFvmUfkw3j/tecGyMdJovJgwGJnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-06-16 um 06:23 schrieb Lijo Lazar:
> Modify it such that it doesn't change the instance mask parameter.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f4029c13a9be..c5451a9b0ee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1295,9 +1295,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
>   
> -#define for_each_inst(i, inst_mask)                                            \
> -	for (i = ffs(inst_mask) - 1; inst_mask;                                \
> -	     inst_mask &= ~(1U << i), i = ffs(inst_mask) - 1)
> +#define for_each_inst(i, inst_mask)        \
> +	for (i = ffs(inst_mask); i-- != 0; \
> +	     i = ffs((inst_mask & (~0U << (i + 1)))))
>   
>   #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
>   
