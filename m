Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CBDC77B75
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9763E10E313;
	Wed,  3 May 2023 15:24:54 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507B010E11E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:24:52 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3908c252609so3170710b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 May 2023 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683127491; x=1685719491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6jN1vQ6xhUP7hY1AiLw30aAwDQ0bQaGJO+3GFkcdmQ=;
 b=NrwsbL3dge3fBLhkAkwcCfKGs+uy1RpZEIj6NWw+M9cNDaQ4xshDJbv5ke0KZL6r1/
 0ar78iSrVs5H8o1VuB7ZH60gd1rUBJft+fFUQ5N8q1+tO+VyE8URayzNkWvFKbwo4lro
 ceI/fmUZ7KuE4L/iISvHBJkUYvYmM4nYy46j1WWiiZVpi2HF1p9+MdwcueGa0irL8Vu7
 rlCBLV4ucLu162yyh5hHym75oglSoZGAyvyobT6wC236h0HHXAYYxFXHUPsbRNq91hGH
 OtWSQ5EkhF/XZsWxJluKj8tf/effFzpgoik+kCT7I7gmy6+Tf+srFSwIOoxya69i6wbB
 uDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683127491; x=1685719491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6jN1vQ6xhUP7hY1AiLw30aAwDQ0bQaGJO+3GFkcdmQ=;
 b=ENuyuqVJwxckDkXQXZZwiP6pe1VR0+FKkLq9jMRk6SkgDZqlE9fCkydsqHuCE30vbI
 MBIJIZcl/GSB+ponpYV2QcqTvlHpBAsBFIDO+k9Qa1tJftOjN+XLXkYW82hkJu5LGMaL
 LHnHDcIhSNElz1Rwn/eQjqOg8BXKKaeMUwdcoolPFSQYKQ+FtpVB71KfZ8yg7O2xq7AB
 o8cOndIdypZ5n+XWPqv6aQzhdV33KeCoivqN6Gs6W3ffBigLJ5Xqc5DoGzJ4pxOh5b2K
 weYYYF8PKSDPkA0uO5Ece8tpWHeXhVQoLQL2kTrcLLZOv5sifAo7o0tIkODTf/5X+ocu
 T3ww==
X-Gm-Message-State: AC+VfDxVUcbdVRjpBKgdXUZZGGuUknIFmmmukXiJyDKA1VvXamS0ulCN
 yn6J+XF0sGuo8wYzKRKYlUfXXG4buebXoMxrEDs=
X-Google-Smtp-Source: ACHHUZ4ve06jKLi9+Fwdet9nJ2/CrLG0Utobw+iAYBIeWVgaIa7i2HInaAiroggWTwPrPRK6CvkAm4cjXcReI/gmxos=
X-Received: by 2002:a05:6808:d4d:b0:38e:5bb0:2e88 with SMTP id
 w13-20020a0568080d4d00b0038e5bb02e88mr235550oik.35.1683127491202; Wed, 03 May
 2023 08:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230427183429.599578-1-alexander.deucher@amd.com>
 <20230427183429.599578-2-alexander.deucher@amd.com>
 <CADnq5_MAiEcCAE79NoeC5FU9eh+kgYBjD0azagRyaDvuXSEGcA@mail.gmail.com>
 <7a3221a9-242a-7a83-f380-c1d0bd8d8c9f@gmail.com>
In-Reply-To: <7a3221a9-242a-7a83-f380-c1d0bd8d8c9f@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 May 2023 11:24:39 -0400
Message-ID: <CADnq5_POJ5ULX8WeiTkxwRiTDxaG8uh_BqCKmcmHOsEddUx_Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop unused function
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 3, 2023 at 11:20=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for this one=
.
>
> Can't say much about the first one. That was just the hack because some
> bit in the IP version was re-used on SRIOV, wasn't it?

Yes, the high 2 bits of the revision number were reused for additional
information so they needed to be masked out when considering the IP
revision.  We already track those extra bits elsewhere and mask out
those bits so that IP version is never seen anymore in practice.

Alex

>
> Christian.
>
> Am 03.05.23 um 17:02 schrieb Alex Deucher:
> > Ping?
> >
> > On Thu, Apr 27, 2023 at 2:34=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >> amdgpu_discovery_get_ip_version() has not been used since
> >> commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV"=
)
> >> so drop it.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -----------------=
--
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
> >>   2 files changed, 50 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c
> >> index 76ceca05452e..b58d94dc1924 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >> @@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struc=
t amdgpu_device *adev)
> >>          return 0;
> >>   }
> >>
> >> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int h=
w_id, int number_instance,
> >> -                                   int *major, int *minor, int *revis=
ion)
> >> -{
> >> -       struct binary_header *bhdr;
> >> -       struct ip_discovery_header *ihdr;
> >> -       struct die_header *dhdr;
> >> -       struct ip *ip;
> >> -       uint16_t die_offset;
> >> -       uint16_t ip_offset;
> >> -       uint16_t num_dies;
> >> -       uint16_t num_ips;
> >> -       int i, j;
> >> -
> >> -       if (!adev->mman.discovery_bin) {
> >> -               DRM_ERROR("ip discovery uninitialized\n");
> >> -               return -EINVAL;
> >> -       }
> >> -
> >> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> >> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_b=
in +
> >> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].off=
set));
> >> -       num_dies =3D le16_to_cpu(ihdr->num_dies);
> >> -
> >> -       for (i =3D 0; i < num_dies; i++) {
> >> -               die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offse=
t);
> >> -               dhdr =3D (struct die_header *)(adev->mman.discovery_bi=
n + die_offset);
> >> -               num_ips =3D le16_to_cpu(dhdr->num_ips);
> >> -               ip_offset =3D die_offset + sizeof(*dhdr);
> >> -
> >> -               for (j =3D 0; j < num_ips; j++) {
> >> -                       ip =3D (struct ip *)(adev->mman.discovery_bin =
+ ip_offset);
> >> -
> >> -                       if ((le16_to_cpu(ip->hw_id) =3D=3D hw_id) && (=
ip->number_instance =3D=3D number_instance)) {
> >> -                               if (major)
> >> -                                       *major =3D ip->major;
> >> -                               if (minor)
> >> -                                       *minor =3D ip->minor;
> >> -                               if (revision)
> >> -                                       *revision =3D ip->revision;
> >> -                               return 0;
> >> -                       }
> >> -                       ip_offset +=3D struct_size(ip, base_address, i=
p->num_base_address);
> >> -               }
> >> -       }
> >> -
> >> -       return -EINVAL;
> >> -}
> >> -
> >>   static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
> >>   {
> >>          int vcn_harvest_count =3D 0;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.h
> >> index 8563dd4a7dc2..63ec6924b907 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> >> @@ -28,8 +28,6 @@
> >>   #define DISCOVERY_TMR_OFFSET    (64 << 10)
> >>
> >>   void amdgpu_discovery_fini(struct amdgpu_device *adev);
> >> -int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int h=
w_id, int number_instance,
> >> -                                    int *major, int *minor, int *revi=
sion);
> >>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
> >>
> >>   #endif /* __AMDGPU_DISCOVERY__ */
> >> --
> >> 2.40.0
> >>
>
