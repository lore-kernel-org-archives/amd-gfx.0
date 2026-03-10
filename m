Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD9FD2D7E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F1710E75D;
	Tue, 10 Mar 2026 12:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="f0/sH3vW";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0848610E267;
 Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143725; bh=N8ytNu1U36GmBgTPXVAE5/A4s2PfdogY1tJY/l2pxcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=f0/sH3vWUtSFTcrY68KbpDRxIZCYT2hIiwDi3Dik93BJCASdZICq9tTWJ3wgjDVyu
 Jxt6MZXNePDtV4TX0U7P53CBk1XHgvUArUuxPPUnS5hIbTeOVph/0B/h50wymqYtj1
 3T7/WTJwdzfusP5uEpNMFoKuQUCnMWZUuDcbxKoU=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ab-b734-7f0000032729-7f000001bfc8-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:38 +0100
Subject: [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
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
Cc: Jan Kara <jack@suse.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=N8ytNu1U36GmBgTPXVAE5/A4s2PfdogY1tJY/l2pxcM=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAX+MICb9QGDh9sr8xrXC0GI/+3a26bt3TCKL
 Vjl33LfQY+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF/gAKCRA0LQZT0ays
 26n6B/wNFZznKdxnE0qMd12a2eIuA9+krGiImi7olxEd9wOJhsBf8sKwI0E3QgvpW0h7L8AJ/V7
 YwWi88O6oeBiZ3QDKSUmLS/9VlykYZ97N4eOIEzkOMJxki98cx4PncgKAN9Jy63O/7GoZyteCZ7
 +9i83brafUHJWnhfe2dyfef6pp7LRzaCEfdld6TPIgAENhsi0/zr3Pv5hQfjJiyWTNInkfN/Wc9
 eBcVMsl2Zb6jE1xGE/aNpGFG8dNw74geAiaLniVxheZHeJfqzhWkArPaHQ0SYGtCtwd5smdDDAA
 6BFeqEcljgo2LkEM+gZQjogP088dQYDyFGUkwYA0hLFDBEaT
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-435C7A3D-F151BDE4/0/0
X-purgate-type: clean
X-purgate-size: 765
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 12:41:16 +0000
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

To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/quota/quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 33bacd70758007129e0375bab44d7431195ec441..2e09fc247d0cf45b9e83a4f8a0be7ea694c8c2a1 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -965,7 +965,7 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	else
 		drop_super_exclusive(sb);
 out:
-	if (pathp && !IS_ERR(pathp))
+	if (!IS_ERR_OR_NULL(pathp))
 		path_put(pathp);
 	return ret;
 }

-- 
2.43.0

