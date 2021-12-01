Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CCBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 09:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E716F476;
	Wed,  1 Dec 2021 09:47:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F58E6F456
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 09:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWWGaSfI6nLmLQpOd2Ch9DIxnz1O10ukfGxt8id2VKAEQcBQ2kue0VSUm8ELON31KhEleHd5gbuQZDYiFfVaLvNN3ctSe3fWttMW6KfutSWwoUqOTvyofJnoxSUHoBFpTw6EklSg+19zgRCIqtRo4u9Cx+PkcS25I/jypELXW5MXNTRIZI3je4ZY6r+uj90j5PeU3Zw/0G/qblgHGfoPyR4KIS6x2PejUSbn67mYqDFT18zrG3wVyCcfXD0VxO6uhQpC/VXnnLcJtORIxPi6dzvhpCeFX6ya6DEnzkCxYPLar+KhTgLypJLzr5BsvYBpxo2pQzC6g3qd1z186Xq5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIG0jpbdYL32g+IALArjgOhA1nTj+uwMxihBtJ+iKYo=;
 b=KkqpAiFXv5WE9BENGKlShT6ZK32p2spsseRCmsWOXznswC2gEbWMtqWgd/4Frq7kSlLznc3caw33gROf4Rvht6u/LAxzpy9RCaUFw78ZslqmkE8X53ZXPuugH5p/RnB24KbIO1qMZMFxCfHPp2+h5hSdDHcGFMh0P1WS2r/L+AZHt0x59tGfSl3BClGsvDQldo8HbFeihAJEsF0q9eCQg8yLHjIPMH5OLoYw0bseedf+HFzt+fPt7NdZh4trPgw+QhYbpepks32uWSz6fGkoORS6lwEbfhYq/6pRA7dXvpubydYcRQxMvK2jJF6FDzIzX+az4417kLXLWbCkHEui0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIG0jpbdYL32g+IALArjgOhA1nTj+uwMxihBtJ+iKYo=;
 b=p/Nf1A2B2QdvB9BxwYjLyjQYJgUIQyHL8xJ/tozlttITKFBml2uPmzNEvmp3SN3OwgF/RDBheESIKsUDNBv8sBVI4S/+dWYywiNNyvKsMXD39ee731dCUhScO1WEcjXTpT6d2kpJRu45drfqOzsUMzhgqEtJP1C/fQBMCSHX9tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 09:47:37 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 09:47:37 +0000
