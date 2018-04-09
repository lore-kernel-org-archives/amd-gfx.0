From: sunnanyong <sunnanyong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Oops in 4.16 kernel amdgpu driver
Date: Mon, 9 Apr 2018 02:31:11 +0000
Message-ID: <EB021AE3BDDC1742A899855D00BABEB0010466EB@DGGEMM506-MBX.china.huawei.com>
References: <EB021AE3BDDC1742A899855D00BABEB0010451CE@DGGEMM506-MBX.china.huawei.com>
 <E7DD0E9246072C4A9CA8F1C79F816696018E7743@dggemi505-mbx.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2010104758=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <E7DD0E9246072C4A9CA8F1C79F816696018E7743-k9ZYk3Ba6VKEZbDCDsDlKQK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Content-Language: zh-CN
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

--===============2010104758==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_EB021AE3BDDC1742A899855D00BABEB0010466EBDGGEMM506MBXchi_"

--_000_EB021AE3BDDC1742A899855D00BABEB0010466EBDGGEMM506MBXchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All ,
      Sometimes it happens Oops in linux kernel 4.16.0 AMDGPU driver, and i=
t nerver happen in 4.15 kernel.
Software environment:Ubuntu17.10 + newest stable kernel 4.16.0 + mesa v17.2=
.8
GPU: Radeon Pro WX5100      CPU: arm64
Here is the calltrace:
.
Apr  8 14:56:01 ubuntu kernel: [30040.729903] ------------[ cut here ]-----=
-------
Apr  8 14:56:01 ubuntu kernel: [30040.729914] kernel BUG at drivers/dma-buf=
/reservation.c:234!
Apr  8 14:56:01 ubuntu kernel: [30040.729926] Internal error: Oops - BUG: 0=
 [#1] SMP
Apr  8 14:56:01 ubuntu kernel: [30040.729932] Modules linked in: xt_nat xt_=
tcpudp veth ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptab=
le_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_fil=
ter xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc overlay sn=
d_hda_codec_hdmi binfmt_misc nls_iso8859_1 snd_hda_intel snd_hda_codec joyd=
ev input_leds snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore ipmi_s=
sif shpchp ipmi_si ipmi_devintf ipmi_msghandler ib_iser rdma_cm iw_cm ib_cm=
 ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_t=
ables autofs4 btrfs zstd_decompress zstd_compress xxhash raid10 raid456 asy=
nc_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc=
32c raid1 multipath linear dm_mirror dm_region_hash dm_log raid0 ses enclos=
ure hid_generic
Apr  8 14:56:01 ubuntu kernel: [30040.730037]  usbhid hid marvell amdgpu ch=
ash gpu_sched hibmc_drm i2c_algo_bit aes_ce_blk ttm aes_ce_cipher crc32_ce =
crct10dif_ce drm_kms_helper ghash_ce sha2_ce syscopyarea sha256_arm64 sysfi=
llrect sysimgblt sha1_ce fb_sys_fops drm mpt3sas hisi_sas_v2_hw hisi_sas_ma=
in raid_class libsas ehci_platform hns_dsaf scsi_transport_sas hns_enet_drv=
 hns_mdio hnae aes_neon_bs aes_neon_blk crypto_simd cryptd aes_arm64
Apr  8 14:56:01 ubuntu kernel: [30040.730094] CPU: 41 PID: 59025 Comm: amdg=
pu_cs:0 Tainted: G        W        4.16.0 #2
Apr  8 14:56:01 ubuntu kernel: [30040.730097] Hardware name: Huawei Taishan=
 2280 /BC11SPCD, BIOS 1.37 11/21/2017
Apr  8 14:56:01 ubuntu kernel: [30040.730100] pstate: 60400005 (nZCv daif +=
PAN -UAO)
Apr  8 14:56:01 ubuntu kernel: [30040.730118] pc : reservation_object_add_s=
hared_fence+0x348/0x3b8
Apr  8 14:56:01 ubuntu kernel: [30040.730147] lr : ttm_eu_fence_buffer_obje=
cts+0x5c/0xd8 [ttm]
Apr  8 14:56:01 ubuntu kernel: [30040.730148] sp : ffff00003aae39d0
Apr  8 14:56:01 ubuntu kernel: [30040.730150] x29: ffff00003aae39d0 x28: 00=
00000000000000
Apr  8 14:56:01 ubuntu kernel: [30040.730154] x27: ffff809c85067c60 x26: ff=
ff80af5e89abb8
Apr  8 14:56:01 ubuntu kernel: [30040.730158] x25: ffff809c92bb5060 x24: ff=
ff802e08141220
Apr  8 14:56:01 ubuntu kernel: [30040.730162] x23: ffff802fb55ea000 x22: ff=
ff809c92bb5060
Apr  8 14:56:01 ubuntu kernel: [30040.730165] x21: 0000000000000000 x20: ff=
ff80ad27471c00
Apr  8 14:56:01 ubuntu kernel: [30040.730169] x19: ffff00003aae3b70 x18: 00=
00fffd38040948
Apr  8 14:56:01 ubuntu kernel: [30040.730172] x17: 0000000000000000 x16: ff=
ff809e434b8f00
Apr  8 14:56:01 ubuntu kernel: [30040.730176] x15: 0000fffd38040940 x14: ff=
ff809f97332600
Apr  8 14:56:01 ubuntu kernel: [30040.730179] x13: ffff809c92bb4e60 x12: 00=
00000000000016
Apr  8 14:56:01 ubuntu kernel: [30040.730183] x11: 0000000000000000 x10: 00=
00000000000040
Apr  8 14:56:01 ubuntu kernel: [30040.730186] x9 : 0000000000000000 x8 : ff=
ff809c92bb5100
Apr  8 14:56:01 ubuntu kernel: [30040.730190] x7 : 00000000000000b8 x6 : 00=
00000000000001
Apr  8 14:56:01 ubuntu kernel: [30040.730193] x5 : 0000000000000003 x4 : 00=
00000000000002
Apr  8 14:56:01 ubuntu kernel: [30040.730196] x3 : ffff809b77ead88c x2 : 00=
00000000000001
Apr  8 14:56:01 ubuntu kernel: [30040.730200] x1 : 0000000000000008 x0 : 00=
00000000000008
Apr  8 14:56:01 ubuntu kernel: [30040.730205] Process amdgpu_cs:0 (pid: 590=
25, stack limit =3D 0x00000000469f89e7)
Apr  8 14:56:01 ubuntu kernel: [30040.730208] Call trace:
Apr  8 14:56:01 ubuntu kernel: [30040.730212]  reservation_object_add_share=
d_fence+0x348/0x3b8
Apr  8 14:56:01 ubuntu kernel: [30040.730225]  ttm_eu_fence_buffer_objects+=
0x5c/0xd8 [ttm]
Apr  8 14:56:01 ubuntu kernel: [30040.730482]  amdgpu_cs_ioctl+0x14f8/0x19f=
8 [amdgpu]
Apr  8 14:56:01 ubuntu kernel: [30040.730533]  drm_ioctl_kernel+0x70/0xd8 [=
drm]
Apr  8 14:56:01 ubuntu kernel: [30040.730578]  drm_ioctl+0x1d4/0x428 [drm]
Apr  8 14:56:01 ubuntu kernel: [30040.730771]  amdgpu_drm_ioctl+0x58/0x98 [=
amdgpu]
Apr  8 14:56:01 ubuntu kernel: [30040.730779]  do_vfs_ioctl+0xc4/0xb50
Apr  8 14:56:01 ubuntu kernel: [30040.730782]  SyS_ioctl+0x8c/0xa8
Apr  8 14:56:01 ubuntu kernel: [30040.730787]  el0_svc_naked+0x30/0x34
Apr  8 14:56:01 ubuntu kernel: [30040.730793] Code: 17ffff6e f9000bb3 a902d=
fb6 f90027ba (d4210000)
Apr  8 14:56:01 ubuntu kernel: [30040.730797] ---[ end trace 07398b112d335f=
c8 ]---


--_000_EB021AE3BDDC1742A899855D00BABEB0010466EBDGGEMM506MBXchi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi All , <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sometimes it happens Oops in linux kernel 4.16=
.0 AMDGPU driver, and it nerver happen in 4.15 kernel.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Softwar=
e environment:Ubuntu17.10 &#43; newest stable kernel 4.16.0 &#43; mesa v17.=
2.8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">GPU: Ra=
deon Pro WX5100&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;CPU: arm64<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Here is=
 the calltrace:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.729903] ------------[ cut here ]-------=
