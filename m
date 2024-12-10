Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A160E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 16:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA9110E28C;
	Tue, 10 Dec 2024 16:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NdhdjiXq";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE6310E28C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 16:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6YOgfvCkgRPerXdezJP8S1C/diuaxa/09E566TWMsTZwxg7KiQQgHiRxNQjg6/P/R9oNIHNUpF3PYfqlhY1OCWWO7+iRKVSMe3PHhbdZyjzsu1KjbM/nPN2fcN5kzRfJSezcdHo9FuWsu3nSNn7XNKJCZBE3SHVI9vKQQ4PbCS7YXCakCQcs5VAmHx62Ax+QH8G6h11eL4+LFKu4vqxM9WPXvTGzAeIe7aXlxsRc3Il+m4LNkI35bbOVnnVhGjIY8ILcR+ZV4jKcqTl8nr73zy0JzktqHQuGd9+Y9GpgNCc0TtcHaYiipxGXaODzmFu7QxyguVGHxKGGUghbhIFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm6tE9Dg0b+4AoF9yGX61+qasoX3JUwo2wuvotJK/V4=;
 b=qVAYwqJjeCJif23/YAqBqHcydL8VuS5jfe+L0153SdXnxw60MjbBvK3jvmAcJYowwNXiKy04Qi3UA9Y0oPPs3jR8cVN8W31FBFOqPUgdo+n9d3h06Ddl+0FDiVRSVdViz2SbubBSvl1Hm0Fa+QGGWKrmBxuLmHSTgNJPFjdQXkU9QqhxmPX0WxEPvIce5Wwc6Ovryz9spdPj/JPV39mEYKxbXvkNhAUX1ghpn5bilzLXozPWguGrM8JzKBOebvzpvCZcN+yh3X6ncksTBu2EzWdaG9nQ3cnQAkrr25U1kYX4NvHK3YYIr8VdMxs4x9feDjpqMgw1/oUpgOuNbKX4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm6tE9Dg0b+4AoF9yGX61+qasoX3JUwo2wuvotJK/V4=;
 b=NdhdjiXqSwOts8F2BUS4F2iJTGQ5IpR3SmUNILC8OVMve8iJpJwSPM+PT++IY6Hrl7rMHC1EtzZCD41fD4XjZRWYbBaKvT9/lx6EbuRCruK+EM43lhXk+x2MVSI0qeUUzYvzV5BQwrpk5EKk/AiHu7roTFBinKSKz9c7hA+uK2A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 16:13:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:13:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7
