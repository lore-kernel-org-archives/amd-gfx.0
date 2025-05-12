Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DCAC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 04:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BE110E059;
	Mon, 12 May 2025 04:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RMC1JjpW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC87C10E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 04:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkYTSROtSSDRhEYdgTiJK2USmOSf3Kahnmj8zA2Q6anP+7djq6X3zkEFDfb9Yxe1FTgWKC/OE2ok4t1NR1YcUEL+UZNDjvhNgutnzH+/WxMwa+zU0BEbcbL7h9Ob57xO+21Ac2W9D7TgW5C+pyuSmGDrUs77ud8IUpp8wGfhvoyhavc2a4hVPdPLWfl3sVnqUja+1gZnVxcyyA6+9BoUJGUTSu6A4I5jEGpkI2TeBpKNaQTS20PxV92C9slO5qV1x9PK/CQvU6Tz8fN3KuSO2qOm30HIma8B2b8XPMSLI0dKgx4iYkudXpR9Zqc8JZnqg/aHPSbG/z7NdqHTJW+CJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME9zZqZkIwYlLlpoC1LOg5YDPhbKXEVr1ySMuuuz0s8=;
 b=AHMI08GBsVgnEQ+sVZ0e3A30FT4O7IaXWATxvDQONjVFqdbPuW+2beWU0Iu4DjmTIXoj4gbGrveQfYm4LlizTO7m3Ju3m2HrkBF8sESTwzKoe2p8XbrRXDO6a74YRfpISWPPOlP6USBpZez0ZTYPHIPIz0sdcbi50mTkVrAhHi9el3uveXc40yHjqwfsVyedw5HurNecR2L8ahS1sYSgBbAI2SSEZLyh5svHABKD0nx2cDIIz+Du38m4EDoXxQH0BeWC1JDrvE9hhQT14GuZtloOdHz8FjYQwx16PQBQTIW5+VBa7km5zUQ6qY4I/nLJt4Gpp1cPB0vEnv3RX/qUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME9zZqZkIwYlLlpoC1LOg5YDPhbKXEVr1ySMuuuz0s8=;
 b=RMC1JjpW7WwB8Hya2tJc0DqhIWJ6LL2GHuQqBb6NIz3qtmq2xaR2Sm7vBeFjsFI3sJ7t8YAJ4GYdGnW75UHDbwswlbrwPn2eafhSGIri2G2852YuEltM6NIkWk1lzc5BMPGDetpfVaxydN36RbbjKbINUyM4R7Ay6dENkTigR6c=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 12 May
 2025 04:49:44 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 04:49:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwvbJR+FukZgeCEWgXfVyk9KjHbPObHtw
