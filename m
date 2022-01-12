Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E33C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 08:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1423112E73;
	Wed, 12 Jan 2022 08:51:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C36112E5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 08:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVmsJO2aeFLuFicdo6lxGs4fGL99dDz8SiKPmuwvsOg6SWdqrqi24ffICGcqYU7Gr9MyDJCGMbtPu7x3QH2RMvLkxwNNzCUaDL11Y/ChZYYvQhSF3bvKVeI0cj8DDxJfOLwx8FfPdGReQUOdAhh2KD526+KCWrwazPo3iSq48ikVnvVhDx4XcH+oA7sU+isSGrgF0sKFBvzpCg+M5os2pR+21+t6arU9+1dihzd7LXoafpdJ70ZJN+Xruva8C7OD3RoBSqrpvDYHxocs+dv3WYhjU1/t2Cd7GToV4XIi+IZ3Cig6LPzVawkhAM03QZZEqMzKOhmEVl8KsznTyRHwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tEJ7zjk8hShcchGAISLpY9arwnhkear4Y/BU9IdmYY=;
 b=BY5AoKBoBoON1ZJx/pezyBEtuH3hAPK1fXXoMwnzewnKuL+97Q8A592lKDh87rICu19CbJp+bPjOsOW0bVwGSJM+PekTKE+2/RpGyKUU/MjbeJN0E6Qexd7SywMZEeQyM349ux3Z8FyZS0harMPupESa4jjcz1FwmaSIymSaaSLeaDeh2g8P3N9Xcd+tcZNLw+DVyTPUzo+OtOIOsQoy2JqiM+SyERKO1rrjgpVhIrAU9PoEr9DAO/zdlM0OS9Kc9pVrUVFFjY20DP6JULHd7vFLK3UqeSehOnCxIPi0vu9Cy8FsQmwEAt0FgnyYuU5krFY7OiB9lb9ZQQxz8yILSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tEJ7zjk8hShcchGAISLpY9arwnhkear4Y/BU9IdmYY=;
 b=NI9FcWMPUO5DvzIHHdd3N+5fucJZ63IeFOiecNcV6PDGiTGXLfLFvw14Rko1gmdt8AhQL1MLhRxqxeGapjPr3FKqQhCUieAMYjJkN92y+1o4Mmxcv2LDmppKUae/N/eNXftx181C1Ad76rd3MV6mlUBoCVZjreWwMxKr+hAGvWo=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 08:51:45 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 08:51:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions
Thread-Index: AQHYB1W2U+0v3x4hIkuvu6RG1ydAaKxfE1SQ
Date: Wed, 12 Jan 2022 08:51:45 +0000
Message-ID: <DM5PR12MB1770C948314DD38AE2041782B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220112014243.6959-1-Stanley.Yang@amd.com>
In-Reply-To: <20220112014243.6959-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T08:51:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=be9d572c-734a-4b44-a6ae-3f8569487338;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-12T08:51:42Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 607d2856-0298-4052-8e16-e0711826bf4f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074f7cd8-0097-4b3f-1329-08d9d5a8c358
x-ms-traffictypediagnostic: DM5PR1201MB0217:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB02175D63DA8110B16C2BB15FB0529@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmLgTP1+g7QXxMgUpzXCY0AyvAnKF98/88idUXqfan6Ah7KYzfAbcAM4yJdc2pM2Fh/jLZyrZwbVHfGINstC55VzBRqpYeG6k0ZajbElskeLYUmVkLL5ajYejK5XoPw+cYxtgUo3dtBj7S1+T9LUVybERc01BNS69/NGNNTJ+tpg1shYTQ7cdYiEr8r6zp2sTo8+JItHEZmxxPRlzCfQcGO+qms9dyMe44ugX8JmLPtTEfLAzUnViVRhMsxThBSqoWj72f6hCByRIBQ6vxhPERTpt1zWgCztFbEQEmKC6hELShzKCG+pM8lidFeBwtowSVxFUFo4KyqbeFEW8WDqOHxU3S2gi6YahIEVCMhjbYoOo9kQhmGcbeRup1phHMoHQM8BVhzzGI8sefBrg5MzAkrlGBFzP2TcaExk3tc5ZEKmT7NkyekNb5Dmc/18iqQkotWxD/8c3x2/3fSeTPJftdSfVvjDuIhsa3t4pGLwfD+sAM99Op0WT6zB9V88i99C6BY/m8IWqLYs2aeZmrWN81Pk7UkQlpsfIVgd1qlIgdZUY8y3OvO/zT8sDVkBtKPcCGlHR/ebJKE88m00/yrKl7LpmC9s2vHcO5xvk5/tGrt+9aU2wQ3HO7cG/T9uSAosFd2dux+s54LsDR+mBm40Bvsl/btrKOIWg3VvEb2/lea+LWQsiMVVdPFkNsH1NbIELm8Hst38ZctiD8TXM/nnAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(76116006)(66476007)(66946007)(8936002)(9686003)(33656002)(26005)(86362001)(6506007)(66446008)(2906002)(8676002)(316002)(55016003)(53546011)(7696005)(4326008)(83380400001)(66556008)(64756008)(54906003)(186003)(71200400001)(52536014)(38070700005)(508600001)(38100700002)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Ek9rkJcdwBvWeijoxKNyeLshdc2I3mry34bSBcOrbBmInRaA5gC+u8hoRs5?=
 =?us-ascii?Q?RcqvhcEKNWqslok5iA1iWmNjt5yqP+4XEcBgcRyUUi88p6BmmG94I/zbHVIq?=
 =?us-ascii?Q?SjnoQ8jc50bos6m/nqkFCD6/+Mg5IRrMVgNDfHcBEMqgY4ktm2qIfloWF26a?=
 =?us-ascii?Q?GIkOkPyVz0btdB5BEAMsBjzvFYsGOKHDG6w8+xaaO5KTtfA+I5w17wUytA2i?=
 =?us-ascii?Q?zYvg6C5vCpkOiMKnmi1u+TYeTAHASwXpZC7jBlS0X37Mu6vYOQRz0iE3UasE?=
 =?us-ascii?Q?ChQJVxamfSW7KKpiMlJcECCf0mQnxkgH0ey2AWlDiG3QgnAV5qyKBieqBGtg?=
 =?us-ascii?Q?xhpO7jvvLvHyIIBpw7fb7dShP95JpjVATSOrtoEuuNNzOoUI0Skq8zwRLuIW?=
 =?us-ascii?Q?HMhaEK+5JSJeWdEgNqnLEoYWLuFMBfNHi3oSCzadOeWnCS59f/LIEYhndCgd?=
 =?us-ascii?Q?dIqSD+0mOiTzo7FCLp/qjNQEYC/UEYp5vTdQdsQv1WGn9ucv+IR+8Equ+iHm?=
 =?us-ascii?Q?Hw+mC2qA0Tw/tgW7qDEeZfPFLsf+uQbCL65bDH+DhPCDm3oAe+PWr6elGim6?=
 =?us-ascii?Q?hNSMr+/lCpgYuPNTwmk93+wRP6AYzOd8P6y/+IBOpJEVrh0S3ZV+kKb9PfeW?=
 =?us-ascii?Q?PZJuBnEqkkcqlmvBZZGas0ejViTuORw+Fw2G1X++Pn7W03x+AcuCp9jZ4uOv?=
 =?us-ascii?Q?QBN7QHx6LjYTaCqv4YEXhbg1aYnVhrZr2UtyQTpACheOtjC92p1ngHsQcO4t?=
 =?us-ascii?Q?8DNnveg2UQ94sH5D5RTDOl5iRaiMafX30DPhk2QmbQeOjZpwLYggDJ4Xlp8r?=
 =?us-ascii?Q?xlrFjs1i1YXi8f55PfS8QbYftMDpnKpUlpzxnzXgyRr3AkONf596xkhP1V16?=
 =?us-ascii?Q?l1rFOYtOBPWrl5AgzeBja5mUVaxiSptaJ6g+YhK0zwN/y1bWY7oH7rWpGAoN?=
 =?us-ascii?Q?NWuSA0ecApThhlqlJssDaL3pOE0gMzLc4ymxspC3JMcZmB5OG0I3Jc7FYR5G?=
 =?us-ascii?Q?xHdbK5aU462Ey6COrTXpSMhvKd9u7SNamXVaxYZ2NpCRDWV1kXCcUuc8cL2D?=
 =?us-ascii?Q?m6HiMAm8Ba5wa4hOzjNBVlztjD67L+cwAUbEOfz1LSktOu+VQreboT++WY3S?=
 =?us-ascii?Q?CDWtdYvJlsOB5RMhtcbjqs+bKztHFAPGDiBsnkzVcPpmsOfZQiXvVJ7Pc+HD?=
 =?us-ascii?Q?AEnv1Q52oLzSWjhis3RXjGMBqKZG+nv3RnwgWkf5E8VH3ZLXbrrs6nK2W+iI?=
 =?us-ascii?Q?EmKdCnl5vKzVM/K1CFU0dFBHXelKmN5bxkTEH9m5K1CpFZRuTDYZV/jvNE/l?=
 =?us-ascii?Q?2j8iDTAdT/Uk0z5UJdWFBDu1ysZbrizDrq/6wYTLP6tob+YtybZypixhMaPV?=
 =?us-ascii?Q?QUFNoeeMXv0safoRbHFxi+rN8m0oyzBNtWaFOfM4+gTTuKVwQX3zBhEZfaLb?=
 =?us-ascii?Q?50IEIFKeP3TkSKtZrpaLbW62CwCbyU/6hWEOCFFtvPC/zQ0xvf0lu5Nry1k9?=
 =?us-ascii?Q?vD+UgZCu/ePQq+1p8IakvZpt3GQW1tBorjkJICXluWas1LWFNMKOlgfEWYCx?=
 =?us-ascii?Q?FVuM8VtH37A9nN9xL1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f7cd8-0097-4b3f-1329-08d9d5a8c358
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 08:51:45.6780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV1G7LPaWS6UlU2n1hqZQMfiXZqaQrzPTUtTtZiK5m2E0pKF9243LGNxF9Nq3JV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Wednesday, January 12, 2022 9:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John
> <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
> critical regions
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
> drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  |  3 ++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c742d1aacf5a..8e0ea582b9c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1309,6 +1309,12 @@ static void psp_ras_ta_check_status(struct
> psp_context *psp)
>  		break;
>  	case TA_RAS_STATUS__SUCCESS:
>  		break;
> +	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
> +		if (ras_cmd->cmd_id =3D=3D TA_RAS_COMMAND__TRIGGER_ERROR)
> {
> +			dev_info(psp->adev->dev,
[Tao] Is dev_warn better? But either way is OK for me.

> +					"RAS INFO: Inject error to critical
> region is not allowed\n");
> +		}
[Tao] The {} can be removed.

> +		break;
>  	default:
>  		dev_warn(psp->adev->dev,
>  				"RAS WARNING: ras status =3D 0x%X\n",
> ras_cmd->ras_status); @@ -1521,7 +1527,9 @@ int
> psp_ras_trigger_error(struct psp_context *psp,
>  	if (amdgpu_ras_intr_triggered())
>  		return 0;
>=20
> -	if (ras_cmd->ras_status)
> +	if (ras_cmd->ras_status =3D=3D
> TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
> +		return -EACCES;
> +	else if (ras_cmd->ras_status)
>  		return -EINVAL;
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e674dbed3615..8bdc2e85cb20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile
> *f,
>  	}
>=20
>  	if (ret)
> -		return -EINVAL;
> +		return ret;
>=20
>  	return size;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> index 5093826a43d1..509d8a1945eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> @@ -64,7 +64,8 @@ enum ta_ras_status {
>  	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            =3D 0xA016,
>  	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             =3D 0xA017,
>  	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          =3D 0xA018,
> -	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019
> +	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019,
> +	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          =3D 0xA01A
>  };
>=20
>  enum ta_ras_block {
> --
> 2.17.1
