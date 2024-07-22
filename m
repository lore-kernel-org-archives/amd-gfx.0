Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C25EC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 03:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB1B10E18A;
	Mon, 22 Jul 2024 03:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmtFuSS3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B1D210E188
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 03:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv1fKdD2cs8q7VFRc886rnfePi7Kh5nRSTKltm0EwsXEdkdlR0+Xvwz05G2R9C/4K/EuAWEF2c74Y75mXvhS87XD30dOw1QyKqlblJdp5tw1QkFaTcpMMbbAifOXluMlClUIASblUx5pfyxPJLV1pMSY/Md900IBsQGtPgM27kW9xp6iQEuImwF6Pu8HfermXI6moVSjai9x0V6J4Flv69XrImY6imEkh9R/pGIXnrROdnXQnTmIguDkC3MFVjprsi/Fhw7LFElhMv/9749zPvHGZrT7Iou7HlfgwTtIVOB6m+fQZmR77j6+aqnRcoobXW/TRenoe5FR7utfdLGd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCYvHDQXN4CUt0IIgm3g5XvOYzkxjvwXZ1O91ZCEWyE=;
 b=IS+ykopLY+vA0iDsgtaKRy175DCmNYYQl+Mcxn7PTL42DUvM7rzNtQYePcsJ2J0hFLx+oqj8YEn69N0oDcfqImkg9H7wLU+7Y/XIj1+0jKG7fu8pTrE7+hLqScoJnWmLXbjgvtsUGVi0NJKJ4SHr+cLyJNHO4YTTRTpJV3fBekNHkrL3P1Pg+OpuHh3G4Atdkh9xp28eUhYcmSR2qHxYrDPoHyc3jtxjPriCxsXpjBZmYXTaxuqjhnbphS0F1I3UKP2pbdIUmzptuyrmzIowa6W3u1NQvQMayUKCX+5zT3ZJ3UKBuPbiXMFp8iDGCMleruMBT9p5fglwebtr34qKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCYvHDQXN4CUt0IIgm3g5XvOYzkxjvwXZ1O91ZCEWyE=;
 b=tmtFuSS3qS5H38FCkMv8UWkvvpnyPbzGlRFpgM/+DkfAnycrYVcfNdb511ToxvGe4HOwfC0YXF4oD+T3WOyTcMhNpqOy0PLTdaGFilgT5nf1TGfIgV4Gz/paQ90gO5rHuNJU6u89LyY0G9caR4NU4fLh7BlaLHmJXeoAyE7AnUg=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 03:27:32 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a%7]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 03:27:31 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Topic: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Index: AQHa2bx3Lq6MdRXCn0ej7o1d9ZHJpbH+MY2AgAPoXQk=
Date: Mon, 22 Jul 2024 03:27:31 +0000
Message-ID: <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
 <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
