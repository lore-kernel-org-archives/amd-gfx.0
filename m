Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E217C4321E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 11:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF39610E54A;
	Tue,  4 Oct 2022 11:13:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F5410E54E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 11:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7CnPuubpGDfKyfjMkgXc6rP9ItoiFJGyLTnsUn5GCzMmFYt/HXUjPpmOziVMo0yL4sg0R0kkcali0W8jMUZbg3opRdK03IcO2xb99tdY51sFoPOGZQdLud/LNHIG7ZIRi/AboU3a26hTMR64VRZ5HkLB/tv0TqeYGQhZnRehu2L/GbItUoYEncCXyctl9jTnOKSr5hLTnZ6jVDYef22Q9cGOcU39gruPqbi0Afn3YCD8Z6kvPb9GdIunZfBXYwlQ432rbup6MA+0mZhqJYdRmb9fnBCITTrX4Rv0sCub45kM5/5Amc4eiW5EMBl+i0IF2qxpnTmIi1S50Qz4LCpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/Lhgj0qHHymkh3UWeFIIHMXiXRHJ4Ss2EX2QHxdAtA=;
 b=Kf+eiQxz8UHn+Qo3QqrIikmkiwdWslTsBO+wsunuTloTdq/yYJTTW/ESUXjD3gDYRKVVEtNgB2x8ozsBVL8/D5tUDEpnNLk8y85TSBdYudrKlr/zY6Pkz49O1Vdh+vqEMRjw3i4HIlvS3CLyNgpG/qLS2qvWdsts3Mu79kH/qkM5i0OVnjUtAI91uzN2Vm9ddSILqbf9LX9JHTL4QHeTFK37/fF6HiB2GJjFoDYfzUAGWSIpyZuPDskCZjj/4U3gXMRAQCTJ46A3cHI9XmBh5ZlTsTRUoIKgdW6BzWeZDgc4S+RNNksMAEggIfsQgb8NMPEuw4YfFnqU5r0A1hEqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/Lhgj0qHHymkh3UWeFIIHMXiXRHJ4Ss2EX2QHxdAtA=;
 b=XJgizjWa5mKxwBDpnC40Dsvvv9aKwYx2au3chrs1UjGhLfBQmU3MmA0ExJGFdWnSspvUva2IN30ADTdI54Kt2v0PiIU+gchX5gnTBG4iVDkrDVrcJ7K2Dk7Nm4nFvylRq0gYWsGiOoIE7XK7uIMFcCSUXrnVEK+zKf+UO7+ZbGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 11:13:17 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:13:16 +0000
