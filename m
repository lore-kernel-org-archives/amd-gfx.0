Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AEAC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 05:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A491610EECD;
	Sun, 28 Apr 2024 05:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwiHkcFU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C75F10EDB1
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 05:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTgWUdPuM5XG3EPFFNhA/vnWJHOMP5+0BaW7VXMxcNmCuaV2Ny5Uydk6g1basviAsfzu61KZTXhQSXU6ZDQSjhskarjjh5/wsJ78eKY5P7vXhDWYq7PqFdM5tauOPCI9NpZrA4DfIycIOM1snZK9V0RVDnj5/5qZo+L9hidp4TwDt2bIRqskm6ZD0Zrb+vpNxCzyqdKCJg5dxN6xYz7B/42Qs2D2Bx7SSeQB2eAXTRivCvHs/roz4TLpXjNohwqPbWUccSX6p9Kr824aHKANyK7gZQxvKtIRETy7ZM6BZkUOADY23xKRhYOeAPqY6mVLbIVPf/BDK+2IHEgDwBThSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL7FNqtXgYvv8lUlEqndfEzqxnY+PjzHRDypbLo0KlU=;
 b=WjoASNSNk5+J/l0ajzU982JSvPVYRK/ihYfNtaAVn3owYn17ekujKQ44YUdPiLulqKVg8DLoxzQ1PHGIzGW6mH/8YbfKu8sC3qb2IDXDaXVlfrhz2+TQMbVWy0APKxS2+O+b7ZXJwAPwjJlDfm7QStj+f7X5ByjOy8YMhGJHhZENN3K3kJBGN0nyUTQKhITbVRsJRqK7zAPuVl22OulMcryRLUNBKYSVt5VhrxSv01CIb0Pl+WqypFySiuw7PU/m6dOzTsc91fesq91D5FaXuBLJG0nmsX/qFgRv6ddO9o1qHt5GkQeWldQmjQr2/IZgJ29kMSx2ncUBJw+EeV3DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL7FNqtXgYvv8lUlEqndfEzqxnY+PjzHRDypbLo0KlU=;
 b=zwiHkcFU/gub8/97IQEzSHdnZ535CKbZivW+X6BH5/5o0+k8GPbwAPB1fKnMVct39oKn4ej6X1MBNN7BOOAoWpgMKRp4mkIt95N2HnBL1olPkSY87VFHbXQT3k8b5tEiJnsjljQdzGqD/smlSqWBsFf+JMZY+Q2fU/N/D0GaLAc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Sun, 28 Apr
 2024 05:37:55 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e%7]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 05:37:54 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
Thread-Index: AQHal7+H6Ah9mIkbW0Wsupio3CNDZ7F9GymAgAAQc3A=
Date: Sun, 28 Apr 2024 05:37:54 +0000
Message-ID: <DM4PR12MB5152E18F8B3F16D52FCA47FFE3142@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240426095243.1075290-1-jesse.zhang@amd.com>
 <CH3PR12MB8074B30E07BEC18FAB4686CBF6142@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074B30E07BEC18FAB4686CBF6142@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c78b9bf5-e470-4bb4-8016-b2e7bd9ac8d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T04:22:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH8PR12MB7376:EE_
