Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD48FEFB58
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFD410EBA3;
	Fri, 27 Feb 2026 14:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hHSlpx/T";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D735710EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 14:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blxGVG/lc9pAVTQ621gTQwpwBTDqLknrrdhs7H3GM0iYIPb3wucvmfkEew9qkILieQ51NrQ4Nv0iWdcmmZ0mkmWFgn+zszECTIUA6cEOwBQTrLqeRZ0k+jvFEaZbE/UH6r2KTr2ZieJpZMoTH8krpdhxHqfZmzDpF5ajHLhPhojN6Pc5Gn0WmZrsQ8bIN5rH7GAMM9RHOLTYzuSGL9vU7wN5/HUDCERa+iZxpTzV+U/3M7UOYlCAeAco8nIAlbhKj6ArQWnTK+jPC2Ay9C5nK54BG2VwW1FkNlyWvpLZUtBz3HOSfRGWy7a2C3rFOODPXXd33nhsRYw8uBWvSpFo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xb21ijKpBYHjhC5+wEbHsqUOSxL2gFuAGBtSbkhYTw=;
 b=Dbs9/Okm7p+OLs4GlKG8GghAEj+hAIaz0WbjTtfhcPFpGllnsdcl/MCiYMNKLc0VbMEiT42ER8rTgxeg4/zPWMllOBILS8yz8VbK42atKtZU2uHzekcIkuZE5pdCi4XvG6rM/bXm8vX8+uwIKaZzIG2MYgJaJ/zII7gFIyfaxM/Pgd/xf4tN5aRc+ea8GcaHC/WOQfPrdSpXyH1hCr7kOfnthg7wNMJIY5GwrRB6DtHezH/QUd2+pn0c7pdtcrWNphj7UBQ/84rbdllZ9E5oCpT4BtS8HfictLx2sRCSvMewjMIf/Ji4y9S7kdC6LWYxQfnEEHDPt92dxhL9f220lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xb21ijKpBYHjhC5+wEbHsqUOSxL2gFuAGBtSbkhYTw=;
 b=hHSlpx/T9J8i1X/tbDF4fdtXpG3hV4wfKLYwmYowzQpq3CwGJZLNY8zm08rm71ylU3hZd8ye4I3VJTfxE1nbLpf5qexAwZwwLfxdflkwyM68Lt49lFpah1ZQl/SBhTL6AyfLlxGIcSA/YsqD7Jm5Tn3AfWTktRLWW/R1HuTMxcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 14:31:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 14:31:47 +0000
