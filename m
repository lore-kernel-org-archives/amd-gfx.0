Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A55AC02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 06:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D727610E2F3;
	Mon, 20 Jan 2025 06:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zeiS+YqT";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1241E10E2DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 06:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf+kGNY1ULx3cRaeR9O0CoIk3OESkuIM81qEE9jIQ83lERH1y1cwqMFsYncDYQU0//4gwn/woOkCzJx6m9wpJmPOzxMZXP/ygWBd1Zir4BxeBMy4EpmjPExwdpOTM7ifgHWL6h2O4q9twbvd+r+ZUgpOs1tJII5rb1DEmaeJ/1HT7dxe1u1Xeh8ZD2Eah7giXJr4jT2ovJfRupjNuYRol8pT350wIE1g4kc2eXdxBYbVa0bnUNZRyvnW29xBmOqAGOV7Xha90018nOrAwQASlmrzQmQO7HBSQpnYQ/ybCO+BwC59J4jL06+eGQ9jJx3AZKL+JYGG9a7rzx1f47qVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aILZB7AWChDbNA/v3mZKcLpzrgXqgQ6v63sqtA6VvtM=;
 b=HEJABkv4c7Qz8DInXPb1DWUjUUDgfEm+aKPBgLVHPke/byCSLFqlccMJvNvVg9lCotN0FZes5t9EN80OAniwXI+89Axf1hvW0C/rH9jB+8bFj45UVdVo2WZwSlxjdF6Z1vXtgGAU5XvAgRJVeJzt2aM5bcsBY7Qb0SW4YT8ZJ2nX8SjzMzAktR9F3oCMBRS555/Zq7hwzwp0k4AqLv8hufVnRjUK/AaaqlqnEKGHhwEfOfDnlYjZnWoS/qSWwTceHMCz75rvDeC53MVCuhxGcchmYglJzP+ODBdSfTIo+Fy0z98sLOYcDFReHjxFeosx7AI875vrUPZI2JelqV4RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aILZB7AWChDbNA/v3mZKcLpzrgXqgQ6v63sqtA6VvtM=;
 b=zeiS+YqTF5m5dRWVLfv71Tl73VJ7XsKpNy0Gro3v+fBgOgJzeSEO6lX6rMaDxSncSRTKBhtF/qaQ8LTl1Ld1yao+4gC8FgAmVvI+ixgbiA0rrIXdEzW3C8b/h/PKeaNCmB4XtuauXwyUUgC/2OhKAFymWtxahIIDDa4hjVF5EG0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 06:27:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:27:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Jiang Liu <gerry@linux.alibaba.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>, "shuox.liu@linux.alibaba.com"
 <shuox.liu@linux.alibaba.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC v2 00/15] Enhance device state machine to better support
 suspend/resume
Thread-Topic: [RFC v2 00/15] Enhance device state machine to better support
 suspend/resume
