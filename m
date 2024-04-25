Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD67C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CE911A2C4;
	Thu, 25 Apr 2024 08:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wpcLH3I4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DA611A2C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 08:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG6scKgGPQkvMYm9gulCyBXzINx7S9C8uPXd4ddZ8Zbe6lDQ8aX++QDeu3AuCJ114xd++dU9XGFxCtNKI3YhBKcZ8VI1A3fu1QOEe+EbkLrEiClPPlIeItgF947RUUFdismFP+byR/TaUzicF5NiJAD9yDMq94vbepPLjf6RuVrmeREe7QTRx0wYGXSMqk0vdsWxxJS8Ww2P4eD+lQaZ/CnPiBG1YP/WRuj95P7XPIIELD6dsJUGFO7yz2mbvUr/8tSilqyJxOZSqlOjfO9e+N73GdH4+Fr4+E3XQf1NsusRkoWIuEPixrIQEECRYOs7rk3RorHOJZlVb6YpcfLdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlL4LGDEkunDEJz0gpN1B6UKeJFxCV1ytv5sklNOjiQ=;
 b=P82ZnHiNk59xx5uRYyYGI00gfdcTL1b/pDKSITGqb58go8Kd7YzC8qT4rPmxJyHUNq1ALwGbJOPm+jzsdIK156IeitVxIBUR6Mg6OhnJmcsMWPLeCRESLhn2NNQEcxhvifkYNCj0Var8GqD7MzO8h7xxTdEG6aJJvUZSFTguErnqNJx51FbfbxLB7Is6QGRMI+ROJSdaQ437/+cYgFMC5fEcVaZAuKjtR/jowR013Q8Ftjypli+bKbDdexOaAyfEF8pxG2K5eUGk0V8WoX+kg2A4h4mM4+zU2a+z7tB60ygkpqpUnEgcqctJKWXQywauA/C69siFoYa/k6dnBxHCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlL4LGDEkunDEJz0gpN1B6UKeJFxCV1ytv5sklNOjiQ=;
 b=wpcLH3I4zhle+g/DhpP6iDHMAJWSmqUz2iremHFhwVxLXH1Um+UNVZAdZUn3EPh1rPd3ZWbiQq+OEYCxeTAaX/l0eoGfGHI3i5nFMvZ5E5S6S5j7gU4x/tQ9JitFl26HZ/Zzg+vhUYLNBZ3xlD/YyZR3Ev/xw4/lg3NOoPL0vvA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:50:22 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:50:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times during
 ras ISR
Thread-Topic: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times
 during ras ISR
Thread-Index: AQHalVgJfgHtEXo3r0S8jfC7u8ZRqLF4qwoAgAAFNlA=
Date: Thu, 25 Apr 2024 08:50:22 +0000
Message-ID: <PH7PR12MB599748EF6B5F08A547E2463B82172@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240423082640.3273762-1-kevinyang.wang@amd.com>
 <20240423082640.3273762-4-kevinyang.wang@amd.com>
 <PH7PR12MB8796EEF4F9900F1A89B85275B0172@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796EEF4F9900F1A89B85275B0172@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df544d6a-82bb-4fc4-a6a9-c286ca8696dc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T08:29:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB8246:EE_
