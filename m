Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC5FC64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 06:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1076010E4A6;
	Tue, 28 Feb 2023 06:18:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDAF10E4A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 06:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaOckoC9YGK36+mBwaX4r4yNK0sHwheIrcLqqKFcdg7dsO4P4PSV1g/gVt5qo3F6Knds2DLAIgbqw/qDhw9wQmfcdi6En0UIfOQMraMnsVyPbTr8jewjjqzxcuPajciYKZB7mhKaTXk1zRdGQhQPEwPFDXqY0Mq0HIYAW5/OPjE/ZY59nLqHj3ofKEu4jA2Mz9Wfm815x3x2ispMVxOY821UfFyZqNDSqkWYoVGQzbLk0QwCq7QTe5zvhSwodrCOGlMm3aG0wxVxy6yAav7RnT+3ZQGudx48Vu+SEkVYBqIYk+3lybdDq8tRRW44H9ZNPS2v1+Dca7RFnD4iKBeIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PIAMa+m+zy/Rx8M3SO1bZKK/mYWY5sYwUA5PuWMxZ4=;
 b=Sh4uurWKuBabUHM/YTAi28kvYpXoGkkQD90kohJZ8dmdU7qbQDLisRcjKzE+Ou1qAYhQpCX0SsyEs9jJCCPDWLRB20tSS1PARGjTmVIQRW8lgHeMrH3S0OWCn5zQSuMy4+TnUzuxAScAizZqubn6ZEEogotZMwdgJfLdgi9KKIzn2A+WxeZT/EIwmzzWEweNjxT6GZzn50g77R3RUO7nOSp8U+FNWoFPgU6VhowGPi34eUkaONJ82LlMHU1vm1uoQGBk8MPm//OyobmAZ/X6wKaNXw4rCI+HJGCjTMLkLGQgNB4+Y4mvLlOAn2ekd66agJXPlwx7S7o3KdU+qy7H1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PIAMa+m+zy/Rx8M3SO1bZKK/mYWY5sYwUA5PuWMxZ4=;
 b=LT/RHXHQ0m3Z4ChGjMf3nvE8IVNxOtGMZETWuVKVCx6o73wqSdVFJ68merGkv+orpBAqwmVcm3RnKyZcPEkikXrETLFG6rFGrzwKGiBSQTyjt0nKfhbA4j5+Pht85nX48n/rmUTzl+W8oqawXee/ltjJoyTN8JQi7Tdfy16yJ/g=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 06:18:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:18:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 0/3] Adjust dGPU handling for BACO
