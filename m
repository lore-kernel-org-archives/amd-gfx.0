Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449DEFD2D79
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92D710E752;
	Tue, 10 Mar 2026 12:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="vpe0akhP";
	dkim-atps=neutral
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C3510E713;
 Tue, 10 Mar 2026 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1773143729; bh=xxm4pfrA8vpE+55Nunaq1/3InG5TW5+yUEKOnNPaCHE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vpe0akhPijy+fdFGsJlWa9KadgjO2UW3S7CfTGj2Nb6xgJuadPCv9jJW3GCcgmmDp
 NsscICFVG30n95MZjrlzYTppWlcYdN0G1O633y0snTb7dDyj/NfP2miiuKsPdNfmP+
 vAwjLimypqw9PSgx5KgoEmL24wgMu4NPRFNkUtuM=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006b1-e21d-7f0000032729-7f000001bb0c-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:29 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:26 +0100
Subject: [PATCH 60/61] Input alps: Drop unlikely() around IS_ERR_OR_NULL()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260310-b4-is_err_or_null-v1-60-bd63b656022d@avm.de>
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
Cc: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=xxm4pfrA8vpE+55Nunaq1/3InG5TW5+yUEKOnNPaCHE=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAai8jb0hbCBoPmYA/prWl4PUOkbFdhFm9gPO
 hWtVu2rtPaJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGogAKCRA0LQZT0ays
 28GYB/9rclpgBQgsqGF0yAXWM/97auTunqqLKOGDeyV/S4nC7HDn1d4UqQoeaSmUw2DOYO4u7t3
 FPnU9VUXE2nXM5FAQLfpjYhH7CG3jEkW4klm33iXRLo1nkpvx8klWZbYR7PMwPnVZTnxKNJmzgZ
 kL0ECVGQ0EahRXa5TL96qA0Z3YR0RjsX+MNWafES7VGwl+HS5Artyl+8jg+/p0RFHayhxpHi2hi
 Ftz0Ut7BpqlmrXUo0TzIlFmAGFe7tZCdcMDr5ii9ECIA4sGLz4jBK2uiDVL8YFZ25Y3k7DF6RQV
 m+hUB3KTG86705bO5a0t2DamRuiInU805Ah5rzh9tCueh4HO
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-373CFF2F-EC21F89B/0/0
X-purgate-type: clean
X-purgate-size: 1265
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

To: "Pali Rohár" <pali@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f3d3b6b4e02d798e75a90333ace72a367befdbac..82e11efad7f7f02b4aaefde340f9b71fa792cf6b 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1482,7 +1482,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
 		dev2 = psmouse->dev;
-	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	} else if (IS_ERR_OR_NULL(priv->dev3)) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,

-- 
2.43.0

