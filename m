Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77D1C4452D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 07:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2E310EC9E;
	Wed, 22 Jul 2026 07:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuUeHrL8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD6D10EC9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 07:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifDexAT2PML7fp8z/uuQEuO2k+1ScAYgrOmM7rZlSVuIZmOb8cSHyLidwOgiKiAzI1ixZk/OlPa71DGd1UTeB79NWE2j+AU59D1z1cfVIB3lm8Vx/MxLYIgmvV2vUVJ2UB02vHHhNH3/W7f7KG9kZg2PoBgClhl4ebwsyCcOKDyIGrdnKG4ZOIhrVlDRHcCAlzKaTIypUVqXFqyLDg376o4KA3nJT17mbtwTLchiK7+vYyjPXPv1TOs46BkekjbdD97YUbZMjv11WgcTNGh79kKARero0jN5tZjCR+o1o38XP41mSnEIvsrMFUJojKLMe5Qr7Tct1abuPjgGXGBMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2JfQ9ArVwTqJ1YMKpFCtOeTdMeoTzIyVM1Ai4ocDG8=;
 b=wlFUMG/yiB1qwoZIGcZNetg/cGpAQJMSddZ2+vPRzjqZOyLXMS0jL5FS0c27KaSn1Et99IlHMKtjCYhlvPUsZTLFNjeTgFwHJqaLPszco+UFC3XHWETRXZjOGt6ylFoI1IBATiHkojDjuSPxMl0/frJyY0t4TZcJjbHTDOPjyMHtBxLjekJ+xah5jVv2Q813Bb7pV4ERVicMgDyyr2owpOZAIvdK6BffRyZCJTbIg6Az8IVJQLMCwH9160CeoP0Jl9Bh+nAYh+7UbTSv1PllHlH2+IJg93agPTGv8v32HAaBtOrU7CiFUlaO7ibrATmJ5r1F8CndRPPfIuDkwezqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2JfQ9ArVwTqJ1YMKpFCtOeTdMeoTzIyVM1Ai4ocDG8=;
 b=ZuUeHrL8GhODpFiZ03JoFAe/7qM5B09J2c17d1udTju1YsWra4Xpvmk2P/ZF/fjkqpvtiqncSidjvBVXhWqMFYn0ZyiEnYW5Fc9wArtTn+tXTNNw/i8PR55qj/ulvTZvJ0cXXO1opFOgReonR40oigHBi3ZRZCwbphDRXdt+7Nw=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:27:15 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:27:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amd/pm: Fix warning about helper function use
