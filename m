Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7287EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 17:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFEC10EF2D;
	Thu, 30 Mar 2023 17:18:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEE210EF2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 17:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW4ojVD96xLVS1HAldMQ8ooNwPwsnFmgv0Aw16nAht8UVduDmOkMYsLUurnh86jpN5clDMpZw+lyH6JBrsNUwoOWcdJIWgqR1TxuHf4Bvh2WZsULCvon8MNPL7LqrxThBIvxVxIHfZ0YyTgNRHft3uiRfbfphqiHM6wgi2WK1FvpYb7GZxpchZDlIIL8SmegMQadFzciYB370AsJfKqR17g1OEzr4lkX7RRBMmmGBVGL4X3f4Vl/vHimE3fEfaq2uVzhLoxFXScwOyr6hSwFNQ7YgVg8YxdnR/LNTBD3khp2fBaFswCJbEoCCtCxTJzAX1LFhohBiRKVyq3XNMcCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQwfLNLeE2gYc+dqTMt8yeYlhhURXKUVz/+iDp1ins0=;
 b=GdKk3DHLmEQNzYWBWCn8AmBpEOWdDTwCG/lUjD8rQGOoD1uJPTK10ZvcmtXzv5AJ/obAMZZ+Zf6glof3+4siDVT5E1/fxhrgShlTqvgaO9cF+QIhy5wvwvHWSQ93XwH5tQXc1gdw4oHayLd8Ak/EsukXuh4BpYOvqPgihL8aYcG4uE6LzBizmMm1yNlGgccxOLmT3/tqSiFGqE/UPB192kfgWL/yDkvjvoVLsb9gd4vxpwjBKOcrl6piPiDG30H4PdJOKDbO7tY3W/VkwY6/HJtNKf1wjMxY9brH8YsirHqSmltJxF0V6oS/4s/u/M1a+5NTmNky6x33+lCYM5eoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQwfLNLeE2gYc+dqTMt8yeYlhhURXKUVz/+iDp1ins0=;
 b=YObZ+mk0y+Sva5NTIPAZEWxOPaE+4OaF2iN2XkktZX+l8RowxlEWNi0sTBEiQ9lDRpaK9PFKzUb4MSEWlsu+wY/P4VT/KxLjl+6xMCOSF9FZOTprKMfoGu2B6QDl1mHoAe4H//YJWJ4HCKyBRr+zans82d2dsdJ6WPWeKjH493E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 17:18:14 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 17:18:14 +0000
