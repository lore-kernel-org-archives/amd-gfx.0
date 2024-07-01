Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEC9C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 11:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1508510E3BC;
	Mon,  1 Jul 2024 11:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gz7ytX9N";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15FA10E3A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 11:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYn9GFmEpZZhTNs/9VdcFvgSArGGgz9Dq0tiK5KSjrRfoDR0gb5NDhyrumum0ib9a5pCNDFhC4Lsw/d83NgN3K4JFagNObfEqo8KfJfmXpjlm0y8dLH+cJPNHVJL+aXhRDCe+XlXpHKUr6eDOSxdf1NxyiWRubZOTLCDAIDl0FZn/oYkOs10QHza3GXTzUgz30XbQqYe/ZIfyd3upSZog5Ic/gqqm5Ubd/aSW2tE8QlUcN6JPDE2IhmDorXPjx8N6Fs8hUQ9cnh8ysLUdDzoLklfYibKH4qwoAh4SrOhHzqsOnE8xshLfeyQVm6tN8hgKLRNQAV/JT29GiuekrnF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXl4k4dWUq4T0A2owDeWOw5cqExQNn+V+FLlWWTBLu8=;
 b=NKpg0fZXdGEHSHnj9go0qSARakJhQhEkybilahLg+zAa120wyT4kqPWCEV73PGBuzogVzobIEHMV3uykhOvimktbYtIv4t81IyEH+BLjOL9N0dxzn5P/4wCMosAqSyPEG0MP4rurx3BxSaazuK4keEdFpNdEl948/tKKSVL1Qvo5f0A9Xju3FFOrkrleCT5sHixdGLrXNmjFOuUn1nu10eNAjO0v4v3UH1vPRyla0Ft05vRTqNId0zh7+y36m1nMtJTkdw5syUVVLdmZZYR6jBeLhILLVbyi/J7L0C2qv0hI/vvVD2lejUYbbCBU5tkdX3HKemTZkMmbQnrjcAQfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXl4k4dWUq4T0A2owDeWOw5cqExQNn+V+FLlWWTBLu8=;
 b=gz7ytX9Nv7BXshZ2PKOetA1sUr43Xw5xBEnp6wPyzYUzdwPOWhBrr6h35s9R3Amw4x0O9X8OTMkM+YUW6p5h9bu738+UtZkZzL4YdDGnYSDwU4Jr1kHTMKSvzgvYJlY194z+ucxpln13M1xKRYwq9wu4+MOwvJ5ok5cKstl+9LY=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 11:32:25 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%2]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 11:32:25 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Topic: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHay6OvO3dqy0Ieq0+pWCltrAlZQLHhvFfA
