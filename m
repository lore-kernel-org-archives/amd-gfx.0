Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8381CCD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 16:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E2E1121E1;
	Fri, 29 May 2026 16:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vufJsMsS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB1F1121E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 16:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuxtSOtOBuVIUjrvsTq5MyASukmJpd6yl36Jx5qqmpnbgMZLZ/eKSyQmsyRHAaIRv+UZA/e/dHp1PjSiKvpUhQeZ07HAkgnwM0HPr40HbrPz5+z4+Xs3uMc7I4y/Yt5WwF9Qbi9nvk5wsOzYyVZ/46SkAh1R/y0V7Dy3lgIbgt2gpG+1+UiZACl/Vsgo9zB/oZ8foKFF3yjZ5rW+N1h3/teViq9Qn9/KLyVEIQ9N34u6B1LdAM+DRwDKuA27QY9QML0c1QWnxB3FRUV9d7ywqK07MyccOR3rmEUkgjf/KxSPpxyyKHiEvWYgxDuqxeTIkWMCO0A0PHVrsEXccFGUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPH2wqMD+Gmp6IiWdPPif28dzNnSoC0osSzaeI/Hrmk=;
 b=WSwzBChnP8BPuQ6ZOb7O3c7fcXLexoR7PWwvXnT7hW1uHXF4KnaYTNFfkn5a+utsWoofPlYI+eJxK92PJ+VV6KLiUwdNCk0FbpyM+gKk+ywE1ZAIwRbOp1nncFEA7wGqmrVJABt6D44CAqvldtRz7RWx7ean/jXaw0Y6r2XILLTiLyORGCZ8FPkKPKjaCBtoNJHSfRocg5kPWtqd6eRPK7n2qgo5RTy3gngtFSQ/zNLOWr2sJ3/9rILr7jodb9moIng03Mv5GaTKV/yfjVnPQOVl/trXhURmpJOjZPhWcbqUSaIrOOHbNivMONZFmU5nFpgcdOh9ZonVXlzyEoz19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPH2wqMD+Gmp6IiWdPPif28dzNnSoC0osSzaeI/Hrmk=;
 b=vufJsMsSn/Oz3i5TrIFzOvwT8W/0HqL/WP8qT7GEUtxNmHz/raOo3UtuXf+EBQ+qs6pJfNNxcuIIIQnQrT5gkSOUO0I9auD/gUs1agxsHKLtTGvN94voQeC8c/3COjwMDeJC8lnCyhwYaMLbY8GG7Lud0MoKInvEJbPvGrkyt/8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 16:10:55 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 16:10:55 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and
 add HQD cleanup
Thread-Topic: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and
 add HQD cleanup
