Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4891C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 02:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AED610E26B;
	Mon, 24 Jul 2023 02:59:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F1A10E26B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 02:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX4pw9Om7lfrGj68RWhuRoxSvHm8Tn4+82VaslG0XlBTL5axXja+CugrUZw8+eqhXjWfjeRR9sk7ETBlSRKMv85W5dn0oaP8eyGmkWwxuZuoB1ViftKfQQItutMsku26KjevRaPBUvKuJREaiAzVDTjTlb51ZfJPgPRvpBdV1By4uJY0+v8emwjI+7sXttZVlfL8SaWgjMdnPxBYCMkG4J067U4SpXmypZ7DybBDSAbFVtRk7WVXjiFX4EQGKqIX2uv0wQdNzYxLaCPi0Fd5YFqjPR350ZpCWx6qo8/l9xVC2O8o6yyuLQbMeF6Vac+C5Kjih6ljoDvP0jKKnBFcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCXoFWfqOfSeNCmhIR0ssT2hulkOndT6VHV2ZecYuq4=;
 b=mJJg2xoH8ZXMFOGINmAWA811s1KqrgiVD3wzXl0+W2wfBA18w/yncFuo0txGzhXWgBDyisbtwbSDp6wYKdCDb2gbwAUcZ4wAffEjZA+eehDfkrK0FIVrrurgUoYnFubBHYhIgTzdgWhScfASdQNBPibwmxQw0pwpUX0iYvIb3o3Ab6FKlXc9ly09XCKsiXSqp+2fihjU60ELATCeqKCLPBlIFxjWBe6K3JNMStxD+kFIxEHe95ZS5XeGcEy328IZSxGQ6i5dJCpOcKTx9rq0FLZiGQcyBgvluc4/oQki22zeU2R5c1z72E8oULRrjNcRJKyyLBzxvlmTj6hQt3qAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCXoFWfqOfSeNCmhIR0ssT2hulkOndT6VHV2ZecYuq4=;
 b=oJNKTOvQQqxhB01LmOlr5bpO4gRVEs9l2ovilK73R859M0+dp+xrgt/jjwgKVmmV/VisroQhfY0sPaxKjazqls/ZEK9LC8yZPNJ1mCkrAbu8BpZ8cg3Ztk3fGzyQP+7bOf4RDwZcdHjnyVkBqK099LwG4zuzkk7dDM//kIclFNY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 02:59:11 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 02:59:11 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: disable the SMU13 OD feature support
 temporarily
Thread-Topic: [PATCH] drm/amd/pm: disable the SMU13 OD feature support
 temporarily
