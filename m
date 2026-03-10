Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E16EFD2D70
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FEF10E72A;
	Tue, 10 Mar 2026 12:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="PKx4gVlk";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F01A10E713;
 Tue, 10 Mar 2026 12:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143726; bh=MCi9bfMt/yjRjpkUd1ZhwbiaE2CmX7FKcN3LCeZC+s8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PKx4gVlkKTdBK4hC8DhkZHv6XjY3aXLFzpRRf+9yfpJ7sETH73wJIPUWVun5ApODc
 fB1HpEzfhSmPsza3W/UlEsW+FK27FdFsyHgYe+IbnAc85JpgiLO0UqynRTi7RRWY3c
 Qcjq/1RWaavgSPFWfIRpI/rqChIvo10IblUQ9PGA=
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ae-2367-7f0000032729-7f000001c98c-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:00 +0100
Subject: [PATCH 34/61] arch/arm: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-34-bd63b656022d@avm.de>
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
Cc: Russell King <linux@armlinux.org.uk>
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=MCi9bfMt/yjRjpkUd1ZhwbiaE2CmX7FKcN3LCeZC+s8=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZJPXZg3WsXcrZtjOff8m1jvG6yKXz3axEvS
 kboSQL/SpuJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGSQAKCRA0LQZT0ays
 2zfACACzyLECzgi3MrIMlJkcwSfYhn2m+PRIL8f9uOY3XlWqWmweHlYuZj3OMlVlJtGjvYSQaMR
 9+D2tmynuqJf309fIXDWVkgzjy8866w+a/UJmSXv/T4izax84D3f8LghtIzFi7mZ97slccnBaIH
 bYp2esZnYrGMRYLzsh/aOQvmQdhErxNZysqZJWPMzNnDfK6XoXYg2wPfHrL2waLBmLBd1ruAh8/
 q/1mTUtEwi8tnMzF9vKrDxFY8VrHUkQh/DKxepIobrtB7u/NL1zHZyVzUjIKrp3fP30IB0/fbFP
 nBUcDJnBx61wdRtaxbBVJBgZihX6FfH11PRkPQUNc/WVeaiP
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-8AC99E1F-6B772227/0/0
X-purgate-type: clean
X-purgate-size: 927
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

To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 arch/arm/common/bL_switcher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index d1e82a318e3b22bf6f54e9a8d5366ddc7a6e44ca..46cbb5caf9f17a22a7c42e4254cb68c6cdebc4e4 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -628,7 +628,7 @@ static void bL_switcher_disable(void)
 		t = &bL_threads[cpu];
 		task = t->task;
 		t->task = NULL;
-		if (!task || IS_ERR(task))
+		if (IS_ERR_OR_NULL(task))
 			continue;
 		kthread_stop(task);
 		/* no more switch may happen on this CPU at this point */

-- 
2.43.0

