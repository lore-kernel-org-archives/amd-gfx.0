Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A44DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 09:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C6D10E675;
	Tue, 22 Feb 2022 09:09:58 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2375F10E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 23:07:55 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id j2so12570040oie.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6K9hTlkQ4IuC5xmGrUgF+6JWWC3ZwdH6QIpXtFbws0g=;
 b=i8nDzUKLL6rl5JY+BgTbruX22+HINcIGZojgBS+l7EOBSHob/zHQxoKz/rkvzwl1jO
 9YerA5fgBQmJIwTTi6k6UHdz3vUY/X7TxrmsFdswjaJbTgyLqJYI5TRX4qblgzViScrE
 PM5cu952Udn/bV639XnzW7WxzS5pw5h71bhAk2VA+wSZYd8ywnLmyqjJNTB7kHbHm2Te
 USBLUR7yd5Wut+NDPKADvaLjbtefpgdz6NqyJjBGvJve/L7j1nmkE584JVP6jdVZSwTf
 8rBzO56Zby58yhsJAUY/Kg0InO05ihiGpt7p5+9yROxNHi66vc2JfpCRRZYA/vCReqlX
 /rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6K9hTlkQ4IuC5xmGrUgF+6JWWC3ZwdH6QIpXtFbws0g=;
 b=7Pvf7vW1u3xHtBAj0pxXWfLXA1VgOaId86qwf+pgxtkwo6CSaAp219wPvFmV98DANV
 0rtHvnvarZo+2olmkNsrhVg0ua71SuJQ159MzvDJiz1faV1xPPTcdoiZdSvCabRWIDwk
 h15zpvOCE76+4FIz1axUxXPONwKM7EVb56B86V00uC6B1f4vr14E9mB0eY+WFCsdTJPq
 sJqFpTQRWy2nql5aKrtaeysqlAILxWul0aaGRPfjwY6P2aar+YstkN9XZRY7dR7V0N+L
 VxjW2CUJoiBPMRdIwRUrvWY8v/EfdHPPLvbQGj6Qv6C1MKP6fw8/ON/yGv+QXSKFfGq6
 dMAA==
X-Gm-Message-State: AOAM5300ga1I2tb+K3NkvYwDJJjcGssxPqUIreu5rbDih3ZFt5DtokHR
 9KY8itcbrRLs/YkRoPp8Rbo=
X-Google-Smtp-Source: ABdhPJxCfUmPQeVI/1O8188AGEILF/Zou414Etg6LvUSSQRojMCG4adcQooCcGCcPJHByAYwAym59g==
X-Received: by 2002:a05:6808:128f:b0:2d5:3582:f5fa with SMTP id
 a15-20020a056808128f00b002d53582f5famr650923oiw.283.1645484874334; 
 Mon, 21 Feb 2022 15:07:54 -0800 (PST)
Received: from localhost.localdomain ([189.78.255.5])
 by smtp.gmail.com with ESMTPSA id z4sm6142794otu.24.2022.02.21.15.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 15:07:54 -0800 (PST)
From: Magali Lemes <magalilemes00@gmail.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc: Fix missing declaration of
 [en/dis]able_kernel_altivec()
Date: Mon, 21 Feb 2022 20:07:41 -0300
Message-Id: <20220221230741.293064-1-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 09:09:56 +0000
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
Cc: kernel test robot <lkp@intel.com>, siqueirajordao@riseup.net,
 Magali Lemes <magalilemes00@gmail.com>, sunpeng.li@amd.com, maira.canal@usp.br,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, linuxppc-dev@lists.ozlabs.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, mwen@igalia.com,
 alexander.deucher@amd.com, isabbasso@riseup.net, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When CONFIG_PPC64 is set and CONFIG_ALTIVEC is not the following build
failures occur:

   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_begin':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:61:17: error: implicit declaration of function 'enable_kernel_altivec'; did you mean 'enable_kernel_vsx'? [-Werror=implicit-function-declaration]
      61 |                 enable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 enable_kernel_vsx
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c: In function 'dc_fpu_end':
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:89:17: error: implicit declaration of function 'disable_kernel_altivec'; did you mean 'disable_kernel_vsx'? [-Werror=implicit-function-declaration]
      89 |                 disable_kernel_altivec();
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 disable_kernel_vsx
   cc1: some warnings being treated as errors

This commit adds stub instances of both enable_kernel_altivec() and
disable_kernel_altivec() the same way as done in commit bd73758803c2
regarding enable_kernel_vsx() and disable_kernel_vsx().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 arch/powerpc/include/asm/switch_to.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 1f43ef696033..aee25e3ebf96 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -62,6 +62,15 @@ static inline void disable_kernel_altivec(void)
 #else
 static inline void save_altivec(struct task_struct *t) { }
 static inline void __giveup_altivec(struct task_struct *t) { }
+static inline void enable_kernel_altivec(void)
+{
+	BUILD_BUG();
+}
+
+static inline void disable_kernel_altivec(void)
+{
+	BUILD_BUG();
+}
 #endif
 
 #ifdef CONFIG_VSX
-- 
2.25.1