Message-ID: <60f3940e-c2c7-7854-a648-e3f1bc086d93@amd.com>
Date: Tue, 4 Oct 2022 13:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Set vmbo destroy after pt bo is created
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221003172030.1389-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221003172030.1389-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR07CA0017.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::13) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6d7db5-5f4a-4e53-c55a-08daa5f96f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SYOaKUhefzu1977tbWndXW3PQfh8v2pOEXUg3NEZ6CAlplGY3B1eEw0XWMy2bw8NZMcPEJfHY/RfhQk+MKEjQI3vYQjZovjxeEpvxV3/X8uQ1W8+dgUaF6TUyZkKvedopRlci1SUQ4DKqquPZHL55y0egVzLaSKN/ITf8gQ+Wcc0/NMfMceaP47ZjNxc8EVVSvTRp+Pd9Kc7ZMu7bSDEgRU3bNiZg1srtOq7dHkN426mBBSVvtzxtmwDZ51Q+VN8We7cPU2mK60DdVdJJtcdeBb/fj9DUpxf1dVVbifzVjpSDsGJTyjBZeWZLzlCsiiIlR3ItZMny8KgHRPDRQdt4/F/ul2wUaZDcNMSVLL2Gr9Pf198gumJIYEag6+U+LLE0kxwz0uEAR8TOOABiTXZoT1RmyHM+AbbFn67ssal4EjAkUv/wGXxLL+ZIqUGTWEfUKbmNFwJPMa3aSx24y5gjiYk8TP+dHEOY0c23z5J/Rqc8rXVDt0i6I/Ham4LOB+VAert8Iz6/f+ok0FZjrQCBcvwNswRma+Cb7DNbhWBGHd6XJdjDRg4KrPXFnEhb3NjtZH7RQLZo8GQEVGNSShcJkfQFPlZaKeeeObanel0nMA7891CivRSMbrgwKASZCWc2HAeQ0sdj1+Bj+be8a9mRRqfWaiwuUW41ZQqYFb5l6lVh4xUHIlS18r39a8UgCgmf+1S7U7V30YE0SjLtnrYM8FTTymCbZV2MbfaDeekHUk5hcsSmQOUn2Iqizf31Ar8UwgN76ira7SH6B7JXVq+MW1CuNqW312taYVVdwhE9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(66899015)(31686004)(41300700001)(8936002)(5660300002)(2906002)(31696002)(6486002)(2616005)(66574015)(6506007)(186003)(38100700002)(478600001)(66556008)(66946007)(66476007)(4326008)(8676002)(83380400001)(6512007)(86362001)(26005)(36756003)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjUvb3ZuK0FGREEwcVV0MkRLN0xDaE1BUDFQVmFRMld3Z0tOUGphTGNtNi9z?=
 =?utf-8?B?M1lrcnA2QTJvYnhtREFiZE9VeDBQY3RQN1VwVjBOSHJjN2VLRHdZbnpWcTdr?=
 =?utf-8?B?bFFkVGpFMnllQkpsVWRVWUpCbGo2WmM3eDl3OU5NN0pBMFpJOHliYmQrVmlC?=
 =?utf-8?B?bVBNRDNkQlF2R01FL3JxVlhhR3hFWk5zelNXOUVZeFNoZnViYUJrMndpMS93?=
 =?utf-8?B?M0hBVVh6ZXJCUjNTa2hoYzlmSzhlOEhKWHQ0WExWbWJzRThzSTdwQTBsVmlh?=
 =?utf-8?B?MjgrcGVGcFA0V1lHMVh4Y1VBclppSk9BemRNOFl2QmNNdGdFd2cvRHltOS85?=
 =?utf-8?B?U1Q1aEZvSkRubVdWWmZIc1FHWEplRmVvT2VyZUpSdElmOTZOVk1DUUhvYkFU?=
 =?utf-8?B?WkhydmFlWGxydXoxelRJY0dnRklIcGFBMWFVYUh1NEwvOC83OExQaitiUy9k?=
 =?utf-8?B?NDJmU2xabm1ueEJmOEcrZ1FMWDhMZFZlWHNKOUNvSGNxMXYxZXNMaGlZMVRS?=
 =?utf-8?B?djlXc2dZNGZxODVDTDVZMmcxTGpILzdlOERQWkdYMWYzMU9ibWNqWFdMS09B?=
 =?utf-8?B?bGsrSlp1QXlKUWZuY2paRTRoVEc0NWV4ckFsdkIrc1hCOWtsa0tISk5udFVs?=
 =?utf-8?B?SXhTT3c3aTh6MDEySmdIZno3MEVCK1BXSjRWbG1xZXNydWFyVEN4LzJMaTdV?=
 =?utf-8?B?eTQ4dTdhV1M2T2RCeW0rSEpNSXA5by9TTFNaQVVuandxR1drNzR0K3lrN0po?=
 =?utf-8?B?Mmk3WTE3RWRETElES1huNk9BUjkyZDZ1cStXSGRBcUlDQVhBeDF1T2JENlQ1?=
 =?utf-8?B?VE93eG81V3Bobmd1aXpoNmRtSXhnNG5HSEhMLytTREJCVEhjTWM5SU1qWFlB?=
 =?utf-8?B?bmtOYk1kQlhnRW1Mb0xmS1hLdHh0T20zVnJTNCsvMjNEbE1CaElvTjZQcjV5?=
 =?utf-8?B?L3R6VjhRUW9BWCsreDFyaFZQRjNZdTFzOTlyQ1Jocngwajl6NnpLRG1GQ3ZT?=
 =?utf-8?B?aGdtdWU2NEdwNHFqVW1YZXI0UXNDaE5IeTR6UnV4UWY1TDhWQnRUeEFEZUds?=
 =?utf-8?B?RmhyVE5LVVN6b2lsUDhBTHVGY3VFUkJsWHpZalFnRHpRRzA3bDZJTXFTV2J4?=
 =?utf-8?B?b1Znd0hLdFl1bjc3MGdSRWJxKzRHZkFiMmxkRkRDcVkwejUvd084VnhJam8z?=
 =?utf-8?B?alJvbThBVmhGRVRCWGpaZWVZNmtYdTlZSndjNmhyV25SU1JQdW1tRWY2V0tX?=
 =?utf-8?B?TXViUjdONkdDOUgzdVI0SlkwVHIvd3RJdy8rWVN4M2Y3N2lzck92ajRjeW9M?=
 =?utf-8?B?NzZjbVpaelF5bWF0M2VOZFQ3Y0wzNnk2eGE5ai9zQlNQOXRqRVVoc0J0alRT?=
 =?utf-8?B?RHVGUlFBQWtJVHc5c2Ixa2VNaHZsSXNWbFlGYUxSM3pHbkp6R2RScytRY0Q3?=
 =?utf-8?B?MTE3bi8va2Y1UnNsYTZFWHRiT2JCSUlnUmpBWjRvdHZIU3FRL2hDeXdTbnR3?=
 =?utf-8?B?Z0tsUUpXcU5yWGZqcmxIaGVNMlFFZmRIdFJ3dTFLaXd3TDhVeG53L1hhbldG?=
 =?utf-8?B?QjZ3MG5sQTNaZFVFbkd0WEhjS3dYY0I0SXExbU9BZUc2OUVaU1VxMTI4VUxa?=
 =?utf-8?B?aDRlcVlmdTg5NXh1d2ZiRkhMUU9zbVJlWnR0NFcrYkQyRk9QcXExQmV5NWhU?=
 =?utf-8?B?WmRPSjdheFhCK2VOcktnbWN0bDBHbVN5L0lEU3JmaFB2TFFPYnhpWnpISlBM?=
 =?utf-8?B?eVduMHMvSXV1NXd3akkxU1lveEZEMjBqdVJiNzVQbzBYdFdQai9tNDdidTNW?=
 =?utf-8?B?VVVEUTA0aUZ4WjJMdVc0NTYwU0pSODNFSkQ3U3NCazAyWFBmemsxdUpSQmNS?=
 =?utf-8?B?NzJsRjIvN29KRDYvVDJ2azFtcVhLQjZBRlJIZXgySGQ0eGxRbTRac3A0MVhV?=
 =?utf-8?B?NkpEY3VGOU9JOW5HeFg5OHZrdkxwQk81U0Q4dE4ycVN6MElLZGpXdFJOV3Fp?=
 =?utf-8?B?YkdCU1pNc0Y1YU8vMHNrMnAwbDFiR0VEMDcyUHhLTHBrSlM0azZ2Y2Q3amVF?=
 =?utf-8?B?aEtaMWRaUEdGV3RKWjM1bUNmS1lVbWRMWFlQVytFVFdwWTVIYi9ERmJJT0I0?=
 =?utf-8?Q?HjLA4e9LaOnLNO6tOiR/DlsvO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d7db5-5f4a-4e53-c55a-08daa5f96f6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 11:13:16.3997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVuFTDRlNT6XzP5M0XN8PQEmFRMzZTVp7TiAyebOVLsBjI6boErC4Zxv8AFTFCT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.10.22 um 19:20 schrieb Philip Yang:
