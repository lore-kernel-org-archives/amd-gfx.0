Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF60C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 23:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB7610E3F5;
	Tue, 20 Dec 2022 23:15:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF92F10E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 23:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwdPClOhBUc4LXI54pBEmAfBKOqPLiWKZn9NuBGp6bYcKpqauc1AlOzFNLEQzSCoUwjDzSkldUdjWL0bMRfAEga8CUjA1+igQvIuXjoiCSZwL6vcg675WbuIYrZFnodolnsu/knkMCYQN3/2yd9FYVaW4TneevFAxnssH3Dn1NrLObf4IKpBoYd7dJBM2ToScbdBn6ae+KBAiW6m6yuft6Ut70taCoqp/Fv0n8QyYGbc/5o/PhsQi9NLyhGl0dZh4GMr/Y+SBqnNpoG9ZLpsfp6IcntXV1+QAN6wbkrk5B4sDel7o7Hag4OThTW8xC3q/IN7o6Hb3CmJNDXvj6+XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MQAhQUXXxpKAkVTkHlaNmQSbsQ9AQjqtxtRr9zChSs=;
 b=YC6k7f9ErSJKVIPzzCWzxGCXH282Wh9FVvQ+fK7YZAjAeq8njgq1CatVzt2wZTpNdljO5x8QsCNTn/0aKcTX3E5QV2/pghPn9z4aFfwnSDxXUl+4aPYQsyqhwDd839TLSCNZgHhNYhrFJNHMI2mpdfUbwef+nnv2Zev/TFdWwfiZKnGzSIBB/N0/QHZpEUoYEjSh68Xag3Be2VIV9+xshS118y7f87kqQKPOLwxwFWqCA/ptbwQUoWoQYIFZ1ycTa3VA82IVzctwzESHJNt5Ow5++klfFJWNc1kjhIHzzJqnOkSfmTHhEkjx6utv8K8029fHW8svPq0Tvd3SjmpoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MQAhQUXXxpKAkVTkHlaNmQSbsQ9AQjqtxtRr9zChSs=;
 b=xJsEYSC9Gah1VOaCB6UYIJ78kzf4CfrTKut5BheLghjCst/HWk8LPnuAkwa55wMOf31s3u+0kgWKndmYedJBilzJVvJ19xe7lc1YGaKgcgQJRwbQjGXZSsEYjBdZN9IX7wnI8Vh6rEMEE2lPEV4pqwMpncWCEeD5GOCiOvZQ2ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:15:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 23:15:45 +0000
