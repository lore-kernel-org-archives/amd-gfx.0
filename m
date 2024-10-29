Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B25CD13590
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 07:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB3310E5BC;
	Tue, 29 Oct 2024 07:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3rMn48f/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7480810E5BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB4VRU8HDMBXitp/MB2fEks11DJM4WOqTWYoZysecLrJ42w8zZlkQLLe49hx8M6k6GnkltQynSmquictfU0prDY3D5V4QKqPvzXQVAXkp/wG/vXztt30WFUJfKtpnz+2JCpJPXDRjKIUOEi/edKcpbUKrk8oM0MeoUNEUFfnuroj7g2mD61Reozm2lH/34Ulh9UmCG6NhQjZTOrKgUZWvotI1ufQjtvmTmpUl70VN4wIdk+fRzJGNMEaeYxkNJpYpCK9yI59zj1hGKSRoLbI7Co0kMOPw8opBdsppmfRFiBLEms5sZp6Q9Ysy8on1y/DRfqdOfBoXIXwrq3bqqR5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtUb4Lc4mLnXWHQkF+++xI3BQss88ZlhV9Ja6EeWgPo=;
 b=dbqlat3cNSKY9D11oCCqu6tnttzlURcMFFznm5KQHMCmFnHupO3gv6/W/ZUELWp8ykJw4LK0yBy7aaoJutiuDBf3Kpvmh+T1fKkqrL+JEl+JJpwwsQO4pHYI/W2nDzH2V82bn87MnmDedRItNdnyKrANkgd+9Rv3rFhvKobNGW7tZYKPJqudYQhvLLZ22NKHTuLADNOZvAcO0WdH52hKAGkMxH0Fjh5lu21yX8YXePF0qYFUTb0csF8CFsFaqqdtg0etGrOJaaP6sdnLywnTeB7bXdYLVuPQrvDZUJtxcmkmszxfwIvzUUp3SkXM4PPtlF+r4sCPOqV7XzdoUH9N+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtUb4Lc4mLnXWHQkF+++xI3BQss88ZlhV9Ja6EeWgPo=;
 b=3rMn48f/RBcRkIh3AjpI8fAyny/6NcLndJ0IZ06Db/kioIxyE3RuKbWPjG4rF+2W9kpbcDa8qZ1xlTcAJanJGC9SMrlWcsh6nHlqnco2LpYD0t+UyLGCwxQGFshwqQgb2DGDHZeqbTMSDQP7thB8LeP9bePHCktiCPpZ2acsRYk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 07:29:49 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 07:29:49 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset
 mask
Thread-Topic: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset
 mask
