From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix lockdep warning in RAS SYSFS v2
Date: Sat, 9 Mar 2019 05:10:18 +0000
Message-ID: <SN6PR12MB2800EC43EFB63A6434768B89874E0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <1552083648-9107-1-git-send-email-andrey.grodzovsky@amd.com>,
 <1552084176-9496-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793994969=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1552084176-9496-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

--===============0793994969==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800EC43EFB63A6434768B89874E0SN6PR12MB2800namp_"

--_000_SN6PR12MB2800EC43EFB63A6434768B89874E0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

thanks for finding the problem.

but NACK for the solution.
struct attribute<https://elixir.bootlin.com/linux/v4.18.20/ident/attribute>=
 {
...
bool ignore_lockdep<https://elixir.bootlin.com/linux/v4.18.20/ident/ignore_=
lockdep>:1;
...
}
lockdef is useless here. I would like just set the ignore bit.
________________________________
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Sent: Saturday, March 9, 2019 6:29:36 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Pan, Xinhui; Grodzovsky, Andrey
Subject: [PATCH v2] drm/amdgpu: Fix lockdep warning in RAS SYSFS v2

Problem:
When loading driver with debug lockdep enabled the WARN_ON as bellow
was observed. Gooling about this warning i found the follwing explanation -
https://git.sphere.ly/tucstwo/cam-test/commit/671ee198b38694cf1dfbaa0b9ea82=
3929517c367

Fix:
Switch all debugfs attributes in RAS to static

