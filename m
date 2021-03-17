Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE16C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9BF64E90
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9BF64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE79F6E102;
	Wed, 17 Mar 2021 17:01:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22E66E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc8ziYsOdgkGxXe21xN9ocFlzX3RAtt48IypLWs0TvSRGUBkEpmtx7SOgr4/buu3JX1x8L3MTYDX13YpTkaunQBK/jGPd7V7tySAE+mDVCLJFyh4rv5tVg9q/jsweLUx3a4cRb7ScnZqrEJIhHnBnynzw3h6CxGCy43QnpTECcO8d1V/QMQX8OFSUCjVYs/rYMr8dYzZF4qqNTNsMB4q19w8u/ARO53zMNP7b45duHR4rUunYdvhYsSS85CwGOy/OvRmxZwRoGeOCixagygKLjGQ9TCCN1OD29T/DZAhzRiWm0lrPXKdQS095keGJlt/dfdUSKjx2lbaWyOSz3vXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IglD85GU/5zADV/yLuxjP7oqgMIYoYUyiz+PIIWbMDk=;
 b=KUgtGSsfC2/PIGhXVV6sBGYuR5ZaN7sxuZD+xuHbp7EJPW6kNEVl/MKCzopZVFOxqvQN82V4RjzlFaD5vrALcn63LUvrA2WLYVnI83HHJYNGb0ho2fv89omajbecv5NWItU3DpU7i253W7m/TDTeJGmygrJXoa5nPsiWAcHKQZ6PSv5DvCjhSsqsIzvQH12u7zIiB5SQZNJ3Xnd2Lj+X68yhnWTg+TP2vD4QXWdXJO+j2lAbbmHijxqiw4hDzLCPbUwCR/O91vTglz6JcS0JVO6whZ+LKXKwsgj4zQMmlMT9i8sjELodlorjdUeV6whyjFe+OrvjMfqUd5CQ/2Ytag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IglD85GU/5zADV/yLuxjP7oqgMIYoYUyiz+PIIWbMDk=;
 b=OR1GqZuY3Yg60XGj+EIKYZvauW5pAsy+Szy9CIDRzzmeOyKoqm07E94rFBf48wZK+HjiNWvQUv9W2SVeGN0fhiK39GqJBvliNHnyhMiroS01clcBtdtlwBemagUAUaI29ZPxKhIDsDzEmjS+WPSEfotyD71fCJtDhZhWYOn9Q54=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 17:01:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 17:01:32 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "harv@gmx.de" <harv@gmx.de>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
