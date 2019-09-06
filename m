From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix null pointer deref in firmware header
 printing
Date: Fri, 6 Sep 2019 08:07:04 +0000
Message-ID: <MN2PR12MB3296D14BE7A0820B853FD5CCA2BA0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190906080413.31573-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589996945=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190906080413.31573-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1589996945==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296D14BE7A0820B853FD5CCA2BA0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296D14BE7A0820B853FD5CCA2BA0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, September 6, 2019 4:04 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan@am=
d.com>
Subject: [PATCH v2] drm/amdgpu: fix null pointer deref in firmware header p=
rinting

v2: declare as (struct common_firmware_header *) type because
    struct xxx_firmware_header inherits from it

When CE's ucode_id(8) is used to get sdma_hdr, we will be accessing an
unallocated amdgpu_firmware_info instance.

This issue appears on rhel7.7 with gcc 4.8.5. Newer compilers might have
optimized out such 'defined but not referenced' variable.

[ 1120.798564] BUG: unable to handle kernel NULL pointer dereference at 000=
000000000000a
[ 1120.806703] IP: [<ffffffffc0e3c9b3>] psp_np_fw_load+0x1e3/0x390 [amdgpu]
[ 1120.813693] PGD 80000002603ff067 PUD 271b8d067 PMD 0
[ 1120.818931] Oops: 0000 [#1] SMP
[ 1120.822245] Modules linked in: amdgpu(OE+) amdkcl(OE) amd_iommu_v2 amdtt=
m(OE) amd_sched(OE) xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun b=
ridge stp llc devlink ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT n=
f_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat nf_conntrack_ipv6 nf_de=
frag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw iptabl=
e_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat iptable_mangle ip=
table_security iptable_raw nf_conntrack libcrc32c ip_set nfnetlink ebtable_=
filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod intel_pmc_core intel_powerclamp coretemp intel=
_rapl joydev kvm_intel eeepc_wmi asus_wmi kvm sparse_keymap iTCO_wdt irqbyp=
ass rfkill crc32_pclmul snd_hda_codec_realtek mxm_wmi ghash_clmulni_intel i=
ntel_wmi_thunderbolt iTCO_vendor_support snd_hda_codec_generic snd_hda_code=
c_hdmi aesni_intel lrw gf128mul glue_helper ablk_helper sg cryptd pcspkr sn=
d_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd=
_pcm snd_timer snd pinctrl_sunrisepoint pinctrl_intel soundcore acpi_pad me=
i_me wmi mei i2c_i801 pcc_cpufreq ip_tables ext4 mbcache jbd2 sd_mod crc_t1=
0dif crct10dif_generic i915 i2c_algo_bit iosf_mbi drm_kms_helper e1000e sys=
copyarea sysfillrect sysimgblt fb_sys_fops ahci libahci drm ptp libata crct=
10dif_pclmul crct10dif_common crc32c_intel serio_raw pps_core drm_panel_ori=
entation_quirks video i2c_hid
[ 1120.954136] CPU: 4 PID: 2426 Comm: modprobe Tainted: G           OE  ---=
---------   3.10.0-1062.el7.x86_64 #1
[ 1120.964390] Hardware name: System manufacturer System Product Name/Z170-=
A, BIOS 1302 11/09/2015
[ 1120.973321] task: ffff991ef1e3c1c0 ti: ffff991ee625c000 task.ti: ffff991=
ee625c000
[ 1120.981020] RIP: 0010:[<ffffffffc0e3c9b3>]  [<ffffffffc0e3c9b3>] psp_np_=
fw_load+0x1e3/0x390 [amdgpu]
[ 1120.990483] RSP: 0018:ffff991ee625f950  EFLAGS: 00010202
[ 1120.995935] RAX: 0000000000000002 RBX: ffff991edf6b2d38 RCX: ffff991edf6=
a0000
[ 1121.003391] RDX: 0000000000000000 RSI: ffff991f01d13898 RDI: ffffffffc11=
0afb3
[ 1121.010706] RBP: ffff991ee625f9b0 R08: 0000000000000000 R09: 00000000000=
00000
[ 1121.018029] R10: 00000000000004c4 R11: ffff991ee625f64e R12: ffff991edf6=
b3220
[ 1121.025353] R13: ffff991edf6a0000 R14: 0000000000000008 R15: ffff991edf6=
b2d30
[ 1121.032666] FS:  00007f97b0c0b740(0000) GS:ffff991f01d00000(0000) knlGS:=
0000000000000000
[ 1121.041000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1121.046880] CR2: 000000000000000a CR3: 000000025e604000 CR4: 00000000003=
607e0
[ 1121.054239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1121.061631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1121.068938] Call Trace:
[ 1121.071494]  [<ffffffffc0e3dba8>] psp_hw_init+0x218/0x270 [amdgpu]
[ 1121.077886]  [<ffffffffc0da3188>] amdgpu_device_fw_loading+0xe8/0x160 [a=
mdgpu]
[ 1121.085296]  [<ffffffffc0e3b34c>] ? vega10_ih_irq_init+0x4bc/0x730 [amdg=
pu]
[ 1121.092534]  [<ffffffffc0da5c75>] amdgpu_device_init+0x1495/0x1c90 [amdg=
pu]
[ 1121.099675]  [<ffffffffc0da9cab>] amdgpu_driver_load_kms+0x8b/0x2f0 [amd=
gpu]
[ 1121.106888]  [<ffffffffc01b25cf>] drm_dev_register+0x12f/0x1d0 [drm]
[ 1121.113419]  [<ffffffffa4dcdfd8>] ? pci_enable_device_flags+0xe8/0x140
[ 1121.120183]  [<ffffffffc0da260a>] amdgpu_pci_probe+0xca/0x170 [amdgpu]
[ 1121.126919]  [<ffffffffa4dcf97a>] local_pci_probe+0x4a/0xb0
[ 1121.132622]  [<ffffffffa4dd10c9>] pci_device_probe+0x109/0x160
[ 1121.138607]  [<ffffffffa4eb4205>] driver_probe_device+0xc5/0x3e0
[ 1121.144766]  [<ffffffffa4eb4603>] __driver_attach+0x93/0xa0
[ 1121.150507]  [<ffffffffa4eb4570>] ? __device_attach+0x50/0x50
[ 1121.156422]  [<ffffffffa4eb1da5>] bus_for_each_dev+0x75/0xc0
[ 1121.162213]  [<ffffffffa4eb3b7e>] driver_attach+0x1e/0x20
[ 1121.167771]  [<ffffffffa4eb3620>] bus_add_driver+0x200/0x2d0
[ 1121.173590]  [<ffffffffa4eb4c94>] driver_register+0x64/0xf0
[ 1121.179345]  [<ffffffffa4dd0905>] __pci_register_driver+0xa5/0xc0
[ 1121.185593]  [<ffffffffc099f000>] ? 0xffffffffc099efff
[ 1121.190914]  [<ffffffffc099f0a4>] amdgpu_init+0xa4/0xb0 [amdgpu]
[ 1121.197101]  [<ffffffffa4a0210a>] do_one_initcall+0xba/0x240
[ 1121.202901]  [<ffffffffa4b1c90a>] load_module+0x271a/0x2bb0
[ 1121.208598]  [<ffffffffa4dad740>] ? ddebug_proc_write+0x100/0x100
[ 1121.214894]  [<ffffffffa4b1ce8f>] SyS_init_module+0xef/0x140
[ 1121.220698]  [<ffffffffa518bede>] system_call_fastpath+0x25/0x2a
[ 1121.226870] Code: b4 01 60 a2 00 00 31 c0 e8 83 60 33 e4 41 8b 47 08 48 =
8b 4d d0 48 c7 c7 b3 af 10 c1 48 69 c0 68 07 00 00 48 8b 84 01 60 a2 00 00 =
<48> 8b 70 08 31 c0 48 89 75 c8 e8 56 60 33 e4 48 8b 4d d0 48 c7
[ 1121.247422] RIP  [<ffffffffc0e3c9b3>] psp_np_fw_load+0x1e3/0x390 [amdgpu=
]
[ 1121.254432]  RSP <ffff991ee625f950>
[ 1121.258017] CR2: 000000000000000a
[ 1121.261427] ---[ end trace e98b35387ede75bd ]---

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
Fixes: 5206b0e79cfe ("drm/amdgpu: add firmware header printing for psp fw l=
oading")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++--------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 81ea5b796d85..f90a0cd12827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -944,21 +944,7 @@ static void psp_print_fw_hdr(struct psp_context *psp,
                              struct amdgpu_firmware_info *ucode)
 {
         struct amdgpu_device *adev =3D psp->adev;
-       const struct sdma_firmware_header_v1_0 *sdma_hdr =3D
-               (const struct sdma_firmware_header_v1_0 *)
-               adev->sdma.instance[ucode->ucode_id - AMDGPU_UCODE_ID_SDMA0=
].fw->data;
-       const struct gfx_firmware_header_v1_0 *ce_hdr =3D
-               (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->d=
ata;
-       const struct gfx_firmware_header_v1_0 *pfp_hdr =3D
-               (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->=
data;
-       const struct gfx_firmware_header_v1_0 *me_hdr =3D
-               (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->d=
ata;
-       const struct gfx_firmware_header_v1_0 *mec_hdr =3D
-               (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->=
data;
-       const struct rlc_firmware_header_v2_0 *rlc_hdr =3D
-               (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->=
data;
-       const struct smc_firmware_header_v1_0 *smc_hdr =3D
-               (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+       struct common_firmware_header *hdr;

         switch (ucode->ucode_id) {
         case AMDGPU_UCODE_ID_SDMA0:
@@ -969,25 +955,33 @@ static void psp_print_fw_hdr(struct psp_context *psp,
         case AMDGPU_UCODE_ID_SDMA5:
         case AMDGPU_UCODE_ID_SDMA6:
         case AMDGPU_UCODE_ID_SDMA7:
-               amdgpu_ucode_print_sdma_hdr(&sdma_hdr->header);
+               hdr =3D (struct common_firmware_header *)
+                       adev->sdma.instance[ucode->ucode_id - AMDGPU_UCODE_=
ID_SDMA0].fw->data;
+               amdgpu_ucode_print_sdma_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_CP_CE:
-               amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->gfx.ce_fw->d=
ata;
+               amdgpu_ucode_print_gfx_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_CP_PFP:
-               amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->gfx.pfp_fw->=
data;
+               amdgpu_ucode_print_gfx_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_CP_ME:
-               amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->gfx.me_fw->d=
ata;
+               amdgpu_ucode_print_gfx_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_CP_MEC1:
-               amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->gfx.mec_fw->=
data;
+               amdgpu_ucode_print_gfx_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_RLC_G:
-               amdgpu_ucode_print_rlc_hdr(&rlc_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->gfx.rlc_fw->=
data;
+               amdgpu_ucode_print_rlc_hdr(hdr);
                 break;
         case AMDGPU_UCODE_ID_SMC:
-               amdgpu_ucode_print_smc_hdr(&smc_hdr->header);
+               hdr =3D (struct common_firmware_header *)adev->pm.fw->data;
+               amdgpu_ucode_print_smc_hdr(hdr);
                 break;
         default:
                 break;
--
2.20.1


--_000_MN2PR12MB3296D14BE7A0820B853FD5CCA2BA0MN2PR12MB3296namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yuan, Xiaojie &lt;Xia=
ojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 6, 2019 4:04 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiaojie &lt=
;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: fix null pointer deref in firmware h=
eader printing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">v2: declare as (struct common_firmware_header *) t=
ype because<br>
&nbsp;&nbsp;&nbsp; struct xxx_firmware_header inherits from it<br>
<br>
When CE's ucode_id(8) is used to get sdma_hdr, we will be accessing an<br>
unallocated amdgpu_firmware_info instance.<br>
<br>
This issue appears on rhel7.7 with gcc 4.8.5. Newer compilers might have<br=
>
optimized out such 'defined but not referenced' variable.<br>
<br>
[ 1120.798564] BUG: unable to handle kernel NULL pointer dereference at 000=
000000000000a<br>
[ 1120.806703] IP: [&lt;ffffffffc0e3c9b3&gt;] psp_np_fw_load&#43;0x1e3/0x39=
0 [amdgpu]<br>
[ 1120.813693] PGD 80000002603ff067 PUD 271b8d067 PMD 0<br>
[ 1120.818931] Oops: 0000 [#1] SMP<br>
[ 1120.822245] Modules linked in: amdgpu(OE&#43;) amdkcl(OE) amd_iommu_v2 a=
mdttm(OE) amd_sched(OE) xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 t=
un bridge stp llc devlink ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJE=
CT nf_reject_ipv4 xt_conntrack ebtable_nat
 ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle =
ip6table_security ip6table_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4=
 nf_nat_ipv4 nf_nat iptable_mangle iptable_security iptable_raw nf_conntrac=
k libcrc32c ip_set nfnetlink ebtable_filter
 ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_reg=
ion_hash dm_log dm_mod intel_pmc_core intel_powerclamp coretemp intel_rapl =
joydev kvm_intel eeepc_wmi asus_wmi kvm sparse_keymap iTCO_wdt irqbypass rf=
kill crc32_pclmul snd_hda_codec_realtek
 mxm_wmi ghash_clmulni_intel intel_wmi_thunderbolt iTCO_vendor_support snd_=
hda_codec_generic snd_hda_codec_hdmi aesni_intel lrw gf128mul glue_helper a=
blk_helper sg cryptd pcspkr snd_hda_intel snd_hda_codec snd_hda_core snd_hw=
dep snd_seq snd_seq_device snd_pcm
 snd_timer snd pinctrl_sunrisepoint pinctrl_intel soundcore acpi_pad mei_me=
 wmi mei i2c_i801 pcc_cpufreq ip_tables ext4 mbcache jbd2 sd_mod crc_t10dif=
 crct10dif_generic i915 i2c_algo_bit iosf_mbi drm_kms_helper e1000e syscopy=
area sysfillrect sysimgblt fb_sys_fops
 ahci libahci drm ptp libata crct10dif_pclmul crct10dif_common crc32c_intel=
 serio_raw pps_core drm_panel_orientation_quirks video i2c_hid<br>
[ 1120.954136] CPU: 4 PID: 2426 Comm: modprobe Tainted: G&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp; ------------&nbsp;&nbsp=
; 3.10.0-1062.el7.x86_64 #1<br>
[ 1120.964390] Hardware name: System manufacturer System Product Name/Z170-=
A, BIOS 1302 11/09/2015<br>
[ 1120.973321] task: ffff991ef1e3c1c0 ti: ffff991ee625c000 task.ti: ffff991=
ee625c000<br>
[ 1120.981020] RIP: 0010:[&lt;ffffffffc0e3c9b3&gt;]&nbsp; [&lt;ffffffffc0e3=
c9b3&gt;] psp_np_fw_load&#43;0x1e3/0x390 [amdgpu]<br>
[ 1120.990483] RSP: 0018:ffff991ee625f950&nbsp; EFLAGS: 00010202<br>
[ 1120.995935] RAX: 0000000000000002 RBX: ffff991edf6b2d38 RCX: ffff991edf6=
a0000<br>
[ 1121.003391] RDX: 0000000000000000 RSI: ffff991f01d13898 RDI: ffffffffc11=
0afb3<br>
[ 1121.010706] RBP: ffff991ee625f9b0 R08: 0000000000000000 R09: 00000000000=
00000<br>
[ 1121.018029] R10: 00000000000004c4 R11: ffff991ee625f64e R12: ffff991edf6=
b3220<br>
[ 1121.025353] R13: ffff991edf6a0000 R14: 0000000000000008 R15: ffff991edf6=
b2d30<br>
[ 1121.032666] FS:&nbsp; 00007f97b0c0b740(0000) GS:ffff991f01d00000(0000) k=
nlGS:0000000000000000<br>
[ 1121.041000] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
[ 1121.046880] CR2: 000000000000000a CR3: 000000025e604000 CR4: 00000000003=
607e0<br>
[ 1121.054239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000<br>
[ 1121.061631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400<br>
[ 1121.068938] Call Trace:<br>
[ 1121.071494]&nbsp; [&lt;ffffffffc0e3dba8&gt;] psp_hw_init&#43;0x218/0x270=
 [amdgpu]<br>
[ 1121.077886]&nbsp; [&lt;ffffffffc0da3188&gt;] amdgpu_device_fw_loading&#4=
3;0xe8/0x160 [amdgpu]<br>
[ 1121.085296]&nbsp; [&lt;ffffffffc0e3b34c&gt;] ? vega10_ih_irq_init&#43;0x=
4bc/0x730 [amdgpu]<br>
[ 1121.092534]&nbsp; [&lt;ffffffffc0da5c75&gt;] amdgpu_device_init&#43;0x14=
95/0x1c90 [amdgpu]<br>
[ 1121.099675]&nbsp; [&lt;ffffffffc0da9cab&gt;] amdgpu_driver_load_kms&#43;=
0x8b/0x2f0 [amdgpu]<br>
[ 1121.106888]&nbsp; [&lt;ffffffffc01b25cf&gt;] drm_dev_register&#43;0x12f/=
0x1d0 [drm]<br>
[ 1121.113419]&nbsp; [&lt;ffffffffa4dcdfd8&gt;] ? pci_enable_device_flags&#=
43;0xe8/0x140<br>
[ 1121.120183]&nbsp; [&lt;ffffffffc0da260a&gt;] amdgpu_pci_probe&#43;0xca/0=
x170 [amdgpu]<br>
[ 1121.126919]&nbsp; [&lt;ffffffffa4dcf97a&gt;] local_pci_probe&#43;0x4a/0x=
b0<br>
[ 1121.132622]&nbsp; [&lt;ffffffffa4dd10c9&gt;] pci_device_probe&#43;0x109/=
0x160<br>
[ 1121.138607]&nbsp; [&lt;ffffffffa4eb4205&gt;] driver_probe_device&#43;0xc=
5/0x3e0<br>
[ 1121.144766]&nbsp; [&lt;ffffffffa4eb4603&gt;] __driver_attach&#43;0x93/0x=
a0<br>
[ 1121.150507]&nbsp; [&lt;ffffffffa4eb4570&gt;] ? __device_attach&#43;0x50/=
0x50<br>
[ 1121.156422]&nbsp; [&lt;ffffffffa4eb1da5&gt;] bus_for_each_dev&#43;0x75/0=
xc0<br>
[ 1121.162213]&nbsp; [&lt;ffffffffa4eb3b7e&gt;] driver_attach&#43;0x1e/0x20=
<br>
[ 1121.167771]&nbsp; [&lt;ffffffffa4eb3620&gt;] bus_add_driver&#43;0x200/0x=
2d0<br>
[ 1121.173590]&nbsp; [&lt;ffffffffa4eb4c94&gt;] driver_register&#43;0x64/0x=
f0<br>
[ 1121.179345]&nbsp; [&lt;ffffffffa4dd0905&gt;] __pci_register_driver&#43;0=
xa5/0xc0<br>
[ 1121.185593]&nbsp; [&lt;ffffffffc099f000&gt;] ? 0xffffffffc099efff<br>
[ 1121.190914]&nbsp; [&lt;ffffffffc099f0a4&gt;] amdgpu_init&#43;0xa4/0xb0 [=
amdgpu]<br>
[ 1121.197101]&nbsp; [&lt;ffffffffa4a0210a&gt;] do_one_initcall&#43;0xba/0x=
240<br>
[ 1121.202901]&nbsp; [&lt;ffffffffa4b1c90a&gt;] load_module&#43;0x271a/0x2b=
b0<br>
[ 1121.208598]&nbsp; [&lt;ffffffffa4dad740&gt;] ? ddebug_proc_write&#43;0x1=
00/0x100<br>
[ 1121.214894]&nbsp; [&lt;ffffffffa4b1ce8f&gt;] SyS_init_module&#43;0xef/0x=
140<br>
[ 1121.220698]&nbsp; [&lt;ffffffffa518bede&gt;] system_call_fastpath&#43;0x=
25/0x2a<br>
[ 1121.226870] Code: b4 01 60 a2 00 00 31 c0 e8 83 60 33 e4 41 8b 47 08 48 =
8b 4d d0 48 c7 c7 b3 af 10 c1 48 69 c0 68 07 00 00 48 8b 84 01 60 a2 00 00 =
&lt;48&gt; 8b 70 08 31 c0 48 89 75 c8 e8 56 60 33 e4 48 8b 4d d0 48 c7<br>
[ 1121.247422] RIP&nbsp; [&lt;ffffffffc0e3c9b3&gt;] psp_np_fw_load&#43;0x1e=
3/0x390 [amdgpu]<br>
[ 1121.254432]&nbsp; RSP &lt;ffff991ee625f950&gt;<br>
[ 1121.258017] CR2: 000000000000000a<br>
[ 1121.261427] ---[ end trace e98b35387ede75bd ]---<br>
<br>
Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
Fixes: 5206b0e79cfe (&quot;drm/amdgpu: add firmware header printing for psp=
 fw loading&quot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&nbsp;1 file changed, 16 insertions(&#43;), 22 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 81ea5b796d85..f90a0cd12827 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -944,21 &#43;944,7 @@ static void psp_print_fw_hdr(struct psp_context *p=
sp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *ucode)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct sdma_firmware_header_v1_=
0 *sdma_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct sdma_firmware_header_v1_0 *)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;sdma.instance[ucode-&gt;ucode_id - AMDGPU_UCODE_ID_SDMA=
0].fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_v1_0=
 *ce_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.ce_fw-&gt;=
data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_v1_0=
 *pfp_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.pfp_fw-&gt=
;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_v1_0=
 *me_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.me_fw-&gt;=
data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_v1_0=
 *mec_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.mec_fw-&gt=
;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_0=
 *rlc_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct rlc_firmware_header_v2_0 *)adev-&gt;gfx.rlc_fw-&gt=
;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smc_firmware_header_v1_0=
 *smc_hdr =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (const struct smc_firmware_header_v1_0 *)adev-&gt;pm.fw-&gt;data=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct common_firmware_header *hd=
r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ucode-&gt;ucode_id=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0=
:<br>
@@ -969,25 &#43;955,33 @@ static void psp_print_fw_hdr(struct psp_context *=
psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA5=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA6=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA7=
:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_sdma_hdr(&amp;sdma_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdm=
a.instance[ucode-&gt;ucode_id - AMDGPU_UCODE_ID_SDMA0].fw-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_sdma_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE=
:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;ce_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;gfx.ce_fw-=
&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PF=
P:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;pfp_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;gfx.pfp_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME=
:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;me_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;gfx.me_fw-=
&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME=
C1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;mec_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;gfx.mec_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G=
:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_rlc_hdr(&amp;rlc_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;gfx.rlc_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_rlc_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_print_smc_hdr(&amp;smc_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (struct common_firmware_header *)adev-&gt;pm.fw-&gt;=
data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_smc_hdr(hdr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296D14BE7A0820B853FD5CCA2BA0MN2PR12MB3296namp_--

--===============1589996945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1589996945==--
