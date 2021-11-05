Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121B861037
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 121B861037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75476E578;
	Fri,  5 Nov 2021 20:56:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DDF6E578
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 20:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4EKNWkNiF+aVFUdYi8XbMy3DqUnLi1R1+/rpkX+qGCTvIt1J41ysz+oXKROq3vhOnYsVL04yEXn5+qW2fMVhLZCrrD+3LyjMVHogEiWCEyWClsBnp/dDg4+SlahEliyeGPV2CoGi5OItfxGwb8yrTAt5RTJhXgQBLpNf3VqR9Xjeyqwx1eg2X/b+U3RqC6IQmHXE3TH0oUA+RUmiz93KdcMfjSm2jp3SKrsd369FgGtD+6NsWlFsoZlzaxGi+Hokpf4irz+CCm13LkuBg13L34hAvj2o1Nqqk0V0OmV8CTgZuBfAp+C/7nLBKZkPyy7g6A16QbA6cirBRkV2h/zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PehfoLoi/pC3NLBEhopyQLt29b4V8c4KbEeSb97TmFA=;
 b=I3Q6oPKVM3nUpoj5NdTuFb6/bYL7lVa1gZPjZvlQbHQfEEWvbw4M/flKAJSUWdiipdFHBCcp7SU0Du0YatLO06v6LtwJTTPKM5z8xS1LmwvF6g2q0cdL46jDQNBNM1O4uDkd8vA9wX4gaS2KHv1hmc/yxSazZLmNbf4dtVX1sgCMF9puXzUUp8q/OIYvVvYWiGpts+2Hz11D44DZvbnDa0bm9RMw1HpZNrqojm+OYqvViHFAUS8PtWlistJDTVyovDaGpSZrCs+WH2O9+B5DHlvvJvn/9b4xLSiiiK2L4dyipf6+nyJyMoXtC67dtmIS1d/EY4KFXQCihLpU3eXE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PehfoLoi/pC3NLBEhopyQLt29b4V8c4KbEeSb97TmFA=;
 b=bZNpVVUboPhk+AAU4PgMV3gt3gtwQ9WU2dYYp9mXQkGYZnBdJZO5yskiytP+fnm2FIvsIAU4RCxrW3887UtyfaSTyRJySEnCi7L+8kGBBzfBy1NwPxDAiIU4c8ZkEyFDPxMf2n2r8KOI0SHJURHNY5FYj8AbDtNTRyFEQwlZ6ME=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 20:56:21 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 20:56:21 +0000
