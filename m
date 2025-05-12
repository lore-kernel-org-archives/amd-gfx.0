Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CEC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 05:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4418B10E0AC;
	Mon, 12 May 2025 05:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="se04e+Mp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E6F10E0AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 05:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZYTfr72KnO77iKpV1RrJ2mOxTcQwsy7SF4d+phq2tK/BJd5Fn5v6s7Whfg2doFBM4yiGq9CR5h/g4AeTKz0moib779LkWMrhM8ynUj4K/cDp/8CpC6j1DwDWVSXu1p3Ez1g70TTIDoYcayPuHDoaUJMGe1O8+ukWW8h+V8yn8PE+aYN7NkPyLu7WaAQqGEoEIn7+nz0wL/V5NUaC4WwA/k61vDoar6pftBm0NvmPudjXqZIP6C89/K+JBUcCgx1qh9dmExiBdJxAzwbSCCn457Fk0b2YCY7QRTB6mb/v/U2TfDtdMgzbURxL/y3+6Qw59l5800qb49OlNGBb88tVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUAEMgUUfKlaC19dn5oDaCexz1vNKjUZwIaRHOyu/Ik=;
 b=xXJemBuYmMSiYQSqdsihbuH9UOuawccQz2eHeYvdUlEUgBzFIBSHESDCJyuT9CEiPHRWdBu9l4tf3T9jhxOGUhHBbvvEuLfk2cwCy4LP9oL7DTJytTzR74hphcNogwIrBcUV6mN3ydhvsPtsAWAU/KzWTYqreihhArOq8AxQIPvhbDW/ky86x22QhL6mF3TRjj7yFScuOaNYOrlsGiIyN7kcqFQRprliTTMCQNgbNB/CCTrc2SOPEDMJN/QN5mxa66qVB1OBBiuJMt1U7wlH5mUdFr/9J3GugE2C2+3L3zTZTrNiqQW2UHq3vF5LIwUzRwrRMY1vDcfhUyJAjZXliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUAEMgUUfKlaC19dn5oDaCexz1vNKjUZwIaRHOyu/Ik=;
 b=se04e+MpVObEfCwQkliRSOa6ZLISyj0tUHxzhkOozDPzeoBzdI4og6KA1HZuNjvWjYYghEtqHyRZHWd+B4FmkibGqigLSdGJIzv3bAe6O7Y9gvwN1xMZVCpNrDdaOSNZdAzLv4Z9cVdoep4eh6/ct8AgMub2csP0793+d/aNWQ0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 05:51:29 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 05:51:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwvyuEbjHPksBs0CSLGoJBd59PbPOdBSQ
