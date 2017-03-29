From: Jan Burgmeier <jan.burgmeier@unicon-software.com>
Subject: Fix hardware accelerated video playback with amdgpu on 32Bit system
Date: Wed, 29 Mar 2017 11:18:38 +0200
Message-ID: <20170329091839.5246-1-jan.burgmeier@unicon-software.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: airlied@linux.ie
List-Id: amd-gfx.lists.freedesktop.org

Hi,

on 32Bit systems hardware accelerated video playback with amdgpu always errors
out with the following message:
	"[drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* IB va_start+ib_bytes is invalid."

Attached you find a patch witch fixes the problem. The patch was made against the staging-next branch.

The used hardware is:
HP T630 Thin Client
CPU: AMD Embedded G-Series GX-420GI Radeon R7E
GPU: Advanced Micro Devices, Inc. [AMD/ATI] Carrizo (rev 88)

Regards,
Jan Burgmeier