Thread-Index: AQHbZVxps5HcglRxIU+hEwV0akJGTbMfO/Ow
Date: Mon, 20 Jan 2025 06:27:58 +0000
Message-ID: <BN9PR12MB5257EC081CE5514FCCE7FC92FCE72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
In-Reply-To: <cover.1736732062.git.gerry@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=99bd5f22-a800-4788-b74e-1164b6da2d7f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-20T06:20:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB8914:EE_
x-ms-office365-filtering-correlation-id: 87a2cb64-a87f-430c-9acc-08dd391b950e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WbvSAJqWw/O1fiFQharfHBJjFuX/omtRKmpLWDH+H4z3C9Ue9D90ngBHkLfA?=
 =?us-ascii?Q?TNdDsYpZ5SG905DF+lN2IOg6JNrgro3uQ76BDHGgWwuoad/gGYOrPYRDfeVk?=
 =?us-ascii?Q?Jh97ZiwJsISdv2ynp7zReZ/zSFeRkdLdU4saAovrqSIf5OUuFxdXML+SndXX?=
 =?us-ascii?Q?ew82KLR34owcStit+End6RFE5k5kDaoj+hLQqCTpoF9VCAqdOJbPdAFlXXLu?=
 =?us-ascii?Q?Pl8R6njS7Gc7XX5UfntRAp79i0WRMcUh8CBHwJRCgML8YszOWZAMjjxd3bW2?=
 =?us-ascii?Q?bAciXaGzyrzzoixiBICkwTyZe/EfckM5FQxyb8++LATQRTw4OXQbPQD/uOL5?=
 =?us-ascii?Q?KzlOvBMVCmfH4koKaHJ68LjVyDqsbX3RBa5bMfaBevqipqNZjdz51ao8Q04n?=
 =?us-ascii?Q?56xATSmvLfqwBIRnuP4jO9HnQwANo8zr+UO2Kv/6+r3mUB4amif4GJZj48Vi?=
 =?us-ascii?Q?i2gfdkDx+UWsrKX/RdrCPnJp3JZolo1wBLctBIpB68Vnfp2f8z3em1cMDgNW?=
 =?us-ascii?Q?TJ8fzibLM5azDp2NuXlgb47Ynmo4yX4U5ZpZOoWjCzw+U1EmzvsD/gUndun9?=
 =?us-ascii?Q?ZTrBAYnxS0f7FVZBpsJvp2Jd/268Ss2c741ixLdSz0MpVCZeVha+zFt1HNko?=
 =?us-ascii?Q?Wls1nDxR9TcuBJfY7qY8uQg1yK1eub6HETbB42x1wvqq+iZPqQhU/xRcWGp2?=
 =?us-ascii?Q?nCsjfLFI6YbXGbHQWTfEUH1wEBvfOD65vh5qZLrPZyyhmsy0ZFik0EiqHW04?=
 =?us-ascii?Q?6r4i3/aiQXNT8UZl3YPAP6k/6kWuzfQmux8ONL+Yrwwpg/y2GQ2T61obgfgc?=
 =?us-ascii?Q?V+EotqZiYSVVlUeUUOrAJR+7CCRMDGdkdHFzuquR6G6e7ypqXwHiSNzLx6+l?=
 =?us-ascii?Q?ENX6GQ/xQ4W45uEi40ozhhu9+MOrqmD2uZRWVHJJt4JuhINdVQLL/TOe4R8R?=
 =?us-ascii?Q?rXfghk1tpKPC8S0e0ad1FKP87of6kcNkxhCEjwJc58sBkB4dF0sb4aRkwAL6?=
 =?us-ascii?Q?xBwdfw5vd9fy0lFMkE0mcxgqM6iaTUYxftoyX588o6BPeAbjs4ZEWaz84Z7N?=
 =?us-ascii?Q?bjlpTY7OOgXOuOVhkHFWYNZbeIlWL6AzWa8iPSJfcxpY9nVGeO6aeEhrWlLp?=
 =?us-ascii?Q?iPmg+hjl7Gxkrpzrnw9MNpvBlkaY4vgTIF+cYwWUPLwTzVKez4AWaQNFCfAs?=
 =?us-ascii?Q?iBMbAIgvxUrAeTXcl7OgUhJHoNoGUct0aUMRth1AG8KFfH8F/nQceR2K6H51?=
 =?us-ascii?Q?gsh+/nljd/+mk29pUZAP//I4gLIAcuzBkq3rIZmEl/Ix783GNADDQ1eRWIQy?=
 =?us-ascii?Q?EL+ZOl681dxjqKEpWORNKD2xzt/U9lholzx9kqJWPUTIzQebP3L5yUC8g9J+?=
 =?us-ascii?Q?U6LhZMqFmVb5sUhKjGrdSf0A2/q9NJOm1STl0A5lzWQ4PzVOkszDYog+mIpW?=
 =?us-ascii?Q?k0CgoUgOm8F/gSOBebt/pdLgCq0gKh7mNp5oEUdoy7A/jbjYuQuPfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pY/0zlJdKNGtoBDUlVxlMnIS9jcyl0lDRDDQuGCNb/wIn9vV+0OVUr9bEZ6H?=
 =?us-ascii?Q?RdNunsV7L1qVYRw6DFWNoplm4bu65BE4cWb8zKMSqPB8NjV5J46xLFtf6l04?=
 =?us-ascii?Q?1+X58gOkIzJTsLu835FLdXqSJaztDuoJSVc7e0lj8MtoGf000+HKlybJFRGS?=
 =?us-ascii?Q?T3ku0YCGkWN6Tpwk3ifLYp5YajtQzfFzeJJVKGkRb+9lF79hHbOjupdxLnoJ?=
 =?us-ascii?Q?KOJPSB9Xd/T3poDHd8YbpHXtqBfQXIxsfBsWBz1Ww9EGlXmYoyIhDe2iKCHe?=
 =?us-ascii?Q?i08smvHH17B9NakAKopw+7AIet+z6VtIlC45OlADujv0gpEfD+tFyHLFPzYq?=
 =?us-ascii?Q?tp1elFdl1VKAiE9la7qytlM2N5dPGSiPgEcMdB1MAWXDAVH4TnPEX7rW9cyK?=
 =?us-ascii?Q?b9hishPHgfee08sQ2iBqqLOgOddIpHngH/6jHX3hPsg+1PmHnRyHBW0Z8rly?=
 =?us-ascii?Q?R5pzpsyxDpUGD0eUpdUo8/kLVsyu5NrNZx9unTnid95zxCCg+s3U8XWGrBaB?=
 =?us-ascii?Q?kPlDc0mBlRim2+ucdrRYYwNH3bSJ2kUwy4n+9D16xz5oU+6nemN1O69G22V+?=
 =?us-ascii?Q?WP3tsUgKOtmb1tVUtPvXrQJowtXYHc8RRtYO8piK238QXfKNtEiZYFVoTZxX?=
 =?us-ascii?Q?2hHKlZqOenYlPOyF3pwFFfX21uWK4V+bRo13twc4KbUpWr5esoMofU70uYop?=
 =?us-ascii?Q?lcyroC4ql1DmLD+2ODW+vPpBWdV+3IM+j97pAqSZcN1+u45b9QOgwQOdiGu/?=
 =?us-ascii?Q?Qk08zBCr+XdIAmsmSmOUiwyPvVVdCIfSkMwcm3iEiO52mh+ER4ZNjE6OcxCx?=
 =?us-ascii?Q?RFGDqoJtlemvPZILtDwJv17QAKvu/vYGce5nrnHbqW3vJU9PtRiqJvqiy14E?=
 =?us-ascii?Q?jDSVtYUip8gkEMUonAGRlpyVr3s0IXyyz78Zr/IYYcp8XZ2TqUzoSzJCPxpL?=
 =?us-ascii?Q?zReD4rRxARcWh0u5CXVKNwS80X4428ki9WxdcKk1SLzb/pSXkUi3PyajrfVy?=
 =?us-ascii?Q?SKkvJxaA1uwZWQJkAH4QbIZxf1l05MJPapUF72aT3wBUVSv2mTkGNRby3AJy?=
 =?us-ascii?Q?42NPb8v4zyXp6sEyz8jbat79nokJuCfZN3SISv/k2OIUhVbzkdf/x38VO7oM?=
 =?us-ascii?Q?vh3SEKLdfGIn2/RlKijmt/tAlKve6R48R3Ao/rhccx/I7VEMWDbhZEvoVICs?=
 =?us-ascii?Q?qzs+n55nE05ocvhhyXfw4MUuVs/wlHswVLb4dhlJuXxiXTsgnQNA7tRAQBSp?=
 =?us-ascii?Q?MFCcNH+D6GY4vJs93G1SwYmZFfLgtuD2xhmA3reC3h2GHmkbu4e8zWFEmbMY?=
 =?us-ascii?Q?L44lNmgV5IHmf/36sZKoJOzc/J36+3hxgnaJiiO8wtMFpXIxcjmlyrFJKNSC?=
 =?us-ascii?Q?p+xgK3KQ9xrMnqphBqm8gwjAKSRqUjExD2jRtiIlnYFqKZdDGFy/ZMl5CRrE?=
 =?us-ascii?Q?i9shVWYq7cv2hnipqic7BDBJMBryL4LfOqIGACCdrh7efNdm+lpE6VJwVHK3?=
 =?us-ascii?Q?GK4TzVlQUE8d50arM3SjK+6FCabYYBG4anbpwKzjwCmLOJmBAFGukygZ9ATg?=
 =?us-ascii?Q?63lAcmEAHSstGLvoYY7iV1lsv+AmQKAzQoACfe3m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a2cb64-a87f-430c-9acc-08dd391b950e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 06:27:58.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4MMwDD/c1j9aTjH0HV2o0GmhbkGkNrErLEK+OdXArQtcs7YP8m0LLulpcNJ2CrIxkf7BNhcblc4rdmHLLdcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

