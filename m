Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06194C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 15:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A7610E133;
	Wed, 15 Feb 2023 15:30:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E36810E133
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 15:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g234lNKt5/Chgs9dHDVDVHw3STHydagfeuX6csuDNOvdDbUMsKdbk+OhFkMzSYKnrUcNLS72bXPUO0uhjX0T88lRNHgIKmnlRKZtOWUdjj4q/YO7qLtfcIdL44Tb49ZKRWPPma8D/4jS14Cjf1SoeOyCElRs7YAKBrTjlecuL6gl224Q8OAQFWdPj+eNpIcowinNhykKi9Mv9s6n9wPSvjCd1dXz5eX5bSAxqirFaOFmM4gLwJVENj6kh1SePURv0MZkj5AQEXSDDRcftGGgEIrfh4/qUwF9ZAOwptGSTpB4MQJ61RIMxtdzFDTeriqChVfK99ot7NnwOf/4fqcPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aoh9r8u6Qrpj7CUWMRw8v8jcxkGeBKuVtpf+ZRqMD9w=;
 b=EttQPS+z3p2TKj+i4gbivIIZHe2pmUEDJDADibs3OSEXyLAB2aBJx9lpVQ6RbHNUQQmqKS+NwyHic0RRDJruWiyrPtG+SsLDXZAv+wrn5Fk4PnBkA5y3w/82ARK6zgonC8rfdBpoJ+cajHLe3LJiqDQxR3OaqDVp1zqlZmaDegejHpqv0HqY4Nv96oYqg9O4WaXy2sKxpXaLWoeo7OI5bgbdYE7/xuxXoFnHAEycUU95WCvS9if9j5J9+e2T0pwT2MrPdreUGvrBWDLpzgw8JwXjSDTIDVmwwiJW93xdO4NB0UG+Q3WSaeeuCsKuaZxdbnmr6KphYMkgKxLjv4G8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aoh9r8u6Qrpj7CUWMRw8v8jcxkGeBKuVtpf+ZRqMD9w=;
 b=LhNk7NE6gJ6FGM1Mxrsh+8JeCfBRF87SiXYnZtF4/CWV6zcAGGzmLz4wksgorFqHY40Ng7KqZWvbKeacdhWOyovFyi6KhVe5wuQpb1Hfse0E9DuNXvXnTlvDZXsonvhRZYLqqmA8Fypu/61SJT7NJGO724H3zQzPSnivX7NXSzg=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 15:29:59 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6947:fb51:bf73:b72e]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6947:fb51:bf73:b72e%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 15:29:59 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amd/display: enable DPG when disabling plane
 for phantom pipe"
Thread-Topic: [PATCH] Revert "drm/amd/display: enable DPG when disabling plane
 for phantom pipe"
