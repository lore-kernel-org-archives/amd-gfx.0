Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C62CC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75CA10EC6C;
	Thu, 20 Apr 2023 14:29:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F36510E0A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681999146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m4/JuEsZscBS1QEjsB4TfQCsUwFo0JrhZtOzYqZKIzY=;
 b=FkDwRI9riU3gqUI/siICUB8tBA0mcKXRPB7GVCSqGoawFBG29zFUKPmjst1bWX21GYlza1
 pbJ71+H4pqCJrb5izMl2C759pIxfra6ywDd1c2UqzkLQo4mHmOhSmSSIHtBlIDG7Jg55+P
 yrr+wgzvWH7vhy1Q1ON3A/bqGrtQc9o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-bTTkCIDpMGyRYDEG93m_dQ-1; Thu, 20 Apr 2023 09:59:05 -0400
X-MC-Unique: bTTkCIDpMGyRYDEG93m_dQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74e04fcc695so58177285a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681999145; x=1684591145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m4/JuEsZscBS1QEjsB4TfQCsUwFo0JrhZtOzYqZKIzY=;
 b=iH2w2Z8ZlYRfIgDnlnyD/cynTFFz1FohEYadPABGDoBTlppj5qBhrkKxhIKQsJ8ugR
 XffGiOPUz79w8OUBvKTP1psjkfv3ec0a5oTAI+U8jYlHX5tbkX5o+lOB5g6ewM16+Fh/
 mAPHDS+kSp67Dl6Rx3kKCHpvZJiLwDZzgBN0dWcYS4PIjfkbtJyYS0nulJLkyeI84Oka
 Y+DdLrmOLoq8Kn7GuwglhXn3R8ZgnnbTq6LfBob2YB3RPcTmyF7IoGOCAjAkvZs3c/jH
 ZxJP4SnvFJKIckI9/KKtSjoJNwUHDbpxB/72sgwwb7V39bu3sqRvwIh7Dex63Nymf0d3
 zGyw==
X-Gm-Message-State: AAQBX9fY6QLYJrVG4cv43nTyyUU25AYlmo9ekrlXj7D7uX7UWGutUMYZ
 NUaD9By3tkUQoyP78s0tCFPCG/em+mhFBiK/S/5munvPupBelg7SG3y6CCkJk1IXhxIXvwFotFS
 1DggWq9JLqcakNASnJ1Hzwl/vNA==
X-Received: by 2002:a05:622a:18a9:b0:3e6:35ec:8a9f with SMTP id
 v41-20020a05622a18a900b003e635ec8a9fmr2276780qtc.59.1681999145140; 
 Thu, 20 Apr 2023 06:59:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZWmwkSKjotOboNJvMVMnZ/90aKxEW+jnR3KliISrG82OxoHSKFPujRz0mheXYNaiH8sWDnrA==
X-Received: by 2002:a05:622a:18a9:b0:3e6:35ec:8a9f with SMTP id
 v41-20020a05622a18a900b003e635ec8a9fmr2276737qtc.59.1681999144890; 
 Thu, 20 Apr 2023 06:59:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 z42-20020a05620a262a00b00745f3200f54sm430905qko.112.2023.04.20.06.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 06:59:04 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Alvin.Lee2@amd.com, Jun.Lei@amd.com,
 qingqing.zhuo@amd.com, Max.Tseng@amd.com, Josip.Pavic@amd.com,
 Eric.Yang2@amd.com, aurabindo.pillai@amd.com
Subject: [PATCH] drm/amd/display: return status of dmub_srv_get_fw_boot_status
Date: Thu, 20 Apr 2023 09:59:01 -0400
Message-Id: <20230420135901.3889747-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Apr 2023 14:29:49 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:
  In function ‘dc_dmub_srv_optimized_init_done’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:184:26:
  error: variable ‘dmub’ set but not used [-Werror=unused-but-set-variable]
  184 |         struct dmub_srv *dmub;
      |                          ^~~~

The return status is never set.
It looks like a call to dmub_srv_get_fw_boot_status is missing.

Fixes: 499e4b1c722e ("drm/amd/display: add mechanism to skip DCN init")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d15ec32243e2..36d936ab4300 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -182,14 +182,23 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 {
 	struct dmub_srv *dmub;
-	union dmub_fw_boot_status status;
+	struct dc_context *dc_ctx;
+	union dmub_fw_boot_status boot_status;
+	enum dmub_status status;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
 
 	dmub = dc_dmub_srv->dmub;
+	dc_ctx = dc_dmub_srv->ctx;
+
+	status = dmub_srv_get_fw_boot_status(dmub, &boot_status);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error querying DMUB boot status: error=%d\n", status);
+		return false;
+	}
 
-	return status.bits.optimized_init_done;
+	return boot_status.bits.optimized_init_done;
 }
 
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
-- 
2.27.0

