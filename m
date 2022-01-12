Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBE8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 01:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D57510E255;
	Wed, 12 Jan 2022 01:13:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1958710E255
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 01:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msB9EM0BwlwiS3oVlTaIfaR7xghRWJbFTylG/TeZujHL3aY4JS1Arn+CZPBL6Q7vBV6hpB5kWDgpxiqvD1Rse2AgCXGKseW+HAAyGdI/GzMjqw6wv4X7lJhwzkNXxT9xGzUSBF5KrfufDMtlvCOkSOUKMN+I6yqFqGnMOjcMvWREkK3LHd5HQkoUh5fndl+sT0Gdspn4bAC0xW0mvOfqsKl7oVXK0irovLPzgFv/XZ9ncAW0Y6j4Ke4tcUhHQYah/ARHX0czzdBUZQHNUt3rfEDwqhPVpxIT7BwcSJ6rJNbpBfoTW/qwopDU4EeDQSUg0WDK8yF4do0yM/p8XAnF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkbtiB3Rx5DPWxLaWt+mnorko4ESjyjTe89gvVzIUow=;
 b=keYGnfg53UKSle3PRcZVdeudKLn41VIgFoVvAvZC9n8DtoGtljvo/9/U0fqtP/LO8lOE94nkNOs1zfF/S3ZzuXJokJh+K5yhe1M6Kmv4agMLEH6rnChaIKO0fUckPnyrNLS/qGfTIkQYUtM0TEaZsHMM53bo233mGNqJ5WXq5hnkDjXC5Zwd86cH7vWQUGi5xUCzG4puw+brKHCDYIpgV+RZUU1esTdBZ+HD6BtUWro+aZsqsp5g4IbA8jAtMivwvncCyBYwYs4gIwOj/LC41J6ZnXBiI0l87j30OiRcuW3g4cnT5ofZ+dtClDA24FFE5PJrM37pQZNW/ynKjTOAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkbtiB3Rx5DPWxLaWt+mnorko4ESjyjTe89gvVzIUow=;
 b=26e8JIP2wFiViCCWCJTaYR0+u6wiZZPabFIt7LV/uxEPOYrqHAWO1z7wQc5eQc6+DfBJz0SG7+pR5LBAgAS6IZmKLxfD6iWdtuIDcEs7gH+MnYkAAFY5cSUerNkGx31azU5GMlo4zjqXMmHmbJIbXDXxY9YzuTONZfbhsKSGgsw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 01:13:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 01:13:53 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
