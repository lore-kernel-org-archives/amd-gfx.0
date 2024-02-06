Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002AC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8FF112E38;
	Tue,  6 Feb 2024 21:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rlHfptoT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3EE112E38
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiTprR0QBsMd28daLXaIvybrRsMENwIy+rvwk8w43eI5zUL0fikoIo4ETNakS67FHzkWX6ZOtagGtCyDTPS5xkYKxiNQ4Ixm6bAiI8cRPNY9GwTm0zn2BPo0DSNnftxcOVXLlwTo5kPl6COE2fJowv/opVITTNmLT70eAdLWilm0RqvEeQ0M9tqlcda/5W0mW7Kfr0euhajSYNiDsmyiNjRtwJQC2sC31ZY4qQGVlXoAtsEi9Eal8+8ly4GNJfa/TjRtQOeopaWNT26r/l9bLpGN+yX/aDdP+R5Eap1MMIVu0MPMoSPH3Ieciq6nqkbFE1Itk3O7RlbJh2K3QB8kLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGamhU1dmL5ROBEJ2IEinsXQ2gJ8ljNiK/yKFC0d+Eo=;
 b=NFmZOovGXNm3Nfu7Yi2DVSwLdjxzQKoKfBS0Ctnhvh83iu+X5PYGGy/N+mDPB8AcYYKDqqPW358DtQQ8wiMvqfpJdPmtGum+WTG5LY+gvsAQ0Az2hMnZAzUgMOiYjx+BFizFrfaHM851TRVEfAhPBpat57i9EXfx2yNBEqLw/Cv7kSgpE3hnThShxsjObFcDHtFYM5ISNlZ2kFQ3aT4Aj8Gi7Lu6dHBJVAzwB4kzjdZoXBrMUuf/1Exc/eWQ7+Bu2zWf9tiIqFk6tXpWQrf5RUZTOUTTSIB3ZWz4kgDcotwMQKvPQc7MA278SgtIpPivioEaekNXE6Rgdk1C3xgCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGamhU1dmL5ROBEJ2IEinsXQ2gJ8ljNiK/yKFC0d+Eo=;
 b=rlHfptoTwHrb5ZdNAWTZvrTZ2L2J6wlDHsFW6c3dWVo2uNQ93UbnYk7YuWdtev6rE8LkOtPKfYPEaUAS83b2Yu9ZPkvLxsRRZiDVSJup4ylpb+VqAkvnH0iGDJQsVEBMI+MAqbP5HORI0aWIQDlkrFzK3m6lecmi13gI4kwIZ4o=
Received: from DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) by
 DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Tue, 6 Feb 2024 21:00:56 +0000
Received: from DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::7f22:4cb3:cff9:2872]) by DS7PR12MB8321.namprd12.prod.outlook.com
 ([fe80::7f22:4cb3:cff9:2872%7]) with mapi id 15.20.7270.015; Tue, 6 Feb 2024
 21:00:56 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Thread-Index: AQHaWSc0e+xguhLBHU660UDlN/LGMLD9vYwAgAAPJFA=
Date: Tue, 6 Feb 2024 21:00:56 +0000
Message-ID: <DS7PR12MB8321603E0C8F002D9F2B69B4E3462@DS7PR12MB8321.namprd12.prod.outlook.com>
References: <20240206180545.626910-1-kent.russell@amd.com>
 <BL3PR12MB64252107FFFBDCFAE77D9F3AEE462@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB64252107FFFBDCFAE77D9F3AEE462@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79a2657e-0a7b-4a03-ae06-b42de747dee3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T20:05:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8321:EE_|DM3PR12MB9413:EE_
