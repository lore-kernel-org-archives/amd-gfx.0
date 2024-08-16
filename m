Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E399C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 19:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3EE10E839;
	Fri, 16 Aug 2024 19:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJSCkZa2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9543C10E839
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 19:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p84Bbhqum2HwqStlamRGZhXU85UgRs8eGmFeITcwizQKUHDtuqlNIGoKbU82MvaLEvYOTCm3T+Cqu3pWzwInLwENRy4r5E55xoqOHKiDYla8z9D9CvvwRwbCSVQVMeGb5uOw40HsVx5EXNrbM/ntvUzdCAri0AZmyziHsva367VP6WXj2/olkPnW8QWdMaDG9kZmGHldnjKDJ9ikov59nW9FW+W2zDGqcpP8zv0Vl0+RoFje3reMa1LZxnthyip9RqqYUZhKeAa/l1yEYLzi8T9Mj0FEHdnFbtbtXYeMeVNfY6/TIX1A9GhvtChIh1g68jnt/dYdEHvnZA4ZniZdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEwjnXGKzXaELBQjUv3YGyKTGEAg1PwLNoQiAhwrLiw=;
 b=u1V+rdyfSIlrjq77w075XLFAx+Yifx3rqhxfYzAKEMLhk/0dAMyj/NRRSDK1K23TUDcjA4NXXhm6xmx0zrZnyl/b83kxqd2Z8/4GalKY85O3Nlmj1FhK+wdT7Wf4rLlOF3eEgC8Lgsx68AtBmhCxkahZEssiUz17oVSZ265YfS5AuM+zhaBG6kvSYZaVXCkLty8O4oifPEbYma6ygXbo6DIXxP/XQiNH4KOPix4QdmNmtN1ZFs00KJuaUpPVLYDZoFYYeNhlC7MFKUqy8PfazAIzNssBO7ga2SymQ0fL5TTlz/cj4NCqkoMB3Wam3V+DyjixP8+3PYIdVNQRrnWSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEwjnXGKzXaELBQjUv3YGyKTGEAg1PwLNoQiAhwrLiw=;
 b=uJSCkZa2s91JFXvuJQ4+hIx/2ObqxoL4D1gozU/9GTyw8iTMdGAmCiL3mKpd7i02SKRuZKS/sktx5DpvWlx/SBkgQL9mMqvfJck60nTN4gI+qrGscEoQ0fTN2AuhFAUOj+7YbGnb229D181SOWQY471Nq+vPlQAMMZJypZk6mxI=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 19:30:40 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 19:30:40 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Topic: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Index: AQHa72Tn5iMMWSqT/kqbFxnwVwSGXLIqRbqw
