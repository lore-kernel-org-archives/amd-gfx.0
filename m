Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E69EC7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 09:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C9810E2C0;
	Mon, 20 Mar 2023 09:40:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2260810E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 09:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfuSS53DpB1DBfCBiY81Ca/Lc7kH/tkSuxt5TuYcevVJjZ9ouvz/f33AE9ZkE+sijdRnhmEHuhUrnaLEwV9PK/yBiG0Mz6SwynpdueycDaORI4gCSObelZuY+VoXzFNt8gvulKtCD5hy3xgSCFotTwgS3d26VQ0PqDfKvjy1MDq8hB6Jgtyhkp8/jSabbl+alFojfUHvAQVSQbUSawDESmMz3AITA7LAgSRjQprSimBR1c63rSFmcpkIgarCjDYTwcSxu2X/77/cj2acKNoNm2NT0z/sagtDnTfXtzm7t0573hv1n++I3sgEMXLfgQrUxrnzDKwjYCVBVrY9pIiLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXpK5bWRJ/LrdvduykhEWITcHLR1i56Mmcb8W1Pqy6U=;
 b=YLRA4WeOM7rp2h7GT69yry03npce154OCbf1yhZN2YCDLRzB6kUQ24Bwo4FC9DkFnlGdovXe1hFGapieMmUXXlyuMNQlUKYfSV6Dy6FJiXNcebvbK1hkgQVbyDFy8gB2Vcfp2jtSag3aEeroMTmU1I+dd1HigaWzOBX9nN/Aw/rctv0xRadvmD6EoO+uaey3smFqFdswtNwQ1kRDn8+8oMO6Btrq/yF5zxhZVyAjKVi/xfi7J5vBkMlEjviZu7jhEjPoWvN8xy9O76O+AfFnNlT1WeXKZu1xbazz5cJCf+G6ahd17H6qqMg4K6R6aDBARkPFUFzTkk53Ppgofah8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXpK5bWRJ/LrdvduykhEWITcHLR1i56Mmcb8W1Pqy6U=;
 b=EcH6c8fvnV3IxAhguDV0oSMjNvUWQbvIZm79x+9EJ9ime/VOIb7bxRrCLoDcXkMpVwkbhCCZRd2mXl0Oy85okYXJbMp/HP7T4ghvgG9cKRBCoTjSG8alBQLkMlVrr88MgHoJTHobua34ibhxpgGdNUiwuRge8xGNqjYHSm8RcmQ=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Mon, 20 Mar
 2023 09:40:08 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 09:40:08 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Initialize umc ras callback
