Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D57C4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 16:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F6D10FA7C;
	Mon,  5 Feb 2024 16:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYmcPq5l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C561610FA90
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 16:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkRVTxz1ywDDUkU0V4nXI6GeWkGPsqhW85lTKL5vSgQ1kgR1EX1U84SL1yHnuLARe6BmMXYj/AF1bEXoEuHwAs+ytq4a//AUWyUxxUE4MepUDjGGEKS+DO+sgH3EI9vhfF23k7VkIbK4ijziQIbJZcAnlLO3jKtTaeWcTn9YFVr2IOAfZKXSmJ6rpuwYitJcIaNvE3SHG30zrOJ9A4xwLPmU/jIK4Z2UTV1Jow2Lqgpws7iqYzxfy62RUSyNVvCvv7z7C+rae2e0zQsmGECOEC1kW84iccoojpEJqfC3gkgkw6pePkmD7RMJs+oCRrI8RNbzSxiiJ7kY1jTipshDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+9mPOX6tCLU0vPe+CaKFWGblxNk7+DA66po7Z6eaWo=;
 b=ianZR02bjF6ID38eOGWkahm//spVk3rW4v6NAhhAmNtc8L2A6ZI9LbHcQhILY99JxNXS6YFJtqP7B3FL1hidi+v3pdHk3AaGWeeR1eLlDNTyn+C1Ia3ZcXuLREarpqTI9WrOuzwrOuxv46G8kpxMl74JtliF2BmG5w9q6K13pup39qKDvqveySJw+Tv3wk4z86E7HyVqZ5EKxqaeobU0KJTHqxb6RT/QK2TkSHEVkJEts5ywwO8VNiEh5/Q1LHRBQipvMtdnyx5f8SncS8S7ElfbxXolz8Jijd48qCR+auKIpr8fXadoA2TOJ+mK90TXwCMUjKRcd8t/h74tf5qopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+9mPOX6tCLU0vPe+CaKFWGblxNk7+DA66po7Z6eaWo=;
 b=XYmcPq5lDBWB/UquQju6lLNs9RUvXNbo78SSvOE26DivNABs+9VisHPEqnJQAYGnYIJVdDDYtUbOnBeD5xMTIcgR0XTAQqQCaPGF2QzcvsdGoqZ2Qu9kg3an+60Uh5acLR8XNwzvgODMRDfxxmkY231aD2gwY5UIjXv4k0PTyYk=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 16:51:45 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 16:51:45 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Implement bounds check for stream
 encoder creation in DCN301
Thread-Topic: [PATCH] drm/amd/display: Implement bounds check for stream
 encoder creation in DCN301
