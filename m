Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD3DEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 22:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F2310E186;
	Mon, 10 Jul 2023 22:24:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246510E186
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 22:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN720d+GfyLtoou+6h/gXRwz043eGdduabIeztybv9zZkXhPajW8nK5jH25oZWkrcHSyEzQI6ceTUVQ/Us9Lrbscpl1Wf5aWvFMvsBB74mFHj5CQr6n2+oNEUiTCkpRPAK76ICYTfNDK6kWm/LuWEQ2mIIej+seDydsgBuRUUC9Ms5ZM+ocVhT9LPSvnj5yR/kHgAaf9oP8q7LL3B7y2HmjB6WbbTDWkVczoyYyK1uXGB1/fG7GTZZIWM456cFjQsk1pExT628zBr73SQZdIKHJzeGKkhcrNyTOi9YzzXYJsGm4JGzyraHSFiHjRd7aDW4lRA/jAWyrQR7JSiJjf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20tcs8b6i3PKCxofxuxWg+x/dWi201/eUSRK82zDN2g=;
 b=FJ2ohRcYSmu//WSjl4mRVhymwgEVjBEfsvBJlletS/J5TcvHBHKFnnk8QxcCIuqbpdMfcvsM5IalLT6qCV2vaUgJNNOvQ4yry/4zaorN9A5/2os19XUosqt951FDSu38QI4uSPp2EagQcd0NUMQ82FMOR1NrCaIKx4SK9oTsgLju6gUQcm89+lx+Ot7qRSVBNzcQv4nR8GX2BPoeWKcPnuCcbjjuEB/QAGK6XUjV/ncryWC+/82ryQHMMbwk1t1XZsuDdlKaq8oknmVORYs6E9MDJPhQCfFNSusKQhjCMrhSXZeBtXRRGT1l+lV2IkEyHARhXgLzDPf/hCPY7N7hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20tcs8b6i3PKCxofxuxWg+x/dWi201/eUSRK82zDN2g=;
 b=ej2cp+XH1uCbXPz8uBUP1RFlr8FMBAMCs8D6WJfWrgUBFlnqxt2glw/PDjeivlXxvlCP6ZncnzKr1zhzGtn/hFYQ1tnY+n3dyQ1TeavHKBuYwXdJ53qUd1RBUaWKWDiC5cfXEFGEQbVpGuExhI4yzHsTTRRnFmdxOY8CwdlfG8c=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:24:47 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:24:46 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable grace period for xcp instance
