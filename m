Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E33C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 19:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CBA10E245;
	Thu,  9 Dec 2021 19:03:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C21C10E245
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 19:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7XtgmF+JZolXk2q42ZQ6TEwHUUYKVcPc5eHhQce7fUQr1PWKkh39olUCPN1ixNGvPN2ja+zOGATyQ1LmI3z/niO/7udhWuBKsGMGBCf6FnQ5QVnPbyha9zTeobX1TkHVcpGcryBOM7ZVSZVfLmKoeBf7Xo4IvSzaQ7m351Z4jf4kLgvb21nkvyhAHHLcbW63yqeTxs+BMMcQR9GFAlXdV9K95p7iJfT2m9ifs4T2ytMxN4rDVxQWIe4znG1wrOj+7ZcyKioJExK+pBPC+Uhxu1iXcVne3SoaNNcFy2idYLe7us5sS4QQmYWKkuo2tuwFvQ/jAOMMuC10eQFc6Z0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pga2IjH1wmKngUXjosRcCaRVe8IW8sE1moA0n7B7rCo=;
 b=nPlfJvsjZBS7Uq/F1HMU4Ikv/yahR7xDuQx8xRTeMT1NPs79ZJ/a5knz63/9Uf/3Blb2xy99jQWFPOXWY2vJ2Dt1NnA7FUClTpf6gOJ3yDlOZOmSFP6Fhr8OiMP0+wjJm5t6A6MvCm0BpbV0oTa1FRqXADx7cludrqysJ4TJ9EmNezU55Gjw5h2VSzIBRDivEmUpSESo3NuOzdwtOSKS4m2szmYtDZIWmALz4u4aqvTUeKSVYHgzovC+Cb0XuQk0ttxwEUIqpMRdc6R+qFxcl3Ex05JmTEOVR3toDKA0UPuKQxVcL43g/9S3jXxmarc3Y3NLsku9f9Hamd9D3XCN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pga2IjH1wmKngUXjosRcCaRVe8IW8sE1moA0n7B7rCo=;
 b=zd80j2G3rDHe685SU1JvfskgUQz76cxTX4ZWn4NJ8AmQA15IKzSS6jUSFX7ZWZdDK0O07zYR6jCJiaIxEURGYVQm/So3pWMgCkzDH3TocqYapVVnKMOxf0j1TXii+nwkGbWPSCpJQ/dgvEtybD7BzdvfU2fZomUPLQWoLFzuoaA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 19:03:02 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 19:03:02 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: add Navi2x to GWS init conditions
