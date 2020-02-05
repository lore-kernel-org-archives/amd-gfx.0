Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C052FC35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C87120730
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XGemkLqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C87120730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D56C6F980;
	Wed,  5 Feb 2020 23:39:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8066E26F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp8Mg9qZCKDwcTg3R/DkzuKYCi/as5Nyza7KZ+tmqZXZTjkxnm0WHUHpSkiySLBvaBmlYYzIziOiB0+9Erg3QZNvhQIG8OfXfkPcr2fN56MTjSnFFY4TbCKkGeQEArw4EMUoiQ4A01SwBS3nIiA6RF+bPNTpbsuJEnwXyvj7Khn+kSbUUI79sZkmocNeTkOnsI5b+4OI5ra8ZtP14bT3f+0F9PllmIW1//4ZozSg7BgtZZ4MsAGZYPTKO0Qe73Lzx23VDFfXPqKZFYAgXMNtaD9xcOzf+INoStpx+Ml3RZl1yA8Q6ut6630NY1rNYLscdqbYkWEF/b/PGQKgLuNbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l0m03mTzL0z910le0kwTdu35Ej40iFz1D67nNTPicM=;
 b=nL/pyn1IWp9nSga/q9gkTEVW54XOIaGnuKKJCu8v4srL4Wehh+rKxdnxFYiPQoWURr8O4lJY38ZI0yHqMCb6qm3FOrohesjXdiZM6ZJUrU26V1XYMhMnyFcYc5pu3gEGtLzWsVN08bRKLOnoR4s29UKr/7gIxX7wntKm63qqW0l4g4hD14gAXGp7ZoJGaBCTI3DegHSnNmaaBD5qer/zgw2un6qK37/sqRidGMAvY+T19VVwdFPNOt5tuQBOhAJQZkV8a47tUnPX+BEc5E9DUbLOBIvwPwiHibohQ1QXFEhzWJENgRuqBIA5ZBy3IydQkZe66W2BAdrjwKwcTpJDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l0m03mTzL0z910le0kwTdu35Ej40iFz1D67nNTPicM=;
 b=XGemkLqYHtviiFuAZYs49ToPeKfaQobI21b79yADBB2z2IWGtciW+9ERoNHPL0OD94hckGhljCfSvbtVrtloVmV1jerIMairTyh6xANgZKOZWz/irXVMgNyfG9tVNGCTeHAdw+OCpuzT5QY3MwzFBf6zrgEsNuifeE5gYetOgik=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB3943.namprd12.prod.outlook.com (52.132.246.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 23:39:41 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:39:41 +0000
Subject: Re: [PATCH 5/6] drm/amdkfd: Only count active sdma queues
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20200205232832.26226-1-Yong.Zhao@amd.com>
 <20200205232832.26226-5-Yong.Zhao@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <9092619f-7f01-693c-4eb2-3c6bb0ed7e82@amd.com>
Date: Wed, 5 Feb 2020 18:39:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200205232832.26226-5-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::32) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from [172.27.227.155] (165.204.55.251) by
 YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 5 Feb 2020 23:39:41 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0c3dcec-5a98-4b96-7668-08d7aa94abed
X-MS-TrafficTypeDiagnostic: CH2PR12MB3943:|CH2PR12MB3943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3943F369C78320CD522E5817F0020@CH2PR12MB3943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(16576012)(110136005)(81156014)(316002)(6486002)(81166006)(8676002)(478600001)(66556008)(956004)(2616005)(52116002)(5660300002)(44832011)(2906002)(66946007)(66476007)(36756003)(31696002)(53546011)(31686004)(86362001)(8936002)(26005)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3943;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QywgUGyQlKASJQIX3bVQQWTIdKvbAEkK+5D8Xxzo31u3hCpG4t5x705hZtmaPKf4pDHiPH27iO8wAJq9cqN9j9/D3Co5CGe/YU3ZIH56g0CVHR8N4/stMGhHqfodv2QDLLWitEZ6u1clEo2GHVyWQL+DRY50oX79X/n1hniaWZaPd677MGsc9w1zWeyzFIfkFM6+ozBhVznj1AJCQWJlmPgXA8Ut/WKMr20Voka37n9VrTkz46ddHOgrkQ8IXfWxQTLH0JrlhdWhN6IrwbymPVCepQk/zH5PidajS1rxyj2MXESZLn5gR92mgCX9X6hfR4vzTU+PWjovPqQcPUK5j5DmhJ3n/SE/srAEuHCrq42R57gycswUN9ldi1xGwlkn9sb6InX8IngYDOCnBT/qeIGJ7Qimc0LazM1kmecuPo5w5AphZuei8kIwk07qzfYi
X-MS-Exchange-AntiSpam-MessageData: JXb02ZZCrq0uUkiBZ2lNFqU3yzMGmRowTT9yNi6wnVk+LnnTnj7Okt67ZFqXd/9AWpwxMAAs5TiW2Bu+hYDuARCaR8SJwCObdPGWIz7BJQJVK4g0QnIvtf2EjW+GV4Wn9JhfnUINJKNDGCfUN4vYnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c3dcec-5a98-4b96-7668-08d7aa94abed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:39:41.4631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Vl1BK30t2swNEuFditqfVPVy4/zbSOA8LLbg8KxHj8+X8pRuq2XILUhPLyjCtfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3943
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

