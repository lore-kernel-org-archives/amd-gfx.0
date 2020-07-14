Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D45EC433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204FF223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnoxOJzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204FF223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1E06E5D4;
	Tue, 14 Jul 2020 18:24:15 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038EA6E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:14 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id o38so13587709qtf.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fsk7NJPPK8Jn1MFS6p5DTJsHxPztFd5+8JWKw43xKw=;
 b=rnoxOJzh7PP048/RuHgK4tKCiUIfGPXnyNUtt20it5nZUGj5we8WuuXQ+cXW5U+XBz
 82PV/DgATKbI1x5UT2cy92dbqm5Y2XiANi4CYG0Lu/S0fkXoRjpalmWCQkCCIioXguEG
 nB7lfrR85HDn2JFh3rhnKMHSJYYv6+tuGTngCADdgI+MYGI72LOusi8fFHtawSx0nJN2
 2NIK4Zg4zn6mj7O/fm60KzdlPu9BIKZxBtG4I16a8Q0ZtiBL7Jqi0rGAePI2xdO0jriE
 D6XXgRzfEJZmZ049ggdp6zj3CPWCQC273O7DFTckvWAxKiZU2etiMmIZDU/PTFQhzCCF
 zJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fsk7NJPPK8Jn1MFS6p5DTJsHxPztFd5+8JWKw43xKw=;
 b=EgxmJcxQlSs9Uu9USYmMnnfnqKcFq81rOvxgmg0bzb4ypDEgkKvjvDv1ca2X7nW95j
 Alcv9zZYJ1vlnckdckfUsMzEYyWoGgsiwqHnhEWUUiIL106/fEDJjLkihqRZEZ+kLKPY
 8OMj5rU/UKWD0GRwHY9kkIHtvYI5xkeD4+XjR08TMhGg4DKZUDC2WdDc+updT2t304N7
 yZqlTXjIY1Bi4n51zjBk96XMyu+beoAsdZTOqOt8DlYbuqzweeHVS3Dh9lepGsXuL+SN
 Jy98o68hZaP3DifYN2Gxqj2+ZMXOTrs9wfPVKNcSue/OR+dHZfyvG+lx7149ub3fei62
 4PFQ==
X-Gm-Message-State: AOAM530VU8mfxBcAbDz9yhihUj0w1hD6hg71SWIwRkRys4iUq8QXybJ3
 vibxcHpBi++TDrxpDN1QLAdCdSmp
X-Google-Smtp-Source: ABdhPJz0M/TPWMRTQZ4QpykI2h7gtxGWxU7ulo7tlA2T7221aVBa+l0QPPf37xI7xda2KTPa5pgjJw==
X-Received: by 2002:ac8:48c9:: with SMTP id l9mr5809413qtr.203.1594751053004; 
 Tue, 14 Jul 2020 11:24:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/42] drm/amdgpu: add navy_flounder gpu info firmware
Date: Tue, 14 Jul 2020 14:23:14 -0400
Message-Id: <20200714182353.2164930-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 724886afb980..99ed9cbfefcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1633,6 +1634,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 		chip_name = "sienna_cichlid";
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		chip_name = "navy_flounder";
+		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
