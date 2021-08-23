Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ABAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55A4613BD
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 18:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C55A4613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C5789B0C;
	Mon, 23 Aug 2021 18:29:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3931D89B0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 18:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/GvTt7IzJZ4ouSGTIEpavGgtFS1gjLBW2mVqzAPJuvcg1czmTo8DyCPTSEZSB+Sho5N36uKFr7HWY/fqORxyHjSxsYASgalH/n1HtjPPZfTNmHyKutDLUrwXl83bgAvqomM5FqQwOguQmnpLgJYinl2uBJK7J44zheI2RDFq0rqxsKbVoN3DBpXocvko6EtqULNogalVnRMRcQjT8OdjNNnu+y3i3VzRh4ooP3GdVSHXSRmsEvBQTGyyepsKeG2ZRqxLEIPm+RKL4VtQFEwZwaoHnLIh78WFYsmaHu5pf6anaMu2P2O9qQhPUAPa2u4InM5dz6KO06zmGHntrF8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrJb6AQEqGzwlZ+TWAMf+MCz/rVWciLYcbx4Iseg+7I=;
 b=PLyD0lg+7CLj3MozkWv0XnlyKoyCmS/Jd43pzj8TR2vJ0Qm38vvbbP41ElJrdn46XEHWWeeMdIyRft/XI7vcQQP9L4X+PIuLqsr9yhDrnufUKOGKdqUkU5YJiAGn7KY/0SIzExfiWx1OQ6ApUz/ojOns2re5kRLMM3vl0OeOHEmfFpfU3a8kc9dlqApnWSo/BgTGV3uH+G5sP7kar1jmjGSCow0nRRpw1fmlsPoGVBPrImSyhxmYKueQva6d589Qc+ZHSHEj8aQO4xq4SAvBpDnM/PESflY8sLRrVFaYYOGZG7D3iYSKZs5doTQMJ5DwUrVgN52LpRGZcLFT9TZPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrJb6AQEqGzwlZ+TWAMf+MCz/rVWciLYcbx4Iseg+7I=;
 b=aWbPX8qIQm7zQ7s72Nf6Lkfg6a49obtz2+5vJ4Wbmx7r+N+LvrUDgkuAFn880Thr/oiLOCiax5DIPAsUTzc9OQerj6UFQZN9A+u7heN8dfw5XneHcHm3aw2b324qA5nfBbfYDy4QaI011lS540LSrJlFL8meJoGiX+GcJpi8eco=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 18:29:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:29:53 +0000
Subject: Re: [PATCH 10/18] drm/amdkfd: CRIU restore queue ids
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: rajneesh.bhardwaj@amd.com
References: <20210819133713.4168-1-david.yatsin@amd.com>
 <20210819133713.4168-11-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6fb17533-3247-0f38-a071-778c788cee26@amd.com>
