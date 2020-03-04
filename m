Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93254C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9382073D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yw7EybQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9382073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70636E129;
	Wed,  4 Mar 2020 22:25:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57C16E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 22:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWsHlwOJkWAQOQ+StywPXqhaSbDbg6GAuYW7jDNQdsQMpv7BWMCs6uL8Rx0l+ePgAHU2j9ulg1Lyz+finx8x/t2TmoBTVnCha0i/MHcF2LmoZKyGUXTuDGMLOatAPTFzzvWJHs/gsZJ8cAswDjMYL3TWxNQTGnFJEDsc66mKuhgag/C96xj6/Qz7eMt+kpKEB8P+9WAaYzevDNVtgpKkZOdDseGgq18Sn7+G1zdNDyfl56CSlrpWx+D/1NUxeU2eMrZuv3E8N4veKoC+ZcDgo3svIIBfz42Kp0+sc56wgjDGhVAGqSSShJ7su9z566n2s8PAQNkoyzFZdLj+fKtzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CysCBt8lEGu8SA1SJGdJhpEPrdFo2VPnvsFGPEhR/CY=;
 b=MwJV/jS5e31rDv2VXwHDbAKEOhwzfQ6mz9AgzIvlEwEtBUn4Ff+MfhnKiBLoV+Vgz1MIvjeeabYdFLhxeqOubWLBX2iaNbflXCRjiZ/g9wotDPl9A38kCRWOBjX4v9XpGTJNa9bqXXr4dPrlFZh5kjC0MQe6N1wqJgW4tPK/akg2Z2p6LgL2SACs8N80gPWd84ZeYRiRowYRqSiqV2eORHhULYEVLyYKGrr9eIi09IAwolC6gvZuNb3oMeCtcoJ6yceFs5mt/PY6lbk7KxUJZnuWu3LqheenB6kz/1zDaRGpwcBA8qmtsE/wqOU7A1eZfw6Urp3zJwNlQESrJ7AByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CysCBt8lEGu8SA1SJGdJhpEPrdFo2VPnvsFGPEhR/CY=;
 b=Yw7EybQ16aQeDG3m+2uo2XRO7o2D13DFO4GPeBReMMSWye7a9CV6VMZ0/9wvSrjxpkDNIW5TiEodZsA4rWP3P/TboCrxqJD4F1iCPd4holbN/Ckn1qsp2+rJVO4t0su3E0ujPvXErE9PHFd1o2DjZeQGaka9P5ywFKeRaz8xm+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3034.namprd12.prod.outlook.com (2603:10b6:5:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 22:25:14 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 22:25:14 +0000
Subject: Re: [PATCH v4 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-3-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <64d19cfe-452c-fa85-3f3c-1953e3c800b0@amd.com>
Date: Wed, 4 Mar 2020 17:25:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200303125039.53141-3-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 22:25:14 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4cfb312-1994-492e-9994-08d7c08ae8f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3034:|DM6PR12MB3034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB303469BDBC833FD7B6108F7599E50@DM6PR12MB3034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(81166006)(6486002)(6512007)(31696002)(66476007)(81156014)(66556008)(66946007)(53546011)(6506007)(5660300002)(8676002)(31686004)(86362001)(316002)(8936002)(186003)(26005)(16526019)(956004)(2616005)(44832011)(478600001)(966005)(52116002)(2906002)(36756003)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3034;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l3N3i1FRd/2zYfyNXyBLYzypj0hrazTw/p7TAadCxs/hPtuXp30o5y0I1S8pJIGnt0Ex4CD/8UJC5p1fjFrm8JfIGkOXwhO0OB/mvKtFunidreJVH7gHmnz/pr/NFA5xnoLtuXoxLJ/Dn0aGQsHgU4pIu/tX6/zVW2LOc1d6tg2ZlQwJFHKzcIy/qGu567gj6aj2ooUoSY5a3VKc0iyDB0/13w35iYYHnjfhEfCm/IgwWC6VB83YLtgfQTl3NQZAKynxGQX3b6QWa294G715paaRoj6S4+Bihcbdpzd9ByAiyVHc+oEJ6WgzcRChYgr3DJuezAfg1Dc+A9WCrUGc6nyECVfP8kGTaaNGJnDI0zHhVtBfYvszU+XI0Xu8quO6jUrY6es1p7svV3fqfi27y2yFb3jZOZbM6n9mYfq4GC89Qdmwe+HnIrRUH1lp9DtS1qJP2I2L1ZIsQfR/I/9wiDNd+hWmZzTR9rVUiLtVVs=
X-MS-Exchange-AntiSpam-MessageData: 8EYWeJc8+L/7JIMOIp8xpbalc07BsgDLs2I6cf3IsSl/gA6ZLM0x9JI4axBVLhRUSZl1HrJP8ShsW3RdQu3DLegpVlRJkTlMoVhiDP62mJ3ceGwort11iDdBF6IX04e1Myv2YlFYerBG9R7tx4mCWw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cfb312-1994-492e-9994-08d7c08ae8f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 22:25:14.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg6q65WpbuJ2haZDXiF0Sk6Lt4EjoiWZr7kQWeS8n0HFXyoirpPSpKtamZuJQWH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
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
> Switch to appropriate sched list for an entity on priority override.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 8c52152e3a6e..a0bf14ab9d33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -522,6 +522,32 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>  	return fence;
>  }
> 
> +static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> +				   struct amdgpu_ctx_entity *aentity,
> +				   int hw_ip, enum drm_sched_priority priority)
> +{
> +	struct amdgpu_device *adev = ctx->adev;
> +	enum gfx_pipe_priority hw_prio;
> +	struct drm_gpu_scheduler **scheds = NULL;
> +	unsigned num_scheds;
> +
> +	/* set sw priority */
> +	drm_sched_entity_set_priority(&aentity->entity, priority);
> +
> +	/* set hw priority */
> +	switch (hw_ip) {
> +	case AMDGPU_HW_IP_COMPUTE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> +		scheds = adev->gfx.compute_prio_sched[hw_prio];
> +		num_scheds = adev->gfx.num_compute_sched[hw_prio];
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
> +}

I'd rather this not be over-engineered (in expectations of more case labels,
and a simple if-else to do it. Over-engineering it "just in case" creates
difficult to maintain code. I believe there is a document about this somewhere
in Documentation/.

You don't need a break only to execute one statement, which you can pull
into the case: label. If you did this you'll see that you just want to do:

static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
					   struct amdgpu_ctx_entity *aentity,
					   int hw_ip, enum drm_sched_priority priority)
{

	...

	/* Set software priority.
	 */
	drm_sched_entity_set_priority(&aentity->entity, priority);

	/* Set hardware priority.
	 */
	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
		hw_prio = s2p_prio_map(priority - 2);  ## or perhaps from a static inline from a header file, so we wouldn't care for the - 2 here
		scheds = adev->gfx.compute_prio_sched[hw_prio];
		num_scheds = adev->gfx.num_compute_sched[hw_prio];
		drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
	}
}

Regards,
Luben

> +
>  void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  				  enum drm_sched_priority priority)
>  {
> @@ -534,13 +560,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>  			ctx->init_priority : ctx->override_priority;
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			struct drm_sched_entity *entity;
> -
>  			if (!ctx->entities[i][j])
>  				continue;
> 
> -			entity = &ctx->entities[i][j]->entity;
> -			drm_sched_entity_set_priority(entity, ctx_prio);
> +			amdgpu_ctx_set_entity_priority(ctx, ctx->entities[i][j],
> +						       i, ctx_prio);
>  		}
>  	}
>  }
> --
> 2.25.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cf436ca206d94469f4ed908d7bf710856%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637188364522588061&amp;sdata=kPMrGVCt00XTJVIG5lDFugkv5CxZne8W1Hqqc2baZZg%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
