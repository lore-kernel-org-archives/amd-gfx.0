Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F61C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1326B6E462;
	Wed,  8 Dec 2021 03:23:44 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3DC6E462
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 03:23:42 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 v15-20020a9d604f000000b0056cdb373b82so1348939otj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Dec 2021 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BUPUcKIBXb9WLKJxuPBXJG+252B4H99gl6z9NYwHNis=;
 b=DWLRoRvm7HpSo5kJ1+H6nK7eDsJuGwIMv1uLcjjyf/x4oCnWNBpkrpfyG/6cIf+MNB
 sLc+3bx6N6q+j2ayLzRKPuZTc3gvGpPRgtDy5kVrMdfd40uXyuOX3BUjI6k3AjemN7Cb
 DgIkJGBerAfn6EF6klM0qmBjifXM5JcvVkkJq9QRYSZ5lWnQ8kX+Sjh47bDaoeh6eXvd
 9Gbs/+WH17lCM8edBXPJJP/JIaAs8vU+waMTuf3+JfwWnxTVw8Vx3w3YHjW9DmMkTeTo
 dpLV6HDgTPtC1YEC5FcA7SMEkufnqlUaPE9fl/L8tZkw5+fi3MkMXit/m+LhnlRYUGy5
 UO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BUPUcKIBXb9WLKJxuPBXJG+252B4H99gl6z9NYwHNis=;
 b=InWGc327BT9q9pRrq+N+ndCBTpkqXlcwqqWn3xx23NLFQzw9gc4N19bHIc8Q4NZmm3
 NO3VdnsIZixuL7msJ6JrgWoTB73Fz9uDDffizJ73xzU9kD/n1tWGQjborNfBDAPHf3QF
 1K96WOtHqtelDbMLF337+bs0hLqUqtj/aDPhSzldXbkUjFpxdtVLT3mtDRMEV/7lHxJj
 3lezWpnYkhRcEMJZMqfOB3NtS4RDRoWhTqA3SxcxLMCKcnxfdK5TDxiJMa73FpmPxGiw
 LA/eI91ixF85pGW2yrPidjGxNXRwwnxpu/dhUmkGVcoc7sXkDwN/Truj1vNz0neuZJNk
 0K6w==
X-Gm-Message-State: AOAM5320XjM/Va52tqhKGDPohI7lJ4sVvqimPa0jjx2RxJWRB1Cek9hR
 7UXtuDPPinkpFMZAn40fxFyDZxEWreihLj+zaKWWAEkU
X-Google-Smtp-Source: ABdhPJxYApy/zj60HodZeTLmwvq10i64E+l/Sb05KHZCWaaDNku2Lp9bQCp0KAfTt0gyvA0LEltPfaer0wyX4lv9WdY=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr40121363ota.200.1638933821600; 
 Tue, 07 Dec 2021 19:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20211208025450.1814289-1-evan.quan@amd.com>
 <20211208025450.1814289-2-evan.quan@amd.com>
In-Reply-To: <20211208025450.1814289-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Dec 2021 22:23:30 -0500
Message-ID: <CADnq5_PN9bk5fqEM62ocActJV7MWkLz4XuxZY6aiVS+x-bX4kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: drop those unrealistic thermal_type checks
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <lijo.lazar@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Dec 7, 2021 at 9:55 PM Evan Quan <evan.quan@amd.com> wrote:
>
> As it's impossible the thermal sensor of KV is one of them.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I52783cb50f037df06f76fbab997e0dc0fd445203
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index b37662c4a413..8b23cc9f098a 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -1260,18 +1260,8 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
>  static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
>  {
>         switch (sensor) {
> -       case THERMAL_TYPE_RV6XX:
> -       case THERMAL_TYPE_RV770:
> -       case THERMAL_TYPE_EVERGREEN:
> -       case THERMAL_TYPE_SUMO:
> -       case THERMAL_TYPE_NI:
> -       case THERMAL_TYPE_SI:
> -       case THERMAL_TYPE_CI:
>         case THERMAL_TYPE_KV:
>                 return true;
> -       case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
> -       case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
> -               return false; /* need special handling */
>         case THERMAL_TYPE_NONE:
>         case THERMAL_TYPE_EXTERNAL:
>         case THERMAL_TYPE_EXTERNAL_GPIO:
> --
> 2.29.0
>
