Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66135C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 16:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C710710E618;
	Fri,  5 Jan 2024 16:12:04 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3E210E618
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 16:12:03 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-203fb334415so953777fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704471122; x=1705075922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=du025OEq5d7w4QrnsM+Bd/qfd9sybNpjMSf1RZA+Yhc=;
 b=KKO1M5rSrV14aX2NaLcIQA8RGlBVdyT7Wbey4t/K2lYNxLHLeiZgiR73VmtaTO88VU
 OprclBdIlIGtSCOCZTE5cUM+gm6lJXVFhuE3QsvCwsTkuV2sbq+iTx93BafV3Qen7Tm3
 nFGbJYry1GmNKIwoZhDAwrPa8xfpF50tBdNO7JLUxSk9nOWQCwWC1p6pIM0yTH7pPptB
 EtlpuY0HnCN5GJQEYZ3ahxGLHncFB01eXLQHqJb8HaW+sq03E7fUmNMr96ZfGEhglhkV
 iHqQrq/hLFz7eCCW7QgblPscnF47eExh0ww39t4Iu+0qJA1qMMH1Az5B5wecYEw+zv+V
 ZElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704471122; x=1705075922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=du025OEq5d7w4QrnsM+Bd/qfd9sybNpjMSf1RZA+Yhc=;
 b=VEFiq3cEaD3v4krcwsCejll9LOI9fYl+qcfH+tEzyCxnqcNeLMX96tFPNJj3U/A/dS
 EZcvS8B3G+/INyz04Y7luelKKMFzYK1TaJ5rbfm113RnrHhuuJzKfD9yRSW0hcPZeJGb
 trAXpy53J5LtkaQTwHDxneURG42UK7b8xdbbJEwzxhGyi9F7NOW3TnHTgNOQ7uYCwGBO
 HV2PT1hW5tHpME5FuM6VASb4wWvJxD0MLq8Cwfflf33QgIaOkDOb+TVTYAr4CRDQIWWo
 eoZF0JbRyklauVxW3q78cLEro4C0wy2rx1dO9Q82l1nOeFM77MER9iV16gwxyHp+SuCp
 hvgQ==
X-Gm-Message-State: AOJu0YyX5c/yTd9FncrfqkKphfyAQ+CzwxFO6mZ4DIfRjpXi1km4xCU+
 l0n2IVbSwg/rK86Tv3qpFKxWR68niBrPXIFJ/rE=
X-Google-Smtp-Source: AGHT+IFIYvOlIHfj4mfAFq2XRhBRdkd65ulsoEbwStnwzrOUDK3OKYf6D08VvL0r6uc71XQ1XmdMinUVbKM1K0YafBo=
X-Received: by 2002:a05:6870:c0cd:b0:205:e440:3d34 with SMTP id
 e13-20020a056870c0cd00b00205e4403d34mr757037oad.100.1704471122282; Fri, 05
 Jan 2024 08:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
 <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
In-Reply-To: <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jan 2024 11:11:51 -0500
Message-ID: <CADnq5_NuFsnRtkPPBgWR4DZVr_z_Wg68v4B7A64S7iGOnCjsqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>,
 mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 5, 2024 at 9:16=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 21.12.23 um 02:58 schrieb Ma, Jun:
> > Hi Christian,
> >
> >
> > On 12/20/2023 10:10 PM, Christian K=C3=B6nig wrote:
> >> Am 19.12.23 um 06:58 schrieb Ma Jun:
> >>> Print a warnning message if the system can't access
> >>> the resize bar register when using large bar.
> >> Well pretty clear NAK, we have embedded use cases where this would
> >> trigger an incorrect warning.
> >>
> >> What should that be good for in the first place?
> >>
> > Some customer platforms do not enable mmconfig for various reasons, suc=
h as
> > bios bug, and therefore cannot access the GPU extend configuration
> > space through mmio.
> >
> > Therefore, when the system enters the d3cold state and resumes,
> > the amdgpu driver fails to resume because the extend configuration
> > space registers of GPU can't be restored. At this point, Usually we
> > only see some failure dmesg log printed by amdgpu driver, it is
> > difficult to find the root cause.
> >
> > So I thought it would be helpful to print some warning messages at
> > the beginning to identify problems quickly.
>
> Interesting bug, but we can't do this here. We have a couple of devices
> where the REBAR cap isn't enabled for some reason (or not correctly
> enabled).
>
> In this case this would print a warning even when there isn't anything
> wrong.
>
> What we could potentially do is to check for the MSI extension, that
> should always be there if I'm not completely mistaken.
>
> But how does this hardware platform even works without the extended mmio
> space? I mean we can't even enable/disable MSI in that configuration if
> I'm not completely mistaken.

That system is probably similar to what Mario mentioned:
https://lore.kernel.org/linux-pci/20231215220343.22523-1-mario.limonciello@=
amd.com/

Alex

>
> Regards,
> Christian.
>
> >
> > Regards,
> > Ma Jun
> >
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
> >>>    1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 4b694696930e..e7aedb4bd66e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_devic=
e *adev, u32 wb)
> >>>             __clear_bit(wb, adev->wb.used);
> >>>    }
> >>>
> >>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *ade=
v)
> >>> +{
> >>> +   if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
> >>> +           DRM_WARN("System can't access the resize bar register,ple=
ase check!!\n");
> >>> +}
> >>> +
> >>>    /**
> >>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
> >>>     *
> >>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_=
device *adev)
> >>>
> >>>     /* skip if the bios has already enabled large BAR */
> >>>     if (adev->gmc.real_vram_size &&
> >>> -       (pci_resource_len(adev->pdev, 0) >=3D adev->gmc.real_vram_siz=
e))
> >>> +       (pci_resource_len(adev->pdev, 0) >=3D adev->gmc.real_vram_siz=
e)) {
> >>> +           amdgpu_find_rb_register(adev);
> >>>             return 0;
> >>> +   }
> >>>
> >>>     /* Check if the root BUS has 64bit memory resources */
> >>>     root =3D adev->pdev->bus;
>
