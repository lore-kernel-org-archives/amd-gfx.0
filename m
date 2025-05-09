Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC09C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 15:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2781710EA98;
	Fri,  9 May 2025 15:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLT2+fZG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A640610EA7D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 15:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EONw0Q6qaRpUKqOd3odYgPtkklS/lnF/cNqhFFHp2Yl//UD6eK+m99rv2WmxoE1E1kZ+9NrrcOJw8Jojbb6zVJnRk5oStaKdd+wP+5pMwPw0yi3q94/KJcgLEw0F/FAZZCk5BhbRPtNEBzgTAE56TNoO8ER36Psw9wUb3SBBorFK5v35h7gn9hxPy9rPuYnFwFDBt6bJGkP64NtaJIiTKAqzg0YUN8z00M9v6QDScCm/Js3bdPK19EUIeaii0mFC1N43wk+tXpb1DPea9PVX8NgKySHiUvXKVE1OtU+y/1EMFZi2AMgGQMY6a1qXkH8EME5oEFODNAarQgaQaoTFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9X0NYyHnFLeG+1qXeKXLL9FYo05QICLTjnftcrJzjA=;
 b=Lpck3QvTgX6ihn50PoZSRieKi2mSoYbFSFJpxjC6BPtN0qsG/0xozmwm3hFID3cXPVuaLgVQCYfOiT63kJEmqLFSMsVs+rQpGDb2Mtm2ogw/cLEyv0JumgTHo8L74qFxl8ojDxDHXeQOgphaHj8b3aq1nntXTrGXDkAG28FztHFnkTzbNNmW5s5V0cDSRmuLGaFbscNuN+vQuGOuL4wL2NYy/WHLq53VhITdYQkKUSJA/PoB/7l3B0UGVKx8iCN1k7KSDyCJGJUl5ldq1nv8nzkA31du6fFgGrNV/RFLdcXicHSce3Bu5IHgg6Fx8SZbqBZCgYjzweOwInfGo/o8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9X0NYyHnFLeG+1qXeKXLL9FYo05QICLTjnftcrJzjA=;
 b=FLT2+fZG0gDqJ9EWbbUZH9Wmd83VtObraGcjRtvRaCKuTuvSvxhABU+0h7tFm5lHnjkj1naM7TzhD6vJw405wtOFmKeogpOlPX6B8R1+QbLohrrLra/omdiqZYcypYjyS7TDQIlCwGg29wdI51iPhSDdch5KACk0QIEH0XOlUx0=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 15:43:50 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%6]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 15:43:50 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chen, Michael" <Michael.Chen@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues
Thread-Topic: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues
Thread-Index: AQHbwD4Oc//pskcLIkWqhoZJHk58rLPJDnmAgAFcVxA=
Date: Fri, 9 May 2025 15:43:50 +0000
Message-ID: <CH0PR12MB537241EBAABDC627CCE09592F48AA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250508172409.3183469-1-alexander.deucher@amd.com>
 <DM4PR12MB6279EDCEC972305A5809AD87948BA@DM4PR12MB6279.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB6279EDCEC972305A5809AD87948BA@DM4PR12MB6279.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-08T18:31:56.891Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA0PR12MB7480:EE_
