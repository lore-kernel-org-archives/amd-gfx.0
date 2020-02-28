Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56899C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2848B246A3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 04:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jMHAJO+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2848B246A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C640F6E9A1;
	Fri, 28 Feb 2020 04:17:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD7A6E9A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 04:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N047VO7qpS/7I6iI9p86YdvdFndjZh0Au7S+tT1IS8nEx/ZFOuoWdMAzx5JH//Acw2Wjcpt3UO9pp3CxJl32dZ0lfOXgh2vra+RMR69dTJjuCLlFl+fy9A+jxEvnCps/LULAAzOrMvL+LnmdxA//JL0iZtCXc06XW83jtlsU+5VM+nXAZ8xc2NixGeiO/GdXTqlqf35vDYFu2iMekXfyMJ1geDs7no+HceoWwUlEPui1tAMFDo2fJQVz+YFRupYYHVyNti/v3vkdEmooblGY8a/UNRqMAM5WgxAQVBL6DWERcqiafOyb2Bor7EEu8i+SusgzSTdpP4n1jlCZEwa8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72FDDL+xZPHtsZnu3/PLiADTduc/5mhcFGS4DpAWaRc=;
 b=AAHvjbxM3i13ARxxFV6OcUmrjohyW4FzDqJZSBubU9n7peDdgi4wB86gnyG2TPdgqNyvCdhtHCyb9vh70PjDDoZESCp+U6Okzs90eoAupKizN6txuUMDyYDJ9IrS8+n6fvJLslGcwNzqZP9Rn2gVaufCSr44tagohiJpUtwQHiimng+CZmKblFlN90OuC9Qd0w1ynkY1nGJlGCL7edG5qzt/YcrCAlELLkStd39lPGU4KZV+vV2og7dHGDW/Y2fBO2kvJupHmRdBWBlBkcy6Cw21DlDD2o/rRNw1mRNsDJQtfIDL8xZKtRQ5lTpV7VFWlErLa4+aNHO/BSMc+FxtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72FDDL+xZPHtsZnu3/PLiADTduc/5mhcFGS4DpAWaRc=;
 b=jMHAJO+gqH0ciAyNF5p/lHFksRQK1bmj+FvHVOaoKNKoh8BlRvELCOrJNH6lN8RFNtJe59qbqZC0fbFyS1O2wyf9PcjJVs9igyG0vb1dTxi9S+pxK+6r/AYl6V3ZGyRZSxFrftiBvgezWLtCeQ/ImcQ0ItqidABHj3oK7obK77Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Fri, 28 Feb
 2020 04:17:07 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 04:17:07 +0000
