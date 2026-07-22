Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD33C44532
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 11:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EDA10ED67;
	Wed, 22 Jul 2026 11:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4qluDQT6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C73D10ED67
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 11:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNuWAXYlV9Mc/HDYYOt4Z/myZoxKORcdmN1CX1fc4CH/Nx82K6ZS62e2JSVzjmVXk72KpkRPZoaX3xXt3eR2BH0uEC9O6KVIYDjvRm1JTQiDJ9pn1i8aSymzfAVlt1K4Kt3o+4qm0+crlEjXxb3eICWKAW2pM0zgVhMRCdyykpAmWNLBJA3WN9VXDC152xCGfSyRasZy+4suGBdNjMknBtzHIRJLfgp6JxVkHXVzZ4asDHTUfO7mELdfyAe+t9YJDdgxsL3xdyuVSdP1dm8/aJ2zcvU60vLXvEjGEQ9P/NszeHabOSlUIoQ8NumiwLdcE2W+0SXkd5cnzzMuBbIQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQWLcL3fP4mzzwjNNUO27p2r2kS7HUKmB5o/NVrsTow=;
 b=tfB6O6LwyDy+NiAWVChzvZJUL+1Z8Kd8NVhLD68sdg2hXft/lHv0u/lMcBS9t7jJSQyodGVg0KWIJjXJp6yq/V/SplyIiL0YC5PAPq5LtEG+kyn+mKJeIAqJo+JHEnEeM8ALE6wuP/2nH0GDo/Tri09iCBDdBuOkXt3TFjSyMGwjs663srVPuTfh51MA3oryn+OVHwtQbX/FCbU/s3nZXpFHIWKwX/RHsDqG3vH/j5LcGO4Fhydlb3fu8ws67VWdVX7BDFBYMvT93QQksgW0BZ22Xj9MzF6Y49vCtjkhaZF1QDw9arfUOXZYHqEKhy1dFV09uMpuPJ0i0+z5ywmBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQWLcL3fP4mzzwjNNUO27p2r2kS7HUKmB5o/NVrsTow=;
 b=4qluDQT6zEiDDHRmlX2rQ74Rw9qHeZnO0x0q9ib54buPJ7b/BXIj+gt9OxugVAI08+XNcDxC3xAIL3rFmbfSxN7Upszr3aLQHESYnhU6BLpL6e0tMgjkSWKkZCwA7yb4udAhFZSLsiUEPuXT/Y5i8eYUkONXrmGuN3IuRgJFQ3I=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by DM4PR12MB7504.namprd12.prod.outlook.com
 (2603:10b6:8:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 11:13:16 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 11:13:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: restore perf state after runtime resume
Thread-Topic: [PATCH] drm/amdgpu: restore perf state after runtime resume
Thread-Index: AQHdGcYGvdAqbspsaUmkRKlWr+y59bZ5Yo5g
Date: Wed, 22 Jul 2026 11:13:16 +0000
Message-ID: <EAYPR12MB9991584ED579327E914EB32293FCC12@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260722103619.2737329-1-candice.li@amd.com>
In-Reply-To: <20260722103619.2737329-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-22T11:12:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|DM4PR12MB7504:EE_
x-ms-office365-filtering-correlation-id: cc0fb864-3c4d-44c1-23cf-08dee7e23a76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: YtAqMS06wb1iAFryGqMhwVElCvF/ip/8JuTAyHEthEqiU3h4HLHqhYZJXvgve3ccVs/SVThWhyWKB+Z+NaOg3fg26r2LF7FIxaZjEhI7a7iRQcU4xfRS0ORAcQksmNXxQt024rq9L6S2zjEURwz6FQyedZ4WRmLUnbfoHA4yTQ/cPpjw+QeM7+SLW79Gut06cnHksypJkQZhOYD4f7cW24vY1295i+S5jqNy7HbbNJ/8Y/Is4THUdsKhXtZlEll1/Rl2tTHbeq5g0hmSerTMdPayzH0eGd0VganKQc1Fyp29HDIUN9FD+cbmq1RuVEmvyVzKlX0Uf3GweSMYDCd/ca1yPcODRFN+89D0aW58Mbw+sGGXqjAA/0fPuCGZAUijQ2S3TFNUyI0jQTmS+cDu9Mf6hWsshCdUTiB13M/lvq3BhPwm8xvQV4iS4DVz/ZWOIH6qMjuBNW99Ti9doomnzKSJ5IOSLAW6l0t7l1ds2pZo2qUEz4uhG7FGE6l08eCMRxO8OyKLj62xZO1I/Dw3ItVsObR5X72TCE3Jz+uzKG//kdn2za51MHy/IlReAVAiIgDVUYyK9irJ85Avn6KmzfIsEAMhwmLwmaGI3WzD5KIXW8KJCPOdBgWJy7gefl80f4LYdJ/XAftn3tNv0vHfUHtdM+egc51d3lEKO3W4WHQCFkotFBH/VmXEz18Ua7hENI3NPZVxVWwXONTQf2Zydg/kHYzeGS41Qw9VYOsOU6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pwxt8+kLsq4UB/uTjjs0Z5ov+3q7iG6XNRmLHcHgUBKAMC55TO1zPQjc1IR+?=
 =?us-ascii?Q?VFgsl3hz7Vf0Nl8MkgmXvF4iz0njtKdLoXqgl3rcFL0QNx0UPj3D0l3O1lJY?=
 =?us-ascii?Q?Rm3p1H5uHzu7dsEUgWzPQUhZ2nV4IsEErMacSArG0yeFA64yGqUq9KyMCuq4?=
 =?us-ascii?Q?IbwwI31+vkYd3N7q0Vw6CQIPVyttWTbCYRzbIDeF013TBgACbeTalPRHRe8j?=
 =?us-ascii?Q?yNxehBTQNRxYCylpysCgPDShENOnqNqXXLSD9Ql9vrgL/h/xEkywteaGwWHQ?=
 =?us-ascii?Q?Hy1JZosX7dkzBTMwr6zGbRuvVi5YzFMhWv2woFkzrBij/vQ9P9r4jmf1CvY9?=
 =?us-ascii?Q?3VW0uy6yIJh+ui6N+LLnpSEHv5WsFNC56CxnY9B1GaPYzUC/Cpy982y5N8GO?=
 =?us-ascii?Q?3Tacj5j6cpx2ZJ9yf8+Hq1ZCiW4FAel5cS1yi2pT6mtdkzhRs3kSDO+kN+lQ?=
 =?us-ascii?Q?5B5o76maA5bm1K5jf5HqME7zj5y/bZTyzQh2p+ugqivN5AS9kTg9CMwN7NBd?=
 =?us-ascii?Q?Yrp87GdUoJsU2PQBQdGJwtt38NapuC5SheVeN2hlmnIuYsBLPh5It7exKuTy?=
 =?us-ascii?Q?ii+VEUdjdAxqtPCcnkTtTzbxgZIqG85G/8UOjGIpqEwlwH1njvuQgJ+avKh6?=
 =?us-ascii?Q?ija3GrLzl2lX2cZXbvKetWVvXF6w8KXbZDxIUDT4qrCmk8YbnOkVWH1GmKWy?=
 =?us-ascii?Q?J4PL0baakywmJ2B8yCVBRG5TrUEK1yWsR73qr/OuiH2/CDl98IEI+FEGrxzf?=
 =?us-ascii?Q?nmNin1fdBPf9ewjoZT7kDgWNxeQf7mYEKfCC8dfAUmRz3+P360kQURNwapU3?=
 =?us-ascii?Q?PShSNJDQxGwLdBgTJbF1tfTh3JlsYJUjskoUCtGT/r3Cgg6bBmAzpTAMJH+O?=
 =?us-ascii?Q?f32LGaojarnusL7G+iVH0wOSNIjFy8J1WkyiD+wcp4Y1I1mFzO6BUDi/gTBt?=
 =?us-ascii?Q?+T9jCaVA5TSy7MFJoIbESxfi/Ss8dm7YNWPYEELfWCXqed3Dh+u4l1pZZRH6?=
 =?us-ascii?Q?E1Mrn7BtTsw8uwqkFI22/fI6cjcwBHw+p0iEmb8TSUZUxy3T+lo1xpM74mg7?=
 =?us-ascii?Q?grTiuVIJ4q5/z/nz2M9VD40JQPL7skcbZm09DCz7S7uaPMBq5By+7mooT6Po?=
 =?us-ascii?Q?K3iSrzITXZefWtvPsRbgNitFdBiMEby8oQ1wgkYfdQYgcqGaaRV7KRpuFdl3?=
 =?us-ascii?Q?yLX4qN8dVXkkA1tuLccoV840KA81aVnl3Xgfw+dDfNR5dGHq8h+H90Y5GbZg?=
 =?us-ascii?Q?HeQDk4lzU4Q4xiGQajqXnW6+oT1RBieWuMkNjJ0hdVBv7yGsjZDB5Of0leBR?=
 =?us-ascii?Q?hd5KWxFxNnssGTFmKFgwtPPz1JzeTi4JaKUB/dnwO9QgdJ95GZ9CAJGzTn7k?=
 =?us-ascii?Q?R8GWU/R7F1DN9jzX4QRDw4aeSPbKdreais1iTZ82UV+f5wMipliirL4e7Zf9?=
 =?us-ascii?Q?ZK3K9V7fB4LE7KE4xigN4hi4DYJYOWCpP7WdbopcfftKVWG2Gb3H5lSG1Ahi?=
 =?us-ascii?Q?2tXVgcFyKV/HH2D/htTMv+SH72yxAaYQsTndieDINs+2xcJ+cUQeBPFN4yB+?=
 =?us-ascii?Q?iECfsQWMfiv2z+dkTKjSjw+RcaVSZOrkAhUa21fs0L1Jo6xYCebB3xlWjBcD?=
 =?us-ascii?Q?208pvfPQtJIhPTX2jJMBjD9zGEaoy/f2Hb7CjRDm/J4KbmFBHxT2HmGUeg1p?=
 =?us-ascii?Q?uqXY0Q/hD9sAMPlayH/USa9hpNLU41LVHU7hDA2FhMHeAUTk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0fb864-3c4d-44c1-23cf-08dee7e23a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 11:13:16.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODT8ABWu3weoDJC1KZFmisseQZtmT0ctS2ystYq8MFQNQkohcCs9r5OyHVhL8pEN5Oz3of7nsMLPUT0Ezif+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, July 22, 2026 6:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: restore perf state after runtime resume

Runtime suspend runs GFX hw_fini and clears perfmon clock gating while KFD =
keeps running, so block perf counters read zero after resume even though pr=
ofiling remains enabled in software.

Re-apply UMD stable pstate for profile DPM modes and re-enable KFD perfcoun=
t after a successful runtime resume.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 46 ++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  1 +
 6 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 121282dd30c161..38974beb98ef88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -38,6 +38,7 @@
 #include "amdgpu_reset.h"
 #if IS_ENABLED(CONFIG_HSA_AMD)
 #include "kfd_priv.h"
+#include "kfd_device_queue_manager.h"
 #endif

 /* Total memory size in system memory and all GPU VRAM. Used to @@ -280,6 =
+281,51 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume=
_proc)
        return r;
 }

+void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
+*adev) { #if IS_ENABLED(CONFIG_HSA_AMD)
+       struct kfd_dev *kfd;
+       struct kfd_process *p;
+       struct kfd_process_device *pdd;
+       struct device_queue_manager *dqm;
+       int i;
+
+       if (!adev->kfd.dev || !adev->kfd.init_complete)
+               return;
+
+       kfd =3D adev->kfd.dev;
+
+       mutex_lock(&kfd->profiler_lock);
+       p =3D kfd->profiler_process;
+       if (!p || !kfd->profiler_perfcount_enabled) {
+               mutex_unlock(&kfd->profiler_lock);
+               return;
+       }
+       mutex_unlock(&kfd->profiler_lock);
+
+       mutex_lock(&p->mutex);
+
+       mutex_lock(&kfd->profiler_lock);
+       if (kfd->profiler_process !=3D p || !kfd->profiler_perfcount_enable=
d) {
+               mutex_unlock(&kfd->profiler_lock);
+               mutex_unlock(&p->mutex);
+               return;
+       }
+       mutex_unlock(&kfd->profiler_lock);
+
+       for (i =3D 0; i < p->n_pdds; i++) {
+               pdd =3D p->pdds[i];
+               if (!pdd || !pdd->dev || pdd->dev->kfd !=3D kfd)
+                       continue;
+
+               dqm =3D pdd->dev->dqm;
+               if (dqm && dqm->ops.set_perfcount)
+                       dqm->ops.set_perfcount(dqm, 1);
+       }
+       mutex_unlock(&p->mutex);
+#endif
+}
+
 void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)  {
        if (adev->kfd.dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 338412a750edf0..1be9d5ef97d6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -164,6 +164,7 @@ void amdgpu_amdkfd_teardown_processes(struct amdgpu_dev=
ice *adev);

 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);=
  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
+void amdgpu_amdkfd_restore_profiler_after_runpm(struct amdgpu_device
+*adev);
 void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);  int amdgp=
u_amdkfd_resume_process(struct amdgpu_device *adev);  void amdgpu_amdkfd_in=
terrupt(struct amdgpu_device *adev, diff --git a/drivers/gpu/drm/amd/amdgpu=
/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5362705143bc75..f7a1064c340692 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2920,6 +2920,21 @@ static int amdgpu_pmops_runtime_suspend(struct devic=
e *dev)
        return 0;
 }

+static void amdgpu_restore_perf_state_after_runpm(struct amdgpu_device
+*adev) {
+       enum amd_dpm_forced_level level;
+       uint32_t profile_mode_mask =3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDAR=
D |
+               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+               AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+               AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+
+       level =3D amdgpu_dpm_get_performance_level(adev);
+       if (level & profile_mode_mask)
+               amdgpu_asic_update_umd_stable_pstate(adev, true);
+
+       amdgpu_amdkfd_restore_profiler_after_runpm(adev);
+}
+
 static int amdgpu_pmops_runtime_resume(struct device *dev)  {
        struct pci_dev *pdev =3D to_pci_dev(dev); @@ -2964,6 +2979,8 @@ sta=
tic int amdgpu_pmops_runtime_resume(struct device *dev)

        if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
                drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
+
+       amdgpu_restore_perf_state_after_runpm(adev);
        adev->in_runpm =3D false;
        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 2c1a936459ac87..2a140c40b53f9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3347,6 +3347,7 @@ static inline uint32_t profile_lock_device(struct kfd=
_process *p,
        if (op =3D=3D 1) {
                if (!kfd->profiler_process) {
                        kfd->profiler_process =3D p;
+                       kfd->profiler_perfcount_enabled =3D false;
                        status =3D 0;
                        mutex_unlock(&kfd->profiler_lock);
                        if (ptl->hw_supported) {
@@ -3364,6 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd=
_process *p,
                }
        } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
                kfd->profiler_process =3D NULL;
+               kfd->profiler_perfcount_enabled =3D false;
                status =3D 0;
                mutex_unlock(&kfd->profiler_lock);

@@ -3404,6 +3406,12 @@ static inline int kfd_profiler_pmc(struct kfd_proces=
s *p,
        mutex_unlock(&p->mutex);

        dqm->ops.set_perfcount(dqm, args->perfcount_enable);
+
+       mutex_lock(&pdd->dev->kfd->profiler_lock);
+       if (pdd->dev->kfd->profiler_process =3D=3D p)
+               pdd->dev->kfd->profiler_perfcount_enabled =3D !!args->perfc=
ount_enable;
+       mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
        return status;
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 88191a4c165796..81055ada4f80b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -389,6 +389,8 @@ struct kfd_dev {
        struct mutex profiler_lock;
        /* Process currently holding the lock */
        struct kfd_process *profiler_process;
+       /* Whether perfcount is enabled for profiler_process */
+       bool profiler_perfcount_enabled;
 };

 enum kfd_mempool {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index eb508fe3ded780..8b7020fc0577a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1180,6 +1180,7 @@ static void kfd_process_profiler_release(struct kfd_p=
rocess *p, struct kfd_proce
        if (pdd->dev->kfd->profiler_process =3D=3D p) {
                pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
                pdd->dev->kfd->profiler_process =3D NULL;
+               pdd->dev->kfd->profiler_perfcount_enabled =3D false;
        }
        mutex_unlock(&pdd->dev->kfd->profiler_lock);
 }
--
2.25.1

