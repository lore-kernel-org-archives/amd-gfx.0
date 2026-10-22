Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE65606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=BazaHFBp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B919810E1F2;
	Thu, 22 Oct 2026 00:31:17 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1F010E089
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso899731f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629069; x=1793233869;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mcBWGLRGBmG7YFh8Yth4qEH+qDKlnDHWnzkD2ZKo2yQ=;
 b=BazaHFBpEAXf5ngT2cpdBOUyd39fjkBvpAVvhz2skfVaCXnNMSqVRwP4LE6riakaIF
 2cxdR+7lrPYcWKA5e8CEu6YERkIWX4zE25D7McEznJuKnaSGXgXKHX0Roz0EAaxGki7i
 V+h6Gp5kdr7ciJ4+j8lSHQ7G00wPmW0sLDifrCRSAZUXm6qfELrrb/U99ZZ6a3zGR0s0
 cVUkLcDOgsVXKy4XulHex2RXLn+ON6vvOP9qRceVEpusgsfyVqESHmXKk2KzgRAOvkPG
 qGoJpwmWLb+LyUsMjEDwV/JD7fIgNHIYhwv8C+v6A419d8hS43G9AR8D3H062rhGXX4g
 gUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629069; x=1793233869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mcBWGLRGBmG7YFh8Yth4qEH+qDKlnDHWnzkD2ZKo2yQ=;
 b=aj+eSXPVMDNRvuUDl01tF/ZA20ptfDiBuyNKutRDukMLCarM+BwR2dkkOJyeQtU7ZI
 ucgB0AY4SQ33kvYvK29SskEMPYdIY9V8SXT665fDssn7C7TRpyw4qpTiuIav+7Qm5ZiN
 TojzGsrJZVz3Kqg0FGzVZzQqKP3NXYu20aT1WMAXWPgNh5LKFPdrL/9nyYWyNfXSpl0/
 +DoqEH/uf66cD+bW4fzpdAF8ljR96thA+XgSSBL83i1DqzR2vLf4W/fKJ4aSH20xYUzP
 YHe/YmsuON75X7PorGwC2u+1N5i0/N0doOCftKDKPd2sKYavrEn2rGlOEAHf57kPCw8r
 Lyzw==
X-Gm-Message-State: AFq9FYKdm2eZg0AVpJ+zdqPJTmMuFjS0KNwwtcikeP/iEC/B2uDQvr4m
 RQxFlR6pPjrDYGMWYvxNzj2CkP/c9fULM/U41PdjpZxENZ18v2tPjh99W81buFgI7K43LeCtx26
 nOBX6jH4=
X-Gm-Gg: AYBFou1DOsVzPXPCjg0+RkhYEMWYPhGhFcMatIRsz6E7bGrenQjxMEDERrkmJQ56SPi
 6yOlA2/m+mG9A/aBAYA9f4iuPX8sipZoWGrAvyvusucmYeLGdYIZIkGS4ErvNAOdkBI6CZfVMNS
 vct93F/fI2movLB+gjQHtu5k6c15mBsxKWyKUXmY33nskkCjnHZcW5jdG7ldQwq0qzewIB8irfl
 vqRIRJ8cCbyhZMfMSdyFJMdiBIa3rSCg9BQj0IfTAR0qp1flPPLhrs5dR0mcxYS3MAUqZUs4lSy
 s9EO2i4H+Mb4o2D9P3z4WZNPQOt7MVyS688vqjC/zcscqEn+BEWR0taHVN97eciLdskAptwzwan
 IUDlPNvbrc/0YzLZD5PNa3OT3ZPqwUv3/NlNrCyA4nsmGN1+OfvIWg1pCLaIhYGHqXZCBDmQMWa
 YWkEZjUTih3QLHCBbM/Ocs7iK75UxPqUZWnASQkhPhUZYr+i0V/rPhmU8zEK2NPzsF28IGD7b0h
 X7ybHtoDtnkSgSBSWZFeq1emHd4YQroInasTKFam8vJv+eD7PoROI6r/S2L5/f0BIjwB8rWvTil
 cb+GGywAb/sffRmeKu0BVp0nsINcf8DxhoQ3ns38uist
X-Received: by 2002:adf:f98d:0:b0:48e:17d1:16c9 with SMTP id
 ffacd0b85a97d-48e264d569cmr5602595f8f.40.1792629069202; 
 Wed, 21 Oct 2026 17:31:09 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:08 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 1/5] drm/amdgpu: Check cs flags.
Date: Thu, 22 Oct 2026 01:30:54 +0100
Message-ID: <20261022003058.1723817-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1745e500fd80..63fd16009bf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -188,6 +188,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
-- 
2.56.0