x-ms-office365-filtering-correlation-id: cf769656-f012-427a-f01c-08dc6504be01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?RP03mpnPJX5yBsIkbWDEacQAHtBbFTXD1IzpSm8b2v85DFAM3wjlCsnQZacy?=
 =?us-ascii?Q?PFdbhke7nztY/OkvTzvQ9QzstQJVw5DTisgXq4kSDzXqpbMUW2CW97bECRgK?=
 =?us-ascii?Q?s4NTtiGVhhVfxcfXwe0H09/erqUGDLHDQ8OPbSZzBBk2p8VCEUEjQjHr4pfL?=
 =?us-ascii?Q?4lF2lBm+sec9O6ZjipYW83QrsljeHu/j+eyPfKGv3nqj6bJstpBPwaUcyGKk?=
 =?us-ascii?Q?KPNU5pfccZzapBBkx+JAhsCHWO/OxJTyR0iGjCsu4LHEP9i3V2MayXVCywnX?=
 =?us-ascii?Q?0W8405qs/a4f2YDanPd+2POhR3pSXHPwLS2uEhLQqzpr6bqmoNhBfrAOdC/j?=
 =?us-ascii?Q?bOvPiZx7cBCfGg8R2h9X43WHg+3htddelayp16JJE0BIaSDSIXoxWIBGgoSl?=
 =?us-ascii?Q?B1ojMv2kJD5YLFxx7HbQgN8N6Jf2b/NQH7FRh+sJdmqW+cwdp/wgC82LR7lP?=
 =?us-ascii?Q?oCW2JnW7OZZuVpuHsEYrxDiCZY1ZK43VdDnASYygQ2U/IFDD1TqxqvQc8BCS?=
 =?us-ascii?Q?89mMJpaCM7gpPuW5/6xD5JRL8Q5dvnjXJYyOy0o91OuPbs2sO0+7Uv+gLgW+?=
 =?us-ascii?Q?3p3qkj7QndJThlj1lBuvvZJ8kWVNYlQ2CLBUb7eRFlJ8WxoBvqam7xXavjDs?=
 =?us-ascii?Q?U3n53hPlAdcyeUtFAgeVwm3iWUbEEdZbQ/WBuCajR5QirJSinVLQsbDsLMzE?=
 =?us-ascii?Q?qDQE6DdjlzFKpXswOJlaTjpkaD0HXY6cmmtesScd54Qpg5LFHYkoNhw2gMiE?=
 =?us-ascii?Q?I0bCDBWqghNtS/og4jchZIm8QGJjJ7NB0h7om5JOZDpgNBeGz/6tL2sGCcMA?=
 =?us-ascii?Q?v+RUd1XiMdfe7rh12sRe7wprBZFueK7Qh8n7/fi+NXD9BallqVuc4AK9G/SI?=
 =?us-ascii?Q?ovl5RWWmeBXFUvJrYHaj0wiHPIq4tisVMKyt0uwRlsiKRYYDXt7B5TmFNOkH?=
 =?us-ascii?Q?0qKxqrOXoU2oJ+BfAPf6r+Ltb1Oz5qCkgRn4mn6IgaueANp6dvM2gikGn+na?=
 =?us-ascii?Q?0iXSEnOfTSUBe6d2kmcvq+QXzjYMWI5wy9ue8z+8Q+0aJhWCijEHaFqyqrz5?=
 =?us-ascii?Q?+jU8ofOkmhcrhvEYcQfUt4ffbqqz+0kH8hmY0F8nlbzxonkeeus5aI1XHYkP?=
 =?us-ascii?Q?sJN96vVuLqmIAzSmCyMGy91sUzN6vshZr5QqHfZpEdlmjNpiDFdv7p7FjpAt?=
 =?us-ascii?Q?16SdAalTD8fy038FSM2S0MjoSzF1DIQRqsLyLnBi6el0b1VKUX9iHEmgJt69?=
 =?us-ascii?Q?ieinGKE4hEfLvHEKAZXiwYzDfyRuCCNcMEAc5KDiYcpXAIUWpZVbjBwppz/z?=
 =?us-ascii?Q?rthK9w5BjtnEGAh4PutbQ3sYShOqFqC8QH7ovR4XdELooA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jy6kOUHSDVXwxHQ9XuUPC3z0VELaO1krSUQgN1t/iJDm/GwGPWSYwreWqwvh?=
 =?us-ascii?Q?weOqR9zq/pRuhydl014eIs1q6qhRPglgif6gLSxKKH2UBJn2cQWhrWqBdLBs?=
 =?us-ascii?Q?hXg8Nvv/YzpM7puB3SwBNPNUg+sZ2gpbMmFv7rQP/rlr4EyvouVB7AYqLocc?=
 =?us-ascii?Q?HVDFjqT5zvEWcX36CA6C5rAkFpDcj3VbltWk8hiG7dfoDVXnKXBwATrPQlS0?=
 =?us-ascii?Q?SdlyT2PILcBHFSA+RIzWG/lOea41Cx8GG4J4bfnNe4t0z2aNR3HiX/8uSMg3?=
 =?us-ascii?Q?U+wqMi23dDzCw2KM+6CK/mnveBiwckdwBjGIEJRJ0L1brYOAakT9QNgzSEr0?=
 =?us-ascii?Q?e1oJ7pk1jg3nLrHlYLJHOjRwdW03oHv/2BvsRo8t7RMWKO4ohDp5LmSzo2IG?=
 =?us-ascii?Q?n/B5jjH38qGkg2PaxrSZpkk5DAS0DcqsEMYq83IezHdbdZ6C6f39b35ce0Wv?=
 =?us-ascii?Q?k6ohJcs+4ycSOFmLUcM1Z2x2aw7sSHoUANmL18p7lldqjdea34l474OFs92D?=
 =?us-ascii?Q?ndbBDIPYFlmoqahXGok63iltGjJscj4gRLzYYEV6IKcfEEqLDYGCLXbGN8Ce?=
 =?us-ascii?Q?njtOxsQaHxXDoAtcdTz6tC8PYVYTcmh/oabhukPorWmUU8+bKcbyCMbKcYed?=
 =?us-ascii?Q?r1NjKD2glDsOPlYNEEtrpL2PGesM+GWlct2Tw486xi4RriP6/kTjTTrae+4Q?=
 =?us-ascii?Q?OKAtNIgKAWjphHKL7zEqlECfzGIYQ7U9KEJomaZNMbA3rllYnE6K3stC1g7j?=
 =?us-ascii?Q?xUKkkN+HImS/fQzJJv1ORPGWvgZjv1v4nX5ef57BCcASq6NonmXzGtU45MRE?=
 =?us-ascii?Q?NlqXoeYvcZolvVwZByPe8/jeYVWnYUWsOzM2SNqTaisyqu+mWL8+uiWimwZ3?=
 =?us-ascii?Q?R3UokuewID3EdTRfWM5ZyNsevo/4GsFe9BsWzVdoxZ7JOF32XeoeGvQa0eAX?=
 =?us-ascii?Q?Py/cmT+n4+8G5dJ2mY1NhUmn2yFznr54Fpo2RktGGxeQiNifAG2Ef31wFpm5?=
 =?us-ascii?Q?MVV5CWQ8map79iXbek0kgbXJ09eVvjsfPVYDEBvTzcxbKlqIH5z1bOQ9wLIo?=
 =?us-ascii?Q?22ntQQLwUR/rvqV5ViLHHLylzBw2mh8i+LahkQWsrqVJPcnyAlrEGSqpLDA1?=
 =?us-ascii?Q?iKZw4UQ0ZgJkZ7wgWk3bTu1o2QZWrXiOriEGhTYXzs0VySSaQ1123E18Qat1?=
 =?us-ascii?Q?sb2xjX8rCITdKRVaqLvJ61WQNCijSyHC7Ws/1Sl272s4bN/5vCUZkOWm+IK4?=
 =?us-ascii?Q?iwPFf0keeOg7SCvVIMavnO3baFYml+3/rnIK64BudUu/yT4OLRAlt5PXgzQF?=
 =?us-ascii?Q?0UuN7x3CRzPrmGUcCnX3/Wue7bqs7hImWKygstspZoJG5AXffnPkQo33Hfb3?=
 =?us-ascii?Q?gOKdXLaMsItTBRhVoFo3eqScndp+XCSbi/4/fq5G1jhX2BixKVE32CMyOdgR?=
 =?us-ascii?Q?EkGYyze4i3y2ZqkBFoAplZzmrvF6R1ImHdwqyeBqzwHCKkCig/qCS+AK2hJi?=
 =?us-ascii?Q?BERW3GMpsDygLEtdPvOjCIPOsF9gJv9/a+xlnSTY72y7F/BOMT6LreEuME1F?=
 =?us-ascii?Q?ngaeAhWxSbdSEPNw6Ho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf769656-f012-427a-f01c-08dc6504be01
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:50:22.1736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgGdAPknLqjw02Chsqgjb1SHgJ5qvfusqHDmoVDU7Iv5xRW45IiiwltM2/rWdOgV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
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

