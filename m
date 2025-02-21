Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D92FC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 06:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82FF10EA27;
	Fri, 21 Feb 2025 06:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUYOPtuz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB5410EA27
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrxUAaTREiy7+y2jssn9w0XgbdGknSWEksSLLHbzXeSUFBfOQYnGrp5F4njxBOsF6gNf4v8ljyRvKbtbxW/7h6fML9bxJpzcmSQDqCG2copJlP20ja2jRonQQp9/i7lOJiX0bOH0oDUShIoMwnf+sdC98jXrwNaQOyFs4rG8sXxUqWK+v+BvpLqH4wXroOQS2qz0qxWV1bEgFve6INlyX+OtQu9dEeBjxJxa8guHsNGK/6ywvMrIoJ79nmkOcMw/thE5UbdZum2OsSU+Wrm4vGmq+9DJYULC9D6yElHAnwr6kSJzF9K4jHY3IiBRad9jWL6F9cIhs70346xvP6NFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYlrvwvyua+2PJLJj9TLvyVYyNB5GLfLN6d0PPiEBFo=;
 b=AVoDqYGXXCGUv+kPRMkU+e6CsDTjW0wUSm5spRGhsPRNxkJRDT4IUSTc7JM8ar727CIvhyxOaVyU/zycyQSVkTnZmoGQ9vk9wNQFWHhI2y8gwlj3BlsNrLGa/qSt8lRQ7fLcg9zJjE+yzgraX2/U0p3vxQGe/NVyIt2fGBtRrfOEtt9PBaEWd6JXs19v+KN0AalY6luGXAElYqyqHSrrgGs50K7S+OFAv2GHHdoQhitYW60Qx6D3YlPZsUCflybZ0YrojyUqiT7pMZWOYVeo9RfpU5LP/JAYNcv88aP2y1GoBkOMN06MRRpX82CJ/oja0Dy9nmj+FaARQmuafy3MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYlrvwvyua+2PJLJj9TLvyVYyNB5GLfLN6d0PPiEBFo=;
 b=YUYOPtuzGcnpST4tE1fqQI4BaLy5gAZ7X4DUGj4M5nRkaOTzAMmurYXV2Bdy8G/JOy4XmCC6msPzRwgDSQ5Y4+dJOkHFlnGY6F3XczMSNhnca8wUy7vERrfiqBRVPN6mFVRcjvGepz3hM+fdmg9hPRUuDXLsMd+qQgAMyfhOx6U=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 06:55:04 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:55:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbfqUiexQ948raQE2ivyVTx2oRhLNRWWKggAAC/oD////hcA==
