Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C12CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B363310F66A;
	Tue, 13 Oct 2026 09:31:07 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B5110F66A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9e3tIeVZWNHofadGYGSph5cBnXix++n6fJ+VLdexU1lOr3KyISeexnNcubWWNYS3axJ14067odONkRg+rDXktBsk+uSdvASaQyw6q5I7DaOF8B0WUI0bHapaKJ3UwIWz6IiBwkXf/2KkJnYNJDR5W8efgeY07XksVC1qWez7rP2WQb+8fblWuEwfUsV1dpyY7crxZGHooJKrOWd9sG01+clqAlu7TNJVvcHS0uy8rgLki0hJBvpKjXM72qjHM9jk5CFTS/2Rs/rzlSgad9hceLvD6/BBQrPYwkwpSEjGU/UUoQXKD6cFCKiJ2bXZYMlwisRYQqjD3V/dSbLsnWiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAhEiPatS9PjUyMVVsmEFopvCmMM+Ax7g6e6HzeLtFw=;
 b=N3Thzr9CN/Qsq8RRdX+Aphr3ZkQeUa7kpfkhjxD8Cx85v89sZ8VI6PUiYQjdJYMub/N/h7kAIxG4dc3aM4jAqk+j6QC9ozUj2VrqGDmiUt5DcBjZgi98AHJL1csn3qefgpsB+UycWfmXOg6cZh/jTd502TWN1bYJzMe3vVRgFl1HT+huwdnVt/eamPASbjigEvL2KGF8G2bk+NNU1sXBhvm41D88WJnpqk2krPlImCL7FtPO+2B5JgEBWS5amNTKsSoaXYuksl6/fydxGhc+Dpq+2o94r1cN0Iiw1MvLwKZkmExfOvSa8NrugAq1DrDu1hoPj2EO6kJ5l9tbN0b/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAhEiPatS9PjUyMVVsmEFopvCmMM+Ax7g6e6HzeLtFw=;
 b=alwwnHK/rtYxj3X27Q4Mt2bw/3R+rbN9Noo76/TzVyhUIe6K4CPL7ixT34XBMEvdsHbn97reg9H35yMYfcH6vNE5phPq5r5QO7JnctGmW019qFvO/U81vR6OKnhPekYhUa+AC7s7L9df82t7WR+fpOS4rgBPPJvC8kYyfHrft3o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:30:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:30:55 +0000