Date: Mon, 1 Jul 2024 11:32:24 +0000
Message-ID: <CH3PR12MB8074E005B23BD9557179384FF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240701104354.507531-1-li.ma@amd.com>
In-Reply-To: <20240701104354.507531-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=69874521-6139-458f-8dea-2e810a4966da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T11:28:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA1PR12MB6308:EE_
x-ms-office365-filtering-correlation-id: 48f34a4a-2c85-42fe-3046-08dc99c17ae3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MQAdLFBWS9CLNIrxVkxgj7gCCPRBOqtmhOrkYzdHif8lyFw2ckVQTCgIBBn3?=
 =?us-ascii?Q?ph5IKPp8D0fxN9v9lYOKb7rf1tujn/mcpGi29BAlsdelqj6VvHm+/mR+w5HL?=
 =?us-ascii?Q?r2isF6526fvvOt4yo9ea3EmKHYzD6tQ5Ky38qitry62VMl/uFWN5/GwQ3TPm?=
 =?us-ascii?Q?yw1i3PR3nZT1Qm4Ur3giAxJV6nv1sSTtjjhhllXroxQeWF63hxjmGg49uf8n?=
 =?us-ascii?Q?liMGji8OreZepDAu0+4fALalEldTvmFp7Eju8VdaNwheBD7/U56YUpsNZQw3?=
 =?us-ascii?Q?I6++IgSU4TfhYf5ePtHSfQriFVrQwhrHNvgL9jDsFH9LEX1/wJ3700ugEiXJ?=
 =?us-ascii?Q?xOkIURQbRxx4wb0VuS24JE1G5AkazAIlGULHSSSsjLbsHE2hDXMcqSn5L7xH?=
 =?us-ascii?Q?+Nhfd49O0dBbK8UUc/Onu1cyiEYhsQeBooa36tqTvPmeEGDoqZ6GiWd0Oney?=
 =?us-ascii?Q?1kmNtZoBlTjAtNh/v0ZIlzDLPEwEA24yDAEjsrAWHTKLq/D12ie/vIFfFKMs?=
 =?us-ascii?Q?XXJDh4nXX2flUbEneO4LYb9Dya52yGVlo290qoW+SLU76dGZMNILPgyPTjdO?=
 =?us-ascii?Q?a0E51Xbw9BY6saFjOLArErl6MlpqBcutDS2K4IWP270Q8XQQ5efiP+h0VUqG?=
 =?us-ascii?Q?zEjd+dNv5VR37a761uVZDB0K7xAj37UyusaDLZRrtfXP5vjQWQmsttnfdXni?=
 =?us-ascii?Q?SzpsqQ9df2W4qE7aRmGUXHuZOse2n2hlG1GhwuEjIX5WBlNuhO8jf1u7up0i?=
 =?us-ascii?Q?M7e9dPlbtgomwe+SGtPSNK2+qtwEU7E3KsF6yeP/a9fbDx3KY5K1fp3a5ocD?=
 =?us-ascii?Q?MU63uQ+B+Tht/sdNFI6Mrw0DPMURv2xMte9quF5Dxp097kYZAcAMGVEMEAzf?=
 =?us-ascii?Q?z3bUXmjB4iJB1gMJU0TaEsWpenRVIyl0Luogm2VBTkUi1pRae3eb2M3LkLs+?=
 =?us-ascii?Q?e/xhGH+iPi7Y6Q5ljo/kJCFWgrPnjQbVhspA8a88JXvi3Ucqw685HWIJAAOx?=
 =?us-ascii?Q?QP0dpOw1XcCwM0Ic0ico5CHw9eKNE3EJIhvmHDE6bHeN9g+lXaow1nbFhWzw?=
 =?us-ascii?Q?nGDLcVfZIu2P0xs4oIgahK6ca5K0h7aRFR9JhdYjtppC6e4n85e5zXRgo9aX?=
 =?us-ascii?Q?qnRlc7048oMsnc9DfQesU6KBHGYoEIStRsG1n1/jzk0ArxuQY6CYcluYXYi4?=
 =?us-ascii?Q?i+vADNT6sDasBdePxxZH5OP5RHah+waArXqz1SqolbY2z1WRFwEqEHLMp9Aj?=
 =?us-ascii?Q?4FuC+TvMI4sbgsf6L5V5+sqDmkrg4SMTR5u95jhorsqWCwpz9jK50zjNdBzA?=
 =?us-ascii?Q?xHtL4X+79l8z2TwJERJuUDMoBI6vI6QsaEJ7ScbMsno2UM1iJgpRzn8CsePf?=
 =?us-ascii?Q?XLwFlq2NQWqR0/QbWZQNNDtywYYjcOBbWVhhFnCn0+zkmDrxJA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIQMMW/v5vHJjkCzfN8pjqrwUApLFtP74/Q+L7gK6o40Omh5Mksv8iG61TVg?=
 =?us-ascii?Q?FQfLaAXyH+aOlrcWr9zAPMKZCpgO3HzGoZBiFDJs/rJ/GbSDK/YbTJI/TVmx?=
 =?us-ascii?Q?qvISndmToq+cm520b9VOqR5Q1dRyBuzGQFixa//j51Y63a6f404i7n0cH3os?=
 =?us-ascii?Q?2ROLGcr4+kpDYa1ZfJ+7Gp+xRLall/ASbPObJlS6wKC0lPQ4901Jjt+hVV+p?=
 =?us-ascii?Q?oE4awOKX6iAveboK+KTvvb0z5HrPtOcrllIMaAt4nJ52r+MuhGe/4guQz1bM?=
 =?us-ascii?Q?qXDjSRbolXboQdH1qIXzfoPJQQMfWVxuF3RbafdvRfBxPKXa5YfzjP202WYr?=
 =?us-ascii?Q?BAwZVc9lif+QoSjdTuihGT8erl8tUauYUJixta+zXancfq6RWMiL9Y4SBZhH?=
 =?us-ascii?Q?DRjNQtroOvJya8Y6UFLMpCG9ztxxAdkYyR5YSrUELw4x5nzNXr+S8lmSmCs7?=
 =?us-ascii?Q?SWoaBjfOefVFBRiyPP9hAfJIcCv+YQ4dZKIiwULdtBeI7ImbV9QA0hPbI7GD?=
 =?us-ascii?Q?kLl+Ockk3dKLlWbfF+DcD9b7kz/aoGNzRPkHvz9WBvvD/vZCtXQTHr7CJJLA?=
 =?us-ascii?Q?iWDzTy4Nt0txCDBGQ9J0Q/aLIGcHeITtIpXJyIYOxcdhZB/fq/ugcJgr+Gd8?=
 =?us-ascii?Q?cGKW8NboWI4Sv9ct0BKwXRI7PSmb99+2O9VofSfiiL7sff1aXdK4/dYIGM5i?=
 =?us-ascii?Q?gQCXvI37QeEVtsmlpUVP0eFPeD/f/hMgLIK5Vm3WCjymKR0l95QlCoUWKcBx?=
 =?us-ascii?Q?p2x2bqDZcgqYi/euR4F9iaOsEpggIiq+SiZEKGBwxZ4U0hSgUBv2DZS3ZiEB?=
 =?us-ascii?Q?HsfbwBPeCxmdIQYfd5pE+G4uBc1saWghGPjCk8cPuN1P4YiNvKiEvphzlCnT?=
 =?us-ascii?Q?q/s7AvHzlpkN+4VTvPFbHxL0XSIEM8p4jvlmtIlMXnDIdCyTZiVBUL5cg/aA?=
 =?us-ascii?Q?o+jaKe6NGcJDZdic9RaSELMAg8PoMuN+NQeEi8llgQORWyp3+gNWF9ch0iYS?=
 =?us-ascii?Q?8fBKZroEkDfbckp+NoHSWhCqhxH5RCZhmKAxAJlmAGnkwSzTnqfG7jFhcc0I?=
 =?us-ascii?Q?GuHG/ZSIqO0wFHzYMBGjRpAuz5DM0QTYlai8KOpb6hIdPAFkTzGXLq5h33EG?=
 =?us-ascii?Q?1avgbma2zZG5qUTAr3etfTKgHSpW9zJcWvwObUkTeuePDgKqleaxYK32SfbF?=
 =?us-ascii?Q?FcmstNBKLPZsyratBuGg7libv5IHlMuOmmApeTLt0FjB6JAiGsK9VK+HvjlJ?=
 =?us-ascii?Q?nEfqTPgemNxWaGv/TD75FtEi+CrYfGRoFroAU7b6P+HR1iyBPH28H7qDeQdn?=
 =?us-ascii?Q?F+It3Z639bJV6+85N1TSxwLMbJCraDt2pju0LDaBs/IskbCT4GGf5eZhjNke?=
 =?us-ascii?Q?W6iGb9nKY+L/BairEiEp50Ahq988qn3hVUCVa7VHftqcI07XYs6+WZme2QVi?=
 =?us-ascii?Q?IlYaaEnPaD91V+mM11+PbDoyVW8lEWbIdCWs30KL3IYwYrzE30QM+35YkuwE?=
 =?us-ascii?Q?Qoohk+290gzL+fPmHXun6z1t7En/YQ7g4Rs5d4YG3Kkb7VVNmZnWfKtGmCC0?=
 =?us-ascii?Q?FZ67ozSiZ74VQFzrwxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f34a4a-2c85-42fe-3046-08dc99c17ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 11:32:24.8857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Z4unulahzvLbmCa0vBAIYkWvUgnBgYiF8tW18xmzWNjrhM7IL7mvTNPOMEfou42750L0vXQmd0uuNdPiVxpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Li,

