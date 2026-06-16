Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F194ACD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 20:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640C310EACB;
	Tue, 16 Jun 2026 20:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="em9uVuUl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B4E10ED16
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 20:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH1PvFWGmxSKRLbOgCnbTpX8ayxT2scyfI8tjPosvxQtS1p+Wcs1jiUCoy7THrs6XV5SVfP+BoSMpgt6FtByZUOwhhyMsbRRGPQbPEGU9YK2q1STMDoEti+R+UmGGYLG+zYjHaQ2lsLDZICiLR/cU5/c6r02mdtwXl9eKhHMXw4KbGG2YamDuq+G1sWJe2Apif6X08W2MWC8MGvWogjXeV+5j2xAk94ENc5NcdAfXhzsx8d3LWNx5NKHt2JxeDYdJ+xigSB9a64sgl7T9px61tfDImV5qHoguF6pkrcbgrTHo98fYwkYRy9b5mChh57kfy0R0Z7RcRSbRDOsf9FSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kIdcD11jj4AzuZC/taowa2kcwmirbNzVj6Qgs0ihNo=;
 b=fOecQgJafi+TKGx10CM8T24iiUQu9PrF8cPU9Y7c3FSmdYrPPVhcxydoiIaaH80/zzs57c6OHw5fbNJL05PXiLL4Ff3690RE2pudLpwmXQsmKH0wkHjrmYH1xmWmggrBAifRiQU6EHZaRJ8iiSNsymFDVhPldIJ7RSepcwbU3JB/OsdY1/MOOsn/nR6tcyaVR8CVIaLElF01yYrseCQZYkwKp4v8ly2STq5wgX02a7ZLpDnR1EXwMiNNgQtjJbR/4wMno2ibC8u8aoXW+AjMEJLX4siP5nCuwk7KAlLJMWH9Onu/MvoBCt7bmm3Z26jrebSuvvb6cqrDFwp6CJaVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kIdcD11jj4AzuZC/taowa2kcwmirbNzVj6Qgs0ihNo=;
 b=em9uVuUlaknZqnG3Kctp/aelR7X/Tv7KxlW2DJypAZhRC5zdWg4/kaJQGupwtDASRKz75s8WVS/gtjexL1+wFBYkCHkpRwz4eFMhHfdgb0GngpD8fcEmn/XMsKXVCpdhzSetKbGbw3fmMWXwBVLJ3lY83dZGn6OrjhRfBHMaqcM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:05:12 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 20:05:12 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 9/9] drm/amdgpu/gmc9: make all vmids available to KFD if
 KQs are disabled
Thread-Topic: [PATCH 9/9] drm/amdgpu/gmc9: make all vmids available to KFD if
 KQs are disabled
Thread-Index: AQHc/QxcV1Q7OHIi10WRzluvIUeiprZBnK4w
Date: Tue, 16 Jun 2026 20:05:12 +0000
Message-ID: <BL1PR12MB5898E909166085FA5B3D511085E52@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260615211654.676386-1-alexander.deucher@amd.com>
 <20260615211654.676386-9-alexander.deucher@amd.com>
