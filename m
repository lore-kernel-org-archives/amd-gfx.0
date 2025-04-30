Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13F6C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 09:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B50D10E0E3;
	Wed, 30 Apr 2025 09:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dztl5vm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8B210E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 09:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsU/Rr5sp7Slx/dQARERlntd9BP6omzqV7n0zbs6LLRmYmjeRL99K+TEw+DyhursNvruVy4CI3bH4rgIlJZXWfjIYqfO54+4aVfJYk/5ZR15MPV4I1gGP5ERlMuOf3X1pFA7HLBAQK8Zb8ph0bojqmSA05CaVIOmCcmZsTi42LS2pzSVOol3PKTvovrsLptK1aYD0+tTOljvswPDbaKcVUiuePcctRgUx1JEM78oXRR/Gz/iDoyaL1rMW9h2gn7VfPVcT4hcFf1p+7B1/vDTWPN7ononUGdLaTuk+FjfwSKdCyY+Tf36OYqG69wWqSkf1zbtyVKSEbeUajNLhaBIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk5zif4wN/P7m0SqgGB+po5ZbS9YBlY+UhtAcLTEKa4=;
 b=tyAuNjtwwEmNJQpOAir8cp+pNXpL2joTtVfBH2JmzH+FMRvbK5wIfz2SP1/Dq0UljWcKI3rQU+ZRp3FQ37BByL0haYVrCw+QUsYxwRw43AOu21DMC0vLeVlxig5yoxIj7OtOrX2dcqYx2uEjVI4tt4rtbg2Mdf/no/6e0XxPLd8Zh/tey/bspd97/UE9awAGl5twelcocfSlMWxXyYr9EjrQk+9BJslUMYKFTcO0a2Fdaft5xtyMLZAM+aQkzjOgV7ZUdavOJuzWN+PWuC+GnFt5Q636yTpJMxZRhTZD86JARB2fHWDGapKpRHm5uAwobLKEgwLlOO+Dxk2a6iv9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk5zif4wN/P7m0SqgGB+po5ZbS9YBlY+UhtAcLTEKa4=;
 b=2dztl5vm0xsjqgsChXeweghr6DsNahGfCLCmCrKWhbStQsAUEHWPHbRwzJR4nT1Tj/n/NxtVHWcpDYclTc3tJW2iQSgW/+Oxiq+SJD064u7TbDfY1Xf7bdTGeX1wiVqWcNUzCxkui7U2Q/Yj8YRpxPGAKOXUs3ERmBY/xz2y1UM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 09:19:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 09:19:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0
Thread-Topic: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0
Thread-Index: AQHbuamOvDsZGn3fgkqqsuWB7v2oC7O77c1AgAAAd9A=
Date: Wed, 30 Apr 2025 09:19:19 +0000
Message-ID: <BN9PR12MB52578BA228EE87DF25597ACDFC832@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
 <20250430082550.60109-7-tao.zhou1@amd.com>
 <BN9PR12MB52572D59351ED50A0C894D47FC832@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52572D59351ED50A0C894D47FC832@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daba74e4-06bb-4b54-ad05-7fb5f2b9ce63;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-30T09:16:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7037:EE_
