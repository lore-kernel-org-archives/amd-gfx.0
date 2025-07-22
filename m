Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DEFC83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF5610E3E0;
	Tue, 22 Jul 2025 03:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZeFi1c2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3665710E3E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWQSigMC8ZYkRR4PXIk3VciXaEzoEzh6CYpSoZQB8N4y4zP6D54pkC7cXBDFid5pM0+irfwz4ZFfto6dIef9lvYQIIzgkceHk1jP9YPrmqabD/nRLCSxWa3vy5hkA3oI9/bF9FsZTipMpHhDiYGCkHwQVa0PfiVE44K75qlkvOc4K/w9P/OJ8d0uiFg605qzaNEpSvdYDG5G2KoC52+Trg1kBmU6WkDiBxsJNBZ1mGyybLpbNFpFfIRHU2ZBnZzUWAh+lDvhA4/xn7S/XLhFcX8O+5pODMr9swDqN0+6xU2tkZ/zhkOUt7fd0Dom4vWMOa76z1mFF5T+u4UI0CiBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfVxZ+KfpoNzM1lxwrzjoGmnDme6uOIk1hbaUxTFS3Y=;
 b=q/PUp5qvzk4JCUCMF73RKGfWa2hvHP5x85VRiuU7P2wi7OwIUm7D6lbufH6JMyRdXWvvUja3zrIzHJRJ8BTmGbWoDJicS3b5C5sqA5LpNSzpqfJYAiIqtwzHIFY1mbtu+P6gql6hCa+Xdlf/CKt85ZEiLbAxtuFHTCXqvpKpTMG4Icty6xvFicirI8qvh3EtH9eT/XuvmDQXwhjpK0K4XiGmE7etas8OtZvRIqdMx+L5PXsPz0AcI/LOKpbjNa/9HH4NqfZI5TrCI6jYYckhdFlo3SkwjWbOsvCqwSsrn+emJLh/3z7huqdFHodRjA8+Ml158xtqwKYvRDrJAZFltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfVxZ+KfpoNzM1lxwrzjoGmnDme6uOIk1hbaUxTFS3Y=;
 b=KZeFi1c21XqRoSLOxAI1PAphoYhmCgV7uSm6MzFo32NKokWBL8lM6GUh8Fwcj08/Vjhqd9ysfP8Slz3trtVKMw/WFBj55B27+DpKKF/40+w252/HklzeTDuJciW0pynfGCaxLVnEugFbHX1JnyAx/opYg1jfzVmSE18xi0H2WYg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:20:39 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 03:20:39 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Index: AQHb9p04fojfbh/6M02fXfMrrWtRW7Q9dcSggAAJjoCAAAHgEA==
Date: Tue, 22 Jul 2025 03:20:38 +0000
Message-ID: <DM4PR12MB5152E07F273F9E67DA145D31E35CA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-2-alexander.deucher@amd.com>
 <DM4PR12MB5152FD2E9D0CB1289DCC5B59E35CA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DS7PR12MB6005861E21B050830C142603FB5CA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005861E21B050830C142603FB5CA@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-22T03:06:00.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH2PR12MB4310:EE_