In-Reply-To: <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-22T03:27:31.378Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|CY8PR12MB8196:EE_
x-ms-office365-filtering-correlation-id: 6b4e4e9f-cc62-4659-3edc-08dca9fe38be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GjNjKG6K635qoxa2poz46sP7IWMap2stgg5JFKrFgan8+1eMUMORszdpgK?=
 =?iso-8859-1?Q?bAUYffQu/fWeCzHMSRp/+03NT1Dt/EMAtiNnSZc/qeqi8TbBnn2llF30aD?=
 =?iso-8859-1?Q?J6AXYpUV4WCXEkWRRhcmMOW/TNGr/zW5935YOMBRvLNsL1LnOO4Tv2EkC1?=
 =?iso-8859-1?Q?11HCwfr3ScP1mFlRADgtY60v7h7GuMUPuvLCZeg2up7IT098toy3Zr2BAS?=
 =?iso-8859-1?Q?VtHMoYhxe1k4+M/f0zNpI7aRFR5hrebHz54Xkd6Q6R8bCes4gatbwyxj7X?=
 =?iso-8859-1?Q?FCfZIwO/wvbGCCM12DCI7Z49yyS/YAPmTuxvNEHq2hNCDk8DoJx9d5rhhw?=
 =?iso-8859-1?Q?U3bdS+JP8NLn0ngHVrXUAeD30IjJoBnXeFxYSQaENMRAlkbsUlL5TB7VA6?=
 =?iso-8859-1?Q?eMjh4JY9sHm8J5AVVSQ1iCiI7LYxjbC/sVP1s/PDe1Jkdoow1EudAT2Fo9?=
 =?iso-8859-1?Q?vh4BSblVlXgLJ16E1LlIGxV+r2JUodbSmVAv0ZsgUBopSXD77PvPMWpMTt?=
 =?iso-8859-1?Q?9i0JuiYHLqn3oT5aOfuELwUAt49oyR+OH6jp8rp1nQyF4azR9rQL42qWEj?=
 =?iso-8859-1?Q?NLIyH+tFK2zkB17YubU24KFy+otRILA0YtmzrzWXX3cYjvZozgLhgM4zFO?=
 =?iso-8859-1?Q?XwGQJqizRc0mnMa1y9QG6mADTY/FEvyxucyExiWshu3ewapex4h9GETYWM?=
 =?iso-8859-1?Q?uSywkzkYlIhYv6Px2qN85OelOVI3GW8lrDMUMIbT+YKFxWHtSxWzr+FV9g?=
 =?iso-8859-1?Q?QO3koTnWmE3Ljw7ZIvoZeel2bVyXpkKahm1telMY1RI0DaU03Xn+ZYpBY8?=
 =?iso-8859-1?Q?eeIQ7Z9EP+tqKsALnG+jDPOWNg3ylyssZDoJnLinXfXexJ2uSYKMoGuDqr?=
 =?iso-8859-1?Q?3T3NgUmy73mosajZKiuB6utbhcvaVIilrYKtuzqxLg/bB9AbXiWTJCiU4c?=
 =?iso-8859-1?Q?eSilkTffUPbZy8ubrBrqgDmBIryPOVjF4W2gsZX5y8kjrk6Zs7g14UQSCB?=
 =?iso-8859-1?Q?G5JetZ8/r90Rbfxmlq+fAVxJnOmEnMk4IRbg2jKgExnamkROZ2bmugJvbs?=
 =?iso-8859-1?Q?js7F2RNmBMipzSogN0v85bE/MWtZKdTazWKjLs1aoYJHnuB+2bLdrRq3Gl?=
 =?iso-8859-1?Q?M9qDreEkOeCKd8Wy1hTls33VS8hGRVRui1itXl7y/Pm1/Eg83jXDPXsmNs?=
 =?iso-8859-1?Q?lbZNqC/pZ1uYml4Dgcj+qcYijwMwOgLKqJSifEeTgbWm4yk46WsaImarEJ?=
 =?iso-8859-1?Q?zCXioCwATNCaM7+D+nFLSXsxU4Nv2hfLke1ekixaZlzy6ziHXqk9MdElvk?=
 =?iso-8859-1?Q?YbkZ0YHl/p2Ou91cJU903BeKmsfE6CK9+pa/o0QC63AuPQR8yG9c2fTCTi?=
 =?iso-8859-1?Q?weReFMlSI7FJRd5vlJkG4xIMIRIzL2fM2XpPQHBphKgY4qu76d03pOFrTe?=
 =?iso-8859-1?Q?Ikfn8CZv46y+d4PZOmPCqwShkD/NQZ9RM7N0eg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z0a6CL3RK4JkkbRFBQDtXsQc8QsYEJKB+D+qDSetskv4Exg3sIJhzRPFLb?=
 =?iso-8859-1?Q?RUireyqVw7fn0vozTDzKqHZfNM8fOG1Du5XdfCOOotbM+fc2IOeZJWjMMy?=
 =?iso-8859-1?Q?ilv1T2uyWRZmDzK3yVqJZMFmFl34O4WP4xYUNPIlkku/UCGoCE6CRro4Kq?=
 =?iso-8859-1?Q?HKUN+Tr2BZKCIrBIx/YBwgnTOc0KuD+Yz9jND/2h9vF8nIc3XUalnHtvs4?=
 =?iso-8859-1?Q?w3vNK1pVlDmt4DWpsK/RGVNqsspDi/MlEsFFfmJO/yQjPz5DOdFMR6sWPN?=
 =?iso-8859-1?Q?VH+lcW9nIw+bRcQNIvwiixikVQWyFyTG6FNjyUBer7ZLyDRbHAH+w0z6e/?=
 =?iso-8859-1?Q?O5APX5Ti+MbNP3mbbqAFD5u+6U15Sa74C8OEmcNIplfH/uSufqS3p63GcM?=
 =?iso-8859-1?Q?8HHo2FLObATrDi3Nx3l88KKEgbOR4o/AMtvripljev97/tLdQ/sHFXX/Ho?=
 =?iso-8859-1?Q?cxN8YyTwCDMxvK9SWyAJCv9YMauMYrdB4gXVVQKe42opDyOxGmssbryYBw?=
 =?iso-8859-1?Q?7abI7clhnM1ZvNZDyaNgpuxXTyDj240bpyJ0675cFO8wDOnI12jI72XYr8?=
 =?iso-8859-1?Q?xMDYMUb1C0j0vZ76ebwAM5oVyUq89PAUtUIQcNqH70Spu9ou5EGm+1FZlX?=
 =?iso-8859-1?Q?EeiV9RKizEFGkkuxiNy46/FFLgfbmawGONXYOviqrCtexXPWxUoSdAJdyj?=
 =?iso-8859-1?Q?6sJVZJ9Uokwe+Tj4OdNEBYGJnWEXT0mNU28yHmaYi3E2UluS2coVq3t7y/?=
 =?iso-8859-1?Q?S0iN2ObZar8hsDHPJ0xkoJeZSt9836lSKAayyATb+HNsFpHCCLxg73XF5+?=
 =?iso-8859-1?Q?dZh1caXvxLI7LIvi1VMho6KM9y9w4hbtnLL0Ww/6dFSb74nEQnW7HOkorB?=
 =?iso-8859-1?Q?P+kK4vyujQ0VNqefVIA5bBK/66z4hRAIQidYrHKCdYVXSep2IjChbsLNf7?=
 =?iso-8859-1?Q?FXDuNz1eN8Bsxb4FtWLkX2L+cSMDDvBCO38VhTgiS4smosz4VaUUah/hrR?=
 =?iso-8859-1?Q?/4OCSICY9vO/82fNMu4myv8KWOk3Wu0QOrtzXiloL8paNrly+qVVwpdDFH?=
 =?iso-8859-1?Q?cr2R8ig4/snbjOK18JLHEMRaXi2UYKE/T8P7IBkYPZlCarUy3HilH7tDY2?=
 =?iso-8859-1?Q?RrPr/QzrZmmEJEozXMe0Ysq9ReSdF6jyIEY68an2YRc/OL3S+JN4XKjBwT?=
 =?iso-8859-1?Q?Nrvb5xTc2lZWhaW4ArJJl4y3bG8zZzbH9+oIuKUUo1vikmWoGghWQnljdS?=
 =?iso-8859-1?Q?qe6MrLhij63KEEd/8Thsu0qP0G96SujTJuju2FcHCdxOfuLY0QnE1JO6Pr?=
 =?iso-8859-1?Q?+ZAOe692srBURTzKaFGVtyIOAGDNDsgeLYXvWODATmIpxs5BKBExoETNPG?=
 =?iso-8859-1?Q?J2z9/MKxqFFWlhTEwnyb4UDyL8DD7C4VHgQ/OlilPf1dw9+q9P0skR0nb5?=
 =?iso-8859-1?Q?DuWLTHVybbhxhQx1PBPu7UCU3q6tY4FmV8kZk/YqMeuA81q5wFl3WCPatk?=
 =?iso-8859-1?Q?UykJjTw0rkUIDwSuFr9qEjw8BB03C5hhJrdmsU6MQVVbnIARetumVjnzbP?=
 =?iso-8859-1?Q?FKxuZYr67o+yy0Mr+dNXrpEfErbygO/LLqFK4dI8GZRTY4fI58KCJxwqU6?=
 =?iso-8859-1?Q?gPVmBvsq1xuBw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB68417B9F856C92BD02912A08EFA82PH8PR12MB6841namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e4e9f-cc62-4659-3edc-08dca9fe38be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 03:27:31.8337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yl152itFuuzeCBjcWFXv1UARiH4PYIATHIslYOhFz3I+bkys2x7xrEK5Ac6YPkx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