Message-ID: <1f8f87f7-acac-acb7-5e1c-8baa643de7b3@amd.com>
Date: Wed, 1 Dec 2021 15:17:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
Content-Language: en-US
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211201092458.3348858-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211201092458.3348858-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 09:47:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47ac1215-e42a-4bde-f79f-08d9b4af9b2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833C74FF2CBB0A4F5231A9A97689@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hXLNnsBl8fasQIjzbGHDIML0sSthmCB4ZMV3v6+Bi/fMmXMwvjKMxAsowv7Gtaei2x2CJz8g3Uk2QJIdSQPTUcq7A2QdQBUMppgq69XKlhmB1/iNVpGeTotM5T7N6Z2oQi4af8jJfSOFzHKT5W7H69WK4qOvjweUbPtMliug2JKA7lyr8/TjcmMk3Lq1hX3Ipl+muCGBYO+KUh4j2r30bul9LrONIfA2O0X5th2ynIv1l4ImiwMeQdY498eRg1Aasid+WqB724EnUqlj+GxqBfQGFM3ZQ0tivx7gxoybnpzxM4DuvdNB1YVcELtgXmFDzsVis6uWsrTNogDh3XAUZZJEPnqYZxI7y0a23Xc0YHlTsG/tpF4UYers37Wo7y71rn0+kBNPGh/2zVh3TQxseCbFk6eepVKRsENN3Ddsy9J1mmgLitooT+kIXhP1TejNSUz5PJX0jHTe+9rQQw5JULVvU4sMo7MmUQvP1NSmQLeKPdCg5OwNk6q4+8SPJ525eIkI0mdvw4gdPWNLb1N2g7Ri5epwYylgJkWQFElvTI4z73Bk8KCJ6WKLgq5rDshT3IwPVJV0dN91jwpQss3+nT1ZcwA2YE3XfpK5M1FFjjXWQcZYMZydUjfkdE6hP8Qi+T/sJuzc26JaUOUVRwM2aJ68aAzCGpgRQ510Ro6oGZYXR0s9qe/62M2sz79ZcdBVmfUavsoQOH09jKjeWmUu1IJ0k5wF6Ja4OCSV5LUHE3aAe7ZRkSeRYowPFyTndey
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(66556008)(66476007)(86362001)(5660300002)(38100700002)(83380400001)(186003)(16576012)(6666004)(8676002)(2616005)(31696002)(66946007)(4326008)(508600001)(53546011)(316002)(54906003)(2906002)(8936002)(26005)(6486002)(36756003)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBPUkZpYTdBVzBDZExBSEhZQW5icE5TWEVUWVowSjF2bWgySStHTmVYdVlu?=
 =?utf-8?B?dkxrdzJQTlN6cGcwOWhSeEpEelRPOTQ4dFd3RitFUzIzOVlzMjRLaVMzMmZN?=
 =?utf-8?B?SG9rLzhDMmdMOExFdi9ud002cFh1a2N4Z1pWVEJ1YnUyUUVhbGVMYUp1blJV?=
 =?utf-8?B?L3ZuM05rdUlMUzFpcmRTcE5PYmx2TTBjdjY4cjZrNUpBN1kvNlhQN0tCR1Y0?=
 =?utf-8?B?blhkVWRBanFIWE1ISTR4VmdSdENwWmxhVzUzRk8xSS9UOHVTaWI0c0cxRkhj?=
 =?utf-8?B?eGk0cUJ6MjVhMFBLMVdvdUV6bzloQ2srWThhTHBYRjV3NU82ZXgxeXZwQTJB?=
 =?utf-8?B?NithREZCd0d5bGJrd0VKY1R2SEhuMjhVOG1DejJZaDJydW1Eb1UwK3N3VEFB?=
 =?utf-8?B?NEwwdEsrMGVZV3paeXBxZ0lxcStHRmVoSkV3cFBOZXdMeDBkbUhXZExxSWd5?=
 =?utf-8?B?eFRUNG1pTndlOVdtTFh3YTh2cHVkc2srKytreFVMY3ZYT09IVFMxMjMvVDZU?=
 =?utf-8?B?OG9NbTZnNTB3WCt4bGlmQUlna0dWUDZ0MkQwanZtRGUwTzVGaEUrZ1B0WkpI?=
 =?utf-8?B?K1VRa0U5T2w5QU1QKzJobVFiS0pBNXY0REl4QlZPYkRvTGNLU2lMZFBIaGNl?=
 =?utf-8?B?WHltK0xYWlZnVDBWUEt5WUFoVm5RR3FjS1FvTnBjWWZ3QjBvY3lIOExIS2NC?=
 =?utf-8?B?V1lFc3p0N0hTSW4wQ3kwTHV3NUcrWXBrY2g0MFVOM2FETjZzTEI2TUJ0cnNY?=
 =?utf-8?B?ekxBVUI4MGZiOCtjTXhGSFg0aXdGaDhRZDFpMTdSRTA2UmRaRDBzamF1VU5N?=
 =?utf-8?B?YUg5V1U0YTdsdnBNOXZOcUFDMTZCSGk4MUQvS2RzQkI5eUNyWWVENEtZTXU5?=
 =?utf-8?B?MnZ0dDhtVWJWWDIrcjdQS2FnZFYwSVU2WEJid09Dd2wyc2hWVkk1WVVKMERV?=
 =?utf-8?B?QXgya3JEcno5U0xDKzFYZXlNSC9Ob21sNmxLUlNLekhybDRXS3ZackM3UVFn?=
 =?utf-8?B?YzNrSWxHUzMrZUliM0piTjJGY3BlTGNjeloyc0prZzU3ZW1DWHhHWVpkM3Mw?=
 =?utf-8?B?SFRYeTV2bnUxV3E5UHUzNVNRR21wL1Nad2ZlT1lrTklQQk9CSjVQclFZbC9Y?=
 =?utf-8?B?QjIyK3Y2TDBoTDlUNHRXTVlROGVIM0pKbHpoRjI3VDQydVFlTGpNcU03bmRG?=
 =?utf-8?B?dlE5VE44aTI0TnlDbXVheXBtbGQ4eEJlTjVBNjJ4LzRlZWtLWGxCanYwRDRq?=
 =?utf-8?B?T2hpdnFmd0xnLzB4eSt6RVRNcGNiKzVvelovSVdFZDdHMlVRRU1jQVJvcStq?=
 =?utf-8?B?ZlVpdTg4eFZDZEhJMEVvVS9BdXo5NUM1dUZXNGhQQWtsbU5CRGE0aDFDZHRR?=
 =?utf-8?B?NFhnS1o3Y3lnR3ZSTkJIR2pwM21wbU9HM1R0Y3BSSlI5bmdyYzUxWjNOQ2ZW?=
 =?utf-8?B?V3F4WFprK3h1NUltS2RhSmNqRjRHOTdRcHFidU9DV3BDU0h3MGZITGZzMVlX?=
 =?utf-8?B?SEVxaktNaGttaGY3ZVJPNkhUTS9OT2QyUCtBSjNyVWk0dzdlRUhVREZnZzBX?=
 =?utf-8?B?dk43OTl3VW5YZE1sM25ydjBSM25kYkVnTlJ6TXNvZWVJVTBiRDhYTGtYR0o5?=
 =?utf-8?B?dS95eHo5dDRjeTF4ZHlWbWdFTVZoZ25WRklsY1JteVdNVEtaOXFlUlRLOFE0?=
 =?utf-8?B?dHM1c3hqN1IvQS85M2h2c3NxZ3BuMCtjeVVRMnJocUg4R2QrTHFyN0hxWnlV?=
 =?utf-8?B?YllWaTNlN2IvMFRqQXVKVjYzU3dZR2R1b1VkNU41TVdEZFFJVGlXV25ZYUdG?=
 =?utf-8?B?VWl5aEV3TnF0RURIdW1ZdlhYbDhaWGZqZFlUa2VVUDRDMERTRU5mTTd5TzVT?=
 =?utf-8?B?dzBVNkFzbDFjOXIxOXp1YVdxNEFSSEd6bjFUcXM2emU2cU5NcEkxU0FOa2Fs?=
 =?utf-8?B?YWovNWY1MG1ZNFM4ZksxM0liL2ZSUGNsdDdMR2tVYnlIdUlJemd5bmp6aE1m?=
 =?utf-8?B?OUFodEJoREdsQUd0WjROdHRpZkdwd2J2aGh4WU5vejgzM2ZBbHNYZDk2aTdh?=
 =?utf-8?B?enZBNmFyU09RRVJwOW45NVNQN2szOE5YM0UycHJpa1VkZDg3azk5Y0diNjdh?=
 =?utf-8?Q?4nV4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac1215-e42a-4bde-f79f-08d9b4af9b2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:47:36.8984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+GaXXBJEFXcs+0aao4JkNQvogiev2Ix6oGMqluHIsamm9zE2RO0xl6nnPBhiWK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 2:54 PM, Lang Yu wrote:
> To maintain system error state when SMU errors occurred,
> which will aid in debugging SMU firmware issues, add SMU
> debug option support.
> 
> It can be enabled or disabled via amdgpu_smu_debug
> debugfs file. When enabled, it makes SMU errors fatal.
> It is disabled by default.
> 
> == Command Guide ==
> 
> 1, enable SMU debug option
> 
>   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> 2, disable SMU debug option
> 
>   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> v3:
>   - Use debugfs_create_bool().(Christian)
>   - Put variable into smu_context struct.
>   - Don't resend command when timeout.
> 
> v2:
>   - Resend command when timeout.(Lijo)
>   - Use debugfs file instead of module parameter.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>   4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..86cd888c7822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	if (!debugfs_initialized())
>   		return 0;
>   
> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> +				  &adev->smu.smu_debug_mode);
> +
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..50dbf5594a9d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -569,6 +569,11 @@ struct smu_context
>   	struct smu_user_dpm_profile user_dpm_profile;
>   
>   	struct stb_context stb_context;
> +	/*
> +	 * When enabled, it makes SMU errors fatal.
> +	 * (0 = disabled (default), 1 = enabled)
> +	 */
> +	bool smu_debug_mode;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..d3797a2d6451 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
>   out:
>   	mutex_unlock(&smu->message_lock);
>   
> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
> +
This hunk can be skipped while submitting. If this fails, GPU reset will 
fail and amdgpu won't continue.

>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..9be005eb4241 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>   		goto Out;
>   	}
> +
>   	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		goto Out;

Next step is reading smu parameter register which is harmless as reading 
response register and it's not clear on read. This goto also may be skipped.

Thanks,
Lijo

> +	}
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
>   	mutex_unlock(&smu->message_lock);
> +
> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
> +
>   	return res;
>   }
>   
> 
