Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC9A1125875
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 19:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5761910E3DC;
	Wed, 11 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZtIfzEcT";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF9A10E3DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 19:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAli5JxHZE7RFp/XK/thcAwZTUsbv1rDdYGeUIcOraoeGyM/DXlkstuEZaJ0lcLnPAAQl7t/dW+N0tfA6G7+mUbawzZbgpkwdNgXoS1SJYn73XjauOY8/Uw9HML7dszmUwatJhnu+NV+AavO7402Ajo6CxcqJMZRudMDoeES9idLSrygsw0cUFEUjFK2GaqHXfmwdNKOGGhTB+5FudCw14BdIpq6S5ioR+97ZF4H2Pap1JCJpkGYWE6ilh48O4jW2iIFW/SeZkLlIVV+fdSwh5ryIu8cFZy+qeX4hCYQaGuwtRLqDKqj7Wrd4bsxg0xlW3RkKigCwpZc/C6Vxt7uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZjOvABQGxKu9Coj7whjhDNRuUXKbtQIvmYeVU4zplk=;
 b=mPwvTgSO/AScWSfUUjUNvws1NqUlm5bLrj1ZQsjA+jlXkEpmBC65RKoQZOY9Kree9v0aME3vfp6fHZHwftOvNwEMzdI0bYQbEkfNkqhTeD65CSNdQ/cIjn+qQTHATsdE+wcKaR03hXazuHdlfOPFnHbOt7GCoS/O4+5eGa+/corMhHdS0i/6y8Jt+OECYzv6llOlhbO8+op/kSndsIe2H3ZLiVYsSEvTgWg9/qe6KMyU0C7Q5qN4l2kw6py9P65EMQND88UyZ+HqCx4jQTAX3vM44vrLxnQcp1bekLTJ2FLSZ04NkDJ/jdaaJMVn5s4knrY7t0puIrEBuVUASC8MEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZjOvABQGxKu9Coj7whjhDNRuUXKbtQIvmYeVU4zplk=;
 b=ZtIfzEcTYniQziWlDOVwFa4iUi5RMrYKN4D78HKjnZ6i85t/FUoREWMPSNulHCfC4RnZk1JdQWHnfGiuke9Ar2ZpGsEsOF3BCB/5rCzEwB13TUPCrzy+njCGYYBphLvC1tYoXujhVVfzxAsXphsSlBq7SuJkvEPusBDY2H1HV+o=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 19:40:32 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 19:40:32 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
Thread-Topic: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
Thread-Index: AQHcsY2udMfwg5/GOEKkVE2chgMJh7WpuGNg
Date: Wed, 11 Mar 2026 19:40:32 +0000
Message-ID: <SJ1PR12MB61212CEE0DBA45B1BD76768A8047A@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
 <20260311193123.2531557-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260311193123.2531557-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-11T19:32:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|SJ2PR12MB8136:EE_
