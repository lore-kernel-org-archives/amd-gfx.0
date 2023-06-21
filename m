Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA312EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 12:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F9410E449;
	Wed, 21 Jun 2023 12:09:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841CF10E449
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 12:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlWnCrFoxHYYG3dJyzBol031jyC0fTohX/LXHaPNmn2alA6gqefSO/clNEseV/38wTC+Xndwo2PT/gG0b78/riEuzxHSz1IRfsnzKFcBI0hpIDcWeGertdc5HlgAJHBWInV5QxY8jF8RGGdgusNmZHV1wuL3gYiJhBN04Y55fL6KKiJlHF3V/xDxBzhBXJxp8p0lzL0HTrFc8n9pDYRcXILq2FqjazXk2utZE2y2EwcPqNPw8R4jit2s3u4JZCcvIrVsMaxulYy8VLb2l2QFh3mAGUXMuDto6RR5kBUB81ROxgEoEY0dpUJ7uIQs8PFnOrQqWQG7dYMiKVwRjATk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A8lKhKjSvk+FQpE9p0My6xm/fmRpXBaXdzUstRu/I0=;
 b=KmrsyyOwGYpX704erMsvPE4Dw0ad5l5x+cpbOsK588cIpCs7Mbx36Zf1upPd3+jjXid+lmUvmhHKvvMsJUlggrKrNa6hsKWYo9CWoRNjSdAZoUBHf0UuRV3pYoGD7Umovc5DXMoXYtrrLEohG0CyXV+GTzDDGZI09eyb9akDJUZrsTo9/P+WD3oOJXMjo+xUp0RTj+8HYXYY03LyNQR0WttPQKE2h0IXMAd7ZqewsMxqYbfrF+vv4Q2N6Hjw3nsIGv5fs20IPgoSR6e53p3lYGODF4qmI6z0HUDk1y82NbsTIWQw43/GfRh2MCVfyW9JRzxKFlisaAZA/CWYpDOlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A8lKhKjSvk+FQpE9p0My6xm/fmRpXBaXdzUstRu/I0=;
 b=2RCILp5H+nPK7iwSqk2laP7GY0eDLeH79hAd+jNFpLimO2SnqhOpbgv2fGi0mgy9VFQkvhu6mJYWRI4anh5AvP9yYzkSV1ZI5JEZD17LXCSlw4+ubo+MObCJUMrJIAY5Ui8xX2E5iKhD340lQbBWbt02XRqcKsOwoXZvflaLXmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 12:09:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 12:09:00 +0000
