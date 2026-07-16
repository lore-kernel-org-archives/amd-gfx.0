Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4951C44507
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751E310E284;
	Thu, 16 Jul 2026 02:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9tf01P/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E8410E284
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu2izLBuixgV3+N0nX+GGP/0/uS5Xhm/pGV7d8OCKl086aWywYVnVrKzSUfmFibn0lhBd/CYDbbmzyDLR5Jp6NKvF1cLGgISJtymN+H998U8PUsDtOTbqyNFZgmI+DqgSwowkPb0Chn/EjODwIHb/qeNUg+u1rSUW/q/CJwTQI/H6GQ86FaHb5hWipOWxLS+tCrEERqs/Aw6c4OVzaKi51wvOGftdj8Wv1X9w2BNov2iOjTGbafu4yG6ac7VYegDspMCY4w6yVIvkiJDpBvT64Pn4Swtto8e4n/gUUJft1HW1DKFtJgIo15g86mW1Mlz3ovLoo35dlxPMk6ulFggjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+aEWr5NW9y/+UKtT8RfH2QPFc5ZJz5DyOstEatF4f4=;
 b=KCWcnVjDQ/45r0f2TzmuVU8j6FMLYfjobmnSWGNQpu2AbGWTyKurFQJf8i9tdZtEM6W43I6jGyCMu1qj73/DjBPCHLnxMV80urlY2AdXIzOCuT7+UQbRvYjaMvQz+/vbwrGeM/Cx6QJC7YM3lxeJV3gbS9hnGg1/4//adYMC1qZrgVkTn1a9XhbzLIEQbx1ScWni6ieBAno96kKnv6dR3CsW6M27TlA+3t/yCN1Lo9E529/EmldArBOcTxzai1m35R25/KD8o1smCMF4d+whPIczpXHgy5wpcxuGMZ7ImT4Lxj6+iRUENBm5rLNgp0tC4odh/HBQcF+WuWyW1xXqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+aEWr5NW9y/+UKtT8RfH2QPFc5ZJz5DyOstEatF4f4=;
 b=C9tf01P/bJ8Xg562QfvNTKFsM5FeDvivbaVRmHqEA2KB4BFKcc2w3b+4SCVUxMwwBL/8EdAX/+9dr8jlLrYHxFzuK0Sq24frWDvBept1UZjAHnNAxp/Nw0VgFS2yuBKvb2mJca0ydxs1Biw4EjCwTTNJ4REOPds4LtSUPHRudu4=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:39:14 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 02:39:14 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Topic: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
Thread-Index: AQHdFC5ANm4aqLrdWUuf8NmcTtp5mrZuPweAgAAHAECAARyOAIAADX0Q
Date: Thu, 16 Jul 2026 02:39:13 +0000
Message-ID: <BL1PR12MB51274C0109B82B4B7B8B1CA4B0C72@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
 <20260715074734.2668631-5-tao.zhou1@amd.com>
 <BN9PR12MB52575849F098B6FD36227AB1FCF82@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BL1PR12MB5127187AC95C256DB499E271B0F82@BL1PR12MB5127.namprd12.prod.outlook.com>
 <BN9PR12MB5306E81D6FF9283352A26382FCC72@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5306E81D6FF9283352A26382FCC72@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T08:25:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|DM4PR12MB7742:EE_
