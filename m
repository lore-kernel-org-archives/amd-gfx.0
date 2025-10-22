Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A6BCCF9E5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AEA10E8C3;
	Thu, 23 Oct 2025 07:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gwMJj0JD";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B2C10E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:03:52 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47109187c32so31491545e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131031; x=1761735831; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDqHxW/jBsy/A2MvdqRNGQd8E6A3Mtbvpi3eUVoeJtk=;
 b=gwMJj0JDhBrjFZs5sMY+HroSj/4KgzkFJKxQMUZUvZq3ooLpRyN7pqn/Bcy0nm6rKR
 eqA0fciaIp2D9daYBbEid5oMFY/cykMDhtFRfb9ZEfptqKQdHqaafWh5oiNZaXw5YwkH
 RTerW7Fi69nVh2hFXK5j2CYLVXOPaytIN3tfWCjqaWsDRsbVzo+4zaTwl628+frwEReF
 14R/RbF9B3Dw9DghFEYp1Yhs1J2g7CXU9Kw8Pfc2Nq6VilgXQC1OIdRDXsPvrlDOQv6X
 dO4BRof7FW72NHaHYihH1YeScXz3Q745dsltXaKkYsRFZ7CoO0d2Jx/re8yS7vKc1bta
 dWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131031; x=1761735831;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kDqHxW/jBsy/A2MvdqRNGQd8E6A3Mtbvpi3eUVoeJtk=;
 b=DZL6rF9LXTGFaVj/jtjNHcwEw4WzYLBfnrbzsonHpeBIhpOETpLYefJB5BUpIW2kNF
 P3OCpVswYGtN63Waye9x3YILO5xKjaXuirCbn4km4whPa1xPzjct9Jz4HLahkDlpvlHO
 MpPTtBpHfX/gXo4BQx6DkCKrtfTGdpVvJGzAgE2vr3BFuuosGSjJq+v/aU2YTlICx6R+
 iD+o9CMUEc3gVz5USr5umYPBJMSeTiLm5wIIbcp4IheyA3CnPeswI4u/eUBAONuSaEUF
 eGhYz3DNFBZrc8OOhjZl/yu6xJeE5XlZFekOiCUMq+ymETr9fvI5WsFL4d4OzWG+E/Jn
 PI8w==
X-Gm-Message-State: AOJu0YzNbu9LCBmjg5IF0+RuVex8ryxHktJYRJP39421zt2iN+llJyvn
 vObKqovQ1HRzZnJcZLP5Y3soMUQ2rfD1Hq9eEEokFf8qwqyAoHl+7T+9bhndTT0nJnUReAMY8js
 yks/u
X-Gm-Gg: ASbGnct9qs3i+wwWPi/cPMbFUwCasrXNwQrfuPzU3xiiJaLAqiHKwjgqrhpN1q6guiK
 ITKEtb9mu8bRtCh0zzoRbihnj525gcXV+MmfMoxwEH/okny+9ts13AktjuMYvNmNynyGc8EGQFr
 KGvflEJPenVbZrq1VXJ4G3SrM+CQy4nQRnSFX+u2Bhj81sEQYDV6+lu6vhQlwoQMlhMp4Ux56LI
 f4opmv9ZPwkVjSEex3vpTgdWqiform61TUMxaEbYvYOvUq3goGWy9gfWEasxcPFcIRygHhw6+RL
 XnAxZ7P08Tnxq0+HdUlvM8m5eY7gDIjfTuTMhddSDnxbEgfFDwiREMqdsw8rpZbr0J5GfdWw81G
 bXrVUz5GEYK9pAvS5DO1nvdypm81jq6YBt8kkvCrIX4k2IGF3tFfC6wHJonikxSYQwKoC+g7jDE
 IlzeWkXUMTlVKtMvkc
X-Google-Smtp-Source: AGHT+IFKf+FCt/jEXDGLtOWPEZIeGedqVDx4UwxR/CDWJFRiFHhVGa5nSfwCwPV9mxuNrWz9W5tEmA==
X-Received: by 2002:a05:600c:4e89:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-47117931c1dmr137611625e9.39.1761131031478; 
 Wed, 22 Oct 2025 04:03:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475c43900e1sm44378745e9.17.2025.10.22.04.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:03:51 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:03:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/ras: Add rascore unified interface function
Message-ID: <aPi6FB3E-LNbVYQB@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

Hello YiPeng Chai,

Commit 13c91b5b4378 ("drm/amd/ras: Add rascore unified interface
function") from Mar 17, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:531 ras_core_ras_interrupt_detected()
	error: we previously assumed 'ras_core' could be null (see line 527)

drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c
    525 bool ras_core_ras_interrupt_detected(struct ras_core_context *ras_core)
    526 {
    527         if (ras_core && ras_core->sys_fn &&
                    ^^^^^^^^
If ras_core is NULL

    528                 ras_core->sys_fn->detect_ras_interrupt)
    529                 return ras_core->sys_fn->detect_ras_interrupt(ras_core);
    530 
--> 531         RAS_DEV_ERR(ras_core->dev, "Failed to detect ras interrupt!\n");
                            ^^^^^^^^^^^^^
Then we are toasted

    532         return false;
    533 }

regards,
dan carpenter
