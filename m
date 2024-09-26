Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC81FCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CB610EB18;
	Thu, 26 Sep 2024 09:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JN+hVJT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9B610EB18
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBaRyFyuYgAVzl3D8PRBK0DbWA7YAc46kYuvrLmXXKW7ktmknugfn3gC3oAJ+Lm0Wy2eRWJC0ROvW1b2dsmsHltLPfpQpcdUSnb0/c9FKzqdejFglpkwQDPyRquxhlkCmUrZbZdbPccptsxtUqQ1vGUbJN5FSdK8C2/nMYrzQmioe7Dv1M3Np90u5lwFElcIC35HLRS2Q4IWIvF/YsV+7wVUeWbQu9hX41jEQkFAKvQ3GgXlkTaRWqEAc6MgIcl98aSaK5wI7MfCHQ44b9TXv3w9J+4pmt0x4Rbmhu0l+uErNUWQgcoXt6USdT2ItwyblHiUHSXCeuHS2EC6PNFbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BywQtNqxdIXi4rrWKn2KHyEAVYEu6omCs/gqd9M0p+A=;
 b=oc1ssV9PUWGWZOmwHj249OtDnvWyo/kzb4E8KxUdySREWhi6HWl4YksK5bmxvZH1ehk96XlUjBhus1hub9HToW3TZo/AIhd08hvFF8k2N3DgSxlNa3GU+8HrUCSPnh/VIqCTpfL72rqv7y9zs0BcYA22IFZ46Wxe6Hr42ChVjZlL96aj8ZJX5EMBZiWVGAP/Sh+OeD1bvRtwoEw1TNfVBwlZ/DlpzIxxtK3pJ24OKB1cNa8Kpv878PM/5dy2etkCENVqPt0tIBCT/oJEV5BLAWRiwYsxLOcMWsTXrKSpDFeOGUhc1Xk9m2MWCk8Hn0CAgxmRs7FQkk/EUor1NmGcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BywQtNqxdIXi4rrWKn2KHyEAVYEu6omCs/gqd9M0p+A=;
 b=2JN+hVJTi/f5KrmVVPtFmYKKLYTo/kC7GiOSPqWgVGuIAmfFH1vcGLbrEvJz42IolKgeIoev5Psk8lsShuIE8TIDvJ1mw6yitO9bWbQhPV9WuDJfXMP19fzQfxYgg0pBq0nVCttsm6x1k3uuDvpN3w1NbUFsCPXHAe5QE0awKVM=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:01:08 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 09:01:08 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>
