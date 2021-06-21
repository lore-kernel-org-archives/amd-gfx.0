Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31368C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAB86115B
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 20:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAB86115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C5889932;
	Mon, 21 Jun 2021 20:05:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B25E89932
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 20:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICk9fZGMVQD4VdXZpscs1M1/rSBTTJTGmGsfjB7pn2iCOBVxQflKftG1I9iF78OyEM3jJdLkYJXa+oB/RFKbZ+5M8A2d9L+hTXW0Xbc/0xH7lICRkQQJHhicMfF/RCPFO6hGMHc0Yfy8+P2Oha9o0SCco3mSJ3Sb8SW6nrYX8iP0swn1D4yknqRgEY1X9t/sAh5b2BO1wboFSAOAaeNFd6lA/vYdp+i3LxlNCyJaszLeQga0i+8pLJ1w6SeeTmD1zNOzc7HRaxAfdD3RlKUa/K1nsFwumblMFzrDd5VBgduOPX8hgr4pQfHgSPvbAUb8guFcShbySzDY6B+iB3y5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4VMFPzD26Xa28tUflwgGffkVcfTIsgoOZGHJLfVL+c=;
 b=f+hE0utAnnnGGoOvq9vOBzTYJCBUaFySadeaHdcxUHMDiPTj4bCMBfbsKsNbEUXWceaPlXCqplmiOOk9x8X1DE2ZlG9ljPa+6i8qi1hM12/TVVvXa8HF59KxjpMTQvw5oh5kjOyHz/2ULX4LzIN1QiCSsAxDpyngUO9z9LWu7HPIK5loqRxVOZ1iJgfvfN9DdzYLmFMPeEHRVWGH9XBOLau2T+lctML2B3C8dTY0INqP8kDQMhxIHgng3TBhsVpojkIOMySA/y7aANPErE15E5M/IAjFbENhRu40MqTT9mEmL+T77+x/lTAfDgeZy+V0/bxpAvJkJLFmawlr9yWUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4VMFPzD26Xa28tUflwgGffkVcfTIsgoOZGHJLfVL+c=;
 b=I8UsO2qKlbfyKsfm+j8ZWeobf8aOXiXIX7cS3gdyOgFCIWA8ikFqnJTKmGXYbrPeMGN+khH0rdnG2g1gegfONQbSPHwge86XQNtSff6WCSSTeAZsYqw277mGpnCbgn2rVtNx9LSrf5ve75L0+XhSSG8/CRjRpVlYW2xwkDtPpus=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Mon, 21 Jun
 2021 20:05:01 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:05:01 +0000
