Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997BC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76A6613F8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76A6613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F846E9B6;
	Fri, 16 Jul 2021 15:48:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B20B6E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYXOFfk2gfzm2yljyoqnEUg2I4AY4x94Gr8l+UPjydwgU15yzb1VJn8f7jj3Eojih9OY4ID7zqdG0J8wgzMv9uk6W+CHfi5IgVh9b42X9IgGXGZEQaESjxdhgQEb84rAuhl8jMFY0HU6yGaoKhabkq9v8U25giuFzCR5k5bxRxQ1HvQP/r6BXEtrxWQO+6WST1ujQc7Q95AOJ1nEBSb9ZbUs7pxV6lTtbbrqLw6tNLexyfsCjnEKglwhvmem/IZg2hcQRklR6ziojmTmeUH4W8TU8hQUwQY0J4x60wC+w7I/N4Ei5AEO6wJ0M0FoZ8EwXOSjt/Jj8I9icMnL6j7VMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSVj6fauV6nevkL1eSxR/+eMAk6+Vk4v7vItaXAoFAA=;
 b=PTQV2dBxxzMIU9NbrAL/eoaI5seUP7yRQ1VTk7+nXH4ByVUiUoCx/GNxk+C1yvaHYzaaA0FqDuPdyuYf+cMmc7kRfecz2FkB4t5Ekh4SZcnceZDHfDqt0Mbrj6qNPW49MsmNa14eDkkWTYl3BrNvNGYOEzymT3wrxWP+JvESL6QOmaV7JTo9kN0NSx+QeWI5f8G/ND7RiTYU8S5Ccx4et/JdHWUGaF1f7/bXJDUFsh/hV1S6FGFjsAu3ihBu6KKznkvVLf119X2l1as/RsEW+6J+jFyif135ChNpTuRhWrvTvq0vsLe2oIlpHcM0ogL7DpjyIhrzznOSO/ul7JL2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSVj6fauV6nevkL1eSxR/+eMAk6+Vk4v7vItaXAoFAA=;
 b=Ee6pN1TS21Qxt3Qrp6xjSuZE+AtZqn6e1uCN6w1MzluLPXtOQ3qJg3kOkDadg/NulzADfxBBm+/FwwPb/r6xKwSVqKx5rYnQ+wkqhfKaLe2PD4/nhIEKJz+NeSsBYb6eEmWujD0QJwSg5QaoS+Km7pkjLlKDZMcxmkObed2kNmY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 16 Jul
 2021 15:48:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.027; Fri, 16 Jul 2021
 15:48:54 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: Fix a concurrency issue during kfd
 recovery
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
 <1626449810-18044-6-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <eb576603-f547-7a61-0d89-6a1f11f01fc2@amd.com>
