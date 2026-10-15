Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3660CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC9F10E799;
	Thu, 15 Oct 2026 12:56:29 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD6E10E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:57:52 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso340161a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792058270; x=1792663070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8geCjQ7JC2kdDVTHPofBNlGWpuqxqKfu6YxeC0KE4uA=;
 b=a4O0x4HqfnH3jnrgDa1TZ3I37k2krVmhubASolr9XbVzg/OgVwL9uYGrNpRaEiZiy2
 qwepXNwvTr5MfvcfWLUHX+JNelkaa+iou4HHchpdmueRvO+5w5MkUenQU6EGIF6csXq8
 uOZSfc99XD3qAz24PC8hjsyenJ5YDH4Y/Iz/WjE3/VTjFZ4TYQo8cZmuoKf18ZT2Zz6u
 evral2847OBJE7ANPoUTkUvmbd6f8Lc33GoS03C8/kC2iyAvBH33PbfjWYjtrYGEwlMq
 /SdTUv1JidLJZKZf0UDu0BBKUtphLZ4hseb6noJH4ipUC0P/N3ws62i20qS4b/fF3Pvn
 Nl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058270; x=1792663070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8geCjQ7JC2kdDVTHPofBNlGWpuqxqKfu6YxeC0KE4uA=;
 b=aygxpocARAVqZCES6fQYuXZhD/PC3Gr1Ws78Pky93XDWxGs2XE4xkx04efUbXeZGLa
 FQFQV0YnuZjRG8KCKD+W7w3h1XldeTWaOu05iSsEhMXmogIwmFLd0KARsW2sQMAjkDiZ
 hz+5dMTKG2sj4l3Lb1JgCiaJ2x8txLouyolKfTs+fRjz5uDciCPChZePA37iQ5OjScdv
 S4GfURU6kU2C6pvN54qzoSkryeKwS9ksnkgP1dddNOg+BUjqae/uvx6wM/R3hZqCFhY9
 XTTC5pnLSCd5SsrjjM5F2+KMgxQOujZHxvWQaDpWLCpN8xy1ZmAR8JKdS2DPylpdXk3Z
 X0fw==
X-Gm-Message-State: AFq9FYLJm/dIp9xT3RmE/yrzBW9k54NAVo9YfIlt/5F+gQj3OdhBKPkf
 2MM3+2JcFau9XJ55izCuZeGyIyKYKQpAKgID3q6dY0jzVbEsMq/THVu6CEmTxysXDjQ=
X-Gm-Gg: AYBFou0UDwamWQM9ZO7moiBNti/lNdzgtRJHlJG6EfXBXZnXES7Q25k7XTCOGn3P0Ij
 eiaNHU2xJu2uS3KfjO4bCy5Xo6NXZG+cRRCQVaNY+B7rGn/p4nEfcnu0huDtPfxWlVFr+lQ46v9
 hj0IOAxgNuUCX7Tpjr9V4WVnf6zC5MBB404JTJubETE58V20BwkskAadWJg2z5u2YFsY9RM4KTk
 19MsnacS++jH85ZuhAyttK548GDcwWZZV1BifY1VSnTYLt9TE51FK9Cck3b9YEKL2Bk26eiUsj9
 cLKiGv2BIIIivqelPCDIFkNnmq+rLMJG1od54EQFkEjErK9n9HQiiPtmPlld4I1+xtkAtA0WEG8
 ToIY3tMs8U25XrTgoYMLxrGuS5Vzj5yYCPBoM304pa1Xq7i7k0JYQfpnIWPllBJYv5CNK/VJdWi
 tp8WpVDVT/5nrk0NdQnSwo+zRisaq+CG1xEatqnvBM9Z8cTv4vf0KYrFW/RLNZTwq/yIAPPt0XV
 0St2aCNvEMPjwOdm7br
X-Received: by 2002:a05:6402:4587:b0:6b3:8018:7643 with SMTP id
 4fb4d7f45d1cf-6b38018771emr264363a12.45.1792058270438; 
 Thu, 15 Oct 2026 02:57:50 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038aa1aesm2182227a12.32.2026.10.15.02.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:57:47 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>
Subject: [PATCH v2 0/3] drm/amdgpu: reset SI/CIK/VI ASIC on Apple boards with
 VRAM at 0
Date: Thu, 15 Oct 2026 11:57:10 +0200
Message-ID: <20261015095713.20560-1-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 12:56:28 +0000
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

On MacBookPros with switchable graphics, the firmware puts VRAM at MC
address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
reset) moves VRAM back to the VBIOS default, and the driver keeps
using the old layout.  This series resets and posts the ASIC at driver
load on Apple boards with VRAM at 0.  As Alex asked in the review of
v1, it adds the same test to si.c, cik.c and vi.c.

Testing:
- Patch 1 (SI) is tested on a MacBookPro11,5: 4 of 4 S3 cycles resume.
- Patches 2 (CIK) and 3 (VI) are only compile-tested.
- No MacBookPro has a CIK GPU, so patch 2 is for consistency only.
- Patch 3 also resets other Polaris MacBookPros with VRAM at 0, for
  example the MacBookPro13,3.  This is not tested.
- The series does not change Vega or Navi.

Patch 3 keeps vi_reset_quirks[].  Its MacBookPro15,1 entries fix a
module reload after S3, when VRAM is no longer at 0.  The new test may
not cover that case.  The new test also catches the MacBookPro14,3, so
its entry is now redundant.  I can remove it in a follow-up if you
prefer.

Changes in v2:
- Add the same test to cik.c and vi.c (Alex).
- SI commit message: cite only the MacBookPro14,3 quirk as the same
  cause.  The MacBookPro15,1 quirk fixes a different failure.
- Code comment: add the iGPU condition.

v1: https://lore.kernel.org/amd-gfx/20261014192030.10611-1-qchcio@gmail.com/

Maciej Kucharek (3):
  drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
  drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
  drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

 drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/si.c  | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c  | 10 ++++++++++
 3 files changed, 30 insertions(+)

-- 
2.55.0

