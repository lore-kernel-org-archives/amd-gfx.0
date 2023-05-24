Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5256C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 17:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592A210E686;
	Wed, 24 May 2023 17:02:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307C310E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 17:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogdByuBFJ7mZ/k3dF3iZxtpUJQ/jI5egLKYPPBO3tI7Vb2mMOD9CagaI9h1QUga1hY/IvqzkoIsqGWoBgCXSUMT/m/t51dnPkDh2VcCVpNEm4Gh1mghJ1tX+F0++Dzb+Jw5KgO6GUqKtL5OhQ4V/OOLG5oKSIJksL3Ak7aPbIK1IIS64e5/lQBg1V4NLofx15rSRHlgldXD+S8xJFAieqjZZ0ZjBJP+eruUmIl1+Mfe0aDmaD6mlIC3IJS5qvSWV0FR+ompdEhzwHsSCblJF6Lc7gV9Dholm4+T7u/IhfHhw77atDkeaP4cTAfIlssW+Q38/p1ClfG1kiqk8CiEjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J64yYv9KWT8klVDlj58G97GLG1RKimGXf1ULNjXC+kY=;
 b=SaHJkYEoCs+DgfbzCN1dZAAKcfKyR4TFQjcjCLDkI6hFBNDHWlaEmHJIOu20CZwBRvIEiAdllt6Lxj7nnQev/uVyqoXU0SmgunP3rRLmuud1cQocNur04BJLMiwN9oP+L03N7bu7qTFOfz15Aqot5l13LjMEpb2wGILCkK4cmFodFIVgbW3+ZO6cwO1ZpRwMdeyhqd5mPFKeDP0dcSvRWXzUNxzHm30vZzrgE7VyQREOcBW9Zk9jzJOub7w+NhCvq+UlpD1jsid9wWd9jI3DfG+2rMkcWhbwbEGtrmixU40FQhuaD/XiPGDPx/FXrV3cCuInWep/ddhM1+0EhPSBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J64yYv9KWT8klVDlj58G97GLG1RKimGXf1ULNjXC+kY=;
 b=YLjMP65bW9auUQu6+lSiR0yAVOqzwbqssxv/7cC0b+BG5NqJKW0yVHIjCq0F0q4O+rLMcb7NiNWDgVtFQUIstmr08IpHFZtYHxh/P3taGxbE2WbRqtjd/FgHbCBo0nxzvdI/1pSdbetyh4HuH3j1tf7YqUAwicfcZ5BR7hSrYpg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 17:02:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 17:02:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence
 signaled
Thread-Topic: [PATCH] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence
 signaled
