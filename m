Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E378C4706C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 01:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9854810E55C;
	Wed, 10 Jan 2024 01:42:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3763C10E55C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 01:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekoTa1tXLODBQFlGIR2mO8kj0PI9JViRxeyI8ksa9cIFJWvWkAitzkVAXkOzK7m7p/JKnF666YdVFUFbVfen1N5oQsdXQx0ytiJiJ9rrfWI/ipdoSA3jWQowlmJRSj8fg2oE9jurl4Opb+MSQiHvRSFgd8Dnl8KMdhCtIwRoGcF/O8xSMHKSVEgrO+G5q6cSZgp7ad7gWJAir7mO+1cgzM4VIUhTTd6Ycf/YIoilrsdOu2e/o3mdktwIeLQfnuNE60dBQBcBkTsAWlG319R+M6cFvKYn7J3wIBQ+TwKT2RXB6PQVvCiGv2GildHeMgFNsZj6uW0AiAZXDLx0gpm3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwuvH+607JCZvjD4V7VyCuGR1CqJlrOW4DSrYAZDNpk=;
 b=AaXW/SvU6iTH6IhMP0vbvBaXTmvihAxDS7U+iJDtW0sKrkhsF4tg/HPx+K5Wz3mA1vKMxHBuQyyBcBufNuRz/MTt5836yhqd0CBikU8UiPPDirkQk6wlVGuYGsxB+8UGNDiuFQoUdfUoSLoFssnb5TQyWuu6XJPS5JxF5yb26j+faNvCRYaz6Hp6Q6KYpbqC+/S9L/knH4wF8H0Y9WAxyamlnoc/wxQMR6X5kxUuQZ7aeRShvhiIl6suVv4hhf5VOD+qCMPq04uBqwbxKGk+4T+c+wiY1jIFDSbda0DXoPv4jvrfBJr53fj6kR6qNZFvtSBdkdimR5WDJrRqKRD2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwuvH+607JCZvjD4V7VyCuGR1CqJlrOW4DSrYAZDNpk=;
 b=OVy6cPSbT/SJi/KxZGFRN/nf2zBCrBidznuFlaBPAkijPq0DJA9j0boAsgExEbHAf62mrL38ae/Efe+zBUf8EW1cCIrQkDUnLh9RQL7lzgFeIaEtee7iIYrb2xzD7gLXnuAoeyorAsv5/OX25Si/Usim6ptTF32lmy9jMxgcBiE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 01:42:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 01:42:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
