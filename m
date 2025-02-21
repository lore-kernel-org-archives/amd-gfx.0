Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4634BC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 06:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E1510EA23;
	Fri, 21 Feb 2025 06:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NphwnqIt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD4D10EA23
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFpZrnkYnmklLENwtoOxqzPr//uOzKl1Gc5p/EKaXQUtSw0/t+nRlB6Bnw3o/6cbL8CJmozZIR5RlGAKtOjHMeM5qMtQNkCkfLp2M0w+BmtN0tFvccdOnGA17ju/43LuI+s0LNHKC1dT95eojmqDD6sv34GlWm8Iha1IrjVYHXzOIU9FydvV+klnhZDnrN+IK+awfmEQRUtnbSq1+p+xsrJFKZKO2b3NRfo2aVeZUKBkDyzo2Qx/vQGa7AddTCkZ+Bs9S5VLaYkq9Z0TnHRZ63rWMogTYinPQIloMDrGp3sah56puCZbXEwkWGMmeO06UAqhsb5xIQLv/tvdRJVK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/XPr+or3rvETOeOfJKeexUVSvaIJJQBAtwduO+XiJg=;
 b=dc+MofE/+khSJY+4qaThyhdqcSd5Q4LdSBGZ7YJbZZJr6Y9SXRXwpBXj5vSMJIJZ8rfnf38o+kbhf6zBeOo8OUPgNstxkOhhEymfCNgSCin7EpRsdPd8WzOyig+bKZJQyioGJyJM8i92D+/Njke7Sgd+5cCF9fI0dt2TX2WCC2WDPlXET7q2Hm4zKKdCcs7M2RSN/Ru+Gjhq5zeMpdQUpgQXXqA9fiJpZFciKf2mffgA+HagQ59WxMWjxPRZm/W19G3MS10ssw8zvgCePi4o6c+JYA2YTTmrunEHtRQyjSWwXh/dJ95N+mQngU5in7rPas1pzccDVLPj+PTnay+YiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/XPr+or3rvETOeOfJKeexUVSvaIJJQBAtwduO+XiJg=;
 b=NphwnqItqbbSSgkGVlLHpOb/yA3/WO4rSDXDRZkfHfKtjYK6QwL2ATMwyi+9xuwtaWDJJw1zINBQOZ0kSUtzopua2oQWzA6s5tdiZHPVAa/SYzi3tUiRUKG1BCALenVO7sV1MMLd9u8wa8zI7mXfejBa7yCPAgtnFvw+8J+BYu0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 06:50:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 06:50:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbfqUgpac7AJfeDkyfVOHaip6rBLNRWzOAgAAAyoA=
Date: Fri, 21 Feb 2025 06:50:03 +0000
Message-ID: <DM4PR12MB51523034558B4EFC8C17A983E3C72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
 <CH3PR12MB807461B879AACBBEC58C137FF6C72@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB807461B879AACBBEC58C137FF6C72@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=724f0133-5a94-4a8d-af95-122650348d90;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T06:39:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB7671:EE_
