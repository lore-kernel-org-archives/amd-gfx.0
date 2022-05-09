Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA29DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 08:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D4110E100;
	Mon,  9 May 2022 08:12:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC28810E100
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 08:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg6+t2qrbbMZE0yI0eBy0xhG2OYZCQAvYRSi3Bz3kGfY/niO1ffs4b7X7qn3+e32OLdS2U2pjdaGTAZ3YMevuwui/ppIL2BiJT1cmvS+mJFJoxFunVuU6BuQTtcqueVi3v2s953sey25rhoyX+4jMnzqcsUohq/EIPPEIlE7BPd7UQG9e2caK0OHuO5BQkDwPKiHceqEoGi3JsjQ4yQI+O/6LleJM/euAk1ap7L39r+4Vth8A8M7rYm8tpqTlP4qMzMZlMTVNb4lGKrMYju1XhK1veGLaq/iCRDFGWt8wM9CQfwGG/dlfgEEtLROquTq/eS7q5UBmTdHbU+i1hpsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI5TiBuUrtKWPqcv0q72WepXe41egatC74C0Ykpu7sE=;
 b=FCbbf4IX4mTo3tYxhK/D7dIHsN/ITzvREmhiI3ELwi/HQrJdvYAwH0teu2CkOLsYWwWM+9KSepN+41VJBSJpUWtIIG/fs5pQ3bUApVjm6RqreS2t+t4IgPsFC0fXIPIVqA4NOZOGLQL8623FcW2yQs6tBHpQ5w4qB95DpqoOx0+JqCDfauaUHxogFruQ8DOfKuqJmTMSof7fjNkP15HjAJPBSVPPZUt2T8y88mXaAi+qGsE0RJb4SyiJae6MwGWtKZ4Yx1Y6dgBkgcfefyo7fpJjaQw4M5Dmr+5ADNZjQJBYJ6i1p1Qmq8pYs3OLSWgPE8Hr/iNrEi/xcNjg6dyufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5TiBuUrtKWPqcv0q72WepXe41egatC74C0Ykpu7sE=;
 b=wGYvwW515ed9+ydTjci+uCqQ0Jsjv5LkIpjIDH2rqzjZtji4l5h7wyq/JmtfakdWAugjW1dzsZ4xy7jckApiYUqHiAlhcRUf78va7KCG30SgbJ5P9Akxk/TYFX9q0p9rWeegw8Nl+YLa5zmoyHq+JaYOf2g0OSCKslffxPWwvBE=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 08:12:13 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:12:13 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMUB FW
Thread-Topic: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMUB
 FW
