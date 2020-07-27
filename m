Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCEEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D095B206E7
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6PtcZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C82D89F5B;
	Mon, 27 Jul 2020 19:46:31 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C4A89F5B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 19:46:30 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f18so16058548wrs.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jGdm1awsl6pAFVIJltSCzTLDW1ARjkPs5Aru4vfQaIQ=;
 b=Jv6PtcZ2zgdQB7LbMNtPZGKqfAluzbqq1D8ysL9IwNw3ov7n240U3lkOI7tkygAuF7
 hDRulhawBD8oMNIfibYz9tZ2u5A8abQXzqGS6J10dxHAusvkJwSYVGDh0caI5sjhb8xs
 7EcDTV5w1G5DqRokDd5LHpLMUdPCUJfVrgSKpswlkMoXZP/65GgXLAZAX/bWu1Yjzv96
 7786/s3BNr+hGVpszIsaEv41IxE84Rth1yVoZGF56AGQ6bbPxK6jyqBibIQFqTToWPWx
 CPk6NQDpBBv7i/NSDwQjDzFXqPcDNS20G/1BDx3S1ajnAco61+FHffy726WNkDIfFS3f
 8K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jGdm1awsl6pAFVIJltSCzTLDW1ARjkPs5Aru4vfQaIQ=;
 b=AOkgH47zm59i4waLKlBzPVZ8cYEhf1BSvfEPG9MmOoANNmLSoz9t4Q9rQh+EAyTcQg
 vZ4dT7HXnolfqK/JkBrJkldfue2Z86jn+bhATH+ZHIgyNynBPb/ZlnQSNb5jKzYS7+u5
 Y0zHhELkq5eq2bm2ggQZe3n7OLTXYErc96ZFHSQFblHrW2+mBUAL4ZinKZ51xjcDSGMv
 BazJvlG1bfH8ZQp/MFrDc2QdT+fBnYlF+nwf3cLu20f0tIQBwD/I5KDtkEARVh7jD+IT
 Gsvd+qMOVY41hRlMbm8CO05DsmxlGjIJKGGGXbZVCSpVkXLlX3Rh+KPveCSVTLI9fOpm
 do4A==
X-Gm-Message-State: AOAM533gCXrpuHUCcO5X0x0NziHaH7baLfLDdAU911Cagbl9VHUAEg2W
 54AZLzOqBRl1FOCMhOWhb8joUeweJZEbK19WQQs=
X-Google-Smtp-Source: ABdhPJzQX3gyFJb3bsxZNqKNf+QS5qrYavEjhKbozIs4GjBm7B5szpLCSSV3VI/SIupWYqiSGbovf7y3elv97uxBAm0=
X-Received: by 2002:adf:e712:: with SMTP id c18mr9046935wrm.92.1595879188587; 
 Mon, 27 Jul 2020 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
 <9139d78a-a242-f973-31ac-a07ce6436396@gmail.com>
 <CAEQFVGY_UL+U7o_1snmQeV0scEMrD4-d8tNKw5CN7s0sZ+CX=A@mail.gmail.com>
 <CADnq5_OyiBsmUmdkA7gnz_ke-kncsSB_J-kS0WJuyePNA=0AcQ@mail.gmail.com>
 <CAEQFVGYAwr_89DNi3UN4PnUg9bceK_str1HiFW6cL81Ptn83bg@mail.gmail.com>
 <CADnq5_MGcptRH7vYMGhuoXN8SjdYvp7JQu2-WsiXy6VgpbucKQ@mail.gmail.com>
 <CAEQFVGYAE6aUKodW20rFUR9+CGNsYP+oNYfkNjYmDoZaLixCbw@mail.gmail.com>
 <CADnq5_PArAuyDRw_kLsomDa-Cr+dHZNF=WC3QyL6LjFPLhDaMg@mail.gmail.com>
