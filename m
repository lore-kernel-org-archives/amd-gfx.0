Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 20:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4B110E7C8;
	Fri, 18 Nov 2022 20:19:26 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B70310E7C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 20:19:22 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1322d768ba7so7244056fac.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsddUOlMjO1pL6o+s4BHIGZ2jvEyiXi4dlz27LYfuOs=;
 b=VAP1xkNoD9bZSPiubhIs5pToNg7kXX4VN/HANSywn3jtAinSq0Ae8BGKYZR/cMAO7o
 KFWQcebnG5ntjsZs/8efBwfouIpDGGFtIvZYfwvmxcF2Fvjz9ivrfL+whVXcp6e5v/yf
 sJJ2v9aRwnZt+Vj/M9Nc7Z/vNdo6kXV4965X7tgTmtlYe/uaoK+seYhKi2CsoUKWPZu5
 Yhx5xW9q+C7qHwRNzVid+FpLGN7QGBioZb/HzkxoKR3QtYNpBLA+wySBLbeCNeWHv6LS
 qlEXjW8S8LxzQ2Q9Hh0v2QymNAr/lAxcAfTyxbajSeRAMkfGa0rZFd9i/vhgboOKIuY9
 /t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsddUOlMjO1pL6o+s4BHIGZ2jvEyiXi4dlz27LYfuOs=;
 b=FE47lq5vHsTRjX8Tk759i+IeLacEVaQoSanAgG9aRRooLsUzHY/DB/VJAEh2aZlYmA
 m6AN6IMd7CzzvLNut0VhJibq4q46y+2EX92PvuPDb2m25CBuOCw1FnWfAVmPeNd38mY5
 W1x3cvP5LfpcVKdiqOuzY/glaT33WNJ1Bdh5bizZ1Evgams3Hd+qu2NW+HJD4olmKnvA
 6rZHVFkWasf475dv6gVu+wqLq11Dsu90Oh5D6TXkOWskjCyiHg9rq5U5Yr1iq8HKWX+p
 aIKCS3iiuYP3BfIuaQ7ZXPhDPoqf0ENPoZ0Nu9p1ohq2IdACSpg7zTnBdLD62eZaUlqD
 dyaQ==
X-Gm-Message-State: ANoB5pkcx2a+sR/7Y+CO6BPo3q1S3d9ajUo6FxUjRn6sEWkkM2w3Rnlp
 kWoNbEq7G2gfXHF0ZIP8swxhZFsKl5NqcwyJPOs=
X-Google-Smtp-Source: AA0mqf4aZ7bEwL+DXn/7hBzufNPfafEWuY3eEND5oFpq/UnHznxec9LjiydF1vg+xJI73FuCDKFYL73/FPraTaofaew=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr8311076oab.46.1668802761793; Fri, 18
 Nov 2022 12:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20221117150003.397385-1-yangyingliang@huawei.com>
 <DM6PR12MB26199CD7A4AE5856B753FCF9E4099@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26199CD7A4AE5856B753FCF9E4099@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Nov 2022 15:19:10 -0500
Message-ID: <CADnq5_PoHDA=gDHUobOJFrhUJPf6smTqEEtA9X25gET0CwwZcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix pci device refcount leak
To: "Quan, Evan" <Evan.Quan@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Yang Yingliang <yangyingliang@huawei.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Nov 17, 2022 at 8:55 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Yang Yingliang <yangyingliang@huawei.com>
> > Sent: Thursday, November 17, 2022 11:00 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>; yangyingliang@huawei.com
> > Subject: [PATCH] drm/amdgpu: fix pci device refcount leak
> >
> > As comment of pci_get_domain_bus_and_slot() says, it returns
> > a pci device with refcount increment, when finish using it,
> > the caller must decrement the reference count by calling
> > pci_dev_put().
> >
> > So before returning from amdgpu_device_resume|suspend_display_audio(),
> > pci_dev_put() is called to avoid refcount leak.
> >
> > Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state
> > before gpu reset V3")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 64510898eedd..69e73fef1ab2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5027,6 +5027,8 @@ static void
> > amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
> >               pm_runtime_enable(&(p->dev));
> >               pm_runtime_resume(&(p->dev));
> >       }
> > +
> > +     pci_dev_put(p);
> >  }
> >
> >  static int amdgpu_device_suspend_display_audio(struct amdgpu_device
> > *adev)
> > @@ -5065,6 +5067,7 @@ static int
> > amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
> >
> >               if (expires < ktime_get_mono_fast_ns()) {
> >                       dev_warn(adev->dev, "failed to suspend display
> > audio\n");
> > +                     pci_dev_put(p);
> >                       /* TODO: abort the succeeding gpu reset? */
> >                       return -ETIMEDOUT;
> >               }
> > @@ -5072,6 +5075,7 @@ static int
> > amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
> >
> >       pm_runtime_disable(&(p->dev));
> >
> > +     pci_dev_put(p);
> >       return 0;
> >  }
> >
> > --
> > 2.25.1
