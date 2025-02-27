Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD97C197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6443610EA26;
	Thu, 27 Feb 2025 05:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RykC4yEQ";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7D910EA26
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:06:16 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c095b5365eso35591185a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740632775; x=1741237575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aqegkt4ukBnF/wTx16oxel05Rk10hFUfDBxqDpBScLU=;
 b=RykC4yEQtn4a+VJyJLBydnG3asH9tZde4S410JgbT/bTjoLbd+PG2Lw9N6VmtNue5B
 alvI4Ufco2epYsNf2g1m2/ijQpAdbRzVuw200Av8U8f7IVDQAvSITYwpBLdZRUVoLBSz
 gEHOHhjZ4P8mwG947y0/XLifnCKTNUdWKST9Sa/+EZyhR2Tm7h5XRwrN3TVMYsJHOAeq
 IKTm1RS7DxCSURd4oX6kpl6U4aVAKofvdNJZN37La0MF6DAFlwNlf0X2b/zmEP4pXRO3
 KFjeUBBsa6l+hYg89LnUkeB9rhKEkV4BDpVGCkVLw5Urqgff6s+Abc6NH8zRzcy2jacs
 Z6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740632775; x=1741237575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aqegkt4ukBnF/wTx16oxel05Rk10hFUfDBxqDpBScLU=;
 b=FocZctNoKBogqFUjMvWxXeTfQHkxYKjcqocurJs05RnmUYjCDTFPw0E+FiHRL1BRHV
 Euf354ITJpNvuevEAEZWbTf0lCqbD+58jjfKCd+9NX/zCK/Wv+57aVYbPcHC08RBWA4Y
 tLEp2scumissSJthoQ7ZO6QqpU6LOva9ONQnkIYpvyyObRWbEQSQj7Ge4dtLRm5888ei
 FkRIygp561rM8GeITOcKD7zi0WsDgfq5/OuNfJ/bEYEevNT6mOqJRdEJ1tp2vYGRn4JQ
 /Up5LOorRtn8PiIFs+B13jZucx2CeBkeaqcQXy5n7hXQOMXoLiamIcT3cG6toQG2h1Sn
 4fug==
X-Gm-Message-State: AOJu0YxMBRZtghFxVcH7xGduVRp9KQkbDq6lQvu3lx3pK5NssS1VfHfi
 pKtWwEERbOuJ0Ga4qyl9aE5h5AnqjuCMjGr6bMETV1UX1mp9bcEOgL7AaA==
X-Gm-Gg: ASbGnctmPtS1TGXP15EgwQyPSH9ZqBm/v4PibG0JjRXHMpFKuL61zwNzWTwIjAq1qqp
 HcAv574p4w5Usy6x9OcFgVsdhr/Zg/sNwFPWGxgjDqMYIXHI3PAviPgn0rsm/ACUeDt9ORjizWw
 b5qBq1D9gXELcryBj1Q0qoMAhCvnawkLFVCnh3FdcYTNdr/lYPd0ETRd2hos3dCDj1ZPFCNDb1J
 FS48QiUV/OGRfNQmqgYVw6s5rVtgiM9uLDRAFtBIbARgXpjgkJHU9hT+kIdkKyNi8HhC69F7oJZ
 8GKcXxS5OiAizdq5HGNZQqjdjyDj5sT+vO4eETCtPmJSm4d5
X-Google-Smtp-Source: AGHT+IGqPEjtuWqUFXq9kd6g2Z8koYCHCJbcLw5JIGuGngxWQd+KWup4JVqT3ofNrnAuJZ5QCJiWgA==
X-Received: by 2002:a05:620a:2951:b0:7c0:af16:b4b5 with SMTP id
 af79cd13be357-7c247effd08mr1049863585a.6.1740632775208; 
 Wed, 26 Feb 2025 21:06:15 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976cca63sm6066906d6.89.2025.02.26.21.06.14
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:06:14 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: fix typos in SI
Date: Thu, 27 Feb 2025 00:05:06 -0500
Message-ID: <20250227050506.167299-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227050506.167299-1-alexandre.f.demers@gmail.com>
References: <20250227050506.167299-1-alexandre.f.demers@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix typos

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index d1c06d0d6a2d..68f6f4ec8a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -919,7 +919,7 @@ static const u32 hainan_mgcg_cgcg_init[] =
 
 /* XXX: update when we support VCE */
 #if 0
-/* tahiti, pitcarin, verde */
+/* tahiti, pitcairn, verde */
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
 	{
@@ -950,7 +950,7 @@ static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 	.codec_array = NULL,
 };
 
-/* tahiti, pitcarin, verde, oland */
+/* tahiti, pitcairn, verde, oland */
 static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
 {
 	{
@@ -1898,7 +1898,7 @@ static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
 	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
 
 	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
-		DRM_ERROR("Timeout setting UVD clocks!\n");
+		DRM_ERROR("Timeout setting VCE clocks!\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.48.1