Message-ID: <7ed63c95-0e96-4149-91b0-3c173f0404be@amd.com>
Date: Fri, 27 Feb 2026 15:31:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] drm/amdgpu: Add IRQ-safe eventfd signal helper
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
 <20260216154943.1582412-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260216154943.1582412-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 66551435-8d4d-4d1d-c637-08de760cf049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: GrsfP8Nq1DkC0nFr+52Mmwdjt1xIM3K4e5I5nwTztDhwpeUIft+u3eRQSyfREuWfFKiaXd2xWGOJu7Ph45TNiwIge02hxxnea5bNFtHyt9q65xDI3EL0vGWNPh/EmOXz0u45IudLkUEDouoHS6aTAvO9wXbu2z9ca9NQLGtWih001vedzN62Vbr6kzZE5KQ2l9rkJBcrr27Yz3mxJQDikdaCh/49WIIZaZ2Fjm3t0kigSXO9FvBkYycQr7xMPVzJqXXJUvUc1iXoH4YRexAD1LtxMM0B9gIK7lilj9mlbOK5HD5nBWLWhcG3ZIIBo/iI/ABXeumU2osPOk+a7FFSVgZarTwvUFZYwEsdT9rYElY6nUhAi9YUZilQNc8LDwaSoViJN5BLvIXHA6HmfLHqGID+kZEPZ1YLtJXysNZVYFcM8ny+ty2qYW0dh3m6WqGUvSenkCkZnas+Aphe6cY1Ukn97fa0wrC0nVIRUomCIMWUSmWCzq1FMdWni01/rTY8IITzQ6E8LrLKvbpOBvfWztlWHqCFcODmddGJ5Rht/xKx5aQbFKxi0Dgyge/S1mQ8TXPyIPZFK35GGkcbJO96idsu/zOCoYdGPelOo6zd4FO3OJ9QTewEnJuJVoiI6hTx+rfocl1byDJO+NJgD6K0FdrjLHd9g05k+c4hOLkixZOCDuqAxUppAE/dWhKSMk99hwnSxf6DDSjH8xnjn8Xakh1T7OtRQ7BNj2X716D+RqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRka2JRMHk4TUZEN0FyRmhwMUZFbXpJWXQvTGxpaTl1UEt5amhuR0NYM1Jj?=
 =?utf-8?B?K2tvbStXR0pjNEJYNTNEOWlnNWxBSWIzV1V2STJrQ1VrUjZVWTQvSlJVZlpT?=
 =?utf-8?B?K0ptZUV1Z0tOR281LzVicGZZMm0wcjhyaDl5SlY2ZzFXcGcrQndRUFBZRHAr?=
 =?utf-8?B?bkw0MFFGSlJkTllMV3gycmdDS1cxRFQxQStBZ0FCZDdBWjhUcWpJUHJsVUo2?=
 =?utf-8?B?aXlXendLTGtESHp1N3l6WE9tczY0akI3NFI4a1FPQjh5a2syRk1DZFhydVNa?=
 =?utf-8?B?UkdaZlJPRmQxYitHZEw4TDh6MGVOenFwMFlNcEdha010ZGswK0FMaHpMc0w2?=
 =?utf-8?B?QnBXbWlaME1LWFhFNmRQT0NMRnYrMjhveEJmcmhQaUQxLzlSRHhyaCs2U0VT?=
 =?utf-8?B?bDl2emNqaEVzY2ErVWQrV1JSM0Fja0NnWU9JS2V5YzJsNGtYVVd3SVJ3YTQz?=
 =?utf-8?B?OVQxMWpTWGk0OHJBeCtVK2JMM2d6YUNhY3UwWTVwN3FHVjgweTFDWkwwcmRi?=
 =?utf-8?B?L2Z5NEpmRGVnWFAwTFRvVjc5WGRBeGRMRThvS05CamY4a3JGMXoxVWFjaWxn?=
 =?utf-8?B?cGsxSE16SisrNk5lTkdXZGRBWHVCS1ViVllJZDBIY21GN2pHVTc0SVd6Vldn?=
 =?utf-8?B?eXI3OFROcWc0K3lZT1F2WUp2MEFPK2syc21mcjdpMjl4RnhYa0JNY3NKUUVt?=
 =?utf-8?B?REZvR0p3cUc1MFRYVzdDQnZ2M25ndWdMcndvRVFuU1BLQjU2dUwrYnM0ZHB1?=
 =?utf-8?B?My9hQ20vaWhEcnUyR2VxQ3EyaHdwdVdCWWY1M1BlNWN1NUNiWVRBNk51SVl6?=
 =?utf-8?B?OEZ6WEZmNHJzbm5OQlQ1ZVlMZXJaZndPNGhEbXJJRGNJQ1lZSmFDR0ZuelZw?=
 =?utf-8?B?ZEhuS0x4NmJ4d1FtdE9CQ2hINFc1SVVhVHY3Zk43d3FhZGR2Nzg3MzRsTzVh?=
 =?utf-8?B?ZXlQNDNrTlRvZ2tnMlg0NFM2clFxVXpvTWJpRFIwZXZzK0dRQ0lRLy8ycGs3?=
 =?utf-8?B?Nk1OSXh3bEpGbGh6WnBpc1piZVJRR1Y2V2lLV3VRaE1MaGxQVEpxc3NhNWx6?=
 =?utf-8?B?ZzN5YnNXa0hXekRkYUhWcWN3bmZYZit1bHRSblAxMk1zTW9TQkZJajU4L3cw?=
 =?utf-8?B?b2J3UUcwSzliYzNMRDNFTDhuNFk4aWJ4NXZvVWQ4U01rSDRmWGZJRno0ei9v?=
 =?utf-8?B?Uyt2SjE5TUNaS3NMN1lPWmZLdFNIY1FZQnUwWkNCWk9hUXVrR3VUKzhibFB5?=
 =?utf-8?B?UEppY1R6MFhkNlRMRDRXVjhJNk1COHlQV2hvVDM2cUo2b1hiS0psbjg4NFJz?=
 =?utf-8?B?TXVJOWRaNEI2Vmo1UWZIL294Mkd5MGJWSnViRnpqVzdhUkRONzN3QlRLenNR?=
 =?utf-8?B?Y0E1UFZTZm91N2hmOWNEVWlTM0dzOGR0L1JYUTRKdnM4bE1FTUdROGZCS2VU?=
 =?utf-8?B?K0drdm5MU1FXWUhLUmtmM1ViK1BXZVhmNzNoc2syWmt4WVQvWnlrQ0xRMmlF?=
 =?utf-8?B?SkRYaXBGbDZhREtHak82aEpubUdublBXNFYySGV1dmxvZkdtb0VhcHl2LzRB?=
 =?utf-8?B?eTFFb3RFaXZXQU8rT2tsWkZ6SzJod2s2Tlc0QmpJMm5pdHVJUEc3VG1JMmc1?=
 =?utf-8?B?RGxTekd6L2FrcXQ3UnR5RUtrbFc2T2g5Qzg5dUtpLzVaNjVFMkh6elA0cHpC?=
 =?utf-8?B?Y0M2bkNLdXF1M1d2b0dadDBIN0YycWRocVVOVWdic29mMU5BUnFLUzczOUNn?=
 =?utf-8?B?bmdiVEtSSURBcDdmaUIxbEhyNm1nTW50M1dqQUd3b21NRTlIMlhkMmx3TlYz?=
 =?utf-8?B?cWlzd2YrZmNNNlBBMW1wbUcrSjAreUIwRjZMTkYxK1ROb2o2UWphOVY2dDFO?=
 =?utf-8?B?MzJnMmRGelFwcTJTYitZNWVtOG9Ld0o4OHhQcEFIR3pEdE45cTNMU1M2QTJl?=
 =?utf-8?B?TjI4aEpzeEVkSDEwMC9hd3VRUjZsVXg1ejlPbU45NENOWVNGYkN0bEkrMjRk?=
 =?utf-8?B?LzQ4dWF0NWxUMDlPV0J3Q1VzV3E4ZGhZTjZpdmdURDBpQVF5bFlHVVdoTnU5?=
 =?utf-8?B?ZFc0b3NUbURadGNiS3Bkc1FxOFFmNWhhTFpaL2U3ZGRNZU9zbTVNdFJXTTZj?=
 =?utf-8?B?SzZXU3ZNbm02enRhN1d3MjZmOUhGcG1SOEVacy9CUlRBemt1SkZaTnhJYWtD?=
 =?utf-8?B?V0FKdFBlWEFPaWNNUkNBaTZ3VENkTGRHSGJpZlEwV3RBREt5MGZ4MGp1WTh5?=
 =?utf-8?B?M0c2Z0JKbzlLZkV3NTBOTlVLQjJ0b3gxQlIzb0U3SjRsVytpaVFDU29ZUU9J?=
 =?utf-8?Q?3SJgjdM+aegXmJqrnR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66551435-8d4d-4d1d-c637-08de760cf049
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:31:47.8558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioI5V4I5ZkRI14Tg/OyqXFnhQTGS47G9BqU2fhNE8ZU/1S+XjnekKA4j3UgNsxm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

