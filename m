Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5253C6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393B78922E;
	Fri, 29 Mar 2024 11:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="EnDEqTQY";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D8B112331
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:47 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-6ea9a616cc4so1340479b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697087; x=1712301887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDl3drvCV8mQminB8cd0FWY5ZeQD5iRDfGVHISUC3N8=;
 b=EnDEqTQY4Ff0HTDkyc0sTaBeSzG7VtShinq5vxpVnJGpvGIKzLDALbdlp58ZUJgo4S
 WSeFyLptq3cuuUMMHMtP2rlQnhPbNfGxSF5dKr/jztP5zq0fKmmHrGpP+I92kNl++iPD
 JQUQaqsu/0lIpUw7CeLRZZZTDa/Oj2bAaEkj3hTf+tjtLNuf+hBZkz+aSBrO7erP2AeL
 XY+aUBIvSzY5fPDcJNa8dDjT78qfg0Qp+xGFcmA1U6SRV6tXFVf4eRfTZubCd4LGFnIo
 DzlhjLJnSxnkzYeCgpZDcDF1r35ikovDJZQu9ChGDlsiWlQgHAfDHwwCL50mYG3ufNC/
 AAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697087; x=1712301887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDl3drvCV8mQminB8cd0FWY5ZeQD5iRDfGVHISUC3N8=;
 b=byNWfr5gyunAVIU7JF2GEMhl+aHo70x6DK08yeMP9XXul0imswp3/a2IdoRMGspbiv
 4I+lHKENZ5AaaN3r2xNwTq7lYS14yBJiM5iHv88kbe1Zu/c1Flvl2itcwVYGqaNbkemZ
 WjMizdkj575CuiCBtbQxfPorcehhpU1NJAU3rF59WHmGN/dBv0TOrYvpCLuhqGct4xRV
 hn6psSvvdPvypExWjZFg+iBlwCVfpULDo3i6N/NO9RyZ92K10ih3op7PswtPFqDtilme
 CJP2AOTuD9/FtbfAqXeUuuKKaLzDPh7QJgblG+Rw1sb/aILh0zTRrekQMZk68g5GoGYW
 XX1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvS4tc/tPxocWD/w8UMdLQtXY2FUg+iE1/nYaavNqVV1ZQztUlDXqdCGh2bUKA3L9mN7Nu/ngGywNs234bS0M2zXPQcrFxGh/XzUubAA==
X-Gm-Message-State: AOJu0YxMwoIwN8w8VkMs5l8Pd5sausRtoUOoIfT0GhHEBD1NqWoaBg/Z
 /OFGVEATCPAQEF6DMBv9JOuiAbxRNNV8eKtk5ETDQZuzQjA5kY9s4sIfjK3Bhjw=
X-Google-Smtp-Source: AGHT+IF+FV+uMuQXtJuoJZDILLDfziMVBq/KUES3aiEW6OY8o73iJ5kWmw5SdybGS1gXP7gvN622NQ==
X-Received: by 2002:a05:6a20:394d:b0:1a3:647b:b895 with SMTP id
 r13-20020a056a20394d00b001a3647bb895mr1477372pzg.47.1711697087156; 
 Fri, 29 Mar 2024 00:24:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:46 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 03/15] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:18 -0700
Message-ID: <20240329072441.591471-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Mar 2024 11:32:14 +0000
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.44.0

