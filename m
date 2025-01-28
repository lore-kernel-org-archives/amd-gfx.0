Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AA2C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171910E60E;
	Tue, 28 Jan 2025 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9v+n1g4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD4F10E60E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcQMql+08xtQfZs7QSfwGpMiUFlAbc/YK4ibbDk/RSPsDR868h89PCUSHNpthHx+DkGaCOII7/1ejcOA7EwcWD2nqNjLZY95zQK4zyp0UrTQ69FJD8AHFBI/ct/jDH3WoKbOKrMtF40Tir4uuNUDj1YoLK888C7lMqYM97f/WNx3+SpnbEJeeQ4DZgMyGwX12wKQLcSzDwrSV7/gW9PYl01fVVQ5ksL0qGmRIAsVAtDaKc6yrIBp+F1S/P8Hp1knEQ0OloCDeH0gN/lKHqVR/okxtDYgreVbvhtCXOEtFgk217VDP9T6wZIuGVesvsq/QnOWfhimWJBElYTmbOhkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk9JNk62Pf2B6glt8FIcyiM3O4wUz2jEbPm1lOAx5AU=;
 b=dMCIFtQdL+Poq8jI29xAn/n5CVeqoniRHACo37jkxtlFK9ZtUPTO2Yh5rVTQTjJpaYqXCsHh5pEw9pXrly7YdChZM75b2f8mPHzrOq06oVj/ISCZtT/n0oBNQnm7dsqSW7RhHn9+CgOhqrpcO9E9kQgOe+q94tSG3sU5rauR/BC33PJS8i2lX4I+ts1ypXLINDq1rzgQvRajMVaXK0HBMCQ+RQo87CTgYNIitDSiA+zr20zV2kWfHi8hSLNNnveEMm+koHxtHFdQKJ7waeZEUGHjPpswS3vKUX60bP7SlPV5dkPGGG8qGc7DIuql0hbyQr+F+mf0KKBhKyMp2OM9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk9JNk62Pf2B6glt8FIcyiM3O4wUz2jEbPm1lOAx5AU=;
 b=L9v+n1g4ZkXMj7qYRwTAuL5aItoBEdoxRftOgSnMLF2+5ieT0KXd5BAYHv+z5bLQ7S6UdRAuorICJcghagqB8QkfR5fcWKWh1wCqM5mrjkWcRv0eTctyi8iimV92Fz2QUjh9siYiLYMFr3SU+dtgp5vXsWwWfU16xPkxx/VE4Oc=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:34:42 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 09:34:41 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Clean up GFX v9.4.3 IP version checks
