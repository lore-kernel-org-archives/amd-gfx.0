Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1ACC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCBD10E65D;
	Thu,  3 Nov 2022 16:42:43 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679410E644
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 16:33:53 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id s24so2878164ljs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JFodtUZbJH+CLxwcNiMfnmGzO2WRURRyq8C5cTpBhX4=;
 b=BmFw5vY6ylGvL4REB26pAS6OI0/iWDVTUeP3x78gKpQAQXk8izI8Ib6sWUaBWOCF7P
 Wdlay+H68kZFJNEAilpluk1riHzq3Mojpm6cXl+Ilx8flo530noyORxOYPVg1tHvdcXM
 nN3+7IjFTSEZ0F4RLESbyFla1kgur0Wue/2yohpO6yOoPGPrfvgzZul+TgNY5/fx3l/F
 49p8CklZ1+TbV5sBH+hYlJCRYPVYXpz61BiMIS0JGlD1gPUi4tsnn5L3ecQTOQL/OFOM
 bxYN3WrUEkRpNaos2gBMWXWVWypZIzaQcbiQEdc7WjdEc2AYvlLxu69OitfAkzzuFxZm
 GQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFodtUZbJH+CLxwcNiMfnmGzO2WRURRyq8C5cTpBhX4=;
 b=iuWmGdfVRhXNPOlmZGHtEF6MX2B2Eq41c8P8sVRExSJAPM/5qk8brNgcrI2m2g0S+5
 ZjB5FR0LUlu0qHBHTEngO25ojw/BTn3mZLZ8swYP3+JwH81Xocec/+J8ZwnQ7twgZmF0
 99OUejtz1wTMA+Blm6QY3bteDcfcJbOxPGqC4Sby4yM8VDkljroeMADFd5Q4owzSTuth
 ElyzemOXL/3YiBvkXVemo+SHVnNPR5Qx180+Qr8fF6WqOcVcUy2d8AVKvHW+XpUl9tKv
 0IwnCKrx1atvasELLwPG5IBjrLcbjuBR4zDkctX76jAwLvqNQx7RRqxd54oAcBh8Y38w
 Sr0w==
X-Gm-Message-State: ACrzQf2Jxxl/VUQgCPLbSqUGldJ5/o8qTv9uJQz1WI7NpLKXF4FSBpjY
 AUZ17DsK0JvLwzX3GSg0uOgtdrMBhDirN6YF36/Mri5x
X-Google-Smtp-Source: AMsMyM5q9wdBk8WlRgaf00spn4yIrdH502cdlLRMhC7+fdkikWN/28JwLb4uOSS0Dq9MH6Sqibt8XJABP5gN/ZljiU0=
X-Received: by 2002:a2e:b88a:0:b0:277:7364:cbcf with SMTP id
 r10-20020a2eb88a000000b002777364cbcfmr4298229ljp.50.1667493231189; Thu, 03
 Nov 2022 09:33:51 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Springer <stefanspr94@gmail.com>
Date: Thu, 3 Nov 2022 17:33:40 +0100
Message-ID: <CAE4WtP8HFJbv88MUsBv2wHv0WuoJoRicVHWP1feUXeJ526Zrwg@mail.gmail.com>
Subject: drm/amdgpu: workaround for TLB seq race
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000b5e52605ec938519"
X-Mailman-Approved-At: Thu, 03 Nov 2022 16:42:39 +0000
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

--000000000000b5e52605ec938519
Content-Type: text/plain; charset="UTF-8"

Tested-by: Stefan Springer <stefanspr94@gmail.com>

--000000000000b5e52605ec938519
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Tested-by: Stefan Springer &lt;<a href="mailto:stefanspr94@gmail.com" target="_blank">stefanspr94@gmail.com</a>&gt;<br></div>

--000000000000b5e52605ec938519--
