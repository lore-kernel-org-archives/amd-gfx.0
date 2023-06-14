Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49893EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 07:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C4B10E417;
	Wed, 14 Jun 2023 07:21:16 +0000 (UTC)
X-Greylist: delayed 460 seconds by postgrey-1.36 at gabe;
 Wed, 14 Jun 2023 02:26:54 UTC
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ED310E3FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 02:26:53 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4Qgq7G623vzBJL9m
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 10:26:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1686709610; x=1689301611; bh=6kTDM7vlftjb630W5DW3qUW1xSe
 0NbOG51vxu+5VB0Y=; b=ecNhXYRvk7voO7rVamgQmRrVpyjRN7y+VjlpwygW+eR
 zuQHwn5YN/lhrKTUOtIu14/50zzu9Zi4mg3gRM/pQCBy4/0Z5XvP91bp3B30hWt4
 SmvoCPkhWxEpCenzPNQ26YGFB7uDh3Z/J9ASxGjsSJILUWEA5Y+0vCemRM0y+w1f
 bHzbEN0zY+O4nE3dDuTrqHLo6tbsUdnI5HX1sSHoWprlfVXy/Q4AGNL0khoWPTxG
 bmFlaVxE1ZjP7F8Vci49FIlyA2qYN7fGhsovKrSXE4dd5eRiAggLvNUGYiOme7kK
 KL8HR4oMVj8C1zsGe+44jxgFAeuU/orFne2z+tkuQdQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AiZxPnQrZUPz for <amd-gfx@lists.freedesktop.org>;
 Wed, 14 Jun 2023 10:26:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4Qgq7G1h15zBJCMY;
 Wed, 14 Jun 2023 10:26:50 +0800 (CST)
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 10:26:50 +0800
From: baomingtong001@208suo.com
To: daniel@ffwll.ch, airlied@gmail.com
Subject: [PATCH] drm/amdgpu: remove unneeded variable
In-Reply-To: <20230614022440.33828-1-luojianhong@cdjrlc.com>
References: <20230614022440.33828-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1ccd72cc9fa4b0f1c5acceef0c21d9fb@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Jun 2023 07:20:53 +0000
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

drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c:1156:5-11: 
Unneeded variable: "result".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c 
b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
index 21be23ec3c79..36aa7657c66d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
@@ -1153,7 +1153,6 @@ int smu7_enable_power_containment(struct pp_hwmgr 
*hwmgr)
      struct phm_ppt_v1_information *table_info =
              (struct phm_ppt_v1_information *)(hwmgr->pptable);
      int smc_result;
-    int result = 0;
      struct phm_cac_tdp_table *cac_table;

      data->power_containment_features = 0;
@@ -1191,7 +1190,7 @@ int smu7_enable_power_containment(struct pp_hwmgr 
*hwmgr)
              }
          }
      }
-    return result;
+    return 0;
  }

  int smu7_disable_power_containment(struct pp_hwmgr *hwmgr)
