Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9FCC25B10
	for <amd-gfx@archiver.kernel.org>; Sat, 11 May 2024 00:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FB310E4B9;
	Sat, 11 May 2024 00:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E0iUgUy1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB5610E4B9
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 May 2024 00:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCxn/AKbbKl3ukvxv+2I8Jzpv9/duLsda3T9/5/GQhQJArfE8PchwXA9IA6iFyysF3l8x/zloWigpB+GxbLngSZ90oQbcspl28ThQM06F0M6grWT1UHsNNeOhYcTWMjWbFUYHdVsPUd0cHre/VWMvWJZTYNCubfYTL/+K4lkSTSv061Sz1+o3y7Owz3zZ2BRHat2WFv4Ca0hKo0/+4FsP51/oRiQ89/QNkMPaqqju98sfmMIHEcYvzBDrbxQ8ZKmaJHeTnd3TuNsk0kT5TQdYaFbjbYkab52ivkHq4/+ourrLR7MStK7AbrM91ZHsmRurPH2tNAGsvSa5MSe6I5yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE0N1/FXDE25FFGv/qWfIDMilnebbVLujrFli3bC/ys=;
 b=FJn93Fzwdyl90KYgFCRHTwnxa51oUBkOZZ8SqFfLvs4c6hL4DNh5XXeOWIwB9O8HJFOLVV4PwR2Qa/z4q4nGEBzReKfFc2albHptw+TPc3mY94FjKrhIZNLeshbnGx5N5xDoZropj5HcK6E+SdidjkUp0N1JKG2BwvNrGwTr35vNWFi5dVtq48aLGVLxktLVWaa7B4CBO7ADtbG2F/6ReaU2uGC9RgprkREF/D1QqttyY+DnyRr7+nz9qwF84UjL5ihsLP0sTGwzu0YNR4FON9Q2dhduoff1cTT9ezmemnuj5km8MSeSU1NPlLT3YLUetnaVIShoiDIZAV0rblqn/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE0N1/FXDE25FFGv/qWfIDMilnebbVLujrFli3bC/ys=;
 b=E0iUgUy14yUW0oE8u8deI/Ic417WLAFJlzxQJkyDysc6bxwaJX/DkeKY/N7fTFQs42dZspyBl5vD9g61JUmBf+SjqtWzCN56Jvbg7NhQoK2oPUllZdhGMzZNG6xHZlmn2zVEJvnggqilO48iqd6FBaYuuVe10tUu1ohB4HJM1z4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Sat, 11 May
 2024 00:25:16 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Sat, 11 May 2024
 00:25:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ma, Jun" <Jun.Ma2@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: Fix the null pointer dereference in
 apply_state_adjust_rules
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: Fix the null pointer dereference in
 apply_state_adjust_rules
Thread-Index: AQHaor5cOL56NEF1ikiJrDgaNM20Z7GRLXUv
Date: Sat, 11 May 2024 00:25:16 +0000
Message-ID: <PH7PR12MB5997EB244DBEE0A21F656A0382E02@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240510094117.493726-1-Jun.Ma2@amd.com>
 <20240510094117.493726-3-Jun.Ma2@amd.com>
