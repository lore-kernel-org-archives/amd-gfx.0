Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A20BC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 07:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC5C10E72A;
	Thu, 17 Jul 2025 07:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1HMMY7Pi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D533E10E72A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 07:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI+gfzNYqbbmy9nieGRCRktnjyv1ypzdL+ePD0m7YOroCwVwQLtWaSCbAN36mQL4MMW7vt8UQ3ZOmck/lwZBIcG1oaBiNm1lCfyo6KQVFxgGnjOOmdj51eSPWBXWpG1Q12vDTFCKg1kF61rE8fy0AE5jzNag+AD9fUaT+Yw5ztEZbDA3rfz7R6Di6PQb3tbNHW55D8ptkCaZolV7OYL+DBfo6lyiPxQ9yvrhvTGCj/cfHT29V0PcwRFiCBHDFZk/6NuUdnRnb9E62cRGDDaoeLgamScgRGyCOHDAE+TMYFV1AOl2McRJ/JtAk0zAHI6OmiHJ/bUvPWWfJARWasep3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vURK8FWp3hinzAZFN5x3jyA6B+vfI06bmliHpsDvpNE=;
 b=E9urMB2tpwz7GpSVxCFO+Neps6bmV5XP97r8pV1+h1CtgWTtA35ajkFn9exFupLkhsKrkJUPVuTE45hAULjMJkrntcSSORMy+OfXq2xLayTOlEovZ7IIo6NmV3E1bxxIsTp7Y9jjHk1Lyiy2tcS3m4jBMWl6yZlzIjDWn0+Vi/NKZtso/lJwt/bbp4Wx3iWi7rj6lFpT+pFg+DgjS+quhouHbRblirEsJ+qkal3yzEC9x8flOtfzRkfXFb8OVtDEWjJdjLrIXE9a4f6enDLK0trV46oODmbtulLIxtx9aBGBYTxOnmPzxtIJvSpcM/E0vZ+NxefARv9EMYnR9n6rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vURK8FWp3hinzAZFN5x3jyA6B+vfI06bmliHpsDvpNE=;
 b=1HMMY7Pimc3Euc+/aUwTKa6fm9A8Ywiio/byqJ3HvbqvW81saYkk+bDa0e3juGH4Vp8vyyptQ2hR8VcH4AF2NZ3en7QvttX9AsiNnd998U3/bOL9lgykolpZompAlnaVXS046xPMKRQ/xVM/loGYvQceTf5Ps1Hlpb0BAHF68fQ=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:40:08 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:40:08 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add command to check address validity
Thread-Topic: [PATCH] drm/amdgpu: add command to check address validity
Thread-Index: AQHb9h25Gr2LXt8XNkyYxbA9UZyxp7Q13wuAgAAQEhA=
Date: Thu, 17 Jul 2025 07:40:07 +0000
Message-ID: <CH2PR12MB421543C50A14F0B85C5C7BAAFC51A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20250716064823.1272183-1-YiPeng.Chai@amd.com>
 <PH7PR12MB8796D356664839C1D5445032B051A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796D356664839C1D5445032B051A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-17T06:39:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MW3PR12MB4394:EE_