> -----Original Message-----
> From: Ma, Li <Li.Ma@amd.com>
> Sent: Monday, July 1, 2024 6:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li
> <Li.Ma@amd.com>
> Subject: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
> SMU v14.0.0 and v14.0.1
>
> This patch enables following UMD stable Pstates profile levels for
> power_dpm_force_performance_level interface.
>
> - profile_peak
> - profile_min_mclk
> - profile_min_sclk
> - profile_standard
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 138
> +++++++++++++++++-
>  1 file changed, 131 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 3a9d58c036ea..72fca481dec1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -65,6 +65,10 @@
>
>  #define SMU_MALL_PG_CONFIG_DEFAULT
> SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
>
> +#define SMU_14_0_0_UMD_PSTATE_GFXCLK                 700
> +#define SMU_14_0_0_UMD_PSTATE_SOCCLK                 678
> +#define SMU_14_0_0_UMD_PSTATE_FCLK                   1800
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -818,9 +822,11 @@
> static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
>                       break;
>               case SMU_MCLK:
>               case SMU_UCLK:
> -             case SMU_FCLK:
>                       max_dpm_level =3D 0;
>                       break;
> +             case SMU_FCLK:
> +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     break;
>               case SMU_SOCCLK:
>                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabled=
 - 1;
>                       break;
> @@ -855,7 +861,7 @@ static int
> smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
>                       min_dpm_level =3D clk_table->NumMemPstatesEnabled -=
 1;
