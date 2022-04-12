Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB555C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 00:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A74110E243;
	Tue, 12 Apr 2022 00:16:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6716C10E243
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 00:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TINhXVISD0kCm9eQtDsBm4QeRJMLhrnnxjQ8aXMjimaGuEcT5d8ymAhQCeWCuovC7wnoDN/1SlR7tEa5vXH2/JjMhbrEbwbYdWEggxoZV+Nbps5Lwy9RTO9B0rqEZTK+SPOEyd2L9DKHAzcCwJKbUfqWxAKzUqHU2d2s+HUjs38O8Vx5VQ6WZd3AuwA5grF9ttdkbtdBOlCbUp+9PnMPH4Lm8NhrmMPqv+wx2F61BXLFvlMpePAgqvKuBN/CuZrT8BM1PYAxfEyivSXZICQ1MvInsJnLP3m3cIIOhGLyb5nAx6aSbM8SKhBvZ7U4rxTvnFxLLcZ59NOwvZwEVOOpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk/PVKyS7ZVNYcmPCEKukBL0HPHAiibuAOe6fmbL/54=;
 b=FUgIebAdMcxC6Nn9zK0pcg1f8QX5MyLTZ7qLMTyd1ITvi3yH2NbpIlencpHIgFOy61fuyzSvYLudOdegpUvtJOEnAn+igocFqiFwBEX+eVmbaO7B0lFkdEojArDu/DpMWsTCrKkHKRW98JFZYOrdsGsvHtUKdcRXQT/vvNPRAgzND8D3jq+/ta0EkrzNCWwUcZzOypaAhHhw0yqShKov8kUT3uYGpST3zwKgX6yE0ynlzi08k/WmSWznW5/iaPI36OiWBh6X97ewgxDGnBhT76vnbLjlkJ9wmTFhXMM3w3cEAFEVnNbeUhFTZJpnL8/OTq3mpQcFTyBbqI7NomGHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk/PVKyS7ZVNYcmPCEKukBL0HPHAiibuAOe6fmbL/54=;
 b=zdtZQb5tOhO3VK+vHHse3KhFwrcOsqyJabb7kHXpgH1gJdJs8ddt/Tl64d6dQAAR+9Nh6S0xyBUgYpSAPgPHpY/o5vKCyaV2YgsliD1dzX7TY7WFA8i1Yg5hjQr8rlE0NXYACkjw4eLEo/OE/IM9Y/jjdPocHYc7aGt2lYxf2H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 00:16:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 00:16:04 +0000