Date: Fri, 21 Feb 2025 06:55:04 +0000
Message-ID: <CH3PR12MB8074B6D820E9EB87E2A914B3F6C72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
 <CH3PR12MB807461B879AACBBEC58C137FF6C72@CH3PR12MB8074.namprd12.prod.outlook.com>
 <DM4PR12MB51523034558B4EFC8C17A983E3C72@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51523034558B4EFC8C17A983E3C72@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=724f0133-5a94-4a8d-af95-122650348d90;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T06:39:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: ba4ace2a-4fc5-416b-8d2f-08dd5244ab84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8gFHzf/978EN+CA3GTuSZytbmmG856kKf/t6EibPrT0x5TcholWMPRgEo8?=
 =?iso-8859-1?Q?57O5/i39AxAhpQ32ShZHBBBota+9SWa0UgnsQQJ+cNY7Rr0U8Y+tsmzXCX?=
 =?iso-8859-1?Q?qG+rT9/iPbyJlMJsF6zN3bY2Ik33UCCoJ2rVrKTnZRqWv2Mz3wEGugtpq9?=
 =?iso-8859-1?Q?8aQDa4548+kY/0EAUdVYqWmITln4f4b8Ltf0IyqRAxmPkzAf+9fqXEUTvr?=
 =?iso-8859-1?Q?VTSMoWeOM0+6GMQe/JM+PJ2kZQhfr0nUS5D9geuz9T8CVnHzAwsN3eGtDR?=
 =?iso-8859-1?Q?yCP0/IrlQnKCZeFItSgONFJre0kYpjrdVEJ/iWt4Hpn0u4KwC6AY4Y/Cma?=
 =?iso-8859-1?Q?D5GqNbhHr20tIa2Tp/ZroDaZfroPVfd6W0a9l9q4JYAbrpWdnYWuYkIRsB?=
 =?iso-8859-1?Q?ySDwVEoXA+0L1tYsVuy405Lx6teG9U4O1V+BSq1gHk8Z31r2sd1qcq/U3A?=
 =?iso-8859-1?Q?rXAtuExsh5UXrJFw/lpDnKdtEBml1E1mZSsUtCQJ+YaNjCK1nPNn4rzJRm?=
 =?iso-8859-1?Q?zb+ADzk3CTGWzJ5Sg9oN1UVbMoyPodDGPTvuUVebc21RwBRRr/R8PNoBeu?=
 =?iso-8859-1?Q?xXRq4xAAe75bFiTmgao2Lr8/OKFofzhiVHhGzuMFxuAaNr23lPHoVUBHt4?=
 =?iso-8859-1?Q?a7Ry9gfI7aS/OrDPcOQ+5aID7+C3EzrOK55TVsFQrB2TNiUfvYgs8sGWJG?=
 =?iso-8859-1?Q?s6UYQBsqFkV/abxE9Os0IAcOszeCFJdgGLpn4RDv49izDt7DJMcww7xcmL?=
 =?iso-8859-1?Q?lk5vDcJItnIL6QX0AW/QEiDPzlBIjRtvy+t/k+cqZuHh2Um9NAdcx3xjPW?=
 =?iso-8859-1?Q?gLgCt78E0T+ITCQSa48kQsmoVnRkR/B7hAp7QKt4FN8+XhyNigyq0/VmSl?=
 =?iso-8859-1?Q?1ijRUOhuAui1/ZkjFrtAHV5WPsKwTIDgl3lMVh5Wtu4KQEYIX8kv4BxLup?=
 =?iso-8859-1?Q?Ik26um1IoYVam+PZou3KWtrz3r6JhfKHKS8R3saBk+0OWS2D2Rt7JzULmr?=
 =?iso-8859-1?Q?sNMzUF7lxSdc7BPS3AESBW9olXC2LMGbhyXZGFiYJZA4rRUDtkPn6a8fyV?=
 =?iso-8859-1?Q?VGgrfMzVTpF0wZ8YLpA+KJXDtS/OW1tr31DuPz3lROYumAHysw9+lt2Xst?=
 =?iso-8859-1?Q?Z1jaoAfcT3rtYanmHgQjmDmwVA0Tci9ju6aDRvLy4vjgK3joS1Q0Hyco4+?=
 =?iso-8859-1?Q?kBoigeNoMFdnp68V9fTma8gZNop1ITaEXUGAHVyQaq70flgJY6Jcmjv/d4?=
 =?iso-8859-1?Q?aP5Lcf7ck5Z0M36SjiKudJWsicj4RZcrnhTETIiZxw84b1ODPSr56qNb+c?=
 =?iso-8859-1?Q?h45XFlY5tsiY/lsqXI+rC1Ph33pxDBAD1PoGvRXR4Auz8e+v2Yki80yjME?=
 =?iso-8859-1?Q?cNupYWsuUx6BC0vuXeuNUXGHRbIZrJRS2XO3R4sW208HOr/JpoZ61+zmwg?=
 =?iso-8859-1?Q?EMwuTPbRAt95MgxS8cnxBFXbiDiCEKRfQICVmC3h+O4FQzupaULq1Bew6m?=
 =?iso-8859-1?Q?D1Mqq1a73xsXcAE3IrFEif?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9c3JqAFpzU1qwFx9ePPUJJPOXUfR8BEm21D4cyE6sTIeqsKMS4oZlK14fd?=
 =?iso-8859-1?Q?qRmQ9GWku8upzrRvtaxs8t2zHLVDsVyzrjqhRu22CajN2JNvYje/6YFT4j?=
 =?iso-8859-1?Q?GOeryOREiTf2Eflfv/bXqEb8TEUR5RAXFCImEiSzNv688XbPcSJDwCgA3Z?=
 =?iso-8859-1?Q?GgMCV2lXubNK/YkCM8OcQCB/+Myc2qpT6W6cMU0LFsEiu28vRrslHrsnga?=
 =?iso-8859-1?Q?lj1HmHqR3BCbEtTT0toMbrIGlCpVsAf/duJZpC/1sjB9e9ZN6PkeSzDeU9?=
 =?iso-8859-1?Q?8GzOWq9ZuyPxp6Z3Qa6ejm6BfCsBjf7iO1s0/cX8w+WubiMZcFWA2T8aNv?=
 =?iso-8859-1?Q?+0Tf2sbhnEYSQK57ZE+hg/NSiHJ97VRbqje/z/nh2gM429jygfxYubHgBk?=
 =?iso-8859-1?Q?WF0WBIeMD5pLyaXY6CK+LT0SarOPcePg9Cc5Vre5fbMRAxvQOvimc7LVM3?=
 =?iso-8859-1?Q?KGWyLAX6MqwYTLXJ8rHFPdBptkP/FJdSqMXSAs0OHFOP9jLObZTU8+gRxI?=
 =?iso-8859-1?Q?etRfJp+FREsLyGP1CjZrCxdwbIm56TL8vN6wQmH3XOmdgc6C+UH9g863vd?=
 =?iso-8859-1?Q?RcpW1FOif/lmBXl1tkmawGYQru2twEk/KVDSO9Eu7XTxamZi09D0xCj6S0?=
 =?iso-8859-1?Q?LYnVJJLi5OGqf5g7QP242A+/kJomtfyo9H/PomSmQUd+VmWTHMhbOMUIVC?=
 =?iso-8859-1?Q?xbBB+wmfTh1SY8TSlkLTxEUJgqiQTo+nrsEqBd8UDdeiDNETEu/Miw4uEb?=
 =?iso-8859-1?Q?+pQjfSZi8Ix5rdnWBMtBHLvwnsufj/u56/xmFiJOcUsjuFLo5P2V/CE7M0?=
 =?iso-8859-1?Q?FG94a7SMVdabw9+qwJpYzFHJrpzkahN93pjUQLDmGrqVHX6PPjBabzZrBN?=
 =?iso-8859-1?Q?5MuppJTg5+nXWP7PlMe5ZG0iy4cTo06Zn5Bw4GFovKHcGPovsjrO36+t2z?=
 =?iso-8859-1?Q?yPUS0M3uK8Pd5fBi4/zEDqdiMpX6AkZ/ql6ZPRoDPpP/BnU1igqFNoIIJC?=
 =?iso-8859-1?Q?oO4qV3Vp07NGdiMTAvNgytFHBKvM5rJRE+Zls8NhJd6vKBJUEese4lrBV0?=
 =?iso-8859-1?Q?LouC13WHZrXsSxRfoeHGO2Zi4/Va9Gi1cwDSPsBBodUpJlsfEa41akb4fq?=
 =?iso-8859-1?Q?96ANyIsrSinEyjPIWL1MzE874mPvl73VynbuQo8C+4VntizXBbjrtEGEx0?=
 =?iso-8859-1?Q?g0FQD7zHaYWG7N5c3UT9mPyYBSQwAQz6zqWhk7b3koleq8lCazpf4XOdd5?=
 =?iso-8859-1?Q?PqAHp+xKu8l1oS8S8FTZ7WD+y4eAcBPnDO1iqrtNlKqDQhKdTNPhMXC/tG?=
 =?iso-8859-1?Q?mnTIjIr0+Pb7/Sl/H79J/+VXAVvBSyjwBo1C0chE6iMUjY25H0L4u+CqNh?=
 =?iso-8859-1?Q?yiv0XrFSaVoUKeEpFT0TivlX2odtxIf1fvG7xpls+2xLx4nRlwv2kWZ6DL?=
 =?iso-8859-1?Q?/sk4Ppom4wGdjDbyvQkOhU8OPm78jGE+bKexkiyO9B2CKzaLaSRfF8N54r?=
 =?iso-8859-1?Q?8grkG+pDRGxtw4pN/y7ED2Yj/IZ2Yq1/R/x+nWTPEU6uJT+tllyAAvnlvv?=
 =?iso-8859-1?Q?uuFWul/NfDdXtQCNZstj4N3c+3ITmfNtIqPe4oZjvofxHJ4dugIhVPyn7L?=
 =?iso-8859-1?Q?GjIntCLzxgsuw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4ace2a-4fc5-416b-8d2f-08dd5244ab84
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:55:04.4734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOBAvwNJaqo52oE/v/cbHbmaXqoWyqMbdmjDV4ij8YtweaHnUfmmQmxW4vKNmN143TD2pyIHtxoQZipHVRfFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