Thread-Index: AQHZQRCjv3R8YsZqPkyWfwsWZMxUOq7QIlTj
Date: Wed, 15 Feb 2023 15:29:58 +0000
Message-ID: <CH0PR12MB52849C61F76FA089F777C1AC8BA39@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230215073730.7630-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230215073730.7630-1-qingqing.zhuo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-15T15:29:58.256Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|BY5PR12MB4084:EE_
x-ms-office365-filtering-correlation-id: 576699a8-0068-4fe7-aefb-08db0f697f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkxZ9AjaLUpbHdt+TU1M2DEj5KIk1Pj5HzdM8JExRvkuzTS5Sd4E4EUtCx5qTbjV71kOpjzLeBMEPlZNrHmLU+gkQYQZalqN3CpV3R2T6p52wBNWFbvIQnAoEo7MDIbtB9f1YHX6fKxmAREJAfVQFFe+sAJn5sbFyM1OgLBUevKIvGzCI6mpvS+PutQLAYZ5caeQ1Y7C5WgJnbN+1U83KJZ9IzvmSpAL+Kb9Gb91tZ5UgHevNRceD1HeDT0xVyAqkIYTm5jbyb4WZSfNWYQ+i1ckdDgYAM6cCN84sf2KvvWZXm/LiIAWyK6i4tk7MiwGQvsni5JAaCEKugBHh+iM4j30YopYS+mrQjhLaXDxHfk0j216fTboh2qUSS65tH+UP7Ig5ePKRbpioflrQLv8Le0eYMt7B9RgeAiEe+fVhNkwU/ADDbA2Ew9Q5QcwzSVl05ZYK4fGS6fvcPqXSn3N1d34PxNqRic7kQy60Frh/Q3igjqaggV6pvvFaVfcqdYLXdbKkxRUfTDerPX+2LEl3MHGmtVX7NTClMa5ggn41uRfbssTWWihYyVJ5PQ0jkP11yJCn3FJ9h17jrGZbD11S8Ja2M7HJIjrCtjAHduTRakAl1UyCaYZD/cACFPPqYkBeuXTU0Ut5//euC08BloElj3Vnpw+HwA5s+ABuBKqaZdr+r40+gX/om4BKfnLz5jIXjGwic1rWtB05Tf86IP6Lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(38100700002)(122000001)(86362001)(33656002)(55016003)(38070700005)(66446008)(8676002)(64756008)(4326008)(66476007)(76116006)(66946007)(52536014)(91956017)(66556008)(41300700001)(110136005)(54906003)(316002)(5660300002)(8936002)(2906002)(83380400001)(478600001)(71200400001)(7696005)(53546011)(186003)(9686003)(26005)(6506007)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gsTUpnP4Ia8Zzdq+WYZhUTdaxnuxUp9aEK/AkzXQTS5r/kDi6lBHJ0StrS5X?=
 =?us-ascii?Q?hsyQWyCvxgmXv/g/2BpYpWy1tnU+TKbhQqLjogm0BFUAxMSV2fBIAgSXMc24?=
 =?us-ascii?Q?MOPFHMWu8+4Ernjmvm1GmK5x79NYNNSzvKSRa3unD8jZ1QuIkUajtnzVkBOT?=
 =?us-ascii?Q?f8N/jsLGa/7pdZkL1k0xSXF5wy6JUhslYWGUe+QTe5jZfC9c2m1yLJNnPZRv?=
 =?us-ascii?Q?5YB61VC/cNalD5RF+qf07C4bpB7WdoEUq/ReXDDVLtsFL8dHIbIjfLkG4q+n?=
 =?us-ascii?Q?FRtYoXEHlOXZkPLj6K/iGWg/bV8146Zh+MgFe8vJ+NJX2u2PJYWpN2G1l6en?=
 =?us-ascii?Q?/6pMKlrUl1pE67RJOZWJ5zrC+ROKM9o9iLZMwwBWaJc/Jeh6lUWE0jotqPSX?=
 =?us-ascii?Q?Ebk7QUB1cqeIgWyWxfu/wLDBsMms1E3nCdAmjX6FGLyNi9SDyhwTXEqOd5aY?=
 =?us-ascii?Q?3fKYa2dO/mi8vmIBt3mrCVmDxpI1BUDXSveNtFhfK3ljp+aPD9pbbZ36iY/N?=
 =?us-ascii?Q?vvn/wMa+d9cCSPQc7ryjuZBA4mi4uUFachp35RdpNthwOaL5fmHrkD+nmHNh?=
 =?us-ascii?Q?DvIDvJswIyrAr27huOnYy9DJJb2uXmoSgl/FoODDCNaSxKSPpGH29QmhXS93?=
 =?us-ascii?Q?kdzuZGBtap6OdVrCoskxs5OV+5eNrW/mdIPFmUxqoPLVmH9Ya2Fxeu7GmGGs?=
 =?us-ascii?Q?IGVBfX7Ia3aPem/wuYx5MOVDERIEzfrBXn4sGj3HEad2681rzHh+25MpTuuq?=
 =?us-ascii?Q?Vgrt6laMXCLPbIOJudpat5znwYuSxPyOEK9Kg1UpCu/OVLHPuCNoYVnkD63p?=
 =?us-ascii?Q?SFgs3Ycq5z1PUPZ5QwlF7Smx6Sy6WtskdJA4R1q9I3kC0Wwt3/X1iPX2aotj?=
 =?us-ascii?Q?TS/0PbNi4EMVwqwdJ5NoBkLp+aTUKOpeDS38QmHghhn9sMgR5r46SEp153OK?=
 =?us-ascii?Q?sXmrkASV6wAAjanPLKnec8hjGrYzIC7fWGkjg6/ay6b6Rym1SFawVmJlG3yk?=
 =?us-ascii?Q?AEZ+taazIvLiA67PCb5TvoRlc0OptsCp0GGQUzrDYncBUpq5XWlCJmQsJh1z?=
 =?us-ascii?Q?VKmL6RRE0UjrmMLBQOAzg0sJtarqx1+spPutulkGem0BHED8LRIchCJFkb9H?=
 =?us-ascii?Q?oLeJV0tgYADilc1hfbxfBqWn0TOVHdZjo1KnAsdh9H7ZiWUMOSYCUNjIyvGc?=
 =?us-ascii?Q?i1P329XSM5k5VUxnr5o0GdW9IKPAa2lPJVaauXHEaaV/koikXxDykRvjKuqs?=
 =?us-ascii?Q?nviju5O0YDaysL/LYaLxdLTCzb7APEztSBmeFjifNw1DmPSRl+TxP4n/qB2B?=
 =?us-ascii?Q?K6A+Qo7j3RUOTbdBfhentpL+FIee12ge/rdWF3Df0qNpw7RMCi1A7NwatgmM?=
 =?us-ascii?Q?dNiRqyK3I87yE0a1HeueMF9U/sOjN3tFtRMNdFeZMQWrkNmAJemy3abbGs2A?=
 =?us-ascii?Q?tYvzMg+I060UEKksa3ZSWujx3Vz+1EemCO0ywqrS24m8cjsbiwxzJeUafom+?=
 =?us-ascii?Q?FB6d46g5DfAlRJNW4bX6Gdg5jEuzMr2faC4L54JurNl9R7HEBUu/YX+h+S/2?=
 =?us-ascii?Q?XjVGBVfz221FD+y7zuw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52849C61F76FA089F777C1AC8BA39CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576699a8-0068-4fe7-aefb-08db0f697f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 15:29:58.8260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7fSS2v2h1OtlEFY0isOqvYOB+XT66FkdBrQ9vhlsvOqjUiJ/2xIrm1nq7Dt29uJApov/ufEsikvFg3N63Btvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB52849C61F76FA089F777C1AC8BA39CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Aurabindo
