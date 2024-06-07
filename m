Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E915EC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B6A10EC68;
	Fri,  7 Jun 2024 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jNaaCBXD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE9B10EC68
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 13:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq1djB8gGslbir8XPEUIkspKoAxihFmeWeq7FKQ5VUfe+X1KycxcI3pEHHtjB6iK7/+4b7Gqm5D5ujBNblceo1hbIcnAia5f1xwF2r6fclRuJTzFQUu2Bi79Kh4CW+7dxUZhUBapHgtRcqyNXCWsjGJ4XEzyF0BPycTbPauFxRmAQCO9do8oJmeRTD3K+uNpqHGyoO+Qed45AjEgYtq8k0ZZH9X8FO8pmOdZ29rqhd4SKKHiGe5CrqD9foAJqM00DY1DUvqH6AQerTPzrR+nldcBmrYii5A7o40I8677nMZbvSCkp8N5Njs1FsHaefuE1EyhC9pXtOkfZm6WIMopfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RwSra7yZoHG97Zku7W/HUc18QaDOyQQKQP8g82X9qc=;
 b=JdteMzip+pMM0eoQOdvl5XAgTPCbNJIdR6Pby0UvbTQhpRXGnhtAdKJAQWbcq5ByW9izrdWdcE16k8dbxYPVhKl9Ku42FvZ4W6u/cdFUrYFeJNi6tTpFf48b8mYZEIVh07qmGzRTIRODommYXkn5+/+YF4BQlbvSjxNTEvZibAETAHCN3tz5K+1KSs80S4pxPEFGKEbla4oo7DrRa7hGB/DyeKCLRvt4AadWx2OjxyKGMKxjiWj0dqpTC0g/P7XicT/JhWcTYQzdpfoS/e5+DYL38E34Duhs2w96WtaP5gNUJuna52Dmt/kmkXzw2R3p9NX8DPoR+ylQkig4/E9tTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RwSra7yZoHG97Zku7W/HUc18QaDOyQQKQP8g82X9qc=;
 b=jNaaCBXD7vXBHAIx+SiFgydlX4k2RwL8yteCYktUZIvxnDPCrnnV4S9RPK+IEJ8wy23XUvsBsNyPE6ut8qUjJD/Rn1+N/oAoAYdXchxp53S4a6bW6cuYAY/yuPBFYhjGRbwo33nlF5u/AYx9EQJWIO9ISTn6mmY9FxaFjlsDPh4=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:55:24 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:55:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Thomas Glanzmann <thomas@glanzmann.de>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan@glanzmann.de" <Pan@glanzmann.de>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory
 with ring turned off.
Thread-Topic: [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory
 with ring turned off.
Thread-Index: AQHauJaL/Kp7ezY/3UCsOKO3TtnWxbG8U2TQ
Date: Fri, 7 Jun 2024 13:55:24 +0000
Message-ID: <BN9PR12MB51464A7312B77085E72C468AF7FB2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <ZmKSGSvm91qXzN_J@glanzmann.de>
In-Reply-To: <ZmKSGSvm91qXzN_J@glanzmann.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=92753daf-27e6-48e2-be8c-955fa344f04f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-07T13:55:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN2PR12MB4421:EE_
x-ms-office365-filtering-correlation-id: b40cb024-bf87-4b53-8a76-08dc86f97aa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?kBRKqnK6y1eR22d9gz5NqveciwCdv65WgDxxn/s6kVmfdXD/0aM/E6MiKyHg?=
 =?us-ascii?Q?ygPS+ajQT9KKZVGF0M/MbivVyo4Q8qt0Xr+acga7ai66JCxaDa6PBwgpqvNs?=
 =?us-ascii?Q?VJboQ+QrWZUufbh/3YB6jtXaUEuDCMYNyjD3GMiGXapNmxqRFYqcBc6XBtrD?=
 =?us-ascii?Q?1Fc6HffRXidboxjo/5TMjnqyLS9CTy5rnobsABBegmaFCu/fHf3CjHXhQlST?=
 =?us-ascii?Q?kJlR0qciX40//JF+0fPgcY3eH3w3bz57t6J/HlnGSw/N2LIKcAAn7BtZqhBt?=
 =?us-ascii?Q?/9Rc3xvRCNQZTvUkM/7AGfVDgG92EPluOZXn6BGsu/MjqUsvH1gfAaz3kZ7s?=
 =?us-ascii?Q?baJYJe0PpyLmlBa1+ihZQvCnUhhH9mDIwdwyFL9iAYYW19NAE55cGwJSzfw8?=
 =?us-ascii?Q?DrnIS3fG2VFVYR2VSSCm0HlPRDEQ6dbrfx/WgtNEET5jXuhrzK0OP/zBQLiA?=
 =?us-ascii?Q?VnzOxOxVGfQTvRHm76GA76/ytyxklIn2BzeiIyOTxhox/aJdeY8fGsOKsTTu?=
 =?us-ascii?Q?AzTqWlJHVdapeV1BUjR2KSAE66AQM+h0idSugg32Eq7DUY8OaayWCswDGyet?=
 =?us-ascii?Q?HsnheoTXLDP/xPYJxR6wtflTlDb3QR0m0Ct1vOUkbtBFAG9Lvc5SNsWlu25Z?=
 =?us-ascii?Q?HSg5G3gcCKcBXq+fNBuopYNKDOfKBWJT17LHBQeem8B34hqNLBdMZPqO4x4O?=
 =?us-ascii?Q?JQpUmHh/ePlW9dER+dSfs8uupJ/oB6NB6L/PjkVU/UnLQM/CZkgxKbgGNn/G?=
 =?us-ascii?Q?b+r3KlMjE5+zbpMWWoa4pYuGfjpREamY0/VnnNdryOlb1sbnOjKeplmkofVU?=
 =?us-ascii?Q?CbwGxuLQMSQ53+LqA4qOlUsa9fZ0DBhK6JK+dDmyYjK3rkPt1zAooqbS4sfA?=
 =?us-ascii?Q?NCoxNjU3tAXBwSH5FkTW5SpxucPzzBFLCeM9puY2NqUp/QecyNAQgiBKfniZ?=
 =?us-ascii?Q?2HVJJTTP79DKPLDTus0iDx26kzcPxxX6JjxKae9uCARZMRy1l4G8QTNQdvgI?=
 =?us-ascii?Q?WNQC5AtKFI1j1ordemQFb12V7NGFvxppvgkRjRtCAAxE3Ob39eAAQ8EeEKQR?=
 =?us-ascii?Q?bZ5zDEJ3Ep3Y3hgEpUNHxcMpCCsiI0ruL+QEAQNgGuuSvxYVL6cKXfSW9FEk?=
 =?us-ascii?Q?Fhh/wEDRbvh4QzCtDtLMygpYSqf7F9jCm3LzQPKOTOBYl16IZRXsvbE+Swz4?=
 =?us-ascii?Q?1zsvv8/0VD9wF06T7CT0fntfhw/pxiIuYiu21vTBTVQ/7zJ1bi76DkfkqFfb?=
 =?us-ascii?Q?lnnLWBpL8IBDyNWOFSPV/tzxHzzctLDc4bD6FRWmjMMBTjTwVNfYbUXH+/+w?=
 =?us-ascii?Q?ykE4EmtP+lY/pkACQ03TEtjp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MXCZuV15buaRAdgf5uMEOozPRXUx8iN3KSp9tP6c8phFaXufF6Fgo5NsA670?=
 =?us-ascii?Q?wSK13r+8IGsN0FTp4CkUDRxDB+vOtwedy1oFnktbHOP2YLovAo/qVFtJmD1I?=
 =?us-ascii?Q?F5QFeQAdNYPo+yAuon03zyk9u51smElFuJWiHv3AxY/bf+PiCnhXEu8uzLqd?=
 =?us-ascii?Q?6bQaHs0KIzYVuq+mNqrHaNjkGgmD4fcEhEopwm7QSK9S52urey+RsQYQ2QMv?=
 =?us-ascii?Q?5aDTuUiLk5mxLb11v+IrnnGJ1duSyWp62/O7E49HtaV34aFFovNH1xnpLrJK?=
 =?us-ascii?Q?/CCRFysddDzJwco+bIpapsZ3o9UEvGZtw1p3MZ2qm3K5+iFMSu+TTtNdkbfD?=
 =?us-ascii?Q?P1jacG1ZSmcuGmXA6QalxpA9vZ3hIA3ov7W3Rw218ZZl7kDhr4uj7KbIVJSk?=
 =?us-ascii?Q?d4yz2hZ6+8oAD4ZBNvtWhRbBK1ElEc4xlyE1zO/RUE1NzIMQcUJUKZ3c1diu?=
 =?us-ascii?Q?SdUu6aDtbcLw0Fg3JC8+doxhnnjLONqU7S3KydvC+Ga28GQea3MJw60ffNmO?=
 =?us-ascii?Q?sjrIjN+0lEIUsqgP6V9X97bQpiUuuxp4OffKAQitJ3cp89zp+afIx+meEBUV?=
 =?us-ascii?Q?3rap8m10gWGXV81+t9CULmvP/NPCS3yMfJ4otG/GdeHcwDrJ7ERc5iPJgihJ?=
 =?us-ascii?Q?DiYTtDHCz6xBfQWJCo1Gdaow8ADDcjQpZJ+oJronTdtpg1muaK/JHLToNMyx?=
 =?us-ascii?Q?p7jRL8Ac5FEx7Fd6LYWeMcc8MhTyszzIf2HE5Q7Bp2mmSMHExxO+XckW6AZP?=
 =?us-ascii?Q?Ohnpxgbi0IspKclsLCnQlDuN0IL48fDZa9osOACvsr6EdTV2uWoZP3hisfst?=
 =?us-ascii?Q?nN6JWuUWy4lQ4Vpkx1pt1Cd+UtHDcic6jZP7FKT2v0yL/yTIcVUwY+RAjH4o?=
 =?us-ascii?Q?q9o8u99+oq04jtL65HD2BJuKI1HRxITcFeFItVUsjtW7dYthZe7TEpUvGAH5?=
 =?us-ascii?Q?MCBR8z2EOLfBgtuZV1hGyJ92/qYO1QSph2KVPZf04AhKD3KwtASklCn7VQqh?=
 =?us-ascii?Q?FjOWQRRXfH02q75yFYzbtOm6AO3i5O92E9VfsRzL2RrRYxxY4KWpbO1FGJzs?=
 =?us-ascii?Q?l7jKwB8tLhDp6EMpnQsv/OphpXJUo0S/n3NkvI7WsfB3mHM/3giu0TJw3MnK?=
 =?us-ascii?Q?8tYLy7vJtH9sUl6i4WPrFP7WDn52j7Lbr+rA43v41Py/isR0idvtpsVcHLeL?=
 =?us-ascii?Q?kou5thIKdEHQGbOsqiMUefs+DJw6pzQjB+feE9DigkVBWNuZ01WRz6rYrjNw?=
 =?us-ascii?Q?LaZV4dQjlFH+p6BBMEwjxJJE81a2RtfkTjf20fFCSRJz37ntUgd8bMn8f/cd?=
 =?us-ascii?Q?D5Pf6de+XQthSSjF0ifClCHrt5k6JbjhRlqhMul7FH4drFZMcDUbrTaiJFzB?=
 =?us-ascii?Q?KlE38mi4qJoDiuRCEIoe8OwSnzcUbYIm+vAxUgCUpGu9yhOPo+tkNosBb/lM?=
 =?us-ascii?Q?llauZiX6crYSQ+GWjZmyNGP6X8ZFgIWAODv6E8TY5PgEfYN6ao3NN2/ag4FX?=
 =?us-ascii?Q?0yNocHnbMecDTDKxzhSdhNi8k0VMdZp0XdLP0Ung8g0JNNs6cwO3xuYvaldy?=
 =?us-ascii?Q?XPgv0E2TZngYrt80gzE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40cb024-bf87-4b53-8a76-08dc86f97aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 13:55:24.2039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeTHYA4BF+Z8mBBKODvpJYHRBtBhkAVTmvFSB0Zzxtq+otU7DFhcP3SdAj5Q4DAz/hZXTeGllHTSulsH3zqnxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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

[Public]

> -----Original Message-----
> From: Thomas Glanzmann <thomas@glanzmann.de>
> Sent: Friday, June 7, 2024 12:53 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan@glanzmann.de; Pan, Xinhui
> <Xinhui.Pan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory
> with ring turned off.
>
> Hello,
> starting with 6.10.0-rc1 I get the following in dmesg:

Should be fixed with this patch:
https://patchwork.freedesktop.org/patch/597421/

Alex

>
> [   11.025935] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
> memory with ring turned off.
> [   11.026037] ------------[ cut here ]------------
> [   11.026038] WARNING: CPU: 10 PID: 659 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1382
> amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
> [   11.026114] Modules linked in: rtl2832_sdr videobuf2_vmalloc
> videobuf2_memops videobuf2_v4l2 videodev videobuf2_common r820t
> intel_rapl_msr amd_atl intel_rapl_common rtl2832 amdgpu(+) i2c_mux
> edac_mce_amd kvm_amd kvm ghash_clmulni_intel snd_hda_codec_realtek
> sha512_ssse3 snd_hda_codec_generic sha256_ssse3
> snd_hda_scodec_component sha1_ssse3 snd_hda_codec_hdmi
> dvb_usb_rtl28xxu snd_hda_intel dvb_usb_v2 snd_intel_dspcfg
> snd_intel_sdw_acpi dvb_core snd_hda_codec drm_exec mc amdxcp
> eeepc_wmi drm_buddy asus_wmi rc_core snd_hda_core aesni_intel
> gpu_sched battery drm_suballoc_helper sparse_keymap snd_hwdep
> platform_profile crypto_simd drm_display_helper cryptd snd_pcm rfkill
> wmi_bmof drm_ttm_helper snd_timer joydev rapl ttm sp5100_tco snd pcspkr
> watchdog drm_kms_helper k10temp ccp soundcore i2c_algo_bit rng_core
> button evdev nfsd auth_rpcgss nfs_acl lockd parport_pc grace ppdev lp
> parport drm fuse loop efi_pstore dm_mod configfs sunrpc ip_tables x_table=
s
> autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10
> [   11.026138]  raid456 async_raid6_recov async_memcpy async_pq
> async_xor async_tx raid1 raid0 md_mod hid_lenovo hid_generic usbhid hid
> ahci nvme libahci xhci_pci mpt3sas nvme_core libata xhci_hcd t10_pi r8169
> raid_class scsi_transport_sas realtek crc64_rocksoft mdio_devres
> crc32_pclmul scsi_mod usbcore crc_t10dif crc32c_intel libphy
> crct10dif_generic i2c_piix4 video crct10dif_pclmul usb_common scsi_common
> crct10dif_common gpio_amdpt wmi gpio_generic
> [   11.026158] CPU: 10 PID: 659 Comm: (udev-worker) Not tainted 6.10.0-rc=
2
> #7
> [   11.026160] Hardware name: ASUS System Product Name/TUF GAMING
> B650M-PLUS, BIOS 2412 01/26/2024
> [   11.026162] RIP: 0010:amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
> [   11.026231] Code: 0b e9 b3 fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f=
6 4c 89 e7 e8
> 6b 72 3c fa eb 98 e8 f4 6b 3c fa eb b2 0f 0b e9 60 fe ff ff <0f> 0b eb a7=
 be 03
> 00 00 00 e8 8d 71 14 fa eb 9b e8 c6 5f 6b fa 66
> [   11.026233] RSP: 0018:ffffbff4412ab370 EFLAGS: 00010282
> [   11.026234] RAX: 00000000ffffffea RBX: ffff9e9dd60d4448 RCX:
> 0000000000000000
> [   11.026236] RDX: 0000000000000000 RSI: ffffffffbc628da6 RDI:
> 00000000ffffffff
> [   11.026237] RBP: ffff9e9dc9c0ef58 R08: 0000000000000000 R09:
> 0000000000000003
> [   11.026238] R10: ffffbff4412ab0f0 R11: ffff9ead1de35fe8 R12:
> ffff9e9dd60d4400
> [   11.026239] R13: ffff9e9dd60d4548 R14: ffff9e9dc9c0ef58 R15:
> 0000000000000258
> [   11.026240] FS:  00007fc9121948c0(0000) GS:ffff9eacddb00000(0000)
> knlGS:0000000000000000
> [   11.026241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   11.026242] CR2: 00007f11564d0790 CR3: 00000001072db000 CR4:
> 0000000000750ef0
> [   11.026243] PKRU: 55555554
> [   11.026244] Call Trace:
> [   11.026246]  <TASK>
> [   11.026247]  ? __warn+0x7c/0x120
> [   11.026251]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
> [   11.026329]  ? report_bug+0x189/0x1c0
> [   11.026332]  ? handle_bug+0x41/0x70
> [   11.026334]  ? exc_invalid_op+0x13/0x60
> [   11.026336]  ? asm_exc_invalid_op+0x16/0x20
> [   11.026338]  ? amdgpu_bo_release_notify+0x1f5/0x210 [amdgpu]
> [   11.026410]  ttm_bo_release+0xfb/0x2e0 [ttm]
> [   11.026413]  ? amdgpu_ttm_debugfs_init+0xf0/0xf0 [amdgpu]
> [   11.026484]  ? ttm_resource_move_to_lru_tail+0x138/0x1d0 [ttm]
> [   11.026486]  amdgpu_bo_free_kernel+0xc7/0x120 [amdgpu]
> [   11.026556]  dm_helpers_free_gpu_mem+0x3d/0x80 [amdgpu]
> [   11.026663]  dcn315_clk_mgr_construct+0x190/0x7e0 [amdgpu]
> [   11.026764]  dc_clk_mgr_create+0x31c/0x500 [amdgpu]
> [   11.026843]  dc_create+0x286/0x630 [amdgpu]
> [   11.026938]  amdgpu_dm_init.isra.0+0x2e9/0x1f10 [amdgpu]
> [   11.027022]  ? __irq_work_queue_local+0x3c/0xe0
> [   11.027025]  ? irq_work_queue+0x31/0x50
> [   11.027027]  ? vprintk_emit+0x17f/0x2b0
> [   11.027029]  ? dev_printk_emit+0xa1/0xd0
> [   11.027033]  dm_hw_init+0xe/0x20 [amdgpu]
> [   11.027104]  amdgpu_device_init+0x1f52/0x2740 [amdgpu]
> [   11.027180]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [   11.027183]  amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
> [   11.027253]  amdgpu_pci_probe+0x183/0x4f0 [amdgpu]
> [   11.027324]  local_pci_probe+0x3c/0x80
> [   11.027327]  pci_device_probe+0xc3/0x240
> [   11.027328]  really_probe+0xcd/0x370
> [   11.027330]  ? __device_attach_driver+0xf0/0xf0
> [   11.027331]  __driver_probe_device+0x78/0x150
> [   11.027332]  driver_probe_device+0x1f/0x90
> [   11.027333]  __driver_attach+0xbf/0x1b0
> [   11.027334]  bus_for_each_dev+0x81/0xd0
> [   11.027336]  bus_add_driver+0x10a/0x230
> [   11.027337]  driver_register+0x55/0xf0
> [   11.027339]  ? 0xffffffffc0e17000
> [   11.027340]  do_one_initcall+0x54/0x310
> [   11.027342]  do_init_module+0x60/0x230
> [   11.027345]  init_module_from_file+0x86/0xc0
> [   11.027347]  idempotent_init_module+0x120/0x2a0
> [   11.027349]  __x64_sys_finit_module+0x5a/0xb0
> [   11.027351]  do_syscall_64+0x80/0x190
> [   11.027353]  ? vm_mmap_pgoff+0x129/0x1c0
> [   11.027356]  ? fpregs_assert_state_consistent+0x1d/0x40
> [   11.027359]  ? syscall_exit_to_user_mode+0x76/0x1f0
> [   11.027360]  ? do_syscall_64+0x8c/0x190
> [   11.027361]  ? __do_sys_newfstatat+0x4e/0x80
> [   11.027364]  ? fpregs_assert_state_consistent+0x1d/0x40
> [   11.027366]  ? syscall_exit_to_user_mode+0x76/0x1f0
> [   11.027367]  ? do_syscall_64+0x8c/0x190
> [   11.027368]  ? fpregs_restore_userregs+0x11/0xc0
> [   11.027370]  ? syscall_exit_to_user_mode+0x76/0x1f0
> [   11.027371]  ? do_syscall_64+0x8c/0x190
> [   11.027372]  ? do_syscall_64+0x8c/0x190
> [   11.027373]  ? fpregs_assert_state_consistent+0x1d/0x40
> [   11.027374]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   11.027376] RIP: 0033:0x7fc91241f719
> [   11.027377] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 4=
8
> 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> [   11.027379] RSP: 002b:00007fffc491bc48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [   11.027380] RAX: ffffffffffffffda RBX: 000055a3eb64ff10 RCX:
> 00007fc91241f719
> [   11.027381] RDX: 0000000000000000 RSI: 00007fc9125b2efd RDI:
> 0000000000000018
> [   11.027382] RBP: 00007fc9125b2efd R08: 0000000000000000 R09:
> 000055a3eb54d730
> [   11.027383] R10: 0000000000000018 R11: 0000000000000246 R12:
> 0000000000020000
> [   11.027384] R13: 0000000000000000 R14: 000055a3eb64c470 R15:
> 000055a3d0094ec1
> [   11.027385]  </TASK>
> [   11.027386] ---[ end trace 0000000000000000 ]---
>
> Full dmesg:
> https://tg.st/u/9c7ed52e84c5a1fa8aa0943139b47f7312c66b70f6dec0deb4
> 09ead1a635c8c5.txt
>
> Cheers,
>         Thomas