Message-ID: <ed96d92d-9797-4a84-e119-f8cb2cb2d6b4@amd.com>
Date: Mon, 11 Apr 2022 20:16:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Cleanup IO links during KFD device removal
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220407161555.545725-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220407161555.545725-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2cea5a4-99a2-4397-aacc-08da1c19a208
X-MS-TrafficTypeDiagnostic: DM6PR12MB4941:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49418138368D32C141FD72D492ED9@DM6PR12MB4941.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17SbTVdv/KvYNUiqIoiRUeP7R37p+rx3IG0BAOw7mUEWm5KLgn3hwKZMCIp/xNbVKdLXFa6W8JWWWDv08ieQy/nEqsG8MHNBezQNi2ealLMtHUjLip+73JvGCn3WhSiDdUgD0Vu8N2wf8G5c2gN5yX+SNRz1zmaxHIwVzpPXFIE5yZ39kM6oPdJqjKAbLCMd5VWa++kpJjP0khXFbgPaLCaDxh62d9T8L5pTQRPk62IQQ7j5vg9LUrsJR3ZgEx22IhNGcj87eS+EZPxSMz8K+NQtA3j3O2mKxOiylXt2I8AuRureOz92v3WGekkCjJP1CGA/mwgYQPA0Bm4EolSr+ad9MZLL4yEWTaqe/O9QSVPwiJmoRBJfnILBla75g3L/bJYCivqyw9k/11T8vfxtiWN8nKPvXK3WzDkEC5u98X+clHEU9V+4rx7FL0BBOwx0MhWhFKNiL1M+gKldDCD5GFX7wKMwtCVQ+5KP49sWcDJgEus/GHK02OrxWmLSWUHRZrXHePNXJpKaVkg+61V6gWkJXp73dtmgKA9XwTWRTpFhgj8UI9gt1rofGVJqnfFkNN/cB8p30DHXr3eWNPXgdodHlvvxXbv31N7ear2hHGXbu31yOvIet2nGlOed9Vg5Gc5NsbEilRz6dD6BcZVdym1YSIYIt5eYSD9CKEwzmJh6HFi9tOGjOQceNVyWJ4rwqn8GS/U2dMuLw+8DJB9CXhUyTZIkQlyJu3JF67tzBTvgFvRema8hEavHgHioGHLr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(83380400001)(38100700002)(36756003)(66556008)(44832011)(45080400002)(31696002)(316002)(4326008)(8676002)(508600001)(6486002)(66476007)(5660300002)(8936002)(6506007)(26005)(186003)(6512007)(2616005)(31686004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitFWFdEeWpVM2JqdFpmRVh5SDhNblVmRDNGYzZQbFJRWjlCT2x3V01uQURE?=
 =?utf-8?B?ekVRb1JSajB1V0VCZ2FEbjdMNEJmVXFGZkcrUEY4VHAwck11U3c1YzI0U0ZP?=
 =?utf-8?B?T3E1cVJlZE9ZSzZBK1VLaE5vY2gwcXN3TlErVXd5M1RkMXNYaWlXU3NpdEg4?=
 =?utf-8?B?cVhkLysvak1yUDNZaXNzOS9YQTFKR090cllUY3RYUUZ5Rmc1aTRseFhrTmIx?=
 =?utf-8?B?Umt0RXRVSHJ0M09kYlNtbFdNbzJmOGRvUGxQYmd2bFlYVG5DcytBbGF5V0ZG?=
 =?utf-8?B?Vnl4OC9GYnVsWkExMG1TVkQyeGNaQXlLcloyelk5eUFnUFkzcXg3eWxLMW0z?=
 =?utf-8?B?blpDZk9uTk42RWpFZXp5Q0U1M1hBU3RzeEFHckliekRlK2orbzRSSHc5Sys3?=
 =?utf-8?B?UW1BOHJFbEdKdG0xSTVHQ3lsSDRMcndFQmxocmptdkxadHlpR0xBYTdaNXFM?=
 =?utf-8?B?emJiajlrdXR2THRVZGFsN1ZHWHJTOHhacytlOWJqeUc1RElTVzdCeHVSYVhu?=
 =?utf-8?B?M2ZMTkRKMUxzMFBNNnlpV25JZUc0S3Z4KzdGd0JGMkVNeW5kalRXOGtCcmIv?=
 =?utf-8?B?SHUvV3ZjNFJRV0Y3N09yQTJSejVhTE1LR2c3d0E0VEFTbk9tdERuWlREYWZU?=
 =?utf-8?B?a0VLVjh3RVpoSnFYMThhN1dUSVhlaG4wYUpjbUdWcUFwVUJSY1RuUnVNTVll?=
 =?utf-8?B?ak1BWXpWSWVwTU81Rlp4Y004bVdja0dTZmdjR1ZEY0liWDZQb0lnMUJybC9j?=
 =?utf-8?B?SUk1OWNUVnVYUWhsN29QM01QQ09YTTV6TllyK0VOVHFnUFBMNUs3ZGxWQ0ZY?=
 =?utf-8?B?MStxZVRCRTRFSk1lUDFiQWxueWpsNDdNVzlYdnF5MUVsWktKcXdodHl1R2Vv?=
 =?utf-8?B?N2FyMUpCcUY5THg3aSswdnl1OEVDdTUyenE2QnZoS2NLeGRZUS9kZFE3SFFT?=
 =?utf-8?B?anArTDB6dmlPQXlzMWJqc0VSQjBtQW81YlBVSzh3eWxOdExncmJZckMwVk1K?=
 =?utf-8?B?eExPS3NZWDNPVDhBOTROVHJSRU5wQUhSQlhnQ2YvRXNaNWk1QlpUZVIxU2JH?=
 =?utf-8?B?ZUw0MnNFeFdPT1lRVFhiYjFPZktDSG0wYUlNUC9CWE1Gd3J6ZnFWZllucSta?=
 =?utf-8?B?OUVXb215N2NiNit0MGtobTRTeVRkc3NxTkZqMnh6WEh1aDlwOU5nWXY5aEtp?=
 =?utf-8?B?Mjl3MWMyQmd4Zk84cWJiL2RCajJkbkNFdUp4VmJGM1ZkQ1N4L25lRWxCMkRL?=
 =?utf-8?B?dUNZYkt6eFZ5VkI2NG41YUROakJzaVR6Umt1TFRwbU9zNjdLc2hmNXlUVjFS?=
 =?utf-8?B?Y3RJT3BUWTZvcXplSk1HUnF1QlRaNEM4K0I0b1I3dmhzanRiVmVpWjg4UHM1?=
 =?utf-8?B?bmRGcVdtdTFkZURlOXZCb0t6SVlwc241dnB6OGRjbkkxOGtxTm1QZ2tMUTVH?=
 =?utf-8?B?V0tFMlMreENUNGhyMXRUYk1DTHJDQ2tsS3RUbUFQRHZPU0VyVFp6NHVHOGJ5?=
 =?utf-8?B?UklML3FDMGQ1SWN2YWp3N005TWc4dWtOTXNxOStyVkVIZWZubThDMWRSSklw?=
 =?utf-8?B?RU5pd29JN0pWemVteXpEakEvRDM1SUlQUlJUeTdMb3o4Q2hnS0RoQ25paCtR?=
 =?utf-8?B?Wm9rWGQwMW1JUGFrbGtsUjNmeHExOXRCZStzR2VsYjkxUXUxaGpSNXJEaWV4?=
 =?utf-8?B?eUtYS3J2Rk1abDZXdFB6WHJxeDN2eVFWYkxvNE15alhGam5aQ3hzWWJVeDdj?=
 =?utf-8?B?UERrWXRsOHF4TUViY0lHQ2V5WW5JWWUwVEkvWnF5bkZJMmdsQUwxSFBsK1hz?=
 =?utf-8?B?dThxWnBaamtvRVpIc3YxUjV2Z1dLUmhvQ1ViTzNDSll5U05PZ2dZMFRrYkZM?=
 =?utf-8?B?K3BOWHB5Zk9BTGJ3ZkhNWE5LZkFxREhaZmxQUUU0cEVqYUp0MWo4Szltb1lP?=
 =?utf-8?B?eW9HUE5QVERySTV2OEUzaElHZFpwcnZPVXNGOUhPZC9JWExHMmczRi9wWVEr?=
 =?utf-8?B?bEdSYWtHa1NjYzlwMjRNZVN5MVJ2L1JaUDd4bndmSlRzaXh6R2pGRk9zcGdT?=
 =?utf-8?B?MmlJQXVWUHhMWHp5dU15dmN1SGZkb2V3anY4NEpjQzBvWDMvNXlMWVBXS3gw?=
 =?utf-8?B?MHk5Z1lBN1FkbEhCdEVYakpiQ1ZBMGd3bm1GRXhocmVPUVh1ZitxTG9jOC8y?=
 =?utf-8?B?N25lVGZ6dStMbndFTjFqNFNaYmsrTit4dVpVdFBnYXpWcGVPV2NaNStvek91?=
 =?utf-8?B?M2RDT3RLbVBWbGNrNE5YeVN5bUdHUTNFaGxjY2I4bjF2N0k0Z0VYUWRNSFJR?=
 =?utf-8?B?Yk5lczJwNWs0aDdZbUpzOWRmRW53YjVWUEpUYkZvbnFCZjNKSzVjZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cea5a4-99a2-4397-aacc-08da1c19a208
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 00:16:04.6313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/L9l9aI07y2XIST+2raLpQUO1vNSYUHoOqbOr83ufwxiWf4ni8t5k3WrTjhI55kgLgB9t8yiF1eh50jK5gj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: Shuotao Xu <shuotaoxu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-07 um 12:15 schrieb Mukul Joshi:
> Currently, the IO-links to the device being removed from topology,
> are not cleared. As a result, there would be dangling links left in
> the KFD topology. This patch aims to fix the following:
> 1. Cleanup all IO links to the device being removed.
> 2. Ensure that node numbering in sysfs and nodes proximity domain
>     values are consistent after the device is removed:
>     a. Adding a device and removing a GPU device are made mutually
>        exclusive.
>     b. The global proximity domain counter is no longer required to be
>        an atomic counter. A normal 32-bit counter can be used instead.
> 3. Update generation_count to let user-mode know that topology has
>     changed due to device removal.
>
> CC: Shuotao Xu <shuotaoxu@microsoft.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Looks good to me. I have two nit-picks inline.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79 ++++++++++++++++++++---
>   3 files changed, 74 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 1eaabd2cb41b..afc8a7fcdad8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   	 * table, add corresponded reversed direction link now.
>   	 */
>   	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL)) {
> -		to_dev = kfd_topology_device_by_proximity_domain(id_to);
> +		to_dev = kfd_topology_device_by_proximity_domain_no_lock(id_to);
>   		if (!to_dev)
>   			return -ENODEV;
>   		/* same everything but the other direction */
> @@ -2225,7 +2225,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	 */
>   	if (kdev->hive_id) {
>   		for (nid = 0; nid < proximity_domain; ++nid) {
> -			peer_dev = kfd_topology_device_by_proximity_domain(nid);
> +			peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
>   			if (!peer_dev->gpu)
>   				continue;
>   			if (peer_dev->gpu->hive_id != kdev->hive_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e1b7e6afa920..8a43def1f638 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
>   int kfd_topology_remove_device(struct kfd_dev *gpu);
>   struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>   						uint32_t proximity_domain);
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
> +						uint32_t proximity_domain);
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
>   struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3bdcae239bc0..874a273b81f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -46,27 +46,38 @@ static struct list_head topology_device_list;
>   static struct kfd_system_properties sys_props;
>   
>   static DECLARE_RWSEM(topology_lock);
> -static atomic_t topology_crat_proximity_domain;
> +static uint32_t topology_crat_proximity_domain;
>   
> -struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
>   						uint32_t proximity_domain)

I remember we discussed this and I suggested splitting a no_lock version 
out of this function. But now I don't see it being used anywhere. Was 
that lost somewhere in refactoring or porting to the upstream branch? 
Maybe the no_lock version isn't needed any more.


>   {
>   	struct kfd_topology_device *top_dev;
>   	struct kfd_topology_device *device = NULL;
>   
> -	down_read(&topology_lock);
> -
>   	list_for_each_entry(top_dev, &topology_device_list, list)
>   		if (top_dev->proximity_domain == proximity_domain) {
>   			device = top_dev;
>   			break;
>   		}
>   
> +	return device;
> +}
> +
> +struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> +						uint32_t proximity_domain)
> +{
> +	struct kfd_topology_device *device = NULL;
> +
> +	down_read(&topology_lock);
> +
> +	device = kfd_topology_device_by_proximity_domain_no_lock(
> +							proximity_domain);
>   	up_read(&topology_lock);
>   
>   	return device;
>   }
>   
> +
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
>   {
>   	struct kfd_topology_device *top_dev = NULL;
> @@ -1060,7 +1071,7 @@ int kfd_topology_init(void)
>   	down_write(&topology_lock);
>   	kfd_topology_update_device_list(&temp_topology_device_list,
>   					&topology_device_list);
> -	atomic_set(&topology_crat_proximity_domain, sys_props.num_devices-1);
> +	topology_crat_proximity_domain = sys_props.num_devices-1;
>   	ret = kfd_topology_update_sysfs();
>   	up_write(&topology_lock);
>   
> @@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> -	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
> -
>   	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
>   	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
>   		struct kfd_topology_device *top_dev;
> @@ -1321,12 +1330,16 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	 */
>   	dev = kfd_assign_gpu(gpu);
>   	if (!dev) {
> +		down_write(&topology_lock);
> +		proximity_domain = ++topology_crat_proximity_domain;
> +
>   		res = kfd_create_crat_image_virtual(&crat_image, &image_size,
>   						    COMPUTE_UNIT_GPU, gpu,
>   						    proximity_domain);
>   		if (res) {
>   			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			return res;
>   		}
>   		res = kfd_parse_crat_table(crat_image,
> @@ -1335,10 +1348,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		if (res) {
>   			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
> +			topology_crat_proximity_domain--;
>   			goto err;
>   		}
>   
> -		down_write(&topology_lock);
>   		kfd_topology_update_device_list(&temp_topology_device_list,
>   			&topology_device_list);
>   
> @@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	return res;
>   }
>   
> +static void kfd_topology_update_io_links(int proximity_domain)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
> +	/*
> +	 * The topology list currently is arranged in increasing
> +	 * order of proximity domain.
> +	 *
> +	 * Two things need to be done when a device is removed:
> +	 * 1. All the IO links to this device need to be
> +	 *    removed.
> +	 * 2. All nodes after the current device node need to move
> +	 *    up once this device node is removed from the topology
> +	 *    list. As a result, the proximity domain values for
> +	 *    all nodes after the node being deleted reduce by 1.
> +	 *    This would also cause the proximity domain values for
> +	 *    io links to be updated based on new proximity
> +	 *    domain values.
> +	 */

I'd put this comment in front of the function, not in the middle of it. 
You can make it a proper kernel-doc comment, especially since the 
function name is a bit generic (and I can't think of a better one that 
isn't excessively long).

Regards,
   Felix


> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev->proximity_domain > proximity_domain)
> +			dev->proximity_domain--;
> +
> +		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props, list) {
> +			/*
> +			 * If there is an io link to the dev being deleted
> +			 * then remove that IO link also.
> +			 */
> +			if (iolink->node_to == proximity_domain) {
> +				list_del(&iolink->list);
> +				dev->io_link_count--;
> +				dev->node_props.io_links_count--;
> +			} else if (iolink->node_from > proximity_domain) {
> +				iolink->node_from--;
> +			} else if (iolink->node_to > proximity_domain) {
> +				iolink->node_to--;
> +			}
> +		}
> +
> +	}
> +}
> +
>   int kfd_topology_remove_device(struct kfd_dev *gpu)
>   {
>   	struct kfd_topology_device *dev, *tmp;
>   	uint32_t gpu_id;
>   	int res = -ENODEV;
> +	int i = 0;
>   
>   	down_write(&topology_lock);
>   
> -	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
> +	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
>   		if (dev->gpu == gpu) {
>   			gpu_id = dev->gpu_id;
>   			kfd_remove_sysfs_node_entry(dev);
>   			kfd_release_topology_device(dev);
>   			sys_props.num_devices--;
> +			kfd_topology_update_io_links(i);
> +			topology_crat_proximity_domain = sys_props.num_devices-1;
> +			sys_props.generation_count++;
>   			res = 0;
>   			if (kfd_topology_update_sysfs() < 0)
>   				kfd_topology_release_sysfs();
>   			break;
>   		}
> +		i++;
> +	}
>   
>   	up_write(&topology_lock);
>   
