Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0773C021BB
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0042A10E485;
	Mon, 24 Feb 2025 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLVV/3a3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2396410E0C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 02:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqEJCj0ZKPIHqwfLL7lLL9QrFvSAbl7MexXVwWN9LvJ+NowcklrSz42/mbxXB/3AI/aqgvMFfwvDnFwdczkbGWqf+vEYpqiTZJNMM5VSLsyM0nbtQTrAAYQhW5RM4EHm8WkWWavIOWXA6UZzmsNS3MDPUnLCJ0R6QZMSa4J81O3B6Ds3SfrLU8fU/ez+XMYj3yEJG+WA2B7xAz4Pe3IPVCKkcRepIOXkqpLQLQICvvWBieg9/8CrRRkV9ud09DCx4PsjxJCnEOtztVCsNF3+MHgRrMD+rF8CYntMzTcVGR2LNAJnoECzQdUbB6nLxldHL1FEw31DqIv3WJH1T0v6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmdhdgjCGhHErR5rZB54PR5CV/e80GiLcBe415mxce4=;
 b=VE2r8XLADgksdt0+c7K7P/ZkDm9+STe4Ufgh0YivEdWmYbH9yjMGWfpnV5A3j+oqvhJms3yQ8INVFvfbhBjNU6kSmX2lzPuAdgXFhwFhMq0vAQ7szKtATKW83ZGL7abZaf6svBPkiIWDKx60IZEMDv97BzJq8j60bxHRa1M09yNSFC+Ep+cdJALXYxC5r+LLth3C/YcIr15QG0myK0LM56vAip2mGbIL7qFMUg+1f2YMN24or8EMTFa1NpaCCqgfNA5Xepa5L3++1zegyFoiCpV3TnnrbJjGC8YZyq8Nw9jBVjO1hZGC/SAxDxGGnwfPNB8v8UOPxs21ArPfE+wbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmdhdgjCGhHErR5rZB54PR5CV/e80GiLcBe415mxce4=;
 b=jLVV/3a3uVTh29uXzeFZX4JaCxKA8+KMaDx1KQtxKCDMxRg8LDVwv4Yq05/CpaRJIojs5LdILwREkFvHDGrI5YLDSPj+3QZb5dT41sCIraGWrst0YV+1oTvRMIHZRbmlanOi3VhmK5KhLCydXw+mHTfYuDvHLocg0pnzPzNiIXM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 02:25:59 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 02:25:59 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Topic: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)
