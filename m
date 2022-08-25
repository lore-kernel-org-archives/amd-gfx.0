Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F98C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE40C10E023;
	Thu, 25 Aug 2022 13:31:51 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81CC10E023
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:46 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id u15so30891309ejt.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=1k6N9WVq4G4AYtLMGBogrp7GQZ6/168vEGje62/Jb0s=;
 b=H5f9Kr0MM0lbOJOHqOgccLNhF58NkGY9eple74snLNAREQihQTa5QkKQImcXIUfKu8
 JF6Ly1GLbvkvo/eDPEh7JFDPHDHV6q4kOqLjjz305V1HC7vixv5yTYg21jKcOxARd6/3
 kni7BMfvEngx1j+wsu7e8I5piLqWwrI9xC1k258fB3rvS8P1J0LRrjga3KGLOsXhpV3c
 B2vkEB+Qmds/eDP5Log+OthPOaskYRVpEgxxw5INouL9/PGxEqF4f+uKi1n6FzxOBNSp
 GfWHJPwqGJoqfYXdclHvk8bS5CIYlfS/8HbMqz6T3iMClbSTmF/4GlgfJREmqROodwVE
 GgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=1k6N9WVq4G4AYtLMGBogrp7GQZ6/168vEGje62/Jb0s=;
 b=AqPidsYHdozaCDncn10c0f8tpdudQBVEaZd3dRrpA34EWfrHcgy+og4nyC78Vv8Er1
 R3kP6Eeo9XhOy+0qW4QIb01rHZ5wfVVEc4bxGl+JFr7m6fn+wW0cmJM/LGPoYt9M8wTk
 FDdHUeETRBO7FtYTyUDU6TdeDd+LXRXsnyzgw152/Ss82peTz+mtLP5c7ny3k4dCOU5h
 xHsKlKxooWxPj2XJtzFWisi33rzKEA8ir++atGv8Wd1ZM+BW3gS4WGvtmQsYs9auo6hF
 U9D6grTdCMddZE4eEsZyTSOLOLIEM+Z1tFsz+97icHchMuQfWHnHobOI5pwyV1tH8Ue+
 rG1Q==
X-Gm-Message-State: ACgBeo19hx0G+QzzXWtGB3rIVazBcLGOayC49499mUwAEzJhKGXHsF28
 weoAs0g2QpY9wwjNQ7ntK0465dCo9rI=
X-Google-Smtp-Source: AA6agR6wJYWGLJA5/nJ8a/0gQpFVzNeW+Bs2STPXSPQ6EYsJlFTi3yJl8e38mdKowGK5pfGHVoB45w==
X-Received: by 2002:a17:907:7214:b0:731:465d:a77c with SMTP id
 dr20-20020a170907721400b00731465da77cmr2493670ejc.308.1661434305373; 
 Thu, 25 Aug 2022 06:31:45 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Latest gang submit patches
Date: Thu, 25 Aug 2022 15:31:31 +0200
Message-Id: <20220825133142.8272-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 Trigger.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

so Trigger found another issues with this series which is now fixed.

Patch #11 is just a shoot into the dark so far, could be that the VCN3/4
problems are now solved. But could as well be that this needs more
investigation.

Bas still has a backtrace with this which I can't figure out why that is
happening, but going to investigate further.

Please review and comment,
Christian.


