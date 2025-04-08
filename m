Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2382FC369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 13:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD9510E699;
	Tue,  8 Apr 2025 13:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uo1vr1hU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AF410E690
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 13:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7a88k8P3/v+CRr9xKqV7dIGRHgyDWto6zr+xuxO62RKcwmW6IBYtRr+ZUL5pH2qWX0WDd0z++ufQCHxpP/NZfRDjGVNjQOPaaKgtfcguii2jkNDMl3OQhhJEkgyKlQ9eNlzEAOmNqJo5VSE52dYZS6/UqDrZMlkWG8oRt/bWoW/FJfuEvPYMb6Jgu4iPJZLuBlIPQc+7s4FZx+DYnyr9A46W3QQUcCaamiPUVe0xhSmgbOWB4PAnou5Dsg2I5ILUCO8hr9n9/4u5kAx/LBgH3LFP3onbSaq5IKmV+27V88mwL7gUpJr/WETEUmkw7m/kjD2RWVjXnneiCR2VRcDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y41zDm8Siuk53B9+CmvIELdL3lw6G1Txre2GdHM4cA8=;
 b=vi+UhDZTGYsywRzrAgUjFPRNBaFufDPPezyKswelPelL/X8WG3p4k5qPtK/rYNhY1wYNWrMrV6k6KImpktDNAvELN7qC2d6J81KMbT1YVi/GmR0YVBaAySJRQjUzBnoDa7lLmoSg4S0HK8aVZD928A40YiMU3WVujZ4X6/ft4ZtxBK1IsQJlb9dNKpygC7EpEk5LB4geDIYIbpDeqcBnlo0b8BY9rmFmQyTagn62VkGFiBLEhQ0huKdkhjLlKjfsI85Ojvt9r/U6ZYhQh0FxNZxtmZsPUNxiTX+QXGgJKvlUmigjVfP5KGt6ubzD3KOiJz1cVxueLJjmx0gJlHcN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y41zDm8Siuk53B9+CmvIELdL3lw6G1Txre2GdHM4cA8=;
 b=uo1vr1hU9qPg5ErFJojNzkiPEc4yqb0wjozaOBnGW7EC55MnyqZiIjccfqV5d8I3hA4Qq7DBtTs8wTwQ99gQ6lUFe+qJWRUWVIINpiEud3JFZ2Jh8yErUf8tF94j++dgJNXFL6eqtOgazVQAz8Vv1suA0s46AeEEy6sqMnV1LEc=
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 13:38:12 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::3f49:9f92:3fcd:e374%7]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 13:38:12 +0000
From: "Yi, Tony" <Tony.Yi@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix CPER error handling on VFs
Thread-Topic: [PATCH] drm/amdgpu: Fix CPER error handling on VFs
Thread-Index: AQHbo0bl0i8NH+3mlUiA+KMCKHgStbOPx4CAgAoI4Xs=
Date: Tue, 8 Apr 2025 13:38:12 +0000
Message-ID: <DS7PR12MB5765D5E289A7BA12F623C262EFB52@DS7PR12MB5765.namprd12.prod.outlook.com>
References: <20250401204415.417443-1-victor.skvortsov@amd.com>
 <BN9PR12MB52578A1D5385C8EF5788EB8CFCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52578A1D5385C8EF5788EB8CFCAF2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T13:38:11.984Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5765:EE_|MW4PR12MB7465:EE_
