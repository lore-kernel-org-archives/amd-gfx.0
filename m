Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C11C4708E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 14:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F81461003
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 14:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F81461003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAED6E1B7;
	Sat, 29 May 2021 14:11:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474E86E1B7
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 14:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkgwqb0Q4DbrclFI8jqsNJnJRj3wIxsRYs1xa/biKpxVswY5nVnck6bMnNDIDoLkk5G19xjmKGjA71iiL3MPDTEVPFmJ1+4TNfS/b5tmGoVDqGb6XUalP4mOOeszZ73e4CJFOcuSjHL//5UBYwk91+vrvyaZnsZUIGJJRGhjKxWyPBnDEOvkNLPeS3HEqFtVcV90ArxTv2I/Z0lMyM47g842pvB/mMXBj3tdraXGxM0kw90i/JQhfFzBdtCF44CVivgkvfiEIrjftegNZlpYntl0LFxzTpUq01i0xZTbL3cHtgfMZ2AkIrJoBkcQvPy6v0IVk80hErUhFrn9ZJl7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0+XlqNkgwoCp6N4EwM5SF83bY22X3liIAH6eAHsOVg=;
 b=j9vx3HrsGu4QF71lrx1Y5jHiyPdU0ZrY5523nTfgEbzmwzM3uEYcqRF7wRnklWnjy1zNjSS05k8RhmTFI2rD2qO4/ZDeo+CNgbxlKIgWxv3qnHSq0r+dcyBN5r0YdvFSUgphADkW8s5B8TRdJEvE8gxv+OCaQh3+mVrv3NVvN+4XfSE3JL5rOc2Qy9PZPdiacayWqCEbWZfSfNU2URhJsRcDvSVZS/iGjBnVOmms6S9DBJLv//iike13PA8LoAeFtdx5hNI9U2zhbE15sE6IPkdDuGvYFpmw2MY0d57TS+IxHELt+mDCq4KSMHzDUEmtSrbLaP0RA86Xb0d1qH0SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0+XlqNkgwoCp6N4EwM5SF83bY22X3liIAH6eAHsOVg=;
 b=2xHWyGtoe+23EpDfiwm7x2ShS/4DYWnii+f3mA/ZP6n8kWD0SPoLO64AX8F92KlENe2MCyZi41UPpKlGDeqouyqwwid74vN231PpJzZ6HhAj6MzIzT3TpamATWEETDEt1nLxprqgKXb8bftu6BXjcUFMEzeqv3WZbVRVVc+KbRs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Sat, 29 May 2021 14:11:00 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4173.027; Sat, 29 May 2021
 14:11:00 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: optimize memory mapping latency
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210528204906.245661-1-jinhuieric.huang@amd.com>
 <20210528204906.245661-3-jinhuieric.huang@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <a8e3a70b-825f-89e8-38fc-e54c7db383ca@amd.com>
