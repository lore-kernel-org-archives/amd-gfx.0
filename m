Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B906606A33D
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxM+cKln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96FB10F35E;
	Tue, 24 Nov 2026 08:40:21 +0000 (UTC)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1199610F0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 17:55:31 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so2598223c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456530; x=1796061330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5zbntsnJYF+MluAOcW87nvuR13e90ScUCD9/dIZ65Hg=;
 b=hxM+cKlnIJXfyto1bW91Iw2f8DPvHroG0h7WfHGcz1DCxjNVNXlcFozOKwU02Fze3c
 n2Uj4ee65qjjNV+yLKf8+DLSs75dBdK70kuEE0fWbhmkyCJcR/KcAfPzBjPakcQe9kib
 WkTwh1fLnaqZSvD8UU5LHdK10zdHpif7bD4ot3zNX/f0sSmAL4HnHySDFJHxCM0zehUF
 tbOnoBJ3frVzmd5D2YXgci1PQ8DOSWgRg4isjpTdwIcrtw/4GNYrCRftKkoh7uNJlTZx
 /RgxQcSEVquFH0fauJJVw/q5K1S71HIdwjLKdOY1ZImq1CUpZC6rY6A7l7EuuHeDEmcY
 bCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456530; x=1796061330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zbntsnJYF+MluAOcW87nvuR13e90ScUCD9/dIZ65Hg=;
 b=yVcw/Ontu25GekXOnELzjQloJocVS9VV3Fr2peLco2gB8PpQyrKUuCbXW1W6xCzsiZ
 2ftNvYGLM+YnVvWzt9vc9zK81uSEeCpziNqNMhBhdw3HlIMlK0dSB/Yo71JKPjJrx6ea
 2RPRv3EBNiqSgu5jeU/MsL1TW+Q4y0nBDi7Q2YLNMwaj5pyOtsa97EvVwwFdnb57Vzcf
 fV/12ndTrY4IRSs7GQAf762BSEtBOlw8BeHT+qUqRlK0OX1RcEaYH57CcQi7bl1onRNK
 Xk2zfGlqsE+lavucJ1MhSSAFs5pQQ2V0dI9cNpZ7G34vNOkW4e5Vr3iXVvs+HOePnYDY
 KFkQ==
X-Gm-Message-State: APuU4Z+EjRsM9LZEK+uUTOn3O7sPsKkWX62nDurSOoKEDwHdnoceGWdf
 Gag+2RLvDOU/KEM7pMDHJFq78+35imFJ2pZ+bC5b3vKnpeb9MIEOw93s
X-Gm-Gg: AZFdTZf5hzUSQOSHNwHuhqC/vchwtBqSZpkP66ZkksXVHgO+xZS3C35wMzxaIQ4Nr+R
 sLUJ6oR+CIn1ok9jdF6wKXdHDmEripCJ5VCk/XHkW1vrPf/WZ7Wf1N6PKOgisf3D/IJpnzZn8sd
 SSvSPpSBuN4TCq/GuqjmKgbTkrtVS4L+KE2wbEWf4gdwOKEyMMymaiZZWv60nWXTpHYDU00Ktaq
 g6+fMZvriHNXdKXsHKUmI+r+x+C0rMhgCdPPMwNwrXXJ6HGLil6Xao3LkNIjhFJDHErNS2ok80Q
 n5hRlQQehxbiujpeihPVBlfxgOPxOirf0HdRgIbbah/HS7T3A57iBOoawV+Jiqk9sqfif1fQKd+
 9aHo7taaEpXE0YTNy7O1Ena1NYjoTZh6hHk143/wqfxL+Trg5BE8ua4Us1Y5Z01si5LL//Up3YV
 x2Gv6VId/FwZD32rmboahZKdY9sb2O7W0aLI2X4kfzyLH8U8OXiHNMJhCukU528rXaqblXO0u16
 zhfPyNpCmGikX1fBGqwMETDZJKmr3JucSca9X73mIXu30g6xsFBnuUUNylAK2ehgMjuwBNhdYP4
 a1HsE2AiYPFcJGgxs6adkvlr+yA4GRYNuxdN6knOJqQGM2pEm1zmeQ==
X-Received: by 2002:a05:701b:4584:b0:1ac:9da7:e86e with SMTP id
 a92af1059eb24-1b556908c17mr12515895c88.30.1795456528961; 
 Mon, 23 Nov 2026 09:55:28 -0800 (PST)
Received: from ubuntu ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b562a82b3fsm30885828c88.5.2026.11.23.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:55:28 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, Bokun Zhang <Bokun.Zhang@amd.com>,
 dri-devel@lists.freedesktop.org, Monk Liu <monk.liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix wrong unit of vf2pf_work delay
Date: Tue, 24 Nov 2026 02:55:12 +0900
Message-ID: <20261123175513.2144018-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The delay of schedule_delayed_work() is in jiffies. But
amdgpu_virt_update_vf2pf_work_item() reschedules vf2pf_work with
vf2pf_update_interval_ms without converting it, so the interval is in
milliseconds only if HZ is 1000.

So use msecs_to_jiffies() when rescheduling.

Fixes: 519b8b76f0b6 ("drm/amdgpu: Implement new guest side VF2PF message transaction (v2)")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
I don't have a test environment, so this patch is compile tested only.

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 915e2a069baf..f93d5df51528 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -797,7 +797,8 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	amdgpu_virt_write_vf2pf_data(adev);
 
 out:
-	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
+	schedule_delayed_work(&(adev->virt.vf2pf_work),
+			      msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 }
 
 static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)

base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.53.0

