Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCF1D116E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 10:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361B410E12F;
	Fri, 28 Nov 2025 10:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwljCnE+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F291110E12F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 10:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnT1SP7k1BShd3gxgFaRTM+JRB4+8KJ099xLvW35KkTsqGgYTgTLtxAQjLo8bKa4+07l1mxYtn//BsVmu0dkFmH7MWTr5a51ae0wnU2v2nHJdO+rHuiN5famtzCE/TuynQ0G7dvCnVk9M5nZRvo4J3YPxaGBdUMlhX4m23oW3PwFYLIFHFIb5YdEOzqscidHGSvLL6MDVFOc7exW4yLHRNKnj9Cil/8w/qBnxq8l7YLHoruPY3CPbp/AHF0D6BKhHxaeu3Solg6yJuI8FUyCIoUZdM2da69b5/zBRcDJTXV4EV7RpJJql0JYZ+Gsyx3qU9Q+I0uu4k87lUzyoT5+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnjrQfntmhafc1vxKJu7AdbAa9vBnvS2vLfflBM162g=;
 b=yoYHhWpsPcmJp8egPQY9tixd2/+JqYMDwzIP5jrnKAXHj4S+pdhYttRwzVwMuxe2wRkOV5hfmRqBY+Jg5BMaN17S4wczfgh8Rkh3y8EaigqE7QvshSwKCcZ8ohXC2PumOL452TQNmIyiKKeapYEU4ZCsJ8TLFhA64BLmkWxajqq0NNSnGQIeHyVjAdafj16OC1CuYLktO5u+uLsNKlc06dBzwDFxriY2Ehnw4uCJuu2VLpqTe0iRLoniXB00D2ssLIefgOO0eglno9wwLSDkXLIhCHWRy8ovF7+/lcIYW/OX+8dlc0xuapWmLjScroGqEinFYqZkD7v9UffTnJcfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnjrQfntmhafc1vxKJu7AdbAa9vBnvS2vLfflBM162g=;
 b=SwljCnE+xbhouYDwwzIA1r1cfZ9z1pp4X+q08Dt1zy+aAdzscMTh6pnvFEiQiHf1JNUGUkJL7FfDn+UAagyaXIPzQSuXUmtiquakmG0IiRzgiOzFmc4vEbaC9pw05lxouaVSvlu1YZQ17125cVjG6ttatlrfzs9RxF4GuVf4ZFg=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:54:23 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:54:23 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Make pre_asic_init optional
Thread-Topic: [PATCH v2] drm/amdgpu: Make pre_asic_init optional
Thread-Index: AQHcYDnvw5A1vLZUsU2xL0IGLUi4LbUH6jwA
Date: Fri, 28 Nov 2025 10:54:23 +0000
Message-ID: <DS7PR12MB60714F16342A43FF6573976C8EDCA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251128073733.3606297-1-lijo.lazar@amd.com>
In-Reply-To: <20251128073733.3606297-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-28T10:54:18.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN0PR12MB6125:EE_
x-ms-office365-filtering-correlation-id: 2fa6868f-fb94-497d-60ef-08de2e6c7dad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9AEKnp8oyZBillOOlJsj0N/dwLRkjZuD+CyR+T1ICYnFTJgzo6KMYRK6AxCI?=
 =?us-ascii?Q?sFC8QmMKhmkSnsqMNRU2E3Zwq23uXoGu44jQnXfhMbmcIiXBEsoQeX2/tsoh?=
 =?us-ascii?Q?8tPbuhl81Oo4K4itS2GVsWlwb/e+QBW9WwikweUA0wdxxXfS94JBHQffCyP3?=
 =?us-ascii?Q?Y76rwwT4FV8e0G9uuPzU2j5s1UTtJTMDkSJ55Dy+JLDfwYCcMxHEFzC6u83M?=
 =?us-ascii?Q?j7GYgm3fsQuqJPtl2+oPOOW7IHNiu8cftFoMR1pUoiDqPH01NbXqSwBrkqzC?=
 =?us-ascii?Q?AHMh848H1zHBBlBIPOHPxXFIJ9bXXryB23gSPcHRu5Dra/2gZMhTzQ06MgcS?=
 =?us-ascii?Q?M8thIbI6GrGOeHCyLxmrq3qR66yEnFT1YMRgnHRrecggrKK8/oljXsz6kND2?=
 =?us-ascii?Q?liEMuIvuzmxQfrXwDXMt9fY9QId1WyAgLUCPByYrAYwWSD88Qvp7VAVZknC3?=
 =?us-ascii?Q?kEAEdxT3O5lAMBZ5JKZV62UtxEjb2xvNIfUPrGmKNwMDpIBsLyrIhHMnDZvK?=
 =?us-ascii?Q?vKBloX8TTy8QUU/Uq4/svL6gKoHI/4OgB6agOYoih/7XuY3dGq+xIsHqbxNf?=
 =?us-ascii?Q?7W6WnHu35TkhEVcQ/bG8Una/siiROFTSYmDtN3EzZkobhGE6Ztc+zIO//bT3?=
 =?us-ascii?Q?9ma2Q7iyZWDuCgaVEKqG5xo2d1TUNvXEfzwkUwZYJGxiMJWlCAgMLLejyB/b?=
 =?us-ascii?Q?RV4ZPNLqB1+ck6NEcQdPtziJWOgi+OHyc32h066ENzpDiVICAZz+yTsvBjtd?=
 =?us-ascii?Q?vLyAD3S4sBGGwJ0gfPhztxfoM6FATqFE3lYBDOOe3dz21EGXO98nI10OxX8o?=
 =?us-ascii?Q?6ZaLRyNcth6t536m/L5kNtJrTrxFOANsYf4xdp9UVYFO5mEKjPgXAIRCGQo3?=
 =?us-ascii?Q?m9/K60TdM3XDv1BV0o+cwqh89S7DAHkW/6ZjQVrvxHkN7Qvfqgm+6PU0QqAf?=
 =?us-ascii?Q?k5e0Mq389+1DxeSxeip9/255DbEAX5lxuzaMWwv0ZpKhbFeJncNmGaHn2/yC?=
 =?us-ascii?Q?bmV1AG8YxZnXdU5HsANHGkXG5CyWG70vpEnKer9Y9JgWY47HCSwPSsn8ZI8G?=
 =?us-ascii?Q?SFoI32zO83CVrZDY8Jq1Mf141TClU+OP7+w4IfGxw6SVrhuaTR/Wib7tBrSd?=
 =?us-ascii?Q?s9qdwNM9x9gnFF1XseBo47UlnRfAxx8FT1KewulgXcZ6fvfZ2stynUcVj0Bb?=
 =?us-ascii?Q?7utzdh5GxYdS5u5O5dK11aDv/oufRWrbMQJRagoKtHNl8oT0Rh2lnXUJP358?=
 =?us-ascii?Q?UEYSwFj+uYr9YLWC6Z97wVJ9BW09Qz31XRCDcHwhGFUlcTD7Hr7N8VCc7BoW?=
 =?us-ascii?Q?L6+qzKqpRGtv7DdhU6G2NMYTh5KCJ7xmYao9BWnOFjiYSqmy0U/hu9Lsoe06?=
 =?us-ascii?Q?rqiyqvmD6G5Dh8Byn9P4nxKZc7aKhkNnUHgkuPQ0wGRl0LnmWmcWujJhG1Pw?=
 =?us-ascii?Q?Cse4QsI8ZAFF45TqUduS+9BjZOh2v6syVr/0e0Q6MsUMSrUivZNiO3EBt2kr?=
 =?us-ascii?Q?1fzGKyLosyCHvV7DAjgSjJnBsJ10TqwNpIdN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NPLwWuxGAut/Fs7Q1BjY6Tb+oCj8fWhoQ118fn3eIW4I6pTaXqUdR0CgUyv?=
 =?us-ascii?Q?2+aslwG278KzXUMvTHdHdB979crouyBCKH/KzcJof3Us9R145dmEcDqad9t0?=
 =?us-ascii?Q?cLRQvdllh2AQpdfTws9y9/dfxto5aEUDQV/yjdl7kQKHN2p/RvkzWTqdvoy9?=
 =?us-ascii?Q?iaX0bRUufFL+Sqrtcd86M4ssJTZUnige/Wesw+590LqJ80SpG3J8pmONPnAu?=
 =?us-ascii?Q?038UjaiEE2joTfci+IZbQd2KvbjVPOnJ9cHvBHv+5tj7ENpqc0c6xKiLjxKC?=
 =?us-ascii?Q?DsquAmmqYxidSgSF2u7NrtbpncpGe/bFjVZTKMZuqKHTl3r2jE+qHJkoDv7G?=
 =?us-ascii?Q?cJSkOgV3u+8ji+VzQceU5x8mbV0WQ8GCs62epWTEJSh2i6GEKm6z40tfB02C?=
 =?us-ascii?Q?h+EvItyh4q456svj76AMIkh/Qu6AMBhNzA6U+B24cvT4UhCZR1+GBK/gEapH?=
 =?us-ascii?Q?g7OSVI3shfpOm+RT/7bfDYY6X/wHxhjHoOlNp7iDoSpWq9SwOnIwuS7ikGI2?=
 =?us-ascii?Q?Ebllzdh0ZfUThs0eHF7y1uZyiBoDzyyW439zCWiWKcM0m51iXCT8af00KseE?=
 =?us-ascii?Q?yCyhKU8kjZTMoWRlVlYl8+PD1+jSfQGf6y/CoFf5p3ViIG91xwq50I2AFhwd?=
 =?us-ascii?Q?gbOCvqhvlbSUNiwhzCKkGvxJzNoHn8G3JIv5d+9tbAnR4jUrZSH5rORQ8Ft1?=
 =?us-ascii?Q?+Zb30qIMVbvoTL5aj3Gx4d6+H9Q48DHXGy7g8BvqNPkVut9g6ozI4MR/xsmg?=
 =?us-ascii?Q?PXT4LhzDsXzWqabjwqhTLoYz/qbZfgWYJ2Kg0VABEXFpkemRni+jv7TtWgmH?=
 =?us-ascii?Q?3XdvBeHHUgyV28oPwnOCSEyordPv5e3rmeBbuSkHpq0xjQhL62G7xuI9lMqg?=
 =?us-ascii?Q?JTt3xkQjGcsNH//Q9JHCFQS9eiByDCO03lKHco1u7uQr2OM/Nzlix1LLJTgJ?=
 =?us-ascii?Q?bnHHCw5VgauN3CbixzpL0aWh56w9DJTR8NwBE8YwxzLtkIcpNLWFNKYBa9CL?=
 =?us-ascii?Q?h2QIneSXsvlYwNsWGYEQHzvifgemcbT0wi33kBW9qz2kCrNaYCjPEDEielF5?=
 =?us-ascii?Q?kXVwrufM63Rv8NhZfA2ln6AO6WlHHsD30A9OChuVbQ0ZMC489h/UD2XxUs+D?=
 =?us-ascii?Q?EfZn+9y3Xse7ibjlrPvGEHDC7ps5bv70cmmGnmBMtfemnM5N4Jia0j4u1FWL?=
 =?us-ascii?Q?5husIEsoeg/AlsNEYqNna+uwZdqptjZAX8R5wffXtm4lkxquhQtYTUI+M/IX?=
 =?us-ascii?Q?ylca4dURVgzhrAWrOjN+kuWTGh/oI1R/za2uJ5hOwFt1XqLdcrsLm4Jhg0N3?=
 =?us-ascii?Q?LAEYj0tFgytPH48FSA/bbl82PPJOyy5A0CFRMqd5colW67yYj4h/qyMIMzPV?=
 =?us-ascii?Q?1VdB5O+KF+7wPTT9/nPLvQYWdOTwBfz0AfgT+1AHec3ai7r59vF9lj01egXF?=
 =?us-ascii?Q?UY726oHJtD7ywV6tazKxQqemic0OcpmHDokFtM3bwk6qRkIvPeM+qs0Yupgj?=
 =?us-ascii?Q?WIO7ghvMeB9/p76M/OwelV+O3r2qX9/XJ7NNGVwFxYwJxUTnnlmw8rNOAqsp?=
 =?us-ascii?Q?8k/t3NyTyHa/j7aE1/8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa6868f-fb94-497d-60ef-08de2e6c7dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 10:54:23.2847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdNfx+iMbN9AefbyW++5U+930slkCA5X6jvQIT+XPB1YbcoHhUn0k84kpCmJ8kU7nwuqzhhmbNWgVPcN8x9Cuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, November 28, 2025 1:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amdgpu: Make pre_asic_init optional

