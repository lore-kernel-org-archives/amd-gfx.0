Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB77F3380F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7E810E56C;
	Tue, 17 Mar 2026 08:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.b="XZIHs5xK";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0368410E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 20:11:34 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89a0d53f3d1so65913936d6.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1773691893; x=1774296693; darn=lists.freedesktop.org; 
 h=mime-version:user-agent:date:to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WzvFHP1OoHExF7Y6Jo5Vp4O7ewqr7NmzZhKN2hl2HlA=;
 b=XZIHs5xKQdbRgQbX/miU0c7YGbl8Jf8OvD9WSOTfd0lkHb5M/yfMke/rJjYGIwPDmy
 PB5nLpxEX7KDKohya05tKDZCJpLKaDyeQW3og0MFB5AAmNtl506QXbN+aEG201p1eaWh
 z1ViaAXVs6sMPSTI/F7CWTzxkTKdy7CmXKtis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773691893; x=1774296693;
 h=mime-version:user-agent:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WzvFHP1OoHExF7Y6Jo5Vp4O7ewqr7NmzZhKN2hl2HlA=;
 b=OG23ayouX3lSMn/L79J6x4Fs75fCfcL1ibVPp2r59z7KyNoPpgccFx/BcTksPOzvGM
 kUiAz7aDdgj6tUmukBZpmOS2WD9QCEJt9aabU+JB/wBAPOkaSqRT0W5kSX71r9kybMYb
 8Qh/Jds5jfzblt0Jtm1uzDF2LiVS3JsF2R53abjzbfDfXQYheqEz8hsuA6d4289uRBq1
 hWbk7oSOR+JbyBI+ovXPzUZLtCKtnwvhYUmtGfLI5C61Ao/lbYQjiAnVvceIAriwK8Qp
 af9M1kaSvCG9kVUWTGsIhOvOMs0ytMs3LL0LX2c+mlP54icStmABOb0xMK7iADRaJuFD
 AtVg==
X-Gm-Message-State: AOJu0Yw8BLuteuSB5ZB7VeVnDlNT5S1l+zRqnlxa4nqB5va3VTXTqb84
 qgpqLfGCyMC1+EG5WUbZg9ZgiqzDz3hqZsGqnh/CC6rQ4oQKo3j6l3U6znqzXuEQ3zjDSeLTpwK
 stdYufohmgC/XpkKdKuMnA96wJl5O6wAIH2Cls8sa4gpulYdmH8lZsVCtMlav/g0oZr3ftvWNGm
 2/HHdYL6947VhHssfqvB5VPNzp2K8fJYB3tsQPdFuNVg==
X-Gm-Gg: ATEYQzzaYbzM/UUUxInW4MIghfxHZ6hKWBwgCv79BcNlpnUjV07yM+ZHQYD7cu3bkFL
 titGp6ftbEAQXODAPYr1RQ5f2DuXsuleyoQ4okGhuScnZfxUIdQzyQZ+kA4F/ZHRVNdy4B9CErG
 /y81vfH3hGGWLPQ2Ss+aR3yGoUnrB/4E6kph+syaS4mZ8aKuKmZu3pVdl+wfsDOSbOrVD8uhhB8
 tljv1aR8q50OtEpiFQm0f75MKTLFdp65nlqnRg7JrIdt98jfOKOaEJbBVzs6rQZzYJ/t0JeX0iK
 fQ8v4fn28LfcPBDs45fxSiXFGu3rC0ikz5csf0AtmI62A2+8yKevpRbO4jDSZgGvOxHGYvAEEi3
 Hw30NaSsEdxpsrsz3Lcz47gzDugwDYPcxOyFQTYfrVK1j5MOG9oo6mB+oZovfwpQLKXytRVSEhv
 bBvM6BAV/U9nkYUcoEW/U+EmjG8UgzzQy+WQ==