x-ms-office365-filtering-correlation-id: 634d103e-b2d7-4c44-bf7a-08dd8f104b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Pgfs0vP7yTRDfoeTPESjt9MwPSE1IsTRs+hPlbZUWRKAe8SYOhRaAbBdoes7?=
 =?us-ascii?Q?raK9mzjTF9iNOmby5O2ba0Vq8T5+t5l0jm03hNu2upi8pVeGQns38SUtMT1D?=
 =?us-ascii?Q?9Vih0lQA8L2GbQTZfEtewAVG3ZiDVIxQdkPup4M99F2HZwqxESbACC9ZfAqO?=
 =?us-ascii?Q?qFTSZ7ggbnXdNiBpNVZm9ZnPbCwv++EKN3GHEZG9wRjfXt9WMy3/x1QYw8A7?=
 =?us-ascii?Q?Ck8D2JFtwB964QRDgbdHOzI+w/eoLAxrKm9TbgUfsI+AG3vTnfYZrj+A/pkT?=
 =?us-ascii?Q?1qVoVD87Si9xWeYfj0yZZStppM+yo0FYuf3nV+aY8k3MMcZb4cmvKPmYOmW7?=
 =?us-ascii?Q?AF8IHwZypdiD44LhM3bZCqIdu+2M8I/44ABnPlS9h993jAfVetJBJYvKdlW1?=
 =?us-ascii?Q?vOEk8U77LnK2/cSUJ4VNNb2NL8Rm955KBi85w8uumWLUsgEp0F9UX34wwbeL?=
 =?us-ascii?Q?/v7lDymT4QcxbiUvwPoEEXyS6VAYYEbSdnodcYconEq+FekcIFqgVDFeFEqZ?=
 =?us-ascii?Q?qhujQspp7pMRQQvhiyUgO124FMuYSMPX2qPWnW5Gw+I6yxr6j3kgen0ooy4a?=
 =?us-ascii?Q?13dPSLCR9rAknjJ9TOT9//qF3ZD7k7ZCLkN47i+gDMHawEAFbJTYDuyeE1Jv?=
 =?us-ascii?Q?8ut9tLVh7QxzkqpidDDixn1RD8VgVn/WwvYU27c+SnD5lRZBZ2sNpp+TG1Kj?=
 =?us-ascii?Q?sG1YymUOAsR0aPLubs6KlgjVnQfbl85mEemvWheK6Pi/7wZ4COvinur21Lgs?=
 =?us-ascii?Q?A0V0ayIH4zpjCSbeSNnicU7tsVImOVAgPgdIVeXMoN1HbS+Rk85QCToPg/GS?=
 =?us-ascii?Q?lAx8q6TjWQjzRGJBPt5mxVw3CMZDHrhSJDa/aAhT2MB2KTfDygYj7lXteb7+?=
 =?us-ascii?Q?oFGbjpuNRf68Uy1lRTLhTFQizcG4cJSQB0tm/RZFjYGWeDrzxggDgjyqql0x?=
 =?us-ascii?Q?E0HczjU8wvCiTtDFxCfcH6uBARc+0mNOEax2qXj2tJrkJLEIGYooCHMt9y8S?=
 =?us-ascii?Q?HaEj3RcOENTMJWIv0JmXgeqitK2FevgtobLGFAinJpVUtRHP0gIeDIlzHx+b?=
 =?us-ascii?Q?mWdIZyl/kJ8EajELuc87Pxebmcrqe/snKA2qkG3prpegUmO2NV3ao12jj065?=
 =?us-ascii?Q?wQZ1Aj+M31/IMoFrIxwXIhoZMd3cUcDNdbuHuitoao/GYft3esPM0ZWKFNyM?=
 =?us-ascii?Q?LK1Lr34hjppX4W/e/JWNpaShDCsWQNIElhFb8RUxfLkrbbKEpLYY++dEqMi/?=
 =?us-ascii?Q?X+Z64VfgJckVIadHprkfeQWouwRvOBqSSp/GB0bM/pdi8GBVobOcn9k/qwv9?=
 =?us-ascii?Q?TNk8l/zwoEPPZxerwXAPVxLpmzeQYBo/zq1xg2D0wkXOUXYb5fB56BJoiIZF?=
 =?us-ascii?Q?0piUVcOgivFHqkCvDM9MXx2VIVDZz7/c3X529wrWvnipUWPwzLhmoXpADysM?=
 =?us-ascii?Q?QBISkCBVkJeXaf1DHumDur6qGLN4KXeo3GgJl7zMvmtQOHSb4oR/VQautt4Q?=
 =?us-ascii?Q?mrezLS+1bWJGmnc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09/jIY9w5kJ5wiYWDiR8U2znjMjdYwtF2XR9/xhZMJLycndaTdtyncygQLNI?=
 =?us-ascii?Q?yEdauckwPYLwBC6kcu111xQMcgHE/etSQ1s/7oZRmlWf3amvipla6DwkhDkQ?=
 =?us-ascii?Q?LKPilaW+MR9D8iRjDKYBp/GT0b/ocgEQ9SfsF2iG9H+PWogurKg9xk8Zwzn0?=
 =?us-ascii?Q?fwfXFeaqUggrv+AAVswwMoWAAvGtTtTEFlKSuZFwqVsWZEnx952tISzpxWoO?=
 =?us-ascii?Q?fwXrz5Ec5kxGOYkzEbumUt+x5puSQGjn3WA0jXyN9VElndL9NApWLIeyLvL2?=
 =?us-ascii?Q?l6mqyu+kOzwEgBqL+qqIpM4ysk95zpKU5DGwizwVdU+6gZLhy4NmFT9V6lYt?=
 =?us-ascii?Q?aZBmVNbsi3GfWfHqiLGthI2YREA3yw59ZeXxHi2E+ZwGAMyUVYy17vYw6Iap?=
 =?us-ascii?Q?H0WUwPH1g2ymbkOf/DywsZs5eCVFXKJ58IVGhkU5tHdCwoBFv0w1N96LmI7I?=
 =?us-ascii?Q?Ez6MMqOEJalHOauIyVMUpvF1QeoVA+DFbDbM5iMSb5yBqI2B4aUeI0nb/OkY?=
 =?us-ascii?Q?2ic25ert+f1hnvj0VK0uj9fbHdjQvKtMDFPeCBXTvoKoa+tQmF9ZbXTG2F6b?=
 =?us-ascii?Q?BZoV7hilD7dS0kVLwOCpkVp9N/EL/fIXIq47nkSFzdiL81olEL4j39pRNMBI?=
 =?us-ascii?Q?uhcXIqlQ3l0pVSYVpT3kh3FB//GgfAurc1QQjsJFpR7Tq5PWIXBn3dodoOxG?=
 =?us-ascii?Q?dVZnHnEhzjkaVQLZ/YUNDfldQq29NCSd8w84bNpEvqdCQhkR8h/iWrBhv8f5?=
 =?us-ascii?Q?MqhYXLARdY5tZ/RWrisdU3eWMwSZnE1mt1EONCoaXmwVeTZ74zMQEBTOlqQA?=
 =?us-ascii?Q?9Y0c3o7piBZW5FyNG/sJxrVcG+TaozjgoghUUbT37kOb/aMC8f4cPLHCByca?=
 =?us-ascii?Q?66tP4KbY3pJD1DBCPbmLMOAJBMnfBezoOjqwQgJOsnNH6pL1wXOPf8YxA/G6?=
 =?us-ascii?Q?E21KdV5yrVI7NR6Mv9OT6iF8Q8dtWn7ccFdqC/sdSy+9/d6Gp7p+2OzIBTSf?=
 =?us-ascii?Q?Tpi7Crls/IuiawB8sC5rOYNq5GLx7z9kXnc4dJOAr6cCTkd7FzIjW/qt621n?=
 =?us-ascii?Q?xwSCvaoIKhP7yyEgBRmWHHIBEQDMrDZA+vJguVrg1piXrOsdtJnKNqQ5TLL4?=
 =?us-ascii?Q?vSRO/JN963tM8KnsWV7jl9GTedmmcakmmUjaDUSC3DpWjNHD4BPDVKE2kZ7d?=
 =?us-ascii?Q?DcWtR0tINkiH2/8e9b2b+gEdizpvNf542hr6qqA8aPlDkvmRVrt9nOl3d6kW?=
 =?us-ascii?Q?D5gnpi+Ii6lbAKx4c8E7ml4kS57vR7V9xujO83leQs2aP8ZFB1YB8xfcWWUX?=
 =?us-ascii?Q?c2+XFeoV/A9FDMNY4WSpy/9Wo7v73hEaolPmOOGrICOGkMLkhUeE18vepu05?=
 =?us-ascii?Q?N2U7Eb+7iTabrYI/poC0qnEvnZ6W58wiCT/iSKUMoTbrsqGKCXCsrfmBkjRV?=
 =?us-ascii?Q?N2JwZw6VrmWUldji7EHgUNGt+J481FWJQjIRPT22/OMD1cXLr6nXTlQ2jiXR?=
 =?us-ascii?Q?hHfjdVQwvARfTmLGW+5YdzV8g3iMJWxDfxPDoQTOkChQKlYUkIzpT/YbUFYx?=
 =?us-ascii?Q?OXJq0s9wuLho+Y0xFWU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB537241EBAABDC627CCE09592F48AACH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634d103e-b2d7-4c44-bf7a-08dd8f104b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 15:43:50.2966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZllSYci9vBZ9Os8GThOtfxzmcmjxfZOCTmd0db0Q3uyovLzFMkYiOYHcjgTKumVxeH+M6uZLGIMrxDBEaq+bNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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

