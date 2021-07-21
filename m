Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4850DC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 15:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE3D60725
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 15:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE3D60725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12916ECB6;
	Wed, 21 Jul 2021 15:50:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0C46ECB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 15:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtLvDAXkIPCJA+qWznLMZ8SiuVRRE3dWtqes+F+1qXDyF6X3noKW3w27EHKxgDHfPA7wWU0DLNz7KWzaILogqVpPlHpdWSM0Y3YfL+CXEEV63pLLgPjYbc9RvVs+k0zTaujhBV0793Bzz/Z817Wmxy6bcqHJJ8j2Rm2AfyIWsD4idqg8vxssIuxXAR4unRPZO3AiKEzmSTja8tIMjDctBNLf2h01J2J2MQ1ZnzpG4bFK5SwN/E0O2uTaTV4NByDDbVXoCN1oqqI1e/4wU/hRaviiImgoHEYQzdmGLmnBJCWKlDd8imH8Xa1XtHIKIndRoGsODgt6waraQF8MTPqWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H08bPV0wBCfjrlsZzQJgGdGqZHtPOVr698weWOqYGs=;
 b=ZHKrGzNLgsNKlBCloVHKJJ2PbfntTeYL6dbGcLOhlulVrEYyccYVkx3opjd/pNVXft6EepKJqDxjORX1h/GeDqwoQiWiYCNA1SqvWwvqJLjqt3WUGZkBuyLiJboeM2brS9EB2qGIa4auHm9H+s4uMl7WJJDV7RzLl15ocMyvKvWqoOPOaoiBp1w4FyPaqCBISDTCnhMBeam6XbLqKy84wi3KGrpSpZtafj6ByS3NeU8ROzkYf7Jf+vrnV3djeRG64I7xNVGBI+uINZ0ZYHIzT8j5VpxxaTlny0+WSqRsVfGg575akxAiUw2iVXcB5quQB3hcmkflX7/U1WQgd7Vtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H08bPV0wBCfjrlsZzQJgGdGqZHtPOVr698weWOqYGs=;
 b=1Wfq9uzH4A3z5gi1VFF4HhwxLxyXWE6FcKLLp1vPpTr3ZOiSNmXPLC7H4WWeGJCzIPBv8K013KyV94KBfGOECXAY+/rOixccT1wsg3oRR+3JSnTWvrCSzRjN6LWA0UFG0MvST+bROdHm5PDtcLrlLkq29rZB+iuFcF9ZM/XB8/U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 15:50:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 15:50:11 +0000
Subject: Re: [PATCH] drm/amdgpu: Clear doorbell interrupt status for Sienna
 Cichlid
