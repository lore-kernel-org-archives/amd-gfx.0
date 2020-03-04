Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BEC3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636A720838
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xUL/3O0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636A720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2CD6E0FE;
	Wed,  4 Mar 2020 21:41:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90D46E0FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 21:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4t3DEyTJSBpbTw0mKaKzBuPIMvgRjcxi5CmbPRkpuVyIVfuc1Qxf9D0HrUaYQfAaW6Vjpe98ATzuVekMaqLeRmBjXVf+BIEPWPG4Fgz0Mg4yxRsHalvnQCKFtJR7QX1OEVgDXi3viNGb7o1WRX7jw8RsAuETynJZqFBD/DoLn1QBpKRu2wyQHw7+imbB3cUrgBNheVFtHJcyhDDc5PPkcrP6TmY3W+mJFnB6Sk3Sw2JoUK0YsytQEpajRY0UCvzwe/Nmafd0jAeEC9xlREN9cDGA2hyXUsw5sdt0P4WM29Drzl9anOhCUE2vdMrXWu1Uvrx3uWs4mGdVKfmjjKQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pFYMIFZHND6Zf1ZaeMG1kgmRA96MW2K6GBCJTFds3g=;
 b=Q7W+fNeGWXYtoWsowmxBjnQVlysvPAIevBldGBHkDoOov14iFjczwKvIxF4J7LgtmQt3rZdjT454yIjnV9/VmaHBSkPtK6XYkY3nenIYb/+50sPD61troCvid8NL9MtORvgZIm2V+SpB7DAXcO3cz43UOEOvQc3QeIv8NjvKm47lGxZonPQCUgpNizFs/CiabHlBRfdRc90cP0EhMIX9+jX5BDnCjjc8NH8UNPCJ0suyxTe5ZHxh1W8l1V0XegLNW/ZZ3p3r2W4hECHa1j60ifdOhYFVTP1qknJkc9g6xDgtHYpMto3RlDRtJmYxZK3h9O7hideHqrskNTfALkUcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pFYMIFZHND6Zf1ZaeMG1kgmRA96MW2K6GBCJTFds3g=;
 b=xUL/3O0oRJSLkCy+eCO0/cFqiRhq69mwM+sgRDva6grffzbq/vpUi0D2OsKiIO0EidfIYrtfc+WHDhpUuEE1xeb9T9koGnfk/Mkp9RM9YaAL1jiiT/NK+3IqKnk8exFFSnNZzvRVNJr2Hy8RgCa7vZ0znXzcFOs9+bgRrbRCebw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 4 Mar
 2020 21:41:46 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 21:41:46 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2085216f-f82c-3d2e-8f91-b05c2cf76a50@amd.com>
