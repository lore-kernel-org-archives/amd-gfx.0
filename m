Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CE0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 08:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DEC10E437;
	Fri, 13 May 2022 08:18:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C83F10EC87
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 08:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrRKvN6DzCOY1b3mZIW/q5/jHgngzaUaJXmU4ywlpCg7xIWMPAvKcQjrAgvNM95j41XwpxUYWSb4sVJKgxDYicZWs0pWJ4dHc40ZMbct/Z2DYUCcIMYO8tKwLx1u78wfwJ4Y/wwyZqdgX7ak5Rp+DNXUSQRUvTyFr5+mZODrc3YkXbMRjvN2d/e4bowgwSwbPdx0H+7U2KRhnniPxE6DVmCbgYESgAnCPwEQn2Dm86eQKU2e/GvJoe65vq5v1iWpx20eQgvw9HFmmlzZOQZ4FIXHcQxiN7jHDV3ZYOPPkj5Xf8pAH6reR0QdThF94UImVb48lRSSX8zCXaKNnUgwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuWtx7Vv7ovKUU+ewoic0KnQzDO0V9zZKoGheWS4rws=;
 b=QTC9IpHL7foHXvxpEHGVpN3D/1RWGy0QiawFjEl6/Y2wiEqknLqXAsRv5dpEgc0Bg6tlh7if+glXz9duqEHXyXKw5xBiRdkVMWDK6fUaH4PpbzMJX8bnYp2Bv+FYSeVc3LUWqKuuIsOPCxf/LlJ79eU/mvruK4HpSXeP1QV130sUCetAu1+peefA+okt4wmZIgVAL7RIlhcjpEzYLB9TCbDtMcVQgAua72whEgBCFFUyr3y4ywG5zZi6/BIuFvB2067uwjrZ+avsvb4HIK6+7KiMktsXY6hsLg2lVTh1DnRAXJq6gya6v02TaJCTPy7/gzy8WfAg2ltrXylRFB5bRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuWtx7Vv7ovKUU+ewoic0KnQzDO0V9zZKoGheWS4rws=;
 b=x0fiQ9uY1HWxsRmnSXtWB/4oGMDDzX/vnsauV0RF5TbiNT6yH0PEn8WXINj1pX6HoBpVh4dhMp7EByNmVOtSJSD+BEbJbWhVn6xyP7rO955TtJndT2tzyCTDNoojeR9ltx6OeGvyCp1C68af4CNG3yaam3TxXalStpNdrHFsscM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW2PR12MB4665.namprd12.prod.outlook.com (2603:10b6:302:2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:18:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 08:18:39 +0000
Message-ID: <45400d34-b7c8-851a-bc15-e9b4171c0356@amd.com>
Date: Fri, 13 May 2022 10:18:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v3
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220511120250.3066-1-christian.koenig@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20220511120250.3066-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::23) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16c61f28-c1db-4e93-b8d5-08da34b92f59
X-MS-TrafficTypeDiagnostic: MW2PR12MB4665:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB466565CC55BB2370D351A552F2CA9@MW2PR12MB4665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7vTzh48RQAdMnA5Krw+SKdzJYwSihZYwqpWIEc1pmF8HWwj+q0aa/MKCwpGqUs4WGzImggBOt/KKvIVWmFpaXpJw33FNhUGnSxgyBog2XdcsHhp6e07+JnJed9IQv+wZE+sXzZT/mK7W+jY8Uoz4KVHLL3siMkXMOWyyZccNY72BC58rCwvYM6BSeNc/wQx+k7A9wGqv4RNg6qgjziWpxHaQbaIRcnwBN3g1B/GVD4SkKggwzYD2N/ZDlTTwdSflDWj7uIH1E1fZmc8aRGvxBirCRLwN1Xl/nbcVPymWIwrFZ7jyy7G5SGr9nn8FdIhEhDW3YBchcRV60/zlVhW/k2Z0meFOQ0lUVjyZTMo5S+iFintznJGWCMLg9HlVyy+Mx2CZ8+YqrTqB0My9CFeR8J1AODBZ6MgAzw9P//OHLuEGFvXOmHnRcTCrh++rKyNlbierxTiTSV08kb/ukkJ44PWjkn/ZvwxPJugC1f2Me8xN/Ui05oKYYazFoDdeyNjSW2HNAjfeitVdZjPGR2VWO9Ic/FXnDkcA4ABUNMZx2MkOBhTlSY/+xhhD5o+3SW93obpBuFkyxEL7jfR+dhEradbtSr1yIEy4TtcDpQeGWdQDE/yxOMXfcwE4COCpj6HRysBk51UeFeZoUcXw6HbsLEIJW7mJ85Gg84FD7jFVgqT5VDcYlCuwARg/g/XBDhLxQ3veyyzpthxkTMO1SgOVMd5jK0i4KYa6uvpdbaoK3TcYpRrkQcR85ZK7akc51qh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(66556008)(2906002)(6486002)(31696002)(86362001)(8676002)(4326008)(5660300002)(66946007)(8936002)(316002)(38100700002)(54906003)(6506007)(186003)(36756003)(2616005)(30864003)(53546011)(83380400001)(66574015)(6666004)(31686004)(6512007)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkh6cXFhVlN0aVE1U0pKUWZxQThKcy9MbGt4dmE3WXAzc3ZCSThocVZ6d0Nj?=
 =?utf-8?B?RURNQ3VNWVh2Y3h6WmhrRkVrZGZFOUo5d0h0b3Z2RXV4YWJZcHlsSHZKdGdt?=
 =?utf-8?B?aGJTaTFjYXB3NFVQOWZrTlVFNE56a004MVMxZVlodFA1ZXA2dU43cWhRT1hq?=
 =?utf-8?B?VGRjYytTanZIcnFYL3JnMVZEdFcrNzIzVlMvVUVWWDZaZXVxd1Nid1FhYTBS?=
 =?utf-8?B?TGg5aTRMeVJxbnBWRUV0eFRuNEp0bzM1QVdETTBLdnRMRms5RElxS2ZzbEpq?=
 =?utf-8?B?ZWROOVZXdy92cVlJQWxyZUhLdEpIY2cwV05yM0s5d21xRytiVVFrNFkrUGFT?=
 =?utf-8?B?cDVORW5VcThZbXJ6UUh4cmNiNEdxd1RENnhRR2YrUWFlZWZ1WGhiV1lEOVJH?=
 =?utf-8?B?UkxsRjdlVHdtZ1hzYjVmOGdpa1VNaEVQU25IdTJtSnlUMXJ5SjNqMmJRWFIz?=
 =?utf-8?B?dHFYM3JwNm0rVXdQc2N2d2ZUS2JnbVZEUml5SGJoSkFmOHR6bGpKV3dHeGpr?=
 =?utf-8?B?b2hmbm9icmFReWhlb204RVV4QnpDOHkyUmkzWWpzTFN1YVltK1RuQkZGZHBh?=
 =?utf-8?B?T05NUE9WVk40TGZSbENiTHoyd2kwZW5DaHNHWjdWUnhSTGViZ1JDeTI0WE1v?=
 =?utf-8?B?S2N1OUh3U2NxaWZXNTJiVHdXSTZnNW1odzkrb0twOEVYaTFxQWJicXZKSlc1?=
 =?utf-8?B?RWZ3THlBbXdya1Q4eUYxUk9nSFRqMlJseW5vTUlvTCtrNnlEb29wUHQ4ckhX?=
 =?utf-8?B?SmVDTXBGK2RlSkw3NHhNd0FablJDSjBKWk5FRG92RkxWTExiR1I5eGFmclF3?=
 =?utf-8?B?QzBzc1l4TVUrMHNrNHJ5cUpLd3BGeURpRk9YQkxCemljYVBLK243ZWoxR0o0?=
 =?utf-8?B?Q3JvbVBtYTI0V09Dcmh0SFNrakQwUmtyMVN0bmV6eEtwL3g5WCtaOHVzSWJ5?=
 =?utf-8?B?ZUorNVowek9IZXNNbnN6MzZFUjZ4dW5YNzAxeGJtdXM4NVZZZ0NzZnY2K1Jq?=
 =?utf-8?B?bFIvekdkMmM0VHNkTmoyRmFkdHVybXRrajdELzdoLzg5dXVrTm8zR1dlTnpF?=
 =?utf-8?B?VW1UTi85aUkyandjS3BpRk8yNHphY2NEODNLdjRxYWZvcHF5OEh4RXZITWZU?=
 =?utf-8?B?enlLdVdnc0tlWGhuVSs0MUM1dWxYQms4QnRDTENGbGNadXhEbjlLUEJoZ0JM?=
 =?utf-8?B?OE9Day9YZVBrM2VjMDdoNFdmcUNzckxtbmdSTnM3bk5YZHVWL3VUcmQwbXJP?=
 =?utf-8?B?K016OVR3Wm9lSVVZSldlWm1aMlZlZ2t2d0FKdW5QRFhxekZNUDZnYlpDZFR6?=
 =?utf-8?B?Z215M1ZnM2NzVjJ2UGZLdGh2UVRnRlhhVmNWT3QxbzNlNDJGc2hjMi9qWlNo?=
 =?utf-8?B?d2NUOHFPSW00ZitSd1JPaUF2WDJaZGhXSnZ0UFEyVEs3VndoUHR2T3ZmSXJG?=
 =?utf-8?B?OUI1Z3RBbXhhM0syRk1lOHBaWTFZc3lWY2o5OUt4SnhiMzI2TzNpc3JialhU?=
 =?utf-8?B?aXF6UFg3VXNjd05Ebnd4MGRIQ3Y1ZFo0WHRqOHFlWHljcEQzRFJWdHNyemE4?=
 =?utf-8?B?Y01aZ0ZlSXhsTjg5ZFZkcEpGcGZSL2c2MWVnOGhpd3FDb2MzWXhEa3dUdHRM?=
 =?utf-8?B?WFRWdHhmOWN0OW5BbEo3WnpOcUVMNGFaenVSQTBURVp5d293eG5OYTBoT3F2?=
 =?utf-8?B?ZDVxbFNaVnA1WTdvY1NwUTB1NUFwcnpSYSthOHhybENnODVWYU0yZmJhMXpW?=
 =?utf-8?B?UDJqOS9NQnhURFdGbFZ2K01PRWpxQnp5ZEJIUE5PV21SSy9xaDdycXpvRHRq?=
 =?utf-8?B?bFI3ZUtzQ0hhOXVQQWFUSzBzNUNUMmZKTzVQamdJbVVoN2lZUnYzcnMvbkg0?=
 =?utf-8?B?NkMrNy9tN01GcTF1WW0xWWhKMEtXa3pEU3BOdGxDMnpqTVVraVk0ZkpNT3Bj?=
 =?utf-8?B?dWR2bXAzQjhEMElzSDVDaklYZ21KZlViSnNZOFladStCaUg2elNtV1ZrWGZY?=
 =?utf-8?B?VEVhQkU1L0NGUmZPbUNPcGhJajV1YnBHMHNYdVViRC9yRHBKTzlBTUdkaFVm?=
 =?utf-8?B?d2Vld3Z1UmtUeXNUQzU5c2lXSE1DeENqdlZyU1JVTjllV1ZjSi9MSnpzM1Az?=
 =?utf-8?B?azVPZWFSKzVpS00reFpYR0JKN2FNNkVhRVE4K2htWWdCeEhtakRvd1lsaGpP?=
 =?utf-8?B?WTNMckNlUXVPTHNyV0NmdzNoOFhZZlNnWWtHUUh4UE53NGEzVUNaak5TbGZR?=
 =?utf-8?B?U1FCT25qMEJQUk84RGcyVTUyUlFENXg5bDRMZndqUnZNczZzVEVhYTVWc0F1?=
 =?utf-8?B?MGtmY0Y4MmlJQ2t3T21ib0tBZ3cyQlU2cEx5TEkxRU0wQ3k2bFpVd2VvNVZr?=
 =?utf-8?Q?Y0OGo3QDLjFFnMF/nlVeo5IMjnlom1/F+X8hAm6hPA2en?=
