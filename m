Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C731C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 03:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AC710E260;
	Mon, 14 Nov 2022 03:55:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84B010E06C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 03:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRhUgMCjsHEopxxx0fwo/6FP0I9ZgVQ2NSvOorTo8ocHZvLCTv+BXYjLjo1YdZL0/XnF/qDeSQaDADmIlHS4ehg8U8k40X1NFx2i5X1T2jJsWwoY7eZKAvfa5NzNbR8yo+zM+2edypR+ELozEP4a8E+dwH1Vhd0gZm0FXSslxyM6TVedNFO2CjNLyNjCLBNql62K+Ivn3lKPzfHgZy69SndavUgNOxppEzkUVJcUFi2izxYehmdZhdG9nXuTwfNNbQ54cNLk4TqZiS5bE8CObulI0tMQJMifWt7FqB1Ef6SzGikO8TqQbalyGAG9N6NQVFa6iA45CRX+gTKMnXg2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5QoPZWltmeyY77QxLa4rLU2Vl+HTggUe2y2L5osw58=;
 b=e0vhUZNbOvFOx5jlJ+ckwWa7pYDEONOaBRhN02KkH7pGhHfWN1eJ7QCg3FBxkOXx53SD0IaCt5drHkwE5jbWhbEJFr8hYk71DNWrVFbpibAlqL7suaPhSD58PDKE8QjpLLv5dfTSDP38C7Pk+Y8Uv7x6r0Ocg9xtD9J+lL5HSc5Sewl6+aR1SrkHPial1n9fbebTMFpYiFzbhZwVl/9Xui0osLY8/81aeNFDbbuyyYar515z0E40nMVPrEwhL74qnUQH+evgVaCzuSV1QhdOKlurCosbEtvVI8wH2eb1/YTd98SCX4gMBPBjAwIoI0U6/0SdWsF6/8pi2DtsVmB8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5QoPZWltmeyY77QxLa4rLU2Vl+HTggUe2y2L5osw58=;
 b=IWs2aqirTZkOOEMUj2EuZpb5wVdy3hRyF5xtK+Fua7cQ0P0Dg3+xrnd0qEy/ESCeGWLa1Kg1Pib1ROYi7wXxASTrkwSpR2xtJ/Cpfsv/hy4pmbvY37KuM3mjdr2iW+mYrUOr2nFAfEUKUMexou9zIFTGbcwi8NwsyKf4hoTNNpg=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 03:55:27 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::10ba:448f:9342:8ae5]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::10ba:448f:9342:8ae5%10]) with mapi id 15.20.5813.017; Mon, 14 Nov
 2022 03:55:27 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add umc channel index mapping table for
 umc_v8_10
Thread-Topic: [PATCH] drm/amdgpu: Add umc channel index mapping table for
 umc_v8_10
