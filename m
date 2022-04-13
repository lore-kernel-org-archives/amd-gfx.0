Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 13:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C843910EF3C;
	Wed, 13 Apr 2022 13:21:17 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888BD10EF3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 13:21:16 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id w127so2000376oig.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MiwArKs+HODvOW7hM2be4w3cVtGs4Ap3cpd9sDWaEBo=;
 b=I1/uKlf9WJ7nZ87PdTAvrHHWfExIf39SepPXC/alesORp28mvIWVTZFW9FQH9brjrV
 dMWRTAEOGl2uMKGoWaysuhRKMetMohEDna0q3VupseufqvLJCVW0x66Fw/93Ec0DNGR5
 Vykaonof8gJDCVPtTaJ0lghg/eMf2nPTVqxy7aQomeOk/1Uzi8swgmQynO54YhXjY7+K
 8WMLLT81o5Go4jWxM+p2Prl7VXEjxlGzId0wpFs5eQPlgOWb0ET3ppJDXJ68bjsWcw2c
 hpnSHxUEwSZGRo2kG5rjmQoKOLXRQI45yKZuAk+HqENJXjJ+pL059wjAfQeTtbp2kv/1
 JDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MiwArKs+HODvOW7hM2be4w3cVtGs4Ap3cpd9sDWaEBo=;
 b=QlWeVS2ZK+GhL+R0qfbFduhvWY8NgUskMvkHurnzmSX+HdpMGYCyzjD6PZZHr6eY2Z
 Xs4tVgW3i2rRZlWdf7N6ziZHf93sN/CVPptIKm8OjVDvQm0XMDWEeMPS6DlqU4gfCFEh
 Ms5ygdCVvSRxsktvLZpHn9OV46ydHjnOcn3KQBHqtNsNI9Yeq+4zjX0Qyk19V+lyVdch
 d8u+ydUBobEg1rlHMhQU4Mzf3Va6G1VAPfEh92Zb+ayHi4EzfOoOjOeYI1L7vnilDppM
 wNrwlbpLPTs4HAc0ZEZa1K4jD9HgQqAh/4u+eQCR1MCHYsgv6du7mWYcaeBxKdlOf9KE
 FXwA==
X-Gm-Message-State: AOAM531yRMMgMos4fh25naXMDueElsapCK979zEHbhbupSKTOkAVuaOr
 Fi7xq2rm8rOuOFQaaR0Rqcc93NVoQySd1p5nHeXqs0HS
X-Google-Smtp-Source: ABdhPJyDZLD0pzsCtv3XMrQSII/S2gkrjSTq6GI2OvgO3ykBvvAgbpk3fKNQNT63HqJqgLneLVRUCQ2OdS5CjGSwyt4=
X-Received: by 2002:a05:6808:199e:b0:2f9:d699:6ad0 with SMTP id
 bj30-20020a056808199e00b002f9d6996ad0mr3831081oib.200.1649856075792; Wed, 13
 Apr 2022 06:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220412210317.638308-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220412210317.638308-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Apr 2022 09:21:03 -0400
Message-ID: <CADnq5_NPOWXKF4givYKBGVGEv-RiCcjABBu0B4WYLW-EK-cLzw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Pass HostVM enable flag into
 DCN3.1 DML"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Mark Broadworth <Mark.Broadworth@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Michael Strauss <michael.strauss@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 12, 2022 at 5:03 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> This reverts commit 367b3e934f578f6c0d5d8ca5987dc6ac4cd6831d.
>
> While we were testing DCN3.1 with a hub, we noticed that only one of 2
> connected displays lights up when using some specific display
> resolution. In summary, this was the setup:
>
> 1. Displays:
>  * Sharp LQ156M1JW26 (eDP): 1080@240
>  * BENQ SW320 (DP): 4k@60
>  * BENQ EX3203R (DP): 4k@60
> 2. Hub: Club3D CSV-7300
> 3. ASIC: DCN3.1
>
> After bisecting this issue, we figured out the commit mentioned above
> introduced this issue. We are investigating why this patch introduced
> this regression, but we need to revert it for now.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mark Broadworth <Mark.Broadworth@amd.com>
> Cc: Michael Strauss <michael.strauss@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 6cc580be7c79..5b3f0c2dfb55 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1668,7 +1668,6 @@ int dcn31_populate_dml_pipes_from_context(
>                 pipes[pipe_cnt].pipe.src.immediate_flip = true;
>
>                 pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
> -               pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
>                 pipes[pipe_cnt].pipe.src.gpuvm = true;
>                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> --
> 2.25.1
>
