Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48656C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 15:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1D310E5D3;
	Fri, 16 Dec 2022 15:15:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5436C10E5D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 15:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeYtz7y1Q6kQoeTqmugWL49Jcx4xgm2/0oQCLFLTSlVvOF8RxjduprNLHQ1IQaCWON/tvC5joCQiQ47Nnfs2+ePEItKh67DrFx0MfPbL38UODF8hI20R3FlQHz/ky6XecybM8UL72qrmBidjfAgSwp3x3FiY5j1fCuLB2fqYE3noe7vnnCqB0S/wqpkp73IR7UOzQre+1cs9948YJ+oXsh883loL6WJQBhOVBtVBWEoRE9sS10fzzy/2AI8+QciHgRjHd3Z5ibE3YupJjANdHERETne8rGNc2Estm+WTxqnQhUwI7SaB8ewwjc5G+8DyqxGBfg/i/TLMYksifdiKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldO3xKYKyUm4xUz1oSrLE1w5F2ouKzmzHe+YHdhghJo=;
 b=TirI4J4tJMsH9eegpkdQ9Ttf8TX8mosH4I34SayDzVwV0imB6+QV2qePHGO09ExVoQoEP4/zIZhnC9yrurMmKQcZ4UbF/HBRfr+jtiJHVgwPiQQdOVUx/cFaW9qdxkIc/dFKmSXeL4ZzYseE9C6YoopfmYPOgKLzJqJYhmFmtfFIC9eGldcrdzIizsxHKadHLq+f1jJs+v6uAqtK5ZwWuiLl5Y9E5XK++mflnwH7H6Td9GoBo422XQkzybZI4NhGVQnNU92dRcUAUaKiq2mOtZYA5lPT45OgmfLTzkfv6r37gN5Tqux3A3BmniK7QYS2hoQrExIZDbCqIkJ6itrn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldO3xKYKyUm4xUz1oSrLE1w5F2ouKzmzHe+YHdhghJo=;
 b=1cu9jZTaY8+WRAAlcFJsepeQhE/31vjnrR0eeIKb6N2AOxQR3rrkJO+VVMw6Ie5K3u3RFanUlMq6R8Hw2DojOt+6Z6bmApBXfQMy+BMmCUfo9VE+g+BNGxOePRRyVO+dT9Ers96s2d5yX9RJ1dVbNmOGtbc91F39OM1L3VoiRWk=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 15:15:37 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7dae:c7a5:62f1:6d43]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7dae:c7a5:62f1:6d43%10]) with mapi id 15.20.5924.012; Fri, 16 Dec
 2022 15:15:37 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
Thread-Topic: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
Thread-Index: AQHZENI4Y51R1PGG4EmV87lkAUTOlq5woGeA
Date: Fri, 16 Dec 2022 15:15:36 +0000
Message-ID: <DM5PR12MB13082BBCCD36EFD11FAF143085E69@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
 <20221215221059.509565-6-alexander.deucher@amd.com>