x-ms-office365-filtering-correlation-id: aa22cd4c-23c8-4c2a-f3b8-08dd5243f7ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VnVokabCGAtRt2YrnDgp9YFx7WHmy60Qy9ayxnWU01Fls52u9BimFhC4sVms?=
 =?us-ascii?Q?FprvAEzWdL1f8Y8gFWMXWPuDUByBJVOMRNrNCV8SD7MOtQaNF0vUkerhhiI2?=
 =?us-ascii?Q?TnNBHEckM932nIHpaUh5hbL1lMzqNqxeP81sPR68IgOrwIkm45Tn9mXkmikT?=
 =?us-ascii?Q?O7lHEa2LdDV6AMlSVMS6i8Z1WI+TJWv75YP8AgkVHQsy6YXxtubA0QheKSYi?=
 =?us-ascii?Q?fs1ephRraDFc5ngj0t7BysQCuP2M44pYjb6P4iHB4EOJGLqFO0AiUA38qCKj?=
 =?us-ascii?Q?VwmnvPR1AG34jiRD4MBsav2PXTt6nGVvvDUYDFAFqQgQ9S8e3Z0qiNZ0WkaL?=
 =?us-ascii?Q?fXnzNuSDtA+Vxpb2d4pDiGqapV6ZbK6YEJ8oE/b5j1NsCOnNz3+4tWNaX3tW?=
 =?us-ascii?Q?YGSWV7hsQXKYABQhsLO0xiMNc/9fIRLQnIZ/RIV8ri6FgfKKE7FqVGyoP/FT?=
 =?us-ascii?Q?2M59pCWDHYlSX+9lZ7tF7bMGBvbs8xNDvVWHkXn6BSue38bBQb4VS3ua4Tnq?=
 =?us-ascii?Q?1bMgYirrDOSxKLHyXZFAclTC8DmhTNwmpsLw5aEljike3Y1GrytzdTZ6vluW?=
 =?us-ascii?Q?TnC76qbs0PXwa2sRie5518KQ71duhx5uG6R48Z2wx9Hcaio/3HSmA3KEJTw/?=
 =?us-ascii?Q?Q2bFCssHH9hS6i3tzT4usL6ca7ZaLdw/paPVIkB4kvoxDPJU8PqzHGpczP+Z?=
 =?us-ascii?Q?nYI+gPvKAsil+uMruv6uLVZOKhP4TIc9g5vgUJMalLwWYIyhdDZpqddhBu+p?=
 =?us-ascii?Q?z+Np9Eh2bdmpTVko/N2HbhbhQAWZdVjo6T3WPlQqkNQXjr/AlnqNyjPvOR7P?=
 =?us-ascii?Q?wstXV+b+LQGDpaZFRSBypeC/Pa240ACzzOIEvwDzDYfHhBJAtCDOJOqUh+gt?=
 =?us-ascii?Q?B4Ryv5m5E9NbErFQal6PXdMSr9aFobt9iv32PRP/wbcFgiLEk2KJhEvbHzfA?=
 =?us-ascii?Q?AyVRskXip+5vRVVfw6JepOnUq1Qf8f3LRMNuvykNauQ06QNGjC5xjAFyuw8J?=
 =?us-ascii?Q?oaVnCBrpCA2IQxHazCK4rMzFfdJpIIlLfswV8IFBJY1P/5oncZ9ecapVxV0A?=
 =?us-ascii?Q?8jHEFFXaEDy7Zbu86D3hooX73Fu+BBOT3oFkbiZkDodx+ngLx7cVHedguTR9?=
 =?us-ascii?Q?XTbeGw8mw7Os3kTxTkprPjudGJDCgWBbeQ4CkrtP/r08iTjwDSeR4ZJKbNwb?=
 =?us-ascii?Q?D1KXYBK9ZibbdthlmeN779EhpLsSkv8A1XYzsBCPdNs6+Zj+Mdn36iGe2pBf?=
 =?us-ascii?Q?x5c3TVK9tpox0t9yYCZq53TwTkPqZr++g1RgqGylCGoigFc0Bx1G8MzVZWKv?=
 =?us-ascii?Q?gDjlHdwYOInCuzPE66jlQMvK63pF/g2a+QwtGGJQF9FD2yGS75RhHYLbuMAh?=
 =?us-ascii?Q?nwomzgPxn+R/XU2ucMTekVsmp0apDIXB2KjKyR5Sihn5d2wSphVU4/dzCGoN?=
 =?us-ascii?Q?0RdNCLPq3AmuPgQzgVGSEatrOokRR0zE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wbrIelfRBTgaXIC02XNMszramRbMu65n+5aWNH9bDdSCh01CK+O7BtY7uRu?=
 =?us-ascii?Q?YIwdSiMWKAdQTdSqBqsqFkorKC9dJ3OWzuNHayOPcwCCweBq4yGByh+eYSQy?=
 =?us-ascii?Q?QGBnu3278PCEbBZF7NV2MybgjHiB1WlMIBRQt+2CYqNgS1HSEDB+pBJFJd77?=
 =?us-ascii?Q?pDecb2qO0bYErgr0gFPLH01Fyk5S8sZY3HUzg3qpeoAxSSi8+VVAj5WL5yR5?=
 =?us-ascii?Q?Gj6WUFlc1scOqkjypypZqtiRoWgZYRrlAisAghvphHVDRWIiejQ+z0dcnnA9?=
 =?us-ascii?Q?FRvSgZre0ej+o7cIibOXizfE6EtdawTFjs9llNDFnz4NFOlb9uXWdXPw/Hyj?=
 =?us-ascii?Q?WOKivFXjiUlLWz+4PF/jh2o9OulYlFXfx/Hkpr69FLaY6mJT2K9fvBNwa/Mu?=
 =?us-ascii?Q?0Xh+qRxY8ui/+Ordzfow8tNjw9en0IT5zAhoEa0Aw/HKtO0pFZkgVodkEkrJ?=
 =?us-ascii?Q?52cPLL8OxhAc1wjReHAwPFejwauKpN7AQwg1gzdV6js9NWMmTxO4Cidnw0VT?=
 =?us-ascii?Q?zZ4PvQ44oh36B8PuLcwq5n7PavNCyFls7Qw3iCPPPIQuAPy9QCNz4oHbJowc?=
 =?us-ascii?Q?k+WBBiPZKXMC0SK7ZQLmx+TRjw6zO6NR2r0MSKnlVu8rkCXNkjd+PlCeagd/?=
 =?us-ascii?Q?aj2GdHc5yVuZMrCEGjqK54PtSMBDMfj2hRbL9ROHcs9A7ukl+RHcPscWR7c5?=
 =?us-ascii?Q?PKMUMj8NCWfIG7Ig6g/kKt7WUVlbIvjKpTufOlOX4HqVDbO5Guxv0pVXKETr?=
 =?us-ascii?Q?0AL21qf4MWamgBRHdRT+Ja3gIar9XqomrwVrNohxF8hKNQBZEn7uBuReOq/w?=
 =?us-ascii?Q?ydVQe9EuaeNqUqrSl8Kw+8600MInxfzk1d23yA4YKZ+2QofviLv00d3BIv4/?=
 =?us-ascii?Q?8b58472vuXw8/gE3Gk9yFh84kVnx2mz3961ZXH+bIgJpBDe9/ElUBVSGOcqX?=
 =?us-ascii?Q?WMWMSC1srBdoKA5EMRB4gqvmJahAwQY02IqgyU6paex+iKpXUdRdmBgGHG8g?=
 =?us-ascii?Q?SUIAvDxOUscZ4b6c8qZ+ZgzTGx4xZDxFxclRtjEdBJ9OGUyIpv/fUtIipkTW?=
 =?us-ascii?Q?vfFl8hcpctxYk8z8q/5A+TrHH47wIIiHx0HL1Zsf71yOK7rZUIY5oWiVN9P3?=
 =?us-ascii?Q?2cj5mgIeJAknWjETVZmBX4sb35glWbVtBRTjOdOMFvUe5rfKgjENu8/d5BbY?=
 =?us-ascii?Q?SRQOHIxQ6saOGe6wYFqO1y9uTB6W6zJpIpRGeeLhxSsMidHMR2NVneWU2RIU?=
 =?us-ascii?Q?qyNkKVULHF1z25RXjqJilWOXJ/FGV1DnGcGUA+Tp1EmSn/YmsII8DNojg6Lf?=
 =?us-ascii?Q?rzoBJoXIaaj+vgcx0fhfAYkC/BJEG89WtpEHFW2WsAK9UJrqg0MGXu+/y5Iw?=
 =?us-ascii?Q?vChGp7ymJ288IiKDFpiPlkn9a8GBskAuo2Bct6NW1/pVfRx9ukEonvHU5pxS?=
 =?us-ascii?Q?WSYJGttnvYIzxiwGlRD1EiBuNCXM9O9mpadIMEoBHckO5dQyUJBWWcv30m0a?=
 =?us-ascii?Q?M2qCuGYByELyx+nSXFPxzKK7/WfLYaJUF77IyPk2YA0opWyvYxBHhxM5OHxy?=
 =?us-ascii?Q?Y5+Gcn1aJsZvSMyYIbk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa22cd4c-23c8-4c2a-f3b8-08dd5243f7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:50:03.2306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27J8YPOGnPshPiXKx/wUNuadnyrD1kIv52UUSz+Kvo3VhHAoQWDXh1qbCn30cIuFN6s272feEfGlsv1nCJifBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, February 21, 2025 2:46 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan=
