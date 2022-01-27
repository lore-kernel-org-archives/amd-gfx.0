Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7298C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 23:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399E210E35B;
	Thu, 27 Jan 2022 23:15:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C6310E35B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 23:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpg4MERN608RxSRDa/TBpjZZLOMbcbGPkPKs6M9L70OeAqpEDh4b8ZgOpl1seTY6Sc7X/BaIu2b1Zh+4XsKgXRQSqKLVTs5sbEl0lXTk3FqeO75UFCKVWW2zlJOjOcBn1VXQ+OHlhezguAUXr0rpOrP8Y6kbQ1CaP9rFM922pGCcVe+m36znDaf7y/T4nzPEP686agdcAyh/vKgU9QFWu1io+pGhbvPYE3KFTZQA6YqPuCxTr7BANxlqNjCaTrH6+EnQfaMwgOo/3irjnIhKp5nD1h19RzL8a7iAnUjMHD9Oz738703TLQ8GDepF+85oDCNK/2Qp9Ru5qA48u2/rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO9Ephqm1svZdDItODsExh8NHA+oxhhWmaGX0Q0+Hy8=;
 b=f51NhsOqPt///T2poBAbgT94nFQHhT9yQXmP6dnG4SnQJHL9mQFExyR1PJVWnzGrE7EfKkSTI0Gifqi1EiimFbc6a1ripftzjqarwgTCiHkWxuSNMOqkH8EIG71RbW7R3yZx3a7Y7tr5pjnNgpuVBrOi0qAeCSi3wfD07tzTmmwUaNRK0Md1oeIXj/U28TR5ohr5MviYE3PbsTaY2nTjn2u0ZarYpQ1cCbho3c4Tme0g4n1/ip2b67HZ5NAMfTYhbnJKSXeXPYDVqu5qiId4cAmdV+IISl4Oojw/wog3oK5z/nWnAk3/v1XETd2tfmjgTVbPDM3do+f1RJbupwwnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO9Ephqm1svZdDItODsExh8NHA+oxhhWmaGX0Q0+Hy8=;
 b=uzd0fxq+0jbfUbApoNLH+REiouSx5vAa/Btvq1Fko5oaMezd/1vW3Om5MlmdfqXpDeMpa4f9GsSfmaVO5kkVJkr4cN+lNB+dXorGyd4RaeGDxDPyCgbEWi90qBHkDUer3+dT7uUKxiTY5kYVPo7RZ0darmnHYu+4P8TKt1goDYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 23:15:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 23:15:49 +0000
