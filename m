Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C9C021B2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 02:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB0E10E0F5;
	Fri, 21 Feb 2025 02:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VNXSIzpy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF2410E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 02:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPE1Vku/8TpP3p+1Pbphz7G0LZPfrvekPS7vSwMGWZLkrUTVpHH9iKpF71K3HL/OeIVb18dJsjz+xGsRD7PX65YaSeyraGZlysE63ItGO2NCpKXDXh+hgJb2c+aQ3gIOma5OhjonJC7kvUWVxdLukzQlXdZC3O+WUjPY7zh0VYJxBEeaqgc5o2EriTjG9wneCSXGei0+widd62cAUyJaM+4gThydfbWpcDPYiiPgcRJbJ/eMSfDvaP8495FDKfLepT+AoIv0XeKDz4sclEBe6UJapWBeHAbX6CO032PvAMImpr8JXhL4eZ8ferxvU3dNK7vSpDNg/E6quQFh3Gu+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+WDakJ68SgWSe7X/c/zw0fCHhv6HucH/x9thdgBN64=;
 b=W6irtGH0C38NUDy+9ZRhNz+zMme3LrQItD9Vb2D/WHUKjSMQQXPdIfdB/Mz1uqGeeDzvy3gFGVi10SQXZ639G8Q5tZQOj7QyvNL49XoZpdpmZ46Myw39J1gf/EI6rhSTiLmuGS/dfwrJZOYfQi8oPYIH9CuiJb61nmnlUseOkXxsPo5g/POJF1Bg+TRZBEM7fBYv66tWVe0tOdpyWEG+ZvyceDjKA4zJSm6X1/XG4zivhNnsGOOFEj/TZaK9A2VZVFWg8xWbHqT2opz9ZTNp5md/9WPaRa2KC86i8Q/XFcX0vHrUxgKmE7ixqaLZzeWgOxfWFBSQ1gB/UoSmZGEyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+WDakJ68SgWSe7X/c/zw0fCHhv6HucH/x9thdgBN64=;
 b=VNXSIzpyZlS6o7U+U4jlIY2rqRpi/DWhEcm3WUZw2/otgip1YdbbQCT6vPqwLLH9UKy0K0T9fRrB/2rWG5NyNEFqFUGAZMTVFrSxrOaQpunmRFa/SStyjOf5X9inIu/Hz2esm4nR7derLH3A5cHnUwH8eqQGs3jkjhBKdmjSyTk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 02:25:41 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 02:25:41 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check if
 the ring is guilty
Thread-Topic: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check
 if the ring is guilty
Thread-Index: AQHbfdrjvqF6sMEQg06WBxWyuOrVgbNPT8SAgAD6BwCAAMm+UA==
Date: Fri, 21 Feb 2025 02:25:41 +0000
Message-ID: <DM4PR12MB5152D50ED621FA8573035577E3C72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-5-jesse.zhang@amd.com>
 <BL1PR12MB5144D07F922054085C142676F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB5144DE4C1BC16A00BFB30358F7C42@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144DE4C1BC16A00BFB30358F7C42@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=271f6545-f851-403c-8b75-0e96fc49bac7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-19T23:11:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB8453:EE_
