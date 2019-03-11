From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix lockdep warning in RAS SYSFS v2
Date: Mon, 11 Mar 2019 17:36:42 +0100
Message-ID: <4e0fc908-f7dd-e42e-7c74-58f2847152ad@gmail.com>
References: <1552083648-9107-1-git-send-email-andrey.grodzovsky@amd.com>
 <1552084176-9496-1-git-send-email-andrey.grodzovsky@amd.com>
 <SN6PR12MB2800EC43EFB63A6434768B89874E0@SN6PR12MB2800.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1858806762=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB2800EC43EFB63A6434768B89874E0-kxOKjb6HO/EqkY47FTA1ogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
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
To: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1858806762==
Content-Type: multipart/alternative;
 boundary="------------4BD9D340E89FEBE96700E84E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4BD9D340E89FEBE96700E84E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Actually Andrey's solution looks sane to me as well.

Device attributes should be defined static for other good reasons.

Having the device attribute in the ras_manager is rather unusual.

Regards,
Christian.

Am 09.03.19 um 06:10 schrieb Pan, Xinhui:
> thanks for finding the problem.
>
> but NACK for the solution.
> struct attribute 
> <https://elixir.bootlin.com/linux/v4.18.20/ident/attribute> {
> ...
> bool ignore_lockdep 
> <https://elixir.bootlin.com/linux/v4.18.20/ident/ignore_lockdep>:1;
> ...
> }
> lockdef is useless here. I would like just set the ignore bit.
> ------------------------------------------------------------------------
> *From:* Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Saturday, March 9, 2019 6:29:36 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Pan, Xinhui; Grodzovsky, Andrey
> *Subject:* [PATCH v2] drm/amdgpu: Fix lockdep warning in RAS SYSFS v2
> Problem:
> When loading driver with debug lockdep enabled the WARN_ON as bellow
> was observed. Gooling about this warning i found the follwing 
> explanation -
> https://git.sphere.ly/tucstwo/cam-test/commit/671ee198b38694cf1dfbaa0b9ea823929517c367
>
> Fix:
> Switch all debugfs attributes in RAS to static
>
> v2: Add correct WARN_ON message to description.
>
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670622] 
> DEBUG_LOCKS_WARN_ON(1)
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670630] WARNING: CPU: 
> 5 PID: 1100 at kernel/locking/lockdep.c:3129 lockdep_init_map+0x288/0x290
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670761] Modules linked 
> in: amdgpu(O+) chash gpu_sched(O) ttm(O) drm_kms_helper(O) drm(O) 
> i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt intel_rapl 
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
> crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek 
> ghash_clmulni_intel snd_hda_codec_generic ledtrig_audio snd_hda_intel 
> snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi 
> snd_seq_midi_event aesni_intel snd_rawmidi aes_x86_64 crypto_simd 
> cryptd glue_helper eeepc_wmi snd_seq asus_wmi sparse_keymap wmi_bmof 
> snd_seq_device snd_timer serio_raw joydev snd soundcore mei_me mei 
> acpi_pad mac_hid binfmt_misc nfsd auth_rpcgss nfs_acl parport_pc lockd 
> ppdev grace lp parport sunrpc autofs4 hid_generic psmouse e1000e r8169 
> ahci libahci usbhid hid mxm_wmi wmi video
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670922] CPU: 5 PID: 
> 1100 Comm: modprobe Tainted: G           O 5.0.0-rc1-dev+ #37
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670991] Hardware name: 
> System manufacturer System Product Name/Z170-PRO, BIOS 1902 06/27/2016
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671061] RIP: 
> 0010:lockdep_init_map+0x288/0x290
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671127] Code: c7 34 3d 
> 1b 83 e8 08 fc 21 00 83 3d 35 4e 05 02 00 0f 85 df fe ff ff 48 c7 c6 
> 00 99 48 82 48 c7 c7 20 94 48 82 e8 b8 87 f6 ff <0f> 0b e9 c5 fe ff ff 
> 90 49 89 f0 31 c9 31 d2 31 f6 e9 32 8f 07 00
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671219] RSP: 
> 0018:ffff8883e0faf0e8 EFLAGS: 00010286
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671291] RAX: 
> 0000000000000000 RBX: ffff8883b07df348 RCX: ffffffff81165de4
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671364] RDX: 
> 0000000000000003 RSI: dffffc0000000000 RDI: 0000000000000246
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671437] RBP: 
> ffffffff8253e4e0 R08: fffffbfff05a271d R09: fffffbfff05a271d
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671510] R10: 
> 0000000000000001 R11: fffffbfff05a271c R12: ffff8883b07d2140
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671583] R13: 
> 0000000000001001 R14: 0000000000000000 R15: 0000000000000000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671656] FS: 
> 00007fcc21833700(0000) GS:ffff8883f4080000(0000) knlGS:0000000000000000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671737] CS: 0010 DS: 
> 0000 ES: 0000 CR0: 0000000080050033
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671809] CR2: 
> 000055b90a13b000 CR3: 00000003d96de005 CR4: 00000000003606e0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671882] DR0: 
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671955] DR3: 
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672027] Call Trace:
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672099] 
> __kernfs_create_file+0x9d/0x150
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672171] 
> sysfs_add_file_mode_ns+0x11d/0x270
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672246] 
> internal_create_group+0x218/0x600
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672324]  ? 
> remove_files.isra.1+0xa0/0xa0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672396]  ? 
> rcu_read_lock_sched_held+0x75/0x80
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672555]  ? 
> amdgpu_ras_create_obj+0x10c/0x130 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672703]  ? 
> __amdgpu_ras_feature_enable+0x109/0x200 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672862] 
> amdgpu_ras_init+0x41e/0x560 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673012]  ? 
> amdgpu_ras_reserve_bad_pages+0x5e0/0x5e0 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673086]  ? 
> __mutex_unlock_slowpath+0xda/0x420
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673162]  ? 
> wait_for_completion+0x200/0x200
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673240]  ? 
> idr_alloc_u32+0x1b0/0x1b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673349]  ? 
> drm_property_create+0x18a/0x200 [drm]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673500] 
> amdgpu_device_init+0x15fc/0x2950 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673646]  ? 
> amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673720]  ? 
> __alloc_pages_nodemask+0x232/0x460
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673792]  ? 
> __alloc_pages_slowpath+0x1370/0x1370
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673864]  ? 
> __mutex_unlock_slowpath+0xda/0x420
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673936]  ? 
> policy_nodemask+0x19/0xa0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674008]  ? 
> kasan_unpoison_shadow+0x36/0x50
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674079]  ? 
> kasan_kmalloc_large+0x9a/0xe0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674222] 
> amdgpu_driver_load_kms+0x101/0x540 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674371]  ? 
> amdgpu_driver_unload_kms+0x220/0x220 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674458]  ? 
> drm_dev_register+0x1a4/0x320 [drm]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674530]  ? 
> __kasan_slab_free+0x138/0x170
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674617] 
> drm_dev_register+0x1fd/0x320 [drm]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674761] 
> amdgpu_pci_probe+0xef/0x1a0 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674904]  ? 
> amdgpu_pci_remove+0x60/0x60 [amdgpu]
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674977] 
> local_pci_probe+0x76/0xe0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675048] 
> pci_device_probe+0x205/0x300
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675119]  ? 
> kernfs_create_link+0xae/0x100
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675191]  ? 
> pci_device_remove+0x1c0/0x1c0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675264] 
> really_probe+0x382/0x5e0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675336] 
> driver_probe_device+0x171/0x1b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675408] 
> __driver_attach+0x193/0x1a0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675479]  ? 
> driver_probe_device+0x1b0/0x1b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675550] 
> bus_for_each_dev+0xe4/0x160
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675621]  ? 
> lock_downgrade+0x2f0/0x2f0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675691]  ? 
> subsys_dev_iter_exit+0x10/0x10
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675764] 
> bus_add_driver+0x322/0x3a0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675836] 
> driver_register+0xc6/0x1a0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675907]  ? 
> 0xffffffffa1090000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675978] 
> do_one_initcall+0xb8/0x29f
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676049]  ? 
> trace_event_raw_event_initcall_finish+0x150/0x150
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676122]  ? 
> kasan_unpoison_shadow+0x36/0x50
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676193]  ? 
> kasan_kmalloc+0xae/0xf0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676264]  ? 
> kmem_cache_alloc_trace+0x14d/0x2b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676336]  ? 
> do_init_module+0x35/0x335
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676406]  ? 
> kasan_unpoison_shadow+0x36/0x50
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676479] 
> do_init_module+0xec/0x335
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676550] 
> load_module+0x3d5d/0x4780
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676627]  ? 
> module_frob_arch_sections+0x20/0x20
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676700]  ? 
> ima_read_file+0x10/0x10
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676770]  ? 
> vfs_read+0x127/0x190
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676842]  ? 
> kernel_read+0x74/0xa0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676913]  ? 
> kernel_read_file+0x16c/0x350
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676986]  ? 
> apparmor_task_free+0xc0/0xc0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677057]  ? 
> do_mmap+0x55e/0x790
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677130]  ? 
> __do_sys_finit_module+0x175/0x1b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677201] 
> __do_sys_finit_module+0x175/0x1b0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677273]  ? 
> __ia32_sys_init_module+0x40/0x40
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677344]  ? 
> check_chain_key+0x131/0x1e0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677416]  ? 
> syscall_trace_enter+0x1fc/0x530
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677491]  ? 
> vtime_user_exit+0xc8/0xe0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677563] 
> do_syscall_64+0x7d/0x1f0
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677634] 
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677706] RIP: 
> 0033:0x7fcc213654d9
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677776] Code: 00 f3 c3 
> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 
> 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 
> 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677873] RSP: 
> 002b:00007ffc8d3c2888 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677954] RAX: 
> ffffffffffffffda RBX: 000055b90a1363b0 RCX: 00007fcc213654d9
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678027] RDX: 
> 0000000000000000 RSI: 000055b9091b926b RDI: 000000000000000d
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678100] RBP: 
> 000055b9091b926b R08: 0000000000000000 R09: 0000000000000000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678173] R10: 
> 000000000000000d R11: 0000000000000246 R12: 0000000000000000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678246] R13: 
> 000055b90a13aa30 R14: 0000000000040000 R15: 0000000000040000
> Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678322] ---[ end trace 
> d006c1f8e03b5e65 ]---
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 
> ++++++++++++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --
>  2 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index bf462c5..b0575b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -77,8 +77,7 @@ struct ras_manager {
>          struct amdgpu_device *adev;
>          /* debugfs */
>          struct dentry *ent;
> -       /* sysfs */
> -       struct device_attribute sysfs_attr;
> +
>          int attr_inuse;
>
>          /* fs node name */
> @@ -374,10 +373,17 @@ static const struct file_operations 
> amdgpu_ras_debugfs_ctrl_ops = {
>          .llseek = default_llseek
>  };
>
> +static struct ras_sysfs_attr {
> +       struct device_attribute sysfs_attrs;
> +       struct ras_manager *obj;
> +} ras_sysfs_attrs[AMDGPU_RAS_BLOCK__LAST];
> +
>  static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
>                  struct device_attribute *attr, char *buf)
>  {
> -       struct ras_manager *obj = container_of(attr, struct 
> ras_manager, sysfs_attr);
> +       struct ras_sysfs_attr *ras_sysfs_attr = container_of(attr, 
> struct ras_sysfs_attr, sysfs_attrs);
> +       struct ras_manager *obj = ras_sysfs_attr->obj;
> +
>          struct ras_query_if info = {
>                  .head = obj->head,
>          };
> @@ -694,10 +700,9 @@ int amdgpu_ras_query_error_count(struct 
> amdgpu_device *adev,
>  static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
>                  struct device_attribute *attr, char *buf)
>  {
> -       struct amdgpu_ras *con =
> -               container_of(attr, struct amdgpu_ras, features_attr);
>          struct drm_device *ddev = dev_get_drvdata(dev);
>          struct amdgpu_device *adev = ddev->dev_private;
> +       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>          struct ras_common_if head;
>          int ras_block_count = AMDGPU_RAS_BLOCK_COUNT;
>          int i;
> @@ -724,11 +729,12 @@ static ssize_t 
> amdgpu_ras_sysfs_features_read(struct device *dev,
>          return s;
>  }
>
> +static DEVICE_ATTR(features, S_IRUGO, amdgpu_ras_sysfs_features_read, 
> NULL);
> +
>  static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device 
> *adev)
>  {
> -       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>          struct attribute *attrs[] = {
> -               &con->features_attr.attr,
> +               &dev_attr_features.attr,
>                  NULL
>          };
>          struct attribute_group group = {
> @@ -736,22 +742,13 @@ static int 
> amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
>                  .attrs = attrs,
>          };
>
> -       con->features_attr = (struct device_attribute) {
> -               .attr = {
> -                       .name = "features",
> -                       .mode = S_IRUGO,
> -               },
> -                       .show = amdgpu_ras_sysfs_features_read,
> -       };
> -
>          return sysfs_create_group(&adev->dev->kobj, &group);
>  }
>
>  static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device 
> *adev)
>  {
> -       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>          struct attribute *attrs[] = {
> -               &con->features_attr.attr,
> +               &dev_attr_features.attr,
>                  NULL
>          };
>          struct attribute_group group = {
> @@ -778,17 +775,22 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device 
> *adev,
>                          head->sysfs_name,
> sizeof(obj->fs_data.sysfs_name));
>
> -       obj->sysfs_attr = (struct device_attribute){
> -               .attr = {
> -                       .name = obj->fs_data.sysfs_name,
> -                       .mode = S_IRUGO,
> +
> +
> +       ras_sysfs_attrs[head->head.block] = (struct ras_sysfs_attr){
> +               .sysfs_attrs = {
> +                       .attr = {
> +                               .name = obj->fs_data.sysfs_name,
> +                               .mode = S_IRUGO,
> +                       },
> +                               .show = amdgpu_ras_sysfs_read,
>                  },
> -                       .show = amdgpu_ras_sysfs_read,
> +               .obj = obj
>          };
>
>          if (sysfs_add_file_to_group(&adev->dev->kobj,
> - &obj->sysfs_attr.attr,
> -                               "ras")) {
> + &ras_sysfs_attrs[head->head.block].sysfs_attrs.attr,
> +                                   "ras")) {
>                  put_obj(obj);
>                  return -EINVAL;
>          }
> @@ -807,8 +809,10 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device 
> *adev,
>                  return -EINVAL;
>
> sysfs_remove_file_from_group(&adev->dev->kobj,
> - &obj->sysfs_attr.attr,
> + &ras_sysfs_attrs[head->block].sysfs_attrs.attr,
>                                  "ras");
> +
> +       ras_sysfs_attrs[head->block].obj = NULL;
>          obj->attr_inuse = 0;
>          put_obj(obj);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 02cb9a1..b572bae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -88,8 +88,6 @@ struct amdgpu_ras {
>          struct dentry *dir;
>          /* debugfs ctrl */
>          struct dentry *ent;
> -       /* sysfs */
> -       struct device_attribute features_attr;
>          /* block array */
>          struct ras_manager *objs;
>
> -- 
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------4BD9D340E89FEBE96700E84E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Actually Andrey's solution looks sane
      to me as well.<br>
      <br>
      Device attributes should be defined static for other good reasons.<br>
      <br>
      Having the device attribute in the ras_manager is rather unusual.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.03.19 um 06:10 schrieb Pan, Xinhui:<br>
    </div>
    <blockquote type="cite"
cite="mid:SN6PR12MB2800EC43EFB63A6434768B89874E0-kxOKjb6HO/EqkY47FTA1ogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          thanks for finding the problem.<br>
          <br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          but NACK for the solution.<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          struct <a
            href="https://elixir.bootlin.com/linux/v4.18.20/ident/attribute"
            moz-do-not-send="true">attribute</a> {<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          ...<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          bool <a
            href="https://elixir.bootlin.com/linux/v4.18.20/ident/ignore_lockdep"
            moz-do-not-send="true">ignore_lockdep</a>:1;<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          ...<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          }<br>
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          lockdef is useless here. I would like just set the ignore bit.<br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Saturday, March 9, 2019 6:29:36 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Cc:</b> Pan, Xinhui; Grodzovsky, Andrey<br>
            <b>Subject:</b> [PATCH v2] drm/amdgpu: Fix lockdep warning
            in RAS SYSFS v2</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:11pt;">
          <div class="PlainText">Problem:<br>
            When loading driver with debug lockdep enabled the WARN_ON
            as bellow<br>
            was observed. Gooling about this warning i found the
            follwing explanation -<br>
            <a
href="https://git.sphere.ly/tucstwo/cam-test/commit/671ee198b38694cf1dfbaa0b9ea823929517c367"
              moz-do-not-send="true">https://git.sphere.ly/tucstwo/cam-test/commit/671ee198b38694cf1dfbaa0b9ea823929517c367</a><br>
            <br>
            Fix:<br>
            Switch all debugfs attributes in RAS to static<br>
            <br>
            v2: Add correct WARN_ON message to description.<br>
            <br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670622]
            DEBUG_LOCKS_WARN_ON(1)<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670630]
            WARNING: CPU: 5 PID: 1100 at kernel/locking/lockdep.c:3129
            lockdep_init_map+0x288/0x290<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670761]
            Modules linked in: amdgpu(O+) chash gpu_sched(O) ttm(O)
            drm_kms_helper(O) drm(O) i2c_algo_bit fb_sys_fops
            syscopyarea sysfillrect sysimgblt intel_rapl
            x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
            irqbypass crct10dif_pclmul crc32_pclmul
            snd_hda_codec_realtek ghash_clmulni_intel
            snd_hda_codec_generic ledtrig_audio snd_hda_intel
            snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi
            snd_seq_midi_event aesni_intel snd_rawmidi aes_x86_64
            crypto_simd cryptd glue_helper eeepc_wmi snd_seq asus_wmi
            sparse_keymap wmi_bmof snd_seq_device snd_timer serio_raw
            joydev snd soundcore mei_me mei acpi_pad mac_hid binfmt_misc
            nfsd auth_rpcgss nfs_acl parport_pc lockd ppdev grace lp
            parport sunrpc autofs4 hid_generic psmouse e1000e r8169 ahci
            libahci usbhid hid mxm_wmi wmi video<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670922] CPU:
            5 PID: 1100 Comm: modprobe Tainted: G           O     
            5.0.0-rc1-dev+ #37<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670991]
            Hardware name: System manufacturer System Product
            Name/Z170-PRO, BIOS 1902 06/27/2016<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671061] RIP:
            0010:lockdep_init_map+0x288/0x290<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671127]
            Code: c7 34 3d 1b 83 e8 08 fc 21 00 83 3d 35 4e 05 02 00 0f
            85 df fe ff ff 48 c7 c6 00 99 48 82 48 c7 c7 20 94 48 82 e8
            b8 87 f6 ff &lt;0f&gt; 0b e9 c5 fe ff ff 90 49 89 f0 31 c9
            31 d2 31 f6 e9 32 8f 07 00<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671219] RSP:
            0018:ffff8883e0faf0e8 EFLAGS: 00010286<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671291] RAX:
            0000000000000000 RBX: ffff8883b07df348 RCX: ffffffff81165de4<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671364] RDX:
            0000000000000003 RSI: dffffc0000000000 RDI: 0000000000000246<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671437] RBP:
            ffffffff8253e4e0 R08: fffffbfff05a271d R09: fffffbfff05a271d<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671510] R10:
            0000000000000001 R11: fffffbfff05a271c R12: ffff8883b07d2140<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671583] R13:
            0000000000001001 R14: 0000000000000000 R15: 0000000000000000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671656] FS: 
            00007fcc21833700(0000) GS:ffff8883f4080000(0000)
            knlGS:0000000000000000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671737] CS: 
            0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671809] CR2:
            000055b90a13b000 CR3: 00000003d96de005 CR4: 00000000003606e0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671882] DR0:
            0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671955] DR3:
            0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672027] Call
            Trace:<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672099] 
            __kernfs_create_file+0x9d/0x150<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672171] 
            sysfs_add_file_mode_ns+0x11d/0x270<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672246] 
            internal_create_group+0x218/0x600<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672324]  ?
            remove_files.isra.1+0xa0/0xa0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672396]  ?
            rcu_read_lock_sched_held+0x75/0x80<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672555]  ?
            amdgpu_ras_create_obj+0x10c/0x130 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672703]  ?
            __amdgpu_ras_feature_enable+0x109/0x200 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672862] 
            amdgpu_ras_init+0x41e/0x560 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673012]  ?
            amdgpu_ras_reserve_bad_pages+0x5e0/0x5e0 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673086]  ?
            __mutex_unlock_slowpath+0xda/0x420<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673162]  ?
            wait_for_completion+0x200/0x200<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673240]  ?
            idr_alloc_u32+0x1b0/0x1b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673349]  ?
            drm_property_create+0x18a/0x200 [drm]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673500] 
            amdgpu_device_init+0x15fc/0x2950 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673646]  ?
            amdgpu_device_has_dc_support+0x30/0x30 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673720]  ?
            __alloc_pages_nodemask+0x232/0x460<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673792]  ?
            __alloc_pages_slowpath+0x1370/0x1370<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673864]  ?
            __mutex_unlock_slowpath+0xda/0x420<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673936]  ?
            policy_nodemask+0x19/0xa0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674008]  ?
            kasan_unpoison_shadow+0x36/0x50<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674079]  ?
            kasan_kmalloc_large+0x9a/0xe0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674222] 
            amdgpu_driver_load_kms+0x101/0x540 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674371]  ?
            amdgpu_driver_unload_kms+0x220/0x220 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674458]  ?
            drm_dev_register+0x1a4/0x320 [drm]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674530]  ?
            __kasan_slab_free+0x138/0x170<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674617] 
            drm_dev_register+0x1fd/0x320 [drm]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674761] 
            amdgpu_pci_probe+0xef/0x1a0 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674904]  ?
            amdgpu_pci_remove+0x60/0x60 [amdgpu]<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674977] 
            local_pci_probe+0x76/0xe0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675048] 
            pci_device_probe+0x205/0x300<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675119]  ?
            kernfs_create_link+0xae/0x100<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675191]  ?
            pci_device_remove+0x1c0/0x1c0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675264] 
            really_probe+0x382/0x5e0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675336] 
            driver_probe_device+0x171/0x1b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675408] 
            __driver_attach+0x193/0x1a0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675479]  ?
            driver_probe_device+0x1b0/0x1b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675550] 
            bus_for_each_dev+0xe4/0x160<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675621]  ?
            lock_downgrade+0x2f0/0x2f0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675691]  ?
            subsys_dev_iter_exit+0x10/0x10<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675764] 
            bus_add_driver+0x322/0x3a0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675836] 
            driver_register+0xc6/0x1a0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675907]  ?
            0xffffffffa1090000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675978] 
            do_one_initcall+0xb8/0x29f<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676049]  ?
            trace_event_raw_event_initcall_finish+0x150/0x150<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676122]  ?
            kasan_unpoison_shadow+0x36/0x50<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676193]  ?
            kasan_kmalloc+0xae/0xf0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676264]  ?
            kmem_cache_alloc_trace+0x14d/0x2b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676336]  ?
            do_init_module+0x35/0x335<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676406]  ?
            kasan_unpoison_shadow+0x36/0x50<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676479] 
            do_init_module+0xec/0x335<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676550] 
            load_module+0x3d5d/0x4780<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676627]  ?
            module_frob_arch_sections+0x20/0x20<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676700]  ?
            ima_read_file+0x10/0x10<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676770]  ?
            vfs_read+0x127/0x190<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676842]  ?
            kernel_read+0x74/0xa0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676913]  ?
            kernel_read_file+0x16c/0x350<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676986]  ?
            apparmor_task_free+0xc0/0xc0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677057]  ?
            do_mmap+0x55e/0x790<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677130]  ?
            __do_sys_finit_module+0x175/0x1b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677201] 
            __do_sys_finit_module+0x175/0x1b0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677273]  ?
            __ia32_sys_init_module+0x40/0x40<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677344]  ?
            check_chain_key+0x131/0x1e0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677416]  ?
            syscall_trace_enter+0x1fc/0x530<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677491]  ?
            vtime_user_exit+0xc8/0xe0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677563] 
            do_syscall_64+0x7d/0x1f0<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677634] 
            entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677706] RIP:
            0033:0x7fcc213654d9<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677776]
            Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48
            89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c
            24 08 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f
            29 2c 00 f7 d8 64 89 01 48<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677873] RSP:
            002b:00007ffc8d3c2888 EFLAGS: 00000246 ORIG_RAX:
            0000000000000139<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677954] RAX:
            ffffffffffffffda RBX: 000055b90a1363b0 RCX: 00007fcc213654d9<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678027] RDX:
            0000000000000000 RSI: 000055b9091b926b RDI: 000000000000000d<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678100] RBP:
            000055b9091b926b R08: 0000000000000000 R09: 0000000000000000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678173] R10:
            000000000000000d R11: 0000000000000246 R12: 0000000000000000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678246] R13:
            000055b90a13aa30 R14: 0000000000040000 R15: 0000000000040000<br>
            Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678322] ---[
            end trace d006c1f8e03b5e65 ]---<br>
            <br>
            Signed-off-by: Andrey Grodzovsky
            <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            ---<br>
             drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54
            ++++++++++++++++++---------------<br>
             drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --<br>
             2 files changed, 29 insertions(+), 27 deletions(-)<br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
            index bf462c5..b0575b6 100644<br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
            @@ -77,8 +77,7 @@ struct ras_manager {<br>
                     struct amdgpu_device *adev;<br>
                     /* debugfs */<br>
                     struct dentry *ent;<br>
            -       /* sysfs */<br>
            -       struct device_attribute sysfs_attr;<br>
            +<br>
                     int attr_inuse;<br>
             <br>
                     /* fs node name */<br>
            @@ -374,10 +373,17 @@ static const struct file_operations
            amdgpu_ras_debugfs_ctrl_ops = {<br>
                     .llseek = default_llseek<br>
             };<br>
             <br>
            +static struct ras_sysfs_attr {<br>
            +       struct device_attribute sysfs_attrs;<br>
            +       struct ras_manager *obj;<br>
            +} ras_sysfs_attrs[AMDGPU_RAS_BLOCK__LAST];<br>
            +<br>
             static ssize_t amdgpu_ras_sysfs_read(struct device *dev,<br>
                             struct device_attribute *attr, char *buf)<br>
             {<br>
            -       struct ras_manager *obj = container_of(attr, struct
            ras_manager, sysfs_attr);<br>
            +       struct ras_sysfs_attr *ras_sysfs_attr =
            container_of(attr, struct ras_sysfs_attr, sysfs_attrs);<br>
            +       struct ras_manager *obj = ras_sysfs_attr-&gt;obj;<br>
            +<br>
                     struct ras_query_if info = {<br>
                             .head = obj-&gt;head,<br>
                     };<br>
            @@ -694,10 +700,9 @@ int amdgpu_ras_query_error_count(struct
            amdgpu_device *adev,<br>
             static ssize_t amdgpu_ras_sysfs_features_read(struct device
            *dev,<br>
                             struct device_attribute *attr, char *buf)<br>
             {<br>
            -       struct amdgpu_ras *con =<br>
            -               container_of(attr, struct amdgpu_ras,
            features_attr);<br>
                     struct drm_device *ddev = dev_get_drvdata(dev);<br>
                     struct amdgpu_device *adev = ddev-&gt;dev_private;<br>
            +       struct amdgpu_ras *con =
            amdgpu_ras_get_context(adev);<br>
                     struct ras_common_if head;<br>
                     int ras_block_count = AMDGPU_RAS_BLOCK_COUNT;<br>
                     int i;<br>
            @@ -724,11 +729,12 @@ static ssize_t
            amdgpu_ras_sysfs_features_read(struct device *dev,<br>
                     return s;<br>
             }<br>
             <br>
            +static DEVICE_ATTR(features, S_IRUGO,
            amdgpu_ras_sysfs_features_read, NULL);<br>
            +<br>
             static int amdgpu_ras_sysfs_create_feature_node(struct
            amdgpu_device *adev)<br>
             {<br>
            -       struct amdgpu_ras *con =
            amdgpu_ras_get_context(adev);<br>
                     struct attribute *attrs[] = {<br>
            -               &amp;con-&gt;features_attr.attr,<br>
            +               &amp;dev_attr_features.attr,<br>
                             NULL<br>
                     };<br>
                     struct attribute_group group = {<br>
            @@ -736,22 +742,13 @@ static int
            amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device
            *adev)<br>
                             .attrs = attrs,<br>
                     };<br>
             <br>
            -       con-&gt;features_attr = (struct device_attribute) {<br>
            -               .attr = {<br>
            -                       .name = "features",<br>
            -                       .mode = S_IRUGO,<br>
            -               },<br>
            -                       .show =
            amdgpu_ras_sysfs_features_read,<br>
            -       };<br>
            -<br>
                     return
            sysfs_create_group(&amp;adev-&gt;dev-&gt;kobj, &amp;group);<br>
             }<br>
             <br>
             static int amdgpu_ras_sysfs_remove_feature_node(struct
            amdgpu_device *adev)<br>
             {<br>
            -       struct amdgpu_ras *con =
            amdgpu_ras_get_context(adev);<br>
                     struct attribute *attrs[] = {<br>
            -               &amp;con-&gt;features_attr.attr,<br>
            +               &amp;dev_attr_features.attr,<br>
                             NULL<br>
                     };<br>
                     struct attribute_group group = {<br>
            @@ -778,17 +775,22 @@ int amdgpu_ras_sysfs_create(struct
            amdgpu_device *adev,<br>
                                     head-&gt;sysfs_name,<br>
                                    
            sizeof(obj-&gt;fs_data.sysfs_name));<br>
             <br>
            -       obj-&gt;sysfs_attr = (struct device_attribute){<br>
            -               .attr = {<br>
            -                       .name = obj-&gt;fs_data.sysfs_name,<br>
            -                       .mode = S_IRUGO,<br>
            +<br>
            +<br>
            +       ras_sysfs_attrs[head-&gt;head.block] = (struct
            ras_sysfs_attr){<br>
            +               .sysfs_attrs = {<br>
            +                       .attr = {<br>
            +                               .name =
            obj-&gt;fs_data.sysfs_name,<br>
            +                               .mode = S_IRUGO,<br>
            +                       },<br>
            +                               .show =
            amdgpu_ras_sysfs_read,<br>
                             },<br>
            -                       .show = amdgpu_ras_sysfs_read,<br>
            +               .obj = obj<br>
                     };<br>
             <br>
                     if
            (sysfs_add_file_to_group(&amp;adev-&gt;dev-&gt;kobj,<br>
            -                              
            &amp;obj-&gt;sysfs_attr.attr,<br>
            -                               "ras")) {<br>
            +                                  
            &amp;ras_sysfs_attrs[head-&gt;head.block].sysfs_attrs.attr,<br>
            +                                   "ras")) {<br>
                             put_obj(obj);<br>
                             return -EINVAL;<br>
                     }<br>
            @@ -807,8 +809,10 @@ int amdgpu_ras_sysfs_remove(struct
            amdgpu_device *adev,<br>
                             return -EINVAL;<br>
             <br>
                    
            sysfs_remove_file_from_group(&amp;adev-&gt;dev-&gt;kobj,<br>
            -                              
            &amp;obj-&gt;sysfs_attr.attr,<br>
            +                              
            &amp;ras_sysfs_attrs[head-&gt;block].sysfs_attrs.attr,<br>
                                             "ras");<br>
            +<br>
            +       ras_sysfs_attrs[head-&gt;block].obj = NULL;<br>
                     obj-&gt;attr_inuse = 0;<br>
                     put_obj(obj);<br>
             <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
            index 02cb9a1..b572bae 100644<br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
            @@ -88,8 +88,6 @@ struct amdgpu_ras {<br>
                     struct dentry *dir;<br>
                     /* debugfs ctrl */<br>
                     struct dentry *ent;<br>
            -       /* sysfs */<br>
            -       struct device_attribute features_attr;<br>
                     /* block array */<br>
                     struct ras_manager *objs;<br>
             <br>
            -- <br>
            2.7.4<br>
            <br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4BD9D340E89FEBE96700E84E--

--===============1858806762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1858806762==--
