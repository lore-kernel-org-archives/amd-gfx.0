Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0282EC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 12:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E9110EFF7;
	Thu, 28 Mar 2024 12:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20OyhnJV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4791210EFF7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 12:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqLfNU6Jgd+ev+QtN4x9+lQdqsZr1VqjFXbiDPvxBzHle4dYhFnFAhrlyMqEAe4vGvjYY/p22CckmCvftrzCUuMjx4a8wf1LiBlOzdhIJvVGGD3kInTx53n/LziYlzEVX3E2bFCR/q8bBId8ZqVTkm8rTzkQOyJLAol2xo+Icgjbs85vEF9MbfJL6rZp5auvLuKcwqkDCiIRqqjrbRPzAKwYBgWaeWLM8+ZpX5kJNMMY+655+Iw4UnU9b2i1ARJKgmZpX0Id+iFr01/vW2hf5QX3mNF0rAOMRKdvQI5XQJvjerDt/xwKkzX/ooOqPaaWC9n7qFFvIPYq3jmL11SM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgwZQpz3iAOEVRuhb9oy0uykRJptfS+VI8igVgG/I4U=;
 b=QIbE447q19uumEQP60BGUPSczYqG8GMXDJCykzh0nnZ4YWxc1fVevVug4i8+ihO/wA9L5Mw+h6GxyQSqAeec2NHpNOogqwX9Hk+EJuiAXtwJUloKmUmlTwClS4c6hT3AW30sc8DYOTd/hqIVhXfGRsiJfQ/2Zg8tHQ+6X4rtZh2j+Wmvmwhz11XaoT33N7Q9tGFxw3UUkgW1hTq4l/P39eXwqscGOFKoNDppSh+zMjwLaUmS9O+DG+3YwiwV7wjPLP+UwQ78CGwJq30z+6DrcekExvRAhnpPCuWw+yXBGHcU8RkkVQorM/TA7rbvL6A3WePc0YWhzdJGS987eVClFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgwZQpz3iAOEVRuhb9oy0uykRJptfS+VI8igVgG/I4U=;
 b=20OyhnJVi4cMPGrD29+spbLIKsdqP1Ej5Tw03jkZdnhbDXZJw3VLG2IPAIWEaW7gafSuW8pdEzqTtveHMvZrHBOhmx9H/lJkgP3kdy9E3K3yYYE0h4ZyRx+nO+kkKJ6xukh6EDerse315e6SZWkBn3lqW0ER9RaudVYtdcWU4VE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 12:29:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:29:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Thread-Topic: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Thread-Index: AQHagPqfV8WlnfElCkS8fxdz0fIfdrFNFQzA
