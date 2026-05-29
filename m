Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7DACD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 16:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926471121C6;
	Fri, 29 May 2026 16:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxlO4mer";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AC61121C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 16:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doccQu+aS+YCLvIzDPP7koOHqQB9M2AH0LINWqYwbJrcsy8hKb2CEH8Pn3vAFpWQ3n2Wo32pgH2hgSt18ZT5p6mkvplVwBfz1lSjZZTC7OL0FS/TD87rDZfWesUznhKH+wQgeXWfcL6TRJwaGGC9hebQi4ipyaI3lFl/DMchy+wXcA3ElQbGCsH6Hqmgu1EPSrjMncRr+vFKYY2vd5Z9+GqJIlZPs6m+rBHqR7HksT7gp+eKV//vONokJz29qp/c5BjdFa0wWfIabafaF7dFCis9NTJn67d1ujSdM7jJ+WDUQTbs9lFe86Of53k4Ms56f3PwYBjH9N2+1/Nlov/TvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U6mkAejrvwnSDO3B4uvV1eghtjFxiD1g/4rfPv3sm0=;
 b=gbsiei0ScUotXcKCPsC8/jmDldy53fvJdBrOaXZytGymjeliuJQJwkf36qsReMvyxnUDWbaam5k9C43aKq5DAVAQYvU9HPohAdCBTXos08asr+nNOMKX1FJ59amK9KFuM33Q+q/oiFLd6B/RVqbelSp4BrzzEUHYWjfDiiq+TmRrY94YoER9Lx9yu3fV9pbHxOcMYG9tbo4KHphC4UQtVAWIhqWCnlRv2PI7am33btfbOaZq4+qkFPJxV7FTzZCgbN2Nymi6DzvCcIOOLI7xW4fdUZPKxLmT8tSn/REOPrOGUVd7cou57NGBLmo2BWQQUVQPz/N3qEbF/H8SxuK7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U6mkAejrvwnSDO3B4uvV1eghtjFxiD1g/4rfPv3sm0=;
 b=HxlO4merAwU6etTZ4VfxY/KeLR6Rkd3zUOcQ5u0YRY0OHm+WTbUcWX5ExBEY/4PCGSUSo+c3pPoyivaawpk93s+I8wfWTMWwoJhfyZKE9scwSKxBOOlBt3wkaGadA7sktp15Br0WjQTUqsjxxkJKfVwqJvmb7cRfAc3UVMAWA/k=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 16:05:19 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 16:05:18 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and
 add HQD cleanup
Thread-Topic: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and
 add HQD cleanup