Thread-Topic: Amdgpu kernel oops and freezing on system suspend and hibernate
Thread-Index: AQHXG0p5RYHfl0EZ/0GCJ2t6T2vD76qIZ6b8
Date: Wed, 17 Mar 2021 17:01:32 +0000
Message-ID: <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
In-Reply-To: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-17T17:01:32.007Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03689fe7-0964-49ea-d25f-08d8e96650ff
x-ms-traffictypediagnostic: MN2PR12MB4583:
x-microsoft-antispam-prvs: <MN2PR12MB45830FAA82F9F471B3D276B4F76A9@MN2PR12MB4583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UmDuP+vVr87K9KbyZWx1vwhaCzQh+oRL232UNCJmNE9u+Co44e8moOGsMtsRtM5B1OwEJ/u92/5UUHE7G6bB2uoo1l0UcGAlFfzLyPxBjR1N0s9SIg3EqC1UHRzX56/J74XzU/avnIuYetMxGm5D4cIE0KvqXLl3L0xRjxgOcumGgbPegGbQY4JvQWPebbCvIBaTnb267kq4/6Yp7gRcpA6/oGyIz7gOCjuaHunFiWslC66cTmCm9JG7ib0gXHX/P3vT+vtxDJ3bEWqBzieWluFnaR0/+HhJO6GQHk3vdFGmvcjFD05o2mOyBlaOKYofyCUFoaEIbwL8pZ8coK9rCvpQuX1svd27/+qMzKcFh+z4yuTLZTFPvaPfsH2lnfocCYv/Kbl3Io9ZaPy51uuRA9EhIzfrXRwPH9Nb3p2c6wHcas5C7Shs/HPNkcxEZqT1c9f/rONLuOrl4MWmpoSZIDzTAbRpALiTEU1mjINwsTESJtrnmaodJUx+hz9OPgCLEnls6FjsK6sj7q+C3CcqY7GiOKIO1yOdxj0O8M4hVWxFBytJPN/+xTmlJxhWQGcsXdbGI+ZjTKRRm9L5FS67v3tMPQ0JCDNeqWAdjud1kDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(33656002)(8676002)(316002)(26005)(5660300002)(76116006)(8936002)(86362001)(83380400001)(52536014)(186003)(30864003)(166002)(15650500001)(110136005)(2906002)(19627405001)(966005)(71200400001)(478600001)(7696005)(53546011)(6506007)(66556008)(66476007)(9686003)(64756008)(66446008)(66946007)(45080400002)(55016002)(19627235002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x4/459TCrwh/pQBa5zEArZBd/3l/YdG7LEmSCwhkFTOLpK7ML1q2/APoFFGk?=
 =?us-ascii?Q?u2qFIv8YZGaCHq0pALIPMfiqD+DhosiVM2MB4ayzIBk52IYR1NpgOhjBZ62x?=
 =?us-ascii?Q?KTXATP5m5HcWmBOf+BtLvCgbx5PD9ML33ygrGRN65slmlZWlm8AeNJ2sr36S?=
 =?us-ascii?Q?6Aa/JPjm7++oT6F49aeegYPFIVbcqrClik3qJarapuSSX5IQGV71Xii0oTcq?=
 =?us-ascii?Q?LhFSSkpjn5ZxGE43AVmzUf1ARSSYu3sO0VAM217RvolFkfBtWQGZySMn25fQ?=
 =?us-ascii?Q?YFJB5SSxM9j4LNxw+CX8+OwEwhq/AXCazCh/q96KTzmymTwphVKwP3uiSEyB?=
 =?us-ascii?Q?mNAu3k8tAx60Zt/cQZPWpx7yUytZq+jrdy0hr4LMA1rQXUr2d9W0QMV9LXAV?=
 =?us-ascii?Q?1q5JxqiyZvu00Xg74ByVDiHlyXzOqKLmqwRr+aQs/44s+Cc1fuEkds0YbWc2?=
 =?us-ascii?Q?t73T9KMwlU7uRfs2E7kpo+LBjiI9Z+eiPLgYjzBrXj1vyMEDkCg4wVq3VWJV?=
 =?us-ascii?Q?H0HTcnfMn/TkBCi5/lPWq6yqPg2V20AtWwcl+R1ZTXTT5R4Rr/j1jg5XhvlE?=
 =?us-ascii?Q?jSQKVaE86mhkqtuoZ0wP3z41I2iRt7IBpn1qE+FM0+QUZvrisu8Mwc9zHgVT?=
 =?us-ascii?Q?7Mv3u5nlGd4OSlXFS+YR0nRyBzEzY9y5t0E7rA9kOnWfZ451HR4NAcPFyiw4?=
 =?us-ascii?Q?6cw1UgI96ePX3cInteguEsaKo6BZ87GbmibYWNI2tVUYp2H3X8l97RZp1xYH?=
 =?us-ascii?Q?KkbkkIOLV8PhGzjlscRaSfMNhXz7gO5Pe+YwCU9lvki0rW7tHfsIpNgzTREL?=
 =?us-ascii?Q?pyI0/F+jakbNLI0lmofmRG0csxPNadRxrjntiyS3hOlnLQ4NJpKxo/JhKxjv?=
 =?us-ascii?Q?71mSbP1GK3p0PPs+aanRTSBy46DWCVmgQrHEbnxIPn9rYQrjhvA/BhZFS2YD?=
 =?us-ascii?Q?jc+zo8Fg/NN1QaVdHGmgdolEgUSoyYt1Mz14jv2QI1IfQYD9r5qtAP5lledP?=
 =?us-ascii?Q?Z2wMpV9YQJLySpP41UD0WBc5wTdhwtzpngMKXlJdbYI22NCbYUeatiShCXOG?=
 =?us-ascii?Q?qtX/c3T9qf+Sw6LbMxn5R3qTHN+8kNux+bmdBK5FO2s/YvcnAshubXrCKPHK?=
 =?us-ascii?Q?GABY8g5hs5sY2ZasX9xZXfWCUL9pVCvkKn9QAmqj027HERiAvq/VljlODeKM?=
 =?us-ascii?Q?YL/iUXUP96lZAIW3HPKtkbrlcozsqlYQTfedMHncPBkWYXoRhsNbgbjAfJom?=
 =?us-ascii?Q?pl1KM5fHS5gLtIEUGNJmwXzHP+uNXQrWnlTT9BY70yhZxkYzfh6AaBr2yxZP?=
 =?us-ascii?Q?psk6ktk9xZwsBe5FWU1FwiP9?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03689fe7-0964-49ea-d25f-08d8e96650ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 17:01:32.5862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sHmcTkPqwspkGGZu7MWXA8wOqfOZE61WitfSFYmzVaLzpeqZsmaKA/etcL1Z+KwQ2R+EBte32QffCJAe0rSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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
Content-Type: multipart/mixed; boundary="===============1510881072=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1510881072==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488704D527398352637AC61F76A9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488704D527398352637AC61F76A9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please try the latest patch set on this bug:
https://gitlab.freedesktop.org/drm/amd/-/issues/1230<https://gitlab.freedes=
ktop.org/drm/amd/-/issues/1230#note_844139>

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Harvey <=
harv@gmx.de>
Sent: Wednesday, March 17, 2021 12:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Amdgpu kernel oops and freezing on system suspend and hibernate

Hello,

I own a laptop, a MSI Bravo 17 A4DDR/MS-17FK
with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M.

DMI: Micro-Star International Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS
E17FKAMS.117 10/29/2020

The system does not hibernate, it just freezes. Starting after a reset
it then resumes from the swap partition and gets the system up, but
shortly after that freezes again.

Even suspending is not working properly - on archlinux with kernel
5.11.6 and on 5.12-rc1 I see the following kernel oopses after resume:

The output of dmesg -l err,warn is:

[11020.188925] ------------[ cut here ]------------
[11020.188929] WARNING: CPU: 0 PID: 7736 at
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2574
dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]
[11020.189314] Modules linked in: rfcomm snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi cmac algif_hash
algif_skcipher af_alg bnep intel_rapl_msr intel_rapl_common iwlmvm
snd_hda_intel snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation soundwire_cadence nls_iso8859_1 vfat
mac80211 snd_hda_codec fat edac_mce_amd uvcvideo btusb snd_hda_core
kvm_amd btrtl libarc4 videobuf2_vmalloc btbcm snd_hwdep videobuf2_memops
hid_multitouch soundwire_bus videobuf2_v4l2 btintel pktcdvd iwlwifi
snd_soc_core kvm videobuf2_common bluetooth snd_compress videodev
ac97_bus snd_pcm_dmaengine snd_pcm snd_timer irqbypass msi_wmi
ecdh_generic joydev mousedev cfg80211 mc ecc rapl snd psmouse
snd_rn_pci_acp3x pcspkr sparse_keymap k10temp i2c_piix4 snd_pci_acp3x
soundcore rfkill tpm_crb tpm_tis tpm_tis_core pinctrl_amd i2c_hid
acpi_cpufreq mac_hid soc_button_array vboxnetflt(OE) vboxnetadp(OE)
vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user bpf_preload
ip_tables x_tables
[11020.189400]  ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom uas
usb_storage dm_crypt cbc encrypted_keys dm_mod trusted tpm
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
aesni_intel crypto_simd cryptd glue_helper serio_raw ccp xhci_pci
xhci_pci_renesas rng_core wmi video usbhid r8168(OE) amdgpu
drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm agpgart
[11020.189445] CPU: 0 PID: 7736 Comm: systemd-sleep Tainted: G
  OE     5.11.6-arch1-1 #1
