Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CD5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 22:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089A010F6EF;
	Wed,  4 May 2022 22:24:24 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BA510F6EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 22:24:22 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id m62so1631118wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlmG38JLDQ7tL3IWq/SZhIp7eD3qDe0xKhj7EzzqosE=;
 b=qk+xXaz9TrKc4xBYbfuqDvC8OK0CUQAyrJAFMQAVTcqMf1VYTOswbJptlnSZxAnAqM
 OWxfb5c5St8rtAJfT5H3PORdaK8MDyJNl/G0BiC9AGUubVTAfTwJzS8plcwgbEZsFQdt
 DnEt0O6l1FnTqKimy4Nv5UDyvHJaAYtR1r9fSQJIC8nnsGTLM1Gn3dViOcMx5bloFK6R
 vXJiBM8Yt5NhKAAta3bZ8qKQalrO+rIxB1mCI4hZI7YhOEixvMknMZ6OvTUTGC5+fY0L
 dnOu/kJCzy5RvNDXGtNqmGdR9Jn4qBkQv+nI7PkPuCxTPzMVXL92+wxleeD0PSpac+wF
 wICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlmG38JLDQ7tL3IWq/SZhIp7eD3qDe0xKhj7EzzqosE=;
 b=X0AIVfG0j9++dhrDbatNEz21Fib+UsDUO3jM+HrKhH+bbA8Taw6GfK3hpaywyp0UaG
 vmjRhxHgyWlm54bCnouzRy7uclGm9sdZVcU/VNT0pAcpVIOcfOJ7/sfKSRgvl0vKhG0b
 JpYQ5ox75t0OohPJv4N5dZr3BtfNtaZJe56K9Ld0TPQ+WV8w2dI5e7ubUb/j9CL9Hq+6
 beTev3n/kmZ9qPZM1BX5lp8fDHtqvYk0iuY0f5+Q5GveWiXTnIgfTAsDNKN6d9D6OGBQ
 TOiYYR2M1/2FoGDonfLkW9436OY2nzPqB6a8i3E/wKD/U2CqLDJrdAjP61dKWqYqGVny
 w1pg==
X-Gm-Message-State: AOAM532db9MN54QYk4q0xLlLMEEOIFLnOl2ikZno7tEDgJqo6xqYgT2g
 Dixf0c2fD6azfclXlsxs/KuwD9CHT48xYQ==
X-Google-Smtp-Source: ABdhPJyuir3Ovvpci2SUl1YaNnfKhJp6vpQATM/x15mazu4iDzk6RsG8B/oOMV1Ddj/m5Ppk2zA9JQ==
X-Received: by 2002:a7b:c7c3:0:b0:389:cbf1:fadf with SMTP id
 z3-20020a7bc7c3000000b00389cbf1fadfmr1435208wmk.147.1651703060364; 
 Wed, 04 May 2022 15:24:20 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:f40e:900::24e])
 by smtp.gmail.com with ESMTPSA id
 f11-20020adfc98b000000b0020c5253d910sm13340443wrh.92.2022.05.04.15.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 15:24:19 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu: Fix a couple of clang warnings
Date: Wed,  4 May 2022 23:24:12 +0100
Message-Id: <20220504222414.95884-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Mike Lothian <mike@fireburn.co.uk>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 3rd patch from the previous series was already applied

This reworks the other two based on Alex's comments

Mike Lothian (2):
  drm/amdgpu/gfx10: Avoid uninitialised variable 'index'
  drm/amdgpu/gfx11: Avoid uninitialised variable 'index'

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.35.1