Thread-Topic: [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7
Thread-Index: AQHbSrczsuStv7+U4kORINKuBSUUQrLfp00g
Date: Tue, 10 Dec 2024 16:13:20 +0000
Message-ID: <BL1PR12MB5144887A577191F02993A1E6F73D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241210035318.2159002-1-jesse.zhang@amd.com>
In-Reply-To: <20241210035318.2159002-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-10T16:13:20.251Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB7952:EE_
x-ms-office365-filtering-correlation-id: ef2bced2-1c59-4efc-9ce0-08dd193590bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+iXwAkf/5ZankKVBvmYJo/oQUo0ldVzPEJ6AoHKX8nbBsPFMAu9xaDyBCVtM?=
 =?us-ascii?Q?9kQbUPySxB7ZSw8CKccycqEQiFo6q78hvJUPbXgFEffT9rsuFJ74HUY+4JFQ?=
 =?us-ascii?Q?E5m7XYf+e8u1AcRcwfuOlLnAUTEePWNf4KCjvkQcz158Wt5H+ruo9hOXImkl?=
 =?us-ascii?Q?InRCJ5T7QgBVBVf+iOze7bQVL0nPYYoZscQWDOREtb/OvY+n0cklgyJ50EXb?=
 =?us-ascii?Q?rVjkfRKR8MbIjKq20L22r6yojqaPnDFXZ8WoyrHSvjIrys/s8R8aadB6IWWx?=
 =?us-ascii?Q?aE6ROZpb8Jcp5cjOBfExQj1eq7kjba/TAoRExm+i9RyIIdZqrHGdCxjuRKvy?=
 =?us-ascii?Q?UL/B0e4Cucw2UEOU2mUmwMm5s3VqPz1YjLIm3ZXutVvrlJgZAGCS3GbW00Vv?=
 =?us-ascii?Q?Ci4vcFWKGSRrSguqyUtAytqT2MF2zAmViPFI499tX7JojRuWWNWeLgOZmypO?=
 =?us-ascii?Q?qus6Jgzc4dP3KUZXOe+At3zuNIghFJc9mZMVZS/LjcxSBlyU+hKlOKMyPeAp?=
 =?us-ascii?Q?0VAh8COaLdiDwUdLtDFfoKnr8pdWQiEjNRHX0Em9qabL/pqXONe76F/rgQwO?=
 =?us-ascii?Q?TBbvRM07s/X9B0my9E4AUtX5Q+txnD+jGXxVoYeo9ofj045Sboo1VG8UP+RB?=
 =?us-ascii?Q?IALpsaBGK8eQKUaJoJicNXiNLqMMk2EJMX8/qoka/EQ84EB4df1y/EmMBhqA?=
 =?us-ascii?Q?uqp3S3mu3DkyyLACL55RLUSyG65/5WXWqKHMS3G/WRtujrY5pWU93S7IDR4v?=
 =?us-ascii?Q?qvfFQ80klYV0M4XgWdISwcEII5K+sEwwlrEtSjbytNmczmAhM+EiVDCgYm5W?=
 =?us-ascii?Q?4uOhVYxRMldFOEoO4fkx+C1DLOwPONzJNExbR9lHU2O3pjhIfVCxeZ9Im03r?=
 =?us-ascii?Q?JDdk5hId6HqJAcHPzaS8DH12KE+u0lSQ52pd9tBnrJ0fIu3w17AgxQ578GQE?=
 =?us-ascii?Q?oF41wvLcZpfDtXveY1EBL+11VHB+u9X/ZqW1iU/yWr0v0kmwDWrayVCX4E05?=
 =?us-ascii?Q?S5fF/TSr/Re2KMgBr51J7hDXBl9BolBex9v+Tm++Zng79Lbv+jg/0/F5Do3C?=
 =?us-ascii?Q?c7OyxPE5q+C9mltYSkFR3FWPz04jZwiZa+3tw3FXQKP8+Htc/NXxgDZo7SSY?=
 =?us-ascii?Q?OpgQanQbL0eTHcINOTTU6wN1KUoA9FJLUXocjIlnCTIRYX8dad4ePG29V2oD?=
 =?us-ascii?Q?oii1B833GFyHAW4n6kJsp6xzYaYDRrMsdo0b2HN187ixLgPFWcCu/ZEkjX1G?=
 =?us-ascii?Q?GmgHq+b3+iwQZVF7O8c7iwNch34I3P8GEC8z4vEOVsVSxBmUqRZl1vGw7ZNd?=
 =?us-ascii?Q?Pfj3ON9alYP8LlMj4sURpP1rylU/aywIwVQ0wDdtIKr/koVhQ9eGypFzKjPY?=
 =?us-ascii?Q?bTerUwupQMVCWvOJOK3AtfaHHiu08dnFxWD8Ju7MVDgJzLBRyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ij8JzsD+NmKkaO1uYAjUzzBKtJ2iMrMXl2YOyYXybqnzhP5A1a4VhlMqj/G?=
 =?us-ascii?Q?uPyr+GwC9qvTxnoH1QmXU1BxaGAPScdkVlmzmZp63Rzh8Jco+p9Rzou31nWZ?=
 =?us-ascii?Q?F/QiotMMltKVkupeE1cSpb4R6CAObptkOBPCZ2dyv7mTo8L2DodgtXpFmek9?=
 =?us-ascii?Q?odTUOn21Cjzeyen11DEMFRL29UjrnAQYrsD2etRRi61Ydlazs25eKojhtraA?=
 =?us-ascii?Q?I/2PN+dOJ+mvHCt7/KRLzJSO5wi7Un8nudfn3DCkIArrdxd3Ibw0kXjahrSl?=
 =?us-ascii?Q?lq32Hv2tSjw+Wyh6qDwC94kS6O/i0onk5Ohw74zmFN53G6PGdRyNXlTSpkv9?=
 =?us-ascii?Q?IZLIC5qtUwNAtd/3DhSKieULrgG8Z0cplEri233CvgbNGpDVp1FMigvsUB6v?=
 =?us-ascii?Q?29X353Mmd9+4/AajW21/HvxZJ9yDTyVuNdxdIZtgLbbl8vwa+tPxKPQTfd4J?=
 =?us-ascii?Q?HYvELwoHks5vb+1Mb6lzSXtqiN1Q6oZrHJQV2EhfJnlIJXI63gxuvzgIwB/y?=
 =?us-ascii?Q?GXAe4h+B5/JyvX6iPOJ0QBPYkyrGBTbCgEZspF7uTAQi024DSUUhMRtnhV+t?=
 =?us-ascii?Q?JRb61Z+qP/dUofL8nEPGWPtYvTBO0ObYY6YUTFZLBYHX3Z6p67TyWn2AQtuY?=
 =?us-ascii?Q?MCz2pLWsFyj2hXSshOD6jyjuZb2Vp3ZWsjODpdgewsvZYNpttJHoUo6XEX9K?=
 =?us-ascii?Q?ZuOF/ypEhzmbOrpCcCxE2WUNUPy85YhwlLIoM6jTsVY+u/U+VR270p0OVuuN?=
 =?us-ascii?Q?5Jsx3oBQfIuLBycwrBmaQrXpNIKT0JcTeYMo5X33ke8y2sD5Ltwi2NNfFGgW?=
 =?us-ascii?Q?XsnUubKemijSa+NdEyFIlD7pxmgSRPp9h+/QjHehJ6pjI5/0hyob+mu9gzHD?=
 =?us-ascii?Q?fxO+Hc4jSLt+qK6045R2FZ0rwiAldG/GnOklyyB64NwZ3qzBUarG+VAKyvKQ?=
 =?us-ascii?Q?63ip8FZp+VaeQAPxM1RN91JUXjGPDOVMygBIa1LO/T3CkRGAbt6faGuS+kAd?=
 =?us-ascii?Q?XiUQNXGmfo/R65Efn8O0Gz4q5k+QUqgmy+37Taekrfv8oNlqgkiMlsWVXFvT?=
 =?us-ascii?Q?6uKVbzHt0vf4EQQgXG3sYAEUB5xljNoFZskDcY5V4h0p8s3V+QWVEaZoYxvu?=
 =?us-ascii?Q?1NzPpADWyFnC2S8b/NqbDYO89tTRAytHwd/NEQV/Dwhe1Ovp8g53ItUCVqam?=
 =?us-ascii?Q?hx/rg9NmOnmH1abQlF8wW1o0TBGqokD9h8M9eJ8NkLs5GXjbejQn2NTaFLbr?=
 =?us-ascii?Q?cQMEeW9fk/73eQa3FiljLYoCckYkuvyLNeLd6RX4Q3hHkb2t8BnG6Pb3Dn71?=
 =?us-ascii?Q?CEaCjKuKAGZxzvF/EHa++yAve91Gfv+Xs1gZU1zdDxolPcQx7IaEAf5sDb8m?=
 =?us-ascii?Q?Z+Re26kOHWglmHU+ukRLkjSqtIdsQ/JTHuBAcVG8/ZltY4nmMzjzivutucE9?=
 =?us-ascii?Q?gtbNCNctM9rEKPMRAatUOD/Q6qzZpyWHePqYQPL5KcvlLwKKZT9fWFXJ34FI?=
 =?us-ascii?Q?lqfw1WGMHXQ/hax3HtGheSk0rINde5bPlBNVyv7fzr7z001Y9Cy5WSIhVV3N?=
 =?us-ascii?Q?yr7NXzYZS6uSyMshWa8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144887A577191F02993A1E6F73D2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2bced2-1c59-4efc-9ce0-08dd193590bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 16:13:20.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTID3hPl8AmQax4YATqAUCiBujJceOD0ggQ9grjJYXsx0cMS/kxpHZRWdphimqQMxGq7t7jBm1n5J/d2EoMiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

--_000_BL1PR12MB5144887A577191F02993A1E6F73D2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jesse.zh=
ang@amd.com <jesse.zhang@amd.com>
Sent: Monday, December 9, 2024 10:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Liang, Prike <Pr=
ike.Liang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7

sdmv7 queue reset already supports by mmio, add its sys file.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c
index 627e0173b64d..8e69b84e0165 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                         return r;
         }

