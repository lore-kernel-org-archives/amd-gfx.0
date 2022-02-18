Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26651C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 04:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87DF10ECBF;
	Fri, 18 Feb 2022 04:03:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3897610ECBF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 04:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL9NqF4auvj4qyX45XpeH5kOEZ/uPI9IWqHJdHb+huZ+2cywzLHKlXeiEcAdnweyoSb03IA1rIP4IgCJXLsyT+D/zWmo1J4NGcR69dOwPciZ0UJ9BIdpI+ZTftKZoak+cOz97TCqW5u6a0dzHelr6f0dDUxW4yYUtWR/A/R9tVGwl2tHf/I6A1iHOEHNq6s32+XgDEQa2lu0dRnKBz+PYeq5wNoNm3BK0UsrK3lNucVODFUIocJMcm9ALKs7/cfO5cyg+J7lAASl/6XWdZCWs+9VhMEGt/ssxoxSH/jPtZEALFl42GsYi68Gt2hhYeqTzG5e/wQTTM68J21Z2wAG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxFbhgJO3dEOcHwUi3XjHGO6pmX40nhwwy1fhGxJMWE=;
 b=kVj1xoaxlOPMgQ+VYBmTGFPNm3ED/pk7QdrKF2N7kr0bv/tRH37gotkCZO9dX6C3Z7Y/mu+gmHPNjkw6iCfseR7nDKRVIz8pm1etpGzsPA6ZXg7DpLSLwLSJjMVsTyl8SLwDVGZvLsN8VIiUB+bPFsF5WD79gdJDTEE6B4asVTwm/y2JzyzNR1O7VskuIA3yT7kK1Pk+7s2FkP1v+mTvZEgpYaXllXeC/Xku4XWI1W+5dn+cbqs9uR01rNCHjYqHNDGqvGqcacJgN+TPsGgdcDFzUwYf9BQ9S9pGVEkoZBdWei/6gXxKDkeoDvzEQZUh5H6CD2DyTEm41FMUZLWZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxFbhgJO3dEOcHwUi3XjHGO6pmX40nhwwy1fhGxJMWE=;
 b=iJ+GljUl+7TNyzg87hHkiMiTjvOtGd0dII5sKR9ulyxLboTGq+oWbvbED0VSKAMqeXgA89ARVfajdps1TJ6iqDwePggcfyoqb3T3YAituWgaejeJvQHUq3sZXC+/6Z378zzDPOnSMU6lJTuogp/bztufao/os9kIuZjVt/fd4oQ=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 04:03:02 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba%7]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 04:03:01 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Topic: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Index: AQHYJHukXF9TM850b0GuCM8tTPxT8qyYryLQ
