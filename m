Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 08:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A271310E1C6;
	Tue, 14 Nov 2023 08:18:05 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Tue, 14 Nov 2023 04:58:39 UTC
Received: from mail.praveen.org.uk (mail.praveen.org.uk [78.141.237.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF20810E06D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 04:58:39 +0000 (UTC)
Received: by mail.praveen.org.uk (OpenSMTPD) with ESMTPSA id ac089a0a
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
 for <amd-gfx@lists.freedesktop.org>;
 Tue, 14 Nov 2023 04:51:30 +0000 (GMT)
Date: Tue, 14 Nov 2023 04:51:56 +0000
From: Abhinav Praveen <abhinav@praveen.org.uk>
To: amd-gfx@lists.freedesktop.org
Subject: page fault GCVM_L2_PROTECTION_FAULT_STATUS on 7900xtx Linux 6.7-rc1
 with Mesa 23.3.0-rc3
Message-ID: <20231114045156.qymbztbq5x57crsd@praveen.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="me3nq4bz35iehwov"
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 14 Nov 2023 08:18:02 +0000
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


--me3nq4bz35iehwov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

When I start X/i3 on a 7900xtx with Linux 6.7-rc1 and Mesa 23.3_rc3, my
log is filled with errors like:

[  649.788816] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788819] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dd000 from client 10
[  649.788820] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.788821] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788822] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788823] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788824] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788825] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788826] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1

A log with all entries since X session startup is attached. I'm
wondering if this is an issue that the amdgpu devs can reproduce or
whether I should create an issue on drm/amd? Also, I am having an issue
with a partially garbled UEFI (but no artifacts after amdgpudrmfb picks
up) and no artifacts in X or in games (This is not an amdgpu issue but I
am just mentioning it incase it is related).

Also drm/amd#2356 persists too. Writing to power1_cap results in:

tee: /sys/class/drm/card0/device/hwmon/hwmon1/power1_cap: Input/output error

-- 
Abhinav Praveen

--me3nq4bz35iehwov
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg.txt"

[  649.746070] elogind-daemon[1941]: New session 3 of user me.
[  649.761578] gmc_v11_0_process_interrupt: 83 callbacks suppressed
[  649.761580] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.761584] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dc000 from client 10
[  649.761586] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.761587] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.761588] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.761589] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.761590] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.761590] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.761591] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.767011] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.767014] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dd000 from client 10
[  649.767016] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.767017] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.767018] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.767019] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.767019] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.767020] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.767021] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.769005] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.769008] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dd000 from client 10
[  649.769010] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.769011] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.769012] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.769013] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.769013] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.769014] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.769015] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788708] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788714] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dd000 from client 10
[  649.788717] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.788719] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788720] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788721] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788722] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788723] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788724] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788737] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788739] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080898b18e000 from client 10
[  649.788741] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.788743] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788744] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788745] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788746] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788747] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788749] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788754] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788756] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080894a77d000 from client 10
[  649.788758] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.788759] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788760] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788762] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788763] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788764] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788765] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788775] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788777] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080898b18e000 from client 10
[  649.788778] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
[  649.788779] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788781] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x1
[  649.788782] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788783] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788784] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788785] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788789] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788791] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080894a77d000 from client 10
[  649.788792] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000000
[  649.788793] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: CB/DB (0x0)
[  649.788794] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788795] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x0
[  649.788797] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x0
[  649.788797] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x0
[  649.788798] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
[  649.788803] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788805] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x000080898b18e000 from client 10
[  649.788806] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D53
[  649.788808] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788809] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x1
[  649.788810] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788811] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788812] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788812] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1
[  649.788816] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  649.788819] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x00008088ed3dd000 from client 10
[  649.788820] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00041D52
[  649.788821] amdgpu 0000:03:00.0: amdgpu: 	 Faulty UTCL2 client ID: SDMA1 (0xe)
[  649.788822] amdgpu 0000:03:00.0: amdgpu: 	 MORE_FAULTS: 0x0
[  649.788823] amdgpu 0000:03:00.0: amdgpu: 	 WALKER_ERROR: 0x1
[  649.788824] amdgpu 0000:03:00.0: amdgpu: 	 PERMISSION_FAULTS: 0x5
[  649.788825] amdgpu 0000:03:00.0: amdgpu: 	 MAPPING_ERROR: 0x1
[  649.788826] amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x1

--me3nq4bz35iehwov--
