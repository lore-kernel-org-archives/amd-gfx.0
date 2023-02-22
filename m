Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF95EC636D7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 02:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3DB10E0D2;
	Wed, 22 Feb 2023 02:53:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962B810E0D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 02:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpwJm4x3s82SbMVKIYh1/kok0ujswHaK/5uDtoKe9fiJo8Sywhazj1Emp4BqI0OAU4RrvVN7xfYbvbkOUUJzAiSN5rJOlK3+ocU+ZRJs/Rc5G9CoUr01FumVQ5z9CciriwM9hJ70B1yk7Dg72oHL1kz+QeLjM8nHUuNpYjGzqq3+a4tWPfbFzYTPDQ4e8MyacDCylsCH1H+3PwWXz4Gl2TneJdPOaQl63H7RiD/M8C+CfAy0JwMUJew9nCnmQLZNmaC6G45eQKysJvn3sMN8kE52gqJ7wWN60yKvE6VDWMAYx50BtmZwvWY3bChW2es89yQP3UVUJGgBfNhXQejxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQbHG2q6k60pG7idWPbHt0w2vMN58lx0YBg2yeyW8u0=;
 b=ofacxc/tiHCMCiNCXSOqcv8OcEfYY4D2DX66VxHXMGtYOpQ9iznah82AsF1JH1lnSXXzJxqE8NuX4tVgm9YVE23tksLmNp/fJtFTZXvaQLIQvWgVjnm43mImIhz1yJFALiPHuGtiARyl2HJylBY4qgip8ptU2XaEgg9p/YlU3lXM7NuxdRrVP/KloKtt2SKOTjSNalSyLT8yu00pE3d0BRjtJdVYU00jN0w75OEYuxDt84l7jF/MxKePC7Lgn/dWwgfMt4r8oB/GJqHh4GsHte4lF2IKpuWEW/UrvwBwq0eJaZFM1qs4RXwI8dWge7U5bLBZ93vntaoiIN9MD0lkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQbHG2q6k60pG7idWPbHt0w2vMN58lx0YBg2yeyW8u0=;
 b=c1nqSgUlhvY8Qer4M7vfokSVMUT7ezIzLoJ7jwzUYQAjrt+MCdxmJ+1cCh+tcNLVLYjY5dBAmrsgRZrAbraibfHJtI60L9uQd3VQd2Dw7pDgWCz3BeX0JB7sd7bRsSx1JciVpNeCHP4cM70s1sAKy/HhDLpFr/RCGvnyQwS1bjw=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 02:53:29 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 02:53:29 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Topic: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Index: AQHZRNnfIuampgK+HUGtOlOkU4++r67aR+xQ
Date: Wed, 22 Feb 2023 02:53:29 +0000
Message-ID: <DM5PR12MB1770DDC217BC1558684F97A6B0AA9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230220031717.18738-1-tao.zhou1@amd.com>
 <20230220031717.18738-2-tao.zhou1@amd.com>