Subject: Re: [PATCH 04/10] drm/amdgpu: get owner ref in validate and map
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-4-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <95a62079-cfb0-5a67-4612-e1ea6351eb6c@amd.com>
Date: Mon, 21 Jun 2021 16:04:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-4-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::31) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Mon, 21 Jun 2021 20:05:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f61a3f-9674-4c0b-9aaf-08d934efd9fe
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52416CAEFAF47F8679319810920A9@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvajZZImq4XsaFJAiTu7wqmOuPAwP63Ve+RFVisjphSLIMlBTh/8nO+yODHWoiRLUO7KvwOwnUS+NHf0fbRxscJ+jFEWwG23s7QoMqE/GK1qbQeldyWCuqQ6ViVg6djjkkyIwWNFe86+f5x9HFGVt6KCKNlu0W5HPcxeiM+cPi9ctmv0RukIv3LkGD4zhxD+tL7gK5fqee/mJI3VpjlqXAwyGIWiGMMRGZ1XU0E302sNcatKsmHix6j6vvejTQlBPeJcgSjZCfNw0epZcj+VCeplh7jvX9ArpbQi3WCNMbFmEUbt5u3sZbcWBGJhx947V+3UkTUmGZj4lCm150+nknJB3kd2vZMbV4BSznMOGbKeNMxVGiSnL0WShpDUUwrktFzSDpYK6YTIUDLjTCiLYsP5vIrOwlAfKHuWaqzz37BeL7121TdlTC7IJ5bTC7elrgCY2gbb2u+MH3rykiK/g1b7BU7FIIjgNnA5FPOk0nKatYdKC9wH/6D69xWizWASnE6UPjUqtQAr70soMw7jNiVPFWQP954PpjTmtVST5CGEALNtEZjepNo33hvfAVUOupg1T1v++xaN2tcIa9lqJz7MnY+A6BkgYEYvIYVTpoEm9zdiq/bjFjjGv0/8UfekI353ZiaoTaEL/NwaSGtZnaDUegZU5aIMIeBqOnM1ajvWhV4AHAuMGjdLAGLpkY7N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(5660300002)(36916002)(38100700002)(956004)(16576012)(44832011)(66556008)(2906002)(53546011)(83380400001)(8936002)(66476007)(2616005)(6486002)(66946007)(8676002)(31696002)(86362001)(478600001)(31686004)(15650500001)(316002)(16526019)(36756003)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dlVkNVNHIvNS9DdGtjdGZnUDV1TSs4Y0czYXNPNXdtMXVHOEpYNEJHN2VL?=
 =?utf-8?B?NW5VeUtqYVdrK1l1cTlIcEVDR1JYcUREUHhHb0ZKMUVMaFhyY1FFQURHUWRU?=
 =?utf-8?B?VXI4WTZlNDdIZjArMUZuSFVTMGMzTWZVT2puaTVHeTVFZ2JHSHJrdE50ejlr?=
 =?utf-8?B?RDVwZVcrV2tCYm12cnFWVkV5NDhjaVJGbElSN0V3Ymh4YW10b1JORlQ3QzV5?=
 =?utf-8?B?M3piTEtBZXlLaHdtWC9uRm8reVRmSVE4RHViS2hpWWZUdEVlNXNVeE45RkNn?=
 =?utf-8?B?QTRsV1lzWDR4Rjk3ak1EMDhvTmlJRi82NjdObUt3VktxbTdOSmxpckp2REk3?=
 =?utf-8?B?SXhOdW1pTWFxRFhvK1lZcjNkMFphMUJaR2hoSzhJQkRGa3E2UnNnRE1ocm1N?=
 =?utf-8?B?WmU0S29XaGV1OENqcGo2dlJqNkFOUGt0dkloYnN4MFFBeGt5eUlYMFRBdlRy?=
 =?utf-8?B?cDJwOTFFU3VtK0k2TEtsODZVcU5kWHp3c0trVS9DK0F4eEFzaEJRbHVZUTFY?=
 =?utf-8?B?eCtWUXhlYTRuVElCRHEwaXRRWGZxUUU4Y1d0M01TTmZmdVI2TzhaeUp6bitY?=
 =?utf-8?B?cEdiSGpsdUVPa0FxWkNFMVViWWVIYzM0ZllNcXBPd3ZKVDVRNTJRNmlvSVRk?=
 =?utf-8?B?TUxqRHRXZEVjaE91OUNrbWkrZ2RDdVVhQWdKWDViK21wbEtVTEFRQnpMRCtk?=
 =?utf-8?B?RUloWWwxZ3F2RkIwcEIxdW9kOXdJZkFBNGltYUNlNkNweE1UaTg5UVVWV09k?=
 =?utf-8?B?eUx4My95NnhBTDhESHdrYnNOeVhvRjJOZEp3bjE2eG5SNFJTU2VKTEpybXVI?=
 =?utf-8?B?NG1KSlRjREN0aHZRYS9hNytkRzVSVkJ3bWZ2SlRpSlZoV1J5TWVhcEQ4UG5j?=
 =?utf-8?B?ZGFwTXFZL3lPeGFFMHo5QjVpV3RDc1ppWnNsUkRIZy9tckRxOTdxbkIzVXpX?=
 =?utf-8?B?M2VsUGJISFA4MjNoT0ppNXFYMThJL2xRdVlrZUhxNE9nMmxwaWxiakhqTlZ5?=
 =?utf-8?B?OW1RNG8zQ1ltaXhJQmViVFlxZTFMYWp3N29zcFBPWS9CQ21FSW9WYXdJcWQr?=
 =?utf-8?B?MTlEZzRKcisvcGFRWExmTGVWWlJUN0RuczFKNUdub0xZVTR0eEJaOG9YWThG?=
 =?utf-8?B?YmVKUWxqUTVsQ1ZnN1lzV28vd3RIL1U3T2RPWjRhaENSZ3UydVZ5MmVmWmg1?=
 =?utf-8?B?dmUyWkxkeE80UzlaZzlFcndYYXI1VzljT1RRUUhaTklUbEFRenJtRlRGdVhl?=
 =?utf-8?B?TTRjd3F1eFRxOWtXM3pEWFpYTG0vM2xyZmcxcjhIRlFhcTkzTytIbkVtVmln?=
 =?utf-8?B?ZG4rRXcvQUdYaVc2a3RvSFlra0VWVEZhNXEyZzMxT1BJSjlaR0MxWUVTc0I3?=
 =?utf-8?B?VE16T1hLNCtFenlSOEhGT292Y3JkblhOWEloZUpMZ2xBYlN1VnhqTEdOc2Jr?=
 =?utf-8?B?c21XcHVudm80VFhEcDBUV0F0OEhMRVIvVWttZWg3Um5NOWhIU3lnTmVQUjg1?=
 =?utf-8?B?WTlPN20yck5tdC93dWREaTRoQ01Pd2trRWlTV29JQUttNXNFQWtmbm1TdEdS?=
 =?utf-8?B?blVrZjVva3pXSzZYVWV4anQrRkZ5Qk1FRUtoQ2p5dktKNW5oajNxek5WT1hI?=
 =?utf-8?B?VVJIYW5nZm11SGJxQU5yRkxxNDJEY05jR0FLd3Y2Y2hWUUFKNWpId0pIdWxT?=
 =?utf-8?B?WWp4SzVVR0RpcEQyK1dCK29NV0owRVJNWUNmYWlCQksyWEpZM3l2NjNna1BR?=
 =?utf-8?Q?ZfoMjLK/nbzzH+hZ/CrLMXQBvv6u+epd18fo08w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f61a3f-9674-4c0b-9aaf-08d934efd9fe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 20:05:01.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRPD7NRBOaFIs3Z9YC2OWLVcEl1mvhuEq6QtxYxCzJr8uCZhUF+chykr3X8wIIHfZnAXkYP+wijPhEwaRmtQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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

