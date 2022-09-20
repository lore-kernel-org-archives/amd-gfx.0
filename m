Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04784C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 01:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141B810E133;
	Tue, 20 Sep 2022 01:04:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F4B10E133
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 01:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnWJP/EHr5D5KaG8KuR6aV+gpEMc20yojTt0YMAirgDcMswIrNzmE5d0FQ9hJcOWrkCS1DZhKv+ZBBtPklZWz6oVFEU6hfgQ0GjkZEmjJe1BW4UiBfxLtA+KQAUsCN/znTaZIqhnl1AoYhO+N0ExwWdBrJbnXyqgSmJnMj2lGl+fadfLB9HlYmnacGsCGuYEkasCLEvEVX+hPTdXGdESU8fI9jNYGZujBuCoDy+BI7u3dfiOtofpDpHPDTdi3I4O7/D2bJWvgrgu3gd8NplbCsMTU+bgQF8ZNJ+2VUqHTtVihAB4Dein9b2e6dY1UfcxszRXZo0Zz6aL+A8gBDcUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yynYT7atQpqjv4S/Uzx4NX+D5fN9+H+R5YXlNqwLlEM=;
 b=YWKPm9bNY7eZUheIW0bapDiWdpVI/UW7sMip5Y3BIUCPPIIOa591368i673qcrdyaz6uB7+tQ1Dqh182WhnqidOgNa6KVE9tSC2TH1eMqoOoC0ZBJELWC+OTUclDR4h2JUxGsjxJWApOSnKQU8sP723Mf9FPp4uYicJTEwb79e1UYhqjrpoCwC+X8MhNPu2OWcmWdAoxQq93phXcuaPav8OGyqXKax0ZQ6oy+qnkIWvv3JMim9MXFRdffseEBhqHJrwk9OJQ8/gfTp5Els8x53Oqanc08j2AdJWxjaPB19DDNcQVQ3OL1OjPviibPP4o3tAVRqIuT5Tx7FB6Wa9ZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yynYT7atQpqjv4S/Uzx4NX+D5fN9+H+R5YXlNqwLlEM=;
 b=BREU0Ev7zDUxEhLjTfBqYZJEhvSGbf2VosUix1IL9PV3qK50ZKf5qVDViXJ7gor7XAqrZ5kKHyYwsWqgNuRwqN2w0mhSfXfjLYQ/f4V0oWe879x3hvn629KvbjNVIm8EFHthUIwLt9pXACgPLs64h6gEIfyGM2kCkkwgzcrkp5s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 01:04:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::64a0:7cc8:5c5f:90fe]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::64a0:7cc8:5c5f:90fe%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 01:04:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH V2 2/7] drm/amd/pm: drop the pptable related workarounds
 for SMU 13.0.0
Thread-Topic: [PATCH V2 2/7] drm/amd/pm: drop the pptable related workarounds
 for SMU 13.0.0
Thread-Index: AQHYy8whtpHCVU6mUUuThqM8uXyksa3ngVpg
Date: Tue, 20 Sep 2022 01:04:10 +0000
Message-ID: <DM6PR12MB26193F4171EC61A571649091E44C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
 <20220919020251.7048-2-evan.quan@amd.com>