Message-ID: <ef2699e7-12b0-f4d0-116f-0e756a58a1c4@amd.com>
Date: Thu, 27 Jan 2022 18:15:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/8] drm/amdkfd: Add GPU recoverable fault SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-5-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ccb556-a4a7-4ed3-d0d1-08d9e1eaf4d8
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB53951E819364B770B6A0263892219@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjcC/VLW5VxFWb2rjB0565F3gUgLMDDoJwQLRGhw1IbWDnzUF3LCM+o7qh594q8lAZI/dD3ZvoQ1T1XLr3ROVBTgq3+L6SvvwL0WZNfAlRSQDtXd+XpmwUpMHKf+Z7IHc3hlUuLLPnVNsCKlY1aSuIyka9/1YRI0XJ8HjFov8ZEQq/5ZeOFAIBsm5WLm1URDnEAE+bw/2TdbvlibW/ZH9VxXR+nB1+6XMCobwlY/dbvwtLz5brP4v/roSu8NiRvxHJGa0e8V/dQFrTJTuY7AFa4RYz0YoGCpAB+5n4p0x34SsTBKmvr/NqZdnFi9AlHMc05rpVKr9nutvHQG7p8CwvDF5V1HygbMCu8ngc0W3V2wFOug61QchQiWMt07QSOpOlI1M7nqBXAsMKtbCX+POYlAgegyxZoBoYoBqKz7Nsx6Mc+dDnBO/vn6uSHqPlu4gpjAw/xUQRPTDun/lxUxM9v54j0claNDmcbac05LMjsRZlVRDUKapL61A+iXjC6NYxSXyeGbecKs7Qeq/aHdSBoOeDYd1JTzoV04/EVPoBZWfBo0kOS+YwBPIzOqRuQOmX81q20gavorH02+jtabPek/26A4qxKetcPfjwxctb431F2qshUzxcGZnqgY6AfIXHHwEyoECajjP0IohkDRcElRdJ0+MKzLsJXZij1fktnpRPyUikTGaYQwjEXMznu8GVfTwevxI25KOU039vGafrUipp+59oF205n47Q/G0UyztvIxH4EmM6PrTrK1mNzG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2906002)(66946007)(6506007)(5660300002)(6486002)(2616005)(508600001)(36756003)(44832011)(66556008)(31686004)(26005)(316002)(83380400001)(66476007)(8676002)(38100700002)(8936002)(186003)(31696002)(86362001)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVQdzdXbU1MSG5aK1hEMDR5MHcvM3FnaDF6K3R2cjh0RkxuRjlhTDluY1dL?=
 =?utf-8?B?UHg2dlVKV0NrT0szcGVrcW9OWUt6MFZFY2xuckxEZ3pPY1hMenVkNDJDTDlk?=
 =?utf-8?B?djBQUGZ0N1RVa0RGeEdJWit0YUxKUWNPbGtPbW1LL1haZWtOaFBnSDBnRStm?=
 =?utf-8?B?Vzdoc1M3NDVrVytiZDNXLzJJMDZCWm05T3J0R0FTbE1qaWRHNDJBL0czdVhY?=
 =?utf-8?B?aDhwRHlEcExVcnR6QzlwU2sxQ1E4djI0UzBGVmRMdmNGd09ndUh1NTF4ZVFJ?=
 =?utf-8?B?RWFPY2srbEhNSTIwd0FzS0IyU0VxUW1JOGtPZTR1bUFDRUgveDVuc3dycEx1?=
 =?utf-8?B?bGFHNllXSjg0UE5JS3ZINDRkdlVKUnZvdlkySGNOTkRDZ3J0clFuNjBSUzI2?=
 =?utf-8?B?UDFNVUtwUXV0RGFMUEF1U05QUUhEQ2N6Nm5UYndmUDI4SzJTWDB1S3RpWkND?=
 =?utf-8?B?bi9CcnpVY1pCcVpnT1ArakY0SVJIWklkNGVBL0dMbzdzN3hyQ28xeDFYWmVI?=
 =?utf-8?B?L0dkb2RzWnl0aEpGMXQ3UElxRE53NXVEbmIrTE0rVkRBNWxsTkRKZHRER0Vj?=
 =?utf-8?B?Ky9NbzRnUWRWYjl3Z0tiYzZDTkxjWGEydElDWkwvMk45ZG9OY0ZHUWFOTHl0?=
 =?utf-8?B?bm1uNm9ONkpXUHd6UmNtamZ3V2w1dGJRZklXQ2lld1lrMmh5dlREeTREbFZZ?=
 =?utf-8?B?cmM1d0MzNUhRVnI0Z1Z5aTZvdDNHTjdibmxoY3MvY0Vob01Ka1REb2NPNEpF?=
 =?utf-8?B?SXFqU3pUNmMvUVdNYVg4U3ptZlZOZ0RseCtpeDBURkFtcURyVUR3MTMrS3c4?=
 =?utf-8?B?VlRaZW5jRmhNeFNJMElTMkRPU3kvTUNVMEFwbXFqREZnSkkrbldPOElURWVn?=
 =?utf-8?B?K3Z6dWN6TGZLejY3bGZLekFQZW8wRS8waUtrMktuUjNZWUgxV2g0Nks2UWpX?=
 =?utf-8?B?ampDZVJYSm9valdNMlNkTmNVbVVZZ2tRc3dLcDV4ZVJsOEpSZkJOcDJmQ3pJ?=
 =?utf-8?B?WDI4S0dzazdyaXNYaWlqcjNSQnFyR3NMSmZxUDI3N3VvS3AxaFIyY25wcGZ1?=
 =?utf-8?B?QkN0UzF3WEx0anpOc3JaT2Z5SVM5Y2JtUkdrOWp3WjlTWnVzU0FwMllMbW80?=
 =?utf-8?B?OVFzUGtzaktNSXg4V1V0bVZwZTNvSWpWSS8xbXJRODVIK0trbk9QdmFydnk2?=
 =?utf-8?B?S1djVVJNSkxVeXJyQUhaWVZzYkRSMXB5TGZxbU9RSW9sN3ZTVWJsVUoydVZu?=
 =?utf-8?B?bldFRllmMXVSajRNbFlFcUc3VVRraG9EajVIcnAwVXpMWkhCMEdMdEhNcXE5?=
 =?utf-8?B?Q2JOUDdGWDZ4SXJTTjlJb2ZiSGwzNnltc01uam9rTzA1a3ZyNUJzaHU2UUNS?=
 =?utf-8?B?c2JqTXl4dzArUWVXQnhzYXJPbVFHdUozTkFPYU55UktZNEYrL2JDR3dnbTEw?=
 =?utf-8?B?Nkp1VnBlU3QwdWUzN0xMbG43V0JGM2tzdzlKc1BIU0taSndpTHJLNk9zcEVF?=
 =?utf-8?B?QnF3Lzg1UHdCbUhQcXl2a2tTRzZaK2phbTllWSsvbzZwTFBoWm1IK2ZSRXgr?=
 =?utf-8?B?V3VMYWRsVEwxZU8zNmVEMUFydG9zZGxlbnpiajZKV0p1VDJSRC9vYU1YcG9v?=
 =?utf-8?B?RWlzQ05scnd5MVVGKzk5aEZRRE9wd05lMnlJanNOSEJhbUtHazE0L2w1cnJC?=
 =?utf-8?B?czF4RkhGVWFlMGxGS0hjaVNCZnduZ3dScS9iQTN6WmE4UmdGUjM1QlFGbno5?=
 =?utf-8?B?WFF5OGtnNUJyWmwvVlZrdFZGK3BvYVZLNGRnblJYWHRlcUZBbzFvZm1UR0pJ?=
 =?utf-8?B?ZkM2UUlOZSs2MnNvNk5Yby9qaUMydFdRMUlZMGNJZURVemwyaW9aZE93MnV3?=
 =?utf-8?B?Sm5pdmVYR0h3b0tZQmloSFN5UlBuZzZhVEdZcHlUUi9XMDJHSStRQkkrNjUy?=
 =?utf-8?B?a2J5VXpXaCtabHpUL0FnL0dISVpsRVhKUnl6b3o3ZFZvNGJwTWpUNTgrTUdo?=
 =?utf-8?B?VFQrM0M3UzBLTCttWUozWkdmQ2dEK0tsUHhobnF3ZEsvS25CR1pOKzVTNExE?=
 =?utf-8?B?VnNQN1JqaG8vaTRSMUhvSnJrRGtWRFJ6VFNWL0VuWXNPQ3B0dXg2R3h5cmlh?=
 =?utf-8?B?NkIvU2ZxVlhWUDRzU2F3SkNZUDc5OXFvN3MxamVxdjFYUlRGQWFJbkFjWkxR?=
 =?utf-8?Q?cJ3DBF5jz4hOzOh+mN36W34=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ccb556-a4a7-4ed3-d0d1-08d9e1eaf4d8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 23:15:49.7019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4zN3gZZjbd6prcyMabWYSHgM7qIDLuKgySqN1hrJiNTPXIJojIPRctmgLNXDObWO6lXGpQmo3fpAFvKH7TJOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> Output timestamp when GPU recoverable fault starts, ends and duration to
