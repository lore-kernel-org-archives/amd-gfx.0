Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 03:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD3510EA18;
	Thu, 13 Jan 2022 03:28:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8887310EA18
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 03:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkVYaXRk+J+mFfa7lExl6RNA5Q5SnvjOr6QY9oQk7sMVfutvpqyxawLfd0gxHUqU8Ygknd0vnwX7ydYIURxRCOUYKHumPuEy30n5NoErPUmfIbePrwR8lU6MRYCCzc8X9Is+rUqFTQC9tnkjWFLGieM2A40Bw5ARuMu6yQft39rhFx7M2nlMKDn+6bap1wsL6TNNAGAzseKiItCRvNydT0h/lYFACJZcw0sT0pguPnI5VvBTBsHntmbYuvrXaMtUGJ5krbe1HDjyFvVf/zguzk5YZCpGUjRs4i7Eu196QE+wLA83tQwhypzXDmi3g+yFpe9f6jKSiK5X3Ux6/ldGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRFKcOrG0IwFhFdWzyqsivTG+HNc7yvAWT8rPrnQZBo=;
 b=KE54G6VtDFyzAPktz3TAQAn/KW67HA4XTQhTR5+rk5FfkvO3sKQiWSoaA1s9XlUO8NUFZ3ZYyQJM/wVzJnkRGmk9CkLLfdymOWzX3BCK9vo8EQSvhs69FfcisVnAwYVhTph5swXbuNPMBGZlQ5Gn2E6wDO1/piQnBWP8g1C0FxUVUKv1ve9EObS2HFXV1NgZnum/tH6Siag8WoIS6gOoHgaiZQjmfLQ0LhhWfZj215wDgzj34y7zFEPexGoXMlS5iIfgRSBsWNz7RGYqqMezM4QzlXpVfShwT+7ym3cfPlaupICPmHp1hP3KYszsFfV0piv0LrWJZP4Jh+9mQaN/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRFKcOrG0IwFhFdWzyqsivTG+HNc7yvAWT8rPrnQZBo=;
 b=AszczJ0zgMTXOTZhPbneiHWjs4Yc1uaC8k3nAjgUqe+8YTuJ4X3Hnm/VBqEhGwvkjLqQJqtNdHJKvZP/bVsq0A73Yf/UGfTsCxZJK9Hst9CAvMtwVhnHrQ1RTgNb2hOetEmOL04fZZHkbR8+K8MMyhGR4CmdFlF8FVIz8onfMHA=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 03:28:47 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::1909:ffc6:461a:5727]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::1909:ffc6:461a:5727%9]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 03:28:47 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Thread-Index: AQHYCBzk73IO8nEW6EKj2ZKVTOYe2qxgSnXw
