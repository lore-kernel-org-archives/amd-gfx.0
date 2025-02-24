Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8216FC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208CE10E3B1;
	Mon, 24 Feb 2025 13:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnPvYj6c";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2F710E3B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 13:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4kpwfkJZdCwi5+ZMSQ12UOWiYpRBibipqXmhZ/iCr4Tb7zqdIiw2f4MU+bWRPJKUdMsLsbTZ9Q6iYfBfQ+On0KO/hwmd3Yw7/Dn183U2Q6EK1MUjS9RSrsqwMr/r1J0v9rwcHmbOQl4fcPGdDNGVev/rRriMiP1RK2EBP8nB7+rIWuGThsjXThbkvLATjSY2APw9jI9eLuUcD588EmR+ymTaoHqPQgt96OOt/pcwnmq549sGnvl7aoK02/p3QFe79Sl7tqPOOcF5CfAtRE4boD1/OTy29jPWmc8YGP0O1R8xW332h7xesxBpxS+srOA3V3wsfOA7IV4XuPcVYRkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3df2Wv3DzwNyu9JY6r8YLBtIQmuF3Gb06HwpysCCQ5Y=;
 b=xfCWI8WgcpFrbwt/ivFv4o9NxGW5oyq60epTjlE9Y/Tr+vUG78IqYzY38wvq49n2YdLLIE+QETavQS8xypgh9v7s4zVwsYmavnkhdsIX7kQIHhSBKAIe44jqZ4sAbI5kF1W62llqTnKE0lcM49vCGvreMEWnSM+DB0Al9eg8Dl9rJyMGFIyq7ypxD5nkk2STwlunJ5SwOkaBoqYQRH51cAwqPyyUPw9GPgbzHAKMUcgoqcIPVhidBHAFzE5U5bm52kWWa6rUdxT847EdmYQVCMhHo7L7pNhTFgHppiT1sv4aqZEe7NEG+NXWz4vxdGYosU/g0do3sRGl28MYATcVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3df2Wv3DzwNyu9JY6r8YLBtIQmuF3Gb06HwpysCCQ5Y=;
 b=FnPvYj6c4ZtnKNsLuX6dcVuSVpEUICpe3sUV42MJaZCMcbFpDDlZ4zv9tsuL37/hnbRSlcYFbtwCT7zvkcfhVkWdaBis6Dwg0R8jppTmD6TEBUySsLab2Wr1RhAF+q+WusF+ltDqx6hxrzdM1P7QORr9Lg95YefTZkdlrlqVBdM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 13:52:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 13:52:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Dong, Andy" <Andy.Dong@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check if CPER enabled when generating CPER
