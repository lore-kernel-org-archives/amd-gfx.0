Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F145E81DFF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F0C10E502;
	Fri,  6 Oct 2023 14:24:15 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C5910E502
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:24:14 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c4f1f0774dso1437647a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696602253; x=1697207053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fq6K6YfzsiyKtGc+7e3/b/An9LvuJm4JEWDU/zNAG00=;
 b=C48POpfWKzVqO15YxcE7rpoP7l8Da1LgkFZhMztZweykeIdKHLj4Z7Gb4XZIvS3N1i
 E5p1Ja/HxvQ3uaSgxKrKalx0MowMJuQ8E+cVAcQb1EHGnFt5mFm+RVVYXvZYJgdcr2ZK
 hgC6mGV+okDcwup+92M4YhYAZerPbspH0jYvisjhHuXKMeRaS65lq77ScB3K4DpqjjCH
 rm34I94wfyxzUJSs0Gaxa9bWfm6yT321QnkYWHcHhwjn9JD449xwa7oyYAuvuCoSsTgj
 /0gOQnYAdPSCWOzxB2cblQRpEGEHmK/bSh0kh33qLZyL8EVohNNbYWkeJtTST8BPaDg3
 QPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696602253; x=1697207053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fq6K6YfzsiyKtGc+7e3/b/An9LvuJm4JEWDU/zNAG00=;
 b=dTHWAYWAeK+Y0hzGuwUGZVuuGjW/lrRJMpWFmjvPd3Qx6a+DmvvVRE+cHArdcnoMzh
 KAmgm1uj9evmInHhi72bmcLMFSLuDdWNv6UAmYqikeXmj/yEFwcci6QjEOBajqHA1jrD
 V3s82q7j01UD++xmuEdbjGmXm7XTdUN1/CT5I+sr0nPEJVnkxCFF7cWZtV6r5BYkiRYK
 gRS2RDIaRp+MYGhImskWGJ2NancJNYIKal9IbBV3b6acskpJabm+N5iKTzlslkEQO6+0
 FiHZNBx4fMsJLXaH1puf3uOdI6ZfAhfJ8mgUOKyIa3mJs0arbZwl5Z+v+tKcqzVRasbx
 SQDQ==
X-Gm-Message-State: AOJu0YyYTDaqF8UQx+MhcShXgZcBQfXcOSoC1zi/EE9ThT8iRGrBn5Uy
 jXPe726b788AFE8knMbd8DsMEf4k4uU6xrt/+R3EEJsi
X-Google-Smtp-Source: AGHT+IGleYObiJpzbf+imFONcRAr9VroUBBO+2lnLYTDnny4i+SHTQzaknk2B6J1oG2wNz5q674zUSjjJN1mXk+0Blg=
X-Received: by 2002:a05:6871:a68f:b0:1e5:6f60:c0cd with SMTP id
 wh15-20020a056871a68f00b001e56f60c0cdmr3648344oab.55.1696602253218; Fri, 06
 Oct 2023 07:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <20231006052149.1566154-4-lijo.lazar@amd.com>
 <007b0fed-4982-4978-95e3-6763d114a97e@gmail.com>
In-Reply-To: <007b0fed-4982-4978-95e3-6763d114a97e@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Oct 2023 10:24:02 -0400
Message-ID: <CADnq5_MzHbigYydWy9xkT_rgNEpogU8+y4bodAy1NxD99acnZQ@mail.gmail.com>
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

On Fri, Oct 6, 2023 at 4:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 06.10.23 um 07:21 schrieb Lijo Lazar:
> > Add sysfs attribute to read power management log. A snapshot is
> > captured to the buffer when the attribute is read.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >
> > v2: Pass PAGE_SIZE as the max size of input buffer
> >
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 +++++++++++++++++++++++++++++=
+
> >   1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index 4c65a2fac028..5a1d21c52672 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1794,6 +1794,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct=
 device *dev,
> >       return count;
> >   }
> >
> > +static int amdgpu_pmlog_attr_update(struct amdgpu_device *adev,
> > +                                 struct amdgpu_device_attr *attr,
> > +                                 uint32_t mask,
> > +                                 enum amdgpu_device_attr_states *state=
s)
> > +{
> > +     if (amdgpu_dpm_get_pm_log(adev, NULL, 0) =3D=3D -EOPNOTSUPP)
> > +             *states =3D ATTR_STATE_UNSUPPORTED;
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t amdgpu_get_pmlog(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> > +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > +     ssize_t size =3D 0;
> > +     int ret;
> > +
> > +     if (amdgpu_in_reset(adev))
> > +             return -EPERM;
>
> Please stop using amdgpu_in_reset() for stuff like that altogether.
>
> When this is reset critical it should grab the reset rw semaphore. If it
> isn't than that check isn't necessary.

All of the power related sysfs files have this check.  It was
originally added because users have processes running which poll
various hwmon files at regular intervals and since SMU also handles
reset, we don't want to get a metrics table request while a reset is
happening otherwise the SMU gets confused.

Alex

>
> Regards,
> Christian.
>
> > +     if (adev->in_suspend && !adev->in_runpm)
> > +             return -EPERM;
> > +
> > +     ret =3D pm_runtime_get_sync(ddev->dev);
> > +     if (ret < 0) {
> > +             pm_runtime_put_autosuspend(ddev->dev);
> > +             return ret;
> > +     }
> > +
> > +     size =3D amdgpu_dpm_get_pm_log(adev, buf, PAGE_SIZE);
> > +
> > +     pm_runtime_mark_last_busy(ddev->dev);
> > +     pm_runtime_put_autosuspend(ddev->dev);
> > +
> > +     return size;
> > +}
> > +
> >   /**
> >    * DOC: gpu_metrics
> >    *
> > @@ -2091,6 +2129,8 @@ static struct amdgpu_device_attr amdgpu_device_at=
trs[] =3D {
> >       AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                          A=
TTR_FLAG_BASIC,
> >                             .attr_update =3D ss_bias_attr_update),
> >       AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                         A=
TTR_FLAG_BASIC),
> > +     AMDGPU_DEVICE_ATTR_RO(pmlog,                                    A=
TTR_FLAG_BASIC,
> > +                           .attr_update =3D amdgpu_pmlog_attr_update),
> >   };
> >
> >   static int default_attr_update(struct amdgpu_device *adev, struct amd=
gpu_device_attr *attr,
>
