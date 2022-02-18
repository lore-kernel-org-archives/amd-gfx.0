Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA54E10F124;
	Fri, 18 Feb 2022 15:25:58 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9210510EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:57:59 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-2d6bca75aa2so14408027b3.18
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=nLaO1ES61pLgsguF+4DTJU+VhEtdELLQod+MClOiJ5Q=;
 b=QgOXTfy53ySH2/dyIH2l+tfO/OAsBlufB2qIsHbOmsYYbDw2UXU5AZ/cacVONQRqg6
 52vlpV9EeMa5fdyh5Fk8iRKC9yDjyuCi6ouKKXFaMSCHNee6X67xQ9TwArpL1yia/ZUS
 gy91I4oai27l+/Z1dyQgqME/KV9QVE+0bVeo7eOAnRe+Ck/rAQlzQcnfR99Eo3jnpjCT
 9zCAz3b35ihKFwof2zBnUOPq1EfT7CKgi2FOSdBqFKH95ccdlzJo8Bixva0dE2CAued7
 1PVgntfAs6raojL01pZRNYSqcm9LYs/jkwR4YG9Tk4LzOVe4JcVX1TJM9C611NXmkyG9
 QBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=nLaO1ES61pLgsguF+4DTJU+VhEtdELLQod+MClOiJ5Q=;
 b=Vjk7DQazHUPk2DuOclo7qRW72lHc0IG64W4gDGMQJjs2SZGJH4cPyJFw95OfnOoJ0j
 MwkUkWSZ70qKuVBeR6fzCi6zdZcf95ydWIQRlkUOnKPYabHzTY1GDiwi7gn+GgNAVsCs
 lUEhzR4L12I1BFXHOv1h26qEV7U+rL+MqPx1Acq3ye0qqKOhgFR39RGdyL6fye1PelyV
 fW/oZAEriaaKes/wqivUAicLY117T/0rJyYlt3VTT0BphMCXX14Rrep+1SV8g4V/W4Ea
 yCwTpRJqr7zO2qR1T9THC+X2xq7lJiE9HBb6WgTegK9fyvaBGLJqLqIxlhult0OFBuCI
 sOEw==
X-Gm-Message-State: AOAM530ia1K7yl1zHhLImhdkl+uSGUEM368mk/fmS3apLTEnsOXbW2zJ
 nFB72MeFUOnp9jnMcBUJw6D/qmZfhccT3w==
X-Google-Smtp-Source: ABdhPJy2Cw5Ad+CWrEChO3m15k6rfDvFDIW8eMR878jYte+bmMTWDNc8tAipvJmzYUhsBJaIzCB+wr+3RPHBUw==
X-Received: from slicestar.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:8543:0:b0:2d0:2d5c:c07f with SMTP id
 v64-20020a818543000000b002d02d5cc07fmr6684543ywf.111.1645171078671; Thu, 17
 Feb 2022 23:57:58 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:24 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/4] drm/amdgpu: Fix compilation under UML
From: David Gow <davidgow@google.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Brendan Higgins <brendanhiggins@google.com>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

From: Randy Dunlap <rdunlap@infradead.org>

cpuinfo_x86 and its associated macros are not available under ARCH=3Dum,
even though CONFIG_X86_64 is defined.

This patch (and discussion) were originally posted here:
https://lkml.org/lkml/2022/1/24/1547

This produces the following build errors:
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1556:9: note: in exp=
ansion of macro =E2=80=98cpu_data=E2=80=99
  return cpu_data(first_cpu_of_numa_node).apicid;
         ^~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1560:1: error: contr=
ol reaches end of non-void function [-Werror=3Dreturn-type]

../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function =E2=80=98kf=
d_fill_iolink_info_for_cpu=E2=80=99:
../arch/um/include/asm/processor-generic.h:103:19: error: called object is =
not a function or function pointer
 #define cpu_data (&boot_cpu_data)
                  ~^~~~~~~~~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1688:27: note: in expans=
ion of macro =E2=80=98cpu_data=E2=80=99
  struct cpuinfo_x86 *c =3D &cpu_data(0);
                           ^~~~~~~~
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:7: error: dereferen=
cing pointer to incomplete type =E2=80=98struct cpuinfo_x86=E2=80=99
  if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
       ^~
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1691:23: error: =E2=80=
=98X86_VENDOR_AMD=E2=80=99 undeclared (first use in this function); did you=
 mean =E2=80=98X86_VENDOR_ANY=E2=80=99?
  if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
                       ^~~~~~~~~~~~~~
                       X86_VENDOR_ANY

../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function =E2=80=98kf=
d_create_vcrat_image_cpu=E2=80=99:
../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:1742:11: warning: unused=
 variable =E2=80=98entries=E2=80=99 [-Wunused-variable]
  uint32_t entries =3D 0;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 9624bbe8b501..b1e2d117be3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1682,7 +1682,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id=
, int *avail_size,
 	return 0;
 }
=20
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 				uint32_t *num_entries,
 				struct crat_subtype_iolink *sub_type_hdr)
@@ -1741,7 +1741,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_ima=
ge, size_t *size)
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size =3D *size;
 	int numa_node_id;
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	uint32_t entries =3D 0;
 #endif
 	int ret =3D 0;
@@ -1806,7 +1806,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_ima=
ge, size_t *size)
 			sub_type_hdr->length);
=20
 		/* Fill in Subtype: IO Link */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 		ret =3D kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
 				&entries,
 				(struct crat_subtype_iolink *)sub_type_hdr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 948fbb39336e..b38fc530ffe2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1552,7 +1552,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumas=
k *cpumask)
 	first_cpu_of_numa_node =3D cpumask_first(cpumask);
 	if (first_cpu_of_numa_node >=3D nr_cpu_ids)
 		return -1;
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	return cpu_data(first_cpu_of_numa_node).apicid;
 #else
 	return first_cpu_of_numa_node;
--=20
2.35.1.265.g69c8d7142f-goog

