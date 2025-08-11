Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD76C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 07:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3410E384;
	Mon, 11 Aug 2025 07:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="X0PxYhwZ";
	dkim-atps=neutral
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D882D10E089
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 05:32:08 +0000 (UTC)
Message-ID: <f2b70e6e-bff6-42f3-82a2-81eed892cc30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1754890326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k8n6wtZoH9yZ6Xr+jnhM5nwzkzvEoSukEzYOZ5O15Gg=;
 b=X0PxYhwZ8DliCXSbwLMi6tGf41D4eY2vX4so8+v0WMBaj74AF8lHDWkWqLEPidVRRD2nZC
 dmlK4VPAFZJ8v23zK2sCI9ImIVC2gDQbWKvSQVTt3l40ejFMaAGd4wpcgNxksevTzrFI/k
 rvfdbGlwhW/HjwE5GKXjJfwrv+VOEcs=
Date: Sun, 10 Aug 2025 22:32:02 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Gang.Ba@amd.com
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>, Tong.Liu01@amd.com,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [REGRESSION] Freeze while shutting down Steam inside of gamescope
 after b8adc31cc0ca ("drm/amdgpu: Avoid extra evict-restore,process.").
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:15:29 +0000
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

Hello,

On kernel 6.17-rc1, when I try to switch from a Steam session running inside
of gamescope back to SDDM by running `steam -shutdown`, I get this error in my dmesg:

[drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed entity

and it locks up the transition to SDDM. I am able to switch to another TTY console,
but the console with my gamescope session stays frozen on a black screen for
several minutes. I also need to force shutdown my PC with the power button
or else the shutdown process hangs.

I bisected the issue to b8adc31cc0ca ("drm/amdgpu: Avoid extra evict-restore
process."). 

After searching the mailing list, I saw that there was a patch [1]
sent out for a race condition introduced by that commit:

[1]: https://lore.kernel.org/all/20250807084655.1597669-1-Tong.Liu01@amd.com/

That patch does seem to resolve this regression on my rig.

System:
  Host: threadripper Kernel: 6.17.0-rc1-1-git-00001-g6bd866b61c96 arch: x86_64
    bits: 64
  Desktop: KDE Plasma v: 6.4.4 Distro: CachyOS
CPU:
  Info: 64-core model: AMD Ryzen Threadripper 9980X s bits: 64 type: MT MCP
    cache: L2: 64 MiB
  Speed (MHz): avg: 1221 min/max: 1221/5476
Graphics:
  Device-1: Advanced Micro Devices [AMD/ATI] Navi 31 [Radeon RX 7900 XT/7900
    XTX/7900 GRE/7900M] driver: amdgpu v: kernel
  Display: wayland server: X.org v: 1.21.1.18 with: Xwayland v: 24.1.8
    compositor: kwin_wayland driver: X: loaded: amdgpu unloaded: modesetting
    dri: radeonsi gpu: amdgpu resolution: 5120x2160~165Hz
  API: EGL v: 1.5 drivers: kms_swrast,radeonsi,swrast
    platforms: gbm,wayland,x11,surfaceless,device
  API: OpenGL v: 4.6 compat-v: 4.5 vendor: amd mesa v: 25.3.0-devel
    renderer: AMD Radeon RX 7900 XTX (radeonsi navi31 LLVM 20.1.8 DRM 3.64
    6.17.0-rc1-1-git-00001-g6bd866b61c96)
  API: Vulkan v: 1.4.321 drivers: radv,llvmpipe surfaces: N/A
  Info: Tools: api: clinfo, eglinfo, glxinfo, vulkaninfo
    de: kscreen-console,kscreen-doctor wl: wayland-info
    x11: xdpyinfo, xprop, xrandr

Thanks,

Matthew
