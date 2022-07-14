Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486ADC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 13:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14E1112367;
	Thu, 14 Jul 2022 13:26:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A2211221E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKxBqWmA4ZJ6l8ewa/KHRWaHK+Np6qu2Q6jcD/biNbGmHH/ha/srGwKXf4BHo+TcAH5RzWUF+Mz33dSAVNbV9MQ2BiZh80T+nAGcCaHWOFl133yLdrN9jU8vPQmjHLvNxMnvB3gFOWMVH0AWzn2eCg1aZRFIXg/s/DNq9Z8+2GF31CmEawKxfxxjj1wxv8ayfy1y6Iv4bYbLTNfbHL+9DOP1FtSLuzeyNTI9UDq+C/7OAGLHWy/mi+JbjqdeVr5z0baRwUFgTnHguyJX7WY5aSEYCFkQ0i8A0l02NuSHuH18KS0UfGkpnsidTFKfqklVrdotoEAKomKn8JPULQFrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0lBcrRUMYqTCAoW9taJywwxqDhQMy5Lk8a3IOLeq1o=;
 b=a775UHqaOSZvQBEZhD1K18G42B2MueVV+3WWsk1zSwRLS31Un6U29uLSnZq5vnJpqNDCnIwcyiNC82UV68x9LiWxwfM7fHuwgHVXzd42ihSAdaSjfapHbAxmVF4CT6jfrJyovnpGY3RiVZBPqyEY5VM7XbW41gkVwm+Hag3xrWcdmpEs0KlcxrebkkR3h4h5FHcFWXSj9y1xNnZCJVlLA4sOsf69YHN0cu+q+QeMQH3tpsCwHjSOde3WyIXEuoCfqqWTXh1tJv3uRjU26RlCPCDP19KlE7pdw6CEBJW/p3LXOiyb/p9EinSOWmaMLEATcHbWRYg8MLgU1boCzmECRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0lBcrRUMYqTCAoW9taJywwxqDhQMy5Lk8a3IOLeq1o=;
 b=mEpQx481c5EBS/V17P/W3KukwX/npwF/M9Ft2nv2/CLdEzzB1B5R/vE548qPMqz6HfGkWFXNsQl9nwUBcXO9mTBTk+dFu5MhO0ElFQKlojl54lK5sDvWA81zXvr1sPQGvHXJ++Tr/YFowwBNb3U4sciZwIGF6L/WDKPvAnx7slI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 13:26:48 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::a1d8:6a71:213b:6e14]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::a1d8:6a71:213b:6e14%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:26:48 +0000
Content-Type: multipart/alternative;
 boundary="------------qZ6Zs2Z01ThgQS3OnaqBl2hE"
