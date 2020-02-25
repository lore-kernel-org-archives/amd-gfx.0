Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC3C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5A121927
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0iSt/hP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5A121927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278C16EB20;
	Tue, 25 Feb 2020 15:11:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6BA6EB20
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 15:11:52 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id u6so15187713wrt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HhHyNuy5Cv01CWid9iyJuotfFjFjkqfYa/Ci7/v5IJc=;
 b=s0iSt/hPp3p8IyhEmXGCXtx1ZSuDYo4MJLYTkWQ0QtBUNw2c0Vu8Le0biXsDahdbE7
 ySzIQJz88CE1xcrpnbt5/qUbWDrU2dXq6WTsblSPbxY0BPjKhMNdRdKdMn6hJ9+sgL9J
 1TeUz6gCFi2PNZUqhMfjt5oIUiEncWZPKloI21qHfHfyPeA34OEjD9oFzg2B17STJCGy
 oW+A84aQ0lLuGbFt7wxUSGLcC18ujPEGoH9IYpbEqtiGbNDaeGodmCrWN8lxJ9T0Xemv
 VLvvdkAaT6nNIU0LluY+lnaqAVU3+UMIJMquiQrWv+iRNcqFv2fPfeICK6b3y23BsLg1
 Lgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HhHyNuy5Cv01CWid9iyJuotfFjFjkqfYa/Ci7/v5IJc=;
 b=Yh2YkMkAZxgqC7CdnDI+ztx8yTzpiXNinI3bw5WOaKMOaRy1SRdvHWGMnupHMEJM3Y
 xd+KzZW/2a+ftl6MM9aU3ZCZI0syTX41Ni7IWc+ak18mfNchGfVV4c+F7/hUknKS9ILY
 NFFKbwhaScBHAMT18z1w+QII0Xk1wlYXGlsCAbdZ//zFp+j/Y4BsVphsLjGnLxL4xWG6
 PonFNqyL33WaOBiKRQzcGQPR/LM3q09HN3MKutmPqRRE/8okUQgn/uvA+ANmBX91MdsM
 UaldfM62il9qHZ0tWO3y5iLn8EP30tpYc3/wn8XMkLt4gX67EGHRzHo61PlWRM/+McFs
 SRFA==
X-Gm-Message-State: APjAAAU4di/a2bzKH8eC0375bO5XC6XfCT0bIbL77J+oqUpVv+kt06Ay
 7jECGuENmZ5z5Rp5wC1SpU7CIHHgqMoILSy+ANp+vg==
X-Google-Smtp-Source: APXvYqzaosHBkjolj1aoSOi9VlDeMthtYo5xvas1ibR/ysEmbm39tnIGl9wTA7XpHOpLbZ9TSWc0rp9wht0saNm3HY0=
X-Received: by 2002:adf:9282:: with SMTP id 2mr22635417wrn.124.1582643511645; 
 Tue, 25 Feb 2020 07:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221184510.636829-1-tom.stdenis@amd.com>
 <CADnq5_Oi2w=Wy3m7e9v1wXd003Rbe2RYmwWSD3DOHz8Okbeyew@mail.gmail.com>
 <0e1a2283-7345-a1f4-f5df-76938e7cebbd@amd.com>
In-Reply-To: <0e1a2283-7345-a1f4-f5df-76938e7cebbd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 10:11:40 -0500
Message-ID: <CADnq5_Mykdzuc8Qicv9oZpavNts0s9o5r9tTCST-=-YxcgZF=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add gfxoff debugfs entry
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 24, 2020 at 9:41 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
>
> On 2020-02-21 1:59 p.m., Alex Deucher wrote:
> > On Fri, Feb 21, 2020 at 1:45 PM Tom St Denis <tom.stdenis@amd.com> wrote:
> >> Write a 32-bit value of zero to disable GFXOFF and write a 32-bit
> >> value of non-zero to enable GFXOFF.
> >>
> >> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 56 +++++++++++++++++++++
> >>   1 file changed, 56 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> index 7379910790c9..3bb74056b9d2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> @@ -842,6 +842,55 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
> >>          return result;
> >>   }
> >>
> >> +/**
> >> + * amdgpu_debugfs_regs_gfxoff_write - Enable/disable GFXOFF
> >> + *
> >> + * @f: open file handle
> >> + * @buf: User buffer to write data from
> >> + * @size: Number of bytes to write
> >> + * @pos:  Offset to seek to
> >> + *
> >> + * Write a 32-bit zero to disable or a 32-bit non-zero to enable
> >> + */
> >> +static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *buf,
> >> +                                        size_t size, loff_t *pos)
> >> +{
> >> +       struct amdgpu_device *adev = file_inode(f)->i_private;
> >> +       ssize_t result = 0;
> >> +       int r;
> >> +
> >> +       if (size & 0x3 || *pos & 0x3)
> >> +               return -EINVAL;
> >> +
> >> +       r = pm_runtime_get_sync(adev->ddev->dev);
> > Not really directly related to this patch, but If you are using umr
> > for debugging, we should probably disable runtime pm, otherwise the
> > entire GPU may be powered down between accesses.  There is already an
> > interface to do that via the core kernel power subsystem in sysfs.
> > E.g.,
> > /sys/class/drm/card0/device/power/control
> > /sys/class/drm/card0/device/power/runtime_status
> > Something else to look at for umr.
>
> We ran into something related to this for UVD/VCE access back in the
> day.  When powered down the MMIO registers are mirrored and accessible
> but while in transition they are not.  So we added a PG flag to the
> offset in the debugfs entry to flag when we need to take the pm mutex or
> not.
>
>
>
>
> >
> > We don't store the state for when we dynamically turn it off like this
> > so if we get a GPU reset or a power management event (runtime pm or
> > S3), GFXOFF will be re-enabled at that point.  This is just for
> > debugging though so:
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Good to note.  Can I get a R-b from someone though so I can push this out?

You can convert mine to an RB if you prefer.

Alex

>
>
> Tom
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