x-ms-office365-filtering-correlation-id: 772a6674-483a-45d5-70c6-08dd76a29bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1OByCqdgh4AAzhPBgNRp2dGEOxvO305qRh+C/1THwq/kx1vgPmjJvUxC/CoT?=
 =?us-ascii?Q?M107MbWvsVgaUATKqM2i7ZwDdd+3kY0nJ3IiW0DW0y5snDlZvqIh9il+WLcW?=
 =?us-ascii?Q?OnElYyJ4Nv5UeDh1GZ1T5No0wCmpq0rNyroFunRfOX1g3mcuVMWm/di7gS2o?=
 =?us-ascii?Q?bY9RKzYlwu65P2+lOL0p2R2aVUrp2J9nHyLF7ft0ZhrE0GcOF2YwHQ5knNLr?=
 =?us-ascii?Q?x/Dzm9WQqamkpOh24sVOVXuKfvvePo74A1AZoMtXU5JKBg+P3iDx6MO3oJ3p?=
 =?us-ascii?Q?cTkGm7BVIJc2njIme7XGDemd4e92P4WU9EBaxEi4RYJBXeIOrMxce5Nj5aGT?=
 =?us-ascii?Q?dbPBW7iziDkjA8OgLlViHr916qmPYdppWlO7nVBjes5xTkGKn/9XwHkVEi2r?=
 =?us-ascii?Q?3Yh/UWjj2hFPrkN1s9KnmBhvThp0R0ihv9FR9xaaHsnnSKDI2H51M39l56sJ?=
 =?us-ascii?Q?31e378/7hrmRDEiH8RC32LMsnE9sN4o2O3l26k6d1QDf/FEg115+dOLKoPN+?=
 =?us-ascii?Q?B+vZ9zGNv97RVZAy0mhjMJbrYiOT4krljYxVVO+LOntNpZef9KUv5e1qJePs?=
 =?us-ascii?Q?akuly7wDyXAJVzJVAX6MDU8NDZXNyFM2+TGT9BsMEZqUfU8nznK3Tf3FNuNp?=
 =?us-ascii?Q?NSIy0sJe1rJTiEnIzaL6GCqg3VZO7KJjRz578I+ze2OPTGCQFtKkWiS+O1a7?=
 =?us-ascii?Q?j+UrLYEtAnUk1mXvjcSy8WsA7ovRGZFStwYTpVfagQ6opFzdVn8bKZFQKciI?=
 =?us-ascii?Q?aZzib0NKCc0zVy1ko6/66g6VP4M9byl+4rMIzBJCRa0AKm49GZp5D1v52o3B?=
 =?us-ascii?Q?pmOtPJ+ZK8vQs6ECq51JAty/GKEz7uWfUtnRqyxGcE8zaAKjUJAWCo8xEZur?=
 =?us-ascii?Q?QpDED+dVb+sekh9MjT8nzz3MbM/M4GlkhL79G0KI4dkEUl0jAXJ5wvvBjnES?=
 =?us-ascii?Q?h0LTD6LnEZixxMmUSMFotieefPJSXwg0/UYZdJo4+l2bVPGGaN/uuJJvm6o9?=
 =?us-ascii?Q?k2u17AST6oAZnh68W97bckRP3N3d1gXZkQUTkJFVynSxWMYXcqUWSMCrtwCE?=
 =?us-ascii?Q?Vxw3y9g3VNmAQDKfbPf4YO6rPbzHMoQ3GJNSjRFtwoPyslwz8q4P1SlRkENO?=
 =?us-ascii?Q?WkSogKpTSgfyzAglVz95/+PYD7akGqsIZrjp7SgRXVMxeKWgK1eYEusoh1s9?=
 =?us-ascii?Q?Q4xJaVHn2C6FMBVzRfTYioHVri4l4e/kdaVExoIzRGG/ogutrAoOM3kw4Knv?=
 =?us-ascii?Q?CKPXZAmI2UhGzyI7/RyDcSTSXDUaVrfdXWL04XDm31sr1YuMVuuh95g/6H8H?=
 =?us-ascii?Q?e+GJEv80xKLrTtTwFssfWiG20V32/r9Jo0vOhZ0br/RQTB4Pvdccj3ft30IW?=
 =?us-ascii?Q?OU9kUvuLf+hmXjzN6mSO6giODQeShkpoA36F6MKD+hd884cGQmoPWscJsMTi?=
 =?us-ascii?Q?aWPtcdDcfxNYM0ht/wsnAZ1Xe6vOO9DG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5765.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mnwE8EPq4LiRoU7e20RxluQnYsGs1R43WuY6gwuyqJnAwl2FH1OJsYnjlB4l?=
 =?us-ascii?Q?780/78R0pBD/2jaIZpKNMlyFFLkty44dr24VJKdanhi9De/zZRaDoJ230tyd?=
 =?us-ascii?Q?0T1xb/Y1sPVrQmG5jp3dgpZEoRHwGGlojgbrGdRZAp84x1rVQtSCw+wz0pCA?=
 =?us-ascii?Q?8mQDrnwY3Hu/Cg3mR8ZfCBUlyKOmLmsMauzwz5OwgR7BmQjZ6Eghn7qWkOba?=
 =?us-ascii?Q?pzK3geS12k7UYqbe+iWWyzoG6b9n4qacHHHLWUD8qo0NUx7ArRtiUKrjWV+r?=
 =?us-ascii?Q?XNbDjtIZjq6s7PmgiFwvs+NMmombBYCeWVzgOLp1WgaFMhzpoFauiLGH+hUK?=
 =?us-ascii?Q?RMKxL2PkC4dAIRVe54SXt0UosMZK7yf7GRrYTI66c/iH5Ai2zFrNVT0POorB?=
 =?us-ascii?Q?uxScpmuBNGo9Jh57k/OLr9J2kE7u+01Vj+EO2GjEkHk6F2YSmjp9qbY5wGR8?=
 =?us-ascii?Q?YbgvDgZ2hyPm527+2+AUZBYEJjtA7FgEIgIu1bp79Ww8mAUrFhG++Wl+JYpZ?=
 =?us-ascii?Q?15rI9fiILvzHOAU6d5cleAy91p/G71YTZxw0Ay8aNFtEodCCpBwgXNKPw1j0?=
 =?us-ascii?Q?gPPQA09LQR1rRW6QFpaJFDSbIErOE3SJHtjAm9G+zHo0d41awo/rhA2eq+ow?=
 =?us-ascii?Q?2/tDpySK6BUM5gjf4TD7AZleJ8VY9kBpslXCaBWDXBmfjI3eLAWTM/95K54y?=
 =?us-ascii?Q?Xm3GknwiEuY9J/yZjTpkvl9ISEkpUtfQDT3GXm4r5CFnyWjkjMwd/xTQKOc5?=
 =?us-ascii?Q?9sRZ/c0IoNjKdvHPVuUe55bIap/Ci0tBqZABazLP0fSu8f7TbV/Sme505LF7?=
 =?us-ascii?Q?vdoGVCmUf+/Tkppo9nwzYe7NpMwzR223Lpn+Hf99eQXzSQVUMliEoi0sZVYW?=
 =?us-ascii?Q?xHGCOBuidEDa5stXZv3MH7pEgKplmbO6KcAGvHxZAIY70CIBmKCnFbYuO5BD?=
 =?us-ascii?Q?S+EmWJgRmJ7Hiqg+6j9orWwwHVgz0GnmwKwurew5RhfhZa0RsmFzGwyYXdeu?=
 =?us-ascii?Q?ddRfCXmbEKFCHUR6bbOcuG6u4Y5O3DkiRcv6QX3/jX8BibWJuehVQnhC+kr3?=
 =?us-ascii?Q?fgG2KCYggHILHivbj90ro1iH0b4SmXeSE+eGvRMXk6z1hxbhjFh9Fa1FEuME?=
 =?us-ascii?Q?7R9Q3ZCFmtKOCEI/Gp6HiRq6vjZLtFTTdWaWVfz67JcT207K9IEATgFRMqTW?=
 =?us-ascii?Q?lIwBITPrLHvJXZZBe+mn2v8kmNj/lJRlESGJuHZy6L8AJgNkxA7l2B0IehLG?=
 =?us-ascii?Q?ZnWCN04i39Cqy0PJG0rlp9bxqGDgMTi2qBPMEqv+1AfOV5cqeB78pLBDY6jT?=
 =?us-ascii?Q?2V2kzpyHdS8bVaWtyUEAMFXGkAlk74DheiWeiHT0Jjt+wAcdNMxiYRTk3TiR?=
 =?us-ascii?Q?IWOiWvTXFkSZlOuHWnWIbu0SLKjmrk7TYyaJEGOhbE71bU3HDMXJTv8Zb/I5?=
 =?us-ascii?Q?+rlIo4ScFk6P1eqtkrZcYvJ5zDxgH1pljf0LWd2IVlDaKgD74T+DLePmVrLm?=
 =?us-ascii?Q?R1AZc/BuHRYfDaE5I7Gow+WDVJ0UuT3fFF4caonbYzAi2UC+rjxEkSb5BPCj?=
 =?us-ascii?Q?Oy2deSUfLmIEIN2UQt8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB5765D5E289A7BA12F623C262EFB52DS7PR12MB5765namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a6674-483a-45d5-70c6-08dd76a29bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 13:38:12.7662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZo1+i7wadx3km+md8n1MGU13fObZU/ivOvP1ARHECl4ppSE6mcBt8Q4iqnw8vKvZ1rUPepG0IJ6ghExI23Nag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
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

