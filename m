Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEB3CCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 05:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0395810E261;
	Wed, 15 Oct 2025 05:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkH750/w";
	dkim-atps=neutral
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B2D10E261
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 05:46:07 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7ad1a815bd2so977820a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760507166; x=1761111966; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewVExFn951MGNPNN4d6rHoTt3v4ew66IxMf3yYm8xSQ=;
 b=SkH750/wbe6ekSxsMOyyczhhMoDcPz4B0I09gowmu4rqBOieIcWDNwHwynSSVfJf92
 G5ZhYEbXvncaeIdli2EERmAP2naF5oCewaPi7KbCcGbE1pR+U6oqnuD/SlpkRAESWnql
 Iyr1Fg4dhCRegnR5A5ypYPDZxKEcGq083hnToTf9D51votQR+AaCWf834eThVMDEx51o
 Ir8lLzwgfbmiCFmCnhjlNe5gjto+mfP7NzYInRzZiVQ0884RJIQ5mokyjhl+pTG/efps
 5KNtRfjYP8mnGX7IZ4crN4B9Q3MeybGvNYfHINHplGbCdvKh0uuWsHY5+S7b73XTaiDu
 j86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760507166; x=1761111966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewVExFn951MGNPNN4d6rHoTt3v4ew66IxMf3yYm8xSQ=;
 b=uRXTueTZnXuqc1CrZvIetijzqsTwcW45S/jATZ3icPhba6yDRwljTyglZ4iqQ/gnSG
 9pXwwRPhds3AlulsRTsrERY1qMCXLauI+6Dl7zYRUJE8bkof4Jt1l3cqA+DKAoKmBgEQ
 mr1ImeuwlMigQcHJ09loA9A6qiav0LeWburG3J9zMZ787namNOBkPkmHd4NG1eeGL+FL
 4/5RNg1TS9gkMGwFx7+0hztkZy4kuu56EJwKP9kHkPs8DTv6UBKPt5HeUqzrN048t9RU
 F5VWV1OhRpgjItpQZKITgJ2UILMEBayVlCM++amQslZvp4R1saw+DsrzNcU5QjmBZlom
 T1vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNM8yeB6Mltl+k+KLHqqesY4NiXWbNrTHM0K8petf3xCR0OkqkX/xZjF7QS1zN840JgIL57OZ4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5FuTo8szuOvlox8VA3/1BAeMlPP8MW8bcQPTjPM7CKBArWJRH
 2Y2LSJRq4NHcYo7JsJiqCjUV1V1X68P1EmKn2YG6HAj+ALTLafnuD4Xq0WEFOQhAOvktFJ2nDAD
 0XQjVrnOGfI1Xc5RNpZieIGSPKozD338=
X-Gm-Gg: ASbGnctmblJnbpSrFx3rZ2X+sug4kFKuhIvWaTYMZdqmQ5USXsTqmElCGmbrZVfI/hV
 b5MaUhrkG0iLyVrGRbzAG3tlFt/0uZqPhlsTXWD2RP9MR1bkbLxHZ/d1LV1Vm5VTBKhSESvaHex
 ixTizB8yKwTJLKS5S83juTF+U8tvyr0Y24Vw2VD3/gV9l5oQPXEOwBEQrfTznVZPr/MrkPM7YkE
 fdmfVHZSX3ZdnfJA9ql979x5zF7LaA9NsK5ueM=
X-Google-Smtp-Source: AGHT+IGFcByO9tw5IybyeaBy7/fwDRldc1V/GTluMZe2mtzrdIXp06qyme0jFb7pJfLAueSEnnngiQW+8oaUgUHdw+I=
X-Received: by 2002:a05:6808:50a0:b0:43f:1dec:96a with SMTP id
 5614622812f47-4417b1a456emr6852853b6e.0.1760507166314; Tue, 14 Oct 2025
 22:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
 <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
 <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
 <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
 <CAAxE2A6G2uB=S8FQ7-cEO0vYc+bppa=fjEG0BHyzHivEG8FCBA@mail.gmail.com>
 <CADnq5_Nmq7E7UaPV6o=i0vhy-WmfgE1EG+NDs=Fstyi1sRDT=Q@mail.gmail.com>
