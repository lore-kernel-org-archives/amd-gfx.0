Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E350FC48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 19:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FB810EB57;
	Thu,  8 Feb 2024 19:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6cs/6P4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D4D10EB57
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 19:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O09qNT7LMHWlc2W792OGlIC+kCtNAN85K6IfkrHcBr0VTbUm4EEvJCaOPq1kjCPFj69aNO7LTC6rmWThnDSkb2U7TrRrPMSkIE1b5u6NPNziQill3th1hv6hEF/HThfGJ7zQPipA7tgXrloKQTMyzTwSsjPI1zkoqArIEvc86V4ZgCqQ7wtzrgbjxNreluv+VfOb5p7MBAVfVspMLqXhkNYw3ciQWnLk+Hi8gutnbZv/6Jn23sTinZT05HdPQhkRDoiE2HS9rWy7eoTVLIou1OOuR9DXAO3zb/jfn2oZeVVKRwljb7NTvr/7CoHUEnTG3incEeNmAoMj2oDrGn+CJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEn54543V60CBEYWBF+3Xg3AQckvPM8TRGM5RIGqcN4=;
 b=k7+Q28TJGFNoh6EJUhdklerEs0vC3dwTFxKCmMEHO7Eym5A9FcL/rvqIstOXoHIjYQ0CLo4PI2qG7f0ODtmwzvsRlh/rCS4QuNcYkipZ4TNYydQJFJQo+JywM3uVt0EewC1tmT0k8c2IC/KyCbhGXRpghifiuzRhh3xg1wIcKe1NUH7lHLhegOOJvc5F4M4u7UaeqnUESUOGbB4l8vVzhmapXPkmVmXR0s1/qLE9U/VFdqfelh5UE37F3bdthYdNW/FTsc2qTjv6UJiLwTIwsn8Y8RXhFCMRIWebnk5GC4kK4tLm11RIcUxJXxCF6O7j2pTB1QV5ZjEXt4njDtaBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEn54543V60CBEYWBF+3Xg3AQckvPM8TRGM5RIGqcN4=;
 b=x6cs/6P43UMmKZm8crFGYxsJvvj11Ls8azLU376WM/O59zA5CRr63OskbFIB9ystEe3Jik2WA6d50ibA5K6fairBzgO4+AIEHlDUKLQ1UoJmRbLU6VpHUFauG/wvAZCqhv8BNOkUSpuyrqhFYGwbIYpvdqbxYuQZBdM3sdXzwSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 19:41:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 19:41:18 +0000
