Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F381C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559AB61101
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 14:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 559AB61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83376EA9E;
	Fri, 20 Aug 2021 14:23:31 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDA06EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 14:23:30 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 i3-20020a056830210300b0051af5666070so4288024otc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aBd+gmQbauzC1Fjjaagb7HPdteA9i0oy69A6Wz//ohk=;
 b=P+Uc1xfIzZGdwBW9e108/+MME7tYQNer3AW1osUHHyr5Sraqiu5VVubeqllSXrQtmn
 vQSONHB2uqHGhq9pHrLZ9a5iU49Ut7kOaPbQcVLHX/EFurObXprc808Tk6VdI8uHHkm4
 01Ye0vCIqSdWCB3rC3RMd5fWM4pX31vEnkaqjXBQ/PLsrP+euA0a+m7WrAXSSHbgqeDr
 9em7/LaQnDFFEbeAt4T30412lOJIiu5/X8aDv1thFyTMftJ5rT7ffvAGnoBiL4PS8+dr
 twhEBgaFGfnGSEzg7jmnaqk1GxZkrFl9WRgOkoKjAt8+oWocc8vjz63nzaE1eHABhLAV
 B4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aBd+gmQbauzC1Fjjaagb7HPdteA9i0oy69A6Wz//ohk=;
 b=hY5XQu7Z8LN7ogyxPJOnykKFTiCc+Y5LjzF6vvyu3Ka1Rs5tPEcS5FI0noNW0KK7It
 70sEo6Jmd+/1St0xsD402a/araQvAknV3PgpvmBDsbHxHDZ+4Ve/RX2j/Tjqjm3EzxBv
 1Z1ySNhak43TqrN6yEGDA4oFnfKle8zPzDkxmGqPUSEqXy1zvgf2DPm+OY9LMNpKxkDZ
 S0+BBRJ6kbqtJKiieQRnRKK6yH1d6fCjy0y2i9/1+H25V4ySifYdZlstOSVIeK2mQ+HT
 TbG01LZckk2rsRL3gxvif90qrLi39gmvddGa6kpazh1vmNtDTaLe9YUgKwHqNwK4ahrz
 mnpA==
X-Gm-Message-State: AOAM530fLcb4FyiGJENm7+bChAycXCxScQRzIcDhCNBC3AtT+BICm1XR
 9tWk8RgkG/QCkl+AZaMlneChsMHm4KNvn2VF1qU=
X-Google-Smtp-Source: ABdhPJxDDerj8/jTz9fPdsOBw1L/aBBxutQolfI1YOm4vCi5N2Tt1M9mIbHNFIPi++aOVwbaGDtC5Zl5lHWdh3CLP0g=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr17145325otp.23.1629469409688; 
 Fri, 20 Aug 2021 07:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210819030859.1470753-1-evan.quan@amd.com>
 <DM5PR12MB2517FA1095D8D016C2E784D5E4C09@DM5PR12MB2517.namprd12.prod.outlook.com>
 <BL1PR12MB5349E230CC22C6031E03DE9097C09@BL1PR12MB5349.namprd12.prod.outlook.com>
 <DM6PR12MB261971EBCF452097AA846F00E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261971EBCF452097AA846F00E4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Aug 2021 10:23:18 -0400
Message-ID: <CADnq5_MfMi34f0HgurMYaxbGa1+J75fyiN5ZJ6m_4r-=PQOh8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Leo" <Leo.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
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

On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
>
>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 19, 2021 10:36 PM
> To: Zhu, James <James.Zhu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-g=
fx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.=
Chen@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/V=
CE on suspend
>
>
>
> [AMD Official Use Only]
>
>
>
> If that is done  =E2=80=93
>
>
>
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_PG_STATE_GATE)=
;
> +               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_CG_STATE_GATE)=
;
>
>
>
> Usual order is CG followed by PG. It comes in the else part, so less like=
ly to happen. Nice to fix for code correctness purpose.
>
> [Quan, Evan] Thanks Lijo. Make sense to me. However, actually these code =
were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c. Same logic=
 was used there. So, maybe @Zhu, James or @Liu, Leo can share some insights=
 about this.
>

It looks like it is wrong there as well.  We should be gating the
clocks before the power.  The order is also wrong in
amdgpu_uvd_ring_begin_use().  We need to ungate the power before the
clocks

Alex


>
>
> BR
>
> Evan
>
>
>
> Thanks,
>
> Lijo
>
>
>
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Thursday, August 19, 2021 7:49 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.=
Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Pan, Xinhui <Xinhui.Pan@am=
d.com>
> Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/V=
CE on suspend
>
>
>
> [AMD Official Use Only]
>
>
>
>
>
> Why not move changes into hw_fini?
>
>
>
> Best Regards!
>
>
>
> James Zhu
>
> ________________________________
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Q=
uan <evan.quan@amd.com>
> Sent: Wednesday, August 18, 2021 11:08 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.=
Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.=
com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE o=
n suspend
>
>
>
> Perform proper cleanups on UVD/VCE suspend: powergate enablement,
> clockgating enablement and dpm disablement. This can fix some hangs
> observed on suspending when UVD/VCE still using(e.g. issue
> "pm-suspend" when video is still playing).
>
> Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 4eebf973a065..d0fc6ec18c29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
>          int r;
>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +       /*
> +        * Proper cleanups before halting the HW engine:
> +        *   - cancel the delayed idle work
> +        *   - enable powergating
> +        *   - enable clockgating
> +        *   - disable dpm
> +        *
> +        * TODO: to align with the VCN implementation, move the
> +        * jobs for clockgating/powergating/dpm setting to
> +        * ->set_powergating_state().
> +        */
> +       cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +       if (adev->pm.dpm_enabled) {
> +               amdgpu_dpm_enable_uvd(adev, false);
> +       } else {
> +               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +               /* shutdown the UVD block */
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_PG_STATE_GATE)=
;
> +               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_UVD,
> +                                                      AMD_CG_STATE_GATE)=
;
> +       }
> +
>          r =3D uvd_v6_0_hw_fini(adev);
>          if (r)
>                  return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index 6d9108fa22e0..a594ade5d30a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
>          int r;
>          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +       /*
> +        * Proper cleanups before halting the HW engine:
> +        *   - cancel the delayed idle work
> +        *   - enable powergating
> +        *   - enable clockgating
> +        *   - disable dpm
> +        *
> +        * TODO: to align with the VCN implementation, move the
> +        * jobs for clockgating/powergating/dpm setting to
> +        * ->set_powergating_state().
> +        */
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +       if (adev->pm.dpm_enabled) {
> +               amdgpu_dpm_enable_vce(adev, false);
> +       } else {
> +               amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> +                                                      AMD_PG_STATE_GATE)=
;
> +               amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK=
_TYPE_VCE,
> +                                                      AMD_CG_STATE_GATE)=
;
> +       }
> +
>          r =3D vce_v3_0_hw_fini(adev);
>          if (r)
>                  return r;
> --
> 2.29.0