Subject: RE: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
Thread-Topic: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
Thread-Index: AQHbDkao2RRBRPsDdEiDYXYh1XWMLrJpyA+Q
Date: Thu, 26 Sep 2024 09:01:08 +0000
Message-ID: <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-7-lijo.lazar@amd.com>
In-Reply-To: <20240924055652.2678433-7-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e06dc962-2e70-4fd3-83fb-ee21b17bac5f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T08:58:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 1f6242d6-5e80-4214-668e-08dcde09c2c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vm+jKpIZCE7nwc2usbzeeqUSyPg/wHh3hrHrI+ShjIgWx5hZ9ObuOvBmEeUD?=
 =?us-ascii?Q?LLaB8vVsZUmA4rxV/KoWBDv3efB/VmTzQQz3nmGOwG2L4uhk62npePfSaDAv?=
 =?us-ascii?Q?BOSPAP6v7yF/zXvzlgyhBAUDqTUEh29GFoIhGQARnjhd0pfQpX2RM6a4xjYy?=
 =?us-ascii?Q?ERLBGlnXp36erjhyUruh1OLSJGSQtUPJFL8MGIezYPubX9uInggyz6er9LGv?=
 =?us-ascii?Q?yAIvKhZfC7dg7I/YoXT9gOl//0ES0P1uNyMIZQocfbuP2eaoV8/V0Fz9+pvR?=
 =?us-ascii?Q?CQ/6SYxJgkAxh0X8Uuhj8wqcpRDf3ECenB8AwDBxDSAWAs/tOYTBeC5oUgiO?=
 =?us-ascii?Q?JR8GmFG+kFmn8K2m9rAYSKCGSJtUZvl8zFj9G0WhNxRTpCcuk/nWbAoqnVY3?=
 =?us-ascii?Q?UG6284pxb+dfYrwj7yBebwvvUmq3HN0v2/+i8aHZY0YTH2B9M5ghjfLKPjRu?=
 =?us-ascii?Q?heugZmhIAjcYBiKUllMjShtJ2TRHWxkx+mrvaoF4xqfRzw7UB9I3e/9W40JE?=
 =?us-ascii?Q?ZtKiaaIWPb8y3YiX5HG3mfDtHMg1wbt4xaoc/xTZhnK30Kkr3DR4hALiLiTY?=
 =?us-ascii?Q?tt4DgzhpsATo8lo10to0RAUBMIAq+S5r3O3UPUKiFLKZHkBRHxgK7ttqbk2C?=
 =?us-ascii?Q?X1m7/vuuJRO2915mq30Qrbhkxi9Jw4B1sNJfThfJWY0CXr/+K9LfCv9Q4GJ1?=
 =?us-ascii?Q?Z6wTIvQ9fL42opgQTNL3jNv5B7/FLLuKHHhdTdxOvbk1vgkAbstdyQ4LpdRc?=
 =?us-ascii?Q?rD+npyaDUzUDtUH9txvN+IkronTLawg4c5haHCRnODN4vtKbHpmBT3juGoWM?=
 =?us-ascii?Q?40GtTl9gYwsXi9gwUIUndQ4623FAfBMG4774Autu15+1/xpPvhZviiGU0FSt?=
 =?us-ascii?Q?SdIDVKYTliSy+YuZfo9bllb+IgA2OwjbXDfWdHohfrEDJcAqQeMFNByMARjy?=
 =?us-ascii?Q?VS9Ov8sVENFjWzZY64q6fifBoKUUYvSZQCf7gIndZ/lMpbd5FFmxqv6LQila?=
 =?us-ascii?Q?+6nZjSQDCMtwOWWpujUhb9vJy4bX6HNNk0QCyCMj+NaTR50h0AAkXh8uxOyV?=
 =?us-ascii?Q?/r0Z/KuxZ/yCmsovSqy3piLuC9BwY13oQ0PJFmTlaQanRn3HhUk43F+kR+s3?=
 =?us-ascii?Q?1DJRbqZnP4RvgaaOaPKGjiVOSeP+Q+nIYL+gWSJRuJMucCFZHnrDuSRJrhrY?=
 =?us-ascii?Q?Zc6fzo8+1Ll+RZCNDZd1cGOyOaIV4RDOdXEbGyXIBhlL3S/KMlBHeR44vLxZ?=
 =?us-ascii?Q?FUgZl7pEG8b+rfTc2z2NPmzpP2PTWN/t21gwUq3kp08eApB9ou+k3B56Otar?=
 =?us-ascii?Q?ikicMyBEc0tMrNx6LAf4706pkTBvBLzn2KNewa8My0CoMy3nd7rMAkk5cZj6?=
 =?us-ascii?Q?TohrZUECEfvqAqgjLem7VgkMo9icEDkzztHHFZHItm3fjitKjQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WAsdp0kwoI/9/MX0dz2OIUXI7YrCvTL+ANLW8PK0Y6LwQqALULM6QWlkG9zi?=
 =?us-ascii?Q?xOqCKzcHFgGPMwXe5Aaq5DCfr8cGijlUKXiFSX5JhH6bNSYUAY48DOTJ+Dw9?=
 =?us-ascii?Q?CzoLUpwVNMowiqhoyNKfBHLhuGQkVye175YIZHAp43UqWrX/jUOlMF2Wp9dz?=
 =?us-ascii?Q?LsucOLRt7RktNpiZX26678xQ9ejMrunHOtUpREU5UXwnuQKbccNpfsTCppXx?=
 =?us-ascii?Q?/AdxDUd4UwgrN3xz15yFctRd4JW9WmkHGr6v7SHqkM8hUOrSlJUoLrIcSmZ/?=
 =?us-ascii?Q?7VI33CykU6sEE93rGJ2MtLsYDLMg+vNhC04KSVF8sWozEM74ix7hrLBRPhFY?=
 =?us-ascii?Q?4wwxdbiSADX9IdAkmUEzhyZxEOeL3LaOXchmydzllAIOQ3wrbUjzc9wv9UFV?=
 =?us-ascii?Q?QNwM3MYjXGsECQPl3fvoMANPB/gSxQc19J0IjtBOquEvaZrj2UadNChrSrvW?=
 =?us-ascii?Q?FRo/sRuIAs/alZ4ERCbsEAYpDqN/vTV1IuIHk+ZeoqWAKR2uLli8fK2itFJy?=
 =?us-ascii?Q?tSnro55BzN+N5NCvljfj3/F4rlWAvkFm8rCznjBbd1XsoKGfMEO2nZkizU9a?=
 =?us-ascii?Q?+Zu8XKlc2GkGHVgHeam6NpycHwy8PM6WW50vhO9JiuzZXBhBsgpN4r/OiWU1?=
 =?us-ascii?Q?kGeiesin7nkvMLH20BsLca6b9Fm8g9H4G0Uj+5Zi5j1OK0EwW6LZwFnvvtPb?=
 =?us-ascii?Q?qQEOMnL2Ll2yfQ53gBLCI1t1sYHml39gn2zklbJZrV1iATdqOxFhJngTQsnY?=
 =?us-ascii?Q?AHY0o/PBMAm/O/xKv21pBqcZuKZn09FndJYL1Evszn2wQphH6oFmxXzeBUok?=
 =?us-ascii?Q?v1PPD++Qcy6mUCuUKjlOIuuq7Sx3jsg3Qr5L8nP18wwB3jp5uPz899a+xFuH?=
 =?us-ascii?Q?1sDD1NctkeJukZRvvjLBvf4PF0r2WY78PyrliwqFVK3R5FdGjM+qhMBC9Yau?=
 =?us-ascii?Q?LKrc/ZyxG3ZWYEAJvyNdC79HY/sw8pPLnGUiEUY6CnuMDX98/4gjWpsr1e9z?=
 =?us-ascii?Q?JD4p7tbKukBT7ZxF0xSgcU4lGwefGBgIMPdoe3L2kGT8qh4GFkkDw55JFOWR?=
 =?us-ascii?Q?ppIs7GYbKLLFVF4TiOh7jANnvaQ9ERKbgAMsxmq1x99gyvKsuttBp22ZK6t8?=
 =?us-ascii?Q?GxkxLcLaStBIaAbjMT/pzAV3hR8XP0lqhyiSedxLJ8UkftdYazEyAij1HxOO?=
 =?us-ascii?Q?UX1fiDAul6ptuGJGL6ycKwwmFgDKeTyzK055fLUpg9U7sREd5gpRSI+i0BxF?=
 =?us-ascii?Q?+tIU3V7LNajnMtwhLKmCFq8sor+zcvNgnsJAkCAqHAJGWZEWmYBH9kRUgo88?=
 =?us-ascii?Q?PgXOecGEbQc4aoNQxlxGMo5lWyCiQqDBNbYV2bWbkE3FRvLEaAmdR4NA2dEb?=
 =?us-ascii?Q?IjIEsZ7E2Ovch5VzSnb174tj1/fh8l71q/cCSMH81AwlDkNoabRIGSYlsvqM?=
 =?us-ascii?Q?UMulC0+vmkp6U2UmQqfHEqVZHVhHLFZwQswTAvCxAgffGXDHuQufsPURZoD3?=
 =?us-ascii?Q?PuW9xdLnIv8kBf5xmn207GBbsyJtDNMUu9/Bx9PxLlGafzdr3WLQbV1Q+7WQ?=
 =?us-ascii?Q?ayPDxtW/ZgugoxU794A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6242d6-5e80-4214-668e-08dcde09c2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:01:08.3481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9Dm2xn01WNcKms/EgRcx39Hel0JUoXmFEwXx3jS8Q8IZExrYSNTOrg88zh/TdTq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

