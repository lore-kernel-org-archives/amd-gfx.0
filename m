Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90609C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 07:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238AA10E093;
	Fri, 26 May 2023 07:18:57 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F6D10E093
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 07:18:55 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f50020e0f8so10102445e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685085533; x=1687677533;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x8EaOVciQbaWaP7P7FJjb990SGfOsPyezBQlBQ+Diw=;
 b=gbIOZDLWvLSxweRWLTzaY8XBjZ5q08yrxVQxiv39jl2zy6TQZa2lgdlICWZEWDSIHZ
 fpabCR6kGa+foz/21JE4Cojs3fkY4BI/iG3y4epRfXiX7j5xEyFsRzYYW9HBUNNPkbj+
 6feD5bHx9YvCa+CqFh8q91RZ4uFIpTPKgNdXi8ohDHul0t+99soOoJx6yo8Vxtyxr/c1
 h1/sjhkffuOOrS8lxEUxW0OSChsIPxBPuICJeRAPI3rSRDYKcY70uh+IJnUZyX4XOy2x
 WL7yZyBfYkb5uM8OjhkM+htw9dkUB/8CaB7nGsQ7vkgmYUhl/yoiZha5An+LjS9Wd0Bx
 Wuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685085533; x=1687677533;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7x8EaOVciQbaWaP7P7FJjb990SGfOsPyezBQlBQ+Diw=;
 b=YzWP7DIuyqs+mQuL7KWuSGaZK18i5APZfWVwUfrgOdt+WQY+zZpd9R52nx6yNR7xIV
 JFYxJqBefCSQa/lqz9jPqhkA/cpdZBFsIHJ94MukQoX1FypLFo3Y6lJZIva/Qvhwf+8Z
 sDWzHIVGc//97I3bnDsw+r2zSMOres4kVtNJDkTvC1YvRlGEIgaLeDkvoHsH5hvgaDtP
 UfPxBmwVPYSrAKw6+XooxQ6wcDNbUdy0q0Wi2ye2F8eKPptlnElQEP9vtj2c2LA5R0Mg
 QgNacALFbBuuWHClWd7jGMBLGhvnVvp8XiPuI0RKTOCfM2mvLRd8AMk+JnmnjeZh7kH5
 jcBQ==
X-Gm-Message-State: AC+VfDzaM7fxN6tkJDK2gS9o69ykYzHaLOb1q/yzxaM2TgQJSokxlOZa
 vc0UscXB//Z4qZ70dS9M8701pOxWAjSg1GlJz/3lhg==
X-Google-Smtp-Source: ACHHUZ6R6U6shWgeZfTSnEZIBLJRJhvCBwuNhpQtzNz+PMH2uTCIIEyZulY1YDZ4YG/YtXlVkmmLqQ==
X-Received: by 2002:a5d:4402:0:b0:30a:bd8b:b102 with SMTP id
 z2-20020a5d4402000000b0030abd8bb102mr591334wrq.19.1685085533126; 
 Fri, 26 May 2023 00:18:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a5d6849000000b003078c535277sm4085490wrw.91.2023.05.26.00.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 00:18:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
In-Reply-To: <20230525155227.560094-1-robdclark@gmail.com>
References: <20230525155227.560094-1-robdclark@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix no-procfs build
Message-Id: <168508553213.1425379.11727335048829128937.b4-ty@linaro.org>
Date: Fri, 26 May 2023 09:18:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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
Cc: Rob Clark <robdclark@chromium.org>, Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 kernel test robot <lkp@intel.com>, Guchun Chen <guchun.chen@amd.com>,
 Jim Cromie <jim.cromie@gmail.com>,
 =?utf-8?q?Marek_Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Thu, 25 May 2023 08:52:24 -0700, Rob Clark wrote:
> Fixes undefined symbol when PROC_FS is not enabled.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/amdgpu: Fix no-procfs build
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1a56fcf08ae463a4564d111356091b2bdb6c7bce
[2/2] drm/amdgpu: Remove duplicate fdinfo fields
      (no commit info)

-- 
Neil