In-Reply-To: <20260615211654.676386-9-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T20:04:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA1PR12MB8987:EE_
x-ms-office365-filtering-correlation-id: e309c7ec-2448-45dc-dfb9-08decbe29312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: TE0hroBLUfuYnGq1/zvFiZ/SwjwwlStRRi3YcOEIEQic9Ru5sEFO43KME0H1qA0ze6dM1pwqR6MMj7au6Zjg9UL0rF78i/wLZHtxzdHs4nwL2oreBt3TtYgymWZgWtTXnNyTtBKT8CcbIUfi2f3upGytkSVKh4Sc3G67KwAhJq4jMurpDriHOe8+7bJ3k95qKaNMByUmnqN/iqQy5r0j5bUTSk8r/gHJPBSf+e8wje1nZqal54KeCqTWvkTnMXW/dwNsnTDC8eurhnvGLVcM9DZzOhsnMgHJ+w7cuLfRqkU4ZZ4Wnp26alqXenu76ReoAsR0SJWrGDQtsrx0qDxQGq1R0c2jEYVDc0Bl3+JaZTp4hDOb97BriUtAmxkd0LRAtrTTCOeIoXEOz/LE8T5NH5xgmiVQ7Adq7tcmydFLXky69ijwg3xfHsCNgWScux7abPZKuk/mGGvATGshEcpp0LlJdpou+UEr7LnrwsrVhRzm2sqzJEfp4phy2/0/y7GuAzfAcnDYa9C/NuOMskzsE1wI87u+Hpoy3V0UV/xVN0IWwTR/ZyVJ2eN5ntXTbsgXoFituCR40ukZ9UFMfaKEj6NcitupNxQ1fAvfIB7c0mlQahncBDdTnV82ezgd4WPoUhGgaAO1TJT9AvY2BXEAJXUaX1MkYgNBXjumEnwLbmHR4rcWqgqPaeBn7h7axpsxvz4oWObsxOfpwTVORfadW5KygMY/gZmmxDH1JN4FLEPgdu3soZ0jgRrP0Yo8EJag
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aasebDGCuMxxQFpYyv8+LZ3vZKq34FIfJEpIOYv5KieZ3/zRN7au8scmcSjq?=
 =?us-ascii?Q?ahMsK+cjIa3Xzxt+qXPIBIAwTClD8/Ss5MAG/j0Ksr/pkGs4dTwr/CQt+KXO?=
 =?us-ascii?Q?dao94JuoMMvDnE8SNk6DimjsJEJU1N8i0Y9MGhRBuUDLoX5r9SQWHIh1/MbM?=
 =?us-ascii?Q?YohZNIF9N5FR9Fg/ntdm9Hof08qsJ/piM0dC4wOzUw1oivpUma0EVJcEqVQO?=
 =?us-ascii?Q?Q4KqvcRTADhG1yG8yGOHCauVwo1yIWQVhLMPSTySEXBNjZGDm4Pwf+YcR9ln?=
 =?us-ascii?Q?ArqFkOMqPEJG7kxbIqc2VvP7pUQ75QYH/qv2uoCqLBU1m2Qa5ulut0LGxvkd?=
 =?us-ascii?Q?XAf7/su+OhVnmAjnuUY6C8A2zjthFtZo9+U5NG5ewaqN8ziTFGJSUOShbriV?=
 =?us-ascii?Q?c/Tjrms7zxDfKB5RGJpadCFo+tw+5nAFW4OylDvB5zAeTMkTux6ARvwOmxUd?=
 =?us-ascii?Q?JC/g1vIGZtEjFPo47OgyeYvT0PvAXgguDvQfzdpjD4YhZ3CJFQWnaylMZRsz?=
 =?us-ascii?Q?PBilgMlQ2Zqv1UsbYclu+ZsRGecYUbuvXAfKSyWHmnzJhhdy+H45BIXzDege?=
 =?us-ascii?Q?yO+vP2dmcHjZ0d5yhlulAjKMySQhoK9RsvTh1F11x3UxjQY7l0wPcevPMXgz?=
 =?us-ascii?Q?1n/EkdlM6BzNWDslxAllIzB43FlUtPXnSB+4nX5yGbPyirJAx6Cc8rrFP5yw?=
 =?us-ascii?Q?wuPmfpQ5ZSVmSKoCUg60sEGilPlvyab/9/AJ3tT5uqYmnRi2fNTj+uAsyNTp?=
 =?us-ascii?Q?3ZJ5ThtHIwqgkIiowVIBogloc54AkXrR0dPvqSkxvtRe2EEBIigrwwEmWG0i?=
 =?us-ascii?Q?lpZiSDa0ZVWu/rdoB0qa71XORCBUIumR1Ip7K6kyA0pmdc35D95Cq/7zTvgo?=
 =?us-ascii?Q?R1ko4ddsGCP6n2+CCn2B9pLg7evltvoS3w6ZbYoXsgwTlNBB3d6ZL/tHTn67?=
 =?us-ascii?Q?+RSvb26zJAzNvNMYQBnnr9AKqfcEI6vhj3FW98AXpPaoYwDIR5Kj5Xak6+Ql?=
 =?us-ascii?Q?932qMT8i9InHSI+EKCghcnm4aUG9AOpBTZVWYvOnSoKl/lWrBZTrU1K9EXk/?=
 =?us-ascii?Q?2SKZDZrbTg054I5bUYMjbbByFEsa09J3tvhAJF1Y0t0wXV1aK8OSxN3JoaZ7?=
 =?us-ascii?Q?merKGF3NG7zCa2ZVT65HW8eHQ47moh/V0GpO/Jiu/NwVsQKWvxpzRl89OOwo?=
 =?us-ascii?Q?eKs+GBujKQDJ21LVvIWIoGll31c0Y+TetdfyERo7KVflgxPr7WJcCsEK2kjz?=
 =?us-ascii?Q?xEMoTlb8Us/Pd+jAs9CD5dUTkZdq3alajdhZN5w2nTWvbKjgZwdVXeDL0ZiG?=
 =?us-ascii?Q?KE/FIj+pKl9fr9HlngPeQdpYpasQKakEMXWX13n9DMAMoAJQp90fVhn+s2ZC?=
 =?us-ascii?Q?KTM7uRPmZVQbVBDRaLvP0zbIKO9l0Iza4y1oUKQgruwSOE5J3Xv0bYgBb8Jl?=
 =?us-ascii?Q?6e3nyPEPGOkO8j2jOpjwL54xa5Nk4QjSIzClzSLfYsyHUZ+ihptaHvGbtdS/?=
 =?us-ascii?Q?oXUsQhYz6RAD5OqcymnCo8KFH43tuY2Mz2AXqI8hlv1jwAk6CGGcFLAc51xe?=
 =?us-ascii?Q?pQHqoG1Pkz9reLS1lg6yPWJJnBGeuM3LuATe7dPGqQ4izSgDPvm99GBPSYdG?=
 =?us-ascii?Q?389d3hCzeOBGcuv92dhVhb1vxzpuco9P7xYZ0S893EgO7tAKHupD1BReCZXR?=
 =?us-ascii?Q?jyypNQuXZ8/hgjWpNu4/JEnhencR+dmZz3uBIo2+SnagVhBk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e309c7ec-2448-45dc-dfb9-08decbe29312
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 20:05:12.3345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhgKkMvmYzKoCb06V08E/vQ90AD16vrTC1piEOVgq2vdLmp/Jnvh1yM6bnwO3m6UemS7AK/TPF59kkyOlJcWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

