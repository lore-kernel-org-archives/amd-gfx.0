Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC128C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 19:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FF410EB58;
	Thu,  3 Mar 2022 19:52:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C2910EB58
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 19:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikzMlSSMKBMqvpc6V+Pr5IVXlZJH2CTo63YZ0jYJXXMbU8R3+o18630gEFUkatHWBwCXXtGVX5d6SyBqxL/F8Ev5Vv8wdGqmjv2jemXKsDXak4Zcz/Eb8vrwq46fiF078TP/CUjVNc35Df+mv0PftnRn+NOF2BxQzeNdm7pT0sXSHKRZ+pmpugMezJ+PcRyZaydxJb6wEbbRVTsvPIoyH2l/WcweAnxLv+INtNdtO/RM+ZUHsxBsvZSUvTo0G4BZ0I9npsI/h9ppT0B04G+/OIEvAUFABAR1F4IHp8T9/eBTzTuRgy5vIxGDZQbMvsWEoBp/foiOyzcGNQWHEP+3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pClovqKEJZEyWmFJL3RJxmE1wCiXHZBORUzbjU9dngA=;
 b=AzYFjxQMWcUwG3UJOWe5w7z40XJuqZj3LEOd1HJErxncfYTPsn37SL7pJN80sO7yijcsl2kB+b3w3mFE054oFX7ck84U398etpF7oQ07Ry+DHew92UYrGGGpL9g7jc6ysyfUy7srhw9WKt3/W5HpA4ng83noYy59akd29u/e3SVtGH2MMTk/4IfpO2LM+kU1Ofzvwk06w8B7WmMIbfnrc+hxbQrWtU/A8ZUNN2M3tPdI0Ag2+WivQqj6Zl3v+C21ReCB0sf/VwWxN0zh/NqYJG5cF0/9D2c8SBiU4+f9+4rV9LMb+MVTxxy678+KkmP8cue918y5isTLdBMIVP9t7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pClovqKEJZEyWmFJL3RJxmE1wCiXHZBORUzbjU9dngA=;
 b=w2I+3Qnnz9IOJKmHtohlSU4fqIJPeQhvZyp0LyKLdZqbmiRmgaHYN/CQaMrFluVRhQsvC/q9JAnwVLBSi0aelb3NYAcBb3rMfE2HVxkhPc/L/+yPZ4Me5Voi8xbdXvff6jW5ifXWKnlcpGW0I0SdctDyDWJ/ZJq11p6kwozi89s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 3 Mar
 2022 19:52:20 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 19:52:19 +0000