________________________________
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>
Sent: Wednesday, February 15, 2023 2:37 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>
Subject: [PATCH] Revert "drm/amd/display: enable DPG when disabling plane f=
or phantom pipe"

This reverts commit b73cf50bd1d0008027cc1b41881b671d9c9054b9.

regression detected by the change. Revert until
fix is available.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +-----------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index 510661d303e8..1c218c526650 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -74,8 +74,6 @@

 #include "dc_trace.h"

-#include "hw_sequencer_private.h"
-
 #include "dce/dmub_outbox.h"

 #define CTX \
@@ -1059,44 +1057,6 @@ static void apply_ctx_interdependent_lock(struct dc =
*dc, struct dc_state *contex
         }
 }

-static void phantom_pipe_blank(
-               struct dc *dc,
-               struct timing_generator *tg,
-               int width,
-               int height)
-{
-       struct dce_hwseq *hws =3D dc->hwseq;
-       enum dc_color_space color_space;
-       struct tg_color black_color =3D {0};
-       struct output_pixel_processor *opp =3D NULL;
-       uint32_t num_opps, opp_id_src0, opp_id_src1;
-       uint32_t otg_active_width, otg_active_height;
-
-       /* program opp dpg blank color */
-       color_space =3D COLOR_SPACE_SRGB;
-       color_space_to_black_color(dc, color_space, &black_color);
-
-       otg_active_width =3D width;
-       otg_active_height =3D height;
-
-       /* get the OPTC source */
-       tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src=
1);
-       ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
-       opp =3D dc->res_pool->opps[opp_id_src0];
-
-       opp->funcs->opp_set_disp_pattern_generator(
-                       opp,
-                       CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
-                       CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-                       COLOR_DEPTH_UNDEFINED,
-                       &black_color,
-                       otg_active_width,
-                       otg_active_height,
-                       0);
-
-       hws->funcs.wait_for_blank_complete(opp);
-}
-
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context=
)
 {
         int i, j;
@@ -1155,13 +1115,8 @@ static void disable_dangling_plane(struct dc *dc, st=
ruct dc_state *context)
                          * again for different use.
                          */
                         if (old_stream->mall_stream_config.type =3D=3D SUB=
VP_PHANTOM) {
-                               if (tg->funcs->enable_crtc) {
-                                       int main_pipe_width, main_pipe_heig=
ht;
-                                       main_pipe_width =3D old_stream->mal=
l_stream_config.paired_stream->dst.width;
-                                       main_pipe_height =3D old_stream->ma=
ll_stream_config.paired_stream->dst.height;
-                                       phantom_pipe_blank(dc, tg, main_pip=
e_width, main_pipe_height);
+                               if (tg->funcs->enable_crtc)
                                         tg->funcs->enable_crtc(tg);
-                               }
                         }
                         dc_rem_all_planes_for_stream(dc, old_stream, dangl=
ing_context);
                         disable_all_writeback_pipes_for_stream(dc, old_str=
eam, dangling_context);
--
2.34.1


--_000_CH0PR12MB52849C61F76FA089F777C1AC8BA39CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
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
Aurabindo<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhuo, Qingqing (Lilli=
an) &lt;Qingqing.Zhuo@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 15, 2023 2:37 AM<br>
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
;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amd/display: enable DPG when disab=
ling plane for phantom pipe&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit b73cf50bd1d0008027cc1b41881b67=
1d9c9054b9.<br>
<br>
regression detected by the change. Revert until<br>
fix is available.<br>
<br>
Signed-off-by: Qingqing Zhuo &lt;qingqing.zhuo@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +----------------------=
-<br>
&nbsp;1 file changed, 1 insertion(+), 46 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index 510661d303e8..1c218c526650 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -74,8 +74,6 @@<br>
&nbsp;<br>
&nbsp;#include &quot;dc_trace.h&quot;<br>
&nbsp;<br>
-#include &quot;hw_sequencer_private.h&quot;<br>
-<br>
&nbsp;#include &quot;dce/dmub_outbox.h&quot;<br>
&nbsp;<br>
&nbsp;#define CTX \<br>
@@ -1059,44 +1057,6 @@ static void apply_ctx_interdependent_lock(struct dc =
*dc, struct dc_state *contex<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-static void phantom_pipe_blank(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dc *dc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct timing_generator *tg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int width,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int height)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dce_hwseq *hws =3D dc-&gt;hwse=
q;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_color_space color_space;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tg_color black_color =3D {0};<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct output_pixel_processor *opp =
=3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_opps, opp_id_src0, opp_i=
d_src1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t otg_active_width, otg_active=
_height;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* program opp dpg blank color */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; color_space =3D COLOR_SPACE_SRGB;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; color_space_to_black_color(dc, color_=
space, &amp;black_color);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_width =3D width;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_height =3D height;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the OPTC source */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tg-&gt;funcs-&gt;get_optc_source(tg, =
&amp;num_opps, &amp;opp_id_src0, &amp;opp_id_src1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(opp_id_src0 &lt; dc-&gt;res_po=
ol-&gt;res_cap-&gt;num_opp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp =3D dc-&gt;res_pool-&gt;opps[opp_=
id_src0];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp-&gt;funcs-&gt;opp_set_disp_patter=
n_generator(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; opp,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTROLLER_DP_TE=
ST_PATTERN_SOLID_COLOR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CONTROLLER_DP_CO=
LOR_SPACE_UDEFINED,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COLOR_DEPTH_UNDE=
FINED,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;black_color=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_width=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; otg_active_heigh=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hws-&gt;funcs.wait_for_blank_complete=
(opp);<br>
-}<br>
-<br>
&nbsp;static void disable_dangling_plane(struct dc *dc, struct dc_state *co=
ntext)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
@@ -1155,13 +1115,8 @@ static void disable_dangling_plane(struct dc *dc, st=
ruct dc_state *context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * again for different use.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (o=
ld_stream-&gt;mall_stream_config.type =3D=3D SUBVP_PHANTOM) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tg-&gt;funcs-&gt;enable_crtc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; int main_pipe_width, main_pipe_height;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; main_pipe_width =3D old_stream-&gt;mall_stream_config.paired_stream-&g=
t;dst.width;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; main_pipe_height =3D old_stream-&gt;mall_stream_config.paired_stream-&=
gt;dst.height;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tg-&gt;funcs-&gt;enable_crtc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tg-&gt;funcs-&gt;enable_crtc(tg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_re=
m_all_planes_for_stream(dc, old_stream, dangling_context);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disab=
le_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52849C61F76FA089F777C1AC8BA39CH0PR12MB5284namp_--
