Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31508CCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 09:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD16E10E1C0;
	Fri, 24 Oct 2025 09:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="woaZrDFW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7362610E1C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 09:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPjTBc4Wv1DdGBP8OexL1R0J+9jTEcrkSDOvzehDG66z98ITGSLvuKTe63HA4zqRbTMPZAReic4JYSByVCMdo/oxi6JKBEJK5W8B+WipuTMJQPBZSS7mKcwdpzq8q9fm8POPHEXcqi2qsIIH1ixDM0svdK9RBAvHYnPUlqsJeqy0vQaHi1F1WBAl1y0QwMbI3N5WnpvWkmrGO7traGGPV/HYGpYlekzgEmBsBmrRrL1BHpvImcGPOqmGpbhMPMttZyQ3ZwyAOnMx9WseXH+yGAawMO49XrgrMV/gcWK0PVOXh7duSLCWhjAeCyw9xD7zyDBHcdiJcgh0X9H1CxusGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSM5v00TOtALwJdv+NfJA9fk28QUgM4J5KkJWYVEIhs=;
 b=Y6VvAoQU1PugDFpD09z4drXLJd1XvNBc5UxvB1mg4PmFdFYKEcsOGQA42BUpTspdQpL8zC6lidSyXMhFRvRGSmoEkeFOeDI8JChPXsbeTsKnW1F+Lnz5I8YQjjzRJXkrwZA7svlpzEbiaVactb3Cp64++udGyPmifJLzL+rgV1/ZpO/DoG8TMK2ae5vhuK79YSvcYx/+anKDgZsNU1iVdjocKLrVmjvMlCgumvXDc+egspCh0LUc9O9WzZPdYAgm0+UaBra34JBm6K4XF01FX13S7UJcaj0ZNa+RMVXeuX+KyvFz4XMvAVvaK4XrOaOgmA3YBdQk85RPtJ8JRzvH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSM5v00TOtALwJdv+NfJA9fk28QUgM4J5KkJWYVEIhs=;
 b=woaZrDFWglF4I15m6IVTlxM94atECn0kSTaHT/pGGbh7SbAs7stN5iMd0MxNyZzr15rjS6YZV0T8jK0cC+vUnfdU43VMScFXxB3nJ7nVU34en+G1SsgQyr35jCS5VMA2kt0zL2VZkmDRJYwYwOQ7j/o9tcunjjW+YajAbPntw+M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 09:48:30 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:48:30 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
