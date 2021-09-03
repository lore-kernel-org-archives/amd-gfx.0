Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4535AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 06:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA926101A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 06:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEA926101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEA16E843;
	Fri,  3 Sep 2021 06:37:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C006E6E843
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 06:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy8Ac/kXrphblOgksEU9lCkNdkVNRuvLnnkLvjF27dFt/B8I+yXPWEfqmxoFxScXTc91iWhgKRczy2mpLhnGOqhVjW9RsTNuFH9NuxgnZafgNQ1ACXy+aYD+/7T/1d2tvXms/U36XZm7b1Y5Gu7l6SdLcujgWm002qVsPKcNnIFfKzxsbNQ96r1nahLZnYBsc+04ULYNou4GcG2vivdCcewiImC8INIBc9004HCsS9iytkKb6+Dac8yV1wYVDuq2ckdkV75fcwAT45Ncl4xx5PJV5LZXgnOAxD0r3FqirDgcQELSb/29laDzk/80GtmM53ZbQVkhuX5sPdiNjwHSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=7INyJFyBLJgds7CUpx7J1tXH8DVq8x7KfmG6N0W9pww=;
 b=JHL4lbHtkv2EU6tQgL/BIqVU/t1Ho4SomGa6ZC/9pRPiJYAe78yS5vDhSWZy4rha75QONgLc0IcAEszlGLqY5BLXkMleImF8hCP38MNU7yb2w87ln2/jD8Xdz8rNz8ETZRQfFUTcGnuY3fVtVvPFxodDe2d4xfH3HIXYH+Gc4xljZJ7znW2ub0CPqipKo8khuFWYtf99lBTx+9zMqGviNF+zvyt6kLNhfAGjlDdA1Gsapq/ikUzAEeVtDHGqeGr7HD1Qu7YfvVs44oZSvmJHVN4JTwGptkdQ0SoF1+FJaZTzKRW053ZdoPDqLqJ1NCGozur/ojEopV4NPv1c6g3v4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7INyJFyBLJgds7CUpx7J1tXH8DVq8x7KfmG6N0W9pww=;
 b=u0rf0w8yrKmkaFh+9nJHo81wGRceK0RvAfTTa/vq5JH7OH3XJsWXmR99hw39IhLMF6kKM7F1nkM8nBFy9oINIZorQq0V5qP4tvm5yZZYtQpdvSdsnbtP14Xdcz0UZK7jGiKyNd1uVj+NUPHwaptOyTVx9VrwDqrhjYc1q8pRJAM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 06:37:07 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 06:37:07 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
