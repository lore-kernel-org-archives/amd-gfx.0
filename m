Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B27C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 02:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB34810E836;
	Tue, 25 Jan 2022 02:55:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50F010E6D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 02:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvvB+Xj0LNMMhfkbIP9GkCrbHSiZMe1jm6CY4FaCehQLJ5/rviBwRxi7BGxjR+JgS+pbrR46toD4uKSofx8qgr/tOw5V9eknHSF7GvFjqNBwC4N7frV1vUv4s9u4XLWe9eb4WN6BggCcjNFEcNXg3Wv5xLXfLJ48BMLyRTpIxBp8oZj3gDtwwO8LyJFzVTsAMeBuhiUE8GMb66YC4qGgugvebAw2a2aqwYErXCv4Na7j+6gcHyzFsua+bXk9UwQ2iM80aYA79W7xgQJuB4PUkbzp7L750RpjofGPNqrGj/V9ms2fkhseCidIidi/fxPPrGpDiGMS/pWa70YksQy2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBBFr34bIF2kO5tgkfH7tQZ7gR43F0rEaaj/R066Vis=;
 b=Ug7GZcHv0SL/nlaFb89j1IpbtQ8os0u8F3I0IqaGRZ8sGY83nzsekz+RoFRIfaMXhKO7lOXIhsXh1SRj21OfsoC94EhYgKUuU1IG8BR8zx2wIqomgD8tQX+RlP91x8PdrT74V+PW5QY2GfxcDC/UywC/r1JOe//tVLhKa6Ps+r02AeKHnnujiJOArVgvVJ6uYfgfdzCoLFXbomMEg/2RVvMtcKKPPzGTXyONyyuOjjgqwsU26AiMMIEycP6DxE1T22JGquU2jQtJsI7OuotT1ES85Yxn2nl+7agHeNRQIkzbsp/0MPBs0CPquPQ+wOsyw+8RKKnAfCuKVzbmJdEgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBBFr34bIF2kO5tgkfH7tQZ7gR43F0rEaaj/R066Vis=;
 b=DCMk7brPL0/WmDAEkwFFrJ2k6P82Ur0n2pBKYx3IGAQkmBqHsJYo0YUKicFaPYy0NvmcIwuiSsbbdYRcxqr/M551CGIhWHc/oHkEq5VU7CLEzJRdBDpo/ofquk2gf4fCk8fbNOJXh/KMc8Y9KqjAb2Lb2qdZdLmW4lfvJ1kDUh4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 02:55:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 02:55:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu11.5: restore cclks in
 vangogh_set_performance_level
Thread-Topic: [PATCH] drm/amdgpu/smu11.5: restore cclks in
 vangogh_set_performance_level