Date: Fri, 16 Aug 2024 19:30:40 +0000
Message-ID: <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
In-Reply-To: <20240815224525.3077505-13-Roman.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=11d8571a-fe12-40e7-bd0b-0e043a538479;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-16T19:27:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA0PR12MB7604:EE_
x-ms-office365-filtering-correlation-id: 4c7d7155-e405-4140-7bd2-08dcbe29e9ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2DZorQt1It7j5kkmydc/845F7lVE4humH+2XVNs15GbTmRwW9HXnzksIXtIp?=
 =?us-ascii?Q?viiADqAPimL6pYFn7aiYNOx92CnMqknZDkxVtB155wm3hnv4En64CEnXB8DT?=
 =?us-ascii?Q?K3QWMj4nJo8LRYZ9nhvIm0AbAjH8SWTvDrCrksVqZ4mbctWLo+lsXmwORKgh?=
 =?us-ascii?Q?KOfN8yqnkel/A8VAljnQu37icx7vkYkQvBCSZ37Ciha1uQ/f3GaqqTVHX8Ji?=
 =?us-ascii?Q?hJ8bdHE8caRXl6EoyOPml+SkjESvHhqjZKXlq8bhGjwDpzJhQ0VPbe/qFQbi?=
 =?us-ascii?Q?V83jCjmUs5JyACUNqT0p8t8tE+ERFlwekv/8hEVDRVqLvSO65p1C6tC8YvRR?=
 =?us-ascii?Q?iYVGP166jr6/HzJ/Q+ObU5jjqeOuXq5ERkKbExZt/JDH8Cn9DMEzQ5Ubyq0X?=
 =?us-ascii?Q?qwrZkxun7SHx87PFF4s7/TfwH7fvZXbkXaas53UMshi3ssWNQKffjw99l7GX?=
 =?us-ascii?Q?8lZnvWbiP/eXWidLUUqUNac5B2Ma1iUYxEkEdUQUtNB4X2RSipkhtPHr/y0k?=
 =?us-ascii?Q?w/NEzuRztSHBORNPtdVRf+4iFcqt9V8yR4kVIa60d6z8xM9Cnpy//trw9CxZ?=
 =?us-ascii?Q?8M0hb6aXQBgSo1+BLETXpeKaaJ9TaukhDmHi9jppgwYXeX04UokfUzc9z3ZU?=
 =?us-ascii?Q?eoIVn+30xTqkgty+Ru9yvHDqtu5P2ch43NDc2Sc3wOHEzA/51aNwylkSpWlQ?=
 =?us-ascii?Q?+xZ56jiwqweLZrJVC6wJPa1iAzRlcgjeS5c9mKKAHqyGjCQAIJqEhnE9XsS2?=
 =?us-ascii?Q?NCkzvfZO43PABL7LL+jGB4rD535FJIpYAKAERWDYXRuPSmV/5tXpnNQH65ni?=
 =?us-ascii?Q?5h8DEj9Gq3kBoeYr9OTVpKltzsj3C5MA7agMUWDgi5c+YhslrsXJsx8vvWVQ?=
 =?us-ascii?Q?0coxUfXMi4yMLXjXWim1sN1gW7WCLoMnL22OeztbLwXVy+udkUtxSuwtNaTM?=
 =?us-ascii?Q?kz/MszO8sWhKzBWhk2kZPTEP3QpHoUXVeB5O9KzetFdQKEhywdx4u3BP5r2l?=
 =?us-ascii?Q?TkqTQjMLt0s7R04VL+RxptViGHoJY/yh74boSfxhuOtpYlPG9SRdqSzoZ232?=
 =?us-ascii?Q?/i0HYUKlwVELaYYCKDHcBN/sOlLGCT8YYjNgnEEY1PshOFpYu1d72iDZ0T/N?=
 =?us-ascii?Q?0A5AEvnqPgXjNWT8Rv49vSMNcV1YWOVCqTKT8kcliXYzBJI2fe5PZGQOv0nV?=
 =?us-ascii?Q?64fY7YEYct/Y4luQuYXNMDX5ghgSkubLc+EhMbcP0R2/Nut8DlziT7ffGg5Q?=
 =?us-ascii?Q?11xJhvovH8xGSc2kJ54v5oPCSu68MQjr/BQKoBzKE0t7EM0kocKZy7sZD32A?=
 =?us-ascii?Q?HW1j0KGdM6EzfobFJvHG2fEzomioj67lAdkMkALHYrCfHBLonQdI+W8cL1vF?=
 =?us-ascii?Q?bJZEDqI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ueRDwyQL+HPreCEwTd/N+l0kL7t6f9vsiWmIEHGcQ5Yf/FJ5HAFEEgbGR3sC?=
 =?us-ascii?Q?+5gaLyipexFP2OTiS+u39Y1NwfTloElLj7iGfpgn22JXe2IaWeAKhDMBTtvF?=
 =?us-ascii?Q?G19Gh0Z0V2fIdQ3aXjrlXRO+U9kW2kbYN9hl5hzeGzK4p7MPFIM+aNgab6SG?=
 =?us-ascii?Q?AJZDFYq7Pepb9xfQrS88P19JWEmJDRd7ahhmAmBmTxKZ1nEDpx30jItmsnv3?=
 =?us-ascii?Q?fntCOq2VQFppsUkdPg+AFkr0xTiVX5EkFmovfAF9JDd35yUDWHpwdOjP1mbN?=
 =?us-ascii?Q?nFWJjBI8KhlMUshevKEUeCNZXsGRYSUH3jNfc0Rc+7MNEGjeDB3ty1Gw0eko?=
 =?us-ascii?Q?ad/OXDk4/A5TE5NuIm2MNttYOu0qH33dhiz8b2BTQ68PCPto2nQ8NuKtUuON?=
 =?us-ascii?Q?UmaZmnm4eFShdYlchSz4O+kT8kT0fJG+xdWKx92QFlgBHjNiUFGDxwInZxJo?=
 =?us-ascii?Q?ixnyieg4kcwvqUyMlcXMP+0S/iucrHdudcHvXLVmOZQEXe3vDQFi+aBeVCZl?=
 =?us-ascii?Q?PeiWatlswy23qHHIqciJfOw9SCjRucPB7npl1QaLWCgDDtBOEJsVuEk75gl/?=
 =?us-ascii?Q?Ou8VNSahF1xjRux8qPL9AjjC59W6gO5GjZmeOpGkoChzHrd3CYNY/BgqxZxj?=
 =?us-ascii?Q?qLvqamxc/pu8l5VdHsT4pevHAlT8O4tzuTlP6V9Y8DT1Rl6i/onS7gVsZDU5?=
 =?us-ascii?Q?zc3fh2oWC4f5ezwGP0FAE5zCjm+kEod1m7JwCLuCmuzL8YF+D5rWRGJEOaja?=
 =?us-ascii?Q?m0jnlZ9UyakHtjR+vJWwNyMgUxFABToNtBpQtsWnfGgTbB6SuCJHSXYvOKQZ?=
 =?us-ascii?Q?CUnrO8XIQAeO9o//4YIQWmJJ4FqWpuz/VHV6N9Iu/lHXSsUcmvYU7rLQj39t?=
 =?us-ascii?Q?bF9Nt0wNWMhK+RKUMRSSuhaoej1A9iFmG9IsfRQvf+Cr4yk9jBwYjPLloftV?=
 =?us-ascii?Q?8EPiQ0NahpVTbdQQLsGMttQz21wzJuKR6jfb/ELIMNNZOXvMYhsRXhFYmXHR?=
 =?us-ascii?Q?zghMe7lGj5DomP9IKabzrsGXA5e+3y7jcVcK++MlwS4gjf5zGdrkFMkf0hOT?=
 =?us-ascii?Q?+JRQ7ds8MKEJORCpauoNQlqAfzjGQisEzfaFflOGxv3eSjN6lkkzboKVcIqv?=
 =?us-ascii?Q?LWrdw4Rujn7ybXWIb0N0AhK+/bYztXhHEzRqQ0d/Iish5jlOmuQ2Mo+WDgTs?=
 =?us-ascii?Q?Ses2BaUS/3coTdt25HD/jYqi5aM/+/0qXBkAo0ZblN9yZTZTQWf7h3EgDJkk?=
 =?us-ascii?Q?XyoMFmSxQiQff3bx7wBf+IGF6X6RROOi731JwfBBlgfzqN27eqPKlBu+zFMp?=
 =?us-ascii?Q?WPUhDuxlfrCtZ+xjteQs49I7Qp9PxXSk7bx+/l5rAlxoTT/1kEa+o53Uzx6U?=
 =?us-ascii?Q?upD8rV0InrE+A9Jei3joXkCmOSdRfWyKyhAwXFB44t5udPOEE2lat01hSTrw?=
 =?us-ascii?Q?glyGBnxMABOI1nzC+5un/4xhqEPBKnHwTT5WTmb2svMVx+NGe7vqOfYgopbA?=
 =?us-ascii?Q?rb+TNTwXHpFfu5JuS5+MQAuAZ7zVzTk4SjBF/KoWSUPYvfLdhNdMW/Y1mAQn?=
 =?us-ascii?Q?/DyTna3+AldawWmUDT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7d7155-e405-4140-7bd2-08dcbe29e9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 19:30:40.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZeehRmb3XXg3SD9eNELbC+gUUzPhEet3IcxKt6zda594s3t2cPM7lYw0BoC9+vq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

