Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF32C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 08:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2309D10E44E;
	Mon, 22 Jul 2024 08:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQNTBVZ2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B5510E44E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 08:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBCN4HW6sgq76QZxKj+dNwLkFOzYvTTG+pLPtcuYIC5LmdY7jWcxPmbcngFkHfuUI2KrhB5WdSL3I3Efm1aAoCIea2NgZb2u1CimzsNYId59w7bz9+jDXmMe0SjFYiYgYxGr5piCvsTthU5FLYRZHwMpbMM/UHn1NuCK+0MkuCGlZVLJAGNmgYvLePK8B45m0n6dTMyYvClfozMgADn4Tc+x3l+s6mWvJ44tscMrCBj6biaG6jGGCYs3vyNrhHwHfYjiWpHcoO87s2eo+z3q+w1YSYddGcE8v/ol3cEFD30tFYn68kw7K2VSlmYwCXEwwl1vXLa6dnYKHuyo8sOMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UqGlVui+k4ALDywXhczA4/ZqYFfJYCF5hVMWowtz9o=;
 b=iXt5jgG5z5fA+nr1ghf4ceJRxPB6KxNUkokvbc+JjWcNJg8cvBlcCRd+8W8vgmKUOED6qx8mNxDZF9rv3MzdB30+68GbbqzieyN1Q2DU+zINGoUWQVY363RfDymUpJOMq7B/fSK70BlsjtwOBR6yu8PmSNzbiB7XTgmIQWngGBCmWo0bLVtgWEliU1uNBYZFw3Lcztvrl6bm7qKVfzCdv1OZAf1Go8D+q1b7IvpYEqBeG/lyCWFGUuo08pjOvMaoJftnrzgMkEptmBsfemg8m99m92KKG6SdEXt3/0FLJ5uCF/7LHvD4iWBuapMb/3TPaVEEz84uqy7cDx3I58lvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UqGlVui+k4ALDywXhczA4/ZqYFfJYCF5hVMWowtz9o=;
 b=xQNTBVZ2VdmMK+zs38lO3T+53KgunUJjtTBVRu2wwXmtRdD0iek3LwXT1N9Sfpgd3N/cqb58j9e0rOVpbQCaNAioQPRX6v4iwWSv7k9FRLvKK6B2O2vhPrz/WO53FmCvZx63Hj9+nTGDuuAknusMmfV24Y2leHFIbiO0MHqByx4=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 08:46:49 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a%7]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 08:46:48 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Topic: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Thread-Index: AQHa2bx3Lq6MdRXCn0ej7o1d9ZHJpbH+MY2AgAPoXQmAAFK2gIAABPRv
Date: Mon, 22 Jul 2024 08:46:48 +0000
Message-ID: <PH8PR12MB6841A6DA262E07EF7317FE72EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
 <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
 <PH8PR12MB68417B9F856C92BD02912A08EFA82@PH8PR12MB6841.namprd12.prod.outlook.com>
 <92f00b1c-79c2-431b-b8dc-70070a65b14a@gmail.com>
