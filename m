Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FCDC5320E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 02:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D16210E2D9;
	Fri, 23 Aug 2024 02:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xhWTAKB8";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025C510E2D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 02:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdWXbcoCZ2JdwIkUoInA1r2vCCPkdVI6IB7BeXxRcLWpy+/kH16NkQ54Gi/TyYbyGQ4fZDD2vZ5vWsnNh+iSK4O1Dfe0eKj9Kx9/AanLULZjlADj71UZBfDbMt/lkO0Zn0MZjEpM/bsfCCx7hP94D+mQvEpBrsH+iJCflfxNMj/sDkX7MdB8FyfZeStNAVbXXp6alYtBgkO9p7AxYFeGT4/ErRmJKdjBmYIbjHtph2juaU9K/oEFwz4cF7aNKAxYnpru6iS9A1+inX1JtHJMFiIDb7Mk3Hl9+x6o067HrJ9UKwe0iMEOf+wZ6JAoYp+6KMEaJxNta845wczotonvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfBab42a1UdB+jrnicTm+U+tTLctdcYfFbVOe2VAFp8=;
 b=JG4UBxAhNAsR2OE8O0ye9hzlSgxn3HVgnJHqcj5Qa2OMfBhrXHJKajtku21X6LJ7CL0ZtT06+Mqb+SAnY4UmrKdzHD2r8C2kAj5cjjaikDnZxfWqcE/6vajpzaFPRYnkalhnPhGcR4QzCf+HMK3Yx8iMHba/T9YuDNtDtEBLFaaMC9wfzBEz+vFVRcgtV17rrIF+0TrKNOO7r11ls84C9jk4sFyfldklJw4yxLI3y3EO2teBlNWaSQKJiR+S9ylYQjRmZjcA3kUBSOn85e93t0KdzEwOgmvEUX4K2uozn7GSlBXNDGROFSuiRSD6KOwDoMWoHZgtgpTK1Ml8aXt94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfBab42a1UdB+jrnicTm+U+tTLctdcYfFbVOe2VAFp8=;
 b=xhWTAKB84Cgs8KK4QwBzldJGUCnaamzYhTWxGX7loGhjzrkBdficwX64FEyWzFpXnb57LIcyNqFpqVbDwBwSGjY6wSwvfVAErM7ABfep67Q5j7L2OOMh5ReGhtiAYQSEdGb0q8njlO+y2JrXyAqq39MeGWWzW2hsqLDPcspW+Es=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 02:31:45 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:31:45 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/swsmu: fix ordering for setting
 workload_mask
Thread-Topic: [PATCH 2/2] drm/amdgpu/swsmu: fix ordering for setting
 workload_mask
Thread-Index: AQHa9QIAhg18TOdmD0aeTb++hX9BPbI0Huew
Date: Fri, 23 Aug 2024 02:31:45 +0000
Message-ID: <DM4PR12MB516518A316E2A7CB63262D2C8E882@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240823021220.9928-1-alexander.deucher@amd.com>
 <20240823021220.9928-2-alexander.deucher@amd.com>
