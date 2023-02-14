Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F3C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 09:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2062E10E824;
	Tue, 14 Feb 2023 09:14:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57CA10E824
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 09:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvQJ3ByzCepxW1X3SumoIn6cwtjbsLEY5g/wm5Rddin5NxMOAavMwfj3WbEA5bzbK4PqOJFtqbDpXlbyzkjGZCAKMxI+IPDvWwaScvSZd922akygyaKLtr3MQitUkXNAaDHlu0Mzgy8AMUJ53UvXJNN2hqGUeKuJYYcubqv1b/5MwTill2lFdo9c9cwt9HJ3/vR0QyiEWqDowcHr/yY7PW7lriT3fhPOFdgY0x7gAIQ5KRT2NDuq9DkcSpofr/tVQ/uLUiSXEQo0SqF3/vRu2nsIRc3k3+/s/y9rXMOR+7AS5MWehEJ/5e5DlzRKIlNnyo4E5t3tzgVXN+yndPfHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+ZrjtqsaZZlJiBtRlG1pdUzMEoaX3w2MMGGAMCQYoE=;
 b=QhyAtBIY7KmjCDlIsU/7KEqNd6o+4m9XoGY4hgAyb8QVQKNHhvt8rBoIBr9/WRLwyxGS6O+Vv06gYVylIr0aXE7TOofDeIERkVmmw9qxriJ+fc0Lq/G7yQCidaZaY+yaqcmUPHx0axhrP9ApIb2XIqeGAwocNaRo2DFvFC134ya+uFtJ/lhzRfszTPpIegOwfJ7tFF1SGVu/QrBC0ayqT4Oh0ubTiU1eBdwf424qyt00LCcrHc6Tq2hWjoe93fhIsuakjhgmqcjDsayB8hEfBiKebNIeG4PAisBVGFUVN1GqqFNyawRFWjYC4YPte872n9Fq02SBk8fjx9RVq23llg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+ZrjtqsaZZlJiBtRlG1pdUzMEoaX3w2MMGGAMCQYoE=;
 b=vXoMbtc5zSlmzYimZgX0vFkxQjaTKAODQrk1b7WQgEBd5svT0h+T1ERHRSdSPNgtRWgexs4kQ/HX09+3qJTnm63vrSG/V7SXsQd57cdgb/GSWncuoy1n/wC0D+X6qgRI0+OHooR4Qn1Iyoix4chOgTvjjZ6qCt6EQ95hUFYaq/4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 09:14:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 09:14:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Kun" <Kun.Liu2@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Liang, Richard qi" <Richardqi.Liang@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal
 throttling
Thread-Topic: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal
 throttling
