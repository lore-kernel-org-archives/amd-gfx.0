Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C6D75BC8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 06:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A6510E3D9;
	Thu, 21 Nov 2024 06:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="no+TUbCV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3198810E3D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 06:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+KKeHUasZX5o7alVpDzEhRZr+FgW6BFWUlRYm4XvJXCdw7LH0ojDB46CsW784HU2cIevwfpBWLJjU1Wbri/bo7AV7YAquCG7fjBGkprnGPevIP2gxQvjowDNLmdcZLhJyzuttynSvShd7YT20wA/fMLscEutpC04a2XYrKLBvCo+Q9M2K47jZYGwhU8b63pyVr6/9v0NS1+8L5+4fwYc2pMDA6KfudVFuuHg+VYq4T5kGHSbYo4KuoGbiZatLiCk9LIpbsvWZUi7/xItG7GJmz1lHkM2aRE/Vzrk3j2fLWTKARQf+F0CBOudh+xCUm8C3RrMINPdsGjUgtRSN21SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWV8Y90AWHpgLyel8fqjhijJ/XWACp1fKgeaVbEBOCI=;
 b=GzPivPKxGotgOsz+GPSij2p9WY3v77hwe8G0F0OUHm+v4r0oIVvocwOT84Vz3KG1adC5cGw4vCk38he9LuUt9/HPKxbBB/vtT3bHUf//o7QzlSGzGSSIaJMIXBG+gUTdP6jd4G8AfSXNON66/jXs+5Onfj+O5LvW7dqqH4hdhheGgCcKEDyVrRy7RwqM/26zkfApxYOpWoZlaIhflDqHThV5Mfxx7MIOArJMKcIN7kkpUFVsVBjUEH8Ti3fumIRJl2l0Da4aZLhOPW774akQLC5J34PQeg1Kv8d5TdMl6OkCJQ1Q7yKFbN22FLYdDgRNmyc7LIZuX4ystLABqMPs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWV8Y90AWHpgLyel8fqjhijJ/XWACp1fKgeaVbEBOCI=;
 b=no+TUbCVEQWmqZxEqp4O+JM77/QHtrpwX4YaaEKJ9wVLmOkKXbZyJhcrj+Q+nGwp5KUAOAYIHgzimUwJI9S3C3JhGwTJ/EOPqqgM2w1IthOrdXilkf1GSGL5cZJtVdg4bIPFDKTUJdCPYvo1g5tEIYrZ9mBw7J1ebS7eRmfnLBc=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 06:47:07 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 06:47:07 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Topic: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Index: AQHbO8hOnWx5fJjctEim5f/IwIjsn7LBSehl
