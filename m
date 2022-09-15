Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACFECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 04:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F9B10EA5A;
	Thu, 15 Sep 2022 04:02:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B807089453
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 04:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSRc/lQilM6+JM34VrCIyd0v4ly3jiU0gzkORpfkta5AJucNDpFZOd9haH3IaEPSTKLqfJcKgZX+lb8DuWADEdXXoP2rxaC8rt05if90tEeS/hnDBSxna1s0nyt2JPJGq+Bes0Vzxm+Uo++aBa+e/ZtfhQ+j5Khz2qGsq9aYv4be5fk4HEpUM9Swia0VF7bM/tgDs9IO/ji8EwusC7+beLPGjBsYNkFUXQu1Mdd4nwzavbta63z/n7IgPW+azKYrFpJN8Rq2j3BAW6NXq4W91txXwumwxaP8F9i4dtxKni93JIs4J+xc9SaUKKWikgDsvA/ExLjJTX/j3YVHZ6Ez/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVKp7tGoMq3w/xRwlBHJGVWWeakxrkSU/LhEaXv6c8g=;
 b=isgYLwjA5oPDlnhtK2sxeYIO8MMrrcMrY4fcJMSyS9vgF29I+2Wb4NCcB5vcXfRhP2mPXXrPcZRKHCJMnJ+5/vf2WfoHDqqZ1fWx+dG0RfWIC4PUTmcDduKnB6ZKq5TNjH8uzzCeMffElxStC/RBpbfFmEDJfhi3/0W4+5OeiLuh2gl3AbPqXGf9FK7D5CbW9JFYm6w8ZF2RH7BsS32zQDyX5sRmNNU/cAaYIOIawgzI8JCJ5E4j7Y024s1F+FvBsV1f+53GgSpHcFOr7JEV2LoK/VhoAi6A7hDm9Y4z0xUXEZMrxOBq0NfA1i6EgEPvD+1CecPfDR4fWv2gU3x9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVKp7tGoMq3w/xRwlBHJGVWWeakxrkSU/LhEaXv6c8g=;
 b=09EEjd/Rj/HdLNU4Rjhox9dkEdJYt+7Dw9o0u8N1L9yQAnPlDABBEP3bNzvAjxFPn6DrT1VC7xBYIjNWlD3X2VEhGK52LlyTtfi9dlTW3kpDcfeQFBesRHaIjPkx4aar4wKWTScCuHtCwtmBzByJs/0fhj9fHCN2C3PHX2EpgRw=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Thu, 15 Sep 2022 04:02:51 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::7118:ff85:f7ee:b1ce%4]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 04:02:51 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Thread-Index: AQHYyCJXeAkvPXRu1UqTYYhuuS4eR63f3y8Q