Thread-Topic: [PATCH 1/2] drm/amdgpu: Clean up GFX v9.4.3 IP version checks
Thread-Index: AQHbcVmWwXJmS+VE7Euds82NoWiyq7Mr7Ozg
Date: Tue, 28 Jan 2025 09:34:41 +0000
Message-ID: <DS7PR12MB6071D62B14409B369AC52E438EEF2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250128075207.1695418-1-lijo.lazar@amd.com>
In-Reply-To: <20250128075207.1695418-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=84fbb084-b612-4f66-b5b9-2719e4471c4c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-28T09:34:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB6947:EE_
x-ms-office365-filtering-correlation-id: 6f4fb491-f118-432f-d77f-08dd3f7efdc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?T4BzGoRdpndVSfDtC8hrdHTn522oNbaVcQ/RjrLoM96zyl4IBtwZpV2aZVWD?=
 =?us-ascii?Q?xi8J0NhjfgEFBDGejQ9LXjskeoxl+34f13bQjO316I9S9tLaVXqiZo9d1oiJ?=
 =?us-ascii?Q?B+UAYN1KcTEpz/nk/0GFtjPioQal37HXUt4uf748kIZJVAl8HA1FIkSYA9qh?=
 =?us-ascii?Q?JSK7MsOqslBLmmcvsOxrZdSqzf9mq6MHo6ooAq9MhlKHNYUuY6YN5LLRq51z?=
 =?us-ascii?Q?VP3P1zO5ExLktsYmmhoZYKE4+P+xq9uVBSmrs+O9HicUTB/ivnnhfKrBLDoF?=
 =?us-ascii?Q?eNWbqY4E3TvU1djnJ9NK6iusHjfY/DQylD0pfhn0lq8u8cqfh+Z6nd7k5sVc?=
 =?us-ascii?Q?+s8itpR6p3st0gJRWfQoJHjwLnt2sPyH1VsnCzIoHLa1DurQOFHIwDqnFyTc?=
 =?us-ascii?Q?NhGjLbh5mn01HqVd0nocFCZqQ2PVq/UizytfylekZ03kCg8Ltu5AZabJWX31?=
 =?us-ascii?Q?FqY+L+AYyfjTebbtffE4Zmu11B5FrrPiRfDa9AjdaVAwxhOE11ZT0eWPaY7K?=
 =?us-ascii?Q?z/RZ/wiNEri0mfm3vzCBAjoNvRz7PppESHdXmxeelvwrXwRNydIYRdzOH7Nt?=
 =?us-ascii?Q?V2AhzwnYZI+/GGB8FMMFCIMe5B0m0RSAMZWNpIGA001+z/EErH2RvljU50xs?=
 =?us-ascii?Q?Af8iDiuAT01UcLXQoJplFMMS5IJitIW/qVvOh3YwfIUdLqy5PLx2WMSL0bb6?=
 =?us-ascii?Q?mpwJ2BCJ47mt/4iREHA+x2oJ0eGT8JG4U1pUXUxfwapPCuhl5fQmm8i65gzh?=
 =?us-ascii?Q?BwmqyeZaCnbt5kPyhqFRA7mpJV0EFtXBAvgmFgZdnQiNAu1Kbl8tsNZAeBcy?=
 =?us-ascii?Q?oTzpnXlCY0zkoMDgEG+274+J06LmGpPBDRjphXMCws0G2z5ZQltOL+rYu1rZ?=
 =?us-ascii?Q?8fGQm5FXnXLaUxrWDEkqQQqnmMiDPuei/TmoFfr4hArZqVK1qoDIRxFg9A7k?=
 =?us-ascii?Q?+nsoCii8wApuzWWTbRVTfWj37MwWbh8PLsXlg1q8gJ24oSdCsdseMBvmAALV?=
 =?us-ascii?Q?bYv+smRMupn9A6MgYMfALFkadvHwshYMlzm6pYpSaFQSWFjVUg2uZ8Em23gw?=
 =?us-ascii?Q?5XyTmDEAzRZuWZFfXWBw+ZQy8gueVDmla2ho6glWHbkHWDq6lvW9pkfSQwAW?=
 =?us-ascii?Q?O/ICZaWMr3eZ2vC3s/GzUQn99PbjP9iSVDWzkPbVifvilEkijnzDMZYTFQYy?=
 =?us-ascii?Q?pmDdZMGiIlxXc71nZ2Whl+XdLod5TRKOGvg5E08f6Q4GWROvVTCDi6nEPGxG?=
 =?us-ascii?Q?7tSDMGmgRb9Li+3/6nMN4ABeYrMMuKLvUCMVprDMl0cYbqVScAnoMeXXmWXc?=
 =?us-ascii?Q?oHsX7GL+h3ccbcPM1TfbYBYEdqVh9RqA1sphonqQ0QdMlbu8HXkg6c7cvJC2?=
 =?us-ascii?Q?akc1KwVIg1qDRbrE5zF/PHkhaXQf9hBlDqbpqzGCM4Lrq+L4Q5zRTzEjr1rZ?=
 =?us-ascii?Q?OgyHliYfsZZ7JDNoYLrnyhwbp4T9femp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dPIdu7BE9SAeMEJGmlo2roOt7XOxKSzbwtIR8hKe6JsuYr9+YhxEJTSjmy3/?=
 =?us-ascii?Q?P91XgvWgbjAHE/U1PjNwJtIchxg4GcliJ6SAo0CmbADLZUoNrb/1pTamWzg+?=
 =?us-ascii?Q?mDTupwyIVAOBS5j2u3gN79uSnsVvvgZsunuUe6o8sePYClktWIX95SN9k1zl?=
 =?us-ascii?Q?93cI7g6W3DU7eK84E2PVLXaHx64Vuruq+Qcox3ezxqZs+ALuUSg6RnS3rRcF?=
 =?us-ascii?Q?j6TyF/cNKeXuR2TQF/enx8R/HDPwj1HEYNpujjWF34C9Rpyis9kACJHuWVqM?=
 =?us-ascii?Q?nslVQPXcb6UfCUPdExMElvaYnG8GTmsMjVDLg1RidCW3wEAfsdnMVhvzkXlK?=
 =?us-ascii?Q?D9b5urvF05XTfHvBIc5ojLV1bB8yUYEeVTpXX5E+JRqsBZwpzIktplU7n/qZ?=
 =?us-ascii?Q?sKcKrCGY61uAQ1m8S9rY/S0aLzpZD4TBnfoI1XOjTJcTXNLzIpLb58UOIlhG?=
 =?us-ascii?Q?j8YYSzF9U1r5MpitnkeVDIGby6aiQrug/20+JMgI2tzsNJ/b4vb1TMdfDyuX?=
 =?us-ascii?Q?22obpOM1JtEA9m8r5rG/nP4XXwsxqn/u2FJBzmGX/myWGtFkojCCob3jXT6N?=
 =?us-ascii?Q?5PwPNlLykX7RfpgXqm09sQR89+ENgHFK0ig4BYWlaelBm9H1VAdss+8cHbgg?=
 =?us-ascii?Q?vonx3Gyhx/ztk9alCZmK+KMDwblwx2GrTbP3HU6saom+6TcNu70VLFzk+UyL?=
 =?us-ascii?Q?z5Z0VKPG352igE8IwK4Th1PWbOIb/5X7RJJ19tRhxoPZ73YCTtTYYTnrJlZQ?=
 =?us-ascii?Q?tHNtdvygoCMQNL7DynD+udW08GluXds0wkRM0mZCJjqgZ40Ak9HHOHxnyhb2?=
 =?us-ascii?Q?DZNgQU9ENAHRxzvKfEqYYDmUuuquBbKfNGyoBsdseQskpaCek9EWWfKSMClL?=
 =?us-ascii?Q?A2Bec6U2s+5yYSpLS/1SvmdDfG5bM6JeDovHOC1KOz+jXYVSyQUCh6W0hRXT?=
 =?us-ascii?Q?ywvp23uW92zcGPsv8hVR96wb+ELqu1iY2mYUABvRnf8SkgPAc31YKsZE8+FJ?=
 =?us-ascii?Q?gcP6HYCyMyvOOuv1NR+86JAWh4E7kQnol81X+gG/XnSTjC1l1gfndnSG+udb?=
 =?us-ascii?Q?tf07QWXPio7apYxJ63IqfGo0vLErfM6cusugHElUaIbZIkjARzQJNW/I5YJ1?=
 =?us-ascii?Q?H2TLfj45R44d4A0pQn2exG8lAu8JDX8fyIh6hUhKHHgXN2Io59XlXyWDWRGN?=
 =?us-ascii?Q?jgtddhcsNQKi3sgB6SbX+NQldujSQBGBvvl5BwhiVNPB6L1tR1CyxE3O9sJv?=
 =?us-ascii?Q?wVtW5aj4ebIh9czp6dE0XVKoyRe0l059nbEXXNGy7M75o60wxqUbjBG+2rna?=
 =?us-ascii?Q?4DazIH6M6YyuKLz4MdUsYb1LmcSBf90AIJ6o/GOAUdxSKjfi6fhNXcg3BaSx?=
 =?us-ascii?Q?Alm7UJDFNEgPzc5rIWS4vFSFwGfFWpatV4huPuaO3HJuo3e61GjlnNwUeYbl?=
 =?us-ascii?Q?iYp5LqCbkcppGwpmL6PZdLlJa45BDeV4knE+C6X2G98u7xUKWs55Anak5nE3?=
 =?us-ascii?Q?Yj2bu2RTRyslyBNWyNjXvWcy3vgq7j4wiRGf4BrUC+ygoKMlZxy1xxrfNgC4?=
 =?us-ascii?Q?N8cLCnsd9gECFCBxMB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4fb491-f118-432f-d77f-08dd3f7efdc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 09:34:41.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNn1yHGQyoZWMWTdPXhWzNXZcHkGDmcWGgJLGWdfszZu8lG0zWHyj3CLDDgNwfkyAbZ1bG6heDgU1WtjFn5kzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 28, 2025 1:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Clean up GFX v9.4.3 IP version checks