In-Reply-To: <CADnq5_PArAuyDRw_kLsomDa-Cr+dHZNF=WC3QyL6LjFPLhDaMg@mail.gmail.com>
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Mon, 27 Jul 2020 21:46:17 +0200
Message-ID: <CAEQFVGb_qJ=90z9Vq+u+gK=mfS0nVtF4hfjA1od7HZjzb+gqwA@mail.gmail.com>
Subject: Re:
To: Alex Deucher <alexdeucher@gmail.com>
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
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0178055088=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0178055088==
Content-Type: multipart/alternative; boundary="00000000000023e6ff05ab719435"

--00000000000023e6ff05ab719435
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 8:31 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Sun, Jul 26, 2020 at 11:31 AM Mauro Rossi <issor.oruam@gmail.com>
> wrote:
> >
> > Hello,
> >
> > On Fri, Jul 24, 2020 at 8:31 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >>
> >> On Wed, Jul 22, 2020 at 3:57 AM Mauro Rossi <issor.oruam@gmail.com>
> wrote:
> >> >
> >> > Hello,
> >> > re-sending and copying full DL
> >> >
> >> > On Wed, Jul 22, 2020 at 4:51 AM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >> >>
> >> >> On Mon, Jul 20, 2020 at 6:00 AM Mauro Rossi <issor.oruam@gmail.com>
> wrote:
> >> >> >
> >> >> > Hi Christian,
> >> >> >
> >> >> > On Mon, Jul 20, 2020 at 11:00 AM Christian K=C3=B6nig
> >> >> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> >> > >
> >> >> > > Hi Mauro,
> >> >> > >
> >> >> > > I'm not deep into the whole DC design, so just some general hig=
h
> level
> >> >> > > comments on the cover letter:
> >> >> > >
> >> >> > > 1. Please add a subject line to the cover letter, my spam filte=
r
> thinks
> >> >> > > that this is suspicious otherwise.
> >> >> >
> >> >> > My mistake in the editing of covert letter with git send-email,
> >> >> > I may have forgot to keep the Subject at the top
> >> >> >
> >> >> > >
> >> >> > > 2. Then you should probably note how well (badly?) is that
> tested. Since
> >> >> > > you noted proof of concept it might not even work.
> >> >> >
> >> >> > The Changelog is to be read as:
> >> >> >
> >> >> > [RFC] was the initial Proof of concept was the RFC and [PATCH v2]
> was
> >> >> > just a rebase onto amd-staging-drm-next
> >> >> >
> >> >> > this series [PATCH v3] has all the known changes required for DCE=
6
> specificity
> >> >> > and based on a long offline thread with Alexander Deutcher and pa=
st
> >> >> > dri-devel chats with Harry Wentland.
> >> >> >
> >> >> > It was tested for my possibilities of testing with HD7750 and
> HD7950,
> >> >> > with checks in dmesg output for not getting "missing
> registers/masks"
> >> >> > kernel WARNING
> >> >> > and with kernel build on Ubuntu 20.04 and with android-x86
> >> >> >
> >> >> > The proposal I made to Alex is that AMD testing systems will be
> used
> >> >> > for further regression testing,
> >> >> > as part of review and validation for eligibility to
> amd-staging-drm-next
> >> >> >
> >> >>
> >> >> We will certainly test it once it lands, but presumably this is
> >> >> working on the SI cards you have access to?
> >> >
> >> >
> >> > Yes, most of my testing was done with android-x86  Android CTS (EGL,
> GLES2, GLES3, VK)
> >> >
> >> > I am also in contact with a person with Firepro W5130M who is runnin=
g
> a piglit session
> >> >
> >> > I had bought an HD7850 to test with Pitcairn, but it arrived as
> defective so I could not test with Pitcair
> >> >
> >> >
> >> >>
> >> >> > >
> >> >> > > 3. How feature complete (HDMI audio?, Freesync?) is it?
> >> >> >
> >> >> > All the changes in DC impacting DCE8 (dc/dce80 path) were ported =
to
> >> >> > DCE6 (dc/dce60 path) in the last two years from initial submissio=
n
> >> >> >
> >> >> > >
> >> >> > > Apart from that it looks like a rather impressive piece of work
> :)
> >> >> > >
> >> >> > > Cheers,
> >> >> > > Christian.
> >> >> >
> >> >> > Thanks,
> >> >> > please consider that most of the latest DCE6 specific parts were
> >> >> > possible due to recent Alex support in getting the correct DCE6
> >> >> > headers,
> >> >> > his suggestions and continuous feedback.
> >> >> >
> >> >> > I would suggest that Alex comments on the proposed next steps to
> follow.
> >> >>
> >> >> The code looks pretty good to me.  I'd like to get some feedback fr=
om
> >> >> the display team to see if they have any concerns, but beyond that =
I
> >> >> think we can pull it into the tree and continue improving it there.
> >> >> Do you have a link to a git tree I can pull directly that contains
> >> >> these patches?  Is this the right branch?
> >> >> https://github.com/maurossi/linux/commits/kernel-5.8rc4_si_next
> >> >>
> >> >> Thanks!
> >> >>
> >> >> Alex
> >> >
> >> >
> >> > The following branch was pushed with the series on top of
> amd-staging-drm-next
> >> >
> >> > https://github.com/maurossi/linux/commits/kernel-5.6_si_drm-next
> >>
> >> I gave this a quick test on all of the SI asics and the various
> >> monitors I had available and it looks good.  A few minor patches I
> >> noticed are attached.  If they look good to you, I'll squash them into
> >> the series when I commit it.  I've pushed it to my fdo tree as well:
> >> https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Dsi_dc_support
> >>
> >> Thanks!
> >>
> >> Alex
> >
> >
> > The new patches are ok and with the following infomation about piglit
> tests,
> > the series may be good to go.
> >
> > I have performed piglit tests on Tahiti HD7950 on kernel 5.8.0-rc6 with
> AMD DC support for SI
> > and comparison with vanilla kernel 5.8.0-rc6
> >
> > Results are the following
> >
> > [piglit gpu tests with kernel 5.8.0-rc6-amddcsi]
> >
> > utente@utente-desktop:~/piglit$ ./piglit run gpu .
> > [26714/26714] skip: 1731, pass: 24669, warn: 15, fail: 288, crash: 11
> > Thank you for running Piglit!
> > Results have been written to /home/utente/piglit
> >
> > [piglit gpu tests with vanilla 5.8.0-rc6]
> >
> > utente@utente-desktop:~/piglit$ ./piglit run gpu .
> > [26714/26714] skip: 1731, pass: 24673, warn: 13, fail: 283, crash: 14
> > Thank you for running Piglit!
> > Results have been written to /home/utente/piglit
> >
> > In the attachment the comparison of "5.8.0-rc6-amddcsi" vs "5.8.0-rc6"
> vanilla
> > and viceversa, I see no significant regression and in the delta of
> failed tests I don't recognize DC related test cases,
> > but you may also have a look.
>
> Looks good to me.  The series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>

