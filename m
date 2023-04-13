Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41540C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 14:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71FB10E37A;
	Thu, 13 Apr 2023 14:25:06 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE9F10E37A
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 14:25:05 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-2f45377dcc7so194290f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681395903; x=1683987903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlDOz7FyaYjDyjXaXYvCHsbX0Nryy2/TTJhRoTTU6Tw=;
 b=L7JCeKVVvyiKt5YdbwRbLr3lfdke9My9Os5X/wFSxVpfW2xo1oHpGDXbp+Xd616Tu6
 v3z3WEwOeNd6fIpbF+XJiDMitE4jG2nT+gGOqCEoJSi6fu+CyZHpIPr0XkdmibrGE4dH
 YNIRLJFXpzG2Gs7DVuXJS/k0hPJsG4tGlu7M2mw/lGJYbeA3JUcArazSr4aiqf01YqZc
 9ECP21+hzSNj98hCtLnr3vQpUjoJQ7fiUML7Y142sSX5Cb8EP1woG5Ie7dBoxadAsTCX
 ghjr0mzCZ7mu4EN8Cv6n1TeyP607IsjDOCZpg9JuV+iLgqggjZ02gIKysmD/KkmYtY9R
 15fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681395903; x=1683987903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlDOz7FyaYjDyjXaXYvCHsbX0Nryy2/TTJhRoTTU6Tw=;
 b=PgRjkbYF7X+bD6KPzZRJ7iULwVHQ87mS7FWeMXqfN29EVvhcWI3g0RpA+ab9Wzdw3F
 PA8NvHRpUhxdW6CZD1EXNpf/US0TUokEvwt6xw335VeWHMOiqywZq2cHvXOUlTlKw4dY
 kP6xZMCeydpABMOfMl0xdXpXEXYIPTgEIaNBrcf3pA86RJLl9l0iiWlFgv87ZuG8NuLA
 RTLYV8numPfuutjYEqkItZG1i2kkoL4RPedkB237VJCi+/D6q+/xEC7yoCbUdCsGc7Xb
 UWaiTDdJ5OcAQ/zVucwP5B99Mf1u9xn8p5iIUaAr05v/s8RIuLx5nKem2OS5O2KO1qk2
 PFwA==
X-Gm-Message-State: AAQBX9dFChAMtwPuuH/hZHCd76xjeZkwap7EUn0KEPxVQgtDkzJmEgqx
 G07+9bNtdT1w36eAYzg0bhijtpk7S3kwzXxMuFQz+w==
X-Google-Smtp-Source: AKy350YxRy/p7OJFNcM2I5M5tfltCd3ZoIZrXPR84Ajm0ehh+WpSzw0Pt1BrKTyWjRIY00Mz/YwmLg==
X-Received: by 2002:adf:e98f:0:b0:2c9:8b81:bd04 with SMTP id
 h15-20020adfe98f000000b002c98b81bd04mr1491242wrm.0.1681395903230; 
 Thu, 13 Apr 2023 07:25:03 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a056000120b00b002e45f6ffe63sm1401186wrx.26.2023.04.13.07.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 07:25:02 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/3] drm/amdgpu: Add a max ibs per submission limit.
Date: Thu, 13 Apr 2023 16:22:52 +0200
Message-Id: <20230413142253.414333-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And ensure each ring supports that many submissions. This makes
sure that we don't get surprises after the submission has been
scheduled where the ring allocation actually gets rejected.

My calculations on the existing limits:
COMPUTE v10: 128
COMPUTE v11: 128
COMPUTE v6: 157
COMPUTE v7: 133
COMPUTE v8: 130
COMPUTE v9: 125
GFX v10: 208
GFX v11: 213
GFX v6: 154 (doubling this in the previous patch)
GFX v7: 226
GFX v8: 213
GFX v9: 208
GFX v9 (SW): 208
SDMA CIK: 87
SDMA SI: 97
SDMA v2.4: 74
SDMA v3.0: 74
SDMA v4.0: 72
SDMA v5.0: 51
SDMA v6.0: 52
UVD ENC v6.0: 98
UVD ENC v7.0: 92
UVD v3.1: 124
UVD v4.2: 124
UVD v5.0: 83
UVD v6.0  (VM): 55
UVD v7.0: 51
VCE v2.0: 126
VCE v3.0 (VM): 98
VCE v4.0: 93
VCN DEC v1.0: 49
VCN DEC v2.0: 51
VCN DEC v3.0: 51
VCN ENC v1.0: 58
VCN ENC v2.0: 93
VCN ENC v3.0: 93
VCN ENC v4.0: 93
VCN JPEG v1.0: 17
VCN JPEG v2.0: 16
VCN JPEG v2.5: 17
VCN JPEG v3.0: 17
VCN JPEG v4.0: 17

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7af3041ccd0e..8362738974c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 	if (r < 0)
 		return r;
 
+	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
+		return -EINVAL;
+
 	++(num_ibs[r]);
 	p->gang_leader_idx = r;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..f676c236b657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -49,6 +49,26 @@
  * them until the pointers are equal again.
  */
 
+/**
+ * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
+ *
+ * @type: ring type for which to return the limit.
+ */
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
+{
+	switch (type) {
+	case AMDGPU_RING_TYPE_GFX:
+		/* Need to keep at least 192 on GFX7+ for old radv. */
+		return 192;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		return 125;
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		return 16;
+	default:
+		return 49;
+	}
+}
+
 /**
  * amdgpu_ring_alloc - allocate space on the ring buffer
  *
@@ -182,6 +202,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	int sched_hw_submission = amdgpu_sched_hw_submission;
 	u32 *num_sched;
 	u32 hw_ip;
+	unsigned int max_ibs_dw;
 
 	/* Set the hw submission limit higher for KIQ because
 	 * it's used for a number of gfx/compute tasks by both
@@ -290,6 +311,14 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		return r;
 	}
 
+	max_ibs_dw = ring->funcs->emit_frame_size +
+		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
+	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
+
+	if (WARN_ON(max_ibs_dw > max_dw)) {
+		max_dw = max_ibs_dw;
+	}
+
 	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
 
 	ring->buf_mask = (ring->ring_size / 4) - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3989e755a5b4..e6e672727529 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -317,6 +317,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
 void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
-- 
2.40.0

