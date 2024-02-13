Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C270DC4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 21:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4796110E928;
	Tue, 13 Feb 2024 21:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAEKB2nz";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DD310E928
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 21:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7ylnQNnd7yHeRXAU0b8awvoPD2VYL7JwujWos+qNWxBKzA0iTSt7m4GNJqkDtNe8x9ac1FbEi3h+mPDAkkpvxiEKz6o5B8rcKRQCekonxaNBscQwSGnVP4AjCO5laYU8mOJenDPeukE/29dqcuZjm3MYxfbrjGv4aLPHtyM1O7hiA/Iz4P4sm30gU0oKcIV7snC7sC/KB/u5yClhHZqS05+bWSJdIuf5e85V6kCXNvj88pF9ebT9NZMqjXTGVgBQEY2P47XnGwrvv+PD9YbUiIslVSNd5qMUDEQw/ehxz3+rORIYb9nLXxL9hXie7EPgaJu4tNGurc+kNmup8P5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16WSYnmlLCf4eJaKyozEhk3LWHi2i9LGMIRArKQK+kY=;
 b=FfPtTDgVAkXRXPfBr7uhW3ey/FEGu/sItrYT/WykhbqkgToyVQkJdUMbsWvqwxTCLxmH6IruJnv+xjG7s1E6BKjS6GN8jA5YbzHcoZTHLOz1wyLyrNtpncjK6eY5EiQXxLX3pZwz5B+4xnzmKrEFcbR+d/gBzqY9FaouPdAneAy54N71vrNbZ7XyzBkCT1/WFxdRP/kfhpVeMwpZlnfYms0hFQ832XbtKoypU1cbcd5lLk4dLYQFQoGum9yrpsqceJYO4VxoVCBCAZApeoq1/yjWPV0rY88WGfQHFaB5METnhm5M8JZ3auC7xa9SyX446EL0FpnfyJNYchczuiODog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16WSYnmlLCf4eJaKyozEhk3LWHi2i9LGMIRArKQK+kY=;
 b=bAEKB2nzrd/I3EggIJGHiF+prNpupcT7AEbQJG5KL6BB5i79oXWK/16bFK1UMYwJN1idHGjYye5LtRWvuBd3TgHWahqEfwZhSRYS3GCtXg5nonttjtcRJjvFzFQ9MN9Dydyg5O8GrRQrDwybUMhAQdZPxpGfnNFo3YkAtY2mo18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 21:44:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 21:44:27 +0000
