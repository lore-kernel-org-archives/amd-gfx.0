Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD9EC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E842160F39
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 22:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E842160F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CCA6EB28;
	Fri, 20 Aug 2021 22:03:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4BF6EB28
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 22:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czsC4QTTr2pzeIMEGxX3BYR21588P0Vrg3WEfFdmboxUmznvNaoVQOtz+K/QBMLdm00FTG4uA1CXddNBr/P9IUmgMBbh7hIdjXwqqAhUsj9tQpqGaczSv1D9+aTTOth6ijW3v5Hl84C0373KymLq/I21APOxNv94CsLiP+ihRAxMpm1Dl45nML0QyWwAyV3yzU74ag4EFTrQXcCXufN8zO/jHHFm7itwN2RlNL+nrt9bh0PjQC/e+UBht7SP1VmMjOWbQSf1HWQrLAvYx6lLijSBd8n1GVaYddJx3SsdWdReR4hjno7bBYEUgJyk5yB7doVrX0Tebi4mbZxK4GtXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hKY0wR+mihIhzyk13DTZyjVtoOXjrR6gxkvRkEhc1U=;
 b=DS87CrxwRNSbnRG8ovrqNsizFz8YWsWjzwvkorWRY/uTLwTOZLi/P5sly64sxgNdgTxoCaWoXMsbu+zeaLysixWOh5LfwKB3EG3Kwahd6qtmPbsAvdiH54oBkPT16sEMY579Hy/wMWHGHBc83sMp7kbNDS/UxqropSfGVXRnULylc4diJsC2ybTcxgM0b7gelQwtBXDozhrBRzP/7B0j29VvYrAiSI9otsl2oAPCadqKMRutC/R0t/lVL5tOOb3lebGfZZsAj/5dhacVJvnMU04JCeAjsiOo8GuUlXKtM/tN7GO/OvV6U9A6z1AP9OOPh+bPFslu82oWRCl+y6vZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hKY0wR+mihIhzyk13DTZyjVtoOXjrR6gxkvRkEhc1U=;
 b=yPdVDL0lwVrryh4Z4TuVbva76YXcWuQTN5ApnC69VZM+vITDdii8yZu96LyOgBqFKlPZ8kwFCTWb//QxLkwKFI4W+upWNBLxl3jYQwg+KqFyTZIxC/sNpF0JMAj+q9DQ2Y46+0DovDDJkBaKld/HN1RvtcRbuXPc26Cl2lBKeh8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 22:03:40 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 22:03:40 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: amd-gfx@lists.freedesktop.org,
 "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <529f7938-59ef-8577-d395-89b442b79d79@amd.com>