Date: Thu, 21 Nov 2024 06:47:07 +0000
Message-ID: <SA1PR12MB73430909A842EFAB0FBD01A9EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241121034835.1011382-1-shikang.fan@amd.com>
In-Reply-To: <20241121034835.1011382-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-21T06:47:07.179Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DM4PR12MB6637:EE_
x-ms-office365-filtering-correlation-id: ebf32829-7c3d-40a2-76a6-08dd09f8513d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?v7+HO815IPl257g5ylEQsqEcX67gJ+u8Pxr5x9oR8sbecYDpdzDeuFxF17?=
 =?iso-8859-1?Q?QWROdeP4mrKuKkvlY43p0s3RLvdn/5N38tCK8J/iaD1KgccVKQXb5q2Gh0?=
 =?iso-8859-1?Q?0fbIDBHlvHT/hIdZpUZb8+4PpD7mLPjxIFf4yKnotajkGXskQ3aV8Denoy?=
 =?iso-8859-1?Q?KeF4zW4T9RAfNjmL9U9amBYcvqspG7ar6R+WFvSohl4lgsS0IJOpwOx1kJ?=
 =?iso-8859-1?Q?spLEXMpGkFT0aZT8yn6WxwonCeddnWG9YLqdYb36iii+Hctj5F02Viztw3?=
 =?iso-8859-1?Q?+TnL/j3f5MYpen4oer5mdyfU2olsDRhukwTyVay24ojL6lmuj1pTaSmqMc?=
 =?iso-8859-1?Q?WboVCmFWhXA1K3BAib7M8BGRZ2Xnjd0fed5bUeGdyeAjDTtTSN6XMXT67r?=
 =?iso-8859-1?Q?gBu2HcTIm8NVrVMna32wO33n0fTub6BInf/hJiiMuYYpEqwEypjbsMMuWN?=
 =?iso-8859-1?Q?sUZnvCrOMfSYV9IIkRMH+yHwtwB07Z+OwMsglaVqBauZ5Up8wY+c6NTdbM?=
 =?iso-8859-1?Q?Lt8a23qidNgEkyjXAVS1L4FXhqdPNKWEStg1RzoKgvMGtx9EK8BTTwrs1D?=
 =?iso-8859-1?Q?3BMIbnMRDlOaWNimnpFg5+pZa835c/9zBbUkqiwbadxZU6zHAgzTpc53uk?=
 =?iso-8859-1?Q?feIfKtjSLeUC2yVCEql53/qMQ1kAtSwyQXIcR3XXuF5P3O8k1p5LeXjHX7?=
 =?iso-8859-1?Q?rawJlPQI+mXsyH86Mb3Z370C9MrwyKkneGkspJy513LACXBkj+HJIqFUOr?=
 =?iso-8859-1?Q?Epuz/vYjpcBmFKEKOXOdnnH8fayxSFUPel4Zi+4Ue5umzmiihfFnfmJDPw?=
 =?iso-8859-1?Q?huhehGM0HEVuYcZMFJX4UIL3S1DAdaj8TlUq04miLlWviTYaGzbhxTWoIe?=
 =?iso-8859-1?Q?VSbv8s3wN6ChMtg9LFZjyUcPmaEYhhEmmwT4dyIuhIS//KbHWCcfjJrFUC?=
 =?iso-8859-1?Q?T4gfV3LszfB5U0cfPuwTg8UX2r5mAWHKzKMQfnifRJyLRsf+qCjyloCY0v?=
 =?iso-8859-1?Q?c43LjfT1/nk/7QjrjSCbeozLgy7TAheXbqBzPrdCynfxQ/emUqlUfAqCtm?=
 =?iso-8859-1?Q?gzQPblauzM+YMKg+VHxvzbOZCosCFClUyLaEq3vUnPHayLxf7M7O9UYgFP?=
 =?iso-8859-1?Q?Fj85LyAIwktsqs1Obw2iBU4+DotodaseJ6qts1ahI0H8YRRo02i0eAd2t7?=
 =?iso-8859-1?Q?2wKyG4L3I7MIHyS92Tim5If+EHM0QHGwH8VJg8SJB90loGoNvlPyDm9dsR?=
 =?iso-8859-1?Q?hmlmrUfCHgY+4ZxpQkniDQhhY6+1URHioxnMNi0pIUmSc2ZHCWR7XUsQPO?=
 =?iso-8859-1?Q?xGf/vygpEasowwO2U1a3VCpumA74jBYmVV5IVLREsZMbbpv5P5RF7yZSRS?=
 =?iso-8859-1?Q?5QAZsruicrTxjPgn1d0nslFpw9xv+i50zkNJWL6cu1o9lDhJmmmjU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0tIu7X4mAnVYBXRXbG7Nr7eUv3+xCZOrzQFbb9CSIJPtctRJN8QondTQJA?=
 =?iso-8859-1?Q?JcXnnqaPNhvdfEema5OVPzxKnIQQyzY3kwQW1LxThFLzSds19ILKBoF3L1?=
 =?iso-8859-1?Q?acOFdGDo8yy130tBCCM9IWNg7v0jWL/g1Fx9Qc5s/RvgLitmYBmTlaBLli?=
 =?iso-8859-1?Q?8Fcgi/YEOS+FV/bwkOPKtLPISuaPzwG/wcwOL5atLQ64iKasgPOZUPbOGw?=
 =?iso-8859-1?Q?JyaNRnbnWm0+PkFxVO+aeh/iwjxrb9WHVKgPyyTpP2/BVSrN7KTHTdLsz5?=
 =?iso-8859-1?Q?rEeSHI1ahCbO7EfTEA5Qqu+K7K/Szd8hDG5/47RlTJePuMDjTtuy+gfRwp?=
 =?iso-8859-1?Q?65kGvwWS1oA7bFy2/1zQR6QlQLpDJBTQqpW0dGhWJBW0jZ2x/NQmCQLkWd?=
 =?iso-8859-1?Q?aU23xYuMtLhfB0S/I5zslfW6VETKuom7ZHzgql+DzTqTKFtk7icYBApZXO?=
 =?iso-8859-1?Q?AcpFq5RcLp7L0rrp+v3hbrmfWe6xcbf3cmumNuGMh3E+SQJ7t0CEZ26t29?=
 =?iso-8859-1?Q?Pzq9cfeyMQb6jvAMRG7y951mDtV7RkpIX5QWqLCTcYexO7K6tlIz0cItky?=
 =?iso-8859-1?Q?HzuMLUdph+osz/irOhWp5g4+PdTyJ8Hd+QWctdTOMeum9RdgkVN4FMdvQV?=
 =?iso-8859-1?Q?UIxJM9y81oFya2RyTrYkH3T4xRFo/Xny2fXzkv2dNu+bypY43FsG3mMhb1?=
 =?iso-8859-1?Q?ZOGI8DFggC93qAUjH36PzAd70TVhQbeDRG/cJzrIlfEFoFF04HbRgQMrvs?=
 =?iso-8859-1?Q?1EMMna9toPZljcdVvAxPMkuOJb23VMShsnqsoi2PpUm75OBi8bD3K5HqGE?=
 =?iso-8859-1?Q?Ayl04tZShyw5kLOUjzOYSdgW68qIgdr6QLNZxWDSRrNJo50EALl4Vqgnda?=
 =?iso-8859-1?Q?vAgxMzdwsieuaJL8z7ByZS82SzL5g6MLn1Yal187TOSCDQLFrRGCajwJyN?=
 =?iso-8859-1?Q?yygl5VnSu2bwJDmXUmOaYxbBIVhjDeZrtzCQIfxicac4F2YJEBAAK3pLTb?=
 =?iso-8859-1?Q?zhDuKf7/v45XG5FFVuYnprhbsSB0OU1NarqxJRtEgDc1IvfhXwfDPzGO2G?=
 =?iso-8859-1?Q?0pldTh6CxBYDK3E0i+S1MX3L8tZx1OGZ+akR45LBWnb2IfciJ7cCcnEYQD?=
 =?iso-8859-1?Q?xUZ0ZtYwN5OvFXLc2vh0EVPzqVm9owWaUoD9cdATDxPbGVwna72xVlcw5I?=
 =?iso-8859-1?Q?lRxGQROm/FSKTly1RET8NAAv0ZvUf++I5NT4uOwzSUjNH17ApjlR6jy5lt?=
 =?iso-8859-1?Q?szP08RWYOTq4enRoE8Mb9EjhgRzVFCphOveaRmgoZntZGd05njnIECXhfz?=
 =?iso-8859-1?Q?DjJuVR9Zpg5avyvskhEMfFz9HeLQkRRpFaXG0KAII0+ymdIerESNXKxl+I?=
 =?iso-8859-1?Q?+i6WsPhH6hAEJT6CpOdf4Peh2+FJIMwpO7XmPOIXk4HvmZixFsAXSe3XUW?=
 =?iso-8859-1?Q?mLeeOlt5nFdTDT4DYYDdXwh7/leDoVSPQDPPjsJHVDOFu7dVcSiZ74xuSq?=
 =?iso-8859-1?Q?Ki0Q7cRfLJ+0EMh9AOL9O9LJ0O3o/FTSL5m8BcO5vaAfn5Qx8ShopJIwcE?=
 =?iso-8859-1?Q?fEMaVuH7b2iRDDV95a8ycvQwx3fiaSVb+sF8mJPqNCGPeYAPEgvJsOJvQF?=
 =?iso-8859-1?Q?uQLDH4X71Zp0g=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73430909A842EFAB0FBD01A9EB222SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf32829-7c3d-40a2-76a6-08dd09f8513d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 06:47:07.5919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mM2PVLtcecAD0biuxIuxSOuCGGbZk2i59exz+VZcUGRTIfuAxI7VMi04Dt6q+OPD57qGNXZlykgH5oD+NtuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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