Thread-Topic: [PATCH] drm/amd/pm: Fix warning about helper function use
Thread-Index: AQHdGacx3DvOov2XzUedkOE6/JvJR7Z5HVqw
Date: Wed, 22 Jul 2026 07:27:14 +0000
Message-ID: <BN9PR12MB5211A0F3EA479CF09F27A70C82C12@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260722065549.425085-1-lijo.lazar@amd.com>
In-Reply-To: <20260722065549.425085-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T07:04:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|IA0PPFC855560D7:EE_
x-ms-office365-filtering-correlation-id: 5ba7bf83-2288-43f3-54c8-08dee7c2a73d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|38070700021|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8q3rt1bP58msi5DQdIUpOUwwvGzGioFp/c0JdAj9A9H4t6u62HGZx/O7KkzDru4DScXqrlTMkh0eHNnWnNUvI4fS1mRUOBqqVwK/bwDiYZI2Qi4t9jZF/NyLqcJDcScHLqMW9Pv1VL3HRru4yQbWreJwKOjmOxuY8egl6Xv0X6ObkcpLXujAKRqz1v75EBwCYoGUurHuDI+5hjDp6EkptRqsfNWu3790hLvqsBm1A1LxkDUY/ImMrtG2N8D10qNFf1Jachjdrhp6Gy9Nz3ylBwlLijrcnqiS1rM2gVNB9rwZT9XOcWYZ1CDvS0PH/r4ySHlsNIbGU24fqXDTsUfdec8FShSSkFZWwIuQNc0z5H+l+oWQVmSXV68eppLJTaZdftjLNo6bpAHwpylj7sIiair1I9vy4lyklhq7pFtObLh6C3kmWudxkVaK/mx00Qgtf1o0sjlj/VcMBUJnhRCRd6LQnEzV2BRrI9rhYNervW5x754BOHWPLHmMrq9d3ooWtIrBQL28WXKLUkNcf7ti/49vK8134oc2wx6zX66j4MZQkb5Wnv3WsHdw36uThYI8/3A82NUl1rY1pZeV/QX8EufBn/D5fN0VP7HtYwQh6MOtp1Tog8zqpVPDMNqRYK2+pU66RDYkByREJui8h4Csete4pX6cLvhz1w5fWSCv1kAJCJgHEUUOLdisk8m35E4htG7hlvFJLaMuM3HGqe/mlVk1VehrJtyA2PTNcxpfECU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(38070700021)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D3ZPLeYLSF+STEM0FzUEhKloq7ISSC/+uARW61ci0GINjrXQfl82vv9OWGZK?=
 =?us-ascii?Q?QaQWUZJ/k0LJbY4BQ/Ex1iKJncnSBiwkIsOkQYCBkLJjoIbcyx0FW4hPRBvF?=
 =?us-ascii?Q?Xnliu52PqE6dkFMMnLkd3BZb1m5lpVrGv0qZdvdfym6ATOwZtk8cUc433tkj?=
 =?us-ascii?Q?EiSub93rl/B0YnRhZEMr/Tuy+iK03UrBmENiX6ZYR8upMQg5Yf2yAhkOpjDK?=
 =?us-ascii?Q?gMul/k/5T2FeQVJOV18hmavDNwjgevJoPxdkFVXnklk+4Aqy8lnuJv9VHnd+?=
 =?us-ascii?Q?b38SRPWiyGmnFArDWmdOcx1DAi4YAg29FFifUKcENcyeW+j8spb2kWO357SY?=
 =?us-ascii?Q?zb61AEo9+DlLgHRXk7IfZEH30wLzc8baO/PDcLTD4T/0ZYYrl3/aFsslMER6?=
 =?us-ascii?Q?bD4rimxegVqf2LU5x389pEC5ccgw3j3D+hzQRkivr5nhd/d0h1FIa35EHQDx?=
 =?us-ascii?Q?0qdO5ZhretEzYHg7tBokB3zfmdcx69JsLixCWvH19/Mie8BItIsOfF51jis0?=
 =?us-ascii?Q?4NwzV8ojgbbm4jYopiMUbHQRMxsHL7k1ebyMs2Iuo5VLmR2wKY1zF6XmX1m5?=
 =?us-ascii?Q?+b3doJoJ4RECUCGKGLNruF1Q9VJz6QjMiQNVV0V8xb/iqNT0HW7eo9xZKi+a?=
 =?us-ascii?Q?Upp2q02IA7whlU9TWiTwcOGr9Ql8ZD4mbc/HS2aPDq8oXLxvFvO32OsH2DY0?=
 =?us-ascii?Q?EL5hapHBpb/yRDUbF+rm5kpA+ltF6mwfGNSHQLFH8iETU3stJBpfd8FvBMZ6?=
 =?us-ascii?Q?8bekxokU5nEzeqNbvFdVrHt2EmCdQmd5LLHIjO/bU3XpX8/NqLE5LI9bUfYt?=
 =?us-ascii?Q?BsbtcdqSrJwLfSEol28VBxpvvaxMk8jZNOkpSaeMKHOMvdh/4hscJC5scTGV?=
 =?us-ascii?Q?L9FBbBs2py3JMOmiiN+cCrkouj2fkdGGt2ibJa3EX0p2x3hypuW9n16kJPtM?=
 =?us-ascii?Q?VIe4qdrKBMKUL/bLUsseQ10up5JaPqlIMd3K3JvtlkwPhvWvdOZkn4YIerGu?=
 =?us-ascii?Q?/NBVbLF8Id78MtvjqpRFYTR/atLzGMeul0+6o6rBIIaTWHwVApkgXxVar4dB?=
 =?us-ascii?Q?HpFg35I0IeMdxn4qXrLU0u58ivavxScfhvwhzwteZogc+hmP5UO0t2aoCthP?=
 =?us-ascii?Q?H0yL43gUduLS7VZwCpTr9M+rTQltXWYVVB/fHm0qvcSsyiX5X1ZkYSo8UgXP?=
 =?us-ascii?Q?fH3dFZU7XBu19fSNneW9+ADKf+FK9rQSO7GLSgz7exT5fIHxiGEfeQ2gWhYs?=
 =?us-ascii?Q?Kg9djf15AJhfK4rs6xejUoZlHf1RKUCFz6hbvJwrh5X+O7rEBNtG4PxkU5TB?=
 =?us-ascii?Q?Aa730MTO47P5jYBDYBUHxdurA/dcDhNcHl8l07V8hqhLVztzT1ec1oTwg7J7?=
 =?us-ascii?Q?nG5i6/SMEUlGBmViN8Dg0aZNaRRtY2EwHpYX/p6qdfrQyJBW1Ga25nahDHQ/?=
 =?us-ascii?Q?IEiPQgl7P55C6cd2f1fDvezsssJRkYCxbUAC+M4abDTGpPliafwliQXsBmDw?=
 =?us-ascii?Q?cecuXCWmRmwP0XsRLcUnXkuL2rGOgbh9EcYMGlmISJjmiOZLU2JmlichvhFa?=
 =?us-ascii?Q?+/bPkxRCnzCcveu93S8xeU7MvD2YwNjfjdmtnJQ1ELia4xrD2o8Ej6u3g/sw?=
 =?us-ascii?Q?O3kv2UyDASFagKbe/Co/jWWKVQnbv8UcPS6q3VlAJvnM5vF8LNcYVBQUILC9?=
 =?us-ascii?Q?vic3DgLFXL5/E0NwZ6rGv77sK+N3KixfeiRkG/zzw5Ye2FFU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba7bf83-2288-43f3-54c8-08dee7c2a73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 07:27:14.8373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qhjESyJ6EwAIjl0LiNnH61WRfjzcMoT4zYO9dwl8gm4zmHQV5ulvOt9fkK/m0RW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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

> Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
I suggest removing this line and refine the patch title.

The tag "Fixes" is used to indicate that a patch should be cherry-picked to=
 the stable kernel branch as a bugfix.
In this case, this is only a suggestion rather than a bug. No related issue=
 was introduced in the original patch.

Ref:
static inline const char *str_enabled_disabled(bool v)
{
        return v ? "enabled" : "disabled";
}

With that fixed, this patch is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, July 22, 2026 14:56
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] drm/amd/pm: Fix warning about helper function use
>
> Use str_enabled_disabled to fix below warning
> drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c:920:3-56: opportunity for
> str_enabled_disabled(smu_feature_bits_is_set ( & feature_mask , feature_i=
ndex ))
>
> Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607210737.OeGpY3kI-lkp@i=
ntel.com/
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 2bd3ea17e789..764f943df5a8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -965,9 +965,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context
> *smu,
>                       buf, size, "%02d. %-20s (%2d) : %s\n", count++,
>                       smu_get_feature_name(smu, sort_feature[feature_inde=
x]),
>                       feature_index,
> -                     smu_feature_bits_is_set(&feature_mask, feature_inde=
x) ?
> -                             "enabled" :
> -                             "disabled");
> +                     str_enabled_disabled(smu_feature_bits_is_set(
> +                             &feature_mask, feature_index)));
>       }
>
>       return size;
> --
> 2.49.0