>                       break;
>               case SMU_FCLK:
> -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     min_dpm_level =3D 0;
>                       break;
>               case SMU_SOCCLK:
>                       min_dpm_level =3D 0;
> @@ -936,9 +942,11 @@ static int
> smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
>                       break;
>               case SMU_MCLK:
>               case SMU_UCLK:
> -             case SMU_FCLK:
>                       max_dpm_level =3D 0;
>                       break;
> +             case SMU_FCLK:
> +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     break;
>               case SMU_SOCCLK:
>                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabled=
 - 1;
>                       break;
> @@ -969,7 +977,7 @@ static int
> smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
>                       min_dpm_level =3D clk_table->NumMemPstatesEnabled -=
 1;
>                       break;
>               case SMU_FCLK:
> -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled -=
 1;
> +                     min_dpm_level =3D 0;
>                       break;
>               case SMU_SOCCLK:
>                       min_dpm_level =3D 0;
> @@ -1268,13 +1276,67 @@ static int smu_v14_0_0_force_clk_levels(struct
> smu_context *smu,
>       return ret;
>  }
>
> -static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
> +static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context
> *smu,
> +                                     enum amd_dpm_forced_level level,
> +                                     enum smu_clk_type clk_type,
> +                                     uint32_t *min_clk,
> +                                     uint32_t *max_clk)
> +{
> +     uint32_t clk_limit =3D 0;
> +     int ret =3D 0;
> +
> +     switch (clk_type) {
> +     case SMU_GFXCLK:
> +     case SMU_SCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCL=
K,
> NULL, &clk_limit);
> +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK=
)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCL=
K,
> &clk_limit, NULL);
> +             break;
> +     case SMU_SOCCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SOCCLK, NULL, &clk_limit);
> +             break;
> +     case SMU_FCLK:
> +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCL=
K,
> NULL, &clk_limit);
> +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK=
)
> +                     smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCL=
K,
> &clk_limit, NULL);
> +             break;
> +     case SMU_VCLK:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> NULL, &clk_limit);
> +             break;
> +     case SMU_VCLK1:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> NULL, &clk_limit);
> +             break;
> +     case SMU_DCLK:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> NULL, &clk_limit);
> +             break;
> +     case SMU_DCLK1:
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> NULL, &clk_limit);
> +             break;
> +     default:
> +             ret =3D -EINVAL;
> +             break;
> +     }
> +     *min_clk =3D *max_clk =3D clk_limit;
> +     return ret;
> +}
> +
> +static int smu_v14_0_common_set_performance_level(struct smu_context
> +*smu,
>                                            enum amd_dpm_forced_level leve=
l)  {
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t sclk_min =3D 0, sclk_max =3D 0;
>       uint32_t fclk_min =3D 0, fclk_max =3D 0;
>       uint32_t socclk_min =3D 0, socclk_max =3D 0;
> +     uint32_t vclk_min =3D 0, vclk_max =3D 0;
> +     uint32_t dclk_min =3D 0, dclk_max =3D 0;
> +     uint32_t vclk1_min =3D 0, vclk1_max =3D 0;
> +     uint32_t dclk1_min =3D 0, dclk1_max =3D 0;
>       int ret =3D 0;
>
>       switch (level) {
> @@ -1282,28 +1344,54 @@ static int
> smu_v14_0_0_set_performance_level(struct smu_context *smu,
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> NULL, &sclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> NULL, &fclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> NULL, &socclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> NULL, &vclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> NULL, &dclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> NULL, &vclk1_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> NULL,
> +&dclk1_max);
>               sclk_min =3D sclk_max;
>               fclk_min =3D fclk_max;
>               socclk_min =3D socclk_max;
> +             vclk_min =3D vclk_max;
> +             dclk_min =3D dclk_max;
> +             vclk1_min =3D vclk1_max;
> +             dclk1_min =3D dclk1_max;
>               break;
>       case AMD_DPM_FORCED_LEVEL_LOW:
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> &sclk_min, NULL);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> &fclk_min, NULL);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> &socclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> &vclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> &dclk_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> &vclk1_min, NULL);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> &dclk1_min,
> +NULL);
>               sclk_max =3D sclk_min;
>               fclk_max =3D fclk_min;
>               socclk_max =3D socclk_min;
> +             vclk_max =3D vclk_min;
> +             dclk_max =3D dclk_min;
> +             vclk1_max =3D vclk1_min;
> +             dclk1_max =3D dclk1_min;
>               break;
>       case AMD_DPM_FORCED_LEVEL_AUTO:
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> &sclk_min, &sclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> &fclk_min, &fclk_max);
>               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> &socclk_min, &socclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> &vclk_min, &vclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> &dclk_min, &dclk_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> &vclk1_min, &vclk1_max);
> +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> &dclk1_min,
> +&dclk1_max);
>               break;
>       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -             /* Temporarily do nothing since the optimal clocks haven't =
been
> provided yet */
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SCLK,
> &sclk_min, &sclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_FCLK,
> &fclk_min, &fclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_SOCCLK, &socclk_min, &socclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK,
> &vclk_min, &vclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK,
> &dclk_min, &dclk_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK1=
,
> &vclk1_min, &vclk1_max);
> +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_DCLK1,
> +&dclk1_min, &dclk1_max);