> recover the fault, if migration happened or only GPU page table is
> updated, fault address, read or write fault.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 48 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  7 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 17 ++++++--
>   3 files changed, 67 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 68c93701c5f7..080eba0d3be0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -266,6 +266,54 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>   }
>   
> +static bool kfd_smi_event_duration(struct kfd_dev *dev, uint64_t ts,
> +				   uint64_t *duration)
> +{
> +	if (list_empty(&dev->smi_clients))
> +		return false;

I'm not sure what this check has to do with the duration calculation. I 
think this should be checked in the caller.

But I'd actually prefer not to include the duration in the message 
because it's redundant. If you have both the start and end event in the 
log, the duration can be easily calculated from the time stamps by 
whatever tool is used to analyze or visualize the log. We do need a way 
to match the start event to the end event. I think the PID and address 
should be good enough for that.


> +
> +	*duration = ktime_get_boottime_ns() - ts;
> +	return true;
> +}
> +
> +void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
> +				    unsigned long address, bool write_fault,
> +				    uint64_t ts)
> +{
> +	char fifo_in[64];
> +	int len;
> +
> +	if (list_empty(&dev->smi_clients))
> +		return;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in), "%x %lld -%d @%lx(%x) %c\n",
> +		       KFD_SMI_EVENT_PAGE_FAULT_START, ts, pid, address,
> +		       dev->id, write_fault ? 'W' : 'R');
> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START, fifo_in,
> +			   len);
> +}
> +
> +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, bool migration,
> +				  uint64_t ts)
> +{
> +	char fifo_in[64];
> +	uint64_t duration;
> +	int len;
> +
> +	if (!kfd_smi_event_duration(dev, ts, &duration))
> +		return;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in),
> +		       "%x %lld(%lld) -%d @%lx(%x) %c\n",
> +		       KFD_SMI_EVENT_PAGE_FAULT_END, ktime_get_boottime_ns(),
> +		       duration, pid, address, dev->id, migration ? 'M' : 'm');
> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END, fifo_in,
> +			   len);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index bffd0c32b060..7f70db914d2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -28,5 +28,10 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
>   void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   					     uint64_t throttle_bitmask);
>   void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
> -
> +void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
> +				    unsigned long address, bool write_fault,
> +				    uint64_t ts);
> +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
> +				  unsigned long address, bool migration,
> +				  uint64_t ts);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2d2cae05dbea..08b21f9759ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -32,6 +32,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_svm.h"
>   #include "kfd_migrate.h"
> +#include "kfd_smi_events.h"
>   
>   #ifdef dev_fmt
>   #undef dev_fmt
> @@ -1596,7 +1597,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	svm_range_unreserve_bos(&ctx);
>   
>   	if (!r)
> -		prange->validate_timestamp = ktime_to_us(ktime_get());
> +		prange->validate_timestamp = ktime_get_boottime_ns();
>   
>   	return r;
>   }
> @@ -2665,11 +2666,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> -	uint64_t timestamp;
> +	uint64_t timestamp = ktime_get_boottime_ns();
>   	int32_t best_loc;
>   	int32_t gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
> +	bool migration = false;
>   	int r = 0;
>   
>   	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
> @@ -2745,9 +2747,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out_unlock_range;
>   	}
>   
> -	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
>   	/* skip duplicate vm fault on different pages of same range */
> -	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
> +	if (div_u64(timestamp -  prange->validate_timestamp, 1000000) <
> +	    AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {

You can probably avoid the division if you redefine 
AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING to be in nanoseconds.

Regards,
   Felix


>   		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
>   			 svms, prange->start, prange->last);
>   		r = 0;
> @@ -2783,7 +2785,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		 svms, prange->start, prange->last, best_loc,
>   		 prange->actual_loc);
>   
> +	kfd_smi_event_page_fault_start(adev->kfd.dev, p->lead_thread->pid, addr,
> +				       write_fault, timestamp);
> +
>   	if (prange->actual_loc != best_loc) {
> +		migration = true;
>   		if (best_loc) {
>   			r = svm_migrate_to_vram(prange, best_loc, mm);
>   			if (r) {
> @@ -2812,6 +2818,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
>   
> +	kfd_smi_event_page_fault_end(adev->kfd.dev, p->lead_thread->pid, addr,
> +				     migration, timestamp);
> +
>   out_unlock_range:
>   	mutex_unlock(&prange->migrate_mutex);
>   out_unlock_svms:
