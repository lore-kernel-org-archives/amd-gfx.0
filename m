Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E6DC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C38F10EE80;
	Thu, 30 Mar 2023 14:24:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC60F10EE80
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feFzvmyhvGWuXt/ctY7TsCyD9q0b9IC2aOFb++IE5prldM2rOUpKR/Njm1cTIUcWQBhjy831kcUnMdUza38aIcRMJnA79Gq8fCv424WrPKec/EQXC3dVI+C+Abt93cc3cNcN5rKJLksa+uGe/JeXotNzkdDCs5ZbuwOYcS0x4zP7YXQkOcho0XruzK24/bIVKHdHXGx7iVm64+IQjgv97Py0DV0iGbP7FsYSvHAMWuyp77Tg3sXCGTnFNLHmC5AWKYOZ/gZGeRU8LiENRY/Yy3CDu2OfQ9Dsf7NOQTqa97nL8lrf7MCSnPXq05t/wMWR5935IyUaezWuv2+1VrEorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vunxDpngZwk/gI38w5OqoC9qhnEJ4Y7UfQXBJ48vYc=;
 b=isgrAfltLzCA5UNJLpNkgJFbbIChSYeclO69HrAwJOvapDv3dQ4AJjRhCn6Cm7usUIeWT/g7sjAEfVfDMcdJdasjUao4N5bNsZvFYewiV2lNLDRHh4ze1gzZPV9cxqDdIKBhZo9Vv66mGfgTgxRoMCW2V3LwZTTLph4t6O6mGKQlz+58dil7dg3aPLWLRfzoTmn7jdvX4NE9q2q1hjGQP1nCKk0OBHLCcV3kSY0JA7AKjxai5qPQQoyARwceg72d6fgKXFSyYjJW6izv1clnQbj2lDQ9dGjwD7BWeZ0ToqOKTU8nS3k4HW0bcjyfSs1wGIXf3LX40Le5Q1xlja+yWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vunxDpngZwk/gI38w5OqoC9qhnEJ4Y7UfQXBJ48vYc=;
 b=OdKjU5pjTHxzdasboW1h8/uA78ORfy5w5+dA4h8Hi0axfvLU9/bnwOIJssnKdMo84DOqBu4DVOMWqhZ16C0VFt1oNk2e/8lpSapaHcwycSBKWy2+7qNY1QO67f2eb5BZU0moNtJAnZWUHmqUCBfs8zY6tYTejdtYzoueeLYygXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 14:24:52 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:24:52 +0000
