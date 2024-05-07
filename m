Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADAAC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DBB1123CC;
	Tue,  7 May 2024 03:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Txes2l1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07331123CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJkjvNpWtZMAs/g9LmQgtACU/V0Dl7eWIw1jnL3n16kMEkBKxsfRDJfYqMG3zZ8f0AdfvX56oWNZRU/MqfNOHDoCAzAYVDWVv+shx3gpByC2xrwHFXlOs8t9izMRkwTQMWgQ7Wiscy7gnoqeMypKMynpUZuOZ0OQw+wMGAH2+Zs0wnUOCWQX8DWrz+z8IkTu8o0hJLoGNILI+vOebwmSNUka+bRZgr8Q3pZJPSY/2zXfmAxC9u5oFWS7IJBXTqnJwMBH3AFU6ZcK7oo1fUql1KuSI6suxnDqOsVyM91mv0K8aldJUOSLKviW/jlK299D9BXKqONAsO9oTwxxxP1dlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYFN7GHQbagVGxUHTsqWXILAlWhm16ANQVnMBfUHPcs=;
 b=Iwqy2Bu8KndhA35ODloJxlPTRQtE7QEWJBHJAMsFa3wmCLiuV5YPeeoKY6CIZiUHf1W0Bfw30KAJV9d/sjjFV2L46I+wIjJZPOBj6RDuil/qvspWS1To7kXe9XavWjsGnO5lQHmchqyHV1tptt/HPUBu13EBmfQ+ydRSzeTBh2Bl7Wae4fyJJOe4v3MWUqiJyXzqZ+phgkNTLj7owcflfOF5WtMdT/SPjKNCIh34l9ZNeuU+efGtp7hFhpluE0YfdlCSbF+YUkGHVBV6j4Fj/g0RZIrVDiD3wqkh/AoONGMm6G9FAJ0nZ9uG8pHoKPgqcHyHDrFmcP3CtoI8QKgGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYFN7GHQbagVGxUHTsqWXILAlWhm16ANQVnMBfUHPcs=;
 b=4Txes2l1y8oK99XjF0d6y+ZFvz4UjNv/CflP3cUleazVru6w88xng1DSWhz/HzG5mAFEDlzkzxIVx7JgjxQF9KmMm//XlLfPBDcofMTXPCMdT9wC/RbXE2Wu3S46xjRc1j6rPpj+0kXhD35ENe2apjxK8ni4pAhGrnq4xMMtmmA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 03:36:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 03:36:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix RAS unload driver issue in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix RAS unload driver issue in SRIOV