x-ms-office365-filtering-correlation-id: 48154526-4689-46d1-6177-08de7fa60ec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: YDUnVjwngFBVUb5ejHvt4EBVIyiJUDfprcGwr8QUMLqx6bWwmWM+fL+QDAbDmrwGEH6WicP83N8GuzR8gyul9OnAmjUWf+1Qk+BL5eTm2SXQjkI9uWedYLnF4kA+hF0D6+hVn+gci8MYI3tec9ErxuzRaXRTCTZILyL5iUoFgISHR+/hxXPGHq68iGNGlf6T00K1SAfVAuxnj1+GrKqXcegwGt59Wx7GyX8fIcnyTQiZSkLFvz2Ql4j66AkqN6eFCdVwH1UVUcEyEy1X9tj6Pi1BNrixRLbcds3LDUdSk07GNopmNKqxjq3rvzOlEd2ggWSV3h6VezEymaq3rOlk19uqUFJ7fYaENq/qXgrUUDnoXXZSiD9YmQM28LAO6IzcUPVvdCb3P2ZWpv74Czkymy+9lkJ8RlMLY36iLGtv5uMLwl6T5mAOWWluAhR7mrualT6aDMSNDcKnl3X1aKpVyEwJhEF9qlTfYXvEiBlxA96dM2wDiPCbOsdENcB6p5vUXjx2X3hjqhrtFWif5OFlZpFzK7ilB6Vy2N6ysYhc49iHPcMOES3ElESJcJLHntjDiE58mXp72/+v6eAHMWZV5CQSl5OnejxHvA1HK9JnLNta6z3vaUcvkQCVIpSrjrYBedzmmgVREmfANiSpYYGLaYF0k4H2zJz5pAh6xefNJ77PnFH8qQ/qO4o2DYHsiTzpr9knnKzZpHVTcD0YR/sJZjkYI3tEZ1qTmQBhEeG0R6OKWmaut/H5ONNVnJdGP+wZ47N+9WLPceZK1l0UycCM7MPBBFDU94xqPpPGY7tYcXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q/HaJemtYiyMQj7WcSerBrsiximqsJt+E4kNWSjbjvPpFISG21Q/CdBv/kI8?=
 =?us-ascii?Q?zzKrX4kUV34gVt0Qhp2Mwd8BYWk9yIcyXyOGST9xDiLQQcQx7VdBkUSgGfQ8?=
 =?us-ascii?Q?jfn5NqWMZgmXCpSgds1t0N7MJNSgT6BqOlyv02uOAcJji9+jPFck5rCRZr6K?=
 =?us-ascii?Q?UwyMiN63YVphVcUyNFt6/ZAf26pPjRmrWJmTBd8FE2t5AlOfbc0/mtYG9gke?=
 =?us-ascii?Q?uYfnysZeqpR5j2JKNdAdED4GuW40E/o+5lT77on1cXQuLXDfwlsbBkh+uu8k?=
 =?us-ascii?Q?7Ni7eTuwsRS857M+Fla/Hy82dKtGPAJATTJV1U2XLtObVwuB+4WeRkK+bXtB?=
 =?us-ascii?Q?WIC04xuPR6sBfKog49yt846KW3rjhOECj50NXRD+Wrqn+dhOYr8+tK86l+SV?=
 =?us-ascii?Q?gDRYS3wmmPswXukbOZVzeQncaZZVg4UwdMhFC3NxOfMBYvh27kjnQYPv7m6h?=
 =?us-ascii?Q?2CpG+Q2D56hHLghxuf1fjZlvfVGMHlbE9ToX8K2mDNYbKaPtABA25sLtB9BI?=
 =?us-ascii?Q?CR4sCJu7ogyi0mEW/AqIwFjkHp3/N/zTM/4+VBfB3lNpiNH4vTPWV+HwbzR4?=
 =?us-ascii?Q?m0VPdAUlv5MtmkqyGyfeQ437WSR7CT0vqfs9JLsfLvVPfhO8AyDyHQE2KL4R?=
 =?us-ascii?Q?ON/s4xhb4AJQxdtBNfYgqx/Rvjm3+SKOjcdmm07Od+Qg5iswRcjFNdAyNU8P?=
 =?us-ascii?Q?U3yRpoxNExOnpCgBRYxOhgBazZJH2ayZPALRYBR9LE7wo0/D0O+f3TFIbUVj?=
 =?us-ascii?Q?8fdS2EYMV/dhs03BhaJNXRa6W/D6DMWSBec1BB1b71ITcrVUfb4H7scedZMw?=
 =?us-ascii?Q?YxlEBZlL+4JWZFwpkYQ14hLAzvtBWgMlpLybQyJUXKuClqg33dgDqgwCXqF/?=
 =?us-ascii?Q?DUxH1R+b8KF+cziFvlbX+g+5TV0fSpRuv907J+dmwJoQLgQmGm6+3PmZ93m4?=
 =?us-ascii?Q?nvWPC8HZyMlPoNTeOOWbwqKHmGwauI4ygWuG+xXaYdIFSIZsxGwQPVw72ob0?=
 =?us-ascii?Q?1v1OTcg5To6Jkq6uKX3lpiizvy1+i6hAZExVID1kzZ96eXXG/XOyQlrSU4hS?=
 =?us-ascii?Q?UfcMIrnEIh6ajH9f9AHKBNrax1U8sjebjeg+i7V9W0nBiuaD8cHfUjDc1gzB?=
 =?us-ascii?Q?JWz4hHm+dA3k5jA1+Lhpeww0e+I064/zFs+u0hwD7b5w8ZLOuTAfvbhDtxty?=
 =?us-ascii?Q?ECUnSPMe2uBgZNjklZesFLiTjzH5wQ6NNpj0BISEDNvqfAI00Hf2mFk2Hzd8?=
 =?us-ascii?Q?c5rD5oW5TjfK3Rapk4A1Bd8NN2a4x0lYTZHnXigTPA/8+GGExK8OdUATEFjX?=
 =?us-ascii?Q?WHU4pkH/I8WboqdLIuYlHKNEA7OBH6SMtHHj5H5Pn6U71cJn7tBnanGuMy96?=
 =?us-ascii?Q?umBCnW/G5wJw7d0W9zSpesw3VADEYWuWqfzQ+ITEJ+258TmrJLK07vtcD0pb?=
 =?us-ascii?Q?J+otLtlSKL9L+CTvpiPphjOFf9+vX5RPNJxeSCroDQLVAoB6fF0l4slpJ3rc?=
 =?us-ascii?Q?irHqFaBNkh2u0xlMceJmOfzhAE6qzTqB/lgnI6xbINovDwnNuDDqetNCRkma?=
 =?us-ascii?Q?fHg/mGjGaiWM+1mkMS0FH/3nnBxp6S2YeUs+PhObtKBqypV1R6Geguykjh6L?=
 =?us-ascii?Q?OaaSKCBzEsIO1AclTMZhCcZWYJmEQYXKy+phtcsaun7pI/Ls+JcMdIcXhvT+?=
 =?us-ascii?Q?rzOkIvB/q2vlaaMkze11GlNFhep8t2bJ4PYvqJHXBS8T5nQF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48154526-4689-46d1-6177-08de7fa60ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 19:40:32.1667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfTah1l9w0HsAhxg0GIsL39zVIHROKndzZTqe9H0MdIPaxr0MetOoDiGnv/2emo6YVNPZSf16IHCOc+FerOl4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136
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

