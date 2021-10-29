Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C3E6101E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58C3E6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2136EA80;
	Fri, 29 Oct 2021 20:24:17 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AE76EA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:24:16 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 x27-20020a9d459b000000b0055303520cc4so15138164ote.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 13:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z0OHok40IE/aJnONgLW39Y3sQEXyJd9E0JBl4IcAfpE=;
 b=IcYOBnHmjKipV16cLyiGoU+4TpO/XchSg2pKLRJP4l6LwyCWQrtAK+5Z4yahtgg5RF
 RmTSXSuJ0rlZCog5FMuvMOPmWf4nDvmf3L50eHZRt4BPNFq1DFThECZQKgFFe/h3od5v
 IS5b5PZkENE9Ev6ZVex3s9Xn6+Y6FVLWprcRvYbKVR7MRT8EgYEx1eYoy1BLmcamGQXI
 OLrbLhgpzKFRqHcX35HfIGfzwGDx0Hyon3d+OaHJDLnTsxr9aLjTuScX2246YliBbqnc
 SvYUf1lBUGAv5SxG7Kw5An2keDvOCzcxh2teYQXqn2IrPVY3osgYuPNqI6W675WUob3K
 QKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z0OHok40IE/aJnONgLW39Y3sQEXyJd9E0JBl4IcAfpE=;
 b=El6Upsg4PgsYMuSyPpW8ZJwuIVAFYxDO2wgkllg1aYwJZ4j4IcQzr7c1erxV0TPR/U
 s1RhU5+aIerXf80LpiUReuHcjpueSFcWBM2SGLX8nn2+SQtTG1h3ol56euWvJh9DGPkx
 CbS6Dn9ouVXa/xW9AnKj4N5K5Hh97+ncjL7XoIefomQzigzHSUW1SfQT9/pGyVcAyPAJ
 +cizbjWHMBQ37UaC8EIlXVKuheJrslJurpyqWa1CBmJYvdVMmbnATapcCdeHq1TR8Z/q
 D7bKSh6wtlwJYSF155p1pgBovvnMgWljBMSeHUUhI37LyvlJRKaPqHbSlT0QRK/FyJ02
 U8qQ==
X-Gm-Message-State: AOAM530LsOgOyTID09pPqrMnJU/II8F6UKI1ZVl+ByKj8ber6vhI3eA6
 sh0VV/AwX6uWguwKfjN8nis3XNzvzU8OxIB0Cq1HnOdYUFz/BA==
X-Google-Smtp-Source: ABdhPJyhfyZpV8cQhpcceU71PRlTkgowbDmGYTbqMO2M4Lelv6yW8ScKsilgg+kbwegIizRyJv5w+JGpqzdY73xxN7A=
X-Received: by 2002:a9d:61d9:: with SMTP id h25mr10488233otk.357.1635539055681; 
 Fri, 29 Oct 2021 13:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211029201156.17595-1-mario.limonciello@amd.com>
 <CADnq5_PJ1W0Hd72yiLrZAq2t4WkdvkhNJfwohd22naJ7h=Tbkw@mail.gmail.com>
In-Reply-To: <CADnq5_PJ1W0Hd72yiLrZAq2t4WkdvkhNJfwohd22naJ7h=Tbkw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Oct 2021 16:24:04 -0400
Message-ID: <CADnq5_PEzdQ7EREkQ=LE1P8L1cbAESxmAHg1FkvkBhpE=FDDwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Roman Li <Roman.Li@amd.com>
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

On Fri, Oct 29, 2021 at 4:19 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Oct 29, 2021 at 4:12 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
> > asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
> > implied a new dependency on newer firmware which might not be met on older
> > kernel versions.
> >
> > Since sw_init runs before hw_init, there is an opportunity to determine
> > whether or not the firmware version is new to adjust the behavior.
> >
> > Cc: Roman.Li@amd.com
> > BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
> > BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
> > Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Actually if there are version differences between renoir and green
sardine, maybe we need to bring back the old logic.  E.g.,
if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
    init_data.flags.disable_dmcu = true;
else
    init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;

Alex

>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 6dd6262f2769..85b3de97f870 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1410,7 +1410,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
> >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> >                 case IP_VERSION(2, 1, 0):
> >                         init_data.flags.gpu_vm_support = true;
> > -                       init_data.flags.disable_dmcu = true;
> > +                       init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;
> >                         break;
> >                 case IP_VERSION(1, 0, 0):
> >                 case IP_VERSION(1, 0, 1):
> > --
> > 2.25.1
> >
