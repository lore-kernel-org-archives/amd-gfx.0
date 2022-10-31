Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC1BECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 19:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B8D10E0E5;
	Mon, 31 Oct 2022 19:00:13 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6AC10E124
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 17:57:38 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id o65so10383721iof.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YPhKQoj326GDzQlpnATdi3QTN2ODDVoVrBVz75un/+Q=;
 b=sYhCXj1H3jsEvNOxWVGQJ+afX+j7LSp//QRFn83qUscI4Eep1oum3gEorgso/be61X
 ajUR+t2AHGLP7unbb9SEG4GCzpn7VMEt6fVz3yMCR+4ZJ2k3N8stJM6//h4FEAJbIubJ
 MOOT43YiJCNfV80lePj7IvdInQ56gfiODzSNIvTFqKsEvfjmwnVlO3+L5O5Y3nhWI6O9
 K0momkWkmHHQDU03ZdNfJPII5w9jSCVvXNB82RukQlzW01UlJ4B1/V2Qp7oeIwej2Rl7
 PL3/vaZkjrV+KbyrAUGu7zMuleUc1H3ioPDhznC7VYrfu9Cw6tC8fzAUPh9zYrRX+7ci
 ga9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPhKQoj326GDzQlpnATdi3QTN2ODDVoVrBVz75un/+Q=;
 b=K+5q+0oy+1NjNhA7USBDN8yDYLBiv6fl4uV0rZMOrHpAaH/Rdl6WpPV5VTPQN7A6OD
 SweUcKwgG8c+0gLggcXrA88bLW4NXTF2f0TVz+IVyR3UbsziUf8k85HJYNIi3/coTTuu
 IRt/a78CQc116grDczqMq3TR/iefznw5+NInKaD+7GnHcrFjIsW5Yddjx7HLtGcjKU+2
 4NxtBPghh5Ljn5DUshxBSYz8dI+wGhPGnp8PKkE1TwLs8FB/BFYaCdQ3ayts7e2Qkb18
 mjd/H+SvrivpFNDOYClwlARD80UGZgSaeydXji6CJTq6vF/LqsgTTwCGB1Wpsldeunke
 VO7Q==
X-Gm-Message-State: ACrzQf19LTY7h2mVL40+5fxztenSvc4DEALeWZCQI94JvD88DfpEGRkS
 cjcXZwiB39mqtG+E03q1xtwc7gylkq42SL/Fr7cJFm6O5Ka7WQ==
X-Google-Smtp-Source: AMsMyM67XExll5UMwgggCXPKhjzVkZsaaGn9qC5GldyBHD5Q2MvvxO4lzgg49TL6tCvFB/QDf6Wp9kYI9i6MgOY9SQ8=
X-Received: by 2002:a02:a30c:0:b0:375:3a7a:de7e with SMTP id
 q12-20020a02a30c000000b003753a7ade7emr7890398jai.246.1667239057308; Mon, 31
 Oct 2022 10:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
 <425617d8-3d36-f50e-e582-826a4c6da32d@amd.com>
In-Reply-To: <425617d8-3d36-f50e-e582-826a4c6da32d@amd.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 31 Oct 2022 18:57:01 +0100
Message-ID: <CAG48ez1Bkk0b6HtSnWcRPfYV0zxYJO_2kuC6s9jmRNwfYcXAiQ@mail.gmail.com>
Subject: Re: [BUG] AMDKFD: criu_checkpoint() error path treats userspace
 pointer as kernel pointer
To: Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 31 Oct 2022 19:00:09 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel list <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 31, 2022 at 6:54 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> Am 2022-10-31 um 10:20 schrieb Jann Horn:
> > be072b06c73970 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
> > added an error path in criu_checkpoint() that (unless I'm completely
> > misreading this) treats the userspace-supplied args->bos (which was
> > previously used as a userspace pointer when passed to
> > criu_checkpoint_bos()) as a kernel pointer:
> >
> >    ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> >        (uint8_t __user *)args->priv_data, &priv_offset);
> >    if (ret)
> >      goto exit_unlock;
> >    [...]
> > close_bo_fds:
> >    if (ret) {
> >      /* If IOCTL returns err, user assumes all FDs opened in
> > criu_dump_bos are closed */
> >      uint32_t i;
> >      struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket
> > *) args->bos;
> >
> >      for (i = 0; i < num_bos; i++) {
> >        if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> >          close_fd(bo_buckets[i].dmabuf_fd);
> >      }
> >    }
> >
> > This seems very wrong, and also like it's guaranteed to blow up as
> > soon as it runs on a machine with SMAP, which makes me think that this
> > codepath was probably never exercised?
> >
> > (Also note that just changing this to copy_from_user() instead would
> > still be wrong, because malicious/bogus userspace could change the FD
> > number to the KFD device's FD, and the VFS assumes that an FD can't be
> > closed while it's being accessed in a single-threaded process.)
>
> Thank you for catching this, and thank you for the advice. In other
> words, we need to store a copy of the FDs in a kernel mode buffer that
> is not accessibly by usermode, so we can reliably close the correct FDs
> in the error handling code path.

Sounds good to me.

> Rajneesh and I will fix this ASAP.
>
> Do you think we should also avoid copying the FDs to usermode before
> we're sure that we'll return success? I don't think it would make a big
> difference because user mode could try to guess the FDs and use them
> before we return from the ioctl either way.

Yeah, that shouldn't matter - as you said, userspace can guess the FDs.
