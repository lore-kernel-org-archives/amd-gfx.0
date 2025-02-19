Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBAC021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 23:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D66710E8AC;
	Wed, 19 Feb 2025 23:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXpIUWho";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF19810E8A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 23:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb3kg9qaJi1ifdJFIP7mgYQBRc+6EZVP89F251Xi+g58CqBMSnAtJ8r5jT12+gO9Wvkt4hO1nHabj0GTKipVHyZhSccqX/jgjUnKiXIdBtDIC8/6RPWD8u9qR7aJtBqCyR7wolkISDR6Kl4y5U12qDRENAUKwzHnJPB73mBWHaeOSq82lwFoxvUpHp66Sc5zHUwZ+btHTtky2+RcwSx5a50hG9beLhupwNe/vtMXafNzroQoqn0juh6p1XbwZnCqBPJRHMDH0hF8zY8d23IE3Atq2thdAjtTZI2Gw4LKEeZzNiKUi94Um2iFBwOiB0xHqN7SctEKt71vta5YaHUKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF+YNmwy0Lf/HmJumC0jKPyCAi9oWMhIt4Nnn3V+HIg=;
 b=rMSrvxgBMj6q5feHUiHQCZu7iaF9sKrXKpZLdLKPL39pLvOG5CP+ttASue8c50PKCtFMLcJhtVSkPgTYskK+gu3SXb9c7R5CZSCVEwRgz0RfGRLZAUXcFNnf08cpf54o+riO1yIGCocbeHTltlJyROb5qoyEbbvZJyzr8nfhcYco4MaZeu9Eoae8dCdKOpXhCHIhxq5VhxjgJAukpx2WFKpvB/1D3TE04XKD0iguDo1/6XHiFEnrWddkVMw7m4NtTw2ePgRfS+Abi9QlkA/JoLHqb9dnz6z91keY0HbxfyOTMgC8T3xUZacC2Sul5qFw93BE8CtC8ZnlWzXQe7ZEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF+YNmwy0Lf/HmJumC0jKPyCAi9oWMhIt4Nnn3V+HIg=;
 b=EXpIUWho+qZsxL7yYb56c1ZsKRBRkAfw/zhkM/krt4hYwf9EFUXIdWcfelsfjXYQTXWZBqOsjR2Z7nEQcyttTztasV5pXYKu2QEP15Bp7l63ssMICVpwdFXxnrPztav5ayWhB0VWTqHeWw1XGVjJPwI+68ZpaXBzfXxFbOIkQTg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:26:45 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:26:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check if
 the ring is guilty
Thread-Topic: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check
 if the ring is guilty
