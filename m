Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF563CD11DD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 12:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5138710E745;
	Tue, 26 Mar 2024 12:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1tcb1RU";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2106.outbound.protection.outlook.com [40.107.101.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF71E10E81E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 12:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrIzGvyaPdnb8dVKADFrD/KvSyIFwS6krKFHaZpTLbRG4qgYMFqUg+2eddCaPiYI7Sx7l6M/ETS5naT2S7nXuMuJBcNJsIO8cB1zY3RHzUO3scjnf0AylDgnkjdlbWrHYEx9nQoB8HanR5Hh1WJekWa/wt1CQkyavb0PhsQwqIQXjv3yu9vQGW7mocX9TwGnrbfT2I+Lr4GXYrry4p7JUjEveR5COFjUar5itcd3ZKXdqC55asM/TMxF5wkP9rVeWCou86ynLu4/0ANbhfD8MpPTOHPv/iKJ+l/eQWZjtSIJ90MmmqDVM1F2gWhqQ3lK1Z4rxcx3OQapX0lAQkCGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9hOAl+iXOFpCMoJLOpiSNX2NkFm1AbQPVuXMpFzUDM=;
 b=ixJ0M5ZxBJ1kKuJQ199n/Qc3w6tAmxGJM4Dn3TXHZZ9lx9L0UI7GrRvzJyrJKIRfvltCFoIghqRpZ3rvxU/9YUSxTwR7wVKnWcEy41hDTZY2qnNCW/4XPcCfxmXuskS384YCN5xu8BEEf3VDqIBImcvTfTG3s9I+ww84biObrWWFsSI3ch1J3M3tlX8JRBEarPJ+c7Xjb7LHoDFbXyx07TuGHyw7Bh579ex5XaUiG13Ttksso7MuPpFzoM96gY8Hgh8lrLtDVvOgmr2SMvAvk/DAPQ3smUKWGGtpN39VjE5nSrcXbgRPZzu7A4dnaJJ6qDmQ9AkjdrXfUoorJNSzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9hOAl+iXOFpCMoJLOpiSNX2NkFm1AbQPVuXMpFzUDM=;
 b=G1tcb1RUoEb1vdXB2QI1pCiGcnsSTFBiNC3pCChoXpDS0QjhZOCvbu1uw6FdeRTUuPja/X/FJKtEiGnzR127ddq3zfCJvFegGl5IG6wHJv+qpMxFits7yOYGVa15jPCOv1dM0cA+x0gGiH/PMI5omAPmxNBnNe47UAvCS+pyAks=
Received: from SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 12:28:19 +0000
Received: from SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::43e8:58fd:8ed7:2bd7]) by SA1PR12MB6680.namprd12.prod.outlook.com
 ([fe80::43e8:58fd:8ed7:2bd7%3]) with mapi id 15.20.7409.023; Tue, 26 Mar 2024
 12:28:19 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "mdaenzer@redhat.com" <mdaenzer@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: add pipe1 hardware support
