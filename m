Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E127FC369A8
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 00:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E30F10EA8D;
	Fri, 11 Apr 2025 00:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aokKBQJt";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798F810EA8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 00:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWZCZq1WmaPMcgpdMaSlaeGiBlfuFdKTXphlWhZkI3+Rc4YcZW1EOb3fJMK8ZTpMqt+ADBmI6xmjXEBChL5CgRbPVxwai32q5KEoxJndwD8JEo8aa4g/FwmDqYZzJnoRy2upJJUk2KrW/stE29to8JpvO19j3x3DOoliQ4/q5ZdeHMBIVKofLlPPhwO1SShOxsh1thhtxfqugFGSGYLh0IleaVjCarnUMA/9Cye4boe9bT6Ra2EGY5nBzqtt1tYBiLyVa2YgZl1bNrO8f9t2eIGiUNqRmzI1AV3VXeXYDW4v0OwegrWiwRx5vlF72q+K9u3OqP5tVtNdgklApmm9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUcrrzzYQp8qjmEKdyIcttCHmh0Uz60OewP+Q3Q/Qss=;
 b=fJjSvk5gJWCHjVFHJccdUJ1IPhaemQDRP7majodOeHrLWdUC07vLBQNJMEb8IYJM/xtUfu//h1UVs3K4r+D3H45jVTY8Kdwj01GjwQpyYc2c4G1OOE6ZQXt0ICLSSLikTIGG2QFDO8hmJDxku3lHC98WMVs2GYMxCUsWeY8wKFcwco6WtW+S51fidbwHZH80FYEm+E7d7moi+re9da9qzWHJwuTfL+s/mc2ZM/IgAIkFfX9Te0AeUx96Q4tgk244HBJ9tyj9Ldz9npzMfyaka1dnAIOpXW4VRZ2Z1Uv4jcIDgKqDnN251q3k0kKnJ4hXX1iCQAPPHcSRn1BNcHq6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUcrrzzYQp8qjmEKdyIcttCHmh0Uz60OewP+Q3Q/Qss=;
 b=aokKBQJtSetoN7sHUPRqEVn1u4pH5j4ussC35iP6W0TBxaExx5yUEI0RX6XsxbmC71c6vM51Fo812R3Vz7JGyyTh6OjR55kGbu8JE0Zno+Gqoii240x1rzJ6iNaPKjwF2uPk7LZTkk+jzEqlO7rJAj1uBPPtS4B9CkgD2TlmO0c=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 00:36:31 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%7]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 00:36:31 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Thread-Index: AQHbqeFx9Vzbn4Y6aEe2s1erqXNM17OciTiAgAEWb1A=
Date: Fri, 11 Apr 2025 00:36:31 +0000
Message-ID: <PH0PR12MB54171BE8C6BFCAF322D59B6E8FB62@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250410062554.573023-1-Emily.Deng@amd.com>
 <BL1PR12MB5061918092FCB2FE9076CA84E1B72@BL1PR12MB5061.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5061918092FCB2FE9076CA84E1B72@BL1PR12MB5061.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5adafb39-3d89-4545-83b8-a205a311519c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T07:57:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|SJ2PR12MB7894:EE_