[Public]

Wiil update commit message as:

-------------
drm/amd/display: Fix MST DSC lightup

[Why]
Secondary monitor does not come up due to MST DSC bw calculation regression=
.

[How]
Fix bug in try_disable_dsc()

Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation Regression")

Cc: mario.limonciello@amd.com
Cc: alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Reported-by: jirislaby@kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3495
Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1228093
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


> -----Original Message-----
> From: Roman.Li@amd.com <Roman.Li@amd.com>
> Sent: Thursday, August 15, 2024 6:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman
> <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Gutierrez,
> Agustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>;
> Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Zuo, Jerry
> <Jerry.Zuo@amd.com>
> Subject: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
>
> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
>
> A typo is fixed for "drm/amd/display: Fix MST BW calculation Regression"
>
> Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation
> Regression")
>
> Reviewed-by: Roman Li <roman.li@amd.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 958fad0d5307..5e08ca700c3f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1066,7 +1066,7 @@ static int try_disable_dsc(struct drm_atomic_state
> *state,
>                       vars[next_index].dsc_enabled =3D false;
>                       vars[next_index].bpp_x16 =3D 0;
>               } else {
> -                     vars[next_index].pbn =3D
> kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps,
> fec_overhead_multiplier_x1000);
> +                     vars[next_index].pbn =3D
> kbps_to_peak_pbn(params[next_index].bw_range.max_kbps,
> fec_overhead_multiplier_x1000);
>                       ret =3D drm_dp_atomic_find_time_slots(state,
>
> params[next_index].port->mgr,
>
> params[next_index].port,
> --
> 2.34.1