In-Reply-To: <20240823021220.9928-2-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb3d7717-2bc8-4b3a-9ba7-45a7f915ba03;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-23T02:30:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: bf1d7761-b9e4-4052-d850-08dcc31bbb94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WpbFr+DJagr+YrIT0pUJvhi2D2w7eLjcBY93ysmhORYy3iy+AusiaRZWwJeT?=
 =?us-ascii?Q?0qM+bJEHwSKcFna5SmBjs5/MahHXrQZN0wAS3jAFjib47lisX7qqvoKADbRi?=
 =?us-ascii?Q?V+QUxnRWKXtU4hfdCWyPbjm81SwKE1/BQ8eRV4JdLXa7xJIgUqEAsGVEgjwU?=
 =?us-ascii?Q?AysVQTPt9Ozws3M4ij7kYDnYMW0UuiMZ9R4dO/yHX8tGwoa3NmD07U71EK7w?=
 =?us-ascii?Q?7cCtLPQwtTuZoRmLGjxmbhv68EFZaq6LPiXYQg8zgr1sfs2hBNCwiZoYKR5k?=
 =?us-ascii?Q?KBXQ0ZvXX/9POAWao+LSzvHFABiVzetytt1HIpbbdwI3Z/OPnuoz3ObnVgbx?=
 =?us-ascii?Q?JQpPv1J9mug3bhlgrSYcXftk4VGWyOMWYWNKuZ1IRZ5zjP77jgHV5Ftc42jP?=
 =?us-ascii?Q?Gtm0uWIU63VfxZOILLNA9tx8794SqnNqgdRfA5gX544qxBYacfYF2zjrSYrd?=
 =?us-ascii?Q?VFhUp1FVzkGarIbqTgGTcXACvhqPkp5SXEwJv+uUPnoBh/MwsIq9xvuSq9Ah?=
 =?us-ascii?Q?h+hcxwwLY75v8QVjYN2W1cby39JM0Sf+8KVR7pahghd6Ql1KmouHmPtuiRhs?=
 =?us-ascii?Q?QAYX0RukbhKI/c6H+wPa/CfpSsaKwly3ymvxhyXsH9Od8EBHmf887cXZwlhL?=
 =?us-ascii?Q?TMmPHnvQ3rupx7Ol52yj2DuAykOQTQ3s/vpsQAoXQ16/5/b/lAl6Cd12KxNn?=
 =?us-ascii?Q?7KkBHGoVdeg5l8f2avzvfE4AemfyxEZcfYt69Y2j11+fT8YkIpEIA6qdQ7el?=
 =?us-ascii?Q?RswQXaPo+KuOTvnvww1JaG/xPZpQM5wl7IxOK1tZrMYypGvFFsUffl3e8oBw?=
 =?us-ascii?Q?+xnDsYtI84DWtXBp9G8zC6R2f42Ku8VbmBBqA9a90CsaQlXDEjoD9ctDnmPQ?=
 =?us-ascii?Q?8WIhbN5nmBI6+lCCefUfIia5kG/QyW6CuHXNBrRAS3Frz7n422qy1YCnR3Wx?=
 =?us-ascii?Q?sCmebD2E3Te5sK80xtdEz2f8m6rxjOXenIsQDJTZvx2vp6+MuU6fLwXjeJwm?=
 =?us-ascii?Q?Y+w73aaj3Z0Ri5BVT28cWOCz4EXVQPhjPdjk6EI8I2pQG6VkWBL2/v1Jln2c?=
 =?us-ascii?Q?WkZ/QtUQk0tZq/WV0O1Hn2Rrlob67KISOR0E34O5ufeQWZX6rIBuhLKUkl23?=
 =?us-ascii?Q?5PIjiarZ+CxhT4LMYadhXhZPzdim/ZOYNC2pi7aONxRzD6t0y0FUm1yEd8MW?=
 =?us-ascii?Q?+iarGDfMOTnDCsp73IGecSdPMT9NJwpkY2wa/70OyyJuH6qjC8MRxkWUC2gD?=
 =?us-ascii?Q?eHp6/eU3Q4FisEBXSVsQ01jJQZPa66dUJyyyyiCMsHQGXx75TeO+W7Og3xE5?=
 =?us-ascii?Q?gBaJhjer11nfmTlpwCysmOLMnaZahih3ELFPqSSoo8HFON7LGJEOwtH4tYW0?=
 =?us-ascii?Q?6eINdTnmeJL7oe6+BRP3CImRkTlP0kc4UN8GUu8JYnPbDMVFMw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpSmfykx7abrAB4rIcMTrLaMVuaUC4r80C0m1ok6PjgXm4cDdC9tMtoSWmrf?=
 =?us-ascii?Q?eXJHoZATFHc6lhFEToyuEL3lmCDygfdBEFgEOMBaXpGDtobeh5YxqyBBMlOZ?=
 =?us-ascii?Q?xlqgzKWHay7HjKmDGs7QrBTrwuz57XFMmjILKRgLU+7Z4d/r8CXCKCs5kWlY?=
 =?us-ascii?Q?7EOG9tWBYmSADlckjRCcqUwrv9OGhRaTvD9KlOy/k3VJQbyohEW0//aoFHFA?=
 =?us-ascii?Q?9HKyle86/icwPinK1h/eaKp25DDxajmyLG4OK8vr/yHUc/DNzp5ebQTwkbD0?=
 =?us-ascii?Q?667rYerSmpfRva4nDVRkShob+PnnNae7+uesvGU5cGHbzFWLoV5dQHIGmHYj?=
 =?us-ascii?Q?lpzDhoM2vgKOJ1m7RSk24BjuHuNrZeXb5Qom9VRWUDhHPTV+OUhK0TNJc/y/?=
 =?us-ascii?Q?tj3EXnCYHPNZ1sJZi7AKmEWNaGaONRwv1pD60YlS+a+pxl5iDVSShLL3eLzN?=
 =?us-ascii?Q?0idcLE9bAlkefLmDWJDLVwTn4UHy1fq9prTZJ6e67qyyGAyK7DROlHdBbdcq?=
 =?us-ascii?Q?X+42DKtlmy85v08BBvTl/oWBCERGVBZ7hSfUYp04qGP61QyxDFsiSCQ4heVj?=
 =?us-ascii?Q?rSj6o4TgFMSjT07YggcgrA/offAm46/JW02HVy2MZRKkfeL1ZY1WuS7sGUge?=
 =?us-ascii?Q?UVZ0W13lLWajf3lOSB8KzPGinSfnyN3hM/wnwp0ZwuUZ/dzeP/pEbb7E5Oow?=
 =?us-ascii?Q?C3dAwY+SFuVMpJlRMq+lyCrvesEbRJjmgmE8wSi8/fHTsNUDdm9SdB+yaANU?=
 =?us-ascii?Q?ANju92Fzo7sO5FEibYsu6J7xFGq51NO5RU56owy1Slf0kDKIu6OjoHxD/5JH?=
 =?us-ascii?Q?RtVHbkY9W/qDFysFlTENtV2bMADg0ZgIwbo2vshB0WSSG+CDWu7oSa4FeP0O?=
 =?us-ascii?Q?tO+iA1CADkTgphH7Lbcxpx9PaRUVG2BPRnlFda1weI5rjbiiwf1EUgTliVvA?=
 =?us-ascii?Q?sq0g84xSmd5and0ZV77ZG6eaK3E4ZeE8O3Bl575nL0XWChp7mnPNIBnS234r?=
 =?us-ascii?Q?Etsz/N9GrAsTtDiHgfeJUrZbMY5nIkYJjK8hv1qTbWhzsR873PlWUi7PXMq+?=
 =?us-ascii?Q?TdbMNZ3Aio4J4swxw9l276OmT5WUf4ZFoiir/arrK8DMt7PEBbfAgzAAuAAd?=
 =?us-ascii?Q?v1Drs87fol8fLqUxUcIvo6GFH6inNbCbtUOEesVdHM1hOnlCe6qnQlTtRjsy?=
 =?us-ascii?Q?yHrmBrweM9VgRKy5c1YrulRV3zWc/m6Duo1DL6C2A68JNxSkcItNJHy/Ldu3?=
 =?us-ascii?Q?fAsjIzRM4GK2Gcn98Kp3axScuAagZUjIeJyVA2RVT5S3KO4cKxg3XyQgcc4R?=
 =?us-ascii?Q?ExiXNkxIv6WluzI2Ua4Rj6w01S3vTOv7iLKLA9IYkORp8QgMshjYxv4VBcQm?=
 =?us-ascii?Q?QNEofEjKHi987MftiRZ7DjNNWVjRGl5wYHMcv0YjfS/p/jdeIasLcVD3Cl2g?=
 =?us-ascii?Q?2oUEo8Lk7UUJzg6nGD4Y84HY/k62x8Pmqys3PNkObPaYxGPHNlELEXtgI2mE?=
 =?us-ascii?Q?3778t4maKcXJUmWLWv8P6rvomr5vdBO9vxqYvX4M0Z9E5odyPpg2vVXXhM7i?=
 =?us-ascii?Q?LMu2TadpoNR8DDmt4gk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1d7761-b9e4-4052-d850-08dcc31bbb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 02:31:45.7970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzYVTzyL3x7vWrS5AD1PurOw5pyaiJHeerlXiK5zaypY2DD0tF05NoDt2g+3wdH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, August 23, 2024 10:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: fix ordering for setting workload_ma=
sk

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


No change in functionality for the current code, but we need to set the ind=
ex properly before changing it if we ever use a non-0 index.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 74e35f8ddefc..c1cd785b4aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1257,7 +1257,6 @@ static int smu_sw_init(void *handle)
        atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
        atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);

-       smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_POWER_PROF=
ILE_BOOTUP_DEFAULT];
        smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] =3D 0;
        smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] =3D 1;
        smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] =3D 2; @@ -=
1265,6 +1264,7 @@ static int smu_sw_init(void *handle)
        smu->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 4;
        smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
        smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;
+       smu->workload_mask =3D 1 <<
+ smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];

        smu->workload_setting[0] =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
        smu->workload_setting[1] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
--
2.46.0

