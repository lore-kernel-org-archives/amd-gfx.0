Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF4FE6FE33
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 17:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FAE10E168;
	Fri,  6 Sep 2024 17:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uI7rwMOY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8913B10E168
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 17:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4HLrE6KcvJ/Ji25Paz2rXgZajymDhdXtvvpOaE1RM/h67PbGtD68lmEyERtc1OEvKl05m02NDzWGxgp7blbrddwybnZh+B2CKw3Eux58bO943wodH+O8OSK28mKPcZbqwx9Z2aWEG4gDhh5dMv/oqL2DjFoG4JdU5QFTrzUy67WlYmJjiE7LCMMCppWLw0F3gSCmAAy23LWduw4HcrNJ+yX0tczMBdmwGTOMBQvC1Gh2FHcRKGH6BYfG+Zt0OfOy9diQOTgYpU+b4GNm4vsY0Ld49+PWqYK1wJopSaiO5lGvRo+ePCfwPGMU3O0oBNwey5Foq8PvO4bJyVJBxPo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvVa3CnJR80zk6YEDXdeKap9kjqqF9uB/uj8VqjFx1c=;
 b=HwAU6DEyqjD6oVzVBD9/BrsYWgdxQhUiOObzhbhU5r2D5FziL1QfjTJnRV672kzgYWJJXZ+Kla5/8+LF6/uFy8Q9hjmQ8ZljaJi0ypgJ3XkmCsvov4O/wm8exs4YsuxD7OOgTracjAzliobAK4gCwPnoYrYR9NUQVtLkJaS22iTr36lMwZbZww4KGeQ4BnLKZwUpQwH4VfpOfBndCQTVLAmMrtvDS3qk1eMF3AATlG8/Ot7OumTDU+kJf1RrUHpkB+Vxc3EbD6ZiDUUeBXyZsblLVBtJ3Vbg23LFofAOGdOgXdXtNtTHzcJO1w8WhLEY4gCDwHvz06Bh9rY4xslXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvVa3CnJR80zk6YEDXdeKap9kjqqF9uB/uj8VqjFx1c=;
 b=uI7rwMOYKDBvD1swFnGdE6B72KRM+PY7Clgxp9bRQueM8aGpGwsAUtzDa1JDQvkzRG3gDbOAqQ8KIj3HX0z7hlIFDYUvCtdL9zNSEimKaSgXdpxvVtcS/aYKDg4oV2dsQemsjEBKc35EQtcNGF2PRRRDWPkGtUxTLGRZOKnk+rg=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 17:34:06 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 17:34:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Topic: [PATCH] drm/amdgpu: update suspend status for aborting from
 deeper suspend
Thread-Index: AQHa/Q/9NyJRCdHMEUaj9C+X/ICUOLJI0mEAgAI4498=
Date: Fri, 6 Sep 2024 17:34:06 +0000
Message-ID: <BN9PR12MB5146FB172036F9601B38C3E6F79E2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20240902081311.2918278-1-Prike.Liang@amd.com>
 <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600580C6E52BE6734FD7F0F7FB9D2@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-06T17:34:05.544Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB6948:EE_