Thread-Index: AQHc6YEACKKHLDBBtEmW6N9OO+yrSLYlNt6A
Date: Fri, 29 May 2026 16:05:18 +0000
Message-ID: <CH0PR12MB53728609509717B364E84FFFF4162@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-14-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-14-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T15:38:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|LV8PR12MB9713:EE_
x-ms-office365-filtering-correlation-id: c1807b48-cd1f-4609-e048-08debd9c1476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|38070700021|921020|3023799007|4143699003|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: F9BkIQzxoABVKqDdZiVluud7kFsvV1ZLPmHfWFRlNhFv4ODHfuU8luksGC3igGXYsd1arCGMJje07X+hVXCdCfGDh16Vm2mZOGpYuE6FJdvXLCUPJCk7Og0OM05UD6aB6hKJ80dEr2m9fPbLlRYcEzpNCIFbz0XctVJPyrODpQMlnLUDOWfKHXHxj5P1TpAliFO9V6yqrz0LLEpspLXz2Nk+GszLRLDt6PJlJdhBVebsrXLStSIk6hpFEKrZCbNQFLYSVvOdXdIQpE25BRAGo1qJ+c5LBskijUaKp9LOFoBPRHbQXr6K8550ymGRG7AC38RjQl8iwkTe8G4amW60a8posVSv6uxKmK+kd8oCZGNj8wsuhS/KrxwMjw7QQl3E9MH0IKg04uDvfbeld7fWNKtG5xbhT5UqtDBPKxm/wB3PX9GblMXRgPkDLuWXZVVX256dxvmQoGEIhTjQ7G5kym0VN3EzXkKIpPqBWr6tDgue6tJ9D2vJzIp2CR8OCc1ZtIemLJ6Mf7I4GwY/z0zJvJVgi7XNnIB9L9M02ZkjIPilymB2ZFqsM2DVgGc0mnPeL0XIrcSdLibbe0bZLfjjF9Z8kc3gc4J8/O3eY/NaNuxGhx2dwgg3X9B4QdDmoikxM3AwFk6JihFyGlPV48frdZFSCHcK2HFwBUrnQKEwke7ySMG1KsoFUVYtO37SfA23fUNHY0tnvY9pIjQEGCe6kodbhNf5mpjBdCx2FFvPNuEVArVgWQRD2++z0Uk+koQAigIbg5fgNg3btSVvd1Mfww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(921020)(3023799007)(4143699003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qp9xmkFuwTcoYQfnKo6jRiwn/h+QLvBmlJRw5m51hFmKrh2V9Kr34fJD4rbt?=
 =?us-ascii?Q?mSu8CGzimQNT13eLyC5P5CZ0YyzwCbYWG3RLdFIPwaoJ9d2CmGy4kO/+l9/U?=
 =?us-ascii?Q?W1T9ffgLH7YqEi2NfTR/cAhtWyf8+SVKavKcy7ZuJ16h1F+qYi0pGraaNf+e?=
 =?us-ascii?Q?kn+vo9Ydtn0x4HhjAxzoh+9EksBzfbO3OP3vzV7GQ/xo9KlJPD577KJ0riY1?=
 =?us-ascii?Q?XIWow15lXOUceb1dJzl2GLdIWBSfBcZjhDlGaIq/7QiDPvA46FM5V8UVBDwy?=
 =?us-ascii?Q?fctQ+j9j6zhFcvMWqGYrMcZLkJLm8ydHwA/2iboP3pFykIR6rPnXurXdGoSm?=
 =?us-ascii?Q?ZJuqScy7qx6I9suTRKlZBScrcH4ncvVpHCtM8+k4PsEi16n7RRaVBDz3dPQm?=
 =?us-ascii?Q?2MUkCQw4VjigT6j5+iXjgXb9IDZwiyIuwSD6wol3Egw5gDP5/mkOR0TL5B1v?=
 =?us-ascii?Q?GW3l2CeBIWG+JMydXvDHT/I14l9EU1P9aWpcyd2/GzZXjhA2DbimY94WzY/p?=
 =?us-ascii?Q?gBgGBfIOB6cTx9lEL2NaweKeH8GE0UYN8roJJalV0SQht+XEn+r2oNzXiWT7?=
 =?us-ascii?Q?/39AxUrDxV2ryv3JDjSuwjU95dt4alANMba3umQC8P6Jij8UsstGSusldP5R?=
 =?us-ascii?Q?PZefwafgnwNRqNxx0Ppe7Yaj73/XWBPBkKP6o0juQCsY509m6Y+y0AtzSsEL?=
 =?us-ascii?Q?kX3VKdgtRBN7pUTNn+o7i5ThJCtQOEBRqi8OJvRyeda2MSNVJr9sdFGj1Gmo?=
 =?us-ascii?Q?U9yoeYW3V1+y/aQMMutn3/vs2YtRClDjx6Euprih50nYhqA9fqZhFQCAMjBP?=
 =?us-ascii?Q?+TLBtUTr5SAoZ34Kqri7VBh/oOxSCnhY4PhfroxxpOOBDoOs29VM5pc+VDZ/?=
 =?us-ascii?Q?Q+A/A//af3sShdXN28Hc178fQyJd9R6NNFag+lSDIp1BOdgq7Tk/R9lKv41p?=
 =?us-ascii?Q?vpV9RfQtG+AxETupyZ3pK79G8KbFWAGDnH2oUO8AlR61v6Fk3BwzNpWKHTmR?=
 =?us-ascii?Q?DpKfq/AvqUgu/kp7AibWt85Wxk+9jI23HkIzM2HAWqAOwdHRb8vWqdbAl3Ie?=
 =?us-ascii?Q?7XD/mojrH+5U19fQIEP/9VsyOb537gkHuRTyxbolHMfnlke94wyFkrx8MHnW?=
 =?us-ascii?Q?2mbUzBNeYwE4JskBMChwpfNqVWXP3v6ahnjvoq7orkkQtkUQakQyasB3Q40h?=
 =?us-ascii?Q?ic+BsN0pXgK4mmTV1NlVCJl01s6JkwFSdOrTWRDjlDrfXkKqz+W8+5sQIJpN?=
 =?us-ascii?Q?i/KbiClSK9L5uhfdOONccLr0D5vaf93su39XCxD2Kf50l0HcVcPyaG3dREBs?=
 =?us-ascii?Q?hgCq8MOXOt65BflTs0bYxZVuSDpYP1tefF5AHcCgKjw+GPd4vOwn99dnIb1W?=
 =?us-ascii?Q?8mtSl83S8YDQRzrubzoY47+b9MKtMhHWf8E5EYHj8eOGbKVeIO5ObG8Wy4O2?=
 =?us-ascii?Q?lkovIi+oe+Ir6KicE1EfsPKhp3KIP2E0vi93vSSLBce0I69NLYvRPteKAZ9d?=
 =?us-ascii?Q?YFfOLWZoTTWTug5chfmRwZeSL2N58H2V56yVtOnOreXVdyXzueCZUejdachK?=
 =?us-ascii?Q?67vSro5IYfEaP5l/rIGM7/gJe2/H2MmgbrpWpkuNlGiLfT5dAJdXJRJmsSGq?=
 =?us-ascii?Q?Gq+L2OiV7MOREuUj1OD/Cc6DVXpuvCoPtbJGrXci704Y1DLo4hSAuj5PNdfT?=
 =?us-ascii?Q?ezu5SDrIE9GlL8GA+RTPO6COo9nANMNw0wg0r6/pcI8oIf8K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1807b48-cd1f-4609-e048-08debd9c1476
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 16:05:18.8715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KiV3+hJTvb/ZgX98A759Sv+hxSssIUz3ZBXamxKdqFt18y9ph/UQ5X9DufI44bs4s5Y0mjHOSHNK9tREVbZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
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

AMD General

Comments inline .

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Thursday, May 21, 2026 8:20 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Amber <Amber.Lin@amd.com>;=
 Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com=
>
Cc: Rastogi, Manu <Manu.Rastogi@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and ad=
d HQD cleanup

From: Jesse Zhang <Jesse.Zhang@amd.com>

Refactor gfx_v11_0_reset_compute_pipe() to accept explicit me, pipe, and qu=
eue parameters instead of deriving them from the ring structure. This enabl=
es the function to be used in generic pipe reset flows.

Introduce gfx_v11_0_clear_hqds_on_mec_pipe() to properly clear CP_HQD_ACTIV=
E and CP_HQD_DEQUEUE_REQUEST for all queues on a given MEC pipe while the p=
ipe reset is asserted, ensuring the HQDs are torn down correctly before dea=
sserting reset.

Switch the KCQ reset path to use the common MEC pipe reset helper amdgpu_gf=
x_mec_pipe_reset_run(), which coordinates the reset sequence including KFD =
suspend/resume to avoid conflicts with user mode queues.

v2: just update the sequence (Alex)

Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 166 +++++++++++++++----------
 1 file changed, 100 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index dd4f33d2ce45f..1995de5e69991 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6874,11 +6874,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *=
ring,
        return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }

-static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
+CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset
+stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u=
32 me,
+                                            u32 pipe)
 {
+       unsigned int q;
+       int j;

-       struct amdgpu_device *adev =3D ring->adev;
-       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
+       for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+               soc21_grbm_select(adev, me, pipe, q, 0);
+               /* Start from a clean HQD dequeue state before forcing HQD =
inactive. */
+               WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
[shaoyunl] When  we are here , you should already execute the pipe reset su=
ccessfully , now just need to clear the ACTIVE and  DEQUEST_RESET directly =
. Don't need to check it again .

+               if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+                       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+                       for (j =3D 0; j < adev->usec_timeout; j++) {
+                               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE)=
 & 1))
+                                       break;
+                               udelay(1);
+                       }
+               }
+
+               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+       }
+}
+
+static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
+                                          u32 me, u32 pipe, u32 queue)
+{
+       uint32_t reset_val, clean_val;
        int r;

        if (!gfx_v11_pipe_reset_support(adev))
@@ -6886,109 +6914,115 @@ static int gfx_v11_0_reset_compute_pipe(struct am=
dgpu_ring *ring)

        gfx_v11_0_set_safe_mode(adev, 0);
        mutex_lock(&adev->srbm_mutex);
-       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-       clean_pipe =3D reset_pipe;
+       soc21_grbm_select(adev, me, pipe, queue, 0);

        if (adev->gfx.rs64_enable) {
+               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+               clean_val =3D reset_val;

-               switch (ring->pipe) {
+               switch (pipe) {
                case 0:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE0_RESET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE0_RESET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE0_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE0_RESET, 0);
                        break;
                case 1:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE1_RESET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE1_RESET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE1_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE1_RESET, 0);
                        break;
                case 2:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE2_RESET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE2_RESET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE2_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE2_RESET, 0);
                        break;
                case 3:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE3_RESET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_RS6=
4_CNTL,
-                                                  MEC_PIPE3_RESET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE3_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS64_=
CNTL,
+                                                 MEC_PIPE3_RESET, 0);
                        break;
                default:
                        break;
                }