Thread-Index: AQHZjfk98E9Te8JnZUahOxJDmJ/aYK9ppu+L
Date: Wed, 24 May 2023 17:02:10 +0000
Message-ID: <BL1PR12MB5144B33E00E0639548FD53B0F7419@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230524043527.2807962-1-jiadong.zhu@amd.com>
In-Reply-To: <20230524043527.2807962-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T17:02:10.088Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5710:EE_
x-ms-office365-filtering-correlation-id: 23b64d00-8792-4956-24af-08db5c789d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Pue4dLeK6cFfQOzheeGOmjCjV1ziIRyh+Ful66XZKBWMJnoNRFascNh/ZkD4BQrLFM7aHcONrgbUycqn5/nAhXaBob91R15EjeRBwVpwtO6uROOaK92+XoU+yFCZiebguFKdzNHIyHr/QDkSHwFxjuMATd2QUvkEAJfKLyeqeWvWngORQ9Xv919T3Qty+kek4Dcajo3eXlCfJRwxBC7gnEbFoUYr8kgip5Bar+XFdwrf/nZxX1mafwikEwUajifb8j2Brdz/e4mgbdVeU3TiSxj1aOquavOLEhgPnhS1s7D9sF/uStIFWIgAZ8hWWSdR9iNFu0gq8ArLX9Yof/oMHoRRSdmaRIGUi/pqhgtM6Tl55ZNVY6aiB7rqmEBk6kbS7U4861bKPEIrUc9QSZZzJasIn94FzF93skjMmbxDS+iQDLP8ES3KJ2mechk4dLZMgmM53s/RKIO4RxRgTTVyIBMd1tLT4RlZfJx2SpBENK3JaIV/jRbyIbz6FyudXsQtTmh+VHilrG/zeazXcLIr2WYTSQ18uwapf3ssLOlU8geTRiJvE4+EcAFQe3ZHf7IKS61pS4H7HnxhtsljHnSB0anfKOivumE+WAhAOCIM4P+q43RWZ/3s4HJODRA4Sp0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(55016003)(33656002)(6506007)(9686003)(26005)(122000001)(53546011)(38100700002)(186003)(83380400001)(2906002)(316002)(66556008)(66446008)(71200400001)(76116006)(66946007)(66476007)(64756008)(7696005)(41300700001)(86362001)(110136005)(478600001)(19627405001)(38070700005)(8676002)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xbw+A72FpTtHL1wcy/XJ21jExZEjiUhZj7YuUxGT3XZgygMjM1kXlpfyKtWf?=
 =?us-ascii?Q?hvyUJXPGmKKDQ7+c1nVACXLACiVCj6iUpHrw7OyxCuFvuV75i/LE1YErY5uw?=
 =?us-ascii?Q?lofFDiN3OzgxMrlKugP2157LW3XSuwKaQjJgNYjamCoRxnAJur3LzBhdEYy2?=
 =?us-ascii?Q?mA6yufDq+9gc3iYNrLxZbVowU/NYg6ttpHkJlVbRnrac3HP5BP2ZrTE4Joq1?=
 =?us-ascii?Q?1gZxj5UNto7nLU4gwFardJHIjJ45lI3T+zjYaNPdbGFMcZ9vavBz0070xTOZ?=
 =?us-ascii?Q?BW3b3oqsPw1JI1zWEbNEnuSwyvyQ/jCY3K6yd1p2gXw/8+/5la5PqNtUzc0a?=
 =?us-ascii?Q?yvKnm5nlGu/bLwd+J/llCz0Kb5jIEdxN2L7TYwJiz714B9s+0c+vkVCXm1ne?=
 =?us-ascii?Q?WtpzmCKzI8g6W4GPmKIlrEFw4X6dqlgFoWAQf5Es3FzEwk8DyF04Y+793QXJ?=
 =?us-ascii?Q?HrECafvdeD+fEfpIk/+SLcFlMVKXFmghZCGJ5gcnKnYuxrSfqmyrsqsDgS+j?=
 =?us-ascii?Q?HJVeMkSyMU2GzoIm8h4T1fnIfgmwE7ahVX72xSGUZC0Y9XjmW4Zf9Z6sZcSy?=
 =?us-ascii?Q?dT0sDCNywL0EfWRE7R0ZSCYWbOoAdoLVz5gFPASh7mW2O2Ez2HNwwV827xg6?=
 =?us-ascii?Q?Rv3AeX7O/GxisCTY7GVQCmhv/9E/hQT7JnNPR/lGTSuGiYpcyBRJAxmorBA2?=
 =?us-ascii?Q?81LzZA8m1m3KdwmionKqGea6x27CsY6qUpo6AA0/9sx1fESJBWFDoGuthao3?=
 =?us-ascii?Q?PgA60uffqIK9eeP4jcICCLXLdd+pOmce+4RIIQ9MvPAuSoAAOTY9eKOI3kS7?=
 =?us-ascii?Q?LA3PQoEkbWqg+cLYQ6r/0iCSrNSq4wLohapKUds/wNsM8B6zTNFEaYSDoWFM?=
 =?us-ascii?Q?2325gDE7DiHj6h/SHBrLmGDEVJxhkApDrla3vWGuIEktyyrgABVhRj0d++ej?=
 =?us-ascii?Q?INubT80f7QdQYF2W88/Wfv3kLgluIzbf7IcCTBD9A9Dh8Gjqa47kT+lnqHQk?=
 =?us-ascii?Q?XL8dpldI3JWRozXEqMntmUDfUAGEZff4pbDj7BVtrlZzW9t16Ble3Bqofb5f?=
 =?us-ascii?Q?jCNPqGEIVo7DzupQ2qUbQKHxqLsdO75tREy2EhbVbSC0f42NVcLkTFpTFQtx?=
 =?us-ascii?Q?mUn+LCCaDgxTH80HiDUaJvqodEevCVCs3xPBThzgO61FguBqSnY6hdA9hFDd?=
 =?us-ascii?Q?tDfYAxxks3B7RimcRN2Byuwi5/TChmDDYAdLeCTP2iW2NV8AxMJIOCNjt3Yd?=
 =?us-ascii?Q?9b5omQE0M42wwvaOZpTHQUrEae+D0iJcRCw71FemXNXVgNmyPvr04MGU/kQD?=
 =?us-ascii?Q?XsYgMPkjGc5USo7H3DDk/Es57sI7FVXk8PQKkZqEPoGY/UNFlmBwe+C7Kyh3?=
 =?us-ascii?Q?r/ULC7KnjiJ8hKlYfR04Yb9f6+KDCpNqMY0tQtHqE0kkKtREELwWXxf+5CCr?=
 =?us-ascii?Q?uJiyzFVXHScl4mSZpwlqXfZzGUZthoWDOjVjZrqOWoDla0On5vzBdEhUUV44?=
 =?us-ascii?Q?DEWXrJTxYsFmUx5tgLkCfMkLnOtCgrQR1p8qzuGAnwJofjNY67MuTyDdd2NG?=
 =?us-ascii?Q?O8jL+6DiUdoJrMkLEz8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B33E00E0639548FD53B0F7419BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b64d00-8792-4956-24af-08db5c789d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 17:02:10.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MB0CO+sULxG3xjOVXbj12Lv19S6jCCeCz8zlwWwKjvIrJyFg1ShTWU4vPocZEFxhLZ3b+3YnoDm06zfOrxoN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