AMD General

Series is

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: June 15, 2026 5:17 PM
> To: amd-gfx@lists.freedesktop.org; Russell, Kent <Kent.Russell@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 9/9] drm/amdgpu/gmc9: make all vmids available to KFD if =
KQs
> are disabled
>
> If the user has disabled kernel queues, then make all vmids
> available to HWS.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 8a5c44810ba1e..5166055c6692c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2025,11 +2025,19 @@ static int gmc_v9_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>        * The first KFD VMID is 8 for GPUs with graphics, 3 for
>        * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
>        * for video processing.
> +      *
> +      * If kernel queues are disabled, allow KFD to use all vmids.
>        */
> -     adev->vm_manager.first_kfd_vmid =3D
> -             (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 1)
> ||
> -              amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 2)
> ||
> -              amdgpu_is_multi_aid(adev)) ?
> +     if (adev->gfx.disable_kq &&
> +         adev->jpeg.disable_kq &&
> +         adev->vcn.disable_kq &&
> +         adev->sdma.no_user_submission)
> +             adev->vm_manager.first_kfd_vmid =3D 1;
> +     else
> +             adev->vm_manager.first_kfd_vmid =3D
> +                     (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 1) ||
> +                      amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 2) ||
> +                      amdgpu_is_multi_aid(adev)) ?
>                       3 :
>                       8;
>
> --
> 2.54.0