Thread-Index: AQHc6YEFumJDZVFTF0mRQd4iEORTuLYlOHBA
Date: Fri, 29 May 2026 16:10:54 +0000
Message-ID: <CH0PR12MB5372CB6EE646106B41E1B214F4162@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-15-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-15-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T16:05:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB9152:EE_
x-ms-office365-filtering-correlation-id: 20579f04-8c6d-4c9b-a6de-08debd9cdcc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|921020|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: 9mPc2uq/slRt/d5ufguYrk+FxpihCjCc33UeIK+71YQ2WfbsXY8TSxzBFuGLvWuXi6GzIg382IcMJ4YR/iQeu62Sy0XQSvbFurWSR5Cp6xuCtenXrL1FcEROhNdbrqqbVvvqroAK6TIM9B4dFmlvcA/5ItgZnvm5FrAgIPj7W6sbXEsEcG0T5a1dqS7w93KvcyxhyKwD0CgzLk20H7Dl7UBy0rlTHdvlA4uKNg7/V+vIeSAAVbpQbnlLIuJ0j3JytB/FoCcwCXyb2uXMOL0VdquhtEqCGVyta/7IcAtG50szV2z2Zu3/x8vD4lst0YxXqa3hFSiMi8pm2RX760Ek2sQEA24YC7EL0EmucLsdJt1G8LzWupsRQ2pXu2/OVCoeDz++IscdruoyrkQHEkuJnPmIIz9cIxsMyDEaC7Hh5+vUoMV3AEgcFsmC4V8zotB4/9etHBoq/05DNtsDU8A20ms7bu8MR+TurhOuB092E9QWbsh9PSChjekeul0v/mBW4G090EBeSXjH2kC9pW2w2m9QPLt6LudiDAU6QO3mWoQ0672P6LKQdrCl0GbXYkHlf7AMcg07zUSK7SbeRgaK2z+wDhwqaNo/cUrNSFHFmnSENeMehFXV8Ezfv2mTE6dzmyuvPNBiByomqtYZkdjs5YtO8bUKJc7TJopfmc8nHWwMPSkFEjUjA2D58Ie4R/U9v2g8cZpkXDUISyICyfG7zuQ7oEBfwL7Q2L0ZhiWzhCHtmaFxaTfgcfVodMZ4FtjaxQWVGts59tdELGMOlr1mOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i/Sz7EUq8gZ9HBLPtFdAWx3rN9iaQ/FzHi/FzfR4W7fnth1DZkOCZQwmnHCb?=
 =?us-ascii?Q?AfHLKgL1utn0bj3M4H4OX1UFlC8tL9mbS+AQPvPKhKvJCYZoNiOS+uX03YLh?=
 =?us-ascii?Q?QaGMaNlOJ3hG73MQz/3MBfhSmrvKU7WP+CfluSl7DJpjtIA4CbKtX184iY4u?=
 =?us-ascii?Q?Nf3sDFvOu5Yo3UkSQVZCkgf51Mzv+S+UOU2S6pAIjeJCE0LO85f+GJk8RYQZ?=
 =?us-ascii?Q?5S1fkdv15rDROqnRgpdj9BH65oTCfqLsnRJpNmES9bvPXKOVY1bplt9g5LuR?=
 =?us-ascii?Q?+T+tKyFA/GtCiJvdvV1f6iRwimk6gy9Q8rL8AHk56/dfsZWfm2199Us8IouR?=
 =?us-ascii?Q?/Z6VtrKEHSXL8nbBEaxCDbq99wLz+Nc1/tdqjPNtCzN9nykp1oI2mTuuocOq?=
 =?us-ascii?Q?qnBGhYtMJnySuB+fZ5Qg9yfXdpq3A1tNWJ7dD1bw1yzTIW/5WmQEfFoMpf/2?=
 =?us-ascii?Q?h2pKdRZEtGNLZaRFsMrg6dY2jdGoOJmnGylmyhuRBh+xerwshnlmvy5ui/Ib?=
 =?us-ascii?Q?T9S0A7GnF5y2l4eqDcqQcVp/o3kME9HbrqX8yaMgue8ePC0iJdDO0SmU+Hzz?=
 =?us-ascii?Q?bVdMqGAeWZqjeO/JbrH3hDplnKF8jsgpVlrIXIiz6NLelQWG/k1b9NfYB7np?=
 =?us-ascii?Q?9ovafYmkBSJNFV7RhkTEIo29DrD8Rj2IboQ+zjBG4Uic5mxr2zZSJeG/mfx0?=
 =?us-ascii?Q?IuLfn7+ZDjNRMCmOUSbxFMHqo2L9Xt1xM304/2qM1yxzQGj1uKyqdNddwm3s?=
 =?us-ascii?Q?8ca7O89ER/dpclNsmx21l10KxGIvPPVsO19XduSvFwZYbFMqdWsz+IhGTJFd?=
 =?us-ascii?Q?Tppq1GsG8ef4bPkSNFbz/pqFaysi/yVjYn7lvgSsQ9VgWyyxUYGUCGjM1Yub?=
 =?us-ascii?Q?GKnew8ZkEkwEKAzCX5Hi7qkom8fjRweF6Z7QLGMVvOCwd6BdqoKpDLEu3/iH?=
 =?us-ascii?Q?tVhfdlt5aAO/5ZT5flPml2ncUdVS8TgutB5K0lO1leiMp+kLTE3ErOX+Q70r?=
 =?us-ascii?Q?BkWhDA6aDvBZBL/RmwbcQ4e5/fusO1XvDpwj3qzDNqwAF+4Mf5j64raCEoJj?=
 =?us-ascii?Q?7btHI2/t4PnS2/9Kc1aKUHrZ0++ILW2VvI4g/DNzK4DTWoq1SO/aEDiqIOZF?=
 =?us-ascii?Q?YCzZc2R3/T/eHX5D4dq+ISQelp+rNEKCCcyU1CmYRC/SjRu6wpp/T67ELfBY?=
 =?us-ascii?Q?ZnFYE1u0fQOT3UHNMso2VzoNd1kiAGzv5bnsKWOsdfVOBO7iyqQ8wyIDlR9B?=
 =?us-ascii?Q?j2MCH/y70hyGdXbGnWsn7m+xR0FR/FzqrxlBN9QXeCjEPTxnbNBPhTZUuHHP?=
 =?us-ascii?Q?7dnZdoSmJjuOc803dXhFZ2rpb4d+E4bSLDVdlTxpIMvX6no1LgGB38Pney+v?=
 =?us-ascii?Q?WcBkqY4IDr1cBxzrMepaTr0ddqhhbvRxiJ5cKLt20QL4pp+EWuVAjhyxNWjC?=
 =?us-ascii?Q?yNevEjJQ0Dwr4btd9mXkaMfTRNnE7abUTvDH8dktzVLNR4JA5co1lrOKolQ3?=
 =?us-ascii?Q?EHfylRWNqLqIg8a36h6qEAdrXhxEb14qaRTjQ7uMhdTMl/cCoerelHVuoOVj?=
 =?us-ascii?Q?a0Yk6xS6FjAob3ytHW4no2Rf4pROZ5fVWiGvcYdnlfmVvmPtMlTRMljW2jQh?=
 =?us-ascii?Q?hX4sAnqhNJXlqBtUcEfnMWA0TbekuFn/eDRcqSWRZlVWA91QfJhk1zbOO/FL?=
 =?us-ascii?Q?tu1uY6Rb2PTBzKXT3O3MX4sS/warZ1NXaIfiPL0RvtR5IeVD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20579f04-8c6d-4c9b-a6de-08debd9cdcc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 16:10:54.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLAuL/VRyz77Np/0L1yw4RFGWJ7nEKZgzh0L6iwS+Yw5x8l5KWBdqAkjXqQa0tFTCEMaqxp3j4G0F0id/5WYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
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

