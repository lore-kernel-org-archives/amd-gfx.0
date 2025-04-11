Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BAC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C045F10EC00;
	Fri, 11 Apr 2025 15:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jvX9nRTB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C75210EC00
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSUKG/ydIkbd1/uB/8RXd8ov+bLdifI7UFWZvkSgI2ofwtTIz/WOxdO+FQI5g2IMocoHCH7WHNx3xhiHKNzBu3HjCh3A//kPKKdFeWaJFlE52HFOF6KL2GNFP93E56pGgDBRmbWA68uJ+3cnqvELvUvSYKJxCJ0eUgvgHgJe6Q0y82htDJll/ZZfvOjK3BvC42E3YEoPQwoCL+HvsfB/sieCuLwkSwIJPtdpAxlMuH1O7FOw+UIzdY/KVQViWuVENS6Vxdczl3HPSWPsiOjopsuJYD5cN3yLBqZd3EDMWeGh5eT4HfhQVO97NEqRRlkfhznW+xz6/GAZi+nfAmjFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvPKy0IfhzIgWTs6iFG0WJ2uLyumqRVBUXrTxkTCa1w=;
 b=gSWtgvKkdhtV1dtDcEyIeWPvmI/w3kRc03rq8lWjrVstIljBc9o9nxjXq6q0OH15ZbCcsWRK7OEN61EY5gHXkPx871lgPpXZQYR6Iq1fvm0y8NKUMjwVADK5xCGKgLhdA22VI+9S70I7a2P3v1kbYwFGVbCQnbYor5OtQ8X25amU5tdrtBN6Mzag9uNbHTjeA/RU2RYu/CKQXfKogvohzhsMS5qUhoh6FnAXrPLG850fkcSnjrSfFXtlvsdyQ+F1jSSiaDE3ieL2x8ZyY2T6vXnVSod6pRovkih8QXUO5/fJ/PiroIWCnNdffzfHIYiDVqr+06chlDmgei3TkYmN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPKy0IfhzIgWTs6iFG0WJ2uLyumqRVBUXrTxkTCa1w=;
 b=jvX9nRTBKboNt3xvi+SgIkXRHt/yQjz986LXsCbb2Q6SgSyUXhwUnCrbpVpphrz/GyI5X6hjWV1nEk3uzPcK4hgxdJMt5hds5T6LRBKYAohHoSn0+j31ZSFTLJ8sRK+VPM9X/zVaLeWPHRSs+N6I7RO296Yw/eSWH0BmEbHErss=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 15:41:33 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 15:41:33 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Xiao, Shane" <shane.xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Xiao, Shane" <shane.xiao@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add rec SDMA engines support with limited XGMI
Thread-Topic: [PATCH] drm/amdkfd: Add rec SDMA engines support with limited
 XGMI
