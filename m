Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F5CA6000
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E20710EBC5;
	Mon,  5 Oct 2026 07:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCihJva2";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0145B10E048
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 20:27:14 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3282db206d3so21025eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 13:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790972833; cv=none;
 d=google.com; s=arc-20260327;
 b=UqPh/xLjAqSZx5zhNsMorGWbJnV/sbOmotcnC3ZA6LTYvjFtMemYeM4wHIH7YocsOX
 JV4UN23tb6tOmFVKVNttu2ud4ZETezsqOj1EXUWDXF93dX4RCQTVf8o363y81e66zL21
 DjT8Nf5JHDlKIVlEI20pB4xw+AnRjxDagxoR3+9UGT9XEGiD4MfoZuE+c8mYgri30Caw
 yoHM+mQGa+3elVjp8LBnxeS0mQwVxJrd2+jpbqu5B9CYHgupR9PNldvm//a1+yAXjKjZ
 yUR32UhW2rF0/9SnlF4PqLcV1uGSy+yMb+C0Ln8mHd8NYcimVVeRWwBqtbYmZSHKLtki
 T6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
 fh=Ul71IiJuojwXq3NNGvkE23P8+sAIMGBgH/iAPfzOAkE=;
 b=L6IlO/+uGrKi6+DGR9BaQV9odHotKFPxirbggSp3T4x7pk0E6Q3AkpntiAjotMxglA
 H/pBQ+xzxIw1Z5IqDDmXjejNgRvUQH0NcNE8acYAq55WTb9d98Zlauo5/f/umoecEhK4
 FUiz+LCElmlTLESpCoHvSHzAADNZ5dWU9bzwTwqlj7ok/T8wqa6w224iL8qERc0SwR6E
 C0R9vAkxMrSIx8Ca6mpYoJblO5M578DmHCAE4hkEzpRtyfzOFr92NTYYXM1TLqW8Ko1v
 BHABSQqSY5fP7Gof0mKmZYTdZZ/AtT9za9LfTF0P7IMw1H7+I084U9dq/GaVQGgIKHNY
 K/NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790972833; x=1791577633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
 b=fCihJva27vM2968s6l0OX4CiXQXKopw3wsOJEhUQldqpZ72sA1KEBp0Sq5FbIWh4E1
 8TgCeliLnEHw3SYFl5A/pGuX+hYnj6k/zF/Z3Uj0q5SJuoYXyZu4YG/N61ZajJXxSMUs
 jOCepgUMjOkqEaTCcmqxIo8AhNJd7itfx9Tr/AaP5EJcnyfkm09TK1XBX/k7aBQt9pxl
 OezbQQLHBE3Dec9pdK+6ILJgjWxUOgyTgMgDzCh/RSC5rj2binviH5VJQEcX2kUnslQj
 Hvae+0nfcawppKc7RRah7stu+EMtWVbhzrpYSar9FawG/c3HGxuCBt00Tlb9h+vQieJR
 5VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972833; x=1791577633;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxSWnSWRJ9M/USzaWwOGc1VbHfaj2Un/7bCqN3HRKO4=;
 b=OUUKGpA0UgVCpszdIqTSE+7Cuc3ocXb4X/OodKdcq01iOu0InBURIfrQh7eO7fSx4U
 b2ETOaxD+bgp2SmFNOy5LnK2jnyGjCBtsWWNJddAEUmdjsj2wuIHwL/0bw36gI3KuS3O
 TbvylWp4C217iZF4LXWjwTUzREWk9a6aDRXNJ8ccDDB4hz8a7fKm9p1b/ZZvmDmcxywa
 78H/Lns8zPsinU9tmdtlMfCvzYxP8R0YbOKXck1WXY41nM9waCigGMPgxbro5JJKYvV+
 8J//iFoQnZE2EmksL7ik3ZO6Fhsr7NHd2K/uJex625vky0+08amfwQBvUEysGl4rYl4b
 kWTQ==
X-Gm-Message-State: AFq9FYJJz+IelcivyZJ4qMkNFLKyw1IrN0T77nnxpfkCVGJrL1n0NoYd
 rfQYcP4aGG3Z7GpKQDgPNx2u7bQ7crpqwSrH7HCTAPiNLJeFrV9gwk7Vd1oMm7j0qv7bTncZRZF
 RwAVUAjJLdOSIsoo6tXx53bDv4Yu+TWU=
X-Gm-Gg: AYBFou26WH4aG91a7EboB5/InpGcfS+WRtTX9qhJ/Gdv4F6ME8k6DJ60qyKdbQaba5G
 6znv3/cwwU+ol6p93mHCOgP317p4GGFuxoqv2jwSzw7MONogGKeUEyA3lMScBXPYQjctVCGfgyi
 d5zcX0pcw6FJqhGlI3tl2ECV4ULm2JXA1nJiUllXRr+BWe7Im1HTpWmsWiPhGRSA5ad8Ou/qs3/
 Lw8E0w77g4/RtKZReezc4hbIUDDb/d2nayw6Q0Q0Lg07vFfYe5INJE20K796Vv1w/bTEizPh+1L
 S+zQXxRi06KiTN8w9ZtbzHbANVu7Lm8Fc+kY55XgCK5DbvmgVMUmKptYMNlhDVDjancNN7HwzTX
 z1z6WaJkLPI4=
