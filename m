Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431CC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 21:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7AD60EFF
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 21:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E7AD60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4CC6E4AA;
	Fri, 30 Jul 2021 21:26:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697AE6E4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 21:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeN6oeKhYXH5unRQ+LKxP84uwCJkQI91Np7jxgl3vofM+2cjJgd4BuAjWNZsSozocQQpmtTvTXqHVXNFjQMnUKIrG50xWGwYHK21+jEJDC6gQgZPFEU8JoXjy7SYfjTT79hrzyiEUj3g6P8lfK/fbJJ7TCxMKzBIxC/P8tv6he+asaldnrMLk4qeLWimZ8pIs+Db6icQ/AdOFeGhC1hAyjystupN9BAYI/vXydZg9svMTgCgDMwAK/PZuwW0gVcwoYu5VPNAnhLDJ3aG7gqOqqvivmTT+CfadLP60mssYScy6IUl5F/Ewoz8LB5eB5GjpGXi3W4JRsz4LJaRgVwUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62a0/IUAZkE8Ix9Fbek6rY2jcrCG/bRQK4rzKMwyd0=;
 b=WNhinOvV9iWtsGfWVOtshi7rtdHvGCu8+Yxa2XNeEBSaDdJSML7AzZwsRUtSHJimEBw7N9SHtWN1nOPFkANGuEF0/jB/CLltvuf6DHSnLetr+/jba37j5ZSKaCKdhXzBatLZMqWCJfV9xF4YLiXpV2yZpErMWJtclP6ZIeI2XSRvWSoLE/pKIaasmlc0xIEtOh94jmATu8Idjstw0Ipk8i/imJOTy6UMcM9eTjrCeWkO5gO9VjgUG13eD5B+dfgp+nK0Vcns9oJJLSXDLNKCcJdG3TwjdeqEjZxK8uWtswA4sjS6ot3h8N/aH6vCEGFG2VxbG+vDBidaeFQchfHOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62a0/IUAZkE8Ix9Fbek6rY2jcrCG/bRQK4rzKMwyd0=;
 b=XBjoEcAhCGplA9M4QNaI4a/h2LTEgS/gVtNZF3QUuZRHn4HyIJ75AZkcOKFbKc50hfDlYJXtb2HDlNlkQOnu2cX1GIEpz6DJkvINQBmh0fXwaBjyLWrbESsCoTp1D3kYFko4xzy6n+U/z10NxVVxGwbkT+9UWASGXwB16VClGRQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 21:26:02 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Fri, 30 Jul 2021
 21:26:02 +0000