X-Received: by 2002:ad4:5ceb:0:b0:89c:5289:4bf5 with SMTP id
 6a1803df08f44-89c52894ddfmr67675416d6.3.1773691892102; 
 Mon, 16 Mar 2026 13:11:32 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c440d4594sm51898636d6.5.2026.03.16.13.11.31
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 13:11:31 -0700 (PDT)
Message-ID: <dfce5e070c5857aaebd8e7136011b90e7d888eb1.camel@ieee.org>
Subject: [Bug report] RADV GFX1200 (Navi 44 / RX 9060 XT): NULL page fault
 at 0x0 on gfxhub during Vulkan rendering
From: Cristian Cocos <cristi@ieee.org>
To: amd-gfx@lists.freedesktop.org
Date: Mon, 16 Mar 2026 16:11:12 -0400
Content-Type: multipart/alternative; boundary="=-lcVi9yoMsE/TZHB2CJMI"
User-Agent: Evolution 3.58.3 (by Flathub.org) 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:18:20 +0000
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

--=-lcVi9yoMsE/TZHB2CJMI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

## Summary

RADV crashes with a `[gfxhub] Page fault at address:
0x0000000000000000` when performing Vulkan rendering on an AMD RX 9060
XT (Navi 44, GFX1200). The crash occurs ~20-30 seconds into video
playback in mpv using `vo=3Dgpu-next` with `gpu-api=3Dvulkan` (libplacebo).
Multiple GPU rings (sdma0, gfx_0.0.0, comp_1.x.x) time out
simultaneously. The kernel driver recovers the rings, but the Vulkan
context is lost.

**Critically, the crash also occurs when video decode is offloaded to
VA-API on a separate Intel iGPU** =E2=80=94 only the Vulkan rendering path
(libplacebo =E2=86=92 RADV =E2=86=92 `vkQueueSubmit2`) is involved. This ru=
les out
VK_KHR_video_decode_queue as the cause.

## System Information

| Component | Version |
|-----------|---------|
| GPU | AMD Radeon RX 9060 XT =E2=80=94 Navi 44, RDNA 4, GFX1200 [1002:7590=
]
(rev c0) |
| Mesa | 26.0.2-1 (also reproduced on 26.0.1) |
| vulkan-radeon | 26.0.2-1 |
| libplacebo | v7.360.0 |
| Kernel | 6.19.8-zen1-1-zen |
| Firmware | linux-firmware-amdgpu 20260309-1 (SMC firmware 102.70.0) |
| CPU | 13th Gen Intel Core i7-1360P |
| Distro | blendOS (Arch-based, rolling) |
| mpv | v0.41.0, FFmpeg n8.0.1 |
| Connection | eGPU via Thunderbolt 4 (Razer Core X V2), PCIe 32 GT/s
x16 link |

### Module parameters

```
options amdgpu runpm=3D0 rebar=3D0 ppfeaturemask=3D0xFFFF7FFF
```

- `runpm=3D0` =E2=80=94 runtime PM disabled (TB eGPU SMU limitation)
- `rebar=3D0` =E2=80=94 BIOS assigns full 16 GB BAR, driver does not resize
- `ppfeaturemask=3D0xFFFF7FFF` =E2=80=94 GFXOFF disabled (bit 15) due to SM=
U IF
version mismatch (driver 0x2E vs firmware 0x33)

**Note:** The SMU interface version mismatch (`smu_v14_0: SMU driver if
version not matched`) is a separate known issue. GFXOFF is disabled to
prevent a bus-loss crash, but the rendering crash described here is
unrelated =E2=80=94 it occurs during active rendering, not during idle.

## Steps to Reproduce

1. Install an AMD RX 9060 XT (Navi 44)
2. Configure mpv with Vulkan rendering:
```
vo=3Dgpu-next
gpu-api=3Dvulkan
gpu-context=3Dwaylandvk
vulkan-device=3D'AMD Radeon RX 9060 XT (RADV GFX1200)'
vulkan-async-compute=3Dyes
vulkan-async-transfer=3Dyes
```
3. Play any video file: `mpv /path/to/video.mkv`
4. Wait ~20-30 seconds

### Test 1: Vulkan decode + Vulkan rendering (`hwdec=3Dvulkan`)

Crashes after ~26 seconds.

### Test 2: VA-API decode (Intel iGPU) + Vulkan rendering
(`hwdec=3Dvaapi`)

