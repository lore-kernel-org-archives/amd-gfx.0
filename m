Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69B8C54E60
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 02:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4EA10F17C;
	Mon, 18 Mar 2024 02:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3kFozerS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842DD10F17C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 02:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1ZRKOVstPfTIjXq2wvji/CSMBeu00S1562e/sJgCKkqI3YN7Qj6vW7NvR3/v/aHeLLvgjrAyD4s0Kx2IoWO2ayAhvAilZsLrUwg/R3wfKxxm2FQKKK8/KdGyfrCJQNL9cDLiBkpHZl/BE8ESFP5N86yOiPOSNrspIr35zCE6xkVeF33JalKnjeKqaVstmJkmyrNkrBtUsJ6irUw3rmhV+eRo59Fv6s9KgDzCV9XfbWeqvN74/HHLIkqcCreAy1ufQNOPcnOED3j9n2T+6YMFevPPoTOfhZ+ikloouF5w2f/6dd5naRf1OIoBVV9iuhWsGoXIY8xYy4AXNfoSM2APw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge30YVkESFrhDMe+Tc5sSpzu42qqyoZE4LzjI9Jy2R0=;
 b=Q0C35zt35UcmvLBQ3XhZDQDDFR7oXjd77KHJ4Ag8Nn6tiIBC3moR+kNUZAKPK8NOHvinzjYfi7zj4iFivNgh8IDp1HMjKVJjL77CFAkbTk3JlSUUxBmTtX+r7+0FNLPkOukrexK15Q7LyDmk9rBOw+fxmQjPkiXY9c9q1o1zXO6j2oFkhYhFSLLfsVGLAUiXgMZlAIMPVsHKmf6X2vM1gdAU3HgPFZWKrAQsv12NVc3iK8t7KjrVKvGeiT9gWeoUYuExBqtFEkdgSYqVvpbnAIbMexWmHJV/8Xw+kDKc8iGIsTnE4ze/TCSJ4AzfeLQ/QGeqSxyCldpwlXhVevkp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge30YVkESFrhDMe+Tc5sSpzu42qqyoZE4LzjI9Jy2R0=;
 b=3kFozerSuPWSmWDlljhRXvBF+WH/e1zOFmZkjCObGyE/WUPB6BvUIwT+SilBl5dh8Sd3CBdQ36a1CkaMrm1FxK5MrzjFitzc39GEXr051cb7TmUh2QxSFbaUmWod+dBAeVDBbxGh/qcYeZODb5wuyl9aiBpbb8F7XjlbxdL5DRk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:06:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:06:14 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip call ras_late_init if ras is not enabled