Message-ID: <2b258d7e-37c3-8fab-4b21-604419655777@amd.com>
Date: Thu, 14 Jul 2022 18:56:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] drm/amdgpu: re-apply "move internal vram_mgr function
 into the C file""
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220714132315.587217-1-christian.koenig@amd.com>
 <20220714132315.587217-2-christian.koenig@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20220714132315.587217-2-christian.koenig@amd.com>
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3eaa273-f4d9-41b3-ab93-08da659c812b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tnr92zGrT7M5zbXVvJ/w3b5qSQEBTcOBWJDsLInvAUn9cnB2jIsxs0c3OWQt6Zd54S2YbD+e8d6pnGu6J3MOLYpPrDntALaLrVVBJjwip3jkOWGaU4JH90hKj7fyFRhDS8Nlznhfy119h05XcJyQ0xkmIxD8jbB8D8dr/eya6gxDsC939rzdeXTQOs5JdhC4RKgWHUeYDtv+0vKIn/nuVhWmp+TWRQCWDasfb10wOAHr/XmG+GTi8YjbYH66cA1fA+3oobpzc3LRmOYbNASul2TWME/ktzsxo6l0A7GpTbfKmvfOQCf2q5PX2oxkS9OGAGxc333oz9vXyuaMAB/71RNcy2sYRd4b5Nisa85+h5uFeZnjxb8y0hGGQXcu/7K9qEwBxdu9L8l3yB6JXGfgnTVXSrWZBj3ZPVsPu/Le4rD8/zipA1aG54Y2d5IhvYzA75Vi1jEMxHbNhIjB97ltOwammnwaq5wXODWdBbnMvsbtzjwxayUIW9osWqvGHypt0FUFOCwE4VX7DIAda3f3ldUa8rrcuMIYLDyAVYnRjrZxorJJcCU2zd/uegtzINS58BYPTR1sSidJjbSHuWJ8jxeFcovqvbtH0Kh3ANxGqmcQf3qQGtVZ6vbxgUpDP8A/5Ydp6wQxssaCJjtxeLpf4Jm+9VSKxekSRCtO/tKXmVrRVPTE3djqifXKID3DxFlq/YbINBOhwDjJTxb6nwDMHV/APq3g+YcBbt70B+s8k4J6LQKe2YtPppewcFW6hoESr/wQt1wucLg+WnmbZS0xCZeAWccb4jorKj8adrRL8yhqMc2dx+/33uazASh9p4dazG1SRZ6G+gM5jHoOqt/HRq5/QTaidVL077s2VZajczg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(38100700002)(66556008)(6506007)(36756003)(2906002)(41300700001)(186003)(66476007)(31696002)(6486002)(33964004)(6666004)(316002)(8676002)(478600001)(53546011)(66946007)(26005)(4326008)(86362001)(6512007)(8936002)(66574015)(83380400001)(5660300002)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRXTXU2Zll4VGp3aytJdDd4NEY2UUNUd1dkdDUwcXMvZHNnL3BKVWdGTzJ6?=
 =?utf-8?B?cGRiWXZ6TmdnalVGL2VLblpWdEFRekhicm9sOHgzaVp3Sml1bllSdTNJckVE?=
 =?utf-8?B?OVl0VEg5L1RQWHVsZm1SOTFHaExYTE51em5VenRrL0EzbGVSOUYxM21VajJa?=
 =?utf-8?B?dkNjQW13ZDh3ZU5UZmlQWVU4MzJONlBZeDhRNFM3djh2Tm9lWElXOGFxaVZ6?=
 =?utf-8?B?K1BTS3V2UXljcVJIUGd4ZkNvcVQwU3lheE1Ga2dKWURLenNzMTE4bWZHdmFL?=
 =?utf-8?B?Q2dYb09YM0pLSi9PekRGMi9ncnlIK2pkalB1T2VWNkVzVTRBU3lUU2JiS0t5?=
 =?utf-8?B?UVNrWTM3OWZzWFRneFFSUWxxRm5RY2VOWVFLSU9zWlBlam5aZTVFdHEvczlq?=
 =?utf-8?B?eTh2VDJvUCsxOUQyRTBQV3U2RVlPU3RpZVBLaHB5b0dxMDlsYnd3T1lnZytz?=
 =?utf-8?B?QWUwRnh6Q3RWa0ZGMXc1WGp5S1QrRjBaTFp3b1pnbWViMEJGZ3hIcDlOTy9B?=
 =?utf-8?B?elVramFJaDNKNXJWMzhxclA2Tlg2YmY0dnd5SjltMXYyOGp5UVkzb0ptelVs?=
 =?utf-8?B?YWQ1dUk2OXFva3AyV1BtYU1CWi93em1MUWpiUVZwM1Bud1l0eFVWVGs3RjZT?=
 =?utf-8?B?K1lULzdvV0w2UWkrRkgrUnozaW00d2dqQ3IwTlFFaTgraXhwS0ZaajBFcFNB?=
 =?utf-8?B?TW4wY0tzdkNUUGhrTlhqT0dSUjNGOVRiOTZmdmNZTmlOcHVoRmJBSHBVZVpa?=
 =?utf-8?B?Z0FWcGZpc090Qkxmai9ZUFA4cW5waFVObXpqSFlRNWNHUnh3NnNzVVZIU2cx?=
 =?utf-8?B?djBKR2ZZV2xyVEI5NXc3MWtMOCs0QnhvQllwcW0wczZPZkJUaXZwZWluUHFE?=
 =?utf-8?B?VENUSklCSGZZWVgxeTFRTTRGQnY0aHhNUFNjd2dNaGczbXJVcG0zSWJZekZW?=
 =?utf-8?B?Z2V3R1hhSDNSdThySEVIRU12cENGbHYwcDFhQTdoMU1YR2dtNjZ3cFcrZ3l4?=
 =?utf-8?B?MHpjNjhzWFBsRG51ZDlBL211Q3EyNnoyZVpiS1k3V3F2eDc1MG5VY0V0bnlh?=
 =?utf-8?B?Y0J4b0NrWURHVng2ZjFOYlFvakNYR0g5NzFRY2dNVFBTanZFdG05KzNWbjFn?=
 =?utf-8?B?SDJTN3krdVlvbVgyUmdpS3NZQXFRV3ZuNkk2QXViZDdOai81cGdQTWRxTW5W?=
 =?utf-8?B?d1lrak91QjNJWFV2N0g1NUFoeUVpaVY3MmgzVkc4T3VsKzlKMlhVbGs5dEEx?=
 =?utf-8?B?YXN0ZmE4OEFLbXZiWml3VDlOVTEwSDVKNmZKOEZPakExUkVrTXU2L0tYaktj?=
 =?utf-8?B?bDVxbFhrd1M0QXpGeVp5cjhKSWFnSHVDOXREVlh4SHdTY0U4elNYZnA2TkN0?=
 =?utf-8?B?RW9XU29hSlFOYUJCcGFld01WTGRnNEMvNmFsdnFvSFhFVnF3UDhhZU5JQ0tN?=
 =?utf-8?B?Si9SbmFndGRwdHc3Yys0enRnVC83T1ZJbWR1MVV0aVZJTTludzUrLzErejBE?=
 =?utf-8?B?eHRMcUQxMnRyUGs4ZStVbS81MzFHSVhiclU4dTc1b2RWbmR5VllxRE5Leldq?=
 =?utf-8?B?ak9sZXlnS3J6TWl0MDQ4bFRhSjNmVmZtSEwwaU9kWVF4NXcrdkRjNzdTeS9U?=
 =?utf-8?B?L3kyR1E0QUtEZlo0UGw1bDlNbmZhZ2tuMWhpZHg1bEd3ckw1d1g0cTVVOHVY?=
 =?utf-8?B?cGRiOW0yMlBzcGpmaHZ1eG01ZzR1THpIdWoxbnVUV0JQcGJPL1VCaDdTMkU3?=
 =?utf-8?B?QnB5MlQyU2hoTGJCMFczakVmQUtvK2RLY2NMMjNiR3J1SzZjc0pmbHgxc0Qy?=
 =?utf-8?B?VlJDREFhcFJWTWZrVzRrS25GUUNmTHhoLzZzVGlwMXVnWTNHSDVRV3kvN1cv?=
 =?utf-8?B?T3V2cFRkVU9RaFhyY1l4aGgvZCtzYVNYK1BnblgyRVpveFEycG9BdGwxVjRx?=
 =?utf-8?B?cW81TFdpZkxkUFUvdFI3REc4TUtjSFRYREhFYnlTbmpJcHAyeU92Rm1qN1JF?=
 =?utf-8?B?cmJWazBDNE1BdTM1SVRWUVFFRnlycHpKSVc0dU54TkR6SmVNdVpCZm1CZmNa?=
 =?utf-8?B?Z3JGNzVzd1NrdTdZek8vZGhQcGg0R0Q4b2hMMUs5dExIRWdUZTVnMWFyQTZh?=
 =?utf-8?Q?Zi7aBQLCtTBf78ejMPuScKuuI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eaa273-f4d9-41b3-ab93-08da659c812b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 13:26:48.5285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXLKQtyVSqc3efhgdFeXfa+mLzIrB04zOJirxah4eKsN9wEccKnXLap8F4WDIT80jfnRHxibgjAenSJ/xSN6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------qZ6Zs2Z01ThgQS3OnaqBl2hE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