Thread-Index: AQHbfdrjdJb9c6apqUCwl0l8RO6zRLNPS1eg
Date: Wed, 19 Feb 2025 23:26:45 +0000
Message-ID: <BL1PR12MB5144D07F922054085C142676F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-5-jesse.zhang@amd.com>
In-Reply-To: <20250213054715.3121445-5-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=271f6545-f851-403c-8b75-0e96fc49bac7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-19T23:11:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4483:EE_
x-ms-office365-filtering-correlation-id: 0fa77f8c-dded-45d4-c4d1-08dd513ce02d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eOvEzUNvK4CgxLKzXB6Bcnw9qR4k8RqteScRl+IXq60DTKehw+ghQtO3iHsp?=
 =?us-ascii?Q?orrksD3ZRHrSAj41G7VCwMCsyOz6eMR19zJ6oZMD1480Ik4Y/gl90BxSu18D?=
 =?us-ascii?Q?8aNd8FrXIRn2YdacQvI+kMp8jrwbdg5aoRTThb7mWegWi0OwEar6mX7iQboE?=
 =?us-ascii?Q?b1fkG/klKBvWlVBgy76yv62fkbJY8XaiEjLk25uJ4fKj+cL+zLBZcye8jwTf?=
 =?us-ascii?Q?RVueiNuWIbRFQEKILbnOz9B4PmWI2YPvumv7W97RjGPmmmeTSCx8is5ud1Oa?=
 =?us-ascii?Q?OiO/A/q07dORS0kCyIbUp8ZFjAOXho9XuKzWmRhiYGgoZPrpyJi0MuykzPLy?=
 =?us-ascii?Q?Z9C9jav/V+5fn6q24+A25j6O+7K5U9NJqHF4M4vDDphuhTwksP5x5ahVRuqB?=
 =?us-ascii?Q?ZW9iOGSXBG1Px0Lljb8/K7RZdQVtzpwKRj3ivqvv9UjI7U6TIpyPWItBXJzl?=
 =?us-ascii?Q?Qzb8gziuJsnZ1YPcE0VrSTa11L3TjBa154r0qnI3LEcCX3A5Rjk8f4eU4am5?=
 =?us-ascii?Q?am+US+qBCJ5gHsXxVNFudlxsEHsSiP+lzML7tXQk0kfI4rqLTh2/moKMHpyP?=
 =?us-ascii?Q?BEBkLzHAto64EeUQkz4y2lXNG/i7XeuU6DKnlw1AgfiDU7m4b26XMXSvCpkm?=
 =?us-ascii?Q?xLNvJZ15HA24zpDtqGm+oltGUqieeVt5uX52MoNLIvU8JnYOscD+BwY2D0ZX?=
 =?us-ascii?Q?DbGfI5o6I92UfcXAdlPAzkkbd3QGHZZgxg1EW454X+jX6k7lgK49BNFw7SOU?=
 =?us-ascii?Q?sKpkFaga1QVmwGxiaMLrONlciSippptyAGdraIx3X5srXWOnUJwJOoOoJlHz?=
 =?us-ascii?Q?5nhVjC7BP6QvrWn1ctGCXCWlTWJnRffPHOtRrWKJJATBAE8/rgG8/PZygmiS?=
 =?us-ascii?Q?cy9hiLGu2B5Vsa6z3tlI3r9xerivafGuw4JeYItQSk7niIw+I2V05kr3eTQd?=
 =?us-ascii?Q?HlFZfU+CPsRNT6aYKleMckdTTOKAlt5lxBREcfjApWsqsUC0u6Ulz2rrkiNU?=
 =?us-ascii?Q?z9UV8PkwBQbkOJfGIY7FIeaP0CuDhF7cyBOHz5U2YOYO/mbYaMQwHGP5MNtm?=
 =?us-ascii?Q?HbXimgEKq595XWBLIrouvSIY+iAkX+FqzhlqPwYiHg24ilisZhRJ4c/9xBjc?=
 =?us-ascii?Q?gxd/07sxo0aFmiOXJm1902AvmkmODabUZXfFyOUCslNbs1iaw2BofoHO5OD+?=
 =?us-ascii?Q?/ftIx02EOrvYVWz2mMDpLJQ7OX8S2PubTtru0De63zaFx5a14D2VkS4WSZ99?=
 =?us-ascii?Q?csWO14ZenvXzHWNbn70ipdZASaIr65usvPe2nIlcoNKbhby51SuPjYPE68MS?=
 =?us-ascii?Q?8BrX1exaVkzbaEzvLw5hMroo+lWb+X5PsQidmeMPfrSGYwhHJVl6z922BHB1?=
 =?us-ascii?Q?mQY5F37mFFOcvEKvCqLIQwCWdXUPgfWhkTciVPs7qfdyCHiZwsdol3zUKxgG?=
 =?us-ascii?Q?Qify3oi9vU+nyI4TAvfEmXd3LD5xwEJu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/3ppoeAY7DKN5JyAj8Ind1YkuBpOUOx3dHfkVIbf+oPApNL/vCIcJaHokGC/?=
 =?us-ascii?Q?yO5xtiPPqeDkOC3Goy7aTK1DoO0+ljXAwz0U3kCi/aUHPIQ2lG2RtSYtv27Z?=
 =?us-ascii?Q?EA9wpE+DzDgErZgzvbSehOlG6shUHk69+YvjE//mwGp/mV6fVn/6FNmehnaX?=
 =?us-ascii?Q?SM2RvykjInzH3xy4sm4mHGpc3xe1mmxug/m9li5x/rbXjdFNbQRp0wu9uDyC?=
 =?us-ascii?Q?mLHLioe7t/0y3qB4cY5J2j+aabcULJ/2h7gsbPiLwfc/jk62sIqKWXq7UWOP?=
 =?us-ascii?Q?is3GjcxE+vDkdMqPKhVIBUD8nu2zzJxmigL7LlIStQGMCuYyUTAnTaQmOJ6p?=
 =?us-ascii?Q?za3+NJuUkx+hWspUgiSenWM944BpGiDmkdTqfFJDd6WL59fKJaNdkVLOe4gf?=
 =?us-ascii?Q?6ee8sgUc728Hy8cPVA94ldYLocV++n6KBviPA9VPBUbPPLrsVsi61wOGnPtK?=
 =?us-ascii?Q?d2zgB6+b8GIIXfQkeVzH5w64PivbuOANrYCMHXg1gAB3Ah0A489+PV7lSENW?=
 =?us-ascii?Q?/lrM+aV+ZdJnJuYAwUx9cT3i3zuIs7XIDT/HRK5fbjrgmpdsF4m3RTWH+I+S?=
 =?us-ascii?Q?ihnxw+4lu9Z4jOORYOnGoz+NUn3ZU3TsXfBK+pRDEOE6ee1ckXOy2WH9hE69?=
 =?us-ascii?Q?Pn+VewoTnGOW5GHFHL0YBhdLzeeUXmo47XITpeCkUd1sIVfimXhIcJWVHIMh?=
 =?us-ascii?Q?dHPNVMYqlTTaUvJQjzevHlFvByLJ5ShJ+WdtlXRsY8buV16qYiaCKIKv/KVJ?=
 =?us-ascii?Q?xoG9qwGdNYwo0nT2IaobTweoY8wxWNIbIBKW9RHL+PDkNBUpdwxtB05j+CiW?=
 =?us-ascii?Q?5SKT9r4iLp8DpCoZUnVLEBvZnVO2d6rPJC6niBvBx0whdeKwTy0nqbunrN41?=
 =?us-ascii?Q?Uj03bT0HxQgHq1gTwTi46nE8gdjd/HbT/ja2lc6AWJxER7wsy+flJWr2YIgv?=
 =?us-ascii?Q?fHr+Eoc4ct6Tacq/uuvT9Z2/vmcTDPnOiAB3kp5UQLyaAI7PjlLRAMzQB2p5?=
 =?us-ascii?Q?4nc29dk+9kyLTKPhXCcO7ty/MM+qFDZIxDqtrc6UKEMWgV9bJMFZR9GpeBJ7?=
 =?us-ascii?Q?xB1WHJ/FD6bqFSwS/N4Zxos1L9YJ9VJp7Z30rEZrgOzA8XW6iyDO+G8/gdNZ?=
 =?us-ascii?Q?DAtYhZseTaN+a0H9xkQT2GrbjZJ4bBNS6+BRUyPgvMFi+dbEJxPkkOALxTa8?=
 =?us-ascii?Q?wDO7OPJ1W92BlHj25/Ife0t7rP0FYAYa7OxkPmfvMZKo7t6yJXKfuN6CbW6u?=
 =?us-ascii?Q?/dPMCFepWWykE95Vt/+Q0K+ZzHrDRWUcw/QM6moLHlc2FbcY64BVR84WddUp?=
 =?us-ascii?Q?iTMbc6JkoSAB/Z23owTNh0j6ygOQc7yqBrk11RItoQSEi7RhOV00TccUqh5w?=
 =?us-ascii?Q?jB5Kodsb8rPhemb46xndJpd+cYj2PIYZpFiGKEgVvXknSk+K+w+YjHYyLzu1?=
 =?us-ascii?Q?sU9f2/4ci/fIzo7OmEhbdKYIZV3jFLOKniM9NmcNZQTxkzhwVthpgy1gg8A+?=
 =?us-ascii?Q?vQGWuYa15MlYuO9pjZpjNhwSyq4/sUoMyzu97X2zFcn/MUMLzptMeDu+AfOt?=
 =?us-ascii?Q?4B5s3pOP8VHSA9futGw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa77f8c-dded-45d4-c4d1-08dd513ce02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:26:45.7031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uataHumcpjWCuHCXiy6GusqiPOGwOuwn28o2cUnb71VVs3NmVgGwxdp26EhJp0cwEK19ai8ZADjxB4HBcP3tKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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

