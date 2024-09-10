Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77715ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A0310E83D;
	Tue, 10 Sep 2024 14:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePlXDzwY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B9710E83D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTYiZjRDx0QaFvMUVguUsCbyE0Fhsf/dQfro87oGGAkF/53cRFzceBmQ0kiVDZEco0mI8l5hDLwHIPdtyzhQsAhDPnbsp39gx0Vhy4fwjXPfG3iR1H0JPn+/daIBEhBPBL5QWLbMVGGvNanCAmJMqGhVhq5cmVCrh3mkIlu38hG2QSiS6Y635ScHwHTV1yxhxJbe/75gx5x7DAiJPcSC7Q43eM3l6xsAPG//uGja2nLam38YmVC8rAM4XlsCKyqqMMo7UHp5CPZzRpAxVZJ1vATntDL2gqB1ALx6COXiIxN3kbS1/3SqXeN7zagEI7KAbuOFA2BVt5gu2B9/EDa7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyvf0LrAmJ189a7Iimgg5c8mrcscSnVmVLPS78Fzmpk=;
 b=expMTDUGovMLgw2nvMC78r6SfZD1QvvQiC2MIUn2E3pbVS3BbuNPX2z47IXjxWyoocF6TgPy9Gl/Qo1IV82Mo5iCocbLsYKqRutIp8bTc3ychRl4qbvAjWxHw1OBUa4iUdqJOvxfCayJhIxIZvRKUPc4166qDTRyuuru4dQ6eTXYkuyDEEDdtpI6tnt55cmp3LCipF2dtatHq+/sy2q63JB0vKS2PwRN0cW+SjBoE3VrHvmxElLcJVpA5WmVQXZgfYgAO+t+wclUd1fxfa1Y+3q5GYBhoTysXY42jQDkRZGC0vpA5uIeweCuWl3g2VjNsrp6XK4j2jnUFnm8lxGBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyvf0LrAmJ189a7Iimgg5c8mrcscSnVmVLPS78Fzmpk=;
 b=ePlXDzwYJ74gKf7jfiTNBWanNF69eyWMfNq2A5+5tgv4vM1zSUm1C0QhyKNAQHWlD7Bs74iz11AL0Xivz5SBXlX9gZ68F4cFX3y4aQrCMS4P+Vge6kXmDCpIFAHY1fk35cGQh5OO4vujLPjfIN5EI1oMa7Tn5b8Ao7+cx1pclFQ=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 14:56:50 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 14:56:50 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix spelling in amd_shared.h
Thread-Topic: [PATCH] drm/amdgpu: fix spelling in amd_shared.h
Thread-Index: AQHbA5DHSAImICvkukWUWOUDq3rbl7JRHClQ
Date: Tue, 10 Sep 2024 14:56:50 +0000
Message-ID: <BL1PR12MB58981D1D282CF1132877F9E7859A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240910144957.2728976-1-alexander.deucher@amd.com>
 <20240910144957.2728976-2-alexander.deucher@amd.com>