Date: Thu, 28 Mar 2024 12:29:12 +0000
Message-ID: <BN9PR12MB52572CFEE8455053D1205BE2FC3B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240328102746.365376-1-tao.zhou1@amd.com>
In-Reply-To: <20240328102746.365376-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=af06778e-3c5a-4090-8bc2-f5541e013965;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T12:28:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7138:EE_
x-ms-office365-filtering-correlation-id: 495367d5-6e2f-4d22-6b3f-08dc4f22ad03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzjUB/bPcK78z0cMl162HShC++ycIhr3WzbzlG3JYMVKfHsySRNDKLaCQJuA48lJXUVnqMteSOX1nWfKG7KlOyrYbDzDGUZnBsDTaKTd81z/WEnm3aHMAU5CVZ31qzyjbinJ4CZ2PgkcxtKF3gpQgR4xZCicl/eTllEsvfHUFTwlIDupTy1u6VuB0/GYVoixe+7WuPVaqKijyXgFEVtqkwx1nK4JS1W3/0yzOykqdsbhL11D6M1jHHh+fgCAaYnQS3QZIKOeRRr5y7LKs6RnWXi82Qp39Xze6G2fCfLh+bXzwDvWIwd9cfBk5c0VW0Gd98NIwOL6k2bspjDUrm9b3Eg8OAC64ouFhEmop129CZZ2FH9Cjo0IcI/4P1grT3XCuZ5TM8QsizpHxEeVF9aG3PmHkakCaTWsutnhFWocMVZJ8DmhQXBXqy8wA2WKRmBXClUK/e69fPTeNdQhJn3wCoFpbFOczLYMpbYvyGbmpsUSz32aiGqfin2RMYnQfqUSrWBcdzCQk1L+nOm6Wj3BjtRsyXTzGHgivyHl1BQAgfdJGllu2xANu1a/w4m84aMLBHueXwkUv2SY0yGQSlEd09N8iONI18Bve25SITyovLRsfh/peSOX8zcqRjZyeQmk6Qgwv5hNQ/xgbiwN1zHazjdf+aOGxuYLgxIqR0dQedKC/a/OTNN5V0ThkLxpXRItDJ1sQixgdMAP6teYJtzitcYk8xXDQ60Wlc2vndgQH4Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FEpaPkqplWAArwWTVt3Bx8y+fSgTdgCbqcF16opmF/kg7wdajU0uZ411B5Rz?=
 =?us-ascii?Q?FU4x+54gXHiqXZhRi0eap74ari/Q/aizAPRtzr+R6peezBm2yCl1BLg6c64x?=
 =?us-ascii?Q?Ic50aPodlV+fR47hZbD5FDstMA8gq+1RssUszjlfxeP6avP370QOo58qgfjP?=
 =?us-ascii?Q?ACGg9cnQSOxkEf7eZlz2jEagd9SIzgiUiW+13RN1BUniuOX3LMfI4WIEC9Sj?=
 =?us-ascii?Q?pGmOjPirp7fjrSu2JkDprG73jMEfwuwvTxS44n02wVlLnSFgQXw5Y8Bm/z0F?=
 =?us-ascii?Q?kHJBaMTnZipEC134xOWHUMLSjYisN0+IiAGUSGUe3bvjj5kziRj+g5+V+Wzv?=
 =?us-ascii?Q?FBlWO7zoZ+oDVQ8qdYYmmoHOxcKqEUCPWIjKyCIsSp8p2twYHyeI4u5Y4pxH?=
 =?us-ascii?Q?FDt+AjcW3ljHrt2O9uiXOiMeQmKnFUpn3M2HOYpNlZ+DoZmdzuvEJL/HiXi9?=
 =?us-ascii?Q?32vryjOtNly8VondE6bkOQVy54HVcGFQAKMXRA5NMake4pga3pTZ4+vwAo44?=
 =?us-ascii?Q?1H5aiipEgWnmEkvryuOYrAeW4hWVplgWXh73cPyWHhZY4DT4oampqZT3M41H?=
 =?us-ascii?Q?48uyeBvX7/LEmLatEYkdkqvi76tWSy1nzDKLFxQn2I3R9ZvsQioSvToOdor7?=
 =?us-ascii?Q?VfAePt4bSWlCPSsvpUABI7U1pCsrFtd1OxRGGgb424xBjrFK1dnf5X/9UDMp?=
 =?us-ascii?Q?KHsTqPD0zlbnCGVB0BQHz3FMoxtP+Xw9TsTi5+6fa2TPBVCA5r2zXC1JNsZt?=
 =?us-ascii?Q?gWkj543Z78dFW2r9b0k6Sjm0Fniw2EEo7vZxY3IGNW+JbvHidO+HGc405F9A?=
 =?us-ascii?Q?iWVmI4Zf009J38v+4AbVTd16lVeddf1oNHGo0tpXBth2CWU7ASUZ2nlbSWFm?=
 =?us-ascii?Q?uTBaVJ37f+2bksSpjcjuA14QZh+zGqwxS+MjkAJ2EKJqauTuXOnDyq12BX+e?=
 =?us-ascii?Q?dXCYW4yPj0leHzBURkmtsO4znyAl45ogBmJCi2J/H8XJB8/l4yaU5lpdecYV?=
 =?us-ascii?Q?VMGlDD0+N9lGzoOn2x3NbkwZgwNevC66lObgPJIjx4QXRKIfNA2hO6KgJRKI?=
 =?us-ascii?Q?kTgPCg4WFCP6CJzk10mKeMAXmsiepa4DkraByY/Fw/UZKWJlysOgbAOFB+H1?=
 =?us-ascii?Q?UT/pwtVEA1qnWT4LK9UQyHI4ASgimy3AnPUUXW4RuyS83mZfhFhSWn1xU04z?=
 =?us-ascii?Q?auuAj6Ica/8AseTFESxzlZ/0SPGSShdRoYixuK/dpwxhon0ajnvqrgTPXj5d?=
 =?us-ascii?Q?VOZHLGyfb7pSdLomwB/iRE9X5WneEYXA7ElwpfbbAXv11NcZeLBolc1HgQNL?=
 =?us-ascii?Q?kQAluZNqhML1+GlAFYRqgm4dH0496resbZUSot8A7Z0ay5ge+9pe9RiA4sBo?=
 =?us-ascii?Q?BQ38AyzwC8yqhrWEpDLLsANbnhESqqJe9aicQJg8aqAzPJOdAmg/ZfaII6p6?=
 =?us-ascii?Q?yWo7mf3Zbu4k900Nb6gWzqaOVpIgDQJsivt5klRiUFpMf32bT6ZxOXZTS/W/?=
 =?us-ascii?Q?4k3IPyN9uL6oO7Mv+OAVrTCJ9BJ+flZOMqaFiXmJ+c47B92EEYr3zfnE6SXK?=
 =?us-ascii?Q?+zD0+twoVQJwpWiR8Q0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495367d5-6e2f-4d22-6b3f-08dc4f22ad03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:29:12.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRF8rZP8UaYyDPUUI5ah/kOpgGH0NOTBTLHetA0vpsz3xyu0oH8vDckgBLxcQ7nKvSBt3CeF/LT8kkqXIDEH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, March 28, 2024 18:28
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2

SDMA_CNTL is not set in some cases, driver configures it by itself.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 71c2f50530cb..d10ae4ce5ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1608,10 +1608,11 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amd=
gpu_device *adev,
                                          DRAM_ECC_INT_ENABLE, 0);
                WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
                break;
-       /* sdma ecc interrupt is enabled by default
-        * driver doesn't need to do anything to
-        * enable the interrupt */
        case AMDGPU_IRQ_STATE_ENABLE:
+               sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
+                                         DRAM_ECC_INT_ENABLE, 1);
+               WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
+               break;
        default:
                break;
        }
--
2.34.1