I verified the patch.

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Thanks,
Arun

On 7/14/2022 6:53 PM, Christian König wrote:
> This re-applys commit 708d19d9f362766147cab79eccae60912c6d3068.
>
> The original problem this was reverted for was found and the correct fix
> will be merged to drm-misc-next-fixes.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
>   2 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 51d9d3a4456c..7a5e8a7b4a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
>   	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
>   }
>   
> +static inline struct drm_buddy_block *
> +amdgpu_vram_mgr_first_block(struct list_head *list)
> +{
> +	return list_first_entry_or_null(list, struct drm_buddy_block, link);
> +}
> +
> +static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
> +{
> +	struct drm_buddy_block *block;
> +	u64 start, size;
> +
> +	block = amdgpu_vram_mgr_first_block(head);
> +	if (!block)
> +		return false;
> +
> +	while (head != block->link.next) {
> +		start = amdgpu_vram_mgr_block_start(block);
> +		size = amdgpu_vram_mgr_block_size(block);
> +
> +		block = list_entry(block->link.next, struct drm_buddy_block, link);
> +		if (start + size != amdgpu_vram_mgr_block_start(block))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +
> +
>   /**
>    * DOC: mem_info_vram_total
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index 9a2db87186c7..4b267bf1c5db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
>   	return PAGE_SIZE << drm_buddy_block_order(block);
>   }
>   
> -static inline struct drm_buddy_block *
> -amdgpu_vram_mgr_first_block(struct list_head *list)
> -{
> -	return list_first_entry_or_null(list, struct drm_buddy_block, link);
> -}
> -
> -static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
> -{
> -	struct drm_buddy_block *block;
> -	u64 start, size;
> -
> -	block = amdgpu_vram_mgr_first_block(head);
> -	if (!block)
> -		return false;
> -
> -	while (head != block->link.next) {
> -		start = amdgpu_vram_mgr_block_start(block);
> -		size = amdgpu_vram_mgr_block_size(block);
> -
> -		block = list_entry(block->link.next, struct drm_buddy_block, link);
> -		if (start + size != amdgpu_vram_mgr_block_start(block))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
>   static inline struct amdgpu_vram_mgr_resource *
>   to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
>   {

--------------qZ6Zs2Z01ThgQS3OnaqBl2hE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Christian,<br>
    <br>
    I verified the patch.<br>
    <br>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;<br>
    <br>
    Thanks,<br>
    Arun<br>
    <br>
    <div class="moz-cite-prefix">On 7/14/2022 6:53 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220714132315.587217-2-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">This re-applys commit 708d19d9f362766147cab79eccae60912c6d3068.

The original problem this was reverted for was found and the correct fix
will be merged to drm-misc-next-fixes.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 29 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 27 ------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 51d9d3a4456c..7a5e8a7b4a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -50,6 +50,35 @@ to_amdgpu_device(struct amdgpu_vram_mgr *mgr)
 	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
 }
 
+static inline struct drm_buddy_block *
+amdgpu_vram_mgr_first_block(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct drm_buddy_block, link);
+}
+
+static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
+{
+	struct drm_buddy_block *block;
+	u64 start, size;
+
+	block = amdgpu_vram_mgr_first_block(head);
+	if (!block)
+		return false;
+
+	while (head != block-&gt;link.next) {
+		start = amdgpu_vram_mgr_block_start(block);
+		size = amdgpu_vram_mgr_block_size(block);
+
+		block = list_entry(block-&gt;link.next, struct drm_buddy_block, link);
+		if (start + size != amdgpu_vram_mgr_block_start(block))
+			return false;
+	}
+
+	return true;
+}
+
+
+
 /**
  * DOC: mem_info_vram_total
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index 9a2db87186c7..4b267bf1c5db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -53,33 +53,6 @@ static inline u64 amdgpu_vram_mgr_block_size(struct drm_buddy_block *block)
 	return PAGE_SIZE &lt;&lt; drm_buddy_block_order(block);
 }
 
-static inline struct drm_buddy_block *
-amdgpu_vram_mgr_first_block(struct list_head *list)
-{
-	return list_first_entry_or_null(list, struct drm_buddy_block, link);
-}
-
-static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
-{
-	struct drm_buddy_block *block;
-	u64 start, size;
-
-	block = amdgpu_vram_mgr_first_block(head);
-	if (!block)
-		return false;
-
-	while (head != block-&gt;link.next) {
-		start = amdgpu_vram_mgr_block_start(block);
-		size = amdgpu_vram_mgr_block_size(block);
-
-		block = list_entry(block-&gt;link.next, struct drm_buddy_block, link);
-		if (start + size != amdgpu_vram_mgr_block_start(block))
-			return false;
-	}
-
-	return true;
-}
-
 static inline struct amdgpu_vram_mgr_resource *
 to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
 {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------qZ6Zs2Z01ThgQS3OnaqBl2hE--
