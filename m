Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18157C43602
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C115E10F208;
	Thu,  2 Jul 2026 08:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="hyWVuM6L";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2304F10EF98
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 18:14:54 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aeb18fe7ceso624602e87.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 11:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782929693; cv=none;
 d=google.com; s=arc-20260327;
 b=m2zvr6GJ+26TQgvqyKKaCJWvENa9yKF58d1I6nNIerUCYBlx0dbua+ExOOnYBEoaH8
 Q1zO444cPVYkn4yf9RywlfHX0E4kav+tAtN/RpUMnPPgnEg46QoDGaShjO2RsGncAkNI
 cSCRTEeyavYuogf9pQ+IeVlp0zhfEed+R0f323nqNs7CWiYUzLgbRT0vY/hhQg/eXnBx
 5vPxmsxfePJiVANfgIA2e8OM2vGQJMRnWZoteEuhkvN7CQ9gSNAQNLq6jwppQ7tCP0uk
 BilfUEzaogO2vtEk98dcWZWtSUcJF3JTRPflYbxUgcEXeHFpqWN9kC54lzQVl/aQcTmg
 lWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 fh=GcSmhpwD/ualGAn8QJHVAfv+0NXFWfLJU/MCyePlngI=;
 b=PX69Tz2UUv5IMefrIm+QBtasNocvcoSffifIJ6PG8wwrIBntgEe8gQRnj8MnxXUllq
 ujdTtjngf1AscVG4SVqetSg/Gzbyl1OWjJRPhtf6B4OahqwLN1OP9v0S4LMfl3HeJ1GD
 D+92iOgjyd7R417Bf1c4SI0Gp0vmal+in8VC89azMbHr4ZFxtHYG1YkniT2dAvuIVlGi
 BJGSgS5m2ssjEfLjvdimraBCptuMRoHtK//lZDT2zVT9oDYUB0OAYLPanhuVWXB/3UNg
 a8Dn4/x4evchHrFqSYntBHcag8YM/oNXOHWHJJQltLpuORA5OTRcYsSQwZhPA+SBlalr
 /JAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782929693; x=1783534493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 b=hyWVuM6LLXE7x/C3yIiWPFg94VTeFypfesqYKCM/qd34t8gddcBQfbDHbfJlW+V9oT
 ENun9w+ZFAUH9Q7ILuuaOP60AwC5sL8KIvUuRQRQv4IzNsAkY/LgV3Xg5G9mAtLMAEIx
 89U+Ggc8k8T1U6JWXNwipqqixsEDdonO8STwRRAGSLwys9+AGOlfvj4PmSBidKtHCz7k
 9y5ho9+XvPfVbF9tCuLd29Z73LnTJgIk8OacqndwcZYdvAIQOGgDKUIO0k3g/+bwa743
 TVW7TcDk251zCrc8cZR99rurhQ3uBuVdOKbb9WolNX1R5hqd9Lu8w2M585Sx8BU4DSpB
 qe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929693; x=1783534493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ho4dYzPzvHEFLwOI8+yqAprMuP6uwFHEAkeRfcmKHsY=;
 b=e7HRNkkQuONjApYh/EeAYMjw6E9xTJ8l3LLs+i9xEh0CBQqtcX75viG4hDP8l06Ijn
 aLWhMI2q2asTfTmM0EIRIJHg9tCTF1LmYZr89WwTYdo/sZgOXypPOhprWBtViqZ4suWh
 FgP5lCAL/A/BvU9AMvoZ2uYrsPR3Cz/6xsyZMVWENNsg9Y7VXEyO2uTyhRdcYQydUxcy
 M+r8rZNU54FZz+8tR7aJ3DdqtpeJrfym8smclugnxZapm89naJx2Nicvrjl2nAUDFnRQ
 m40LqGUfA1Ersy+9b8VqiXlgRMdaeNktdYouCmBOHcuqdvTYY6p0tAEL1qliXx2Z0u81
 Strw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZfwJ5wkLZK89sHosX0GdNiEh0zVMJbaVGOcLUXZf3wmYJV95vnAxvA6yC7VDqqKhuXpBWYTJ/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT1sP2kn0vX71+TlmVv46wezuU9qxLgvvK8I5cQO9UrFzSMuFP
 th++eJtBZHqizMj5pFM3HAgrdWRgz7f8cOJyTPktATojSv++AuIZTDw6RHHKkcnBjj+wVZyREC0
 SnAr6xygysE+V7mcSAnI7nndLFHxIA85C3sHG4wlEug==
