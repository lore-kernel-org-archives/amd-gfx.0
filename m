Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E25C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 06:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6A510E641;
	Wed,  1 Nov 2023 06:45:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C460D10E641
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 06:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN8Uii2P+sUNcAAnBZa8wDIWnfEl20+zy0lm6uLeHdLTxSyLQQMyPx43bKXA33tqFWfSbw8kFqpmmBPzRLKWA8g3Htz2yEgzOIXILO63CLyaZCTXsDcgLAcqBWQBzvVE6LFf40H83VnvdqFzgfKhC1kzVEX7f+YWxtVjln1w5zO0pI4iazxprxc5I5YRJT/75g+lquR60ea/qfH9dPgcZJiJn56JnfVBKCZI8HWwmRV5HnnhEDUNENJZ+ay7OAFFnVDiOsrlxRB34F8zP7ocPQNZxvnXMhIselQFxSP6tiPXVfsgHTtBDmId8P5/Xq1ieSEIn4zvnoUzITbOhz4nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psYhB1fsb5HxYKDZAvqB7s4dTvTKe7enRitFlWFK674=;
 b=iPgXcEO3AdYfoCk88zAmgSsXXD9Rbz61gFksuXzDswKig4lCwrmC1vWTP2Fgb6EzGG+86+ARekvwvh4x9bYLGqLnXxeqFiFmePEi4bvMbRp72fGjHDr3UgDfhZLlWs7nVShvloWQmTQStbo6u+QLPM7C9k+0TSbCcE37kPWiFp4ex4X+fuuDR+9XldJ7lZle+2AcEhHYQF1V1cEYN05D2KGc7v9I0WkYVvaY/j6UoPcKCrtsZhlnO0JR5mLSMFPATwbIqMCDHvGEip3pxvi+Ki170rQlktANQemwwcmoFIXkPk6IlYZYxHVXagJvGO55Ozn8SfDAs1j5B2dOf4Lz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psYhB1fsb5HxYKDZAvqB7s4dTvTKe7enRitFlWFK674=;
 b=5TN/31nX3yllXeVtdtPJAW76Dd2rJCR8fCRinsQINp8k7v5zCuJX5lLeA4MkirPRvp2BTWV9iiRWHvnqcVTGPij8n0nozx64gjRenJW7t87o4ljVfOQ2yQZ+IcDCCP6Njfv2bn6PxNFu6ZMBVzRU9XlDlGQnJINPY0zJhAHOa2o=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 06:45:23 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f%5]) with mapi id 15.20.6933.028; Wed, 1 Nov 2023
 06:45:22 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Thread-Topic: [PATCH] drm/amdgpu: Don't warn for unsupported set_xgmi_plpd_mode
