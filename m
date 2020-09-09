Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA52C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 15:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02922265
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mbtF1RW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02922265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25A56E32D;
	Wed,  9 Sep 2020 15:01:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD4D8997E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 15:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyB46oFoBJurtNNQL9ImVS30uSuFc8cLe89CGof4c7CJDsteh5nqMExr2u9opgGcS+e6SYhdUo5ZXTSZyOG+D2rIhpoqbyqBCr6/b0TxeAAX6nnn7gccSiTDnDgGRvEieMTOhKTYhdDsEOHZd85P/dzTEW83LyfCU4dBnKN+qiSqj5vAbWmLHaGKcd0DYjytWHJYYCO5FWsCYbfCyh9C/roFtAnI78WXbcSmOUnQNFJNGRjdrHLJTCVB9fIeSd6EIknpdRjWeZIHNWBsAIhMWXW9cdmzjDaZpMerlYvdu+Rz2ZMHkieL8pNrcjfEXbB1Ts7IfATDpzaXonslr8AYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bYrUaSEsjyH37hAMwYQ6q3vYAQ3oPBrTeHb2qh18Go=;
 b=DAwHKLsIT5L4uCJULQSDl5L6OjmvPYc9ndEgrVlevSNHcZTrIXw/1n5Aetb/AfrP952rgZrF+eroN+l2LVNX8fA0VXwj3QhqQFgnBAaQ+yRW44xh1MeG2uFaOJcglJ/Z9IfNTOeceD5kH9YRcY34vpLFaF4j21es2KnrMloSFMWP9vAzND19gJxw/DRpzjbi782LYfjFlix18qrx0laXFmmIVnSMbWN/yeyWJFBrymSZW8EoSFATuyxy9rdDNN8+q7JaG5yl6dGkErPx4EJC2xVTvJB7DpNOPQ7MHQJByrvOipSDgjm0JDQnlPj2p9K+M/GaUw/iTwaOAeQA8hW9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bYrUaSEsjyH37hAMwYQ6q3vYAQ3oPBrTeHb2qh18Go=;
 b=mbtF1RW90u202LZUnlexQf7GIl/q/NXDM+POUjVATx6Jgil6F8T0l2wegKQZttUgRcm8F0hbZyI5LyFoH+F27OH+mQPY6Ks/l5pjLg9Ow2ox1Yb/ELej2isilDXdcKGiimBCFVGvAKJi2TmodponIFzxUutuI8GIVOmnTgO5aRU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:00:56 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Wed, 9 Sep 2020
 15:00:56 +0000
Subject: Re: [PATCH 2/3] drm/amd/display: Refactor to prevent crtc state
 access in DM IRQ handler
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
 <20200909142854.105032-3-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <41e2f4c8-1b9c-247a-b239-36d5ef601092@amd.com>