Message-ID: <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
Date: Thu, 30 Mar 2023 10:24:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
In-Reply-To: <20230329154753.1261-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::28) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a51919-e180-4e1c-cd99-08db312a8685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mo4HPOC36o7/QoQoU5t/4yvck3K5+vvV271/f/fU+YDRMV00pCXAvCOO5NDBAGXB9eqIjKzxuZWMC0sQsuk+e2iQ2CZRQf95Cub+H0+IY6gMjSqp/qbJ1zOySAOyaKiD1FEk835vls5s8Nhs/56l5fBDKamvyxBzrm32AoQo0T6DuT1K5a/UqmLjnwped5lF+zJw7aAcdYPxw+Ac7s7CoOkmCPA/+j3JwQzYkT22O7Y4t3XucwxGoY5/vvkdqBiojXgr4IYJYQOKm+A0wcVOMf4JfHKR5w1j57F4lnZnEg+6j+tqatglYGpOPr32yJJr+5LNfl0jHnKShZl0i8sZG80qD5ryxrWmXMUsximi8eUmcLmLc5OZhsk8wcqK7+sEu9wo4yVPZmEBjfZcDsJqaemqfDmoc0KkMYcEL7min9SD8ivYiq5PpqTJSwotKf1ZBKQn2iCo9MJFOFzUShi7snU0BlNT+P9DmG9YHIwtdH7j6sH1PpohHyknn6qNE+A7oeYXpB0DyPXNFAgpiyrQRMHYfI6Nq9aQ29CO1rLgDrPFnGmDR1BPR9tYuOMabJCqEbbuqp4fUqKA21MuEduM95gAxXbsIDMeY8Kh2tYNz8cg+9pi8BoornP/i84HgtikL4dbxz+g6Dhi1eOlakd5oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36756003)(31696002)(86362001)(2906002)(31686004)(6666004)(53546011)(2616005)(478600001)(6506007)(6512007)(6486002)(26005)(83380400001)(66476007)(66946007)(66556008)(8936002)(4326008)(54906003)(8676002)(186003)(41300700001)(5660300002)(316002)(38100700002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdRZDIzQlo5VFFLOGNVMW9IbWtDWFVieDk4ZWhZanJ6aWxJSmdlYXlRK2Q0?=
 =?utf-8?B?NExUTUVKT0ZRUE5NRmNlL3hvUEZoN3JpMlAvbnRoUS9QSUVvc05ENzl5cW1s?=
 =?utf-8?B?NUlYZVdOb2NRQ21GTmg5WVZieUJHZUZaYmp4QWRjaUd5Q3VuRkwrVlVlK1dS?=
 =?utf-8?B?VnNSSXJHdDdFbC8zSjVidUVUUUw5RFI5Y0NqdmxCQkI1M0FrVW1QTVZTRzVO?=
 =?utf-8?B?Nkc1WDN1QWVOd1N2TkN0ZTM4N3R0c1hGNzdRNlgxZi8vdlNZamtSVzRVQXIx?=
 =?utf-8?B?SGUxSjhYM2lsbU54OFBpRDZSd2hGTlY3ZWlMcFRGd1FvNHUvMXo0M3pZenBj?=
 =?utf-8?B?RnFwMHpsK0hQYjJRd1ZWZ1pzSk9Ga1MvTThBcHZzKzhWbEQ0Tmt0TGJxcHk1?=
 =?utf-8?B?RXNvOWlWYXNDSVgxeXpwVjlDOUJFZXBJT3Zobk9aK0paNXVNRllVeXJPN1lU?=
 =?utf-8?B?dUtFMkYvSXh6TEc1bjhDT1JUdis4UmdvU01wK04xa2p4RENkM3B2UUh4eGhM?=
 =?utf-8?B?ZzlUQ3FpM0tyT1hhRGc2MTRJamo4ck9qRFFBRmFRV0JTMHlCRG96V2pHSUpH?=
 =?utf-8?B?UitTR3ZDV2w5Q24yeHladktrVTJaM1M4TWpqZ2pPbWpxNC9QVXNZS2ZmUktz?=
 =?utf-8?B?N3pDcUN6UCt5NHhLV2V3T3ZJdXdtYTAzZDF4ZUFRZ1pWV1kzam16dUdLYlpj?=
 =?utf-8?B?Q0N5dkhsUUp3aG11aWxMc3RUWjNkbEZQZFpCYnNuclloV3Y2ZTFZYU1mZ3F1?=
 =?utf-8?B?a2xHYkpROGRXUFlqczVZR1FNZ1l2SkdHMEJaUkNnWkdrRlpKT1hPMmNpNzQ5?=
 =?utf-8?B?N3JqbjZGSUcyekRadTQwYUk0aUNubzV1RlRpRmRJYWdkbmsxdWxnSXNpcDBS?=
 =?utf-8?B?dW1nZGd1Ym80UW9waFFiZk5Nd2ZTZHdqdmkxRU4xb3MzR0o0cmNQVGlSSjI3?=
 =?utf-8?B?K1FtbjdhLzhtNDk2RlJBU1Z4MkRNTFNpMWY1Q3JERjhad1hCMlV6eHoyL3Zm?=
 =?utf-8?B?OTlGNjQ1QTVIdXcxZlEwdHVEbEx3UWhmRmsyVWYxbkN2KzhWK3dEajB2N3ll?=
 =?utf-8?B?cmxvcWxzNWwxVnhLd3BrQlEvZUlTcWV5QnUwMzN2N2I5NDJwVHRlZjJjeWhB?=
 =?utf-8?B?eTB5RVVoMHlBcmFRc05xSUV3bTVmTEZlZGNMRjJSOFhQUHp1cHVpUjN2SGQ1?=
 =?utf-8?B?UXFMVDR5WDJkWWhUb3lManFIMzJyQ20zYWNpekR2UncxVzZFaEl1V3lBdU9S?=
 =?utf-8?B?KytybnpCaEJSaHNzN3pYOEl4YklrcXRzZ2VmWHEvaXhUT1pYNnp0RDRwQTNE?=
 =?utf-8?B?WXo1NWprZEtVRUdRdmNLZzBxVDRNdmFzQWNpV2dNOU5UQ3JzRGdtM25tM0JI?=
 =?utf-8?B?TVVIZkxWVCtyZ1hFbXFKbWJkRk4zTjNsV2hTZDZoWlMzWTVXTzY0eXcwVjhm?=
 =?utf-8?B?QWtYcW80MkIyQ0FkL2JkYjFrTlZtVU91NjJycEZVbWFTVE1XRG1Fa0VOSVk2?=
 =?utf-8?B?RG9EWGgzR2lYQlY2d0FwOHlwK2JLY2xVM3N2eUxpZWZDenlMUG1qaFRqVC8y?=
 =?utf-8?B?Z01qNlRPS3pSb2RCRDkrbmxKNnZLbEFhTk0vWm1rREZNN3RYRmFBZVcxenlD?=
 =?utf-8?B?RDBrYnkzRVJVWlBIeE1uSG1YSTgvOHhKOGc4eXBJV0JrR2VHTEM4SXZZcHlD?=
 =?utf-8?B?VkpWVHdrTWtEV1RnanBpdThHSzJXMDNsVi9FUTJpaEJ3ajB4N2s2TmQ4SlA2?=
 =?utf-8?B?TUFCRldML1ltd0lYbitaYUV3L3lvRlhLK25zcFNUSnN4ZmZ4VzJqN3dXQlZC?=
 =?utf-8?B?ZVVtSXFVejdaTE55MnFRWExsNGQ1WHlPWmZRZTFhVG5WWkJydEN0bVgzUldI?=
 =?utf-8?B?b0VLb0VnTVhVNkIwVWJEc3lNNmhxa21lSE1aQUU1UHQ3bWl0cTlNMXprUkxa?=
 =?utf-8?B?R2loVENvTEI1Y2NiaGRGMVdpNlF3TmFjOGw5Ymp3VHNIM0xleCtqVmwzMjNK?=
 =?utf-8?B?b2xXbU80T01Jd3FyK2RkMkxrb2VYbXpsWUFwWmxGcFd1WEZIdmVDZEIwUUNQ?=
 =?utf-8?B?VTd6WEdUekVlc1M3dmhVa0RicGlzSzkvbUhPanZhNCtlTWtTeVJHdm5XbEpo?=
 =?utf-8?Q?+LwxGoBOYfCeDv0wL37YyyN+J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a51919-e180-4e1c-cd99-08db312a8685
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:24:51.9936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr/2xUd7QZqdv4ER0n0IHSOMC8nUIFRXkF972soO+4OSn+ZpsIFMJkt0KcoUBO7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 11:47, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> This patch:
> - creates a doorbell page for graphics driver usages.
> - removes the adev->doorbell.ptr variable, replaces it with
>   kernel-doorbell-bo's cpu address.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>  3 files changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 6581b78fe438..10a9bb10e974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>  	/* doorbell mmio */
>  	resource_size_t		base;
>  	resource_size_t		size;
> -	u32 __iomem		*ptr;
> +	u32	__iomem		*ptr;
>  
>  	/* Number of doorbells reserved for amdgpu kernel driver */
>  	u32 num_kernel_doorbells;
> +
> +	/* For kernel doorbell pages */
> +	struct amdgpu_doorbell_obj kernel_doorbells;
>  };

