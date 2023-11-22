Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B41C27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 21:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97A710E0E3;
	Wed, 22 Nov 2023 21:51:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D60710E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 21:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOSVzT2yIZpIQyRmha22oh1IvKq5d5yvSIZP4b72K4aJ9SFunMnXkaPIRaqt2H/oBZqJrMUVy7JaM8GcuZ/6qFoSgebYvAOVPU+WLDGiZUPelHA05yGWADoyWnBYjQk33zkqUw80PXu4dcf3s5AEvGq4z4quG4OBlr8rU+nySxdq+TBAKLgga93XmKQ2F+Cld+JCh58mPzRuE2KfQlmdxzODSMzCkfe1KoBWuKFvi/VTRzKw1Bj005XIDBXS72GOEqlIYdN8/BNL2bhlCUYG7GGUAezzX3G03UxntmFWi/fbgtCfwpIQCaVnuTVM940CZtnL/4yxc8wZwEvtoSZZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iFEYXq9w/O950tFhkVzEnNKmOnsgOdUvkxbJ+t9snY=;
 b=XOy7FN3vjy+F0VRs4P8bSbgUHR0f7UaA/dPnEW6lghml6EZ66O22Sp9OJ32jHZqPf7VAQRNc+7wIqr3Osk9jr4CCYDul49RN8l7ASQp6onhBTFRunBPc21OLSJh0IcgjImw3yy/g10imRT5uyPw/OZIraF2KEx1bKnMfJE5Gt9PPaHqXfaQ3jHk77AbR2Xz94DLvwlKtvHeVRN3BTqkKhakZ3Fl3+iDSPi9BWIFbwt4/Tes49HXX1vBnVODLJzo6kChuSWCUFcNH2PF94ijSO3MMAZL5Sja7/LHtzJCyD6DO5E5cbMrphX3wRaS27hKtln2mwxncrL2hl4El0EJ2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iFEYXq9w/O950tFhkVzEnNKmOnsgOdUvkxbJ+t9snY=;
 b=g66SIgjvkNN2KIrvDWU/Wuu+trq+hXX//PE6gPeURnt9kLPJN8VBxy1k8Thqp0hVp6dU5mMUU/kulKWnFMb43lWMdNHMzen68FVNZ0pdlr6vWF7eDkv6x0n795Oa4cjVN3738wiRF46WacJOLlteq4Rc2RHAUtMaRq2EHoZWp3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 21:51:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:51:22 +0000
