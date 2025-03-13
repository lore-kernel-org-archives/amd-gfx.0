Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E062C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 21:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660FE10E93E;
	Thu, 13 Mar 2025 21:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyo5JEgZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE9810E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 21:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1yXwerZyG6y5mQEAxHhALOm7yeM0wzYziQdBsdFcef+31qNNUsdksr0MYnV7rELRAHoL0YBiedaEtzKLokZR0BmHe1qdscKDIqqDrE1jYM2S6hB8Umcg6Kvoh6vQSj/AClQm6fHVfmts5eWW7sZ6yKqZwyyWBtzaNt3wYfq4z2x4W52z1MCQSrv9PJxE/4+6OsCaXdPQSZHyum05CXd3v2hAqeBWyBI2zGaSQgglYSIpuGtOMs8OgoWsj8lxVa93u6pIxONKn3HRya9JH7z0IVdmUPZAK2X7L+IAdWKmBrk5CXtT27IMsFG45s0WyjspRYJIyBIyOxxSXWMbvB7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wioKYngh24lkX6aOxhAmG+MourfUyGaWGPgCFEGlu6c=;
 b=tmdjhTC6ev757QErXWlzFWLFFX58Tnu92fP4QvdoOjlqQeCM/SemVfVtSI1fNtatjzxuI7QxtuOS0e2jEHL5MgfM/3l3epDD7g6X8obtKdtrwNhNCnJecrZ9V90m3igi2sebQIqmlFmqsEaJbbrnQ/EvOLeRt3Cr/Erle+SI4fgj3AffN34RiE0mWFsIFOsrVe88lPPyY6Yk06qBIY3HWu7NpuU9TTBnN7HfAcpwwYbimxmF85cwkocgX5RfrSqpeD5daPqaCb6Cb3A+P1dbG7BzBK245M/ax6RjWSV0PjnyG844A5/drWtlWnkceEY0fmG1LXJfJMa8mQN8/XZHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wioKYngh24lkX6aOxhAmG+MourfUyGaWGPgCFEGlu6c=;
 b=wyo5JEgZk5bdpEffyTAGJf5HolXxgMmqjTuEz/JbniySJ8MomzCB1/YUtcGZ+UBZBwV3gVNYAL/F7sroKX4x+bkLF1nb7dLP6JAxll47tb3TMn8lJZEtM3VWUZtmibbeqXdz2R0Iw4Ra8SFKhwM0z79Zq7tA84QJUf87tqxFbJg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 21:05:57 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 21:05:57 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop drm_firmware_drivers_only()