Date: Mon, 12 May 2025 04:49:44 +0000
Message-ID: <PH7PR12MB879652F177669F5FF94756C4B097A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250512043136.4969-1-cesun102@amd.com>
In-Reply-To: <20250512043136.4969-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=705343a9-b2c7-4ff2-ba27-f7746c042ba7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-12T04:49:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB7119:EE_
x-ms-office365-filtering-correlation-id: 76712e49-0c18-433a-e1bd-08dd91106a28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OXJgoAzOlJnNxOsVyMLWZRoHr2JB5Io/ztbcnUXn/kTtzjjUPdQrbUzRp0RF?=
 =?us-ascii?Q?SurGHlDcw5urNnM0vJP08OCFwOB/2Fb6TE3deF5/meXeRYLQInjmt2DuaGuK?=
 =?us-ascii?Q?qrWbMzqV5wO5eY4FbVRPj8QwJmJNf4Cjk3ghzBZpwlQQcBUhsM0/pww/MzTp?=
 =?us-ascii?Q?GyTiyuJpdh8UdqIlKcPvXjAdU8x6/NQZriKsecR7u2mCz9L0KOc41kovpBbU?=
 =?us-ascii?Q?dzm2/RPJXV1R24Q4kRBgBw1sxX8nmj7jJX8lBzZ/nUsVv+NxJXkA0mWfpDgj?=
 =?us-ascii?Q?ypgVF7cReo2GiFDvdpKNUsop/324GCi+Pf3IsL7bUMvI71/XThVCM44PCCuf?=
 =?us-ascii?Q?s65FWCCOYlzAmUaj4k/5uUTaKfxSbTy/VCkDnSWnpQJyeo9NTrviAFPt5xxr?=
 =?us-ascii?Q?xmsr1SwbEiVO2YjBTSInbb3Czs4/K+BF2WxLvq3rA2/bUuN96N5WBCaDtJO1?=
 =?us-ascii?Q?k2MSjBVQs2yWpRIzw0SHSHup7EGZuEb65lNxMDzFT/23UcA4SHuu3MKo0Hap?=
 =?us-ascii?Q?ugEeCnwutBSpasdP4CFVAsLiCO96bQaFkRpTTDmSPYP7i+6F/cBu79L5CoEY?=
 =?us-ascii?Q?ojO40OiMoQogOp/Q4WaIStzB9OLHM+AF7HlE56B2ciXSxayxZQsSh31DrB6k?=
 =?us-ascii?Q?1Dpt+7rZ2bJtSU8XEK4M0rfD829yyupmHa7OE7VMa7LIsQNUdqqXx0SyWiJG?=
 =?us-ascii?Q?Icwtozf9nNse4EMgHpSGcJ/caqM+5oniMKr7mQVcBpRnI6DB9f+SMe+jm2XE?=
 =?us-ascii?Q?OhT0eLvIptT4Kf92ux5uhpZDCNTAh46wAlqH3uFTuRoqgpA0RRaUXIgBasI7?=
 =?us-ascii?Q?LN6Jh3yjSmClVuLWlkOqEmebKIXKqJfBSk3jrUtsr6FL3nOwmSb7+KrMs8U2?=
 =?us-ascii?Q?oYfL4YPcnf42zc4jCr6hKz0x9BPYqDKq0BLMjwlBYnc57ie6chDc3Ujfmnbj?=
 =?us-ascii?Q?HGPAZSYvaxRuWGl4N1TmZd4lQDRiwZ12ovaadzykfbs0qM7Luo/AlgteqxG8?=
 =?us-ascii?Q?4vDf59sYCqheKZQT3LkGxMFBvt+ztIxKvASBZ5LTn6Ga0X7U3SuGgZnrDZkx?=
 =?us-ascii?Q?0ZwNPgvMrOO7Vj2XT1Qnd/pCyXEZmY/UvMDS48obN/SiEkMOnMYQRk0PFJYJ?=
 =?us-ascii?Q?RzSa0DLf0hTqt4L0ene3ZsPutl2LR25qCR9IExJdz2DJQukwKyKgFX/PyjzB?=
 =?us-ascii?Q?Xq35gSt7R1gRCzSV6ar8c7sFaULP+8GwPfqhZ83+LbDIu/rd441y5q9QCSea?=
 =?us-ascii?Q?9M4HRcxHxQAbjCE81y95ccRRCcI8YP5G5ZVtiywxaSJp+u+ofDPx6FJnC46i?=
 =?us-ascii?Q?LYJ+B+GB9Dd8O8mOV8JYo3T6qfgnk+3VitZzr+QvA8bV9L9mlIpsQ2NhGBie?=
 =?us-ascii?Q?xAldCcqEMvFxGRH75SfqhGG1Lg4WVWG2dWw9LYO816OfRKF2ZWHl7d1i8FDF?=
 =?us-ascii?Q?5FCZVNt5cve7Mf99e4ckMoKQrgNTBcaWY2jZy5837ntrjzPqK8m4eds9v4Mv?=
 =?us-ascii?Q?Xc8/kgjz1e5i2kE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nQ1iW53HshM1z4w7HdhsnRpwdxkdSF1Tm3S4M4GChGzChYM2YCm6Bit9nNpI?=
 =?us-ascii?Q?SEZatniw0WTsUG1fjXz6UPUgDKu1FniKqak2joVHgmpaOaJZKp144vnY123z?=
 =?us-ascii?Q?mvNfex8XYS5dbmqbQ3CGoEx4kAYKYkqqtfaGUs5cjERbBAd4trTFEmqsntAs?=
 =?us-ascii?Q?Ywrgj7IXGwtXZRgQweMXjFzd4Vmb/lXEmPlEY7Bmq39cewfF9KAcOcwEIanF?=
 =?us-ascii?Q?mHBg016SZkfh1QrGWBud2JvTXKPWcoKIjEjHsK4XF38+fnrC7nrRt6ME4G5h?=
 =?us-ascii?Q?DDIe6fZiQhJlGqNNjl4QHvXo1u1o7zwKHhbLKasjt9regdVbsmwqs4QKIRcy?=
 =?us-ascii?Q?Gd4+YYdXf2Q9M+jBYkWSS3i03RyfdCbeX8oPe4CCjIpKzUZzfb8l4yDlIDcS?=
 =?us-ascii?Q?Gw7uXKBr7EELC7CX0sDi3uw4oNRvf8963Tmfy0no5f2d62mKvn8ipKN5qPa7?=
 =?us-ascii?Q?fc62ihgSPlbn1ndydEwFmZMkDZQQa768TlzHEbjHb6q2NW77otttSwCZRuDc?=
 =?us-ascii?Q?wHjurhUcXfzKen+LDoTKyJy/NEracuXGbrQWvsUQm0f3fLi8Xp1ZhRWLRY+5?=
 =?us-ascii?Q?qJpw1vEG9/JBeBcycef5BtTCyp7IOn730e1hkAZ9wqgz3JM1YddiZNFlUiyj?=
 =?us-ascii?Q?XgoNQIICVgh6oPnpiQ42O2zug9z5DcQz+5N1ZkF5qO+YVJSJ6UHHpSWs4F3j?=
 =?us-ascii?Q?fQN2kG2gPjn5Q699AwrUFl/qu10O6jmc8a1rG4RSDSKgO/QFyp2f/n5Lwe9x?=
 =?us-ascii?Q?IVm2r8ImU8dUNcJckCrLJCQOXW99SwtIHwz169+MZFnIeNJmfi6MUXWMM5fa?=
 =?us-ascii?Q?M9u4u7MOnyyWv0nB0dOwuv5i/QaFD0RQ20fE7UorgQvo6OCir0QeG1asNrBK?=
 =?us-ascii?Q?IL618OHbUzGS3Zlfko6gDxai0V2UXOm4oC6SGYKnJCFhPKA57vEK+p/Fx1Kh?=
 =?us-ascii?Q?itdsJCDeXFudfotQeCCFzea31FQ8TaF9qDFKpxV5tePv4PBXabKKccbyKtqN?=
 =?us-ascii?Q?CM2BGI91+tBzWP9e9xJY6Yvsdgw0rALhLyeM3/MHNFxBHN2B8SBXq9j3hXdL?=
 =?us-ascii?Q?fY6MQ96NqcgbaEUfc1cd3MNd0KuV04R4bMr9xUORBBN2niOQtCtPvWNMeZx5?=
 =?us-ascii?Q?yuCOzEY/oBv303ie8V/NFw5CcfaQQ2F+OUwSgh1TkCI3TL8gp0m+Ke7MZEp6?=
 =?us-ascii?Q?BxQEQtwNV2glnIb116GGVQBoF17lS0vzYAmDWHglcY62RYt4Uoeq6YjJZ5em?=
 =?us-ascii?Q?kjRevx0cUqvfstz9nvAkm+dzOo/kT6Xgrfv1vIXW1Gh+2PlfNkAh2Uha96y0?=
 =?us-ascii?Q?FPNU6GETDnH8c/8KURfVfdgNYkOgZm9sxJP50PxEDvOu6NBqICCGvty+JI/v?=
 =?us-ascii?Q?XshUQt3rtkVcoFBiuaiY/hHfxk4zW1jIdXbooAhY5l4EHoeZZ17S21bePnXM?=
 =?us-ascii?Q?olAg6dLLCCJSji1EiFMdC/naHehYPrx6IQ7/Wzj+ybXsgb59rdrAU1l+nvBJ?=
 =?us-ascii?Q?LuzXviIXtERWcwMULACjPStjZP7msW8RqzwYcyYJ2xxiye7Uu9OpZ2EUSrxU?=
 =?us-ascii?Q?8lztX3edVm3C4b8FPM4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76712e49-0c18-433a-e1bd-08dd91106a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 04:49:44.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeJPXTizmSAsaoeM1iBAoAjn3nAeJ5c2NQE5C4NAl8uHlgOMadIaZFKoZ9Z8PFjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Monday, May 12, 2025 12:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records e=
