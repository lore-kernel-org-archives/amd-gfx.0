Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C132C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 10:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BE510E2E6;
	Thu, 20 Mar 2025 10:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bDW6u696";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1726C10E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 10:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKFbQytyK2PvTWxJos5bYAu5GfESsEHBd3XylGveNkLfEl73LYIBLFbyvud7phDs36J3T16JP4WrY1GfZ/JGfAgYNTA208wARgsIMUs2w59XnPunLN/cmTvQ0MEhlSCkPzgA6/v6iiRH2M5mkzVHwwbWFlX2XPTnZuVUq2ZvEfpMtOTNf16rS9MqAeuesctEAFoaTm1ZlgcGax9MNp0G6/E1dazwWhsDlEecxbg2JOnvOaCYL20rL96Hua0ad9RdiLmQUO/wfro46rnRqlpnwjNuNE2YtSyfQ+98T1JVllY/4tWW55/ZYeUYW/kScOVKZLGarEAPUf+e3R3TzFFoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhY1YsbioHeWYl59PDiPyo533oC33cbvwqkwU++3I6M=;
 b=WjohZ85SJcrcKN0GayVz7fVyRqZurQWLZUg1OqRTa9urXMOrWdWa7n2vxsELqGvwoP81zCXHzTGsHSQAk8kDc+VzAzVDNwqbu/Kiopbi/nb9hWE8y9Cs/cHahuXexbkm+EMPF9DNrotgr9SEfGa+zM9Sv7MWivOmcuF+oIfzCZ+X7UYhfXx4gdIKvGCAegU5ijRZcw88ossIa7jSPQbHec4YlxN8bUNQ4dRg4qfWHfiBzYkiQdGhyOZS1kIJ8ZhQinf8PCYZyu5qs6wXHdhIhjdYte1AnZVXc1kwnOCYBjWp3WPFs5tWaZLLwzO6YtLWe67B5nATHAz2wuAL+7Zx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhY1YsbioHeWYl59PDiPyo533oC33cbvwqkwU++3I6M=;
 b=bDW6u696VkLRRJHfKI7hrjavTS2ZOjCfcllY1nGK9QMXkIWugyyt9eg/htPBPA07oVFb0V6CznN2t/VGU50LuM9CTeeX1XBulhmLfO/gRmC47/bRPDl7s+ToyZLzmGjKZxLP35ltAiXE9kHL105dmBoG3SzJX5OGJ3hz2z0nDCc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.36; Thu, 20 Mar 2025 10:17:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:17:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
