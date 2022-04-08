Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99AFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 03:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B122010E136;
	Fri,  8 Apr 2022 03:10:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B86C10E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 03:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2vgQWyw8TDt9jkelD3V2D1Vt5o+7hRvWp3fgGSHg4TkKszx9KY1eusfoPivXHRPm6pWRCEOF3oZqoKdTI9U8QlmLGwE4nEzBROUyGKzqAI3hQdmWtD+Ltp0S5IqeA8oPoOrCX9Jj7EFEXfNVoMcPDXmV3IH5iS3rM2wKfdlCnCldqLw8+5jJRNMJtDXk+FyUW/D3qdWwtqdndGOeSbDH2Qlwulp0r6po0/OrEQKwK837536XKpfcuNmWn8SEF4aDghXahQ+cpXXEGiIn0HeaZBCrcLkNYpsEMDseitgMjhk7gILVF7npPW2UgH0SGYLxWLGv30dLP0un6hCv2zDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa27OmrkJy2OHrjTFRPdeeCkaryKwzC9BLJZmQlGI04=;
 b=F3Wgj7Uvv93qZHa77Wv6uLPBp2vcFfzuhzK82i0kxdohh5QleBYO4sUdXjgnBii8OD3946HgKw85BxYaZd8orlEExWQHobAxn3y8T5ppoONNiV7Dq6FYZDAB4NezfSYT6A8df0PA7QQ8CdZT/tgkFAHi/Z9HJHSyF8YHrpqSqy6rkcdikhMJlVwOsud2GYZbldrJGEC1Y5ykiK8WOkYB7ZAoCf53AlNEDqMTelyZ30Nv/IrmmrNmZHwqwK/t0WjXXIULso6oAcYFTQjg/dyDfBp2mNffswYDhATtxIBU1qVplciVGRMgeJ9NaTgLpCvUG0D9SSHitQRZh9WEm2g80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa27OmrkJy2OHrjTFRPdeeCkaryKwzC9BLJZmQlGI04=;
 b=mwe+6wr3RU9E7BNUxPpV9osjaQyBg8T2BJ7PbgPOb6TAfeH6ELFddiy22TBUKuFyFRZubSKPICR2zJEUMC6PohjXXTLWENf6h3tJo6gb3usGRSYC1SLzGFAsjFTUz8q+dr+0kmj++THWwTWtZrcjxdFBhDoL/0I3XZXe+O08Ze4=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:10:40 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::4004:ae31:37e8:629e]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::4004:ae31:37e8:629e%9]) with mapi id 15.20.5144.023; Fri, 8 Apr 2022
 03:10:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
Thread-Index: AQHYSu7zBP6lJ9Adz0iM3I6RAL/bVKzlUzWAgAACxTA=
Date: Fri, 8 Apr 2022 03:10:40 +0000
Message-ID: <BL1PR12MB5254903B0B003945023B3D0FFCE99@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20220408021826.12173-1-Stanley.Yang@amd.com>
 <DM5PR12MB177014D82A157785A35EDA75B0E99@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB177014D82A157785A35EDA75B0E99@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T02:49:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe06eb6b-bd48-453f-9b93-84ec83ef45e3;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a992da19-9997-4ecd-b4ac-08da190d5cca
