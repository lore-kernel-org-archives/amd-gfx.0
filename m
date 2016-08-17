From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: slowpath warning on Tonga
Date: Wed, 17 Aug 2016 17:36:03 +0000
Message-ID: <DM5PR12MB11325E0A696ABFE5006B4223F7140@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826118011=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1826118011==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB11325E0A696ABFE5006B4223F7140DM5PR12MB1132namp_"

--_000_DM5PR12MB11325E0A696ABFE5006B4223F7140DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I just happened to notice this on my Tonga.  It's otherwise operating fine.=
  For ref, it's attached to a HDMI KVM which eventually makes it way to a D=
VI-D monitor.


[   28.579561] ------------[ cut here ]------------
[   28.579613] WARNING: CPU: 4 PID: 1276 at drivers/gpu/drm/amd/amdgpu/../d=
al/modules/freesync/freesync.c:187 map_index_from_stream.isra.6.part.7+0x1a=
/0x20 [amdgpu]
[   28.579615] Modules linked in: amdkfd amd_iommu_v2 amdgpu i2c_algo_bit t=
tm drm_kms_helper drm xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masq=
uerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4=
 xt_conntrack nf_conntrack tun bridge ebtable_filter ebtables ip6table_filt=
er ip6_tables rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache snd_hda_codec_=
realtek snd_hda_codec_generic snd_hda_codec_hdmi kvm_amd snd_hda_intel vfat=
 fat kvm snd_hda_codec snd_hda_core eeepc_wmi asus_wmi irqbypass sparse_key=
map crct10dif_pclmul snd_hwdep snd_seq crc32_pclmul rfkill video crc32c_int=
el snd_seq_device mxm_wmi ghash_clmulni_intel snd_pcm snd_timer edac_mce_am=
d sp5100_tco edac_core joydev snd pcspkr fam15h_power k10temp i2c_piix4 tpm=
_infineon acpi_cpufreq soundcore tpm_tis nfsd tpm wmi shpchp
[   28.579646]  auth_rpcgss nfs_acl lockd grace sunrpc 8021q garp stp llc m=
rp r8169 serio_raw mii fjes
[   28.579653] CPU: 4 PID: 1276 Comm: Xorg Tainted: G        W       4.6.0+=
 #3
