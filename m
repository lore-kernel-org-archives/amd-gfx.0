Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D31C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 13:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2736010ED19;
	Fri, 29 Apr 2022 13:20:49 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E9810ED15
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 13:20:48 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-e2fa360f6dso8116836fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rmv8GAxZBM6kzAefpH8lo3vq0j3wnHXZaT5QQhRpFJ4=;
 b=G9PWU5iBbaPwCZ/35/c/hXxJ7zIk74WM7Q4XvkMzJEBvjR/ekYo1mClXZy/Y1FIdex
 AnxQbqpE5rKH2BqbxCOPmiH4RJpy9Yrlig0h4iUTEOs5SJeb/OtiTzATrg0bKuQQ626z
 KHwFCVioNz4y/unerAj7gOq8XWZ981p2oZ+QGpFchHzRQUE5dHn9Qb6OF5s5hrwHb237
 hRUi/T7PD9X+ywHWzlcYdHlMwi7eZhSIv2zsXkZnNrpUe4ehfa4EoJomzLdE9TnmBYXR
 VsFp3IDWUmbFYOyptMQXrChVBLwvq/unCov0gIGtUocigADv1FA9nRsXvxsI9AR6y16s
 e8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rmv8GAxZBM6kzAefpH8lo3vq0j3wnHXZaT5QQhRpFJ4=;
 b=tPIGOa92djaAckp6eDrPd5vXZBkYRITLzA5b/oJwiC673WRk9k1rt+Ov8KbsiiSzA2
 ByS0dmjLf4/WF4nc8kgjKYxCVI7N5/Zhl+tWEnGihByiTNSy35PgbQWI3zg56F0bXEWZ
 uQuEcc59o7uAOfwswXHXh/MqIunQFOkIVE+1o5y69G2Ve2IVr17dA17fyF9Fpw67uCoL
 Z4C3Pqqr7ZHKp20Gru5CAQTX8KYHAgjPOjf+VvoVMyqWzRSZToJAW/Kiv7jM47CdQAM0
 eff4fOzMtHnQe+S1XRHE1lx6VKq54u7C/Dq8FmNcp27ohmu9C2jcH/CgPrtr4YkdgC1C
 aLcA==
X-Gm-Message-State: AOAM533bhiAm6m+UlC55mPx3McL4zNHSCQl+WMfK9V5iwXbCGtMlSiD2
 O0nqGS8/Vf8eOWyK3F9rVuz1pVJCV+XkLilayV/YunbR
X-Google-Smtp-Source: ABdhPJwuk8rzMabYxDNpREJ4yCMaDnpjpI3g5KFHB1ElzpJN2T8pLMY14LYC3g+Vp8z74MXAC7cCoUhrtw/J3PZR1bo=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1223201oaa.200.1651238447558; Fri, 29
 Apr 2022 06:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428221311.1030146-1-alexander.deucher@amd.com>
 <DM4PR12MB5182C293BE9C6AF6E807A554ECFC9@DM4PR12MB5182.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5182C293BE9C6AF6E807A554ECFC9@DM4PR12MB5182.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Apr 2022 09:20:36 -0400
Message-ID: <CADnq5_NK2fZBuytsw9ZrgFukDF0P7wbw1Na7c4jT8c2zoaLRgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 28, 2022 at 9:41 PM Kazlauskas, Nicholas
<Nicholas.Kazlauskas@amd.com> wrote:
>
> [Public]
>
>
> This bug previously existed, and we have a solution in place for it.
>
> The solution we picked was to force a stall through reading back the memo=
ry. You'll see this implemented in dmub_srv.c and the dmub_cmd.h header - t=
hrough use of a volatile read over the region written. We do this for both =
the initial allocation for the cache windows and on every command submissio=
n to ensure DMCUB doesn't wakeup before the writes are in VRAM.
>
> The issue on dGPU is the latency through the HDP path, but on APU the iss=
ue is out of order writes. We saw this problem on both DCN30/DCN21 when DMC=
UB was first introduced.
>
> The writes we do happen within dmub_hw_init and on every command executio=
n, but this patch adds the flush before HW init. I think the only issue thi=
s potentially fixes is the initial writeout in the SW PSP code to VRAM, but=
 they already have flushes in place for that. The signature validation woul=
d cause firmware to fail to load if it wasn't at least.
>
> So from a correctness perspective I don't think this patch causes any iss=
ue, but from a performance perspective this probably adds at least 100us to=
 boot, if not more. My recommendation is to leave things as-is for now.

Thanks for the background.  I'll drop that patch.

Alex


>
> Regards,
> Nicholas Kazlauskas
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex D=
eucher <alexander.deucher@amd.com>
> Sent: Thursday, April 28, 2022 6:13 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB =
firmware
>
> When data is written to VRAM via the PCI BAR, the data goes
> through a block called HDP which has a write queue and a
> read cache.  When the driver writes to VRAM, it needs to flush
> the HDP write queue to make sure all the data written has
> actually hit VRAM.
>
> When we write the DMCUB firmware to vram, we never flushed the
> HDP.  In theory this could cause DMCUB errors if we try and
> start the DMCUB firmware without making sure the data has hit
> memory.
>
> This doesn't fix any known issues, but is the right thing to do.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a6c3e1d74124..5c1fd3a91cd5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1133,6 +1133,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *a=
dev)
>                  break;
>          }
>
> +       /* flush HDP */
> +       mb();
> +       amdgpu_device_flush_hdp(adev, NULL);
> +
>          status =3D dmub_srv_hw_init(dmub_srv, &hw_params);
>          if (status !=3D DMUB_STATUS_OK) {
>                  DRM_ERROR("Error initializing DMUB HW: %d\n", status);
> --
> 2.35.1
>
