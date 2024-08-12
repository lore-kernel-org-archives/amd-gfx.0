Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CF3C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 03:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8932510E094;
	Mon, 12 Aug 2024 03:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZmsA7Leg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACFC10E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 03:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2XmSLwprLBOV7MUuz/me45UlHRCr3nQKFixQ0fr8OH0tp2w6rYk5XkpuUGGQU4+mcCXpd49i2Eil5/YynuHwb9X8GmV2W+d5/XTw3FdXvN8T3v54SwnuheTWAN6uzEMFDPaGD1LvgegenMcoQh3XMak4NNcOHT7zt5a3+FcxhvlVd3yFez73PY1KgjuvIy8mlEdQ1x7/cwUdpyg8psKaQ4h20X7Wthq/RGSDhOeRF4qgzXVDSUy48YQoGvzZAEZrAUF8zPFwsmy9OTzZ6od4Rmk3VkI/5ULuucUOdJ9/aUaxfTqdCCVoYcUKpdK22kJodnXHpJDlAQYt/2zLnz8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EH55fIMcw/4vND2h56jyqT8Ghc0aDA1buyumcKqNAw=;
 b=cjfd1Sr9J/wxIXiG41CgsvbDXZnOCWcSbaV2V8pKEBYYB9sVUkduk+qx33Vrid8VyGHCavKEae3yQw7LXWWidL5rS/+VWn9mWfOMniql8EDyeVXn5vhcOn5XXuMVz08deFLwTDU5mV5yf12gTBbyON3o3zGBSfpSenzDl5ZgXTrgqPwQaQAGxMO15uuW/6elFExjUxe6oCfHIKlZVm9wANSB3Qa5xB8XZQR5ykCYjYDohfhitsZmqrg93IMcRDQvy1RT4dC2fW3h+X8tOwwAwaK5CKRaL2XSygf04pt1wwqGlJAqAPiMZfR9evXLddyVJ5TiwwCj+KMm6/Em3QOU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EH55fIMcw/4vND2h56jyqT8Ghc0aDA1buyumcKqNAw=;
 b=ZmsA7LegSf7cu9i7C2Vx0rAV8LwS2Ta1NgNW5u9yjKEaeHsCkBkoqq4j4Yhu2l0b6VIzmPmoqrdTWgcMSDIUfYgY2wf73RdOjAIt9NMk8Qy4CtvN0WRmHhg7Jr1miQv6VJCUyLNTkTpGaAFMH7OlCPkKBXJCrAWYiBsUVn4PviQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 03:52:15 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.7849.015; Mon, 12 Aug 2024
 03:52:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Topic: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
 recovery
