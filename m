Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335CBCD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 09:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B24110E034;
	Mon, 25 May 2026 09:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bzQYkeg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979F210E034
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 09:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPTcJ5T/PYfISBG0abiLlPOhT0nrowO0GpWVuRN1HSI9HHRiYr9f4NGUKrAbUGKrWh5rMIe3MJo9ScshTryc+IRLbj28PJNgzIrNIs5GLFuwpGNtP3nnGR08RyWXw4AEWMizhFstdK6mYbPp6+dgP7GE7Kij6hphLk6VgEKOnoSAPXasr/vTsWiCIpNESTxrWOWqcuC18WISLmHlUzNcaCgW72lK9lxx6ZkIlVgUKsfmSBaJIv22Ef/2P6iufgPQXC/wP7lXZ091FNBnyQHxA5+aR9LqOz7fuI/P9MJMWuwlr5DKotNxXQdr423IRFndB5f14XBkBtRHgyGJG6za0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wGr6/hC80WQkGnNgsWh2gSKhxrs5v9Tub1lSCbq/Rw=;
 b=F4lzBi495JXkdbNd1yB3stkslIQTkQY6hPDCv/CfvhRqh+SN1Ia2KVgpVINnqBdlEoU2k/svwFur9ZNbH40fNGLPClMA6BCfdvvK0Rt5UPr1LQPDhgEaatMPW0xZai6ecF34VGyQsFus4O0GT//leIqj/5+ezPcQEUpsnIj/RSDK2HulxJdz1vi/aQFYIJZSRIvGrk8E7cA7n8ocdBz8A/enWvoXCRZLMFqjQP8++t+C8uUmCz5pQvM4D6BIns2Lpm5xSMMSIUb+Dtf71j/ZH71jT4YROF6mPr1R6CyMcJ9HAAhqMzL0/iqOaoxLNkZ3uQWH47TwniMbYTtJf480sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wGr6/hC80WQkGnNgsWh2gSKhxrs5v9Tub1lSCbq/Rw=;
 b=4bzQYkeghfC19Gu1b39b65aO1nZe/RJzOWLWJyawKX5YaYnE/lerYTSwWeD28tgNEQl0Ruz07FXVsVezp3aW1ULB2lmn0thy09BZuu8ZJLvlBCHtzvyYhcD2sKMHvpPGdE8DgQU+74KX9iZSB5QvpIjyCOjXLKpxVOje3GouFmY=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:06:33 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:06:33 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 03/42] drm/amdgpu: track guilty fence for queue reset