Thread-Index: AQHYEWcldgxPudCcr0WTpdhL/Wsxt6xzCvYQ
Date: Tue, 25 Jan 2022 02:55:19 +0000
Message-ID: <DM6PR12MB26190D79E8267A37E1C87FB7E45F9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220124211230.1635105-1-alexander.deucher@amd.com>
In-Reply-To: <20220124211230.1635105-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-25T02:55:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=32eb9f2f-6c51-4cc8-85dc-8e2541724929;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41797ade-f400-4f21-015f-08d9dfae1fad
x-ms-traffictypediagnostic: BY5PR12MB4116:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4116B7E14A5B8AA8EC39E329E45F9@BY5PR12MB4116.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alD6gUkn+SrACnPevhUmyD7N6ZKc5YyrdgmGw0moT8IHD7d2uidpIGGATCBlw/4JlpkMPfs9eHLKRSf+pSdwf4RWkYT2bkIkco+a9voP0VuZbY4RE+1bbzyw0N6h0kP5tP5pbuJZY0f1BZ5B7qBKu/xOOd93p+Vk/jhNQcYDye4RV4kBsanhkuBE45Cd5nchCb6gOrvDnQ6eFLeKinsOr90lRhRbw2RPkWJ36cBY35MpCpguqz1mcskrbxZr8/1I+vLD5RM6Va9HA6nHorKy3jdguHGZ7etzkAtasfRhBnJiZggc9x8fBsbvhHX08nig+4pC5/CUw+udXh/t+xOWrGrwlyElSAap0Xog+l1QHjecmw9vDV7RK882itJ58b7rfAkZaX1KzKZmQFpgNv9T93VOJ97Nc+fj/hAq/g6vXu8uxitcXl5ouCBciz5BRhfNxv/EpxjerUAoAVYwUmZF4NOnvMiOfrCpxjtA0PmN2t0n8315JGu8xVTiDY7FI8WfkD7BfAVT/+Y3pTvoq/1hNwXAJ7/VGmnmF7KhqfAnOJcR4IQpm0QDhmSmyeXsG5yuxm8RSnf3NOjJpeQi16Zq6YLLyKfJE7QBEjA3QkkpSPEd81n70KW3e8pqpcCp4YOxd6AfzYVc1ykrAs1rd+4ycvH6scpQ346L3nqNtFXQ2asRuPAJvPSN+ArHyI5d6gJbwDKzF2BpetRf87FM/doBYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(508600001)(66556008)(86362001)(83380400001)(8936002)(52536014)(316002)(8676002)(71200400001)(26005)(7696005)(4326008)(9686003)(6506007)(186003)(38070700005)(2906002)(66476007)(33656002)(110136005)(76116006)(66946007)(122000001)(5660300002)(64756008)(66446008)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/n+1A9fb/B+KavVTv2rJjDL6yFQE85a5L0GTRWpguXSa34udNMMmoeGTaQJ?=
 =?us-ascii?Q?rD03YTms4DqyMgptgPfQ6mJztwbnB9YxmzakGcywIU1pmebGhlVrL5MjYmQh?=
 =?us-ascii?Q?qetf7Qh1Gl//MGaP9crpqeHKtWu7HbSRpLKs3H7VUq0btqLyVi4HtdXLazoL?=
 =?us-ascii?Q?DPz13IkXXB5UylqyRlGzNvsg8oHG2TAhE71xMeg0AwyCbZgHzVzQMtLa2UNQ?=
 =?us-ascii?Q?3s6GkFh0l7wzHad41MZdbnAso/opJQLL/lR4LtihzIa3BAwAJvM2liXF1xcV?=
 =?us-ascii?Q?AoAD6MrCbeuL6jd7N/JpT+tbhWyT4VhCXkIlp2zDiXbw6Basa0oVSOfEtjWk?=
 =?us-ascii?Q?VzddohmQwQD3TNe7XKRa3WzAkC6FjUU+Sk6ewS7lNAdiDLRDntg6wJylu+eR?=
 =?us-ascii?Q?J3AqoKcEi5j1rosp0JXcmbPMowXMLh8Ko1njBVOS0y3U+K2AQ5i7PEu2sKPv?=
 =?us-ascii?Q?XQFm2uB/CXNBP0ZXM9MYyfxbLH9i/urVnOPcU75oE4W2xUvz3e6PIm0/nzW0?=
 =?us-ascii?Q?InebumjFKKcAl7VpXkyDouSGAth5SVk7NSpK2DPZm/h6/0OSwbYi2xv2xg2g?=
 =?us-ascii?Q?wAbBaW+cpXoL8HKeVLDG6fDLdDmhAtGVoeUeFZjOuW4jvT3l9kavxVjvObT8?=
 =?us-ascii?Q?23fWJpvbXgGtrr4ifwZPxzDvYnwH3IZhI1HnaAqb9vlkaN3eb0zI8rEQNyw9?=
 =?us-ascii?Q?6kbtFrM3SNBQbLXJz8CZWyfm0jHMuTOJPfUSip3P0qv351CNzhGbfuKWPTz5?=
 =?us-ascii?Q?0OCn53hkCYfkXNl2Ag3pfeXLFAb3UejGU/1OBFQmO8sWBLr0OLQZAFmMrA8t?=
 =?us-ascii?Q?MJnPeJFhwf2IIuhnJK56X3m7Kd9JYw5H14qXnYDZu37ei2Atp196BM+6bTCu?=
 =?us-ascii?Q?4kmI55SrUMY+BGPTwjo15/8ic/i1IIQNyp/qkY9M0MnJo+BGeTLpI5lI3Smg?=
 =?us-ascii?Q?ogSvq28jXBNFgxwWe3+elD7MdJ3BrAxYuu6Z5Za04asIrvqwgFx7RpMJXHeV?=
 =?us-ascii?Q?obtX8S4VpP3SfeKGZdXBU0WFP/cAI6sL7OzP1CS4fMkvbCI3+LCiw7m6OWNX?=
 =?us-ascii?Q?mrTTN0rRm/gn2MfcV4+hdHGQkvztPiWzvQis80tSs/fnypqEyqvRMrFkJRD0?=
 =?us-ascii?Q?rKuJAUzIH4pGgBRhM48QWTjkUPECHfIl0Ya7A5AOjirsqTwWBRQDwzEO8MJU?=
 =?us-ascii?Q?q+tt87qLele6WkVTGrdP52lZT5V+0VX9ahUrxRqSh0/fv/XHmDyXGX2qoVRd?=
 =?us-ascii?Q?kqu8qje9dUydrkJl1yrl8dDPKKLC4ENRyzcMMaJJKcIqXaTh44w2yygzL1eF?=
 =?us-ascii?Q?O7OJMss3S7Z1ew589uKePubPdLM7wHWJHoAKoLtp9HtlO/5cesNuXfsyWGVE?=
 =?us-ascii?Q?AJNQX/8Vh/vsdIOsBktqrn1+t1pZJR9/8+PAGGZVahqRz6e21GioinfsNL0i?=
 =?us-ascii?Q?O6hVw7NvV5JJFnslB7YKUyPVrvpSmKsowtumH+NaUGONLpf3XQkK23rBisvh?=
 =?us-ascii?Q?l/cNhOa1zSR4rgcYLrD1db2GvFFILkaEEuRRV4g3mE811aYmhzlBFXAOc09Z?=
 =?us-ascii?Q?nzyGa+O0fA+n9PCRA3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41797ade-f400-4f21-015f-08d9dfae1fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 02:55:19.6965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aQb5sOvBDgts4Mo4RkO1kgi4gvTxuRB66s8BJqDN1VNuoNhtiKm3RqxMeH+AE87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 25, 2022 5:13 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu11.5: restore cclks in
