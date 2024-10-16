Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C9BD2A53D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 19:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF2710E18D;
	Wed, 16 Oct 2024 19:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lh5PkHUe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994B410E18D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 19:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5477W1rIAsAWfkutFrIS8X7zyRu3YONAHhEpLBQThfBWBPTiIeLoqbUDwJzBQ8X3xUkdexpis3wqE+/tV9a/U2CXdT1j4OBWTUsmUa3NoEq6O9gmo2JtlJ3ZViUVaCcuI0/Bs0ZN2xrJynO6NKBcPE5dvpirY+Ml8gIbTxYd9GI/5eBV9NeBNBYNoli12P3rqCAqc/jujO8wEgBmeHjLeh0w/prq1a1gXl+WkTreaKCdE/D/3eTTnZtawUWP8fobpaCHoBkjpVed6/vyIlS914pFIBudkk7pXlAUsOnqD2Yr8LZf0pQ56XvehAtbRKrirI4wTWqThW4VHIpB5xjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yIscCwmoa2aiueX1l6JbSYk3u3eCwVvJImZaxlFAwY=;
 b=byt7btZL0qSM6RmNn4+vyijBT0htPINaxZDTHndk0C/1xUh9p1s4I8oty35VWM+mHI25Oq0A+vHUy5BtHp8r7cPYwVbASssbkqOpV7fpjQKJXQncY+oM8L5TqdQrdVLxjDC5fDL/WAjnSPWGqfAo2+P6bM6KY1JPlSs5uVpg60j3tDZ5Bmvzs2YHHw1LPIws2NAQwVLLZ3nGRI3KfHzh2ct8qd0b11kmnPXCXKrUgDJsy3HMsi8JJQPQROL1HveD99QFb6aoxNiH97P3agsmyHDX+lIMVE6RXyPDOvtVMocgl/pFXWU2vmeloOk+ijw/QcetgNAUAlQVjYUR+umszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yIscCwmoa2aiueX1l6JbSYk3u3eCwVvJImZaxlFAwY=;
 b=lh5PkHUe2vcUkgii4padjji5F0QKxuYj96dr9oJmeJfMy5Ak1AYkzCp79ks7oDxZwYSSWDrWakIA/1MVu4YX/aOqIx3j0IgWxhDZrPlgcwMMiBG8SEy1sPK0Wl9+UoIbI14QwQJ5K36pqv3XsGdQ6DbJ91vOtzinncVYrWqEGjc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 19:08:00 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 19:08:00 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yao, Yiqing(James)" <YiQing.Yao@amd.com>
Subject: RE: [PATCH] drm/amdkfd: sever xgmi io link if host driver has disable
 sharing
Thread-Topic: [PATCH] drm/amdkfd: sever xgmi io link if host driver has
 disable sharing