v2: Add correct WARN_ON message to description.

Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670622] DEBUG_LOCKS_WARN_ON=
(1)
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670630] WARNING: CPU: 5 PID=
: 1100 at kernel/locking/lockdep.c:3129 lockdep_init_map+0x288/0x290
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670761] Modules linked in: =
amdgpu(O+) chash gpu_sched(O) ttm(O) drm_kms_helper(O) drm(O) i2c_algo_bit =
fb_sys_fops syscopyarea sysfillrect sysimgblt intel_rapl x86_pkg_temp_therm=
al intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32=
_pclmul snd_hda_codec_realtek ghash_clmulni_intel snd_hda_codec_generic led=
trig_audio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_s=
eq_midi snd_seq_midi_event aesni_intel snd_rawmidi aes_x86_64 crypto_simd c=
ryptd glue_helper eeepc_wmi snd_seq asus_wmi sparse_keymap wmi_bmof snd_seq=
_device snd_timer serio_raw joydev snd soundcore mei_me mei acpi_pad mac_hi=
d binfmt_misc nfsd auth_rpcgss nfs_acl parport_pc lockd ppdev grace lp parp=
ort sunrpc autofs4 hid_generic psmouse e1000e r8169 ahci libahci usbhid hid=
 mxm_wmi wmi video
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670922] CPU: 5 PID: 1100 Co=
mm: modprobe Tainted: G           O      5.0.0-rc1-dev+ #37
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.670991] Hardware name: Syst=
em manufacturer System Product Name/Z170-PRO, BIOS 1902 06/27/2016
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671061] RIP: 0010:lockdep_i=
nit_map+0x288/0x290
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671127] Code: c7 34 3d 1b 8=
3 e8 08 fc 21 00 83 3d 35 4e 05 02 00 0f 85 df fe ff ff 48 c7 c6 00 99 48 8=
2 48 c7 c7 20 94 48 82 e8 b8 87 f6 ff <0f> 0b e9 c5 fe ff ff 90 49 89 f0 31=
 c9 31 d2 31 f6 e9 32 8f 07 00
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671219] RSP: 0018:ffff8883e=
0faf0e8 EFLAGS: 00010286
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671291] RAX: 00000000000000=
00 RBX: ffff8883b07df348 RCX: ffffffff81165de4
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671364] RDX: 00000000000000=
03 RSI: dffffc0000000000 RDI: 0000000000000246
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671437] RBP: ffffffff8253e4=
e0 R08: fffffbfff05a271d R09: fffffbfff05a271d
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671510] R10: 00000000000000=
01 R11: fffffbfff05a271c R12: ffff8883b07d2140
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671583] R13: 00000000000010=
01 R14: 0000000000000000 R15: 0000000000000000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671656] FS:  00007fcc218337=
00(0000) GS:ffff8883f4080000(0000) knlGS:0000000000000000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671737] CS:  0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671809] CR2: 000055b90a13b0=
00 CR3: 00000003d96de005 CR4: 00000000003606e0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671882] DR0: 00000000000000=
00 DR1: 0000000000000000 DR2: 0000000000000000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.671955] DR3: 00000000000000=
00 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672027] Call Trace:
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672099]  __kernfs_create_fi=
le+0x9d/0x150
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672171]  sysfs_add_file_mod=
e_ns+0x11d/0x270
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672246]  internal_create_gr=
oup+0x218/0x600
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672324]  ? remove_files.isr=
a.1+0xa0/0xa0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672396]  ? rcu_read_lock_sc=
hed_held+0x75/0x80
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672555]  ? amdgpu_ras_creat=
e_obj+0x10c/0x130 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672703]  ? __amdgpu_ras_fea=
ture_enable+0x109/0x200 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.672862]  amdgpu_ras_init+0x=
41e/0x560 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673012]  ? amdgpu_ras_reser=
ve_bad_pages+0x5e0/0x5e0 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673086]  ? __mutex_unlock_s=
lowpath+0xda/0x420
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673162]  ? wait_for_complet=
ion+0x200/0x200
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673240]  ? idr_alloc_u32+0x=
1b0/0x1b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673349]  ? drm_property_cre=
ate+0x18a/0x200 [drm]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673500]  amdgpu_device_init=
+0x15fc/0x2950 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673646]  ? amdgpu_device_ha=
s_dc_support+0x30/0x30 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673720]  ? __alloc_pages_no=
demask+0x232/0x460
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673792]  ? __alloc_pages_sl=
owpath+0x1370/0x1370
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673864]  ? __mutex_unlock_s=
lowpath+0xda/0x420
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.673936]  ? policy_nodemask+=
0x19/0xa0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674008]  ? kasan_unpoison_s=
hadow+0x36/0x50
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674079]  ? kasan_kmalloc_la=
rge+0x9a/0xe0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674222]  amdgpu_driver_load=
_kms+0x101/0x540 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674371]  ? amdgpu_driver_un=
load_kms+0x220/0x220 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674458]  ? drm_dev_register=
+0x1a4/0x320 [drm]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674530]  ? __kasan_slab_fre=
e+0x138/0x170
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674617]  drm_dev_register+0=
x1fd/0x320 [drm]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674761]  amdgpu_pci_probe+0=
xef/0x1a0 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674904]  ? amdgpu_pci_remov=
e+0x60/0x60 [amdgpu]
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.674977]  local_pci_probe+0x=
76/0xe0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675048]  pci_device_probe+0=
x205/0x300
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675119]  ? kernfs_create_li=
nk+0xae/0x100
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675191]  ? pci_device_remov=
e+0x1c0/0x1c0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675264]  really_probe+0x382=
/0x5e0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675336]  driver_probe_devic=
e+0x171/0x1b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675408]  __driver_attach+0x=
193/0x1a0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675479]  ? driver_probe_dev=
ice+0x1b0/0x1b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675550]  bus_for_each_dev+0=
xe4/0x160
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675621]  ? lock_downgrade+0=
x2f0/0x2f0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675691]  ? subsys_dev_iter_=
exit+0x10/0x10
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675764]  bus_add_driver+0x3=
22/0x3a0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675836]  driver_register+0x=
c6/0x1a0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675907]  ? 0xffffffffa10900=
00
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.675978]  do_one_initcall+0x=
b8/0x29f
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676049]  ? trace_event_raw_=
event_initcall_finish+0x150/0x150
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676122]  ? kasan_unpoison_s=
hadow+0x36/0x50
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676193]  ? kasan_kmalloc+0x=
ae/0xf0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676264]  ? kmem_cache_alloc=
_trace+0x14d/0x2b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676336]  ? do_init_module+0=
x35/0x335
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676406]  ? kasan_unpoison_s=
hadow+0x36/0x50
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676479]  do_init_module+0xe=
c/0x335
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676550]  load_module+0x3d5d=
/0x4780
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676627]  ? module_frob_arch=
_sections+0x20/0x20
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676700]  ? ima_read_file+0x=
10/0x10
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676770]  ? vfs_read+0x127/0=
x190
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676842]  ? kernel_read+0x74=
/0xa0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676913]  ? kernel_read_file=
+0x16c/0x350
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.676986]  ? apparmor_task_fr=
ee+0xc0/0xc0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677057]  ? do_mmap+0x55e/0x=
790
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677130]  ? __do_sys_finit_m=
odule+0x175/0x1b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677201]  __do_sys_finit_mod=
ule+0x175/0x1b0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677273]  ? __ia32_sys_init_=
module+0x40/0x40
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677344]  ? check_chain_key+=
0x131/0x1e0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677416]  ? syscall_trace_en=
ter+0x1fc/0x530
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677491]  ? vtime_user_exit+=
0xc8/0xe0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677563]  do_syscall_64+0x7d=
/0x1f0
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677634]  entry_SYSCALL_64_a=
fter_hwframe+0x44/0xa9
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677706] RIP: 0033:0x7fcc213=
654d9
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677776] Code: 00 f3 c3 66 2=
e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4=
d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d=
 8f 29 2c 00 f7 d8 64 89 01 48
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677873] RSP: 002b:00007ffc8=
d3c2888 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.677954] RAX: ffffffffffffff=
da RBX: 000055b90a1363b0 RCX: 00007fcc213654d9
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678027] RDX: 00000000000000=
00 RSI: 000055b9091b926b RDI: 000000000000000d
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678100] RBP: 000055b9091b92=
6b R08: 0000000000000000 R09: 0000000000000000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678173] R10: 00000000000000=
0d R11: 0000000000000246 R12: 0000000000000000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678246] R13: 000055b90a13aa=
30 R14: 0000000000040000 R15: 0000000000040000
Mar  5 12:27:01 ubuntu-1604-test kernel: [   21.678322] ---[ end trace d006=
c1f8e03b5e65 ]---

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 ++++++++++++++++++-----------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index bf462c5..b0575b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -77,8 +77,7 @@ struct ras_manager {
         struct amdgpu_device *adev;
         /* debugfs */
         struct dentry *ent;
-       /* sysfs */
-       struct device_attribute sysfs_attr;
+
         int attr_inuse;

         /* fs node name */
@@ -374,10 +373,17 @@ static const struct file_operations amdgpu_ras_debugf=
s_ctrl_ops =3D {
         .llseek =3D default_llseek
 };

+static struct ras_sysfs_attr {
+       struct device_attribute sysfs_attrs;
+       struct ras_manager *obj;
+} ras_sysfs_attrs[AMDGPU_RAS_BLOCK__LAST];
+
 static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
                 struct device_attribute *attr, char *buf)
 {
-       struct ras_manager *obj =3D container_of(attr, struct ras_manager, =
sysfs_attr);
+       struct ras_sysfs_attr *ras_sysfs_attr =3D container_of(attr, struct=
 ras_sysfs_attr, sysfs_attrs);
+       struct ras_manager *obj =3D ras_sysfs_attr->obj;
+
         struct ras_query_if info =3D {
                 .head =3D obj->head,
         };
@@ -694,10 +700,9 @@ int amdgpu_ras_query_error_count(struct amdgpu_device =
*adev,
 static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
                 struct device_attribute *attr, char *buf)
 {
-       struct amdgpu_ras *con =3D
-               container_of(attr, struct amdgpu_ras, features_attr);
         struct drm_device *ddev =3D dev_get_drvdata(dev);
         struct amdgpu_device *adev =3D ddev->dev_private;
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
         struct ras_common_if head;
         int ras_block_count =3D AMDGPU_RAS_BLOCK_COUNT;
         int i;
@@ -724,11 +729,12 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct =
device *dev,
         return s;
 }

+static DEVICE_ATTR(features, S_IRUGO, amdgpu_ras_sysfs_features_read, NULL=
);
+
 static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev=
)
 {
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
         struct attribute *attrs[] =3D {
-               &con->features_attr.attr,
+               &dev_attr_features.attr,
                 NULL
         };
         struct attribute_group group =3D {
@@ -736,22 +742,13 @@ static int amdgpu_ras_sysfs_create_feature_node(struc=
t amdgpu_device *adev)
                 .attrs =3D attrs,
         };

-       con->features_attr =3D (struct device_attribute) {
-               .attr =3D {
-                       .name =3D "features",
-                       .mode =3D S_IRUGO,
-               },
-                       .show =3D amdgpu_ras_sysfs_features_read,
-       };
-
         return sysfs_create_group(&adev->dev->kobj, &group);
 }

 static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev=
)
 {
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
         struct attribute *attrs[] =3D {
-               &con->features_attr.attr,
+               &dev_attr_features.attr,
                 NULL
         };
         struct attribute_group group =3D {
@@ -778,17 +775,22 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *ade=
v,
                         head->sysfs_name,
                         sizeof(obj->fs_data.sysfs_name));

-       obj->sysfs_attr =3D (struct device_attribute){
-               .attr =3D {
-                       .name =3D obj->fs_data.sysfs_name,
-                       .mode =3D S_IRUGO,
+
+
+       ras_sysfs_attrs[head->head.block] =3D (struct ras_sysfs_attr){
+               .sysfs_attrs =3D {
+                       .attr =3D {
+                               .name =3D obj->fs_data.sysfs_name,
+                               .mode =3D S_IRUGO,
+                       },
+                               .show =3D amdgpu_ras_sysfs_read,
                 },
-                       .show =3D amdgpu_ras_sysfs_read,
+               .obj =3D obj
         };

         if (sysfs_add_file_to_group(&adev->dev->kobj,
-                               &obj->sysfs_attr.attr,
-                               "ras")) {
+                                   &ras_sysfs_attrs[head->head.block].sysf=
s_attrs.attr,
+                                   "ras")) {
                 put_obj(obj);
                 return -EINVAL;
         }
@@ -807,8 +809,10 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev=
,
                 return -EINVAL;

         sysfs_remove_file_from_group(&adev->dev->kobj,
-                               &obj->sysfs_attr.attr,
+                               &ras_sysfs_attrs[head->block].sysfs_attrs.a=
ttr,
                                 "ras");
+
+       ras_sysfs_attrs[head->block].obj =3D NULL;
         obj->attr_inuse =3D 0;
         put_obj(obj);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 02cb9a1..b572bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -88,8 +88,6 @@ struct amdgpu_ras {
         struct dentry *dir;
         /* debugfs ctrl */
         struct dentry *ent;
-       /* sysfs */
-       struct device_attribute features_attr;
         /* block array */
         struct ras_manager *objs;

--
2.7.4


--_000_SN6PR12MB2800EC43EFB63A6434768B89874E0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
thanks for finding the problem.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
but NACK for the solution.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
struct <a href=3D"https://elixir.bootlin.com/linux/v4.18.20/ident/attribute=
">attribute</a> {<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
...<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
bool <a href=3D"https://elixir.bootlin.com/linux/v4.18.20/ident/ignore_lock=
dep">ignore_lockdep</a>:1;<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
...<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
}<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
lockdef is useless here. I would like just set the ignore bit.<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Andrey Grodzovsky &=
lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, March 9, 2019 6:29:36 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Pan, Xinhui; Grodzovsky, Andrey<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Fix lockdep warning in RAS SYSFS v2<=
/font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Problem:<br>
When loading driver with debug lockdep enabled the WARN_ON as bellow<br>
was observed. Gooling about this warning i found the follwing explanation -=
<br>
<a href=3D"https://git.sphere.ly/tucstwo/cam-test/commit/671ee198b38694cf1d=
fbaa0b9ea823929517c367">https://git.sphere.ly/tucstwo/cam-test/commit/671ee=
198b38694cf1dfbaa0b9ea823929517c367</a><br>
<br>
Fix:<br>
Switch all debugfs attributes in RAS to static<br>
<br>
v2: Add correct WARN_ON message to description.<br>
<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.670622] DEBU=
G_LOCKS_WARN_ON(1)<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.670630] WARN=
ING: CPU: 5 PID: 1100 at kernel/locking/lockdep.c:3129 lockdep_init_map&#43=
;0x288/0x290<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.670761] Modu=
les linked in: amdgpu(O&#43;) chash gpu_sched(O) ttm(O) drm_kms_helper(O) d=
rm(O) i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt intel_rapl=
 x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
 kvm irqbypass crct10dif_pclmul crc32_pclmul snd_hda_codec_realtek ghash_cl=
mulni_intel snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec=
 snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event aesni_intel=
 snd_rawmidi aes_x86_64 crypto_simd
 cryptd glue_helper eeepc_wmi snd_seq asus_wmi sparse_keymap wmi_bmof snd_s=
eq_device snd_timer serio_raw joydev snd soundcore mei_me mei acpi_pad mac_=
hid binfmt_misc nfsd auth_rpcgss nfs_acl parport_pc lockd ppdev grace lp pa=
rport sunrpc autofs4 hid_generic
 psmouse e1000e r8169 ahci libahci usbhid hid mxm_wmi wmi video<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.670922] CPU:=
 5 PID: 1100 Comm: modprobe Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; O&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.0.0-rc1-dev&#43; =
