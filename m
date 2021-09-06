Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39299C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D995B6109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D995B6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9021B89CE2;
	Tue,  7 Sep 2021 07:18:32 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E8889919
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 09:43:06 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AC3F3F302
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Sep 2021 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1630921385;
 bh=XD25p+R3q7wLkzAA9yB9q7yknzjb1YZmhH5xo8GDL6c=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=SaPV14dgSvLc1/dQFpASkBEAFRbgd0l6io+4KtliYU05/ViRXUUKFUbn3Wb3VaX9t
 g5V5hTVAaPFWItd2XC977ZqwYeisMt8+GdXr+jaYMSGuOBs0AwjaWa45jDT0dHyAgl
 X38Sgh53kapmfHhoJnP6ZUb8O3YrDFCWx1CjYVNuotia+qNEV5egzmXKN4f933H9js
 AkXUBW6D3Bvl+WsqjSm5X1Ifl8MrJmRWDTtfGkJvX6yicpC+KuxrNvUeIOGkofNgO5
 DGfqKIAj5q11/zvnFK+z9TKAaWiZz1/i2JNqi4p5+YwskgtdzAhFgAJz/VcMFgSK+v
 +6ktOQb5JZn7g==
Received: by mail-pj1-f72.google.com with SMTP id
 mh10-20020a17090b4aca00b00196c3691d66so4261825pjb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Sep 2021 02:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XD25p+R3q7wLkzAA9yB9q7yknzjb1YZmhH5xo8GDL6c=;
 b=GewlZ+fjpmXej58pYKwrRd4m9omrshQx81K520Riyg5NxTRMb39YvJxm/Xug0w1i1L
 HRI8NjIaevcRQ2JIdLo6RzqaWbi7nYohMGZk9tx+7syM3tJ9gCxl9pUbKJMXqSRjsNkn
 arCRhNHU1ZyN94C2/O5pKY6Lg3xnvS/PFZEwThJGU1wqfFeaPTtEZ/qKsOzQMC86AkDI
 HILahycZuCUsH0Lyojx7NBp3oBxAmU1tHOBWZvZKmra/smtnJJjRrRrePvJOdgwxRwry
 CPJSxencr1b9yTldHitp38RG5td/V3qVcBX2CtRSUYBELjfZxNe3ILiuXRj+Wepy0dd5
 8JUQ==
X-Gm-Message-State: AOAM530CnofSpJ/T+SYHlUxGlLWUvQxfYH3YrOyOxCvFPgW0qDNIPwtE
 Qr+0JQ0pCpvZIrcKe8qM3tWCzGuiq2Q9R566xg2g5JHqer3GEivo8waN9ZEU7xmyMrI+wxw9tBG
 Bl8AzOLUzEStI1NdJf76Sp9U3rMD50G+NT1xmdXGSKHQ=
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr11388875pga.427.1630921383743; 
 Mon, 06 Sep 2021 02:43:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh+XmQvhizq/V7wU2cvsxmdwnIZ93QEevu4lh7JSfDKoEnJz6OhEAs67CNhzzSQdaxpP2kdQ==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr11388852pga.427.1630921383373; 
 Mon, 06 Sep 2021 02:43:03 -0700 (PDT)
Received: from canonical.com
 (2001-b011-3815-77ef-015d-33ac-b72e-e12f.dynamic-ip6.hinet.net.
 [2001:b011:3815:77ef:15d:33ac:b72e:e12f])
 by smtp.gmail.com with ESMTPSA id y3sm7163203pjg.7.2021.09.06.02.43.02
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 02:43:03 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix the compilation error with arch=UM
Date: Mon,  6 Sep 2021 17:43:02 +0800
Message-Id: <20210906094302.2135745-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Sep 2021 07:18:31 +0000
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

Config with arch=UM and would trigger this compiltaion error.

  In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:92,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_debug.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:23:
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In function 'intel_core_rkl_chk':
   arch/um/include/asm/processor-generic.h:104:19: error: called object is not a function or function pointer
     104 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:27: note: in expansion of macro 'cpu_data'
    1742 |  struct cpuinfo_x86 *c = &cpu_data(0);
         |                           ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1744:11: error: dereferencing pointer to incomplete type 'struct cpuinfo_x86'
    1744 |  return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
         |           ^~
   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1748:1: error: control reaches end of non-void function [-Werror=return-type]
    1748 | }
         | ^
   cc1: some warnings being treated as errors

With arch=UM, can't get x86 type and model,
so just skip the x86 cpu checking.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b3dc549986eb ("drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform")
Signed-off-by: Koba Ko <Koba.ko@canonical.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c           | 3 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cfedfb1e8596..e2e4205dbdd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1675,7 +1675,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 	return 0;
 }
 
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 				uint32_t *num_entries,
 				struct crat_subtype_iolink *sub_type_hdr)
@@ -1734,7 +1734,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
 	int numa_node_id;
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
 	int ret = 0;
@@ -1799,7 +1799,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 			sub_type_hdr->length);
 
 		/* Fill in Subtype: IO Link */
-#ifdef CONFIG_X86_64
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
 				&entries,
 				(struct crat_subtype_iolink *)sub_type_hdr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 98cca5f2b27f..2a8fed2b9f01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1549,7 +1549,8 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
 	first_cpu_of_numa_node = cpumask_first(cpumask);
 	if (first_cpu_of_numa_node >= nr_cpu_ids)
 		return -1;
-#ifdef CONFIG_X86_64
+
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 	return cpu_data(first_cpu_of_numa_node).apicid;
 #else
 	return first_cpu_of_numa_node;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index e7803ce8f67a..c39e0e6ca057 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1738,7 +1738,7 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 static bool intel_core_rkl_chk(void)
 {
-#if IS_ENABLED(CONFIG_X86_64)
+#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
-- 
2.25.1