X-Received: by 2002:a05:7300:d788:b0:34d:861c:99b8 with SMTP id
 5a478bee46e88-351116a0c6amr738247eec.21.1790972833038; Fri, 02 Oct 2026
 13:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
 <20260825211819.100210-3-mauriciobellon@gmail.com>
 <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
In-Reply-To: <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
From: Mauricio Bellon <mauriciobellon@gmail.com>
Date: Fri, 2 Oct 2026 17:27:00 -0300
X-Gm-Features: AclHuK_CIfPFlIQiGSPAiToKVF5xWjKYzn1ROgmtUkXM-ukPSNc90K7QM4K-zcI
Message-ID: <CABNo9DeZNoJ+EW2Q2od29TD8LCmgrOg35DKKqsNA0ZJJ3g6FiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Mauricio Bellon <mbellon@lenovo.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

Hi Jerry,

Just a friendly ping on the DSC ordering question below. I'm currently
blocked on this before preparing the next revision.

Thanks,
Mauricio

Em ter., 8 de set. de 2026 =C3=A0s 17:00, Mauricio Bellon
<mauriciobellon@gmail.com> escreveu:

>
> Hi Jerry,
>
> Thanks for catching that, you're right.
>
> I went back through the sequence and confirmed that my new
> dp_set_dsc_on_rx() call runs in the pre-enable phase, before
> enable_link() performs DP link training. I had mixed up the requirement
> to configure source-side DSC before link setup with the separate
> requirement to enable DSC on the sink only after training.
>
> It happened to work with the X13 and monitor I tested, including the
> hotplug cases, but that clearly doesn't make the ordering safe for other
> sinks. I won't keep patch 2 in its current form.
>
> Would the right place for dp_set_dsc_on_rx() be at the start of the
> post-enable phase, after link training but before
> hwss->enable_stream()? Or should it stay in its current location after
> hwss->enable_stream()?
>
> I'll wait for your guidance on the intended placement before sending a
> revision. Patch 1 should be independent of this sink DSC ordering change.
>
> Thanks,
> Mauricio
>
>
> Em ter., 8 de set. de 2026 =C3=A0s 15:14, Zuo, Jerry <Jerry.Zuo@amd.com> =
escreveu:
> >
> > AMD General
> >
> > Hi Mauricio:
> >
> >      This change breaks dsc, causing black screen.
> >
> >      Sink RX dsc enable should land after link training. Writing dsc en=
able to the RX on an untrained link is too early, that should be done after=
 training. That is likely to be the main sequence regression.
> >
> > Regards,
> > Jerry
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Mauricio Bellon
> > > Sent: Tuesday, August 25, 2026 17:18
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Lin, Wayne <Wayne.Lin@amd.com>; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Mauricio Bellon <mbellon@lenovo.com>;
> > > Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher=
,
> > > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; stable@vger.kernel.org
> > > Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source D=
SC
> > >
> > > [Some people who received this message don't often get email from
> > > mauriciobellon@gmail.com. Learn why this is important at
> > > https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > From: Mauricio Bellon <mbellon@lenovo.com>
> > >
> > > Direct DisplayPort high-refresh modes using DSC and two-way ODM can
> > > commit without visible output during a 4K120-to-4K144 transition. A w=
orking
> > > 4K144 stream can also return black after long-pulse hotplug reconstru=
ction.
> > >
> > > The DPMS-on path currently enables source DSC before link enablement =
but
> > > does not enable sink DSC until after the source stream is enabled. Th=
is leaves
> > > the sink and source compression state ordered differently while the s=
tream is
> > > brought up.
> > >
> > > Enable sink DSC immediately before source DSC in the pre-enable phase=
, and
> > > remove the later redundant sink-enable operation near PPS packet
> > > programming. This establishes the order as sink DSC, source DSC, stre=
am
> > > enablement, and PPS before the compressed stream becomes visible.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > index 48b086d15..412ce52b3 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > @@ -2635,8 +2635,10 @@ static enum dc_status
> > > link_set_dpms_on_pre_enable_link(
> > >          */
> > >         if (stream->timing.flags.DSC) {
> > >                 if (dc_is_dp_signal(stream->signal) ||
> > > -                       dc_is_virtual_signal(stream->signal))
> > > +                       dc_is_virtual_signal(stream->signal)) {
> > > +                       dp_set_dsc_on_rx(pipe_ctx, true);
> > >                         link_set_dsc_enable(pipe_ctx, true);
> > > +               }
> > >         }
> > >
> > >         if (link->replay_settings.config.replay_supported
> > > && !dc_is_embedded_signal(link->connector_signal))
> > > @@ -2729,7 +2731,6 @@ static enum dc_status
> > > link_set_dpms_on_post_enable_link(
> > >         if (stream->timing.flags.DSC) {
> > >                 if (dc_is_dp_signal(stream->signal) ||
> > >                                 dc_is_virtual_signal(stream->signal))=
 {
> > > -                       dp_set_dsc_on_rx(pipe_ctx, true);
> > >                         link_set_dsc_pps_packet(pipe_ctx, true, true)=
;
> > >                 }
> > >         }
> > > --
> > > 2.53.0
> >