Thread-Index: AQHZQErCGOCpEP7AxUqtX1sTSzNPh67OKBaw
Date: Tue, 14 Feb 2023 09:14:41 +0000
Message-ID: <DM6PR12MB2619FB1E02008F742B37735EE4A29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230214080255.31493-1-Kun.Liu2@amd.com>
In-Reply-To: <20230214080255.31493-1-Kun.Liu2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T09:14:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2299ebdb-c1a1-4488-889e-c084622f5059;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SN7PR12MB7977:EE_
x-ms-office365-filtering-correlation-id: e1e767f5-4d62-4bfd-c5f6-08db0e6be832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dpd6NNQFhRXhjLHoZ7+Iag85QmwYUZtUyAK5Uss6oi4FfYt0Z8Rmn2XPeKDYBM//vqYwfMoUJvVGzEGNfUr+MkWDJiaSvYHYT24oXJhpqUcRvYNBckM0W1X0pr6jgYgZ8nXSmPX9qCYr2CANl7ubpc66yGp/qzSe/tRyxUzHaZVT6nfONkhzpSpdM/uQxAAD8EfjOFBHEodwOSt8KosNFlgEyTbgDUNXyY4uVdOITv889UFcHkDYmpng8LI8sFh5hvHBY13adHTjA48+qUuMhM1lgblBNQUvuxdrCv8FtO7xn1Dl9qvkfpzo1e6KudpurvfylYnmlYLSzZ9L32lTlpLAbVKarYXjxIPqgfXB1wW7y81cCL02fUC4uJNoaV+QgQy+ktZYaFfRVolRcts7G6hXB0Idbl79XTt5o4hf01Oq+9NnxLDZbg91peUZ3YMamLy954QBAiCLfh4a+JjTBMYr2isnrDa8RBZnZPq8oBCprh6dPij21KVAeKwUXPZMlFEcR3ypNkfDGRBSFT0AhY3aRKZA/6DL5Y2fayiiBa24USLu9yvVm1Bynxz01Z824pf2zC50WbzuO5c2ibpKkuLaZoN7AMmTcPGkYpyes6c4XepYOwdTHq5UTFCzGNikxcZYNMWoY04fHUUeLUWFd9mu/E9FJ1+8b0uDXlGTBK++BOFCoeUHmxw/SJPakdCT94cHNVJ519n2p+t9VVHn6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(33656002)(110136005)(41300700001)(54906003)(478600001)(122000001)(186003)(26005)(52536014)(8936002)(71200400001)(55016003)(7696005)(2906002)(38100700002)(53546011)(9686003)(6506007)(86362001)(5660300002)(83380400001)(66946007)(38070700005)(76116006)(66556008)(66446008)(66476007)(64756008)(8676002)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EIHHpFZBSO4/gJFs86Vh1lBuh+IxG6g/Iy7EdWn7Lciu7+oFT/GrLaXyOAN1?=
 =?us-ascii?Q?ZqDHKe7/p2dQBNVcOmu7v8KMRejqumzg5eHtRqoZg3mD1istxO5f+u9pYKwL?=
 =?us-ascii?Q?jycoO9rOfB4VJARcXkWxPeIepA1G9K0q+yuC9wFo1xeAV1eIXjKy/06Dy9bR?=
 =?us-ascii?Q?3BSbDy7jwXT4Jc9D/o0VxBY0Qt/w0c4XLRM/9fy+DyLnTNBYqJaHDwycBYPO?=
 =?us-ascii?Q?pIUFcA24ekL91MuGGeAu9wTEH5F3wNm3Fif1RW5TFhLsoDUr6oRrE1l0oPAp?=
 =?us-ascii?Q?2NzwLnlULm1ZICBi1mSRJ9EIN7s2kJkYVz5s+tZj3KrUceh8EOZ3FmUjjmlc?=
 =?us-ascii?Q?fATGKsR3w1esICcqwz2K7NbJ49VGRFEdplDNIBw4sirWqMMku+KNATiak1Zx?=
 =?us-ascii?Q?MVJXffcRPn/QyvRBAe5nfaQ4JsE+w1GykhadUfPifPlwiuJLG03X0qHCRwn5?=
 =?us-ascii?Q?qpdWHb9cKd3QKZqy0xhR6Jdld87xf9aVTx0+amnW85R5F4U+1OD7U+3Soani?=
 =?us-ascii?Q?YgEYzzefu4VibMuR3F/2yxymgIpqkH3ILPH1ZKdr2dcEEdiiH1DJc5Z1uJv3?=
 =?us-ascii?Q?ypx0i7oQLfUYyIp4BfvL+r6yTmLsrKicxu2kUUqNYtAHvhRLHSGbapM1InBq?=
 =?us-ascii?Q?oCs8tEr3YxIfIBODswkIxnOPCNJB7ouDkyrUX9gbMWxSpun3nCA8bMglnOpD?=
 =?us-ascii?Q?TSrAoUoqnSyaNMbeYmp1azYHPlbco40ZhKdbdKvCmYQf8FfqtQkc4IlQUowc?=
 =?us-ascii?Q?nSSluZAzRPiwumaMrnx4iTA+Do4xWL/ogOXH+HSUYzXdmG09ONLedH0LbiNM?=
 =?us-ascii?Q?Dk4CfzwybLbNiDMGiPLsRMZdKiAfoochc6oEGLtMbgNvdAVnScOI550fOtRN?=
 =?us-ascii?Q?KOTCLm4+FhqnLFuQLeLAh5mqxhFBscuzmXCmihXrZcatWfdDa4nsxBkD3Oud?=
 =?us-ascii?Q?940ZDOgBxaqztBNJVMXHUF6lGP1f17Lf6ST0f7x7xXhyx0FFmJSnAUWBmalo?=
 =?us-ascii?Q?PFCWghzGgBb9r5kBj4zJdK6MG4I5TeJChb10+dt9DozpglrRCceRvb+zVgLW?=
 =?us-ascii?Q?fWyWSXwHy94vyPPX7Wgngxhq2Icne3hKg1YvW4nt3xqIhGINxrVZBJSiqCIb?=
 =?us-ascii?Q?0lsDgG1Uqexjh18ASdbtL2hrzVR4xMhwiF73b9AYeFG2wrKW7d7zP1/sX9A0?=
 =?us-ascii?Q?lCJFn7E5ct/sdxx1SHL+O9MUMIlE0aV6lShYaMv34fjInazexPqaG1/DO/+w?=
 =?us-ascii?Q?JdOWaPUyX/Abpc7HK0BlrhPy4XqaCp8AOwZF31AfYUF6Cq4vq1kLkmRUSef9?=
 =?us-ascii?Q?FJfHGus0cQdDEbghHxR8i0G+EszGkjDu4YJtSrf/AaK2JlSNpEhXkDaAP98H?=
 =?us-ascii?Q?pVYdJZM26kRVX6MTokwbvxKzolqVqfktbAWb68h/uX2WRPP7ls5NXzM5o4to?=
 =?us-ascii?Q?YTBVAyR0jVLK9VuuU+MjDSwNOHm04GkVeh31nzzh33d5cqE9C22Yha+mXfVO?=
 =?us-ascii?Q?Pbg6MnsXm35DIVdXDSZHwLb2U/nJ67Ld/fGaF/SxliEV22vj96rJB75bbHfz?=
 =?us-ascii?Q?EjKkG0dJCsjp8fBqSlo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e767f5-4d62-4bfd-c5f6-08db0e6be832
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 09:14:42.2675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKPCTFYAFH2lE7FUa2o+hxIPXTWkz5eiRJHPQUOvBCWqgDgetCMG67IfKYMcxqaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: kunliu13 <Kun.Liu2@amd.com>
> Sent: Tuesday, February 14, 2023 4:03 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: added a sysfs interface for thermal
> throttling
>=20
> implement apu_thermal_cap r/w callback for vangogh
>=20
> Jira ID: SWDEV-354511
[Quan, Evan] Please drop this internal link.
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 23
> +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index cb10c7e31..d211b1dfe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1590,6 +1590,27 @@ static int vangogh_read_sensor(struct
> smu_context *smu,
>  	return ret;
>  }
>=20
> +static int vangogh_get_apu_thermal_limit(struct smu_context *smu,
> uint32_t *limit)
> +{
> +	int ret =3D -EINVAL;
> +
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +					      SMU_MSG_GetThermalLimit,
> +					      0, limit);
> +	return ret;
[Quan, Evan] "ret" here and below in vangogh_set_apu_thermal_limit seem unn=
ecessary.
Other that those, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> +}
> +
> +int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t
> limit)
> +{
> +	int ret =3D -EINVAL;
> +
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +
> SMU_MSG_SetReducedThermalLimit,
> +					      limit, NULL);
> +	return ret;
> +}
> +
> +
>  static int vangogh_set_watermarks_table(struct smu_context *smu,
>  				       struct pp_smu_wm_range_sets
> *clock_ranges)
>  {
> @@ -2425,6 +2446,8 @@ static const struct pptable_funcs
> vangogh_ppt_funcs =3D {
>  	.dpm_set_jpeg_enable =3D vangogh_dpm_set_jpeg_enable,
>  	.is_dpm_running =3D vangogh_is_dpm_running,
>  	.read_sensor =3D vangogh_read_sensor,
> +	.get_apu_thermal_limit =3D vangogh_get_apu_thermal_limit,
> +	.set_apu_thermal_limit =3D vangogh_set_apu_thermal_limit,
>  	.get_enabled_mask =3D smu_cmn_get_enabled_mask,
>  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>  	.set_watermarks_table =3D vangogh_set_watermarks_table,
> --
> 2.25.1