#37<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.670991] Hard=
ware name: System manufacturer System Product Name/Z170-PRO, BIOS 1902 06/2=
7/2016<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671061] RIP:=
 0010:lockdep_init_map&#43;0x288/0x290<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671127] Code=
: c7 34 3d 1b 83 e8 08 fc 21 00 83 3d 35 4e 05 02 00 0f 85 df fe ff ff 48 c=
7 c6 00 99 48 82 48 c7 c7 20 94 48 82 e8 b8 87 f6 ff &lt;0f&gt; 0b e9 c5 fe=
 ff ff 90 49 89 f0 31 c9 31 d2 31 f6 e9 32 8f 07 00<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671219] RSP:=
 0018:ffff8883e0faf0e8 EFLAGS: 00010286<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671291] RAX:=
 0000000000000000 RBX: ffff8883b07df348 RCX: ffffffff81165de4<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671364] RDX:=
 0000000000000003 RSI: dffffc0000000000 RDI: 0000000000000246<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671437] RBP:=
 ffffffff8253e4e0 R08: fffffbfff05a271d R09: fffffbfff05a271d<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671510] R10:=
 0000000000000001 R11: fffffbfff05a271c R12: ffff8883b07d2140<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671583] R13:=
 0000000000001001 R14: 0000000000000000 R15: 0000000000000000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671656] FS:&=