Subject: Re: [PATCH] drm/amdkfd: replace trivial funcs with direct access
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105184348.2155143-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <d1c5cb73-3124-ccfb-9480-1eb5938c9cfb@amd.com>
Date: Fri, 5 Nov 2021 16:56:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105184348.2155143-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PAZP264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::12) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PAZP264CA0089.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 20:56:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58ac0288-cd12-4ace-8679-08d9a09eb834
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383524B7773DC9A4E3B546E7928E9@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIAkCG8vZs1H1D72WMgcYGw2a+ZinjcaOIQzmFTYOt1hXSz/yeM8q+gDRl8A5jbIO9Il0tHDiD+18z/r9H/iG37wqpbpmIOo1SofAQMVMAlxOBWQV/y3lD6sEAx1Ah1ZWqJgWRQD8C9EUmrEieKXBe+Efs0FB6YsglkwhiQOQaRakfZG2ZXlB3Otv04rcw1lLjjb9Msg58ol6Rz+QoN3TqnbRc7Uf4gqxVcxMZ0zGsA8vfg5/nChTLqAed3w8RQk4FBSKvDgahq9843+GH/ktE0KOjw7f2dXXTjFf1YmCTAU6LUTKM6c7MRPZWlSQNt84NRkOiJAO+rwK3Vada4SoSNtr38bn+UJB/ztjWZYz6+3G74TAjH8UTeaJyYrF6T5qOlAGF5U/MXO4F66rKTZqa66eLCjKCnzqNScsLneGe5GhK83yVpYasrNTXFZvZDLsWK6elmaEvLAB/alY0QqxaizuqNtBYTmAaqvTT4Y6537ZBI4AToMWdZOwKRC5OAwBVy7DUjFPJY7QBKFD+SHmgH20pum0q4LF3FBFpyyHEs6/gXTBl6H/4rbcJ293pa2EP7wjSa8YMgtiuXjAL71NrOMV/GQNqE+1tOTcgBGNoF1TT9Eol0kYszzHNYeAA8LgNp96l96zFH0JfOqRgy6AillpqLHvlxueBzMX4VvoBsY7tJ3rNHFMYvXjs8SCiFmEg9br+33k/mETxkUeMkXnUA5viBjEzthqKojH5GI5YX/2bRor5CJehXcclEeaxtv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(5660300002)(4326008)(44832011)(508600001)(36756003)(36916002)(53546011)(26005)(66556008)(2906002)(66476007)(8936002)(66946007)(316002)(16576012)(38100700002)(8676002)(6666004)(956004)(31696002)(2616005)(83380400001)(31686004)(6486002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdUWUxSWlpWaklJcGtUN3g3WC9LNDRnVzRBYkpVL1dzQ3ZtQjZlTU9QTFhE?=
 =?utf-8?B?Vkx4VDFrV25CaU1Cb1ROUDZCM3dOQWdrMnZ4YXFGWHJzb0tSMnNCaGczaElI?=
 =?utf-8?B?RUhUYWJ0Q3ZVb2c3VTR0STdhV1RQY2hIaXRLV1EweDFFWFZ0T1pIWnZwRlNS?=
 =?utf-8?B?YVFKSUZYM2RSbkNSOGNucjVuRkdLeHA1ZHJlemxSU2ZGV0hZSG5zU0tGZ3o4?=
 =?utf-8?B?Y1YvRlYraDh0dVRaWWtqdGFqcCtPTG14b0ZIN2lOTkZMWDBzVHBRVEhqcHlW?=
 =?utf-8?B?TEhsMm9xTE5aNnlhdXltc0lXM2hvTVJHeHA2OW9vRzFLcElVbWUzYmRBa0NM?=
 =?utf-8?B?U041bW9OQzkzV3hrMFdnM1VmS3RFWFhtanlsL2dKbXEwRlFZZzJSL1plNnNX?=
 =?utf-8?B?eWtMV0FlRGxiSmZZUm9ONmMvc2xxbFJQU29OVTNpUml2ekMyK1c5dWVITWQz?=
 =?utf-8?B?OVpYN1ZrL3N2YkNic0czMVFVR2tMRkxhWkt5RFl5QnNYK2Ixa0tQTlB5Y01J?=
 =?utf-8?B?cTltcmk5M0VpalVNTXM5OGNXKzVqY0pNUVk4NUQ5Z1gvZTkyNDBZaTArcVdY?=
 =?utf-8?B?SjNMbURWRzN3TFNsb2JuOUtFV2hsclVmUFJoMmRxYzVpc3dYM1kwNmN6Zlhr?=
 =?utf-8?B?UjQxU3V5VHhFd3puUHpmU09sQ3IzWFRadEx6ZnNCdTFKOVZtM2FhQmtJRUhl?=
 =?utf-8?B?QzlTUnNSbys5bnVncGROdFZ6QmRYbUN3WVlQaktUUWlZZVBGRTl4ZGNTdktP?=
 =?utf-8?B?STZFQThkTURYdEp4MmFsMzJ1bDlrL0J3VlBWTDF5RHUzWThxWEJpZjVodTd6?=
 =?utf-8?B?WTZTQmZCSSsxeUhiaXNwYnowUStRNFV6VGpJMWJKZUZrL2tGR2NQRlN1QXg1?=
 =?utf-8?B?dUNCZW9RZEJ3Z1k5cGtUQmx3WXlDa0dVVTBWUVFaWlJCNStOUmIvazhJSkVs?=
 =?utf-8?B?ZHkvYnVrQ3NUQjQxbnhPdG1PR21FaDI3Yi9EN1YvMHB5bEpma2NTV0NOYUg1?=
 =?utf-8?B?azl6OHc4VTZUb3o1TGtwOGhRYVRuVy84MHA0RXRWUng2UlM2bzk2RG1uV3FS?=
 =?utf-8?B?cjhBL3c3QlNNOTZvSk96MXUrWjY5OEJaZ2dpZG1QTnJ5MDF3bmEzUzBiZkhq?=
 =?utf-8?B?WHZLNjEvSkRMejVDK3QxcUprcE5xaGt5THpBdUR0d0hvQitDZVBVZjFsQ0Ex?=
 =?utf-8?B?NVVLK3FFU3lwQW5LQXl4ZzdRVG1HQlZBSEEvaWdJZ0V2UHMrUWJxOWF4R1cw?=
 =?utf-8?B?M0JwQmk1cTZrczNEOERaUEl1eTcxekFsUEhTaGh0Y203Y0wyTE0zYjVuQ1hz?=
 =?utf-8?B?UEt0U3ZheS84VG93a1VYUklmQ2JiVXVtZHZMdEk2QkFGOFoyYUlJbXVjUEtD?=
 =?utf-8?B?cWZseno0NWIvcitWV2doak1JVmx5MExLQnAzT1I3aGc5dHJKQ1FsQnhjRXBE?=
 =?utf-8?B?em5OODJXQTlYZUppUGloeWhySFFxQk16U0R0ZjhQTVc5aFFaMWFrbWhPQ3Rh?=
 =?utf-8?B?eU1jRmYvYTZyNFNRWTZmdnlaNTZUYm5KdkFKckFrNE5BOVprT2FEOHkrK0FP?=
 =?utf-8?B?WDltWG52cDJMUFlQTk9qQkV4cmd2Z3JJYUl0SGpqWm5URjZLbVVoVWRjem5v?=
 =?utf-8?B?UUZQbHhzSEZFaTJrOW1mdXBvOVpJMkhZV1g0aXYzdXFpcXdHazdFNkp0Qm1S?=
 =?utf-8?B?NDhpMFEwdXNydVZVY1RJOXR6N0pHZ0c4RDRxZldSS0E2QzFIcGIxVDlqdHow?=
 =?utf-8?B?aHkydUlpZVpzQ08wdVB4cFhnY2dOYlNHU3Y4cC9PZC9PcGtkbW9JK2JrNXlh?=
 =?utf-8?B?NE9uT2x4SSsrODhJN1VvUUFSRTZGUW0vQmpiTDA4QzJYZ01xYkQwTnNsM3JR?=
 =?utf-8?B?R1JtTG04Qy9TZzlvbzlEZElhSDJkdFNYNkVRVEFjUnNiYUlpTG5yQjhRajJs?=
 =?utf-8?B?alpCV2dTV2FleER5bEo3RkhVWFJUQ0N4c3JMcy9Ic1NBeWR0SkNCdTBsS21Y?=
 =?utf-8?B?ZVlvNVRodWdOS1pHakJPbm5Xd05LZ2tiSEpnZTFEYU5IU3U3eGFvV2RDV1Mv?=
 =?utf-8?B?UEVJbWJET1JBaXI3UWtUeHNoL3M0TjhQem92YWlmMlp1MmlUQkM0UG9uYnkv?=
 =?utf-8?B?YWNlR3hXU1VyTzk0MGVwMGtiUUx5cndvQy94Z21DaVVBSTdqRWNNNHlqcmI1?=
 =?utf-8?Q?WwQOicnJNumzuMMo55+8JLg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ac0288-cd12-4ace-8679-08d9a09eb834
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 20:56:20.8391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O978DKzCRIixBnb6Nw2bGjrACCe6ZMqpmH/CT6bNjkTCBIoWeM+/FvGwG55PPOcZ604dQgh6xIcQ25AcyI9EXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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
Cc: Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-05 2:43 p.m., Graham Sider wrote:
> These get funcs simply return an adev field. Replace funcs/calls with
> direct field accesses instead.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 30 -------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  8 ++---
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  7 ++---
>   6 files changed, 10 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 83f863dca7af..46cf48b3904a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -521,16 +521,6 @@ uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
>   	return amdgpu_vram_mgr_usage(vram_man);
>   }
>   
> -uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev)
> -{
> -	return adev->gmc.xgmi.hive_id;
> -}
> -
> -uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev)
> -{
> -	return adev->unique_id;
> -}
> -
>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>   					  struct amdgpu_device *src)
>   {
> @@ -630,26 +620,6 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
>   	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
>   }
>   
> -uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev)
> -{
> -	return adev->rmmio_remap.bus_addr;
> -}
> -
> -uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev)
> -{
> -	return adev->gds.gws_size;
> -}
> -
> -uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev)
> -{
> -	return adev->rev_id;
> -}
> -
> -int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev)
> -{
> -	return adev->gmc.noretry;
> -}
> -
>   int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
>   				enum kgd_engine_type engine,
>   				uint32_t vmid, uint64_t gpu_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5f658823a637..d00de575c541 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -224,12 +224,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  size_t buffer_size, uint32_t *metadata_size,
>   				  uint32_t *flags);
>   uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
> -uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev);
> -uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev);
> -uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev);
> -uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev);
> -uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev);
> -int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev);
>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>   					  struct amdgpu_device *src);
>   int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 8d5021e8c714..2e3d74f7fbfb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1313,7 +1313,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   			err = -EINVAL;
>   			goto err_unlock;
>   		}
> -		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
> +		offset = dev->adev->rmmio_remap.bus_addr;
>   		if (!offset) {
>   			err = -ENOMEM;
>   			goto err_unlock;
> @@ -2066,7 +2066,7 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
>   		return -EINVAL;
>   
> -	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
> +	address = dev->adev->rmmio_remap.bus_addr;
>   
>   	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
>   				VM_DONTDUMP | VM_PFNMAP;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index c8aade17efef..b752dc36a2cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -892,7 +892,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>   		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
>   			&& kfd->mec2_fw_version >= 0x28))
>   		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
> -				amdgpu_amdkfd_get_num_gws(kfd->adev), &kfd->gws);
> +				kfd->adev->gds.gws_size, &kfd->gws);
>   
>   	return ret;
>   }
> @@ -994,9 +994,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		goto kfd_doorbell_error;
>   	}
>   
> -	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->adev);
> +	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
>   
> -	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->adev);
> +	kfd->noretry = kfd->adev->gmc.noretry;
>   
>   	if (kfd_interrupt_init(kfd)) {
>   		dev_err(kfd_device, "Error initializing interrupts\n");
> @@ -1014,7 +1014,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	 */
>   	if (kfd_gws_init(kfd)) {
>   		dev_err(kfd_device, "Could not allocate %d gws\n",
> -			amdgpu_amdkfd_get_num_gws(kfd->adev));
> +			kfd->adev->gds.gws_size);
>   		goto gws_error;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 62dc41cf2cb9..4f8464658daf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -118,7 +118,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   		return ret;
>   
>   	pqn->q->gws = mem;
> -	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->adev) : 0;
> +	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>   							pqn->q, NULL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 2e0006e22006..ae7c9944dc4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -531,7 +531,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>   				      dev->gpu->sdma_fw_version);
>   		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> -				      amdgpu_amdkfd_get_unique_id(dev->gpu->adev));
> +				      dev->gpu->adev->unique_id);
>   
>   	}
>   
> @@ -1381,8 +1381,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	dev->node_props.vendor_id = gpu->pdev->vendor;
>   	dev->node_props.device_id = gpu->pdev->device;
>   	dev->node_props.capability |=
> -		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->adev) <<
> -			HSA_CAP_ASIC_REVISION_SHIFT) &
> +		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
>   			HSA_CAP_ASIC_REVISION_MASK);
>   	dev->node_props.location_id = pci_dev_id(gpu->pdev);
>   	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
> @@ -1401,7 +1400,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   				gpu->device_info->num_sdma_queues_per_engine;
>   	dev->node_props.num_gws = (dev->gpu->gws &&
>   		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
> -		amdgpu_amdkfd_get_num_gws(dev->gpu->adev) : 0;
> +		dev->gpu->adev->gds.gws_size : 0;
>   	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
>   
>   	kfd_fill_mem_clk_max_info(dev);
