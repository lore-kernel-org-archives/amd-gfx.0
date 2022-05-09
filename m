Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA22C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 13:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BAC10EB69;
	Mon,  9 May 2022 13:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3145B10EB69
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 13:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAcpDDdFpntEdF9Y5pmpIWM7Q55uBDVupwLMfUZ4NHz+oDRLOILOstPto1OkzUaxlZcnoD/sl5AG6jqma2yx1wW1qbBbLhXGedtXyQQfo2QimUeCvWJ8NyNGe5j0joH1Ry+EABj5eqqSOyean/z5s0TJZ0MGwAdk44ttkES4UNNgJI90mg6a/Z6innURK8O0KpE01hSgtL02PJd/bpdr+DnoSdqeDaM5ejqJvCpxfCa541+qhj7fjRtkWvE4+nm1qKhVdvmXrgpBFFaImXWWr+ib0ggeXtV1KtzlU3FLZjWg7Jrp5U28BXMicQsTzYXajXAdhbDAIzCPOUzsx2VtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+BCkop5T8QeCUdBDSOvZ/Jyj1RTGFnVkzAMm8aVfa0=;
 b=kn4elq8y2sb151yqxAEW/Y9lgB1Gm+kAlMZAIFdZFenYarYF+tWHcQP/MFoz1UGN/yWy9DM5vtgX11+r+3hLfur3YEE2GZKGVuzD4ZL4Gdv6UZ0EZ03KzlrSjQ8+39vqEwsL44b47XBcjicr6mRVqaFAhew1Ult8kuXbZuDTu0QvcrvLxwuDxZfQOfL9q2MnlfdrK9r0E/tHyemZKDaoomjJgi9AGRByzdQOPfxVEafwxI6j+PFrLuivF3Wmy5UhGRmypCRf12C5fGVHixv1WU/lmisLCXnCWv8zxswq/yqaMnzFMQphXcz80NNszkNRgaQOBOqtocX3Kx9qi607ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+BCkop5T8QeCUdBDSOvZ/Jyj1RTGFnVkzAMm8aVfa0=;
 b=28Pq4y+/hk3qhnFHLnAeqAdk+VN4hfKwqN6WVzKXEYJb5R5x/bVmk3mkQOcPEUwMTZv3JjJZ/+xA/Kpwf4EGbnwzmtTXbyJZCpAP/ZY/OeYmzRzvEaI0dFBD9NZTelNsqIb3M+WDB/iRpubjEdlvWacSrcs3jROqZnF4o2tlAUI=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 13:41:42 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 13:41:42 +0000
From: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMUB FW
Thread-Topic: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMUB
 FW
Thread-Index: AQHYYIvAh7lJ6bH8akmp0VS9Sl3UOq0WN+EAgABbTwQ=
Date: Mon, 9 May 2022 13:41:41 +0000
Message-ID: <BN9PR12MB51451C7A7CCB3726921D256A8DC69@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-4-dingchen.zhang@amd.com>
 <MW4PR12MB566853776D089737D2CCDC6496C69@MW4PR12MB5668.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB566853776D089737D2CCDC6496C69@MW4PR12MB5668.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-09T13:41:41.089Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5ded39f-6e12-49b9-d183-08da31c1a6a6
