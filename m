Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165FCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 13:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965CD6E220;
	Tue, 30 Nov 2021 13:48:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0802B6E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 13:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYsEkbSp+UmZVvDZsi9REezMGoE4K/0Smo/N8UJhwkNlJNpJQC2796cRKb8O6a/j9vLim0QWWQpCxyiAc+IYmxqTvgqVAFK3A0y7g7b7GWydFwAZ0tbiNnNhIM99yYvsSwk9APdS1Xc0MzRd+ARGI+sJ6IBBSB9Y/QTwMAkoJtPZfmSXTbW6gvSpJc1DK7BiaSmNGTGGpuPMS2ptX2tdvLdSCxxrPECg0zKmbudRen+ex2JUrtBHYvD7I1TL3WgbbcLxrndL/QcGyv7ROQOUN4iX5Kxk/OiPQ+AaZCh78O6eBZRStDvzmpaxaKpyYGnJLxkGjDuKOSv+hhS/S+S/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjCNURioSKHq1qyOC45Jx7Qs/QuHJYpxF6ycWqEJn1M=;
 b=mTi7BcNFnnYpjANBCeIqhrrzcVy52r/VjgpG1t2JoHR4yEKOfbv7pepax7NX8TT0MNUI7eA4ZJnUi1Wk5K7bLOVYvBbiwJkt3ZleVo/zkuiwVKBoKazkAjEpKdt2S5vz70kg2L4f7p2mVGhsW0hfbn7HCwzgmLfbhI8D7r56gka5r9REn2avmaQJrZ+VyTQWrwjRAOLEMIhaqnp3AXJ8MsJ+vrNswdSCev9w0bwu0oPbiEXgkoPJC8etrxd3Mqk3sMoDigrd+BCdrZJNitjdicssgo/U/9me/dB4Lv9LGCtEQaEgObSvOIdvRailNdeKIjvkXKGYrUfs+4pfOIe43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjCNURioSKHq1qyOC45Jx7Qs/QuHJYpxF6ycWqEJn1M=;
 b=t+nbWFz4GafN9zaLEWvYOjfkdOMquxuSAuSTs3JV1F6xOceS/KNABxnWOq3VriahhFH6sYRUMTwYG68hWjPg2e1tq71H2mVbYaaCJgowMJ5Hc6SnTZzJPiilZRxkCOqzCPMSK1sbSt/JyjoDGJxsZi9lMwFcZESaj8r8fgNS2qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 13:48:29 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 13:48:29 +0000