In-Reply-To: <20220919020251.7048-2-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-20T01:04:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e0f1269-5fa2-422a-94d8-3c80dd408961;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SA1PR12MB7040:EE_
x-ms-office365-filtering-correlation-id: 83a0f3c5-9270-41bc-6280-08da9aa40693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjjk9VaUDV0DmxTL8ubFpoTNSFZwSs8MCKJlaxfpp0e+m/I2AT2FtlWo3jzPR9aMIFCj2I/J4ZIUY3JGxo71ElpqnUQvtmDwIAZOwaLC068VlM6+JlbAEiVbixeqkctaDroPPQHFk/SNfD0Cm4nsBswI0BfpNGohhOGKxSqNR871ik5IvXi08Znd0rVWBseZ0yEpCWybWfQgVbidwy85s3ruBtQak0yGWjRt4fl/ACrl1BDpEAqmb3DSlcTMhRM7d/taeGqTgv2u+RrsQimMeCapmdtvB8kcy+WuYhOQ8ArZ721RVHP53GrsexgQjLWiQZAFDhfIx0dRc7qAQqGkkuy/nrHYjHt3nTNrN8EKfR3eF47+c0rSbvoLEO6xEyJS4qDnJZRH8+mP+59qFGBvRgu2u5OZsD7n3jptsPZpIz+l5+xc3IRoelAfdVXlxmiLrA6WwTqrWRFD6MOzezopQBqs8yoJO9WahxuWi/GowoPN7EtE9DMaCycQN8ykzTCs7UCowPjCQ5jOIjVxeEA7rx2lcRNnEn5lNYlN7a6zGODpTxgDgBwfeTj1NK4B5GMyYGzWLuHpRGeiwQso9l5mZUF2DZ2witS6FoJsVx1NDe3358kGIHYKc9SvHlHZAX3GxkTtGOGFZkH2qB3ssLoZg7qd8u/+kYeXSD4BZnWYYSaJz2tQt9Hb+rHrCcpPO0/7t+/+MmU99sNeVwG8qvo9bIJ+iCHM0PcxzpVY0pPxZt8zrZC68guc/1veF2VHNCBiwmD2jUOiaBjFtnrWfU2Jtw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(66946007)(6636002)(52536014)(33656002)(5660300002)(8936002)(316002)(86362001)(110136005)(76116006)(66556008)(4326008)(8676002)(64756008)(66446008)(66476007)(122000001)(38100700002)(83380400001)(7696005)(53546011)(41300700001)(6506007)(71200400001)(478600001)(186003)(9686003)(26005)(38070700005)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?km0a8+9tdAr0+NxFYSvrjo6pP6lIbMSeHGO60MrbM3UGMirDnFoe7jkeyM19?=
 =?us-ascii?Q?5a9WAztCsptIuz/3N2rkwA17Akrfbiq3bIbsGuolywyARCpwCsKAHWh/Hp06?=
 =?us-ascii?Q?jBZUHI8UuQ+lgfMagH/ktbXwAtsZnSSdqZa62VGm5zLUuWNV981RqN2P0sGx?=
 =?us-ascii?Q?gPlkXHGa0OU3ElaSHFH/HZNIX4oI3TZhp2BRcpmFQa8qym4UCldTTLjL3whM?=
 =?us-ascii?Q?v6W2W9ka1xWMVSIWWFU3q2UMA/m9j7rvKuefV6l896qCZ9Gze5EPBOvO+8q9?=
 =?us-ascii?Q?xvj4vkk2CyKkycuZWsV7my+J+Dmj1nprBbRB7nOrKmJ6zOetxsZiLLsbviUO?=
 =?us-ascii?Q?s7PA7nDuP0EuTBhmSjrfoptBsi1YNbEgAoNMx+2RclNREpsurETx8Vp/mfbA?=
 =?us-ascii?Q?ZXjRbsYv8ofsvTOML4+eO9fnpq5RJHKJWkplD1IkhtrQJd2GoWgttUUIgtm6?=
 =?us-ascii?Q?7H53fjyit2Vo9N+ncr9V5B8YZV1fM7sIXCwCn5LYEmSS6lL98x4+Ivu/PjVw?=
 =?us-ascii?Q?KyYKEWMreyOx0mmzHwvRRkVkO91YYXJ0etQHsRyREkaAC8G+nVZmc/jgn/hW?=
 =?us-ascii?Q?b5N8cz0OyKKVXuh8xMYEzfj637ikCXRGMba+YxPO5FP4WIxEHNTH1nDFaVei?=
 =?us-ascii?Q?RTcQMsevfEEWX86rXYx9un4DObP8Vvv4okTfm3lDM/5fhOEFz8mO49TRZHG7?=
 =?us-ascii?Q?qPGyy1GqFNxkN1t0FB+5ZJmk2X4/ttb2d6ZWvT5aInCRVD7/SBd7BBTd098V?=
 =?us-ascii?Q?RGUMI3LiJ1dwCSvEt+jHtDAN28tzSxbSn2z+2RW5CBfF1ZZ3W5m1C5tZq9L+?=
 =?us-ascii?Q?LHT1emNWoXKGVzOoCvUyZJiw4nyRJXiBYLEZy35iKtPqcTtW6t+oVOgG+WLM?=
 =?us-ascii?Q?y5euqAL5NnCgJCM1P0/I9iUBjRSdntdK+llYxIO9gzAeniGYAgIpKYDsAsBO?=
 =?us-ascii?Q?66os24s4lRuJVvPy6f0k1mxGwmCIzS5exR98aSWV1axIccM79pUUcdS6zQKy?=
 =?us-ascii?Q?md+Mha4J5VnPuUdQoAvPOPNVmNTxhBR+D0rxDahA6ld+Lug4b90gRNSzXLig?=
 =?us-ascii?Q?Y3Fvof1uowKzTdhkpsQyBNrdqpeURvSsTBMBXzY8hBY3gMzJ+nl1JMozYhy9?=
 =?us-ascii?Q?xo09/zxItx2qTKUI9DbUhIIb4KcaAy06yLEYEpdKqUi5yxu8J17Gmeggf/8I?=
 =?us-ascii?Q?flUzKjR4MLWPVcy73jMo79edb+5l+t+7Ja1IVZoNm58rgpnr8murzIY6ZMR9?=
 =?us-ascii?Q?Yq3lzxRXds8avnrhtmHAlhiw67h23i00DGWr5lM3Wb+UfpAiVwQqIdeZf+cE?=
 =?us-ascii?Q?fJPOvt0BOM0AIhqt8RjH+BQM06YeEduT+gORVwDBxzXQ4aVqJ5JvLhsnB7Ds?=
 =?us-ascii?Q?Lz2wxqn12Kf2B7VnkXZc3c9qp9Ki3Dawdnje2g2yzzYpDb4VotlTOhoCRxzB?=
 =?us-ascii?Q?Yqh8t/G3m6cek3XtNJxB1EvL78UDnn/FzcxXy8UfNFOhUQZ4SpduDAV9jglH?=
 =?us-ascii?Q?JOCt37X7ydgUWVFKApk4oiXeQ3U5I0CLtJw+p0ad1eEJqQcKV9eBZI2FdirC?=
 =?us-ascii?Q?V8ICK9GXHEwfzh+wvTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a0f3c5-9270-41bc-6280-08da9aa40693
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 01:04:10.1670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJh4u1hFygieFxC12VT5feis8heEs456WOUR5tpDi4x0dHFXyr+X67tm+GImAemG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