Comments in line.

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
Subject: [PATCH 14/42] drm/amdgpu/gfx12: Refactor compute pipe reset and ad=
d HQD cleanup

From: Jesse Zhang <Jesse.Zhang@amd.com>

Refactor gfx_v12_0_reset_compute_pipe() to accept explicit me, pipe, and qu=
eue parameters instead of deriving them from the ring structure. This enabl=
es the function to be used in generic pipe reset flows.

Introduce gfx_v12_0_clear_hqds_on_mec_pipe() to properly clear CP_HQD_ACTIV=
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 123 ++++++++++++++++---------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 4be650ce1fba7..d235e904b806b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5309,10 +5309,38 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *=
ring,
        return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }

-static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
+/*
+ * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
+CP_HQD_DEQUEUE_REQUEST for
+ * every queue on (me, pipe). HQDs must be torn down while pipe reset
+stays
+ * asserted; only then clear the pipe reset bit.
+ * Caller must hold adev->srbm_mutex.
+ */
+static void gfx_v12_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev, u=
32 me,
+                                            u32 pipe)
 {
-       struct amdgpu_device *adev =3D ring->adev;
-       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
+       unsigned int q;
+       int j;
+
+       for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
+               soc24_grbm_select(adev, me, pipe, q, 0);
+               /* Start from a clean HQD dequeue state before forcing HQD =
inactive. */
+               WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
{shaoyunl] : After pipe reset successfully , you should be able to directly=
 clear ACTIVE and DEQUEUE_REQUEST .  One more thing  you need to set  regSP=
I_COMPUTE_QUEUE_RESET) to 1 to reset SPI after per queue reset through  MMI=
O .

