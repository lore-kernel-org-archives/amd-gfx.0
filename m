Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A5BC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 08:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C88610E713;
	Wed, 21 Jan 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZMyjXNN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D5810E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 08:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKgQBktUL4yNSZ6dmhSIdMWqKh1HJBD8alGdxD8Ut+3CutzYxfmPAHHjQvcrrxbei37wkVPOFApPxfh0lZfDzXLagxQj+eyyc/aFIB978dz7YTfBx3DRZcdmXoyAKlNCto12huBypFyq9of6QmNM67VZ5FXfy+8LLDzxjiLeVhghUjsg9LZbgKC614IemL4YI2Nu3MGWNoQk/vzF8FRNc7aD6NruYlqoDMr3GN8q5PGoPVuCUI0IUhAKIMuayEW70FoJrOgvhb9CJeK9s+UexEPRbq1ZlLO2GtK3Uw7rshFU2PiZ70/43Rerhu+S05p1v50w1FiUNwipvVqgpxg5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjnQX3/PdBVCFGx+bcZfHBagFsAvT2HT5NZujMhdIjs=;
 b=owifaxUmSYQb9LfMHaPbnIDVHRQ8UQUeYQ7Nl/vBpLQaDwvpPv/sQXGifgoB0WFn7uW213qM0BCFZxpVUdx6CgrfMyCxhcNQVcN0Qj7ZXEzRV+3HYNarl45MiTjdNY8SM3jF7HfeA2kG3wpvlSxxijpkwwLqsjmXFiI55VHZqucI2+shOZ/1yv9ekVhEsIHknUDIBifcwRqydPRZhxXZ+WrBnuEpjdJt/WaiXXQcmnrmfR8MaHaclA1jjULRHN5PvqP4kJzd4krJCf6md4A/wFwJVaUw40sf+Wn89U43IN1S7Yiagpl7pSiU7jjI9Yc3vrJ5FP+jlmuigESeJE5F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjnQX3/PdBVCFGx+bcZfHBagFsAvT2HT5NZujMhdIjs=;
 b=nZMyjXNNiblareyl+Dm1FaPjS3JpGB52woFYCGfpbzAG89JtqPyfdFTzseQ2vhDoBMJUMf5MwZc1PDO8VaSWHkw1IuYlW0L0LXOsyHv9xwFDjgWjD/1V+DpVm2L2jwWp+xcKwBSx8muRS9lnmi7ibRvXKhkRqA5xc0g98zdg0Qc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 08:38:01 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 08:38:01 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 09/10] drm/amdgpu: Call drm_sched_increase_karma() for
 ring resets
Thread-Topic: [PATCH 09/10] drm/amdgpu: Call drm_sched_increase_karma() for
 ring resets
Thread-Index: AQHcioJG6V0xSQRFoku0GPk5sBSgkbVcTXYQ
Date: Wed, 21 Jan 2026 08:38:01 +0000
Message-ID: <DM4PR12MB5152FE65D98C8F122BFEFBADE396A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
 <20260121030057.1683102-10-alexander.deucher@amd.com>