In-Reply-To: <20240910144957.2728976-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb1b61c5-bb44-442b-9581-c3ad10680a91;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T14:56:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: bd63cc14-e87c-492b-b23e-08dcd1a8cd46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IxY7MhB9KkG9VAqEuqQOKU7mrzBF8rH/XFFB8IjuRWbkV4ckSU2VvaYRL+NF?=
 =?us-ascii?Q?Wc1fSDf1+38V5WgKtUfAzrAwohBc71N1V8Xkp643wqV71GNnlrPD/JrOKNn8?=
 =?us-ascii?Q?fl81BdLg9neXChWSwh7rGua53fKK+FxXvR1mDa6uAh6NP9J644oWl3fNut6e?=
 =?us-ascii?Q?KSM9AabuvSsYVTZlQ3BvcYE/fMHntEUBeXda86LIbolOvqBQ3U7CQMOcojgl?=
 =?us-ascii?Q?OrEd4RiFDQsCvHfgkRR1D9xWnZuP3Iz5v1XxFqftQ1RvAB+urLsABGuzda7p?=
 =?us-ascii?Q?qCdOddflUvS577dFZLXvStupC73/O0SLCwPkaTACzomLGI32H6by9dNfSzN1?=
 =?us-ascii?Q?I09dlFScbc9vbU2QIk8LAC9soR5em3ULZ9suJ/jbZqyJ3+Q2h/i0yZn0uku2?=
 =?us-ascii?Q?rLI7pirOxZ9a+laaXzfWe4X52T7MZ6HUq3bVKUjsCNLIGXIfnIvpXVbAHMF9?=
 =?us-ascii?Q?5xVg2w2iYGp026n9hKTkjAFzzhkSsx7E5UvEUf6QnZljhCBKRUCMvGHxpcG/?=
 =?us-ascii?Q?rmhyr4Fbq85TRzYDlK4gUggc5ZZrSZK5cyOscTa/8CqyMy5eIqTv+lx9pSmb?=
 =?us-ascii?Q?Z+5G5XUxlWTVMNGJpu5snXTCdoloOi5EjCmekf4O3os7aPZMQLTjkK1Yxsg+?=
 =?us-ascii?Q?I1ACGX31iElqSlWZOsiiB0OVSEa/I605YpY1Qvx/4qd2qU5ZIHWVI1V2+iAR?=
 =?us-ascii?Q?bd9LDVs20fyXu8AQMd48dDXCGRgBiH2nID6XdmsdOBs3pgdWfWFSmjBxlQTx?=
 =?us-ascii?Q?lile5/hRwvfsRIoN6dK6hU1tz6XXB/pGe9iTqoceTrt7MaXUJLktfy8/QaJK?=
 =?us-ascii?Q?ECTL+k10pQSIHGuxLCsy2LR9+DbxRS24kL5OpAFaRH+qObRsIy+22oPbkuTO?=
 =?us-ascii?Q?PUuOdyXNadjF7pKb0vlUkW4/PN50M6fn/aBhINGycsuC1QJcHmyD4fAwR9Zz?=
 =?us-ascii?Q?K1s4JzJjHUS5ysd+Z6TGwZcVRXJYP3X9bcq7n8J0w30jm2wwed57EwYhmo+d?=
 =?us-ascii?Q?ZXrPPUuUmUAT/FLiXAxMxYKff6vpEnyI5wGcGSoXEdVUFW2n3PCb/r7fkWYc?=
 =?us-ascii?Q?1ShL1rmVgZQomUo3B1QXwvWUaxYleFUqbdYEEQftrLALXfl9luAw/r/MLYa8?=
 =?us-ascii?Q?dsly6+J47esoxDTmClLXALR1j0fo5Yjb0K0K5s8zNE5OEHg1G18YPjNEm2By?=
 =?us-ascii?Q?qEJnQEi+afIEYFjnDySJVHpR5xEmYqwKccohqjHN9bHotnAn2RFCFZck2lTC?=
 =?us-ascii?Q?gX8UaSGIVMR5H0CS6GBBbbhmz4PGEnjHAcVIHh8kqzC6LITYpmKzaOa76yl4?=
 =?us-ascii?Q?IfmRVAayjiWd6BiAWHW18tXSHj+94SEDXXl2NoY4wEAgVvqghwpkcGIpV/7p?=
 =?us-ascii?Q?8wZHcQBgSe5VgF/wTx8qa9zlWBwbiPgvkHndHNo/P0OUV4cu4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CHDaRJSqO2yi3D8s9vBXINpLOo/+vRO1T/JrlpTynljRbz7uiN2ZJD7EO7vc?=
 =?us-ascii?Q?U71ArlPQuRuiukVWB2Bxj7pYnZDeGcyaRD2TrjXmpI/4Xfpb8U2HwWdzTQTz?=
 =?us-ascii?Q?U1fptZz6zMcHaOSZwYe6kipd47I7QS/DN5PFuWKEzPJX1qD5QX0O/HD9jzny?=
 =?us-ascii?Q?Ph8mTeXDXVQjtZ6u9fVPnzV31JyNvwvxVaHwDeM+t4D6QP6KuCrucZ1ffFG6?=
 =?us-ascii?Q?T10TdSLbEuYSoIxT9Lm9GUy+AQL/9JB0786VUoSSB0rG8ucVKwtLnfAfeT0U?=
 =?us-ascii?Q?zW+CiLwJiEPzmcRDGtCPXtXjQfeNc9FXtr/XfqemoKuk7USYuk3BPodb9Ey4?=
 =?us-ascii?Q?5AlgBqFSBD/Xb9/Naal9/+L1GrHwr5gj9MpyW1E3gFPReeSWXtYDXj8VZW0F?=
 =?us-ascii?Q?FrYWjBzAPMxeu8JEd8i2gnCVeiOz0wupNPHkb5/9ADGfv4MRrCm/+1TBFiWW?=
 =?us-ascii?Q?w925Ll10QNFSd7PYFIPS2n2QgITyK/GMj2476DzGsDyuMURAQCBhU1lgvZF9?=
 =?us-ascii?Q?UKVG5aYw70yJfEZNC5sCTlqchez53YYsqsKfKcRMPJfi7VsinXTxxQMe31wx?=
 =?us-ascii?Q?CMPoK5w5oGTKQnFANbqZZV2p7i5+FBC9vRSCrZKdZvU/aH6ZX5GRwCQueZxc?=
 =?us-ascii?Q?LJKKdtqlAA0uM7/mfK3PdBINiuioQfMV0ajVHhpl973q19EYbOEsuZW5gX9H?=
 =?us-ascii?Q?cXND9g7C3KxlSm7NNMN5ZLvX5Ephb1ysIIPGsUvkoK25oChHl1j5F8cyPzlJ?=
 =?us-ascii?Q?uSGKrqcHx1FhJHjG+B/OxBzi0Okx6qWdzwlTBTrCUQgJ705oxEAkCf30C/Pk?=
 =?us-ascii?Q?Ex0t4+6c2pmsEOIkXaMsRn7Dh1VAUwMK4juLxz2kx5HS4TrG7INHAX2cVqdz?=
 =?us-ascii?Q?AkWzSUC/TE6nX8vB7s+2JRnVq+8GRw7Tv7Y5RyU5O1lCiYgmZJ5h8+Gi2ZMx?=
 =?us-ascii?Q?I06toqQOXRUsgmC9pMv1upUELDGVrq+MofCfpeOI4jy0I46xxI+xnjWvCcaH?=
 =?us-ascii?Q?lLdSFiSfCfs3L5CIKL22Ys6S0zd1iha2BBXIOgEW2Gjv9T4eyJKr3yWMSPBX?=
 =?us-ascii?Q?RvWbmNLkzWzVs5Qnb8CrGjkpgUqjouWR7MVh0CjTtClttCJuJa0DLdFVbG58?=
 =?us-ascii?Q?pPPUO3M6VUMOqgbYrLXT/bKGa3QeI/Fqk173HFw3Xk8FV+dxBUwqtHbBRwNq?=
 =?us-ascii?Q?ftSgaSB9eogXWC0XnV6YTSe6ZbcMUSEok59or0h+9J13I6vu9vFpQ6rZD9i1?=
 =?us-ascii?Q?B6rX5mUppivU2V2w/Zp/+flbL6d/c6ptL/NdyI5gfmMmAM4qo80ew4LzTF3O?=
 =?us-ascii?Q?lGXLEP9ixWk3nNuITME4VpBOf1mUjID6BYDBReZsrDISDGwyF75S2/I2OfrA?=
 =?us-ascii?Q?JQUJcZZdLOeAwd8upGvV3AE2aaLCeqyiur3qQJCC7lT3QNTasKxRUW3pGcm9?=
 =?us-ascii?Q?uD9Yy4Vr/wKJeSWmnxm1b+1Z3jZ/sl8SC4acGf+VW31L07oMQDTTbmdOBr2c?=
 =?us-ascii?Q?PvEBXA5dd3UGOVMb4k0kus8xZ+RMqlwJY+m6FJZIasA/iBTELX597Ra9SFoM?=
 =?us-ascii?Q?OhqHLJdsDwzXiLUxoLw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd63cc14-e87c-492b-b23e-08dcd1a8cd46
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 14:56:50.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g19UQmWch1GcWxm4frLmoLeJ7QTL0ZeKgL9viG58T2ca1Zh+zUVxQ3PhuqofmWRKi0fz98ApITyOcEAWBE/aXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, September 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix spelling in amd_shared.h
>
> Fix spelling in documentation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 745fd052840d..3f91926a50e9 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -85,7 +85,7 @@ enum amd_apu_flags {
>  * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
>  * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
>  * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
> -* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
> +* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
>  * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
>  * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
>  */
> --
> 2.46.0