Thread-Index: AQHY98vBK05SXzvJjE2IuY/BNLOJga49ygsA
Date: Mon, 14 Nov 2022 03:55:27 +0000
Message-ID: <DM5PR12MB1770FA73D429E800F4F154ACB0059@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221114015134.4079216-1-YiPeng.Chai@amd.com>
In-Reply-To: <20221114015134.4079216-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-14T03:54:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=70c4ad1b-7179-4e1d-8a83-7a8128aa4bc1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-14T03:55:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d03c2725-2978-464a-b5cb-5677e05dc7e1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DM4PR12MB5374:EE_
x-ms-office365-filtering-correlation-id: b341eafd-4a8b-4813-3573-08dac5f410e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHCoQwwYWtHZhMyhqLHoapxvKbA5qHTkrTicdHB9H4c5nwt+z0klNYnDc1kpcO4UAbeP9ADME0DwPwoboa1z8Y4DF6geq7B6ohNCoZwa9GjWbjPIdm1WOEuDiadOmSQhvnUHk19zAjFIj6qn2a0GwcaIXpsS+pFKwtk3dVspIPV6PWy6F9yG83ySfK5OJdEtTnBIOiHDHCPVNx55e4HHx1l5o6C4PSRNxJdyNAq1swnhIiOXxwMlyq277tBXP/ZFk6l+/T1X8XXTH5OJEZ0DsXb8EghRQwCfGZCUBlcmNMRtuQ29MZWj/dFUl0f8J045vCBRxaeD0EMFyiS8dlqHHwtCejHbD7yibLrDQBi6A9lZow15HubbS22lHYtU+zZONajTTYjOf2kP174qQI4ZnvId5vL8ruKFbO6lIWdiUVHk1Psm83eUsgIJO/gZ9V0eLAGvtejbZwPfDdmAW39TnGw9JVFLhOLpul5/1KlrS2kIdYfD74HAlRO2XmkGKWVOAHbew9iWOImlyH2FjpqpK0a10xB2aIWhlcYPCyspuFS7js01uaw7RcSrfWEcIu20uJhLmMJ5BO4G3lhH7R/EuBosprTwEc37pHTXnKlpo76lxNpvLz+1f/HeX0mHgqRaeR6hDUeVTL3UoKzqs1HceLSM3KLrwPPCNmdoQbQsdjPjI5SHTnHciCAdjk7PvPfRxjdJqFtl3vlkuiAndLNmXqJDtqLcV316Q1n9bB3vjWWv0I/wVPZFQOky8guQzBDkIk3K92KUmZ6WwTrKbLN2zQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(2906002)(66446008)(38100700002)(64756008)(66476007)(66556008)(66946007)(8936002)(76116006)(5660300002)(83380400001)(4326008)(8676002)(54906003)(122000001)(52536014)(41300700001)(110136005)(33656002)(316002)(55016003)(86362001)(478600001)(71200400001)(53546011)(6506007)(38070700005)(186003)(26005)(9686003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzqJG8CeYx4dnE6AVbEI7IsF3Sj0SeRrr32XEU0WePH/N0/k1FYecTCvyFqp?=
 =?us-ascii?Q?BuW9zgiyXGzX8bMgaVuNA6jGyzHClT7D7QScTqkK/d5vNott01MyCelYSA9m?=
 =?us-ascii?Q?5Dsx14VMMH1yb1OGeclNFSW9ueSvjdS1zC0nQNAhcdFMl5jE+FmXbd70ZvO8?=
 =?us-ascii?Q?KdseWEWJ0QwJlxWit1nPIX2zw74gZvz9SqmWFbPvFWpAecbXoQIXW41ikuGt?=
 =?us-ascii?Q?OyPtxVrRZQLCtmlc7CFNODqid76eWNFuns1eg3k/w2DzBJAQAgw1Yel2vWrk?=
 =?us-ascii?Q?RdPSxdvewVxxzJEAMDd20EoZEhu2Rr2mpsYfFJix7jSmLH498ZRcalmqfEMk?=
 =?us-ascii?Q?uJxKKdYgEr/HpWEcpF8nqMpddShX3QnNCcfkunmvFu9lRxQ8UWPKKf3UyB/d?=
 =?us-ascii?Q?mEJnl7UuC7073cXNJnMKy9PCqNagccsoz5EhNLkANPelfGfiZ5wNu4Ywjza6?=
 =?us-ascii?Q?8Jt4kOyQmxN43oayJqn235x/KIwAG3ErKW+8ppW4Ml4MSPoa4i+YSbuNsK4F?=
 =?us-ascii?Q?E5REJ8zXiPA60lZ2a2/wQw9bovrGGuSztQivTAyvIQwpq2mq0b1J9VpMcvKU?=
 =?us-ascii?Q?393kVbZwh54Pr8QdycOgv/DPzPez1wHkazTPigtuIwx1voax6Kp1Fx6NntPt?=
 =?us-ascii?Q?bwWDxzNTK8VykdttwYDsOYBtdOa2ZFDLl34KFOPOo9JNVyV7gvX2P+2jZN9m?=
 =?us-ascii?Q?UnH94uYkSVtmpLbB1y0Qsdb5eNk59RYSb1mUmhmNafI8t8Kogr/jo37pxqgZ?=
 =?us-ascii?Q?WN2q5rtAiQe1yVOkba30RVNCCmaNjnWNLnvB4l8GsuProqLeHgYEzJHA1MJn?=
 =?us-ascii?Q?y26jjHP/9PWDFcCqs0qbzl2uQldI5fjC+WV9Yj3LkUWJvCe+IoW+qdst7NjR?=
 =?us-ascii?Q?1sfsQU01zK02x9LPdTzf3Dq5wwGE2+67azj6FhboZxkElM2lswRc7YJpN5uH?=
 =?us-ascii?Q?1uvC64awdsVWJsop5k/IGMPKFHoRHQ/8UU4j+o9eDKuoUpE0jOAEwsD8KQrC?=
 =?us-ascii?Q?hVfHKSPG2xRtiAUIJ6bWhyXCR+9x1KT6fh+6ZlptJMfOedTsUffJm2KmLMEb?=
 =?us-ascii?Q?+d9J+P7wldkG9r9ATxTgyN3d8QCKo/xXLG93RWlFbaAo6zlEmXdz8HK8zNPq?=
 =?us-ascii?Q?z4Uialdy8zZXfRjtBWlnV1dk0THe54qWygN8iRJYZ+1Ihl4LrRq48b2egOAG?=
 =?us-ascii?Q?PoHtwoEY5Ru57NVmu5Uke0YY65dssB3vEbln/k07ojOmmVuY8F1vGgEsX1+b?=
 =?us-ascii?Q?qsDq4Qt14F7rgKqqBJEGCgrHOEH/MQNmLeQk0ZgMDBK4SkT8nzk8ZZg4ULl7?=
 =?us-ascii?Q?Remt+zuq3CuC04O4ah8duaqnVQ5qxyeBZlCLK2FB3RCfeA4gDVskz0EyHIcw?=
 =?us-ascii?Q?z1DbFyIEc+UIwjLm2qYEWPh8HGlNcwIVaFe/oNvQPMRlIj3Bd6F2V8YYR+bo?=
 =?us-ascii?Q?u4oRXOW29ts31gF3Lg/Y0a9y0mOolyevndrzD6SVnXh7uFO/oOB55kv30dqC?=
 =?us-ascii?Q?PFnbaNN1ynHIPxmbHKExOzf247EmscEuJ//91+l+9ekSZ+bPSrEYmpU1xFX3?=
 =?us-ascii?Q?zGsz0+EbnlL4E7TXPkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b341eafd-4a8b-4813-3573-08dac5f410e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 03:55:27.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfmQTtdNTEVnCaXXvrE9du0h5mJrSVzOHv/gOZ5ft1394mjoGBJdJKdkISeiYwJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, November 14, 2022 9:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Add umc channel index mapping table for
> umc_v8_10
>=20
> Add umc channel index mapping table for umc_v8_10.
>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 ++++-
> drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 10 ++++++++++
> drivers/gpu/drm/amd/amdgpu/umc_v8_10.h |  4 ++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 16f52049d986..96e52ec0fb69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -558,7 +558,10 @@ static void gmc_v11_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  		adev->umc.node_inst_num =3D adev->gmc.num_umc;
>  		adev->umc.max_ras_err_cnt_per_query =3D
> UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
>  		adev->umc.channel_offs =3D
> UMC_V8_10_PER_CHANNEL_OFFSET;
> -		adev->umc.channel_idx_tbl =3D
> &umc_v8_10_channel_idx_tbl[0][0][0];
> +		if (adev->umc.node_inst_num =3D=3D 4)
> +			adev->umc.channel_idx_tbl =3D
> &umc_v8_10_channel_idx_tbl_ext0[0][0][0];
> +		else
> +			adev->umc.channel_idx_tbl =3D
> &umc_v8_10_channel_idx_tbl[0][0][0];
>  		adev->umc.ras =3D &umc_v8_10_ras;
>  		break;
>  	case IP_VERSION(8, 11, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> index 91235df54e22..b7da4528cf0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -45,6 +45,16 @@ const struct channelnum_map_colbit
> umc_v8_10_channelnum_map_colbit_table[] =3D {
>  	{6,  11},
>  };
>=20
> +const uint32_t
> +	umc_v8_10_channel_idx_tbl_ext0[]
> +				[UMC_V8_10_UMC_INSTANCE_NUM]
> +				[UMC_V8_10_CHANNEL_INSTANCE_NUM] =3D {
> +	   {{1,   5}, {7,  3}},
> +	   {{14, 15}, {13, 12}},
> +	   {{10, 11}, {9,  8}},
> +	   {{6,   2}, {0,  4}}
> +	};
> +
>  const uint32_t
>  	umc_v8_10_channel_idx_tbl[]
>  				[UMC_V8_10_UMC_INSTANCE_NUM]
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> index 849ede88e111..25eaf4af5fcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
> @@ -66,5 +66,9 @@ extern const uint32_t
>  				[UMC_V8_10_UMC_INSTANCE_NUM]
>  				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
>=20
> +extern const uint32_t
> +	umc_v8_10_channel_idx_tbl_ext0[]
> +				[UMC_V8_10_UMC_INSTANCE_NUM]
> +				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
>  #endif
>=20
> --
> 2.25.1
