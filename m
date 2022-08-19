Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ED0C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Aug 2022 22:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C602510E2C4;
	Fri, 19 Aug 2022 22:18:05 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E067410E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=PAcBO42BylxKVptePXYg0sDhCMDFOaqId5YBR1i2H60=; b=ElWWJTFFs7kCRoKeWdUnDYRBYa
 s1nXu3QEAdQutXkJjt9dns3Y7GiyGn9FfA4SrzkuE+t1lgu0ygS1XMrHldXXz+ZyMMt5TtO1eK4Ql
 XGpZrWl5wSKolkWHANKzJ3P3AdQTP7cUgTdWiEqgXLjYfKPX4Rt9Yq9/5l3QNC+38qhlvUKF2aIB7
 ullgyfHIehIb7UairHAs9IwvNm/0aKWtb3CaVQf67oErzbTJPUvoQmoxsFNuqGBezMHhyFaA4PWrF
 3UpFV/sdMDQKag3P+L5IT327wl7BToVSazCU3o0jU1sy00X44lD9yIwfURJFsDzLIfbWinaNL2tHx
 kfXhAaHg==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oP97H-00BbKA-DH; Fri, 19 Aug 2022 21:01:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: export cpu_smallcore_map for modules
Date: Fri, 19 Aug 2022 14:01:12 -0700
Message-Id: <20220819210112.7924-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Aug 2022 22:17:57 +0000
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 amd-gfx@lists.freedesktop.org, Michael Ellerman <mpe@ellerman.id.au>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Randy Dunlap <rdunlap@infradead.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix build error when CONFIG_DRM_AMDGPU=m:

ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

by exporting 'cpu_smallcore_map' just as other per_cpu
symbols are exported.

drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
This is an inline function on powerpc which references
cpu_smallcore_map.

Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
---
 arch/powerpc/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -86,6 +86,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_core_m
 static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_smallcore_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 EXPORT_SYMBOL_GPL(has_big_cores);