Date: Wed, 9 Sep 2020 11:00:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200909142854.105032-3-aurabindo.pillai@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::20) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.61] (24.212.165.133) by
 YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 15:00:55 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89079b0d-5f95-4a6d-a34b-08d854d12750
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3414A8658D2734468B066AA6EC260@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmFY7yv1C8vxkC7/BBiZ95KqpqtEIL3GSfwTetinjS0ZLR2tWtaS/wExixJ1+K+rgpH0shiCIoVa3L4JnOsGvCQ47Q242XIfEkOu15BcakomLDYGGrkns7L8dJsdypjWPvbGxtxWCYL56gjtPfa+heJ6NN8CcJ2x5uu6rihuuxKmCX/Tbbezq5ijcZQlNIdGOqGj8oxjjKKbF0l34hPTPTCbjJzLx4zbnchhKsPuFj0pN3SqqdNVvH3gYBbIOfVMX2gxotrVK80j4qlDze2cGAkEbWM80rxGwwJEUKzJqjs/GbycPjxLZgwpior+7P0eC/3g8HDgg3Uf2DjUmWIbW8sRKpTyQXhy8TxLG4o04W3uFShFBkNsD1XbhgjYhYTb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(52116002)(316002)(16576012)(26005)(31686004)(83380400001)(53546011)(6666004)(36756003)(30864003)(8676002)(5660300002)(6486002)(66946007)(66556008)(66476007)(16526019)(2906002)(31696002)(478600001)(86362001)(2616005)(8936002)(956004)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HC8DibYW59lGqFp7s+FXBvgVS3XygEFjm5jkRVltvwcGoM74S7AM1xqfRR6inf1FiZp/EUKziONFbYPfQ4CM6155+iAYLMnOHiyJ16w8njisVd7tNSBFkmwIJRBuMu1adYBQgbe+aizxG8EWg/iF8LPAOfHBRO5JzVS0FlYJDP8HePK7MafPQFomE83C/bH95TBTr738BZOQrxAdGguNF7mRV9dZJG1vIFg35O3Auxv75YhTPrQDqn4Iw7mI+LxiKyROUpGIuPIzLMGCWFHsCwS2ASXV5LaK/6AD/7J+7dNQCIf/FSnRRtV0nI/2sjKQ6CtKtvctvLBCj/aNri8k4cn96bU7+QAcbXJ1jOuIWyBOeX7OHQjSVO92lAbxUhp159JVx0DjD2letZzkfy/01jqWF+L/hjNd2buHQtF26vA6KSBuu8b2dk1mGIssJlaR0RqiwWsqoJHBPjfn89BLmXwRmJw85RzlTWR8FDCfuxtx+qNUA0hXzvyHN0XZe+FfR1zJu/J8GgjnqC8BgvMZatik/UhGg5H2MUIr3g3ob4zpusT/E5r1jdUNUG7GneRYSAV0N+mi+JnOk7aE2YM/a9jESyeJgquAkytGwlYEybzZ1gww97x0/wiSu5aD3xOM8MkoZC+dml7AytTsyLGPoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89079b0d-5f95-4a6d-a34b-08d854d12750
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:00:56.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Xl18FaIMiPckcGsqaEa+8A62OXOjRh809GemU2VQeYnzsb66GwxNTIliKpM+W3epFZ7FWvc0OMsETgNYJesEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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

