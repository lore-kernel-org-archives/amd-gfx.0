Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB9C606A681
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8nSWpkj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC0B10E71E;
	Mon, 23 Nov 2026 08:30:10 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E305810E16A
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Nov 2026 06:15:20 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-38699cf08dfso636061eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795241720; x=1795846520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpzYn0GzUFdnPwdqQHx2vxNDfinxrzoJcs9m7k9ETRM=;
 b=p8nSWpkjf/e5onmjzzy+H6/cmub869AvBCXla1bPa6KTVdeRYt8vxs8HFLzBgMRl0I
 i+xqFXOeaOT4a9wcAl46aNeTUvUCK4R0aycw+GloRV3LFXQXlhlYHJdmSR+smHvKRqNr
 KRiqtZm9mwyTbVKEt7p8tb890FaSbRNN7W7B1McAqoFpVxuATvf/0hUBOXBcuuzomIRk
 w+4zc6bVkXlZK5Udu+pFrKR82cgdyMJXsFW24pUvBxFf1KgJ+sPGGJcv/2tEvs0S4a9G
 Vr+8OEgWcWjSzx3j5hl9KN2FCsHkYQZjq5PHydcd2rfBp+K4/xtPimAiRNOIaPLDxH85
 hrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795241720; x=1795846520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpzYn0GzUFdnPwdqQHx2vxNDfinxrzoJcs9m7k9ETRM=;
 b=ptLLoWzI4fBm/nn1r0/3IAMn1fv3DUjM86vU+f274K15W3khsCciPE2+woeaf1zfZe
 di0vDRJhDZdvFCXs+fqHA0TyMs/tbscrg7uiGsMDr0Uwp2ijvfWng6Kr47nQN7Byw16F
 a5/a1GSq25xrPB47ySY+AsWCPFLKsWUuPSFq5K7qIu2MEz19SIYD44tYSI3gr/0YMAoy
 zunRKnEJomfRmsLO6lU5BzjEZJ7oZIUmavU1svO614m64AQxdEQwA7VypR6kOATQNPxF
 jdWbzuu1tG5z73lCkHgdclbliyHcy1opUEj9kxievb/HwHeFqcOTA4AxriGd7lP9iOEq
 vUUA==
X-Gm-Message-State: APuU4Z9MJVNtrwJn0XE7v6gIn2T34ybs9RVnUc/dS/be5Is1V1PDMlE2
 RAT77qwfDff7RK+P1gtCqox4Ah/WNm8OPNUfwfOC7Ca8XzIl0REn4moxEDanTXYB
X-Gm-Gg: AZFdTZcTTWNWaMRYwXIXyCd34HJNcv+eTXJwQLxbYKDdonkv21j1ebhcWoHv95pVcAH
 RsSyjQ9DwYwmboi+nq4p/BUCafl0Y0qXehBS1VnF52Mm6gXggWJE4LtzJ2sriIdWvcLVimlLRTC
 O9ZQy83RVXiNY8NUWe5c9FotYn7wMiZT513+gVeewJ3Wbpo4H6xzgV473RhlQybQjji7Xbgh9we
 eIfoGEnMjXoTLmyWaJ8aBxAZqtpR5PjRjULuHeBmV/IzH4UjnJfdobVOHGInENTOAgnYLQRBVlT
 hGtd0AS3QUCR+o4rDaPCKBiv6+nVUDyGomMxJwKekO9vcclAZGVX0CKZ8m7aTHLOztZD9FeVnfB
 tqU2gEE81IWxooUp22eBbRnEthIApjGQGyJpaUInES6MvGfZME5QR43VKgdsovnEI+ovRg/usXf
 xpOztHR8Yt0h6KunBMtnf37SW+XOREH/jZP+MiH3Y81OGu/Ld/vnBzYLye0qyNt4ZoGuhj7kHuj
 JjRhO6t4KVGrwlwexCt3Djbn7NEKybRTAbABWu4nacwytpI28McQVDzsZ6HzTNMKiJ5oZRZs2/n
 2QvzEBaY+GAGVA3q1S3G
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id
 5a478bee46e88-386a01fa8d8mr298090eec.35.1795241720086; 
 Fri, 20 Nov 2026 22:15:20 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm13054023eec.0.2026.11.20.22.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:15:19 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/amd/display: Document the return values of the
 dc_update_state helpers
Date: Sat, 21 Nov 2026 06:15:16 +0000
Message-ID: <20261121061516.1830533-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:30:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc -Wall reports:

  dc.h:2175 No description found for return value of
  'dc_update_state_prepare'
  dc.h:2190 No description found for return value of
  'dc_update_state_cleanup'

Both functions return bool and their comments explain in prose what the
caller must do next, but neither has a Return: section, so kernel-doc
asks for one.  Move the explanation into a Return: section and say when
the scratch slot is released.

No functional change.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..231a8ca2b18a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2170,8 +2170,8 @@ struct dc_update_scratch_space *dc_update_state_init(
  * dc_update_state_prepare - Prepare the commit under the global lock.
  * @scratch: commit scratch from dc_update_state_init()
  *
- * On failure the scratch slot is released and false is returned; the caller
- * must not call execute or cleanup.
+ * Return: true on success, false on failure. On failure the scratch slot has
+ * already been released, so the caller must not call execute or cleanup.
  */
 bool dc_update_state_prepare(struct dc_update_scratch_space *scratch);
 
@@ -2185,8 +2185,11 @@ void dc_update_state_execute(const struct dc_update_scratch_space *scratch);
  * dc_update_state_cleanup - Finalise the commit and release the scratch slot.
  * @scratch: commit scratch from dc_update_state_init()
  *
- * Must be called with the global lock held. Returns true if the caller must
- * loop back to prepare (SEAMLESS continuation).
+ * Must be called with the global lock held.
+ *
+ * Return: true if the caller must loop back to prepare (SEAMLESS
+ * continuation), false otherwise; the scratch slot is released before false
+ * is returned.
  */
 bool dc_update_state_cleanup(struct dc_update_scratch_space *scratch);
 

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