Hi Jesse,

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Friday, February 21, 2025 2:50 PM
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Prosyak,
> Vitaly <Vitaly.Prosyak@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, February 21, 2025 2:46 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Prosyak, Vitaly
> <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Jesse,
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > jesse.zhang@amd.com
> > Sent: Friday, February 14, 2025 1:56 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kim, Jonathan
> > <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> > Jesse(Jie) <Jesse.Zhang@amd.com>; Prosyak, Vitaly
> > <Vitaly.Prosyak@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
> >
> > From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> >
> > This patch updates the SDMA v4.4.2 software initialization to enable
> > per-queue reset support when the MEC firmware version is 0xb0 or
> > higher and the PMFW supports SDMA reset.
> >
> > The following changes are included:
> > - Added a condition to check if the MEC firmware version is at least
> > 0xb0 and if
> >   the PMFW supports SDMA reset using
> > `amdgpu_dpm_reset_sdma_is_supported`.
> > - If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag
> > is set in
> >   `adev->sdma.supported_reset`.
> >
> > Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> > Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > index b24a1ff5d743..e01d97b96655 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >               }
> >       }
> >
> > -     /* TODO: Add queue reset mask when FW fully supports it */
> >       adev->sdma.supported_reset =3D
> >
> > amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> > +     if (adev->gfx.mec_fw_version >=3D 0xb0 &&
> > amdgpu_dpm_reset_sdma_is_supported(adev))
> > +             adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
>
> So, we do not have SDMA firmware version dependency here, correct?
>    Yes, sdma queue reset use pmfw interface, and it only depends on pmfw
> and mec firmware.
>     Jesse
>

Thanks for clarification. Series is,

Reviewed-by: Tim Huang <tim.huang@amd.com>

> Tim
> >
> >       if (amdgpu_sdma_ras_sw_init(adev)) {
> >               dev_err(adev->dev, "fail to initialize sdma ras
> > block\n");
> > --
> > 2.25.1
>
>

