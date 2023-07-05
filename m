Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE045EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 06:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB7610E320;
	Wed,  5 Jul 2023 06:22:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6156810E320
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 06:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP/JfeeWbVpdHM0spkYsIUHvxFFwnghxzJcaUsSgJ1AifHr46wpKQsFE12oT62pogirKfyL8tmZyuqc8ZLoulvCyxEadnyz8n8nePrFHSBRsr9+wYUkbHFIrOdmBOnIfaFvmmviJo1TryK6xzhX/86xuMgp00KbmcONKgQDHa+g9plgkVTpprmAethd7myvvkF/y9OKknvhc7gjMVjLqn8ZCOhPkVtYulohFYuAE5Y37pgW5e8Yx5WA4+kfrkwi9mQXjM/dc8Tlb0HGjICwTI6K4pnlnoXFk/WW96r7ZzJiBLHbpd02jL1az96fCt8X3pSwHSUpRrfSzYEGVN15zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G71wdjgz24V0lh+RVzgW5wMvh3hPqZv876FKKCDMDH8=;
 b=h7SsRr0vJDewdwodWD6R8Wud0YKuJ5GXW0R8dBvkx3x7ieX24yGiVZ1pUkp2xAdleMcql7OXUR25vv4dLqDe/AuW1NbBn7Z7ZFhYndT3/JcIstUER73u0E/KwhQiZ/jiFHP799xrOkAZkBvY02tfLI9lhXjjoHsq5CWtd1rlSnpa2ZzsFoHhOFZ9qRolQKHtJ/VB7Qg72YOX2cYzfH2JlsbFCB1rJOlIuBcgO105JNJgJzkyXIxFgpl+R8kt0NelOQ/DnPWmsA+wJ0XQv0U9NI7zSMyXYqg+dOATvAMG8n3pz2aHEBVORIwhROrXDKw2UoaMqxikIWWiTH9+Pkh92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G71wdjgz24V0lh+RVzgW5wMvh3hPqZv876FKKCDMDH8=;
 b=fgbgmbIBC95kqdO5suKGipygmkazYtGXsvNntvKOgFfDVD6FEv6hKRPc0oYj3Ldjcy8Y5wA+ewLCh3UQVdIcm850REHqzn/97vhRUIb7OlELVsiVp1Y09NPmbYRYlfyuDFHK/M7mbX4MWZK3uOxh625nwygRjjj8iw7sAaRpbxw=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:22:03 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::ed91:e0f1:49d2:1af1%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:22:03 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
