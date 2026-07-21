Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515F7C531D1
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257AB10EFDC;
	Thu, 23 Jul 2026 07:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=deq.rocks header.i=@deq.rocks header.b="bMVW1R3C";
	dkim-atps=neutral
X-Greylist: delayed 337 seconds by postgrey-1.36 at gabe;
 Tue, 21 Jul 2026 14:07:26 UTC
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8400510E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 14:07:26 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: a49af32d-73a9-431b-bd0a-d739e3ebcff1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1784642503;
 bh=VeUZjxn7WyogGHiYtS5M2Fn8omQS8kn+4hN6551NdGc=;
 h=From:To:Cc:Subject:Date:From;
 b=bMVW1R3Ca8BkHAaPDmh8vWXh3uXngA9/DkN0z9ZU7+Lgopge8zLfInTPk8Xps/GI9
 Jvhci5uV95h/Ze+cO9bC27WeZjin0M/tJd5l4fUxoDLpQpEfPAYg+rMt4NgYi/CJXx
 Cy9xYvDVov72flt5nFHd8sVvHLm5fpCidt7yod5/kIF3M9HFopeEvOj6hBzRJ4sMRu
 hgwQ1om0JdPsNSvCi/Zc2G0q4M8JdmACtw6d7AsTxO0575XHcY3mWDfXZmkt7qvKos
 6jKy9lF8oZswGzF0EPe5cIyvNOFb7Mq580XmYPe/SJfxpvuhhDac5yWraH6+WExI7P
 0uCiG2ma4yy4g==
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, me@freddy.us,
 Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Tue, 21 Jul 2026 16:01:31 +0200
Message-ID: <20260721140131.10797-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:46 +0000
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

After S3, reloading amdgpu on MacBookPro15,1 systems with a Radeon Pro
555X or 560X fails while loading the SMU firmware. The existing SMC
register check does not request a reset because the registers do not
reliably reflect the stale SMU state on these machines.

Frederick Morlock found that forcing a VI ASIC reset allows the driver to
initialize again. This patch limits his workaround to the exact PCI
device, Apple subsystem device and revision combinations used by these
two GPUs, leaving other VI hardware unchanged.

Suggested-by: Frederick Morlock <me@freddy.us>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a256320b92f3..320c43143e5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1407,10 +1407,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+struct vi_reset_quirk {
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u8 revision;
+};
+
+static const struct vi_reset_quirk vi_reset_quirks[] = {
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+};
+
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 {
+	unsigned int i;
 	u32 clock_cntl, pc;
 
+	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
+		if (adev->pdev->device == vi_reset_quirks[i].device &&
+		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
+		    adev->pdev->subsystem_device == vi_reset_quirks[i].subsystem_device &&
+		    adev->pdev->revision == vi_reset_quirks[i].revision)
+			return true;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.55.0