Date: Mon, 12 May 2025 05:51:29 +0000
Message-ID: <PH7PR12MB8796BDF79BDA1A76874B2220B097A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250512051345.5771-1-cesun102@amd.com>
In-Reply-To: <20250512051345.5771-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b445d8d1-5d67-4fd0-8bdc-57e54f903dba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-12T05:16:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB9196:EE_
x-ms-office365-filtering-correlation-id: 54fa2bb5-f6fc-44b7-8229-08dd91190ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JZUcwPuLu8MHEza3BGgotOdE2e8V1/7q9bSIHH7D4z7Q4DYznHjkX9Fd1QPZ?=
 =?us-ascii?Q?I9HDiVbIjmPwEHABYIj3Sip3Jcn9xe/g2qOwoh74N3xhUiayI6Ge8wLdrg3R?=
 =?us-ascii?Q?1ghpwOpDZnBZvEcIJI9Hfemi8Xg1Xv2bAKFEqeZ9AiqoeeewuJMi8QXfXD0H?=
 =?us-ascii?Q?Sqw3aqRuifzXPnvGZ4UbOx2eko/5iits6ZohMX7zpdsSwR2UVgZOHVClapg2?=
 =?us-ascii?Q?tvPHgaz42y3/9gKjv490xeKMdj0RXn5Zeao03wAjpTsvx7ProzE9AtuQIRpl?=
 =?us-ascii?Q?399CN5pYS48wETltgO/mAH+S2gxqVqlBzO1hYpxgWmA+k58sfU3FIh/yVSkl?=
 =?us-ascii?Q?OwZehXCVnNxqTkGofmcTWhyaNcgn+E/efbhAmscdRFF5OTDDQhZ+IR4ofco2?=
 =?us-ascii?Q?X4aMSPC0gGmTGlsSN9nc+U6/PFVRanPK7Djce93pI55nEdwijwE9NuaWfQXq?=
 =?us-ascii?Q?i/RJXJuQaHfV2YhIOmXmFL1hjHUgHnF0/KNW7HFjbVuCrRVf2jswYdEC3PqR?=
 =?us-ascii?Q?LPXZKJcQDB1AFau0/Ko8TyHpVpQmd4cIJkU1iZPqA2YCftQGWZGcAAi0hjRZ?=
 =?us-ascii?Q?Sb2JNeuSCOCJzmS47OqMJnjZaqfWHhGLE7hYwcdY7TdNAzMtYxnebLJbPmPD?=
 =?us-ascii?Q?rSjrtsUVBf4ylY3MDXS91Euqxz332YE6fUwGCks1OQxaMQZPVnFSI03SP47l?=
 =?us-ascii?Q?oYeTcBoONCwNIamlr80pJTIYq90yFfZXaR2Qvn+Muq3ZWrvqSFkb0GCh/p+f?=
 =?us-ascii?Q?BDaOuSH7dVeAQp8uzuyt+lqVqyjdnOBSRgE+QwKW8FrQ0fvxHZs3l22NfxRx?=
 =?us-ascii?Q?JGLhU14YcSyCupbJrUEboUu/4HdSDVODKdO806lTqz5qBUv4IspTjWAYh3Y8?=
 =?us-ascii?Q?ewP6Wibcd7iKzlCKfp/0kU0Vl283g+HnT1AOAxcBA7Nx6tDyAEVCz5eO1gCz?=
 =?us-ascii?Q?5adXg9nJCBeOHuoaFumOCXoV/SRf2jn/IGzbqNTWveNrJZcg+lnviZl5Eooz?=
 =?us-ascii?Q?xKnDt3nPPtI/i2QpdvlEf58ndeeMVrMHzZ0CuR+pFkVZndmnBWTW7te/Qu1L?=
 =?us-ascii?Q?b1ZaQXbL0ZbDfd0ucvnPkOG8bNw1UpRVkGGB7LqoFBw6t46297/GN0EwmUSD?=
 =?us-ascii?Q?8AMuMRzfUpP3k6DUdCLxcR/AONh8R0hEQ+5WmEJjvsZyaU/wx8gOaT9+GXDl?=
 =?us-ascii?Q?2d3GDIFUm2kZaZaam0kt78FjIyRbt+sUqmiB3vu9urha+AQ7OCEwSyG1YJ6I?=
 =?us-ascii?Q?AvQFz7tLs0qEMHCXTIcaEPC50u1By6g4uhRk2T6UN5JtxR+rp/X4qiju6f1y?=
 =?us-ascii?Q?gPSHjj5dIzBVJQw/mbv56SqAy/Uwkx8xip0lrmgV6A4Ea0M30SBoOL627/+C?=
 =?us-ascii?Q?h+Oe/MgzfL0cEcsTBqLTWXUrGAJcIOwdCY9nPZooDsr9EscfVHDpYS5sOZmC?=
 =?us-ascii?Q?rOyJZ9CSnMQ8VeDTPCE4LhiuHDeDlZr+t5IpOe/9PrcnbKw16pVa9HfabGmf?=
 =?us-ascii?Q?hzdkVrlOT6RDI54=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5OEMf53kdeq3gIIoL8lVa3MEQGnrRsGkTpwCplj3YTBuo3mpFk1BSi5hcLNm?=
 =?us-ascii?Q?2ZevJ6k6ImAQeDy7ncAZgzGi62BCRr3dB6WFe1vUq56ZDoWZS6TNattRk2NJ?=
 =?us-ascii?Q?WefYX9T0dSTxoLmK9uVwSEkAHVq7m2A7dFl5Z/47Bk9uCZv3nRIccNpiR4F9?=
 =?us-ascii?Q?ZKhNiHaxBR7RcRSMHnVTUWB7EhnxIo7945BR60cfWAAarxMsATF4QLKQokxV?=
 =?us-ascii?Q?XB25dZNXt/ZR8+KtYgX591qXoFWWL+2slFP6AU/zvAsH90fpjQEIPk8bzK6k?=
 =?us-ascii?Q?1AA8TQiBzR5ScrYBbb6X4yeXH83Ool2YhrFV651kOLCpBxWYULjv5jSpHKnj?=
 =?us-ascii?Q?gkE50MgXasv0QxROY2XBHswQJktHv/d5V7DVk6Q9UI7HciEFApbUTNOiNrID?=
 =?us-ascii?Q?ET+EZn6wIt3TLLaTlqPcppKwo1fbSwmQ7DQ6tTbrtNOL2KBfqg/uyOxsSZnH?=
 =?us-ascii?Q?ENuj6i5SfWMfcqRqkhSowxKgPdVGJjdvS0cAXg2t2AXsxqkQA+WqWlEF/nHB?=
 =?us-ascii?Q?rv27UmAU4xogaeLH7OpZgEePfNtdR4XEs1byQz4rcQrCoAy468dn5RSNikBw?=
 =?us-ascii?Q?Ouh89nsAQ3NQrLWeAvZXmwBB/v3f4V37l5jB9ZVSfgFqk2xZIY2X6HqBSd5e?=
 =?us-ascii?Q?EY8dCEVAnJ2AcHOWFQ2wNl6aDyHusaOWe7kInRbFjBIUVJaUM124iDthg6/Z?=
 =?us-ascii?Q?/CTZY6J4BFOYDbreNqnQmsEzOLEoqI+/z+7PjbBaWEFJw3iUIzG42oDFUb1c?=
 =?us-ascii?Q?sjqmwVXAbk3Ta97PryHz0K1C49VGRoIso4j6XUeYPPDZk6ZOk7d4u7XdtRtz?=
 =?us-ascii?Q?IcnmVZZTcSetRgEVR7gopxGhuf5JpMSP/lz2rg0y1u4FlXjJiDwOm0QmIRyh?=
 =?us-ascii?Q?9iZyT5IKGq+DDN5nL0URghnuaAvxXCjFfumurRP/usAVUAKryp//krsORVzA?=
 =?us-ascii?Q?H14GZrsopPbE3/HgGsVJRPxm9LU5qka6pero6upsR8nSSxzWzr+doTwm7tQQ?=
 =?us-ascii?Q?h4nFwD9O22WpJpvJ7vd9iaGhxYpDmNyrOEpd+3zSmLQMvNhuUalakQmMzJWi?=
 =?us-ascii?Q?2tpOJR0D5/07rMRuup7YdUomNelwbgo8SmvlrBaqd1NI3VPFZTQEvCISX7ZF?=
 =?us-ascii?Q?kimxR14TBbyKrSHmREkcb4qncSyLXYvAXhtiH0b2rmopUNOjbh2gLbFtr605?=
 =?us-ascii?Q?/OX3U6m7nwYr3aeFji010JPcvLFSLCwJBOsWdZqrortJSBidkPgE1H0ckwzD?=
 =?us-ascii?Q?CPYZOm8O2UPe+IUwIq1bMm/cYUdSVgsbpZME7Sz4Z/02vAOpbtij6AeJhZOK?=
 =?us-ascii?Q?8Wl6fE6xFblRw2Wm/rbg/PzydfnMj3dDw1uTPrECjOdVm/n6+NW8Yy7bjnfJ?=
 =?us-ascii?Q?+poHbD7lJvGsjqq/kdcbiAUQp6Nz9mhmxGOCRNdCQrKRrN9MIrMMt0fBQmkC?=
 =?us-ascii?Q?iS1Sl1Mnh65tp6x4nnEhzEc8Pgqbhn4FB+8r2wqFj+m39EYPxgeiNXYQboEA?=
 =?us-ascii?Q?+6wuzNDXc1GC9NCPu7qyXvfzh8bqYrruAXXrywWIDtHW0wNh+5rAgS+cieuv?=
 =?us-ascii?Q?S6M3i6MVqw7/kJTDH7Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fa2bb5-f6fc-44b7-8229-08dd91190ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:51:29.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9qNu7lb6sXQWlz5EGagRPNotRCgTs7XiB4M3l8vH3UmeGn0fJeeT6z1MSaIKFEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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
> Sent: Monday, May 12, 2025 1:14 PM
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 5 +++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 4 ++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..ef9125a696ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -621,6 +621,11 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struc=
t
> amdgpu_irq_src *src,  int amdgpu_irq_put(struct amdgpu_device *adev, stru=
ct
> amdgpu_irq_src *src,
>                  unsigned int type)
>  {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +     if(ras->is_rma)
> +             return -EINVAL;

[Tao] please add  a comment for the check, with this added, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +
>       if (!adev->irq.installed)
>               return -ENOENT;
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
> --
> 2.34.1

