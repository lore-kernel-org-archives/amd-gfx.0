Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC856C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 03:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D17E10E619;
	Wed, 16 Feb 2022 03:10:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C308210E619
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 03:10:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Kuh3+h/1FcIpugRV5JJ+vYSwN0oDP6J/I31bn3mkIwgfNQvn11z4+7+AFUH4NRODLvBkgFs6/FOGgFYNQ6z7Eb5td+sX7uvpTXG1ln7xwhXiGII7Sv1vpNMGLaTueijHYEFuqbVtyd65/1zhKqq1u6+GShQD7Zlh5qh6jJ+7yZA3jcBOYBvc5N68aD7Eok9IVXYjvBCSq7hirD06KGdOoRGWRyUjmC274N3XuYcjN1SAEFaXMKr9TeY4yeX3oyOIubjo4OeWoRoi/qg3rcYBp3GqsS3JWUY02nbiZSXJbNQvwjS+W5TBsjRRJr65T/dJJJV2AwyLVnbbS491+81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK/GPo7lEWf+yB6YMoyMjdOybfx8on4RxUpmS7krFt0=;
 b=Y+7oDZmvkTmx0TFxaoqnrhDlIRdqfPSDxPb/WPj7CPvStuF5aKodlrtHZI1c7qZp9WuLtSwybujk88+9Klvh5rir8axPtq98t/VsMRE/+0pxoe7pmbp1atiu56xGuWEU+DwhnHXrWA+jahnz59J/NrFeXjzfESGgziwhrOLbQ3KXFk2fxMwbUyStH9JeN1OtLdQyA0xPHNOdDPvALVxoHuHNkOGknu1L3nH1waj2FqMLdBAPHtFKxPybb1VKyaOMQTLbrupk/MaPWRR1+kDp0sQh7SSMN0QjL9qxrnQMAPLC0NhT+emiUWSJBgtm+JjlJFem3hAzv1C7Isvbz3TNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK/GPo7lEWf+yB6YMoyMjdOybfx8on4RxUpmS7krFt0=;
 b=HJaSnTmgOz/NPZNdLsFp+XKx/e3MNzZkyB/QKVSbJHxpwMS07xec+1IiI1iUCzQnw6Opa5k6u18eDhDNF/nV7pFliF7N4AqtVY3n2kz65Ls38Dm2rfDpWlAESX30V4yYiLHiWk6brY7qLGXGcFv7w6HLya8J5UmNaQTUPqDrCas=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 03:10:37 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 03:10:37 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Thread-Topic: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
 initialization in some ras blocks
Thread-Index: AQHYIj+R6h4jVwCkr0eDIaPDvuDSpayVgBuw
Date: Wed, 16 Feb 2022 03:10:37 +0000
Message-ID: <DM5PR12MB1770B9A2F456845D78F0F96BB0359@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
 <20220215074124.3411761-7-YiPeng.Chai@amd.com>