Thank you Alex for review and the help in finalizing the series
and to Harry who initially encouraged me and provided the feedbacks to
previous v2 series



>
> >
> > dmesg for "5.8.0-rc6-amddcsi" is also provide the check the crashes
> >
> > Regarding the other user testing the series with Firepro W5130M
> > he found an already existing issue in amdgpu si_support=3D1 which is
> independent from my series and matches a problem alrady reported. [1]
> >
>
> amdgpu does not currently implement GPU reset support for SI.
>
> Alex
>

If you have in the plans to add support and prevent those crashes,
the user would be glad to be available for glxgears and piglit testing
on Firepro W5130M

Please let me know

Mauro


>
> > Mauro
> >
> > [1] https://bbs.archlinux.org/viewtopic.php?id=3D249097
> >
> >>
> >>
> >> >
> >> >>
> >> >>
> >> >> >
> >> >> > Mauro
> >> >> >
> >> >> > >
> >> >> > > Am 16.07.20 um 23:22 schrieb Mauro Rossi:
> >> >> > > > The series adds SI support to AMD DC
> >> >> > > >
> >> >> > > > Changelog:
> >> >> > > >
> >> >> > > > [RFC]
> >> >> > > > Preliminar Proof Of Concept, with DCE8 headers still used in
> dce60_resources.c
> >> >> > > >
> >> >> > > > [PATCH v2]
> >> >> > > > Rebase on amd-staging-drm-next dated 17-Oct-2018
> >> >> > > >
> >> >> > > > [PATCH v3]
> >> >> > > > Add support for DCE6 specific headers,
> >> >> > > > ad hoc DCE6 macros, funtions and fixes,
> >> >> > > > rebase on current amd-staging-drm-next
> >> >> > > >
> >> >> > > >
> >> >> > > > Commits [01/27]..[08/27] SI support added in various DC
> components
> >> >> > > >
> >> >> > > > [PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers
> (v6)
> >> >> > > > [PATCH v3 02/27] drm/amd/display: add asics info for SI parts
> >> >> > > > [PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6
> support (v9b)
> >> >> > > > [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 suppor=
t
> (v2)
> >> >> > > > [PATCH v3 05/27] drm/amd/display: dc/bios: add support for DC=
E6
> >> >> > > > [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for
> DCE6 (v2)
> >> >> > > > [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE=
6
> (v4)
> >> >> > > > [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support
> (v4)
> >> >> > > >
> >> >> > > > Commits [09/27]..[24/27] DCE6 specific code adaptions
> >> >> > > >
> >> >> > > > [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for
> SI parts (v2)
> >> >> > > > [PATCH v3 10/27] drm/amd/display: dc/dce60: set
> max_cursor_size to 64
> >> >> > > > [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specifi=
c
> macros,functions
> >> >> > > > [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific
> macros
> >> >> > > > [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specifi=
c
> macros,functions
> >> >> > > > [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific
> macros,functions
> >> >> > > > [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6
> specific macros,functions
> >> >> > > > [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6
> specific macros,functions
> >> >> > > > [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific
> macros,functions
> >> >> > > > [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6
> specific macros,functions
> >> >> > > > [PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers
> (v7)
> >> >> > > > [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling
> Horizontal Filter Init
> >> >> > > > [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE=
6
> macros,functions
> >> >> > > > [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE=
6
> specific .cursor_lock
> >> >> > > > [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add
> DCE6 specific functions
> >> >> > > > [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers
> (v6)
> >> >> > > >
> >> >> > > >
> >> >> > > > Commits [25/27]..[27/27] SI support final enablements
> >> >> > > >
> >> >> > > > [PATCH v3 25/27] drm/amd/display: create plane rotation
> property for Bonarie and later
> >> >> > > > [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts
> (v2)
> >> >> > > > [PATCH v3 27/27] drm/amd/display: enable SI support in the
> Kconfig (v2)
> >> >> > > >
> >> >> > > >
> >> >> > > > Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> >> >> > > >
> >> >> > > > _______________________________________________
> >> >> > > > amd-gfx mailing list
> >> >> > > > amd-gfx@lists.freedesktop.org
> >> >> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >> >> > >
> >> >> > _______________________________________________
> >> >> > amd-gfx mailing list
> >> >> > amd-gfx@lists.freedesktop.org
> >> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000023e6ff05ab719435
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 27, 2020 at 8:31 PM Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Sun, Jul 26, 2020 at 11:31 AM Mauro Rossi &lt;<a href=3D"mailto:issor.oru=
am@gmail.com" target=3D"_blank">issor.oruam@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; On Fri, Jul 24, 2020 at 8:31 PM Alex Deucher &lt;<a href=3D"mailto:ale=
xdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt; On Wed, Jul 22, 2020 at 3:57 AM Mauro Rossi &lt;<a href=3D"mailto:=
issor.oruam@gmail.com" target=3D"_blank">issor.oruam@gmail.com</a>&gt; wrot=
e:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hello,<br>
&gt;&gt; &gt; re-sending and copying full DL<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, Jul 22, 2020 at 4:51 AM Alex Deucher &lt;<a href=3D"m=
ailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt=
; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Mon, Jul 20, 2020 at 6:00 AM Mauro Rossi &lt;<a href=
=3D"mailto:issor.oruam@gmail.com" target=3D"_blank">issor.oruam@gmail.com</=
a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Hi Christian,<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; On Mon, Jul 20, 2020 at 11:00 AM Christian K=C3=B6ni=
g<br>
&gt;&gt; &gt;&gt; &gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.c=
om" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Hi Mauro,<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; I&#39;m not deep into the whole DC design, so j=
ust some general high level<br>
&gt;&gt; &gt;&gt; &gt; &gt; comments on the cover letter:<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; 1. Please add a subject line to the cover lette=
r, my spam filter thinks<br>
&gt;&gt; &gt;&gt; &gt; &gt; that this is suspicious otherwise.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; My mistake in the editing of covert letter with git =
send-email,<br>
&gt;&gt; &gt;&gt; &gt; I may have forgot to keep the Subject at the top<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; 2. Then you should probably note how well (badl=
y?) is that tested. Since<br>
&gt;&gt; &gt;&gt; &gt; &gt; you noted proof of concept it might not even wo=
rk.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The Changelog is to be read as:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; [RFC] was the initial Proof of concept was the RFC a=
nd [PATCH v2] was<br>
&gt;&gt; &gt;&gt; &gt; just a rebase onto amd-staging-drm-next<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; this series [PATCH v3] has all the known changes req=
uired for DCE6 specificity<br>
&gt;&gt; &gt;&gt; &gt; and based on a long offline thread with Alexander De=
utcher and past<br>
&gt;&gt; &gt;&gt; &gt; dri-devel chats with Harry Wentland.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; It was tested for my possibilities of testing with H=
D7750 and HD7950,<br>
&gt;&gt; &gt;&gt; &gt; with checks in dmesg output for not getting &quot;mi=
ssing registers/masks&quot;<br>
&gt;&gt; &gt;&gt; &gt; kernel WARNING<br>
&gt;&gt; &gt;&gt; &gt; and with kernel build on Ubuntu 20.04 and with andro=
id-x86<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; The proposal I made to Alex is that AMD testing syst=
ems will be used<br>
&gt;&gt; &gt;&gt; &gt; for further regression testing,<br>
&gt;&gt; &gt;&gt; &gt; as part of review and validation for eligibility to =
amd-staging-drm-next<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; We will certainly test it once it lands, but presumably t=
his is<br>
&gt;&gt; &gt;&gt; working on the SI cards you have access to?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, most of my testing was done with android-x86=C2=A0 Andro=
id CTS (EGL, GLES2, GLES3, VK)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am also in contact with a person with Firepro W5130M who is=
 running a piglit session<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I had bought an HD7850 to test with Pitcairn, but it arrived =
as defective so I could not test with Pitcair<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; 3. How feature complete (HDMI audio?, Freesync?=
) is it?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; All the changes in DC impacting DCE8 (dc/dce80 path)=
 were ported to<br>
&gt;&gt; &gt;&gt; &gt; DCE6 (dc/dce60 path) in the last two years from init=
ial submission<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Apart from that it looks like a rather impressi=
ve piece of work :)<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Cheers,<br>
&gt;&gt; &gt;&gt; &gt; &gt; Christian.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt;&gt; &gt; please consider that most of the latest DCE6 specifi=
c parts were<br>
&gt;&gt; &gt;&gt; &gt; possible due to recent Alex support in getting the c=
orrect DCE6<br>
&gt;&gt; &gt;&gt; &gt; headers,<br>
&gt;&gt; &gt;&gt; &gt; his suggestions and continuous feedback.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; I would suggest that Alex comments on the proposed n=
ext steps to follow.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The code looks pretty good to me.=C2=A0 I&#39;d like to g=
et some feedback from<br>
&gt;&gt; &gt;&gt; the display team to see if they have any concerns, but be=
yond that I<br>
&gt;&gt; &gt;&gt; think we can pull it into the tree and continue improving=
 it there.<br>
&gt;&gt; &gt;&gt; Do you have a link to a git tree I can pull directly that=
 contains<br>
&gt;&gt; &gt;&gt; these patches?=C2=A0 Is this the right branch?<br>
&gt;&gt; &gt;&gt; <a href=3D"https://github.com/maurossi/linux/commits/kern=
el-5.8rc4_si_next" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
maurossi/linux/commits/kernel-5.8rc4_si_next</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks!<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Alex<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The following branch was pushed with the series on top of amd=
-staging-drm-next<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://github.com/maurossi/linux/commits/kernel-5=
.6_si_drm-next" rel=3D"noreferrer" target=3D"_blank">https://github.com/mau=
rossi/linux/commits/kernel-5.6_si_drm-next</a><br>
&gt;&gt;<br>
&gt;&gt; I gave this a quick test on all of the SI asics and the various<br=
>
&gt;&gt; monitors I had available and it looks good.=C2=A0 A few minor patc=
hes I<br>
&gt;&gt; noticed are attached.=C2=A0 If they look good to you, I&#39;ll squ=
ash them into<br>
&gt;&gt; the series when I commit it.=C2=A0 I&#39;ve pushed it to my fdo tr=
ee as well:<br>
&gt;&gt; <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Dsi_d=
c_support" rel=3D"noreferrer" target=3D"_blank">https://cgit.freedesktop.or=
g/~agd5f/linux/log/?h=3Dsi_dc_support</a><br>
&gt;&gt;<br>
&gt;&gt; Thanks!<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt; The new patches are ok and with the following infomation about piglit =
tests,<br>
&gt; the series may be good to go.<br>
&gt;<br>
&gt; I have performed piglit tests on Tahiti HD7950 on kernel 5.8.0-rc6 wit=
h AMD DC support for SI<br>
&gt; and comparison with vanilla kernel 5.8.0-rc6<br>
&gt;<br>
&gt; Results are the following<br>
&gt;<br>
&gt; [piglit gpu tests with kernel 5.8.0-rc6-amddcsi]<br>
&gt;<br>
&gt; utente@utente-desktop:~/piglit$ ./piglit run gpu .<br>
&gt; [26714/26714] skip: 1731, pass: 24669, warn: 15, fail: 288, crash: 11<=
br>
&gt; Thank you for running Piglit!<br>
&gt; Results have been written to /home/utente/piglit<br>
&gt;<br>
&gt; [piglit gpu tests with vanilla 5.8.0-rc6]<br>
&gt;<br>
&gt; utente@utente-desktop:~/piglit$ ./piglit run gpu .<br>
&gt; [26714/26714] skip: 1731, pass: 24673, warn: 13, fail: 283, crash: 14<=
br>
&gt; Thank you for running Piglit!<br>
&gt; Results have been written to /home/utente/piglit<br>
&gt;<br>
&gt; In the attachment the comparison of &quot;5.8.0-rc6-amddcsi&quot; vs &=
quot;5.8.0-rc6&quot; vanilla<br>
&gt; and viceversa, I see no significant regression and in the delta of fai=
led tests I don&#39;t recognize DC related test cases,<br>
&gt; but you may also have a look.<br>
<br>
Looks good to me.=C2=A0 The series is:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" =
target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br></blockquote><div><b=
r></div><div>Thank you Alex for review and the help in finalizing the serie=
s</div><div>and to Harry who initially encouraged me and provided the feedb=
acks to previous v2 series</div><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; dmesg for &quot;5.8.0-rc6-amddcsi&quot; is also provide the check the =
crashes<br>
&gt;<br>
&gt; Regarding the other user testing the series with Firepro W5130M<br>
&gt; he found an already existing issue in amdgpu si_support=3D1 which is i=
ndependent from my series and matches a problem alrady reported. [1]<br>
&gt;<br>
<br>
amdgpu does not currently implement GPU reset support for SI.<br>
<br>
Alex<br></blockquote><div><br></div><div>If you have in the plans to add su=
pport and prevent those crashes,=C2=A0</div><div>the user would be glad to =
be available for glxgears and piglit testing on=C2=A0Firepro W5130M</div><d=
iv><br></div><div>Please let me know</div><div><br></div><div>Mauro</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Mauro<br>
&gt;<br>
&gt; [1] <a href=3D"https://bbs.archlinux.org/viewtopic.php?id=3D249097" re=
l=3D"noreferrer" target=3D"_blank">https://bbs.archlinux.org/viewtopic.php?=
id=3D249097</a><br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Mauro<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; Am 16.07.20 um 23:22 schrieb Mauro Rossi:<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; The series adds SI support to AMD DC<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Changelog:<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [RFC]<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Preliminar Proof Of Concept, with DCE8 hea=
ders still used in dce60_resources.c<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v2]<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Rebase on amd-staging-drm-next dated 17-Oc=
t-2018<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3]<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Add support for DCE6 specific headers,<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; ad hoc DCE6 macros, funtions and fixes,<br=
>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; rebase on current amd-staging-drm-next<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Commits [01/27]..[08/27] SI support added =
in various DC components<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 01/27] drm/amdgpu: add some requ=
ired DCE6 registers (v6)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 02/27] drm/amd/display: add asic=
s info for SI parts<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 03/27] drm/amd/display: dc/dce: =
add initial DCE6 support (v9b)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 04/27] drm/amd/display: dc/core:=
 add SI/DCE6 support (v2)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 05/27] drm/amd/display: dc/bios:=
 add support for DCE6<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 06/27] drm/amd/display: dc/gpio:=
 add support for DCE6 (v2)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 07/27] drm/amd/display: dc/irq: =
add support for DCE6 (v4)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 08/27] drm/amd/display: amdgpu_d=
m: add SI support (v4)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Commits [09/27]..[24/27] DCE6 specific cod=
e adaptions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 09/27] drm/amd/display: dc/clk_m=
gr: add support for SI parts (v2)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 10/27] drm/amd/display: dc/dce60=
: set max_cursor_size to 64<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 11/27] drm/amd/display: dce_audi=
o: add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 12/27] drm/amd/display: dce_dmcu=
: add DCE6 specific macros<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 13/27] drm/amd/display: dce_hwse=
q: add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 14/27] drm/amd/display: dce_ipp:=
 add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 15/27] drm/amd/display: dce_link=
_encoder: add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 16/27] drm/amd/display: dce_mem_=
input: add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 17/27] drm/amd/display: dce_opp:=
 add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 18/27] drm/amd/display: dce_tran=
sform: add DCE6 specific macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 19/27] drm/amdgpu: add some requ=
ired DCE6 registers (v7)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 20/27] drm/amd/display: dce_tran=
sform: DCE6 Scaling Horizontal Filter Init<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 21/27] drm/amd/display: dce60_hw=
_sequencer: add DCE6 macros,functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 22/27] drm/amd/display: dce60_hw=
_sequencer: add DCE6 specific .cursor_lock<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 23/27] drm/amd/display: dce60_ti=
ming_generator: add DCE6 specific functions<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 24/27] drm/amd/display: dc/dce60=
: use DCE6 headers (v6)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Commits [25/27]..[27/27] SI support final =
enablements<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 25/27] drm/amd/display: create p=
lane rotation property for Bonarie and later<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 26/27] drm/amdgpu: enable DC sup=
port for SI parts (v2)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; [PATCH v3 27/27] drm/amd/display: enable S=
I support in the Kconfig (v2)<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; Signed-off-by: Mauro Rossi &lt;<a href=3D"=
mailto:issor.oruam@gmail.com" target=3D"_blank">issor.oruam@gmail.com</a>&g=
t;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; __________________________________________=
_____<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt;&gt; &gt; &gt; &gt; <a href=3D"https://lists.freedesktop.org/m=
ailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt;&gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" tar=
get=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx</a><br>
</blockquote></div></div>

--00000000000023e6ff05ab719435--

--===============0178055088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0178055088==--