Date: Mon, 23 Aug 2021 14:29:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819133713.4168-11-david.yatsin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:29:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a072794b-98c2-49f9-d392-08d96664001f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB509980D836525EC7E02FFE2892C49@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwOtMWyb5UTiNlC1g3Uj0w6MnZP9ZX9RAPMDlmGkwBcRuDxEjg4SQzlwxcdhdYM9U+QITmMbDgxI1SS5ZhKniv1kSgoRpjjh02v50DiujnWzPvWdM2BJD73kcGD0G+d+UEL+j1tLq7cIikbY9IhQ4mofwjmIc2cTPcc4XNfwCf9MBQdxhKiC8LuskKqpn4Kfr6y8T9+DVDH3img6jshGzoiWjYnKtJZ4eUg2D/sDBCgBcrqcO+ystiaxRkQAhJGAirG3cR8xsnxxCpOgDGsTI3ryebB6e/FZh6Htwcg7taMqMvI+gb5ttQWMcxcL98rUuWADiO75W4Eex9iHD1ov2HIX+rkdeBa+lGTiII5x+gwjokcyGWl60BidyI5grrk2IeFtuJaFFdCegOP80TzDPdaowlFq/ncAgzugSuNtnjYNADF4yC4du1wiQtxmWPM5aEcnww/8vCWLJazS/fYn/pIJhxffKhSXDIIFPQAPPIqmGeYbm2RvoCuXHsKt9mZPO6HQRhk53Pk+G6kbfViQbH+puEg3vKDL15p26rLANSC7q7xwz5HMHUWnyb47qgJGBEL//oTFpuMLGeYLAC3PdFyXtBF5fZlG8gbhIvs9zENtEv0SY/sOgxM5MQAqYLg5bLcyOGacIRBnXnfcteJir4nUuMhDprgETT+poWtY3/CrErUMGnXy3SoUX25lRt20jykDROD5l6/OoBen82/uctIOE4Z2XHfkrCtkQrDD9wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(2906002)(31696002)(16576012)(6486002)(316002)(86362001)(31686004)(8936002)(36756003)(2616005)(66556008)(956004)(66476007)(44832011)(478600001)(8676002)(186003)(26005)(4326008)(83380400001)(38100700002)(66946007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZ6OE9wWTJnUzF1R1RNTlRiSHk5TFFFaTdBVzJ3eG1tOHpKQWxvYVNOaU1q?=
 =?utf-8?B?QytkT2ZlS1E2cVVjaXNnTUFPNXlTNzRabmhZN1c5VWNtL0ZIcTlJTkx5SmFJ?=
 =?utf-8?B?eDM3bE5ZMmo0SHllR1dEN0RQV3lQVnJzbGlPcWpMeGVXcVlDNDAxSkNQNkhU?=
 =?utf-8?B?UUEwRjZHSUxTOEk2VEk4dnA2MUhqMmhFUUZIVXVLaTl4YVRYM0xYMTVuTVJY?=
 =?utf-8?B?MmZlTC9seXF1OE80RGJLRHdlbXAwUXBTR1l6djZqSlBoMG00a1h3SnF5UUpJ?=
 =?utf-8?B?WnlRaG95LzR6NE8xWmkvOFcrTEFEL09TRjU3cUdZbmk4TjVlTkRvWnpDTm0r?=
 =?utf-8?B?aHo0TkJQYk9MM3ZyTHFCUTZDN3IyRG10dmtQUE5US0J2Uy9XaFZ6TGpIb0Y1?=
 =?utf-8?B?NWJDK2Y0eG1DVVg2T2ZoOXkzVGJTVnluL1kwTmh1YTEwVWNnejVqaHVZVjRW?=
 =?utf-8?B?VzVsRTNNdWxIdFlKMXRDSmtFWXdBdk9TcVo0ck5JSUVDbkc0Wi9xN3BsNml5?=
 =?utf-8?B?ZUJoZzFJUTFCL2VTMVh2ZDFxRjU3T1lNMzRBQ09uTTJycHFOTGR1RmZvR2Na?=
 =?utf-8?B?Z25EOWN3eVdiaUoyWkxES1lwdEZtdzhGTXB0MFEySkUrVTc3anBZUS93Mzh3?=
 =?utf-8?B?OWNNdlN2SXlVL3Z4VEhiNVBBMlNQcXliL0pMYkwxM1VRdUxXRHVNelVoZVIz?=
 =?utf-8?B?ajNTTnpQanNmMThXSnlHUlg1dENNcTFzTXVuazQ3YUIxU0NQaExzbDdTN0tK?=
 =?utf-8?B?NUV1Q2hKVkxWT05QOVc5OUsyVlZyb0l0QWUwMEFyWkhITFY1dlJxcnJBVk1k?=
 =?utf-8?B?aEc1NWtlWWdNMWlZMkpsZkttNGs4MkcxYlEwNzc4VXQyM252aExNdzlHVGJN?=
 =?utf-8?B?cVJVaVlnL0hEYTcrUnZSYzdvcmJDWFd5dFNBejBVK2h0ZGxnZVFCa0hma1JY?=
 =?utf-8?B?V1dUMHRSeC9ydFg3QS9SNmg4NVc4MGpMUjVqdERCY2dVaHBEeEVZbXVVSjJs?=
 =?utf-8?B?TUJhaUwxcS9WS0NMWHh4bFVNcU1RZkF4Ni9DSGJaYWFSR2g4YkZZM24zTTU0?=
 =?utf-8?B?VEZIRmt3L2lvM05oNkFlS2JiM01rb0JkRC9LV0wzODlBRUViWFovZ2ZCMXBa?=
 =?utf-8?B?SkNqWnNRR3hjKyt0K20xN3p2Q0d5S2QvVW12cFE0MTV1UDV1R3dXTUtBWmFp?=
 =?utf-8?B?M0JNblp2TkdBZ25VSUFPc1FWRnlCenRQSnRGS0tuS280TDA4OXJGVEgyaHEv?=
 =?utf-8?B?SDZYR3JwcHVLZklJamJzdHZ6Q1pTWmpiT2FUSEpTZStQSHo3Qm1YSWRQTDlP?=
 =?utf-8?B?djc1c0Fmemkvc1JIeTI2NVBXUGxDcHNNRGZUQ0w1aHZycTFVTFZ6V21nNEVo?=
 =?utf-8?B?SStZN1pNZmsyWnYwVEVYQmRBU2RhNFFmd2VGZ3l3Mm1obWxJYjBBcVo4R1FK?=
 =?utf-8?B?WXJpeitnQ2pRcXdiTDdrZ1Zvb0pPb0ZQVTFVRUxCcjYvSUZkY0hGdE1OUk5x?=
 =?utf-8?B?TE9mOUNGcndyMkZ6V0pKT1VaSzNGQXN3YytZRUx4T050ZWZIT1E0ZlN5MTZ4?=
 =?utf-8?B?NWphZ3IycHZpS3RkMUhsS2RWbU52R0VKWEtsNktNRTloQTcydWQ1RGVHcXVZ?=
 =?utf-8?B?ZG5CY1JmOXV6WjRFOGpWZno4MEowTCs3aU1TOTVqRmJPTDBTT0cvcnRPdXlm?=
 =?utf-8?B?V3ZKaUVKWDlhVDFmZFVtTFYrNVlvY1pycEtLTy8ybTdnNmVvNHNTZEQ5QS81?=
 =?utf-8?Q?hfnExcCBWpYKLuHy529LN6RKZ4NFiftHJPrF9pe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a072794b-98c2-49f9-d392-08d96664001f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:29:53.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndleghXob7pAbF9Xtw5uZxA/xfSwO1meimAIQbfxqGvfVy9XktF++sQOw610qtB5JnQv4aagg2NQZw+PWs4SvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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