On 2021-06-21 12:04 p.m., Alex Sierra wrote:
> Get the proper owner reference for amdgpu_hmm_range_get_pages function.
> This is useful for partial migrations. To avoid migrating back to
> system memory, VRAM pages, that are accessible by all devices in the
> same memory domain.
> Ex. multiple devices in the same hive.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 54f47b09b14a..2b4318646a75 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1313,6 +1313,17 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
>   	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
>   }
>   
> +static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
> +{
> +	struct kfd_process_device *pdd;
> +	struct amdgpu_device *adev;
> +
> +	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
> +	adev = (struct amdgpu_device *)pdd->dev->kgd;
> +
> +	return SVM_ADEV_PGMAP_OWNER(adev);
> +}
> +
>   /*
>    * Validation+GPU mapping with concurrent invalidation (MMU notifiers)
>    *
> @@ -1343,6 +1354,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   {
>   	struct svm_validate_context ctx;
>   	struct hmm_range *hmm_range;
> +	struct kfd_process *p;
> +	void *owner;
> +	int32_t idx;
>   	int r = 0;
>   
>   	ctx.process = container_of(prange->svms, struct kfd_process, svms);
> @@ -1389,10 +1403,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	svm_range_reserve_bos(&ctx);
>   
>   	if (!prange->actual_loc) {
> +		p = container_of(prange->svms, struct kfd_process, svms);
> +		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
> +							MAX_GPU_INSTANCE));
> +		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
> +			if (kfd_svm_page_owner(p, idx) != owner) {
> +				owner = NULL;
> +				break;
> +			}
> +		}
>   		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
>   					       prange->start << PAGE_SHIFT,
>   					       prange->npages, &hmm_range,
> -					       false, true, NULL);
> +					       false, true, owner);
>   		if (r) {
>   			pr_debug("failed %d to get svm range pages\n", r);
>   			goto unreserve_out;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
