Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BA6EC8758
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E04710E0A3;
	Thu,  7 Sep 2023 20:51:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D574B10E09F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCWcAQxhYhgTdkVq/fVaSfXNDAjNn3fODQ7p9tZ9lWQsIg99N3uRD1Rvydm7kK39PyJh2uIX76oxsOCx5r7tvxztTLwkrkppvQuy+gglwsWj+2Dt1F/j1E3niyBfQrY3tXdgy0DvCdt3HixK0YXUhem0zYIxgBDts5Z2CLFmBLOZ7ppVwKWCU98GH70fbmt44LgefaR5bkBN27PUy/83OLjriaQJB3nVaHcQoZUlpgH+fa5o0Ndj/8pk2wQPCK3957m01Up+C2BajZ+HPWG7syjkXKgi+xomgPE/0E2zax8Eu/R5x8ylobTSSfjE/VGIb1/w2Y0JwtsQeM4Izk6AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+izWZLBqSl9QbYhcyhLGBduKlESzoNUY8vmi3ZgXUk=;
 b=Z0zealBRWOtX4PI9ZG2tpWJfvBbZfgwnPDO7ApDftuNvs+vM+/ZYAXZ+red4THgPa6sn+e7GfQJIBmxfWqLbwdm6PiMh+YixiFGj4hLd4D4ALTno84g3cayisA4FNVRZ0mO5nlxLUoqlH1d7gT2tS5RFAORYyucHYTls8AZ0Am5yRlyFHk75hWT5Pa8x7MKF+rBZ0oWi1ebU3WGsHMITBdxQVMNzGFbT2U4254Gxp0tJEmpUYJW+x7xJglq6+K62V8UtmNrqAEi1u4nmbW+EU66RxdLudWfyE5KYTHAw7QnXNSzGe2EeyKqqZiZtKpXaCodwAoUcTZP+ghkpau2UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+izWZLBqSl9QbYhcyhLGBduKlESzoNUY8vmi3ZgXUk=;
 b=Cj8Vq3AK+UJC5pTjl/2n8gbo5GZ4aGDQtCfuaPSMkD5PsFNgq6xu5USUdAuBKlpRXjU2LthB5XrQvsxrJSIrKd2XzXIRDpXRGYu3ERQxht3e3d9sXmafQ7pUYtVOk4o1xAplB4KaaB611ksQ1Xe8aT5vH+eIQ6Dw7/kLMo+2IsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:51:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:51:02 +0000
