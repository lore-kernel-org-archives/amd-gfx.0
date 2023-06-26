Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803FDEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 17:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19ADB10E08B;
	Mon, 26 Jun 2023 17:45:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7A710E08B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 17:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4icl6wAwoYZJb3Ihocs1Ui702q2EeyTSKuFTui64pSVmwd9V8hXtgk+ldLjMXFVvJLyGlKoKWKemULHPrIaDL/tOlPtk7H7GOU88StZKjLpxItEETR9Zy0T2jyuye7wJKlT4fel8m3MFW3+7kkRuMBd0XmBHKVsI/NdvyZqXyMrS9vOd7BRJVdPWkGuQLVrR6K9a8hE9x6S6iKOF/Z9729Al/t1ecGCctqOF8cuZe9jUBiWXeYNqMV8AXtsrXpIzUgjArpQzK8RsZ4MJUeXyvwwS9bQ8f3Rw0/LRKqkk83C8b5gWa6gFteie5qRThLXIbwLIwA2MSNAC1zepZ4eCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pl7dTN8NOry/ZM6hsX9Rht8jEEBEmjFk65Xk+yQUMeE=;
 b=gxhVDeH6S3dOqqfbviwTuKLuZM/oNdtvYbDaxj5YqHpEeV2+knuFOOgD6PAMXwUXsQdgBWT1WUKg2BSypimAsysvzuXtHznuj/8+c9n7zpKSqxArLna3HL9mYZJkIKGzfWLSvnp/pbYOvaxvHtRbid4qrveM0VL6f1HTFJDsMyExgVkLa5sDuFQqTIZx83b7TBsxumdcBH2ryX2eunhc23ZgmfjEAd2LiS+NJSmXAmJ/9qOCAJk/pUaI/r1eWwmyK6XiK++3usVr+M0VcAjHfOXC3b9pi10vOihEGTjTqFggoB0lblHScLoIvzgaQMCV6/efXcjZqSzFnLQEZ64PEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl7dTN8NOry/ZM6hsX9Rht8jEEBEmjFk65Xk+yQUMeE=;
 b=UetMY1DEGbPYJ29e1+5RMvuxByJx0YMKSTM6ogWazzsBqGdQIgBjLwoRMalCOKkfWvrpsotVL1XDjMB7TQ8NSK/06AmChnU/XpKXS7wVKJkMK6nJiTqH5QPLpu4bzt6lavbnNjGDZ3IZDb9z3EzZWFldAn7BBgshpGbSmEORuAM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:45:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 17:45:08 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/display: edp do not add non-edid timings"