Thread-Topic: [PATCH v2 0/3] Adjust dGPU handling for BACO
Thread-Index: AQHZSy84MYhcxnhUmU6yKlOuveI3Ca7j4VLg
Date: Tue, 28 Feb 2023 06:18:10 +0000
Message-ID: <DM6PR12MB2619DA95E587E8361F255596E4AC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230228044304.27940-1-mario.limonciello@amd.com>
In-Reply-To: <20230228044304.27940-1-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-28T06:18:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=438a6ea4-3f30-49c1-93cf-717b97ec4eb0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH0PR12MB5107:EE_
x-ms-office365-filtering-correlation-id: c5f6b075-95ba-467c-5f0b-08db19539116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMw+xa9O8rpwDUmhKtaYWij9nFlP75nAjfpjzTAJ/AMf50GaoddRf3YEg02ENSKk0aQv+pipAdxxIZTCYFuWzq0rGudGdrrd2Xya5qE4l2JqSiYdh2rRessH5xngpn18LIjzR0ZMm9osOfdILOJHA5TsCQnh4g/4CnzK5CcIVDHL3p6mgyJ5EVur8GyY+cjqIJua+MxqApoZAzBZSvXPZrx+079EfCXr9wIf1XURWUUGGfBIJc7P0+Vm/LU/N9ddY3zsSj2T9TU7Cfqj3iXKjnTpCLopYrhTzLLefv4ua8YYzbhPDI04+rGjEVIIwjOxJH6VEk6ivsFMI97PbmW08SYpTHhQucCv1P5Ro+8ZolYwQ1QnQRbuopFXZacEQl+tIcJi/XQtBfi7g5/2eeJatdg2kGHRLnY02YqD9wY1qKati8v6UkRk0dmf6MkDUw/u6JSWIT2lp1LTKFBoV2/oEA6C50lcmAMWPoX/TVSZF+3tfsItS9nUGC+oP252D5I74drqnuDRJscBi2oOSI/NSKJU2qQpv+bzQymcqx5k+Qzg9qzv5J9nKvl1ayfBktQFIihcwKWEqlutAn7zkvOtfQhOpu7hU7zPSEsRjrxZTl8hCHtjU8CUweHZiUodDs9pUIGkxDSXUclxCR8gEKR+3oMqd0tRxdC7+HOvR4v+0xrhuz/TLy8wkPqgSg5A6C23GUpjoXsW3fZtaimL0aOZ5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(9686003)(26005)(186003)(53546011)(6506007)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(55016003)(41300700001)(66446008)(66476007)(64756008)(4326008)(66946007)(8676002)(66556008)(76116006)(2906002)(8936002)(52536014)(5660300002)(71200400001)(7696005)(110136005)(316002)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?St+92kcv/0OzXFbZSdfyuBz4pxiNe26e/qNW9eLYi7Te8toTvEaMyc8hjgth?=
 =?us-ascii?Q?pUnP2b+H2pvcrUm+8h8jMNt/14+H4BuCKyBxZL3rkat/SCH0VJE4uZfr9ZPr?=
 =?us-ascii?Q?KKb+3308ax4mD5AUY4MNjfGblMjwyYh/VBxitdUlaQWTj20lTxihx7aD3RGx?=
 =?us-ascii?Q?hykcXEMXYLm9zU3uJOFX0oOVOYhkmc0Ss76Blib2aQ47ifjT37EAHErTk84e?=
 =?us-ascii?Q?ozFF45iuQ26CABge+z4cphXrr6OjPUWQ/Ea/P+x/s63bac6LGl1FQ3VGJZky?=
 =?us-ascii?Q?4f5/ZLAYefeK57D4SSNCeMHBmxJLPT+STGX4Xs9itOCy8Q4rhZCdAJ1bSuGS?=
 =?us-ascii?Q?m4N0da8U7jJgoNL+NQI+cccmAibZU3z8BMCzHVsQ+2k5ki67ilBCuCQPdies?=
 =?us-ascii?Q?bHwAZjyPiNKCD+ckOWdp1KZjJhFoZrETjrykAgdLk7Ll4ogYPGLe1rjA0NVa?=
 =?us-ascii?Q?xpLjae6kFY9B0hSX4Eo3nbF90kuNiAQwneKQpyloK0S39GPf7gqJGVK+GQ3W?=
 =?us-ascii?Q?tEVnS75FQN8jWr9YEQx12xwnIAAt4b0h1n+Z9zIWEOr578jORHoS7czj+FGB?=
 =?us-ascii?Q?kZwucs2gW6egphB1NlfkoWdubfCZ6J1uJRpVYRzak2BNYsvIU8E8HCM+D8g1?=
 =?us-ascii?Q?RCkxhAKQLaa1JMCG5gn9oZ1WJiJk+OKX2JloTkoDvphHDQY7Q7TVjjOEu+r8?=
 =?us-ascii?Q?AYgTHRVZSBRAh7HLpoMOC2ihsQlUa0LtVkTSDWFKbAQhyErXiL8Epq2OpUlU?=
 =?us-ascii?Q?4Q39ITiS8PM4aXvqfUZIcDs3Ng6q8pJ6/stHArxAuO4aFguzN2qe6b8AHY2R?=
 =?us-ascii?Q?JZGrgHb4ritGNc+MSMA1jOWXHOwnqPTv/McXWn/AbWWV7as81aQvIiNXN9p3?=
 =?us-ascii?Q?WK/Y81rEBFooqHvKjW4TZ9aEplhrPMRszOJHABcbc3ZeYYmHJoqRZFxD5eSk?=
 =?us-ascii?Q?wykERNGejvPz1dws7uzsHoswHiimHNXWnua4BUXC1DcqyaLWV8619EmxrLn5?=
 =?us-ascii?Q?Dvd4QqUCrqPPZjMNWP4R73pWnWycmE16yw+Yqmfe9IEvt18kDSgJhcJS0mDE?=
 =?us-ascii?Q?V/NqxdL3ewWtJJ6xoe/H6gpm/7Xg9ge/yHN1j8kmIseppiW0kfwQXsZ7NqbX?=
 =?us-ascii?Q?J78jYp1t7Tb9BLboTOsqtnREE75MioVI2o+pgn5/Ht7W4YkjjPC9kEfTYlPd?=
 =?us-ascii?Q?6FOX48ExvHOqa2CN5YJFn3wGX4UyhPftVZ26WL+LHUq8k4EeGQwnyy2QGXxD?=
 =?us-ascii?Q?QNhfSzwOBefTXYVuXnibf1T3SHxCtst0/l+f8gIJ0RtPpZg4K7rdkD/52Upr?=
 =?us-ascii?Q?lvwOkCbNHpGIeJCNuq8orxhUEHSY14q5Is5/MbR2IpzDeNkkbXQUjbZ0hUeF?=
 =?us-ascii?Q?/GxUzyMrt+rFevtAk1f6xWLf2OqBzYf3ED48V9kdyxqcVgKsIHGqLs21IjpU?=
 =?us-ascii?Q?4fEA7bV8FhO5p0wfhLXvzNrPtA1WjU+MAoKmkJnRWHSnYr0GO8Tt9F5XsL7d?=
 =?us-ascii?Q?s4/VQykDn6axcjKU/PLQwqt9gFIQHkF0O2kqCGQZrRdHgVddF4CoeZc0U1Ew?=
 =?us-ascii?Q?usuDmtmyzcgc+noGGOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f6b075-95ba-467c-5f0b-08db19539116
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:18:11.0043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7xFUIYMAZqPhNO90j+UELleNlicEtoIlFUrtMiFIcCGazJY6Djy0xzk1h1ycpVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Cc: Peter Kopec <pekopec@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario Limonciello
> Sent: Tuesday, February 28, 2023 12:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Peter Kopec <pekopec@redhat.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v2 0/3] Adjust dGPU handling for BACO
>=20
> This series adjusts the handling for dGPUs when the system is going into
> s2idle.  The intent is to match the following truth table below:
>=20
> +-------------------+----------------------------------+-----------------=
-----------------
> +-----------------------------+
> |                   | s2idle (no FADT)                 | s2idle (FADT)   =
                 | deep
