Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65B2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BECA10E50C;
	Fri, 10 May 2024 06:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SCoTALkA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0511A10E438
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Olms0daFC+04GtNI++NKJQrFVC1g7FeDg7Wbuvrv0VygIQzxIJENKAHVDAZZ+iX1XIodNOEojloMuwjtF+BL17LKAXWuf1SU0hlNGw9uv1pSb8T4NkogkLCjmRHfbaXStIAhu1ggZCUSDQ97IV77vq6YT0xkEuEVqqVl+DCoXuHZwIWLq1n5d6VCsIpBS0DaHlsDJrLozXjbtyiI6Pm6isHT5E4rzjPyLmUtqcXunholGUlbc1JXpaAHnjeFDqazfFCUyfca0BkBEOC0N1Z6ct8FhhpgRgSYKnW40JFyr6J0zb+cGL12kTQn8aJgEJrmTFt4r9+GemW2Ui+q589B9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEdH+DRGn7OE92S3S2Fts2zOmjgtVHARaYRuS1BOYTI=;
 b=P6RPbcjXc0AcAZ+tNZ8BbZweTtHlRHcGuAXPr6GvWCj1ZxQayRIqQAuIxIGXRXPePD5mxqUGvHV7rj8IIbG/XlQ/zLjJtfIh+ee31NQtjyS57xdCpJjd0TuwB05AKV8LqYUjd0hOP4Bx1s0Ym+WSpYRLh0/KEzwu7lKvC0W5raKtpOPlpdA61yWK3TjRYmi8w8NBAjR3Z3Jw8GWparMzUxrQg9UWAztguOhc7X5Vbtsri7YzdwtLo5UEeauj0CSB4z5ZA8ItqTNiPogaKq339pIb28RwGakbMQPRsDxfVm1uPkfG7z3kVgQGIhqKJK0eGT46SvWiUIb+NTRYrwUNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEdH+DRGn7OE92S3S2Fts2zOmjgtVHARaYRuS1BOYTI=;
 b=SCoTALkAWWcH9XnnFuPoRiARZTQXNf4fKUOU6XwVf+RR4CqzmxQVkdIxaNvbqqRmuS9yRBMyptvSwCmQafyhqrLw7y3U2NLdysTopI+IBwLWbWKJDSQpOiiAE8uuqNA00qufO+OvP3AluygVAmrtfvc5fVkyMPV/m+5W/tXKppc=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 06:43:42 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:43:42 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 14/22] drm/amdgu: remove unused code