x-ms-office365-filtering-correlation-id: f74ff47f-f828-415d-66eb-08dee2e36c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|38070700021|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 4spxRflL8jNoGba9bK/70WGQpGAn1qsOGum0gb7kAFCSi/D8ClzM55zGxGK8T8vlP7JYTuCCsIHc8aUgtdO5F/1x6/k66hrUOjVRERQGqazltVoSTiQMdilNAcRnndM33qnHKom+tIYjdQh0m6N47UTyGXmjj/miWJjoqhJ+C43mYA1q7bzWH7ocpiGb2cndC7kWQi7Y+oSmjGMgfJmcdgJ50RMebnotElhMn/uke5LrNmMLxZgUd15OcFqJmLDkCSll/fztm5RwZkUkGOs3sCJzjU0JgKJvefSgwXkk9HKSj19MU1hlXfOFom9dAaiN1g1HeYLWAoCTtmqYRbJqoAF9/51QYM/nztXXDTnLwIdcueHa44AH2sP2ezMiFw4VgZwFuw9zKr6NTYtPTF6Z43oXqBobmp0YPpOo+/lUIVpXAWgjjSvgdq9VItVHIUEsfNOrIv8y8o8zOxGLXCCl7uvJSjat0nOUvfipLexXCqvcveLrSzllR7l952OUK9aYh9QjlsulwkxMm0Z6O8Vd9ao6RbMeRez+nLTB+Im++8nGJEwMC05BBRWdn7SiPW1Zkj/8eXl4RbTqUDAUek2/0aALQzyWVQJyTirR/Dvh2QTWGVZ2ThcH9hccPBX1LORjN3pqrFtzeGBq6wjVw0Z31Vme8f58BGccGCgawUwd+U0OdU8ux01mTTWgcLAiYbmW/ge3GzHxDqvzJrT1YSo/yTKSVEnq83cgifzS2LnxSs4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s2fWtDI3tWALVIByKPLCTOy5wbUeDmjPAsKvIrtDTmnkcHc2AP0Hx2qZ55hz?=
 =?us-ascii?Q?SMC4skAN+Gy11LEfzvlmO92utNvCRBPHhcbtdWKn7tzw/QVrS6jZcE/24dg2?=
 =?us-ascii?Q?nP4XVefBVFWFQaZc/EPBHJASz1v11dJM4hiWqei7G23tM81UB67cQZrrFxjF?=
 =?us-ascii?Q?BwL+BNk2P2zkfFSkN3OK/xpu1r1uiDKkDBHnJuFrKWCVO/cRhx7yUnyB3LQO?=
 =?us-ascii?Q?29UsDgyX+R3XiJLCvYBsWO/FgNbN+Fb7JW6888otyLQpAZ4s5MvW15Qro+c9?=
 =?us-ascii?Q?C5Y3bh0MaZEoxbh+UkhsubiTjYN3K+U+9RGd6XebKQ0t4bZ5ZmLdzZcsJs2s?=
 =?us-ascii?Q?3yVIEgHRyRXOi5twlqgRKSpeMrQo+dl/wZAVsjXMOtdFF0Lx09RNu9LQAiaA?=
 =?us-ascii?Q?BQnd3DXpV/bPGPkXNo7oRQM+PoOyS8rzcsy4Jn1gwTpqlcLavSKH8T9I+gWe?=
 =?us-ascii?Q?B5UUzEyoSnfoWLzjFQe4lAT6W6ehU/yXTYlVvdaMyI5jY5B4n95TxPeBwGnz?=
 =?us-ascii?Q?hMn0qqa2gTFGu5LuveNgeZUidpr86tnZdg6FdaTZvtwo9KuG6CGzIm6tOe1l?=
 =?us-ascii?Q?HpuISIY94+bawaPPH79BVQ18qk8FHYHfDZGwH6Ml5Og1KNb7dEipjJ3txJkh?=
 =?us-ascii?Q?Y37MAlJ+lLip07shcKVPmRLtltwmc2/QR/XJHvi4a2t0qb85aI11Cu4vTf3p?=
 =?us-ascii?Q?ViIWV5S1B+vXya1KFD9+jDK0gtKL8GswCyE4SPAJMkOrAGh4UUX5byeJbOof?=
 =?us-ascii?Q?i57cwpLeLXIH4fGADNw/RBjXftZTNNyeeKMEvULnCxbfFVE/NSAcC2IPipwI?=
 =?us-ascii?Q?0JNPFs89scx0vgj5Zm6jZdJBgFcWBYVylNH4emusOa9buLX5SkSz3ZRRO08o?=
 =?us-ascii?Q?7Ict7fYtUa0rH2w0QntqEzD+U+vduHmTvuflpfBrIdDjYqHH5kbO5Q0/7N5c?=
 =?us-ascii?Q?ZC4AZsr8tPLwOkX5sBpKjM12oMB6/dIU3fdpZ8+K1LPjEqkFPJj8B4AEMGfH?=
 =?us-ascii?Q?3deX2LYNLfbf0cYvpu6Ho5pM0zA2EErvhPcpDKMoqkry6Z6FLvrr4I6TWnOS?=
 =?us-ascii?Q?xSFO05hTu8r1Qr14g706VrG/a2RGKCApa0UTCZSgt9WK1HsTzK1NXJ6QkGDJ?=
 =?us-ascii?Q?A9vOwWOqftgbVHUdKPg+EzhC8hgL0PEWeB4QJHlAPS28LExM9bR7sxRoAXgz?=
 =?us-ascii?Q?KeXUi30xr7au7lGkG/L7nygMvFw3ecaASiGXkaSLCo7KJ0ABASEwD3nPjnrm?=
 =?us-ascii?Q?gc3/tTaYQhxuTVyWNUpPOHg/cw1FY8ETquxw/SjPmlM2Z3IfumkGJ1Qu1nvA?=
 =?us-ascii?Q?EUWnfjLtBzIo4YqKjFvcTVIZ7h/fOKQGle2S4KOYVUy99FWCTQmR0lfIrBNn?=
 =?us-ascii?Q?58K7KsYASIz/6FLaE9W23dL7Pusaau+trQtjrPj40QVqBjnwvIS3EmHFDbHo?=
 =?us-ascii?Q?Nxc6v3vFf1Fi5xnTl0s7I/CDJohCcE62P0zj2iRFa+dOTwLgQOT0Qn1k8Wxn?=
 =?us-ascii?Q?JaaSSWVNJ/cdunMpPTelouOHraOyXQCueA6A0gfi/HXR5doNDQMkBMzQAN1x?=
 =?us-ascii?Q?GYYftgvAFj58wkIzwAhUGs0sSHWFsDq6O5+Fd7KmmkSSrOqx0LRqk1+0nH0d?=
 =?us-ascii?Q?SkfRtwfoWBLbgzgh5wnebG7yfSZt0ngXa6h3fgDEHF/UMXfQxduN0tAjw88X?=
 =?us-ascii?Q?rJU0Cs4HkigNnvxjYvRJucznmaRsKG9EgTgdBqa0XLHg0CCE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74ff47f-f828-415d-66eb-08dee2e36c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 02:39:13.8491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVlgbzzDhB13CQe/IB5dyrRspFZU2XrrRfId8CSyOk0ssmCwYTyYgOYAmBBYTN6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

