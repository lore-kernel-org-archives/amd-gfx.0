Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC213C001E0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 17:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A3910E47D;
	Wed,  9 Aug 2023 17:28:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A71110E47C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 17:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FivAKty69LekOUJ/os8dUwdnstWVgG77dlcl5IKhxhj3Eleki1eE3YtVBgHVPiZd2sUupQYMAjl7uo7aGdEFKdCk4WnBlCYOIst62pN7LOItokGWWpb0JBz5WtkW30+5+4pU1BbJRP3znCVBmnI9FriMVki6uSi4q3lYzkZ6b9Qft+MVGLcGR96BbXkrIWxtQRGos0OJTt6ccyNidUGXBu6ivxWMHNLYhQBG5EBMVZ76ia1y8A+I1May7X+ZkiR34ZDtl89+lfl///fvvzy2IGlW/LbkQ8oUQsJ0NWc2ctDs3dhW6D5rF/5ZpqV0m+9wjriJE+I+qy5nxKx+yb08Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qrro2NGCTD+r8ECVEk5GYMBlga5N0fi0pKKlsctYIPU=;
 b=YIt2ytM1WZcd13NMtppbVLjJWiLwtof6tEbAzxDTQwzBgUMYtc6iNib9ERssf0Jt4OBDkggkKcrv0tIbZNqNTnhNDOx0NwY3kSKsF3H/RZT0UvOTtv6X3b85r1oq1W9jihO+oyJiCOGLCWhnRREsoMpQN2eqmb8nun4EpeCj2kDoK/9Jo+J7ycpaM2x3t5xQIqWAZ0GeVAqGMGjqxknUc508Ab8zaEwa+8gUxGFPNszO5rpMfC/Zzg3N36HJAAiXHIWLEXKVJwXe+T9Q1mv0OIUZNio56a3wy3BphCxZSciIYlQcak11imZWwu5JV/I2Wr88ausf/qPSLiKzaZ/clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrro2NGCTD+r8ECVEk5GYMBlga5N0fi0pKKlsctYIPU=;
 b=k12J+FI3SIuP1lB+PpkPHhUh+451A47HIsl2Yd3SZVrCIcqcj3xZyu4Nl969ZwHVN3mEUTQfucIq73YgdjOPU2BYypXDo/ndyAm3WNQEL7XFpX4kjdbzbIUiK+QWpdeBH2SkSgWuopM3hwszUHSNggSETNwqYtHOfkrmt7YnKlY=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 17:28:07 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1322:914a:589a:7146]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1322:914a:589a:7146%5]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 17:28:07 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 13/15] drm/amd/display: Remove freesync video mode amdgpu
 parameter
Thread-Topic: [PATCH 13/15] drm/amd/display: Remove freesync video mode amdgpu
 parameter
Thread-Index: AQHZytNv2eCOy0q2UU+4XqctBLDrhq/iN7pF
Date: Wed, 9 Aug 2023 17:28:07 +0000
Message-ID: <CH0PR12MB52841CC92CF63A180A014C348B12A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
 <20230809150620.1071566-14-stylon.wang@amd.com>
