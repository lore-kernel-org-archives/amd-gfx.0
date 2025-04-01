Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0D8C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 19:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0D810E149;
	Tue,  1 Apr 2025 19:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYc74scj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBF010E149
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 19:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMCVT3OCJVA3RplkJb0+4EjKV/6WMtATB4iIIwYMVuo2uRbTiTtBVogYIBmuzfN009B+H+19QVesoL3FkHQdHItbKNUmpDFQU9FYdVz1Hjh9vlfCXWHeGOcI0/G0AIbTT15qLi9yiBRbUV3ZhNkpZglmw4MvoKXUxHUQtkojss38tWVTgeh16lkjq4xMUiDIa2K/3Vd8HRJr+RFHDH06dhItrVJGjrblfXCumXFSwGL7J1gvgbYS3l/kNvx6vefRwUx2IhCrYHAxJaX9KlqJ5uceVgKxop0D604jijpcmm7RmOzRr6Ybe/Goj5rmn6FVt+ordR6pM1832HkcTuAo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCR/pYr3vE4b0K71Fa1goc9JLSWeI0Mw0Qx9KX/33eI=;
 b=sNNepUIpI5S9O032K1o+GEAG61e7jhY+Drsyjqw1JqJBkeCHERGU7+m9pI231IOE8H6W46i2pXwQF/KaYbChQqEj4Z0vEyr533dgekb+im7P/qpmk7X8Bn62s3HvjKITiYNVjAzMfiRM3JChLQAOGj32rHqPli/jEOmGWZDwOUFzVDQFyA2Vqb7K4gXpZoBOlCmq+LdiFSSU4xRt2VyjDND6IiREaV0A6Vi09EKJExZSYV4nDXgXkX9aVXFC3+fq0W5TquHwXGrS4o0Vs21U6Jy4KXIyD68NU8N2Si4xJ6knz/mHofTQ/6WnXeA0XFz3RXUqRbBKOm2gVdmsQWeIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCR/pYr3vE4b0K71Fa1goc9JLSWeI0Mw0Qx9KX/33eI=;
 b=RYc74scjIhNzhEkbwMQ8OrxUjUbq1Ho8YnPKOuGXbXIv6Z3MdQolZSQGp8B84qFYLMlq0gg3Tb5cLc2ah9XU79Cbnt1yVq8OAL1n5AclIwXgdpIMiUMeGE1aOrzjT0vRCzoEPmjrUlyMqxgpEcvpc9FW4grNAAQU8JyE43ER3QI=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 19:58:45 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 19:58:45 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Topic: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Thread-Index: AQHbolPrjKkZl70QPkit8XBJA+Cxt7OPPDXg
