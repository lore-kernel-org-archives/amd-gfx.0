Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E440FD2D82
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9FD10E76D;
	Tue, 10 Mar 2026 12:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="P4cFZP/3";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7AD10E711;
 Tue, 10 Mar 2026 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143726; bh=/e9fhAri3fvWicTXaGdDwpg1S0XTbSGg5f30RLJZwGo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P4cFZP/3ySCkqkvFmysB/zTqxbD/PjzdR54YsQWs2B7Ag1WfdJL7tNy9mM+YApj2D
 ndVw5Z3V4gfnNIxLGP9hoQNh4xHTmaffyOwYpsHdTRxcA8+K0XD0gxaMwz/nUN0o0X
 SCmLqyt5cLBWipGIDG9rrJsNtObMa14/gIb9ntNs=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ae-e21d-7f0000032729-7f000001da1e-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:01 +0100
Subject: [PATCH 35/61] arch/mips: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-35-bd63b656022d@avm.de>
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
Cc: John Crispin <john@phrozen.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=/e9fhAri3fvWicTXaGdDwpg1S0XTbSGg5f30RLJZwGo=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZM2fTyCYVfDSlmEmcm8t3ybPKD3MDuGKTUj
 vCjhqZWFOmJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGTAAKCRA0LQZT0ays
 2z2rCAC7oYhghVATpgjsAoGRn4N5/GCkNEQ5d/YNbMHtku5Ne/hNSs0W+K9kYWVkFPm5TlrH0DE
 8/RGH1u5MDT7P37KNp17NEpcRPc+zR1hHTpFzNLygQMhigzbVOt/7U+vGXQh1CXjciuY8j7FckI
 dtMHKNN16hVWRN9J7DdvS7Q09vOysbfuZGn+o8hs1SmUg64a9Ig5/41sPHN38J7SQblPeyGhLri
 3JgxiG8Mz5G70Y5/Rddk73/lgtWO+z4F7ECaPWtfktQ/wSj5ZuFGkTm2dn045+qsqR71gKKNbgQ
 /lgkcaOekPRGDC/jtk9N/uPlc4vBw/GKHnCp8LPegSQzk/iw
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-86614F2F-8EE3A410/0/0
X-purgate-type: clean
X-purgate-size: 863
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

To: John Crispin <john@phrozen.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 arch/mips/lantiq/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 2d5a0bcb0cec156dc5f0daedbdd7c56ff8d62ca4..4ae271a887c39163370d070b49d9e5152a709bd7 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(clk_get_ppe);
 
 static inline int clk_good(struct clk *clk)
 {
-	return clk && !IS_ERR(clk);
+	return !IS_ERR_OR_NULL(clk);
 }
 
 unsigned long clk_get_rate(struct clk *clk)

-- 
2.43.0

