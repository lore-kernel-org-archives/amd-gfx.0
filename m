Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED89CA0EED
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 06:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD4B10E151;
	Wed, 20 Aug 2025 06:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D++2DzQw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5015E10E151
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 06:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLcngFbjUodIkwiLWztcKpX/HOmnC2XU9YygPy6gjLPebDgXxkvROKOYwyov8hJnL4OIo6Re1wVuoPA6CuF0ra0lTIwdM8i/QbCAxVIpgNxkILn8GNffVkuv08VbrBSIs7/y4A+Je3Hj525Bj5Yk7VCU1bWVj0WSKDqFD/V+aBVC0W9CH1nvvN2hQ7nUC7T7vgzQaTKiW8sqnUG7ZLGTvG1faDtJOrMwWmGQuDEaUSvmUl4ztJLe2eDhHHJ0PQNwbqWEKrdt/Zwgtm6C+t9fItGhVTjw1Ue9dFWz6A4B0IrScRxe/6h2pdSogFPfrsq0bqF3VV1EILTbA+gYaYjm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrS/JsvKRJnA8Yx6xIo31jE2xbptguougLtwUjb+7vs=;
 b=WpHNqN/ZFDiNXiGjjydrbHU9IS3AVhrsxTkZzglgPCC2PoMVLhI3y8lKU14L82P7UYE/2gebHKFRKzl77WreqO6ZEPdQgqKGKClOHFFeAliOvz1HvzVgDJ61mqLUPmsqA0L62P9u2ig+7eIJ7Mh2MYITTUbGoOQP54QX7fLGrYPA/w3qB/kBq7W1vD9TtV691hZyfI75B4FUDQRxRQf0bTLGwzT2ZDlQNK8hHzHO6Kr5k2iiaciKR4smpIWsMflC6/olh0fOCJ3VhQp6qID1Lr0DbqLpftOc8xmMeHwmUXfwahfsxE4UFQZ7VveEHBrW2ew+MNjB7yq3sKxUBag7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrS/JsvKRJnA8Yx6xIo31jE2xbptguougLtwUjb+7vs=;
 b=D++2DzQwvctRK3b0+NkBNHu4cpHYe0tYpAZ8MzMtOz40uO+4Y5eEBL3Rb51IZ6b9QLmbJ/11URsawvppHAUBZ8YIjeL+ThJ/m0qQ0I86o9p+dfRqGI6QPnb3mFz5doi2NrIYIKW42zkXISOo7jkcGcpJ23vb4wZ69fYOZ+hCwUE=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 06:01:39 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::542:90bb:6ae5:a2b%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 06:01:39 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Topic: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS
 poison injection
Thread-Index: AQHcEMnH3hRnZo6IxEm6T5kGcGXV3bRqxPUAgABBCLiAAAVCSA==
Date: Wed, 20 Aug 2025 06:01:39 +0000
Message-ID: <CY5PR12MB63454C06BC4FD4F4109D2A0FFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
 <20250819052548.124897-2-xiang.liu@amd.com>
 <BY5PR12MB42125F685673D0BDF0ADECBDFC33A@BY5PR12MB4212.namprd12.prod.outlook.com>
 <CY5PR12MB6345B07E614DBE882CE7FF2EFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6345B07E614DBE882CE7FF2EFA33A@CY5PR12MB6345.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-20T06:01:38.9770000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|CH2PR12MB4087:EE_