Thread-Index: AQHaV9v0YVSC/oi2D0u1zcJk6gRQILD78G4A
Date: Mon, 5 Feb 2024 16:51:45 +0000
Message-ID: <CY8PR12MB8193DEEF8A5AD21C2407338089472@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240205023449.2542171-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240205023449.2542171-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a0eb997-9037-433f-9b0b-d8bbf26db48b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-05T16:27:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|MW4PR12MB6999:EE_
x-ms-office365-filtering-correlation-id: 16396fbc-c578-4803-7594-08dc266abcbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 303e/jP3RAsZ8n+7XTzAw2x0wWaS9bZBSge58OGykONIm13cZ8tcnB6gfIzO3AmsEuRKCB7BPEFEyYgvDKmGsjLwD0qb+nVoSCppHwo6s1o29dnKTkdyCnqGCQGJT8+Tm2jXnkMfS0kO6Xa4r2cVRMab9UFDxrl0uJY+cmkBwJF/QnD5OYB94QBU3k7Q7dzt+/8d4AL5RY13jNJ9lZQ7+4MdcvlkPYDzdNfW59DNQKpC09bLLyQHJM2GKur6ixDVSzh0we68q43UnQvuSh55ez3xEixefnZK8Kv4PDGpkH7UyFCEw4rmWCS6lh51/0/7iwURK9rNu0c3wRNRhg2r8EVYxU3BVbF3wEOOo7fQYFnqAJ4vCpIzdeJXYdo3ZWkYhoVgyND3V/2ZJ6kyDMvr0zeyDdMUlR1iOCwnp5gpik/oqZN66LYyPNF5jovZqCqil/YsSB2/K4ztSiiYeFvfkUVaEKufIkEUYDw/XDT1Rc8dIppaVkcEtG03WKFqno/a/BDs4Wz4LTpXmiuMosLGRHNvd8ewDIg3tJ4/DwwfI0FDDWqaPd6yEyupBlmvCmkZJ+J72iblk5cx105hzNx1K6lkqHalL4Q+XAcK1bJ9j66uKj6A3jemmAWqFGexoD3c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(316002)(6636002)(110136005)(64756008)(66556008)(122000001)(76116006)(66446008)(38100700002)(7696005)(6506007)(53546011)(26005)(9686003)(33656002)(86362001)(2906002)(478600001)(71200400001)(66946007)(66476007)(4326008)(8936002)(8676002)(52536014)(5660300002)(38070700009)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znuedcV02Hfx5WeISNQU+Lcyf578DjV9G9q4WudMG71kDjfC3z3ISvRCYilc?=
 =?us-ascii?Q?RAQTIFQvbvJw/HRqys6+a6QkjPEcGKdif4Mzso71+Nl+3aDvwnRe6RNN0M0p?=
 =?us-ascii?Q?Wzea58Xiy8FaG+rmjJuL6Ca6ABiWJYblw+G9k/CYjqXAqz/tBic4kpX51xm8?=
 =?us-ascii?Q?D0Dn7PO6IH2zjOVoBq6oB5Bx/R9Ssq6qzDm1CQY50cpT1Z24qyut2zk4GrGm?=
 =?us-ascii?Q?aLBPvlD5OSY3OLZTIzXrjVPsOeYq62BMCeEVVSi6lfe26kIyVWOCKwfsoBSg?=
 =?us-ascii?Q?M25ewFJzIb2X6J+01MoYvretF47CGSusEXMM4PBaKcpTgf0/V4hTY/n4C/zW?=
 =?us-ascii?Q?G/CLl5IV0Fl24VE+9inndQ7cfvZTFnGlqzfCs/7GUOQm1WowSeaeHWj1RKg/?=
 =?us-ascii?Q?9z+t1+MsuPqFMrZn5x1qlxYYBiwgbQ0uIEUV6yb3/oLBCkqA0wSmWyzLBp5F?=
 =?us-ascii?Q?yV9WKdC9afTOJgPhban+jnDJSlvJT2pHlGnyhRKmgmB48m2iMVMlVSS9Xhf3?=
 =?us-ascii?Q?RMSesDw+SE45BcM1z+XLIbh2TudWQbv7lralfZzGY1zTtEwXwWwOCh/qm/01?=
 =?us-ascii?Q?ESsvidk+6GGchChztxDNbp1fgxZeY719W4JisKnM3klJ8bt0VZBKDH2DHnfo?=
 =?us-ascii?Q?GI06MgswGZ3J+9VHTWAWFQ1tRDqAPfYymMuRAC88FuM1sg7Y7axqnJ23i09I?=
 =?us-ascii?Q?kFMBm1nVnUvdOb0bb7e1Yre8xUcrj6MeaS6rwHAHmPGfxU5JAaMYewGQuD3B?=
 =?us-ascii?Q?wjHY12IceOm8Shk63bsWfEi5r0ZNrBTQed/NiTsuhwj6kskMfveR4csF1Pcd?=
 =?us-ascii?Q?C0vUBjHXmQRMf9k5XTvEzqFQg1/H0DSc4VYgUCo+3nWQMbbkzFmave/o/ahL?=
 =?us-ascii?Q?89xyhXRUOTeaes1cAZhyZz3trtIZ5bLb3b23W29Nw5Qka6XAKh0ORpW95vQU?=
 =?us-ascii?Q?AfOA17/ZALiTIgYU0ruGLHYKLWycXnhzqqdu+vi9EdQUF73/Okp/BZhDn06T?=
 =?us-ascii?Q?8PfW5dIyvVheOrkdwD0b1bwAp/OjWUNnT1iNhlKOb+JZPbrcYLYcGEMemkbv?=
 =?us-ascii?Q?hZI1Nv3PF5/GL+Zcph7kl3byOsGgh8gmvRFxnoNrVZGIXVXLmH2eUmvubaBX?=
 =?us-ascii?Q?mevlgek/L6qbRILCx1GQ8eoroHoYtY9WbymZBTbe4XoKTZyjVoM1FmcCl3OS?=
 =?us-ascii?Q?XbfWblL5vtsQ2CXLWgvBtX2maXP55N7JEfRPYQlzkxH4VM8iWXq86Ae3S3AZ?=
 =?us-ascii?Q?hdX9SIzhLOqTs3NsvuoOqwHqXjH0vWMXi88kWxtd/AcQ7mElN85u1FhY1DDU?=
 =?us-ascii?Q?d+Pll0pHZWovh6Nhlj8SIs2/QwKrZYGrvEhxO8cTeSKBNxhMgibTQw8YumPy?=
 =?us-ascii?Q?VEEvJbmE9YiAVJTvanOiBnlglrUo/rwwI2q4gbmw9PWf33gQyggSxnjkh3yk?=
 =?us-ascii?Q?64vxkBaXPKdkHYN/nhKYkbW9J430EiEGTvyNKxUpGjts/dm2vM5IYzykarVu?=
 =?us-ascii?Q?d4LcpFGFcNNtj/W+QPEhK2YPTTElNIK+P1ykIgjhrclyMfmNbNk/+iBphIfY?=
 =?us-ascii?Q?bZ1rsKK6e+Ms8uQ1g+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16396fbc-c578-4803-7594-08dc266abcbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 16:51:45.4389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ+eW2ALET95bAtBsbXekRblNqN0w2rVCDx4wR+7i4AuaMPK48SYBwe2xBhJjdFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Inline.

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Sunday, February 4, 2024 9:35 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH] drm/amd/display: Implement bounds check for stream
> encoder creation in DCN301
>
> 'stream_enc_regs' array is an array of dcn10_stream_enc_registers structu=
res.
> The array is initialized with four elements, corresponding to the four ca=
lls to
> stream_enc_regs() in the array initializer. This means that valid indices=
 for this