Thread-Index: AQHbKdJH0unvMGZbjUaoAYsYrGbjCLKdVKLA
Date: Tue, 29 Oct 2024 07:29:49 +0000
Message-ID: <CH3PR12MB8074D0EE6E93D732F8E82A71F64B2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241029071447.3077959-1-jesse.zhang@amd.com>
In-Reply-To: <20241029071447.3077959-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a4bbdb79-8f56-4103-8129-05ffb5a23673;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-29T07:28:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MW4PR12MB7190:EE_
x-ms-office365-filtering-correlation-id: 9b1e6a20-dd9b-428a-34fd-08dcf7eb78b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aj+BDe+YH26yBODIZ3Q7vSX6+jdaqP09PDSGGLyyAr5N58O0SvpN/e34Ubt5?=
 =?us-ascii?Q?rhlLOeNjLiiYYrGWGgcgMhQf7rvQQVCdqKzAGwGvDe8g4Vcje5HO/dOeYplL?=
 =?us-ascii?Q?Nul07Azc71xE/DWPAf0CHKM+Hl0x9vcOSGLeh5sgs41UmYh4aPqJdQYWZ1pZ?=
 =?us-ascii?Q?9PdmFCuTYM7cuKJ20yJsd6q1dfJOQPcIfgSUKHDF4WnKnENSGTRc0wyAX0+I?=
 =?us-ascii?Q?Jum88kJ28V/QnfvbXZPIFoeMSZ2YrsUJS3icz2m2PcTXM23lpq+HQ6iOQm9Q?=
 =?us-ascii?Q?DESysmY9cko+8jPyn6NEc/ToSxkkRwg53i8RGyeRKwThUGYwclbSIvXiApo1?=
 =?us-ascii?Q?tQAy2sB++iAl8w4bj/iyVSvNzzhVFZlXFofPEDRN5aUtHmgJ3t5gOdaIUJHJ?=
 =?us-ascii?Q?A3i1rKc5w5KT4dSpDpPQwaLAtjxOjNXSRJPF+PeeP805CKldpF2GL14OWtQF?=
 =?us-ascii?Q?IZWmMbr+9aoh/jXXwEySBY2fvdjdTpa7fuBdXLmPxBFdH+G6TzPMgbIUgJGd?=
 =?us-ascii?Q?vt2H39TIcvsijnQQj0c98PePHY5bglHsX1aoPNOVcjkGzSDDl+IVw6Yc1o7A?=
 =?us-ascii?Q?rpdmv67x3q2G5aWOhiUh8b0buA8Ag6JvMVavQnPcBLBEgFHstQzhSvCmYcgY?=
 =?us-ascii?Q?UQIEzXkCGL1W6vFJBWMfwG9v7CQkIETYpi0IzjQSh0Mz6Ae0NebEy73UkDt8?=
 =?us-ascii?Q?bygz9vpL7cCnQ0n0a4uQXDtTTH/jJBqeUwxJoBLa5CwbW4GZxhUImP4YTaIF?=
 =?us-ascii?Q?/IAKOgWeqA3js6qEZrHYv2DBqE8MHOdkjvmjfSEnutyqf1bWFyz5HRoGc6pI?=
 =?us-ascii?Q?tz5/tjuf+KQnoZ4iRHlhDmCyHYwCotA5Au6agzdcg9yNuiGf9PrQwitLnNkw?=
 =?us-ascii?Q?AJSp6H6cYgYAhyiVQk5K9xZ7ostWCOQp7+dWoZ7O0lnvjNs+MlPkCJ34yJUh?=
 =?us-ascii?Q?+WxBG2D8KkgH7wNmaiCrqkGMA4DXDrEozYxGXrAnGNZ7TH13RnSEZkFvryyp?=
 =?us-ascii?Q?ehX9BXd14CFgvO1PhiMnceaT34m+GkesllKqA7OF2LW8CafmmBuXF8OD3V9H?=
 =?us-ascii?Q?m5KHQYrWAtjaKokOgd9cLhuuPTPrLGCiLB/4+oW34kH/J56DqqZe5/xMsy5H?=
 =?us-ascii?Q?XTTlLfrFIp+Mgk97Ty0seBMNU6OMEnKMLkzTVybquckQMjraPe1Ji+EYoEOx?=
 =?us-ascii?Q?KoEUVEB8TSvTjK0LVUWCz/aRAH8d8bD4HbF47vRunFFAlTczVEcCnXYV5gBp?=
 =?us-ascii?Q?8gR9etQqRwlrsoJADmJZrcv7TylU5QHvPelhmmtFqWIRK76yNZRU1T804AAD?=
 =?us-ascii?Q?ZDduFF7EwZRgePZyXBTmU1hTDF6bK/WiWI5sUxdGBozuZfr0SJQwMI2AjmzF?=
 =?us-ascii?Q?i1uZihQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PmyLvb9pmJbT0qBokG7fEBTegc3PZKvrxIRVF1Wc/R27CKfgHVd72QdXX3dX?=
 =?us-ascii?Q?Nm9DgAHvTcpt4FC6C1kM/2baX1ebppIbpw+YHpKNZu9UfD8+OpjjVpM/iTrI?=
 =?us-ascii?Q?AIHy9I68KOtBT4R+MrafZrn1USTJVZ0BSGExMmEz3nnrre6OPCbJgy71JPIe?=
 =?us-ascii?Q?LjhsQhpHWBgRrZaF8gGm3+F0LoKEcyGwqaDWobO13uHWxvTIgaLtfuGkV1OT?=
 =?us-ascii?Q?n4vuk5cu9r1wt+GuaNQGy4AKAu4WHGpABrsvb/zXmgHT3IDiQPcdv9J8RDJD?=
 =?us-ascii?Q?n6tVXdQ7DstIWRl6nSCILwj7luKium7XG3qsEsOkymtSooFSl1e4iYtG+0S7?=
 =?us-ascii?Q?0oMGpzOL5ySTOVauzKML08L6nE/41fBM/bQCmhM2En4FPz20WBsdeqOIYjsh?=
 =?us-ascii?Q?eoOPBV0AnTCwgCkYe6PIlhNpUUlwKCYz4rL0jpqMNnxk5I7Zx8nOGN7cmd4p?=
 =?us-ascii?Q?ntyFW2eZAgVueW3gxQAcoXxdKxIPsbjyFzh8ariRODVbGWsltvc07bJw9Z+x?=
 =?us-ascii?Q?T/259jadaypjMViP9sbu7+Evvpu0Q/RDnkbyQspDg3eKZf0J5BUi1he2wovD?=
 =?us-ascii?Q?BDdqRHBIL4EGpTxaeBxCd/G2B8tkY0YDYxghnU/t6NmOBWUb96E8iDiBKJ/F?=
 =?us-ascii?Q?iCT8JobQGz2fqSNcHq/uWdc+mybCzxZZUgHhZRdA2ZexbszJHhhlUVLEkx/g?=
 =?us-ascii?Q?gr4PNajx0VhL7m+6StAUEK3ROII9T2vznNayp1GvU5q84AZ+Ea0PWU0RV0SL?=
 =?us-ascii?Q?IDP88WeLBUoyOZzkFvc9TvTwJ4EqSizMiy7TdDXqb+41PEP+x1+eQ8IrM5n9?=
 =?us-ascii?Q?6Ot6IGFsjAw6tV28J6+IU1DZaQzafAxJS+AzBfUiBSELW7XHYZfHvrqDHG7o?=
 =?us-ascii?Q?9QEMK+KC1oHsT30Fry/C4Bm30Jh6rlAFgCELy14FvA7vc802LLD9PKb3T2OC?=
 =?us-ascii?Q?jE+HRqSFCdDmJjd3QcBErP03k+cc8CuAMIeWVIi6XUZCWZO0w1qc4D7QQwW7?=
 =?us-ascii?Q?ZJbO/dZ5YY/yZa1v+qVgWY8LOuI8uYl5APtbVi/V+ZpTsiBOich7F9PCH4kU?=
 =?us-ascii?Q?qAXJIyl6bGScZT9P3zQf82ZBXzBy6YD2STwOYQJkK1Tw0aWvGee8OCX78CV9?=
 =?us-ascii?Q?dGsG/Yufw5H45iUutOOQ/rvI2I2NS0zEJzCB/BbmeJDhotDPn20AREbib6r/?=
 =?us-ascii?Q?43M314bVm8qA0pYBzDnnDOZDVTiAJHgtHuKiU0ijHy5rcMAxDpVEdEtKLLWK?=
 =?us-ascii?Q?KOB9lpBTPk2nkOui5UwSHOdF1vj6b0HYV2WSg/8SHKGwllWli7dlzFkERkP9?=
 =?us-ascii?Q?tCBuJwVc516Bg/8i89igTGnsoD4GyL09qFvzoNVZTE1qDV4omoi8+W9fS/6z?=
 =?us-ascii?Q?AIj8Jm6rpbsj/iS6qC+Tk/+ZY7j+lMrC3kbTXDjB1afk59OpIv138R169T0H?=
 =?us-ascii?Q?8bBL9WJEgWunGraEUvX7LRlG4tkrEDcKAVVG6tYoPDVAOwey13MosrlCsGmy?=
 =?us-ascii?Q?Hv0R048kDYY7FkAvgOCO0pZlVsT7b1HewlMeLHIpxw9XhsdsncbLEgCizRpq?=
 =?us-ascii?Q?wY9xjuXEAV1vo+wATh4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1e6a20-dd9b-428a-34fd-08dcf7eb78b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 07:29:49.3876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GsQHDLeNpDH1CXsvLG6qGytWNIEWPUoVntHMQs3XyKW+4p9QiDbnXTPLTtJKKeVkUecYNZtkFx9erlNzwEZfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
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