--_000_CH0PR12MB537241EBAABDC627CCE09592F48AACH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

In theory , I don't see the problem to use kiq to reset the schq.  But I th=
ink it's more stable to let driver do the reset for both kiq and schq since=
 these two queues are the basic part for others parts to run  normally .

Regards
Shaoyun.liu

From: Chen, Michael <Michael.Chen@amd.com>
Sent: Thursday, May 8, 2025 2:32 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy que=
ues


[Public]



________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Thursday, May 8, 2025 1:24 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Michael <Michael.Chen@amd.com<mailto:Michael.Chen@amd.com>=
>; Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu/mes12: rework pipe selection for legacy queues

Only use the KIQ pipe for the scheduler queue.  For legacy
kernel queues, use the scheduler pipe.  This aligns with
mes11.

Cc: Michael Chen <Michael.Chen@amd.com<mailto:Michael.Chen@amd.com>>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 18 +++++++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 2febb63ab2322..f665daf71780d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -299,6 +299,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *a=
dev,
         queue_input.queue_id =3D ring->queue;
         queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
+       /* need to use KIQ pipe to map the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;

         r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
         if (r)
@@ -323,6 +326,10 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device=
 *adev,
         queue_input.trail_fence_addr =3D gpu_addr;
         queue_input.trail_fence_data =3D seq;

+       /* need to use KIQ pipe to unmap the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;
+
         r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input=
);
         if (r)
                 DRM_ERROR("failed to unmap legacy queue\n");
@@ -349,7 +356,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,
         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
         queue_input.vmid =3D vmid;
         queue_input.use_mmio =3D use_mmio;
-       queue_input.is_kq =3D true;
+       /* need to use KIQ pipe to reset the scheduler queue */
+       if (ring =3D=3D &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
+               queue_input.use_kiq =3D true;
         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
                 queue_input.legacy_gfx =3D true;
We are not supposed to reset scheduler queue, so this change is not necessa=
ry.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index a41f65b4f733a..d1836ad93ccfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -242,6 +242,7 @@ struct mes_map_legacy_queue_input {
         uint32_t                           queue_id;
         uint64_t                           mqd_addr;
         uint64_t                           wptr_addr;
+       bool                               use_kiq;
 };

 struct mes_unmap_legacy_queue_input {
@@ -252,6 +253,7 @@ struct mes_unmap_legacy_queue_input {
         uint32_t                           queue_id;
         uint64_t                           trail_fence_addr;
         uint64_t                           trail_fence_data;
+       bool                               use_kiq;
 };

 struct mes_suspend_gang_input {
@@ -277,7 +279,7 @@ struct mes_reset_queue_input {
         uint64_t                           wptr_addr;
         uint32_t                           vmid;
         bool                               legacy_gfx;
-       bool                               is_kq;
+       bool                               use_kiq;
 };

 enum mes_misc_opcode {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index b4f17332d4664..8f2e24ecf747f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -515,7 +515,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes=
 *mes,
                 convert_to_mes_queue_type(input->queue_type);
         mes_add_queue_pkt.map_legacy_kq =3D 1;

-       if (mes->adev->enable_uni_mes)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -554,7 +554,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_m=
es *mes,
                         convert_to_mes_queue_type(input->queue_type);
         }

-       if (mes->adev->enable_uni_mes)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,
                 mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_of=
fset;
         }

-       if (input->is_kq)
+       if (input->use_kiq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
@@ -1339,7 +1339,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)
                 return r;
         }

-       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
+       kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[AMDGPU_MES_SCHED=
_PIPE]);

         r =3D amdgpu_ring_test_ring(kiq_ring);
         if (r) {
@@ -1608,7 +1608,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu=
_device *adev)
         soc21_grbm_select(adev, 0, 0, 0, 0);
         mutex_unlock(&adev->srbm_mutex);

