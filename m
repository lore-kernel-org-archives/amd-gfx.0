Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244DBE9413F
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 03:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2A910E562;
	Sat,  7 Oct 2023 03:40:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A59B10E562
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 03:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faMTJg6+bUWpfzXduJ7bqThTWNPPcdB3bhzTogrChLYQEflWQ3Lk3RUhgZ6GEsclw8Yz6vY4D6zDdARW2YUUHwQBKTw+qosZ2aZJ3q94OukI0t/Ooa9f4xEyxrkLeJyxD9GsOYW8dBKjLdnfs0ptW++wf+E/jH1bbnwdTGWSr4guC1L/k1b/fSwbknBUcrHDeTrVro5KS7rYQrYuYSXFQX9uZxssLFMw1eWIGIYIMVpV+RndjDlRO/Z7bXmJ3QSgoZolXXHayhozLYKJ7uz0fdXMJXMlBsKcXcDEOwaW17y8Ho5kFTw1kRh82lJdz05WxhnnpgQcA70ofB+fWGibAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNkq5WEniHTy9KxbsOOX5iKKn7fz4j41lxB5ILzmHLo=;
 b=jZEB2j7OsI5AaEdiTEUq2Gedz4OTJTpioPxZCH9zjfID72/xN15hB7U1YGvw+Jgmt519xFjQJjeytYUbOqdzCuU6CFMs7ejhr8sQcaAIfIph4Qza3mMeKKJ0ty7fBLUMsBW1LitZgKlLJS+mIYCjj8Fx6dFBTIJOfnu/3TDhNZvdQV3bkD5YgELpJUZWrCCCDyoK8/WiUXC/c/Gu+QGS/J0w86PJ0KU75Cbo1AyIh4jHEKX8oWdqUqxDgFyed3PtzigkDgptkaD34iirr1IhwzS4ZsUv80QZE4UXe4DUdTD1BslXBfcfISh9jJjRCDJAY4XToTdXweirBhTI2fNUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNkq5WEniHTy9KxbsOOX5iKKn7fz4j41lxB5ILzmHLo=;
 b=HCd8MdEWNerV0GaHIJHwvyOyIm2+9MKuypZY2o8FSzlR8erfc6MSxr14KEC7elVNFlVOuqYnycyGWKlL/qZCPhuh3CFbVPzqAA75wiT9xNbAjBwY6ilO4W0kTPklvrn9cP2VMV9s4qOAdYWbqHHgbljgOXYZ9Gx0ZI8DPSsfOeg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 03:40:04 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6838.030; Sat, 7 Oct 2023
 03:40:04 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/vpe: fix insert_nop ops
Thread-Topic: [PATCH 3/3] drm/amdgpu/vpe: fix insert_nop ops
Thread-Index: AQHZ+M3MEZjKAG3XxU+Ff8bOXEyt47A9rQng
Date: Sat, 7 Oct 2023 03:40:03 +0000
Message-ID: <CY5PR12MB6369745AAA6E6FB880DA8A76C1C8A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231007032416.9557-1-Lang.Yu@amd.com>
 <20231007032416.9557-3-Lang.Yu@amd.com>