Message-ID: <7405f5fb-1d74-40e1-0d1e-3b5f38c3597c@amd.com>
Date: Tue, 30 Nov 2021 19:18:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-12-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-12-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 30 Nov 2021 13:48:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 185264dd-09cd-4541-2352-08d9b40816b6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46190A7493DAFF7BD39DC70397679@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/j8qNFSAZ54J/JxUjulFkgGRBZCsat5lYxYSfjULFkBlssIbqrEUnHL8ZupLy0PbEGA1Y4VsNvRdDVsvlGDQqVVaGvcp8Nqp2svYjnQNLaB93MC/UYBJCxl7qYOOkalURN2TvwRXKcebCfXRxccsI7aGCU5tsLlTDlixGoIrQJ3YXlAgPfwWgELGQ6eg6ykjGyjOLyEc0TUYvg4ympLfySzagYTYHz5ir/4BG5cCrAahJUnFJDrbdBFYAyqFNkl7l/jvYAj77IYZnSvnOsF1JcNlutlueHmckIzG3CcdsVPSRA9ho3U5ln29iXBtPK8T9hMRS1qQZA8Ka2cEWyLvD6gm45G6GdjZnj/3Q1Ao6XMzwttPebMrGG+sQ3me+R4xiKrIucBUAm8095LzfBZj+GhTC5nqGVQQCr2wRlAOjCh822MaqSqfN7tgn2iHJO2zr/pCXWctRg54GC8ACQMbb2KVD5alAGBfJQto732hg61kN0Bn2govubcRd/9/7UIRHarFG7F2Oz9T1OwoQhR6tEr2g9A5QGp4VZGDRAC1pT8JVOO37ZLbKMPNg1JLegI0ivGBEBH5yBf12bq0i5OzVpZjPABL5NLMYC5y5Mg0kAWLMfAu3zbeSP51S6qbbrDVtE8cSiLCAlTZvfbNs3wlMn7zE24JB039OHq42TTFa+PpBLeCoNVXHx7WUpa+nBuzjKDKxuA62Ah3zqskrAt6ncqhMQbCfNQJuKAgQYK1xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(36756003)(83380400001)(16576012)(4326008)(38100700002)(2906002)(26005)(508600001)(186003)(8936002)(53546011)(66556008)(31686004)(31696002)(8676002)(66946007)(6666004)(86362001)(2616005)(5660300002)(6486002)(66476007)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1N0ekVrdGJJR1I2MXpUcjVtK1laYXNVbXIrQVpURzB6c1o0enQ4TXJjaFNQ?=
 =?utf-8?B?eGxPdFQ1RktvOVFVaUJabnkrWjRXN0NreE5JVFFHc3cvTnl0THU4L211OTF0?=
 =?utf-8?B?b3g3VmdGUWRENlJYdHRCakZXMC9rVzBYaDUxY0pLb1ZPTFhZVGJVVUt3WFMw?=
 =?utf-8?B?Vmx4Z3U5bkthalF5VkNnVUFPVHhWbisvR3daeFhLaURjMHVENE9EOEtMV1NS?=
 =?utf-8?B?eXJVVTgvcjV1bko3d0N5NngxbHkwMHZqYUhNa2RRbnhNYlNqcExERXF0ck5B?=
 =?utf-8?B?WWM1ZUZxZ2cwVFN0YzFvM0xrM2tRdDJqcGhDYWZlZ0tSSXpwb2dsWC9aVjY4?=
 =?utf-8?B?MDBBekJQNlF4WXRVYVBTQUlzaWRtMkNJaEZ0REdqbXYxeHJCVi8wT2lNSG5Z?=
 =?utf-8?B?bzZTSXhXT1JrWG52NC9KZ2dmUHJTSWs3YWMrWjZRZlVsajVxQkRBcTN6Z3U0?=
 =?utf-8?B?a0t0Y3BwNHdFOThwQnBlZDlnSVUzZkExZis4YnpQYm1jWHgxeVBGTGcrV0Vu?=
 =?utf-8?B?NkhqUTFYb2Jrcnh0c2g3VytEL0lpTitzVy9odUZsWUhQQmExeEVLdG5CdlQz?=
 =?utf-8?B?eTVxT3IrbmpoZk5LQ0YzSXRBMWhCZ3NvL3BiTCtjVmNlalBWSTFVckw5UWhM?=
 =?utf-8?B?RkdFM1VnL0p2WGZLblphcm44SnFZQzRqcGszZFRoZWRFNk5HVzArWVV4cFBB?=
 =?utf-8?B?aWlqM1VnTDZLeVZnb1FxVEZzWDVWY2tET2RraEhFbTcrS3c3aXdNOHVGczhu?=
 =?utf-8?B?VnovaWJWa2l6WklkZ0kwZ0VyOVk3R1dtSFNCelI1REJFVHFJQ2hkdlFDdzha?=
 =?utf-8?B?UVVFVkt5M1g4M2U2cUxRWXZibGJ6YXE3Um96ekptejVUVzVZNUhGb0dXU1hp?=
 =?utf-8?B?NjZpRC92OVl0ZmtKQ20rdnk2bUFidWpvOS8wV09WWDhBdWdJbHVKTjI3MUc2?=
 =?utf-8?B?TTBlTlJMSnN4RWkzRTdNUmJOVC9lbjRxNTJFa3h2ODRqZFZqdlpCaW05b1Bu?=
 =?utf-8?B?TEFBYlBlL1pPZmVOd0VnNXZ6VmdwZjhYZlBLbWZoeEJORkdWSk5mSitLZzVr?=
 =?utf-8?B?RkFjVGRONC8vVE4yWllZLzd2cHluSWtjeWRpNEdPdytsK0NPMXlpT2w1cjBM?=
 =?utf-8?B?Tm5jSHEwdnJSZmpjV2lGMmJSSEhBRXJablJBTUw2MzFDSGZyeGliRmdzTDZ6?=
 =?utf-8?B?WE4vRVcxYmkwanJycTNERUYrakZEL2t2Qjk2S0lxczRQKy9kdU5LSEdzOWNi?=
 =?utf-8?B?STVyRUNaUThxQjBHckFsYUY2OGNCdmpDQVJDakZtZXRPKzJGWmpBbmxOZUVa?=
 =?utf-8?B?clllY2hEM3pVUkErNFVkb0FtREtrLytTTUZLZzdxeEtDU2Nlem1tLzJZOVdt?=
 =?utf-8?B?elgyZmJwWFc0U0lXKzdVUlBTNUE2RXVxeUl6alNhQ2QzY0RrVGNNYWMvSFRF?=
 =?utf-8?B?WGFoSnJyc1FHTWRSUmZqU1paMnozdlUxSkxGOTB6cVRBVFZSelZhakZuOGVO?=
 =?utf-8?B?SVAyL0pPVUpsaHliL1V1RGNyMEpGZ3kvK2dMdUJId1BhNjgvL2xOTWRUNS81?=
 =?utf-8?B?MlZMYnB6cXpFdWxsdWcwa2hLRWVLeUx5UHpmQlpMdTIwRkl3Z0RYVUNwL3N0?=
 =?utf-8?B?RVZhTUtwSERYTUh1M2xCRUFPZTllYUhrWW9yamkwbTdDdUdsb2pJZmh1U3cy?=
 =?utf-8?B?b2gxQmlMN0NYWFNTZnZ3cndQZTdHN29ucTNXdS9vdVl2Mm9RNmQwYXVMM2hp?=
 =?utf-8?B?amxMczkzOVozaC96aG9VY3ozWjVDVHBEVTVnTWc1eEVnVXRzbGFvcXFUSFU4?=
 =?utf-8?B?TEVyYjNWM28zdTU2d2NjZE5EbG0xaHpDTEVuTXRORkw4dHNpTjBVakdTMEFa?=
 =?utf-8?B?NlNsOXJIQ1cvOG1jb0dhR0lITHJoeXBNNG5BZlpjYXBlazA4YW54cUlxMU5u?=
 =?utf-8?B?ZjhnWmlra3JHZU1hSldYVjF3dkNTYVJJS3hsS1EzcjZrclVtb1NoTWo1a0to?=
 =?utf-8?B?Q2ROdHAzNTlUQlV1VGwxcThZRFAvenY2REh2eVJDK3BXVm5hZk8xOTdDSEJV?=
 =?utf-8?B?ZGRNNG9ScXh1Wk5BR21TektaaGtadUZHY1NUWVZESEhmYmR2RnQ0aURHYmlS?=
 =?utf-8?Q?H5g4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185264dd-09cd-4541-2352-08d9b40816b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 13:48:28.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLAVI1vLd9lDAESTa/iWohqsZuqPIK0AyoPtEZIJR385OoNVI2ARKkVEB6LjU/WS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2021 1:12 PM, Evan Quan wrote:
> We should avoid having multi-function APIs. It should be up to the caller
> to determine when or whether to call amdgpu_dpm_dispatch_task().
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I78ec4eb8ceb6e526a4734113d213d15a5fbaa8a4
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 18 ++----------------
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 26 ++++++++++++++++++++++++--
>   2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c6299e406848..8f0ae58f4292 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -558,8 +558,6 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>   				enum amd_pm_state_type state)
>   {
>   	adev->pm.dpm.user_state = state;
> -
> -	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
>   }
>   
>   enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> @@ -727,13 +725,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (!pp_funcs->set_sclk_od)
>   		return -EOPNOTSUPP;
>   
> -	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
> -
> -	amdgpu_dpm_dispatch_task(adev,
> -				 AMD_PP_TASK_READJUST_POWER_STATE,
> -				 NULL);
> -
> -	return 0;
> +	return pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
>   }
>   
>   int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
> @@ -753,13 +745,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
>   	if (!pp_funcs->set_mclk_od)
>   		return -EOPNOTSUPP;
>   
> -	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
> -
> -	amdgpu_dpm_dispatch_task(adev,
> -				 AMD_PP_TASK_READJUST_POWER_STATE,
> -				 NULL);
> -
> -	return 0;
> +	return pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
>   }
>   
>   int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index fa2f4e11e94e..89e1134d660f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -187,6 +187,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   
>   	amdgpu_dpm_set_power_state(adev, state);
>   
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_ENABLE_USER_STATE,
> +				 &state);
> +

This is just the opposite of what has been done so far. The idea is to 
keep the logic inside dpm_* calls and not to keep the logic in 
amdgpu_pm. This does the reverse. I guess this patch can be dropped.

Thanks,
Lijo

>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
>   
> @@ -1278,7 +1282,16 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
> +	ret = amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
> +	if (ret) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> @@ -1340,7 +1353,16 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   		return ret;
>   	}
>   
> -	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> +	ret = amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
> +	if (ret) {
> +		pm_runtime_mark_last_busy(ddev->dev);
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	amdgpu_dpm_dispatch_task(adev,
> +				 AMD_PP_TASK_READJUST_POWER_STATE,
> +				 NULL);
>   
>   	pm_runtime_mark_last_busy(ddev->dev);
>   	pm_runtime_put_autosuspend(ddev->dev);
> 