x-ms-office365-filtering-correlation-id: 103a07ad-ab3d-4ae6-36ed-08dcce9a1b81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+V3IFXDfT29/20A+siQTeoM4TdFvPbBdqlPCSxJVtm1rjkH7zeAapQBeUtfY?=
 =?us-ascii?Q?lgPwnHUMrQnhdeGYuxsl36GdEfAQFgUP8/unh1jDM5CYVnG3GAnbut2Zk0Qu?=
 =?us-ascii?Q?9h32kYJZPB6Bti6m2+YVs7pNCnDUpQ/fJEqu4EH692a9xLGJ4lEnP67v7FEq?=
 =?us-ascii?Q?2ayzuUe4B+1upvBIOkvc8DwE50TS/aDEt6r5XqFzcS5zwXIabQEMbM9CshJU?=
 =?us-ascii?Q?2o41FAxVpMGwgB9BTIJePEwHLELckQXoJfsbGQC2XlN1hUvMq5gFGKopGxH5?=
 =?us-ascii?Q?Re3u67/iJFlL6nRMxRRVzM3yfXKP85GzSGxI80ZtpaoV/6pgdjnNeEpwM0Pp?=
 =?us-ascii?Q?LJm7Tw7tgLY07ebsimAj5NJ8k8hrqJ9dNGhy4Qgq476rSZAalN9EkKnP7eam?=
 =?us-ascii?Q?hgWan4ZjIabdTUHmX8SBQAlSTDFGKZ8DpeXlnH5NCfB0XwN0Q1Qk6ZAgp8KJ?=
 =?us-ascii?Q?xj3hn2e45xoxid88hgSZYuFTzzb1iOfRU/h8dUECl8yDh36OZrjCgRGj+2aM?=
 =?us-ascii?Q?Vitg6ZDOV//BUhvyt4Jm5VkBp76MHPIv7y8rs0EjKo6HKdGFjthVndcTqts6?=
 =?us-ascii?Q?yXi7Mpw1OyD37t3a3zE/x3RZmUHffSLw4+94oQTNk3ZmsnmAxiqaBcNmWd5y?=
 =?us-ascii?Q?cRuYlqPJYeSWoYW8ASHrflT1djhWccLHk63LtAEqE7q1YSLbVyRhUFvZcSdA?=
 =?us-ascii?Q?cwGaT+qJiM1oSa/1vkOXf8HL/f6HCCdp4IAV9BHBRvx8uIWosYWXHosJVVAu?=
 =?us-ascii?Q?OR2BJ+6LoprJUhEubHvNgSI3P8Nb8R7LplXZ8qQAUnrmlw5kim32G14akkm5?=
 =?us-ascii?Q?r8AjRk57A0wvaqCHCQkSEWb2NcM7//DMVjcTs6mFrwVx6KeeY+n64aahYo4E?=
 =?us-ascii?Q?MOZwugprzv8yq1qyW0IIPTsEnzpVGX198c/JHyciKStOjSWqsjSR9ioAK8sv?=
 =?us-ascii?Q?kPGhEG7VQYkhwQ/N2Bo0lkQZkTWBnIUmRBPtWfclJJuPYMpkD7oiSaWov/5E?=
 =?us-ascii?Q?qBJ3ZA1Wkw1sSoaDAqD2UCXJPvBsq+n+Pb7oQ4D9tz2dR4SdG/U/jUExpdIH?=
 =?us-ascii?Q?L9KWpGk8FKa3Cks4qtm9Gp91Y2fJovHqK0xpMWUK9h7UFULv+jL+e3TCBS5c?=
 =?us-ascii?Q?RYvkuuXIalGmPF6BEpBRVV+GSOvmtUmUIwVgLBpALpI/XaveQVrDb5/zrynT?=
 =?us-ascii?Q?Evz8vHnfH0FxeuOl6rFEjsj/BbaWf6SdgT0CrHluwZw6UaE9bB6atyr5wdSu?=
 =?us-ascii?Q?yADDZsjTISSOkpdGTj/GD+uJ8IEm9/2sQdPc9a/YJ09+X9CaXZTGby7UGKPw?=
 =?us-ascii?Q?Einkhn0yMmgYTytTLkBzRROytelu5tA5tumhsWLTHd2IvrU3+wjWKb+ciENo?=
 =?us-ascii?Q?HwtBO0ZYBUJGHUUeoKTypTz2rORfIJ7fre25rMCUGIGmhK2uPA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?az9TNdHSXIE8Bo259yFdroM/XN63dV+Rz9KXm6nRhthq21BvPPsqu79sO0zb?=
 =?us-ascii?Q?aAEwQl76wdUSnbhyCQPYaEoJPwo94Nw+Y5W4De4Vz8r83UE8o8jI1wu9mt/y?=
 =?us-ascii?Q?2vG4mu4+UZiijQbYg0b58fIaU1zosk1j1zoEkgc9NVLH51x7INLkzhsgg+7h?=
 =?us-ascii?Q?q8pUlPeGAyfSzGXl9s/1TRQkU3ZHwqkqkyajasMJQYX3SrNXyRgdfi95L1ae?=
 =?us-ascii?Q?JEm80udtY0TtifFHy0951THzV3lK74iOOYohTOJ4f4fY19pLA4u4YK4YQkoV?=
 =?us-ascii?Q?RlWmtslIE0F+wDBT9GB8aoJ3ty3VzSXhe2MBF06E/NCjKLtKjURYAawlgP65?=
 =?us-ascii?Q?qqEkaymIxp1bk/ivnlX5VTlDiukKd2e47Q+Xs1wmyeIzE023sRwi7nxqHVbZ?=
 =?us-ascii?Q?ME45cenTIJeCoZ22JcU10BPSlpcw5EhMcgCbCz2Ipjn+D07s+JXUfOMHkCdx?=
 =?us-ascii?Q?npVLbbqo95lexcs6Iou0ZccoM/fI1/qfUEwxtrBo2dloP1QGL0NLImt5cEJ2?=
 =?us-ascii?Q?7w/PIV+cvvD4mKssdbnWtYciChZ7W320DlxHjV2Hp07aCZvIzy0Rzg84dF00?=
 =?us-ascii?Q?QQhfBkWFPDYuz87Nz2GEVJ5KEvEn87+cFyOAFfTLEJ2s8OP7330niQRpmMk2?=
 =?us-ascii?Q?HHrBKmPfjflJUMLZI0zhN8ACCfEcXqJ+xXEQQBewUCvkU2xgvk+V+vysD7q8?=
 =?us-ascii?Q?9BGg8W3WKxcgR3NKyefCSZoa301ZRmiBpDcJq1PwpnIlxC8lMzc3NfuL2+7R?=
 =?us-ascii?Q?ixpFhayVlmXYiq6csQjIj1F94m+XSzAjuc5Av2ma5PDoAeJ1mvnT+rzn4raV?=
 =?us-ascii?Q?SJ8KQsA/SwLEabEpyedbNds04Ami28P2ZHS8tIaynUDYt5qU/OF7L7IrX0EI?=
 =?us-ascii?Q?4qHRRkar0xnlBsgfIyn5QOGaLRCv5QnrdLxfoZVWe4GsFjs2TjNvIT0M2OB1?=
 =?us-ascii?Q?fmkBqjTzIIGIaTbDdNdYohZHwkuBW+2qV8rIwLc+Sa6ZzD/EhiOYgw297xiW?=
 =?us-ascii?Q?UDbeefL3yxkWFDd3PNzYBbA0O6cK+t40pSTBhSRTusiGEbeeZvweWkQBMjKK?=
 =?us-ascii?Q?zB08kvvXvvnZm7x+GMFrnRsVM4xHi8wXTGOQGgd1sJcH53bptKJcjrBNqcmh?=
 =?us-ascii?Q?mUdW01ClRPK+gHzp/M7uuUHP5JiMzW+kejT97qc9y1ehV6eDVEqWUclYquyl?=
 =?us-ascii?Q?fdYkoDYZ3uvtsG+d1qbmDDuvbOoH2AT/ZrCjWP0lbDejM42LqRA5LSzKEtjQ?=
 =?us-ascii?Q?YQO4WUhwrkiKZSYfmWfW+jkHU5NcqnS4etIMibqhpXI1jDHZ8eZ0piq/ncj6?=
 =?us-ascii?Q?XuH1PQmhSWot7ojkt26+NyiTIwma9CutinKSivgW4h7bbpMwXDnlPW2YUgSP?=
 =?us-ascii?Q?UM5Cu0YVQUTKTAeP4uBZdwwHvH+6CDsumjBGxlNqmwcFJKzprZ74NMpV71c/?=
 =?us-ascii?Q?WYJ2xpl7dMU4ICK8nTnBBDEyDGtU1KbB2zCTnS6Q5XgK1vak4r12cDdJnLN0?=
 =?us-ascii?Q?z8WL3uffADtACSzsyDDMq092dAuWQ7qc3F7yGP86pbHR4pc2u0bwjV5u3Fvj?=
 =?us-ascii?Q?ZJn19bZcf9m6OpKNOJ8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146FB172036F9601B38C3E6F79E2BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a07ad-ab3d-4ae6-36ed-08dcce9a1b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 17:34:06.1493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj4eWD7hNRwafXAnqSaK04nqzEdBCuH0rVEM02rGulSTNYy2Fmky7u+fzWFQOSzTjzUAZ7i33BxV0dRNAnrbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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

--_000_BN9PR12MB5146FB172036F9601B38C3E6F79E2BN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Can you elaborate on how this fails?  Seems like maybe we should just get r=
id of adev->suspend_complete and just check the MP0 SOL register to determi=
ne whether or not we need to reset the GPU on resume.

Alex

________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Thursday, September 5, 2024 3:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update suspend status for aborting from de=
eper suspend

[AMD Official Use Only - AMD Internal Distribution Only]

According to the ChromeOS team test, this patch can resolve the S3 suspend =
abort from deeper sleep, which occurs when suspension aborts after calling =
the noirq suspend and before executing the _S3 and turning off the power ra=
il.

Could this patch get a review or acknowledgment?

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, September 2, 2024 4:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: update suspend status for aborting from
> deeper suspend
>
> There're some other suspend abort cases which can call the noirq suspend
> except for executing _S3 method. In those cases need to process as
> incomplete suspendsion.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..cf701bb8fc79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct
> amdgpu_device *adev)
>        * 2) S3 suspend abort and TOS already launched.
>        */
>       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -                     !adev->suspend_complete &&
> -                     sol_reg)
> +                     sol_reg) {
> +             adev->suspend_complete =3D false;
>               return true;
> -
> -     return false;
> +     } else {
> +             adev->suspend_complete =3D true;
> +             return false;
> +     }
>  }
>
>  static int soc15_asic_reset(struct amdgpu_device *adev)
> --
> 2.34.1