> array are 0, 1, 2, and 3.
>
> The error message 'stream_enc_regs' 4 <=3D 5 below, is indicating that th=
ere is an
> attempt to access this array with an index of 5, which is out of bounds. =
This
> could lead to undefined behavior
>
> Here, eng_id is used as an index to access the stream_enc_regs array. If =
eng_id
> is 5, this would result in an out-of-bounds access.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn301/dcn301_reso
> urce.c:1011 dcn301_stream_encoder_create() error: buffer overflow
> 'stream_enc_regs' 4 <=3D 5

Please mention that this is Smatch warning.
In current implementation this function is called with eng_id  limited by n=
um_stream_encoder =3D 4 for dcn301.

>
> Fixes: 3a83e4e64bb1 ("drm/amd/display: Add dcn3.01 support to DC (v2)")
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../display/dc/resource/dcn301/dcn301_resource.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> index 511ff6b5b985..f915d7c3980e 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> +++
> b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
> @@ -1006,10 +1006,18 @@ static struct stream_encoder
> *dcn301_stream_encoder_create(enum engine_id eng_id
>               return NULL;
>       }

>
> -     dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
> -                                     eng_id, vpg, afmt,
> -                                     &stream_enc_regs[eng_id],
> -                                     &se_shift, &se_mask);
> +     if (eng_id < ARRAY_SIZE(stream_enc_regs)) {
> +             dcn30_dio_stream_encoder_construct(enc1, ctx, ctx-
> >dc_bios,
> +                                                eng_id, vpg, afmt,
> +                                                &stream_enc_regs[eng_id]=
,
> +                                                &se_shift, &se_mask);
> +     } else {
> +             DRM_ERROR("Invalid engine id: %d\n", eng_id);
> +             kfree(enc1);
> +             kfree(vpg);
> +             kfree(afmt);
> +             return NULL;
> +     }

Can you just extend the existing null checks instead?
e.g.
        if (!enc1 || !vpg || !afmt || (eng_id  >=3D ARRAY_SIZE(stream_enc_r=
egs))

>
>       return &enc1->base;
>  }
> --
> 2.34.1