[   28.579655] Hardware name: To be filled by O.E.M. To be filled by O.E.M.=
/M5A97 LE R2.0, BIOS 2501 04/09/2014
[   28.579656]  0000000000000286 0000000018ea4846 ffff8800ad38bb80 ffffffff=
813cd56e
[   28.579658]  0000000000000000 0000000000000000 ffff8800ad38bbc0 ffffffff=
810a4c9b
[   28.579660]  000000bbb6cdf030 ffff8800b9d2a0a8 ffff8800b6d0f000 ffff8800=
ad38bc1a
[   28.579661] Call Trace:
[   28.579665]  [<ffffffff813cd56e>] dump_stack+0x63/0x85
[   28.579668]  [<ffffffff810a4c9b>] __warn+0xcb/0xf0
[   28.579670]  [<ffffffff810a4dcd>] warn_slowpath_null+0x1d/0x20
[   28.579702]  [<ffffffffa067380a>] map_index_from_stream.isra.6.part.7+0x=
1a/0x20 [amdgpu]
[   28.579735]  [<ffffffffa0674730>] mod_freesync_set_user_enable+0xc0/0x18=
0 [amdgpu]
[   28.579766]  [<ffffffffa062d719>] amdgpu_dm_connector_atomic_set_propert=
y+0x1d9/0x1f0 [amdgpu]
[   28.579782]  [<ffffffffa0514fc4>] drm_atomic_connector_set_property+0x34=
/0x70 [drm]
[   28.579790]  [<ffffffffa056d64b>] drm_atomic_helper_connector_set_proper=
ty+0x7b/0xc0 [drm_kms_helper]
[   28.579799]  [<ffffffffa0503039>] ? _object_find+0x69/0xa0 [drm]
[   28.579809]  [<ffffffffa050a437>] drm_mode_obj_set_property_ioctl+0x177/=
0x250 [drm]
[   28.579820]  [<ffffffffa050a54f>] drm_mode_connector_property_set_ioctl+=
0x3f/0x60 [drm]
[   28.579829]  [<ffffffffa04fa912>] drm_ioctl+0x152/0x540 [drm]
[   28.579835]  [<ffffffff811b1c26>] ? filemap_map_pages+0x126/0x340
[   28.579845]  [<ffffffffa050a510>] ? drm_mode_obj_set_property_ioctl+0x25=
0/0x250 [drm]
[   28.579847]  [<ffffffff811ee2b3>] ? unmap_region+0xf3/0x130
[   28.579850]  [<ffffffff817cd40e>] ? _raw_spin_unlock_irqrestore+0xe/0x10
[   28.579871]  [<ffffffffa05a004c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[   28.579874]  [<ffffffff81252cb1>] do_vfs_ioctl+0xa1/0x5a0
[   28.579876]  [<ffffffff81253229>] SyS_ioctl+0x79/0x90
[   28.579878]  [<ffffffff817cd832>] entry_SYSCALL_64_fastpath+0x1a/0xa4
[   28.579879] ---[ end trace 51ecc44c48a97e14 ]---
[   28.579880] ------------[ cut here ]------------
[   28.579913] WARNING: CPU: 4 PID: 1276 at drivers/gpu/drm/amd/amdgpu/../d=
al/modules/freesync/freesync.c:187 map_index_from_stream.isra.6.part.7+0x1a=
/0x20 [amdgpu]
[   28.579915] Modules linked in: amdkfd amd_iommu_v2 amdgpu i2c_algo_bit t=
tm drm_kms_helper drm xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masq=
uerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4=
 xt_conntrack nf_conntrack tun bridge ebtable_filter ebtables ip6table_filt=
er ip6_tables rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache snd_hda_codec_=
realtek snd_hda_codec_generic snd_hda_codec_hdmi kvm_amd snd_hda_intel vfat=
 fat kvm snd_hda_codec snd_hda_core eeepc_wmi asus_wmi irqbypass sparse_key=
map crct10dif_pclmul snd_hwdep snd_seq crc32_pclmul rfkill video crc32c_int=
el snd_seq_device mxm_wmi ghash_clmulni_intel snd_pcm snd_timer edac_mce_am=
d sp5100_tco edac_core joydev snd pcspkr fam15h_power k10temp i2c_piix4 tpm=
_infineon acpi_cpufreq soundcore tpm_tis nfsd tpm wmi shpchp
[   28.579940]  auth_rpcgss nfs_acl lockd grace sunrpc 8021q garp stp llc m=
rp r8169 serio_raw mii fjes
[   28.579944] CPU: 4 PID: 1276 Comm: Xorg Tainted: G        W       4.6.0+=
 #3
[   28.579945] Hardware name: To be filled by O.E.M. To be filled by O.E.M.=
/M5A97 LE R2.0, BIOS 2501 04/09/2014
[   28.579946]  0000000000000286 0000000018ea4846 ffff8800ad38bb38 ffffffff=
813cd56e
[   28.579948]  0000000000000000 0000000000000000 ffff8800ad38bb78 ffffffff=
810a4c9b
[   28.579949]  000000bb00000000 ffff8800b9d2a0a8 ffff8800b9d2a0a8 ffff8800=
b9d2a0b0
[   28.579951] Call Trace:
[   28.579952]  [<ffffffff813cd56e>] dump_stack+0x63/0x85
[   28.579954]  [<ffffffff810a4c9b>] __warn+0xcb/0xf0
[   28.579956]  [<ffffffff810a4dcd>] warn_slowpath_null+0x1d/0x20
[   28.579987]  [<ffffffffa067380a>] map_index_from_stream.isra.6.part.7+0x=
1a/0x20 [amdgpu]
[   28.580018]  [<ffffffffa067399d>] set_freesync_on_streams+0x8d/0x270 [am=
dgpu]
[   28.580050]  [<ffffffffa06747b6>] mod_freesync_set_user_enable+0x146/0x1=
80 [amdgpu]
[   28.580078]  [<ffffffffa062d719>] amdgpu_dm_connector_atomic_set_propert=
y+0x1d9/0x1f0 [amdgpu]
[   28.580088]  [<ffffffffa0514fc4>] drm_atomic_connector_set_property+0x34=
/0x70 [drm]
[   28.580093]  [<ffffffffa056d64b>] drm_atomic_helper_connector_set_proper=
ty+0x7b/0xc0 [drm_kms_helper]
[   28.580102]  [<ffffffffa0503039>] ? _object_find+0x69/0xa0 [drm]
[   28.580112]  [<ffffffffa050a437>] drm_mode_obj_set_property_ioctl+0x177/=
0x250 [drm]
[   28.580121]  [<ffffffffa050a54f>] drm_mode_connector_property_set_ioctl+=
0x3f/0x60 [drm]
[   28.580129]  [<ffffffffa04fa912>] drm_ioctl+0x152/0x540 [drm]
[   28.580131]  [<ffffffff811b1c26>] ? filemap_map_pages+0x126/0x340
[   28.580140]  [<ffffffffa050a510>] ? drm_mode_obj_set_property_ioctl+0x25=
0/0x250 [drm]
[   28.580142]  [<ffffffff811ee2b3>] ? unmap_region+0xf3/0x130
[   28.580144]  [<ffffffff817cd40e>] ? _raw_spin_unlock_irqrestore+0xe/0x10
[   28.580166]  [<ffffffffa05a004c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[   28.580168]  [<ffffffff81252cb1>] do_vfs_ioctl+0xa1/0x5a0
[   28.580170]  [<ffffffff81253229>] SyS_ioctl+0x79/0x90
[   28.580171]  [<ffffffff817cd832>] entry_SYSCALL_64_fastpath+0x1a/0xa4
[   28.580173] ---[ end trace 51ecc44c48a97e15 ]---



--_000_DM5PR12MB11325E0A696ABFE5006B4223F7140DM5PR12MB1132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>I just happened to notice this on my Tonga. &nbsp;It's otherwise operati=
ng fine. &nbsp;For ref, it's attached to a HDMI KVM which eventually makes =
it way to a DVI-D monitor.</p>
<p><br>
</p>
<p></p>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579561] ------------[ cut here ]------------</span>=
</div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579613] WARNING: CPU: 4 PID: 1276 at drivers/gpu/dr=
m/amd/amdgpu/../dal/modules/freesync/freesync.c:187 map_index_from_stream.i=
sra.6.part.7&#43;0x1a/0x20 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579615] Modules linked in: amdkfd amd_iommu_v2 amdg=
pu i2c_algo_bit ttm drm_kms_helper drm xt_CHECKSUM iptable_mangle ipt_MASQU=
ERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4
 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack tun brid=
