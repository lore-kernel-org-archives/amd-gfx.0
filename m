Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7440FC7618D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 13:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043B410E01F;
	Mon, 20 Mar 2023 13:16:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FA710E01F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 13:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FodmtQwaUNz/u2cFneALTIbJQBtpKZVHSWzV+7e7LmS8YXMc3+xc0xJs6KQG8VhqDebrDEyTtFU7WJKPYK1VIJ7zNn6Ik12lWXLi3oW59ZUvXx2wD0bB7CsXJrlFbFsimiFZCoJES3ylJFWmq4ULYmLkV8hxM6cI2Ubbjhc2lKACBjdStSwHsSVslNdSO2D87RK/e6TLmD/7vzindmm88Llbe+ToKQXueql8x50vutxktWofHPUiNUvgX7uJtWizFmXC7pdGPIkrdWf9Hu5pup+ZSy7kQDvJLFp79qhTC80r7K+JWLhdQawdbihVUAxmexys84WjdNCvkAIreMC8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puZN/khW0aOz1P3qj+2fb/9qd7eAZnP9LXlVdDbc7WM=;
 b=BMnMa+XOXDeXGZvKVr+EuCO2h8440rMNFYgyeDSiRaHg69etkaKmQuR3QXOoXOoaAc1QVmQnSH7KUwYYGlEFQsfxRWwDx4MNneomXwMbP1kLM7W9mKy7ShkNflV7uIHScrgP6bcIbGRIke9yVxn9WAJC5K3LhUMebvAsxsLygPXEzAbrWc8XL0erGMKYb1BXkAFJDVZRl+HOQGTcWuzgRhOaJvrB05SkqDuOaQBP9cmiUmP1hg9FflHA1YmVHABvzU9FowOaCe4+H+1QFsq1gcBbOd8gcCulJeARLqIXMJJFCTvjCEe9PkzZkS9f601NoL8s1e+l2dzNRkkGfgbWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puZN/khW0aOz1P3qj+2fb/9qd7eAZnP9LXlVdDbc7WM=;
 b=mpKCccxoP2Et4N67f+5QB0b0lwzjbxe7C47VmsB4F6EhPQbMiUsEg849O5QUYgEmVlftbatqkPAef+MQOS8XPjEe9mfNrjuehjl9gNAwhvhrH1ma8AEk4AJsFXpu0qZsbMg5OOoWyiEhsiQN1zLecErV//53hz8EbfqKy0ZRaHM=
Received: from PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:16:28 +0000
Received: from PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3bb0:da9a:5a44:8e32]) by PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3bb0:da9a:5a44:8e32%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:16:24 +0000
From: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for
 navi1x
Thread-Topic: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for
 navi1x
Thread-Index: AQHZWW9kgtVbRpJIVUSk4OM83wUdK68DWGwAgABQ67A=
Date: Mon, 20 Mar 2023 13:16:24 +0000
Message-ID: <PH7PR12MB583199591148F8B68F1DABE8FB809@PH7PR12MB5831.namprd12.prod.outlook.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
 <20230318075615.2630-20-qingqing.zhuo@amd.com>
 <DM6PR12MB2619EFBDFC4F2F9A7DCD2FD2E4809@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EFBDFC4F2F9A7DCD2FD2E4809@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89719c98-2581-47e5-b606-cbc0d259174d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-20T08:26:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_|MN2PR12MB4270:EE_