To: Chengzhe Liu <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721030211.1611320-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8e0d4b55-5b17-a076-78a7-da959c7c8bee@amd.com>
Date: Wed, 21 Jul 2021 11:50:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210721030211.1611320-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: QB1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::16) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 QB1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 15:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46747c6-9af6-4745-3ac8-08d94c5f3946
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02191944299FF5513133296199E39@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3lIVwbuZgyhPqZequHw6akG1XRg6IKM6JfCowvsODOzGVYMih/HYI4t8yrb6hC7zbhfJzCEmHpS0lZVrdrNazkIBBIRi1RZ7jkwDUle2Sl6w/YDJQVWgn69L81MChIQjmtHqiCOW/gcmhdQvnv8+CHLPAB56xFB6mOMCqmSx/6Ht+xU0ccJtSkrwHcbxzmzWH+6xo2QoaTNvE8hJ0n2zLxV86Ubdh8TrdkkOW//zXtmcWBWMk/gJB0D2ZSjH/+/xepSb8VfZR46AEnkesYsklMJKLsHw5jCFSG801n6RBQLjcJQjM8qvx3IKN5+l5FQ2eHE8WNoQdVRsc7OrrRuMWtw5HDAxcPp7Ce3q7FU8bh3PZfzgCr2YTvbS5fcPfYmWyChjVhO2/1LTPlXSpX4yw7rlEDWoASOKmjcyblykGQPznVYeH5LHqB6MgOZCHsesrJt11afI2D0q0Kih9uDHuflAXF9Orva8Gmyhng0G7CLW8Oph5ZPeYlVCk1wxgaPYn6sTgcQK+RQAc6TEkGDRlRxGFvlFOvnqyFnbjH0vcedEvUDxeTqXnj2xWE9G8hW0kUAkE1YxfhlhFmI8Sp2FWYSnU04RJeKdkfdkT8JLy8pCFtnmZD8YmkM/cueo+0g6LUKopTMhUApJLa7GFgAHlqj6xGtTt0GVnPnA/2M4WHN5LD5/vyGGCaj8V2HPCVBE6aFF0OV0OOnYUtpVcyj2RYkw5/cy9v2/Q3775YzZGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(26005)(66556008)(66476007)(66946007)(8676002)(86362001)(316002)(478600001)(54906003)(83380400001)(8936002)(31696002)(36756003)(2906002)(2616005)(5660300002)(31686004)(6486002)(44832011)(38100700002)(186003)(6512007)(55236004)(53546011)(6506007)(956004)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZXMnU4NUQ3S3ZQQTNGaGlZQkZ4N1VURUF4TkE3U2dYUlFXZ1BPUTFkQ0lO?=
 =?utf-8?B?U0ZlQ2JxQ3ZocXpmRDZnalJZMUpLLy9jNDNWTWR6cDNOMFppK25RaGxpVFdj?=
 =?utf-8?B?QXhaeTZzMlhJZTlTY3dpQXJxdEozQ1Z0VmlTRDNnNmhFUTJkV2VianpHaUpL?=
 =?utf-8?B?dmo0bE9USG5tUzhveC9uNENsK29Oc0xEakVKV0d6Snh2cGlLMWVjZGx0eEhq?=
 =?utf-8?B?QktHb09vcXNwbTBBOWw0TlFYbWNkMW5rNmdsRFZUWXpGYkF2ZXlVS2RaKytm?=
 =?utf-8?B?T0JQS2k1aEJTbUtFd1Uyc2h3YjgzZzBJaE5uY1JIVUFsdEdSQ3hyYjU4MUda?=
 =?utf-8?B?L2xQdVc5dTFqZUNzUi9FZStta01UTGpvM0F2RUdQRmxrQWZUZWxIVTI4cnJy?=
 =?utf-8?B?OFE3QUdHdmF1MnRzcGhsODdaY0lpRXNJTGZIczZoQkZ2aDdrU3d2OFU1c1VT?=
 =?utf-8?B?WS91b081U3FMMXlaeStSUGp6MUdDSlZkUVRDYWlKMnBvQUlYaE1pL3I3WW01?=
 =?utf-8?B?clBrRHd0bHRqdDNDL2twTko2MkNTLzJhejBBR09qRTkrblRkU1V1Z0Rwb3Ny?=
 =?utf-8?B?eHk4VEtCYVkvUlpkTTVJYnZmaVRRQ3MxODZXVGVmUktLV2lnL0k5UlZPcFR1?=
 =?utf-8?B?Zk1RbzJidVYxVG9hTDVyWHIzamtwMTNWZG9FK2ltRVJWNGdPMEk1eDZwd1h1?=
 =?utf-8?B?K2J3UG4zb3hXVklndG96VmVueHlTeGpkTGo2V2dUSjA2V3B2cXJtSjlNa0Js?=
 =?utf-8?B?NDc0d01sd0phYXlsYkMxMVFydXdhck40eVB0M0JSWE9BTWVNZzUzc0FqUWYw?=
 =?utf-8?B?RzV1NG1ndEZHZUM0ZDY5ZEJWVnRNZWM2QUFnRVgzOFhPeFBJdklZMHZvUkhx?=
 =?utf-8?B?emg4MHpSam1ZM1NRZ3JxbmtEc0N3OXhKaUhKVW9GbXdkR0VtZ0RQUlNFaDMw?=
 =?utf-8?B?NVg0QmpCcHJEQzFMSm03czZFell4MTl2aVZId0tRWDV6WXl1V1FkRkxUQjg1?=
 =?utf-8?B?cHhlMkhBQ040Rzlqd0tzamxiSnlvSGhKVnhRVE9waDhvb3NMdEZDcmYzM2dT?=
 =?utf-8?B?bHo5aU9kUEVpdFZGR1dobkVHQ2dwWThOZ0o3RWhVVm43TkZzQzRrQ0d0ZG50?=
 =?utf-8?B?bDBRKzlIcE1VdktpN3ovc0h5NFBYTlo1OHhRWDY5K2liWGp4TWJPZEl4WXM0?=
 =?utf-8?B?VTZLa25kZUVGdyszNDBRTFJkOFBKb2QrenpOcVlJSUl4cmdiUERSY25sWStL?=
 =?utf-8?B?MENhQllrL3Z0blhlTk5INXJMSk1JWkdDVTVsWC9MWTB0ejFCWEtOYjVkUUQ4?=
 =?utf-8?B?NlRQcmJaNmNNd0ZOSEVRMGs3dnRLS3E2ZFFxaDdkYnBTTG5CeTYrWEthdUdT?=
 =?utf-8?B?VkVGaVoydlE2TTBZclV6bkJqSjhCMHVkYWxlZWpzZHZwcEpsZWE3Q00yUUQr?=
 =?utf-8?B?MUM3WTk2VnEvSXZUOENDNCs3OTlYNkFVam1saHpQalNyZGJLTkdnSTNXYVI0?=
 =?utf-8?B?eExveTFtZExibnN5NU9CaXlZVm9LcjZTczNCcGVaa2dldXRQNzBLMlFTQlEr?=
 =?utf-8?B?NmFCejdJUGRXaXZuZzRsQVEyZFhYRmdhTVJpYkZ2M25URk9tYUY0RVhZd05X?=
 =?utf-8?B?SVBBQWJVelFZbXRlRDRMRGJpZVJRMlZKTGYzcWFpeU5CRTlycDNGZTlNQ204?=
 =?utf-8?B?RUYyNElVN3ZNVDNubUVsbDVDcE9MLzZZL2piTGFyMG5POGoyRkRvdUJzai92?=
 =?utf-8?Q?egxtCbnyvjn3yyosLg66MKgqRGnILGUGkJE6Cke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46747c6-9af6-4745-3ac8-08d94c5f3946
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 15:50:11.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfQ7LbSDUur0p6oLOI8fFGEG/rCV85R3qp2SlqL+VBQBMvz9vhgmX1aabdzTtT+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, looks good.

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

