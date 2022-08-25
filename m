Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D29C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C6A10E013;
	Thu, 25 Aug 2022 07:50:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9054210E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZGaz70KJ/xepXMei3ZOSaqsay2R7Wq/o9jxEuCLIKPjEAY9Ww2qPzhcfwhh7MrO13jUmyKvTchwrGzLHtRS5s/C3oanCOvigOESTM/tLFj25TI05Ob3jptve5uAlGgZ/UryrY9YF/NrZ3osPd3NBTe19bSEaYOh84vYo96BdwMaMzYWeOl10N95X4DoZ/rcKfoYmwmMGfqxMMmqEtm6BTY4KOBwAiZMO/ssJDZaYI/PEgzY3UQiM7kG9gQ0B04CHKhyUWFNSp8M+YFKH5DzlL8oN3mEc7gCIo3Oy5tRwGe1zYHVD7dLvgUUZqBRiI6eoW+0KZyjtXAJKFqrz4rzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KmOojvSiCgNCd7sSy6ybym1flk4Wc5UjSoKcALhv5I=;
 b=ly4/FPB8KKeknLvvnMgNAt1hISTGgqiJrDAhkS2gXpu4lfFfaMUgR30uA7lgw+DqXiHzebwEH0f0dF1FLAWizasLLo5M0cmDuXlloWuLwDcEd8EmThpBnWwgqd2OYdcwwYlEmKXiZMk8q1JIi/YWY7Sp5w0NbSte/V4gH4vhkNbIA5nrbXUbvzZc1FoAKILSDDq3MH3qGptwT8lmHag/4W7Y0Ixr01uLghIcjtcZyRHNDFkVuEMrBQSiznBSa5bvrn9Cddu5ylcCqMckzuqVXtCsNk43DeU3WFxIiSW6rDM+LS0bDJ1A8ypzQrM0aWS4uTJBZVvadZRGVW9ApqsAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KmOojvSiCgNCd7sSy6ybym1flk4Wc5UjSoKcALhv5I=;
 b=O5tDT/7SslojreFeAd4nIZhqgOWB7560QranYqq0djSEu5H1xcG2D4GQlyh8qVTUlgZSBIpTs/Q2y5NQANy7cEVEHzQ/7+/DD5xxtRT2gmASmmqO1aHm5JJJonmIstlP305YEE3csUnd006VEGVzqpUkFFRm+diWaPagqg6tBJU=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 00:15:19 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::5576:6164:80cd:1f11]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::5576:6164:80cd:1f11%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 00:15:18 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Topic: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Index: AQHYt4SIQE89o3rhGEaxEnyih/49da29/jyAgADCCnA=
