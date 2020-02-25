Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E056C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FCC2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YQPfV3nU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FCC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2626E987;
	Tue, 25 Feb 2020 17:06:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE28C6E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 17:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwP3hxUq2NILnC4zUAh2ksNMGWVaZATrOzZeKxlnJQ79rRduj6UJvbMehjGB4H12ijCj91K3VjmkfK0WzoD/tAbUE9AICk7/j3nnjmXylHU9mWt/BB0AIqfod9pUNEHQqMZVf5WAVibJWge3+VDjQyfQ7I8O116jF77075ZgKFm3JWPswd+7HhF61nh2s7QrNsxdEjHZMGjbVGdayRESufzWArunIcpiQkd6pr81rpnYH2mt5gTcChkIR8sXqc49E7c8Iuj4FZYs4kCpKtPxV711QSNqkTzvw/3KwltxLr7qx3LXyHc6OsT8Ltd9CwXCQtF8kmcImZ0qKJc87FcctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI8f5PtpjNSJzSyQgRgj6ToWuIjkMyP8KU6oEJnW/8Q=;
 b=aUPw1O1EbRab7Whjoyqi1v/KkTP61Cd60kuyly5xkurevVHh/p9hDrM/ihYui6xpNqfBhkEtQWkJpHoSMZ2TBZqclHERDO37AHPFTWg+zDgNoRtW/3Wk+S01pSyELLFtWh8RMB/JFCmPPcL0PA5EQnI6V63Uk5tETuvx2gnSG5FByNanVmA5mvlP/dUIoZPT1JurfL+TsdG7nn/du6zCiwgPZOIfju63XDNTGDsJjRZXLRER3yGbxy3FG3FzTAw4ui0cOPUzuSxv3qKNbLkH2VunHEIisqCJYaRrvR6QYhRPNsglTSRP/onPwu0+217QKq0eX53BdWQni6/y0CmxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI8f5PtpjNSJzSyQgRgj6ToWuIjkMyP8KU6oEJnW/8Q=;
 b=YQPfV3nUtYsPDKzv7sbKJ78gUx+ZfkuJrS9vaLr/3gZ0+ZTQ01K1+GBanaFuCi0FG/RZuHOfGWQTQtvlbI57AgyLGgcQXc3X50dn5pr1fqHs90dkBitiylz4e3h+e0M17D2g+WJ3TfTzqcqRjMuGQKmK0gUBDlZ6l8UJjGTSdA4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 17:06:19 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:06:19 +0000
Subject: Re: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
 <20200224221842.14110-6-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f99701ac-37e0-def4-4a58-bc1f24bb28d5@amd.com>
Date: Tue, 25 Feb 2020 12:06:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200224221842.14110-6-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: DM6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:5:80::49) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.50.63.88] (104.129.159.211) by
 DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Tue, 25 Feb 2020 17:06:18 +0000