Thread-Index: AQHa7GdXCtBfTYGl40eD2/Rp0iTj5rIi/NxA
Date: Mon, 12 Aug 2024 03:52:15 +0000
Message-ID: <PH7PR12MB8796EB006F4E9D99DE041DF7B0852@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240812032546.8006-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240812032546.8006-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d20fced8-8c50-4f7a-9411-0003b6b43eed;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T03:50:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BY5PR12MB4067:EE_
x-ms-office365-filtering-correlation-id: 44f97cdd-dbb2-4eb3-403d-08dcba8227b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?q3P5EGBnOpCtY2Ff/g6LoomiEklcSrrjvyoLwCjoSjSYVyjtOpKnwokp1Lcy?=
 =?us-ascii?Q?9o+E/pBq3cxdfPSAKTnA2aa4cTgz/HHVoKmoW6QoV6x8cY97pSeNW3muVthh?=
 =?us-ascii?Q?RnS6J2nj4umZWj7H5vpZScqSlwD6el8bN+mZPQYMZBpRjxgK1aB3b1bvis10?=
 =?us-ascii?Q?5RXNggaREV4MIj2WjbnL+gVE6DlmhjTIBxf8jxtemLeikfUtLZvvbC6cifyQ?=
 =?us-ascii?Q?+ful1VjLYLg4NLg4oUVXNpJX5XVWD1JVTbXmFDsWnoIf8HuZ/yxTCqBu8/kq?=
 =?us-ascii?Q?Q+V1V7BR0Jjp5GQ9dy7jrEl+P3Y+mhhgiGcYXqxxDqBV0AItKcCcQzGPPKbW?=
 =?us-ascii?Q?+NLBbpHI/R1A7VUd33Ew2wN2GysZP7MNBeGWJUk61K1932ad/9gDi8PoT5MY?=
 =?us-ascii?Q?tQap05TH5yZjHsPr+ac/6utX2cdZXsrYDuzFnujKELPKOezrwmBImaCd3Xp6?=
 =?us-ascii?Q?O+za7p6i/6uktOJi3ttKliPk5igHMkZhA0wfU6I4oZlgPwuyCb6GweFEfqO9?=
 =?us-ascii?Q?sippIL+ElswuZVGBHoGpKZ75yc88bBgO4ItyPRBUwh0EqfwaCkpDpNMMZVqz?=
 =?us-ascii?Q?oi5+7l924FoyK7H0C+rKB/a2Ok2FLYlNfDIFyEYoaLU+ZtHqPNHywg8zqxzI?=
 =?us-ascii?Q?QcLga5PqrCcRPnlwYSpYB0Ruo0soHY3Lfs9Ha0IFTMql/ZN2r4O52MRlVF3A?=
 =?us-ascii?Q?v19gpcef0LHi6HvYHO+rcZ9GektS/p+1AX3MBwrI+tmPBbiq2tQnWUeuobKk?=
 =?us-ascii?Q?Hq4YaW1bSM5xrnhqGGlo3eeaZyPlUg8cMv1lLAzj5qH87KCF2+DKtZR9TqSY?=
 =?us-ascii?Q?pe1MmzZE4HawWI50XP8Ic8DIkj8acVdwsfuJsRwxvfLJN7FIbXV8S8LMbDIX?=
 =?us-ascii?Q?RzmIxZ36aV1RmCOvnx2TbmPCSHXeJgprhqSRL0T44W+QbdQbFN5GMpDWXzFW?=
 =?us-ascii?Q?kiBqjsCYAiTHv6h6hScey/PjBXjgGK39yIK4IX9cwBCdQymzXUW2v5UWJuIw?=
 =?us-ascii?Q?vxs9WZBTjCBc0JxZd8UkWj7NpGSqdyi648zy8QJX8WtoDM6Q/1GgTRtbs8T8?=
 =?us-ascii?Q?k+NUJI5h9LTuE9SQZmnj95NDzYLC2RQSoA3zCDwJm5I84ClXC5MUvQ1R3y0w?=
 =?us-ascii?Q?sjpS+X7j4HbpVDX+KIEYnte8WAwvpK3wvrn2vZYGk/YVEQsiduDsWuTXfwUj?=
 =?us-ascii?Q?LJrZikkXD/TG4idiU39FMS8B92Og9ay1QvHZjVYi7vvv0bj2LkspxAcuUIWS?=
 =?us-ascii?Q?8c/D0FwNtR8WSE8VtT2w/2pu8HKW+8lMPKcv9Y+/1Fk7rGhgDtQ45ADDIuw0?=
 =?us-ascii?Q?hlaEcaRnwLJcHVbemQwg70QFsNaKAPjfJ2b1HtPkSC1SbbKId19djRZep887?=
 =?us-ascii?Q?n9mNmO+0zzWqnQERpbMqsbTRs6VOu9GnWjh6sffZ3IaCINOelw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+bG6l7bsDKgFdnq+QPcPaemBm1SUnjGTdnQx7jE99aFBM8GX7fVppEeBlsYE?=
 =?us-ascii?Q?/hcopNqh2YQIHOSQEOJ8Kk/R/XwXiob+FXqO4NKSB0WMLhWz0FbxlhqX5SGM?=
 =?us-ascii?Q?zaUBhOUl57wEYorLFit1jmNR0cWszSg5AZ1iEitAjLTfb7jKH5MBJSCLeOnJ?=
 =?us-ascii?Q?EbsyuNmJupXhxtUWgf42lKHAoWBpRnNfUbWHtH23ikBY7jrjuMhNLXGIKo8T?=
 =?us-ascii?Q?JRhNPKjrYdW9lxZR8YvIZakOnNm7Vif+IbGpnBdSJpSeJ98jH6dbZ2tfHZgO?=
 =?us-ascii?Q?msOJ5d44W1XXwVCrfSt+ZMVskv15NR4OuBTWgwR/Hrtr3kXpeIZ6RblnepIB?=
 =?us-ascii?Q?C3y9V5S2tKzRqG1lEPBBC1Bhw+I/5KvIySf1stdEseeKm3KtfTHa2+Z2zr93?=
 =?us-ascii?Q?BDf9T7Qsx5Hqs1t1qyZ+UA26ye+xlQ0iFFb7WNBChm8NspxSne0nyn/8UncE?=
 =?us-ascii?Q?7ijfP4jqMI33KbvEaNr/hUhOgO0BnDWeTY0fGstnlfpQM7l3Y7mPyn0Xu1Le?=
 =?us-ascii?Q?fxMCuXryatAfHaR0cdxccXfaIpT9JzSbxdhyhjw3rHqHBVU/q5rXeoumteWr?=
 =?us-ascii?Q?A9Lp9Lk1FwoymQd+TpwQswM91lG/8OfU9QLzzR0lSBbj1zj9ooqscSOC7kMa?=
 =?us-ascii?Q?vm7zvMVQLxcYcjDWjOKRo/hsE4SB6m3PPCNMhpHk7TRv13Mhbd08xspEDdh1?=
 =?us-ascii?Q?RQmHRSpY7Cu+r/KkUUHnTZ+kr3pdbfNEMXc8WfD70AI2Tyop1na48CbFBeqk?=
 =?us-ascii?Q?uOofFg0PELOkjTIeo5s0WwoLlc0ozeUi5KihLQ8XZ0dv0z4btMQmWGiAdnx4?=
 =?us-ascii?Q?jDw3J9iUsHUF8tqqm2Ic6MMgxdgotKWjEASlhICA6x8AiG+Z0WKFPI3WKW66?=
 =?us-ascii?Q?Mq2qfqSUyPEuLufbh0Do2d1CF+LW1xkc+ZJrxFV28OoVOfIFMi3xVb9XWTY7?=
 =?us-ascii?Q?dR7q7TjFSvriyiSGChg2TDphgaiDlkbgNtzW0UsNSSZpVM1/EE1B8cD7vBxO?=
 =?us-ascii?Q?bEf+DvZ1EkCjxJt8TNRsXu/RxEiv/EQoe9SSouDWGalCJjthqV6nsCJU/bbO?=
 =?us-ascii?Q?6Varwu9hxw7RJgKD4Jx57/Am5HoLAoHyLhDllY18VUaO5y/bN8beg7bsq9eM?=
 =?us-ascii?Q?0ucACWFEq4KCGYVzGEEsTxLtvuQBnkglGZudbQ/FULitjVmbhEPcUW1xIPlB?=
 =?us-ascii?Q?aiptn6IkMwZNSN95XR9QS6Lgs5GiKRFNzc08Gn1ZFbPO9B484PJpa8PsBZZU?=
 =?us-ascii?Q?1RuVpJufVzuVLvs6GUxC1klpUjUWfcAgbY1jMBm/zX06j7PyyPBJPm9lEs2g?=
 =?us-ascii?Q?81PUazxDTAO0COpkaQytAArY6ZUmgkp3OxjoTDAWDVQrK0sHMjzoJt3n9CSo?=
 =?us-ascii?Q?9ZhNwmFH9MHY4IRGu8wfq2Ovf3O1AuRCPpI3tM+NY3drQ1gad2C1qR7eMQOP?=
 =?us-ascii?Q?pnBbw7TQevbKhTI7D0o7ZTFj5rKTrdPu9fl6tdCXAjHsvgXCJc7r+MiRJtes?=
 =?us-ascii?Q?5bPk4qVAB9Y/gN1k38QNKspATIttfeLcFyHJfUf0/+jZZaYKaJQ+NNylUeH1?=
 =?us-ascii?Q?wn0ZcazoTWqBQMwZfc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f97cdd-dbb2-4eb3-403d-08dcba8227b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 03:52:15.4127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acji5USibxzOeZABCD05XOHY6YrwEtXz3HOVw3Drs7Fq4rJZcH+64jo9YFEj34sC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Monday, August 12, 2024 11:26 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add debug option to enable mode2 for poison
