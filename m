Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEE320792
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3in+YEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEE320792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20BF6E125;
	Wed, 22 Jul 2020 07:57:51 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8036E125
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 07:57:49 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id a14so928633wra.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eoVDwy59ZoOaR6qDCMZiek6AtSH8ys36anHNIJanihw=;
 b=Z3in+YEL+xjPwWPHoDMGnaitSE588P1VutqjFjORKGfODvzHGs/hB72XIkrNc5lqK7
 hBIow5yB2YJ40PEhtMLgP+TAdhYBw8MBtN2mj7wyMrtIZQVvZRPGjutZxrkBYOqlUY3E
 3zLaNcBfjmMuP7xI4Jw0QyWKA6IJbr7Y6w8VqCZWEpZMOt9BzbpMHRSzvgvlzNp6GR3t
 lJaMSsqS8h2GtH6TR8oTmRhFl99JGB8zclfuqWjC7sXcxd2Cqcbnb37naeWrjKjregEG
 HaPz1HdMx9pUIzA4r0utPagWFmmMfZPyhgwixU+vVPAGM6q5ZwrAi0bUV52j62Pd5rcr
 UTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eoVDwy59ZoOaR6qDCMZiek6AtSH8ys36anHNIJanihw=;
 b=hprileTxEThvQPANHVDn+Ffy3SEumTlMmm+F4ed0wZoXrvuQLcrL5JMQ7aoocmltRb
 xgyjRmK2TCyuwuaCdmUT0FKkJqpGHakcYVqLu5PoghYMoOmSQffy+fm8/6RNpdCoDq6N
 Z3QhLYfuBBKP2u0aRD6YM1XeEOKVQjzcc6cvULuRkv9xnknvQEMsxHjU2mih7AZiyx07
 l/MBUBxXhQzGRIusCCf1NjcbUlAWsuwKjNgpcZMhrvpILSpmciZwugFgPuM9QVM23sTZ
 OEMnOKndQB95imuiDMqNK5SG04cclKNiUCZrVeWLTBQRMH7Ntgit9a9xB31ZAVX2W5WA
 E1zg==
X-Gm-Message-State: AOAM530tC2bZCTqdk5KvClhVhPLK0MZKgA+kfAuSOLuqBud6j3LuAJz4
 PeXOWiAE51ozAjbNN9X/oc6iyt/QS3S5Qy0IX8E=
X-Google-Smtp-Source: ABdhPJyzuyu7TKKJFOVNfM9KFBZ7odm/sbGBffUd9nQZ7F93AOfN7hB5mmrJ7E2vLHiKfggny2E/rY8+hdaPzHKXh9o=
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr29376720wrv.272.1595404668337; 
 Wed, 22 Jul 2020 00:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
 <9139d78a-a242-f973-31ac-a07ce6436396@gmail.com>
 <CAEQFVGY_UL+U7o_1snmQeV0scEMrD4-d8tNKw5CN7s0sZ+CX=A@mail.gmail.com>
 <CADnq5_OyiBsmUmdkA7gnz_ke-kncsSB_J-kS0WJuyePNA=0AcQ@mail.gmail.com>
In-Reply-To: <CADnq5_OyiBsmUmdkA7gnz_ke-kncsSB_J-kS0WJuyePNA=0AcQ@mail.gmail.com>
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Wed, 22 Jul 2020 09:56:10 +0200
Message-ID: <CAEQFVGYAwr_89DNi3UN4PnUg9bceK_str1HiFW6cL81Ptn83bg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2002692459=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2002692459==
Content-Type: multipart/alternative; boundary="00000000000087816d05ab03184d"

--00000000000087816d05ab03184d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
re-sending and copying full DL

