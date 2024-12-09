Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA5E77173
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 09:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB0810E498;
	Mon,  9 Dec 2024 09:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y682iSX2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7942D10E498
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 09:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRM8DJ221Enu+wYosPaYC7/hGuGg6PyC0dWiNPp5QEMkNJ+fT4K8PR7W2WRiYki240eX60m4uLSmaysJRamsU3Ah+vLnvJY4SWPsND3XSVi8/kACIhJMM8y3jUtlbKQZIU7aSAz58Hi2c21Bou8QoT1caePxGRyy57PJf6W38+Nh35+GRpEypLY7vdpP/J6+MkLcYP1bAxhuMML85/J/+z+dFtGWtpgsor1MnhPvqHLpSMRMB4hdgXqLamARJvw4bgt7eJCAkTsDwGLFTUzlxjDBnbzj6oyjHpjmt2DTRuf1fDBTayf/crUedeuS/mIFyB9sbIBmSXQSTMY5T7i3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YFbWt6LsZCu81/TBxY7VQ5jHhASkOrEAnn9V2+G40A=;
 b=EL4RRUlPyFXSKd/cyNHA3+oHFkBwj8qhOpmxb3VrWuXpEzllUSaF1u+dN+KIUc3D3igRgv2tudC9zVvJzuQP9tKXdQ3TKdby8ptroj+uJLdHZ8h5XsCUbTDlQgQ1ozna7f97jy7dfluHf+kJT10h8oF5Ri1OcgEjUL/yNH5RPFPzIC4D1JpCHNGTfNPxMJQB4Z+r7aTBDRto61gY5+FmWDZDr+/wBiMITjVJIQITvozOl+mmm/Tf8/DmsRL8xEh0aN2UmIXhr20lbL/BF6u0UHNdGki5M8v6zD9yWlENMcYWfbz86JuwVAkYP3vMbTsf4sSIgpB4vxgscsxhrGxuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YFbWt6LsZCu81/TBxY7VQ5jHhASkOrEAnn9V2+G40A=;
 b=Y682iSX2pZhIM/pqj8zJcKwOED7ggsEp6X7zxjJ2heVqSJ1OpmdvWQ0lflk2+mVjBuLrp9s3yBTUUKdByyXlCuFstN22Sqn5x7CnXDbQmGMipBcB4HoZgvX+L8KiX0KRfbvQlYwdgRqeGQ20Va/zNEvANJw4G4mL4Wk+GcrgsWU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 09:19:02 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:19:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: improve RAS ACA to avoid binding unsupported
 RAS blocks
Thread-Topic: [PATCH] drm/amdgpu: improve RAS ACA to avoid binding unsupported
 RAS blocks
