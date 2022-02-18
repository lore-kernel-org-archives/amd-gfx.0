Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67FFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED6010F11D;
	Fri, 18 Feb 2022 15:25:34 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACED10EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:58:07 +0000 (UTC)
Received: by mail-pl1-x64a.google.com with SMTP id
 c22-20020a170902849600b0014eff3fd4bcso3230138plo.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 23:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=j0CZufvSyGMkqIs03zWz3SOrzF5QkxrcKJyKN+3F6DU=;
 b=DnvEEpeLGT7C5chE/iFqLg1oxG7vGRUWbZEgwmeFp5/uBfxwHZ4WKh+ARdG0TZevOn
 S8V+kTXByBAPADfiBUy8qdYWtbxpPbyjuahrqoW5Y+jx4Ka3f2ix+XYBDPLErajyCmGc
 WhsTS3GeBvKSmJU24IW3jl4Eitt4U8L46TqvxavzKDg0M7fao2jGz5UhpxjTsQKN5dwB
 3pcbMsevsoyi2PABytqDtcFfB+sDZF7+PctoUcSKimkNVz6fqrYV63g+hOOmzfycxYWD
 GeQLc8fwAtfGcxSsJO76HpBCHUOMxWvmRj95XUCGtf7GYhrl8yZF035C7XUfj6JbBWPA
 VPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=j0CZufvSyGMkqIs03zWz3SOrzF5QkxrcKJyKN+3F6DU=;
 b=A2lG59Dlhte1UDac3wxVk0w38drE0OA3JHoYaXek+P37n7rqgfxVICD80BZ+Dk1rvF
 fDKI5GnuPbP/gz5T4tqv9BbxUDZ9uSLo+z7ienKB/xHrfyVNmRysO5Sf5PWBCyadQZ0P
 SSE3Idw3OX7oiwkvaafqsNbGd2IbFSddGnSe45dtfZzDHALbdMfquMw1BoA3GmWdsjRq
 wNopCN4U+8pJaFMOlu0ML8Mt3mwWeakHvXrTccC8G298TuyVFgHj48volk4MMJEq7wfa
 paDQ1Es/rf9gyLiXRKQ37kOwIghVEg6Rgm27Ffa9SyapIHwe585rA/hysv0cqObhs4Pg
 Hgkg==
X-Gm-Message-State: AOAM533mFBTBlVoWMP425v2ufiw262vevvDj62NqGl5fvcz/b/CzIM0+
 3hb78kzYUOMjWyZ9xl4SID5UcNsH4S0ImQ==
X-Google-Smtp-Source: ABdhPJweI7iurcA3Hbq+nFlKuGo4v8cSMtTOOIZv9Y5cBs/yQBBEnAM5KLK3GgPSvT5VxuN+hAiv//qPBNXQEg==
X-Received: from slicestar.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:581:b0:1b9:b85e:94df with SMTP id
 i1-20020a17090a058100b001b9b85e94dfmr7115153pji.195.1645171087194; Thu, 17
 Feb 2022 23:58:07 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:26 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 3/4] IB/qib: Compile under User-Mode Linux
From: David Gow <davidgow@google.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Brendan Higgins <brendanhiggins@google.com>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 18 Feb 2022 15:25:33 +0000
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
Cc: David Gow <davidgow@google.com>, linux-rdma@vger.kernel.org,
 felix.kuehling@amd.com, x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The User-Mode-Linux architecture (with the x86_64 subarch) defines
CONFIG_X86_64, but doesn't expose the cpuinfo_x86 struct (instead
there's a cpuinfo_um struct).

In order to allow UML to build with allyesconfig, only check cpuinfo_x86
on non-UML architectures.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/infiniband/hw/qib/qib_wc_x86_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_wc_x86_64.c b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
index edd0ddbd4481..76fef1321c26 100644
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -146,5 +146,9 @@ void qib_disable_wc(struct qib_devdata *dd)
  */
 int qib_unordered_wc(void)
 {
+#ifndef CONFIG_UML
 	return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
+#else
+	return 0;
+#endif
 }
-- 
2.35.1.265.g69c8d7142f-goog