On 2/16/26 16:49, Srinivasan Shanmugam wrote:
> Add amdgpu_eventfd_signal(), a helper to signal an eventfd previously
> bound to an event_id for the given drm_file (amdgpu_fpriv).
> 
> The helper is IRQ-safe: it uses RCU read-side protection and lockless
> xa_load() to find the mapping. Bind/unbind and final teardown already
> use call_rcu() + synchronize_rcu(), ensuring safe lifetime of entries.
> 
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2baeb0b20df1..b0e9b7ff2f80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -473,6 +473,7 @@ int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
>  int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
>  void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv);
> +void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count);
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 43da5bc36b7c..66e2ae8b7c8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -745,6 +745,27 @@ int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
>  	return 0;
>  }
>  
> +void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count)
> +{
> +	struct amdgpu_eventfd_entry *e;
> +	struct eventfd_ctx *ctx;
> +
> +	if (!fpriv || !count)
> +		return;
> +
> +	/*
> +	 * IRQ-side: lockless lookup. Lifetime is protected by:
> +	 *  - bind/unbind freeing entries via call_rcu()
> +	 *  - registry_fini() calling synchronize_rcu() before xa_destroy()
> +	 */
> +	rcu_read_lock();
> +	e = xa_load(&fpriv->eventfd_xa, event_id);
> +	ctx = e ? READ_ONCE(e->ctx) : NULL;
> +	if (ctx)
> +		eventfd_signal(ctx);
> +	rcu_read_unlock();

Using RCU like this would work but is not the usual design pattern.

I would rather use the xa_lock_irqsafe()/irqrestore functions and keep the xa locked while the eventfd signals.

Regards,
Christian.

> +}
> +
>  /*
>   * Userspace get information ioctl
>   */