Thread-Index: AQHZvdiVJDWUoDWIhE2Z9Bzk4nAiI6/IOUgw
Date: Mon, 24 Jul 2023 02:59:10 +0000
Message-ID: <DM5PR12MB2469E27E57394C6D17DDDF0EF102A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724024159.501981-1-evan.quan@amd.com>
In-Reply-To: <20230724024159.501981-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=91513462-22df-447b-a9cd-ba743dbe3313;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-24T02:56:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB7803:EE_
x-ms-office365-filtering-correlation-id: 16adfb4f-a400-4a5c-c7cd-08db8bf1f488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbOamkKkMnAg1PMkLcwwRagaHVDIo6hKcfsmB2AP21dalabp9ah5Di70lOn/sKdlaKtSj+Avyt14CytkhzHKwJOMzQ9P/uffk/dz7NMjb+86xzcISad5vd8biD/NMk+1Wt5AL5plgK8Za3HmtavrwI2c8OMImqxJgFbkNKbc63B9Q6Sn6apmzIV7UoCPaE9VKltdaSy61vh3+5EvhGcMS8EA8QOgrSdu3AJW4IxA/PI+GuYNeW9yBguPHWia2UQs0ctvIA3v8BUH7sXrR3mSQ+SrJmqtV7GZqJZJ7oZI5mbWiFnR8slVkDpNFYNtiCiyr/eyzBNAVu9akpN8Gs3iY3eAjgovDzs1QriDck6gJbx6xvXcP5+6ebNNJLwFA2WRDMGJgV3xG051mrZLDMZJIBeB26eyCFkEqOSWxJ9GexhpCs951GuebWUEs5iXKQGa8MRM/roIDuN5YtAmDzPcXvE+2Ycgdcu8Dhx8lISgyNifxGHn3EGyFYFAGmbZ9fhPpxA3IuuOIgciFpUkJas3SZmA/OusuYKLkOEg3wz7fre1L5xNj13a98mCrEYhNmP81PgwFpMA1IUqJjA3PUQms+R1kDXOG8x4LY5Kq4oUjEj9n5SXI+yX9KLWf4fD0tvY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(71200400001)(7696005)(478600001)(9686003)(110136005)(54906003)(53546011)(186003)(6506007)(26005)(2906002)(316002)(41300700001)(76116006)(66946007)(66556008)(66476007)(64756008)(4326008)(66446008)(5660300002)(52536014)(8676002)(8936002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(83380400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TBVt/cgJoQd5BzRb+motYNiNsBBFhoentxkyIiIohqIeQwfjstqPGKwDn/4/?=
 =?us-ascii?Q?/cpJBM5HfjJVkjpjanvN9JdzvAn9EOGe9PjgwVcr5UdUOEPCBjzB9nn4OqIe?=
 =?us-ascii?Q?kJn+vrhoZdK4xUvw68ZklJnlaZ2YHReQcJ929iIGnVJ2GQSVytl8AP6FWwQl?=
 =?us-ascii?Q?jYDw7OwfI5TvbFTqS3q52G4MpZej6vpCVEqDa39NwgQk7NjGr9SXrwFI4ttQ?=
 =?us-ascii?Q?+h6NoPjtntGmSRpmRHKmXx41gVyNYHXdqB9FS/wQUxDF2iKKuUuLkwB8jEIC?=
 =?us-ascii?Q?EU71xhcuA6Oxn2RyxXI0otPDyXV2UZowq0A6rLQAi9nQdTugwo2mlvp5Xe4C?=
 =?us-ascii?Q?VB+JKY0zuFJlzYyjDJIUjTfgdZIisAISXgwmzWjq9j+Vt61oqCvZvUVwptop?=
 =?us-ascii?Q?ihjxRJS01+Rk47dWtAy27w0WeIMSmWNy5zw/dsxZKoYiiuJ+PqP7EwMxhhAg?=
 =?us-ascii?Q?qA65XKfMZRFj6Bpcf+NGCpkO3GwRFrD3HdIcInXiHod5Gczdt6/NjLaZLfqb?=
 =?us-ascii?Q?LV+Lk9vstg3xvBrz6XpKmtLBIbzmB/e4dMP6foJXFZiHzg8Ciy2dex/sFMSa?=
 =?us-ascii?Q?ZLHoca/SzCY739ECnhGzFq/WGcrb984mELl/xJITFF46cI446x066FjDIx7Q?=
 =?us-ascii?Q?icnxYDKaA1fzgDz7hkZe3UABcDu2PXgjmwzOICzy6tz12oz8MymcUmT4Qvm6?=
 =?us-ascii?Q?dzQp8Ioa6dAvOdcSZFY7BvVRNI/4YMh//QpvM8T4BLMcDI4juvdMBtqZ3pK9?=
 =?us-ascii?Q?aGm0eq2NFDVit7Gal5mOxG4Uiyj29HUEJTVjhPh/2T/mihNyFznBVNx+SC6G?=
 =?us-ascii?Q?PdJAs1Iq+3r1j7c9GKJo4dcFigk9w+MknhN6zprOYaPF2dyc47WSxHmFR4Ij?=
 =?us-ascii?Q?2P2CvUiTjkqMCeyuCkysQXKl3wqB35PNe0XbgBkCMkspFt9Urcs+WYQkLGEX?=
 =?us-ascii?Q?PNUiZEBRXoZj96i4UasMk99DeyhiHE+B1iOL6nN2LiGeeSoeYOEj/jMYvGR4?=
 =?us-ascii?Q?fd7msm9oB2xJobUvwzHtdTp9iQp3Hq0dzjVC2vSatrFDSa+0LgD6DZIWWqRL?=
 =?us-ascii?Q?DQTWYS90+JimGi8c2nizEzZ5odlUpXiZqZ6fCxd10JLq4hKRJxtLNr5Gwdyq?=
 =?us-ascii?Q?WDaLeQqFVlWLEBAsxt/bf7SiPbY26hTSPylK+Akr7plcp27ju2UXvtZ2b2D4?=
 =?us-ascii?Q?8DRwP6EIbOlRtOr25gwW3vsZyKwgeIPCvKTKwpuYUiuoebh0wbyNJk4h8HIS?=
 =?us-ascii?Q?fVBljzzIAkL2O+MqutL5pWLKE0nnsesgeUCj0CWo8R0valtKMDYxQa0Rk8yd?=
 =?us-ascii?Q?M3CxAv/qXeDO7r6b/+9UNHHer4QXI1bnKYLerFOtJk4qxCSTch17D7YNi5bN?=
 =?us-ascii?Q?KmTZnFa76pyWkNSQifQ65+sZcVb1ZRAehTrjw+9wdO3GOPc9/0Rfx+aCZt9/?=
 =?us-ascii?Q?CzIp1+/UtxMOqGtdJdbgcdoBieiWmoQgypXAEfOB7p2cVJRKd/7mGEn33O0N?=
 =?us-ascii?Q?o2Ad/dqlHgyMqG7/EKGNKvO70Na6/zrDeCf6P1qtmSvZFCnaFYKPfdTjQF4M?=
 =?us-ascii?Q?QhgWHPbEiW/wyNWelsw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16adfb4f-a400-4a5c-c7cd-08db8bf1f488
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 02:59:10.8561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ThD7kpd7Uu9HduRNqXh3xSprQRo3mtDxiLH00+Dd3gSv7mYC5BExMe6ZM5lm7bgewGruNNWXj3NDrlOyXZJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Looks it's more clear to include code line " smu->od_settings =3D &powerpla=
y_table->overdrive_table;" into the #if 0 section?

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Monday, July 24, 2023 10:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: disable the SMU13 OD feature support
> temporarily
>
> The existing OD interface cannot support the growing demand for more OD
> features. We are in the transition to a new OD mechanism. So, disable the
> SMU13 OD feature support temporarily. And this should be reverted when
> the new OD mechanism online.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 9
> +++++++++  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |
> 4 ++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 60d2684478a0..a3e510981dc5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -348,9 +348,18 @@ static int
> smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
>       if (powerplay_table->platform_caps &
> SMU_13_0_0_PP_PLATFORM_CAP_MACO)
>               smu_baco->maco_support =3D true;
>
> +     /*
> +      * We are in the transition to a new OD mechanism.
> +      * Disable the OD feature support for SMU13 temporarily.
> +      * TODO: get this reverted when new OD mechanism online
> +      */
> +#if 0
>       if (!overdrive_lowerlimits->FeatureCtrlMask ||
>           !overdrive_upperlimits->FeatureCtrlMask)
>               smu->od_enabled =3D false;
> +#else
> +             smu->od_enabled =3D false;
> +#endif
>
>       table_context->thermal_controller_type =3D
>               powerplay_table->thermal_controller_type;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index ebb961f60316..44a3e2bf426b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -338,9 +338,13 @@ static int
> smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
>       if (smu_baco->platform_support && (BoardTable->HsrEnabled ||
> BoardTable->VddqOffEnabled))
>               smu_baco->maco_support =3D true;
>
> +#if 0
>       if (!overdrive_lowerlimits->FeatureCtrlMask ||
>           !overdrive_upperlimits->FeatureCtrlMask)
>               smu->od_enabled =3D false;
> +#else
> +             smu->od_enabled =3D false;
> +#endif
>
>       table_context->thermal_controller_type =3D
>               powerplay_table->thermal_controller_type;
> --
> 2.34.1