+               if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+                       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+                       for (j =3D 0; j < adev->usec_timeout; j++) {
+                               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE)=
 & 1))
+                                       break;
+                               udelay(1);
+                       }
+               }
+               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
+       }
+}
+
+static int gfx_v12_0_reset_compute_pipe(struct amdgpu_device *adev,
+                                          u32 me, u32 pipe, u32 queue)
+{
+       uint32_t reset_val, clean_val;
        int r =3D 0;

        if (!gfx_v12_pipe_reset_support(adev))
@@ -5320,75 +5348,78 @@ static int gfx_v12_0_reset_compute_pipe(struct amdg=
pu_ring *ring)

        gfx_v12_0_set_safe_mode(adev, 0);
        mutex_lock(&adev->srbm_mutex);
-       soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
-       clean_pipe =3D reset_pipe;
-
+       soc24_grbm_select(adev, me, pipe, queue, 0);
        if (adev->gfx.rs64_enable) {
-               switch (ring->pipe) {
+               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+               clean_val =3D reset_val;
+
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
+               gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+               soc24_grbm_select(adev, me, pipe, queue, 0);
+               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
                r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2)=
 -
                                RS64_FW_UC_START_ADDR_LO;
        } else {
-               switch (ring->pipe) {
+               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
+               clean_val =3D reset_val;
+
+               switch (pipe) {
                case 0:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
-                                                          MEC_ME1_PIPE0_RE=
SET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_CNT=
L,
-                                                          MEC_ME1_PIPE0_RE=
SET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+                                                 MEC_ME1_PIPE0_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+                                                 MEC_ME1_PIPE0_RESET, 0);
                        break;
                case 1:
-                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_CNT=
L,
-                                                          MEC_ME1_PIPE1_RE=
SET, 1);
-                       clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_CNT=
L,
-                                                          MEC_ME1_PIPE1_RE=
SET, 0);
+                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_CNTL,
+                                                 MEC_ME1_PIPE1_RESET, 1);
+                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_CNTL,
+                                                 MEC_ME1_PIPE1_RESET, 0);
                        break;
                default:
-               break;
+                       break;
                }
-               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
-               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
-               /* Doesn't find the F32 MEC instruction pointer register, a=
nd suppose
-                * the driver won't run into the F32 mode.
-                */
+
+               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
+               gfx_v12_0_clear_hqds_on_mec_pipe(adev, me, pipe);
+               soc24_grbm_select(adev, me, pipe, queue, 0);
+               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
        }

        soc24_grbm_select(adev, 0, 0, 0, 0);
        mutex_unlock(&adev->srbm_mutex);
        gfx_v12_0_unset_safe_mode(adev, 0);

-       dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
-                       r =3D=3D 0 ? "successfully" : "failed");
-       /* Need the ring test to verify the pipe reset result.*/
+       dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW s=
tart PC: %s\n",
+               me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
        return 0;
 }

@@ -5405,7 +5436,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ri=
ng,
        r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
        if (r) {
                dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe re=
set\n", r);
-               r =3D gfx_v12_0_reset_compute_pipe(ring);
+               r =3D gfx_v12_0_reset_compute_pipe(adev, ring->me, ring->pi=
pe,
+ring->queue);
                if (r)
                        return r;
        }
--
2.54.0