Here's an example where it could be confusing what the difference is
between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
As the comment to the struct doorbell_obj declarations says
in patch 7,

> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> +struct amdgpu_doorbell_obj {

Perhaps we should call it "struct amdgpu_doorbell_bo", since
it does contain amdgpu_bo's, which are doorbell's bos.

Regards,
Luben

>  
>  /* Reserved doorbells for amdgpu (including multimedia).
> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>  int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>  				struct amdgpu_doorbell_obj *db_obj);
>  
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver
> + *
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
> +
>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 8be15b82b545..b46fe8b1378d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Creates doorbells for graphics driver
> + *
> + * returns 0 on success, error otherwise.
> + */
> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
> +{
> +	int r;
> +	struct amdgpu_doorbell_obj *kernel_doorbells = &adev->doorbell.kernel_doorbells;
> +
> +	kernel_doorbells->doorbell_bitmap = bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
> +							  GFP_KERNEL);
> +	if (!kernel_doorbells->doorbell_bitmap) {
> +		DRM_ERROR("Failed to create kernel doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
> +
> +	kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * sizeof(u32);
> +	r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
> +	if (r) {
> +		bitmap_free(kernel_doorbells->doorbell_bitmap);
> +		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * GPU doorbell aperture helpers function.
>   */
> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  		adev->doorbell.base = 0;
>  		adev->doorbell.size = 0;
>  		adev->doorbell.num_kernel_doorbells = 0;
> -		adev->doorbell.ptr = NULL;
>  		return 0;
>  	}
>  
> @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>  	if (adev->asic_type >= CHIP_VEGA10)
>  		adev->doorbell.num_kernel_doorbells += 0x400;
>  
> -	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_kernel_doorbells *
> -				     sizeof(u32));
> -	if (adev->doorbell.ptr == NULL)
> -		return -ENOMEM;
> -
> +	adev->doorbell.ptr = ioremap(adev->doorbell.base, adev->doorbell.size);
>  	return 0;
>  }
>  
> @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   */
>  void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>  {
> -	iounmap(adev->doorbell.ptr);
> -	adev->doorbell.ptr = NULL;
> +	bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
> +	amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 203d77a20507..75c6852845c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Create a boorbell page for kernel usages */
> +	r = amdgpu_doorbell_create_kernel_doorbells(adev);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize kernel doorbells. \n");
> +		return r;
> +	}
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {

