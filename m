Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E3D64092
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 08:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8158510E7FC;
	Wed, 17 Dec 2025 08:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y2okppBL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A868910EBE8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 08:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYodZ7Sz91SbO/FhIbcZ0232/ipjFEWbdyTnnrFCesryHbMFJbQdMjAHfayxBHqpY1pXhpsonGfYsT1ODB/B1SOR6eG17cPJ+rIfmfaVGfwryHjRz/cCMrNsyljhVsjVgh/uu3iBsaQyX2WA5FPligRXH5SQAhcJXv53LJgiA2dmBQ1lGgkfIS/qsGv5gxCqkwV9gWkF9FP6pACZn7JrxEQkrDKhmwxnKA4DBn1WISWOEmGvEnp7f9iVCmd1hdTLY7MTOmwFB7mkMsRUfMm/B8O28q2keTyXJwVpv6Zh9gsxceB+4I9nBLM2vJaDiTP8BZJXjBhJV8JRUvBNBfu6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2i1iQvT6cQFh6xzxJNy256ZLt5Nm1QD2ROmu5yQ6eE=;
 b=C0+YbOU6u5vW0WovYEzeyY56nh8PFHr8CBlLgtGvvdThpifKPryoBVXV2q40RG4TacJQEezIzrfg8pXIZ3uRpRrVkQPVsAJCv7mvyawbXmDPwsIpsKuAxNxl7h7D1QtCurWXXBvWSUnLWDaveGPdtJLuthUJ5DdfGp9VrRLEW84D6a8CRr3Q0DEqxUnRQlmvXaOQUNIXBt3XdAagEwyItLLhTebPzfzP2xEzMAAQor0FT6Z31pky46iAUC3eTzAUl3yVuwb8khtUEjA7XmDOwSAILnLUhl0FLQ5xJF7As5COO27yZYc/V2pfA+BDGia5+x+bu4YYDhKdfQj/y7uZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2i1iQvT6cQFh6xzxJNy256ZLt5Nm1QD2ROmu5yQ6eE=;
 b=y2okppBLBykfkBIO9QJTySGEQP7QYhf/HGmKSW0UOjrfu/9lNeXACwU9I4dhCPIGwlN6BJwWuyd2qyrbFA/CPgitOMNHQThcrnFqMWEq+1QCr1zv11ryVlDimb9bRN5YjQnqe6ID7pAFTq0lApkMrfbn2ToXFi2PKOJTV4/UPAM=