Date: Thu, 15 Sep 2022 04:02:51 +0000
Message-ID: <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
In-Reply-To: <20220914101025.366954-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Andrey.Grodzovsky@amd.com,Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-15T04:02:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b46fa223-f385-4cdf-b474-dcc6bece1e5f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-15T04:02:47Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9ba9feae-4807-464c-85f7-dabd24e2ac74
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|DM4PR12MB6181:EE_
x-ms-office365-filtering-correlation-id: f60807c8-5172-4b98-f69e-08da96cf28d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +R9Nlwk5/mclK6Ms/c7GeplQHqTAVdi0u9s7MiCDP86sFDvVbst4OyudYm5ob75XbW6X0CZUt0iF3RqKP31QetNUVopHQQ+Jt6rHpPO7EsM9R1Y9fBo7p2SYeHrDSIS/XtI12lzZT30TQwO4zcwnIx4DBb3Q6cxgQ2MqvsuWXBoyMbrAE3UzGc+AbwVaU1rNhjZ20oUJqw8x54ma7/qdWpNYlQ8i5Fe3Z6pUhVcPOKaOCW6EHJO1TkzgGnytxYUchqm4oQPfg37wF2AVBq21KcKWiowfvUI/I8B0FoCq12JYEhzEYFxnru+79NZfQZ7hOGWZtRnEUIrhsik54AHnfx/tKihkM6t49VkH/gUZsjD5Siq5g1aX5yL9KM8kZWLDWPcxiaKFq+WOBWX1T8ofRh1y7zMl0ye8UNnS+q0mNPWGSmCiyIpgmxsPMoi+b1/NwGe4X40DgPlNSxy6oDCb+FfB9yQ6CNrxlfaSrnV6yZJmuBd+2Y7oQk8615ZUG50uUjB2FJG0q8gQa1dZa0vNZur6u+TKawVfNnmWUB7fw03Nz6VoPlyJkwFB3uhE7fX3/0vd0MitxxWa1KSxqxgOOJakMwfaq/u9oiG2kbdCRhuQAM9IiaZjSkxbs4PGEFkEN1C4jOmw9WGzaJESFzu+2DhCWkFwFCVt23R9ZwcoalX5DBrjMMmwItXEJIbM1amOBgXnKr7n+DOwO7YjU0xEkMaaAUDYEP/EvxyR68KziwWpBp2cPf0LNus8ym/OxIBn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199015)(9686003)(55016003)(186003)(110136005)(53546011)(86362001)(7696005)(26005)(33656002)(316002)(6636002)(41300700001)(122000001)(52536014)(8936002)(5660300002)(83380400001)(38070700005)(66946007)(2906002)(8676002)(66556008)(76116006)(66476007)(66446008)(4326008)(38100700002)(64756008)(6506007)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxi56H0rfO/me7SKwDfBFTwQwPGiovXqTR5FZNzttI5796O34m6wZbaL3RmM?=
 =?us-ascii?Q?6J3wzq7sWBRGChZEYQZKtC7GopB1n3bcdcYwbvbLfPgRMZyxULZBLs0EIOOi?=
 =?us-ascii?Q?HBr6sHwc5Bi/AJt5+BzrbJAMF452sK0u+vKTXZN6xgy44Wn/LU/gq/p9tNog?=
 =?us-ascii?Q?4g22aYH/4ffK5nWTqCtUO913I/CmKZA6+4qaudKDSPdTHIiuVbmZcTzMW1q5?=
 =?us-ascii?Q?9i+1nFYXu2/TNMiCcvhPA/01vN7ediJd3YfWt/Y9Nrn0Snj1cayWZC/6X4Dj?=
 =?us-ascii?Q?NTHzfelwlojts/5UtBHqKNUBJcGthXkrIZzVBSSfjqGYTUtN61x1Fy2eZ+D7?=
 =?us-ascii?Q?7sBlee23+Oej3/SeXz+PCBgSPc6Klw7NTMC5hU+6uKqS4mYAls4VG5acy/+9?=
 =?us-ascii?Q?R/mDTOINbJoZeiOrMzmjepmtEz19XyHAvg0fJn/rS7gZMjguqvcMNqGn4ctK?=
 =?us-ascii?Q?1K7SEoVYmj3l3JjcfoDuYHYekNxbX4Kt32T6lbeRyxMrSSVB0lhvbOvrXga7?=
 =?us-ascii?Q?kMIGFdIWnNcCFmL9r6yqzVtDje7w/33TXADNFAooVXGA0xf80b8xAwB1Yc0x?=
 =?us-ascii?Q?V5gvV/0nLY3NclUJrYDRTtzmJmsquJa0jpOC0HT951MKnS6rPrqZpxuEYY+I?=
 =?us-ascii?Q?tdAOm8aKZB4TYitIh9Cr86PbhhGPNsOEAfVxpTeEGMCC0yxwSpqWTFP7FEQd?=
 =?us-ascii?Q?bR6zcrNcg7Ocvdj03Oo4Ujs9tHALMh1FwhZ+dM0kvyeeeazCU+8GtFB9bydV?=
 =?us-ascii?Q?mlFs1sPPf3FalF5BfVxW4j2J92TagZHqr0A72pnqz4dC8N+JJ0EzhPIWPlR6?=
 =?us-ascii?Q?pICx/idHkkTXgZCStzIRoB0ApQhL3nIuqug+UG9Kk0WQya7OdzIx/rTtU4An?=
 =?us-ascii?Q?idjTv77YZgNkTNqZ3jEqO/40+Sufj3cbzIX9sumIJhm5qTlRRl81SyCt+PLN?=
 =?us-ascii?Q?TbyEvHCqj2oYP450h9FVzlnnX5iFhoDEPMwyLVensoVpmtJ3emsxxuDucWgb?=
 =?us-ascii?Q?hXmpb1nXixCXFm/Z1cm5OSpS+3xIZ9dY1hifmE2uMVQF6x4TS41l8drY8ClT?=
 =?us-ascii?Q?SbTagQm1GyoJE7OIqs0B/MSLKyyp1dqG/DkJDEUZ0q9J8eA95Cy/vWtZ/4Kw?=
 =?us-ascii?Q?mRKZbqLmGl1XAWMLzX2JD+ufIiH7es/Q0CosRkr+GpPlNYDKMRK1GVZ067tc?=
 =?us-ascii?Q?b1v57g+vTpOzJGSIBxRLxk3pWJxY+tWn1PlPQ5RMCc5cQW3c37Ufxi4kkCr4?=
 =?us-ascii?Q?K3bP7dX3yrAlwJEh3Nhvmyp3JFHJ8uTPTibzfU1/ILsBMF5EmdvupBVvl5j+?=
 =?us-ascii?Q?q6bAuMHqgd3GkBMhJHJQl1FibjhdsKgNFUcSCeST1O3dP+jYpmzs3KQGSF5M?=
 =?us-ascii?Q?U5FOeA6PpPlFXp3nTO6ppltqJ6gRN3xNl2UjYUWtanT48jlnQDSvHoHbpzaa?=
 =?us-ascii?Q?vc2bP/a8xyUqLN0ZbSajz3jOrJV0y37UkWFxB/qx9P5nUozZFKwl4GSOGkAd?=
 =?us-ascii?Q?gkEiZjT8k7E3VqZJpzTndloSTvuFzSAvMx8ecV70Jnlfpx8I7uHi2wEOo8dG?=
 =?us-ascii?Q?k4Xgt1M7AZqTHcHaejE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60807c8-5172-4b98-f69e-08da96cf28d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 04:02:51.3294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYm8ov/hX9PPa43hEMPnRVypheEiGfPErMZrVj2VwPK1n5M/cvzPRtucezHjQObL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping.

