Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2F7C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 02:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF86D11B774;
	Thu, 14 Jul 2022 02:47:55 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A77011BC71
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 02:47:53 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-10c0430e27dso935355fac.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v9Z2pa3lYfgqOmxTpM+5SYBO+u1+8NSu92ncqpCfQY8=;
 b=qqk8G4BvzxhB2/teStSBaAq8s78P80HdDRJ0x5FrK6Lg89tVtFtHohC0Z4AcBsfbAO
 UtvqF8GyXnOttxvegkLxGSYrcnMx/1l+2fTPXAza5fg3tdM9Fv9T73dYBUImETOU/Nro
 Wl2amSurfoa0YJh0TJanV8WZx0nEy3V0xqRnD6a5HBapfGIdb76deTDOYjA+8h8YsSps
 2zxfFqqIY0QdSMM5eR95KKgCHS4eF4U0LD48YamauzXoRCxeWO1jc4SDSi2J9j7q72yh
 P0iDBnGSweFUP20VQELIHqgDBNeWvQI5T8q1EXOyhbToN8AY5pLVHo6a25YIVwuxGl+t
 iL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v9Z2pa3lYfgqOmxTpM+5SYBO+u1+8NSu92ncqpCfQY8=;
 b=cEUXQB60Fx6niz1vAZHyAJpRvx6N6Y6Uw5bA+qWMwYzCTXtndqpLOLQrSuwaP/AG6d
 CgWZHm8LpFJ1Z3CG8PEnQNuxHT5YtJncw+Te29SCD55ysK7Zef+7hZUrJ9Vi8LQQhHiz
 Xfh7+P3nx+hiV6wG+6mYCGdC0jQWXbt4j1H1QWlNPqi0ugxaQ0bEgogrQN/ne4eoPmpJ
 pbYSHDpkdIzNhvdBsmRoW1/r583PuYFt+fMxu3SrdcQQJeRuo9plDcho8p+5wWoVLd7g
 rtpzIqejzuBAlpA8asNL3QL8nUcIiRHQyWYk2kasR0Xrlmi4BDoFZ0vmhSpIZqUrL1zE
 wWYQ==
X-Gm-Message-State: AJIora8CEkqHw2pDkjF/+5xDMFtzykGO2ziXyJ0m1VmwbUM2UW2fO1aW
 a53U52Jl59EgNEJfaNKodwE=
X-Google-Smtp-Source: AGRyM1tzY4Fvs6tJ3dc9U0ZOGrrTt97Ng9qKIUzGuhG4rUVktnpbjwBhaA+HsVP89EObeOKnh6UXAw==
X-Received: by 2002:a05:6870:fb89:b0:10c:3847:f0a with SMTP id
 kv9-20020a056870fb8900b0010c38470f0amr3426847oab.273.1657766873249; 
 Wed, 13 Jul 2022 19:47:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a4aa78c000000b0035ef3da8387sm145781oom.4.2022.07.13.19.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 19:47:52 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [GIT CHERRY-PICK 0/2] Fix compilation errors on GCC12
Date: Wed, 13 Jul 2022 23:47:46 -0300
Message-Id: <20220714024748.29696-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Alex,

I believe you are already working on a rebase right now, but could you please
cherry-pick these two commits from torvalds/master to fix compilation errors raised by
GCC12 in the meantime?

SHA-1:    82880283d7fcd0a1d20964a56d6d1a5cc0df0713
patch-id: 684ed745d944c90c2aae3c9eda5a4f5aa9cd48e5

SHA-1:    52a9dab6d892763b2a8334a568bd4e2c1a6fde66
patch-id: 6b15e90354234809c3e054332d5d37612c5995dc

Thanks in advance,
Tales

Kees Cook (1):
  libsubcmd: Fix use-after-free for realloc(..., 0)

Sergei Trofimovich (1):
  objtool: Fix truncated string warning

 tools/lib/subcmd/subcmd-util.h | 11 ++---------
 tools/objtool/check.c          |  2 +-
 2 files changed, 3 insertions(+), 10 deletions(-)

-- 
2.37.0