pre_asic_init is not required for all SOCs. Make it optional and remove emp=
ty implementations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: pre_asic_init returns void, no need to use ternary operator

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/cik.c    | 5 -----
 drivers/gpu/drm/amd/amdgpu/nv.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/si.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc15.c  | 1 -  drivers/gpu/drm/amd/amdgpu/soc2=
1.c  | 5 -----  drivers/gpu/drm/amd/amdgpu/soc24.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/vi.c     | 5 -----
 8 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 790e84fec949..fa71df36f4b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1549,7 +1549,11 @@ int emu_soc_asic_init(struct amdgpu_device *adev);  =
#define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pc=
ie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) \
     ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco=
((adev)) : 0) -#define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->=
pre_asic_init((adev))
+#define amdgpu_asic_pre_asic_init(adev)                                   =
   \
+       {                                                                  =
  \
+               if ((adev)->asic_funcs && (adev)->asic_funcs->pre_asic_init=
) \
+                       (adev)->asic_funcs->pre_asic_init((adev));         =
  \
+       }
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
        ((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs-=
>update_umd_stable_pstate((adev), (enter)) : 0)  #define amdgpu_asic_query_=
video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e)=
, (c)) diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/=
amdgpu/cik.c
index 9cd63b4177bf..fc0d2524b16f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1957,10 +1957,6 @@ static uint64_t cik_get_pcie_replay_count(struct amd=
gpu_device *adev)
        return (nak_r + nak_g);
 }