Thread-Index: AQHbH+RKsJt2e8we306Mj5ger89wIbKJvRGA
Date: Wed, 16 Oct 2024 19:08:00 +0000
Message-ID: <CY8PR12MB7435752CDBFDEF81C128F44D85462@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20241016155833.956478-1-jonathan.kim@amd.com>
In-Reply-To: <20241016155833.956478-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=24fc866c-efec-404c-9e03-ea0ec3f13003;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-16T19:06:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CY8PR12MB7217:EE_
x-ms-office365-filtering-correlation-id: 73795853-7231-4236-8fef-08dcee15da1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SQIkvfMCYgEr/n8cERlceL32DM30Eo0v3ttxdHIf5pWHlren8Obl3Us0k2z3?=
 =?us-ascii?Q?6WM8XRmJ+yFpsCyp7e5si0blMkyfFXb+n0Djp15GtBx67xuthDDSA87gaaKW?=
 =?us-ascii?Q?LT/35wNOmHh5jeZU2CcB3Ld0ZCkoLapXDDVPs2AObkBd2bAf5wK9MpDmxMCb?=
 =?us-ascii?Q?c8zdODGEVI5STszaflM4ZReg4wZv2bHe7GDDHa/tW+l3gzJjdSJ3+4ZSwqMh?=
 =?us-ascii?Q?olPi97MnDk68FDO/4myJwrQgKquwboDvA7D7x56/BCaQOF0svuDdvM9sNEnX?=
 =?us-ascii?Q?8zKXf8m26/b7oqiA46F+rx1DzN9IKVVzyDrCjlpQBpzQ7GgaSlaR40za4qYs?=
 =?us-ascii?Q?nn4vdOkeQ2S+aQRQqNEvAgyal4m/AlBHos/GLGTgq5iLMi9pjFRJitiz6Kr+?=
 =?us-ascii?Q?dF5Y9igAZQbowcGet7vmoPy0A7wePk2Dx0o8mRkb1V/P/VI7q85HwqIkBssL?=
 =?us-ascii?Q?n0h53i5YDv8sx//7CFYBrrDjULZ+S2Hg8110mqNKdahHMj/P+CrVknqtkPHS?=
 =?us-ascii?Q?QZjmgKLTpPdk+Lmfkp6GzIKxuB3DJdQIbzlprv616qBjXGZFf+pkgnCOPszn?=
 =?us-ascii?Q?aqCXUfql4OuxMiTUkAcQ1G2Ik11fgWomS+LUiBlpNwXi+ScUwj5mhRbMRtoi?=
 =?us-ascii?Q?cXY3CBtF2ktioiIvtVo6PZ62mBGamjyY168ZBk0cX0Y0LkPgfLnvqao10gVm?=
 =?us-ascii?Q?rzBlbWFoRHZuY9U7napb04iA3Eq+CSorw/DznurpbJrlLMTgX8JB3ie+qSH+?=
 =?us-ascii?Q?dcVqc9t4wvCm/WVWVM+me73KvC+JJuVtVqvUgRwYsWd/4TOk8+2ASzK2JFdt?=
 =?us-ascii?Q?Pu6XihL9C4KOmGGon575p22Xip6Dt3+TdxamTxkZXw2co23rl3yuoXkmj/9m?=
 =?us-ascii?Q?8JvBzLE9cvOVu65b8S6e44VkP7Qo0JC2eRMe5hQ7RakB2NQGLtfILLbQlvLg?=
 =?us-ascii?Q?Rx/JctVOsjc8iiEiCTsUejfOw8czQ4aEAJfA4IeZpHt4qJCSFnnxEhKXU82p?=
 =?us-ascii?Q?F9WIXsaceqhV/RnhkPKCsFBMmMLTEO6xg5LetOL4UbOw0FL63utkot8dMzgs?=
 =?us-ascii?Q?ZFzHLTAXYB4GSP3DHN+GhBjrdJ6cme1k8MjjZWsyG5gsJJoJC+8g0BxkkdCJ?=
 =?us-ascii?Q?nBNDTvQ0+yi+eByrORtt2WuY2ZQf3benWoDNtCMbPDmVT3KhEe2lYEyKM1VC?=
 =?us-ascii?Q?jGBfs1Lv7QygaXFPvAWjY5EqjlhE0eaNMGELkaOMIwxfeuUoHBkgsGbk943v?=
 =?us-ascii?Q?F2uolPRdUKeVbYy3kt8dTBWBKCZLA+vmkE+PYtveYcxUJn6Rbr6DUZZMqXhI?=
 =?us-ascii?Q?i9WfzATAEwZtD1z3vL0cbVBoySjvmhaXdYtkMH02Aw+7Ew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jilBG0G0y6ORi1d6RCmioUY3uDt33Z2ZKZor5wFfL5ynFwO0k6j5GQzm7q0a?=
 =?us-ascii?Q?1/PRTBDCSEFUGOChQIO2rnDZJwwLyoI9LVB2GWXZB4+ozHlz7+8fv5jtcNqr?=
 =?us-ascii?Q?pwCWLgAN35kMOlgMdzNSs3WB8mVRf+5qwm/11VcmJlnDr3WIdiQ3lPueyLkC?=
 =?us-ascii?Q?bnwOo2lu80zZrN9MZVBmW9XCto/py8O+qJ7Le4gthPwkGjprfSoh3WlClIDP?=
 =?us-ascii?Q?QiixXHcXtzbDsSvHD8fAgMPk9xJhKqdzOJC5ppzgG4J8k4bnF9RI2RwJ9l72?=
 =?us-ascii?Q?oIFuC9SRCzLKapuV3nvqo/5DL+8hSqMC0xyJswvOottp5SJ6gDDylJlcHdsE?=
 =?us-ascii?Q?HEVbDXtZwyoz4pnvKpkRHpM9l7lwaGgLQMNd/qS82jolASHDShPBHqt6/Lwz?=
 =?us-ascii?Q?QC3ssFGDrcyHH7GAqjfhS41EJngYjjkygt9H+r4DaiE5voh6uIeV5jcdkV9z?=
 =?us-ascii?Q?b5sQeiBxw51H1SAaA0WU+LdpCJgj4RKGFH0JUBGdiZHOM109sbIOdiLHT/cF?=
 =?us-ascii?Q?LO+Kv5DE38a/QmRUcyrGE/u7cLwkQWppo5ul/EeZlNJfvfH4s/tFcIz5Ln/m?=
 =?us-ascii?Q?81A+HQi1HXPBoOplHuNw8ruf1bJu6Xx638Tc9UTYdsPTbFTqgyKF7q/V7imx?=
 =?us-ascii?Q?/LWHGcjC2BuVLHQQKTZuzfxQN6NydiMIk1yG7g2dousb4GTdAhq9ZifzYmo9?=
 =?us-ascii?Q?TN+xT3r+PotsZ7HEJm8H37acvJar/aQeDQLlQxymvsRETA3YG+LQ0dPKWxTG?=
 =?us-ascii?Q?u2TOgQYy0DZMjcl7gRchCHHVfPrY9VxPvhaPn6+B8REWuqNyGPdH0BQQ0ixe?=
 =?us-ascii?Q?4BckMcsRXKLHje3DEoruKUOmlrAy0ahNvJjbhM+2/BuAeUCBgROOxhv7mGTV?=
 =?us-ascii?Q?jaVzCM6TnpK4uXD9/Pu7OolMy7s/PysHzhtCSGYRQiYET409uHvXUR11Bhgs?=
 =?us-ascii?Q?KnuQw/shVdmS32vpzE3bZ8k9Z26TphmrD7xgOacNLC3BmQyagKjpbgDgtlOo?=
 =?us-ascii?Q?XxdjjZ2MFboSE8BSXisiP9yKAlkSTskx0M1NGOCvIoDDaFX5FHnvnLn5nzmr?=
 =?us-ascii?Q?tQYEh94rPMGjysf4fjcTWg6Joo46uSBJjHXyJ2op9RKpdPDkzv96XWEdKf1B?=
 =?us-ascii?Q?M39wf+0crRofiH/qasSO2Q4oSZu1Ged1O+QucsHaVCFsttdn/XlXp5Z20tGV?=
 =?us-ascii?Q?G4TdYwuBV8meLSe5/uGsqBq/TxJbr+THFpw4mBDonUAaojwjek4AGD3mAojh?=
 =?us-ascii?Q?wSpdlwoWtNkltxxAtkBbg32GTYLn5Dk72Zgi9W1paz+RbtRR2b2a0Jr0IOBt?=
 =?us-ascii?Q?dUuxyIuIdgdOLdSaqUvQ181Z15TH3yXtAVJ9V0wOz3ZUaabg8iltCvXSZsYA?=
 =?us-ascii?Q?M8U8cxfzry4p/7UfYDfZIzOgbjExLBo80YgA4N4SdYdyIfgqCA2CwTjX1mQC?=
 =?us-ascii?Q?Heki2mEX/WZElWQmTyztR4p0r2Bb7Feqy6ZkOMIl/33wnXqxpA2vCX2zeAaz?=
 =?us-ascii?Q?nMHNYYZ22uAlseW87UPkd9RmHiXoHhz7Y4dS7IcNO1cQGRt/1tOq/aQ9mylW?=
 =?us-ascii?Q?5mxSMxHN0GMODWytcpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73795853-7231-4236-8fef-08dcee15da1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 19:08:00.0676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY8zzvgFwvxoC/49obzxz/FIjuokArVWImhU1cZTH9bU7FUJjlY9C7iNP/2kVF13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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

