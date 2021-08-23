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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D979C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 07:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5606D6124D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 07:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5606D6124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8CB89D2F;
	Mon, 23 Aug 2021 07:08:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E57889D2F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 07:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO8KRwyXy53kvxR2xWUYriVekMWyzr6iV/DIIwadhsbyEEuf5I6DMnh1OoDlm7dE5yBVqYs81DdQu+Xnc/Qys0WNlxbN3JDan/1vVT0NXFxYzCealOAxOgphfIcbrzwGYNOU5T13+4HiGcHJfrwvSKCCJCDHPbbCIPniuxLkCSbTCoET6+/kyBFkU1PqA40j98IFF8b7rIAG1B7Y5nhA4kZm1rCIRDNRXnduoJxAxGweJB+ZbYGgF+jLShHGDKomwhCf/ZcHdX6JE7ZMELgfx4Rv2LCxX/iUuVd9YXTZWX3Uo7NhaP66t13rr2amAvqW+Y4H05nlUPrSkzpKWgf9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSeP+MgIdC9LhrFOo22YVgW39AppWNomyu36IS1hHWg=;
 b=N5n6uCVFsHbaL+r3hU0l9neBBvhmVk/vHo3szxxai4Wu+PBbKyTI+PdvGIMdct4Her6Qf+HxxfYlu9UPOKPRlNXvss1/bBw3XBJsGtje4NjQTFtYnaC2myoWatTz5YPLfQdsBxetG9sF9mvtDIsujW6kKx/i9j4aImRyfih0ayl9zQxbnOspuKU1zFS6QvhPj33pTmXTWemroSCRIRQi4pbJbStdCnEeIPJV7W5duIeUFMzNT0smuhucp4GRFug5sWMOhv3JZjskwfohlldG6abSkJcdUfHNq98NHxqtu3u8L4L12sCQ5yWd755iTEDl9d0S9xrH7tZzb+bGbPYPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSeP+MgIdC9LhrFOo22YVgW39AppWNomyu36IS1hHWg=;
 b=cF5QhfyOX7M0yvdcO+YvDpzJFnYGb8xd1rbpr2irNrU9aFtJR8uIOyRY6rO0KI6PustHPy+Rf4+gyZKm7xHUy8tgJAkuaRuG6bg7fsyz5pU+pTh6J15PQSfcU2iv3bZp7YOu1GFpyKnhDkvmY7sYZwEwyG7HSZEM0ktM7L0QrXw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 07:08:44 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Mon, 23 Aug 2021
 07:08:44 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
Date: Mon, 23 Aug 2021 12:38:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 07:08:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13e66c0-b6d1-4820-68ca-08d96604d817
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256826AC7255210FC3922E397C49@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJ9cTjGLXS6khtNgt8SsiNUPN82xCy0WRre1dweWKRUdiUtlbI18a7JQ4lPkUXZ8BRPvxWsPzyzLKSdI7OFaBHSptrFjGZi93XK4LUD5iO22zpthFmEdVwGgvt+rqiFVjK7egC9WvFd6rLvY4Cj/4Sw/3O1EtCSrz1J3SWycVd4Z1zeG9mMnoVr7iOfJjjFIIfmGHMQ+evqqy4Q9q17xXVQbZIn595YhCX4RPCzAicRKxZcj3nEHLc39eZSLUrwehE5bOy+qXEXQikw+FfBn3lm0bR/Ctl76bxPRl86CvR9D7wIGNhXxRZudxqIWgw6YmvNSde3zkHH+Hwv5Br2aTsT0R5vLWJB/6GL5dZ6B56lkEL3NOWkLiSVLOYWvAiJ6eoZF48C2tiCmThOgt+xNH65izZEbWzKF5QE2ve6nO6Bqi/XDtFBAA0Pn29Cz4XMXWb3eJLBUvkXYi/4oXAPa/xqBLwnOdOiKjWit8OZ/U91/EIyR7HwMMLvErw78TvI4kmcOllbO16dEa4YFVbXOGxWzOT3ck4V81IyyxbnrU0gHtZPPYjEaOQMUH7NSLdSiQYKfAnheYLKJKYPrBeHQUmol5+VZRG1f7x7j5JcWzZTzf11eH80QC+e4NUiA+lBgnGITRCOo8Lv2t/PmmyLlL5u36XDSPl5iGGkXcGe80ktw/bcl0i8ooYCqJMsVG2rUQtLUSGHWwATrU3gRK0ixkQzKR2EEY7PlBZMsWt0I0+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(30864003)(53546011)(6486002)(66476007)(31686004)(8676002)(26005)(66556008)(86362001)(66946007)(5660300002)(316002)(16576012)(8936002)(6666004)(478600001)(36756003)(956004)(2906002)(31696002)(2616005)(83380400001)(38100700002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9tNGNINi9BNHgvd2g1Z3ExODQ2TXhwWjNCbjJqSlJpWlQwcmhmRkVRajdK?=
 =?utf-8?B?VmczQkkrQ3ozYXU1VkVBVWduSmNDRDF3ZDVIRlBvNzNncmYwd0tMckMzYmFP?=
 =?utf-8?B?V1NaN002V3diY3orL295aGVWbGtWRUhOOUhYVU1uNDRLM2M0aEFNUmt0NVZs?=
 =?utf-8?B?YzJ1UzFxVXJoem1Hb1NmbnBtZWY0N0w5SGY4cDJoS0tSZm9CK1NiRkdmMXoy?=
 =?utf-8?B?UklGVTJKOGV1dTNKQ2NEV3pRaUNsRHowMHNURytVaC9kcHNqK25mb3RvcDcy?=
 =?utf-8?B?TWZJNDVWUHJkNFZpRHFpVldTV2pQMml5MkY2SDB6bXZzSWxtOUtiUUtlTGFy?=
 =?utf-8?B?NVdlQlBnUWZYZXhVRDdFVHhlNFVEaDVleFEveFMvQU5uWC9CNHNTNlZNS283?=
 =?utf-8?B?aTUvOHBzTGNxcjlLeWpGZEFRbEJpMmFhTTVQTjNMYlhWa2lzK0huTTJuTXdT?=
 =?utf-8?B?RW5pd09FcHM3aCsyOU9neDI0WGUwOVp4U1VOa2pDMG91TEw3RDBUZVF1UXdY?=
 =?utf-8?B?WXFlQjRXajNrT3JuYUJ5VjBwK05BM3QwNjZvcnhicHpMQWpNOU5XamI4elI4?=
 =?utf-8?B?bThrRmxSNDBpNGRGVU1wY2lLbWd5TnhWOTU2V0xmZmkzNUlqY1RwRzBaUHRn?=
 =?utf-8?B?Vlludi8rN2lFMFFwODJvV29qNHlySTFwcHRacE1ra3hPcE04YTZ5SEVqMDRS?=
 =?utf-8?B?MnBOdkFJZzBpcWQ4WFhLRlNISW8rUTMvSDRqQUxvNnM4WU5Sa1Q0dmo2Q3ZS?=
 =?utf-8?B?WURTMVZKYlpIcjVORVFIdzdCeGxyMGlDaEllTDhyZGJreTU2cWdTU1RqNmlM?=
 =?utf-8?B?S2laaWZhS2x6aFpnTldyUENDazdCdUVkbVVRN2RBZEU2ME9sU05mTUhoY0cx?=
 =?utf-8?B?bTBoR3gvWm5hMG5aNHJMSnAyb2lTdkN6ZWI5OTJXYXhHVnNjenRYUGp0K3h6?=
 =?utf-8?B?a3A3TWNyVE9pK3psT3ZDZDlTUW5KcWZ0c3phNDhZbUVXYWlrRmpicFR4WGY3?=
 =?utf-8?B?OExieGFrWjlOemJyS09ON25aNXpTSG0vbzE0U2xNaFJreFRzdjRsSXNiRDdZ?=
 =?utf-8?B?MXk4dGp4M1hxK2xleXpkWERRN0JWN1hqM25wK0xmbVRnSi9Dd2xqTHlJNVVU?=
 =?utf-8?B?SVdlVHBqMjNpeWF4S0IwV212MDdUUU0wMXo0VlNCZnEzTHdwVU1MbDdtVjJ6?=
 =?utf-8?B?VWoyL2ErakpZOWduQ1ZCVXR6cThJbjMzRXRtY3RGQjVlbGQyLzIzc1hXUXlx?=
 =?utf-8?B?UVpGV1ZJZmtyWXYyZk0xdE1temtpQXd4ak5LeUVqQ2tFUHpaL2p3NThsdXNm?=
 =?utf-8?B?TEM2cHY4VGpVTnVicVNxUjJocmF6TlBvU0c5cXF1V08wMnlJaXpNYlhQNkli?=
 =?utf-8?B?bzVvcEFPamt1Qmo3MGRBRVpvZFE2djI5VG8zdEdPbmpHVjVUbkwvbitEeEsr?=
 =?utf-8?B?Q000QmFBaWdacDNqTGlnWnljcjZLVEVrOFA4WHBONVhGNklPdnczcXAyWk1J?=
 =?utf-8?B?TjlyYlp3Z1JzTUZDSjBueVdwaWZqUGhtZ01EZUd3U2R5d1haNkdKeGdBaCsw?=
 =?utf-8?B?cUc4VWQvVUZzNE5Fb2l4NGF5aWM0Rng2U1NGeWc2TCtLOUdiTU1GbjZGalM4?=
 =?utf-8?B?Nk1rUWhaRFU0T0pwM0YrSU9hTkdCaGZmeEhyU00rc2dUcHpjeE9jU2JUTURu?=
 =?utf-8?B?Y1d0NkE5cWFRNENvZjJqOTZTZlQwVllrT01Tenhqd0VRSEFtY3JobDVZUVJC?=
 =?utf-8?Q?Dq8ZFd473ZICFpoiA1QoII+iCO0ADD0Fnyo0z9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13e66c0-b6d1-4820-68ca-08d96604d817
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 07:08:44.3211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKFXKaI557UhVuzBHlratls/GokdsIDZCjMZd/F2aiIdP5Ycn5qRut/2iIYdRdPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
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



On 8/20/2021 11:02 AM, Joseph Greathouse wrote:
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
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>   3 files changed, 107 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f8fce9d05f50..86bdb765f350 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   static int map_queues_cpsch(struct device_queue_manager *dqm);
>   
>   static void deallocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>   				struct queue *q);
>   
>   static inline void deallocate_hqd(struct device_queue_manager *dqm,
>   				struct queue *q);
>   static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>   				struct queue *q);
>   static void kfd_process_hw_exception(struct work_struct *work);
>   
> @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   			q->pipe, q->queue);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		retval = allocate_sdma_queue(dqm, q);
> +		retval = allocate_sdma_queue(dqm, qpd, q);
>   		if (retval)
>   			goto deallocate_vmid;
>   		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   		deallocate_hqd(dqm, q);
>   	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>   deallocate_vmid:
>   	if (list_empty(&qpd->queues_list))
>   		deallocate_vmid(dqm, qpd, q);
> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>   	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		deallocate_hqd(dqm, q);
>   	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>   	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>   	else {
>   		pr_debug("q->properties.type %d is invalid\n",
>   				q->properties.type);
> @@ -1039,42 +1041,93 @@ static void pre_reset(struct device_queue_manager *dqm)
>   	dqm_unlock(dqm);
>   }
>   
> +static uint64_t sdma_engine_mask(int engine, int num_engines)

Looks more like the queue mask for an engine, the name doesn't make it 
clear.

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
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>   				struct queue *q)
>   {
> -	int bit;
> +	uint64_t available_queue_bitmap;
> +	unsigned int bit, engine, num_engines;
> +	bool found_sdma = false;
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
> -		if (dqm->sdma_bitmap == 0) {

This is still a valid optimization and no need to loop through if 
nothing is available anyway. Valid for XGMI loop also.

> +		num_engines = get_num_sdma_engines(dqm);
> +		for_each_set_bit(engine, &(qpd->sdma_engine_bitmap), num_engines) {

Probably a naive question -

Theoretically there are 8 queues per engine as per the mask code. In the 
below code, there is an assumption that a process will use at best 
number of queues=max num of sdma engines or xgmi engines simultaneously. 
Is that true always? For ex: there are 2 sdma engines and 4 queues per 
engine. Can't multiple threads of a process initiate multiple sdma 
transactions > number of sdma engines available? This code limits that, 
but I don't know if that is a possible case.

Thanks,
Lijo

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
>   			pr_err("No more SDMA queue to allocate\n");
>   			return -ENOMEM;
>   		}
> -
> -		bit = __ffs64(dqm->sdma_bitmap);
> -		dqm->sdma_bitmap &= ~(1ULL << bit);
> -		q->sdma_id = bit;
> -		q->properties.sdma_engine_id = q->sdma_id %
> -				get_num_sdma_engines(dqm);
> -		q->properties.sdma_queue_id = q->sdma_id /
> -				get_num_sdma_engines(dqm);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
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
> +			break;
> +		}
> +		if (!found_sdma) {
>   			pr_err("No more XGMI SDMA queue to allocate\n");
>   			return -ENOMEM;
>   		}
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
>   	}
>   
>   	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   }
>   
>   static void deallocate_sdma_queue(struct device_queue_manager *dqm,
> +				struct qcm_process_device *qpd,
>   				struct queue *q)
>   {
> +	uint32_t engine = q->properties.sdma_engine_id;
> +
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>   		if (q->sdma_id >= get_num_sdma_queues(dqm))
>   			return;
>   		dqm->sdma_bitmap |= (1ULL << q->sdma_id);
> +		/* Don't give SDMA0 back to be reallocated on Aldebaran.
> +		 * It is only OK to use this engine from the first allocation
> +		 * within a process.
> +		 */
> +		if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
> +					engine == 0))
> +			qpd->sdma_engine_bitmap |= (1ULL << engine);
> +
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>   			return;
>   		dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
> +		/* engine ID in the queue properties is the global engine ID.
> +		 * The XGMI engine bitmap ignores the PCIe-optimized engines.
> +		 */
> +		engine -= get_num_sdma_engines(dqm);
> +		qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>   	}
>   }
>   
> @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		dqm_lock(dqm);
> -		retval = allocate_sdma_queue(dqm, q);
> +		retval = allocate_sdma_queue(dqm, qpd, q);
>   		dqm_unlock(dqm);
>   		if (retval)
>   			goto out;
> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		dqm_lock(dqm);
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>   		dqm_unlock(dqm);
>   	}
>   out:
> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		deallocate_sdma_queue(dqm, q);
> +		deallocate_sdma_queue(dqm, qpd, q);
>   		pdd->sdma_past_activity_counter += sdma_val;
>   	}
>   
> @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   	/* Clear all user mode queues */
>   	list_for_each_entry(q, &qpd->queues_list, list) {
>   		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
> -			deallocate_sdma_queue(dqm, q);
> +			deallocate_sdma_queue(dqm, qpd, q);
>   		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> -			deallocate_sdma_queue(dqm, q);
> +			deallocate_sdma_queue(dqm, qpd, q);
>   
>   		if (q->properties.is_active) {
>   			decrement_queue_count(dqm, q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ab83b0de6b22..c38eebc9db4d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -576,6 +576,8 @@ struct qcm_process_device {
>   	struct list_head priv_queue_list;
>   
>   	unsigned int queue_count;
> +	unsigned long sdma_engine_bitmap;
> +	unsigned long xgmi_sdma_engine_bitmap;
>   	unsigned int vmid;
>   	bool is_debug;
>   	unsigned int evicted; /* eviction counter, 0=active */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 21ec8a18cad2..13c85624bf7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1422,6 +1422,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   							struct kfd_process *p)
>   {
>   	struct kfd_process_device *pdd = NULL;
> +	const struct kfd_device_info *dev_info = dev->dqm->dev->device_info;
>   
>   	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>   		return NULL;
> @@ -1446,6 +1447,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   	pdd->qpd.pqm = &p->pqm;
>   	pdd->qpd.evicted = 0;
>   	pdd->qpd.mapped_gws_queue = false;
> +	pdd->qpd.sdma_engine_bitmap = BIT_ULL(dev_info->num_sdma_engines) - 1;
> +	pdd->qpd.xgmi_sdma_engine_bitmap = BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>   	pdd->process = p;
>   	pdd->bound = PDD_UNBOUND;
>   	pdd->already_dequeued = false;
> 
