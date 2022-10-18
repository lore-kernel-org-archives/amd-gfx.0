Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDFDC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 11:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38A410E820;
	Tue, 18 Oct 2022 11:25:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4067910E820
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 11:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S66sU1JwDL2sGbpUt7kxyMkiXaFOieXrug8GBKP456hy/9JKh8KIN0W+ftO1ZvWOnBFr5E2eZQLNKa68p/38H60eiviUJRBXUMulkE4Z51aHU7mBqAM46KatEEW30Cn1dSI4slDj3Tnrn75tdSl8Ux5TKPl/vcmXEsSI44fJF1dvRw5i+Ck12EBZ7XEah0TknaVttQZcEYKw5Tm+II7FB221H0dAkCoIL4uxbpqTT70Aig7uzMOfyk+S3jrgj01ilbHJpSF4+LL46lwdqWNbM/TchTSgDfabVZ50xaA7Y33XNydMcSRJcJ6H0Xs6rOEoYRxyBQ2QJWtA7NtVNNcijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWY82K55dN5aRAU5xObigCzvaUhHhUt9oKGDCjQSDFE=;
 b=BbHdRbunr2ijbHvCIdGUnfGRufY0jdWc3jSLUTC044Rb9EJHCZjJ6sP623n8D0BMDbr55gTryIIsGLmdt110a2ltLCdcw4uReYKOyeXbXbswZJyf3vcd8lpQB8LwAgr+sC6B2dXera5o6ukQdNzfc9RQznbzH5Lczlmh9fOCRQn76P6ZPKfn0sr8KFMDhcVduJ00Hr3B7DPQ1WVTkJ6ZnAkK/M59Z3+JZ40WBnYqgC+wr5AUiZqmS5O3Z5F2ikeX5h7Tv8TgpH8VQVNcPQlbWDGdy3LPMN9oQdNiz7C7BGvNfiAke/GE70jirg6pplgDwIAW/OjCY/UmynT/1O09rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWY82K55dN5aRAU5xObigCzvaUhHhUt9oKGDCjQSDFE=;
 b=ZO2XfXbjnhWaLaJARYG64ms2vZ4qN6wwborYFWJmV7y+FZYSJHT5UOHUfspmTy8chPo03F96uZ8LI6HJgzYsMBOLZqgcX582rDWZpWiJDjfu07Cn8H24I2Ux3YohLan7HqhbqQY5gknndnbUs8ggQPs6yKp1oVU+MLIcIwHiku8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 11:25:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 11:25:01 +0000
