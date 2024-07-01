Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C4C30653
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 08:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C7510E344;
	Mon,  1 Jul 2024 08:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jy1b+jyG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BDA10E344
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 08:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VisPN6qHserbS9SRRAVx0LXf3clVeRKcJu955kITiZxVsMiqHgCxWuJ5qJ19mWhMiG6QY5RtdpZ1wps0BwqPFBlo+FMGgHIsYd6blUyO211mC+0HI3FHCClPZJ4iPo9/Pz2PlcicIXrSqIvQY5w0GxSLhXuSH+6TPxEZRzzvC1llmQWTD5Y+Zzby/aGUiNgv/FlTrZBCePe/JIxHA4M2ipmPsF8FlbwGihrkGJ+odbqlGrhJfGHA5ciqu9eIPci2zOVWm1epkfdUXCiNjS1a53k7jkdoRnyu1DfiRcg5XqnyPIVbxoKfoRUoxK5MOys1qhGoWAA6JT0b3s7qzTWDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEhyuCZXfKgZNLFiOXanMRc6IFrW+XYrdYw59RuPokY=;
 b=OINhZrisogTPi1hppJHEmNBvdjePdteByDZqfFPu1R+0pLtCXC0C+78kW2rzYdICgvVvF2xU8AGVV8DAuMQnBVUt/vThnrzTYTxab22BqAmRITy7/9pwjEQe3pSTMG5xJb0sGwvrEn1W85HIGV+H9+xv55ahCrtR3vOQlUwGQz1FcT4DsXbEKSy0cSHGQhQ5NFueghogrQm6VtTSwuk/hIIxA1SRLnfu42+OeSnfNUskyfc3NlEMQxz6PirclsQqxIROZ1SLoDmG4PM55sTez61xW33E1jTnQEaZO3rb/IEmVKjXXdXqo1wabrg3bWj7luW8nqxG69u/tERpxDNODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEhyuCZXfKgZNLFiOXanMRc6IFrW+XYrdYw59RuPokY=;
 b=Jy1b+jyGUDK6sjCasXkuR8kYurKuR31el4yhy2SMH/L4HVLiJyPCs6mpmT7HRHtYsanKB5EnerAfRm8x9KYSj0+Oo5aeGUFbirL8SITOWuJ7rETIRYLr0pISROkDgQ85NaW3ifsQ1D9kYJQmDBqPQ+DKhLS/1TxOAJ3VhYEFHe0=
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:13:54 +0000
Received: from SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57]) by SJ2PR12MB7990.namprd12.prod.outlook.com
 ([fe80::b83a:d225:234b:6c57%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 08:13:53 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Topic: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Thread-Index: AQHay4483/vFmdZM5UCkmTyP39YIj7HhhfWw
Date: Mon, 1 Jul 2024 08:13:53 +0000
Message-ID: <SJ2PR12MB79902342EE435050707F9E3F9AD32@SJ2PR12MB7990.namprd12.prod.outlook.com>
References: <20240701081050.21825-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240701081050.21825-1-YiPeng.Chai@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7a9a54dd-b03e-4c2e-8e1b-7f60bb92bef6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T08:13:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7990:EE_|MW4PR12MB6705:EE_
x-ms-office365-filtering-correlation-id: 48349997-aeb3-4cea-6226-08dc99a5bf5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?agduHmB1LqQFjDEc5xtXEpio/UpGGr2yQaAAg8xJONP74S5ppjIpOqsQEemE?=
 =?us-ascii?Q?V3M6/HA1U14qB/VOGjGndWbQal9bzoKFlBy3CSkXPBKs0PZJ7yE6q4bNVcAd?=
 =?us-ascii?Q?WsUzrc8MPOhJ3W9buCPdnRbWFJEKxfnxXs9Eox1QauMtpJtlQiRi1jZtr2It?=
 =?us-ascii?Q?473lbcRbxJVSxMMcoBnbwf1NpKdpe5BEKQd4rF/Wn1s+JU8lpwqHWYOvakBQ?=
 =?us-ascii?Q?OaW5AYfmq6MoDPJWmMeysI3JLbH4jeLENyKG7IbTm6ra+dGgsbI5KBTPt5c4?=
 =?us-ascii?Q?AWfJnPxuMJVUxiMfbscSMqfiEVWKKq91CGRoQ3ZEGoeKP6Vqd2gCaQpU6kAO?=
 =?us-ascii?Q?j4mp9Vf/5rwWlFiE22QrLamdAjc+nlWXI8WVb78HQN1gQIhidQL0cYQB/k+z?=
 =?us-ascii?Q?6ZmiG9OanMA8AyN3fzh807INnbXihHZzpuLhUTLskwg/TYVZ83NuudquS53z?=
 =?us-ascii?Q?cefyYDKB4f0wQf/oZxh8gagossG8SH7m8820kYSHEgdX1kb5HvPkt9xiB5vV?=
 =?us-ascii?Q?eP1sOT4X3I8NBH/q4MYpEsljf2tvpiHede/AkzvEcVALuO3JoVTyvjl6AvG9?=
 =?us-ascii?Q?+1SOnAFEONn4qFJCE9Wh7hInS9CHVGBYkLEA/6MYtNU8tkrO9QnpxEWRo1Jp?=
 =?us-ascii?Q?rbl2vCG4VfafBXHX2V4DPMghmXXS80eQSalDmRW36HK6a6YCfTVaSl5oJ+Fm?=
 =?us-ascii?Q?rzlM3EiIHcUEajOXvnFhSrXAnZaGzdksSiWRiG4AMSXEwsL1gdCr4MEyQiva?=
 =?us-ascii?Q?65Ki3h3lJOxKSniWG9k/mTRnlJnc75bSBAsKv4qdPm72Z+IY89RzTfTKgDDt?=
 =?us-ascii?Q?mwawWtMTtR8gQYSC+YElKk0B7ghOcaIVxx6MkzqHc3fLtrsX2tNmGT53rElJ?=
 =?us-ascii?Q?qw/gyJ2aUriXL0nv42db37Vdi/CC+yEwHs1jcFfGXlnyDrPQlwzhvRfZ5xcy?=
 =?us-ascii?Q?YqV9Gtg3kS4BFtx4ur6uqys66Zibz0FztlkMz8vIodYlhUhVNt8+/xwGzd4N?=
 =?us-ascii?Q?6T7Pl4uaby2lf15MVL3A2bJcPls5o0/DPGbeWEfwd0wxtu0S4MzD+gM5J26I?=
 =?us-ascii?Q?AjnH9bHICkrVW4v/zugaqwZScXfSC2UnRIuvCT1NYAGVpIWwM1uX89mrC+r6?=
 =?us-ascii?Q?/ndHlrMXW79GsAZSES+F9xtetPkufU0n7vGIStTl8GNtyEzdT6QxhdFQ0Bgx?=
 =?us-ascii?Q?+XVigLLb6VE6qZxCRSOZsHP1VfS7q0ja7woQDcrEbc5s6l9s/5Dc04XdKBPE?=
 =?us-ascii?Q?1tFCHd6OifTM/6GTmnSup++YVvrgsMEqTOadGO4tqv62vIAPJv5OlGadIkP+?=
 =?us-ascii?Q?BLAPRxsvGVJxcET/2bWXJtwTH5FyU+bBn+4oAoWAlhxKLtZacIV096XGa2hn?=
 =?us-ascii?Q?AJIVbx0iMkMKsIG3UbvbMXjUfGLniYA0CKFpNKDN+eo/gqJvow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB7990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hrMUlWBfkdduXKWEK8eGs7Nb+BtbSB/SS8ILqzdjpgivhXV5DY/EZUIbuFa/?=
 =?us-ascii?Q?/pxnvYaIOdd/48nW6DHzcSfyuo4Pc7XLpLk9QnzOOTOHM2m1hQlGMj1a7aqo?=
 =?us-ascii?Q?yManLPomyJYCCdWfn+1X+YPv7Ejlq/VgNOZ3fJZDerY+d0jpMN8t38/nQGGj?=
 =?us-ascii?Q?SioaUBgyl1nfitz1HfSYeMJ5TJyTIBymTh6cGw+zEyFwReE3JxizcL868fcs?=
 =?us-ascii?Q?rkM+rn2LFFMPsDW76uuoyG8l72djK3PynU1rJHIpzBRcHGJ0KOh3Z7raZPS/?=
 =?us-ascii?Q?kpDPPh3Pv0doES/VLTy9UKx7Ye0e+K2Nn8x2RhgLNvvysu52sBaxDqH/0ji/?=
 =?us-ascii?Q?udNdreEimpx3PnAslnzwVG9isafWoE36Y15kkgV9dDRVu/Ov8Rn79kpV3XpI?=
 =?us-ascii?Q?GD0eqRSi5MrnhDIgr6dEZP15ZJb6Kw9Z/XgpJf4wTZMV8I8N7TyQHwJw77pQ?=
 =?us-ascii?Q?jJd819omX1Xva7U7zVLL5A7CMWGlH7PyVUnCoBsmSEj3eowzZqkgwW4mDCKb?=
 =?us-ascii?Q?8P/T+nK/5seB9gEZkDY59RwLkzAvskN3HK7VdOf+uhgFpZu68N/rAMeIxQ5N?=
 =?us-ascii?Q?cJn5CGFkOH1ma1LWaNjsU6BOVgGSXnM6hDptVTwzROjAY7iCaX5PQp5KTLRC?=
 =?us-ascii?Q?GM9SDOf3SXw1vHR6n6aFie/67ZopLvZCJi4tZZI3ZNsxnJvlL5v6whQ/TysV?=
 =?us-ascii?Q?XPtRTmfEadmgKj0hohfJpCjefXGVrsskJTLEUbHuj8c6djqvo1sJ58GtPBA6?=
 =?us-ascii?Q?54egX9QqD5rXIf4MSCvHA8361RhtDTTT2xYCbee+tj0dlK/TbbeqGfTHpNO6?=
 =?us-ascii?Q?JF+opTnwM1/3hC72r99XeOiypXEdfVrgZJZYK+CuzaX576p96khtXyW6A2+f?=
 =?us-ascii?Q?OZazjT9qVEY4k6mmHQ99YtDy0i7JXM5fgY60C/PndChIlc/szThvTJce9JTR?=
 =?us-ascii?Q?qbdvB6M2rKHZHlR0iW1VmxBIGQ2KZRAr08+0ciiMW93jzsqb7kkgnCw570zv?=
 =?us-ascii?Q?g9jqCyzx8aPJX2GHufA2FanjrNqodya4psiBOUCSVEg5/3955/uMbjKRYLMI?=
 =?us-ascii?Q?3htxQ7TTyPC9TWRifC8VPivAHaUAG8JwtaMQuTDHyeb+fHUfBadw4NIq9h/N?=
 =?us-ascii?Q?QrY5FjzsxcgrpH2lZfCq1TJ0rqGVdZ7pcfBIN0aWBkfUHLJBUSQvSkli/CQE?=
 =?us-ascii?Q?5PaY5ZtD2VpPNJ2G9jyoXkSsiZinbOLaolfEzcDT/DLWLa1zXCe/acIiAdun?=
 =?us-ascii?Q?5k/QQCsCEeT9UN73S9M/MI8neD7HMldwlXuR04W3+0g42YT/e9RnruT69TqG?=
 =?us-ascii?Q?B1TeiFyvzkAbzUE7JX7y1K1EK2irBOnEU2r11JXhCqMoK9WQ0YWhYFuoSCZE?=
 =?us-ascii?Q?lrK+ozg1vMr6rZNSRUKm/O0rMZH+CbpNFHafKSKE9/KsjEpByRLIwP3+f4XE?=
 =?us-ascii?Q?kLa1yvFbBQRF2732oNR9uMdT8O15v9zZ/cysazK6TwW18/GwM7J/bkd5v1w4?=
 =?us-ascii?Q?IIG7zUN3NlOfIR5hAgWEJ7gThtYfy8VrB55FzjeCllQFmhtfXgWYojWrJS5a?=
 =?us-ascii?Q?XZHdOWF9s3IUBdUIjzY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48349997-aeb3-4cea-6226-08dc99a5bf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 08:13:53.8563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UX3oajiGSoorgDiiAhV2xklwKdDMl3KR+CeS9/bGaMNMBkLdFwgWAUUV9AbKtZdSPcKetGsQ9isdcaO2M+8Nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, July 1, 2024 4:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: sysfs node disable query error count during =
gpu
> reset
>
> Sysfs node disable query error count during gpu reset.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 +++
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index d0a8da67dc2a..b0f95a7649bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -316,8 +316,6 @@ static int aldebaran_mode2_restore_ip(struct
> amdgpu_device *adev)
>               adev->ip_blocks[i].status.late_initialized =3D true;
>       }
>
> -     amdgpu_ras_set_error_query_ready(adev, true);
> -
>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e133a9982a77..41689aa24e67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3157,7 +3157,8 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>               return r;
>       }
>
> -     amdgpu_ras_set_error_query_ready(adev, true);
> +     if (!amdgpu_in_reset(adev))
> +             amdgpu_ras_set_error_query_ready(adev, true);
>
>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ac7ded01dad0..e2abc04112d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1295,6 +1295,9 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device
> *dev, struct device_attribute *a
>               .head =3D obj->head,
>       };
>
> +     if (!amdgpu_ras_get_error_query_ready(obj->adev))
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +
>       if (amdgpu_ras_query_error_status(obj->adev, &info))
>               return -EINVAL;
>
> --
> 2.34.1

