Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E917FC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 07:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD6C10E079;
	Mon, 12 May 2025 07:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KX3qhzcI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1858A10E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:01:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs8YUwsOlJCamSF9BZzkUw+8G/TxWOP/MEH2S31c5vXvCF9agoXvcCCsDD3idG+O0z68Sox7haZWjHRzYRY0CmjOrVv0wFQ8jZ03qd8vYVooSFmsHyC7AnY0uzmOpQZLtbizJa+5pEYAQs3aki3VvgPY9XILHhObXPE10TO0ecdm12AvgD/E8J0KJaOcGxVE/nYbyfhNSiaCkSuzMemt+rQJoPwLR2GlM7jDfngjJAQ5fYVA0AmhonYO8vUG/Q+6y6+W/w98wZhqOtkgISzkI/DWC3g1wm1wh5pHTAxfj9EgJTI0kn0kh+Pi25CtiajB35g5paJWgFObxvkhQ1PIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1plBylcPVIcwcCIpbZGI0T5ZP8Lc8pjeZpQLqQEIMQY=;
 b=FFXdctzJli+jZ3N7JQPlY+o/GOf0J07BTO0zS6/FLqJYuDv1FZGQiosucZ8tKQNTySTORxbLPyoTfDJNU8H+QulZuHl2mUUw28eZzjBZuZ2kp4HWtRF2ZSthFJOC7QRVWm7Fjx/tfaV105+rCXq6eNkS/Z5X/kZyb4f8rffkBS34C/MaXnZvk/6UiIMfZK1iLuu5/jGgloedFKiz+OCpDnkwh/x8J92BeApLesFPjJAdZPoq7yKZ74IaPc0WxBWJUfvifxuRV5OZVaMp+tGmR7AikrJQwBBfRPjBktRPpfgGrwNjcWgLLQJsp+9t/RzKtAo9bynj0APB5yKgeiyTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1plBylcPVIcwcCIpbZGI0T5ZP8Lc8pjeZpQLqQEIMQY=;
 b=KX3qhzcIUkQHXZzv+rvZtgxE/NfP1f1VD+dOMRJ2zu1ngUeV+m3wCGR8/WOvd8iI3zT8FQ6lWIuWYUyOWkR/RjnsrX0wzmfPh6DH9Ms/Se2nFX/Hy2zFlHDMzZzgQToZtq3dpz/M5wSNkg6+TNscf6pYAR4SbdvEslv6AInzfMA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 07:00:59 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 07:00:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Topic: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS records
 exceed threshold