ge ebtable_filter ebtables ip6table_filter ip6_tables rpcsec_gss_krb5 nfsv4=
 dns_resolver nfs fscache snd_hda_codec_realtek snd_hda_codec_generic snd_h=
da_codec_hdmi kvm_amd snd_hda_intel
 vfat fat kvm snd_hda_codec snd_hda_core eeepc_wmi asus_wmi irqbypass spars=
e_keymap crct10dif_pclmul snd_hwdep snd_seq crc32_pclmul rfkill video crc32=
c_intel snd_seq_device mxm_wmi ghash_clmulni_intel snd_pcm snd_timer edac_m=
ce_amd sp5100_tco edac_core joydev
 snd pcspkr fam15h_power k10temp i2c_piix4 tpm_infineon acpi_cpufreq soundc=
ore tpm_tis nfsd tpm wmi shpchp</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579646] &nbsp;auth_rpcgss nfs_acl lockd grace sunrp=
c 8021q garp stp llc mrp r8169 serio_raw mii fjes</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579653] CPU: 4 PID: 1276 Comm: Xorg Tainted: G &nbs=
p; &nbsp; &nbsp; &nbsp;W &nbsp; &nbsp; &nbsp; 4.6.0&#43; #3</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579655] Hardware name: To be filled by O.E.M. To be=
 filled by O.E.M./M5A97 LE R2.0, BIOS 2501 04/09/2014</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579656] &nbsp;0000000000000286 0000000018ea4846 fff=