In-Reply-To: <CADnq5_Nmq7E7UaPV6o=i0vhy-WmfgE1EG+NDs=Fstyi1sRDT=Q@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 15 Oct 2025 01:45:29 -0400
X-Gm-Features: AS18NWA92zfCfmnGgGDhW0wwP3UcnQqBN1w8V7Ydg3TIYBJl9lUU_dIRZ2XVAJ4
Message-ID: <CAAxE2A4MxiqZbamseYb_k9dzMQgWLtO=7nx3uyucKoCQrMkU3A@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Content-Type: multipart/alternative; boundary="00000000000045d67206412c04d4"
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

--00000000000045d67206412c04d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 2:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Tue, Oct 14, 2025 at 2:10=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > On Tue, Oct 14, 2025, 12:37 Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >> On Tue, Oct 14, 2025 at 11:11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo=
@gmail.com> wrote:
> >> >
> >> > On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com>
> wrote:
> >> >>
> >> >> On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <mara=
eo@gmail.com>
> wrote:
> >> >> >
> >> >> > On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher <
> alexdeucher@gmail.com> wrote:
> >> >> >>
> >> >> >> On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <
> Prike.Liang@amd.com> wrote:
> >> >> >> >
> >> >> >> > [Public]
> >> >> >> >
> >> >> >> > Regards,
> >> >> >> >       Prike
> >> >> >> >
> >> >> >> > > -----Original Message-----
> >> >> >> > > From: Alex Deucher <alexdeucher@gmail.com>
> >> >> >> > > Sent: Monday, October 13, 2025 9:44 PM
> >> >> >> > > To: Liang, Prike <Prike.Liang@amd.com>
> >> >> >> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >> >> >> > > gfx@lists.freedesktop.org
> >> >> >> > > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and
> alignment to shadow
> >> >> >> > > info
> >> >> >> > >
> >> >> >> > > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <
> Prike.Liang@amd.com> wrote:
> >> >> >> > > >
> >> >> >> > > > [Public]
> >> >> >> > > >
> >> >> >> > > > We may need to update the userspace EOP buffer request;
> otherwise, the EOP
> >> >> >> > > buffer validation may fail.
> >> >> >> > >
> >> >> >> > > Existing userspace should be ok.  It currently uses PAGE_SIZ=
E
> which is larger than
> >> >> >> > > 2048.
> >> >> >> > The mesa uses the EOP size as max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kernel
> validates the eop buffer can be successful at this point.
> >> >> >> >
> >> >> >> > But the mesa may need to use the shadow_info->eop_size as well
> in the future?
> >> >> >>
> >> >> >> Ideally mesa would query the kernel to get the proper minimum
> size.
> >> >> >> Yogesh will be looking at this.
> >> >> >>
> >> >> >> Alex
> >> >> >
> >> >> >
> >> >> > Does the EOP buffer store privileged information? What is its
> content?
> >> >>
> >> >> It stores end of pipe events for the compute queue generated from
> >> >> things like RELEASE_MEM or AQL packets.  They are specific to each
> >> >> user queue.  In theory corrupting or messing with the data in the
> >> >> buffer should only affect that queue.
> >> >
> >> >
> >> > RELEASE_MEM has a hidden implicit VMID parameter. That's why it's
> important to know whether it's stored in the EOP buffer that can be
> overwritten by userspace.
> >>
> >> My understanding is that that is only relevant for kernel queues where
> >> the vmid comes from the IB for each job.  For user queues, the vmid is
> >> determined by the HQD so that is unused in the user queue case.
> >
> >
> > This is NAK'd until a proof is given that the EOP buffer can't be used
> to change the VMID of EOP fence writes.
>
> The EOP buffer allocation is already in use.  It's used for compute
> user queues for both ROCm and KGD.  All this patch does is allow
> userspace to query what the size requirements are.  If we find a
> problem in the EOP handling in firmware we should fix it in firmware,
> but the software side is already in use.
>

So are you going to just brush it off? Aren't you interested in at least
verifying whether it's possible to do privilege escalation with it even if
it's already used? Do you really just want to merge this quickly without
verifying whether it allows userspace to write any physical address because
"userspace already uses it"? Do you really not want to know what is
possible to do with the EOP buffer?

Marek

