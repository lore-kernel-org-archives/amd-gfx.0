Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD1C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 18:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80A52075E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K+gXoDZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD9F6E0E0;
	Tue, 18 Aug 2020 18:35:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B983B6E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 18:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nydwoJYcP26GQWd86pxa6UiV+vX0Asg1wOuStnGnxh/QkIzl5VDOQa0a1rZNsQXpxfoBc3CKwJH5RaKVlHsc+ULb/+51V4WkWYkYzbomN3rbi+5cWQRCzFy7rFYESc7TAbBXsLE8fWZXpqu9dtzY9xgF7Ep1nk/46tRg+JWY3GfJdYUHdl1+zQJO8u4HzEtxRAoKUj1F/oWlXtjNMspYk3YRyHycvOr34DOxfvz7oBjjiudh9J8mdwOUCREIGp3YIUOw55n6S7IrDeZJVKxH5bk4TvEVLIk5aldzJzSurEcL6TTetFcf+xufwU6QaP8iIvbLMcaQq5AK4qk9AKRQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40mQ/DMzLm29/0v8rFlEJiPQxU3O1Iwyi1vpnWUTIAE=;
 b=fKBxSY9886wvO50bgizFxJODw2EYC6f3OIRjyGrJx93b1IOMiY0oivDNCJxc4YwN3ncDd5D9lVRgOASK9SQpAd1elMuCKpFSPeZGdXazbG7btsLK2cPHUomoV1yyjH5efX3+bgppEnU+IeDcog16GYmf22UBEw+h2fHRSOYGfKfh8ogDdNll/gyVhzpXeKqCq0b2JqAMny+zwU1JSAZ4SdSEINYW2At2M9Wf1YkYlbmJG9vAkp0egFUZc/rI/gG7Px8Q6xyxKDEf4v3fcvtMTH1Zy22AbmgBDdwDj4dClaJZjnsaBhEkwjazgBpLQ8+pCvYhonBNHr2npPbR62w7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40mQ/DMzLm29/0v8rFlEJiPQxU3O1Iwyi1vpnWUTIAE=;
 b=K+gXoDZVUiOd9fPT+yqwTn+eYprWCeyOMNIHYSDpaa6Qc7JF6evLM1KKhoSvkyfMM+9evu+tKe+MPnxz3YYeL/28cOqUESTQwT6ZUoZoK/OlyKRNgfvS/QHpWlYHEbKkWnUsqnfPOSFsb8SkCPGe2f+LOdWhZ4CsxSDNYtectlI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 18:35:20 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3283.027; Tue, 18 Aug 2020
 18:35:20 +0000
