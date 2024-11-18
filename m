Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AB4D10F57
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 05:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C25810E31D;
	Mon, 18 Nov 2024 05:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d8S1UGg9";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA6E10E31D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 05:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbxgbepk90hRw2mCPHcavw4KKKtKoUhMxfpO1rX3WDifTFZ9yKJoHTI8bGYarDByMNrg2lB5Jp1XVellGaXzExK+R16e7v61kDKttNiRtVE7bZocz4ue02GTMImrBXDZyBQXsW2whjxkzNgxT5rwHHkfY50GTUfRJC5MQPwMWw1WLRpE/+MFCPc+Nm5K2h0+mYd2XO3aux7T+rklrvOsPMqWgiG63vq6mcV5CFdLK5x6ID9SKTC4/b274OcRDddn7pm3aLkzu3Y4owC5AGc5IkgDjyKdS9OmD/dVRyRrE0O/fsC2H0D3U/GRGrWa4wCqAClalHVLLQtJ78GwsRbEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVcDhpcj1Ma68Uj5WDe4in3iPUxJ0crtkMeGbAA3CtY=;
 b=afAy00VxaLXRktrDYHpxxJILyNdi5TSgblzkdAKF7h2dcVrS8Bado/DmE28BrtrtGRXqW8WQi7Tv1tDy78+PLHUfaqf+/SmdvGM3esRA9VIuzE4X5Y3HCq6vpefKc1O+MnyBf/XSLCOJc5xG12QLFYshv3u5lL7gsAog8RrMSgOC3Ki+EAsQfgSSi5KfnfYOZy55apCY34N9U/yREGzTEyXcajUFw/AXuy8kiLeDG1NP9DvvUMHsUuPQI5hiVQ7IeVcwM9JykAUTL+RZ/m+X5PYmGnc86WXXZUkXYtSvaBDGcPS8jN/U+Kfo/bTm1hUcjKzFqa97VzpgLLN2PbqLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVcDhpcj1Ma68Uj5WDe4in3iPUxJ0crtkMeGbAA3CtY=;
 b=d8S1UGg9eacDzS2riqgJOnOeoHAj3JCuqW25UeJe7zx+qc/6MWBeHvSH721RyIhuOzsylWUcAhHa/cjDVkDFwvvp64gJyWCwvG4P9iErzLpfp2tvQNU21elqxXLIxWFIvxA8SKrYUgYv08BlTlTNGeG/O31TKFo1qq21CHrqYrM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Mon, 18 Nov
 2024 05:46:39 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:46:39 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Dong, Andy" <Andy.Dong@amd.com>