Date: Fri, 20 Aug 2021 18:03:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 22:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 543b273d-6b33-43f4-08c8-08d964265df3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244C8FAC1695FDFC9F1ED0D92C19@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaO8F7l1QP7otEn8M+2cjp3WV38NhF0LgVBrbULFbAsbY6y0BAXEsm5v4KZ4GZp16oOpGOsiq3AIvf5SOOpwrWfeBnDrGetp4d+/hMmn3T4KXDbBUqAw/b5zjDiuujeVlYkoFKq/eQo7z45utTRS6FSh596TWgHNzHFOTsIqbWykfeKZaVnaAkKO8Bx3kywZY+z1x7CBphl/dljVN4qb8aJjYS5jOfEFPKMxsQT4EmAe3M5wj6cdo5tsq4wIlyc6oI2w31o5FYPnHjZWXLTtB8Fe2/+gCxVVvukQnJZEWKDZXGujM7jz+vCk40t8w1jfD90TkeQdvUPfEgSNMwowAyQX2GWsP5TeNtfcbVzhGZhVXOas62hqm7nCnoGk7V/nkBFh4M7rRSrgmbVXyCIuW3XihceioFcQ/4GINEWdz1oJS30ezcnCfxhvRAfGA7X6HpL87RXNXWC5fNRDX33Wg4ytjIdvNUpxE0Yk+148ytn7uXzqm9BKqbO+wIqHyVfKv1v93zMdzCNw6IKlgB8DhZ12oy2wZLS6gPHV6NlbkAw7CQLm+zQ6RTqhjevyFlXXxu0D6GB2AeZEqH2PSWLhVij700h4FbYn6Kmb4BXLNlEC7G41CLKTrteU2ZmOXRF056d8oSM3AKCkulPL/ebM/Vm3DWVW0Nn7frqFeZ9PFuKhbM9GZh0XmsKR5uh1P50AQZrn4sx8LGK5lSS8NbKniZ9k8xWlniKIfWPVjUidjZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(186003)(8676002)(316002)(38100700002)(16576012)(66946007)(31686004)(6486002)(2906002)(6636002)(36756003)(83380400001)(44832011)(66476007)(37006003)(26005)(8936002)(478600001)(2616005)(66556008)(31696002)(956004)(5660300002)(86362001)(6862004)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dYUmSbaVZkpuOprPhO0pyIzu+86dMThY2WS9IQbit/AMvNhbJ7fXyxN2Iw060YtdHD9/GsjMUOVDV1x0YJy3SApsl30mPQW8aWuHA/7kT0mmGk6wZTSfaZj/sb/Rg2leh/AJZqAf9ITnd4iS2Yaze7I+Oypvd1tRAwXtb3CIwND/euEQ8Jcf7TFnI5Aa1oyAh1zH0E2ux/Y1tX1rxejJZ00OoPLpxcEETx5iP50gdJoTS8wR7RD4pxoieLqCdz9a0FIbr3fBo9vFtr2+Va4q7uW82K7SEc33lPdvyfk9Zym+sdMJXwOyKsyVr8nxH9sWG2i7L89cB4MmybF36I6V3z+/l1LO0qq21lw1QWTMhFAkW2/M/O2ZnrgznX9v39j0GrEExT8nOsT+O0BeGbUIg7IK7vz9YhH4TFD/QPk7j8CJ39Lx2UH8MEMOwW7xD07mChvfK9E+BD5q+q64bJPz+qpjrzuhn+GEEUdfQB7Jhdc8wXaUoL19qUYUzjuTf4pG260HIeQG745yPuVoa98iwEpXu9Kmw2NJkn2Zkbv+KTjR42XcSUwQkO1xL6vUt9nXDdry/TcidyR+SpMYdYZl8e6PftOT7m9BazddM8Ev0WXh9zexNki2sTuKEsGOh/LzmaH+Loh+Qkigg/Q/1KKhn445W67baVYxa7LKue9wR2O4H4eOhHdVVQ9QHdRJGh0xemwwkaEGcIVVCCi1akHKzIIy+hz4pQhK/3WLUqyrfXaj3woqahBaz67M2sgPeh3F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543b273d-6b33-43f4-08c8-08d964265df3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 22:03:39.8852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBQwSw6dtCxmWLyQutT6qvtXa5Om/GMmD8Shvi4D/79WYHPZz1RMtC/gO2SDNGz+9r690VZiZiLx4pBPLkL4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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

Am 2021-08-20 um 1:32 a.m. schrieb Joseph Greathouse:
> Give every process at most one queue from each SDMA engine.
> Previously, we allocated all SDMA engines and queues on a first-
> come-first-serve basis. This meant that it was possible for two
> processes racing on their allocation requests to each end up with
> two queues on the same SDMA engine. That could serialize the
> performance of commands to different queues.
>
> This new mechanism allows each process at most a single queue
> on each SDMA engine. Processes will check for queue availability on
> SDMA engine 0, then 1, then 2, etc. and only allocate on that
> engine if there is an available queue slot. If there are no
> queue slots available (or if this process has already allocated
> a queue on this engine), it moves on and tries the next engine.
>
> The Aldebaran chip has a small quirk that SDMA0 should only be
> used by the very first allocation from each process. It is OK to
> use any other SDMA engine at any time, but after the first SDMA
> allocation request from a process, the resulting engine must
> be from SDMA1 or above. This patch handles this case as well.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