Message-ID: <5d41fc4b-ca95-4cb2-b0a4-649614548882@amd.com>
Date: Tue, 13 Oct 2026 11:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu/userq: take reset_domain->sem before
 userq_mutex in destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-7-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013082457.2492273-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b24f964-d031-4711-f08e-08df290cae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qx50b6/efmOpeyKA4R15xMWDMM3k/pYVu5xOdyFNK9cMkQYJ7UaHHnpUFMB2y+aUkq6iJS5rfRYcfEFERqB2Jl4NK3Q0r2Z5HaJ7kvIIxYLsaIQcBNBxm8dQWPZkM0l2YpumPwtQGMgCDca+dHnnQSEfYfiaz1YJyOEXIYS8vjpNihkJS/9/IkLDizthfxgbGJgcPjqU3IoFIToxZ38MkGsdby/D2mSvQ2NK1bcSkBgn+R+IXfRDUsuI+U3XdbUJQit8RMHMo4Q3DPONXbkrEu/2O/eT5+11eYE2z5WnJ3IlIchvUWtlIVXOfmkH/Xtvo1TA1E3U2QNSdb+dHNAAwTEZRbSfxn7qwPMPCv6uCW/8lIjsnHlQS5loAMBtiIYVbYFR09tvqhF+bgC6dbMcGEpWeu+/c6oVe0V02NtCqvd2e9zciepOXoGJXxkyGqO1lrx5qrcf+rgquWC8ffHCIpH35FFymoSn4h7rgQG9AuNl5D/cnUUnX+L3LzlZAcDfOUMCDdTugLOce5Xa/OidDk0V5eBzN90Pfbe3jMlCG5W9nzbniEd9NneIwtZciQ7oqIKhlmUr1rUlxIM+pKSmm0m7gLoFw0IeAtsoBGkM/43G2JRh62hCcMGg909RnTX1jfn0VsdPKq9vBiy0HrsP9tuVBeLDeANLm6jTxofAHKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hMRXVVQit1R011ZG5UQ0xDTG9LN2lqTXpScVJVMWtFSEtMd0V4U0dsY1pt?=
 =?utf-8?B?a2NrakZxSENocHpoaVJOQStzcHZqSk9RL2VSRDc2d2RLTGNMSGE4akRpRVNT?=
 =?utf-8?B?YkcxT3ZDMDJZeWJCdHQreU9xbUFoaTExVDNITmZCeXoyUXVzeTNkSGVqREoz?=
 =?utf-8?B?MDFiZ0hjQzlHcTdlYWZaajA0NjQ3RVpOWG5NRis2cE5yTE0wbnJVclRGYkZO?=
 =?utf-8?B?MUVlQjdEQm9Lbng5dm9LRU9HNDBlbm55VGpUTDVpRzBXdEJ6cGR1RjdKY1Qy?=
 =?utf-8?B?dnUra3YrczEweGFzckV5Y1hpSVRhRnBiUzVWYVJDV2NrQ0xmdFllSWpIUkdV?=
 =?utf-8?B?ZlRZZURwQjBxTXVPZTE5ZGNHcjVEc0FWRHNPbkM1VHNKTlRpL0ZlRjVhSyto?=
 =?utf-8?B?c0pSS0VpakY5UUttQnR5WUVabHR2NnF5UmNYbGI4b1hRTFBxa2ZzeUxmcFVs?=
 =?utf-8?B?WUJpRmJ4QVhDRlArR3hTTmRuZDljVUc3Y1RwM2o2RUJsRWt0VjJqQlJUUHFv?=
 =?utf-8?B?L2xmQzEzM21USVhRRlFCNXZ2TG80RXpmNGdDOC9lbWpXYWg5WTJKWFBFL3pS?=
 =?utf-8?B?V0xYQlo1L1Z0VmNOYlVNOE00MlZ3NXExdVBSWXhMZUlqZ1h5VmpFM254Z0JS?=
 =?utf-8?B?MTE3K0R4V0IzMnBqSVl4RHdaWUhyN1hqQUVFNkluOUo2ZDVCSzk4ckI0OGN6?=
 =?utf-8?B?MkVDdXV5cnE3RENXWFVocVgyOWFMeTMwTzQvUS9wNVA0bmpaMWJnb25kbjUx?=
 =?utf-8?B?U291bnduZ3lRc3NUbjU1Q25RWTFpYzBzVkZ5UzluMGNkZFgrTEpBSG5MYXBJ?=
 =?utf-8?B?UTJpSUN0Wk5sRCttUDVxZm1uRTBRTTdZT0dUTWEvcFdHaWk0UWJNK0UyVTZK?=
 =?utf-8?B?ZmlvTlJFbEdEb2hpZU9QOTlEdFZCc2lRNStKN3BvZTJqQnQ3WmxEVWZQdHdO?=
 =?utf-8?B?ZVZjZk8yckZVcDhPNmpqREZCVEFRMHY1bUNHY3FjV29ROE16S2VGNVhUQVdi?=
 =?utf-8?B?d2d2U2hKeGFGeFJ2MjI5OG0wRTQ0eU1OalpRa2FwSkxsRzZSaFVJNzBicUd6?=
 =?utf-8?B?Rk90aFVxTU9RT3lPVlhJdXVyN3YyZWdtcGgyRU95R2RJQm9PRUd5L0RZZStn?=
 =?utf-8?B?SGhmdnBVTzF3TXhJakFUUkJpZllZdktYWWZlSk1SbWZtdFh5MjZBS2ppTHZq?=
 =?utf-8?B?emZkcTBTeE9rWE95bSsreEU4cmxEU01HOTZaaUNLZVRvSDh1ZnhhYXo1MHk5?=
 =?utf-8?B?YzJHWFF0WUltTnhSb0xrS0o0VEZJSGVpK1pxUW8ySnRlRnpCWEZXQzdybkRU?=
 =?utf-8?B?OGd5M0luU2dHdytpM1dUT1BVVXNsam1kMXFtakJLNGlDWXN6b1lvZHN6dGNF?=
 =?utf-8?B?bE9STGM1R2t0RzZ4SnFQR3VSakhrLzd1Tk9uOWZjM3E5Z1VzTWFLc3NrdE9K?=
 =?utf-8?B?NWNEbm41dGZwY2xKK3psT0F6Ymt0TmRvNDlHRVBLQml5WmFQaHdYVnkyYk5U?=
 =?utf-8?B?RUE0OC8yZXhYVDF2MVJOazlZUllaZkloSUpXM3daOHVIbVl5OVE1YURvZy8x?=
 =?utf-8?B?cjZiZzJVTk1pRHdWTXRCWEtPaDJHRlovakJqbFZ0VFV0WCtiRHMvNTQxTlZs?=
 =?utf-8?B?K0tkcXBXbkJnS21zY1QzNmk4T0FJQjExWWl5Z3BSRFFKWWQ2a0RycjM2aEhS?=
 =?utf-8?B?eHI0dVdVYjNBZFdWaUZzekE4cWhkakowY3F6K2dnWXZrcjZQVEw2VVd1L3JT?=
 =?utf-8?B?WUxPQVlsZXVYenlrV3FPMjh1c3FDcU1kOHhNc3pPWExMcDlCb1B2d3pnSEtN?=
 =?utf-8?B?UE1HMEdPV1AvLzc3aW40ZE1XYjEzRm1zeWhRZnE4djFsc1F5dXRRdkI1c2l2?=
 =?utf-8?B?OENoY1NLWko1OHAyajhtZ2krcit3alZrOGJPeWU2U0pLRnBEUkRSSitTWTQ3?=
 =?utf-8?B?aDNWRTRVd1dRam1BRUdxdnhDcUpkdXoxa2NMVjhjNUFIY1o3bkZNck5ZaVpt?=
 =?utf-8?B?Q2Q5TFBlemQ3TzZ0YWgwd25vb25MVUx3b1ZlR1BMbGZKZnJ5UVRJajFGSFRV?=
 =?utf-8?B?RlFScDVtaXVuWkZFMWM4QXNUSFVtc1Z4QjRKRGV1WFdMNHAxT21yNXYraEkw?=
 =?utf-8?B?VHdiSkJpWnhYSU5OQXRzWjFrMDBGdHFLMC9vc2VIZXE0Tk9ydmxhT1p5NW5j?=
 =?utf-8?B?UVBFV2c2UWZ6WlRydHZPM0xTR2ZoclV1cUtVMXB1Q0JXRzNhU1NYVDNkZy9n?=
 =?utf-8?B?NDZxOE0yV1lwZG9LMGRPWHF2dnlCWUNQZ0h4MzUraE00Ly8rcytJYW9heWRF?=
 =?utf-8?Q?WQGs9GryuaX8UaCs0S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b24f964-d031-4711-f08e-08df290cae38
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:30:55.0746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xPQYKh8rtEg4F+FKNekG+SxuKchONKvdyGT5LY0rm9EXVtnAFnnzHQCGlt6UHgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

