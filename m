Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9379AFEEF51
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 14:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1170C10E421;
	Tue,  7 Apr 2026 14:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KNag3Z6h";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6F010E421
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 14:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgCfxCA3MYd+Uc5BYTQq7sQFrbS/GZTftIjkQm9EEIcl3LXYnVFd5BX2FvSM00yLQzqd/zH/IinSPNyQzUf6ODVBFHSCjXAGLzBrtHP7UQ4bZUGJobINXmoqUuHNZyYKWR0VvFFD9eM8CiMrLvEcIfsyLDdqAnTykkfjNi2pwyzIaiHd7Z+hL4CJRGQmKJ0kxY5q8zhvblml9SxvbkhSAL6ovEgu67bPDFyc4WIN6MVSPU7bZdwHWeWAe9qvm9hnOzfjvMVbQSYRXnez3pNnRSofdrocfgElNTKCuBZeaPLv1MXR82e8hT4G1HY8oas4HkPE2V26ZBqb1CXa7vE6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dycbaUt3+qhyt285f17HFbOueTIqV+Ql0RAPbsYDeFQ=;
 b=ZS5e0AdwJCVt1l9gy70rTuX9MB/G6GsEid1F1HjOwdOq/mxYE+dfw/xv9qj4PwchalANjDtaAg8P/4TJEn26YRuF1Q+ELgVvJ3x1LCwOQ0wWBhecy9b0caahYdXTJ5q9Q8HGmCbwMCsJREsP6dY/Ol48LxzDzv5bC8Tk0A9VKCr/MCYSKY6GejVY6osF8KS4citkWby6ZEPxYfV2u7llsqnKjTBGjpClxHKJVQhWh9P9EVL2OvtrFHoyIlT9NX2uWFg6YI73s+zxz3l9UmWpWH3DHgSE6NP4Evf0LfB6N3iIiKMXSSVpSH1l7FbLjpFB/HXsKrKSfm6rv9R2XZUC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dycbaUt3+qhyt285f17HFbOueTIqV+Ql0RAPbsYDeFQ=;
 b=KNag3Z6heCUPaDB2/FGFkM7WY3jXBRk0tkBUfsX5F3Nez4tuCwzPyu3nwLs3s09wO205k0ZWhbw4BUPE564Us+ZkOEbM6LlkXKGjLkSZQD4wDGwVVBKVJA8Lc/Q5YOBtWY5OATYXATJyAmnx6ztGUDmE/z4Fr/0JmM21GHfrJUM=
Received: from DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) by
 SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 14:40:07 +0000
Received: from DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02]) by DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02%2]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 14:40:06 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for
 legacy queues on unified MES
Thread-Topic: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for
 legacy queues on unified MES