x-ms-office365-filtering-correlation-id: 49bba471-174d-42a2-de20-08dc67455a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tct6A8hRYWLyr6QxkXdvaJRRzZYJOjtp8/XxWG0aO38VWVcyEuC57aJSZpY1?=
 =?us-ascii?Q?evRuvJ/ta2GEgVkO1A15PbbXmm4yhte5C3i6ZzIURDWq1Z9F1MSEALAruvHO?=
 =?us-ascii?Q?5oHHGjzyVJ2S1wOZbr98ZvhSvOIrCuHS4bBqB3qh6zWlhRVTrmdf3106zcCv?=
 =?us-ascii?Q?nsdtnpU/lHywb2sL7xJRzKb/dX/n9dTm0PPlTAWnSrH4H2e2u0zarRAHWRQD?=
 =?us-ascii?Q?HWHjPr4AHythwZIKVaEewExFBcZDp7BTVza9jo9SrRyOb4rGb1NfQzFAiuyU?=
 =?us-ascii?Q?X3jl+DFT2UvSbVrQCIjp5O0nmCbkA9sEx6Umr7bGywVpu4nYABB5omUbh+My?=
 =?us-ascii?Q?AweklwVSIYkaaTd8KytXDmLS9F3Yq2T6QZiaB9P2ORi02nRl21s0s9OEAv/9?=
 =?us-ascii?Q?ndoiq5/0za0edKYdPXAaZnIhDlEAm9Mr/rMwbLNn0S8z51d34wvf4YTWphMI?=
 =?us-ascii?Q?VPCWzNiydUp000Alxx9oE9MMhsuQ+YETVJHyJHO5MLTJT3yXI/Ud+fVwVk1U?=
 =?us-ascii?Q?Q+OI8LjiRCDU9pWLjZV+KX8/00yPorpo3u1+QpFlEBmWI5gfWT2vqjnBtyZ6?=
 =?us-ascii?Q?hoc378qj3ofxDx16SdO99xHcEubagP02opssO3n4QSBo6lIZ0FKSfElLADYn?=
 =?us-ascii?Q?YxN38v2SEyPWesumj6UD1iYuQKDwlOdPurLxRHvUOSMWF8uduc1MscjujX7Q?=
 =?us-ascii?Q?A1F+4SO6pybMv8VP14eteuI9WknZ+0rt/lQD696TngB/oZAeSbAdDSzJJfBk?=
 =?us-ascii?Q?CbahLj9hHD7rpcLP17pbNTIPAoXLg9gYYbHPYLhS95NZlc/8r0DHm/YGoAmA?=
 =?us-ascii?Q?Kmb5Wl4oLdqjOkmJZmuQaJcl048bTLGftlqYNf3jWQ0XCRLg7Tyyzkvx0Phc?=
 =?us-ascii?Q?PWaqNDwLU7tRE9xSfhkKoZzu9Icnf2BMosga2yLjrSBP7OWmxNhCw5LE1MEx?=
 =?us-ascii?Q?Sxq5rr4F0+GE0K+tzguVzX077qvZwxDJYJorqbSABgtmEXwzFJ2IhRjF+U87?=
 =?us-ascii?Q?Ns7yO3RE0kAkmkfYtUWvDyd1cEhuRRIijyo+2tHnLFBirtjmsTxsErjzh9oN?=
 =?us-ascii?Q?ampDc1KG1CA/abj+UfWx7SeavTl1+Q8+KActYoTJzd5Ol9tullTUBYsRC8zh?=
 =?us-ascii?Q?myLBoQU52dfPSsJ+jdLQRm+v1onmqnU2wrkzXSyIVrnDoIU1fmRS2LZPYXJu?=
 =?us-ascii?Q?DeerxHe+43F64mTNcBuwrfI9CcUCBXBXjeIoHBtxr2v03cgLjg0fhz6/QU0t?=
 =?us-ascii?Q?j5Sm9aUjl/oitaQ2hGURkL6Mk9NTIKXCjr5DoTYoO2FFI4FBTrntpV9SSWuk?=
 =?us-ascii?Q?pfj2+U0LsSiuHqAL9IPNm1Yfg+coROoQCEK2Q4Lyun4diQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uv6BRbgr3P3HaYFdZv6zGvKDGoktAvF/DqBr++cY9lZUqZWlo3ycpE5f02Io?=
 =?us-ascii?Q?incGw5s82jA9GBXfpUWQZr3RfMdBuYd5LsFxShSgSNXPsC7XEKqr+oQvZEeH?=
 =?us-ascii?Q?oOSBlBQvriN5qaO9cniUJOqbKgNzQmaRGh+uzx7owIM6YkepBhAcef31QFO8?=
 =?us-ascii?Q?E1s1217UChMRIlWtQOeIVdUTTWrG/NekUnpYAczPjvQ2Fxg7vdEwDxwEas9O?=
 =?us-ascii?Q?RWQ96skcCrKrhytTwyNhL6gMjwwju1xzATs0Ii4ohypzMA3LAY2+PHUPGjEg?=
 =?us-ascii?Q?CQFKxlTIWncUUAuiH/dlGzm4PN+6QlLWZfqT+ft1tNi7kA+0skqe3NJWlEGt?=
 =?us-ascii?Q?CyEcItibapOoHBHIG6MxR+PhUoyJcNxoLvM5cj6OcshH+MSZz5ptc8RqZuLh?=
 =?us-ascii?Q?LQ6KSNNnyFs7odY4/NGIHfXbjJIyHx33x8Wxx2EznqjmHD8kR7NI+ybj4fkI?=
 =?us-ascii?Q?HFBLpXfcotBKjPgfAH29lY6hFhqF8/e7pVbJUsgFX+CJjS28pMdvKf7/Wba4?=
 =?us-ascii?Q?D4U9CiGAQqyDmanJgKr0T8XWHLX+7+xwzBkntZVhxuWZWzRcQDwDWX2zgqtY?=
 =?us-ascii?Q?c50qBnb9Z1MH2cnJkMCFdnZ34MpnhOTGHb10AY06VJ8Irv7VmG/rE/CBAH5k?=
 =?us-ascii?Q?keI0sksAibqsGmC/USovi4/QC21Rhhxwa3ZYPc+obpvTXKxTorFwgGlyZS5i?=
 =?us-ascii?Q?ShQONrhKLC1W/YYAAW9u9LUdNcT/FAfGf+lhKuaKg1kRSg73sUUInzo1ILHh?=
 =?us-ascii?Q?4YVy1dtXpRIPeLZCZe2gXvWe8E8COwdu5Tfm4ff8HOxHUfi0Enb81/BUkuiK?=
 =?us-ascii?Q?cclCx0FZWktC9SgX5ni61FHFsV+Gfm6lNG0rCPnzhhFoOTEAPzD6tw6QhnDL?=
 =?us-ascii?Q?gmJcmOKtt5AswS6HN44qg+T/pc622AFTqsFZk1WMJrvR1H4yLrnZ1H23/E4M?=
 =?us-ascii?Q?4PPseduzhDsbI1RQl2a56of10no8vWhnj7mRW3O0wtTH1n+CD96DvBLoUNve?=
 =?us-ascii?Q?J5XyPNtwFURa2DkgDYavbfARa3sVZi05IQendjhEHSnBxok/WSNdjy7yTs9v?=
 =?us-ascii?Q?cvTO6ck/V4ky1tiJtYAcnPGkoUPtUVAJrp1/O1SJRg40rJ6fJWMupGYniazh?=
 =?us-ascii?Q?eNt8vipKJ2KDUUGiEcswxCKb2Qsz1aSQA0/p2zuLC/6Rh2XZqQ00Q0xJ2d4h?=
 =?us-ascii?Q?15SG8UVmsmhYkjeTlXNTYB9cqtDLas/qP41Q+kdfjrm5gZMzVtx+s3PyTJ/9?=
 =?us-ascii?Q?wOzslGTzmKsDEm7ra1xOdJGG3zxsfuMmSggrNQMzRg/InjQ3veyOUBOXcaYk?=
 =?us-ascii?Q?kGKKmc3WRG0GcyyRSBDGE6L1ITiH23o7B0h7pOXZMDYhiB7mv2y+JV8WOzia?=
 =?us-ascii?Q?2YjUpfJakidVNKJNz5RZD2USv3vMswHBw0q1J8eRtLmn3s+YsAe1Klz/n6hb?=
 =?us-ascii?Q?mLmg1d35aoDq7/I2ljuNGw7gd5z4hCY4yy59s4A7wpt7hlVwSa4nrVCbKoHh?=
 =?us-ascii?Q?SIIwEQLwEe6mLd/gU7CREBr+caunO20O+JZfKEo55uuBtuFaFVMSTyp4q2XK?=
 =?us-ascii?Q?qJ2LQOvdPCNsgH0Mi2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bba471-174d-42a2-de20-08dc67455a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 05:37:54.6684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw+k8sIZ66vUHdS9X2A3zGcufXh5iM3kFrLMLZHcxcLzQYdxCcjSWtC5aice9LFbW2tU+0EpKWwnQtaRTF5Mqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

