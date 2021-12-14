Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1709010E87F;
	Tue, 14 Dec 2021 03:21:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A7E10E87F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO6f/LibKysSYL1eQ+BnRh8zWpenu8PH54fua2M9ZvenAI7mOu/KOUUviP9KaGA1d6aHPc0cfdpVUbc6t/GTfIesy/SSCU5pq6nzXY9fXWSftlR1hukxIkeUVtI+yU6ISpNwBFNqkICURfQ4jgSCKXx8q998Sqsuqh3UsTsBhLVdWfhTsNnjhF4CEgCpnEXLStobgGIrT+kMs+RYvyB1957bWkfV4qk0C5jQYzGdueKxrzeH2AxqNfp8XCPjxhUCQt8LHvAn3rnyOHs8dBK1J9K3+2YMozDWFl0PnY2O+RJSIMN0ec8mhF7+Db+VOe/CyVdWEkRgx1CuXy0kAEfBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IYZbStx68XjJyBJrH9zu6URtQSgVbzc5nUi+oFkJbw=;
 b=JPzUlQhFFay2M0WrHMl6HSZ3XWmDws8JP1tClK+HSqbZ4MlJ0sgPOsBls1vpIYMW9Pv5GLWEtRqrRvLRH5VeELOc3XQdVi+ZjUL3pHNwPfUlbq5iY1n7OOFdN8rx+haKQdaw0NTWokSL9ZTBpIGm+oVet1fIKammtmODW61sNhT1O247hnaoZgavb1zcv4ZU8jYphixn4Zb33HiWxOz5O2mFtlK3FOQ79uovoy+RxAg5ila4PKGiAmKHo+si11szc4koOWWnQwfnDicpx0lVZI6Z8NPw0ZsryKS44BPdsMBjL51t5s2mRiTrSS2piDmiASJbITkTXBTpC+OscL1cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IYZbStx68XjJyBJrH9zu6URtQSgVbzc5nUi+oFkJbw=;
 b=fAVBzI9Wx3ZMXRh5b/Ur0DQmhrcSIqv0kDGb8wd8ZUpPXgy4ZAqCJR4S9GONebMbSjWuRVC8Hm+SXxRAFfMOsXAu9QEmCugoKpICNh6zTXZcXftMUYtFVgmQc3ClNELNcIO2zaHqDyyvG4+/QCzcOp9xdfbpnj47QDrKN9ra8Dk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 14 Dec 2021 03:21:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 03:21:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: skip setting gfx cgpg in the s0ix
 suspend-resume
Thread-Topic: [PATCH v2] drm/amd/pm: skip setting gfx cgpg in the s0ix
 suspend-resume
