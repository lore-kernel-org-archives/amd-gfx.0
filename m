Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB12C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8DC2075B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vziRjE64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8DC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4306E096;
	Mon, 13 Jan 2020 16:57:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540F06E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9A6iqm1yc464hfsEZL7kb/2mtdpenxlDJUYFjbjnlS/VWZC+h4cu51PBCiGuoPDxrR4nhJQpiBRjdfl7oefs7HPdwiMOdXquni1sy+ddNk/TvidXD9n/+qVlj0U+x0pVcKTbOdtS4qDUGmzrUnaxYsZ/nTsM7BcPElSJxMvYWZb73eDMNgh0E3EI5e8UeZ86iAX4wtUY+ef2q0X8jDZSlW7cxl5AZVYXHe+OGkaJJ2DoW57QfHHmaOakbRz0sZKMDX5N+MqWzOpJZvKlR0HOZxah6A2KThZlUJ8l6JSRTUNiDlCzzYcyjAVDYEy0FGtmrjg9EsZsKalKmLbUTauDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M9YtqIELlqT1BPpYU1nTPDfrwD0OdNY9cINBXNDcPw=;
 b=c+Ladi0azMPnpyFuuD3d5RIzyq2uzrhiu5cG3eBQxm1otSMMonOKdputfpza4Opld2gdzPsBLkDBNdpbbIGhsPoZ7q4StcvcxKMm74KAqoTzs4hlNCuIcTArnvRPBiUClXUn81hubcBOGwULRYuffz9ZJhD7kJi27Isp2wKeqochpnHwPM2heD/Q6ftlchoHQBnQYRSjMNg7GLWU9Z+VCIExp640AA7IPlGolvwdRktFtgn8AK38Cfd/iLcwQWaOgh4Mu9jwVVEzArXVNQ8HFEw3f1ZiKw/xvFh+PF+w7w6W5DPmMm+prjiVCsybs4pxPzilW4crOCdAvlLv84VevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M9YtqIELlqT1BPpYU1nTPDfrwD0OdNY9cINBXNDcPw=;
 b=vziRjE64mrYl6HLFbtNU9A/NTynBSejFZ4jLFPf15300BHNdApNlxdn+PA4vLbXPdftfoE8pu0To6M/L6Va2E5EfxmBGJZ5PFm5Pyh4NDOXhtaxy4eARZo9fe8F5Eh75nsDc++2X/5To0NlwpDKgy2ncfWaatuR+mIkrdXa3wcg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 16:57:51 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:57:51 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: kiq pm4 function implementation for gfx_v9
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5d79097f-bc5c-eecf-1da9-69c23e7728b8@amd.com>
Date: Mon, 13 Jan 2020 11:57:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200111183938.126310-2-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 16:57:51 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d7e4594-cabd-4591-31b0-08d79849b9bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:|DM5PR1201MB0203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02037FE4CC61CCDBBFA637CE92350@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(81156014)(31686004)(5660300002)(81166006)(8936002)(8676002)(86362001)(478600001)(36756003)(31696002)(6486002)(66556008)(66946007)(66476007)(2906002)(44832011)(316002)(16576012)(53546011)(2616005)(16526019)(36916002)(186003)(52116002)(26005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0203;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM7kDbPo5xxoZ0Y9WJ1t6twCjbRunCctFPMvxWwjf4/+QWqQJSwknBmdFnIdh5pWRTws/4LiXDtQuXY7dcQcQ2gbVOAhassheFHUiEdvHfskVET2KyUYo4UkoB67QNbrxg0mUkdPJrtCEQL3yLz3IcsXYoNuQ8WXO1HXsJKigB3m+Pd+jLvoBiI2+X+34assluGI4LDsZ1j4KtPmjduT2V5YVtmyJWMJv24tUxg2KBcLj0VrooBOPcvAPGvxogdepDVZNoFg7LES9fy6vGgatmZ2+F+yS2a1VwrPq6pV1OIswx/49Un8wQwflQwKMsi/vtT1OunFaNiivf2Uov9I7VpFC90C7cThSYiEpc//zTb3QqFJoz9RYW1bsAK1xUG60Y80Vp/vYp5UnRB/+Dx8uh5aBN57RCjAIyScuk1FtDuEOJTSzr4ap2EMgyurIvXs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7e4594-cabd-4591-31b0-08d79849b9bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:57:51.3826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhJMn+pdWSSBoM1VJHyMNcmh0IIkG427osAMR5me+vrSeveJg4qtJhChaaPz+Bk9sCa0URlCmLlUisTM+LB/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

On 2020-01-11 1:39 p.m., Alex Sierra wrote:
> Functions implemented from kiq_pm4_funcs struct members
> for gfx_v9 version.
>
> Change-Id: I8fd3e160c4bd58f19d35d29e39517db967063afe
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 115 ++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e3d466bd5c4e..ad0179ea2cc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -739,6 +739,120 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
>   				     void *inject_if);
>   
> +static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
> +				uint64_t queue_mask)
> +{
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
> +	amdgpu_ring_write(kiq_ring,
> +		PACKET3_SET_RESOURCES_VMID_MASK(0) |
> +		/* vmid_mask:0* queue_type:0 (KIQ) */
> +		PACKET3_SET_RESOURCES_QUEUE_TYPE(0));
> +	amdgpu_ring_write(kiq_ring,
> +			lower_32_bits(queue_mask));	/* queue mask lo */
> +	amdgpu_ring_write(kiq_ring,
> +			upper_32_bits(queue_mask));	/* queue mask hi */
> +	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
> +	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
> +	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
> +	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
> +}
> +
> +static void gfx_v9_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
> +				 struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = kiq_ring->adev;
> +	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
> +	uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
> +	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
> +	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
> +	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +			 PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
> +			 PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
> +			 PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
> +			 PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
> +			 PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
> +			 /*queue_type: normal compute queue */
> +			 PACKET3_MAP_QUEUES_QUEUE_TYPE(0) |
> +			 /* alloc format: all_on_one_pipe */
> +			 PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) |
> +			 PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
> +			 /* num_queues: must be 1 */
> +			 PACKET3_MAP_QUEUES_NUM_QUEUES(1));
> +	amdgpu_ring_write(kiq_ring,
> +			PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
> +	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
> +	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
> +	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
> +	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
> +}
> +
> +static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
> +				   struct amdgpu_ring *ring,
> +				   enum amdgpu_unmap_queues_action action,
> +				   u64 gpu_addr, u64 seq)
> +{
> +	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
> +	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +			  PACKET3_UNMAP_QUEUES_ACTION(action) |
> +			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
> +			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
> +			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
> +	amdgpu_ring_write(kiq_ring,
> +			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
> +
> +	if (action == PREEMPT_QUEUES_NO_UNMAP) {
> +		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> +		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> +		amdgpu_ring_write(kiq_ring, seq);
> +	} else {
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +	}
> +}
> +
> +static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
> +				   struct amdgpu_ring *ring,
> +				   u64 addr,
> +				   u64 seq)
> +{
> +	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
> +			  PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
> +			  PACKET3_QUERY_STATUS_COMMAND(2));
> +	/* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
> +	amdgpu_ring_write(kiq_ring,
> +			PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
> +			PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
> +	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
> +	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
> +	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
> +	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
> +}
> +
> +static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
> +	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
> +	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
> +	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
> +	.kiq_query_status = gfx_v9_0_kiq_query_status,
> +	.set_resources_size = 8,
> +	.map_queues_size = 7,
> +	.unmap_queues_size = 6,
> +	.query_status_size = 7,
> +};
> +
> +static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
> +{
> +	adev->gfx.kiq.pmf = &gfx_v9_0_kiq_pm4_funcs;
> +}
> +
>   static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
>   {
>   	switch (adev->asic_type) {
> @@ -4260,6 +4374,7 @@ static int gfx_v9_0_early_init(void *handle)
>   	else
>   		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
>   	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
> +	gfx_v9_0_set_kiq_pm4_funcs(adev);
>   	gfx_v9_0_set_ring_funcs(adev);
>   	gfx_v9_0_set_irq_funcs(adev);
>   	gfx_v9_0_set_gds_init(adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