[11020.189450] Hardware name: Micro-Star International Co., Ltd. Bravo
17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
[11020.189453] RIP: 0010:dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]
[11020.189792] Code: 88 03 00 00 31 c0 48 8d 96 f0 01 00 00 48 8b 0a 48
85 c9 74 06 48 3b 59 08 74 20 83 c0 01 48 81 c2 d0 04 00 00 83 f8 06 75
e3 <0f> 0b 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d 41 5e c3 48 98 48 69 c0
[11020.189795] RSP: 0018:ffffc1f003373c38 EFLAGS: 00010246
[11020.189799] RAX: 0000000000000006 RBX: ffff9e244e0ea800 RCX:
0000000000000000
[11020.189802] RDX: ffff9e2582fe1ed0 RSI: ffff9e2582fe0000 RDI:
0000000000000000
[11020.189804] RBP: ffff9e244e0f0000 R08: 00000000000000f9 R09:
ffff9e244323a000
[11020.189806] R10: ffff9e244323ae40 R11: 0000000001320122 R12:
000000000000fa01
[11020.189808] R13: 0000000000000000 R14: 000000000000fa42 R15:
0000000000000003
[11020.189810] FS:  00007f6219470a40(0000) GS:ffff9e275f600000(0000)
knlGS:0000000000000000
[11020.189813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11020.189815] CR2: 00007fb7a8980180 CR3: 0000000109cae000 CR4:
0000000000350ef0
[11020.189818] Call Trace:
[11020.189828]  amdgpu_dm_backlight_update_status+0xb4/0xc0 [amdgpu]
[11020.190185]  backlight_suspend+0x6a/0x80
[11020.190192]  ? brightness_store+0x80/0x80
[11020.190197]  dpm_run_callback+0x4c/0x150
[11020.190202]  __device_suspend+0x11c/0x4d0
[11020.190205]  dpm_suspend+0xef/0x230
[11020.190209]  dpm_suspend_start+0x77/0x80
[11020.190213]  suspend_devices_and_enter+0x109/0x800
[11020.190219]  pm_suspend.cold+0x329/0x374
[11020.190225]  state_store+0x71/0xd0
[11020.190230]  kernfs_fop_write_iter+0x124/0x1b0
[11020.190236]  new_sync_write+0x159/0x1f0
[11020.190241]  vfs_write+0x1fc/0x2a0
[11020.190245]  ksys_write+0x67/0xe0
[11020.190249]  do_syscall_64+0x33/0x40
[11020.190255]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[11020.190261] RIP: 0033:0x7f6219de10f7
[11020.190265] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[11020.190268] RSP: 002b:00007fff7ae91318 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[11020.190272] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:
00007f6219de10f7
[11020.190275] RDX: 0000000000000004 RSI: 00007fff7ae91400 RDI:
0000000000000004
[11020.190276] RBP: 00007fff7ae91400 R08: 000055e3a1261b70 R09:
00007f6219e770c0
[11020.190278] R10: 00007f6219e76fc0 R11: 0000000000000246 R12:
0000000000000004
[11020.190280] R13: 000055e3a125d3c0 R14: 0000000000000004 R15:
00007f6219eb3700
[11020.190284] ---[ end trace e7dfefa87a0c3feb ]---
[11020.853160] IRQ 85: no longer affine to CPU1
[11020.856648] IRQ 86: no longer affine to CPU2
[11020.859859] IRQ 87: no longer affine to CPU3
[11020.862584] IRQ 88: no longer affine to CPU4
[11020.865211] IRQ 89: no longer affine to CPU5
[11020.867656] IRQ 90: no longer affine to CPU6
[11020.870520] IRQ 91: no longer affine to CPU7
[11020.873539] IRQ 92: no longer affine to CPU8
[11020.876530] IRQ 93: no longer affine to CPU9
[11020.879551] IRQ 94: no longer affine to CPU10
[11023.064667] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not
matched