--_000_SA1PR12MB73430909A842EFAB0FBD01A9EB222SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

+@Koenig, Christian<mailto:Christian.Koenig@amd.com>

Hi Christian,
Could you please help review this patch? I removed the timeout wait in the =
function.

Thanks,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Thursday, November 21, 2024 11:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad j=
obs

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..f53889ce71a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 }

 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver recei=
ves
+ * FLR notification from host driver. If there are still jobs running, the=
n
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it
+ * the timeout and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-       int i;
+       int i, j;
         struct drm_sched_job *job;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)
                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

-               spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
-               spin_unlock(&ring->sched.job_list_lock);
-               if (job)
+               if (amdgpu_fence_count_emitted(ring))
                         return true;
         }
         return false;
--
2.34.1


--_000_SA1PR12MB73430909A842EFAB0FBD01A9EB222SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
+<a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM340083" class=3D"tW=
KOu mention ms-bgc-nlr ms-fcl-b">@Koenig, Christian</a><br>
<br>
Hi Christian,<br>
Could you please help review this patch? I removed the timeout wait in the =
function.<br>
<br>
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Shikan=
g Fan &lt;shikang.fan@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, November 21, 2024 11:48 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Deng, Emily &lt;E=
mily.Deng@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdgpu: Check fence emitted count to id=
entify bad jobs</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">In SRIOV, when host driver performs MODE 1 =
reset and notifies FLR to<br>
guest driver, there is a small chance that there is no job running on hw<br=
>
but the driver has not updated the pending list yet, causing the driver<br>
not respond the FLR request. Modify the has_job_running function to<br>
make sure if there is still running job.<br>
<br>
v2: Use amdgpu_fence_count_emitted to determine job running status.<br>
v3: Remove the timeout wait in has_job_running<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------<br>
&nbsp;1 file changed, 7 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b3ca911e55d6..f53889ce71a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t<br>
+ * amdgpu_device_has_job_running - check if there is any unfinished job<br=
>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
- * check if there is any job in mirror list<br>
+ * check if there is any job running on the device when guest driver recei=
ves<br>
+ * FLR notification from host driver. If there are still jobs running, the=
n<br>
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it<br>
+ * the timeout and guest driver then issue the reset request.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fence_count_emitted(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB73430909A842EFAB0FBD01A9EB222SA1PR12MB7343namp_--