x-ms-traffictypediagnostic: MWHPR12MB1454:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1454113699838CB073AEB5B08DC69@MWHPR12MB1454.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIu7V0hBVsnbya1OFLuOOEu6f5/isEFYGNEe6Ts6uS6Xpx9VyOmJZfvFut/pcOc4qgF79/+LYGqbofuC89UBD1K3+SYtgRLmRehPftG+szyFgc2YyUvQydogVJKDoaWmDd5Y1DKKGhhkYZRvS16wErMZWK9YAQccKdUyzm0Owgu6POoC7/BhnnsXduVtF1XMO3QCuOIoChJtN68MmUKVI6O/hEiJiWeGNDNaH6YZQ7a/mZ4Ay0C1kqswDx7P1YYmPh9PYayt5g8Cxnz10g9uNQRtWzVZqwsJ2byK8KLi65akrCksqCdDE0IKFaUNb6q5HwD5TUp+JZIE9GAfvCj/ACsl0JrEngv32rm2rcg1Sf8A6EQ9nGJVWvQiuM8niJdpUY2yMsgFjyZJVCtSvKPzwqzhS4+F0C8ds1npo0wSAz+FmVnXLkmFLg8gMZP46R8q3iN7AdtOmkGhT/3TyfLIpapK/Q1k4kqOTdex/XPUhqDbBW3VDC/lW2u0p6YN+mQouxR6goVaRI8exXbMK3w8BdiMB97oeSNCr8DzRVBuHj2S3H/PxQWcFwBp/gzfPt6fPKxPayRBSX3/1qGEJ+KUnuGCR1sXCLnU/UPwh+kIu367xuL7nI4NIpvJ7DGEr19PuBf1QRQ3Wjj4KBOeGqt4F1sv/MVOkSQ7OHp3ZCAXwVeYqOTPSAzGawsMDW20IQC2N2FH9Sul2mt/QntG2XvYIHh++bTm3MTVFXDAu1fBdzk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(9686003)(52536014)(8936002)(54906003)(86362001)(19627405001)(55016003)(53546011)(316002)(6506007)(7696005)(5660300002)(508600001)(71200400001)(4326008)(66476007)(66556008)(76116006)(2906002)(64756008)(38100700002)(38070700005)(33656002)(66946007)(8676002)(26005)(186003)(122000001)(83380400001)(91956017)(66446008)(14143004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7GUMrImqevXg2tPeaQ5rLVVK4f5j2w3GJfOCbCYVAffbHpPG3hu6rS4Y5aMe?=
 =?us-ascii?Q?LeRiZ19IR2vU3bYXeSPU2UgkKaD9M/ElncGT2tIcVH6F4BM8H8TqvihX2KDh?=
 =?us-ascii?Q?ky+e0tXimudZt3M1tja/zx6pnR9O9/hEnISdpRUukn8f05lT6+CqoR4zuQ0R?=
 =?us-ascii?Q?C6A1/xwNcdhgkPLaGgtGslKOoNkjMzAq6ctOZXFvgBtC9nvZFcTZ545D4RSf?=
 =?us-ascii?Q?yt6qlg66GF4fSCQOX40lxyNLP8R9LG6R2EOMrxxCKKVOk+F3vJOXHz+CUN0C?=
 =?us-ascii?Q?OYAri/caHCOvC1cNs5tn+tIBSslpaAEJRPk/AJoXC1Iuvstk0tShbJ1QAxV6?=
 =?us-ascii?Q?ESYDEsdJBcT3mXL9mVkgHo6Bm7jOTNAIINijw2bFtKUkxaEoF6sv/fdJnS/2?=
 =?us-ascii?Q?xLl0xlPpzcXz3tryqRWWMJX2AkAFxdWGT9tjdxtCK7579Ua3ukPyoG14oHRs?=
 =?us-ascii?Q?QggPAAF23X4jU/l1AQX3GZSfMt4fB1kXaxWEbS8VPX4YJQKhZet5n/jJ129u?=
 =?us-ascii?Q?lzbrrz+Om8I2dD5XkbNj+oy3mew0kMvwajfdbsEKi+KINPb1bNhUMgtG2ri5?=
 =?us-ascii?Q?6lcmLWXXQ28rI5qqgGkFhTjv9Ssl+ktljagXnUg31i1qrwJPfgQSnNvtekLJ?=
 =?us-ascii?Q?l3As8klpu0n6feJerk50UwDW3pT9daf4gYJ/1heIFj3h1upc3bNAl0/DqQUc?=
 =?us-ascii?Q?bdr4jCsYx4LYw36XwPKGuGEpR/X7xdIjNosQOxQAqfaWImc3WxP/eYk1nHxq?=
 =?us-ascii?Q?2MapS4UCa8i2V+8VYTsUu2+WYPlVvTfdEm06maOSNtol/hKdyhdyMC6Ae+R1?=
 =?us-ascii?Q?FtMQKU7+l5wm7Sl0rVdkK13UzGyc9QNyYoRUDeMj3EF17Y6Xk9m4MHSt3vFB?=
 =?us-ascii?Q?UPPzXqNK5SIzKRbIrsgx+AqaTVGCvXMbMbAjZsTAODAqCXfu9wNWublAyVC0?=
 =?us-ascii?Q?3xS9DdIioz1u+dqv74DWSiHZmnVbsl/KNqk9NQQHXsHucXOsU1ZUfB1AKBvY?=
 =?us-ascii?Q?hCRb5VvlzWVoAGtFN2/JTJcNfd2rcollzlkOQgl/NG/vhXopdR1fI1UK8BLX?=
 =?us-ascii?Q?yc+Ej78LQom0yYyd1AN9/vTO5i+gQD8aMuHFR3PURP6HR8DIoszWVBHwiI8g?=
 =?us-ascii?Q?4Esi1V7yUAsHEPq+09RVA14uDfQSw9hJwMsT7d1PQTeBM0uhD9hye1WFlieX?=
 =?us-ascii?Q?1FHurUYWN656wdHednXW7WtS/9BqKl+ihjWCVHmYwjzO1JfuE1vMLHphUnGr?=
 =?us-ascii?Q?JtO6DoRCbRoH7ee1L6l5sM2C942XJp+fbcrWdzjngf/zKC3VXWXgNG8Rk2uv?=
 =?us-ascii?Q?/lla0da6bO1/RdYNgbEeOHvKLTD09G3+i3q8tR6DG/UzzuG37tKQbkBKYdq2?=
 =?us-ascii?Q?WGhr2JH6Gglf9nzNcJ7Ve+N0BM+VYRERIxF+D/j6KFQudYCp5OJoB+1Vae2R?=
 =?us-ascii?Q?wiea4HqFYVUXn2n3wtpIqAyBeQPxQhOLrkpxGOTE5EGCywv5hYEv00fPzSFq?=
 =?us-ascii?Q?kPCv2G4wkG6XCV/EcAaLp5Wltw1A3G3iWg+Y58sYtutAWsqVXIXxXyeyVKIY?=
 =?us-ascii?Q?9GCupy0eDsiTxZpQedz41di4tcswxeuisqe+ONkCTFgB7buz6aoGzNBSNq5U?=
 =?us-ascii?Q?jNnVh4go2eCjf/udA55SnHSrMbbqW3Mhs0dTNlIfSL5MBx7OmPC7NM5njBCp?=
 =?us-ascii?Q?uAuujTn8d+hQRdpk6sDa51QjXVVUHJWT7WFmRXaNpoNVA6LA?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB51451C7A7CCB3726921D256A8DC69BN9PR12MB5145namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ded39f-6e12-49b9-d183-08da31c1a6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 13:41:42.0121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gq/El1aBwV0TIia2jkH4coFIYIJ3AK5sr9O0zkkwCOUnsPXLSqUv6+Gg5wkcaS/aBSCKGE2PpKovwWV1rFG14g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
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

--_000_BN9PR12MB51451C7A7CCB3726921D256A8DC69BN9PR12MB5145namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Chandan,

The dirty rectangle combination is implemented in DMUB firmware instead of =
DC/DM layer in kernel. The "max # of dirty RECTs of 3" is the limitation in=
 DMUB FW.

regards
David
________________________________
From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Sent: Monday, May 9, 2022 4:12 AM
To: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;=
 Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.=
com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle=
.Kotarac@amd.com>
Subject: RE: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMU=
B FW

Hi,


Why is the DC_MAX_DIRTY_RECTS set to 3? What causes this limitation?

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
>
> #include "i2caux_interface.h"
>+
>+#include "dce/dmub_psr.h"
>+
> #include "dce/dmub_hw_lock_mgr.h"
>
> #include "dc_trace.h"
>@@ -2842,6 +2845,55 @@ static void commit_planes_do_stream_update(struct d=
c *dc,
>        }
> }
>
>+void dc_dmub_update_dirty_rect(struct dc *dc,
>+                             int surface_count,
>+                             struct dc_stream_state *stream,
>+                             struct dc_surface_update *srf_updates,
>+                             struct dc_state *context)
>+{
>+      union dmub_rb_cmd cmd;
>+      struct dc_context *dc_ctx =3D dc->ctx;
>+      struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
>+      unsigned int i, j;
>+
>+      if (stream->link->psr_settings.psr_version !=3D DC_PSR_VERSION_SU_1=
)
>+              return;
>+
>+      memset(&cmd, 0x0, sizeof(cmd));
>+      cmd.update_dirty_rect.header.type =3D DMUB_CMD__UPDATE_DIRTY_RECT;
>+      cmd.update_dirty_rect.header.sub_type =3D 0;
>+      cmd.update_dirty_rect.header.payload_bytes =3D
>+              sizeof(cmd.update_dirty_rect) -
>+              sizeof(cmd.update_dirty_rect.header);
>+      update_dirty_rect =3D &cmd.update_dirty_rect.update_dirty_rect_data=
;
>+      for (i =3D 0; i < surface_count; i++) {
>+              struct dc_plane_state *plane_state =3D srf_updates[i].surfa=
ce;
>+              const struct dc_flip_addrs *flip_addr =3D srf_updates[i].fl=
ip_addr;
>+
>+              if (!srf_updates[i].surface || !flip_addr)
>+                      continue;
>+              /* Do not send in immediate flip mode */
>+              if (srf_updates[i].surface->flip_immediate)
>+                      continue;
>+
>+              update_dirty_rect->dirty_rect_count =3D flip_addr->dirty_re=
ct_count;
>+              memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty=
_rects,
>+                              sizeof(flip_addr->dirty_rects));
>+              for (j =3D 0; j < dc->res_pool->pipe_count; j++) {
>+                      struct pipe_ctx *pipe_ctx =3D &context->res_ctx.pip=
e_ctx[j];
>+
>+                      if (pipe_ctx->stream !=3D stream)
>+                              continue;
>+                      if (pipe_ctx->plane_state !=3D plane_state)
>+                              continue;
>+
>+                      update_dirty_rect->pipe_idx =3D j;
>+                      dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
>+                      dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
>+              }
>+      }
>+}
>+
> static void commit_planes_for_stream(struct dc *dc,
>                struct dc_surface_update *srf_updates,
>                int surface_count,
>@@ -2934,6 +2986,8 @@ static void commit_planes_for_stream(struct dc *dc,
>                 */
>               dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
>
>+      dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates,
>+context);
>+
>        // Stream updates
>        if (stream_update)
>                commit_planes_do_stream_update(dc, stream, stream_update, =
update_type, context); diff --git >a/drivers/gpu/drm/amd/display/dc/dc.h b/=
drivers/gpu/drm/amd/display/dc/dc.h
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
>        struct dc_plane_address address;
>        unsigned int flip_timestamp_in_us;
>        bool flip_immediate;
>        /* TODO: add flip duration for FreeSync */
>        bool triplebuffer_flips;
>+      unsigned int dirty_rect_count;
>+      struct rect dirty_rects[DC_MAX_DIRTY_RECTS];
> };
>
> void dc_post_update_surfaces_to_stream(
>diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/=
amd/display/dc/dc_stream.h
>index 58941f4defb3..58036469c62a 100644
>--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
>+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
>@@ -529,4 +529,9 @@ bool dc_stream_get_crtc_position(struct dc *dc,
>
> struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
>
>+void dc_dmub_update_dirty_rect(struct dc *dc,
>+                             int surface_count,
>+                             struct dc_stream_state *stream,
>+                             struct dc_surface_update *srf_updates,
>+                             struct dc_state *context);
> #endif /* DC_STREAM_H_ */
>--
>2.25.1


--_000_BN9PR12MB51451C7A7CCB3726921D256A8DC69BN9PR12MB5145namp_
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
: 12pt; color: rgb(0, 0, 0);">
Hi Chandan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The dirty rectangle combination is implemented in DMUB firmware instead of =
DC/DM layer in kernel. The &quot;max # of dirty RECTs of 3&quot; is the lim=
itation in DMUB FW.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
regards</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
David</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> VURDIGERENATARAJ, CHA=
NDAN &lt;CHANDAN.VURDIGERENATARAJ@amd.com&gt;<br>
<b>Sent:</b> Monday, May 9, 2022 4:12 AM<br>
<b>To:</b> Zhang, Dingchen (David) &lt;Dingchen.Zhang@amd.com&gt;; amd-gfx@=
lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, =
Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt=
;;
 Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@amd.c=
om&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lin, Wayne &lt;=
Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;=
; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle
 &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 03/17] drm/amd/display: combine dirty rectangles=
 in DMUB FW</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
<br>
Why is the DC_MAX_DIRTY_RECTS set to 3? What causes this limitation?<br>
&nbsp;<br>
&gt;[why]<br>
&gt;In PSR-SU design, the DMUB FW handles the combination of multiple dirty=
 rectangles.<br>
&gt;<br>
&gt;[how]<br>
&gt;- create DC dmub update dirty rectangle helper which sends the<br>
&gt;&nbsp; dirty rectangles per pipe from DC to DMUB, and DMUB FW will<br>
&gt;&nbsp; handle to combine the dirty RECTs<br>
&gt;- call the helper from DC commit plane update function.<br>
&gt;<br>
&gt;Signed-off-by: David Zhang &lt;dingchen.zhang@amd.com&gt;<br>
&gt;---<br>
&gt; drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp; | 54 ++++++++++++=
++++++++++<br>
&gt; drivers/gpu/drm/amd/display/dc/dc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 3 ++<br>
&gt; drivers/gpu/drm/amd/display/dc/dc_stream.h |&nbsp; 5 ++<br>
&gt; 3 files changed, 62 insertions(+)<br>
&gt;<br>
&gt;diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm=
/amd/display/dc/core/dc.c<br>
&gt;index c2fcd67bcc4d..0649d84b71b6 100644<br>
&gt;--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt;+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt;@@ -72,6 +72,9 @@<br>
&gt; #include &quot;dmub/dmub_srv.h&quot;<br>
&gt; <br>
&gt; #include &quot;i2caux_interface.h&quot;<br>
&gt;+<br>
&gt;+#include &quot;dce/dmub_psr.h&quot;<br>
&gt;+<br>
&gt; #include &quot;dce/dmub_hw_lock_mgr.h&quot;<br>
&gt; <br>
&gt; #include &quot;dc_trace.h&quot;<br>
&gt;@@ -2842,6 +2845,55 @@ static void commit_planes_do_stream_update(struc=
t dc *dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; }<br>
&gt; <br>
&gt;+void dc_dmub_update_dirty_rect(struct dc *dc,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; int surface_count,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *stream,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_surface_update *srf_updates,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *context)<br>
&gt;+{<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union dmub_rb_cmd cmd;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *dc_ctx =3D dc-&gt;ct=
x;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dmub_cmd_update_dirty_rect_data =
*update_dirty_rect;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, j;<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (stream-&gt;link-&gt;psr_settings.ps=
r_version !=3D DC_PSR_VERSION_SU_1)<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return;<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;cmd, 0x0, sizeof(cmd));<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.update_dirty_rect.header.type =3D D=
MUB_CMD__UPDATE_DIRTY_RECT;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.update_dirty_rect.header.sub_type =
=3D 0;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd.update_dirty_rect.header.payload_by=
tes =3D<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sizeof(cmd.update_dirty_rect) -<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sizeof(cmd.update_dirty_rect.header);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_dirty_rect =3D &amp;cmd.update_d=
irty_rect.update_dirty_rect_data;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; surface_count; i++=
) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct dc_plane_state *plane_state =3D srf_updates[i].surface;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; const struct dc_flip_addrs *flip_addr =3D srf_updates[i].flip_addr=
;<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (!srf_updates[i].surface || !flip_addr)<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* Do not send in immediate flip mode */<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (srf_updates[i].surface-&gt;flip_immediate)<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; update_dirty_rect-&gt;dirty_rect_count =3D flip_addr-&gt;dirty_rec=
t_count;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; memcpy(update_dirty_rect-&gt;src_dirty_rects, flip_addr-&gt;dirty_=
rects,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(flip_addr-&gt;dirty_rects));<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; for (j =3D 0; j &lt; dc-&gt;res_pool-&gt;pipe_count; j++) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pipe_ctx *p=
ipe_ctx =3D &amp;context-&gt;res_ctx.pipe_ctx[j];<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;s=
tream !=3D stream)<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_ctx-&gt;p=
lane_state !=3D plane_state)<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt;+<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_dirty_rect-=
&gt;pipe_idx =3D j;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_dmub_srv_cmd_qu=
eue(dc_ctx-&gt;dmub_srv, &amp;cmd);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_dmub_srv_cmd_ex=
ecute(dc_ctx-&gt;dmub_srv);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;+}<br>
&gt;+<br>
&gt; static void commit_planes_for_stream(struct dc *dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_surface_update *srf_updates,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; int surface_count,<br>
&gt;@@ -2934,6 +2986,8 @@ static void commit_planes_for_stream(struct dc *d=
c,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dc-&gt;hwss.pipe_control_lock(dc, top_pipe_to_program, true);=
<br>
&gt; <br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_dmub_update_dirty_rect(dc, surface_c=
ount, stream, srf_updates, <br>
&gt;+context);<br>
&gt;+<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Stream updates<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (stream_update)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; commit_planes_do_stream_update(dc, stream, stream_updat=
e, update_type, context); diff --git &gt;a/drivers/gpu/drm/amd/display/dc/d=
c.h b/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt;index 942bfb8fd851..85f3303e7843 100644<br>
&gt;--- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt;+++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt;@@ -1134,12 +1134,15 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut)=
;<br>
&gt;&nbsp; * in cases such as Stereo 3D, Planar YUV, etc.&nbsp; Other per-f=
lip attributes such<br>
&gt;&nbsp; * as frame durations and DCC format can also be set.<br>
&gt;&nbsp; */<br>
&gt;+#define DC_MAX_DIRTY_RECTS 3<br>
&gt; struct dc_flip_addrs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_plane_address addr=
ess;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int flip_timestamp_=
in_us;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool flip_immediate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: add flip duration f=
or FreeSync */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool triplebuffer_flips;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dirty_rect_count;<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rect dirty_rects[DC_MAX_DIRTY_RE=
CTS];<br>
&gt; };<br>
&gt; <br>
&gt; void dc_post_update_surfaces_to_stream(<br>
&gt;diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/d=
rm/amd/display/dc/dc_stream.h<br>
&gt;index 58941f4defb3..58036469c62a 100644<br>
&gt;--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
&gt;+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h<br>
&gt;@@ -529,4 +529,9 @@ bool dc_stream_get_crtc_position(struct dc *dc,<br>
&gt; <br>
&gt; struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream=
);<br>
&gt; <br>
&gt;+void dc_dmub_update_dirty_rect(struct dc *dc,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; int surface_count,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_stream_state *stream,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_surface_update *srf_updates,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *context);<br>
&gt; #endif /* DC_STREAM_H_ */<br>
&gt;--<br>
&gt;2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB51451C7A7CCB3726921D256A8DC69BN9PR12MB5145namp_--