In-Reply-To: <20221215221059.509565-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-16T15:15:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5bcbffc8-67d3-4a6b-be85-4778d763a8a1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|MW4PR12MB6803:EE_
x-ms-office365-filtering-correlation-id: 4c1bea38-af20-41dd-35b2-08dadf786285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y15lKg9oB8SCyN0XGrOPTfJzP0V8nHihIZizsqlun7goAbeghsWel4AKE5C0C6DX5FoH0NbMamAAFLoKRy03TDdzSN9b8mhmaZ6vGMYKAbXuvWzDjzNgcU8Yj58WA+q+eOJq+ZUhoQ8l+Jg1yYJI9ZaXUz9YJPf46EhvBLCb31mVf8TAIoXDwvIzzDHpWZnbAADBSw/f7MT0BeeIYtVmbgma17mHQAIiHJfY9EtXc0kt2TF4YjiVD0N/+XWCCiBWzfbBiTnD5cwY6FuTBWgXH1rL/d21X94y0qjUd7cJyZZLeuJ2kwAnenn8FNdzIl/77M2e1X8yYCxdoNe6uFwLyBlmAWHPF0YGLcNhIW4E2QSR279idTcRAfHCi++lP+H3y05RO0aiEthzn0fkGlIcw8wG5gOuDS8LlpIjHmh+c41OrvEX6IfNiUFh5pvzlXuMZrYlEZqZS/sYzWZ07YsXACOANAv/+ztOUnXqF2y0F3udzaMjswOHEMKi5iZ2jj9TrDoNFiOXu6A6W9+QbUy6Q5zKnA7g8RaIHr4PHkxepHcqMDcuy5/IVWbNgnS83IOUU8MwqDIBu7raZjqNO5hn5Ju6+ivlsYV3oKwDHT2oylT2igmMoHIGHZ0vFy+sTZ3EtnaAfC3KRg5JGSyAa5iGkhLgztuB2sKKGXJjlo4DzZAJ6U5wHNhgjUQzvxfq4g/nU5GTYd1Wcoj5fVT14pWFS/WcSlFRorK/xxeIR2/4dR3468eF398e2xpbuNc7P9gq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(33656002)(2906002)(122000001)(5660300002)(86362001)(8936002)(55016003)(15650500001)(38070700005)(83380400001)(52536014)(54906003)(316002)(38100700002)(186003)(110136005)(41300700001)(9686003)(4326008)(66556008)(76116006)(26005)(7696005)(64756008)(71200400001)(6506007)(66446008)(8676002)(53546011)(66946007)(66476007)(478600001)(21314003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aURA770ViDemNxEbC1Yhi/M+WC0fhAiZLNiMJ/MQ1jBDJfQ03m85ZYUgA7D8?=
 =?us-ascii?Q?Fnf5yHjVsbyWhPA8NXP6xi1iBBbrCXTvBZXgYWJ9y+8Skni0oklEZ+RF25Dt?=
 =?us-ascii?Q?5EwD7keqblYuzuInXxP/YutQBNLS9xdlUTUggIJ/00aPp8clviEf7VESFRUZ?=
 =?us-ascii?Q?AhL8ByVimyOCfvaNy6z/MekY0EIzg2mTIwPmgWWHPgF7h5qn6N8DIJNcr4a6?=
 =?us-ascii?Q?QO4Gb/ihl60Fp+Prrso2w3H+5S+jkP1ehW6sg4HPqT/A1a/9xLf1xRnDc1bf?=
 =?us-ascii?Q?7NrDYMyvpqueuRlCg4JU0w4aWjdLbxRs8/6EhqOOKYWVX4XzzhlGOTt0+MTE?=
 =?us-ascii?Q?l4noHfZvyWXWHOAQk0pd7ck0CjvIAFdDLtE1mRPReasKT8+9emdjGoOxKH1a?=
 =?us-ascii?Q?5NuZszntjV+87h0PiQRJJkXoxv6h9bP8049gw7JJd8SEUuHsZw9AdqLtgDV6?=
 =?us-ascii?Q?uaxrgXhKYZuG6j9cY788zv5mGQMFukr89YO9zi4HDU6KM3r9sxf6Jbej+NsG?=
 =?us-ascii?Q?0znnhrXXktXLeElsbRc0xg2kAZtq4BbEyNK1ZSOtgwcw5dGml/Ku15dzwd3n?=
 =?us-ascii?Q?kiefHLHVu5+S01x630tBV5dKOR/+pFvkVo2cFccWqp9gGJWyY5wTtbZ9kM2I?=
 =?us-ascii?Q?T+v3nXxWaStMKuXxtAfrEZR1GOR4fYuBW/ae39Rm6IQ/BjoVKdPbgxDcc7aP?=
 =?us-ascii?Q?B76HdvYk7uqgXUfeaKyhUwfAYiEWsu688NIrjBjX9EpJIzctKJDstkj+WLG+?=
 =?us-ascii?Q?eSN/TD/wi6XBqeX5KSfWF9q+r1P72kDQ8HTYtUOPRw8YTLetmkZi3HvwbWfo?=
 =?us-ascii?Q?yQZ7kqUCuISDSj6otQtX+6h900pIj5p03bdi7P4iwSPc50ueHZhl5fExd2+G?=
 =?us-ascii?Q?HT54YvsRuWpu2L8wJv7fkvJTph0KUOHcb+3GAVxjJrk8JIQKkhR/U3/wVjUx?=
 =?us-ascii?Q?rw26abeANsDu87w7MLIjJIHTnTZQ9pHC85+yS+8Ci6r9YWmfZ+wm1EzyKSLZ?=
 =?us-ascii?Q?QmPjcjCfxzm4ssK7Cu9BiUXb7CC0V3wZmGIuLnNi6TDqZOl7/q3oPOKz/Z2Q?=
 =?us-ascii?Q?vYuP8QJf/OT4lU+2I6Ab/gvGFfah3PP+xFggR0RcR5il0cqZCreGwVolLPvt?=
 =?us-ascii?Q?tfmnxqgO1EZ7wvdRcAXST3/9xfNM18NJe52jOXeHjyi7IRg65/HjK0aP11Bo?=
 =?us-ascii?Q?OU5vtDhyMRKPH+30t9PGmaJtuKjOXbNYVsA/0AVj/MTJ/R6aAiBbDCFgnR1X?=
 =?us-ascii?Q?vs9EPkcl38HkBoVJKyYy1rDEudD5FbxUSS33KKRFmvRJDMCAkhuRjj116whT?=
 =?us-ascii?Q?7QUvdL2uiiTozC4QnD75t121UE8jjrETgTnAfhpC57AcnSYIqvJ+bpFakVbQ?=
 =?us-ascii?Q?vcYTEYgwpPcOur/WtTel/P5bhculDzRXlQ87pqlDiIHgyep7sGVB/9716pTe?=
 =?us-ascii?Q?+/MfTgQZkymkCSjRR18dum8NiUSpwdb1t+VHOlEvOlb+pd3+A8oGvbIGKvnF?=
 =?us-ascii?Q?bTKTShW5ZfevM8axUFRqQJBY9xkXcLZSSmTPV3SofKdiWXrGaFJhUenxA1Nr?=
 =?us-ascii?Q?BP8lIK8uj+yQaGSbUEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1bea38-af20-41dd-35b2-08dadf786285
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 15:15:36.7844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJQS0vNvd4sbGrEINpmnkt3xyP0WqGAUfs8U10q1xmoqXE7sx8zyJzobBj88zQ8MEZIf9EXcQmRDrHl/mZoDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Probably want to fix that typo from SMDA to SDMA in the subject line before=
 pushing.

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, December 15, 2022 5:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Bhardwaj, Rajneesh
> <Rajneesh.Bhardwaj@amd.com>
> Subject: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
>=20
> SDMA 5.x is part of the GFX block so it's controlled via
> GFXOFF.  Skip suspend as it should be handled the same
> as GFX.
>=20
> v2: drop SDMA 4.x.  That requires special handling.
>=20
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a99b327d5f09..5c0719c03c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct
> amdgpu_device *adev)
>  		     adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_GFX))
>  			continue;
>=20
> +		/* SDMA 5.x+ is part of GFX power domain so it's covered by
> GFXOFF */
> +		if (adev->in_s0ix &&
> +		    (adev->ip_versions[SDMA0_HWIP][0] >=3D IP_VERSION(5, 0, 0))
> &&
> +		    (adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
>  		/* XXX handle errors */
>  		r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
>  		/* XXX handle errors */
> --
> 2.38.1
