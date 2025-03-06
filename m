Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD26C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962D210E2C9;
	Thu,  6 Mar 2025 20:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iq/4KaWY";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1901B10E2C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:11:19 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-224104a9230so2669695ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 12:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741291878; x=1741896678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3pYrta3fh3keHzP2liyRZHG8fMHLydPKgRnffJ2QIc=;
 b=iq/4KaWYdQeUW+YHoTV4fs+IracPvVnmLGgMEKEI+nkqd0gPLOcRR2UpjBBaXV41jf
 z9W8rbiRHulnB6zCL4bqL4g5aPcsRjgRNcpbmXmT7ODRs8Ks8P8Ib2mRK9ZRPp44P/Gl
 atnvwxVPW51FcvAOw1hSbH4EYV1Nv/KLNBgK0fXZw45Ir9WcNK/ftukUKQ+P30XOkjuk
 b/KsljhcpZpKZyTcwvsJpVexSHPiqj7lrkBo8cmKiIkMtnRYXb1Uda0U8EaDuSahfsH2
 Bb5f3w7oRS429K0WNzViywd8pU8gfERsca55lMV0rAIYFzJp68BLn1p56uxHUVABa0xx
 ViNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741291878; x=1741896678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3pYrta3fh3keHzP2liyRZHG8fMHLydPKgRnffJ2QIc=;
 b=EUYs7BJ/J4LvVyGNc/54zT7AFRwzQV9UirAhIjubqLKXE51XnmJAlj+XU+C673NrsQ
 XFNupbpOXLHxUVVp/CYz5FRoIB7W+d4DLbp4p7CVR1O1uCWm2cClhY3zQQeo2ftScKZu
 tvDdNs36Qtz3rBB1LMwfj8c1gjW7j5RiImfXaDT3Zdqjq5bj7QhgVG0njMePYAwPZypk
 2m2/ycuttg2V/GWW8M5jRXLQAAoYbKPZPHCMz0mqpu1wfvBJkrzeGo5hiGtijefaBAAK
 oLYlMqgwG8DEWy+80FRLKRq3MuwrBIblGhxeYCDQOFjEGkPnzUX+zrpIcLw1+vD8nJPB
 zYrA==
X-Gm-Message-State: AOJu0Yycm3uGMuPuMGaX/H9qwPQ/l2D6+VX36pMSDE75uw28GtuXwaIw
 Gy20JsRJjbTnnqAX5VBjH7DeutSAc/ptj8DPXjTSKznKnwx3/BLrPskR8Mx+SJAsPCaLoa+GWP0
 rHW9Wq4vmV3W8BVOi0mwsHrxoZ9ySRarO
X-Gm-Gg: ASbGncvn3e5ZJWiWuTd48gXjxdnz0KUb7etISQW0g8WyxhVbKCv2l6E0jWXR8IJLDJj
 d9gAAwsgfA9okaADN9WzZ0NJfbYtHD63D9TeOKeDHmnm+eHbvPoUa2vvb8NL+Jgdulo3ryU07ne
 OetZAiaz9qKIaSKcmoiQRCgCY2+A==
X-Google-Smtp-Source: AGHT+IFV4pLuUtKFrApcjLCYN+uKHlioXlYu160jPFttrnnRusY/orYJNxzSt4DY/BCkmhffGIgHoFk0a14Oky3vZqg=
X-Received: by 2002:a17:903:2284:b0:223:f9a4:dc25 with SMTP id
 d9443c01a7336-22428bdea2dmr3215395ad.14.1741291878511; Thu, 06 Mar 2025
 12:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20250306185752.50871-1-mario.limonciello@amd.com>
 <CADnq5_NUZwNK_h05mbAD7iba1JjDj=CtQ5=fRb_0VDpgaFzG6g@mail.gmail.com>
 <858ce1da-673a-4cef-a1d3-c062a9ffa64c@amd.com>
In-Reply-To: <858ce1da-673a-4cef-a1d3-c062a9ffa64c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 15:11:07 -0500
X-Gm-Features: AQ5f1JomVpIuYWLkATVNXqBeOP4gUydfMxi75PiE9q5WLyluebMZh0hmpQim9QE
Message-ID: <CADnq5_NooJigP55UB6beFRSa_n3bnk4Sy8za1BvQ_sRg2Ta3Ow@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Fail initialization earlier when DC is
 disabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Mar 6, 2025 at 2:31=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 3/6/2025 13:19, Alex Deucher wrote:
> > On Thu, Mar 6, 2025 at 1:58=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> Modern APU and dGPU require DC support to be able to light up the
> >> display.  If DC support has been disabled either by kernel config
> >> or by kernel command line the screen will visibly freeze when the
> >> driver finishes early init.
> >>
> >> As it's known before early init is done whether DC support is required
> >> detect this during discovery and bail if DC support was disabled
> >> for any reason.  This will ensure that the existing framebuffer
> >> provided by efifb or simpledrm keeps working.
> >
> > I think there are a couple of corner cases we need to handle:
> > 1. if adev->enable_virtual_display is set.  The user has configured
> > virtual displays and hence they want to use them rather than the
> > actual physical displays.  This is useful with GPUs in servers or for
> > early bring up.
>  > 2. If the board supports DCN IP, but all it's been fused off due to>
> silicon flaws (e.g., adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK).
> > In that case, we don't want to fail.
>
> In that case I wonder if it's better to use
> amdgpu_device_asic_has_dc_support() instead of
> amdgpu_device_has_dc_support() which should cover both of those concerns.

