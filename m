Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9572EE9DE6D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7505310E776;
	Thu,  9 Apr 2026 08:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="kdVbDMLy";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE8510E138
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 00:05:23 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-50d2945e6adso4952111cf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2026 17:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775693123; cv=none;
 d=google.com; s=arc-20240605;
 b=XCGIdAEMVi1NeHV6oNJaLBYPyZm8ZQBualNzOWz4PomWOURTvU3WjD0MvtvAn5wod8
 qc2kyM2RGvJ0t9lMuZuAAb+SgIeppyShUFmdOkWLYpLFVeEvghzaPfO9xCYFmnfeSsV2
 gKVDTz+2Y3E0xBEzBlpsAZKGbdWZRhymshCHsQDpVvAKUR7fVRsyLR7veEB/Y2qygncV
 O77aswylC3PdAKdYKrOY0BCl9CXP0CNUyuc0B63JcXS+EDAY97ETS5N89ZTAWGeSkfl8
 m93iQ7IDKq8QwAkxaQ1LuYK8wGTpBUyM3cW9nF9PYVNX+mKpj5d++o5lxz9hYTAqeuQ5
 W0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=d5Le/5THFWE6y5V0G24EA1XqfjwC/vACRAr6s3UaP0k=;
 fh=LYN8rUkjKrk8P/z4hxTLJgSk8ZFtrFPhcLjEY5H8VoM=;
 b=BD95z03BYjby0IvbwGtfMjZp0GY/oWteIhyQ7p+nLd2TMDGp4LOOFG1TzOVJk99sDk
 eIKzmoU/1kH0yQVy1zXfeolREw3bXA6u1tfPalSyQhbxyN4fE3/fq9svp0TgLHTopMnf
 YtRzLlb1TLrmxne9qeNyrRujJ2MnOfd3RnEVXrOQL5/+jeO87kxdoJAUKNvj9CPU6yZy
 rAwcMhQ6neGLkJZJxEVVPHBrfFtcebqOzaR0O9k/hdLl/WmaCdNYfjbjUmM9j6R8V+3P
 rF+9fiHfiDbhvsw3ccoV+EN4rt1y7+10R6OhJvPZXAQMK1a3W4KtpVomw8KlfF4U+5Wl
 TA9w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775693123; x=1776297923;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d5Le/5THFWE6y5V0G24EA1XqfjwC/vACRAr6s3UaP0k=;
 b=kdVbDMLy36E2OCLZOUExFcBg2YnHJBg/n7NMuAyfsqDK4E4h8qyO5O5Fadj56DlpqI
 atjS3HTcOQpCw/GjhY388bGrLG/EwlSVWcPzvOzaUlFMZahBajomP2szBmLrE4/XDDOw
 h7Sn0qdYU2i7XdljH6mn8IwMMKnVGaTCEVs8Xyz+Ye3LbUZvaXueFvm2EG5iMiLyWX16
 rCtP3zU4VDF+R/yAzsic+mR/fjYmzcETXZuEdmRBDxSd266J9he75CfUz8+AdADE4oJV
 1iEzGjc6rzBP666h+j7QRbr/MGH168LZY/luDWRQEj90midhkRIZAnfThjJxtYPxIfKd
 BhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775693123; x=1776297923;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5Le/5THFWE6y5V0G24EA1XqfjwC/vACRAr6s3UaP0k=;
 b=cUkQc/r33fWc+HDXijbcnAND9QiMafmvedwPeNO0hitVU8FpTwDIBozoaYBPizYyUm
 ti2eCjyMSy9pIBeMGzFWeXAVGs3yrJZWN8oU9sT+nlyjGFXO5sa8fB4tWeqbOlLGsMaP
 Yk8x8JuoWWuGGrs1lyGvNhUveWACQLok3XZec2oHyP/0f7V/vbbcchOIG1LbJ/gRHiMJ
 UDuyTQ9Z8DNy2Hx09RYCQDVMYrtSja37cD2BSCxWvfJ0zDVr/ijtKSRRt+4PFl6Q1iof
 qXt2vAV9XStcTOfNvVt5/ARZFnri7GvS2Rokm4M+v2J6eRIen61UhA2izkk/bkt6UX72
 Pexw==
X-Gm-Message-State: AOJu0Yz+yAuAKduwGKO+5BXji95Ir1/2daBlmSfGMdx6GtJbJ4IE2z6z
 CAxGfyP8zyvVcgQOjMsN20tALaaIu5HCSfdouDyM7JAazqbXn3N8oz9UtbxTpqronZ15MEWIkit
 qaNPRgZH9MbDpl6EEHBJaO+RliGggjeylz0Li5MQrxJ/+LXOy51WxeSbvMJdF