In-Reply-To: <20220215074124.3411761-7-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T03:10:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4c632f49-551b-4dbd-9419-1ee77d03aabe;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-16T03:10:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 10e68bd4-ea52-4971-b22d-3946f94e94df
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5232cbca-db56-47e2-15ca-08d9f0f9e7f6
x-ms-traffictypediagnostic: MWHPR1201MB0270:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB02706D110DB99FE9CFB08064B0359@MWHPR1201MB0270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJxMov8ZzICDrySdnIc8SWzslW4VTKDl5ismI6bqxxLPda3AHHdFRl4IfTzfE5S7BZYwsGQKDDfeTfy0ljZcBcsP7odzqX2JmbyTrD11RaxwgdZPnIdGRazZZ1/Z8BAIhB3fA++u0zCZ/B8lBgnRuxuqgrGJoCFtCUjpSjYTPP3gnK8T1G6391oTt6g9B2WV2AKWpE0j6HxoAVc3Rhbiq3uBUE/rCmgv2so4LE9PQsfLmtQkUIPJj34EOXx3T+qVTOGs94a+V5b4jcWuJKG9tS4+WW9gZOC3okDqwCf0WBK0x+cm9ToGl6RobqgQwz+01Ptg70U7P9PQ3z1ozHXiqr8o8d6vBQhK/QVH1giUZYk1obLXktZWHti/MxPZuWwm1YMYIjK7zgPox1zeb5Jc/YVWEzxaQncJz/d7lel5YO2pFwdw8HY7crdlD/qM+gRrcZI6oNpPL11U7cqdL1X6idSILRFk0HzYsNyTBAVus8bLtK07FNGOxwjI8w8vQmdrVnv2pyrE2CUfIbATfpMW4DloiJfbkPTwiIPO4goeCCdXdAsJz6HgangQq+qGHXwbuhULd4/KNUVcm7BT2BrWgH7i/9+vNhP9ouT13UtfS88Tr4qqoRD9b+xRChI+HbBmseVOoyEEdnqiwzYPhp3b7RQHtjneF5ttrn68S0ZWufyUYDuGJwLwn9KA/CN9bD2E1ywzkJO25SYjPzkOwDZGMyoZmtsqHyNyWnLRHkkArao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(9686003)(316002)(55016003)(508600001)(53546011)(83380400001)(5660300002)(26005)(186003)(6506007)(33656002)(38100700002)(7696005)(54906003)(38070700005)(110136005)(8936002)(71200400001)(66946007)(76116006)(52536014)(64756008)(8676002)(122000001)(66476007)(66556008)(4326008)(66446008)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0wJ50X1ng4JXBQ32OMKrvTlaZPiIQjz2uBnQ73Y827+UArRF9KDY2N/9nNd?=
 =?us-ascii?Q?Fofl8/gLu68DjyFmdo1tG3lfsiBiOOINqmqwMd3DjvoEQJClrRW3AeAMNl4h?=
 =?us-ascii?Q?yyEeH+nPv44k7fxtjjfwtlgQY95YJ3jPTNSrk/P6zxS23pts2KZ0iB6+zRZy?=
 =?us-ascii?Q?Zyz8ZKXSK4jn1BZucJTYaWgI9IulfbakwS5p5mv1xObNmyCP9sROce3KCdb5?=
 =?us-ascii?Q?Wg9HKt4XANpJcxoEFY7PAIXfwTm60zJc27GNns180ml00hB2TgWQcV9ctFzI?=
 =?us-ascii?Q?sDX26anZax3ZTHyMvLZmCPsEO6hFIhTR4PSBOvp8ylR+/O+7Ny6+1btKyEzI?=
 =?us-ascii?Q?f3yOqNPpj5MaE/Y056MncgLZvGNq2YSL6OKAZblQkXMLUag5EEgqCzEfriqd?=
 =?us-ascii?Q?LUPMwnUnNqAcMsPytA+Ja4zdyXrCl6sfXLcX3aLIsViYjKD0r3J3cx2gzkGw?=
 =?us-ascii?Q?w5qeDo1WhTh10+0WFTHZJF81cYBG8TRTLfnYHrRUV6rPr9/oCFbwrOmCOIay?=
 =?us-ascii?Q?n5PfTM7tSZGKtdFelaBpPRrsDlj4gKnBUzNhkrV/RxCe6gERirccHF/1Sq9p?=
 =?us-ascii?Q?YkfseDnL/hAoRUaYVMrbrrzbedJiAMa0045hLWQ43qr1VTyHcXfzhwd9w1nB?=
 =?us-ascii?Q?cJ3JjSBYuDZMxnvzjtPgu7Ir9q/tvfqrqOpDBR8L2S1yfz+Iq5cp2xeHy8H1?=
 =?us-ascii?Q?efQJI6Y0lTDZEY8E3+vbvROaRyVC3HO/qRf1QScuPnPiE6ao4d+tcG0xriJ1?=
 =?us-ascii?Q?qrxWLiipRl0a6H9PFMVBiDqKIoOcx1k0Km3NZAI9jrp8YVa3AlrFY4DBCfGI?=
 =?us-ascii?Q?UhUtTABXJtB0MiwJvPSXXgTLJ6vmHGy7HtTIK0fkf2a+GZ6CyE4CGEDh2ZYk?=
 =?us-ascii?Q?57u+IuBIgTUHFUsGOLxv6iwUVLDWdQq9mxW/3zdSpsqORPFuD0dJ7VsjTkSg?=
 =?us-ascii?Q?EhaA91oz+UCjttkjW5bSDDmiCwTG/jtOEtxDODZww2+nEtT1vO4lwSdOG00/?=
 =?us-ascii?Q?vMaafEOwaaAUnxsaCa0O2idikaJo4aJfFqFTFR/6G2O3lLkUm7yTh/wDQIlm?=
 =?us-ascii?Q?sePffithpaYCvakZ+h1s+R91iwGtF+pFwbq3yAL5fc4lXDYhfRFISLiN826w?=
 =?us-ascii?Q?CUJ0Z7X92E496fNYQmcGZK5IGRFFxVxFtqqctUH9BZlfMwTYjDv83ZTaWZA9?=
 =?us-ascii?Q?xYz89ZdVWLRLr7qKnO2tOAw+7d9+2a3+TzwHjNAwajr0J8gCx5ao0wbRYyuR?=
 =?us-ascii?Q?xOxg4DZcydmU22DGLoLvhZlQWydugWSfRs0dEkceHsjcl/jT69dnb8NOI0yv?=
 =?us-ascii?Q?yAT7CHWM1B/u/I8JEYoKpWxs7ZbexGEZvy9T6QYx0t7NpQNp9zk1Of36JIGW?=
 =?us-ascii?Q?yKKteeQtqXEkbbkPbFNWG/d/3D1sESz2SxLJMurVU0FohaZiysR/s5l0qZGb?=
 =?us-ascii?Q?3uxMnAmnuXfHKZA7jxOdiUsI6I7esj0Wj5OemcLO72F2K6c7oEYdt7+cNel1?=
 =?us-ascii?Q?wUupHWhMvXVEvXZeC/NYsVVka/MQpOuHeuXG55phE02yVsHcHNpB8aT4KTrt?=
 =?us-ascii?Q?MPaEyLdfdE4usKuzAHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5232cbca-db56-47e2-15ca-08d9f0f9e7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:10:37.7729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYUt5rS6O/tpW8qsxs6uQNORQw0iZbofrIeQ05NBwIH4ZlvED/bJomELwtO2H7Hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, February 15, 2022 3:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu: Remove redundant .ras_late_init
