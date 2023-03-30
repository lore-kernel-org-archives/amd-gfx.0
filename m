Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6EC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E9510E133;
	Thu, 30 Mar 2023 11:05:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C9510E133
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfEzB5QqOeCH0big8fPdCEaNMh/aqfWOd2sgXzsoNS7VP1bOrudC/YATl/FeMe4reb1bYPQIKnN2D1zDYBado1Dkh4fyvt/IBNpzSfOpb/qjMxdzFi5qbF3ycMMumYQeQtrdkhjZnSod40tXQ6FlmLHlM+1OEprIIBk4zOKYqYvtY6svXz4FV68IndS6mOBBIqXz4K17purp/LtZDYZaIvhIl7Wjzg0X8GIf6VNHD7dLKAKfLSfx7+QH7n1zxbkhPVNfS0HDFWImHsRk7sojq7y09bYBPEesNZSZO1Po6jziOH5egBbqSTwIsBVu6BT5K2A2zTdT1D55d9D6G99r/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCMHtIZ5EtEqp8iTvC0V9fFYwnwe+7y6nkEgzJR6DbE=;
 b=f2MZGrq5vgICkY17P5RAUiLQwerhTW0RGDE1QyTCYca3sLE3aDfoBR1ykitCx7ZY3GtHxhCzNVhMpK27w9Tod3qx4Tsm94RRDzZwLSj8k5Fw3UMQgUKJvePSBO0KAsMpzCs0YdSjUYLHy8jQCmAD6Su4zCKim43cOKLUeCNsAnm7i/wQJ7i/V6ERX2tokeGs/8h0hnDa4hm+phjDCFjhdQoVRLJ7p7SVoRWLX0ranjxjcv+sKZWjEeosY9jiiwciJCUs/z3I4x1Mdsd2HPMUwMYbMw3UTvGGijsKNRI0ht1/RMUFPqFMWyNDORMKCvt+29JHKu/khy9ADROPZnWEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCMHtIZ5EtEqp8iTvC0V9fFYwnwe+7y6nkEgzJR6DbE=;
 b=oJc4pEF+YO1eQcdaUnJpRHRrbwX+tMRQKM6vdimyk9vRmZB52916aE6/X7usJvi7pjCv5+1AU71q2vifuVVy5ofylazaZTiM11nnLizS88crQQ81JPyeS1Fgd/yXPNwD18JbhJAaH8jTKolUBBbd5dA9nweFL7JOd7+VENUpk3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 11:05:55 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:05:55 +0000
