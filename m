Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F01B103E300
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BE410EB48;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCvpqIyy";
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A53F10E042
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 01:53:16 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d73ccee442so1798771a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773366795; x=1773971595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Je77iCsOrEuw63H4T4mEYukShtJgkZJQLEZYMkoBqT4=;
 b=KCvpqIyylOCpqqTdkCPph5QbuCMofd5Mmn4OOSSTaPiz3xBpv0Tmr0uEIvSZHkpZcF
 csiCpnTDowMVyk3jzgERR3AVjzlZC8+fbpcfsjqYCkFEMSMIUOWGNjVMmhXNtLuDy8ed
 WKRvvH6dlK53SJde4x/uQAoiy+fpnw7svYPLmXqeBQprpD8UyA+prALQ4UqENyWp20km
 o0UEbbY/VnZjxQYcwlVAjSOFv7WNtAEv0lowiac56gv3dOQLLir8ivQeh0N02olB4WVw
 sYssViEWDLIXz8MdZOL9M8+LbMHZYKEOF1FyvyUBeMfU1EfVER4LRzMno/Tr2iL25uyT
 0+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773366795; x=1773971595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je77iCsOrEuw63H4T4mEYukShtJgkZJQLEZYMkoBqT4=;
 b=nZaHv3Ejc9GbRCi2w8KAvPtVG5M+Po1MY68oiIOzsJt4yoBd3HpEeDF0vTKgZXckK4
 mQNjO/tTiWqTw5NVI1ZymHeT2rrVysMp/J+ZB+Wp5x3srlL5LjEYxmwugewGZ8L6tnVj
 qZQfbfi72qCRCSxJj43V22lgBd0Z9AbMLXttyD4RZp1ZyBcuDTjY+4aRVGBuO2HwkWbz
 44gb7ASc8XqLbqhpZ0JwEKO4sgw4VTdByR6fwUdOOayfJpIO6oq0z52WZExT8Wut8qu3
 L4eHfJXffH/18G8zwZrpgP0r6T7M9uiPruGQHVOOSkhzU6G3VNGw1mtElJ/LkXY5xKVS
 Q6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY6BWrefPZngKOLlp0lplh21385kpemL/dCvPk7nnS53GawO88ijoAW+0mvxzhnnqbp+HLvmg/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWzhS3JNynNPpCYKMl3DG1ljwxmJUXFv+84vuNmLsNuX7XPNfd
 tU+ZnTKE3+gE+4fdkR6vbDnzxz0DnFB2p4gc2SMwoX+GNngklbd/9qc1
X-Gm-Gg: ATEYQzwleT/p39RFeslB1+R1jZ5iQxDY8Wg7s+4ACpZ4i0vv3XqttybFOosWLA5wCUC
 9/6hMDOaBiFwf9uVBsxJVcCxT/yw1pn7Ks6oG8VBhW8B3pouEqFGlZowifPxFI3gpmIXpydQcAw
 KfGhHTIDR8ldiuekbu1v2N4jcGmQD6VHD75PCTiFBLGOJQWo/V0FogQ5CDYcJLElKzVWFjiuEnq
 8WpdQyIHuNi2WTNC9DscGMKTFcSorEVERR2Aln0AHqksoPGTVKWn2asZCtNW3VGzJBlCWguML0k
 4xeeYZKA3Jnj6BQvYCfm0ab84fDn5o8MyfWqmdscXiNQ5UDB0sfVDN7N/NtsKaxrKCj8qZhMPXK
 Jj/FPThOLGq2cOxLohnIlo0fHjHXJeNLCgToMC2ol/vJg5Ngxu+zmdAta+hMsXyZdDti+3l96zO
 QAHFAAAKmG5dq/vDFRJ4khPcFJaXqIBzyylgMnqyd54RPC8+lp4sFbAYHgQS7gb9/ATwOM
X-Received: by 2002:a05:6830:4903:b0:7d7:7b6f:d53e with SMTP id
 46e09a7af769-7d782311bc6mr985481a34.0.1773366795315; 
 Thu, 12 Mar 2026 18:53:15 -0700 (PDT)
Received: from Mac (c-76-107-126-43.hsd1.tn.comcast.net. [76.107.126.43])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae68a4bsm5314729a34.19.2026.03.12.18.53.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 18:53:14 -0700 (PDT)
From: David Baum <davidbaum461@gmail.com>
To: alex.deucher@amd.com,
	christian.koenig@amd.com
Cc: lijo.lazar@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Baum <davidbaum461@gmail.com>
Subject: [PATCH] drm/amdgpu: switch XGMI sysfs show helpers to sysfs_emit_at()
Date: Thu, 12 Mar 2026 20:52:26 -0500
Message-ID: <20260313015226.39727-1-davidbaum461@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

The XGMI sysfs show helpers amdgpu_xgmi_show_num_hops() and
amdgpu_xgmi_show_num_links() currently populate the output buffer with
sprintf() and then call sysfs_emit(buf, "%s\n", buf) to append the final
newline.

Convert both helpers to use sysfs_emit_at() while tracking the current
offset. This keeps buffer construction in the sysfs helpers, avoids
feeding the output buffer back into the final formatted write, and
matches the style already used by
amdgpu_xgmi_show_connected_port_num().

Signed-off-by: David Baum <davidbaum461@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 11e56df1d91b..13fc7247fe23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -469,12 +469,12 @@ static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	int i, offset = 0;
 
 	for (i = 0; i < top->num_nodes; i++)
-		sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_hops);
+		offset += sysfs_emit_at(buf, offset, "%02x ", top->nodes[i].num_hops);
 
-	return sysfs_emit(buf, "%s\n", buf);
+	return offset + sysfs_emit_at(buf, offset, "\n");
 }
 
 static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
@@ -484,12 +484,12 @@ static ssize_t amdgpu_xgmi_show_num_links(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	int i, offset = 0;
 
 	for (i = 0; i < top->num_nodes; i++)
-		sprintf(buf + 3 * i, "%02x ", top->nodes[i].num_links);
+		offset += sysfs_emit_at(buf, offset, "%02x ", top->nodes[i].num_links);
 
-	return sysfs_emit(buf, "%s\n", buf);
+	return offset + sysfs_emit_at(buf, offset, "\n");
 }
 
 static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
-- 
2.50.1 (Apple Git-155)

