Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E1C4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 01:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2AF10E05D;
	Thu, 18 Jan 2024 01:35:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06C710E05D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 01:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3AjP9YHGQ1xLXKy3jHPRKb9uCrRFjsgEu3LCP9w0le8ZHpUzXRoZeLTdBI4uPIDFSQD+U+npZ8OwTHgB82JKjd6rlHamf7nQcbd0ffkGbWVhyutCBW+njcjDUUrjWe2pMVyaHHWg8xMOuJtsz0ypHcbJpzbKPelj+X7BXfldrE5JA5YlSazy8t55vamYHm1kMvmWZfOyuabwjYUvzd4kqF3PTXZg8tHge2/FZ0LMbvi1FUFVAf4QHTcagenPtyEFkcTIES3IvM4Do1+mcOBtvmEes52drr+/q8oPqTezRj9QU2cwtqqXZUfjvujlqknrtZrFsLMPW0QFKoml+EAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iarf/FgsIqF8myN+cC4R8899yOzvT+7yd8sLBT1TbH0=;
 b=msbO1894JPZGBAgjdRXD40gvA/g921kuxtfuy8F4wLP5Q9mW3zPW/Duy0Wm+4Kc4wWwVCPX5yKWocJwUoSPls9pJG9qjP7SG9ttyseLkeeBFmmwSkv/NhCvwAixDQmGdEs6fc+O28Aqu4JPR0l6SNIITSPrAXEw0d6FrwP1/UVwbCNXefmKNFqi+z62XyXqvOw5uYGOTRoEmUddooVc/07JqZW70vEiJu3biDzo41g7GrqVdG+Rb1v6La4yl8uK2l3JLiiy8g1dQ9m7AyFvkCrqPXqIPrSxaKo0MQNEpDD218ejjDYl7Z3vfFGTT/PUvwOnEgSrP580XJNRCuewKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iarf/FgsIqF8myN+cC4R8899yOzvT+7yd8sLBT1TbH0=;
 b=PMZjRRMO3ff2w/rKn5ngM4YmtMBsPsLHEd3jPMUrpuwJlysocIbdmrDdZwOqE1QL3AFefosBGYKZWARcGYFQopfzXbcr4gR8Xk+u11AIwvuIXtPIYG4sSIgnLpEOxW4gt6uyMse9MIHkum5641NG11xcwvSTEijH7+B4SgeXETU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 01:35:46 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 01:35:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] update check condition of query for ras page retire
Thread-Topic: [PATCH 2/2] update check condition of query for ras page retire
Thread-Index: AQHaSSWim49buScVsEK38SxGJvvTwLDd6YIAgADhOjA=
Date: Thu, 18 Jan 2024 01:35:46 +0000
Message-ID: <PH7PR12MB879691080C71B54D9FA9FCC1B0712@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240117091430.29140-1-tao.zhou1@amd.com>
 <20240117091430.29140-2-tao.zhou1@amd.com>
 <BN9PR12MB5257A35A7FCCF270C82EEFBDFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257A35A7FCCF270C82EEFBDFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5342b37a-e175-433a-abea-c0bb0332a21d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T12:07:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7633:EE_