Date: Fri, 16 Jul 2021 11:48:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1626449810-18044-6-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:48:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 686b3d09-8ea2-4533-4811-08d94871374c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB532196121BA61743BD3DC01092119@BN9PR12MB5321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVVBPaHVEJ/4++zob8Y2pmuUFenU9V6QeKk+LvKSEw86sr9GkE30pLLPW80BfWGeNXiTScI74bxMz8RM5x6ay33pNkCM/X9Gs4llIQ+7savk7e171vG+A+9VuupFSbetQOv5IMJyBWd0Fa0eDbNwZYffE7NI/7I3/K2A/fmvXQjUMXJHIG02LY0me7sVyMfJuvbc4a8VW1S9B635J3se74hgAvM5Tj8jdOzgZPbz1AoNTxupFAtc4te9wKnKVOFnT2aPynex+rrobdA1zAjUNq771g4wrxEAT0APxffc3GxQ70660YAmcRRH/UKFJq/ilFHSJwjmSPsRFEwk6uFob6wOJgc7yTsdN6pBmCcYdrZJGaeVcIH4rGt2p+okVLj6XYYYwCz3MTJdfoMeIbavFbgmQXl5OKNEpsRdKGj3Wlv0ng64ECpcZzZ3PDwzJiTW1xFGFWS3+FW9ywVtt9uhJVFHxq/TnE6sZERkyqemGZUm/VDsEErNTBiQQUgoOo/Uum8B2DopdHvcSOqz6u+QVo50BtMwSlNIefDGBphQ1OO/X1hJq77mnD9tRFryHhRZ1hKtOpbb7NbC5c6OY9g1bNO55I0AGse2Kz2njjJkZiH7mICH3+xDBOmqXeAkzMnBomUDv0Zy5VTnzCwVRoqfzbUWI9SN0NKzLTimx1HjYu0smB8DkHQUGYW5yEVLjiKKChBGkaQCQ/bu7VMj2JkgkmYnySwyHEeoCAxV/PIuBsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(83380400001)(2616005)(4326008)(8676002)(44832011)(186003)(956004)(31696002)(66476007)(36756003)(66556008)(31686004)(38100700002)(86362001)(26005)(66946007)(508600001)(316002)(2906002)(5660300002)(16576012)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blM2dmNvblRPbytqbkdLUnpuNWhpYXlvNW4vN2tNTEdCNlZTa0ZZVStLR2I3?=
 =?utf-8?B?L3pzUzBNUGtRRUxOWFdMZVNUZ3hscXVxMjFaWUVEZUpKQnpYYklxaE9yNVZz?=
 =?utf-8?B?U0dHcDd3MUxoNHNTb0FlaCs4U1NkaGpHNGE5RGk5YlE4ZDVMUE9QdHdyUUh6?=
 =?utf-8?B?RUdwUzZxdnNhakpCL3ZpNGF4T0NidHVjNnl5OHQ3SU5sYjhyL3JFb0FkR2U1?=
 =?utf-8?B?dlp1OU9lU0NiTGttbUoxckxmdVlXc0R5alR6cU9mNWcraFNZT2thNUl2Mllh?=
 =?utf-8?B?VVk0RHc3S3lVMC9Qclc5Z3lLdzc4dW5UZEphaTYzTWNkTVNLaW5HNm5ZWk5K?=
 =?utf-8?B?UUtuWkI4MXhJTVJzWUozbFZsOTFZUnBHRm1qWjM2TUpqQjN6WVFJU2FqSlls?=
 =?utf-8?B?SFZVVGEwdmNUN1BSY0NXbi9oSkxLLzllWnNucEhVdE01M1Z3dnY3R0FDbXp1?=
 =?utf-8?B?cnkxV05ZYVliSStaNTVZOGZibHNROHRhQ1pRVVhQUTVVL0JwZExuaFlsOXp5?=
 =?utf-8?B?ZytFeGJ0V2lHSE9GL2xzRkFWeXZYSDk5YUxwRENQc1NvNGRwZk00SEdTU0pt?=
 =?utf-8?B?bTlibTVjdnU0dzc0anVVSGZmbFBsa253bnVpZlNJME1nYmNxbjA4ZVRHY1cw?=
 =?utf-8?B?alRxSHB1ZGViY013c2d6aEExU1IzNUxEQmlZWjdhanpuMlJuZzByQ0syRTVD?=
 =?utf-8?B?MDFicTRkak1ZeTQ1b09rUloreURMTk9UTFN0WUxQN3NtU3g3MFZuTWloaHVM?=
 =?utf-8?B?TkxGYS9PTmVSL2FKUnJjbWlIcUg1NmxrUWQwaEY5QndWQnFST05FRUM4bXM3?=
 =?utf-8?B?N3JBYzFqaDR6VjhkQWI0SnpEU1pCYkt0bG9xeTN6UXUyeEJ4czFDQzM5eXVH?=
 =?utf-8?B?RldiN09FZngvSG9qNi9wcjdNL1FsWUJhK1pXR3lkb1dkc04ydzBYV3FVVDdh?=
 =?utf-8?B?V2RtYVNLM1hadTBiVzNwYzIzaE9CUEZ5UU5jQlVUVzNrT0NuOUN6YTRHdmhJ?=
 =?utf-8?B?SUxNWjd2cDN0RUc0dEdxNStwWFpHV2lRQmZzZ0VIU2ZwNk5lelU5ekEra2RC?=
 =?utf-8?B?VnBydTdIUTZ0RDFPZGVBV2szNVBBMHNOSGJObC9wVzg4Y3k4cCtWYkMxWjBa?=
 =?utf-8?B?a1pzazRWMHFsSmNoazUreUh1d0xFNGpSaEpyUXlwNTg4THY1NFNPY2NKSlhG?=
 =?utf-8?B?MHJ0Y3A4TVRHM1dINnNZUmVIMkFQMk9IcmdaRHlDYU1vSkJRL01NZGE0cEhy?=
 =?utf-8?B?TWlaUjZhU094bHE3ZlBIYkJYSDB1Zy9RUE1Pa1JIcDZuVlBEbXBQMVRVTTR0?=
 =?utf-8?B?eCtscHErdEY1UFFLZjRaQzBRdW5qL1JHWHZmZWQwdGF6VFRQcXcweVA1UitM?=
 =?utf-8?B?K3lTMTd0cUtSWUx1cFpJYmUzNzFkZmVFdlc2UjZwcVc1SzI3OFhVbG1BalJq?=
 =?utf-8?B?R0dkN1IwSFNuREswWmNya1lmRFNNbkZQaVRLbzIvUGVWajRDaG9vNzRLYk5y?=
 =?utf-8?B?RldYcEFUS3FUWFNwU3FnV0lPcitxVzlvTllZWkhPZExiaEk1MXg4WmVpTzZh?=
 =?utf-8?B?YTJsSkxZN2Y4SWY2anVGSkdqNlFubjdVVnBCU0JpOGdkVVpOYjM1cEQyK0lF?=
 =?utf-8?B?M1NyazNwRFJSQS84aUJQTHVaUEsyU04zc3VRc21oZ2I4MmtjRFNMa096a0JQ?=
 =?utf-8?B?REs1OVBHK2pUZ0prU0RhLy9CVnN0d1k4amdyVk11MGVEbDJjN3l1NUhBeVRK?=
 =?utf-8?Q?MbNEtMRvoxegkuyckJzAVjfZbfg/bKaEAp817AK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b3d09-8ea2-4533-4811-08d94871374c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:48:54.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Tk77DSGVphMbICG33wIMq1sPIOXWI4cUJ5Rmjx6f/wc1hAPeu7wEoMGSu/3uurbbKnAmaEczlto5swkd7zaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
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
Cc: feifei.xu@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 3 and 5 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


