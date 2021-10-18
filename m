Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 14:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CD360F93
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 14:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18CD360F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2656EA4C;
	Mon, 18 Oct 2021 14:31:41 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205586EA4C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 14:31:41 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id o204so22746oih.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8tLzE3KKViQV7owu6ILuIqq08bA5HRFxScieEmzJ0c4=;
 b=hZOzHNLzy0bf1bZl38GGGk0ATB0N4O0bMtn53b0LpXISJ5UHw+AWh+t29GDA0Pp5eW
 N7cCov6lCK6tTh4Sinl6DD4uKtCkPBz0fpQRJP0kNZDmlynH1UavzVR3rNOWb5+IHmHm
 9dO1YluUcoXCklk5xGJ8ydisUH5YV9Ks3EKiII6hAfLw0sH04xG/Mx1Ri5MoRDIWUAYG
 tXKEUzGXBZTFxG7l5sO7fdrjGs5ufOruMGbasar/NmHZ1ZSoCdezUOsPQYJ0Wx3p+I65
 sNkcdFrsJlxv4cInybAiqqb7YUIXlX9SUg2KGW+SEcXtrONEgxssjSC/oK76mCKBRN4c
 ErtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tLzE3KKViQV7owu6ILuIqq08bA5HRFxScieEmzJ0c4=;
 b=A3xNRi2D8YuT2onVOfd5tLN1Yn5NiiklLLum5VdUYlIS/zDzD4dHeoRRZHkHhmD9M6
 KVmLJTJf89z6dMGjZsPqw7X3Ds7jPTgA1sp5HKbc1/H2qdyHzq/wJsQ2TCoPqW/+fRZ7
 MA31YRZ9JwmTvhdwI1prTjwcWWR5Wa7UlC0i283ztsFUvECGduIBy4cKX2bJWuLW0AgT
 LIgb7nA7ezOsh53Oq4jF2X57Q2W4ORhGHtyHx2rq/Fk4juwMxQJzZ+kDk6R2CVIjRQJu
 gGANKvwv+ClhiObUwDyAuDv18J8rS/di1Ah/UlnbT8dKMFg/nuM0JHmqRjtZohIKj+5/
 BdBQ==
X-Gm-Message-State: AOAM5318LQSguUO6TEE779Rah4wzT9FXNQD0AJ22v2I1Dc1sjmgXQLxy
 Vgh1KLwP1K4CbvJfNm2OrIStDCURC9vSy7EebIs=
X-Google-Smtp-Source: ABdhPJxb7EYbxvc+gx22lLqCLOIyZH8EEeYqx5vT6WD2Otnf4TRYYv4pVcyt9Y8tVlNtzykFTwa63AjiPHji7Y9mr/w=
X-Received: by 2002:a05:6808:1527:: with SMTP id
 u39mr67272oiw.123.1634567500407; 
 Mon, 18 Oct 2021 07:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018143014.9474-1-guchun.chen@amd.com>
In-Reply-To: <20211018143014.9474-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Oct 2021 10:31:29 -0400
Message-ID: <CADnq5_MZoBRdJ=20Fo72mqjZEDrUVUEBJpay5VaE-XEgeTt2tw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: parse hw_id_name for SDMA instance
 2 and 3
To: Guchun Chen <guchun.chen@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <xinhui.pan@amd.com>
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

On Mon, Oct 18, 2021 at 10:30 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Otherwise, hw_id_name string is NULL for SDMA 2 and 3 when dumping
> ip version from VBIOS.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 9645b95b9c42..dfb92f229748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -108,6 +108,8 @@ static const char *hw_id_names[HW_ID_MAX] = {
>         [HDP_HWID]              = "HDP",
>         [SDMA0_HWID]            = "SDMA0",
>         [SDMA1_HWID]            = "SDMA1",
> +       [SDMA2_HWID]            = "SDMA2",
> +       [SDMA3_HWID]            = "SDMA3",
>         [ISP_HWID]              = "ISP",
>         [DBGU_IO_HWID]          = "DBGU_IO",
>         [DF_HWID]               = "DF",
> --
> 2.17.1
>