One minor fix added.

Yong

On 2020-02-05 6:28 p.m., Yong Zhao wrote:
> The sdma_queue_count was only used for inferring whether we should
> unmap SDMA queues under HWS mode. In contrast, We mapped active queues
> rather than all in map_queues_cpsch(). In order to match the map and unmap
> for SDMA queues, we should just count active SDMA queues. Meanwhile,
> rename sdma_queue_count to active_sdma_queue_count to reflect the new
> usage.
>
> Change-Id: I9f1c3305dad044a3c779ec0730fcf7554050de8b
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 54 ++++++++-----------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 16 +++---
>   3 files changed, 31 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 064108cf493b..cf77b866054a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -138,6 +138,10 @@ void increment_queue_count(struct device_queue_manager *dqm,
>   	dqm->active_queue_count++;
>   	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
>   		dqm->active_cp_queue_count++;
> +	else if (type == KFD_QUEUE_TYPE_SDMA)
> +		dqm->active_sdma_queue_count++;
> +	else if (type == KFD_QUEUE_TYPE_SDMA_XGMI)
> +		dqm->active_xgmi_sdma_queue_count++;
>   }
>   
>   void decrement_queue_count(struct device_queue_manager *dqm,
> @@ -146,6 +150,10 @@ void decrement_queue_count(struct device_queue_manager *dqm,
>   	dqm->active_queue_count--;
>   	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
>   		dqm->active_cp_queue_count--;
> +	else if (type == KFD_QUEUE_TYPE_SDMA)
> +		dqm->active_sdma_queue_count--;
> +	else if (type == KFD_QUEUE_TYPE_SDMA_XGMI)
> +		dqm->active_xgmi_sdma_queue_count--;
>   }
>   
>   static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
> @@ -377,11 +385,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
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
> @@ -462,15 +465,13 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
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
> @@ -916,8 +917,8 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
>   	mutex_init(&dqm->lock_hidden);
>   	INIT_LIST_HEAD(&dqm->queues);
>   	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
> -	dqm->sdma_queue_count = 0;
> -	dqm->xgmi_sdma_queue_count = 0;
> +	dqm->active_sdma_queue_count = 0;
> +	dqm->active_xgmi_sdma_queue_count = 0;
>   
>   	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
>   		int pipe_offset = pipe * get_queues_per_pipe(dqm);
> @@ -1081,8 +1082,8 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
>   	mutex_init(&dqm->lock_hidden);
>   	INIT_LIST_HEAD(&dqm->queues);
>   	dqm->active_queue_count = dqm->processes_count = 0;
> -	dqm->sdma_queue_count = 0;
> -	dqm->xgmi_sdma_queue_count = 0;
> +	dqm->active_sdma_queue_count = 0;
> +	dqm->active_xgmi_sdma_queue_count = 0;
>   	dqm->active_runlist = false;
>   	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
>   	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
> @@ -1254,11 +1255,6 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
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
> @@ -1367,9 +1363,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   		return retval;
>   
>   	pr_debug("Before destroying queues, sdma queue count is : %u, xgmi sdma queue count is : %u\n",
> -		dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
> +		dqm->active_sdma_queue_count, dqm->active_xgmi_sdma_queue_count);
>   
> -	if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
> +	if (dqm->active_sdma_queue_count > 0 || dqm->active_xgmi_sdma_queue_count)
>   		unmap_sdma_queues(dqm);
>   
>   	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
> @@ -1444,13 +1440,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
> @@ -1673,13 +1666,10 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
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
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 05e0afc04cd9..62472a186d4f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -182,8 +182,9 @@ struct device_queue_manager {
>   	unsigned int		processes_count;
>   	unsigned int		active_queue_count;
>   	unsigned int		active_cp_queue_count;
> -	unsigned int		sdma_queue_count;
> -	unsigned int		xgmi_sdma_queue_count;
> +	unsigned int		cp_queue_count;
[yz] I have deleted this item as it is actually not needed.
> +	unsigned int		active_sdma_queue_count;
> +	unsigned int		active_xgmi_sdma_queue_count;
>   	unsigned int		total_queue_count;
>   	unsigned int		next_pipe_to_allocate;
>   	unsigned int		*allocated_queues;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c604a2ede3f5..941b5876f19f 100644
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
> +		 * corresponding check logic there.
> +		 */
>   		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
