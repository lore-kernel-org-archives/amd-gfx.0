Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B5BEE57E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 09:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA19E10E88F;
	Fri,  8 Sep 2023 09:02:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5586E10E88D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 09:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVjnJ+2HSHtO4C3lYxR0JzC8D5ooCSQrmPAEwRex9ys+oF/4/DnsdNhqTggBXclGFXV84vzi2mqZ3zL8uwv75ANko5nMiOy0MjeFKEzRKzFXtkoE4ucVN9B8OsPeJUqLa1yTzd5AhhbSX+0XVksRNPRkB5xP+U0DnvZXtvFtXi78BH22IYYO4L7v4I8k54cMaRI0REsB2Ulz2nov7wN91E5QFL4a6DOj8Yoe0z0wBNNSZSNgWBTAQnHYYc7TdQNbdHiqXy1SIrYRLR9aAQfSwttMHL/1J6VY78LJ/37XeYhaggQkZFhVLDHBZKpa6p39qAwL6EVODWFkf5kTozecHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSM6vECCvtOELB+3vIdxkhIw1q9UMz07MhfmfxGg1jY=;
 b=a1glP4FVDLt1KckKL4LFhAPTnebhosbpGTuOiFulnX3PQkBlMi1ed+OAn1F+sKyxlfic2OZ/DbeNT3LOVQQtNMxWBY75V3JkhDVI+u8z31yr/gJFTligNiWv7lQrQmgOdNeI4qv2ISgMDJMKaa824D3FLO6DCPf/CWjyey+awxPSlr8y7xLw622DTqZJsBS0tq43Sw3Nhq8FymIN0OVn8lDRwt9JDbQRv2BY/M0POFGZoP8nT5ipHG3ykkcMIGd3RB5Js2BaH3wiUnhvrTC+KegwaTFXU16TK6KeDUfvmXYVuaBDTeUpB/1+HThA1eoguYC+BX++ReD9J0KRbQDzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSM6vECCvtOELB+3vIdxkhIw1q9UMz07MhfmfxGg1jY=;
 b=RNHuABM2BKSkVJ0OoGNBve8BHJehiN/N5FFXsVPJxn0zj4BmuTxUf+psTuK0g9E7BUSHB26biFTRGZShTRv50Xs3qRgFfMRvDVjg96dQGwJGAp1Ll+aN5zK9nnFPTkKy7ebEAw/ukxUca9+O+zSqiqXlGb1h/xGvMNUgFdWH7hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 09:02:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::55cb:215b:389e:eced%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 09:02:02 +0000
