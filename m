Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F73C71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 03:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E37110E5F6;
	Fri, 25 Aug 2023 03:23:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847010E5F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 03:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWOrfvGZ7sXmu2z9i5YYUXQnTrmZgQBCkITcxOcyXYW5jhq+yQGb+/ie+NcXhIyzxai09PyGYwuCdPlBNBTGfNhQyByxMeF7pMv6C5nonpVyZILa4UpqUNV75ns2SVMb5XZ3WbUV7a4IwTz/jKieAefN/A2PaUF8465cyFHP7tOKK9GcDXK/IlGTKjP+rPdfxcHq4uoFoT9GUYn/a0B4D84uXbSIEFDew/si/bGNV3SoGeeISQGV7eZZ7wI/oD5eGmV6zR0gTuRqKWGbzeGcz/IU1ZfAV0RLzS1L3zc4sUS1gzrajrnrLn6bwy4FJkVOZxX9obS9gNOpiIl+3mlAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgbbiHuh9lTEXLwDNRdCdYuNcl/w2Awh7lqqgTk/q9M=;
 b=iEFQ0QboOa4ZDHEk4/KwJKtB14UCzFNzYLwVyNXCqJalIaMZAvzChyixPxcTuQiig+mKIdJtzcahhtG1TfoJOxPqo44g6uyxO7+KwBMNqjKI4IZrYMkHi+Sx52ap8G0wMjO6mNMsLe5XPvP/Kxkyc6Siz/+9Iydq1d1bWKpeRDi+lciJfxE5R2m0va0od2tjz/jskvSQvO2Yb++etqraNIUo5by5zo+74vnbT/WqeDhiI45eiGNaG1nAQqCBXsViVn0A86lJKnzD/YL4gJf9YhKan22ytviMh+ux0oMlWEqKeMvu3ZoEtOAl2OAyWQm0pSuAKYTPy2X0taHGSU5nNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgbbiHuh9lTEXLwDNRdCdYuNcl/w2Awh7lqqgTk/q9M=;
 b=u+1gSfVHniV3KKs/1KAm3FMwD/V4bxnPlkhJaY71ux7Kyrsz6sWxs60oMGEU7548ckZjLzPQt/ewhgiCEbyiiRxod+pMR0LV++rl+UWiqzlKFCf2kXOOwBKg6m26qdhatqc63zPojSxoCszG5DGXZaPDIdsewqiUiiHKNP4WT3o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 03:23:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:23:46 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: workaround for the wrong ac power detection
 on smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: workaround for the wrong ac power detection
 on smu 13.0.0
