Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E15C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 18:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09D410ED80;
	Thu, 24 Feb 2022 18:11:36 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EF410ED80
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 18:11:35 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id k2so3965397oia.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 10:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lhftd0jL42I2VxzhOIFes9JfV0nRqPy1VwUofPci2kM=;
 b=iphyAWK295vgj+feGFGRDXc463EeBkb+qJoJ3mRYkVvhMLei3eZz5jFkNZX9VzfBYs
 cdmJSFm8yUGSp0O/yKG9Temuhb/pKSPs3fFnv5wFOFOFgNqxtvyF3x5LILYVZXrCcThW
 AZUbKXv60GkHGaLVOr83lSPnZHeHHM/OXieKG2ry3/aU3MHAL8OyecfB5P8OBdCKxa1V
 uuOZ0UGSEdMbEoA2Bpf/ASaGzkERP7yEuoFDF/MOmUys8hx5/aVWlqp5wtMun1GuN4S7
 bpFzuiUe9Jz7WZzjo89PGspittfQejwlF1tIQsyaM/CM1cyRWzwap4MLy7nGZjR0UxjE
 kqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lhftd0jL42I2VxzhOIFes9JfV0nRqPy1VwUofPci2kM=;
 b=kpoL7OTNzeYQGgUO4LCIoR4FpADCcphJEquZxFw5MVlbv7kJDR+yEukaI5EGs1sUzp
 qLvBVyygD/hFMpfaWCd+QBdjGyj+qn5VEVUafsBSAXKxGb3SOjCuG78xT+VoKJbCqJ5Q
 OKvlPWS1qNc6Q2NIy3ZclSxok6u8rtRDGR2/DMOYWtFo3nR+L2yXcbazRgwAodgIm4Zb
 5XRguQxqmNf03p9j6YUcBfD56B5O2vT5jljy63XMorUzphJTY6eqPk/1z8+jSFmSo2zr
 yCSz4UhS/Z/3/YSJiBdvh27N9FO7jB6y7TvNKbKwmAX/C3h7Vfv7gI2FB7OKIDMUIrDg
 PKYg==
X-Gm-Message-State: AOAM5338k4wNiH6nzAUiY+/gYLuXv6epp5uira+BRMdMU5FNCcLtbgSv
 YMYRtToG18zgsjs8CdYkcjH2FGUTvcyDfKtgFn5xYGtYKgM=
X-Google-Smtp-Source: ABdhPJyHAERuNlf5d4eDrv3KFeOfNWgD6VYQPfJcgNdZP8G/TdjO8+Sa6ZJlqCW+lBEjqOzuySBFYPZ4H7ovG5w4N+w=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2084650oie.132.1645726295067; Thu, 24
 Feb 2022 10:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
In-Reply-To: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Feb 2022 13:11:24 -0500
Message-ID: <CADnq5_P8j4mBRH1eJmNkof6bTc2W4cLafMVmZiwhXxhg5t5_HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Exclude PCI reset method for now.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 24, 2022 at 1:05 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> According to my investigation of the state of PCI
> reset recently it's not working. The reason is
> due to the fact the kernel PCI code rejects SBR
> when there are more then one PF under same bridge
> which we always have (at least AUDIO PF but usually
> more) and that because SBR will reset all the PFS
> and devices under the same bridge as you and you
> cannot assume they support SBR.
> Once we anble FLR support we can reenable this option as
> FLR is doable on single PF and doens't have this
> restriction.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ecf8c307baf6..78cdbe3c4a9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1539,6 +1539,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>                 amdgpu_sched_hw_submission = roundup_pow_of_two(amdgpu_sched_hw_submission);
>         }
>
> +       if (amdgpu_reset_method > 4) {

Validate the other side as well?

if (amdgpu_reset_method < -1 || amdgpu_reset_method > 4) {

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               dev_warn(adev->dev, "invalid option for reset method, reverting to default\n");
> +               amdgpu_reset_method = -1;
> +       }
> +
>         amdgpu_device_check_smu_prv_buffer_size(adev);
>
>         amdgpu_device_check_vm_size(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e18356fff710..5a2ecc65951d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -829,9 +829,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>
>  /**
>   * DOC: reset_method (int)
> - * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
> + * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>   */
> -MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco, 5 = pci)");
> +MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
>  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>
>  /**
> --
> 2.25.1
>
