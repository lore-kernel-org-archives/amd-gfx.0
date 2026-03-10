Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8631FD2D7A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CAB10E73B;
	Tue, 10 Mar 2026 12:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="SoumYKRr";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC54589A94;
 Tue, 10 Mar 2026 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143730; bh=BZdZKAXpTi8WGNXN2fiMzetM/noYEEE0kBAl+EzvNzY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SoumYKRreG/py1h5mHUmmcf5MNhTA0IWVyuhwVtBQDsB3zjLeFZGYUpB8dmBQK885
 8zp8zOhWINTswvz/8Dpb4sCQeiaM8MeFzyXeYCejwMtQ6v6ZBfw76CXpeNeZINOkH+
 x4yAkEpkA6PhpBthZhWBkiZQBi3374fgQonGrnmw=
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006b1-2367-7f0000032729-7f000001ca68-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:29 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:27 +0100
Subject: [PATCH 61/61] file: Drop unlikely() around IS_ERR_OR_NULL()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-61-bd63b656022d@avm.de>
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=BZdZKAXpTi8WGNXN2fiMzetM/noYEEE0kBAl+EzvNzY=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAamjmr2YH1D6NIv4bWMOoOgSjqlNw1AkTnEk
 z4zblGz3BCJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGpgAKCRA0LQZT0ays
 24dkB/9I2IH2WVtNuAbc4pN8k/UWfzfn7IBk5SYldKbG4a3vAt2BCQOMLY6KBgHTT+SL+30NFE0
 eqhT72U09tRMvyWUaeodCCSJABvxL6Unq+gQWaX6/P1+X8+kVa/Fa0v8GHtiYqiopntbOsAjZBr
 sS0Bbptn0GuVsdoMNke4vQD0A9rA3xW5nWOgDpK1U8FjC9uaXfz1Bfzn2XQq/Me0fZtcNCJpNlZ
 qjNOLRSw3BZGb7IPqnUrcjHIuuNd6dYbs6wYHOgbyiibTqQrj6tp6SnoDxHnYU93V6GBh2lMfHt
 9qSEynUbZNIYOnoqI2ah9KWLVKFkMsTrddsdp5JisL6z2WZS
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-96CB1E1F-80912B69/0/0
X-purgate-type: clean
X-purgate-size: 1022
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

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of unlikely().

Change generated with coccinelle.

To: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 include/linux/file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d3155685cdbb89f546f26ef66e3e1b4..007b9b9d365a052c1c056e12571eaf4f8ef5a45c 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -163,7 +163,7 @@ static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
 {
 	if (unlikely(fdf->__fd >= 0))
 		put_unused_fd(fdf->__fd);
-	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
+	if (!IS_ERR_OR_NULL(fdf->__file))
 		fput(fdf->__file);
 }
 

-- 
2.43.0