> recovery
>
> Add debug option to enable mode2 for poison recovery for testing purpose =
only.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 16 ++++++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e6b641cb362a..c34819f947ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1201,6 +1201,7 @@ struct amdgpu_device {
>       bool                            debug_disable_soft_recovery;
>       bool                            debug_use_vram_fw_buf;
>       bool                            debug_enable_ras_aca;
> +     bool                            debug_mode2_for_poison_recovery;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index afe3b8bd35a1..be6b920933d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -133,6 +133,7 @@ enum AMDGPU_DEBUG_MASK {
>       AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY =3D BIT(2),
>       AMDGPU_DEBUG_USE_VRAM_FW_BUF =3D BIT(3),
>       AMDGPU_DEBUG_ENABLE_RAS_ACA =3D BIT(4),
> +     AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY =3D BIT(5),
>  };
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX; @@ -2229,6 +2230,11 @@ stat=
ic
> void amdgpu_init_debug_options(struct amdgpu_device *adev)
>               pr_info("debug: enable RAS ACA\n");
>               adev->debug_enable_ras_aca =3D true;
>       }
> +
> +     if (amdgpu_debug_mask &
> AMDGPU_DEBUG_MODE2_FOR_POISON_RECOVERY) {
> +             pr_info("debug: enable mode2 reset for poison consumption
> recovery");
> +             adev->debug_mode2_for_poison_recovery =3D true;
> +     }
>  }
>
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned=
 long
> flags) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 816800555f7f..a355b2bc2214 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -164,10 +164,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);

[Tao] can we apply the debug option for all ASICs?

> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> @@ -180,10 +182,12 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SDMA3:
>       case SOC15_IH_CLIENTID_SDMA4:
>               block =3D AMDGPU_RAS_BLOCK__SDMA;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     reset =3D ((dev->adev-
> >debug_mode2_for_poison_recovery) ?
> +                              AMDGPU_RAS_GPU_RESET_MODE2_RESET :
> AMDGPU_RAS_GPU_RESET_MODE1_RESET);
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       default:
>               dev_warn(dev->adev->dev,
> --
> 2.17.1