Thread-Topic: [PATCH] Revert "drm/amd/display: edp do not add non-edid timings"
Thread-Index: AQHZqFVj7fsDCxqQZkC6/uubOCxG1a+dWqjA
Date: Mon, 26 Jun 2023 17:45:08 +0000
Message-ID: <MN0PR12MB6101F112F3F93AC872833E98E226A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230626174058.1344311-1-hersenxs.wu@amd.com>
In-Reply-To: <20230626174058.1344311-1-hersenxs.wu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4bcefbe4-2f0f-4e0e-9c6c-64871739cba7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-26T17:44:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB8180:EE_
x-ms-office365-filtering-correlation-id: 8b175c79-2a06-4132-00aa-08db766d152d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwmlVAcjUNuiiR1V2UFZO80nf9z45mHjuxBgDBp57h5fV6pX48IIvyc5mvqwuu7Ttqvkds/ejhMBBbFv51IzxgHvOYZM5J6LxuzlYHUp7vVM3Y+MibyJy52KM1rVAtChngQ6ncZwzV1VSBPeky/HmJ6afHfCkrEcX6kk+pj/hpfNoBOGFb1YzjOB1K+mltHN5LAPCiuQMJRhgLk9Y9jQLm8SQi4wM5wc/3D2rr8LSztcqBheqWHb83hSueZw/aLSf559/Qb4tIgs2+/6K6Whx8QEDGsyRKyvvXueT1605tCTS8X884fI49Lb2n1wlW2SZeqBdc7vQdaYyZuX2i6GbdByuz7yGVAAv2Gd1qHnb++sAOOxDeNGo6LJ6EkxURoEh7VrqRkBe0lqd3d2RfDUbrGqfYyPwOPD7OYD50m4+COfZsaQjJyvSJDD9sS0VWbxt82tdT6JuM5EVwrulcwgFpA6mlI8RpYG0yOF9CcbRnGfrgta6eU65yDSgq3NQ4COuk1E9CtY3P+BKnnH4odnhKnN6LQbnj9mny+gBg10Mzf/zEh40sBhqpg78pSjEyy+eElzVkhsRY9Ae30kHRYv4Tr5OsqNThW6d5uS94T4v3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(26005)(66946007)(966005)(478600001)(7696005)(110136005)(83380400001)(71200400001)(2906002)(6506007)(186003)(5660300002)(52536014)(33656002)(55016003)(76116006)(6636002)(38100700002)(122000001)(9686003)(316002)(8936002)(8676002)(41300700001)(4326008)(86362001)(66446008)(38070700005)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/U4YZMqso7QZiYckoh/KR0xcbbrKAMPmz1zqQiinQQ9RMvTRKQ5T3ib9V4l?=
 =?us-ascii?Q?ro7d05Roip1zJlC47SCgcLSiKhBep1eibLE9BEPevnKSfFvk6RLU8J5gXvF/?=
 =?us-ascii?Q?daCFmuUEUxR+kFQHmTyPVTzntpjgXTlCIHq6YT5f4iRtjmpi245eo1KLU/gm?=
 =?us-ascii?Q?M9TsAVKcMw7Q3f+jIlkaYO+Z6Q4IHZZJL6O8HvHPvENJ48KBwS0J6f6dUzRE?=
 =?us-ascii?Q?9oTC6vLQnvP1cSB2E/J8zk8W40ye2eaCMWo+MsVfGFD4UXiSLdzcX6NDRmNf?=
 =?us-ascii?Q?NRtsWQkBf9P0TbN8f87426DdP8oDEadNiq+Dwpj9gjOaalt+clnK7GZi/uK6?=
 =?us-ascii?Q?N1LtefPHG11x7m/Wr4gH/lAZfT1HHAgJIKEUmw1jq92ZxrOpwIrdT6VX1Bed?=
 =?us-ascii?Q?NUrxBze4Ya68kDkvivZJf1xMzIdzswvH/jxpXroFSpxr8QV4Xj/0aBUS1qpE?=
 =?us-ascii?Q?gnVG58tQn6vnpb22QEBpHFWW2U93MkbZvz6Krp0wA+SjUYsutlnBgWJFDg4D?=
 =?us-ascii?Q?W7epnzk/DgP0rI+0pZrm8buf8M07ryIYDMMtDZTKPvgOrsJzIoIo/dDSlgwG?=
 =?us-ascii?Q?Sf8KH4g8G0LYtDNTjVIRxs8ptnDd+UsRX12Dz5uTy+CS8B6SoFpln6GhMvSG?=
 =?us-ascii?Q?EnymV/faErs21HjM67IMolsT+43jTdkcuVGFA9kR1k6UITXwXoR/sv8U6HF/?=
 =?us-ascii?Q?FwWEip789eNOEOa3IGWCw1HTuzA6VAC57a8ojN4pnU6emBl7zwnqG3fcKXjn?=
 =?us-ascii?Q?mtElUgHQabK6QK1/SiIaRquJKWpv2jLNl5lMG9Va5a9QvF96roCPe2yut6KI?=
 =?us-ascii?Q?oqBuwtzd4Uenf8mardI1L6KjWYMHQWOedbaNV4Nbuf/XXFkVBGXpZO0ju4Sn?=
 =?us-ascii?Q?c71ZGDuaw5dR6dHjig+hOGwojU0agY/mFQeCh5bFzWBr9n8Thb+tNIqy2BL9?=
 =?us-ascii?Q?J1eHRNzuWFMzIZRsEkyyktNU6PSpyOJ225FMYWFyzT/bF6xN9Kg13wwQ+jrF?=
 =?us-ascii?Q?b5R+HJQW2HmGGE9Avf9cKe3whqYiTtF+2aVObzJKR6Tsjr1NhyMsAXiFvuaO?=
 =?us-ascii?Q?J3590h3Pz62L0PCrjmjvgOofGvpTr9AvYTSzBfCLUSwckW1l9lhFGpjdbVom?=
 =?us-ascii?Q?YPmX+2+rxGhHMUcTevPtuPdnyoxaAlc2b4dI4jjjUsYcloNfyotyyCXhYVNz?=
 =?us-ascii?Q?RZZpT1fa4Sko0NlYR1PC9y5/PNLvc9uesqdQw17WXIYP4HPjbQgd7dWjf/YW?=
 =?us-ascii?Q?zDqOebewvjShZ6yujrdF8fUtNdwepmgMGWYceYfN84V8/IIku0QgQwWl+XKP?=
 =?us-ascii?Q?Q1Cb7cfl8yc2Ia4A+8GxW8M/X1FTBe3v9QXesL7m30w9OVErnzAdYkO5kP9z?=
 =?us-ascii?Q?u/p4kHqpdJV/7Jz/GBa1tgBNEp4NpWsEo5siIzGA4dP9sW4kWDy2H4wSkR7s?=
 =?us-ascii?Q?H05kDYhee3DHNmwzlV/jh2Eg+VKjo6g5Mfys7uYK68oTpUk4Q/GIi0eLEd73?=
 =?us-ascii?Q?Wyz6ENBJmLV67lq0PBaEtQHVOwks33KGRNudU9RH1ncNRNd0mI29zpApz+em?=
 =?us-ascii?Q?MI/+pR8PM+PzCfCBlvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b175c79-2a06-4132-00aa-08db766d152d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 17:45:08.1474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4U3OMx2YfMUtVt+9OvpbDvexaxUb54M3gA1dfqO/ZHY63qHy/e/V55dtBGBEbAsehhpEYvC3Ak9wfpBWOgmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> This change causes regression when eDP and external display in mirror
> mode. When external display supports low resolution than eDP, use eDP
> timing to driver external display may cause corruption on external
> display.
>
> This reverts commit aa9704d5127f06c9ffedb0480d2788b87fecedfb.
>
> Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>

The original commit CC to stable, we need this to go to stable too.

Here's some tags to pick up when merging.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2655
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a46b8b47b756..073bf00c6fdc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7258,13 +7258,7 @@ static int
> amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>                               drm_add_modes_noedid(connector, 1920,
> 1080);
>       } else {
>               amdgpu_dm_connector_ddc_get_modes(connector, edid);
> -             /* most eDP supports only timings from its edid,
> -              * usually only detailed timings are available
> -              * from eDP edid. timings which are not from edid
> -              * may damage eDP
> -              */
> -             if (connector->connector_type !=3D
> DRM_MODE_CONNECTOR_eDP)
> -
>       amdgpu_dm_connector_add_common_modes(encoder, connector);
> +             amdgpu_dm_connector_add_common_modes(encoder,
> connector);
>               amdgpu_dm_connector_add_freesync_modes(connector,
> edid);
>       }
>       amdgpu_dm_fbc_init(connector);
> --
> 2.25.1