-----<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.729914] kernel BUG at drivers/dma-buf/r=
eservation.c:234!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.729926] Internal error: Oops - BUG: 0 [=
#1] SMP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.729932] Modules linked in: xt_nat xt_tc=
pudp veth ipt_MASQUERADE nf_nat_masquerade_ipv4 xfrm_user xfrm_algo iptable=
_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
 xt_addrtype iptable_filter xt_conntrack nf_nat nf_conntrack br_netfilter b=
ridge stp llc overlay snd_hda_codec_hdmi binfmt_misc nls_iso8859_1 snd_hda_=
intel snd_hda_codec joydev input_leds snd_hda_core snd_hwdep snd_pcm snd_ti=
mer snd soundcore ipmi_ssif shpchp
 ipmi_si ipmi_devintf ipmi_msghandler ib_iser rdma_cm iw_cm ib_cm ib_core i=
scsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables auto=
fs4 btrfs zstd_decompress zstd_compress xxhash raid10 raid456 async_raid6_r=
ecov async_memcpy async_pq async_xor
 async_tx xor raid6_pq libcrc32c raid1 multipath linear dm_mirror dm_region=
_hash dm_log raid0 ses enclosure hid_generic<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730037]&nbsp; usbhid hid marvell amdgpu=
 chash gpu_sched hibmc_drm i2c_algo_bit aes_ce_blk ttm aes_ce_cipher crc32_=
