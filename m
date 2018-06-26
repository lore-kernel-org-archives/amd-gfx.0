From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: DCN/PP regression
Date: Tue, 26 Jun 2018 12:44:02 +0200
Message-ID: <05b5d7ff-1a76-fbaa-aae7-0a4ed4ccc96b@daenzer.net>
References: <3d69a07b-c09a-e23b-13b6-e28506195e65@amd.com>
 <f18aaf77-2ad9-690f-19c5-21c01fb3e24f@daenzer.net>
 <297ba259-4d3f-f43b-7339-98c2fc402737@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3A039B9FD2C454EA5112A5B7"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <297ba259-4d3f-f43b-7339-98c2fc402737-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-CA
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>
Cc: Charlene.Liu-5C7GfCeVMHo@public.gmane.org, mikita.lipski-5C7GfCeVMHo@public.gmane.org, "Wentland,
 Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------3A039B9FD2C454EA5112A5B7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-06-26 11:09 AM, Michel Dänzer wrote:
> On 2018-06-26 10:39 AM, Michel Dänzer wrote:
>> On 2018-06-25 03:58 PM, Tom St Denis wrote:
>>> With a Tonga dGPU installed in a Raven1 system I see (attached) dmesg
>>> warning from init.
>>>
>>> Also, every warm reboot results in my Tonga failing to init (also
>>> attached).  If I cold reboot (hit the reset button) it works fine.
>>
>> FWIW, I'm not seeing either issue with my Tonga.
> 
> That being said, I just got the attached splats when stopping GDM.

Looks like these are happening (also when DPMS turns off the displays)
since "drm/amd/display: redesign dce/dcn clock voltage update request".
Attaching the splats again for Dmytro's convenience.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------3A039B9FD2C454EA5112A5B7
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jun 26 11:02:59 kaveri kernel: [  111.312545] WARNING: CPU: 12 PID: 132 a=
t drivers/gpu/drm//amd/amdgpu/../display/dc/dce100/dce100_hw_sequencer.c:=
154 dce100_set_bandwidth+0x154/0x300 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.312555] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) edac_mce_amd(E) amdkfd(OE) binfmt_misc(E) kvm(E) nls_ascii(E) amd=
gpu(OE) nls_cp437(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) vfa=
t(E) snd_hda_codec_realtek(E) ghash_clmulni_intel(E) fat(E) wmi_bmof(E) p=
cbc(E) snd_hda_codec_generic(E) chash(OE) gpu_sched(OE) radeon(OE) snd_hd=
a_codec_hdmi(E) snd_hda_intel(E) ttm(OE) snd_hda_codec(E) aesni_intel(E) =
drm_kms_helper(OE) snd_hda_core(E) aes_x86_64(E) crypto_simd(E) snd_hwdep=
(E) cryptd(E) efi_pstore(E) drm(OE) glue_helper(E) snd_pcm(E) i2c_algo_bi=
t(E) pcspkr(E) snd_timer(E) fb_sys_fops(E) efivars(E) r8169(E) sp5100_tco=
(E) ccp(E) syscopyarea(E) snd(E) sysfillrect(E) k10temp(E) mii(E) sg(E) s=
ysimgblt(E) soundcore(E) rng_core(E) i2c_piix4(E)
Jun 26 11:02:59 kaveri kernel: [  111.312668]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efivarfs(E)=
 ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) m=
bcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multi=
path(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) h=
id(E) xhci_pci(E) ahci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_intel(E=
) scsi_mod(E) usbcore(E) shpchp(E) gpio_amdpt(E) gpio_generic(E)
Jun 26 11:02:59 kaveri kernel: [  111.312750] CPU: 12 PID: 132 Comm: kwor=
ker/12:1 Tainted: G    B      OE     4.17.0-rc5+ #108
Jun 26 11:02:59 kaveri kernel: [  111.312756] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jun 26 11:02:59 kaveri kernel: [  111.312792] Workqueue: events drm_mode_=
rmfb_work_fn [drm]
Jun 26 11:02:59 kaveri kernel: [  111.312927] RIP: 0010:dce100_set_bandwi=
dth+0x154/0x300 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.312932] RSP: 0018:ffff8803ea6df708 =
EFLAGS: 00010246
Jun 26 11:02:59 kaveri kernel: [  111.312939] RAX: 1ffff10079f102d0 RBX: =
ffff8803cf881ab0 RCX: 0000000000000000
Jun 26 11:02:59 kaveri kernel: [  111.312945] RDX: ffff8803cf881ab0 RSI: =
0000000000000000 RDI: ffff8803cf881c5c
Jun 26 11:02:59 kaveri kernel: [  111.312950] RBP: dffffc0000000000 R08: =
ffff8803ea6df770 R09: ffffed0087e6f82b
Jun 26 11:02:59 kaveri kernel: [  111.312955] R10: 0000000000000001 R11: =
ffffed0087e6f82a R12: 1ffff1007d4dbee3
Jun 26 11:02:59 kaveri kernel: [  111.312960] R13: ffff8803c3fea200 R14: =
0000000000000000 R15: ffff8803cf880000
Jun 26 11:02:59 kaveri kernel: [  111.312966] FS:  0000000000000000(0000)=
 GS:ffff8803ee300000(0000) knlGS:0000000000000000
Jun 26 11:02:59 kaveri kernel: [  111.312972] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jun 26 11:02:59 kaveri kernel: [  111.312977] CR2: 00007faa6e01a040 CR3: =
000000037ff8c000 CR4: 00000000003406e0
Jun 26 11:02:59 kaveri kernel: [  111.312981] Call Trace:
Jun 26 11:02:59 kaveri kernel: [  111.313117]  ? dce100_pplib_apply_displ=
ay_requirements+0x1b0/0x1b0 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313251]  ? bios_is_accelerated_mode=
+0xdb/0x140 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313384]  ? bios_get_image+0xb0/0xb0=
 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313518]  dc_commit_state+0x707/0x16=
e0 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313533]  ? wait_for_completion_time=
out+0x81/0x390
Jun 26 11:02:59 kaveri kernel: [  111.313542]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun 26 11:02:59 kaveri kernel: [  111.313672]  ? dc_create+0x1b00/0x1b00 =
[amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313705]  ? drm_dev_dbg+0x1a0/0x1a0 =
[drm]
Jun 26 11:02:59 kaveri kernel: [  111.313715]  ? process_one_work+0x7c4/0=
x16b0
Jun 26 11:02:59 kaveri kernel: [  111.313721]  ? worker_thread+0xce/0xbe0=

Jun 26 11:02:59 kaveri kernel: [  111.313742]  ? drm_atomic_helper_swap_s=
tate+0x6ae/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.313751]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun 26 11:02:59 kaveri kernel: [  111.313884]  amdgpu_dm_atomic_commit_ta=
il+0x961/0x3f90 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.313899]  ? do_raw_spin_unlock+0x54/=
0x220
Jun 26 11:02:59 kaveri kernel: [  111.313906]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Jun 26 11:02:59 kaveri kernel: [  111.313913]  ? wait_for_completion_time=
out+0xc1/0x390
Jun 26 11:02:59 kaveri kernel: [  111.313932]  ? drm_atomic_helper_swap_s=
tate+0x79b/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.314059]  ? commit_planes_to_stream+=
0x1690/0x1690 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.314066]  ? lock_downgrade+0x5e0/0x5=
e0
Jun 26 11:02:59 kaveri kernel: [  111.314085]  ? drm_atomic_helper_swap_s=
tate+0x6ae/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.314210]  ? dm_plane_helper_prepare_=
fb+0x264/0x810 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.314233]  ? drm_atomic_helper_wait_f=
or_dependencies+0x3e9/0x7f0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.314255]  commit_tail+0x9a/0xf0 [drm=
_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.314275]  drm_atomic_helper_commit+0=
x1f1/0x230 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.314312]  atomic_remove_fb+0x56a/0x6=
f0 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.314350]  ? drm_framebuffer_unregist=
er_private+0x40/0x40 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.314363]  ? worker_thread+0x1f0/0xbe=
0
Jun 26 11:02:59 kaveri kernel: [  111.314400]  drm_framebuffer_remove+0x1=
07/0x360 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.314435]  drm_mode_rmfb_work_fn+0x10=
1/0x1e0 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.314445]  process_one_work+0x7c4/0x1=
6b0
Jun 26 11:02:59 kaveri kernel: [  111.314457]  ? drain_workqueue+0x380/0x=
380
Jun 26 11:02:59 kaveri kernel: [  111.314464]  ? lock_acquire+0x10b/0x330=