Date: Thu, 25 Aug 2022 00:15:17 +0000
Message-ID: <BL1PR12MB52378253F334F7CFC0BA71A1F0729@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220824064048.2581639-1-Prike.Liang@amd.com>
 <DS7PR12MB6005164AE7FD86070B2E545DFB739@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005164AE7FD86070B2E545DFB739@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-25T00:15:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=99420bb2-b49e-4600-8d74-1d73e2a752b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-25T00:15:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0ab5285e-b5fd-4868-bbda-8e5f3e585137
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c54aa9f-fb72-4c17-d6c6-08da862ee417
x-ms-traffictypediagnostic: SJ0PR12MB5406:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1IsHp7WmF91/YUHAtHLZLE3fKjTnqCB17rzMZFBSA8AXZAISIV872a9oyYUSxsOqYImY157YNZ0Ja2SpCTUqpdQpT5TCZe+4SVtU1cLsf8w+RdRqOYiPIyfHQSuUs5BbyvzbYyf1kwWo4eZ8U3vMV+zXHM7ylnUt0F7xhYjEf4sxExGxvVK5nUI+1G4Rt+aogqMkSmtSWiJ+br8EFR1cDN+UOjJOAUA4uSR4PBYzN+SqVjptNe77j+sAxCP+iosSFJZUEE/oFB+z8YZKnyRcW7I00Q65ondhaXXJXa7ASYsWsYUNH+vtkXwaPvhJaGOkBVuLIUP8/8/h3dylR4ULqn3Og8hQKDYEWaKWbzj4it7c1IuNhjVhlVpfCZOSiWoDkrnbtyk51Lh/GyoloS61bjAk9LiHqdSjib6ya8k4yv2E5WQNKWr41y8lcext0phi92HQK/H5ikX+wNVEseFyJk8twcT2DernsnKAWqp1gQiLa9XFM1jQMMEvA1QJgUcvVIZWzwwFCYKYMB0ckquxmW1paxi3GcLivpel/XKzM4SzZyafKXuXo7zEpywVk0MenrLMwZdGpYtuBWoHz7HY/GJN5k0liFo6xmfJxRYN6kLGbBY5Z1B4CQIwX+5jhWJh+UJcuXlzmy+HgbD/T4MJWcvpjKblvPHkba1E2wEw1W6Sw7BxXXtsvh8VsJG1ngtlk47DL18sf8GGuRj+epqDB+wTxzclF9g2Yaz6GumEdBP6iChnJEpJXm77xpgGCiwd0M5ZbSMa6z1kDAYmd5j/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(52536014)(316002)(478600001)(5660300002)(8936002)(122000001)(71200400001)(66476007)(64756008)(38100700002)(66946007)(76116006)(66446008)(110136005)(41300700001)(54906003)(4326008)(66556008)(8676002)(53546011)(186003)(83380400001)(33656002)(6506007)(2906002)(26005)(9686003)(7696005)(55016003)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3e8QtOX05Ut4vXhyoTn6WCEAxVUVCJPHh5ZTdcztgMW5XFhKJ0jYy1Q9A1jm?=
 =?us-ascii?Q?xFci8axd3Ga0VvNYTVUTeZ7q/L5/3cAo5JFDNZsqFtrTIgEMgMmKiYV+LQf9?=
 =?us-ascii?Q?8SlEOHTyeDA6iaBhcKs6coGoT/eCap8gDT7PG1X2FlcNKxwl8XJMf5AVQc01?=
 =?us-ascii?Q?5CuhGHRr1xKCtHFE/dACO+HG8PQusdP7ME7G3p3m1y+1VpFqOElYfdNeOIWj?=
 =?us-ascii?Q?N/kpFafQxj+LGQ7OwfqpcIU5gl6GMkhBNI0Ce3QNqrGDWA/0AqZr8smlm8mq?=
 =?us-ascii?Q?LqiMKP4kApT+DXuJxkFn9fPpb28HA9ojKzBG1aK0KlQCvvi69euon1rqyLBx?=
 =?us-ascii?Q?fkuMIegUYxr+iEwQdcNauzMomWIw3+XkJu5/ufCWTEh4Q1E+055k3VW/YlpB?=
 =?us-ascii?Q?Mb2nXd1bl5gaXbWZDpT0aZX2S2Wh10D3vbPQAuiNNj9RpipoWDwOMnv0rPIh?=
 =?us-ascii?Q?9bWzrzlWe8h7fYEVCQoAfSniD0AhxOwwUtOGlrolhtqubv0+5JCzphjPxXDr?=
 =?us-ascii?Q?4QMfgcSeHnC/QGKZiFQ/OOyDGghkogRGqCpa1X+8dXIS6DSoNUMzHuxlA/Zl?=
 =?us-ascii?Q?6TGqbSvwnOdfgEC41dBK3qye1DT5UoiKzEQc9i3hmF98kP3qw8oQX1iCK9Qi?=
 =?us-ascii?Q?jWvUvxkWHfuVomJ/MwE+3Froxy9L87khE8Nx5hY2qOz2FKEH6HEQMnidZw2v?=
 =?us-ascii?Q?TidsdSU++EsVOUSXemrooYKEUrNUwE34CoTGwq86gMnr5U78GRuInz4+DWFh?=
 =?us-ascii?Q?1V8IR0DChrTu4X6IczPTWc6OPAHEpDB/hUMP4xOMwoXjL7/b4qjEA/E/SkEB?=
 =?us-ascii?Q?AHXdZnZHh29JqEmfdLIaUD++bLsQOSPi9g8AJbAF3YiWQ4GM6clshE1eURKT?=
 =?us-ascii?Q?ouuLzY+JzfuobyvCRV4kifApvDot7VKULwwekkhM3a2Fo9/PKZMcF9nz9h3t?=
 =?us-ascii?Q?hd2IDPEg7kikGj705y1BKbXHWHph2IMeKupr/qtrdD1ZdFWPTGLBEFSZQlZv?=
 =?us-ascii?Q?/BP/dXTmD/Dm+gZ0xCZ8uusauDSO1XyF1TN6bljwzB1aGcjgQAsseSTWhYJ6?=
 =?us-ascii?Q?E6rMul24guz5nRaPfGGx4NZBVh/w0Q7Mpi+KAH+y5LU3YtjNDztMIHzosIfg?=
 =?us-ascii?Q?vPty1YNlep00P7FzeiviRdnqAfEhgxuY4RayfH2NQowu4/aQFighN6528r66?=
 =?us-ascii?Q?+BGsBDIAB1lZHqL2u2uCSAZ4gzj7IUp1sIHn7FZQVTugWm+6NYpmquaVNHWA?=
 =?us-ascii?Q?84s3c5aSmmXW7pPiyH0lmaP1fyN1TbdofVWIdnllDTnWk4s5JdZw+5qwxHUF?=
 =?us-ascii?Q?1TIIeYRLFHDPTilhVb+t7sWQx7AbftlvMN0NuAzdSB81jIT1M5NDDPprXIp0?=
 =?us-ascii?Q?wBOvquRHY193kQ5co+2x7YE5aUv4wpeuNY28XPJZtMXl8g3kR9H4BOHOuNpf?=
 =?us-ascii?Q?Wx+n8yCgi5Xf5LTXsqZuNu3k3A4SZNfwL26PlQXUEM32OVpJ5tpaM1VVL5Jq?=
 =?us-ascii?Q?b7OM+Eo6NvJw1s6/AwjrPxecsd4OgJlxOxhi0uQmjkAbdDPWiIl21w9sU/d7?=
 =?us-ascii?Q?GVqdMgDNkXsqr2TBYwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c54aa9f-fb72-4c17-d6c6-08da862ee417
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 00:15:17.9419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCzrFljiztccvmxHc6IGtUpS9oMYfFBMSgbxPxRVVmtN+QXlDK/7K7fVMhqP3vHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, August 24, 2022 8:40 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
>=20
> [Public]
>=20
> Add more for the review and awareness.
>=20
> Regards,
> --Prike
>=20
> -----Original Message-----
> From: Prike Liang <Prike.Liang@amd.com>
> Sent: Wednesday, August 24, 2022 2:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liang,
> Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
>=20
> Correct the isa version for handling KFD test.
>=20
> Fixes: 7c4f4f197e0c ("drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD
> definitions")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fdad1415f8bd..5ebbeac61379 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -388,7 +388,7 @@ struct kfd_dev *kgd2kfd_probe(struct
> amdgpu_device *adev, bool vf)
>                                 f2g =3D &gfx_v10_3_kfd2kgd;
>                         break;
>                 case IP_VERSION(10, 3, 7):
> -                       gfx_target_version =3D 100307;
> +                       gfx_target_version =3D 100306;
>                         if (!vf)
>                                 f2g =3D &gfx_v10_3_kfd2kgd;
>                         break;
> --
> 2.25.1
>=20
