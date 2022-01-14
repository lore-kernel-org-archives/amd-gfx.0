Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D67C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 22:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4981E10E249;
	Fri, 14 Jan 2022 22:07:11 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D13C10E249
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 22:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgjEMzjNaofppYF5bycYWeYNEVPzRK9/bheQwD3Y8xYXiCHHuoKA3ALg0Oedd7w57Fq0K6hVuLhiVwkMDTiAB//ibK110eR4SOu1srlAPuNdC5AVOsPLLJF16szmM9j6NhiuqvtoIDhaS3ru638+2UvoS82G6ld8b9Xg+22nqOtZ/91A04aIitxGqRXuyKkm38uJ4CuhTlQTaxC4S+Dwj7XTBpxKK1ZCZcgOGOtsqG9aDzUF/oUlpmYeczmSiizXC2ZgYr7bEmcSAVcQxs5s47+x03rUc4r9Ukh3YLtp4ABiB5BUl0vMkDUZxvIVZ8RspXtPDALrIRafrZd1TG4wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FifSE8PSnYdOMSFU1fw6Z0w/fXZnRuxOEfqqxOn1XQ=;
 b=KBRoV25RI3RdbNfASSO6fKX0d7PbasNwhpztsicekgAuzQ3gA0//qnmwKVe2Xivr3k8yTg7COPxq0v53pRnKnm9DY77fmP785lRPqUZAepHJpycvzvhXYQRhkTo4+lPmWvK4X5duBo+Z/D5XIbX8fAT/O8O9J3qoHwLdAe+4ak/IoNvlcAefU+/PHbkgFtRnW9lV7rTO4UhQo+quXr9eBMu2Na5hpEppykbRROOByDI+fwFyL/kC20QkhIUiSakEO8w7bioVOgohPtVYXpHf7N4zCDdl0YGY+4JR4ojC67bBR8ff79WAhPRQ+EvlFFbQyJk3exADGQFfqxxWM4JXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FifSE8PSnYdOMSFU1fw6Z0w/fXZnRuxOEfqqxOn1XQ=;
 b=inHuu16VmwewMwtanoQaB7h6+NZStj1581SDMBoxBb//V5+aJPsynRn0KLJDsYJEDHls4XBZHcL+Yxu72uBtlVqvlvoDW2or2EPBsY5U9iWjvEmV5HSY3kskfvKTnk5ZNaWKo2hm8RJXHTEGD4fmqaOrp5vFw0mfWhx4wdvS5yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR1201MB0088.namprd12.prod.outlook.com (2603:10b6:910:1e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 22:07:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 22:07:06 +0000
Subject: Re: [PATCH 2/5] drm/amdkfd: enable per process SMI event
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220114203839.21707-1-Philip.Yang@amd.com>
 <20220114203839.21707-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <625540be-9aa7-792f-3b23-89c053f414be@amd.com>
