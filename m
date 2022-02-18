Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73477C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB2510F123;
	Fri, 18 Feb 2022 15:25:35 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBAB10EBA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:58:12 +0000 (UTC)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2d07ae11460so36398147b3.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=URNN4JDAS2rJK/SsmuwfW0pd7j7Yza7iayBlpkhGFLc=;
 b=EBGQU4gek4jI2VHo57UusHs/wBde2oMRrnCtCmvYuBRGiig/b+r8mypTt+pMzb70F+
 eui57kZL0D/54jmqGjPrmsWd0gCCmIddw38zfF9pbmDCKJlhAdFSEiYaxzW6GmFO49Yu
 4RQaHEq87uRGZVdETZV+edy95vXUKC33J17G8BU6e3WahR+nFckwqtWorOj6MMQ/YOvZ
 gl2yOMRPf+OuLe+iUFLdgXX42Wt9q4ukxNsPwtPrcQkgE8bBuiANjsLn54dhHyW0HIeI
 DXlmWM+XgNzhDKEWkVKRqXrhzm++Sv6+QkC4DoMdzkdUGfb51BKxH9jR5kdWZcjQ0pa2
 EbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=URNN4JDAS2rJK/SsmuwfW0pd7j7Yza7iayBlpkhGFLc=;
 b=oNxa/qhvguOxeztUCjMkOl+uVqmapxKOLOQ7H75FxfrM253nMRLzwSYUWVjNZLtLLq
 3s0GJCXIVjWA5xHMpOhOSr3F00/RGtbcaNtGbt4zEbTnGyGfiFMJDu/s0KsfW+c37xMg
 iJfnhmkvdT7wIybO7NuAA33Sng7ID81ftaQbeEBUV5f/DrkzSW+rUyGIIniLbzrMFy3x
 bd2ABnEAWwMhY+cnj7EEy52msgg3D1svuHlSeS/Exd83KdKHC81yyUJkABLPJfMWqmoa
 79VVIJy5LK6TdYy45nc7UtZXgvwbYIl977RnNlzFqvMvNo5erMYyV4GZiOaBuJAvTCVx
 DTVA==
X-Gm-Message-State: AOAM532c7zP+O+XsZzV8xZqGqCrkBEvvC5S2cdsaPTsFLTWZb+MmrFtG
 eURES6SBSYOXwHfdNW01ZDcuY1xDFY7q5w==
X-Google-Smtp-Source: ABdhPJzkXNI0mIB4QIL1eB63wzi9+92ViwlJdKnUh9PGSnuYSdteX3Ps478m374ivFv5Kh1qd98wF5JtWHxwTw==
X-Received: from slicestar.c.googlers.com
 ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:f611:0:b0:2cf:aa3c:ab17 with SMTP id
 w17-20020a81f611000000b002cfaa3cab17mr658303ywm.410.1645171091604; Thu, 17
 Feb 2022 23:58:11 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:27 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-5-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
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

There are a number of Kconfig options which break compilation under UML wit=
h
allyesconfig.  As kunit_tool's --alltests option is based on allyesconfig a=
nd
UML, we need to update the list of broken options to make --alltests build
again.

Note that, while this does build again, it still segfaults on startup,
so more work remains to be done.

They are:
- CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
- CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache
- CONFIG_BNXT: Failing under UML with -Werror
ERROR:root:../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function =
=E2=80=98bnxt_ptp_enable=E2=80=99:
../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:400:43: error: array subsc=
ript 255 is above array bounds of =E2=80=98struct pps_pin[4]=E2=80=99 [-Wer=
ror=3Darray-bounds]
  400 |                         ptp->pps_info.pins[pin_id].event =3D BNXT_P=
PS_EVENT_EXTERNAL;
      |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~
- CONFIG_PATA_CS5535: Needs MSR access (__tracepoint_{read,write}_msr)
- CONFIG_VDPA: Enables CONFIG_DMA_OPS, which is unimplemented. ('dma_ops' i=
s not defined)

These are all issues which should be investigated properly and the
corresponding options either fixed or disabled under UML. Having this
list of broken options should act as a good to-do list here, and will
allow these issues to be worked on independently, and other tests to
work in the meantime.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/configs/broken_on_uml.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testi=
ng/kunit/configs/broken_on_uml.config
index 690870043ac0..546482b0bc4d 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -42,3 +42,8 @@
 # CONFIG_ADI_AXI_ADC is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_PAGE_POISONING is not set
+# CONFIG_VFIO_PCI is not set
+# CONFIG_INFINIBAND_RDMAVT is not set
+# CONFIG_BNXT is not set
+# CONFIG_PATA_CS5535 is not set
+# CONFIG_VDPA is not set
--=20
2.35.1.265.g69c8d7142f-goog