One final nit-pick inline. With that fixed, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>  3 files changed, 107 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f8fce9d05f50..86bdb765f350 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>  static int map_queues_cpsch(struct device_queue_manager *dqm);
>  
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>  				struct queue *q);
>  
>  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>  				struct queue *q);
>  static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
>  static int allocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>  				struct queue *q);
>  static void kfd_process_hw_exception(struct work_struct *work);
>  
> @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>  			q->pipe, q->queue);
>  	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		retval = allocate_sdma_queue(dqm, q);
> +		retval = allocate_sdma_queue(dqm, qpd, q);
>  		if (retval)
>  			goto deallocate_vmid;
>  		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>  		deallocate_hqd(dqm, q);
>  	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>  deallocate_vmid:
>  	if (list_empty(&qpd->queues_list))
>  		deallocate_vmid(dqm, qpd, q);
> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>  	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>  		deallocate_hqd(dqm, q);
>  	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>  	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>  	else {
>  		pr_debug("q->properties.type %d is invalid\n",
>  				q->properties.type);
> @@ -1039,42 +1041,93 @@ static void pre_reset(struct device_queue_manager *dqm)
>  	dqm_unlock(dqm);
>  }
>  
> +static uint64_t sdma_engine_mask(int engine, int num_engines)
> +{
> +	uint64_t mask = 0;
> +
> +	engine %= num_engines;
> +	while (engine < (sizeof(uint64_t)*8)) {
> +		mask |= 1ULL << engine;
> +		engine += num_engines;
> +	}
> +	return mask;
> +}
> +
>  static int allocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>  				struct queue *q)
>  {
> -	int bit;
> +	uint64_t available_queue_bitmap;
> +	unsigned int bit, engine, num_engines;
> +	bool found_sdma = false;
>  
>  	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -		if (dqm->sdma_bitmap == 0) {
> +		num_engines = get_num_sdma_engines(dqm);
> +		for_each_set_bit(engine, &(qpd->sdma_engine_bitmap), num_engines) {
> +			/* Do not reuse SDMA0 for any subsequent SDMA queue
> +			 * requests on Aldebaran. If SDMA0's queues are all
> +			 * full, then this process should never use SDMA0
> +			 * for any further requests
> +			 */
> +			if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
> +					engine == 0)
> +				qpd->sdma_engine_bitmap &= ~(1ULL << engine);
> +
> +			available_queue_bitmap = sdma_engine_mask(engine, num_engines);
> +			available_queue_bitmap &= dqm->sdma_bitmap;
> +
> +			if (!available_queue_bitmap)
> +				continue;
> +			/* Take the selected engine off the list so we will not
> +			 * allocate two queues onto the same engine
> +			 */
> +			qpd->sdma_engine_bitmap &= ~(1ULL << engine);
> +			found_sdma = true;
> +
> +			bit = __ffs64(available_queue_bitmap);
> +			dqm->sdma_bitmap &= ~(1ULL << bit);
> +			q->sdma_id = bit;
> +			q->properties.sdma_engine_id = q->sdma_id % num_engines;
> +			q->properties.sdma_queue_id = q->sdma_id / num_engines;
> +			break;
> +		}
> +		if (!found_sdma) {
>  			pr_err("No more SDMA queue to allocate\n");
>  			return -ENOMEM;
>  		}
> -
> -		bit = __ffs64(dqm->sdma_bitmap);
> -		dqm->sdma_bitmap &= ~(1ULL << bit);
> -		q->sdma_id = bit;
> -		q->properties.sdma_engine_id = q->sdma_id %
> -				get_num_sdma_engines(dqm);
> -		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_sdma_engines(dqm);
>  	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		if (dqm->xgmi_sdma_bitmap == 0) {
> +		num_engines = get_num_xgmi_sdma_engines(dqm);
> +		for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap), num_engines) {
> +			available_queue_bitmap = sdma_engine_mask(engine, num_engines);
> +			available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
> +
> +			if (!available_queue_bitmap)
> +				continue;
> +			/* Take the selected engine off the list so we will not
> +			 * allocate two queues onto the same engine
> +			 */
> +			qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
> +			found_sdma = true;
> +
> +			bit = __ffs64(available_queue_bitmap);
> +			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
> +			q->sdma_id = bit;
> +			/* sdma_engine_id is sdma id including
> +			 * both PCIe-optimized SDMAs and XGMI-
> +			 * optimized SDMAs. The calculation below
> +			 * assumes the first N engines are always
> +			 * PCIe-optimized ones
> +			 */
> +			q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
> +				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
> +			q->properties.sdma_queue_id = q->sdma_id /
> +				get_num_xgmi_sdma_engines(dqm);

You could use "num_engines" here instead of get_num_xgmi_sdma_engines(dqm).

Regards,
  Felix


> +			break;
> +		}
> +		if (!found_sdma) {
>  			pr_err("No more XGMI SDMA queue to allocate\n");
>  			return -ENOMEM;
>  		}
> -		bit = __ffs64(dqm->xgmi_sdma_bitmap);
> -		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
> -		q->sdma_id = bit;
> -		/* sdma_engine_id is sdma id including
> -		 * both PCIe-optimized SDMAs and XGMI-
> -		 * optimized SDMAs. The calculation below
> -		 * assumes the first N engines are always
> -		 * PCIe-optimized ones
> -		 */
> -		q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
> -				q->sdma_id % get_num_xgmi_sdma_engines(dqm);
> -		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_xgmi_sdma_engines(dqm);
>  	}
>  
>  	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>  }
>  
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>  				struct queue *q)
>  {
> +	uint32_t engine = q->properties.sdma_engine_id;
> +
>  	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>  		if (q->sdma_id >= get_num_sdma_queues(dqm))
>  			return;
>  		dqm->sdma_bitmap |= (1ULL << q->sdma_id);
> +		/* Don't give SDMA0 back to be reallocated on Aldebaran.
> +		 * It is only OK to use this engine from the first allocation
> +		 * within a process.
> +		 */
> +		if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
> +					engine == 0))
> +			qpd->sdma_engine_bitmap |= (1ULL << engine);
> +
>  	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>  		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>  			return;
>  		dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
> +		/* engine ID in the queue properties is the global engine ID.
> +		 * The XGMI engine bitmap ignores the PCIe-optimized engines.
> +		 */
> +		engine -= get_num_sdma_engines(dqm);
> +		qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>  	}
>  }
>  
> @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>  	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>  		dqm_lock(dqm);
> -		retval = allocate_sdma_queue(dqm, q);
> +		retval = allocate_sdma_queue(dqm, qpd, q);
>  		dqm_unlock(dqm);
>  		if (retval)
>  			goto out;
> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>  	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>  		dqm_lock(dqm);
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>  		dqm_unlock(dqm);
>  	}
>  out:
> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>  
>  	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>  	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>  		pdd->sdma_past_activity_counter += sdma_val;
>  	}
>  
> @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>  	/* Clear all user mode queues */
>  	list_for_each_entry(q, &qpd->queues_list, list) {
>  		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -			deallocate_sdma_queue(dqm, q);
> +			deallocate_sdma_queue(dqm, qpd, q);
>  		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -			deallocate_sdma_queue(dqm, q);
> +			deallocate_sdma_queue(dqm, qpd, q);
>  
>  		if (q->properties.is_active) {
>  			decrement_queue_count(dqm, q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ab83b0de6b22..c38eebc9db4d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -576,6 +576,8 @@ struct qcm_process_device {
>  	struct list_head priv_queue_list;
>  
>  	unsigned int queue_count;
> +	unsigned long sdma_engine_bitmap;
> +	unsigned long xgmi_sdma_engine_bitmap;
>  	unsigned int vmid;
>  	bool is_debug;
>  	unsigned int evicted; /* eviction counter, 0=active */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21ec8a18cad2..13c85624bf7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1422,6 +1422,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>  							struct kfd_process *p)
>  {
>  	struct kfd_process_device *pdd = NULL;
> +	const struct kfd_device_info *dev_info = dev->dqm->dev->device_info;
>  
>  	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>  		return NULL;
> @@ -1446,6 +1447,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>  	pdd->qpd.pqm = &p->pqm;
>  	pdd->qpd.evicted = 0;
>  	pdd->qpd.mapped_gws_queue = false;
> +	pdd->qpd.sdma_engine_bitmap = BIT_ULL(dev_info->num_sdma_engines) - 1;
> +	pdd->qpd.xgmi_sdma_engine_bitmap = BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>  	pdd->process = p;
>  	pdd->bound = PDD_UNBOUND;
>  	pdd->already_dequeued = false;