Am 2021-08-19 um 9:37 a.m. schrieb David Yat Sin:
> When re-creating queues during CRIU restore, restore the queue with the
> same queue id value used during CRIU dump. Adding a new private
> structure queue_restore_data to store queue restore information.

The sentence about the queue_restore_data structure is outdated.

Regards,
  Felix


>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 22 ++++++++++++++++++-
>  4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6f1c9fb8d46c..813ed42e3ce6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -312,7 +312,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  			p->pasid,
>  			dev->id);
>  
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL,
>  			&doorbell_offset_in_process);
>  	if (err != 0)
>  		goto err_create_queue;
> @@ -2543,7 +2543,7 @@ static int criu_restore_queue(struct kfd_process *p,
>  
>  	print_queue_properties(&qp);
>  
> -	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, NULL);
> +	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
>  	if (ret) {
>  		pr_err("Failed to create new queue err:%d\n", ret);
>  		ret = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index 159add0f5aaa..749a7a3bf191 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
>  	properties.type = KFD_QUEUE_TYPE_DIQ;
>  
>  	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
> -				&properties, &qid, NULL);
> +				&properties, &qid, NULL, NULL);
>  
>  	if (status) {
>  		pr_err("Failed to create DIQ\n");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4b4808b191f2..eaf5fe1480e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -468,6 +468,7 @@ enum KFD_QUEUE_PRIORITY {
>   * it's user mode or kernel mode queue.
>   *
>   */
> +
>  struct queue_properties {
>  	enum kfd_queue_type type;
>  	enum kfd_queue_format format;
> @@ -1114,6 +1115,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			    struct file *f,
>  			    struct queue_properties *properties,
>  			    unsigned int *qid,
> +			    const struct kfd_criu_queue_priv_data *q_data,
>  			    uint32_t *p_doorbell_offset_in_process);
>  int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
>  int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 95a6c36cea4c..e6abab16b8de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -42,6 +42,20 @@ static inline struct process_queue_node *get_queue_by_qid(
>  	return NULL;
>  }
>  
> +static int assign_queue_slot_by_qid(struct process_queue_manager *pqm,
> +				    unsigned int qid)
> +{
> +	if (qid >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> +		return -EINVAL;
> +
> +	if (__test_and_set_bit(qid, pqm->queue_slot_bitmap)) {
> +		pr_err("Cannot create new queue because requested qid(%u) is in use\n", qid);
> +		return -ENOSPC;
> +	}
> +
> +	return 0;
> +}
> +
>  static int find_available_queue_slot(struct process_queue_manager *pqm,
>  					unsigned int *qid)
>  {
> @@ -193,6 +207,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			    struct file *f,
>  			    struct queue_properties *properties,
>  			    unsigned int *qid,
> +			    const struct kfd_criu_queue_priv_data *q_data,
>  			    uint32_t *p_doorbell_offset_in_process)
>  {
>  	int retval;
> @@ -224,7 +239,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	if (pdd->qpd.queue_count >= max_queues)
>  		return -ENOSPC;
>  
> -	retval = find_available_queue_slot(pqm, qid);
> +	if (q_data) {
> +		retval = assign_queue_slot_by_qid(pqm, q_data->q_id);
> +		*qid = q_data->q_id;
> +	} else
> +		retval = find_available_queue_slot(pqm, qid);
> +
>  	if (retval != 0)
>  		return retval;
>  
