Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470AAFD2D69
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9504910E723;
	Tue, 10 Mar 2026 12:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="xKnBkg56";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087F710E716;
 Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143728; bh=sIEabNGpfTtaNmN5jdtpnoUYPpUdFMe596BbQNmq6Ew=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=xKnBkg5622xaCaFlGwFQ3bswFSgdcTVbCDHB3k8l65KFt6Ule9kyi3QR8HfOXuW5L
 MKbugm+H1wq/E04UmM1cfkP9mUjiEZ3Ws7yzlEjYYTJHZ64lqewOtbO15JI10WApm1
 CoPFx+DZxYAYXylALiT4nuOog37Am7eL2zh2ct4Q=
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006b0-e21d-7f0000032729-7f000001bae4-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:19 +0100
Subject: [PATCH 53/61] hyperv: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-53-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=sIEabNGpfTtaNmN5jdtpnoUYPpUdFMe596BbQNmq6Ew=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaKQPK6RykE0QE2RJD5htL1ZvRNh+zI6jTmu
 VOYpL5CXyeJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGigAKCRA0LQZT0ays
 29fzB/oCGLAMazrUNiEmwKr9nq0MNT5XdhZH3wkJWE4yJ+UKMd35Xi9PPSb65qZMk+N4uMiZj2H
 T6Td1MreYgfIRLT7kTJk/n1BuSWWFP55nfvFZFjjhY5aoonvuH6RpMC7x9+9tNKQtJ7ne+y8JUp
 qmDL3C1GxXXFNKbwYmtZySONDO5gXmgMnGjDdckVFucnIkQYwHywWpIrPTZv3zUS9k6qS6F4HLs
 npSrcLjQ++9xnCfmtppGIezlVuCbkGtNbWVtJ6RuDAqRXXu4e1NER6f7pIlU/5AgYfpLOxyecDo
 JLi+d7tyzKhXU/h5ql9oJc0IZPZktOy6eLbVlaElpfc4YFhD
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-95676F2F-E8C255A2/0/0
X-purgate-type: clean
X-purgate-size: 1148
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 12:41:15 +0000
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

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: "K. Y. Srinivasan" <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/hv/mshv_eventfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index d8471546e6a0c7e6eca933c640459f1d02152cb2..24dff7a498ac9c3edd31f4c9bc2f23729ba2a6ce 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -516,10 +516,10 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	if (irqfd->irqfd_resampler)
 		mshv_irqfd_resampler_shutdown(irqfd);
 
-	if (resamplefd && !IS_ERR(resamplefd))
+	if (!IS_ERR_OR_NULL(resamplefd))
 		eventfd_ctx_put(resamplefd);
 
-	if (eventfd && !IS_ERR(eventfd))
+	if (!IS_ERR_OR_NULL(eventfd))
 		eventfd_ctx_put(eventfd);
 
 out:

-- 
2.43.0