--_000_DS7PR12MB5765D5E289A7BA12F623C262EFB52DS7PR12MB5765namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Signed-off-by: Tony Yi <Tony.Yi@amd.com>
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, April 2, 2025 12:23 AM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zha=
o, Victor <Victor.Zhao@amd.com>; Yi, Tony <Tony.Yi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix CPER error handling on VFs

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, April 2, 2025 04:44
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Yi=
, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CPER error handling on VFs

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..8d2da3a27440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1378,14 +1378,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
        used_size =3D host_telemetry->header.used_size;

        if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-               return 0;
+               return -EINVAL;

        cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, G=
FP_KERNEL);
        if (!cper_dump)
                return -ENOMEM;

-       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
+       if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
)) {
+               ret =3D -EINVAL;
                goto out;
+       }

        *more =3D cper_dump->more;

@@ -1434,7 +1436,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)
                                adev, virt->fw_reserve.ras_telemetry, &more=
);
                else
                        ret =3D 0;
-       } while (more);
+       } while (more && !ret);

        return ret;
 }
--
2.34.1


--_000_DS7PR12MB5765D5E289A7BA12F623C262EFB52DS7PR12MB5765namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Signed-off-by:&nbsp;Tony Yi &lt;Tony.Yi@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 2, 2025 12:23 AM<br>
<b>To:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Yi, Tony &lt;Tony=
.Yi@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Fix CPER error handling on VFs</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
Sent: Wednesday, April 2, 2025 04:44<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Luo, Zhigang &lt;Zhigang.Luo@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zh=
ang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Zhao, Victor &lt;Vic=
tor.Zhao@amd.com&gt;; Yi, Tony &lt;Tony.Yi@amd.com&gt;; Skvortsov, Victor &=
lt;Victor.Skvortsov@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Fix CPER error handling on VFs<br>
<br>
From: Tony Yi &lt;Tony.Yi@amd.com&gt;<br>
<br>
CPER read will loop infinitely if an error is encountered and the more bit =
is set. Add error checks to break upon failure.<br>
<br>
Suggested-by: Tony Yi &lt;Tony.Yi@amd.com&gt;<br>
Signed-off-by: Victor Skvortsov &lt;Victor.Skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 +++++---<br>
&nbsp;1 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 0bb8cbe0dcc0..8d2da3a27440 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -1378,14 +1378,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size =3D host_telemetry-&gt=
;header.used_size;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_RA=
S_TELEMETRY_SIZE_KB &lt;&lt; 10))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump =3D kmemdup(&amp;host_=
telemetry-&gt;body.cper_dump, used_size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cper_dump)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_check=
sum(cper_dump, used_size, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (checksum !=3D amd_sriov_msg_check=
sum(cper_dump, used_size, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *more =3D cper_dump-&gt;more;<br=
>
<br>
@@ -1434,7 +1436,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, virt-&gt;fw_reserve.ras_telemetr=
y, &amp;more);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (more);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (more &amp;&amp; !ret);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DS7PR12MB5765D5E289A7BA12F623C262EFB52DS7PR12MB5765namp_--
