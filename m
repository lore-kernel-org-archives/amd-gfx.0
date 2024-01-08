Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E34C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 23:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E73410E0A9;
	Mon,  8 Jan 2024 23:17:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223A910E0A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 23:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW/HsMCIgwMz9X3ht4li2Fz8w8kzfkTAfMBzUzuvrIg5yEKe+RgpEyfHefN0b84aPhvXrS4jH/MIHd1HheGvsnPrzM8+Y3ih9p5nAFojewW+86Br8VdYSu1n0C9SfBl1kEvxMEskVIZrRwY77wmXj/cxhjiXMUHKW98wpJXDq69W118Rtgu7xL6rzj1X1BCb3QP7AcC64iaMKAIa2ZBhspjVqFHn3dVMNCf1jr5rZfgKf3eZdh+6QsXkIAXTpvETwEZF0Hi3W7Tf3F9oNJx77i7P3C09NoVtR2YTEW8/Ra2wgRP9g5eYy7YThMSODY65SJDIknzdCOKqojke8Z1Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCxvC7Li9VU5RD9eWN8OSfX4FKfHB7dlmep8ct6issg=;
 b=U2Bx7zAvgE3SmZGdo5sm1it9ARYPfxcdfbycgVNaOgwps1XwUvLeyXqWiWOEbIH0VEdzfTAgqS+dIjSNrS2sWyPynShIW5zUAMoKpfEgM1uGIG40Hlpy0LDN36GF+5WMo+Z0b2nuuoOFOcECt9yI8jJqXuNR5Vwru01Pn9zUY/saBgi3Lklw+0T1+WbUo5plWjvhFhTXUesk7cKbLJqYgoxKuqoeQOLSZ7loZT/Ht/LJdgIDSEwiFbPu6aNax5283lyESc8FdU0fvuV0oLCdLfsvgJsNZsSPDoRRDx947RoQwuEqDI7xG5pYv5ldARN+RrOyZVETFCKsc7X9H8c6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCxvC7Li9VU5RD9eWN8OSfX4FKfHB7dlmep8ct6issg=;
 b=dRZx/DUAZdeFELuQS8sSt0kgyQHiPGm9gKn0mfy9EWzv7kBOpM3vZ/ZRByp6Iq7/VIofFqoBDhRZ9DJvDqWufJcan4dGbsDaWdAQq6Fz0Cns+VQJtuUd1Sgl8Pdi3+6exMN37fGKTCWVmn1UFVuoTeq836bNIwa5SpbYTYjiygM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Mon, 8 Jan 2024 23:17:06 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8cf7:bb84:b64e:331%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:17:06 +0000