Message-ID: <fb8ca9ac-c9a9-21ed-50d9-3ca0ebea6e5f@amd.com>
Date: Thu, 30 Mar 2023 13:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/16] drm/amdgpu: include protection for doobell.h
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cac46de-2efb-43d2-a5ed-08db310ebbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4rCc7fehyQ7IKCd24fXGnIo4pEGGytxKQFas9esUU3eSlmk1F6LJnSBmI4RjF2bDH4qblnftHt4YCfOX7qB6RT4MjmOjXT6k+EO/LnYymslbtgoqa9dXkJGcWJZ3/Cz0K6zVEK+/By9SasqWeFRnTIUzMSU7q+CS6ldTNOaDWLVMarK+7YsH5jfTEvTtd8uqpvo1DFNILLsVgBrv2CF6VROgAZT0r4kF55Wy7F2CNpOyPqgtRsXum+QxAsrpYgYawNxXY3eUggdCGa9SSdhsrzXzpASIe5l8eNrmZe7kys7eJWZ0fCIkjQGW+/60O3SaiVx0vsnfCKOPGSadi3ojscumhTJQNKk2sGPsJh2V7f0d9sSrNcoC8gKZH8agbT383sZMcd/K1MUcBxuEWQuyKhBIltSxnE0UZEOxGpxQ11+pWFlDuXg+pfaoWzfD5+dj6jntRNpAT1TwJtxsmGriUZ4s8hY/ysg2WwhNZqhvBeVtTAW7QSijAFC06oxXqOk2quNGWNPvpoZ/IMVRhLc8W5BvnwDn8ujfG5tiEZIaEbiG++1MXabjSzxKnSF5Q/H201C7Lh51Z3tD4vkQ389jgRrHdFp72nLv6mRUkA95UJlPhNkUCqDwPxQwYNBuR0p6QRQgaaqVawXueCY3P4MvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(66476007)(8936002)(66946007)(66556008)(8676002)(41300700001)(4326008)(2906002)(38100700002)(5660300002)(6506007)(6512007)(26005)(6666004)(6486002)(2616005)(36756003)(31686004)(186003)(316002)(31696002)(86362001)(54906003)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZEODFCbEhyNm1EZnI2V2pmM0Vva1h5V05HcHZmT1F3bE5TMzlQNWJYZE0x?=
 =?utf-8?B?Snl0SVA3ZDgxLzdNM2JkWDdtVzcxYlpxb0t2M20ycWxJN3VxYjJJZlROSTI3?=
 =?utf-8?B?SmNQcnRrdmMyTk9Lb3BtbkE2VXZOS0hMb2NMNG5GRGpzcnp3bmlPNXRRNzFh?=
 =?utf-8?B?SWJGLzJPWWxXRjQ3Vk5MNGQ0YUVGWDR0SHFXMnczY3FQaUpHQWJPcVZIQUdX?=
 =?utf-8?B?KytHK3JIWDRyeFdDbmpBMHdEWW80ZlF0bjBxSE43aEsyU0FockkzbGVGSnk3?=
 =?utf-8?B?Ky9Zc3dXdDd0eFU0bGtPUzJlWDR1Z2NWMjBqdUQzRndhdEJTalNvY1VEblNp?=
 =?utf-8?B?YU92dkRtT1FNL1hzRzE0OXBMUTkrNmd6bUthdllUK2llUTc5czB4ZGYxOHh1?=
 =?utf-8?B?VDlNcXJSTC9rRkljV1drMVJUeE5ERFlKNmh5OHo4ZWlTcXlWa2srZVF4emJX?=
 =?utf-8?B?dmhFUlRtZUU1d1RRbUdxbGNONkl4eUpnV3d5TjVnblFjTklqVkY0TVhvSkl3?=
 =?utf-8?B?TWh0b3VyZ1FaS2J0c2lXN0p0dUxPTUFCeDJxSGVHK3Y5ZlpNYWlNdUs4KzMx?=
 =?utf-8?B?WEF0dEVpSmpRRk5OYTV2REtORzYvbDlCcGJWdVUwLzZ3YTZqLzdjSmFaTXk1?=
 =?utf-8?B?djZ4aldBMEYzTnZRVWlIa0RGN0ZkRVAvaEM5WVg4VnRVZEJJNkozMFJLZjNW?=
 =?utf-8?B?NVhUMTNFeGxMTkVta0VsVEUrZzlSZTFES2ExSEN6NjlEYkJZcy9PYU9tNnd0?=
 =?utf-8?B?RWdma1FKR1Y3eHRQb0JUbUZCS3M5ci9sdm4rWHN0MWdaWkZnZUxtbHJqTW96?=
 =?utf-8?B?WXF4UFhhR0MwMzd6MHUxZHdnR0JOMHBoOVBTNlNZRUVJREdoTWxTbCtmTk03?=
 =?utf-8?B?RTF1bGVRd0JTYnEra09FeUVla2d6RE11UmZjaC9VSCs2WDgrODAyUDVHYWkw?=
 =?utf-8?B?K093V2s0VmdPZ3JraVh1Z3RRbmJmME0zSkxSSVlleGZUSzVJVmZyMDd6bGQ3?=
 =?utf-8?B?enMwT3U3UkNieEhmNlhYUE1sMUVXVDlhSjZXSWxTTmNOTHRCN0t5aXJZUEZY?=
 =?utf-8?B?dEJ2cm15SEs5aVJWbTZvbWlLd2ZkL0VKdzMrOXNDSG1tOEVaRUtKbldVNEpn?=
 =?utf-8?B?bGFIL2o5RHZOTHdVZDI2REN1TmtvLzFoM3BDeHVtaENUdkJQMmFRUUxEbnBV?=
 =?utf-8?B?THJ2bWp0b3B1cndUeUxpYmkvWkpHR01hU0xKMWR3c1NaR1hnWjRKQnF0UUpT?=
 =?utf-8?B?a2F5bTJXazdkZmY1UVpKWlJjdVV5VE51Wmx2Q0ZuQytCZCtHNWNYOHJuWFRh?=
 =?utf-8?B?eFpaT3BQZzFjaE5XZHhJenNIeis0NzJ1U0hGUjVkcEw5cVJldVFRZHBMSkNL?=
 =?utf-8?B?YVRxUllOYnlwL21DSkhEWVBQRTkvd1hGNVQwTlJ3WUlsZVBZV1FET0d5VWox?=
 =?utf-8?B?cWl5THVjSG9MZzBtakRwU0NkTWRMNnVPTTkxZTVHdTFhSW00WUQxMW1ObUto?=
 =?utf-8?B?VzhOSnBkOElEQk5GdjdXNlAxVFRYTXNnbFlIOEpqQWVxdzBZR3dxUWx2djF1?=
 =?utf-8?B?Nmkyd2ZBMDhtTXVDRTJRSHRpVitKZnBzL3dFZU5Cd0toU1pRVmtLUmRvZnZy?=
 =?utf-8?B?N0x3ZjZuNzd1ME1XdCtiZ0w0cUlFQ0JxTitpRUpzb1A4elM1MFFGT2VJWVU3?=
 =?utf-8?B?MG1XSUpUM0FiVXN6SXZhbjhoN21iYS9ySGJDOXBDcG9OSitnSkc4d0dGS3FH?=
 =?utf-8?B?Y04vcDAzVktJWWoyVmJwWXg4N3VhbkE0emVJbWtuc095cEVGZHN6R20xWkdv?=
 =?utf-8?B?QW9wWGdaMVB6eG03d2owNTVNdHA2Njh4SjdmSVZlSE5DQjh4SSs5TzE4OGNo?=
 =?utf-8?B?a2hRdkE5YmZSN1owWWVNd00wYzNDWmx2NTZSSldMZXBHTENQb21hK2ZLU1pK?=
 =?utf-8?B?dEtmNERXNDhhUEtRK2VkVklsNjVTTVpMK2RFRzZBTXdma2NHeHdZaTZ6dWlD?=
 =?utf-8?B?bHVYaytqWEFQWHFyRElGL0FUVi9HYlJPTnp6Y1pRTjhRRHk5VVNINnJ4eHFr?=
 =?utf-8?B?UzcvazBWMTltNm0wQkZ0bXBXK2RNenhaaVBHc1lGRHhUUUIwVFI4cWo3cHgr?=
 =?utf-8?Q?7FWs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cac46de-2efb-43d2-a5ed-08db310ebbc1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:05:55.4450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6rMF3p0+iO72tSMB7HpIe7ocPQ6n+XwXBkjpmEXFvIIyizqa7BooK7yAG5hRLU4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds double include protection for doorbell.h
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I suggest to get this pushed to amd-staging-drm-next ASAP together with 
patch #1.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 12263986f889..6064943a1b53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -21,6 +21,9 @@
>    *
>    */
>   
> +#ifndef AMDGPU_DOORBELL_H
> +#define AMDGPU_DOORBELL_H
> +
>   /*
>    * GPU doorbell structures, functions & helpers
>    */
> @@ -308,3 +311,4 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>   #define WDOORBELL64(index, v) amdgpu_mm_wdoorbell64(adev, (index), (v))
>   
> +#endif
> \ No newline at end of file

