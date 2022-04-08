Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDA8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 15:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12E410F1C4;
	Fri,  8 Apr 2022 15:28:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8025910F1C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 15:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWdPYpCZ3TNW4QYKgOsWTRmo9tXmryt9EAspG1dYfy+vaehU9a3RwZv1731Dq3MlPLz1VZ4GB9rsqW1/PljIHpHk4ZT8Ru7b/eU2NGj9xsAlx30S0YSBBTkt2s2yFo0WzInoxpgvPDrQyHcYbBO005bo7gxUJbo0j7fM3301NgM55bI59U9U4ax/Y0BLEbTDyaz/3qKTD4GYKpx9NIjLJ08SKyx9F2eQqZT+CP7OZRIlWIimOcjVqbniUWEArs8NZMiDZGcGMs/UElZI/H+le2pUjRIxXLm2fOOCcmRbKb5NCo2xSEaz8tqUKmGmtbWGAVpwvWgoWuXizC7hvy2s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icEQfR1rVuLo+VOGwKl0m/Syicr6U1WYi26lFRJqbh0=;
 b=jwDra4UPGBtQc7yZRj72AZwNFhmbbrr8IO78S2gPTegATZyXDN2YvR2yxeo8tef8bOJATovam6MeqseLIfwNjNNQIexxjZz0lRZDUpxfladnYCMPIHNVjW9sYSWQgE3vnb6Z88NeFIYf1PhiVHBU+sTOroXOZaeebqdPqj9P4EShCUFwFusqw1EEGoW9XKcLWjKF70vOQEEa6Z3jfqEug6n04XadKxr4ktnEEI3WTgnHb9OrSb9nCf1wgwEAw28rJpAMwlEDaRODWB9LOO5wLeRglPeMzI5HR+Rem3LKomdgn2WZAoUx6A/VTGV8R+0QtLpeffWIyQvmrmj0OGrAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icEQfR1rVuLo+VOGwKl0m/Syicr6U1WYi26lFRJqbh0=;
 b=3lx+9zI+ZtcWbYPlSmZVWxM02wfBqxiVXDqWx6lfzrKO80TmdR/4YodPJqnlJ8OjVtz4qSMajUV4ToX9pZnaldwrGVQHxgOlazTmUs+HBquBeygb8gJvn66LId3hvhZM6T6Vn4GVlcf1tski+dUetWQvyB3LlchIc37TfyZOrtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 15:28:10 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 15:28:09 +0000
