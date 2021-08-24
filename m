Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DDC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A620610A3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A620610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD948984C;
	Tue, 24 Aug 2021 16:19:38 +0000 (UTC)
X-Greylist: delayed 3581 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 16:19:37 UTC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (unknown
 [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBE88984C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 16:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn21I+Fe1s6OiLhRK4QfHOCpfVivUXhGdL3U/zLau2XVf91zH6TO2P3qWgWVqycKhoHeGVEMJEDWbJOeP8H0sT7m93KrEyp5QcwZNi9kIqRNFBzStMwr9uIqpLkphsMCzdSFqKaiJYQRxdIfG10HqEnK3ZdKh3TPpXWAwc6H0QpG7Mff+nle/VJASb6yHanWZ7Qmyu4htd99trkB2AyYiwrOj+ayEclYTVciwo7WRYpadKJoeVmpLrfwwQSYyOlbkxvSBOrdbrdfsYAMM/J3Cw9hcQxaLvTWVs36JDEYX43nS0fRWFCEtoBBuvKb46qLPhcQ6Gtb0534ASWAdwlUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K6uELIjUkKYsptyuYk5y9sJZ9Jn05bMApfo2fseOzg=;
 b=Cvp35NKSmwyuq3HKP9TqF/vw2lt9yfi+QkQClMHemADQIztlGXsK0FzIqZPTN2BSESFS3+hwvSdmUomL5UnuTUd3rQ4l8CxgF019IXrmcPfd0Wa31OoRgrk1l4GugQMXjHACKdACxd4AwWyfWGns81OEWcHv0k8F49w40tSEPk6jHgVNfEWtJ0aK1JigEl9iC9mB3sMmdY1QnGRg55YVWnam8anrdJaPbwvgy5rTpsxAmAaGQxSZL/EjQ8hiquINjkkErVYvUy1XbSzqy9k1b5l2ujzK+bPHK1bw/p4eTGZwWuMHTHWUp08NyRoto/imeeOTSl25HtN5lSQ7iL8r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K6uELIjUkKYsptyuYk5y9sJZ9Jn05bMApfo2fseOzg=;
 b=wDrFjSzeLUldU6uysB6aKTixDWwiTDJMIjCeSmYonTnFsEJmAeydkCvL5aYJVF0XEiEZ11qTj2glD7FW2Nfnw8YQJW/7pXDKHZp6MLcDpLFlk4AD528zlkgApLoujk61x8aFXjIKa5oEbfNRG3bx1K4DZdgqJVw8Apf0pwLigi0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 14:46:50 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 14:46:49 +0000
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1629798692-21361-1-git-send-email-Monk.Liu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <c83ad5a4-0adc-3940-ff86-b9e194235604@amd.com>
Date: Tue, 24 Aug 2021 10:46:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1629798692-21361-1-git-send-email-Monk.Liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::23) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:61c9:4593:6778:84a7]
 (2607:fea8:3edf:49b0:61c9:4593:6778:84a7) by
 YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 14:46:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d965197b-1998-48a4-8cf2-08d9670e0129
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4461915FD2FA2EC463CD7D01EAC59@SA0PR12MB4461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXsz2nD82DwNZ/3iWtNxHG+QTU9eJ9Y7GgNr76DWpYrLh+E9Zy2Pl4nUfe+0y8x1KGqSCaISM1ennGf8T1pAdI+EVvO7WJeQ2UFpRw0z/+CWLyqN4Y6qeB3Tn0vN6BgnKC2WltH/ydLvKG5ELAy5XhK3Ys523pfcWYFZjKAdVvCgNHowBaD/01/6PVCkx//SqfjDqLAruds8aC4YZMXs9jcHd2K6xOfJ9Z5V7Ob/Gep94h43d+32pboDEWrDPA7Hoe38W2RzxfWDNQMCmIKO/B6t7XbXjD8KyVzOoijQQmbL3A0tbd0j+6/dlf4N5KfgVPZSDlOqCb4QY5e7hb8pnJYX8VTlL4XqOPkeLIsj96U/JZPEJSJC6JDtiAI6gTMxtpIiwC4yODD4vDNxsIWFrtLR7j+NGRNWDY08oFAs1Dndelyz+F7rQTKIU6ZEFYso/fnOv3mx4qw8XUnD1cMYvok19I/qTJr5V/ikCW7oAsGZStCVxpdtVPxClkUS66ZO9zuTwirXCWtBkmg/2Mt0L4Qx0CZaRE8ipZO3R8PSkz/uvg5GMDOhcEl5Qc+gDlzgxAWhEV8+bVbANBqDsqUorXbrNr9pSt+ZeU0GWnmh+asyiwh0NMzAOolkyyLR3cVG2t5znPwHQlEtF6vJjGliNXu9ntMpf7ExqOGpAEjWcUn7m2PmXt/sE1mL4fSpXX6nQwt8EupQl8cPqon/nEyqG6ARuV3X7Dj3gN4IkNoUEidRwq78AyHDvS1Abr/vYLEC2wtxxp8T+bmZbWh4+XYL3Aektv5PGnqERRoRAnhsfsXNKGkKy1FsIGKiwPeAzhQJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(2616005)(44832011)(186003)(83380400001)(8676002)(478600001)(86362001)(6486002)(38100700002)(966005)(316002)(66476007)(31696002)(53546011)(31686004)(36756003)(2906002)(8936002)(5660300002)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRjSHZJTDJwN0hFcThwcVFNSGNUWWh6c2hTVGFPeHJDRWplamZJVEx1Vzlk?=
 =?utf-8?B?OW5WSlBaeXBJWEZzVDdPYnBxL2JxbDE1ME5ic0kyL3pXaHpBUWxWZjk3Vi90?=
 =?utf-8?B?cTFsYWZXODN4c3Ywak5XOXZIOUlsUnZNd1BrK0JwVW1OUTgyMlFqQThwaUNt?=
 =?utf-8?B?SmFlWDFISFE2Mmw4Uy9CNU14clVUcnBFU3BaTTRiNk9Xb1o2VGdTQy9kZk91?=
 =?utf-8?B?L3p2WWhUd2cwQVQyM0pRVUdhdGFwcTdFc2VzYkQwMVUyaXFZdnR0algvOFJM?=
 =?utf-8?B?VDJNWVhCV0IvbUZMcTZPWHNlZkxYQkxrbkdhTFMrUkpEUnd1UG9FTHFpeVl1?=
 =?utf-8?B?Z2JYRFJrdmlzUXlhMkgwMWJWKy9EQWZncTRYYlMxVlJkQTFBdHUwZHp2YzAv?=
 =?utf-8?B?T2tIaUpNd3hkNkVyNEhCZk16VlBnamlvQ3FKUFBFbUQxdExYODRtM3JYcmNK?=
 =?utf-8?B?bUZwMlY5V3l6NkdHR2ZRNm5CTXRXRm1jZHFMT2FYQUhXdXUwYi9jNG5tMmp0?=
 =?utf-8?B?cDNhcW9wVFZpS3JwNEEwa3ZCYmRpK0IxZG9qVGFQenJiY2lkaTJIa0ZienNG?=
 =?utf-8?B?NHk5QU9oMXRFNHJQNXljVmFmaXNRc3BkNlcxNVZpb2d3Q1pVOWRqSHNOd09M?=
 =?utf-8?B?cEVCdzRULy9mSXE1QURRdzBUOVk3OXZTYTB1UzM2UGpQSEFiUktndlZZdURi?=
 =?utf-8?B?eTlIRXAzWFJqd29BTlM3ckdSS2MrbFlCd1VnOWQ1RWpOanJUbEQ1RUpCNDFS?=
 =?utf-8?B?OUFyaW5VT01MYVhvRVpvRnNsdjQwREkrTnB6MlJsZWtDT2ZOQmdrNmVJYWdP?=
 =?utf-8?B?ajhvUjBpOThkQ0lpR3NkNGtMZ2Fwc2YzZXlFMTFaMks4enlWdFNNRTdHM004?=
 =?utf-8?B?azVjZG1uaUhtTXFoSnFDTENKYzd0RkdSaGRjVk9nNERKQWEwSjNzUk1zTmZJ?=
 =?utf-8?B?MktDTUtKNnNTRy9MN3BVcUlPVlhPM3VxMjlTQTBxTXhvSC9JczdyR0t5RzRB?=
 =?utf-8?B?K2NaRGptUnNRTWZjY0x5QlVuaEtTak5GWWc0SWpwZjJFNUFITFNTY0psUkM2?=
 =?utf-8?B?bzcrZ2JrMVZoNzNoaUJkK1lIMFNGUzZDSGJ5L3hNL1NaNlRHdWYxUXhtZ2RF?=
 =?utf-8?B?TXYxajRDcjVMNmlNb0Fmb2x5cmdNb1lqc2dsbCt1TnBZWGpuSURmSGNMSjM3?=
 =?utf-8?B?Tk9tNmZ6U043OU9vRHBJcUx5M1M5ek1QRjlvZVNDYWRoUit4QS9yYkE3OGoz?=
 =?utf-8?B?OTQwNGZKdFJsY1krRnpmK2JpdVFMYkViTGVoOVVkaUtKZFdwQ3U0UnBvQnhM?=
 =?utf-8?B?REdkRG9kL2dKWm5UTWpmYWRtNjdnT0EwT2VTcEk5eWVoOUJWTUQwOGZLa3ow?=
 =?utf-8?B?UWhreW9MbExZbWx3bG1JdUZuTk1McmVtVldnUFNNQXFBUzhHNTRpdTlKWlh4?=
 =?utf-8?B?d0JHczArT0NrVDkyU0J4MU9Gb1NCbmdvWXM1VlVMMU5QSTh0QTRKTmZyN3p5?=
 =?utf-8?B?S1Rxend2SDY2SEkxL0lJMXd6OHA4eHcxWGtLQy9BMU91dUZwQUpXSXFISTVG?=
 =?utf-8?B?TkhyeWMvMWNjeUVraVFuK2lydGtuRytWSG9wdFFrSmFybmxQZzBjcktqc1VJ?=
 =?utf-8?B?UGtjczN0QVJJeTVXM1JlQXFDOVBLTmNGNHl3VkV1SnV6bVRPSXRtZjRMcGw2?=
 =?utf-8?B?dC9zcDhTMWNHKytYcVZzWEFDdEg0MnEwdFlNajliRm5EUGpNMDZ0RUMra2to?=
 =?utf-8?B?MzhUU2JBWmoxeTNsejNtRVFuUnFrUldQUDhJK25yWGFJRDFtcEVkVmdoZVgw?=
 =?utf-8?B?VVJXRnhiL25rWG1tZ2pLdzEzMWpvTkkvbGkxSmhuemhHVzk1VkV2MVlIOEZT?=
 =?utf-8?Q?rFWnOM8xjc6mD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d965197b-1998-48a4-8cf2-08d9670e0129
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 14:46:49.8278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoQR66BCApQTVtPaSzj2XXMFSMkiA0TIXSN+poDAu+ZxV0J8eCnPa4TjjDyqZXYDhPLDZbpVoJDpjT9YpPLkOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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