@Deucher, Alexander @Lazar, Lijo Can I have your RB for the first two patch=
es of this series? I know there is some arguments for other patches.
As that(missing of the first two patches) is gating the integration of the =
new IFWIs for SMU13.0.0 ASIC.

BR
Evan
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, September 19, 2022 10:03 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V2 2/7] drm/amd/pm: drop the pptable related
> workarounds for SMU 13.0.0
>=20
> The pptable in the vbios is fully ready. The related workarounds in drive=
r are
> not needed any more.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I2549cd1acd6eebde361ed8e27d5631bd57644e52
> --
> v1->v2:
>   - drop unrelated and unnecessary changes(Alex, Guchun)
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 46 ++--------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 54 ++-----------------
>  2 files changed, 6 insertions(+), 94 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 4fd685af8fa4..53d26bca524a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -210,7 +210,8 @@ int smu_v13_0_init_pptable_microcode(struct
> smu_context *smu)
>  	if (!adev->scpm_enabled)
>  		return 0;
>=20
> -	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7))
> +	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7)) ||
> +	    (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 0)))
>  		return 0;
>=20
>  	/* override pptable_id from driver parameter */ @@ -219,27 +220,6
> @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
>  		dev_info(adev->dev, "override pptable id %d\n",
> pptable_id);
>  	} else {
>  		pptable_id =3D smu->smu_table.boot_values.pp_table_id;
> -
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
> -		 *   - use vbios carried pptable when pptable_id is 3664, 3715
> or 3795
> -		 *   - use 36831 soft pptable when pptable_id is 3683
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0,
> 0)) {
> -			switch (pptable_id) {
> -			case 3664:
> -			case 3715:
> -			case 3795:
> -				pptable_id =3D 0;
> -				break;
> -			case 3683:
> -				pptable_id =3D 36831;
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable
> id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		}
>  	}
>=20
>  	/* "pptable_id =3D=3D 0" means vbios carries the pptable. */ @@ -475,28
> +455,8 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
>  	} else {
>  		pptable_id =3D smu->smu_table.boot_values.pp_table_id;
>=20
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
> -		 *   - use 3664, 3683 or 3715 on request
> -		 *   - use 3664 when pptable_id is 0
> -		 * TODO: drop these when the pptable carried in vbios is
> ready.
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0,
> 0)) {
> -			switch (pptable_id) {
> -			case 0:
> -				pptable_id =3D 3664;
> -				break;
> -			case 3664:
> -			case 3683:
> -			case 3715:
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable
> id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		} else if (adev->ip_versions[MP1_HWIP][0] =3D=3D
> IP_VERSION(13, 0, 10)) {
> +		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0,
> 10))
>  			pptable_id =3D 6666;
> -		}
>  	}
>=20
>  	/* force using vbios pptable in sriov mode */ diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a6b7319fbfe6..1d454485e0d9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -375,59 +375,11 @@ static int smu_v13_0_0_setup_pptable(struct
> smu_context *smu)  {
>  	struct smu_table_context *smu_table =3D &smu->smu_table;
>  	struct amdgpu_device *adev =3D smu->adev;
> -	uint32_t pptable_id;
>  	int ret =3D 0;
>=20
> -	/*
> -	 * With SCPM enabled, the pptable used will be signed. It cannot
> -	 * be used directly by driver. To get the raw pptable, we need to
> -	 * rely on the combo pptable(and its revelant SMU message).
> -	 */
> -	if (adev->scpm_enabled) {
> -		ret =3D smu_v13_0_0_get_pptable_from_pmfw(smu,
> -							&smu_table-
> >power_play_table,
> -							&smu_table-
> >power_play_table_size);
> -	} else {
> -		/* override pptable_id from driver parameter */
> -		if (amdgpu_smu_pptable_id >=3D 0) {
> -			pptable_id =3D amdgpu_smu_pptable_id;
> -			dev_info(adev->dev, "override pptable id %d\n",
> pptable_id);
> -		} else {
> -			pptable_id =3D smu_table->boot_values.pp_table_id;
> -		}
> -
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
> -		 *   - use vbios carried pptable when pptable_id is 3664, 3715
> or 3795
> -		 *   - use soft pptable when pptable_id is 3683
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0,
> 0)) {
> -			switch (pptable_id) {
> -			case 3664:
> -			case 3715:
> -			case 3795:
> -			case 3794:
> -				pptable_id =3D 0;
> -				break;
> -			case 3683:
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable
> id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		}
> -
> -		/* force using vbios pptable in sriov mode */
> -		if ((amdgpu_sriov_vf(adev) || !pptable_id) &&
> (amdgpu_emu_mode !=3D 1))
> -			ret =3D smu_v13_0_0_get_pptable_from_pmfw(smu,
> -								&smu_table-
> >power_play_table,
> -								&smu_table-
> >power_play_table_size);
> -		else
> -			ret =3D smu_v13_0_get_pptable_from_firmware(smu,
> -								  &smu_table-
> >power_play_table,
> -								  &smu_table-
> >power_play_table_size,
> -								  pptable_id);
> -	}
> +	ret =3D smu_v13_0_0_get_pptable_from_pmfw(smu,
> +						&smu_table-
> >power_play_table,
> +						&smu_table-
> >power_play_table_size);
>  	if (ret)
>  		return ret;
>=20
> --
> 2.34.1
