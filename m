Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E323C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 13:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D5C60F39
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 13:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32D5C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3616ED0F;
	Thu, 23 Sep 2021 13:06:39 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCE56ED0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 13:06:39 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 5-20020a9d0685000000b0054706d7b8e5so8434986otx.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PazrWcvTjYGi+f+dZNL/PXJ7uqqlEG9JlrJoOqf6Qpk=;
 b=e1T996Xo3PX7EJcdwuap54qP6Rz5VrJlu6IP+EFjtF0DG2slN+UPkG5AuPn3bvG0bq
 UFTf4O8y2dotsKVhtRFKUSU45I5u6KsrUNWs+P1MFA52MTxswmDTO1S4U3qPZokepXMt
 mcVD5lqLYBesUXTy4Lm0D1396Hb6zKOvCEmMh/NDdjpBotutJ0oiCI4TLkkfe/kQ1FX/
 4jcPVOuIvt1T+jYTGNsKQDJJUp+dns0HzJIcZrAi0YUFrE3j2kBB612Ep67XCrD/ezBA
 4bS4j+uJ8+pZ19APCcalJl4qmxQVUeK/NOpvfjPe0Y1jzVcUPmwgf+xnJ1Gl45uXDPZp
 q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PazrWcvTjYGi+f+dZNL/PXJ7uqqlEG9JlrJoOqf6Qpk=;
 b=ouXvbeGDqWQC+0oe95i7iu/7Odg8neS+5MdCNWwDXikAECz79ZjeAfE87dE1Jhp5YT
 23T1iVc28mazoi/eQ05xi56j7Dsb43Buv8Fo9aZfmRsPoBBShvERc2bYoSbRDrA7SXza
 rCYcftA2L8w/iu/DmNWpXcvwiZV5okVf28x2HKOB0xyq64ANJAzJ3g3cDCEvvmqG1CM6
 NBcjbIc89ggzBbk3KbSlQZCI8XaZtulAZoMzMtGBdhCyZSD5Mk5yQ6oltnNmwVi0nU2S
 Ld3g5+yIeUz5paQoYCwq+woRTo4gc55OIBHvRhhzvMGk43+NE3eR8Vf6Lqu8hSChWo/l
 lobg==
X-Gm-Message-State: AOAM5318F9/pWFuWfbkNYS18cqRaMIxvbgYUXPveXYYSsSj3jtuU/yuX
 Oqr2706Cvj3TG0RCo0gSVY/VjN1FIMhkblqAS7OgUgmT
X-Google-Smtp-Source: ABdhPJww9JX7hirrzHEte5UswK3cEbPcHKfG72/LxnqdHZG2sI0ae9veI9xffvCRKQlNJL4Hjt8O1EkE+EoYMZqOfQA=
X-Received: by 2002:a05:6830:2704:: with SMTP id
 j4mr4256607otu.299.1632402398350; 
 Thu, 23 Sep 2021 06:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210923042937.16385-1-lijo.lazar@amd.com>
 <CADnq5_NBP4ZGJ+gzDuWoiTMu8iD1yQ8N--QxGDzmb6-C82aJ2g@mail.gmail.com>
 <DM6PR12MB39301B88CEF191051CE6028397A39@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39301B88CEF191051CE6028397A39@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Sep 2021 09:06:27 -0400
Message-ID: <CADnq5_N9jzHGKXyyYcPaBhYQ+78tMFh7Dv0hqvJ0p45_jvTrjA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Update intermediate power state for SI
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 23, 2021 at 9:04 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Alex,
>
> "Fixes" tag - I interpret it as fixes some broken logic in the earlier patch. This one doesn't fix f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)"). That patch's logic works well and is fine as it is.
>
> May be add a reference or some more details in the comments?

yeah, probably skip that fixes tag.  I suspect this bug was there from
when dpm support was first added for SI if you want to dig up that
commit, otherwise, I can just send it out for stable as is with the
bug reference.

Alex


>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, September 23, 2021 6:21 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Update intermediate power state for SI
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Fixes: f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)")
>
> Thanks!
>
> On Thu, Sep 23, 2021 at 12:30 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
> >
> > Update the current state as boot state during dpm initialization.
> > During the subsequent initialization, set_power_state gets called to
> > transition to the final power state. set_power_state refers to values
> > from the current state and without current state populated, it could
> > result in NULL pointer dereference.
> >
> > Bug:https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > gitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1698&amp;data=04%7C0
> > 1%7Clijo.lazar%40amd.com%7C8a10ba2a0d7d4896ed1408d97e90d3cc%7C3dd8961f
> > e4884e608e11a82d994e183d%7C0%7C0%7C637679982775776349%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> > 0%3D%7C1000&amp;sdata=gTpG97DwoTSYBTN%2BSZYiAAL4o1VjG5n%2BaHu65s%2BADG
> > E%3D&amp;reserved=0
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> > index bdbbeb959c68..81f82aa05ec2 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> > @@ -6867,6 +6867,8 @@ static int si_dpm_enable(struct amdgpu_device *adev)
> >         si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
> >         si_thermal_start_thermal_controller(adev);
> >
> > +       ni_update_current_ps(adev, boot_ps);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.17.1
> >