x-ms-office365-filtering-correlation-id: 49e23f41-945f-4fa3-3367-08ddc5052743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LmmYw3Hjah2eUjzEvcPF2IOe7ddyr+u9txmouceKOZbEfDB8gvtn/cNWWVlL?=
 =?us-ascii?Q?f3NFMBZaqU2MnZ7khOx6y0NaEvxJXCdImZcNQ7aXOyOm9F0h82c/YzZAwTbu?=
 =?us-ascii?Q?P5mQQnCqTQGZ2cWZK2CGc+p/HmW1H1qWEgX2aLuK+2p0Ga2x7zZ5SSWz+g4d?=
 =?us-ascii?Q?nmJmm9GkcrInD1AfRRPbB+CPE2xmfBG5TP9rnu3s+cJ9YG/GJtwHGvPiL0dH?=
 =?us-ascii?Q?GVy2uJ6YsVj+Qg1Ky/s43vrmmap11aYIelkqKE34CI43HsbVfMC69mdutxZh?=
 =?us-ascii?Q?HiET3ThKA6LnSusr8L3SFvRvGwk+QTMFxKTKC616FqimkDplEkEkZQjdRHJT?=
 =?us-ascii?Q?7sf/FXQZ6tZkII6Bg3PZpkbRtKtsZe3kWkg5qEnZENF/DFAYG4VGmZWcTux4?=
 =?us-ascii?Q?Hyt8kt3Z+a5mVu/YdQKUD8+M7zH6FFq46LncyO79F/zYTC9cqMNxPRo+tMgs?=
 =?us-ascii?Q?wMjJ0aHZvrmwarJmOIOFC0D2XrjQJrf40Rc7MfSyDuMJwGCm+I4fHefqP2tv?=
 =?us-ascii?Q?E2TBEmhnkzjQrbtjf1sIMCmbzvAZ8Ai8G39hYFk+uYigcakMB7CXv5meA/zQ?=
 =?us-ascii?Q?5VmZOTdLXeyLRRj/yWiKf5pE1l7IJVeXCV259TDRnJJAA9xwSpmqvnucpaEU?=
 =?us-ascii?Q?tRTDGeDR0e5MDYz1Ml3dDBCbijZNz439pgxOSHmlQpzazowBXAFN6+P82eGq?=
 =?us-ascii?Q?82+c12jxj59n3YsND7Z8Y9a/sq22D0YZt/lyoOyTX943bAHXqq1Frmani/vh?=
 =?us-ascii?Q?UVz3YXrxiNIJ4DY2Jcimue4kwm26VlQ4EkZ4hZA9t58/7jaDKw/xjhk3rwdV?=
 =?us-ascii?Q?DVKtTuBapjPP2plzory+fERpjvZ5J8REMeffKp0MCe2A78soQWmN19fXDWlP?=
 =?us-ascii?Q?z2MSNdQg6VnJAgCYC6pB3YmZ9FlswMRu0BCvSJC++uYR/tF0m0diU2ypHMDO?=
 =?us-ascii?Q?n9e163KK6Hcfia7OfHhncygnIBuRFljmB4ySJ3W3c0BoBEvdaVcnP5K/+a0J?=
 =?us-ascii?Q?t2K/2g5MdwJF5lD54h2N6uTDR4Cvsq2xO2yaIpeQ1IDRjTcvypmuRViZVZtk?=
 =?us-ascii?Q?PYH7480dnuMDmxUxNOECzNpkt5I5tLDoI0NXdsBF7u1se9VHuBsam3xp3If+?=
 =?us-ascii?Q?Z/W9JwR/eudtHDB1dZkqjXjNOz+ZYc0jMj6o15P5bnPWqSU17lxl461mvBJg?=
 =?us-ascii?Q?Xuc/5kuBXarRhayuhY+594aKYR3DzKrosPAq7f+umWFbhT8OT+Pof0VxV8dG?=
 =?us-ascii?Q?OJw4C70dbai46nD1+KQbiwRNiPZ25Y9/+Bw3m7Jrz2RAix/DE17p7SxxQQFj?=
 =?us-ascii?Q?nCT3qqdZIOSa4g0lHbUqjpGZiPyoNynVxnqnhn0mQ8ZuPvgbbwJ7ad/Ouu7F?=
 =?us-ascii?Q?BLV+Hqjcp/Z4yq/v4WOsDXxltM6tqfw8QrDafBaIrOrVHA01BZDlu8A7YFrB?=
 =?us-ascii?Q?Ae+LQfDpeKLe7NmwixAORNKguj0LjgEGfOaa4EPOUmSJs/5atv70nA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4E/GpNtbVNj94BqFor5YbLW+VjvYi0sBWoOl4YgJ+NXITZYYyVcUIdaWy+s?=
 =?us-ascii?Q?1hOBjtxm6xtDZaf3KE9yTddQDgVdVN27T1T8VdZ3WvrBZyzRk+xqyy0eXLKq?=
 =?us-ascii?Q?/VDqNjZUBpk36sBhz720rZ/9M8JAdFK7FFuTP/5WkrHZ01lA+IIC4Cc4PfKW?=
 =?us-ascii?Q?pZpXTXi3bRsunInC4F54QV294Hhdc6ucujOYugueuV2D5qxq/ysMLyctHT92?=
 =?us-ascii?Q?0uzLpxfttMyLyV0i0MQV1hSK1clvZMhQDFOKktCtbcvq5cnNW07kvBOFIclv?=
 =?us-ascii?Q?viIGXr4liW9SeGqkk1lh5NRd8jQRMh/SrDIkhJwJ+qzjsA3VsObdf8uSNpD0?=
 =?us-ascii?Q?gJFHlClAoScew/24IyXySn2aALsTExSC3CdB85d0f0uD1gPoJegOVqgBHEAU?=
 =?us-ascii?Q?2eq2bXXVRIPlbIpZUSZOZg1kfDFHISiSsHoQIlKBzGWM8IPFxzvg31IK5ER0?=
 =?us-ascii?Q?mAVzXhOgY1FpG9QsLjvHwNVUUcZGILl/R9THu/T1t5XZje4z6y3kVDJ8pG9v?=
 =?us-ascii?Q?67HK9eRRqaiBlmQ38LfZrwteVT3hlzoG3iSg/paMzlZRsEqhT4mZM9TD6TzZ?=
 =?us-ascii?Q?CyEAD8K+2OPmOHc6lK2hnaGqtanukjdyJBggPOHUcZM26jLkTlnGmwRwfYmz?=
 =?us-ascii?Q?pHQxLXzb+b5AvthOKLkPBnGyw7OGTPgb6rdh3HY/QaNQUdGmNsYygptTvse0?=
 =?us-ascii?Q?jcngzp3eMZU0RtOc6b5MSJFxQ4mM10EtKhOt+wacYTVF3WX7uI49VEVYM60V?=
 =?us-ascii?Q?Cagy8aM65qSxvw/VVi5gyreKxqzW1D0BQ6vEO4BeDBg/x8a+R5taizwoCnqS?=
 =?us-ascii?Q?NQxo17KSTtmyV9HJqad4rbvsN9Z0OBVwx0Eis655vkfbdUOjGHvUgWmq1w1y?=
 =?us-ascii?Q?XGjMs3tJMKG7g+eY1Xf+khl4JVKle+LKFmRggPRap3vg+hstHUBI2uvCjADZ?=
 =?us-ascii?Q?e29J5rgPXTG2R918vEFrMxYISH0Arcw5UdZNXNBlEm5Z31aNxZQ9BqWKmXzb?=
 =?us-ascii?Q?+stVhGYMfL0scmoX4eZtbTPClRz957RaOGyq9a8bSsr8o9WAocAzFBltDuzq?=
 =?us-ascii?Q?K46RbH0MbDlS3CmGKklM5/gTnmHbQqghtMNenPkXMJW5HqjZad+IaxoqRjhK?=
 =?us-ascii?Q?vFoxB5rs7lwzUIfDqiwlNHyg7kAqa2qcWGV8Wq+aldYk+6xzslHDwJFed4vi?=
 =?us-ascii?Q?qAgVttyXweMSXJxqI3fQJ+oul1lmAA/2+sdQOs9XlAu9EKRaCX1FIbHx4PLR?=
 =?us-ascii?Q?z4LfTKNc0rjWZ66Unw3jHpT0NmCyiaGZc88taPZIYrVyTp7cjyrputBGV2Ic?=
 =?us-ascii?Q?U45uDdKqHWIrZXaJghm585O9g23fYwAiT3j7odHILkxfyvUANsM/l5yg5SBd?=
 =?us-ascii?Q?ZvP7xLaVqQNiWsgWcutmLE0YCgtGkrJ1f72rsshh1VHtnr3W3t7e/B3HLLbV?=
 =?us-ascii?Q?if5uUbinCFX+fQaOyHo4fPdB7UgHMHHb6zutcPMAIkXCObL0CiZNFz/IjldJ?=
 =?us-ascii?Q?e+2khtNBXnYHkLb57zTcSAquH/iuB4npIJN15z/SVxzHdXjbFzrsDT7SEXo8?=
 =?us-ascii?Q?BOET1otxNCgZLUUby6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e23f41-945f-4fa3-3367-08ddc5052743
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:40:08.0369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JE6ZzCG7tfVTFhOKbkNVDhI9FfYnSGindLtMSRgySQy8sIPTpnb69rEA1/ofyc3Fge3tL+Mchap3Y85/DM5d9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 17, 2025 2:40 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add command to check address validity

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 16, 2025 2:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: add command to check address validity
>
> Add command to check address validity and remove unused command codes.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58
> +++++++++++-------------- drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3
> ++
>  2 files changed, 29 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 15bde4904996..68feec0956f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -163,47 +163,38 @@ static bool
> amdgpu_ras_get_error_query_ready(struct
> amdgpu_device *adev)
>       return false;
>  }
>
> -static int amdgpu_reserve_page_direct(struct amdgpu_device *adev,
> uint64_t
> address)
> +static int amdgpu_check_address_validity(struct amdgpu_device *adev,
> +uint64_t address)
>  {
> -     struct ras_err_data err_data;
> -     struct eeprom_table_record err_rec;
> -     int ret;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_vram_block_info blk_info;
> +     uint64_t page_pfns[32] =3D {0};
> +     int i, ret, count;
> +
> +     if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
> +             return 0;
>
>       if ((address >=3D adev->gmc.mc_vram_size) ||
>           (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
>               dev_warn(adev->dev,
> -                      "RAS WARN: input address 0x%llx is invalid.\n",
> -                      address);
> +                 "RAS WARN: input address 0x%llx is invalid.\n",
> +                 address);
>               return -EINVAL;
>       }
>
> -     if (amdgpu_ras_check_bad_page(adev, address)) {
> -             dev_warn(adev->dev,
> -                      "RAS WARN: 0x%llx has already been marked as bad
> page!\n",
> -                      address);
> -             return 0;
> -     }
> -
> -     ret =3D amdgpu_ras_error_data_init(&err_data);
> -     if (ret)
> -             return ret;
> +     count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
> +                             address, page_pfns, ARRAY_SIZE(page_pfns));
> +     if (count <=3D 0)
> +             return -EPERM;
>
> -     memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
> -     err_data.err_addr =3D &err_rec;
> -     amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
> -
> -     if (amdgpu_bad_page_threshold !=3D 0) {
> -             amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> -                                      err_data.err_addr_cnt, false);
> -             amdgpu_ras_save_bad_pages(adev, NULL);
> +     for (i =3D 0; i < count; i++) {
> +             memset(&blk_info, 0, sizeof(blk_info));
> +             ret =3D amdgpu_vram_mgr_query_address_block_info(&adev-
> >mman.vram_mgr,
> +                                     page_pfns[i] <<
> AMDGPU_GPU_PAGE_SHIFT, &blk_info);
> +             if (!ret && (blk_info.task.pid =3D=3D con->init_task_pid) &=
&
> +                     !strncmp(blk_info.task.comm,
> + con->init_task_comm,
> TASK_COMM_LEN))
> +                     return -EACCES;
>       }
>
> -     amdgpu_ras_error_data_fini(&err_data);
> -
> -     dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES
> AND WILL CORRUPT RAS EEPROM\n");
> -     dev_warn(adev->dev, "Clear EEPROM:\n");
> -     dev_warn(adev->dev, "    echo 1 >
> /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
> -
>       return 0;
>  }
>
> @@ -295,7 +286,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,
>               op =3D 1;
>       else if (sscanf(str, "inject %32s %8s", block_name, err) =3D=3D 2)
>               op =3D 2;
> -     else if (strstr(str, "retire_page") !=3D NULL)
> +     else if (strstr(str, "check_address") !=3D NULL)

