Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11698C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 09:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39E4112EA0;
	Tue, 30 Jan 2024 09:26:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13E7112EA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 09:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1SewhImZlkjr17yBUkGK2ja0q+LtIBXK1njH/dJKqqTr8Ohf3Rl1J0Z39KorBLS/xyiKQ3uYDX7XNJ+5AgQ9Gl0jrmWadR4Jr/GBBSEpVodJ0VtJUH1OJvjrsX9YHB9HWTTgkXQA7GOW6qcHpH9/K86v8hmTmJudB3AFn6yyCfywfYUoSdWMj4iYRD6Q5vvFXospaAt5MzKrbwyfvkP0xikiqgHhfzn4VHm1vKDTwDdXDFIaQH1BYqiFbS07E7KGMpx3RMiOsAfUsurWnoJPnnOkSJ8V6gPdSyOEKSYs1C7Bq2z5ihJmxWzKQ8b7NYRR+gLqgajmY8JTO5igIJadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mba9YtOLI8VFTHKb3hmRHLoTU5dcL20jC9xNncP8uHY=;
 b=kqDFrKEDEi35O3aRA+JlEHSCtc3j1S9IHBYDIu+XOQLp89ZYrRMkA2nuaVFSHOTNf/G01zHYAOtr2V3Rt+O8AjARKFhOg51peCjVZMb5OmOO4AD35jNQF3vTociC3MO38/YNJs8G0ebcc0dm8zm3mLhugq07O2O5zDgqhR1ddHHLl3P0ydbnNU2fhPW49djflNk9feKmrQocjJemu+BCYSMtRco0Mtm0Di/r7Te0wJl8q4U2WGgoog/5tEv9Xr7ZiPFrgwxfwHgyFMsuaNDnRLqxGURE1SaSbJ4/8+650qRnQs/3qAqyiObn8OWQ/LF3WCXAf6dSwA57hhbTGxjGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mba9YtOLI8VFTHKb3hmRHLoTU5dcL20jC9xNncP8uHY=;
 b=PwflnZe5xJLdK6hvbFUP4uSXj71YNO4Og4pqHyWFUNFLRDmELTq9mVyzBGaoDl7eOHpY0GA5qu6ba7H6ZzYiuWgtkw2ENnG7PaenNo6NZFTsMZlncDO2XNUSs3zpQG86a1vfyfT9QVEbLRkhvzHaeOeD1tz6ImSQ7Ef91XNRxo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 09:26:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 09:26:27 +0000
