Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24224C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9CA10EE87;
	Thu,  1 Feb 2024 14:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K1//PQ5j";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A6410EE86
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 14:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJOLuHa3tWKKfdM9pNmeHRuTO4zfkI+dEB9VGftHKe0gu13sVDnCOh0tMIanRktrh/WBFhaXsmp7QoHQnKrtbbipqkbH6sOj3nXo1hWYWfGISZBrUMnNzwnnPr7IY6fc1LKG+k1IoHDIZDKzSyAnr9gqimH/NIn2SJH/RjvpQuOfnOAglWQJ571RSk0TLgyvwT80IUVoLzlIzCTyx6n/0SSP3MomBi+pp7ZARhYo8jgj0wj6IdIqvEIqt6yyScWMeKPMfzSYpGrK1EHV4FjLPmq0qT08X65SDpz+3/4XSaG8TAn4XxN++Apwzv1/jRDIIkUGdWJevvNN3vfZ6yZRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeN3z2rLI/Qh2dKp8BJRZTq7zXAii5/zZqDrb9qEz9w=;
 b=aw2SoF+gvKiA8Pmy54XN+QXxo0BispgaKQrihjwCgohChG1hBjZZEFwFaDbkrw5xTowg3XS9Jsp8r0w9hpNd67dOYY6fQbrM91Nm/GFaQCWOXGR8REKbAwt1Buvwm2dtvUKVPzuxgc/1Lt/WFFq6gXzd4ky0Pz8yOlu8Kc6QB7xrHbmUSbLiai1+Be+BeTpb2Y7rn5cVSEuL1z4YKHybCjhnSH4Fjes2/f446OQXA/cOUztthZ7knCxaZ2wgV5mjFfqEzCm7lmHAPJKOt+pNEmq23LMQC0bn7G08N+SrBCBEYu6vxR5CUVESrA0AmBF8xv/Jks2kIFUSoEP2nCHQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeN3z2rLI/Qh2dKp8BJRZTq7zXAii5/zZqDrb9qEz9w=;
 b=K1//PQ5jg9OBrl+FGoKEBCRyB4xIEQMa98i5ARgE37ZMXzI8NlYrNOZTJSQ3pcX4Px7ToSxeX2XSX6aFLYXhvM3NeibgThg1QK24dWAnjQey9EyiOLnVsJAeBa6VvAMHE9303hDATv7N28wJFmDa+ArKErDbu58mYQqCKi/PurE=
Received: from DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 14:23:51 +0000
Received: from DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f]) by DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f%5]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 14:23:51 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sun,
 Yongqiang" <Yongqiang.Sun@amd.com>
Subject: RE: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator'
 in 'dcn21_set_pipe()'
Thread-Topic: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator'
 in 'dcn21_set_pipe()'
Thread-Index: AQHaVPVIUwReDeFdvU2wAhDnPiimmrD1iilQ
Date: Thu, 1 Feb 2024 14:23:51 +0000
Message-ID: <DM6PR12MB45457C77838BEEA41DA40010F3432@DM6PR12MB4545.namprd12.prod.outlook.com>
References: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
 <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7be6d1c9-3ea6-4d45-ac09-36ea767e5f28;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T14:22:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4545:EE_|MW6PR12MB8958:EE_