Subject: Re: [PATCH v3] drm/amdkfd: sparse: Fix warning in reading SDMA
 counters
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200818160845.27134-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dba362c8-4027-047d-808a-140aa03710bf@amd.com>
Date: Tue, 18 Aug 2020 14:35:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200818160845.27134-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Tue, 18 Aug 2020 18:35:19 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c68788f-2a86-4a12-a231-08d843a575c0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430ECF689CE05B6AA6EF851925C0@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgnK1PCGxDFtNCqntP4DZTxt/YXaV13n3ZpjBSFjOmSCueX/FqBWfZrNbJlZyh98yvFCGcPDhk+ZC3WTmMzbt7nOYLI0Snol2gCO7emlqksrVMoW5kvzTg9fWbWHtLmPKX4UIL8BAo3K75Mk9K6irliQoQLNjefGaMoUyvokbqSZllXgr9ip+/nbDH9oqt03NspxhnJYx7J6hLKaQiY9NHAFaZOgtrsJtur2u/uBsbg2dqP0aNQpourl8R3I2zSSgdQ5bj9yD5NmgjbkaFgClXy06mP2hc8qvyPq0F5/+fI8F3NMKNh0/lU6H5o+RNctauLnZm5e+4qRpXqklnLWuYcTKWAHTdM4tcOkY2lTz9VI9RlMAxH9o/gmo8EEFdvH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(31686004)(66556008)(5660300002)(66476007)(16526019)(16576012)(316002)(66946007)(8676002)(52116002)(26005)(186003)(8936002)(478600001)(956004)(83380400001)(2616005)(86362001)(36756003)(6486002)(31696002)(44832011)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: okvW6fB3C3gNwPl/+zS24gT23BFcL369yUQ4LLjynUD1v/BBE8eiKK88wXQmtdytKt/puzoPaUbl+unK1+IJQKUvMIURLTzMn745H6aJJ4V714/IohYjNVwluMUGSnWqfGbN1AGXYYo5/dCmNWSlmBgzdnuXA7GNoocUPrslyZ5od3FRMYaN9KTWyvrAkxjPQgZJEqgnm72NZ1wtF4xLMuIHldD0f9oZuy/nxeV1URZH9CwyXpZ4Ao1PHyFQpHH8vdTqpPmdSHSoxO8+M3Q/CHJlvI9aoiG2TCmbXftYyzttrHHK14482QZNe5+jE1fXsTkAxhs9FpPUfbfDcgsgDL89OHmCzkUr/tm0S4yWATNugQHXmcTpP88EbTaGMGoLN3jI7Vl5GQPxVURFmImTDmC1UYsMDcBsuv0IPVAoZOHH5d4IXIjbZPLfKyAgcFJNJsde/kZQ45/RFBWUc2VeonouxC8H1bAjQQnWNySzDYsjJT27laSvDo5DTjN0Vr3DmI47xAKo+BDF7+3fOvl0MkSNdEgpKNNhHmp7b6gJCivaTcgT27MKhl2jsuZJG7GCal7sNVxknXJ9okzK9TYpnV2u4LiMgVp+nnSD4+XikFyIsEj61PE9Xw99Hn+uwcxhlqWUoNJxsN3Yc9OMtXeQQg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c68788f-2a86-4a12-a231-08d843a575c0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:35:19.8867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRcvLuKwxhIE6jNu3nLm+O78onHEzRukZ9jcGTJKmnYyr8iEPYM6PsXxYy3Yd/d75Fu9TqfoMP+9/UrUmEv2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-08-18 um 12:08 p.m. schrieb Mukul Joshi:
> Add __user annotation to fix related sparse warning while reading
> SDMA counters from userland.
> Also, rework the read SDMA counters function by removing redundant
> checks.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++-----------------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  8 +++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
>  3 files changed, 12 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e0e60b0d0669..560adc57a050 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -153,30 +153,6 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>  		dqm->active_cp_queue_count--;
>  }
>  
> -int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val)
> -{
> -	int ret;
> -	uint64_t tmp = 0;
> -
> -	if (!val)
> -		return -EINVAL;
> -	/*
> -	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
> -	 */
> -	if (!access_ok((const void __user *)(q_rptr +
> -					sizeof(uint64_t)), sizeof(uint64_t))) {
> -		pr_err("Can't access sdma queue activity counter\n");
> -		return -EFAULT;
> -	}
> -
> -	ret = get_user(tmp, (uint64_t *)(q_rptr + sizeof(uint64_t)));
> -	if (!ret) {
> -		*val = tmp;
> -	}
> -
> -	return ret;
> -}
> -
>  static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
>  {
>  	struct kfd_dev *dev = qpd->dqm->dev;
> @@ -552,7 +528,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>  	/* Get the SDMA queue stats */
>  	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>  	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t)q->properties.read_ptr,
> +		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>  							&sdma_val);
>  		if (retval)
>  			pr_err("Failed to read SDMA queue counter for queue: %d\n",
> @@ -1473,7 +1449,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>  	/* Get the SDMA queue stats */
>  	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>  	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t)q->properties.read_ptr,
> +		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>  							&sdma_val);
>  		if (retval)
>  			pr_err("Failed to read SDMA queue counter for queue: %d\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 49d8e324c636..16262e5d93f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -251,5 +251,11 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
>  	mutex_unlock(&dqm->lock_hidden);
>  }
>  
> -int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val);
> +static inline int read_sdma_queue_counter(uint64_t __user *q_rptr, uint64_t *val)
> +{
> +        /*
> +         * SDMA activity counter is stored at queue's RPTR + 0x8 location.
> +         */
> +	return get_user(*val, q_rptr + 1);
> +}
>  #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4480f905814c..ff7686250ae0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -87,7 +87,7 @@ struct kfd_sdma_activity_handler_workarea {
>  };
>  
>  struct temp_sdma_queue_list {
> -	uint64_t rptr;
> +	uint64_t __user *rptr;
>  	uint64_t sdma_val;
>  	unsigned int queue_id;
>  	struct list_head list;
> @@ -159,7 +159,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  		}
>  
>  		INIT_LIST_HEAD(&sdma_q->list);
> -		sdma_q->rptr = (uint64_t)q->properties.read_ptr;
> +		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
>  		sdma_q->queue_id = q->properties.queue_id;
>  		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>  	}
> @@ -218,7 +218,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  			continue;
>  
>  		list_for_each_entry_safe(sdma_q, next, &sdma_q_list.list, list) {
> -			if (((uint64_t)q->properties.read_ptr == sdma_q->rptr) &&
> +			if (((uint64_t __user *)q->properties.read_ptr == sdma_q->rptr) &&
>  			     (sdma_q->queue_id == q->properties.queue_id)) {
>  				list_del(&sdma_q->list);
>  				kfree(sdma_q);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