Message-ID: <55233541-f4bc-481c-b6d6-690ab33bf5c9@amd.com>
Date: Tue, 30 Jan 2024 10:26:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix missing error code in
 'gmc_v6/7/8/9_0_hw_init()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240130082101.397532-1-srinivasan.shanmugam@amd.com>
 <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240130082727.399314-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 7affcf68-a433-4202-be2d-08dc217588c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzdNHX/PrFW+GVUyUAt+HbuCa5xnc2yz35G8UqkfrEfcEJ+cvBvhxx5WyPa935V0Q8+1QyERSuiIlw/vogWPAQsRcc70aX6/y8MA+4VuZlMjlwFSdWVlk0bJWIPvG5szf+JEoGqGNOeD/qmpBUMi6nWqlYT6c8tGF2wO8gbb97kjCMXPowYqh+zx39V4a3NxpeapUaCRn4r82yHNGfB9/bAJ39bpMx1efZ2RE28m+sfxRq3ufIRFwPl/YHOUwx0B7dDgq8ZMmfl8tCI80/xkGr45LU6zlDgWxLi+2VqaNNAM2YXwJBEeRFc+tQK/FP1FQj9UlyiYoY4R2+t/zGl4REPQtoPm/GhS/9Zm16JlnEDa7+e5cdwfj8FVUQBPHjDb7XdHuGJs6igv3MZ6h2Pq8e1RI9seKIOPryHt0srcDx81Eqx04Zzpk4K0z6CF6tUDu+cwFky+qD1HKG2uv1sEs0Ip+cUw5o77W7IVIcXc/Erx3ohAJ5S2sGFppYHSowT2gZgyyVgHMEGoJjvxj8UA4b3JbmRrxZXC3Zw18T99kK6vvh07dh2Oabn+xZtqEAhQyB6Ep29ZCRC2QWFGUk9HLFPSdfMwr8oyadH5IqoFEzLahWOiB9jNv8muKP0T4SWf1xJhR1Zkyl3qixAuo9I+zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(6666004)(6506007)(6512007)(2616005)(38100700002)(86362001)(31696002)(36756003)(6486002)(478600001)(4326008)(2906002)(41300700001)(83380400001)(5660300002)(110136005)(66476007)(66556008)(6636002)(8676002)(316002)(8936002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1LcDIraHNwakhDamMvMVBwdHdycVg2TUlEMkdKc1E5Zm9reHNUNjlmdlY0?=
 =?utf-8?B?RDdBQUUrVkx0NVBralBDckJaOEIzZ3RNSnlsVXBCYzJiOG45Z3hnNjJ1Yy9L?=
 =?utf-8?B?L2NJdmtDclg3bEx1VHg0QnBpWm5xWmp4R3l0dmtmQ3J0aUJNM1pWek1Jcko3?=
 =?utf-8?B?UExVUVZWMnpzaGIzdWEwZTE5cjM5RnFsYUE5Q2VJQXhRUjNDRjBnV3l6OEdJ?=
 =?utf-8?B?emxiLzMwZ0xTYTI4U25HWjBqTEFFV0hCUVQ2bXNxNm04Ulo2d1pwVm9aN1lx?=
 =?utf-8?B?VEJnRXlGaHZFbVcyelJpNmVjTkQ3RUxVeTlPdHJMdjNiYlRrVmdTQUEzNmll?=
 =?utf-8?B?eGFwS2xRaS90ZEtFVlA2ckFjMmxtc1dRdW5PYXAwaHdML3hYL1BvRnM4L3Qx?=
 =?utf-8?B?Nmx1bTVSZ2NVMU1KSSs3d296VUc4YmRYdXA2TVEyNGRnYzJmcmFRY2xibUlX?=
 =?utf-8?B?MWtnSlpoRjRwbXVzUU9PVE1MdmQwZStsUkkwdGs1WHhGU1N3TkhxTnVSaDly?=
 =?utf-8?B?UkRFQkg0YXFVY1ZRbHQ2dVVuZFRSeXRuR2tvWEpFZlFPZWZHamM3Kzd2Rjd6?=
 =?utf-8?B?d2F0L3p3NU4zZEhleDNvdzR5QVhzMDlSWG1OZWJ1TGZ1T2dnU2ExazFZTkNK?=
 =?utf-8?B?UFZrT0FKdHBKQ3RoZ1dlVUxZejdiV1lwVTl1KzRTMS9TRjhndUhTSVpITHpW?=
 =?utf-8?B?WFBDQnJIdWtqWmlTY2I2RGxYVkpiN2ozeWpFeHpNRm1rQUx2eW1wZjZqZE1U?=
 =?utf-8?B?YStxSXlnN3VCUnBROVowbFNoVUJmbEFKelZySlRmTTBOL3l0S0U4ZDhHaUNP?=
 =?utf-8?B?akc5R2hnTWhXYzBTQVM2R1pJejhBdnUwMDFoNEZickJuNUpsWXQ5N1FmbCti?=
 =?utf-8?B?WFo4MWJRdzJWRVZoalQrbVA4bno1djBmMGR0LzlZM2prMmV4bVBzUkkwMjN2?=
 =?utf-8?B?M1lNZVNxb1lEQXRIc1h6MFVnU2dPNGE4VjFKY2pHdG1RUDVlWHB3ZU9UUzRV?=
 =?utf-8?B?THZkakNhMzZXcUNWV0lWSklkcEVwazZJRDJGS3RPYWdSbmYzOUpQdnpaODFm?=
 =?utf-8?B?Y3BvT2NQcjZOWUwxSG05aVB6UG4vYWdMRjRLSzJCVDhqTkdGWHdMZ0dCdU9a?=
 =?utf-8?B?cTRnMnM5UXB2dmNvVTNZdjc0eXVtSHF1cGNlOTlzbGZWd3YvMlFRZVZjT3h2?=
 =?utf-8?B?MnEzbll3YW9TQnhiaUF2WDh5NjBpdWxlNkxpQTV1eWlKeXNxVjhKWllYNm03?=
 =?utf-8?B?NUJpVUs5aGFiU3htKytLMzdwMHdMSGQzVE5kRy9YaTU5RkM4VDBtaHIxM0FB?=
 =?utf-8?B?M0RYWjdNNEtwT0ZuNnhza0llY1hmQU5jdkt2Q2VsNi8rV2trUHNDVVlTeTZX?=
 =?utf-8?B?MDkyU1NSQkNvRHRrV3ZHK2RXK3RxTUJ4UFpzUC9McGtGODVjY1ZxOG9WaDBt?=
 =?utf-8?B?REJXZ01qWHIxcldXTUFacjBJdGNoTVBmczQ4M3k5emlGMVpTczlhQXNtYk83?=
 =?utf-8?B?UHJPdHM5WjlwM2FBOTlFUjBzdU10QUNyd05TVGZtZDZtTmhYanE1Q3k1NFYy?=
 =?utf-8?B?WS83amRobXFjQU9zUzNkZVloRzFPQVRPRGd2ekxVS0thUXo1TTYwRWUwSWsx?=
 =?utf-8?B?aDBGOFJKdjR4UTJUS1FscjN5NXRkQUlscGUvRTV5TFcvN1Z5U3AwTmVxMmxl?=
 =?utf-8?B?S1hnang0cGdpL1hCL2RqNTFOVkdlQjBaSmEyZHdESjlieEkwb0pab3hrQXgr?=
 =?utf-8?B?TTVydWo3UkhvMU00bG1PeW00SnBOVTczenBWZThtRkRPcTlDNm56TUhZbzRs?=
 =?utf-8?B?Nk1pV25ud3U0a3ZFNTM1dEVTQlB6eE9sSlpOYUROb0EyR2ZNUSsvcXd5dnV0?=
 =?utf-8?B?NTZmZmJFbDFjNXJTK25MVjhjZDBoMU9KNElISWkzYmNqblJ1WTlkRkgvS0xM?=
 =?utf-8?B?Q0dxOHFyOTJnZVF3K1IwNmRQMnZvNnRaL1U3ZDlBVDdaRHNLckRkd0lnUnA1?=
 =?utf-8?B?Z1VtRUhFL25CMTEvRk9IbUppMExsTnNKTXVuelA5U0Vyb2lkRzVFcjRRZ3BE?=
 =?utf-8?B?TVloNU9Xc1Q2TGpFaksxYlVQZXFzKzNaMWVPN2FSR0NiWXZJUS9HQ1RUMXdH?=
 =?utf-8?Q?Jet0ahf4Y/x+rckVjwK4eLKDT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7affcf68-a433-4202-be2d-08dc217588c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 09:26:27.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFtJdhzWqt2BQKI2MjGAiysef1AVsQEzSlUkTumlmiyi3DH6JDu3NMVQxbfqmm36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.01.24 um 09:27 schrieb Srinivasan Shanmugam:
> Return r for success scenairos in 'gmc_v6/7/8/9_0_hw_init()'
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:920 gmc_v6_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1104 gmc_v7_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1224 gmc_v8_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2347 gmc_v9_0_hw_init() warn: missing error code? 'r'
>
> Fixes: 8301de8fcadc ("drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>     Changed 'return 0;' to 'return r;' in 'gmc_v9_0_hw_init' in v1.

I think return 0 is actually better since at least in the GMC v6 case 
I've checked the "if(r) return r;" actually guarantees that it's zero.

Regards,
Christian.

>
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 229263e407e0..7e53b7b043a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -916,8 +916,8 @@ static int gmc_v6_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return r;
>   }
>   
>   static int gmc_v6_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index d95f719eec55..d30b57820c9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1100,8 +1100,8 @@ static int gmc_v7_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return r;
>   }
>   
>   static int gmc_v7_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 4eb0cccdb413..5d55e2313345 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1220,8 +1220,8 @@ static int gmc_v8_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return r;
>   }
>   
>   static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index a3a11538207b..b5651e0426f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2343,8 +2343,8 @@ static int gmc_v9_0_hw_init(void *handle)
>   
>   	if (amdgpu_emu_mode == 1)
>   		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +
> +	return r;
>   }
>   
>   /**