Date: Fri, 14 Jan 2022 17:07:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220114203839.21707-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b27792-4ffb-45e0-a087-08d9d7aa33b2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0088:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0088C04076D14134C562159992549@CY4PR1201MB0088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTIQWZnrKaPUwghBuS2LadOs3jG8cN8uuWDFRRG2C09HBP2u5HW0rcPw+0AlqOZgkNb8r38+VcriDLrdN92RKrgNCAoTpb5uJ3pYOU/cM6XUtMS+6dj6IDpHRo9ez4fK4QgL/d5VZCfWTy5Yh4MrNg1L5hWqVJoCwnvVk0yl9IxGFNTL5qOiqU5FUrvoYbeQkxIXTGBGL5DRHN/DTzkbVkLb+z00huu2nc6wwNTPYcaO1T0H5fic1X5v8b3kWfLtdwQahUOlzslSw01ijAXJOFqDWxWEtJcERdFNGYYAGQ7ElP7Wp1eg666rCCLHC7tHb+ldHR9ZH95Gjf4DL9Kfn2/mLm19SXmcRQP/r7IHrkJ21S+2HPNGkhfwchdGK5fkn3pAiwXTAvmRa5YxT9q918Fn7xng2VR4nyi2oemfo2cVwTXA0fC9bjKnvN0ZDHbvWD86n2p6GzBinpmKN40IWKiUEO3ycT33sipeIIVhr9B1wMefF8cZxegQd5ZVf8qCKHKB0o2DNI0BvHVafbegVgJf9E9/2Y3X9Sy6YsK9djEW2QmvS1R2yF59QilUXyFDOaf5D+0PnpjehyvYZFHFzXVis5ubro9IarqFVnhl8Ye54lJJ8wq4bckZlOfTW8kDbQ5Dt1EJwA0C6o4+SBtACn4xV8XIIf1vwZl/ANC3jTU1Zgr5Kppdgy7fR+plpylmNn1pbC5ONkW8FGcjr7ntE3gFJlfOIX+nrkIOSRlRWUDEZuwjmjOUJCh7TW2M7usR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(66476007)(66556008)(8936002)(8676002)(26005)(86362001)(38100700002)(44832011)(508600001)(6506007)(6486002)(2906002)(186003)(5660300002)(66946007)(31696002)(36756003)(83380400001)(2616005)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VjVURhazZIbTVvemh6Mm5QRHBhUkVlbHFNeDNKT0lBV3FFeFpDaDRFQmpI?=
 =?utf-8?B?MERuUmNYcDYyRlU5L2NLU0ZjM0tZd2Q5ZlJzL0dLT1RqNW9OZjRsVFl1WU5S?=
 =?utf-8?B?TENSZFEzbXM1QWhqRG1ickYwVVJKMi96VnZYVXFIeTZ6US9mU01GZmVCNlkw?=
 =?utf-8?B?SGxEZThHYWVjdHo2UWYzNFI4NzBWdGdKSHhtSnVnYUNGSXorNXpMZ1IyT3hL?=
 =?utf-8?B?UTRRbW5tY3FYYUJOVm14TkhNMXZMUVJxYUZOMkpXS1dzWThQUEpoQi9pa05w?=
 =?utf-8?B?YXkvOElFTXNLeWZNZ3ZpclBHWXM2ZUlwcGFOM2dGRGlCV2FXaDh5MkFJZXZI?=
 =?utf-8?B?OGJPS3Njc2M5aXBPNnQ3MXRoY3R1QlZoZVV5V3owcVhrQnhFaW9sNmpNYXcr?=
 =?utf-8?B?L3RyY1hHMXhPZWNaMUo1dEozMkhLaE9BT0dQV2FkYmpieThCVjRhekF1bHNx?=
 =?utf-8?B?L0d6L2FKQXJCdEphK0VjK08rVFZQT2lQVU1qKzZ3NlhES2M5N2FLbDhTQXh4?=
 =?utf-8?B?R3g3ZWxsQUcxbGhQUkRLLzN4eTFZaTBFNWRqaWxPUlNSODY2YUdweGhZMElU?=
 =?utf-8?B?NGJDU0htRExUQUdHeG9mZUtqMVhTOHltb1BtNzV2WDBJNG5Ud1BHcHJGdVNJ?=
 =?utf-8?B?TlB6NW9rWURybWNNSVJIV2ZUL0FOSTk5QU1YV1p2U29JYXgwdXRLL2tjeTU2?=
 =?utf-8?B?NzR2aE1kVS9BSXZwYnk5QytGR1dkSmc4QXV6SnpmSlUyckJsZlI0eHMwU2RD?=
 =?utf-8?B?MmxJMVFvS2N0RWJLNzQyZ2FHa0MwVEtTU0dlZjZXbE1vbllVMHhHSVdvdjZj?=
 =?utf-8?B?QUJET1RIZ3p1OFJ6RE5VNlY1QTdHdEFna253aGE3azJ1RWZ4YVZEaU1YNGw0?=
 =?utf-8?B?aGRXSGZ4bUR3Q2NjbndGeW44MkNvaXJaOFlRQXF6ZHR6ZnBRK3VSbXF0d2Nv?=
 =?utf-8?B?cVovWnZXeDl5VFFNMWNVcnczWlRqblFUZlpVazBQMGh4VytTa1FHSGZlamNG?=
 =?utf-8?B?ZEwwaWl6a21Mc1RGM0YrbWJsZ3hrcjE5NTVIOHI4bHg4ZTFtUHBnTkcwbm5u?=
 =?utf-8?B?OE1VNHpiZ2Q5bHFwUndkaGVFYVRqdk15ZHRkbVVGaXNrdEt2Q3dBdGo3MXVM?=
 =?utf-8?B?RXhRbHE5WVNadWt4Q3RnZnQ4NWNGWFVONTV6bFBwOHpyMmJTV1B3Z1IyVWRs?=
 =?utf-8?B?ekVNSlB0M0VxWTJkNEFvaTNMejdacGYyMGVBU21OQzZXRmhLMnVpbDZzSG14?=
 =?utf-8?B?Y0ZZTjd1V3N6cjIyQzUvWDN6aVl1STdCeHh3bUJpbGxwT2x3MlJtSTJ4a1Qy?=
 =?utf-8?B?ZC9Xb1dsbWhFZGJ3VHgrY1NnbExidWs2cVBNSllscG41Y1NuRDVoMkdvdllt?=
 =?utf-8?B?WXF3VDJVSTBZOXkwck1rRXMzcVJqcTlXM0RYL1JNTW9pcGpJcWpITDliQmd0?=
 =?utf-8?B?a3BkcHA3aU11dThWL1lTWTdRdTUvWHR2dDhnaXhvdHBNODFVNzMrSHdtM0py?=
 =?utf-8?B?QzlBeWRtRkFvSGNxQjJDdU9LUHd6MWxrL3ZacDAwdnFua1JpSzJ5MS9KYnky?=
 =?utf-8?B?a3hUOEdXTjNkQ0ZxVmRMYVVxZEhpZFZXOGJubk4xVllwSzV2MnoyZHFzaUF0?=
 =?utf-8?B?M29KYXhydjcrY3VDSERwUGtaWWJXRjNYK0UwVzlWUHkxUHlIQ3VRajZlOTdr?=
 =?utf-8?B?RWh5aG1mR2kzSjRDcW9LOVluQ3Q4OVI3dDJETWJMWnJEcUQ4aDRRZzlLeXpF?=
 =?utf-8?B?bmFrQUNNRFVSMU5EbUtXVEo1SkRmaFhJTXRWMWRwQW1adEhQMG0xS05xaVpm?=
 =?utf-8?B?eVlacjBtaFlhNkNHV3QrUE9ndktyMWdMSW1URzg1NzFOajVHSGU3ckNqN3hv?=
 =?utf-8?B?czF3MmFMQzNzVDVJaFMxY3UyNDNTMlZxNEVCSlBBQTVqaE5FR2VRdjZLUVVM?=
 =?utf-8?B?VFN3bVhFbkdVdzdaNU1TZzYxM014enBPbG1CVlVKVDZycDlCZnBSWXNURXB2?=
 =?utf-8?B?U0FwMGFBZnNCTVp2K3JxdlcvWkp5ZmhBaTlLUHNUK045ejQvYnl6ZlBGcWVZ?=
 =?utf-8?B?VXU1WGhRTnppeDJjTnVaLzQ0alV1T0lJc3F4WkJMdmF5bGlWamVFaVBBRVFO?=
 =?utf-8?B?UTZmaDY4SjZ3R0NTeWdMYnk3ejVMQzZiTjBrd2MreitNaDdIOU5qdjFZRCt2?=
 =?utf-8?Q?ZvbITBZQ3JFuUbNtc9cwIl0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b27792-4ffb-45e0-a087-08d9d7aa33b2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 22:07:06.3592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L9rDOLQpjg/7fShGCi7cDxF+rymBTEw9Tgjh9uWLcqBf/V6WHb0vjlEcYAaeF31CuCJyfky+7DMzaRK32h7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0088
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


