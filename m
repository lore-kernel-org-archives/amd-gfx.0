Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083CFC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 07:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF16B40E8;
	Fri,  5 Aug 2022 07:24:08 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1260FA17C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 17:17:40 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id dc19so418701ejb.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=W3oQTjR935kyPwW8JTzNphawSp0RrVbBZvc3FA95SqM=;
 b=CXWDpj8EE+E/y1A4LLIdWpEV4dz6BU5+YOyxOh/YLtPkJwFlBJB1T2YAT5I0CWpJbm
 VVDqDcqzQQ8s3ioCrfGbckfIaXDN/DMIQcyKDaq2cGGklhoikD/bu8Yh47Rv2wLjHhXb
 ti4AKQ9roXLqZxh+MOQdxpogEjPOBzv2zGxt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=W3oQTjR935kyPwW8JTzNphawSp0RrVbBZvc3FA95SqM=;
 b=6rMGLScp8ikgh51lcD/GP7zaPZ/Yqh/2O8smkVA36eRw0iv0IiK6thIaljvOWb2Ehn
 PpiFqL1jHOuOz1yfLfjKSCdE9GC68m6z3h1Om15bRNS6cNBWysCt01ek0h61Z8RKz5uI
 39Afd6HQHK/JWyufPsmwUVEvcLwzwI3kGFGjyISTUMVj7ptmOqOVgwxmQiWMy/8R4THz
 23uv3lLAoL5FPq3LAEF11l7gvmWytKOpRv7uQlywkoU/5ceIBy4nlu7Y2P76/OB3k0Jp
 kI8tl+UVYL8oRl4WP3nQ1eZ6nn0jf+NTXglpcSs3B0j/WNeFH04cQ+UumfSmrF0bcojV
 Fj5A==
X-Gm-Message-State: ACgBeo3eM8xWgMesX1DP9C+nYiVLFt8yyQZwxrhEG+9pZ9O9SKsbV6mP
 dOsZ3cePY+JD91wqdHM1IUXhZhukGUno9Wi8
X-Google-Smtp-Source: AA6agR639nsLMJ+SwIonjLJd0T+WRkREae1Q6r56Ystnwf5P8uYxopG30ZcghcUc1gIeGd4MhkGJqQ==
X-Received: by 2002:a17:907:2e0d:b0:72b:5cf4:464a with SMTP id
 ig13-20020a1709072e0d00b0072b5cf4464amr2152957ejc.87.1659633459030; 
 Thu, 04 Aug 2022 10:17:39 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53]) by smtp.gmail.com with ESMTPSA id
 b12-20020a1709065e4c00b00730b61d8a5esm553642eju.61.2022.08.04.10.17.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Aug 2022 10:17:38 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bv3so507375wrb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 10:17:38 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr2010623wrw.281.1659633457704; Thu, 04
 Aug 2022 10:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <Yut2otE1h2xtC79o@debian>
In-Reply-To: <Yut2otE1h2xtC79o@debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Aug 2022 10:17:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
Message-ID: <CAHk-=wjPF0dXvDeqPiSzpev4KhhWU0-R8muaYVF73vy2Vw=QTw@mail.gmail.com>
Subject: Re: mainline build failure due to 6fdd2077ec03 ("drm/amd/amdgpu: add
 memory training support for PSP_V13")
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 05 Aug 2022 07:24:03 +0000
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
Cc: Chengming Gui <Jack.Gui@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 4, 2022 at 12:35 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> I will be happy to test any patch or provide any extra log if needed.

It sounds like that file just needs to get a

    #include <linux/vmalloc.h>

there, and for some reason architectures other than alpha and mips end
up getting it accidentally through other headers.

Mind testing just adding that header file, and perhaps even sending a
patch if (when) that works for you?

                    Linus