x-ms-office365-filtering-correlation-id: 01339b82-ccc9-44a3-1a17-08dd521f09ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PGW2wgE+4U/VToob2TTwFiNvYnTvk9iowF122wnx0jbhtiJKZHcz6z9KfZYx?=
 =?us-ascii?Q?9ky3m8Hn2FqSMGz4oGIfG9flFHQ2cEZIusup3KGp25NdR285klvq1H9M7nXr?=
 =?us-ascii?Q?HpEuSdoRmR1urL+ixoIWfTzmsx0AHsE2xnZ64K0JtghBpwdqj+rn+PV3z3ko?=
 =?us-ascii?Q?qaqf1tItCoNisSQZF7dblholF7tIjpMIb3nTU3DTB0vOFpDp/lWyksQt05Dy?=
 =?us-ascii?Q?HNKA8NZoZAql/1VF3DFuB1bDuXwXgCo+B6L0m6lSep4xXhdvETQC1hKA4Qw1?=
 =?us-ascii?Q?odD93NRsHa5UZfczVfMG7opyH/zbV4TcnojNZ3GspBwUPVNV48JLTDbHCSHe?=
 =?us-ascii?Q?ZRb0rZr6BIVODfLITby14Wk6Q9hMMy5AmQCYKZ7z/7Rn1SFcGJWd8X/LcL6j?=
 =?us-ascii?Q?IPIc11rMoVof2nccSsDw6eswp/mbnx0LADPsCupWujsVSFOLS9Mb5PzycVHH?=
 =?us-ascii?Q?MztuEbelRm6KrWr1blIv+YVJJUhSXHgQX/NFljXDwWehQ2C1p2x8ayHTZTiH?=
 =?us-ascii?Q?pCclvqBI4xQnzb9T/FXFLHDtQnKrc2RXzR06rAP6PWcJ+BzQE7a5es2Buew5?=
 =?us-ascii?Q?6hjfjJW+9ZUgHOCoqDjzo2VLGPOFZraHyfK4iJAIT/NLrZguQl2lflNsZ6E0?=
 =?us-ascii?Q?uhL/NHRIDF8jCpFm9ARzNT1LQm1cnvUROkXfzmp9Q0U6E/q1o8qHxFQdS1W8?=
 =?us-ascii?Q?YL8VKINz3TTks/lgLCi8gBhMyJgaU7g06RfCYLtJ0PQrYx8J6qkc5SF4YQr2?=
 =?us-ascii?Q?WxEEp0J7/7dTa8c2VpSuJVEEQxDwIBdxxgONOdyxoTbaGuLgAfLK0X4RtZYs?=
 =?us-ascii?Q?OlRCvCpQWrPfBKIZVD1uaw6NdeujerBRdEn51C0mF6IJPMiyWWVUJYCQmOYE?=
 =?us-ascii?Q?gOIfBwHAzeUls8nXJPA+b/k7LOSw7zGwgErThPvPGb9hih8v/TwBh//gfx/I?=
 =?us-ascii?Q?2WoQGaUKstFDpnbA7k9awMSCRST6m8Rhmxt80kN9R51rE4VmSoJh+UlqfmFK?=
 =?us-ascii?Q?pd8fZMsPvR9aVh+CEUU70W8YZEkexDravFsx61DqeYgSmn/WBZT1Bbus1Ds6?=
 =?us-ascii?Q?xIsPLxyLsIerF8XqieEB45eQ1UoBJUeCUrPCNITNR8NaTzwA2Jocz/Pvlvzh?=
 =?us-ascii?Q?prtyGhdwxIV3zQQXPTy5Bb1PATkM5RN6uEXx+dZtOJYv9n9VqlRwUVkzWP3a?=
 =?us-ascii?Q?jjCt97qNJnSKzb4FPTmciXtX3xDu+8OdqsL1fC58WcctOUdjkwFqFXs1orc/?=
 =?us-ascii?Q?6AEuPqgcs638W8FtozLB8lvFU0nafbAc7dhXwZ99ZOOauxFZIqmR4CztX9Wj?=
 =?us-ascii?Q?fqBPiXo+I5RD/CTE5hFgb8n+++++dQCJO6TyhoxG7xEeu2iBJrxBPiPZigeU?=
 =?us-ascii?Q?q0q8Zk8YeUeBQbr7I9XlKT6yd3IUul2I/uNU5Lk4hiBlYN7OD9u+zaxm+GMF?=
 =?us-ascii?Q?eZPDvIJhQBQNGOtg9aPIR2/YDg3LwB5q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ui3Q7RWnztG6KcCOsI0GE5yEcNCwC3VFN5h+xsSBUdDJP1JSVAB7QpuRwEP?=
 =?us-ascii?Q?/1PCh/as6QytbnOjLPuzXQQ71yHeqFBsflZiXat1IZN5dTNnkfCAWtcmU0dn?=
 =?us-ascii?Q?rlNG5pxCT6uLvQ547ByjUgsAzGEILR58CLs/euqrf67XUamWuV/jCHLB77pL?=
 =?us-ascii?Q?YuLjb+EPg3mNitIjWpnXrDY6+Y9IBjYBzBL3Sy3+p1Kh1Qw0ihCRy35a2fwz?=
 =?us-ascii?Q?RrPeGHXldkRppCBgsT7oaAVhs9bYTlNYpTsHdnz7jKqCpDDoi/eGtLefm9u2?=
 =?us-ascii?Q?C+HY13D343g48rildLtagh1WVGDK+MZC6hdCOBb/jKtcwNFfg49gs+umH5TK?=
 =?us-ascii?Q?hl3LOsAKYIOOGaJk0MB4Na4NsWyZStJwwkquubzvNxAkENDXpa9U7NzEvhNQ?=
 =?us-ascii?Q?Q84sOldQ51DFNE01EVhr83hPht1FNp1PYRozOvWuY+8MMxGl61IqwuIkwrCh?=
 =?us-ascii?Q?YNvYA9hGLBE2qw7FCz34aJqK8GuoXZHX/HnbMJmrUn+TN8n1IfEOnesElKVh?=
 =?us-ascii?Q?VwdDc+WJRg4Y4cTEA22ucEtp0INA2hAElHrLupbnCOKS8nb5kdKsFP3OGS+P?=
 =?us-ascii?Q?ZLBUn7UShQddP/ZUHOrPbV0WrTsgkU1LFY3iHYxy5doerc1MEpZ+CzRwodq0?=
 =?us-ascii?Q?jnz3iM8yggF1HNiKaHxbeJOcyxmk3ahP1DVsI/nUF/DeqiaI0MtuNxrEvofe?=
 =?us-ascii?Q?LcZPXtO1hsolk6u31bXNCEjzznLtSaM/BTXds9qgb7ecqbNVBvTkgsKRcIHK?=
 =?us-ascii?Q?NDuAEraCXSe9m/kfxUqR1PYewHhW4MZrCZMXq4252XVRFM0hrbfAEdp+kVzH?=
 =?us-ascii?Q?vc8kD7MgV8KxPOQJneItcT6Vqug3RWyouEs+0uRJKHkbuAJIyzaESziV9VEE?=
 =?us-ascii?Q?/kOi8EPZukXBBdOvQUOEkVWd3uYuA8BvebIdZRGzBNuFC7mqGFk2MuvZ/+su?=
 =?us-ascii?Q?FFfIMI16DfoDEXvVMeisffmPlfyotvURoETgCvkWEtWM0RZqRInuiSAII8xn?=
 =?us-ascii?Q?3ppkk/cjYkGHk7tiB9CFEBm1rJ5AYMVFQ38+Xow1ozrGKk6DLAXr9ZrAwRTD?=
 =?us-ascii?Q?7I6OAftsllfrWveS+kdSYM9qjxe+xSYvfwcXPQNgRRwpu4SoNiEFNrWmH5H1?=
 =?us-ascii?Q?wfpLCrPGCTTATD2n/SFZM0RBslPafZ79C72M2MPagUT34YlQZwPuw052PD+v?=
 =?us-ascii?Q?ykawJatDQ84i0yvgx4GgFMIWwGAtax5kwDdtIO5cw7mW3rzDy2UIuj8WX91o?=
 =?us-ascii?Q?E6ryPN/CYBeW6rL1RnLGpFdzrxfxH4oTDMuyOOesk5mMWUeQmGe3uKEt2+mq?=
 =?us-ascii?Q?MhC1rh5DZtxjsFSEKnDVqUzmlBT/OQtvZaRJdcKqDIWdwrOU9PETpK9dKGqr?=
 =?us-ascii?Q?ngXRANSeD4Ik95pZ8Ec+H+lyJ+FcECUQ8OL85dTb2B7JLZ8HtbhTRWuefoHo?=
 =?us-ascii?Q?QpU6tF7QLzj/ORmSt8R2a7d3Mvkpg+Bnka/mg/hkkT6Uj9mEEIlRufEgcL0y?=
 =?us-ascii?Q?GTEbqITyS5nlIWBD0hiPpxZLNgfHXL6YcaEueyQcrxr1IODvPj1Um7DVNt/j?=
 =?us-ascii?Q?rqt48/rkBOQZgXjq07M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01339b82-ccc9-44a3-1a17-08dd521f09ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 02:25:41.6870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naj5SfKQTYKpX/1bS2WPRuy4DUqfl1e57pPuqltbdgo6nVhZhxn3Ei/+JDgldE7mlEkTc2Nnm3cNGotsFC1y4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, February 20, 2025 10:22 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@a=
