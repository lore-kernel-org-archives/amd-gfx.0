Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E4C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDD5112D6A;
	Tue, 30 Apr 2024 17:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FjDRTY9D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2593E112D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3szkw2+TvKz7XKqcfu2oQlmT25TkQIY3wYaIa+C7n0M=; b=FjDRTY9DXToYoJuD8KL8mmMkem
 B4l962HnMjrysgHV6/05o/gYd0tu0S10kKem1GKD8v3ObiqeFtcbANkSuvHZvtLyP+eZnUynIGhdf
 qYox7nvUu9jpjnPdA+R4aRXI8rr95JHlGLk4Pb9WCAtB62ww6mKjUPeNAcUs1kTglrdUBQKzO5lNI
 b4783Ai9RCulco3mSy3JHPzROGLoVcp27RElyauWXlZwf5eIk8liBJnFdY5CJi6jtDjXJSra703Y+
 TlYeYwf8MhIckiQkw72gPzllZ1zgD1GNaMGogM26Zto+wypMEri/lThOBZW6dg7j6tbS6vZWA3LMI
 4ER3Hjsw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGl-001sRf-L4; Tue, 30 Apr 2024 19:27:55 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 4/5] drm/amdgpu: Show engine capacity in fdinfo
Date: Tue, 30 Apr 2024 18:27:47 +0100
Message-ID: <20240430172748.61576-5-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

In cases where there is more than one user visible engine of the same type
DRM fdinfo spec allows the capacity tag to be emitted.

Start doing that so that gputop can adapt and show, for example, 50% if
only one of the two engine instances is fully loaded, while the other is
idle.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c7df7fa3459f..a09944104c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -57,6 +57,7 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
+	struct amdgpu_device *adev = fpriv->ctx_mgr.adev;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
 	struct amdgpu_mem_stats stats;
@@ -105,7 +106,12 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		if (!usage[hw_ip])
 			continue;
 
-		drm_printf(p, "drm-engine-%s:\t%lld ns\n", amdgpu_ip_name[hw_ip],
-			   ktime_to_ns(usage[hw_ip]));
+		drm_printf(p, "drm-engine-%s:\t%lld ns\n",
+			   amdgpu_ip_name[hw_ip], ktime_to_ns(usage[hw_ip]));
+
+		if (adev->num_ip_rings[hw_ip] > 1)
+			drm_printf(p, "drm-engine-capacity-%s:\t%u\n",
+				   amdgpu_ip_name[hw_ip],
+				   adev->num_ip_rings[hw_ip]);
 	}
 }
-- 
2.44.0