Jun 26 11:02:59 kaveri kernel: [  111.314477]  worker_thread+0xce/0xbe0
Jun 26 11:02:59 kaveri kernel: [  111.314489]  ? process_one_work+0x16b0/=
0x16b0
Jun 26 11:02:59 kaveri kernel: [  111.314496]  kthread+0x2db/0x390
Jun 26 11:02:59 kaveri kernel: [  111.314504]  ? kthread_create_worker_on=
_cpu+0xc0/0xc0
Jun 26 11:02:59 kaveri kernel: [  111.314512]  ret_from_fork+0x27/0x50
Jun 26 11:02:59 kaveri kernel: [  111.314524] Code: 28 84 c0 74 08 3c 03 =
0f 8e 7d 01 00 00 8b 83 10 01 00 00 41 39 c6 44 0f 42 f0 48 81 c3 30 04 0=
0 00 48 39 d3 75 90 45 85 f6 75 02 <0f> 0b 49 8d 9d 30 01 00 00 48 b8 00 =
00 00 00 00 fc ff df 44 89=20
Jun 26 11:02:59 kaveri kernel: [  111.314638] irq event stamp: 0
Jun 26 11:02:59 kaveri kernel: [  111.314644] hardirqs last  enabled at (=
0): [<0000000000000000>]           (null)
Jun 26 11:02:59 kaveri kernel: [  111.314652] hardirqs last disabled at (=
0): [<ffffffff8bf1559c>] copy_process.part.32+0x109c/0x5db0
Jun 26 11:02:59 kaveri kernel: [  111.314660] softirqs last  enabled at (=
0): [<ffffffff8bf1563a>] copy_process.part.32+0x113a/0x5db0
Jun 26 11:02:59 kaveri kernel: [  111.314665] softirqs last disabled at (=
0): [<0000000000000000>]           (null)
Jun 26 11:02:59 kaveri kernel: [  111.314669] ---[ end trace f80487e2fecc=
0221 ]---
Jun 26 11:02:59 kaveri kernel: [  111.357040] WARNING: CPU: 12 PID: 132 a=
t drivers/gpu/drm//amd/amdgpu/../display/dc/dce100/dce100_hw_sequencer.c:=
154 dce100_set_bandwidth+0x154/0x300 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.357050] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) edac_mce_amd(E) amdkfd(OE) binfmt_misc(E) kvm(E) nls_ascii(E) amd=
gpu(OE) nls_cp437(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) vfa=
t(E) snd_hda_codec_realtek(E) ghash_clmulni_intel(E) fat(E) wmi_bmof(E) p=
cbc(E) snd_hda_codec_generic(E) chash(OE) gpu_sched(OE) radeon(OE) snd_hd=
a_codec_hdmi(E) snd_hda_intel(E) ttm(OE) snd_hda_codec(E) aesni_intel(E) =
drm_kms_helper(OE) snd_hda_core(E) aes_x86_64(E) crypto_simd(E) snd_hwdep=
(E) cryptd(E) efi_pstore(E) drm(OE) glue_helper(E) snd_pcm(E) i2c_algo_bi=
t(E) pcspkr(E) snd_timer(E) fb_sys_fops(E) efivars(E) r8169(E) sp5100_tco=
(E) ccp(E) syscopyarea(E) snd(E) sysfillrect(E) k10temp(E) mii(E) sg(E) s=
ysimgblt(E) soundcore(E) rng_core(E) i2c_piix4(E)
Jun 26 11:02:59 kaveri kernel: [  111.357164]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efivarfs(E)=
 ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) m=
bcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multi=
path(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) h=
id(E) xhci_pci(E) ahci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_intel(E=
) scsi_mod(E) usbcore(E) shpchp(E) gpio_amdpt(E) gpio_generic(E)
Jun 26 11:02:59 kaveri kernel: [  111.357247] CPU: 12 PID: 132 Comm: kwor=
ker/12:1 Tainted: G    B   W  OE     4.17.0-rc5+ #108
Jun 26 11:02:59 kaveri kernel: [  111.357253] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jun 26 11:02:59 kaveri kernel: [  111.357290] Workqueue: events drm_mode_=
rmfb_work_fn [drm]
Jun 26 11:02:59 kaveri kernel: [  111.357424] RIP: 0010:dce100_set_bandwi=
dth+0x154/0x300 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.357429] RSP: 0018:ffff8803ea6df708 =
EFLAGS: 00010246
Jun 26 11:02:59 kaveri kernel: [  111.357437] RAX: 1ffff10079f102d0 RBX: =
ffff8803cf881ab0 RCX: 0000000000000000
Jun 26 11:02:59 kaveri kernel: [  111.357442] RDX: ffff8803cf881ab0 RSI: =
0000000000000000 RDI: ffff8803cf881c5c
Jun 26 11:02:59 kaveri kernel: [  111.357447] RBP: dffffc0000000000 R08: =
ffffed007a3d5cf2 R09: ffffed007a3d5cf2
Jun 26 11:02:59 kaveri kernel: [  111.357452] R10: ffff8803ea6df510 R11: =
ffffed007a3d5cf1 R12: 1ffff1007d4dbee3
Jun 26 11:02:59 kaveri kernel: [  111.357457] R13: ffff8803c3fea200 R14: =
0000000000000000 R15: ffff8803cf880000
Jun 26 11:02:59 kaveri kernel: [  111.357463] FS:  0000000000000000(0000)=
 GS:ffff8803ee300000(0000) knlGS:0000000000000000
Jun 26 11:02:59 kaveri kernel: [  111.357468] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jun 26 11:02:59 kaveri kernel: [  111.357473] CR2: 00007faa6e01a040 CR3: =
000000037ff8c000 CR4: 00000000003406e0
Jun 26 11:02:59 kaveri kernel: [  111.357478] Call Trace:
Jun 26 11:02:59 kaveri kernel: [  111.357616]  ? dce100_pplib_apply_displ=
ay_requirements+0x1b0/0x1b0 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.357751]  ? bios_is_accelerated_mode=
+0xdb/0x140 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.357888]  dc_commit_state+0xe0a/0x16=
e0 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.357903]  ? wait_for_completion_time=
out+0x81/0x390
Jun 26 11:02:59 kaveri kernel: [  111.357913]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun 26 11:02:59 kaveri kernel: [  111.358042]  ? dc_create+0x1b00/0x1b00 =
[amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.358075]  ? drm_dev_dbg+0x1a0/0x1a0 =
[drm]
Jun 26 11:02:59 kaveri kernel: [  111.358085]  ? process_one_work+0x7c4/0=
x16b0
Jun 26 11:02:59 kaveri kernel: [  111.358091]  ? worker_thread+0xce/0xbe0=