> |
> +-------------------+----------------------------------+-----------------=
-----------------
> +-----------------------------+
> | APU Prepare       | 0                                | 0               =
                 | 0                           |
> | APU Suspend       | Run                              | Run             =
                 | Run
> |
> | BACO dGPU Prepare | 1 if suspended                   | 1 if suspended  =
                 | 1
> if suspended              |
> | BACO dGPU Suspend | Runtime suspend if prepare was 0 | Runtime
> suspend if prepare was 0 | S3 suspend if prepare was 0 |
> | BOCO dGPU Prepare | 1                                | 1               =
                 | 1 if suspended
> |
For BOCO Prepare, it should be also "1 if suspsended" instead of "1" for s2=
idle per patch1.=20
Do I miss anything?

BR
Evan
> | BOCO dGPU Suspend | Runtime suspend if prepare was 0 | Runtime
> suspend if prepare was 0 | S3 suspend if prepare was 0 |
> +-------------------+----------------------------------+-----------------=
-----------------
> +-----------------------------+
>=20
> That is BACO and BOCO are handled very similarly when system is doing
> s2idle.
>=20
> v1->v2:
>  * Rework flags and flow
>  * Try to do runtime suspend first, and if it fails do system suspend
>=20
> Mario Limonciello (3):
>   drm/amd: Allow dGPUs that support BACO to use smart suspend
>   drm/amd: Don't always set s3 for dGPUs in all sleep modes
>   drm/amd: Add special handling for system s0ix state w/ dGPUs
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 44 +++++++++++++++-----
> ----
>  2 files changed, 34 insertions(+), 21 deletions(-)
>=20
> --
> 2.34.1