In-Reply-To: <20231007032416.9557-3-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d36448d5-be27-443b-813f-0b4c7799305f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-07T03:35:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB8711:EE_
x-ms-office365-filtering-correlation-id: f175e210-d257-472f-5392-08dbc6e717b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P9/s0ZkvTcSxIGrxVOaAb3/BMI12BZeC/OFT8GYcGovA56uMoeAzuCn3HgJEAoda1NBn1OyEOtN2iu9KF2fi2BrD2exMcNAiAtwTwXTDTrM71qL53wWqFQ0Or9h92Ug4LZvSNZDRlOs5xeTiLB1+o00MrvrWa0sTTlQPIGQgoX27Ow+Ieru4gzv2MPCZkthuf3J5q8kTc5s7x4T2WEvUPJdbuHD783ZaJSCrs0G7SdftLx1Kpu/RXHOHXYZWHNqgBAOpLCUF7s+bHw59/6fBK3xaAWV/oAeSKf/F99eK5QGCwCG8JTNdorO9gIForyuotRG7ZZPkgFpClYKwxXbyXJjxEpZRSMzElYcnZMFqEk0Uqsu8u6vGtcTbyXxMI7GhyNRQcV3hx6tsW+vhlFYACZbGEzB90mrqOpp32gUewlnYy+5NLTI16rv8cxSSTp6EgIN1RVRWYjpHT8D2rbmdbWWGxVbLawuewrMDyjgu0c8GHq9t+Zl4C0sHOKfv3o+qlqj7n2byDM9n6chcwOebBFnZepsOPEMylk0F27n3qNUX6xx1qgtRX5KeyAz3ziQ0TYQSQVo6671SCeLFiNGgwoN5aEbQ87fr641A+RVz2riRPzTKJDMlB2ByX9lQgpOU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7696005)(6506007)(71200400001)(53546011)(478600001)(2906002)(26005)(76116006)(9686003)(41300700001)(316002)(66556008)(66476007)(66446008)(110136005)(5660300002)(8936002)(64756008)(66946007)(52536014)(6636002)(8676002)(4326008)(122000001)(38070700005)(86362001)(38100700002)(33656002)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h/saDDHn5KeSZ4EIw/ek3U2s322JrRtZwMkJBMw0ZUHp5BaJsgzIRiU0J37V?=
 =?us-ascii?Q?DiX5Whj9sczgkea2D//lR6gEgop2/dhpPEux0U133D+WFmGyModTznKtlbM/?=
 =?us-ascii?Q?3hopUcKmRmX0hEojq6kZhu5CYyX/BH+q+rQU+keE2OTXT6YB1L8aa8NJrTiv?=
 =?us-ascii?Q?uHfwQ613g31AomrdfowIR0PRslCz/cIS7bLg+htMdvHTzZDOiggLouCkvLmR?=
 =?us-ascii?Q?J6xZ9ZMYEVDhVmLUBPBltFfC0qmXLSJuKE4QS9Iwd504WPsDBAn38sKFXBDK?=
 =?us-ascii?Q?fxeKE2O7MC5mT5Qd3/Sa4xLNfAm1Xr0XVvBZAj+qDqE/SDiYaGrXXAWDGHfh?=
 =?us-ascii?Q?eaqkLaCAGAOrUMEjTIv9667gmQ9FvXsVW0zjLYxPCqcuiEd/tjz2UxhBc+1A?=
 =?us-ascii?Q?s0Ml4FIFQe4m2LJlNg7x8Ur+vzk4+eJWZhxil7c5mkaYyhf5eq9z9mF+ge7w?=
 =?us-ascii?Q?WSrojVL9taVfNXnMzJokYd/zvkTEgCeMjpaA9cg51DC31Do561f0yg23YcIp?=
 =?us-ascii?Q?xm5GvwtsuTUn8BBJikGWkBG6ndc5LlBwkXkQcEAMuz5d7InZ59kH4kELscYS?=
 =?us-ascii?Q?OXlSu/ISABOSrG9jaB9KJgQLxnlHTaRgJsiTAiVZUlPv43jza4uPObBFTSs7?=
 =?us-ascii?Q?DMVOoEls46a8TN+m/aRD1Y6aW+l8x90BSnrahfE672jLgrqO9sH8/ZGXPPY+?=
 =?us-ascii?Q?pi3iuvRrhkzEwPpuQIiHxVsHLLk0Bbr0yxqIoTUH9xgh0dBndoy459UOM1K6?=
 =?us-ascii?Q?gXc9mxttCnPjQUWIrWDXAZj/8VSy+2peOpCRfRr4zw2AfqtDDF7jThzhxtiC?=
 =?us-ascii?Q?PLOi/YvCOV9hWJG3sbBgxD4ks4bBtyJIuUi+HES2k/ogId8/MlD4fXRgCbo3?=
 =?us-ascii?Q?L1vZfgoGb3asEdg5ULqdi2/JBhYSuALq15qFj4cARNQfnZYeeFLsopbtFeiU?=
 =?us-ascii?Q?gAQly5dfhrexrWLlRWSd/hW52NYltNi9tBZ/rm+KbdueZR+Z7JBX/ww5cQmk?=
 =?us-ascii?Q?uBRBZhHRBq4SqUtLg5KtJ0jKD+mLt5E5LSWdVqMYgXTCPdehR1+qb/hcUnOJ?=
 =?us-ascii?Q?O4GK7Uft9sUSLKt1jfvHdPxtfBn5aZ1akXtNoD8TghnmQX+HZ5hxeG5F1H6G?=
 =?us-ascii?Q?KzExh2j0dutVHlTdy/0ZXnxuhySZXQpQdROadf8FFBhub7cr10h/BEjo4mRf?=
 =?us-ascii?Q?t750etBbBfS+V1TghQUiPOlFdhJxrnaHpR8Y2JgZfrrRJzLJalpslCN6Kc2x?=
 =?us-ascii?Q?GjQhgQw/T0lfvcmoEaAsOgzDDgclGM7zGSYv5OoM4dIGMYgSe2DEd4dZ+dOx?=
 =?us-ascii?Q?a4T9hprkuGv+D6o1ePKCiZ3lQZHt0bL92kpqCKoLGrgeiNNJ61NkLB4GM9cQ?=
 =?us-ascii?Q?eYJXIG/7cacX4l09eWO5Br3T1Fv3rRiDH7unC8voBvZ/JIeYOaOEw6s8Kupl?=
 =?us-ascii?Q?AIh9DOs7AAtCMMYM036PFddpol+MtFIWK4/wO8bJ+nWR/2ZwhJAVTDLbfb1j?=
 =?us-ascii?Q?ywUxPoDYGwrHKnYDmZQexdDgB+atHyOH4+pUMApWPeYpzaUW9g8xYdzS3tjo?=
 =?us-ascii?Q?+yEV2HJ2cbJXnp4iwNU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f175e210-d257-472f-5392-08dbc6e717b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 03:40:04.0326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8ffVSTacn8WLohJoo9t2xEm4kSpvXhTPZQ1Du4qWeSQUx+lWnDUWq4OPdW42KLK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Saturday, October 7, 2023 11:24 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vpe: fix insert_nop ops

Avoid infinite loop when count is 0.
This is missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c
index bb74478098bb..e81579708e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -240,11 +240,12 @@ static void vpe_ring_insert_nop(struct amdgpu_ring *r=
ing, uint32_t count)  {
        int i;

-       amdgpu_ring_write(ring, ring->funcs->nop |
+       for (i =3D 0; i < count; i++)
+               if (i =3D=3D 0)
+                       amdgpu_ring_write(ring, ring->funcs->nop |
                                VPE_CMD_NOP_HEADER_COUNT(count - 1));
-
-       for (i =3D 0; i < count - 1; i++)
-               amdgpu_ring_write(ring, 0);
+               else
+                       amdgpu_ring_write(ring, ring->funcs->nop);
 }

 static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmi=
d)
--
2.25.1