Am 2021-07-16 um 11:36 a.m. schrieb Oak Zeng:
> start_cpsch and stop_cpsch can be called during kfd device
> initialization or during gpu reset/recovery. So they can
> run concurrently. Currently in start_cpsch and stop_cpsch,
> pm_init and pm_uninit is not protected by the dpm lock.
> Imagine such a case that user use packet manager's function
> to submit a pm4 packet to hang hws (ie through command
> cat /sys/class/kfd/kfd/topology/nodes/1/gpu_id | sudo tee
> /sys/kernel/debug/kfd/hang_hws), while kfd device is under
> device reset/recovery so packet manager can be not initialized.
> There will be unpredictable protection fault in such case.
>
> This patch moves pm_init/uninit inside the dpm lock and check
> packet manager is initialized before using packet manager
> function.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> Acked-by: Christian Konig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  8 +-------
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 |  2 +-
>  4 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 03875d2..56b5010 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1383,18 +1383,12 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
>   */
>  int kfd_debugfs_hang_hws(struct kfd_dev *dev)
>  {
> -	int r = 0;
> -
>  	if (dev->dqm->sched_policy != KFD_SCHED_POLICY_HWS) {
>  		pr_err("HWS is not enabled");
>  		return -EINVAL;
>  	}
>  
> -	r = pm_debugfs_hang_hws(&dev->dqm->packet_mgr);
> -	if (!r)
> -		r = dqm_debugfs_execute_queues(dev->dqm);
> -
> -	return r;
> +	return dqm_debugfs_hang_hws(dev->dqm);
>  }
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6b2f594..6b89ca6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1164,6 +1164,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  
>  	retval = 0;
>  
> +	dqm_lock(dqm);
>  	retval = pm_init(&dqm->packet_mgr, dqm);
>  	if (retval)
>  		goto fail_packet_manager_init;
> @@ -1186,7 +1187,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  
>  	init_interrupts(dqm);
>  
> -	dqm_lock(dqm);
>  	/* clear hang status when driver try to start the hw scheduler */
>  	dqm->is_hws_hang = false;
>  	dqm->is_resetting = false;
> @@ -1199,6 +1199,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  fail_set_sched_resources:
>  	pm_uninit(&dqm->packet_mgr, false);
>  fail_packet_manager_init:
> +	dqm_unlock(dqm);
>  	return retval;
>  }
>  
> @@ -1211,12 +1212,12 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>  	hanging = dqm->is_hws_hang || dqm->is_resetting;
>  	dqm->sched_running = false;
> -	dqm_unlock(dqm);
>  
>  	pm_release_ib(&dqm->packet_mgr);
>  
>  	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
>  	pm_uninit(&dqm->packet_mgr, hanging);
> +	dqm_unlock(dqm);
>  
>  	return 0;
>  }
> @@ -2099,11 +2100,16 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
>  	return r;
>  }
>  
> -int dqm_debugfs_execute_queues(struct device_queue_manager *dqm)
> +int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
>  {
>  	int r = 0;
>  
>  	dqm_lock(dqm);
> +	r = pm_debugfs_hang_hws(&dqm->packet_mgr);
> +	if (r) {
> +		dqm_unlock(dqm);
> +		return r;
> +	}
>  	dqm->active_runlist = true;
>  	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>  	dqm_unlock(dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index b130cc0..b33ebe8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -448,6 +448,9 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
>  	uint32_t *buffer, size;
>  	int r = 0;
>  
> +	if (!pm->priv_queue)
> +		return -EAGAIN;
> +
>  	size = pm->pmf->query_status_size;
>  	mutex_lock(&pm->lock);
>  	kq_acquire_packet_buffer(pm->priv_queue,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3426743..8a5dfda 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1194,7 +1194,7 @@ int pm_debugfs_runlist(struct seq_file *m, void *data);
>  
>  int kfd_debugfs_hang_hws(struct kfd_dev *dev);
>  int pm_debugfs_hang_hws(struct packet_manager *pm);
> -int dqm_debugfs_execute_queues(struct device_queue_manager *dqm);
> +int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
>  
>  #else
>  
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