Thread-Index: AQHcv+VLI+gkd5lmJ0S/ICsCMkPfFLXTuP+5
Date: Tue, 7 Apr 2026 14:40:06 +0000
Message-ID: <DM4PR12MB62793B6B50FA340D23A916E3945AA@DM4PR12MB6279.namprd12.prod.outlook.com>
References: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260330013346.1054624-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-07T14:40:06.216Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6279:EE_|SN7PR12MB7450:EE_
x-ms-office365-filtering-correlation-id: b5af05ea-b916-4b05-ebe2-08de94b39000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: 2n2iyyyvCr5khp6y2X5lQnlzJ9rsn3PIno2bWsF8XMW8gNuwQL9yItEX3SGLHEna1RSEMvgtv9ihrtHLgLUHxbBli78yLIGmIBq2qg671fmWK3l9Wn7dWW88ZpQtejU8ekhG8f4jFoozi62DGW+5TNmybTdFYUCO6tkoygAwpiPUS/RuwggDt17RWqa04jloQaaR2hHzJxEOkmxU4j4WBcmTr/0j93H3R7FewgetcWhzlb2Xbc79tlYb70P4j/zoDJZnhbcQXYLSa7Pn8XxL0skOJCrKFIBlX8FvVJuRvtbiJqfMKfDtz2oqm9d7HJbmJVUgOvGod1i98uTl9Ei1n2CBF2Arv/Mw5xZoLofRSbQK+TDvFsovJ+mNkP/JKna7cIjy4dvLcnG0BKX0JkH5YcGLkhq9pNqQ8qsG1DJPCBxhMHKIqthfltZbXS+oyqXqQPETYSYq4+qD5KJQmpQE2SPxRxtMzrlvU7If6zo/3k/+qUyCn2IMHe4eeJ0lJojBu9SFObtpiItTrNM+wFqvgxG5+rdlJTK0SvpX98dOTw7EMb9g8y26tr4YURfSL6UKM53fwMsu9rgvWzbrtwgCORvYWg7gvvXdgze9/Dz2LfP8fLOCcaH9k3YwFXkhCCYZYC3eoEYxjknk83ZhsAiCJApUsB1d/AHBZiXcfpFNYc8ndGLX3SuXVmZzhjYkvbMFnk8Lk3CXGR7mOKRsKnowaNpjNqMibMZQRl0okF/jdybovlaJ4Zzc/ACvxfmgqQRs1fD9yWdrFrsjPN4hR7rvNM9SRe037LvqTckRfGPj1Ww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AvWObYP3K3TrfGow3flwHxLUtfheKAglV2XYPwof47SrYgb1oHY8qlOThfuy?=
 =?us-ascii?Q?vrVy8GEmwknt7QTxzp6/Kza6YvGSmutOmW4hvOQwSnmWy2X+23aKGLIZgG3v?=
 =?us-ascii?Q?nHb6gxItuRBwmcIJz2XVw0ZfkI7aZxS1hfg9FLT3D96IkoAl+wvgGZ1XiVdI?=
 =?us-ascii?Q?Un09xOFbBmqVuCFUnuBhQmI+dR5OiM4qKNxE3E+Bs5BWozgC2tZYVFDg1/05?=
 =?us-ascii?Q?kG7CIA0oIMa5pKv63uuIJR51dXV6T516HHLVlrnUoewRM/QDltcbeh8HiQxb?=
 =?us-ascii?Q?hza/fRXq8N/GgbMzpXe2IS+8TdD999b+mmL6mbES/G2AiqUGT0nV1qVDmvJ0?=
 =?us-ascii?Q?8iJVVmdjC0xBJVrVxnyKNvM3brdD3YMihSUKQNQZ2TtVOjf0BnPtSggLfnGJ?=
 =?us-ascii?Q?OP5BCt4aFze5nzKKA4grqRJdlxE4g480YA8XFAI5P6UpUEdvlFfxmpmTAvaa?=
 =?us-ascii?Q?BuAfDYYyudpV/yOYNsGT+ieOrzgqXQhw61kdk2lGxl+7rc+wGLSnrZvs64it?=
 =?us-ascii?Q?h4h+/drA+hHkmwrNSjACfZ+c/rcqOBT6D2STu1nn4CsrRwJMtdxSTdk0oWCn?=
 =?us-ascii?Q?/hb5j4yR+qiGbBG0U8/VO8rQ/wN9dY4S69creclIaUVtekzOGosKSBQApqWy?=
 =?us-ascii?Q?RUV59SS8zHjXnpsuiy6BbHilqXkZgNC8dXlT6jq/Dmjn9zHRPkk+co3DFrgN?=
 =?us-ascii?Q?a4zfTpyQrAsFCUtFcvEiDR5gj8THH2juG7sOX8KIlXJczpOyKCj56czftKFS?=
 =?us-ascii?Q?KZJLf6Q0v9KH5aS7v5TWWYb3ljqZwEhrFe5Z0WqoCAk91ikpQCf/zH8+Oqqb?=
 =?us-ascii?Q?z7++KWkmQT9cFn3AK05qsOFUrKrCOmhyBar4rC9Hn/nhVGa8p3WXjHMoTz2o?=
 =?us-ascii?Q?5+QrGpD13/E2vuQfGt1a7bEykQt8pdNmZsWb9MKDV3Mem3sL+uGTRj2opRvr?=
 =?us-ascii?Q?KlhkrVUFlAw0Y+BFrh0o7Zli7RgkdUXu/b8L0JaK4dslyOXiziiEhvvln+Ne?=
 =?us-ascii?Q?hK1Kiv28r9Uu3P735VoAewHSoZZIAg6cHQboIOWriUgZPMIxD1HFPzVNqoEo?=
 =?us-ascii?Q?tTICrfauGIzoAn5Zyl3KUNKrvjXGhavIViiKP9Db6lWVWdo7GqemJ5cse6pj?=
 =?us-ascii?Q?F4K1xh327KUbTLmBR53p89uqPD8jRUqIyshhfyYKUCFUkqQMM0LNmJiSMmb1?=
 =?us-ascii?Q?oo4fIP5LuUzyMMAHlz3f5CIR20KN/1/aIDZJPu1Q06mmuQEloGkJ+Bid9ZFv?=
 =?us-ascii?Q?SI8BzwbjC//nNUHQy2zoch0OnK3Fnmapa7akLYq60f8eOJ4XB4vKGyjjmlEa?=
 =?us-ascii?Q?HJkpo6Jf+wBi3NFPJM8CfTXnWe4CkauWtgErFZt3Wv+BRIUjMKHNhd4Q124G?=
 =?us-ascii?Q?RRAxJMawznEycQcxYaW0TDX72DdAl5YPKk55s2ectIFbyvx9Himyp+jAF6Eb?=
 =?us-ascii?Q?1au3DtEdPnPtaSiclAlkW6jAklp5OkxkDN59NPLaC0aL3iTCbXzxGRsZ/2wI?=
 =?us-ascii?Q?bx4w6VRhe2c+L7yZM6+nq76p2oNrCTqeO7Gr79l2TtCDqNzvZnRUUQCX69rs?=
 =?us-ascii?Q?o+Sz4jt7qfEzVU/YwDZmFiY3e2cRRm8e3+qlF+Y3gZzETweO/UEpUlyfvM+D?=
 =?us-ascii?Q?izYa98IEb8Zyy5Xhk1jB21RXTwWgcbKg1dzoOGk6S42denh0YaM7PetZXnLa?=
 =?us-ascii?Q?qS85SCZA3f4SeZQF1yZQ1JrdwGUINU5a18yVqrKhSrCW7BGD?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB62793B6B50FA340D23A916E3945AADM4PR12MB6279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5af05ea-b916-4b05-ebe2-08de94b39000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:40:06.8791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVOBjyb12O67RneJqyNBssGu5KE8S6e69MF0g7iDgypHz23p1U2cryyaIIS09ep2dU3VGXHHIIWdC0xCtZ7xgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

