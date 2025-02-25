Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0476BC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 11:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40FC10E637;
	Tue, 25 Feb 2025 11:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tqRXb+o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B3710E637
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 11:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHvmwMf1cqvX+lw3VO1gAzWJ06xkGUImmnZlMczpeFrcY56S1sgv0SJ8ykTTWEU13yC33bGro8bvxMKBtPXYNhtywGb1kjk7bnLLsK9J+NzUB9KjZOTywU6K4WX1Bf8Zsz529fm2Jt6xoy+3fj7kn0at2zfTDK5yGEcxnI6bDSvUUYD3ASbvb10lKApUxHLlk9HpC9r+ff0TC9xmyvuiJ69S+fFP3QHyN4ywa/OARyWww0tWP0b+p2kg7WRG+mnHMG4OmrfNEnlAmmTTqdcTIHCM7txJXF26j+KsswNLaFab+gDv04OjNlAxgRBO8dpvlJEjnUHnsUXqaGJuKSXIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dMdAWNEfaeepba9/51DRiplFHN2Af5JNK4X6zCppwI=;
 b=pNtnJJB2KiodUSH83hP62Zu8FkdNTOGzkBgMzEloGJoJnatCjF/v6k4UY+YP8rHvba2EnJ5TbcbHjXP9lDuSI96ARNbV/xH/IqDM4rALuvJ2jhpLW0lq/pLbjFazA2hQzdR8fGHJhtgX/EpEOJ227gGdlAhFJ4QSDNY5AP3rx5Hj9zV98JVyeDkrDPZ/lFxATQ5DnQKedAEg6Coxs6dlQMIPPQ5MNU1kvhNVA5xvygtU3LZu75pBDATa3jIeAn+yqo+/kJWvgSGCFHReiEQx2wggKVurIFpsWGrnwDLdXwk23cb7NT82pOIn3ZOR40hcARfPnFWSaEJAUOEQj/fm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dMdAWNEfaeepba9/51DRiplFHN2Af5JNK4X6zCppwI=;
 b=3tqRXb+otE/zGKrTJwWaxH1mHMNqAcbqqKYWUrxLyfssW/pZTHiiUf8C5WccqRrDpLGZIizIUgXhGInk3cZPR8A4o6C2XWnHCAvXfsNqjYogetVjuDzz0hKm1QTdXNQ2vADEfKOaNlxXsAc+ZJWctc10566PCd7S+mG3o28JqpU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 11:22:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 11:22:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increase AMDGPU_MAX_RINGS