Thread-Topic: [PATCH] drm/amdkfd: add Navi2x to GWS init conditions
Thread-Index: AQHX7StVNCjfYtSEykK0Bx8YpRim2KwqhD3Q
Date: Thu, 9 Dec 2021 19:03:02 +0000
Message-ID: <DM6PR12MB3163969E9E0CC232C7C4804685709@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20211209183230.3564248-1-Graham.Sider@amd.com>
In-Reply-To: <20211209183230.3564248-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=48f1c79c-7434-4e46-bb05-e4788b52fb9c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-09T19:02:19Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 87eae8de-83dd-47dd-b5d1-4e36de4b5fa8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8bef118-eb99-4fb9-65f6-08d9bb468620
x-ms-traffictypediagnostic: DM5PR1201MB2473:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB24739E6E7FAB7E54D13D2AC385709@DM5PR1201MB2473.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJFEIbrQ8xnM8aB9ASFKkOdW1EIKp6jp7tqLp2MygGEfCWh8KvqUJpMhyN0plHhAmISFFVHDjTctf2o2MHS5PpcwyF1/VHyRx2nrK5++jYdYFas7NGeakClqtpbLVmlQ//j57b1KviUcGxHSa50eovK3MeaSaBeBFbWlqvOF6szlofjR4f2k8bHCRxgfHjmxsaCdi5dTCmkBBvwJiFGU91V8ajbpjCvZFwgmKROu/rSGcD+x5BhdudDP4g64WiIfHnyxrCKZ1HyIYbt6IgF7yCwCscnmRcHvi66v+xheqMdYqGn6fInxVwXoHO3aBjapEuCkZORsPsVn6VyOzHLsmdzYe3CuhLP9dQfy/7l66o8DQjRtEl9wIQJVF9JQBuxYg+XdirZ1lAoVEBhGDp5wu+PRqeB68xcmJ2B80JTHX+Vhgq0aVwHk6v25umGtc7ByQtnLqThbaMRfshCExA6P36kLVw7mFPiRE7T6yPrZzu0XNQXEEHSuZz/0UkYCm3B0rHiw7B2BRZZlD5ipt6EAC/aEOpPgrm4RZpmTyvQuQvvrd1xsm6hCvSWlp3ZTn9rTf41XhQlD2M/KOdCoPY/082hKq4e77P9iJee83dFXkJlos+6DpZHmkzTu1diL+zagRdxU4XdQNpSZim9qws77LDhuyGfLfSIqrj8pop2LGiYACqElkJNbU3sS61IM4P640sDZhUqyc/i7GHFfJrIo7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(26005)(83380400001)(33656002)(8936002)(38070700005)(122000001)(5660300002)(86362001)(7696005)(52536014)(55016003)(110136005)(2906002)(4326008)(9686003)(8676002)(66476007)(76116006)(66946007)(508600001)(6506007)(316002)(66446008)(186003)(66556008)(64756008)(53546011)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fq5gUA3m61ZyhDumI6D7Peh3cu2Dd9EBj0l4fZBJvwT5+VtUikU3JZ4tper9?=
 =?us-ascii?Q?piMg9TtC2/FOSdEqIhEoJwDx74r6Snhz6luDrO65nN+b6hpIHyUhNQxCoPfT?=
 =?us-ascii?Q?K4WcAH18fp/leKn3UekMKSdfP+thRQmx6QUQE2naBUYXncnwZbmrd4rpm1I+?=
 =?us-ascii?Q?ZAb7EKIxMVGFeK+UQTSPsqq15PKzokSze1JOClrftdSzzgHefAMvOlMp4Kjz?=
 =?us-ascii?Q?j9kLRDWDMU2ioCsDDQYGPTgHENPv6R9dI4OZPtfN6CWZ02BntqijZeZJ7tqb?=
 =?us-ascii?Q?vv/eXmcucGfbXHLjk/dcwrqIZI41moIKJ7fihqh9yGRdDsbnCb+pfxFbS4b7?=
 =?us-ascii?Q?7euu9MyD0G2ECpYTdfwngxmvPRybL8Or67D+h9Y+s+lWMep795cdeL3wshKV?=
 =?us-ascii?Q?+gQ3TRn+AJwDY//jZoJaj0q2pxx5V5v4Wo/kZ49HrXDNzqWf0ohSo4u4M5gl?=
 =?us-ascii?Q?sjBM96iqUoTaZXLlCnzeQYs9X0WQqmn2AqMwWGqMB3z1pd92hBZcmCiCs8eC?=
 =?us-ascii?Q?C4RkBXySxgKimmveqBSDUn9XIheGyp+itfd6Rbbl0WKpOCIcQTJNgKbidibf?=
 =?us-ascii?Q?iyB3O0soyAKx5p5il1HVcZfOnoq5cz/H7wQIXDTBb01o1djoHGQ2LH1RfO9x?=
 =?us-ascii?Q?tihQyeHU+srImMkBVgdl2U3RCobJS02Jo17zehdJt7RcwUVITTadcXVg4Mgm?=
 =?us-ascii?Q?sjSWhcogQI0HVbrSGptvTmj479BF8REcY2+yvlAAeHSjDnETf9Au7pt4SNGI?=
 =?us-ascii?Q?OzDvt8/NSH1mxKUTtziBT1gmGcLYJfnU3yPUgJ3Xf0WoEq2V7EeiXNfDhSy+?=
 =?us-ascii?Q?aVQhQ4Y/H/uTH8HXoq3kLivR7UoGdbFTOEVH6Tkx9LNzK7zhIu37qGYapDDF?=
 =?us-ascii?Q?lEh1FdLY5lnFc0zMq9DNyu72SUHK86ySBWdenHUD1OyhvjsLZfzgH8Vl3hCe?=
 =?us-ascii?Q?jkevD95MAmHwAw2jR7sJy30kKY6kNcgKOaowqSEw8+r/TKV1v4Km1uuaPoOO?=
 =?us-ascii?Q?lLMRIdHybND+nEFeAg4lCG1EmIuhDBIf2NgJ1XNM63jyKwxw9AYzJfZKyxyX?=
 =?us-ascii?Q?VG92WEO7lcwcB+bgHYbk46QIosfX4AVJCZoLdimMDziAit/BXHXBVPMwFMs8?=
 =?us-ascii?Q?mXXyU26ao1uJEx1KoNYruPa+zik9UxnPWlD0o4LV3REwrdXgi4EA7aSahfMO?=
 =?us-ascii?Q?JPav38+I9JWuxv23D29xcgkin6Zi7b/xstELKWufib3d3ZNYMrFg2O8J3Fz9?=
 =?us-ascii?Q?wpoM2SO9nilfwNnl5qXxCREe66MPfembBVraB+u9qXaIzx7Ua2z+xo38JlYk?=
 =?us-ascii?Q?1QszlMlD2MOK7gYHZdXrUn0hiowKFKCMmFbkV2rq8XtCUhGrNVQvN8U4fHOt?=
 =?us-ascii?Q?Ywb34zN94UIcfeiZ/KbEmzKL4EtJpiyEJoWZ7G8oRkuyDUboagBpcAmQYeZW?=
 =?us-ascii?Q?FdEqIo7Ae6qeMjG8MBJa47A15BI8AoUbq6JMwtFCy6e3AhJQQiybzDPBT0T1?=
 =?us-ascii?Q?f64jcznyY5nrwktOZIcl6Mf2WO5WJR3qiGLJ23DEsdA9Z+C8I25EisNNS4pz?=
 =?us-ascii?Q?vfb7EwNXNju3+Bp/JEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bef118-eb99-4fb9-65f6-08d9bb468620
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 19:03:02.1385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZoyKijWjW3fFk79a1aibr84sn7Y80qUNveMGL6z3vXSXJPBCP5aOQc9sB+L2jiq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: December 9, 2021 1:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Sider, Graham <Graham.Sider@amd.com>
> Subject: [PATCH] drm/amdkfd: add Navi2x to GWS init conditions
>
> Initalize GWS on Navi2x with mec2_fw_version >=3D 0x42.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Reviewed-and-tested-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index facc28f58c1f..67dd94b0b9a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -368,7 +368,10 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>               (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 1)
>                       && kfd->mec2_fw_version >=3D 0x30)   ||
>               (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 2)
> -                     && kfd->mec2_fw_version >=3D 0x28))))
> +                     && kfd->mec2_fw_version >=3D 0x28)   ||
> +             (KFD_GC_VERSION(kfd) >=3D IP_VERSION(10, 3, 0)
> +                     && KFD_GC_VERSION(kfd) <=3D IP_VERSION(10, 3, 5)
> +                     && kfd->mec2_fw_version >=3D 0x42))))
>               ret =3D amdgpu_amdkfd_alloc_gws(kfd->adev,
>                               kfd->adev->gds.gws_size, &kfd->gws);
>
> --
> 2.25.1