xceed
> threshold
>
> kernel panic caused by RAS records exceeding the threshold when load driv=
er
> specifying RMA(bad_page_threshold=3D128) 1.Fix the warnings caused by dis=
abling
> the interrupt source before it was enabled 2.xcp sysfs is not initialized=
,null pointer
> appears during fini 3.Fix the memory leak caused by the device's early ex=
it due to
> rma
>
> The first reason:
> [ 2744.246650] ------------[ cut here ]------------ [ 2744.246651] WARNIN=
G: CPU: 0 PID:
> 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635
> amdgpu_irq_put.cold+0x42/0x6e [amdgpu] [ 2744.247108] Modules linked in:
> amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)
> amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype
> nft_compat nf_tables nfnetlink br_netfilter bridge stp llc overlay binfmt=
_misc
> intel_rapl_msr intel_rapl_common i10nm_edac nfit x86_pkg_temp_thermal
> intel_powerclamp coretemp ipmi_ssif kvm_intel nls_iso8859_1 kvm rapl
> isst_if_mbox_pci isst_if_mmio pmt_telemetry pmt_crashlog isst_if_common
> pmt_class mei_me mei acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler
> acpi_power_meter acpi_pad mac_hid sch_fq_codel dm_multipath scsi_dh_rdac
> scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore_blk pstore_zone
> efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress=
 raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]  linear mlx5_ib i=
