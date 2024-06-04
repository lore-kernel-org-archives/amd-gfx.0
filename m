Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E865AC25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 03:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D205610E276;
	Tue,  4 Jun 2024 03:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xx9BkVWm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD03110E276
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 03:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpPm8ajlffBbvEJe4h45tDsoDgn2f6J9Pd1hqYsUrlmKxZFZMLYRUflY1Jl8Yx3y8Agfshrx7qn3Lu3Rh452+Xl8q+VrsS9te6VA0HCEsJevVOXxG8D3V1dSApeB+lSWJCagd1dKefsxTALwpxjNCm4YTuwoWZRANGOVQFMZAxB/xoN4DYrAnvJFD+zDgEDk2eHx2dbTQppEwmW8XtksXBZKbHrz69KtzBcwgqTMxJ9tKzFAcJjHJRB1mi7qAQHB36ZkLhoTynWjpam6eJBhTQC7VJZLHUsdCqcrO8SQ3viVAEFMzC83VqgJMvAt/6mfj7a5JbV7chKV4/xJwqpvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izj/OvAWwEfgYVp5NWyUrNsXQLrFxPGccZVtU2kMiK0=;
 b=JMEPFrg1+2M8HMH2svHWuMoK0yicz6UUPZvzNJjfcLHAcbyd/s3jXVoAXwaYGBkKmejQwMvTNZaJmoY1Jmw+C9FQivKo6oAd1JBec0fpKjMaap3AqWPEIjmGK6YTDFLZjjOJmnQ82/SnIJIlZB0zgEV23ldhcp8EGYLhTKIa0r8ZMSsjqs676APB1sSbSerSJAKvW7XegNx91WBAApO+EG7nAEj8hleH2A2xM/LodT347rtWLnj7ihhwiPytFUY//JjetwLqEqn38SVZwGXrC5skkSDlG1cMfQC7t7PZwpdqND6IsoOd1MpRzBs8guDmlzwsjOuNUr+nVzMVcWAgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izj/OvAWwEfgYVp5NWyUrNsXQLrFxPGccZVtU2kMiK0=;
 b=xx9BkVWmEbGLn5WaKTM5ZEzdQqdL+aonvQtbSYMb3wg/00djpxE+nhZdMQ5qXN+vlmriHsoJxpUj7G3N5g4aIJzFJ8Hgu52FwjGp2Pem43MUwK7qCCsZtT50lZJfTzKi81TWxFmMcAOhO3knp4rW+CraNgOjVyfm6pJ0hE/tUw0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 03:25:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:25:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Olsak, Marek"
 <Marek.Olsak@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set PTE_IS_PTE bit for gfx12
Thread-Topic: [PATCH] drm/amdgpu: Set PTE_IS_PTE bit for gfx12
Thread-Index: AQHatcYElqQVk5Qa002YZoBy9YUrhbG2IlZggADPl9A=
Date: Tue, 4 Jun 2024 03:25:02 +0000
Message-ID: <BN9PR12MB5257D74CB801C7BD2163D793FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240603145305.197978-1-Frank.Min@amd.com>
 <SA1PR12MB5659B1C307D2F0356376CFD1E9FF2@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659B1C307D2F0356376CFD1E9FF2@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a17eaa17-7e71-40e7-9ec5-3cfdbb6691d5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T15:01:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6492:EE_
