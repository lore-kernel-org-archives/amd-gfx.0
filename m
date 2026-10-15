Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64683CCA48B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001821126A7;
	Fri, 16 Oct 2026 08:55:49 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B317810E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:18:58 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c2e36c3478aso342100366b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792088337; x=1792693137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GwNeNf/zUJyjKm81A6K2cijsAB6yIEwlP0rAjiOwBRU=;
 b=sv+xUJM8JzOjfHgdblj/AwIXY+F3BczC7vxgtvGYR1LH0zcmkp85nTjj7OVwzNA27K
 Nvxwz6WvcfEkoou5X6JaWGvBBNKh8Mvvm5FruZ5ke83Wr52y+ZxABzV1AzDAw9MRRt27
 DZDVgIqH9G8GVhkplHaGHhEfcKkUHEs1+1XIPciWiKM8ziky2Xjj59UyJpNL8KC+vdol
 6FjCpnwZvyWpQADxwSghs5OFjLOp3e8wt+03hS4kwYYGVNbdiyO93OSVZ1odiDmHV18o
 RGRd09MJqTYZyynJr052RWIazU1uzCXBPHxmkkb2SdnnKMe66Y/43rvDdhjJENzaXrwu
 nclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088337; x=1792693137;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GwNeNf/zUJyjKm81A6K2cijsAB6yIEwlP0rAjiOwBRU=;
 b=i1oA533RHq2jbD+FGScHsbk3vaeaSa1Xx2VRPczdXQ7a32FZL/OVIeP3MZ9pMOCabs
 76CN7EV1x6hWrrPgDrim/UCeh0wp5a+8v0PIh7C5yeUxI7je6nKMiDwKpEPJ1DCTtcL0
 78WC3kY+KU5U7vUsVx1uEUUhNWfBwn4+IR5Qy87+2/ZwUqTwdN2KVAOH/WVQFgxRqdIR
 KHFEHNFPD+z20p8fcInaSG/+VzpQ7TTvIH6F6UleSRkFgXSF8d4tK18gpnWFW/ARjFih
 VEkm/IZ1Xb9Esv1sOoCIrToAcNCTr7bBHy2PVaxwiQ+Rpw8VKJF/ndJb+aiB9f5pHGq8
 kkBQ==
X-Gm-Message-State: AFq9FYIQhoQi8HbFtG75KVpTmzWYJgFUy+ciISpLLvDryOZ7tRzA262M
 Pd/xH3nB31lfRgInscOsKKkDCthwe+zeTBS2BoJ4QnuXfCBTy9c/O2ufVl7PQrqmG9w=
X-Gm-Gg: AYBFou0+A9kz6PF8dw5QyMuCkEIhKDgrNLB5eZ8gW7cmuYDAUvDXEW0YQaVZr71sEXb
 dBPGphSSQKDEEOyb+SuSZs2EnfXOnIN7esl7dfl6Z0zGeYCpXY1Xn6Q3cB4NZWVduPW6Vq7RCt0
 TeWeUGteZf+yXSTRDo7okbCxy5wbm83boxgTEI2rJlDWSmlIH2K4CN54wHjWXFTld6q1Di1Wxis
 7E8RRl259SWXubN7WVOqBsHp8DfpLSm5KPDm6T6Lmh3my5RrcKIT68MiSkyjsMqlo258KDM2lH1
 qctl7peVpNni4LGHvVac+Dp6QlPcBA2OOkv9tZpf2Pd9iTBmCytE1mKX9w4n54VkA06K4+zj5ku
 K+Vq7cUQgGfX9PBHwRjt/RaLro9R4ztV8bLJKFnajUm3TwUq0fZlHcsHWm8dfkCdPf7cUjvjnWy
 NhAkuMo8BrhVOQOscfrJkZDGtuEXjQGGjh0QPCJxYiPrU22d6kWWJgy5K/yH6Kb1fJs4trplnvx
 OYo422+cCDkaJwi454K
X-Received: by 2002:a17:907:1c84:b0:c2e:4e08:19b4 with SMTP id
 a640c23a62f3a-c31a9a28c7emr1865146666b.3.1792088336879; 
 Thu, 15 Oct 2026 11:18:56 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:18:50 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Maciej Kucharek <qchcio@gmail.com>
Subject: [PATCH v3 0/3] drm/amdgpu: reset SI/CIK/VI ASIC on Apple boards with
 VRAM at 0
Date: Thu, 15 Oct 2026 20:18:34 +0200
Message-ID: <20261015181837.41690-1-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 08:55:44 +0000
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
load on Apple boards with VRAM at 0.  It adds the same test to si.c,
cik.c and vi.c.

Testing:
- Patch 1 (SI) is tested on a MacBookPro11,5: 4 of 4 S3 cycles resume.
- Patches 2 (CIK) and 3 (VI) are only compile-tested.
- No MacBookPro has a CIK GPU, so patch 2 is for consistency only.
- Patch 3 also resets other Polaris MacBookPros with VRAM at 0, for
  example the MacBookPro13,3.  This is not tested.
- The series does not change Vega or Navi.

Patch 3 removes vi_reset_quirks[].  Andre, Frederick and Francisco, you
added its entries for the MacBookPro15,1 and 14,3.  If you can, please
test patch 3 on those machines:
- MacBookPro14,3: S3 resume works.
- MacBookPro15,1: S3 resume works, and a module reload after S3 works.

Changes in v3:
- VI: remove vi_reset_quirks[], because the new test replaces it
  (Alex).

Changes in v2:
- Add the same test to cik.c and vi.c (Alex).
- SI commit message: cite only the MacBookPro14,3 quirk as the same
  cause.  The MacBookPro15,1 quirk fixes a different failure.
- Code comment: add the iGPU condition.

v2: https://lore.kernel.org/amd-gfx/20261015095713.20560-1-qchcio@gmail.com/
v1: https://lore.kernel.org/amd-gfx/20261014192030.10611-1-qchcio@gmail.com/

Maciej Kucharek (3):
  drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
  drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
  drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

 drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/si.c  | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c  | 29 +++++++++--------------------
 3 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.55.0

