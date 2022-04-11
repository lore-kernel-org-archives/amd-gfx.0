Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1F4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B35910E48C;
	Mon, 11 Apr 2022 16:43:45 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF74D10E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:43:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DD225B81645;
 Mon, 11 Apr 2022 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FF8C385A9;
 Mon, 11 Apr 2022 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649695421;
 bh=P6kNXqgtIDflfg4Owki6sH0KoN+WyNIeOO/oXvVxNXY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hjMixZcJDSS7zCDeVH5g93ATIMlm/0aJCdn3P1/8DHz7dRxQex90SRWnxT4c7IlKQ
 iRrB0BcMPGNkCk6qIjnymacz1sEeBHpE33wfP9ABqbgVOSG7I4Ye76bb/z4dQdXefb
 FtmBjfQVcy5gc5f15Tjnon4OA1MuJSJ99sZZ99kc+zXtUt9oc/5aSW9zDXX3TK7wex
 vmmxmkBBnYt0v5MOrF2FDSFycHFcsTvP68hbQZyBO/PtTUB7HjY8QNVRYzRMhU4txm
 T4ODrMOkwWNS8cV9L/Lehfk1eUbWtoCIBvgYRW4S2gZB7czKAuWPZi11uI3ynqJtLZ
 5Q96qUL2vciBw==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 1/2] drm/amdkfd: add missing void argument to function
 kgd2kfd_init
Date: Mon, 11 Apr 2022 09:43:07 -0700
Message-Id: <20220411164308.2491139-2-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411164308.2491139-1-nathan@kernel.org>
References: <20220411164308.2491139-1-nathan@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Colin Ian King <colin.king@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Colin Ian King <colin.king@canonical.com>

commit 63617d8b125ed9f674133dd000b6df58d6b2965a upstream.

Function kgd2kfd_init is missing a void argument, add it
to clean up the non-ANSI function declaration.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 986ff52d5750..f4b7f7e6c40e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -82,7 +82,7 @@ static void kfd_exit(void)
 	kfd_chardev_exit();
 }
 
-int kgd2kfd_init()
+int kgd2kfd_init(void)
 {
 	return kfd_init();
 }
-- 
2.35.1