f8800ad38bb80 ffffffff813cd56e</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579658] &nbsp;0000000000000000 0000000000000000 fff=
f8800ad38bbc0 ffffffff810a4c9b</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579660] &nbsp;000000bbb6cdf030 ffff8800b9d2a0a8 fff=
f8800b6d0f000 ffff8800ad38bc1a</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579661] Call Trace:</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579665] &nbsp;[&lt;ffffffff813cd56e&gt;] dump_stack=
&#43;0x63/0x85</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579668] &nbsp;[&lt;ffffffff810a4c9b&gt;] __warn&#43=
;0xcb/0xf0</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579670] &nbsp;[&lt;ffffffff810a4dcd&gt;] warn_slowp=
ath_null&#43;0x1d/0x20</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579702] &nbsp;[&lt;ffffffffa067380a&gt;] map_index_=
from_stream.isra.6.part.7&#43;0x1a/0x20 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579735] &nbsp;[&lt;ffffffffa0674730&gt;] mod_freesy=
nc_set_user_enable&#43;0xc0/0x180 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579766] &nbsp;[&lt;ffffffffa062d719&gt;] amdgpu_dm_=
connector_atomic_set_property&#43;0x1d9/0x1f0 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579782] &nbsp;[&lt;ffffffffa0514fc4&gt;] drm_atomic=
_connector_set_property&#43;0x34/0x70 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579790] &nbsp;[&lt;ffffffffa056d64b&gt;] drm_atomic=
_helper_connector_set_property&#43;0x7b/0xc0 [drm_kms_helper]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579799] &nbsp;[&lt;ffffffffa0503039&gt;] ? _object_=
find&#43;0x69/0xa0 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579809] &nbsp;[&lt;ffffffffa050a437&gt;] drm_mode_o=
bj_set_property_ioctl&#43;0x177/0x250 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579820] &nbsp;[&lt;ffffffffa050a54f&gt;] drm_mode_c=
onnector_property_set_ioctl&#43;0x3f/0x60 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579829] &nbsp;[&lt;ffffffffa04fa912&gt;] drm_ioctl&=
#43;0x152/0x540 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579835] &nbsp;[&lt;ffffffff811b1c26&gt;] ? filemap_=
map_pages&#43;0x126/0x340</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579845] &nbsp;[&lt;ffffffffa050a510&gt;] ? drm_mode=
_obj_set_property_ioctl&#43;0x250/0x250 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579847] &nbsp;[&lt;ffffffff811ee2b3&gt;] ? unmap_re=
gion&#43;0xf3/0x130</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579850] &nbsp;[&lt;ffffffff817cd40e&gt;] ? _raw_spi=
n_unlock_irqrestore&#43;0xe/0x10</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579871] &nbsp;[&lt;ffffffffa05a004c&gt;] amdgpu_drm=
_ioctl&#43;0x4c/0x80 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579874] &nbsp;[&lt;ffffffff81252cb1&gt;] do_vfs_ioc=
tl&#43;0xa1/0x5a0</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579876] &nbsp;[&lt;ffffffff81253229&gt;] SyS_ioctl&=
#43;0x79/0x90</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579878] &nbsp;[&lt;ffffffff817cd832&gt;] entry_SYSC=
ALL_64_fastpath&#43;0x1a/0xa4</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579879] ---[ end trace 51ecc44c48a97e14 ]---</span>=
</div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579880] ------------[ cut here ]------------</span>=
</div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579913] WARNING: CPU: 4 PID: 1276 at drivers/gpu/dr=
m/amd/amdgpu/../dal/modules/freesync/freesync.c:187 map_index_from_stream.i=
sra.6.part.7&#43;0x1a/0x20 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579915] Modules linked in: amdkfd amd_iommu_v2 amdg=
pu i2c_algo_bit ttm drm_kms_helper drm xt_CHECKSUM iptable_mangle ipt_MASQU=
ERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4
 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack tun brid=
ge ebtable_filter ebtables ip6table_filter ip6_tables rpcsec_gss_krb5 nfsv4=
 dns_resolver nfs fscache snd_hda_codec_realtek snd_hda_codec_generic snd_h=
da_codec_hdmi kvm_amd snd_hda_intel
 vfat fat kvm snd_hda_codec snd_hda_core eeepc_wmi asus_wmi irqbypass spars=
e_keymap crct10dif_pclmul snd_hwdep snd_seq crc32_pclmul rfkill video crc32=
c_intel snd_seq_device mxm_wmi ghash_clmulni_intel snd_pcm snd_timer edac_m=
ce_amd sp5100_tco edac_core joydev
 snd pcspkr fam15h_power k10temp i2c_piix4 tpm_infineon acpi_cpufreq soundc=