Thread-Index: AQHX8Jk/ZJV//u9QCkqfkEkMyd4jG6wxUiuw
Date: Tue, 14 Dec 2021 03:21:43 +0000
Message-ID: <DM6PR12MB26197660B2BF780150640B38E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <1639451805-19735-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1639451805-19735-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T03:21:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537bce20-9cec-4522-a61a-afd2bde3e527;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fae8851-bac0-43a0-b547-08d9beb0da18
x-ms-traffictypediagnostic: DM5PR12MB2502:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2502DDF691879FAA7F4FC9D6E4759@DM5PR12MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMEld3ovsAYJNp9o1Sqf1qZQS2F1jCKuc/nl4Qc6cFgQRRec28hQhqYwtblLljfUnMJUBPjoyrP/fvtcMsMGZV+c2eR4W9m1VDCbXOFley7ygS9JTg3JXL0YuABLbfYMcbHb2b2qjuAQCCbmivqHZJc1F2mqjLBQMMLyUdzw0PmGzbS9MmHrBFqwrN0TA+gOWgTTLJ7djjsDmUpKjQcXWi6//AIRa+N+bE93o49GadkYyLCxAcjU+1otPKZOb5xa/5E/UGbVysw5QnZXBpaDa21gVQ5+63N0+Z5WXoTTEoNqeEUR1wRqRXkgFCkggWKSSBmLgx5g4lPrIJMCB29JXPZCUMFcfrJnVv+XoAqJCSGiij8Urf/83pPFeiKgImF+gOnbIgwnlZFfwvWhzqzH+z5WgfJOpuMVLTKQgFjNYkoogELoZ+GltIDOeKl+hhs6JYhce9ltIzE7Uho9RB+af20Q17l/uFsYsnJgcNdYTKIoYcdlK9/WVrlhlP5S2dgMl8Pbc4McfsAT1QYXk4vV4cdpmRX1IYxp1txfNTJJpcRVD3yIRQppc5S4TJuFjIhLzOkZH5MLYbzJGOYNm36ZOWTfavZ/MAEw1HHCnAWY19DqIteZbqu+UDl4i1Nb9+XcmlKu1nhk4PS5p7mUGpQIg2n1xc1MDsyrBgJc0Jf0dY1RF51B80+Y0CksfNXs0uk/wK4+Ncws0f7kvbBxHUfgz+9NFcuQGGYewYd6dq4WU1M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(15650500001)(38100700002)(26005)(7696005)(86362001)(83380400001)(64756008)(186003)(66556008)(2906002)(53546011)(76116006)(9686003)(4326008)(38070700005)(33656002)(54906003)(8676002)(110136005)(508600001)(8936002)(71200400001)(6506007)(66476007)(5660300002)(122000001)(66446008)(316002)(66946007)(52536014)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y9FsBrqBI90DQhv/IWQNAPE3OW6AjeZ5N2kcMgsv01N3TaziNd5ZD6WUqLcK?=
 =?us-ascii?Q?F91ISJdSVduC4QX/soaCvv01ka74f4RVDTO7/dQ8Ysugp2v4fza+eg9DtXqI?=
 =?us-ascii?Q?wUjswq3Lo6ygyVQfhjTkPSNu3a81RKPVZlJNHnwFiVyxfVIwyu0BT+7BxrH1?=
 =?us-ascii?Q?2hW7avyL5S53EaIltYYwlVha7m9c4f9Xf6qRF0L5OQCBB+V4N7QQkpT6EEQn?=
 =?us-ascii?Q?PuFBjAby/QC16WdhmcK2k/k6F7SULyFYdVodqlUe8Q6/m5d5UFvwOHnz4tQW?=
 =?us-ascii?Q?JcOesDBPvp9KYu5KSfXffJGVZn00SvMl4XQMsC8XvSwmSe13jOzG78CtfhGs?=
 =?us-ascii?Q?AYogn372AwCzSNZDGNj5AIUQpkZ7dwdHfhBnMpPxK6oHomaTrU5hHHkgsWEr?=
 =?us-ascii?Q?NJV0gTyeQyAAhrA5y/gucAXcVtcUOz5dQ5CIWAiBT9mEatPK7nY7nLyCtJJf?=
 =?us-ascii?Q?XQhePHHEEr10cfGB3B0jvlbDfp6gjCPmP9EtmHhFy0EsilCV1C8NfP1ppzDx?=
 =?us-ascii?Q?gUXUHxY2VmpNOhBUaOvx11UJCS5d7nMBL7LG4Ob//6yMJuvjRGmLPYUToj+s?=
 =?us-ascii?Q?qIYN33OHmJKwC19MnxuJwXvo/5I6+gcS2W1UDup/LFLpVyQYmXJz9eVLUudE?=
 =?us-ascii?Q?t0CG2Nga9qHtv6w2zvW8d0+5ikU7RtP718U/JhXq6as6UrqI7ZGjHlHmG2o9?=
 =?us-ascii?Q?SU+UlWuoLRTjQ7L2mLvXZrzb8MF5gkV67VYbZS6Va1ZOhKee0iMVQnj9hHS/?=
 =?us-ascii?Q?cnCIVY2BtXg7/K9AIx5aK+CsmWptbe89T2wN/gxwbI1AhWqkrlcBM01v7neR?=
 =?us-ascii?Q?4iMi+GZ/BYSHseX58vcgCfS2yZoPrrxJiyfkktr87vuRvSXf5XKUrAQ/YN7m?=
 =?us-ascii?Q?PpdKLV6JWnYCCcKg0+7p23wZwIK6qHw6NHOD9d3atbUBj82bs+S+3CDvPJPZ?=
 =?us-ascii?Q?4+tQwTgD4l39NVhzvTWPs9znbbfbMDmdo8/XuoY6H3XsHR8bzHSYW1Yqf1/B?=
 =?us-ascii?Q?WWY3zC7DTT4XpOyKgR/ARgv5jzWbr/MyHTCrxISSIrYfKe4ervLJjDRi4PVo?=
 =?us-ascii?Q?me4chpCBbKkCKq/FF7sl0Rh2k2X2rolaV9YAClSF5cQ3s3qirqKygdod7jJA?=
 =?us-ascii?Q?GPtUzDeWDFJ4fBOdX9Elv2WEe0nA9yEiFmd5ogQ2TtUB2mvRcuAWxzqczBoF?=
 =?us-ascii?Q?9pan4QOBTCiNugDhKPPa/2V47JNyaCGosLDnTF4DKSyMu2ltWMEfBuzGIxLK?=
 =?us-ascii?Q?ydHElB7NuTKaVjSQSuwJ/yKrAjvlfqDsf7ARYLiOJBL4+LV/r8Y0A3eWbseV?=
 =?us-ascii?Q?85V7qnT1ovipKUldoa8bPee1Mur2r/RR2UoDeuCpVjhjD1KYIFV2fvgly7AR?=
 =?us-ascii?Q?9ibt+42sd1Rf0YRk8JLZUGNGNjhVhQ+JS/dn/DwNeEZnj+qj/dTL/GxmjoXz?=
 =?us-ascii?Q?tSQ2dnOZBECrxHj5McH7G7DXxaXXc1dMzPZehilJlTsa1C1cFObm+odgA/o6?=
 =?us-ascii?Q?BNHKozqcvOiS1NJUFy5wNLse8E1CIiET0CI/vQVR5zp870i3zTmJ4WiYPhSZ?=
 =?us-ascii?Q?rmP/JidcwWeA8liPzd8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae8851-bac0-43a0-b547-08d9beb0da18
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:21:43.0240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvEAJbzB80mfW0qPA9SUeOkD811YWxxDZP5zb+iUeAlenrGsNc0tzwdRHyvEf4OA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, December 14, 2021 11:17 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2] drm/amd/pm: skip setting gfx cgpg in the s0ix suspend=
-
> resume
>=20
> In the s0ix entry need retain gfx in the gfxoff state,so here need't
> set gfx cgpg in the S0ix suspend-resume process. Moreover move the S0ix
> check into SMU12 can simplify the code condition check.
>=20
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> v1->v2:
> - Move s0ix check into SMU12.
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 7 ++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 ++-
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2d718c30c8eb..af98fa140d83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1569,9 +1569,7 @@ static int smu_suspend(void *handle)
>=20
>  	smu->watermarks_bitmap &=3D ~(WATERMARKS_LOADED);
>=20
> -	/* skip CGPG when in S0ix */
> -	if (smu->is_apu && !adev->in_s0ix)
> -		smu_set_gfx_cgpg(&adev->smu, false);
> +	smu_set_gfx_cgpg(&adev->smu, false);
>=20
>  	return 0;
>  }
> @@ -1602,8 +1600,7 @@ static int smu_resume(void *handle)
>  		return ret;
>  	}
>=20
> -	if (smu->is_apu)
> -		smu_set_gfx_cgpg(&adev->smu, true);
> +	smu_set_gfx_cgpg(&adev->smu, true);
>=20
>  	smu->disable_uclk_switch =3D 0;
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index d60b8c5e8715..1ae59f2321b2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -120,7 +120,8 @@ int smu_v12_0_powergate_sdma(struct smu_context
> *smu, bool gate)
>=20
>  int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
>  {
> -	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
> +	/* Until now the SMU12 only implemented for Renoir series so here
> neen't do APU check. */
> +	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) || smu-
> >adev->in_s0ix)
>  		return 0;
>=20
>  	return smu_cmn_send_smc_msg_with_param(smu,
> --
> 2.17.1