Message-ID: <3ee2a79e-7b25-3b23-4b71-9c197d4d464d@amd.com>
Date: Wed, 21 Jun 2023 14:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/12] drm/amdgpu: use doorbell mgr for MES kernel
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-12-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230620171608.2131-12-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e44786-3924-4093-9051-08db72504c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1osoDZXcimwDRf2Pe4RvQAzTaUNWdlnKkWmneqrRlF1Z40gSc0Lw6vVPkLi1vvk+D+9eIgNi16VOz8I4wBEBVKQUyExl66RD/8P9ah9k0XZl8zIw8Ufk4+L78/Kdw6kdKwJ8L6t2/iXPlSVLHuEEbUy30pwaZdqRG8YI0ct57Qzx2my/JOxn5ZQQCHaGyyFTBSaw5pw6+zxUjUiTV5YhX2tafPJDMa+mHenRSjq108mEAfVFpvKb8l7k1Bxrr5L+spAtEo96ammEKg7PvsFBaNFIV8ObI85znkYW+K3QaWrex27cdelGweRE1IHaaLLNFCFZv0DpvG0s7234emqHCGuar+UNa5gyPxupvrW7B3azmTkb/Pukb8o3RXmW/dKrfOGu+b6CjN2+3uMElcwsQatgVH5aSTYOHpV/ErESoVDBLTjlGQ46BqQ2LhaTA5IKrdnK7eLtLyvb5VrEHhZW5ZWJGXae+GM1FE/x2m/+dPHiIswYOcgVV9mPQo38rN5sgjWdgz+mdJr0D7BR7ACMzWKeQ1Wz7KvlOjZ6C2SiifUoEpaIauYDUKpuPQXxAIorpUETKAGzxlmPEWscAxLWFsRvqIuqL+WKvnFbVGrvXCsVmSOvsPk4vZaprCIDVkF012kqIlkIjfXzdR2mXH97Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(31686004)(36756003)(5660300002)(8676002)(41300700001)(8936002)(66476007)(86362001)(66556008)(38100700002)(4326008)(316002)(66946007)(31696002)(6486002)(478600001)(6512007)(6506007)(186003)(2906002)(2616005)(83380400001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0F2UnU1QlZlQ3piU1dMUy9jVjdlbkFWdXhSS0p4SGozUWpZVlQ4eUkyRWgw?=
 =?utf-8?B?NllNdklZMXZUNjFyK2JJZ1RLcDkwVk1GY2NCeWxRZUppNUNxYmI1ZHVSSkNz?=
 =?utf-8?B?SHdFQ2kyeUh4TTgrL0xJUWhRaDA2akF1aVZlU1Q1NklJbUUveWhZdFdOV09Q?=
 =?utf-8?B?TzlpRUNUZDZRWUlGTG9zc3pCcDViMzRXRDlEWHVxUmN4RS9qc1VqdmZrQ05N?=
 =?utf-8?B?dUpobmVhRXhLYmx0RkVEbmM0dWtKTkdjcWhMcUNLZUIzMDRqWU9KZHRGeXAr?=
 =?utf-8?B?Z1lReEFqY0RKS1dnb0h5aW42YWxkdkYyb1ZqU3ZuT3poQ3hKeGVBTUFwOEx0?=
 =?utf-8?B?NmErb202elVCdGVWTmV3YjNWeVVnNGNxbGFRTjNLZFBkNy9zQmc2Z0VZdmZi?=
 =?utf-8?B?T2VlaCttdkRmOTg5UDZKV3pGdzVjT3dvMDhwUUN0bElGYmxHWGszYXA3alpu?=
 =?utf-8?B?WnpRaU1TM2JmbUZFa0ZiUW9FT0lYV01oWjRmV2ZEazRBVzNlMDJaUitSZTRE?=
 =?utf-8?B?Snd0Q24yWXFWdzJLUDMraGVpZDRCeXZGaDZqZEhEa29oQUdPS0s4cGFMTDhu?=
 =?utf-8?B?MXVaRFE3aDlmRGk5ZFpuUGkyS1RSZ28waHVhdU9TRUN5bDNKR1E5UVZXQ215?=
 =?utf-8?B?cEJ3NFpWZEg2SHREUkppS25qOWFxdlpDOTV3aHY2MEpoV0xsVVU3cFdLQmVC?=
 =?utf-8?B?STcyakxvWVNNenNWWTBCTVV4Mjk3M21JWGR0bVhvczlqVlgyYjhnN2hsc01w?=
 =?utf-8?B?bVZXM01CMXowN2ViMk50Q0FScU5ST21uQ0ladmNXSFRQZVozQXVUVFFQUXMy?=
 =?utf-8?B?d0pjRjQvZUR0anF6NE0reFdMaENoVC8xOWZWL0J6dVJ3T1VPZkhOYUtEb2tP?=
 =?utf-8?B?dDhzUFZoU3RzYWVsODQxL3d6c2hkNEtLOG9yOU5DTk1HcEw5bXZWZ0ZJRVRx?=
 =?utf-8?B?d3ZrT1BYUGxtYzlKbGhaa3dUTXZ5NkU3YWFPem5sNGZtZU1ydXhldUtMYXhZ?=
 =?utf-8?B?U3RYWnk2YW1kVS9tTGFnN2hMci82cXpaYUVHcEc5U0FWa2lvVDlxU0JaYzJB?=
 =?utf-8?B?d2Z1R1VLL1Y3V1B3WTdRbnJ4WWt5Y0M2RlRxQlo1NmR6RmVkV1dLTEE5VmdL?=
 =?utf-8?B?bkg3dmFwOXRudEdwZldlUjh1RUVrRVJVeldqN1VyMkl0S3d3QTQ2dGlaSXNF?=
 =?utf-8?B?eUNhSXNUSGQwSXY3aFNQS0VIdEI0ZDcyenM5dnVPanpHMU9jdThta2dwWWtH?=
 =?utf-8?B?TForS2tJaDlBcmtjQlh2ME9aMXdEZGxQM1VIaVYvVkVNTXNwN1c3YTIwUHFJ?=
 =?utf-8?B?Ni9pSTAwc1FWZXl5Y0w0d2E1VEdYcS9wczQ1Y3ZsMWpXNTF0RitHRE4xSEUw?=
 =?utf-8?B?azRuK3UrY21CY3ZzR21DN0cxN0trcEoyb2l5MVpMKzJaT0dzaHJTMDkwUUhj?=
 =?utf-8?B?em5CZzQ0K0ZFOW9uTnloM1orRXdnTkdUU042UytYYUtGYXZrTWw3anUwY2JC?=
 =?utf-8?B?aHF0Y1Y4Y05TVVIzRzhQUkw3ZlEzbDJVNlVEL2x1R042Q1lXWTkybU8rV2x1?=
 =?utf-8?B?NkNnZC9EOHEyYmVmZDFyMnBqTGdhMzB2ZmN1TW0rZDhra2g0QUFaNVROUDR3?=
 =?utf-8?B?TmttS2JjVVVKc2VmZTVKclpGdkFleTVEMGxvUnl3b213S0JxL3Q0UCtFeGF5?=
 =?utf-8?B?aXBWQjZhSWtjS2R3L0ZLdXlRVm1jYm9Uc1NOOXQ3eHQ5aEtFU3c1cUxPdVJj?=
 =?utf-8?B?QURQU3FrQURWSjNtekJlcHNLU3ZvdkNOMWNHMEF5cW5lOVpadWZoOFJCeUtv?=
 =?utf-8?B?NkRjN1pOckVqSUVKbzh4U1RLak9QdTNJa0JEdTN6bkNTbHpJcldqUHN2eGFX?=
 =?utf-8?B?NzJmRy8rR0s3aEV4YW9UbjhEN2FCZmpjSElIOFpkOWxNT3RiQ292WmkwTlI1?=
 =?utf-8?B?OUw1dzQ4REZHRVRCT2c5OW1TS1RrclhKaVpvUVRXeldOTUZmM2NtS3RveCtD?=
 =?utf-8?B?YTY5cFcxWmZod0ZJeVhja05CQ3ZYRnF0U0h1TFdMSkcvMURESzFJalNOY04x?=
 =?utf-8?B?a2p6b1N1SDhlM0xPK2lqWTF0STZTajcydm5QMDBGdmhPUGZkMFUxV1BKWksy?=
 =?utf-8?B?RCtYenppYVlnOFg1R1BrY2xydjdWNkllQ2JrU1MyRXJGUUNDRDh2dWF2K3hY?=
 =?utf-8?Q?Ubkx+gImLPfjNqMogVC0UZL0VwavAtDU/6gRsLKNwZez?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e44786-3924-4093-9051-08db72504c42
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:09:00.6726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26X5AcQ3kCnfsDp/Z9MM1+Kh4eVz9IdntGndyl5kX4U2y2jpT+xV/noE0oLymNr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.06.23 um 19:16 schrieb Shashank Sharma:
> This patch:
> - Removes the existing doorbell management code, and its variables
>    from the doorbell_init function, it will be done in doorbell
>    manager now.
> - uses the doorbell page created for MES kernel level needs (doorbells
>    for MES self tests)
> - current MES code was allocating MES doorbells in MES process context,
>    but those were getting written using kernel doorbell calls. This patch
>    instead allocates a MES kernel doorbell for this (in add_hw_queue).
>
> V2: Create an extra page of doorbells for MES during kernel doorbell
>      creation (Alex)

As discussed on the other patch, this should probably be merged with 
patch #6 or otherwise we break the MES test in between.

Apart from that this patch set looks good to me now and is most likely 
ready to land.

Christian.

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 94 ++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +
>   2 files changed, 40 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f0f00466b59f..01c3d27512d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -67,91 +67,70 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
>   		doorbell_id * 2);
>   }
>   
> -static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
> +static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>   					 struct amdgpu_mes_process *process,
>   					 int ip_type, uint64_t *doorbell_index)
>   {
>   	unsigned int offset, found;
> +	struct amdgpu_mes *mes = &adev->mes;
>   
> -	if (ip_type == AMDGPU_RING_TYPE_SDMA) {
> +	if (ip_type == AMDGPU_RING_TYPE_SDMA)
>   		offset = adev->doorbell_index.sdma_engine[0];
> -		found = find_next_zero_bit(process->doorbell_bitmap,
> -					   AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
> -					   offset);
> -	} else {
> -		found = find_first_zero_bit(process->doorbell_bitmap,
> -					    AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
> -	}
> +	else
> +		offset = 0;
>   
> -	if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
> +	found = find_next_zero_bit(mes->doorbell_bitmap, mes->num_mes_dbs, offset);
> +	if (found >= mes->num_mes_dbs) {
>   		DRM_WARN("No doorbell available\n");
>   		return -ENOSPC;
>   	}
>   
> -	set_bit(found, process->doorbell_bitmap);
> -
> -	*doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
> -				process->doorbell_index, found);
> +	set_bit(found, mes->doorbell_bitmap);
>   
> +	/* Get the absolute doorbell index on BAR */
> +	*doorbell_index = mes->db_start_dw_offset + found * 2;
>   	return 0;
>   }
>   
> -static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
> +static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
>   					   struct amdgpu_mes_process *process,
>   					   uint32_t doorbell_index)
>   {
> -	unsigned int old, doorbell_id;
> -
> -	doorbell_id = doorbell_index -
> -		(process->doorbell_index *
> -		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
> -	doorbell_id /= 2;
> +	unsigned int old, rel_index;
> +	struct amdgpu_mes *mes = &adev->mes;
>   
> -	old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
> +	/* Find the relative index of the doorbell in this object */
> +	rel_index = (doorbell_index - mes->db_start_dw_offset) / 2;
> +	old = test_and_clear_bit(rel_index, mes->doorbell_bitmap);
>   	WARN_ON(!old);
>   }
>   
>   static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>   {
> -	size_t doorbell_start_offset;
> -	size_t doorbell_aperture_size;
> -	size_t doorbell_process_limit;
> -	size_t aggregated_doorbell_start;
>   	int i;
> +	struct amdgpu_mes *mes = &adev->mes;
>   
> -	aggregated_doorbell_start = (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
> -	aggregated_doorbell_start =
> -		roundup(aggregated_doorbell_start, PAGE_SIZE);
> -
> -	doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
> -	doorbell_start_offset =
> -		roundup(doorbell_start_offset,
> -			amdgpu_mes_doorbell_process_slice(adev));
> -
> -	doorbell_aperture_size = adev->doorbell.size;
> -	doorbell_aperture_size =
> -			rounddown(doorbell_aperture_size,
> -				  amdgpu_mes_doorbell_process_slice(adev));
> -
> -	if (doorbell_aperture_size > doorbell_start_offset)
> -		doorbell_process_limit =
> -			(doorbell_aperture_size - doorbell_start_offset) /
> -			amdgpu_mes_doorbell_process_slice(adev);
> -	else
> -		return -ENOSPC;
> -
> -	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
> -	adev->mes.max_doorbell_slices = doorbell_process_limit;
> +	/* Bitmap for dynamic allocation of kernel doorbells */
> +	mes->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE / sizeof(u32), GFP_KERNEL);
> +	if (!mes->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
>   
> -	/* allocate Qword range for aggregated doorbell */
> -	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
> -		adev->mes.aggregated_doorbells[i] =
> -			aggregated_doorbell_start / sizeof(u32) + i * 2;
> +	mes->num_mes_dbs = PAGE_SIZE / AMDGPU_ONE_DOORBELL_SIZE;
> +	for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
> +		adev->mes.aggregated_doorbells[i] = mes->db_start_dw_offset + i * 2;
> +		set_bit(i, mes->doorbell_bitmap);
> +	}
>   
> -	DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
>   	return 0;
>   }
>   
> +static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
> +{
> +	bitmap_free(adev->mes.doorbell_bitmap);
> +}
> +
>   int amdgpu_mes_init(struct amdgpu_device *adev)
>   {
>   	int i, r;
> @@ -250,6 +229,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>   	amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
> +	amdgpu_mes_doorbell_free(adev);
>   
>   	idr_destroy(&adev->mes.pasid_idr);
>   	idr_destroy(&adev->mes.gang_id_idr);
> @@ -679,7 +659,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	*queue_id = queue->queue_id = r;
>   
>   	/* allocate a doorbell index for the queue */
> -	r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
> +	r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
>   					  qprops->queue_type,
>   					  &qprops->doorbell_off);
>   	if (r)
> @@ -737,7 +717,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	return 0;
>   
>   clean_up_doorbell:
> -	amdgpu_mes_queue_doorbell_free(adev, gang->process,
> +	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>   				       qprops->doorbell_off);
>   clean_up_queue_id:
>   	spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> @@ -792,7 +772,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
>   			  queue_id);
>   
>   	list_del(&queue->list);
> -	amdgpu_mes_queue_doorbell_free(adev, gang->process,
> +	amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>   				       queue->doorbell_off);
>   	amdgpu_mes_unlock(&adev->mes);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a403418d5eac..2c604e04fd5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -27,6 +27,7 @@
>   #include "amdgpu_irq.h"
>   #include "kgd_kfd_interface.h"
>   #include "amdgpu_gfx.h"
> +#include "amdgpu_doorbell.h"
>   #include <linux/sched/mm.h>
>   
>   #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
> @@ -130,6 +131,8 @@ struct amdgpu_mes {
>   
>   	/* MES doorbells */
>   	uint32_t			db_start_dw_offset;
> +	uint32_t			num_mes_dbs;
> +	unsigned long			*doorbell_bitmap;
>   
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;

