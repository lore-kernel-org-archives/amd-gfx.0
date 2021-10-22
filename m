Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA706108B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FA706108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733626ED1B;
	Fri, 22 Oct 2021 11:00:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5006ED17
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 11:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEr4ssaPkp1yGbyo1XmcrNinooT+Ho10sKJY+0pgLTtSdrLS9CjGmPjxAi2yz0Q0J3rzEL7WjDR2KNB+757Zk8jc/crloUHBz3bYu/GY1N/RAiO7gYsjNS/Yqf2DSf1MyrFx8GEyqWsi3UpQaahDpaknWzdwcLWMisZ4Ds39zM0rMRl8YW4RIzK3P1oznzgtuXs+hsoImdVaRw41Prd3VfFtXFcpeAF9z910ArgXt3cK/2YWgFzlub4/gEN/6wpv5BSfPpbpRCfVBxI9alNXCkPUq8GxyS6MRVl8RxXTkckarsAINzWn5RBWldNAz0VD2YppF2LOjZqncXBsP+qGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMyhwGxH5Nc6AneSlDhcPWvtepx/iXkdFQaccZqtBpU=;
 b=FZr71CVJmAWAn+wJEOUyVjLZ32MmIkjMpWeXUVkRqJFSUnvJsn4LoO+HYlkp45BszLLRUNcKFlDkYjQpIW84+Rxp7f7mXtP6SRtQPKFcuxfMlgl3w0SAQ7h0Z/yiPimv0mWt6xmOuHxZSNOi/Y5TNye4xnFtxYoAiHJh9zz0YJKU6k8Yoy7ykTfdn5rcKfxxJnLPkGlJKeqfmkH+xxIdKDgCyhuyw1ZWPdDUiPkH0WkQsBsf7R/VMFdvafV41/ppVKOwX057oZK5x7cRtwpNoYONAlVy4cAiSPjD+0Crbdx2XYh0gd2kwQGAg+f0mYkaYef1S2dqpruFP9Hx0lqVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMyhwGxH5Nc6AneSlDhcPWvtepx/iXkdFQaccZqtBpU=;
 b=skx4tAjzR/fMksZRQkP8GMqunXPZ/SKxLkME75tyiWGGz2XrcH2lnKgoBvb8qoJptl0caZKO+XKjL8lTzkBT04lpLSFpV2rakfSopjAezyXORcV4DzzWS9sFbwiUPijF8w07ic+001QehHgpAgU2NgjeA0p6I120BjdpBbpfaJ4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 11:00:01 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 11:00:00 +0000
Subject: Re: [PATCH v4 3/3] drm/amdgpu: recover gart table at resume
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022105423.69769-1-nirmoy.das@amd.com>
 <20211022105423.69769-3-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f6d03a04-0468-140e-84cb-50969ac8779c@amd.com>