Thread-Index: AQHaC8kKtasbyU3TME2/2Mvb+IfgzrBkwL+Q
Date: Wed, 1 Nov 2023 06:45:22 +0000
Message-ID: <PH7PR12MB79881F91AB5FE433D695EAB79AA7A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231031070756.16404-1-tao.zhou1@amd.com>
In-Reply-To: <20231031070756.16404-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eaeba536-a304-426d-80d1-c68cf326e23e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-01T02:36:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|MW6PR12MB8999:EE_
x-ms-office365-filtering-correlation-id: 86177d0e-e0f2-4f09-3894-08dbdaa61f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0n8pP4tZPhqgWM83bpOSCaj0I6grGhnESECoDcpqNnC7OaU4Y0SmUU+AX3EwRqLmey+PiQxYhvgI3Fhb/bm8E3ph2tyOc6Gam8QteiMZuY2q5mvAoBegpE0P8YCS8osxZjwwE9vvjWzIWG8KWJo0MTsrdEzIiAYga4lybpvzNcVakx5Nbsio4A3Eds+6ch76xS6j6QG043VV3VvxUwr9fLKobsa7HlBlFzXT6FtiVcDXvPsZ7lI0H4/JUfExANHRy+1jiLhZCQ+ylArzi16cnra4UPdqZUDj0mVx4XsFvhlCiUDmJ8K0YyjfuCjojbmpbx7Xp+w74HaiD5yJ75DgZkDtYA6aTsvaV0R8TadL97uNxcqtIBnSGimLC/iqKtahr87+zeLe+p/n+5dc+WbIlm/62qQ3EKq0DmXjKjcCYXuVcG83yG2NqqbFPcIo/C3Q0CRIjWxqKkY3b5murWtv2cXNhpMdHL/XEumDLIVj3v21RgKLp7PaW8AmegD6i3DdNyI7zKueJotXR994GjqVeZy6rpVgnscqRbaXeFdAl0MLR8quGKR9pk+30GzMcJHWW+TUbTpEmrJuBftq1zPr/WBf56y/+QlNXOU3k+00WEneoZbE1KPyurrDuM7EMR51ww1mch+wViBCw2gyAN/2BHCa/5piW0BS01Dt3W0YkSE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(6506007)(26005)(9686003)(53546011)(7696005)(38100700002)(122000001)(33656002)(86362001)(38070700009)(83380400001)(4326008)(8676002)(5660300002)(110136005)(316002)(76116006)(66556008)(66946007)(66476007)(2906002)(54906003)(64756008)(66446008)(52536014)(8936002)(71200400001)(55016003)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXHt7IbphnK0K2OHxxPRPg5NwDpNlD0wNP1qJ9tlLgSTqcD3vF91iicOSxuQ?=
 =?us-ascii?Q?4CqY9gk4WUaD7N1A77kD9UxksmmU35K+6x19XNWENoJXV+DKETbWfiPcv1l+?=
 =?us-ascii?Q?vHe4CSVvTh4Tw4A3q0o9hexSHHkBdqu2tvFqeM1LmCbuz3HwcQe+ULCI22Vx?=
 =?us-ascii?Q?K3dNjZAM0oXYh9rVOf71tGIgTkOsEg/+UXzmpj9uV6696ITBdUfTM0ppHbwb?=
 =?us-ascii?Q?lbx+znHNLyfKdhzCyPfmsuLQOwFR6XPg5T9IP4s+q6BlpNIAz9yoWzeTf++C?=
 =?us-ascii?Q?GSc2DW+uX9LqNRfooqgDAa2wNgTDpDt8POrtnMK6hYjCiIX7nBnNbndiJ6rk?=
 =?us-ascii?Q?Ag0lGFDeJlp52EpBdjjKclnFvltN9iqR8LAs2cvI88LMix+JM8H817o47F3c?=
 =?us-ascii?Q?yCl5TrHy75hMLEyytCSaVaOBiWOE6hC51Yo3z7YkqolCMIc5Q82gwCu79rio?=
 =?us-ascii?Q?9yc6upHp31VWHcBUtLqoTqJLLmopeS0S8R9Fa7qP6JOaZs/80Bt7mNfAR57I?=
 =?us-ascii?Q?UX72W7dmkam5r3puTrH0dt9uV6YESg9nL5xIskifbDU69gwMLz2ukjJHGaMJ?=
 =?us-ascii?Q?OLGoSgRpAzu4LMKvSA5pxM6/caEaa4+D7ZpU+4S35MnTD1qvgz9n9pH6yYHK?=
 =?us-ascii?Q?LMTyL0lQhZBCmGQqmtP2Q57XUWPAvFK58FvMFsbb3bRK/DkkVha04eC5OKAC?=
 =?us-ascii?Q?Y+I4P+8lxxKW6BePgUYZlhnCpffaleQG8FDBj6tQK8ikmEH3toArvuBE5j70?=
 =?us-ascii?Q?hmtrCRK44sVrK4W+is5hMMeUijwp/hjlx2MUg3xZN7ueJBFkrKypylpBIqH8?=
 =?us-ascii?Q?eHBoIJi3StHC3l6OMxqycm1y8ZWoohLJLN30FVt6bU496K7DdhQAoQG4xzC7?=
 =?us-ascii?Q?zBDVQ3IYNcRtMsm09TVhCg9oXh+sIDCGCGA+09Y3oYouh0VVagEmanA+lYdn?=
 =?us-ascii?Q?YoCV4UJgdfOnOwDt0tyofRYz8t3e6Ok4ZznxA8u0umiUfKYHMVX692vrjqWQ?=
 =?us-ascii?Q?m9oKPNC70Y5k3H5NMW44hVUdx8dZjOxVg1KdqTPfC6luKd1ppXoZBNlzrt4f?=
 =?us-ascii?Q?wONK10P+jT4oWXb8MYu2ouzTP69sDMPRaE1byHNyrd9KJHIZ6uXyHTbr/b3V?=
 =?us-ascii?Q?6dqHejdpbepmDenM7eFK+TQglPrbEhqljhP51eB/N9vx3LwJLh/QeTWI1yYq?=
 =?us-ascii?Q?6KH4wVdCC5LuSw+jQN0RHrBqg/vL3jZaAqGHQmBz4pMahp5/EqNWFGlrVO3A?=
 =?us-ascii?Q?sDWwumk7ZfB6//46baBCwfPgyzUdJH+ZUwVnSLRL85RGndPAMCpecLdTgEnL?=
 =?us-ascii?Q?oIIHGxv+4c1rTGLtwozpUrrlOYnNSD8Y1CUMyGL8Q69WYUFUR1q5VEEVyOzX?=
 =?us-ascii?Q?c5h8wgBFaeTHzODE9+drZ63xYA1OTXVS5caWuXtj5DpaQ3FAQWJ2faMJBd8g?=
 =?us-ascii?Q?dG2MlJN1xLdatXjMSDmbNDc1s12w6HWRtZPFdxS4ZLEfV9PzgKYeaKcQb8lh?=
 =?us-ascii?Q?Ft+VDzVKyT/NXJiSIrOE2+nrGcMiQnx4VwB/fqUDt2pE6ay/QIzQf/dzJyIT?=
 =?us-ascii?Q?1X1hUqAi+FyDlp7hJx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86177d0e-e0f2-4f09-3894-08dbdaa61f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 06:45:22.8697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EwxUm7B4mFbCL1pEN3Thf98bCng50dhV+AACx2COuLhVSQO/nfVcMp9+cHjwYa0EhRm9iPctgedY5gbN5i/Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Tuesday, October 31, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: Don't warn for unsupported
