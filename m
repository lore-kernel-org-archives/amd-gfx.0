Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E390DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 04:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACD510E22D;
	Mon, 14 Feb 2022 04:38:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F8010E22D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 04:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYbzl9jo3f9EN8W2P3ip/7qMcPFEqVVO8MdiHyZtrdNMUnurbzS1AgVRR8dorNy64uj+oLLBfx9GSthnlkX858M1f8MnBcPpWuUltSwxrphyRgO43D2XOGV68njq3i4FzuJwKXu/SQOqFa42wEQ8uIBxvT/zRyKVhzDO9fP/jtA2DZHleBH8wZgdhdBowc2gS9u0Gl1IICbGhQDQASENeTexw89xsZj5Rp3ltlozjhDouFRB6eoDOzI8JpfFFZ0sSt/jldm7HOMw/SJ/iOknsDawHSbfuLFKYoj74Y7cQruRpTvfN4WpfzFV5Bv9+YA45mHVpLFCyEVzJR7AR2ZYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdTm4sj0YoyiZ0Mmm3O3WTvoAp5XA1dGcXuIheL9Xs0=;
 b=EOiM/FU/8q0ACubMvVjh0Sqj+f6nSRYJ5O8aoikL5/aXu1fkPSH0k6/PyuAefAFeLQakpY4pI0mpT3wMCJJz1Wdj9YLIFtLErXdecLKewSmhcNK5/29VTgHwEKsfOrzAuVOGR7AIjt0XLVAyoFKMiCoYPHDRGlWXBWtFaLmPaWGzil+JHBHndBh7hq8irgufkA2DNRZe+fGZmlBlcJUZ8aEG1E6z/Ur4r9WeAOWM/OupY4zUdnLa458HAlFWUMuAfntH3lH9+4dct8/WsVsrvRLd3nabVUgU90RUFlMA/QciBH6ZKjZ4fzK9p4qRUEFrp7MsS9hwPnq/tLNDPhw31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdTm4sj0YoyiZ0Mmm3O3WTvoAp5XA1dGcXuIheL9Xs0=;
 b=nwCPDHDdBp7t3zgZearI5VoEuVOxOk6kRvuN+PyO4ur/vnqAuMIYlVDWiwXzDHf6WtFaEoHYcO1s7eo3T3ExLWo76HYJBRimncOnaO+m6djShkATg5FFkqDjtbUVRTkxBHI/Sgwx2r21wfkfgtNkyvSigsZnYGGgtF+gmyv7zHY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 04:38:28 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587%5]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 04:38:28 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Topic: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Index: AQHYIVkNJV84Gq/p50mVV3yZyCX7vaySdkJw