Thread-Topic: [PATCH] drm/amdgpu: increase AMDGPU_MAX_RINGS
Thread-Index: AQHbh3ditsdaXP/FMUSzMIy68JUperNX4DQw
Date: Tue, 25 Feb 2025 11:22:53 +0000
Message-ID: <BN9PR12MB52571328EAD59061D1FA9FE6FCC32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250225112055.253865-1-tao.zhou1@amd.com>
In-Reply-To: <20250225112055.253865-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c851908a-19f2-461c-9ae3-fada70e0ed96;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T11:22:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6265:EE_
x-ms-office365-filtering-correlation-id: ba9cf249-5fac-47fe-e5d4-08dd558ebef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XbMHTfaAzQuXW/C675B1DRokOj/avtRA1XaOJ4wmqDuePY5LqLtfhg6IJgNS?=
 =?us-ascii?Q?daGVQIbfup2RfflT17aP0BBUnXo27RGsmLhZYl2+McMkgMVvtzKw39dKagnt?=
 =?us-ascii?Q?h3kXb4NKAqeZZq/bzoSfNpFX/S6kgbNv8BI5wbUoRCgzcV076XuR7nKzHGgI?=
 =?us-ascii?Q?jj78HwSd0MRSMUGnzIKxZnJc93Q3TGapO2uaoMCyNAGbSglg1jz3i2OT14Sk?=
 =?us-ascii?Q?sjgsHXUPwpteY0Z0p3i+ETf6tOHVYEFnOHeMbKplRaJCruCWQnpscHWowq2X?=
 =?us-ascii?Q?b/f1M6eDeUfVGoYLbrpNGGrXZh4LL6uHxqIeW5YpSeT7kmEnhLlTBbMZQKgH?=
 =?us-ascii?Q?xIs3gkf05J4Ea73AHr5s/TIeQoObsOY68URNbAmrlFg3TX3yy7xCdTIAlX16?=
 =?us-ascii?Q?6i5T3VjspadOJETf79RVkykuZQJuNj2zLiVbyhvDNA2oSVvFtO9H/b0Cs5g+?=
 =?us-ascii?Q?D9cQ8WBIJsqtCJL3PbmjdnQyFk7KjRHsuARwsoHWk6uYBYvZKqO2qG82qV4Q?=
 =?us-ascii?Q?W2Migifqfdx4PeahpeRoPEZuKr2Ju/+lobWtcJqMS2r3j7QdGE78NmeWln7K?=
 =?us-ascii?Q?O8su4rGWqPN/v6PddOpsRJSN/cGckxNFjObJmRLZ/fTcAipTItAe/OMPvLFX?=
 =?us-ascii?Q?9+AODmiuwwhWcN+ZqmZsWIeIPisZIvHbr7pJoY3PBqUnhby3lwhZWJOhrcA/?=
 =?us-ascii?Q?0UDeCU4iB8svO0nysKXzPTKTyagvrvUdDLlGKD5SFyV09zafax4154tJLyYo?=
 =?us-ascii?Q?I6f3Ir4VM2+wBmO1PPFGe2K8Z2VaSyL+1ui4uqvLo4kZ8dVrTMMSm3W4hfy+?=
 =?us-ascii?Q?wS49s+PlJtU+iLuygCVIOF372YQrj+TgP40iBTFPR7WSPtBWfk9k/rEs+WNV?=
 =?us-ascii?Q?QA91GDTbqI8L0oCzduqEnXsUaw+8Qdh1rBfyLNvg5u7vdyLNrvZ3lz74cc6I?=
 =?us-ascii?Q?XCrFRIesBLwwwJl2hNupmS1o7CTSc+xS/ToNmy4zXdjYflFNfPPNwlQ2+sX1?=
 =?us-ascii?Q?H1zzh7fDncW6hPy11Lj11cywBXzHAYFJi997pSrl9uygy1ow31jlRdutHJjl?=
 =?us-ascii?Q?9gMvN/+0ocHmybNVdxCiOwFBjYTmpDNflDYOct3K68HXm7EwomktpR3sPOHQ?=
 =?us-ascii?Q?0yLchr2P6aPbCn5QUulRFKWTKdX/iRKO85XIZgQLm3UYoRs9PYqkdF0WrZf4?=
 =?us-ascii?Q?/bNZrokto5gRcLwBFvW3pCBdaCHB4fv7C+ylPXYkEyh670EjbPFK2ASTLKue?=
 =?us-ascii?Q?VYf3DpFakVpTRs/6PIr6qfhsUB1XqJCxqJfgAKT1+cdG+WaHGyeWa514/R9P?=
 =?us-ascii?Q?pXG5LBo2bHnNg0HJZWXGaIaNNzZsRQ4KHlK0hmxwAVoLD6UVn9AQyENwv5qL?=
 =?us-ascii?Q?pNBrumeWFi71n8GsWcQsrU/nUr6GXc6uXFH/gglfa8W+MRma25bccHbYRUFR?=
 =?us-ascii?Q?UbGH2XPQ5iLYOk+bU+ALJRWMP4HMzwZY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiydh6Tw0Xfd4miX+mzGyOKvQYkGRDhE1iFYPmdRjrIe1kg1heOEiHhNpMv/?=
 =?us-ascii?Q?rcQqi9lIG5ux7shB8kjdCN1p28wV8a4kTmub5mpwdhrVLECh0NOW5zSsW/KI?=
 =?us-ascii?Q?cC/AwsN62kbAV+Mvb/TSE/d+tYno1JrN/X4/4ZAQQ/sd2dPvd6TvoFGFhVll?=
 =?us-ascii?Q?GctKAjh11fbvnu+zWogLQsH+6jF+uWo+Tq61sNBvUBQcodV+H7YAoE/zxm05?=
 =?us-ascii?Q?wqZhnjMeFbAiaRiZs5WbSM8rdhERakDnpHVPasVutxGM9FUAF8uLgPTjbMEq?=
 =?us-ascii?Q?/KTKSck36F8ou8bZ0mH4z/Aqg+8YinTRn6Uw3RcOLImahlwYvU1ZsnbcA0kA?=
 =?us-ascii?Q?zZRyrmiJprEn2hzE3E96Q6apxWrSWM2z1pZMmUp4TzQf8xuC1rOYm/utlBz6?=
 =?us-ascii?Q?M3O9xlPY9S4vT0/Lofkl5Huwgz5+XAon+Q8p0i4uUVJkHAM9k68va5O6EdJe?=
 =?us-ascii?Q?RMrPOrbGdMpoPPhRbY3iYTT/yJ+Ga4MmFo7eh0wxe+5GNIKrEiIgwCU00JVo?=
 =?us-ascii?Q?cx8LNqplmtGMgkoyBqjhkfc+IRMYzUSeQmhdjBl9P2oxNCHVAy1DpbTfujuR?=
 =?us-ascii?Q?YReWP7/AGJU6kr0GIAiRkK0khzRnuQjuzubBhp/7rn1towPukSd4D8ROrCx1?=
 =?us-ascii?Q?JfOjRhuIgesDcDgkK2GaI+JwJKQQmtcSYRanJxyKmEfHidF1u4H1IC6/BJAY?=
 =?us-ascii?Q?Mih9UJaQLzcA4lDZTPv9vffhm8Xh9D3dfgzFpm2G+/Q5irNlPvvYehA+jGUb?=
 =?us-ascii?Q?IjJPpnZWeNwB8z/TmYeVC5aAJ2N2Naz4xP1Szf/gg7QnVlNMn1SpTFVznxZO?=
 =?us-ascii?Q?S1rEsVlpBPByZIJxSeXMWirvNI0l6G5gc+UNKWNx5o7VLtSZprL0s3OR+ZJG?=
 =?us-ascii?Q?6ztLSa/wGhYgkaFTgbxcee9zTyU4Wy/yOo0WfD818AiTnOGXx27RgOJLCrm2?=
 =?us-ascii?Q?sPnAUWr3Dky5RdPjguEzArcDTiSfNb0Hf4sO5AS2MUvoz6CIf/LCgFMpYATZ?=
 =?us-ascii?Q?M+FZ5NzgN4y6x/G3EmP9H/ycFgnMrjRKX3MM+evHF/Xi5IfiqaZbGzp/itr1?=
 =?us-ascii?Q?YQHBFAF3WbZbITNnHtBK/GpHUKNJpzNtwyZHa8ReL4yPx+dXLZVVDEvYdTxj?=
 =?us-ascii?Q?fgKZ4H/2h5PTDWoNTubm0VBKqfGW//NxhdXrbIZZFccfuqcVA1yl9sB3OIi6?=
 =?us-ascii?Q?3yPtaU2u2l25rjdl0hKRaGpGMJ90t8tdALd5UeGqEZ70/L+FFj3fDxgcpHot?=
 =?us-ascii?Q?G9/21tT4eJ5+Zj5JXiyM0tpk6XdXPGq0Ktpzc0NGqihgaYmeIbXGdirJu6ug?=
 =?us-ascii?Q?nHnosI461nUHLHZtNFI3gMc79bWOhXgd965WYjglCwQpxtZWBmUevEYJ8OSO?=
 =?us-ascii?Q?Rvk5oK/nIJdlrbfnrzf/ZWXc/niDk+RZf+oIuzJoP4rMCArQfZkEvtMK87Gh?=
 =?us-ascii?Q?GyDsHO8TMc0jruBTykeb4/jgs12xwj9svD5lQz/5I7QBVixf58yx4vWZEH0I?=
 =?us-ascii?Q?1EAohd0RgpNzcg9xTCSpqbiWEKpsKoM8FhBqmZhW69HVdNnshnjymYHcS1k7?=
 =?us-ascii?Q?ylRkVomZLipuxQktwXo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9cf249-5fac-47fe-e5d4-08dd558ebef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:22:53.3484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABXPN979ESGqrA/eSaKel/B/6fKLPCDyZjbmwlHDecdOIhezVR4ZEaj72cRjoqbC2EtnVGsOOJvXzpFl5ibVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, February 25, 2025 19:21
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: increase AMDGPU_MAX_RINGS

Increase it since a cper ring is introduced.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index 52f7a9a79e7b..b4fd1e17205e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;

 /* max number of rings */
-#define AMDGPU_MAX_RINGS               132
+#define AMDGPU_MAX_RINGS               133
 #define AMDGPU_MAX_HWIP_RINGS          64
 #define AMDGPU_MAX_GFX_RINGS           2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
--
2.34.1