x-ms-office365-filtering-correlation-id: e8c4d5dc-8630-4ac9-088c-08db29454e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRtDUFrKp66Ua96x+d/Wx/REs48UOPiRwZOLIIVLvC3tXJ8S4di55Gcr7uLvspfIhV5MbN0kJjekXC5oe+64/Cj/0y9SVEwIncji2c6H0aRMgbMrMqmSfyb8EJ6tthK7NvRfeQbUPmGt/dSTHKbxZlVi8KGj0ym/4cYk+S15h0DFflsievmXYj4xdAXgH1FnU/XiVrCNHUlffNkQnp8jPK/7nqeXTRNxxM9M8ue6oEyvarxB+cDs63Z9fQl8nr6oct74Pw86QG8P3Ymdh0b2Mj9n4aAL7hmnm/+jXlTwtIEh3PSXd1/ic8gQ/4jq6kgmFpCNDvb2RjGHxgdiI39fQc/wjgJTCCWMCPC4tOmz2uu8aiBQOmHukAkYthk/iJrfKV8cMye0sc4rAkAjdncnZznUymrcxOQr39Jw30UPsNAiCEH1rUnaYDhLK3ZfcT/rAN9Qs/hPTaMzpFbkCLK7A0z8Q/fSDGdcF33TMZbdHojKU8YiEqv9M1ai18hOnEFcibLrisnjoAe1AnedQgSnhxMArkjBTlH9svpOevEuoGLCuU//Luup6aZMxg5Mh76VuTe6EA1BhD+zBamIHlQQCrp33Aam5cVNMobIwROhbRfnWzAzZQcVky9RAOapEEJHNJGPua8SqK3TUm8LtfemTTYaIsvglVtn2Ri2Q8IQVhCdlTGtUDR6CcIxhCirqefC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5831.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(8936002)(52536014)(5660300002)(41300700001)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(2906002)(4326008)(966005)(83380400001)(478600001)(7696005)(9686003)(71200400001)(186003)(6506007)(26005)(53546011)(54906003)(110136005)(316002)(8676002)(66446008)(76116006)(64756008)(66946007)(66556008)(66476007)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GpOnZZrpMswj9Jqbkjf9xPBZ/W2Xby/8FMfXgcTfn+EDQ2km+gZR+o+Ec9hn?=
 =?us-ascii?Q?05hh6VssSXCa4RbSnXTEL/kBo+8nlWbHG9rNjHVqPAS6HoABY4UutAC65Rzo?=
 =?us-ascii?Q?xFpRZ+2akZa259QCW+fPotln431dGUjRzNeXjvF1XeOv2Hj3z1tekQa9SIAD?=
 =?us-ascii?Q?OgTTvt0pj5Eo1owmMiICV4LmT5rJRPRFn9542zeXxr37FCR8p+PGJE2J7mgr?=
 =?us-ascii?Q?8h0+9UJ0B1Gnd+o6Sw26D9dGVooGNlnhOIz7QpRM5D002S1zFIKQkR7X/JC4?=
 =?us-ascii?Q?NkUx9nkIl2Uj8i5vFKeuGwqXRtHE4nKizvk+ps243bPwA2BDgOadqlUf6m/R?=
 =?us-ascii?Q?Tcq0cMC/BGlovAXzHpWd0v0Yd0KbPJHsxphIplpQ/juc5n82xebirU9fDCnu?=
 =?us-ascii?Q?+Ge6BUcFFqjwf6ZZmyAOfTd/DSQBWwjXpN1cJC75fBUGtTb0+Hvuiq698rto?=
 =?us-ascii?Q?UGRNcFHzoWmAi2t1etbIm0fzo/3ZeVyXp7LigSMOGaHrpyZiQW/zW8D8Pk/e?=
 =?us-ascii?Q?yQzhZH5ZqSksMbKs3zb875WV70p1Qnsl389iSuCGuwa1goCOv68DjjmE1UhP?=
 =?us-ascii?Q?CF0z1CkBaYR7faXGvoI6TOeclRi1sfm9Qg1+CBIzw5KiSG9tBvd1hHEV//5M?=
 =?us-ascii?Q?B8ibyWn8CjwTkeuXWiheJWmnONO5i11E+8aLT/LLR8rVdB/TrlTd455wTBel?=
 =?us-ascii?Q?/YRdw3xovZPtQk6Hv2kbHQRhPHYfogLW7uylptnxiXJCy6cSUu8jrXtGhW+t?=
 =?us-ascii?Q?zTFGGu76Rgo6kfJEsileg0PHTb6A70zsSmpgNA60UXGse4IYbpOYLr1xjJfT?=
 =?us-ascii?Q?3mo1P/RrmZ6ZP68kbIRgFwxzD1QxM0BMFNBvT9W03OpSZMpqBqOyN4nRqorb?=
 =?us-ascii?Q?BKUZPMZhRaa7KVRc2XmEmXGjkvZ1WkoRvnzOFNfkghc2u/yBBYMpRdH+JzzC?=
 =?us-ascii?Q?DD2BQJNjQ8ZqkEtsivEqz2t5BLqLr1JvZmq2iowBahTdyC87XfBAmuBF/gbH?=
 =?us-ascii?Q?uVPlCb05gTYkHmmyePujvT/a109zumVAlwNNB9Bn0y1d5GiLbHoNcxNb0YiQ?=
 =?us-ascii?Q?DnXVudyJ7tWOhDI3AQivr24U5CsVMYeqELLP0SkuH0b/0B7iI1YUV7nT8om7?=
 =?us-ascii?Q?cgC0UYx0cxk5n1+SW0+u4fM7BpZGylcGJSS6twNka6dS/MyBzpOEttnrmtQm?=
 =?us-ascii?Q?Pm0jDSuhMSykEvZfKpDAsSfkhxpf5U42KfSFEkDP9qD/bVCUgtNCyJO3/DAR?=
 =?us-ascii?Q?ZQv+SwEqMnvFjvgsdAkgl1/sStdJkRFzDZo5Gzhzs7tuMOQk5kL/4SGl86JZ?=
 =?us-ascii?Q?a+kkTULE/ajUp05HMWY7aYnn2aUNBTXQaiFjA4EXtgwRxdkcInlIrbf+skBD?=
 =?us-ascii?Q?lwhOWFyjyu2ovzu0na+ZM0942ZJTlf+mPvRBooZ0s9ykK1K4GZelN3JZlKkR?=
 =?us-ascii?Q?SUYj9A5OEpzDMexQXvyXmsyGvHJ4zMeFTYVw6rpIEdPe1Swl6hlDIfWEL8K2?=
 =?us-ascii?Q?ti0lkgLcqAdmOO45TR/51z1zuv9BVlw0WzfVFigWzumv1T79CshCdQcjQgyy?=
 =?us-ascii?Q?3UMeHqbj7iRNP726gKk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c4d5dc-8630-4ac9-088c-08db29454e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 13:16:24.1919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUAoFX7xboiQfQ7kjVfMqqxX+hm9xwen5FqoHVAnyBwigd0Pc+4ZcehtdCGjWTgV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira, 
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks Evan! Will do.