Date: Thu, 13 Jan 2022 03:28:47 +0000
Message-ID: <CY4PR12MB176788FD3646CE7D5DB37886B0539@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20220113012829.27726-1-Stanley.Yang@amd.com>
In-Reply-To: <20220113012829.27726-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T03:28:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=156385e4-1994-42d7-9915-7d829c7d7b36;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-13T03:28:42Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b562c790-276c-484f-ba93-a4b619e15a07
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e560c8d-35ff-41cb-0571-08d9d644cf81
x-ms-traffictypediagnostic: CY4PR12MB1671:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1671A281EE89331052EFC90CB0539@CY4PR12MB1671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTXC89UVJuvO5yX387FKE77VUkC9hOf/4KWV0Dskaky0T4EeqJ6Nwe3BfysrJxK8gX80EXkYoJmFnkQ50qA9/SY3zp7ceNgUdQenk2KouYJXx4CvAtUsr+Zs3DqV6ub4tu9md/leESt7tbDf4KyTZsuRPI+klf34y8r/8K0wX5qosy0YRf6/rqglUMNOzX9j3db4jCmNI+hlen4fDpoHn236y3nIYfQSpThQ5juafegCK+2PJHhtN0NhYMZoYrL4dqObVl3BNm85j1moEED9QxH7DgT47dRPPAq/et/c0QOQAxE4Lq6Vm9cmCPXFUDKuHIhYVJrEw9YzNPTM2c8etIlVt2k9/y2mQ/WMdX3q/ql5UMeRSHQmqHI9dpVJsU5+bMnF5DbwRKvdi2ZdozA20RZThU19RveDRIKG28wmAOqUYuiXXZxOc1Z0W0trP6wNxq5FzqnQjRbHHVwpIvhd2PNahUIYqphD5t6gSJxdhmrvao5vEDznc+VITfKwUsqmEFYRv2naeCWFkXiRh1FdPBdSYxeTzjYNQyMdu6IRo6jdxPKKgSBj/mALYB2Tua47D31PWAXzhupZVlMXeo1EPiwgz73XC3BuqetebkjwPfWRkw/6WEFUfQX1sF1CjbH+kvRE3zzBOnQaVFsvywaiMKzZKwBG8hmkLsg3l1tVbCCQAIUvtXt0wfA8kUDYLHU9d3Ji8RJXlwGQcL0Fz0KudQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(33656002)(66476007)(66946007)(64756008)(8676002)(8936002)(2906002)(66446008)(5660300002)(38070700005)(7696005)(86362001)(54906003)(508600001)(6506007)(110136005)(38100700002)(122000001)(55016003)(9686003)(53546011)(76116006)(26005)(316002)(186003)(4326008)(83380400001)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mtOrtXy+IsgQxN5QAVrlv1pz55VfsyhEmrt+Qld47DQc20Yre4+uCoRs9gVe?=
 =?us-ascii?Q?WxzzCsNed4LdsXiHryLdXxa7WDBhbS2b0RgG1eL4vFoKQOgGMu/Nd2ZEO2B4?=
 =?us-ascii?Q?Zc/mQ9v/itbfiITHnbjJOB8tv3Ha2/qdiAvmhzSXi5t4G81ScH5vL95Xyhk1?=
 =?us-ascii?Q?skwTZjroVhr4YbPQYAP+DgxFYrgeXkkS16dkNmx49c9Izsra5HNLsTT/Ct7b?=
 =?us-ascii?Q?WoMRjvFqCDSV8WMlQ2QqTstRRGZZBcn9ZEo9NNqsxO1kXDMiVfbTb/npEOMs?=
 =?us-ascii?Q?6q3yrKcZieLSDJcO+7xlrcWm+2bkcVzVFXRfe/mfpbB3voYHbMcW0ZaOLCH3?=
 =?us-ascii?Q?Ajb4kzJep1UWR2khrTsI/aknxfKFsirQofUezaoRsIdz7qX56MSJtrjvSf6x?=
 =?us-ascii?Q?/XRN8YSp0tB5hrTkK7Wl207A7ECw4OZpG66eT5cMEgVQiS3h7uFijRlu4SDN?=
 =?us-ascii?Q?6fg2F4wLEQoYLMVKqT9kkdigQrg9RwqpyddOo9Y/9TqwZDEHjj06dUhMcky4?=
 =?us-ascii?Q?sh3uF9BTtczAIkBoFlqtG1nZUd5rDNNtkGVwZUp3FZRqL7zu14LzX81J0biN?=
 =?us-ascii?Q?ITtfGe8P4Lq6BwZCHUQUi9PrKhD+POMs9XFskAgNJGvLhubCOsnIt/TY9wyV?=
 =?us-ascii?Q?W5BBduugYtHt2wwfrqR8bXE4/0jPHP3Fx/dRf40rh2jT541ws9Lb4FHkrBhI?=
 =?us-ascii?Q?Y9X5zvu7h4/Zx3V6WhwpygXRFSUvdaN2SAW2ajGxn369Y2VeNK+Kdfp+cF80?=
 =?us-ascii?Q?Z7W44RuqE2CGS+YyCjpiPJEcuWQ0KZhuYTARQXJxuUJ2TT+RbOfK0Acx1GhY?=
 =?us-ascii?Q?mcgfm3UIFmuhJAbGaj38O8jmaZ8xNOzHyLIwkdh0j9VS4215ZW3JjSC3gAje?=
 =?us-ascii?Q?68UjsXtiHTbfWGUMzdQaJUqXlPQHHBsxweVg+aLHDjz4yH0tRaPR8nlUOGcN?=
 =?us-ascii?Q?jh3iYvNKAcGdlrp+9DsArAyF9kdPRhFdtwZOQMiqTLAIhvt70vezJpXxskWH?=
 =?us-ascii?Q?pvEH4V0jPUPHm1rl0185QSNbKoCqGiDGT0+ApXcP1nRjupKg8NUS1MJ3b94S?=
 =?us-ascii?Q?xvQlnf0huGjf0r2FR5p3upTZTohXfATudPU6vssSeENZiR9cNh9d5nGPrYAn?=
 =?us-ascii?Q?Edv0P2HSmEisjeoROiqU2VN4sVJJ0JnGdHLvf8y6kx1BstP42ssw1baSn7R1?=
 =?us-ascii?Q?Z/qwxj+MpWX0uy185SvzZBDM7qJDLGg39RAv8ziSnbo7o3tyJwxcwCEtRcqX?=
 =?us-ascii?Q?uwJnXKCW1sa5iWS2rdYsawI59kNjpVPSfWwafyUmERgzYzo10foPrYaBhfSa?=
 =?us-ascii?Q?euNHWm/Jguki8nE4UrIiblTQZbJwA3xfjmFkZBK7o/0auE+91X3oXbZFKKm5?=
 =?us-ascii?Q?5744kCISYaYsLrJ7pkOrOlaD45LNiGA6OKGIRoX3+AGyjCzjr9ybflWZRn5g?=
 =?us-ascii?Q?wgGYPqZtV2gg8RzQ9qrRuJGbbxK1BhmSBq3TMp6xwmBFO6QI4IbOHbBdCFGZ?=
 =?us-ascii?Q?4J2n3lyOKf9UsIAritjw8G3O3Ow4tx0p9efFbhUNACPeV4Ja5bJv5vFqpFGr?=
 =?us-ascii?Q?v0+GPE5c1pdY8MfW7hM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e560c8d-35ff-41cb-0571-08d9d644cf81
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 03:28:47.6001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvpwyQhDn8giC9dc0DOu6ukB7fMkRYS3Q6NgYg4YJ3R3uTK2nb5pq2XaW8uyHMic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Since you use dev_warn, "RAS WARNING" is better than "RAS INFO" in the prin=
t message, with this fixed the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Thursday, January 13, 2022 9:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John
> <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
> critical regions v2
>=20
> Changed from v1:
>     remove unused brace
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 ++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c742d1aacf5a..144176779f9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1309,6 +1309,11 @@ static void psp_ras_ta_check_status(struct
> psp_context *psp)
>  		break;
>  	case TA_RAS_STATUS__SUCCESS:
>  		break;
> +	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
> +		if (ras_cmd->cmd_id =3D=3D TA_RAS_COMMAND__TRIGGER_ERROR)
> +			dev_warn(psp->adev->dev,
> +					"RAS INFO: Inject error to critical
> region is not allowed\n");
> +		break;
>  	default:
>  		dev_warn(psp->adev->dev,
>  				"RAS WARNING: ras status =3D 0x%X\n",
> ras_cmd->ras_status); @@ -1521,7 +1526,9 @@ int
> psp_ras_trigger_error(struct psp_context *psp,
>  	if (amdgpu_ras_intr_triggered())
>  		return 0;
>=20
> -	if (ras_cmd->ras_status)
> +	if (ras_cmd->ras_status =3D=3D
> TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
> +		return -EACCES;
> +	else if (ras_cmd->ras_status)
>  		return -EINVAL;
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e674dbed3615..8bdc2e85cb20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile
> *f,
>  	}
>=20
>  	if (ret)
> -		return -EINVAL;
> +		return ret;
>=20
>  	return size;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> index 5093826a43d1..509d8a1945eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> @@ -64,7 +64,8 @@ enum ta_ras_status {
>  	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            =3D 0xA016,
>  	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             =3D 0xA017,
>  	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          =3D 0xA018,
> -	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019
> +	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      =3D 0xA019,
> +	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          =3D 0xA01A
>  };
>=20
>  enum ta_ras_block {
> --
> 2.17.1