Message-ID: <eb54d698-39d1-4111-a312-2d5c7221ecba@amd.com>
Date: Wed, 22 Nov 2023 16:51:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] drm/amdkfd: enable pc sampling create
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-6-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-6-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b497a4-65d9-4127-2938-08dbeba52aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRaj6dUYLU6Ysz7sDxqGEKYS3OFV8h4UTrAlDmWzWa5lD2VWxa54vqAImN2JUAp+si9YKyertTat9e5GNdPbn7YX5KKhhU+gN+z2FbSHrAnrmayoVQXcs+3zl288BCfeH0p0/y8PpzziWA30J4SGSufo5SOQvxbrbBSk2NmxauR3VVIGljC5cefycwHRhCGt9Ao3FM3+1B2kO5Dz+qAnF6NRnTomiUF6I7CZCP0lF0NyM3WGTHfxSeFGc4j0Ea5+7ayGpysyIefz/OsgqOY2guOj4u0mWRzF9nyTe0TylxVW0DKb6TFg94fBN94HvQ3EEMtG5s0msKArKtVp/TJqS6NzTwjZh5wRQ2QMlz372QHyoxSfzpINHFen9cSUH6k0CQ25Dyp0HmCiFkLCQ4JDICzLA3+yF6f9m47LTWfN7BTOZ3vPGXjMqg4CHtzdDNyt6CFxIZG/HviLjmjXIjBOIzDIhMsRkAoEVQG7e3jodzKi9wWRKW3oy69u15fSDpJ396SXHMNjbSRbpXYm5EF3pFkoFBhM11gd/LOFu1UySfUN4URJIK37b6tDIUu8HiGYKAoWFKDI9U+mWe/T03wotZQuO6I28Ov7BMQt6hS6BC229LmLhXPjnY2iHYXnab6OnAEgFg9+X4kiuI013LQLqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(316002)(66556008)(66476007)(53546011)(36916002)(41300700001)(66946007)(26005)(2616005)(4326008)(8676002)(8936002)(478600001)(6486002)(6512007)(6506007)(31686004)(44832011)(5660300002)(83380400001)(2906002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlBiTW50Z2l0WUVmZllVUTJObjYyMHJJbm9NL080bWsvelZ3R0VEWFVHVUtZ?=
 =?utf-8?B?SWFRV0J3Q1l5dVFOVTBIUHRzL2ttdk5GT2drMEZrUzFwOXhjK25YYkJDZ2Rn?=
 =?utf-8?B?VUpQK0oyREpYdzBOandPRXBMalhPam1IcEIwNzRXeWxKc2RjbzNYNWp6WEVT?=
 =?utf-8?B?eFpTb2doMFk0QUhGQXAyK2VYVjRDTHI1RTRybURhbmJGRjJHbG82aXJqWWNI?=
 =?utf-8?B?YTlEbGE5K3RVZ05PNm5nWGI2ZitwZU1LYjR3ZEI2ZW1YbEw3TVZNVlRFaC84?=
 =?utf-8?B?SjlxcDlNREhIOGNaVHpQM0VnS2tRSG5LaXd1WkY0c24vMFJzUXdjeTgwcXRQ?=
 =?utf-8?B?a2IrbllpZmxrcVFHNm5MYkwvUll0L2Q0RE8xMXdlbnVEOXp5MkhUOTVTSVBW?=
 =?utf-8?B?MllYbFlra0U0TDM5Q0x2WitZSzBQaTJHMHVPZ0xaY3U3djZpZmFvcXI0YzI5?=
 =?utf-8?B?SHU1Tms2V3ltTjhaYWxuQlN6ZHNaUXRTVVNxL1krZm5ZNmpEWW94MjVQTDNG?=
 =?utf-8?B?V2ZSQUxjK2ZNemJmblRwV0U2Mm9QM096ZTBpNnczVVlOaHhsMm1iZXhWMDNL?=
 =?utf-8?B?U25HRDZweVAxdkZINUN3Q1BPTHpMWUh4KzJ0dUNMWDQ3SXVUbDFVc1kybEFG?=
 =?utf-8?B?U3dDQy9jallBUGtnMFNUeXZ3eWNsR2ZkQjYrSk9MbVNETC8yTVZvQnY1SWw3?=
 =?utf-8?B?N0FoMTFuS0U5cnlaMzdYOEE1WUlyL3M1S0ZKT3I3Z1BmUkJnREVNVUlVNXRp?=
 =?utf-8?B?aDFrVDV4eXhyTDYrbzlxVkgzSnFhVzNwSDZkSzNIT3phZzBzcnR5RWp3Zkpv?=
 =?utf-8?B?QjQ1bk11c0FhVzdVVFpJSy9GTlFaaTV6dlZoZGx4bStxZHhka3hzOEZMNkVW?=
 =?utf-8?B?dVJuWkhod1QzUURYVmUxK1VLU1JjMDRqZWFqd0VyN0Y5NGowQS9UajluM0tY?=
 =?utf-8?B?UEZIZWtHT3hQcm81YmJ0ZWozSUNSbXd1ZDlzR3BET3BOc3FzMCt0TTJmTmxP?=
 =?utf-8?B?U0dNbXpsbXFEcnhDbTIxd3JXb2N2M0NQQlp6amk4aWR5Y1dldC9ncStlQTZr?=
 =?utf-8?B?ZE5mRTlqZHJGR1RCdWtXb3Y1ajBuZlNHT251UWZCOG5CSmRQY05KaUpaR0t4?=
 =?utf-8?B?MzRqZ055RHd3Z2o4ZWlELzBFeDFMTGoraEJoaHBrOTFyM1lQeGtsbWhUU2th?=
 =?utf-8?B?eGpjU05WRTdrT3AzZ25Sc00wVElJYnhNdlREbnRkTWtmdERoWG05QU1GajR1?=
 =?utf-8?B?YWZ2akNRSFIwVy9ob2s0V2RZRTA4VFVvSDN1RTN2cTcxRnBkMVdsVzZ4WDIz?=
 =?utf-8?B?UmRvdGRRSDFST0dRK1gzZHcwNzJMY3RGbzA3K1VKUmsvc2twWmZjT3NxajVp?=
 =?utf-8?B?UTdCcXJGU2svdVJ3M0ZSNGdsMzZyT3JPODFNNFBaVlROSEpDS1VqYUpjc0l1?=
 =?utf-8?B?UmlOcGpHQmhybzFYYlpleGNXb3Q4cENFdDNBODlVY3BtMjM2Tmk1N2ExZFBS?=
 =?utf-8?B?YTlVS0x1VWROZ1dBY0lWUHBHVFFlajZIbGMwK3ZnVDF1U0VDOStwdjlFOEEr?=
 =?utf-8?B?aFBpWkU3amNTS2xlQ2NFVVVYSUpwT1gvb3huZFJpcm9HUSt5OHU4azdhaVRL?=
 =?utf-8?B?K0JZRUUyS29OU0dQTVNHaURHbTVFT2c3WlN5SXdKUkI5aXh2UUdiNFpxRW5M?=
 =?utf-8?B?Y09Wb3lZcDNISFZZVFhDVG9ldmc4RWZ5NU1BYmRnaW1NdWZkUjNwTEovMGJK?=
 =?utf-8?B?dVM2MGw1eGRNTG1yRTU5cksyWmY3ZFR5anFRcE1mV01sOThSWGYxRUNmSnhq?=
 =?utf-8?B?b1BnVDRxNDB1SFBEWEg1SThDWGR5dG04YmxzWExRSkxhSDhKblI4Qk9oZFo5?=
 =?utf-8?B?Z1NjbU80NDN4cCtYKzc4dkZGdUdIU24yMzJVWGhDd3ZtdFpKV0tuQU5lN1Jt?=
 =?utf-8?B?MStwMkgweXV2cHFiWXo0Ky9sNlYza0d6YVE2cng4QjB1VG1zaUl2bDQrVndG?=
 =?utf-8?B?Ly8rK0pwVUNkTi9CQXhBYmlWSUEzTmJPZitDSDBFcDlJNEp2dS9YWEplR2hw?=
 =?utf-8?B?ZWJCUWlXZGltOHhlK3pSMFVvdjRTK1cybUpqb0VzaWNuSGxVRG1qU25ZVHRQ?=
 =?utf-8?Q?ZEwfs4W538aecuYdc9dXJaYlH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b497a4-65d9-4127-2938-08dbeba52aca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:51:22.4236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN6KUcZet9itX3f8I0JYdcRUWTNeoYjZeA/zak/+GfHDhTNUuc9lCgAwznlgK1gxn3U8AjGV/xK5Ruw69T8qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> From: David Yat Sin <david.yatsin@amd.com>
>
> Enable pc sampling create.
>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 54 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
>   2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 49fecbc7013e..f0d910ee730c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -97,7 +97,59 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
>   static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *user_args)
>   {
> -	return -EINVAL;
> +	struct kfd_pc_sample_info *supported_format = NULL;
> +	struct kfd_pc_sample_info user_info;
> +	int ret;
> +	int i;
> +
> +	if (user_args->num_sample_info != 1)
> +		return -EINVAL;
> +
> +	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
> +				sizeof(struct kfd_pc_sample_info));
> +	if (ret) {
> +		pr_debug("Failed to copy PC sampling info from user\n");
> +		return -EFAULT;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
> +		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version
> +			&& user_info.method == supported_formats[i].sample_info->method
> +			&& user_info.type == supported_formats[i].sample_info->type
> +			&& user_info.value <= supported_formats[i].sample_info->value_max
> +			&& user_info.value >= supported_formats[i].sample_info->value_min) {
> +			supported_format =
> +				(struct kfd_pc_sample_info *)supported_formats[i].sample_info;
> +			break;
> +		}
> +	}
> +
> +	if (!supported_format) {
> +		pr_debug("Sampling format is not supported!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	mutex_lock(&pdd->dev->pcs_data.mutex);
> +	if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
> +		memcmp(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
> +				&user_info, sizeof(user_info))) {

I think you can compare structures in C. This would be more readable:

	if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
	    pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info != user_info) {
		...
	}


> +		ret = copy_to_user((void __user *) user_args->sample_info_ptr,
> +			&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
> +			sizeof(struct kfd_pc_sample_info));
> +		mutex_unlock(&pdd->dev->pcs_data.mutex);
> +		return ret ? ret : -EEXIST;

When copy_to_user fails, it returns the number of bytes not copied. 
That's not a useful return value here. This should be

		return ret ? -EFAULT : -EEXIST;

Also -EBUSY may be more appropriate than -EEXIST.


> +	}
> +
> +	/* TODO: add trace_id return */
> +
> +	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
> +		memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
> +				&user_info, sizeof(user_info));

I think you can assign structures in C. Just do

		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;

Regards,
   Felix


> +
> +	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
> +	mutex_unlock(&pdd->dev->pcs_data.mutex);
> +
> +	return 0;
>   }
>   
>   static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4a0b66189c67..81c925fb2952 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -256,9 +256,19 @@ struct kfd_vmid_info {
>   
>   struct kfd_dev;
>   
> +struct kfd_dev_pc_sampling_data {
> +	uint32_t use_count;         /* Num of PC sampling sessions */
> +	struct kfd_pc_sample_info pc_sample_info;
> +};
> +
> +struct kfd_dev_pcs_hosttrap {
> +	struct kfd_dev_pc_sampling_data base;
> +};
> +
>   /* Per device PC Sampling data */
>   struct kfd_dev_pc_sampling {
>   	struct mutex mutex;
> +	struct kfd_dev_pcs_hosttrap hosttrap_entry;
>   };
>   
>   struct kfd_node {
