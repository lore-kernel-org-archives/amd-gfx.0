Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F59C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 04:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB93A10E049;
	Mon, 13 May 2024 04:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDOsvtnS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8C910E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 04:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMuMz8Yk3nYSwMJXRSh6NAuue1UfBxe+kKwSjxMoLmpx7Ah28TRuMvqWcYk6psOkCra6t5YkajnnVs9Yb1JXNXm+bf1D89UFOOaxLetcdpMm8grYdKpokB1Jcr/UG3lVWtZsw2moRpEGwJhSEZ2rzvNLikMUZH7qEGCI8ehw9oLVPF9bismK4uom4dWOmwUZrqbw/wzTwVijfaF+foFW7/9kTRaH7zFmBFO7OCfCPxnR1WFtn74AuLImJZS6DFtqNpNA/S9TunwhBNfJ+YE3xN6pX7Uxfi+bYxeGNWWRjOtenMgmGRS1j/dMpJIzMsPxe8vx9t6JbGNQzYuc79HAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vu5xcm/FfFeOjyEEqScxdaLGXTlb3ovX0Per2hXP6c=;
 b=YAIT10QwrRmi6ocR+521/pHoQFDaa35a9koCVDFHpO9SnjjPfNAIcNvMIIKfr0XNBhCJRPkP+rPV7NeKxQnwcLXCTntCTlNo6nNkB7k1QtufB0aZy9saZhbNeopOnio5/SxaOkY0nxLeiACRmkOvgiguAnNV3uOKDMJuQzn4xXuTFsGKXdkthuNKzA5DpGdjHH1Ype1DE+dAhhreh1CA1Ey283j9HY7O/5pwXexeejw8Fk8fVSXwiptNNVngbzRXGwV+5/7/VSaHCn8KytG0znBHvFOHa1TBe3NlRGaB2btTORjztwBY5Nk8kvla7v/EDAQrcVYqz83dvELtiGz3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vu5xcm/FfFeOjyEEqScxdaLGXTlb3ovX0Per2hXP6c=;
 b=BDOsvtnSz5JpdafH5tCiukIRVx8IqUDkB5z9yOU9ElkTp8SnURJ/8t8pFdPaNwsGFgM/hK97dMZ4+DSjhEKfRDISpcWjBZbVIWMX7pENHHHnJpSruNVaL+5N0Wqdf8DleqSP0s8+PS+A3e0qDpgAe7tW7/YQno3aT9PjRqkTkkk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:06:06 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 04:06:06 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Topic: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Index: AQHaooVbhctGbf4y0U6wZaK3/I021rGUcsoAgAAOF1A=
Date: Mon, 13 May 2024 04:06:06 +0000
Message-ID: <CH3PR12MB807449947D2DEBC78B1F6B6FF6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-18-jesse.zhang@amd.com>
 <DM4PR12MB5152F766B9A117B703AC21DDE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152F766B9A117B703AC21DDE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0cae49d9-55a3-465b-b45d-61e2f78e0db9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:18:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SN7PR12MB6984:EE_