> Under VRAM usage pression, map to GPU may fail to create pt bo and
> vmbo->shadow_list is not initialized, then ttm_bo_release calling
> amdgpu_bo_vm_destroy to access vmbo->shadow_list generates below
> dmesg and NULL pointer access backtrace:
>
> Set vmbo destroy callback to amdgpu_bo_vm_destroy only after creating pt
> bo successfully, otherwise use default callback amdgpu_bo_destroy.
>
> amdgpu: amdgpu_vm_bo_update failed
> amdgpu: update_gpuvm_pte() failed
> amdgpu: Failed to map bo to gpuvm
> amdgpu 0000:43:00.0: amdgpu: Failed to map peer:0000:43:00.0 mem_domain:2
> BUG: kernel NULL pointer dereference, address:
>   RIP: 0010:amdgpu_bo_vm_destroy+0x4d/0x80 [amdgpu]
>   Call Trace:
>    <TASK>
>    ttm_bo_release+0x207/0x320 [amdttm]
>    amdttm_bo_init_reserved+0x1d6/0x210 [amdttm]
>    amdgpu_bo_create+0x1ba/0x520 [amdgpu]
>    amdgpu_bo_create_vm+0x3a/0x80 [amdgpu]
>    amdgpu_vm_pt_create+0xde/0x270 [amdgpu]
>    amdgpu_vm_ptes_update+0x63b/0x710 [amdgpu]
>    amdgpu_vm_update_range+0x2e7/0x6e0 [amdgpu]
>    amdgpu_vm_bo_update+0x2bd/0x600 [amdgpu]
>    update_gpuvm_pte+0x160/0x420 [amdgpu]
>    amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x313/0x1130 [amdgpu]
>    kfd_ioctl_map_memory_to_gpu+0x115/0x390 [amdgpu]
>    kfd_ioctl+0x24a/0x5b0 [amdgpu]
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Mhm, quite some hack because or init and fini sequence is still not 
ideal. Please add a code comment explaining why we do this.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4570ad449390..ae924db72b62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -688,11 +688,11 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   	 * num of amdgpu_vm_pt entries.
>   	 */
>   	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> -	bp->destroy = &amdgpu_bo_vm_destroy;
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
>   
> +	bo_ptr->tbo.destroy = &amdgpu_bo_vm_destroy;
>   	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
>   	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
>   	return r;

