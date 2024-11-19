Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B989D60D05
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 01:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC8610E2A5;
	Tue, 19 Nov 2024 01:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SI8d7Qkp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBED10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 01:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5Fn2ipDaSzp1hIGdAMr5XS3zkWVU8k1fsGlxPDYotMwNhRo7Z9xC7c5aFf9ja3NzIw1xO61jGm4rFBiUIbnPw/Cot91f/EYamoQKYriFFsVQjum5a6xcwuLBiMgjl3E7RJoEEO26z9lTzkERDl3hT0o7XstB43uUbCOeiQv7vVwNxAlhWjSaASXUVFDfqh3JWSReLo2zUxzJEPjvhW/am98Lgw6zBI+XWyCL03VnqUUFkVoO9K8b4dDBG8Hj3eqOWLTTEnz9f20NPPcBThyV/3/Rv7zkUWZyNyww7/1RdWs/B8Jr00rPjynVRAHVDjoN4ZZef0F4C6XDmOkX9nSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcKs/N5OLP1ZtwpP/6yQkcmC/r7blQZAt4EJfLZVyvU=;
 b=qSZNkCdUlfvXZ1JnEYzrxoaoUkzZtGcoW+GLlC9d2xcI2aTPUm03eg3Vbi1vAQyqAHSYjea6SxUJx+HPtnzzJv39wxbed2ue/XRQhQhf7dsffvBXmxJFFFn9nJgvJxHViXdFDfqoZp5IHeIXqLApuwq9VoxIWkFoeNU0ohWKTGfGW5xSWbt6YNZdDhrhS5MF+BFpNlctJywJIl7X/ckPjnD3/XLli6YhbYvb9oN1LGhaZEF/qs+PcmzPNe8yYvhmcjJHifkzd5jEIVwel3/vzwewkORPRJsGQAzzErH3gregv0bWGwu17+3RVEir1vZPS5t8EeYS0FfQXB7lheLFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcKs/N5OLP1ZtwpP/6yQkcmC/r7blQZAt4EJfLZVyvU=;
 b=SI8d7Qkppcp1XNaIn8g/3nyfe774TE6NjUZrjeLhNPo9yMppuaPEJrZmqDdfOqu4FWvE/Uv+W6X+t/ibWba2lwMzCWPG1EMQX3030v2hiE1vVOJwsrLskLwkKI/HddLuJOxSwNnWJbvUd9tG6Hnu90GIGkl/9OmOZg/QUAsBab4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 01:19:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:19:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Dong, Andy"
 <Andy.Dong@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Topic: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Index: AQHbOXLc1Inn8rabrkS799Mil571ubK8zdsAgAEAf0A=
Date: Tue, 19 Nov 2024 01:19:22 +0000
Message-ID: <DM4PR12MB515296DB6EE94F3AE0EA948CE3202@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241118043128.3834919-1-jesse.zhang@amd.com>
 <20241118043128.3834919-3-jesse.zhang@amd.com>
 <582143c8-b424-4b1f-8aae-8ebbba8a832b@amd.com>
