Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A34C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 16:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8910E862;
	Wed, 19 Feb 2025 16:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OsfvMKj5";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5841910E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 16:15:40 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2217ea6d8daso1774155ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 08:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739981740; x=1740586540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mANA1QS5nb/rkKiR3jD6xZTdHv2/v72mLzglceefX7g=;
 b=OsfvMKj560IzcLpujplh9Jmp80gpkPjlaiA4T2ovl+mkyr84VKHVidnLEe7ky1c0fS
 RZA8/GCIv7seWL7hct98/kSuy8c0HRuSPkvXGGMYs3qhRnADPC74WHYisAmhQwCdaiHm
 pnkxYpgEwQ7U2TUasT8OthU/sX40UUu9w1qx9RgfpGnxAgAgzjq0ps0gfkHXJP+9lcxm
 ccGqmAm1gC0iuT8EW31jS6G0lLSu5srznBS3iz8SN9q/Ev0BjvUsDdfPrG31IV6znQ5q
 DAyr6SojIOVUZccbMiZnwK2UEBDB8td1iIp73t60Nd4s40a5BGy4UmdLUervt/V2gmLM
 JOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739981740; x=1740586540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mANA1QS5nb/rkKiR3jD6xZTdHv2/v72mLzglceefX7g=;
 b=N26VZR4ScKjHbnZCT5ZZeCo8Jm8DFTXgkXTfQnNQpWEhdXqJPyRSdDOMLe4AnZO3V4
 PlvrPJ972XQcgvffI9Lp9HHD2lv3v7CRfSETvPR2T1q0Q6iMK5oF5wTLMvmu699r4hcr
 dFJjgDIdFzCMDBuiSxDdK2gcF8LyfFsMwaVSBpKVAHLmI8j9kDKOVTfLXhSuflnTi9FQ
 sAHK2DiHcUseEm5ttXl6Pj7J9+9oQ+vIvIGu1lEIoBqqTFYYEASpVBy+/QeSaXbAt+28
 lC0ILXowSs2pmpO/8xSIA9WHL2aYJtaJdx+ejmKICNf4DeWBgxi7Ow3+iJZrOqwW2NVo
 60uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIxTFd0Cs8rfkgPSLdwc/CpYBa3nWWtfihxBBCMStHVGwoBiOJwpNWh4huEOImpYm3lHVpQ7K@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5iotq9OyyCTjBSgd0Y1MpR1CXDGwjEbJMP5PXV4Xq1/4GvSd1
 kGBY3Q/AVyr0zzXuE9pIuc5jgaUZXfzicBMMOoQ2LaN2HS/KfUdWsu4JoTP32sB9OECBED8vUMj
 AOgW44H3OjcZ4NIPjzXBIykkzCMc=
X-Gm-Gg: ASbGnct4+JZy/HJ9HZc9Tdnnqd1JF8ZKY5ChoyW8cr6WxJh7ce3mpHWu/HY/51NUAfB
 owuHZ1gSL1urkDPNGeS5tLhK/D2Evi9ovJivd7WYPS/blQjbqWBTxpOQTO3zb3KLYbGQcDUfP
X-Google-Smtp-Source: AGHT+IEqux7P5RsCQsl2Q9xPEXnpueszSk6igxVN+cGUgKuEAxH3NDXckF/7N3nVRvBXiYL6wP7uO90/cmSKUfqbj5s=
X-Received: by 2002:a17:903:46c7:b0:215:9a73:6c4f with SMTP id
 d9443c01a7336-221040125b5mr111127955ad.6.1739981739736; Wed, 19 Feb 2025
 08:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20250218150829.2710795-1-alexander.deucher@amd.com>
 <c3626b4c-ce7e-494d-8c56-6d55869524b2@amd.com>
 <CADnq5_MZAuwCOBSfmLL5tddM0U-CmVN7Ca+nRSdKzAaZkC=dWA@mail.gmail.com>
 <264cae95-e28e-46af-b6e5-df9cafea2f28@amd.com>
In-Reply-To: <264cae95-e28e-46af-b6e5-df9cafea2f28@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 11:15:28 -0500
X-Gm-Features: AWEUYZkhUPX-3-c1qONZFYZx7VNFr-5w03wtatZuu5ZCY9iUppvbU9Ie3dUQXjA
Message-ID: <CADnq5_MV2dGiVs+RjBYxu1cWjS0wa5Rbjf_Gi17pHO5BAsrdWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2025 at 10:42=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 2/19/2025 8:02 PM, Alex Deucher wrote:
> > On Tue, Feb 18, 2025 at 11:05=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.co=
m> wrote:
> >>
> >>
> >>
> >> On 2/18/2025 8:38 PM, Alex Deucher wrote:
> >>> There was a quirk added to add a workaround for a Sapphire
> >>> RX 5600 XT Pulse that didn't allow BAR resizing.  However,
> >>> the quirk casused a regression on Dell laptops using those
> >>> chips, rather than narrowing the scope of the resizing
> >>> quirk, add a quirk to prevent amdgpu from resizing the BAR
> >>> on those Dell platforms.
> >>>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> >>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 560=
0 XT Pulse")
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>
> >> As per the issue thread, issue happens when dGPU resumes from runpm. I=
f
> >> so, can't we disable runpm as the workaround (IMO, the current patch
> >> also is a workaround)?
> >
> > This seems like a better workaround than disabling runtime pm.
> > Leaving the dGPU powered up all the time seems worse than limiting the
> > BAR size on this platform.
> >
>
> Probably, it's better to note down that as well in the description.
> Also, check if the device has runpm enabled. If a user prefers
> performance, say runpm disabled through driver option, then no need to
> apply this.

I can update the commit message, but the runtime pm method gets set
much later in the init sequence so we don't know what it is or if it
is enabled when we resize the BAR.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 512e642477a7e..56fd874a22de8 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -1662,6 +1662,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_=
device *adev)
> >>>       if (amdgpu_sriov_vf(adev))
> >>>               return 0;
> >>>
> >>> +     /* skip resizing on Dell G5 SE platforms */
> >>> +     if (adev->pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> >>> +         adev->pdev->device =3D=3D 0x731f &&
> >>> +         adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_DELL)
> >>> +             return 0;
> >>> +
> >>>       /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 =
*/
> >>>       if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
> >>>               DRM_WARN("System can't access extended configuration sp=
ace, please check!!\n");
> >>
>
