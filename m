Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CCACCF9F3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C592F10E681;
	Tue, 28 Oct 2025 22:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfNNULqE";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450BC10E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:48 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-63e0cec110eso11211233a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689207; x=1762294007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BgyLIr+ccGdWYEGbqCZXV/fc5aX/z2rkP7ewFzSKEts=;
 b=VfNNULqE85b6/PB3prE5i738DBLdQpDCdRyduzyHolgmqGjaqKud9hrsgp1bFynpVL
 7dNKMPwj3v/HWFHWub06VJLAFd7R6E8m+qcnqX8FYcuie1zK5ujkSHQG6xenrG2YZN1s
 mfaHMOjq8AgXFByctojExWOGGcCb2r0IUyN7doHLCAnf6bybus14KoGUAliBOpzF2FTE
 3urJ/KMzd+xeQ87BIadCZtMJj2OWQKyWTdap523o1WTCLCa+gaCYkO1KtrbMOH2/9byV
 3gWvk5vYs/cVnSrB6XyRA+EW1tUZFDcGpoBiXedYdniYTB7tXS9DXtcWhAwKuFY51alz
 Nkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689207; x=1762294007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgyLIr+ccGdWYEGbqCZXV/fc5aX/z2rkP7ewFzSKEts=;
 b=X0VoRcYzxKhwMNabW+3le6H/A6J0may+r9j0E0lUY/9uEOK0BfeD30t9ch6iC0e5Jw
 +qFjYSdYc+CJon57LbZ6TI83MDNGhiyy0bJqLqqoy+n7odw6kDb81LZlZcmd+RkoTLYZ
 kbWIT+ws9e/PHB8BOj/DVNrHuVP8EExzrQmUATihi6JpEQrve+5Y6MKb8hDMev9wtbWK
 91r+U+Lh0nvubEO+99hXKBuHQe6li1Uqxc55QOI7/NcC/bD17UjRPYUX9Qg7gXNR1FoN
 E9TcSVr4IKbCvHKp2L2H/yua2Vxc55BtyIqtqxNt3/XikFUB19Ig+G+N7KIsJ7KBd4tN
 5Ejw==
X-Gm-Message-State: AOJu0YxFbYd0fKHsrta8VnPBaOSPh5KMcK6165x60sjXM3ugrlXr3BFj
 iJSRQQV9REgpC8njX3LQAeSOyolrmO9mNhrT3dOS560ewGRnD978xe3kVeqdMA==
X-Gm-Gg: ASbGncviCIq4tFkgK9LuNRc1gzZoOKSnpgESzzZiDBdEjt07cBC3CeLFFbpu0CqmqI8
 vo4MGlTqJqzO3ad3x9Pf8v1+ZTbnnh3Pdw84LjKMN/HibQqxNFaMhAyk3f9Y2pORrdEnX2p/wRl
 o0DQF8QhWvspLUTjgR1EhtJdLJ7hQHsHhQPrbL22jcgaPvofoCeHYuCWYQkLUpD6XTv6urM0fZh
 9R3Tj9KTRdxl9EQu0T64KAR1wiZpbPx4Cre7Znh9LQZJQ4kW4k2Y1lyBzkrpuE2SkWEYvnKCDsm
 POZ7fJiAVqWFwqyv2djNksVGE82CQRd6VHh8lb1uLbrVBM6pdWwxcyTHZ7Xk3AfPr6rRPBe+xBb
 h3MLQzspsaX4n0LXjD2FrrO2EacC8+rmnJ04zNtfkdhmSU+/Gpvx8vvu95hRVfUvuB/xnIQikjz
 TyNWpbOYt5oOF2ifLil1ujKTcwABFQfhdESFOOnWya4h7Wb7DO+IxOEYEsEuc3KpTR4iGUISYMd
 e7e9dBj
X-Google-Smtp-Source: AGHT+IHfmRPolfBvdw7DCIaqorTOBB4nxGE7jZuKD4lvOkIKKrV5IrQfJeHGedVNLC1lMwHAPzFUMA==
X-Received: by 2002:a05:6402:50cd:b0:63e:2d4d:5a60 with SMTP id
 4fb4d7f45d1cf-64044188bbcmr509971a12.8.1761689206641; 
 Tue, 28 Oct 2025 15:06:46 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 07/14] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs
Date: Tue, 28 Oct 2025 23:06:21 +0100
Message-ID: <20251028220628.8371-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Some harvested chips may not have any IP blocks,
or we may not have the firmware for the IP blocks.
In these cases, the query should return that no video
codec is supported.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b3e6b3fcdf2c..42b5da59d00f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1263,7 +1263,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			-EFAULT : 0;
 	}
 	case AMDGPU_INFO_VIDEO_CAPS: {
-		const struct amdgpu_video_codecs *codecs;
+		static const struct amdgpu_video_codecs no_codecs = {0};
+		const struct amdgpu_video_codecs *codecs = &no_codecs;
 		struct drm_amdgpu_info_video_caps *caps;
 		int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf..b755238c2c3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs cik_video_codecs_decode =
 static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				  const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e0f139de7991..9468c03bdb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs hainan_video_codecs_decode =
 static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_VERDE:
 	case CHIP_TAHITI:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a611a7345125..f0e4193cf722 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs cz_video_codecs_decode =
 static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
+	const enum amd_ip_block_type ip =
+		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
+
+	if (!amdgpu_device_ip_is_valid(adev, ip))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		if (encode)
-- 
2.51.0

