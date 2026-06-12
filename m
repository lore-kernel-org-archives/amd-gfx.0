Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B50CD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6765C10E0C1;
	Fri, 12 Jun 2026 15:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmMtTBHx";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0544F10E0C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 15:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkNLQt+xbo3UzBD/wSJVuhQOWWd+4p6hSayKN3WcbT18ISbIfYHAo2uRz4sBWzlD7zO40K7jVPsVZOtHWFv1rLBbNIKJTuIIeKlCN24qY1hSpmWZpw33qfy4Oao6h66FGWnDfCAVrWziLzUM/IwDMtzGTmvPylYMDhbPGH4h4lKQFIHa3T3eZgz5mCbZ7LOyfQVoG55bWijMPCEMJktmn3OjBOa8Lh/3A4uX2VRtdVOJ4JHyFyLbBjIK1AAujAyFsJhQZrvKZwHgn5mjAo8EPZjlWkfxy78epeKu4TzbsWI33bxjdwu1QX+m8f4+YN2olBnpNEwoVkoM71PHlIZ0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VcLEJrkzz/xiTtMOG1RnsVCStqqETOMvBt1dnDG1Qs=;
 b=tXXkEaeYAUdVIwrVA+B7vIwTFOmUe06tlmGBjZM3V1/bEKdJH31IWLu6u60ljL4PkIk51fM27aS4UlSVgJZgIxZStrdApGSauI8WPuuFyua9NNnCWdC0lEVRUgenGY5ns0M0QicfaIchtu1fAw0O8dSLowmDzG+TftqArd5XrotQDKw1Gsn/v0d1UNQQ3BG0AxK5zjSPDApJ1Ps/xHz5eUvBBv+Eshzyi3BZT1VWJC8D2zmo7QQ9TukZMkIiPyXdWB2mTPvxMnbzp72d/+QiOfk/trvtdBSW9+2w7OCFBiONP+7BMJhAEVTrmnfB8af9IxnG1bfKzS3jjkU7DjTKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VcLEJrkzz/xiTtMOG1RnsVCStqqETOMvBt1dnDG1Qs=;
 b=YmMtTBHxX3OJ9/VL4FhpC8MQKsoWJbHfTwo6jpbzruOtnd1Qa+ruTbI64JsW9wMvR+FxClCh39gWd8pQpF385+49Gpu2KW6tIeuOVd8UpMDllslAAZ9v7u0q9RtdI7YqFJiyFVbFD415rJPCwUUhmMaaqeePk9jMJznVecNMw0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 15:30:40 +0000
Received: from PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16]) by PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:30:38 +0000
Message-ID: <d8d80c67-7a1d-4a44-8a24-3c0059b91bfb@amd.com>
Date: Fri, 12 Jun 2026 11:30:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: remove dead kernel-allocated signal page
 code