Thread-Topic: [PATCH] drm/amdgpu: Check if CPER enabled when generating CPER
Thread-Index: AQHbhr4iD5OX+txT90mRUt8ut4GIY7NWd4FA
Date: Mon, 24 Feb 2025 13:52:42 +0000
Message-ID: <BN9PR12MB52578BA4C6AB19F9D4B2291DFCC02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250224131409.26433-1-xiang.liu@amd.com>
In-Reply-To: <20250224131409.26433-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7b29dc77-e0f4-45f6-a0d0-2ad16d475320;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T13:46:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5787:EE_
x-ms-office365-filtering-correlation-id: 684707d5-cacf-4d85-74f6-08dd54da8275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?giUhwElSy1eHrvrUB8dSGfl9FO1SUVpgIPSd0DKdkEzlNwAaUN/1OP3nIkgK?=
 =?us-ascii?Q?GATreLoauIVyf6TANHySmGDJDR1RuxX7OfQzauodTdVyJpu5BkwsvbMiphwQ?=
 =?us-ascii?Q?fKYcFJbKfTlEZmDvluAf3MY8GkoGjOu15vx1OyLuACkq5xdlfj91C2IEJz7h?=
 =?us-ascii?Q?Dl1+rjb6mKL5QlmLybgkjt90/VuVpvAmtKpPj7j1sbaZD0o6gDBbkSmMpeB4?=
 =?us-ascii?Q?ejMuylhC3q66pVpHDLa6jihBeUWlF+cy+Ay9NOdazUZNQc/m9ZIKZz7lEC/3?=
 =?us-ascii?Q?dJc2b8nLfzd/8tUC8afluiuEhTvVnTV0MsSq7TZj6QIPAfvnRV7SdfZXsMH2?=
 =?us-ascii?Q?kgEUEk2H4IIlvrT5MxFl/w8R3gitZMIkXrOrYSoFgSW2ghAW78lIQQCVROeP?=
 =?us-ascii?Q?hEQCEo37WZPspW9n+w32IadNjF9o7T5z2iBcCOjSlPdflQJhrF0xhgpxnz5z?=
 =?us-ascii?Q?ZNbAUgDw+d8i+F41mRtIuhVqw1o2+lWqLb5XLRG1VmlIw4CJa34KnfAk6GxB?=
 =?us-ascii?Q?j1O2BqW+tDk15niXrp18abWQr5nFFdPvUco0rKG5Blr6ZKXlcrKdcRx3HXIQ?=
 =?us-ascii?Q?/1XSTTqMBCdO+Z0a9x6D8PDEzDlBaP6X0XF+MNIIRWOJ5eE6CSw6LHU0ySPV?=
 =?us-ascii?Q?4p5knsP2atL+wkkuw3He/wSh4imJGObyxZxkPDurj95a0ha9+QFW6lRS7nwh?=
 =?us-ascii?Q?bILoDTZQMTsxZ8FfHeEE6MR8CxzhxYjU/cv0Cr5+r+8YALK981n8A6/GImPZ?=
 =?us-ascii?Q?Wh6RbNP4ZpYzSM8v/f41AeOaQLxnuLk4Nf359mxkS5udLoVsCxmJkmhwuizU?=
 =?us-ascii?Q?Kz3iYn7eXymCM5lAXk9hBrjf1DEgSJKw5rXghrnj+Xtl8U0huAghNbyTvm31?=
 =?us-ascii?Q?6mm1+WQqjJnRpmZgWbmeo3LbuJBVBqFiI/86UZPLbEr0WNTYpbxbSz8Qydft?=
 =?us-ascii?Q?Jgz+pVWmVQoBBw8itB7Sib7M2PQLr7ttSJ6qMM0DlqzWexLIbbAEMneEKSJj?=
 =?us-ascii?Q?6hkg8eJ7WV4pFCyWhEH+0lzlhMv3hGGS5Q+BqGZQSy7QM2PnCoS14FZQlXK/?=
 =?us-ascii?Q?+5zRSerlGoKpQ/hYXm5bwDWxl7izPcbSiP3p/qMKD0/A8TykVu13pjG4Rdhc?=
 =?us-ascii?Q?eWORr2MIjF1J+JcyElaZjFfaL6IoQ+ex61D1+pHqz+5HyNtFfEi1p5lJRUEQ?=
 =?us-ascii?Q?5lAs48hq8vHOjc2tN+MeW1JdbDX4l349IsXIe1vgQfx564stYN15+uhzXz1v?=
 =?us-ascii?Q?MXG6Dcfu1xCThNObdxjyxYVvNWAAmLMHx/ZWYjZ0ISNfv8lwanBTqFTSl4GH?=
 =?us-ascii?Q?rENpVfl7CPKoeZs73Fxs3yC32L3oVfrEVTVDlMcXDV9dSyhdFISz/gU2rreu?=
 =?us-ascii?Q?+9OruLEXRkfbWmeSflPn5oejoAdCAEY78qMeeNfM6W3XqkkieQDa1MgM4jk3?=
 =?us-ascii?Q?ytE81wfa02Gc0AKSh9fpzucuN9TzQWQs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?moYcZRkNV3wuYB40w9O+ZvluV+v43Gh7qWaYe2gk379moFMVAovUtz+2lgPV?=
 =?us-ascii?Q?CYb+EEMQyO400UxQIswvtU8gI2EWyO5Q7TARVRqV5nXdpuTEb5SxlE6pJWFK?=
 =?us-ascii?Q?zrk4rL0AKnGI2/VHm+qZR/G9lo3tf4Lv3HxgUh3thR4KQNMEUUBA3SqOLV5Y?=
 =?us-ascii?Q?Qsr6P3ym7x8PPL7l5LuKL4XFz6QKZvOTHhCrqFbBM6YbyGMVCnP4PvH+omMY?=
 =?us-ascii?Q?ut26t6Wd7P2LVK7K34yOJDHc5RiLq1Y6bRbl59VfqSxExpKCxI6zHupCwkuf?=
 =?us-ascii?Q?bJHGXbRpYhkWaMzfCdOa4AwDkMkdzBRAk2bu8t5zt/hkan+fRJrMyzInO/qS?=
 =?us-ascii?Q?QNn1gD16jbDkofNz+5P5WvRWN+v6GAkh0lAOi6TJNcJKdYkcCZqxu0wbWVFA?=
 =?us-ascii?Q?xUOQhX+z41kVBPAe4o3eU1A9WePFiSsGJPZ56bA3z8SCnmNLE/dD5HkxQR/x?=
 =?us-ascii?Q?IInnlnVcPMAxJt+OcP8B/tN94FO75oqTusNEqAv8BSKyR8NX1LiBvQz4xa91?=
 =?us-ascii?Q?HaxrTDa3uG8wb7U+Ypn9/s26QShq36HDMVLrNIYC1+7MpkqxyWbS7goO4Ely?=
 =?us-ascii?Q?6jEyafyW+r7Mq+WYJ5CeuZHsBverZOuNRoYU8illkU3RNmB3cOGGDTvMTrtb?=
 =?us-ascii?Q?thvkXC4XXk+QFjO7AZv70o+nqiH7TTTfIVhkoqqIs/aPAHLlBGF1pwt6sF9e?=
 =?us-ascii?Q?+Nq/bbStX3dffVU9P1YuRu7RoHc0C6qdBFj96RfwKU1ejmWokPyS7T94xff2?=
 =?us-ascii?Q?0Kcd9yEyeYZsymjDY/xkZmbdZY2vQyvJQHpO3IswtKxiPYOmgWSN/MvOKqql?=
 =?us-ascii?Q?BRH6USxGOWkjeERxg1mQ59tkqO0Rt1Jku0wDY8Fgh8x3Ljk/kETKh9kl/tqf?=
 =?us-ascii?Q?abcIiVjbMLkbzeNJOJPBHvURmr6jVKv5FqDcUu0ERDbNJ0b7/8Ja1oUSO1s/?=
 =?us-ascii?Q?ZKv2xyjuuEoTLMXl5F3RQeiXIIE+2cfXys6ESORiFoT0YLxkPEJJspsoL3Er?=
 =?us-ascii?Q?yLv1o7HzQmuKE9hioeQMKPpsEaDsQct8cCHhthyybP+hNFA3exxvrHkiKakY?=
 =?us-ascii?Q?5JYIKWExiCeqZMrGlGzbMOpqkrh3QbRmK7cgBbLiudaPYAOegDoJP+5XdPAQ?=
 =?us-ascii?Q?BVODIxh7fYwI+ITQXczf3yNhTs9wu/pWP0+XfL9q3tZaCZype8ynRjxW8hff?=
 =?us-ascii?Q?RmDaPemoGvmu3DO+jdVJJ2Iu/FOnL2MsImKDEE3MrwX0ZcCFdw/S/3i3cdbq?=
 =?us-ascii?Q?PEXo34ZC78Hl2GGHrAKrYyIW02tSJEc2CyVcYz5GdNJW9sHW9gpMaFY30Kxu?=
 =?us-ascii?Q?yrdzcszNtMsCqxNDqGJxX/I2UeG/DZr2043B6vLs7P+AM7U3cySZB+o5Ws8Z?=
 =?us-ascii?Q?z51GxC7yfxf0AEk7fF/Me33zcW7va5plqIp9JJhkXKCXJPJ6bCyAlV7LkLtu?=
 =?us-ascii?Q?eW+XfL6oYrTJS76hzFW6nYPvL3/Zs3dbRbwPtRcys7zwHvL2g3ow34O4ucEA?=
 =?us-ascii?Q?Vs4SJwn7drel050EztN8WExkg131JLVr+Z+6nl72WrFtRHRtCxSlzOfa1/R4?=
 =?us-ascii?Q?rizn2uZ7R7kpAlnbFXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684707d5-cacf-4d85-74f6-08dd54da8275
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:52:42.4371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+OttiKVp43EmH/U9FRRNI7VUfdxxPBZ2mBT8dLtl0rq3oPai68mx8gZlaRktjzXke98yqtVrNUWvNcQW/BqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Please make another change to set cper.enabled to be true *only* after cper=
 ring is successfully created.

