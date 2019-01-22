From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Add APTX quirk for Lenovo laptop
Date: Tue, 22 Jan 2019 15:56:05 +0000
Message-ID: <20190122155605.C24BB217F9@mail.kernel.org>
References: <20190116160514.13477-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190116160514.13477-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.orgstable@vger.kernel.orgstable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.20.3, v4.19.16, v4.14.94, v4.9.151, v4.4.171, v3.18.132.

v4.20.3: Build OK!
v4.19.16: Build OK!
v4.14.94: Failed to apply! Possible dependencies:
    Unable to calculate

v4.9.151: Failed to apply! Possible dependencies:
    b3fc2ab37e27 ("drm/amdgpu: add another ATPX quirk for TOPAZ")

v4.4.171: Failed to apply! Possible dependencies:
    052c299080cd ("drm/amdgpu: add atpx quirk handling (v2)")
    1db4496f167b ("drm/amdgpu: fix power state when port pm is unavailable")
    2f5af82eeab2 ("drm/amdgpu/atpx: track whether if this is a hybrid graphics platform")
    5c614792474b ("drm/amdgpu: disable power control on hybrid laptops")
    6b1095eedd39 ("drm/amdgpu: init atpx at switcheroo register time (v2)")
    6c24a85d236e ("drm/amdgpu: add new device to use atpx quirk")
    7ac33e47d576 ("drm/amdgpu: fix check for port PM availability")
    8d45f80ed08b ("drm/amdgpu: clean up atpx power control handling")
    a78fe13389f0 ("drm/amdgpu/atpx: add a query for ATPX dGPU power control")
    b3fc2ab37e27 ("drm/amdgpu: add another ATPX quirk for TOPAZ")
    c8791a13d281 ("drm/amdgpu: print a message if ATPX dGPU power control is missing")

v3.18.132: Failed to apply! Possible dependencies:
    052c299080cd ("drm/amdgpu: add atpx quirk handling (v2)")
    1db4496f167b ("drm/amdgpu: fix power state when port pm is unavailable")
    2f5af82eeab2 ("drm/amdgpu/atpx: track whether if this is a hybrid graphics platform")
    5c614792474b ("drm/amdgpu: disable power control on hybrid laptops")
    6c24a85d236e ("drm/amdgpu: add new device to use atpx quirk")
    7ac33e47d576 ("drm/amdgpu: fix check for port PM availability")
    8d45f80ed08b ("drm/amdgpu: clean up atpx power control handling")
    97b2e202fba0 ("drm/amdgpu: add amdgpu.h (v2)")
    a78fe13389f0 ("drm/amdgpu/atpx: add a query for ATPX dGPU power control")
    b3fc2ab37e27 ("drm/amdgpu: add another ATPX quirk for TOPAZ")
    bedf2a65c1aa ("drm/amdgpu: disable runtime pm on PX laptops without dGPU power control")
    c8791a13d281 ("drm/amdgpu: print a message if ATPX dGPU power control is missing")
    d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
    e9bef455af8e ("Revert "drm/amdgpu: disable runtime pm on PX laptops without dGPU power control"")


How should we proceed with this patch?
