Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A16C4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249D810EE83;
	Thu,  1 Feb 2024 14:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NAB5/61";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914B310EE83
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 14:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmelkP7/5fc9dK5tpQULP1ooJkZFQTY5Zg0XbSxpwQj6ZDm5w2Aah3jxxk6S9PQKt9tS3u8vTgiWjkixEtkaM+bzcJv6udpqiNEeFTe1X7p3oZ4R025e6iwOan4ZGcfRGKIkdX/5CvqleKmcNr/+Rrq9lLBqLr2uEBEB0rPWn9yVXqtQnllE82WD94Rj9V1oChzU5Slh1qsvS0UH45udPrEs0L+U4X5k3mUbRd1Vf/6ESi4kDarZWpWM8PKa6U36T2gP7OJNMkuRbzNv/hPoECpxCb2lOn9kQAsiSkDDEB8WfUUcAfFA5vGd2gE07pAVuw7GfXiE0nLUi7IhKtNSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYbXs304S5HpdIBRKKQqOUkj6ITbG5McJUj3sehbyt8=;
 b=Hv5jbB6xnaOQ737hhFxmFwF6357WVShwrNuwPmaq8kViGsd+KmG7HqZV5hY+VGNLGX7iHxfNyNRyBMFhq9V6QHmSa+f6u3OWh4nvZijnh1aAfG2em5pgWf/Y1kCgrxDkvNBRWYR/lEugdmoFODnXRshF24Yot9xEd6fCOxoqDfGjxGHZJJdxTaQUBAnVixTaXBFxIw7682isVB6dPEuDuAo62JV0mJStZX491PeaDazcQVGDuARjLVbvxvcRU29Lomn3hooNMR29lLO1ZdSw6vDYwP5+MpNIxSihINicTJXOcaZQVTEEa2oZfjnldJnjIChRe7GNu/4biGt9DrZn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYbXs304S5HpdIBRKKQqOUkj6ITbG5McJUj3sehbyt8=;
 b=3NAB5/616n8JWN7wAQDQ7jhVjgcOF+1FTJJ0ihrN8DiIq539vkjI/ScE6OsZ3Ght4IwM4WFbiDL30A8vsimJzXp7aL/+KviYIjFfocMPdLlbu9+n2jaVN49mUcLayxOK/VS2OJU/i/B1ZaUJCwQ+hLtYdUSB8ZSSPyInUdj78QU=
Received: from DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 14:23:50 +0000
Received: from DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f]) by DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f%5]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 14:23:50 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sun,
 Yongqiang" <Yongqiang.Sun@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Fix 'panel_cntl' could be null in
 'dcn21_set_backlight_level()'
Thread-Topic: [PATCH v3] drm/amd/display: Fix 'panel_cntl' could be null in
 'dcn21_set_backlight_level()'
Thread-Index: AQHaVPU8B5WOetQEGkS1+MjrkzaWh7D1ieuA
Date: Thu, 1 Feb 2024 14:23:50 +0000
Message-ID: <DM6PR12MB4545AAAFC85402924E2F78F7F3432@DM6PR12MB4545.namprd12.prod.outlook.com>
References: <20240131030412.692179-1-srinivasan.shanmugam@amd.com>
 <20240201095712.1171428-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240201095712.1171428-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=67f38f7b-39fe-481b-8f08-634b47c90005;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T14:21:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4545:EE_|MW6PR12MB8958:EE_