Thread-Topic: [PATCH] drm/amdgpu: skip call ras_late_init if ras is not enabled
Thread-Index: AQHaeM73impxrNRlZ0ubB3rAjgWje7E8vfkw
Date: Mon, 18 Mar 2024 02:06:14 +0000
Message-ID: <BN9PR12MB5257F6CCF83DD261E690BD7BFC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240318005503.4173308-1-kevinyang.wang@amd.com>
In-Reply-To: <20240318005503.4173308-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f1b2816-fe57-4b90-9e9e-9223ae9e5f4f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T01:58:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV8PR12MB9420:EE_
x-ms-office365-filtering-correlation-id: 08a4dfe5-1a9c-4ca5-d7a4-08dc46effdb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6a5Is9LEu1AM/Vb1RS+lBhSDUW09z4omLhR3hpm+l75sZ0XmQCgCFfewQzK82fsCJFmuRjn/Rips85OetLvHNHzGGEhEWUXsR5ln6FC9UXVvFFxJ2q8D7gkGCTJJOVp3CFUz31tVVX5kRF36+lnYjLEz2urQt757d1Jg2Y//3GEJ2XwXa/JVgICUyhWKvcxbwnT47FbDCCPOCzVPNcdUwp2AE3Hbl25MzPzThuEsth8+9x3GGAErxlJgwUdtcz7UeFeA3vHsrOBY7JrtnLWGdxjRWvreZWpVJYbzWWXiMYl3NChagrkFbVqjxgJIIbxF/RmZY1i9Ckg4vn0cJS+GqM4A7gacePoQOx0BYNOquNUjdoPAn1aLttZnX5HMxQCOUukVx4bAgvNtT9WQnYvCJ59/EqTYRKCImizmQSEIOre7nxJde3szdZDGV4ekpRA1dHl5Wl6J/pCrZEZS0FJzvqEJ35HtuTNGG5r/QhiKDamhEIexSrWQgzk9Uo5e8geEHBxTg4pte6/a/iG72tRBOW09coqRVCOM3xqNmluE4hqwjrgs+5F6Gx8GdZXOpCmYFOJVZmjtRdU80NXJwO5LcKZNtSzDHp1yg1OKZ4h83aJAjfL6uh/f7/FkclTCF0400IlYd9teRl2TgKs5roANjGIqrVf3QFXNcAIWNuaqk+xoSMEDuQayRLffmVniVld0X/bN7lJY8ErCnMETz94jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GOaOrCJuERFUr9htzgma34eJUMBbEzfQZkivglTJd98jg9goosKhkedWqly+?=
 =?us-ascii?Q?y0ZEYUtI4ur2WbmcnS7INuBXhLO2BLJje6mCZGxkgkwlFTi1CbkgexpX86Cq?=
 =?us-ascii?Q?wi0yU5NoSb7ih9tGJTcTlrsCrJY1seCm7rSFqNWb8g4aX0Mq951guEzsOAWu?=
 =?us-ascii?Q?Xh0xafHfdYHy3ABLlrRnXGImSopjN/qFV5+h45hNhKrRPCzJFGhJF1kCSdmB?=
 =?us-ascii?Q?ORRLHL+b5CYY7VK8K9TN+FfREFAzA8EWJhdoSia9QkTaro/ragJyXb6eynXo?=
 =?us-ascii?Q?ZX1s5Aqehx6gLsSV+O3I7HRaEol8aH7+r6m7DjRcCZvLIE+yGSUwHKhQ4BmA?=
 =?us-ascii?Q?mYqtBHGgdyNoLco99tqvnXSOyvFQQFbHPJ6LUu+TIdgIbV3GIc8bh9FbTzWg?=
 =?us-ascii?Q?Oub6Mz7n9w5flYUDP9C8OYHCV5gAJFi2Gxr+d5xdTO1QD+2OG/lrmnc2SMPq?=
 =?us-ascii?Q?c2feLug+2uMk406rBBv9Kui7vBRxQ5EphEQWeE/9FaZ+WzuPziiDV8X5YWQr?=
 =?us-ascii?Q?QWOW1hrdgbxSn6PrpTNZjgbZ/LauaNIj27/LbhE9MmJzhY089RdqfqcZvVsH?=
 =?us-ascii?Q?4C4np/TU44p71Vcry9ark95ydycj0gsfFwB2GjkxJXQzyx2vAyn4sqtQNvWc?=
 =?us-ascii?Q?D8pmJU4/b0YoT5js4xQyXbmrmi97nM6ad+mG+7lScqYMTpVClAe+zAWBRY6f?=
 =?us-ascii?Q?z3VjaFXeQKzaMlgjiuWPHwdDOhR8/SbrGdedOV8NDtnyubslzMmKwJu1UePk?=
 =?us-ascii?Q?6mGMibROTQCyOp8gFUDFHWe2lSYUJjEqbFkfqvoeYKoAlTAUrys6v9IdVNoN?=
 =?us-ascii?Q?dsh27g74TAb/eDpc418r7JFDuF4j1Iao8yJqgAHsYwwEBP8H8SwXPT17Q0j3?=
 =?us-ascii?Q?BpwXWUYYdF3YiTmu2xGs+L1rdE2JVsgvBLF5XNOJq8I7zn5saQGKodL4+gPe?=
 =?us-ascii?Q?FCklEvcvhGh8s2xid5WPq0IcPq/egpc7eU7JVKu+DKih+XHA0rDhxZZL+QEK?=
 =?us-ascii?Q?rDgKit92xC1BgtAdnVdeQ5834lw4fay1tPzdbxQz0+te1cftlZ0gVM0dg3Gm?=
 =?us-ascii?Q?Onj2ttJpuy1e8YFSyOj/PvkMOX2Vr8NJm7cTYoXS3UNVA/7OTB5IDfUKP6q0?=
 =?us-ascii?Q?+J1SVeXfLh944520fRhkZnYcP+6DdVZ4GLuEnIxNLUdggdK1cpoAXbB3IFbJ?=
 =?us-ascii?Q?iULZOl1oJEjC2czliXpKgVfwpyfDoXtU/BK9YA/NOAhSP7aZIPhFEUZ85FHG?=
 =?us-ascii?Q?mhqAoW0PhOgKKAh+HEgoP0wl0D5FAKu/8+2LafV/0ZSGagXPkQGggHgFYqLB?=
 =?us-ascii?Q?Bp3jTwabeNjCGfI47IL9flSQm/sjSPxpKZnBrGiwKQVZk6KOYkVQqEJT9kus?=
 =?us-ascii?Q?b6tzZxYo+8lsUJglUEGIaCewNxJEdnM6t+Sb4G/IHw/MPfoGG+7htGQ/zmDB?=
 =?us-ascii?Q?Fil/MnbqgxhRcA6sLUi4j9+t13iw56zzauXouRBns1jpL5DgiEiPm3MMJJdB?=
 =?us-ascii?Q?YQF4ayT3HYZtu/hiQur9hrM9y7OXyUDg5V48Gum8WHWja/t0g/xbHX754UIo?=
 =?us-ascii?Q?7qsFqgs+TkCFcmGJDaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4dfe5-1a9c-4ca5-d7a4-08dc46effdb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:06:14.7445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miy9gYxl+V1rq8ztEhS8vo5AA7OlH5nqr3P9+LrXpVhJSUPuayvBhujb34gMKTCoU8f73TiLbbRhHkXhlSPM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

Let's not rely on ras_enabled flags. It mixed with hw & sw ras caps. There =
is case that sw ras is disabled, but hardware is still ras capable.

The function actually relies on ras block list to decide if it does anythin=
g. If ras block is NULL, then it will be skipped by nature.

Let's revisit current implementation - basically it should walk through the=
 ras block list before doing anything else.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, March 18, 2024 08:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH] drm/amdgpu: skip call ras_late_init if ras is not enabled

skip call ras_late_init if ras is not enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 7d4a1bc30277..4ea35648fdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3391,10 +3391,14 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)

 int amdgpu_ras_late_init(struct amdgpu_device *adev)  {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct amdgpu_ras_block_list *node, *tmp;
        struct amdgpu_ras_block_object *obj;
        int r;

+       if (!adev->ras_enabled || !con)
+               return 0;
+
        /* Guest side doesn't need init ras feature */
        if (amdgpu_sriov_vf(adev))
                return 0;
--
2.34.1

