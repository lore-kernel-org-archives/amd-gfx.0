Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B4EC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 02:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439C0112EDD;
	Wed, 13 Jul 2022 02:40:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ADB112EDD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 02:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReDrPoBscxd8Dy/J7vxwJTIp04Sb6VOONBo3CvXQXImPFZS861RY9WiwJ2r8R5mhdD9WmYXDTi12r4Ilcxv5CQkhDcNSewH3T+6yrXRTwWFrc2chelIig1hfMTUkU3sQVHJj+oFDpp0GacB4fFNiu9F1VT2/NvaDUbdTa8tZ0UCs5tIYkDiXjVBQ1nNyNsgmFUOUAjcrmJboEmdfsRmxEJkKZI+c+NcYuEEro6VRnpnCIS3O769xqYycIYQtp0kZQjzfjfX4lQZUYLZaPml26eXtDp9tINocGMmaY3I4fGBIHBe9K4dKCpV7Ki2uoBrL4GMArhuWeOcdqagzB+VkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtiBsBAEbyU3d+QDIaWSJgrSzy97Ia2Wg6RXGjBul/Q=;
 b=ZXdCPZ3qU6HbWUKJ88KYtymIZ03wXWUzqWAp4ZEfAAZRejhNcTuOQOpY16K7Lv0uPhrnL7Wljlc7qMkCiDhqTXWWA3iuAwoix4twNsFFVXlks/Ol7KRiu5YXdNxAPDYkFJxMwclOtbFqnVavr9Hvx15I9UreCY9jjhU7iTAJzySeZQqVqRRMh8WImxntpdAlCJANndk5I0sCF1EHpo7v4sICToU/jwtE/0oNkXarW4hmkLIEB6MWFuUVWGKh5BIfn2kSjWfKEd3O4IKGUpyfIMNPMmWP2ikcV5BXa/l3UrB2Ec6bkdIvNaKa0Z2pbZyjh83uB1CmH6QNTYv4W5PNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtiBsBAEbyU3d+QDIaWSJgrSzy97Ia2Wg6RXGjBul/Q=;
 b=I7qtS/sP3C/C1emZAM7670dOolypgHOMd6jErCYUUAc89hkybv+HACvlR6UT4miGo2ItHGUUaa4N6daUbOBaD3p236SOpJ0KqrKoNr59dm0JIBH5HT9Kp8EQzqq3+IagezM6yhWaUfQMD6mpIUh8jjIwumHDKd35sVyiYNiaA5E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 02:40:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%8]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 02:40:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amd/display: attempt to fix the logic in
 commit_planes_for_stream()
Thread-Topic: [PATCH 4/4] drm/amd/display: attempt to fix the logic in
 commit_planes_for_stream()
Thread-Index: AQHYlgIKCmPcemJ/Qkyixv1TUDnxHa17l9SQ
Date: Wed, 13 Jul 2022 02:40:50 +0000
Message-ID: <BN9PR12MB5257E07B128230092A4D2019FC899@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
 <20220712151348.3047904-4-alexander.deucher@amd.com>