Message-ID: <c72a334b-9ea3-8283-cd93-b26f332fca32@amd.com>
Date: Thu, 7 Sep 2023 16:51:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv2 2/4] drm/amdkfd: Update cache info reporting for GFX
 v9.4.3
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230906154429.216489-1-mukul.joshi@amd.com>
 <20230906154429.216489-2-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230906154429.216489-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 36743ed3-836c-460d-72c6-08dbafe425f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiyDuIX7SFDd9UaZkT07jgXC16vdVONTRk0D60DKR/gWEPy+vy0nYZuwxpntpCNOPcPZyvxgcR25T+6/6kRh5SWZ70MqFipBM2m9Tgg2TDl+WHHe6JjYc7vPWD9B5bhNxPzeKYc/SGpmtZv6+16+oWqzhZu7moQCVh8nZ7A+479F35PBxsrnTmcE+mI8QE8UKkiqZyLycJUJfeteifpZ6M/2nCtwNNEM8LOLUl4hbiTewqKngnsYSJU7ZCEy2Ez8F1744vxzqBHuzDfha01OIY+ak/PgMJnGZNa1fF1ZjRMC0y4PXzkxNZe53LO7oBRTsrRlIsZucEucQ5lIc+QGQpBXwECWO6AUEQkdfw00DmmGVXiXdVVdN/mVclVxyzV13qYJ10V5I3WW1zPDQmLLCw5j3UzOZazmTE8D8carGhOGIIEjgZdBDvw+xgrvXgmOhWl7ak5+dQ0N6Oz8miZ1a3JX8qS2ArPT9uHp4WnPuvwAye/Ms/ygOnndGUgx7uYUAv4abhOVXN4IqH6aPOJqwNZxU8B+FCr4wMXOSUFSsCP9QF128IBx6rFWujeVo1/aIGFoZk1PlMc7td6qubuvYyqw2ZFs8qh9gi1TLBa/fE+2PJKaoAZkkfep2Bv9MiWXV7qrIjkjIadCdvH/D16I4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(186009)(451199024)(1800799009)(66556008)(66476007)(66946007)(316002)(41300700001)(2906002)(38100700002)(5660300002)(53546011)(44832011)(8936002)(8676002)(6506007)(31696002)(36916002)(86362001)(83380400001)(15650500001)(6512007)(478600001)(6486002)(26005)(2616005)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmN4ZjNwWlYyYlJCTW5mR1dheVVGcjVmRVdSL2dxaTFxazViTjQxdFJPZjRF?=
 =?utf-8?B?U0xuVEVGczJlMTlqVDBPYnUrUkViREJHT28zTWtnR3grN3ZqWlFKZjNlMWxX?=
 =?utf-8?B?UC9PdU1KREdZTVd0N21laEZqTXIxbjZpanpaenhZTGNjQ0VocEpvRzRwZE4r?=
 =?utf-8?B?WnNmZEl1VGJqTFRXbUZaaVdVNVJaTlVJQzNhVGVnVktRWHZmZUxUVUxtUDFa?=
 =?utf-8?B?Vk42UnhRaS9MdjFDYkRLQ29mVWNpWDFxaE5IcVpzbXR0NGNweU0zN2h5Qy8v?=
 =?utf-8?B?eUczaDZ3bUljWEhJaDNkV3RqZUU2VkR5MTJPMHdXNExyWmtqbVluSkIrRkdh?=
 =?utf-8?B?ZHMzRHNjb0RWYitNSmlTc2JaaTllbDJPSFRYbE1ma1hLSkdTdEJoNGpFWVB2?=
 =?utf-8?B?RzdMSmlWQmI3YWxtSTBBRWU1Y2JoV0hzTjdiVmRUR1dvbW4zMjFSM2Y1Nzdh?=
 =?utf-8?B?eDlmcnJwbUdSUWRGVEQ1ZlVOdkt6MTRodnNoYlNRRmVjRVJFT2JLbEtIVlJM?=
 =?utf-8?B?d2JXZnRDRm8rRlEyUVdHMXc2cUxUZUNDMWhhL2JzWDl3RlBFcW9MeEVMNkdZ?=
 =?utf-8?B?U2M0Rkt3UUlXcitaNVF6aDc4UzlBU1AyWUJGRVdjZ3YrNUxYVUNTR1hWLzZq?=
 =?utf-8?B?STNadnVGNDBQSUFzVm1kU2NlMVdGakpWM2pFd0lvQStaajRtb1hMUG9rb3pp?=
 =?utf-8?B?VkNmb05OZVVpc0tZMlhpa3JVK1RQbUpDY2w4QU1vN3haL1RwQVVqcUF3dkx2?=
 =?utf-8?B?eFU3VHVhdDNpdGI3Zk9DL2gyNFQ5YUt5bVVIRnZGZnNLV05UTUF3eGZ4c1ZL?=
 =?utf-8?B?RDE5cG5Qa3pQUVIvMTJLOUZzZVJ3SlArWXp3aTdhbHhWMkJPTXlYNHlzcThH?=
 =?utf-8?B?SFE3QXlvMWhRNFdrbkcwK0x6VFB3S2liczhFcU9FVjRzQ0ltSjJVeVN0QW1a?=
 =?utf-8?B?NXFZb2F6bVVMdzBkaDJhTXo4MDRNYTlQYmIrTDlZWms4QzMrVVZ3eU9xZWtH?=
 =?utf-8?B?dTZEMzdGNW8zLzcvcWlSbGtsNkNTS1hGY3FFdzBxdkZKSkNFUjdGdlRzTWJk?=
 =?utf-8?B?RG1ZWkRVUVJCUzBKbjRVZXE0Y3RJOU5mampzbkZxbXVzT3ZKT3o4WEdMcm5v?=
 =?utf-8?B?QUlaWkxKUUdQTmJnMXhFREs3QnVKdUVEK3Z3K3lWek9zbkVHQ09Jb2o4Vnla?=
 =?utf-8?B?NkZXN29lV0pDSjV3UlphKzBJN2cySFdwbFZZRU5PbENFY2czMkpmdjQ2b0pq?=
 =?utf-8?B?M2ZYVW9DVVQrdnlXTFhkczNKbGpLRmNTWnh5VmNWb0xiVnlkMmh6VEU1NnZx?=
 =?utf-8?B?cE1RV3QxamEyOHVzK0RiRWptWnlwUUpXQmdaaElVdm96Yzd5dFovMS9kQm1x?=
 =?utf-8?B?SUtzZVZDdDBVVjg3QlJ4SHZVVDgxZ3lOOWFETnlEVTN1K0JlQnVtRlVZcGJ2?=
 =?utf-8?B?SnZRNzk4YWpLZ0JwSnhia0VjWUtaMWJ6NSt3R3h2aTJWdTdQRVpmdFRzT1FR?=
 =?utf-8?B?SWxsWWNRSzR4WFhseG02Tzlkci9IaGZJVXBnWXVxck9Qek1mbU9DZ2NXWjhZ?=
 =?utf-8?B?T3FMNGYrWVpBbUEwS0IwZlRkVGVPZUVaMXRtRWFFUWxxMUZvZTZrb2gzNXJG?=
 =?utf-8?B?dlI2L1FwK1phNWI3RXl0YTNCUlozTmtaSDJqY2JZNC9mS1I3Q092N05JVVJ2?=
 =?utf-8?B?L3BBT2V1SHh1bGVWR2FrbWNpOHlqZUlvSy9XazQ3c1dDdWhDZS9pSXozdWhD?=
 =?utf-8?B?aVRNSVorNU5zVHpCVEV3RDVsZFVNVk1mbzI5YlJZeGFPVmdOSVIwRVhnYTF6?=
 =?utf-8?B?Y1lNbWZLK2hpeTVNOERBUmNHNFNVc0Q4QXBzMFk1K0hiSUsrVnhyOWhSaWlS?=
 =?utf-8?B?bEFTdWZIVkFyR2w0dzNhWGc5bXhyOGJINzdIWWtmRnoyV1hkY2tvbGh5UXJR?=
 =?utf-8?B?VlJ0cmVTbVFkM3VkOEJ3YWF1dG5JR3FiOWVYQzNpd1ozSDhWcVhjZ3lYQ0hy?=
 =?utf-8?B?aDcxa01EcVg2bHVYdFcvdklmdmloSmZyamg2dkhCZGNEZkN1WjQvUC83NFRz?=
 =?utf-8?B?ZVRqTUZvNUxNVGVROVROVWFFMnUxQktWN3B1cnhzSml2bVIvUDRhczVDdExW?=
 =?utf-8?Q?rby3KRCg0nbrxU1MGQzaFxPqt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36743ed3-836c-460d-72c6-08dbafe425f3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:51:02.8276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzOOHViLUZs1mmHFZmXGLRTBrtBxkIXP10f6p65zJu0HPpzLq09aTh1igyRs08hq+E1zYVeiMixPhhplcdy37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
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