Hi @Koenig, Christian and @Grodzovsky, Andrey,

We found some reset related issues during stress test on the sequence. Plea=
se help give some comments.


Thanks,
Victor



-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>=20
Sent: Wednesday, September 14, 2022 6:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky=
@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow

[background]
For a gpu recovery caused by a hang on one ring (e.g. compute), jobs from a=
nother ring (e.g. gfx) may continue signaling during drm_sched_stop stage. =
The signal bit will not be cleared.

At the resubmit stage after recovery, the job with hw fence signaled bit se=
t will call job done directly instead go through fence process.
This makes the hw_rq_count decrease but rcu fence pointer not cleared yet.

Then overflow happens in the fence driver slots and some jobs may be skippe=
d and leave the rcu pointer not cleared which makes an infinite wait for th=
e slot on the next fence emitted.

This infinite wait cause a job timeout on the emitting job. And driver will=
 stuck at the its sched stop step because kthread_park cannot be done.

[how]
1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt before dr=
m sched stop 2. handle all fences in fence process to aviod skip when overf=
low happens

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---  drivers/=
gpu/drm/amd/amdgpu/amdgpu_fence.c  |  6 +-----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 943c9e750575..c0cfae52f12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
 		amdgpu_virt_fini_data_exchange(adev);
 	}
=20
-	amdgpu_fence_driver_isr_toggle(adev, true);
-
 	/* block all schedulers and reset given job's ring */
 	for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring =3D adev->rings[i]; @@ -5214,6 +5212,8 @@ int a=
mdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
=20
+		amdgpu_fence_driver_isr_toggle(tmp_adev, true);
+
 		for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring =3D tmp_adev->rings[i];
=20
@@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
=20
-	if (need_emergency_restart)
+	if (need_emergency_restart) {
+		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
+			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
+		}
 		goto skip_sched_resume;
+	}
=20
 	/*
 	 * Must check guilty signal here since after this point all old @@ -5240,=
6 +5244,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && dma_fence_is_signaled(&job->hw_fence)) {
 		job_signaled =3D true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
+			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
+		}
 		goto skip_hw_reset;
 	}
=20
@@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
 		if (r && r =3D=3D -EAGAIN) {
 			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
 			adev->asic_reset_res =3D 0;
+			amdgpu_fence_driver_isr_toggle(adev, true);
 			goto retry;
 		}
 	}
@@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev=
 *pdev)
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
=20
+	amdgpu_fence_driver_isr_toggle(adev, true);
+
 	adev->no_hw_access =3D true;
 	r =3D amdgpu_device_pre_asic_reset(adev, &reset_context);
 	adev->no_hw_access =3D false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 8adeb7469f1e..65a877e1a7fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 	if (unlikely(seq =3D=3D last_seq))
 		return false;
=20
-	last_seq &=3D drv->num_fences_mask;
-	seq &=3D drv->num_fences_mask;
-
 	do {
 		struct dma_fence *fence, **ptr;
=20
 		++last_seq;
-		last_seq &=3D drv->num_fences_mask;
-		ptr =3D &drv->fences[last_seq];
+		ptr =3D &drv->fences[last_seq & drv->num_fences_mask];
=20
 		/* There is always exactly one thread signaling this fence slot */
 		fence =3D rcu_dereference_protected(*ptr, 1);
--
2.25.1