--_000_BN9PR12MB5146FB172036F9601B38C3E6F79E2BN9PR12MB5146namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Can you elaborate on how this fails?&nbsp; Seems like maybe we should just =
get rid of adev-&gt;suspend_complete and just check the MP0 SOL register to=
 determine whether or not we need to reset the GPU on resume.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 5, 2024 3:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: update suspend status for aborting =
from deeper suspend</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
According to the ChromeOS team test, this patch can resolve the S3 suspend =
abort from deeper sleep, which occurs when suspension aborts after calling =
the noirq suspend and before executing the _S3 and turning off the power ra=
il.<br>
<br>
Could this patch get a review or acknowledgment?<br>
<br>
Thanks,<br>
Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
&gt; Sent: Monday, September 2, 2024 4:13 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liang, Prike=
<br>
&gt; &lt;Prike.Liang@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: update suspend status for aborting from<b=
r>
&gt; deeper suspend<br>
&gt;<br>
&gt; There're some other suspend abort cases which can call the noirq suspe=
nd<br>
&gt; except for executing _S3 method. In those cases need to process as<br>
&gt; incomplete suspendsion.<br>
&gt;<br>
&gt; Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 10 ++++++----<br>
&gt;&nbsp; 1 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 8d16dacdc172..cf701bb8fc79 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -587,11 +587,13 @@ static bool soc15_need_reset_on_resume(struct<br=
>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2) S3 suspend abort and TO=
S already launched.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_AP=
U &amp;&amp; adev-&gt;in_s3 &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;suspend_compl=
ete &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sol_reg)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sol_reg) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;suspend_complete =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return true;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;suspend_complete =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5146FB172036F9601B38C3E6F79E2BN9PR12MB5146namp_--
