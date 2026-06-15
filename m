Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6A8CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 17:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE8310E511;
	Mon, 15 Jun 2026 17:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9v93ZkL";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A2810E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 17:54:06 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so438709eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 10:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546046; cv=none;
 d=google.com; s=arc-20240605;
 b=N74gOHYsT9djSFr/K9N4z7M11VcjRvgIGfGY3f771eLdjetiFccuegob2QYqHd52if
 nVE5TteuUS8N7MpPSdWWvq+thR1yGtD4FJp7oamHEaIctScgSb591YA+HlHOqjEm9oA8
 1XAjyVFljvklqOZaCtEMlUrCC4kN7F3jRoE0WnWEHggdXBs2wTWh6oIlMOTiVUZW1xSF
 VX3XpLUukjaHekzWmZaZ9tbtwm58vDLA0f4l1G9WQqmlt7HIgc/tYIqszYllLxVqzCXn
 0TtbmK3nWRXXAp7+LGk1CRibH7zkp6nrMin83jvRUJ0dfd//KvhMGKBbhjYEjG+zu86t
 gvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 fh=8NZK/li2IV6I8S/rS1JLlv99vfsCN11tCzFwSSRu8c4=;
 b=iQLljBUWF7JqyVmQlbb8ICUBXm58Uxk7yrsTXwezQ3/7kPzp0ceMdC6Rxzu2g6bs3j
 O9quZlDD2W9eJa0ILnnJqkRyx9R7P6bal0I8y0VcJ/mp82PIiTX2IqaxF5BRsoCuXx3B
 7pINP7UDc9hpRXzK+dXr9q/Zng1hsNN6Tu7zAv/LJXLduu//rn52Jjb/RozEpvku8aEs
 TJ9iRjPDz7cpXePlZ5KI/gqsE9jxcR5F/p6Q95kz4i42iiqWUVs5GzZA+6SiVje3C26T
 nsVp7j9CscBbihxrurxcMWDw1+JUIY0ybxxTiK3+uLfGMu3D/zUdLnMtXyoZzRQDy64B
 zlvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546046; x=1782150846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 b=A9v93ZkL1JXCrZLCLp+kilr4+5swFWxF5esqbMSYTea+4n+eQ4TY9056FTUt4Aztgq
 jButYOx+1rbOEX1aAP9F6eMEwju6xf0eiotmgS9Qg7LteWoCgVyolNSHxfkGRHh/tVnB
 tSyAXssnGL9mXO5j1/8qcrzekvoAb2VK9y/F/HACHuY1GFoj/a5i01qWy/MAz379D8ij
 K5L4FXAaDwnKdu8tAT7w3lkfCsDHF1R17OpgQoEZRAvEEt8ktB+1GaFay0KdO+0033aG
 0XFw43mk/dHd/XsTXvP2Ai/5yJaAvB/8ahwyRkLGx0ItIFGjeRpXiZGj8eRCJHMWLBlI
 gZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546046; x=1782150846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Rqy3CrWBr5mXZd21QMPU6BJ30DbF1dOpUcQYTCdhx0=;
 b=aEYpJivDFDrH1Ue1hE9huIuXEyKAUAh7bft0C6WKjo1jhxZPRxmZBvciV7tqDrY/Ed
 Ll/7ukbnYNAiA1C7Rt339R8T/NeP9uNfF792LTLUOZVcFoMfVtDCcqEFHvITtejLBT5M
 /KOoQuXBCTapHJXilKlIdHIbYjja7mguzOEVmoPh8fikc2s5HcfZBK7QfitjVvYtk6+5
 M5cXujKumnfuRlY6ZIAq2GfyLYpzSd1ubNaL2cUPNND5FbtsOiM2KHmJf3oA+h7J1v1N
 /l6y9X4GJs+oLz9wwm/vZ92tG/tiAZcDL61AYHj6kjva5xeLTp+Bj+Qnk/Sv/OunFjCU
 KJZg==
X-Gm-Message-State: AOJu0YzUWbt6BDF2TbvyL1dTDZ41oPbWI7vdF+JC2Z9WWt0/pEeuN4t0
 tLzY2OeA4rqj7b50IJ4C/ULV5kDOVr1FaExWLmDBihIhhPca2bhf38gsPUnpl6oY7gVwiI+/SnA
 Kij0KK3GPzlmNhb2C0ZRmGNjW9+J+QRI=
X-Gm-Gg: Acq92OFhhIKY2UVkTApHkZPFh6oAeRfV5BJF8nL3eP42ACrGDkx+7RKH5xrfkieiJrd
 iELN6Xyvm/E0pVqg2hWeP1qiLoiQMoMZarY7rz7V7a2U3/bK2aIiyLOTenyxt5ykUUSd8tPDmyn
 YoHa5w520VT+RLqb0BnVRVAzjvsiOk9w5HyhOC7WKVewYd2ckP9KMm5/OiZZxJJlF+iqvQ8PIpg
 9IiovYa/ZyuDkAxKBkmc97xS2xSB/CckwxV5asNBNQuzuPnsWakoiBUpe+uP5EhNXeYJNTzTdvg
 Bx5XYpeGyAgA73bS+UdOXgxxZOMAbcA3lw5R5QLnaC9St1xWfMMvDNmRciBMngXGpxwZdvyHy1h
 kjerC
X-Received: by 2002:a05:7300:2d07:b0:304:cec4:dbdb with SMTP id
 5a478bee46e88-3082008977cmr3599528eec.4.1781546045858; Mon, 15 Jun 2026
 10:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
In-Reply-To: <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 13:53:52 -0400
X-Gm-Features: AVVi8CdqwiWNBPSphn3J7yyMq6FkhbfPshSymt8PKr3c0v0L9dqT3Suxzi8nKmw
Message-ID: <CADnq5_P0WSMb1ALbKO-mqRWa+Et3Qe+04um_r0B-cDdxiYo0nA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Use seq_putc() in three functions
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
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

Applied patches 2 and 3.  Thanks!

Alex

On Fri, Jun 5, 2026 at 8:09=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 12:44:01 +0200
>
> Single characters should occasionally be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 885e9b7bc27a..e45fa6e97fc6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -606,7 +606,7 @@ static int dp_lttpr_status_show(struct seq_file *m, v=
oid *unused)
>                 break;
>         }
>
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>         return 0;
>  }
>
> @@ -1081,7 +1081,7 @@ static int psr_capability_show(struct seq_file *m, =
void *data)
>                    str_yes_no(link->psr_settings.psr_feature_enabled));
>         if (link->psr_settings.psr_version)
>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_version=
);
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>
>         return 0;
>  }
> @@ -1266,7 +1266,7 @@ static int hdcp_sink_capability_show(struct seq_fil=
e *m, void *data)
>         if (!hdcp_cap && !hdcp2_cap)
>                 seq_printf(m, "%s ", "None");
>
> -       seq_puts(m, "\n");
> +       seq_putc(m, '\n');
>
>         return 0;
>  }
> --
> 2.54.0
>
