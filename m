Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 13:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4973B10E1BF;
	Thu, 20 Jan 2022 13:41:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758E510E1BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 13:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc/fkhC2H5r297j2VWHFOG7s6+Zlx4Q5Oe3ysaqXufp51+VNJQiBSa0O9qw6pQXIgE/YspoX3cs1EK2UETHb0AGWGTzLKoOSsKrv+WJ/WzeVLAI+yKoSvMj4VcKtPNvskSAMoiExaDVfCDPQldA+ahiuBJCWYTpS1Yidbn4xaxfwSfW5/Pvpouo9zdy3Zxp/LA81Gt9+CqAg/oFYKanscrRnQYMeAyucP9IY7T6s+mYHiigm1j6+62dmORUgAHHU2Uu5xBLG5f893HtlWXlJJFCzDGhkOrIMuLAii++kNZ/dNOldT9HJbn9jJc1WpupX3IC/uWnfZoeStLxMGNeRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4jJ1+bN1t3Qqj7FKgbo2uyGxt/6WxKd8xDVJ6K61wQ=;
 b=DOwmcZQ8ICEHBhnDloGmz22DDFX4rVugoTbk3kjyeCm7/C7/nM7O+DiAqCKbK0ccs+c6pf6Hrs8jN6zF1gXFKdsEQd6mQVHN408uol+uGmcIu46LPB5/RsngPG08edxVxfJgom6OQIetxs24TZ6X2aTBiBF/XeyuuvoO4WwLDGhXwwrIttcsrr+e+sMVO1clmSCUv56xjRfzGGncAF76VHAByC5FrrHrwlVrtBZtbcN3/3y2gWRTM7CcuUtIpxPELc8W5s5Z1w6j0+/QrVSZ8gMf4Kc9YKa2n8LSkmrlybl8wyPRlkbzH2aKMA22Yop4P3kHMCfNu6Oi15qzxtDOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4jJ1+bN1t3Qqj7FKgbo2uyGxt/6WxKd8xDVJ6K61wQ=;
 b=Hjzm6gHCLYwnMzCrg3civ45wasToPmnMNxTGdJYINocWPiI66QbGNKMawFG+BOFuXGo14oV8wzIngFZUsMYYj9uDZEAtwpQ6JHUN+h1F83rooIJYOq7TFR/oAx6UEOIQGSOc8/SfraMbOsjMLnba61gFNX5icJLefbqFWafi7EA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY4PR1201MB2501.namprd12.prod.outlook.com (2603:10b6:903:d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 13:41:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 13:41:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 7/7] drm/amd/pm: drop unneeded hwmgr->smu_lock
