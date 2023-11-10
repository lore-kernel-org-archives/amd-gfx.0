Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EB910E18C;
	Fri, 10 Nov 2023 19:07:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F192810E18C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buwvdYSNApsijdDCkobVGrB301fSEOk5VBpa+gr6gXocjBex00EHlykrso2aNklfM2q8DjW0AaK6ScKJ4a7CmvGo7+J97B3FLzvnYg+pPWrRKjD4mmZy2//ASRTqZalizZCJUTd2cUV198f7gdAjjOhg5KjXYEWRGUs0M33xI4mL7vCW174NAkoxr3UBuifbncDZYVtLlNtVB0G3EL7zUwo6O/oT9JiuPfK+OwXcblus95BX5YdBZ+aT1cjiQ12K/F1ZP5Xe5PzoIjUNZTVTLIn+gf7TPQ+qfKOeQT2Yx5aja+kEgTrmXhX0V/PWVYSTmkCFkt0/HhFaUpQR8KHVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FnOETHX9YLZaj4gIE6OaOQ3gV0mCclycheczHEjhAE=;
 b=C1FFnSzC1l1AUnQVjwoQXg+vQftxQ8+TxUzrtEcAunPm+OpDMJ6uT4sXaWOrWaGLNOfOygb0msrCm7MSCqa4R7O99e+vhcuJllnP8ALJcLDS/e1NKoZZx76EnPTOJ+kvO8713p9EaHR78og3b1V5JOI4dmQirNIMqSOxA5dLCw6velupWGUZkbJcxzvk5EfwH4e501iS9G0HiibcUqHuNqRo46CuQWeoD0eKTlOJ9ne4bCMM98fl/Tk24XF3k1UuUFFwuWSe6WTRD8cDIkm4pLFQ6ny3od8sHwMyO8lrfwxu9aIDpSpjdcLvDx23Miv7YOdpsRU4lRshsUjxdpYLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FnOETHX9YLZaj4gIE6OaOQ3gV0mCclycheczHEjhAE=;
 b=ZKofAtCId/qDTgih8qZycKy5/Ne2DrAF5DaFbode3JOKiQGc7TcMoVLZDPhuQgZwxhoyYIXX3WabZlgN+fIBKAy99MyVH5+ZN6tiZkVEOD3DLT2hW2uLU+/FNBA4oqm+679BaJ5oXz3nQv3WWG/VnPelZMGq/X9eQbdmQLfNlqk=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:07:03 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:07:03 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