Thread-Index: AQHZ1wL4gNj/XXfUCkKtLWFn+2AC1a/6WKNQ
Date: Fri, 25 Aug 2023 03:23:45 +0000
Message-ID: <DM6PR12MB2619A1B05DEC2910DABC3A52E4E3A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230825031926.1932471-1-kenneth.feng@amd.com>
In-Reply-To: <20230825031926.1932471-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4f9da804-236a-455d-a265-51084876bf50;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T03:22:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM4PR12MB5889:EE_
x-ms-office365-filtering-correlation-id: d95c3cd8-729b-4077-192d-08dba51ab0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mOLC73Hk8jnWami0+Td1c/FcV5OLW7PRChE11QftEkQKf9xhxW0HF4tM3nVmaRRWZrKVJRYyiClkTRcTGvkh9Xb3hXxOyi8TKPjZK6J91wAcnG86LHnT1rA393RO/W+dKhhRJb9Aj9ZbNXC6a9GrXRFqKYSFgwAR2DaVCXw9BXH3ATPZ7CYfYapKFIS40EI7jGQZyRPfkpIEdKvWRpkavfR6khop4WJwdBeCOnVY6+/DJkjSW1j/qS/RbR5/nheVQ1tEtq2HAfT/KoalrqYiO5JP84xzTrRFYiNu/t+B95kTnauBJ5BVQiEVM+gHSEPLVdFk/o2yj2gupMPy7KEiyzKO9bNh0YnsDmXI/8bmzTZ7b8HW57By6LcHZqbtT5suZAfVlUgOf/qreRQLAjuM/nwic884GiZWMsEr9xOFZMBpJTWRjcSW4Tw7HKBWvr4ldDD9qm6QsV8CWB5uMCRUh/ipppoWezoRweJxZ2K/22j1e2qrxlj18kIicCnnCTJN0n95Jbq6j+hN8kngvvK+3SuqVDDIr3koJAouJO3C1PTT3vsECrci0lvyp99eFwdey/x1OvcNviXwVEI12+/jVrra7Re7dn8eN/Buw/dWe8ps/VGiR/p2vEz66yzG23e
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(66574015)(83380400001)(33656002)(7696005)(55016003)(71200400001)(38100700002)(38070700005)(122000001)(76116006)(66556008)(66946007)(66476007)(66446008)(64756008)(316002)(110136005)(478600001)(53546011)(41300700001)(9686003)(6506007)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vkv1f2wTJI+IBjz0S1ZQEYno7B9qrbvuMzBUBzfdqEI8RMb2MgXGJotYyAu+?=
 =?us-ascii?Q?rOXlsRVvm53jo8a3zrmYseEcWlFfsQGdQH3SglTgOJZUIqO42C+Ua2JBDjL4?=
 =?us-ascii?Q?utwH5JJu96xzhDdO2VqzVg7Vt32aIJPsmqHkAFLvirxgh2ub/oJLyuqrvbY+?=
 =?us-ascii?Q?xY6mv9oY/wjMbkvZG505Qut/UkoVX6/kckhIMP+NeMEQ3s0TEk39mrsf1Rbo?=
 =?us-ascii?Q?OPgK8cJmgSgfvwBvshWFnz0bIGSnbGGFpycZkJ4Euc1CbqfrRVC3U6QE7+xC?=
 =?us-ascii?Q?nH7TsifxA/fwBFkIbRAfwmj6aEyollxdWOuh/BdtKsuf/qzpVaBwrJ60e4V+?=
 =?us-ascii?Q?pvfxmH8jO/DOJAnBfmGkd7x06BupVCQgdjjfqfh3QsLddcSNwomxISBvuIBj?=
 =?us-ascii?Q?QW5FaEWKdz1bkzKDfF+lkpkopOgQ+f1WOqP/Drv8diypEffM2d56dEnOACrR?=
 =?us-ascii?Q?9vc8gF3F6GWlkh3SJ8AwVA1ldM6LHT48FZIwKhpB12fl2tX1LDHCCVOhz/mB?=
 =?us-ascii?Q?hLTdZ5vqPAvuRo4jsiUKL55n4Rbry0IdMFUWY3qFyprc1MclWiDMOyV7uCRo?=
 =?us-ascii?Q?ycndg52rj8hHPNCbJNnT0DHhUuhtiLl1jk7lwj2jeBVb5lBOHVfFY5LZadGS?=
 =?us-ascii?Q?Z5JcwdJE46wq0QpN8hxXV6ClEL46yQ1u1rweTbY4zi0D1qFp9tojDMh0aH1q?=
 =?us-ascii?Q?YzPSLy3fnWQvNAwFlZ25h/wt/+/6ssZ6hTNryaml59/14mKB6IfB3uLPTdDM?=
 =?us-ascii?Q?0DwQ0FvCV6QwkNPNyMypUq0mGIzwr1b7CYTtCmPCujXNazV2INXt0HMmj4KO?=
 =?us-ascii?Q?1m0edBDNSrpZGq7vzv8x3BApaWurIACzLRH678iDX71DaPaW1H9XG2nktPMM?=
 =?us-ascii?Q?A4NWBnIaaJVXZ1WlL/eue/jUjEXJn6E0+KA3o3ir9f/fNzS9y7GHh5673iNQ?=
 =?us-ascii?Q?Qigh000nGjyNUO0+AjXGD+A1F7EuxFQZt4WzMsQZKmyxN+gItmW/JJE851tw?=
 =?us-ascii?Q?3Hx0Wk8WGEiHQ67Wbqn1WyMns4oteYu9MHKbPSjFmMMpSR7CssaNeUbYeBS+?=
 =?us-ascii?Q?2v7DmGNwb2W+/mp/lZJAs9MnddHwAh3mlsgPseFZYKdUgl+hq86Zcu1KsknH?=
 =?us-ascii?Q?Botk/0VRnhEilGfdV9MOovxafuavwSxUBTyDwj1/AMgyNmfsNLKQHKj9XegL?=
 =?us-ascii?Q?unwR+YrCyKomj5+Knd90KVMDnVe18sn/ZtsYWMJS4cP4CDyFMZn9QZkM0fvr?=
 =?us-ascii?Q?cz/1CXgGyNe+WwIkU4i+PsNdNtrq3t9uaIsY+9yXmaQVls/z5n4agaoQEc3X?=
 =?us-ascii?Q?6aqCEEXZzWNOO7aNprNJ7eerCa3nT16oIhpkE4t0vBIgLwZXRrf8dOmTtRsW?=
 =?us-ascii?Q?aCpEXJ226ugLgrugkbJc/5GZgtJG91237SvwQ7wgYV0Qv2yZhqLVXr41wEeI?=
 =?us-ascii?Q?wave3uFIXdZFZJxMVfIb3WvIVRxCKkA+mbkttDF4boEceqC4ecKaXuLxQu0l?=
 =?us-ascii?Q?U6MMq6EngI1MIQIvM+XALQ+9ozkSHg4cNuW+tjBrvB2KqWWnEWdiURk7tw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95c3cd8-729b-4077-192d-08dba51ab0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 03:23:45.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoGtwyFIqM0V41VgQiTZup4zYvhJQPqiaDxv0dawWh+x6Wve+lSK0l9BQezZeM4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

As discussed offline, better to document something like "this is a temporar=
y solution and will be dropped in the future".
Either way, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Friday, August 25, 2023 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: workaround for the wrong ac power
> detection on smu 13.0.0
>
> workaround for the wrong ac power detection on smu 13.0.0
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 +--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0232adb95df3..fd1798fd716e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1021,8 +1021,7 @@ static int
> smu_v13_0_process_pending_interrupt(struct smu_context *smu)
>  {
>       int ret =3D 0;
>
> -     if (smu->dc_controlled_by_gpio &&
> -         smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
> +     if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
>               ret =3D smu_v13_0_allow_ih_interrupt(smu);
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3903a47669e4..128468355375 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2664,7 +2664,6 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>       .enable_mgpu_fan_boost =3D smu_v13_0_0_enable_mgpu_fan_boost,
>       .get_power_limit =3D smu_v13_0_0_get_power_limit,
>       .set_power_limit =3D smu_v13_0_set_power_limit,
> -     .set_power_source =3D smu_v13_0_set_power_source,
>       .get_power_profile_mode =3D smu_v13_0_0_get_power_profile_mode,
>       .set_power_profile_mode =3D smu_v13_0_0_set_power_profile_mode,
>       .run_btc =3D smu_v13_0_run_btc,
> --
> 2.34.1

