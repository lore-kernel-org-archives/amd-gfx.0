Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E33C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 13:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0456610E821;
	Wed, 28 Sep 2022 13:52:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E46E10E81E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 13:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmK73tPyCY2l/q5yn1kq+zQAYuSh589k3ht3oJqiCBn5lfIuXbRhDc9v4rz2NYxsSEcIkWAJ+YrlArnNw9JXua2nRydVbovozlr93TEDnB6dUwOavDvfHwqYPGnqCEsc9pPoqLcQ3O9fR9rAkwvAnTwQq/qQC2RUAxr/POZ+CdCZ9e4xc9qwex6LebCK/M6R56ud7Ir7qTDR/QL2zZkvG8GbfvUzvi9/YuOwmTO3H5vZD93D9w65ax7sfpm0/Bisv5OQ5NbRx4Rnx2Te4xfSYIP6jYtHhj0Tnc3kc1DaLrsrkaWaqs8zTwAoQ1CGz0LZPe8aVcDjPUybqGosVLq/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aih9sb6Sdr+bhu/8Xw7biKQIUMAQRl/Bd2U/Ko4kxag=;
 b=RpL9IzwQys1K05TH1XnZsNbqxF2HeVKy09OWNkRLD9hyR8d0cU3YMTpfDvWo/R1q2XkYK9BrpzXyJXVXcCxyp7HVlHZXIBwK9T/A1YH/epr4KfTU1Mjx/1kResBbJidkbJ8243B9GsSTZ4/bTyX9WARqtzjJ0z/MAmEc7VGb8P5mTcdwZlLGHU0S2aEzX6ZSHZileaTobgsg2C43Hd3nOGdJ1gFoiWBWLRdE3YhMiGf9hwnISvLOMDOHE7lMdUemSkaz3hq36ErAH1FNEUOtOyV9pFxiHRg+OqMqOjXLgbaBnMA//OSxsO/piJgU/4az0Hs/FV6OojGoPkQmYzbHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aih9sb6Sdr+bhu/8Xw7biKQIUMAQRl/Bd2U/Ko4kxag=;
 b=tzeelsNCyWKyCZEuaYRF8/guGJIL+bY5B157f9gnoy77BkBJ2gKESl3GoFT/1gs2kxdmZBRWsfKFxq0YL9sj4EVBE9TGFDt1PY93cUv7g9MO6zrA+Kl7mydb8Wb6aQwxxMXLwdbRBaW/f4GLZFeLpfK5R/jWRSVJLR+b0VOWGLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 13:52:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9033:772f:1339:75f6%4]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 13:52:34 +0000
