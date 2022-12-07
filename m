Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20FEC63703
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 14:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B6210E109;
	Wed,  7 Dec 2022 14:58:56 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEFA10E109
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 14:58:51 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-14455716674so15422328fac.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Dec 2022 06:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dnsAlzMws8feEwK9BnFGuDj2giVPz6pahFN0B57RgNQ=;
 b=RwVs81sWd0YOCNeGXT3aW+6BUYGoisICIy06QVcgVCYTnUgsVN9ekyyEwkrRyXN2rx
 M1OeHiQ/waiCFpX2QMWV6vkB0i+oezlp5FwME27dPYloKtmvuzZcb4KJrPvLemF7ZdNT
 XtN0xevyZyhnKkhaNxiFtz7eFvnDs+/BQUtX7BAtFxSENGJQESRdxm9oRJdFB2KgJQw5
 CQYMWj4P8WiN0rwQGRo8Ap5Wnw+EV0Sf6djDqgTS6o9Sq29A2JflC56BvbyLqCnlJPgV
 7qY29wjRFl6WgM7RUbOszx4fFp8nM8klaonihK4ej3ksAL7sFNPZskG3FFsee03ukZ1m
 n49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dnsAlzMws8feEwK9BnFGuDj2giVPz6pahFN0B57RgNQ=;
 b=ut2y6ib4fKGt100j7BpujvXJoJwKejJ/e9kaGMme5LM/ax38n9X5iG29HUdmv6RzfE
 1UdRF/ABXXuJfQXGhQ7sCOxu2Vh0N+tibLUJGJNZb33lhadRjeOl60WihzeKUn9LNNXX
 v4tcdHYOQzt3RJE6Ga5Zg1bdEIlz/clA1vRCLsWy5mn8rb9kYG+NutqBS7rCbC0G+wsc
 s9JZCM+exWPrYXCHSMaoNSG6z+yYX2/S9HPhcz/fuiUlMzG45sq62xd9hVFMcIe/ccKU
 qtgyh3Lp0W47NmnsMO87spE11ab4MVd+8mvZr4LC6hqS2VxRKObuufrz6PsPkOUOmWKf
 uiNw==
X-Gm-Message-State: ANoB5pm2aS6Tr0EaDlfFjWstJGAWPk8GQDXiCvLLoDoUqIT2Lmh/0Fxg
 tkWWjjgjS0o/5gZeuVA1p394c+mtPZYmZtvnKVs=
X-Google-Smtp-Source: AA0mqf6UKRvsSUUFWT4WOAY30LTUv7r50R0rLME00huHEUG5o8n8KtXkC/cSXSYOA4JZ+eVVr+4dzXGm6v2hI9SQJg8=
X-Received: by 2002:a05:6870:7a0c:b0:143:8a81:116c with SMTP id
 hf12-20020a0568707a0c00b001438a81116cmr28719436oab.96.1670425130260; Wed, 07
 Dec 2022 06:58:50 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
In-Reply-To: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 09:58:39 -0500
Message-ID: <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7
 on certain video files leads to problems with VAAPI hardware decoding.
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, James.Zhu@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 9:44 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
>
> I found a commit that on certain video files leads to problems with
> VAAPI hardware decoding.
> Reproducing the issue requires mesa to be built with the h264 hardware
> encoder enabled and the attached file to be playable in the vlc
> player.
> Before kernel 5.16 this only led to an artifact in the form of a green
> bar at the top of the screen, then starting from 5.17 the GPU began to
> freeze.
> In 6.0, the problem with GPU freezing is solved, but the kernel itself
> freezes when certain actions are performed. And the vlc application
> cannot be terminated in any way.

What GPU do you have and what entries do you have in
sys/class/drm/card0/device/ip_discovery/die/0/UVD for the device?
specifically the harvest settings for each instance if there are
multiple instances.  If you had an rx6700 you might have been using
software rendering prior to commit
7cbe08a930a132d84b4cf79953b00b074ec7a2a.

Alex

>
> The kernel trace would be like:
> [  976.184187] amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:40 vmid:1 pasid:32785, for process vlc pid 9905 thread
> vlc:cs0 pid 9956)
> [  976.184205] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x0000800106b53000 from client 0x12 (VMC)
> [  976.184210] amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00141651
> [  976.184213] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID: VCN0 (0xb)
> [  976.184216] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x1
> [  976.184219] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x0
> [  976.184222] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [  976.184225] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x0
> [  976.184228] amdgpu 0000:03:00.0: amdgpu: RW: 0x1
> [  976.184234] amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:40 vmid:1 pasid:32785, for process vlc pid 9905 thread
> vlc:cs0 pid 9956)
> [  976.184238] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x0000800106b52000 from client 0x12 (VMC)
> [  976.184242] amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> [  976.184245] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID:
> unknown (0x0)
> [  976.184248] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x0
> [  976.184251] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x0
> [  976.184253] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x0
> [  976.184256] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x0
> [  976.184259] amdgpu 0000:03:00.0: amdgpu: RW: 0x0
> [  976.184264] amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:40 vmid:1 pasid:32785, for process vlc pid 9905 thread
> vlc:cs0 pid 9956)
> [  976.184268] amdgpu 0000:03:00.0: amdgpu:   in page starting at
> address 0x0000800106b53000 from client 0x12 (VMC)
> [  976.184271] amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> [  976.184273] amdgpu 0000:03:00.0: amdgpu: Faulty UTCL2 client ID:
> unknown (0x0)
> [  976.184276] amdgpu 0000:03:00.0: amdgpu: MORE_FAULTS: 0x0
> [  976.184279] amdgpu 0000:03:00.0: amdgpu: WALKER_ERROR: 0x0
> [  976.184281] amdgpu 0000:03:00.0: amdgpu: PERMISSION_FAULTS: 0x0
> [  976.184284] amdgpu 0000:03:00.0: amdgpu: MAPPING_ERROR: 0x0
> [  976.184286] amdgpu 0000:03:00.0: amdgpu: RW: 0x0
>
>
> The problematic commit is:
> commit 7cbe08a930a132d84b4cf79953b00b074ec7a2a7 (HEAD)
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Mon Aug 9 11:22:20 2021 -0400
>
>     drm/amdgpu: handle VCN instances when harvesting (v2)
>
>     There may be multiple instances and only one is harvested.
>
>     v2: fix typo in commit message
>
>     Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
>     Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1673
>     Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>     Reviewed-by: James Zhu <James.Zhu@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: stable@vger.kernel.org
>
>
> Thanks!
>
> --
> Best Regards,
> Mike Gavrilov.