Am 2022-01-14 um 3:38 p.m. schrieb Philip Yang:
> Process receive event log from same process by default. Add a flag to
> be able to receive event log from all processes, this requires super
> user permission.
>
> Event log with pid 0 send to all processes.
>
> Define new event log id, migration trigger, user queue eviction
> trigger, those new event log will be added in following patches.
>
> Update kfd_ioctl.h version.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 28 +++++++++++++++------
>  include/uapi/linux/kfd_ioctl.h              | 27 ++++++++++++++++++++
>  2 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 7023fa21a0a9..5818ea8ad4ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -37,6 +37,8 @@ struct kfd_smi_client {
>  	uint64_t events;
>  	struct kfd_dev *dev;
>  	spinlock_t lock;
> +	pid_t pid;
> +	bool suser;
>  };
>  
>  #define MAX_KFIFO_SIZE	1024
> @@ -150,16 +152,26 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> -static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
> -			      char *event_msg, int len)
> +static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
> +			       unsigned int smi_event)
> +{
> +	if (pid &&
> +	    !(client->suser && client->events & KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESSES)) &&
> +	    client->pid != pid)

We cannot change the default behaviour for existing SMI events.
Otherwise be break existing user mode.

I'd make the new flag KFD_SMI_EVENT_SAME_PROCESS. Its default is 0,
which preserves the existing behaviour.

