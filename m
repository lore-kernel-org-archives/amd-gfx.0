Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA8C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 21:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943DF11AC05;
	Mon,  6 Jun 2022 21:07:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4675D11AC05
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 21:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVtHZT3NxTo78qT/xH9UWLb9aI/39vLGD9BqGayKU6eYRCoO5hJa501Wu4YXmadZBTIY+IEy3CTMEbW0YTfQ9WdfrwMAuISBXLrj89TJ0AziUDPLAg/TsaA2x2fVyk1eSt92p5f1qjXefuxj/93kCtav91bI6+zzHDXp7GXyBvNnRpKWMeMMdyaQ9mJS3FvWLWvMuJEUrN52ddKuZlPBxB/5X7YDWdFdlJZIFPy8lXXjWscz4gO+nf9vCzsj3haVNeMoPY04bgBut88VW6OdBckvch54chIc9vCd8w4MF4iFAtlya36+64lM6p635F82Pi5cvURJCHwUGVb4fFklJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/b9Tcmdlb10lbuza2fY5C/iH9Qze6Tj9BDGld77lnw=;
 b=lzMrN2f7YFAvNY1xZksINb8eY+hLEMO3K6lhM+lYaHgSf4MobNhjspv1uBvS63P54Rx8feIGUqtIlzlqO+EP6vz8wOwt5P2YKsEKetlSn0iDkdjobrA3Msr7zd12LBp1rEwpJChYUmNpGAVSy0XpCYOPN5IPRXN9LYZZHN1i3dDlNnXcdyIbyIG2EwMJlevljUM52cC7udn3ySZ928pSorrNtGWMjfTrjAWs/Sg3tOto82GB46kHDvkmwZnD6wg7LPEvt7+AzC6azGAspYm4y+JM3O64tzjjdkAE4g49d8+gy4NO5b36fj40tboIZ4oDu89IJUYidXxVN6dXxOH22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/b9Tcmdlb10lbuza2fY5C/iH9Qze6Tj9BDGld77lnw=;
 b=nHVAYQ/eSKzpUdCJ+agWbZbA3lHyNBU3hPCXpmSFKSJdmXPgPDTV43G269aT9iGO+G0+MLHhCzZ6IvDmuEaJn+554Lxizt9NtU732ELxnrrQLKyOuQV+RTYtkm+rBGgI1l55VlY7fGpeWcwevQ8/eCyCP6R9/Qsu2xQpim6kXO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 21:07:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 21:07:54 +0000