Message-ID: <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
Date: Fri, 8 Apr 2022 11:28:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for AMDKFD
Content-Language: en-US
To: Shuotao Xu <xushuotao@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220408084544.9313-2-shuotaoxu@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d79ca4b-cbd9-4227-4449-08da19746323
X-MS-TrafficTypeDiagnostic: DS7PR12MB5864:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5864187454F5A4D76ED8FF88EAE99@DS7PR12MB5864.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV+7ArDEe/VAXrrxTa4NnHXrU1gaEKscdBz1W2WIqVk9M59Sp7K8Rt97gF8532mA/rizRnoLq3XMbCaVuVBtOshAk2obZk8KXSlfHlU1l/BALI8jUZXDbRCPGXt3FI6PeZe7W1tuITwRzQ8CNTzHQUZl/zpqPe4PRtRoP2Cq+Zic5VHJ/W9B+9RK/1OLlfhnzB7cmwJavxa9nWhM2dt2emJyd75XeHu95Wtz5jJgOKhxWoN2FUCb1ZtSWzkx4HNoEJMhxZ0a5OL7QBzccG0QkQEOfxRB0oX3qOOc6hTTCpx37FRVB8HuORsdwCtDVoUYwmpU6HPZ8VCf+tjlTYguQwQcz7B4y+p5sHJrN9qHMZwQwhwh32PLEny/SLgUqt3vF/5lWpmpxI7cSr7B0cyM6/BOnoEqB60d6tLfPtpHJiExu3frqqy23vOtp9x9UkROwUrkiPsSaYp0wj74r0SZLhCdrjQZYqfwzb679RjYn9tB1s3Snk9VGC9D2Rug9w8LDKm6/nB3QgI0CsE27oeEnjQb9fgRCvMIy9drh9h+5NSJuZ4PJjk22/orKiA40SZxKNr7bkLoU43hB0fX53xxcmBze8o0r8Zzle0w2YkwxyruSLWWwMTAolXAyXeSD4HHMkVQ+/l0TUfxwV7nemPHpOhBaP7NBYE9xJgivkUuf3ZGdC3+RZByeQ/XbA6sgkr4iNu/jV3WCjhhRuNtyTzDobPNtfsnd76PqAPFxXN+xNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(186003)(5660300002)(31696002)(6486002)(6512007)(53546011)(316002)(38100700002)(6506007)(508600001)(66946007)(83380400001)(44832011)(31686004)(86362001)(36756003)(8676002)(66556008)(66476007)(8936002)(2906002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGV4RGRoaU44RDAwTi9IRmlDUU5RaTUza2RmNUdwSGJ6NnE3Zjd1Vi9JbDlS?=
 =?utf-8?B?dlNIdVhQOWNoc2laLzdwMEE5WVJnT3drd0JwNjA4L1YxTVFOUlhrWnp1N3VQ?=
 =?utf-8?B?anpZa2FmajIzNmZqM0ttYlFidzNLMUpPQ212OEo1aHVyVzVoaDRjdURGT2Z6?=
 =?utf-8?B?WlFtMElZQWZ6QU9yWHhDMDlnVWZpQ1VWTW1leHdGdlM2WkFTeTJZaG9zLyt3?=
 =?utf-8?B?dnlTakljQktKbzhnQ1lQMFE5bHNTTDR2NVZHT1JHVlE0eXlVS3gxRDAyQ1NI?=
 =?utf-8?B?RmpuckNjdkFrY3NvS3ZhS29neXFCelJhdjdhM1lyVHg4MTNvVHpzdEFyK3hm?=
 =?utf-8?B?VDJERmpCdTl3S2dvTWNiUCt4ZDIwWDdoVk9KU0MwOGhsLzJyend1SkZaK3Nv?=
 =?utf-8?B?R3EzMHNKY2VqSDVMNGl1MFV2OHZ0Y2ZYUE9lZjFrTUVPRnR3clhSQTNBLzVs?=
 =?utf-8?B?LytJVHJBYnlWN2NKV3dIU1gvTkEzcWVXVFVRZFRwUmdTYlNqMWp0dkJSTWZ5?=
 =?utf-8?B?YWwwd2ZhTXdKZ2x4cVYxckRPbmZ1WHpWWlRpeHB5Q1Z6WjR3dVFISS9GQmRF?=
 =?utf-8?B?Qlc1dXRqSHdPQ05ZY2RDREl5Y3lHQ3ZZV3cxbG9rMzNpazU5WWQwQlFkbEQ4?=
 =?utf-8?B?OEVhVmY2Z3hZV2xRZVRFb2lpSHVmb1JSeDRZWUZsTkZUdVhtRTFaaHlWeTdi?=
 =?utf-8?B?ZGhOa1EwMFYwWEEzVGxpdFh0OTNCSm4vMTdVZXpRbUxNN25YWG0yNm9tSDhV?=
 =?utf-8?B?RVVNRWM4QmJodGhyNnNmbDNRTGI5bVBtVFRCSEJ5alYyUnpFZEgwT2l4MUFG?=
 =?utf-8?B?Znl5enMzdXJlTXlNWUJiTUhrYnp6clRJOHBwWUljNVF4M1lsS2xOZHprR3Aw?=
 =?utf-8?B?WXJmeTlJQzN5aXlrVkpIOVlqbWtOSkdGd25xczRSaEVPNHZJTFFiSVNNOC83?=
 =?utf-8?B?dmxLOFp3OWRmTGpQN3lMa1hGQ2VzcU5Ec1crN3d1MmJFWE9ka0h0bkluWUtQ?=
 =?utf-8?B?WDBqOG9mWGp6M3hrU1F5MEtEMGdBYXkyVjFZajV3MkY0OWFyY1Q2NVMxanFp?=
 =?utf-8?B?NUZHTDBlVHhjQk1hSzY1bk1iMVNkNmhjUGhIZWpiOVhXYXVTcTY5N1pDdzZs?=
 =?utf-8?B?OWJZdjdxS2dIcXRPS3VpNlpJTm5tTDFEUWtpK2RITU9OanQzZHFpdVFqZEho?=
 =?utf-8?B?Q1VhajBkdWJYWVM4Y0ZrSUYyZngrSS9MVklOUkxYSnNTNFVmUXY4QTdhUFhk?=
 =?utf-8?B?cUxCS1NaTzd6MHRMeEtkQklvZnhpK3lVeXJXVmk3TDVVcXV3L2FaNCtVWGdX?=
 =?utf-8?B?cEhyM200Q2gxV1lzbGg5QTlDTGhZSEhpTHB0RzNPTGx4QitnNkE5TUovZm12?=
 =?utf-8?B?NFdKU0U4RDIwVlZJYk00bVVrQTJQZ0ppMUV3bUdTRVNldEZXVi90ZEtxcERx?=
 =?utf-8?B?RTRHc0htU2ZqOHBrZ3dzVStVM2l4aXhHY2x5S0tsZkh2MndBUkdZSGUreTBN?=
 =?utf-8?B?a2xGYlhyN0xRZGtLYU9GOWM2WWdqalB0UDdBWkNlUVVISjhqOTlTRmV5KzRu?=
 =?utf-8?B?ZHhKd2hMYndVanY2c1BmODdabU03VldYY3J2UkpaaDVwMVAzWUlucDhBaHU5?=
 =?utf-8?B?bFZjM3hjdW50WWpETHZTS3VqZUFIS3BpMGxsUkorY3V0ZEtodnZCTkVNVUR6?=
 =?utf-8?B?QnlQNGRpYk5Bck9GOFJCeW5XNFhvNG5oYmJaOC9FRWFpZUdVT3hOOFRVNDRO?=
 =?utf-8?B?RlhuZGdxNkhpajBrZWFmN1hNOUlWbFltWDBDOXdlWlNQWlM5OThJSm5hQUN1?=
 =?utf-8?B?S2RuNzR1TE5QZXZJZ3ZvbnNUYWV5d2ZHVXQyVEw0ZlV0dVNCeFUrRWtWamRx?=
 =?utf-8?B?WnhmTXU0dDkxOFpVN3RqTDRWQ0YzcFFvTVpBcmZUd1hJaWZwV3l5YlZsVlpO?=
 =?utf-8?B?NkJOVTlGQXZqSUEzYUMyY2pFVFNNbXVoazY3V0FrYWhVZzhweHJucUdBdFRk?=
 =?utf-8?B?cUE5aUZ6Tm15dXNPZFhXc0VXZS9BaHQ2YW0vaDFma2lvYVcvZFVsU1IrNzVt?=
 =?utf-8?B?ckNGYXkzMGwzTG55UWZZVjlFc0tKcEdncWIxZHVsUlA5MjhjbUM2VHovM1hJ?=
 =?utf-8?B?cnJLSmZZOFc2ZnJTdkVzc1QydUxPcmhxR01wVlRDNVU5NEhTS0lRMXFWSkdN?=
 =?utf-8?B?alVQUURNNHEyYmkxK1F5VmI5L1dEZEY3RU14MXh5UVlqV0Q4NEhZT1JRQUxh?=
 =?utf-8?B?RnF2MjdyaS9HWUgxR1E5OVZ5KzZzMmlBTld0YWgyeEszK2JObHpnait3a3Ux?=
 =?utf-8?B?YXQ4R1NXUVcyWDlWSEFXMkJrWUZaSG91a3RacmorQm9DMDJIbnQxK3dKS2VQ?=
 =?utf-8?Q?+bOkw/UsZf06wWB855SS0AqfkWxMOyOOupBteGG+xJvUx?=
X-MS-Exchange-AntiSpam-MessageData-1: 1owqsa7VkMJFKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d79ca4b-cbd9-4227-4449-08da19746323
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:28:09.8377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7CJj3ANhOKuz2cyfkiVVH0Wx1yH6kUB5XXfv5Ci/YrPV744FSF+mrNUQJ8tusa0cF0BXCaCcpMRW//hp9mUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com, pengc@microsoft.com,
 Lei.Qu@microsoft.com, Shuotao Xu <shuotaoxu@microsoft.com>,
 Ran.Shu@microsoft.com, Ziyue.Yang@microsoft.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-04-08 04:45, Shuotao Xu wrote:
> Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug of GPU
> devices can open doors for many advanced applications in data center
> in the next few years, such as for GPU resource
> disaggregation. Current AMDKFD does not support hotplug out b/o the
> following reasons:
> 
> 1. During PCIe removal, decrement KFD lock which was incremented at
>     the beginning of hw fini; otherwise kfd_open later is going to
>     fail.

I assumed you read my comment last time, still you do same approach.
More in details bellow

> 
> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>     out.
> 
> 3. New kfd node_id is not properly assigned after a new device is
>     added after a gpu is hotplugged out in a system. libhsakmt will
>     find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>     when taking a topology_snapshot, thus returns fault to the rocm
>     stack.
> 
> -- This patch fixes issue 1; another patch by Mukul fixes issues 2&3.
> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
>     5.16.0-kfd is unstable out of box for MI100.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 13 +++++++++++++
>   4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c18c4be1e4ac..d50011bdb5c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>   	return r;
>   }
>   
> +int amdgpu_amdkfd_resume_processes(void)
> +{
> +	return kgd2kfd_resume_processes();
> +}
> +
>   int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>   {
>   	int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..803306e011c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>   int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> +int amdgpu_amdkfd_resume_processes(void);
>   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   			const void *ih_ring_entry);
>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>   int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> +int kgd2kfd_resume_processes(void);
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   	return 0;
>   }
>   
> +static inline int kgd2kfd_resume_processes(void)
> +{
> +	return 0;
> +}
> +
>   static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fa4a9f13c922..5827b65b7489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	if (drm_dev_is_unplugged(adev_to_drm(adev)))
>   		amdgpu_device_unmap_mmio(adev);
>   
> +	amdgpu_amdkfd_resume_processes();
>   }
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 62aa6c9d5123..ef05aae9255e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   	return ret;
>   }
>   
> +/* for non-runtime resume only */
> +int kgd2kfd_resume_processes(void)
> +{
> +	int count;
> +
> +	count = atomic_dec_return(&kfd_locked);
> +	WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> +	if (count == 0)
> +		return kfd_resume_all_processes();
> +
> +	return 0;
> +}


It doesn't make sense to me to just increment kfd_locked in
kgd2kfd_suspend to only decrement it again a few functions down the
road.

I suggest this instead - you only incrmemnt if not during PCI remove

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1c2cf3a33c1f..7754f77248a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -952,11 +952,12 @@ bool kfd_is_locked(void)

  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
  {
+
         if (!kfd->init_complete)
                 return;

         /* for runtime suspend, skip locking kfd */
-       if (!run_pm) {
+       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
                 /* For first KFD device suspend all the KFD processes */
                 if (atomic_inc_return(&kfd_locked) == 1)
                         kfd_suspend_all_processes();


Andrey



> +
>   int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>   {
>   	int err = 0;
