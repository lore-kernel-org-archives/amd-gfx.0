Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F22C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F312220709
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lHeVzzRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F312220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF72089F89;
	Wed, 20 May 2020 15:46:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EB489F89
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 15:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHojDpNmbfV6RvY5eVoKX0gsWVpRI2887nuj+3y8TdydLt9cNbUBCi0fhZJ/oNBIJboojF1m1Ap9LnSBNwDAEthHAVLVXeMRQN88ounrMTQqL7qmWo3WCRYtRp2AR/Vv44IILlzGfrGnbSeJwAWTbz5y9tyUAU4wwZti68wnyg2zvJKPNG8CSytOw0GAk7e2yHYnNUAlWqDmv/YzpVqvquoEQh7hQVZmszEZPyy3l8HhfbLKd3ZA4vQ0CHJ9LoHc8ZDKFiSRQM6Nb9tBXbxrafwiV3fISrtTr9K+xmBtj1s351r5oOkAHP6kIS7yXZWy1pipt6YKlMzMafUcJhTqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dp6/6gLjoiIG9bVDNN3f8p+bRoEuypyJkrxhmxTrxs=;
 b=Ib8Y4Gh4QqzCrhB5MzU/7eJuhmt0h5q8WHg35w781PRXwHMoheG4EykOqJ5sGHtRHVuPBMIjvx0oGg0UDA0KiTlMouwgIU6HuKmk3588X5uw+9GW0xqE3gWr8+TWwV2j419PLCaUsRDpY/ZbYVuEL2E5gIvOTR4e2HLohaPR37dVdwGyGaExdgVhdB/r8qpBQhVCP8YexE9P3RAKxmTcjYsmllgrbZpDxFZd89mMLG6HQY9dTzBefjr/EsrfKt9R0xMnkyAhc33fTiNZqE+5JGxytP0ET7dRlju11hfr3HA8iWqW7TeLmpWUDP3UF57iUwbTJaASh58ww+tNPk0jHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dp6/6gLjoiIG9bVDNN3f8p+bRoEuypyJkrxhmxTrxs=;
 b=lHeVzzRA/Wwb7Oaok+e//CdFbIyRjCxY4QBOdVko3e7S0lwHPptM4DSoWoTtmE80j9oDBWx7CKzEvdkT7tH8+VJrWdqiAXysDPeXVT2JgdsOvQdktymRWvlf5UtrV2DxqtUBCp9Mwp+LxDzi/o5HR+dNWaVp43skyXXznMYo1W0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3509.namprd12.prod.outlook.com (2603:10b6:a03:13b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 15:46:25 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:46:25 +0000
Subject: Re: [PATCH] drm/amd/display: Handle GPU reset for DC block
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20200520152949.15795-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <3285e846-d346-fa12-e00f-f07b24366c15@amd.com>
Date: Wed, 20 May 2020 11:46:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200520152949.15795-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 15:46:24 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e162cae-c332-46af-8f08-08d7fcd4f392
X-MS-TrafficTypeDiagnostic: BYAPR12MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3509ED2164B747D17A2F6927ECB60@BYAPR12MB3509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7L4ST/K2yGS0jo9oSxc1jP588PiKx2llB6SoJwaa3WtCv9CmxncyswdGhzRNXvafNeNKNUAFarRh+TeaPSoel0Lj6uneQ2c/djd/JVeyKdKuPfMPFZCV7YmRxfxX/q93u33TZOthROVyno9o85VDHVQ6GjmBWi+ob5ujGrfGJfcxRaWc05atLiNGT+yxB1WTgVegrtK16+/5wSHuSNYFeytd89/gKYqEauDmZhQ3l32dtn3dZbiBQWwwzPFA3N8eha8aNZWwG4AzdrKyVcOuy/QOeenKMSHVvnYVKXebOb5q+Y5/+VV9grCEPv6Lxx4Icl05PW1AVxtX9YgtSZlB7380UeAPX941ae0NqD2+ZAiPewQQNxqK8vZ8uCYbzFKI570ReCMrNsOXCMP+SNYv7iKk4rxcSJwKX/xwPjkWL0nnyZ3TL1yFnKT+cMgopzmzzVbasOpze5U7IBthOuQTPG+UX3dWUiGp6HbiG2LaFBe7v0ncKQJCjeikaPNOdqy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(26005)(31696002)(956004)(8936002)(8676002)(2616005)(36756003)(6636002)(31686004)(66946007)(66556008)(66476007)(86362001)(16526019)(2906002)(316002)(186003)(5660300002)(6486002)(52116002)(478600001)(53546011)(6666004)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TnfYaNvGAJD0i39Z+UWFAGJG4v1K80fJ9d3SUfaUvb5VXtXaKugB4ptCsw05IbbZ/C5M+QKGHYee5uuynmjFoZ39Ez1k6WaQ7t/NDTNA4x/hkrT6DS3tQmP2c6s5Wiz1/hsTL85DU/ZWwa6CEzv5/xrUXWqKVBujUaIvZitQbi66RXCF8SB5n2A1xGzZliT+NIxLNuJaqRA0GyWv/ygL/vL1bkMeQyujEnVdl4OmHcXx2BqpQpWfQGOEgn/hDn8Pk8UeuXGuJo3WZgk+VkoGhTm8swnP+A4xZFlhMACwP0SRSrjwjjyvfp+3v+RCqJ3xsOXsPZnLhKQbiQ5+L6GdivyOG+/Q/U+iVC2+h5EiYogGKc0ROGJxVIjttGtf/KLJ6ALqf69BtZ4lf5j3bU7KuHgTk2xhU13CCQ9om+TW6pR7zw/uw4/5rTiLYsgTpax6LX3XC1VT6OqJ/fQ0nkUVdFCpz0T5a4hUFB8a2bTdmM1zOquWkadrSu+PaPm5vAVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e162cae-c332-46af-8f08-08d7fcd4f392
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:46:24.9667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKG7QvqiDgxj05IU+FKN6PTjzcepuFaK8JU6ppTh7iK2tpul+ly2ubFDf9LGb9d1EcOBpXS1bpnriTl6/XjNzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3509
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