x-ms-office365-filtering-correlation-id: 51764757-e299-4586-63f8-08dc233169ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihyOCRSuVIGnp2P21WTcca+j+6ZQotbKVUnWsx8Hp0/uLpLvwjLkFI4Vy8e4LqHCY5+LgaweKx2aXwTu5Cw5FV7QUsVPFrKVidAxlNIo+js6Mhg5NRLEq0cXCf/pEDqpbKJmBZS6jUPmVgJaYYBkuKBfBXV1kQwHrcC7jvWWbzfGz2P/Z3iW7GPUN9v4k5EqTKAws1W5+XhCvdrtq7Pl/BpcXA8PdscFk36mm03Mul7PU85p+V9ta6l8gnX33/C38mVAXn72NtPmkzzDBa+YO4pQQlG88E8ufSL5hSZG61HCy/asEwnzRKAOgRK3cmW1iuOhmednG+Fh+swj9PwmVFjbF0ZYwxgQnFFzK1KfCnz8a59dXmkWHjxTHHWdFs9uyzGGP/RomKc5D904+XZ4WSWhshhaxakajqBFa6ECTfqyANU34mDiOkzue+RnuxWgnukBSQmKQfLrCt/iKeEKp559ss0/wAeW7EMrzLgfiyU/9XSz1aaw8ckO0guWbOEWoIf5EaFBYTC6tfwClyfI25SiQAV3a9pkPUeBAFqiu1g4gGbEurCMJEThuNhI3deuphBboAPUOq9OEq+v/FVZrQiK0+dLYkm1E1HXmSSXXMXJD7Ukj7t2sS/K6YZwc20U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4545.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33656002)(55016003)(86362001)(53546011)(9686003)(478600001)(38070700009)(83380400001)(26005)(38100700002)(5660300002)(2906002)(316002)(66556008)(4326008)(66446008)(64756008)(54906003)(6636002)(71200400001)(6506007)(7696005)(52536014)(66946007)(8676002)(122000001)(8936002)(76116006)(110136005)(66476007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lmlAiu0t/ihuGW2VmtpvkRc+npf+2SSegdRWa6wgFF5xGDBaQSFnzkoVF2KF?=
 =?us-ascii?Q?jZ7+rcA+aeV5b5KdZwEYpnX6W7oXidfHzfEXPoYEbul8ST7Bal2fYao56l+V?=
 =?us-ascii?Q?SU0KpBVuEL9aDtmuYsOXtMKoT6wepbJdW88PZZjCvv+BjFAN4JJyNNU8motf?=
 =?us-ascii?Q?BxJOO9fX+sZ1sUvMuXQjgAW4+ypQbXJgOrzwt26zZbPCjhn4qMiJyQflofaz?=
 =?us-ascii?Q?CR1r8kZC552GL84lvEVsxKXq/kdsTRQgm7ml5ICFBjYhvSFETP/xWPoiVvXQ?=
 =?us-ascii?Q?EcSOEcXLhauHzmcbo/xxXfrsNVSuPOSqQGgb6X/kSslNI71epgAzb1YVgsok?=
 =?us-ascii?Q?JZ/41tr6kktu/bYimlGsH+u+lMzS5nanZnziFmm35kG5KWKwQ5oV/4+sTRfU?=
 =?us-ascii?Q?OGQFoG9pinQCGCn79jnbIVHouXs4fM6XymAfIJ8Bx1ueW5sGks6BBTtno/pN?=
 =?us-ascii?Q?H7MbdVU/Js4YlvvRYUwU4/n30TWEPis+G6702kaQ5vYg2fP8KzH4scsWIth2?=
 =?us-ascii?Q?82ihEG1USb3ax8YOpTlFGUk55uVK2l2c2vS5kg5zLKY3kmlxCJzgLBlXhufY?=
 =?us-ascii?Q?qtjQre7F8LtgB6j2aarVPP3Ho7YRNBZm7VLWts+l1F+i+XoNS2ow5S4mc7AG?=
 =?us-ascii?Q?YHANFhpC7C1SdNxHU69ndf6vD+D87JNrtV3W+ulkZ+Mb3aN80S4kfO81SfmP?=
 =?us-ascii?Q?f3D0FQMYTvP6GEOdJCzPGmEh4BgaHyzTPTU0QPSb1UTSvBwLXUNMDd8HGMEQ?=
 =?us-ascii?Q?THL6taT+wQNLb4LN4ivd923j5CPBu/6dvMH6W7OltZEXFR3FTwoeW9kNSpIj?=
 =?us-ascii?Q?QbbpUyXSQ0HdGBVorhZdwKNRZoI0FH96Nj0q/ycmtHVUWIxoI2vVxkpQnBQ3?=
 =?us-ascii?Q?XtX/d5cC3KEmBxfdOl4voNeWgjVk31qHeauV8ivAAFMZsPhQi3JizVoR1rD4?=
 =?us-ascii?Q?yaBSkE45ht4V5Mfgud+D4Bn122ZQztaO7DL4pS5h/nli1cZ4a+vJ/MuiUGrS?=
 =?us-ascii?Q?AQUJJgdD2waMrZFtdeMawiz1NFwvzb3Up4jnyjqI+SK3xPYaYuCHMw8aNID6?=
 =?us-ascii?Q?yQmli+ulz/8dgI4yrvD4CoJq0po8wEra4h1ha7NapaFDc0yLV5sGk3gyH4Ma?=
 =?us-ascii?Q?HhZkebbIyqbVeN8YFsIwMSA2r27ODGZG2d+BGZ7gUtCY51q5Dou1OJ5TckOe?=
 =?us-ascii?Q?rbhDNO/7ZvVB4UIcJaR6YJ7AUPtF2S+cngEkSzSV9LPmwyWxcRnSjrMxUhZj?=
 =?us-ascii?Q?wLI+9IylEY9mbW9sYecUCP9537RNPMCUrjgelyXa8Uor6miHT8SyiKlL66kR?=
 =?us-ascii?Q?Z1E2avxBlKYvayvbyt6zmLKqg1Ren357jrdQQ7DLuS7dLr2cAE9VUnRU+lt8?=
 =?us-ascii?Q?FGSylKb4QQfU6gWAn73LTEfNX1D7zmzdVg4C+rEGz+yhv6Cp+ErFZvKtaVQU?=
 =?us-ascii?Q?wtnBmZtGfV/AdQrFYqaDuNJu34XiUcE6cYuEoV33SmZG5/x3H4MiMUBZOILQ?=
 =?us-ascii?Q?HBRA6Y8n5k0EVQCbwnvWATp0apMzUz/Fi1cTQhbGUrykTyCYS4L+EfZhLzP5?=
 =?us-ascii?Q?5NaHdTark5G3+TJKDUQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4545.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51764757-e299-4586-63f8-08dc233169ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 14:23:51.7996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HnHn6ALkdjL58tG/Iu6Vy9RS4QPMHinxfVf3fWjhNuVsj2P8sh1NlqrhrhhxcNI
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
Sent: Thursday, February 1, 2024 4:59 AM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>; Koo, Anthony <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.com>
Subject: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator' i=
n 'dcn21_set_pipe()'

In "u32 otg_inst =3D pipe_ctx->stream_res.tg->inst;"
pipe_ctx->stream_res.tg could be NULL, it is relying on the caller to ensur=
e the tg is not NULL.

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm cal=
l backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - s/u32/uint32_t for consistency (Anthony)

 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..8323077bba15 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -206,28 +206,32 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx =
*pipe_ctx)  void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)  {
        struct abm *abm =3D pipe_ctx->stream_res.abm;
-       uint32_t otg_inst =3D pipe_ctx->stream_res.tg->inst;
+       struct timing_generator *tg =3D pipe_ctx->stream_res.tg;
        struct panel_cntl *panel_cntl =3D pipe_ctx->stream->link->panel_cnt=
l;
        struct dmcu *dmcu =3D pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+       uint32_t otg_inst;
+
+       if (!abm && !tg && !panel_cntl)
+               return;
+
+       otg_inst =3D tg->inst;

        if (dmcu) {
                dce110_set_pipe(pipe_ctx);
                return;
        }

-       if (abm && panel_cntl) {
-               if (abm->funcs && abm->funcs->set_pipe_ex) {
-                       abm->funcs->set_pipe_ex(abm,
+       if (abm->funcs && abm->funcs->set_pipe_ex) {
+               abm->funcs->set_pipe_ex(abm,
                                        otg_inst,
                                        SET_ABM_PIPE_NORMAL,
                                        panel_cntl->inst,
                                        panel_cntl->pwrseq_inst);
-               } else {
-                               dmub_abm_set_pipe(abm, otg_inst,
-                                               SET_ABM_PIPE_NORMAL,
-                                               panel_cntl->inst,
-                                               panel_cntl->pwrseq_inst);
-               }
+       } else {
+               dmub_abm_set_pipe(abm, otg_inst,
+                                 SET_ABM_PIPE_NORMAL,
+                                 panel_cntl->inst,
+                                 panel_cntl->pwrseq_inst);
        }
 }

--
2.34.1