Thread-Index: AQHaoCk/El1CkdUCR0yHMH0EWXSYyLGLHwRQ
Date: Tue, 7 May 2024 03:36:18 +0000
Message-ID: <BN9PR12MB5257F34B8B5BF476E2E04AF2FCE42@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240507024940.2199229-1-kevinyang.wang@amd.com>
In-Reply-To: <20240507024940.2199229-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0011c801-06a9-418b-9861-ce90164f4639;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-07T03:35:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6152:EE_
x-ms-office365-filtering-correlation-id: 74ca51f1-0520-43d2-9aaf-08dc6e46db1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?w0KWsgJ1VzJjdjFJwegQ2dTSg7b5YJQJdAYx4k7xeR5XUhxM5I8DicmJrRvp?=
 =?us-ascii?Q?13tQ7AXf262qD06Q8DhiN47OVQRGIxbKo9QD1U8tG6uCJbJRPQfVeYZYnWRT?=
 =?us-ascii?Q?Xi2yPFpR0uO+GMZ9b4th6Llh4j4d7WF8B/pKSafOuAx2pewFGGFW37JcCXj3?=
 =?us-ascii?Q?XVjkNNMZ6Ca8lJKjN/p2Opc9AJvHgtZ8GyONKJijewrBRYVttiAJ7G1Gb2n7?=
 =?us-ascii?Q?EATVd6Bb7XPQospHLAzZqhPyjXavfOcRhByEEcGN/IuxbyIAcDoth7fWnq6q?=
 =?us-ascii?Q?Xmrm+j+0CPxOI5SpyLKUWm2POyQRq8npJOwA28TtvzVePxwsQZpoj7AotakH?=
 =?us-ascii?Q?/M18wlKwD4gBfvToyO8TZvRLKTv1TiD4XxrdjvIkwURPYk45Y+CUrKbigW0h?=
 =?us-ascii?Q?21z+2Ip4CKETKUU+6DIGCladDD9X/SgYaJ/I5n0ZO6OYiJ0JupDRARpZvHpf?=
 =?us-ascii?Q?EvZY8Onvo8sy/jhKo3YOYiwcpk8Y3s0Q3pNgKSmRGnsNgqfnxnWACuzEaZQ/?=
 =?us-ascii?Q?39JYjnJJ56eCW2i1A9TixWAc1zHEoj4anc0pK2WmSDGdCAMbvzj9GkfwG++8?=
 =?us-ascii?Q?LTOVwd4SAykGYE6rqbUUy8eMRPrzQZLeQgiKcafShspLwD2Rg5FJgdGO3MqJ?=
 =?us-ascii?Q?bZmBRmiJz/UYYczy1GbNRz3d8r0E+OQz3XobkR8fkgBe46GAHAdpXZ/BcNSz?=
 =?us-ascii?Q?cZozcLvwPUx7arGMtRhMdc6le5PhDXwzDBPhS098oVuDYQNJKKGlR4+yFHOT?=
 =?us-ascii?Q?M7VjWdElZj3ts32PhfS6Z0/2bGslVvoP43XSH4yD/lKIRYTkNl7o6zoNo/cX?=
 =?us-ascii?Q?OVDfSN6RjXNLa3KF64WVVbJdj4xw28uDG6SJe4f8rc3K+Xnwh9k2lYkXXdfq?=
 =?us-ascii?Q?F6gXCroUb02pzav5mBTkaoUSjUVQciQTziM5+mjzzC4cRYJU+oFW/OMlV/9u?=
 =?us-ascii?Q?KCZULhIkOAaAW65jrxtnOoAEHCTmauaZy4Nrz2IyDimCh6XdbxcL91nRomfg?=
 =?us-ascii?Q?YTrE327NHxXJLxYtSQ+gwrx8PZDduP5TyEAbADrdY05JzirLJpiPkD8oDTFx?=
 =?us-ascii?Q?pbx+C/LxHenDYZIeQH0A3QQJOvxJXNnknjFzhKqAxtqTuJu8ObgvyDR0z+m2?=
 =?us-ascii?Q?qXuxCanp6dI/uuP9YjhuJLg0TFE8Gg+ca+BCUJDtPnVv1nog07qGxXFYnR3H?=
 =?us-ascii?Q?hx/qdYiQUUrRG15vjXk188kS1BdsnQEffBu2K7eOHkBW4XUY3PWSdtDn6SCZ?=
 =?us-ascii?Q?2xCo9xMGMvRUSw4I/FVmq/ib205RsatxlyyXfHpwNBHrukb5zI7alluvwdJc?=
 =?us-ascii?Q?5jVnjWnia73nhwU4kurvLCEdlyScQ96wWplEOoHM9skicg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+MVcxn6OGfQSXVhBZgQvU+Qfzt4GQvol5f8I1sizQDn5r/aZO8FTUemyLe8f?=
 =?us-ascii?Q?5hVxQLbhQdJVc1U4U69vazmSU7lifayhu+s0xbmfqzIUlA9WdSMr8xMwa/hm?=
 =?us-ascii?Q?5zXaUoM+Z0akAB9L4u6NKvqzbsaOjUVpqlMvvG2mAfZiwpmFwk8JGENdcei9?=
 =?us-ascii?Q?x7+xno4QeAgNLz3V45wms1cBPYTidZQjubk2Ms6m1Cg0/gklBHEifv75Nr+3?=
 =?us-ascii?Q?93YThnybD7QRivFnHgYEhGCQQqI3JgPrXpBQ6KkdbrfYBUQssmMKQuEwrre8?=
 =?us-ascii?Q?KmqkWbOWfzOi5deCVwfpL+sBc7ppufVTZAgTS+Buq1MhMmhWi+yA4zkm7L9+?=
 =?us-ascii?Q?9R5wfnBUt+B8F5dXnYjqr/0kigDmllo/T+4V1TjnMgd+bIArF6MH2QrAaqdz?=
 =?us-ascii?Q?R3QlvWKxEsGh3NqaHTxfAZP8FSmfNDIlVLJ5+gLfEcwyHxDubuD5gcxJRLSI?=
 =?us-ascii?Q?b0OUYkZQhs/Zt9X9LomvU/tt76eeU3gvxNRGJTM4W17Z/pLJqAS110M65+5u?=
 =?us-ascii?Q?feh+Z57euzZHXGnRhWQuEarGQlTx+0CQgMRMj0fO5FhZKIaORwqqbkMD+bvD?=
 =?us-ascii?Q?in9q7GpDZZVDh/xdeNwJzmZy4foeE2U52zm7PZX8iIIyxzvzfXy41E73hrM+?=
 =?us-ascii?Q?069+z549ZuD77BuOGUrfLYYPD0gqZ0OAqCdggblUhxefEgzqUTUzwzzR6IAJ?=
 =?us-ascii?Q?vSgwVWcK1SoIWk0heoePyYhq1JH38X686avTdn+6wVGs6u3nvKx48IMnSEo4?=
 =?us-ascii?Q?+0WiJsM9JrnS49P0vDRx0/1ufM8SxKvbGuRccmOVP5ZLEd7Q2lyVHUsUVOpq?=
 =?us-ascii?Q?2PWgmIvhmtWcFiVcZW+Twx5atZSgjXZchy3baOpomyc+STvXG9BG/uqfTle8?=
 =?us-ascii?Q?UaiRFovq9K8ZoLnvK1wQMrinbgnYzQP465r2Ur4z9Mk5r0XJ7JqahqAdFSQx?=
 =?us-ascii?Q?xFpsVsBRzROp/92PFbc7/S1dMLgAjwDm6dMWGcRbBr2ShY7eJAPp/UFwRpw+?=
 =?us-ascii?Q?VAlkzQOFMMKCs/JAmy3qneU9INklQ7ckXWxN+SlvpMbpkG/G6u/tuYaN7oRA?=
 =?us-ascii?Q?UgllzZ6MUsZB9BIrYuHO+Vh5WpLgEe9YvI4pcfOv9goy3LejOmz2MtajMToQ?=
 =?us-ascii?Q?ElwHDPbgYHXt+zN4SPBBa+lARYC/huHTLrFXXMCfk43SKMwiKbuK6JnbLDbI?=
 =?us-ascii?Q?6E1/6BxpOOLNIOOaCGs7GMBKllSoqn9qHRofq7yMvikZs8/7J3OKuJWKD+I7?=
 =?us-ascii?Q?X0o7l5s29FKlaKFKkfsRH+ZAkJafxro4T5RaA1q/JdSwHptvRZ6hDlgjdpht?=
 =?us-ascii?Q?zDDQNdLut7zm9lNVaY24HErFUOA2OfyN2iIdRlrPA0P0AAN3rimL3wuF17M6?=
 =?us-ascii?Q?JMMfCy5+GI5QOD1GnM0DCtc1Q48NZI0m6ur7cogXGqgKm2j5SwDUK3uFK/MD?=
 =?us-ascii?Q?dNLg7/FpVzwKXDVays1q5+x9KbsWzQzqStANzCXW4qVeT6hgZAsX4+NYpDKq?=
 =?us-ascii?Q?mdY5zncMA6AT2zf2fO1LcrS9jUdwe1Ges9psbx5x81YwWioQkGnOl0cQauk1?=
 =?us-ascii?Q?2xmi1Qr/4of71EcL3nrXPgkScwXNe3zzClAqdm5b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ca51f1-0520-43d2-9aaf-08dc6e46db1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 03:36:18.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2dRIOITDffltRxZk6V4V//ZirdcynX0+aEIXeHXkR5rVSVWUVGe5QDdrQVb8AVoXH9lm/mh0SiFbpsq4EzW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, May 7, 2024 10:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix RAS unload driver issue in SRIOV