Thread-Topic: [PATCH 14/22] drm/amdgu: remove unused code
Thread-Index: AQHaooVSLFbUoG3rHECwbF1POoWKAbGP+dOg
Date: Fri, 10 May 2024 06:43:42 +0000
Message-ID: <CH3PR12MB807448B936271A453E88160CF6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-14-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-14-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4fccf9fd-c235-4307-861f-300acc4e9e79;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:01:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7200:EE_
x-ms-office365-filtering-correlation-id: 8363d298-136b-4d5b-c971-08dc70bc8831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uQ21zx7jRp5zHah0EtSzlhzGcOnHjRTn1TPgxIeEpDxyOHP/SXqXTR7EiY?=
 =?iso-8859-1?Q?jr20g8LAcVmNnbcwRRmCkAp0QsR1MYWBetz6eWfBA1S0jKzbQMhogiBpG0?=
 =?iso-8859-1?Q?VuRCwpvjPGCkv5Ajmu5/TcoM9k9/YRvs0MoToqBhbNRfwNDXzu5XpgXUFm?=
 =?iso-8859-1?Q?qf0eABBrvBByfoVJzwQHNU+p8KN19s/SlHzUe57FLbCNjMbJIy0hgfdx5v?=
 =?iso-8859-1?Q?xgPUmoqX5nnp59XkoVbQvzA1E6mKc9xlip9ytsbOUqf3E5oFC+cmdQXfM9?=
 =?iso-8859-1?Q?6RUuG/IDnTGXaBhV2AXsvJsVXFo6zPDV+CRNycK5Hi2Iep9FnzTqc1+yI+?=
 =?iso-8859-1?Q?uXvRg8Ic9Z2RfqJ/bJv0P5YBAyjZGSypuRAJYSnUee0xvm8xZ45oyMJwsg?=
 =?iso-8859-1?Q?XqzZta8wSCHwWJbuXNfjQxulZFNWcUu66Frns5ga0cym3F8FPZ0LSHRKAF?=
 =?iso-8859-1?Q?gjQXZCEToS8wOhx0uqgibW8JRY9eggiOVkz4piFKysSV5klGG++q6FPNA6?=
 =?iso-8859-1?Q?S62r3oYBshM5sNipqBsq+x2d0eMWCJ1hvgEg0wWUda4MSQ2R/vn7eK7gna?=
 =?iso-8859-1?Q?dpK34ASgxzakJHVAMbFFT08P2mPTqrCbH15hXNbOnp/bANa371h7ch9Yhd?=
 =?iso-8859-1?Q?z8V2piQs/0IKE1mkXoLVOeHgmyR1l+C+fxgtgHw/LXPrEu+nLWcm3ZIw/5?=
 =?iso-8859-1?Q?XVVpLsb3KNyfi8W+pcPLFCNo3w07QXBcOHJ6erCedxaBsv12zXfRNT7La6?=
 =?iso-8859-1?Q?arZWpmmJKwgvVow4QSygLJjXwDV508gqMi7Ab68EFgi4SiVDViO9SS4Vgl?=
 =?iso-8859-1?Q?itUo7cTbXZXSVpK4Ol2Wld+7p+M/XIexf87EbQy95zSfzszTBbLcLFI2Cd?=
 =?iso-8859-1?Q?OS8IQH+hPZUyG0hYvIy6i3gC0EYFOzqM+bdrbsUhqPOpt6mp7TMumKXcxB?=
 =?iso-8859-1?Q?q8XAs1bxxIbnK36nUruusbuPG1iYdI6qJnFrisGeK1pkrqzw+ZOEIKPuuN?=
 =?iso-8859-1?Q?U473zJjdoPhbmqaqWqRXPuHVl1XONkcvcVTU2RnUFvKSuVmSKyYvaLpKYd?=
 =?iso-8859-1?Q?3v1Mkixq+pN00rKAt5FECJKJKSqbu8tGatWbKep7WJRA4mbb8+BdGhPtEi?=
 =?iso-8859-1?Q?OgboezYSTRN06BwU++VMsF+5V6qZC1cpl5Z69VFZQYl3diCayurfW5XXZq?=
 =?iso-8859-1?Q?cxx7cf2DBkpzXRQQPhybxeMv3AVswp2yZTs5tKSZGhV3EL03w00AOS3dU+?=
 =?iso-8859-1?Q?1TizH/k5srRcW8xcZ9CCg+TLu1Y77kOPdi/fKM93Ld78HrOcf3PSKoRZgV?=
 =?iso-8859-1?Q?bGQ36hW7U5j3iXRA1ugKC0vEba1x7sCNwiCz6UPzeBDtrfifO1dDviEBf+?=
 =?iso-8859-1?Q?fIkjvFAyuSNQ+HQ8exT7FU+35V/+XtJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uy4kt5+i63JVKzmCQa7bRQCF8xITXQF8aYmtaEfRldwnzB8GAyVwg5kDZG?=
 =?iso-8859-1?Q?f6Vag94yfZfvyvu6/qnqrDoSgzWbUlS05vKkGoJAonSocmgzuu5CeE2Zjy?=
 =?iso-8859-1?Q?2u0T1YXvOisbZFtBpd8+CANjYS7OB5b0w12iL/jwShFg5XlTmxL6LYvEPb?=
 =?iso-8859-1?Q?dn/Ieneu5XA6MwW/PjPN8AuEqdk5rqKcRuyU6ZJHlD1YkGQqSwgxhGncSD?=
 =?iso-8859-1?Q?TeBMYp19XkAxiGL8k5FBgG6Pw91VOXHbNbEYmYZ3hkEQ/4yd19rKiyO6ow?=
 =?iso-8859-1?Q?Brw+XTUPCIP7VhdUko5Bgumwz7gL0qDi3LqJotFx4wvMS0C6CCLBb7yZCZ?=
 =?iso-8859-1?Q?aeojeSHWAUndzcksDEYi5jdDvK+tvb1mfUuCn3o2QTbfDin+YzzN1+hSyC?=
 =?iso-8859-1?Q?XY0dHgRERcmB9H9K+dprpCLZ6Rg3256S3BhquhwGduEI/ji8PrW4vfj7aw?=
 =?iso-8859-1?Q?n9X9h2zTGwyInYFSw7ozzBa4B5wtoWLyK+aXvMxUJuZPeUJjT9QAe7Dj4g?=
 =?iso-8859-1?Q?ZNyii3y9eNHGAH1uYrtVg88NAFmM0etBVMmOoafM2ZO6js5NwceUSToyAo?=
 =?iso-8859-1?Q?0NOgPK+i/GYFqn8pbzGYX6mr6ezgC0caScAGyULZ5IMWF5UEUy/32vfrh0?=
 =?iso-8859-1?Q?D3gWBIFmInyE3ct57hauUOXx/VM2mU32x/5OVQN0jweMZun/70nHPK+Gmw?=
 =?iso-8859-1?Q?68abD0WQnqHaoqKhmGOLkYqBDVEIh0wHZr3TVUMbnea6qFN4sQCyMVTmb0?=
 =?iso-8859-1?Q?yQ2uhUQv/J5+eIc0I6dwUcgZFolL4fjEI1sYzuhXNPCLlKCFqOZC70YIYA?=
 =?iso-8859-1?Q?V9O1V8mjSbmTGLoJbSGmNfYQxiG9yVne6ydW+xaK+FjKlKVgevNsX2v9Uf?=
 =?iso-8859-1?Q?B+fTzxQi8ddS8wBSbqSTxnSHey29Tu3ybY7dety5oWXDPSJXopYcAVSbKQ?=
 =?iso-8859-1?Q?Hh9i/YzH/zPgqMxKPgyuZECC9YXGhF2t9qblVetN/0P1xM8t8lpJ14YwkS?=
 =?iso-8859-1?Q?2qKdovhiTgrVFXiPFOWjSlaE0RG7hxFRyErUc9snK1sR59tqm986lIn8I+?=
 =?iso-8859-1?Q?ct9nIGkorpOaj5Tt3ezxWvMgZdEGfv7rfgWv8ZRJaY+Npcqpn0RIld2P+5?=
 =?iso-8859-1?Q?F52BHi4CFA0OerfsJa1DI7g4r573qYiwVmrAAj3SXDqybKvMbDak6Ls5p5?=
 =?iso-8859-1?Q?UhvYd3cU1nndHo3akPDALcPCnsbvPZOqDWdVwQ5SgcCUY8EAd1jQ4jqfYH?=
 =?iso-8859-1?Q?9TcrI3zG4SrML86l0cvN0PwehUmjK1rQLkUZZ2PYW6EoKMwVGwAjIP7vpo?=
 =?iso-8859-1?Q?d8Vg/o2dEeDLfjKRTQ0NSeJRyPOe6t27/m3kdqsVp7KOP2ZiV/bIVguPF1?=
 =?iso-8859-1?Q?1lyNP0E919RriyUFQvtLJV/q9cO5Kfci/Q2lqz24Ak3Z5qbG34JdswVUeO?=
 =?iso-8859-1?Q?4wkYPLUrqcDfos6fiadRg214wxSX8SYb4AUpVqzupZahgB2PLZSBa6stdz?=
 =?iso-8859-1?Q?kM7DTyzPvBIjhXc/fBKhmKwn72P0jVz5CJQ69waDOxqsUqaqb7mQ8mn0AV?=
 =?iso-8859-1?Q?YI3E0XOfGjdzEgLN64AxzI+AT0bXeG9e/UG1ejXVi/APBM5B0YH6/gZ2Ur?=
 =?iso-8859-1?Q?8pBWjB/NhGZWc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8363d298-136b-4d5b-c971-08dc70bc8831
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:43:42.0686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynuuyb5v560PUSkcy5cVbhVZHdfkCwsGg3S8ZvjLy3MR8Ud75Q5J2xTofdlCBfrOsHiO5QLSZeSADIztOAGARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 14/22] drm/amdgu: remove unused code
>
> The same code is executed when the condition err is true or false, becaus=
e the
> code in the if-then branch and after the if statement is identical
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 541dbd70d8c7..16d3deac375d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -963,8 +963,6 @@ static int gfx_v7_0_init_microcode(struct
> amdgpu_device *adev)
>
>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
> -     if (err)
> -             goto out;
>  out:
>       if (err) {
>               pr_err("gfx7: Failed to load firmware \"%s\"\n", fw_name);
> --
> 2.25.1