Thread-Topic: [PATCH] drm/amd/amdgpu: add pipe1 hardware support
Thread-Index: AQHadp/IwvLxLJiFEk+8jYNWxsoidrFKBG1g
Date: Tue, 26 Mar 2024 12:28:19 +0000
Message-ID: <SA1PR12MB6680EAC544D653060504DE83E9352@SA1PR12MB6680.namprd12.prod.outlook.com>
References: <20240315061226.1691633-1-zhenguo.yin@amd.com>
In-Reply-To: <20240315061226.1691633-1-zhenguo.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=afa8d89d-5fcb-472a-9fd4-44e94f06567f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T12:26:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6680:EE_|IA1PR12MB8222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5By14Z7BCWvf9IwcO5AOurrICtiaaMULguUhWYCaWAREkQKZNNgU7MxDw7TV3Mdo13smJFKk07hd2ffgVAa0aPN/N677Q4dTEbPaentGgqmCChMIA72lahty6Qz0pjqomyycDT5VPA91CEiUwgFPdsfpNlPZwCEBjNusub03eaH2gA7UTRD0GijI34hXJbGsgYGFgu7fpZ2iJgII3qpqBHZx3z6ziegx4KsADmLgAfMvfnPUmXS4fsh9+Co5IPoAPnqKk66Iq0MoN6eioDlyP7suSIPBVhCp90XEzpSv8FFUWJrStq5LmhGVih5gYlxeyXR3rwn/ZF7zstnFncmrZeE8/WjOaMjc8y3TFb4AIcqulhchFXqBuCMA47Z2cNCyoLoyQb9vNhV93ToI9DPgpb0cV1E5tPm8MS7V4D0xSqyB/djkd8TM0MJuG7pkJNIVtqIow/RWGVep2DJdEIlWOBnzC2JOdgO7Vp7MiCrfGyvbMEh0Uleh8Bbe0zjUJp3CpnG4Ar9b2wLLM6WerQK0C3klvGttbYeSTNr7ChEK3EmDpazMjCiE3UBs7devrrPEKXV1y0y4FLcj05gYiT3HomnpOtRPu9WNAUDOoCIjcI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khyqjDYL1rTUHvxeZ2hWypEdTh7nm4Y2jMM4FDVlgzGqQC+Yrd5XAVzlWhVX?=
 =?us-ascii?Q?K5qmIzkYJp2D2vJ7vcVKf0ovwps/N5TngiuUrrwthZ320D8TswKb39csDTJa?=
 =?us-ascii?Q?TVk4tmepJMXcgo06k+lQVdgRI4YlA1ssrFUkAHjK4u0jh5jtnZTjlRG3cHUe?=
 =?us-ascii?Q?6L7BBE/apmBKDetxNvwCrtOvVwLZypZR1v4FW7fOZOOouV+APe0nc3KqyIes?=
 =?us-ascii?Q?4ktb9BlRNAr+NaVmMglo8xj+ml1ueonrP7PedS50uT+kYtk3I3GH431lxHQw?=
 =?us-ascii?Q?ReMv3/27se1dtblnEGSknDlhXAy4OEyXvZlGPCUEG/1+RVySiOnehf816I8w?=
 =?us-ascii?Q?rMBLPX1qF806/iUQcGrycU/vXm7ouSSkrdKDY8JrD774rRKDHXY5W+U4LFKp?=
 =?us-ascii?Q?0RLDkinH+uLUujaftGfxdYTx6ECM0xOgo9lgeRNzb9asdiwDbFkQYV0l2U0w?=
 =?us-ascii?Q?MhCbeMmsREJsjVm8orfDDJvJ5GE8VFyPvyoPpUXC/iomdiBsucG5K4V81h5o?=
 =?us-ascii?Q?5Ig1+8cD+MtOqhIzUxr7WEFIVU6YR57mPEsem5PU5/Kk305SLD5sYocNQG5l?=
 =?us-ascii?Q?qEidDFNo2PNdeFU79yA4MsBM0CIyiCzmbmY1+IzPvZWGrx33CVxJVp7xcxse?=
 =?us-ascii?Q?LRV+QhI/QkXlpJYf5BW8f0oElHd6BTgrA//2P+SF0gAaY/78jrj0kIKCURPY?=
 =?us-ascii?Q?dw11zMNtuh97PUfBxRy4l51qItJEum+biNwcOJiiYI/qW9hq7lJ6GiYE/aeg?=
 =?us-ascii?Q?lJOktg3M7h5hypl5qOsOhiEGLeCYE6CDQPggVpXGvu6R1n5gFfJlhHADfzRt?=
 =?us-ascii?Q?LYkQ3xvL7mNeIPM7V5wOdx0mWkFqqy6BK4ZUNvuj4WThFYp5L86oqtVXyLVi?=
 =?us-ascii?Q?19ZESnjeNPktBnJZQlciE6t6epfItoyYE4MM3k2/bd8TeZnNXo5m/JI4+yfX?=
 =?us-ascii?Q?DR3cl4E4KuojeF6e2j5i/S4h6L0YCtg12mySAa00qzBqDIS6ccZolorkLINc?=
 =?us-ascii?Q?IDJ74sHHHx1w31FHbuU2y/PM5x6NyGtFUyC2TDnw43BjTPq2v2LJXRLmEFZ7?=
 =?us-ascii?Q?dFs045Nyc+tOVGpc/0VCfotYblzUna6Ai1Q04kGmteOXbszBho4SJyTmVWxr?=
 =?us-ascii?Q?Dm7YqjDwRRFo4+MJQgGxm43LnYLOc/VshuhEJ58eLUbNXoZ/co+O13uU+Gpe?=
 =?us-ascii?Q?AJiBXum3i4aT+vv8G3S9Wr2qtVgud9SINjKiqWDtmaDsBJI5irlGNfS7ACio?=
 =?us-ascii?Q?7NERf6kdyZbiL6Ty1GC83VvxH8ocKXwOuTSmX7GNJDf97yaAuKnXaBkUyQ7t?=
 =?us-ascii?Q?0h5oN2jd/UbJgZTJi2j1GOTfy8eNOPFhRsvl8yjC03bAhe6QdMs2cqsQiLAQ?=
 =?us-ascii?Q?l+5PKwzIbFg2SmM12OoMbJmXU53L3RAyTWelQnni74gjY5NzjUC13Sy3VgGm?=
 =?us-ascii?Q?uP4//Q6L4nP1tnvzzL1Z3JlO3kekPyK/4msCMwvVQkkIYLIXMNhav+Y/MCR0?=
 =?us-ascii?Q?25v11PMLiSzErn4vYqRYmND+A0D6otWRzG3KD/LFCqHVmxnQYsK8bt2Rp5Gp?=
 =?us-ascii?Q?ZGpEAC6hRTo6k56xDEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92d610e-d04f-4298-fb6d-08dc4d903837
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 12:28:19.3249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhlNFXE+GadSXtghIJ2xyRi+/q04YI/1UIdsEIM6nogl0GCRRWhgoFkMuMXnBJ1V6DHFM/sSL3/WmZO2Cm8Mqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222
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