b_uverbs
> ib_core ast i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helpe=
r
> crct10dif_pclmul syscopyarea crc32_pclmul ghash_clmulni_intel mlx5_core s=
ysfillrect
> sysimgblt aesni_intel mlxfw fb_sys_fops psample cec crypto_simd cryptd rc=
_core
> i2c_i801 nvme xhci_pci tls intel_pmt drm pci_hyperv_intf nvme_core i2c_sm=
bus
> i2c_ismt xhci_pci_renesas wmi pinctrl_emmitsburg
> [ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G           OE =
    5.15.0-
> 70-generic #77-Ubuntu
> [ 2744.247197] Hardware name: Microsoft C278A/C278A, BIOS
> C2789.5.BS.1C23.AG.2 11/21/2024 [ 2744.247198] Workqueue: events
> work_for_cpu_fn [ 2744.247206] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e
> [amdgpu] [ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2 89 5=
5 d4 e8
> 90 09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0 75 0=
7 <0f> 0b e9
> 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4c 89 [ 2744.247636] R=
SP:
> 0018:ffa0000019e27cb0 EFLAGS: 00010246 [ 2744.247639] RAX:
> 0000000000000000 RBX: 0000000000000000 RCX: ff11000150fa87c0
> [ 2744.247641] RDX: 0000000000000000 RSI: ffffffffc2222430 RDI:
> ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0 R08: 00000000000000=
03
> R09: ffffffffffe41a08 [ 2744.247643] R10: 0000000000ffff0a R11: 000000000=
0000001
> R12: ff1100019f22ce60 [ 2744.247644] R13: 0000000000000000 R14:
> 00000000ffffffea R15: ff1100019f200000 [ 2744.247645] FS:
> 0000000000000000(0000) GS:ff11007e7e400000(0000) knlGS:0000000000000000
> [ 2744.247647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2744.247649] CR2: 00007f3d2002819c CR3: 0000000006810003 CR4:
> 0000000000771ef0 [ 2744.247650] DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000 [ 2744.247651] DR3:
> 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 2744.247652] PKRU: 55555554 [ 2744.247653] Call Trace:
> [ 2744.247654]  <TASK>
> [ 2744.247656]  sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]  ?
> vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]
> amdgpu_ip_block_hw_fini+0x31/0x61 [amdgpu] [ 2744.248776]
> amdgpu_device_fini_hw+0x3bb/0x47b [amdgpu] [ 2744.249197]  ?
> blocking_notifier_chain_unregister+0x56/0xb0
> [ 2744.249202]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [ 2744.249482=
]
> amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [ 2744.249913]
> amdgpu_pci_probe+0x23e/0x590 [amdgpu] [ 2744.250187]
> local_pci_probe+0x48/0x90 [ 2744.250191]  work_for_cpu_fn+0x17/0x30
> [ 2744.250196]  process_one_work+0x228/0x3d0 [ 2744.250198]
> worker_thread+0x223/0x420 [ 2744.250200]  ? process_one_work+0x3d0/0x3d0
> [ 2744.250201]  kthread+0x127/0x150 [ 2744.250204]  ?
> set_kthread_struct+0x50/0x50 [ 2744.250207]  ret_from_fork+0x1f/0x30
> [ 2744.250212]  </TASK> [ 2744.250213] ---[ end trace 488c997a88508bc3 ]-=
--
>
> The second reason:
> [ 5139.303446] Memory manager not clean during takedown.
> [ 5139.303509] WARNING: CPU: 145 PID: 117699 at drivers/gpu/drm/drm_mm.c:=
998
> drm_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Modules linked in:
> amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)
> amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) xt_conntrack
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype
> nft_compat nf_tables nfnetlink br_netfilter bridge stp llc overlay intel_=
rapl_msr
> intel_rapl_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp
> coretemp ipmi_ssif kvm_intel binfmt_misc kvm nls_iso8859_1 rapl isst_if_m=
box_pci
> pmt_telemetry pmt_crashlog isst_if_mmio pmt_class isst_if_common mei_me m=
ei
> acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter
> mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua m=
sr
> ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables=
 autofs4
> btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 rai=
d0
> multipath [ 5139.303572]  linear mlx5_ib ib_uverbs ib_core crct10dif_pclm=
ul ast
> crc32_pclmul i2c_algo_bit ghash_clmulni_intel aesni_intel crypto_simd
> drm_vram_helper cryptd drm_ttm_helper mlx5_core ttm drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core mlxfw psample i=
ntel_pmt
> nvme xhci_pci drm tls i2c_i801 pci_hyperv_intf nvme_core i2c_smbus i2c_is=
mt
> xhci_pci_renesas wmi pinctrl_emmitsburg [last unloaded: amdkcl]
> [ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G     U     O=
E
> 5.15.0-70-generic #77-Ubuntu
> [ 5139.303590] Hardware name: Microsoft C278A/C278A, BIOS
> C2789.5.BS.1C23.AG.2 11/21/2024 [ 5139.303591] RIP:
> 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5139.303605] Code: cc 66 90 0f 1f =
44
> 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 75 05 c3 cc cc cc cc 55 48 c7 c7 1=
8 d0 10 c0
> 48 89 e5 e8 5a bc c3 c1 <0f> 0b 5d c3 cc cc cc cc 90 0f 1f 44 00 00 55 b9=
 15 00 00
> 00 48 89 [ 5139.303607] RSP: 0018:ffa00000325c3940 EFLAGS: 00010286
> [ 5139.303608] RAX: 0000000000000000 RBX: ff1100012f5cecb0 RCX:
> 0000000000000027 [ 5139.303609] RDX: ff11007e7fa60588 RSI:
> 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RBP: ffa00000325c39=
40
> R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.303610] R10:
> 000000000000002b R11: 0000000000000001 R12: ff1100012f5cec00
> [ 5139.303611] R13: ff1100012138f068 R14: 0000000000000000 R15:
> ff1100012f5cec90 [ 5139.303611] FS:  00007f42ffca0000(0000)
> GS:ff11007e7fa40000(0000) knlGS:0000000000000000 [ 5139.303612] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5139.303613] CR2:
> 00007f23d945ab68 CR3: 00000001212ce005 CR4: 0000000000771ee0
> [ 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 [ 5139.303615] DR3: 0000000000000000 DR6:
> 00000000fffe07f0 DR7: 0000000000000400 [ 5139.303615] PKRU: 55555554
> [ 5139.303616] Call Trace:
> [ 5139.303617]  <TASK>
> [ 5139.303619]  amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm]
> [ 5139.303625]  amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]
> amdgpu_bo_fini+0x27/0xc0 [amdgpu] [ 5139.303959]  gmc_v9_0_sw_fini+0x63/0=
x90
> [amdgpu] [ 5139.304144]  amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu]
> [ 5139.304302]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.30445=
5]
> devm_drm_dev_init_release+0x4a/0x80 [drm] [ 5139.304472]
> devm_action_release+0x12/0x20 [ 5139.304476]  release_nodes+0x3d/0xb0
> [ 5139.304478]  devres_release_all+0x9b/0xd0 [ 5139.304480]
> really_probe+0x11d/0x420 [ 5139.304483]  __driver_probe_device+0x119/0x19=
0
> [ 5139.304485]  driver_probe_device+0x23/0xc0 [ 5139.304487]
> __driver_attach+0xf7/0x1f0 [ 5139.304489]  ? __device_attach_driver+0x140=
/0x140
> [ 5139.304491]  bus_for_each_dev+0x7c/0xd0 [ 5139.304493]
> driver_attach+0x1e/0x30 [ 5139.304494]  bus_add_driver+0x148/0x220
> [ 5139.304496]  driver_register+0x95/0x100 [ 5139.304498]
> __pci_register_driver+0x68/0x70 [ 5139.304500]  amdgpu_init+0xbc/0x1000
> [amdgpu] [ 5139.304655]  ? 0xffffffffc0b8f000 [ 5139.304657]
> do_one_initcall+0x46/0x1e0 [ 5139.304659]  ?
> kmem_cache_alloc_trace+0x19e/0x2e0
> [ 5139.304663]  do_init_module+0x52/0x260 [ 5139.304665]
> load_module+0xb2b/0xbc0 [ 5139.304667]  __do_sys_finit_module+0xbf/0x120
> [ 5139.304669]  __x64_sys_finit_module+0x18/0x20 [ 5139.304670]
> do_syscall_64+0x59/0xc0 [ 5139.304673]  ? exit_to_user_mode_prepare+0x37/=
0xb0
> [ 5139.304676]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 5139.304678]  ? __x64_sys_mmap+0x33/0x50 [ 5139.304680]  ?
> do_syscall_64+0x69/0xc0 [ 5139.304681]
> entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 5139.304684] RIP: 0033:0x7f42ffdbf88d
> [ 5139.304686] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 4=
8 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73
> 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48 [ 5139.304687] RSP:
> 002b:00007ffcb7427158 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [ 5139.304688] RAX: ffffffffffffffda RBX: 000055ce8b8f3150 RCX: 00007f42f=
fdbf88d
> [ 5139.304689] RDX: 0000000000000000 RSI: 000055ce8b8f9a70 RDI:
> 000000000000000a [ 5139.304690] RBP: 0000000000040000 R08:
> 0000000000000000 R09: 0000000000000011 [ 5139.304690] R10:
> 000000000000000a R11: 0000000000000246 R12: 000055ce8b8f9a70
> [ 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce8b8f2ab0 R15:
> 000055ce8b8f9aa0 [ 5139.304692]  </TASK> [ 5139.304693] ---[ end trace
> 8536b052f7883003 ]---
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   | 16 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c        |  7 +++++--
>  7 files changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d4f3fb3519c8..5e9980a48085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -595,6 +595,7 @@ static bool
> amdgpu_fence_need_ring_interrupt_restore(struct amdgpu_ring *ring)
>   */
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)  {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       int i, r;
>
>       for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) { @@ -614,7 +615,8 @@ void
> amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>
>               if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
>                   ring->fence_drv.irq_src &&
> -                 amdgpu_fence_need_ring_interrupt_restore(ring))
> +                 amdgpu_fence_need_ring_interrupt_restore(ring) &&
> +                 !ras->is_rma)
>                       amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>                                      ring->fence_drv.irq_type);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index cb7991362b5d..6f24e95c9112 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>       amdgpu_vram_mgr_fini(adev);
>       amdgpu_gtt_mgr_fini(adev);
>       amdgpu_preempt_mgr_fini(adev);
> +     amdgpu_doorbell_fini(adev);
> +
>       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
>       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
>       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index cd6e4c0b94da..e970a1427fe0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device
> *adev)
>       struct amdgpu_xcp_cfg *xcp_cfg;
>       int i;
>
> -     if (!adev->xcp_mgr)
> +     if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
>               return;
>
> -     xcp_cfg =3D  adev->xcp_mgr->xcp_cfg;
> +     xcp_cfg =3D adev->xcp_mgr->xcp_cfg;
>       for (i =3D 0; i < xcp_cfg->num_res; i++) {
>               xcp_res =3D &xcp_cfg->xcp_res[i];
>               kobject_put(&xcp_res->kobj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index dcc6752c3ece..4ae19a9cf843 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2377,12 +2377,20 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_bl=
ock
> *ip_block)  static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_bloc=
k)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       int i, num_xcc;
>
> -     amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -     amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
> -     amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> -     amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +     if (!ras->is_rma)
> +             amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +
> +     if (!ras->is_rma)
> +             amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
> +
> +     if (!ras->is_rma)
> +             amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +
> +     if (!ras->is_rma)
> +             amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>
>       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>       for (i =3D 0; i < num_xcc; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..95dc408faa02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2491,6 +2491,7 @@ static void gmc_v9_0_gart_disable(struct amdgpu_dev=
ice
> *adev)  static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       gmc_v9_0_gart_disable(adev);
>
> @@ -2513,10 +2514,12 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_bloc=
k
> *ip_block)
>        * are not enabled.
>        */
>       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> -             amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +             if (!ras->is_rma)

