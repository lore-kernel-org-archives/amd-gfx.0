Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD19CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4D510EB6F;
	Tue, 23 Jun 2026 14:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SBDyxv5N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109AB10EB6F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xpoipWDPEQ2xr5NX2Qr61jrOC93Id91hyu1/cGdo8kQ=; b=SBDyxv5NOMeXDmH0WSjLHmBjE6
 hx7VTgdfvo2ec1/3LEz8YwVyDnn6WZVL5MwZ4mKxZvDMYhSm9OfsAM88gyMyaIBM91kwEgv5Ke62L
 gFXXtJKzqcuosZ3A2fwJkSIPWdtO3ye8i0w1REO9YmIXntVTfWFSJYK3RxEgua3q66PlSrNkljAl5
 oJBFbBSU/VE4Dw6adItBfRSkPrwBs660StiCFmj0uCbmkpCYi6BgLxKaGkDFVtbklmJiYYt/Yy6cs
 pwAeQwrafCwcH4YDIgUvwRc00K44njMfJIv0TAh2jyDUNlcfM0BQoBPQ7T/fUKTJ+lMU2rN1nOb2h
 9Fpqj3LA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc1sQ-004DBx-OC; Tue, 23 Jun 2026 16:13:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC v2 0/4] Tiny steps towards amdgpu checkpoint and restore
Date: Tue, 23 Jun 2026 15:12:53 +0100
Message-ID: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I am sending this early with the main goal of getting a feel on how it will be
received etc.

Cover letter is written mostly for people who already know what checkpoint and
restore is, so I will just restate the high level goal - To be able to
checkpoint and restore purely a rendernode process (so no kfd in the picture).

And for people not too familiar what it is, probably best to first read about it
here: https://criu.org/Main_Page.

There are three pieces of work here:

1.
This kernel series which adds new uapi to amdgpu.

2.
A new IGT test case which helped me find what doesn't work and to verify what I
added.

https://cgit.freedesktop.org/~tursulin/intel-gpu-tools/log/?h=amd-criu

The IGT starts out adding some very basic tests (first commit) which are laid
out in order of increasing complexity.

Following commits then add more tests and by the end, with all these series
combined, they all pass apart from the forking subtest. But that one I am
leaving out of scope for now.

(And to be clear, before this work, none of the tests cases can pass.)

3.
Changes to the amdgpu CRIU plugin which use the above uapi, among other changes.

https://github.com/tursulin/criu/pull/new/amdgpu-render-node-rfc

As a picture is worth a thousand words the best I can do is some from terminal
pastes showing it all in action.

Terminal 1:

$ sudo ~/build-holo/tests/amdgpu/amd_criu --r busy-client-content
IGT-Version: 2.3-ge37a85b91 (x86_64) (Linux: 7.1.0-rc2-cfs x86_64)
Using IGT_SRANDOM=1779805687 for randomisation
Opened device: /dev/dri/renderD128
Starting subtest: busy-client-content
Start checkpointing within 10 seconds...

Now switch to terminal 2:

$ sudo /usr/local/sbin/criu dump -t `pgrep amd_criu | head -1` \
  -L /usr/local/lib/criu/ -vvv -o criu.log -j --link-remap --tcp-established \
  --file-locks --ext-unix-sk

Back to terminal 1:

...
Killed # This is normal - CRIU dump has saved and terminated the process

Back to terminal 2, lets restore it:

$ sudo /usr/local/sbin/criu restore  -L /usr/local/lib/criu/ -vvv \
  -o restore.log --shell-job --link-remap --tcp-established --file-locks 
  --ext-unix-sk
Subtest busy-client-content: SUCCESS (10.739s)

And that is it. Client which was busy looping submitting a SDMA_NOP IB was
successfuly checkpointed and restored to completion. It both ran for the
remainder of the indented duration and we checked buffer content was as
expected at the end.

There is definitely more to do. Play more with exported buffers, syncobjs,
fences, buffer objects lists, but for now, as said, I am looking for some early
feedback etc.

v2:
 * Dropped the reserved VM ID query.
 * Made userptr address an explicit union in the bo list entry uapi.
 * Changed copy buffer from synchronous to providing a fence to userspace.
 * Rebased for removal of ctx->guilty.

Tvrtko Ursulin (4):
  drm/amdgpu: Extend listing of buffer handles with the userptr object
    flag
  drm/amdgpu: Add a new ioctl for listing client contexts
  drm/amdgpu: Add context handle renaming operation
  drm/amdgpu: Add driver managed buffer copy

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 130 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 122 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  54 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  26 ++++-
 include/uapi/drm/amdgpu_drm.h           |  62 ++++++++++-
 7 files changed, 369 insertions(+), 31 deletions(-)

-- 
2.54.0