Message-ID: <484ea84a-bc61-4014-b29a-9604fbe9d64b@amd.com>
Date: Fri, 8 Sep 2023 11:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amd/display: fix the white screen issue when >= 64GB
 DRAM
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908084639.113840-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230908084639.113840-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 831ad68f-6f1b-4093-6b03-08dbb04a444d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/RgStSoJGkcSfGehiEzpIje1xpenZaNC+Dcdz1MaRXEH2j2pgYv0Hu781vVKJ3lCFd+kLbndB7Igtd8nRKq69HZaPFW6y2+f94FCcZ4FY66cTsUVW/1FuPw3DX8LLJugoPFJNflbGlOFf3MisZ+rf+40ctsCmQ/6Mypu20FtiVBRfkt8T+iLoSoTSY6D3Iu0LvX831DNxFfbsrKBQCf9o8zLEYfHY5ADSXRoL9S7TJLrz3DVjJpaKOQhzUB6lpY/VWJZRcBkeGWW52umOxmeSCc+zwa0UtJ1SO6e5mSZvrSZA9bbvcaz/ZW5ETYdRZHBipj+7MLW8rzsfcj1NL3HQRxswqddU4eI/NmlCHM5CdBpnTcg24n3v24recVimMa2CiW2Q5+FdOlIdGgTcTHksYwNN91mmmx/taHJRC0u0T73jm1cn1jpcUiM4lUZRdOoYuExgbm75RO26+ZgjbpQ+phYggjmvg1/70ZakjxHKXTjrJ2ztmj4RFUnU6Fle9MBDKZN44q4/tPKudnLGL4DggDcRrL3HJFkyRgeFW9zLUWGXojIMl55iPGovCRLccwpNVLhS93tj0jUV1yRiytVhsnqy8sEY5b3lys++lMVUZxKKkfoqTmGDn763GRqST4I72O7JZVk6bI7et7WfWSGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(478600001)(6512007)(2906002)(316002)(83380400001)(2616005)(26005)(5660300002)(41300700001)(66476007)(66946007)(8676002)(4326008)(8936002)(66556008)(31696002)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0h2TmRnV0Nic291YjBla1NxdmxTNUFWejM5N1JBcWtIcHNLMkF4aEpQamN1?=
 =?utf-8?B?TTNkZnNidDZuNm0vZmEva1JKanpqczRNWnR5cXMvRkVJc0JucGxnUm5KVWYy?=
 =?utf-8?B?dkgrQWR1ejRnUEYrblFEbVhjb2pQZEZxRVA1SUdPM2lsRVBzQVpxdjMyVGx3?=
 =?utf-8?B?UktrSHZNN2ZwaXR4aC8zbVY2MmtmcXYxZ2dGenZMVHdiSVMycVFlNTl4QW1D?=
 =?utf-8?B?cDIvVCtycDhXemJTY3VzdW4vQ0h3SWYyR2VacVU2ZTZnb05FY3lqZlQ2ZXc5?=
 =?utf-8?B?d3JoMEo4UnM3K3FvMnpnUFRCb1FZMWs5QXlvZ01CVzRMWHRnRE5VTkNaTE9j?=
 =?utf-8?B?blB5UEo4QVk5T1ZRWGU2cDVGZXFocWt5SVdCSWtJYlI2OERpc0xxZjFvaXp2?=
 =?utf-8?B?cFZhWWY0MjI1UlN2QS9oZVpkRkJkWW80WDNvTGNDUFE1UVNBZ0ZYYldNdzZw?=
 =?utf-8?B?TzBzcVdBNHhxOEtNSVJ0bzVKeXh1MGxhMG1PSTJSbmxCbjc5R3ZUYm5NNmJL?=
 =?utf-8?B?cThVd251TUo3ajR1bExlWXlMaDduSjRUZTVLQnFOdHgxSW45ZW1YM0FmZmY0?=
 =?utf-8?B?dWNvSU13endTUlh0VUZpZlJDaTc2bE1kWURSV3lRa01OckVEQ0QvTlNrUE4x?=
 =?utf-8?B?ZTdPMnhYcXdhaVNPR0RLQnowalhsSmFpSjJsa1BMc0NmUVhkWG5vMzQrQjh2?=
 =?utf-8?B?SHlXclhVcTVYYmVtS2NudDVZbHBtT0JsM1duenlJM01nV3dMQ1BCbGF4VDFx?=
 =?utf-8?B?Q0kzMUlGLy81RllEYUR6RFQ1YVl1dFR3dzdtamZhWjdNL0o3TjdQY1RWSU1M?=
 =?utf-8?B?YUNPUTZZUU41SmRTMHpDTGlOdWsvNUpQMzYrNlJzS1l1SWI2NHdOY0I1czRS?=
 =?utf-8?B?Qk1mdzhvK0NzTFBTb2ozbnloSGNsUWt3aEJHTElqdVZTRHBtNDRycm5oendH?=
 =?utf-8?B?RVBhbGx6OG16Z3NGSEl0aElnaFZMYWdHQmt1ZUk2OGNTTHJ1cFJ2Q2xUamVP?=
 =?utf-8?B?aldYbVA1T2ZVckh4MnpmeEhwY29ENzBQbjFOV0trZkg5aVY2ZGpNYzdqQitp?=
 =?utf-8?B?U3YydjAvMlhqVlVPV25nenl2SUVsZ2VtWmVTQUJTTVhqbUNFajNqRXIvZjZL?=
 =?utf-8?B?VlpJRTZadHpWbjNwakhHYWs1QlBXcCtZcC8rTXlPcW9LLzM2M1VLbml6WjAx?=
 =?utf-8?B?a0IxSElIZzVlQ2FodFBUZmFCdEc1MGJwWDNvbjIzcXZ4U3UzeXVXdEw5QkFn?=
 =?utf-8?B?dTRUODlRaXhyN0VqY09sdjhlRDJxTmJKeXV6amxaU0RjRThnM0sxWXZxYzcw?=
 =?utf-8?B?OXliSUd1TEgvZFlmc29vRVVKSmMvSy91OU45bE56bTNmejhoT0RrbGN3Q2hL?=
 =?utf-8?B?WUdZRnZGL1NYWUFONWFiVHdqVzBFbUhnZUtIKzJSMmtFaGs0SFQ1ZUE5Nnpl?=
 =?utf-8?B?aFdJdHhycm91c1hOU3Z2YzZQM0M2dWtLa2FKM0Zzd0E0UVlCRno1YzVBRHdC?=
 =?utf-8?B?SE8wSThqKytBRjhrTjUzS1ByRnlZRk9aS0w1NUVYVFJReHZONTN5bkJ5Y3o2?=
 =?utf-8?B?MThpT2gwckJBdWdMa2ZjT0I1NE5IT21KcmRaMmdCS1Axd1pmWW5oZG1ZS0lG?=
 =?utf-8?B?ckFLZ2QwUGpaamhobVo0aXdyWXk0Tmt6MGJzeFNiRVFCNEdyUG1Qb0JqYzAx?=
 =?utf-8?B?REJFZmtwRXFHS2JPNlJwMFcrak4rRGY2eWVkSnptRnJxQi90bksxSWdnSzVY?=
 =?utf-8?B?T2l6Um4raWRnb0gzVzAvRHBvOWV2WUJzTXpYc2w3enI4cjV2RkEwMTVpcVNT?=
 =?utf-8?B?YXp5OFRpK2NPL0JHQlFtTXRKZlVqZEFpTXhQdTJnSHVJMFd1b3ZRSldORWRH?=
 =?utf-8?B?WklKNWQ4cEk4VzBEcGQ4VVpRRFozOVFGS0djY2lFYWwrcXBBVGdadnF2OHRa?=
 =?utf-8?B?Y1V6Q3hZZS9yaXVBSEIwUUNzeCtGQVVJRTZoU3l2ZC9aU0JBRHgvNStsci9y?=
 =?utf-8?B?RlM0QTV2OXAvQXN0V3Fvb0lwc0hCZHdxZUthSVZ3VlJzdWJIUmxRT1dDQnRH?=
 =?utf-8?B?eVJHVnhNYXpKeTBPNFpjYXM5Wi9VTzUwbE9TVEdnOTVOLzg4Z0plV21WQ1h6?=
 =?utf-8?Q?ql8wH134ma4SQ+iwZjlvRY5D3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831ad68f-6f1b-4093-6b03-08dbb04a444d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:02:02.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4nakXh6ngKNl9nmFUk2abg0bYvG2QFWS4SHUFNdVkv3FGpktaXm/TCmfOKPDQlJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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
Cc: Alexander.Deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.09.23 um 10:46 schrieb Yifan Zhang:
> dropping bit 31:4 of paget table base is wrong, it makes page table
> base points to wrong address if phys addr is beyond 64GB; dropping
> page_table_start/end bit 31:4 is unnecessary since dcn20_vmid_setup
> will do that.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Good catch, one nit pick below.

With out without that Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1bb1a394f55f..f8bf04fcceac 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1283,11 +1283,11 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   
>   	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>   
> -	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
> +	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44);
>   	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
> -	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
> +	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44);
>   	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);

While at it you might want to change those to use AMDGPU_GPU_PAGE_SHIFT 
and the lower_32_bits() and upper_32_bits() functions instead.

Something like:

page_table_end.high_part = upper_32_bits(adev->gmc.gart_end >> 
AMDGPU_GPU_PAGE_SHIFT);
page_table_end.low_part = lower_32_bits(adev->gmc.gart_end >> 
AMDGPU_GPU_PAGE_SHIFT);

Not a must have, but might be a bit cleaner.

Regards,
Christian.

> -	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
> +	page_table_base.high_part = upper_32_bits(pt_base);
>   	page_table_base.low_part = lower_32_bits(pt_base);
>   
>   	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;