Message-ID: <ba63e6cf-8162-1d99-00d6-62e4165a6b04@amd.com>
Date: Mon, 8 Jan 2024 17:17:03 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240108223651.14997-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240108223651.14997-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:806:122::35) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: d968f620-57f8-4a00-74d1-08dc109fee42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfYO2rMgaMIcl8nDTR3lzSb0/QzYgTKzamLlQL/08EqyaC3BcBfxZRxSo/4R3Nlx8Bos+N4tEin8eLdvBV12AXxmW80CEbMx6sXgTCZDjicTpJ7vxpRFUMOXhScjzMbdWGlap6ZCevny97riJ/erxujBRviva27JofWun3nqwvQwxt7+idFzoWwuw/hK80q2KCIKmFlYLNdcir+E9xfv0nb9xwMnPx50Tmh8rqOied6c6Mz/fEqaf7i16zrCDkN7jkl2TNNd3d4f4zKgN8S/RMpOE895L7BbJjCf8hrFHSWApRMRzJHxj3aIn+C7Yg/l94Nptd0QLQfUPQY7saI0Tq62ZIe79WbQMgeQN/D+DHMYQrGTzRqfsEv6SD/Zrerj3EJGlYnv+4o/auD3tSz15+2mQhdmUQQ/546AWarqr9mvFFRM+0hNPT04/ezwxI+/pn5cdL9LOmOvAesq7deeZnjPX+8GbyNaL/7BWwnOzDcjUPpk7HD42hYkS1ynbLSrLh0vy/u0856kPYNOhd6C7jz6Wqa/faWIFdl8gevD/3YLmOT7YiGQn+LQoBgHF11/fTimVru2lqLWzPYj2ugtpZp94wFbYpUo0lIEwylGBICJ7WwkPMTZdwqbIF72rxSFNY7nT+Qw2mFYTc4CiGxBpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(38100700002)(31686004)(2906002)(5660300002)(6486002)(53546011)(36756003)(86362001)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(4326008)(31696002)(83380400001)(478600001)(26005)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3dSM3gzcmlJbjVqcGhSMkVEdTZMUlR1STk5WU4vZ0VaaEJ1b2JsOHFJVUxl?=
 =?utf-8?B?TUFYdnFVUTBmL2NETk9aWmhuN0dTMzJ0Rm5NWjU5Rk5QM1BOMnRRWmtVQS9j?=
 =?utf-8?B?Y3dGKy85LzZwSUUrY2VKNlF6SVRmMkZ1NllMODRNdXJxcDhvVksxTUM5S0lH?=
 =?utf-8?B?MVNESVJlN3hhMHBmSXN4OXkyQ1lZU1dLTjI0OC9qYjltWEtvMWNVUy9Uem00?=
 =?utf-8?B?eFNzZ2RVR2VHcTMwVXhrV2kxZno1WjhaWVI1OHVHQmt3THRJdUdFeEc2dkxl?=
 =?utf-8?B?Z3d4UDdTNkhiWjB3bDZyTlZXQ2tIQkhNK0w5cE52WDl1NHVxa2d3TjdzMFhs?=
 =?utf-8?B?WmxhTDBORzkvTXd0NGd1ZE5VQmFZdEoyQXUrbDB2SE5LSjEzeUhwZUdiYUFZ?=
 =?utf-8?B?NXVINmhqU1FWUndpdzZydkttR2VXL3drd1ppZGxFcUppK3M5dEJ0MEI1T01o?=
 =?utf-8?B?cHNHZGdQUWk3OFBjNzlxdWpNQURBTEJVR3JQUHBJWDc3a2k2WnJsTGtwTko3?=
 =?utf-8?B?ZkdDNEErN29sQWdjVkZYWDM5TC9kc1FnQnlxeUYxLytIbEU3UDlVWFVLQlRB?=
 =?utf-8?B?Z2tQOUhXRnV5K0ltWVZZNjU3VXhyM2g0bzQwT0k5MVJhY2lUNVRyVktwK0Zr?=
 =?utf-8?B?NEhOVlF2RS9pRHJpQ25DMGUvWkwvZmhpdStVemE0RW10cTRZb1BjSjRPeEtT?=
 =?utf-8?B?aW1lWkJoT2lzaFdPQ3ZqdXVNSHduWVNxQ0FiNUE5Ri9EdDJjcEFaSTQvMUFC?=
 =?utf-8?B?K1djakd1S0N1U0RheUVYVGVpeTdjOFVlYmxUWVJlRTVPdXN3NEFXYzNNOXZJ?=
 =?utf-8?B?YnV1QTlXQWJIcllCbmtaYUpRaWRQM0ZxYVVsTk5MckJPRU9ZN0pWUS92aG9q?=
 =?utf-8?B?ckNrbk9tcFMxbStxaFJDRzU4Z2FJMUtaeXVIVTVzd0UvMTA0alRMTEt4WmRG?=
 =?utf-8?B?dW5zSkxUa3NTb0xMbDdFcytJT1gxcnEydFFDNmFxVUg2VkpvZ2JIYm1QRVMw?=
 =?utf-8?B?VHdoN291Y2RXSDJKcExVa0J2QWx2eHBRN2EwR2pSV1BLVnAxSmdJdk0xelpo?=
 =?utf-8?B?Tk9CREdRdEV4YU9DanI5YzRZSzkyYzZrc3FacGlIOGhlUVcwa1hQYnBwTThZ?=
 =?utf-8?B?eU80bkEzcHJrMlZjMFVnWWlkWmJpOGtqSTBwQWRQVUdGSHJXemU2TWlqOXlJ?=
 =?utf-8?B?Zk1WdzdQajM1dTlMNUluc1p2RnhwN1hFUXNEaVQ0b05SaGxvUGtlWldoUUVz?=
 =?utf-8?B?aWs3aE5MOFhydXJqK2YrY2t0UmV6NDIvV05uQXNlZ2hHZ3RKa3pnK2ZhaXN0?=
 =?utf-8?B?VHdVNkhYTzBWSkt0MURvaWtCeG5hOFYwb0JGS2pHTUtzRUU3WVVCZStZaXIv?=
 =?utf-8?B?Q0hnRXQxQVh5Uk1FZnIzWFpYQ0N5SjhoZFA5ckwvcmdmVlo1c1NXWHNNbjVx?=
 =?utf-8?B?bUJBQU8vWXJLVXFOdmV3dVdyK0FPTHBGazA3cGgyUVluYmdjRGF5d2dQUGtU?=
 =?utf-8?B?THh6WldqVGM4LzIxRllQK1hYTFprZVg4YVFyYlBra2Vqelk2alEwbDFnbzRW?=
 =?utf-8?B?b1ZteEErcURnVUpraEhtNlNLcUV5Mnk0amlpdmVGN0VGVEgrZU5PMmJwS2tx?=
 =?utf-8?B?NTl3VTJxTkV5TW1hb2I1NTFoZWpvOHl4M0I0aDhESmZscThpeDNMWUxNcFBH?=
 =?utf-8?B?WXE0YXV6WUVyYVpZeHI1SXBGdTYweGZWZGFYbGUveG50MGtlUnQ5TnEyT3Er?=
 =?utf-8?B?NERLaFN2NHpBY3UzWEZHZWROYXllZTRndktCSU85ZlNCMzlRNytUWUZIWGNQ?=
 =?utf-8?B?OFhiK0lzMk9Gc2dyb2h6TVNnR0RCdmNMVWxKOG95RnNhUTNnZjV3ZU1uVG41?=
 =?utf-8?B?cGZLenR6aHh0bmhIWlNHcS9tSElSUWlaR2NZQTJSVExWbU1WQXlGVUNsUi9Z?=
 =?utf-8?B?VFlXMFliK2llVGk4QU5ORjBVcENpVkROMVg3WCtFOGp5ekxZVDgzcUhBL2ow?=
 =?utf-8?B?YVRKMmRLUEoxcmhKTEFReDRMVFNzSS9HbVdUb2RQRVdwSUN5cVFaTUlLa2Vh?=
 =?utf-8?B?b2x3Q2grS3pibXh6VVFzTDZhS2hBKzQxN0RXVVE0VElUbGdTQ1RYVDkyRHhj?=
 =?utf-8?Q?MiOc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968f620-57f8-4a00-74d1-08dc109fee42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:17:06.4395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96h9iKm+XnlvPhJRz5MQrPboIwT6685/bQ0zWmnrpMko2ZzvQKHEhkortnyjt26u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With a nitpick below, this patch is

Reviewed-by:Xiaogang Chen<Xiaogang.Chen@amd.com>

On 1/8/2024 4:36 PM, Philip Yang wrote:
> After range spliting, set new range and old range actual_loc:
> new range actual_loc is 0 if new->vram_pages is 0.
> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cc24f30f88fb..cb09e1d3a643 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> -	prange->vram_pages = 0;
I think it is better to keep it, also:

+new->actual_loc = 0;

though not necessary as prange is allocated by kzalloc, just keep consistent with previous statements, or remove

atomic_set(&prange->invalid, 0);
prange->validate_timestamp = 0;

too.

Regards
Xiaogang

>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -980,8 +979,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc && new->vram_pages) {
>   		old->vram_pages -= new->vram_pages;
> +		new->actual_loc = old->actual_loc;
> +		if (!old->vram_pages)
> +			old->actual_loc = 0;
> +	}
>   
>   	return 0;
>   }
> @@ -1058,7 +1061,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> -	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
