Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA5E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A6910E4BB;
	Fri, 10 Jan 2025 02:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hXxlUv0o";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7500810E4C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736474931; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=0CMzlVt70wcyAKf3qiA6N7oL/us7UKuWh4Iu3WvCL5g=;
 b=hXxlUv0oFy3Q9JohFHAfPfHno6EZ5BGpnse6EEBuTN2BexDgBs7aSwcM04yPKBbSbPCEOkAedgAjGjz+Hk3HX2aejtOYLAVTcN+TEry+xtXCjYuvpo8SvKbEVxbXSMQrNEmlECSjLTKkV7nC0cCvlOXz1L/mhC3qrpZQYlHvO+U=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNJ5W9r_1736474930 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 10:08:50 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v4 1/5] drm/amdgpu: clear adev->in_suspend flag when fails to suspend
Date: Fri, 10 Jan 2025 10:08:43 +0800
Message-ID: <04046faffc26d2dfceda01806782df1083450066.1736474822.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736474822.git.gerry@linux.alibaba.com>
References: <cover.1736474822.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Clear adev->in_suspend flag when fails to suspend, otherwise it will
cause too much warnings like:
[ 1802.212027] ------------[ cut here ]------------
[ 1802.212028] WARNING: CPU: 97 PID: 11282 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_object.c:452 amdgpu_bo_free_kernel+0xf9/0x120 [amdgpu]
[ 1802.212198] Modules linked in: amdgpu(E-) tcp_diag(E) inet_diag(E) rfkil=
l(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel=
_uncore_frequency_common(E) i10nm_edac(E) nfit(E) x86_pkg_temp_thermal(E) i=
ntel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) crct10dif_pclmul(E) crc3=
2_pclmul(E) ghash_clmulni_intel(E) rapl(E) iTCO_wdt(E) pmt_telemetry(E) iTC=
O_vendor_support(E) pmt_class(E) intel_cstate(E) snd_hda_intel(E) ipmi_ssif=
(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_p=
cm(E) snd_timer(E) intel_uncore(E) snd(E) cdc_ether(E) pcspkr(E) i2c_i801(E=
) idxd(E) mei_me(E) usbnet(E) ses(E) isst_if_mmio(E) isst_if_mbox_pci(E) mi=
i(E) joydev(E) soundcore(E) isst_if_common(E) idxd_bus(E) mei(E) enclosure(=
E) intel_vsec(E) i2c_smbus(E) i2c_ismt(E) sunrpc(E) acpi_power_meter(E) ipm=
i_si(E) acpi_ipmi(E) ipmi_devintf(E) acpi_pad(E) ipmi_msghandler(E) vfat(E)=
 fat(E) sg(E) video(E) amdxcp(E) drm_ttm_helper(E) ttm(E) drm_exec(E) gpu_s=
ched(E) drm_suballoc_helper(E) crc32c_intel(E) drm_buddy(E)
[ 1802.212223]  ast(E) drm_shmem_helper(E) drm_display_helper(E) i2c_algo_b=
it(E) drm_kms_helper(E) virtio_net(E) mpt3sas(E) drm(E) net_failover(E) ahc=
i(E) raid_class(E) failover(E) libahci(E) scsi_transport_sas(E) dimlib(E) l=
ibata(E) i2c_core(E) wmi(E) pinctrl_emmitsburg(E) [last unloaded: amdgpu(E)]
[ 1802.212231] CPU: 97 PID: 11282 Comm: rmmod Kdump: loaded Tainted: G     =
   W   E      6.10.0+ #2
[ 1802.212232] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, =
BIOS 3.0.ES.AL.P.087.05 04/07/2024
[ 1802.212232] RIP: 0010:amdgpu_bo_free_kernel+0xf9/0x120 [amdgpu]
[ 1802.212401] Code: 00 00 00 4d 85 e4 74 08 49 c7 04 24 00 00 00 00 48 85 =
ed 74 08 48 c7 45 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f=
> 0b e9 3b ff ff ff 3d 00 fe ff ff 74 b3 49 8b be b0 10 ff ff 4c
[ 1802.212402] RSP: 0018:ffffbe0e92087cb0 EFLAGS: 00010202
[ 1802.212403] RAX: 0000000000000206 RBX: ffff9cbc06c37f10 RCX: 00000000002=
0000d
[ 1802.212404] RDX: ffff9cbc06c37f18 RSI: ffff9cbc06c37f58 RDI: ffff9cbc06c=
37f10
[ 1802.212407] RBP: ffff9cbc06c37f18 R08: ffff9cba42388800 R09: 00000000002=
0000d
[ 1802.212409] R10: 0000000000040000 R11: 0000000000000006 R12: ffff9cbc06c=
37f58
[ 1802.212410] R13: ffff9cba4238dc00 R14: ffff9cbc06c0ef50 R15: ffff9cbc06c=
00000
[ 1802.212411] FS:  00007f927dc4e740(0000) GS:ffff9db47e880000(0000) knlGS:=
0000000000000000
[ 1802.212412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1802.212413] CR2: 000056342b2be1a8 CR3: 00000003f1546005 CR4: 0000000000f=
70ef0
[ 1802.212413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1802.212414] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 1802.212415] PKRU: 55555554
[ 1802.212415] Call Trace:
[ 1802.212416]  <TASK>
[ 1802.212417]  ? __warn+0x83/0x130
[ 1802.212419]  ? amdgpu_bo_free_kernel+0xf9/0x120 [amdgpu]
[ 1802.212586]  ? __report_bug+0xea/0x100
[ 1802.212588]  ? report_bug+0x24/0x70
[ 1802.212589]  ? handle_bug+0x3c/0x70
[ 1802.212590]  ? exc_invalid_op+0x18/0x70
[ 1802.212591]  ? asm_exc_invalid_op+0x1a/0x20
[ 1802.212594]  ? amdgpu_bo_free_kernel+0xf9/0x120 [amdgpu]
[ 1802.212746]  amdgpu_ring_fini+0x91/0x120 [amdgpu]
[ 1802.212901]  amdgpu_jpeg_sw_fini+0xb2/0xe0 [amdgpu]
[ 1802.213106]  amdgpu_device_ip_fini.isra.0+0xb1/0x1c0 [amdgpu]
[ 1802.213247]  amdgpu_device_fini_sw+0x49/0x290 [amdgpu]
[ 1802.213413]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[ 1802.213576]  devm_drm_dev_init_release+0x4e/0x70 [drm]
[ 1802.213602]  release_nodes+0x35/0xb0
[ 1802.213605]  devres_release_all+0x8f/0xd0
[ 1802.213606]  device_unbind_cleanup+0xe/0x70
[ 1802.213609]  device_release_driver_internal+0x1bc/0x200
[ 1802.213611]  driver_detach+0x48/0x90
[ 1802.213613]  bus_remove_driver+0x6d/0xf0
[ 1802.213615]  pci_unregister_driver+0x2e/0xb0
[ 1802.213618]  amdgpu_exit+0x15/0x1c4 [amdgpu]
[ 1802.213861]  __do_sys_delete_module.constprop.0+0x176/0x310
[ 1802.213863]  do_syscall_64+0x5d/0x170
[ 1802.213866]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1802.213869] RIP: 0033:0x7f927d6620cb
[ 1802.213870] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
[ 1802.213871] RSP: 002b:00007fff031d9d78 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000b0
[ 1802.213873] RAX: ffffffffffffffda RBX: 000055d8d6df69e0 RCX: 00007f927d6=
620cb
[ 1802.213873] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055d8d6d=
f6a48
[ 1802.213874] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[ 1802.213875] R10: 00007f927d7aaac0 R11: 0000000000000206 R12: 00007fff031=
d9fa0
[ 1802.213876] R13: 00007fff031da5f1 R14: 000055d8d6df62a0 R15: 000055d8d6d=
f69e0
[ 1802.213878]  </TASK>
[ 1802.213879] ---[ end trace 0000000000000000 ]---

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0a121aab5c74..5ff53a3b9851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4910,7 +4910,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l notify_clients)
 		amdgpu_virt_fini_data_exchange(adev);
 		r =3D amdgpu_virt_request_full_gpu(adev, false);
 		if (r)
-			return r;
+			goto error_out;
 	}
=20
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
@@ -4930,7 +4930,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l notify_clients)
=20
 	r =3D amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto error_out;
=20
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
=20
@@ -4943,9 +4943,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bo=
ol notify_clients)
=20
 	r =3D amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
-		return r;
+		goto error_out;
=20
 	return 0;
+error_out:
+	adev->in_suspend =3D false;
+	return r;
 }
=20
 /**
@@ -5007,8 +5010,10 @@ int amdgpu_device_resume(struct drm_device *dev, boo=
l notify_clients)
 		amdgpu_virt_release_full_gpu(adev, true);
 	}
=20
-	if (r)
+	if (r) {
+		adev->in_suspend =3D false;
 		return r;
+	}
=20
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
--=20
2.43.5