To: Yongqiang Sun <Yongqiang.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260611200746.320513-1-Yongqiang.Sun@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260611200746.320513-1-Yongqiang.Sun@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::28) To PH8PR12MB8432.namprd12.prod.outlook.com
 (2603:10b6:510:25b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB8432:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c52083-ed02-45d5-390b-08dec8978e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wrbDmu0LgbVebRnL+V8F2NBjH1ouRi7+BlP1Pf01oZ4G5G/laH60Y6S9kSaW3WTCxkL9zfQ0sTrCsxJIyn6g5xjNcdAx5E4qH7ZAlXDn24q7PhPr1WQw99Zn/nnmicYK1HB9KB8/9XpOC2/jags/t7rP0ezs2ny4yZqNS1bVZbivjvt/XTKn4KQcBgjIIsM44tVLZFo/pSwCkXiUD40189Ownow6NGbY46Bv6nF5nniHZoubM1Meb70K8k7STtlZxMEGWT+TftCmNNDhaEXFoDZAS49NdjF+8du8m6rBcL8674xWXod8EtK46fiLudhxTO/LcPinY69lroP4DxSsHVDF/rvYQ36xO/6tWvbRln84ZghEAyVolgah3HY8DgCXLCFm5cDFq4a4TMb3/6GIPD7M5HlJwyvIVYE1fIO2CbkQRQq7W6nkEq9hg6zDR3Mw5anGt2DoUlk82SVDGsAR8rAm+OGEQfIr9BfkjTRGEBqu1YL6b2ORTQL3I1x6zsEZ9IedVqN/soCXPenzDHCBNO+aQmH+pCITCusRj47sIkeGJelMWPZm2ZMpKOa/7AfAAVdXEThVzKG0/36+2obLx1DkHoqp6XgEBdvc66IUeXmwZdi5OZ09bBD6PBzcvo4EXI9goTRySpRuKMIzirF7R5QkEv5seKN7hZTGTqDqtpiQ0IRE0UaAmlLEneh5udiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB8432.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNKSWdNc2Zmem5mZ3Y3SDBkNmNzUlB4RGRUVCtQYXRmWHluVGxVUG50dlVl?=
 =?utf-8?B?blB5UlM3cmdrNzMxaFI5VzdGSjJqdmlKWlNkQWw5OTFIVlRJYll1d1pEVkhX?=
 =?utf-8?B?Z0xweEp2KzlDbWc3Y1RHWGVpMk1GZjFVZlBHWlJqTDBNU2liQzZFSGg0MWk1?=
 =?utf-8?B?a3ViODBLeUlhMnlsK3dIQXFobjBVekRVUFA4L2dUTWFkcTFQRDg0a2VZV0tP?=
 =?utf-8?B?dXBuaFhhNW5Jd2J1OU01VE5JT1F4REtmaDltVzRqYzFhOU56Ulc0TGtuV2dq?=
 =?utf-8?B?Qml4aFdoWVN5YTVPNENmWXNBMHFuZVY4bGdqQTNxbloyVk9HTzhzbmg5UGZD?=
 =?utf-8?B?Q3YrUGVkOXhVRjU5S3JIMk5MeXJSUzRrd2RodyttOHRKek8xMzVyMENPWjBX?=
 =?utf-8?B?bU53QUNteG93RllLeC9zWFFObFcvUzBvT1lxRVlPdXIzNEJLUkRTUldpK2xB?=
 =?utf-8?B?RXEyK2k0NFliaWRLNjFUWmEwWStOM1dZNno5WDArUG1KU1JWam1wTlVWS2JZ?=
 =?utf-8?B?THJka1A4dXN0L2RiOUZCQXp0eU5zckQ5TjVJSVB3a2JxYU5sZVIxaVN6bElO?=
 =?utf-8?B?YndFTWV1Q3NNcmZkNjVCWGlFWk9OS2FGejU2dDM3T0tUUCtRSm43Vi9qc3M2?=
 =?utf-8?B?TEduRnNMZ214QnJoSFJMbUhreGpSa3Z6ZXVmS21QTUNaY1A5Z2p5WEVIamFZ?=
 =?utf-8?B?WXZ4eDlpcmlQYU1iTDNzMy9zOFRhNVlpUCthQVZQdTE0Q050RGJjVGNHNi9G?=
 =?utf-8?B?ZGh5c242VlhVU0NyMVNoV1pUN21OQUZJQ0RqV0c0NDgxN0xGbkhaR3puSmZh?=
 =?utf-8?B?eU9UZFk5RG92enlxWTZ3Nm1IMUY0eUVJend5Vm9qMEVNUS8xaWkwNUhOMnF0?=
 =?utf-8?B?UThZQzVla0luSVZRekJTdTFDM01DbUptZWkrNlhScmdhelJIRUtnWlBEUDkz?=
 =?utf-8?B?eGlCMEZmSlNvMWIrWXhHaHBFRmZVZ2RqOUxHYktIcVNsSFhlQlZWd1BpWmZz?=
 =?utf-8?B?VUVPbzZTVXV4c1dETUhGd0NvajRqcnlrMXNXS21oakpWWlBubkdZLzNqVDlT?=
 =?utf-8?B?dUNSYTdQTjRDUkQrdk5LV0E1cHlxOGdleldJOUtqZ25GamdJdTNUMzR3ZHFp?=
 =?utf-8?B?UHFaL0duSjd3VXFzYWZhQkVhNWhBbkZYQkhEWVdGcWY2cUJTL0pkeDN0KzFw?=
 =?utf-8?B?b0l2c084a3h0T25YY3g2SGVFSklVbnlPelF2bFlqMXBNME84a2Iybkp3Y0hE?=
 =?utf-8?B?SE1qS3NEa0E4OHZVUm1oeXV2QjBCNXlPeTFKNTRMTTNsKy9qT0JoSmVwOWdE?=
 =?utf-8?B?aUVaM1QzYkY1UUpJTDh1YUI4NW5RbzB3d204bVFtT25IWTZ3Q3RnNVFEaDQ3?=
 =?utf-8?B?eTBPdEJITUgwaHhDY2RoMitlSDU5cXpwblptV056SVN0blFNUm5Cc1psbUNh?=
 =?utf-8?B?elphUC9tY3FGL2xwNzVRRDQ4NXdOTXlCRlNqWFhOVVZpb092SjRKVXppdCsw?=
 =?utf-8?B?bEE0V3UvKzVEQmcvMldwSEpaOWtPVWw2NkVPUHdBUEI1U3ZzWExhbk5BSVR3?=
 =?utf-8?B?bWtvZkRVU0N3N1ljWTFxdUtQaXd4Q1F1amsxZFlubUlvSGwyeWhHRzNkQSti?=
 =?utf-8?B?QUw1WjJqZytmWUM0Rk9iamk2SmNWSXBJYW1CWHZqSzVkbHFGb0VrRXE4T1du?=
 =?utf-8?B?eTRmYTk3VXU5NWVYdFhRNWQ2NmNYd1JjNlJlNXYyRmRYakUzN0Q4UEZYQWFv?=
 =?utf-8?B?V2U3UUo2cnFMVXVUeGY1ZWZPN3FOZU5WdWJ5QnJXcUVQeThYUTdVa0FpYVAv?=
 =?utf-8?B?OXAzMFJIbGcxQ3hBcUFoYnoxRjlDaDZ6V0FwaHFOM1BVczJRT1M3VkZMQXp6?=
 =?utf-8?B?YVp5TVMzWWdJUC9kcDM1QklGOXJRTXB1NEE3bGxvZEc1S0JaR09CTkJITTdz?=
 =?utf-8?B?bXhZY3RGMGJKcHZidlNkM1JTLzB3cnJPaVd4NXNXWHBJckJiNFI3MFB6ZXY3?=
 =?utf-8?B?d3hoaU1NdXZmaE84Q0t4TjFCS0xCZHVySDRtWkdzR2RQLy9KNUlJNXNPYk9r?=
 =?utf-8?B?S1hSTmFQaWNkT0QwSmd5NkdIZThjU054Ui80S1FOYTNvdll3azRtU1J1ekpk?=
 =?utf-8?B?V1RxNnVRVExKQTVVd0s5RlYxTG1jMWpadC9xVW9CVVJ5L0hMZFJvSHJlY3Zn?=
 =?utf-8?B?T2dkR29RU3V4WVVwekdEeThSeTZzVTZaKy9IYmNLR0pjNWVnV3Izem1hWk5t?=
 =?utf-8?B?ZXYxamVaR1MvL3ZYOXFEWjlkY05CL1E3bW03Um94bk8zckZ6SkMxSnRtTmhE?=
 =?utf-8?B?TlE2dEtzMC9yemErNnlBV21WenhNdCtEaXRZdk0ydVdrejduMWJFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c52083-ed02-45d5-390b-08dec8978e01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:30:38.2618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr4K1y+ExtsAl3UYIRDnE5ZB5m8tlsL3etg3xs4qC8DGSPHB0hwbCBXIR5AIClSNVEAr/YMiA6TrfXYWaDzWyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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


On 2026-06-11 16:07, Yongqiang Sun wrote:
> With the KFD_MMAP_TYPE_EVENTS mmap path gone, a kernel-allocated signal
> page can no longer be exposed to user space, so allocate_signal_page()
> and the related bookkeeping are dead code. The only remaining way to set
> up a signal page is kfd_kmap_event_page()/kfd_event_page_set(), where
> user space allocates the events page as a BO and passes it via the
> event_page_offset of the create event IOCTL.
>
> Remove allocate_signal_page() and require the signal page to be provided
> by user space. Drop the now unused kfd_signal_page user mapping
> bookkeeping (user_address/need_to_free_pages) and
> kfd_event::user_signal_address.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 59 +++++--------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.h |  3 --
>   2 files changed, 10 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e44f1d1bc516..85e4ad10d619 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -55,8 +55,6 @@ struct kfd_event_waiter {
>    */
>   struct kfd_signal_page {
>   	uint64_t *kernel_address;
> -	uint64_t __user *user_address;
> -	bool need_to_free_pages;
>   };

This patch looks good to me. But I think you could even go one step 
further, maybe in a third patch. struct kfd_signal_page now has just a 
single member. There is really no reason why this structure needs to be 
allocated dynamically any more. You could just replace p->signal_page 
with a uint64_t * that holds the kernel_address of kmapped the signal BO 
directly.

That said, patches 1 and 2 are

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   
>   static uint64_t *page_slots(struct kfd_signal_page *page)
> @@ -64,49 +62,19 @@ static uint64_t *page_slots(struct kfd_signal_page *page)
>   	return page->kernel_address;
>   }
>   
> -static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
> -{
> -	void *backing_store;
> -	struct kfd_signal_page *page;
> -
> -	page = kzalloc(sizeof(*page), GFP_KERNEL);
> -	if (!page)
> -		return NULL;
> -
> -	backing_store = (void *) __get_free_pages(GFP_KERNEL,
> -					get_order(KFD_SIGNAL_EVENT_LIMIT * 8));
> -	if (!backing_store)
> -		goto fail_alloc_signal_store;
> -
> -	/* Initialize all events to unsignaled */
> -	memset(backing_store, (uint8_t) UNSIGNALED_EVENT_SLOT,
> -	       KFD_SIGNAL_EVENT_LIMIT * 8);
> -
> -	page->kernel_address = backing_store;
> -	page->need_to_free_pages = true;
> -	pr_debug("Allocated new event signal page at %p, for process %p\n",
> -			page, p);
> -
> -	return page;
> -
> -fail_alloc_signal_store:
> -	kfree(page);
> -	return NULL;
> -}
> -
>   static int allocate_event_notification_slot(struct kfd_process *p,
>   					    struct kfd_event *ev,
>   					    const int *restore_id)
>   {
>   	int id;
>   
> -	if (!p->signal_page) {
> -		p->signal_page = allocate_signal_page(p);
> -		if (!p->signal_page)
> -			return -ENOMEM;
> -		/* Oldest user mode expects 256 event slots */
> -		p->signal_mapped_size = 256*8;
> -	}
> +	/*
> +	 * The signal page is allocated in user mode and mapped to the kernel
> +	 * via the event_page_offset of the create event IOCTL. Without it no
> +	 * signal events can be created.
> +	 */
> +	if (!p->signal_page)
> +		return -ENOMEM;
>   
>   	if (restore_id) {
>   		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
> @@ -212,10 +180,8 @@ static int create_signal_event(struct file *devkfd, struct kfd_process *p,
>   
>   	p->signal_event_count++;
>   
> -	ev->user_signal_address = &p->signal_page->user_address[ev->event_id];
> -	pr_debug("Signal event number %zu created with id %d, address %p\n",
> -			p->signal_event_count, ev->event_id,
> -			ev->user_signal_address);
> +	pr_debug("Signal event number %zu created with id %d\n",
> +			p->signal_event_count, ev->event_id);
>   
>   	return 0;
>   }
> @@ -303,12 +269,7 @@ static void shutdown_signal_page(struct kfd_process *p)
>   {
>   	struct kfd_signal_page *page = p->signal_page;
>   
> -	if (page) {
> -		if (page->need_to_free_pages)
> -			free_pages((unsigned long)page->kernel_address,
> -				   get_order(KFD_SIGNAL_EVENT_LIMIT * 8));
> -		kfree(page);
> -	}
> +	kfree(page);
>   }
>   
>   void kfd_event_free_process(struct kfd_process *p)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> index 1dc21c13833b..88e3797bfc42 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> @@ -63,9 +63,6 @@ struct kfd_event {
>   	spinlock_t lock;
>   	wait_queue_head_t wq; /* List of event waiters. */
>   
> -	/* Only for signal events. */
> -	uint64_t __user *user_signal_address;
> -
>   	/* type specific data */
>   	union {
>   		struct kfd_hsa_memory_exception_data memory_exception_data;
