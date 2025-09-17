Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD8CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F91B10E88D;
	Wed, 17 Sep 2025 14:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IVe51Lyf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D22510E888
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z4ledhvkgkNLJIkKfqzD7y0HQPjiocyUpq/BAZYhsyQ=; b=IVe51LyfQriI8Dk29zZuyai034
 /R+ndvj+b6jrxV37L5fHMsw7eYmuf34TFfElv/ECoY/TZSRw8D0o9r4UXa9tKVfPb8E+lbX+L6KFH
 YaSPElqJmfr0fi7Pj8Nx6Lp2FEi5E85Gy1swmAu52ZERbLTHdIJvWErrfMBcBZLUUyZR5RjgDlFEl
 UpO5zwGy9g6GrrscPgEPl6wkLvBObMXyCFQsZ5DqZu+QcGRniD8Vm/vDiGMCTarS7l2BzN6/e1Mp1
 0r0EkO+Uw0VyllO1BsXCaW1ofJ7TG+RZ+arv1qF3eSANgTYBB+u518ohr9CR0Ox0mXP+LnYP980pj
 S3VNuqIw==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYh-00CkfO-VE; Wed, 17 Sep 2025 16:55:00 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 5/6] drm/amd: Move display debugfs array of longs parsing into
 common
Date: Wed, 17 Sep 2025 15:54:48 +0100
Message-ID: <20250917145450.3000-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
References: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
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

Move code which parses an input string into array of longs to a shared
location so following patches can make use of it.

QQQ:
Static inline in a header file is not the best. Figure out a better
place.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 36 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 21 +++--------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 17848ce65d1f..61019e64d376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1804,4 +1804,40 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+/**
+ * amdgpu_parse_buffer_l - parse text into array of longs
+ * @buf: input buffer (will be modified while parsing)
+ * @base: base argument for kstrtol
+ * @delimiters: array of delimiters separating arguments
+ * @param: output array
+ * @max_params: maximum number of params to store in the output array
+ *
+ * Returns zero for no parameters found, number of arguments found (capped to
+ * max_params), or the negative errno in case of a failure.
+ */
+static inline int amdgpu_parse_buffer_l(char *buf, unsigned int base,
+					const char *delimiters,
+					long *param, unsigned int max_params)
+{
+	char *token, *tmp = buf;
+	unsigned int i = 0;
+
+	while ((token = strsep(&tmp, delimiters)) != NULL) {
+		int ret;
+
+		if (!strlen(token))
+			continue;
+
+		if (i == max_params)
+			break;
+
+		ret = kstrtol(token, base, &param[i++]);
+		if (ret)
+			return ret;
+	}
+
+	return i;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index c18c4df6126f..dd6aa72de0c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -78,24 +78,13 @@ static int parse_write_buffer_into_params(char *buf,
 					  unsigned int max_param_num,
 					  unsigned int *param_nums)
 {
-	char *token, *tmp = buf;
-	unsigned int i = 0;
+	int ret;
 
-	while ((token = strsep(&tmp, " \n")) != NULL) {
-		int ret;
+	ret = amdgpu_parse_buffer_l(buf, 16, " \n", param, max_param_num);
+	if (ret < 0)
+		return ret;
 
-		if (!strlen(token))
-			continue;
-
-		if (i == max_param_num)
-			break;
-
-		ret = kstrtol(token, 16, &param[i++]);
-		if (ret)
-			return ret;
-	}
-
-	*param_nums = i;
+	*param_nums = ret;
 
 	return 0;
 }
-- 
2.48.0