Thread-Index: AQHbShjZDOtr1MqgE0m4eAyrrKtlxbLdoowg
Date: Mon, 9 Dec 2024 09:19:02 +0000
Message-ID: <PH7PR12MB8796105FC0B6EF80BA4227DEB03C2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241209090038.3255608-1-kevinyang.wang@amd.com>
In-Reply-To: <20241209090038.3255608-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=446ba45d-00d6-42dd-9d71-23206c8a8cdd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-09T09:18:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BN5PR12MB9488:EE_
x-ms-office365-filtering-correlation-id: 68737477-4d67-4f5b-50d2-08dd183285b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eSZ6hXcEcxxF/9qIVAYSurez/EwmU05EYen7zh8umTWZOWNW2DoHufLV2GBs?=
 =?us-ascii?Q?d7vfIweaMJt5xjl5TNwC1y1vUhi8fjTPMBO2p2Cl4CDq2WfCP+kigFEfVX5G?=
 =?us-ascii?Q?722a1LXmCtBy9eUwyhwtnaoADWRVvCkzI24MYqZ9uxVp0MHPH5xijxQ4J13E?=
 =?us-ascii?Q?iqZbre/ezjfFhtX8zD5wC14Z5s5ItVIiwtNW0JF0luLzoQNJBxRzTsYHnNkp?=
 =?us-ascii?Q?TukYmQaofe7pR+zahtSwp0oCZZ9G7EMEsSJdIEj9l0fdKTwLEhbirr/xpo16?=
 =?us-ascii?Q?CH/8wXjIdwZJvZvzaPzJy0PiAk8CVPWI5OQA21NxfvgccAgfXttuGqsStlQS?=
 =?us-ascii?Q?eIx+MWES9KmQkS92aG2L0goydFo5kmz8BotBnSk4SMtCv2yy0qLbaD+Jylt7?=
 =?us-ascii?Q?e6UL4Q9K14/NLsRlp2p28keXe7HffCraCk587zhktcJeJaGPN4NyybsQAYMn?=
 =?us-ascii?Q?bTE10IPaWDttrahkkFJIUGCFJ1nPIvS1MMhMAGdwrRNQ2MBSMxe07UbUxYnB?=
 =?us-ascii?Q?QfV4c949XlUgvDkEhjSovkCyhrQErCRwlswfJ8GybCo5jd4UJ5tQ7U8PapJY?=
 =?us-ascii?Q?0DHqBZXPSJAQe6MBuQIEsoeJNPLz13FVmTGwbw15cy5RV5kpfQj8T+kY+qYo?=
 =?us-ascii?Q?U7aPQot6UfPreXZALZqdlYhCtFobdCiORT/91bC5K9vWsLJGCk4+Tx7iCump?=
 =?us-ascii?Q?/5jPyoUFTJB1KOLI2QUHB9z1p+/M6k2i2Mb8I3jici6KWIpipB2cXz/Ows1L?=
 =?us-ascii?Q?mzLlzdd7i5dhye6RT0hs6B7Le+hjjJEniIVmoqATL02BiJ1NFb37xCv6NaGr?=
 =?us-ascii?Q?Ip+5HncvGeNLoM9FBXGN0preARugKd1rEqs9H7FGYh15zcEDHvNDXKOwyazN?=
 =?us-ascii?Q?pO2CAsbvAiQC8W0VHV2+L08LgO1E+1hs5aEFM3uiQXJKC2O5c4faQFEOT+4T?=
 =?us-ascii?Q?SK4cuYTLGa6+dfZ8gzDgZvsgQnYSK1AJ/yPFSRozstqcF20sKXS4gNfaVHM+?=
 =?us-ascii?Q?I6vr00ZoVlaqssvG/0JOSsydJP3ohjccbwsRdoLuRvGi4d4TeZyC7ujIdZW2?=
 =?us-ascii?Q?A8ue71g6TNnG/wmOH07J+7slVxpY4TiGIvNM4iUxajiWW17lzTPjD1qGMNE6?=
 =?us-ascii?Q?dIfxXxzD7umMwymCURvzKwbDNEOGEDefzcivkSvhu7CTr1N3vnKnvV1+0hVJ?=
 =?us-ascii?Q?vhBpmceIuEAnwBmkLw7z1ulKJLOHvDo4Qv3mqHu8RcELJEzuetNE1/z/PDQ+?=
 =?us-ascii?Q?8XxD8wSND7TDSUenXLpS5WtNEakVc8y42+Dmw9LVjf45df9Fulp9YOQjLZL3?=
 =?us-ascii?Q?fjvsoe1Zh/QSUui5dW+s/hSy4xW5wN9i/p4aZ9YXrvgpBrLX32Xr7C2uIE7q?=
 =?us-ascii?Q?dzolEdjwhPiTT6XkG7r72No1l7M8oObsUJwBcOdtdktu5fqg9Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yV7dm0rTAPH5meJvhyj8jKln2wqCVMOBO/e3/7hr7j4vxCAKsNwGI+wZ6RDI?=
 =?us-ascii?Q?NsjPK1rw/URJapneq0ueH3Bi676aX4LSKlgsf+76jMrDv5zdaTPw6XCKgxuy?=
 =?us-ascii?Q?Mp2F7bYLnlFNlP7SqadNHaKOUIuraHPINPYELGOE1npGJ3qcNmxu/tJm/xPb?=
 =?us-ascii?Q?ZAQbNaB/LJ4XysCqamkGl65WH9e7FAgRWmQC72iKRMS4hsVFRUs4gGFle1zs?=
 =?us-ascii?Q?eqVDw+8tClZ46E9FZRuXZSk1aBzlEquEUXS5I3gbTybMQTt3MN8nnviR0KJR?=
 =?us-ascii?Q?d/SWUJc4+4pTEiPv8xlstaQ898G/dBlDlvIcpF9I/JclIkkTqZRGfExdrAW+?=
 =?us-ascii?Q?yl8SDclUcev8sGjvslPALjLCqxSmqGnUkTAq9q4AgKXzFrWMfZSM662dgwej?=
 =?us-ascii?Q?A6kYSHhPFATA9ujiXs2tMKUJ4hRRapU/zZG8azUYlBA9rc/D79KCHvBc2J2f?=
 =?us-ascii?Q?5Kf9cL+5jofj4IKyirMCN7p5T6gpzELBZYVgir0jMZyrev+Bj1wpeuI/BZya?=
 =?us-ascii?Q?f63QxDX5P0T8YmhtQIFe+Ns/8aFP8JVtjGLPB+nVL1PrHZBQlB2vj9osxv06?=
 =?us-ascii?Q?+uxPMh9bTOsK55hhMBMrgw8/bGfzzbOB73FLpZGlgGdJKw+VhaJ+qb7Z4XGB?=
 =?us-ascii?Q?OBwYZIrOp6kxNYzi36+pugCibOnl/x+F2duVxFN4IoNkyOHXyiK3A5x5MbZH?=
 =?us-ascii?Q?0bX6n5LwnJyzcYUT61T2VdslGSFMNjvEieUplfqhGYungMeKu8zqt7XtnEux?=
 =?us-ascii?Q?90GZvDmu/4BQl1e5pK7WDZslzxHGPxWbm5RiAt1/k4WPJ7Mwge6gCsjTtdBm?=
 =?us-ascii?Q?4he/qvoanLLwi1RG1N+C9FsVYOuTctprc+E8G6F8SwhBBGIvCaujjPfdHR85?=
 =?us-ascii?Q?maiXGnpL7LT/xfwxTwz8xUenfGtMXGcZ2FbffXEQM2r4iMFnOAinidT0OWgC?=
 =?us-ascii?Q?sqretAj0/hHIcZXJmtM4CxNjGdH3mu4OUnzNrTdR8YV+r4Np5JSbMurhpUlD?=
 =?us-ascii?Q?dWT/TeHlKk6YRou+XJdvcEzVoHOyWuYfgwei9HXjh3t4cS6GYSyOyM5u4tl/?=
 =?us-ascii?Q?6Bogu9sEiJ/OHCFLkqVguSrVSZ+Q7BcC3uTWA7ntw24rw6RTostdmCnjOXHp?=
 =?us-ascii?Q?WN/ZqPsq1PywZvh5QBsEzmp8ewxVkzO+SEW1NmchqUKE/mezdGXAuoTKUJRv?=
 =?us-ascii?Q?yAZTNZ6Dc2PDECOHUibZPs3ZtiSvuDPWO6hlPOSI/vF4rkzCuV90HDwJlWS8?=
 =?us-ascii?Q?fl4uSPB8efWyBbiQdVgmKP02A2H/Lj40yEV0TyRKAHyJCbtWP8HvgWVH62nP?=
 =?us-ascii?Q?YEelcOhA14y/dKVoIq/V0u0Y6d+RDFAkKMfVHZ+k7C+f768DCQ2l202NaAlQ?=
 =?us-ascii?Q?/nS4+dTkxwlBL5LY1TxBL4E497S7+OjBUNse1N+Ad/62SVXHq04QBZLxHyy5?=
 =?us-ascii?Q?Y5leElRP+Gl7rIcqTmwJmnqxHwzJhj2tbprYzAaTJNAs4oxfgo+ti3DBei/3?=
 =?us-ascii?Q?xrX/FjCOsUkjEQOcHv0gwq9Bq6kkxS7zKM1qAzTdhUihvQEwoi2rYJFnW6sG?=
 =?us-ascii?Q?u2ndt8fTN/4ox97O1Z3ERltRW4RsSrqATXF5SA91TymR8wA0puo8rPgUsiR8?=
 =?us-ascii?Q?cD8B1s1hWWRem2A0U7wHIvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68737477-4d67-4f5b-50d2-08dd183285b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:19:02.7210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cbabi1Sx2JMxp8s/cDrjaIoBrEwNX7ytAbM+wh5U61bzeQic43hbm03xEhGLpChW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, December 9, 2024 5:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: improve RAS ACA to avoid binding unsupported
> RAS blocks
>
> Improve RAS ACA code to avoid binding unsupported RAS blocks, thus avoidi=
ng
> invalid ACA Bank to ACA Bank cache, and also reduce system memory
> consumption.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index db081618e85c..54426e04c7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1302,6 +1302,9 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev,
> enum amdgpu_ras_block blk,
>       if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
>               return 0;
>
> +     if (!amdgpu_ras_is_supported(adev, blk))
> +             return 0;
> +
>       obj =3D get_ras_manager(adev, blk);
>       if (!obj)
>               return -EINVAL;
> @@ -1313,6 +1316,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)  {
>       struct ras_manager *obj;
>
> +     if (!amdgpu_ras_is_supported(adev, blk))
> +             return 0;
> +
>       obj =3D get_ras_manager(adev, blk);
>       if (!obj)
>               return -EINVAL;
> --
> 2.34.1

