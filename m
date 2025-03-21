Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388BEC36001
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 14:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAB710E13A;
	Fri, 21 Mar 2025 14:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZ30F/nl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D9710E13A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 14:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UieIHfCowWu5+kzT0brWsAKUa7yBoU10wY0igzwI3N3cPYMT2WNwZR7WkYNUo4WHSY5ZjzzfKsLmMYp4OGA+Pk0ddtk1yS7mgHIkp8TNst/H4XlpwF3nAxlQxhF6tq4RGRCMUgruxC2UIBh/SLdzb/m9h/YoAHKllIjRi2/rCkXdIlKcsnWPaf50WPt85Po5cgWh+3xRRTDJN6yLRTlFdtq2Zz2UiSZ/MCHcLGG7aZPH8zUsk1/jSgB6EmGEkhLB8fMMukRT2AphShheBKbD4fiVVUwt8VaDM5BhmIlaCBMmzz/x70/dQQ6DCWnJ1uEaWyGnAvi+vXR3sY2wjJeQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajczqj9/A/PEM0aza/OASHIwOMwzW3ojqgJRrmR3wlA=;
 b=ViqTVRhTmMrvMt8+K2/Yi73zR23GFehzsU5taTV/jaNzljfFVl/l7YucMHxm+6MJ2PiTBnqV68mgInUsC0YVCh/TjbsIGasFM1qSd1dMK7gY2eMNMD0BvrDUHdLf9r+KD0D3mbl4DVMkeSFHVpO2uD1H/uAfUACa6UARu2njhbRziTaF+ZSxKhUoofkG6z3E8uxzPJ6DR8HICC3m2DrbxNMxK2szYhSnwMW+yzTxUnqOCMuJo3EGRIW8mdH83P0nGMhL0yt3YKnc3nmt+3jaxy6SifsOhp/giKeAd1PdKqBgGChfjSZD1z4+u1agRcKWAmEnvdmLKmQUQI8KZpC86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajczqj9/A/PEM0aza/OASHIwOMwzW3ojqgJRrmR3wlA=;
 b=VZ30F/nl65nNEqHDvc6opBI8ak9Bxy/6rhvtPOg+xsGaFAy8IyDB81SH2Mn2Mewzpwt9tOhDUAJUnon+VLj9wTTTgc2o+TR8lo8VYBZMi9TzjOTIl5khcRibTtQGgWc9XyMR20k77MriC63DcX7SeoJKNZpD3McTPF6GZAvMFJQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 14:14:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 14:14:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use correct gfx deferred error count