Messed up James' email in Tested-by tag.  CC'ing James.

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, October 16, 2024 11:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling, F=
elix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim,
> Jonathan <Jonathan.Kim@amd.com>; James Yao <yiqing@yao.amd.com>
> Subject: [PATCH] drm/amdkfd: sever xgmi io link if host driver has disabl=
e sharing
>
> From: Jonathan Kim <Jonathan.Kim@amd.com>
>
> Host drivers can create partial hives per guest by disabling xgmi sharing
> between certain peers in the main hive.
> Typically, these partial hives are fully connected per guest session.
> In the event that the host makes a mistake by adding a non-shared node
> to a guest session, have the KFD reflect sharing disabled by severing
> the IO link.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Tested-by: James Yao <yiqing@yao.amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  3 +++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index fcdbcff57632..1d50f327eb08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -801,6 +801,23 @@ int amdgpu_xgmi_get_num_links(struct amdgpu_device
> *adev,
>       return  -EINVAL;
>  }
>
> +bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> +                                     struct amdgpu_device *peer_adev)
> +{
> +     struct psp_xgmi_topology_info *top =3D &adev->psp.xgmi_context.top_=
info;
> +     int i;
> +
> +     /* Sharing should always be enabled for non-SRIOV. */
> +     if (!amdgpu_sriov_vf(adev))
> +             return true;
> +
> +     for (i =3D 0 ; i < top->num_nodes; ++i)
> +             if (top->nodes[i].node_id =3D=3D peer_adev->gmc.xgmi.node_i=
d)
> +                     return !!top->nodes[i].is_sharing_enabled;
> +
> +     return false;
> +}
> +
>  /*
>   * Devices that support extended data require the entire hive to initial=
ize with
>   * the shared memory buffer flag set.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 41d5f97fc77a..8cc7ab38db7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -66,6 +66,8 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device
> *adev,
>               struct amdgpu_device *peer_adev);
>  int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>               struct amdgpu_device *peer_adev);
> +bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> +                                     struct amdgpu_device *peer_adev);
>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>                                          uint64_t addr);
>  static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 48caecf7e72e..723f1220e1cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -28,6 +28,7 @@
>  #include "kfd_topology.h"
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> +#include "amdgpu_xgmi.h"
>
>  /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
>   * GPU processor ID are expressed with Bit[31]=3D1.
> @@ -2329,6 +2330,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_i=
mage,
>                               continue;
>                       if (peer_dev->gpu->kfd->hive_id !=3D kdev->kfd->hiv=
e_id)
>                               continue;
> +                     if (!amdgpu_xgmi_get_is_sharing_enabled(kdev->adev,
> peer_dev->gpu->adev))
> +                             continue;
>                       sub_type_hdr =3D (typeof(sub_type_hdr))(
>                               (char *)sub_type_hdr +
>                               sizeof(struct crat_subtype_iolink));
> --
> 2.34.1