Date: Wed, 4 Mar 2020 16:41:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200303125039.53141-1-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Wed, 4 Mar 2020 21:41:45 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d07d01dd-f1e7-4395-7f62-08d7c084d60c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4187:|DM6PR12MB4187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41871208EEF3A8DA6482C97D99E50@DM6PR12MB4187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(186003)(966005)(316002)(86362001)(478600001)(16526019)(8936002)(4326008)(26005)(956004)(52116002)(6512007)(31686004)(45080400002)(44832011)(2616005)(6506007)(6486002)(36756003)(53546011)(8676002)(2906002)(31696002)(66556008)(30864003)(5660300002)(81156014)(66946007)(66476007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4187;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nePUjQMJGr/SOpga+5IzPN+RuFvNiWbFrFTvEoETpjuo6uPE0spLwZo0gDDGo548/rGvbEJMKHlfV3MR08xifZrwMuLva7cfmyDmaSrER+Ul8CaFggZtPeC/TLDlB4faTtyzdxTM8v9lczBB0c1Gh76oEJZuU3F5DLva2KYDuvNT7yivJk4/1dT2mGHpPdaDwb1b8mDZFXQybk23LgTlZSqIqu3PD80I2C76vYrIzi6DNjeR0HamPYZLAzAqgmydbWRYIE8nv+5Tdn3MfeB4N0n/ZG1KME2aSrMNrAfxVF6vaSBm2pbY5efQrBPAalILTO9CTgE9ar6Ekbojsa9UYFV2+CgfT/56lDB4wEH4d1xSA6ka35O9dAcvxoS37efZczccB544qYL4G1KMAuOrHc6MXQQGYaZDqrsuJvwLg4SmeRfb0zvBUthK/pNb9RVavYhTXgudM849iu08IFYGw933N42SRBpgP4mhsIOF6IR7lNGBS9OjOFfJhEilU3lst20n7iwR4iWxCD8uZpWGdA==
X-MS-Exchange-AntiSpam-MessageData: k/VykdQMFdSthH+mgh7UUl9Q0c8O4LQy+T05lYSfBoC725E3rSnGM1iDSQ0qx8/GMqJbU3/YXLlIL1cHwKXyAcGsfgQxMLTlTLDuFhgcWzZcF4PS4ORn2376K2KSkDWVO69Ke5F0v9yi442vQ9zaKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07d01dd-f1e7-4395-7f62-08d7c084d60c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 21:41:45.9271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CokThOycKTKT87aoOX5kEcNPYTX0CnlOzkwvC5YRzXXqcZ6sM1s8McBV75W5vEyB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-03 7:50 a.m., Nirmoy Das wrote:
> We were changing compute ring priority while rings were being used
> before every job submission which is not recommended. This patch
> sets compute queue priority at mqd initialization for gfx8, gfx9 and
> gfx10.
> 
> Policy: make queue 0 of each pipe as high priority compute queue
> 
> High/normal priority compute sched lists are generated from set of high/normal
> priority compute queues. At context creation, entity of compute queue
> get a sched list from high or normal priority depending on ctx->priority
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 60 +++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  8 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 15 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 19 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 23 +++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++++
>  9 files changed, 135 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f397ff97b4e4..8304d0c87899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>  	struct drm_sched_entity *entity = p->entity;
>  	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>  	struct amdgpu_bo_list_entry *e;
>  	struct amdgpu_job *job;
>  	uint64_t seq;
> @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	priority = job->base.s_priority;
>  	drm_sched_entity_push_job(&job->base, entity);
> 
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>  	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> 
>  	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 94a6c42f29ea..4ad944f85672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -61,12 +61,30 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>  	return -EACCES;
>  }
> 
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
> +{
> +	switch(prio) {

LKCS wants a space after a keyword ("switch") and before parenthesis "(".
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-braces-and-spaces

Please read the LKCS in you local Linux source code:
Documentation/process/coding-style.rst
so we don't have to point that out anymore.

> +	case DRM_SCHED_PRIORITY_MIN:
> +	case DRM_SCHED_PRIORITY_NORMAL:
> +	case DRM_SCHED_PRIORITY_HIGH_SW:
> +		return AMDGPU_GFX_PIPE_PRIO_NORMAL;

This is taken care of by the "default:" label and
unnecessary here (can be removed completely).

> +	case DRM_SCHED_PRIORITY_HIGH_HW:
> +	case DRM_SCHED_PRIORITY_KERNEL:
> +		return AMDGPU_GFX_PIPE_PRIO_HIGH;
> +	default:
> +		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
> +	}

This can be a map. We're mapping from one integer
space to another. There is no reason for a jump switch.

For instance,

/* Map of the DRM scheduling priority to pipe
 * priority.
 */
const enum gfx_pipe_priority s2p_prio_map[] = {
	[0] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[1] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[2] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[3] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[4] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[5] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
	[6] = AMDGPU_GFX_PIPE_PRIO_HIGH,
	[7] = AMDGPU_GFX_PIPE_PRIO_HIGH,
	[8] = AMDGPU_GFX_PIPE_PRIO_NORMAL,
};

/* Map it!
 */
pipe_prio = s2p_prio_map[sched_prio + 2];   ## You can view this as y = f(x + 2).

Note that if you fix enum drm_sched_priority as I described
in an earlier review, you'd not need the additive factor of 2
in the above linear transformation.

> +
> +	return AMDGPU_GFX_PIPE_PRIO_NORMAL;

You don't need a return here at all, when you have a "default:" label
up there.

> +}
> +
>  static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
>  {
>  	struct amdgpu_device *adev = ctx->adev;
>  	struct amdgpu_ctx_entity *entity;
>  	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>  	unsigned num_scheds = 0;
> +	enum gfx_pipe_priority hw_prio;
>  	enum drm_sched_priority priority;
>  	int r;
> 
> @@ -85,8 +103,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>  			num_scheds = 1;
>  			break;
>  		case AMDGPU_HW_IP_COMPUTE:
> -			scheds = adev->gfx.compute_sched;
> -			num_scheds = adev->gfx.num_compute_sched;
> +			hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> +			scheds = adev->gfx.compute_prio_sched[hw_prio];
> +			num_scheds = adev->gfx.num_compute_sched[hw_prio];
>  			break;
>  		case AMDGPU_HW_IP_DMA:
>  			scheds = adev->sdma.sdma_sched;
> @@ -628,20 +647,47 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  	mutex_destroy(&mgr->lock);
>  }
> 
> +
> +static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
> +{
> +	int num_compute_sched_normal = 0;
> +	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
> +	int i;
> +
> +	/* fill compute_sched array as: start from 0th index for normal priority scheds and
> +	 * start from (last_index - num_compute_sched_normal) for high priority
> +	 * scheds */

See the LKCS guide here on comments.
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

To quote from Documentation/process/coding-style.rst:

  "NEVER
   try to explain HOW your code works in a comment: it's much better to
   write the code so that the **working** is obvious, and it's a waste of
   time to explain badly written code.

   Generally, you want your comments to tell WHAT your code does, not HOW."

Please comment on why and what you're doing as opposed to how.
Or if you don't want to do this, simply remove the comment.

Remember, you want to make it clear why and what the code does here,
as opposed to how it's doing it.

Use this style of commenting, like Christian does:

previous code ends here;

/* Comment line 1.
 * Comment line 2.
 */
code starts here--no extra empty lines...

> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		if (!adev->gfx.compute_ring[i].has_high_prio)
> +			adev->gfx.compute_sched[num_compute_sched_normal++] =
> +				&adev->gfx.compute_ring[i].sched;
> +		else
> +			adev->gfx.compute_sched[num_compute_sched_high--] =
> +				&adev->gfx.compute_ring[i].sched;
> +	}
> +
> +	/* compute ring only has two priority for now */
> +	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> +	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +
> +	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +	adev->gfx.compute_prio_sched[i] =
> +		&adev->gfx.compute_sched[num_compute_sched_high - 1];
> +	adev->gfx.num_compute_sched[i] =
> +		adev->gfx.num_compute_rings - num_compute_sched_normal;
> +}
> +
>  void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>  {
>  	int i, j;
> 
> +	amdgpu_ctx_init_compute_sched(adev);
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>  		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
>  		adev->gfx.num_gfx_sched++;
>  	}
> 
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
> -		adev->gfx.num_compute_sched++;
> -	}
> -
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
>  		adev->sdma.num_sdma_sched++;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7403588684b3..952725e7243c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -192,6 +192,14 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>  	return adev->gfx.mec.num_mec > 1;
>  }
> 
> +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> +					       int queue)
> +{
> +	/* Policy: make queue 0 of each pipe as high priority compute queue */
> +	return (queue == 0);
> +
> +}
> +
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>  {
>  	int i, queue, pipe, mec;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 37ba05b63b2a..47a5cdae28c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -41,6 +41,16 @@
>  #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
>  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
> 
> +enum gfx_pipe_priority {
> +	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
> +	AMDGPU_GFX_PIPE_PRIO_HIGH,
> +	AMDGPU_GFX_PIPE_PRIO_MAX

Please don't call it "MAX". "Maximum value" means
that that value is in the domain of values
the priory can take, and it is not. That is,
priority could never be AMDGPU_GFX_PIPE_PRIO_MAX.

If you want to know the size of the domain of values,
just call it that:
AMDGPU_GFX_PIPE_PRIO_NUM/_SIZE.

enum gfx_pipe_priority {
	AMDGPU_GFX_PIPE_PRIO_UNDEFINED,
	AMDGPU_GFX_PIPE_PRIO_NORMAL,
	AMDGPU_GFX_PIPE_PRIO_HIGH,

	AMDGPU_GFX_PIPE_PRIO_SIZE,
};

Naturally 0 would be undefined, yet named.
Note the empty line before the size.

Regards,
Luben

> +
> +};
> +
> +#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> +#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> +
>  struct amdgpu_mec {
>  	struct amdgpu_bo	*hpd_eop_obj;
>  	u64			hpd_eop_gpu_addr;
> @@ -280,8 +290,9 @@ struct amdgpu_gfx {
>  	uint32_t			num_gfx_sched;
>  	unsigned			num_gfx_rings;
>  	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> +	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>  	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> -	uint32_t			num_compute_sched;
> +	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>  	unsigned			num_compute_rings;
>  	struct amdgpu_irq_src		eop_irq;
>  	struct amdgpu_irq_src		priv_reg_irq;
> @@ -363,6 +374,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
>  				 int *mec, int *pipe, int *queue);
>  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
>  				     int pipe, int queue);
> +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> +					       int queue);
>  int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
>  			       int pipe, int queue);
>  void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d42be880a236..4981e443a884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
> 
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> 
>  	drm_sched_job_cleanup(s_job);
> 
> -	amdgpu_ring_priority_put(ring, s_job->s_priority);
>  	dma_fence_put(job->fence);
>  	amdgpu_sync_free(&job->sync);
>  	amdgpu_sync_free(&job->sched_sync);
> @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>  		      void *owner, struct dma_fence **f)
>  {
>  	enum drm_sched_priority priority;
> -	struct amdgpu_ring *ring;
>  	int r;
> 
>  	if (!f)
> @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>  	priority = job->base.s_priority;
>  	drm_sched_entity_push_job(&job->base, entity);
> 
> -	ring = to_amdgpu_ring(entity->rq->sched);
> -	amdgpu_ring_priority_get(ring, priority);
> -
>  	return 0;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff085d00..dcea1ef92883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -222,6 +222,7 @@ struct amdgpu_ring {
>  	struct mutex		priority_mutex;
>  	/* protected by priority_mutex */
>  	int			priority;
> +	bool			has_high_prio;
> 
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *ent;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 96cf617e41d1..c1da41e35323 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3211,6 +3211,22 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
>  	return r;
>  }
> 
> +static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct v10_compute_mqd *mqd)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +			ring->has_high_prio = true;
> +			mqd->cp_hqd_queue_priority =
> +				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +		} else {
> +			ring->has_high_prio = false;
> +		}
> +	}
> +}
> +
>  static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -3336,6 +3352,9 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>  	mqd->cp_hqd_ib_control = tmp;
> 
> +	/* set static priority for a compute queue/ring */
> +	gfx_v10_0_compute_mqd_set_priority(ring, mqd);
> +
>  	/* map_queues packet doesn't need activate the queue,
>  	 * so only kiq need set this field.
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 393a1324daa9..668c8eb2b2cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4430,6 +4430,22 @@ static int gfx_v8_0_deactivate_hqd(struct amdgpu_device *adev, u32 req)
>  	return r;
>  }
> 
> +static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *mqd)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +			ring->has_high_prio = true;
> +			mqd->cp_hqd_queue_priority =
> +				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +		} else {
> +			ring->has_high_prio = false;
> +		}
> +	}
> +}
> +
>  static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -4553,9 +4569,6 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  	/* defaults */
>  	mqd->cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
>  	mqd->cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
> -	mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
> -	mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
> -	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
>  	mqd->cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
>  	mqd->cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
>  	mqd->cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
> @@ -4567,6 +4580,10 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  	mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
>  	mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
> 
> +	/* set static priority for a queue/ring */
> +	gfx_v8_0_mqd_set_priority(ring, mqd);
> +	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +
>  	/* map_queues packet doesn't need activate the queue,
>  	 * so only kiq need set this field.
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 015647959d69..726d1ac41637 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3314,6 +3314,22 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
>  	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
>  }
> 
> +static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +			ring->has_high_prio = true;
> +			mqd->cp_hqd_queue_priority =
> +				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +		} else {
> +			ring->has_high_prio = false;
> +		}
> +	}
> +}
> +
>  static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> @@ -3450,6 +3466,10 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>  	mqd->cp_hqd_ib_control = tmp;
> 
> +	/* set static priority for a queue/ring */
> +	gfx_v9_0_mqd_set_priority(ring, mqd);
> +	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +
>  	/* map_queues packet doesn't need activate the queue,
>  	 * so only kiq need set this field.
>  	 */
> --
> 2.25.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cfa70ffa2d9874bbe1a5908d7bf71077e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637188364502419515&amp;sdata=vIM2clFPPCfIDK24UxAiJDZ5JH%2F83K2JESZtZKTGQUc%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