Date: Fri, 22 Oct 2021 12:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022105423.69769-3-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BN9PR03CA0944.namprd03.prod.outlook.com
 (2603:10b6:408:108::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [10.254.34.194] (165.204.84.11) by
 BN9PR03CA0944.namprd03.prod.outlook.com (2603:10b6:408:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 10:59:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62f40bc4-2f8f-4a0e-019e-08d9954b17e4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53915D321CBF4CA9F8AD52378B809@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjEvBqbaM4j9JvFC6vJUHKXMmtj6+twdDd6yuH3PAnPxn2xWBpI+P+Z9VaI5KNxfzJrMNTqpq3U/+TffprimgzMqZXuqNhmn8BEMjhcJ3o0NxKXISnkpPBJtE3jfemdtJeYeeQUWhPszr8qH23OQ1cTA0Cohv/5xV3Vd1gegrPJP9EHwBWHwLpLhgiKiOIlpNp2RPKDUqmYgaoj2bAWBQ/rzTw32oA45UBlRaNPz7U4sO3QpZMDofpux423Ukf/3imKGJcxsSEmiSdOyUiC1K4colwnWpeLE7eXtWnMo88yVbr7GdfwxAfNXoCiDxGyE3jJMJkESPvlZYvayB50AgAP9naVg+9yHqdaSAZIlKyCQ+wEhgJhKAHAaA0zPwPth+NiPVELwE45OnNMB4EoVKdX/Iiflhm//qDWkNUpaW6I2ekEB7d0HLU9zQfzZNCyssGy6tLKJy/rTKjl0/Lcqa0jatv8xLm4L4SfesVuI0FolrvFsiofmDwl07bGg+fls2mcgYHekq3YE8W0GtXf0kPNz1AQJ4tK03duXNSThRHHl0gCslnSeCdrebXzvfv4akmzszLBaNRDK2/Fqv+kzlwX+qOBngz7p7N+rs0fMlSULxfwDlThKNInKn9s7lMLECoPLjewu5dZk9BetNNwBZBL2jQyfg+AC1XCtxn+7GduRTAZQha2F/E2y+t4c1/QvYO3GFo6WGgF44fgpkKY3rrP9ybWVvvJVNolMk+mC+2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(8936002)(4326008)(6486002)(186003)(316002)(38100700002)(83380400001)(8676002)(508600001)(5660300002)(2906002)(53546011)(36756003)(26005)(66476007)(31696002)(66946007)(66556008)(2616005)(956004)(6666004)(16576012)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJZbVRQVitsUys5NnpoelBqZHgzY3NqRG5nNjdQSVlnQ0llUkh6R3c4UFhl?=
 =?utf-8?B?Y1BFRHhNWFRqaDkxRi9sUXlCaS9JcS9mL0srbkpKU0ErcVNlcndFWWZ0ODl5?=
 =?utf-8?B?S3hzdFVCU3JWVFZiem5Fbm5vcTJvamQ0bHRtUStBTmtCNU1KUWFObW9WVyth?=
 =?utf-8?B?dUF6UUZxckhZN1FabXVrbFIxcmV3SDM1dUtma1MxekZrR0hKRVdZTnBjNUF0?=
 =?utf-8?B?TGk5RzM5NGRveldRTGhJYnR6ZTdWMFF4bDV2L2hxUnlqUUVFWVhQa25sdkZU?=
 =?utf-8?B?NzZ1TTNMdnFHVkRhdENaVjUwL01QNEdsbUVidXpvVEtBcTlyZzNrTWU1d1dJ?=
 =?utf-8?B?VUk4NURBV0prcnhsbkVSZjJQVkd0QUlDanIzU2hHNWNzR2krbG9VUnByMVQ3?=
 =?utf-8?B?SXBvOUdGQWsyeXg3dWNFUUVTSkEwNnRTczZoU2lWcjFTc3BuSWJqUWozeWdn?=
 =?utf-8?B?czhpVS9qdUhKV3FtMldOSk13MDZOaXpyV1BwdGNXRlZ2QmxzU1BYdDczM0Q2?=
 =?utf-8?B?cjFBU3dSK3loNThaVkhTTHR6L1hGZTZsQThUdlJ1dXJ6a205dWlqdzFMa1Jp?=
 =?utf-8?B?by9nbXc2ckE4V3Z4ZFNSR2RiRkM2Q3ozWllSMFBzNDcvTU40UytwbjZhazB3?=
 =?utf-8?B?Y1cxc1dLZHpUbWV5UjVOMlVWQWF0MThvR3pVM0ZvMU9RcGRZZVNjckcwWG83?=
 =?utf-8?B?YlltQ002TUVWYi9jUVBQbW5CNnEzVmpqVDJESjFhNHJ5Y2VNVmcvQytoTity?=
 =?utf-8?B?ZkU5RkprQ2Z0VmVPV1k3aWY0Q3JFeDZxNUJKOVMyakJTVWRESnlOcU5Dei9t?=
 =?utf-8?B?Mm0zS3FRRi9YY0t1UkNGbUFyOER2b01YVCs2OW1jenZoR2lNTERDK1FWRzVH?=
 =?utf-8?B?YW5jZElsR3o4dmVHVTM1bWJTRVRjSUlJOEcxcWhxcFNBUitVWkFMNWFhbmJo?=
 =?utf-8?B?M1g1blF6clBpYlFud0pCVzlDQlIxN1ZEMHRFOHJjelJwM2dtNW1kcEFHRVIy?=
 =?utf-8?B?b1J2Um5IZ2xIZysxOTJnYjZiaWorUGJkcXBIUTVIZWZROTl5emlBOFBpeUpw?=
 =?utf-8?B?Nlo5eU5IcXJJKzZIQW5OT3A3bzZnVm8zSEdOcXRDK3J2NzdkQ04vaGRabzNt?=
 =?utf-8?B?LzE4YU9KZEx5RUdCUStnRnFQZUJIMHlGK0dBYmlFc0Jnb0djU0xuMGpOTHZJ?=
 =?utf-8?B?ZHpWMXdIVk05L3JqRk9QUEgwdnJxbTBtZ0JnVUloaGR5ZnlsUExteG02YVlE?=
 =?utf-8?B?N3NoRzkreEFjd1R5WWFTeEYrRWQ5MlNnb1cxZ1JGWHk0R2pjSHp3dnZhdmwy?=
 =?utf-8?B?UTcyQktFME1jSEdBSmxleUVUcDBVVWJNaHgzRi9CQzU2eUJzMmV4enRyZVBo?=
 =?utf-8?B?OGNXdFAvMFVzUU5VMFFnNjhFUVVPOTh0Y3M2STl3QVREczRsSVFzVGpTRHMy?=
 =?utf-8?B?SnhpQzBEaHNuQjYrN2g1MkJZY0NNZG8vM1R6bFdjUDdBVmhiK1pkcVY1NlND?=
 =?utf-8?B?ZS9mWkZGSjVKaUlDMGhCQ2RsNks4MnRudFZRSU8wbHMxaE1TR2ZacTFNcTR2?=
 =?utf-8?B?TkxlcXpFQzQ0cituM2NJbEt0QmZncTllV1JrN0owQ3lEamVPZFdzUzFnL1E0?=
 =?utf-8?B?cjJETVltdjl5RGJtMkY3L3pTN1VsWjlFUzdYS3c1ZVVPeFFGOVhOZmZMSjVL?=
 =?utf-8?B?UjJGKy92L3FzeDJLM2cva0FQRFF3TXZLYkFGYzM5c2hVelJxV2hicmk1c3Vy?=
 =?utf-8?B?NTJsZ09wQmdFNVNkbWpwcEFmeDBwVHErNmc4NlJmR3hOaVJBeHc3ODlieW5Q?=
 =?utf-8?B?TThwTzBmVGZ4UlhHdGkxQWhrTUF4N3lIcHBoL3hjOWFRblFUYmVNV2FaYVBl?=
 =?utf-8?B?bE1jYUpvdndvbUQ1Zi9wb1YwdGJFQnQ3U3pYdGhodkhQMWZyRFFvU0hqcU1y?=
 =?utf-8?Q?VezX2FcpTVQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f40bc4-2f8f-4a0e-019e-08d9954b17e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 11:00:00.7481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nirmodas@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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


On 10/22/21 12:54 PM, Nirmoy Das wrote:
> Get rid off pin/unpin of gart BO at resume/suspend and
> instead pin only once and try to recover gart content
> at resume time. This is much more stable in case there
> is OOM situation at 2nd call to amdgpu_device_evict_resources()
> while evicting GART table.
>
> v4: return amdgpu_bo_create_kernel() directly without checking
> its return value.
> v3: remove gart recovery from other places
> v2: pin gart at amdgpu_gart_table_vram_alloc()
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 82 ++--------------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
>   7 files changed, 11 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b53d86aebac..f0c70e9d37fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3935,16 +3935,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>
> -	/* First evict vram memory */
>   	amdgpu_device_evict_resources(adev);
>
>   	amdgpu_fence_driver_hw_fini(adev);
>
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
>
>   	return 0;
>   }
> @@ -4286,8 +4281,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   		goto error;
>
>   	amdgpu_virt_init_data_exchange(adev);
> -	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,10 +4597,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>
> -				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
> -				if (r)
> -					goto out;
> -
>   				r = amdgpu_device_fw_loading(tmp_adev);
>   				if (r)
>   					return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index d3e4203f6217..3525f87dc1af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -116,78 +116,12 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>   {
>   	int r;


I forgot to remove this unused r and now resent[1] this patch again but 
forgot add in-reply-to.


https://patchwork.freedesktop.org/patch/460939/


Regards,

Nirmoy


> -	if (adev->gart.bo == NULL) {
> -		struct amdgpu_bo_param bp;
> -
> -		memset(&bp, 0, sizeof(bp));
> -		bp.size = adev->gart.table_size;
> -		bp.byte_align = PAGE_SIZE;
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -		bp.type = ttm_bo_type_kernel;
> -		bp.resv = NULL;
> -		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
> -		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> -		if (r) {
> -			return r;
> -		}
> -	}
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_gart_table_vram_pin - pin gart page table in vram
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Pin the GART page table in vram so it will not be moved
> - * by the memory manager (pcie r4xx, r5xx+).  These asics require the
> - * gart table to be in video memory.
> - * Returns 0 for success, error for failure.
> - */
> -int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev)
> -{
> -	int r;
> -
> -	r = amdgpu_bo_reserve(adev->gart.bo, false);
> -	if (unlikely(r != 0))
> -		return r;
> -	r = amdgpu_bo_pin(adev->gart.bo, AMDGPU_GEM_DOMAIN_VRAM);
> -	if (r) {
> -		amdgpu_bo_unreserve(adev->gart.bo);
> -		return r;
> -	}
> -	r = amdgpu_bo_kmap(adev->gart.bo, &adev->gart.ptr);
> -	if (r)
> -		amdgpu_bo_unpin(adev->gart.bo);
> -	amdgpu_bo_unreserve(adev->gart.bo);
> -	return r;
> -}
> -
> -/**
> - * amdgpu_gart_table_vram_unpin - unpin gart page table in vram
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Unpin the GART page table in vram (pcie r4xx, r5xx+).
> - * These asics require the gart table to be in video memory.
> - */
> -void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
> -{
> -	int r;
> +	if (adev->gart.bo != NULL)
> +		return 0;
>
> -	if (adev->gart.bo == NULL) {
> -		return;
> -	}
> -	r = amdgpu_bo_reserve(adev->gart.bo, true);
> -	if (likely(r == 0)) {
> -		amdgpu_bo_kunmap(adev->gart.bo);
> -		amdgpu_bo_unpin(adev->gart.bo);
> -		amdgpu_bo_unreserve(adev->gart.bo);
> -		adev->gart.ptr = NULL;
> -	}
> +	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
> +				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
> +				       NULL, (void *)&adev->gart.ptr);
>   }
>
>   /**
> @@ -201,11 +135,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
>    */
>   void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
>   {
> -	if (adev->gart.bo == NULL) {
> -		return;
> -	}
> -	amdgpu_bo_unref(&adev->gart.bo);
> -	adev->gart.ptr = NULL;
> +	amdgpu_bo_free_kernel(&adev->gart.bo, NULL, (void *)&adev->gart.ptr);
>   }
>
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..2440278a3b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,7 +992,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -1062,7 +1062,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0e81e03e9b49..3a8c9d4ee06a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -476,7 +476,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -608,7 +608,6 @@ static void gmc_v6_0_gart_disable(struct amdgpu_device *adev)
>   	WREG32(mmVM_L2_CNTL3,
>   	       VM_L2_CNTL3__L2_CACHE_BIGK_ASSOCIATIVITY_MASK |
>   	       (0UL << VM_L2_CNTL3__L2_CACHE_BIGK_FRAGMENT_SIZE__SHIFT));
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..ab8adbff9e2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -620,7 +620,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -758,7 +758,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..cd3a4bd8fed9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,7 +837,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -992,7 +992,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..8732da11ad98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,7 +1714,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -1793,7 +1793,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v9_0_hw_fini(void *handle)
> --
> 2.32.0
>