In-Reply-To: <20240510094117.493726-3-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-11T00:23:40.1688093Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7196:EE_
x-ms-office365-filtering-correlation-id: 639dfae4-b5c8-4f09-0772-08dc7150d4d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?aB3gIpAxEjBuJ/O1yipj3z3tfjyblJio6wU9kdES87L6Rqv8hQWYM9AKS6Dc?=
 =?us-ascii?Q?Iz8Zhd+MDu3Un3zFq42exM5j9GbLkSjsYoEkDzuSNSzejmF0D2+duWy7oAq7?=
 =?us-ascii?Q?P104OtRR76Gt5NKRNZUlpT/ahvHnbfjBMIpoksHvFwSIV6NeBC/B4eiS8iwo?=
 =?us-ascii?Q?/E2In8xhcjGPCOFC8OUvbLNKgqcQ/vkW9aViWToysWHqY59Bs/NPsKhBX9V5?=
 =?us-ascii?Q?PMVm5qGRQo06TW3gWJrfk0nt4m+Xs3/6xgjiQNUoRqVVRpB/5b9uFfWzmx18?=
 =?us-ascii?Q?hZkfxxtNhUBNDzn9s1MYmXWYReT1EqSnfxgDg0Rgo3AbNpbJwKVJydTageu7?=
 =?us-ascii?Q?FmawyuGTxJr7gwYXOXxRxZdRFoD+GCHSplVKB/nnhbCgbg+KgQVCjDuneBCE?=
 =?us-ascii?Q?EaI1Wn7gWHBvUK3K2oDESQ/dndUpkphixxVUDRB+ag2oKx4MExsc4I2eRRco?=
 =?us-ascii?Q?N655okZTsKnxJcob6yKPuhlnZ/044nPetmk2uZt3i1oc32Un7hftXL+Gz7PD?=
 =?us-ascii?Q?TVtlbOZo7HbVVs9sxiJLLZ9r4PHS9MB70QbcbTERc+yd/EqxDCZWIlesleQX?=
 =?us-ascii?Q?wQFaSjtkti0kesZ3MKgiHZvcc6l8ZuDqY3hej7mWA5llJfuzvIK7g8c8BgU3?=
 =?us-ascii?Q?HXsbwfR1GX1OLLwSJNsKatYmc6fiTnb5OGGzqLaEXvY0pYFz9YT3xo0+AbhC?=
 =?us-ascii?Q?TffalK/dlQo+Wb9p1ZoVEKKF8HNRNSEwLKLDf4jAI5b3c5AgHiAlxZ5GyTxY?=
 =?us-ascii?Q?2E4hbt4tRpfXsjhHOkwgz+vabDsfeKNZ4/dBdEyJ3E5kPBSZe6ZPceUi5i2V?=
 =?us-ascii?Q?uZH4mi9ZDDlL/EYIyOiweICmPJpGxunqy9rUJtoPjZqMn4CQY4TwIv6TPkTl?=
 =?us-ascii?Q?8qMuAHYSYbrxS6RtBh57wwWz93ElMl4AJyUhQyxFsB/VDYaAbSTrBD8tMg3t?=
 =?us-ascii?Q?kccbAHGKyhe/ddlBHgYQSwOWzFGAddjIHvjTTUmnTknYRCToxOUixwoJXYxN?=
 =?us-ascii?Q?U54alywGCKpj5B66pQxreOExIO7Vb78bTXNch5SN38A3LWelpqdPSfb4Kn9V?=
 =?us-ascii?Q?sIVQQFbnBcBe5y2GoLU8BDW5mag4VhdK2vMM2ADddm6mW2pk2soGvtma/apL?=
 =?us-ascii?Q?dlgGd0/DSbXk0hWSLhOINPtrl4HVwmNcjdMD5VzAGZ7IOEpPfFRdwizKpNma?=
 =?us-ascii?Q?zXEcN5aFnSTJqaMOZp4Z6/1viKw3FSL7ao6TWkU4b9uN58VlA4zDHFD7iuzh?=
 =?us-ascii?Q?5IwOLteRb9uvHxLeGfDesoU2z/5cTiEmNjTnDBDGmwDmlVZe3TudNxRtyML1?=
 =?us-ascii?Q?7aImIG3L+4AzlZ2b5Tbh/nul7Enokq6SR9d7gO8LwZAviQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4sxf9oKzU5zTqxUvJvh9LDKPq6qobdOxiUciWcZmdYmkiVrSjkcFmtxAo2b?=
 =?us-ascii?Q?niaq3BA7fPYS/7y9mDc38jLs/qLi/sYLmEurVCWVHJs4ZjPmTV1tlJX5wPRc?=
 =?us-ascii?Q?oSduDEFMixRoplynXIMKXbuwKqaYA1TiGDqYoegiDW/jg7ScE9MAbH5rmPD7?=
 =?us-ascii?Q?og9YD3qeMbsxW6cWdsypPFFa6z0UMbxO1yMDUf02VKvR8QHXmLlFhQkH9/tZ?=
 =?us-ascii?Q?EDXQo28pZj6XT5U9AqmU5oJG8S9b59DatzZDK3l0n20h3LgX5P5QhCOLm+ZH?=
 =?us-ascii?Q?CCiQL5pAB5DrGO8YOzMjZQUGyBTmrxCVRvfIWE6UFfbCFIoWZDF6amTwq1rX?=
 =?us-ascii?Q?ocvbuYBo+f+q2lRNBnixMRXyh9UTOqlLQQtpSaqqQu+06K1OGZGqAVTYIiuR?=
 =?us-ascii?Q?yv1sE3UiHwJZ3oKjZQ79zi00pX+EAvUkP5TwHS3wnid/0IiXLCCvubR/F+9v?=
 =?us-ascii?Q?37ns8v2e+TscHVMTyJqorNXLzO1Iz4nM1YbO+H9yS+cbkc4Su7nGOUK5VqnC?=
 =?us-ascii?Q?6F2EhN6CzCnOWktnwpCXid/5LFdIaWMkN4NyVlQNhOjcw2x7sylb0b9wV4PH?=
 =?us-ascii?Q?5A5rVXVIrLRD59p+Z3h+G4Wm2heC8Q9bCjtJNIVLAKOumerY+RvWo86WW5cd?=
 =?us-ascii?Q?7K84o9IQuXSZCwpkV3R5esPT9mMPmR06ofCBj/kVSU+ZU6hbU35+l66RsHOs?=
 =?us-ascii?Q?r+YvKiOlNSlNMTIKQ7oLQnFIxlQ4d103XM5CZ6e9Eh5wINd6UnPvVu+CFjC5?=
 =?us-ascii?Q?Mn7dwUs5UtXjKN0B3XllFIJP64TlNT2bnTOB7S1mIYzXpGUh2wouAa1TtGiP?=
 =?us-ascii?Q?lcwARHWJCnsW3INg/L+SkVmhMGQkLifUe3qyGDhq893jKw3+x5QSAPdd9OAk?=
 =?us-ascii?Q?IgxxF+E+QRUIsC+zbSc60VydgjVd+Eyc4L/55dgvcBv4yDyGhSG6LB2Zh+o0?=
 =?us-ascii?Q?DSlFkNbkk9r6Kqum5jEiqnZk2HLpbwJfMbkL5fgnUA5Ha29Tv8ySFo8aJtHu?=
 =?us-ascii?Q?I6+eVgHzc0ehHcQjhDr6wrFTrRHhlUnklJprgABCI+1z0JTWsQRDrRkXezGZ?=
 =?us-ascii?Q?2hmCFi6JEKkoHvE19ryT2tHP3R11T+pdux3jUeJxSiTrD/XRVzLx7sUUCdJj?=
 =?us-ascii?Q?4r60rYFGYKIL3WrmP8efvqPzROBvbYkrmzfrOGO50j9rSkTrErC+o6IlaFiG?=
 =?us-ascii?Q?NxsrI1yyWkrothW1TLfpUEsGzdfhTUMzfnVMcIf6/F+0vSXLUZVwnSZiD/CR?=
 =?us-ascii?Q?u8SNtoZEGuw60mo13sX8AyybvI6RpFe53LhJpGkASGrVHJvpTFIb8Ksl1Kvq?=
 =?us-ascii?Q?4pMNVW6FnZ5iMjQaoLWXjxB3P/ylyJcR6wtzG6k5CuGcxZ8rcmXGi/v5JYNh?=
 =?us-ascii?Q?OtXv3QKy0KTsHsQwzasqR59a2//nFx5tIr/vuAGHn0dFIFNoPJkf1Ls1D5yY?=
 =?us-ascii?Q?zx4ODDYO0KLdN10z6N1HhQLw5h6vK0lXbPpx/uGnfDLqe6Z9a0AZtmMYDVKM?=
 =?us-ascii?Q?oxM8VjhrI+Dg/+nxgveBVjbEILN8bf/ZUelAiOhUHuCnwg4tHlbYjixEqq1N?=
 =?us-ascii?Q?cYr4zugD8N8A34yNzM6LgY2uKX0dVIlRzzq3anmpP+u0srF+13iuuqyfiebR?=
 =?us-ascii?Q?A5cSmXCWXLjBLRJiAdhUu1bgk348UD1eLCJC8isw9I0X?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997EB244DBEE0A21F656A0382E02PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639dfae4-b5c8-4f09-0772-08dc7150d4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 00:25:16.1242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhK0Mnl5cp++DK/7mn16OZVoP9hBEasFgJuAU2WWRAYbYnPPEUB8uSwzFLjvD5NO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