X-Gm-Gg: AfdE7cmBMObDUjmm++6Bn1dJe2Y37YmI42c5+3GHbv+5fW9fSX43I+tlfRaC/fqNOQS
 UkJwcSbQyYGpIuf4EIJk7TCenIGRiLO13Y9ZgvJSi7eby8r1L6glstOHOiDxOaHL8vGfyXhBtKZ
 EJEIJpBG0WwUV775WWTeapKChuJabmHRrz0OWNSk1vZVhu+3xhcqOFM2ZBJ1BdyzPEG4LO5VHU6
 K43cKmvioS946PgL5hDA0QA5ZirFfFC+ZuTuhPuQTPYjtU62rDjTfUlG4BxNPl5LgQpuyVtzZPA
 LbY9y5Cwnm5AH9o/Qjp+S5URDH/NiAOPro7AlQdvcy9StRImsEx9Ba61
X-Received: by 2002:a05:6512:6887:b0:5ae:c210:1a24 with SMTP id
 2adb3069b0e04-5aec679794dmr446560e87.6.1782929693093; Wed, 01 Jul 2026
 11:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
 <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
In-Reply-To: <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
From: Tiago Gomes Dourado de Oliveira <tiagodourado@usp.br>
Date: Wed, 1 Jul 2026 15:14:41 -0300
X-Gm-Features: AVVi8Cfz28S6QQpc728eGJ7jRF7I_P-iT0Kc_pfoJctYsb4JGLeCjJvMKVsUn_A
Message-ID: <CAJRPy2G-X_uaHZWLWjXVBUFJsZ4Xq-mWmRrmsTPrFs7NyPdXow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com, 
 simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>, 
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 Jul 2026 08:07:22 +0000
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

On Fri, Jun 26, 2026 at 6:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, Jun 26, 2026 at 8:14=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 6/26/26 04:59, Tiago Dourado wrote:
> > > The jpeg_v3_0_process_interrupt function is identical to
> > > jpeg_v2_0_process_interrupt. Remove the duplicate implementation
> > > in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_fun=
cs struct.
> > > Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
> > > cross-version reuse.
> >
> > Usually we intentionally don't do any cross IP version reuse, that has =
cause tons of problems in the past.
> >
> > @Leo any particular reason why we don't have a separate SRCID file for =
VCN3?
> >
> > My educated guess is that nothing changed compared to VCN2 and nobody c=
ared to re-generate the file from the HW definition.
> >
>
> I think it's the same so no need for a separate one.  There are a
> number of existing places where VCN or jpeg use one function
> implementation across multiple generations.
>

Thanks for the feedback. Given what both of you pointed out, what do
you suggest that we can do?

Regards,
Tiago

> Alex
>
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
> > > Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
> > > ---
> > >
> > > v2:
> > > - Assigned function directly to irq_funcs instead of using a macro.
> > >
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
> > >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
> > >  3 files changed, 6 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_0.c
> > > index 9fe8d10ab..9006fc57e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> > > @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct a=
mdgpu_device *adev,
> > >       return 0;
> > >  }
> > >
> > > -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > >                                     struct amdgpu_irq_src *source,
> > >                                     struct amdgpu_iv_entry *entry)
> > >  {
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_0.h
> > > index 654e43e83..4f400fb47 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
> > > @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgp=
u_ring *ring,
> > >  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t=
 reg, uint32_t val);
> > >  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count=
);
> > >
> > > +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
> > > +                             struct amdgpu_irq_src *source,
> > > +                             struct amdgpu_iv_entry *entry);
> > > +
> > >  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
> > >
> > >  #endif /* __JPEG_V2_0_H__ */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v3_0.c
> > > index 98f5e0622..2f3a5a17e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> > > @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct =
amdgpu_device *adev,
> > >       return 0;
> > >  }
> > >
> > > -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
> > > -                                   struct amdgpu_irq_src *source,
> > > -                                   struct amdgpu_iv_entry *entry)
> > > -{
> > > -     DRM_DEBUG("IH: JPEG TRAP\n");
> > > -
> > > -     switch (entry->src_id) {
> > > -     case VCN_2_0__SRCID__JPEG_DECODE:
> > > -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > > -             break;
> > > -     default:
> > > -             DRM_ERROR("Unhandled interrupt: %d %d\n",
> > > -                       entry->src_id, entry->src_data[0]);
> > > -             break;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > >  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> > >                               unsigned int vmid,
> > >                               struct amdgpu_fence *timedout_fence)
> > > @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct a=
mdgpu_device *adev)
> > >
> > >  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs =3D {
> > >       .set =3D jpeg_v3_0_set_interrupt_state,
> > > -     .process =3D jpeg_v3_0_process_interrupt,
> > > +     .process =3D jpeg_v2_0_process_interrupt,
> > >  };
> > >
> > >  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
> >