Date: Tue, 1 Apr 2025 19:58:45 +0000
Message-ID: <CY8PR12MB70994594F0790EAD3CA31E1D8CAC2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250331154456.1879064-1-jay.cornwall@amd.com>
In-Reply-To: <20250331154456.1879064-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9a5e25db-0b87-403c-a3c5-ee7118f16167;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-01T19:58:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA1PR12MB6701:EE_
x-ms-office365-filtering-correlation-id: 8145b530-1044-4333-2b74-08dd71579c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QwWSdVQRIOql/BeNcAbrZ86R/SCBJCPrDQvb4Ds9YqT570fP//sVgVj2EWq4?=
 =?us-ascii?Q?0qeYhymh2ZVz9CxRWMokzTtrl6WLmcndup0sY49eJrsdPSDIr94Q5GdCDavm?=
 =?us-ascii?Q?g4qMVjuk90NG7qZb7EttpBbrJ5as+CdsK/0N16oFbhDaZq0WsXvxUGkRVoR+?=
 =?us-ascii?Q?/+t2x2ubBHcx7qbjZdr6I/wD5VwTZ/v1N3fOqB6+Iqvlai8IvZFXAo2j7FY/?=
 =?us-ascii?Q?N6WcKDo7sYnDgk+de443IBYw1qnhNpZ36hISplwCZgpx2AzfET2SJNqrhP5g?=
 =?us-ascii?Q?Mj7Zbj4nN3PU5iZhwgLGYKiY6iz07MBOGxyCrpZEfu/+UXN/fqk7oeaPA5LH?=
 =?us-ascii?Q?PQ46NnYOYJN41PFsJyyp9MHICL0xLsfUvLeiH4HA9OA5VM9yg4+8H2VIRJrH?=
 =?us-ascii?Q?SiMHPY3TVx9KCn337dW7ZtbInFzY2JoDRM4akX+pVQM8IYzTzF7brzMk6nms?=
 =?us-ascii?Q?AZMgCInqe//QRv4OysqfVYp9v2fUg2pQk4r2mRrQd7Xi2L3/PEBZ6Vy/cf3R?=
 =?us-ascii?Q?03shZF029NXK9n2BpiO5Q2EF/xI8JidlSXuSMD8NllIVWVXVC6rmG2Zv7tD5?=
 =?us-ascii?Q?jdYZ3WGcUXR9s7THg4q/wvOp/zJVVc0YJvENzpVb5o0yJEIZWny5HosieOn/?=
 =?us-ascii?Q?rWmPJ1MYhHzb8FUmFF4OPpW7KtmMvnA8r+Bfjz1fNhpyY8BgXpWYxsWMOMOx?=
 =?us-ascii?Q?wrY2quSg+9B9umyJ8+Zw4W5dJqSdN4pDPokAdl1/VjXG8Idk5MyA38VzU77S?=
 =?us-ascii?Q?fZfNgNm+OUsh7RgXx2CD5LaTbrhMl0va8WY3/FmUVJUPj3X7aq/KfwJjg7CL?=
 =?us-ascii?Q?Yb2P5NVO8KPHLyLt/grNK7gkB19rP+jRMugcmBmJYzFTEyhqUPVenrsgZsYi?=
 =?us-ascii?Q?t9R/DuCKP/Urm+/AnWYj4Q+m3LiihteTf2o7VTXB2JiTrP5VQ9uGeG18P0KE?=
 =?us-ascii?Q?VXXMDqKMHs/a/q3bO/1uv0DQjwfHEt+y5NaV1h+6T3r0HYTv1x1uVusbTQQ5?=
 =?us-ascii?Q?IZ0d+glpwjTiTJYPbE6HI8f2bIb63m+RIeLsQLZzyZdQ+mkO9DYU9ZWxeUPX?=
 =?us-ascii?Q?b189ZxeXSpI0hZZVBg8lsrV3dlN2Io2q6JeTXoHmJwQvjkW4sh2yZh8zV2Pg?=
 =?us-ascii?Q?xseJoWWj/I5gk1uNLpkhvaK24y4t2iS+bb+4l/gfdDNqFCKdTSwOZTjSMxGG?=
 =?us-ascii?Q?txJ9WNFqi/d10zh7kmTdXbML70ffBkPw54zBJQqUX2AIrOxla9rLpas7ne5d?=
 =?us-ascii?Q?tVOdbx24WOc9mnoVkXJzzLsBXj4kKCpIX506JrBf3vGv9VCcimATuYk7GD0J?=
 =?us-ascii?Q?47ZeB/W446LULKU/4uoci/WFAGv+nTQnanUf+/+jRc5VoxXbKKwYPK9bVh8a?=
 =?us-ascii?Q?sVt2IKLlqCBq1buuNp3PLLiRvP5otdkLOAsEfMwMvHt0PcHDzn4smFLR0HJA?=
 =?us-ascii?Q?i9HPtEpZ9gIggpyXo7O0lk7XIt+0JlqU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUSDNg53TVP5MmJ6APSbmz3vmX6MgQ+foh0EXhHWjTvA+PbysrSfBIH/xbCi?=
 =?us-ascii?Q?HHvhhgL+OVQsgcPOJJaN7uoKmkPBAs1rfthmPLJNrEJVn1CxmTNkFKBk7KDh?=
 =?us-ascii?Q?MiWRpoGiLLsd5KiwuLj4bqRVxPp15kOWPE0gE1aow9AgOu9F+H0N2zkZLgZJ?=
 =?us-ascii?Q?YjwoqXujhdEdKOJxYKKt3qHevcDPQzyqL7Cogp7Mb2CGojYFEd4p9fMBoWdz?=
 =?us-ascii?Q?VljtSp46wGH2QgPsQga+Aw22R7LmCHhfbV3QOtN0jB6dhpfdSK8NsFYkDB9r?=
 =?us-ascii?Q?hp0OUIbVokmihkD5iRsaNNXtSCrOghrOmVqSOolwSgdWDd+w3BvOTlrPz+Au?=
 =?us-ascii?Q?R68vuNNIiMt2tziKCG0OQiuNkY8A+JtQX0padHm7kWfo/TTRebwhN4a341fA?=
 =?us-ascii?Q?qTty5m9cK/Du2EoLQ12zlUtgeKd5PBW8t/ec/5Ltd0KzviScJdnV4UZLbEWp?=
 =?us-ascii?Q?QChXIWvYoXhmDzO3O/TwEDyP5jwh9LqUj09xZ8LkKgzUcp1QSTwwMw33oFOR?=
 =?us-ascii?Q?+3XXvb6zXLOxs7WdSysTtu/bD/6hF/HrTEUDgr1UAD9O6OCSzmzs3MpIpSpG?=
 =?us-ascii?Q?i/fT2qyO9cTw93DJctzIcNLvqjSd2LNm0s0LhWxNnfiFWY/ZoF7atHwv8q1w?=
 =?us-ascii?Q?8LiylpsPYVDqrGofy9lqcPrmL4TgGtliie4mVf/lUSspBfXy011yS5ZaxfVC?=
 =?us-ascii?Q?xCh7Unk6KaUhfzql3s3vnM8044C7qfwGRmfK/3INgw5W+Bs5Rta83K3L0HRQ?=
 =?us-ascii?Q?//u8NcJAzXA4GezRQzkStI7lVerno0LU17UqjtVrcAf2xcnG678qeED6fEFy?=
 =?us-ascii?Q?PcMUY/Hm5P2FeD+OWk6RYjc06Qube5SqZBEoiCmvgiGMJCn9zXCnOfDZ38Y4?=
 =?us-ascii?Q?2fENfHf1Jt9ITZOBmixRUBaUTIP5KBgl4OaFWGdcpmtmxsgApFpLKX+RHENY?=
 =?us-ascii?Q?lDcb0dAFoOzwA3Vyrt7VkfMAYv+hRGiXPfEVvl1O41hiKwpR8nhlDSgEbu3U?=
 =?us-ascii?Q?FNm0hiMzn4eBqRNtbhISN3UArrLvqTDorPvzV73yAqsGVtbZZkDq4pE8y/RY?=
 =?us-ascii?Q?6tGjFD76RBtSKC1DKrxdGzhZcnzfZFF4gzYQCvIr23I7uxwPAEsI4pdZDHjK?=
 =?us-ascii?Q?QmHL1stARwhV3tC+E7ZP8dZLuJA+u6eRJjtKUSjVByzo6606M+xd3ObA//LK?=
 =?us-ascii?Q?dySx2/lyziROhPByZ42IG2/icig8oDFLTRysi7F2JzwaetAv5+gUFau9TUpL?=
 =?us-ascii?Q?dwfUueZetN1c19C42RAFxeMPvG5oD6MaX4QeLXvwXzZwPIuxooc4YVf9Fi0V?=
 =?us-ascii?Q?EeTItpPnq7iFHGYlyGVwsoXmCjdPhyaCQpDE2ADDRldu5twSY2A54NiCLnem?=
 =?us-ascii?Q?9+zHWn3W09dVMor0leF/Hy5FShVTdTZggJuULmxUJyaHx1WR9cjqcOpvuwN6?=
 =?us-ascii?Q?MrhdcE1HUG3UuojJ3FhO97935/oX6VuXk5Ord+g0EdzVTDCwmdgLPwPSsjfu?=
 =?us-ascii?Q?bHMmHVFJC1+V9MEgd8zlkLRievUpAqH6ycjEDTOEwfJHiFzebuisbip1xeBG?=
 =?us-ascii?Q?C5MBQ5lLG/gIOKL9RGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8145b530-1044-4333-2b74-08dd71579c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 19:58:45.1099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM/t+Cm0nwXjIUIW1S9hlzYAXO6fGEYsPjoqFKboTL6PF2NFdd0bTjcc45ldKqq6yrCcEVZHjKeAgU/SEMyC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jay Corn=