Thread-Topic: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
Thread-Index: AQHcQ5nJ+svnMk5Av0u5S4W36DgR2bTRD24g
Date: Fri, 24 Oct 2025 09:48:30 +0000
Message-ID: <DM4PR12MB5152CD1FE8415EAD4B995529E3F1A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251022212026.1785896-1-alexander.deucher@amd.com>
In-Reply-To: <20251022212026.1785896-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T09:48:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN0PR12MB5953:EE_
x-ms-office365-filtering-correlation-id: e7489f68-f28e-4b96-4c71-08de12e27d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?U4dAW6Vdc1lb0X3HsLXV4wWFOQas9HWJEUrdFgDG0DD/BJ94U4kebU7uvXDw?=
 =?us-ascii?Q?dp4BEb1nxYKXVnM8mOAXECMfPzO5SEPOabd+9lvlGUIwhRgzld+U5mTG6l4F?=
 =?us-ascii?Q?x9EcRwi0xPYlacPpUmvOBfYkKZzGLX7NTnxpr1UOCHEJcnnzo6J/WNR1FEph?=
 =?us-ascii?Q?KNXiVuk0zBCtX2+R/cq/0MzUcezfrnzPdV1yrHa+valQkCW3nxLArks2cXTj?=
 =?us-ascii?Q?3KlTqWOcO0OVLGDn1tyLO7vl9hw3oMZx8sjFhq6kJNrYXqsPTtZ/ekLsbOPq?=
 =?us-ascii?Q?fcAaxfa/paQPaGbBgS9tC8AHgxg0bFcuYvKF/eEj+SaMYk9NWj7YWr5Ouvs4?=
 =?us-ascii?Q?pzVIZKURZOvPTLWQMH57ctaS1/ripIm0fFSP29keS4KcmTnkmXFI8U9npTem?=
 =?us-ascii?Q?COeZbyKTWsv8TtI6t0YxE09pdvOy0iZ6vdXX7XuhSKVZwJsMMhjGja7vz1oV?=
 =?us-ascii?Q?82DgReAGCoprGSofRb7GwjJdY4fdlklT8CtPrsPREhw3HkuQgk3TV8A6/QXR?=
 =?us-ascii?Q?8IQQp5OYrwtaKN2TXrlDiU2sZ8raCXy8rdtetPyW0Ja/9zFx2D/KJfVtoeJd?=
 =?us-ascii?Q?j1EinIffnh5xUpM/Lw//FTYUK8/DZ6bLBit1AmjfkJKR5hzjrUzGmJWExYZQ?=
 =?us-ascii?Q?xz3Vz99EuOxlrRQUFk6ihiAO/ws5n7ukeIba1EStgCg2FytgGZXJfrnM8sPf?=
 =?us-ascii?Q?0ygfjoVDUZsNPD9iOPToWxguVggYKlnW7+eiQ9kLnT76Ru4mVKmTbVq9pGXr?=
 =?us-ascii?Q?iI8WFfMRaaninbP1jI5OLNoNYmR3d7PwSrTcobgCF6ZSDduT/if3J4jM7Ood?=
 =?us-ascii?Q?uF/H8FH+IHwQ9aFBKDEW6QlzkEOV707Mgiuf3IMpMPsbhrp/upFAvjylnIIx?=
 =?us-ascii?Q?tgpiE9MQB9P6JXFzrG2gXxUyAb9uy4na38H+hVBgo9wvO2QghJOl+9OpIXKM?=
 =?us-ascii?Q?de44B4OGFjE5F/t+u+Ssf1Yi0qls6/joFxa7AmFy9jBO6Y0ecmjJz4WmeMIh?=
 =?us-ascii?Q?Id2ZZJVu7e0SmbHIZ+fi1XzEe7atlbYwhExKda95yfFCmgHfklu45PQV/ztE?=
 =?us-ascii?Q?mKg0hv1CzMiEKHXmD4y74qQcZ/blEglRtVFYO2AoZ1kJyP4LkGX3VEX2RWRq?=
 =?us-ascii?Q?s7JZNNXwcn3Ve/bHiqQCC1TMv8GrTfqAtpSm89vbOIIhMCc23Ak3G7wMiu94?=
 =?us-ascii?Q?HzOK56ZB4e9RRbO8uSW91B2C/HspMigkDpdavv5rtr2pd9rI/i+V+0AMzldj?=
 =?us-ascii?Q?X9a+VXmfXhXbRED39sh/EEE+uYzuy22KrOKBmHDNWosnR2ZkPSBAv+wnLpg5?=
 =?us-ascii?Q?iWZFXM5id4Df0kAlCsrh0dVOprBNU/QRpCSBSknZR8H9N0rCNAQ1z0DYNhyv?=
 =?us-ascii?Q?KwfHyGdOiHlW2q9KJ5+Z71dT1milGPNZBHM22W48Es+q7nYLYY6rjaszj/10?=
 =?us-ascii?Q?/4wyVBnJ5rOaJ8RfCV7B0M8ydRQ1ebDozUoTeJWqdi595i+S7UM1pgAM6uNl?=
 =?us-ascii?Q?mpTfYfypG8eiV0Q1uNff0N5FDpegNVsHwJRk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DMHJHeanEeNeYdekZ+9cgjyppoyAykgpEPw3PfFexPb8o4zngreYtteM2STL?=
 =?us-ascii?Q?4qWonC8siA+2ItE6mcxoYhdTDEH4reIXFxCEpnyXW23BmaOJVbkZ5CAxCxW8?=
 =?us-ascii?Q?Aks3LLxkuzUqmr0dyw5N3/3jDZewDnSDaYVD2EbZnpqDFWgVJJhMAZcLT+Ff?=
 =?us-ascii?Q?zz/Wa7Hl7xjLzgALxWQ0N+zvV3qKSEmqPH6phy3jYrN1xXoubPvTch+TwgjI?=
 =?us-ascii?Q?NXmQ4WykRGITi7bZPu4Owd3nVeavRPq5UV/N/Esjld7ZyoMOaRdbSb2zMoW1?=
 =?us-ascii?Q?xwNwYbqtDlK3rgq1TSX7StW2EYQuadEPd0fHL2V2cMOr1HF2zc9Z1Qqs5ZJ1?=
 =?us-ascii?Q?RFNeKOCQgrb4UMdB8ZxZxKDFV4LiR6sd+gtrwBtenCg4Xnjz0EB7FNf76T3d?=
 =?us-ascii?Q?EdNTZQajEh02FPXX7MeNX/SPDEdcYCV8CnrI3LYVxWCh3+JBQZa7bWeJAQzc?=
 =?us-ascii?Q?gyDXBEFduO3d6G8n5kX0mxHWGy+g8KfYgFqmsybZ/a7IgggSAe1oWz+nqgPZ?=
 =?us-ascii?Q?AWPDSWkR8T27flZGEa8PcmrYROen8cVApAjrjzKrADjxrd9FwIG+6ql9b9SK?=
 =?us-ascii?Q?uRX8sCDrF4fEGOBsoQtlrsXAdYUPpBXOmlrKUtWXGjYgtuXzbrjPz8GwPnj/?=
 =?us-ascii?Q?ffzbi2P8rgKxcXe/D1OnBs9jH5QJ3rQK/dAOgeGNd4xFwIg0PAhjyPJJl9Uz?=
 =?us-ascii?Q?KEEhsI54ou1BJp5wUgdfePoRrb33mTYDEFS1VpmfDSPYvlL+B2YV/imDZYTI?=
 =?us-ascii?Q?oQwd6xr6U6Z+5rmgwDh91z2QrhH+MFW9+diIhgKx6eZybhuRrgwFuH7Fa294?=
 =?us-ascii?Q?xXtnJlDGp5Sjt/8Lr93xxoqsUt5ANGL14Q5Up9neAYsgqcgX2/UwJlmfWZQ7?=
 =?us-ascii?Q?6Nxi4OEBHTttcruDf5Khplr48ZPHn92ehTMySNcBObhhwBOplU5/2HNMx2CL?=
 =?us-ascii?Q?laNV9rjQM6kK9TYkok8BsaiFqfUWw9UpJ3rIvNOdRGPIWyMtJ2cQ/vgVTMEf?=
 =?us-ascii?Q?Q615UE1Qpt7gRig0cgMgAUpihSbZ9c4n0eIabUIRnxv6LMG1y++ApD2lTaOs?=
 =?us-ascii?Q?tu8GFD0DUjjMdJuhaRyksZysWqOOjw4w3If3RZorjj3H0zjgKNjvuzG9XTJ5?=
 =?us-ascii?Q?vjgSNTxlk2COjZl91MxRIK++sWo0IncA6PXnLlwt/JymczrGzvGIRPI1gCOu?=
 =?us-ascii?Q?efI+f1lCXvalfljFLHyQ1X2ywnGxLNwLW0LUm8WxcXLnMMRkZyNxM2INSqkz?=
 =?us-ascii?Q?VvWrHqQhHkP+7RoObEqIl23Hy/6DbYrdbClW51cUzOv+aj+QWSBWA1p4Ii3G?=
 =?us-ascii?Q?M/fHHb+QCmQvtM/mAcZyatyMnw/1DvFFG/72ZoGaJKqr1P8lUAbhaeuEBZcQ?=
 =?us-ascii?Q?yjzTem1Q92uePpgV6SUNM+PL4ligaLvj+VzG+50I3LtjOTwlpz1W0wPouUAH?=
 =?us-ascii?Q?gpIT/x06TMjgbYXO8JpCdsImpRDek+1nfS/h76vfoByzHANXs0N47/n49La4?=
 =?us-ascii?Q?ZOr0pJ1CCOd5AY6yzCCreZ7blDVJEo+QkbPIJXns7iRdZoRRQ+akpQ9dtNte?=
 =?us-ascii?Q?nWm1T84Uz7vxgNhJado=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7489f68-f28e-4b96-4c71-08de12e27d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 09:48:30.4630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYrNbJbrhibr8DAkXhXMgXrmsW3C4M+tUM5VLtjeCQCgZz8AiB0KIpWB7LU9/EZ1KmRC+5vJspkYU7NiLmM1nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, October 23, 2025 5:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
>
> If we don't end up initializing the fences, free then when we free the jo=
b.
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3d396ab625f33..8ad8b16e96760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -295,6 +295,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job
> *s_job)
>
>       amdgpu_sync_free(&job->explicit_sync);
>
> +     if (!job->hw_fence->base.ops)
> +             kfree(job->hw_fence);
> +     if (!job->hw_vm_fence->base.ops)
> +             kfree(job->hw_vm_fence);
> +
>       kfree(job);
>  }
>
> @@ -324,6 +329,11 @@ void amdgpu_job_free(struct amdgpu_job *job)
>       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>               dma_fence_put(job->gang_submit);
>
> +     if (!job->hw_fence->base.ops)
> +             kfree(job->hw_fence);
> +     if (!job->hw_vm_fence->base.ops)
> +             kfree(job->hw_vm_fence);
> +
>       kfree(job);
>  }
>
> --
> 2.51.0