Message-ID: <3d09d354-4c2b-54db-fbbf-d56f277ec364@amd.com>
Date: Tue, 20 Dec 2022 18:15:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Fix kernel warning during topology setup
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221220225031.2182712-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221220225031.2182712-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d9854d-db08-4082-1a3e-08dae2e01f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uc0ZjMZNhK0BS++DnE9u+DbXMDIjWJ7r6u70PTROzOYhyZrcPp0ByohnE05S0ISOHmlm1yzcg3DChFoNKRPGc09hPx8/dYquTh8sPjTCf/D0Dq69kz7viS1OmKXCUOZHTYXsen3NZVzL2ILBZwgpy4I/58x9iuMoA+jJfuirGRnvfEzMElCVZGRezvXOErOWnvmyE65k8KKHtq4nh6jKv0tjZ00/pYgpbw3sSuO1p3a9PpxFFDE811/prrTGcokZRxKWUWUYC+K+4OdMfrwyj/qTKjFcoIfeGyHeDDTq8FHx6TG+ZndQqJtYvWcPdnFKsZKWTtO9sIZxFeTbfx10TuwZ5v2BzG8LHjYZM9ueoeQMtLn+yIGn3+BI3dbnQ5sRM0goyz+sR3Tv8vgNYgZrxu/Uqzxi8vI5UTUPZ3zX54UkIHxnyWUsiNvNfFjssmClas+UUXWTHUDQe5CWQB3Y/9ESTRZxgVEoHYIhm3ThyKJb3+24+DGra2AF6SoijMbH5AnXhopD7oL3Y8P9VNwkcKGDxJlj3jgdwOSF2OrBSrS3xieIHlXc3ExwFl0MGwWCdffIWGyVM+29aWdD7P53gfdyNFCh8r4ZX34JmxeGWYu8Pflm12hkChLGEVNcVLDMCjhxsqVHfrF22qpZE8Gq3cVfxf2y1rda213AxXC8zi+qDZzCg4g1YwpDby+xcSJE4aCdvhOpgw74OJLRWlJLpuNPXxob3L6mImsWBFxkB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(31686004)(2616005)(66556008)(66946007)(38100700002)(66476007)(4001150100001)(41300700001)(8936002)(8676002)(2906002)(86362001)(31696002)(53546011)(5660300002)(478600001)(36756003)(316002)(6486002)(83380400001)(44832011)(6506007)(6512007)(186003)(26005)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERUL21kVDZjdDJ1TUpRYmxyVE8ra0pnOXptY1NlTHZKQTI0SytzRHR4dWJM?=
 =?utf-8?B?ZmdCdjhHNzJQR0I2K21Ga3krZVVwdFNhS0VPd3U5UEp1bng0TjMwZnZHUzdK?=
 =?utf-8?B?YmthQ2hIOGlMdG1Ca3FVYXQzaXF3T1duNHVRWTFqYnk1bW8vekV0b3hLQTVT?=
 =?utf-8?B?QVB2NG4xdS8wV0U4VkdURkk5b1k0L2prRzhaNDZ3WnVKb2thVTdCR01WeUpj?=
 =?utf-8?B?SlVxeWJxaXFuM21xWk44SVhaSVFmT3RMVy8wZy9CM3ZDM2xSYnBkK1lQZjdy?=
 =?utf-8?B?dGxZWUt0K3pHWGFkWjh1MkZzM1VEUGt1L0Z0bjNiUklVLzRPOXZ5YmZEdmdF?=
 =?utf-8?B?cVMzVDhTNSszbGhFQ1F5SUF1WVpmeHdRZXFvN0ExaDlLaTFGRE1yMnBZSnIx?=
 =?utf-8?B?VkFWY2wvaFJVRVFMZVlOb3d3dFIvTWxaZ054VjhLOHZCd1U1M21zTjZidFV2?=
 =?utf-8?B?Mk4zb2g3cU4yUzdSSE5mdEVCN2Q3N1FvTkM4T001TC9TQy9CWDNuMUxSZkx5?=
 =?utf-8?B?bWwrSUpIZnJsWitkdmJCVS81ejVSZ0kyOENkMFA5QWlBMHpRejVDaWU0dHQy?=
 =?utf-8?B?TjJ2RWRRZkxaNjR2bnFpMkNJQk9vczloQ0oxTW9ZZ3ZGRjBMVS96Ym45dTZm?=
 =?utf-8?B?SzE3TG5NcldmYTVzMmtkKzc5dVMrd0xBZHdmRFVoMG1KU3k4SnBldit1Zjg4?=
 =?utf-8?B?K1VNZlFUNExSeWJXMjF2b3JRdGhDM1lyMXFrQS9iVnQ1b1ZRTFZ5bUJ0bXhr?=
 =?utf-8?B?VEdRajV5NkhDRlc0WXFpUkZFQXJPV0Fkbmh6Zm1qeWEweE9SYS96Uld3cENt?=
 =?utf-8?B?c2EyYytWdktLRzMrYURUdWZYWVFhT0p5WjJLdzNLZlNxTnRTUkZ1UVpqMTha?=
 =?utf-8?B?KzJ4eXlwQ2FKaGcxTWJDTnVrVU1CTHpLKy9nYXRQN21KaDFJZWhlS3JQaE4v?=
 =?utf-8?B?YzlSV0poQm43Vlk1MzM5K3pJb0JyODFSRC8vQkcxakJPckwvMnE1MTRETkU4?=
 =?utf-8?B?MXZmRlB6RVRweEFwQUgzanVWZk5mT2JIMk90M0RTUWErUFg2Qk1XMnJIMUhi?=
 =?utf-8?B?WHY1c2t5akYrbXVReXMvc1RuOFZWQkRialQ2NUlVcXl1c09yL0Q2TTZJZzRs?=
 =?utf-8?B?YXNKZnk3ODd2ZGliNDExRk5NRnVmM3lseXZlUnBNclFrVC9sZDBVb2EvcWVr?=
 =?utf-8?B?UlZZY2V5WlRUbFg2N204WUJYQXJFdkplQnFHRTlrendCNTVjR2JIQjNyWjRq?=
 =?utf-8?B?VHVtWC8rODF5YmxhQkFwZFVQVXJOSy9vRHNMVXl4blJrN0FWelpyUlhrdjc1?=
 =?utf-8?B?MXhLcFNtVU02elRYTXZiMU9hL2ZOWW43bHVwOFVWQzVOVkt3SWg0KzNVb05V?=
 =?utf-8?B?ZFRHbXZSbDBpai9VNkVLd0NMaEkxQndPWXFHYlY1SWZjbVJSY0dpNlVGVklN?=
 =?utf-8?B?REpzWTVpam5WMGQwQ2s1aDlNdEFmbHFIWURBVTQxWWsyUFllbUJhM3hGaFRH?=
 =?utf-8?B?cXg2NjQ5Q29wQTMyc2NCY09tKzZDbDdIa3ZHaHZqZkQ4enRDTnBWNDBYdXlZ?=
 =?utf-8?B?M1BZazB3dE5pTTQ2TEJVclhpd1FqV1JBeFAwZU4yc0VDOUhRc3NTOHZUREpT?=
 =?utf-8?B?WGhRUlhOMDZxaWVkZEMyTHpJWFEyYXFjdWc1SFhTMXBmaU5SUmE2QVFjRURn?=
 =?utf-8?B?bU94cElWWC9PbnBLL2VyVUpzd1lmN3lXbzd4SWJKMktOY1lmZjh3WWFSU0dh?=
 =?utf-8?B?WXJrWmxJb21ENEw1VTZKQkV4endyOFB6dnB0MzBNakZnb1BwbXRmQm1hdkJS?=
 =?utf-8?B?cVdCdFdsVDZwNnpBQkJ1MGZxSWtwMGE4ejI1RkV4eVJvbFAyKzM4eHJ2MU0z?=
 =?utf-8?B?bHIxNUhFZDZjaHlsZm9xYkhDM0NhWncwdHhBRE53Z3pUWThoYmNpVUsvQzV3?=
 =?utf-8?B?c0pIVGNKdHB5TTB0ZS9xaGFyWlpocFNIaWRoSmx6R2RucHRvV1pCdlBJTE5V?=
 =?utf-8?B?ODYvaVFkSnBXQXMrMUk3Y1RPNVA0bVM5TUhXT0VHVm1oTGFMSXZkZE1CZmkz?=
 =?utf-8?B?aitBZnFHN2pwaGFHMllJbmt1M0NHdE1HaGJ0UVNwd0hHZGc4Q0J2d3FPaDBD?=
 =?utf-8?Q?urAKRwA3Th6JRKeqR721Dv9aK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9854d-db08-4082-1a3e-08dae2e01f6d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:15:45.6330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qle3rtg+YWYBAHKceKEotAxcVft4hiRA3Nj2T3fANq3bSH2kk3uhmZRfqQRTZYpLVmhXDa45rhY6fiVkthWtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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