-       adev->mes.ring[0].sched.ready =3D false;
+       adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false;
 }

 static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
@@ -1687,7 +1687,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device=
 *adev)

 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-       if (adev->mes.ring[0].sched.ready) {
+       if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready) {
                 if (adev->enable_uni_mes)
                         amdgpu_mes_unmap_legacy_queue(adev,
                                       &adev->mes.ring[AMDGPU_MES_SCHED_PIP=
E],
@@ -1695,7 +1695,7 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device=
 *adev)
                 else
                         mes_v12_0_kiq_dequeue_sched(adev);

-               adev->mes.ring[0].sched.ready =3D false;
+               adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false=
;
         }

         mes_v12_0_enable(adev, false);
@@ -1708,7 +1708,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)
         int r;
         struct amdgpu_device *adev =3D ip_block->adev;

-       if (adev->mes.ring[0].sched.ready)
+       if (adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready)
                 goto out;

         if (!adev->enable_mes_kiq) {
@@ -1763,7 +1763,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)
          * with MES enabled.
          */
         adev->gfx.kiq[0].ring.sched.ready =3D false;
-       adev->mes.ring[0].sched.ready =3D true;
+       adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D true;

         return 0;

--
2.49.0

--_000_CH0PR12MB537241EBAABDC627CCE09592F48AACH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">In theory , I don&#8217;t see the problem to use kiq =
to reset the schq.&nbsp; But I think it&#8217;s more stable to let driver d=
o the reset for both kiq and schq since these two queues are the
 basic part for others parts to run &nbsp;normally . <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Shaoyun.liu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Chen, Michael &lt;Michael.Chen=
