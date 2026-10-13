Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567CCC6B2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F304410FD87;
	Wed, 14 Oct 2026 12:47:52 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319CF10E959
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:40:14 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6715944eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791931213; x=1792536013;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CWZGGdh7JOQ6UqV1gxmMbPkjK0LPv1nbOU26QpmZ10=;
 b=euy1X/o4emQDhM7kbhBc3OacqlLPUOIkj1fXi2jePSt/jsBNzRUeN+7WtvchfnHtfZ
 FccSW8Oc0SWPZZleNchGp2XvcuiXBlAWYfExzCkPaNalcns0Di8CouYg3cFfo1uJ/Ctt
 RpEPe0OKzi5riM+1kdL14d6XwybXqlVYfp7bKN7EDiNS5NI6SDwmsH2q4G23urRJlg/G
 IhRP6YREhYmtmVfzOu+vI5Pk/lBzg4ZB1xWBJE8Z2duWLcytrclyx/A5kYI73xNMxQdo
 72kKI3wqTztgX4Ch/je5ob7jxdJ01HLwU7bvDxu/tcXzBi0O3/MLVRGP5/+LvaAMAb0s
 VmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791931213; x=1792536013;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6CWZGGdh7JOQ6UqV1gxmMbPkjK0LPv1nbOU26QpmZ10=;
 b=bAOou4Rwtp20XU4M9TMKN7bMnN2HcXyn/5sI6U2TSWqNWa6LOhy0LItNUF6xGFws9k
 kLpzaM3j9hxsUIdMf3yfzwk0eyjoYb/0Hcajk5GTW6WyG9bV+eLFrILJsFhWCCJjwdmB
 +hgyvCkoXLM/XOmYbhOMPTzu+R7j4UhoTW3Vtup75Apez2vGp5wNZCmxylTlgbAzFIud
 7Kh+7oZHfKAtcrgQONjaH9CbbcgT+cgPXH3T+UY4JQsV4tt4zQay3g7qd1tfTWF26hzh
 8P/7cAGkmPovUc7c6G1PHQNLenaw+Jli5KfIEXNvr43kr9JBx0EcswM+kMkiV0QgkUrG
 MLfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIE/zvqk1kPyfZTW4lFJhrJqgK/Kgc5Y0KjQgO+5MF5UFBp//7+8jZDk8RVhqN07qFjpexDCM4@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ7M00pgKqaFofQDJxkqcUcST3m9jUMipTnZN4YmSaSzopF8KwN
 OqYdCrjLYFsUgxFfIQkyLLfWV4sRCKe+9aAgxRK/YItwGOTo+R6Wva7zYnBdtJ0pNbWnnHJwOqH
 lxyxOxgFL1Q==
X-Received: from dlak14.prod.google.com ([2002:a05:701b:290e:b0:14e:f9ab:6f83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2309:b0:153:7a27:b89
 with SMTP id a92af1059eb24-16a5ed4008cmr22709999c88.21.1791931212336; Tue, 13
 Oct 2026 15:40:12 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-1-irogers@google.com>
Subject: [PATCH 00/11] kobject: Require explicit initialization of struct
 kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

Clang supports the 'require_explicit_initialization' attribute on struct
fields to enforce that the field is explicitly initialized when an
aggregate object is constructed, emitting -Wuninitialized-explicit-init
(enabled by default) if the field is omitted.

Following discussion at the Linux Plumbers Conference [1], this series
introduces __require_explicit_initialization in
include/linux/compiler_attributes.h and applies it to
struct kobj_type::release.

As Documentation/core-api/kobject.rst notes:
  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed."

Annotating struct kobj_type::release caught 30 struct kobj_type
definitions across the tree that omitted .release:
- Patches 2-10 fix 10 struct kobj_type definitions where dynamically
  allocated kobjects, ksets, or enclosing structures were either leaked on
  kobject_put() or freed prematurely before kobject release (risking a
  use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
- Patch 11 annotates struct kobj_type::release with
  __require_explicit_initialization and explicitly sets .release = NULL
  (with explanatory comments) on the remaining legacy struct kobj_type
  definitions whose kobjects are static, per-CPU, or embedded in devm- or
  parent-managed structures.

[1] https://lpc.events/event/20/contributions/2392/

Ian Rogers (11):
  Compiler Attributes: Add __require_explicit_initialization macro
  powerpc/secvar: Add missing kobject release callback to secvar_ktype
  sh: sq: Add missing kobject release callback to ktype_percpu_entry
  cpufreq: Initialize kobj_type release callback in ondemand and
    conservative governors
  ACPI: CPPC: Free cpc_desc in kobject release callback
  dlm: Free dlm_ls in kobject release callback
  xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
  s390/sclp_mem: Allocate struct sclp_mem dynamically and add kobject
    release
  ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
  drm/amdkfd: Free queue in procfs_queue_type kobject release callback
  kobject: Require explicit initialization of struct kobj_type::release

 Documentation/conf.py                         |  1 +
 arch/arm64/kernel/cpuinfo.c                   |  2 +
 arch/powerpc/kernel/secvar-sysfs.c            |  6 ++
 arch/sh/kernel/cpu/sh4/sq.c                   |  6 ++
 drivers/acpi/cppc_acpi.c                      | 39 +++++-----
 drivers/acpi/sysfs.c                          |  2 +
 drivers/cpufreq/cpufreq_conservative.c        |  5 +-
 drivers/cpufreq/cpufreq_governor.c            |  3 +-
 drivers/cpufreq/cpufreq_governor.h            |  1 +
 drivers/cpufreq/cpufreq_ondemand.c            |  5 +-
 drivers/dma/ioat/sysfs.c                      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |  4 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 10 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  5 +-
 drivers/infiniband/hw/hfi1/sysfs.c            |  2 +
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 +
 drivers/parisc/pdc_stable.c                   |  2 +
 drivers/power/supply/ab8500_fg.c              |  2 +
 drivers/s390/char/sclp_mem.c                  | 73 +++++++++----------
 drivers/soc/hisilicon/kunpeng_hccs.c          |  6 ++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  2 +
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  2 +
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  2 +
 drivers/xen/sys-hypervisor.c                  |  6 ++
 fs/dlm/lockspace.c                            | 19 +++--
 fs/erofs/sysfs.c                              |  4 +
 fs/f2fs/sysfs.c                               |  6 ++
 fs/ocfs2/cluster/masklog.c                    |  2 +
 fs/ubifs/sysfs.c                              | 24 ++----
 include/linux/compiler_attributes.h           | 11 +++
 include/linux/kobject.h                       |  2 +-
 scripts/checkpatch.pl                         |  1 +
 tools/lib/python/kdoc/xforms_lists.py         |  1 +
 33 files changed, 170 insertions(+), 90 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