Message-ID: <c14611b8-b524-4520-b6e5-ca67118c4b12@amd.com>
Date: Thu, 8 Feb 2024 14:41:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240208041401.1870940-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240208041401.1870940-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4d2703-74a7-4e22-6860-08dc28ddeb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSNYRRIgRWHho6SaDbVv8c84WufE7Xj2XZy3nvmDVwslHXSTVLRSrwwZrKrgBvohVWqJgxXDK7Q5+7el7jTOsxdutt7wjRTW4FcooycjcqDuwYlx8ziN52Dr+vf1Bv5MXA2z77RjmYYJlzEi+6JAyhh0R1GXDF4t2jGopkdWBGKda5C9HAVVQWVb+qwZAo/iIdmDE+8Rdv/yDRSUTI7nF0s5BupouAhCZjwAeRbYoynlm/G5OtReCv0jkIQCqGRv4W7m8kEDPXqCoQnkQgraLmoWyHLcsFjF07WdCGqL6BacLP3UWoXzxfJRUH2ouOtLt3tc8GU1lC95U6rvAVv3d0yeE9Q7CPYBda3OA81ejES3a0bNVLs4vNyIM4gITVOFyRrgJfSl31Cl73I0lIweSaiNoAsdZ+BS+JajgBVc2tTbuogekvdnJoDjHMiNhe4R1S0roGt6NDwXxRt69RJCU0VpvaiuhszrwF0+7kHJH0VXyLFeQeFYaJAiJCXYzf+gEnvO7tcpF4JXDOT9hQ5EXpE2lwigK6XDQYe1RFTXUJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(966005)(15650500001)(41300700001)(36916002)(53546011)(6506007)(6512007)(66556008)(66476007)(478600001)(66946007)(8676002)(5660300002)(8936002)(2906002)(31696002)(2616005)(86362001)(6486002)(26005)(44832011)(316002)(83380400001)(31686004)(38100700002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZSMktSZDFtbmlzWk1pMkorbTI5NFVQU0tKSXc0emw1a2daMzE5V1JlNTd5?=
 =?utf-8?B?bjZORlFybGJ1WTZ2Q0FCRkVSeVVlYk5EdXAydHl1Q2JCdFN2YVQ1N3I2a0Vw?=
 =?utf-8?B?b1RsMnhFQnF6RkI2YlZucWpYY0pTRysxVURWYVBwSlgwTW1xOGprZTd2bmgz?=
 =?utf-8?B?RVFiUjl0WTF5N3hTZVd4T3ZaODBTcTRwTWFwTFpHSXBUeTZ5c0NreUozVkpt?=
 =?utf-8?B?R0ZqS3NYazUrRktnMzl6ellEd0l3c0duVENldmZraVVHZWtvbm1WTkI4aWs2?=
 =?utf-8?B?WEJnQkphMHRRUVJ6QWxmcmhER1F1cTZmLy9XNW5DckdzMnRWMDhRWFZHVDg3?=
 =?utf-8?B?WUV0RE5LMEpMVUV6cFhFS0JBOUlFT0E1SkJCTEJKZEx3d2NwTDAxNDA3SEdu?=
 =?utf-8?B?cjRoTXFPb29oMFJjVmprVU1jVko3dXE2a082VDJsSFBpcWVDL3hUZ2ticEIv?=
 =?utf-8?B?TDdFNWVGREQ0cFR3b21TWVU2UmYxWGRMR3B0NUJVQ01JRWpaenM5RHBlSWd5?=
 =?utf-8?B?Q3NseS9yS3Q4bVRQQngwZUpBWG5EL3FPellEanJiL2hqZzhEZWJhekQ3T2x4?=
 =?utf-8?B?TDFwVzh3dlNseHdtVVlzUldPaVJLV05sdEY5dEpXSk1TNnNmZUVTN2xTZkRt?=
 =?utf-8?B?SmZqbDltMDltUWJBVlhCNFNHbjJkUHVCd2ZQclFyTGU1dG9UVXZ5RE5LWndn?=
 =?utf-8?B?a0xxcjE5N09HK3RKYzA0czdLUDQxQ3NjQUZkanhGUzNhVE1KMHpQR3A1S0gy?=
 =?utf-8?B?WDNWQ21mYUhtS2lYYjRBT3lkMnFiaWFHTlY2bVhaY3JVTTQ4WloxQzJoSDRF?=
 =?utf-8?B?YW14YThVWm0xVE1LV3dSQmM5TTdNMUw0aWF5V1p0MHB1UjE3VkV4a3E4RFND?=
 =?utf-8?B?RXVta2tjL3IySkVvdHZYQ3pYK09OQ05pd3R6Q0dFSFNGdnhiWjd0N28ybmNF?=
 =?utf-8?B?WEMrL0RYNGRBbFJ4dWF1VnNBamxIVzdNcnkyMW9hQks5UmlnZ0dMbTFNVzVC?=
 =?utf-8?B?dVJvNjI0cnNlWE04M1RvWVBBcnM1ZmR4THpqNzB3bkV5ZERES2ZxenJDWEpm?=
 =?utf-8?B?T0hGRndMbWZ2eTZKbHpyUS9FTnZpODUzWXhnUnkzbmE1RWN5U3dSZWJFdnE5?=
 =?utf-8?B?U1o0ajZ3UEhNY0Z5SDVweExkNnFwcmpHSjVMYUtQRXpoY2F5U3JsKzZhcW1n?=
 =?utf-8?B?Q3RqekFYeG5XMnNnMnFuSXZwamw1Y1EzcmJZS2UxTjR2a1RyMi9UNFQ5WFNP?=
 =?utf-8?B?YStNdjZIbEowWHJBNjJuU3ZKTkpYYTZTNU5lVkplVmhuZmdKWHBReGx5dE84?=
 =?utf-8?B?TEZXZTNhNWMrcXJ2WHZidkVuZE05TVZUNE1kSDZhdzR1ZVZ6ZkZjcXU0dnNF?=
 =?utf-8?B?L2RSRnVuZzhDRGZ0MHdYWmtTazM0UlNIbU5DYWtuQlM2V000V2N0WTl6bmlj?=
 =?utf-8?B?NklXalB2MVBVcnpWclZ2RnRpdW5JcVBJM1E5THZSSll0dDNRQk9vTXBrL094?=
 =?utf-8?B?ajFMdE9wT1prT3l0aGFFdmQrL2tnSExjd2x0endZcko3Z1JZeGlQMExlNmtN?=
 =?utf-8?B?MHROMExtMmUwNWJLSVR6aTQ1ZXNXZktQb0dkSHNhcHVaNExpdUJCZGFaSFdw?=
 =?utf-8?B?UXVyUWQzZjhJc29jaHNsMUdzVmQ3N0w3VlhlM0RNY0dsb25xTzZKU1JraEZI?=
 =?utf-8?B?ejB1NEdXY3RiM0RwZUFzTUZLVlg1THd1bDlMNFFGV25sb21ncUlsNVFwQnhm?=
 =?utf-8?B?RVRwQitUc2NtbEZERUd0ZmFqOU1jZUplZFUyTVd6TXVLQ04wT1c5Z3VxV0Fn?=
 =?utf-8?B?ckxLSFZPODhPdmdqaVRCcVZCZ25qVDUzTy9BOExhZitIdkJLMXJrSlRYbHNW?=
 =?utf-8?B?djFYNDVGaUs5dXFIVmNuZTdDdVlGcVZ2enIxckJDVk1JQ0xoZ05UZXRJRGk5?=
 =?utf-8?B?SVEvYTdiZCs5NnBHaktSYXVwenVHMFc3WWFKREE1WVJaVEZkK2RmMXMzZFpp?=
 =?utf-8?B?cXpCeVRoZUtoM3NydGZ3OGNUWDRvUlZlYWVwL21PSXBTMytkWFRyZ3p1U2RZ?=
 =?utf-8?B?bDBUS3BlMzRFMmIwbmV3QUdVelBNNUloL29qc0w4R0FEVjVZZG5vdW51aXdL?=
 =?utf-8?Q?qi/umDSl86vG5aITdQZjlDjeI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4d2703-74a7-4e22-6860-08dc28ddeb23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:41:17.9328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7xgmlGzZPdOGZjmEHOAUFx9LRIOj+tAzsa3l0bM4UC730sNVD6oEXP02YcXPBZYNAmCFHN/TE7y7iFUOPuhcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
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


On 2024-02-07 23:14, Rajneesh Bhardwaj wrote:
> In certain cooperative group dispatch scenarios the default SPI resource
> allocation may cause reduced per-CU workgroup occupancy. Set
> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
> scenarions.
>
> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
> * Found a bug in the previous reviewed version
>    https://lists.freedesktop.org/archives/amd-gfx/2024-February/104101.html
>    since the q->is_gws is unset for keeping the count.
> * updated pqm_set_gws to pass minfo holding gws state for the active
>    queues and use that to apply the FORCE_SIMD_DIST_MASK.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 4 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>   3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 42d881809dc7..0b71db4c96b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   		update_cu_mask(mm, mqd, minfo, 0);
>   	set_priority(m, q);
>   
> +	if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
> +		m->compute_resource_limits = minfo->gws ?
> +			COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
> +

This looks OK because we don't set anything else in 
m->compute_resource_limits. If that ever changes, we have to be more 
careful here to not wipe out other fields in that register.


>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 677281c0793e..f4b327a2d4a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -542,6 +542,7 @@ struct mqd_update_info {
>   		} cu_mask;
>   	};
>   	enum mqd_update_flag update_flag;
> +	bool gws;

Instead of adding a new bool, can we add a flag to mqd_update_flag?

Looks good to me otherwise.

Regards,
   Felix


>   };
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 43eff221eae5..5416a110ced9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   			void *gws)
>   {
> +	struct mqd_update_info minfo = {0};
>   	struct kfd_node *dev = NULL;
>   	struct process_queue_node *pqn;
>   	struct kfd_process_device *pdd;
> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	}
>   
>   	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
> +	minfo.gws = !!gws;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q, NULL);
> +							pqn->q, &minfo);
>   }
>   
>   void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