nbsp; 00007fcc21833700(0000) GS:ffff8883f4080000(0000) knlGS:00000000000000=
00<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671737] CS:&=
nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671809] CR2:=
 000055b90a13b000 CR3: 00000003d96de005 CR4: 00000000003606e0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671882] DR0:=
 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.671955] DR3:=
 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672027] Call=
 Trace:<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672099]&nbsp=
; __kernfs_create_file&#43;0x9d/0x150<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672171]&nbsp=
; sysfs_add_file_mode_ns&#43;0x11d/0x270<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672246]&nbsp=
; internal_create_group&#43;0x218/0x600<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672324]&nbsp=
; ? remove_files.isra.1&#43;0xa0/0xa0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672396]&nbsp=
; ? rcu_read_lock_sched_held&#43;0x75/0x80<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672555]&nbsp=
; ? amdgpu_ras_create_obj&#43;0x10c/0x130 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672703]&nbsp=
; ? __amdgpu_ras_feature_enable&#43;0x109/0x200 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.672862]&nbsp=
; amdgpu_ras_init&#43;0x41e/0x560 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673012]&nbsp=
; ? amdgpu_ras_reserve_bad_pages&#43;0x5e0/0x5e0 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673086]&nbsp=
; ? __mutex_unlock_slowpath&#43;0xda/0x420<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673162]&nbsp=
; ? wait_for_completion&#43;0x200/0x200<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673240]&nbsp=
; ? idr_alloc_u32&#43;0x1b0/0x1b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673349]&nbsp=
; ? drm_property_create&#43;0x18a/0x200 [drm]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673500]&nbsp=
; amdgpu_device_init&#43;0x15fc/0x2950 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673646]&nbsp=
; ? amdgpu_device_has_dc_support&#43;0x30/0x30 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673720]&nbsp=
; ? __alloc_pages_nodemask&#43;0x232/0x460<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673792]&nbsp=
; ? __alloc_pages_slowpath&#43;0x1370/0x1370<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673864]&nbsp=
; ? __mutex_unlock_slowpath&#43;0xda/0x420<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.673936]&nbsp=
; ? policy_nodemask&#43;0x19/0xa0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674008]&nbsp=
; ? kasan_unpoison_shadow&#43;0x36/0x50<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674079]&nbsp=
; ? kasan_kmalloc_large&#43;0x9a/0xe0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674222]&nbsp=
; amdgpu_driver_load_kms&#43;0x101/0x540 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674371]&nbsp=
; ? amdgpu_driver_unload_kms&#43;0x220/0x220 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674458]&nbsp=
; ? drm_dev_register&#43;0x1a4/0x320 [drm]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674530]&nbsp=
; ? __kasan_slab_free&#43;0x138/0x170<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674617]&nbsp=
; drm_dev_register&#43;0x1fd/0x320 [drm]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674761]&nbsp=
; amdgpu_pci_probe&#43;0xef/0x1a0 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674904]&nbsp=
; ? amdgpu_pci_remove&#43;0x60/0x60 [amdgpu]<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.674977]&nbsp=
; local_pci_probe&#43;0x76/0xe0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675048]&nbsp=
; pci_device_probe&#43;0x205/0x300<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675119]&nbsp=
; ? kernfs_create_link&#43;0xae/0x100<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675191]&nbsp=
; ? pci_device_remove&#43;0x1c0/0x1c0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675264]&nbsp=
; really_probe&#43;0x382/0x5e0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675336]&nbsp=
; driver_probe_device&#43;0x171/0x1b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675408]&nbsp=
; __driver_attach&#43;0x193/0x1a0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675479]&nbsp=
; ? driver_probe_device&#43;0x1b0/0x1b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675550]&nbsp=
; bus_for_each_dev&#43;0xe4/0x160<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675621]&nbsp=
; ? lock_downgrade&#43;0x2f0/0x2f0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675691]&nbsp=
; ? subsys_dev_iter_exit&#43;0x10/0x10<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675764]&nbsp=
; bus_add_driver&#43;0x322/0x3a0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675836]&nbsp=
; driver_register&#43;0xc6/0x1a0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675907]&nbsp=
; ? 0xffffffffa1090000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.675978]&nbsp=
; do_one_initcall&#43;0xb8/0x29f<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676049]&nbsp=
; ? trace_event_raw_event_initcall_finish&#43;0x150/0x150<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676122]&nbsp=
; ? kasan_unpoison_shadow&#43;0x36/0x50<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676193]&nbsp=
; ? kasan_kmalloc&#43;0xae/0xf0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676264]&nbsp=
; ? kmem_cache_alloc_trace&#43;0x14d/0x2b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676336]&nbsp=
; ? do_init_module&#43;0x35/0x335<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676406]&nbsp=
; ? kasan_unpoison_shadow&#43;0x36/0x50<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676479]&nbsp=
; do_init_module&#43;0xec/0x335<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676550]&nbsp=
; load_module&#43;0x3d5d/0x4780<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676627]&nbsp=
; ? module_frob_arch_sections&#43;0x20/0x20<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676700]&nbsp=
; ? ima_read_file&#43;0x10/0x10<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676770]&nbsp=
; ? vfs_read&#43;0x127/0x190<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676842]&nbsp=
; ? kernel_read&#43;0x74/0xa0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676913]&nbsp=
; ? kernel_read_file&#43;0x16c/0x350<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.676986]&nbsp=
; ? apparmor_task_free&#43;0xc0/0xc0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677057]&nbsp=
; ? do_mmap&#43;0x55e/0x790<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677130]&nbsp=
; ? __do_sys_finit_module&#43;0x175/0x1b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677201]&nbsp=
; __do_sys_finit_module&#43;0x175/0x1b0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677273]&nbsp=
; ? __ia32_sys_init_module&#43;0x40/0x40<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677344]&nbsp=
; ? check_chain_key&#43;0x131/0x1e0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677416]&nbsp=
; ? syscall_trace_enter&#43;0x1fc/0x530<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677491]&nbsp=
; ? vtime_user_exit&#43;0xc8/0xe0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677563]&nbsp=
; do_syscall_64&#43;0x7d/0x1f0<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677634]&nbsp=
; entry_SYSCALL_64_after_hwframe&#43;0x44/0xa9<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677706] RIP:=
 0033:0x7fcc213654d9<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677776] Code=