Subject: Re: [RFC PATCH 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-3-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7f3c49cb-3d9d-ca2b-c4fa-0111d53a616d@amd.com>
Date: Thu, 27 Feb 2020 23:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200227214012.3383-3-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Fri, 28 Feb 2020 04:17:07 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91a1c34b-0b5e-4812-ca27-08d7bc0512e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3580:|DM6PR12MB3580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB358023CB6E9BDF87D07BDC9E99E80@DM6PR12MB3580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(44832011)(66476007)(2616005)(8676002)(16526019)(6486002)(36756003)(52116002)(956004)(186003)(26005)(31696002)(66556008)(316002)(66946007)(478600001)(31686004)(966005)(86362001)(6512007)(4326008)(81156014)(5660300002)(2906002)(81166006)(53546011)(6506007)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3580;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJWZRciSx8fKLA0CSSn3p2FJvfcXT6VOrzHkwZlWjgtH+wAHaUNP0PZdQ5fXlwh+NjJN+ch0YuZ0vUjQQVpdnd55HofAOWXnvutTSoUEiSKgVbpqgO7A0fwFwoebuKEiSiurI+Pp5myxyqlRRjw6GONnpeG86jSqnvZve6s7ivSfxQK1jOkfXc4ligE5fTecWbd/DPF89eiEiws/LakGye7je8m1teMK6eDWL9kjAuTzoXWxocL8ydoQ9eld8EPLC1uQ4chO8mzkVdJW2/oXhEe/ul5u2HdPM3af9yUZuhztJvBNcBOanjzGsiEyZbTLAGNZtbB7zq2RwcZOdQkmdoi0qalfp4g8hqzEuzjwoe//DWy9qgzRve3Vv4lPBxXPUbVhMFFUXS2remM7/LB2PYRDDK4ET+Shzy+5YDBk/8zZTN0Z0CAk5RPEtjYI9ST/Tjxp9cl/KGnxzQBDb9XJOoUWZCF/wejSzDCoxaVNmCu6cIZXe7Ienxgx5INV4Arf4MLh7xG3T5pWUYrYDzj3zw==
X-MS-Exchange-AntiSpam-MessageData: wQwkelmtT4k/BscMWpUOqG8FquSMwtTUnedM8aiQOfeHWCpzTAoDmMjb1hNuJXNwyfUa4NfdErL1JeYEEyxi/cDEdgXA3y2gPqv3Ch3tQPOBR7YcBewqpX3STdG9L6HliM5irVh91fLtRLDiUivnGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a1c34b-0b5e-4812-ca27-08d7bc0512e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 04:17:07.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW/lbGowrMgwQettx+nIOC5bqnWZHl2MGWA1xKfMyshE3Sdf/EAUCGB9xfPv8U46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
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

On 2020-02-27 4:40 p.m., Nirmoy Das wrote:
> Switch to appropriate sched list for an entity on priority override.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 54 ++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index a1742b1d4f9c..69a791430b25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -508,11 +508,53 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>  	return fence;
>  }
>  
> +static int amdgpu_ctx_change_sched(struct amdgpu_ctx *ctx,
> +				   struct amdgpu_ctx_entity *aentity,
> +				   int hw_ip, enum drm_sched_priority priority)
> +{
> +	struct amdgpu_device *adev = ctx->adev;
> +	struct drm_gpu_scheduler **scheds = NULL;
> +	unsigned num_scheds = 0;
> +
> +	switch (hw_ip) {
> +		case AMDGPU_HW_IP_COMPUTE:

NAK. Don't indent the "case".

LKCS says that "case" must not be indented:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#indentation

> +			if (priority > DRM_SCHED_PRIORITY_NORMAL &&
> +			    adev->gfx.num_compute_sched_high) {
> +				scheds = adev->gfx.compute_sched_high;
> +				num_scheds = adev->gfx.num_compute_sched_high;
> +			} else {
> +				scheds = adev->gfx.compute_sched;
> +				num_scheds = adev->gfx.num_compute_sched;
> +			}

I feel that this is a regression in that we're having an if-conditional
inside a switch-case. Could use just use maps to execute without
any branching?

Surely priority could be used as an index into a map of DRM_SCHED_PRIORITY_MAX
to find out which scheduler to use and the number thereof.

> +			break;
> +		default:
> +			return 0;
> +	}


> +
> +	return drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
> +}
> +
> +static int amdgpu_ctx_hw_priority_override(struct amdgpu_ctx *ctx,
> +					    const u32 hw_ip,
> +					    enum drm_sched_priority priority)
> +{
> +	int r = 0, i;
> +
> +	for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
> +		if (!ctx->entities[hw_ip][i])
> +			continue;
> +		r = amdgpu_ctx_change_sched(ctx, ctx->entities[hw_ip][i],
> +					    hw_ip, priority);
> +	}
> +
> +	return r;
> +}
> +
>  void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  				  enum drm_sched_priority priority)
>  {
>  	enum drm_sched_priority ctx_prio;
> -	unsigned i, j;
> +	unsigned r, i, j;
>  
>  	ctx->override_priority = priority;
>  
> @@ -521,11 +563,21 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  			struct drm_sched_entity *entity;
> +			struct amdgpu_ring *ring;
>  
>  			if (!ctx->entities[i][j])
>  				continue;
>  
>  			entity = &ctx->entities[i][j]->entity;
> +			ring = to_amdgpu_ring(entity->rq->sched);
> +
> +			if (ring->high_priority) {
> +				r = amdgpu_ctx_hw_priority_override(ctx, i,
> +								    ctx_prio);
> +				if (r)
> +					DRM_ERROR("Failed to override HW priority for %s",
> +						  ring->name);
> +			}

I can't see this an an improvement when we add branching inside a for-loop.
Perhaps if we remove if-conditionals and use indexing to eliminate
branching?

Regards,
Luben

>  			drm_sched_entity_set_priority(entity, ctx_prio);
>  		}
>  	}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
