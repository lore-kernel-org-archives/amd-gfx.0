Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8144ED33980
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 15:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0EB10EB4D;
	Fri,  5 Dec 2025 15:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xx9zJ2zz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC2010EB4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 15:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+jYCNfqXDeSII5m6tAB7sSXguktSsLsBFzJ7CwF0W7LRw0DljgPy0vhkmtT39ohipea4GtnMPMCqhIw1ssfEDLT5XHy2csUxdYm3NP3u2BdK2Q3arQwNeF6UXBOsxmUehBvXaUBTOKBtToerv6APLUolX+yflGxSoHD02u8fbnnih5Znnq0UzerksnB4MMm3j9WBj1T4PeKFd0A0zLUY/FQoU++BJx7vZgdALFjEH582P38DdgizYnbYEPSUxl2RJ5XSKX2pkGT8WzWoTy/w4FwqaGC7szAC9Ffcf5xXZaRfFjHtb1PgredPhmiqfhUykH2iFkJzXKe+fKDHQKrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTDEcZxnwLEZihOydnGklml2WK50j+6KC+JqT1MnZUY=;
 b=LAXbA73/QeAG4u8MRlrkKlHz+ggByUISOMa6icD5u+G8H180ro/Ot3MwpQTwn00VsKPTPVGPlJtofD3KO77xBCXNZ8iPCPvk9GHUTsM6ob4lTZnoQ8hqJtgWcoaE+L/GelUoNfdICNYCbc4MBXK8vOlII9ytAlTaobNG/mcA38nWRSbh+h9BXdUVvVavfuA3Fe3W/bws6cqgz6KIReqU6bggIRlWIHL3JImbfWXeDz95wlmm1QwCfHzizOiGirW30V4QEFN+jYjR9TdL8RzikTIJ0U1pZofrhWo8vj6dv20NcuBt8l4tp9nhu3XoD67mRfP06NyeKRm8W4zotn3wsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTDEcZxnwLEZihOydnGklml2WK50j+6KC+JqT1MnZUY=;
 b=Xx9zJ2zzJXw4l5tKBmw7zenk44u9T2sNXtZsy7uCc0uO9tmEqazvzZKZkxV+i9VP7klp5Gznfmlt92Bj0a6cg5TxGGxRKrvFux8H5uTVl/jJ2ax/Iu2TT8iSwMOu4RsBE6ecxYLmIIrH4HoUYQVNNhM73kzXWTwNMwMQc9JpYVw=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 15:16:24 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:16:24 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Laurenzo, Stella"
 <Stella.Laurenzo@amd.com>
Subject: RE: [PATCH] amdkfd: Bump ABI to indicate presence of Trap handler
 support for expert scheduling
Thread-Topic: [PATCH] amdkfd: Bump ABI to indicate presence of Trap handler
 support for expert scheduling