Message-ID: <6cde0148-b829-cc7e-ebf7-288b74ba8147@amd.com>
Date: Tue, 18 Oct 2022 13:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] drm/amdgpu: Improve the software ring priority
 scheduler
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
 <20221018090815.2662321-5-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221018090815.2662321-5-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbcc78d-26f1-46d0-b0e6-08dab0fb6583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuCNl2RFPhxXK5svwLCw08WaqulnMyEm+Q7lUGGQyBHS5PmxsFonyG6Wv+ZxAWKbqkILYW6RPZzvgeZKCJzWXKJYegBVwryb0brxw0p404/xP8+0j9XVRghz1UhrNIBO8Ml/4EEQpkGLxYjy0LdIlIJHRORDDcIbV6dQd5bAsKsLITDRoVUEG500mq/03YPXVfgutqg2/IV/l2bgIPXhJA1EBeqUQ2g2rnEUN7iPyJxJvi85BMpfcMj+Fas7Hksn7+zqwC9NJrbOHWH26aLEenQrNDvN8B3FmK1U483GbYvkCeETBMXsn17gW6nL/HcXSqKIp3DLdbHIper3v5PFAgHJhVGBlW23Y4D6tORjhanjfl+U+rRCf2xiesVS0DCITHynsO4/IPTLs1+ZNd8QIUi5bQGsj7EEixlH8Op31U45TlwUO8URa4ltxg5tw0FZYsty7lay2pLo/pgGZhQymgplcOZ6FA5IKim/BlK1uQrhNLbd0SNijAcKfH+zB3joO8hGYwfbRE1XsaxC6BWAProjBTS3HCWqlCsQ53Ut7lkb8y+A9mSn6Ppuwev47/773DYdUKFwRmxEumT1COH1LzCRIIT3U1/7hUZmo03Djd2AY1zyTbcOY1xlYaeo5qLZBuM7AoCBijaQ+1qLMeMRHVVESIc0A4GulgkZrUHQtahxuLCQ5+oNWR78xY1G+oNSwfuBFvX2/xvh731Wc45fH0yvZkWhl8kArMO1MA9XcNcT39NgS/3I3i0gExY+GHKcrMYx1eiwQat8HcvG6Dvt2X9bZAM/4OR6czSnhsLkOB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(31696002)(38100700002)(5660300002)(86362001)(4326008)(66946007)(66556008)(66476007)(8676002)(316002)(2906002)(41300700001)(8936002)(66574015)(2616005)(186003)(83380400001)(6666004)(6486002)(478600001)(6512007)(6506007)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRwZHFrc2loSkwwUzVVeVBDRENldDBoQ251UXI2UXhzNzNLN0FWMmgwMnhr?=
 =?utf-8?B?Y0xUUWZaNzV2bjNZcS9XeDVjN3FlREFLK3liVDlSZnExM0p2elZpYlRlSVdJ?=
 =?utf-8?B?ZVdXaTBrcEJJQWVxWStkVER6eHc0akl0T1FzMWI3U0xBQjBWZUlrZEdxN0gy?=
 =?utf-8?B?bWpvaHhTTXlnR3ltZzZIQmdrY0JMZkkxVTkxRm1jYzY2MmpyRS9ZYjdOR01r?=
 =?utf-8?B?R1VHOFBYSCtJWHR2TkdhdC9ZQk9SRGsrRmRGMnE2QWhtQWlKSVZGWTJxdmpR?=
 =?utf-8?B?Mk14R3J1N0hDWTZMWFN0N2JMVG9wM3ZYSWtUV1hNb2I3ejZRUHZrNjFkV0Vr?=
 =?utf-8?B?aUhoYWhMdG8yWlN1c0dHeDBiRzVKc1Bqc25GWC9tNERsK2xERTNYQVVHcVlX?=
 =?utf-8?B?b05CTnZlWnprVTNjZ2MxMVZacDMvOTBpQWFSSXl1dHpoOCtNR2ExUko0WmdC?=
 =?utf-8?B?WFpZNW9MS3JnSWJkOG1jaU9NZ0VPM2dzWEN6TzNIT0lNQ0lOZTZnRURtbEdD?=
 =?utf-8?B?eEpONnVLdGM1RDFtZGpzdHV3NXkycEJScmVsZmpsalNiZmtaMm42TW56V1JB?=
 =?utf-8?B?aTE1dzAvNW1GWUhwd3dYZXF5U2NsaWdhbUxIZy9oVWl5WUxSc3JEay9mdVRJ?=
 =?utf-8?B?dS9oWnZ4UnJUZmdXZFkyNlRoMWM3OFhkZnlUa0lEVTBuQ0JJVTNiZ1JwSEFO?=
 =?utf-8?B?UnVsL1lHWkZMdURLVmNmdTNZSGFvNDV2eG1LMTJ0ZStaU0grV2VHN3hJQnhN?=
 =?utf-8?B?K0FLTm5ibHRPUFlFMjVMbDhiZWNReUxidElIMmtIZXZ0QjRWQ3pRLzA2V1Fq?=
 =?utf-8?B?SHNSYjVPQVBLVXliU003Z01ZVlVGdEJQdnRBVnorZkRmc04wQ2lJUFpLV2Er?=
 =?utf-8?B?YUNPQ0FpVnkyR0U4RWNiOWY4TGloRVZJN0YzY0hld3g0UmtDR0NIYWwxaFVl?=
 =?utf-8?B?M3poM1hpNldBUWlMM0RNNGhUbnBaN2R0UWhOUWFUYWtPQUtCUTdzdW52MlFJ?=
 =?utf-8?B?TnhjUVhrcEN5cmNkbWtYL2F2QXk4UWFSNkdCMERDSkVwTkcwdFMvTTFmOGNX?=
 =?utf-8?B?a3NsbmluU0pvOWRTaDdjRGNHRFAzQytRYjRXaSsvV3cxdnVJU3dERXlSeTY1?=
 =?utf-8?B?MG1zMEdCRVpqQmNrNXFEcUJnWGU4WFZnWGxkbXlIeDBVRzV2Y01jMFY2TkxF?=
 =?utf-8?B?OW5UUXg3NWpySkZvSGNhOGROalJhZ2lxcWtWRVg3aDA1bGVJME13czI0SnV5?=
 =?utf-8?B?OHJhdUVyNHhzNENlMkdGU2dlenZQZEZaM2Rab1NPNmx0a2lyVWthYWVxcGtk?=
 =?utf-8?B?SnRxZ1o0UUVKYlZ0bk14dFJ3N0ZGbXpNNXNJS0I3VXpKb2ZPRVhJT2w2VjdO?=
 =?utf-8?B?b01sWU5tZFEvOEptcXBWTnlkRWJRTlZOc3hVaXJQZVpPVkRXU1RQWjZ3Y0x4?=
 =?utf-8?B?YVhseWNaNU9vSE1Oa2pmcURMOEdHdndRUW04a3g1TG5McEc1OUdZV0pVMXVL?=
 =?utf-8?B?amlVcXZ2aHNRRFo5MjlWM0RqbzBnRjd3K2dCZGtnNDUrRmpUV3A0cTN0Z3Z6?=
 =?utf-8?B?Zys2Mk16bzkxcWNJY3BickhScjUwSjBUNVdXbkhxUDJDQ0JPUld6WnJ1cmg0?=
 =?utf-8?B?SXpjQlIwZ1c0MXBWRGhyeGFycXN0eXRHUWtUWWFJYTdrUy81cVpFYmVXUXl0?=
 =?utf-8?B?Rlc3dHZ6TzJYaGd5SndBRXZDUDh5azBKNXZrWGJibHJ3di9KQ1pONW82Uldv?=
 =?utf-8?B?cTlmUWZkN1oxbzlDMjRXL1BwK1RoSUtWcVBCYzVaaUh6Zmt4ZVE4RDVpa1Vu?=
 =?utf-8?B?a1dTS1VaSTNYS0ppK2x2dVc5NTkrdVlLeWxuNmZDWDZCR1EySy9waFlHdWpL?=
 =?utf-8?B?NTVKalRFU0p4Slc1UUlKMnZFUko0L2lndVczS0tCZG5GY3lPdGFSSVZqSGpZ?=
 =?utf-8?B?N3hBZTV4KzJxbUpnOEdrUjJTd3N1YVlOeERGZHJ0Yy9lcU9oMFdMMHFSbVo0?=
 =?utf-8?B?dTFNdVdzbmcvZThKWjF0ZGtKenRXaW4zSUJLbmwxSktwcmd5VU1RbEdpY09l?=
 =?utf-8?B?S3FCZDZKOWpwdllTWXJ4b29DUW9mZFZnVTRTRGlvaTNqSTVOWjgvT3ViTitu?=
 =?utf-8?B?MWZmWGNJQ0dicEcxSU1KUzE1UUVDWnV0MXFZSFBpb090di9mTmZJUVVldWhB?=
 =?utf-8?Q?4ohAiSbv7GYnyrPA04ZdbK+a6FGHv8ZU3aTHgqdDLuEB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbcc78d-26f1-46d0-b0e6-08dab0fb6583
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:25:01.3693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a65gfJKoHyv6flcRBLg0DTjKFoXUJ1SEZfbo84vseKoUdwGYc0cwZ28ECMT+iRqy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.10.22 um 11:08 schrieb jiadong.zhu@amd.com:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Using the drm scheduler, the software rings' scheduling threads with different
> priorities have the same opportunity to get the spinlock and copy its packages
> into the real ring. Though preemption may happen for the low priority ring, it
> will catch up with the high priority ring by copying more data (the resubmit
> package and the current ibs) on the next calling of set_wptr. As a result, the
> priority is not quite effective.
>
> Here are some details to improve the priority of software rings at the bottom
> of drm scheduler by slowing down the low priority thread with following
> strategy.
> 1. If all the high priority fences are signaled which indicates gpu is idle
>     while there are low priority packages to submit, no delay happens.
> 2. When there are unsignaled fences on high priority rings, we account for the
>     portion of the ibs sent from the low priority ring. If the portion exceeds
>     a certain threshold(eg, 30%), a timeout wait happens on low priority
>     threads till more high priority ibs submitted.
> 3. The mechanism is started when the first time mcbp triggered, ended when all
>     the high priority fences are signaled.

