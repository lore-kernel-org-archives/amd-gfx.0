Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B281EFB818
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F53610E4E5;
	Tue, 24 Feb 2026 08:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.b="i2Qic6qH";
	dkim-atps=neutral
X-Greylist: delayed 419 seconds by postgrey-1.36 at gabe;
 Mon, 23 Feb 2026 21:57:11 UTC
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E8210E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 21:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZMM2FCMzlh2fG;
 Mon, 23 Feb 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received; s=mr01; t=1771883531; x=
 1774475532; bh=fwAOd1ujkWk5Wg47tjqI1LopMAuDLIx8SW3w8NZ6/A4=; b=i
 2Qic6qH3w2ePfpk0N9nGewJkl16BFF9xn3Nba/2xGyqWMDUiYnWf7Jxf1cyXNBWb
 tStBD4L8xfnuy7KjTTB7tBkU9ySQsVm58HMNOI5bdF4C5aMt2wpwnvMEzPmqVGWL
 YnTtHoOLetHNnRkh2q2qA1l03RCysJMSD/Ztvd+3CGa/uTPqpzIxm60yVbCrWLMt
 p1TGNfmkT/RobCsmrcTNwfnF+E+TSbQ0SQtbjT/GMN3yDMHYq0nj9H4JqqjiIcRY
 Lg3PSJgPFgPgsSUt3ZWvJif2nOdMRYemNFQSKxMdZzJi5q8qeTnDgAwqa1Wefiw+
 b05U7jlPWGb7l5XJHu+7w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CE_48XZbhwXM; Mon, 23 Feb 2026 21:52:11 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZMC00Hxzlfl6N;
 Mon, 23 Feb 2026 21:52:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
 Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/62] drm/amdgpu: Fix locking bugs in error paths
Date: Mon, 23 Feb 2026 13:50:23 -0800
Message-ID: <20260223215118.2154194-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Feb 2026 08:33:26 +0000
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

Do not unlock psp->ras_context.mutex if it has not been locked. This has
been detected by the Clang thread-safety analyzer.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: b3fb79cda568 ("drm/amdgpu: add mutex to protect ras shared memory"=
)
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp_ta.c
index 6e8aad91bcd3..0d3c18f04ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -332,13 +332,13 @@ static ssize_t ta_if_invoke_debugfs_write(struct fi=
le *fp, const char *buf, size
 	if (!context || !context->initialized) {
 		dev_err(adev->dev, "TA is not initialized\n");
 		ret =3D -EINVAL;
-		goto err_free_shared_buf;
+		goto free_shared_buf;
 	}
=20
 	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
 		dev_err(adev->dev, "Unsupported function to invoke TA\n");
 		ret =3D -EOPNOTSUPP;
-		goto err_free_shared_buf;
+		goto free_shared_buf;
 	}
=20
 	context->session_id =3D ta_id;
@@ -346,7 +346,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp, const char *buf, size
 	mutex_lock(&psp->ras_context.mutex);
 	ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shared_b=
uf_len);
 	if (ret)
-		goto err_free_shared_buf;
+		goto unlock;
=20
 	ret =3D psp_fn_ta_invoke(psp, cmd_id);
 	if (ret || context->resp_status) {
@@ -354,15 +354,17 @@ static ssize_t ta_if_invoke_debugfs_write(struct fi=
le *fp, const char *buf, size
 			ret, context->resp_status);
 		if (!ret) {
 			ret =3D -EINVAL;
-			goto err_free_shared_buf;
+			goto unlock;
 		}
 	}
=20
 	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_bu=
f, shared_buf_len))
 		ret =3D -EFAULT;
=20
-err_free_shared_buf:
+unlock:
 	mutex_unlock(&psp->ras_context.mutex);
+
+free_shared_buf:
 	kfree(shared_buf);
=20
 	return ret;
