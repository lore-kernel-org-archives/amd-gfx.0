Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CACC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57936206C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z1MUYTcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57936206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7B66E0D4;
	Fri, 22 May 2020 14:59:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7724E6E0D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 14:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F557z1kKArAVWC2OSBtO+gT1CNriwHV/96zh6Vw/Ow05/2w8G69fteu2JuTbaDuWi0zn4exqE1LvJqMWsWgjEe3H9hJIgfDxD2KXmpsyQ93sF7edwHLimAALc1wGLC6bo8p+XOtEZiSw8hbTv7LiFXjk+8nTrHLVZFjD+IKsBSqynaGjpQoj6OVvqR0bFUrBrdsKImFPnm6jhuSDM9YZ93hSde2+JcozeaauV2eWelasUNLEE6BvGvyHilWgF/rbq/b9l+apk9JIM03P1osD8EmujVm+sCx186dSdQzpXJgv9Kv5rZ/vbhb4f4z2pRhrA0LYoTcJrhuPFy84A7BCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZF2ntyWjJu9ODOmma9Tef61KJmM5DGgSgklw5rnsvE=;
 b=TYdOrNvKn4XZ7ccZyDtng8AxNqv4vLpgeoToVHh0kqbZvpfDaqYsxW5A0cyEXbkaU1vwFLndMijQsrqS+Hpu/rC/aCLeCWaJ5ERrC7fqRdHw7AOQjpQxYsB/Iqr21xrV3nhb8ndzZe+Ws2ZWN73xc1oYgT6nBzHcf4ehUdeDyS99oz8JaIggKP/lbFfX9lCDyJA3TgJtZJv62Tqo28iTbnw7jSNNGTQnZkwmAJ5uHQPTIHrqOG9EewC0rnjeZrOCPCAqun2j1hyWp5utM7Y6GUs9EyoRPP/a5cHf23YaE247lQd/87PjauDJ8Dl7xq723jTZP3NvxXzs/8bpQ5KP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZF2ntyWjJu9ODOmma9Tef61KJmM5DGgSgklw5rnsvE=;
 b=z1MUYTccvq5a5uYPg3pXwJxoanC/l0qmDWK/xAY4pSA+GGOH7c8UyT12zbniiZf3icxnEYoL4b0pyhSfw9LfpyyOpBh2rty6ThHZUrGZ57EjKOhTPOt6aj8UkDASxHbCJq9Ha8XwAs71C1n2lGfcA36x01eZC+EN3UnHRuGeYCk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 14:59:33 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 14:59:33 +0000