-               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
-               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
+               gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+               soc21_grbm_select(adev, me, pipe, queue, 0);
+               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
                r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2)=
 -
                                        RS64_FW_UC_START_ADDR_LO;
        } else {
-               if (ring->me =3D=3D 1) {
-                       switch (ring->pipe) {
+               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+               clean_val =3D reset_val;
+
+               if (me =3D=3D 1) {
+                       switch (pipe) {
                        case 0:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE0_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE0_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE0_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE0_RES=
ET, 0);
                                break;
                        case 1:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE1_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE1_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE1_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE1_RES=
ET, 0);
                                break;
                        case 2:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE2_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE2_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE2_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE2_RES=
ET, 0);
                                break;
                        case 3:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE3_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME1_PIPE3_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE3_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME1_PIPE3_RES=
ET, 0);
                                break;
                        default:
                                break;
                        }
                        /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
                } else {
-                       switch (ring->pipe) {
+                       switch (pipe) {
                        case 0:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE0_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE0_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE0_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE0_RES=
ET, 0);
                                break;
                        case 1:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE1_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE1_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE1_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE1_RES=
ET, 0);
                                break;
                        case 2:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE2_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE2_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE2_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE2_RES=
ET, 0);
                                break;
                        case 3:
-                               reset_pipe =3D REG_SET_FIELD(reset_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE3_RE=
SET, 1);
-                               clean_pipe =3D REG_SET_FIELD(clean_pipe, CP=
_MEC_CNTL,
-                                                          MEC_ME2_PIPE3_RE=
SET, 0);
+                               reset_val =3D REG_SET_FIELD(reset_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE3_RES=
ET, 1);
+                               clean_val =3D REG_SET_FIELD(clean_val, CP_M=
EC_CNTL,
+                                                         MEC_ME2_PIPE3_RES=
ET, 0);
                                break;
                        default:
                                break;
                        }
                        /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
                }
-               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
-               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+               gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+               soc21_grbm_select(adev, me, pipe, queue, 0);
+               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
                r =3D RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR)=
);
        }

@@ -6996,8 +7030,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu=
_ring *ring)
        mutex_unlock(&adev->srbm_mutex);
        gfx_v11_0_unset_safe_mode(adev, 0);

-       dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: %s=
\n", ring->name,
-                       r =3D=3D 0 ? "successfully" : "failed");
+       dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW s=
tart PC: %s\n",
+               me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
        /*FIXME:Sometimes driver can't cache the MEC firmware start PC corr=
ectly, so the pipe
         * reset status relies on the compute ring test result.
         */
@@ -7017,7 +7051,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ri=
ng,
        r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
        if (r) {
                dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe res=
et\n", r);
-               r =3D gfx_v11_0_reset_compute_pipe(ring);
+               r =3D gfx_v11_0_reset_compute_pipe(adev, ring->me, ring->pi=
pe,
+ring->queue);
                if (r)
                        return r;
        }
--
2.54.0

