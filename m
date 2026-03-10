Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE74FFD2D6D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8569E10E736;
	Tue, 10 Mar 2026 12:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="arIjqC+e";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659B588E45;
 Tue, 10 Mar 2026 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143729; bh=Zdu+cVQUurUlnC57nYv7WmkJa7Su1n9ZL+7ubRQiCbU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=arIjqC+eOW50ePPRI7IzTKWN2gbhB0tQ9WRbPXDZdH2y8Tl8MVJAS9gxKOCgGSNO1
 MKRth9R9YTwOofMsTkyRe5Kz4PcjK/cLboke0inMKDssNbfSjXTkXB1/ZhuTMFSoly
 YzXp7hvqApt2TDtbnjQwMPLewEHxBbUoVg9XuPpY=
Received: from [212.42.244.71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006b1-2367-7f0000032729-7f000001ca3e-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
 by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:29 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:24 +0100
Subject: [PATCH 58/61] arch/x86: Prefer IS_ERR_OR_NULL over manual NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-58-bd63b656022d@avm.de>
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
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Zdu+cVQUurUlnC57nYv7WmkJa7Su1n9ZL+7ubRQiCbU=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAabkCM/59lsV79Q3PWR22p56JLuGabUpuR4i
 qxQub+ly/qJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGmwAKCRA0LQZT0ays
 2xXOB/9ZPHi30qdJIkWySghqlR16lgaAoi3kyqOX8y681/67uYGL/oYTixO52tnBrjVPqGtMJMl
 /Q1KhfevGkVNYzFAfMrFBpAZag+UIgbv/BCAd+mAYMHmfUSOVrYD15iCyuV/mzNjhjHEufwESj4
 I0XaRrF8IjuTyxoOaAktjvNz5kPAQuNzEBmaZ3v2GCRGsUPgyn1rW2fNRbOhVzN0Q0ZlAeRhTj/
 Qq0svuNBXvGJBVWHLKzaFNv3dtadS6o0vkr1vZsO43v1j0qtJ5bmVxhOhChUZ8M0SvSfZzOtGDb
 woeHnmnHVjGmRuu20BTVhdN6fCN/9hgCBGPx0vI7/S13IInk
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-8448CE1F-1FDA919B/0/0
X-purgate-type: clean
X-purgate-size: 1974
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

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Semantich change: Previously the code only printed the warning on error,
but not when the pointer was NULL. Now the warning is printed in both
cases!

Change found with coccinelle.

To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 arch/x86/kernel/callthunks.c | 2 +-
 arch/x86/kernel/irq.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e37728f7032277a99ffb0e6bb7dfa318660e56a0..6dc45838d8e439e117815b85e2840bb3a6688ed8 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -212,7 +212,7 @@ static __init_or_module void patch_call(void *addr, const struct core_text *ct)
 		return;
 
 	dest = call_get_dest(addr);
-	if (!dest || WARN_ON_ONCE(IS_ERR(dest)))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(dest)))
 		return;
 
 	if (!is_coretext(ct, dest))
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index ec77be217eaf5f558fa73c2ff6cf1ab8953ee2f8..81963909066d72607f58d3e443a21a3b3e701a99 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -282,7 +282,7 @@ static __always_inline bool call_irq_handler(int vector, struct pt_regs *regs)
 {
 	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
 
-	if (likely(!IS_ERR_OR_NULL(desc))) {
+	if (!IS_ERR_OR_NULL(desc)) {
 		handle_irq(desc, regs);
 		return true;
 	}

-- 
2.43.0