Date: Mon, 14 Feb 2022 04:38:28 +0000
Message-ID: <BL1PR12MB5237138B195FAF8E0DEB35AFF0339@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220214041142.2556519-1-yifan1.zhang@amd.com>
In-Reply-To: <20220214041142.2556519-1-yifan1.zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T04:38:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0aac96d3-5e7f-44f0-ba73-3f1dbf70e38f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-14T04:38:23Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f2532b12-3913-42a6-8e69-c07ea9d89ffe
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6458e45d-0a53-436a-93c9-08d9ef73d895
x-ms-traffictypediagnostic: SN6PR12MB2686:EE_
x-microsoft-antispam-prvs: <SN6PR12MB26861A2EB4F1B81CE44D9C3EF0339@SN6PR12MB2686.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7chbGHug7ugd1ugJW7pe2upVkgdHV6R89P5MwmeqIbSZYQmOEFsWPqygT8WoJQGfO75U8g5t0BkTvscxVlZbWoMSOVnnzCF6gv7C4pcxWCsGBi6OvhT6+rXra/KTbEA+Clno6rEhFUaB6qW+n5An8wqkk//ydghIkNjkaz9hRt4Nmr684Xib6Fb4EeH9iMaGsIgMw+I+XvbPIJQ9OFJMvBE9iahwYppCOpxJffoU89qIvVmeqMjqJkyDmRyJx2FqOlfTmxi4qjcvmQ0keeKur+3SZu/VYr/9XKVv3QfLQKpflA89Ur747O5OWHFDeEKwmFwz37YCkJMxcJIE4tR9fYS70x3TNTGxfoYaPHpJcogn1gzwvTZUbO9/ANEs9QrC97R6yGtoiRlZWSXgSghKs1PaxQJV+Eq8ISEkFn+yRVQTnHCqj2Tn4q6/NMqBSFB4BiJbM01I4oTdXrS4qB1Wqq2QN9PN6e56jifItoG9j+IYdNsaav/22ymunjcYZecAacaXq/LYBmDsgGvlXMQmnYWD9huOqtfO9k9d82Ok2MyDBjRCznKLhTL/prH0JAC72YhU3ve9WZl5B2DX1EGqcFRJ3qAEqMDFCm3/VlhFO7oJ0N2EYLYBU1l5VKKuK+EbBIUFlRd+6LOsmfOKiGisS9c1EjgdaVFSrhBAyBfIL0bAl+CiWWzRiGsay06SgtxriPlSOWYJTH6ob4wIFWErg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66946007)(7696005)(66476007)(66446008)(66556008)(76116006)(83380400001)(38070700005)(5660300002)(6506007)(9686003)(2906002)(53546011)(71200400001)(26005)(33656002)(186003)(4326008)(86362001)(52536014)(316002)(110136005)(54906003)(8936002)(122000001)(55016003)(8676002)(508600001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pgy3L++kTh9QyN9YJpZtcITDOJ62f2PaXPOCpjeQG5laZpmMlgquB5i0LsgM?=
 =?us-ascii?Q?GB0A/mFt+xfs+G3BBsWdYoRvI8DckGoMRjlcoBGgxJLOyA1z+dn1YAuqNFO6?=
 =?us-ascii?Q?DWDQKAE6lilsz0ZEPrN7OOzpF1pXXg9wtp+zSD0EqKfAms7RdeI89BEW1fc4?=
 =?us-ascii?Q?taot3uPRMennq81S67ppN4W5E3lmtSHeOIxEhyf85OGJVm2LwGRo+jVaNsXL?=
 =?us-ascii?Q?ITBY8fYonbvFgwwqIOz/vLp2aXQ88McGqZnytwfJPacZrClTpXguxeaZm64R?=
 =?us-ascii?Q?IqguJ/kxdTzPNTdTeSt6LZnIdZ+s5mwC8BieR982bv/yz8GkLRxe5jT1a1La?=
 =?us-ascii?Q?hVRi9Egw+6FoBpJUod+AUoYMnara/KJWx0H7NjDHacQmv81u+a0rfZA818Xd?=
 =?us-ascii?Q?olbNHu7hc8iZrb+EWmE1SuSqfpPafxR3sNh/JCwbfjObmopbRtJ998L99S9z?=
 =?us-ascii?Q?kQyXB8IcOauPd7Xi2o0Tx+RAzRent+91mm04a9w9I4QQirYD0vzylwB7oROp?=
 =?us-ascii?Q?NVqYeUu9ylNooAfkWPgJptuQd5HSXbv+MaJTA72cgEDpMNeddCIHZlYDPVdw?=
 =?us-ascii?Q?2t7sMdpt8Li6u1C9An42gsaGFDHOZHKia8kChETA7ncVmQ0gHMYM6FhKjQyv?=
 =?us-ascii?Q?zkZxb/Bb1xm/fPBWYGHABYmHLiqpvYXW5gHpJuGbxyh9Y+/YDZ3fNnCrR4Z1?=
 =?us-ascii?Q?8+GYD10vGcCvBoMni+1sUJ6xGTv8HPIWI6s5+J2yFtfAPKIrC0wlUeUIZrM8?=
 =?us-ascii?Q?N/VlUgx/m/yGSDf+eeXcfY0HK98ZWsp5+55g+pqikWT4OJH+MCqLHnAvm3bu?=
 =?us-ascii?Q?0CmMmuyj0cMFZKV+zf/abOclLsYJ1Y6o5nd2D52AIatHwBTT1qfJXDw/6H+U?=
 =?us-ascii?Q?NafkvAv3uAuorPakPovDv3TpIKI733vjIDYdYH+KRVk6QWYHWQRdhe0YtLTv?=
 =?us-ascii?Q?ZhTWy4uehFl8vu9uvf37VJZdm7SNOCsLDFpB/op6PTqbOknIHD2NseGn714X?=
 =?us-ascii?Q?a5DeJrPYZidcaDPBjALXm0ZN0JswBhXH5iEIq1mF+C5ix/FdOlA8LSyeDkWC?=
 =?us-ascii?Q?wOCgbO5S3pzVUY/E1LPQWfr17m4bQN762C82Ed1gfO2wymbIKp2FaM9whStt?=
 =?us-ascii?Q?QYoq4ijNrEOhjjV/6/cTogyo24AElF7dPVPEH5uVrUgObSq1wMYIiZ15fRgU?=
 =?us-ascii?Q?7ClqSETJROOBjh6TBYFzIc6clH4EeqLWPBPtdXJwKpbHZGg3VbNaGpSHyFQp?=
 =?us-ascii?Q?Ov/jBwsELHXwH9udnTeiluP+nVzrMhQG8oWB7OHEJYlewA+ya/qFOFVdZ8pQ?=
 =?us-ascii?Q?XWHmkGH8z7DOsaqP+bpAbAv3MGLpL/snOpV5WOgeBXXWzFM6zlv38m6EthCL?=
 =?us-ascii?Q?949VthnmNN+/lRd5KmIz0TuTvBNCpF+mzd3YzrpuOGdjIyEZjk0HKfaEOCeY?=
 =?us-ascii?Q?rURce5PNRzmdgpmqMm31tXpWDH/hBgE8+8ORF5d7T5S81BbHMrjf2qHCYMqh?=
 =?us-ascii?Q?jOT/w3wKgRoNCkKZUV1pzbv4k7p0ShAunXvI/NQXTTN0wvV1jHfBESA9+tXD?=
 =?us-ascii?Q?P6Avg3xGn78bsc4Qy6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6458e45d-0a53-436a-93c9-08d9ef73d895
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 04:38:28.1864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEeMPVLj+CmcPLKtqZU4wCTCL96+UIq5JwLEgXlymYkIBqr2Be8j1kHu4bj7pEqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Yifan,
Please remove Change-Id.
With this fixed, Acked-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan
> Zhang
> Sent: Monday, February 14, 2022 12:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset
> msg
>=20
> the 2nd parameter should be smu msg type rather than asic msg index.
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Change-Id: I0a65fac53b06c053ce193580d68cf586e77d2c2d
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e90387a84cbb..e2d099409123 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -262,14 +262,9 @@ static int yellow_carp_post_smu_init(struct
> smu_context *smu)
>=20
>  static int yellow_carp_mode_reset(struct smu_context *smu, int type)  {
> -	int ret =3D 0, index =3D 0;
> -
> -	index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
> -				SMU_MSG_GfxDeviceDriverReset);
> -	if (index < 0)
> -		return index =3D=3D -EACCES ? 0 : index;
> +	int ret =3D 0;
>=20
> -	ret =3D smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index,
> type, NULL);
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +SMU_MSG_GfxDeviceDriverReset, type, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "Failed to mode reset!\n");
>=20
> --
> 2.25.1