In-Reply-To: <92f00b1c-79c2-431b-b8dc-70070a65b14a@gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-22T08:46:48.342Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|MW4PR12MB6707:EE_
x-ms-office365-filtering-correlation-id: 066afa77-0287-426d-e0c0-08dcaa2ad336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?czQRw9plC+/CwFNhBaAEsUHco+fHSu4OhYXqpLVC04uFUfB1u31haRZYZk?=
 =?iso-8859-1?Q?MnKb9snNp26Me1mLxG04ibRu/wYSvElEtViYyLHoH36184kfxuOgzOhNfd?=
 =?iso-8859-1?Q?1S/1Ikw++voUqE3Wr8jrMz5UbqZEUWHBca3eQcxYAvxYiHViAuciuSZbq6?=
 =?iso-8859-1?Q?+PdXMGFvxv3H1GMpZIOErt9iWJAOfwWzhvm6tEV3VuphA6//i6BndCXVcG?=
 =?iso-8859-1?Q?YYGL0JfVw/RjbLX5ssoNqDj+Ohd+CDR/vmUgK3EfcuDFtuGalTI8Kf0TI3?=
 =?iso-8859-1?Q?kTD0vtc9ztrssijGrAMWHsZBfyYhAC3HrN1YUYi/b0TgneKEBcgCt0rEGw?=
 =?iso-8859-1?Q?bf95euPGG+J0oyMq1Om6zAfX+GtNLBD7DBbm1W49mdcj/afxT5jGO4gGJq?=
 =?iso-8859-1?Q?W9+lDH3MKeCziwjKhgxxkh4NdNsoRoK7/2FEX9wQONGzWjhGYI3omVuySL?=
 =?iso-8859-1?Q?9V6EE4f9qRfsro3BsHmHzrLpQ0DbFzFhEKdHkGEshujL8gT3MzLRxD/8EC?=
 =?iso-8859-1?Q?icdQsOFGClANmb9P/un+1rUnZLWzbz2lW0HHt//r1t+lRHC2UccOMb+4xP?=
 =?iso-8859-1?Q?krP09nUfhm3bJ8UFp7XWuC2VkH5sG+YG4Glk1OGULgVhLb89z/F3u5g9y2?=
 =?iso-8859-1?Q?DoIVPJKYMCoK049wJPLUJ+7oE/DfH8V0P9TkkeqcwGbgbBo7sieiOE9TKp?=
 =?iso-8859-1?Q?83IxArZj5k9z+haZPpvSntg3UkFn2fkY4ZyZvwOLxRdXDt0wz6l9I897ZD?=
 =?iso-8859-1?Q?OEjRSt7tkxzJzb2XDPoJAlAN+DqupNfsjxQBIASJrKnwcsdNyhCz2T/bRF?=
 =?iso-8859-1?Q?zfjKaMsJm2QJkvawo43DF/8RzSY0yr7TXtTXBq0Z64dAbhn4ur/1SIqh/Z?=
 =?iso-8859-1?Q?OQVBox3GKzxxhVszz8/cHk0z1tTo2Tcb3qlDBRC0PZEvEeOX8NR5UfjHsC?=
 =?iso-8859-1?Q?Vwll3aYNfzTuEggwR04eTpXwkPnmEXG22ca/mBwtKUvSHxKOZJ5KINjIVr?=
 =?iso-8859-1?Q?GOn4+d7Lzsis4HuOm9IsK8RyFkl1OnGU6GOQ/UTMdt6nGdCBzjqGU740kD?=
 =?iso-8859-1?Q?0IfDjIeddd/PlvPNEwK7W2YZ0s1kaY54BBfl+IgCtRho1l4SVdG1bSslI9?=
 =?iso-8859-1?Q?ZEAlfFteLwF/9357lkYSlavwoATKm59kxtMQKLbhHuEq2ouRqow/gYFmye?=
 =?iso-8859-1?Q?CesrL2GhxcqPWWthWwqZaEUZDq/e+44bONDyKIHFwlQkqy6kvqtANRLNYG?=
 =?iso-8859-1?Q?GQu4xCdhMFSqVWZfNqNBGork2fbKy3gFA7vvAPal6Xvro2ZKWlVcSWbQ8F?=
 =?iso-8859-1?Q?4ajo7/nWdD9p9OVo8RrXz7avqQsDyCmYRP7lJJiNWOvAtVgvhKKTumj8n5?=
 =?iso-8859-1?Q?I/j+lYYjii7IdpJ+v2bTIIvkZxR36fdvgoGIx7VQCyGfAYAleDXav9XsGR?=
 =?iso-8859-1?Q?TLAiOy8Xgm9FXJ61L09O9OXh4FkdrCFIen2pLw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nnfFwLQTyGC6SBtspRWDe+llty8ezdG7/F/NcDFY4T/YCFwVNDs3A+Ychq?=
 =?iso-8859-1?Q?Z2+UgteclyiMU4p0DmqkLaDA0RlP/Yt/iyf7hoq6KXyAPzsgivN84qBowR?=
 =?iso-8859-1?Q?kc+l/O90JU4Ma/d28K8GjoZeZPiXfdyWTRDotW2blUyxxV7booh9o1gLFj?=
 =?iso-8859-1?Q?L7CTfCKJqTfE55y6wV/CJI91QqxWYs414RzSx+aXk++vJuELMNzYZiTdHI?=
 =?iso-8859-1?Q?ZnEZSqoPT/Guo44hqh8t1Oxu1Wg9xYZ4v9fiozr06Hk2HiOd2j+JuN7l84?=
 =?iso-8859-1?Q?Rr8KW6tm0ydVAeOmH8NJrsfFI5ekVE2Cg/abK+e+JPHy/2epHTQoCPd610?=
 =?iso-8859-1?Q?wcaHdazetQAKpxYeSLRO/EUtjal/n3O/xfftZzn3EcLOFK+/Pt7tF6I+a+?=
 =?iso-8859-1?Q?ZCI8lqFJhqSg/5G0miASSXMy8JfUlm9M99OhSP3nwtj7+Ncj8B8pLwnzeP?=
 =?iso-8859-1?Q?9rkLq1eodgIsz601ZsXHSLZusDAidXWTgqJDLXYmVt45jpySay6Howw2HL?=
 =?iso-8859-1?Q?bd9em58tdgqSV3aPRBGVXQ7QqA0YpPmFT94D4S5hqyo/Z8rRQ+b6tDJjVm?=
 =?iso-8859-1?Q?lxs6lHF/JZqOjHTYfz+AKfWTW24HOqSyNUD45EbOjohnT3TQ61gSks8DPx?=
 =?iso-8859-1?Q?zVvR15bmqWvsSt5toZPh7YG2y39UJzx02NutQDS1TZbFcF6FK5P+itfXo3?=
 =?iso-8859-1?Q?9a2zmhvwz37egY77GOw+1krmC2MQtNBxO4TZw8RZBRp6Io+K/h700UpnRp?=
 =?iso-8859-1?Q?ARWQLwbWAwMGZfbqgvDDaTeLDUt9fsQ5Zdt870dNIl0qGESpqPvUN2hRKV?=
 =?iso-8859-1?Q?FbxZniZjuqNmROysSIPFVlWWDBAToBVNgdThfN2tlvO4sjBBUl5uW6JYs/?=
 =?iso-8859-1?Q?dOlPFdSwqjhw6+YtdoVANDc89e7STQKDmdF3FSikjjrZAM1jHj8INk/E9D?=
 =?iso-8859-1?Q?zAi6+DrXhrpxSHtkTudsYA2oaA7Sd3mPRZUV5rXv0RI9nZgxsj+Y37gkA8?=
 =?iso-8859-1?Q?dZ9AQJenGEzBhsAqiu29urjRPxNK4/nd1lLPaUouEMC/Pxtt3JDqeLQ+gy?=
 =?iso-8859-1?Q?l+gN22f2Zbpf6ou5bnHYbWrJog95fADbj+UZFX2yAaEqLeE3/0lA4TLjhi?=
 =?iso-8859-1?Q?M6uLyuqiEwFdCUCHD/LM3vU4csVkwcb0VzpDE8zWRQu9JRunp2CMI6gzgT?=
 =?iso-8859-1?Q?nd3sjGfhS//utPnFFCprVPulkhN7c7k6uTf8jvXR3Sl+NiHDdyvyB0R+vE?=
 =?iso-8859-1?Q?Wlx34w/8zwzles4RGIsVZ6Y5UC+K9foxBmlh1QZwRdNi74rsgk6yMjxrp1?=
 =?iso-8859-1?Q?miLDrTkgLR4MIQ7t5EtFqT+CZhT9SDRpTVnHrJjYVFjrG/QmylFIRtTCg1?=
 =?iso-8859-1?Q?bWj8JJnDNFJRpKrHXvD4cWkFv46+E66iyXDrtA/ov5ORuxjgagJfi8NGKj?=
 =?iso-8859-1?Q?ZbDXZfcLyZNQs6qZY93bLptm2e18swnqXcQrOiPhGEy5LgVAPJapbE5mOY?=
 =?iso-8859-1?Q?tKjNrIHnpGYbCvSGkUdR/5pLijZstzamBkHxLxEVL1EZaZ0xiBMva8+c7m?=
 =?iso-8859-1?Q?jIPNx9acxUDSwZTEw5iqwywQwWrH/A8Q8jWTIX1ZzLSy9UJNfUAc8HFjD6?=
 =?iso-8859-1?Q?DNhsT+xKkK7dU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB6841A6DA262E07EF7317FE72EFA82PH8PR12MB6841namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066afa77-0287-426d-e0c0-08dcaa2ad336
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 08:46:48.8630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PqMwhLLx6pwqn0+WLp6F35NEJUpdcTIIXI/uoe04rOKvRxQrau9aDP9HEKNcK4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
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

