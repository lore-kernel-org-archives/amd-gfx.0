Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DCAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E6F64FBB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E6F64FBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FC76EA74;
	Wed, 10 Mar 2021 22:29:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6376EA74
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 22:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6g4siKHFTvzXEKb3LANUUuSz1ONIDNu7A/ZL6+upidGD0VQVztz0O+4Dua8YDPuMPGoWSZU5kCle8sxqs6JJ8qwoEm1DIjoAYdcSoOr3tJAmll79uIltzr0Lk94JG+QDp9n3MptjavEbHykJp1+DC71bWw41yocRDN55v0aDjpAWyTt3CWl/f1g5Vv2QpYCYfuN6+/G6b5j1drMgNzq/F5WR+/bDiO76NXwVJ6KTREu/qUJAEHCd4LMocg24pexGsWMUvToVe7Gka8JT++hPcQkTqXQkMtoQ03AkIt55ZH8OiOqInMiWxxbDleNEzp31YZcr/zZnx6kBSfkqiB5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdTpHQklhfjXrrKzn+3BcaVbQ1RhzLdcsBTOIs8/jrM=;
 b=e6O6O3u85AYOOQU4DMu3Ecb6pgdixsw4MsvIkne9Qx8LY7yIf+fWCA3VQKrTgEYde7wdnYnfKjmbwbYS6MrozVHk+FF4FTYP62jMXxLdmKlg4/VxBvZwwvU97JlQM/sE59o4z8evewgoc+VcxSNgFaW3oUW6drUWN4tjJMdIPsZweuwqjBK8GeHLKEwsBRq0IVPW2yH8uiv3StFOjUhKUSKr6rBSNMePJd6L04xBH9svl5gyAv4H49CiNITKhRCF6cOtClRqkfSkj1qE9ZQZUqmQ25HDOl4eFGmMr24Ydo5aPIFrJ+Lp9u+VxpnthEj8P8w/g/AnHZaRtY1zmFdvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdTpHQklhfjXrrKzn+3BcaVbQ1RhzLdcsBTOIs8/jrM=;
 b=WjoEaCN4i9wdXwxj7ESxQvOpH+9psAO1BvTVgEwCSl51bi89IxoIxVxolfujcvQEPDqRSn5keKuS7hWYPoqzIaUdpDqpC62xJxsOGfuq1cAt7kccbUKYIaaJx25SuZvx2dC884FPu4vGuD5qG4oP0POi5X+vdnk5tF+m+21alGQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Wed, 10 Mar
 2021 22:29:06 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Wed, 10 Mar 2021
 22:29:06 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210309161911.45133-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5fc00303-a937-38ec-f494-0665bd413f7f@amd.com>