**Also crashes after ~26 seconds.** VA-API decode runs on the Intel
iGPU (`iHD_drv_video.so`), only Vulkan rendering runs on the AMD GPU
via RADV. This isolates the bug to the RADV rendering path.

## RADV Error Output

```
radv/amdgpu: The CS has been cancelled because the context is lost.
This context is guilty of a hard recovery.

[vo/gpu-next/libplacebo] vkQueueSubmit2: VK_ERROR_DEVICE_LOST
(../src/vulkan/command.c:514)
[vo/gpu-next/libplacebo] Retrieving query pool results:
VK_ERROR_DEVICE_LOST (../src/vulkan/gpu.c:105)
[vo/gpu-next/libplacebo] Failed holding swapchain image for
presentation
[vo/gpu-next] Failed presenting frame!
[ffmpeg] vk: Unable to submit command buffer: VK_ERROR_DEVICE_LOST
[ffmpeg/video] h264: hardware accelerator failed to decode picture
```

## Kernel Log (Crash 1 =E2=80=94 hwdec=3Dvulkan, Mesa 26.0.2)

```
amdgpu 0000:06:00.0: amdgpu: Dumping IP State
amdgpu 0000:06:00.0: amdgpu: [drm] AMDGPU device coredump file has been
created
amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D11425,
emitted seq=3D11427
amdgpu 0000:06:00.0: amdgpu: Starting sdma0 ring reset
amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled
seq=3D16289, emitted seq=3D16291
amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid 45004
amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 timeout, signaled seq=3D13,
emitted seq=3D14
amdgpu 0000:06:00.0: amdgpu: Process mpv pid 44985 thread vo pid 45004
amdgpu 0000:06:00.0: amdgpu: Ring comp_1.1.0 reset succeeded
amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
amdgpu 0000:06:00.0: amdgpu: Fence fallback timer expired on ring sdma1
amdgpu 0000:06:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip_done timed
out
```

## Kernel Log (Crash 2 =E2=80=94 hwdec=3Dvaapi, Mesa 26.0.2)

```
amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D13615,
emitted seq=3D13617
amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded
amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled
seq=3D30731, emitted seq=3D30733
amdgpu 0000:06:00.0: amdgpu: Process mpv pid 66481 thread vo pid 66500
amdgpu 0000:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded
amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset
amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 timeout, signaled seq=3D312,
emitted seq=3D313
```

## GPU Device Coredump (Crash 1)

```
**** AMDGPU Device Coredump ****
version: 1
kernel: 6.19.8-zen1-1-zen
module: amdgpu
time: 3054.167340782

SOC Device id: 30096
SOC Family: 152
SOC External Revision id: 65

HWIP: GC[1][0]: v12.0.0.0.0
HWIP: SDMA0[3][0]: v7.0.0.0.0
HWIP: MMHUB[12][0]: v4.1.0.0.0

Ring timed out details
IP Type: 2 Ring Name: sdma0

[gfxhub] Page fault observed
Faulty page starting at address: 0x0000000000000000
Protection fault status register: 0x0
```

**Full coredump available on request** (543 KB).

## Analysis

- The crash is a **NULL pointer dereference at GPU virtual address
0x0** =E2=80=94 RADV is submitting commands that reference unmapped memory.
- The `Protection fault status register: 0x0` suggests the fault info
itself is zeroed, which may indicate the fault occurred very early in
command processing or in an SDMA copy from a NULL source.
- The fault hits sdma0 first, then cascades to gfx_0.0.0 and a compute
ring =E2=80=94 consistent with a resource upload (SDMA) referencing a NULL
buffer, followed by the GFX/compute rings trying to use the result.
- After ring resets, the GPU fully recovers (all fences drain, PCIe
link stays up at 32 GT/s x16), confirming this is a userspace (RADV)
command stream issue, not a hardware or kernel driver bug.
- The `flip_done timed out` on CRTC-0 is a secondary effect =E2=80=94 the
compositor's page flip can't complete while rings are being reset,
which restarts the GNOME session.

## Additional Notes

