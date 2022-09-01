Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00E2ECAAD4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 02:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E4810E350;
	Thu,  1 Sep 2022 02:23:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694C510E350
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 02:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCa3VdfamL8UxqcIpiYIZDlzecXjXAaR/UBaE3wGX2F3wHgKNx412pma9Ye/2I0lb45RuEv8kNHmWgdTTt1tMyc06GlLVHQOp2yuVmZOWrCQhATKVNwvT+btVm1i1qntXkGfYcHU7IZrAqqVFcyIcIEnDYixuVoP2n/XmOhv2BqRpX5FnhnzzKauiWTOXGfkSvRMPvckzeEyn3sry9Wx7KpUtM9QF90h+h8CXDDfp7gH2Z8R2Reb+O+DUeFCyAGXskVtBJO2HYLbV60HJuNXuG0nA/ltujLedThLwpZFLdtF9fv5O0747oNDfmg+17Y2dV/Pkls7VHA6DEMGRRIewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWyKZkmsV1ChjO9JATYDpwBPmwyzYODb4IF8+z4USso=;
 b=HtgRtcLgxVqwgAvMpij2me2TilxjaH8QbLI6oaTDk047huo30q/yJC70E0buhEunmKZUemEqS8pFkVuUFxSqYdnPP5fhCkJf5OQMDKimAP4qpX9uERLBUfbgBKJBB5906jovYgn/snyEWZHvUE64MP4s4m1dIpgcnVxYIwUTM5vXQhb2TE6OEvERpX33ANutHXpNOd3NjRVGi2VlLgvPc7DJxwFJdT4EkEupBae+EB5y/S3LrnSx6vHOM51CeDOkJbLM+IJT53e6yniHYXvc7+wAiow7Pgh+BEPRTGKjFK77yWYUWYQaORZYMkTFLKchFs888/SikSe6Szf+wLVAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWyKZkmsV1ChjO9JATYDpwBPmwyzYODb4IF8+z4USso=;
 b=mvFUXhWkaNucTmAHZuQwQPRmk9R1MRNNeLV9gypcbBs7EeRkSVXHFvJagBniVsf6yGTZ6u/p+pILbmNaSsWYkp5HlT2nrkaR2wLP7lLa2QNQsep+NKR9cXE7LJLuxXP1jFY5ksV2UUZu60ohYPpjSPMFKmzW7lwRlXnXgg7RW/A=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 02:23:37 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ad15:8e0b:87c1:5081]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ad15:8e0b:87c1:5081%3]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:23:37 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Chander, 
 Vignesh" <Vignesh.Chander@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