x-ms-traffictypediagnostic: PH0PR12MB5451:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5451041877A36E579A229E9BFCE99@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDEg+yh8utRwsNSQLxuYeZfEIJ/AtK/sjesAN+QREv679HXCKi+zfEJddWBFZquE3gqyL63uhI1MqEkKDt1wC7/QUyMDJW6j9LwBsvz8Y/p726/UruUCHycxu+QaCS7soBq+DLkRaFHhZlLlL+Wb1/V1Lxl7l196W9r3mhP3nULrWhFeUeftNPrrAQ1KJyCfutWhhnkfr5WOxskuHZozCx/EVLmKeOOEyIiKLM6vIPzYZu78ifoUwUX/tb1PcpVKBsncwvOpmgUeFKHtewDCtC0WkYJM7TKt2I20nMPLTnCVEjEa3E6dGVTTay2KqfrRJf22DwRIaYmSmHQyDz6+a7m2jeac+u8aSikfCZdsvQTXgrw4fEZFvqxF8DuvSSCB26XJTvYsCF1PsvzgwVvdIMT+Q0GkzcMLKR6nO4GzXNIN4GjKXHCiZkDAP48iaYQFoxZ+WBvNU1sTm6TWKjnDC5E/VH6jpzWFjAJAE+sajZzl7PRtkop5k22DpEy1KZlCRlmeGAOKXm7NLD5WlQDvmWqOT1HHaZZsli+llO92FrQIRS1cMjYpoaUzJgRa0M+qkaKnsSFVT7M0G7I/ZmtEgCmt2B4K3pbRgxnq5YlYH4Y72VLajZC7/xTT6Il9dV9n2YNRm1/8+Z34bL6yDL+q4eX/y3/Uc1u9NY5N65Xk+6xh9X2+oLvGQ9uGUoFOxOGYN61oT0K5n5TJKhFBVOcxkTHaP9WrdX+ESIJ2luMyqqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(316002)(4326008)(7696005)(6506007)(5660300002)(66446008)(66556008)(38100700002)(64756008)(66946007)(66476007)(122000001)(53546011)(110136005)(76116006)(86362001)(9686003)(83380400001)(6636002)(186003)(508600001)(55016003)(52536014)(2906002)(71200400001)(26005)(8936002)(33656002)(38070700005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?339d42RAWVeXWvyb4eXY9xc+mgdDbPLme97XrDIxyTfplmhwF9yXEVY+Ast3?=
 =?us-ascii?Q?jBTvf+Ld9+8Z1TePwPIKzWnaBEDu2i27v55qMSckTlpWw0wmpmjxuyGCXEUC?=
 =?us-ascii?Q?kjC6az4/JfYYcxMvCEcROeMOxdbe8fziE/jUOBj5VjEZgTTCKuup6U/Yq7GP?=
 =?us-ascii?Q?zptd9y5ic3WcTPGV6KU1fWEm/vw5tRIhsszBu7pTbhLyQxiowov7gJKYOnw2?=
 =?us-ascii?Q?DTcBgQ1OALaYq5lEhSnMr9eSeVsUBNAmc3e70kKnrdxCU6M9Fo2UVvP34lMh?=
 =?us-ascii?Q?IVQfSsf5i1jkgOtlsa5DOt6zv24BY8P6OjfrgJAt7mk8PhnSBObkVpGqZF0J?=
 =?us-ascii?Q?OAnLAi98sl0PrYx0jnc+P6wR0C5C1nHUmtBlhIH4qgjn/mp/zmKrmMOSdgrR?=
 =?us-ascii?Q?PeSoycl2iSUIPtghmdLBNrBB43AgzvWncJTb3NBa+kXPw5YWjeX1WmOiAGh8?=
 =?us-ascii?Q?brt0rhncPXbgFP6kkj5dJLZ+hltVKeR1NwpyQv5X4JXjOKfLmAUNHGAbWfVK?=
 =?us-ascii?Q?k5+wIjLbkpVaGBWBhxxjRQGNxpmyxSglLankgNze3pAt+Q43INFOE5Jj4aVc?=
 =?us-ascii?Q?mIT/6QSpcBrcoRrYV0dy4vINDQN6iABED+KpRei7SJ3xdn2fHa1OItr7IvX3?=
 =?us-ascii?Q?z03NM8v5JPxVUm8Cq+SXPZVF/uD4IpON8S5Gx3AvHlAlwwXP51yZqe6J9mM7?=
 =?us-ascii?Q?3VID0wPBcHIPpoNQMGzmd/PRAVYAdEYiYFieolk1AfeHMkM3F79kcMlxyD6c?=
 =?us-ascii?Q?509Xv3OfnNE18u24o4Lf+xZlXOb5+lkyVVBZ8hRb2rv/TgC3IjiYjVIH4ey/?=
 =?us-ascii?Q?V3WHO+P/EDsOsND6qJehfq3AIw4acmv7NifaPmHjO0d50Us9upnVk0pKTzFi?=
 =?us-ascii?Q?5PIrmETYMBSL6HCiDyXYyuBKhqQbVwAa05AcKQJOLUnDTGF+hPWVSysxHjj5?=
 =?us-ascii?Q?D50FQN63iUWXxL7wUG4RsWAFpNyU67lUGml5aWWdnKPsaVikxVrwy9VDCZY6?=
 =?us-ascii?Q?7zYEvg6ahyyVC16Qu6oLIY06lhbXJD2sk2E84789aOPPe/CwdEM8Dly+xQ+3?=
 =?us-ascii?Q?sFXIKVJxSVNctVSXT4hEB1VFppkZIV2LB3jJ1JGwH672SD83ohHvlhqK7mpu?=
 =?us-ascii?Q?U1MiM2Zglxzgok5GSx6BYi7eOFgzVKgTX9pAQBmOp0IPD0jHVQFyaWNdhuBm?=
 =?us-ascii?Q?Key500yN/5A5K1gwbfVajA+1M56+HteVdJrTmXaXAGjgNPlwc7N+NVWCKWym?=
 =?us-ascii?Q?tj9b1tIUqD63qTSh7WYaOAM1L595ltbNWNwr22FVYbsp1LZeozlBb5HLwvlS?=
 =?us-ascii?Q?VnljAaWQvDEjb5mZVNb3MNlisitPtXpfVFmqHalhCMOmNkXpA/PwG2Lcvc3L?=
 =?us-ascii?Q?c8YcokSAgNb7/EsFSw1uW9cXmr/JYqXuM+zqRpdhGEsqXcx18dmD8zMny1c6?=
 =?us-ascii?Q?Sw/AmrsLH9F3nTORGlw+rnQWHAnl8s7tjwNHu5hVTLXhB4INyVSZUKkf+wvw?=
 =?us-ascii?Q?pVF8FOPbXbQNAWCGOgl2+QJOGmeElQbToUu9HWPOaUFbKkzRnkDU/rOtbnBW?=
 =?us-ascii?Q?Mt1UpTh5dHKS7wltmoLUONrkJlXVJ+s47uW1nVhq7x+gl65NTRFa6/vy/Fed?=
 =?us-ascii?Q?jrtiK5fjOjB51MWqcP5dTcLie60dZ/vwJmGHsziUHda/Bku4jVkZzKC7Sabv?=
 =?us-ascii?Q?4QJEtJAAMQjc+6wKLTXNI1WNuq2OOCmJ/fZua+QOJfcn79JGtswvIADTs5xh?=
 =?us-ascii?Q?fCExKaGmTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a992da19-9997-4ecd-b4ac-08da190d5cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:10:40.7623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8E+V/XmmfW69/dfTXMnNeiIhYz6x0Qsk0zTBv2JzBQx1U5737QneIQo+Y8BYyfyBgvLqr7XsBSFryXaI7MC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We shall consider centralize UMC MCA status check in a helper function, at =
least, querying IPID, SYND, and MCA_STATUS should be the same for both ue a=
nd ce.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, April 8, 2022 10:59
To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: print more correctable error in=
fo

[AMD Official Use Only]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, April 8, 2022 10:18 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice=20
> <Candice.Li@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: print more correctable error=20
> info
>=20

[Tao] it's better to add description for the patch.

> Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 62
> ++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index c45d9c14ecbc..803119f75e39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -70,15 +70,46 @@ static void
> umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device  {
>  	uint64_t mc_umc_status;
>  	uint32_t eccinfo_table_idx;
> +	uint32_t umc_reg_offset;
> +	uint32_t mc_umc_addr;
> +	uint64_t reg_value;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
> +						umc_inst, ch_inst);
> +
>  	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	/* check for SRAM correctable error
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		if (mc_umc_status)
> +			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n",
> +mc_umc_status, umc_reg_offset);
> +
> +		/* print IPID registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print SYND registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print MISC0 registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +	}

[Tao] can we implement a query_error_status function and:

1. call query_error_status in xxx_error_count function, like this patch, or=
 2. register it to adev->umc.ras and call it in amdgpu_ras_get_ecc_info.

>  }
>=20
>  static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_device *adev, @@ -242,7 +273,9 @@ static void=20
> umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>  	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
>  	uint64_t mc_umc_status;
> +	uint32_t mc_umc_addr;
>  	uint32_t mc_umc_status_addr;
> +	uint64_t reg_value;
>=20
>  	/* UMC 6_1_1 registers */
>  	ecc_err_cnt_sel_addr =3D
> @@ -277,8 +310,33 @@ static void
> umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>  	  MCUMC_STATUS is a 64 bit register */
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
> +	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D
> +1) {
>  		*error_count +=3D 1;
> +
> +		if (mc_umc_status)
> +			dev_info(adev->dev, "MCA STATUS 0x%llx,
> umc_reg_offset 0x%x\n",
> +mc_umc_status, umc_reg_offset);
> +
> +		/* print IPID registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset
> 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print SYND registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA SYND 0x%llx,
> umc_reg_offset 0x%x\n",
> +reg_value, umc_reg_offset);
> +
> +		/* print MISC0 registers value */
> +		mc_umc_addr =3D
> +			SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +		reg_value =3D RREG64_PCIE((mc_umc_addr + umc_reg_offset) *
> 4);
> +		if (reg_value)
> +			dev_info(adev->dev, "MCA MISC0 0x%llx,
> umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +	}
>  }
>=20
>  static void umc_v6_7_querry_uncorrectable_error_count(struct=20
> amdgpu_device *adev,
> --
> 2.17.1