Thread-Topic: [PATCH] drm/amdgpu: Initialize umc ras callback
Thread-Index: AQHZWw+MVpdoPs1Rqkmxz4ReA4kfs68DaXIA
Date: Mon, 20 Mar 2023 09:40:08 +0000
Message-ID: <BL1PR12MB53348BC9B779601FB167010D9A809@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230320093648.30914-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230320093648.30914-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-20T09:40:05Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=152f2e60-8257-478f-aeaf-518f29fb9636;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-20T09:40:05Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 957fd8b1-3979-460b-8e2f-0c6613f9ff81
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DM4PR12MB8450:EE_
x-ms-office365-filtering-correlation-id: fc8b99cb-ff71-4089-e555-08db292717ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEjrnQ8pL7oimLDOydri8TDUp0quKGxh4lFoedPfmKONL99wDTZoU82F6Aqc1VWDaRbfpt0E3ebRUgdP5J1rvVXcAWlovZL15ayGGh0vryYFi+CxxCI7ibY7SgudINWdgcII+N89dUvqABXvMCNVmE9NdoRqaq1VnSeNT6AJbRZj7cdqS306Yem6zkph/e2Mr1RE8CghISmsmDJmZXScjaswJCx5If4/QZBSi3iMICqZEM2qOLpeG3LqQE4qrrajv2zsh/EOfHkH+uroXyqeMgHuOiZ5e69Ubx7kJOscLyEWJBGb6e1cpk4AJeX1wivOsqJFQdG3AYo5fqSCtZRxcENAp9SRUT0Uj58+/684AxJQ7NKc606kRjuGUX0WPWJpyzLzW2Gcr4z2JT9qE3efY+aN8HwHBEz6kaP+q7Nmy+8tNEywngzpieVNlovcCkrdUuyIUrBT34So5/r30M1YDFJ3mb13Rk+yQxvA/knONTE8SCgq5rFeuWnrg+IXIPqPh80cfkX9jeWUzIHsy+IyGvncLMQSQmgnsepjXTwfYf3G2HKikon5climSG9DJdUC4gJ0kEk6NMESDh58nmLxzhPpu8INH3sVeaL+iEBZ8ryMgMSf5uN74IbwwYo/TOn7Y415Q/gijp+zTlGSv18sdM1hoeYPiS228qlL3vL1Sqrf9aOsVG+nNyZjh9a9xLpFP7PR2pX/IUTObGIPqtqhiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(110136005)(122000001)(76116006)(71200400001)(55016003)(7696005)(41300700001)(83380400001)(86362001)(53546011)(6506007)(8936002)(33656002)(5660300002)(26005)(186003)(52536014)(316002)(2906002)(8676002)(38100700002)(6636002)(66476007)(38070700005)(9686003)(4326008)(66556008)(64756008)(66446008)(478600001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FDg47iBCNd2id4ytgQtY++68gtlaqwEt8sMTWzd0X9SHttnaZ1aomJpyElLp?=
 =?us-ascii?Q?NyWdH1twdfeABJARfg1vb76VfTR/8YPSngVBd5AMGfTOFLNYeaj6uSo/1jwA?=
 =?us-ascii?Q?DoOn5wxfsZFW0dI+TOqZOaaLHQgednqdAT4ZHEMCDZzqIVke4WMgEYiANb/Y?=
 =?us-ascii?Q?wDf4TBBLF6M7/3DDtiQrYWQYXRdAPu7eNwR/gMRYUbHJuMyrqhombbByUSAG?=
 =?us-ascii?Q?9rDfEXzo/CXxCp140qCPOcCp9h251f4SeWePhl9482mMPnYOWqZLuhJJ6pDP?=
 =?us-ascii?Q?f0YXuCLchJOutZNJIdZzrpNSrX0W5zOAeqT8ddCQATmBaOjkswkXtMLH/gY4?=
 =?us-ascii?Q?7NKkVXoLqL8w1RsEC7Hb4NFs8d1DZQm2aDT5EQB5HX+2/yjVCFDaUlyr77vh?=
 =?us-ascii?Q?sp94BkClOAlsNuiPdHvnFie+inZ+rIGYqVvCgVzCO+k05WlzRp1WQ/xjWTFQ?=
 =?us-ascii?Q?b9o5QK//fH7+nEng3r82JT2Qs6oduM/TGEw9/FgwTZcbTQskXVT90ucWlkmU?=
 =?us-ascii?Q?VIdQGiAaaiz6HozW/x/C1kj8usKYVcPRSa7vSnusPuzeQS6iT6JR4MXQj79E?=
 =?us-ascii?Q?lbwVPzOEfbj4+Z/HULTiTIpsjXco/YdpN4anCfqN3++Ux+hh9QMadkYjG4cw?=
 =?us-ascii?Q?JeiXK6wuYGFSXo75H26rwqEnz+QEowGaE8lGpzjQUkQKaIcSjVuOqyzpVucm?=
 =?us-ascii?Q?Ji6BDi7z/1DyBO45ySfd+gYqrvhOJwzDXKk07adMj1NfezzpS3CgWg317QPK?=
 =?us-ascii?Q?DmtcaDZyIeRzmAbTqKuVEj8ZfqgeJq9bvIQ4rECho7fGgNhABtAXhodUmAtO?=
 =?us-ascii?Q?t1I35z/yz8mC50Y79yOZMMRBBRq+4M54fExigzLm4R+bDzxjJ1zR0NqGaBwn?=
 =?us-ascii?Q?OLpFWEwPhdDOuJyRPIvuB0UO1Loi6D6GwysKxMg1MpQAXnQvvumBprxqD0wG?=
 =?us-ascii?Q?Mqs7wEGmZXZNtqm1FjohjZGK2gawDm/RKvh/rULW4m97MxhiwGWxD3wE8ixf?=
 =?us-ascii?Q?2QymiGSdflZOePFDeKmMhwMjBOGYDcJCAGAzNAunLy01QvsjrByGps5bvtnX?=
 =?us-ascii?Q?2viTzWG32N3W+ssQzDcIzPrLS1/r9ilZSqgkfSczUHTVZskCfJ1bmL9TR4hW?=
 =?us-ascii?Q?I4biVxMhgbgbjyZ3mvQTwIyp6D0y+P4kU3gzTI4/jDBjVE10M5QBK1wN2sgd?=
 =?us-ascii?Q?RfPNz5/JKJBydtBxNNhjLz07PMgcD6Nh4QqusppyoxpweK1UJcMz8sIjxKgV?=
 =?us-ascii?Q?PNiR/oylyMNIwJtOugW6G18rom18eJmaU2hyQZLt/N6DvvVZr/xGme4QwXZl?=
 =?us-ascii?Q?fnnpmkQmwBCU4WAt+g1uUQT6hSzGq7HDCDe19GK0DgVyEnwUxTIqwzh9g8dJ?=
 =?us-ascii?Q?JDcs/qgbIA2u419spovfHIcE7pal2rGbdBm5aISdx/De39ZLbsWH2g/M2ws/?=
 =?us-ascii?Q?MBqGepWjM1V4X0LaHF74iIRHoEUENBoF2hU6mtfUf4ue9V1Xl7PMKmA/CUyW?=
 =?us-ascii?Q?y86umwnKiTrTi4WVoxItw/Jox/MnKkTCrDRcB8ZhzTAaRtBNSDzKQH1WoK2L?=
 =?us-ascii?Q?RMyruYSUY0u9qTVdaVXGYqkl71LhdIX4R/aLPV4x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8b99cb-ff71-4089-e555-08db292717ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 09:40:08.0636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnER0GV7uiFxKgOg0Dom2P+EsYPFlGILIVmscVSKQMRfsylXp0uzY3opy6tsfRboaeb2zFY9KBDePgWNtsbt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Hawking Zhang
> Sent: Monday, March 20, 2023 5:37 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Initialize umc ras callback
>=20
> Fix a coding error which results to null interrupt handler for umc ras.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index da68ceaa024c..9e2e97207e53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -232,7 +232,7 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device
> *adev)
>  	if (!ras->ras_block.ras_late_init)
>  		ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
>=20
> -	if (ras->ras_block.ras_cb)
> +	if (!ras->ras_block.ras_cb)
>  		ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
>=20
>  	return 0;
> --
> 2.17.1