@amd.com&gt;
<br>
<b>Sent:</b> Thursday, May 8, 2025 2:32 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/mes12: rework pipe selection for leg=
acy queues<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;D=
eucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexande=
r.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b>&nbsp;Thursday, May 8, 2025 1:24 PM<br>
<b>To:</b>&nbsp;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@li=
sts.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b>&nbsp;Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@=
amd.com">Alexander.Deucher@amd.com</a>&gt;; Chen, Michael &lt;<a href=3D"ma=
ilto:Michael.Chen@amd.com">Michael.Chen@amd.com</a>&gt;; Liu, Shaoyun &lt;<=
a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu/mes12: rework pipe selection for le=
gacy queues</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Only use the KIQ pipe for the scheduler queue.&nbsp; For legacy=
<br>
kernel queues, use the scheduler pipe.&nbsp; This aligns with<br>
mes11.<br>
<br>
Cc: Michael Chen &lt;<a href=3D"mailto:Michael.Chen@amd.com">Michael.Chen@a=
md.com</a>&gt;<br>
Cc: Shaoyun Liu &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.=
com</a>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp; | 18 +++++++++---------<=
br>
&nbsp;3 files changed, 22 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 2febb63ab2322..f665daf71780d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -299,6 +299,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.queue_id =3D r=
ing-&gt;queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.mqd_addr =3D a=
mdgpu_bo_gpu_offset(ring-&gt;mqd_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
ring-&gt;wptr_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to map the sc=
heduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;map_legacy_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -323,6 +326,10 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.trail_fence_ad=
dr =3D gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.trail_fence_da=
ta =3D seq;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to unmap the =
scheduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;unmap_legacy_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to unmap legacy queue\n&quot;)=
;<br>
@@ -349,7 +356,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
ring-&gt;wptr_gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.vmid =3D vmid;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.use_mmio =3D u=
se_mmio;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.is_kq =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to use KIQ pipe to reset the =
scheduler queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring =3D=3D &amp;adev-&gt;mes.rin=
g[AMDGPU_MES_SCHED_PIPE])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.use_kiq =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;typ=
e =3D=3D AMDGPU_RING_TYPE_GFX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.legacy_gfx =3D true;<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">We are not supposed=
 to reset scheduler queue, so this change is not necessary.&nbsp;<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index a41f65b4f733a..d1836ad93ccfe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -242,6 +242,7 @@ struct mes_map_legacy_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_addr;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct mes_unmap_legacy_queue_input {<br>
@@ -252,6 +253,7 @@ struct mes_unmap_legacy_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trail_fence=
_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trail_fence=
_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct mes_suspend_gang_input {<br>
@@ -277,7 +279,7 @@ struct mes_reset_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; legacy_gfx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is=
_kq;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
e_kiq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum mes_misc_opcode {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index b4f17332d4664..8f2e24ecf747f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -515,7 +515,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; convert_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_add_queue_pkt.map_lega=
cy_kq =3D 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -554,7 +554,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conve=
rt_to_mes_queue_type(input-&gt;queue_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes_reset_queue_pkt.doorbell_offset =3D input-&gt;doo=
rbell_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;is_kq)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;use_kiq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
@@ -1339,7 +1339,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ri=
ng, &amp;adev-&gt;mes.ring[0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ri=
ng, &amp;adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_rin=
g(kiq_ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
@@ -1608,7 +1608,7 @@ static void mes_v12_0_kiq_dequeue_sched(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0,=
 0, 0, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;srbm_mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D =
false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PI=
PE].sched.ready =3D false;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)<br>
@@ -1687,7 +1687,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].sched.ready)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[AMDGPU_MES_SCHE=
D_PIPE].sched.ready) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_mes_unmap_legacy_queue(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE],<br>
@@ -1695,7 +1695,7 @@ static int mes_v12_0_kiq_hw_fini(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v=
12_0_kiq_dequeue_sched(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready =3D false;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v12_0_enable(adev, fal=
se);<br>
@@ -1708,7 +1708,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ip_block-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].sched.ready)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[AMDGPU_MES_SCHE=
D_PIPE].sched.ready)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_mes_k=
iq) {<br>
@@ -1763,7 +1763,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with MES enabled.<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq[0].ring.s=
ched.ready =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[0].sched.ready =3D =
true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PI=
PE].sched.ready =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
--<br>
2.49.0<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB537241EBAABDC627CCE09592F48AACH0PR12MB5372namp_--
