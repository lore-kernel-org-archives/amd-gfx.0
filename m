Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC74DC54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B8910E36B;
	Fri, 13 Jan 2023 08:24:54 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FA510E986
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 04:30:21 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id bp44so18366920qtb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pefoley.com; s=google;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p0dBrxhwzNc4hP4DgOVMhl62x5+l/CjTKJPM4tbmqzY=;
 b=YNDyGcfRgEU/Kq6pPTLt+tyMpJK1rsOqsYI8KPXwxZYIamFSE406hKfGFfzeEerv1h
 1xzx78ssO7r5z0r2Y51K2WiuU2PiGpD430GfLFw4iWyqHQaNGETSPhMo9muJQH7N3ekA
 /m1YAwav1xw/rVrcjgfP3J4/vdAeMZVUOrHsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p0dBrxhwzNc4hP4DgOVMhl62x5+l/CjTKJPM4tbmqzY=;
 b=UJOTK64ZmXV1SJM8rCU8DQiIsFt4PC58irwT+0WcUsRF6tvNPLrPgKxoxaTrPgnZyF
 6fT6PxOESp1+ckWcrZCOO9RHLiefyfx4XQZlwYFOIO+ndWUorh0QznxlAO/U07kn1jL6
 RrOZRuM7umKAbB7DZB3o6QbJcQmUQnF61qkixZKn+Y9ONqxR7maKxXjtlH03lZSYw3VX
 3Q1pS+Gha8rrA7E6RK7yJXCY45Wc8mto8tMFNExts6cr6Jvqk4Oz59Hdv9BfzsUsKa2z
 IRcF8BxMgEU5iIlZFiXV7yvuE6Vh8hME9hpjLRJdhmO1v7Gdn0ePv0UqQkljoSWTfRlY
 ybpA==
X-Gm-Message-State: AFqh2krj9afoxh8sz3SkAFRx9ixVjJwlJuUdUHCMq3qTcoWLNvn9wgyj
 HBDBWgsu6ffKZe31ZHQpG+MtJQ==
X-Google-Smtp-Source: AMrXdXvheG74WaJ4gLRhKTBR9pU9wGyMsZMdYlR+zcKAn6f+t5K5H6COUVAnxs9Rkc5f5FnHEAbx2A==
X-Received: by 2002:ac8:45c1:0:b0:3b2:ad80:4ed9 with SMTP id
 e1-20020ac845c1000000b003b2ad804ed9mr2315153qto.3.1673584220004; 
 Thu, 12 Jan 2023 20:30:20 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
 by smtp.gmail.com with ESMTPSA id
 k8-20020ac80748000000b0038b684a1642sm9990711qth.32.2023.01.12.20.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 20:30:19 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 12 Jan 2023 23:30:07 -0500
Subject: [PATCH] amdgpu: Avoid building on UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230112-amduml-v1-1-5e4a0d37de16@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAE/ewGMC/x2NQQqDMBAAvyJ7NmASU2i/UjxszFoXmrTs2lII/
 r3R4zADU0FJmBRuXQWhLyu/SgPbdzCvWB5kODUGNzg/WOsM5vTJTxMu4epD8mNcIrQ4opKJgmVe
 jzyjbiSHeAst/DsP92nf/zXBjh9xAAAA
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673584219; l=1421;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=V3EDjbwX5C9xijdyynQFeDCFZ4HzmtuuGO+aY7RnMrQ=;
 b=GWzJZguVtyMb5JcgRjAen1+KzgR+kAdz0XRNAOYpK4eBDV2AKONnUWnifIZ5CfMcjKl88KPVrRPX
 l03poj0LCnXMaRqG5RRghTm92bCkLke87D+Qsx+OXDh1+y4Pjk0Y
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Mailman-Approved-At: Fri, 13 Jan 2023 08:24:51 +0000
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
Cc: Peter Foley <pefoley2@pefoley.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu driver tries to use fields not supported by UML's cpuinfo
struct. Disable the driver when targeting UML to avoid tripping up
allyesconfig.

e.g.
../drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In function ‘intel_core_rkl_chk’:
../drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:33: error: initialization of ‘struct cpuinfo_x86 *’ from incompatible pointer type ‘struct cpuinfo_um *’ [-Werror=incompatible-pointer-types
]
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In function ‘kfd_cpumask_to_apic_id’:
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2157:48: error: ‘struct cpuinfo_um’ has no member named ‘apicid’

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 5fcd510f1abb..aa0008ff8712 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -3,6 +3,7 @@
 config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI && MMU
+	depends on !UML
 	select FW_LOADER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230112-amduml-565935d34bfb

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