Subject: RE: [PATCH 3/3 V2] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Topic: [PATCH 3/3 V2] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Index: AQHbOXsttDa+HL3LT02ipOfajyeHzrK8hlDw
Date: Mon, 18 Nov 2024 05:46:39 +0000
Message-ID: <CH3PR12MB8074128A0CF9C1915B5AE3E0F6272@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241118053059.3836648-1-jesse.zhang@amd.com>
In-Reply-To: <20241118053059.3836648-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=97ae6712-eba8-410b-a503-3f580dd3193e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-18T05:42:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MN0PR12MB6367:EE_
x-ms-office365-filtering-correlation-id: eb3a032f-9223-48b5-edde-08dd07945f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?u0Xqxmnn3uxYanabWZeQ5lyJGVDhtTVY4pxMjS/ZWLFvLSfEMBSjenzuGR?=
 =?iso-8859-1?Q?Z3R0auzRcohLIwoBPLb0ti7EKFvBdVR6zGYdOsYzmzbCA7BKh4ulCO9SfP?=
 =?iso-8859-1?Q?vjNy/cTLxHseCA5EXpkQzGCNTXjzQgbho9EvBD0vIdH8gMiTNMsAMgb+Hy?=
 =?iso-8859-1?Q?4SH3zik09zQWkulUYeyylASQTm3Svr8NK9pdpyjM7fJbkmsny+ENYl/VHc?=
 =?iso-8859-1?Q?jHMqBuPUrS35SwXf8bDMjihtILzjOAodL4yJe/6sLExPZxzlO/Mr5CWzn3?=
 =?iso-8859-1?Q?HhlxBr56B7yLePk33mQgqIbWJV/8WcnwS5drPzyCB8hvd6OzB+mgGuBRTL?=
 =?iso-8859-1?Q?J6xmh2eOyIlE97b3qo/ZfHaw3b3jBMnBizj1hSaffrBpPz0DnlYRooae1T?=
 =?iso-8859-1?Q?KaOijRVhn3L/aFH5cRCZujeAPzNKMMeRhi9Q742V3/887ii3q2XpbYxTcH?=
 =?iso-8859-1?Q?owl/H75672HBGCtF/adyH61ApZ5OERJnmo+zvrGC9i7sH4kl7qDVNzxu/J?=
 =?iso-8859-1?Q?BcJRMeY1Wmi/d9Z+A9RAMF/zNPEd6fMIBaGU8kgaoF3/VIjo1r6uhGYmIi?=
 =?iso-8859-1?Q?ZlmhR8PrutPi2mvYATntsCvTsTadsL6rDkt7mZxbQxw/yEBoH9h6HHRXot?=
 =?iso-8859-1?Q?hNT8A7ngNTiU7T9fwNbNseNIkERO9dhE1VQnNLLq6U09WfwSFgwqFqYOO/?=
 =?iso-8859-1?Q?MK0iCydxyQLZKklCRBTONQKKdvgQedeP/+54oIDOpu8VRksyPeKI7lopu9?=
 =?iso-8859-1?Q?oTo2/tTmTjAL6M2lBwTF9NA/Z78I5WElQJbuOpsbfDv0Zm20rCNwpIFeM+?=
 =?iso-8859-1?Q?Cq6Y+kv/C8Mg3GjHXYUVV/MBDilwVJj7ecmAb7gq4YcnF4cyUI37dh5/CW?=
 =?iso-8859-1?Q?JBeZp08zptayVprLKtvaoDFLPbBhs2oJtQY8RzOs1b40dET8Lfy3E/oGQZ?=
 =?iso-8859-1?Q?G78qeCuchU0iPo0pVNdvS0OzRzsxUr/Cga0N0v1E0WhDpGCveYT7uso64H?=
 =?iso-8859-1?Q?80C9AywoZ4P3UFARJC+A5XsTTkiUQe8K8Dm7e0WaDmzc4cuPlmPU0nsC9A?=
 =?iso-8859-1?Q?/6x6+t/hYED96pJl79fEyb7RaYovnGgnc7tb6NHazqE7pa7ZzsPRCxl5IS?=
 =?iso-8859-1?Q?soLbNKtQT37/aIxPcqu8SNPyHpsv08yvRmrnr0VYjS3BGr4EPpNUpHTEnY?=
 =?iso-8859-1?Q?1IQ7lTbENopPHAr0S6C8O4KeQRVQv1p1Gk54BPA8kiGJJD+JnfR6j/xUyi?=
 =?iso-8859-1?Q?0Md2zSDBGisIBVuNE+NSAfC15U0wJYR3eIpp+9QDizI6bXv6ScKiEfEoBJ?=
 =?iso-8859-1?Q?iOa/Jr3467uCQXYgtZg6pyNyyocLSZCoREzdn8HXeP0sBc5URukSKzBA2q?=
 =?iso-8859-1?Q?rChNsFGTqhUk96vL5Ovtd7X+cVqeg/kEb38q1drv6+J1sl3n7IvRA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8yMLPZOkrrhdRZgH8cQPErd0WtifbXUYfy5iSEOTqa98AGo0/gkKsyxP05?=
 =?iso-8859-1?Q?owI5xIEuwiuFFG5LntV0f27EIzde295XgZkQLDHeaUucp7hsJFyYvBT0Uw?=
 =?iso-8859-1?Q?h5jkido1Jp6khhMmlJHI3d2aN+aHJIGBh9S3/b/VRQlwcQL4xW073QBO5w?=
 =?iso-8859-1?Q?EhcXKjI0XmBgc1vIt0CIoOK8Gf1XYkG+n/QU89SypITdJvundYesj6ZJIs?=
 =?iso-8859-1?Q?lAu6w8zKT6OO2+AlGntvA0fzcVySQ9KDZMnNOuGoiNG5nGw2VjrdQ7vRTw?=
 =?iso-8859-1?Q?WT/2NIwnCzK3uM+cTo2+cZf32QvvvTf23dq9reqI8B2whSCn8lYjpC4hR5?=
 =?iso-8859-1?Q?hBXYSJUOvzBPdGmj2oPJEvbNAn85IP0MB7sw2yvq7vYov0AykzYvLWCk3j?=
 =?iso-8859-1?Q?1cSlHDsG9+LZfJZwUJA912zDDFfpTlKQee5u4Q+9lk8RSWSGy1cA6O32WL?=
 =?iso-8859-1?Q?fQtBZpI7koxhEb9312bv7snc9PUGQpStvtkI0wsT3K1g57O26WNwtqhHW2?=
 =?iso-8859-1?Q?RTdcri3NBSBpYJQ6+xYyCti8JdGRu/BXlQm2CgwTcUj9QQmmb0lftxOWTy?=
 =?iso-8859-1?Q?Ea4zhz6md3Qc6aLhlLAmZK9rMh/Z+jbdrkxQssQdyN0qjAIkX/Y7o98JNS?=
 =?iso-8859-1?Q?nDJK+WEPGwsIncIWHRX5ReFRBucqGm9ozqggZ/o9LvkheaMrwL09/X+Rii?=
 =?iso-8859-1?Q?ueN23QCJRub9ZGmLR1QVNSmylceGI8DPGoeO+8TiesLzrqtS7J87MPnLI+?=
 =?iso-8859-1?Q?4tKhvGnkpt7kXOyb/pm0gpAWYTErC7a48vgyWMb7K8FbSLf5vb4gCUay6i?=
 =?iso-8859-1?Q?KqL59if0fjvQSEkhKnpXzoA3EYWIC0rdP+UIdD8qcgMzfDksdXsWh/6/5P?=
 =?iso-8859-1?Q?7F4xYK+d8ql3YMvIjhAN0h3QaTTiFJb3DIANxdujx6gV+Mp7FjUBwJP++7?=
 =?iso-8859-1?Q?Qy+n/YUJczLrLjle3njROIz31XUaTfDD2l44ax9EAG8Zkb2jHSDK85aAfU?=
 =?iso-8859-1?Q?1FmRaM3s6jIjkNe8PHtC5SAR6ZYFsjPvQFSzxPtbGqwLjaxar2P1rUKi73?=
 =?iso-8859-1?Q?d57UDYA5vK5uv3Ojjnc+1UDfmxGG3RDUWh+/toPIAn6VmWwXkhEOFTznsK?=
 =?iso-8859-1?Q?PzuckKi7SkCPge6eAsmLYjva/3vxDXFuC3om8OaFJaIqngyHUhePFoLzxY?=
 =?iso-8859-1?Q?87S80mJbALYk4HRluHU/atVnkX0doW7uHFS/w0upDcM9qjyMGeT5yYd8Tl?=
 =?iso-8859-1?Q?6icEJ2JSBzhn0zVZ9coKQKr7XlYSKcKbDifZBo/1LCGBP7uwG9hUTpHNK9?=
 =?iso-8859-1?Q?skuw10hZoiIGy8K8AJTG+n0px6U55xjL1Gz6p8QyHiKDtXZfwkC45zH1qN?=
 =?iso-8859-1?Q?UTz58k0QofpTSI4sV/kc9yXHU3bjv27qBzCS5/Kv4Vtc6yu4xkrIYNDAma?=
 =?iso-8859-1?Q?MwusweuHRJGFc/IfdoiDeSdaif/QR+V2ipJZoE8Kxnr4Z8sm6ZAMUzoiWn?=
 =?iso-8859-1?Q?7sgeAbvNcsiLlPf3ven70cBh4PXF9wgyZ9ShWfL1aw9jPBvSCrt4SSYSg/?=
 =?iso-8859-1?Q?G+5bneyfJZctctLp6x/MHwSMpS8Pv/eNNx6hZZQR9BPqq+LWVH1tkXJzg0?=
 =?iso-8859-1?Q?NgvBkdy5zvDy0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a032f-9223-48b5-edde-08dd07945f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 05:46:39.3230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LB0J7b0qzGyM9sqlgfRFfeCBIkVndPcYiWoqjWBZuYvfD7vrwJHDh2nT7taARO2wV++HTMM0PKDUWvlDjO7iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