x-ms-office365-filtering-correlation-id: e4501e09-4967-4fb0-4762-08dc73020374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?7z2sz/j+/mZiTsfWFW5R4qhguDiSuxbCgTnWdhoAzWkEZmCn7q+oI/yX4d/D?=
 =?us-ascii?Q?OQKr+e/J/WQH8QFytQbWSvr4kn/pdTW0VCOQbtcHg5yVAGC5egYpieDJdoFO?=
 =?us-ascii?Q?KtKOhfBPjcgdWCZiIEdOy6Y9AF67mIF6GJE8tYSLrInUMAYZ4Hms+tndo42N?=
 =?us-ascii?Q?Uzzk5H7FUQvOd2BXEUzgi68cZOjZo2s2JppTEBwydAshAzCc35NuZ/RA/lll?=
 =?us-ascii?Q?PNNXhRuMoQ4BJVeDWFbHpupeEjis7lBq9CffYn9eE4MZekixJjuwY/hfC8Eb?=
 =?us-ascii?Q?e2mhb7mLFDdaAC6FfCH+WKi6W4McNr1zyUy7BhC6lC2M4DOVMrZazSgo+SLG?=
 =?us-ascii?Q?rZxlQe+uh0j5+pUyzE67LofJfg3ON9o5G9HYvHEyQzeS3xECso60BEAn4zM7?=
 =?us-ascii?Q?RsA2pzGcsCfx8yjn0+Xb2Jl+Hop8lCHk6FuDBurClEZ3baHYP6iTvjXOwJwk?=
 =?us-ascii?Q?Bo8XSdnOIgrBEj+pZJIKh5VbN6LsQgaqcGGQKIehGzFNbL0t/iaWy0H3kTwS?=
 =?us-ascii?Q?4jLRlWKnzG/2FlmKtL9d6c8Ibl2IguC6JlkGO4Dn8HDqqTRsX/MHM4pcOmKe?=
 =?us-ascii?Q?xOVXLbWrNiA9DKp3g46yzNQJ6bOrwiZbWEL/1lwGijBtfkG6/0ep3dWhlY72?=
 =?us-ascii?Q?eUUfFihi2LeMTwh2j1qqMikew9Kg+kAnqpUZSmVFWuEYcC6EFIVCF76AIeBk?=
 =?us-ascii?Q?5xJr3/p0zu6GKIXk01tRNyTr0k4RtU90Kx/5lL1U6GBqsC8ikppWdccsgWiR?=
 =?us-ascii?Q?KldVZgAyWJRcKKnlvJyCQJXjEoiFXWCh9bVHOehqcQnSn/hKb6ORl3CoNUBz?=
 =?us-ascii?Q?ST9BYE4utaCwc/XJYKDgQsoN+ohdyw9W51jJiqafjmLCqz1YjTBdPld4Amgw?=
 =?us-ascii?Q?6Ymcr3HwEkan4joiakSYp8ipeGk2j+fEXcPrPT5JTfNQDqDhOjyUkfK8Joq2?=
 =?us-ascii?Q?WI9esY5+kvTiXXdZ1qk2wLp/W5vOqEqWcQta+UAclhU0Ac5/iN32YngkAmrA?=
 =?us-ascii?Q?va+E50RduB4IeTylKae07J1XEZjjN7a8+ulRRyYN87+pIU9L+rYlNCVDi1wE?=
 =?us-ascii?Q?hh24SxkBuaa7JRF9MMlukD6szZCGcHJA5ZFTMNmgReW1vjT6m+b67wp/KiFM?=
 =?us-ascii?Q?Qh4wkZrUAGKp9v8CGfgLUrVEXXfSqhUE2p9KPgGdrzVSvKh9iM/3WbYc/NVz?=
 =?us-ascii?Q?0GSccNPEIIEJ5yO2K8unq7FnpTQC9ct5liH1cvb/uKfwC2QCO2eGwe28X8m9?=
 =?us-ascii?Q?Rb8ZXCuG16gaw7XRPtnenbUA+ruvYTKjr2qfWSQYd+sGEKiJ/obrEyf5h4X6?=
 =?us-ascii?Q?XWbRlJIQZOceguA+TWXfUL314dyIo99xVBoxPYmLPYj4ig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VU6I1lUg6FvdC9P8FAp0+6xXGu+K8ZmEQ476dB9M22bGQoIr41B+YqjRTOWC?=
 =?us-ascii?Q?y5LGfB1aHhigGiq8Gr7Sk7vNFoVUYN38AuwzuvsPzd0okLrfNLWlcPXc/VZM?=
 =?us-ascii?Q?PXQCXCXdhXUkc5niDF9N0MZa/j17xzBi9JCRIadqwGRz6Ds5qQjcJowc2lYS?=
 =?us-ascii?Q?iWZj42P/GkwEYGVEEASJl6ohQPlb6ovfZNjfWJXOS4dUuCYaSSE9olxa6cGU?=
 =?us-ascii?Q?hdnHkkMsLGT6FoQw2T44QWYwCYIpt4Tyt8m/cN7l6bmOhban0rdN7zsbbvT/?=
 =?us-ascii?Q?PjKdzqOYwCilW6jbacJ4c7dZqihhJk/trJn6qZNULazrZvKY2Ky0XOcIvYwW?=
 =?us-ascii?Q?tIVjjeWTM8a61xS3ZuAALA1RpMnL6XJPb7icSSeKLeI/hudSWgqIKScOYQSL?=
 =?us-ascii?Q?BTZC/3fpVGV3ufn17SbZTflGW/E2cc8fybQaoVO+q6zup3RAnKvS3PrFSFS1?=
 =?us-ascii?Q?F/sLCeFpgah1Znc3yWqsdrdK/CL1qbyMV6DEj+uuwyQYanwKqEVTQKmXtnzF?=
 =?us-ascii?Q?twiJvkEETGdp0pg8WBSZ0W3b4JrtVnDnpo16P8D7uJqkppunnjCtjYZOJn5y?=
 =?us-ascii?Q?LUbBhz/RAh6NoCFf7A+RM8Dilo+TwhNWQlDbcdZK42pG2aEAsjP/5jDvlqut?=
 =?us-ascii?Q?ns6lgj32UFuTFNLB8GABiWh3hQ3vVnZApLXSs9tmskkSbgwtmUx1wHQ4cHpC?=
 =?us-ascii?Q?BBUboUniuDZd8EdDwXbqOwFPyGwbhXz8aI/fJD7TIyIMuARr9V1afkXoH7PS?=
 =?us-ascii?Q?8CGbnFY12YajiiGzrVz6kebbwFUODBkY7RbyMZAea+aHa06pMk9oBmQtq4Pa?=
 =?us-ascii?Q?id/gCFrwbrYyFsS9SDnijFKjxN3Bx0Z0LxQWVlR6h8z1d66xaLtznSb4eDoT?=
 =?us-ascii?Q?XRQGmBMD1ZwT6w8xZ9QwfWXbySNzHTj2sxaZgKGGsPDJEXchd1P+ac547jEP?=
 =?us-ascii?Q?rcqIJWLtW42LMg1tHJ5GA4Nl+TUz9nZ2x02hq0Gj5GAIIzNVf2lkiYywbVHO?=
 =?us-ascii?Q?FuAbqlOmE/aSHM7SucDy8XCdr/zJaLlUFZh/iOYIs+lL4TMS3uT6lu4ysAw1?=
 =?us-ascii?Q?c5xYtw7bgmP59il6T1HGxVcB3wW4oDK8U5A8RtprR91QVgwNxJgq94o/3vYS?=
 =?us-ascii?Q?ceva89pEVdrV8mtC7QrSFLvaAveI+pi1Y2fcSq8584iStFQO+GlWCYv3XGIE?=
 =?us-ascii?Q?8sdpyZy8/VuHm9xCM8ohPBntpqfeZDy8rS8fvVf+NFUMnR9Pzpzyqp7APGmF?=
 =?us-ascii?Q?ISAYs5WV62bLJ5dAFCs2u2hC7MZvA/eo7UGLvlNEUA13Bks6LFjXLJ6bYzbU?=
 =?us-ascii?Q?6eMH+k9rMelfwGKfE8+PDCQWv6/B4PCNrHFjEQtfWfAbf5eMcMwZA1YgnkUs?=
 =?us-ascii?Q?n396e/QiDSavbazNQdDSufA9u5QSjx/+ukv2Sp/r1mezrkj3pnTsYhX9U1BC?=
 =?us-ascii?Q?yiyN1NsR4nfll71k8aswiTIEHnvzi3D2FZ2O3K+SJn1vKypwhiThZg/jHz1T?=
 =?us-ascii?Q?hJ7Zr53Acbi0J3HhKbfeO/fQ7KfS4Wc4v/28fi3TB9wMZXOvJMtb34bmv4mE?=
 =?us-ascii?Q?ST3/xvVtv43whKJwQzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4501e09-4967-4fb0-4762-08dc73020374
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 04:06:06.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiCfxMy7sLYevQ7y3gEIa6CN7EvcyvpVDrc/3NOHX5XLirkHbYjEd6OfyinnR61hUVrtQyFml73fTQbjHRW3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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

Hi Jesse,

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Monday, May 13, 2024 10:19 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table
> entries
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping ...
>
> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
>
> Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr)
> returns a negative number
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> index f4bd8e9357e2..4433ec4e9cf2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> @@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)  {
>         int result;
>         unsigned int i;
> -       unsigned int table_entries;
>         struct pp_power_state *state;
> -       int size;
> +       int size, table_entries;
>
>         if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
>                 return 0;
> @@ -45,7 +44,7 @@ int psm_init_power_state_table(struct pp_hwmgr
> *hwmgr)
>         hwmgr->ps_size =3D size =3D
> hwmgr->hwmgr_func->get_power_state_size(hwmgr) +
>                                           sizeof(struct
> pp_power_state);
>
> -       if (table_entries =3D=3D 0 || size =3D=3D 0) {
> +       if (table_entries <=3D 0 || size =3D=3D 0) {
>                 pr_warn("Please check whether power state
> management is supported on this asic\n");
>                 return 0;
>         }

We should need to check this before set the hwmgr->num_ps and hwmgr->ps_siz=
e, otherwise we may have incorrect hwmgr->num_ps if meet the condition tabl=
e_entries < 0.

Tim Huang

> --
> 2.25.1
>