Thread-Topic: [PATCH 03/42] drm/amdgpu: track guilty fence for queue reset
Thread-Index: AQHc6YDquYOyzTPH8kSSzb+uq6VdwLYeeH0Q
Date: Mon, 25 May 2026 09:06:33 +0000
Message-ID: <DM4PR12MB5152BA2B96ABA048BE32264FE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-4-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T09:06:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB6802:EE_
x-ms-office365-filtering-correlation-id: 980453c4-37fc-412b-a2c0-08deba3ceadf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|921020|22082099003|18002099003|56012099003|4143699003|3023799007|11063799006|6133799003;
x-microsoft-antispam-message-info: 0S395U+DsCyQfumgXDphdN1wmJULc+CtDLULc+Xu6xcdU6Txh0GKz0G+tXZuQuqZ44ZOH7N6gvjH7exFUXnyTAf7phN+3KlJk5qZvwXTLjzUB5RHzFqOUSvwYLCh9nqWlGecP5BQEolcDRnig5F0/xfY0wTCTtw9n7Uu5H/0Apa2GI4PVWKugx6bzRwsvShyhx+wrKvfeiAz79iUY8RefPbvyZstR60mpNsn+wXN2m/rCQBEaTJBqmiESQ+2Jr0My47peTamV4MEfFQwHBT2DD+GnPNlGlFjDnBzO36BEEHgRVE7hQLccxoXu+NWjMcPY3OQmr0JZ8V7hq3Bca7335BMcW2JWu1BeR6Cqymvnz645ownjGMYwrGsypRJJKi3ojAUk9g/r/bIC4tHfixPbzD3zR2k3CiKBJObjD3uMUrp/nBH6r6OeHXQDiOII9NwQcuxbBPHoyE3k9VuBdywoMhMpST0hCkzwInLwAVfyAuRYCa1WVJbaIyN9vmt0/yqYOgNaBhnmTvJwErhvxcUeagdLp/wYs9nsnjQX6M8/iFtwBoCJ8q0bXH1ay6X0Iok3VWb1FTF9277a34WBO1KApioJQGtHWA9zmmP6RQUEqWPKLFxYGopaZ+QQ1t57W8PHZ5kdvju1ZyhZnfrY9qteIqGXvZ7ejy3Au85r6lsyZxKMgOU40BR5wAys2xIfQmjNt12TMiXMBTB2HtS4IUlT8+0xJRPjpARo0Fn2Q9EMTg2S2qn0+PliPrqIYzFqmVCe17j3C4cAnsRxouBNVwzZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020)(22082099003)(18002099003)(56012099003)(4143699003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dedHQpITDuNKD4eHzFGmz3Oj9S3xEcozK0wWe3ER819jgoeL7tw2R4kE236l?=
 =?us-ascii?Q?3edx7dR5daWCcGX0eJIagzB4E1CJ5pxIoEKL8TK+6v2Pz6+q8gMm8UlDOjqU?=
 =?us-ascii?Q?AoSY9nywjphvNTALKG+Da37+AOftUw091VGQq90Eql8wVVd+N0+lQivQRFYk?=
 =?us-ascii?Q?gRkM/M7oCruvz6o08C07fXMJQ0WEWGvW13VWBIcv+4zFHfiSUP+RqyV4YTvJ?=
 =?us-ascii?Q?kP7Kj5eYX2gXErHtSt4s4QQrDqT2kcPjgHPzHbGK1LMHFYwwcZAEut6ZiGlE?=
 =?us-ascii?Q?aCQqVSe5eLLGO2n5xEaR+r/xh1IYyHvI9t+b+D24LZFH76l3XPPPU7xQTuY0?=
 =?us-ascii?Q?R+BQgTAmWX502mHnAC6AlfGthAtjff8i+VO7UIb3ExgLJ2JU53LMaUp0UNwe?=
 =?us-ascii?Q?NPPNhzLXfR26KBZUXwKxa+NEAgWr21s+6L5a8ICjyYU3fbkMyUr4Lmtj7M6t?=
 =?us-ascii?Q?8mDOmRIiFn3D8+owAqmEv25DhmZpI0FRye1sg/jTA2EXTLDlWjOhz6UmFn7r?=
 =?us-ascii?Q?18ggGQnOxb179nvgtP9GZ9RbFm3IIG8ohrbDcQ9ohdhyzYjiAVgN1VVQAI5W?=
 =?us-ascii?Q?yayza+Cloc6exnTl8Z3z8lsHebTmFeLnUHiDHv6vs1d83phKLCQ9P2r/gHTO?=
 =?us-ascii?Q?gqaLDBrO4EXKvFi4WFxQlnkuc02zgAmISfnwZWZJHwd4yTK2WcD4If18oeNd?=
 =?us-ascii?Q?kMKEh2Dz4u7ELYWyD+DQLOvpULLXMqGDF9lI/h80Y5wna96jxbolEpIq51Xx?=
 =?us-ascii?Q?Pk9hGu+h6fQZPnwOZUrYlPjASNGY0ry3uhKLJGrvT2G+AKth6kSUACNqwUGs?=
 =?us-ascii?Q?rtKXgY18VBtYdRwdtaqCPul7DWcP7sQLYaE1rNqW/bCMmbCEHDc6C2LtTwdK?=
 =?us-ascii?Q?xa1XA23s5LrV1tHSNzYH0zdNApdVDkL3X9bnt1HpdKp5tNJ5cQcSsSesNtic?=
 =?us-ascii?Q?2diPjAH4LIanPuXs6QSGT+XI9lKig7Bo4kQzIcwVwCjBNUadjKrn1WaMuir0?=
 =?us-ascii?Q?9F7TVPUamka7FH8y1aQhrJsAglJNfoIr+pxEuxQxJiRQcxBDek7mUOb+sfZA?=
 =?us-ascii?Q?J5/JO/1pjUomEiq+ZLGkhMqEh7irAwqluwbel00t5nsDZU7N6MBpC7dH/fuZ?=
 =?us-ascii?Q?QgtZgd2TGUvmZ+qHqE0s6q4raMI4TXkzEhGTl2gvBYTFpChl3XT5aXpEwZhS?=
 =?us-ascii?Q?xlByEeE6HNWBVS2ACMCfAwRLGa7kbI+vMu1/5Wtb3K8myh4a94yk7iySDZQ3?=
 =?us-ascii?Q?HSMUMKBQqy8zApL3EMMW+oPHy/wg5sb9NcwmsZ3ATeEYGNXgYjxv+Q/Uohwq?=
 =?us-ascii?Q?n6AfP97TlvotaG+kojy7oPITapd+LbCpTphcj6UZ4JHeaJ/sLdhA1DaZyfLm?=
 =?us-ascii?Q?Ja5+5e8QgKEkeefiostCQkSS7z0F6Hv+C8yHqx9utGQ2DFfQ+UHUXwiw9gY3?=
 =?us-ascii?Q?0yh9EaTW0dlA3Fe8KD1UePuHIDhXCRdIG3OLHncMLY8mE/SM2qGS7VCHIOaL?=
 =?us-ascii?Q?mmZn5lR3RFZFVgrY8qUc+phg+pyZOdKR1JoDFPnoOJeZV81jeFFzNdgNls59?=
 =?us-ascii?Q?8VUKa8yASEMEjGe7yKmky1Qnw7RhGO+fGjH52u0t/TD1O/NebIP2Vue1i4C6?=
 =?us-ascii?Q?6qjLgnvbo0O4hAF7hhqqPhH+WyNzAS5VkimNy/xTTbXEgvQq2GBPInbTdxqw?=
 =?us-ascii?Q?gqNbqkd02RChS+y1Sj5xVlCBcycZszoM8ikzCx2zpK29C5xw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980453c4-37fc-412b-a2c0-08deba3ceadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:06:33.4310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjDi+YjPNkqOfP/CWMb6icKGn4QVvWwJ5MPykgphlyFhqmljEW0Mpa2tqFNvWsVnW/E+TdJVpGItNMD0py786w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

the Patches 3/42 to 10/42 reviewed by Reviewed-by:Jesse Zhang <jesse.zhang@=
amd.com>

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Friday, May 22, 2026 8:20 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 03/42] drm/amdgpu: track guilty fence for queue reset
>
> If we've already seen a fence, don't backup the ring contents since presu=
mably
> either the previous reset was not successful or there was something wrong=
 with the
> data.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 11 +++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 6a43c8494fa8c..a7a6db0bc6940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -803,6 +803,17 @@ void
> amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>       ring->ring_backup_entries_to_copy =3D 0;
>
> +     /* if we've already seen this fence, return early.
> +      * ring->ring_backup_entries_to_copy is set to 0 so
> +      * the reemit helper will return early as well to
> +      * avoid getting stuck in a reemit loop.
> +      */
> +     if (ring->guilty_fence =3D=3D guilty_fence) {
> +             ring->guilty_fence =3D NULL;
> +             return;
> +     }
> +     ring->guilty_fence =3D guilty_fence;
> +
>       do {
>               last_seq++;
>               last_seq &=3D ring->fence_drv.num_fences_mask; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 8f28b3bd70106..9276a3bb69de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -314,6 +314,7 @@ struct amdgpu_ring {
>       uint32_t                *ring_backup;
>       unsigned int            ring_backup_entries_to_copy;
>       bool                    reemit;
> +     struct amdgpu_fence     *guilty_fence;
>       unsigned                rptr_offs;
>       u64                     rptr_gpu_addr;
>       u32                     *rptr_cpu_addr;
> --
> 2.54.0