In-Reply-To: <20230809150620.1071566-14-stylon.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-09T17:28:06.377Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: 78f2a289-1f6f-4a96-df28-08db98fdfede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wykKnmtv0eL+OH5/F8vU5JBEU5iBUN4TpV0iwonAuY69usx+u5bvZkMjN7nvZhC5/6lL5IWuJ+0zFBoRwV902KkNkdU8cfNeW0WqpNz5HIl3ZB1JsMOp0AVLbtJPNpqwbI5ZfejpDCXlKDdI0kA2NEF0fxl6E86kpxXQgRQJ98s3L3T35eHTNKeZeBn/dXFA48udXo18hWbNAGuhURxS2vT3ojhGw0byku4e6nxBfrAiaukBnZIAJ2wds0UajksR5Se57yOkMReTeB+rCYwn9hH14UkyEWe/Pc78bC3fGlwKbXcx6Q5iGkvSsBMf5Dm7FHlOucWj+OsWwpblxIzYTuREvGAD36D4ZHJ99sbBQZBotqt6LBVNKd61qHYt4DoPiJVBYFJTneUPBCDjeMlI6aaMcdVB2L19UJaMZGcc/95cebpD0GO5+GUdPzMWi/0NbxjtjRWmItAaFDMm/BHoWZVVJvBzh2zl5wT2yKlqwjN70tPQAHdPeXd3iGObzCAdNo0F/Lc8LQ15VUrM6XbnNQ5ooVuDvYrZH6SkNYq/8rEQFZ9E49RDrw/kid/125Fbx+EpNKsRS4IvTgwd/y6/XDAbUp4o1i/+i0ALZ3j2P4N4MYm3NW7LfD64y0SeL7RA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(186006)(1800799006)(9686003)(55016003)(26005)(53546011)(6506007)(54906003)(38100700002)(110136005)(33656002)(52536014)(5660300002)(86362001)(38070700005)(4326008)(2906002)(66446008)(66556008)(66476007)(66946007)(76116006)(91956017)(41300700001)(8936002)(8676002)(316002)(64756008)(71200400001)(7696005)(122000001)(478600001)(83380400001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l606FvbykCdz+Bh32q4gbKrEv6EXp57hFnN5F4Y3CWewfcEymsftFYnmtLE2?=
 =?us-ascii?Q?5WWjWw7pBDTe/UKaH2JyLNYoY2ECwkMAJMbAZAlPzXjfnK9mQHp3kIzbsTaK?=
 =?us-ascii?Q?/MxJM3fKRJPOqL8vBq5kfTvqNyl2csheftvc5PGmwN91Gh4m46wfzJv2or2z?=
 =?us-ascii?Q?SnlJ/GnSpa/bOfc+oD+BaiWIQcA5hQZiLpmzJOsQlr4dalTeREPfwHYCMKal?=
 =?us-ascii?Q?lyqIUJ0eDIMbm+dvtzGxsXGamDD5hcuU3HY7kwC1hhynW1+lp+lAOyMphmc6?=
 =?us-ascii?Q?BNCBHiYNoS2IW5SiBn9iSL8wsR1o7dURSBb9izidNR1HtCJkberaPtzpzG/C?=
 =?us-ascii?Q?9gy9mPloBl2QqJmlKRAssKA65Z0O58rLFuunxPqgZaMtOf+6UUFoOWgPf87l?=
 =?us-ascii?Q?uk7v9/CjLw8PnJERj5RQ62PIaLHiI9Vwd4hR9daC/3E83/aS5/TE2uUS39Ls?=
 =?us-ascii?Q?2EgNfoa2DZPSl0wFACQ5dfHa4leEr9tgM30V4m857igh/pOCVMD3ltgALHhu?=
 =?us-ascii?Q?Kvsvk9Zs6/+klOaagEhQk0M1CIwPgH9fcYkLVywWY54+sfcY+mZF42B5cRBF?=
 =?us-ascii?Q?AVkP0ufEIOMIMMNKhgkOowOycW6ge+1dUbwC78Lx2CTPE0FZp8yRLxWsrqyP?=
 =?us-ascii?Q?LiWDXWBEG6xI+UkLbX4VtoFWhrKq/N/YYVaSFjS8SKUazLS3gur1rSR9Kad5?=
 =?us-ascii?Q?wtvsohjzOR5G3AAkYQxMi8SdZ09ibFh8kAh9zTXxXPDcRS5S+9NCccrVwp+5?=
 =?us-ascii?Q?NGiXFM70pIuPdUZ6F+4oNhcokE4hVLQJYSNASE8+s0Sv7sRUew8p3GqFNDCP?=
 =?us-ascii?Q?lq4XC2h/ojpBh6m2PHJaTiITCySvRw3hrnu44h6mY+Lu11TJLCInKOgxdS6c?=
 =?us-ascii?Q?g2vL3VsCdLFcbeCBpXddDI9Cz3mqcLSeBQnBEl0OrQsjtaq6cmIMD8m+aTNQ?=
 =?us-ascii?Q?15evvW8ggsGtRijq1VQL+BQZwm5gRVAmRODUPsJ8cHKbqe0f+q3LufK4q+bg?=
 =?us-ascii?Q?Fo/hkgXODuUqpyx23GcNIYs5SZxy4Z80U6WcpfYSmdem/H/F9Te4sCqne45w?=
 =?us-ascii?Q?iOaQ9b8fDeenQDq+XqQTPW3nYS3DYVBRhT4ZPjzm0dA8odW2YAeHFVYtpJew?=
 =?us-ascii?Q?k/PR2Zkrpdx4s3/m87RNmgF5cpldMcANrRSdhR8Lu8syL6E0hUMcf4rYtLGl?=
 =?us-ascii?Q?dT1hhMQhBHaV4VcdBVzG7ex5rMbxdkOfGK6mLsv1bYtODWQrRnZfDC9UG5Th?=
 =?us-ascii?Q?o/7OsqseuszHyMdbUcvf5Hev2xyTS5YERsUvrJqM5BkrdRJ+Q47m0xZga+0t?=
 =?us-ascii?Q?8J9VOM7rXQg8VehkJinn9rqKH9uDUcyC+NsjlxzsaQB1kU+1advyo5J9SukN?=
 =?us-ascii?Q?9ZtavHt++Oj2Z1ltXkoBq0A92QF38GAyCnlg5oM+XQymYxy7nr7VKcmvd+Wa?=
 =?us-ascii?Q?lj4y38e/TMZ971qFMvfFskdMHeHGDUCuM+mF3D+eWKcyYySqazT9eQYRs9UP?=
 =?us-ascii?Q?bz3xH19siKTnkolvUoHpNKFx8p6e7zauqkuvUl/yrj4YELdG/pJjW8B7DvTV?=
 =?us-ascii?Q?2XIONTdLptSs/JTNVbw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52841CC92CF63A180A014C348B12ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f2a289-1f6f-4a96-df28-08db98fdfede
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 17:28:07.2718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwfpH2xbqqR6WWFECZoYD1oDSvcWGAjOxJttDS3WUmO6Kp7MUkdYZ9KGGT6ATBMV9ZoJkN8FxFjcy4odt2OgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB52841CC92CF63A180A014C348B12ACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Stylon,

Sorry, the title is misleading. This doesn't touch display. Could you pleas=
e remove display from the title and make it drm/amd:

--

Regards,
Jay
________________________________
From: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>
Sent: Wednesday, August 9, 2023 11:05 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Pillai, Aurab=
indo <Aurabindo.Pillai@amd.com>
Subject: [PATCH 13/15] drm/amd/display: Remove freesync video mode amdgpu p=
arameter

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Freesync Video mode was enabled by default. Hence no need for the module
parameter, so remove it completely

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 2e3c7c15cb8e..4de074243c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -193,7 +193,6 @@ extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
 extern uint amdgpu_dc_feature_mask;
-extern uint amdgpu_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 0fec81d6a7df..8f7d0f8e57ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -187,7 +187,6 @@ int amdgpu_mes_kiq;
 int amdgpu_noretry =3D -1;
 int amdgpu_force_asic_type =3D -1;
 int amdgpu_tmz =3D -1; /* auto */
-uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method =3D -1; /* auto */
 int amdgpu_num_kcq =3D -1;
 int amdgpu_smartshift_bias;
@@ -885,32 +884,6 @@ module_param_named(backlight, amdgpu_backlight, bint, =
0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 =3D auto (default), 0 =3D of=
f, 1 =3D on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);

-/**
- * DOC: freesync_video (uint)
- * Enable the optimization to adjust front porch timing to achieve seamles=
s
- * mode change experience when setting a freesync supported mode for which=
 full
- * modeset is not needed.
- *
- * The Display Core will add a set of modes derived from the base FreeSync
- * video mode into the corresponding connector's mode list based on common=
ly
- * used refresh rates and VRR range of the connected display, when users e=
nable
- * this feature. From the userspace perspective, they can see a seamless m=
ode
- * change experience when the change between different refresh rates under=
 the
- * same resolution. Additionally, userspace applications such as Video pla=
yback
- * can read this modeset list and change the refresh rate based on the vid=
eo
- * frame rate. Finally, the userspace can also derive an appropriate mode =
for a
- * particular refresh rate based on the FreeSync Mode and add it to the
- * connector's mode list.
- *
- * Note: This is an experimental feature.
- *
- * The default value: 0 (off).
- */
-MODULE_PARM_DESC(
-       freesync_video,
-       "Enable freesync modesetting optimization feature (0 =3D off (defau=
lt), 1 =3D on)");
-module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
-
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mode0, 2 =
=3D mode1, 3 =3D mode2, 4 =3D baco)
--
2.41.0