--_000_PH8PR12MB6841A6DA262E07EF7317FE72EFA82PH8PR12MB6841namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

>> Can you try to reduce num_hw_submission for the MES ring?

Smaller num_hw_submission should not help for this issue, for Mes work with=
out drm scheduler like legacy kiq. Smaller num_hw_submission will result in=
 smaller mes ring size and more waiting time.

Regards,
Jack
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, 22 July 2024 16:20
To: Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow

Thx, but in that case this patch here then won't help either it just mitiga=
tes the problem.

Can you try to reduce num_hw_submission for the MES ring?

Thanks,
Christian.

Am 22.07.24 um 05:27 schrieb Xiao, Jack:

[AMD Official Use Only - AMD Internal Distribution Only]

>> I think we rather need to increase the MES ring size instead.

Unfortunately, it doesn't work. I guess mes firmware has limitation.

Regards,
Jack

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Friday, 19 July 2024 23:44
To: Xiao, Jack <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org><mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alex=
ander.Deucher@amd.com><mailto:Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow

Am 19.07.24 um 11:16 schrieb Jack Xiao:
> wait memory room until enough before writing mes packets
> to avoid ring buffer overflow.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com><mailto:Jack.Xiao@amd.com>
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



--_000_PH8PR12MB6841A6DA262E07EF7317FE72EFA82PH8PR12MB6841namp_
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
<i>&gt;&gt; Can you try to reduce num_hw_submission for the MES ring?<br>
</i><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Smaller num_hw_submission should not help for this issue, for Mes work with=
out drm scheduler like legacy kiq. Smaller num_hw_submission will result in=
 smaller mes ring size and more waiting time.</div>
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
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, 22 July 2024 16:20<br>
<b>To:</b> Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow</f=
ont>
<div>&nbsp;</div>
</div>
<div>Thx, but in that case this patch here then won't help either it just m=
itigates the problem.<br>
<br>
Can you try to reduce num_hw_submission for the MES ring?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 22.07.24 um 05:27 schrieb Xiao, Jack:<b=
r>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Calibri; font-size:10pt; color:#0000=
FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none=
">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<i>&gt;&gt; I think we rather need to increase the MES ring size instead.</=
i></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Unfortunately, it doesn't work. I guess mes firmware has limitation.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Regards,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Jack</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Sent:</b> Friday, 19 July 2024 23:44<br>
<b>To:</b> Xiao, Jack <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:J=
ack.Xiao@amd.com">
&lt;Jack.Xiao@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander <a class=3D"x=
_moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 19.07.24 um 11:16 schrieb Jack Xiao:<br>
&gt; wait memory room until enough before writing mes packets<br>
&gt; to avoid ring buffer overflow.<br>
&gt;<br>
&gt; Signed-off-by: Jack Xiao <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Jack.Xiao@amd.com">
&lt;Jack.Xiao@amd.com&gt;</a><br>
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
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_PH8PR12MB6841A6DA262E07EF7317FE72EFA82PH8PR12MB6841namp_--