X-Originating-IP: [104.129.159.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d60bc4a4-9d1f-4edd-104e-08d7ba150807
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:|DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490F45F83937D8EE0B797CB92ED0@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(44832011)(478600001)(31696002)(30864003)(36756003)(66476007)(66556008)(31686004)(66946007)(2616005)(16576012)(6486002)(2906002)(26005)(5660300002)(8936002)(316002)(81166006)(8676002)(52116002)(53546011)(16526019)(86362001)(956004)(186003)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2490;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZloVH5Hcqow0rhOP3/+LsnX/1rG5+uaRk1rwmhvz3jfsn/zg4zn0E6CpbpCnMXxkTr8oA2150rAwDurVfYr8+6Re+3FnQ63aZg1BGs4l1GjjOeYIJFXOUalRvU+g3yuTNMlzyS49H3//KiosuBbmInIxeinElMuMNCJ9q+imNlFvfjfFpAzMagLP8qca2HdLMrnwk1hHsjiitGagBRRRDdV/OiEeWXglx7kTSRnkIBjLF/YmLtJGGolKLdeaenRnQgBXCqkk8yftsMMtpOCu+eD+gRu1ZQISbf7Kt/wq+PALfj243m2iDndWVW6zzTRovrnswlhOoVV3SRp2Y6ANNo3I92sEmia8h91tUKE2TH+bPUydgGpaqIfQSNYEKxd6OKreHfKwp5uRxDhidwwN/MFJlc6+Im8nKNjYvDOXLLJXpK72F0zTtta1YMEOybjc
X-MS-Exchange-AntiSpam-MessageData: jXOTcu4EAO1688+fvR5AcTTJseTsSOPPbjnW8h9TWRaJBieqkvVU6+acKWX1VgugD3d7MfPeaZ5D42ap+IwpQDp8fLcNT0qZW9/4RVBBidQeVyoY3GLUbDZQVxKs7Ktzic2wpsIyG+jq6m4NUS0rCg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60bc4a4-9d1f-4edd-104e-08d7ba150807
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 17:06:19.0613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwesCszieYIA9zEoxUonFihnQffY4oo6dUHnIxta4m9RMct4V0OrFnYD8WZRoKkXRq8fWVHaq4VdZtF94Ii7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As I understand it, the SDMA queue counting wasn't incorrect. The main 
change here is that you no longer send separate unmap packets for SDMA 
queues, and that makes SDMA queue counting unnecessary.

That said, this patch series is a nice cleanup and improvement. The 
series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

On 2020-02-24 17:18, Yong Zhao wrote:
> The previous SDMA queue counting was wrong. In addition, after confirming
> with MEC firmware team, we understands that only one unmap queue package,
> instead of one unmap queue package for CP and each SDMA engine, is needed,
> which results in much simpler driver code.
>
> Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++-------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 -
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++--
>   3 files changed, 29 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 958275db3f55..692abfd2088a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -109,6 +109,11 @@ static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
>   	return dqm->dev->device_info->num_xgmi_sdma_engines;
>   }
>   
> +static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
> +{
> +	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
> +}
> +
>   unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
>   {
>   	return dqm->dev->device_info->num_sdma_engines
> @@ -375,11 +380,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   	if (q->properties.is_active)
>   		increment_queue_count(dqm, q->properties.type);
>   
> -	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -		dqm->sdma_queue_count++;
> -	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		dqm->xgmi_sdma_queue_count++;
> -
>   	/*
>   	 * Unconditionally increment this counter, regardless of the queue's
>   	 * type or whether the queue is active.
> @@ -460,15 +460,13 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>   	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   			q->properties.type)];
>   
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE) {
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		deallocate_hqd(dqm, q);
> -	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -		dqm->sdma_queue_count--;
> +	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>   		deallocate_sdma_queue(dqm, q);
> -	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		dqm->xgmi_sdma_queue_count--;
> +	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>   		deallocate_sdma_queue(dqm, q);
> -	} else {
> +	else {
>   		pr_debug("q->properties.type %d is invalid\n",
>   				q->properties.type);
>   		return -EINVAL;
> @@ -915,8 +913,6 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
>   	INIT_LIST_HEAD(&dqm->queues);
>   	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
>   	dqm->active_cp_queue_count = 0;
> -	dqm->sdma_queue_count = 0;
> -	dqm->xgmi_sdma_queue_count = 0;
>   
>   	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
>   		int pipe_offset = pipe * get_queues_per_pipe(dqm);
> @@ -981,8 +977,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   	int bit;
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -		if (dqm->sdma_bitmap == 0)
> +		if (dqm->sdma_bitmap == 0) {
> +			pr_err("No more SDMA queue to allocate\n");
>   			return -ENOMEM;
> +		}
> +
>   		bit = __ffs64(dqm->sdma_bitmap);
>   		dqm->sdma_bitmap &= ~(1ULL << bit);
>   		q->sdma_id = bit;
> @@ -991,8 +990,10 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   		q->properties.sdma_queue_id = q->sdma_id /
>   				get_num_sdma_engines(dqm);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		if (dqm->xgmi_sdma_bitmap == 0)
> +		if (dqm->xgmi_sdma_bitmap == 0) {
> +			pr_err("No more XGMI SDMA queue to allocate\n");
>   			return -ENOMEM;
> +		}
>   		bit = __ffs64(dqm->xgmi_sdma_bitmap);
>   		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>   		q->sdma_id = bit;
> @@ -1081,8 +1082,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   	INIT_LIST_HEAD(&dqm->queues);
>   	dqm->active_queue_count = dqm->processes_count = 0;
>   	dqm->active_cp_queue_count = 0;
> -	dqm->sdma_queue_count = 0;
> -	dqm->xgmi_sdma_queue_count = 0;
> +
>   	dqm->active_runlist = false;
>   	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
>   	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
> @@ -1254,11 +1254,6 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	list_add(&q->list, &qpd->queues_list);
>   	qpd->queue_count++;
>   
> -	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -		dqm->sdma_queue_count++;
> -	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		dqm->xgmi_sdma_queue_count++;
> -
>   	if (q->properties.is_active) {
>   		increment_queue_count(dqm, q->properties.type);
>   
> @@ -1315,20 +1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
>   	return 0;
>   }
>   
> -static int unmap_sdma_queues(struct device_queue_manager *dqm)
> -{
> -	int i, retval = 0;
> -
> -	for (i = 0; i < dqm->dev->device_info->num_sdma_engines +
> -		dqm->dev->device_info->num_xgmi_sdma_engines; i++) {
> -		retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
> -			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i);
> -		if (retval)
> -			return retval;
> -	}
> -	return retval;
> -}
> -
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int map_queues_cpsch(struct device_queue_manager *dqm)
>   {
> @@ -1366,12 +1347,6 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!dqm->active_runlist)
>   		return retval;
>   
> -	pr_debug("Before destroying queues, sdma queue count is : %u, xgmi sdma queue count is : %u\n",
> -		dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
> -
> -	if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
> -		unmap_sdma_queues(dqm);
> -
>   	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
>   			filter, filter_param, false, 0);
>   	if (retval)
> @@ -1444,13 +1419,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   
>   	deallocate_doorbell(qpd, q);
>   
> -	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -		dqm->sdma_queue_count--;
> +	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>   		deallocate_sdma_queue(dqm, q);
> -	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		dqm->xgmi_sdma_queue_count--;
> +	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>   		deallocate_sdma_queue(dqm, q);
> -	}
>   
>   	list_del(&q->list);
>   	qpd->queue_count--;
> @@ -1673,13 +1645,10 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   
>   	/* Clear all user mode queues */
>   	list_for_each_entry(q, &qpd->queues_list, list) {
> -		if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -			dqm->sdma_queue_count--;
> +		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>   			deallocate_sdma_queue(dqm, q);
> -		} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -			dqm->xgmi_sdma_queue_count--;
> +		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>   			deallocate_sdma_queue(dqm, q);
> -		}
>   
>   		if (q->properties.is_active)
>   			decrement_queue_count(dqm, q->properties.type);
> @@ -1759,8 +1728,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
>   	struct kfd_dev *dev = dqm->dev;
>   	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
>   	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
> -		(dev->device_info->num_sdma_engines +
> -		dev->device_info->num_xgmi_sdma_engines) *
> +		get_num_all_sdma_engines(dqm) *
>   		dev->device_info->num_sdma_queues_per_engine +
>   		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
>   
> @@ -2012,8 +1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
>   		}
>   	}
>   
> -	for (pipe = 0; pipe < get_num_sdma_engines(dqm) +
> -			get_num_xgmi_sdma_engines(dqm); pipe++) {
> +	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
>   		for (queue = 0;
>   		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
>   		     queue++) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 05e0afc04cd9..50d919f814e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -182,8 +182,6 @@ struct device_queue_manager {
>   	unsigned int		processes_count;
>   	unsigned int		active_queue_count;
>   	unsigned int		active_cp_queue_count;
> -	unsigned int		sdma_queue_count;
> -	unsigned int		xgmi_sdma_queue_count;
>   	unsigned int		total_queue_count;
>   	unsigned int		next_pipe_to_allocate;
>   	unsigned int		*allocated_queues;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 3bfa5c8d9654..eb1635ac8988 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -241,16 +241,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	switch (type) {
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		if ((type == KFD_QUEUE_TYPE_SDMA && dev->dqm->sdma_queue_count
> -			>= get_num_sdma_queues(dev->dqm)) ||
> -			(type == KFD_QUEUE_TYPE_SDMA_XGMI &&
> -			dev->dqm->xgmi_sdma_queue_count
> -			>= get_num_xgmi_sdma_queues(dev->dqm))) {
> -			pr_debug("Over-subscription is not allowed for SDMA.\n");
> -			retval = -EPERM;
> -			goto err_create_queue;
> -		}
> -
> +		/* SDMA queues are always allocated statically no matter
> +		 * which scheduler mode is used. We also do not need to
> +		 * check whether a SDMA queue can be allocated here, because
> +		 * allocate_sdma_queue() in create_queue() has the
> +		 * corresponding check logic.
> +		 */
>   		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