Fix null pointer issue when unload driver in SRIOV mode.

Adjust the function position to ensure that the amdgpu_mca/aca_xxx_init() r=
elated functions can be initialized properly.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 36509fa9fecf..36deac3b1440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3611,10 +3611,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        struct amdgpu_ras_block_object *obj;
        int r;

-       /* Guest side doesn't need init ras feature */
-       if (amdgpu_sriov_vf(adev))
-               return 0;
-
        amdgpu_ras_event_mgr_init(adev);

        if (amdgpu_aca_is_enabled(adev)) {
@@ -3625,7 +3621,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
                if (r)
                        return r;

-               amdgpu_ras_set_aca_debug_mode(adev, false);
+               if (!amdgpu_sriov_vf(adev))
+                   amdgpu_ras_set_aca_debug_mode(adev, false);
        } else {
                if (amdgpu_in_reset(adev))
                        r =3D amdgpu_mca_reset(adev);
@@ -3634,9 +3631,14 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
                if (r)
                        return r;

-               amdgpu_ras_set_mca_debug_mode(adev, false);
+               if (!amdgpu_sriov_vf(adev))
+                   amdgpu_ras_set_mca_debug_mode(adev, false);
        }

+       /* Guest side doesn't need init ras feature */
+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                obj =3D node->ras_obj;
                if (!obj) {
--
2.34.1