Jun 26 11:02:59 kaveri kernel: [  111.358112]  ? drm_atomic_helper_swap_s=
tate+0x6ae/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358121]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jun 26 11:02:59 kaveri kernel: [  111.358256]  amdgpu_dm_atomic_commit_ta=
il+0x961/0x3f90 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.358271]  ? do_raw_spin_unlock+0x54/=
0x220
Jun 26 11:02:59 kaveri kernel: [  111.358278]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Jun 26 11:02:59 kaveri kernel: [  111.358285]  ? wait_for_completion_time=
out+0xc1/0x390
Jun 26 11:02:59 kaveri kernel: [  111.358304]  ? drm_atomic_helper_swap_s=
tate+0x79b/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358432]  ? commit_planes_to_stream+=
0x1690/0x1690 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.358439]  ? lock_downgrade+0x5e0/0x5=
e0
Jun 26 11:02:59 kaveri kernel: [  111.358458]  ? drm_atomic_helper_swap_s=
tate+0x6ae/0x15b0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358584]  ? dm_plane_helper_prepare_=
fb+0x264/0x810 [amdgpu]
Jun 26 11:02:59 kaveri kernel: [  111.358606]  ? drm_atomic_helper_wait_f=
or_dependencies+0x3e9/0x7f0 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358629]  commit_tail+0x9a/0xf0 [drm=
_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358649]  drm_atomic_helper_commit+0=
x1f1/0x230 [drm_kms_helper]
Jun 26 11:02:59 kaveri kernel: [  111.358686]  atomic_remove_fb+0x56a/0x6=
f0 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.358725]  ? drm_framebuffer_unregist=
er_private+0x40/0x40 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.358738]  ? worker_thread+0x1f0/0xbe=
0
Jun 26 11:02:59 kaveri kernel: [  111.358775]  drm_framebuffer_remove+0x1=
07/0x360 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.358809]  drm_mode_rmfb_work_fn+0x10=
1/0x1e0 [drm]
Jun 26 11:02:59 kaveri kernel: [  111.358820]  process_one_work+0x7c4/0x1=
6b0
Jun 26 11:02:59 kaveri kernel: [  111.358832]  ? drain_workqueue+0x380/0x=
380
Jun 26 11:02:59 kaveri kernel: [  111.358839]  ? lock_acquire+0x10b/0x330=

Jun 26 11:02:59 kaveri kernel: [  111.358852]  worker_thread+0xce/0xbe0
Jun 26 11:02:59 kaveri kernel: [  111.358864]  ? process_one_work+0x16b0/=
0x16b0
Jun 26 11:02:59 kaveri kernel: [  111.358871]  kthread+0x2db/0x390
Jun 26 11:02:59 kaveri kernel: [  111.358878]  ? kthread_create_worker_on=
_cpu+0xc0/0xc0
Jun 26 11:02:59 kaveri kernel: [  111.358886]  ret_from_fork+0x27/0x50
Jun 26 11:02:59 kaveri kernel: [  111.358899] Code: 28 84 c0 74 08 3c 03 =
0f 8e 7d 01 00 00 8b 83 10 01 00 00 41 39 c6 44 0f 42 f0 48 81 c3 30 04 0=
0 00 48 39 d3 75 90 45 85 f6 75 02 <0f> 0b 49 8d 9d 30 01 00 00 48 b8 00 =
00 00 00 00 fc ff df 44 89=20
Jun 26 11:02:59 kaveri kernel: [  111.359014] irq event stamp: 0
Jun 26 11:02:59 kaveri kernel: [  111.359020] hardirqs last  enabled at (=
0): [<0000000000000000>]           (null)
Jun 26 11:02:59 kaveri kernel: [  111.359028] hardirqs last disabled at (=
0): [<ffffffff8bf1559c>] copy_process.part.32+0x109c/0x5db0
Jun 26 11:02:59 kaveri kernel: [  111.359036] softirqs last  enabled at (=
0): [<ffffffff8bf1563a>] copy_process.part.32+0x113a/0x5db0
Jun 26 11:02:59 kaveri kernel: [  111.359041] softirqs last disabled at (=
0): [<0000000000000000>]           (null)
Jun 26 11:02:59 kaveri kernel: [  111.359046] ---[ end trace f80487e2fecc=
0222 ]---

--------------3A039B9FD2C454EA5112A5B7
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------3A039B9FD2C454EA5112A5B7--
