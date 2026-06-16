Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF21ACD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DFC10E928;
	Tue, 16 Jun 2026 08:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cp6QfvBT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B079D10E928
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcecOLmZGslmj4YsMy3Cjv/fiaGnWpkm96LX805ehkJRM/jo7Bxayrf2+Jl6AknNGF3yOnTBV2XPioFi4mKJxkMB5pikK02z0HfndqHghitg9Z6/PqKaZBTncqLo7n05/BroBvxoGwO+kDUVGO1KYnAmdFZf20X5lnD8iF0s/egEY7geRU0b6wLoPbwhkQuLkls2T/x0ahPmPU7uidJfaVYHBkgrhjYECOPqz44dZvUoziK3JPIT78OvYWVswE3zzSNJkbiqQlM06cbSkGDX8QvrvmUQBLxjTYrGuWJCr4xtgb+FRMvX7Iciot9EswzTMyCZ8Sigm313VlK0Wnffww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR07OLMzfM5jjy56dAjzIX6+Arf8D6uESumKXD0vZWw=;
 b=hxE1fsH1awMtBn93gsZYiIMsHDBu/oxG1ohgs5W9T0AqSC4v1MB5lcVeZmG29bqoE5CgEiC/nuUAca4mXVSiq/2pFWbRdV1j25B7L77IrV3gHpmS2wg7eXEieMoXtQFy/cV2IdxE4mcglBA7KnUD306jFXqSRy1VmtHtyB27tUfiBVMPL309xavlmllv7U91l6VXu4xqL4lPyeO8gO124KthYHUJpMOGKMosKX07L2P3P/COjBuJlk41WNfBVvxK8Ldxa0lTeRpFPKhpspwiYzoVYTRJUy/AWTMD+84c3blowCaWEq7bhC9qosUxa9cX2lcp/g8QWv52be0bpwCSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR07OLMzfM5jjy56dAjzIX6+Arf8D6uESumKXD0vZWw=;
 b=Cp6QfvBTppK+FCSET+rOn4GPJIYvCpjELhFwsy5zxoMSCszmfnsy/rF6Kdo5oF5UWLehTNrJwaGz5NY6cRSEuUdaArfB7/HtK33Jov83inNoPyzJVigSdIJE+qt7BIEARNgAG1G+SIC6AnNPixEIMAs3Vsch32fOS5YibFfRBhE=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by PH0PR12MB999087.namprd12.prod.outlook.com (2603:10b6:510:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:57:58 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::a136:cb8b:515d:4fa4]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::a136:cb8b:515d:4fa4%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:57:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array overflow
Thread-Topic: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array
 overflow