x-ms-office365-filtering-correlation-id: 34ce7318-c5f6-476f-c546-08ddc8cebb6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wrRcQ8a93L+cIWaIFuj0lQmsPL3Pr3DUUA6GEJIwfhT2RnOyburR6hfqSg?=
 =?iso-8859-1?Q?/37qZs1hcQi5U54NEzvrpbsgCWkTTkECMhbJPjGdfNHy/IOz6PST9u3lc/?=
 =?iso-8859-1?Q?bCr8mm8Bzb0HeMVUV2VWjIcY2Jddo3mVxGPKzyB8guAObKUXHkvplmR/kq?=
 =?iso-8859-1?Q?biu9mf11it0m5NQhsDNEvbC5S0F5G8YU6ke5zSAS/CspsN3bciPudFx35n?=
 =?iso-8859-1?Q?CTYrYNfij5Ll4irYMSUyBbKnaCPB4snnMrJLgDmQ1jxoSDei0ctDMga3bf?=
 =?iso-8859-1?Q?0vevlAaVKdlhiqXYpKmGAZ7vH3AgYlKoZmTlkTZVzMqty2i9hWFizgI6fd?=
 =?iso-8859-1?Q?vXF3y/1dmdomzaDLMRvgcWmTBq+4GffBWNsWVDKQoVtyYGN2u7D7w1dhUs?=
 =?iso-8859-1?Q?6y/04GQGixF08JbrUuNaBBbCHIt/JTGoH3MjFk/4QRcg3hb79csJq7niX0?=
 =?iso-8859-1?Q?df/VQSvBnkqhUMjNUscxuPlL9qu/vidtrhFJXb6JaLucTbzOkT0xpjVO3W?=
 =?iso-8859-1?Q?ydRfK+gSBBLS+62/C+Rl+fkUdV+reo47pyVe/qcHAugPDxfgfFyj2k3Ee3?=
 =?iso-8859-1?Q?fb97EWJtahSU5kl1wwb0SKk2yme6d58YWSqdswzbKewN9JACdQtQqcxvUT?=
 =?iso-8859-1?Q?+kFlo0DGk1+2a/VjMw0PuOthbyH8qLjOEwkXLCYpfABBJJgk/VHEw+JIi4?=
 =?iso-8859-1?Q?a/UikBAZJKuuBpT0D3JKgJe0aONFRz+zOu9Ad2Gs42G7rPkf1kGb+DFM60?=
 =?iso-8859-1?Q?7Tl/OZBuMblILCB2ChTIFIflxCEX3guMnfdQBJ5Os+KsPgZcS6fylMVGZ9?=
 =?iso-8859-1?Q?TuoN7DUqynBO7qXxODhrHGraELBZcnO/DHsEs/cQkdLtFqvJf4BothRMsy?=
 =?iso-8859-1?Q?LHvAA1CVgyvuMBNJwom2NxJ/Mx5WV8pAJMJQomuxE9iF2Sw8zhs3zX0SXH?=
 =?iso-8859-1?Q?bh6gfQRS7XGjVLqAO6eMcfFBwfxlFBKOC2rZFdddztsfuNtW7Ugc49yRis?=
 =?iso-8859-1?Q?ffqGhm6+NI9o/bpA+5dx2BiJ7o4SQWGg9ZmEsxQJdRlKf4XTjfpTuj56IU?=
 =?iso-8859-1?Q?h+r/VFegtK4GuRmZt7RpVCDigOHSO/5JBOwHGHnc3j69k2V7OrgLeGy6RC?=
 =?iso-8859-1?Q?IeeXI3/EOGwfxjHS8xqev5LnnT3bUN4Pa/fJKEwrQKBY/buOXgQeCRx7ZK?=
 =?iso-8859-1?Q?kgp+BD+Ya+6VVLhpxdxLAqmPLQsdulfv0OVTiD1iVvtQHI2JGKoU/usCVx?=
 =?iso-8859-1?Q?HV8oEIN1vdu8CNdicthO2OmV3TyQ0XW5V7Vj/IWc+bfCwd8uPBpuAIBUyC?=
 =?iso-8859-1?Q?ARI5ZFsim3fCMkk9BcOVpRhRaJ5vpfLQKv+HajFdbdmfvTVHWPCdisLapq?=
 =?iso-8859-1?Q?tgMXT/vh2AYqdCJLBp63eoLCCgUugTLx+4EjBK8G5BofxjYzX4o3qDDPn8?=
 =?iso-8859-1?Q?HNZNYUV7NrnndKs2b7WNsyOtm6ovnpv0X6DMInGrbnC1wP2Q1jGYBibNS9?=
 =?iso-8859-1?Q?/AY5Fy56cBNy+hFmFgF9HlQV29I9PQ2SHR8nBqHxrezA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?chm5qi5oNBs7tSBbf5LYKkSoRndb5YoxQrCooOcJ5RrqyQaM/og7AMx5Ux?=
 =?iso-8859-1?Q?4RzjSEeceaw5KsS5cLtyRP5pzRu1eZev5+CwvXoqexlHRdIrVd4iuWYn9J?=
 =?iso-8859-1?Q?9VwMu+yuFBkWcAGPTUSpHUQZh0nXOL3vySydySyknsEQFX5KOYHvdIl/Po?=
 =?iso-8859-1?Q?y3NFRBEGiCwRnPdAl6AwwpgVbXb/op0gdmHZ028XL9HBm8MLjvNhp3Orje?=
 =?iso-8859-1?Q?R39mzIIMh5z/CNVxj33G2RA22i7Y4Ty0GUGK1+89h1QueMOkjAfbmCJmkv?=
 =?iso-8859-1?Q?vwb6OB+lRJCd9jTpNY+AMhUDlvM6uM/exIfGgGxg/yCMMw9ZNd3aSz3EaP?=
 =?iso-8859-1?Q?Hgw1nDm47Q7VJgEKRICIlfqng1CO4p7zJ/NzQt6ahC/1wIrPfPzMeQOpVp?=
 =?iso-8859-1?Q?K1ILQudzxckZjrXeJ1HItn3RyhZT2Vuk67sl+TuPNfqI+c4+0R2vDqZBcC?=
 =?iso-8859-1?Q?H9Jxcb7ZzQAOyTbCkdVWmddpr6T7JCjNOF2SNOYdXuY+NAR6a7e3lCtM0u?=
 =?iso-8859-1?Q?2v8duKgymCJGpMywbetKwhGkeWivhdJyOnoWPNpcuyvfkQiRcpmSjIy2mx?=
 =?iso-8859-1?Q?dqEg24uTrHwnS+eg6tVeBbr1hGKaghzkTrJkaxyyOnwherPBiukfo1KsWg?=
 =?iso-8859-1?Q?4J0YOWelv3kdBWAlf/xQ7Dnvu75iDn4nARETKtokAM04lbJpzVfIamLWvd?=
 =?iso-8859-1?Q?BSfrYMwKL+1TTXqfgUOifHn6HxNUpWcS5Tzz8xVy7CL7eMxy/mRptJcnm2?=
 =?iso-8859-1?Q?y/n9fWPM8IKMOyoMiH6P3Qd3PbSCR0dp4hUoSR++kksWXl2sgJNjMMXVAb?=
 =?iso-8859-1?Q?2ArSLcOHyezs/7NaCRY0CvifbzNFRlfLDKb7QCUBlP1L033SoD7XwrQ637?=
 =?iso-8859-1?Q?upLbwXcXO46XMqWUZZ+KHhzNr85VhnpwCgW82SiKZq9OiEGnEiPC1oZe5u?=
 =?iso-8859-1?Q?EOPfprgH4H2GuYdMNTf4UaPeWZ4fbvDXRvqU8WMKX7Wx1CM4UP0KoX6+lR?=
 =?iso-8859-1?Q?O3xRbVWXwTAqGQySA21qMTU/F6FgBArNURf8F/cAyc4X55/gv9vny8M9Zy?=
 =?iso-8859-1?Q?c0y9JcU1oGO0tiPLc90+tMFQZ9GvJjQOZXITRSPGcQ54FVjWA8jGGM7oc0?=
 =?iso-8859-1?Q?mIsDYF7HDc/fKCktDAHGASBeRi3MFXR1yNOhhe00rYDLbbzZkvXdD/UJ8q?=
 =?iso-8859-1?Q?nsDmBeG9XOqCyjQ2B0bZcmqLh+kZQqpZZIcshP0ajCeYGgKALlrUI40J1J?=
 =?iso-8859-1?Q?ZARYFDeOfk3XxnESd1n3ejmuUYoWf28zkIIXX30fsHcLlvU5h27NtbNuK7?=
 =?iso-8859-1?Q?UtzN3N+MamFQNTeowzPqbEf5vCkB5aCKYErRuUzVpGDqHya/jemKsSSjcX?=
 =?iso-8859-1?Q?Jxwe4xYkTQQvHUlE1s7dPYQEP7xMTNdR36bWoxbKJbL0JZIHmPUfQlYh0b?=
 =?iso-8859-1?Q?ZcThXfAPXYvrh/19qXrblbpKZFcA9VqZLIeS0NKB8smD/JpDbchBzZAQru?=
 =?iso-8859-1?Q?wr3GaoBfkTRJX8St9Iy2+kkFsN4R6rRZDb50mTmsr+njlWV3eIhqjdwnen?=
 =?iso-8859-1?Q?0d6r20VPLzYWiLsHnE/jy46WbuJ0YZSvMCR7ycItPOdlEahFDJX7I0UXwc?=
 =?iso-8859-1?Q?m0yHrSwS+J34k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ce7318-c5f6-476f-c546-08ddc8cebb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 03:20:38.9939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdtXnfXMPblQ0wJXLwH6sfKhMGNj+/MPzZR3KbGkhvtBce2SGKcfQCrrwszYJE5863vQ34P8ukBUL4FUXs06XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