Thanks for the patches.

We currently have no plans to include RAS programming as part of the device=
 suspend/resume sequence. Instead, we are focusing on a series of clean up =
patches and a new RAS software module that will eliminate all legacy code/w=
orkarounds and also the changes you proposed here. It is not necessary to m=
ake this interim change in the upstream.

Regards,
Hawking

-----Original Message-----
From: Jiang Liu <gerry@linux.alibaba.com>
Sent: Monday, January 13, 2025 09:42
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com;=
 simona@ffwll.ch; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.L=
azar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario <=
Mario.Limonciello@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Russell=
, Kent <Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com; amd-gfx@lists.f=
reedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 00/15] Enhance device state machine to better support susp=
end/resume

Recently we were testing suspend/resume functionality with AMD GPUs, we hav=
e encountered several resource tracking related bugs, such as double buffer=
 free, use after free and unbalanced irq reference count.

We have tried to solve these issues case by case, but found that may not be=
 the right way. Especially about the unbalanced irq reference count, there =
will be new issues appear once we fixed the current known issues. After ana=
lyzing related source code, we found that there may be some fundamental imp=
lementation flaws behind these resource tracking issues.

The amdgpu driver has two major state machines to driver the device managem=
ent flow, one is for ip blocks, the other is for ras blocks.
The hook points defined in struct amd_ip_funcs for device setup/teardown ar=
e symmetric, but the implementation is asymmetric, sometime even ambiguous.=
 The most obvious two issues we noticed are:
1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
   are called from .hw_fini() instead of .early_fini().
2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
   match the way to set those flags.

When taking device suspend/resume into account, in addition to device probe=
/remove, things get much more complex. Some issues arise because many suspe=
nd/resume implementations directly reuse .hw_init/.hw_fini/ .late_init hook=
 points.

So we try to fix those issues by two enhancements/refinements to current de=
vice management state machines.

The first change is to make the ip block state machine and associated statu=
s flags work in stack-like way as below:
Callbacks                    State after successfully execute callback
                             AMDGPU_IP_STATE_INVALID
.early_init()                AMDGPU_IP_STATE_EARLY
.sw_init()                   AMDGPU_IP_STATE_SW
.hw_init()                   AMDGPU_IP_STATE_HW
.late_init()                 AMDGPU_IP_STATE_LATE
.early_fini()                AMDGPU_IP_STATE_HW
.hw_fini()                   AMDGPU_IP_STATE_SW
.sw_fini()                   AMDGPU_IP_STATE_EARLY
.late_fini()                 AMDGPU_IP_STATE_INVALID

Also do the same thing for ras block state machine, though it's much more s=
impler.

The second change is fine tune the overall device management work flow as b=
elow:
1. amdgpu_driver_load_kms()
        amdgpu_device_init()
                amdgpu_device_ip_early_init()
                        ip_blocks[i].early_init()
                        ip_blocks[i].status.valid =3D true
                amdgpu_device_ip_init()
                        amdgpu_ras_init()
                        ip_blocks[i].sw_init()
                        ip_blocks[i].status.sw =3D true
                        ip_blocks[i].hw_init()
                        ip_blocks[i].status.hw =3D true
                amdgpu_device_ip_late_init()
                        ip_blocks[i].late_init()
                        ip_blocks[i].status.late_initialized =3D true
                        amdgpu_ras_late_init()
                                ras_blocks[i].ras_late_init()
                                        amdgpu_ras_feature_enable_on_boot()