In-Reply-To: <20220712151348.3047904-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-13T02:40:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=215d0a15-b55f-4bb8-80a5-07eb9b3e550c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c63da970-5aa9-4000-30b1-08da64791997
x-ms-traffictypediagnostic: CH2PR12MB4956:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVMyEYLtwBbBJC4ngSBs42OzYBCBrW54bzxTysh2YNjPWKIiU71K3Os6Nn4i/tIzeJcu3nUrPRX8xQRAzAAJ2Pzs4K5Vit9wKEoRfloi+LsLqJUZyPSVWqfYqY/gT7Y9/0tuDmG4dZsOebG6ndCBglTgUVGMPiEVV6Xh4gpz0LpNFlURWF/JH1ahy5zQ3MaKwQiCAR8/lNsoIx8o+58NMOPufd8V6dxivCOVQHoAi38YraXPdggXj7qWwKzqIIm64n1pbwsA8CqUccyIyqoiodtqk7nhioSFzI2AU26zeD2ebfG05gdBt2kwKDWyCADRc10ewyf91LRvqicxxKADtWS9aoUKiYcl0uRyZua2gef2WyN8M8rhhnyt/1/Xm6l4gG4WZTex5JRJ+0EnVO+4GRrI85iDvYhJwy7UI4HznMJskT6L85OVJ0TdsFHEI0Z//CONT1+nW6WWVJf6sWxO09T9tFQLcHZZK+Wt6p6tZ+rVYQ3QU6pbuyDiLGintS5m0UVoPtGU6Q4wPjNlqESi6vmmYTw+wFuc68YJY+INL09SeR+soxtrRux1DYVf03fZDXVS3mmVHaHDUTOAdQwBY5dhf3Bemoog3ZgbbgdNBzlvKbt2InoxwddbLp+0gyXnLBvgyz1Bfw3dzGsh/KjA9gMHR3Uvnkj3KH8L/mzmffPnReCAfzcF5GCnMMuw+1wspCoHkS38tRkTumhYAVIaEdNhaz1hx14lAeFnzIinXuuoA2+j8HeGsmT9Day2wmQP1yde5ouf+ttcWXhVPQsKPQw+B+4m3CDSeBg6+HrqEl2Hg0ilsQjb5hak8KP6ESnz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(86362001)(110136005)(2906002)(8936002)(186003)(5660300002)(122000001)(478600001)(52536014)(55016003)(71200400001)(66946007)(66476007)(38070700005)(6506007)(53546011)(7696005)(9686003)(66446008)(316002)(66556008)(38100700002)(64756008)(76116006)(26005)(8676002)(4326008)(83380400001)(33656002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WxAqsmBoOOURN4FaM1ZBQW6GMrzClLCzUnXCHk99tldG7kN5rMUTIofH0loO?=
 =?us-ascii?Q?LBM1GHzEp7PoJtsO40BLJCwiEPS2dY+IA6ixdYTlVT1IJ5Xar8jfgCLbuMBV?=
 =?us-ascii?Q?5aNQoPlVpga7QQNCcZYMeZO+jUSTB7vq/fvdX7wUUVQLWsPJgLV1S2t7SEtF?=
 =?us-ascii?Q?QsvTHXhCbY2DOnNiq9hMo8HcgQXssy0Lk/ajv3YPiDmpq4+hz1hRIJ0zZsaH?=
 =?us-ascii?Q?2w80qFeQUjhuCOhSroVvbCPSYkHUl0juXyWZ+j6DPcVeHH6r6is6BXUuncWq?=
 =?us-ascii?Q?eocfbOZDcBA9pnwhJMBlL7QMAOWxSbJwixfinJqLRAjdD8jsMxwtDpFjFrZp?=
 =?us-ascii?Q?rvcEj6UL9oYSc9Hj3Vn25fNi30kopuEy28MRBa05/gNx6QL0c3zsGUhcHMdO?=
 =?us-ascii?Q?uu4jecrl9P6yfFFWBMJTYMulTDKP8xdUm4KDizhHgofQP+BXgc+PYdOEm0fV?=
 =?us-ascii?Q?QhDrVW09fUX67QWQdP3dBbufbq99LGA2mKjeu0ev7NR8DWymxqQgNdtc+c4V?=
 =?us-ascii?Q?fluj4/nZNStryh5t51x07yCgDjeo5nt+AQRuhp2joQaiD0Kl88lgrLBWTt4N?=
 =?us-ascii?Q?J9Dbb/viptKAAeFSsuQI4wJ2Fy619Tdy0EMgV5wddC+wVCTAotkHG2Ed1dOA?=
 =?us-ascii?Q?cZ/GvhPUC80A23MJApP/Vg4yP5XRsGwHLPtLxMpN53vIm2ljPXqtkm2izmdV?=
 =?us-ascii?Q?Kue4kvbZtZV4lIhvbtOz9E/d4fvjcRyTuG8NRSbUXybJEBOAzsqxFzeB7/No?=
 =?us-ascii?Q?yY6uG9k/RwlvGgWsMmI7JULnVjJhn/++ioe3afdp9mbd2KJJ5Z3UBovE/0Ur?=
 =?us-ascii?Q?9TM8nx+P0GaOP4/x508K3bZk5GZl+fnqfHH9xm9wIRdvEi6Ug5+hxLB5t4Va?=
 =?us-ascii?Q?imvURuXb4N7IYedgOwUpykYd6SxVAto4i7Z6vFtEtBBy5anI5pOhD9Mghz9O?=
 =?us-ascii?Q?uUgcb4e9imgDp1/XhpwA3SXsLzV9n6S+dLc8IWWYqxEAaWKJvFDgNyTAhVaQ?=
 =?us-ascii?Q?W2Be8JpMwSuaAGv3E7s/9El/D4zwrvyTSYrNiRkPwyrXPZqo3giwpeKsqlDJ?=
 =?us-ascii?Q?BrKK5s2IV+lLNarVvgdSRDvBDGXkoxPIAUpZVcRJ9kknfNwkC+9MlkRNbmQY?=
 =?us-ascii?Q?7FcDQeT/coOdl/2FgNtpzfqXnz9WOSvE+LaqJmOyjIwJ8USaJ09gXASD2hAv?=
 =?us-ascii?Q?MnKud7J9MR0W6o7dldlDpfWz7c97YZQ4THMtTNYDJlHWk6yujKQKtnMW6xG9?=
 =?us-ascii?Q?BfFwevAGzIxA5spdj7HTdIjiCX0wTwSv8vHvABkheM6kzfxc1Q8RUMIhMAxZ?=
 =?us-ascii?Q?XwKvYnYUlgPgWr4ZqL9ZJQLYGk7lmYUHd3apbG8I7D0bCPshPQlFok22jR/S?=
 =?us-ascii?Q?skBKa5lMZJ3rUQ6ehadKdzLdvc6bofPYT2+BwtHjDZvNEvZjgWICPqvNhpbN?=
 =?us-ascii?Q?wpBGHrm5NO0sWCVLBPKhTCMrR+JrUp16YjEXhYv1HNyqduNWMQQ17gausGoL?=
 =?us-ascii?Q?iLFMDW5MkBBqQgcNcIPMjPsCYD0kV6KI4aNzWiN5UbHauRXSexdnUlI5BPSG?=
 =?us-ascii?Q?2wn/tSE6NJEVY7HGDNTjsBCOK9fzKbFtw95/18ug?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63da970-5aa9-4000-30b1-08da64791997
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 02:40:50.9349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62accEERufuvRQdYlSailaOkR+F96DLjTZigOJIgtPeJcCrE7Qz9SooSuH7UUBv6b8bEL0lT8UWxUidQEvUTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is=20

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 12, 2022 23:14
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/display: attempt to fix the logic in commit_pl=
anes_for_stream()