In-Reply-To: <582143c8-b424-4b1f-8aae-8ebbba8a832b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3ed6a279-9a64-4708-ba1b-cc76dfaa1fb7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T01:16:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB5843:EE_
x-ms-office365-filtering-correlation-id: f07e8053-6dcb-4cbc-877e-08dd08383368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mHRt7Jh1BtEHFjJOXc2lRJDCCzHQrBzHK9jKXwuEtVtEUIHkIqkuOfKIHn4H?=
 =?us-ascii?Q?LAGU7lt71euwfnwXZFZBt8jF0Kr+Oeps3PErDfneBUVn0FJ/bqg7jDCUljzo?=
 =?us-ascii?Q?ubSh4mmfNN+I3a86Zdh9nE1Dmb88NVDkn1p/m+kvfAxCxxD2ze68GlIkcBQa?=
 =?us-ascii?Q?u/hKZAVnbBporBBhCbquY7srWIJPaabnv7cjU8vX/rmiJcUeygxvEJjb4cjQ?=
 =?us-ascii?Q?YoOguX+aW5a7rtgb7IWF3u/aRIQKjwi2+MRh2g+3GgT7rMJJfqXhDTmFtwrf?=
 =?us-ascii?Q?O6R8k6ealhaZkI2hKLcyy/SCMHMrh/x5bnrdG//nzEgB5DjTGJK8URmVQJfU?=
 =?us-ascii?Q?u/clICS1/IEe9dvJCGtHiG5NNY51d4oeZv6I7iUWmbN8B33d3KEZ3taIC0n5?=
 =?us-ascii?Q?CHhyJk8pfmTQJJy70eV9NqaWAiFf6uQjKeqvyxTYhZWDgjtQV2cSftxgUdZt?=
 =?us-ascii?Q?/8AIiaT0n7AvMyoSnKWH3E5+gLMCUxkB0Ne0Rv+SRQKu5lfSO/zsEg9E/IsI?=
 =?us-ascii?Q?lABnBgG2WjR2zP01wIyfEXL1s6HFCAY4mJXO57eJMkP46H/5VaGUngOApnVz?=
 =?us-ascii?Q?GZIxAa3ZNh1lIjN/Ishpk9HkZJeiA8OYocBO48wtKMdIb4kKy3jmD40aCSik?=
 =?us-ascii?Q?o6OmaPwIwLjbTw12YVmfU9XATAfGqE0qbdp1rPel4I5sg3+Djx2+0By/MG12?=
 =?us-ascii?Q?/ldF0bLaAB+/BZtbi0k9QPJn2cgBmkgSOQj6k03T0TO8uZkR2eSjfigsItw7?=
 =?us-ascii?Q?DdFpuUfAuZsUJLYwyZBSK6f/9yJYHur72L0cvtaVUa4Ru1w91irFwHey6RjI?=
 =?us-ascii?Q?WeWTlL8hnAs/Iaoqk4wRgInc+yKYXtEJQU1i2hI/bd/O8BQmgvG8OrK2lEOf?=
 =?us-ascii?Q?j/hurts5a2JPBK39F5+6L9HrrLwB5zrm2JggZd/DxwRDFDqctdQMU4n84eI2?=
 =?us-ascii?Q?uGeBOr2dQoyZY32U/4w5MyI3MYCz3vbmakHyIckjh1Mgce0FZ3Nx/pKXYCxA?=
 =?us-ascii?Q?/GFBLMWUnStPi0dAgk2QLrt9GH0lERUlOxFOlFtvjlGOtSaqbr5XQ4oZG4FJ?=
 =?us-ascii?Q?NzmfB9T1FUF2qyT83zOx41wjfnbJiFCo/aOnn33qIwoChQSlzocpq03VJJMS?=
 =?us-ascii?Q?RXx7W5FhKuRK/QUPZ42j0+QMjE1avCBUhNuKxfpxIiVGzL6ZnO521dK7cOsj?=
 =?us-ascii?Q?vQi8XceBD1FiQBHzBc9Jy2AgXokICRaq2g/lNgBpsF5T68eCf7ZUvq9kUV7D?=
 =?us-ascii?Q?cHwNM9JSP2z+ZWUIknLtXcyHiX65O6lRqPLOX1hsftnb9hB9oNR40O3PTcpP?=
 =?us-ascii?Q?XCyov5bTMveM+NMoz4ZvqMmFGk8yVFNjTj12uosYEFigqJoh3r7yqJtl43RW?=
 =?us-ascii?Q?3ouQVWw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TeMndFR2VXLXC+jS1XiHvoFIcW4s6krrk6O9nsnz0w1l4H3g3OLFyC0haJYM?=
 =?us-ascii?Q?zhd3ohwNuh7rV2JiYr5t5fW0nxny/oGPqK9PUc+moub3mkMdgLofcm9q5R5O?=
 =?us-ascii?Q?Q0Hjz5NoUoxR12f7ePwGHJOOU1006MpG39lUXiM977VacZjePMCf58xQPPju?=
 =?us-ascii?Q?SbdAy3NA77ygDqel01OaTRNuRhjYmPnSJg4sD2RFkMFyRyX0wJ+cWbNotFrZ?=
 =?us-ascii?Q?e2My7ndkF2Q5Pla6vLOuuR5bYV5N5L//1BbosaaV0Byd9Stpri/d+ubH6Y50?=
 =?us-ascii?Q?oMFqIctdCeDB44QfzoXUG+eXZmd33FDCwYV6KpbSm1rPu/vEPtLvhkgWh1W3?=
 =?us-ascii?Q?h8zjZGKYZn2xVCbhHoOn0B90Bi81ktDOajBlGSYxOsZKaghTrGuy0ZzGjIEt?=
 =?us-ascii?Q?mxjvSngaZDOIWYHi85Ju/eO8aRWsQaffz/BtWcIyp4H0Q3JvChAMnSgDOqPu?=
 =?us-ascii?Q?och0W9f8ULZZqgO2QlkqgffJlwHNVvPmS1o1N6GY+o9wTvW1Qtl4kZpggJyJ?=
 =?us-ascii?Q?q7MZHeklaLjz4VtyUxxPQXapW8nfiIzD08LXI9xrrekp+zrWwvspH5H6dUrV?=
 =?us-ascii?Q?Qr/L/O06Pp1IpShV37XJDxCC5mrJ1T+HsT3XXmJxSFrfC3AWBTPlREe44hur?=
 =?us-ascii?Q?3+71beZWxvHjPpUXwUGbE32Db2oCfnU5My6LonyMGQNDrWy8E/pbaXxEwsDl?=
 =?us-ascii?Q?F11B7mhN2J0nAAl5lvmPXAc5CmaoN1xlrQaj5KNKvP9868OEguOELdxXxZZP?=
 =?us-ascii?Q?Tmu42IrDpKwQKMUFHEIw1SfMjwpwGkCHl6wYiLlgeH3XQqZ0ovnPM3yk4VQ9?=
 =?us-ascii?Q?Rm30Pizm20W5Thx4yMuOrHh5eLg4cG2HRa8IM6yXZjAvRIzavQhjSayRE7TJ?=
 =?us-ascii?Q?omkRPFOvz06HIMoZmDUwHgwyVzuZ64wo+FgmL6cqDCRM67vZjE/R4eS2xThL?=
 =?us-ascii?Q?s7d38arppDM+3hgj1qTXNAb0j+2BATzlZCyW03Dv+7sohxf5XdjUAcN+yMU1?=
 =?us-ascii?Q?vMhSd8m5B3vNZ9BHHaqprt0FM97U7+3khwai4xdjYcbPkEccJJxoxpP0sEXm?=
 =?us-ascii?Q?IlkRV/12xmflesDqY7Mphx13UmiF1bGFQMtZPlIHcvwk8x3aYdn5rDXB1juE?=
 =?us-ascii?Q?V6rIkKL0Eqsqx12b8TW12iNKyNd/vyjOkKtZ3iT7oFlgsEWT528s9SdJhoaf?=
 =?us-ascii?Q?QMDBHC3Wfgd5n1rKrg7NIm8Ioz6niwwkNtq4pPRJC2W5Dzg8uwHjCCHg7V98?=
 =?us-ascii?Q?05asbRF8qQxkoTI4qv/YJOH7pu7HNjw2WxRyB/gmk3R1Q93gJDOTTP7LdquP?=
 =?us-ascii?Q?REYEqbdIOv+FCPoJ58udEwtwvVs63LxisA6vpmE6wRmuWFlJECE2paXbgtXi?=
 =?us-ascii?Q?2K2h+eq5TP+gLPLEA4wfHZf1m3C68TSl6zEmYewcS+OvkjFcufQ+Mz4OwxBk?=
 =?us-ascii?Q?zC4cHhDMtitM8BE68mS7P6tjDKnRDLJvjovY5k2AoeGNSOCmFgndeqLCyBK8?=
 =?us-ascii?Q?bgagkhvi7IuSq2rnyT06se3GGd2lfctqJDFhpDxp21PVJ2ShFpa4ou4B7hD7?=
 =?us-ascii?Q?lhdnFWIk7YBaxjMtEZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07e8053-6dcb-4cbc-877e-08dd08383368
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 01:19:23.0044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdhocoOxcL4osdFV6wqaNdNVtn6bHuCXnPFHkHchb8AUJsRA3IJA3vlCzqLu64wixT3y/NBLo//9oJNbTQE3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, November 18, 2024 5:58 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly <Vitaly=
.Prosyak@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Dong, Andy <Andy.Dong@am=
d.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging

Am 18.11.24 um 05:31 schrieb Jesse.zhang@amd.com:
> Replace the check drm_dev_enter with sysfs directory entry.
> Because the dev->unplugged flag will also be set to true, Only
> uninstall the driver by amdgpu_exit, not actually unplug the device.

Clearly a NAK to this one. This looks strongly like you are just working ar=
ound the issue that the functions are called twice.

What exactly is going on here?

This warning occurs when running hotplug tests in IGT.
When a device is unplugged, the PCI bus removes the device.
Then uninstall the amdgpu driver, and many similar warnings will be reporte=
d.
There is V2 about the is patch and update the details in comments.

Thanks
Jesse

Regards,
Christian.

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reported-by: Andy Dong <andy.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
>   7 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 3c89c74d67e0..e54f42e3797e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device
> *adev)
>
>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   {
> -     amdgpu_gfx_sysfs_xcp_fini(adev);
> -     amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     if (adev->dev->kobj.sd) {
> +             amdgpu_gfx_sysfs_xcp_fini(adev);
> +             amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +             amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +     }
>   }
>
>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 43ea76ebbad8..9a1a317d4fd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -     if (adev->jpeg.num_jpeg_inst)
> -             device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->jpeg.num_jpeg_inst)
> +                     device_remove_file(adev->dev, &dev_attr_jpeg_reset_=
mask);
> +     }
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *ad=
ev)
>       if (ret)
>               return;
>
> -     device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev, &dev_attr_mem_info_preempt_us=
ed);
>
>       ttm_resource_manager_cleanup(man);
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..113f0d242618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_=
device *adev)
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
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 60e19052a1e2..ed9c795e7b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>   void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -     if (adev->vcn.num_vcn_inst)
> -             device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vcn.num_vcn_inst)
> +                     device_remove_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
> +     }
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..dc96e81235df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>   void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -     if (adev->vpe.num_instances)
> -             device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> +     if (adev->dev->kobj.sd) {
> +             if (adev->vpe.num_instances)
> +                     device_remove_file(adev->dev, &dev_attr_vpe_reset_m=
ask);
> +     }
>   }
>
>   static const struct amdgpu_ring_funcs vpe_ring_funcs =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..621aeca53880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
> *adev)
>
>   static void df_v3_6_sw_fini(struct amdgpu_device *adev)
>   {
> -
> -     device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>
>   }
>