--_000_CH0PR12MB52841CC92CF63A180A014C348B12ACH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Stylon,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Sorry, the title is misleading. This doesn't touch display. Could you pleas=
e remove display from the title and make it drm/amd:
<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Chao-kai (Stylo=
n) &lt;Stylon.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 9, 2023 11:05 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wa=
yne &lt;Wayne.Lin@amd.com&gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.=
com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Kotarac, Pavle &lt;Pav=
le.Kotarac@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt=
;;
 Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH 13/15] drm/amd/display: Remove freesync video mode a=
mdgpu parameter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Aurabindo Pillai &lt;aurabindo.pillai@amd.co=
m&gt;<br>
<br>
[Why&amp;How]<br>
Freesync Video mode was enabled by default. Hence no need for the module<br=
>
parameter, so remove it completely<br>
<br>
Acked-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Reviewed-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1=
 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 ------------------------=
-<br>
&nbsp;2 files changed, 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 2e3c7c15cb8e..4de074243c4d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -193,7 +193,6 @@ extern int amdgpu_emu_mode;<br>
&nbsp;extern uint amdgpu_smu_memory_pool_size;<br>
&nbsp;extern int amdgpu_smu_pptable_id;<br>
&nbsp;extern uint amdgpu_dc_feature_mask;<br>
-extern uint amdgpu_freesync_vid_mode;<br>
&nbsp;extern uint amdgpu_dc_debug_mask;<br>
&nbsp;extern uint amdgpu_dc_visual_confirm;<br>
&nbsp;extern uint amdgpu_dm_abm_level;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 0fec81d6a7df..8f7d0f8e57ae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -187,7 +187,6 @@ int amdgpu_mes_kiq;<br>
&nbsp;int amdgpu_noretry =3D -1;<br>
&nbsp;int amdgpu_force_asic_type =3D -1;<br>
&nbsp;int amdgpu_tmz =3D -1; /* auto */<br>
-uint amdgpu_freesync_vid_mode;<br>
&nbsp;int amdgpu_reset_method =3D -1; /* auto */<br>
&nbsp;int amdgpu_num_kcq =3D -1;<br>
&nbsp;int amdgpu_smartshift_bias;<br>
@@ -885,32 +884,6 @@ module_param_named(backlight, amdgpu_backlight, bint, =
0444);<br>
&nbsp;MODULE_PARM_DESC(tmz, &quot;Enable TMZ feature (-1 =3D auto (default)=
, 0 =3D off, 1 =3D on)&quot;);<br>
&nbsp;module_param_named(tmz, amdgpu_tmz, int, 0444);<br>
&nbsp;<br>
-/**<br>
- * DOC: freesync_video (uint)<br>
- * Enable the optimization to adjust front porch timing to achieve seamles=
s<br>
- * mode change experience when setting a freesync supported mode for which=
 full<br>
- * modeset is not needed.<br>
- *<br>
- * The Display Core will add a set of modes derived from the base FreeSync=
<br>
- * video mode into the corresponding connector's mode list based on common=
ly<br>
- * used refresh rates and VRR range of the connected display, when users e=
nable<br>
- * this feature. From the userspace perspective, they can see a seamless m=
ode<br>
- * change experience when the change between different refresh rates under=
 the<br>
- * same resolution. Additionally, userspace applications such as Video pla=
yback<br>
- * can read this modeset list and change the refresh rate based on the vid=
eo<br>
- * frame rate. Finally, the userspace can also derive an appropriate mode =
for a<br>
- * particular refresh rate based on the FreeSync Mode and add it to the<br=
>
- * connector's mode list.<br>
- *<br>
- * Note: This is an experimental feature.<br>
- *<br>
- * The default value: 0 (off).<br>
- */<br>
-MODULE_PARM_DESC(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freesync_video,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Enable freesync modesetting opt=
imization feature (0 =3D off (default), 1 =3D on)&quot;);<br>
-module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);<=
br>
-<br>
&nbsp;/**<br>
&nbsp; * DOC: reset_method (int)<br>
&nbsp; * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mode0=
, 2 =3D mode1, 3 =3D mode2, 4 =3D baco)<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52841CC92CF63A180A014C348B12ACH0PR12MB5284namp_--