Date: Fri, 3 Sep 2021 12:06:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902114459.3866-2-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::34)
 To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 06:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c904f406-6bf8-453b-70ad-08d96ea53fbc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5037EE7DF08AB29171E85A8DF2CF9@DM4PR12MB5037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4z0zaY7WWEG6uwPywwE668Rc1ewPQhoFroPUm8wgWhgU5dNk/OwgAvTUeQTY6L6ItLJH4D4JT1g0RN1XdBFcRtVL9jJTvVZgHGvuDJdi8o9Ozun563xLWfuoCPkT8+O0wmIINTJi4ZqhqOoHyYah1QeHbFaJiLCktcfBuxKlVuFZ2B+TdWHbKGENxLMwXycqGRhVdUSV24W2QXAdNWP3Rk0XDbSoqFBTiKVIdMLSZfhLsddXAqzt+NxUd1sBAfwR04VQfkMQnj1EWbnC4R0jPYnZTbtZQMkTwxNwHYY7JxAg0b+ZXJp+pbN7/j1HtRQspcbi/rQkfOzOmkQD8TWnrpZymgmvqUndQI36GhWU582c4ZGxvhoKLSt//VkIFyNgheJb7/e5iDKYDHreljBq/5pBaXh2BNCjAkH7ZcZXuHZdwzWZJ/Wn+XVfhHxUo8iDpTe364jw54zTAuKFQnVpUhF9GCPOLajHdbnxgESvAE46r4HB6NWMdf695iEZDfwUvdEKE+BuOxfTcHjL21jN9I71uP+oXo70dVVATQzF8f7RZnLKNyOIB4CsLQi7vUJIl47BqbfLsxB8VcXLQ15/5j4beXJnx4V9Uz50DCuIlH0JlNbeTJp0amclcGZ1M63/sH1Mk8PSH5/b8OW5e2F6PPV0U1McMoV7XMyPGnBI2z490wZfXHXQ9k1g7KvcOC/QFot0bi6BNVeErHG+AvUYsnLle8qi2n86DNtmQ5smq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(38100700002)(8936002)(83380400001)(2616005)(5660300002)(66946007)(4326008)(36756003)(316002)(6486002)(16576012)(1006002)(8676002)(66556008)(66476007)(2906002)(26005)(6666004)(31686004)(478600001)(53546011)(55236004)(186003)(31696002)(956004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVFVVQ4aDFBT0ZCZk90Y0RBYkRoTXJsanljZ2hMRSs2V3FNd0tIVFJmejdO?=
 =?utf-8?B?YVZyVDVGcmljbWJuaWM5bWt4T09QWDNjNEtWMHJHUi9zbmcrUE41MldUdDdz?=
 =?utf-8?B?UWkxbzFCSGZhTEllYTBXK2txOUV2b3EwZUZRNE54OHRYalZjVDI1dllTcXBw?=
 =?utf-8?B?Tmh4R0IzNWFNM3dBOFVmb3FCdThhQmZ6enFramFlRmZNSmNLVDlIb2Zub3U4?=
 =?utf-8?B?TlVIcjR2OVp1MFAvbmZqUGxyUytvblo5K2RrQiswdWJwWk8ybHFaSGNOVk81?=
 =?utf-8?B?Z0lMMlpIWkc0UlQzSUk3Rkt0dVZ6M3RpWFFHOGpXckpRRzRkTzJuSXlEZkQy?=
 =?utf-8?B?c0xZREhGWVN6ek9La2NYTXZpT3VmVjN3WG1HRE1kMnZEWmVUQUMrVjhqTTdy?=
 =?utf-8?B?a0s4eGdsTU1GbC8wZTFaYlk3S3hYb1NsaEpoNjJ6eWxhYmFnZlgyemhGYW9H?=
 =?utf-8?B?ZHN4VG8reTdvczRtQlpEZzB0MWtQbVNuYzNKejJQRyszNE4wbU1IWTEvRU05?=
 =?utf-8?B?Y3BVQklkcEVzbmxsR3poYk5hRjhhK0RNbDUwTzZwQm1wczVSVlpuV1hqZXd5?=
 =?utf-8?B?WnQ0YkpxeUVINXBvQVRKVnFBTHZwMG12MnVxTkZ6MlVSTE9IdmZHdHY0Z0Vq?=
 =?utf-8?B?L0NwSk1MM3FkTWJtWGJFWHI5UHNQRm51Q3dPZkJxdkZuZy8xOUgxTkxnaFdT?=
 =?utf-8?B?SVdudVJydWNvdDRkYzFWWXVGekpkVFFPbWV6T1Y4TW01WlNQcXBMRUhqOXJ6?=
 =?utf-8?B?Qk9HN29OUjhTTnplbHVJa2I2YmdLL1lDcjVUR3dEdlB3WDNNdVU0VitxVytV?=
 =?utf-8?B?eStYUU9PcGlyTkIzaUlGbjE4a1NKeDdteit6NWFSdlNqcVZDa1FTa28xUWlZ?=
 =?utf-8?B?dzdtclQ4aUpLdlcyNUF5MmZqcTkxaFdYZGZvWlVVbVQ5LzNPMHlGdWFRSFYx?=
 =?utf-8?B?VC9VRktSZkxGOSs1dHJBdEpWV1dOSnZ0b3NUTVNxaW0wc09mUU9kdnZFTGIw?=
 =?utf-8?B?UVhNWEk4dTNsN3FUNnhyaHlYQkVycXdRV1VCNWFxaHZRNEFCZDRsaTJmdStS?=
 =?utf-8?B?MlVaMFZaSjJMSnd1WjlnUFVyZU52VmlzQU8yekFSZWcvY0dqT3ArYTViR0g2?=
 =?utf-8?B?c1lvQktDNlhUTUd2V0MvTWZjVHRzWVB2RE81c2dLc2xhV25kR3hvWU1sSUVF?=
 =?utf-8?B?YnIxWGk4VENqKzdkb2dISUplaExHN2cxb01hUUY5cjNwUFMyRFZzZG8xa1Vk?=
 =?utf-8?B?VFk1d1ozVmxuQW5JcmNqWVQxbGtLL2xKeTcrVWNhaTlVR2V0Rm9UZGtjZExI?=
 =?utf-8?B?dE8xUVVOQ1lWLzdnbnhuVkNFWGRGdFoyakloSjY3RHRLYURkM2lqYmludE1U?=
 =?utf-8?B?a013YXMwUVFJNWVwSkF1b0JpZ1hCWEN2Y2JsWXhvRVkydmcydG40U0xRZUJV?=
 =?utf-8?B?cXFvczk3dlQzRnpzRm0wOStpYVFReDl3RzJPaUJDWlE2a0Joc05FMG5zbzA3?=
 =?utf-8?B?MTV1d0NwTWRVemkxbXVpOTZpZDZGMXpVUVhDWDlYV2ZWVFFpZnRwcUJ3Q3Js?=
 =?utf-8?B?WmxHa09OWnFUYitxZzkzU3FJSnVlNUl0SngvRmo5YjhOUEVNcGVkTWZaZm9j?=
 =?utf-8?B?SysvZk5EK3RCRldrR3FTUmRXOGZaQ0Q5L2EvQlV3Vm9jVlJQeDFtVzZac3hh?=
 =?utf-8?B?OUFwWmJtZVJ2cTZ0dGtpVDhOZWxLR2ZrNVFkUVdYcHNhUUVQbUE1N01Wb3pK?=
 =?utf-8?Q?5Ds3NivO95n9HOBJFur+Eq4yBOd1R0E6hCObiDQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c904f406-6bf8-453b-70ad-08d96ea53fbc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 06:37:06.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9dy4QdmMcTkDA2W2023414XEbpweGrxnlNgUmedZkLpATMNPZYj/yoRNyhjfwhXYATNf/TQEFwlm2VM0Kq4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
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