In-Reply-To: <20260121030057.1683102-10-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T08:37:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 176dbe96-a40d-436b-0280-08de58c86315
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zob1lXd6Cgc9mkpfaMnS7R9MRUwoX4ydThCQigJIFU2B/UapN6lRiSsN0Lo+?=
 =?us-ascii?Q?+LFNqrl0m/WFw3RLQ9cjkIRPMk4t521lrkuzlFZVgYGq+LX1z/DUyv1KQFvm?=
 =?us-ascii?Q?55H83hCMZn/uTekTeO2cOZYate9jmcuixXjqUCIX9Wgit9/o7PDWds57saiX?=
 =?us-ascii?Q?PMOPsIpqJKVuJ/ZQBjvRNyAFAZrsAil+ncOpqlX/1DObv60ZDF/Ant1lH4Yp?=
 =?us-ascii?Q?J4Sv2gknv4pyjZ94m6c0GVgPqIOz2xN+hPC4qJ2qlutJqH2pHj9VesMrCiKH?=
 =?us-ascii?Q?xLJ1aWlUQvKHP9w7/vGrp9q84tWIvRRgv0tpPZNfgwWTQpBgLNXcAjWal3pL?=
 =?us-ascii?Q?/Lpl/K5lfav5A2f2GMXINjCKqYAMwkkmoc4Mj40IwHj//6GGuR0OPs9Vn7ce?=
 =?us-ascii?Q?TfpKF6hL8ODDEmAYfhB8DfXardvIaHXB9IZU14I/pfQa2AehqQcxYhKZ+s7i?=
 =?us-ascii?Q?tAcdlOeKqyZF/q8rlw5y07nKf+tXaOlgIL2yIyI2u+ykyUajkmE63vuY39s9?=
 =?us-ascii?Q?ZTFKB+6SNiDojDfRo1gVUVcpVx3IDHcdX4XPnEaQWhjq//OELaE6d39znKBj?=
 =?us-ascii?Q?T/6AuPLwCVqjr7ldDgjChsS+MwjpfdJlBqx1TKqCBVDErZqh/RUGCHXOPjWV?=
 =?us-ascii?Q?q0pFCPgB2+rqQ97b3qC52pVogvMvS+H1hAu3Ucaj2c27i9vgMkZFaPXsQqjb?=
 =?us-ascii?Q?OQ9pJ9lXnz5aUZ0RuDgte8D73cQohW7qDW0tDnQAA3QggRfqal6wYQsHAp1H?=
 =?us-ascii?Q?KMK+96g5XYceeYkTAPezQA0Vb8Y58/neqCwwTyPjWZjfCYx74YG3R+pP5sIh?=
 =?us-ascii?Q?3gG42GstJX2KqcIEjefaL1BnOKzZkEDpPqVQR5pBTgQO3l+W1h4RyiFkSVog?=
 =?us-ascii?Q?4j/pQfJ7xypf9t9FVQZiA28oyaE7+NW7TDblbfgNqQRnKS4Ny40mfsGfbFYH?=
 =?us-ascii?Q?tO8ljbiNQVLVRUyHRxWcHMjaiIAjAxXe4n12SOhM9kYG6KuqY6RTYxFcxHNa?=
 =?us-ascii?Q?+ihThJwFzMpPRz+c2oV5Qclsbyo32L76mYiCs4OaOWwTuhpe+ktP57djYQvu?=
 =?us-ascii?Q?o+SSN4AjNQDYk9L12OFOC1kEsKOk6ZBryY1rIOcqiYbLlYGkvXHi5ANWEsGP?=
 =?us-ascii?Q?immYwhE/C6IBdbDuVUNxxBnG2xBfYRG9WUQiGH6gOslx+u52uzqrALom2ugA?=
 =?us-ascii?Q?27ohw9KlzBhYi/Sais6F8SuVcHnw8lAbN1oGVVqmoQvG1hz3gfgji8U33HtD?=
 =?us-ascii?Q?cJ7C5Jio0e5HEwVBBQLqSki4yKf1TyoJBqza+nmw96I9tQh6v7xTL6WNqzXW?=
 =?us-ascii?Q?7OgXnJv89HFsWhvTFlkLowQ3R9mBG6FG3M6plgAnsmyeFb1Rp6QiSKKuQwG0?=
 =?us-ascii?Q?vizYs7RO/wCFH64lFbDx+9hDdsx89VpqM5usisB4doaHAg6Trx0GERXLjzQK?=
 =?us-ascii?Q?w+88eXA5U5pIR/+fBwHy7HPyeYj/H8U5Z+2p1ObCZL8Gv8an1qmJV46AVGLb?=
 =?us-ascii?Q?W7patbmqaWNoAgg/+4hTpxs9D3aplEMDdWzR/uOx96GeK7Z4yD2SceEB70/f?=
 =?us-ascii?Q?QBv6YiIArKsw7SjBvDIXlw9HfwiXNF4COvoHG95GVaCSAcUdjyRu1h0LtXBH?=
 =?us-ascii?Q?LFoFpSvowj45rDwXM8Rbt28=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0XxryNVk7N2yJFJqNNvEf1idlR+UWGfNlA6K2PxNfj/v6ORnZnBu1yia/kbb?=
 =?us-ascii?Q?0On9PNGwdEYbf8w4tC2qHW7RFzGmYai9V0TR/EV558218wldAsE9Ce6XqgAc?=
 =?us-ascii?Q?5LQ0IMze6nZlWTSJwblQ6GrvTHWxnIaTZayMPRaTRv1yIysEX/XyEUOHfWI/?=
 =?us-ascii?Q?VqA8uauYaqiU6DO6Rn3GBrmPFwjdclvcJ1wLwoEq2rbCnA+6g8f1/1+WKLE1?=
 =?us-ascii?Q?1dl82HVuDAlmNvyolwiYI+6FUI+9isJg5AOioSfD/KI7SgU1TxAwmK5LXly1?=
 =?us-ascii?Q?jArsNCfWyJBcbcTgxOwEfE5RJTfiQnD8k7ogo2ffLYUj2rZNiOxZ1EzaldqM?=
 =?us-ascii?Q?y+kV/B3M37c2mlUXqd3jKOMSE9TxkQa2/2R7asPsOOJG1tGmXUucMfEgWJjY?=
 =?us-ascii?Q?yvo0RnK6HADryXeIQy1DOT9pma5mFKRxGgt7B6UwYbtp625Z93WtEKSTzVuu?=
 =?us-ascii?Q?QzvB84hwb9t8xVdG5tX+tpx4mrQ14580jwwKCr9vYQ7MyAjUlewhsCJyTTFR?=
 =?us-ascii?Q?4+7K4uozTFK4H3SJHjgZjUMiM/kGWIyIJPQ07xmYYVy5xyqcbjYEbrJBJBjd?=
 =?us-ascii?Q?sc0huLL9cmf7I9bMQxlG7hnBrazjL5W/cjpPk+aPdWdFQ2+T5Dgcs1BObsWG?=
 =?us-ascii?Q?taTQhUVyvCXJiXrfE6tdmoZZ33TBoRd8ye+nw7Jvz7kGFgfz1KtKnsJZjghA?=
 =?us-ascii?Q?OWXwO9rFJyaQOPHLh2y1CtewG6keRMm9dTF5LSNEiuZFT91LN+PR4x0gj3gF?=
 =?us-ascii?Q?WjKe1ktgTSnE0Q4sIrliq4jvJvN2dFfJ8FPRaXKE8RITD5MkXC/YaE5ktjld?=
 =?us-ascii?Q?yrJYAD8AFs82cPwQgjygA0gQLENGI3TTWQYLA/pg+IIJCL/ILU4TA5VPS5S4?=
 =?us-ascii?Q?64ZioZuVotQNfrMmYFcDw4uFNSeWmBILtoQt2IN0D93tI7CeNZAoK2qI1ukL?=
 =?us-ascii?Q?JZGzchp4N0864bVCNGXxZvhxb+M2DixlucY1Q+5ENB8r7TQ9OzQqaBP4OU+t?=
 =?us-ascii?Q?Gh2EVyZXQSbwNyywQzIigU7kOOB/D/sppmCiIyTLSvNNYy9PY0l/iG8AUzgc?=
 =?us-ascii?Q?6kK2s4qju753ZoqhkG59U0qUtHZIZUkKd/JDjbx67HAgZ5LVkwm9/KaMiqvg?=
 =?us-ascii?Q?PxF1lGqJLbqUACJk5Yd0tb4OK59O7GvepkbcrKHtXwU92lbIdkX3DV9UYPmE?=
 =?us-ascii?Q?M7HyrUoXbDSg540gxCIMNfL0md3vrtSdUu4JZbgxVjFAznDSpopDUIVeitWi?=
 =?us-ascii?Q?4imWsr7lqoqUtegB7VpcbBWItzyIixWBq22eYA8GeSrhans6fgHD65/TDdka?=
 =?us-ascii?Q?OdTiPJEuHXRZNbsV6YzgGGyw3NVSOS7f4z2hu9gytiFV8/+WnugqVHJ5RDkf?=
 =?us-ascii?Q?ghzQIPCDmHLkrl86qcd1wRJsKWoA/xrRoB0YvozUVncCsZeCN/0CUfOiqQht?=
 =?us-ascii?Q?PRfsftjZUGXT/a9evbmeP8HAXL4UTxgVcFi1ENQgGO+jZUtBx4KE4YvDX9Rn?=
 =?us-ascii?Q?z7LKeTXtC6pxlRpeqV809D362FCk8nqVSZ1wBs/NIdrhsvj3Z6CVFQeXgTPo?=
 =?us-ascii?Q?kC6AKMWEQlO/z6bIQN+ue/7iP+KWCqpSYtKR7cTuy4HV+Cvys6zEKQK3Jh6/?=
 =?us-ascii?Q?r3h4Tg8cN8huGYgbrjVyQxaoScbNRqnq6Ogp8kiO0U69KUWCT6pjStcHmiXf?=
 =?us-ascii?Q?LHHinFuZAqJfoDsjUX+WoLNJCCRXiuXZPREgAPKsNxoORR96?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176dbe96-a40d-436b-0280-08de58c86315
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:38:01.1936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StbVoruuNSJyPyodCsoPFTuf1MRSRQLEeKciVoypmBNGKjBM2h3GsbE+JKQS/vdPWAVlqDvrVHo/p8wFFEXEkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, January 21, 2026 11:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 09/10] drm/amdgpu: Call drm_sched_increase_karma() for ri=
ng
> resets
>
> Mark the entity as guilty.  Align with adapter resets.
> This only makes sense now that the CS IOCTL returns -ETIME rather than -
> ECANCELED.  Without that patch, this would break userspace.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index a323071762822..3c4b148d4f6ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>                       s_job->sched->name);
>               /* Stop the scheduler to prevent anybody else from touching=
 the ring
> buffer. */
>               drm_sched_wqueue_stop(&ring->sched);
> +             if (job->vm)
> +                     drm_sched_increase_karma(&job->base);
>               r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>               if (!r) {
>                       /* add the job back to the pending list */
> --
> 2.52.0