Thanks,
Lillian

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, March 20, 2023 4:26 AM
To: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedes=
ktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bhawan=
preet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotar=
ac, Pavle <Pavle.Kotarac@amd.com>
Subject: RE: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for=
 navi1x

[AMD Official Use Only - General]

Better to update the subject with prefix as "drm/amd/pm" to align with othe=
r power changes.
Either way the patch is
Reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Qingqing Zhuo
> Sent: Saturday, March 18, 2023 3:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo,
> Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu,
> Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN
> for navi1x
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> May help stability with some navi1x boards.
>
> Hopefully this helps with stability with multiple monitors and would
> allow us to re-enable MPC_SPLIT_DYNAMIC in the DC code for better power s=
avings.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2196
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 95da6dd1cc65..c4000518dc56 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -304,7 +304,8 @@ navi10_get_allowed_feature_mask(struct
> smu_context *smu,
>                               | FEATURE_MASK(FEATURE_GFX_SS_BIT)
>                               | FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
>                               | FEATURE_MASK(FEATURE_FW_CTF_BIT)
> -                             |
> FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
> +                             |
> FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT)
> +                             |
> FEATURE_MASK(FEATURE_TEMP_DEPENDENT_VMIN_BIT);
>
>       if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
>               *(uint64_t *)feature_mask |=3D
> FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
> --
> 2.34.1