: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 8=
9 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 &lt;48&gt; 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677873] RSP:=
 002b:00007ffc8d3c2888 EFLAGS: 00000246 ORIG_RAX: 0000000000000139<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.677954] RAX:=
 ffffffffffffffda RBX: 000055b90a1363b0 RCX: 00007fcc213654d9<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.678027] RDX:=
 0000000000000000 RSI: 000055b9091b926b RDI: 000000000000000d<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.678100] RBP:=
 000055b9091b926b R08: 0000000000000000 R09: 0000000000000000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.678173] R10:=
 000000000000000d R11: 0000000000000246 R12: 0000000000000000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.678246] R13:=
 000055b90a13aa30 R14: 0000000000040000 R15: 0000000000040000<br>
Mar&nbsp; 5 12:27:01 ubuntu-1604-test kernel: [&nbsp;&nbsp; 21.678322] ---[=
 end trace d006c1f8e03b5e65 ]---<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 2 --<br>
&nbsp;2 files changed, 29 insertions(&#43;), 27 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index bf462c5..b0575b6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -77,8 &#43;77,7 @@ struct ras_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* debugfs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *ent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sysfs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute sysfs_attr;<b=
r>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int attr_inuse;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fs node name */<br>
@@ -374,10 &#43;373,17 @@ static const struct file_operations amdgpu_ras_de=
bugfs_ctrl_ops =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static struct ras_sysfs_attr {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute sysfs_att=
rs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj;<br>
&#43;} ras_sysfs_attrs[AMDGPU_RAS_BLOCK__LAST];<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_ras_sysfs_read(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =3D container=
_of(attr, struct ras_manager, sysfs_attr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_sysfs_attr *ras_sysfs_=
attr =3D container_of(attr, struct ras_sysfs_attr, sysfs_attrs);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =3D ras_s=
ysfs_attr-&gt;obj;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .head =3D obj-&gt;head,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
@@ -694,10 &#43;700,9 @@ int amdgpu_ras_query_error_count(struct amdgpu_dev=
ice *adev,<br>
&nbsp;static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; container_of(attr, struct amdgpu_ras, features_attr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =
=3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu=
_ras_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_common_if head;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ras_block_count =3D AM=
DGPU_RAS_BLOCK_COUNT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
@@ -724,11 &#43;729,12 @@ static ssize_t amdgpu_ras_sysfs_features_read(str=
uct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static DEVICE_ATTR(features, S_IRUGO, amdgpu_ras_sysfs_features_read, =
NULL);<br>
&#43;<br>
&nbsp;static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras=
_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute *attrs[] =
=3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;con-&gt;features_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;dev_attr_features.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NULL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute_group gro=
up =3D {<br>
@@ -736,22 &#43;742,13 @@ static int amdgpu_ras_sysfs_create_feature_node(s=
truct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .attrs =3D attrs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;features_attr =3D (struct dev=
ice_attribute) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .attr =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;=
features&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode =3D S_IRUG=
O,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D amdgpu=
_ras_sysfs_features_read,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_create_group(=
&amp;adev-&gt;dev-&gt;kobj, &amp;group);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras=
_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute *attrs[] =
=3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;con-&gt;features_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;dev_attr_features.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NULL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute_group gro=
up =3D {<br>
@@ -778,17 &#43;775,22 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; head-=
&gt;sysfs_name,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(obj-&gt;fs_data.sysfs_name));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;sysfs_attr =3D (struct device=
_attribute){<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .attr =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D obj-&g=
t;fs_data.sysfs_name,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode =3D S_IRUG=
O,<br>
&#43;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_sysfs_attrs[head-&gt;head.blo=
ck] =3D (struct ras_sysfs_attr){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; .sysfs_attrs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .attr =3D {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D obj-&gt;fs_data.sysfs_name,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode =3D S_IRUGO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D amdgpu_ras_sysfs_read,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .show =3D amdgpu=
_ras_sysfs_read,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; .obj =3D obj<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sysfs_add_file_to_grou=
p(&amp;adev-&gt;dev-&gt;kobj,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;obj-&gt;sysfs_attr.attr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ras&quot;)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ras_sysfs_=
attrs[head-&gt;head.block].sysfs_attrs.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ras&quot;=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; put_obj(obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -807,8 &#43;809,10 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file_from_gro=
up(&amp;adev-&gt;dev-&gt;kobj,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;obj-&gt;sysfs_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ras_sysfs_attrs[head-&gt;block].sy=
sfs_attrs.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ras&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_sysfs_attrs[head-&gt;block].o=
bj =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;attr_inuse =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_obj(obj);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index 02cb9a1..b572bae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -88,8 &#43;88,6 @@ struct amdgpu_ras {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *dir;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* debugfs ctrl */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *ent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sysfs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute features_attr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block array */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *objs;<=
br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_SN6PR12MB2800EC43EFB63A6434768B89874E0SN6PR12MB2800namp_--

--===============0793994969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0793994969==--