x-ms-office365-filtering-correlation-id: d2b5fe6c-cae2-4319-530a-08dc17c5cb27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mt0EZvvEjc7IHWOK3Iq7mau7FG9nFtsIZUYuSztJvr8Y2MTFdziHB85znCxgs8agu5XlJfSHV0J7ZY09M+g45QaiUQd9Z0NRDvJP4n93DNBWmgYhOG39Rw77oyBF1vVDl8ivOeBxcydKIxS3gE+oHKwmGDKKhknlfQt4sOqYbxFz/pXtZahvl6XWUK6LJLLS+YSsFA+F1h39mdfkTCo3yOmzPaCIAJXaqKQ7TZnZhjG8z5tkX4puVgseDvdr48X1UFsIhPGmQ2rb9rOwsCcQ4a1wT+40v7v1yZEW3qFlQxGhtMln/UCuswcemYdrrwnqTifT+KqqKoIVQIvsWN10Qy0LPpIGWk6Wnzjk9fMcgN/akytXIlP0G9ezlMctiwuuXWorw8mLp7f1tO696ZDoqoJPjdL1C6jO3GJNi6cXV7QBh8ASWQ8LFaV+PN2depoUR12viNiCAMoq/cMPsioKUE+RA809qv2gTrvKe+KHlsHSWKVk/bahFK7v0vtEYzRF+MM9fPvqT4ny2pau6g4YKrrFNHXXQlADv23cE7DlCoxCxV9WWERpIcxJzYkp/uIs8VnhwwlZUCdwfdOt2FUsFCmo/jHdC6rmi++c30URUyHqxlOIR9ffNGJqbrID8pXl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(9686003)(5660300002)(66556008)(66446008)(38100700002)(122000001)(8676002)(15650500001)(52536014)(71200400001)(41300700001)(2906002)(8936002)(110136005)(478600001)(76116006)(316002)(66476007)(66946007)(64756008)(86362001)(33656002)(38070700009)(7696005)(6506007)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Goc12FBma7cfHVIsA6jEonqRBXKFm+s6SR2f1asbzXwADMyRLzMprtiqO8uD?=
 =?us-ascii?Q?QN+rSYmz1Xk0ztBIkKrQNmw/5i7737fDYk5iq5hKurSUZ68+QpC3Hka25XBW?=
 =?us-ascii?Q?IWJLYY50QumrSfuxbvYmKBJXMtv/cW8Zwa7qyKARzpDauzisiwafUHco8RiH?=
 =?us-ascii?Q?bKhvOng1yAgqtC4OyBG2ZMosgNwX08wQz7w2yJZGT/lKCCMRPAHw2EZBc3AV?=
 =?us-ascii?Q?1bATOHdbocAiKNT0eHmTxnjJ2uvTV5PxXU1/H6khzqzB4rmaIjjFEoSHtw+4?=
 =?us-ascii?Q?2EWd7pOo3gwZh9cW1iwPCajJ9ZpMY5cAzGDJd7ewVd1EITDFfMqTn8Vvy1z3?=
 =?us-ascii?Q?N7nnQ4GWPohdE/hDOzpo5kec+qrUaVEMBkDpMp9ITzmKMEl9xSV6IAtkowMa?=
 =?us-ascii?Q?4rd0km/ZOfZFCdDlDLdvLdOT7L+R6hvQOML4b5Q1rQ8bhIDnOkIoqp49vNgy?=
 =?us-ascii?Q?75Ep+/0rZH5CGg5CWT4mmqJ+u85fIKtcagu3/BCNU54t4SBQAH1hLqLILpQC?=
 =?us-ascii?Q?SDObPAMCLfXUQ33NzAv4aUrhcrsp6u8h9O8xm5xju1zph9vpOKK9flVc+kY6?=
 =?us-ascii?Q?x40RchT1efsixF1T0cg2GMhVK1r4CJlUjY3CfPvJVjJyQUtK6lt76Gkn9irN?=
 =?us-ascii?Q?4lR6pQrNupG7+hPK4CgmWBBSQ20AXe1vFHgmgy2FHq8cMEe3AogyFgR5lrtd?=
 =?us-ascii?Q?mYLcT1yaQHTbIKUvrCjc1SDcayLw0l74IV2zE7VC2sqjWoT3uf1HW5erS7qi?=
 =?us-ascii?Q?uWPUZBmrY+JQMqBs1W6zx2uyFkC8sE4HyV7LNxu7imn8QMiE7b13+NH60FPZ?=
 =?us-ascii?Q?alyB/cVLGkbtvSyxAZhGhOUAI4NH0pK+UR44cDG2hsNU7HqDUdcnO8p2bttc?=
 =?us-ascii?Q?9NfBjMmop2vBWd3lAEBKcw95P8QgUFv11NynCwa1S8R42rQ7xfL31QqEhVPD?=
 =?us-ascii?Q?W+QVbCMovmt7ZL04NmqGyfcCPbXGGOMw6jvITDKyr8pjYow/mvnaiVFg+aAF?=
 =?us-ascii?Q?ukxYOA93CFyLwVdK/PNHk9/m9ymslED8oXjPzhFLgM7MtrC7nM5aNHfVinlP?=
 =?us-ascii?Q?yLQCjeaJhtYdOr0MbrXExywMBjpzP3qD8Sk7RiX0oEr6MHTNhtSdncI3FGwd?=
 =?us-ascii?Q?8FDcYWrE8D+LeWLABneYI0Fdnu0zkkoi+TM61UAEEbM7ylTEbMBowmy8VBDH?=
 =?us-ascii?Q?WwEA8lb4ELqS8yjifA2crUuLfLQshW72ynd1fqNqPeiLn01j9W2AalHgdOqv?=
 =?us-ascii?Q?jMnDr980miL+3g+wps/551FR6EeOkcjcLWmb3xjSadaJlqOOyt7FV5GpMKRj?=
 =?us-ascii?Q?ae4IX1TE130KHNwlVXS/T4IQto/O/6tHQN59k29S5xGhTpSBxD8tHzc9hlki?=
 =?us-ascii?Q?UYV0gc3UnW4GY9486ZaJivcUUsYRp3PpjjmV6Pc04oRD5s7C0YkVpYTTQxjU?=
 =?us-ascii?Q?LxA26irEx5twgNMkIaBKDQ8ZUVLvV7Jga3eYbs5gx351fmF+O5eHvHQEdLbl?=
 =?us-ascii?Q?wkKQSJD2HpC+yfSMZkCtbZnl8RQecX8be6juMlN2YLATxF5TXG8LDGs+X0UJ?=
 =?us-ascii?Q?u9i/Cll712piW2ZXyAo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b5fe6c-cae2-4319-530a-08dc17c5cb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 01:35:46.3586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9ZP4LCqhR370v17fFKFh7rJ6BnCHggePMkDYus4cjBAZb4ocfq+dvrJrDRh8Wv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

