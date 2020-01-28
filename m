Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9BAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 17:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3192465B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 17:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="qipFRQ3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3192465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859036EF2B;
	Tue, 28 Jan 2020 17:39:31 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F496EF2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 17:39:30 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id e25so10895952qtr.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3pqrElJ/6exdeGh6RS3kU3h+xISt6w4sCN70dd6PfKE=;
 b=qipFRQ3xb8Nb0DGij5CjNXzzd4s+08rdTABe8wqb7KQWRhwzCq0AVPEk4ddmc5AK7R
 duJ/yDGivFqZQCdt1uf/W97dO5JqiWb3zyln2BUhGt5FoZoGGM/SOJxwoDMMA1vy9mM3
 QBgZTfg7SmisoIHjYPiAHH9U1SqVVYJlXZ0RlWd7ktouO24USe9jwGNkP+1ACU2Kdroh
 MLyc7sYeQS9n7jSZX2RFCqToF+gzmkkZnmxueGcTYk9KyMQqatRZQ73j8qxM5RSMvq+U
 MQdvq3HzGHE/nnLzv+OsEI4Q6D4fVopcX95JBbDA5L/czoeJGHxBqGS8T9Nevd+Wafp9
 HRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3pqrElJ/6exdeGh6RS3kU3h+xISt6w4sCN70dd6PfKE=;
 b=EVgYh3TjEWc3c9kGEIqoAl1yzoVujPfNvoPVicE1yo20Y/tEiDgLTV3iUSsGC7wA04
 sIUzzWMtsiHfJUFXjWrj5UjkU7DvY7mDWVBAuSVgGqB7jd71JhP1E99lOva3V/npQXsO
 e6UP1Jkjzxf9+SIbTmP4vtPGnZuhBIGZeSLVuDuvEC4DL5VHRvgmemfTK2PVeoxxADmM
 efk8UBV56eD6eDEuPkeg4ZOd5xwbUG+oio3VcZzSRE5EN85aU4d6/VunnNzokjW7ATOS
 LCaJMbT/OIFtcOjdWfmRrxw2BzH+4YLnt7i1HgQY5nCUULLSKVe0ja5P6PU8DCsB+5ci
 36Mw==
X-Gm-Message-State: APjAAAXqkqX3zJNPBEE26gW05l1cZmODT5/zD1c4Wx9cwYvL7/U5kUZ6
 cEXlKi9tuPP7rhTmIWlX3zxQc1HSdunp/kZyyCpCrg==
X-Google-Smtp-Source: APXvYqxHSfUUc1yMjKwvL59oe9UMlTB1u5NAjfgmdl5vyggz6AjLGSe8xirEPRgXVO1NEhyhIiA4Cjq3CwTc5PEbnVY=
X-Received: by 2002:ac8:5358:: with SMTP id d24mr12366931qto.161.1580233169573; 
 Tue, 28 Jan 2020 09:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 28 Jan 2020 17:39:18 +0000
Message-ID: <CAHbf0-G_mG-awokOA5yeLwp4CKzQ1WB_a6rBLj-xKY5cnS+YUw@mail.gmail.com>
Subject: Re: [Patch v1 0/5] Enable BACO with KFD
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Is this designed to work with PRIME laptops too?

On Tue, 28 Jan 2020 at 01:29, Rajneesh Bhardwaj
<rajneesh.bhardwaj@amd.com> wrote:
>
> This series aims to enable BACO by default on supported AMD platforms
> and ensures that the AMD Kernel Fusion Driver can co-exist with this
> feature when the GPU devices are runtime suspended and firmware pushes
> the envelop to save more power with BACO entry sequence. Current
> approach makes sure that if KFD is using GPU services for compute, it
> won't let AMDGPU driver suspend and if the AMDGPU driver is already
> runtime suspended with GPUs in deep power saving mode with BACO, the KFD
> driver wakes up the AMDGPU and then starts the compute workload
> execution.
>
> This series has been tested with a single GPU (fiji), Dual GPUs (fiji
> and fiji/tonga) and seems to work fine. I have not seen but expect some
> corner cases where for some reason a KFD client binds a process but is
> unable to complete the task within 60 seconds. Ideally we should put the
> runtime_put and auto_suspend code in some function which is logical
> opposite of bind_process_to_device but during my experiments, it ended
> up with random gpu hang, machine reboot etc so any comments for
> improvement are welcome.
>
> Todo:
>
> rebase on top of https://patchwork.freedesktop.org/patch/338037/
>
> Rajneesh Bhardwaj (5):
>   drm/amdgpu: always enable runtime power management
>   drm/amdgpu: Fix missing error check in suspend
>   drm/amdkfd: Introduce debugfs option to disable baco
>   drm/amdkfd: show warning when kfd is locked
>   drm/amdkfd: refactor runtime pm for baco
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +++----
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c   | 27 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
>  10 files changed, 91 insertions(+), 33 deletions(-)
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