Date: Sat, 29 May 2021 10:10:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210528204906.245661-3-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:889c:5e2:3561:6b91]
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:889c:5e2:3561:6b91]
 (2607:9880:2048:122:889c:5e2:3561:6b91) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Sat, 29 May 2021 14:10:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0326246f-dbcd-48b5-3ac4-08d922ab9600
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15295A5B7D6FF382596E3D4B82219@DM5PR12MB1529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYhjRToDsyPRQR/sHMCLYzvcMtq/mv38TCif3WLo/O3jGyYJxQQP3wjgUl8F30fu2yNenv6rSFyl4AjAoEBDQY7TNL/70YKaY4yUYnx995RkNL7baVRQhb1wnt21RDOFAsw7JrX+SV0DQhE7sdsYtYLi+phChTDobtOfJoQXEMdFJJBVEOevn7sI9qVo8SogHn6V1xUsb6fU9ODdOjEFFXFliZzrIyMds2bv5jDYY0b5pW5Acng/cfaPnyTTT/IVCfDYShOxxKGrlTYZmya3xK9TyGqpFFxTVPuWhqq+weQo2H/C8N08mS5lf0yE2B1wWog3mYlljZMQ8amO8GR7IYWvfPLZYulwihEc3trX7h0ijXCWw0fKDUKoP+YVcoRB6hqCI3WvqbKcbsULWMLXvm+gwxJL4KsCOygAAm8kfNmgJLflwIVizKKC4pv+m6xVCMWo2i/GZZ0uVQ5L6ZUkfP/wn/lFaI34nCQTqwQ2+p6Fm8TqKiSiMZ2KNLGlCAKaQ0lmPCW6Rlrq7rSbwaUdOA7V2QAnkiXZpm9V8PU+h/JPiaHOBq6MGRJ8Q0QZ/BC+s8XV5QbXKFT6kfoSLXVMF/lM26eczNZ/yxtHnGkupcz7NJBtEAhJFVW/uG8uK4R04NlA0QcHgoRgAZve/1qF3bCj9ZWttE6wNIXkeAAPgrTv5jLXCfRuoog9rFW6yST0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(5660300002)(31696002)(16526019)(186003)(66946007)(66556008)(66476007)(316002)(53546011)(31686004)(6916009)(36756003)(6486002)(86362001)(2906002)(2616005)(8936002)(38100700002)(8676002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFpZM3hGWStZYUhXYWt2cGcydkt0eEk4VFE1bUo1LzBHL3lCb0I1MTB3R3V5?=
 =?utf-8?B?RndHelNHa3kyUm1wdTlGR0wwamNBR0xFdG83SlljVVVkb2V0TE81QkhpR1ll?=
 =?utf-8?B?dXJXVVg0REZzc0RoOU90VVBmTkZ1S3Z1MmJqeWpOT1JCWTFabVl5bWFuMTVz?=
 =?utf-8?B?Myt5QXJJUXNWY2Q1eEw1K25GdDF4anBlTTVpUGpGcEFMYUFNbXNRVFZVdkdw?=
 =?utf-8?B?OHdKekk4eExYdUZtYTRHYjBWVTZTR1gzenUraTJZdDFtUXczNjc2VHhKcXRW?=
 =?utf-8?B?MTlFM2xBMHVqSHFOUFk4cjQ1MElzOWtJVVZCWmZCMnR6c3dJNFZQa1hXVFpF?=
 =?utf-8?B?RmRiRnlzRU1xU3JtaWZwMDBDeU1jMTJlZGZOSTV0SldYdjBjYXRYY1BnZUtW?=
 =?utf-8?B?YVk4N3ByUnJDRDRNSlBMQjFwc1IySG8vWFdxVitzUWdudmVwak4xaDJ1dWlY?=
 =?utf-8?B?QklSUUtleUpINUpiNjIvMjFobmhQS2lQZGY5TFZBUktCWWhZbmU4MFlvOE1W?=
 =?utf-8?B?UVRqV2FsV1RrRXpGSThMaGNZWDJvaXpjQ2VLRFZwTEJJVFlqbUk5emo0UjY5?=
 =?utf-8?B?NW40KzBnbXZiZExObi9od0UyWmMwd3dXU3I2cGVRaGN1cVgrbEMvZWxyQ0Iz?=
 =?utf-8?B?M09qZi96ZjcyaVNDbE5RbXdnRHZsTXBUYVlvU29aaWozMFZLUGJMNU1yZDNt?=
 =?utf-8?B?Z1U1ODY1UWlvaDZCdjJuZUZRejhzTEV4VVR1RVVhWjY0U2lkb3FCdjdyc0NW?=
 =?utf-8?B?c04wSU9qZ3BhbHg2Z2lsdXhBTFJtTm1uRFdGamRiWU1jVTJaRlRpbzFtcGhm?=
 =?utf-8?B?bmN3L2gzUjY0L1ZabmcxNzVGcHUwQmM5M09qbmNHNDZTS25PU0JsY2M1bjky?=
 =?utf-8?B?VWNVSCtUK0krMTFiaGdRTjMzSkhEaG1ZV0cyQWxGQWl1aktBRFU0amJ3NTEx?=
 =?utf-8?B?QVB3UURyVGZSd3F4VjdkbDhDQXRvazRWekpwYWhyem93M1RZYTQ1VG43S2Ni?=
 =?utf-8?B?Q0kxcHZUa1BQQkg4N3haK1VQNExjdjdVQkc4SlkrVnYydmdXa0tBVXk3QURB?=
 =?utf-8?B?a2lWZ0JGQ3RyZlloa1ZISFpNZEltMjlhd3hHWDljd0dueWVsZUJwTy9sWlAz?=
 =?utf-8?B?ZUhvR3E4T2VkTzV0aGZOQ3V3dkdjMHRuQjkxblE5elVjVVFnRmExWDQxQ1U4?=
 =?utf-8?B?c0h6aWtOVnJhNmtObWhYNXBXR2d1cEpaOTc0NDdDWHdtZW5BSy9ucEg0ZzZS?=
 =?utf-8?B?ZlFCYk1YaEhBRHN0OHNQMU4xb0daeXVsVzRUYW1PdThDYWtQbjdCYnpCR0Fr?=
 =?utf-8?B?M1N5NFRWVW03aGVqUDNzaFp0SGgvQVo0Zlo0NmJtMXUxcjNwOG1YTEtucHo0?=
 =?utf-8?B?a2wzamZQbUtuTnRZRTB2a1pxY2xFNUh3c3NELzBoakFVMktzbXphdEdRRTYv?=
 =?utf-8?B?bTN0eEdnaXRKRkZCNWJVdTFqbDh4NkoveTVZdjU4Y0EvQlpkb1lSamhNMW1v?=
 =?utf-8?B?UmRhYStoN2VDbWVRak5XWHNheVhUMXIxU3JhbVlybFZwd2JlQVdaL0RGNEZv?=
 =?utf-8?B?OC9RSDZ2Z2YzSmRjT0tCK1VGc3h4TFEzSWhobWVPNGNJWVlhOThaMHdBK2Np?=
 =?utf-8?B?MjhxODR6ZlVUQUlxNm5NS25nYm9TTkxnZGV2MkVZVXFiV3NpRVQyQ3Y5VnRO?=
 =?utf-8?B?bjlWQk1jbTBNSUNOVWZqR3lseER6ZXB5OTFDR0JQK1ZPZEdzSkE4bEc5UFA2?=
 =?utf-8?B?OE1uYXk1RktuM2VzZU1lcEkyemdjelp4RXc0SVEyTitaVmJzNFFXcGJ4QnVE?=
 =?utf-8?B?RkJZV1BrRmJkRGFjTzdsT3czdGlMUEN3MkdKK08wK0duVDkzcXdUMFZGcUN3?=
 =?utf-8?Q?wUZlpimxTFpdY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0326246f-dbcd-48b5-3ac4-08d922ab9600
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2021 14:11:00.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwdAcn+VGYraNfE8/dglJJR0txeYKs1bkrRuddPUQFQ3OPivCDG+Kfp3AAxXVJ5QC/n4VBtWE+9QykSWPwzPUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore those patches, I find a better resolution and will send it 
out later.

Regards,
Eric

On 2021-05-28 4:49 p.m., Eric Huang wrote:
> 1. conditionally flush TLBs after map.
> 2. add heavy weight TLBs flushing after unmap.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 24 +++++++++++--------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  4 ++--
>   8 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2560977760b3..997258c24ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -85,6 +85,7 @@ struct kgd_mem {
>   
>   	bool aql_queue;
>   	bool is_imported;
> +	bool table_freed;
>   };
>   
>   /* KFD Memory Eviction */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 385c33675227..8ac0d849fd3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1132,6 +1132,8 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
>   		return ret;
>   	}
>   
> +	mem->table_freed = bo_va->table_freed;
> +
>   	return amdgpu_sync_fence(sync, bo_va->last_pt_update);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 36e7f088d4ee..0e0f27f779cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -87,6 +87,7 @@ struct amdgpu_bo_va {
>   	bool				cleared;
>   
>   	bool				is_xgmi;
> +	bool				table_freed;
>   };
>   
>   struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b1bdc89cb5d1..57793483c8d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1897,7 +1897,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   						resv, mapping->start,
>   						mapping->last, update_flags,
>   						mapping->offset, mem,
> -						pages_addr, last_update, NULL,
> +						pages_addr, last_update, &bo_va->table_freed,
>   						vram_base_offset);
>   		if (r)
>   			return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 960913a35ee4..c45ccd1d03c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1658,16 +1658,18 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   	}
>   
>   	/* Flush TLBs after waiting for the page table updates to complete */
> -	for (i = 0; i < args->n_devices; i++) {
> -		peer = kfd_device_by_id(devices_arr[i]);
> -		if (WARN_ON_ONCE(!peer))
> -			continue;
> -		peer_pdd = kfd_get_process_device_data(peer, p);
> -		if (WARN_ON_ONCE(!peer_pdd))
> -			continue;
> -		if (!amdgpu_read_lock(peer->ddev, true)) {
> -			kfd_flush_tlb(peer_pdd);
> -			amdgpu_read_unlock(peer->ddev);
> +	if (((struct kgd_mem *)mem)->table_freed) {
> +		for (i = 0; i < args->n_devices; i++) {
> +			peer = kfd_device_by_id(devices_arr[i]);
> +			if (WARN_ON_ONCE(!peer))
> +				continue;
> +			peer_pdd = kfd_get_process_device_data(peer, p);
> +			if (WARN_ON_ONCE(!peer_pdd))
> +				continue;
> +			if (!amdgpu_read_lock(peer->ddev, true)) {
> +				kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
> +				amdgpu_read_unlock(peer->ddev);
> +			}
>   		}
>   	}
>   
> @@ -1766,6 +1768,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			amdgpu_read_unlock(peer->ddev);
>   			goto unmap_memory_from_gpu_failed;
>   		}
> +		((struct kgd_mem *)mem)->table_freed = false;
> +		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>   		amdgpu_read_unlock(peer->ddev);
>   		args->n_success = i+1;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c1bea1f7627b..a4920bc5cfbc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			qpd->vmid,
>   			qpd->page_table_base);
>   	/* invalidate the VM context after pasid and vmid mapping is set up */
> -	kfd_flush_tlb(qpd_to_pdd(qpd));
> +	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>   
>   	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>   		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
> @@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>   		if (flush_texture_cache_nocpsch(q->device, qpd))
>   			pr_err("Failed to flush TC\n");
>   
> -	kfd_flush_tlb(qpd_to_pdd(qpd));
> +	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>   
>   	/* Release the vmid mapping */
>   	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
> @@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   				dqm->dev->kgd,
>   				qpd->vmid,
>   				qpd->page_table_base);
> -		kfd_flush_tlb(pdd);
> +		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>   	}
>   
>   	/* Take a safe reference to the mm_struct, which may otherwise
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ecdd5e782b81..edce3ecf207d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
>   
>   void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd);
> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
>   int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4ab9da288f90..a03373743a3d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2161,7 +2161,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>   }
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd)
> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   {
>   	struct kfd_dev *dev = pdd->dev;
>   
> @@ -2174,7 +2174,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
>   							pdd->qpd.vmid);
>   	} else {
>   		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
> -					pdd->process->pasid, TLB_FLUSH_LEGACY);
> +					pdd->process->pasid, type);
>   	}
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