Thread-Topic: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
Thread-Index: AQHYBzz8vYgv8Dt2mkmHH7J6VRev6KxelM6A
Date: Wed, 12 Jan 2022 01:13:53 +0000
Message-ID: <DM6PR12MB2619B1D42FB73BA88DF6FFC4E4529@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220111224525.3090269-1-alexander.deucher@amd.com>
In-Reply-To: <20220111224525.3090269-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T01:13:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f924696c-ddc3-4f71-a0a4-eb8640772491;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87ccc51-2e72-467b-31c3-08d9d568ccc4
x-ms-traffictypediagnostic: DM5PR12MB4678:EE_
x-microsoft-antispam-prvs: <DM5PR12MB46785CFAE0D2F953AAF15444E4529@DM5PR12MB4678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obH4KU9ciT9pwZ9bTZ2d74uLCyuk1CnzoxPgcV8KxPY/jzsIWyDtNbrwilpYn6XCmSCQy+/g9wPNeA4vnM7qUXteZ+R5JtlZkmrbvyk6dFFNtrTQ3xAGbU6Qp+xRVrIpVQFQEzGY3X28ZzTyODr9hEgZtBDCNicF77QCvjzECu0KC7380SCkShooH6B/Q2RHclIS8rxBlqAVqY1962r3mm2gZWRk4bkwEhOqECgJc5F48cljZQVdZ3u954p7CFlOc+5pd70vKDgjyLWfidKdAm6k7SGd0U+FVsq8OStSjR68y93GWw2HXJP3B2AspaYGq6nl+djMOHBRr6WnPFMrHFgmha5wHUiMmo9uEIyg3J968o0YuKp5FKL8WJsHt2bI3lLpmNBjrUrUDW3ZSeQxLXQ9w0hRGLpzBZ0OfjSQVHG8OpmcFx64vDXNbWWsI+kfseLRagUsZ+oUoq88Qlc77D6/knDKLMN0dZO+io6pjAgl50Dbz9gAdtPRpHIuV4XWGn/Bh6QUlimubc0Bb0c4XpEAIlqKr4zNegVD1X+7xQcmsKr7fo9+8qfJnOmQVaVqxHe47kXJ8DsFMmYMjhYvHKAcyE+vBLPiH7i8yTMAGxF7paN6wL/MqLYVlW8+7ASmQ8l/ryPU+K6fwE2M8lIZEkdIcO+kXkasypmYkuFUDT54ul8N/RP4j5VhSmUz0vTk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66556008)(66476007)(71200400001)(64756008)(66446008)(76116006)(8676002)(52536014)(122000001)(26005)(66946007)(38100700002)(33656002)(4326008)(5660300002)(186003)(8936002)(7696005)(53546011)(6506007)(55016003)(9686003)(508600001)(110136005)(316002)(2906002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4QzEWCOg4Q6I2iuerxlLl3/eG+OyvQUkfIg1WRsdaLvk9bi5yRqcfJbfXjAu?=
 =?us-ascii?Q?uOR/5Mx+BsHuecE7WggXd/hud1lflSntJoJJAq0NfxS4XL1YdZtwlbC8HPoD?=
 =?us-ascii?Q?gtriFBW6K63OBDfbr8wxW2WDobqLxwmNglUET1VgNI8TbRlKXxLeAo/vLPdh?=
 =?us-ascii?Q?vP8bo4jHYHF0dUdrVg9L69oPwDL/4aeOoiVjuV6Obk+xd2BnfvzvpejPpI/G?=
 =?us-ascii?Q?zLcE4hR8EOR1U3rsNsWfesxMGJRzXNpBkqPMGAVDulV7O7kueqN/BNpAKpfC?=
 =?us-ascii?Q?vhJ2S1Mh1G7RdMTKEWFGViSHP462gujBp0jYNkwLFcrmHdtXLn+jRrTRrecv?=
 =?us-ascii?Q?+BKpiZv9AU7XveAIlB0hDfbav2Iao4L4UUB0rWGjy1BrR8Czp6MhkuYb4xmG?=
 =?us-ascii?Q?akwRNumCnUKYjoNAMJLA8O/TmbNBndQK5dlUvM7YQmOL+iDPiK9G08Rw6nmU?=
 =?us-ascii?Q?NKRh3rZU2SfeVuI1EAjLEB+wqAu/+EDfDqucSsihU73frnFDEHjZmRmCENQr?=
 =?us-ascii?Q?Bi/UP0i7smvTMFHUinsYHBd85PHlTEpbWAU/LbkhEdYXVyqNpO8b1K7lmSZk?=
 =?us-ascii?Q?mslKi9HS7n8KVkxRaVNO89A5SAVcqSjcgQbqp6LwDxKmHmJ1Y4kShWoWFqaL?=
 =?us-ascii?Q?OAVKY8YskLud7dDnRQvVKoFuiv0qw8drxk714AXkxs+sTm3bYLXmWoDlDWhV?=
 =?us-ascii?Q?CK5YpdZbDi1C7ZBg2eWp5LsZJ3tSwRTlmrh2suwQBXY4+kLFa7clcr5Jarc0?=
 =?us-ascii?Q?iXEybXlrYOnq6CzUSS8favhk563vxQGt99CGIUJ3USlmgDfEt1NlK6z3e6cv?=
 =?us-ascii?Q?JATUck8tMKWHbUah0RYfgjxRQLcEKKjOz9uK3W8uc4wtzteZOF+ko2XtHaOf?=
 =?us-ascii?Q?v7MK/kBfXD6D/T7+7Z5r06gaMAHlMhLBcJg2HpJl/1GXh61Tbi65dD9f+IE2?=
 =?us-ascii?Q?YJM6rO+NUZmb5DK+dIgg3MhPMTpgi+r9xEMZFfhKJrm2u861LOczwAx2gChb?=
 =?us-ascii?Q?KRAHjMWoW40fofUE/1YCw88FKRd1s4o4E2ldeQlY+oF//3PgpocGqhNhbqNT?=
 =?us-ascii?Q?ApndKTTtRGI9zBBqVmokpwRtvPyZTEJdRaBeD96HX5FupsqlU94YEqSnggmg?=
 =?us-ascii?Q?ErUoXa9n0UC/dOwcbQoc/Ne/4qGtBLu3gfKGAAf+QKoxrfdNUCGML3QDJJfI?=
 =?us-ascii?Q?RWXnizARCa8/A4c8eXXcXDLDmz4Z/7p6UBe8OmM5mRvvF4iiyGo7I25CjkUu?=
 =?us-ascii?Q?NFTOIObBQuu/y31vaDMY6eDLjNReM/nigd9TkT/Dm2g+OPMCdRoDIJ1FVKzs?=
 =?us-ascii?Q?Tnd3TquTqsMXyACoeuSUOY1olOcsuGyTv5C2j6wQeqAyifZhFTl4ewK2fdNo?=
 =?us-ascii?Q?G6aPSxp2ueLy80UqraFLNDfiJBo3oVGvu2PdoxKCvtyGXpFeoDzI+dUpCG7x?=
 =?us-ascii?Q?4vOfLqjlx5f9KJWgkX2aZcQFGMwTFoDAfWB41wSOPkBowlTtiRvLK+5oM0Qz?=
 =?us-ascii?Q?V17FeR9EulGXul/TvPQzb7LSUHnKNee4KbuZNxqKtH0ZE9XLz8PyzhedNKYb?=
 =?us-ascii?Q?BzTaIXhijq3shkKBqKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ccc51-2e72-467b-31c3-08d9d568ccc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 01:13:53.7579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbFmBR+JKNaM5MBzukMxl0OZ9lxjNqn830zexedPpY2KT8PgBbihXmevdr/XhHVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, January 12, 2022 6:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: invert the logic in
> amdgpu_device_should_recover_gpu()
>=20
> Rather than opting into GPU recovery support, default to on, and opt out =
if
> it's not working on a particular GPU.  This avoids the need to add new as=
ics to
> this list since this is a core feature.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++------------
> -
>  1 file changed, 17 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f33e43018616..32ad50b86248 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4453,34 +4453,24 @@ bool
> amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>=20
>  	if (amdgpu_gpu_recovery =3D=3D -1) {
>  		switch (adev->asic_type) {
> -		case CHIP_BONAIRE:
> -		case CHIP_HAWAII:
> -		case CHIP_TOPAZ:
> -		case CHIP_TONGA:
> -		case CHIP_FIJI:
> -		case CHIP_POLARIS10:
> -		case CHIP_POLARIS11:
> -		case CHIP_POLARIS12:
> -		case CHIP_VEGAM:
> -		case CHIP_VEGA20:
> -		case CHIP_VEGA10:
> -		case CHIP_VEGA12:
> -		case CHIP_RAVEN:
> -		case CHIP_ARCTURUS:
> -		case CHIP_RENOIR:
> -		case CHIP_NAVI10:
> -		case CHIP_NAVI14:
> -		case CHIP_NAVI12:
> -		case CHIP_SIENNA_CICHLID:
> -		case CHIP_NAVY_FLOUNDER:
> -		case CHIP_DIMGREY_CAVEFISH:
> -		case CHIP_BEIGE_GOBY:
> -		case CHIP_VANGOGH:
> -		case CHIP_ALDEBARAN:
> -		case CHIP_YELLOW_CARP:
> -			break;
> -		default:
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +		case CHIP_VERDE:
> +		case CHIP_TAHITI:
> +		case CHIP_PITCAIRN:
> +		case CHIP_OLAND:
> +		case CHIP_HAINAN:
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +		case CHIP_KAVERI:
> +		case CHIP_KABINI:
> +		case CHIP_MULLINS:
> +#endif
> +		case CHIP_CARRIZO:
> +		case CHIP_STONEY:
> +		case CHIP_CYAN_SKILLFISH:
>  			goto disabled;
> +		default:
> +			break;
>  		}
>  	}
>=20
> --
> 2.33.1