On 9/2/2021 5:14 PM, Nirmoy Das wrote:
> Use debugfs_create_file_size API for creating ring debugfs
> file, also cleanup surrounding code.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>   3 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 077f9baf74fe..dee56ab19a8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		if (!ring)
>   			continue;
>   
> -		if (amdgpu_debugfs_ring_init(adev, ring)) {
> -			DRM_ERROR("Failed to register debugfs file for rings !\n");
> -		}
> +		amdgpu_debugfs_ring_init(adev, ring);
>   	}
>   
>   	amdgpu_ras_debugfs_create_all(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index f40753e1a60d..968521d80514 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -415,26 +415,20 @@ static const struct file_operations amdgpu_debugfs_ring_fops = {
>   
>   #endif
>   
> -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring)
>   {
>   #if defined(CONFIG_DEBUG_FS)
>   	struct drm_minor *minor = adev_to_drm(adev)->primary;
> -	struct dentry *ent, *root = minor->debugfs_root;
> +	struct dentry *root = minor->debugfs_root;
>   	char name[32];
>   
>   	sprintf(name, "amdgpu_ring_%s", ring->name);
>   
> -	ent = debugfs_create_file(name,
> -				  S_IFREG | S_IRUGO, root,
> -				  ring, &amdgpu_debugfs_ring_fops);
> -	if (IS_ERR(ent))
> -		return -ENOMEM;

Why are we doing this ? Why to make it void from int ?

- Shashank


> -
> -	i_size_write(ent->d_inode, ring->ring_size + 12);
> -	ring->ent = ent;
> +	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
> +				 &amdgpu_debugfs_ring_fops,
> +				 ring->ring_size + 12);
>   #endif
> -	return 0;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 88d80eb3fea1..c29fbce0a5b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>   	bool			has_compute_vm_bug;
>   	bool			no_scheduler;
>   	int			hw_prio;
> -
> -#if defined(CONFIG_DEBUG_FS)
> -	struct dentry *ent;
> -#endif
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
> @@ -356,8 +352,6 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   
>   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>   
> -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring);
> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
> -
>   #endif
> 