[AMD Official Use Only - General]

Hi Tim

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, April 28, 2024 12:34 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jess=
e(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning

[AMD Official Use Only - General]

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, April 26, 2024 5:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
>
> Check the return of function smum_send_msg_to_smc as it may fail to
> initialize the variable.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  8 +++++--
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++-----
> --
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19 +++++++++++------
>  .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |  5 ++++-
>  4 files changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 02ba68d7c654..f9f016cb60ce 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1310,13 +1310,17 @@ static int smu10_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D sclk * 100;
>               *size =3D 4;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D mclk * 100;
>               *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 1fcd4451001f..5c95eda6cbd2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4000,6 +4000,7 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>       uint32_t offset, val_vid;
>       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr-
> >backend);
>       struct amdgpu_device *adev =3D hwmgr->adev;
> +     int ret =3D 0;
>
>       /* size must be at least 4 bytes for all sensors */
>       if (*size < 4)
> @@ -4007,12 +4008,16 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D sclk;
>               *size =3D 4;
>               return 0;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D mclk;
>               *size =3D 4;
>               return 0;
> @@ -4965,13 +4970,14 @@ static int smu7_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
>       struct phm_odn_clock_levels *odn_sclk_table =3D &(odn_table-
> >odn_core_clock_dpm_levels);
>       struct phm_odn_clock_levels *odn_mclk_table =3D &(odn_table-
> >odn_memory_clock_dpm_levels);
> -     int size =3D 0;
> +     int size =3D 0, ret =3D 0;
>       uint32_t i, now, clock, pcie_speed;
>
>       switch (type) {
>       case PP_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < sclk_table->count; i++) {
>                       if (clock > sclk_table->dpm_levels[i].value)
>                               continue; @@ -4985,8 +4991,9 @@ static
> int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>                                       (i =3D=3D now) ? "*" : "");
>               break;
>       case PP_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < mclk_table->count; i++) {
>                       if (clock > mclk_table->dpm_levels[i].value)
>                               continue; diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 9f5bd998c6bf..b47e1ab12430 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2481,10 +2481,12 @@ static int
> vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr
> *hwmgr)
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       AvfsFuseOverride_t *avfs_fuse_table =3D &(data-
> >smc_state_table.avfs_fuse_override_table);
>
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> -
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> -
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> +     if (result)
> +             return result;
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     if (result)
> +             result;