Message-ID: <1ae5a45b-6a33-456b-9824-1a856fe71a07@amd.com>
Date: Tue, 13 Feb 2024 16:44:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdkfd: update SIMD distribution algo for
 GFXIP 9.4.2 onwards
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240213213934.1086279-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240213213934.1086279-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5f4798-eb5e-4308-a1af-08dc2cdcf398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlFn74lyCe1I0gsNm4g+TdKINmMvKP1lYWM3WEKgvpr/m05IH5XNY3wJ1l5Fixkh7ogxYDnlLZyWMNTfWcFSCuQQqMu77G/aqNXZ+5wt72d+TKvl0IdKqa6y5RU09sLsk3hEKbG/H502XOtEFdE2b+i32b9SEaiqQD6dYxphVhN9R7OgfmB2AzRTT7zHC7ISfq6dOSC+OKTiO9E/6CciclCzm79VZDUTuoRaX7AkAYbCl89JX5WpXhfKU+VFwOVGluhCNIsz8rVbu6Di2DPUK19jVH0bAao9HNXJPBk0Wjj4hFsK4/3gUNEJv1PofUOHSz6Z6SHG8YNRR8Yynz7OcHZnVmK1mtUXFm+hdlBswvdcDQynaxpckImAKJLS6YAQHo7iP+ba7a1UgcqSz5U6JDE1+11bStYDy8feFB7+qKVXpdb5UqxFmDFjqHBBjHe1mk4NV9LwMjC9/i5iYF93QERNutSlW/iwBqQib29goqZ+uCaVfNjjoAnihDm2r088te5/AktmXLl/Fw/VxW5APWpkeYjpe5PGLSuus+GgT/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39850400004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(41300700001)(31696002)(26005)(4326008)(8676002)(8936002)(66556008)(66476007)(478600001)(66946007)(966005)(6486002)(6512007)(316002)(38100700002)(44832011)(2906002)(36916002)(53546011)(6506007)(15650500001)(5660300002)(36756003)(31686004)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRTTXFKK3pDazlRMzVsTEkxVU8zRlhoLzdXdkZnY1FKZ0JkVjVvb05iendM?=
 =?utf-8?B?b05mTzZpUTEzUVRtYU83dVEyMWZPaDB6MmFBWHRFUnY2cW96R3piT3FsQWp5?=
 =?utf-8?B?MjFlNHp0cjBlVGdBQzgxbG9XZVVZb2VGdXZwTUJLSjNYM0g2eWFkWXpHUkxO?=
 =?utf-8?B?ZFBER0VhREsydGhQZk1WcXY4RkVHNHBtd0dTaWtSV3Bsb3I5a0xkN202Zk0r?=
 =?utf-8?B?NmtpN0ZJYXdKMlc5TzdrMk9rMGUxS0VBNFVsbVlyeDJRN2t0RTFIWHB2YzF3?=
 =?utf-8?B?MlNzbW9RODg2LzVzRFRyKzRNckQ4Mk9pQUlRaUUwN2l0Q09XMU0wa2Znc3Fq?=
 =?utf-8?B?SXJnYlBrSnNlVG9wSFRhSDJSWi9nWjVQeDBSYTIwOU1Sb3F2WlpFSmtZTCtQ?=
 =?utf-8?B?N3lUaTU3RjJ0MG5EeUhrTlRWLzYxRjQ0ZUhCV09BRDRzWE9BU0l1K2MvaTdk?=
 =?utf-8?B?bzFvL3ZjM0w5Mk9kU0ZTN1Qwdlp3UEZzN1NiMlRJVVRHMklkaXB6VHAvVGFt?=
 =?utf-8?B?ZXNtY0VOaFZHRkRMaE92UWxSUTc3cDVxY0dqRVZBWUxHZjczVGxzcmFETVg3?=
 =?utf-8?B?OVNkTDhabEJxZnF6TjV1NmJWYXpsaStYUm9XWFV6aEpNWGsxUCt4cmhNaENa?=
 =?utf-8?B?YzV4Zkw4OVFuRnhkMmZDdWEvaHdJdEpFMTNnZVI4bGloQlJmMXEyUG9OQTZw?=
 =?utf-8?B?NkI5VzBZMkhCMEpKTnQ4cXJGd0F3S1p1M2QrSHlpNzdWQVMvTjhaMThXZHA3?=
 =?utf-8?B?OTIrMUIwSnhUUHZrV0piV0RWOWxnWXlhMXVpMjJMTnJndFkvaDBaK2NTMEVL?=
 =?utf-8?B?SVFoc0NwS0dkMkE2WTN1TjVOK0YwZHM5bms5SXRkUG9kN2crdjVaT2tuWGFi?=
 =?utf-8?B?bWRGWXBtSmozVWIyRERZRkxqbWpJOTFKWHV3bTVWMENUeTdDb2UvT0V4SmpV?=
 =?utf-8?B?bmJ5bTdGNDFNZnVWZlFDS0dnUDVPRU5JQi9OWXdueHc5TVduUnFVay9ITzdt?=
 =?utf-8?B?ZTluSUZrL0NWUktrYXRKZk45d2tnNkg5T2xwUjI3S3ZzaXdJck9QbU13ZmMw?=
 =?utf-8?B?UWZkcW9oalBCVkJoeGUzcWMwTWRhVi9jRHlkTlY4Y0YwUWJUSnRLMWJ3Sytx?=
 =?utf-8?B?RUhlN2dEWWNTTGwwUThvTXlYTml5Q09NaE5JMUxmT09TMVZ3TzdiY3c4YnhP?=
 =?utf-8?B?QTNGRTNvNk4xNnhCdEpWSHRxcWtONmI0ODBJaS9LS05xOFllaS9iSlNVTE9R?=
 =?utf-8?B?VHpCVkpOTzBISGxHNGJza1lXR2hhejZCdGhNMFJ6Vk51VlIxUHd5RTlnZXR4?=
 =?utf-8?B?alN1VnU2S0FlR3RBdTA3M0JHU1ZzZStDWDBqZmN0WHJmaUhwczRQTTZHTWVJ?=
 =?utf-8?B?N05Ub0Nka2x5NFZwZFpyVFVveGJSNFMweE9hUXhkQU1LNk1BdkE2Q0Q2eWs5?=
 =?utf-8?B?RUExbFRGRjhTRlRaK1YwZXRmdVR6VEhRNGV6NElycFp3UVlHN2RkTmJVdEdu?=
 =?utf-8?B?TWlObGtmUWk3TUsrYzFWQkpUUFhCenc0NW0wbmpFcTRheEM0MkJmRWU4V2xq?=
 =?utf-8?B?eGVVYkU2bTUwZEdwZ09sYkxVRE1YVlZya3ZNdEFSNDZlQWRacGVUYTBaMjlu?=
 =?utf-8?B?MGNsY3BDcHFCSDNUWVlKazkxdVF3S1VqNVVhcS8rNFc4S3h2ZkxiclZqeTA2?=
 =?utf-8?B?aTlQMTZab2R5WnVTL3JTUVZNSVVHM0tmeGVQS3VMS0FlMGkrTlF2MUJGSlBY?=
 =?utf-8?B?ZGxkNzAyYTBxTGYvY3dqRS8wTEl5Q2FVR2pMVHlMOWdDRExMdElIVENJSkhr?=
 =?utf-8?B?b1RIVjVqbzZCcDdMNE5VbkVIWUNSZ3NjRFNZU2pDWVo3UGJzOG4vRm00ajJK?=
 =?utf-8?B?U1dpK2V4L21JS0ZFdEozNDNES2g2MGwvMTBNUzA3RUpYK0d3bStmRllidFFC?=
 =?utf-8?B?OU5tWmU0OFpMWWJlc3p1eFgyRjQ4ZGZsZ0tiRnlmSmQ5UDlIVm9wWitQd1c4?=
 =?utf-8?B?NFNiYjd1NjFpRU9uc3BVaWhlY2RWUVIvNXJCR1dkejV4UVBBOTRIcEpFd3Rz?=
 =?utf-8?B?WVpwRm9NT2FpWHpET0NhcVhWMlluTzBwRW9iL2dyUmdWNGdBK1BiUGNiaHRS?=
 =?utf-8?Q?WA2cLiobFNeYJL4B771ThHBvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5f4798-eb5e-4308-a1af-08dc2cdcf398
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:44:27.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvGMaIKZ0ulmS0gq+P3JAZ5GFawom/lg3N120SKkZQqNkpg/17CEXz93SHJNcELM4PWCavGPmEfXA/tbLQDXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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


