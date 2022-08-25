Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA65AC64990
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 14:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1127110E34D;
	Thu, 25 Aug 2022 14:26:40 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14C210E34D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 14:26:35 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-f2a4c51c45so25084737fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=G/Ig1A5g72nhRrRqV5ATdqiwe9CwrLoOJ7z2TePHxb0=;
 b=BmnwDLY1w/sOfP7JbS/3HztWT2YW5idx8d9KWBJhtP1JlmV+Rtk/eUHKnm3gUSqkVO
 MW2T2MXU/tt0Lu5KK7pMW4EKB2+8IOlEzCYllk2oWrR9Rg6aUq8yNxS+ZKEtYIOwmr8f
 eNieCdN49D0jEExbcCzndLfUOeF9y9XgHI19UaohgwbsYg+p+Zqfk+mMNQ2vF8Y2YmgR
 R7JlQGJ7U8sbM2o9L6Iq1rsYHAgs9IXnmgFSAm8XOacwQeksv9ovXWPbWZ2/SDMLmHou
 06V4GIVB3t1T3kq3axZwQaZOgRb2Z2rV8KxYlxwbJOw2by4lLHrnnH9MNyh6Iog8Og5i
 8XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=G/Ig1A5g72nhRrRqV5ATdqiwe9CwrLoOJ7z2TePHxb0=;
 b=5ht6+YTSI8y0Ujc8LPb09CbhvZbzVED2lHFmwCVLtnkc/+WwbK7GD5zvF29+w+ybvE
 C7Wm7GaUFAZBuGZDEFWOiK3PuDIzMQh6eUQqkbc5gXQ+zcfOXMCVQnii2MqA08N057r5
 kfHWugZJd2iMiW8lxzxbp4vgSEPj45p6i1oZcJNxO0c6PWQVk6oHqTIca5LMFasXLzEi
 Nv8hpojEsVrlC8XwJrzx/JMw3jeEHHk/wa0Jj43CTlsj1n72A9LePipzLJKwZ8euB3Sx
 B5TXdaON5iTKn/NR6m3PcnzneiaBxCUNdQ/rDIISsM7bJqXn+9kxlbQMAg5Uv7ISZO/3
 +fMQ==
X-Gm-Message-State: ACgBeo1wPgx10nF3IvKOzxEMexRNGNcqdD7zKLvfSihYCEst2SCayv+x
 n/dFMM1neNQz2LuVBFv8vq0VG5zouEH1aiVzbsM=
X-Google-Smtp-Source: AA6agR7XtQZmaBwEgbHmKwSfs0y8fBk/C/PY1sHn5Qk62HECx4Dkj042KfUumnjiLzK8Hy0H3AbiXlyXxNrjOl6Y6HQ=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr722754oab.96.1661437594739; Thu, 25 Aug
 2022 07:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085820.1228641-1-lijo.lazar@amd.com>
 <CADnq5_McOZzSd+FmtKuLxjTpUD5X=_WrhwDyf_at-E6228T+RA@mail.gmail.com>
 <c552044e-f804-4853-9d61-2bb1338587f0@amd.com>
In-Reply-To: <c552044e-f804-4853-9d61-2bb1338587f0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 10:26:23 -0400
Message-ID: <CADnq5_PK0LtCa8_1rvO6PF_vHQcfa_-+V77sBmZUc6Ym0xgWPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org, tseewald@gmail.com,
 helgaas@kernel.org, Alexander.Deucher@amd.com, sr@denx.de,
 Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 25, 2022 at 10:22 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 8/25/2022 7:37 PM, Alex Deucher wrote:
> > On Thu, Aug 25, 2022 at 4:58 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
> >>
> >> HDP flush is used early in the init sequence as part of memory control=
ler
> >> block initialization. Hence remapping of HDP registers needed for flus=
h
> >> needs to happen earlier.
> >>
> >> This also fixes the AER error reported as Unsupported Request during
> >> driver load.
> >>
> >> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=3D05%7C01%7Cl=
ijo.lazar%40amd.com%7Caeec5a5e8ec7402e546708da86a31e41%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637970332414985963%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3DEQuUjHTaVPSKZdCUhL6iI4EJ56UMhKTLl86uVpSL8AU%3D&amp;reserved=3D=
0
> >>
> >> Reported-by: Tom Seewald <tseewald@gmail.com>
> >> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
> >>   drivers/gpu/drm/amd/amdgpu/nv.c            | 6 ------
> >>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 ------
> >>   drivers/gpu/drm/amd/amdgpu/soc21.c         | 6 ------
> >>   4 files changed, 9 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index ce7d117efdb5..53d753e94a71 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -2376,6 +2376,15 @@ static int amdgpu_device_ip_init(struct amdgpu_=
device *adev)
> >>                                  DRM_ERROR("amdgpu_vram_scratch_init f=
ailed %d\n", r);
> >>                                  goto init_failed;
> >>                          }
> >> +
> >> +                       /* remap HDP registers to a hole in mmio space=
,
> >> +                        * for the purpose of expose those registers
> >> +                        * to process space. This is needed for any ea=
rly HDP
> >> +                        * flush operation during gmc initialization.
> >> +                        */
> >> +                       if (adev->nbio.funcs->remap_hdp_registers && !=
amdgpu_sriov_vf(adev))
> >> +                               adev->nbio.funcs->remap_hdp_registers(=
adev);
> >> +
> >
> > We probably also need this in ip_resume() as well to handle the
> > suspend and resume case.  Thinking about this more, maybe it's easier
> > to just track whether the remap has happened yet and use the old or
> > new offset based on that.
>
> If we can use the default offset without a remap, does it make sense to
> remap? What about calling the same in ip_resume?

The remap is necessary so that userspace drivers can access this to
flush the HDP registers when they need to since normally it's in a
non-accessible region of the MMIO space.  I'm fine with updating it in
ip_resume as well.

Alex


>
> Thanks,
> Lijo
>
> >
> > Alex
> >
> >
> >>                          r =3D adev->ip_blocks[i].version->funcs->hw_i=
nit((void *)adev);
> >>                          if (r) {
> >>                                  DRM_ERROR("hw_init %d failed %d\n", i=
, r);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c
> >> index b3fba8dea63c..3ac7fef74277 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >> @@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handle)
> >>          nv_program_aspm(adev);
> >>          /* setup nbio registers */
> >>          adev->nbio.funcs->init_registers(adev);
> >> -       /* remap HDP registers to a hole in mmio space,
> >> -        * for the purpose of expose those registers
> >> -        * to process space
> >> -        */
> >> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(=
adev))
> >> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>          /* enable the doorbell aperture */
> >>          nv_enable_doorbell_aperture(adev, true);
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/=
amdgpu/soc15.c
> >> index fde6154f2009..a0481e37d7cf 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >> @@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *handle)
> >>          soc15_program_aspm(adev);
> >>          /* setup nbio registers */
> >>          adev->nbio.funcs->init_registers(adev);
> >> -       /* remap HDP registers to a hole in mmio space,
> >> -        * for the purpose of expose those registers
> >> -        * to process space
> >> -        */
> >> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(=
adev))
> >> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>
> >>          /* enable the doorbell aperture */
> >>          soc15_enable_doorbell_aperture(adev, true);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/=
amdgpu/soc21.c
> >> index 55284b24f113..16b447055102 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> >> @@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *handle)
> >>          soc21_program_aspm(adev);
> >>          /* setup nbio registers */
> >>          adev->nbio.funcs->init_registers(adev);
> >> -       /* remap HDP registers to a hole in mmio space,
> >> -        * for the purpose of expose those registers
> >> -        * to process space
> >> -        */
> >> -       if (adev->nbio.funcs->remap_hdp_registers)
> >> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>          /* enable the doorbell aperture */
> >>          soc21_enable_doorbell_aperture(adev, true);
> >>
> >> --
> >> 2.25.1
> >>