Thread-Topic: [PATCH V2 7/7] drm/amd/pm: drop unneeded hwmgr->smu_lock
Thread-Index: AQHYC2UPHKtLa9aM6kqfiRQ5+LoAe6xr0WQAgAAef8A=
Date: Thu, 20 Jan 2022 13:41:31 +0000
Message-ID: <DM5PR12MB24692A21520A9041A812E569F15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
 <20220117054151.124838-7-evan.quan@amd.com>
 <DM6PR12MB261959C203C1D74A51DE6045E45A9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261959C203C1D74A51DE6045E45A9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T13:41:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4cca0d2c-195b-4d11-8874-2e82df65c8fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-20T13:41:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3ebb726d-572e-42cf-befe-501984a223ed
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 770b7d86-e280-4393-c20f-08d9dc1a9171
x-ms-traffictypediagnostic: CY4PR1201MB2501:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB2501E429EE696082F59C5FA7F15A9@CY4PR1201MB2501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1VSooyfb9sV5xEIkck4aMkiCSCBtQRtZ+3FO04WHLVbKj7mT6hgxhET8M+bU9vyMy11mLk/+rUnGuFkm7ei5wTLElrG8b3A7VIxYQADu9P4yqQxMONb2rcb4ajHokOtL9IL1t36IR39k2WDEQ331m/LUO3sNidnMhBT6BBAzbwZHB0V0M9GqMmv4aKxE0umqfn8diQzab7O1IUYpWQm2X4N0SD2WQH1SQhdCp1oiXMxVa52QxFSnr2joGG4cyqD6Ujyu1DdSboqsFENbHiI6aO/lzMhjrUyK7Ze4BXlfaZRKJM57gWX8rpHwS2fZb4xWdiKla+oC2XpmuiLy8+vEHDgpg7oIdGEFo09GqdDVrG0c81ovPU+7cmEO0J7zYlZ8asMa8DziLZK3LLlLjccRuuO3oFgxTY9leF+Bw16KdtNUr0gQcN0Ju1ivCGYvvqy2FfppGOdNkJ18YbOs7N/8a9iIbv3uMI8VSQk0//NIpDD/bQQZhya/d6SG8SUU4aOY7MT5cm7EeutoOam+SVepr0B+0+dF+PLjfATIMYSpV+uj/Xrxd/azFilomKcLmZzed6fI+wdN6qg1CXPW1CLr9WiVl0P1fXhEo3HdYH0Jjrm/n4mL7OXIBKPcQnAKXDVCGsmZ1LTEfoO6Sm8hCbpzb66eAQC2N3ScaAcNi0a+u19RW1hq/irU19dkpCx0zLc7BDFuFePW50ormP1t6kedg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(83380400001)(7696005)(8676002)(55016003)(508600001)(64756008)(66446008)(66946007)(122000001)(66476007)(66556008)(76116006)(86362001)(52536014)(5660300002)(26005)(8936002)(2906002)(316002)(6506007)(33656002)(53546011)(30864003)(71200400001)(110136005)(54906003)(9686003)(186003)(38100700002)(4326008)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uD+WjZ9E6KnbXSE/wIzh3jmYURw9u2yq8kFhqGR7iQNEZ437AX1JqynSaRnq?=
 =?us-ascii?Q?aUkYN/d0SBAPiwNlxhuNmNiEOFbes2zdoWWVohYNXaJBEcr1Sy0gc2gVIzJI?=
 =?us-ascii?Q?cvQr9QZNZG8W8gr11FRrNRn4S0s/GvX98XCrmJq+clYivldBQsnPccyCsu8J?=
 =?us-ascii?Q?ME5qesQv+e1TralzyADH13LGL7QwNqgh8RZFN/LJS+iTwX3Bjweo8cNiPKYI?=
 =?us-ascii?Q?pUv5dGNZ+EdTy6y0uYtHjLU5+VSM4RCsry9z+BvmIDKMODz6d2P/Av2a8zJ+?=
 =?us-ascii?Q?8Cji/ujVuhzCFGixEB9Vnag26Ux3HrJWym0SLhXEtVgldAdXSEpq22QmgJH5?=
 =?us-ascii?Q?gWEJ2MmlE68rSzWogCIUuH4GwVP94T6RlRGb23BWCcC5i833hHswIBGlMfuE?=
 =?us-ascii?Q?rD5qaXAxBIOmNeeBh45mO1NX1r6BmSHQHBU2lXyULlxnZvYC5I/5X9ZUcwio?=
 =?us-ascii?Q?iBTxYjY5fuKZlw1TLwwpCrsr+op9ou+JwJQKRn/ekv4DLAzeQ47e+KUPrROZ?=
 =?us-ascii?Q?nSKR9Y75KnK0me4Hya1JG/iTnBlxqautkEk5fboGG/b1elwpp/2goSoLDKju?=
 =?us-ascii?Q?13TvncrB0D3x1P9N8EBAeYsRdfUWJNHiWlK3taPCwazEICHVYyFDoCeqmNji?=
 =?us-ascii?Q?leQeWKMJV7bAKlnhXHAxzOKQb5Yk0l8QPgguiWayam6ZzuhYq6TYg4QLT17e?=
 =?us-ascii?Q?Z/gOS7vOBW2DsYXgy0CTR2H7IfM7AuOADdqj4J3cN1pzst07w7SEzN/GbG8L?=
 =?us-ascii?Q?4zL5oYsLlKfT/1uMIqaJnpghm4q5Eq4Oq1Lo26K83UMfCgavmS8bJ8o1VtV8?=
 =?us-ascii?Q?zFRcmAz6jtQiy4QeiOoGTWm+qBIF+lg7QyTNoSYCfs+d8INn/RiIJhrjra2H?=
 =?us-ascii?Q?ImBt9PRbj1gnvxGJnzBSCLlbBPlYcqw5tGhLAsxL0eT8vXwueHtv+56AmdWC?=
 =?us-ascii?Q?4Bx4tRHQ1GCpZ75gxwLW+XMJ5XKy/SCWf7JPmg5qXXY69SW5JnSySTnKv7XG?=
 =?us-ascii?Q?jwS9HLsxz1Kz0VdBi27w6i9QVJF/lme/gNe6j5ys/RJCT90fgtYDjSV6Ppwq?=
 =?us-ascii?Q?uKDWX7E/xiDfPKdxPdb7BYoZQpgdNet8dVRIj+haHES1tTa/BP9PUjySm2OX?=
 =?us-ascii?Q?6ibZTUvswQecnoi6QhDkmZSul323bZJcYN4AhBRiYXrHTg0hNTMNHAooUtdU?=
 =?us-ascii?Q?EoSbWfLUL9WTsnkUGskPQHP4u/c/hm1qttaydEk509h7lQBe2ZZXjCMdckRZ?=
 =?us-ascii?Q?xZu9mTO9juU8DEWYheN2bZ/L4/N4i4irz/lKASv43g/Ip0dma4t7SJT8cpkH?=
 =?us-ascii?Q?OlVeebDO9n7WiRtHMOiNkEAdnlP3bEZFKSn4PlOgrhVobHtiSWpqiQvu/0oE?=
 =?us-ascii?Q?IGKP7W56ztBBV7R7/YxJrZu/aypBH9MEFqG6KapBdypuvhi3ii/pzd8Ukit7?=
 =?us-ascii?Q?roPPU1dD+25PHE/068fk+fHwFlHJ1Ciz/wMH/589xwXUawuBHo4FDXaUTg9r?=
 =?us-ascii?Q?w6nq/OmSdiaLiAIn9pnpnoDaopfCblUluZvwT7f/OTkshvUflIPmZW3xWN/P?=
 =?us-ascii?Q?DSew+vqlCLkyKjJtMb6sF8vAXF1GSa0MJLDogv41/Y9CNVXjCwIUOsjP/+sp?=
 =?us-ascii?Q?ylk7gKGaN5l/JVZNsVCU0v0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770b7d86-e280-4393-c20f-08d9dc1a9171
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 13:41:31.1891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAaVk7haItDOqhOBYKFCObIQ2SAHSDw2KOPB+OkapVMfXQnmGp9U+RgcnzcNKHscGZbHmaaKcLsCIVxOunpbjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2501
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