This Series is,

Reviewed-by: Tim Huang <tim.huang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse.zhang@amd.com
> Sent: Monday, November 18, 2024 1:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Dong, Andy <Andy.Dong@amd.com>
> Subject: [PATCH 3/3 V2] drm/amdgpu: Fix sysfs warning when hotplugging
>
> Fix the similar warning when hotplugging:
>
> [  155.585721] kernfs: can not remove 'enforce_isolation', no directory
> [  155.592201] WARNING: CPU: 3 PID: 6960 at fs/kernfs/dir.c:1683
> kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.601145] Modules linked in: xt_MASQUERADE xt_comment
> nft_compat veth bridge stp llc overlay nft_fib_inet nft_fib_ipv4 nft_fib_=
ipv6
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink qrtr intel_rapl_msr amd_atl intel_rapl_common
> amd64_edac edac_mce_amd amdgpu kvm_amd kvm ipmi_ssif amdxcp rapl
> drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper
> drm_ttm_helper ttm pcspkr drm_display_helper acpi_cpufreq
> drm_kms_helper video wmi k10temp i2c_piix4 acpi_ipmi ipmi_si drm zram
> ip_tables loop squashfs dm_multipath crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
> sp5100_tco ixgbe rfkill ccp dca sunrpc be2iscsi bnx2i cnic uio cxgb4i cxg=
b4 tls
> cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi ipmi_devintf ipmi_msghandler f=
use
> [  155.685224] systemd-journald[1354]: Compressed data object 957 -> 524
> using ZSTD [  155.685687] CPU: 3 PID: 6960 Comm: amd_pci_unplug Not
> tainted 6.10.0-1148853.1.zuul.164395107d6642bdb451071313e9378d #1
> [  155.704149] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T,
> BIOS V1.03.B10 04/01/2019 [  155.712383] RIP:
> 0010:kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.717805] Code: a0 00 48 89 ef e8 37 96 c7 ff 5b b8 fe ff ff ff 5d 4=
1 5c
> 41 5d e9 f7 96 a0 00 0f 0b eb ab 48 c7 c7 48 ba 7e 8f e8 f7 66 bf ff <0f>=
 0b eb