ce crct10dif_ce drm_kms_helper ghash_ce sha2_ce
 syscopyarea sha256_arm64 sysfillrect sysimgblt sha1_ce fb_sys_fops drm mpt=
3sas hisi_sas_v2_hw hisi_sas_main raid_class libsas ehci_platform hns_dsaf =
scsi_transport_sas hns_enet_drv hns_mdio hnae aes_neon_bs aes_neon_blk cryp=
to_simd cryptd aes_arm64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730094] CPU: 41 PID: 59025 Comm: amdgpu=
_cs:0 Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4.16.0 #2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730097] Hardware name: Huawei Taishan 2=
280 /BC11SPCD, BIOS 1.37 11/21/2017<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730100] pstate: 60400005 (nZCv daif &#4=
3;PAN -UAO)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730118] pc : reservation_object_add_sha=
red_fence&#43;0x348/0x3b8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730147] lr : ttm_eu_fence_buffer_object=
s&#43;0x5c/0xd8 [ttm]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730148] sp : ffff00003aae39d0<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730150] x29: ffff00003aae39d0 x28: 0000=
000000000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730154] x27: ffff809c85067c60 x26: ffff=
80af5e89abb8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730158] x25: ffff809c92bb5060 x24: ffff=
802e08141220<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730162] x23: ffff802fb55ea000 x22: ffff=
809c92bb5060<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730165] x21: 0000000000000000 x20: ffff=
80ad27471c00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730169] x19: ffff00003aae3b70 x18: 0000=
fffd38040948<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730172] x17: 0000000000000000 x16: ffff=
809e434b8f00<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730176] x15: 0000fffd38040940 x14: ffff=
809f97332600<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730179] x13: ffff809c92bb4e60 x12: 0000=
000000000016<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730183] x11: 0000000000000000 x10: 0000=
000000000040<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730186] x9 : 0000000000000000 x8 : ffff=
809c92bb5100<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730190] x7 : 00000000000000b8 x6 : 0000=
000000000001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730193] x5 : 0000000000000003 x4 : 0000=
000000000002<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730196] x3 : ffff809b77ead88c x2 : 0000=
000000000001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730200] x1 : 0000000000000008 x0 : 0000=
000000000008<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730205] Process amdgpu_cs:0 (pid: 59025=
, stack limit =3D 0x00000000469f89e7)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730208] Call trace:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730212]&nbsp; reservation_object_add_sh=
ared_fence&#43;0x348/0x3b8<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730225]&nbsp; ttm_eu_fence_buffer_objec=
ts&#43;0x5c/0xd8 [ttm]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730482]&nbsp; amdgpu_cs_ioctl&#43;0x14f=
8/0x19f8 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730533]&nbsp; drm_ioctl_kernel&#43;0x70=
/0xd8 [drm]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730578]&nbsp; drm_ioctl&#43;0x1d4/0x428=
 [drm]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730771]&nbsp; amdgpu_drm_ioctl&#43;0x58=
/0x98 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730779]&nbsp; do_vfs_ioctl&#43;0xc4/0xb=
50<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730782]&nbsp; SyS_ioctl&#43;0x8c/0xa8<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730787]&nbsp; el0_svc_naked&#43;0x30/0x=
34<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730793] Code: 17ffff6e f9000bb3 a902dfb=
6 f90027ba (d4210000)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Apr&nbs=
p; 8 14:56:01 ubuntu kernel: [30040.730797] ---[ end trace 07398b112d335fc8=
 ]---
</span><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
</div>
</body>
</html>

--_000_EB021AE3BDDC1742A899855D00BABEB0010466EBDGGEMM506MBXchi_--

--===============2010104758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2010104758==--