This Series is,

Reviewed-by: Tim Huang <tim.huang@amd.com>

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Tuesday, October 29, 2024 3:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset
> mask
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Add two sysfs interfaces for gfx and compute:
> gfx_reset_mask
> compute_reset_mask
>
> These interfaces are read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc), soft reset, queue
> reset, and pipe reset.
>
> V2: the sysfs node returns a text string instead of some flags (Christian=
)
> v3: add a generic helper which takes the ring as parameter
>     and print the strings in the order they are applied (Christian)
>
>     check amdgpu_gpu_recovery  before creating sysfs file itself,
>     and initialize supported_reset_types in IP version files (Lijo)
> v4: Fixing uninitialized variables (Tim)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com> Suggested-by:Alex
> Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  9 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 23 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 17 ++++++
>  9 files changed, 184 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..aea1031d7b84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
>  #define AMDGPU_RESET_VCE                     (1 << 13)
>  #define AMDGPU_RESET_VCE1                    (1 << 14)
>
> +/* reset mask */
> +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset,
> +mode1/mode2/BACO/etc. */ #define AMDGPU_RESET_TYPE_SOFT_RESET (1
> << 1)
> +/* IP level soft reset */ #define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2)
> +/* per queue */ #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe
> +*/
> +
>  /* max cursor sizes (in pixels) */
>  #define CIK_CURSOR_WIDTH 128
>  #define CIK_CURSOR_HEIGHT 128
> @@ -1466,6 +1472,8 @@ struct dma_fence
> *amdgpu_device_get_gang(struct amdgpu_device *adev);  struct dma_fence
> *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>                                           struct dma_fence *gang);
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ef715b2bbcdb..cd1e3f018893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct
> amdgpu_device *adev,
>       }
>       return ret;
>  }
> +
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring) {
> +     ssize_t size =3D 0;
> +
> +     if (!ring)
> +             return size;
> +
> +     if (amdgpu_device_should_recover_gpu(ring->adev))
> +             size |=3D AMDGPU_RESET_TYPE_FULL;
> +
> +     if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
> +         !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
> +             size |=3D AMDGPU_RESET_TYPE_SOFT_RESET;
> +
> +     return size;
> +}
> +
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset) {
> +     ssize_t size =3D 0;
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
> +             size +=3D sysfs_emit_at(buf, size, "soft ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> +             size +=3D sysfs_emit_at(buf, size, "queue ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
> +             size +=3D sysfs_emit_at(buf, size, "pipe ");
> +
> +     if (supported_reset & AMDGPU_RESET_TYPE_FULL)
> +             size +=3D sysfs_emit_at(buf, size, "full ");
> +
> +     size +=3D sysfs_emit_at(buf, size, "\n");
> +     return size;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..6de1f3bf6863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1588,6 +1588,32 @@ static ssize_t
> amdgpu_gfx_set_enforce_isolation(struct device *dev,
>       return count;
>  }
>
> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset); =
}
> +
> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> +                                             struct device_attribute *at=
tr,
> +                                             char *buf)
> +{
> +     struct drm_device *ddev =3D dev_get_drvdata(dev);
> +     struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +     if (!adev)
> +             return -ENODEV;
> +
> +     return amdgpu_show_reset_mask(buf,
> adev->gfx.compute_supported_reset);
> +}
> +
>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>                  NULL, amdgpu_gfx_set_run_cleaner_shader);
>
> @@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition,
> 0644,  static DEVICE_ATTR(available_compute_partition, 0444,
>                  amdgpu_gfx_get_available_compute_partition, NULL);
>
> +static DEVICE_ATTR(gfx_reset_mask, 0444,
> +                amdgpu_gfx_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_reset_mask, 0444,
> +                amdgpu_gfx_get_compute_reset_mask, NULL);
> +
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)  {
>       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr; @@ -1702,6
> +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device
> *adev,
>                           cleaner_shader_size);
>  }
>
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev) {
> +     int r =3D 0;
> +
> +     if (!amdgpu_gpu_recovery)
> +             return r;
> +
> +     if (adev->gfx.num_gfx_rings) {
> +             r =3D device_create_file(adev->dev, &dev_attr_gfx_reset_mas=
k);
> +             if (r)
> +                     return r;
> +     }
> +
> +     if (adev->gfx.num_compute_rings) {
> +             r =3D device_create_file(adev->dev, &dev_attr_compute_reset=
_mask);
> +             if (r)
> +                     return r;
> +     }
> +
> +     return r;
> +}
> +
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev) {
> +     if (!amdgpu_gpu_recovery)
> +             return;
> +
> +     if (adev->gfx.num_gfx_rings)
> +             device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> +
> +     if (adev->gfx.num_compute_rings)
> +             device_remove_file(adev->dev, &dev_attr_compute_reset_mask)=
; }
> +
>  /**
>   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD
> (Graphics Driver)
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..fb0e1adf6766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -424,6 +424,8 @@ struct amdgpu_gfx {
>       /* reset mask */
>       uint32_t                        grbm_soft_reset;
>       uint32_t                        srbm_soft_reset;
> +     uint32_t                        gfx_supported_reset;
> +     uint32_t                        compute_supported_reset;
>
>       /* gfx off */
>       bool                            gfx_off_state;      /* true:
> enabled, false: disabled */
> @@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
> amdgpu_device *adev);  void amdgpu_gfx_enforce_isolation_handler(struct
> work_struct *work);  void
> amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
> void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev); void
> +amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  { diff
> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..e2b2cdab423b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4825,6 +4825,11 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       }
>               }
>       }
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
>
>       r =3D amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
>       if (r) {
> @@ -4854,6 +4859,9 @@ static int gfx_v10_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       gfx_v10_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>       return 0;
> @@ -4896,6 +4904,7 @@ static int gfx_v10_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       amdgpu_gfx_kiq_fini(adev, 0);
>
>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       gfx_v10_0_pfp_fini(adev);
>       gfx_v10_0_ce_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..ec24e8d019b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1683,6 +1683,24 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(11, 0, 0):
> +     case IP_VERSION(11, 0, 2):
> +     case IP_VERSION(11, 0, 3):
> +             if ((adev->gfx.me_fw_version >=3D 2280) &&
> +                         (adev->gfx.mec_fw_version >=3D 2410)) {
> +                             adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                             adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +             }
> +             break;
> +     default:
> +             break;
> +     }
> +
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
>               if (r) {
> @@ -1721,6 +1739,10 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       if (r)
>               return r;
>
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init (adev);
> +     if (r)
> +             return r;
> +
>       return 0;
>  }
>
> @@ -1783,6 +1805,7 @@ static int gfx_v11_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v11_0_free_microcode(adev);
>
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..f5ffa2d8b22a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1437,6 +1437,12 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +
>       if (!adev->enable_mes_kiq) {
>               r =3D amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
>               if (r) {
> @@ -1467,6 +1473,9 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>       gfx_v12_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>
> @@ -1530,6 +1539,7 @@ static int gfx_v12_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v12_0_free_microcode(adev);
>
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..94007a9ed54b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2362,6 +2362,12 @@ static int gfx_v9_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> +     /* TODO: Add queue reset mask when FW fully supports it */
> +     adev->gfx.gfx_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +
>       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>       if (r) {
>               DRM_ERROR("Failed to init KIQ BOs!\n"); @@ -2391,6 +2397,9 =
@@
> static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>       gfx_v9_0_alloc_ip_dump(adev);
>
>       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +     if (r)
> +             return r;
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
>       if (r)
>               return r;
>
> @@ -2419,6 +2428,7 @@ static int gfx_v9_0_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       amdgpu_gfx_kiq_fini(adev, 0);
>
>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       gfx_v9_0_mec_fini(adev);
>       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..028fda13ac50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1157,6 +1157,19 @@ static int gfx_v9_4_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       return r;
>       }
>
> +     adev->gfx.compute_supported_reset =3D
> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0])=
;
> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +     case IP_VERSION(9, 4, 3):
> +     case IP_VERSION(9, 4, 4):
> +             if (adev->gfx.mec_fw_version >=3D 155) {
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +                     adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_PIPE;
> +             }
> +             break;
> +     default:
> +             break;
> +     }
>       r =3D gfx_v9_4_3_gpu_early_init(adev);
>       if (r)
>               return r;
> @@ -1175,6 +1188,9 @@ static int gfx_v9_4_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>       if (r)
>               return r;
>
> +     r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
> +     if (r)
> +             return r;
>       return 0;
>  }
>
> @@ -1200,6 +1216,7 @@ static int gfx_v9_4_3_sw_fini(struct
> amdgpu_ip_block *ip_block)
>       gfx_v9_4_3_free_microcode(adev);
>       amdgpu_gfx_sysfs_fini(adev);
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>
>       kfree(adev->gfx.ip_dump_core);
>       kfree(adev->gfx.ip_dump_compute_queues);
> --
> 2.25.1