Thread-Topic: [PATCH] drm/amdgpu: drop drm_firmware_drivers_only()
Thread-Index: AQHblFufybds7EudTE6tAu9VWTrjLrNxjp5w
Date: Thu, 13 Mar 2025 21:05:57 +0000
Message-ID: <BL1PR12MB589820959058C368B24535CC85D32@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250313210436.1380413-1-alexander.deucher@amd.com>
In-Reply-To: <20250313210436.1380413-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d51702ef-7029-4295-8731-98a32e091ea7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T21:05:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB6359:EE_
x-ms-office365-filtering-correlation-id: 2fe8bf4e-da2a-4f38-d1a4-08dd6272d98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gdeIqvubob35I6ofGIJ+NPigeKc4OZ6MDkp40cl7JCBLpvBp9x6g/Kk0ZfUZ?=
 =?us-ascii?Q?tgmhy4hLIMP/3pf0jfhOnszt62eiqbiODpeijDy3fFRdKzRUU8YnNfbaGFUD?=
 =?us-ascii?Q?V9YLox93AEab5lE4wjxm++vGEXhC23FobFLaXPes3dM368r5V6n1Xg6TBQFs?=
 =?us-ascii?Q?fjg58Laz3oxESyeFuI/abLDZBSEr0pfVk6+Mwjj+V4Eidw4w0E51NtFsXv/h?=
 =?us-ascii?Q?yWeABj5yOxiG5zROuEDf/vNAGHNcgKz/vS5hzfMBlgSeen0asDdxEllYrVb4?=
 =?us-ascii?Q?BAMVBkwwYfBWlSz8ONf8WpO2jge3H8Uqzb+rx4uBIQVwyBU3+09KryjfldJH?=
 =?us-ascii?Q?KbgXTFvJIcop8Xgg2aYvpYB4apMFztYgeYDZFBefNH0Icpu4VYhpudKEcY0a?=
 =?us-ascii?Q?T8vEGIm9y8R/AMSwf6OWTTcY6uCCj7gq2JXPVzIEpQAW4adELH3ZjgReWMlw?=
 =?us-ascii?Q?9Arpu2OdWxuGND0hECUCidsRBJeu6CJ3Io7sXqlxmeLmNCgfgPqTXTnFfFgH?=
 =?us-ascii?Q?ZoUj0jZa9W1ouDtaS0eF2mmZGiNz0SGa9MLIr4yD4JViQ3aEmne7BiW9uaKf?=
 =?us-ascii?Q?45Ys+LqETsC6OXdO0Q2iaZfa7fZE/MJgM2OZjNgJak01fhOrdSQ1x4F4c7r2?=
 =?us-ascii?Q?0fd6u0m93cNiNJMnazK9Pao2/iQxYOPZfZAdLPp0Tv/nbRSyFJlRnJDAU5EJ?=
 =?us-ascii?Q?uv1T3b1R3KeyCgFkmc4tky16gUW7BAZHKjY9/NjdIfobcAtBKTuDyqtOi1Px?=
 =?us-ascii?Q?eO0/QEKQQSeysJbM7RzYZ3r6NiDN69RXk/hHjzAlCfN+IKYe53622Vc6syWg?=
 =?us-ascii?Q?tnF/gZoDjLhQw3+GApZAUu8M/DTgkxjRpxj5nb/1qE7qXBg1lrXl+EtZ7WRE?=
 =?us-ascii?Q?KvUbz6gyPCswjRwBSsS34zFToAdwbVPUm5hUEd5JQM+8HyU0V5zLr9YBiMXZ?=
 =?us-ascii?Q?4GZmrZvaJRxx+KwUFp7k8POFLiEuqa0b1sKKZE/EeLU8qv5Q5SkRhIGXN7lt?=
 =?us-ascii?Q?epIjpsvyT5z+pU8e/+jUTMt5t9JoRVhTirLuWIZHi7oY0FmueV6mLS9ImWu1?=
 =?us-ascii?Q?Lc5wPea8XGMGy9tjWLDXCNoBBkRPfBnwko1xqip+XlcWWH9qNlaQSHggRuIk?=
 =?us-ascii?Q?hOBgXIqwGwY6p/Cx0k9RbBgaeym9n23ChEBSnMDJ0D2TiQLqbYBadPOe+5ta?=
 =?us-ascii?Q?ArsO8y5O3Wb3lJ1LVfIIL7eWyOhScAUpAxlkjOY9MVtnvIhMI03pniNLTW6h?=
 =?us-ascii?Q?6KsMkUuhdayyEEfNuHflbJ28wuHcxPOTQHlG/c3cO3YoKBXM6tUw1cJgh8ri?=
 =?us-ascii?Q?FTSXVQHEq5kSKcF5kOnTQv01OFUZkvLRrr0UiJtpiYLNKXuSyX+KvocQbAcO?=
 =?us-ascii?Q?I/GK170KTeR8mx+XVsYTaVfXYrsCfV7m+9hUVVhXoTKgAQv7ouzUKYGWuIR9?=
 =?us-ascii?Q?iYPZJX4h2cFbPihtyP98npROCpkO+iWq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oCIMNoYGDxYE17QLTEgeXhgLPVSBxs3OZeKPpqyZzUehe1JgUavEXr+7T5hn?=
 =?us-ascii?Q?p9kEcVxBXW+k0dmna9kixJj/YaNC6Va3r9x91dAtX0DRgB+tJe0oVfpjk8ke?=
 =?us-ascii?Q?j6WqUMJMVmXE4eOmU5Bj+Gif0b5cnr1bHJ+oAamRtJqwAxevRi74+PQbgmQ2?=
 =?us-ascii?Q?0PCxr6Ls/WdDf6tx51V+g6HCmwOdXaBbIhQDalPvyouRMuI5H9uWB2gWUrfa?=
 =?us-ascii?Q?u4+NWC6Io3AzJglgjyQxNv/mZ73bXPm5VXf6gPLNK9gx3oarY8svgGtMD2XP?=
 =?us-ascii?Q?kUm+LnsQ0KsHk3FESeRbBHuySju1HAKPBs044VjWqHKtEdQn/lfIqSqqiE/L?=
 =?us-ascii?Q?Xiv2oWvRK3M91ANtoo+kDTTYOK9gM/lJd5YQp7o6hMBIQHHurBPr7CBlWzow?=
 =?us-ascii?Q?cMUsJD/GYnAj0O/AioZqDAdXVMJGJumhIIaBCzDkcFkCRRizktgiok8V06fc?=
 =?us-ascii?Q?O+Or8Gup0hIPoomfBfM28AP5YnkDcj6ACq5/BvgcM5kWcB5tBp8UzRnniLIF?=
 =?us-ascii?Q?uLGIT3c0xICyVw+xpmO+1fJSm/ixvn1n11l3S74tarCX6Gwla6+uqeO/ud9c?=
 =?us-ascii?Q?kxh2bVf9nbm6FuVFQguPCp34EiLGrPqaD0if7W5Qmel8Crweu28IbdBDU4/P?=
 =?us-ascii?Q?LqnVfvP5hEpNSP0JrW55Nq3NnLOcM0Qy4EU7tUOBVkX1V9Xa/3FjGmhAYO/j?=
 =?us-ascii?Q?XJlWD8JJynXppSm7F+1MhMQrVGDQm0chTEgu1K1Qnps3V/O+0pvau6Wc6m5o?=
 =?us-ascii?Q?8UUH+OEe++zvacV/53zjrZZAdM/13qH1cJOvVAnPLMX/avMCN1mV22Ya3D7u?=
 =?us-ascii?Q?7kW8yzN5dTnvsbAfMCGnGVTLcSw7W40pHmGkxeYk+ByhOngAaJ2/KILm4ULt?=
 =?us-ascii?Q?yV4GEfHsiGQE1I2dQjD3q0cId/dkB+C3VICT7YfPO7I2EWuDW/Ndawof5WwW?=
 =?us-ascii?Q?WIEqmNJ+Bz+Ald0lSfoN/CynKsRDx5Hck177hnMy3AtmX3GqoY7lQPOExXHa?=
 =?us-ascii?Q?THsTgovtasahBQUm9TJ5863SIbEqAKdLuAoBaiB20NuI3OYGf/bXAFIuyd27?=
 =?us-ascii?Q?Vc87jI6T5Vo+G7zER8Lr0Nn0kci8Ss2NDtw/q+pDOXr2hFHwZ3bpirMxbcRY?=
 =?us-ascii?Q?J0bsvfwvOGCWbXCAMnOtBU+Grh8mNI+3sci/ekpbvL+PAoK5L+4QJ/VCSPyL?=
 =?us-ascii?Q?CraP1YMEFRzQ3/jXCzYoKh0ZDHGFKJpz9A9TVdHXJTtTSFRoS3qh1b7cDzxo?=
 =?us-ascii?Q?wqSkR43QJ4/pYqXO9lweOj5pziKAx0QTh6WPkpvJD+z+KlYU3MhO5gb4ueZm?=
 =?us-ascii?Q?4kI3BLMnewGKyd6CaI7idYFy1/+DDBa5FqTPZ/WA43+ys2KyRWZdk0ifIy59?=
 =?us-ascii?Q?K6/VTB+JAo8Q1jcodR5sT2ITkB2har9hFM6SAKYpv+X3UO4RPB54qaZALVKL?=
 =?us-ascii?Q?e+fnRpleMBzWvHsQvJW6JKyUUe0NkueDZm3nb9h6fsRQkcjcWB368hvXQLwd?=
 =?us-ascii?Q?Ihzya37bVKVBXUeUfd7l5undA/KIclqOmBmtxDC2hhDW7WQAK00pnGzj+N7l?=
 =?us-ascii?Q?GqKHk43F+SL6wK6rh9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe8bf4e-da2a-4f38-d1a4-08dd6272d98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 21:05:57.1579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCAYRWrIh5c3HJADK0mdy8lT6BmXygoE6I/FlCbbrOvwDF/CRoLRlv8epyLB7KkCWEd/6ElIKNb9lWKgDbzv5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: drop drm_firmware_drivers_only()
>
> There are a number of systems and cloud providers out there
> that have nomodeset hardcoded in their kernel parameters
> to block nouveau for the nvidia driver.  This prevents the
> amdgpu driver from loading. Unfortunately the end user cannot
> easily change this.  The preferred way to block modules from
> loading is to use modprobe.blacklist=3D<driver>.  That is what
> providers should be using to block specific drivers.
>
> Drop the check to allow the driver to load even when nomodeset
> is specified on the kernel command line.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3b34fdd105937..dd86661153582 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3022,9 +3022,6 @@ static int __init amdgpu_init(void)
>  {
>       int r;
>
> -     if (drm_firmware_drivers_only())
> -             return -EINVAL;
> -
>       r =3D amdgpu_sync_init();
>       if (r)
>               goto error_sync;
> --
> 2.48.1