x-ms-office365-filtering-correlation-id: 106d1fc8-8c5e-40a8-9967-08dc2756b6d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gVF0Dl8RydAxvHCApNlUAzVeE7+vYfLIiHnX0WEfSju85MiW7ibirrRc/n/tpnE+c/MFk7W+4UPAdnV8HNYV+HVp80lqwN15pHxtKsedwR7dp3M/UWPwa7uXZmccbjqk29YGSfp7AQNx4eNIwRPCmoJq1hRfZYKNBQQ+P1IJlYfRWusB77RCNt5xXPS6EhHrwBVJQgs7tZfIMbMi3LN/zUGNPUd1zjly7DvT2QQxEwdFc7fNe4r1MZkckHS4kzjxfCtVLLmTgjZz66ZdW1BrP04Qn4JUdbPy4XlsLGBEjpykpNOpJ41CSOiA1/rIuQDAtQyyfGecmm4kz5pU1KqJWxHsKgeLALLbElgrnWHNMyoG931+riFRtW33oDY9pNWxlA+XklDA4w92utu492BvIKss+fs5/3mE5O3unPZGB2a14nzc6RMd3Y7OaPpzcyIRIo4867T5dXhgelmqpy7R+L+hS8pErlaHUWZGPBb3UvDEpTwiTw53+QfpAiwA1d5XuUx/CHFxPkVR8wQu2Xg/DRWEH39DFBCULRxA0CXOrpX8Tav5Z8KguTeTsEzKW5wp/Auzrlme2aM+3cWU3aPPYkALo5/k45E8ZTpQPpqdhtCYrpWdVe1cnZ+j3eTrWTo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8321.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(26005)(2906002)(41300700001)(66446008)(8936002)(5660300002)(71200400001)(8676002)(83380400001)(66476007)(64756008)(38100700002)(122000001)(110136005)(66946007)(6506007)(316002)(7696005)(52536014)(76116006)(66556008)(9686003)(53546011)(86362001)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjeDWjqI6kDHDFLmKj9L692sFO1ZqejgABYqOjiKjVk0HgCtZwXyW6SFMFo4?=
 =?us-ascii?Q?rGEGlYG1yVn3wI36bBfpDzihUwLGSQa5mm5Mm3DPxA1v9IT4xqm5rba9L1Jk?=
 =?us-ascii?Q?Hs55BHiYahAoO1XW3UrT5v/ETMJpJNUZzJKjPChGVAQp2DjBA0PptWgO56TY?=
 =?us-ascii?Q?7jlhChkpuJPervM0pPxLZc7d2xUR2iCYUvho30TqcxRxcd1vTyskvCUP3Ys1?=
 =?us-ascii?Q?On8Bocm5kxGmvjLtUIeTgCaLVg7RZzYhyP1wN42tUZ2QoffM4hz84zXoDaTB?=
 =?us-ascii?Q?f0gbsXKnPnbj+6dNn9pX5MjgZlAzvwszi/KKhdqOii2pq2OyLWCWLzDdd37Y?=
 =?us-ascii?Q?FtU3e9YjfrjqcBepNvcxaVaGCP40/kFQJkLHuOr57rGCgkO8KgrF1kzwctyV?=
 =?us-ascii?Q?v5afUnhfADxtDHcQnuR2jpgRqYTY8sfK5pFz8KgLmfcmBlTP3Z9x3Y+8s3le?=
 =?us-ascii?Q?wgKs15wWQxONTM6TUxl1PiR9Tjq70GRzjp25I9Ozrx0ddjPCvZQqiHSZl4Fr?=
 =?us-ascii?Q?TPVNiuvVt2xZr7P7AhpBIn7uEY4DK7hk/Aw1H1BE2NgSvHYAqjVxwA+gpbrf?=
 =?us-ascii?Q?iQtxtiR+a8y7d7+4XIXVsQzBCDyWAFYAC1J2k3uPkcvAX/xsEnpgANFHxR1E?=
 =?us-ascii?Q?mn16EcoMpxGBaiFaWLVMFvhYKcFLsr8ZgxdcoKaVAPOV1B5IdYmnIuacVZ8W?=
 =?us-ascii?Q?Zy9o9Uu3CI1cTZS+UYVyca4vLAukYAJttX2Nyko7ZjTxHxAeIvM4F3btYNo0?=
 =?us-ascii?Q?bysrA7dARGvZ5vogB55OVdJgsgkuimGiBG6zAy8Sj1+jHrrK0SUUc0Z9aQbh?=
 =?us-ascii?Q?3OW7q3DYtZje8QDj5wBtWDD4N8f/hGI84AyLui/Z0ymFH2Fc1mxNfiHAkLI8?=
 =?us-ascii?Q?bPraX/6W5nw3bYpMBYKlGtqHH+FZUFaOmYwDwBzEf/5IFO8DG3nFa6xPzNCF?=
 =?us-ascii?Q?hOIbcG1Z/xrXgZ+y5ce8UJp2DqhdvyCFAISZWH/uAVGnUzkSE37Um6Q4w4DJ?=
 =?us-ascii?Q?AqKvbKpn6/U4f8QdF8W1tRFR07MnZCahocXMkg0uOeX0ctuwk6pHckrHxRtp?=
 =?us-ascii?Q?XEMpIQ11TB79R1xzJZ/yIGjW2x8hJG4jaiE0oTji/qEIvk7S4W1SGwYw2Cqe?=
 =?us-ascii?Q?IKBO2Nd9tv8YVvLc+FW0kByU7pciIbHJ3BFyOoS0Dr0LVYCe2hcNbmZIPRNp?=
 =?us-ascii?Q?JgkWZoEvgIohRRchN0cqLh2gFOGvvO0ErBr5yGfZB+fd8GVonf9A5XpEUIOD?=
 =?us-ascii?Q?1FR96+VVnA+bNzxiNOWRry7lM961ddeDKuNs+a09TqAdrH/kAxX1HbH2p7/d?=
 =?us-ascii?Q?NHfodkaROj/KkEX3E6cftx7pxa/E2qe/0U345yObESv8B2CLJjLTjzACdKH2?=
 =?us-ascii?Q?uw/KHw1ZHKzrHsXhrb/o2Onkml35xc3pEz12tcPeXXZDD4RlRS8Ghqmw94OE?=
 =?us-ascii?Q?7OxpgZ8Yw3WSdx3N4cjNgJyac4lXFOeFN9VMrkS5xNyPitL7jg3JbD8mEvZ7?=
 =?us-ascii?Q?t6FS0KNSZq0wqNjJLzcZ1s6AWUVPVITP77yvr6q1YeLiZ8My5TN/8r8rawkt?=
 =?us-ascii?Q?NCNiIE2fRQnEdfcvWBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8321.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106d1fc8-8c5e-40a8-9967-08dc2756b6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 21:00:56.7397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DB1qAB7gCFpVcU2qSJ570aH2rET4ocYTKXe2xbWqeuA4qv5ZCsGmhEc6D1h0Re1FQDkWbysYfuwrNdgM/M0Lgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

Comments inline.

Regards,
Ramesh

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joshi, M=
ukul
Sent: Wednesday, February 7, 2024 1:36 AM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3

[AMD Official Use Only - General]

[AMD Official Use Only - General]

The commit description needs a Fixes tag of the offending commit.
With that fixed, this patch is:

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Tuesday, February 6, 2024 1:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
>
> Its currently incorrectly multiplied by number of XCCs in the
> partition
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3df2a8ad86fb..64bf2a56f010 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1640,9 +1640,7 @@ static int fill_in_l2_l3_pcache(struct
> kfd_cache_properties **props_ext,
>               else
>                       mode =3D UNKNOWN_MEMORY_PARTITION_MODE;
>
> -             if (pcache->cache_level =3D=3D 2)
> -                     pcache->cache_size =3D
> pcache_info[cache_type].cache_size * num_xcc;
> -             else if (mode)
> +             if (mode)
>                       pcache->cache_size =3D
> pcache_info[cache_type].cache_size / mode;
>               else
>                       pcache->cache_size =3D
> pcache_info[cache_type].cache_size;
Ramesh: Per my reading a cache_size is correct and should be around 4 MiB. =
Per my thinking "mode" does not come into play?
> --
> 2.34.1