Hi, Alex

Could you please help to review this patch?
This should fix the bug: https://gitlab.freedesktop.org/drm/amd/-/issues/21=
17.

Thx.

Best,
Zhenguo
Cloud-GPU Core team, SRDC

-----Original Message-----
From: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Sent: Friday, March 15, 2024 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: mdaenzer@redhat.com; Deucher, Alexander <Alexander.Deucher@amd.com>; Ko=
enig, Christian <Christian.Koenig@amd.com>; Paneer Selvam, Arunpravin <Arun=
pravin.PaneerSelvam@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <=
Monk.Liu@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add pipe1 hardware support

Enable pipe1 support starting from SIENNA CICHLID asic.
Need to use correct ref/mask for pipe1 hdp flush.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
Fixes: 085292c3d780 ("Revert "drm/amd/amdgpu: add pipe1 hardware support"")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index f90905ef32c7..5eb6f189920b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4518,7 +4518,7 @@ static int gfx_v10_0_sw_init(void *handle)
        case IP_VERSION(10, 3, 3):
        case IP_VERSION(10, 3, 7):
                adev->gfx.me.num_me =3D 1;
-               adev->gfx.me.num_pipe_per_me =3D 1;
+               adev->gfx.me.num_pipe_per_me =3D 2;
                adev->gfx.me.num_queue_per_pipe =3D 1;
                adev->gfx.mec.num_mec =3D 2;
                adev->gfx.mec.num_pipe_per_mec =3D 4;
@@ -8317,7 +8317,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdg=
pu_ring *ring)
                }
                reg_mem_engine =3D 0;
        } else {
-               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0;
+               ref_and_mask =3D nbio_hf_reg->ref_and_mask_cp0 << ring->pip=
e;
                reg_mem_engine =3D 1; /* pfp */
        }

--
2.35.1