Thread-Topic: [PATCH] drm/amdkfd: enable grace period for xcp instance
Thread-Index: AQHZs2cumjrRxA5TqE2PSvQUes6h9q+zktPA
Date: Mon, 10 Jul 2023 22:24:46 +0000
Message-ID: <BL3PR12MB64252080596A0A4C3E3B6960EE30A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230710194530.214865-1-jinhuieric.huang@amd.com>
In-Reply-To: <20230710194530.214865-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57094dca-6876-4111-aa71-fa7f3729adeb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-10T22:21:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SA0PR12MB4509:EE_
x-ms-office365-filtering-correlation-id: 4c5e18b0-934e-44bb-70f1-08db819477c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfe6RAobgBkNqGm0romD4TzxeBIzLEx21DdDnTkpjy3Fg7EacrgWJICM6nZjVtuytcCm/Vxe7JSAOFAvJF+JjUXy92Xd+8J62r/TvMC9z1JZ2R8O2ljTJJqCt9bp13/+5aACmiLysntS0sgc+GKBVZHLN4EPuNgMwyIB/jIverJpaTn3JZfnvCfRLgEPIODf/NpftOwFxzlXaM1x0wvsPT8JUuLPnpdyFPgOE9WDaI+Bluq8/8y/yDTC86SuLijSzBvxsAA46XkTxbUTm5XrwBJNJNMRyKxiEyP4ZbV57F++hAsy6ylgF6n0KINeMZnk5bNL5wAyTl08rY4qIDCzKK4mx1FFy2yd/TzuqZFDAEZKAY96NJ84SGMbvtAgnZm2KwWsTCjdxyfcs+fnFTnIhNbIhxcHBLsS67UTR7rrMMFyVysEArtdNBHVsBj7YFlaH78BLAi29xVFsPzxCN5bhccH0oCPU+grgv47ZCR6l+toWNHmGSKbvTrD8G1uUjbe0SnQR/sZFfalbRAFSLQbmC5vp76zfYzq06ZnWNmVVi4R9vCAin9+VfRRJRgGMAuqOI3F+dccFNkpqOgj8WsDkaH07AU3jjM89oWiG1FRO47ZP/NH8rf3IhZRd2YLoRCdh2R/e8Zx3yUCqXPHcxp+0iKtD8JQE3PkyXqTaW/0WHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(186003)(6506007)(9686003)(26005)(53546011)(83380400001)(41300700001)(4326008)(66446008)(64756008)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(52536014)(66476007)(478600001)(66946007)(7696005)(76116006)(110136005)(71200400001)(54906003)(55016003)(33656002)(122000001)(38070700005)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5sAqX/KLErBGTxXLYRDpf2vqGsc3WRLLrITwMxb2ougbX9qFJcwaH86WuKt?=
 =?us-ascii?Q?wXhnndRHnt2QATT7W8hnz5hnQvK2SxLfxJlGOAiZgi/NRK9bqeKunzZOTRuJ?=
 =?us-ascii?Q?YPYoND4+/21sgnsdx0y80XnPAd2mvRCk/pVrqZDY0ZPIouldnHRDYPsTElbO?=
 =?us-ascii?Q?GZ0jcg+WBvMtff+pU9PFhwFSYWTNGBqZDuWEdS0gW/rzaRCSayQPj7TStiay?=
 =?us-ascii?Q?HZrLBg8QUVAOup3jyekaPSGmYrHozW1Fihk9QY9wVksc29mK732lbCkwFlSl?=
 =?us-ascii?Q?hw1FWvLpxsVusB6btLd1GFqY2Z5jkrRtIeKE9yNb37pJQqjcWQUPRELXabaX?=
 =?us-ascii?Q?qn0bm6a0YzH0w6wTGn2D3u0mfX4PZ1hBssSYATOrzAhrEvVMxhKi9Y9Jg1jo?=
 =?us-ascii?Q?3qM58faQ47wDZUYLxPq3pMi6GYLT3MUraHjOWz4Ui+J4EtV0B0iQoAmhe0zF?=
 =?us-ascii?Q?qCKlAkRiMCcEWHCS8AvqCB1aEFc+Vrmj9Z9eqRC33wMTE3jvxPnOgK5Vot3B?=
 =?us-ascii?Q?HtQzKWnLQVZkjA1UjQn0Qrd3GZOf6pFqvkAdNjl8+vBPW0g98M4ZNof5UFUu?=
 =?us-ascii?Q?cc4XRgYQ/r5tFSjTTrripagizM/iOt8q68CDHphn2IB1R+xusv9vQxSxplJb?=
 =?us-ascii?Q?+kAq3QCpOqOp7Y+GVVAtwNmuFdoadIRx1t6hCRcYjJy2Icu6PnZA2RLQKJNA?=
 =?us-ascii?Q?TNhOkzmI0dNcnb+B59sXKmqORh+zTM7OrCOZLHKXbCXYERuiBC4gJMiPHC+7?=
 =?us-ascii?Q?owqz1vdEw4+ZdQawj1q8N052NCkIrggCh/BIn965R/3g2pxtC/bqOXO0Rzjb?=
 =?us-ascii?Q?qDUREQvLvfMlSl/8hkB7KaQXGuMdDBdIBFfGA77vqmSpXmGS94yjsiz2LdIX?=
 =?us-ascii?Q?X8fjIvFSgGHrf0svDcRqvVZwMIuBE4lScoKGUq6lthllBarjKLI4fMFyglx4?=
 =?us-ascii?Q?S/WIQj9p9M3kOA+Oi4u7luRLi+eg680SPh5NSYxExw95271TG4ZQFRPedAVx?=
 =?us-ascii?Q?50wxL/TijuUvPDRaPUsgrPwVaMjdYmjgbFfK7KPt9YLzhYxphadE4CbFnfew?=
 =?us-ascii?Q?m+h9MdKPHDH+jchcUQbQQ6SodjbyFSvtF1MnV/Qd8XyDTsnhCZ8cboUOCMYq?=
 =?us-ascii?Q?ltvXaPpx/X8/+dy1ZuR2TdR7w67RrEDI8nb4RnO1ybc8I9YDcLagx7Ud5b0v?=
 =?us-ascii?Q?Q1B/TEVrKQeUC6u+Y4GRzgTVXF+xi7sAR8mm23Lbki+fZky8Skn+32Wye7z0?=
 =?us-ascii?Q?jEhwQjIqvC/N0EWIcabYbO9eo+e/jkMWsHB9Eiqz9az/ytudn26OsiNdAwbV?=
 =?us-ascii?Q?bBrT3uZ0z3UceLmaZ/7d2kLEAJ0SDfApoUukjUAahl24BqWEQtR10o1sXu3W?=
 =?us-ascii?Q?3mYkXQGGlxgwgogIjpCRPjnEX+EmayeHp/GtN8edo+cSFUH8sgx556AtkK8b?=
 =?us-ascii?Q?hlhvoIRg5w3sz8wAxUdXp8mR4lrF1pRKHmdHn9l1j+IStpku56dbpnkAQt8P?=
 =?us-ascii?Q?tOoFH1QjT1DAs/D9oYSZMKm1weeT+0eOyZT81XxAQiGic7fNUPG3fyHOwf1b?=
 =?us-ascii?Q?mgh+V1umks+gaf98pPY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e18b0-934e-44bb-70f1-08db819477c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:24:46.7829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cz8+6j4fOxQ0IumNe/2FYGIx5CLUzbGaj6YA9PSHbzE0p/+2D9gzpp88+mi5uLqX+oxGM9AN4rdnSQW02EaIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric
> Huang
> Sent: Monday, July 10, 2023 3:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: enable grace period for xcp instance
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Read/write grace period from/to first xcc instance of xcp in kfd node.
>
Hi Eric,

My patch, "drm/amdkfd: Update CWSR grace period for GFX9.4.3", which got mi=
ssed during the merge
should handle most of what you are trying to do.
I will push that patch. Please add on top if there is anything missing.

Hope that works for you.

Thanks,
Mukul

> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11
> ++++++++---  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |
> 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++---
>  3 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index de83eccdd9de..a95bcb91dc09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1619,10 +1619,15 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>
>         init_sdma_bitmaps(dqm);
>
> -       if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +       if (dqm->dev->kfd2kgd->get_iq_wait_times) {
> +               u32 inst =3D ffs(dqm->dev->xcc_mask &
> +                              (1UL <<
> +                              dqm->dev->xcp->id *
> +                              dqm->dev->adev->gfx.num_xcc_per_xcp)) -
> + 1;
>                 dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                       &dqm->wait_times,
> -                                       0);
> +                                       &dqm->wait_times[inst],
> +                                       inst);
> +       }
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 7dd4b177219d..45959c33b944 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -262,7 +262,7 @@ struct device_queue_manager {
>         /* used for GFX 9.4.3 only */
>         uint32_t                current_logical_xcc_start;
>
> -       uint32_t                wait_times;
> +       uint32_t                wait_times[MAX_XCP];
>
>         wait_queue_head_t       destroy_wait;
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8fda16e6fee6..dd50164c16cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -292,17 +292,21 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>         struct pm4_mec_write_data_mmio *packet;
>         uint32_t reg_offset =3D 0;
>         uint32_t reg_data =3D 0;
> +       uint32_t inst =3D ffs(pm->dqm->dev->xcc_mask &
> +                           (1UL <<
> +                           pm->dqm->dev->xcp->id *
> +                           pm->dqm->dev->adev->gfx.num_xcc_per_xcp)) -
> + 1;
>
>         pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                         pm->dqm->dev->adev,
> -                       pm->dqm->wait_times,
> +                       pm->dqm->wait_times[inst],
>                         grace_period,
>                         &reg_offset,
>                         &reg_data,
> -                       0);
> +                       inst);
>
>         if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> -               reg_data =3D pm->dqm->wait_times;
> +               reg_data =3D pm->dqm->wait_times[inst];
>
>         packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>         memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> --
> 2.34.1