[Public]

> -----Original Message-----
> From: jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Thursday, February 13, 2025 12:47 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu,
> Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH V7 5/9] drm/amdgpu: Update amdgpu_job_timedout to check i=
f the
> ring is guilty
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch updates the `amdgpu_job_timedout` function to check if the rin=
g is
> actually guilty of causing the timeout. If not, it skips error handling a=
nd fence
> completion.
>

Thinking about this more, I'm not sure if this is the right approach.  If w=
e detect a timeout on a kernel ring, we still want to do the reset, but we =
don't want to kill the job if it's not guilty.  This approach makes sense i=
f we have all kernel rings as we'll eventually get the timeout on the other=
 ring and the reset will eventually get triggered.  But if the hang is on a=
 KFD queue, it won't get noticed until we attempt to preempt the user queue=
s for some other reason which may take a while.  How about the following in=
stead.  We move the is_guilty check down into the queue reset area.  Someth=
ing like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index 100f044759435..48350d1030612 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -130,8 +130,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)
                amdgpu_vm_put_task_info(ti);
        }

-       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
-
        /* attempt a per ring reset */
        if (amdgpu_gpu_recovery &&
            ring->funcs->reset) {
@@ -146,13 +144,22 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_stop(&ring->sched, s_job);
                        atomic_inc(&ring->adev->gpu_reset_counter);
-                       amdgpu_fence_driver_force_completion(ring);
+                       if (ring->funcs->is_guilty) {
+                               if (ring->funcs->is_guilty(ring)) {
+                                       dma_fence_set_error(&s_job->s_fence=
->finished, -ETIME);
+                                       amdgpu_fence_driver_force_completio=
n(ring);
+                               }
+                       } else {
+                               amdgpu_fence_driver_force_completion(ring);
+                               dma_fence_set_error(&s_job->s_fence->finish=
ed, -ETIME);
+                       }
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_start(&ring->sched, 0);
                        goto exit;
                }
                dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.n=
ame);
        }
+       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);

        if (amdgpu_device_should_recover_gpu(ring->adev)) {
                struct amdgpu_reset_context reset_context;



> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 100f04475943..f94c876db72b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -101,6 +101,16 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>               /* Effectively the job is aborted as the device is gone */
>               return DRM_GPU_SCHED_STAT_ENODEV;
>       }
> +     /* Check if the ring is actually guilty of causing the timeout.
> +     * If not, skip error handling and fence completion.
> +     */
> +     if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
> +             if (!ring->funcs->is_guilty(ring)) {
> +                     dev_err(adev->dev, "ring %s timeout, but not guilty=
\n",
> +                             s_job->sched->name);
> +                     goto exit;
> +             }
> +     }
>
>       /*
>        * Do the coredump immediately after a job timeout to get a very
> --
> 2.25.1

