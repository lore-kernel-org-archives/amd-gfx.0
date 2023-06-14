Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9359AEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 07:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B5510E409;
	Wed, 14 Jun 2023 07:20:59 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E4010E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 02:27:41 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4QgpyP3vmFzBJL9v
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 10:19:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1686709149; x=1689301150; bh=+bZIMx7NjUairCzhV4yQ6x1V7oV
 wZZngMN1eFmk00jI=; b=EKUbHYNPDGx3udiEz3qTS3JOB9WSB/x8unwPK3kCOav
 /AKVmW4bqqZ09iI0P51CYUTF+MGSEVaQZnnJeUyk8wsOV5mEnqNARDShWEQJylEc
 rzYhZnTAvL2myUBJINnIxKaQRguw8guQQ1wr//RC0PEIh73mhPDUVBD4Joowzt2H
 cPJsUftYu0aAUchVmDwbIu8PTs5N79NTLGMDw71vvGctb7dx+vi3ErOwkyFYQ1BR
 l5m348D7X8kuWP9PWGYwfy8BJe1Hn/pm7I/LAV4uTjhFHHD+nB5b4ezj3MHcZwcI
 PEpnux4nxBLsB6FUAwqd/jVEwN/vJvdX1aBlXJ80Nbg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cr-MM3gCN8JL for <amd-gfx@lists.freedesktop.org>;
 Wed, 14 Jun 2023 10:19:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4QgpyP0gFczBJL9m;
 Wed, 14 Jun 2023 10:19:09 +0800 (CST)
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 10:19:08 +0800
From: baomingtong001@208suo.com
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com
Subject: [PATCH] drm/amd/pm: remove unneeded variable
In-Reply-To: <20230614021546.39168-1-luojianhong@cdjrlc.com>
References: <20230614021546.39168-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <bfca99db848b8d29d0399566e579bc21@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Jun 2023 07:20:55 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the following coccicheck warning:

drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c:1657:14-18: Unneeded 
variable: "size".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 275f708db636..c94d825a871b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1654,7 +1654,7 @@ static int navi10_force_clk_levels(struct 
smu_context *smu,
                     enum smu_clk_type clk_type, uint32_t mask)
  {

-    int ret = 0, size = 0;
+    int ret = 0;
      uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, 
max_freq = 0;

      soft_min_level = mask ? (ffs(mask) - 1) : 0;
@@ -1675,15 +1675,15 @@ static int navi10_force_clk_levels(struct 
smu_context *smu,

          ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 
soft_min_level, &min_freq);
          if (ret)
-            return size;
+            return 0;

          ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 
soft_max_level, &max_freq);
          if (ret)
-            return size;
+            return 0;

          ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, 
min_freq, max_freq);
          if (ret)
-            return size;
+            return 0;
          break;
      case SMU_DCEFCLK:
          dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is 
not supported!\n");
@@ -1693,7 +1693,7 @@ static int navi10_force_clk_levels(struct 
smu_context *smu,
          break;
      }

-    return size;
+    return 0;
  }

  static int navi10_populate_umd_state_clk(struct smu_context *smu)
