Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666CAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3BD10E2D0;
	Wed, 13 Dec 2023 14:17:15 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E684610E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 14:17:13 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f060e059a3so5225953fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702477033; x=1703081833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwwopG1pmZ2n3upcRHX7NHadWpkrg2UdfeITzRxKMpo=;
 b=d6kPZKHPZPZncpvKz/Z/CsmW3WbLz9zGxthn14fZglBs6f4yob8e+BXp1szb7n45HI
 PVSGdGXMhclS5foleHFg7uzsTJmJkNp3lG4dmEWVj5iwuDPtCo5PNxSzjJ3oXMY3Mv9h
 Ma+tww4l1kxCEl4BUMzylLICX5c5fLl+25HjhDx5TmMBaZxZbtev8m3hvdZLU+AWScov
 aaQNtTZoLmHfzDjHylWlON5kftoJ+Q+mvx6QNv69XHWS58CE+mEX+lgFu0ztLjv4y69n
 WNspR0kZVWJ9ugYr9o6oY1oGbO6eXhNi+VnFEQezoSg54zxE2LFqjcBaIE1u6G7ViXpm
 qO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702477033; x=1703081833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwwopG1pmZ2n3upcRHX7NHadWpkrg2UdfeITzRxKMpo=;
 b=khi62Tei6ptlKieasf6hbhG0x/IkOjW2TN7BEKn2Pk8etMizVW+vhWdVms/G2qb5Tj
 UjCP5vFMw0QJRSH3lFGlr92k0oO5KJbTF3QPxJUG+Tdy1NPJ34lyMdt3NQCXOnZR9GTX
 O1VYhCuzB97jrQ7F5wGiFCOagEceJeMR3BVAw35LEj56JWI+ayj4RPJ3sLZvrnnI8ExT
 mcMtECI3dFH5+gYcToH3HQ0tM8h877Bvhdhh5+AJlDrAkwF0S8cG/ZUTINzVvHsj3wC1
 98sbAcNFYk6/rVPremgik4GqjCtQ7htwVmhbR+5zmFuRJAPkXAqX7DIl7iVYEIcRoCvz
 hoTA==
X-Gm-Message-State: AOJu0YxkHM++gXsCVdtnRz41SZ7XW4uigHLRnmmXhPSrgjlxMjyQ3J7m
 Wuld11BG29N6/CbroKE49tsgNz1tU4KqXgoOZ58=
X-Google-Smtp-Source: AGHT+IHiQYT1aI9+To0TcbM6Qafqu2xfpE2tdsbWAIxcqq2YLIoMek0twPV0WrR2DFdS4UwMQgbDEvvvs/HDqYZbS4Q=
X-Received: by 2002:a05:6870:9123:b0:1fb:75c:3ff3 with SMTP id
 o35-20020a056870912300b001fb075c3ff3mr10876097oae.83.1702477032855; Wed, 13
 Dec 2023 06:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
 <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
 <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
 <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
 <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
In-Reply-To: <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 09:17:01 -0500
Message-ID: <CADnq5_NtVufiPfTyLS-pDKcqkU9uEu23=bEasoQvy6iOQ-9snA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Linux Regressions <regressions@lists.linux.dev>,
 Oliver Schmidt <oliver@luced.de>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 12, 2023 at 9:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/12/2023 18:08, Oliver Schmidt wrote:
> > Hi Wayne,
> >
> > On 12.12.23 17:06, Mario Limonciello wrote:
> >> I looked through your bugs related to this and I didn't see a referenc=
e to the
> >> specific docking station model.
> >> The logs mentioned "Thinkpad dock" but no model.
> >> Could you share more about it so that AMD can try to reproduce it?
> >
> > Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see=
 also
> > https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-dock=
ing-station-overview-and-service-parts
> >
>
> By chance do you have access to any other dock or monitor combinations
> that you can conclude it only happens on this dock or only a certain
> monitor, or only a certain monitor connected to this dock?

IIRC, Wayne's patch was to fix an HP dock, I suspect reverting this
will just break one dock to fix another.  Wayne, do you have the other
problematic dock that this patch was needed to fix or even the
thinkpad dock?  Would be nice to properly sort this out if possible.