Thread-Topic: [PATCH] drm/amdgpu: Use correct gfx deferred error count
Thread-Index: AQHbmmESOJuwTXgSO02r2+VKolhon7N9oicQ
Date: Fri, 21 Mar 2025 14:14:01 +0000
Message-ID: <BN9PR12MB52573699A7C5FE3B59D8085AFCDB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250321125859.611759-1-xiang.liu@amd.com>
In-Reply-To: <20250321125859.611759-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21c87c6f-11c4-4a9e-80bf-569c166c6f32;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-21T14:13:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB9137:EE_
x-ms-office365-filtering-correlation-id: 87d973f5-eba5-4f68-0d33-08dd6882a138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8JSLrpLF/FaUlzqfSAqr21L+x9rFPfYyf+eQhwRgtEMxJf5CWvn5P9iMPDmo?=
 =?us-ascii?Q?u2QE/jcXq3vhmF1TScyF4iFof0Bf05QTwEUntd2BpcDMk0c8xrYHfMWP33BK?=
 =?us-ascii?Q?Wf58czTVi7qZz/jzCeRI1YhWnzDiw9wDJcHPMCkwKg8dlTGJ/rUu0WjOeHfn?=
 =?us-ascii?Q?E2X/5ZKakbvtiXhg5MYuF4uw5Fl7T5QLGb/JhxkipsXsb6F0UJFdrf92mbrc?=
 =?us-ascii?Q?nYBamMlffzP/uL9bufrJHt0y0r0TDyUNOxrxIWiUO4MG+l4N5v2FDXx2cJvk?=
 =?us-ascii?Q?WuZ7G1Eb/Ut7HU29uRo1weInSXQSOV3IzaxstfjLMM3asJC6ZhlUA2b79p4C?=
 =?us-ascii?Q?qjcXZ+HhzZ4BV3TKwb++PbF7bq0EhE/CUJmhwmvuYYJ/h+kyC1EOthOyB14c?=
 =?us-ascii?Q?5hcdSusaNP1nzm3ghwEuJ09J7SSmlzRWKr7kUhyTMpem9HkOoyVtpS4vuBKT?=
 =?us-ascii?Q?wWw4AxzoAHiFnpwQzQtXyOxzC/+sJmqeUIppoihACC58g0iv3bR+VhjCwwob?=
 =?us-ascii?Q?3QiUyGVSMRJLQbUWzpdeFca02AY/oMlSQuSeDvaVPT3pXyFf+6mcFHdGosWr?=
 =?us-ascii?Q?l7cCul6gn8LgwO6jr0CVfGdk6LHvVvxCFfEpqayzOfshlyJKNCd1wmmlXkp2?=
 =?us-ascii?Q?EAj+CH9bvp4oaXkfhLM8fg9z0zDZPaLEPsyDeWazOOO6PCiq82C/DglwqobT?=
 =?us-ascii?Q?K/Yxlr0LwFxoH5AxipuK2rV46UkJS9AeWJuCYQneb8fW8kX+BHlf6NtL6CRC?=
 =?us-ascii?Q?Ji+dnL7XK2AnyIgj4nkKLE4gkd4XtWYb8yx0SRlEEWkdY31wGxcVH0SsnBy9?=
 =?us-ascii?Q?KlAggDCF/FRqBUMctX7zsWxL00F5R8206KT7a3iZpYJTNBtMZBimM91tr81K?=
 =?us-ascii?Q?Sx9tK40WCEqv8361KbRieqG6FH2r6j200B1q2ScR20ZjtCYTyS+DsZ3evgDu?=
 =?us-ascii?Q?P2K29jHf6X6vrFvbru8gghCWA5hllb7MqVQybiJazqh5d8njYH3RPhEHFcAz?=
 =?us-ascii?Q?BVnxapPr7Gmn6JcBoVwu/jJ6hshZH6YgzOvWhWyZxQJvVArZH58B8irOqr4P?=
 =?us-ascii?Q?ef5C+G8lu4r/DZ+tXREtmz7dY3X9rrm0uvR39wITQ3CJ/T5qV4hcEoX+4o2r?=
 =?us-ascii?Q?99REXqAXuKUAsHRT06IzwE3vbJEj4C2+ckZuD0ySbj86njcuIF7maiHY0Dv9?=
 =?us-ascii?Q?BOAKc7lreAmiEQMioYe+Cfy+zz8DbGdM/Ypj2iGmLDZxFP7qKhVpVTd+0Xms?=
 =?us-ascii?Q?M/WgMNh9TEYMfuFWX4Y3Ony886EKS2caSW2ONQ5ckju0E7GeT9m17rSdel5h?=
 =?us-ascii?Q?DwIkTqalOpVrVhdb8NoeWvtBr8Vj5G6KLvesk9k5HqsLnDcoDkZDDlc8u2gt?=
 =?us-ascii?Q?995j+bDKN+Mwjqx9YcDd+I1SaJ0CBBgVorrnUEwCh93L3Y1mPKIZh9rzRedj?=
 =?us-ascii?Q?urbZ7gJepeMzGPGk7rkBGT2t9NsmfBSn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYK+cErssGmfc2K3fDAREcjEBFx7VIsL9ZBKr5QuyK+YMD66s5SZH7oP0/cN?=
 =?us-ascii?Q?9LJ8nuH6/wm9yBBRtIoDcOLnX82w7l57mvFqk0PvRaC8SoOqjGyg34E058fX?=
 =?us-ascii?Q?GO/tPCYL5h0e498Vqxh3+ODMg8YfFcislgEy7yq8NoaJAoVnVzE6pt9Jp7GJ?=
 =?us-ascii?Q?lEwMAVqo7uQifZPZ44DZZdXfC0lBZB7BsKmLIf9ejhuGp77oD6f9ob3Kejxq?=
 =?us-ascii?Q?H/R47KXa/xkXstwODhE03pG8v3KPecJf0xzkYPbuNLQK5BoUdACgEIuz716q?=
 =?us-ascii?Q?YQFobOD9a6Cb2W5QDCz/im2tmhIfXPLMrivn36H7IBtm2Xowen/AEU8pPKrU?=
 =?us-ascii?Q?tMFkMwzyIYKqdsKSSfPKEBWtJBYqBjN37iPOXm78srupigCxV8g5/7v7rHVX?=
 =?us-ascii?Q?ahytrM01C2hV27LmxUutf0cHFxP9qzhcbVlT3NeEkt9FIhioQBe5U0Qlo6km?=
 =?us-ascii?Q?0Vfh0EJ8ur0MRVNtpSuaCVHBQvUYCi1PAreX1xITGCrHjoiBi6rRDYmrVcDi?=
 =?us-ascii?Q?v/hDKrsYS6rLy1RUNWF5NJvFUiaNYVbh3wXI4xWBp8wGd7SUy9tjZ/+GlOFE?=
 =?us-ascii?Q?JqGFrheCRIrlsCyxFH/ymud7QuYhifDTMg/BvUdWccgfwC/h86f6MYawK46C?=
 =?us-ascii?Q?85hHiZ8a7w3ZxZIwsH9jv+0TAxvmLgkmSCtNqyaVXJ6f+hNYT7j0L0Sbn4eN?=
 =?us-ascii?Q?n6H/1mwLjyHYsAkof8rQ2St10x+lh9cVOrEZNQMErxIGYzo2awI57FcCj/eB?=
 =?us-ascii?Q?F7gUYT7vvmQU8BDEdYUN2V8ia4cMvcMDn3LgxI70vapPF5R/olDQ/E1MpydA?=
 =?us-ascii?Q?AlICTa4QHvzE5lWlU2+BZPMyaOAffd/ztEmgzE+q05lyuGVSnZthujPZckBK?=
 =?us-ascii?Q?i3Qa6hMWVrJvKJt5bbYAMHKmdIvUEFnd2WMEuFf49lozo+h6THe+2xy5qmhj?=
 =?us-ascii?Q?h27jTOREf1U8zYErbNgKuWIYsGVz6KpmVbjagpkSYAswLItJ96aDXCB2y6Vn?=
 =?us-ascii?Q?O12RD29ICEKfoshiTpxQ2E+ppfjuboEQSwhDO9mwxv1i/uXrVFuPhRB57RPa?=
 =?us-ascii?Q?Z6x1pNucL0PzC2Dzk0fRF/HzjMfz5Ml0Dnx2/vyFJSvhL6crS8O4xYzTeEE2?=
 =?us-ascii?Q?o4VLLcaJxx3T3u8YUhiyMGMGEJ0V+nQ85qjfmbG6QixDAgNyljk1hS232isR?=
 =?us-ascii?Q?H9saf2E0JJTjQbPtJhvtfCQfOVhWRwpIYZTbRuXQQ1e5I3qldRUvbU2b9OhI?=
 =?us-ascii?Q?3D1Xvj5t8dKi9ZgOniGxwbg3wqZZ6FfgDJPE1aQUvQIYdFMAVKnbz4u2x2Ac?=
 =?us-ascii?Q?BexIfZLjcF7qM79AkWWZIwFLdQnIQDN7RvldI1q0W7IrQFUSqF+PJOL2AtQ/?=
 =?us-ascii?Q?8XOP1c3QAyBT1w4OMWZ5DVY41+3kpT9DmPPqbZ2ZbWF2VUYJvjWrmdbV4IsD?=
 =?us-ascii?Q?qjNII/clO690JqTlcHFbytrZaZwlkThZwJESAgwaXMa+Com7VDBLnG7HAs01?=
 =?us-ascii?Q?046uNib+pYAmy9iSykK3DnJqpswrVUkjJNEqvPQOVStzPwTOUWeyB0fDBi8J?=
 =?us-ascii?Q?ox0RZvpQduPvWkEfCYlWc3/ivg/JcvbyoXkfvWYP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d973f5-eba5-4f68-0d33-08dd6882a138
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 14:14:01.5806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3kO5ATdo357NerZYNLO6/Df1T/Kcuq5/+0NM2s/3nO5kUVdq0sFNOnqZ5AZ0GX6QMimYErj1htm16WBd3DFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, March 21, 2025 20:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Yang, Stanley <Stanley.Yang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Use correct gfx deferred error count

In the case of parsing GFX deferred error from SMU corrected error channel,=
 the error count should be set to 1 instead of parsing from
MISC0 register, which is 0.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index a58e2ce4deb5..e84238336fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -898,9 +898,10 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handl=
e *handle,
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    bank->aca_err_type,
-                                                    ACA_REG__MISC0__ERRCNT=
(misc0));
+               ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
+                       (bank->aca_err_type =3D=3D ACA_ERROR_TYPE_CE) ?
+                               ACA_REG__MISC0__ERRCNT(misc0) :
+                               1);
                break;
        default:
                return -EINVAL;
--
2.34.1