Hi Lijo,

Please help review the latest patch version. The faulty source is the amdgp=
u_vm_cpu_commit() requests too many HDP flush commands to KIQ due to VM pag=
e table updates during reset.
The new change fix this by using non-KIQ HDP flush path when in reset, and =
added extra fence force completion on KIQ rings during SRIOV pre_reset.

Thanks,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Wednesday, March 11, 2026 3:31 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; amd-gfx@lists.freedesktop.org; Xie, Chenglei <Chenglei.Xie@amd.com>; D=
eucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit duri=
ng reset

During GPU reset (SR-IOV), amdgpu_vm_cpu_commit() is called repeatedly for =
VM page table updates. Each call uses amdgpu_device_flush_hdp(adev, NULL), =
which on SRIOV runtime takes the KIQ path and submits a fence to the KIQ ri=
ng. That floods the KIQ ring while the GPU is resetting. After reset, hardw=
are has cleared the queue and those fences are lost, but fence writeback me=
mory and sync_seq are out of sync, so amdgpu_fence_emit_polling() can hit -=
ETIMEDOUT and block further KIQ use.

Fix:
- In amdgpu_vm_cpu_commit(), when the device is in reset,
  use the non-KIQ HDP flush path (amdgpu_hdp_flush) instead of
  amdgpu_device_flush_hdp so VM updates during reset do not submit to the
  KIQ ring.
- In amdgpu_virt_pre_reset(), force completion on all KIQ ring fences so an=
y
  pending fences are signalled before reset. The other rings were handled i=
n amdgpu_device_pre_asic_reset()

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I95404ce348ad546ddff1ea3b95a3f790299eb7aa
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f01f385091083..5998e0a04d760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1191,9 +1191,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_m=
ode(struct amdgpu_device *ad

 void amdgpu_virt_pre_reset(struct amdgpu_device *adev)  {
+       int i;
+
        /* stop the data exchange thread */
        amdgpu_virt_fini_data_exchange(adev);
        amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
+
+       /* Force completion on KIQ ring fences so pending fences are signal=
led. */
+       for (i =3D 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
+               struct amdgpu_ring *ring =3D &adev->gfx.kiq[i].ring;
+
+               if (!ring->fence_drv.initialized)
+                       continue;
+               amdgpu_fence_driver_force_completion(ring);
+       }
 }

 void amdgpu_virt_post_reset(struct amdgpu_device *adev) diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_v=
m_cpu.c
index 22e2e5b473415..50ab9f9604834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,7 @@
  */

 #include "amdgpu_vm.h"
+#include "amdgpu.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"

@@ -112,7 +113,11 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_updat=
e_params *p,
                atomic64_inc(&p->vm->tlb_seq);

        mb();
-       amdgpu_device_flush_hdp(p->adev, NULL);
+       /* Avoid KIQ during reset; use non-KIQ HDP flush */
+       if (amdgpu_in_reset(p->adev))
+               amdgpu_hdp_flush(p->adev, NULL);
+       else
+               amdgpu_device_flush_hdp(p->adev, NULL);
        return 0;
 }

--
2.34.1

