Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BD8C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 16:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB46E10E4C1;
	Wed, 24 May 2023 16:10:21 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5D110E4BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 16:10:20 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so9996315e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684944617; x=1687536617;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sonO3GOYzGccW/51txZZdB4M9CGgorlp/b5UFoGyaco=;
 b=huJrIL8GrNYmxaL+91OktyHSNGC4Uj9H6LgChlHFde8wRuazQA2qKQx6gCLm5EeUL2
 ChyzSS3yZGt2x8Op/sPCRDNJ0ZBVe22BFbk5n7wqOh3LXQN3gNw2KahY5+Y4d7fAPypg
 guLngSIAs+OA9FpyZelrGBAx01iPnej6Pxh7AaBFHLpBkcLKz4zj5MECgG68A+pkFuSl
 W2tTk2kgJLFACbkK6DcSAREyG9sqVzJko7HCcFQROj/IKjqcPi5ksUUb75URizrZUeDH
 1pJkY+oznh25umOaeF2AuwhXQ6sJXhvqLrjKjkeTnLqslRGHojbcxLvb+wlSlazue9a9
 NfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684944617; x=1687536617;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sonO3GOYzGccW/51txZZdB4M9CGgorlp/b5UFoGyaco=;
 b=Q5QcRzyuPsm3WC3bEpkcDXCb1e0IA0/zB70js//i7Clm7162MfBLhik/7Cc+E7YAJo
 Zptt6W7wbZgbZ34yuvQGauHAcwmQBlovHzZNpIYlNoP9jojqdDifxqkFkEaSrG1taa2s
 3sJnRTCDAkBQFWl+0NP4oSmtScKG5Q61cQEz2Jkc37VZIBMAtn0AcYjkapiw40SytkJl
 k8uGUGRgcJSA8GZITYpW58XZVx7L67Wje3EoJwiNG3qI6R9wJcty/rlJxt09E1XNxqVK
 BQ1r9AmxTJujCVhcpr+kA2Yhs2hmh0f5HnDv762LzoJN7vEacDBZ3zUw4H6yRbcxOhDZ
 JLqw==
X-Gm-Message-State: AC+VfDwcE4keWhB7/2C1ZGRULhrg/rkg2n6FOqHVpGb3qu4Hk/IeiAgC
 n3FgYmSavf/xRywwwWqEYD/s0g==
X-Google-Smtp-Source: ACHHUZ6TpR8oaLW3NZ/tDgs34qpc3OAVHAqUENH6gjAtwJ10LJtGbVpmkQsfflTucQ7R54D29ZedZQ==
X-Received: by 2002:a7b:ce87:0:b0:3f4:2327:53c2 with SMTP id
 q7-20020a7bce87000000b003f4232753c2mr248128wmj.19.1684944616955; 
 Wed, 24 May 2023 09:10:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f4f89bc48dsm2865399wml.15.2023.05.24.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 09:10:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
In-Reply-To: <20230515143023.801167-1-robdclark@gmail.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
Subject: Re: (subset) [PATCH v4 0/9] drm: fdinfo memory stats
Message-Id: <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
Date: Wed, 24 May 2023 18:10:15 +0200
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
Cc: linux-doc@vger.kernel.org, Akhil P Oommen <quic_akhilpo@quicinc.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-kernel@vger.kernel.org,
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rob Clark <robdclark@chromium.org>, Guchun Chen <guchun.chen@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org,
 Chia-I Wu <olvaffe@gmail.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 linux-arm-msm@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Jim Cromie <jim.cromie@gmail.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Peter Maucher <bellosilicio@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Christopher Healy <healych@amazon.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On Mon, 15 May 2023 07:30:07 -0700, Rob Clark wrote:
> Similar motivation to other similar recent attempt[1].  But with an
> attempt to have some shared code for this.  As well as documentation.
> 
> It is probably a bit UMA-centric, I guess devices with VRAM might want
> some placement stats as well.  But this seems like a reasonable start.
> 
> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/9] drm/docs: Fix usage stats typos
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0020582a8afe9a8570f80ec503c59bf049a616de
[2/9] drm: Add common fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3f09a0cd4ea3b9d34495450d686227d48e7ec648
[3/9] drm/msm: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51d86ee5e07ccef85af04ee9850b0baa107999b6
[4/9] drm/amdgpu: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=376c25f8ca47084c4f0aff0f14684780756ccef4
[5/9] drm: Add fdinfo memory stats
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=686b21b5f6ca2f8a716f9a4ade07246dbfb2713e
[6/9] drm/msm: Add memory stats to fdinfo
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e9757f5ddb98238226ad68a1609aa313de35adb
[7/9] drm/doc: Relax fdinfo string constraints
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=90d63a150b85fd1debb9c01237fb78faee02746a

-- 
Neil