x-ms-office365-filtering-correlation-id: c1717ded-cac3-4eb8-6679-08dd7890e790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mg14z0GZq/belx2c3BYRTyf2D5bscugHMA5Hm57qNmhPOh7zQOfuZbg8gkQp?=
 =?us-ascii?Q?MSt6wmLuKlKneA+KU/aoa1ut6/njjefNRltlU691K1ftxorcE18uNj1cTtxf?=
 =?us-ascii?Q?VeMH9A5ar4sAuq7TrNHlm1YV8fHArywVv7db1lHQpyUlwh5VgO0u8vyfTEN4?=
 =?us-ascii?Q?u0M0iVBEgSVDnWMt3scSKWX8FT3AYJg1XUTwL9+OYEWhw6aQx51YDdjro+q2?=
 =?us-ascii?Q?TGljiEfALJXBAYiJAXuZ3c9AQ2NTS2ekIqfoQb9jynutq+myunHggJfOATJA?=
 =?us-ascii?Q?ATMUOQ4AUaB0enWClcNe86ZxzIYWcNq1fgpajEuU/rSODxctXlGwfwCKNW78?=
 =?us-ascii?Q?vqLrWyPMFzHaC+tFHJb2t7fOTW84xkJqrWjv6AnDalr0LskE7ox6Q22wPqWU?=
 =?us-ascii?Q?2vs6PaqRkfF2FUPYGU0/8Opl/QreEICGkXlpZm14XIGNBl+XoLGKbNIa/j5i?=
 =?us-ascii?Q?o+165EN5mOBUds8t6xaCWI43EfUpUXCZjWIWB2JslYncMo5j8FdJIZy60UGu?=
 =?us-ascii?Q?7LYi3fvX1ci0Uz3QkaB1/HKDaBoff5MN0ODSMAAjL8dNNnO3C+v8Dd+wHCSk?=
 =?us-ascii?Q?dy19zRsrp7fDJ7BHvH3nfWcwKStPCAkD+F4hfaztZQ4/hFLK0OqcLMBrJyNX?=
 =?us-ascii?Q?1KNg+wB3T3EfKPZWl7xk54vOszMvZ5N0yoBxQw0FpXCJsv193FnqAzGuN0SF?=
 =?us-ascii?Q?BCVRC4dQsQ+GudFN3+Enb6C+mhvIZMQUwbqHfRggQugcFU8KXSl47EUiyt9H?=
 =?us-ascii?Q?8L8PnAVFp4/yBVR1WTHoR3/VBSah8fNEHzVnqAvLt+cpEFdJAl3WTAiX+70O?=
 =?us-ascii?Q?3/TPPLmCAqzxpAaT3WctWDktjajBdXJ5IIDyTimT/ZuNY3UxwoZnffs4LeFO?=
 =?us-ascii?Q?wZgoUB+iJFwo3Nr6jTXoQRv4bJjuuYCDWLk/gdJxWRq/xYoRfUAs0O7hslNy?=
 =?us-ascii?Q?oCEec7YtP4p07MdGiEK/8Amtj0fPAeF197m5aDRqng70F0MkErDfmH5hfGiQ?=
 =?us-ascii?Q?xv8Ju1E6+kUSoCVIyCT6QRam0gXUt6VCg0KIcQtOy1cdXFTrJ2XyYe6ZXgq5?=
 =?us-ascii?Q?dPEs5jEzEQ/xLRt+BIsJG1A0z+QRCHV09I/BoWuq3m/AW80EnNxWCjzcP1+7?=
 =?us-ascii?Q?7FmjTo/bf+IG8B73LpDlIbtmehSPzzLSpbatXfQFUPZ+Ajz7H/G20wAV/oiS?=
 =?us-ascii?Q?CuYDREnoeDmnixSB82sk5PK1BjPjFZEBc8vEcyt2VKFpTGU976c+6lBOGjDi?=
 =?us-ascii?Q?PWeqpqktW4FPye5LqUEpQRF93neK7XiwH0bSiYxRnP1/dCXZQeu/60QtcYGf?=
 =?us-ascii?Q?UUS3UsYNkDu7l7J9wPf0osP5j83oGja0Jzlnk/eqwBA2ML78f4JRSt7Uosjv?=
 =?us-ascii?Q?ICwXevQx+83+FcagfVUDzMqfp7YcWLW6qF9+tj3JsnSzxkHdfbHKwEpBr9Mm?=
 =?us-ascii?Q?thccIrsIuFWLaUidY9J+vLa8QwSSD160TasHXiXW196fcb6LHQ2QmqDMC3y7?=
 =?us-ascii?Q?dyUaMY8mH2BP/wU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hbn/1pBR2gK+pijBkzpuhNx5kmrhAT5fDmWaeLmoAWx9RmCkeX5+s8ndRRce?=
 =?us-ascii?Q?fQ8AdhQjgaeA/zplz4DUfowhl4mgvtaC+jcatlC+f/990KM4B+ZeCBBrmtf/?=
 =?us-ascii?Q?IcqT1mYwShEihVzCDxK/SOrozY9V2KKF/MnrtstsmoMQj4livHmL+u7MPJja?=
 =?us-ascii?Q?h74xzW6WV9SCCE1CCVt7NBkEwxbBUQwTOsF0KoNZfjiRq2lDLmz0GRwio3pQ?=
 =?us-ascii?Q?iuRgbBciYa8EElUIpdzJtPfxbdafw384PNDZg0Ja/rQxoDnidVcrxSeC8MMi?=
 =?us-ascii?Q?KAPU+DOWSnpH0qo1BHwInOn8yXjnjhGBW8tlSzHfBC/dSMA7aHkUZqbVPybf?=
 =?us-ascii?Q?vjEf/BFGXH4vOAfT1WN3Is9V7YvST7qg0iHVAY2MxSXt6TJW/YkD3s5YtRif?=
 =?us-ascii?Q?seOhTdNtVE9F8RvO9GwcpyY7UNP1j6gipJ8dJpoRTAFZT9VvuR1IuOtrQ3vb?=
 =?us-ascii?Q?Rn5ywH3DMeawoJ4bFMPc0HWgZFsoLPYAvE7AUDdECrcfe6b/EYAr6i+5iHwo?=
 =?us-ascii?Q?CgLKcmiWbAdj3ojgbDuOblIiwJOIfrvqTLyB65D3FW3Yl05qWos+wA/ggbHS?=
 =?us-ascii?Q?8fAtsEMPsJMRMerKJFMhj5++qNqvSiyAwzF3qwNiE+M6UQCKPyJ6jo5efhE9?=
 =?us-ascii?Q?aY24FZw7/uz/SkpLdtedDLlcDQX2DVR9JqyM8O3Pww9o0aclMu36ycWvXNj1?=
 =?us-ascii?Q?TqDLXS3S34FKdaslxYsydv9BHcKph4bbKfmc8U6ln2dpjadm3OLZ6VwndFCa?=
 =?us-ascii?Q?mZUNM6BvuoWc26ItwD/HMzmvHfBHdnth2mJF9nuB8BOu5PKYntuY4I0DahPz?=
 =?us-ascii?Q?llO/GCtu9nq8omZsm1v5Vx/29uC+ajK3AlVFaGjCq39dyaMIzgke/ib7dj3y?=
 =?us-ascii?Q?ArKAookBW7sf4Y7wq99jVL+YAMt2F8q+Z1wfpFJKHqYdRbrIsTpWoV+UkNAJ?=
 =?us-ascii?Q?/s+LQcG6EkJgPhF9WBtVDyUbxk5jXRkmJFgFN+iLFJFrU1WN9v/2YQOyGc/A?=
 =?us-ascii?Q?3951F1mmD3zw5RyXC1wDguAMwHZyGsjTaYmWVp6xSznInaB+9848mcjifGZG?=
 =?us-ascii?Q?/36jFAPC636wslVGzkaVuKXgvslyCmZqqwdGfvN4PWqqoXM9+a7b3N1yFLB5?=
 =?us-ascii?Q?r6AiNZM7mpghfXcJjwKNtrshhAt6Me7gzdnEqI//ordBCjWFD+9nxtcMg30g?=
 =?us-ascii?Q?ngARf1MivDiBtcTyhFWczvbNqw4Ec+8dgRBP6sD6TjFAChavzHTOR+ZXokJ7?=
 =?us-ascii?Q?ETgMaiOvq8RtW2LnEmWvB6SsU1LnL0YM9YfhpWXqKSewi9coyOJ/b+UfWXlW?=
 =?us-ascii?Q?ybiyuqrTxveOJRgb9sHcdYmpKrPCWVLPuR+Kqd5H8T4NwBYpYPTTA2L7E1K1?=
 =?us-ascii?Q?gOd+9cBWMHBJQ/wOYzI+OKpv6UbG/U/EK6y4iYJKBVYXR3R5fZZNwUOcUuA3?=
 =?us-ascii?Q?aw4fiZx6ZHT0a0zIyaKsattmQrfU+lxzeuE0NBOEBMzcV4MqptW3UqGnacNU?=
 =?us-ascii?Q?re7qa/00KPhvMpRn8/JtAOsehD/XTy4RzqDWbXWFwUgC66/swNi2p13Ighb7?=
 =?us-ascii?Q?DEBY9rphvVNBoY/Qjbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1717ded-cac3-4eb8-6679-08dd7890e790
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 00:36:31.1695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZwbnnTDoORqlto4JF53SrULP5AMkoI45Oh4ibTaMfp+emhkwcLx/Kb7pDblipk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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