> [Tao] the added check is fine for me, but I prefer to reserve retire_page=
 command, we can set check_address to op 4.

[Thomas] ok.

>               op =3D 3;
>       else if (str[0] && str[1] && str[2] && str[3])
>               /* ascii string, but commands are not matched. */ @@
> -495,7 +486,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file=
 *f,
>               return ret;
>
>       if (data.op =3D=3D 3) {
> -             ret =3D amdgpu_reserve_page_direct(adev, data.inject.addres=
s);
> +             ret =3D amdgpu_check_address_validity(adev,
> + data.inject.address);
>               if (!ret)
>                       return size;
>               else
> @@ -4103,6 +4094,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> +     con->init_task_pid =3D task_pid_nr(current);
> +     get_task_comm(con->init_task_comm, current);
> +
>       dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>                "hardware ability[%x] ras_mask[%x]\n",
>                adev->ras_hw_enabled, adev->ras_enabled); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 927d6bff734a..7f10a7402160 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -570,6 +570,9 @@ struct amdgpu_ras {
>       struct ras_event_manager *event_mgr;
>
>       uint64_t reserved_pages_in_bytes;
> +
> +     pid_t init_task_pid;
> +     char init_task_comm[TASK_COMM_LEN];
>  };
>
>  struct ras_fs_data {
> --
> 2.34.1


