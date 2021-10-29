Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50851C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2DD60F56
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C2DD60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22916EA7F;
	Fri, 29 Oct 2021 20:19:21 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2B56EA7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:19:20 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id g125so14982046oif.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lGspjNIYU8OAKDDMNwCpygJm2SnDEb2M2shCj7ZzHVE=;
 b=KvTSun6mAYe5eEpvCBKBpf+n1VPeTsbGGZzeoMteIoz84xWSAImqitKJVrF0XhggNh
 ZM5A9veeHGBd+8HnkjNETVId1rxUEeYHJe0sT06VpixbhCmpUqlf1Nctrs8caoN8i2E4
 a+z11Aq+MdRkFkIQy66a097MDzUblsg+C7id+ih9wDR44efDiCuIhfQyXFpy7RNNPjP5
 Nw3FVcGvzxm8H2jOD7aGq17uzwB9Qa6FrkTli44Qy7kJaJDuqL+1YSjr5ukV1g7cSJvU
 x6xhMrQ2aVn7h/5rWLNeNJ1TlFe+xSM5lSohyn6sD9ImhFbo/DBvtLbyZKnx2hAl4m16
 PgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lGspjNIYU8OAKDDMNwCpygJm2SnDEb2M2shCj7ZzHVE=;
 b=s6EDJm4xK8+MwUjItiTh0dYlaBclNy4PxY3NLluXvidEHfQWDfnTF7kDDmjHr3Bmbp
 /SnhhUp6omg8fdRZKHnnETfMMFiweGPjw0Lo3T3uzUzbYNlUbyHmz8NjhwdbVJUx56ST
 6umbdEwkzVxnZdqFHbZCyFxYxVZTyOb7rZAintxcd9J0FCsyxExS5ujF4ibtNYFK0qYH
 bQMSlIpKaVSp9g0zfMS1a5jfrV9o43SsvbuDfLw+fVt9OWLWqubuoZVbM5ooO6s4EqpI
 C+bm0fOpAFNIrtuQ+8/9jmwW8UyJ37NXJiB9i7G1jkwKLPu6qRFzRbpVM/o3ayMpwH5n
 DOBQ==
X-Gm-Message-State: AOAM533Nu7CNLJXD+aqBaPKajLfUbnmUSTPerrClj+grJY+qwSp1n9jE
 L5hJmw/etGPSURbZshqg0yBMv+VQ9MFNzvBFUQI=
X-Google-Smtp-Source: ABdhPJzLGYdNuAsIYQlI2S984ZkxB/vKwMoQpWLzTVJ42bCSEj/pYmKn8RBmvJTJhtKUSr9jujio4LM5nM2ij1CstUA=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr15118381oia.5.1635538759640; 
 Fri, 29 Oct 2021 13:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211029201156.17595-1-mario.limonciello@amd.com>
In-Reply-To: <20211029201156.17595-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Oct 2021 16:19:08 -0400
Message-ID: <CADnq5_PJ1W0Hd72yiLrZAq2t4WkdvkhNJfwohd22naJ7h=Tbkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Roman Li <Roman.Li@amd.com>
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

On Fri, Oct 29, 2021 at 4:12 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21
> asics") switched over to using dmub on Renoir to fix Gitlab 1735, but this
> implied a new dependency on newer firmware which might not be met on older
> kernel versions.
>
> Since sw_init runs before hw_init, there is an opportunity to determine
> whether or not the firmware version is new to adjust the behavior.
>
> Cc: Roman.Li@amd.com
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1772
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
> Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all dcn21 asics")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6dd6262f2769..85b3de97f870 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1410,7 +1410,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 1, 0):
>                         init_data.flags.gpu_vm_support = true;
> -                       init_data.flags.disable_dmcu = true;
> +                       init_data.flags.disable_dmcu = adev->dm.dmcub_fw_version > 0x01000000;
>                         break;
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
> --
> 2.25.1
>
