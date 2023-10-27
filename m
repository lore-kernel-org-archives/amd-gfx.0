Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5ABC25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 07:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD4B10E937;
	Fri, 27 Oct 2023 07:06:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B251D10E937
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 07:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuz4uBaHninS8ISSeEZckBFvlvb4P4z6wc7Ue79kvzbLlCMonUeR7sFiaty7KYsM4ksEf3Pkvxy8RicCG7n4gce9bIaFeOx8h2RqPzHRUueH49lbkIllfyb0zjNk5DAI9lQXDAYX2uA3IUL4w0bO5aHadXs1YIG4QNCq9jSCun71+rQMCfFSVw7evkGvLZG3L98RjOgnZp35NOw9nncf2K/yvHbMiRuRHt6lcu6+VC3DV6Oy8aBNjdkJeKj6iPNOLElpiOScxYgQkUetShT91avfia2siW6/enhCaMh5fAVoC+1sFgru9pupDY5oAX8LnpqpInpUVONbWsxmKmHtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUealTQ94S/46OntuR66ylWxZTys8tZlESylACpfhXw=;
 b=KceJ07j0PLaXkloBFe45LcH11EGzk/fM3OvsRG1ZCd9ed/L98dqux6mmoSD3xiwqjtU4CaIIpfmaulFPJjphRTuZHjauSuG77P9ZIT+skaztZscI80dtcBXDk9iRUS23t55lZf/UjW2wEoOHfVTseBtj5LKSrPDAJtGvnwot6ax05eZeAvjc6tV66mgCtFMtU+RJmQUMXMXsTPeNQR3+sRSHQyNM7ZNXNP+0hddpCJbUAFu7zxrne3GTz6po8w52+P2V/wRj6jAGllLZW2Zwsle3/en1v16nBgSNTj2i9kF95k2Da2fXymYwhFOHpjB6JqHreN3KiqVZDy78QpKFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUealTQ94S/46OntuR66ylWxZTys8tZlESylACpfhXw=;
 b=sdewjPZy43BwxqWvD/uW9UFO754eSOFgUGpxfjUn6hNm2/bOF53fx5thsuWJD4d0tMMRIYedZALFnXsoVXQM0CQBNOL1XrDw6u7xBjQE8qKVdhFbinEHtjQkmgnniRQjBo06d1/4q+OZ3o2L6Ou1XCdj6Fks0BloOVb4KoLJUc4=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:06:34 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::a6f6:4f5f:f381:bb7f%4]) with mapi id 15.20.6907.028; Fri, 27 Oct 2023
 07:06:33 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use mode-2 reset for RAS poison consumption