[Tao] I mean move the check into amdgpu_irq_put.

> +                     amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>
>               if (adev->gmc.ecc_irq.funcs &&
> -                 amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
> +                 amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC)
> &&
> +                 !ras->is_rma)
>                       amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 11f9c07f1e8d..788f035424f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1606,6 +1606,7 @@ static int sdma_v4_4_2_hw_init(struct amdgpu_ip_blo=
ck
> *ip_block)  static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>       uint32_t inst_mask;
>       int i;
>
> @@ -1615,8 +1616,9 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_blo=
ck
> *ip_block)
>       inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
>       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
>               for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -                     amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> -                                    AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +                     if (!ras->is_rma)
> +                             amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> +                                            AMDGPU_SDMA_IRQ_INSTANCE0 + =
i);
>               }
>       }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index c457be3a3c56..23722367bda8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1317,6 +1317,7 @@ static int soc15_common_hw_init(struct
> amdgpu_ip_block *ip_block)  static int soc15_common_hw_fini(struct
> amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       /* Disable the doorbell aperture and selfring doorbell aperture
>        * separately in hw_fini because soc15_enable_doorbell_aperture @@ =
-
> 1338,10 +1339,12 @@ static int soc15_common_hw_fini(struct amdgpu_ip_bloc=
k
> *ip_block)
>           adev->nbio.ras_if &&
>           amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
>               if (adev->nbio.ras &&
> -                 adev->nbio.ras->init_ras_controller_interrupt)
> +                 adev->nbio.ras->init_ras_controller_interrupt &&
> +                 !ras->is_rma)
>                       amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq=
, 0);
>               if (adev->nbio.ras &&
> -                 adev->nbio.ras->init_ras_err_event_athub_interrupt)
> +                 adev->nbio.ras->init_ras_err_event_athub_interrupt &&
> +                 !ras->is_rma)
>                       amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athu=
b_irq,
> 0);
>       }
>
> --
> 2.34.1