ore tpm_tis nfsd tpm wmi shpchp</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579940] &nbsp;auth_rpcgss nfs_acl lockd grace sunrp=
c 8021q garp stp llc mrp r8169 serio_raw mii fjes</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579944] CPU: 4 PID: 1276 Comm: Xorg Tainted: G &nbs=
p; &nbsp; &nbsp; &nbsp;W &nbsp; &nbsp; &nbsp; 4.6.0&#43; #3</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579945] Hardware name: To be filled by O.E.M. To be=
 filled by O.E.M./M5A97 LE R2.0, BIOS 2501 04/09/2014</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579946] &nbsp;0000000000000286 0000000018ea4846 fff=
f8800ad38bb38 ffffffff813cd56e</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579948] &nbsp;0000000000000000 0000000000000000 fff=
f8800ad38bb78 ffffffff810a4c9b</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579949] &nbsp;000000bb00000000 ffff8800b9d2a0a8 fff=
f8800b9d2a0a8 ffff8800b9d2a0b0</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579951] Call Trace:</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579952] &nbsp;[&lt;ffffffff813cd56e&gt;] dump_stack=
&#43;0x63/0x85</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579954] &nbsp;[&lt;ffffffff810a4c9b&gt;] __warn&#43=
;0xcb/0xf0</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579956] &nbsp;[&lt;ffffffff810a4dcd&gt;] warn_slowp=
ath_null&#43;0x1d/0x20</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.579987] &nbsp;[&lt;ffffffffa067380a&gt;] map_index_=
from_stream.isra.6.part.7&#43;0x1a/0x20 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580018] &nbsp;[&lt;ffffffffa067399d&gt;] set_freesy=
nc_on_streams&#43;0x8d/0x270 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580050] &nbsp;[&lt;ffffffffa06747b6&gt;] mod_freesy=
nc_set_user_enable&#43;0x146/0x180 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580078] &nbsp;[&lt;ffffffffa062d719&gt;] amdgpu_dm_=
connector_atomic_set_property&#43;0x1d9/0x1f0 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580088] &nbsp;[&lt;ffffffffa0514fc4&gt;] drm_atomic=
_connector_set_property&#43;0x34/0x70 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580093] &nbsp;[&lt;ffffffffa056d64b&gt;] drm_atomic=
_helper_connector_set_property&#43;0x7b/0xc0 [drm_kms_helper]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580102] &nbsp;[&lt;ffffffffa0503039&gt;] ? _object_=
find&#43;0x69/0xa0 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580112] &nbsp;[&lt;ffffffffa050a437&gt;] drm_mode_o=
bj_set_property_ioctl&#43;0x177/0x250 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580121] &nbsp;[&lt;ffffffffa050a54f&gt;] drm_mode_c=
onnector_property_set_ioctl&#43;0x3f/0x60 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580129] &nbsp;[&lt;ffffffffa04fa912&gt;] drm_ioctl&=
#43;0x152/0x540 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580131] &nbsp;[&lt;ffffffff811b1c26&gt;] ? filemap_=
map_pages&#43;0x126/0x340</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580140] &nbsp;[&lt;ffffffffa050a510&gt;] ? drm_mode=
_obj_set_property_ioctl&#43;0x250/0x250 [drm]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580142] &nbsp;[&lt;ffffffff811ee2b3&gt;] ? unmap_re=
gion&#43;0xf3/0x130</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580144] &nbsp;[&lt;ffffffff817cd40e&gt;] ? _raw_spi=
n_unlock_irqrestore&#43;0xe/0x10</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580166] &nbsp;[&lt;ffffffffa05a004c&gt;] amdgpu_drm=
_ioctl&#43;0x4c/0x80 [amdgpu]</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580168] &nbsp;[&lt;ffffffff81252cb1&gt;] do_vfs_ioc=
tl&#43;0xa1/0x5a0</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580170] &nbsp;[&lt;ffffffff81253229&gt;] SyS_ioctl&=
#43;0x79/0x90</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580171] &nbsp;[&lt;ffffffff817cd832&gt;] entry_SYSC=
ALL_64_fastpath&#43;0x1a/0xa4</span></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace; font-s=
ize: 10pt;">[ &nbsp; 28.580173] ---[ end trace 51ecc44c48a97e15 ]---</span>=
</div>
<div><br>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_DM5PR12MB11325E0A696ABFE5006B4223F7140DM5PR12MB1132namp_--

--===============1826118011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1826118011==--