--_000_BL1PR12MB5144B33E00E0639548FD53B0F7419BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of jiadong.=
zhu@amd.com <jiadong.zhu@amd.com>
Sent: Wednesday, May 24, 2023 12:35 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence sig=
naled

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

When MEC executes unmap_queue for mid command buffer preemption, it will
kick the write pointer of the gfx ring, set CP_VMID_PREEMPT to trigger the
preemption and wait for CP_VMID_PREEMPT becomes zero after the preemption
done. There is a race condition that PFP may excute the resetting command
before MEC set CP_VMID_PREEMPT. As a result, hang happens as
CP_VMID_PREEMPT is always 0xffff.

To avoid this, we send resetting CP_VMID_PREEMPT command after the trailing
fence is siganled and update gfx write pointer explicitly.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 8bf95a6b0767..cbdd9918b3e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5402,10 +5402,6 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ri=
ng *ring)
         amdgpu_ring_alloc(ring, 13);
         gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
                                  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC |=
 AMDGPU_FENCE_FLAG_INT);
-       /*reset the CP_VMID_PREEMPT after trailing fence*/
-       amdgpu_ring_emit_wreg(ring,
-                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
-                             0x0);

         /* assert IB preemption, emit the trailing fence */
         kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP=
,
@@ -5428,6 +5424,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ri=
ng *ring)
                 DRM_WARN("ring %d timeout to preempt ib\n", ring->idx);
         }

+       /*reset the CP_VMID_PREEMPT after trailing fence*/
+       amdgpu_ring_emit_wreg(ring,
+                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
+                             0x0);
         amdgpu_ring_commit(ring);

         /* deassert preemption condition */
--
2.25.1


--_000_BL1PR12MB5144B33E00E0639548FD53B0F7419BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of jiadong.zhu@amd.com &lt;jiado=
ng.zhu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 24, 2023 12:35 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhu, Jiadong &lt;Jiadong.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fe=
nce signaled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
<br>
When MEC executes unmap_queue for mid command buffer preemption, it will<br=
>
kick the write pointer of the gfx ring, set CP_VMID_PREEMPT to trigger the<=
br>
preemption and wait for CP_VMID_PREEMPT becomes zero after the preemption<b=
r>
done. There is a race condition that PFP may excute the resetting command<b=
r>
before MEC set CP_VMID_PREEMPT. As a result, hang happens as<br>
CP_VMID_PREEMPT is always 0xffff.<br>
<br>
To avoid this, we send resetting CP_VMID_PREEMPT command after the trailing=
<br>
fence is siganled and update gfx write pointer explicitly.<br>
<br>
Signed-off-by: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 8bf95a6b0767..cbdd9918b3e7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -5402,10 +5402,6 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ri=
ng *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(ring, 13=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_ring_emit_fence(r=
ing, ring-&gt;trail_fence_gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;trail_seq, AMDGPU=
_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*reset the CP_VMID_PREEMPT after tra=
iling fence*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_wreg(ring,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* assert IB preemption, e=
mit the trailing fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_unmap_=
queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,<br>
@@ -5428,6 +5424,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ri=
ng *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;ring %d timeout to preempt ib\n&quot;,=
 ring-&gt;idx);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*reset the CP_VMID_PREEMPT after tra=
iling fence*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_wreg(ring,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(ring);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* deassert preemption con=
dition */<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B33E00E0639548FD53B0F7419BL1PR12MB5144namp_--
