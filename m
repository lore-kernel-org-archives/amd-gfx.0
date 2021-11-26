Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CBFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 10:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A697D6ECD3;
	Fri, 26 Nov 2021 10:37:43 +0000 (UTC)
X-Greylist: delayed 1452 seconds by postgrey-1.36 at gabe;
 Fri, 26 Nov 2021 10:06:13 UTC
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B6C6EAB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 10:06:13 +0000 (UTC)
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:57478
 helo=[10.137.0.14]) by office.oderland.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <josef@oderland.se>)
 id 1mqXjz-00HNiC-Ec; Fri, 26 Nov 2021 10:41:59 +0100
Message-ID: <397d1973-2253-c97d-6767-f629a971e4f0@oderland.se>
Date: Fri, 26 Nov 2021 10:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 xen-devel <xen-devel@lists.xenproject.org>
From: Josef Johansson <josef@oderland.se>
Subject: Failed to terminate hdcp ta during suspend on Xen
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - office.oderland.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oderland.se
X-Get-Message-Sender-Via: office.oderland.com: authenticated_id:
 josjoh@oderland.se
X-Authenticated-Sender: office.oderland.com: josjoh@oderland.se
X-Mailman-Approved-At: Fri, 26 Nov 2021 10:37:43 +0000
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

Hi,

I'm trying to solve problems during Suspend/Resume on Qubes OS (which is
running Xen).

What happens is that the resume works, but the screen blanks out each time
I type a letter on the keyboard and then returns again, then after a while
the screen just goes black.

If I boot the same kernel without Xen this issue is not present.

Running almost Linux tip with Xen 4.14.3-4 I'm getting the
following errors/warnings:

dom0 kernel: [drm] psp gfx command INVOKE_CMD(0x3) failed and response
status is (0x0)
dom0 kernel: [drm] psp gfx command UNLOAD_TA(0x2) failed and response
status is (0x0)
dom0 kernel: [drm:psp_suspend [amdgpu]] *ERROR* Failed to terminate hdcp ta
dom0 kernel: [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR*
suspend of IP block <psp> failed -22
[...]
dom0 kernel: [drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
dom0 kernel: [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
dom0 kernel: [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of
IP block <psp> failed -62
dom0 kernel: amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_resume failed
(-62).
dom0 kernel: PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -62
dom0 kernel: amdgpu 0000:07:00.0: PM: failed to resume async: error -62

I have done my best to follow the source code
and my current analysis is ( assuming we follow 'Failed to terminate
hdcp ta' ) is:
The psp gfx warn (amdgpu_psp.c: psp_cmd_submit_buf) :
L491:        DRM_WARN("psp gfx command %s(0x%X) failed and response
status is (0x%X)\n",
L492:             psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
psp->cmd_buf_mem->cmd_id,
L493:             psp->cmd_buf_mem->resp.status);

Last to set ret (amdgpu_psp.c: psp_cmd_submit_buf):
L452: ret = psp_ring_cmd_submit(psp, psp->cmd_buf_mc_addr,
fence_mc_addr, index);

The line setting -EINVAL (amdgpu_psp.c: psp_ring_cmd_submit):
L2767:    if ((write_frame < ring_buffer_start) || (ring_buffer_end <
write_frame)) {
L2768:        DRM_ERROR("ring_buffer_start = %p; ring_buffer_end = %p;
write_frame = %p\n",
L2769:              ring_buffer_start, ring_buffer_end, write_frame);
L2770:        DRM_ERROR("write_frame is pointing to address out of
bounds\n");
L2771:        return -EINVAL;

The thing that leads up to this email is that I'm not getting those
DRM_ERROR in my dmesg. I see that they have existed for 2 years so I really
should have them.

Any clues? Anything I can test to add? printk's somewhere that should
help diagnose?

Regards
Josef

dmesg:
dom0 kernel: PM: suspend entry (deep)
dom0 kernel: Filesystems sync: 0.010 seconds
dom0 kernel: Freezing user space processes ... (elapsed 0.001 seconds) done.
dom0 kernel: OOM killer disabled.
dom0 kernel: Freezing remaining freezable tasks ... (elapsed 0.000
seconds) done.
dom0 kernel: printk: Suspending console(s) (use no_console_suspend to debug)
dom0 kernel: [drm] psp gfx command INVOKE_CMD(0x3) failed and response
status is (0x0)
dom0 kernel: [drm] psp gfx command UNLOAD_TA(0x2) failed and response
status is (0x0)
dom0 kernel: [drm:psp_suspend [amdgpu]] *ERROR* Failed to terminate hdcp ta
dom0 kernel: [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR*
suspend of IP block <psp> failed -22
dom0 kernel: PM: suspend devices took 4.705 seconds
dom0 kernel: ACPI: EC: interrupt blocked
dom0 kernel: ACPI: PM: Preparing to enter system sleep state S3
dom0 kernel: ACPI: EC: event blocked
dom0 kernel: ACPI: EC: EC stopped
dom0 kernel: ACPI: PM: Saving platform NVS memory
dom0 kernel: Disabling non-boot CPUs ...
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 1 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 2 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 3 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 51f4000,
(ffff8880051f4000, 0)
dom0 kernel: smpboot: CPU 4 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 5 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 6 is now offline
dom0 kernel: josef-debug: cr3: 2810000, build_cr3: 1036aa000,
(ffff8881036aa000, 0)
dom0 kernel: smpboot: CPU 7 is now offline
dom0 kernel: ACPI: PM: Low-level resume complete
dom0 kernel: ACPI: EC: EC started
dom0 kernel: ACPI: PM: Restoring platform NVS memory
dom0 kernel: xen_acpi_processor: Uploading Xen processor PM info
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU1
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU3
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU5
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU7
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU9
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU11
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU13
dom0 kernel: xen_acpi_processor: (_PXX): Hypervisor error (-19) for ACPI
CPU15
dom0 kernel: Enabling non-boot CPUs ...
dom0 kernel: installing Xen timer for CPU 1
dom0 kernel: cpu 1 spinlock event irq 67
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C001: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU1 is up
dom0 kernel: installing Xen timer for CPU 2
dom0 kernel: cpu 2 spinlock event irq 73
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C002: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU2 is up
dom0 kernel: installing Xen timer for CPU 3
dom0 kernel: cpu 3 spinlock event irq 79
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C003: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU3 is up
dom0 kernel: installing Xen timer for CPU 4
dom0 kernel: cpu 4 spinlock event irq 85
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C004: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU4 is up
dom0 kernel: installing Xen timer for CPU 5
dom0 kernel: cpu 5 spinlock event irq 91
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C005: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU5 is up
dom0 kernel: installing Xen timer for CPU 6
dom0 kernel: cpu 6 spinlock event irq 97
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C006: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU6 is up
dom0 kernel: installing Xen timer for CPU 7
dom0 kernel: cpu 7 spinlock event irq 103
dom0 kernel: [Firmware Bug]: ACPI MWAIT C-state 0x0 not supported by HW
(0x0)
dom0 kernel: ACPI: \_SB_.PLTF.C007: Found 3 idle states
dom0 kernel: ACPI: FW issue: working around C-state latencies out of order
dom0 kernel: CPU7 is up
dom0 kernel: ACPI: PM: Waking up from system sleep state S3
dom0 kernel: ACPI: EC: interrupt unblocked
dom0 kernel: ACPI: EC: event unblocked
dom0 kernel: [drm] PCIE GART of 1024M enabled.
dom0 kernel: [drm] PTB located at 0x000000F400900000
dom0 kernel: [drm] PSP is resuming...
dom0 kernel: usb usb2: root hub lost power or was reset
dom0 kernel: usb usb3: root hub lost power or was reset
dom0 kernel: nvme nvme0: 8/0/0 default/read/poll queues
dom0 kernel: usb 4-4: reset full-speed USB device number 5 using xhci_hcd
dom0 kernel: [drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
dom0 kernel: [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
dom0 kernel: [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of
IP block <psp> failed -62
dom0 kernel: amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_resume failed
(-62).
dom0 kernel: PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -62
dom0 kernel: amdgpu 0000:07:00.0: PM: failed to resume async: error -62
dom0 kernel: usb 2-2: reset high-speed USB device number 2 using xhci_hcd
dom0 kernel: PM: resume devices took 0.546 seconds
dom0 kernel: OOM killer enabled.