On 2023-09-06 11:44, Mukul Joshi wrote:
> Update cache info reporting in sysfs to report the correct
> number of CUs and associated cache information based on
> different spatial partitioning modes.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Revert the change in kfd_crat.c
> - Add a comment to not change value of CRAT_SIBLINGMAP_SIZE.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 82 +++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +-
>   3 files changed, 51 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> index 387a8ef49385..74c2d7a0d628 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
> @@ -79,6 +79,10 @@ struct crat_header {
>   #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
>   #define CRAT_SUBTYPE_MAX			6
>   
> +/*
> + * Do not change the value of CRAT_SIBLINGMAP_SIZE from 32
> + * as it breaks the ABI.
> + */
>   #define CRAT_SIBLINGMAP_SIZE	32
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index c54795682dfb..b98cc7930e4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1596,14 +1596,17 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
>   static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   				struct kfd_gpu_cache_info *pcache_info,
>   				struct kfd_cu_info *cu_info,
> -				int cache_type, unsigned int cu_processor_id)
> +				int cache_type, unsigned int cu_processor_id,
> +				struct kfd_node *knode)
>   {
>   	unsigned int cu_sibling_map_mask;
>   	int first_active_cu;
> -	int i, j, k;
> +	int i, j, k, xcc, start, end;
>   	struct kfd_cache_properties *pcache = NULL;
>   
> -	cu_sibling_map_mask = cu_info->cu_bitmap[0][0][0];
> +	start = ffs(knode->xcc_mask) - 1;
> +	end = start + NUM_XCC(knode->xcc_mask);
> +	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
>   	cu_sibling_map_mask &=
>   		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>   	first_active_cu = ffs(cu_sibling_map_mask);
> @@ -1638,16 +1641,18 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   		cu_sibling_map_mask = cu_sibling_map_mask >> (first_active_cu - 1);
>   		k = 0;
>   
> -		for (i = 0; i < cu_info->num_shader_engines; i++) {
> -			for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
> -				pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
> -				pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
> -				pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
> -				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
> -				k += 4;
> -
> -				cu_sibling_map_mask = cu_info->cu_bitmap[0][i % 4][j + i / 4];
> -				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
> +		for (xcc = start; xcc < end; xcc++) {
> +			for (i = 0; i < cu_info->num_shader_engines; i++) {
> +				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
> +					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
> +					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
> +					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
> +					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
> +					k += 4;
> +
> +					cu_sibling_map_mask = cu_info->cu_bitmap[start][i % 4][j + i / 4];

Shouldn't this use "xcc" as index instead of "start"?

Other than that, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

P.S.: This whole function looks suspicious to me the way it exposes 
active/inactive CUs to user mode. I think user mode only wants to count 
active CUs in the sibling mask because it has no other information about 
inactive CUs. And reading the cu_info into cu_sibling_map_mask and then 
only using it in the next loop iteration is probably also wrong. It 
basically throws away cu_info from the last xcc,SE,SA. Or maybe I just 
don't understand what this function is trying to do.


> +					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
> +				}
>   			}
>   		}
>   		pcache->sibling_map_size = k;
> @@ -1665,7 +1670,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_node *kdev)
>   {
>   	struct kfd_gpu_cache_info *pcache_info = NULL;
> -	int i, j, k;
> +	int i, j, k, xcc, start, end;
>   	int ct = 0;
>   	unsigned int cu_processor_id;
>   	int ret;
> @@ -1699,37 +1704,42 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   	 *			then it will consider only one CU from
>   	 *			the shared unit
>   	 */
> +	start = ffs(kdev->xcc_mask) - 1;
> +	end = start + NUM_XCC(kdev->xcc_mask);
> +
>   	for (ct = 0; ct < num_of_cache_types; ct++) {
>   		cu_processor_id = gpu_processor_id;
>   		if (pcache_info[ct].cache_level == 1) {
> -			for (i = 0; i < pcu_info->num_shader_engines; i++) {
> -				for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
> -					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
> -
> -						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
> -									pcu_info->cu_bitmap[0][i % 4][j + i / 4], ct,
> -									cu_processor_id, k);
> -
> -						if (ret < 0)
> -							break;
> -
> -						if (!ret) {
> -							num_of_entries++;
> -							list_add_tail(&props_ext->list, &dev->cache_props);
> +			for (xcc = start; xcc < end; xcc++) {
> +				for (i = 0; i < pcu_info->num_shader_engines; i++) {
> +					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
> +						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
> +
> +							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
> +										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
> +										cu_processor_id, k);
> +
> +							if (ret < 0)
> +								break;
> +
> +							if (!ret) {
> +								num_of_entries++;
> +								list_add_tail(&props_ext->list, &dev->cache_props);
> +							}
> +
> +							/* Move to next CU block */
> +							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
> +								pcu_info->num_cu_per_sh) ?
> +								pcache_info[ct].num_cu_shared :
> +								(pcu_info->num_cu_per_sh - k);
> +							cu_processor_id += num_cu_shared;
>   						}
> -
> -						/* Move to next CU block */
> -						num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
> -							pcu_info->num_cu_per_sh) ?
> -							pcache_info[ct].num_cu_shared :
> -							(pcu_info->num_cu_per_sh - k);
> -						cu_processor_id += num_cu_shared;
>   					}
>   				}
>   			}
>   		} else {
>   			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
> -								pcu_info, ct, cu_processor_id);
> +					pcu_info, ct, cu_processor_id, kdev);
>   
>   			if (ret < 0)
>   				break;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index dea32a9e5506..27386ce9a021 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -89,7 +89,7 @@ struct kfd_mem_properties {
>   	struct attribute	attr;
>   };
>   
> -#define CACHE_SIBLINGMAP_SIZE 64
> +#define CACHE_SIBLINGMAP_SIZE 128
>   
>   struct kfd_cache_properties {
>   	struct list_head	list;
