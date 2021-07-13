Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80444C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 14:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0421A6127C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 14:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421A6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12FF6E0CF;
	Tue, 13 Jul 2021 14:40:42 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988C16E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 14:40:41 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so22761602otl.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DB1dBw6QYOGeRhe+xQ5ABZKFKBsEixtOkoHiIxRIjOc=;
 b=iAIzRAe/Dt7HWRcwt6s0QgXh3HWXSqlMigrm/syO2+D9Bkatwm8yP9dyOV9wGSvXP8
 svCPTnmmlYYtxv7lWGVkpC+skcxdT5gepLyaqflGQyUjRin1N4Tsnf6vrkKU8jsjOX/R
 EZmet3VAPp/saXmypCDaL/E6Y0L7Ni/NH+CM25CQK6e9d6RaYrRb3DsIh7kDv95EZorN
 6f0MSLIOeC9Nk7Mrwoq60urh2mCbuSX0RLd1fyjpaCvo2c6AX3NpYajEfFSIxo9Peqn0
 zLKgkOEaKi1uP1VVlXdnCEUWkXHEhGDuR1GMzUiYEMsy7f04zzjFN01npw3NdY/WCIiD
 cLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DB1dBw6QYOGeRhe+xQ5ABZKFKBsEixtOkoHiIxRIjOc=;
 b=nfVnMCEFqHapbDdt4+Z/GD5G4F2hRVOUKxbS7sJaC2UCzbS2S//a+45HvbejpusaNw
 u0+NB+aqQ9gExI7U3X/p98/QtG+CRFvg96JghcmhsQ5sg4N+28Nc4s+hTNXZAtCEV3vz
 NHRcdhpHuR9AORThvL7XZzNB4MgNqOlYJRD6SJ4yRtEoywLWuJvDGKY5cNwLpTyoT5cU
 Kpzrb5AZPLR5TK8oEjxopTBDAv+JTOSG8sCwDV93Mi+YpwCrqY0JCX5oB+Dz4BwrYDNf
 o9XeIt5L4u8vhYkx7/BZQtrgvNQr8JFqMO0Lvdv6pyb/dL8y1gjGnQvPiSFtp7lac3Lp
 hBcg==
X-Gm-Message-State: AOAM5319tj48bM3LVgdC9cHDzIzbcuOS9xETR60aouhlv61YJZhCEY8D
 ucqyWfMYuQHrXGa/Rl0E3ZgB7dmRoOh61NBbqe4=
X-Google-Smtp-Source: ABdhPJwNYvKxtSCI4sHnOSn9GsIFGufhHaKeeyr7y4lEG9cvpuuaQQacEG8ZfHzEHASKwvZTLKjFnt+xBALx9/BSQpQ=
X-Received: by 2002:a9d:2482:: with SMTP id z2mr1141513ota.132.1626187241004; 
 Tue, 13 Jul 2021 07:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <7f461adc-8868-0b76-cedb-d8be8d527218@daenzer.net>
 <YOqiQmAUTBWjbVb6@mainframe.localdomain>
In-Reply-To: <YOqiQmAUTBWjbVb6@mainframe.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jul 2021 10:40:30 -0400
Message-ID: <CADnq5_OLvV9LoNTFsiCi_Cm1-zYZmRyLvyCK59Kn7rZzrndXPA@mail.gmail.com>
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

On Mon, Jul 12, 2021 at 3:18 AM Ketsui <esgwpl@gmail.com> wrote:
>
> > So far, so good; no hang in a week. I'll try the rest of the new firmware as well now, will follow up if there's a hang again.
>
> I've noticed that the VM_L2_PROTECTION_FAULT_STATUS error doesn't always result in a hang, looking through my journal I can see
> maybe a dozen of them spread out across multiple boots but my system only became non-functional like two times so far (I know
> because I have the dmesg when the hangs happened saved, you can find them attached to this mail).
>
> To make myself clear, I haven't actually had a hang too with the new firmwares even though these messages still appear on my dmesg,
> sorry if my feedback gave the wrong impression.

Were these issues mitigated with older firmware for you previously?

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