Thread-Topic: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3
Thread-Index: AQHaQxNA7m3zwZ/HKEKl4J2KX/3DTrDSRmoQ
Date: Wed, 10 Jan 2024 01:42:52 +0000
Message-ID: <BN9PR12MB52573FBDF086D60AB7EC1A52FC692@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240109154625.1608427-1-alexander.deucher@amd.com>
In-Reply-To: <20240109154625.1608427-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0548da96-0f3d-4716-b6d9-05dc4b07f3e0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-10T01:42:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7442:EE_
x-ms-office365-filtering-correlation-id: d24f39f1-1c7b-4c0f-b8d5-08dc117d7607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FP7+EbOYNrhmTEtCmcXYexl2J7FT6BWRRRwIvIocATtTU1WaGM/IZEZXX70EKMeN9OetmgzF3ksl/sVyc4g72uQrmFO0KZtUVLQGJ2lJnbZwLovuzbQM5aavEHWjSBP5DKF1003gBEX2qlev2cx1LPk+6Xn14YsIZDuPnjq2pJeJ5+89yF6SpIrjcbWFrKwMliJIOux8PSWVpvpocJXhVtoCO5NL1VEHJ5b8b34TBOoKy/5PiBJocpuN1CFVhHIQCYIO51BfVV3CRoXdx6uPGROkMSWg7eqBYsCOYxPE5WsaaNBBOV9PgRa0iA9bilbzFCExCmEPZZVKiudqsjR7HFPtU9DL7iuVOs6zaR0wBiD6ceygn/FFztzNQUX+2ETBdShUECG08IY0pnJJ0WddHhvS6RlWIYK0bTpI4WGU2x5MXfje5z33uQYgYc14aMi6JkhA8gvVFbbMIIdc0kdW7WvTYYPVtDVYW11gLQIjkjfZyZUkW4TjJIOGvKH7Lb1CKVZj9N6oF7TdwS33YPXADOs33ZZsZ1yato5j8YHmqX09aya8oec1bF27JR4keqVCpYvKW4SUJjO6Acmas/MUjwyWZrZo5Xp/AIHiDbhBYO5n08mt61yp7+jdPqNVaZha
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(53546011)(9686003)(110136005)(478600001)(38070700009)(86362001)(33656002)(71200400001)(26005)(83380400001)(5660300002)(2906002)(316002)(7696005)(6506007)(76116006)(8936002)(8676002)(4326008)(66946007)(38100700002)(41300700001)(52536014)(66556008)(66476007)(66446008)(64756008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJX3z5OSG5UDEGHR/RDnc8JEiSd9cg+3StD6rwhy3zCsDnLCdRgllQVSLR4D?=
 =?us-ascii?Q?IVlSqD4LQHPprVXF8OFrwIljTjTilCl+8DHz+48Vvnlt4KrDfiOFT+93CUU5?=
 =?us-ascii?Q?8W0LNBHAIkr6UHZOnSzoY2fAOVUwCXl/Ot3A1VGoWiIO+Mcb3w5d1SdDv6p/?=
 =?us-ascii?Q?0hZPZFoph4j4mXKh4kyrkPG5UG1uS/4eywTSGqFk8+nvbRS/s/C+0AmmMNqZ?=
 =?us-ascii?Q?pf8D/I9JEKaDrv8FzI1gTSkuozLXnkKdTYx3n7rJd6wDm+GSylzpKhNIPnOv?=
 =?us-ascii?Q?l8w6Epvk44PuThDW5/2pYR2yVw3g0eWPB+qfcS+ojR6oRqpWbu5HzMvAIqHa?=
 =?us-ascii?Q?dw/v1rg7sS49sw7FvDeXC5vzhRf3w7hQrZlq1MNT9dzlujVmFX8PkyvdDl9Y?=
 =?us-ascii?Q?O9rJ7WYd3keyNrwQ+phR7zKGgBuxFaQEB9IK72wXLtVJwpSkusjb3S/jqAZi?=
 =?us-ascii?Q?SrnJjTierjtlQX5OtCC5u0ro2AdqhxUrBw3Q5qfBOyyOluIKgO6yZtnwIj68?=
 =?us-ascii?Q?IRjy226D1OIbQ/fAP1aBi8HB5aLn8VJSvkA8bAZdVafBYZ6XjZeCr1G3uCkB?=
 =?us-ascii?Q?2iV06jhqrkhSX72MakctiK5pDdJD4rkTI4sqjt+HBkaPMoNOJlzRc6a2WHsB?=
 =?us-ascii?Q?q4SEUmYTlJOyzXf4JlOcMQoMUlndC6xGuvvUH5tovGN6UWuWHltMDmvITjZ8?=
 =?us-ascii?Q?G1yI6SrIXeov3PEYnDb7hir3DMRNDTEAaNPMrkymND5PNj8/x45J5xvtn/ls?=
 =?us-ascii?Q?jnYvrLQYZcVp8XPkoCL1QToAxa6ClyONbN8p0l+0rfDDX9fR9cks1ZreObm2?=
 =?us-ascii?Q?0ug8Dc3AJsE2LplSJH4iCvXr0blRLOJgR7U4mAhXbSXoGF5l+tO2oyxHXoXn?=
 =?us-ascii?Q?TimkyoIpVcMD6BlcvvLxvxNm48C9gJrjCKrNRt1d1MOxtPFZk5xW4+3TaINi?=
 =?us-ascii?Q?7/DMlLhNrAcr9Qfw2JmWt1AFL5Q6X0y+yV8jtHtsuquVWVxtoZRV0bnpAPoM?=
 =?us-ascii?Q?nzfGX03+jOjP1DC0VNQokhnmoekkBuC7R2xDwhMigIsy0CwrI1hS8XXlXhLt?=
 =?us-ascii?Q?TtYWNqkwpdp85htfHjpui1+ClRUP5AJoqcMdJ649q7P3lnzN8sO6+uLPMQwP?=
 =?us-ascii?Q?nK8K2CDIKi4NPUW8tiOpe7sB0v7YIlsN36Hp5leyYtn8Xk9fl1wXSLbs3x2S?=
 =?us-ascii?Q?omNSkzlVaorVGJOI+Oxx1ZOQEKLqiBsvYufHK1R3PO+Zg/1Q2RlHnQFV2H7A?=
 =?us-ascii?Q?B2qFEJ3YSj86jBG1ZMSfHX1P74aPrQd419Ob4pM4V5yOKGbKP5ZBBQRUg81x?=
 =?us-ascii?Q?pgnbK6G+ZngGG2QRJKvnY6cTgye0LrwPxiNDPMRm9D+nFc1asoM9Dwt93jaY?=
 =?us-ascii?Q?o6XbGiTLBpsayYTDO/3FwtKwmiNLDfG1WF7Y/dai5s1Q0Y6zD2hO4QV2CqEd?=
 =?us-ascii?Q?23+MZJrccM/Nol/opLlJ7Pd47LcLh6K03alY1F7zoy5b/zjd05e/tb3IvZv7?=
 =?us-ascii?Q?SpZplFaumgKQPsOgspqWzkBWYRd2o/tmtqJ/W/DfLKQ6b7rFdAcHYHpQ4HMe?=
 =?us-ascii?Q?GsCNTNdfRzc3049K3z03f8V2vpI38qgGqvEpk3Ha?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24f39f1-1c7b-4c0f-b8d5-08dc117d7607
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 01:42:52.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pCxvEyAE6dlaPRZLpHernzJ8XkRixpkneZN1QMpqly7mV3VfTVEYpBR0y9O30Z3fvWdCowMvjXTX3G1KwOgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, January 9, 2024 23:46
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop exp hw support check for GC 9.4.3

No longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..f96811bbe40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1963,8 +1963,6 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)
                amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
                break;
        case IP_VERSION(9, 4, 3):
-               if (!amdgpu_exp_hw_support)
-                       return -EINVAL;
                amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
                break;
        case IP_VERSION(10, 1, 10):
--
2.42.0