wall
Sent: Monday, March 31, 2025 11:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Russell, Kent <Kent.Russell@amd.c=
om>
Subject: [PATCH v3] drm/amdgpu: Increase KIQ invalidate_tlbs timeout

KIQ invalidate_tlbs request has been seen to marginally exceed the
configured 100 ms timeout on systems under load.

All other KIQ requests in the driver use a 10 second timeout. Use a
similar timeout implementation on the invalidate_tlbs path.

v2: Poll once before msleep
v3: Fix return value

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ffca74a476da..3cdb5f8325aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -356,7 +356,6 @@ enum amdgpu_kiq_irq {
        AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
        AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 464625282872..ecb74ccf1d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_devi=
ce *adev, uint16_t pasid,
                                   uint32_t flush_type, bool all_hub,
                                   uint32_t inst)
 {
-       u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-               adev->usec_timeout;
        struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
        unsigned int ndw;
-       int r;
+       int r, cnt =3D 0;
        uint32_t seq;

        /*
@@ -761,10 +759,21 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_devi=
ce *adev, uint16_t pasid,

                amdgpu_ring_commit(ring);
                spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-               if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1)=
 {
+
+               r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
+
+               might_sleep();
+               while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+                      !amdgpu_reset_pending(adev->reset_domain)) {
+                       msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+                       r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_=
REG_WAIT);
+               }
+
+               if (cnt > MAX_KIQ_REG_TRY) {
                        dev_err(adev->dev, "timeout waiting for kiq fence\n=
");
                        r =3D -ETIME;
-               }
+               } else
+                       r =3D 0;
        }

 error_unlock_reset:
--
2.34.1