-static void cik_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static const struct amdgpu_asic_funcs cik_asic_funcs =3D  {
        .read_disabled_bios =3D &cik_read_disabled_bios, @@ -1981,7 +1977,6=
 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =3D
        .need_reset_on_init =3D &cik_need_reset_on_init,
        .get_pcie_replay_count =3D &cik_get_pcie_replay_count,
        .supports_baco =3D &cik_asic_supports_baco,
-       .pre_asic_init =3D &cik_pre_asic_init,
        .query_video_codecs =3D &cik_query_video_codecs,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 50e77d9b30af..f17c3839aea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -593,10 +593,6 @@ static void nv_init_doorbell_index(struct amdgpu_devic=
e *adev)
        adev->doorbell_index.sdma_doorbell_range =3D 20;  }

-static void nv_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
                                       bool enter)
 {
@@ -630,7 +626,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =3D=
 {
        .need_reset_on_init =3D &nv_need_reset_on_init,
        .get_pcie_replay_count =3D &amdgpu_nbio_get_pcie_replay_count,
        .supports_baco =3D &amdgpu_dpm_is_baco_supported,
-       .pre_asic_init =3D &nv_pre_asic_init,
        .update_umd_stable_pstate =3D &nv_update_umd_stable_pstate,
        .query_video_codecs =3D &nv_query_video_codecs,  }; diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c index f7288=
372ee61..70e9ba9d927c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2003,10 +2003,6 @@ static int si_set_vce_clocks(struct amdgpu_device *a=
dev, u32 evclk, u32 ecclk)
        return 0;
 }

