Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F060EC9832F
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Sep 2026 18:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DB710E0C9;
	Sat, 26 Sep 2026 18:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=servicesoffice.ca header.i=@servicesoffice.ca header.b="bPsxFpgL";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Sat, 26 Sep 2026 18:57:15 UTC
Received: from mta0.migadu.com (out-68.mta0.migadu.com [91.218.175.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6610E0C9
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 18:57:14 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=SSy8ighERssgTPuII+UvORkS1ymqGSJH01xi+3jvAdI=; 
 c=simple/simple; d=servicesoffice.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790449033; v=1; x=1791053833;
 b=bPsxFpgLb876ZKYuM6y3Sn9rJ65mXWBABYsonQl8+S4zY046emPH4q4zdqCseaj3IggAD+7R
 MdxFeZ5HUspMP4VluIplDcpHNUxLC1/vo0336e6TiMU+4KK6J1v5N/wcwy7IuuUJqwwuCOCLOT+
 WHQdYXJwUlSkY9al6a4hSsPhtBepR8+kBojiypnYulr4lGZ5mYUxXlRQRxM9P4dLw0dibbEPVX+
 3dg0UIGo/IGu8l2N0E0floRzJKIGGXFCDb8rTzdLD7TOt4RTujnbExKGWeFJG9QEwZ6S+ZTHyC4
 e6e9vjJQazy7PNGMYt1xT/xnVB0BdraOvRdZYLQO2RDUA==
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id fef5794c4879d686;
 Sat, 26 Sep 2026 18:51:08 +0000
X-Mizu-Trace-ID: fef5794c4879d686
X-Migadu-Flow: FLOW_OUT
Date: Sat, 26 Sep 2026 14:51:06 -0400
Message-ID: <c593ee7192ca9746d5c7d89c7ae1dd91@servicesoffice.ca>
From: jano@servicesoffice.ca
To: amd-gfx@lists.freedesktop.org
Subject: [amdgpu] XFCE/X11 freeze while working: Raphael iGPU + NVIDIA RTX
 5070, REG_WAIT dcn31_program_compbuf_size + flip_done
Content-Type: text/plain; charset=utf-8
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

The desktop freezes during a normal work session: both monitors stop updating, mouse/keyboard are dead, the machine stays powered, a hard power-cycle is required. This is not a shutdown/reboot hang.

Hardware / OS:
- Ubuntu 26.04 LTS, kernel 7.0.0-34-generic, XFCE on X11
- AMD Ryzen 7 7700X, iGPU Raphael (amdgpu, PCI 1002:164e) drives the displays (DisplayPort + HDMI, 2x1080p, 3840x1080 desktop)
- NVIDIA GeForce RTX 5070 (PCI 10de:2f04), open kernel module 595.91.07
- xrandr providers: NVIDIA-0 = Source Output; AMD = Sink Output + Source Offload
- glxinfo renderer = NVIDIA GeForce RTX 5070 (also with DRI_PRIME=0 and DRI_PRIME=1)
- Mesa 26.0.3

Observed trigger (same night, graphical session already open):
- pCloud Drive AppImage 2.3.0 (Electron 39.8.10 / Chromium 142), command line --no-sandbox --ozone-platform=x11, GPU acceleration enabled
- Telegram Desktop Flatpak 7.2.9 (GNOME runtime 50) which installed two Flatpak NVIDIA GL stacks at once: org.freedesktop.Platform.GL.nvidia-595-71-05 and nvidia-595-91-07 (plus GL32 595-71-05)

Kernel log (hostname stripped):

overnight / frozen session:
amdgpu 0000:0f:00.0: [drm] REG_WAIT timeout 1us * 100 tries - dcn31_program_compbuf_size line:141
WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn31/dcn31_hubbub.c:151 at dcn31_program_compbuf_size ... kworker
amdgpu 0000:0f:00.0: [drm] REG_WAIT timeout 1us * 100 tries - dcn31_program_compbuf_size line:142
INFO: task pcloud.bin blocked for more than 122 seconds (D state)

later the same day, both screens froze:
amdgpu 0000:0f:00.0: [drm] *ERROR* [CRTC:364:crtc-0] hw_done or flip_done timed out
amdgpu 0000:0f:00.0: [drm] *ERROR* [CRTC:368:crtc-1] hw_done or flip_done timed out

Question: what mitigation is recommended when amdgpu owns the displays, GLX is on NVIDIA, Electron 39 is GPU-accelerated, and Flatpak has two NVIDIA GL runtimes?

Thanks.