AMD General

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, July 16, 2026 9:50 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> AMD General
>
> Best Regards,
> Thomas
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou1,=
 Tao
> Sent: Wednesday, July 15, 2026 4:57 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
>
> AMD General
>
> OK. Since Ce is working on it as well, he will refine his code per my pat=
ch and your
> suggestion.
>
> Regards,
> Tao
>
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Wednesday, July 15, 2026 4:27 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: RE: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
> >
> > AMD General
> >
> > +       init_config.debug_disable_ce_logs =3D
> > + adev->debug_disable_ce_logs;
> >
> > Let's pass the full amdgpu_debug_mask to ras core
> >
> > Regards,
> > Hawking
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> > Zhou
> > Sent: Wednesday, July 15, 2026 3:48 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH 5/5] drm/amd/ras: add ras ce log switch for uniras
> >
> > So we can disable ce log manually.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
> >  drivers/gpu/drm/amd/ras/rascore/ras.h            | 2 ++
> >  drivers/gpu/drm/amd/ras/rascore/ras_aca.c        | 7 ++++++-
> >  drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 1 +
> >  4 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> > b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> > index c55288c2df9a..1e95419989b4 100644
> > --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> > +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> > @@ -310,6 +310,7 @@ static struct ras_core_context
> > *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
> >                 amdgpu_ras_mgr_eeprom_is_supported(adev);
> >         init_config.poison_supported =3D
> >                 amdgpu_ras_is_poison_mode_supported(adev);
> > +       init_config.debug_disable_ce_logs =3D
> > + adev->debug_disable_ce_logs;
> >
> >         amdgpu_ras_mgr_init_aca_config(adev, &init_config);
> >         amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff
> > --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> > b/drivers/gpu/drm/amd/ras/rascore/ras.h
> > index 5719bc1b6167..9d538a07c50e 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> > @@ -301,6 +301,7 @@ struct ras_core_config {
> >
> >         bool poison_supported;
> >         bool ras_eeprom_supported;
> > +       bool debug_disable_ce_logs;
> >         const struct ras_sys_func *sys_fn;
> >
> >         struct ras_aca_config aca_cfg; @@ -348,6 +349,7 @@ struct
> > ras_core_context {
> >         bool ras_core_enabled;
> >
> >         u64 ras_fw_features;
> > +       bool debug_disable_ce_logs;
> >  };
> >
> >  struct ras_core_context *ras_core_create(struct ras_core_config
> > *init_config); diff -- git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> > index 67a35409ff0e..9760894c4c66 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
> > @@ -98,7 +98,7 @@ static void aca_report_ecc_info(struct
> > ras_core_context *ras_core,
> >                         blk_name(blk));
> >         }
> >
> > -       if (ecc_count.new_ce_count) {
> > +       if (ecc_count.new_ce_count &&
> > + !ras_core->debug_disable_ce_logs) {
>
> [Thomas] Can we replace ras_core->debug_disable_ce_logs with the function
> interface in sun,ce patch?  The other changes are the same.

[Tao] sure, Ce will update it.

>
> >                 RAS_DEV_INFO(ras_core->dev,
> >                 "{%llu} socket: %d, die: %d, %u new correctable
> > hardware errors detected in %s block\n",
> >                         seq_no, skt, aid, ecc_count.new_ce_count,
> > blk_name(blk)); @@ -
> > 114,6 +114,11 @@ static void aca_bank_log(struct ras_core_context *ras_=
core,  {
> >         int i;
> >
> > +       if (ras_core->debug_disable_ce_logs &&
> > +           bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
> > +           !bank_ecc->real_de_count)
> > +               return;
> > +
> >         RAS_DEV_INFO(ras_core->dev,
> >                 "{%llu}" RAS_HW_ERR "Accelerator Check Architecture eve=
nts
> logged\n",
> >                 bank->seq_no);
> > diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> > b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> > index 2346918c7736..cdef7727decb 100644
> > --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> > +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> > @@ -377,6 +377,7 @@ int ras_core_hw_init(struct ras_core_context *ras_c=
ore)
> >                         ras_core->config->ras_eeprom_supported;
> >
> >         ras_core->poison_supported =3D
> > ras_core->config->poison_supported;
> > +       ras_core->debug_disable_ce_logs =3D
> > +ras_core->config->debug_disable_ce_logs;
> >
> >         ret =3D ras_psp_hw_init(ras_core);
> >         if (ret)
> > --
> > 2.34.1
> >
>