We should not need to set the VCLK1 and DCLK1 for SMU v14.0.0.

Tim

>               break;
>       case AMD_DPM_FORCED_LEVEL_MANUAL:
>       case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> @@ -1343,6 +1431,42 @@ static int
> smu_v14_0_0_set_performance_level(struct smu_context *smu,
>                       return ret;
>       }
>
> +     if (vclk_min && vclk_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_VCLK,
> +                                                           vclk_min,
> +                                                           vclk_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (vclk1_min && vclk1_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_VCLK1,
> +                                                           vclk1_min,
> +                                                           vclk1_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (dclk_min && dclk_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_DCLK,
> +                                                           dclk_min,
> +                                                           dclk_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     if (dclk1_min && dclk1_max) {
> +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> +                                                           SMU_DCLK1,
> +                                                           dclk1_min,
> +                                                           dclk1_max);
> +             if (ret)
> +                     return ret;
> +     }
> +
>       return ret;
>  }
>
> @@ -1520,7 +1644,7 @@ static const struct pptable_funcs
> smu_v14_0_0_ppt_funcs =3D {
>       .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
>       .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
>       .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> -     .set_performance_level =3D smu_v14_0_0_set_performance_level,
> +     .set_performance_level =3D smu_v14_0_common_set_performance_level,
>       .set_fine_grain_gfx_freq_parameters =3D
> smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
>       .set_gfx_power_up_by_imu =3D smu_v14_0_set_gfx_power_up_by_imu,
>       .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
> --
> 2.25.1

