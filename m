Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE81C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 22:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA45310FD3C;
	Fri,  3 Jun 2022 22:38:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668151120FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 22:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/NvhiSxGXvL82+I3H1ZNa53XptjCiFKCmW5wryQ9uZqN3BSiD8SBBp6LUayV9BQDn64ypGV7yZh2qwPT3i72IYI9VKBvD4oaYW1lvead5r5zNcgcWcmknUxkn8EceEYboqV2J2baJilb380IpzAZu8J0YD3l2iRruNJ/MYMBkEsEDtaC7XiWx64/a2oUnvmJj4XpOfVzMYokj4RiY2b3ZMxVdjbI9VHrtMpV3Gsx71AJlpLdd0+hxRb6G4Zu+1+AtJ3CxAEkqgqfkh0fwNZ5uj914I88+uPcmbmJ2KbigujDFs0/vNYVVd2QqOFyRoZT2lUMV+16slQo7D67CvnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIQdhGI13TzumPsSwmXuvFtSbg4SgARq5G53v2a/mz8=;
 b=OjbPDHMh50Nx7McAA5neYXIho8ciUjbUHHeyemctIaJd4y1HaXS0s0NUC8awJRtwxsUQWDetQ3Y9cMOYzB9aF70Xm2aDLZV4H2TShoJkZW90leJnc9e8nuY+ZP/f6NTVaYyjh6ysx6AXS2MxGKGvx1bjh3gKxC8pEnbWi1bRTITT9/PdNQtjy/ek5sXH7bVRFtb06Ob5K5n3ZOTIoV/TUsz7Sj4j2/bLZ7GL0rC+nAmvf39/93mLS/UBEQplkX4eTvSbswaWGQeuNb/Sw9g5p4FJHULX6W6CYKfIOkoW/tPfpT1tWOTC6wVpG+FRs3XpHGgHhKlNa96ETsVr+KF/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIQdhGI13TzumPsSwmXuvFtSbg4SgARq5G53v2a/mz8=;
 b=smbuNCqgz6w/PBGlrxoFpyvI01bn/T9lvQ0CoyXPXX3iwFmnk2XVGy5uU1TO5YPyzr5HVn8uNmvkcHZ9oAElwm1VsUAbdk8ydwJ6BhPHQVaX5dAtlUpOveyeWPWT0B4YBu75a2DnbdbyR4oBqr2szexYMhDypbLMPp+eY2ZnVHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (13.101.157.78) by
 DM6PR12MB3099.namprd12.prod.outlook.com (20.178.198.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.18; Fri, 3 Jun 2022 22:38:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.016; Fri, 3 Jun 2022
 22:38:30 +0000
Message-ID: <b420dcf6-a5bc-2440-138e-1675a06d1bc9@amd.com>
Date: Fri, 3 Jun 2022 18:38:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdkfd: Extend KFD device topology to surface
 peer-to-peer links
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20220603105252.3372797-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220603105252.3372797-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:610:cc::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4094052-ca91-484c-f55a-08da45b1c8ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30999AD973ED7A76F9F68E3392A19@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoN4PbKxwtlP8wb5mBDfwjL1DY5eONxRNEidNgWR1yN0MQ1IHVVcgEeYeba71PnKnYw4g9265R8cextrHEjv6nJkPlsXQgog9OHaqKrzkACZnaRH+N5kSe7uK9oSbkrK5fXoVPPun7ork5RzzVtRIY/UQpD6Vn9nxTK60B0sb1JcnRnBVC3i18fQMBCv4ymCi5f72O0Hg/2MXLm8r9qL8mTINMefdHPM8YznyX3GgguQzcXviXpEEpSfifImoFP0tw4I+cZvwm6GfszIkH3dfcWzWhf7QnVLM0uJF292Jf8Vw18BKjqfNYF9ebvR9jpDlJJZBruAEF1cC7gibrcHWIVh9D0iAzilt9Jp1bzWlIV9IQj3xxov8P9aLnWcWyu/ec5TcriYpu6QrANv1wuDMSiSroAp+SPLWa72NGFOw/Y8fK+vwGMASzZR3uiG9dGZRm0ZJ3IPImv6hPaHJu+OWUz5b5fsppDkX2QHBT+gKly1OQyffVA9PsRdsIiib9bqmDrXcWNwqh/Vf3uDmEWY3kuSF1fkf1VRMHrh2YTeLm6rHmj+0T3HYPEsevwvcKzGd/BfvI16TBclPvPIxmJ2/8aqX0L/8We2UeSSuFhnBFd/NHAKt93KHgfVokgfHcOxYmEOQtUW5dAwRsO/P/BRky1loRXGl4qqdzZPXL2TMQcJCN0K3/f0jV2Ns2DbCegSXTO/TO6r8PP7HWGjlVRlpkmxv19HwCOfv8PRtK0EbgsZtivrbxz1SuOmDkuwSUcu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6506007)(2616005)(31686004)(44832011)(6486002)(316002)(37006003)(36756003)(6636002)(66556008)(83380400001)(66476007)(8676002)(66946007)(6862004)(53546011)(186003)(38100700002)(508600001)(86362001)(8936002)(26005)(6512007)(5660300002)(2906002)(36916002)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVUxSTc2c2ZLY3FZTG9xTURqVFRPVlpXL0ZiSmJ4dVd0a3J1Y0NTLzN0LzB5?=
 =?utf-8?B?UDkwcnU5UXA2RGc2U280djFpQkJxOUNQaHdwZ2VDU2I4TUlzYkNDUGwwOEdN?=
 =?utf-8?B?NGx2a0hrVk9pb01ZVGtVR2gxK3drZ1FUZmlXeUJPY1dkY0JJK0U5S2JsWDJD?=
 =?utf-8?B?bnZ3LzdneTZ2Z05NQU05bFJhcnlFcHVuOTl5L0U3aXM2K2puSy9TUGN4M2dQ?=
 =?utf-8?B?eUIyek9ZTXhsak9QckRVMkhNWWRhTndqT1h0UWw5czAvRkhLMnByancvQVd1?=
 =?utf-8?B?VXZ4TGs1ODJlVFM0Vkd6OUZDcFYxcEdPa3dPeDBFMXVUbWx0clkyLzBBK2RK?=
 =?utf-8?B?REs0cU0wbXJmWEVMU3lKME9JTXZBenNvdDEvZ3pvTmIxb3lmT0VITUxiUDNZ?=
 =?utf-8?B?WGJoaG1Jc0dkNnlaeW02Mmw2cEsvcjRKMTZHd1pHeHY1ZXR2RmpubHIvQjVR?=
 =?utf-8?B?YktJMEVxNVhPa2xlTVBHWlhHTjdyV0hZU1ZuRS9TdlRscnNZUk9iTDdIOFlr?=
 =?utf-8?B?R3hOaEhXTVZuMEdHbEZhTTdRSUZhUkNTRTRzV2pBT2V2czFSdEp1RUhOSEtF?=
 =?utf-8?B?RnhTa1ZzVVVuQkpwQ3R3U0k4cWZlR3RxTk1qQzlHOGhTOXlnTGtIYnhrdmJ2?=
 =?utf-8?B?azliTTY1TXRqMTZCdDNERURMT1J5WDJSWE42R2Jsbm5MdmhYb1VsV1hQUU8w?=
 =?utf-8?B?bFdWZEsxeXgrejBBRHhpd2JxTGw4RzU0ZXhaM0ZVKzBscEhzQlN0KzF3WHpU?=
 =?utf-8?B?TzBkcFNqSVM0TC80cnpFL2NYdE5NS2VNbXczYmJvMGt3SHpNcVVqVEpFZ0Y0?=
 =?utf-8?B?LzVPWW9ST1hrZlAxK0RRaHFRTjM2Yks3SStsb01CZkwyelR2cmV6Ukkxc2s0?=
 =?utf-8?B?T1VBWUJRUjc1cDNuVDNIYkE4VWRQSjBJcGdMOVF6dlBSb1JBRi9MUllzeFhv?=
 =?utf-8?B?MjhyNWM3VHdxSzBIWVhibmI3MlhWWjlTMFhwTWI4bVkrVlBWSkFmejZlSDNn?=
 =?utf-8?B?NTVkckl5TUk0L29KMnY4Q0s2K2hKeFNTdEVzck50OUd3NHczVmMzcitqVkxW?=
 =?utf-8?B?R2FYV1RUU2VFQTBwc0FNOEN1UFhZeElCWjJoL1FUd3VqV2tsTXBCazBXdmdB?=
 =?utf-8?B?dzB4YTZBaE9Tanp1aGpUU3c5QnAxRlNMNGcyOTdmMWNhSGZ0R05lMmxOTWdz?=
 =?utf-8?B?dzBEU3Vkak16d2hYc3FKd1g1NmVZRTFzWCthNGQ1SFdsd0F6NzJDTFNhRlE2?=
 =?utf-8?B?Rjloak1pWC9BRHNoNU9jeFlFczNCdnppdUtVM0djZWkyc1V4SVBMNitwZzl2?=
 =?utf-8?B?czhvK3pEYTd1RE9lNi9Ld0FkcUc3UlQ5REpHcmtVM0xlWUd1UDg3M1V3aFMz?=
 =?utf-8?B?Y3FHM3BOUTNsSlI0YlFaSU9DemJvOUFubWRzUi9qN2FwaCtMUm9SRGt0cFBP?=
 =?utf-8?B?UlpqY0p0UnhFZHA2eFBrdzZkM3h4UjZtQUh2MGJKdWp3UFRCV3hadUFlaFNI?=
 =?utf-8?B?Vm1ZOUgrQUpIMDk2WHNrZ3lIdzRQQktXZjRWUmtQSWhSZVByMWJDaXYvQjZI?=
 =?utf-8?B?R1JrRGJuV0JFKzNaVTBMSDFDckx0YTgybys0TUNlRVpjRE9xZVRWRVY0Zlk4?=
 =?utf-8?B?NEdtOFEwQ29INGZTSlJhcXRWbW9FQlVxeGJIZTlvWE9vVVlzb25zdnVBZEZp?=
 =?utf-8?B?ZTBnZE13ZVZtWGJjdHFaM2MvTjFTR2ZuZ0JkWi9IMVAyZWVVdXpJdmZhZyto?=
 =?utf-8?B?U016cWxTaFoydFE3dmNjS2RyR2hFUkJSbnB3STBJVXd0ZU5tNkNVR0pUQVBV?=
 =?utf-8?B?VS85dnZGWDZ1NHErRzNrczRJczJhRU5UMm1CUkJLNVdEcDRpUnRvQkVETnZL?=
 =?utf-8?B?aE5zdlh5ZXFUNCtROWVuY1o4aG9uY2hoWGVZeXY1ZUFZVlRSQ250QS9UdjNo?=
 =?utf-8?B?WkZaeERxSnNWV0FQVTJMVnRzb2RvWnZ3dnpIT0hva2pTM29oTnUra2NoY0I2?=
 =?utf-8?B?a2NZYnBGRGExZ0ZzZGprc09vc2NDUGtaaTNjc2dOc0QxNGFwakFmL0drNDVM?=
 =?utf-8?B?TVhPdXJ2MjlVMEhSUXNMakx6MTVFTG9maTV6VUtHa01mSW9hZ2JrakdYTTB1?=
 =?utf-8?B?ZGYvK2NOM0EzZHNYUXgrZ0V0eFZWdUR3aUlUemRpNzl3RnY2dXhQeVp6akxV?=
 =?utf-8?B?dm5TNlY3eS9mUSt1aFZ2TjFoU3AwUFFjRDVlMGl3ZUxteDg4WmlvN3I1VFkr?=
 =?utf-8?B?d1YzWnN3T2YxVGhORVliT1pwRXhycXpaWGh6S0FMUGRYNXoxMGdnWmhTb1ph?=
 =?utf-8?B?TzBueE16L3dsL2JEbEt5a0pHSWVjMER5MW5MZ0JpQTdMZ1BqbmErZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4094052-ca91-484c-f55a-08da45b1c8ca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 22:38:30.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEEJbFsYgbBuTGs5jsovhveDDaivRzge1p2eSwhtqRm+YEZq7ecjzb/IWj0cpJwq1SoznRDGYCd0pHrtuXqUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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