x-ms-office365-filtering-correlation-id: a2e49f26-e4e7-40af-7856-08dd87c81658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zdGETCephNeWFCeFxavH2TRUZMz6MdHGSICMuRX4IN1xd1QCv+BsrEZsfMY/?=
 =?us-ascii?Q?tH6hg95jZnY+WQERwo7IQ7PFKW57s88gplTbI5w2g4S06aujPIyHC7HajKfr?=
 =?us-ascii?Q?TNfMHPapIiDCCWB9ShHAGBPeVxg56IF//Z+F+ZdBHMhIiay1WxDlf47yZ8fA?=
 =?us-ascii?Q?Q+hwK4553Gu6HCaPbEWKcjWiB8qUtLKmjNRbA/RZ/WvLL08P/a9NzIXI3fiR?=
 =?us-ascii?Q?gR7p5Zn5Y89TYnQhPMtC/FHm0RPOvvjZMbVUC3D2Zx/gMhmb6bJb75Vg4KX7?=
 =?us-ascii?Q?0dMYXh51Y7FiaXjFkUP2x2EiAy1KV/y7Io/F9RQZoK+IOfH+86sGVgD6xrD4?=
 =?us-ascii?Q?8HPRHZkdFHBULZUMQQ/o+/Na6N+QYH8hEwDb1OrSJ/gGEu9dEm5qXo2H+3qt?=
 =?us-ascii?Q?raUpjAGHSGLMN8MZFwKm1Xg1W2/oMOxu/hAz9ZiBV88ImLKXkDDRCG6B0/ZO?=
 =?us-ascii?Q?Ak8VLwXrDWXmYX2YdwIxVriCj5yY3Z+CiLLdV6xPSEfr2OaYXNwTepNfKLwr?=
 =?us-ascii?Q?WGXkmpR+tPrfGjJ8vqNMKWbFR59dGz6InrfxXdw5RlZMdvT2ivdQGxnfm8V7?=
 =?us-ascii?Q?ChgzXP6Ujlt9FDO1WxcYywonDAMNUpTf4B+Uwodn7GwhetdhcPR7AsiZFMHm?=
 =?us-ascii?Q?6jqrIa+ohJzroFCAicdUT5QXyqV+qjdd6KJ5yFAm6zT6gj7b3Y6ntxWaT29y?=
 =?us-ascii?Q?4etK8Oejbw93UQejP90UkTs3YW8Tf6NguBXFxC3jJ6k5II8XcxbW4uOjhYKR?=
 =?us-ascii?Q?Zeir2Oy5Nc+9hunXpAJYV5iwpENDsIGlQ8IE2ak5RocaSefInudUQRBT5JVB?=
 =?us-ascii?Q?qmjvO7pij5iSN9SnOirOr8aHHidFO3K3eZQN+d5p4RrHXSRgtHxZLljpHLwC?=
 =?us-ascii?Q?gEEnzaakzyQd0DBFrz8m51DSn6Acv3SLm8E9thprIRW15Sdt+9zPreRL+kW3?=
 =?us-ascii?Q?pPlswPd4tWpA02kY/jkWye5WmlqQIKPmff8WJTzSYiXN1ZGM/OC3cN55H4QF?=
 =?us-ascii?Q?Kp91/7/MENJkZgGa5DtK5ungKMijZux70nNJMt/V7l2ZSp0jmv4iOzhtl/hj?=
 =?us-ascii?Q?9Ld0XhBHjT3x1Un5EDckQODqxTgJ2lEL+2dZaUHzhBRlopqkqJsUkZerCzyH?=
 =?us-ascii?Q?5RZL0HLoQFBnNcTcMilznf3D91eZRnmjplQIJbNg49qMJe+klFzD4ZL//7Or?=
 =?us-ascii?Q?/QhbiSSQfp7aYGihIZycF5gko+2MdJYRsSss5RFjNF9hwRBlCcekLlUf+INu?=
 =?us-ascii?Q?eI8VtV6xtdY+1iirX2SLdzVlH3DktmXhQ1TOu83+GLreigoon2/oNhlhECJ3?=
 =?us-ascii?Q?m9tQoF0PJARmJETUYWpmUR7GNU1pWmXf9DQz7xaHVm5IfdZYhXRbn6Z1dleL?=
 =?us-ascii?Q?H9lTyHFgUC8pM0iom+Bt07C8ngjZKMK36s18NBvZQUPFUUi0P+WyqoQGumoY?=
 =?us-ascii?Q?hd2+44MjLl4Cj9eyHep13d+7EEbxkdcctrxzNzhhtYYGi7Z1JR8CJbO8hkWR?=
 =?us-ascii?Q?nwVEHCgdeUDKH38=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?00q+9997+Vi631Kzo8uhIkdt/HpNJqZ0DK/iRlGJ53DlBEHhM2dMuz/cOAJW?=
 =?us-ascii?Q?RCTBLoi8qUUUbL8/a62OsuKAr28hVF0qDucZ1k+SXzIYhC1CyKo6SyCi3FHq?=
 =?us-ascii?Q?BLAWEjXPqBACdsUdCjHgAcFSlbtLXVn9QMyU8xoerWqZBVPTZlWfL1trRvPJ?=
 =?us-ascii?Q?obJaCdwu3jG9VDEoWkXQ3uDhZfPi8knCCH5Xnd8mvgZPfOY8ECbsdXpC5cTq?=
 =?us-ascii?Q?k7gudj0piQTCKcbtYfEGCz/01zPBKHRqQmM2EfTr1ZHGCo0gjYrUWbzLDHyw?=
 =?us-ascii?Q?e+kfjnfOQ3DVHq1X9bhYlsXaqINUEfioYbkl6GNUpjsbDK3RnUi06o9M6GaG?=
 =?us-ascii?Q?sfdD4P8Pzdd/YNIe3aitU3I/NdqfRmvJQ/bSUxMLT8AMDZEAk+1e2sW49Fv0?=
 =?us-ascii?Q?6r1cqgCgDB3vXJP60MM1qtt1TdCaSOokROTe26k0IuZE+4imuZo3As2cOEy7?=
 =?us-ascii?Q?bJqMrbg7tr2Lys4HENulOtHAJxin6DJJpanm9MRqjBnFpvAeWAkzilmnjNOE?=
 =?us-ascii?Q?Nw4vsNktBCfyPIz1D2nD/Kt3K5uRcI6jS5RLlw0ZPBiNdhh21nbzsmwdsVGf?=
 =?us-ascii?Q?uIK8TbzksmiMdLvo9MVavRvZkYnH7RZfFIx/Aetks+Z+Rc86XAQG/FdbgAsV?=
 =?us-ascii?Q?xfHUEg610EBygJRQz07H1QrEOwq7UnXOptKyQqWpdAx/pFIShkL3fBNVg4aW?=
 =?us-ascii?Q?uacYmv/zlkFFMN50PxAq/00mZ7al87ebJ204lxsASOOd3adv+9MvymcYz5sT?=
 =?us-ascii?Q?BEcMZ+hjtKqAduFR4LE9eI75KC0fJB6JrSLhIIRIdMJLmOhQVAxduE8frZ4X?=
 =?us-ascii?Q?i6aWchwqv7LgY9an9R6RToitKL+BdGSZLNLES4XPK2tfk6oxBZ8zGnxsYlaX?=
 =?us-ascii?Q?sqILl6r75OInbuVRIWs9L/XD7jjWd/MLSHyXNwrpvNyjFZ2vAsJhsn7OSIw1?=
 =?us-ascii?Q?hSgCDV+eTbpyMkelv9dLJJ3Imj3dfJMoKywVXhd9idceSoFzp/f4ZoKgBbJm?=
 =?us-ascii?Q?1BiPrVs42Bb9d5JtufhFbrG5kC1pkGZXjjxu75Xb0lqF7t0u8Ug5w1t+jZQJ?=
 =?us-ascii?Q?A62fjSpRcQzV/21r7P0UxvNjzGCtx3ZYImO9jAnDjkLx/qLSsUA0XWSF1l83?=
 =?us-ascii?Q?w3W3+KH0wz2CO4ZJX/Qd6CXZDGoNaMMnXPSZrTTpMN6QdkqnqocNfnq/3gNO?=
 =?us-ascii?Q?1kXTnkahQnNgW2YsENdgmxmKqpJwXCzcH3CbdKmgRykhGFo06Ng80Gm2eIk0?=
 =?us-ascii?Q?Bl3tgkw4+sSNTF3+mEQZT0d9L4Zfts1AtUjUYmTy+FzqaYivtxNewxNkOHzg?=
 =?us-ascii?Q?vo+ClxA72vbXQmpsS4qzVU+A1wemj1byTylokVDtwcnBLQekCbDerYvW9lm9?=
 =?us-ascii?Q?AYbeZ9Vehwl27FQIRJWHEmO1FEqZUbeF8PyFUdN/ZJwiWIIOw74/Cy4gOaU/?=
 =?us-ascii?Q?GT1MKw3Gj4hRebOvJ0pLxYkL+M0sz7b9NOXy18bVyMLs1i1RQXaVdMtdeGtp?=
 =?us-ascii?Q?jceGrPxccsEm3FhT40OlW0hOOfWUxJtumCWUGqPPqu9xkkmDstE3Tkoh8bjd?=
 =?us-ascii?Q?5mZPkZYerIN/zabho7I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e49f26-e4e7-40af-7856-08dd87c81658
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 09:19:19.3964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+IeAAIzyIKoOomEEa/lc9c6baVYTUUR3fcMSkujkTpbyuvvAQgheVGyXOc5h4manJVJpUC1Hd8Ut+c97Ek4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

Hit send too quickly. please drop the vendor since it is not needed.

With that fixed. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Wednesday, April 30, 2025 17:17
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

"vendor" is not needed at this stage.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, April 30, 2025 16:26
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: set vram type for GC 9.5.0

Set vram type and vendor so we can take different actions per the type.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 464015fc2012..ac21197bf0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,6 +64,7 @@

 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
+#include "atom.h"

 /* add these here since we already include dce12 headers and these are for=
 DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                             =
                             0x055d
@@ -2075,6 +2076,11 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_=
device *adev)  {
        adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
        adev->gmc.vram_width =3D 128 * 64;
+
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))=
 {
+               adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
+               adev->gmc.vram_vendor =3D SAMSUNG;
+       }
 }

 static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
--
2.34.1