X-MS-Exchange-AntiSpam-MessageData-1: ENzOxgZDFv33dg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c61f28-c1db-4e93-b8d5-08da34b92f59
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:18:39.6394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2/5qIS/jOsifhJjRgMSCVZ+Fm9AncJToiwuIWS5qL1CP392HxRGIbIHx0oXWesw4EzMOSxlmYSggOaGgvp94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
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
Cc: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, daniel@ffwll.ch,
 David M Nieto <David.Nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

On 5/11/2022 2:02 PM, Christian König wrote:
> Convert fdinfo format to one documented in drm-usage-stats.rst.
> 
> It turned out that the existing implementation was actually completely
> nonsense. The calculated percentages indeed represented the usage of the
> engine, but with varying time slices.
> 
> So 10% usage for application A could mean something completely different
> than 10% usage for application B.
> 
> Completely nuke that and just use the now standardized nanosecond
> interface.
> 
> v2: drop the documentation change for now, nuke percentage calculation
> v3: only account for each hw_ip, move the time_spend to the ctx mgr.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Cc: David M Nieto <David.Nieto@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 234 ++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  23 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  41 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   2 +-
>   5 files changed, 153 insertions(+), 149 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 01853431249d..43b97ad3c6be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1239,7 +1239,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   
>   	p->fence = dma_fence_get(&job->base.s_fence->finished);
>   
> -	amdgpu_ctx_add_fence(p->ctx, entity, p->fence, &seq);
> +	seq = amdgpu_ctx_add_fence(&fpriv->ctx_mgr, p->ctx, entity, p->fence);
>   	amdgpu_cs_post_dependencies(p);
>   
>   	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 8f0e6d93bb9c..5a0d67cc3d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -135,9 +135,9 @@ static enum amdgpu_ring_priority_level amdgpu_ctx_sched_prio_to_ring_prio(int32_
>   
>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   {
> -	struct amdgpu_device *adev = ctx->adev;
> -	int32_t ctx_prio;
> +	struct amdgpu_device *adev = ctx->mgr->adev;
>   	unsigned int hw_prio;
> +	int32_t ctx_prio;
>   
>   	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
> @@ -162,17 +162,49 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>   	return hw_prio;
>   }
>   
> +/* Calculate the time spend on the hw */
> +static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
> +{
> +	struct drm_sched_fence *s_fence;
> +
> +	if (!fence)
> +		return ns_to_ktime(0);
> +
> +	/* When the fence is not even scheduled it can't have spend time */
> +	s_fence = to_drm_sched_fence(fence);
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
> +		return ns_to_ktime(0);
> +
> +	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
> +		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
shouldn't this be s_fence->finished.timestamp instead of 
s_fence->scheduled.timestamp ?
> +
> +	return ktime_sub(s_fence->finished.timestamp,
> +			 s_fence->scheduled.timestamp);
> +}
> +
> +static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
> +				      struct amdgpu_ctx_entity *centity)
> +{
> +	ktime_t res = ns_to_ktime(0);
> +	uint32_t i;
> +
> +	spin_lock(&ctx->ring_lock);
> +	for (i = 0; i < amdgpu_sched_jobs; i++) {
> +		res = ktime_add(res, amdgpu_ctx_fence_time(centity->fences[i]));
> +	}
> +	spin_unlock(&ctx->ring_lock);
> +	return res;
> +}
>   
>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   				  const u32 ring)
>   {
> -	struct amdgpu_device *adev = ctx->adev;
> -	struct amdgpu_ctx_entity *entity;
>   	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
> -	unsigned num_scheds = 0;
> -	int32_t ctx_prio;
> -	unsigned int hw_prio;
> +	struct amdgpu_device *adev = ctx->mgr->adev;
> +	struct amdgpu_ctx_entity *entity;
>   	enum drm_sched_priority drm_prio;
> +	unsigned int hw_prio, num_scheds;
> +	int32_t ctx_prio;
>   	int r;
>   
>   	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> @@ -182,6 +214,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   
>   	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
> +	entity->hw_ip = hw_ip;
>   	entity->sequence = 1;
>   	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>   	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
> @@ -220,11 +253,29 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	return r;
>   }
>   
> -static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> +{
> +	ktime_t res = ns_to_ktime(0);
> +	int i;
> +
> +	if (!entity)
> +		return res;
> +
> +	for (i = 0; i < amdgpu_sched_jobs; ++i) {
> +		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
> +		dma_fence_put(entity->fences[i]);
Don't we need a corresponding _get() for this put() ? I had a quick look 
at amdgpu_ctx_fence_time() too, and it seems it had its own pair of 
get/put.

> +	}
> +
> +	kfree(entity);
> +	return res;
> +}
> +
> +static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr,
>   			   int32_t priority,
>   			   struct drm_file *filp,
>   			   struct amdgpu_ctx *ctx)
>   {
> +	struct amdgpu_device *adev = mgr->adev;
>   	int r;
>   
>   	r = amdgpu_ctx_priority_permit(filp, priority);
> @@ -233,9 +284,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   
>   	memset(ctx, 0, sizeof(*ctx));
>   
> -	ctx->adev = adev;
> -
>   	kref_init(&ctx->refcount);
> +	ctx->mgr = mgr;
>   	spin_lock_init(&ctx->ring_lock);
>   	mutex_init(&ctx->lock);
>   
> @@ -249,24 +299,10 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> -{
> -
> -	int i;
> -
> -	if (!entity)
> -		return;
> -
> -	for (i = 0; i < amdgpu_sched_jobs; ++i)
> -		dma_fence_put(entity->fences[i]);
> -
> -	kfree(entity);
> -}
> -
>   static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>   					u32 *stable_pstate)
>   {
> -	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_device *adev = ctx->mgr->adev;
>   	enum amd_dpm_forced_level current_level;
>   
>   	current_level = amdgpu_dpm_get_performance_level(adev);
> @@ -294,7 +330,7 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>   static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   					u32 stable_pstate)
>   {
> -	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_device *adev = ctx->mgr->adev;
>   	enum amd_dpm_forced_level level;
>   	int r;
>   
> @@ -340,7 +376,8 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>   static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
> +	struct amdgpu_device *adev = mgr->adev;
>   	unsigned i, j, idx;
>   
>   	if (!adev)
> @@ -348,8 +385,10 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   
>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>   		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
> -			amdgpu_ctx_fini_entity(ctx->entities[i][j]);
> -			ctx->entities[i][j] = NULL;
> +			ktime_t spend;
> +
> +			spend = amdgpu_ctx_fini_entity(ctx->entities[i][j]);
> +			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
>   		}
>   	}
>   
> @@ -416,7 +455,7 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>   	}
>   
>   	*id = (uint32_t)r;
> -	r = amdgpu_ctx_init(adev, priority, filp, ctx);
> +	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>   	if (r) {
>   		idr_remove(&mgr->ctx_handles, *id);
>   		*id = 0;
> @@ -666,19 +705,20 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>   	return 0;
>   }
>   
> -void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
> -			  struct drm_sched_entity *entity,
> -			  struct dma_fence *fence, uint64_t *handle)
> +uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx_mgr *mgr,
> +			      struct amdgpu_ctx *ctx,
> +			      struct drm_sched_entity *entity,
> +			      struct dma_fence *fence)
>   {
>   	struct amdgpu_ctx_entity *centity = to_amdgpu_ctx_entity(entity);
>   	uint64_t seq = centity->sequence;
>   	struct dma_fence *other = NULL;
>   	unsigned idx = 0;
> +	ktime_t spend;
>   
>   	idx = seq & (amdgpu_sched_jobs - 1);
>   	other = centity->fences[idx];
> -	if (other)
> -		BUG_ON(!dma_fence_is_signaled(other));
> +	BUG_ON(other && !dma_fence_is_signaled(other));
>   
>   	dma_fence_get(fence);
>   
> @@ -687,9 +727,40 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>   	centity->sequence++;
>   	spin_unlock(&ctx->ring_lock);
>   
> +	spend = amdgpu_ctx_fence_time(other);
> +	atomic64_add(ktime_to_ns(spend), &mgr->time_spend[centity->hw_ip]);
> +
>   	dma_fence_put(other);
> -	if (handle)
> -		*handle = seq;
> +	return seq;
> +}
> +
> +ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw_ip)
> +{
> +	struct amdgpu_ctx *ctx;
> +	unsigned int i;
> +	uint32_t id;
> +	ktime_t res;
> +
> +	/*
> +	 * This is a little bit racy because it can be that ctx or fences are
> +	 * destroyed just in the moment we try to account them. But that is ok
> +	 * since exactly that case is explicitely allowed by the interface.
> +	 */
> +	mutex_lock(&mgr->lock);
> +	res = ns_to_ktime(atomic64_read(&mgr->time_spend[hw_ip]));
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +		for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
> +			struct amdgpu_ctx_entity *centity;
> +
> +			centity = ctx->entities[hw_ip][i];
> +			if (!centity)
> +				continue;
> +			res = ktime_add(res, amdgpu_ctx_entity_time(ctx,
> +								    centity));
> +		}
> +	}
> +	mutex_unlock(&mgr->lock);
> +	return res;
>   }
>   
>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
> @@ -726,7 +797,7 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   					   int hw_ip,
>   					   int32_t priority)
>   {
> -	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_device *adev = ctx->mgr->adev;
>   	unsigned int hw_prio;
>   	struct drm_gpu_scheduler **scheds = NULL;
>   	unsigned num_scheds;
> @@ -791,10 +862,17 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   	return r;
>   }
>   
> -void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
> +void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
> +			 struct amdgpu_device *adev)
>   {
> +	unsigned int i;
> +
> +	mgr->adev = adev;
>   	mutex_init(&mgr->lock);
>   	idr_init(&mgr->ctx_handles);
> +
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> +		atomic64_set(&mgr->time_spend[i], 0);
>   }
>   
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
> @@ -869,81 +947,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	idr_destroy(&mgr->ctx_handles);
>   	mutex_destroy(&mgr->lock);
>   }
> -
> -static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx,
> -		struct amdgpu_ctx_entity *centity, ktime_t *total, ktime_t *max)
> -{
> -	ktime_t now, t1;
> -	uint32_t i;
> -
> -	*total = *max = 0;
> -
> -	now = ktime_get();
> -	for (i = 0; i < amdgpu_sched_jobs; i++) {
> -		struct dma_fence *fence;
> -		struct drm_sched_fence *s_fence;
> -
> -		spin_lock(&ctx->ring_lock);
> -		fence = dma_fence_get(centity->fences[i]);
> -		spin_unlock(&ctx->ring_lock);
> -		if (!fence)
> -			continue;
> -		s_fence = to_drm_sched_fence(fence);
> -		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
> -			dma_fence_put(fence);
> -			continue;
> -		}
> -		t1 = s_fence->scheduled.timestamp;
> -		if (!ktime_before(t1, now)) {
> -			dma_fence_put(fence);
> -			continue;
> -		}
> -		if (dma_fence_is_signaled(&s_fence->finished) &&
> -			s_fence->finished.timestamp < now)
> -			*total += ktime_sub(s_fence->finished.timestamp, t1);
> -		else
> -			*total += ktime_sub(now, t1);
> -		t1 = ktime_sub(now, t1);
> -		dma_fence_put(fence);
> -		*max = max(t1, *max);
> -	}
> -}
> -
> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> -		uint32_t idx, uint64_t *elapsed)
> -{
> -	struct idr *idp;
> -	struct amdgpu_ctx *ctx;
> -	uint32_t id;
> -	struct amdgpu_ctx_entity *centity;
> -	ktime_t total = 0, max = 0;
> -
> -	if (idx >= AMDGPU_MAX_ENTITY_NUM)
> -		return 0;
> -	idp = &mgr->ctx_handles;
> -	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(idp, ctx, id) {
> -		ktime_t ttotal, tmax;
> -
> -		if (!ctx->entities[hwip][idx])
> -			continue;
> -
> -		centity = ctx->entities[hwip][idx];
> -		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> -
> -		/* Harmonic mean approximation diverges for very small
> -		 * values. If ratio < 0.01% ignore
> -		 */
> -		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> -			continue;
> -
> -		total = ktime_add(total, ttotal);
> -		max = ktime_after(tmax, max) ? tmax : max;
> -	}
> -
> -	mutex_unlock(&mgr->lock);
> -	if (elapsed)
> -		*elapsed = max;
> -
> -	return total;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 142f2f87d44c..a28ebf3be764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -23,16 +23,20 @@
>   #ifndef __AMDGPU_CTX_H__
>   #define __AMDGPU_CTX_H__
>   
> +#include <linux/ktime.h>
> +#include <linux/types.h>
> +
>   #include "amdgpu_ring.h"
>   
>   struct drm_device;
>   struct drm_file;
>   struct amdgpu_fpriv;
> +struct amdgpu_ctx_mgr;
>   
>   #define AMDGPU_MAX_ENTITY_NUM 4
> -#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) ((max) > 16384ULL*(total))
>   
>   struct amdgpu_ctx_entity {
> +	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
>   	struct dma_fence	*fences[];
> @@ -40,7 +44,7 @@ struct amdgpu_ctx_entity {
>   
>   struct amdgpu_ctx {
>   	struct kref			refcount;
> -	struct amdgpu_device		*adev;
> +	struct amdgpu_ctx_mgr		*mgr;
A suggestion here, should we split this patch in 2 parts:
- introduce ctx_mgr and change the respective APIs
- use ctx_mgr and calculate the time spent per context

It would make it easier to read and review.

- Shashank

>   	unsigned			reset_counter;
>   	unsigned			reset_counter_query;
>   	uint32_t			vram_lost_counter;
> @@ -61,6 +65,7 @@ struct amdgpu_ctx_mgr {
>   	struct mutex		lock;
>   	/* protected by lock */
>   	struct idr		ctx_handles;
> +	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
>   };
>   
>   extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
> @@ -70,9 +75,10 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
>   
>   int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   			  u32 ring, struct drm_sched_entity **entity);
> -void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
> -			  struct drm_sched_entity *entity,
> -			  struct dma_fence *fence, uint64_t *seq);
> +uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx_mgr *mgr,
> +			      struct amdgpu_ctx *ctx,
> +			      struct drm_sched_entity *entity,
> +			      struct dma_fence *fence);
>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   				       struct drm_sched_entity *entity,
>   				       uint64_t seq);
> @@ -85,10 +91,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   			       struct drm_sched_entity *entity);
>   
> -void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
> +void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
> +			 struct amdgpu_device *adev);
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
> -ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
> -		uint32_t idx, uint64_t *elapsed);
> +ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 5a6857c44bb6..52c2b90925a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -32,6 +32,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_debugfs.h>
> +#include <drm/drm_drv.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> @@ -55,10 +56,10 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   {
>   	struct amdgpu_fpriv *fpriv;
> -	uint32_t bus, dev, fn, i, domain;
>   	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>   	struct drm_file *file = f->private_data;
>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +	uint32_t bus, dev, fn, domain, hw_ip;
>   	struct amdgpu_bo *root;
>   	int ret;
>   
> @@ -83,29 +84,25 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	amdgpu_bo_unreserve(root);
>   	amdgpu_bo_unref(&root);
>   
> -	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
> -			dev, fn, fpriv->vm.pasid);
> -	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
> -	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
> -	seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
> -		uint32_t count = amdgpu_ctx_num_entities[i];
> -		int idx = 0;
> -		uint64_t total = 0, min = 0;
> -		uint32_t perc, frac;
> +	/*
> +	 * ******************************************************************
> +	 * For text output format description please see drm-usage-stats.rst!
> +	 * ******************************************************************
> +	 */
>   
> -		for (idx = 0; idx < count; idx++) {
> -			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
> -				i, idx, &min);
> -			if ((total == 0) || (min == 0))
> -				continue;
> +	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> +	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
> +			dev, fn, fpriv->vm.pasid);
> +	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> +	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
> +	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
> +	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> +		ktime_t usage = amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, hw_ip);
>   
> -			perc = div64_u64(10000 * total, min);
> -			frac = perc % 100;
> +		if (!usage)
> +			continue;
>   
> -			seq_printf(m, "%s%d:\t%d.%d%%\n",
> -					amdgpu_ip_name[i],
> -					idx, perc/100, frac);
> -		}
> +		seq_printf(m, "drm-engine-%s:\t%Ld ns\n",
> +			   amdgpu_ip_name[hw_ip], ktime_to_ns(usage));
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 6b626c293e72..0814e6508a00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1144,7 +1144,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	mutex_init(&fpriv->bo_list_lock);
>   	idr_init(&fpriv->bo_list_handles);
>   
> -	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
> +	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
>   	file_priv->driver_priv = fpriv;
>   	goto out_suspend;