x-ms-office365-filtering-correlation-id: d3e38ba3-15ed-495b-db62-08dc233168fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFZlgPzF++9GBsXMwTKgBig60J9pdiZs0XuwB/osOW5Ymp/W46O1RKvfbf3Nj+Qq1g0pM8X67vw4UPbylkdwPfyZ9Te2wLk3syEqYxD06eZkgt4Oct8kMTDmI9ddqykRG53j0WXfUFyjfjHQobMZ1g4axYAeLsGa7wopCCqGQXH43chfIgC5oL2erN+ScYnl+9WQnLLklYvntXqimdG8fdvPIGOeSiA0HeH2g+YfUpFLOVI4QHxL+VLWEnmSUEl+lPzjOiYgUABpXECNgWIXFfNf/lixAzqIFebH/8io3KIbuPHGaL4VyWKxYge2BcL3ZY+fOsX+NUpjLoT44ou51cwjWTSglhnMmJ9AaMGpd7XVKYvxQ/L+gid8LHFSpe4XvSQpVaDqrNArlPedaoDyMWwo39PytS03EHe382P7MkOww2e7T0yYwGqOTjwIfL8gspFI3zDfMEzq6zDpWIBVUhlJT+OkiQ5Nzv98oOPzQ7+k7DP8UcwbGr8+oVilGhpNsoB/6AuDhaueCWUFB0hJkuV3OYnE9jU2Bfcg11CVkx+rPEEGIKZy+TKBaj7bAIShDg4+QSA7ixYmlHJ1u0zo68CW/ub8GDjWeXZ3ldYsjuSSUcTkDDEby/xYCMhaffwk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4545.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33656002)(55016003)(86362001)(53546011)(9686003)(478600001)(38070700009)(83380400001)(26005)(38100700002)(5660300002)(2906002)(316002)(66556008)(4326008)(66446008)(64756008)(54906003)(6636002)(71200400001)(6506007)(7696005)(52536014)(66946007)(8676002)(122000001)(8936002)(76116006)(110136005)(66476007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kK9TKXi1G11WuHblYFC4z4TAPvdTmHD2DBQYwbPFgFk2PxzBGkA1N37LCWLF?=
 =?us-ascii?Q?kktLYsBoSR7b5MVpn9YBCtA/zOXXqeU1pyrkldExkjWz0DHJJ6vH74trsvBi?=
 =?us-ascii?Q?stw+jr5VJJcCn2Ju5/LdTJv+xzWIkUg6x3/XQBYgYhvmTzJ6ol3I9cy7EAC+?=
 =?us-ascii?Q?2b7Iz1AlNgZqcjxHtntiZpry5lubsS7SUXy58zfSyUwA6li+Qcdj/ApawFE3?=
 =?us-ascii?Q?XG0StFRzGQkhlOLWDvnI5Tal1+8UJeXsDMbEw2qBAlms7tskkq5oklmIQBvw?=
 =?us-ascii?Q?Ne77cHoWC1v2TcYaOII0B2Xc9EBLWD1n6UJMAQyXqf5mc99SO5+xjC9pKXd0?=
 =?us-ascii?Q?nEA1Ri7OZ/AsoI7MOgrF/5M0Qp5n9NC2cq0CQgqxlOfJShgqR4tUqIofAOSa?=
 =?us-ascii?Q?0SsxalMMAJ9hwZN18Gqtxhh2OVxnqhC7mwX2C4e88pKuURM3NvMnoZJl1mKA?=
 =?us-ascii?Q?OzKlsOHDN5gilizSjW2bFqN0T1bINam4ZVRZxXt2VSMgSYK0FPETjlNA8QwL?=
 =?us-ascii?Q?XeVZp+fsinwZuhQOnK8VaHJuNSu0x9iW9z1D/R6rheeIlojuMD+Bjih7qR7n?=
 =?us-ascii?Q?Xf5PqQrUPdXj7HREfscaVwW/u2maAB2pLX9ZefuuMB2T57uNR1JIw8I2ZM6R?=
 =?us-ascii?Q?LfAfCondZQGD4Jt/O1JppysAOAn/uiK7WGUWFbM/PlGqNgSqCDbVNOyIfEjs?=
 =?us-ascii?Q?spn+LWqUhmyqDp4wHTu3bi9qGCJvVt/CtaO8u8wy8xEZ6ZNSYqZFsDdCaZi3?=
 =?us-ascii?Q?vc0Cj4yN/Pq/5WwbVEnaSOb7UfM7GpOeNZuixHfR5wwZ8HLI4mjOCknHs3p+?=
 =?us-ascii?Q?jlY0EmvZOZ1nIdMvJVJGKcG+he/c4tlm20OpOQxQzqzhdV44YwYtMXMsUH3H?=
 =?us-ascii?Q?Ga8EBed+zutW+SZnDI0UZ79BalSn8NXlMAF72gdujREIAGkgc8HyiA1UBgOU?=
 =?us-ascii?Q?9wpbTiBY4kx7SJzR8WsS7+o2uPgux3FhbCr8GFk5+jdgP8yPodwDrtEn+/5f?=
 =?us-ascii?Q?8d6AavAJF5anJSobU6A/9ni4VcoiOPLD+wFVbink1RByr5QZIQltWNPSi5pp?=
 =?us-ascii?Q?5WDaHXiQY3gRKDNmvuX2zLFwuTyCvxaS66KyrzeZfqOB5Z779qWvGWrtl9MU?=
 =?us-ascii?Q?M2bElKot0xP+UTYOo9DAbakePJIkRlcaUQXJKAJsxmy9mXUHDFhtPR8aaJ6T?=
 =?us-ascii?Q?/hXBCvzbs4qRjt1kJ0tKWTseSEnYm2y/gzSGUyBDacpL7zVqgxtA9018WANo?=
 =?us-ascii?Q?2EikvxjJStBOLNNPpFtLa1NqX1nbkj1BFOsmo7Izmr8Tqfkr3zzFgDeJtCaB?=
 =?us-ascii?Q?gYh6wkPQ/3T8qkyLAhmQdD29C4BT0YglJQ9tUfM4fVV/uShC0IpmPD4rlb29?=
 =?us-ascii?Q?y6cFfOEGtRsvROZHzpTITiGiWHe7qjrld1pec1u3N3vWzvpxMbCkDaMEDOdS?=
 =?us-ascii?Q?tbwKJvaV28dwmBlIHUiqwCpR+FUhhKa9zEZuA4l4zcyLIdENE+Io0pMe6Osf?=
 =?us-ascii?Q?rbXYHjzDxFBzcNXWRVox3iUuL53zd8GLi3oCocJuO2AbwwkGIoKpNQyH8LUM?=
 =?us-ascii?Q?RklGIkifQyX3C+BmWyw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4545.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e38ba3-15ed-495b-db62-08dc233168fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 14:23:50.1463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRIC/jeVOq2ynwfE7As/4eZwmEnS96WVRousZRDhdLS3Z1uHpTd7OxC9NgMRMHAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
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

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>

Thanks,
Anthony

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, February 1, 2024 4:57 AM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>; Koo, Anthony <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix 'panel_cntl' could be null in 'dcn=
21_set_backlight_level()'

'panel_cntl' structure used to control the display panel could be null, der=
eferencing it could lead to a null pointer access.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn21/dcn21_hwseq.c:269 dcn21=
_set_backlight_level() error: we previously assumed 'panel_cntl' could be n=
ull (see line 250)

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm cal=
l backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v3:
 - s/u32/uint32_t for consistency (Anthony)

 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8323077bba15..5c7f380a84f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -241,34 +241,35 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_=
ctx,  {
        struct dc_context *dc =3D pipe_ctx->stream->ctx;
        struct abm *abm =3D pipe_ctx->stream_res.abm;
+       struct timing_generator *tg =3D pipe_ctx->stream_res.tg;
        struct panel_cntl *panel_cntl =3D pipe_ctx->stream->link->panel_cnt=
l;
+       uint32_t otg_inst;
+
+       if (!abm && !tg && !panel_cntl)
+               return false;
+
+       otg_inst =3D tg->inst;

        if (dc->dc->res_pool->dmcu) {
                dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, =
frame_ramp);
                return true;
        }

-       if (abm !=3D NULL) {
-               uint32_t otg_inst =3D pipe_ctx->stream_res.tg->inst;
-
-               if (abm && panel_cntl) {
-                       if (abm->funcs && abm->funcs->set_pipe_ex) {
-                               abm->funcs->set_pipe_ex(abm,
-                                               otg_inst,
-                                               SET_ABM_PIPE_NORMAL,
-                                               panel_cntl->inst,
-                                               panel_cntl->pwrseq_inst);
-                       } else {
-                                       dmub_abm_set_pipe(abm,
-                                                       otg_inst,
-                                                       SET_ABM_PIPE_NORMAL=
,
-                                                       panel_cntl->inst,
-                                                       panel_cntl->pwrseq_=
inst);
-                       }
-               }
+       if (abm->funcs && abm->funcs->set_pipe_ex) {
+               abm->funcs->set_pipe_ex(abm,
+                                       otg_inst,
+                                       SET_ABM_PIPE_NORMAL,
+                                       panel_cntl->inst,
+                                       panel_cntl->pwrseq_inst);
+       } else {
+               dmub_abm_set_pipe(abm,
+                                 otg_inst,
+                                 SET_ABM_PIPE_NORMAL,
+                                 panel_cntl->inst,
+                                 panel_cntl->pwrseq_inst);
        }

-       if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+       if (abm->funcs && abm->funcs->set_backlight_level_pwm)
                abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_=
16,
                        frame_ramp, 0, panel_cntl->inst);
        else
--
2.34.1