md.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang=
@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check=
 if the ring is guilty

[Public]

> -----Original Message-----
> From: Deucher, Alexander
> Sent: Wednesday, February 19, 2025 6:27 PM
> To: jesse.zhang@amd.com; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to
> check if the ring is guilty
>
> > -----Original Message-----
> > From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> > Sent: Thursday, February 13, 2025 12:47 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> > Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie)
> > <Jesse.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>;
> > Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to
> > check if the ring is guilty
> >
> > From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> >
> > This patch updates the `amdgpu_job_timedout` function to check if
> > the ring is actually guilty of causing the timeout. If not, it skips
> > error handling and fence completion.
> >
>
> Thinking about this more, I'm not sure if this is the right approach.
> If we detect a timeout on a kernel ring, we still want to do the
> reset, but we don't want to kill the job if it's not guilty.  This
> approach makes sense if we have all kernel rings as we'll eventually
> get the timeout on the other ring and the reset will eventually get
> triggered.  But if the hang is on a KFD queue, it won't get noticed
> until we attempt to preempt the user queues for some other reason
> which may take a while.  How about the following instead.  We move the is=
_guilty check down into the queue reset area.  Something like this:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f044759435..48350d1030612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -130,8 +130,6 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>               amdgpu_vm_put_task_info(ti);
>       }
>
> -     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> -
>       /* attempt a per ring reset */
>       if (amdgpu_gpu_recovery &&
>           ring->funcs->reset) {
> @@ -146,13 +144,22 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>                       if (amdgpu_ring_sched_ready(ring))
>                               drm_sched_stop(&ring->sched, s_job);
>                       atomic_inc(&ring->adev->gpu_reset_counter);
> -                     amdgpu_fence_driver_force_completion(ring);
> +                     if (ring->funcs->is_guilty) {
> +                             if (ring->funcs->is_guilty(ring)) {
> +
> + dma_fence_set_error(&s_job->s_fence-
> >finished, -ETIME);
> +                                     amdgpu_fence_driver_force_completio=
n(ring);
> +                             }
> +                     } else {
> +                             amdgpu_fence_driver_force_completion(ring);
> +
> + dma_fence_set_error(&s_job->s_fence->finished, -
> ETIME);
> +                     }
>                       if (amdgpu_ring_sched_ready(ring))
>                               drm_sched_start(&ring->sched, 0);
>                       goto exit;
>               }
>               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.n=
ame);
>       }
> +     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>
>       if (amdgpu_device_should_recover_gpu(ring->adev)) {
>               struct amdgpu_reset_context reset_context;
>


Actually something like the attached patch.  Need to call is_guilty before =
reset.

Thanks Alex, will update before pushing to drm-next
 Jesse

Alex


>
>
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index 100f04475943..f94c876db72b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -101,6 +101,16 @@ static enum drm_gpu_sched_stat
> > amdgpu_job_timedout(struct drm_sched_job *s_job)
> >             /* Effectively the job is aborted as the device is gone */
> >             return DRM_GPU_SCHED_STAT_ENODEV;
> >     }
> > +   /* Check if the ring is actually guilty of causing the timeout.
> > +   * If not, skip error handling and fence completion.
> > +   */
> > +   if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
> > +           if (!ring->funcs->is_guilty(ring)) {
> > +                   dev_err(adev->dev, "ring %s timeout, but not guilty=
\n",
> > +                           s_job->sched->name);
> > +                   goto exit;
> > +           }
> > +   }
> >
> >     /*
> >      * Do the coredump immediately after a job timeout to get a very
> > --
> > 2.25.1