This is a really big NAK for this approach since it will break GPU reset 
and can lead to deadlocks. You can't sleep in any of the callbacks 
waiting for the hardware to do something.

What we could do instead is to insert a dependency for the low priority 
ring. E.g. in amdgpu_job_dependency() return the latest high priority 
fence whenever a low priority job is about to be scheduled.

Regards,
Christian.

>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 93 ++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  3 +
>   2 files changed, 90 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index 41b057b9358e..eac89094f1d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -27,7 +27,13 @@
>   #include "amdgpu_ring.h"
>   #include "amdgpu.h"
>   
> +/* The jiffies fallback resubmission happens */
>   #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +
> +/* Maximum waiting jiffies on low priority ring thread */
> +#define AMDGPU_MUX_DELAY_JIFFIES_TIMEOUT (HZ / 10)
> +
> +/* The time threshold of unsignaled fence that trigger mcbp */
>   #define AMDGPU_MAX_LAST_UNSIGNALED_THRESHOLD_US 10000
>   
>   static const struct ring_info {
> @@ -47,6 +53,69 @@ static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ri
>   			&mux->ring_entry[ring->entry_index] : NULL;
>   }
>   
> +static uint32_t ring_priority_to_ratio_pct(unsigned int hw_prio)
> +{
> +	uint32_t ratio;
> +
> +	switch (hw_prio) {
> +	case AMDGPU_RING_PRIO_DEFAULT:
> +		ratio = 30;
> +		break;
> +	case AMDGPU_RING_PRIO_2:
> +		ratio = 100;
> +		break;
> +	default:
> +		ratio = 100;
> +	}
> +	return ratio;
> +}
> +
> +static void reset_wcnt_on_all_rings(struct amdgpu_ring_mux *mux)
> +{
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++)
> +		mux->ring_entry[i].w_cnt = 0;
> +}
> +
> +/**
> + * Decide if the low priority ring task should be delayed when there are high
> + * priority ibs ongoing. If all the high priority fences are signaled at that
> + * time, gpu is idle, we do not need to wait. Otherwise we calculate the
> + * percentage of portions copying ibs on the current ring and compare with the
> + * threshold according to the priority.
> + */
> +static bool proceed_on_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_ring *high_prio_ring;
> +	u64 current_cnt, total_cnt = 0;
> +	int i;
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entry[i].ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
> +			high_prio_ring = mux->ring_entry[i].ring;
> +			break;
> +		}
> +	}
> +
> +	/*All high priority fences signaled indicates gpu is idle.*/
> +	if (amdgpu_fence_count_emitted(high_prio_ring) == 0) {
> +		reset_wcnt_on_all_rings(mux);
> +		return true;
> +	}
> +
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entry[i].ring->hw_prio == ring->hw_prio)
> +			current_cnt = mux->ring_entry[i].w_cnt;
> +		total_cnt += mux->ring_entry[i].w_cnt;
> +	}
> +
> +	if (total_cnt == 0)
> +		return true;
> +
> +	return ring_priority_to_ratio_pct(ring->hw_prio) > current_cnt * 100 / total_cnt;
> +}
> +
>   /* copy packages on sw ring range[begin, end) */
>   static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>   						  struct amdgpu_ring *ring,
> @@ -73,6 +142,13 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>   	}
>   }
>   
> +/* delay low priotiry task depending on high priority rings fence signal condition*/
> +static void wait_on_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	wait_event_interruptible_timeout(mux->wait, proceed_on_ring(mux, ring),
> +					 AMDGPU_MUX_DELAY_JIFFIES_TIMEOUT);
> +}
> +
>   static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
>   {
>   	struct amdgpu_mux_entry *e = NULL;
> @@ -126,7 +202,6 @@ static void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
>   static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
>   {
>   	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
> -
>   	if (!spin_trylock(&mux->lock)) {
>   		amdgpu_ring_mux_schedule_resubmit(mux);
>   		DRM_ERROR("reschedule resubmit\n");
> @@ -158,6 +233,7 @@ int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>   	}
>   
>   	spin_lock_init(&mux->lock);
> +	init_waitqueue_head(&mux->wait);
>   	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
>   
>   	return 0;
> @@ -205,8 +281,10 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
>   {
>   	struct amdgpu_mux_entry *e;
>   
> -	spin_lock(&mux->lock);
> +	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && !proceed_on_ring(mux, ring))
> +		wait_on_ring(mux, ring);
>   
> +	spin_lock(&mux->lock);
>   	if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
>   		amdgpu_mux_resubmit_chunks(mux);
>   
> @@ -238,7 +316,12 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
>   	} else {
>   		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>   	}
> +
> +	e->w_cnt++;
>   	spin_unlock(&mux->lock);
> +
> +	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +		wake_up_interruptible(&mux->wait);
>   }
>   
>   u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> @@ -373,7 +456,9 @@ int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
>   	spin_lock(&mux->lock);
>   	mux->pending_trailing_fence_signaled = true;
>   	r = amdgpu_ring_preempt_ib(mux->real_ring);
> +	reset_wcnt_on_all_rings(mux);
>   	spin_unlock(&mux->lock);
> +
>   	return r;
>   }
>   
> @@ -408,10 +493,6 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
>   	struct amdgpu_mux_entry *e;
>   	struct amdgpu_mux_chunk *chunk;
>   
> -	spin_lock(&mux->lock);
> -	amdgpu_mux_resubmit_chunks(mux);
> -	spin_unlock(&mux->lock);
> -
>   	e = amdgpu_ring_mux_sw_entry(mux, ring);
>   	if (!e) {
>   		DRM_ERROR("cannot find entry!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> index aa758ebc86ae..a99647e33c9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -39,6 +39,7 @@ struct amdgpu_ring;
>    * @sw_rptr: the read pointer in software ring.
>    * @sw_wptr: the write pointer in software ring.
>    * @list: list head for amdgpu_mux_chunk
> + * @w_cnt: the write count of the current ring.
>    */
>   struct amdgpu_mux_entry {
>   	struct                  amdgpu_ring *ring;
> @@ -48,6 +49,7 @@ struct amdgpu_mux_entry {
>   	u64                     sw_rptr;
>   	u64                     sw_wptr;
>   	struct list_head        list;
> +	u64                     w_cnt;
>   };
>   
>   struct amdgpu_ring_mux {
> @@ -64,6 +66,7 @@ struct amdgpu_ring_mux {
>   	struct timer_list       resubmit_timer;
>   
>   	bool                    pending_trailing_fence_signaled;
> +	wait_queue_head_t       wait;
>   };
>   
>   /**