2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
        amdgpu_device_suspend()
                amdgpu_ras_early_fini()
                        ras_blocks[i].ras_early_fini()
                                amdgpu_ras_feature_disable()
                amdgpu_ras_suspend()
                        amdgpu_ras_disable_all_features()
+++             ip_blocks[i].early_fini()
+++             ip_blocks[i].status.late_initialized =3D false
                ip_blocks[i].suspend()

3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
        amdgpu_device_resume()
                amdgpu_device_ip_resume()
                        ip_blocks[i].resume()
                amdgpu_device_ip_late_init()
                        ip_blocks[i].late_init()
                        ip_blocks[i].status.late_initialized =3D true
                        amdgpu_ras_late_init()
                                ras_blocks[i].ras_late_init()
                                        amdgpu_ras_feature_enable_on_boot()
                amdgpu_ras_resume()
                        amdgpu_ras_enable_all_features()

4. amdgpu_driver_unload_kms()
        amdgpu_device_fini_hw()
                amdgpu_ras_early_fini()
                        ras_blocks[i].ras_early_fini()
+++             ip_blocks[i].early_fini()
+++             ip_blocks[i].status.late_initialized =3D false
                ip_blocks[i].hw_fini()
                ip_blocks[i].status.hw =3D false

5. amdgpu_driver_release_kms()
        amdgpu_device_fini_sw()
                amdgpu_device_ip_fini()
                        ip_blocks[i].sw_fini()
                        ip_blocks[i].status.sw =3D false
---                     ip_blocks[i].status.valid =3D false
+++                     amdgpu_ras_fini()
                        ip_blocks[i].late_fini()
+++                     ip_blocks[i].status.valid =3D false
---                     ip_blocks[i].status.late_initialized =3D false
---                     amdgpu_ras_fini()

The main changes include:
1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
   Currently there's only one ip block which provides `early_fini`
   callback. We have add a check of `in_s3` to keep current behavior in
   function amdgpu_dm_early_fini(). So there should be no functional
   changes.
2) set ip_blocks[i].status.late_initialized to false after calling
   callback `early_fini`. We have auditted all usages of the
   late_initialized flag and no functional changes found.
3) only set ip_blocks[i].status.valid =3D false after calling the
   `late_fini` callback.
4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.

Then we try to refine each subsystem, such as nbio, asic etc, to follow the=
 new design. Currently we have only taken the nbio and asic as examples to =
show the proposed changes. Once we have confirmed that's the right way to g=
o, we will handle the lefting subsystems.

This is in early stage and requesting for comments, any comments and sugges=
tions are welcomed!


v2:
- remove patch 1 in v1, it already got merged
- convert status bool flags for ip block into enum
- introduce iterators to walk ip blocks
- refine the way to define status markers
- split amdgpu_dm related change into a dedicated patch
- add patch 13 to walk ip blocks in reverse order when shutdown

Jiang Liu (15):
  drm/amdgpu: add helper functions to track status for ras manager
  drm/amdgpu: add a flag to track ras debugfs creation status
  drm/amdgpu: free all resources on error recovery path of
    amdgpu_ras_init()
  drm/amdgpu: introduce a flag to track refcount held for features
  drm/amdgpu: enhance amdgpu_ras_block_late_fini()
  drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
  drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
  drm/amdgpu: make IP block state machine works in stack like way
  drm/amdgpu_dm: enhance amdgpu_dm_early_fini() for PM ops
  drm/admgpu: make device state machine work in stack like way
  drm/amdgpu: convert ip block bool flags into an enum
  drm/amdgpu: introduce IP block iterators to reduce duplicated code
  drm/amdgpu: walk IP blocks in reverse order when shutdown
  drm/amdgpu/nbio: improve the way to manage irq reference count
  drm/amdgpu/asic: make ip block operations symmetric by .early_fini()

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 109 +++-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 504 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 142 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  50 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  51 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  22 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +-
 32 files changed, 668 insertions(+), 460 deletions(-)

--
2.43.5