In-Reply-To: <20230220031717.18738-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|MN2PR12MB4567:EE_
x-ms-office365-filtering-correlation-id: f04b4ce9-ac10-428b-f10f-08db147ffa22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WBz6z9tSQQIjpS2Vw0NW6wQ2m+4ict09qsOmWkzGdhfW/nwVTMKPb8ywd7YFaMft4ARX+TWwsIIw3fJJQ8g9hZ5KYXcFm9Rt7W0UTRPWMwY4iPCS6LIBy2/N6BH0EAcQRjN/7PiZT5/HSVnZssYw8HR1dUKuObtghDWym/3720r0pc0unlmoiwGo12X1Oeys/dSCwfA3JtltGVWr6EAShnyGSmCEJJciflXWrOmK/yLJJND4N5Z005c67REdFpd43EUyvMbGmUdBjjRdawSzWetWGvjRd3NmKz0bbt6bl+hb19EX22joQloOAkkS0nWTn7Qcn4BXb1nkG6EhkJ5lnXGHSNYMTf/M+nu/Bjlc5p4T5LptsyRR5YMt14t+GGedhW/Rr2X/3zjo8mlHrcW1AX5bJA5gCK9A316E6cOFtgsQNPu5HRsVBoYvMavpUBxfy1LCu13z8dpQlS0rftNEbOFEuJqdI1G5CiTTQFZ9tGyaxqS1or0kuDoNDFlPaOExX7MPLUgqHaL5CsFjQxGfwoNMxgGP1ui5WnPqUEg/74hMBxasO0PdG1E/KO/905rzk5l4JFaBe743gZF8yPoNsvxO2LniLevgrAaJW8VuXZXvtot1G/XEwSntbxk6yw3KtqEgua395MFWh90gxGfOp3Rx2L5hKL4GIo13IU7mRKM7GCRFviQykudY1ke1W/BuYi7KTDM+ejodQld+oxg9+bez1Ws7fhi/PR9K/tuONo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199018)(41300700001)(52536014)(76116006)(7696005)(53546011)(9686003)(66476007)(55016003)(66946007)(8676002)(66446008)(66556008)(8936002)(64756008)(6506007)(186003)(26005)(33656002)(86362001)(5660300002)(83380400001)(122000001)(478600001)(6636002)(316002)(110136005)(71200400001)(38100700002)(2906002)(38070700005)(921005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fbjcehdWZ76xDmSc3Bh1bgiitUGRrA3E5CJwRcIwb8N+Gc2owYOXgCTO+5Xz?=
 =?us-ascii?Q?7YZMzg5YnChpK6D4REv6hHqEYLzIL/KFbc79hxrOrOBbdxeDq4ojmKPo+SJW?=
 =?us-ascii?Q?fYj1P5JmF+baUAFxeYlQHWtiFRa0iWdxY6qZDVkOLOxwKf8l3YeFq8tecCsh?=
 =?us-ascii?Q?bu/9O2/cp40ZU0/yWiQU2RPkdc8icoAo7dq8HFp93QWLjBWUorKnfuZxicaH?=
 =?us-ascii?Q?3yZDH8/UAYB23mSlj4PSPuvNZitMbzR7r4bZZoyX55b3TVANlwCmoGtiQe76?=
 =?us-ascii?Q?Fd20Jjsaj2egZWlCbzki8o4ht1YjYzqxJIcpINu8OVoRDHn1yWeQolbky87a?=
 =?us-ascii?Q?yu9gxeHprhTHN+8TTp5hNOAy7AkQKvv1FKXR864Un3aViqFbKh0nowvAXvyh?=
 =?us-ascii?Q?vFoMqTJEeOD3goJ5j5CQPJAHb0O0pfo+D6WJbi2to8mwDsyZDpm1K6pOUait?=
 =?us-ascii?Q?GZTdIXaWk3at6hQtH0f0njykI99ZIxhiU0XtKLq+EbOMXVm1tQB7Iot5VkvZ?=
 =?us-ascii?Q?HQqMe5rkJY4vvxvKl1PI7YF7b82zvPwpjHTzG33rLGrSyOgMJKV5u8zOixHS?=
 =?us-ascii?Q?sY4gqu3AH/rtb2o9DLMWvIzFPRqmFs43G+OkzSh9r3TvMuTuZ1vrHqvmZ+HL?=
 =?us-ascii?Q?yNpzB6Uy7zm9CkjcmqI9ogL2ufpFVL/z/E4oKX6J4BBbF7nUOl/6WLlubBnX?=
 =?us-ascii?Q?oJEIgTRO/MYxb7r+ls9mjywFy4x/K8/Zf6QGuyUEOahVXWijZ41SqzUmS1D/?=
 =?us-ascii?Q?sdIwpZpMir2TJYdeU7ULn0iSLlMXQ0zBSif1I/wcSUkDFnDQwosara3twLKT?=
 =?us-ascii?Q?M+gm63BcWIMtULbXU6frM90HsFpfASIcHTBSoyBPL/AugcBdMlmAD/0oTzLl?=
 =?us-ascii?Q?FK2fx27J79mPnRxejARIZNCg2bL0DyOc0l+YWNZOtZkGmW7hofdyImZFiRVZ?=
 =?us-ascii?Q?Cwxo5nXuwCwAfaEI4DOCGS8Fqf08v2vuZB3WQg7PKDOIKgyElcr2blvVsGCm?=
 =?us-ascii?Q?ELiLza0ol3mLPaK7KPNpkzelsAOMD3rOnj9Cc/KACSDZjBS/8DRsVIjlMfdR?=
 =?us-ascii?Q?53wkBsxfVifshQdI09EOOpoMHsja/XugzXdBMVRLV6jPPCbN5KFV6wPfhdoe?=
 =?us-ascii?Q?W4nnYKpy14hBSsV6PvxJVijM+abVRBiYuRHNPHG2VahsGQ3V8R9IGUrVOpEA?=
 =?us-ascii?Q?haFMW1YvittxmtBX9VGmqL6Xcx0H1WhlBWvTCXzxlHRuNIWlF0GgMHnxQj5j?=
 =?us-ascii?Q?TY6jMn/17zMvJx5m4WZCtTLQtq7K/r29Y1AAjbTW0ocqfOJfVT6NMdsArE6b?=
 =?us-ascii?Q?4bX2vibrv9OExS3oHLumf5DLvYQHX3jpnHDWtbYVBSGZjhYPNJI7Q5vMlzCu?=
 =?us-ascii?Q?tOhplo8b8MRlISZJIQNRachAVDRZ0Pt8W4yb9Fjzh1crcrxS+OfFyJNuE31/?=
 =?us-ascii?Q?peys8V68H/zH4Ws3efi9DTVibtFn+Zrt5N35cTsHRpXrP4U9hnRtWNGgafJO?=
 =?us-ascii?Q?8lH2V5FMIg1SEjJ3RDGYKKXN+DfW4UqIkLm0+1uI38f6ue20RqhiTfZJgPPI?=
 =?us-ascii?Q?xRpi+YNkytQaTjf/tk4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04b4ce9-ac10-428b-f10f-08db147ffa22
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 02:53:29.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fseI5rcYSvkxLtdsfhwbpqp8fGpf+/YWDK8GAPFogvZcTzHsDt4bAaV3J6D5Pubw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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

Ping...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, February 20, 2023 11:17 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
> count
>=20
> If a UMC bad page is reserved but not freed by an application, the applic=
ation
> may trigger uncorrectable error repeatly by accessing the page.
>=20
> v2: add specific function to do the check.
> v3: remove duplicate pages, calculate new added bad page number.
> v4: reuse save_bad_pages to calculate new added bad page number.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 +++++++++++++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  5 +++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6e543558386d..5c02c6c9f773 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -176,7 +176,7 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
>  	if (amdgpu_bad_page_threshold !=3D 0) {
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  					 err_data.err_addr_cnt);
> -		amdgpu_ras_save_bad_pages(adev);
> +		amdgpu_ras_save_bad_pages(adev, NULL);
>  	}
>=20
>  	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES
> AND WILL CORRUPT RAS EEPROM\n"); @@ -2084,22 +2084,32 @@ int
> amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>  /*
>   * write error record array to eeprom, the function should be
>   * protected by recovery_lock
> + * new_cnt: new added UE count, excluding reserved bad pages, can be
> + NULL
>   */
> -int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
> +int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
> +		unsigned long *new_cnt)
>  {
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	struct ras_err_handler_data *data;
>  	struct amdgpu_ras_eeprom_control *control;
>  	int save_count;
>=20
> -	if (!con || !con->eh_data)
> +	if (!con || !con->eh_data) {
> +		if (new_cnt)
> +			*new_cnt =3D 0;
> +
>  		return 0;
> +	}
>=20
>  	mutex_lock(&con->recovery_lock);
>  	control =3D &con->eeprom_control;
>  	data =3D con->eh_data;
>  	save_count =3D data->count - control->ras_num_recs;
>  	mutex_unlock(&con->recovery_lock);
> +
> +	if (new_cnt)
> +		*new_cnt =3D save_count / adev->umc.retire_unit;
> +
>  	/* only new entries are saved */
>  	if (save_count > 0) {
>  		if (amdgpu_ras_eeprom_append(control,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index f2ad999993f6..ef38f4c93df0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -547,7 +547,8 @@ int amdgpu_ras_query_error_count(struct
> amdgpu_device *adev,  int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
>  		struct eeprom_table_record *bps, int pages);
>=20
> -int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
> +int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
> +		unsigned long *new_cnt);
>=20
>  static inline enum ta_ras_block
>  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 1c7fcb4f2380..7c6fc3214339 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -68,7 +68,7 @@ int amdgpu_umc_page_retirement_mca(struct
> amdgpu_device *adev,
>  	if (amdgpu_bad_page_threshold !=3D 0) {
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  						err_data.err_addr_cnt);
> -		amdgpu_ras_save_bad_pages(adev);
> +		amdgpu_ras_save_bad_pages(adev, NULL);
>  	}
>=20
>  out:
> @@ -147,7 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>  			err_data->err_addr_cnt) {
>  			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>  						err_data->err_addr_cnt);
> -			amdgpu_ras_save_bad_pages(adev);
> +
> +			amdgpu_ras_save_bad_pages(adev, &(err_data-
> >ue_count));
>=20
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev, con-
> >eeprom_control.ras_num_recs);
>=20
> --
> 2.35.1