Thread-Topic: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
Thread-Index: AQHYvRU7pTwH/e1ogUS5CYwBluKkFq3J13Qg
Date: Thu, 1 Sep 2022 02:23:37 +0000
Message-ID: <BL1PR12MB5334431C61BE14E5BDD566189A7B9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220831083925.1440-1-tao.zhou1@amd.com>
In-Reply-To: <20220831083925.1440-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-01T02:23:33Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=855a2917-e406-479e-ae63-a88dd8cfb036;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-01T02:23:33Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 495d4c66-ca73-49ac-bf49-31e98fd516a0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0006c6cf-1b23-4c02-1206-08da8bc0fa52
x-ms-traffictypediagnostic: CY5PR12MB6129:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pD9xxx0vvVtHygYpUx1i9OJSInHfvXAfSsXePFlwLA2QYAsY+dJ6KiW+wEFz5ljSeC0ll4RFJW0pZpb2zaTtkXkNpEhxPClRKF5bJS5x0BNLz5GF4F8/p/yI2IqBwHyOSP/OCHLQPPEonj4kpgk6Tqz0FL4OqCkKyUPeCHUHSb61MEXNiJ/leNuG0Q9Gh3eYq2YKKgoOCPUXAC5iLECEEy1o1wyJjQFGmx9/dkM3D219MI+z5XGkXax6dcSq5svbv5Kgk2VHVp3HxS1noIOUanTG3bWENRmQlOSDaOJKbYfMeeVfNloJMueS/mzMbBMquHIW2PuvcJfbkB0g921xdiCf6DJtKlGdK7t8eS7e8+L64Eer3G0JZs/+Wm2IQCvLodGbssW7k3W4QoyqB8JnbD00SUK2D6P6CbaP9ZvaZsaZRv1wfaJCWm9DWbFuNaMFVzGP6XFltXKVWXDw8mqkOY4NQRqxOUwSwcSyy5aPhJWridbvmkeAVvvRA+jCpjQalBlOSc0TeEfF0mawEpQS01lTwn39F9i25P60aGdux2lLxAuApyC5TaDJ2T86w0ojMcVeL2NCoWvbsr6CUY2nFVQ+H+Kb6pqGUli5dttF7B32AJ4itCMO4C+6J/yOksm2U7DF9TAgu2vMdwy/xPBYsRmdTr9RHsO9csk5ivtlVfUQTyvPxNd/H8yRF6+moOYOC6lK1S+9lsNynvoGck3tdvCexohHWTLpaVsDESa9JHZZHIwqPIOMtoqqdrTUP3Y+hxTMS690nE5oH8rV8VT39f00tO7yETrVnmRoasKohDk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(186003)(83380400001)(2906002)(5660300002)(33656002)(26005)(52536014)(8936002)(9686003)(316002)(71200400001)(38070700005)(7696005)(6506007)(66946007)(76116006)(53546011)(66446008)(66556008)(8676002)(66476007)(64756008)(122000001)(6636002)(110136005)(38100700002)(86362001)(41300700001)(55016003)(921005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EeMw22VIPgM3EHfUmr1HJny3XCN4N7v/CBdiRWUhwRy0qLpE1OOdkPlDRvm+?=
 =?us-ascii?Q?v7Rz+uSIUgDqglob/S+nSiOXuBYmTNTGyanNO1Ryl4PQn09APzr1glomSRGf?=
 =?us-ascii?Q?MmGlyi4D+0JvBq2MxE/3NE7zWqqaBrFXGY7K3UH+XI1BUAy1pVpfQRldTAeu?=
 =?us-ascii?Q?CSPbLCQfX9ETxzyUr0f5SvNUsGUabHD40Xy61TtI8iPbv3PBSTgWXixWZH/L?=
 =?us-ascii?Q?01C1JIDwuI97M7V9Ec8COZ3WR/JOaoSXPPkgtbkx1yGwJN6lmB/m2OXPmU9R?=
 =?us-ascii?Q?9GdjIRnTcy01qwdavY0y3DKbqFcK2RhRYvSrXHEkZOF6tYaRxGoFMfJU3M0W?=
 =?us-ascii?Q?go4zOVLSg0aax6/cZGuFSokV8ElR5Uik50Q2PzgDCGerfeXI2Ay+4TxlLLx2?=
 =?us-ascii?Q?8O4xySqQ9PZdSk0AQzkJAVPp2d+r671v4wVYfRyKh/h4IBw4S/x67ptAuRV8?=
 =?us-ascii?Q?RfS9vZOnc8uCmqy8v5TWi3gFYdkFPXXmVC9dsI+zHFaRT5hCc5yoOUL4rfTg?=
 =?us-ascii?Q?m1rvuoTLSsGovQGC78YLyUpIAOjn9Y6KjLoxSiUp/dpiZDYz3a6QWWaxXHO8?=
 =?us-ascii?Q?Hd+KrTPlMSUO+nvD2VRdrwGc4Lr9dvzOszW8u/6fSRBUVwfX1b2Wt+Rcb8D0?=
 =?us-ascii?Q?psAPvUCMddjJAzlbQrr7PUpXOc2dYHPwxUsjmgnHlcxQNA41xbTCb22wLTtG?=
 =?us-ascii?Q?sXBxYwiMRgKSN7UBIsVTdXS1Qg94CRbH9Tray/rOKSnxCmDSEa/m8F8NCut4?=
 =?us-ascii?Q?3wt5LKYC/ObDnhNq7zafdSC8wG0cmhZz9v6G/GSZzjkuTXOalr5T565IBkPP?=
 =?us-ascii?Q?V58aAz95N0ts2n8ZmwdYGOqnCFWk15l59BgT781cdoE8ugdiR2vsf3DAtAFW?=
 =?us-ascii?Q?d15shmVFB0Sg0BIZjc6rl0InTnlRuvmIuXuJ/zijWQKSHgfLq4SnqvUmWrbz?=
 =?us-ascii?Q?qG3iBs3Uzh3YShuwQgk7LqQ6DhsqwvjD7rj45wPrpch7rjN/709DHF6+jLU7?=
 =?us-ascii?Q?vD1gNafRxeIu0rv7bPjDJ+daigRU/wbN3QIJLuxsFEWGxkJHuPGGOYGv7cAY?=
 =?us-ascii?Q?anWih5ZQUkQrPcIT1tuM8dcsP+lvKN7E6/969wd9nLYJVyCl/3RbSvgT6YrI?=
 =?us-ascii?Q?zb7JmpHwPhXa0rIynT7NhMjoHHcm+3+iKVAFtQjaMpRNpOkTu6DFr69oVbXq?=
 =?us-ascii?Q?A9doidEpnvVoTxoSx3FOHUG8Lv4Fd9eyr4bnN3A6qDyGha5e3L8OSL8zCU/z?=
 =?us-ascii?Q?XA3/hJSUZbMk6qvR5qZD49W8KKQNh+3ZGRIjLkYKFb/4Q7ymWc4vL7Y6vuNL?=
 =?us-ascii?Q?W8qMi2bVaj9syiKz8bJN8HwSz0dDY8XB3pAE7tkdcyCGgHaIoqxrm2BrA10Z?=
 =?us-ascii?Q?YVX4fADW2gNrcaUq0uXCYBv7gCHK+Y81hyh/EHiPKAuif6knRlOizaUiMW5c?=
 =?us-ascii?Q?pdUjo8EcL4A2IKa0PfGjsBFAIEJbfTTFz6vNmFoMycq681uYayf4W39r0m7U?=
 =?us-ascii?Q?AtkafRh3wgwKPKrMWamjOBWxUEPrGQ02JcS14vGaMtoVoH8d/dDEBIKuHVoY?=
 =?us-ascii?Q?ydqcdjJNx+oyrDOZ39g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0006c6cf-1b23-4c02-1206-08da8bc0fa52
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 02:23:37.5854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CT/bZi5YcyGONpwPOekIVHcpzitgmxO7a+del5UqFUkFwHez10DvC9IFzz0DM1q7cbqQZqMOsKBid84fmgHQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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

The series is fine for me, these patches also need to be reviewed by the vi=
rtualization group.

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, August 31, 2022 4:39 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Liu,
> Monk <Monk.Liu@amd.com>; Skvortsov, Victor
> <Victor.Skvortsov@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;
> Chander, Vignesh <Vignesh.Chander@amd.com>; Wan, Gavin
> <Gavin.Wan@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
>=20
> In SRIOV, RAS error injection request will be sent to PF via mailbox, the
> injection input information should also be transferred to PF.
>=20
> Generally, the error injection is operated on PF side directly, but for R=
AS
> poison test, since workload is launched on VF side, VF has to tell PF abo=
ut the
> injection information.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 26 ++++++++++++++++------
> --  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 24
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  9 ++++++++
>  4 files changed, 53 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ab9ba5a9c33d..498642eb5fb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1103,15 +1103,25 @@ int amdgpu_ras_error_inject(struct
> amdgpu_device *adev,
>  							  block_info.address);
>  	}
>=20
> -	if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
> -		if (block_obj->hw_ops->ras_error_inject)
> -			ret =3D block_obj->hw_ops->ras_error_inject(adev,
> info);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
> +			if (block_obj->hw_ops->ras_error_inject)
> +				ret =3D block_obj->hw_ops-
> >ras_error_inject(adev, info);
> +		} else {
> +			/* If defined special ras_error_inject(e.g: xgmi),
> implement special ras_error_inject */
> +			if (block_obj->hw_ops->ras_error_inject)
> +				ret =3D block_obj->hw_ops-
> >ras_error_inject(adev, &block_info);
> +			else  /*If not defined .ras_error_inject, use default
> ras_error_inject*/
> +				ret =3D psp_ras_trigger_error(&adev->psp,
> &block_info);
> +		}
>  	} else {
> -		/* If defined special ras_error_inject(e.g: xgmi), implement
> special ras_error_inject */
> -		if (block_obj->hw_ops->ras_error_inject)
> -			ret =3D block_obj->hw_ops->ras_error_inject(adev,
> &block_info);
> -		else  /*If not defined .ras_error_inject, use default
> ras_error_inject*/
> -			ret =3D psp_ras_trigger_error(&adev->psp,
> &block_info);
> +		if (adev->virt.ops && adev->virt.ops->ras_trigger_error) {
> +			adev->virt.ops->ras_trigger_error(adev, &block_info);
> +			ret =3D 0;
> +		} else {
> +			dev_warn(adev->dev,
> +				"No ras_trigger_error interface in SRIOV!\n");
> +		}
>  	}
>=20
>  	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 239f232f9c02..4534e6f70a4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -84,6 +84,8 @@ struct amdgpu_virt_ops {
>  	int (*reset_gpu)(struct amdgpu_device *adev);
>  	int (*wait_reset)(struct amdgpu_device *adev);
>  	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1,
> u32 data2, u32 data3);
> +	void (*ras_trigger_error)(struct amdgpu_device *adev,
> +				struct ta_ras_trigger_error_input *info);
>  };
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index a2f04b249132..3b4c5162a237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -33,6 +33,7 @@
>  #include "mxgpu_ai.h"
>=20
>  #include "amdgpu_reset.h"
> +#include "ta_ras_if.h"
>=20
>  static void xgpu_ai_mailbox_send_ack(struct amdgpu_device *adev)  { @@ -
> 405,6 +406,28 @@ static int xgpu_ai_request_init_data(struct
> amdgpu_device *adev)
>  	return xgpu_ai_send_access_requests(adev,
> IDH_REQ_GPU_INIT_DATA);  }
>=20
> +void amdgpu_virt_ras_trigger_error(struct amdgpu_device *adev,
> +               struct ta_ras_trigger_error_input *info) {
> +       uint32_t addr_lo, addr_hi, data1 =3D 0;
> +
> +       addr_lo =3D lower_32_bits(info->address);
> +       addr_hi =3D upper_32_bits(info->address);
> +
> +       /* block id : bits[0:4], inject_error_type : bits[5:8]
> +        * sub_block_index : bits[9:17], value : bits[18:19]
> +        */
> +       data1 =3D info->block_id & RAS_BLOCK_ID_MASK;
> +       data1 |=3D (info->inject_error_type & RAS_INJECT_ERROR_TYPE_MASK)
> <<
> +			RAS_INJECT_ERROR_TYPE_SHIFT;
> +       data1 |=3D (info->sub_block_index & RAS_SUB_BLOCK_INDEX_MASK) <<
> +			RAS_SUB_BLOCK_INDEX_SHIFT;
> +       data1 |=3D (info->value & RAS_VALUE_MASK) << RAS_VALUE_SHIFT;
> +
> +       xgpu_ai_mailbox_trans_msg(adev, IDH_RAS_ERROR_INJECT, data1,
> +				addr_lo, addr_hi);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
>  	.req_full_gpu	=3D xgpu_ai_request_full_gpu_access,
>  	.rel_full_gpu	=3D xgpu_ai_release_full_gpu_access,
> @@ -412,4 +435,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
>  	.wait_reset =3D NULL,
>  	.trans_msg =3D xgpu_ai_mailbox_trans_msg,
>  	.req_init_data  =3D xgpu_ai_request_init_data,
> +	.ras_trigger_error =3D amdgpu_virt_ras_trigger_error,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index fa7e13e0459e..0841d6632328 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -29,6 +29,14 @@
>  #define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
>  #define AI_MAILBOX_POLL_MSG_REP_MAX	11
>=20
> +#define RAS_BLOCK_ID_MASK 0x1f
> +#define RAS_INJECT_ERROR_TYPE_MASK 0xf
> +#define RAS_INJECT_ERROR_TYPE_SHIFT 5
> +#define RAS_SUB_BLOCK_INDEX_MASK 0x1ff
> +#define RAS_SUB_BLOCK_INDEX_SHIFT 9
> +#define RAS_VALUE_MASK 0x3
> +#define RAS_VALUE_SHIFT 18
> +
>  enum idh_request {
>  	IDH_REQ_GPU_INIT_ACCESS =3D 1,
>  	IDH_REL_GPU_INIT_ACCESS,
> @@ -39,6 +47,7 @@ enum idh_request {
>=20
>  	IDH_LOG_VF_ERROR       =3D 200,
>  	IDH_READY_TO_RESET 	=3D 201,
> +	IDH_RAS_ERROR_INJECT =3D 202,
>  };
>=20
>  enum idh_event {
> --
> 2.35.1