Thread-Topic: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
Thread-Index: AQHZrwHmjkyMtDKHuEKXfg+jMT+f0K+qs+cA
Date: Wed, 5 Jul 2023 06:22:03 +0000
Message-ID: <PH0PR12MB54044D7F2C19252B2FED08D0F62FA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230705053038.2739012-1-lijo.lazar@amd.com>
In-Reply-To: <20230705053038.2739012-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=44eaf868-1e38-4cee-a413-20a7b01b48f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-05T06:21:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|SA1PR12MB7173:EE_
x-ms-office365-filtering-correlation-id: 3271aaad-884f-4244-db81-08db7d2025de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSo85DTs8SFnSTF7DeQve1HwZztvwGAlijLUoqDpsxN6LrzZqtetaJJ6RkW4Tuzcv3J7WGIuYHTAHZKPL7fQsevvpRGiaMyvEWwK2EqjcrfU3KC+5WaCBZL7UF933B83kxENvCMlx+WHPsVi0MiFPQEybbg1NeXB/u+5924vIdPRgbISwbGeEUdKQRlSJthgM/cch3lgGY0vfwB++JtG4T0fCcAcfyts0lqFbBpHnHk3ZcABhb660EPoAnKQlpvria6QO0AZXHJyZVDTnbb8Ytc3cKR9SEbxygQ89iKNAJERgdhe0nDX4cpJwcO8VRVPdNq5bx5J+upuQqvnGy2Yl7nDXUuUuVovUWNmcSGy6wXSzPBwgaZH2ZvNsydqzpPYba+dL3hoeuTFtgDlPXW4MXn7Jbe0Ndi/YiAqpNw/UMbUdhin0/y4yfPasnltzbMPMGVh6Dimqziv4tEPmY1hSQSINHRZZIx/Fkw79lKiY3R0upFPhl+8XSw4MSO0yrOKQj7PC491ZEpKRWt3x7SkGe2asKvyCF+gAWiNdEkUCQ9oHcGDg6xoCPMcZ/X3aJOQJ3XsunUuD6dQpr5/DzmvBuslpbebHtC9NlsvuXQE5CULGbP4jN1aiFB1qKbSIY/o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(38070700005)(2906002)(41300700001)(8676002)(52536014)(8936002)(33656002)(55016003)(5660300002)(86362001)(186003)(478600001)(26005)(6506007)(71200400001)(9686003)(76116006)(7696005)(122000001)(316002)(4326008)(64756008)(66446008)(66946007)(53546011)(66556008)(38100700002)(54906003)(66476007)(83380400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/QUk7RjbomFHWuL5Pwbuesf5nOX/UAwC9XO+I76muR9X6/TCLb0LsEe2Toz?=
 =?us-ascii?Q?qKr7hOkze+WC6nPII7a0HAiZ3JcKn96GHpiDaBHi6Fj0G7fRV/sMT+KMsmSA?=
 =?us-ascii?Q?f1JyFLSfO8RkTtq0HlfhpFPiCt0QKSee5rhTwYNufvCvNEY8WEPqFy7yPEr1?=
 =?us-ascii?Q?pMpT71hXJa4qN9qGVZxGa0Tssbo/PyjgSQ3JVb89+NtpQKuENrSmHSuBiH91?=
 =?us-ascii?Q?aGmEg0Mom+xK9UlPxt1rdpR/x6L2QLrr5dzU8ZIXbI3r5MXp2bjlIEpkfwFx?=
 =?us-ascii?Q?OlDr1B0wAhAMMSwRhLgdHd5WkrXm87JaRPSW6QD7HuPkflqPkL8O6j4iWSRt?=
 =?us-ascii?Q?5K4EMXVC06pBbAcYpqd9komZUaUf1nTlUeWGgtUhKh/6sRix/TVNNp1GQb14?=
 =?us-ascii?Q?DIkZsXT7Q2jV+QIXW3LhS0f6RQzFumTUba8+0v2r1rWkQALsmx/b1IWDq4w7?=
 =?us-ascii?Q?uHlGKyfF7iaaDUL6RSOmS2vJ1SsvZIgXMkuF/BIwzZ9WrxGtL3HjlyUeffbS?=
 =?us-ascii?Q?4oXFhBvi0JPKEWDaqXnJJvp3bjsWrqjvVithm2zNgiFXo/ArLSEXWGESMRlr?=
 =?us-ascii?Q?zuxNPXD6biJixFQaTLyQSw7IZwA7gtnzgE4MbGXffgYQ6RvLen+zgVl5Hg2j?=
 =?us-ascii?Q?JsxVmXKxO94uaNy9uht9qXcKmagtOwH17jvwTTEJA7+4rDpIw5pNpiE+UV00?=
 =?us-ascii?Q?9x8BFtyPSQPqK7hFo3xQQ0jOtI1GYur2HljuIaa8bYLked8s+PCbVHX8eNHL?=
 =?us-ascii?Q?P5J8S4s8o2SbXENXf2eVo6jxSMQ/obN+Z+4tAmVwPYRbinhwlXjXB/3bh/6R?=
 =?us-ascii?Q?7uuGHHjqQUOMh5EnBiEh8hR5qVXYVgpG/aZvF+mQWVCByCZfwi3YflLHJOFX?=
 =?us-ascii?Q?Ovlq+WpS7qx0bjKmAwP1Wll3wjfGbY86NpyGbbIiV27DYplOeqr9J3uF2lTY?=
 =?us-ascii?Q?/ig4APBSXqvHiNviUu12PjWpG/s7g/z4qbutiLEiWFxja56h3rDAxuGbqbRH?=
 =?us-ascii?Q?OAYYNd1uq2fAZp8e21IezCh7clwmK1K7kjEzcjAVobOqyOSwF/nvubNS536R?=
 =?us-ascii?Q?dKvjeoC4i7vD5lxwNbzjc8/9zs5myqj4XPkoKIekHEb5oISm7duZimdIqrEX?=
 =?us-ascii?Q?/S0BOsuVTLtTFefKsmTldsng6JtlKo83MBWCjtEHXvufSd7dqU+HzfAYwwN9?=
 =?us-ascii?Q?pYiP/XlSdwtLWrjzCoZWm8F9BOPismsUrjvpSAMs0UW/GwLLI0imm2Fcf6QD?=
 =?us-ascii?Q?+gj8CxDNQRsXllZ7TvW7Z9xS/NdxgnLL98wyGmHeiK8N3RJQtV4asMlS4Sck?=
 =?us-ascii?Q?+CsM68QciLVxkhocfWEPTeSb4RK67orwMETM92awMWLefHXQF1dY142myKH4?=
 =?us-ascii?Q?+09vEeIoEB+FxyApKChgFMBIg00gyl5pDKD8q3NkRgWDbBhQ4F+RxkT5tCF2?=
 =?us-ascii?Q?xfTVu78319pgRbxpIXW514TmJqJfvuj6ubXoXfTEv5njgG+v4LmXhAc/5J4a?=
 =?us-ascii?Q?5jwrS2yavnXe0cDg8FFQs8obNmqmVR8ZWxZkqjfkJ8rUi+Pe0FOxqMpfwMgi?=
 =?us-ascii?Q?VAsJfve50SnNkGV8/bs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3271aaad-884f-4244-db81-08db7d2025de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 06:22:03.0429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfAs2N7iwQNjEWVyrbRaDZejmRRnAMA6JtRgaQhFLYCJSp1aWKszhvY8EZwvoDrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gadre,
 Mangesh" <Mangesh.Gadre@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, July 5, 2023 1:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma,
> Le <Le.Ma@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
> Subject: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
>
> Programming of XCC id is already taken care with partition mode change.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 -------------------------
>  1 file changed, 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 51532d0dd7a7..548b1123f7c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1034,32 +1034,6 @@ static void
> gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_
>       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG,
> data);  }
>
> -static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
> -                                       int xcc_id)
> -{
> -     uint32_t tmp =3D 0;
> -     int num_xcc;
> -
> -     num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> -     switch (num_xcc) {
> -     /* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
> -     case 1:
> -             WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regCP_HYP_XCP_CTL, 0x8);
> -             break;
> -     case 2:
> -     case 4:
> -     case 6:
> -     case 8:
> -             tmp =3D (xcc_id % adev->gfx.num_xcc_per_xcp) <<
> REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
> -             tmp =3D tmp | (adev->gfx.num_xcc_per_xcp <<
> REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
> -             WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regCP_HYP_XCP_CTL, tmp);
> -
> -             break;
> -     default:
> -             break;
> -     }
> -}
> -
>  static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)  {
>       uint32_t rlc_setting;
> @@ -1917,9 +1891,6 @@ static int gfx_v9_4_3_xcc_cp_resume(struct
> amdgpu_device *adev, int xcc_id)
>                       return r;
>       }
>
> -     /* set the virtual and physical id based on partition_mode */
> -     gfx_v9_4_3_xcc_program_xcc_id(adev, xcc_id);
> -
>       r =3D gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);
>       if (r)
>               return r;
> --
> 2.25.1