Thread-Index: AQHbhHbEC0IX1EOjt0SwgkhpAnXPtrNVqizA
Date: Mon, 24 Feb 2025 02:25:58 +0000
Message-ID: <DM4PR12MB51527826AE614AA04EF882ACE3C02@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250221153901.3508931-1-alexander.deucher@amd.com>
In-Reply-To: <20250221153901.3508931-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2faf4c71-134c-4359-bde0-5c19e59f42ac;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T01:15:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB6968:EE_
x-ms-office365-filtering-correlation-id: bdb3d09e-ebbd-4f8b-d2a3-08dd547a9338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1ap5IYjy++tiH/3fZzQyx0BPXds6mMyNa/uq5F6eeOlpozk62shCYYY/p02/?=
 =?us-ascii?Q?OmnZkyS2XTjuOaACVBv8piLkut+Qhgd/FPmATbRDjzFEjvCwW7srQwl8ahvC?=
 =?us-ascii?Q?vplpLVpq57PJx6BuY4dVii/l2MNh3amKCqfgp6Cv86H1iYK9S0NkZp1VKHv7?=
 =?us-ascii?Q?VbCqPCrsA2uNenqr8PHF1PQeJp4OcTN8/ghWCBImJF4QzmgUXkMRGAFh3LAp?=
 =?us-ascii?Q?HsIS0o8gKTmtniwPEtETw71u77xwm2fsNaYHDCgTz1cQaQWCbsOLgba+Jt47?=
 =?us-ascii?Q?wx3o3xFnTlU3LT8NYcnvIdAeYYpYhMF9x9B0cvEDoeR96hiK4/ydDbftbClI?=
 =?us-ascii?Q?T4kV4+TJ2hIakxkCwilqNxGYqCFZxiBnmtqsAjw9J3warvPAqCvFV79Ozk7z?=
 =?us-ascii?Q?2VYDWnHw2Z/MKcciFUpNUPaPWkxsg87xXKP3jjrApUYURPT47ifpNWXxFTPg?=
 =?us-ascii?Q?GEAZo3O396TD6hj3qRM7dv4UdUdjEC9Nk3lOjSKivcj5RHVVQPNLX9Gu9dew?=
 =?us-ascii?Q?eEn9kP5UbOBXGqUMmjfp5091ZGnx6zBeL7VmPr9A4SRoFaX11ZqbPuBKecxy?=
 =?us-ascii?Q?xOiYVmYWAcdzaa4yBXdteoYSInHAescsJjNxsHYQjs2kHFVoyTdbrlirtmoz?=
 =?us-ascii?Q?GboqukH3DP4GelXL4z5WrLtuP4jCe50wpsT0DLDHkEWNAeTubr66ag+nYh0L?=
 =?us-ascii?Q?A01o975VewfxdkBLkvV12ToAntaUa5JTDKH6r5tkubA8iUxFwexh/kzRZ0HQ?=
 =?us-ascii?Q?gXbib4qcKyaThFsQRNqgVdeWwUd0F31lPssfcHEGFU7jihGZFx9q8q4C1gz5?=
 =?us-ascii?Q?G+49ByHVIPDC1GpUaljZdGtot8lOU8N3XmXKMaqGyUa5G4eOz8xBt9PmK4QI?=
 =?us-ascii?Q?gPcMuBboJiR+YfiP7bchNXO1xqq0owCi5BNkf7rT2cNWgbQhFhvm/3PJbgKg?=
 =?us-ascii?Q?zmdjZYXQrAu0+xIjRAwaRGPfElCTuVQETUytk9MU3db7AfCsWMkAR1a7iHNm?=
 =?us-ascii?Q?AJdu094OYGP59sYEaGMTeP2T5IeBozh2cUg2i1VYmB2clkc8yzJ/XPTnCkAz?=
 =?us-ascii?Q?MflMvxYz42BkkOzYZYD6Mf72dtbOtJhx10nSABiw3PpCm0LGlf4xKnQm2y3n?=
 =?us-ascii?Q?gzWviBYPEa+XyY1UE/84jUe9vsGu82t2CF2bFwgsAmwqmInplOqqLgDK1na9?=
 =?us-ascii?Q?zAo5k9IClqgVszLrGv+jdSaxl6mRjHCsa+4s729QHZbslDHpI6lTeAvnUOu7?=
 =?us-ascii?Q?0gTzzZFXoXOzZZQjkttYI0S7aBpL5//3WA62KkRnSWNgYMCYoQXPBbukxx16?=
 =?us-ascii?Q?hrryXmkJCTLxdqDs7K6m8PckpU1p7dvp2Ngmt/4SslSb7nLeFnkSMCnlzMDX?=
 =?us-ascii?Q?HWOvAivtFr9W/GfrRj30Z4eqo+bs4gYmudsna6i2H90D1jz4sVAXLcbi8EPu?=
 =?us-ascii?Q?Y18GRRanGJFNa6oELQcNhTq3uXONbPS4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgeh+hDC/OYHDOQQVs46O9AaSBw792FriqlgmFvb3AOVemzVgWxnk2el4Vk2?=
 =?us-ascii?Q?la/aij/DXfM8oCHUtFdvGvMraZzRjM7A1cZ5yTPS6N7YbOurIE+t1IRfzhBM?=
 =?us-ascii?Q?QHB9pZq3u5WmHW7NXgY+tS8pPIMKx6LVjzlW8kHw+KsXjVFyQ4t4/5NRdLG1?=
 =?us-ascii?Q?tYoRFcSHHIgaFLc79l0yFJn7X404tyXSPPa9MnBJqplAghEvWOQhPpuPLyJ/?=
 =?us-ascii?Q?AA5pOfB5QqtuicwJ8AqOrIW7e5CnwyWi9Hx7RnxSShXXX4B2vMUdllH0blD2?=
 =?us-ascii?Q?c3OHmxMqRX2PlZSazMkNA0wcr1rQeyUZMzSFSAlfgLHq5T+lPE90c9TkFWQP?=
 =?us-ascii?Q?yPL5E9sZuRqp3w+iCqESak5RUuZ6Sbz6R8WWdAfD988IE0Uk+2jaQnbfi3BL?=
 =?us-ascii?Q?dd3EU5/Rd88ID8m+Y9Q8ugawChq6t1Ie4QxSdd/IcejZe3rfh9s/gbm55AKb?=
 =?us-ascii?Q?PbJ2tvBbkziw/KdB/EFwenXKHIJgjfFCUP5v5J2zMnKFyF0/lEMwlaaKUpKL?=
 =?us-ascii?Q?znXQxjffpOsXDh/J7k/sVIRX6iIoN4F3LuNuj6DxoEHs88oywPz0MEfAsv1/?=
 =?us-ascii?Q?M5YZDHDUPXXbl8Ag3ieLp1tx7OetStHhBfVwEs69u3yNM8ZzESspGJx0THH5?=
 =?us-ascii?Q?Pn+0LQ8DuizgiBgFdegWQPj1BkntyT2v65w4WZ31xefkBkdrXus9SjX3ZJfN?=
 =?us-ascii?Q?3jyLk8HGq8IapNkyLDQhppNQsKDphshJykhW6s0FGcDVAQDEqwC6NbY5YzFU?=
 =?us-ascii?Q?TVHKmX/hY05WaDjPSeEOuOoIoEwb40MDo+0ylJFGwo0vuqfdlAtg3nyxOYAn?=
 =?us-ascii?Q?W7gqoVizhwhKtCrC27IXVHTIChR7y6Lw4RIWb9v7x6K/KxwffBMYe2GJQKtF?=
 =?us-ascii?Q?Ufifw6ix1w52HMMv4HkYxKBXhEwaVX+wW2W5gCxkOSI2y++Q1h7q/AnAQEVE?=
 =?us-ascii?Q?KA9Pl+VOTspUsowToGZSzugmRL978tJmfiu7nnA1hJ12DoD+KRqAjpy1MTdv?=
 =?us-ascii?Q?M/B9i7j4eeOL3FUYIiYeZQ+XqViFHdWsTq24grkUHX4Z44W/+wPI/Hke5PqQ?=
 =?us-ascii?Q?4zHwsrWHbc+IPXkOWfBtkWP96+3Ahc//XhM+wrePwwcMsMTnswrd9ygjGB54?=
 =?us-ascii?Q?986bxOG1tp817NmlVFyz4WwIoho8XJjGR8QmVt9f5SIGPJ8OJpcS4gcvv8lf?=
 =?us-ascii?Q?LNr2hE8fjjpDSOIEHrObqYaHm+BT52GQSsapbIsEmUeAO+fcWEcDWMjEsOhp?=
 =?us-ascii?Q?5dcZS3SWWkTP8YpN2f1VcY6GPvrqLQWy2VQOVqFQ/cT5Ygzpm15oMCGM3Bo9?=
 =?us-ascii?Q?XlmYgSi/F5fVBiv1OK26zikzrXEOhFjLSt2IhLPVxK3oAC2/ODgap0+Z9Cpt?=
 =?us-ascii?Q?idyXzNn6v9d1rZrSs+vgn/x7hCPDX0kDPy8FDGqxcEy9WQUGM/eTtmrjUcKv?=
 =?us-ascii?Q?legvqj10bawqTZRlMit2xZ3k9wieojrdOW8yqYrN9JJ7TE62yOEwj92RsPw9?=
 =?us-ascii?Q?GEjLesfvF8ObUE4WlPXINkAJKajz9LNtXpEHV8sJTpm26klLCBY2VZnik4jG?=
 =?us-ascii?Q?Np0lX0JnrkvgLF6UY5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb3d09e-ebbd-4f8b-d2a3-08dd547a9338
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 02:25:58.8981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrENiGXz5moWS4j94CGYlEzQiQgv+dWU4coMwzwfFZRN03iU7qY+atlTM+SuGhS4zvd0jjVE7wUmNumr6VW/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

The is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 21, 2025 11:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: fix is_guilty logic change (v2)

Incrementing the gpu_reset counter needs to be in the is_guilty block.  Alo=
s move the fence error before the reset to keep the original ordering.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if th=
e ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index efba509e2b5d1..c37bc683253a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,14 +151,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
                else
                        is_guilty =3D true;

+               if (is_guilty)
+                       dma_fence_set_error(&s_job->s_fence->finished, -ETI=
ME);
+
                r =3D amdgpu_ring_reset(ring, job->vmid);
                if (!r) {
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_stop(&ring->sched, s_job);
-                       atomic_inc(&ring->adev->gpu_reset_counter);
                        if (is_guilty) {
+                               atomic_inc(&ring->adev->gpu_reset_counter);
                                amdgpu_fence_driver_force_completion(ring);
-                               dma_fence_set_error(&s_job->s_fence->finish=
ed, -ETIME);
                        }
                        if (amdgpu_ring_sched_ready(ring))
                                drm_sched_start(&ring->sched, 0);
--
2.48.1

