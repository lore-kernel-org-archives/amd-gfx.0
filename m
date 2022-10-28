Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60351C38A02
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Oct 2022 20:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAD310E18F;
	Fri, 28 Oct 2022 20:17:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7B110E18F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 20:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz+pbyzFzf2kudVnPUnbqLWVwibAxvfD9KNzM09z+MuUDNEXRt4Bnpr4wK0kVt4OVYyiOAMymfD18W4USLmG9lGX65vppHYc/MiS/QTr1bCGxCOCd0xaPkZ7ngpJEMJYDKWBs92j3ggLqJ20buek4VcS9SIfCU6twPV4Tjai3X4cpbbYAY5T51ZjLvOtVqCL+5qChKVfPGHCcjCvCGl+f4SKm9t+sl1yUkYcZsI6USofEoBB7tHf5khfd1MsemNFA7UEdKjo3LZhGM5DzHIZ219Y6O+DUnMXyiOiCpAYHuik3iWOHTRaLzvc+ZqSmb2Xcoj5jW6u9ytssKsJDOyG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0V7KBEq2kWVw24NLaAe57XUiVfM4dJ9/9vcU6lx1E4=;
 b=QEptYc6qJteDgCeGbDwVrWB41OPqcMO5LTsgwdPAHzEnvjwB3qdwZ+bnywJO5GX3Byza96HkbZR4ysIpL3CZeteMup0b5UAr6KLTdjA6a/b5poPxjwO5/VuUja9kah6bzUmKKAwS6zBI1BtWk1WH9WiaYHUVIJKD8EnStb+QRT6BZt4EDUKCcLTRtMPC+mwi9fVmrNC1+o3qW8EmEvEnWHopEWWmk8cIaBBON4v34+AjPKuKGfdJOMlA1yG7CjUbyxDPuSyhCd7NnZ0vU2N2s4suuTc3+4hDoiuGdZTBSAg+AWNgNGRImUzP2+tEVcLxyBXlRxaJoiCFX9tt/Ser6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0V7KBEq2kWVw24NLaAe57XUiVfM4dJ9/9vcU6lx1E4=;
 b=T0u3+NhXz+u94J+Brmly22jI65pMb59tJJHB5jxp2yYe32EZINbRmsY+jxTjzLm0f4xArYsUdQtmhMrs2gU1azs9sKVCAz2wJ+B5Ga/B8R7jLaIw0Q2S3kZpHg50AWMzigtxMQeZwLiJ6I+TE67dWkPNPjxxd3jKosMoCHqvOes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 20:17:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 20:17:44 +0000