Thread-Index: AQHbqdK4kddjr0uqx0uXHlNfwZkUSLOel/lQ
Date: Fri, 11 Apr 2025 15:41:33 +0000
Message-ID: <CY8PR12MB7435088226B4CDB5B1C924C785B62@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250410043956.559468-1-shane.xiao@amd.com>
In-Reply-To: <20250410043956.559468-1-shane.xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=eb7f7432-b4a0-49db-9874-ecbc5fd633d9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-11T15:26:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ0PR12MB6856:EE_
x-ms-office365-filtering-correlation-id: 1366585a-c382-4fc1-f9d2-08dd790f5636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xWhBArAIytlv23bX4OX4lZS5Fq6M2384ygtw/ueynSGIvjVyv3qJLyT1np3v?=
 =?us-ascii?Q?cIbUJ+ElgxGepea5Bu2w0jAx/vcZ8DfzEzWQnv3K0PtJXCsdgyVWRZLChUVy?=
 =?us-ascii?Q?KA0R6yT9eDx2Qh/6jX7Lq4MUQXZ3LEmz8j8VLTt4lBAT3Y2OVPnuvDw7os35?=
 =?us-ascii?Q?pMXS1y8YJrBtYtnALhH/4TxnHu5gGdMW7FvR4ZLqABIwkS81xecvfqD8AoZF?=
 =?us-ascii?Q?vsu2VjVKb5eiaqQjKC8/Cx1I3cqzBFlVQM469IGY6RYdr/q71nDF0tT5g68+?=
 =?us-ascii?Q?0kxHi/JnY2qht2XKO5zCy3BDeLTVeIRJ58Cu4zIsindlFvHBwMHDQ6bDnmBq?=
 =?us-ascii?Q?OYQOERQnAmV2580DVGqo3F+NPsaAgVveKwV7Sok7Z1PWywcxUtQUpNy8/L5Z?=
 =?us-ascii?Q?eoxrfbPKbPJiE5Rt/P+VlHu9qT4nk0hm5NzByYeekX4xoZcAOvVhFQ88DeC3?=
 =?us-ascii?Q?6JtKfcQVBZe5f/NAbI59Ae9X9ciy4zHy69STmIwa5sVN3cbK4ugfklgy1PHs?=
 =?us-ascii?Q?ubV3Q9M+iyJXa0/Pwiu8Bq0uMXucZHpcI8ahx+TUndvykDf1yQ7yqBqOUqHq?=
 =?us-ascii?Q?lSszB37S9E1lR5PHWPIdYxmhZ3YOvYxySs5WJVUTDRVon075yIDYEckbENku?=
 =?us-ascii?Q?FL/RCH+qoHSYXDqvdhOiGnju2ahGH05L2nOD8aPNxXWfhFEGRnL+qB/uKauk?=
 =?us-ascii?Q?29N8GcNcbpjj+n5wD6KlOiaAXLL2KDvGTvbUrfeL4swC1MyBLn9UIU67wosn?=
 =?us-ascii?Q?qtMDCwA56oaKYxx8esK6CZNVq0SpnBQU/3L2wTv+r2Tjt5hpno3hMxJvy4o3?=
 =?us-ascii?Q?ZxEKOWztEpdQ5TerUuPehRkyaBKXqwCCvqX6j0dCQsZ7evUGQlepz1Uid/0X?=
 =?us-ascii?Q?ZKqyVa5aoJ7+HOli4mPBlyXEEMPNZgOkJqQuuZrxFsHX1cnOYwUriorz6FTB?=
 =?us-ascii?Q?pd4Xki7Ip+HV5+GTXn22/FNra9i6m1E7oQWxlca8QjD5lGXPQBWI+BMQjIaC?=
 =?us-ascii?Q?p7paJf4LmNBIOtdgZBn5zf7F6Tn29gYej8Y1YGSh0eVIlTvbR88bJHFWWgMb?=
 =?us-ascii?Q?B/FSe/H2DJcztG0465zOAwcnO8PbPdSKMxWkTkw504Vjs9xML8xUUfj1Cr8m?=
 =?us-ascii?Q?ZXXfav5J2WZBP93PlVwxasbroAWJupRGsJbMVhXiU2PSGTcbCXkMGvh6bcnj?=
 =?us-ascii?Q?FreDgLMGjgfoB4E0X5ySkI1qaPoxiNXp7r5q/bSrk9iBs6XkR3WqpsK1GRKw?=
 =?us-ascii?Q?QJGnwANCvnhrkstQlVdIYVJSv4biS7UdFNkOLEmETvsIVxzfH0zMrH1J3cP7?=
 =?us-ascii?Q?TkJUnv+m+ZPB3sh64F3E8mLGbFDLUEz7QwNDnh9t1HC370r6rAAYwsbK5B2m?=
 =?us-ascii?Q?81I6NCai8TPCSR3Ov71/vOmSokhvumIaZ6LM4xpN4i1uGiZBLoFNXf/EBQTF?=
 =?us-ascii?Q?q5IlkxEZjRcp8RBXFvM9cpR+Txh6IOEposvmwin0OhlxaIYy6sKKxQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?04cBvklBgElTI21D/+WwvROkjNF0PyzHZxjc9xfbKv+wC8T0p1M2wr5sm5tt?=
 =?us-ascii?Q?x5WZ1mcc7o/G8rNRlAQ059XwzbVsDycFK8P3aVvIV8G0VgAROIx15QQF1hKp?=
 =?us-ascii?Q?G2TFU7E7Fb/WYbC6nEvDzzTAUF5kmL70RJfvk6ATX+ZJODbu5F0vRKsKSyu5?=
 =?us-ascii?Q?S+LnKjpFAT38ileQpMEQKhjHKpUDd0nWFXSc8754+JYDU/aMrBj4TpdnPmAx?=
 =?us-ascii?Q?LNXMBavo467APoFPE/IO7D9NKP2Qtl78ikmb6RsMSanke01dsb9Vpl5DtKqf?=
 =?us-ascii?Q?ItYa5XX/8O0QmlHkVZ+4zVjYmbDMwQjBneUKkNbKuQRVC0lZ5Z21X9y9EjfT?=
 =?us-ascii?Q?Gue+bm4QsG/kWTQKMjzi5kFhuWJlxET9ywg8jA3aJI7aDsPH9WiNKZ+BqEUF?=
 =?us-ascii?Q?gHD8B1R/BA4ly0RtKM78yQFrjnGzvuTtwFBrNnF9efD9Cr9LqzFq5xHQaUDu?=
 =?us-ascii?Q?9Xh6PZBnft3p/muAl74X4hRmmlzRxWH/ifVSOS1kJL3RzL4xF/HIKAeSDHwN?=
 =?us-ascii?Q?mTmqUYOL+f6APl/EqOeMnU7w34Dk6TA9jByfNBEh9f0k7XRruY7hbuhHrPQ3?=
 =?us-ascii?Q?Js1GM7bcDhH4Poa/tG7wh8IKt9vrKfNlRUVPiop+uMavpSVOmHx4ApHbkiXm?=
 =?us-ascii?Q?Gk+GIrGRJb2QolaWLuXx850lIBK3ADCwoCcYdj7VhMn58XqJQZQslFf54dgb?=
 =?us-ascii?Q?bZGOBtYQh/s5lwvKfJugmFPmHKW8Fijt2CQKl8A3ITxf7hIcy8FKDudO8jvW?=
 =?us-ascii?Q?lH488dpforRWGLcnLkJlJvoATUSN3DtNyn9AeD9tLrJUP+GeURyV5aRWxMQn?=
 =?us-ascii?Q?UBPCOU2Ixr7YMdp1LX3JxreBpKo0vm+ZIzwUPPSHOOuv0DzsiZm8TePSzF0q?=
 =?us-ascii?Q?+4EyrbDTImiVcBG1XD/HCA6XxXg+u9J8pT0oFB+wgPjXlI+R5koyG7seg7wT?=
 =?us-ascii?Q?81t7stpLfm6v6XtFXDLy4q5iZF+K7kENOWySHgnEjqdx6/vHszTewkMxGK4j?=
 =?us-ascii?Q?GNUjqLj2f2AmgTg2mGCDSr9tAicdxmf4RGjgKckUeMvS6naRCNK6DzQyXgGw?=
 =?us-ascii?Q?0A02C9WUwbau4xblhSTOJw2xJ1rB71f/ciw4jyMH0wk8Dh9pusC8Kf9KqMI6?=
 =?us-ascii?Q?Qb4DDnyMbiq26tnwVI47oL2G8AfkE4LxxfMLRpAbTF2OXatToWqh8oNiEnhT?=
 =?us-ascii?Q?bF6a0ZJF+zn9A/io0s7lPB2G3d4Xww100VikBX7RhkNdOLrK942jzHevp3LI?=
 =?us-ascii?Q?oyqGOXGW02oOujtDRAuv7OvvIAzVtFjA7cVnCJgE7Orp195J0SbdlW56V7DC?=
 =?us-ascii?Q?fUxDwjC8WCEgwU+I46jzcEEgrqEg/CMh074pD56YTvyzBmTWicWpUMBbdvUL?=
 =?us-ascii?Q?yaNjFgyKDxaAD2lLf4j9hu500UQhhE8KbtgrtFjE4SsfPZoHrJ87PVXBjmvO?=
 =?us-ascii?Q?NMeCKRhfpPg6NW56Ri3arSnOYUAZI39Ou9w/D+GT7fgjGFNT24QUbcP7Ata0?=
 =?us-ascii?Q?VVcdW3mFYtew9K0aoRq9fn8kN12i82yZ+XNzymAF0dZNd58ozUYrPsitjVv2?=
 =?us-ascii?Q?x1hbQvorXQt+K++UvdU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1366585a-c382-4fc1-f9d2-08dd790f5636
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 15:41:33.3896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dx8Kblqz3XDhvDy7f5KB43fH98ly09twmQlJ7FG8ziFjZZDB0ecTbMl4WqLXVtdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shane
> Xiao
> Sent: Thursday, April 10, 2025 12:40 AM
> To: amd-gfx@lists.freedesktop.org; Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Xiao, Shane <shane.xiao@amd.com>
> Subject: [PATCH] drm/amdkfd: Add rec SDMA engines support with limited XG=
MI
>
> This patch adds recommended SDMA engines with limited XGMI SDMA engines.
> It will help improve overall performance for device to device copies
> with this optimization.
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>