Subject: Re: [PATCH] drm/amdkfd: Restore all process on post reset
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210728173154.834263-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <feffbe5c-7400-a3f5-148d-03e7d128aece@amd.com>
Date: Fri, 30 Jul 2021 17:26:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728173154.834263-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::23) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.20 via Frontend Transport; Fri, 30 Jul 2021 21:26:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d74d5416-258d-4615-d069-08d953a0a1b1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52606A0D1F2A15FD011A008492EC9@BN9PR12MB5260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1UNEZ8dqD0qkhNxdbdNHlVXwYm0e4fV7E/GxCIhZW60lF9s5/zKxIE2Z98mHT00gzFH7cYtYSKmzTmLpEQ9k73zPwHvzbuDuQUd4jTTy4vg9ESDLkcimzRjGBNRqZ+2USkikzsvRpPEgv05jO02nbyYc2ZqVshbKfj5EpTpEUXwhXQDwuXGl3wioEH8IBXpchcNh06mKLahbsuMqGwe0wX9gfKytjMcGRqrDf95ILdvbF8uNGKs8BFpdynDfLTUjYP1dHiqru29pIoOYcSIMlmM1zRn6GCRWTZJvuY2+j74AvN4OkaWDEhzUA+uRmI0ZC+tQ6jByIRCKer/wqFkB4rY9mVHRstg2mb5mUC1/XxQ0Z9BO7KKUYxqeG448/Gg+J/nGZ8TEyY/cXXnMc0WbeD4Q97FxVHaoEvekPbgH+1mS45FE04zem35/6Ue/60bEXLXiAOfg1b24us+TE14kK5avxGzoS6hM1C2WYLfgOwCgmHiZamuPCDewgWJfNtO5oDNt7qji+WLb6ZL3CVcwyaaa9nP3tT5M/+9MjtLZRDsJwJEO5OewVIRpRBJWAryQQ9tk6zOEtOJpZhVaa58essSs1+hecOWHBx5/7S8ODqRRsJ2Dilr0vC1SSHcADaWN1px1cIOu5mJesPyFfL86yfEhZnT2Pt7MsxO2FVwnXIgYIONKfKtkC7jGt/JksVDezwOXUS42LcvrS1HzQaJM2Lj7yFkfryOQzayM2IH5b8/hPO2OleL4IPJz/DRQga/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(38100700002)(2906002)(8936002)(956004)(83380400001)(31686004)(66476007)(316002)(8676002)(36756003)(2616005)(44832011)(5660300002)(66946007)(66556008)(16576012)(86362001)(6486002)(26005)(478600001)(31696002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJQaFFGTkZnRmxQN1RsdFY5bFJJRzI1YWlEU1B0MTBlQzNJWlkxZDJBa2NF?=
 =?utf-8?B?MDZ1T0tvZkFJNG81OGpCaVlTcmdFUENYRUhXSlhyNnhOQXJRWDJ0YlpOZjh1?=
 =?utf-8?B?dXJkaXo1SXZVSEVDYVZrc2F0cnliVDhEanc1ZG5YcTR1NFdzZldiNmhoT3kz?=
 =?utf-8?B?L0VGL3NxUHlJV29TYXpkZ3JTNDhlcmEybWFSVHd5a2c3QXhsNWVFM1NSekVh?=
 =?utf-8?B?dUpUMDN4bk1Ca09FdmxyVldaSUEvRGRpUWxqTE1SSzZRMTR3cStLT0lKMjV5?=
 =?utf-8?B?RzJwM2xVUDRTdHVvRFIrajVKc0FOMkpYNG8xbkZvdnhkckJBeEJpUi9NaXpX?=
 =?utf-8?B?ZXNpcW9rTlo4ZndjaGszYTlpWjdNVTdVQzFUOG05TkNJbU9PVU1NSWUyTXRy?=
 =?utf-8?B?V2xzNzRVRm1xOWg0Y1F2VU1ZSk5uODFwODUrMkN4QUhTSG5uWnUzNDlBNE1s?=
 =?utf-8?B?aGdZanlNUWJEc1pVd0piOHZUajBORzJscmUvTURWK2hZWW5vUWp5Wi9YSnln?=
 =?utf-8?B?VURRVFdhWjhIbUdwODhhMWZ6Z20rdHBrVFEweFJJTERKOFdSM0NkejZuWUVX?=
 =?utf-8?B?Qm8xVUJ4ZUJiS0Y1SDNJUTJHTzRGOUdJRjhBUk14Q0Ftckc2WjQ2MHZEYjJU?=
 =?utf-8?B?QVdRZjFRdFRnMXc0RjZjNnd4Q3JobEZ3dU01aGJmQVBSRzVsOStRcjg0RitN?=
 =?utf-8?B?QzdVWGYxeDVldW16SUZGY3RwWUF0OUdVdFMydkRCbzJabG1PN2ZwRUpNOTRT?=
 =?utf-8?B?WnFaS1l4THhoSjJ2a1Z3YVJYS29rVXQwNE5FL1cwNlNQTUZrRDFIOGpxYzlV?=
 =?utf-8?B?eUFxT2ZwWGY5ejRhczVHOVJkYmpVcE9mYzdLL2c2U05JbSs3QUZlbFFUZHhT?=
 =?utf-8?B?MThpeDdTekU5RXJMZElnTmo5NUlTeEdLT0o4V01wT1UrVXdxWE1oSUQ2TExJ?=
 =?utf-8?B?Wm9acmFHRTRUUlJJWk00L09kaWd5L0xLeEhCMEt4aXkxbmYzTDA5QndyYmll?=
 =?utf-8?B?c2p6ZGF6a3QvSlpGZndiKyt3aHUwZ1hMblIxbEZ5ZlRocjlsdmF4SndTWXA2?=
 =?utf-8?B?WWRuM1dQdXBkZk1NT0hPc3pXcndYOE5Pd1Z2K1QvaEdYRXV4VHFrbi9WaHNB?=
 =?utf-8?B?Ylo3T2Q4K2ZuVTN4VHZVTzhBRW1ZV1ZrcFo0TytXMW1xZ0RZZENKOFZrRG5t?=
 =?utf-8?B?QkQxVm5zN0pWa2xVV3FsMVFvdUFQUEtrSEk3WWk4SWJYTk81Y0I4YkpwOUZT?=
 =?utf-8?B?cWdXS0U3RzdKT2NVb3ZuUVRxbmZaV05hNS9hMWFvRDdaZDliYTNRRU5qTUM0?=
 =?utf-8?B?T2VYYkVyMzRLSmZTcVdRd3NkWHMzcTdqNWc2ZWhpMWNHM1ZDdi91OFMyZ095?=
 =?utf-8?B?RldZZ1kyWEhtKzN4ZE41ZXg4TUpKMnloa2ZvSnROT1lnN203c2xzbTRtYU1y?=
 =?utf-8?B?M3RuOVhvTlFqcGp5REVnZE1nZzIra0t1bTNZNlVSR0tOdW1NdFhnR0lDMTF0?=
 =?utf-8?B?aFlMYWVMSzZIemFPbUNOQUpJbnY4UXVlaURWeENpdGpVUlFZMm9LM1BGQ050?=
 =?utf-8?B?dXI4clIrUGxNVzY5L1Bkdm5CbU9MckJmN0FhWElWSEl1RVhzOTZKa21ERWIv?=
 =?utf-8?B?UDN2TmxqT3FMSlNONUNaZmJ5RnBYQXdtdnpBK080Rm5HVnk1Mk5IeWFxSmFW?=
 =?utf-8?B?R09rT1pqQTZhM2pWV0lpWTkxL3pwK08xYllpcUpTYkNDNkdpWG1LNnV2WW5B?=
 =?utf-8?Q?f+lnqfX+4tqyzpbi+ZiHGzr7LgQqSf2rXp+Brse?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74d5416-258d-4615-d069-08d953a0a1b1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 21:26:02.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+PBBt0vAK9h3qGjEj7p1uFCwaFOEC9gvEGwu/K65TVVz0K0z3JEaeORFM+eriSF0kbYxqnQqlahZReMYxqZ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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

Am 2021-07-28 um 1:31 p.m. schrieb Eric Huang:
> It is to fix a bug of gpu_recovery on multiple GPUs,
> When one gpu is reset, the application running on other
> gpu hangs, because kfd post reset doesn't restore the
> running process.

This will resume all processes, even those that were affected by the GPU
reset.

The assumption we made here is, that KFD processes can use all GPUs. So
when one GPU is reset, all processes are affected. If we want to refine
that, we'll need some more complex logic to identify the processes
affected by a GPU reset and keep only those processes suspended. This
could be based on the GPUs that a process has created queues on, or
allocated memory on.

What we don't want, is processes continuing with bad data or
inconsistent state after a GPU reset.


>  And it also fixes a bug in the function
> kfd_process_evict_queues, when one gpu hangs, process
> running on other gpus can't be evicted.

This should be a separate patch. The code you're removing was there as
an attempt to make kfd_process_evict_queues transactional. That means,
it either succeeds completely or it fails completely. I wanted to avoid
putting the system into an unknown state where some queues are suspended
and others are not and the caller has no idea how to proceed. So I roll
back a partial queue eviction if something failed.

Your changing this to "try to evict as much as possible". Then a failure
does not mean "eviction failed" but "eviction completed but something
hung". Then the GPU reset can take care of the hanging part. I think
that's a reasonable strategy. But we need to be sure that there are no
other error conditions (other than hangs) that could cause a queue
eviction to fail.

There were some recent changes in pqm_destroy_queue that check the
return value of dqm->ops.destroy_queue, which indirectly comes from
execute_queues (sam as in the eviction case). -ETIME means a hang. Other
errors are possible. Those other errors may still need the roll-back.
Otherwise we'd leave stuff running on a non-hanging GPU after we
promised that we evicted everything.

See one more comment inline.


>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 24 +-----------------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 24b5e0aa1eac..daf1c19bd799 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -984,7 +984,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>  	if (!kfd->init_complete)
>  		return 0;
>  
> -	ret = kfd_resume(kfd);
> +	ret = kgd2kfd_resume(kfd, false, true);

Which branch is this for? On amd-staging-drm-next kgd2kfd_resume only
has two parameters.

Regards,
  Felix


>  	if (ret)
>  		return ret;
>  	atomic_dec(&kfd_locked);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 38a9dee40785..9272a12c1db8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1879,36 +1879,14 @@ int kfd_process_evict_queues(struct kfd_process *p)
>  {
>  	int r = 0;
>  	int i;
> -	unsigned int n_evicted = 0;
>  
>  	for (i = 0; i < p->n_pdds; i++) {
>  		struct kfd_process_device *pdd = p->pdds[i];
>  
>  		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>  							    &pdd->qpd);
> -		if (r) {
> +		if (r)
>  			pr_err("Failed to evict process queues\n");
> -			goto fail;
> -		}
> -		n_evicted++;
> -	}
> -
> -	return r;
> -
> -fail:
> -	/* To keep state consistent, roll back partial eviction by
> -	 * restoring queues
> -	 */
> -	for (i = 0; i < p->n_pdds; i++) {
> -		struct kfd_process_device *pdd = p->pdds[i];
> -
> -		if (n_evicted == 0)
> -			break;
> -		if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
> -							      &pdd->qpd))
> -			pr_err("Failed to restore queues\n");
> -
> -		n_evicted--;
>  	}
>  
>  	return r;