On Wed, Jul 22, 2020 at 4:51 AM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Mon, Jul 20, 2020 at 6:00 AM Mauro Rossi <issor.oruam@gmail.com> wrote=
:
> >
> > Hi Christian,
> >
> > On Mon, Jul 20, 2020 at 11:00 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > Hi Mauro,
> > >
> > > I'm not deep into the whole DC design, so just some general high leve=
l
> > > comments on the cover letter:
> > >
> > > 1. Please add a subject line to the cover letter, my spam filter thin=
ks
> > > that this is suspicious otherwise.
> >
> > My mistake in the editing of covert letter with git send-email,
> > I may have forgot to keep the Subject at the top
> >
> > >
> > > 2. Then you should probably note how well (badly?) is that tested.
> Since
> > > you noted proof of concept it might not even work.
> >
> > The Changelog is to be read as:
> >
> > [RFC] was the initial Proof of concept was the RFC and [PATCH v2] was
> > just a rebase onto amd-staging-drm-next
> >
> > this series [PATCH v3] has all the known changes required for DCE6
> specificity
> > and based on a long offline thread with Alexander Deutcher and past
> > dri-devel chats with Harry Wentland.
> >
> > It was tested for my possibilities of testing with HD7750 and HD7950,
> > with checks in dmesg output for not getting "missing registers/masks"
> > kernel WARNING
> > and with kernel build on Ubuntu 20.04 and with android-x86
> >
> > The proposal I made to Alex is that AMD testing systems will be used
> > for further regression testing,
> > as part of review and validation for eligibility to amd-staging-drm-nex=
t
> >
>
> We will certainly test it once it lands, but presumably this is
> working on the SI cards you have access to?
>

Yes, most of my testing was done with android-x86  Android CTS (EGL, GLES2,
GLES3, VK)

I am also in contact with a person with Firepro W5130M who is running a
piglit session

I had bought an HD7850 to test with Pitcairn, but it arrived as defective
so I could not test with Pitcair



> > >
> > > 3. How feature complete (HDMI audio?, Freesync?) is it?
> >
> > All the changes in DC impacting DCE8 (dc/dce80 path) were ported to
> > DCE6 (dc/dce60 path) in the last two years from initial submission
> >
> > >
> > > Apart from that it looks like a rather impressive piece of work :)
> > >
> > > Cheers,
> > > Christian.
> >
> > Thanks,
> > please consider that most of the latest DCE6 specific parts were
> > possible due to recent Alex support in getting the correct DCE6
> > headers,
> > his suggestions and continuous feedback.
> >
> > I would suggest that Alex comments on the proposed next steps to follow=
.
>
> The code looks pretty good to me.  I'd like to get some feedback from
> the display team to see if they have any concerns, but beyond that I
> think we can pull it into the tree and continue improving it there.
> Do you have a link to a git tree I can pull directly that contains
> these patches?  Is this the right branch?
> https://github.com/maurossi/linux/commits/kernel-5.8rc4_si_next
>
> Thanks!
>
> Alex
>

The following branch was pushed with the series on top of
amd-staging-drm-next

https://github.com/maurossi/linux/commits/kernel-5.6_si_drm-next