On 2020-05-20 11:29 a.m., Bhawanpreet Lakha wrote:
> [Why]
> Previously we used the s3 codepath for gpu reset. This can lead to issues in
> certain case where we end of waiting for fences which will never come (because
> parts of the hw are off due to gpu reset) and we end up waiting forever causing
> a deadlock.
> 
> [How]
> Handle GPU reset separately from normal s3 case. We essentially need to redo
> everything we do in s3, but avoid any drm calls.
> 
> For GPU reset case
> 
> suspend:
> 	-Acquire DC lock
> 	-Cache current dc_state
> 	-Commit 0 stream/planes to dc (this puts dc into a state where it can be
> 	 powered off)
> 	-Disable interrupts
> resume
> 	-Edit cached state to force full update
> 	-Commit cached state from suspend
> 	-Build stream and plane updates from the cached state
> 	-Commit stream/plane updates
> 	-Enable interrupts
> 	-Release DC lock

Some comments inline below, but mostly looks good.


> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 +++++++++++++++++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>   2 files changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 60fe64aef11b..46bb6e156f81 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1521,10 +1521,109 @@ static int dm_hw_fini(void *handle)
>   	return 0;
>   }
>   
> +
> +static int dm_enable_vblank(struct drm_crtc *crtc);
> +static void dm_disable_vblank(struct drm_crtc *crtc);
> +
> +static void dm_gpureset_interrupt(struct amdgpu_device *adev,
> +				 struct dc_state *state, bool enable)
> +{

dm_gpureset_toggle_interrupts() might be more clear since this isn't an 
interrupt handler.

> +	enum dc_irq_source irq_source;
> +	struct amdgpu_crtc *acrtc;
> +	int rc = -EBUSY;
> +	int i = 0;
> +
> +	for (i = 0; i < state->stream_count; i++) {
> +		acrtc = get_crtc_by_otg_inst(
> +				adev, state->stream_status[i].primary_otg_inst);
> +
> +		if (acrtc && state->stream_status[i].plane_count != 0) {
> +			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
> +			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
> +			DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
> +				  acrtc->crtc_id, enable ? "en" : "dis", rc);
> +			if (rc)
> +				DRM_WARN("Failed to %s pflip interrupts\n",
> +					 enable ? "enable" : "disable");
> +
> +			if (enable){

Style nitpick, should be if (enable) {

> +				rc = dm_enable_vblank(&acrtc->base);
> +				if (rc)
> +					DRM_WARN("Failed to enable vblank interrupts\n");
> +			} else

Let's keep the } else {

}

here since we're already using on the if above.

> +				dm_disable_vblank(&acrtc->base);
> +
> +		}
> +	}
> +
> +}
> +
> +enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
> +{
> +	struct dc_state *context = NULL;
> +	enum dc_status res = DC_ERROR_UNEXPECTED;
> +	int i;
> +	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };

Let's use memset for this rather than = { 0 }; , some compilers complain.