Date: Fri, 18 Feb 2022 04:03:01 +0000
Message-ID: <BYAPR12MB32386BDBD0153DBFB038EE69FB379@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8f415d31-1f87-4945-bd0c-3eb0e48235d7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T04:02:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b218d0ec-7b7e-4fa1-b712-08d9f2938e97
x-ms-traffictypediagnostic: DM6PR12MB3769:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3769A1F8597ECCCB3B7921ECFB379@DM6PR12MB3769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccguFtnMhlHx6tWCMV3hZYrUHH68gT/KYVjiGsJV43rEkF1Mc9RY52xO2S1aC1iVdOJRcSudJdIntjEOo7AXy99kZnJYkT83UfLH+ZnirVlOlmKGM4SAN6QxFpyDEeEH6ZU4VcGFzI3qRcR2Rojvyqg6d/1WWAfvcQCvyP/fitfS+LfeKwVvcOA+Z5ZHrrkCy0cmOehMJ8iAHjgIj8b/sjyYFi5a+7nzmMOQPlQI81i84aRdUAjEf9kTXmaZci1cRtaeMnNtYG7Qk9c0BP6r/bQm0hb/Pbbo2oQ1rS56UE97yRnxHdEsxSPwkZVyWf6FfHUP/M62LkNswhAg0Sk7sL5yQ9y7km5NQ6OFihXOlxW8Bl/4jmtNyRX9RcjM0BimUP44naCr7w6magNMbOzpYdnyZ3MlGCHWbqqIBau+fhACfXaOBRMZtYebrWu2uQni7brXtobwUA3WHG7Ks4RnLojMYKWhzqhjp7nB6dlp2arSDnAPnNvQfI+/dLp9FcaAyvgNYW8JcK3fEbM9IxysVUD9WNN+zObf+9EDV1nNYnMS75Vve43lPQkSWBgKPiMxMXFGf34TF9ufoWAJ92nSVh0ChGLM2CH/ScDikJap5dZo8HwZbPRq5HdlnIx5YN4AlKOqtI6Tpn0lyQVzGiZ0nHSiJPBZB0NPs6u9cgoA+E1Cqlqkf2a+DG6ysfeauEteFv90l+4kWU/nB6uh5tRLjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66556008)(64756008)(4326008)(8676002)(316002)(76116006)(66946007)(66476007)(38070700005)(71200400001)(508600001)(6916009)(54906003)(66446008)(186003)(8936002)(53546011)(86362001)(122000001)(38100700002)(5660300002)(7696005)(6506007)(9686003)(2906002)(15650500001)(55016003)(33656002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZugJGFLfOO8NT39QkEZ/+y9BtEDRdBL5VJnUKkxVxexr7LFoNMIl7gtw6W6?=
 =?us-ascii?Q?y6Hz46FgS/lKPcY0BVh9yJH0wr5mKIskKkVebtem1yFIg3RDkap7JyyA4BP1?=
 =?us-ascii?Q?PKP1y9mmSOUB60KbGPUraDDWF7o2iyqJPW9HEOPa/ZPsEzWIwl/eSSde4B/d?=
 =?us-ascii?Q?ghf8KCsLOkYcvQRi6dE0mf+Fhf21BxwOXDS/LXC5Yja3ru5GST6y1gFRMrQ9?=
 =?us-ascii?Q?wPldfCwscu6hd/LKlUb5w4CFlG6Lg0TIk4s0SWoZFgro8J3f05S2fWeTWtTP?=
 =?us-ascii?Q?583wpchJP0QOAdKnbbQwoAvyOvZY9OPnJYfhb+r+Nv9SiFnD0ExtCCkSe0SZ?=
 =?us-ascii?Q?QVquP0vOAQYA4Lvo1/KodUsdwG9uJVIZEsLslqMu2FseAf3nvHnvHrgr3Ebb?=
 =?us-ascii?Q?QxPlMvOlMei5mPjrHK2UyDZODbOJM1dz5hIp1pJXLQuLEfsSBayCNROTquK7?=
 =?us-ascii?Q?AYcvuixRjSJckjkLYbMd/PVYfYNe+AbduuVE2BCRHF700sX4r6k1cVeRhRs0?=
 =?us-ascii?Q?hijB2OlTDEPK8VyzWe5nb3SwE8R9R8TvmaNBXc/72y8pf2/M+czFBiBGctPe?=
 =?us-ascii?Q?dMOGx7I9wIicPUp7TsjEIPuexTL+YyqMoN8iUiXjYU/MUWdYAQnPQIJllP4w?=
 =?us-ascii?Q?cj3uFWzm2jmnmu+0sakOg/7TZlvQl1AAJ8ULruTSAmKXmkPCf6JvE4DQ+RE+?=
 =?us-ascii?Q?8yqUX+1hN7nMMiEZValsMgZVhiFTYPyewcMSomovuYUR4z+k22hdnVZvifOh?=
 =?us-ascii?Q?Gx3f/3DLd+ViAiC26Asz4znHRI9Kvs34m0HptygsrtWjgjkoVEEQbJ8O2gcS?=
 =?us-ascii?Q?K0ssqi8dPSRezJRmCs1rUP/ynv0RDTRBYRBg4lhBPeZyeGsY9kyCdKwZNpOx?=
 =?us-ascii?Q?1vkWmPy4Nq9xCFM0xrq1XMjcRyAM35fvAUOlQc4yJ8ZxHgDEq3IUCjFq1tGC?=
 =?us-ascii?Q?4gNCu7pi9nSbCOBFG8xfRk8zwiU/MoXC1JKflL8cZEFtYlhHLLjoYYN4JTqv?=
 =?us-ascii?Q?mxhDlyPpaCc51/84kxdorhDUUZxwqrpgbhK+n+xExlblw2PEkZuuaF2zByey?=
 =?us-ascii?Q?AMnMHveF6CzcuyQDHdFBZIHY/08aTqUGrbnXovI9b54uQMAFekj2SFRVmroN?=
 =?us-ascii?Q?5YC8P8+6wpVW4JgszpSjyIs7KTKPp2ZDEtRg0b+4543zE9/mRVj0kgMUBPfF?=
 =?us-ascii?Q?zUrulxnrmg2suFIcfoM8pH0xbdx8F60kZpsB90lpFWI/XgKYzYUTPpFIEA5o?=
 =?us-ascii?Q?oAiFbfovFyhtxylsBwygyTcKgkEdfWpIQLBB27nVy8GAKleqnQ5/NwLVjN8N?=
 =?us-ascii?Q?zjk5nGleR8VS1wZttw8H/cQ0U91ddd3EdAtfPeXywuOYelICdrC4cvDrjoB8?=
 =?us-ascii?Q?/UayyYp9FT5F/wcblFPNHGk4zWJaEscq2gcSHq8W/qDAJZfVOG92qMdnutKW?=
 =?us-ascii?Q?7N7NKMa5xtU59oZaW++QQrmx86zVOsJNiZ7kblzDqD73OtUz3E3urp4Yy7na?=
 =?us-ascii?Q?w8+pLxhlrlsQiZCw61HZucxmyQDQQg3C49kBz5vM8XUYYtbjLthSQOOBng?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b218d0ec-7b7e-4fa1-b712-08d9f2938e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 04:03:01.4495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvuh/cDf8sczwJlRM4TCbLTeSUo7sRgsEUtXLY6oMAmEgupRFYXj/YLzs5BZa7Yt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Please ignore this patch for the moment and seems need take care the RN ser=
ies for a special case.

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, February 18, 2022 11:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amd/pm: validate SMU feature enable message for
> getting feature enabled mask
>
> There's always miss the SMU feature enabled checked in the NPI phase, so
> let validate the SMU feature enable message directly rather than add more
> and more MP1 version check.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 28 ++++++--------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index f24111d28290..da1ac70ed455 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -552,10 +552,9 @@ bool smu_cmn_clk_dpm_is_enabled(struct
> smu_context *smu,  int smu_cmn_get_enabled_mask(struct smu_context
> *smu,
>                            uint64_t *feature_mask)
>  {
> -     struct amdgpu_device *adev =3D smu->adev;
>       uint32_t *feature_mask_high;
>       uint32_t *feature_mask_low;
> -     int ret =3D 0;
> +     int ret =3D 0, index =3D 0;
>
>       if (!feature_mask)
>               return -EINVAL;
> @@ -563,12 +562,10 @@ int smu_cmn_get_enabled_mask(struct
> smu_context *smu,
>       feature_mask_low =3D &((uint32_t *)feature_mask)[0];
>       feature_mask_high =3D &((uint32_t *)feature_mask)[1];
>
> -     switch (adev->ip_versions[MP1_HWIP][0]) {
> -     /* For Vangogh and Yellow Carp */
> -     case IP_VERSION(11, 5, 0):
> -     case IP_VERSION(13, 0, 1):
> -     case IP_VERSION(13, 0, 3):
> -     case IP_VERSION(13, 0, 8):
> +     index =3D smu_cmn_to_asic_specific_index(smu,
> +                                             CMN2ASIC_MAPPING_MSG,
> +
>       SMU_MSG_GetEnabledSmuFeatures);
> +     if (index > 0) {
>               ret =3D smu_cmn_send_smc_msg_with_param(smu,
>
> SMU_MSG_GetEnabledSmuFeatures,
>                                                     0,
> @@ -580,19 +577,7 @@ int smu_cmn_get_enabled_mask(struct
> smu_context *smu,
>
> SMU_MSG_GetEnabledSmuFeatures,
>                                                     1,
>                                                     feature_mask_high);
> -             break;
> -     /*
> -      * For Cyan Skillfish and Renoir, there is no interface provided by
> PMFW
> -      * to retrieve the enabled features. So, we assume all features are
> enabled.
> -      * TODO: add other APU ASICs which suffer from the same issue here
> -      */
> -     case IP_VERSION(11, 0, 8):
> -     case IP_VERSION(12, 0, 0):
> -     case IP_VERSION(12, 0, 1):
> -             memset(feature_mask, 0xff, sizeof(*feature_mask));
> -             break;
> -     /* other dGPU ASICs */
> -     default:
> +     } else {
>               ret =3D smu_cmn_send_smc_msg(smu,
>
> SMU_MSG_GetEnabledSmuFeaturesHigh,
>                                          feature_mask_high);
> @@ -602,7 +587,6 @@ int smu_cmn_get_enabled_mask(struct smu_context
> *smu,
>               ret =3D smu_cmn_send_smc_msg(smu,
>
> SMU_MSG_GetEnabledSmuFeaturesLow,
>                                          feature_mask_low);
> -             break;
>       }
>
>       return ret;
> --
> 2.17.1

