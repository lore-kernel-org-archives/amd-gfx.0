Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97299CC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 21:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225EE10E056;
	Thu, 15 Oct 2026 21:47:12 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CF31124AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 21:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulxdu+rU03qSLBr/SPJ3P+EqsVte3XEEstwWEKOqzj55MlE8u0qRDAW9ed9vANfhHyssLBpak63rCTsMG7PuVGMEjEnBKXM+5kdqTBpkoatL7irmgEvhdtKaC3xiXPgg/sn5Jvwqv8thFKNJ28leiuXwma6M9D6wdHVvrgmx1Q4+QFej/RQd8dw7IrmzasFTM5nXa76pYnwHiZ8BbOvNYhn2shqpEVqrAu/c5pbsIP7RHLVHqOb5d1XFQ9ybUQZxKBDlNEdukFmrpinoT4clXa3ZcuL3jMcu4NFTVEwqjBeEAI6xF0K+xVZtU4Z6Ge9dqVff8JcjLsFXs9W4/Yx3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgqDbkOfI3rZrdu0qk7KELrBu6Ysqbrp+6repHrimjA=;
 b=rowLqJsISIK6q8s2gzjVKogYeZ37Ah9ymi10fo2tKSqZ7YoB1RXSp64rlVitX1RX9ZsG4IrXbn9fgRHUwGArE8r4vyYIXEm3Hfr8PPf6mCrIV3w0kDpBQuosS8yZqGdPZ0ieiIo9E4kkeI3cJRpFhSOvIynW2So58lVhu8BzM5iKBKPcc93rRA/qyPMLjVI/8G4E66ygT3VacSX/Bv55F1PbPvd9qsy9Oo65DLhu5VZo/yv4wL3qcoh2JInlDPMdENbyhUHTrP6M9d8vWTjdM3z6JO1DE/QvuAuzTtzyw3/m7ktLaKfT0M2oY05/1oKdzQ/A8YSVY1JTQ1S7Tm+dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgqDbkOfI3rZrdu0qk7KELrBu6Ysqbrp+6repHrimjA=;
 b=sp73/s3wHIsD3zhcTXuoT1MXT/bGMgR02ZPtfagUPu2yKbnxZ56sLtq//mpwpWlG+HALyVJLR9vNYE6j4zk0PEhLbHfif6KZz3PB26CqIEvSGok6fU+FQ7gzk4lUAIZk3/4n8NNWw3Ex9HNHiggk1zFk5sUmd+PxNzWKYiInFew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DS0PR12MB8218.namprd12.prod.outlook.com
 (2603:10b6:8:f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 21:47:02 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 21:47:01 +0000
Message-ID: <357e549f-bfbc-4749-aefa-f0f9e25d6e06@amd.com>
Date: Thu, 15 Oct 2026 17:46:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdkfd: evict the queues only once for CRIU
 PROCESS_INFO
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, David Yat Sin <david.yatsin@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
 <20261013092158.2261502-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261013092158.2261502-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6c3e93-4c7c-451a-5754-08df2b05d7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bPq5sSxps1aKHdVBwSG6TTlTr12iFHJ2naOmkLKTeBQ3tNHX5I9+LgDvf6cyNPgD7Fbt4ZCe4dhyrNINLXJlyX/oV8xwtk3Z2mjfssnbC9pZClWgabExwbvGJmVELI6OnK75ANSgIRsDoNuXPFMjU7lrbitWVH82pY5wL1VpQOdzcjm+uT4lqinD20Oy9vwC9NJfoby+83/hHcE48opMUYIhhCADH1aWIKbFP21PNuB9slsfayXOjnJMLIVzrARPfmwBaacoCP1iiAskSbpYnnzLEBfX6ZILAZ3xBA7z9NOEpDdTcP/hIBho+7H1LbkycgvZ1u+Em9CTm7K/MuoQgFTYaeGN1tlBFMgkrhGOZxWjkOk1YnSgVk23iCsHC5WHq4g7MWqMmHqXe03cuZtj7SF7leyMfJTAkdIv08t6o7XQiqL0Q9XmnjnU2jeHlJiEJSJAJBPYwq4d+VU+FEJtps7wIW27LswUNEKrBZouT5IFhiKA+FcNvw2mSRuEVsHIItatmPIRe0p3NrBqtdPOKwy1n9Cm3X0fZF0fAQ1E0zH25e+sOkOXlSoJ55wO8KpMyFVdFgIN8SYOLvjM+yQFHBaIOv3jU+JQDN+tPE4zIuV7fV/bM4Rh534B98L1+dIg/FOzDUxv9vwAC+VpiENMcr5teYcJQbpeSqoX+y24YBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2gzVkxRR29QTWlvYk1weVNqOUxrd1FxSEFGOERCQ1hVME91ZDlWS0JqR0wv?=
 =?utf-8?B?QWhwN1dNdzVOVm9rS0YxZUlOTStjVElPYjlSakczb09ScWNYZmxtVUNWTGho?=
 =?utf-8?B?MEhnK3hZYjREcWtUNWtKRjhuTE1yVlVCcUo5Zmp4MmlFbFdKUXF0M0doOTdP?=
 =?utf-8?B?TEVUaFdnZXZUTy9yVlpQbHB6cG96T2wvS3M1WTRlQWJiZXJBMFhCR1lCT1dr?=
 =?utf-8?B?RWk4U3FvNnhDYkRocmpMcnhZQWt0ODdoU2R3cTNkbk1scG4zcjZBZ0VYOXVT?=
 =?utf-8?B?TzF5NENEczJLZXhOWGo2TTA4eVdWMk0vN1NGd25Hc1JnU3VoUzJ3Wi9tRmFR?=
 =?utf-8?B?Y0xVSlczcElsTTQ0Y2plOUVJWWxERUFqNHlaT0tvZFovcGdxWllRVCszR1dE?=
 =?utf-8?B?VzBKNVB0UWZIdXFrQjNMLzQyZ1d6cU9sYnBab3ZtT1AwYTNZc0hlaWZ3Y3F3?=
 =?utf-8?B?MGJSMWl0YUl1ckh6bmtmQzc3U3VhZmtXRHRLOGFWUlVOd0JSTThFYnVPS2NR?=
 =?utf-8?B?OEpGQkFmeXRxbjlNM0NYYkdmR2lGY2RaQzYwUUNwYVdtMXpaN241a09ubFo2?=
 =?utf-8?B?TWYvMWlEcGtGUHB2QTd2ZklIVkIzQys2dTZnSXhVcUk1K1dZaE4xUW5Wb3Ra?=
 =?utf-8?B?WUxYUmhaS25MbFZjWEo2RXJuci9MMjVzcXF3WHowekJxeTFLbXlmWXcyTVNX?=
 =?utf-8?B?eHN5T3Y1N25VQ092eWJaMzZsRWlyZm9KOWQ1b2pnclA4ZkV2OVhmYlR5THdi?=
 =?utf-8?B?NkUrUndhU2VwaEl2WjlLRmFzc2MzTWVZYWRhUHFiNHlYRWRwajQ5WDZqS0Nr?=
 =?utf-8?B?RTZZQmJNREJvajJWRlZtVXZaaWg0TkNhQXI5SEsyTkZ4YXVEOE9QQ0RqNXAy?=
 =?utf-8?B?R2xkZlV3TStvdXg0OWkvTUJRbko0NC9vSDJPNTBEcHdvQktseERrYUNTM3VD?=
 =?utf-8?B?UVRUVlplS0pGYVI0NFRDTkVZdWNuWmtZZzRvMzcvaEtkMCtLb1J3Z2Z2TEFu?=
 =?utf-8?B?Yks4N0Z0M1U0WmY5T003ZW8zUlpuWjBZdWRBb1hRUmVaR096dFlNZUVpa0Uw?=
 =?utf-8?B?enlyTnkvSkkyUVVMSEcyOFZ1NTYxOEVZdFVNLzc2MEJkaVJuNGw0THZ0UFg2?=
 =?utf-8?B?RXNqMS9mc3dFTWRyeHFiRGswYzcvQnFQUW92ZlZtR0ljdWd1c2YxR21zTitI?=
 =?utf-8?B?K2RXZjJ1N0dpYU5CTmhCS0FydkRaRTNqME5yNFY0Mk9SUWhhU2RaemtyNlZU?=
 =?utf-8?B?c1FhUmpkK3lGOWM4UjJRSTk4Wk5laHZlOFlKMGxpd0lrd2xEdmNCZUE3T0R2?=
 =?utf-8?B?M2ZRUi96MTYvVHZTeHl3VTh5cWNSUkQvSkZNTWJFUFFPaWJNL3JQQWNLcCtI?=
 =?utf-8?B?RU1JSE5iMVRnVHpuY0dZVW10bWhZREtmUFoxYVg4bDRFbmFSVDM3T3EwV0lH?=
 =?utf-8?B?NE0wMHRvUnQxS3d6cEptalA2VFNqdjZDaFVTN2RJY2k1VTlzQUFIMEtqNFFC?=
 =?utf-8?B?NEJFcFZOVkdWb2FPWEVwRHNDTmpiNnplYTBhK2FkSkpXeXl0WXhzOUVlSTFr?=
 =?utf-8?B?R1RkR0VGbmc2R0N1RktCd0FJMUVsbCtsQVg3b3RLZzBON1VURTJSdzFST3pS?=
 =?utf-8?B?ZzEyL1F1c1JPNSs1b2ZjT0ZaTWlmUmFCekxrN040ZzNhaWpBdEhsWUlSOGlx?=
 =?utf-8?B?a0krWUE0NElIREYvMm5EdUtQRHhocVlqdFJPYVBSKzdNRzRrT3g5QzhIcGNJ?=
 =?utf-8?B?bWNFUGZGZUNWZ2x0dlh3TUkvb1pORHNPdHY4c09zWkNKUG4vTm9Ib2RndEZW?=
 =?utf-8?B?ckN3cXF5NkJtT3RZZnA4eEJlSTIxVndsVXd0Vm9qZ0dLd3FEMGZ2V3hibDdy?=
 =?utf-8?B?V0JLMnJjSUdRdVFWd29iTkVRZ3k1RFYzQVJUY3RWRmY3UWk3eXpqQzl0cmFU?=
 =?utf-8?B?QUxOSXZod3NGTUtCakNtczNRYSs0ZnA3anJtdWp0MzNHYTZQYUNIS3ArUEJ2?=
 =?utf-8?B?L1dhMTFScy9NTXBxQUw1dHZLZW00ZlpPcGVDUlR4ekJpaUs0a0crbnJKTGQ3?=
 =?utf-8?B?c1Z0WWpjbEhrKzlMSWdQTmZ4dGM0K2hldkxyVzY5aGJSczZJckYyM0N5WXo1?=
 =?utf-8?B?MktzRzVCOE5GUXZNK1RRa1d5cUk1Z09hbVpWNWd1SGlzYUFteUR1MEpBQmRP?=
 =?utf-8?B?eExDRk9LWG85cGgvcXVYN0RERHErVmF6WUd4T0REdmRCYmxYUTk3Vmx5U1Bh?=
 =?utf-8?B?bm9QTjA3RmJVRG5EREpqOE1WRitURzdDRng3SDBEMHRZM1l1cEJPN1g2bUdn?=
 =?utf-8?B?SHQyQVBqRE5nR3ZEcEw2ZnNXQ3RoSXZOT0ZrVTJRM1ZKMzNXYmZiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6c3e93-4c7c-451a-5754-08df2b05d7bb
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:47:00.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12ipsbeeFJvovDg3m/NCocDfZuqlQD10jUAkHWGFkMvo8az44a92XBa6o19ATqouXVoDwTq7RsJekhG4XJqz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
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

On 2026-10-13 05:20, Jesse Zhang wrote:
> criu_process_info() evicts the queues of the process on every call, and
> each kfd_process_evict_queues() increments qpd->evicted, but CRIU UNPAUSE
> restores them only once. After PROCESS_INFO twice and UNPAUSE the queues
> stay evicted for good. On navi31, a barrier-AND packet on an HSA queue
> completes after PROCESS_INFO + UNPAUSE, but times out after
> PROCESS_INFO, PROCESS_INFO, UNPAUSE.

I'm not disagreeing with the patch. It makes the API more robust. But is 
this a valid use case? I.e., is CRIU actually calling PROCESS_INFO 
multiple times? Why?


>
> The error path has a related problem: when kfd_process_evict_queues()
> itself fails, it has already rolled back its partial eviction, and the
> kfd_process_restore_queues() in the error path restores once more.

I agree. Your patch addresses this as well.


>
> Evict only when the queues are not paused yet, and on errors only undo
> an eviction done by this call. The barrier now completes after any
> number of PROCESS_INFO calls followed by UNPAUSE.
>
> Fixes: cd9f79103003 ("drm/amdkfd: CRIU Implement KFD unpause operation")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1d86ddfd6bde..2e1d412a0e6b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2869,6 +2869,7 @@ static int criu_process_info(struct file *filep,
>   				struct kfd_process *p,
>   				struct kfd_ioctl_criu_args *args)
>   {
> +	bool paused_here = false;
>   	int ret = 0;
>   
>   	mutex_lock(&p->mutex);
> @@ -2879,11 +2880,15 @@ static int criu_process_info(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> -	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
> -	if (ret)
> -		goto err_unlock;
> +	/* UNPAUSE restores the queues once, so evict them only once */
> +	if (!p->queues_paused) {
> +		ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
> +		if (ret)
> +			goto err_unlock;
>   
> -	p->queues_paused = true;
> +		p->queues_paused = true;
> +		paused_here = true;
> +	}
>   
>   	args->pid = task_pid_nr_ns(p->lead_thread,
>   					task_active_pid_ns(p->lead_thread));
> @@ -2898,7 +2903,7 @@ static int criu_process_info(struct file *filep,
>   				args->priv_data_size);
>   
>   err_unlock:
> -	if (ret) {
> +	if (ret && paused_here) {
>   		kfd_process_restore_queues(p);
>   		p->queues_paused = false;
>   	}