Date: Wed, 10 Mar 2021 17:29:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210309161911.45133-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 22:29:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd6bde14-8067-4229-48c8-08d8e413eaa6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40629F841BCFE6716D98BF6292919@MN2PR12MB4062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbACY9fd5x3BBTZhUcDoUYYXdiTuEPEBaFtqHeUc2NitSTBMLLWuInLPiTKfLHJVCDkuYLNaYEyDFDUnDhY/KHTg6XW4h03h29F1uZQbgIWfTkWKpY/WQacrZQPHe1ZKc2TrIa+6ptxTDjELo8Kvi9VDUroPfvj88H3Mb33gzJjvl7yajfnGbaeNM+gaMNy65JUdIPhG4gbLfV/PEv4pm/NOuQxe00+vb20L2AZXnZWA6uIeLL5yAP+XWuLmTY7eclyux8YSVa8ywMrvIsvfDL9bmKxVjzCY0AZrwYpJujvKplhsZQ7GajNRKaWc+xn3OAMa0C5OZ685dYryGDeyzUgLSOofCa0KJPhGb3aNd90/N9MWdXLz7ILvJXqKPY0vJ0R52NLb6HyeuTEy6UDANm8lWwRsJXZR9Xss4NWji/oGou4N0L0aGSxLxknz8YlD42BBm9rsHsPi+NIKQwylCKVT/HUXCmhViqygOV2NZ3RRDKNeoZ9ks63ttAHEe9gvMFWdgHi6Nxxf4tv7TM2E/GkWgTM+1VQiBQPKWk+kamGMMv0Z686o6fYwI/+XygBV26PXhedHNqStxChRUsBkTTBzYCgKR88YzWBAijBxPic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(316002)(66556008)(52116002)(66476007)(26005)(186003)(66946007)(31696002)(16526019)(53546011)(2906002)(31686004)(956004)(478600001)(8676002)(16576012)(36916002)(83380400001)(2616005)(6486002)(8936002)(44832011)(86362001)(4326008)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUxPNFg1b3M0ZEdHSHBrNTUrOFQrTlBtN3RBYWpHR1ZCekNxblVnOFBOYVdT?=
 =?utf-8?B?d0swUXUwaXB6aTBIUWJkUFl1WkQ2UGVjdU9hUjdkb0lEcTIxS3hYZkdvS2xZ?=
 =?utf-8?B?U293TlNxS1d3bDMvU0lkdVlGZkZxYjZtcksvaVdEWWRFZWY0dWY0YmlLanJq?=
 =?utf-8?B?REZUZXdqeWlaNE82aTNNN0swcUVMWEgwa25GUHhUKzV1UW16Wjgvc1RtMWR0?=
 =?utf-8?B?RkhJWlBoRE0yVkxVQjFsUkV6aHUyWDVoeUcwSnBWakRrQ0xjSDl5Q0FVcjdl?=
 =?utf-8?B?ZXo3V0lBd0RFU1UwUFhYWkRXQ2VtdXhMSXpLUzZyN2tqMzlCZHorRVdVUnVt?=
 =?utf-8?B?R0NTWi92SENUbkJTL1NrTUFnbWM4VS94bTRLQnhSL3Z0MGY0T05CdTZYc0tX?=
 =?utf-8?B?TU9qR21GOG1QMmVMbW1CY0VHajlDZ00ycnVheGZNZmNnVXhqZkkzZC9LMU5n?=
 =?utf-8?B?SHl4N0RUUGIxQVpxMzFOVkR5WFRieE5pOE1qNGtQQ0RIbEFuVjNWYlF6K0xz?=
 =?utf-8?B?NVlWL29sUU5jZ1Q2K0Q1OHNkNUxodkdIak9WWDl4VWNodGQ0K0J3TWJPVWRQ?=
 =?utf-8?B?UWhqdXNyWko4K2RjMGFNU1E0REVlOEFhN1llN3hZenlCYTk0OFNISUxRbXAr?=
 =?utf-8?B?NXpaMXZWRTRCSDEycnJSS3dzd1c5UEp3ZExpVUdFMzd3OTRyb3pJZXBrQ2xD?=
 =?utf-8?B?SzJWbWo5Q2FmRVNady9sZVN1V2d1bG5sWjdvZnd4eDdWKzNPMXlXeDJoRkx3?=
 =?utf-8?B?WjE0K0NLRVZvMG5aOHBmWVFWR2lTdllkS1BnbG00NUtJbGFkYTMvTWdlSkFk?=
 =?utf-8?B?TDgyZmF0aUJMa3FPc3lTbjJGN1QzZUMrNDdXVlhEdmpoeUQ2bUFEenRuMDdK?=
 =?utf-8?B?V2dwTC83K2pqanJFSzRPNm8zYk0yRXg2VGR6TlZwaTRtVWJHZGJVdTNVVFRl?=
 =?utf-8?B?QnRpNVo5bW9yMHZ4WDc4SGd3a243bzhNV2pWQTV2Yi9TT091N0xCekhpS3h5?=
 =?utf-8?B?emp6OHBtRjdZd3FUK1p6TThnNWRFTmNTUldpczdlWGltR3hxbVBBVEgxTHND?=
 =?utf-8?B?SkJUSm05Um84L1BnS1A0Y2JtQVR4Q01WK004Q25zWm11R25DeTM1WDZnbGNT?=
 =?utf-8?B?a0MrL2xFcnBWMEthU3YxQ2VpbWZBK0xkRzVHUnZ1OE5BcUNwamJkdXNTTjdJ?=
 =?utf-8?B?SVVVZzlacFlOUWxZRlpOZjZnWUoxb1o1VmttV3pURDNCY0p3b3FCd25HUXRF?=
 =?utf-8?B?NHdjTlZBS1kwY0hYTWp6MHdjd2hXQU1ad2l1SmpsUENrZXI2R3hrTGRpSVUv?=
 =?utf-8?B?UGxxbGFHTmtoMHNCMExtOGo1eFUzd2VJWndGaXYza0FmbFpaMmhuRWYvTFha?=
 =?utf-8?B?WGE2S1g1TUJkOGRJVDlBaWlzV1JmVGNjelNpU24xNGUvTjIxL3kyYjlzVVBz?=
 =?utf-8?B?UVA5NHJyWGZLOVpKMEtSZTJYSWtJbU9lRno5YWlsd0tEZE95VCtmMlR5cTFi?=
 =?utf-8?B?czNxakJycDcyUHA2T2JiR2xMaWJGdW9DNnRLR2xjTWpaUDVMZkZ0WHE0MkdL?=
 =?utf-8?B?dW9BOHJINlhqandYRytaenZteDY5NE81SFdVcjBNbER6TWlZU3U3dDNZY0Zr?=
 =?utf-8?B?TGhoUS96dTFVUlg2OVlKL25TdTYyOUptRFJpNDJ1bnJSSkEvZHpXb1hON1Jn?=
 =?utf-8?B?dzVQaXl2aVBuWHhPVEM2em4wVndoUGtBQngxUlRwVXZ0dmVwQTlqa2lxYnJU?=
 =?utf-8?Q?p1k6bKVcWf949BJGCq5/4fV8KcxVbBFDl1RPy9R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6bde14-8067-4229-48c8-08d8e413eaa6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:29:06.7861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUbMfBC9K7sIn6WaS96Q+tTY9lHAWflE1/99RQNNSdAdE08u2Ji+pyQ9x2VmTkS0OeGyw1eP/R0jT/r6gqx+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: Philip.Yang@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-09 11:19 a.m., Jonathan Kim wrote:
> Add IH function to allow caller to wait until ring entries are processed
> until the checkpoint write pointer.
>
> This will be primarily used by HMM to drain pending page fault interrupts
> before memory unmap to prevent HMM from handling stale interrupts.
>
> v3: Scrap busy loop and change to wait_event.
>
> v2: Update title and description to clarify use.
> Add rptr/wptr wrap counter checks to guarantee ring entries are processed
> until the checkpoint.
>
> Suggested-by: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 49 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  5 +++
>   2 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index dc852af4f3b7..1024065f1f03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -99,6 +99,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   		ih->rptr_addr = adev->wb.gpu_addr + rptr_offs * 4;
>   		ih->rptr_cpu = &adev->wb.wb[rptr_offs];
>   	}
> +
> +	init_waitqueue_head(&ih->wait_process);
>   	return 0;
>   }
>   
> @@ -160,6 +162,52 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	}
>   }
>   
> +/* Waiter helper that checks current rptr matches or passes checkpoint wptr */
> +static bool amdgpu_ih_has_checkpoint_processed(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih,
> +					uint32_t checkpoint_wptr,
> +					uint32_t *prev_rptr)
> +{
> +	uint32_t cur_rptr = ih->rptr | (*prev_rptr & ~ih->ptr_mask);
> +
> +	/* rptr has wrapped. */
> +	if (cur_rptr < *prev_rptr)
> +		cur_rptr += ih->ptr_mask + 1;
> +	*prev_rptr = cur_rptr;
> +
> +	return cur_rptr >= checkpoint_wptr;
> +}
> +
> +/**
> + * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Used to ensure ring has processed IVs up to the checkpoint write pointer.
> + */
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih)
> +{
> +	uint32_t checkpoint_wptr, rptr;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return -ENODEV;
> +
> +	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +	/* Order wptr with rptr. */
> +	rmb();
> +	rptr = READ_ONCE(ih->rptr);
> +
> +	/* wptr has wrapped. */
> +	if (rptr > checkpoint_wptr)
> +		checkpoint_wptr += ih->ptr_mask + 1;
> +
> +	return wait_event_interruptible(ih->wait_process,
> +				amdgpu_ih_has_checkpoint_processed(adev, ih,
> +						checkpoint_wptr, &rptr));
> +}
> +
>   /**
>    * amdgpu_ih_process - interrupt handler
>    *
> @@ -195,6 +243,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	}
>   
>   	amdgpu_ih_set_rptr(adev, ih);
> +	wake_up_all(&ih->wait_process);
>   	atomic_set(&ih->lock, 0);
>   
>   	/* make sure wptr hasn't changed while processing */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6ed4a85fc7c3..87ec6d20dbe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -66,6 +66,9 @@ struct amdgpu_ih_ring {
>   	unsigned		rptr;
>   	atomic_t		lock;
>   	struct amdgpu_ih_regs	ih_regs;
> +
> +	/* For waiting on IH processing at checkpoint. */
> +	wait_queue_head_t wait_process;
>   };
>   
>   /* provided by the ih block */
> @@ -87,6 +90,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