- The GPU is connected via Thunderbolt 4 (eGPU enclosure), but the PCIe
link stays healthy through the crash =E2=80=94 this is not a link/BAR issue=
.
- This was also reproduced on Mesa 26.0.1 with kernel 6.19.6 and
firmware 20260221 (SMC 102.69.0) =E2=80=94 same crash signature.
- Desktop compositing (GNOME Shell / Mutter on Wayland) works fine on
this GPU =E2=80=94 only mpv's libplacebo rendering pipeline triggers the cr=
ash.
- `vulkan-async-compute=3Dyes` was enabled. Not yet tested with async
compute disabled, though the fault is on sdma0, not a compute ring.

--=-lcVi9yoMsE/TZHB2CJMI
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>## Summary</div><div><br></div><div>RADV crashes =
with a `[gfxhub] Page fault at address: 0x0000000000000000` when performing=
 Vulkan rendering on an AMD RX 9060 XT (Navi 44, GFX1200). The crash occurs=
 ~20-30 seconds into video playback in mpv using `vo=3Dgpu-next` with `gpu-=
api=3Dvulkan` (libplacebo). Multiple GPU rings (sdma0, gfx_0.0.0, comp_1.x.=
x) time out simultaneously. The kernel driver recovers the rings, but the V=
ulkan context is lost.</div><div><br></div><div>**Critically, the crash als=
o occurs when video decode is offloaded to VA-API on a separate Intel iGPU*=
* =E2=80=94 only the Vulkan rendering path (libplacebo =E2=86=92 RADV =E2=
=86=92 `vkQueueSubmit2`) is involved. This rules out VK_KHR_video_decode_qu=
eue as the cause.</div><div><br></div><div>## System Information</div><div>=
<br></div><div>| Component | Version |</div><div>|-----------|---------|</d=
iv><div>| GPU | AMD Radeon RX 9060 XT =E2=80=94 Navi 44, RDNA 4, GFX1200 [1=
002:7590] (rev c0) |</div><div>| Mesa | 26.0.2-1 (also reproduced on 26.0.1=
) |</div><div>| vulkan-radeon | 26.0.2-1 |</div><div>| libplacebo | v7.360.=
0 |</div><div>| Kernel | 6.19.8-zen1-1-zen |</div><div>| Firmware | linux-f=
irmware-amdgpu 20260309-1 (SMC firmware 102.70.0) |</div><div>| CPU | 13th =
Gen Intel Core i7-1360P |</div><div>| Distro | blendOS (Arch-based, rolling=
) |</div><div>| mpv | v0.41.0, FFmpeg n8.0.1 |</div><div>| Connection | eGP=
U via Thunderbolt 4 (Razer Core X V2), PCIe 32 GT/s x16 link |</div><div><b=
r></div><div>### Module parameters</div><div><br></div><div>```</div><div>o=
ptions amdgpu runpm=3D0 rebar=3D0 ppfeaturemask=3D0xFFFF7FFF</div><div>```<=
/div><div><br></div><div>- `runpm=3D0` =E2=80=94 runtime PM disabled (TB eG=
PU SMU limitation)</div><div>- `rebar=3D0` =E2=80=94 BIOS assigns full 16 G=
B BAR, driver does not resize</div><div>- `ppfeaturemask=3D0xFFFF7FFF` =E2=
=80=94 GFXOFF disabled (bit 15) due to SMU IF version mismatch (driver 0x2E=
 vs firmware 0x33)</div><div><br></div><div>**Note:** The SMU interface ver=
sion mismatch (`smu_v14_0: SMU driver if version not matched`) is a separat=
e known issue. GFXOFF is disabled to prevent a bus-loss crash, but the rend=
ering crash described here is unrelated =E2=80=94 it occurs during active r=
endering, not during idle.</div><div><br></div><div>## Steps to Reproduce</=
div><div><br></div><div>1. Install an AMD RX 9060 XT (Navi 44)</div><div>2.=
 Configure mpv with Vulkan rendering:</div><div>   ```</div><div>   vo=3Dgp=