On 2021-07-20 11:02 p.m., Chengzhe Liu wrote:
> On Sienna Cichlid, in pass-through mode, if we unload the driver in BACO
> mode(RTPM), then the kernel would receive thousands of interrupts.
> That's because there is doorbell monitor interrupt on BIF, so KVM keeps
> injecting interrupts to the guest VM. So we should clear the doorbell
> interrupt status after BACO exit.
>
> v2: Modify coding style and commit message
>
> Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 21 +++++++++++++++++++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 37fa199be8b3..92f73d2bbfc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5265,6 +5265,10 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>  	    adev->nbio.funcs->enable_doorbell_interrupt)
>  		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
>  
> +	if (amdgpu_passthrough(adev) &&
> +	    adev->nbio.funcs->clear_doorbell_interrupt)
> +		adev->nbio.funcs->clear_doorbell_interrupt(adev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index 45295dce5c3e..843052205bd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -95,6 +95,7 @@ struct amdgpu_nbio_funcs {
>  	void (*program_aspm)(struct amdgpu_device *adev);
>  	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
>  	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
> +	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
>  };
>  
>  struct amdgpu_nbio {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 7b79eeaa88aa..b184b656b9b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -508,6 +508,26 @@ static void nbio_v2_3_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev
>  	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
>  }
>  
> +static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
> +{
> +	uint32_t reg, reg_data;
> +
> +	if (adev->asic_type != CHIP_SIENNA_CICHLID)
> +		return;
> +
> +	reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
> +
> +	/* Clear Interrupt Status
> +	 */
> +	if ((reg & BIF_RB_CNTL__RB_ENABLE_MASK) == 0) {
> +		reg = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
> +		if (reg & BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS_MASK) {
> +			reg_data = 1 << BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR__SHIFT;
> +			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, reg_data);
> +		}
> +	}
> +}
> +
>  const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
>  	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
>  	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
> @@ -531,4 +551,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
>  	.program_aspm =  nbio_v2_3_program_aspm,
>  	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
>  	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
> +	.clear_doorbell_interrupt = nbio_v2_3_clear_doorbell_interrupt,
>  };

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