>
> >
> > Mauro
> >
> > >
> > > Am 16.07.20 um 23:22 schrieb Mauro Rossi:
> > > > The series adds SI support to AMD DC
> > > >
> > > > Changelog:
> > > >
> > > > [RFC]
> > > > Preliminar Proof Of Concept, with DCE8 headers still used in
> dce60_resources.c
> > > >
> > > > [PATCH v2]
> > > > Rebase on amd-staging-drm-next dated 17-Oct-2018
> > > >
> > > > [PATCH v3]
> > > > Add support for DCE6 specific headers,
> > > > ad hoc DCE6 macros, funtions and fixes,
> > > > rebase on current amd-staging-drm-next
> > > >
> > > >
> > > > Commits [01/27]..[08/27] SI support added in various DC components
> > > >
> > > > [PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers (v6)
> > > > [PATCH v3 02/27] drm/amd/display: add asics info for SI parts
> > > > [PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6 support
> (v9b)
> > > > [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 support (v2)
> > > > [PATCH v3 05/27] drm/amd/display: dc/bios: add support for DCE6
> > > > [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for DCE6 (v2=
)
> > > > [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE6 (v4)
> > > > [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support (v4)
> > > >
> > > > Commits [09/27]..[24/27] DCE6 specific code adaptions
> > > >
> > > > [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for SI
> parts (v2)
> > > > [PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_size to =
64
> > > > [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specific
> macros,functions
> > > > [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific macro=
s
> > > > [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specific
> macros,functions
> > > > [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific
> macros,functions
> > > > [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6
> specific macros,functions
> > > > [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 specific
> macros,functions
> > > > [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific
> macros,functions
> > > > [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 specific
> macros,functions
> > > > [PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers (v7)
> > > > [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling
> Horizontal Filter Init
> > > > [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE6
> macros,functions
> > > > [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE6
> specific .cursor_lock
> > > > [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add DCE6
> specific functions
> > > > [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers (v6)
> > > >
> > > >
> > > > Commits [25/27]..[27/27] SI support final enablements
> > > >
> > > > [PATCH v3 25/27] drm/amd/display: create plane rotation property fo=
r
> Bonarie and later
> > > > [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts (v2)
> > > > [PATCH v3 27/27] drm/amd/display: enable SI support in the Kconfig
> (v2)
> > > >
> > > >
> > > > Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000087816d05ab03184d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,=C2=A0=C2=A0<br></div><div>re-sendi=
ng and copying full DL</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Jul 22, 2020 at 4:51 AM Alex Deucher &lt;<a h=
ref=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Jul 20, 2=
020 at 6:00 AM Mauro Rossi &lt;<a href=3D"mailto:issor.oruam@gmail.com" tar=
get=3D"_blank">issor.oruam@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; On Mon, Jul 20, 2020 at 11:00 AM Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_bla=
nk">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi Mauro,<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m not deep into the whole DC design, so just some general h=
igh level<br>
&gt; &gt; comments on the cover letter:<br>
&gt; &gt;<br>
&gt; &gt; 1. Please add a subject line to the cover letter, my spam filter =
thinks<br>
&gt; &gt; that this is suspicious otherwise.<br>
&gt;<br>
&gt; My mistake in the editing of covert letter with git send-email,<br>
&gt; I may have forgot to keep the Subject at the top<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; 2. Then you should probably note how well (badly?) is that tested=
. Since<br>
&gt; &gt; you noted proof of concept it might not even work.<br>
&gt;<br>
&gt; The Changelog is to be read as:<br>
&gt;<br>
&gt; [RFC] was the initial Proof of concept was the RFC and [PATCH v2] was<=
br>
&gt; just a rebase onto amd-staging-drm-next<br>
&gt;<br>
&gt; this series [PATCH v3] has all the known changes required for DCE6 spe=
cificity<br>
&gt; and based on a long offline thread with Alexander Deutcher and past<br=
>
&gt; dri-devel chats with Harry Wentland.<br>
&gt;<br>
&gt; It was tested for my possibilities of testing with HD7750 and HD7950,<=
br>
&gt; with checks in dmesg output for not getting &quot;missing registers/ma=
sks&quot;<br>
&gt; kernel WARNING<br>
&gt; and with kernel build on Ubuntu 20.04 and with android-x86<br>
&gt;<br>
&gt; The proposal I made to Alex is that AMD testing systems will be used<b=
r>
&gt; for further regression testing,<br>
&gt; as part of review and validation for eligibility to amd-staging-drm-ne=
xt<br>
&gt;<br>
<br>
We will certainly test it once it lands, but presumably this is<br>
working on the SI cards you have access to?<br></blockquote><div><br></div>=
<div>Yes, most of my testing was done with android-x86=C2=A0

Android CTS (EGL, GLES2, GLES3, VK)=20

</div><div><br></div><div>I am also in contact with a person with Firepro W=
5130M who is running a piglit session</div><div><br></div><div>I had bought=
 an HD7850 to test with Pitcairn, but it arrived as defective so I could no=
t test with Pitcair=C2=A0</div><div><br></div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; &gt;<br>
&gt; &gt; 3. How feature complete (HDMI audio?, Freesync?) is it?<br>
&gt;<br>
&gt; All the changes in DC impacting DCE8 (dc/dce80 path) were ported to<br=
>
&gt; DCE6 (dc/dce60 path) in the last two years from initial submission<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Apart from that it looks like a rather impressive piece of work :=
)<br>
&gt; &gt;<br>
&gt; &gt; Cheers,<br>
&gt; &gt; Christian.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; please consider that most of the latest DCE6 specific parts were<br>
&gt; possible due to recent Alex support in getting the correct DCE6<br>
&gt; headers,<br>
&gt; his suggestions and continuous feedback.<br>
&gt;<br>
&gt; I would suggest that Alex comments on the proposed next steps to follo=
w.<br>
<br>
The code looks pretty good to me.=C2=A0 I&#39;d like to get some feedback f=
rom<br>
the display team to see if they have any concerns, but beyond that I<br>
think we can pull it into the tree and continue improving it there.<br>
Do you have a link to a git tree I can pull directly that contains<br>
these patches?=C2=A0 Is this the right branch?<br>
<a href=3D"https://github.com/maurossi/linux/commits/kernel-5.8rc4_si_next"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/maurossi/linux/com=
mits/kernel-5.8rc4_si_next</a><br>
<br>
Thanks!<br>
<br>
Alex<br></blockquote><div><br></div><div><div>The following branch was push=
ed with the series on top of amd-staging-drm-next</div><div><br></div><div>=
<a href=3D"https://github.com/maurossi/linux/commits/kernel-5.6_si_drm-next=
" target=3D"_blank">https://github.com/maurossi/linux/commits/kernel-5.6_si=
_drm-next</a></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt;<br>
&gt; Mauro<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Am 16.07.20 um 23:22 schrieb Mauro Rossi:<br>
&gt; &gt; &gt; The series adds SI support to AMD DC<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Changelog:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [RFC]<br>
&gt; &gt; &gt; Preliminar Proof Of Concept, with DCE8 headers still used in=
 dce60_resources.c<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [PATCH v2]<br>
&gt; &gt; &gt; Rebase on amd-staging-drm-next dated 17-Oct-2018<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [PATCH v3]<br>
&gt; &gt; &gt; Add support for DCE6 specific headers,<br>
&gt; &gt; &gt; ad hoc DCE6 macros, funtions and fixes,<br>
&gt; &gt; &gt; rebase on current amd-staging-drm-next<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Commits [01/27]..[08/27] SI support added in various DC comp=
onents<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [PATCH v3 01/27] drm/amdgpu: add some required DCE6 register=
s (v6)<br>
&gt; &gt; &gt; [PATCH v3 02/27] drm/amd/display: add asics info for SI part=
s<br>
&gt; &gt; &gt; [PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6 s=
upport (v9b)<br>
&gt; &gt; &gt; [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 suppo=
rt (v2)<br>
&gt; &gt; &gt; [PATCH v3 05/27] drm/amd/display: dc/bios: add support for D=
CE6<br>
&gt; &gt; &gt; [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for D=
CE6 (v2)<br>
&gt; &gt; &gt; [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DC=
E6 (v4)<br>
&gt; &gt; &gt; [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support =
(v4)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Commits [09/27]..[24/27] DCE6 specific code adaptions<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support fo=
r SI parts (v2)<br>
&gt; &gt; &gt; [PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_s=
ize to 64<br>
&gt; &gt; &gt; [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specif=
ic macros,functions<br>
&gt; &gt; &gt; [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specifi=
c macros<br>
&gt; &gt; &gt; [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specif=
ic macros,functions<br>
&gt; &gt; &gt; [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific=
 macros,functions<br>
&gt; &gt; &gt; [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6=
 specific macros,functions<br>
&gt; &gt; &gt; [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 sp=
ecific macros,functions<br>
&gt; &gt; &gt; [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific=
 macros,functions<br>
&gt; &gt; &gt; [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 sp=
ecific macros,functions<br>
&gt; &gt; &gt; [PATCH v3 19/27] drm/amdgpu: add some required DCE6 register=
s (v7)<br>
&gt; &gt; &gt; [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scalin=
g Horizontal Filter Init<br>
&gt; &gt; &gt; [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DC=
E6 macros,functions<br>
&gt; &gt; &gt; [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DC=
E6 specific .cursor_lock<br>
&gt; &gt; &gt; [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: ad=
d DCE6 specific functions<br>
&gt; &gt; &gt; [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers=
 (v6)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Commits [25/27]..[27/27] SI support final enablements<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [PATCH v3 25/27] drm/amd/display: create plane rotation prop=
erty for Bonarie and later<br>
&gt; &gt; &gt; [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts =
(v2)<br>
&gt; &gt; &gt; [PATCH v3 27/27] drm/amd/display: enable SI support in the K=
config (v2)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Mauro Rossi &lt;<a href=3D"mailto:issor.oruam=
@gmail.com" target=3D"_blank">issor.oruam@gmail.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; amd-gfx mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_=
blank">amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/am=
d-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/m=
ailman/listinfo/amd-gfx</a><br>
&gt; &gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--00000000000087816d05ab03184d--

--===============2002692459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2002692459==--
