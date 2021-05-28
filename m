Return-Path: <SRS0=Uo0t=KY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B7C4708E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996596103E
	for <amd-gfx@archiver.kernel.org>; Sat, 29 May 2021 10:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996596103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15AE36EDF8;
	Sat, 29 May 2021 10:20:33 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8915A6F603
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 17:54:06 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id v12so1970113plo.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ANKlONzWohdov+6WuLPhtLq95Lmabba/pjDXictlH4k=;
 b=mByhbx9uR7qw3+5csFqtiBmrny5PUErxiaumYIELRBs8Ijs/xcNtiUowTW2QHmGhSS
 cI906VAtactPrTU8A5fjRUAOM3qGcxGnnCAZif3JnDahkLLSXlaD6hYXARYKqVrgOcdj
 leokyJOXneOJp2VKYjLGXrQaxUHzBF7YT+bGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ANKlONzWohdov+6WuLPhtLq95Lmabba/pjDXictlH4k=;
 b=eXZIBg+qaZC0Fr5HoYFpdqjs/qA3zJz2a4sChnCLArhgMJIEGRYSbpbhj8qQi+8Qfc
 +VXBJQkl3hlRLxb3KobmIaLXOi/+D5Z1vWZ6aogeDLCoQgjsb6v+leJF/QnlI6mKzQyn
 3B7FVkJEWDITs/AHZLc6Rli6F/eidDFQ0/LZe58Ydfp3y375nnjy2mys4rEjyAHv/IjF
 corcFQl9MrZJfcTCIRD/4RIo1cqaqxVoqwcA5Fp7f+ubKefxWjRjR+V+eZ+gllX+u08F
 GD7i0x03IM79n9Z8SqUqfwH7J70tRINV+Q2/BuwfIimJtCXdHp3/rXdDx4GUn0zz1qwV
 0pMQ==
X-Gm-Message-State: AOAM531Jt27uUO449sEsB8TCvV/HajSxPQmR4n1Uc/ltiCDkrCbR6+gO
 O8eok5V+yVWzSeWrjkOBBHm/tg==
X-Google-Smtp-Source: ABdhPJxV6f94zLFz54LqBFWRmHCGWw+arAdFtXMyPPRV1EjRN1cZPZzO5qd5b8pWXki+rqrAZBOCqA==
X-Received: by 2002:a17:90a:aa96:: with SMTP id
 l22mr5626405pjq.173.1622224446120; 
 Fri, 28 May 2021 10:54:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id z5sm3292699pfb.114.2021.05.28.10.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 May 2021 10:54:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Avoid HDCP over-read and corruption
Date: Fri, 28 May 2021 10:53:54 -0700
Message-Id: <20210528175354.790719-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=4cf2a0636c89416b735d9eedea1837894110975d;
 i=GPlLtkYl4Vl/u1+SgJBiTZwrwkUA3g5q8nhHlBK0VMY=;
 m=/B+IjR5hEpc1KZKXt3rRQHZHXjtNP00Y56rODzGI5ak=;
 p=3dO8lx4rI19NbM9CeLbNSicq/6IC+kqbqEuhiYMdAzI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026;
 b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCxLjIACgkQiXL039xtwCa1kA//VV0
 eUIrl0DGPwzFYYACM0z9ElR4Sni6kHJQADmYI0oV5GXqxqVYMpTOwMjuLPhiZb5RDObC+tyj9MgKv
 GYhx8bIT2X7tztY4aHUpJ0HfPt+sjSzOMvgkLb0F7SOpSxgYp4AJ+aMRp5NUYpcTAZnOKN4k3J1/h
 ojMvo9Y3WX7DIw00WJC6CkgAdNxYretO1gpNmTRnW89KAHaQEpdn9LECYebozdVB122FFCH0qBnre
 5g5wbM2tAH8O3n4alGiQyEbJa16AdWazV8DBYP5YvrDc4dQnMtM1UXXE9K4ZuZPBokx93Av+jfJX6
 N6xrqXcuspSluMjJxe89+6CwyIqrhVWpEFmjtPaPVVDamEYmIYIX4TwahDu93x5Dvb2mP7tSMsRkx
 wmjZw/rRcxlkeBYHJKekTmYsZepdREXApoxWTAtbHU4eoQkU7nfUwo3Nl1s7SaKHVQcLSGCAZPGUW
 I95pVsNvURFGjSoSoH7rKGZnENTPIRnNadOpwYwigFku5mSKE+P5jflW2UzmUxPIHPH/4ABZ1GVLS
 KqooaDCaBF2czw5/41fq3U/e9Pf+lhbxe+IbHd8+lf9iQC7AHePUogh5hWgrALi8JUqKBX/Nz8wDn
 j2v2QxS+8Q+4Hp0egW8y3Sl12DkukVrhY5EDXYZKy0KgS7HgBmJCE9Z1qF1OpDoc=
X-Mailman-Approved-At: Sat, 29 May 2021 10:20:31 +0000
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
Cc: Martin Tsai <martin.tsai@amd.com>, Kees Cook <keescook@chromium.org>,
 Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 Wenjing Liu <wenjing.liu@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Wheeler <daniel.wheeler@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of reading the desired 5 bytes of the actual target field,
the code was reading 8. This could result in a corrupted value if the
trailing 3 bytes were non-zero, so instead use an appropriately sized
and zero-initialized bounce buffer, and read only 5 bytes before casting
to u64.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 2cbd931363bd..6d26d9c63ab2 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -29,8 +29,10 @@ static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 {
 	uint64_t n = 0;
 	uint8_t count = 0;
+	u8 bksv[sizeof(n)] = { };
 
-	memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(uint64_t));
+	memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
+	n = *(uint64_t *)bksv;
 
 	while (n) {
 		count++;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
