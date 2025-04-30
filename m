Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CB0C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 07:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC32B10E09E;
	Wed, 30 Apr 2025 07:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJtXc/rX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9BF10E09E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 07:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYX3guI8c/s/F9lVGq3/XWuEv9DNlj39jsPa6eFHVNkE3CvFaQQPzbkNFK/SIjsXKhs10bBcw3k9tgmzYIs71CcvyqsfrGni1DtCJeyGV6rkOQvdBSTpb8t4ka4bd6cdpms2VfDoQxYwR/WKQ12K//DdG8jDv7KH3gbkBNYADW3QY1hBFakcEnAcK3OqMBkvwE7inG3FhBaP5AAbBrt7Pc250h4zbLGiLpxVBjGvqXQ42ECN0AlrQsYdb78N/GJ0q2Q5gnaDQJL+Q3G8Bsv2hx7qIquGJKJkuzW9EVOt+K+Sl0clKxM9NJnMYzNAHP5U0FtdPtNvYCVxpZjy6kssSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPQtd4KvuL4KaNPa6LpQg9/FTFiCEtz5XCPCVa5DNkU=;
 b=U+wYTwKVnsILVJTQ1sQMk2mCMs8Q2bYiZX/AwMl1B4zszOLGqZNONxzp+k5NdnvhwT//ls449D5ZTtYQcX4MIGKS6zISeqPa7dyAC3mqacjy5OMnVg1wTLXM6rp+XqdAPUBV+0liebY/2Hw3byhGjVp7gn5aNaGuDHOH1O9mGZNlw/ocJnaxvo8iVJ6cHttv0ZYncP/wEYFeSr0zGCDrL4gO3yPFFjgftTnv8aKoeCSeZQc/HTp6NBpdktNq3i+bDgdQ2VDWYN/BqKfhYCrfro2E4VZPc72wtE3DIn4a8tSQt05+rMa0zkWIdesX5+5UQNHx5ROOMRTtP+Pamf0cvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPQtd4KvuL4KaNPa6LpQg9/FTFiCEtz5XCPCVa5DNkU=;
 b=QJtXc/rXfcThfSp5g5d93Gn+wrFRn0ENm5e8X7Cfjog22avEU4neyfG9CixlZBj3Uo7oDhJn2X1OnYNRsByYN2VqKRjHCKPTx+oNdoZNT8xkJh6zN0mGU/lDn5ORX7clohGlo+XDomLZG/7Z8mW1dZk1EaSSwbm9dGwktjPfkcU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 07:41:26 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 07:41:25 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Refine RAS bad page records counting and parsing in
 eeprom V3
Thread-Topic: [PATCH] Refine RAS bad page records counting and parsing in
 eeprom V3