With the comment in patch 1 addressed, the series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Thursday, January 20, 2022 7:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH V2 7/7] drm/amd/pm: drop unneeded hwmgr->smu_lock

[AMD Official Use Only]

Ping for the series..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, January 17, 2022 1:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo=20
> <Lijo.Lazar@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan=20
> <Evan.Quan@amd.com>
> Subject: [PATCH V2 7/7] drm/amd/pm: drop unneeded hwmgr->smu_lock
>=20
> As all those related APIs are already well protected by adev->pm.mutex.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I36426791d3bbc9d84a6ae437da26a892682eb0cb
> ---
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 278 +++---------------
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   1 -
>  2 files changed, 38 insertions(+), 241 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 76c26ae368f9..a2da46bf3985 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -50,7 +50,6 @@ static int amd_powerplay_create(struct amdgpu_device
> *adev)
>  	hwmgr->adev =3D adev;
>  	hwmgr->not_vf =3D !amdgpu_sriov_vf(adev);
>  	hwmgr->device =3D amdgpu_cgs_create_device(adev);
> -	mutex_init(&hwmgr->smu_lock);
>  	mutex_init(&hwmgr->msg_lock);
>  	hwmgr->chip_family =3D adev->family;
>  	hwmgr->chip_id =3D adev->asic_type;
> @@ -178,12 +177,9 @@ static int pp_late_init(void *handle)
>  	struct amdgpu_device *adev =3D handle;
>  	struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>=20
> -	if (hwmgr && hwmgr->pm_en) {
> -		mutex_lock(&hwmgr->smu_lock);
> +	if (hwmgr && hwmgr->pm_en)
>  		hwmgr_handle_task(hwmgr,
>  					AMD_PP_TASK_COMPLETE_INIT,
> NULL);
> -		mutex_unlock(&hwmgr->smu_lock);
> -	}
>  	if (adev->pm.smu_prv_buffer_size !=3D 0)
>  		pp_reserve_vram_for_smu(adev);
>=20
> @@ -345,11 +341,9 @@ static int pp_dpm_force_performance_level(void
> *handle,
>  	if (level =3D=3D hwmgr->dpm_level)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	pp_dpm_en_umd_pstate(hwmgr, &level);
>  	hwmgr->request_dpm_level =3D level;
>  	hwmgr_handle_task(hwmgr,
> AMD_PP_TASK_READJUST_POWER_STATE, NULL);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -358,21 +352,16 @@ static enum amd_dpm_forced_level=20
> pp_dpm_get_performance_level(
>  								void *handle)
>  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	enum amd_dpm_forced_level level;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	level =3D hwmgr->dpm_level;
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return level;
> +	return hwmgr->dpm_level;
>  }
>=20
>  static uint32_t pp_dpm_get_sclk(void *handle, bool low)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	uint32_t clk =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return 0;
> @@ -381,16 +370,12 @@ static uint32_t pp_dpm_get_sclk(void *handle,=20
> bool low)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	clk =3D hwmgr->hwmgr_func->get_sclk(hwmgr, low);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return clk;
> +	return hwmgr->hwmgr_func->get_sclk(hwmgr, low);
>  }
>=20
>  static uint32_t pp_dpm_get_mclk(void *handle, bool low)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	uint32_t clk =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return 0;
> @@ -399,10 +384,7 @@ static uint32_t pp_dpm_get_mclk(void *handle,=20
> bool low)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	clk =3D hwmgr->hwmgr_func->get_mclk(hwmgr, low);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return clk;
> +	return hwmgr->hwmgr_func->get_mclk(hwmgr, low);
>  }
>=20
>  static void pp_dpm_powergate_vce(void *handle, bool gate) @@ -416,9
> +398,7 @@ static void pp_dpm_powergate_vce(void *handle, bool gate)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->powergate_vce(hwmgr, gate);
> -	mutex_unlock(&hwmgr->smu_lock);
>  }
>=20
>  static void pp_dpm_powergate_uvd(void *handle, bool gate) @@ -432,25
> +412,18 @@ static void pp_dpm_powergate_uvd(void *handle, bool gate)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->powergate_uvd(hwmgr, gate);
> -	mutex_unlock(&hwmgr->smu_lock);
>  }
>=20
>  static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_id,
>  		enum amd_pm_state_type *user_state)  {
> -	int ret =3D 0;
>  	struct pp_hwmgr *hwmgr =3D handle;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr_handle_task(hwmgr, task_id, user_state);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return hwmgr_handle_task(hwmgr, task_id, user_state);
>  }
>=20
>  static enum amd_pm_state_type pp_dpm_get_current_power_state(void
> *handle) @@ -462,8 +435,6 @@ static enum amd_pm_state_type=20
> pp_dpm_get_current_power_state(void *handle)
>  	if (!hwmgr || !hwmgr->pm_en || !hwmgr->current_ps)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	state =3D hwmgr->current_ps;
>=20
>  	switch (state->classification.ui_label) { @@ -483,7 +454,6 @@ static=20
> enum amd_pm_state_type pp_dpm_get_current_power_state(void
> *handle)
>  			pm_type =3D POWER_STATE_TYPE_DEFAULT;
>  		break;
>  	}
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return pm_type;
>  }
> @@ -501,9 +471,7 @@ static int pp_dpm_set_fan_control_mode(void=20
> *handle, uint32_t mode)
>  	if (mode =3D=3D U32_MAX)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -521,16 +489,13 @@ static int pp_dpm_get_fan_control_mode(void=20
> *handle, uint32_t *fan_mode)
>  	if (!fan_mode)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	*fan_mode =3D hwmgr->hwmgr_func-
> >get_fan_control_mode(hwmgr);
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
>  static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EOPNOTSUPP;
> @@ -541,16 +506,12 @@ static int pp_dpm_set_fan_speed_pwm(void=20
> *handle, uint32_t speed)
>  	if (speed =3D=3D U32_MAX)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
>  }
>=20
>  static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EOPNOTSUPP;
> @@ -561,16 +522,12 @@ static int pp_dpm_get_fan_speed_pwm(void=20
> *handle, uint32_t *speed)
>  	if (!speed)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
>  }
>=20
>  static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EOPNOTSUPP;
> @@ -581,16 +538,12 @@ static int pp_dpm_get_fan_speed_rpm(void=20
> *handle, uint32_t *rpm)
>  	if (!rpm)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
>  }
>=20
>  static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EOPNOTSUPP;
> @@ -601,10 +554,7 @@ static int pp_dpm_set_fan_speed_rpm(void *handle,=20
> uint32_t rpm)
>  	if (rpm =3D=3D U32_MAX)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
>  }
>=20
>  static int pp_dpm_get_pp_num_states(void *handle, @@ -618,8 +568,6 @@=20
> static int pp_dpm_get_pp_num_states(void *handle,
>  	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	data->nums =3D hwmgr->num_ps;
>=20
>  	for (i =3D 0; i < hwmgr->num_ps; i++) { @@ -642,23 +590,18 @@ static=20
> int pp_dpm_get_pp_num_states(void *handle,
>  				data->states[i] =3D
> POWER_STATE_TYPE_DEFAULT;
>  		}
>  	}
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
>  static int pp_dpm_get_pp_table(void *handle, char **table)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int size =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	*table =3D (char *)hwmgr->soft_pp_table;
> -	size =3D hwmgr->soft_pp_table_size;
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return size;
> +	return hwmgr->soft_pp_table_size;
>  }
>=20
>  static int amd_powerplay_reset(void *handle) @@ -685,13 +628,12 @@=20
> static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size=
)
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	if (!hwmgr->hardcode_pp_table) {
>  		hwmgr->hardcode_pp_table =3D kmemdup(hwmgr-
> >soft_pp_table,
>  						   hwmgr-
> >soft_pp_table_size,
>  						   GFP_KERNEL);
>  		if (!hwmgr->hardcode_pp_table)
> -			goto err;
> +			return ret;
>  	}
>=20
>  	memcpy(hwmgr->hardcode_pp_table, buf, size); @@ -700,17
> +642,11 @@ static int pp_dpm_set_pp_table(void *handle, const char=20
> +*buf,
> size_t size)
>=20
>  	ret =3D amd_powerplay_reset(handle);
>  	if (ret)
> -		goto err;
> +		return ret;
>=20
> -	if (hwmgr->hwmgr_func->avfs_control) {
> +	if (hwmgr->hwmgr_func->avfs_control)
>  		ret =3D hwmgr->hwmgr_func->avfs_control(hwmgr, false);
> -		if (ret)
> -			goto err;
> -	}
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return 0;
> -err:
> -	mutex_unlock(&hwmgr->smu_lock);
> +
>  	return ret;
>  }
>=20
> @@ -718,7 +654,6 @@ static int pp_dpm_force_clock_level(void *handle,
>  		enum pp_clock_type type, uint32_t mask)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -733,17 +668,13 @@ static int pp_dpm_force_clock_level(void *handle,
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->force_clock_level(hwmgr, type, mask);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->force_clock_level(hwmgr, type,
> mask);
>  }
>=20
>  static int pp_dpm_print_clock_levels(void *handle,
>  		enum pp_clock_type type, char *buf)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -752,16 +683,12 @@ static int pp_dpm_print_clock_levels(void *handle,
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->print_clock_levels(hwmgr, type, buf);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->print_clock_levels(hwmgr, type, buf);
>  }
>=20
>  static int pp_dpm_get_sclk_od(void *handle)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -770,16 +697,12 @@ static int pp_dpm_get_sclk_od(void *handle)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_sclk_od(hwmgr);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->get_sclk_od(hwmgr);
>  }
>=20
>  static int pp_dpm_set_sclk_od(void *handle, uint32_t value)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -789,16 +712,12 @@ static int pp_dpm_set_sclk_od(void *handle,=20
> uint32_t value)
>  		return 0;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_sclk_od(hwmgr, value);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->set_sclk_od(hwmgr, value);
>  }
>=20
>  static int pp_dpm_get_mclk_od(void *handle)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -807,16 +726,12 @@ static int pp_dpm_get_mclk_od(void *handle)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_mclk_od(hwmgr);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->get_mclk_od(hwmgr);
>  }
>=20
>  static int pp_dpm_set_mclk_od(void *handle, uint32_t value)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -825,17 +740,13 @@ static int pp_dpm_set_mclk_od(void *handle,=20
> uint32_t value)
>  		pr_info_ratelimited("%s was not implemented.\n", __func__);
>  		return 0;
>  	}
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
>  }
>=20
>  static int pp_dpm_read_sensor(void *handle, int idx,
>  			      void *value, int *size)
>  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en || !value)
>  		return -EINVAL;
> @@ -854,10 +765,7 @@ static int pp_dpm_read_sensor(void *handle, int idx,
>  		*((uint32_t *)value) =3D hwmgr-
> >thermal_controller.fanInfo.ulMaxRPM;
>  		return 0;
>  	default:
> -		mutex_lock(&hwmgr->smu_lock);
> -		ret =3D hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value,
> size);
> -		mutex_unlock(&hwmgr->smu_lock);
> -		return ret;
> +		return hwmgr->hwmgr_func->read_sensor(hwmgr, idx,
> value, size);
>  	}
>  }
>=20
> @@ -877,36 +785,28 @@ pp_dpm_get_vce_clock_state(void *handle,=20
> unsigned idx)  static int pp_get_power_profile_mode(void *handle, char
> *buf)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret;
>=20
>  	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func-
> >get_power_profile_mode)
>  		return -EOPNOTSUPP;
>  	if (!buf)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->get_power_profile_mode(hwmgr,
> buf);
>  }
>=20
>  static int pp_set_power_profile_mode(void *handle, long *input,=20
> uint32_t
> size)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D -EOPNOTSUPP;
>=20
>  	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func-
> >set_power_profile_mode)
> -		return ret;
> +		return -EOPNOTSUPP;
>=20
>  	if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
>  		pr_debug("power profile setting is for manual dpm mode only.\n");
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_power_profile_mode(hwmgr,
> input, size);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return hwmgr->hwmgr_func->set_power_profile_mode(hwmgr,
> input, size);
>  }
>=20
>  static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type,=20
> long *input, uint32_t size) @@ -971,8 +871,6 @@ static int=20
> pp_dpm_switch_power_profile(void *handle,
>  	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	if (!en) {
>  		hwmgr->workload_mask &=3D ~(1 << hwmgr-
> >workload_prority[type]);
>  		index =3D fls(hwmgr->workload_mask);
> @@ -987,15 +885,12 @@ static int pp_dpm_switch_power_profile(void=20
> *handle,
>=20
>  	if (type =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
>  		hwmgr->hwmgr_func-
> >disable_power_features_for_compute_performance) {
> -			if (hwmgr->hwmgr_func-
> >disable_power_features_for_compute_performance(hwmgr, en)) {
> -				mutex_unlock(&hwmgr->smu_lock);
> +			if
> +(hwmgr->hwmgr_func-
> >disable_power_features_for_compute_performance(hwmg
> +r, en))
>  				return -EINVAL;
> -			}
>  	}
>=20
>  	if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>  		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr,
> &workload, 0);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1025,10 +920,8 @@ static int pp_set_power_limit(void *handle,=20
> uint32_t limit)
>  	if (limit > max_power_limit)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_power_limit(hwmgr, limit);
>  	hwmgr->power_limit =3D limit;
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
> @@ -1045,8 +938,6 @@ static int pp_get_power_limit(void *handle,=20
> uint32_t *limit,
>  	if (power_type !=3D PP_PWR_TYPE_SUSTAINED)
>  		return -EOPNOTSUPP;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	switch (pp_limit_level) {
>  		case PP_PWR_LIMIT_CURRENT:
>  			*limit =3D hwmgr->power_limit;
> @@ -1066,8 +957,6 @@ static int pp_get_power_limit(void *handle,=20
> uint32_t *limit,
>  			break;
>  	}
>=20
> -	mutex_unlock(&hwmgr->smu_lock);
> -
>  	return ret;
>  }
>=20
> @@ -1079,9 +968,7 @@ static int pp_display_configuration_change(void
> *handle,
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	phm_store_dal_configuration_data(hwmgr, display_config);
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
> @@ -1089,15 +976,11 @@ static int pp_get_display_power_level(void=20
> *handle,
>  		struct amd_pp_simple_clock_info *output)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en ||!output)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_get_dal_power_level(hwmgr, output);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return phm_get_dal_power_level(hwmgr, output);
>  }
>=20
>  static int pp_get_current_clocks(void *handle, @@ -1111,8 +994,6 @@=20
> static int pp_get_current_clocks(void *handle,
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	phm_get_dal_power_level(hwmgr, &simple_clocks);
>=20
>  	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> @@ -1125,7 +1006,6 @@ static int pp_get_current_clocks(void *handle,
>=20
>  	if (ret) {
>  		pr_debug("Error in phm_get_clock_info \n");
> -		mutex_unlock(&hwmgr->smu_lock);
>  		return -EINVAL;
>  	}
>=20
> @@ -1148,14 +1028,12 @@ static int pp_get_current_clocks(void *handle,
>  		clocks->max_engine_clock_in_sr =3D hw_clocks.max_eng_clk;
>  		clocks->min_engine_clock_in_sr =3D hw_clocks.min_eng_clk;
>  	}
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
>  static int pp_get_clock_by_type(void *handle, enum amd_pp_clock_type=20
> type, struct amd_pp_clocks *clocks)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -1163,10 +1041,7 @@ static int pp_get_clock_by_type(void *handle,=20
> enum amd_pp_clock_type type, struc
>  	if (clocks =3D=3D NULL)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_get_clock_by_type(hwmgr, type, clocks);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return phm_get_clock_by_type(hwmgr, type, clocks);
>  }
>=20
>  static int pp_get_clock_by_type_with_latency(void *handle, @@=20
> -1174,15
> +1049,11 @@ static int pp_get_clock_by_type_with_latency(void *handle,
>  		struct pp_clock_levels_with_latency *clocks)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en ||!clocks)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return phm_get_clock_by_type_with_latency(hwmgr, type, clocks);
>  }
>=20
>  static int pp_get_clock_by_type_with_voltage(void *handle, @@=20
> -1190,50
> +1061,34 @@ static int pp_get_clock_by_type_with_voltage(void *handle,
>  		struct pp_clock_levels_with_voltage *clocks)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en ||!clocks)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
> -	ret =3D phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
> -
> -	mutex_unlock(&hwmgr->smu_lock);
> -	return ret;
> +	return phm_get_clock_by_type_with_voltage(hwmgr, type, clocks);
>  }
>=20
>  static int pp_set_watermarks_for_clocks_ranges(void *handle,
>  		void *clock_ranges)
>  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en || !clock_ranges)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_set_watermarks_for_clocks_ranges(hwmgr,
> -			clock_ranges);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return phm_set_watermarks_for_clocks_ranges(hwmgr,
> +						    clock_ranges);
>  }
>=20
>  static int pp_display_clock_voltage_request(void *handle,
>  		struct pp_display_clock_request *clock)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en ||!clock)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_display_clock_voltage_request(hwmgr, clock);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return phm_display_clock_voltage_request(hwmgr, clock);
>  }
>=20
>  static int pp_get_display_mode_validation_clocks(void *handle, @@ -
> 1247,12 +1102,9 @@ static int=20
> pp_get_display_mode_validation_clocks(void
> *handle,
>=20
>  	clocks->level =3D PP_DAL_POWERLEVEL_7;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -
>  	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> PHM_PlatformCaps_DynamicPatchPowerState))
>  		ret =3D phm_get_max_high_clocks(hwmgr, clocks);
>=20
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return ret;
>  }
>=20
> @@ -1364,9 +1216,7 @@ static int pp_notify_smu_enable_pwe(void
> *handle)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->smus_notify_pwe(hwmgr);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1382,9 +1232,7 @@ static int pp_enable_mgpu_fan_boost(void
> *handle)
>  	     hwmgr->hwmgr_func->enable_mgpu_fan_boost =3D=3D NULL)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->enable_mgpu_fan_boost(hwmgr);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1401,9 +1249,7 @@ static int pp_set_min_deep_sleep_dcefclk(void
> *handle, uint32_t clock)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1420,9 +1266,7 @@ static int pp_set_hard_min_dcefclk_by_freq(void
> *handle, uint32_t clock)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr,
> clock);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1439,9 +1283,7 @@ static int pp_set_hard_min_fclk_by_freq(void=20
> *handle, uint32_t clock)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1449,16 +1291,11 @@ static int pp_set_hard_min_fclk_by_freq(void=20
> *handle, uint32_t clock)  static int pp_set_active_display_count(void=20
> *handle, uint32_t count)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D phm_set_active_display_count(hwmgr, count);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return phm_set_active_display_count(hwmgr, count);
>  }
>=20
>  static int pp_get_asic_baco_capability(void *handle, bool *cap) @@=20
> -1473,9
> +1310,7 @@ static int pp_get_asic_baco_capability(void *handle, bool=20
> +*cap)
>  		!hwmgr->hwmgr_func->get_asic_baco_capability)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1490,9 +1325,7 @@ static int pp_get_asic_baco_state(void *handle,=20
> int
> *state)
>  	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->get_asic_baco_state(hwmgr, (enum BACO_STATE=20
> *)state);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1508,9 +1341,7 @@ static int pp_set_asic_baco_state(void *handle,=20
> int
> state)
>  		!hwmgr->hwmgr_func->set_asic_baco_state)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum=20
> BACO_STATE)state);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1518,7 +1349,6 @@ static int pp_set_asic_baco_state(void *handle,=20
> int
> state)  static int pp_get_ppfeature_status(void *handle, char *buf)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en || !buf)
>  		return -EINVAL;
> @@ -1528,17 +1358,12 @@ static int pp_get_ppfeature_status(void=20
> *handle, char *buf)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->get_ppfeature_status(hwmgr, buf);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return hwmgr->hwmgr_func->get_ppfeature_status(hwmgr, buf);
>  }
>=20
>  static int pp_set_ppfeature_status(void *handle, uint64_t=20
> ppfeature_masks) {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -1548,17 +1373,12 @@ static int pp_set_ppfeature_status(void=20
> *handle, uint64_t ppfeature_masks)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->set_ppfeature_status(hwmgr,
> ppfeature_masks);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return hwmgr->hwmgr_func->set_ppfeature_status(hwmgr,
> +ppfeature_masks);
>  }
>=20
>  static int pp_asic_reset_mode_2(void *handle)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -1568,17 +1388,12 @@ static int pp_asic_reset_mode_2(void *handle)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->asic_reset(hwmgr,
> SMU_ASIC_RESET_MODE_2);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return hwmgr->hwmgr_func->asic_reset(hwmgr,
> SMU_ASIC_RESET_MODE_2);
>  }
>=20
>  static int pp_smu_i2c_bus_access(void *handle, bool acquire)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	int ret =3D 0;
>=20
>  	if (!hwmgr || !hwmgr->pm_en)
>  		return -EINVAL;
> @@ -1588,11 +1403,7 @@ static int pp_smu_i2c_bus_access(void *handle,=20
> bool acquire)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	ret =3D hwmgr->hwmgr_func->smu_i2c_bus_access(hwmgr, acquire);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return ret;
> +	return hwmgr->hwmgr_func->smu_i2c_bus_access(hwmgr, acquire);
>  }
>=20
>  static int pp_set_df_cstate(void *handle, enum pp_df_cstate state) @@=20
> -
> 1605,9 +1416,7 @@ static int pp_set_df_cstate(void *handle, enum=20
> pp_df_cstate state)
>  	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_df_cstate)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_df_cstate(hwmgr, state);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1622,9 +1431,7 @@ static int pp_set_xgmi_pstate(void *handle,=20
> uint32_t pstate)
>  	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->set_xgmi_pstate)
>  		return 0;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->set_xgmi_pstate(hwmgr, pstate);
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> @@ -1632,7 +1439,6 @@ static int pp_set_xgmi_pstate(void *handle,=20
> uint32_t pstate)  static ssize_t pp_get_gpu_metrics(void *handle, void
> **table)  {
>  	struct pp_hwmgr *hwmgr =3D handle;
> -	ssize_t size;
>=20
>  	if (!hwmgr)
>  		return -EINVAL;
> @@ -1640,11 +1446,7 @@ static ssize_t pp_get_gpu_metrics(void *handle,=20
> void **table)
>  	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_gpu_metrics)
>  		return -EOPNOTSUPP;
>=20
> -	mutex_lock(&hwmgr->smu_lock);
> -	size =3D hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
> -	mutex_unlock(&hwmgr->smu_lock);
> -
> -	return size;
> +	return hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
>  }
>=20
>  static int pp_gfx_state_change_set(void *handle, uint32_t state) @@ -
> 1659,9 +1461,7 @@ static int pp_gfx_state_change_set(void *handle,=20
> uint32_t state)
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&hwmgr->smu_lock);
>  	hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
> -	mutex_unlock(&hwmgr->smu_lock);
>  	return 0;
>  }
>=20
> @@ -1675,12 +1475,10 @@ static int pp_get_prv_buffer_details(void=20
> *handle, void **addr, size_t *size)
>=20
>  	*addr =3D NULL;
>  	*size =3D 0;
> -	mutex_lock(&hwmgr->smu_lock);
>  	if (adev->pm.smu_prv_buffer) {
>  		amdgpu_bo_kmap(adev->pm.smu_prv_buffer, addr);
>  		*size =3D adev->pm.smu_prv_buffer_size;
>  	}
> -	mutex_unlock(&hwmgr->smu_lock);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 03226baea65e..4f7f2f455301 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -748,7 +748,6 @@ struct pp_hwmgr {
>  	bool not_vf;
>  	bool pm_en;
>  	bool pp_one_vf;
> -	struct mutex smu_lock;
>  	struct mutex msg_lock;
>=20
>  	uint32_t pp_table_version;
> --
> 2.29.0