The indentation is screwed up.  I'm not sure quite how the logic should flo=
w.  Someone more familiar with this code should verify this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 45 +++++++++++++-----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index 7453ec54420b..efc61a485561 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3229,7 +3229,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank =3D MAX_TTU;
 	}
=20
-	if ((update_type !=3D UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_=
changed)
+	if ((update_type !=3D UPDATE_TYPE_FAST) &&=20
+stream->update_flags.bits.dsc_changed) {
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) { @@ -3247,6 +3247,7 @@ static =
void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
 						top_pipe_to_program->stream_res.tg);
 		}
+	}
=20
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
@@ -3455,27 +3456,27 @@ static void commit_planes_for_stream(struct dc *dc,
=20
 	}
=20
-		if (update_type !=3D UPDATE_TYPE_FAST)
-			if (dc->hwss.commit_subvp_config)
-				dc->hwss.commit_subvp_config(dc, context);
+	if (update_type !=3D UPDATE_TYPE_FAST)
+		if (dc->hwss.commit_subvp_config)
+			dc->hwss.commit_subvp_config(dc, context);
=20
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			dc->hwss.interdependent_update_lock(dc, context, false);
-		} else {
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-		}
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+		dc->hwss.interdependent_update_lock(dc, context, false);
+	} else {
+		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+	}
=20
-		if ((update_type !=3D UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc=
_changed)
-			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable=
) {
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VACTIVE);
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VBLANK);
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VACTIVE);
+	if ((update_type !=3D UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_=
changed) {
+		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable)=
 {
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VACTIVE);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VBLANK);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VACTIVE);
=20
 			if (stream && should_use_dmub_lock(stream->link)) {
 				union dmub_hw_lock_flags hw_locks =3D { 0 }; @@ -3492,8 +3493,9 @@ sta=
tic void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
 		}
+	}
=20
-	if (update_type !=3D UPDATE_TYPE_FAST)
+	if (update_type !=3D UPDATE_TYPE_FAST) {
 		dc->hwss.post_unlock_program_front_end(dc, context);
=20
 		/* Since phantom pipe programming is moved to post_unlock_program_front_=
end, @@ -3506,6 +3508,7 @@ static void commit_planes_for_stream(struct dc *=
dc,
 			if (dc->hwss.subvp_pipe_control_lock)
 				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_p=
ipes, top_pipe_to_program, subvp_prev_use);
 		}
+	}
=20
 	// Fire manual trigger only when bottom plane is flipped
 	for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
--
2.35.3