Subject: Re: [PATCH] drm/amd/display: Handle GPU reset for DC block
To: Alex Deucher <alexdeucher@gmail.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20200521213933.5252-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_OaLsk6T-+R2n0ozB2c_dGWKukoKL-UYX-N6kr1k4-3SA@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <54252959-67b6-9d9b-429a-8b6467f503ab@amd.com>
Date: Fri, 22 May 2020 10:59:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CADnq5_OaLsk6T-+R2n0ozB2c_dGWKukoKL-UYX-N6kr1k4-3SA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 14:59:32 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b32e892-9a57-4cfc-4dc8-08d7fe60bc80
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3637329BBE55807D850FF1D3ECB40@BYAPR12MB3637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVSNZkHWc/W3agOoQU+3Fo57dquko9yqapAiKcp7RGTAXl2Rh4xte74OJts7sjS1VWo4Je/K7Uo6V5WxAyMCJKjX66KvC/+ztcZsRx3D1YKfK+hOasJo+Hs5B5iWHycLF5IY0Mn3+kMTE/KRDU9EhvPOdcc8R2+iD3W9FfKZxVCI2vehr5CyJljDVPudkWTeO8v2MNYKn9JhaXgk2hz+kBdT3YVixCxajFyvmVU6rLckaraLA0gQkgdy2uiiUf9hcT+Arz1CXDwSioxPnNS5XdlI+hasooHtm9U+yiamnpFhJlCQYRb2zMD+qMZGsdWTPZ0jjxYmDr2qf/673xbHlRdM71OFhDChMC/Q8ZCklVaBnTt9ik26vVVNM9AModWprKunCZ6T778yd7gh85U34NEmrVNxvsSFyfLChx7NHp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(6486002)(6666004)(31686004)(52116002)(8936002)(16526019)(53546011)(8676002)(36756003)(16576012)(66476007)(110136005)(6636002)(26005)(2906002)(478600001)(5660300002)(86362001)(31696002)(54906003)(66946007)(2616005)(956004)(4326008)(316002)(66556008)(186003)(966005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 33vdyOpwdR0rz+Zy9VYleBYHA20EW3ecRO8dCnmzAsrbE6fDjRO91adfrF9XhtmjSA0obMkRjugllk8I14RRtZSGpG10cWo+bL5ORihYXhQtfDL5TbuQtaEZo2EgHjbw4XfU1GoBisAv4CjfK0xPwqOK8AVH2nUmUjy+YfVJcfIOfsqTCodWSxHpN6i2jGmIWXJhbX+wu6DgopbfSjFkkRqEpXoG+cq4+aRdnQDDfueNmDkvJ5BQ3g7i8Ap4aMj8AkRBrAcO9rpAkgJpYzKKDKmhRGERtq3n5zsPulxFvRRyn1crdZ9d2Z6NZxJmViRiwo3FJgASxunZLWvswEpdKH4010dbTZdGKXE1rbsL0R4SLsxcMYEIdk+ZO0L0XYVt+4EaA+utpc6xGWxjPy9lNOwjd1yXE80wRYOemvy0bgfN8+aOw8wOLFIzMdmCiHO+gc8MsQp4csjMiv99JicrvfBjGXmJBoDRAMuvLXquvREBL5jCwHGmmLd6AsVjgKHE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b32e892-9a57-4cfc-4dc8-08d7fe60bc80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 14:59:33.0354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBfkRlgJ0bVhwoSZrGgHmVsL1xpqKP/Rtl0sllI3ZZ9h5m8uOR/m8LCb61wwqzXcgPdus29oeAleQm2RbhLGJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-22 10:45 a.m., Alex Deucher wrote:
> On Thu, May 21, 2020 at 5:39 PM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>>
>> [Why]
>> Previously we used the s3 codepath for gpu reset. This can lead to issues in
>> certain case where we end of waiting for fences which will never come (because
>> parts of the hw are off due to gpu reset) and we end up waiting forever causing
>> a deadlock.
>>
>> [How]
>> Handle GPU reset separately from normal s3 case. We essentially need to redo
>> everything we do in s3, but avoid any drm calls.
>>
>> For GPU reset case
>>
>> suspend:
>>          -Acquire DC lock
>>          -Cache current dc_state
>>          -Commit 0 stream/planes to dc (this puts dc into a state where it can be
>>           powered off)
>>          -Disable interrupts
>> resume
>>          -Edit cached state to force full update
>>          -Commit cached state from suspend
>>          -Build stream and plane updates from the cached state
>>          -Commit stream/plane updates
>>          -Enable interrupts
>>          -Release DC lock
>>
>> v2:
>> -Formatting
>> -Release dc_state
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Looks good to me now.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> 
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 182 +++++++++++++++++-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>>   2 files changed, 182 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 60fe64aef11b..4110ff8580b7 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1521,10 +1521,114 @@ static int dm_hw_fini(void *handle)
>>          return 0;
>>   }
>>
>> +
>> +static int dm_enable_vblank(struct drm_crtc *crtc);
>> +static void dm_disable_vblank(struct drm_crtc *crtc);
>> +
>> +static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>> +                                struct dc_state *state, bool enable)
>> +{
>> +       enum dc_irq_source irq_source;
>> +       struct amdgpu_crtc *acrtc;
>> +       int rc = -EBUSY;
>> +       int i = 0;
>> +
>> +       for (i = 0; i < state->stream_count; i++) {
>> +               acrtc = get_crtc_by_otg_inst(
>> +                               adev, state->stream_status[i].primary_otg_inst);
>> +
>> +               if (acrtc && state->stream_status[i].plane_count != 0) {
>> +                       irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
>> +                       rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
>> +                       DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
>> +                                 acrtc->crtc_id, enable ? "en" : "dis", rc);
>> +                       if (rc)
>> +                               DRM_WARN("Failed to %s pflip interrupts\n",
>> +                                        enable ? "enable" : "disable");
>> +
>> +                       if (enable) {
>> +                               rc = dm_enable_vblank(&acrtc->base);
>> +                               if (rc)
>> +                                       DRM_WARN("Failed to enable vblank interrupts\n");
>> +                       } else {
>> +                               dm_disable_vblank(&acrtc->base);
>> +                       }
>> +
>> +               }
>> +       }
>> +
>> +}
>> +
>> +enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
>> +{
>> +       struct dc_state *context = NULL;
>> +       enum dc_status res = DC_ERROR_UNEXPECTED;
>> +       int i;
>> +       struct dc_stream_state *del_streams[MAX_PIPES];
>> +       int del_streams_count = 0;
>> +
>> +       memset(del_streams, 0, sizeof(del_streams));
>> +
>> +       context = dc_create_state(dc);
>> +       if (context == NULL)
>> +               goto context_alloc_fail;
>> +
>> +       dc_resource_state_copy_construct_current(dc, context);
>> +
>> +       /* First remove from context all streams */
>> +       for (i = 0; i < context->stream_count; i++) {
>> +               struct dc_stream_state *stream = context->streams[i];
>> +
>> +               del_streams[del_streams_count++] = stream;
>> +       }
>> +
>> +       /* Remove all planes for removed streams and then remove the streams */
>> +       for (i = 0; i < del_streams_count; i++) {
>> +               if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
>> +                       res = DC_FAIL_DETACH_SURFACES;
>> +                       goto fail;
>> +               }
>> +
>> +               res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
>> +               if (res != DC_OK)
>> +                       goto fail;
>> +       }
>> +
>> +
>> +       res = dc_validate_global_state(dc, context, false);
>> +
>> +       if (res != DC_OK) {
>> +               DRM_ERROR("%s:resource validation failed, dc_status:%d\n", __func__, res);
>> +               goto fail;
>> +       }
>> +
>> +       res = dc_commit_state(dc, context);
>> +
>> +fail:
>> +       dc_release_state(context);
>> +
>> +context_alloc_fail:
>> +       return res;
>> +}
>> +
>>   static int dm_suspend(void *handle)
>>   {
>>          struct amdgpu_device *adev = handle;
>>          struct amdgpu_display_manager *dm = &adev->dm;
>> +       int ret = 0;
>> +
>> +       if (adev->in_gpu_reset) {
>> +               mutex_lock(&dm->dc_lock);
>> +               dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
>> +
>> +               dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
>> +
>> +               amdgpu_dm_commit_zero_streams(dm->dc);
>> +
>> +               amdgpu_dm_irq_suspend(adev);
>> +
>> +               return ret;
>> +       }
>>
>>          WARN_ON(adev->dm.cached_state);
>>          adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
>> @@ -1640,6 +1744,46 @@ static void emulated_link_detect(struct dc_link *link)
>>
>>   }
>>
>> +static void dm_gpureset_commit_state(struct dc_state *dc_state,
>> +                                    struct amdgpu_display_manager *dm)
>> +{
>> +       struct {
>> +               struct dc_surface_update surface_updates[MAX_SURFACES];
>> +               struct dc_plane_info plane_infos[MAX_SURFACES];
>> +               struct dc_scaling_info scaling_infos[MAX_SURFACES];
>> +               struct dc_flip_addrs flip_addrs[MAX_SURFACES];
>> +               struct dc_stream_update stream_update;
>> +       } * bundle;
>> +       int k, m;
>> +
>> +       bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
>> +
>> +       if (!bundle) {
>> +               dm_error("Failed to allocate update bundle\n");
>> +               goto cleanup;
>> +       }
>> +
>> +       for (k = 0; k < dc_state->stream_count; k++) {
>> +               bundle->stream_update.stream = dc_state->streams[k];
>> +
>> +               for (m = 0; m < dc_state->stream_status->plane_count; m++) {
>> +                       bundle->surface_updates[m].surface =
>> +                               dc_state->stream_status->plane_states[m];
>> +                       bundle->surface_updates[m].surface->force_full_update =
>> +                               true;
>> +               }
>> +               dc_commit_updates_for_stream(
>> +                       dm->dc, bundle->surface_updates,
>> +                       dc_state->stream_status->plane_count,
>> +                       dc_state->streams[k], &bundle->stream_update, dc_state);
>> +       }
>> +
>> +cleanup:
>> +       kfree(bundle);
>> +
>> +       return;
>> +}
>> +
>>   static int dm_resume(void *handle)
>>   {
>>          struct amdgpu_device *adev = handle;
>> @@ -1656,8 +1800,44 @@ static int dm_resume(void *handle)
>>          struct dm_plane_state *dm_new_plane_state;
>>          struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
>>          enum dc_connection_type new_connection_type = dc_connection_none;
>> -       int i, r;
>> +       struct dc_state *dc_state;
>> +       int i, r, j;
>> +
>> +       if (adev->in_gpu_reset) {
>> +               dc_state = dm->cached_dc_state;
>>
>> +               r = dm_dmub_hw_init(adev);
>> +               if (r)
>> +                       DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>> +
>> +               dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>> +               dc_resume(dm->dc);
>> +
>> +               amdgpu_dm_irq_resume_early(adev);
>> +
>> +               for (i = 0; i < dc_state->stream_count; i++) {
>> +                       dc_state->streams[i]->mode_changed = true;
>> +                       for (j = 0; j < dc_state->stream_status->plane_count; j++) {
>> +                               dc_state->stream_status->plane_states[j]->update_flags.raw
>> +                                       = 0xffffffff;
>> +                       }
>> +               }
>> +
>> +               WARN_ON(!dc_commit_state(dm->dc, dc_state));
>> +
>> +               dm_gpureset_commit_state(dm->cached_dc_state, dm);
>> +
>> +               dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
>> +
>> +               dc_release_state(dm->cached_dc_state);
>> +               dm->cached_dc_state = NULL;
>> +
>> +               amdgpu_dm_irq_resume_late(adev);
>> +
>> +               mutex_unlock(&dm->dc_lock);
>> +
>> +               return 0;
>> +       }
>>          /* Recreate dc_state - DC invalidates it when setting power state to S3. */
>>          dc_release_state(dm_state->context);
>>          dm_state->context = dc_create_state(dm->dc);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 3f0c6298b588..40c912e0bf0c 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -315,6 +315,7 @@ struct amdgpu_display_manager {
>>   #endif
>>
>>          struct drm_atomic_state *cached_state;
>> +       struct dc_state *cached_dc_state;
>>
>>          struct dm_comressor_info compressor;
>>
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