Sure, will revert related patch in the next version.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, January 17, 2024 8:09 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 2/2] update check condition of query for ras page ret=
ire
>
> [AMD Official Use Only - General]
>
> static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
>                         void *table)
>  {
> -       /* Support ecc info by default */
> -       return 0;
> +       /* we use debug mode flag instead of this interface */
> +       return -EOPNOTSUPP;
>  }
>
> Shall we just drop the callback implementation? smu_get_ecc_info will ret=
urn -
> EOPNOTSUPP if the callback is not supported.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Wednesday, January 17, 2024 17:15
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] update check condition of query for ras page retire
>
> Support page retirement handling in debug mode.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c              | 9 +++++++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 41139bac7643..6df32f0afd89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -90,12 +90,16 @@ static void amdgpu_umc_handle_bad_pages(struct
> amdgpu_device *adev,  {
>         struct ras_err_data *err_data =3D (struct ras_err_data *)ras_erro=
r_status;
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +       unsigned int error_query_mode;
>         int ret =3D 0;
>
> +       amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
> +
>         mutex_lock(&con->page_retirement_lock);
>
>         ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
> -       if (ret =3D=3D -EOPNOTSUPP) {
> +       if (ret =3D=3D -EOPNOTSUPP &&
> +           error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
>                 if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
>                     adev->umc.ras->ras_block.hw_ops->query_ras_error_coun=
t)
>                     adev->umc.ras->ras_block.hw_ops->query_ras_error_coun=
t(adev,
> ras_error_status); @@ -119,7 +123,8 @@ static void
> amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
>                          */
>                         adev->umc.ras->ras_block.hw_ops-
> >query_ras_error_address(adev, ras_error_status);
>                 }
> -       } else if (!ret) {
> +       } else if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUER=
Y
> ||
> +           (!ret && error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUER=
Y)) {
>                 if (adev->umc.ras &&
>                     adev->umc.ras->ecc_info_query_ras_error_count)
>                     adev->umc.ras->ecc_info_query_ras_error_count(adev,
> ras_error_status); diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index c560f4af214d..d86c9e7fc64b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2909,8 +2909,8 @@ static int
> smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,  static ssiz=
e_t
> smu_v13_0_6_get_ecc_info(struct smu_context *smu,
>                         void *table)
>  {
> -       /* Support ecc info by default */
> -       return 0;
> +       /* we use debug mode flag instead of this interface */
> +       return -EOPNOTSUPP;
>  }
>
>  static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
> --
> 2.35.1
>