[AMD Official Use Only - General]

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, April 25, 2024 4:31 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: RE: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times dur=
ing ras ISR

[AMD Official Use Only - General]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, April 23, 2024 4:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times
> during ras ISR
>
> because the ue valid mca count will only be cleared after gpu reset,
> so only dump mca log on the first time to get mca bank after receive RAS =
interrupt.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 28
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |
> 1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 264f56fd4f66..b581523fa8d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -229,6 +229,8 @@ int amdgpu_mca_init(struct amdgpu_device *adev)
>       struct mca_bank_cache *mca_cache;
>       int i;
>
> +     atomic_set(&mca->ue_update_flag, 0);
> +
>       for (i =3D 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
>               mca_cache =3D &mca->mca_caches[i];
>               mutex_init(&mca_cache->lock); @@ -244,6 +246,8 @@ void
> amdgpu_mca_fini(struct amdgpu_device *adev)
>       struct mca_bank_cache *mca_cache;
>       int i;
>
> +     atomic_set(&mca->ue_update_flag, 0);
> +
>       for (i =3D 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
>               mca_cache =3D &mca->mca_caches[i];
>               amdgpu_mca_bank_set_release(&mca_cache->mca_set);
> @@ -325,6 +329,27 @@ static int amdgpu_mca_smu_get_mca_entry(struct
> amdgpu_device *adev, enum amdgpu_
>       return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);  }
>
> +static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev,
> +enum amdgpu_mca_error_type type) {
> +     struct amdgpu_mca *mca =3D &adev->mca;
> +     bool ret =3D true;
> +
> +     /*
> +      * Because the UE Valid MCA count will only be cleared after reset,
> +      * in order to avoid repeated counting of the error count,
> +      * the aca bank is only updated once during the gpu recovery stage.
> +      */
> +     if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE) {
> +             if (amdgpu_ras_intr_triggered())
> +                     ret =3D atomic_cmpxchg(&mca->ue_update_flag, 0, 1)
> + =3D=3D
> 0;
> +             else
> +                     atomic_set(&mca->ue_update_flag, 0);
> +     }
> +
> +     return ret;
> +}
> +
> +

[Tao] redundant line, with this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

[Kevin]:
Thanks for reminding me.

Best Regards,
Kevin

>  static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev,
> enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
>                                     struct ras_query_context *qctx)  {
> @@ -
> 335,6 +360,9 @@ static int amdgpu_mca_smu_get_mca_set(struct
> amdgpu_device *adev, enum amdgpu_mc
>       if (!mca_set)
>               return -EINVAL;
>
> +     if (!amdgpu_mca_bank_should_update(adev, type))
> +             return 0;
> +
>       ret =3D amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
>       if (ret)
>               return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> index 9b97cfa28e05..e80323ff90c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> @@ -93,6 +93,7 @@ struct amdgpu_mca {
>       struct amdgpu_mca_ras mpio;
>       const struct amdgpu_mca_smu_funcs *mca_funcs;
>       struct mca_bank_cache mca_caches[AMDGPU_MCA_ERROR_TYPE_DE];
> +     atomic_t ue_update_flag;
>  };
>
>  enum mca_reg_idx {
> --
> 2.34.1