Thread-Topic: [PATCH] drm/amdgpu: use mode-2 reset for RAS poison consumption
Thread-Index: AQHaCIqgpsg+YyubFU+367J8t/l2W7BdNv+g
Date: Fri, 27 Oct 2023 07:06:33 +0000
Message-ID: <PH7PR12MB7988A4ABB99489F4A97FCCCB9ADCA@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231027040345.29495-1-tao.zhou1@amd.com>
In-Reply-To: <20231027040345.29495-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=872b8301-c7e2-4f29-9b32-d3cf7ddff2bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-27T07:05:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SA1PR12MB8141:EE_
x-ms-office365-filtering-correlation-id: a053832d-f504-43e2-da36-08dbd6bb406f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWMU7LUKMxSCq9m8ZHdS/JGn/MZZpOQECRxLWaned7nGY1uGx8Wv93VBlX5jtlrRZMqxmWdvtMkNBXqs1cgdRgmB7AaLzy60M5J7k6iYAnlIEFgAq2gTydQtIBZsoph6C7PvRitlp1Mzv0L2Xt3DquZnoXAhu5W46HnQC6zJBP+LIl9dy+zuqlyjWZHFSFEj9IlUmxnV8tOZMrfYtpbY6pcHnd6oGueJ0YXkZSgWjCFsvNgkOps/x0HUri8R9LY2wfR/PscVz+fJ5tI5nWpv+W1qR8hzZZmpF4+eUqBOQJYWHlw3e6xzYZtsBjz7wnj/CdE8mVbjdCWEil7xYZoza9rOrwq+tHKDb3P4RYSPu2/8CsNu8n/qlGnVxkcqpp7aOU01l922WKtj1zPguy6KKnFSYigSxIu3rnsbnVChd02zZo4TnFhj766PGDalAtAHvtCshzadaXfn5zxz5L/3e9Oxiw1mVLoRcPldda+kbpP4s4GQTh9TEwX7bpoMu2m6H2Vn6EyecNpSDeMEsmr3FpwWMviIIhgSWjgrPMyUnLL89X6Qe9DVqQWy3xGBHyh9hCXuPuiMNoTohWt/SxVUCQDd6S2RzVFKJG2/Fl020qDkNFftBm1515BMZU6ech27
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8676002)(8936002)(41300700001)(4326008)(38070700009)(2906002)(5660300002)(52536014)(71200400001)(53546011)(7696005)(6506007)(9686003)(122000001)(83380400001)(110136005)(38100700002)(66946007)(76116006)(86362001)(55016003)(316002)(26005)(66556008)(33656002)(66446008)(66476007)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tJrAR5odprlR6Wfit1yvV+QPy+VrCrlTsAvJvasZVb49Hdcl81EFqKdO/F40?=
 =?us-ascii?Q?Ms/nepAa2Wsh3JoYA/zRQDst84GRL0nGbiyVvN3EIdR2PKgW1l6LgfWQjEmO?=
 =?us-ascii?Q?d87sVkg/6lAm+Eqtl+C/WN5uAXoNICabekgmv9ou8v6tKG28FrOHKxH/TlnD?=
 =?us-ascii?Q?r041YoiadawMFs1X51Bw/1u0QEntlvBrcQc9KkMjdtUVh/wFD2RrUT7YSaWi?=
 =?us-ascii?Q?hDy1fL1sLL9vQLHCmsDxLE1fufl7eygKg2EalEWSjnWRWrgL9yu+TfMh+Ydp?=
 =?us-ascii?Q?dRNyKWSjbrZATEFqq6tekd5xifzWwJWTVf1U/wg6/qucIdJ4WQOMOQIp7QhX?=
 =?us-ascii?Q?gZd8bOwbC6ggPzx6P587sgOt9uK7Rw/yPReUXCPAZUmtTMy7roOyCTSBw79E?=
 =?us-ascii?Q?94d19vRivYxt17XPeWKany+vleqRwWfBiJ7s+qnJXDZxg5K5hNKb6TXfOylH?=
 =?us-ascii?Q?C8lsbUs/MkmX0fSqgyoouQ9g/BjkDIAyM1ACzcdv+RvOF4beB1VAtGeKBqQq?=
 =?us-ascii?Q?DKqUS44nVWNPr5Z1Vlgl1gbTb81sdAMw6/BNa61VlCBNEIL9dj+dh4CQN1RZ?=
 =?us-ascii?Q?YU8SEChw1Erphw+OsFR648flDHELqzPXtnSHJtvSg3DHz7Y+ODYlyAs3p0nI?=
 =?us-ascii?Q?nBZ62869+S7NAFrPMGASb/YU2TPZu6U6tkwnrDiBU5MrSVpz6Rn7EV3/jXrt?=
 =?us-ascii?Q?XTHvCDZBy17ha8ZBAl10VDgkOicV4ogpZcA2KvW619kXNmKbklrO/XkSnqKm?=
 =?us-ascii?Q?9PcGx0RI7ATH4zfr2/K9BUpCxu40y6lEb0aYsLdXFGiBtHWTi30o9NjfpUVS?=
 =?us-ascii?Q?zSP57Vjxd19TaEKJWmiaUCbVE4JHxvGDDKe4OhZ+0zKIC3G6xjCFLHV/zI17?=
 =?us-ascii?Q?CdtKot8QY2C0sPhHcrHAjbNKpGb78u0eQ2xZS5s5I18wNdaRqb92kS7zKBjX?=
 =?us-ascii?Q?JzeT/XuxNNQ3+LHwMBA1GnUCyEFNQwuX75+zWVkrGoy7ZFshcTBsc329XCzc?=
 =?us-ascii?Q?L02pNX3H5eYwxV1++qz5+MXcAM4ozAjFdXDuY9ZXW9bvRrejrU/YIJbIFAai?=
 =?us-ascii?Q?PD0jxFi8tj3H0MqF9BsYqC4Roh8QPmw739nkvFKSIOPN0HXfTFi/2oHIImXv?=
 =?us-ascii?Q?5J/fWGz3clRCUP6M2NjsKSl35FaF4HpPshg/Xi90hotU2exqt2CCVpF8zfXK?=
 =?us-ascii?Q?eFmqLF7XW8b7yT+izVxYOZ4shFjgeybZ9pbYx9bR6H/r2OKtiznqtVesXmnn?=
 =?us-ascii?Q?wdWnBGBLESwToH/TTY7GF9yBX8e6IKu5d1TtUDitt8uzbAmlbdzHQLg2SZ+s?=
 =?us-ascii?Q?FlzmcK4cZn3MUUDJMVqYkst0WvU9yk3Olc1Avyu07/6mLHLoiFyrTLitUCPj?=
 =?us-ascii?Q?AuUbMV/ZRpI3mI1JAXT7RfuFERJsK5LfBF+xV+TlxVwn7AFYyg7/D8MwY3gb?=
 =?us-ascii?Q?5zmQypFnPBCcs7tT411aU+MJeuLgIQsfPkjWWQAcdlYqyDhaW8ESlTWAfMqb?=
 =?us-ascii?Q?piN3Csm4lcPT0b01YVI2kJ/2lJqE9j3rMZSPYWuTS0W5larn27AEFt3DhpS0?=
 =?us-ascii?Q?VkSfk0SRLsgUjWqAf6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a053832d-f504-43e2-da36-08dbd6bb406f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:06:33.0880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSn7l6MvTzRZGLbw7yXYHeP2WjSukAvR3L/ab+BcXl+TI3ap1IAnKG+RTXmZzl7FghsPjI104t4Cv85lGfwe+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Friday, October 27, 2023 12:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: use mode-2 reset for RAS poison
> consumption
>
> Switch from mode-1 reset to mode-2 for poison consumption.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index f74347cc087a..d65e21914d8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -166,8 +166,12 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>                       }
>               }
>
> -             if (reset)
> +             if (reset) {
> +                     /* use mode-2 reset for poison consumption */
> +                     if (!entry)
> +                             con->gpu_reset_flags |=3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>                       amdgpu_ras_reset_gpu(adev);
> +             }
>       }
>
>       kfree(err_data->err_addr);
> --
> 2.35.1