u-next</div><div>   gpu-api=3Dvulkan</div><div>   gpu-context=3Dwaylandvk</=
div><div>   vulkan-device=3D'AMD Radeon RX 9060 XT (RADV GFX1200)'</div><di=
v>   vulkan-async-compute=3Dyes</div><div>   vulkan-async-transfer=3Dyes</d=
iv><div>   ```</div><div>3. Play any video file: `mpv /path/to/video.mkv`</=
div><div>4. Wait ~20-30 seconds</div><div><br></div><div>### Test 1: Vulkan=
 decode + Vulkan rendering (`hwdec=3Dvulkan`)</div><div><br></div><div>Cras=
hes after ~26 seconds.</div><div><br></div><div>### Test 2: VA-API decode (=
Intel iGPU) + Vulkan rendering (`hwdec=3Dvaapi`)</div><div><br></div><div>*=
*Also crashes after ~26 seconds.** VA-API decode runs on the Intel iGPU (`i=
HD_drv_video.so`), only Vulkan rendering runs on the AMD GPU via RADV. This=
 isolates the bug to the RADV rendering path.</div><div><br></div><div>## R=
ADV Error Output</div><div><br></div><div>```</div><div>radv/amdgpu: The CS=
 has been cancelled because the context is lost.</div><div>This context is =
guilty of a hard recovery.</div><div><br></div><div>[vo/gpu-next/libplacebo=
] vkQueueSubmit2: VK_ERROR_DEVICE_LOST (../src/vulkan/command.c:514)</div><=
div>[vo/gpu-next/libplacebo] Retrieving query pool results: VK_ERROR_DEVICE=
_LOST (../src/vulkan/gpu.c:105)</div><div>[vo/gpu-next/libplacebo] Failed h=
olding swapchain image for presentation</div><div>[vo/gpu-next] Failed pres=
enting frame!</div><div>[ffmpeg] vk: Unable to submit command buffer: VK_ER=
ROR_DEVICE_LOST</div><div>[ffmpeg/video] h264: hardware accelerator failed =
to decode picture</div><div>```</div><div><br></div><div>## Kernel Log (Cra=
sh 1 =E2=80=94 hwdec=3Dvulkan, Mesa 26.0.2)</div><div><br></div><div>```</d=
iv><div>amdgpu 0000:06:00.0: amdgpu: Dumping IP State</div><div>amdgpu 0000=
:06:00.0: amdgpu: [drm] AMDGPU device coredump file has been created</div><=
div>amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D11425, =
emitted seq=3D11427</div><div>amdgpu 0000:06:00.0: amdgpu: Starting sdma0 r=
ing reset</div><div>amdgpu 0000:06:00.0: amdgpu: Ring sdma0 reset succeeded=
</div><div>amdgpu 0000:06:00.0: [drm] device wedged, but recovered through =
reset</div><div>amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 timeout, signal=
ed seq=3D16289, emitted seq=3D16291</div><div>amdgpu 0000:06:00.0: amdgpu: =
 Process mpv pid 44985 thread vo pid 45004</div><div>amdgpu 0000:06:00.0: a=
mdgpu: Ring gfx_0.0.0 reset succeeded</div><div>amdgpu 0000:06:00.0: [drm] =
device wedged, but recovered through reset</div><div>amdgpu 0000:06:00.0: a=
mdgpu: ring comp_1.1.0 timeout, signaled seq=3D13, emitted seq=3D14</div><d=
iv>amdgpu 0000:06:00.0: amdgpu:  Process mpv pid 44985 thread vo pid 45004<=
/div><div>amdgpu 0000:06:00.0: amdgpu: Ring comp_1.1.0 reset succeeded</div=
><div>amdgpu 0000:06:00.0: [drm] device wedged, but recovered through reset=
</div><div>amdgpu 0000:06:00.0: amdgpu: Fence fallback timer expired on rin=
g sdma1</div><div>amdgpu 0000:06:00.0: [drm] *ERROR* [CRTC:416:crtc-0] flip=
_done timed out</div><div>```</div><div><br></div><div>## Kernel Log (Crash=
 2 =E2=80=94 hwdec=3Dvaapi, Mesa 26.0.2)</div><div><br></div><div>```</div>=
