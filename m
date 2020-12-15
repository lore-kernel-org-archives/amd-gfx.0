Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CBC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17792255F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17792255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA166E3F7;
	Tue, 15 Dec 2020 15:51:23 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411FD6E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 15:51:22 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id b24so2295263otj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qSE8ZXqSYA1eNXc7k0UndW9BwjCEDLY1saGS6vnBF3k=;
 b=trX67BFB27FJYvRH6iSo8mz5xvRWHIkhGb/cndX2mZZAxq8Q0EFx1hIqYhwyiRSHNq
 4xmxv96nWWPEUvL1rOXGz+40aIcuqAPFchiqXvo9Di/cq0OUJsgZk9c6B8tiPtvK4b7J
 P+Bee2cB44+feSRankBK7T52zF0sa/PZJ0irhOCAAh/ruDwRxbxdHHrVsjOMIc8YAv2+
 hldXe09CJhmQfyoc0rZ5Zxiq4QQN/ZdsO7I8jHUv8l/GREZ5KuWHJfX/Z1v1k4wqprXH
 RuFkU78tMH43NpnZLogoev2AUTvNhlBzYkOKJzdwM6HhhrEAH33XWqMSk6c5AhVsl475
 uPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qSE8ZXqSYA1eNXc7k0UndW9BwjCEDLY1saGS6vnBF3k=;
 b=hGvLCwYWHs65OK8Xq17z51bRyjpdc7qdECDJZG5LHFeBCLK9IwoGny6esSiEYulIsJ
 ANVnsUo04Smki5iiU0CF7VLD9kvUOlmBzmF6ZtBjjsO5gishGugHarP5YnWSAd6DAauV
 4l8STLrWclValfPgXQTkrmxM9Xv+8hyFwncwd+B9g25nQy890y0MkCM4FaVAmcozH0VA
 M6efs63e2o99R1+MH42soUfycArN/FzSXqQE3iLJo+g5Vw4gQnWQCDXxwuGlmnyUD2kb
 dULrdn95j6i8xqEnbLqTt4jyadz5N7eMPy87ZKcC/JuggZ0E4H6DjEaxI3eZKF8Zt7AQ
 f7fw==
X-Gm-Message-State: AOAM532pcM0CHD0cvbgm6utZM8CZXWUwXQHqqNzoou6qAd9Rv9/0X1ds
 lT+BQ6UFtp5sIMsNTMUn9VOMx5lV8FVBSgy+ncsi934ibzM=
X-Google-Smtp-Source: ABdhPJy5B7G6xO7zA7cn13n4Ck5Td7SzQQORFDVEUT9WyWiJG5nlSjw3M3BfwKqhb6oCdbfQPtUXIZrrYvDmArS/PgY=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr23736177otg.311.1608047481581; 
 Tue, 15 Dec 2020 07:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20201211155553.GC25974@zn.tnic>
 <CADnq5_MHqWqOd5ZngitF4UUDoZsh+fPrYJtHpJMbJdjAhFfhew@mail.gmail.com>
 <20201215154948.3muy72twmmstd3a3@outlook.office365.com>
In-Reply-To: <20201215154948.3muy72twmmstd3a3@outlook.office365.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Dec 2020 10:51:10 -0500
Message-ID: <CADnq5_Nere729YJ0KWWjc16RtESS=smjAkCtF4_XMGaeyHPVWw@mail.gmail.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Tony Cheng <Tony.Cheng@amd.com>, Chiawen Huang <chiawen.huang@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 10:49 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> Hi Alex,
>
> I made the below patch that might fix the issue; I need to hear Boris's
> feedback first. Alex, did you already revert it?

I have not reverted it yet.

Alex