On 2022-06-03 06:52, Ramesh Errabolu wrote:
> Extend KFD device topology to surface peer-to-peer links among
> GPU devices connected over PCIe or xGMI. Enabling HSA_AMD_P2P is
> REQUIRED to surface peer-to-peer links.
>
> Prior to this KFD did not expose to user mode any P2P links or
> indirect links that go over two or more direct hops. Old versions
> of the Thunk used to make up their own P2P and indirect links without
> the information about peer-accessibility and chipset support available
> to the kernel mode driver. In this patch we expose P2P links in a new
> sysfs directory to provide more reliable P2P link information to user
> mode.
>
> Old versions of the Thunk will continue to work as before and ignore
> the new directory. This avoids conflicts between P2P links exposed by
> KFD and P2P links created by the Thunk itself. New versions of the Thunk
> will use only the P2P links provided in the new p2p_links directory, if
> it exists, or fall back to the old code path on older KFDs that don't
> expose p2p_links.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 319 +++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   3 +
>   2 files changed, 320 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8d50d207cf66..be4dce85e7c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -40,6 +40,7 @@
>   #include "kfd_svm.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu.h"
>   
>   /* topology_device_list - Master list of all topology devices */
>   static struct list_head topology_device_list;
> @@ -148,6 +149,7 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>   	struct kfd_mem_properties *mem;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_iolink_properties *iolink;
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_perf_properties *perf;
>   
>   	list_del(&dev->list);
> @@ -173,6 +175,13 @@ static void kfd_release_topology_device(struct kfd_topology_device *dev)
>   		kfree(iolink);
>   	}
>   
> +	while (dev->p2p_link_props.next != &dev->p2p_link_props) {
> +		p2plink = container_of(dev->p2p_link_props.next,
> +				struct kfd_iolink_properties, list);
> +		list_del(&p2plink->list);
> +		kfree(p2plink);
> +	}
> +
>   	while (dev->perf_props.next != &dev->perf_props) {
>   		perf = container_of(dev->perf_props.next,
>   				struct kfd_perf_properties, list);
> @@ -214,6 +223,7 @@ struct kfd_topology_device *kfd_create_topology_device(
>   	INIT_LIST_HEAD(&dev->mem_props);
>   	INIT_LIST_HEAD(&dev->cache_props);
>   	INIT_LIST_HEAD(&dev->io_link_props);
> +	INIT_LIST_HEAD(&dev->p2p_link_props);
>   	INIT_LIST_HEAD(&dev->perf_props);
>   
>   	list_add_tail(&dev->list, device_list);
> @@ -465,6 +475,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   			      dev->node_props.caches_count);
>   	sysfs_show_32bit_prop(buffer, offs, "io_links_count",
>   			      dev->node_props.io_links_count);
> +	sysfs_show_32bit_prop(buffer, offs, "p2p_links_count",
> +			      dev->node_props.p2p_links_count);
>   	sysfs_show_32bit_prop(buffer, offs, "cpu_core_id_base",
>   			      dev->node_props.cpu_core_id_base);
>   	sysfs_show_32bit_prop(buffer, offs, "simd_id_base",
> @@ -568,6 +580,7 @@ static void kfd_remove_sysfs_file(struct kobject *kobj, struct attribute *attr)
>   
>   static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   {
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_iolink_properties *iolink;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_mem_properties *mem;
> @@ -585,6 +598,18 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   		dev->kobj_iolink = NULL;
>   	}
>   
> +	if (dev->kobj_p2plink) {
> +		list_for_each_entry(p2plink, &dev->p2p_link_props, list)
> +			if (p2plink->kobj) {
> +				kfd_remove_sysfs_file(p2plink->kobj,
> +							&p2plink->attr);
> +				p2plink->kobj = NULL;
> +			}
> +		kobject_del(dev->kobj_p2plink);
> +		kobject_put(dev->kobj_p2plink);
> +		dev->kobj_p2plink = NULL;
> +	}
> +
>   	if (dev->kobj_cache) {
>   		list_for_each_entry(cache, &dev->cache_props, list)
>   			if (cache->kobj) {
> @@ -631,6 +656,7 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
>   static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   		uint32_t id)
>   {
> +	struct kfd_iolink_properties *p2plink;
>   	struct kfd_iolink_properties *iolink;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_mem_properties *mem;
> @@ -668,6 +694,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   	if (!dev->kobj_iolink)
>   		return -ENOMEM;
>   
> +	dev->kobj_p2plink = kobject_create_and_add("p2p_links", dev->kobj_node);
> +	if (!dev->kobj_p2plink)
> +		return -ENOMEM;
> +
>   	dev->kobj_perf = kobject_create_and_add("perf", dev->kobj_node);
>   	if (!dev->kobj_perf)
>   		return -ENOMEM;
> @@ -757,6 +787,27 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   		i++;
>   	}
>   
> +	i = 0;
> +	list_for_each_entry(p2plink, &dev->p2p_link_props, list) {
> +		p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +		if (!p2plink->kobj)
> +			return -ENOMEM;
> +		ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
> +				dev->kobj_p2plink, "%d", i);
> +		if (ret < 0) {
> +			kobject_put(p2plink->kobj);
> +			return ret;
> +		}
> +
> +		p2plink->attr.name = "properties";
> +		p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
> +		sysfs_attr_init(&iolink->attr);
> +		ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
> +		if (ret < 0)
> +			return ret;
> +		i++;
> +	}
> +
>   	/* All hardware blocks have the same number of attributes. */
>   	num_attrs = ARRAY_SIZE(perf_attr_iommu);
>   	list_for_each_entry(perf, &dev->perf_props, list) {
> @@ -1145,6 +1196,7 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>   	struct kfd_mem_properties *mem;
>   	struct kfd_cache_properties *cache;
>   	struct kfd_iolink_properties *iolink;
> +	struct kfd_iolink_properties *p2plink;
>   
>   	down_write(&topology_lock);
>   	list_for_each_entry(dev, &topology_device_list, list) {
> @@ -1165,6 +1217,8 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
>   				cache->gpu = dev->gpu;
>   			list_for_each_entry(iolink, &dev->io_link_props, list)
>   				iolink->gpu = dev->gpu;
> +			list_for_each_entry(p2plink, &dev->p2p_link_props, list)
> +				p2plink->gpu = dev->gpu;
>   			break;
>   		}
>   	}
> @@ -1287,6 +1341,250 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
>   		}
>   	}
> +
> +	/* Create indirect links so apply flags setting to all */
> +	list_for_each_entry(link, &dev->p2p_link_props, list) {
> +		link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +		kfd_set_iolink_no_atomics(dev, NULL, link);
> +		peer_dev = kfd_topology_device_by_proximity_domain(
> +				link->node_to);
> +
> +		if (!peer_dev)
> +			continue;
> +
> +		list_for_each_entry(inbound_link, &peer_dev->p2p_link_props,
> +									list) {
> +			if (inbound_link->node_to != link->node_from)
> +				continue;
> +
> +			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
> +			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
> +			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
> +		}
> +	}
> +}
> +
> +static int kfd_build_p2p_node_entry(struct kfd_topology_device *dev,
> +				struct kfd_iolink_properties *p2plink)
> +{
> +	int ret;
> +
> +	p2plink->kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!p2plink->kobj)
> +		return -ENOMEM;
> +
> +	ret = kobject_init_and_add(p2plink->kobj, &iolink_type,
> +			dev->kobj_p2plink, "%d", dev->node_props.p2p_links_count - 1);
> +	if (ret < 0) {
> +		kobject_put(p2plink->kobj);
> +		return ret;
> +	}
> +
> +	p2plink->attr.name = "properties";
> +	p2plink->attr.mode = KFD_SYSFS_FILE_MODE;
> +	sysfs_attr_init(&p2plink->attr);
> +	ret = sysfs_create_file(p2plink->kobj, &p2plink->attr);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int kfd_create_in_direct_link_prop(struct kfd_topology_device *kdev, int gpu_node)
> +{
> +	struct kfd_iolink_properties *props = NULL, *props2 = NULL;
> +	struct kfd_iolink_properties *gpu_link, *cpu_link;
> +	struct kfd_topology_device *cpu_dev;
> +	int ret = 0;
> +	int i, num_cpu;
> +
> +	num_cpu = 0;
> +	list_for_each_entry(cpu_dev, &topology_device_list, list) {
> +		if (cpu_dev->gpu)
> +			break;
> +		num_cpu++;
> +	}
> +
> +	gpu_link = list_first_entry(&kdev->io_link_props,
> +					struct kfd_iolink_properties, list);
> +	if (!gpu_link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_cpu; i++) {
> +		/* CPU <--> GPU */
> +		if (gpu_link->node_to == i)
> +			continue;
> +
> +		/* find CPU <-->  CPU links */
> +		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> +		if (cpu_dev) {
> +			list_for_each_entry(cpu_link,
> +					&cpu_dev->io_link_props, list) {
> +				if (cpu_link->node_to == gpu_link->node_to)
> +					break;
> +			}
> +		}
> +
> +		if (cpu_link->node_to != gpu_link->node_to)
> +			return -ENOMEM;
> +
> +		/* CPU <--> CPU <--> GPU, GPU node*/
> +		props = kfd_alloc_struct(props);
> +		if (!props)
> +			return -ENOMEM;
> +
> +		memcpy(props, gpu_link, sizeof(struct kfd_iolink_properties));
> +		props->weight = gpu_link->weight + cpu_link->weight;
> +		props->min_latency = gpu_link->min_latency + cpu_link->min_latency;
> +		props->max_latency = gpu_link->max_latency + cpu_link->max_latency;
> +		props->min_bandwidth = min(gpu_link->min_bandwidth, cpu_link->min_bandwidth);
> +		props->max_bandwidth = min(gpu_link->max_bandwidth, cpu_link->max_bandwidth);
> +
> +		props->node_from = gpu_node;
> +		props->node_to = i;
> +		kdev->node_props.p2p_links_count++;
> +		list_add_tail(&props->list, &kdev->p2p_link_props);
> +		ret = kfd_build_p2p_node_entry(kdev, props);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* for small Bar, no CPU --> GPU in-direct links */
> +		if (kfd_dev_is_large_bar(kdev->gpu)) {
> +			/* CPU <--> CPU <--> GPU, CPU node*/
> +			props2 = kfd_alloc_struct(props2);
> +			if (!props2)
> +				return -ENOMEM;
> +
> +			memcpy(props2, props, sizeof(struct kfd_iolink_properties));
> +			props2->node_from = i;
> +			props2->node_to = gpu_node;
> +			props2->kobj = NULL;
> +			cpu_dev->node_props.p2p_links_count++;
> +			list_add_tail(&props2->list, &cpu_dev->p2p_link_props);
> +			ret = kfd_build_p2p_node_entry(cpu_dev, props2);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +#if defined(CONFIG_HSA_AMD_P2P)
> +static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
> +		struct kfd_topology_device *peer, int from, int to)
> +{
> +	struct kfd_iolink_properties *props = NULL;
> +	struct kfd_iolink_properties *iolink1, *iolink2, *iolink3;
> +	struct kfd_topology_device *cpu_dev;
> +	int ret = 0;
> +
> +	if (!amdgpu_device_is_peer_accessible(
> +				kdev->gpu->adev,
> +				peer->gpu->adev))
> +		return ret;
> +
> +	iolink1 = list_first_entry(&kdev->io_link_props,
> +							struct kfd_iolink_properties, list);
> +	if (!iolink1)
> +		return -ENOMEM;
> +
> +	iolink2 = list_first_entry(&peer->io_link_props,
> +							struct kfd_iolink_properties, list);
> +	if (!iolink2)
> +		return -ENOMEM;
> +
> +	props = kfd_alloc_struct(props);
> +	if (!props)
> +		return -ENOMEM;
> +
> +	memcpy(props, iolink1, sizeof(struct kfd_iolink_properties));
> +
> +	props->weight = iolink1->weight + iolink2->weight;
> +	props->min_latency = iolink1->min_latency + iolink2->min_latency;
> +	props->max_latency = iolink1->max_latency + iolink2->max_latency;
> +	props->min_bandwidth = min(iolink1->min_bandwidth, iolink2->min_bandwidth);
> +	props->max_bandwidth = min(iolink2->max_bandwidth, iolink2->max_bandwidth);
> +
> +	if (iolink1->node_to != iolink2->node_to) {
> +		/* CPU->CPU  link*/
> +		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
> +		if (cpu_dev) {
> +			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> +				if (iolink3->node_to == iolink2->node_to)
> +					break;
> +
> +			props->weight += iolink3->weight;
> +			props->min_latency += iolink3->min_latency;
> +			props->max_latency += iolink3->max_latency;
> +			props->min_bandwidth = min(props->min_bandwidth,
> +							iolink3->min_bandwidth);
> +			props->max_bandwidth = min(props->max_bandwidth,
> +							iolink3->max_bandwidth);
> +		} else {
> +			WARN(1, "CPU node not found");
> +		}
> +	}
> +
> +	props->node_from = from;
> +	props->node_to = to;
> +	peer->node_props.p2p_links_count++;
> +	list_add_tail(&props->list, &peer->p2p_link_props);
> +	ret = kfd_build_p2p_node_entry(peer, props);
> +
> +	return ret;
> +}
> +#endif
> +
> +static int kfd_dev_create_p2p_links(void)
> +{
> +	struct kfd_topology_device *dev;
> +	struct kfd_topology_device *new_dev;
> +	uint32_t i, k;
> +	int ret = 0;
> +
> +	k = 0;
> +	list_for_each_entry(dev, &topology_device_list, list)
> +		k++;
> +	if (k < 2)
> +		return 0;
> +
> +	new_dev = list_last_entry(&topology_device_list, struct kfd_topology_device, list);
> +	if (WARN_ON(!new_dev->gpu))
> +		return 0;
> +
> +	k--;
> +	i = 0;
> +
> +	/* create in-direct links */
> +	ret = kfd_create_in_direct_link_prop(new_dev, k);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* create p2p links */
> +#if defined(CONFIG_HSA_AMD_P2P)
> +	list_for_each_entry(dev, &topology_device_list, list) {
> +		if (dev == new_dev)
> +			break;
> +		if (!dev->gpu || !dev->gpu->adev ||
> +		    (dev->gpu->hive_id &&
> +		     dev->gpu->hive_id == new_dev->gpu->hive_id))
> +			goto next;
> +
> +		/* check if node(s) is/are peer accessible in one direction or bi-direction */
> +		ret = kfd_add_peer_prop(new_dev, dev, i, k);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = kfd_add_peer_prop(dev, new_dev, k, i);
> +		if (ret < 0)
> +			goto out;
> +next:
> +		i++;
> +	}
> +#endif
> +
> +out:
> +	return ret;
>   }
>   
>   int kfd_topology_add_device(struct kfd_dev *gpu)
> @@ -1305,7 +1603,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	INIT_LIST_HEAD(&temp_topology_device_list);
>   
>   	gpu_id = kfd_generate_gpu_id(gpu);
> -
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
>   	/* Check to see if this gpu device exists in the topology_device_list.
> @@ -1362,6 +1659,8 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   	dev->gpu_id = gpu_id;
>   	gpu->id = gpu_id;
>   
> +	kfd_dev_create_p2p_links();
This ignores the return value from kfd_dev_create_p2p_links.
> +
>   	/* TODO: Move the following lines to function
>   	 *	kfd_add_non_crat_information
>   	 */
> @@ -1507,7 +1806,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   static void kfd_topology_update_io_links(int proximity_domain)
>   {
>   	struct kfd_topology_device *dev;
> -	struct kfd_iolink_properties *iolink, *tmp;
> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
>   
>   	list_for_each_entry(dev, &topology_device_list, list) {
>   		if (dev->proximity_domain > proximity_domain)
> @@ -1529,6 +1828,22 @@ static void kfd_topology_update_io_links(int proximity_domain)
>   					iolink->node_to--;
>   			}
>   		}
> +
> +		list_for_each_entry_safe(p2plink, tmp, &dev->p2p_link_props, list) {
> +			/*
> +			 * If there is a p2p link to the dev being deleted
> +			 * then remove that p2p link also.
> +			 */
> +			if (p2plink->node_to == proximity_domain) {
> +				list_del(&p2plink->list);
> +				dev->node_props.p2p_links_count--;
> +			} else {
> +				if (p2plink->node_from > proximity_domain)
> +					p2plink->node_from--;
> +				if (p2plink->node_to > proximity_domain)
> +					p2plink->node_to--;
> +			}
> +		}
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 4f80d2ea1000..2fb5664e1041 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -38,6 +38,7 @@ struct kfd_node_properties {
>   	uint32_t mem_banks_count;
>   	uint32_t caches_count;
>   	uint32_t io_links_count;
> +	uint32_t p2p_links_count;
>   	uint32_t cpu_core_id_base;
>   	uint32_t simd_id_base;
>   	uint32_t capability;
> @@ -131,12 +132,14 @@ struct kfd_topology_device {
>   	struct list_head		cache_props;
>   	uint32_t			io_link_count;
>   	struct list_head		io_link_props;
> +	struct list_head		p2p_link_props;
>   	struct list_head		perf_props;
>   	struct kfd_dev			*gpu;
>   	struct kobject			*kobj_node;
>   	struct kobject			*kobj_mem;
>   	struct kobject			*kobj_cache;
>   	struct kobject			*kobj_iolink;
> +	struct kobject			*kobj_p2plink;
>   	struct kobject			*kobj_perf;
>   	struct attribute		attr_gpuid;
>   	struct attribute		attr_name;