+       adev->sdma.supported_reset =3D
+               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].rin=
g);
+       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
         /* Allocate memory for SDMA IP Dump buffer */
         ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint3=
2_t), GFP_KERNEL);
         if (ptr)
@@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *=
ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
 #endif
-
+       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
+       if (r)
+               return r;

         return r;
 }
@@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *=
ip_block)
         for (i =3D 0; i < adev->sdma.num_instances; i++)
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);

+       amdgpu_sdma_sysfs_reset_mask_fini(adev);
         amdgpu_sdma_destroy_inst_ctx(adev, true);

         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT)
--
2.25.1


--_000_BL1PR12MB5144887A577191F02993A1E6F73D2BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jesse.zhang@amd.com &lt;jesse=
.zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, December 9, 2024 10:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Zhu, Jiadong &lt;Jiadong.Zhu@amd.=
com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;; Huang, Tim &lt;Tim.Huang=
@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 5/5] drm/amdgpu/sdma7: Add queue reset sysfs for sdm=
av7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">sdmv7 queue reset already supports by mmio, add it=
s sys file.<br>
<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c<br>
index 627e0173b64d..8e69b84e0165 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c<br>
@@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.supported_reset =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_soft_full_reset_mask(&amp;adev-&gt;sdma.instance[0].r=
ing);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.supported_reset |=3D AM=
DGPU_RESET_TYPE_PER_QUEUE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Allocate memory for SDM=
A IP Dump buffer */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D kcalloc(adev-&gt;s=
dma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ptr)<br>
@@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;userq_funcs[AMDGP=
U_HW_IP_DMA] =3D &amp;userq_mes_funcs;<br>
&nbsp;#endif<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_sdma_sysfs_reset_mask_in=
it(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
@@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_sysfs_reset_mask_fini(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_destroy_inst_c=
tx(adev, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type =3D=3D AMDGPU_FW_LOAD_DIRECT)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144887A577191F02993A1E6F73D2BL1PR12MB5144namp_--