Regards,
Hawking

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Monday, February 24, 2025 21:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Dong, Andy <Andy.Dong@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Check if CPER enabled when generating CPER

In the case of CPER disabled, generating CPER will cause kernel NULL pointe=
r dereference without checking.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index d11593cd1922..ffd4c64e123c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -392,6 +392,9 @@ static void aca_banks_generate_cper(struct amdgpu_devic=
e *adev,
        struct aca_bank_node *node;
        struct aca_bank *bank;

+       if (!adev->cper.enabled)
+               return;
+
        if (!banks || !count) {
                dev_warn(adev->dev, "fail to generate cper records\n");
                return;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 7c4ff12269d9..81e9b443ca0a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -716,8 +716,9 @@ int amdgpu_dpm_send_rma_reason(struct amdgpu_device *ad=
ev)
        ret =3D smu_send_rma_reason(smu);
        mutex_unlock(&adev->pm.mutex);

-       if (amdgpu_cper_generate_bp_threshold_record(adev))
-               dev_warn(adev->dev, "fail to generate bad page threshold cp=
er records\n");
+       if (adev->cper.enabled)
+               if (amdgpu_cper_generate_bp_threshold_record(adev))
+                       dev_warn(adev->dev, "fail to generate bad page thre=
shold cper
+records\n");

        return ret;
 }
--
2.34.1