--_000_DM4PR12MB62793B6B50FA340D23A916E3945AADM4PR12MB6279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Sunday, March 29, 2026 9:33 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chen, Michael <M=
ichael.Chen@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Ale=
xander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe for leg=
acy queues on unified MES

when suspend_all_gangs is issued to pipe0 MES during system suspend or runt=
ime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, lea=
ving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 023c7345ea54..67fb5161c0e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_m=
es *mes,
                 convert_to_mes_queue_type(input->queue_type);
         mes_add_queue_pkt.map_legacy_kq =3D 1;

-       if (mes->adev->enable_uni_mes)
-               pipe =3D AMDGPU_MES_KIQ_PIPE;
-       else
+       if (mes->adev->enable_uni_mes) {
+               /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues on sched pipe. */
+               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
+                       pipe =3D AMDGPU_MES_KIQ_PIPE;
+               else
+                       pipe =3D AMDGPU_MES_SCHED_PIPE;
+       } else {
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
+       }

         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
                         &mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu=
_mes *mes,
                         convert_to_mes_queue_type(input->queue_type);
         }

-       if (mes->adev->enable_uni_mes)
-               pipe =3D AMDGPU_MES_KIQ_PIPE;
-       else
+       if (mes->adev->enable_uni_mes) {
+               /* Keep scheduler queue on KIQ pipe; unmap all other kernel=
 queues on sched pipe. */
+               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
+                       pipe =3D AMDGPU_MES_KIQ_PIPE;
+               else
+                       pipe =3D AMDGPU_MES_SCHED_PIPE;
+       } else {
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
+       }

         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
                         &mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt=
),
--
2.49.0


--_000_DM4PR12MB62793B6B50FA340D23A916E3945AADM4PR12MB6279namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jesse Zhang &lt;Jesse=
.Zhang@amd.com&gt;<br>
<b>Sent:</b> Sunday, March 29, 2026 9:33 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.=
com&gt;; Chen, Michael &lt;Michael.Chen@amd.com&gt;; Zhang, Jesse(Jie) &lt;=
Jesse.Zhang@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&g=
t;;
 Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3 1/2] drm/amdgpu/mes_v12_0: use mes schedule pipe =
for legacy queues on unified MES</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">when suspend_all_gangs is issued to pipe0 MES duri=
ng system suspend or runtime PM, pipe0 can only suspend and resume queues i=
t has tracked.<br>
KCQs registered with a non-zero pipe slot may not be correctly handled, lea=
ving them in an inconsistent state after resume.<br>
<br>
v3: fix the schedule pipe issue<br>
<br>
Suggested-by: Michael Chen &lt;michael.chen@amd.com&gt;<br>
Suggested-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Suggested-by: Shaoyun Liu &lt;shaoyun.liu@amd.com&gt;<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 22 ++++++++++++++++------<br=
>
&nbsp;1 file changed, 16 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 023c7345ea54..67fb5161c0e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -528,10 +528,15 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; convert_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.map_lega=
cy_kq =3D 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Keep scheduler queue on KIQ pipe; map all other kernel queues=
 on sched pipe. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input-&gt;queue_type =3D=3D AMDGPU_RING_TYPE_MES)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_=
MES_KIQ_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_=
MES_SCHED_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mes_v12_0_submit_pk=
t_and_poll_completion(mes, pipe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
mes_add_queue_pkt, sizeof(mes_add_queue_pkt),<br>
@@ -567,10 +572,15 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu=
_mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conve=
rt_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Keep scheduler queue on KIQ pipe; unmap all other kernel queu=
es on sched pipe. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (input-&gt;queue_type =3D=3D AMDGPU_RING_TYPE_MES)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_=
MES_KIQ_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_=
MES_SCHED_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mes_v12_0_submit_pk=
t_and_poll_completion(mes, pipe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM4PR12MB62793B6B50FA340D23A916E3945AADM4PR12MB6279namp_--