> +	int del_streams_count = 0;
> +
> +	context = dc_create_state(dc);
> +	if (context == NULL)
> +		goto context_alloc_fail;
> +
> +	dc_resource_state_copy_construct_current(dc, context);
> +
> +	/* First remove from context all streams */
> +	for (i = 0; i < context->stream_count; i++) {
> +		struct dc_stream_state *stream = context->streams[i];

Need an extra blank line here.

> +		del_streams[del_streams_count++] = stream;
> +	}
> +
> +	/* Remove all planes for removed streams and then remove the streams */
> +	for (i = 0; i < del_streams_count; i++) {
> +		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
> +			res = DC_FAIL_DETACH_SURFACES;
> +			goto fail;
> +		}
> +
> +		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
> +		if (res != DC_OK)
> +			goto fail;
> +	}
> +
> +
> +	res = dc_validate_global_state(dc, context, false);
> +
> +	if (res != DC_OK) {
> +		DRM_ERROR("%s:resource validation failed, dc_status:%d\n", __func__, res);
> +		goto fail;
> +	}
> +
> +	res = dc_commit_state(dc, context);
> +
> +fail:
> +	dc_release_state(context);
> +
> +context_alloc_fail:
> +	return res;
> +}
> +
>   static int dm_suspend(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
>   	struct amdgpu_display_manager *dm = &adev->dm;
> +	int ret = 0;
> +
> +	if (adev->in_gpu_reset) {
> +		mutex_lock(&dm->dc_lock);
> +		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
> +
> +		dm_gpureset_interrupt(adev, dm->cached_dc_state, false);
> +		
> +		amdgpu_dm_commit_zero_streams(dm->dc);
> +
> +		amdgpu_dm_irq_suspend(adev);

Probably should have a blank line here for style.

> +		return ret;
> +	}
>   
>   	WARN_ON(adev->dm.cached_state);
>   	adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
> @@ -1640,6 +1739,46 @@ static void emulated_link_detect(struct dc_link *link)
>   
>   }
>   
> +static void dm_gpureset_commit_state(struct dc_state *dc_state,
> +				     struct amdgpu_display_manager *dm)
> +{
> +	struct {
> +		struct dc_surface_update surface_updates[MAX_SURFACES];
> +		struct dc_plane_info plane_infos[MAX_SURFACES];
> +		struct dc_scaling_info scaling_infos[MAX_SURFACES];
> +		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
> +		struct dc_stream_update stream_update;
> +	} * bundle;
> +	int k, m;
> +
> +	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
> +
> +	if (!bundle) {
> +		dm_error("Failed to allocate update bundle\n");
> +		goto cleanup;
> +	}
> +
> +	for (k = 0; k < dc_state->stream_count; k++) {
> +		bundle->stream_update.stream = dc_state->streams[k];
> +
> +		for (m = 0; m < dc_state->stream_status->plane_count; m++) {
> +			bundle->surface_updates[m].surface =
> +				dc_state->stream_status->plane_states[m];
> +			bundle->surface_updates[m].surface->force_full_update =
> +				true;
> +		}
> +		dc_commit_updates_for_stream(
> +			dm->dc, bundle->surface_updates,
> +			dc_state->stream_status->plane_count,
> +			dc_state->streams[k], &bundle->stream_update, dc_state);
> +	}
> +
> +cleanup:
> +	kfree(bundle);
> +
> +	return;
> +}
> +
>   static int dm_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
> @@ -1656,8 +1795,42 @@ static int dm_resume(void *handle)
>   	struct dm_plane_state *dm_new_plane_state;
>   	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
>   	enum dc_connection_type new_connection_type = dc_connection_none;
> -	int i, r;
> +	struct dc_state *dc_state;
> +	int i, r, j;
> +
> +	if (adev->in_gpu_reset) {
> +		dc_state = dm->cached_dc_state;
>   
> +		r = dm_dmub_hw_init(adev);
> +		if (r)
> +			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> +
> +		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +		dc_resume(dm->dc);
> +
> +		amdgpu_dm_irq_resume_early(adev);
> +
> +		for (i = 0; i < dc_state->stream_count; i++) {
> +			dc_state->streams[i]->mode_changed = true;
> +			for (j = 0; j < dc_state->stream_status->plane_count; j++) {
> +				dc_state->stream_status->plane_states[j]->update_flags.raw
> +					= 0xffffffff;
> +			}
> +		}
> +
> +		WARN_ON(!dc_commit_state(dm->dc, dc_state));
> +
> +		dm_gpureset_commit_state(dm->cached_dc_state, dm);
> +
> +		dm_gpureset_interrupt(adev, dm->cached_dc_state, true);
> +
> +		dm->cached_dc_state = NULL;

Shouldn't we free this?

Regards,
Nicholas Kazlauskas

> +		amdgpu_dm_irq_resume_late(adev);
> +
> +		mutex_unlock(&dm->dc_lock);
> +
> +		return 0;
> +	}
>   	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
>   	dc_release_state(dm_state->context);
>   	dm_state->context = dc_create_state(dm->dc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 3f0c6298b588..40c912e0bf0c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -315,6 +315,7 @@ struct amdgpu_display_manager {
>   #endif
>   
>   	struct drm_atomic_state *cached_state;
> +	struct dc_state *cached_dc_state;
>   
>   	struct dm_comressor_info compressor;
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