Received: from SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:35:50 +0000
Received: from SJ2PR12MB7798.namprd12.prod.outlook.com
 ([fe80::95a5:4454:6ffb:ca65]) by SJ2PR12MB7798.namprd12.prod.outlook.com
 ([fe80::95a5:4454:6ffb:ca65%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 08:35:50 +0000
From: "Yao, Chengjun" <Chengjun.Yao@amd.com>
To: "Yao, Chengjun" <Chengjun.Yao@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH] drm/fb-helper: Fix vblank timeout during suspend/reset
Thread-Topic: [PATCH] drm/fb-helper: Fix vblank timeout during suspend/reset
Thread-Index: AQHcbZtqH0qIa9QnuUuuJxuGInCNcrUlhPDA
Date: Wed, 17 Dec 2025 08:35:50 +0000
Message-ID: <SJ2PR12MB77985EE047EE14673B955D6292ABA@SJ2PR12MB7798.namprd12.prod.outlook.com>
References: <20251215081822.432005-1-Chengjun.Yao@amd.com>
In-Reply-To: <20251215081822.432005-1-Chengjun.Yao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-17T08:35:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7798:EE_|CH2PR12MB4310:EE_
x-ms-office365-filtering-correlation-id: c2ac544a-0f36-4fc9-ae0f-08de3d4748cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kS5fNzKmdbLn5/lQDAgYkwsERV5inI3wA4C8312MX+L5xgryifJwaaDo0R42?=
 =?us-ascii?Q?2qxWXCkp4yfvvcn2REhFWLeATGvWoGcHDx8U/wGDYXVtxDCFZZX4HD9+PehB?=
 =?us-ascii?Q?oTKYAUIiuxBL6d6fh9xxZOvmJLARFgXUIQOcrtVHHQHq17Sv/kUdUrGSR0Cu?=
 =?us-ascii?Q?bZRfW/BT7li7RWKZ67ZDL087AjDXdxgojNTzXL45kjif/RdZAt/L8hH6OhoR?=
 =?us-ascii?Q?Y6nYh3acAKFiOCXDeUxeEGohLgFrFz97POuMNjitITjIJsDmEozs3hPFohhd?=
 =?us-ascii?Q?/s6QsgxFUjZIMkk2eViMnrjxOLMfQ0NuWmQxTw2O7TPUlqVjL+lsCmY97Uen?=
 =?us-ascii?Q?MasI0qbaGuom9DVysYKna477pW6++tVK3K5Yxy6PAaHXz5UlcphstzCpOS/s?=
 =?us-ascii?Q?2Pl/qjheh0smtR1i7is9riYJ8UUi3vuXBTP8cWCWK5CFxCN3JMcFIdOjWAtX?=
 =?us-ascii?Q?FYD9x9+/6wTQeNR3nTtaT0NhOqlhxMkpiXZZAYKyxAtCTXJtXsY8vuiJIvmw?=
 =?us-ascii?Q?yHDhX7IZrqBcPWfdBrZGmEmIxtIxp+3Mx1C/at5xiwfuPvIBpkjB1QSqZfeL?=
 =?us-ascii?Q?qTnk7mhRAurrJ3huA7NaDHLzDOAqpwIt7F+2FzLGWw9oI6w+oGN7YWLKq/9w?=
 =?us-ascii?Q?yzCZSnbKl0yZxv7/ux1oshLqcvk3IdfCo47OTBtxvVw5vRPKVVAmnLF8BUey?=
 =?us-ascii?Q?/47kwaLyygYvQaVLuXfLfiEKYz79Ff3L0bJ+sUEWARNpdTKnKX6Vx+iq/Nze?=
 =?us-ascii?Q?Y0rsFWl2q3Rwd4jxIOw37Q0WCH/6a+LOwRNXixOLMfjkaPiKEjyny93UJgmN?=
 =?us-ascii?Q?qOq52USwCavOiAkAqW5OT1CssYhyf2eLxZf57ue2A735OZs6JtR17WYN//fc?=
 =?us-ascii?Q?6ahOz12zOFg3ZXGe3+6nEZcKnr0XZVeRHVm1fgCoxp7YXzckbNp0rISA8oOZ?=
 =?us-ascii?Q?MUmLtUWPw1tpb4k3/c+k7ZJ61ippGCdJHyYH5rL8V4PFtyYQsWBXVpgALLWH?=
 =?us-ascii?Q?R8pAOYozosXBZGZ1LnskByQ91iAYCGi7sRTiC/fNxWLPlWuhq+wIHHew9Tnw?=
 =?us-ascii?Q?AnFCA/PTJ9yR+P5FRtYFiOjuS1z9UvYkY1o1R2YUbegNNzRDbrUjxsMV8xp+?=
 =?us-ascii?Q?dq1B8oEyiCrn4w7eudG8sM6Le2I0f9gjGn5KCDTltWh699+eIdWxZccEx3/H?=
 =?us-ascii?Q?WxGuGchuRn5eZzXircqyZtNkaOV0iaAqFSVqWFW9Kv31htS+aPDy5CW1203e?=
 =?us-ascii?Q?dtONM+sVN6IvJfqME1i9do82Z11tO2nH3wkrGLEMLU5mx48ymo1dfBL8Ed19?=
 =?us-ascii?Q?9NXDqKtQkaV+Grdk8XYrja9Xp8vJsv1COzseY8u+LiapsYDtmDGa2ceEAd2P?=
 =?us-ascii?Q?xs9cc6g+Vam6uEzD3PaKkCB1/8gzT8JH5elTTDqa1kEFoz/CnW/gH6I0QIHq?=
 =?us-ascii?Q?wPml9QAX98+SENYoREYUDjdBZL9gOyUKmUsGrHgAJ//VXUZPZ79r/keF3iF6?=
 =?us-ascii?Q?Ev3SVIWYOaw7PX4ai/jA/vgnY/M+iejvhyaW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7798.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pLWgEw60CYkmLnpAee+comkKR83Q6e1ptnweB7DAnYdm6OKrlR1mJDWoJT0o?=
 =?us-ascii?Q?RtS2lqYIQmqav3UIy7XKnIXjBQOuqy0HOtMsrJyRjhal0rO2/FZ63powqRWQ?=
 =?us-ascii?Q?IrQzEialOqOjS3lhPWvNYKkeAFThRawxFu5GLhQw0fYfoCXJrldTix6OB6jN?=
 =?us-ascii?Q?UOMIBOICto1FtNjPu135WsR15RpQx640vZRne/dAIzSVwjFvMjqWiaFyjq+u?=
 =?us-ascii?Q?HFz6lL+7vC7Pf5/H03AJYBCNh0QC/6nHpvR8kFevqjibAsOFbpX8Ufvt1JWE?=
 =?us-ascii?Q?mceLel+ks1NiGzpWA2Gy639n5mtjlSprBceyUE/YbhuXKZaA0fxFgJyejx5N?=
 =?us-ascii?Q?sV4pLKQmXdcDVdMaGZo0iJpDJhvmuX29GhzM7LvE8IcebpqEucGutjXHAkFR?=
 =?us-ascii?Q?CyjpAqm8chm99VT3wWXO3UxXNUWRqYWjBEUr+ChbZRtTF+tJA0DbllcBIA3m?=
 =?us-ascii?Q?kdLYjHB7zNahrArtFVGuOZTMEIgySt5ZIkIOMqhORUA0gSZMSJjwpoEd5HQu?=
 =?us-ascii?Q?90BCR2blOgBRZ5N636Nk/p79bjDg9EwWg9/VpdCXf+MPcYbclXmb5U9ZAT1z?=
 =?us-ascii?Q?I9v8RVnMKkEhhgBj9oo/xGundA8rP6aX9PkM4OPAp/ISV+mK8ih/uej5Any3?=
 =?us-ascii?Q?JgNaCGs96iLss8G18ilyJVCJbl5vrhNtGSu0kVd6ig0sVu2iZfZOviRpr4vF?=
 =?us-ascii?Q?rEfM0Ie77SMw+JkeCDl5lg+qqlWTyBRce4gQ8dgPY908AT3/NiyJ431GtJ1j?=
 =?us-ascii?Q?cUFIZkvBDqUWRuvQNlPy2kdp+2tJ4BBrRIBoIEslSZTWXQvsUcxZe9GZUI0d?=
 =?us-ascii?Q?3wRCawk0CmXnrbpRjMydVIbgkL/rBEJqhTZCMrDM0iGio7tnKNyd8HGng9nI?=
 =?us-ascii?Q?W8qShoTrR9tMRgPxGo1GY0Zt9tmLbbWJYejByp5bVj2MLJKO5ZWEhH+DLVNa?=
 =?us-ascii?Q?HeQWg6LkdcHNCwRVikk2+d03tidOw1xTb+7JGcNG0hmR687ZtXV/bfDunihW?=
 =?us-ascii?Q?ZgJo3AnrxLS2xmqiYd9d0SmzXJNEeCQG2wwhb1JlkzOYpfmJfHeJ868GHuqz?=
 =?us-ascii?Q?Vorr2tP5dUKP4FysFZiFeHTOHHqLmVtYUJA/KY3hi3NnE/Q0lE7i/TDfq3Ny?=
 =?us-ascii?Q?V1T+gqpZAdeP3Ex7a4h/S8QfQPZ5J0YGUjpBol/HziddIZANweBaT7s0cWTv?=
 =?us-ascii?Q?JJDeKmVvOp9yP/80AeDaGPPg68v8dW5XwHnyFhQQixEYeLCK3pnOmOcxZ10m?=
 =?us-ascii?Q?71nlGffiCiQQ5JbVBi1EbSOLOo+sIVKm0eiQssz4NfTh26cn09Th+1m+vCle?=
 =?us-ascii?Q?BiA0DPd5bcTX1WCPdalNESnn5gzH6fSlATTz097zVVqzpjZY1svY0E4hl087?=
 =?us-ascii?Q?dHb9u2PZ09nF8ZAeV9TLJ1NLjl5EylMBV0J4SUgv433bbAnTcZiFf460Maif?=
 =?us-ascii?Q?1+g1xaEyIjXcLZPXA6XNNdKP6aak+HVGkVCaE7N+lSyi1f5tKeIn1l5a/4p7?=
 =?us-ascii?Q?jbO1HXNHXrPfDfWCB1PMW/X2Ni54lGDZeUiYCvUHtq/RZi4L4gZpmDRPDn5M?=
 =?us-ascii?Q?F7XM0LieTe3yWAGVB0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ac544a-0f36-4fc9-ae0f-08de3d4748cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 08:35:50.6414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGBWxiJc6UivyMup46143FfTFizmNX/De0dbQeMXGcu2Qr4sw07zsdfdredXJjEBEnrqY10JGRtQopJpmOMJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

[AMD Official Use Only - AMD Internal Distribution Only]

ping

-----Original Message-----
From: Chengjun Yao <Chengjun.Yao@amd.com>
Sent: Monday, December 15, 2025 4:18 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; tzimmermann@suse.de; amd-gfx@lists.freedesktop.org
Cc: Yao, Chengjun <Chengjun.Yao@amd.com>; Pillai, Aurabindo <Aurabindo.Pill=
ai@amd.com>
Subject: [PATCH] drm/fb-helper: Fix vblank timeout during suspend/reset

During GPU reset, VBlank interrupts are disabled which causes
drm_fb_helper_fb_dirty() to wait for VBlank timeout. This will create call =
traces like (seen on an RX7900 series dGPU):

[  101.313646] ------------[ cut here ]------------ [  101.313648] amdgpu 0=
000:03:00.0: [drm] vblank wait timed out on crtc 0 [  101.313657] WARNING: =
CPU: 0 PID: 461 at drivers/gpu/drm/drm_vblank.c:1320 drm_wait_one_vblank+0x=
176/0x220 [  101.313663] Modules linked in: amdgpu amdxcp drm_panel_backlig=
ht_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_help=
er drm_display_helper cec rc_core i2c_algo_bit nf_conntrack_netlink xt_nat =
xt_tcpudp veth xt_conntrack xt_MASQUERADE bridge stp llc xfrm_user xfrm_alg=
o xt_set ip_set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_=
ipv4 xt_addrtype nft_compat x_tables nf_tables overlay qrtr sunrpc snd_hda_=
codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_=
atihdmi snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core snd_int=
el_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm amd_atl intel_rapl_msr snd_s=
eq_midi intel_rapl_common asus_ec_sensors snd_seq_midi_event snd_rawmidi sn=
d_seq eeepc_wmi snd_seq_device edac_mce_amd asus_wmi polyval_clmulni ghash_=
clmulni_intel snd_timer platform_profile aesni_intel wmi_bmof sparse_keymap=
 joydev snd rapl input_leds i2c_piix4 soundcore ccp k10temp i2c_smbus gpio_=
amdpt mac_hid binfmt_misc sch_fq_codel msr parport_pc ppdev lp parport [  1=
01.313745]  efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid r=
8169 realtek ahci libahci video wmi [  101.313760] CPU: 0 UID: 0 PID: 461 C=
omm: kworker/0:2 Not tainted 6.18.0-rc6-174403b3b920 #1 PREEMPT(voluntary) =
[  101.313763] Hardware name: ASUS System Product Name/TUF GAMING X670E-PLU=
S, BIOS 0821 11/15/2022 [  101.313765] Workqueue: events drm_fb_helper_dama=
ge_work [  101.313769] RIP: 0010:drm_wait_one_vblank+0x176/0x220
[  101.313772] Code: 7c 24 08 4c 8b 77 50 4d 85 f6 0f 84 a1 00 00 00 e8 2f =
11 03 00 44 89 e9 4c 89 f2 48 c7 c7 d0 ad 0d a8 48 89 c6 e8 2a e0 4a ff <0f=
> 0b e9 f2 fe ff ff 48 85 ff 74 04 4c 8b 67 08 4d 8b 6c 24 50 4d [  101.313=
774] RSP: 0018:ffffc99c00d47d68 EFLAGS: 00010246 [  101.313777] RAX: 000000=
0000000000 RBX: 000000000200038a RCX: 0000000000000000 [  101.313778] RDX: =
0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000 [  101.313779]=
 RBP: ffffc99c00d47dc0 R08: 0000000000000000 R09: 0000000000000000 [  101.3=
13781] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8948c4280010 [ =
 101.313782] R13: 0000000000000000 R14: ffff894883263a50 R15: ffff89488c384=
830 [  101.313784] FS:  0000000000000000(0000) GS:ffff895424692000(0000) kn=
lGS:0000000000000000 [  101.313785] CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033 [  101.313787] CR2: 00007773650ee200 CR3: 0000000588e40000 CR4: =
0000000000f50ef0 [  101.313788] PKRU: 55555554 [  101.313790] Call Trace:
[  101.313791]  <TASK>
[  101.313795]  ? __pfx_autoremove_wake_function+0x10/0x10
[  101.313800]  drm_crtc_wait_one_vblank+0x17/0x30
[  101.313802]  drm_client_modeset_wait_for_vblank+0x61/0x80
[  101.313805]  drm_fb_helper_damage_work+0x46/0x1a0
[  101.313808]  process_one_work+0x1a1/0x3f0 [  101.313812]  worker_thread+=
0x2ba/0x3d0 [  101.313816]  kthread+0x107/0x220 [  101.313818]  ? __pfx_wor=
ker_thread+0x10/0x10 [  101.313821]  ? __pfx_kthread+0x10/0x10 [  101.31382=
3]  ret_from_fork+0x202/0x230 [  101.313826]  ? __pfx_kthread+0x10/0x10 [  =
101.313828]  ret_from_fork_asm+0x1a/0x30 [  101.313834]  </TASK> [  101.313=
835] ---[ end trace 0000000000000000 ]---

Cancel pending damage work synchronously before console_lock() to ensure an=
y in-flight framebuffer damage operations complete before suspension.

Also check for FBINFO_STATE_RUNNING in drm_fb_helper_damage_work() to avoid=
 executing damage work if it is rescheduled while the device is suspended.

Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c index c0343ec16a57..199cca1b5bdd 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -402,6 +402,9 @@ static void drm_fb_helper_damage_work(struct work_struc=
t *work)  {
        struct drm_fb_helper *helper =3D container_of(work, struct drm_fb_h=
elper, damage_work);

+       if (helper->info->state !=3D FBINFO_STATE_RUNNING)
+               return;
+
        drm_fb_helper_fb_dirty(helper);
 }

@@ -794,6 +797,13 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_=
helper *fb_helper,
                if (fb_helper->info->state !=3D FBINFO_STATE_RUNNING)
                        return;

+               /*
+                * Cancel pending damage work. During GPU reset, VBlank
+                * interrupts are disabled and drm_fb_helper_fb_dirty()
+                * would wait for VBlank timeout otherwise.
+                */
+               cancel_work_sync(&fb_helper->damage_work);
+
                console_lock();

        } else {
--
2.43.0