Message-ID: <3a1af5d6-4586-cce8-6c63-4f8ddc9d1c95@amd.com>
Date: Thu, 3 Mar 2022 14:52:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/10] drm/amdgpu: install ctx entities with cmpxchg
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-2-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7336beff-8313-4e5b-05c6-08d9fd4f537f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2442576C71198459424D2CC9EA049@MW2PR12MB2442.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdmRwm8FfxnGr/Fpo+ERFmHUJHz11dIx0rkrdzLrtMI5HCMSHqGpWYZN7wJma+URu3Dr3AgWJBDmw6YrwObzCxSMYcci2XNuppduHbGlpZsr8iMqNI+eD6JhpJTe35MIZvY8MvUoOZYa7Fi6BTFP9GM3lYC3m6m6oyIpzm5kv0HB7jtcMBtRhs09MjWRiHKT82WpMvTBjK8QNx8m8hJHs0k//kRfw/otBEBav0yqx2r3SgfkAXZ/ugmy7+VKklQG8wJdHKhVNVCRLrXCDMxYGpMD12gnVo/9dVFAuh+R+MEBNa8nLoqyrHaJjqFROzVNYWn33UM+oUSvhU6UZvetpNTnNzCnkbnnFriR6CPTv2KY8MjtjRKxgZLqJaKOtRTdqVKLJK7zakN5o4f8E9SLtARZ7MjAdXkSLAfXys7SZn06/JgmUImFpaKQ4lPtLmziIUh+qBlGt6wvqbWTqfcAjVTz0xfSnWRKMLpunrjryIOScHMFKYGxGEfpdD6wPuCu/d+fNB9ruPjnr6PTLpR16pZ7di+7asnx6S3+BoiDvlFF0VxYCgsXJG5EpDsRIx436CpfrqUOuTFij5A6+4Dutqxa+PNfApGFOcyYFCe0M5kt8LWypF6+UhtHZgrz7hhRFVUb/z3JXlcXkgZLMWQqkDl4vtIrFwTHI9T9HymzG3fV9Gua3FKyTThkmYT6C4r4U3BvPA+b/fqdm1DZEJ5rFsKQMzhwBggSPsIqxsxCgRzJaqhLGD8WhfpUI5kQAGAorQN1F1J0Y4za5wm9wve8wWDOYVXKjkM3VrPeUfJQkk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(4326008)(83380400001)(6486002)(31686004)(66476007)(66556008)(66946007)(31696002)(86362001)(8676002)(36756003)(53546011)(6506007)(6666004)(8936002)(6636002)(44832011)(38100700002)(6512007)(316002)(5660300002)(66574015)(186003)(2906002)(2616005)(17423001)(156123004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZ3TGQ0M3N3QUg2UFlHL0h5VEZrZmRTZGhXU3RaY1I5OHRaSkNOOXlGdjZV?=
 =?utf-8?B?MzlFdzlOUnlIdDJFRitnemhFd0krS3BpR0IrRkRjTEh6K2FVUlJwZjJJVkQ4?=
 =?utf-8?B?eWZDRkFwVVB5SkFRNGtVU21nbWZsTmZGTjJrMkRra0Q3SEJHOEZQekJzOTdm?=
 =?utf-8?B?SnFsV0d6RFRVRXlvMHc4U1RqcG5XL2VDSXV3aDlvczRScmNqUmNwVG5KRWZs?=
 =?utf-8?B?VnhXYjd6bkN3WGwrTjRMMEpaNC81TjJseXUxVmtJVEkyMWZSTnhEQitxeUo4?=
 =?utf-8?B?dUhBTlF3U0dnd2JFKy9Sck0zZy8xYytZeEVoWmx4SEhmL29GZGN0Rk8xWEUv?=
 =?utf-8?B?UE4wci9tdmZWc0JISFNoSXpqK21UTzN3WGE4WVBGWU5TYTc1bW53MzBwelpn?=
 =?utf-8?B?bjFkNHYrdlo3M2ZiUHhpTUpJSUNPb1A5aVN3dU5SVWlhd1U4R2VVMGQvSzZm?=
 =?utf-8?B?akZ6V0JQRFhsYTdGcmduYUFmQWFCSllDL1ovcjRSSHZIVERycCtzRS9aM3d6?=
 =?utf-8?B?c09MMU91WnJzY0p1aWhrZnZOWU1zaXpNWVBSNEhydGc1V0Njc0tvU2lRZDI3?=
 =?utf-8?B?SmxGc0lWbjRsa1pkZDdpUFI5QUZLNXpCYTQ1TEtEMmVWWmZBbzFXZGtLdlIy?=
 =?utf-8?B?cEZNRnJMYk5iNlV4Ym9Ha1FrQWZLMlVhNXp2dHFBV1EvNHVqT2VnNlpjcklJ?=
 =?utf-8?B?Qm84SThwUHBNSzlLZWR4S1ppWHlPQmRzNllqYXRhNzBxN2xqSFZQSG84QlBn?=
 =?utf-8?B?RW1jQmtwdTZ1S3pUY1dtVmNNYlZTNUoySDRXcFJDdUpVWmswRlRDcG1RcVVR?=
 =?utf-8?B?endUOCtPZDJya1R4Rjc3ZmRnUU91NHdJZ0VwelNSTWV0REkzMWhtdFVCeVlF?=
 =?utf-8?B?aUxieUtrVFZrc1RXMmF4RWhLU0VCY2xXeW0zc0lEMnRNNDFaZVpPSFFKMWVU?=
 =?utf-8?B?VVNKUWdNUVpoczRYMGxnZ3Ewb01TVlZxTEFaTnVtZWUyZkJOU2JqVkMwbFQ3?=
 =?utf-8?B?UmVweW4zQzUyVmVMY1FhUjRFWTdHdHp4TlZVSlI4QzhHdElVUzVTUkJrMGxs?=
 =?utf-8?B?MW44a0lVZHlCWlI5dmZnZ2FRdzJIWXV0WGM5SGpGaUpRMkNSN3EwTFM0aWVk?=
 =?utf-8?B?aW5RKzc3cEdTbk83M2lqZ1E4eWRSc1I1NzF6M2tERmpzLzMyMUl2TlhnY1dE?=
 =?utf-8?B?dW1rS0prYmlrdHJnSDBaNG1aaEp6VDdmelFpTDdjcTZZZUxYdlhiQWszdmda?=
 =?utf-8?B?dUhHTHVhOGE2MW5MTElTUGE0WnA5a09JdC8rZEpZY21CU1BPVnRWTy8zeUJn?=
 =?utf-8?B?SzJPUUpmUi81QVhNQ1VodGowZnYvWmN5c0xpTHFpWUM5dVRjRC9YT24rQ3Y0?=
 =?utf-8?B?c2tGSkhoakVJd0g5b21BcEpGUkUwNnBQbFRvL1NmVWZzTGNQUkRtb096Tkxv?=
 =?utf-8?B?Zkk3eXpmaDhhMkZlUk83ckJTVEU1U1NUbnlnemxXT0h4eXNWN04rVUEwV2ZD?=
 =?utf-8?B?TFVkdXpJbk5KZ2VHeFBHcmp0MEFkbTNOa1ZHQUgrY0ltRHRIelg0QW4yU1gr?=
 =?utf-8?B?WDlmVVJwYXdZN2tFWTBxNGNBQys4bzRGZnBLZ2dVYnh3RnUvRkdpSVdxcmw5?=
 =?utf-8?B?RnBhZlA5S3RTZW9MQnZXUXR0cmpNQzNiM1J5NXl6U1JyOWVaYUFBb1FjanBO?=
 =?utf-8?B?bTg0L1BMZW1vMkFKWGJEUUlCb2srTHVMakNaVlZUaHpFb21INVlxeGNzd0o4?=
 =?utf-8?B?YTNxOXpPcFB5Zzk5NTFhYUhDK1pISkN1NG9VZ1NEVTVtd08zRi9tVlA1Tkds?=
 =?utf-8?B?UDdKVEtNcmpWZGxneGhWMUJvS1p2YUNyUHUwNndQai9MSjE0T09nSDU5VXll?=
 =?utf-8?B?NTIwS3RRYVFQZUtlcHhwYTJZUmQwaGwrRkc2OTJhUHVLbFh3ZHN4ODFhU0M5?=
 =?utf-8?B?NC9vWGxtT3VMVytCY2lzalRodXlLNGVzcE9ha3U2OE5HbkxWeHNpUHZod01V?=
 =?utf-8?B?dDNJbVpmVXNneDNvLzIySEVreFVCZnJyVHB2QXNaaFJHelE0ZDdnWmhBSUNw?=
 =?utf-8?B?NnUwbkxDVXN5Y1l0YXpiVEFnSGFHSUxLREVRMU4zby82REtZSlIwYTNoWFRl?=
 =?utf-8?B?dmdoL3BzcGV1OEl2K3Nta3BNbVhBYXp4QXlaRUg4TC9RaklwblA5MUsvMDRW?=
 =?utf-8?B?S0ZSZVlpUzNxUENyazVkOUM4T2VEUWxWdVZpSEU1ZFcwdDJOODA3SXJuZXN3?=
 =?utf-8?Q?wawt8R1Gbs0ESBB57ICyBikr7QVMwdbyaE1iFl5pFA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7336beff-8313-4e5b-05c6-08d9fd4f537f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 19:52:19.7369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRuQwPx2rXlF7x16PbxHyAiV04cBz9uBfTWuqfKigE+hCPeBGAJloZCIbrYC4KGudJwmMYsxtA66VrUB49YwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-03-03 03:22, Christian König wrote:
> Since we removed the context lock we need to make sure that not two threads
> are trying to install an entity at the same time.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index c1f8b0e37b93..72c5f1c53d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	if (r)
>   		goto error_free_entity;
>   
> -	ctx->entities[hw_ip][ring] = entity;
> +	/* It's not an error if we fail to install the new entity */
> +	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
> +		goto cleanup_entity;
> +
>   	return 0;
>   
> +cleanup_entity:
> +	drm_sched_entity_fini(&entity->entity);
> +
>   error_free_entity:
>   	kfree(entity);
>   
