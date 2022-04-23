Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BCC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Apr 2022 02:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A374110E94C;
	Sat, 23 Apr 2022 02:27:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7100A10E94C
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 02:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNPzy7rhWCo4Gs+tHBE+9Hw8NkBcVbuLmeiqnr+qj2L4gWPp1EwkNzRYX0m6fHgZpw+dulQqhcebg4sG4E+WN1rNrxc/HJFxUTvmdJhFuBFDRIbFuA8D1a7ffstSn5MjyfoWHcsJbvzGmqbgZaau7OSaz/ZCiXFlk7rzW1x+MEKvTKvXD6Z8LBHhsu5xSurjBVnQS+tyHzQVxomqw6jrXChikwgEQUOUmovLQrZSurCqbsVfg8PTystzuc9HC8XMp4lkZIioyO8vEm3zFoZKObXszHSn04UtPyWozJtWl2yWPhM9cZBll9/cEozM0HjfK9mk8sO7W3lpG8UQTGdeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6M68kGybu2qxka8eaIugaSszh5BR1Ate4MbjKRJpjg=;
 b=HsPJYTNFEtGsQleurwdR2LLyTY/wQvKRxv4MhKCLgxwJ3WphoAOrc5o66NFkulCT4zJhmiLivCys/Aj1sbVYUHT9dKzrZKnmaqMm6Ufnkl0Fm3RK1qMd+z9tosSCooYayIUSgrNmwGkxph8g4fXCvL47UardI6UnTQjymVnLcrSvDc9L5YiiBqU3Hjcp3Vh7q0VlKf+/lUYPBCFXy67bYGAQ7HFZ0PwDV385SBmNh2jJQmRm3d8U7Oo0YgYFqkIoxIkago+p7pfDVK8Bje6xdASGzzmK3rCyEQ1b8eaBNFRGiDKHeMu9RBFJE3tUA2E1RuxYPZdVCpb+o0vRxi3XBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6M68kGybu2qxka8eaIugaSszh5BR1Ate4MbjKRJpjg=;
 b=rp2pldPnraKooWvcQoHfbmquMTFxInqDUrvEYUm8+g5ksu8GfKor/CDc3kfE5jGXkBsGtd517vXwPHeDlMWXIe8My9MEfjzplJiyCSYjdLIIV9tvbtJzLSZFPpPfxPX84La01T9S1B52AWbukPoVPiGIttJ3B7MnB+3pPRNd4AI=
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by MWHPR12MB1149.namprd12.prod.outlook.com (2603:10b6:300:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 02:27:06 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::8079:93c0:f340:7a1f]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::8079:93c0:f340:7a1f%4]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 02:27:06 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
Thread-Topic: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
Thread-Index: AQHYVrlVtH9+5hv8KE6VRe68q9/2Faz8xVGA
Date: Sat, 23 Apr 2022 02:27:06 +0000
Message-ID: <SN6PR12MB2717F60FB7CBE1BD5F8BF168FDF69@SN6PR12MB2717.namprd12.prod.outlook.com>
References: <20220423022445.7238-1-alex.sierra@amd.com>
In-Reply-To: <20220423022445.7238-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f11afc22-1eed-48ef-aa3b-08da24d0c2dc
x-ms-traffictypediagnostic: MWHPR12MB1149:EE_
x-microsoft-antispam-prvs: <MWHPR12MB114901EE0A70F9B5A8B301FCFDF69@MWHPR12MB1149.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsvkThbLenPp1u1tx0oVBdE1hf3z+7l1JVa0oNGFxl/BwLEbJNEOmVoQZi4q4qbJOcYcHD0Gvw7PuvdMHj+4VsV7q1UnH9Xp+U34l6QF2drxOQv5W+waGUUjjzL7343WjDO07o1yRKqn4BNjrA8lMAePPObJvXDlqSs2/TEIZjJW3CvcYcBXnHIZ/sDf20YiUMq/PcGLZ3T2WPOy02ZBth7Ix4gol5RjM1ANwuJeDQiG96eShZcNBpjGylH4Y55MO6JrW6F3WoFaFvVxChIRrbc/hEmI8OHdHG1Qkrg66Wv/gCqpR8KcyqsaBBskDWEpmcwm6fzPBIEhWhKYFxRn5lJjsn1Cu9zi/AD6KIrFwCKn9P2SJahqyj4wTsnmCR0SeGm91pfrevy/QjbsNWpD7jDVd7LDAAfyIpX6FHN8+Q4TBZUSuJHwoDTtnBpsvJSerPkGqo7OlGHS4oF3ItKv2RGSbDwX0IZHDksRjMxceUGmcDnWj29Lx3vWPdTSJecyaR7sJAa2EciW1Y/JLfpSqDC5AA7dk+qGHQUt3BgxsCsRPle4o6TcF0gK6t8yinhMyTsyJYYlIEbqFxiinFiFejtMsqHrrC1IX4Xt4m5XOJJpMZ0qtex07bh8yHjY2W68lgWmH4pvkRaatYZBxz8yaFt9yGVPSVDYBuffkXWwS0x/lhQ08sqGqZWeJa7vtw1tX4iRaJEbMjnzvwHYxyz7IQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2717.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(316002)(83380400001)(508600001)(53546011)(30864003)(2906002)(52536014)(8936002)(26005)(186003)(9686003)(71200400001)(6506007)(38070700005)(38100700002)(7696005)(122000001)(55016003)(66556008)(66946007)(86362001)(5660300002)(66446008)(64756008)(33656002)(76116006)(66476007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvMZ61CSs8Ot/QG9uZxTLz7F/ukmfjJ+QI+rG3wy6E8cnkBtaJ9w1qN/dcNb?=
 =?us-ascii?Q?BAysa6ZNEIEcccnh+zledNg5JpRVxf58fTVodjMb45+dpAgUhh6VWYoasorc?=
 =?us-ascii?Q?Il76nCuUCLIzZrd75T6T21FWS8Mfn9k1fkMHk4nCj8qtz7pBadb65tYGeKdt?=
 =?us-ascii?Q?fBqxbNS4Fjtk57PbYI52weTxM2Wx2Zymtb2F3wIyag4SR6n5rlCbdDnnWpYt?=
 =?us-ascii?Q?eMVfuGT1bKYaoVe1kYwQtR2zU8wdaeztXlupKunaU27k3U7MOPz4Y011tCuL?=
 =?us-ascii?Q?+Qeo9hEN3uPjqL3D/zNVeRt5Dgy0E7CCT06A9KE+n8IVJkCoDFAcsGRrXa3B?=
 =?us-ascii?Q?l4o6o3t4mg4qG+kFyq8eX3woz04hq2PZ6Rjx+vZBP67pXCGFtxCKGBb4WYGg?=
 =?us-ascii?Q?zvcPyBzMmAQ5o6H7vqDIiydZUCTV2p1D86IQbILsCoIdPx1eBdvAw+RXUeii?=
 =?us-ascii?Q?hgTcovQ7ldVY9YNmCbOsPyFHn52D7EFrQxTRvho2+oMJuUVT8Dqk7JGIL5IA?=
 =?us-ascii?Q?nUs2xJESV9ACDPK8ARF3cn3fwLO6Oq3UwMPjShVx3qbN3B+S7ST0OoUaVAbV?=
 =?us-ascii?Q?2v3cGIG6RCBIk6wF3Y+irogoSbDI7pdy3FuEiOoOxr5Nsvej13q8nfcgtWJd?=
 =?us-ascii?Q?K2WMc/1Q56ErZs444gwhhe8B41KXGkLHEnKfV0kG+CYr+nF5/BLMoUAhJr/E?=
 =?us-ascii?Q?XxJYYI1PUX332pgqkROazWAw7CtQ5tX0OLEsjsefGfwUfAywbzFrzqnKwC2x?=
 =?us-ascii?Q?ZJAYSTdJ7lhEIUyE0/5DQqyHp2LKano0T35jAu/aHxjiKxhhkOT5ylFZzduA?=
 =?us-ascii?Q?+iDtCmhJT14KyaLK2+o7aevaSEsPuNU8rYJPlM6/+xwM4Jo6FhA7tyUPHDXF?=
 =?us-ascii?Q?WP7flpVZZQiTbFqamXU2PsHSfyizKJ+clC81qW2nC11xAKA4xy9Tk9hcWobo?=
 =?us-ascii?Q?rYixUr91+XfgmgPCqpjsrFTymJGqumr/MRBziJKolgV/HinhHeg9adj0zNVW?=
 =?us-ascii?Q?9Lj4+jcIpxBR7/OMyZ4VD29s2oV5ajCvb6by4Ekfk8V3eYjF7iaythMBGhGH?=
 =?us-ascii?Q?L7SgZXE2ZrG6S8PXrKrfZI3n2fMltL0f3WDhdJFAQgY6Yc4y5BHnK+djKQqQ?=
 =?us-ascii?Q?0gvndZBZ6IO0d11ntOKXwYnWnfqKIgDT2kBIiiKana9q5d4CcZl3v38UYGnu?=
 =?us-ascii?Q?+fPZEhiIfNVYDfaxmENzyLjOZKJcgZ6PCzV/1q0PEUoBVMBZhwNSFHHIZJsQ?=
 =?us-ascii?Q?IVm//v6mQBaq7uZaB/Q/gutuZvMs05szyk9dsmD+gcnA/xCaWIi/RvVw50pg?=
 =?us-ascii?Q?7HMGqFtNY9F2OHPgcOg0KcmtvMw4CJ3lwDZkLOrWjv/5q3WR+7hHuSGDhXK9?=
 =?us-ascii?Q?Yob2WoQWaOeP7LKRl2n4qwxlFGeGefHaUPC4jDZDUPqEHdrW/KF+Gmc84d3j?=
 =?us-ascii?Q?X1h7vnE6LvNNDr48A7zF525qtGsaOSGiSaxx6k0Bt2tXuZdAMMdjuhvthKmt?=
 =?us-ascii?Q?jNNy9ZE62K8ZsMAAXDDJcxxROlGv4ctibQyuL1RetE0sb8KiA6T5RvxoEO7C?=
 =?us-ascii?Q?jE6W3O5MIZx8RjU/U7kzOK+G3gpZuaHjBCADDQ+P1Li608DOpGLcnjzw53ro?=
 =?us-ascii?Q?Tq6dsSNBpV4CMmW3C03rAmh/LCdmqINIivsWKWaIVtOV34D/9ngs5w9BSTwS?=
 =?us-ascii?Q?fLz/MpZdFdbVNa27iXWGcfHXBR1xcH3+iR+E3/BuUN8ZETQt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11afc22-1eed-48ef-aa3b-08da24d0c2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2022 02:27:06.7072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ei/PtfLZcB2tsjJBf0oxGzJpswomQBJCZNEF1bsQxcSq82ulj3IAKmNQ1MSAHg7OiPf0SB706fLB4diam2bNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
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

This v2 patch extends to all GMC versions.

Regards,
Alex

> -----Original Message-----
> From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
> Sent: Friday, April 22, 2022 9:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
> Subject: [PATCH v2] drm/amdgpu: replace VM fault error by info logs
>=20
> This is not a kernel error. These logs are caused by VM faults that could=
 not
> be handled. Typically, generated by user mode applications.
>=20
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 14 +++++++-------
> drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 14 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c    |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c    |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c    |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 20 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 14 +++++++-------
> drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 14 +++++++-------
>  9 files changed, 52 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 6e0ace2fbfab..c226a4803086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -79,25 +79,25 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct
> amdgpu_device *adev,
>  	u32 cid =3D REG_GET_FIELD(status,
>  				GCVM_L2_PROTECTION_FAULT_STATUS,
> CID);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  		status);
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>  		cid >=3D ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
> gfxhub_client_ids[cid],
>  		cid);
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS,
> PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS,
> MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%lx\n",
> +	dev_info(adev->dev, "\t RW: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, RW));  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index ff738e9725ee..fdcca1477592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -82,25 +82,25 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct
> amdgpu_device *adev,
>  	u32 cid =3D REG_GET_FIELD(status,
>  				GCVM_L2_PROTECTION_FAULT_STATUS,
> CID);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  		status);
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>  		cid >=3D ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
> gfxhub_client_ids[cid],
>  		cid);
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS,
> PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS,
> MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%lx\n",
> +	dev_info(adev->dev, "\t RW: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		GCVM_L2_PROTECTION_FAULT_STATUS, RW));  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a455e59f41f4..864fcc0edb90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -148,14 +148,14 @@ static int gmc_v10_0_process_interrupt(struct
> amdgpu_device *adev,
>  	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>  	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, "
>  		"for process %s pid %d thread %s pid %d)\n",
>  		entry->vmid_src ? "mmhub" : "gfxhub",
>  		entry->src_id, entry->ring_id, entry->vmid,
>  		entry->pasid, task_info.process_name, task_info.tgid,
>  		task_info.task_name, task_info.pid);
> -	dev_err(adev->dev, "  in page starting at address 0x%016llx from
> client 0x%x (%s)\n",
> +	dev_info(adev->dev, "  in page starting at address 0x%016llx from
> +client 0x%x (%s)\n",
>  		addr, entry->client_id,
>  		soc15_ih_clientid_name[entry->client_id]);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index ec291d28edff..3d830fd7706b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -620,7 +620,7 @@ static void gmc_v6_0_vm_decode_fault(struct
> amdgpu_device *adev,
>  	mc_id =3D REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			      MEMORY_CLIENT_ID);
>=20
> -	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s
> from '%s' (0x%08x) (%d)\n",
> +	dev_info(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s
> from
> +'%s' (0x%08x) (%d)\n",
>  	       protections, vmid, addr,
>  	       REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			     MEMORY_CLIENT_RW) ?
> @@ -1083,11 +1083,11 @@ static int gmc_v6_0_process_interrupt(struct
> amdgpu_device *adev,
>  		gmc_v6_0_set_fault_enable_default(adev, false);
>=20
>  	if (printk_ratelimit()) {
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
> +		dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>  			entry->src_id, entry->src_data[0]);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
>  			addr);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
>  			status);
>  		gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 979da6f510e8..1f3ceb03b47b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -781,7 +781,7 @@ static void gmc_v7_0_vm_decode_fault(struct
> amdgpu_device *adev, u32 status,
>  	mc_id =3D REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			      MEMORY_CLIENT_ID);
>=20
> -	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page
> %u, %s from '%s' (0x%08x) (%d)\n",
> +	dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page
> %u,
> +%s from '%s' (0x%08x) (%d)\n",
>  	       protections, vmid, pasid, addr,
>  	       REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			     MEMORY_CLIENT_RW) ?
> @@ -1286,11 +1286,11 @@ static int gmc_v7_0_process_interrupt(struct
> amdgpu_device *adev,
>  		gmc_v7_0_set_fault_enable_default(adev, false);
>=20
>  	if (printk_ratelimit()) {
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
> +		dev_info(adev->dev, "GPU fault detected: %d 0x%08x\n",
>  			entry->src_id, entry->src_data[0]);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
>  			addr);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
>  			status);
>  		gmc_v7_0_vm_decode_fault(adev, status, addr, mc_client,
>  					 entry->pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 382dde1ce74c..5be3f4f77c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1021,7 +1021,7 @@ static void gmc_v8_0_vm_decode_fault(struct
> amdgpu_device *adev, u32 status,
>  	mc_id =3D REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			      MEMORY_CLIENT_ID);
>=20
> -	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page
> %u, %s from '%s' (0x%08x) (%d)\n",
> +	dev_info(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page
> %u,
> +%s from '%s' (0x%08x) (%d)\n",
>  	       protections, vmid, pasid, addr,
>  	       REG_GET_FIELD(status,
> VM_CONTEXT1_PROTECTION_FAULT_STATUS,
>  			     MEMORY_CLIENT_RW) ?
> @@ -1466,12 +1466,12 @@ static int gmc_v8_0_process_interrupt(struct
> amdgpu_device *adev,
>  		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>  		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>=20
> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for
> process %s pid %d thread %s pid %d\n",
> +		dev_info(adev->dev, "GPU fault detected: %d 0x%08x for
> process %s pid
> +%d thread %s pid %d\n",
>  			entry->src_id, entry->src_data[0],
> task_info.process_name,
>  			task_info.tgid, task_info.task_name, task_info.pid);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
>  			addr);
> -		dev_err(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
> +		dev_info(adev->dev, "
> VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
>  			status);
>  		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>  					 entry->pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 22761a3bb818..98c8de7307be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -582,14 +582,14 @@ static int gmc_v9_0_process_interrupt(struct
> amdgpu_device *adev,
>  	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>  	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"[%s] %s page fault (src_id:%u ring:%u vmid:%u "
>  		"pasid:%u, for process %s pid %d thread %s pid %d)\n",
>  		hub_name, retry_fault ? "retry" : "no-retry",
>  		entry->src_id, entry->ring_id, entry->vmid,
>  		entry->pasid, task_info.process_name, task_info.tgid,
>  		task_info.task_name, task_info.pid);
> -	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH
> client 0x%x (%s)\n",
> +	dev_info(adev->dev, "  in page starting at address 0x%016llx from IH
> +client 0x%x (%s)\n",
>  		addr, entry->client_id,
>  		soc15_ih_clientid_name[entry->client_id]);
>=20
> @@ -611,11 +611,11 @@ static int gmc_v9_0_process_interrupt(struct
> amdgpu_device *adev,
>  	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>=20
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  		status);
>  	if (hub =3D=3D &adev->vmhub[AMDGPU_GFXHUB_0]) {
> -		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s
> (0x%x)\n",
>  			cid >=3D ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
>  			gfxhub_client_ids[cid],
>  			cid);
> @@ -648,22 +648,22 @@ static int gmc_v9_0_process_interrupt(struct
> amdgpu_device *adev,
>  			mmhub_cid =3D NULL;
>  			break;
>  		}
> -		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s
> (0x%x)\n",
>  			mmhub_cid ? mmhub_cid : "unknown", cid);
>  	}
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		VM_L2_PROTECTION_FAULT_STATUS,
> PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
> +	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 636abd855686..ec8c8b2cab36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -150,7 +150,7 @@
> mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device
> *adev,
>  	rw =3D REG_GET_FIELD(status,
>  			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  		status);
>  	switch (adev->ip_versions[MMHUB_HWIP][0]) { @@ -169,21 +169,21
> @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device
> *adev,
>  		mmhub_cid =3D NULL;
>  		break;
>  	}
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>  		mmhub_cid ? mmhub_cid : "unknown", cid);
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
> +	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>  }
>=20
>  static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
> uint32_t vmid, diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index ff44c5364a8c..72dda850e7d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -87,7 +87,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct
> amdgpu_device *adev,
>  	rw =3D REG_GET_FIELD(status,
>  			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
>=20
> -	dev_err(adev->dev,
> +	dev_info(adev->dev,
>  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  		status);
>  	switch (adev->ip_versions[MMHUB_HWIP][0]) { @@ -100,21 +100,21
> @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device
> *adev,
>  		mmhub_cid =3D NULL;
>  		break;
>  	}
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +	dev_info(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>  		mmhub_cid ? mmhub_cid : "unknown", cid);
> -	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> -	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> WALKER_ERROR));
> -	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
> +	dev_info(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> PERMISSION_FAULTS));
> -	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
> +	dev_info(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  		REG_GET_FIELD(status,
>  		MMVM_L2_PROTECTION_FAULT_STATUS,
> MAPPING_ERROR));
> -	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
> +	dev_info(adev->dev, "\t RW: 0x%x\n", rw);
>  }
>=20
>  static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
> --
> 2.32.0