Thread-Index: AQHYYIvAhkV7iX26C0SEYiVk/mvJ760WNreA
Date: Mon, 9 May 2022 08:12:12 +0000
Message-ID: <MW4PR12MB566853776D089737D2CCDC6496C69@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-4-dingchen.zhang@amd.com>
In-Reply-To: <20220505142323.2566949-4-dingchen.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2305a97-c9d9-4081-06d0-08da31939f69
x-ms-traffictypediagnostic: CH2PR12MB4133:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4133C759ADDC800DEEC700E296C69@CH2PR12MB4133.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULm6NqMXqTuks7uk+pb0fSSv31A+9qb/oYYlnqOor7u0bIGx+JpVWAZQnDM1LfTLJYuQrVt6ats5aShE/31K+nDb1i3sDyPX+iXtP43swZqZuLSBpMIimSDPMsNhz9lowwUN6DhcFm4Vul2/T/slM35WQjD4zSIg7a1kG0qIspROrBi/P6Ej98P3aD/o+3QCRJ+m+LamPLzUbecmYGtNWyr53yM+oN3f52zVYVfRIJwVu7Pr+oDaRlDX/K7VSFKIVE4F6Kj+9HluHlkmFJ6ErvpG7QXTOGgjaf/I7r2dYmKzPX18VRpJ8zjQQOTJ/P2oxdawTtL/h6DvBm9HpS1y5ZhjydQJiZWkKxlKkhU6vaD3Ba4ZeaMpAcbRZohae8XBMrKYh2yn2GsvYv49m0WEpZg6RRcruJA2OgaTKo3Yil0DbTY5/f6DpQpnBgsN4ub+2TpIhMvvoxMo+mo7ou1jq4MSkHwHCykXXZ45nOmfKT4GEgZkxujuNcKM6Ky43ZcmFGpt05XD6W2pqFEbBhKnt2aMVT4dzN3JOXif2+WH7nOBtHAL80Zgik4FrS3ziKdqxFASWg3L/zil17+to3FhB256EtxOr/ca8Zo7ryQzXfLjgwr2h4jSx0gp1ZtQCAUEhxagpIiHphw7YHuHen4p+UsvHYdPuOFhAznLlm+7w2NgZFj9nQ9UGp8b8VkJAMPVTsga6wOXfpUSDMx4YNBeTREjeR9LFN+/IULroDcP7I4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(2906002)(8936002)(55016003)(122000001)(38070700005)(38100700002)(5660300002)(110136005)(508600001)(4326008)(186003)(83380400001)(33656002)(66946007)(66446008)(66476007)(76116006)(8676002)(66556008)(64756008)(54906003)(316002)(55236004)(6506007)(7696005)(9686003)(86362001)(71200400001)(26005)(14143004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4D34cPTOmBlpUVOUZW7+syM4cB+UBPiypoHs46f84g3onnWYnwobGEzmFn+?=
 =?us-ascii?Q?XUJQoROFyIN5j3ddT5UXpxQD32B8D+Bi0bhpY3oPQ7ppa1XVGim8XtjXeQ22?=
 =?us-ascii?Q?l17mWGvvKw9rQPr3LbMK1kIHfIGI6mn9LFKXJ8J+AhYfCQ3cdzLnjtaGuo+x?=
 =?us-ascii?Q?r7Q5R+1sDcyyV2GQaltmrZWvLzcy/lqS4lPi7vB1Nl0X4EIC5I0zMcgILyrA?=
 =?us-ascii?Q?Hs/c81IIugd7QJYZckwIMXLvHPRK8CtpcclfgwVfM+XPIokpbk40f3YhnTMz?=
 =?us-ascii?Q?2/UelyqoCJOJNCvwMyvZJoT/29j8MVjDDeXGhYae4v029HgjztPgTXxJ4uDa?=
 =?us-ascii?Q?8NHwpjsQYBaonP3vnFZZnVzRyjHEI/WIrxGqEaXr+W82jVY3Vl3IPCL+trTb?=
 =?us-ascii?Q?tMbGBoiRlVeFyRXSbberrfX9WAKM0vLKq1Mc8VZCW/hXn5euyQHxpFgaUabZ?=
 =?us-ascii?Q?sMgnmIiFWse+3PpHRACCW/elVKBZDoiR2/kdjqgxWo6WQy+QlNOR8inlPRzd?=
 =?us-ascii?Q?dcsL0wady+qmXHDkVlyPWwGXteSBjtdc4eGJ4qIKWbfyZCXeE1YtGiBhx/jj?=
 =?us-ascii?Q?ggTzn3NOMaDNkLLbCTsHaFpxt4+5Wg9B5bs07s5jKqQ+7+pq43lfz59WvNGL?=
 =?us-ascii?Q?XuMlsIwb667jKM46j3wxNOPkiscg8xnEtKaLNEVU95YpsUTSlgWoDypdkFdz?=
 =?us-ascii?Q?IpFNlgpBlSPpbMideCMnh9b2YGgIDyr5b+0W15aFM/msYg4iVU0L2kGBEPiq?=
 =?us-ascii?Q?jk/cCL8niObOw0SIY2X0YLvbxVE6eav+BVCc7oQzgBxqDDhiu8hGJNKFSDzA?=
 =?us-ascii?Q?xdFpKHbtPnjOsOlzZ3HRrmHJSoipFNq2n0rYBnJfDJc9ErJIBbwzE3lZpmKb?=
 =?us-ascii?Q?y3Fl1PdWq5DSLOvU5Z0/IZ0Hxy2rdy8N1M7cJjkJ8lYkNUewd7Qj/y9R9b8N?=
 =?us-ascii?Q?DDQ6mHXrG8peWbn5FOpCUQPPQYXn8rdgU42Oe0m048fFRPvZdiPo4pU60VMS?=
 =?us-ascii?Q?qJBHoh37C/wdp67SoyyFxNV4M5gMQhjjWtmsPceGtkvfW7dpclV++C5KOsb0?=
 =?us-ascii?Q?HXG+iOGZ8TdwJwwchfhzgybJpNII5VtuYMNm3X7jG9it7HdmCkY+iMsS/dnM?=
 =?us-ascii?Q?H3Io/JB74UtpHRZ8AraJ3tnB7PW48Vxpu25xumWAYKc6NDL8HDtn/bZsM4S1?=
 =?us-ascii?Q?TiIc28NbnmwrAzbi0X8RCKYGacqeO2VOyI3LbE11GGbXVI0tw2TursbWWsVe?=
 =?us-ascii?Q?9lDvKYt3pAVwXOOl637/x3hoMZEKQEQv+FZTrLcqZ1g67cXOw8ubO8a/6AuN?=
 =?us-ascii?Q?TwfXiIvI6hwMGwZxhtgxSPj0J/LO3MSb6GkCeQqtX9hcavGSJYuUds3i6XFF?=
 =?us-ascii?Q?Fdywf9skKJrUnTWhM5KEERzb2P95PxS38GpjUfQxO5MdlcPWydQ75cwDt0uy?=
 =?us-ascii?Q?8mkxyDprS15XyBP1bTAuuC9aK+e90xZiu05OGg3EmKXjMpDw69Eju74huKcr?=
 =?us-ascii?Q?EhHXv29Z+R13RlW02Uh5cE/eD+tbC5Y3Cx5TTw4p3huJ9Wn6wDfsqN8jukwE?=
 =?us-ascii?Q?XbPjLCkitGVQfxnLh52/rGkA7up1aPOuK+WbVowxbIn0ZZBP76AbCBC87yPt?=
 =?us-ascii?Q?OhHjbuC8WUw4FPJLKXQaXIqoPMFc7zVOPAWAwobzYFS1NXmvJoZceXmI1p2X?=
 =?us-ascii?Q?1NZiq0DXo0C5aNGQmiZu1k9XhZOyUFzNMr+XQsF7FnZVG81U9gKKWRbHP6cL?=
 =?us-ascii?Q?8gN6UP0w8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2305a97-c9d9-4081-06d0-08da31939f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 08:12:13.0135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNjZgczg1pGCM80la2IcVsjRqBaJrQnggQjUVzly0AdWFUB2dyV1Ft/vKtNAxNKf+uqxouzLnwy3qeGVfHrHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,


Why is the DC_MAX_DIRTY_RECTS set to 3? What causes this limitation?
=20
>[why]
>In PSR-SU design, the DMUB FW handles the combination of multiple dirty re=
ctangles.
>
>[how]
>- create DC dmub update dirty rectangle helper which sends the
>  dirty rectangles per pipe from DC to DMUB, and DMUB FW will
>  handle to combine the dirty RECTs
>- call the helper from DC commit plane update function.
>
>Signed-off-by: David Zhang <dingchen.zhang@amd.com>
>---
> drivers/gpu/drm/amd/display/dc/core/dc.c   | 54 ++++++++++++++++++++++
> drivers/gpu/drm/amd/display/dc/dc.h        |  3 ++
> drivers/gpu/drm/amd/display/dc/dc_stream.h |  5 ++
> 3 files changed, 62 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/am=
d/display/dc/core/dc.c
>index c2fcd67bcc4d..0649d84b71b6 100644
>--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>@@ -72,6 +72,9 @@
> #include "dmub/dmub_srv.h"
>=20
> #include "i2caux_interface.h"
>+
>+#include "dce/dmub_psr.h"
>+
> #include "dce/dmub_hw_lock_mgr.h"
>=20
> #include "dc_trace.h"
>@@ -2842,6 +2845,55 @@ static void commit_planes_do_stream_update(struct d=
c *dc,
> 	}
> }
>=20
>+void dc_dmub_update_dirty_rect(struct dc *dc,
>+			       int surface_count,
>+			       struct dc_stream_state *stream,
>+			       struct dc_surface_update *srf_updates,
>+			       struct dc_state *context)
>+{
>+	union dmub_rb_cmd cmd;
>+	struct dc_context *dc_ctx =3D dc->ctx;
>+	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
>+	unsigned int i, j;
>+
>+	if (stream->link->psr_settings.psr_version !=3D DC_PSR_VERSION_SU_1)
>+		return;
>+
>+	memset(&cmd, 0x0, sizeof(cmd));
>+	cmd.update_dirty_rect.header.type =3D DMUB_CMD__UPDATE_DIRTY_RECT;
>+	cmd.update_dirty_rect.header.sub_type =3D 0;
>+	cmd.update_dirty_rect.header.payload_bytes =3D
>+		sizeof(cmd.update_dirty_rect) -
>+		sizeof(cmd.update_dirty_rect.header);
>+	update_dirty_rect =3D &cmd.update_dirty_rect.update_dirty_rect_data;
>+	for (i =3D 0; i < surface_count; i++) {
>+		struct dc_plane_state *plane_state =3D srf_updates[i].surface;
>+		const struct dc_flip_addrs *flip_addr =3D srf_updates[i].flip_addr;
>+
>+		if (!srf_updates[i].surface || !flip_addr)
>+			continue;
>+		/* Do not send in immediate flip mode */
>+		if (srf_updates[i].surface->flip_immediate)
>+			continue;
>+
>+		update_dirty_rect->dirty_rect_count =3D flip_addr->dirty_rect_count;
>+		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
>+				sizeof(flip_addr->dirty_rects));
>+		for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
>+			struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pipe_ctx[j];
>+
>+			if (pipe_ctx->stream !=3D stream)
>+				continue;
>+			if (pipe_ctx->plane_state !=3D plane_state)
>+				continue;
>+
>+			update_dirty_rect->pipe_idx =3D j;
>+			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
>+			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
>+		}
>+	}
>+}
>+
> static void commit_planes_for_stream(struct dc *dc,
> 		struct dc_surface_update *srf_updates,
> 		int surface_count,
>@@ -2934,6 +2986,8 @@ static void commit_planes_for_stream(struct dc *dc,
> 		 */
>		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
>=20
>+	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates,=20
>+context);
>+
> 	// Stream updates
> 	if (stream_update)
> 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, =
context); diff --git >a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/d=
rm/amd/display/dc/dc.h
>index 942bfb8fd851..85f3303e7843 100644
>--- a/drivers/gpu/drm/amd/display/dc/dc.h
>+++ b/drivers/gpu/drm/amd/display/dc/dc.h
>@@ -1134,12 +1134,15 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut);
>  * in cases such as Stereo 3D, Planar YUV, etc.  Other per-flip attribute=
s such
>  * as frame durations and DCC format can also be set.
>  */
>+#define DC_MAX_DIRTY_RECTS 3
> struct dc_flip_addrs {
> 	struct dc_plane_address address;
> 	unsigned int flip_timestamp_in_us;
> 	bool flip_immediate;
> 	/* TODO: add flip duration for FreeSync */
> 	bool triplebuffer_flips;
>+	unsigned int dirty_rect_count;
>+	struct rect dirty_rects[DC_MAX_DIRTY_RECTS];
> };
>=20
> void dc_post_update_surfaces_to_stream(
>diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/=
amd/display/dc/dc_stream.h
>index 58941f4defb3..58036469c62a 100644
>--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>@@ -529,4 +529,9 @@ bool dc_stream_get_crtc_position(struct dc *dc,
>=20
> struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
>=20
>+void dc_dmub_update_dirty_rect(struct dc *dc,
>+			       int surface_count,
>+			       struct dc_stream_state *stream,
>+			       struct dc_surface_update *srf_updates,
>+			       struct dc_state *context);
> #endif /* DC_STREAM_H_ */
>--
>2.25.1