[AMD Official Use Only - AMD Internal Distribution Only]

>>+     refresh =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_X=
GMI) &&
>>+               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);

Is there a corner case that reloading with a different version tos and refr=
eshing nps change co-exist?

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 24, 2024 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Ra=
jneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.c=
om>
Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init

Add a callback to check if there is any condition detected by GMC block for=
 reset on init. One case is if a pending NPS change request is detected. If=
 reset is done because of NPS switch, refresh NPS info from discovery table=
.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 21f1e65c9dc9..011fe3a847d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devi=
ce *adev,
        struct amdgpu_gmc_memrange *ranges;
        int range_cnt, ret, i, j;
        uint32_t nps_type;
+       bool refresh;

        if (!mem_ranges)
                return -EINVAL;

+       refresh =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_X=
GMI) &&
+                 (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
        ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-                                           &range_cnt, false);
+                                           &range_cnt, refresh);

        if (ret)
                return ret;
@@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgp=
u_device *adev)
                        adev->dev,
                        "NPS mode change request done, reload driver to com=
plete the change\n");  }
+
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev) {
+       if (adev->gmc.gmc_funcs->need_reset_on_init)
+               return adev->gmc.gmc_funcs->need_reset_on_init(adev);
+
+       return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index b13d6adb5efd..d4cd247fe574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
         BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) =
| \
         BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))

+#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
+
 /*
  * GMC page fault information
  */
@@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
        /* Request NPS mode */
        int (*request_mem_partition_mode)(struct amdgpu_device *adev,
                                          int nps_mode);
+       bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };

 struct amdgpu_xgmi_ras {
@@ -314,6 +317,7 @@ struct amdgpu_gmc {
        const struct amdgpu_gmc_funcs   *gmc_funcs;
        enum amdgpu_memory_partition    requested_nps_mode;
        uint32_t supported_nps_modes;
+       uint32_t reset_flags;

        struct amdgpu_xgmi xgmi;
        struct amdgpu_irq_src   ecc_irq;
@@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *=
adev,  int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
                                        int nps_mode);
 void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);

 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 619933f252aa..97ca4931a7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_devi=
ce *adev)

        if (amdgpu_psp_tos_reload_needed(adev))
                return true;
+       if (amdgpu_gmc_need_reset_on_init(adev))
+               return true;
        /* Just return false for soc15 GPUs.  Reset does not seem to
         * be necessary.
         */
--
2.25.1