X-Gm-Gg: AeBDiet7L6aE3neULoqCvliy0488l7iVkYhHs2gtRgABlx5PA4bGo+TwUGocgJjrLHd
 FwyxBozmG7dR1U7HXKjfQN8WMDelVM4iFT4aaMHu84AqkVuxTtOIR5hLqcRbgGd+tTbtI5DQuuH
 WwMGG7iT+6l8cfUE4gG2O6yHYhUWexF/vz28S/66Khk5IFpszzVwlbaAz8RtpPQKz7HBP8QL90v
 wmQpkCCExPesIH/pwDM1TLth1JaxiNLhxvh8mIBSSm0M1KnxfN+id380tYH9jK07QA77DUhsR5q
 c2jR
X-Received: by 2002:a05:622a:110c:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-50dc21329e1mr24569581cf.13.1775693122679; Wed, 08 Apr 2026
 17:05:22 -0700 (PDT)
MIME-Version: 1.0
From: Geramy Loveless <gloveless@jqluv.com>
Date: Wed, 8 Apr 2026 17:05:11 -0700
X-Gm-Features: AQROBzCxvCql-bYU3BcPNR_bl6Gf1i6iBkbe2arlUlSKV_Nw1rExdNXQsUwaQKw
Message-ID: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
Subject: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU reset
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 09 Apr 2026 08:45:39 +0000
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

When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
Thunderbolt the TB driver receives no notification and the tunnel
stays up while the endpoint is unreachable. All subsequent PCIe
reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
triggering an infinite reset loop that hangs the system.

After MODE1 reset completes, check whether the PCIe endpoint is still
reachable using pci_device_is_present(). If the device is behind
Thunderbolt and the link is dead, walk up parent bridges calling
pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
inside the dock. If recovery fails, return -ENODEV to prevent the
reset retry loop.

This also causes the GPU fan to be at 100% and basically when it
happens and you are not there, you now have a GPU with fan at 100% and
cant reset it.
I wanted to notate some other things I am finding sometimes before
this adventure of patches to the kernel and amdgpu driver.
Sometimes a crash could happen in the drive and then the GPU fan speed
hits 100% and the air is hot coming out without any workload, other
times
I have seen it have barely any fan speed at all and heat up more than
it should at the fan level its curently operating at. These are things
I have seen with this gpu in a TB5 dock with the driver and
instability. I'm not sure exactly whats going on there but I figured
since im communicating with these patches I might as well bring you up
to speed and supermario has been great help throughout me trying to
get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
USB4v2 dock!

It seems to be finally working with bar resizing after my kernel
patch. Which allows you to safely release a empty switch bridge at the
device end.
Then it rebuilds it afterwords with the increased bar. This was done
on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
branch with my patch here.

https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u

Thank you!

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 31a60173c..91d01d538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
/* ensure no_hw_access is updated before we access hw */
smp_mb();
+ /*
+ * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
+ * endpoint but the TB tunnel stays up unaware. Detect the
+ * dead link and attempt recovery by resetting parent bridges
+ * to retrain the physical PCIe link inside the dock.
+ */
+ if (!pci_device_is_present(adev->pdev) &&
+ pci_is_thunderbolt_attached(adev->pdev)) {
+ struct pci_dev *bridge;
+ bool recovered = false;
+
+ dev_info(adev->dev,
+ "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
+
+ bridge = pci_upstream_bridge(adev->pdev);
+ while (bridge && !pci_is_root_bus(bridge->bus)) {
+ dev_info(adev->dev,
+ "attempting link recovery via %s\n",
+ pci_name(bridge));
+ pci_bridge_secondary_bus_reset(bridge);
+ msleep(100);
+ if (pci_device_is_present(adev->pdev)) {
+ recovered = true;
+ break;
+ }
+ bridge = pci_upstream_bridge(bridge);
+ }
+
+ if (!recovered) {
+ dev_err(adev->dev,
+ "Thunderbolt PCIe link recovery failed\n");
+ ret = -ENODEV;
+ goto mode1_reset_failed;
+ }
+
+ dev_info(adev->dev,
+ "Thunderbolt PCIe link recovered via %s\n",
+ pci_name(bridge));
+ }
+
amdgpu_device_load_pci_state(adev->pdev);
ret = amdgpu_psp_wait_for_bootloader(adev);
if (ret)
-- 
2.51.0
