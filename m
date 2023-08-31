Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C59C83F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 07:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0759010E166;
	Thu, 31 Aug 2023 07:15:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1484910E166
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 07:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4oCAmwBJSPqcs30U4NgMuxdVHGw3Aq5gEBxR9XuMSHJC5CJf+vbHCxVPWpcy7JyAzDUuFZe7A7Yf2eXB3pRQtc052lDrc5mhSWxEEizllDM6rCEE/JXIXvNcB3wdwS6NhyMtk1PJnUnWMzHRQR0JsKmu7wCKrXdbCVo+wKe5Itaoina/8QcEns572Px90WiCkpPXpqfe3j1yCLrH2ZpRk5ohAVWnT9che+NLOz+F40+2+9PDbq54Cojde63zJu//hm7j+gUtMO0jSZGEltKVBKP0rNDK6TGzMOnWEULK0QMwnjeD2XOFC2GzASvtvUk5KRb0Jf0jupQ1smQAWoHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOwyz5ppEdN08P6MIwkX3VjwBEn1fvKRtIL6dQFrs6k=;
 b=AK2NtTIO9WSzi83k5Uz8GZKX2uLUFnXUYhr3WCOqDv9rOufBGGbXd1/C8Hv+8U8ueXa7DrujGzsw36exBCs+FNhWMykk/OhdnqV6Qab4DdoiaihVRSmgc/8w03wRQ/3bfZvbXLfQ+WpoOuN4prp5JzJ3VVJK+QeAgF9ttDdsDcl8ueR2jLpKu1vLnDMrIxPYaLDqeoOYITLLvlnE2E5hLgvge9Uh2QcZo0+SCS8EuU6IbM/IY7lCqqPbl51yk/OrB1r6VN3WnlUrL5+Eonx+GYrilsjDtZ1eQoX21SxzaHFDzaoT1b5E+NAysakUJBDJELRdIK1q16bbZMDPDhL//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOwyz5ppEdN08P6MIwkX3VjwBEn1fvKRtIL6dQFrs6k=;
 b=izWwCXHZsYD5EO7Pc4fD6CjSxfu/fRA+DDos8HG77ZgllGTJ/upn76xOF/scDt/ajXXK66rMdkni/LBW9HgIYOu0fHK4WR8lrDhpU6H+JOe4rbq/bfhY5A5Nin0twFeVWVaZd3bfkRGiqRQN2+o7WXSiBjVtpPoA6tTxWdXvr0I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 07:15:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 07:15:39 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amd/pm: only poweron/off vcn/jpeg when they are
 valid.
Thread-Topic: [PATCH v3] drm/amd/pm: only poweron/off vcn/jpeg when they are
 valid.
