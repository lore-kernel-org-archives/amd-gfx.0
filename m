Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E05CCA487
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 07:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043418CF8E;
	Mon, 11 Jul 2022 07:11:50 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EA814A05C;
 Sun, 10 Jul 2022 13:29:30 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id o15so2781179pjh.1;
 Sun, 10 Jul 2022 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l6SGihpgssqPHGXdvCDtBHTLs4yyN/NsGv3mxWPlRX8=;
 b=pQtD+Lij3g3SFoJvtPr7sSdNnU+dLwPU9a28z4D2JKBXyQ1B6MgfM3s87Fy49b2LvC
 j6HpnS6zFsIXVLek0tnupD7yRwdUGLLlATDaCzkH7Jhjao+AnI4tefB7vr2W5CcBuSva
 SSbjgMVAI44C/PS0LOoiFAQjUom5BDUOzLSIacI90siXQK0gOlYdGsQQbAcXcoJGG16b
 qiDbtb5gmH2iTN19c8Kf14bZHBHmppxz1qMfOHV7qKiJZmNCLHqmZak6Dpv7Y2LLLIC2
 YUCr1oppifk3i14zaD3MMDIqF91Y4Spx/TpjSj1UWjlTT8DhgkBgGbmZjY5jmA8TUBxb
 87lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l6SGihpgssqPHGXdvCDtBHTLs4yyN/NsGv3mxWPlRX8=;
 b=M8xjIJEE3XhC7WwOH0cM7vRKcQlTaSKo0Ffoo19Ql+sUjF/+/VJWhCdaTiVGheESms
 XsTerhgz8Ki5o9sHtgym4ZAa1xGr8UIS/k6VT1HVKwXWRwL1kCn/tebzUqeKPFuxwn1j
 pqJbHw9SxpL5zDS7jCZ3v0Pibe7B/sJHDvcBgdx5/OCaDQsMr2mDz+0UW48PmWzz6aby
 JZ6Upv583EL66+PzGjtm8N5EbdKOTLDCNkZHnpQtna9mcsNnWm+/RIr30E6rKI6qQqzR
 mpKAbDhMjMDiangsXybr13L1axJra7SGdWwFbNYVsinINmgHFVf3ngXP6F6sTU2J5m3V
 nihw==
X-Gm-Message-State: AJIora+NPcZTsnq0IMh+N+X867djbBuPmqDHhlf+l+AS67fQi5t8GDwU
 oeVKgu55+ONMSpg3BSVyO1R1MQt6qfc8WpxGGKE=
X-Google-Smtp-Source: AGRyM1sE31F8lmvr17IXEq3f/W4RJBFKDGkjunlunig4JtKWK/IHOifRAFTviUvqXTlmAOrvEb+TzQ==
X-Received: by 2002:a17:90b:2341:b0:1ef:819f:dfc4 with SMTP id
 ms1-20020a17090b234100b001ef819fdfc4mr11413503pjb.206.1657459769622; 
 Sun, 10 Jul 2022 06:29:29 -0700 (PDT)
Received: from sebin-inspiron.bbrouter ([103.160.233.217])
 by smtp.gmail.com with ESMTPSA id
 g14-20020aa796ae000000b0052536c695c0sm3001586pfk.170.2022.07.10.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jul 2022 06:29:29 -0700 (PDT)
From: Sebin Sebastian <mailmesebin00@gmail.com>
To: 
Subject: [PATCH -next] drm/amdgpu: double free error and freeing uninitialized
 null pointer
Date: Sun, 10 Jul 2022 18:59:09 +0530
Message-Id: <20220710132911.399325-1-mailmesebin00@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Jul 2022 07:11:49 +0000
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
Cc: Tom St Denis <tom.stdenis@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 David Airlie <airlied@linux.ie>, Sebin Sebastian <mailmesebin00@gmail.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix two coverity warning's double free and and an uninitialized pointer
read. Both tmp and new are pointing at same address and both are freed
which leads to double free. Freeing tmp in the condition after new is
assigned with new address fixes the double free issue. new is not
initialized to null which also leads to a free on an uninitialized
pointer.
Coverity issue: 1518665 (uninitialized pointer read)
		1518679 (double free)

Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f3b3c688e4e7..d82fe0e1b06b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1660,7 +1660,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
 	char reg_offset[11];
-	uint32_t *new, *tmp = NULL;
+	uint32_t *new = NULL, *tmp = NULL;
 	int ret, i = 0, len = 0;
 
 	do {
@@ -1692,17 +1692,19 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		goto error_free;
 	}
 	ret = down_write_killable(&adev->reset_domain->sem);
-	if (ret)
+	if (ret) {
+		kfree(tmp);
 		goto error_free;
+	}
 
 	swap(adev->reset_dump_reg_list, tmp);
 	swap(adev->reset_dump_reg_value, new);
 	adev->num_regs = i;
 	up_write(&adev->reset_domain->sem);
+	kfree(tmp);
 	ret = size;
 
 error_free:
-	kfree(tmp);
 	kfree(new);
 	return ret;
 }
-- 
2.34.1