Remove unnecessary IP version checks for GFX 9.4.3 and similar variants.
Wrap checks inside meaningful function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 68 ++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 22 ++++----
 2 files changed, 29 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 2ba185875baa..f4635fc8a7ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -942,21 +942,12 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_de=
vice *adev)
        adev->gfx.funcs =3D &gfx_v9_4_3_gfx_funcs;
        adev->gfx.ras =3D &gfx_v9_4_3_ras;

-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 4, 4):
-       case IP_VERSION(9, 5, 0):
-               adev->gfx.config.max_hw_contexts =3D 8;
-               adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
-               adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100;
-               adev->gfx.config.sc_hiz_tile_fifo_size =3D 0x30;
-               adev->gfx.config.sc_earlyz_tile_fifo_size =3D 0x4C0;
-               gb_addr_config =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGB_=
ADDR_CONFIG);
-               break;
-       default:
-               BUG();
-               break;
-       }
+       adev->gfx.config.max_hw_contexts =3D 8;
+       adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
+       adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100;
+       adev->gfx.config.sc_hiz_tile_fifo_size =3D 0x30;
+       adev->gfx.config.sc_earlyz_tile_fifo_size =3D 0x4C0;
+       gb_addr_config =3D RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CON=
FIG);

        adev->gfx.config.gb_addr_config =3D gb_addr_config;