<div>amdgpu 0000:06:00.0: amdgpu: ring sdma0 timeout, signaled seq=3D13615,=
 emitted seq=3D13617</div><div>amdgpu 0000:06:00.0: amdgpu: Ring sdma0 rese=
t succeeded</div><div>amdgpu 0000:06:00.0: [drm] device wedged, but recover=
ed through reset</div><div>amdgpu 0000:06:00.0: amdgpu: ring gfx_0.0.0 time=
out, signaled seq=3D30731, emitted seq=3D30733</div><div>amdgpu 0000:06:00.=
0: amdgpu:  Process mpv pid 66481 thread vo pid 66500</div><div>amdgpu 0000=
:06:00.0: amdgpu: Ring gfx_0.0.0 reset succeeded</div><div>amdgpu 0000:06:0=
0.0: [drm] device wedged, but recovered through reset</div><div>amdgpu 0000=
:06:00.0: amdgpu: ring comp_1.1.1 timeout, signaled seq=3D312, emitted seq=
=3D313</div><div>```</div><div><br></div><div>## GPU Device Coredump (Crash=
 1)</div><div><br></div><div>```</div><div>**** AMDGPU Device Coredump ****=
</div><div>version: 1</div><div>kernel: 6.19.8-zen1-1-zen</div><div>module:=
 amdgpu</div><div>time: 3054.167340782</div><div><br></div><div>SOC Device =
id: 30096</div><div>SOC Family: 152</div><div>SOC External Revision id: 65<=
/div><div><br></div><div>HWIP: GC[1][0]: v12.0.0.0.0</div><div>HWIP: SDMA0[=
3][0]: v7.0.0.0.0</div><div>HWIP: MMHUB[12][0]: v4.1.0.0.0</div><div><br></=
div><div>Ring timed out details</div><div>IP Type: 2 Ring Name: sdma0</div>=
<div><br></div><div>[gfxhub] Page fault observed</div><div>Faulty page star=
ting at address: 0x0000000000000000</div><div>Protection fault status regis=
ter: 0x0</div><div>```</div><div><br></div><div>**Full coredump available o=
n request** (543 KB).</div><div><br></div><div>## Analysis</div><div><br></=
div><div>- The crash is a **NULL pointer dereference at GPU virtual address=
 0x0** =E2=80=94 RADV is submitting commands that reference unmapped memory=
.</div><div>- The `Protection fault status register: 0x0` suggests the faul=
t info itself is zeroed, which may indicate the fault occurred very early i=
n command processing or in an SDMA copy from a NULL source.</div><div>- The=
 fault hits sdma0 first, then cascades to gfx_0.0.0 and a compute ring =E2=
=80=94 consistent with a resource upload (SDMA) referencing a NULL buffer, =
followed by the GFX/compute rings trying to use the result.</div><div>- Aft=
er ring resets, the GPU fully recovers (all fences drain, PCIe link stays u=
p at 32 GT/s x16), confirming this is a userspace (RADV) command stream iss=
ue, not a hardware or kernel driver bug.</div><div>- The `flip_done timed o=
ut` on CRTC-0 is a secondary effect =E2=80=94 the compositor's page flip ca=
n't complete while rings are being reset, which restarts the GNOME session.=
</div><div><br></div><div>## Additional Notes</div><div><br></div><div>- Th=
e GPU is connected via Thunderbolt 4 (eGPU enclosure), but the PCIe link st=
ays healthy through the crash =E2=80=94 this is not a link/BAR issue.</div>=
<div>- This was also reproduced on Mesa 26.0.1 with kernel 6.19.6 and firmw=
are 20260221 (SMC 102.69.0) =E2=80=94 same crash signature.</div><div>- Des=
ktop compositing (GNOME Shell / Mutter on Wayland) works fine on this GPU =
=E2=80=94 only mpv's libplacebo rendering pipeline triggers the crash.</div=
><div>- `vulkan-async-compute=3Dyes` was enabled. Not yet tested with async=
 compute disabled, though the fault is on sdma0, not a compute ring.</div><=
div><span></span></div></body></html>

--=-lcVi9yoMsE/TZHB2CJMI--