That should work, or maybe just warn once in
amdgpu_device_asic_has_dc_support().  E.g., something like:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b9b4f8daf531..c986e619dbe99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3988,6 +3988,8 @@ bool amdgpu_device_asic_has_dc_support(enum
amd_asic_type asic_type)
                 */
                return amdgpu_dc > 0;
        default:
+               if (amdgpu_dc =3D=3D 0)
+                       DRM_INFO_ONCE("Display Core has been disable
via kernel parameter, No display!\n");
                return amdgpu_dc !=3D 0;
 #else
        default:


>
> >
> > Alex
> >
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2:
> >>   * Update commit message justification
> >>   * Add correct "default" handling
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++----=
--
> >>   1 file changed, 33 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c
> >> index a4258127083d..24f532de6322 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_bloc=
ks(struct amdgpu_device *adev)
> >>                  return 0;
> >>          }
> >>
> >> -       if (!amdgpu_device_has_dc_support(adev))
> >> -               return 0;
> >> -
> >> -#if defined(CONFIG_DRM_AMD_DC)
> >>          if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> >>                  switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> >>                  case IP_VERSION(1, 0, 0):
> >> @@ -2166,39 +2162,63 @@ static int amdgpu_discovery_set_display_ip_blo=
cks(struct amdgpu_device *adev)
> >>                  case IP_VERSION(3, 5, 1):
> >>                  case IP_VERSION(3, 6, 0):
> >>                  case IP_VERSION(4, 1, 0):
> >> +                       if (!amdgpu_device_has_dc_support(adev)) {
> >> +                               dev_err(adev->dev,
> >> +                                       "DC support is required for dm=
 ip block(DCE_HWIP:0x%x)\n",
> >> +                                       amdgpu_ip_version(adev, DCE_HW=
IP, 0));
> >> +                               return -EINVAL;
> >> +                       }
> >> +
> >>                          /* TODO: Fix IP version. DC code expects vers=
ion 4.0.1 */
> >>                          if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_=
VERSION(4, 1, 0))
> >>                                  adev->ip_versions[DCE_HWIP][0] =3D IP=
_VERSION(4, 0, 1);
> >>
> >> +#if defined(CONFIG_DRM_AMD_DC)
> >>                          if (amdgpu_sriov_vf(adev))
> >>                                  amdgpu_discovery_set_sriov_display(ad=
ev);
> >>                          else
> >>                                  amdgpu_device_ip_block_add(adev, &dm_=
ip_block);
> >>                          break;
> >> +#endif
> >>                  default:
> >> -                       dev_err(adev->dev,
> >> -                               "Failed to add dm ip block(DCE_HWIP:0x=
%x)\n",
> >> -                               amdgpu_ip_version(adev, DCE_HWIP, 0));
> >> -                       return -EINVAL;
> >> +                       if (amdgpu_device_has_dc_support(adev)) {
> >> +                               dev_err(adev->dev,
> >> +                                       "Failed to add dm ip block(DCE=
_HWIP:0x%x)\n",
> >> +                                       amdgpu_ip_version(adev, DCE_HW=
IP, 0));
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       return 0;
> >>                  }
> >>          } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
> >>                  switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
> >>                  case IP_VERSION(12, 0, 0):
> >>                  case IP_VERSION(12, 0, 1):
> >>                  case IP_VERSION(12, 1, 0):
> >> +
> >> +               if (!amdgpu_device_has_dc_support(adev)) {
> >> +                       dev_err(adev->dev,
> >> +                               "DC support is required for dm ip bloc=
k(DCI_HWIP:0x%x)\n",
> >> +                               amdgpu_ip_version(adev, DCI_HWIP, 0));
> >> +                       return -EINVAL;
> >> +               }
> >> +
> >> +#if defined(CONFIG_DRM_AMD_DC)
> >>                          if (amdgpu_sriov_vf(adev))
> >>                                  amdgpu_discovery_set_sriov_display(ad=
ev);
> >>                          else
> >>                                  amdgpu_device_ip_block_add(adev, &dm_=
ip_block);
> >>                          break;
> >> +#endif
> >>                  default:
> >> -                       dev_err(adev->dev,
> >> -                               "Failed to add dm ip block(DCI_HWIP:0x=
%x)\n",
> >> -                               amdgpu_ip_version(adev, DCI_HWIP, 0));
> >> -                       return -EINVAL;
> >> +                       if (amdgpu_device_has_dc_support(adev)) {
> >> +                               dev_err(adev->dev,
> >> +                                       "Failed to add dm ip block(DCI=
_HWIP:0x%x)\n",
> >> +                                       amdgpu_ip_version(adev, DCI_HW=
IP, 0));
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       return 0;
> >>                  }
> >>          }
> >> -#endif
> >>          return 0;
> >>   }
> >>
> >> --
> >> 2.48.1
> >>
>