On 10/13/26 10:24, Prike Liang wrote:
> amdgpu_userq_destroy() takes reset_domain->sem for read in
> amdgpu_userq_detach_doorbell() while holding userq_mutex.

Yeah that is correct behavior.

> GPU recovery
> holds reset_domain->sem for write and then takes clientlist_mutex in
> drm_client_dev_suspend(),

That is completely broken behavior and need to be fixed.

The GPU reset can *NEVER* call drm_client_dev_suspend(), who came up with that nonsense?

Regards,
Christian.

> which already depends on userq_mutex through
> the fbdev reservation and userq restore paths. Lockdep reports:
> 
>   Chain exists of:
>     &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
> 
> Keep waiting for the last fence under userq_mutex only, as the fence of a
> hung queue is only force-completed by the reset, then take
> reset_domain->sem before re-acquiring userq_mutex for the doorbell
> detach, unmap and fence driver teardown. This also keeps the MES unmap
> from racing with an in-progress GPU reset.
> 
> Fixes: f18719ef4bb7 ("drm/amdgpu: Convert amdgpu userqueue management from IDR to XArray")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5fef0cc7703c..a34ea8ecd700 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -415,15 +415,6 @@ static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue
>  	dma_fence_wait(f, false);
>  }
>  
> -static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
> -{
> -	struct amdgpu_device *adev = queue->userq_mgr->adev;
> -
> -	down_read(&adev->reset_domain->sem);
> -	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> -	up_read(&adev->reset_domain->sem);
> -}
> -
>  /**
>   * amdgpu_userq_ensure_ev_fence - ensure a valid, unsignaled eviction fence exists
>   * @uq_mgr: the usermode queue manager for this process
> @@ -547,8 +538,12 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	amdgpu_userq_wait_for_last_fence(queue);
> +	mutex_unlock(&uq_mgr->userq_mutex);
>  
> -	amdgpu_userq_detach_doorbell(queue);
> +	/* GPU recovery takes userq_mutex under reset_domain->sem, keep that order */
> +	down_read(&adev->reset_domain->sem);
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
> @@ -558,6 +553,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
>  	mutex_unlock(&uq_mgr->userq_mutex);
> +	up_read(&adev->reset_domain->sem);
>  
>  	/*
>  	 * A failed unmap means MES could not remove the hung queue and is now