.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse=
.Zhang@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> jesse.zhang@amd.com
> Sent: Friday, February 14, 2025 1:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Prosyak, Vitaly
> <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch updates the SDMA v4.4.2 software initialization to enable
> per-queue reset support when the MEC firmware version is 0xb0 or
> higher and the PMFW supports SDMA reset.
>
> The following changes are included:
> - Added a condition to check if the MEC firmware version is at least
> 0xb0 and if
>   the PMFW supports SDMA reset using
> `amdgpu_dpm_reset_sdma_is_supported`.
> - If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag
> is set in
>   `adev->sdma.supported_reset`.
>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index b24a1ff5d743..e01d97b96655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>               }
>       }
>
> -     /* TODO: Add queue reset mask when FW fully supports it */
>       adev->sdma.supported_reset =3D
>
> amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> +     if (adev->gfx.mec_fw_version >=3D 0xb0 &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +             adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;

So, we do not have SDMA firmware version dependency here, correct?
   Yes, sdma queue reset use pmfw interface, and it only depends on pmfw an=
d mec firmware.
    Jesse

Tim
>
>       if (amdgpu_sdma_ras_sw_init(adev)) {
>               dev_err(adev->dev, "fail to initialize sdma ras
> block\n");
> --
> 2.25.1