Couple of minor style nit-picks below.

Otherwise:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 42 ++++++++++++++---------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 9bbee484d57c..3835b5d96355 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1267,33 +1267,43 @@ static void
> kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
>  {
>       struct kfd_node *gpu =3D outbound_link->gpu;
>       struct amdgpu_device *adev =3D gpu->adev;
> -     int num_xgmi_nodes =3D adev->gmc.xgmi.num_physical_nodes;
> +     unsigned int num_xgmi_nodes =3D adev->gmc.xgmi.num_physical_nodes;
> +     unsigned int num_xgmi_sdma_engines =3D
> kfd_get_num_xgmi_sdma_engines(gpu);
> +     unsigned int num_sdma_engines =3D kfd_get_num_sdma_engines(gpu);
> +     unsigned int sdma_eng_id_mask =3D (1 << num_sdma_engines) - 1;
> +     unsigned int xgmi_sdma_eng_id_mask =3D
> +                     ((1 << num_xgmi_sdma_engines) - 1) <<
> num_sdma_engines;

Declare masks as uint32_t type for fixed size bit wise operations.

> +
>       bool support_rec_eng =3D !amdgpu_sriov_vf(adev) && to_dev->gpu &&
>               adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes =3D=
=3D
> 1 &&
> -             kfd_get_num_xgmi_sdma_engines(gpu) >=3D 14 &&
> -             (!(adev->flags & AMD_IS_APU) && num_xgmi_nodes =3D=3D 8);
> +             num_xgmi_sdma_engines >=3D 6 && (!(adev->flags & AMD_IS_APU=
)
> &&
> +             num_xgmi_nodes =3D=3D 8);
>
>       if (support_rec_eng) {
>               int src_socket_id =3D adev->gmc.xgmi.physical_node_id;
>               int dst_socket_id =3D to_dev->gpu->adev-
> >gmc.xgmi.physical_node_id;
> +             unsigned int reshift =3D num_xgmi_sdma_engines =3D=3D 6 ? 1=
 : 0;
>
>               outbound_link->rec_sdma_eng_id_mask =3D
> -                     1 << rec_sdma_eng_map[src_socket_id][dst_socket_id]=
;
> +                             1 <<
> (rec_sdma_eng_map[src_socket_id][dst_socket_id] >> reshift);
>               inbound_link->rec_sdma_eng_id_mask =3D
> -                     1 << rec_sdma_eng_map[dst_socket_id][src_socket_id]=
;
> -     } else {
> -             int num_sdma_eng =3D kfd_get_num_sdma_engines(gpu);
> -             int i, eng_offset =3D 0;
> +                             1 <<
> (rec_sdma_eng_map[dst_socket_id][src_socket_id] >> reshift);
>
> -             if (outbound_link->iolink_type =3D=3D CRAT_IOLINK_TYPE_XGMI=
 &&
> -                 kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
> -                     eng_offset =3D num_sdma_eng;
> -                     num_sdma_eng =3D kfd_get_num_xgmi_sdma_engines(gpu)=
;
> +             /* If recommended engine is out of range, need to reset the=
 mask */
> +             if (outbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask)=
 {
> +                     outbound_link->rec_sdma_eng_id_mask =3D
> xgmi_sdma_eng_id_mask;
>               }

Don't need braces for one-liner ifs.

> -
> -             for (i =3D 0; i < num_sdma_eng; i++) {
> -                     outbound_link->rec_sdma_eng_id_mask |=3D (1 << (i +
> eng_offset));
> -                     inbound_link->rec_sdma_eng_id_mask |=3D (1 << (i +
> eng_offset));
> +             if (inbound_link->rec_sdma_eng_id_mask & sdma_eng_id_mask) =
{
> +                     inbound_link->rec_sdma_eng_id_mask =3D
> xgmi_sdma_eng_id_mask;
> +             }

Don't need braces for one-liner ifs.


> +     } else {
> +             if (outbound_link->iolink_type =3D=3D CRAT_IOLINK_TYPE_XGMI=
 &&
> +                 num_xgmi_sdma_engines && to_dev->gpu) {
> +                     outbound_link->rec_sdma_eng_id_mask =3D
> xgmi_sdma_eng_id_mask;
> +                     inbound_link->rec_sdma_eng_id_mask =3D
> xgmi_sdma_eng_id_mask;
> +             } else {
> +                     outbound_link->rec_sdma_eng_id_mask =3D
> sdma_eng_id_mask;
> +                     inbound_link->rec_sdma_eng_id_mask =3D
> sdma_eng_id_mask;
>               }

Probably could simplify the nested ifs as:
else {
        uint32_t engine_mask =3D (iolink_type =3D=3D xgmi && num_xgmi_sdma_=
engines && to_dev->gpu) ?
                                    xgmi_sdma_eng_id_mask : sdma_eng_id_mas=
k;

        outbound_link->rec_mask =3D engine_mask;
        inbound_link->rec_mask =3D engine_mask;
}

Jon

>       }
>  }
> --
> 2.25.1