The SAME_PROCESS flag can apply to all events. But for the new profiler
events, we need to check both the flag and the ADMIN capability to allow
events from all processes, because they contain more sensitive
information than the existing SMI events.


> +		return false;
> +
> +	return client->events & KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event);

You still need to access client->events with READ_ONCE here. The reason
is, that this function is not holding the lock. So we need to read the
variable atomically.

Regards,
  Felix


> +}
> +
> +static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
> +			       unsigned int smi_event, char *event_msg, int len)
>  {
>  	struct kfd_smi_client *client;
>  
>  	rcu_read_lock();
>  
>  	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
> -		if (!(READ_ONCE(client->events) &
> -				KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event)))
> +		if (!kfd_smi_ev_enabled(pid, client, smi_event))
>  			continue;
>  		spin_lock(&client->lock);
>  		if (kfifo_avail(&client->fifo) >= len) {
> @@ -202,7 +214,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
>  	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
>  						dev->reset_seq_num);
>  
> -	add_event_to_kfifo(dev, event, fifo_in, len);
> +	add_event_to_kfifo(0, dev, event, fifo_in, len);
>  }
>  
>  void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
> @@ -225,7 +237,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>  		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>  		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
>  
> -	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
> +	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
>  }
>  
>  void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
> @@ -250,7 +262,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>  	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
>  		task_info.pid, task_info.task_name);
>  
> -	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
> +	add_event_to_kfifo(task_info.pid, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
>  }
>  
>  int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> @@ -282,6 +294,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>  	spin_lock_init(&client->lock);
>  	client->events = 0;
>  	client->dev = dev;
> +	client->pid = current->pid;
> +	client->suser = capable(CAP_SYS_ADMIN);
>  
>  	spin_lock(&dev->smi_lock);
>  	list_add_rcu(&client->list, &dev->smi_clients);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index af96af174dc4..bbbae8ad9721 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -32,6 +32,7 @@
>   * - 1.4 - Indicate new SRAM EDC bit in device properties
>   * - 1.5 - Add SVM API
>   * - 1.6 - Query clear flags in SVM get_attr API
> + * - 1.7 - Add SMI profiler event log
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
>  #define KFD_IOCTL_MINOR_VERSION 6
> @@ -459,10 +460,36 @@ enum kfd_smi_event {
>  	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>  	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>  	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> +	KFD_SMI_EVENT_MIGRATION = 5,
> +	KFD_SMI_EVENT_PAGE_FAULT = 6,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 7,
> +	KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE = 8,
> +
> +	/*
> +	 * max event number, as a flag bit to get events from all processes,
> +	 * this requires super user permission, otherwise will not be able to
> +	 * receive events from any process. Without this flag to receive events
> +	 * from same process.
> +	 */
> +	KFD_SMI_EVENT_ALL_PROCESSES = 64
>  };
>  
>  #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
>  
> +enum KFD_MIGRATION_TRIGGER {
> +	MIGRATION_TRIGGER_PREFETCH = 1,
> +	MIGRATION_TRIGGER_PAGEFAULT,
> +	MIGRATION_TRIGGER_PAGEFAULT_CPU,
> +	MIGRATION_TRIGGER_TTM_EVICTION
> +};
> +
> +enum KFD_USER_QUEUE_EVICTION_TRIGGER {
> +	SVM_RANGE_EVICTION = 1,
> +	USERPTR_EVICTION,
> +	TTM_EVICTION,
> +	SUSPEND_EVICTION
> +};
> +
>  struct kfd_ioctl_smi_events_args {
>  	__u32 gpuid;	/* to KFD */
>  	__u32 anon_fd;	/* from KFD */
