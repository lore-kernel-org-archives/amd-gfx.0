Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A9FC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 18:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C5710EBAB;
	Thu, 13 Apr 2023 18:24:21 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D1810EBAB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 18:24:19 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id xd13so5738842ejb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681410256; x=1684002256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku9gRQuLVWJ9nY/Am2FOOCqxmL/I93x3A+ektHrct4A=;
 b=VctV0WSGElrQmO/10bkw6JxrO+jH1umsZu7HsWsKx6yzt3cfSHDy5Jrw87tyQv/E6p
 JwnFD+PY/EEmOJFmq8hE/iwfWrspYEYseU/WO6pX4usbvlk+ntjkZ7Rj9b1WLfokJiin
 4GsAttmglO4WeaB568Yw0REi37WLXQKPNC5EjMHT1wTX5lWWCWmMy6Fi3vQAslH+Vtwg
 f2KFnriWo/5psyp68f/SJrV+fCrHiCgOvpBCqvWy4Z4PGMFRYN1tsAIxGg71LuNn4JpK
 jSFMkzi0AayW+/3t86v8JXZqMJ+4+monjVnwLpTb03G2IDIHGnT6aUtRk/1jyTkFUTAs
 3MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681410256; x=1684002256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ku9gRQuLVWJ9nY/Am2FOOCqxmL/I93x3A+ektHrct4A=;
 b=ZSKwfWxxi012My2ND7FTDNwHvTIOduzQWOnhXfDsWsrlkk3mxAwrq0eRR0UTblYvHy
 Qnej7kGTbq0XGG+uak+dUCrNE2+QjXxCPAqbgEQ1ekxb4nxoxoEXIyG489RtZM+R546F
 z0HXfo28rsgs4yYVh7nH0efB0U2G2nD1hoPNPyGkOCQKEI+Yv/tCzTtksUJoO5ESQndD
 dU+MBk/bHwsPpQuGTgLHD1NncofueQ8xuRJVhWcztT0bwCS42ftUdJmcRTueYFTeB2i4
 FQd9fTYnHwzyWFks/aZBV2nJjEt3/UXOhHstUgJYJuxxphQUGI0EI/lGKwLLi/QCusWi
 Gssg==
X-Gm-Message-State: AAQBX9fFKLEO3j1nxDMugdu4rcT4eW9HMaOTodU08fkmW5GWJhOaxuul
 5pgFWpUKkpdJ4/pXY9du7+p7/kyL1YVL3Go9J1M=
X-Google-Smtp-Source: AKy350a6OmHQT7Bb36zZJIaAH0TmYSWeeZWKtYGlVGoOr9yuBU9kY+waNfxrmqIVaZEwkqc6H0atO9ntC0SUGxq3FOk=
X-Received: by 2002:a17:906:37cd:b0:93d:1b82:3c13 with SMTP id
 o13-20020a17090637cd00b0093d1b823c13mr1737135ejc.7.1681410256444; Thu, 13 Apr
 2023 11:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
 <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
 <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
 <CADnq5_MrY3QtU_--B=OYD+_+nx6jNyzJfOxBzfoPrmeLJC6h3Q@mail.gmail.com>
 <8b2df4e1-ad00-a834-3382-d25f1c667978@gmail.com>
 <CADnq5_PLfseKjhYZe54poe+hE4-cL+Fgqc=sZ=QabN1Xqud0Lg@mail.gmail.com>
In-Reply-To: <CADnq5_PLfseKjhYZe54poe+hE4-cL+Fgqc=sZ=QabN1Xqud0Lg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 13 Apr 2023 14:23:40 -0400
Message-ID: <CAAxE2A5XxySNG2BqcXZKhq=wyC7DnhONLtyFLgRx4x65K3ZbTA@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000ea03b05f93bd517"
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000000ea03b05f93bd517
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm OK with that.

Marek

On Thu, Apr 13, 2023 at 12:56=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:

> On Thu, Apr 13, 2023 at 11:54=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 13.04.23 um 14:26 schrieb Alex Deucher:
> > > On Thu, Apr 13, 2023 at 7:32=E2=80=AFAM Christian K=C3=B6nig
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >> Ok, then we have a problem.
> > >>
> > >> Alex what do you think?
> > > If you program it to 0, FW skips the GDS backup I think so UMD's can
> > > decide whether they want to use it or not, depending on whether they
> > > use GDS.
> >
> > Yeah, but when Mesa isn't using it we have a hard way justifying to
> > upstream that because it isn't tested at all.
>
> Well, the interface would still get used, it's just that mesa would
> likely only ever pass 0 for the virtual address.  It's just a
> passthrough to the packet.  If we discover we need it at some point,
> it would be nice to not have to add a new interface to add it.
>
> Alex
>
> >
> > Christian.
> >
> > >
> > > Alex
> > >
> > >
> > >> Christian.
> > >>
> > >> Am 13.04.23 um 11:21 schrieb Marek Ol=C5=A1=C3=A1k:
> > >>
> > >> That's not why it was removed. It was removed because userspace
> doesn't use GDS memory and gds_va is always going to be 0.
> > >>
> > >> Firmware shouldn't use it because using it would increase preemption
> latency.
> > >>
> > >> Marek
> > >>
> > >> On Sun, Apr 9, 2023, 11:21 Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
> > >>> We removed the GDS information because they were unnecessary. The
> GDS size was already part of the device info before we added the shadow
> info.
> > >>>
> > >>> But as far as I know the firmware needs valid VAs for all three
> buffers or won't work correctly.
> > >>>
> > >>> Christian.
> > >>>
> > >>> Am 06.04.23 um 17:01 schrieb Marek Ol=C5=A1=C3=A1k:
> > >>>
> > >>> There is no GDS shadowing info in the device info uapi, so userspac=
e
> can't create any GDS buffer and thus can't have any GDS va. It's a uapi
> issue, not what firmware wants to do.
> > >>>
> > >>> Marek
> > >>>
> > >>> On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
> > >>>> That's what I thought as well, but Mitch/Hans insisted on that.
> > >>>>
> > >>>> We should probably double check internally.
> > >>>>
> > >>>> Christian.
> > >>>>
> > >>>> Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:
> > >>>>
> > >>>> GDS memory isn't used on gfx11. Only GDS OA is used.
> > >>>>
> > >>>> Marek
> > >>>>
> > >>>> On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> > >>>>> Why that?
> > >>>>>
> > >>>>> This is the save buffer for GDS, not the old style GDS BOs.
> > >>>>>
> > >>>>> Christian.
> > >>>>>
> > >>>>> Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:
> > >>>>>
> > >>>>> gds_va is unnecessary.
> > >>>>>
> > >>>>> Marek
> > >>>>>
> > >>>>> On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <
> alexander.deucher@amd.com> wrote:
> > >>>>>> For GFX11, the UMD needs to allocate some shadow buffers
> > >>>>>> to be used for preemption.  The UMD allocates the buffers
> > >>>>>> and passes the GPU virtual address to the kernel since the
> > >>>>>> kernel will program the packet that specified these
> > >>>>>> addresses as part of its IB submission frame.
> > >>>>>>
> > >>>>>> v2: UMD passes shadow init to tell kernel when to initialize
> > >>>>>>      the shadow
> > >>>>>>
> > >>>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >>>>>> ---
> > >>>>>>   include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
> > >>>>>>   1 file changed, 10 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > >>>>>> index b6eb90df5d05..3d9474af6566 100644
> > >>>>>> --- a/include/uapi/drm/amdgpu_drm.h
> > >>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
> > >>>>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
> > >>>>>>   #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
> > >>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
> > >>>>>>   #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
> > >>>>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
> > >>>>>>
> > >>>>>>   struct drm_amdgpu_cs_chunk {
> > >>>>>>          __u32           chunk_id;
> > >>>>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
> > >>>>>>          };
> > >>>>>>   };
> > >>>>>>
> > >>>>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW
>  0x1
> > >>>>>> +
> > >>>>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
> > >>>>>> +       __u64 shadow_va;
> > >>>>>> +       __u64 csa_va;
> > >>>>>> +       __u64 gds_va;
> > >>>>>> +       __u64 flags;
> > >>>>>> +};
> > >>>>>> +
> > >>>>>>   /*
> > >>>>>>    *  Query h/w info: Flag that this is integrated (a.h.a.
> fusion) GPU
> > >>>>>>    *
> > >>>>>> --
> > >>>>>> 2.39.2
> > >>>>>>
> >
>

--0000000000000ea03b05f93bd517
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m OK with that.</div><div><br></div><div>Marek<=
br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Apr 13, 2023 at 12:56=E2=80=AFPM Alex Deucher &lt;<a href=
=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Apr 13, 2023=
 at 11:54=E2=80=AFAM Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">c=
koenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Am 13.04.23 um 14:26 schrieb Alex Deucher:<br>
&gt; &gt; On Thu, Apr 13, 2023 at 7:32=E2=80=AFAM Christian K=C3=B6nig<br>
&gt; &gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D=
"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt; Ok, then we have a problem.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Alex what do you think?<br>
&gt; &gt; If you program it to 0, FW skips the GDS backup I think so UMD&#3=
9;s can<br>
&gt; &gt; decide whether they want to use it or not, depending on whether t=
hey<br>
&gt; &gt; use GDS.<br>
&gt;<br>
&gt; Yeah, but when Mesa isn&#39;t using it we have a hard way justifying t=
o<br>
&gt; upstream that because it isn&#39;t tested at all.<br>
<br>
Well, the interface would still get used, it&#39;s just that mesa would<br>
likely only ever pass 0 for the virtual address.=C2=A0 It&#39;s just a<br>
passthrough to the packet.=C2=A0 If we discover we need it at some point,<b=
r>
it would be nice to not have to add a new interface to add it.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; Christian.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Am 13.04.23 um 11:21 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; That&#39;s not why it was removed. It was removed because use=
rspace doesn&#39;t use GDS memory and gds_va is always going to be 0.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Firmware shouldn&#39;t use it because using it would increase=
 preemption latency.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Marek<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Sun, Apr 9, 2023, 11:21 Christian K=C3=B6nig &lt;<a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leic=
htzumerken@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt; We removed the GDS information because they were unnecess=
ary. The GDS size was already part of the device info before we added the s=
hadow info.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; But as far as I know the firmware needs valid VAs for all=
 three buffers or won&#39;t work correctly.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Am 06.04.23 um 17:01 schrieb Marek Ol=C5=A1=C3=A1k:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; There is no GDS shadowing info in the device info uapi, s=
o userspace can&#39;t create any GDS buffer and thus can&#39;t have any GDS=
 va. It&#39;s a uapi issue, not what firmware wants to do.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Marek<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Christian K=C3=B6n=
ig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank=
">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt; That&#39;s what I thought as well, but Mitch/Hans ins=
isted on that.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; We should probably double check internally.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:<b=
r>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; GDS memory isn&#39;t used on gfx11. Only GDS OA is us=
ed.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Marek<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=
=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">ch=
ristian.koenig@amd.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; Why that?<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; This is the save buffer for GDS, not the old styl=
e GDS BOs.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1=
k:<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; gds_va is unnecessary.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Marek<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deuc=
her &lt;<a href=3D"mailto:alexander.deucher@amd.com" target=3D"_blank">alex=
ander.deucher@amd.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; For GFX11, the UMD needs to allocate some sha=
dow buffers<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; to be used for preemption.=C2=A0 The UMD allo=
cates the buffers<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; and passes the GPU virtual address to the ker=
nel since the<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; kernel will program the packet that specified=
 these<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; addresses as part of its IB submission frame.=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; v2: UMD passes shadow init to tell kernel whe=
n to initialize<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 the shadow<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Reviewed-by: Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"ma=
ilto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com=
</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0include/uapi/drm/amdgpu_drm.h | 1=
0 ++++++++++<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+)<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/=
include/uapi/drm/amdgpu_drm.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; index b6eb90df5d05..3d9474af6566 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va =
{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0#define AMDGPU_CHUNK_ID_SCHEDULED=
_DEPENDENCIES 0x07<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_T=
IMELINE_WAIT=C2=A0 =C2=A0 0x08<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_T=
IMELINE_SIGNAL=C2=A0 0x09<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW=C2=A0 =
=C2=A00x0a<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0struct drm_amdgpu_cs_chunk {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chunk_id;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chu=
nk_data {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_=
INIT_SHADOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 shadow_va;<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 csa_va;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 gds_va;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 flags;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +};<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0/*<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 *=C2=A0 Query h/w info: Flag tha=
t this is integrated (a.h.a. fusion) GPU<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 *<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2.39.2<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;<br>
</blockquote></div>

--0000000000000ea03b05f93bd517--
