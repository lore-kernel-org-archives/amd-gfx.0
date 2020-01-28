Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9071C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0F4214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+UtAuWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0F4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1326E0EF;
	Tue, 28 Jan 2020 17:27:05 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486AE6E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 17:27:04 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q9so3391524wmj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3zogbKQf9hCrfx0vdvGmTPxBX3hmSPCdmrtOO2nSbW8=;
 b=q+UtAuWVhlXHMXAFXdv/M4ipp0bHVggAGY7t3ojEp4lXqk6eHY5d7hP/fxApegGQRu
 uxLS1jJYZPmBurB/fWYcM2Eqt6gnKFii3u+GoJKqenn1//g07OYMZXwbb9Mo70oNu131
 a1xN29RRHFwV3oF4xIGUP2pXkym8udkogpqmSx5xH669CN+vv7tuvgfQI3g44Se3nDtY
 kjT+Deetlss0gawEYnjzQxyLC3Sb7c2SBXeF4vP2l4WovbxiAhNR5hHQEE59Ynxwh8ht
 XVT1oT97NKweMMcRIhAhH1EA1MKAGqWYqiQdw9k7W1VAhAb+CQeKSDijGFjvVDrQv6R2
 29xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3zogbKQf9hCrfx0vdvGmTPxBX3hmSPCdmrtOO2nSbW8=;
 b=iJft8TlLDdRPXLiNmtNDj9DlZZfoRYPNPpwLUkBuLUMXPEwrPvpa0MNEwGH4JZ4MxK
 HMk1kEXk7ThQgc/xrdIuxDoPx32H9/WGc1bGoCEP5VQUrR++a6bNB3hSmhpzjN64EMog
 snRTeceGJC1b9nVSCwoN886eZEMQVHCRiAPLM/xt6dwBvhjSpW3TJ/QPQQuaQsmNueEI
 lGxTamcP/qEzYpDZBwm0uWfKQA7xFvxf8M7HnqcNMKSWvtgovvpez8eX7oryq7LopkUo
 U+PtyPQBvbEfAP9r5v7WVXkvXrG9HZnfzj+QA+A3JeTNDui7vcXX2UAakEQxS2ZOdF1j
 iKIg==
X-Gm-Message-State: APjAAAVXVAGrhmnIozvnGNLXIR6EE/8X/r/SbW19SblOVfRhqFofvNyf
 g4uGheivHlNC/Cm+wAoGXnKIV7iBgWbv3owQ+jrlNA==
X-Google-Smtp-Source: APXvYqzeKp3KoLfS273clqrAz694JK1WcPDq/p/WPHou0iipMmDihZzq+zlccxhPMBACz9j20ZZMtC9vKra6gFKC6JI=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr6188292wmb.73.1580232423004;
 Tue, 28 Jan 2020 09:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20200125184845.4233-1-alexander.deucher@amd.com>
 <20200125184845.4233-3-alexander.deucher@amd.com>
 <f51f32b5-9a08-bb30-66e9-52bddb8f469c@gmail.com>
In-Reply-To: <f51f32b5-9a08-bb30-66e9-52bddb8f469c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 12:26:51 -0500
Message-ID: <CADnq5_NUjjtf_kSut0doWRoRUOqi-OrN=M8=3=sf3JoYiCuuwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/navi10: add OD support for restoring
 default table
To: Matt Coffin <mcoffin13@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 28, 2020 at 11:44 AM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> For this, I believe we're updating `table_context->overdrive_table` with
> the values set by the user, wouldn't the intended behavior here be to
> restore the settings that were there on boot?
>

Correct.

>
>
> If so, I think we'd have to cache the overdrive table that was there on
> boot, and use that in the response for `PP_OD_RESTORE_DEFAULT_TABLE`, no?
>
>
>
> I'm doing some testing on this patchset, but on initial lookover that's
> the only thing I saw. I could be mistaken, but I think this just writes
> the overdrive table that we are currently using over again instead of
> writing the default one.

I just copied that vega20 did.  You may be right.  I haven't paged the
recent SMU interface stuff into my head in a while.  If so, we should
also fix the vega20_ppt.c code.

Thanks!

Alex

>
> On 1/25/20 11:48 AM, Alex Deucher wrote:
> > Was missing before.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > index d2d45181ae23..f60762f9b143 100644
> > --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> > @@ -2062,6 +2062,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
> >               if (ret)
> >                       return ret;
> >               od_table->UclkFmax = input[1];
> > +             break;
> > +     case PP_OD_RESTORE_DEFAULT_TABLE:
> > +             ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> > +             if (ret) {
> > +                     pr_err("Failed to export over drive table!\n");
> > +                     return ret;
> > +             }
> > +
> >               break;
> >       case PP_OD_COMMIT_DPM_TABLE:
> >               navi10_dump_od_table(od_table);
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