Thread-Index: AQHbwvyuEbjHPksBs0CSLGoJBd59PbPOdBSQgAAc0/A=
Date: Mon, 12 May 2025 07:00:59 +0000
Message-ID: <PH7PR12MB8796967655FB7E97FE94A917B097A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250512051345.5771-1-cesun102@amd.com>
 <PH7PR12MB8796BDF79BDA1A76874B2220B097A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796BDF79BDA1A76874B2220B097A@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: f014da91-ab8d-427a-4e90-08dd9122c040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P4+syUObyrSU6Iz5YSzA9G4Q13DqqCicnG0csJfqDyWOBSNGDMQcjndRJfc4?=
 =?us-ascii?Q?1fW3+8oDhGVGpcsSH1n3EWiTYtEEdOpzYLCqwrmNMTZpC70s/FWq2c7Nl5jN?=
 =?us-ascii?Q?HsVXAZLgiqPPJr9Rh36bQn09ejTk0EHI9zQhqcNDEVTdR3apgFdxmcMtF5Jp?=
 =?us-ascii?Q?DDCyDUZ94SjO7/VDmy14YPRdV/u1Ph+UtVjRNJA6z9pmLkoEQqettxMRQmas?=
 =?us-ascii?Q?gACH+H1ARPM0DPTWP+6PyFQICTmRZifEOSTOLYihj97YL8RT0mjJEcp2/xfD?=
 =?us-ascii?Q?XkdTQ89X+olrvnAVhtsS+LFw7BmtN2sYr69NaZZuiHiJ6F3wfJNIMIvJdinT?=
 =?us-ascii?Q?tLgruxswf5gT44gpUxNh5G1lDpNjgEiZVpJ+vDc9KUv5kmVLAXldloJXpeYw?=
 =?us-ascii?Q?OWjb3aDiCNLN4lF8cemsiFZlqUkVn1rIzZ0Btsa27ipgWxqkLxp+s0gg/Zhm?=
 =?us-ascii?Q?LNx6WIObE6eYlmprzNZDXwmM5mbttY1e6srtHx2IFa2aFITxXDbWEPDMj6Cf?=
 =?us-ascii?Q?MEeLR9WYkiiNHUL8yarLAh+fdmpKIkc0W5Qnn9lmZiuGRM+tL7czkNDpv3b1?=
 =?us-ascii?Q?ZEdiWyUdYW+8rBhWo2krHPHeHo3objNIXFAQ6XWWEx7pETW7tOn74BretVbl?=
 =?us-ascii?Q?ij5p5g6bsMZ8h8+qrWO8EipHVbG4XpkDFeZQLFyILpyPAL/KGkp1huThRcBM?=
 =?us-ascii?Q?HgiX/XqnI+XoKGfGWiPoslnTeye9efq25uELOksKln1B6IQyQuG7hge7vMBL?=
 =?us-ascii?Q?+NAnQ9Vw/sPleTbgQMOAjzN6uw5t4y3YhCs7FCvBEkeT0MLqTc6J9H+8nsZf?=
 =?us-ascii?Q?Yq4GxQDv5TDt0LvPBMaZLu2kSQ+Ff9/s3FwFQ0+HMlhaKAcjLLQggTIjpMsa?=
 =?us-ascii?Q?yV2FLACvzsfWlQG6mwqN0X5wH0psplKlMJCuulDseQxyKqoiOLoFhuKMnD2K?=
 =?us-ascii?Q?xpw2/U6gYhnDTBAFHRoDctqbmgyLiFK4zIu5iXdzMIipDtAvKMrXXkgjWpXt?=
 =?us-ascii?Q?dwJCd+zmDkSIbxfQTLR1BBC3NAbpvnS8sZH8cR+0O7C48a8Dhq5lifP2PK26?=
 =?us-ascii?Q?n1lBRcc8OO87sjgxNl2yc+gkf4fJ9MaxtrQqGtiHQIrYyMZpq6lNpBzbE6u0?=
 =?us-ascii?Q?CNluxBM0Sno8sZYeiixr9TJUjNIc0pywdeP3X1Oz2EQgGUELLhmIC42BmtYx?=
 =?us-ascii?Q?U3Jo5zN3or44NoqlXWhMc89lIdbXc/Gpnrbbj1FTSb030E4AQ+oSVifHZpUZ?=
 =?us-ascii?Q?gtO9lWV8YGZ7nI+JzEyq2KY2dV71Dh1VZIJ2WfULICO8Aoz9RzGPOP/w/wvo?=
 =?us-ascii?Q?XPfFkNLlS8EP1xZ2by2axbbs0KV6Cs4VRJzzCeLKHXkNDUwPNqrCS+1rUH5Q?=
 =?us-ascii?Q?xQ4R9BcRMaz0boBtYGuI7xnkpv4EzY+RS9yq5doGvYULnDx9VsT3l9/8G0Zk?=
 =?us-ascii?Q?dlCJX1lsYzFCQpkZbaOo6TLHot9o6BlU+p+D7g5BzjOBtrjUNpIGV7JZqkfi?=
 =?us-ascii?Q?+6q57XyAYXx02w8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KWpD9E6bxwk8LwaHPh/E3StBBw/CmOyu32csJR1Af27drjwYhmloDZ7TIg6/?=
 =?us-ascii?Q?059oCo++XPGfNZ5LzxRpdy17lLRzyn79CCTzshqQun4+V3wtGEdtdx50qB0t?=
 =?us-ascii?Q?MMp8oB9rmIDCqJU6sC6ArQYbf/+/amRwdZEdDlaI54tlOGUaZRWABUL3rgD/?=
 =?us-ascii?Q?Gt8Voctc3xupVIVS+MJYEBD876LjdoM8yGq4mJW6cvqChHVdj8AN/neyJ6o5?=
 =?us-ascii?Q?PrtXiOL+Iy8HSNolzh/EvuVcu0dQik8jAVOGmSi3/8B8e+jTKOYy7MFM/QdY?=
 =?us-ascii?Q?9S6QqR17vDGupdDeIiF7soeCKIeeeyeV8ddiPGTVudqPxnRaal/rT3GW8NR8?=
 =?us-ascii?Q?dB28ZRqPQvSrX3MHBioAISvEpANNDPD9MwRnJlMCxxJcCDnlA3guTcAYW+p/?=
 =?us-ascii?Q?Hc/rF++2qJqhBbtWQOeyzs3vTGIQLJjD3Tv9bJyiKdOemNCyu52aQS8khKW2?=
 =?us-ascii?Q?jsvQmZtL6eSzmcUQj5ejDv6dQrJMwpbq+S1bPO+JhE4ke0Eg3qoK0MAOq5kb?=
 =?us-ascii?Q?2ASV+kdIduBmj0WmxkNMCMSis7SnGWaQUSJUcq+3REKTWizs2Dfw0XvVTOUS?=
 =?us-ascii?Q?l1P/isYo4RDGcwO85OZJwZ3jkR7/QAn3CX/PsS0ock6K08RySclzeCbFknRF?=
 =?us-ascii?Q?7bmrPELMJf8/gYzOyd1dVPy8opi391caKCx0bOob/4YEqpsrW+OeF6M2c4Dr?=
 =?us-ascii?Q?oO18CN1PWto+vDtE6UjviLGxNDVNBlqz+zNSwCKHId8zDUCPiJn3hdsCzzTd?=
 =?us-ascii?Q?Cv1t8Na47oG7M1zCV6/lGqEaS9YygoeetW4rRC0TQqKPfkM9lo4egbs13gWY?=
 =?us-ascii?Q?50egyllBjOv5LFziSlK66dL7kGZ3e68Kiq98e55qOB3CPpl3Fu+qMkPo00CP?=
 =?us-ascii?Q?52z2pj2pFXf8RoYsz91/w460E/wvsD2Jl8ADndGSFio9yUb5QOWBQfuIVNPO?=
 =?us-ascii?Q?88Ez8kWPFpBFRDlwKtclQKL4d8J+e/ZTQfEjFCyahXTuvG4ZkQqdgmsPxlSJ?=
 =?us-ascii?Q?zAQYEbGY9jGV5xSXyoA72ZFMb2oCaGWB+hmckv96Tej+dpPX0GS3akODPS75?=
 =?us-ascii?Q?04A+akogt/3Dv9PzxhCDdYUQG6uIFdZh7VNDHmjaPq86EB3TpXPbEfM+4jJE?=
 =?us-ascii?Q?gUrxlXN+HIfa57Zve2K3abdjT+G8KMMaHndi+eRNkTTja9fec1H6bsxtttck?=
 =?us-ascii?Q?4X+XPdWLbxP6UwZCT8Y43ZMeVHlsGxS8g/feCKcdeMxNX3Kj6Nenwwy9O/aE?=
 =?us-ascii?Q?07HKMr7Uq7Vnrn9scnYrcv5CNnoAxKEqLWO5H7Np1vfWaxzQjdFxrbWhUH7M?=
 =?us-ascii?Q?I5P9B1C7RaiBCzbIYRPWjoXCsNnX9R32wKWnYDc+yAYbphAtEjcaGAbckd4h?=
 =?us-ascii?Q?i/c0/mm2oZ0XC7zFtSvHRAjHpLFPs3jqZzXWuOf3tFo7Avk955QtN1Haxrcl?=
 =?us-ascii?Q?Js7zouwJ83gy79uxZSRIpojqYQSSbU2oMjfF3h3is35yMF7++gC4DrWNdstz?=
 =?us-ascii?Q?bXdS/Se7fYPx7Pcbhig9XXjHg4BQo30h9KU/SB/sffOTBrA9xjia35JmGa7F?=
 =?us-ascii?Q?HtNpWZg6cqAofGulNKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f014da91-ab8d-427a-4e90-08dd9122c040
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 07:00:59.6571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0K7DXPfjGjbMQjyVDHAxK83s2G2CqEM7kW53c5VRPmkOmL749Hu5e53aaHczOMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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
> From: Zhou1, Tao
> Sent: Monday, May 12, 2025 1:51 PM
> To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS recor=
ds
> exceed threshold
>
>
>
> > -----Original Message-----
> > From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> > Sent: Monday, May 12, 2025 1:14 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> > Subject: [PATCH] drm/amdgpu: Fix the kernel panic caused by RAS
> > records exceed threshold
> >
> > kernel panic caused by RAS records exceeding the threshold when load
> > driver specifying RMA(bad_page_threshold=3D128) 1.Fix the warnings
> > caused by disabling the interrupt source before it was enabled 2.xcp
> > sysfs is not initialized,null pointer appears during fini 3.Fix the
> > memory leak caused by the device's early exit due to rma
> >
> > The first reason:
> > [ 2744.246650] ------------[ cut here ]------------ [ 2744.246651] WARN=
ING: CPU: 0
> PID:
> > 289 at /tmp/amd.BkfTLqYV/amd/amdgpu/amdgpu_irq.c:635
> > amdgpu_irq_put.cold+0x42/0x6e [amdgpu] [ 2744.247108] Modules linked in=
:
> > amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)
> > amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE)
> xt_conntrack
> > nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter
> > xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> > overlay binfmt_misc intel_rapl_msr intel_rapl_common i10nm_edac nfit
> > x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel
> > nls_iso8859_1 kvm rapl isst_if_mbox_pci isst_if_mmio pmt_telemetry
> > pmt_crashlog isst_if_common pmt_class mei_me mei acpi_ipmi ipmi_si
> > ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad mac_hid
> > sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr
> > ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables
> > x_tables autofs4 btrfs blake2b_generic zstd_compress raid10
> > raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> > raid6_pq libcrc32c raid1 raid0 multipath [ 2744.247167]  linear
> > mlx5_ib ib_uverbs ib_core ast i2c_algo_bit drm_vram_helper
> > drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul syscopyarea
> > crc32_pclmul ghash_clmulni_intel mlx5_core sysfillrect sysimgblt
> > aesni_intel mlxfw fb_sys_fops psample cec crypto_simd cryptd rc_core
> > i2c_i801 nvme xhci_pci tls intel_pmt drm pci_hyperv_intf nvme_core
> > i2c_smbus i2c_ismt xhci_pci_renesas wmi pinctrl_emmitsburg
> > [ 2744.247194] CPU: 0 PID: 289 Comm: kworker/0:1 Tainted: G           O=
E
> 5.15.0-
> > 70-generic #77-Ubuntu
> > [ 2744.247197] Hardware name: Microsoft C278A/C278A, BIOS
> > C2789.5.BS.1C23.AG.2 11/21/2024 [ 2744.247198] Workqueue: events
> > work_for_cpu_fn [ 2744.247206] RIP: 0010:amdgpu_irq_put.cold+0x42/0x6e
> > [amdgpu] [ 2744.247634] Code: 79 7f ff 44 89 ee 48 c7 c7 4d 5a 42 c2
> > 89 55 d4 e8
> > 90 09 bc bf 8b 55 d4 4c 89 e6 4c 89 ff e8 3c 76 7f ff 8b 55 d4 84 c0
> > 75 07 <0f> 0b e9
> > 95 79 7f ff 49 03 5c 24 08 f0 ff 0b 75 13 4c 89 e6 4c 89 [ 2744.247636]=
 RSP:
> > 0018:ffa0000019e27cb0 EFLAGS: 00010246 [ 2744.247639] RAX:
> > 0000000000000000 RBX: 0000000000000000 RCX: ff11000150fa87c0 [
> > 2744.247641] RDX: 0000000000000000 RSI: ffffffffc2222430 RDI:
> > ff1100019f200000 [ 2744.247642] RBP: ffa0000019e27ce0 R08:
> > 0000000000000003
> > R09: ffffffffffe41a08 [ 2744.247643] R10: 0000000000ffff0a R11:
> > 0000000000000001
> > R12: ff1100019f22ce60 [ 2744.247644] R13: 0000000000000000 R14:
> > 00000000ffffffea R15: ff1100019f200000 [ 2744.247645] FS:
> > 0000000000000000(0000) GS:ff11007e7e400000(0000)
> > knlGS:0000000000000000 [ 2744.247647] CS:  0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033 [ 2744.247649] CR2: 00007f3d2002819c CR3:
> 0000000006810003 CR4:
> > 0000000000771ef0 [ 2744.247650] DR0: 0000000000000000 DR1:
> > 0000000000000000 DR2: 0000000000000000 [ 2744.247651] DR3:
> > 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 [
> > 2744.247652] PKRU: 55555554 [ 2744.247653] Call Trace:
> > [ 2744.247654]  <TASK>
> > [ 2744.247656]  sdma_v4_4_2_hw_fini+0x7a/0xc0 [amdgpu] [ 2744.247997]  =
?
> > vcn_v4_0_3_hw_fini+0x5f/0xa0 [amdgpu] [ 2744.248336]
> > amdgpu_ip_block_hw_fini+0x31/0x61 [amdgpu] [ 2744.248776]
> > amdgpu_device_fini_hw+0x3bb/0x47b [amdgpu] [ 2744.249197]  ?
> > blocking_notifier_chain_unregister+0x56/0xb0
> > [ 2744.249202]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu] [
> > 2744.249482] amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu] [
> > 2744.249913]
> > amdgpu_pci_probe+0x23e/0x590 [amdgpu] [ 2744.250187]
> > local_pci_probe+0x48/0x90 [ 2744.250191]  work_for_cpu_fn+0x17/0x30 [
> > 2744.250196]  process_one_work+0x228/0x3d0 [ 2744.250198]
> > worker_thread+0x223/0x420 [ 2744.250200]  ?
> > process_one_work+0x3d0/0x3d0 [ 2744.250201]  kthread+0x127/0x150
> [ 2744.250204]  ?
> > set_kthread_struct+0x50/0x50 [ 2744.250207]  ret_from_fork+0x1f/0x30 [
> > 2744.250212]  </TASK> [ 2744.250213] ---[ end trace 488c997a88508bc3
> > ]---
> >
> > The second reason:
> > [ 5139.303446] Memory manager not clean during takedown.
> > [ 5139.303509] WARNING: CPU: 145 PID: 117699 at
> > drivers/gpu/drm/drm_mm.c:998
> > drm_mm_takedown+0x27/0x30 [drm] [ 5139.303542] Modules linked in:
> > amdgpu(OE+) amddrm_ttm_helper(OE) amdttm(OE) amdxcp(OE)
> > amddrm_buddy(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE)
> xt_conntrack
> > nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter
> > xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> > overlay intel_rapl_msr intel_rapl_common i10nm_edac nfit
> > x86_pkg_temp_thermal intel_powerclamp coretemp ipmi_ssif kvm_intel
> > binfmt_misc kvm nls_iso8859_1 rapl isst_if_mbox_pci pmt_telemetry
> > pmt_crashlog isst_if_mmio pmt_class isst_if_common mei_me mei
> > acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad
> > acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac
> > scsi_dh_emc scsi_dh_alua msr ramoops reed_solomon pstore_blk
> > pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs
> > blake2b_generic zstd_compress raid10 raid456 async_raid6_recov
> > async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
> > raid0 multipath [ 5139.303572]  linear mlx5_ib ib_uverbs ib_core
> > crct10dif_pclmul ast crc32_pclmul i2c_algo_bit ghash_clmulni_intel
> > aesni_intel crypto_simd drm_vram_helper cryptd drm_ttm_helper
> > mlx5_core ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_f=
ops cec
> rc_core mlxfw psample intel_pmt nvme xhci_pci drm tls i2c_i801 pci_hyperv=
_intf
> nvme_core i2c_smbus i2c_ismt xhci_pci_renesas wmi pinctrl_emmitsburg [las=
t
> unloaded: amdkcl]
> > [ 5139.303588] CPU: 145 PID: 117699 Comm: modprobe Tainted: G     U    =
 OE
> > 5.15.0-70-generic #77-Ubuntu
> > [ 5139.303590] Hardware name: Microsoft C278A/C278A, BIOS
> > C2789.5.BS.1C23.AG.2 11/21/2024 [ 5139.303591] RIP:
> > 0010:drm_mm_takedown+0x27/0x30 [drm] [ 5139.303605] Code: cc 66 90 0f
> > 1f 44
> > 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 75 05 c3 cc cc cc cc 55 48 c7
> > c7 18 d0 10 c0
> > 48 89 e5 e8 5a bc c3 c1 <0f> 0b 5d c3 cc cc cc cc 90 0f 1f 44 00 00 55
> > b9 15 00 00
> > 00 48 89 [ 5139.303607] RSP: 0018:ffa00000325c3940 EFLAGS: 00010286 [
> > 5139.303608] RAX: 0000000000000000 RBX: ff1100012f5cecb0 RCX:
> > 0000000000000027 [ 5139.303609] RDX: ff11007e7fa60588 RSI:
> > 0000000000000001 RDI: ff11007e7fa60580 [ 5139.303610] RBP:
> > ffa00000325c3940
> > R08: 0000000000000003 R09: fffffffff00c2b78 [ 5139.303610] R10:
> > 000000000000002b R11: 0000000000000001 R12: ff1100012f5cec00 [
> > 5139.303611] R13: ff1100012138f068 R14: 0000000000000000 R15:
> > ff1100012f5cec90 [ 5139.303611] FS:  00007f42ffca0000(0000)
> > GS:ff11007e7fa40000(0000) knlGS:0000000000000000 [ 5139.303612] CS:
> > 0010
> > DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5139.303613] CR2:
> > 00007f23d945ab68 CR3: 00000001212ce005 CR4: 0000000000771ee0 [
> > 5139.303614] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000 [ 5139.303615] DR3: 0000000000000000 DR6:
> > 00000000fffe07f0 DR7: 0000000000000400 [ 5139.303615] PKRU: 55555554 [
> > 5139.303616] Call Trace:
> > [ 5139.303617]  <TASK>
> > [ 5139.303619]  amdttm_range_man_fini_nocheck+0xfe/0x1c0 [amdttm] [
> > 5139.303625]  amdgpu_ttm_fini+0x2ed/0x390 [amdgpu] [ 5139.303800]
> > amdgpu_bo_fini+0x27/0xc0 [amdgpu] [ 5139.303959]
> > gmc_v9_0_sw_fini+0x63/0x90 [amdgpu] [ 5139.304144]
> > amdgpu_device_fini_sw+0x125/0x6a0 [amdgpu] [ 5139.304302]
> > amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [ 5139.304455]
> > devm_drm_dev_init_release+0x4a/0x80 [drm] [ 5139.304472]
> > devm_action_release+0x12/0x20 [ 5139.304476]  release_nodes+0x3d/0xb0
> > [ 5139.304478]  devres_release_all+0x9b/0xd0 [ 5139.304480]
> > really_probe+0x11d/0x420 [ 5139.304483]
> > __driver_probe_device+0x119/0x190 [ 5139.304485]
> > driver_probe_device+0x23/0xc0 [ 5139.304487]
> > __driver_attach+0xf7/0x1f0 [ 5139.304489]  ?
> > __device_attach_driver+0x140/0x140
> > [ 5139.304491]  bus_for_each_dev+0x7c/0xd0 [ 5139.304493]
> > driver_attach+0x1e/0x30 [ 5139.304494]  bus_add_driver+0x148/0x220 [
> > 5139.304496]  driver_register+0x95/0x100 [ 5139.304498]
> > __pci_register_driver+0x68/0x70 [ 5139.304500]
> > amdgpu_init+0xbc/0x1000 [amdgpu] [ 5139.304655]  ? 0xffffffffc0b8f000
> > [ 5139.304657]
> > do_one_initcall+0x46/0x1e0 [ 5139.304659]  ?
> > kmem_cache_alloc_trace+0x19e/0x2e0
> > [ 5139.304663]  do_init_module+0x52/0x260 [ 5139.304665]
> > load_module+0xb2b/0xbc0 [ 5139.304667]
> > __do_sys_finit_module+0xbf/0x120 [ 5139.304669]
> > __x64_sys_finit_module+0x18/0x20 [ 5139.304670]
> > do_syscall_64+0x59/0xc0 [ 5139.304673]  ?
> > exit_to_user_mode_prepare+0x37/0xb0
> > [ 5139.304676]  ? syscall_exit_to_user_mode+0x27/0x50
> > [ 5139.304678]  ? __x64_sys_mmap+0x33/0x50 [ 5139.304680]  ?
> > do_syscall_64+0x69/0xc0 [ 5139.304681]
> > entry_SYSCALL_64_after_hwframe+0x61/0xcb
> > [ 5139.304684] RIP: 0033:0x7f42ffdbf88d [ 5139.304686] Code: 5b 41 5c
> > c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73
> > 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48 [ 5139.304687] RSP:
> > 002b:00007ffcb7427158 EFLAGS: 00000246 ORIG_RAX: 0000000000000139 [
> > 5139.304688] RAX: ffffffffffffffda RBX: 000055ce8b8f3150 RCX:
> > 00007f42ffdbf88d [ 5139.304689] RDX: 0000000000000000 RSI:
> 000055ce8b8f9a70 RDI:
> > 000000000000000a [ 5139.304690] RBP: 0000000000040000 R08:
> > 0000000000000000 R09: 0000000000000011 [ 5139.304690] R10:
> > 000000000000000a R11: 0000000000000246 R12: 000055ce8b8f9a70 [
> > 5139.304691] R13: 000055ce8b8f2ec0 R14: 000055ce8b8f2ab0 R15:
> > 000055ce8b8f9aa0 [ 5139.304692]  </TASK> [ 5139.304693] ---[ end trace
> > 8536b052f7883003 ]---
> >
> > Signed-off-by: Ce Sun <cesun102@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 5 +++++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
> > drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 4 ++--
> >  3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > index 0e890f2785b1..ef9125a696ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -621,6 +621,11 @@ int amdgpu_irq_get(struct amdgpu_device *adev,
> > struct amdgpu_irq_src *src,  int amdgpu_irq_put(struct amdgpu_device
> > *adev, struct amdgpu_irq_src *src,
> >                unsigned int type)
> >  {
> > +   struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> > +
> > +   if(ras->is_rma)
> > +           return -EINVAL;
>
> [Tao] please add  a comment for the check, with this added, the patch is:
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

[Tao] BTW, please use amdgpu_ras_is_rma to get rma status.

>
> > +
> >     if (!adev->irq.installed)
> >             return -ENOENT;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index cb7991362b5d..6f24e95c9112 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -2496,6 +2496,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
> >     amdgpu_vram_mgr_fini(adev);
> >     amdgpu_gtt_mgr_fini(adev);
> >     amdgpu_preempt_mgr_fini(adev);
> > +   amdgpu_doorbell_fini(adev);
> > +
> >     ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
> >     ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
> >     ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > index cd6e4c0b94da..e970a1427fe0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -719,10 +719,10 @@ void amdgpu_xcp_cfg_sysfs_fini(struct
> > amdgpu_device
> > *adev)
> >     struct amdgpu_xcp_cfg *xcp_cfg;
> >     int i;
> >
> > -   if (!adev->xcp_mgr)
> > +   if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
> >             return;
> >
> > -   xcp_cfg =3D  adev->xcp_mgr->xcp_cfg;
> > +   xcp_cfg =3D adev->xcp_mgr->xcp_cfg;
> >     for (i =3D 0; i < xcp_cfg->num_res; i++) {
> >             xcp_res =3D &xcp_cfg->xcp_res[i];
> >             kobject_put(&xcp_res->kobj);
> > --
> > 2.34.1