On 2020-09-09 10:28 a.m., Aurabindo Pillai wrote:
> [Why&How]
> Currently commit_tail holds global locks and wait for dependencies which is
> against the DRM API contracts. Inorder to fix this, IRQ handler should be able
> to run without having to access crtc state. Required parameters are copied over
> so that they can be directly accessed from the interrupt handler
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 115 ++++++++++--------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
>   .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +
>   3 files changed, 68 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40814cdd8c92..0603436a3313 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -192,17 +192,14 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
>   		return 0;
>   	else {
>   		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
> -		struct dm_crtc_state *acrtc_state = to_dm_crtc_state(
> -				acrtc->base.state);
>   
> -
> -		if (acrtc_state->stream == NULL) {
> +		if (acrtc->dm_irq_params.stream == NULL) {
>   			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
>   				  crtc);
>   			return 0;
>   		}
>   
> -		return dc_stream_get_vblank_counter(acrtc_state->stream);
> +		return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
>   	}
>   }
>   
> @@ -215,10 +212,8 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
>   		return -EINVAL;
>   	else {
>   		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
> -		struct dm_crtc_state *acrtc_state = to_dm_crtc_state(
> -						acrtc->base.state);
>   
> -		if (acrtc_state->stream ==  NULL) {
> +		if (acrtc->dm_irq_params.stream ==  NULL) {
>   			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
>   				  crtc);
>   			return 0;
> @@ -228,7 +223,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
>   		 * TODO rework base driver to use values directly.
>   		 * for now parse it back into reg-format
>   		 */
> -		dc_stream_get_scanoutpos(acrtc_state->stream,
> +		dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
>   					 &v_blank_start,
>   					 &v_blank_end,
>   					 &h_position,
> @@ -287,6 +282,14 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
>   	return NULL;
>   }
>   
> +static inline bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
> +{
> +	return acrtc->dm_irq_params.freesync_config.state ==
> +		       VRR_STATE_ACTIVE_VARIABLE ||
> +	       acrtc->dm_irq_params.freesync_config.state ==
> +		       VRR_STATE_ACTIVE_FIXED;
> +}
> +
>   static inline bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
>   {
>   	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
> @@ -307,7 +310,6 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   	struct amdgpu_device *adev = irq_params->adev;
>   	unsigned long flags;
>   	struct drm_pending_vblank_event *e;
> -	struct dm_crtc_state *acrtc_state;
>   	uint32_t vpos, hpos, v_blank_start, v_blank_end;
>   	bool vrr_active;
>   
> @@ -339,12 +341,11 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   	if (!e)
>   		WARN_ON(1);
>   
> -	acrtc_state = to_dm_crtc_state(amdgpu_crtc->base.state);
> -	vrr_active = amdgpu_dm_vrr_active(acrtc_state);
> +	vrr_active = amdgpu_dm_vrr_active_irq(amdgpu_crtc);
>   
>   	/* Fixed refresh rate, or VRR scanout position outside front-porch? */
>   	if (!vrr_active ||
> -	    !dc_stream_get_scanoutpos(acrtc_state->stream, &v_blank_start,
> +	    !dc_stream_get_scanoutpos(amdgpu_crtc->dm_irq_params.stream, &v_blank_start,
>   				      &v_blank_end, &hpos, &vpos) ||
>   	    (vpos < v_blank_start)) {
>   		/* Update to correct count and vblank timestamp if racing with
> @@ -405,17 +406,17 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>   	struct common_irq_params *irq_params = interrupt_params;
>   	struct amdgpu_device *adev = irq_params->adev;
>   	struct amdgpu_crtc *acrtc;
> -	struct dm_crtc_state *acrtc_state;
>   	unsigned long flags;
> +	int vrr_active;
>   
>   	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
>   
>   	if (acrtc) {
> -		acrtc_state = to_dm_crtc_state(acrtc->base.state);
> +		vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
>   
>   		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
>   			      acrtc->crtc_id,
> -			      amdgpu_dm_vrr_active(acrtc_state));
> +			      vrr_active);
>   
>   		/* Core vblank handling is done here after end of front-porch in
>   		 * vrr mode, as vblank timestamping will give valid results
> @@ -423,22 +424,22 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>   		 * page-flip completion events that have been queued to us
>   		 * if a pageflip happened inside front-porch.
>   		 */
> -		if (amdgpu_dm_vrr_active(acrtc_state)) {
> +		if (vrr_active) {
>   			drm_crtc_handle_vblank(&acrtc->base);
>   
>   			/* BTR processing for pre-DCE12 ASICs */
> -			if (acrtc_state->stream &&
> +			if (acrtc->dm_irq_params.stream &&
>   			    adev->family < AMDGPU_FAMILY_AI) {
>   				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>   				mod_freesync_handle_v_update(
>   				    adev->dm.freesync_module,
> -				    acrtc_state->stream,
> -				    &acrtc_state->vrr_params);
> +				    acrtc->dm_irq_params.stream,
> +				    &acrtc->dm_irq_params.vrr_params);
>   
>   				dc_stream_adjust_vmin_vmax(
>   				    adev->dm.dc,
> -				    acrtc_state->stream,
> -				    &acrtc_state->vrr_params.adjust);
> +				    acrtc->dm_irq_params.stream,
> +				    &acrtc->dm_irq_params.vrr_params.adjust);
>   				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   			}
>   		}
> @@ -457,18 +458,17 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   	struct common_irq_params *irq_params = interrupt_params;
>   	struct amdgpu_device *adev = irq_params->adev;
>   	struct amdgpu_crtc *acrtc;
> -	struct dm_crtc_state *acrtc_state;
>   	unsigned long flags;
> +	int vrr_active;
>   
>   	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
>   	if (!acrtc)
>   		return;
>   
> -	acrtc_state = to_dm_crtc_state(acrtc->base.state);
> +	vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
>   
>   	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
> -			 amdgpu_dm_vrr_active(acrtc_state),
> -			 acrtc_state->active_planes);
> +		      vrr_active, acrtc->dm_irq_params.active_planes);
>   
>   	/**
>   	 * Core vblank handling at start of front-porch is only possible
> @@ -476,7 +476,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   	 * valid results while done in front-porch. Otherwise defer it
>   	 * to dm_vupdate_high_irq after end of front-porch.
>   	 */
> -	if (!amdgpu_dm_vrr_active(acrtc_state))
> +	if (!vrr_active)
>   		drm_crtc_handle_vblank(&acrtc->base);
>   
>   	/**
> @@ -491,14 +491,16 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   
>   	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>   
> -	if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
> -	    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> +	if (acrtc->dm_irq_params.stream &&
> +	    acrtc->dm_irq_params.vrr_params.supported &&
> +	    acrtc->dm_irq_params.freesync_config.state ==
> +		    VRR_STATE_ACTIVE_VARIABLE) {
>   		mod_freesync_handle_v_update(adev->dm.freesync_module,
> -					     acrtc_state->stream,
> -					     &acrtc_state->vrr_params);
> +					     acrtc->dm_irq_params.stream,
> +					     &acrtc->dm_irq_params.vrr_params);
>   
> -		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc_state->stream,
> -					   &acrtc_state->vrr_params.adjust);
> +		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
> +					   &acrtc->dm_irq_params.vrr_params.adjust);
>   	}
>   
>   	/*
> @@ -513,7 +515,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   	 */
>   	if (adev->family >= AMDGPU_FAMILY_RV &&
>   	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
> -	    acrtc_state->active_planes == 0) {
> +	    acrtc->dm_irq_params.active_planes == 0) {
>   		if (acrtc->event) {
>   			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
>   			acrtc->event = NULL;
> @@ -4845,7 +4847,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
>   	}
>   
>   	state->active_planes = cur->active_planes;
> -	state->vrr_params = cur->vrr_params;
>   	state->vrr_infopacket = cur->vrr_infopacket;
>   	state->abm_level = cur->abm_level;
>   	state->vrr_supported = cur->vrr_supported;
> @@ -6913,6 +6914,7 @@ static void update_freesync_state_on_stream(
>   	struct mod_vrr_params vrr_params;
>   	struct dc_info_packet vrr_infopacket = {0};
>   	struct amdgpu_device *adev = dm->adev;
> +	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
>   	unsigned long flags;
>   
>   	if (!new_stream)
> @@ -6927,7 +6929,7 @@ static void update_freesync_state_on_stream(
>   		return;
>   
>   	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
> -	vrr_params = new_crtc_state->vrr_params;
> +        vrr_params = acrtc->dm_irq_params.vrr_params;
>   
>   	if (surface) {
>   		mod_freesync_handle_preflip(
> @@ -6958,7 +6960,7 @@ static void update_freesync_state_on_stream(
>   		&vrr_infopacket);
>   
>   	new_crtc_state->freesync_timing_changed |=
> -		(memcmp(&new_crtc_state->vrr_params.adjust,
> +		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
>   			&vrr_params.adjust,
>   			sizeof(vrr_params.adjust)) != 0);
>   
> @@ -6967,10 +6969,10 @@ static void update_freesync_state_on_stream(
>   			&vrr_infopacket,
>   			sizeof(vrr_infopacket)) != 0);
>   
> -	new_crtc_state->vrr_params = vrr_params;
> +	acrtc->dm_irq_params.vrr_params = vrr_params;
>   	new_crtc_state->vrr_infopacket = vrr_infopacket;
>   
> -	new_stream->adjust = new_crtc_state->vrr_params.adjust;
> +	new_stream->adjust = acrtc->dm_irq_params.vrr_params.adjust;
>   	new_stream->vrr_infopacket = vrr_infopacket;
>   
>   	if (new_crtc_state->freesync_vrr_info_changed)
> @@ -6982,7 +6984,7 @@ static void update_freesync_state_on_stream(
>   	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   }
>   
> -static void pre_update_freesync_state_on_stream(
> +static void update_stream_irq_parameters(
>   	struct amdgpu_display_manager *dm,
>   	struct dm_crtc_state *new_crtc_state)
>   {
> @@ -6990,6 +6992,7 @@ static void pre_update_freesync_state_on_stream(
>   	struct mod_vrr_params vrr_params;
>   	struct mod_freesync_config config = new_crtc_state->freesync_config;
>   	struct amdgpu_device *adev = dm->adev;
> +	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
>   	unsigned long flags;
>   
>   	if (!new_stream)
> @@ -7003,7 +7006,7 @@ static void pre_update_freesync_state_on_stream(
>   		return;
>   
>   	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
> -	vrr_params = new_crtc_state->vrr_params;
> +        vrr_params = acrtc->dm_irq_params.vrr_params;
>   
>   	if (new_crtc_state->vrr_supported &&
>   	    config.min_refresh_in_uhz &&
> @@ -7020,11 +7023,14 @@ static void pre_update_freesync_state_on_stream(
>   				      &config, &vrr_params);
>   
>   	new_crtc_state->freesync_timing_changed |=
> -		(memcmp(&new_crtc_state->vrr_params.adjust,
> -			&vrr_params.adjust,
> -			sizeof(vrr_params.adjust)) != 0);
> +		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
> +			&vrr_params.adjust, sizeof(vrr_params.adjust)) != 0);
>   
> -	new_crtc_state->vrr_params = vrr_params;
> +	new_crtc_state->freesync_config = config;
> +	/* Copy state for access from DM IRQ handler */
> +	acrtc->dm_irq_params.freesync_config = config;
> +	acrtc->dm_irq_params.active_planes = new_crtc_state->active_planes;
> +	acrtc->dm_irq_params.vrr_params = vrr_params;
>   	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   }
>   
> @@ -7332,7 +7338,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>   			dc_stream_adjust_vmin_vmax(
>   				dm->dc, acrtc_state->stream,
> -				&acrtc_state->vrr_params.adjust);
> +				&acrtc_attach->dm_irq_params.vrr_params.adjust);
>   			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>   		}
>   		mutex_lock(&dm->dc_lock);
> @@ -7545,6 +7551,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>   	int crtc_disable_count = 0;
>   	bool mode_set_reset_required = false;
> +        struct amdgpu_crtc *acrtc;
>   
>   	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>   
> @@ -7651,9 +7658,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   			const struct dc_stream_status *status =
>   					dc_stream_get_status(dm_new_crtc_state->stream);
>   
> -			if (!status)
> +			if (!status) {
>   				status = dc_stream_get_status_from_state(dc_state,
>   									 dm_new_crtc_state->stream);
> +				dc_stream_retain(dm_new_crtc_state->stream);

You're missing a release on this reference (dc_stream_release) so this 
will cause a memory leak.

> +				acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
> +			}
>   
>   			if (!status)
>   				DC_ERR("got no status for stream %p on acrtc%p\n", dm_new_crtc_state->stream, acrtc);
> @@ -7780,8 +7790,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>   
> -		/* Update freesync active state. */
> -		pre_update_freesync_state_on_stream(dm, dm_new_crtc_state);
> +		/* For freesync config update on crtc state and params for irq */
> +		update_stream_irq_parameters(dm, dm_new_crtc_state);
>   
>   		/* Handle vrr on->off / off->on transitions */
>   		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
> @@ -7797,10 +7807,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   
> +		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +
>   		if (new_crtc_state->active &&
>   		    (!old_crtc_state->active ||
>   		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
> +			dc_stream_retain(dm_new_crtc_state->stream);

This retain is also missing a dc_stream_release.

Regards,
Nicholas Kazlauskas

> +			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
>   			manage_dm_interrupts(adev, acrtc, true);
> +
>   #ifdef CONFIG_DEBUG_FS
>   			/**
>   			 * Frontend may have changed so reapply the CRC capture
> @@ -8044,8 +8059,6 @@ static void reset_freesync_config_for_crtc(
>   {
>   	new_crtc_state->vrr_supported = false;
>   
> -	memset(&new_crtc_state->vrr_params, 0,
> -	       sizeof(new_crtc_state->vrr_params));
>   	memset(&new_crtc_state->vrr_infopacket, 0,
>   	       sizeof(new_crtc_state->vrr_infopacket));
>   }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 4da7cd065ba0..6d4a751a389f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -434,7 +434,6 @@ struct dm_crtc_state {
>   
>   	bool vrr_supported;
>   	struct mod_freesync_config freesync_config;
> -	struct mod_vrr_params vrr_params;
>   	struct dc_info_packet vrr_infopacket;
>   
>   	int abm_level;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> index 55ef237eed8b..45825a34f8eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> @@ -28,6 +28,10 @@
>   
>   struct dm_irq_params {
>   	u32 last_flip_vblank;
> +	struct mod_vrr_params vrr_params;
> +	struct dc_stream_state *stream;
> +	int active_planes;
> +	struct mod_freesync_config freesync_config;
>   };
>   
>   #endif /* __AMDGPU_DM_IRQ_PARAMS_H__ */
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