>
> * https://patchwork.freedesktop.org/series/84965/
>
> Thanks
>
> On 12/14, Alex Deucher wrote:
> > On Fri, Dec 11, 2020 at 11:49 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > Hi,
> > >
> > > patch in $Subject breaks booting on a laptop here, GPU details are
> > > below. The machine stops booting right when it attempts to switch modes
> > > during boot, to a higher mode than the default VGA one. Machine doesn't
> > > ping and is otherwise unresponsive so that a hard reset is the only
> > > thing that helps.
> > >
> > > Reverting that patch ontop of -rc7 fixes it and the machine boots just fine.
> >
> > + a few more display folks
> >
> > This patch looks like a correctness fix, but not critical.  Unless
> > anyone has a proper fix handy, I'll just revert it for now and we can
> > revisit it properly.
> >
> > Alex
> >
> >
> > >
> > > Thx.
> > >
> > > [    1.628086] ata1.00: supports DRM functions and may not be fully accessible
> > > [    1.632050] ata1.00: supports DRM functions and may not be fully accessible
> > > [    1.895818] [drm] amdgpu kernel modesetting enabled.
> > > [    1.897628] [drm] initializing kernel modesetting (CARRIZO 0x1002:0x9874 0x103C:0x807E 0xC4).
> > > [    1.898256] [drm] register mmio base: 0xD0C00000
> > > [    1.898422] [drm] register mmio size: 262144
> > > [    1.898583] [drm] add ip block number 0 <vi_common>
> > > [    1.898759] [drm] add ip block number 1 <gmc_v8_0>
> > > [    1.898931] [drm] add ip block number 2 <cz_ih>
> > > [    1.899082] [drm] add ip block number 3 <gfx_v8_0>
> > > [    1.899241] [drm] add ip block number 4 <sdma_v3_0>
> > > [    1.899439] [drm] add ip block number 5 <powerplay>
> > > [    1.899573] [drm] add ip block number 6 <dm>
> > > [    1.899693] [drm] add ip block number 7 <uvd_v6_0>
> > > [    1.899827] [drm] add ip block number 8 <vce_v3_0>
> > > [    1.911458] [drm] BIOS signature incorrect 5b 7
> > > [    1.912551] [drm] UVD is enabled in physical mode
> > > [    1.912707] [drm] VCE enabled in physical mode
> > > [    1.912921] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
> > > [    1.913837] [drm] Detected VRAM RAM=512M, BAR=512M
> > > [    1.913998] [drm] RAM width 128bits UNKNOWN
> > > [    1.915149] [drm] amdgpu: 512M of VRAM memory ready
> > > [    1.915306] [drm] amdgpu: 3072M of GTT memory ready.
> > > [    1.915468] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > > [    1.916139] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
> > > [    1.918733] [drm] Found UVD firmware Version: 1.91 Family ID: 11
> > > [    1.918950] [drm] UVD ENC is disabled
> > > [    1.919680] [drm] Found VCE firmware Version: 52.4 Binary ID: 3
> > > [    1.925963] [drm] DM_PPLIB: values for Engine clock
> > > [    1.926106] [drm] DM_PPLIB:   300000
> > > [    1.926205] [drm] DM_PPLIB:   360000
> > > [    1.926304] [drm] DM_PPLIB:   423530
> > > [    1.926404] [drm] DM_PPLIB:   514290
> > > [    1.926516] [drm] DM_PPLIB:   626090
> > > [    1.926629] [drm] DM_PPLIB:   720000
> > > [    1.926743] [drm] DM_PPLIB: Validation clocks:
> > > [    1.926952] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.927117] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.927281] [drm] DM_PPLIB:    level           : 8
> > > [    1.927435] [drm] DM_PPLIB: values for Display clock
> > > [    1.927594] [drm] DM_PPLIB:   300000
> > > [    1.927708] [drm] DM_PPLIB:   400000
> > > [    1.927822] [drm] DM_PPLIB:   496560
> > > [    1.927936] [drm] DM_PPLIB:   626090
> > > [    1.928048] [drm] DM_PPLIB:   685720
> > > [    1.928161] [drm] DM_PPLIB:   757900
> > > [    1.928275] [drm] DM_PPLIB: Validation clocks:
> > > [    1.928419] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.928584] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.928748] [drm] DM_PPLIB:    level           : 8
> > > [    1.928901] [drm] DM_PPLIB: values for Memory clock
> > > [    1.929058] [drm] DM_PPLIB:   333000
> > > [    1.929172] [drm] DM_PPLIB:   800000
> > > [    1.929403] [drm] DM_PPLIB: Validation clocks:
> > > [    1.929549] [drm] DM_PPLIB:    engine_max_clock: 72000
> > > [    1.929716] [drm] DM_PPLIB:    memory_max_clock: 80000
> > > [    1.929919] [drm] DM_PPLIB:    level           : 8
> > > [    1.930148] [drm] Display Core initialized with v3.2.104!
> > > [    2.003938] [drm] UVD initialized successfully.
> > > [    2.204023] [drm] VCE initialized successfully.
> > > [    2.206228] [drm] fb mappable at 0xA0EE4000
> > > [    2.206375] [drm] vram apper at 0xA0000000
> > > [    2.206514] [drm] size 14745600
> > > [    2.206654] [drm] fb depth is 24
> > > [    2.206760] [drm]    pitch is 10240
> > > [    2.207123] fbcon: amdgpudrmfb (fb0) is primary device
> > > [    2.301263] amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb frame buffer device
> > > [    2.320735] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:00:01.0 on minor 0
> > >
> > >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Cpb2l3OjKBeFwx%2FHIf%2F0d%2BSFiJL46p7Bct3JAIThSZ8%3D&amp;reserved=0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C36709b101b6e4c353e7e08d8a07a1d89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435793657547591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=XdoPAac6FCjulOvtOsdzO4rh5Qd9wwNIi%2B%2F5lvkaUoI%3D&amp;reserved=0
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