Ping......

Best Wishes
Emily Deng



>-----Original Message-----
>From: Chen, Horace <Horace.Chen@amd.com>
>Sent: Thursday, April 10, 2025 4:00 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH] drm/amdgpu: Clear overflow for SRIOV
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>Tested on MI210 VF also.
>
>Tested-by: Horace Chen <Horace.Chen@amd.com>
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily D=
eng
>Sent: Thursday, April 10, 2025 2:26 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu: Clear overflow for SRIOV
>
>For VF, it doesn't have the permission to clear overflow, clear the bit by=
 reset.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 10 ++++++++--
>drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
> drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
> drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
> 4 files changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>index 901f8b12c672..23bace1b457f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>@@ -227,13 +227,19 @@ int amdgpu_ih_process(struct amdgpu_device *adev,
>struct amdgpu_ih_ring *ih)
>                ih->rptr &=3D ih->ptr_mask;
>        }
>
>-       amdgpu_ih_set_rptr(adev, ih);
>+       if ((!amdgpu_sriov_vf(adev)) || !ih->overflow)
>+               amdgpu_ih_set_rptr(adev, ih);
>+
>        wake_up_all(&ih->wait_process);
>
>        /* make sure wptr hasn't changed while processing */
>        wptr =3D amdgpu_ih_get_wptr(adev, ih);
>        if (wptr !=3D ih->rptr)
>-               goto restart_ih;
>+               if ((!amdgpu_sriov_vf(adev)) ||  !ih->overflow)
>+                       goto restart_ih;
>+
>+       if (amdgpu_sriov_vf(adev) && ih->overflow)
>+               amdgpu_amdkfd_gpu_reset(adev);
>
>        return IRQ_HANDLED;
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>index b0a88f92cd82..7f7ea046e209 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
>        /* For waiting on IH processing at checkpoint. */
>        wait_queue_head_t wait_process;
>        uint64_t                processed_timestamp;
>+       bool overflow;
> };
>
> /* return true if time stamp t2 is after t1 with 48bit wrap around */ dif=
f --git
>a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_=
0.c
>index f8a485164437..8d3ae88b96a4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev=
)
>                        if (ret)
>                                return ret;
>                }
>+               ih[i]->overflow =3D false;
>        }
>
>        /* update doorbell range for ih ring 0 */ @@ -446,7 +447,10 @@ sta=
tic u32
>ih_v6_0_get_wptr(struct amdgpu_device *adev,
>        wptr =3D RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
>        if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                goto out;
>-       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+       if (!amdgpu_sriov_vf(adev))
>+               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+       else
>+               ih->overflow =3D true;
>
>        /* When a ring buffer overflow happen start parsing interrupt
>         * from the last not overwritten vector (wptr + 32). Hopefully dif=
f --git
>a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>index e9e3b2ed4b7b..2ad209406d17 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ad=
ev)
>                        if (ret)
>                                return ret;
>                }
>+               ih[i]->overflow =3D false;
>        }
>
>        if (!amdgpu_sriov_vf(adev))
>@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device
>*adev,
>        if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>                goto out;
>
>-       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+       if (!amdgpu_sriov_vf(adev))
>+               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
>+       else
>+               ih->overflow =3D true;
>
>        /* When a ring buffer overflow happen start parsing interrupt
>         * from the last not overwritten vector (wptr + 32). Hopefully
>--
>2.34.1
>