On 2024-02-13 16:39, Rajneesh Bhardwaj wrote:
> In certain cooperative group dispatch scenarios the default SPI resource
> allocation may cause reduced per-CU workgroup occupancy. Set
> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
> scenarions.
>
> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> * Change the enum bitfield to 4 to avoid ORing condition of previous
>    member flags.
> * Incorporate review feedback from Felix from
>    https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg102840.html
>    and split one of the suggested gfx11 changes as a seperate patch.
>
>
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>   3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 42d881809dc7..697b6d530d12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -303,6 +303,15 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   		update_cu_mask(mm, mqd, minfo, 0);
>   	set_priority(m, q);
>   
> +	if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2)) {
> +		if (minfo->update_flag & UPDATE_FLAG_IS_GWS)
> +			m->compute_resource_limits |=
> +				COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
> +		else
> +			m->compute_resource_limits &=
> +				~COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
> +	}
> +
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 677281c0793e..80320b8603fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -532,6 +532,7 @@ struct queue_properties {
>   enum mqd_update_flag {
>   	UPDATE_FLAG_DBG_WA_ENABLE = 1,
>   	UPDATE_FLAG_DBG_WA_DISABLE = 2,
> +	UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
>   };
>   
>   struct mqd_update_info {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 43eff221eae5..4858112f9a53 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   			void *gws)
>   {
> +	struct mqd_update_info minfo = {0};
>   	struct kfd_node *dev = NULL;
>   	struct process_queue_node *pqn;
>   	struct kfd_process_device *pdd;
> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	}
>   
>   	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
> +	minfo.update_flag = gws ? UPDATE_FLAG_IS_GWS : 0;
>   
>   	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q, NULL);
> +							pqn->q, &minfo);
>   }
>   
>   void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