Message-ID: <9db95d91-84f5-4f10-633b-e42e909b14d6@amd.com>
Date: Fri, 28 Oct 2022 16:17:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20221027081402.320626-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221027081402.320626-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:208:32d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d2bc47-7a94-4189-45c2-08dab92178e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +reUnuRwKJTxyabsNwqXeZkszRTCWd4u4a3bCnNCgfuKzlF3kAI4buiTkJ9igekxmOsc9tp7SKqKBKTC9eaBUT9eR9vVUuaHvSK+M9iJUW8i/tnghxkW4iqyWSVRJ7Q6xabevSUM7bsUifFpM4L/LbKrLCF8YwkDyZ/wqPiM371bp0kuHUZNr0PbmDximd9kYAOjJuhs6xQhH6j4fwRfdXLotcEw3hI6a/Dx7UoIjXT0+ZCvJg7atSk+oStXAl2htMDu6LBtIRaVZ1FClzlHaZwgal2nvQhImvtIGgo8zTAQ1fVgWIfQ6HrUk5PZmMM7Ae9XHwIAdLAXob7YlwbJlgQlzEPBMlN14OFdd7onqv/z949kUEob1PPBWnFd+wQ1azf0LASw1OY9m98g/LrWFew6ZQTplutHK3KMrzXWrsrxxHMxIAyjKPZA3Fpoo71aurQOiiotq9+Fn0tfM2U1XXq3k4iJrNDtDsnrrf/iHzQlwyKVS3VoVHCoAsSNuHr4xhVBKvFagXv3hmhnXXGX/GvI+zCDutlaboEoyVj1Oe8OZm6c21dZg52UrwE7mJKkTkFME/u4n2sfr4lgpsIWDuiTyC2wuLZaz9A1blEMjT2mPjRzDHGU3w9241S9n4WS+oGiixe/maAriq4hUOyKxgDxtApJotAA8JtVj5LuTeE/tXy0MeTO3CRSXoH/gKx4+tKfSvI0XV7KvnxtfYgUq1xuoKi4oW9Zvmpq9bHtDTMj9GQ0forZG0992JHF9ooZXhT3M9fZQIB8qyqfpWfX6MZ50Gs47MeeuGVoZjBFjTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(6636002)(6486002)(478600001)(6506007)(83380400001)(8936002)(2616005)(186003)(26005)(41300700001)(31696002)(44832011)(5660300002)(36756003)(86362001)(6512007)(4001150100001)(316002)(2906002)(53546011)(36916002)(38100700002)(31686004)(4326008)(66946007)(8676002)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGhoUEhEdmpjZjBvMjFQQmZLdHNTSW5zL2s3OVMxMUJUbU5BS2tBczUwcTgy?=
 =?utf-8?B?K05YOXd3QUIwRGlOT3FUSTgyZ0IvY0t5QjVmQlNDbk5GY1UzTGZrWDhRd05i?=
 =?utf-8?B?dzYxaEpUby81cXhXcCtDYW9FNmxMT29UN0hTUXpxMmNPeUt5MlFkZmFkMStz?=
 =?utf-8?B?d1VNMWpPU0RQRytGZ054dHRDaWZOVmNxWWVUYVVsVS92VGhyL1JMa1piR0o5?=
 =?utf-8?B?VjNzRkFNR0IvcFZqb2l5cGdLbHRNTmRDNFZhZnUxWFUzUDdKUThqQUJUZXJI?=
 =?utf-8?B?a1IwN0o4WHpPd1FGeHByMVpwdjZBS2xuRzhZYWh0SnJ3NGJPa3NhamUzM0Zo?=
 =?utf-8?B?dkxKTUxnVTNEVHByd2JPTk9MMmFQbXozRmxXR3ZFL2FjOE1wdSsvM0p5M3FV?=
 =?utf-8?B?Y0pYMlEwbWk2amVsOTNzNjY1Z1ZYTU1mZEQ5c3VhM0hyVWx3cTV4MXUwTzlo?=
 =?utf-8?B?dlhYNDl2MmNMclFDbW41QU10ZDVKNzhvUGFrd1VSa0V1S3BhNkRaSFNNQXMr?=
 =?utf-8?B?elFWTmgzZmRpTHR6Tmw4V0kzZytrTDVtTllyUWdBMmY2a0w4WC9weW5CWlpo?=
 =?utf-8?B?VlVmSktNY2Y4blljODhXbmQyTUNpMy83c2JLa2VkTWg0d28rYW9nV0xkemFQ?=
 =?utf-8?B?T2M1a1NCOTZSd2lxcmkwTEY2VjVweHVaZWtmaFQ1bld1V0RFYW1NUTdjTUNq?=
 =?utf-8?B?YmNtRlNVcHZLdXAzVzYxc0xJY3NlRUJyQlM1SFdZT1JETnRmRUpaZzVZMDRR?=
 =?utf-8?B?Zi9HZGJRVjIxT21uZ0Vuc1BLdEg2WG14WlAwNFkzaVlLaGxnelVOazBMSkNN?=
 =?utf-8?B?S2RmbFMzbkF0dW41am9CQWJzb1MzR1RPZFp6V2tmYXRIbzBNMDl3d09EeEkw?=
 =?utf-8?B?Z1BZalUyYVYwbjI0NTJDeS8yUHY5eEZGbEpwRnMzS2tpNC92UURUeGNpWFQv?=
 =?utf-8?B?RkJZczIxS0lWRDRKTnJDVWFvcjl4alFqRWcwMXhMQkdjMFBQcmJYVkhoM3p6?=
 =?utf-8?B?bGp6enBqWjlsb1NTU0JTKzBNQ29vRVNuVDZCYWRjWUFwVEl5WFNTK1JZWno3?=
 =?utf-8?B?azRkNUZwZlJsSXpZRW4yRHljcXowMjdJVG9CeDVhY2YrZnNXWG5OYnMxZkFO?=
 =?utf-8?B?L3pmMGpyZXB4RDU2NkxhTzYxVXAvcDh5aCtDeTBkRWNMZnZQNzNNYWJZdXpL?=
 =?utf-8?B?V0F0WDZBME5ZbytMQ3ZKQUJKUzYwd3dhb2I3RlFSRXN6TmZHbFVHN25KVThn?=
 =?utf-8?B?czZNWHlQejZJSDQ3ZGRGRFpwUGkwSjVQZnZOTVJvM01xajlTM1owQnNTT2dh?=
 =?utf-8?B?SG8yWlg3VEtKTG53S1RteWs1cytLNm8vVkZ0ZEhCdTAzS1N5dFdqb1I4Z1E4?=
 =?utf-8?B?L2Q4OC9ldlhhdU0yWjRCNGRaWnZGelk3QzN0ZW5zYkxnYWZML0pKa3JBOUZT?=
 =?utf-8?B?aGxrVXUrdzd3cXdYb1YzSUlpcnFjUngxaUQrN01iN3hEUzhwQWtKNlZzcHZu?=
 =?utf-8?B?Tm54YzY4Q1pmclFjbVpLNEtpaER1bEFTeHVxNmU5N25OdlBrLzRoNFZqNmUy?=
 =?utf-8?B?MStBWGsvWjNrZTJzV0tseFE4blp6MVI4c213TkRud09NQmZxcXZOa3gxN1dM?=
 =?utf-8?B?b09vVE5xZUNYZmtaOG5SUm1GQXd0WnNzcEZQcktLdVk0SldsbTVENGxkbk5K?=
 =?utf-8?B?aTY5VGc3RWkyTDl3RVFJS0hxb3Vxdml6V05mT2w4WWdnWFRrV1V5bTM3Vm1j?=
 =?utf-8?B?cFBtWWsyYzZDbkxYMzRWQjlRT0ZhUC8wSHUwbXU2aTV4bWtqb3ZsclVFdzRN?=
 =?utf-8?B?dWxoa3RLajRDRnBmOHpVdFErdHljUitoVDNvUFQwMzNqbnRKRXllaWllangy?=
 =?utf-8?B?MmF5b0N1Z0k0WlhmcVhhUUtqQ1prN0FYZUhZdis1YjZKbm0zWHRrNUZQMHBG?=
 =?utf-8?B?MDR2VVQxTWpqUnBMVHlNanpWV3hKTWdkWkVBaS9VcWRBZStURWNZc21PTFl3?=
 =?utf-8?B?aFU1RGJ3aVN3TStZZEpKTVM0aWFDQ0JyRk15NE9aMVBVWFV6Vy9venpPTFZX?=
 =?utf-8?B?cEgzSEJhQWgvK28xb210cGh3QmVzUDkva3Fzbm9td0pENW9JaXRRRnJWQ0JI?=
 =?utf-8?Q?4b144m0AfqWHmmbx3k3A7R7ZI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d2bc47-7a94-4189-45c2-08dab92178e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:17:44.1078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btQrmLwccrqyljvc5vmg8IjetLpRueNItn9kD858oGxlfc0CDjXkWmx9SGZy/cotA5OVzh604swc0XqhG0jdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-27 04:14, Ma Jun wrote:
> For some GPUs with more CUs, the original sibling_map[32]
>
> in struct crat_subtype_cache is not enough
>
> to save the cache information when create the VCRAT table,
>
> so skip filling the struct crat_subtype_cache info instead
>
> fill struct kfd_cache_properties directly to fix this problem.
>
> v3:
> - Drop processor id calc function
> v2:
> - Remove unnecessary sys interface "cache_ext"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 307 +++-------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  12 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 238 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   5 +-
>   4 files changed, 278 insertions(+), 284 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index d25ac9cbe5b2..8b7e34b45740 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
[snip]
> +int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info)
>   {
> -	struct kfd_gpu_cache_info *pcache_info;
>   	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
>   	int num_of_cache_types = 0;
> -	int i, j, k;
> -	int ct = 0;
> -	int mem_available = available_size;
> -	unsigned int cu_processor_id;
> -	int ret;
> -	unsigned int num_cu_shared;
>   
>   	switch (kdev->adev->asic_type) {
[snip]
>
>   	default:
>   		switch (KFD_GC_VERSION(kdev)) {
[snip]
>   		case IP_VERSION(11, 0, 0):
>   		case IP_VERSION(11, 0, 1):
>   		case IP_VERSION(11, 0, 2):
>   		case IP_VERSION(11, 0, 3):
> -			pcache_info = cache_info;
> +			*pcache_info = cache_info;

This won't work. cache_info is a local variable. It will be out of scope 
as soon as this function returns. You'll need to allocate this in some 
data structure that will persist after the function returns. Maybe 
expect the caller to pass in a pointer to an array in their own stack frame.


>   			num_of_cache_types =
> -				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
> +				kfd_fill_gpu_cache_info_from_gfx_config(kdev, *pcache_info);
[snip]
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index e0680d265a66..dc231e248258 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c

[snip]

 > int kfd_topology_add_device(struct kfd_dev *gpu)
>   {
>   	uint32_t gpu_id;
> @@ -1759,6 +1970,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   			topology_crat_proximity_domain--;
>   			return res;
>   		}
> +
>   		res = kfd_parse_crat_table(crat_image,
>   					   &temp_topology_device_list,
>   					   proximity_domain);
> @@ -1771,23 +1983,31 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   		kfd_topology_update_device_list(&temp_topology_device_list,
>   			&topology_device_list);
> +		up_write(&topology_lock);

I'm not sure if dropping and re-taking the topology lock here could lead 
to race conditions. But this could be avoided, if you moved the 
responsibility for topology locking out of kfd_assign_gpu and into the 
caller (kfd_topology_add_device).

Regards,
   Felix


> +
> +		dev = kfd_assign_gpu(gpu);
> +		if (WARN_ON(!dev)) {
> +			res = -ENODEV;
> +			goto err;
> +		}
> +
> +		down_write(&topology_lock);
> +
> +		/* Fill the cache affinity information here for the GPUs
> +		 * using VCRAT
> +		 */
> +		kfd_fill_cache_non_crat_info(dev, gpu);
>   
>   		/* Update the SYSFS tree, since we added another topology
>   		 * device
>   		 */
>   		res = kfd_topology_update_sysfs();
>   		up_write(&topology_lock);
> -
>   		if (!res)
>   			sys_props.generation_count++;
>   		else
>   			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
>   						gpu_id, res);
> -		dev = kfd_assign_gpu(gpu);
> -		if (WARN_ON(!dev)) {
> -			res = -ENODEV;
> -			goto err;
> -		}
>   	}
>   
>   	dev->gpu_id = gpu_id;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index dc4e239c8f8f..3e8ac87f0ac9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -87,6 +87,8 @@ struct kfd_mem_properties {
>   	struct attribute	attr_used;
>   };
>   
> +#define CACHE_SIBLINGMAP_SIZE 64
> +
>   struct kfd_cache_properties {
>   	struct list_head	list;
>   	uint32_t		processor_id_low;
> @@ -97,10 +99,11 @@ struct kfd_cache_properties {
>   	uint32_t		cache_assoc;
>   	uint32_t		cache_latency;
>   	uint32_t		cache_type;
> -	uint8_t			sibling_map[CRAT_SIBLINGMAP_SIZE];
> +	uint8_t			sibling_map[CACHE_SIBLINGMAP_SIZE];
>   	struct kfd_dev		*gpu;
>   	struct kobject		*kobj;
>   	struct attribute	attr;
> +	uint32_t		sibling_map_size;
>   };
>   
>   struct kfd_iolink_properties {