> initialization in some ras blocks
>=20
> 1. Define amdgpu_ras_block_late_init_default in amdgpu_ras.c as
>    .ras_late_init common function, which is called when
>    .ras_late_init of ras block doesn't initialize.
[Tao]: doesn't initialize -> "isn't initialized" or "is uninitialized"=20

> 2. Remove the code of using amdgpu_ras_block_late_init to
>    initialize .ras_late_init in ras blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 4 ----
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 3 ---
>  4 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6cb1e5d126d7..ad37df6e50ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2457,6 +2457,12 @@ int amdgpu_ras_block_late_init(struct
> amdgpu_device *adev,
>  	return r;
>  }
>=20
> +int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> +			 struct ras_common_if *ras_block)
> +{
> +	return amdgpu_ras_block_late_init(adev, ras_block); }
> +
>  /* helper function to remove ras fs node and interrupt handler */  void
> amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block)
> @@ -2535,6 +2541,8 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>  		obj =3D node->ras_obj;
>  		if (obj->ras_late_init)
>  			obj->ras_late_init(adev, &obj->ras_comm);
> +		else
> +			amdgpu_ras_block_late_init_default(adev, &obj-
> >ras_comm);
>  	}
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b719d2c3003b..412e44af1608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1291,10 +1291,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct
> amdgpu_device *adev)
>  		adev->mmhub.ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>  		adev->mmhub.ras_if =3D &adev->mmhub.ras-
> >ras_block.ras_comm;
>=20
> -		/* If don't define special ras_late_init function, use default
> ras_late_init */
> -		if (!adev->mmhub.ras->ras_block.ras_late_init)
> -			adev->mmhub.ras->ras_block.ras_late_init =3D
> amdgpu_ras_block_late_init;
> -
>  		/* If don't define special ras_fini function, use default ras_fini */
>  		if (!adev->mmhub.ras->ras_block.ras_fini)
>  			adev->mmhub.ras->ras_block.ras_fini =3D
> amdgpu_mmhub_ras_fini; diff --git
> a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index c9e931f046f7..d7811e0327cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -163,7 +163,6 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
>  		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D amdgpu_hdp_ras_fini,
>  	},
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 12d09a58b644..b4b36899f5c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -71,7 +71,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp0_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mp0_ras_fini,
>  	},
>  };
> @@ -104,7 +103,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mp1_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mp1_ras_fini,
>  	},
>  };
> @@ -137,7 +135,6 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D {
>  		},
>  		.hw_ops =3D &mca_v3_0_mpio_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
> -		.ras_late_init =3D amdgpu_ras_block_late_init,
>  		.ras_fini =3D mca_v3_0_mpio_ras_fini,
>  	},
>  };
> --
> 2.25.1