--_000_PH7PR12MB5997EB244DBEE0A21F656A0382E02PH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is

Acked-by: Yang Wang<kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Friday, May 10, 2024 17:42
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: Fix the null pointer dereference in app=
ly_state_adjust_rules

Check the pointer value to fix potential null pointer
dereference

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  7 +++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 14 ++++++++------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  7 +++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9301e65ff13c..632a25957477 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3314,8 +3314,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hw=
mgr *hwmgr,
                         const struct pp_power_state *current_ps)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;
-       struct smu7_power_state *smu7_ps =3D
-                               cast_phw_smu7_power_state(&request_ps->hard=
ware);
+       struct smu7_power_state *smu7_ps;
         uint32_t sclk;
         uint32_t mclk;
         struct PP_Clocks minimum_clocks =3D {0};
@@ -3332,6 +3331,10 @@ static int smu7_apply_state_adjust_rules(struct pp_h=
wmgr *hwmgr,
         uint32_t latency;
         bool latency_allowed =3D false;

+       smu7_ps =3D cast_phw_smu7_power_state(&request_ps->hardware);
+       if (!smu7_ps)
+               return -EINVAL;
+
         data->battery_state =3D (PP_StateUILabel_Battery =3D=3D
                         request_ps->classification.ui_label);
         data->mclk_ignore_signal =3D false;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b858cc2a5c9e..7e1197420873 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1074,16 +1074,18 @@ static int smu8_apply_state_adjust_rules(struct pp_=
hwmgr *hwmgr,
                                 struct pp_power_state  *prequest_ps,
                         const struct pp_power_state *pcurrent_ps)
 {
-       struct smu8_power_state *smu8_ps =3D
-                               cast_smu8_power_state(&prequest_ps->hardwar=
e);
-
-       const struct smu8_power_state *smu8_current_ps =3D
-                               cast_const_smu8_power_state(&pcurrent_ps->h=
ardware);
-
+       struct smu8_power_state *smu8_ps;
+       const struct smu8_power_state *smu8_current_ps;
         struct smu8_hwmgr *data =3D hwmgr->backend;
         struct PP_Clocks clocks =3D {0, 0, 0, 0};
         bool force_high;

+       smu8_ps =3D cast_smu8_power_state(&prequest_ps->hardware);
+       smu8_current_ps =3D cast_const_smu8_power_state(&pcurrent_ps->hardw=
are);
+
+       if (!smu8_ps || !smu8_current_ps)
+               return -EINVAL;
+
         smu8_ps->need_dfs_bypass =3D true;

         data->battery_state =3D (PP_StateUILabel_Battery =3D=3D prequest_p=
s->classification.ui_label);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 3b461c07344b..6524d99e5cab 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3280,8 +3280,7 @@ static int vega10_apply_state_adjust_rules(struct pp_=
hwmgr *hwmgr,
                         const struct pp_power_state *current_ps)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;
-       struct vega10_power_state *vega10_ps =3D
-                               cast_phw_vega10_power_state(&request_ps->ha=
rdware);
+       struct vega10_power_state *vega10_ps;
         uint32_t sclk;
         uint32_t mclk;
         struct PP_Clocks minimum_clocks =3D {0};
@@ -3299,6 +3298,10 @@ static int vega10_apply_state_adjust_rules(struct pp=
_hwmgr *hwmgr,
         uint32_t stable_pstate_sclk =3D 0, stable_pstate_mclk =3D 0;
         uint32_t latency;

+       vega10_ps =3D cast_phw_vega10_power_state(&request_ps->hardware);
+       if (!vega10_ps)
+               return -EINVAL;
+
         data->battery_state =3D (PP_StateUILabel_Battery =3D=3D
                         request_ps->classification.ui_label);

--
2.34.1


--_000_PH7PR12MB5997EB244DBEE0A21F656A0382E02PH7PR12MB5997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Series is</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Acked-by: Yang Wang&lt;kevinyang.wang@amd.com&gt;</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin&nbsp;</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;<br>
<b>Sent:</b> Friday, May 10, 2024 17:42<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.=
com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Ma, Jun &lt;Ju=
n.Ma2@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu/pm: Fix the null pointer dereference=
 in apply_state_adjust_rules
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Check the pointer value to fix potential null poin=
ter<br>
dereference<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 7 +++++--<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c&nbsp;&nbsp;&nbsp; | 1=
4 ++++++++------<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c&nbsp; |&nbsp; 7 +++=
++--<br>
&nbsp;3 files changed, 18 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
index 9301e65ff13c..632a25957477 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3314,8 +3314,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 struct pp_power_state *current_ps)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_power_state *smu7_ps =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_phw_smu7_power_state(&amp;request_ps-&=
gt;hardware);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_power_state *smu7_ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks minimum_c=
locks =3D {0};<br>
@@ -3332,6 +3331,10 @@ static int smu7_apply_state_adjust_rules(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t latency;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool latency_allowed =3D f=
alse;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_ps =3D cast_phw_smu7_power_state=
(&amp;request_ps-&gt;hardware);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu7_ps)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;battery_state =3D=
 (PP_StateUILabel_Battery =3D=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reque=
st_ps-&gt;classification.ui_label);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;mclk_ignore_signa=
l =3D false;<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c<br>
index b858cc2a5c9e..7e1197420873 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c<br>
@@ -1074,16 +1074,18 @@ static int smu8_apply_state_adjust_rules(struct pp_=
hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state&nbsp; *pre=
quest_ps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 struct pp_power_state *pcurrent_ps)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu8_power_state *smu8_ps =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_smu8_power_state(&amp;prequest_ps-&gt;=
hardware);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smu8_power_state *smu8_c=
urrent_ps =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_const_smu8_power_state(&amp;pcurrent_p=
s-&gt;hardware);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu8_power_state *smu8_ps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smu8_power_state *smu8_c=
urrent_ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu8_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks clocks =
=3D {0, 0, 0, 0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool force_high;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_ps =3D cast_smu8_power_state(&am=
p;prequest_ps-&gt;hardware);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_current_ps =3D cast_const_smu8_p=
ower_state(&amp;pcurrent_ps-&gt;hardware);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu8_ps || !smu8_current_ps)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_ps-&gt;need_dfs_bypas=
s =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;battery_state =3D=
 (PP_StateUILabel_Battery =3D=3D prequest_ps-&gt;classification.ui_label);<=
br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
index 3b461c07344b..6524d99e5cab 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3280,8 +3280,7 @@ static int vega10_apply_state_adjust_rules(struct pp_=
hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 struct pp_power_state *current_ps)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_power_state *vega10_ps =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_phw_vega10_power_state(&amp;request_ps=
-&gt;hardware);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_power_state *vega10_ps;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks minimum_c=
locks =3D {0};<br>
@@ -3299,6 +3298,10 @@ static int vega10_apply_state_adjust_rules(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t stable_pstate_scl=
k =3D 0, stable_pstate_mclk =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t latency;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ps =3D cast_phw_vega10_power_s=
tate(&amp;request_ps-&gt;hardware);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vega10_ps)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;battery_state =3D=
 (PP_StateUILabel_Battery =3D=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reque=
st_ps-&gt;classification.ui_label);<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB5997EB244DBEE0A21F656A0382E02PH7PR12MB5997namp_--