Message-ID: <0362df49-3887-37a7-111c-430c2c75e951@amd.com>
Date: Thu, 30 Mar 2023 13:18:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-12-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 11/16] drm/amdgpu: get absolute offset from doorbell index
In-Reply-To: <20230329154753.1261-12-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: e49a66bb-58d3-44b3-fe22-08db3142bef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vU+mfTmf3tOtr0Uzog6ACMk5eT4JbyfVUgBrYX1POz1ORLsEIiYUeCQsTs6uKpgIIB0rj/ui3rrL3Ru26ySnbG0mWheEfYYY9jotRvgVbcfgUIw8iD7ka8YiFMu+6pPVbuGa6wrJpZK4C7zpTzMDsPnUcl1/y0ai3T/O6dDxhVB/N+z351QiKLj+ito8jz5lC5apwG4sgPNhOOBEuo5y6AaE3OXXldALvz9DN9qNSIqGjan9f3VePQADWGDajRKgsqeSZwiN5Ffsi3gD2BNTKCmjS0/ZWFO1diVOou9x0fOwczhs7wIOb+bM/D0phyryuxWCrphRyzA7VT6kZH9MiaJNpPnsRU6x5hYpoX20rJx7zxDSpwn1ga4xuYcpzu678f1e/lwpxWmoObfEy+0JZr5yd9y8WA6z95ivElAY8amLqi2qLJ4XJyY8y9LKHeUDl647ywJIWVH55HSPDX9jh5zRLGjm/56QQb+WirhpPY1JtdJrA9M9jKTwwgoJwS5HxWXVF/cZLQngl+OL3JNmufx3i2XNRWX9GgOMtoQ2xASC4xO7MQT97tTfX2Z+nGK7DzfLdZ3UvOGfjqHpzFON6n1oWIg+WtjlMrWi7uX98DHVjZNcdcRaGp9w0jFulLvX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(2616005)(2906002)(44832011)(5660300002)(6506007)(86362001)(966005)(26005)(53546011)(6512007)(6666004)(31696002)(6486002)(54906003)(316002)(478600001)(66476007)(8676002)(8936002)(41300700001)(38100700002)(66946007)(66556008)(4326008)(36756003)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1FJN21NUittNEdtOTB0VEtGdEJWQWdtQWhPL1ZnSUwzT3RRRWFnUnBvWER2?=
 =?utf-8?B?NndnLzkwL2VqRG5MdStkZVp1MHZkUnVYVmlpdjVIMlhOa2tId2FVcXNXeHAw?=
 =?utf-8?B?eHlNNDZDU093anRQZStCdTgrSVJQdGxzVUcvUWhCTUhmR25UWTAyUnpvVUxl?=
 =?utf-8?B?dkxUd01wL1phRTdWUmhWRVBONk95a1AyYzE5NGo4MlpYYkZRdmFPanAyUTZ6?=
 =?utf-8?B?QXhCcDhad1RsWFp5WURyK2h0Y3U4amdGMnM3bWJQdnFId0hrZWV0ZFk5OWMr?=
 =?utf-8?B?TjN0NjdMZjE0NGNIOVBwRTFXc2xLdk9RQU9LVEhJL3FKNzNteDNjVVpNTzY3?=
 =?utf-8?B?cFk5VGxZb1dJV1FMWHFhSmVMcTV6UlR3WTQxZ1lZMHJoM3ZGQWlkV3kzUjZy?=
 =?utf-8?B?ckV1VGV5UzhkVGljdjhaYWprSkpBbWRwRzR2OEtWTFRwT0ppbGt1bHhKeEdL?=
 =?utf-8?B?YmI5WmsyL0RUSEFlS0M3SWkrMklCUlpRbVU1Nys4TkgwTWc2N0NZRUV0SFdl?=
 =?utf-8?B?MHorZnF2NXg0VTNCRE95YUYxeEgya05QSHE4NjFSZytSaDJWdUg5S0s2NkNS?=
 =?utf-8?B?eTFjMGYya2k3R2VHaVRxQVg5d0dHRGZDL2tWZXBvK29LM2NENTdNeUhHSXl6?=
 =?utf-8?B?VkN5QktBd0JNWlRtQ0x0RkVYYTdhSllTZk0zdmg1VkMwaHpzK3F6d1B3dWJ6?=
 =?utf-8?B?eUtodjRRcWVYK21reGdQQ05EN2R1TkVBZXQzN2VLWmxxekVKQkFVT3dPYVk3?=
 =?utf-8?B?anhGRXZtZEdiSkoxY0M4SEhzYTkxLzd3WWtudmdxUWlkLzI4Zmg5cENoMjFD?=
 =?utf-8?B?cHdCQlp6b2lWQ2kyd2tKZVh4UktDaCs5SEhWVitUL1llS1dYSTl4ODNubmd6?=
 =?utf-8?B?enAwdjl1VE9Va1ozWXF3eHltcHhPdG1McFowV05ycDF0cmhWZ0FHUnk1Z1Zx?=
 =?utf-8?B?aWxOOHhJTnoyUG5Ja3NPVXUzTmxpczVESjI3VFl6dTZaREtSWVY5LzM1ekRy?=
 =?utf-8?B?SWdabXdaM0VrZTdjaG5pc2ErbDVKMDF5Y3VSMnhnZHZ6R2w0QTAxL08rLzBO?=
 =?utf-8?B?Q1pCZWRwSXU1WnR0QXRVc290RFZrLy83NlBPYWF0b1VsRW8xdXpxMWd1T3BU?=
 =?utf-8?B?Y0lYUGQwN3pQUGdZM0pZa3lKa3dTWDVtWEl3RS92TjNQT1FQTnl2Qnl1YWlK?=
 =?utf-8?B?ajRmRGJUN2ZMNHpQbGJpQnZ1LzNmMk9VUVZWYnFYUTFlWVFuWWhEaW14a214?=
 =?utf-8?B?NHY3N3VzbG9NemowZE9PL3JuOG9sM1VUdzEvWUpkcDhxM1NPdXBRR0xsMDZM?=
 =?utf-8?B?d0ZDUi9FWUhleTJjWk94YVR2am5LNzFCaEFmVDQ2aGF1UHc1K0grM1MxUGlL?=
 =?utf-8?B?ckJCT2dFTGhrU3p4ekprMVVodUhmdjM5MUhyTEQraU1talQvaHBWUXdDQmEv?=
 =?utf-8?B?aXBVekhJb3ZjcXQ3eWJzdVovL0VZN0RIcUVaMVN1NGk3UmpZK3hnT1FaYVFq?=
 =?utf-8?B?cHVZaFNuY2ZhMHp5aE9pVSs5bVRoc1pRWkJwcmJiQUpyR3FjYXQ0ZVdMOWh2?=
 =?utf-8?B?SHd6cVpybGxWVUwxK3IrUkk0emxUYUxVYWtOd3lSdVJxdXlYUE5CYmpXa2tk?=
 =?utf-8?B?aGJsWjhLbkc3ejhJb2VOZ09vajhjNEpvL1F5OUw2S3A3eDc4eVZUMk1mNWMv?=
 =?utf-8?B?T0xzOXNkNG1Tb0RZM25lYWV2MHJ0bmdIZmJ3YTgrSmF4a0VPZmRLNlZvZnFM?=
 =?utf-8?B?YXdJb2hUTTRneUJ3bEVWZ1MzR2RHajBWNFE3SkRDQVU3U3dqS21qVUNObDhm?=
 =?utf-8?B?NEdud1pHdDQ4SXdQSWtlVEJOOHBwTngvcElva1ZQSDNIekF0MTkyT2trdU1F?=
 =?utf-8?B?ZW01bTVBU0NGSkF4azJOYTlkWnlBUit5TzBXdWxoNWUxazVyU1czUmxUME83?=
 =?utf-8?B?NEVPWGpRc0NIMkE1NFZjRmFSdU9BVUpLNU14SVFMUDdMOE0wUnJrb3RFVk9j?=
 =?utf-8?B?UW8wOVBLdW5CSWpFZjI1d3lYMmo0NWk0RVNnMzJ3TEgzQWZJS1dXTHFJNEsv?=
 =?utf-8?B?NUxtaEE0N0FYWFdWTEt0Vkh4SXpnYTErOVgvb29PQjhZdUdZTnBNSEZjR3Zs?=
 =?utf-8?Q?0qYZ/YwqD7QI7ghvvUfiZOUjr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49a66bb-58d3-44b3-fe22-08db3142bef2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:18:14.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXfByil0cCcrF565F2c/VXkjLxd5IlFzgUIvB9dwbmwhi2/igyAwJgT4BOxpOoEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 11:47, Shashank Sharma wrote:
> This patch adds a helper function which converts a doorbell's
> relative index in a BO to an absolute doorbell offset in the
> doorbell BAR.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 15 +++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 26 +++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 10a9bb10e974..3481e9d83879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -383,6 +383,21 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>   */
>  int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
>  
> +/**
> + * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_bo: doorbell object's bo
> + *
> + * @db_index: doorbell relative index in this doorbell object
> + *
> + * returns doorbell's absolute index in BAR
> + */
> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *db_bo,
> +				       uint32_t doorbell_index);
> +

Two things:
1. No kernel doc for function declarations--this should go to where
the function is defined. (This also removes redundancy.)

2. No empty lines around function arguments in kernel doc. See this about
the format of function documentation:
https://www.kernel.org/doc/html/v4.12/doc-guide/kernel-doc.html#function-documentation

>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 81713b2c28e1..c263bae6b0c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -130,6 +130,32 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  	}
>  }
>  
> +/**
> + * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_bo: doorbell object's bo
> + *
> + * @db_index: doorbell relative index in this doorbell object
> + *
> + * returns doorbell's absolute index in BAR
> + */
> +uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
> +				       struct amdgpu_bo *db_bo,
> +				       uint32_t doorbell_index)
> +{
> +	int db_bo_offset;
> +
> +	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);

amdgpu_bo_gpu_offset_no_check() returns u64. Perhaps use u64,
or u32 (which is what this function returns) and cast it down.

> +
> +	/*
> +	 * doorbell index granularity is maintained at 32 bit
> +	 * but doorbell's size is 64-bit, so index * 2
> +	 */
> +	return db_bo_offset / sizeof(u32) + doorbell_index * 2;

Perhaps add this inside the comment:
* (db_bo_offset + doorbell_index * 8) / sizeof(u32),
which seems clearer to me. But leave the return as is.

Regards,
Luben

> +}
> +
>  /**
>   * amdgpu_doorbell_free_page - Free a doorbell page
>   *