> dc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [  155.736766] R=
SP:
> 0018:ffffb1685d7a3e20 EFLAGS: 00010296 [  155.742108] RAX:
> 0000000000000038 RBX: ffff929e94c80000 RCX: 0000000000000000
> [  155.749363] RDX: ffff928e1efaf200 RSI: ffff928e1efa18c0 RDI:
> ffff928e1efa18c0 [  155.756612] RBP: 0000000000000008 R08:
> 0000000000000000 R09: 0000000000000003 [  155.763855] R10:
> ffffb1685d7a3cd8 R11: ffffffff8fb3e1c8 R12: ffffffffc1ef5341 [  155.77110=
4]
> R13: ffff929e94cc5530 R14: 0000000000000000 R15: 0000000000000000
> [  155.778357] FS:  00007fd9dd8d9c40(0000) GS:ffff928e1ef80000(0000)
> knlGS:0000000000000000 [  155.786594] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 [  155.792450] CR2: 0000561245ceee38 CR3:
> 0000000113018000 CR4: 00000000003506f0 [  155.799702] Call Trace:
> [  155.802254]  <TASK>
> [  155.804460]  ? __warn+0x80/0x120
> [  155.807798]  ? kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.812617]  ? report_bug+0x164/0x190 [  155.816393]  ?
> handle_bug+0x3c/0x80 [  155.819994]  ? exc_invalid_op+0x17/0x70
> [  155.823939]  ? asm_exc_invalid_op+0x1a/0x20 [  155.828235]  ?
> kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.833058]  amdgpu_gfx_sysfs_fini+0x59/0xd0 [amdgpu]
> [  155.838637]  gfx_v9_0_sw_fini+0x123/0x1c0 [amdgpu] [  155.843887]
> amdgpu_device_fini_sw+0xbc/0x3e0 [amdgpu] [  155.849432]
> amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [  155.855235]
> drm_dev_put.part.0+0x3c/0x60 [drm] [  155.859914]
> drm_release+0x8b/0xc0 [drm] [  155.863978]  __fput+0xf1/0x2c0
> [  155.867141]  __x64_sys_close+0x3c/0x80 [  155.870998]
> do_syscall_64+0x64/0x170
>
> V2: Add details in comments (Tim)
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reported-by: Andy Dong <andy.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
>  7 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 3c89c74d67e0..e54f42e3797e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device
> *adev)
>
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)  {
> -     amdgpu_gfx_sysfs_xcp_fini(adev);
> -     amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     if (adev->dev->kobj.sd) {
> +             amdgpu_gfx_sysfs_xcp_fini(adev);
> +             amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +             amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     }
>  }
>
>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 43ea76ebbad8..9a1a317d4fd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->jpeg.num_jpeg_inst)
> -             device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->jpeg.num_jpeg_inst)
> +                     device_remove_file(adev->dev, &dev_attr_jpeg_reset_=
mask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct
> amdgpu_device *adev)
>       if (ret)
>               return;
>
> -     device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev,
> &dev_attr_mem_info_preempt_used);
>
>       ttm_resource_manager_cleanup(man);
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT,
> NULL); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..113f0d242618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct
> amdgpu_device *adev)
>       if (!amdgpu_gpu_recovery)
>               return;
>
> -     if (adev->sdma.num_instances)
> -             device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->sdma.num_instances)
> +                     device_remove_file(adev->dev, &dev_attr_sdma_reset_=
mask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 60e19052a1e2..ed9c795e7b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->vcn.num_vcn_inst)
> -             device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vcn.num_vcn_inst)
> +                     device_remove_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
> +     }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..dc96e81235df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     if (adev->vpe.num_instances)
> -             device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vpe.num_instances)
> +                     device_remove_file(adev->dev, &dev_attr_vpe_reset_m=
ask);
> +     }
>  }
>
>  static const struct amdgpu_ring_funcs vpe_ring_funcs =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..621aeca53880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
> *adev)
>
>  static void df_v3_6_sw_fini(struct amdgpu_device *adev)  {
> -
> -     device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>
>  }
>
> --
> 2.25.1

