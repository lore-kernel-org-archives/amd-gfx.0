Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3091BC678D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 08:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD4010E381;
	Tue,  7 Mar 2023 08:16:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7829410E381
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 08:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNWRR2hjhNIUubrmnWF3KNpLd4anT1QE682ggjJeFblLQ7mZI1xPhi5OamRlLKLGctwR//CdcokPUpLtqSUCTpxSK9JROV2knbcgiG3DYi5XtEyoAvvPTDAextvdKCITTfR3ftW3Rj6p3muHuvP9saepZksm1HruU8ixLhJHB9+Yu8TsD7KQRZA/T2MpT18bLPVm11rvvMnCQAb58ZWG9/vos61bEPw75hn66jsfK3BbUIwJNwdO8xSSlYPnuK/wsLwlM4Uer+cZUYLUznNgyPa/KmLRFWAtIN3BNFJF2ioCp4jSfytHfLFmm1OlozjnmNk87FanMqXVSXt4u82woQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvzZKpZVsm14DLdTyq3EBF9RCH1PvWFvpZs13qxm3L4=;
 b=hnYEpqSlhA5n8HNeYCEPO3sYupG69rhCuyvVGyWNN0V5+68HbhmWgqVQ2hLEOYtTw3Mek5ZSvcw80zAAt56r/7zsO4eXSXWQ0gaPhqVX4rYCaAiBzX8dkVlCDiwxXKNUQ+rIFp900fOFalOc3A97WpiP4IGQHhbVlLCNu6fectpsVr6vjtoNXWZ86ssr9aXIdxRf7Ee8221drRvGts9rbH4wkyr5TvlMvqSVc+6XiolQP9SxoCHpbHSUCWRYAip412VAQJdAPxoQnUQ2vl9jGAZtWZVqECE1Gw6/vTES59EsHVBjWo7J25o3BIa9wVJTgRP9IFqjz6cSEMj6RS7FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvzZKpZVsm14DLdTyq3EBF9RCH1PvWFvpZs13qxm3L4=;
 b=qv/txBjWFePAW+kXwYTOLUJEuy95+3oxenke3qUui0726anvIRdWgoUWChoG5pECMpLbn/MQvOWQBvGnG1HFZlxfoSTXo602utMf7yHD6mbyiYz7K59aHWeMemHgaJHI1vqu6FuoMSkiXP1IxtEsNGynbhw4FwrYzb01buNtKss=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 08:16:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 08:16:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc15
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc15
Thread-Index: AQHZUEPkg/X+jzOqjk2sxGixStXFxq7u+bNg
Date: Tue, 7 Mar 2023 08:16:40 +0000
Message-ID: <DM6PR12MB2619E8A81758C67650D5F7FBE4B79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230306155348.41081-1-alexander.deucher@amd.com>
In-Reply-To: <20230306155348.41081-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T08:16:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a62374ee-7dab-4a6a-8a01-99252deefdca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4500:EE_
x-ms-office365-filtering-correlation-id: e9dd6efa-0ffd-44e7-3ef7-08db1ee447c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HeK3WF0wAGbcgEI2wwt7XHOp9WTUY/oyBttUdW0RQsJ9lCfV5SoqRfrGsxV53/Jz2nSkriVXHBmwGO0DFmgPKFVxa3gQR/bl+rOdnx+5Me8p/G2L3u7HikaXJDXTiC60qQZeLw4wGiBkQbXz9NCxfreu4+DsbZNYl/ZD/5Y6dA+92S3jalQNvfSdNqo6P9bvY4disO6HN2BADPhvr9s8wAzEHVRQINicRPUvvSFvuJBVajv0rVbaWu4gkeuc1II/chOmYCqsZddFYZS3ZafTcFiMnjPMhfOGkbkzSne0kplYL5wmaVqIQ28P2/E6XxE1pmUZJNa7zm/OOcXdlTR63DQxNdNvHgXXk5LETCwq6b7HQkMBZep8YDqMv8Xgmya9PnVlEYx5A9KF6xVhBAWgUziTZN2z/KuNrL1qcphoxCDHzGnfhrjDezcYwta7kGnVWdfSqM/ygMEW9EOkDmNvNwXYclN93Lc0qqqLNYUKaGmHJig7DGb+W2Q2g04I5ud8iHfO6q+To7bbUISRkTNEjyICXCuFrnaKauHOvQxz3Jl7w1N3J/NtAeFoGiAQE0xvGCCRxpOAY+iXzc3koTvEpJn9f3LtFR1j+SZ775fxj8l5+/bW0QZWw5HoXdWMf4i0vnwZmfghbHDfrqmWQA49oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(84040400005)(451199018)(38100700002)(122000001)(86362001)(33656002)(38070700005)(5660300002)(2906002)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(8936002)(8676002)(66946007)(41300700001)(52536014)(186003)(53546011)(26005)(9686003)(83380400001)(110136005)(478600001)(55016003)(316002)(6506007)(7696005)(71200400001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hCpWhWXujHTqQWDqur2Wp9yevEZfSsNATjAAHj4sOEkg9509I8JeKPsxtZgW?=
 =?us-ascii?Q?5D+6fY8Onyz9DQo81D/mNboyhjwkUzq1v/AdQhM0m9COFw2wbKqKZz6hsfo5?=
 =?us-ascii?Q?E6ZnSq2l3CVV/8icam7XtsKdRdsI6xzx59jo8AiXJFX8LiCXbdhlTpg1x+gw?=
 =?us-ascii?Q?djXGRtu81xhAv53ZiGFRdUo1hZfHYNgYqLXtp4gRzmtLVmVuQc08uUVr0Yrn?=
 =?us-ascii?Q?3nHFPSc2nKawYVN8y905pVKADpeBKlzJ15K4fk+XOTIrsuuZGGqnu9Dorbkl?=
 =?us-ascii?Q?DpM2XoMvZwoD5o2OuGVHEHzhPJ0k+bfAk1zQdSztOD7YRw6bsLBLIlnEico4?=
 =?us-ascii?Q?NdFsk3NpuefBJMA/E2gH6KaCuI9wK57O6WDQZ40PqTBEfn5emp7hpxeClzHF?=
 =?us-ascii?Q?KKQgtrTJ9cLZ3RY0UfGstbjWhhkMIKVbMMy101spSR/XpPzSmw0QrOydBkRl?=
 =?us-ascii?Q?9OpDIyjzbPu94MPgQu6MV1CajzWoqp2Pfvj+jfuPQtpUjDslFEvF2hE1QIEy?=
 =?us-ascii?Q?RUbm+NOr8IOTPco80OGXo+QFNYT6haPXMPhjmAQkWOWbf95lzzUrohtvehnh?=
 =?us-ascii?Q?f28Yu7+URZZiaztMMRXY55cJX7GN3NV6XTWF4RdIrGOU658dXgXasoKyqo0I?=
 =?us-ascii?Q?mOOOsdseYCMvBKJ/KrDIk+TBU6KY45AifNIe4O8RHVg77pV+6fGYkZ9vCXE1?=
 =?us-ascii?Q?k1SKGRxBK73tGLVb67nV0QHFXdJJMg/dj99YhWg9PYp/ohmDuXMLEftq3O+2?=
 =?us-ascii?Q?vNwx0eCv4lkwjd0xFhEZfdD+ycJTEnfPl2aLyEvepNTum/XNDtnbBpPCIiU+?=
 =?us-ascii?Q?wVrXfL/my+tmYVr844d0+2FgZvZa8jeo50lA53xR9LEAIxYECIcaI6qLhdg9?=
 =?us-ascii?Q?esXoNAFsWv3weuIZ+oNOcmyAveC8D5NEu9tEFiAzushox+qFNMDcx59KgoaF?=
 =?us-ascii?Q?hRIuZkIksnFkvCukofR0lzdzhRtZ1vvi6jneaAWMGPHCS2rbpMQr3fzfWxs8?=
 =?us-ascii?Q?UBqZJn7jYQiv9MuvpVHdgq2QJ3U3h6kSQjgPo7hMrnFrAhFpm4I832dK3fQv?=
 =?us-ascii?Q?bwlY9XWBU5DLQJVc29gHFXUNznnCV8uaJHTAAdgmGalPCIYTx+jk0wzsoBQl?=
 =?us-ascii?Q?YehZ70FlRjQ/ZVD5pKoGH7xykba4y2jykIRizHbXxEwN8v45a/zbl6kYhpzu?=
 =?us-ascii?Q?h4ojiYYBj/KjungX2aZ6PkXsBcs9cZmWyG/yUY8cKoU+uBB7nUw2t+u6ghvt?=
 =?us-ascii?Q?F6mP5wmuUNgN41pD1XxnO88EBsKw0rjwoe+qmV8QWHX6GrBO1DuTjNsuRhTi?=
 =?us-ascii?Q?ZM6++lIqrrE0ZE4PhMk7mzzNVLODQBrNt/+8uRRMNvEmnDkKfF7nIrxcANDr?=
 =?us-ascii?Q?3wZhPmND39hthq60VDVYUiu5aUemc8KU+Lz15IRBKVi2t11uGUIIFu7ySIet?=
 =?us-ascii?Q?FLSs6EDg5BmPdDBRjqfhO+6XqZz54zOLYzPRk/l+zckG+J8TMpNIxA7dbEfl?=
 =?us-ascii?Q?GvEvVPGlMYT/aIWVrEpHODZFN5TXQZ/aw5nG7fivLSrUcsbM8X4Q+o8rUqrl?=
 =?us-ascii?Q?ls9ZItuH4Yu7D3sM3d0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dd6efa-0ffd-44e7-3ef7-08db1ee447c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 08:16:40.8452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 850xj8RG9I4ZO1+PdAcAMiN2FWESLtHgGJsFCCMp9bVn7tJCEXlk8ARk7Lv+fXYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, March 6, 2023 11:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix error checking in
> amdgpu_read_mm_registers for soc15
>=20
> Properly skip non-existent registers as well.
>=20
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2442
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 7cd17dda32ce..2eddd7f6cd41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -439,8 +439,9 @@ static int soc15_read_register(struct amdgpu_device
> *adev, u32 se_num,
>  	*value =3D 0;
>  	for (i =3D 0; i < ARRAY_SIZE(soc15_allowed_read_registers); i++) {
>  		en =3D &soc15_allowed_read_registers[i];
> -		if (adev->reg_offset[en->hwip][en->inst] &&
> -			reg_offset !=3D (adev->reg_offset[en->hwip][en-
> >inst][en->seg]
> +		if (!adev->reg_offset[en->hwip][en->inst])
> +			continue;
> +		else if (reg_offset !=3D (adev->reg_offset[en->hwip][en-
> >inst][en->seg]
>  					+ en->reg_offset))
>  			continue;
>=20
> --
> 2.39.2
