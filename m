Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F52C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4CF10E3FC;
	Thu, 30 Mar 2023 15:31:44 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4BB10E1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zvT9oJ3YH4zrM7prcgD3s2yqWUE0MWwLYPTIfkGrJ2E=; b=fXlvLR1Y1f6aoUnYgiOGrRiNtB
 iMqbEw9CXnf3EvXLtEykZsJslANCV4gERd9eEhaYxX5IohYfSPbsRut9BKYr0DfdywkHENLzaaohu
 AMatn7CReLz6l9WAgQ+bbWgjTHwtByJG+EQZfs5Gt48BMbWWg1rPZD9sGi6WGwlnv+GmoZqozYJte
 m40KBQ6Fyp3lgl+CsEw93cc0+ape8HpRNDhA3XPMnSW4xpJToubMRZ4kCi5xBZn4ZutnWqP24MS6Z
 PhFeVtd1PiNWUksi7hr+To1VKUe7qVLzP5aqnwVcN3aEZq2ZKaOZkiqeyjHVxWepdEmeBhOcrjM1t
 rHbFZYSg==;
Received: from [191.255.122.45] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1phtSQ-001LZv-6U; Thu, 30 Mar 2023 16:40:54 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Fix incorrect comment about Vangogh power cap
 support
Date: Thu, 30 Mar 2023 11:40:45 -0300
Message-Id: <20230330144045.466110-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Mar 2023 15:31:43 +0000
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
Cc: Melissa Wen <mwen@igalia.com>, Xinhui.Pan@amd.com, kernel@gpiccoli.net,
 Lijo Lazar <lijo.lazar@amd.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 rodrigo.barbieri@canonical.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The comment mentions that power1 cap attributes are not supported on
Vangogh, but the opposite is indeed valid: for APUs, only Vangogh is
supported. While at it, also fixed the Renoir comment below (thanks
Melissa for noticing that!).

Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hi folks, this is a very trivial one, just to fix the comments - since I needed
to re-read the code/comments to figure out, I'm trying to improve it here to
avoid others to get confused as well heh

Lemme know in case I made some mistake (even after re-re-reading the code).
Cheers,


Guilherme


 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d75a67cfe523..6460906c354c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3351,7 +3351,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
 		effective_mode &= ~S_IWUSR;
 
-	/* not implemented yet for GC 10.3.1 APUs */
+	/* In the case of APUs, this is only implemented on Vangogh */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
 	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)))) &&
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
@@ -3360,7 +3360,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
 		return 0;
 
-	/* not implemented yet for APUs having <= GC 9.3.0 */
+	/* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
 	     ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))) &&
 	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
-- 
2.40.0