the lspci -k output is:

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
        Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
        Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
        Kernel driver in use: pcieport
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
        Kernel driver in use: pcieport
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
        Kernel driver in use: pcieport
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
        Kernel driver in use: pcieport
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal
PCIe GPP Bridge to Bus
        Kernel driver in use: pcieport
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal
PCIe GPP Bridge to Bus
        Kernel driver in use: pcieport
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
(rev 51)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: piix4_smbus
        Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
(rev 51)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 3
        Kernel driver in use: k10temp
        Kernel modules: k10temp
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Upstream Port of PCI Express Switch (rev c1)
        Kernel driver in use: pcieport
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Downstream Port of PCI Express Switch
        Kernel driver in use: pcieport
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
14 [Radeon RX 5500/5500M / Pro 5500M] (rev c1)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10
HDMI Audio
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
        Subsystem: Intel Corporation Device 0084
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: r8168
        Kernel modules: r8169, r8168
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe
SSD Controller SM981/PM981/PM983
        Subsystem: Samsung Electronics Co Ltd Device a801
        Kernel driver in use: nvme
07:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Renoir (rev c6)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: amdgpu
        Kernel modules: amdgpu
07:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 10h-1fh) Platform Security Processor
        Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
10h-1fh) Platform Security Processor
        Kernel driver in use: ccp
        Kernel modules: ccp
07:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
07:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
07:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x
07:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) HD Audio Controller
        DeviceName: HD Audio Controller
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel
08:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 81)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: ahci
08:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 81)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
        Kernel driver in use: ahci

I suppose the amdgpu module is at fault here?

Greetings
Harvey


--_000_MN2PR12MB4488704D527398352637AC61F76A9MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please try the latest patch set on this bug:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_844139=
" id=3D"LPlnk">https://gitlab.freedesktop.org/drm/amd/-/issues/1230</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Harvey &lt;harv@gmx.de&gt;<br=
>
<b>Sent:</b> Wednesday, March 17, 2021 12:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Amdgpu kernel oops and freezing on system suspend and hiber=
nate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello,<br>
<br>
I own a laptop, a MSI Bravo 17 A4DDR/MS-17FK<br>
with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M.<br>
<br>
DMI: Micro-Star International Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS <br>
E17FKAMS.117 10/29/2020<br>
<br>
The system does not hibernate, it just freezes. Starting after a reset <br>
it then resumes from the swap partition and gets the system up, but <br>
shortly after that freezes again.<br>
<br>
Even suspending is not working properly - on archlinux with kernel <br>
5.11.6 and on 5.12-rc1 I see the following kernel oopses after resume:<br>
<br>
The output of dmesg -l err,warn is:<br>
<br>
[11020.188925] ------------[ cut here ]------------<br>
[11020.188929] WARNING: CPU: 0 PID: 7736 at <br>
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2574 <br>
dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]<br>
[11020.189314] Modules linked in: rfcomm snd_hda_codec_realtek <br>
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi cmac algif_hash <br>
algif_skcipher af_alg bnep intel_rapl_msr intel_rapl_common iwlmvm <br>
snd_hda_intel snd_intel_dspcfg soundwire_intel <br>
soundwire_generic_allocation soundwire_cadence nls_iso8859_1 vfat <br>
mac80211 snd_hda_codec fat edac_mce_amd uvcvideo btusb snd_hda_core <br>
kvm_amd btrtl libarc4 videobuf2_vmalloc btbcm snd_hwdep videobuf2_memops <b=
r>
hid_multitouch soundwire_bus videobuf2_v4l2 btintel pktcdvd iwlwifi <br>
snd_soc_core kvm videobuf2_common bluetooth snd_compress videodev <br>
ac97_bus snd_pcm_dmaengine snd_pcm snd_timer irqbypass msi_wmi <br>
ecdh_generic joydev mousedev cfg80211 mc ecc rapl snd psmouse <br>
snd_rn_pci_acp3x pcspkr sparse_keymap k10temp i2c_piix4 snd_pci_acp3x <br>
soundcore rfkill tpm_crb tpm_tis tpm_tis_core pinctrl_amd i2c_hid <br>
acpi_cpufreq mac_hid soc_button_array vboxnetflt(OE) vboxnetadp(OE) <br>
vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user bpf_preload <br>
ip_tables x_tables<br>
[11020.189400]&nbsp; ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom ua=
s <br>
usb_storage dm_crypt cbc encrypted_keys dm_mod trusted tpm <br>
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel <br>
aesni_intel crypto_simd cryptd glue_helper serio_raw ccp xhci_pci <br>
xhci_pci_renesas rng_core wmi video usbhid r8168(OE) amdgpu <br>
drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper syscopyarea <br>
sysfillrect sysimgblt fb_sys_fops cec drm agpgart<br>
[11020.189445] CPU: 0 PID: 7736 Comm: systemd-sleep Tainted: G <br>
&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.11.6-arch1-1 #1<br>
[11020.189450] Hardware name: Micro-Star International Co., Ltd. Bravo <br>
17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020<br>
[11020.189453] RIP: 0010:dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]<br>
[11020.189792] Code: 88 03 00 00 31 c0 48 8d 96 f0 01 00 00 48 8b 0a 48 <br=
>
85 c9 74 06 48 3b 59 08 74 20 83 c0 01 48 81 c2 d0 04 00 00 83 f8 06 75 <br=
>
e3 &lt;0f&gt; 0b 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d 41 5e c3 48 98 48 69 c=
0<br>
[11020.189795] RSP: 0018:ffffc1f003373c38 EFLAGS: 00010246<br>
[11020.189799] RAX: 0000000000000006 RBX: ffff9e244e0ea800 RCX: <br>
0000000000000000<br>
[11020.189802] RDX: ffff9e2582fe1ed0 RSI: ffff9e2582fe0000 RDI: <br>
0000000000000000<br>
[11020.189804] RBP: ffff9e244e0f0000 R08: 00000000000000f9 R09: <br>
ffff9e244323a000<br>
[11020.189806] R10: ffff9e244323ae40 R11: 0000000001320122 R12: <br>
000000000000fa01<br>
[11020.189808] R13: 0000000000000000 R14: 000000000000fa42 R15: <br>
0000000000000003<br>
[11020.189810] FS:&nbsp; 00007f6219470a40(0000) GS:ffff9e275f600000(0000) <=
br>
knlGS:0000000000000000<br>
[11020.189813] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
[11020.189815] CR2: 00007fb7a8980180 CR3: 0000000109cae000 CR4: <br>
0000000000350ef0<br>
[11020.189818] Call Trace:<br>
[11020.189828]&nbsp; amdgpu_dm_backlight_update_status+0xb4/0xc0 [amdgpu]<b=
r>
[11020.190185]&nbsp; backlight_suspend+0x6a/0x80<br>
[11020.190192]&nbsp; ? brightness_store+0x80/0x80<br>
[11020.190197]&nbsp; dpm_run_callback+0x4c/0x150<br>
[11020.190202]&nbsp; __device_suspend+0x11c/0x4d0<br>
[11020.190205]&nbsp; dpm_suspend+0xef/0x230<br>
[11020.190209]&nbsp; dpm_suspend_start+0x77/0x80<br>
[11020.190213]&nbsp; suspend_devices_and_enter+0x109/0x800<br>
[11020.190219]&nbsp; pm_suspend.cold+0x329/0x374<br>
[11020.190225]&nbsp; state_store+0x71/0xd0<br>
[11020.190230]&nbsp; kernfs_fop_write_iter+0x124/0x1b0<br>
[11020.190236]&nbsp; new_sync_write+0x159/0x1f0<br>
[11020.190241]&nbsp; vfs_write+0x1fc/0x2a0<br>
[11020.190245]&nbsp; ksys_write+0x67/0xe0<br>
[11020.190249]&nbsp; do_syscall_64+0x33/0x40<br>
[11020.190255]&nbsp; entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
[11020.190261] RIP: 0033:0x7f6219de10f7<br>
[11020.190265] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f <br=
>
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f <br=
>
05 &lt;48&gt; 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 2=
4<br>
[11020.190268] RSP: 002b:00007fff7ae91318 EFLAGS: 00000246 ORIG_RAX: <br>
0000000000000001<br>
[11020.190272] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: <br>
00007f6219de10f7<br>
[11020.190275] RDX: 0000000000000004 RSI: 00007fff7ae91400 RDI: <br>
0000000000000004<br>
[11020.190276] RBP: 00007fff7ae91400 R08: 000055e3a1261b70 R09: <br>
00007f6219e770c0<br>
[11020.190278] R10: 00007f6219e76fc0 R11: 0000000000000246 R12: <br>
0000000000000004<br>
[11020.190280] R13: 000055e3a125d3c0 R14: 0000000000000004 R15: <br>
00007f6219eb3700<br>
[11020.190284] ---[ end trace e7dfefa87a0c3feb ]---<br>
[11020.853160] IRQ 85: no longer affine to CPU1<br>
[11020.856648] IRQ 86: no longer affine to CPU2<br>
[11020.859859] IRQ 87: no longer affine to CPU3<br>
[11020.862584] IRQ 88: no longer affine to CPU4<br>
[11020.865211] IRQ 89: no longer affine to CPU5<br>
[11020.867656] IRQ 90: no longer affine to CPU6<br>
[11020.870520] IRQ 91: no longer affine to CPU7<br>
[11020.873539] IRQ 92: no longer affine to CPU8<br>
[11020.876530] IRQ 93: no longer affine to CPU9<br>
[11020.879551] IRQ 94: no longer affine to CPU10<br>
[11023.064667] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not <br>
matched<br>
<br>
the lspci -k output is:<br>
<br>
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Advanced Micro Device=
s, Inc. [AMD] Renoir Root Complex<br>
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Advanced Micro Device=
s, Inc. [AMD] Renoir IOMMU<br>
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe <br>
Dummy Host Bridge<br>
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP <br>
Bridge<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe <br>
Dummy Host Bridge<br>
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP <br>
Bridge<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP <br>
Bridge<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP <br>
Bridge<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe <br>
Dummy Host Bridge<br>
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal <br>
PCIe GPP Bridge to Bus<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal <br>
PCIe GPP Bridge to Bus<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller <br>
(rev 51)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: piix4_smbu=
s<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: i2c_piix4, sp510=
0_tco<br>
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge <br>
(rev 51)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 0<br>
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 1<br>
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 2<br>
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: k10temp<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: k10temp<br>
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 4<br>
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 5<br>
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 6<br>
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device <br>
24: Function 7<br>
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL <br>
Upstream Port of PCI Express Switch (rev c1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL <br>
Downstream Port of PCI Express Switch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: pcieport<b=
r>
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi <br=
>
14 [Radeon RX 5500/5500M / Pro 5500M] (rev c1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: amdgpu<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: amdgpu<br>
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 <br>
HDMI Audio<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: snd_hda_in=
tel<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: snd_hda_intel<br=
>
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Intel Corporation Dev=
ice 0084<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: iwlwifi<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: iwlwifi<br>
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. <br>
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: r8168<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: r8169, r8168<br>
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe <br=
>
SSD Controller SM981/PM981/PM983<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Samsung Electronics C=
o Ltd Device a801<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: nvme<br>
07:00.0 VGA compatible controller: Advanced Micro Devices, Inc. <br>
[AMD/ATI] Renoir (rev c6)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: amdgpu<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: amdgpu<br>
07:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family <b=
r>
17h (Models 10h-1fh) Platform Security Processor<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Advanced Micro Device=
s, Inc. [AMD] Family 17h (Models <br>
10h-1fh) Platform Security Processor<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: ccp<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: ccp<br>
07:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: xhci_hcd<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: xhci_pci<br>
07:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: xhci_hcd<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: xhci_pci<br>
07:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] <br>
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: snd_pci_acp3x, s=
nd_rn_pci_acp3x<br>
07:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h <br>
(Models 10h-1fh) HD Audio Controller<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DeviceName: HD Audio Controller<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: snd_hda_in=
tel<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel modules: snd_hda_intel<br=
>
08:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA <br>
Controller [AHCI mode] (rev 81)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: ahci<br>
08:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA <br>
Controller [AHCI mode] (rev 81)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: Micro-Star Internatio=
nal Co., Ltd. [MSI] Device 12ac<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kernel driver in use: ahci<br>
<br>
I suppose the amdgpu module is at fault here?<br>
<br>
Greetings<br>
Harvey<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488704D527398352637AC61F76A9MN2PR12MB4488namp_--

--===============1510881072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1510881072==--