Thread-Topic: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
Thread-Index: AQHaDlddRVB0fVi35E+uwYwzW6/mBrBz9JOg
Date: Fri, 10 Nov 2023 19:07:03 +0000
Message-ID: <DM6PR12MB50211E7128EDF3D5D6067B9295AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-20-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-20-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=24956ba8-78e2-492f-ae23-6f9ed1907c61;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T19:03:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|SA1PR12MB8721:EE_
x-ms-office365-filtering-correlation-id: 6e3965f1-9b41-4a22-3766-08dbe2203976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4c4oe5//wQvAdHifSwG1SkPz0FeGKyvyNqMTZVYZq9auobpZXD+vw8SvFhvXtDrrEtg1sMM/+86b9Sx68TyUZ1tj4XDFrqyCLAcijf79eKE9UOfgnq3Xjsjumlbtt9sHX8Pu5diGupYlZwCX6+m5wQnzu5LCTwJXyKd0a0D9A3Am70bnfyz0YJUqMp2rH8j24u9H2/oylfb5mVdnhSfwrqH1wHUDmlU9vwYU+lZwNTJheC7dcW8aJgUa1E/LwsCDPUSawGf2GJ4oS9lyaGbMvoz8vm7hc0UbC1S/vVy2xzdqratRxY7npqTPOL2D2HW9pN3r05Dz1pH01y+D6zg0Cs4LUNTYN8MUiJl4HIhLywvSHXpO/yZ96t0fjoTp0aF5aghsfg9i0AlT7Dqqqhm50ogagdV8lSd7UomLKhPsL9jTNjK6YHo9jJYW6TlHOzw14SB75BJbSPw8PvtwYtY0ZpaKs5gVdQT5qKz4ou9jw12+KKqaLKjANWuvYN5NeqYJrkpGYyqILlfFTZGr+Oe1IlXFi4zho3fX09wOIYIXuBs07eXWmL5rzdPZgWA+2BWsbIodnMdvQ9j4XIQ7NtUxqM3E9n4v9zBYchmwGRY/JpgwTReEoPB2+elyR+hN3LgD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33656002)(66899024)(38070700009)(8936002)(83380400001)(316002)(26005)(66476007)(66446008)(64756008)(76116006)(66946007)(54906003)(110136005)(66556008)(2906002)(52536014)(4326008)(55016003)(5660300002)(478600001)(53546011)(8676002)(71200400001)(7696005)(6506007)(9686003)(122000001)(38100700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dcu3gCJdHjUejf9rer5vI95Xqrqx1bw9yc9D0wFeZVv6R4X9KTOOc3ByhwSB?=
 =?us-ascii?Q?lkL6A6UQZ6OdHW67joDWsWKXnqGSLFEJuQwo34wI8wSPdRpHlTwC7ILA6LIq?=
 =?us-ascii?Q?hOxH8eoG9M0u+uaW5V5Nfli5eBZqg0DCUUc90MWAfgWBfKZPnRfXIz7rPxSb?=
 =?us-ascii?Q?Vqxy0Qowa43t+X5PkAjyREerDn9LZxBrYeRWn9EL89gB/FPz12DGGu0D8g99?=
 =?us-ascii?Q?hwXOATTqQIoJWJwq0cbPyiovXIvOlY5ofe2E1gaejEl83DcppWLRkXoYtO6N?=
 =?us-ascii?Q?twUFS+VF8kyhOEawL1mpfE9YhfY6EmcZ9fBikcIcUrrPbHa5tGjJaSlGSXN7?=
 =?us-ascii?Q?DEYkXnFFts41IWy+l9oQeDDuyYuNBt8N8WmVNLCarypH1XGDyy2hgEIrcoko?=
 =?us-ascii?Q?6FKE1mjDB+Ig2uG0JiwqR4jnuDL43Bx3ziXlhova4qlt//DjpKWhIXgItq4E?=
 =?us-ascii?Q?TiOuxO4IFO8bbT/Gw46+Eh3UWZLVu9zx4H8nS5o0Zxk8jqrBjIQGk12BYEiU?=
 =?us-ascii?Q?opsh2nPjIXAo4QOvuA/apKwZj3R+YRMlVMQISTo7J1n/zFALERAi6Dt2d1h8?=
 =?us-ascii?Q?lhA9602XWAkDTUHSfT2nMAEGwMhJXnoKPzJWsFWRrM8DunI0prlPn3fXHnhz?=
 =?us-ascii?Q?+wtFQY2d0rE036uoypbHCmtpxJzhwsXpR8TA7VbbngZ+kX/YjWBzEsHP7P1d?=
 =?us-ascii?Q?betWATmCopUJVsvq586kaxnogogcAw7eDl2zIuPqVauDAys2RhOaNmuZcUKA?=
 =?us-ascii?Q?lLW6IKvGuqQDyKcExbn2X/1rjUCbjw+pfhsiUTngAzJW39jdzilDyq+Q4b2o?=
 =?us-ascii?Q?fzL7QMHw+ZQd9OpvRtsUiSnnELtwXMvCTR5aTPAvLHlRHpiTEsAMrDa/NDgB?=
 =?us-ascii?Q?a4S8N405tUpMS9cRXp4FxYrmdsob6veay4u8A0R0gUlmmulpa7MXuje2913E?=
 =?us-ascii?Q?VI4Wrdy9Rg2eKE0G3XkOB8GPejZWMpbhXai7LYzX3Hs0Mftbs8UixkYbR1V/?=
 =?us-ascii?Q?8zVqPge3o+3fpqNtL6qGlezfZhlAjRlGWgpE8c+V7QV5av74FILeFBmxIIT7?=
 =?us-ascii?Q?g/7PXhMtPxiO5oP4ePnv/hd30L7Xi58oEjkgTaswiu0YEGJspX7bC34N26Vp?=
 =?us-ascii?Q?9yCHb4HjuU0UeYcPc6JZAjy6g4358LeMABoo0zdUvPht3g+mBP7pPDBNgFpc?=
 =?us-ascii?Q?NemyZ9j82n+buE7oOjPc+b6kULMkI3/S1IIDs1Wbp8KCvVeqU/xvHeESUJFI?=
 =?us-ascii?Q?KygdGM3WUsi+zSQSQPRtjsWHEiFGzavGmkpt4nr8dE5ZbxFWEPH5t+ZeNJWz?=
 =?us-ascii?Q?QW+PD7g4oDoYdZCvRbRQ9Qqvo9bRs5L022ozn52xiLwJCjV4N/0McDp7dWhJ?=
 =?us-ascii?Q?zdzNFEqHQ3c621QUFtGNgHWfWh3MrGhZw8UGojPfreFpfMnbvz4ruClu9cWL?=
 =?us-ascii?Q?HvQPk80ByxY+zga1FeFZTDSFG90ZCgg9UDDKOBBq+VK7mXEJkvPwiggmmhiY?=
 =?us-ascii?Q?yMBvoqUjOUxHdPv69bp2r8nF1fXAvCmrVTvDdcAa6zfCEGXqKiYp6ClYK1/0?=
 =?us-ascii?Q?Keo0fty4rE0jnO4CQ6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3965f1-9b41-4a22-3766-08dbe2203976
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:07:03.3549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg9ZU5agiZbg9lYMh3yDw/4gG7edN0PixajIkS9i1s+CKb+aEG6eNjofUWON5OlHlh2uNBQwtSB0ErAPoOmdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
>
> Enable pc sampling stop.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++--
> -
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 33d003ca0093..2c4ac5b4cc4b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct
> kfd_process_device *pdd,
>       return 0;
>  }
>
> -static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
> +static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
> +                                     struct pc_sampling_entry *pcs_entry=
)
>  {
> -     return -EINVAL;
> +     bool pc_sampling_stop =3D false;
> +
> +     pcs_entry->enabled =3D false;
> +     mutex_lock(&pdd->dev->pcs_data.mutex);
For the START/STOP/DESTROY ioctls, I think we can hold pdd->dev->pcs_data.m=
utex through the whole IOCTL. Then we would not have to deal with the inter=
mediate states where the START/STOP/DESTROY are happening at the same time.

> +     pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
> +     if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
> +             WRITE_ONCE(pdd->dev-
> >pcs_data.hosttrap_entry.base.stop_enable, true);
> +             pc_sampling_stop =3D true;
> +     }
> +     mutex_unlock(&pdd->dev->pcs_data.mutex);
>
> +     if (pc_sampling_stop) {
> +             kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
> +                     pdd->dev-
> >pcs_data.hosttrap_entry.base.pc_sample_info.method,
> +false);
> +
> +             mutex_lock(&pdd->dev->pcs_data.mutex);
> +             pdd->dev->pcs_data.hosttrap_entry.base.target_simd =3D 0;
> +             pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot =3D=
 0;
> +             WRITE_ONCE(pdd->dev-
> >pcs_data.hosttrap_entry.base.stop_enable, false);
> +             mutex_unlock(&pdd->dev->pcs_data.mutex);
> +     }
> +
> +     return 0;
>  }
>
>  static int kfd_pc_sample_create(struct kfd_process_device *pdd, @@ -251,=
7
> +273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
>               if (!pcs_entry->enabled)
>                       return -EALREADY;
>               else
> -                     return kfd_pc_sample_stop(pdd);
> +                     return kfd_pc_sample_stop(pdd, pcs_entry);
>       }
>
>       return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 613910e0d440..badaa4d68cc4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -259,6 +259,8 @@ struct kfd_dev;
>  struct kfd_dev_pc_sampling_data {
>       uint32_t use_count;         /* Num of PC sampling sessions */
>       uint32_t active_count;      /* Num of active sessions */
> +     uint32_t target_simd;       /* target simd for trap */
> +     uint32_t target_wave_slot;  /* target wave slot for trap */
>       bool stop_enable;           /* pc sampling stop in process */
>       struct idr pc_sampling_idr;
>       struct kfd_pc_sample_info pc_sample_info;
> --
> 2.25.1