Alex

>
> > Best regards,
> > Oliver
> >
> > On 12.12.23 17:06, Mario Limonciello wrote:
> >> On 12/12/2023 04:10, Lin, Wayne wrote:
> >>> [Public]
> >>>
> >>> Hi Mario,
> >>>
> >>> Thanks for the help.
> >>> My feeling is like this problem probably relates to specific dock. Ne=
ed time
> >>> to take
> >>> further look.
> >>
> >> Oliver,
> >>
> >> I looked through your bugs related to this and I didn't see a referenc=
e to the
> >> specific docking station model.
> >> The logs mentioned "Thinkpad dock" but no model.
> >>
> >> Could you share more about it so that AMD can try to reproduce it?
> >>
> >>>
> >>> Since reverting solves the issue now, feel free to add:
> >>> Acked-by: Wayne Lin <wayne.lin@amd.com>
> >>
> >> Sure, thanks.
> >>
> >>>
> >>> Thanks,
> >>> Wayne
> >>>
> >>>> -----Original Message-----
> >>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>> Sent: Tuesday, December 12, 2023 12:15 AM
> >>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
> >>>> <Harry.Wentland@amd.com>
> >>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.ker=
nel.org;
> >>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
> >>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
> >>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume =
flow"
> >>>>
> >>>> Ping on this one.
> >>>>
> >>>> On 12/5/2023 13:54, Mario Limonciello wrote:
> >>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
> >>>>>
> >>>>> Reports are that this causes problems with external monitors after
> >>>>> wake up from suspend, which is something it was directly supposed t=
o help.
> >>>>>
> >>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> >>>>> Cc: Wayne Lin <wayne.lin@amd.com>
> >>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
> >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218211
> >>>>> Link:
> >>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-=
aft
> >>>>> er-suspend/151840
> >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello
> >>>>> <mario.limonciello@amd.com>
> >>>>> ---
> >>>>>     .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++---------=
-----
> >>>> --
> >>>>>     1 file changed, 13 insertions(+), 80 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> index c146dc9cba92..1ba58e4ecab3 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
> >>>>>       return detect_mst_link_for_all_connectors(adev_to_drm(adev));
> >>>>>     }
> >>>>>
> >>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mg=
r
> >>>>> *mgr) -{
> >>>>> -   int ret;
> >>>>> -   u8 guid[16];
> >>>>> -   u64 tmp64;
> >>>>> -
> >>>>> -   mutex_lock(&mgr->lock);
> >>>>> -   if (!mgr->mst_primary)
> >>>>> -           goto out_fail;
> >>>>> -
> >>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
> >>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
> >>>>> -                            DP_MST_EN |
> >>>>> -                            DP_UP_REQ_EN |
> >>>>> -                            DP_UPSTREAM_IS_SRC);
> >>>>> -   if (ret < 0) {
> >>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   /* Some hubs forget their guids after they resume */
> >>>>> -   ret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> >>>>> -   if (ret !=3D 16) {
> >>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   if (memchr_inv(guid, 0, 16) =3D=3D NULL) {
> >>>>> -           tmp64 =3D get_jiffies_64();
> >>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
> >>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
> >>>>> -
> >>>>> -           ret =3D drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
> >>>>> -
> >>>>> -           if (ret !=3D 16) {
> >>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
> >>>> undocked during suspend?\n");
> >>>>> -                   goto out_fail;
> >>>>> -           }
> >>>>> -   }
> >>>>> -
> >>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
> >>>>> -
> >>>>> -out_fail:
> >>>>> -   mutex_unlock(&mgr->lock);
> >>>>> -}
> >>>>> -
> >>>>>     static void s3_handle_mst(struct drm_device *dev, bool suspend)
> >>>>>     {
> >>>>>       struct amdgpu_dm_connector *aconnector;
> >>>>>       struct drm_connector *connector;
> >>>>>       struct drm_connector_list_iter iter;
> >>>>>       struct drm_dp_mst_topology_mgr *mgr;
> >>>>> +   int ret;
> >>>>> +   bool need_hotplug =3D false;
> >>>>>
> >>>>>       drm_connector_list_iter_begin(dev, &iter);
> >>>>>       drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
> >>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
> >>>> suspend)
> >>>>>                       if (!dp_is_lttpr_present(aconnector->dc_link)=
)
> >>>>>                               try_to_configure_aux_timeout(aconnect=
or-
> >>>>> dc_link->ddc,
> >>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
> >>>>>
> >>>>> -                   /* TODO: move resume_mst_branch_status() into
> >>>> drm mst resume again
> >>>>> -                    * once topology probing work is pulled out fro=
m mst
> >>>> resume into mst
> >>>>> -                    * resume 2nd step. mst resume 2nd step should =
be
> >>>> called after old
> >>>>> -                    * state getting restored (i.e.
> >>>> drm_atomic_helper_resume()).
> >>>>> -                    */
> >>>>> -                   resume_mst_branch_status(mgr);
> >>>>> +                   ret =3D drm_dp_mst_topology_mgr_resume(mgr, tru=
e);
> >>>>> +                   if (ret < 0) {
> >>>>> +
> >>>>         dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> >>>>> +                                   aconnector->dc_link);
> >>>>> +                           need_hotplug =3D true;
> >>>>> +                   }
> >>>>>               }
> >>>>>       }
> >>>>>       drm_connector_list_iter_end(&iter);
> >>>>> +
> >>>>> +   if (need_hotplug)
> >>>>> +           drm_kms_helper_hotplug_event(dev);
> >>>>>     }
> >>>>>
> >>>>>     static int amdgpu_dm_smu_write_watermarks_table(struct
> >>>> amdgpu_device
> >>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
> >>>>>       struct dm_atomic_state *dm_state =3D to_dm_atomic_state(dm-
> >>>>> atomic_obj.state);
> >>>>>       enum dc_connection_type new_connection_type =3D
> >>>> dc_connection_none;
> >>>>>       struct dc_state *dc_state;
> >>>>> -   int i, r, j, ret;
> >>>>> -   bool need_hotplug =3D false;
> >>>>> +   int i, r, j;
> >>>>>
> >>>>>       if (dm->dc->caps.ips_support) {
> >>>>>               dc_dmub_srv_exit_low_power_state(dm->dc);
> >>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
> >>>>>                       continue;
> >>>>>
> >>>>>               /*
> >>>>> -            * this is the case when traversing through already cre=
ated end
> >>>> sink
> >>>>> +            * this is the case when traversing through already cre=
ated
> >>>>>                * MST connectors, should be skipped
> >>>>>                */
> >>>>>               if (aconnector && aconnector->mst_root) @@ -3017,27
> >>>> +2971,6 @@
> >>>>> static int dm_resume(void *handle)
> >>>>>
> >>>>>       dm->cached_state =3D NULL;
> >>>>>
> >>>>> -   /* Do mst topology probing after resuming cached state*/
> >>>>> -   drm_connector_list_iter_begin(ddev, &iter);
> >>>>> -   drm_for_each_connector_iter(connector, &iter) {
> >>>>> -           aconnector =3D to_amdgpu_dm_connector(connector);
> >>>>> -           if (aconnector->dc_link->type !=3D dc_connection_mst_br=
anch
> >>>> ||
> >>>>> -               aconnector->mst_root)
> >>>>> -                   continue;
> >>>>> -
> >>>>> -           ret =3D drm_dp_mst_topology_mgr_resume(&aconnector-
> >>>>> mst_mgr, true);
> >>>>> -
> >>>>> -           if (ret < 0) {
> >>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
> >>>>> dc_link->ctx,
> >>>>> -                                   aconnector->dc_link);
> >>>>> -                   need_hotplug =3D true;
> >>>>> -           }
> >>>>> -   }
> >>>>> -   drm_connector_list_iter_end(&iter);
> >>>>> -
> >>>>> -   if (need_hotplug)
> >>>>> -           drm_kms_helper_hotplug_event(ddev);
> >>>>> -
> >>>>>       amdgpu_dm_irq_resume_late(adev);
> >>>>>
> >>>>>       amdgpu_dm_smu_write_watermarks_table(adev);
> >>>
> >>
>
