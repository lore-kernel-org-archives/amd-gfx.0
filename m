Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC6C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 20:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61561D9A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 20:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61561D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECD989FCA;
	Tue, 29 Jun 2021 20:06:18 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5968F6E8F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 20:06:16 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 59-20020a9d0ac10000b0290462f0ab0800so16053902otq.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dWjwb+D04+Ctf6Ws9fSRf0HruduB/Hh/Hnq4nvPFCfM=;
 b=NW7DKGu7QWS3PLDyZZ7JU68pA8vbSui61XaPHqqbG26rj6QUHlcQbX0tUNH6CLicmQ
 7i4O1Ar09DoScx+IAJWH5OULuuWfzeGXsgFveg0+4GGK2Fplwc2YCx4MG/tUrlrU41mw
 pyZgmWLnybPdgw6YgZafK6v1PiB5y2weX56rUwYuIl+jg25JKAyEauvTV/EbgbbaHCkx
 G5xIjJvOwo51INZ5+LluBVYy4e0wBBcRKkvE5tSzkrFJxy6f/XeYq5R7ZucuZukqCUJX
 RPMONbMsKFI54uP++AWS9MNitUc7w3Qz6HGZ8ObbGYVf13nGeaFFMVl0+AjH919qFwFD
 026g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dWjwb+D04+Ctf6Ws9fSRf0HruduB/Hh/Hnq4nvPFCfM=;
 b=dYzRIKicvcI8zXLSqzqg6X8JKuyX+v1cpyqUnF0NXIeqLNu/rEHXwASLPIF+Qmd1G2
 t6HivCjs42zLdrtCbqCKzhaalwTCKpXU74DV+yO+si4kGEFQP0gcNVqSzepaSLwrFBhs
 zAMmbUSte1UykHHt8lB7lmbTZhsW+y1tdCLVtSswyUAAos6bkkaL0fM6hogRpwJwG7YV
 FMmg7NR10jyHWZMdNfPLn7vO2inLyLNTRBb/mbLe0TKQmpP7bTIAgYggECC+d3+Za6zv
 +gP8TM+KxtqCiLTxWL/KwmuT5CZo8IKi6xDLlAKB5wk2ArD/ZtdKL5rS0jndvAndAG3F
 2QXA==
X-Gm-Message-State: AOAM531i7qOP3xqgVjvrj8PqfVTY+ITBNqoaMJVNZhkPirfsGVEhYq6B
 f9y5ItNXwb1P74TwVT9E1QLAU7IK9ClhDleALdk=
X-Google-Smtp-Source: ABdhPJyi8YIy6VZEoIsOdE3kKEMKhM4tH7PuZ9G0kpV/dlxI63eYXbJ6eSi5B13oF9jsOrhIMDxVz4UWi7LoAH0f4n4=
X-Received: by 2002:a05:6830:1e64:: with SMTP id
 m4mr5841941otr.23.1624997175724; 
 Tue, 29 Jun 2021 13:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3xKZ1PQeZXiXNootYrdPc5RHo9KZ5vM8zX3V5ydAD8-AhfMA@mail.gmail.com>
In-Reply-To: <CAB3xKZ1PQeZXiXNootYrdPc5RHo9KZ5vM8zX3V5ydAD8-AhfMA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jun 2021 16:06:04 -0400
Message-ID: <CADnq5_NvNYpmGJQhQCi4uQPu54Qy4yvXrLiMMZW=WZeJG3XEBw@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
To: Ketsui <esgwpl@gmail.com>
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

On Tue, Jun 29, 2021 at 3:57 PM Ketsui <esgwpl@gmail.com> wrote:
>
> I have the 3200G I'm still getting this error with that version.

I think the 3200G may be a raven or raven2 variant rather than
picasso.  Can you try the latest firmware from upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/amdgpu

Alex

>
> [ +23.754701] amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:2 pasid:32773, for process mpv pid 5016 thread mpv:cs0 pid 5064)
> [  +0.000017] amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x80010009e000 from client 27
> [  +0.000007] amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00240C51
> [  +0.000003] amdgpu 0000:08:00.0: amdgpu:       Faulty UTCL2 client ID: CPG (0x6)
> [  +0.000003] amdgpu 0000:08:00.0: amdgpu:       MORE_FAULTS: 0x1
> [  +0.000002] amdgpu 0000:08:00.0: amdgpu:       WALKER_ERROR: 0x0
> [  +0.000002] amdgpu 0000:08:00.0: amdgpu:       PERMISSION_FAULTS: 0x5
> [  +0.000002] amdgpu 0000:08:00.0: amdgpu:       MAPPING_ERROR: 0x0
> [  +0.000001] amdgpu 0000:08:00.0: amdgpu:       RW: 0x1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
