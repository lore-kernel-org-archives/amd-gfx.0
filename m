Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991CEC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 12:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2617322447
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 12:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLjiVAUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617322447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A036EABE;
	Wed, 21 Oct 2020 12:17:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EF26EABE;
 Wed, 21 Oct 2020 12:17:31 +0000 (UTC)
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de
 [95.90.213.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F6A422453;
 Wed, 21 Oct 2020 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603282651;
 bh=ZThY5uPrN8m7PVeYj6yV3k4YTH50nRqHVbTBxoDTc5M=;
 h=From:To:Cc:Subject:Date:From;
 b=eLjiVAUbctSCqXFNEqOjYCcD0lD36EsozUQwQLXQib17OkD1maRKTKIGr2Sfggau3
 MkRA3zzFiQNh47QZlV8cJjzX/nrnNCZAV/sHmguIAyCCH4oLr9VIY1qSgtkUKuBp7s
 7Q/wiluVMS9Ay8unKODOQ7hNqNbe2LcMEjwM37mg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kVD3Y-001U2X-88; Wed, 21 Oct 2020 14:17:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v3 0/6] Documentation build fixes against upstream
Date: Wed, 21 Oct 2020 14:17:21 +0200
Message-Id: <cover.1603282193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, kunit-dev@googlegroups.com,
 David Airlie <airlied@linux.ie>, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, target-devel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>,
 Colton Lewis <colton.w.lewis@protonmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Johannes Thumshirn <jthumshirn@suse.de>, Dave Airlie <airlied@redhat.com>,
 Iurii Zaikin <yzaikin@google.com>, Dennis Li <Dennis.Li@amd.com>,
 linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Shuah Khan <skhan@linuxfoundation.org>, David Sterba <dsterba@suse.com>,
 Evan Quan <evan.quan@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
 Peter Zijlstra <peterz@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As we're close to the end of the merge window for Kernel 5.10,
this series contain the patches from the past two documentation
fix series I sent during the merge window and that required more
work.

It is based on the top of upstream. The full series with the patches
that either didn't generate any reply or have been acked is on
this branch:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=docs_for_v5.10

There are a couple of warnings that aren't addressed here, because
they don't show at linux-next. I'm keeping a second patch series 
against next-20201021 fixing additional warnings caused by patches
pending merges.

I'll be posting those in separate.

Regards,
Mauro

Mauro Carvalho Chehab (6):
  drm: amdgpu: kernel-doc: update some adev parameters
  docs: lockdep-design: fix some warning issues
  locking/refcount: move kernel-doc markups to the proper place
  IB/srpt: docs: add a description for cq_size  member
  kunit: test: fix remaining kernel-doc warnings
  docs: fs: api-summary.rst: get rid of kernel-doc include

 Documentation/filesystems/api-summary.rst    |   3 -
 Documentation/locking/lockdep-design.rst     |  51 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  28 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |   7 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h        |   1 +
 include/kunit/test.h                         |  16 +-
 include/linux/refcount.h                     | 158 +++++++++----------
 8 files changed, 139 insertions(+), 131 deletions(-)

-- 
2.26.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