Hi jesse,

Not have a return, Is this a typo?

[Zhang, Jesse(Jie)]  Return check added just to fix warning about uninitial=
ized variables top32 and botmon32.



>       serial_number =3D ((uint64_t)bottom32 << 32) | top32;
>
>       if (pp_override_get_default_fuse_value(serial_number, &fuse) =3D=3D
> 0) { @@ -3924,11 +3926,16 @@ static int vega10_read_sensor(struct
> pp_hwmgr *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             if (ret)
> +                     break;
> +
>               *((uint32_t *)value) =3D sclk_mhz * 100;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             if (ret)
> +                     break;
>               if (mclk_idx < dpm_table->mem_table.count) {
>                       *((uint32_t *)value) =3D dpm_table-
> >mem_table.dpm_levels[mclk_idx].value;
>                       *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 7eeab84d421a..ac9ec8257f82 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -185,10 +185,13 @@ static int smu10_copy_table_to_smc(struct
> pp_hwmgr *hwmgr,  static int smu10_verify_smc_interface(struct
> pp_hwmgr
> *hwmgr)  {
>       uint32_t smc_driver_if_version;
> +     int ret =3D 0;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetDriverIfVersion,
>                       &smc_driver_if_version);
> +     if (ret)
> +             return ret;
>
>       if ((smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION) &&
>           (smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION + 1)) {
> --
> 2.25.1