x-ms-office365-filtering-correlation-id: 015eacdf-2f6c-443f-8183-08dddfaf0787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Jt3pCzHTlXcW6I0K+Ij8xJdYPf+Hv0hu4z5POH8E1Xhu9oKN/d2//6ME0BJA?=
 =?us-ascii?Q?obbsvbc6ooj2hr7bsk9pNapd9LA6DtYeslPyUtriEUUEOOHiuQZAMKxEq4zw?=
 =?us-ascii?Q?1tXDRSf+Mon1am+f8HRCKIHwIpJAYIimFZ9CWCU5ugwpDz1js4Z1pcQfWHGX?=
 =?us-ascii?Q?WTwnka4mXWfm6eHQEfq0Ac5RRW1I7kBLP/7xYuMX5r46VhDuSBPlIQl9ssoR?=
 =?us-ascii?Q?Doog3GphvsqYllWHmxs6c6og4L7z4OR1NeaiWlyXGAMpgUfH4J4/NxKfsaKX?=
 =?us-ascii?Q?u4Xa39fUFd+AiqIEoocj3uDuHDsA7gaZmu2KTAVTS12GIJWQJFrK0kj3Ursf?=
 =?us-ascii?Q?l+FAxzYasz1dilBPCntdeKkomAMGE9XeoTqOAonePVH0NsOOzLZoaAhkXPry?=
 =?us-ascii?Q?PNwSAp5zVTBMR0QzkoOGCGXkM+UjIK8oQ6wldDdcfO+JpdhPts2SeH2upagY?=
 =?us-ascii?Q?XSawfopU5OXlVMIHrBgOJH/0XtwbAV4LBjduOecfYZDX+3oVVr+25hFoL3Dv?=
 =?us-ascii?Q?O0E7mRgPjBdLP3+flgsGRADI7rVuCkvL3v2dPUvOIJP5H5qmbKlOFqRdmDkc?=
 =?us-ascii?Q?JiAr81zb5ql+81D9vbsIqdH+LlZ8lS0D7KcYBJhaU6Ei36xdZN6rdKwvdEPv?=
 =?us-ascii?Q?nv4diewabxMkFswBZfbWmGw7BesiAPCGbOzqRk6iMNmmBTFtVcsyabsHsgNm?=
 =?us-ascii?Q?3MzMs4bNUQdoe14vZ13z4NdSjuPk4E+AtSmo5fut2FQlcXrd+b/j7S4KfpXK?=
 =?us-ascii?Q?CUuMmvMiZBsblWeMo5/Gf7sQgq4126t+fKW+00a2XOxeE6IyRkT6YXAn6Mvs?=
 =?us-ascii?Q?haDN7gqgki2BBAYQCpLyfQ6Q8U3+LuKp6rXG7Dd/nnMYUgLfURb39YtD9rTd?=
 =?us-ascii?Q?ZNA6PTvJFp3KcjaMYQRFfuHBu785IdIY0+6TULLHQ+89qqyiCnmfURdyuftI?=
 =?us-ascii?Q?heoZjSCHaj2C26WDqZI/7NCxp9uxC7Oh170RB50fd4Vo/GYn3HQGIly9KDHq?=
 =?us-ascii?Q?dGAbaHTmdapSrixxTphR7T6SGD1tsCHboV31hFVQFEOu6GMe3pjwhURnYtx/?=
 =?us-ascii?Q?JIbBIWxRqPcXHY5zqWq+iHcNb/Zy3gZT4MaGCNo6sA1YobE9DAXFIlUCng7v?=
 =?us-ascii?Q?w9gGQqGv45kjsrSuxK35wqMJzFIcKzSwCNXVxn6BZ+y/S2oWnC677kYpk93q?=
 =?us-ascii?Q?X0MwjkyMqIeWu/voIVSP1Pun/dsXECBIQ3Yu1u9BL0g1o1GQA9klRul4OBgP?=
 =?us-ascii?Q?bAuihvn55TrdBbV7rODzoT3K7MqwKSQrafxZaJYHLjpmkI0sKNYrEbjeC1Rq?=
 =?us-ascii?Q?Qm9BZbAKpPrJV2PNVSjqCJi8nAQUSD43CXHjeow3sENj1/gWU2ew3Bi1YBGZ?=
 =?us-ascii?Q?SLEM/kJvzcctzZS0sHqCUCfwT8zPA00+2wYYmgxgj2VLjM+PXVna5AhkdlO+?=
 =?us-ascii?Q?joy9jsJVuzdWj7N/gv3Uq4e/WOMP3yZdvDME67u26tBKcThV4FmSAa0khUmq?=
 =?us-ascii?Q?xny1CObteqWWuS0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UM2bYZV0DMxuQr+Jx5oBoJEeYtMpQlMDKTReX3pZBvJ2TbY6ArIrKKcAEKD9?=
 =?us-ascii?Q?lYM5oGzW4K4rkAuFImooqqULPxSfMDQ0Pjz/yMrkDwu3JYeo7kLZl0iIuPQ7?=
 =?us-ascii?Q?p1dcexKnwrNQkeSlNJXmRopo10WCNSFQFEGScvNNgHBZl3vMxnbWiuRpW02V?=
 =?us-ascii?Q?6tujyJfpZyC6SCMHwA9SSlFwAvY0KOe8WnhYr4kI3TKT2euugKrgtjnzg//m?=
 =?us-ascii?Q?Yn268U/ukBkCH1MfqBvkcccE5g2pgCTld5+T5cvwdtbax3MZ0WmHGb16guFU?=
 =?us-ascii?Q?FGhXZMVYAWyWWrl4zrGiV2mJwyKQjJoqadAdBH0i4TJHiGGEMGre6nWVWbYl?=
 =?us-ascii?Q?aOe4iZxU4OP4c72tAY9tr8yDQDcnwbhP9EgXccdGSINN5SJXKY5cjBi8nkJi?=
 =?us-ascii?Q?6MP4le3EA03PKAfZttmAEp+GUBpXDsC6Oq66idY9jDAgBUDwApkj3DsdnmO6?=
 =?us-ascii?Q?J2ihKSwhEb5CF+lTRY+cMqBPeCv4FlthSIJmZGPGnF2uhKZMM+8ps7W6pyuR?=
 =?us-ascii?Q?GfVqlTtRmDKfujEevuOnDYijGi5wD0XvS3MRUc+ASit/WDTqE9ddWl2LeoP0?=
 =?us-ascii?Q?dQf+AWffEvLYvETL0UuXfZeVqLf3likEKHNOphO6GyRYP5LtmuN8YMPI+64V?=
 =?us-ascii?Q?3yDYj8LqbpAUlf12go17yAWaQOi+pVF3REr+r7IYUwGIg96A9So2Z3lFudPv?=
 =?us-ascii?Q?Y2E4y5U2PWdbbgqZexHoQlB2YADwDrNqj4XjXeEa+uBFR500FcheeyaKwvc9?=
 =?us-ascii?Q?ZLEP9L1IsiSJuSlB4bTGZ6DeEHkRAAtDj6pMa8wbI1tnFlPsqaU87hBo+4xx?=
 =?us-ascii?Q?isaAX/GXnKXfOJWtuhSQRQjuDFGk9pFhAXD8ei96ch3wcK+9cp5cwM1W96bz?=
 =?us-ascii?Q?xqMae2nUEElAV7WPnSlvmzErpVUEbuvsp5p1cqXLCjpyO7foh8Ui1Itzfxx/?=
 =?us-ascii?Q?dOdnMrijfleUyyQVZa1L6N67ChZ+VvrJApKWyYaQdT8ysxvzQWG+DXRsTNHc?=
 =?us-ascii?Q?pVXihjSXcSWmReRtiq8KDejFc73Y1djzgIke9MU1x4yk3CYfQDGD+wjNFSU1?=
 =?us-ascii?Q?wL3lD4/TpjxJRNRFtnbegMnV7x4FZ3FeWr24ahWHOrGV7Hoikr24s3OS0vZ7?=
 =?us-ascii?Q?TIA0n+sR9FbXjQ7RxQUvbm52A20F0tE9t8OEreNzSY/AJEK5NrncQbWGpIkl?=
 =?us-ascii?Q?AnHxIGetloeneGE35lYpdzFPB3Y308Z1l8nSu8cTH2hWPBXL3sGVC7tRDa1L?=
 =?us-ascii?Q?rXv2zZqfgWZj75w5LRRU2ViyRCqUWDfb9g+/bHKlvkTb3BHmsR2A66NGAQRx?=
 =?us-ascii?Q?sSRO35EaqVVV73Uibi4RLWK/RqSzCbJT7uwl4x0UkcJPgJ3QXMhD5STY2Vq2?=
 =?us-ascii?Q?UguRibajAS8U7hiLNIQun4GB2V7/ft2JmfkPei0dX7bSATWe2dJFZVoqNu24?=
 =?us-ascii?Q?2iAK6FnR0xKtzWDJrsbnrVFwk4VVRtIG7klbDbSJH5i7JDcEgYTMahMURX+p?=
 =?us-ascii?Q?BYScU1m4dQexuqmo814txPy2nfbpXIAlG/iHYNrYDTkeh8EkpCqdyjypl3+X?=
 =?us-ascii?Q?vI8Lo8INYwFEQrgENvA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63454C06BC4FD4F4109D2A0FFA33ACY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015eacdf-2f6c-443f-8183-08dddfaf0787
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 06:01:39.4851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TSBjR7YMixkYnc7dmqvBIAvgoqFv1AAiDK30MuKFk+dxCiNq2Vm4m4FLhFoTuiAqA/7gHjU58rsIgcJmUduyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