Message-ID: <fc7a63b3-9a45-d19f-3689-44ebc41aeb76@amd.com>
Date: Wed, 28 Sep 2022 09:52:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amd/display: Prevent OTG shutdown during PSR SU
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220927231339.187788-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220927231339.187788-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9e4c6d-73ec-46a7-965c-08daa158b226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Qnw1a0jMbc+mI0ZuM6mKJpHz4Ih7PJV8BnzHIYmSOM9GuMpTyfQ+49bzIC1ueMs4lZOKt5kBnz/AHDDx6pFdl0EgUCs5iF+5ZD408jx7+DGp52okaoSmJUogoGO+hvtTARNF+Q5NUr3Ncb+0c45w5Uz4McRPZiHCG5LDyKo312yYukNXRRhpmJnbX03E3L55ASN0hKOvDbx0cBSQYpZWNVNg0VTeSdZeUyqR39BHJb16/YwqRhFVls67fBeCH4HY5cI9XFxOvv3GmQRa7X7zIpoUh8CeuzYl6agO/TvXnqQi9PHUtHPy6VsSEvHDGNs3DBvO+PD1tqkgSf4SY48XOBIHwXwVbV2mwHz3mrrZo7g9uOyTAvA3NtE9eOu1rB1vom83aZZ65wnG58KwQ74I9m9aRGeOu16pB7L86ov/dIx6alRXcC9o+HUh16veXf1mAUVk6Kn0HPLLQF8SW91zftCYZUhb9Wg6unjEUVUcy9v6BMWREys2BJnfHjXEKJwNVDBnI7yB5O66MTELoy0kMQ9UoIYdWvsF1XhbE8crE2APr65ZutkfDYuqgTxKLOVs5PVFbX06htSmpXVxhATgfgh3o/qbDS39kUYQ4Khg/EYPsTRUJLct7bYY8KPUAjSLWNGbKn8sl2sQRUrbSD1I9hJAW7z+z9F+wZXljtsAE2Jb7extp89h1Ggf4Y6UVQBMRPwTl9hkIGzg0riYy4sI3thE48mqi6yGAfiAb0v/ojBhUymPP27Dmoo1FWYJJO7snoC/7vLJ5nB9ilfhR6YfUMjrSV2Ad+sqzruTQc91v8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(83380400001)(31686004)(86362001)(38100700002)(31696002)(36756003)(66476007)(2906002)(44832011)(6512007)(8936002)(66946007)(5660300002)(66556008)(4326008)(8676002)(53546011)(2616005)(6506007)(316002)(41300700001)(186003)(478600001)(6486002)(26005)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektFM08vOURjNEJ0TDI5T0lzWDN4SXF3TTNKd0VPeGR1bDliZFVoeEtBN0lv?=
 =?utf-8?B?WnpxNDdoeTFTcExadE56THZMdFZOZjhIanJWNWtrVi9mbVJUbXpDcndXOEVq?=
 =?utf-8?B?TGlzVGZsMEw3SHU4R1JmWGdNcDZEekJIRDg3dGRvOVJpZ2JLNnhYUmZRamUw?=
 =?utf-8?B?dmFaMm5kWUJ0a3ViUVlGTFlzSkY2OUZEYytUbHk3bWVhWjlua0lyR2w0NEVD?=
 =?utf-8?B?Q0I5NVRsSGRKZFN1a256eE9ISzJxdDBpdzJvWCszQXlqNXJrREhDQk8ya0lY?=
 =?utf-8?B?TUp1ZkUwQmtJaEpjZi8za0tjbnFCYXd4V3dGdkJhem9DV0ZZVHF5QzBKdmRJ?=
 =?utf-8?B?d2FNWnpFT2JydC9uZ0tUR3JBWS9PRmxEV2VQKzRxQnJ6T0NsVklaQThSZnJ6?=
 =?utf-8?B?UG5uS3MvT2FRNVZtQkR0RVdXT3RLVU43a1VOQnArcG9JUkVqVFE3VC9NNVBv?=
 =?utf-8?B?amtad2I2ZkJBUTI2SVJoUzRmK1ZVRUVQaWNTWnp4dnpnUjFjdjl3azBXRUZD?=
 =?utf-8?B?dUFScVo5czF6K2RxWERFOTZOTjRNQzd1NmZiZ0FJVE9tajRiTFVrN3pYQUhF?=
 =?utf-8?B?Tmk5VXZaZXg1bms4VlpTOFc3ajNneGxzMldUMHZIYzhEeTVZUmhSK1ZRMXBj?=
 =?utf-8?B?c3FFRWV2K1JXdFZmSmIrbDREYTcxb2xTd1RqUWx4dzdkZG1VdzBTbnQxc1RQ?=
 =?utf-8?B?SUpHdFJlbHpldHBzQWNla3p2NUFFV29BdExhbUJlTnJaOG9EMS9OKzFhZFdn?=
 =?utf-8?B?T3E1MjF5NGpZaHdjVmR1Tlp4RVRCeWZqWStGM29LMVhZUXFBT1gyNmFEUWc0?=
 =?utf-8?B?bTFjZEI4d0s0WWwrYVZMdjZ6bHRxS1o1dk4xbmJGV1NSOWc1OEMxNmRObENY?=
 =?utf-8?B?OXhzR1hVR0JYdi9jN1cxU0pKcUJrTEJyc25zaFhBQU14L1dUNGtoU3RmUUhB?=
 =?utf-8?B?bEx0Mzg4eVV0QUlnK3dmaEhWN0FEVmdtd29zZlFzWmxqR29sYjB6ZHlNTnJp?=
 =?utf-8?B?aW52dEJGTW5NVG15NVVwbTFjZTZ3NFF3Wko4ZVhFbVVWaVYxZHg3VkFHWW0w?=
 =?utf-8?B?aFF3UFN0azJlaGZjamtyZmhGNlpyb2hxaEFmNFRRTzZaaHloYVhYS0p4NGM3?=
 =?utf-8?B?a21XRjluNElTaFl1RXoxbWg1NmhCNkpvMUNicVJQRkRNYlE5UU1ucklZQ0d1?=
 =?utf-8?B?bXl5T1BNeDBMSENrc01rQ01VMGtMYWFOcjI3SWQ5SlJFY1U4TzcxSXFBN1p5?=
 =?utf-8?B?RkVRMTNzNzFFYjdUT0lNTDV2bmRiK01xQmhjTWJoY0NnRDdJMWRhN1JUVi94?=
 =?utf-8?B?RS9KS0xxUmlZTXo2WlJsRlkyblFyRDN6TTF3UU9Ca3habWNZZ0pZYy9Sc1No?=
 =?utf-8?B?VHROckZsaFRLMys5Q3Z1UXkvc3FtOWJrWmdadkhMNUJ6YmFTU1A1RE1zdzFB?=
 =?utf-8?B?SE1YVmlVNGdZWWtDK28zZGRpQWxxQjA1dldTQkdpNStyK21nQ3NaRnEyZFFW?=
 =?utf-8?B?ek14WGNYNUxiVlE5TGU5ZTdxT3pySll3cUhvZ3pUbnVEUzU0bHNkQm1GVFNQ?=
 =?utf-8?B?VzBRZTJBWXg2eUxocGFrYk5JaEQ0dXhhakVDTjl2L2V2amtvcmZ3eTNkTS95?=
 =?utf-8?B?T3AvNVBlOERCaU4xM1FjQ1ZwWlJKWk03ZnVsQkZzbyt2RHlaaFgydEwzZUFK?=
 =?utf-8?B?NmIyVDBUYmQ2RlFqeUFVbUdkaDBHb1B1UmpGMVhrMENyMCt4RlVSSUMxbjJY?=
 =?utf-8?B?eTAza1pGLzlkZ0NCNDN3T1h4bXNrVG1JZFphSUo5SHVBN211YUY5Z1B3Szho?=
 =?utf-8?B?SE00T2R0ZUt4YmpFcWxRV1Q2aStSSHdkZDN0bktkcldzLzRVOXFabFY4aEYr?=
 =?utf-8?B?aHlmRnd0ZXpGNmZkQlAvSVJFN3NFZ3F4RnpDWlBZcVF3K05RaFpNVXpMNFZl?=
 =?utf-8?B?WEpuM3NkVXhqVFBlUzdaa1JJMHZ4MU96aHBXbTZwTGV4Z1hrdlEycGRBUTE0?=
 =?utf-8?B?dFlreFlOZ0lReCtNZ0xHYXFSb3dQV01QSnozUmhyUHU3d1N2bHNTc2xrRUxx?=
 =?utf-8?B?YTd6N1NacFdYaURHODNrYnZDY1BjY3BjemlkVHlLeW5GMmdkTHRnUUI3Q1ky?=
 =?utf-8?Q?uxrghRIRHh27Sd0BknuG8WQTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9e4c6d-73ec-46a7-965c-08daa158b226
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 13:52:34.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pTI9fAI6K6T5E/0Oo6Sc7wF3BpeQOuKleo9WJ+f1jgl1yzSS2OfbnEH2M1Gvt0Ws5VrEHmDKxm8YT513iotWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 regressions@lists.linux.dev, git@augustwikerfors.se
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-27 19:13, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
> link-off. This theoretically saves power by putting more of the display
> hardware to sleep. However, we observe that with PSR SU, it causes
> visual artifacts, higher power usage, and potential system hang.
> 
> This is partly due to an odd behavior with the VStartup interrupt used
> to signal DRM vblank events. If the OTG is toggled on/off during a PSR
> link on/off cycle, the vstartup interrupt fires twice in quick
> succession. This generates incorrectly timed vblank events.
> Additionally, it can cause cursor updates to generate visual artifacts.
> 
> Note that this is not observed with PSR1 since PSR is fully disabled
> when there are vblank event requestors. Cursor updates are also
> artifact-free, likely because there are no selectively-updated (SU)
> frames that can generate artifacts.
> 
> [How]
> 
> A potential solution is to disable z10 idle optimizations only when fast
> updates (flips & cursor updates) are committed. A mechanism to do so
> would require some thoughtful design. Let's just disable idle
> optimizations for PSR2 for now.
> 

Great writeup. Wish every bugfix came with details like this.

> Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

With Thorsten's comments addressed this is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index c8da18e45b0e..8ca10ab3dfc1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -170,7 +170,13 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
>  					   &stream, 1,
>  					   &params);
>  
> -	power_opt |= psr_power_opt_z10_static_screen;
> +	/*
> +	 * Only enable static-screen optimizations for PSR1. For PSR SU, this
> +	 * causes vstartup interrupt issues, used by amdgpu_dm to send vblank
> +	 * events.
> +	 */
> +	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
> +		power_opt |= psr_power_opt_z10_static_screen;
>  
>  	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
>  }