> set_xgmi_plpd_mode
>
> set_xgmi_plpd_mode may be unsupported and this isn't error, no need to
> print warning for it.
>
> Suggested-by: lijo.lazar@amd.com
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 0533f873001b..c9b09bddbcdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1138,7 +1138,8 @@ static int amdgpu_ras_error_inject_xgmi(struct
> amdgpu_device *adev,
>       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>               dev_warn(adev->dev, "Failed to disallow df cstate");
>
> -     if (amdgpu_dpm_set_xgmi_plpd_mode(adev,
> XGMI_PLPD_DISALLOW))
> +     ret =3D amdgpu_dpm_set_xgmi_plpd_mode(adev,
> XGMI_PLPD_DISALLOW);
> +     if (ret && ret !=3D -EOPNOTSUPP)
>               dev_warn(adev->dev, "Failed to disallow XGMI power down");
>
>       ret =3D psp_ras_trigger_error(&adev->psp, block_info, instance_mask=
);
> @@ -1146,7 +1147,8 @@ static int amdgpu_ras_error_inject_xgmi(struct
> amdgpu_device *adev,
>       if (amdgpu_ras_intr_triggered())
>               return ret;
>
> -     if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT))
> +     ret =3D amdgpu_dpm_set_xgmi_plpd_mode(adev,
> XGMI_PLPD_DEFAULT);
> +     if (ret && ret !=3D -EOPNOTSUPP)
>               dev_warn(adev->dev, "Failed to allow XGMI power down");
>
>       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> --
> 2.35.1