[Public]

Yes, enabled privileged user queues and the flood disappeared, and the rese=
t worked.

Thanks
Jesse
-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, July 22, 2025 11:11 AM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queu=
e types

[Public]

Maybe this issue is introduced by the userq mapped to a privileged queue, c=
ould you try whether the issue can be seen when only enable the userq?

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Zhang,
> Jesse(Jie)
> Sent: Tuesday, July 22, 2025 10:38 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for
> queue types
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi  Alex,
>
> With this mqd configuration we get many cases of illegal register
> flooding and reset not working.
> Should we create the privileged user queue ?
>
>
> Log:
> [drm:gfx_v11_0_priv_reg_irq [amdgpu]] *ERROR* Illegal register access
> in command stream [  180.429970] [drm:gfx_v11_0_priv_reg_irq [amdgpu]]
> *ERROR* Illegal register access in command stream
>
>
> Thanks
> Jesse
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Alex Deucher
> Sent: Thursday, July 17, 2025 6:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for
> queue types
>
> Set the MQD as appropriate for the kernel vs user queues.
>
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 372dceceff359..9dd49b1caa605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4129,6 +4129,8 @@ static int gfx_v11_0_gfx_mqd_init(struct
> amdgpu_device *adev, void *m,  #endif
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH,
> 1);
> +       if (!prop->kernel_queue)
> +               tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV,
> + 1);
>         mqd->cp_gfx_hqd_cntl =3D tmp;
>
>         /* set up cp_doorbell_control */ @@ -4281,8 +4283,10 @@ static
> int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH,
> 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>                             prop->allow_tunneling);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +       if (prop->kernel_queue) {
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> + PRIV_STATE,
> 1);
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE,
> 1);
> +       }
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>         mqd->cp_hqd_pq_control =3D tmp;
> --
> 2.50.1