--00000000000045d67206412c04d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Oct 14, 2025 at 2:49=E2=80=AFPM Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Tue, Oct 14, 2025 at 2:10=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D=
"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; On Tue, Oct 14, 2025, 12:37 Alex Deucher &lt;<a href=3D"mailto:alexdeu=
cher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Oct 14, 2025 at 11:11=E2=80=AFAM Marek Ol=C5=A1=C3=A1k &lt=
;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>=
&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Tue, Oct 14, 2025 at 10:12=E2=80=AFAM Alex Deucher &lt;<a =
href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.c=
om</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Tue, Oct 14, 2025 at 2:49=E2=80=AFAM Marek Ol=C5=A1=C3=
=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail=
.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Alex Deucher=
 &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, =
Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_blank">Prike.Li=
ang@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; [Public]<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Prike<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; -----Original Message-----<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; From: Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt;<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; Sent: Monday, October 13, 2025 9:44 PM=
<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; To: Liang, Prike &lt;<a href=3D"mailto=
:Prike.Liang@amd.com" target=3D"_blank">Prike.Liang@amd.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"=
mailto:Alexander.Deucher@amd.com" target=3D"_blank">Alexander.Deucher@amd.c=
om</a>&gt;; amd-<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; <a href=3D"mailto:gfx@lists.freedeskto=
p.org" target=3D"_blank">gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; Subject: Re: [PATCH 3/7] drm/amdgpu/gf=
x: add eop size and alignment to shadow<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; info<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; On Mon, Oct 13, 2025 at 4:54=E2=80=AFA=
M Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com" target=3D"_blank"=
>Prike.Liang@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; &gt; [Public]<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; &gt; We may need to update the userspa=
ce EOP buffer request; otherwise, the EOP<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; buffer validation may fail.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; Existing userspace should be ok.=C2=A0=
 It currently uses PAGE_SIZE which is larger than<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &gt; 2048.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; The mesa uses the EOP size as max_t(u32, PA=
GE_SIZE, AMDGPU_GPU_PAGE_SIZE) which is sees larger than 2048, so the kerne=
l validates the eop buffer can be successful at this point.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; But the mesa may need to use the shadow_inf=
o-&gt;eop_size as well in the future?<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Ideally mesa would query the kernel to get the p=
roper minimum size.<br>
&gt;&gt; &gt;&gt; &gt;&gt; Yogesh will be looking at this.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; Alex<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Does the EOP buffer store privileged information? Wh=
at is its content?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; It stores end of pipe events for the compute queue genera=
ted from<br>
&gt;&gt; &gt;&gt; things like RELEASE_MEM or AQL packets.=C2=A0 They are sp=
ecific to each<br>
&gt;&gt; &gt;&gt; user queue.=C2=A0 In theory corrupting or messing with th=
e data in the<br>
&gt;&gt; &gt;&gt; buffer should only affect that queue.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; RELEASE_MEM has a hidden implicit VMID parameter. That&#39;s =
why it&#39;s important to know whether it&#39;s stored in the EOP buffer th=
at can be overwritten by userspace.<br>
&gt;&gt;<br>
&gt;&gt; My understanding is that that is only relevant for kernel queues w=
here<br>
&gt;&gt; the vmid comes from the IB for each job.=C2=A0 For user queues, th=
e vmid is<br>
&gt;&gt; determined by the HQD so that is unused in the user queue case.<br=
>
&gt;<br>
&gt;<br>
&gt; This is NAK&#39;d until a proof is given that the EOP buffer can&#39;t=
 be used to change the VMID of EOP fence writes.<br>
<br>
The EOP buffer allocation is already in use.=C2=A0 It&#39;s used for comput=
e<br>
user queues for both ROCm and KGD.=C2=A0 All this patch does is allow<br>
userspace to query what the size requirements are.=C2=A0 If we find a<br>
problem in the EOP handling in firmware we should fix it in firmware,<br>
but the software side is already in use.<br></blockquote><div><br></div>So =
are you going to just brush it off? Aren&#39;t you interested in at least v=
erifying whether it&#39;s possible to do privilege escalation with it even =
if it&#39;s already used? Do you really just want to merge this quickly wit=
hout verifying whether it allows userspace to write any physical address be=
cause &quot;userspace already uses it&quot;? Do you really not want to know=
 what is possible to do with the EOP buffer?</div><div class=3D"gmail_quote=
 gmail_quote_container"><br></div><div class=3D"gmail_quote gmail_quote_con=
tainer">Marek</div></div>

--00000000000045d67206412c04d4--