> vangogh_set_performance_level
>=20
> When we disable manual clock setting, we need to restore the cclks
> as well as the gfxclk.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20
> ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 721027917f81..9a89b768c01b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1388,7 +1388,7 @@ static int
> vangogh_set_peak_clock_by_device(struct smu_context *smu)
>  static int vangogh_set_performance_level(struct smu_context *smu,
>  					enum amd_dpm_forced_level level)
>  {
> -	int ret =3D 0;
> +	int ret =3D 0, i;
>  	uint32_t soc_mask, mclk_mask, fclk_mask;
>  	uint32_t vclk_mask =3D 0, dclk_mask =3D 0;
>=20
> @@ -1482,6 +1482,24 @@ static int vangogh_set_performance_level(struct
> smu_context *smu,
>  	if (ret)
>  		return ret;
>=20
> +	if (smu->adev->pm.fw_version >=3D 0x43f1b00) {
> +		for (i =3D 0; i < smu->cpu_core_num; i++) {
> +			ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMinCclk,
> +							      ((i << 20)
> +							       | smu-
> >cpu_actual_soft_min_freq),
> +							      NULL);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxCclk,
> +							      ((i << 20)
> +							       | smu-
> >cpu_actual_soft_max_freq),
> +							      NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	return ret;
>  }
>=20
> --
> 2.34.1