Thread-Index: AQHc/WxP/3nujpykbU2oXlpgdY0B0bZA4Xkg
Date: Tue, 16 Jun 2026 08:57:57 +0000
Message-ID: <SJ2PR12MB880715FF183CBB3B61F66E78B0E52@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20260616084340.4128985-1-YiPeng.Chai@amd.com>
In-Reply-To: <20260616084340.4128985-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T08:57:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|PH0PR12MB999087:EE_
x-ms-office365-filtering-correlation-id: 4c0f86cd-1a9f-44d3-18fa-08decb855cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Z6ECIr2YWjL9twIQEZDiZZ3f2dwnzvbMiPmNm4G1BNbfMFGQy/zzEn3o3ml46wL7UioQ5YEmxzx4byvWhs8VXiy8UAB/PQGx+U+WIFDUjXrgBGFU2W0D8d+orDIBWyh6pAFSckl+yg/bJc6Rmo8RhUBCGgO3Jm2tMwlmsmjTZb5rcWYWuVZJ2Fl26Kj7SrLiBk3Ymp/3WPXdGslNz36aS+8d1LzV8cD/927/3a1USWyRT71IiutdmvAWGtT5u3nDY/0w76XQisd9MChUdWdM+Y/dllPC9yeRAtr6OmNlj6QC4gYWQV5cdfr6/tJFF2ubRIzQrEJ5DGWUFLhgfCYcQqv8p5XRT5vETZo+aA4zXVAVNBjB19apZHjM8ZkXS28pmln4cdpP2/lMIXgnL5jZXyM5mi5Mk1XehAKfCRuhLwO0wK4pmtOmfBz8I0pGFweNb43xEa3LL8sGW+no29gdlhmj8vOEujxzlEMUgE9GWt42qQ5wXcqwX57AIhCLiLF4SbcVvS9uPGrS8qqh/OWcQXIZqZIVX6VREL6y8LCcNVxCyT0c3SZoraDDDCj/1lGaIpNBzlbgcs4JPP4DmXJOgDe6D3q4BImZDcI4t6MmMnHDNgsUrHq9xEgbxNgkWz7OKtBmMFQf5LKzxtn9//kRZQ0B/+g2vf1LdHFftefNql+Ndv0trWtUfOC3hmIVGCAApE7t0Iy2VdAm+DaXx6hVzTJtGKOBeNk+E1P4u0Y+61t4BOHLIewOzeJjXiucHSKN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eTyAs46weDSqj0v1LsnDMRPgruMAmqCixQU1u3mRiFGrHCJVM9hwV2IZdI+p?=
 =?us-ascii?Q?wLw4T/DxjlrEqPgFXzcmyiGSUF9vQyFEd5w+4v7g19VTXt1bomyXVqXz2Wzb?=
 =?us-ascii?Q?su7DtAYMotuudFVLr1tUTG8u3aTtNl+WfJLCX1VlGikIpYZIHcK+7wG00lNN?=
 =?us-ascii?Q?JBDSrnjQ6zfyRCrF7GTBaBUwwZ7sxqkdKSM5SoKsd9M2CsHX2auDDEetYGCH?=
 =?us-ascii?Q?yJ0MlwT/sQaRAPnb40NgWBmDkrNQUvJ18jBfOXCLoTwMjQhcK6QDinHtfAvx?=
 =?us-ascii?Q?jrZ8Y6I+UrlRz6VpvEs2W3lAx/qzQK1uhXMqyt/Wyp/ICJcxa3s3mnINJBrA?=
 =?us-ascii?Q?FqdOelpG5bE3jIeYCor0FljZiHHeV4adAJCDTlbCNpG4dSxaAKTKBmk7DJoi?=
 =?us-ascii?Q?izIO/i7FgGizQSImHVAVNVPzhyVDl2ph6Ekkb2uZ5UFXlaT13UlLdtl+xCUn?=
 =?us-ascii?Q?Q+RSYpf8hI/O0lCIuXmglRsec2zqkmtHIK2Nfmx8S3VPg1Vjk4aTEn2JPSJl?=
 =?us-ascii?Q?gINBpf9Pxl/RiwsCHlvoUxg/+M61mhzH4RBtUboJfqM22xUzIB850aG23J/l?=
 =?us-ascii?Q?2c8NlUnfUnuH9O7diqiG+HwJmBpLMvsRUkG2uNlCcQqD+kB+zI3wokd0Y7pc?=
 =?us-ascii?Q?zVvMChbNvPzaLfpr5/qDZNMamX3egHI/b6mBvXoUzxLOy1xyIVCPHlV9In9/?=
 =?us-ascii?Q?oJ0tMs0H1NMlOy+IQAzFPYjHM3ndA2XWS6Pv2l/LxHwMFNzQjiM5jqv/9nUL?=
 =?us-ascii?Q?NGow3n8+b3m+MBL5cxoTSKnbxn1PMnWSufTr1p1Dw97sFDJytfRIAPf8PSxh?=
 =?us-ascii?Q?drc0NBWIPWlDM4BSeY5o+VIuFDX2QJIT+ScJzAGAlT4pslL1aMBuqpstP0Nb?=
 =?us-ascii?Q?EnuNk9CSyb4iLKnHjt9WF+UnQ8eyDTx1AkvP7rsxRW387+zbmOJW6zcZ2G91?=
 =?us-ascii?Q?UeUJE+epduRxR/Y6lfdvic5r6fUIya1spgD6Pj1LhfOYty7o4F1iaccoq7DE?=
 =?us-ascii?Q?jExPKLHBEvs+TamlRdko8UxSZ2n3/PqfIG6H4TPI/qJVBvZz/ZTEJpD3upMs?=
 =?us-ascii?Q?D455qgDwYiER07hMkVgwyyQM04gCiV/vr/e5O7fHZ7aA+X1e9btkUzc/uDPe?=
 =?us-ascii?Q?E8f++vYj7Y+A0f44y84PpR0CxHbpmteLDTD1MRSVZSk/bGyTIhiBaY56RbPE?=
 =?us-ascii?Q?LXK9tK0hutMpjs5O4z+JVy6Npfor2uoIRxvtfAflnpf+vd7r3NAcYo0DBr7E?=
 =?us-ascii?Q?6/xD5q+fs5ZohjK41yGptOZj0XI5oUcbV2+hX9E+xpRreVqdp7qXQePS12zT?=
 =?us-ascii?Q?pGVEDjpqihGQmHd6qVH9yVGj2Msm1i+b5WYiVAavK0V+ABt7bXpUbvVamItZ?=
 =?us-ascii?Q?qh0zGp/KbDJjNm6FeIV0hAAZvYC5Ml83MmI2JmCL5tY+yzc5QizIJAE0vkSA?=
 =?us-ascii?Q?HoL6Dc0NwiKsnqGwEW1jnyInC4lcmMZ12JVuc3VV9SN+9dKV1r5XqzE04cvb?=
 =?us-ascii?Q?7HNTdGzStzvwbsfUvxJLBZ+GOoIdK4gQO+1XUZH7cQ6U1b9T1n3cCJ2RcK6X?=
 =?us-ascii?Q?pD8aV8lwbMBnuciHNYymLw/UbPjdEugXzZa73epwGsIt59CotjnmliH7pmql?=
 =?us-ascii?Q?pyYiCH/DsdBp1fSiPT85w9PM3fE8D+rETE+7SraYEBpsmuGwvcB3pexMq9UH?=
 =?us-ascii?Q?JPkY/tljIyEO7LKIDRR0NQ0h5syLy3/ggqSxiU2WS5r1GLi8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0f86cd-1a9f-44d3-18fa-08decb855cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 08:57:57.9914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyJ5zWRww/BBjPq0LYSTaAuN7tpV0AaCUwe19B7sAxKZsbJbyAuEqw9LRDRda5fy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999087
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

AMD General

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, June 16, 2026 4:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: add bounds check to prevent array overfl=
ow
>
> Add bounds check to prevent array overflow.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 94ddb8b98abf..0a2136668b68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -5064,6 +5064,9 @@ static void
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
>        * Use this list instead of mgpu_info to find the amdgpu
>        * device on which the UMC error was reported.
>        */
> +     if (mce_adev_list.num_gpu >=3D MAX_GPU_INSTANCE)

[Tao] do we need to add warning message for it?

> +             return;
> +
>       mce_adev_list.devs[mce_adev_list.num_gpu++] =3D adev;
>
>       /*
> --
> 2.43.0

