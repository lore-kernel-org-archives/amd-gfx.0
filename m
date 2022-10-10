Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F002BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 20:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B5710E6DE;
	Mon, 10 Oct 2022 20:05:32 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BEC10E6DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 20:05:30 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1326637be6eso13606040fac.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMy48WEPSHI4WpuP6HY1mUNGQM8kiZYDwBlc5kM/aZ8=;
 b=afGUN72DZfVxhiXBEc0OergFsOyMLWmxX9ziFUyS/dTOMou0alEcOG5VFWwaGGULQX
 1Tga5ABBFWaNXPDfGIcmtTfTlrcT8Fv9PNzIpuXVib2rPBfawT1tQvm/hrP3jRj3Ckw+
 uUwlbNfVdU7kD0cEzEn1zzGpe2eLKJS1HwFxi8akWGCQnciigXpn/YF3/yQZRw5tHn8N
 gAaaVJZmHqm6NoH7hqQa2oPge1WU52se1D7l8t0U8H/Y/89qRU59ekl3EGjoQjJYosRw
 YvHkltLR42D7Q5wo2hzms1AD+9WGTYLT9qVkNJPZYxyJdEchYxdO9/FETU1Nhe7Q6M0v
 atSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMy48WEPSHI4WpuP6HY1mUNGQM8kiZYDwBlc5kM/aZ8=;
 b=OnfQKm6vQVB9EYICwdyfr2qYu4SLJjVmNvz05ZvF6/u5y90u+JIHbnXrrzwmkSR6zo
 EIgQg0LBcb93opFjsrDWd2mFi7sdrC5DMWMcVLF0OtSERh8CAp/1KmVFXU179uZxrQCw
 LdtixzgjhzpCteCUI8d/WXuvU4wkJ91A9+kfVavsryjODPJ7MDsWMsIbnB8kryQRS3wt
 Vh1UowhwCiZeyCZcJGoDtqmacw0fmhPoB1I3Z4V2y6AgTgpDomH2Jj/sT6eGXE9RfxpU
 9BSNEjf1wcurUSPUg9dXt3YmNPZbrC5iyopOgEiW+FbZBjkhcaMcJLo78To0QZENe3Kb
 kxEA==
X-Gm-Message-State: ACrzQf1tU2W32FromLjZf2wptRfYAMoljO+89Z/BU/56BEczNjbQOTsF
 yP1dj7ytiq3HbG17ZB9AuIxmp0QI/CynUPv3Wf4=
X-Google-Smtp-Source: AMsMyM7I/pKUEcC6io0V20vDlbYQdBURa7lm7uFTwWx1zbO8Rz0Sp7cTf3g0gkvC6FtRaVqOYyOYVC385cFquLAZ26E=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr4658251oao.96.1665432329755; Mon, 10
 Oct 2022 13:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221004081402.49069-1-aleksei.kodanev@bell-sw.com>
 <20221004081402.49069-2-aleksei.kodanev@bell-sw.com>
 <DM6PR12MB26196DC660A86E363EC4ECD8E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26196DC660A86E363EC4ECD8E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Oct 2022 16:05:17 -0400
Message-ID: <CADnq5_P68bum9BP9fxdCC5bhwymX9C8dQXnzW0_JGERS6+Tm9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one
 overflow in 'performance_levels'
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, Oct 8, 2022 at 5:13 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Series is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Alexey Kodanev
> > Sent: Tuesday, October 4, 2022 4:14 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> > Subject: [PATCH 2/2] drm/amd/pm: smu7_hwmgr: fix potential off-by-one
> > overflow in 'performance_levels'
> >
> > Since 'hardwareActivityPerformanceLevels' is set to the size of the
> > 'performance_levels' array in smu7_hwmgr_backend_init(), using the '<='
> > assertion to check for the next index value is incorrect.
> > Replace it with '<'.
> >
> > Detected using the static analysis tool - Svace.
> > Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to
> > manager asics with smu ip version 7.")
> > Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > index e4fcbf8a7eb5..7ef7e81525a3 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -3603,7 +3603,7 @@ static int
> > smu7_get_pp_table_entry_callback_func_v1(struct pp_hwmgr *hwmgr,
> >                       return -EINVAL);
> >
> >       PP_ASSERT_WITH_CODE(
> > -                     (smu7_power_state->performance_level_count <=
> > +                     (smu7_power_state->performance_level_count <
> >                                       hwmgr-
> > >platform_descriptor.hardwareActivityPerformanceLevels),
> >                       "Performance levels exceeds Driver limit!",
> >                       return -EINVAL);
> > --
> > 2.25.1
>