Thread-Topic: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
Thread-Index: AQHbmQJr9HfkOltftkaKxSy7V+e3xLN70F7Q
Date: Thu, 20 Mar 2025 10:17:06 +0000
Message-ID: <DS7PR12MB6005C8AEADF30260499AB34CFBD82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <20250319190850.3899718-2-alexander.deucher@amd.com>
In-Reply-To: <20250319190850.3899718-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f20efb01-6e48-42c9-bf62-a64c8e8cd46f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T10:16:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CY5PR12MB6575:EE_
x-ms-office365-filtering-correlation-id: 0c989fe9-6f73-4623-c116-08dd67985e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wgUyob575Lxr7CM5/MXVdw06Pv/VJcfDRytJtD2rc93NeNyDbJ0ASI8iqmS/?=
 =?us-ascii?Q?ThEPZuy2A6zOanjSzz55vh5cvipW72Eprg4w9DYB6HFLnMZ81k5zeufM9M9Y?=
 =?us-ascii?Q?LwcA9VvzkR2dPBbDBeOx/KzJMFNdz1+g1FQLB479fzZge+d2ow7BIeHyLx3V?=
 =?us-ascii?Q?wK8UT+aeEFOoW2oJMRBsIAbIGlBhTp7vISYpm0v5BpDnQnluCvgcDOmg5/VY?=
 =?us-ascii?Q?LqM/CPefUwUPdl6DMCM/bCQ52iG4x8Mb1TzhcAYKPtYnM7l3mMuMRjQXmRfL?=
 =?us-ascii?Q?p/M53YT8jc/RDRyU9pTDJ3n8HCHmv4w/xggXP9t6rsoV19n26lOJcC0jlUi6?=
 =?us-ascii?Q?xPPTJ4/BAVAx3tI3dEAX2mF/IGsI4ZawbrayYbfGA691wEcFOJXQp/Y/uBq6?=
 =?us-ascii?Q?t4GhLDvPbxJHF7rLzLNw8H0OpjiGxaO8qLYOyUlvK0+MZuLMQmfRCJsuPHBK?=
 =?us-ascii?Q?d9hbPsWzVSe2c7+N4sFV0B6jHNZvEwiIaA7CVS/j87ZkU+ZE8V4eUON1e/I1?=
 =?us-ascii?Q?8B17tgSgxD+BN23rZV5BLE7FRmg56RvrlLkZtpptwyvY/+Ke2ItVjoxEH8lc?=
 =?us-ascii?Q?BJhg4ghy0iqRXtE3fJhD5XlcSwR/2LusUEC7sDQCljXm5AqkjgIz91HTuGRW?=
 =?us-ascii?Q?W9g1YolAxCfQ0rwmpuVGsraYa0XCYRHL3PHrdARAvsu/ODhU+t2Cl1wQ8/Ce?=
 =?us-ascii?Q?/+1KcT+wY8OOs0O3E6YlqVbjLDU063j6Z6XBZsuSltOlkaJ6mMZ0RMJK8F0J?=
 =?us-ascii?Q?GiEPoRwpf+PfmYImmVsTwhO6DV34FhODXhVkOmGhnhjFtCh6nm57WihHwfDR?=
 =?us-ascii?Q?gRPIjn+SwMxRCn8pxMaWLAFr+G2mdesaR9ADoV9UFI5EA5/0mpl/5iVfzvPH?=
 =?us-ascii?Q?dyNqsULmyDDZ0h0u99yxK83e6nMaQu9TK+wKhu1syq3sYX1pYpQSS2g6kLjb?=
 =?us-ascii?Q?4spKrmVqtfftRaRK59BVuQTPTBCSJL4kQh2Gmw6pIY3Dn2+tSh3syFXIHwH+?=
 =?us-ascii?Q?9yOqyFhU0V8wN35JP8W0VsRGA9R8pF4Bsuldir91j2ZdaBJojj2m71skvZ+o?=
 =?us-ascii?Q?wVZREjB28HPWToWuMmsFFn5BZ2m86Ma8r+SfrMHUpYQIS9VpQdTZjL3udbWW?=
 =?us-ascii?Q?vRzliv5QbJFcB90fJJ/dJdUOv1wCbiIzcRgcx5j7h2IQpuVS+GYzOJq/Ne9C?=
 =?us-ascii?Q?1s3vm0mYilVSUWLQtgjlxbDyDuYtMwuZx3T6oMy2hYYofjZfySLFKmZwwi8F?=
 =?us-ascii?Q?rlV/npubGUOA1IGdoUm//4ZRsaNhzXvFmlZqsvZ79+8YWsjr1PaakLSFmOq7?=
 =?us-ascii?Q?vJqfAPZ0MPzKcCrZ0x8XpaUjO07/INdl7DQ6Pce/6wltSOdlwaTqAcrNBPtd?=
 =?us-ascii?Q?xqhIDzsudqHlMtFiQfFYnJewSPYiyNrnc8Xo3Fjrc2sFdh+Qh5wnEEuegRBX?=
 =?us-ascii?Q?aMlP+dbqea+31eyiV2K3vlID6/lVvgNz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6JqxQ8zqmw1AGf5PhGvPj60fJhUifpYieBkDm3g337bLuc+VxiyX3AWHTXpL?=
 =?us-ascii?Q?+6NQZDPINHHQ97zKiuYnIH726YMKHMImLGolBF3r+XAWH99D6b5wbaWk9Y3P?=
 =?us-ascii?Q?Hxi3H2CtsbH8qmit9akDImxvPBM4MnUyjqSWeezGgC3s3niIPR/T+ucTWyqJ?=
 =?us-ascii?Q?pZF6/A1kOPoPJCZdsROUpm3dmBa1dJGRwg1plukaJAWnTG8SK7nKsaikwIPd?=
 =?us-ascii?Q?4RwNbCP4O6/QIkymkpw3ardliQwmyADUH9iluNwhErQPWtZz5oagAUcyWn2k?=
 =?us-ascii?Q?uAxfTV1e5gHriKBCBgcAVNl/lJKg6Cs+wfA4iP42lb8rfFkLJk/ZHEPY47Ut?=
 =?us-ascii?Q?HTPpu6QJJlUpQoVj2zNhjG86oO1wyYCoYqQGG+xBRjH9ztboAhjqrYuCV6fa?=
 =?us-ascii?Q?keskvNA1IQZ8zH2sDAtasllOUufnKPrCiT3sOhIPxU36ZA6t8jx9YYq+B0m0?=
 =?us-ascii?Q?7/nGZMJijLTsbk/kyQ3xbsFYwLgKNbV/wciNAFG92BQLq/FUCoRKzQAmdlPK?=
 =?us-ascii?Q?vfjW0zlbSpJHgR4IO/zaUIj4w7p6dcapF6Q8aor7pUfkbZYRTfeW9i/Ngs04?=
 =?us-ascii?Q?Sa1Qh+GXucZslOei/2v6MJ37QzlgWVqFAwvSxhAwD8Bho0Tka4RSsJz9IU/k?=
 =?us-ascii?Q?StpDTda80kGZo0IkowhYvXzCsrdcOL7+JnP3rjAx93g4WRMiFulxMWz7Q8FU?=
 =?us-ascii?Q?AqMDF4Eq3puzkiYw3z/Ln77oVn4+ebRSRTiHW8sEFKIjPsJqtimsl/+NXHQi?=
 =?us-ascii?Q?x+nyrvfJG0Z/6w/G5brFTl4rPYyfbUCLazNosOWAKqxNUVe8Zj/MhDLZz90a?=
 =?us-ascii?Q?mrjFL8r2MpLfqBT6u7rGAqGcBbb4cmKOmDfsoW4c3/Cni6d31J7eDRHin5u1?=
 =?us-ascii?Q?F8lTQLi6mBt/z/dSUmXN6kuZY9WAaCbI7Qwzp6/akvdve8tyDwEDaCO287/N?=
 =?us-ascii?Q?g6MIugAFIMTTPuItok1RhTN6MA1y5TZ6DMuJZ7qkz32cZzpjaSqvHl5C/FRS?=
 =?us-ascii?Q?EwzVPy7LZpvMRN3P6/4JsKZS+CmgkkaAGn2WX51mwOUyhxrBPokmRKfTlBOH?=
 =?us-ascii?Q?ofp7MMjmDTLKsjtclc+XdHzbTZfKBycDlFpptus//ONEIJO3+lzDr1HjwOXM?=
 =?us-ascii?Q?AxPC3ILQN/7rfUKtmvvuuu3Fz6BJ2M8Fp92CcuczhlGx0qmvoBH3ijaPPA7r?=
 =?us-ascii?Q?oh2/sMvBPHlS8J6+9fyOnV7aUzDoLRydfvLcxLdIqdzSqkVsffxR1GVSohYm?=
 =?us-ascii?Q?KfJ3/vMw4Aia4KbjuluFlUeYhoaNOrHNAVg8yYjOFzsjObZtm4jXEfaNe87f?=
 =?us-ascii?Q?tYANTDlYSpK8nKrEEzLvSed/ehbq+ENOIrkYNL8Ud4oSYKUEiaD/+znbNrnR?=
 =?us-ascii?Q?yyeAj9mxSANYwqcPjoLooskSoCHTKBvvZNC+PGSsrGUSA9PqNfzCNU5eyqzF?=
 =?us-ascii?Q?oJWQZH/VzWFD8F4KucKRVrJSjErf5sOZGK7gfOnB1E0rnQOMcQREumbyKLhc?=
 =?us-ascii?Q?piqJKbi+sg+8cL35P5Tp2/p9AwZXUcyI2o8i0ye3V6yexDi45ULEcQJGFlqp?=
 =?us-ascii?Q?3RoXM5Goap7iPwSC07A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c989fe9-6f73-4623-c116-08dd67985e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 10:17:06.6504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFttdSOEm7wX+qxPnGR9MQI/+Ly8HX0ZNk0eI3+fdDsAFcbNff9BpejatOjtruRL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 20, 2025 3:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/4] drm/amdgpu/mes: enable compute pipes across all MEC
>
> Enable pipes on both MECs for MES.
>
> Fixes: 745f46b6a99f ("drm/amdgpu: enable mes v12 self test")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 10f14bf925778..ac9b1708e20d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -130,8 +130,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>       }
>
>       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> -             /* use only 1st MEC pipes */
> -             if (i >=3D adev->gfx.mec.num_pipe_per_mec)
> +             if (i >=3D (adev->gfx.mec.num_pipe_per_mec * adev-
> >gfx.mec.num_mec))
>                       break;
>               adev->mes.compute_hqd_mask[i] =3D 0xc;
>       }
> --
> 2.48.1

