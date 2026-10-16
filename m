Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D69CCF2C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EE910E18E;
	Fri, 16 Oct 2026 14:21:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E15789C29
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 14:21:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 85CC6601F0;
 Fri, 16 Oct 2026 14:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BCBCC2BCF4;
 Fri, 16 Oct 2026 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792160492;
 bh=ZSNqtsaQT9QggSLA44InTOkMSiMsEJSY5gdy1zypyi0=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=B3D/5N1Wr1Kl+h5gRlwDXcO1zQJ3LSkDKpG1EcP8wERIOwe4HkW/FPmNonEyMY1tf
 lGJNFsArqHfM/D8T2EXordSbKQ8h2QqywOPaESbP5GgYvjsnjsHgJAh2Mj/SD3eviP
 8aMIEAqZmFhBkTzzPtdodq1k+ZE6L2wF+EpIU64dpOpyfHzZx7twSEJHwHN2kupPyU
 94jIZLb9GO9q/RzbVsC/BMrz54GceuOllcyE4fzof6lEbZNK7it8A050F9HVezI6Wf
 WvyXSgjy2HLmQA6s3EousaZWwsZ9dN94VwAcDs53HxW8OyzF79C9NuwrqTZsgPKqwA
 9fFwdTZ4m77kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 25D82CC6B38;
 Fri, 16 Oct 2026 14:21:32 +0000 (UTC)
From: Sergey Armodin via B4 Relay <devnull+dolph-in.yandex.ru@kernel.org>
Date: Fri, 16 Oct 2026 21:21:31 +0700
Subject: [PATCH] drm/amdgpu: reset VI ASIC on MacBookPro14,3 with Radeon
 Pro 560
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-amdgpu-pro560-quirk-v1-1-3e5d3fe5ff29@yandex.ru>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJp5ESvYpxge0AgxHq1BoSw
 t2psnyL/1dIrMIJrtUKyl9JMk8FdKrAD+3UM0ooBmusI0MO21foY8aoc+0MvrPoE5tQU+jIW3e
 +QCmjcifL/3q7H075MbL//FawbTv/umMMdwAAAA==
X-Change-ID: 20261016-amdgpu-pro560-quirk-7d51df1c2649
To: amd-gfx@lists.freedesktop.org
Cc: Sergey Armodin <dolph-in@yandex.ru>, 
 =?utf-8?q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?= <fbeltranmillalen@gmail.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792160491; l=2939;
 i=dolph-in@yandex.ru; s=20261016; h=from:subject:message-id;
 bh=b/4Sa1kJnEP0nzwhtI/lrU8C3VwvseWg4I5tjfSF6S0=;
 b=s7FoqV2n3ug2q870bLxKdP533iO39HM0D9UWSUMw33b4WpDKYwQifJvmgeJFtRgxQJs3yTvt/
 80qh79j2e3jCja9hXnzZHh8uIZcLq2SmjwUG26kfYq/Zsg+MhH9ASHV
X-Developer-Key: i=dolph-in@yandex.ru; a=ed25519;
 pk=/5fxDh8OvR0Ye0oOUwYm3G0Ly9E3XSQq8qmh+T+is1g=
X-Endpoint-Received: by B4 Relay for dolph-in@yandex.ru/20261016 with
 auth_id=1212
X-Original-From: Sergey Armodin <dolph-in@yandex.ru>
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
Reply-To: dolph-in@yandex.ru
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sergey Armodin <dolph-in@yandex.ru>

The MacBookPro14,3 also ships with a Radeon Pro 560 (Polaris11,
1002:67ef, subsystem 106b:0179, revision c0), which has the same problem
as the Radeon Pro 555 added in commit a22e5e4f2ebb ("drm/amdgpu: reset
VI ASIC on MacBookPro14,3"): the firmware leaves the framebuffer at MC
address 0 at boot (MC_VM_FB_LOCATION = 0x00ff0000, 4 GiB of VRAM), while
a re-POST through the VBIOS ASIC_Init table places it at 0xF4_0000_0000
(0xf4fff400), so a GPU reset, or the S3 resume described there, moves it
under the driver.

Add this variant to the VI reset quirk table.

Tested on a MacBookPro14,3 with this Radeon Pro 560 on 7.2.5 with
commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1") and
the 555 commit backported (the kernel also carries distribution patches
and machine-local workarounds for its BCM43602 Wi-Fi and T1).

Without this entry the framebuffer is at 0x0000000000000000 on every
boot, and a GPU reset forced through amdgpu_gpu_recover fails: after the
re-POST MC_VM_FB_LOCATION reads 0xf4fff400 while the driver still puts
the GART table at 0x0000000001B00000, the IOMMU reports DMA read faults
from the GPU, and the SMU firmware load fails ("SMU load firmware
failed", then "GPU reset end with ret = -22"), leaving the internal
panel black.

With it, amdgpu logs a PCI CONFIG reset on load and the framebuffer is
at 0x000000F400000000 after both cold and warm boot.  The same forced
GPU reset completes ("GPU reset(1) succeeded!") without SMU errors or
IOMMU faults, followed by two "ring gfx timeout, but soft recovered"
messages, and the GPU came back from 14 S3 cycles (4 lid close,
3 systemctl suspend, 7 rtcwake) with no amdgpu errors; the internal
panel was back after each lid-close resume.

Cc: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
Cc: stable@vger.kernel.org # 6.12.x
Assisted-by: LLM
Signed-off-by: Sergey Armodin <dolph-in@yandex.ru>
---
The kernel logs of both forced-reset runs (with and without this entry)
and of the S3 cycles are available if they help.
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a0435fd..ac26641 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1398,6 +1398,7 @@ static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0179, 0xc0 }, /* Radeon Pro 560 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)

---
base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
change-id: 20261016-amdgpu-pro560-quirk-7d51df1c2649

Best regards,
--  
Sergey Armodin <dolph-in@yandex.ru>