-static void si_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static const struct amdgpu_asic_funcs si_asic_funcs =3D  {
        .read_disabled_bios =3D &si_read_disabled_bios, @@ -2028,7 +2024,6 =
@@ static const struct amdgpu_asic_funcs si_asic_funcs =3D
        .need_reset_on_init =3D &si_need_reset_on_init,
        .get_pcie_replay_count =3D &si_get_pcie_replay_count,
        .supports_baco =3D &si_asic_supports_baco,
-       .pre_asic_init =3D &si_pre_asic_init,
        .query_video_codecs =3D &si_query_video_codecs,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 42f5d9c0e3af..54b14751fd7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -951,7 +951,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asi=
c_funcs =3D
        .need_reset_on_init =3D &soc15_need_reset_on_init,
        .get_pcie_replay_count =3D &amdgpu_nbio_get_pcie_replay_count,
        .supports_baco =3D &soc15_supports_baco,
-       .pre_asic_init =3D &soc15_pre_asic_init,
        .query_video_codecs =3D &soc15_query_video_codecs,
        .encode_ext_smn_addressing =3D &aqua_vanjaram_encode_ext_smn_addres=
sing,
        .get_reg_state =3D &aqua_vanjaram_get_reg_state, diff --git a/drive=
rs/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ad36c96478a8..55c3781fc730 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -513,10 +513,6 @@ static void soc21_init_doorbell_index(struct amdgpu_de=
vice *adev)
        adev->doorbell_index.sdma_doorbell_range =3D 20;  }

-static void soc21_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
                                          bool enter)
 {
@@ -546,7 +542,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
=3D {
        .need_reset_on_init =3D &soc21_need_reset_on_init,
        .get_pcie_replay_count =3D &amdgpu_nbio_get_pcie_replay_count,
        .supports_baco =3D &amdgpu_dpm_is_baco_supported,
-       .pre_asic_init =3D &soc21_pre_asic_init,
        .query_video_codecs =3D &soc21_query_video_codecs,
        .update_umd_stable_pstate =3D &soc21_update_umd_stable_pstate,  }; =
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 972b449ab89f..ecb6c3fcfbd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -327,10 +327,6 @@ static void soc24_init_doorbell_index(struct amdgpu_de=
vice *adev)
        adev->doorbell_index.sdma_doorbell_range =3D 20;  }

-static void soc24_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
                                          bool enter)
 {
@@ -357,7 +353,6 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs =
=3D {
        .need_reset_on_init =3D &soc24_need_reset_on_init,
        .get_pcie_replay_count =3D &soc24_get_pcie_replay_count,
        .supports_baco =3D &amdgpu_dpm_is_baco_supported,
-       .pre_asic_init =3D &soc24_pre_asic_init,
        .query_video_codecs =3D &soc24_query_video_codecs,
        .update_umd_stable_pstate =3D &soc24_update_umd_stable_pstate,  }; =
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c index a611a7345125..6a574b6c8e63 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1424,10 +1424,6 @@ static bool vi_need_reset_on_init(struct amdgpu_devi=
ce *adev)
        return false;
 }

-static void vi_pre_asic_init(struct amdgpu_device *adev) -{ -}
-
 static const struct amdgpu_asic_funcs vi_asic_funcs =3D  {
        .read_disabled_bios =3D &vi_read_disabled_bios, @@ -1447,7 +1443,6 =
@@ static const struct amdgpu_asic_funcs vi_asic_funcs =3D
        .need_reset_on_init =3D &vi_need_reset_on_init,
        .get_pcie_replay_count =3D &vi_get_pcie_replay_count,
        .supports_baco =3D &vi_asic_supports_baco,
-       .pre_asic_init =3D &vi_pre_asic_init,
        .query_video_codecs =3D &vi_query_video_codecs,  };

--
2.49.0