Thread-Index: AQHZ29Q6Kqu+Fmko30ypaOXLcNdStLAD/c5A
Date: Thu, 31 Aug 2023 07:15:39 +0000
Message-ID: <DM6PR12MB2619DE3BAE7B9BB1CA4F8BF1E4E5A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230831062712.4122679-1-yifan1.zhang@amd.com>
In-Reply-To: <20230831062712.4122679-1-yifan1.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=91264adf-c5b3-4c90-9b3d-060b3fa9b7d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-31T07:14:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|PH8PR12MB7349:EE_
x-ms-office365-filtering-correlation-id: fa29080d-625b-49b9-b6be-08dba9f21497
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhSoxMjRvUWsSFFHQAbcCfBc7s4cr4WmfgCgaxmLMGKvA36vrJjJL9DOU5PxM0172ZYD3RhFFUZW7Gy6VfkK/LEL2xw2A8l7LuzipjDziwzcPPuGNP6IIUZR4fnidzgpah+EkDqHLAukXCvedqcRSZsBvkK1yvM+cQFmtWLrdMD+NLnvj81JG2b0DuGt14UNq15wP0w3Ema5N8DN5izIM6S0x4KiSJMPUG4vepUjiueNMvkJ+rvWkWCGCnCjYnUGxq3TxU+fZepwfjKWdeyLrz1WKJzFsuGEq+IRupgo+hoC3mDRW95DlSfMSCbjj4nuFvffroke4T8m2HbJgJ5wn2g70geShfngmhoo/nDxuQ9vi4ATH6zUpHVGyIS+3ktfUvZ4GZCJYLujZwDhrEeeqyWuY/Xs5zJ2rdbQEFytjROa75APT48BHIbjG+nhr+2AZnGJZDiLhDyA3bWy/Xu+niOqTb7Wi5J6KMlmkBX1GIavQsNh0J5HW9ikpKp1hQGNfO2lnx4Ang1A83scnvOrWV9fTfi4Vd74o7JKv3OKZX80oFGfJ0lC25cndwnurekh0yo9Ni9oUit2ZAxlc17FeTGwVbSWnynwab5qa0RImpuXQd3bRqjYzW3kMGY9i4+b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(33656002)(55016003)(83380400001)(8676002)(52536014)(86362001)(41300700001)(8936002)(4326008)(5660300002)(7696005)(26005)(53546011)(71200400001)(6506007)(9686003)(478600001)(110136005)(76116006)(2906002)(38070700005)(122000001)(38100700002)(66556008)(66476007)(64756008)(66946007)(66446008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QXD5cajLoI7cMu9SbWVWcK2/xs23vXd2DbMQr8/gzK56atfNaHuRCgRpFcbs?=
 =?us-ascii?Q?m4yT2g/3QmXsywRmpmu1DvlCd8hFAKyTD18hK5ReNoOGG7P2NrkaB0Q6LnWr?=
 =?us-ascii?Q?FjgdxXAwY+vsnlWLX1lhVGIxfo7TaAUXhhmNmw9C+eBWI06wv03JE2boeR1p?=
 =?us-ascii?Q?FogTDgCoDcdKD7nZa5lyrZSmHZ81QzyObtgiSQ6msPsXZ/lVqnp6wqfd7069?=
 =?us-ascii?Q?AahU2Ia5i+fwBlYH5oa568ByDHlrtcLh0DgtTWwlUl3AJ18AHh4qUsF3dl96?=
 =?us-ascii?Q?YAlQSR8YgLwEHmWnwwNbhe5pu5dYt5ymoMv2uC9ntbKX+eq0JKE2RLD6qqou?=
 =?us-ascii?Q?3Rq4xpSciuZifRhH6W7ADw44kAaOZYGDKun7Yxm9sP6kUm5HLduhGQPHgB5B?=
 =?us-ascii?Q?xVAEn6Itk96RTgFyxd4+VZVrEao7sucVYRRpiHAufFSkKpZZDmuHGg0hxc5s?=
 =?us-ascii?Q?kxudUHWvDMtcvaE2aefq0TICg3ntA+XrwaH7xFpXKjqymjI15y2RpE6zyYRO?=
 =?us-ascii?Q?JfW2Kl1qcGHGBjucG8cuHutVfK/Hr5DV5Msovac2lOQdrxuFCy40QIeF9Peg?=
 =?us-ascii?Q?RnNyIEtUvFIN9l/qgIOfgygcVj8NDcRANOw791TbzV5nrOI4jwAIYsXyGxpG?=
 =?us-ascii?Q?GcVXj5FN2PxZLFZCkfl93mrHPjQipLaHOkQdtGoBiTwUOYEo11mPUzqVYEXI?=
 =?us-ascii?Q?cjfYO479BwDc8SgMl9c8I3768A1zmggWCtZwaB+X2JFK6XCoP8L9+u7JrJ+Q?=
 =?us-ascii?Q?rKuWl2GJuFDxeONCOwqpLWnnbMaFUsYo6jRVwUbj/v/TZCy03687LJp5EvDD?=
 =?us-ascii?Q?yqLEIngc5I+VrmePMxcE8rCI2RP1+inzyDGG0BWGg7FmUJSL+kdnXYGZyzmh?=
 =?us-ascii?Q?OWWIhFuy+vdE0AdzIgkVQxvgpAcv0ukKnZ+SHUpfqxUlJI9VzV+/LPMDuQ/+?=
 =?us-ascii?Q?+mx5qDsrabW/J27ms2Xal5QVSyIHXC+4d4Y8SXdpRdbIy2oJv7QdQv98s88c?=
 =?us-ascii?Q?Lw7JZ2CUXgUKIiycbkUD5tPpavAnNIBWkf/K6BswIuehDFIBywlxcP4vW+8g?=
 =?us-ascii?Q?QhKmpzXoAMPLFJ3jPFQbKVaCX6KQ+hT34BBjUeCh6TYChzzLckaFzMiMzzfS?=
 =?us-ascii?Q?9/GL4+w8bC+Eoo0WM01JOvS3TOFDty0kH8+3iq/aOsDCCcL2ySJuKALbC9gl?=
 =?us-ascii?Q?CNWGpNS7xHalZxYI5+bG13sHgbK0TxntRg/FaXZ4x7auGmk+CFe1o0pXjHi3?=
 =?us-ascii?Q?qObuK3w2P76hx+tTmksjLiI+YJokqhg8sEif8iJ3oa08+1ndeB56M9tlR1sp?=
 =?us-ascii?Q?X5PDCMUSCR8i0rR+ZPFMfCute0wBr+80GFujcKoy1kOyuoQmq+YVW0NTuRHV?=
 =?us-ascii?Q?YnReiiBR3B80FrqPNOXZiTmkzuBi3yWVqIdkfR989E7nJudKiEcjd7NeAmUy?=
 =?us-ascii?Q?sRpyec0fZyEYO/cnkhtm3WiG7E9fE6rC7p7IgQDMSTH8T4NxxKOO/2v8GYMo?=
 =?us-ascii?Q?7V9D2+ewqphMCpSzoDRl4OMKegLZUTNz27KWri8Ne5RKlSKlPHofAwOaifgp?=
 =?us-ascii?Q?XadAeIDcJtD5i8K0H6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa29080d-625b-49b9-b6be-08dba9f21497
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 07:15:39.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOpBACCh06ZTc/qll7HQKeHyf1MssnZm7B9hTQ1iyd3+eLc2ix4PAbZtbeksMXUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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
Cc: "Ma, Li" <Li.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, August 31, 2023 2:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Ma, Li <Li.Ma@amd.com>; Zhang,
> Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH v3] drm/amd/pm: only poweron/off vcn/jpeg when they are
> valid.
>
> If vcn is disabled in kernel parameters, don't touch vcn,
> otherwise it may cause vcn hang.
>
> v2: delete unnecessary logs
> v3: move "is_vcn_enabled" check to smu_dpm_setvcn/jpeg_enable (Evan)
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 24
> +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..e3e1f69643ce 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -215,6 +215,21 @@ static int smu_set_gfx_imu_enable(struct
> smu_context *smu)
>       return smu_set_gfx_power_up_by_imu(smu);
>  }
>
> +static bool is_vcn_enabled(struct amdgpu_device *adev)
> +{
> +     int i;
> +
> +     for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +             if ((adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_VCN ||
> +                     adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_JPEG) &&
> +                     !adev->ip_blocks[i].status.valid)
> +
There seems an extra empty line here. With this dropped, the patch is revie=
wed-by: Evan Quan <evan.quan@amd.com>

Evan
> +                     return false;
> +     }
> +
> +     return true;
> +}
> +
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>                                 bool enable)
>  {
> @@ -222,6 +237,12 @@ static int smu_dpm_set_vcn_enable(struct
> smu_context *smu,
>       struct smu_power_gate *power_gate =3D &smu_power->power_gate;
>       int ret =3D 0;
>
> +     /*
> +      * don't poweron vcn/jpeg when they are skipped.
> +      */
> +     if (!is_vcn_enabled(smu->adev))
> +             return 0;
> +
>       if (!smu->ppt_funcs->dpm_set_vcn_enable)
>               return 0;
>
> @@ -242,6 +263,9 @@ static int smu_dpm_set_jpeg_enable(struct
> smu_context *smu,
>       struct smu_power_gate *power_gate =3D &smu_power->power_gate;
>       int ret =3D 0;
>
> +     if (!is_vcn_enabled(smu->adev))
> +             return 0;
> +
>       if (!smu->ppt_funcs->dpm_set_jpeg_enable)
>               return 0;
>
> --
> 2.37.3

