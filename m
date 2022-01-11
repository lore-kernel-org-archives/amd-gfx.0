Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A98C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 02:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409AA10E416;
	Tue, 11 Jan 2022 02:06:16 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB3810E4B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 02:06:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 w19-20020a056830061300b0058f1dd48932so17083295oti.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 18:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BJ3s2lmERXBZ28o0K23n75yN8eHQLM0VQB3UppvQjkQ=;
 b=Rv+Mz//GETraKYL44/RNAsQ7a7SJ99LqjUM0L4an1tZ61X01u+3afx6fqOizZr+nWb
 Vb5ANFHWhamw9Qnu5OZYXml43dUYbOZ/l7xk+NNMvgGoNkMF+oETVCxlLUPiMev63D3U
 EPqkwJpxh5srX7wgO21QL2qM6b9Ox2njhGTRNnfmx5TBydvQ/k/Jo0cguLUrcXTjEJ/2
 Zzn6I7baDTigjlwvpRtzvz2VyjNOrgOOTty7W+QZQj/gjWHWzfCtKcHT9GLXRcQjixtS
 B1YrRlRooqVmqqcLa0aAyhOL/nRq/ZBTF/ydMrUUcbJxCidCkyU465GNBibW8W0CG+st
 2njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BJ3s2lmERXBZ28o0K23n75yN8eHQLM0VQB3UppvQjkQ=;
 b=YSvJINwPJDSD1c9t+l7JHYqlWjs5LKw93lzqPgV0L/NEaz7Zheum+Quop7rlS94xMy
 g+4NgTtBXY1C32cy4WJDwQ5iD3qjUUf+ppmfuus5hhIyH3WEq+hm/IP7E5f+ecp5U9te
 lhFu4WFPz+DjyKQY2n+snCvxQtietuoSsge5jilWvWy7txzfw0v6eUrpulezEvOZO7u1
 sFU5MX5ZGDVQKtK6QSL3lqTUivuQbG0IztMCU+4JJYVVotN0Locja1PRrPHDMjn9776Z
 MQyDQSSc+sY7MaLNq7oY+guchGr4+5/vyovujwYkn1ZeXobg/qUKyX72Z+WcA6F4xaSE
 7x0g==
X-Gm-Message-State: AOAM531SV+IQnxIWRIOXdFV2ZoWBnPYjMTx6I0LioyrjJ5/e7PeAtYCZ
 zed+c2G58z9jZrWgPwqscYbwhr/9T6gVLqgHi88=
X-Google-Smtp-Source: ABdhPJwfuyJGx8PKAf+QlejldL6YlxihWR5T0sZYdAFrqmG0do1eBJTrIeIA6QmZX1dOA2BKuQPxkz+mILh3dHRZZNg=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr1955318otk.200.1641866773920; 
 Mon, 10 Jan 2022 18:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
 <20220110233906.1178021-5-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220110233906.1178021-5-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Jan 2022 21:06:02 -0500
Message-ID: <CADnq5_O1_KP+wheYBrSk6b5TzNEPHLh=qE40ZfgKyY2Lmap_Og@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Silent GCC warning
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Leo Li <sunpeng.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 nicholas choi <nicholas.choi@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I just sent these same three fixes earlier today:
https://patchwork.freedesktop.org/series/98695/

Alex

On Mon, Jan 10, 2022 at 6:39 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> We have the following GCC warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h:400:10:
> error: =E2=80=98struct amdgpu_iv_entry=E2=80=99 declared inside parameter=
 list will not
> be visible outside of this definition or declaration [-Werror]
>   400 |   struct amdgpu_iv_entry *entry);
>
> Silent this warning
>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h
> index f604a2235a9c..62f1f97ef7f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -395,6 +395,7 @@ struct ras_err_handler_data {
>         int space_left;
>  };
>
> +struct amdgpu_iv_entry;
>  typedef int (*ras_ih_cb)(struct amdgpu_device *adev,
>                 void *err_data,
>                 struct amdgpu_iv_entry *entry);
> --
> 2.25.1
>
