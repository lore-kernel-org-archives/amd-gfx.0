Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD95C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F6410E381;
	Mon, 11 Apr 2022 16:51:55 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721EB10E381
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:49:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C9237B8170A;
 Mon, 11 Apr 2022 16:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC09C385AC;
 Mon, 11 Apr 2022 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1649695777;
 bh=EnBUkZbeIVCdx3q6qdW94/u6LeiCVS+Yeldz3hosr9I=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Qe3f4Uo6bTkAzMNwMl8+gyx8Og9jhK41Zn2gnvh9UTtAulhDXsANiA+yTTaAGfA0T
 XJ+cE/ySAHRo47aDUClvTxLVh3cU5pbWYmNrSDsOSAVd+qNI2NI7v7hw/HCwg3iPDM
 uCe99+23BNf25aUc4gdGa8BXDMEAcKK7ZUTGEvtY=
Subject: Patch "drm/amdkfd: add missing void argument to function
 kgd2kfd_init" has been added to the 5.4-stable tree
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, colin.king@canonical.com,
 gregkh@linuxfoundation.org, llvm@lists.linux.dev, nathan@kernel.org,
 ndesaulniers@google.com, rdunlap@infradead.org, sashal@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Apr 2022 18:49:34 +0200
In-Reply-To: <20220411164308.2491139-2-nathan@kernel.org>
Message-ID: <1649695774113231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Mon, 11 Apr 2022 16:51:54 +0000
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
Cc: stable-commits@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This is a note to let you know that I've just added the patch titled

    drm/amdkfd: add missing void argument to function kgd2kfd_init

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-amdkfd-add-missing-void-argument-to-function-kgd2kfd_init.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Mon Apr 11 06:48:58 PM CEST 2022
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 11 Apr 2022 09:43:07 -0700
Subject: drm/amdkfd: add missing void argument to function kgd2kfd_init
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Nick Desaulniers <ndesaulniers@google.com>, amd-gfx@lists.freedesktop.org, llvm@lists.linux.dev, stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>
Message-ID: <20220411164308.2491139-2-nathan@kernel.org>

From: Nathan Chancellor <nathan@kernel.org>

From: Colin Ian King <colin.king@canonical.com>

commit 63617d8b125ed9f674133dd000b6df58d6b2965a upstream.

Function kgd2kfd_init is missing a void argument, add it
to clean up the non-ANSI function declaration.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_module.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


Patches currently in stable-queue which might be from nathan@kernel.org are

queue-5.4/drm-amdkfd-fix-wstrict-prototypes-from-amdgpu_amdkfd_gfx_10_0_get_functions.patch
queue-5.4/drm-amdkfd-add-missing-void-argument-to-function-kgd2kfd_init.patch
queue-5.4/arm64-module-remove-noload-from-linker-script.patch
queue-5.4/tools-build-filter-out-options-and-warnings-not-supported-by-clang.patch
queue-5.4/riscv-module-remove-noload.patch
queue-5.4/tools-build-use-shell-instead-of-to-get-embedded-libperl-s-ccopts.patch