On 2021-08-24 5:51 a.m., Monk Liu wrote:
> the original logic is wrong that the timeout will not be retriggerd
> after the previous job siganled, and that lead to the scenario that all
> jobs in the same scheduler shares the same timeout timer from the very
> begining job in this scheduler which is wrong.
>
> we should modify the timer everytime a previous job signaled.
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a2a9536..fb27025 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -235,6 +235,13 @@ static void drm_sched_start_timeout(struct drm_gpu_scheduler *sched)
>   		schedule_delayed_work(&sched->work_tdr, sched->timeout);
>   }
>   
> +static void drm_sched_restart_timeout(struct drm_gpu_scheduler *sched)
> +{
> +	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
> +	    !list_empty(&sched->pending_list))
> +		mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
> +}
> +
>   /**
>    * drm_sched_fault - immediately start timeout handler
>    *
> @@ -693,6 +700,11 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>   		/* remove job from pending_list */
>   		list_del_init(&job->list);
> +
> +		/* once the job deleted from pending list we should restart
> +		 * the timeout calculation for the next job.
> +		 */
> +		drm_sched_restart_timeout(sched);


I think this should work, but 2 points -

1st you should probably remove this now 
https://elixir.bootlin.com/linux/v5.14-rc1/source/drivers/gpu/drm/scheduler/sched_main.c#L797

2nd - if you have two adjacent jobs started very closely you effectively 
letting the second job to be twice longer hang without TDR because
you reset TDR timer for it when it's almost expired. If we could have 
TTL (time to live counter) for each job and then do mod_delayed_work
to the TTL of the following job instead of just full timer reset then 
this would be more precise. But this is more of recommendation for 
improvement.

Andrey


>   		/* make the scheduled timestamp more accurate */
>   		next = list_first_entry_or_null(&sched->pending_list,
>   						typeof(*next), list);
