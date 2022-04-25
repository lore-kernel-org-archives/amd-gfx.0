Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56777C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 17:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3AE10F0A2;
	Mon, 25 Apr 2022 17:12:48 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CE410F0AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 17:12:47 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id q129so17838053oif.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+u/S/yPWVhNnjSYbLsyDazqBcVzHwKzX3VKk0nDog3E=;
 b=YKcpEASqDNN4e4TPaodMzhGedkJeOupH9R3p1jf3LOM1oIlv/P+EkPiGh6oTDR7Htl
 iAGCT6EP+pMnOr6q77rZwvdBnyXbeRJFG7h1sOEJ7nh1P1E+5vNcJ60zxMRod3JLunpV
 N+7TD+/2QQSJUgBXGWdlXFOXMp36gMmTpQI9JUFTQl3k3YB4QJipY3bTvnA0sWs1+xRq
 AcJRaj5xNe29IL1bga5v/+ErHCtRNfi2DMRMkS9gZxgLNU5yDUAU89evYxtCVW1tLxz6
 m7ry3tptyrhCb99BWE/gGjbaxnRirhf5J3W7A8PAeNB4LAVj1V7l0VK1q4LKLcjO+vGe
 dd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+u/S/yPWVhNnjSYbLsyDazqBcVzHwKzX3VKk0nDog3E=;
 b=PZ22CYLVTGFc8HcR+8Y/I/YmCHlOMVUicp2GkW5uWPKDWjkAQ969yVL0OmM93iMi8I
 znjbRsmuxKJiw8hedpp5QNQhy4BeMCTVUPito+LvyITtjcX5r+cC34nU2BBr5thpT85W
 ElZlRGFXsuswdNMDnG7jgrzf8j86tcLZHCTHQNQ4oL3bRQZzrNwGjhUfOGPw6t+4O/vz
 Jp0hdnWA8aCZZhIIBc5vtw2jnXGXjr2ZKo/5IjSl0qQZkx1mPyclgUclk5mFw2Fslbus
 MOjBaZOHuYhXxSql2p7iZmDAPZ/CI8Yxz/1K55E+TlLAjKzYH7tKp4oheuSv/3FTUNjN
 38Lg==
X-Gm-Message-State: AOAM53370XDZXt5DeyzsnLCqXmo0wQhwG04xDjDtXzFHfxJqknxdTzgc
 whiPobmM89l+5YbPDVPvV/f/Xok1cnh+sYiPlVQ=
X-Google-Smtp-Source: ABdhPJzNID7soY95yC5ymmcnkzbAC5YGKwW8kIv7ErFFLXlCwqFWaeA5yBbjuQuw0Jc0clSbopBfXZERrjVx3Au77Js=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr4153016oiw.253.1650906766661; Mon, 25
 Apr 2022 10:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220425022508.75434-1-evan.quan@amd.com>
In-Reply-To: <20220425022508.75434-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Apr 2022 13:12:35 -0400
Message-ID: <CADnq5_Nffq-Eb=6Dwsq4JKLt9hoy=WiTs4cm08YhP8Kobu+s-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the compile warning
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Apr 24, 2022 at 10:25 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Fix the compile warning below:
> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
> kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'
>
> Reported-by: kernel test robot <lkp@intel.com>
> CC: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: If4985252017023d6711b4d7eb1192a397baff813
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 8b23cc9f098a..cab948118d4b 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1623,6 +1623,7 @@ static int kv_update_samu_dpm(struct amdgpu_device *adev, bool gate)
>
>  static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
>  {
> +#if 0
>         u8 i;
>         struct amdgpu_clock_voltage_dependency_table *table =
>                 &adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
> @@ -1636,6 +1637,8 @@ static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
>                 i = table->count - 1;
>
>         return i;
> +#endif

Just drop the code at this point and return 0.

Alex


> +       return 0;
>  }
>
>  static void kv_update_acp_boot_level(struct amdgpu_device *adev)
> --
> 2.29.0
>