--_000_PH8PR12MB68417B9F856C92BD02912A08EFA82PH8PR12MB6841namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

>> I think we rather need to increase the MES ring size instead.

Unfortunately, it doesn't work. I guess mes firmware has limitation.

Regards,
Jack

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, 19 July 2024 23:44
To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow

Am 19.07.24 um 11:16 schrieb Jack Xiao:
> wait memory room until enough before writing mes packets
> to avoid ring buffer overflow.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
>   2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 8ce51b9236c1..68c74adf79f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>        const char *op_str, *misc_op_str;
>        unsigned long flags;
>        u64 status_gpu_addr;
> -     u32 status_offset;
> +     u32 seq, status_offset;
>        u64 *status_ptr;
>        signed long r;
>        int ret;
> @@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>        if (r)
>                goto error_unlock_free;
>
> +     seq =3D ++ring->fence_drv.sync_seq;
> +     r =3D amdgpu_fence_wait_polling(ring,
> +                                   seq - ring->fence_drv.num_fences_mask=
,
> +                                   timeout);
> +     if (r < 1)
> +             goto error_undo;
> +
>        api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status_=
off);
>        api_status->api_completion_fence_addr =3D status_gpu_addr;
>        api_status->api_completion_fence_value =3D 1;
> @@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>        mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>        mes_status_pkt.api_status.api_completion_fence_addr =3D
>                ring->fence_drv.gpu_addr;
> -     mes_status_pkt.api_status.api_completion_fence_value =3D
> -             ++ring->fence_drv.sync_seq;
> +     mes_status_pkt.api_status.api_completion_fence_value =3D seq;
>
>        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>                                   sizeof(mes_status_pkt) / 4);
> @@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
>                        x_pkt->header.opcode);
>
> -     r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, tim=
eout);
> +     r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
>        if (r < 1 || !*status_ptr) {
>
>                if (misc_op_str)
> @@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>        amdgpu_device_wb_free(adev, status_offset);
>        return 0;
>
> +error_undo:
> +     dev_err(adev->dev, "MES ring buffer is full.\n");
> +     amdgpu_ring_undo(ring);
> +
>   error_unlock_free:
>        spin_unlock_irqrestore(&mes->ring_lock, flags);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index c9f74231ad59..48e01206bcc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>        const char *op_str, *misc_op_str;
>        unsigned long flags;
>        u64 status_gpu_addr;
> -     u32 status_offset;
> +     u32 seq, status_offset;
>        u64 *status_ptr;
>        signed long r;
>        int ret;
> @@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>        if (r)
>                goto error_unlock_free;
>
> +     seq =3D ++ring->fence_drv.sync_seq;
> +     r =3D amdgpu_fence_wait_polling(ring,
> +                                   seq - ring->fence_drv.num_fences_mask=
,

That's what's amdgpu_fence_emit_polling() does anyway.

So this here just moves the polling a bit earlier.

I think we rather need to increase the MES ring size instead.

Regards,
Christian.


> +                                   timeout);
> +     if (r < 1)
> +             goto error_undo;
> +
>        api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status_=
off);
>        api_status->api_completion_fence_addr =3D status_gpu_addr;
>        api_status->api_completion_fence_value =3D 1;
> @@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>        mes_status_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>        mes_status_pkt.api_status.api_completion_fence_addr =3D
>                ring->fence_drv.gpu_addr;
> -     mes_status_pkt.api_status.api_completion_fence_value =3D
> -             ++ring->fence_drv.sync_seq;
> +     mes_status_pkt.api_status.api_completion_fence_value =3D seq;
>
>        amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>                                   sizeof(mes_status_pkt) / 4);
> @@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(s=
truct amdgpu_mes *mes,
>                dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
>                        x_pkt->header.opcode);
>
> -     r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, tim=
eout);
> +     r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
>        if (r < 1 || !*status_ptr) {
>
>                if (misc_op_str)
> @@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>        amdgpu_device_wb_free(adev, status_offset);
>        return 0;
>
> +error_undo:
> +     dev_err(adev->dev, "MES ring buffer is full.\n");
> +     amdgpu_ring_undo(ring);
> +
>   error_unlock_free:
>        spin_unlock_irqrestore(&mes->ring_lock, flags);
>


--_000_PH8PR12MB68417B9F856C92BD02912A08EFA82PH8PR12MB6841namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<i>&gt;&gt; I think we rather need to increase the MES ring size instead.</=
i></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Unfortunately, it doesn't work. I guess mes firmware has limitation.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Jack</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, 19 July 2024 23:44<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 19.07.24 um 11:16 schrieb Jack Xiao:<br>
&gt; wait memory room until enough before writing mes packets<br>
&gt; to avoid ring buffer overflow.<br>
&gt;<br>
&gt; Signed-off-by: Jack Xiao &lt;Jack.Xiao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++=
----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++=
----<br>
&gt;&nbsp;&nbsp; 2 files changed, 28 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v11_0.c<br>
&gt; index 8ce51b9236c1..68c74adf79f1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
&gt; @@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *op_str, *misc_op=
_str;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 status_gpu_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 status_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 seq, status_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *status_ptr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; @@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completi=
on(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unlock_free;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; seq =3D ++ring-&gt;fence_drv.sync_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq - ring-&gt=
;fence_drv.num_fences_mask,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_undo;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status =3D (struct MES_A=
PI_STATUS *)((char *)pkt + api_status_off);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status-&gt;api_completio=
n_fence_addr =3D status_gpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status-&gt;api_completio=
n_fence_value =3D 1;<br>
&gt; @@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.header.dwsize=
 =3D API_FRAME_SIZE_IN_DWORDS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.ap=
i_completion_fence_addr =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.gpu_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.api_completion_fen=
ce_value =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ++ring-&gt;fence_drv.sync_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.api_completion_fen=
ce_value =3D seq;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write_multiple(r=
ing, &amp;mes_status_pkt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(mes_statu=
s_pkt) / 4);<br>
&gt; @@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;MES msg=3D%d was emitted\n&=
quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x_pkt-&=
gt;header.opcode);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, ring-&=
gt;fence_drv.sync_seq, timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, t=
imeout);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1 || !*status_ptr=
) {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (misc_op_str)<br>
&gt; @@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completi=
on(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_wb_free(adev, =
status_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +error_undo:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;MES ring buffer =
is full.\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_undo(ring);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; error_unlock_free:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
mes-&gt;ring_lock, flags);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/mes_v12_0.c<br>
&gt; index c9f74231ad59..48e01206bcc4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
&gt; @@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *op_str, *misc_op=
_str;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 status_gpu_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 status_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 seq, status_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *status_ptr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; @@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completi=
on(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unlock_free;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; seq =3D ++ring-&gt;fence_drv.sync_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq - ring-&gt=
;fence_drv.num_fences_mask,<br>
<br>
That's what's amdgpu_fence_emit_polling() does anyway.<br>
<br>
So this here just moves the polling a bit earlier.<br>
<br>
I think we rather need to increase the MES ring size instead.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto error_undo;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status =3D (struct MES_A=
PI_STATUS *)((char *)pkt + api_status_off);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status-&gt;api_completio=
n_fence_addr =3D status_gpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; api_status-&gt;api_completio=
n_fence_value =3D 1;<br>
&gt; @@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.header.dwsize=
 =3D API_FRAME_SIZE_IN_DWORDS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.ap=
i_completion_fence_addr =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.gpu_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.api_completion_fen=
ce_value =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ++ring-&gt;fence_drv.sync_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; mes_status_pkt.api_status.api_completion_fen=
ce_value =3D seq;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write_multiple(r=
ing, &amp;mes_status_pkt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(mes_statu=
s_pkt) / 4);<br>
&gt; @@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;MES msg=3D%d was emitted\n&=
quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x_pkt-&=
gt;header.opcode);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, ring-&=
gt;fence_drv.sync_seq, timeout);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fence_wait_polling(ring, seq, t=
imeout);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 1 || !*status_ptr=
) {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (misc_op_str)<br>
&gt; @@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completi=
on(struct amdgpu_mes *mes,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_wb_free(adev, =
status_offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +error_undo:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;MES ring buffer =
is full.\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_undo(ring);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; error_unlock_free:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
mes-&gt;ring_lock, flags);<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB68417B9F856C92BD02912A08EFA82PH8PR12MB6841namp_--