x-ms-office365-filtering-correlation-id: 90ccb404-1d2b-4eed-e9f8-08dc8445ebac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?KdXLO7+fRWdnXg7Qq4TVQptuutHoRa4lIc1eykdLjWHazJyk57AdPkWk/TwW?=
 =?us-ascii?Q?IOZUFyODx4srqEJO8VRmrxrSmAWNlgdzj69MRQqxtMX0SaX+fnXMiauAfi9I?=
 =?us-ascii?Q?UKQPcC2xrdl6Nb8DKxfYcMrayOhlOAZwXu969hxHqt+D+j1bxccaAkrq01cI?=
 =?us-ascii?Q?tvE8DGjft4AwCTcyMPKPRwuo5588IVseAKSIzan/TdraFD7IV2qBoNGd5Id5?=
 =?us-ascii?Q?FHyqiaTSHqkutWEOIK7alFlrhjxmAFFjIqsRwzEPf79sAVZAzwQZkMezLOgt?=
 =?us-ascii?Q?p+CHkb8H8RwGC0arhEqYWWaV9fsoCBmnUqF3mtSL2KfqiRdBYo9CaDK2SrOT?=
 =?us-ascii?Q?o5yxrKRSUTewOv+H+/+QheYGEtLhqOHJV8xg+/FqMlWxdvOUnPEO6gYXnK16?=
 =?us-ascii?Q?V4xO/G3Mew0hD5JeS/i8HLSAp/HAdpU+eIBcNHcDC5AOUkMZ8P21wphyhzti?=
 =?us-ascii?Q?upHjzxnxbwFcqHaN8DLANan48Kpj8X1QC7l1v3K70Y0BTdl2uobGT+/1X4S8?=
 =?us-ascii?Q?rc52/MX+nhr+J2OGbx/iX0vuhuQjpqOKvOIp6O1nwRyksVMc8v3EZHrO53Ra?=
 =?us-ascii?Q?PlX5h+ZEZ5kiVkhxhyXsHohhTBY+voOmDalVgQGjx16cYFLgrladeP/o9B7m?=
 =?us-ascii?Q?qAXRJwTe5RqV8magUmcRJqS2eSEYUUYwZV1UY9H7TWc96O66jf8U2o4os6Jy?=
 =?us-ascii?Q?G5LiXDuij6+/q7Cyqd18nYXEaZK14ExZ7ThaVaPRk4a4syDobXvXVWE8Uz1v?=
 =?us-ascii?Q?gTIBFOTiwaRY0eSFIYAnec+dr1eqEZjSq9Xf50YcgwhXAWejHBpnl9nWv/Go?=
 =?us-ascii?Q?kwUslroEqtJxxxawuR03I/U9x+gA4k1s49qI/sIXUqLxOBN5ZMwe0NJCy1TB?=
 =?us-ascii?Q?8KQcKsgHUxGPh0kF+PLydaK3weAiiZ+TmCUloigbKAxH2z2av41gIgbhcPre?=
 =?us-ascii?Q?dmmCZBBbtw4IF3FJzo3wOKj7nNHDpWN4oz6Xs4/y71rYdKMGnYpOPeO9C/zg?=
 =?us-ascii?Q?gRIKdPLW9he/WQ8AXDDAVVXDqh/M6Y57+c2mN/1zM5woYSe7BQJNRmp120zM?=
 =?us-ascii?Q?yIZl+sWRfUWXY6nv6Lj/5g4hnkhcDGWYFD1cz2wVt0pFA9Kx4y03QE6s3qn6?=
 =?us-ascii?Q?I/rAtdwAwTbsEIf295eNkrdjDhFLO6+1egcJOhTxExWtQu1vOIojlEo4GcBt?=
 =?us-ascii?Q?/euWu2w3FRMSsIJB/YoZxe4raEIddqKYMnTiiVVmQk77BNQBZtdbvEpLll/C?=
 =?us-ascii?Q?tsNfXNKkL0Dzx2gyJxdDD3M6FreF0U6/td8wKdqU3ZzuzX7sE7oovgfuNizx?=
 =?us-ascii?Q?z+sSD+MEydhIbUUAEgyko+MXQ8FCSgA73KAAAEiDKFxE2Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nsqni366bo5/oTd2PsS1gyfQKtn60HHj/S+2QSoUNwYpKSbu7RyreB8LwVtl?=
 =?us-ascii?Q?RfG0Xwkt7VK+yB6Xl1M5otu8ZLJpvSy6orLacH4V2K0Bz9WX+j6UjIL82/VT?=
 =?us-ascii?Q?aXCeFadZQ3RGXTRekLaeMW5O8d9uDgjzXOJzuNvPyPqznt+RhIEkb5MJ4vnS?=
 =?us-ascii?Q?NzOcvc90gHI8cD5Bfoj+FW4nIPgTtQn1U+FTSqiyKAo05kJk5s75E5nu0KPO?=
 =?us-ascii?Q?6xKQYam8ecLbJtAy8eVHZti6zFL5DSZPDgGDy3LwUjZAC55ADdSmyUrusHVh?=
 =?us-ascii?Q?qarEvOa0HleMhSEUJrg3bg1y9pES/WDvNmUEAlTcmcsbZxFElYSdnE2D8cL7?=
 =?us-ascii?Q?13r1i31PsFGCZNWshYpMbZTumYdlgx4UOBsEVVWOvjEey5UfRu72cucxSqNx?=
 =?us-ascii?Q?ZK+dJGSBYHT57wpt7PamqpxoIIVmG2gC2PlVZn9JdGZy6l6h2FkbRbmymWdQ?=
 =?us-ascii?Q?5xJEIgxEDhSpFdKEEE2ZQi9kiOrFravYBES9Nc6cfRDDASFbvafQXczzLXvL?=
 =?us-ascii?Q?FuNNEwco0ImcJROM6JaA3q/CQ4imWFftc645onC5+b3MqFF+uV/+rK+vAo7i?=
 =?us-ascii?Q?N7ARauvXW7p56NSvsF5rFjlzgRtT9SAl3004DdNIqtABxTjilXLUxaPAdOBJ?=
 =?us-ascii?Q?tVDIRLmenb3dyRnBmmaLQTeIt+3UjoNphabstwn9HtN1e+xzT0rSHpzfhXKL?=
 =?us-ascii?Q?8PjFRUzGyE3r4EICmhTTCnSGkxNU02K938tvfIXR8VeG5Le8U18UH7Z3EfsR?=
 =?us-ascii?Q?VrzNCYbeC9zrPMp+nX5DorlSoBekwvXk8U432GaxGZ/GeVSO8XASqll5xQ2n?=
 =?us-ascii?Q?qCk5dZFnMpvmPB9LYxWWT0ghn5eGwDk3ZgnaBXqZAzC2x3KlHbOCE5hjS/hS?=
 =?us-ascii?Q?xBno5uALAMxzj28ApB/JMs/RLjYrDaay6I2QNVfkm/Y1J6berILDrGVMQ5Pb?=
 =?us-ascii?Q?pFkyl+44dYjvE08VtH7olftTbkasFMolUivzNjfRzHNvEkpJfkpzdiWbaDIk?=
 =?us-ascii?Q?nbolXR9ktmHjTKLVcwt+/vo2EjwzfjIPQjXtRlJK5KbHgxtP0RH7AjVm9H/X?=
 =?us-ascii?Q?z4DV5QvQwNkMCq3ZXfTiolZSeM7cwgaefNjPfSTa2tTvMpQeCNeRwz3uzBc1?=
 =?us-ascii?Q?C4HXOZvsf/1w46GDt9WdIa1otwxZIO/GfvJL7OcK70uKSOL0VfkjjVMJmB2u?=
 =?us-ascii?Q?YwcyWJsucpm+8Ii8neriKeY/FjQFqd9FmyCBJP+rI45hjYjxxRyi7UsVP62N?=
 =?us-ascii?Q?67w8zukm5xblFOJvVzSln2eG7rxx2RYivMJco6V/4tUbmrW5Y4oYODoYldZv?=
 =?us-ascii?Q?DSOlOPgWC2Hlc+kLMtEh3tOQE6+Bq1sAtfHrSTP1yQgW5RP8NTDkC7UFR1W9?=
 =?us-ascii?Q?u20JMsd0UYXzVRFFxyJoVGyTeyZqS98J0CjTpGtIrC7/E4hVKWLNNwX7x8pt?=
 =?us-ascii?Q?XGOap/UepKo+3a6ZH+QxdroKGvU7zSxu6LBoLnjeK39VjeClolFgXYmQ7WH6?=
 =?us-ascii?Q?G3pKiXsX06v82FRJEft2KRrCuSSNsY++YZDOgF1q0GHUUmkDhGLGZN1/sDIz?=
 =?us-ascii?Q?KWdmk+Fk9spIn1pofhzN15jRSBSn09Jj4HHjgosh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ccb404-1d2b-4eed-e9f8-08dc8445ebac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:25:02.0959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kxHZeM2AL/4wzE3FhBh0uLgw53AU1sJzHQXsaOv03hVo4+tO2S0vz+5PpMkB+Kap/lbnih59BoPzBa6lgAbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Monday, June 3, 2024 23:04
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <=
Likun.Gao@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set PTE_IS_PTE bit for gfx12

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

Set PTE_IS_PTE bit while PRT is enabled on gfx12.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 7d99fcc58baf..e09be1a6c7d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -512,6 +512,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *=
adev,
                *flags |=3D AMDGPU_PTE_PRT_GFX12;
                *flags |=3D AMDGPU_PTE_SNOOPED;
                *flags |=3D AMDGPU_PTE_SYSTEM;
+               *flags |=3D AMDGPU_PTE_IS_PTE;
                *flags &=3D ~AMDGPU_PTE_VALID;
        }

--
2.34.1