Message-ID: <86337ea3-fb05-9c21-434d-d07e5d38830f@amd.com>
Date: Mon, 6 Jun 2022 17:07:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdkfd: Extend KFD device topology to surface
 peer-to-peer links
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606180806.3322667-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220606180806.3322667-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a21ec18-0d1e-47d0-65d7-08da48009fba
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB49132366ACF523E17ED67A0E92A29@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1TtyT7KVHt8NYpsNUia519Jh2IYp6vchb6DBUIKnC5SOt9vMQxz5htEw0lQoUz9cByCHRpwrkP+VAe8wVPgW0grc9vBB6E6U3hshle2dL7cV+6dBD0u2z7JHZnRb/FL/yRpz9Fvbk639kBz2pYU1odhNf7U28FSEfr8MGKSOdgUhO+t/1alTQV3Q7CzrUaZSY7dbvSGfPIq7zhM6ksjeDtgD2B2sb8REoEptleMcNDz/m21MUQ0KGj0k+R/Ue9gkGUBmkLO8ZZ5MANt1f6869hNLqlnvmN/+dSqJvXIDQlGoACXkaV69uU1BUSRRjk8yx24kqvTjw2UbQEjgN/I7usvC3lyxq8zjckrpNyNKjKcLiakHFWVCAi1R9lycLCQL4/Efc4pYzCYSZmx4XiVJM084sNHxGlCB3bMnEBAvsMLF4+e8n+oKW4KaozGYdlTNNKs8cigFnGA134D3l3jAXtx7XPNwoNzAhel7VOL+a4RCQsPwjVDVL1TbQvb3+UXfzG89NzYRCg4A9lGyfoyeWhFWrNfxIi2/EryupsvTHt2m0bEeHTVLl+xhpPWwZ/tOZsAqPRkGvMwbgl61pYmT6ufV83QNe2qVFcBauZKQGXAXSm+XWmJRq+Q5vSTYPsTm7dDwnbNmfT/NKWipHResDZ37wbRnYBjhwH2cpgoBylM4D+cjK0glBNFrlwUQ0nFwEeggJiVTVsHLZUqEOn1xFHuoZQQ0zNu177ysS54II3pk3XYsG3MO2dw85yNp4QW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(66476007)(8676002)(66556008)(66946007)(44832011)(30864003)(26005)(6512007)(6506007)(38100700002)(508600001)(6486002)(5660300002)(2906002)(8936002)(86362001)(31696002)(316002)(31686004)(36756003)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmU0eDN2Z1pnMWlMSlQvWklLK3RXY3JGTnpWdE1UdlFVTTNEYmVrcThIMVY0?=
 =?utf-8?B?UGYvcGNvY1hoRWtIc0N3M3NIMldGVTJYWGNhVlZGQU1LMzdvUjVrTW1rd0s5?=
 =?utf-8?B?OUszUGltZzBYdEdxYkszVHpiYXN3SXdLbWFYYXZtRWhpcWFBMWF1amNmbmJw?=
 =?utf-8?B?NzVjSkd4TXJMUzBsMis1NWE2L3N5dzJPY0R0ajY5K0o2TzZDRnIzTEVyUkhL?=
 =?utf-8?B?ZkxmOFdHcmFSNllvd082NkxPVEZKc1NlbUQxTjJzeFNyZElzTVl4QnFlUEVK?=
 =?utf-8?B?UXJvSzFVM0dtekdaM0trMUxrTktCd2FWK2J5a05kdTdoeXV1YVExVDBxaWFC?=
 =?utf-8?B?T1Q4enNvMDJVRkJMcEQzalhmQUtheEY2ZWZ2eXdINlBES1Q3SUNUcEhsUU9F?=
 =?utf-8?B?b2szQm03bU15SjJKSWQrUFVTdFkxN2pKNjYwbEdOQzVCeVVLR2M2dnh3dnBk?=
 =?utf-8?B?QUl0WEs4bUxUd1NSOHVzZDNhZndkRDBzZXBjSkNjMFRHU1M4d2JQT2ZzRng3?=
 =?utf-8?B?L2JYWWlXS2IxeU5uVllhb21EM2ZOSkZUQ2hrTVhhdk1OL0hCK0RhUm5MUnha?=
 =?utf-8?B?aUNHWjVzTjRya1NXVTVrOGFYSFJBR0g3UjFZMkVBbVdYMnRQZE9WZ2E1YWRG?=
 =?utf-8?B?WjRTa2xFS3hNa2tmT2dxUXlsWW8wZ3dXQTBqY0J3K0FDL0E3MkxlVTIwUUhK?=
 =?utf-8?B?L0VZdWVoekdvRGdJYW9EbUVIMWRZVUhUVjlhSTFVdHgvRG50b29MSytNSlJr?=
 =?utf-8?B?V2p3akYvTkl6VnhQd0haM3VJaVVHdEJLWXQrL1g1SDdYYzgva2ZlMXVTSkFs?=
 =?utf-8?B?V3JtSXJRMUxnNkczb0x3elZ3cXo1ZGdwKzQwV0dyUmZNMTVDcmFKZGgyakRL?=
 =?utf-8?B?cFZ5S0dmS0NiWlFiSlB5aTRaV0syblRBclRhRTdTdEt2WDBsSXFXV1FvRVV2?=
 =?utf-8?B?Q3Y1NUFiTW9BWHFSZ0FZdFJGa2pITDcwNVJlNkc4NEc1YnV0NGhiQkwzYUNE?=
 =?utf-8?B?MDF5MWdzbGNnUWplM0VUck5CVTVPL2t6V2ZnZ0VXL0RCT2F1MGo4VEZUTmds?=
 =?utf-8?B?dVNoU0hrbkhKZy9XZEJuYzFNcE5MTEtHVVdiV04zaTUyclZJL3BCL1V4Njg4?=
 =?utf-8?B?V2lXcUd6SjM5emNlTjFmSVFqQ0tLaDFXK2dZNG52VE1ad3FWYzNzUDRFWkI3?=
 =?utf-8?B?TlMvTU1RSUNDTVFEbEZvRFFwQkJkSVpnTS8ybzl0ZlRxa2FMb2JvLzNkVnFv?=
 =?utf-8?B?QXlOOFhLZEIwdS9XMkpZQVptRzQ0NWZVVTV5c0diU2I1RnNyb0dFTkllMlVw?=
 =?utf-8?B?QjBsR0V0T2FzV0prV3ZHc0J3QkFoeG5pMU9XVWRkNEwrTk44cVFERG1DMzRs?=
 =?utf-8?B?RUQrT2ZXVzQzbHlvZVZkY0I0aEkxSFBuTDlla1I4dVpmcVRxUUxRb09qWFFt?=
 =?utf-8?B?UTUwc2lUdGt3S3pLUUVXcW9XSldrTm5xL28zQmx2NWxiNnFhbDF5aTZFOElR?=
 =?utf-8?B?R0pIcEdPOXhTalVKOVFOdnZPNEJFaGdsVlFLVG1zblRCQlZwMFNWRGcvbmZW?=
 =?utf-8?B?SWczbEQzL0pPdmhWWHpxdXN6R1hHRmxuZmdKQmt0VDJKVGlCNEM1OGNxdVlO?=
 =?utf-8?B?ZStVVjdCWFpMSSsrem9mS1EzVjVZRlJMOXMvalNmTUJZbzFORm9wZWl2Umdx?=
 =?utf-8?B?VW5WQTJFbEJsdmkxRGF0cWwwOGVTR3RlRjdYbEVrOXVhb2tnbEpQd3E5SHhv?=
 =?utf-8?B?bDQyWTdLZFlwbWdrVDRwMGUxeTIyQkR5R0VIQ0d2enM4OVdaRk5yL1JSNzk1?=
 =?utf-8?B?YnkxWnAwWVdHZzY5dVpqbTZQRFVTb2tuL0lNemhYbUtNU1gvOHJ5RlhReGgy?=
 =?utf-8?B?U2p0OHpLWEZjajVSMTQwNzFCRytwVXFaMzZ5UmNkK0hXWUtzNmEzZitKc0x1?=
 =?utf-8?B?aFpTZXJyZTVGMWhrZTJCUzlTZEFWd1ZHZU5jbHpiQTBYYTlRb3F3cCtRRjU1?=
 =?utf-8?B?dHlyQ3hmbW9sbE5xODJUTXIxczdVMlBFNC8yRmJKdjJHOFNPazU1alRrSmth?=
 =?utf-8?B?UDBhcHB0S1hXSnJueU5zOUJTVlpWWjNXdy8weStuTDl1WXNZNUlPSDI0RnBn?=
 =?utf-8?B?RURvSmhVOVZ1SlpRZ3J3OCtWWnJFbElsSjY1TWRnNHlSVS9UcGJzRW94Nnk2?=
 =?utf-8?B?bVVWL1N3YnhEcGQrY0pISitNU0wzRnBVTVR6ekRzcEdRbVRWdXgyZDJyU3py?=
 =?utf-8?B?OGoyRk1hRjZWaTl1alY5T0dMSktSV0RsK0ZNOEJiSCs5QXFpbVo1bXRwa3Uy?=
 =?utf-8?B?T3dmSHIrZ01EV3QzU3lJblVpU0tKSVZsckpCOXFFM3MxVG9ZNS9LUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a21ec18-0d1e-47d0-65d7-08da48009fba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 21:07:54.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbOuszbBq+E2g8wOPjWTyIHRYC69+nTpJCHl597zWwEqLHQyRQdzdUafYhijDz9LvqRJUzLDSx/9/A675I/o5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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


Am 2022-06-06 um 14:08 schrieb Ramesh Errabolu:
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

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 319 +++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   3 +
>   2 files changed, 320 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 8d50d207cf66..3e240b22ec91 100644
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
> +static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int gpu_node)
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
> +	ret = kfd_create_indirect_link_prop(new_dev, k);
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