On 2022-12-20 17:50, Mukul Joshi wrote:
> This patch fixes the following kernel warning seen during
> driver load by correctly initializing the p2plink attr before
> creating the sysfs file:
>
> [  +0.002865] ------------[ cut here ]------------
> [  +0.002327] kobject: '(null)' (0000000056260cfb): is not initialized, yet kobject_put() is being called.
> [  +0.004780] WARNING: CPU: 32 PID: 1006 at lib/kobject.c:718 kobject_put+0xaa/0x1c0
> [  +0.001361] Call Trace:
> [  +0.001234]  <TASK>
> [  +0.001067]  kfd_remove_sysfs_node_entry+0x24a/0x2d0 [amdgpu]
> [  +0.003147]  kfd_topology_update_sysfs+0x3d/0x750 [amdgpu]
> [  +0.002890]  kfd_topology_add_device+0xbd7/0xc70 [amdgpu]
> [  +0.002844]  ? lock_release+0x13c/0x2e0
> [  +0.001936]  ? smu_cmn_send_smc_msg_with_param+0x1e8/0x2d0 [amdgpu]
> [  +0.003313]  ? amdgpu_dpm_get_mclk+0x54/0x60 [amdgpu]
> [  +0.002703]  kgd2kfd_device_init.cold+0x39f/0x4ed [amdgpu]
> [  +0.002930]  amdgpu_amdkfd_device_init+0x13d/0x1f0 [amdgpu]
> [  +0.002944]  amdgpu_device_init.cold+0x1464/0x17b4 [amdgpu]
> [  +0.002970]  ? pci_bus_read_config_word+0x43/0x80
> [  +0.002380]  amdgpu_driver_load_kms+0x15/0x100 [amdgpu]
> [  +0.002744]  amdgpu_pci_probe+0x147/0x370 [amdgpu]
> [  +0.002522]  local_pci_probe+0x40/0x80
> [  +0.001896]  work_for_cpu_fn+0x10/0x20
> [  +0.001892]  process_one_work+0x26e/0x5a0
> [  +0.002029]  worker_thread+0x1fd/0x3e0
> [  +0.001890]  ? process_one_work+0x5a0/0x5a0
> [  +0.002115]  kthread+0xea/0x110
> [  +0.001618]  ? kthread_complete_and_exit+0x20/0x20
> [  +0.002422]  ret_from_fork+0x1f/0x30
> [  +0.001808]  </TASK>
> [  +0.001103] irq event stamp: 59837
> [  +0.001718] hardirqs last  enabled at (59849): [<ffffffffb30fab12>] __up_console_sem+0x52/0x60
> [  +0.004414] hardirqs last disabled at (59860): [<ffffffffb30faaf7>] __up_console_sem+0x37/0x60
> [  +0.004414] softirqs last  enabled at (59654): [<ffffffffb307d9c7>] irq_exit_rcu+0xd7/0x130
> [  +0.004205] softirqs last disabled at (59649): [<ffffffffb307d9c7>] irq_exit_rcu+0xd7/0x130
> [  +0.004203] ---[ end trace 0000000000000000 ]---
>
> Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index bceb1a5b2518..3fdaba56be6f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -801,7 +801,7 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   
>   		p2plink->attr.name = "properties";
>   		p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
> -		sysfs_attr_init(&iolink->attr);
> +		sysfs_attr_init(&p2plink->attr);
>   		ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
>   		if (ret < 0)
>   			return ret;
