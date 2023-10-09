Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31422E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E6A10E0FE;
	Mon,  9 Oct 2023 14:16:30 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0569210E0FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:16:28 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1e58a522e41so1997827fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696860988; x=1697465788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6ByXfcqaW852uGGDoefSjUjRJsbMqoNQbQzTOOk8LU=;
 b=JXo9pJ95kPBNYTi09G7MSiSVVAwiczM3aYjwlJZgdQf9/7bJ85bCwBAG+aE1DMiW3D
 WZHHwrwiT1Y409USUrVjxiP3qpm6UGL6TqaHfrW9GvuX5e03bpihVmDw0bPEVzlnnCW8
 I1nD5HJIYrzyrr02FJa6HhDW4LioJI4XTNpcrKslWllqoIYRG1HIHccT6LtrOKXSvcfj
 5vDrajJUVNGDBefi6Af4E7EXMKyXKjEu5kqkIzi/oi4FqTn+G4hbbQjexHDfC+z7Xfz9
 DdFR6saXiEcOKLL8FhEB+I4tyuN1bfUNsXku2LGRuIibzmYzBEE0hI8BxjzuHvn29Kpn
 kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696860988; x=1697465788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6ByXfcqaW852uGGDoefSjUjRJsbMqoNQbQzTOOk8LU=;
 b=kyH+adyIz+F14BXvMXZJmPIHgik2+862VGhcFxkeoVNZLEcemV7/rbASXXhbwcaWS8
 jh3v1997RK9C7QEQPgOiDAK4TwzhJVPB4966iQpgsEPKE5bm5eaa4azGZOZCGwpXQcoI
 e22p5DB5/YjgJQ+b4ARsZip6MZ4Swa0XBON8Ye5YOEPlC5CHNvrxUKqOenxf3MJoNsrw
 0fW+weqyg4CFYcx260pzInF6IKpVKq8f46ekthhH168wBrwdPI3CPNYDcjveZWNa65Ky
 oXOmwnqABHT+gd0XlBLdE6whqC0B0Orlr/sldcXqbyLOkfQEyLqB2y+iF/ISAw0SEP4D
 1b8A==
X-Gm-Message-State: AOJu0YxeguuQH+NQm6ABT3kqJgpObtP7JSq3xl4IvjnJr2cQbx3TM/pC
 m8WIbcLCL0yqexjUYcw28LmCpYmpGx5VBKXaRoI=
X-Google-Smtp-Source: AGHT+IGfxdyIz+wOdEM6U9wNJc+Asjd3wGJ1d4xdaK3I2zUltRa00RGSfd/+/VJUPql9rj7Z8oiMssnfdVHGoh/4xTI=
X-Received: by 2002:a05:6870:f141:b0:1d1:425b:8029 with SMTP id
 l1-20020a056870f14100b001d1425b8029mr19265371oac.13.1696860986731; Mon, 09
 Oct 2023 07:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <20231006052149.1566154-4-lijo.lazar@amd.com>
 <007b0fed-4982-4978-95e3-6763d114a97e@gmail.com>
 <CADnq5_MzHbigYydWy9xkT_rgNEpogU8+y4bodAy1NxD99acnZQ@mail.gmail.com>
 <11992882-b7ff-4fe5-8777-755f128472e9@gmail.com>
In-Reply-To: <11992882-b7ff-4fe5-8777-755f128472e9@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 10:16:15 -0400
Message-ID: <CADnq5_N-_uTpay-Ph1k2iJWJNEcL38c1iZjZoe28n4jVXPMrPQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/amd/pm: Add sysfs attribute to get pm log
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
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 9, 2023 at 4:41=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 06.10.23 um 16:24 schrieb Alex Deucher:
> > On Fri, Oct 6, 2023 at 4:32=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 06.10.23 um 07:21 schrieb Lijo Lazar:
> >>> Add sysfs attribute to read power management log. A snapshot is
> >>> captured to the buffer when the attribute is read.
> >>>
> >>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >>> ---
> >>>
> >>> v2: Pass PAGE_SIZE as the max size of input buffer
> >>>
> >>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 ++++++++++++++++++++++++++=
++++
> >>>    1 file changed, 40 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd=
/pm/amdgpu_pm.c
> >>> index 4c65a2fac028..5a1d21c52672 100644
> >>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> @@ -1794,6 +1794,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(stru=
ct device *dev,
> >>>        return count;
> >>>    }
> >>>
> >>> +static int amdgpu_pmlog_attr_update(struct amdgpu_device *adev,
> >>> +                                 struct amdgpu_device_attr *attr,
> >>> +                                 uint32_t mask,
> >>> +                                 enum amdgpu_device_attr_states *sta=
tes)
> >>> +{
> >>> +     if (amdgpu_dpm_get_pm_log(adev, NULL, 0) =3D=3D -EOPNOTSUPP)
> >>> +             *states =3D ATTR_STATE_UNSUPPORTED;
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static ssize_t amdgpu_get_pmlog(struct device *dev,
> >>> +                             struct device_attribute *attr, char *bu=
f)
> >>> +{
> >>> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> >>> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> >>> +     ssize_t size =3D 0;
> >>> +     int ret;
> >>> +
> >>> +     if (amdgpu_in_reset(adev))
> >>> +             return -EPERM;
> >> Please stop using amdgpu_in_reset() for stuff like that altogether.
> >>
> >> When this is reset critical it should grab the reset rw semaphore. If =
it
> >> isn't than that check isn't necessary.
> > All of the power related sysfs files have this check.  It was
> > originally added because users have processes running which poll
> > various hwmon files at regular intervals and since SMU also handles
> > reset, we don't want to get a metrics table request while a reset is
> > happening otherwise the SMU gets confused.
>
> Then this approach is completely broken. Nothing prevents the reset from
> starting right after doing the check.
>
> If we need exclusive access to the SMU then we should just grab a lock.

Right, but the entire file should be fixed.  It's sort of orthogonal
to this patch.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >>> +     if (adev->in_suspend && !adev->in_runpm)
> >>> +             return -EPERM;
> >>> +
> >>> +     ret =3D pm_runtime_get_sync(ddev->dev);
> >>> +     if (ret < 0) {
> >>> +             pm_runtime_put_autosuspend(ddev->dev);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     size =3D amdgpu_dpm_get_pm_log(adev, buf, PAGE_SIZE);
> >>> +
> >>> +     pm_runtime_mark_last_busy(ddev->dev);
> >>> +     pm_runtime_put_autosuspend(ddev->dev);
> >>> +
> >>> +     return size;
> >>> +}
> >>> +
> >>>    /**
> >>>     * DOC: gpu_metrics
> >>>     *
> >>> @@ -2091,6 +2129,8 @@ static struct amdgpu_device_attr amdgpu_device_=
attrs[] =3D {
> >>>        AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                        =
  ATTR_FLAG_BASIC,
> >>>                              .attr_update =3D ss_bias_attr_update),
> >>>        AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                       =
  ATTR_FLAG_BASIC),
> >>> +     AMDGPU_DEVICE_ATTR_RO(pmlog,                                   =
 ATTR_FLAG_BASIC,
> >>> +                           .attr_update =3D amdgpu_pmlog_attr_update=
),
> >>>    };
> >>>
> >>>    static int default_attr_update(struct amdgpu_device *adev, struct =
amdgpu_device_attr *attr,
>