Thread-Index: AQHbuYUfBB9yWatggEaEFXP8BnCCXrO7031w
Date: Wed, 30 Apr 2025 07:41:25 +0000
Message-ID: <PH7PR12MB879632DC12DD1C2FD71856EEB0832@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250430040512.307765-1-ganglxie@amd.com>
In-Reply-To: <20250430040512.307765-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=27e35692-c47f-4b2a-9c0a-91fd826bf9e0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-30T07:41:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB8082:EE_
x-ms-office365-filtering-correlation-id: 60f98bd3-1969-4c3d-0c42-08dd87ba6957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?86s48DmVMF0v8FG/6e2ywlhGfNROCeZcBluJmqpuyFCJzCpZl5LWKOFiGxA2?=
 =?us-ascii?Q?YjjA18A5ne8xYOm03RXio5dNJiYZKmTDOJvb4RY8zmCtZdFRG6cRa0BjOua7?=
 =?us-ascii?Q?mcAHlj7h9emFGRj8Q6yYAW5CjO3Wnhj6FwycnRc7Y1ccQVzNlPWo+IBxNpDL?=
 =?us-ascii?Q?jrFKiktOu+DJyQziR2TADu18GH4zwa45xE8L6TGHmgJAp4jl0H/E3IzOW59p?=
 =?us-ascii?Q?YrZBchieBN39+xrMKhmIWfSTiM2R/W4r0nKJ2Dpvbt9wBKaN7FoY4zDcQYFj?=
 =?us-ascii?Q?sAaZ33gImDJZSAeBNW3wx7HpZi6THvu2c8VedAhI/x0BxnhN/hoLWl3CHPw2?=
 =?us-ascii?Q?RZg1xJsLoiIInO/PqAAlKMH8lRGvrFy/L/1OMXfe+wmdkEjHXHcpdzptHHiL?=
 =?us-ascii?Q?bp/A/Ln4aiDgs0IxFMUbAhzPp4t40d3o2zLeKjmbQUW+8vLTPaXE7nb/sQnL?=
 =?us-ascii?Q?pghZAJbXLP0lRzd3515hhTWicZuUEJxhHEViLgZkxJuw4YMcoZQGYTpkZRfl?=
 =?us-ascii?Q?auBvlxJxazVp4u8i7hQS9rtNbReiFpDMC7BPrtEEXaH0qlss2HOoxem5INHu?=
 =?us-ascii?Q?p3fms50af4wmNSFGN1GPTcu8/45tTZaPi00mndjbpNftUTdi4JcXbEotn6Sw?=
 =?us-ascii?Q?4HMa/lXpe6dTrBQ+sJ+bboe9Grr7vc8nDo6txMGuGXbJbiAFSknpfP1X9zvh?=
 =?us-ascii?Q?slfU9UhQZO43/r00DEsy/FoVgnZAgh4u1pr2VLEAqDkqlHnvpEYGAyrbEL97?=
 =?us-ascii?Q?4RbG+Bp5bDgi0/njqEHXEjQuJN2izIOZ5IIjcJj3R+harUlhuXPybRVHvEOC?=
 =?us-ascii?Q?ipWuj7iD0VaHeYC6mcP9TJDz/FXo6WaRHTEiU/b3uj5eRB6uDFZnyT1H0qb0?=
 =?us-ascii?Q?BsiAn6HDR+Gn5o1urOQdsewOsbxCglUr9+xWUgUHfphbsiSRnRYC34QNAJRn?=
 =?us-ascii?Q?r3nnSxayOF5Fk2Gf+SNchviyQeUQWDxO1TifPP3LjodDWmtjgUoQRXugVF0/?=
 =?us-ascii?Q?8ahubyaTWt7CF6d3j3z6WGQTfuAgzQ1fWPbSP7QxpuKZt9Bfv6s0vWrnqx4e?=
 =?us-ascii?Q?rK0AlztZU+zAcMyG3O/sjpjUNHfHdhqiPWxsBSBs20XCxtbyckX6K7z/Ad4T?=
 =?us-ascii?Q?scgppA1eZosz5QO8zkvMItqvARKw5ISfCBWx27milOlHY1UOHwwRg+e6EJOe?=
 =?us-ascii?Q?m0yfX/bH7tf/s7RofdpAEOdo90FXWQ11V8ASz0/PVotMb9GYPYxgz1VdmiII?=
 =?us-ascii?Q?07UDOgKJE5oMfa9n8oLMMx4SASXxVGAmSHsKuNJgU/Aife5eSIdUHc5UlAiG?=
 =?us-ascii?Q?oXzEDOBc4pJRzzJTITt1T4DWhmAXH4qEPBk8+jJtWalqNRB50vIHrfUBE9ab?=
 =?us-ascii?Q?BPv+Xz8VSgQ9WGgcN+pzQVtyTC2XFB2VgV8LuxtAb8vfik5j81N6JHbz5NBY?=
 =?us-ascii?Q?lmN2AfmoEvYjRr6HJOvhWz7SG/7f3nNl27ORItciMNpD59EQDieiONONDgAM?=
 =?us-ascii?Q?sI+IEyFS9w4m+p4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5aaGM2MFoB9LlcRUs7lB+o2pvzb6cKskAlvI1RcqKDolQ0jq+zaG31WlwxJH?=
 =?us-ascii?Q?1MGPDzeC9KCa1/pKSbq+9IkQaMYz9M+O6Qe8uakavjGk8lWPJPwP356unrF5?=
 =?us-ascii?Q?icEiIiDBHoqvLryhLUM1qBvLFt63sZxqFev/ZIMkhCpbu1yiiVyhtVx5mhxc?=
 =?us-ascii?Q?+CWn2Ugkv5LOTBLtz6nbJk4ZHczXLX+l2Fe/CvT+h2t2/4Qtn2GeFj/ulfo9?=
 =?us-ascii?Q?5QKLWM/eCZc7phsXPsYyGU31h1u28YwseHm5mG6Nq9+XzGcNFcLcxAQC9x7R?=
 =?us-ascii?Q?OnaUyT5pDH8CozErTnyaN/6tPW8oTG20519fyLsr+akf6RIdjpXsAXWMVfkT?=
 =?us-ascii?Q?l8FBOQZWqVw9PL1V/dz3d1jNcUxrvvbAGlxROH4c479s1fe2SHJR6fOoU/G6?=
 =?us-ascii?Q?SRl6gU7KT3YOxAq3YRoC7HUeJNotWD2lBjiZIs40vK8oUEraCn0Dza/uM+Zv?=
 =?us-ascii?Q?0AVirY+nqgBs/krAWs5AiuUG8YgT6u/7PtCLFUzEDGHOP2KEmqXX/PAeTINe?=
 =?us-ascii?Q?IiHLD6lvxmWKOEAMPm4rfa3GajbKniDCmjUuc0ltjTrTytdDIg6k2uYzPT8X?=
 =?us-ascii?Q?0uoX55iPWC77nh++xhr+gEzixbGGrDJS9amaxmByJoY7QGgFRlrmQjgidkBW?=
 =?us-ascii?Q?BE9eyt15ryB/ZojwgbxM9u4mXn9k4pKH8NwuC4sjOLhClIT0N0oQYJw4uPO9?=
 =?us-ascii?Q?UpS+xS4ouotCwRPUKbkM5J+JjmjFppg64loImNO1okKyX0Rydp8ZsnoRxk8F?=
 =?us-ascii?Q?TjKOrFqOXEQ4pd+njs1Cb1A6Yu8H+C9zBh406vPpFCHKFFRDIT5ydl26O95B?=
 =?us-ascii?Q?Mk5XFiNIA4nBuj9hmXw+GKKXt8LwLK5T3Zi6OFibpwmCKAMdFsHsZ4qUa0Qv?=
 =?us-ascii?Q?w/F8mZA31G3aOftE0Q3SPi+4hZYOL+FgQ72CvpNCokdyct1Aq0unLyPuRfAa?=
 =?us-ascii?Q?dwZobtNy6kFymcSl4yES4wh35R8y0l4OvybGtdodg2w6/RPCAUHFDfv+6ZFA?=
 =?us-ascii?Q?9idV80ckae0+Fow9cBriiUXqpUbcY7StFY2iP+sExhsuhuK/a9OnU87ueTgO?=
 =?us-ascii?Q?pW0uct1Xi3lKEz/4dy5a5e2w666lrxs+wIVWWGrnoZThs/iufDZ0ngcnGotI?=
 =?us-ascii?Q?ggBTb/6NA+1zcwtFBaHYZe5AxoP9AY4be/roBYGQM2dGiPiTn87JPkULgMy9?=
 =?us-ascii?Q?582KjLdQzLY8EjFRghFwTjIg5lolFxgROVvJ3rEWlLSogyOWBY+Hzna63Bdd?=
 =?us-ascii?Q?AKTOhT/Qva5RmSbhqnigTiinWKzqF/GMx0QxMw1B4YfbbSaQbOrOXOEBFDg4?=
 =?us-ascii?Q?gD5l6q12rsLcyWNMGa7ISSkNwdIWml8IbCmELR2iNoC5PtVi/Nsbe547GUK/?=
 =?us-ascii?Q?abnyo5HvqNbZKZYKAjyxpY+FWXBhmaJ0WSqsAiZMGUtdMSriI+rjnI1iBag4?=
 =?us-ascii?Q?G0z01UNe6W96lTQYdWhvKbgSQrH+vhb1407w+A5Ektq223fCHNxygTHsJzte?=
 =?us-ascii?Q?gpdOZyLysGUeSRwm5DJ2r+MjjCkye+IU5Y2SXP5YvX5xWplbHMZTKFl5nH+c?=
 =?us-ascii?Q?x9enHzN0YkIh1/fY1P0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f98bd3-1969-4c3d-0c42-08dd87ba6957
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 07:41:25.7297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwe4HwOq4gUhjD1sdWnxOWtaYYFUZGVgko5fFWmyFiNCufoxpUDBZczCpM0azlAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Wednesday, April 30, 2025 12:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] Refine RAS bad page records counting and parsing in eepr=
om V3
>
> there is only MCA records in V3, no need to care about PA records.
> recalculate the value of ras_num_bad_pages when parsing failed and go on =
with the
> left records instead of quit.
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++----------
>  1 file changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85143acf3a2..32f41f151c82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2889,6 +2889,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct
> amdgpu_device *adev,
>               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
>                       return -EINVAL;
>       }
> +
>       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
>                                                                       ade=
v-
> >umc.retire_unit);
>  }
> @@ -2903,7 +2904,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i;
> +     uint32_t i =3D 0;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2924,28 +2925,31 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>       mutex_lock(&con->recovery_lock);
>
>       if (from_rom) {
> -             for (i =3D 0; i < pages; i++) {
> -                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> -                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> -                                 (bps[i].mem_channel =3D=3D bps[i + 1].m=
em_channel)) {
> -                                     //deal with retire_unit records a t=
ime
> -                                     ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> -                                                                     &bp=
s[i],
> &err_data, nps);
> -                                     if (ret)
> -                                             goto free;
> -                                     i +=3D (adev->umc.retire_unit - 1);
> +             /* there is no pa recs in V3, so skip pa recs processing */
> +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                     for (i =3D 0; i < pages; i++) {
> +                             if (control->ras_num_recs - i >=3D adev->um=
c.retire_unit)
> {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> +                                             /* deal with retire_unit re=
cords a time */
> +                                             ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> +                                                                        =
     &bps[i],
> &err_data, nps);
> +                                             if (ret)
> +                                                     control->ras_num_ba=
d_pages -
> =3D adev->umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             break;
> +                                     }
>                               } else {
>                                       break;
>                               }
> -                     } else {
> -                             break;
>                       }
>               }
>               for (; i < pages; i++) {
>                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
>                               &bps[i], &err_data, nps);
>                       if (ret)
> -                             goto free;
> +                             control->ras_num_bad_pages -=3D adev-
> >umc.retire_unit;
>               }
>       } else {
>               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages); @=
@ -
> 3040,21 +3044,28 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
>               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> -                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> -                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> -                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> -                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> -                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                     /*In V3, there is no pa recs, and some cases(when
> address=3D=3D0) may be parsed
> +                     as pa recs, so add verion check to avoid it.
> +                     */
> +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                             for (i =3D 0; i < control->ras_num_recs; i+=
+) {
> +                                     if ((control->ras_num_recs - i) >=
=3D adev-
> >umc.retire_unit) {
> +                                             if ((bps[i].address =3D=3D =
bps[i +
> 1].address) &&
> +                                                     (bps[i].mem_channel=
 =3D=3D bps[i +
> 1].mem_channel)) {
> +                                                     control->ras_num_pa=
_recs +=3D
> adev->umc.retire_unit;
> +                                                     i +=3D (adev->umc.r=
etire_unit - 1);
> +                                             } else {
> +                                                     control->ras_num_mc=
a_recs +=3D
> +                                                                        =
     (control-
> >ras_num_recs - i);
> +                                                     break;
> +                                             }
>                                       } else {
> -                                             control->ras_num_mca_recs +=
=3D
> -                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +                                             control->ras_num_mca_recs +=
=3D
> (control->ras_num_recs - i);
>                                               break;
>                                       }
> -                             } else {
> -                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> -                                     break;
>                               }
> +                     } else {
> +                             control->ras_num_mca_recs =3D control-
> >ras_num_recs;
>                       }
>               }
>
> --
> 2.34.1