Thread-Index: AQHcZfAwO3Qm0buUS0qOeCgtyWAzOrUTKE4Q
Date: Fri, 5 Dec 2025 15:16:24 +0000
Message-ID: <BL1PR12MB589839EEE40D6D2670E8E6F685A7A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251205140441.2094767-1-mario.limonciello@amd.com>
In-Reply-To: <20251205140441.2094767-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-05T15:16:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MN0PR12MB5761:EE_
x-ms-office365-filtering-correlation-id: 7288b094-6889-4479-bc69-08de3411413f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t1dC1WozJxBoMQQyRQKR4QI8T1lzCbAcTj2R67H4BMwXMbVeCsARzQ6jPU2N?=
 =?us-ascii?Q?UmlM/YTi1/8CvbH3CCXMP2u4tPwcRCBp9Ow8r1m4Qx1WeEI9Asq2M9kD6oQw?=
 =?us-ascii?Q?sJBhV7jphUUtJRa4E9aVZBXsZDjbFJeg6w/iJx9C9Y6dWOlh26avHgVhbWot?=
 =?us-ascii?Q?0x+7QSO/2HDXBAacSfGEVNUmDUl5SWmdTpo6U6rKXLqucZPr7EUZoBWI1zgY?=
 =?us-ascii?Q?AKitFARAl95QS22kZhbSSAUoKUguIbMsrJu7munlAHSdKcSmKlV2/zBoGoir?=
 =?us-ascii?Q?8sCHNo9pvudFtjeS6vpdia/btTU1HEENW6LrSuI/VpQKZ+oKPcjo5kPnRcQ1?=
 =?us-ascii?Q?aYa3LBQp91v2WDn5PVxlEKG/nPYePgGW3qanqWggkZPSaocWMcu1luktoQuP?=
 =?us-ascii?Q?pPjJDGPeIVelNArvPfs6/hiC+kfW24oNpdAMpW9v73BtAALW7P639zzGJ7CS?=
 =?us-ascii?Q?uARnm1Q9LGbLgThwci/L0x46JjL2cbOjT2VFaSvmKhuIf0SgBj3ULL7B8B4Z?=
 =?us-ascii?Q?K62QIfnkvJxNRxBqx2HkxEUdAeO2mto7135P/bBaQMGeLPLRYZwIlyB5OoCG?=
 =?us-ascii?Q?QcD9tv7FoqjWezCkzRw0rtQGn3QaZMhbvrm2pYGu84B0wQS7Ie1PGOX9jtQC?=
 =?us-ascii?Q?vuY1nnXQR+h77MWTLV6FKy3bL45skIyrQxaoj4OPoR5bYNnFRnBWJTUjlb6D?=
 =?us-ascii?Q?WYt/yx/OXwoNfqaWdUB8AGAOjkea7fXM9SVDZbowzPJuFshplCBaY+8kLlz+?=
 =?us-ascii?Q?TFktZ7QOrCOJzEmvotDdJZWoRMEV6NchUzJR7UEUSbpV+SJclMYxZLIiz2Y8?=
 =?us-ascii?Q?4Z1+0r9aah5kt1sM3+7a0sxi2ixfnDSauxno+S8OWla3KqzTVIK94UBHbsSt?=
 =?us-ascii?Q?b4IGUK2JDGp5SpFsXb7x8rSIgovjaxt/dQhcn+tf7qi+2tnl387SS5chNgAn?=
 =?us-ascii?Q?KPu/ws5mzcAK8ZDnZqvN0I2S0S5y6AyAL8an8+PZjn8Ul9PxQthSY+JnqpIq?=
 =?us-ascii?Q?kHbvf7mk6JqABnmjX278z6zyjRVI6pI/8NPVxuWI7WFcPnQZTrLpby5MmpQU?=
 =?us-ascii?Q?BcOYvZbPbKgLUDt/nTdB4rIZUOqVuqGcSPVDCW/bCbVVoQ/CILBShGotLIFz?=
 =?us-ascii?Q?RvI1DtCrK9KUVt5n7mGqjh80BCyOcU1M3ejt5diElvDQUPkPZlLj59yXOIrf?=
 =?us-ascii?Q?hgJ5Lb2QyCVDDufofrKvYPOF2HH8U5dfYIRHmXM8iHtYBpV1P/ryzrU9Va4P?=
 =?us-ascii?Q?Ri8iPCZxVm2k+69+mAJtGW0xRQWhxv5AFE/NMnlm7sEZvClJdY01ZYuEZvQ4?=
 =?us-ascii?Q?VwQpvuRSPQ+5Ae9t8Aebb9ksMIXsnM/Jjbh4lI64gK+jyTj4AOxgS5C6ND8X?=
 =?us-ascii?Q?3T0NdEGZLKr9fGMsBidj1Ut6CQqigl0OtSA3WhqyYseaZrcwoq6EFQCb66d/?=
 =?us-ascii?Q?59KGLJzcQOtTreO7Zo3pbfEjsckcEYHl1cTQ73zqDDl7IfX3AmXddLcCgsp2?=
 =?us-ascii?Q?efDJtTog0nM9GoiEqL23bTmGOnxN443YBBxp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I86NGSSYsyHnJVQH762uJSH5Zt0DG8f4xcpUFtCm7Av7nQ/wTQPfa+TrIY2Z?=
 =?us-ascii?Q?kRowDRMOeMlgapjGfL2d6eTMlhEJTI1G9DGTPt1Bb2DZ/nhe7OQrKkhSVYpv?=
 =?us-ascii?Q?JvQxvSljrcKjwUd0EGHzMNLnzsIXSfDA0eZWYY777hByCVUkAeffamLEhPJD?=
 =?us-ascii?Q?3XwYDNGYHNpYoRVtnGLKg8bQ6T9k2sRpd3fe4r7wn6x+Lk1tl1im8wZSww+z?=
 =?us-ascii?Q?SIX6pl6SMdh1YY/tebMijnHEx6lYm53pcXdnBMkMeyU8QCDF2GmLXU+DhjDe?=
 =?us-ascii?Q?M38j19DJo5ZhV805oZITOd4vASAuxXE187zBL0Sjn1eQ9hH5r0fDkZ637ziP?=
 =?us-ascii?Q?U/T2xSkWGA+sLWC+5q+Xgkl5nJNVJOT8jQiaqDdR96+xkgbooySFQ1OapxMt?=
 =?us-ascii?Q?ii9YUCySUOMphqLu++aZla3PyPcd4UbjhVldPeicbu8lOSYhuxdLK0GGgqkg?=
 =?us-ascii?Q?fHn2a15odMcgNInA5O/12BcXGbMSgb92niVo6sGyUu6uwVfWboqU5hb0vtE7?=
 =?us-ascii?Q?vG6FntPh6gzgizWKdPq2pbNZ+WoGUEgQkLUOh88PCe5gbd3K7sigFntHrrz/?=
 =?us-ascii?Q?MdFBlO8IMhSOW33VrNdt/Etc2q1vt2LvwtkAQnHIK/3hL/LXLDC2hPAfr+xO?=
 =?us-ascii?Q?6iY8xurnGHO9YAD/PkAt/i/Rdb7joFlr/6WwnZeG1bBWUeHVy/Dv/YlfgtMz?=
 =?us-ascii?Q?OLVIXrgMiKINh84osn7rfbN+o1azOkkKM0xcFtGykQFwKKAKRRXIeYN2K8ij?=
 =?us-ascii?Q?DK7w/CCD7APS/4r8GimRz2TyZgZ6DVC7qJPsYFAGrdlwGX0G15iWVy+lhuDM?=
 =?us-ascii?Q?pve/3XOlwlWv/WK0GqUihmyxq8jz2ochmFQYdIVTz+WbB5w+z/EPPrRuk9Lq?=
 =?us-ascii?Q?LeQwAQmD19oEEVKEY1Pkq+WZiiPcYKX0a+HuklydyOaFGEFIb85iV/T51t4c?=
 =?us-ascii?Q?KWRJjxLZeDak+6aTj8loo1evxovV+tssJkazA7YHkM1XoaFB7aXGpwh9d666?=
 =?us-ascii?Q?on2dIF1NHU9vJagmGO4UhzoXkqNtc/u0a9FwdPd2/IrHoL8tlhIUGRBt0BaM?=
 =?us-ascii?Q?Y8O0IntA9ZWY20DA1ScVlE4mpGdhvcMMZMMskvb+79WhxWJeAi2zmP7YPwle?=
 =?us-ascii?Q?vDE7Y4HBF0rl9ljgDxB03GaxtIReys9kWd7sgFPM/byeb3dII1BItxzTnwCB?=
 =?us-ascii?Q?o2hMfJtdDm5zjljBwUEIRfMl7GNHsilEAYQaiUqI0fai/sjBoOHtNwjl6s/w?=
 =?us-ascii?Q?eGaZQrOF/YkE4rDIHiz91mWTOdsAUYJgvF/rsRyrJngxnx6Jefl/OF8qUljj?=
 =?us-ascii?Q?siT+sOiTFqYZoeI8Qih6Y2uszQ43SRme7x1C7akLE3LIW076GJMj/bNj+4NH?=
 =?us-ascii?Q?NDQqtB6+msPZZ3zdskuB/69RbwWz//9oJ1ea88DsGqxLbkM/YifVc3j+FEn3?=
 =?us-ascii?Q?TDm+YSLMvLPb/7MAVMrrDwMcWe7hiPIyikEu6sABNQBRplyyGZbRV00vWfY6?=
 =?us-ascii?Q?uRzVRYvpzVtf/wIAM6BahhaXFHYmudlP4D0M20P3KZdtNR9DyYDouZqY5IWg?=
 =?us-ascii?Q?hFs+cff0XwdnrauKDe0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7288b094-6889-4479-bc69-08de3411413f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 15:16:24.6368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEPhomJgN2Vyv0sQ2NL8WbtDzzwr4u8Q9/c6JK18DOYXGP1JHV5P9AOIE+LeA7qgHlhMvjZkSaXy+woxbNVNkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Friday, December 5, 2025 9:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Laurenzo, Stella
> <Stella.Laurenzo@amd.com>
> Subject: [PATCH] amdkfd: Bump ABI to indicate presence of Trap handler su=
pport for
> expert scheduling
>
> commit 0f0c8a6983db ("drm/amdkfd: Trap handler support for expert
> scheduling mode") introduced support for a trap handler when expert
> scheduling mode. However userspace needs to know whether or not a trap
> handler support is present.
>
> Bump the KFD IOCTL API so that userspace can key off this to decide.
>
> Suggested-by: Stella Laurenzo <stella.laurenzo@amd.com>
> Fixes: 0f0c8a6983db ("drm/amdkfd: Trap handler support for expert schedul=
ing
> mode")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 84aa24c02715..4d0c1a53f9d5 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -45,9 +45,10 @@
>   * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>   * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
>   * - 1.19 - Add a new ioctl to craete secondary kfd processes
> + * - 1.20 - Trap handler support for expert scheduling mode available
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 19
> +#define KFD_IOCTL_MINOR_VERSION 20
>
>  struct kfd_ioctl_get_version_args {
>       __u32 major_version;    /* from KFD */
> --
> 2.51.2

