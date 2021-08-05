Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C89C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 18:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4898E6112F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 18:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4898E6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99876E8A8;
	Thu,  5 Aug 2021 18:21:44 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5736E8A8;
 Thu,  5 Aug 2021 18:21:44 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 c2-20020a0568303482b029048bcf4c6bd9so6078291otu.8; 
 Thu, 05 Aug 2021 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=27qj2SWHf1ITmiEsMbQM8FzGSFNAOy3v+jLUQb3Ja84=;
 b=KfJY1YUJIGR7TvsAVd7lBr89GqNQUjB9YAaf/2DLFZBymgDfomTuzE8vyS0sdSIe2J
 nr/Ctl8RHwIxj3Eul7qbc6jdtiiwEhWoRsLLLigKmKTHYt2o+/J3OcNXjsGVQAIZsoHn
 cpDHhiaY1EBOn8zhBBn/luIB0cbu2eX/LrfddnrjCod/mEUpopCyLhiVtXvj+lRub2Ri
 BfTgteRJAYiYYz26hVBGG0EcE2Z+ddzzXliwuqOJ1TntGB6FcCIK0thOEp1uxj7IAvDc
 j4S9xOpsG+wMpLZUWbUBWi1T6URWvGYcwNSygVQB4XVI1k6ovB6VA9vtlC2GxD2tKZo9
 FZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=27qj2SWHf1ITmiEsMbQM8FzGSFNAOy3v+jLUQb3Ja84=;
 b=dZA2KA85X7yJMipAL6NDnqkgKBOR2TtFbVldKUpIe0xU4LBhShsZvyGVR09Y51UXna
 DsUMHSAgrwYqYCP37uZJxq9z9ipW75LWA7kXVxL8qQZY/9jnpnlmu9fVIq8ibTz/KJqo
 elz4Y9FtVt0qbup3j8dEmqZELqkWZP3KsptDxlSLPEHsPnpyHOB58uRdTRFwBCjmzqc+
 2OEeaVHyXX0q0lox/Kug0DaCK+mTeRp7t15v7oXU1eofQ5mHVtejXtJ3pGvZey36BKey
 Gs4L4CxxFInX59bvJLTWgdELmcqzOV/czCHzhiaLgCIHkoH54RnbwVc0ZkvVnldDPvIB
 EPdg==
X-Gm-Message-State: AOAM532IwlcqVd9W9dt3i1UPMFFnjepZ19LaHcO94R/7ltm0ZYC2NQRW
 SyTf8m0n0sS9ozWzfpKd5qJ2i6mtjT7esQMu0pg=
X-Google-Smtp-Source: ABdhPJxEFl9g2uIR7AX/5xRKU2EoUakZ8tDgBO6V/DlWWQ9gFUU2CtMZ7xgrDvbpoNlW+6PhoRR5f5SqhnQmG5wrXhk=
X-Received: by 2002:a05:6830:1c2f:: with SMTP id
 f15mr4696064ote.23.1628187703609; 
 Thu, 05 Aug 2021 11:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twko1gCNTB3CPf7CAQqWFayMj=1fa3ZoEwwviDFhF48kQ@mail.gmail.com>
 <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgYq=EpNmDPNVxnBX+HpjNcQg50DSjuxZuK0UbZjh-pnQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Aug 2021 14:21:31 -0400
Message-ID: <CADnq5_M7gbOn34_57ipGjfpo7FvB3sFQnSOtkPUvstshX4V-zQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.14-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Harry Wentland <hwentlan@amd.com>, 
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 5, 2021 at 2:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This might possibly have been fixed already by the previous drm pull,
> but I wanted to report it anyway, just in case.
>
> It happened after an uptime of over a week, so it might not be trivial
> to reproduce.
>
> It's a NULL pointer dereference in dc_stream_retain() with the code being
>
>         lock xadd %eax,0x390(%rdi) <-- trapping instruction
>
> and that's just the
>
>         kref_get(&stream->refcount);
>
> with a NULL 'stream' argument.
>
>   Call Trace:
>    dc_resource_state_copy_construct+0x13f/0x190 [amdgpu]
>    amdgpu_dm_atomic_commit_tail+0xd5/0x1540 [amdgpu]
>    commit_tail+0x97/0x180 [drm_kms_helper]
>    process_one_work+0x1df/0x3a0
>
> the oops is followed by a stream of
>
>   [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR* [CRTC:55:crtc-1]
> hw_done or flip_done timed out
>
> and the machine was not usable afterwards.
>
> lspci says this is a
>
>  49:00.0 VGA compatible controller [0300]:
>    Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
>    [Radeon RX 470/480/570/570X/580/580X/590]
>    [1002:67df] (rev e7) (prog-if 00 [VGA controller])
>
> Full oops in the attachment, but I think the above is all the really
> salient details.

Thanks for the report.  Adding some display folks to take a look.

Alex