--_000_CY5PR12MB63454C06BC4FD4F4109D2A0FFA33ACY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,
As discuss offline with Thomas, will check the VF critical address regions =
of guest in another patch as a new feature.

Regards,

Liu, Xiang

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Xia=
ng(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, August 20, 2025 1:33 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection


[AMD Official Use Only - AMD Internal Distribution Only]

Hi Thomas,
Sure, will do, thanks.

Regards,

Liu, Xiang

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, August 20, 2025 9:39 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS po=
ison injection

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, August 19, 2025 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection

Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b00cbb927ca8..6730de574fdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,
        struct amdgpu_vram_block_info blk_info;
        uint64_t page_pfns[32] =3D {0};
        int i, ret, count;
+       bool hit =3D false;

        if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
                return 0;

+       if (amdgpu_sriov_vf(adev)) {
+               if (amdgpu_virt_check_vf_critical_region(adev, address, &hi=
t))
+                       return -EPERM;
+               return hit ? -EACCES : 0;

[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,
          The VF critical address regions of guest may be also need to be c=
hecked.

+       }
+
        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
                return -EFAULT;
--
2.34.1


--_000_CY5PR12MB63454C06BC4FD4F4109D2A0FFA33ACY5PR12MB6345namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
As discuss offline with Thomas, will check the VF critical address regions =
of guest in another patch as a new feature.</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Regards,</span></p>
<p style=3D"text-align: left; text-indent: 0px; background-color: white; ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Liu, Xiang(Dean) &lt;Xiang.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 1:33 PM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Helvetica,sans=
-serif; font-size:11pt; color:rgb(0,0,0)">
Hi Thomas,&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Helvetica,sans=
-serif; font-size:11pt; color:rgb(0,0,0)">
Sure, will do, thanks.</div>
<p class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; ba=
ckground-color:white; margin:0px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; co=
lor:black">Regards,</span></p>
<p class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; ba=
ckground-color:white; margin-top:0px; margin-bottom:0px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; co=
lor:rgb(36,36,36)">Liu, Xiang</span></p>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Chai, Thomas &lt;Yi=
Peng.Chai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 20, 2025 9:39 AM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Check VF critical region before=
 RAS poison injection</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font face=3D"Times New Roman" size=3D"3"><sp=
an style=3D"font-size:12pt"><a name=3D"x_BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt">[AMD Official Use Only=
 - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Sent: Tuesday, August 19, 2025 1:26 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: Check VF critical region before RAS poison=
 injection<br>
<br>
Check VF critical region before RAS poison injection to ensure that the poi=
son injection will not hit the VF critical region.<br>
<br>
Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b00cbb927ca8..6730de574fdc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -219,10 +219,17 @@ static int amdgpu_check_address_validity(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_block_info bl=
k_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t page_pfns[32] =3D {0};<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hit =3D false;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_=
HWIP, 0) &lt; IP_VERSION(12, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_virt_check_vf_critical_region(adev, address, &amp;hit=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EPERM;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hit ? -EACCES : 0;<br>
<br>
[Thomas]Only checking if the address is within the PF critical address regi=
ons may be not sufficient,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The VF critical addr=
ess regions of guest may be also need to be checked.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((address &gt;=3D adev-&gt;gm=
c.mc_vram_size) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (address=
 &gt;=3D RAS_UMC_INJECT_ADDR_LIMIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EFAULT;<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB63454C06BC4FD4F4109D2A0FFA33ACY5PR12MB6345namp_--
