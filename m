Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254D3C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EB210E139;
	Thu, 10 Apr 2025 17:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jrcH7O1h";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CE410E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 17:34:24 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so289126a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744306464; x=1744911264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhK9HterwBcSEVdYSFfTYHbOq36DgcH7apy33HJp/SE=;
 b=jrcH7O1hqii1ymTityPV0JTg7lRMYMxNckRfXFHVxC9DuQvK531/MbcTSWQstXIUCH
 sPzwI7z7vHnDXgx+o7qnfG6BmKnLULxp/fXX4Nj49Elc9dD5iRa0pNMfGVqxU7OYzOGE
 IfmtV67YRLoiyuvulJR/ksyE9vhg+WvB/I/40aEMiDoekx/xUlTK0wTtY3eZyUeDQGEI
 FKC/uyE1nz/Z6BTWHvTvQ0Psz1Ub7lsEtzJhCKqcTFEjRmIknxzCkd9S2xEGL6Sg9OGh
 AUFTn+BkicW3vJtjBPXL2YB8jdLrWVRuLKwOK1YnH0BQdehgiYorJ1EbnMq0vGm4t/ld
 3Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306464; x=1744911264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhK9HterwBcSEVdYSFfTYHbOq36DgcH7apy33HJp/SE=;
 b=UwM6RwqBAiscXWA9cFy+29nG/1otbHETZ/G+WwSx1Dg5Ad7LeDBG3lTQMQ6MWDYtP0
 7/2P3ieOOT2sX4jkhpKmnMGFC8ZrWd1Za9GxWKPjlAhYi5OyUBJsWYxcx79zE9aZ57kF
 hxyHaUMCd+/4yDqne6tKclph0Ix4aH0BhPrekymfXWeT09GM/8gi0bIINSHNZBf+ZBNm
 E0ph/JCtbwH99pwWp5esNLIvnTfxab8XeKMJ+nVrz6BOZUYEKCr7O5qMVzA1S24S4KEl
 k4qwgQqHfJ6Us+9rVGwU5XpFjN9VSkfPzhp1221sizxJPnjAYjbEqE153WozeinwK+rw
 akPA==
X-Gm-Message-State: AOJu0YxgXJqeZ7ggp9yy7NPKUuQqSLD9bQfyhf7G53FHvJ18t+dBCAjO
 FBnu0Lr0pch4WZjjzOvWs7RJx0dUg5vHgZxzfAZ+h5FnUKuaLjd53LZDbhU7nwgCTqWac23IOJQ
 7uTJ4ujiDb7SmkRRzf+xxp03exzE=
X-Gm-Gg: ASbGncvIINH4yCrNVUXizcixMU+bDVhBh9vvSPezQPlRhlj2BEMp2YBPRiK/iWZAiKE
 xsbtZGO+vqbRHqA0OTKc2JEGPmYOYTqMzFREOuholoqKnRWdFrMu5Zgl/MOheuq4Y+EDUkLCRcC
 hAo9F/OViJNzgknMpB6InSwA==
X-Google-Smtp-Source: AGHT+IFCgJDqEUdqxAPdw1EHNgUIZaXtsoxiLkTpE9gbvWGcB4TOSohA3+iVXEm8WVnqe+jtu4g8cMg0+T5Vm33pcoA=
X-Received: by 2002:a17:90b:4a46:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-306dbc3a205mr3643150a91.8.1744306463674; Thu, 10 Apr 2025
 10:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250410172411.10075-1-mario.limonciello@amd.com>
In-Reply-To: <20250410172411.10075-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 13:34:11 -0400
X-Gm-Features: ATxdqUHDE0gKQ_9JNdMIXvEJwiQv9G_xsI7Z-4uJG955ZoGWvdZwe29So7FjzLY
Message-ID: <CADnq5_P7dPpNOcwv8=pYzYUpzRuexZ659+_99+45BnYd4FG9bQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/amdgpu: Add Ryzen AI 350 series processors
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 10, 2025 at 1:33=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> These have been announced so add them to the table.
>
> Link: https://www.amd.com/en/products/processors/laptop/ryzen/ai-300-seri=
es/amd-ryzen-ai-7-350.html
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index 5dd4b8762d19..094e76a65dc0 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -13,3 +13,4 @@ Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2=
.7, 13.0.8
>  Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4=
 / 13.0.11
>  Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.=
0.4 / 13.0.11
>  Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
> +Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4
> --
> 2.49.0
>