@@ -2795,16 +2786,10 @@ static int gfx_v9_4_3_set_clockgating_state(struct =
amdgpu_ip_block *ip_block,
                return 0;

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 4, 4):
-               for (i =3D 0; i < num_xcc; i++)
-                       gfx_v9_4_3_xcc_update_gfx_clock_gating(
-                               adev, state =3D=3D AMD_CG_STATE_GATE, i);
-               break;
-       default:
-               break;
-       }
+       for (i =3D 0; i < num_xcc; i++)
+               gfx_v9_4_3_xcc_update_gfx_clock_gating(
+                       adev, state =3D=3D AMD_CG_STATE_GATE, i);
+
        return 0;
 }

@@ -4867,34 +4852,13 @@ static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_=
device *adev)

 static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)  {
-       /* init asci gds info */
-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 4, 4):
-       case IP_VERSION(9, 5, 0):
-               /* 9.4.3 removed all the GDS internal memory,
-                * only support GWS opcode in kernel, like barrier
-                * semaphore.etc */
-               adev->gds.gds_size =3D 0;
-               break;
-       default:
-               adev->gds.gds_size =3D 0x10000;
-               break;
-       }
-
-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 4, 4):
-       case IP_VERSION(9, 5, 0):
-               /* deprecated for 9.4.3, no usage at all */
-               adev->gds.gds_compute_max_wave_id =3D 0;
-               break;
-       default:
-               /* this really depends on the chip */
-               adev->gds.gds_compute_max_wave_id =3D 0x7ff;
-               break;
-       }
+       /* 9.4.3 variants removed all the GDS internal memory,
+        * only support GWS opcode in kernel, like barrier
+        * semaphore.etc */

+       /* init asic gds info */
+       adev->gds.gds_size =3D 0;
+       adev->gds.gds_compute_max_wave_id =3D 0;
        adev->gds.gws_size =3D 64;
        adev->gds.oa_size =3D 16;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 5470cef7e9bd..cb25f7f0dfc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -313,6 +313,16 @@ gfxhub_v1_2_xcc_disable_identity_aperture(struct amdgp=
u_device *adev,
        }
 }

+static inline bool
+gfxhub_v1_2_per_process_xnack_support(struct amdgpu_device *adev) {
+       /*
+        * TODO: Check if this function is really needed, so far only 9.4.3
+        * variants use GFXHUB 1.2
+        */
+       return !!adev->aid_mask;
+}
+
 static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
                                              uint32_t xcc_mask)
 {
@@ -355,7 +365,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct am=
dgpu_device *adev,
                                            PAGE_TABLE_BLOCK_SIZE,
                                            block_size);
                        /* Send no-retry XNACK on fault to suppress VM faul=
t storm.
-                        * On 9.4.2 and 9.4.3, XNACK can be enabled in
+                        * On 9.4.3 variants, XNACK can be enabled in
                         * the SQ per-process.
                         * Retry faults need to be enabled for that to work=
.
                         */
@@ -363,14 +373,8 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct a=
mdgpu_device *adev,
                                tmp, VM_CONTEXT1_CNTL,
                                RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
                                !adev->gmc.noretry ||
-                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
-                                               IP_VERSION(9, 4, 2) ||
-                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
-                                               IP_VERSION(9, 4, 3) ||
-                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
-                                               IP_VERSION(9, 4, 4) ||
-                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
-                                               IP_VERSION(9, 5, 0));
+                                       gfxhub_v1_2_per_process_xnack_suppo=
rt(
+                                               adev));
                        WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONT=
EXT1_CNTL,
                                            i * hub->ctx_distance, tmp);
                        WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
--
2.25.1

