Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B1DC48285
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 15:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE7311299F;
	Mon, 29 Jan 2024 15:33:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF65511299F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 15:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUD0T1OwuZkLvk++Azt6T+qCGANLyIMpCecRuSslaGq8A0bK6l8nC9XYJU8h+Co6FHv6e6lqI0huAvPuMhhiQe6KZN9ZyGZR86SaD3Oa3QwzrEt5BVdBk0UkJAj+Z1uNQiIDAqXyJd2IbN/546d+rJQVDIqgOVPhMK5FrG2ABqc7WyiouFssbur7Trmvsb/bVIkBdmfsKBSwP8ZXvAay/Cuk7u7+gE89RxdeOmBZTJqxIa7aTIYIy9pDBNA1AiKIaoMDrpmY3YlEsCNZqgmCyQyMkR5mYZPOnCZTttlLWXRc7COIN/phLD8cF3AUeEUAjmJeCYargE3ef1lJhW8dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTz4QzQu+XU7g0HwSHeHtTwY9l4tUZXu0HEEzqF8a0A=;
 b=KrrLoYhyYlP3XYhMxViglZ8jEi0RxAQwZaJ+6ht7UX857ebN9cGQv6kShBiXflDmQ7orxAIUoTJdYtoQSFcySvezMuTuo6kxop0kClNcBYykHhNVIFqSWmaFUGFeIniulTgx1FLnudzPSFnZrEo0YJrGaGw5ZIqvXt7hKxDosCRqCJMyhT8avpHH4DjSZFfP+FvcOn7rNG0vHqziH/iFSgvWsa/DAYUptxc6vbA82aN+3J5V0AzkxqJmONpK9sjeAyzcnjZN/cHvdu4KoOnIOO4HuJPFJEUBzqmPavKeaceYlNO1OTCRbF+XvfyZ4si+Fjr3fjLyCv+CWlRPXPuxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTz4QzQu+XU7g0HwSHeHtTwY9l4tUZXu0HEEzqF8a0A=;
 b=U9aRnHdq4xRZx8krJoXGvCvtxm4ataXt4SlgIfrUKXdpErePGBKM0fANeQxWO2NSGKwzUDsNHvpFtP705LrDvIx7t9B2hGJiUwFlCaL53DpsxJr1W1cLYf4SMzDRXAIff+Jec4P85oJx61A5zjGjkWQnboNZdn9hE9ZLwVPA3xQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:33:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:33:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
Thread-Topic: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
Thread-Index: AQHaT6m7qTBIkuRwKkihE6KhIAdGWrDw8WE8
Date: Mon, 29 Jan 2024 15:33:07 +0000
Message-ID: <BL1PR12MB5144C965BBBD655E8F722A8DF77E2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240125161514.436188-1-alexander.deucher@amd.com>
In-Reply-To: <20240125161514.436188-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T15:33:06.622Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8876:EE_
x-ms-office365-filtering-correlation-id: 3f74a520-067c-42ce-c8f9-08dc20df9794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+K9QOCTFb1+PU27uuvbajxoguXZfgkrKrS/pgx8+PMznI0uFZRjabVYZn0gsNViP+F6yjQDyAfzO28PnbTyGxMtwhgkIfM3S3riS28SdkKa9NO3tExDl9LieTtEUCjPC9vVc4/7lsfsmICpSq8fIt0lPvrVM1KfC9WAZKzGRBF8BxyXe58Ho7G5DQpky0EXX4waT4iKoanfr6UlRn0u1RrOSlejkzX07pywSOCNcZUvxRVwF7SDBotvccpRNEMzN4wa7jUJWlOLhtdWoH3NsjMrFiucHT/TYc+E43dTcdyAauoVu33DrcGtkDaQrPt3yx3Z9A1zljWTg1ba+sXp/IpJZPLWtO1YZtc0pXzu1oI2JlVexYKFiXCQN3VehmL1a+TB5Us9QylxMixJudwP/9A+qi9B6oarf7FFz99CDlCcV41tsAbAhM2nQzRTjkB9TS3s3Lg9gwgXoHW3XhR9mM7MiNN38jBCSDPLJDPlt7yLty86d0mntGMnqGi9bxT2xEFn/GoAqOBjj5Gu9hBWF+SFaDNuo2Rr+hYkSbcPJM9DYbcEG7iapcXkMajfauO5yt1GM4MoVg8Ko6J59cGcaFuZyYaCT+O1b+raRriaraUmcsiPoYdY0pX9f+0E+s16EzGXEj3hh3jCAkMxp1YpzN9y4oHvI/v6+RzR9rXpXbI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(19627405001)(55016003)(26005)(83380400001)(7696005)(6506007)(53546011)(33656002)(86362001)(38070700009)(66946007)(5660300002)(8676002)(52536014)(41300700001)(8936002)(4326008)(38100700002)(9686003)(122000001)(316002)(478600001)(66446008)(66476007)(6916009)(91956017)(64756008)(76116006)(66556008)(54906003)(71200400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KC0wK5Mv95wcJtphruOHF4ud6ZJFxdvAgqU+3bXE0RDi8uV9XbxLa6VFHwwU?=
 =?us-ascii?Q?fxJsQAGllOyqtbtfLKjBT72r/9Weg4G5xZpUkSK10OpmzeKDc4OWH/D3j8um?=
 =?us-ascii?Q?jSKXt7PY3R6tlIM5JztH5Qxp+FU7kEEsaGqAJdqWuwrt9UDxOyTHnJqaBIxg?=
 =?us-ascii?Q?MQwS+lbJEVQWmeSeLDWfUJ/eTIkrjptWY2TqLw6j8Nt+ewst1qkCv4PpmrvD?=
 =?us-ascii?Q?LPtFlD5Fc1XaiH0DEzbl/35Gx45XdJ9i9bE4ta6oAinr+fuBNWpvDHBvC2ux?=
 =?us-ascii?Q?lG7eWJy9epXEEpcNcry60O47vyUu1wLgx6ZYZqEh076TE4cUL90tFbTBLuMi?=
 =?us-ascii?Q?a+p4uQ3VkPM2FimbQXJSiOeALEVeSWmT5gBEsJhc3/9fm2uJ+tok/SpZfPhQ?=
 =?us-ascii?Q?09LJrxjyo4V14qvKVVFRiXNkHIcKNR4JltlUUrbnrSC+OwiwNPfAAkQ5BYkM?=
 =?us-ascii?Q?ANwH2tDK9gLeeu1I4xofKJWf19YolmbbnO00fTos/6BozNdWHZH5EabHXifN?=
 =?us-ascii?Q?e2GQc2Otn1DICtsKhxGXiQPxxNT8/XDFV/YNNCGWA+dA1UKhARABuP036VFq?=
 =?us-ascii?Q?2XKZwqzYLFb6eskp/qQbv1cMHesXinJZWwo8FSYXWEly2NMFhWY2H7bhFePX?=
 =?us-ascii?Q?tJvI5AAxgWD3xKMhI/3cBQNUK2fOxFkWrxMYVBfFZdfriCj7VRZRop7FWAvd?=
 =?us-ascii?Q?rSO4GqIlIdn4oMaUpKCJ9z8M/uF3I2bVq9xus6iOy4lMB6QAwLKXUQFWgAU0?=
 =?us-ascii?Q?/xGC6+fRmLXE1aL1iA7iCaRCrLz0GYTlfGA2XbkTsu7nSzsmpHc5yqlgwgqN?=
 =?us-ascii?Q?RufjsuDEeETb+5dBcKzHFNkIYK7Opfpe5zNAdF+UPEQnQevx3EOnDu+ro5Wo?=
 =?us-ascii?Q?ingwpyzZlRrgFTj+UuYb0u9LOvlWVZ8QLwcsUWn2/BH/Veg/Pf0w4jPRf80Z?=
 =?us-ascii?Q?2b5kGwopQL9iCy/ul1Ky8fPUrRalvuo7N7jT8iTCOkbR6ZyNBhZ/iMlrOCDf?=
 =?us-ascii?Q?ip06WMMIp5ZG4hY7V5klK87cD21ziDKZSDZJPcQoCnuHHPxLBwhD5yMtGC03?=
 =?us-ascii?Q?TYR5TlPsYARG/5cpWEwFBS3y0/bWqSTgODsHT+qUsBha1O2cM2HBnhMZ4WCH?=
 =?us-ascii?Q?dpsEnyrVjP78DsYyJl7NEfovzR2h6dLl7sI8gjM47vQBdhm4UwRCaJiR2N7j?=
 =?us-ascii?Q?0n44fdJPcItPpnPRi0aMIT10xErpg7TbDw8RoLKjQBtMOWjCGEjKpoiTHce9?=
 =?us-ascii?Q?Y2HOPp3rSf3mjK8xR/XBwAkgtJB2Y0PeNTNdtqLcdbNiDlvVj4vM8lt+2tob?=
 =?us-ascii?Q?vlrTR2+482hG9kwVHT3cDU1jtCgDVi8SMFlbGMKnebrWsPKpXZHchJJ060+O?=
 =?us-ascii?Q?k/d3ajMp0jwMDPuaDBmhe8AvOyvAe+t/KIckuyJ+O/TL1xR9DP5b0H0qbY0L?=
 =?us-ascii?Q?1KNen51n0bpXm/11b947ggeT116dFloInwm3YlYKZ+ZNFHAUaK4Vb3ifKuJa?=
 =?us-ascii?Q?6jjqhrZL7KCxA7LsEF1UJndEx9UI+t9wsb/I2yogYeg62kW0odu/kT4ATmFh?=
 =?us-ascii?Q?iiICtY6Lx3A5rpNQSNk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C965BBBD655E8F722A8DF77E2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74a520-067c-42ce-c8f9-08dc20df9794
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:33:07.2441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jy34dj9LQ3uErupLmbwLwcKQW1k5qRZ4iIpJPVrllp1hEGeIjUZhnODFA9b4L8fRFMgS5s5/cMemJipeLRtJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C965BBBD655E8F722A8DF77E2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Ping?

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, January 25, 2024 11:15 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.co=
m>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset

From: Ma Jun <Jun.Ma2@amd.com>

Fix the warning info below during mode1 reset.
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  ? show_regs+0x6e/0x80
[  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000005]  ? __warn+0x91/0x150
[  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000006]  ? report_bug+0x19d/0x1b0
[  +0.000013]  ? handle_bug+0x46/0x80
[  +0.000012]  ? exc_invalid_op+0x1d/0x80
[  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
[  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
[  +0.000007]  ? __flush_work.isra.0+0x208/0x390
[  +0.000007]  ? _prb_read_valid+0x216/0x290
[  +0.000008]  __cancel_work_timer+0x11d/0x1a0
[  +0.000007]  ? try_to_grab_pending+0xe8/0x190
[  +0.000012]  cancel_work_sync+0x14/0x20
[  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
[  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]

This warning info was printed after applying the patch
"drm/sched: Convert drm scheduler to use a work queue rather than kthread".
The root cause is that amdgpu driver tries to use the uninitialized
work_struct in the struct drm_gpu_scheduler

v2:
 - Rename the function to amdgpu_ring_sched_ready and move it to
amdgpu_ring.c (Alex)
v3:
- Fix a few more checks based on Vitaly's patch (Alex)

Fixes: 11b3b9f461c5 ("drm/sched: Check scheduler ready before calling timeo=
ut handling")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  2 +-
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 899e31e3a5e8..3a3f3ce09f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -290,7 +290,7 @@ static int suspend_resume_compute_scheduler(struct amdg=
pu_device *adev, bool sus
         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
                 struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];

-               if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;

                 /* stop secheduler and drain ring. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index e485dd3357c6..1afbb2e932c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_fil=
e *m, void *unused)
         for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
                 struct amdgpu_ring *ring =3D adev->rings[i];

-               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;
                 drm_sched_wqueue_stop(&ring->sched);
         }
@@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_fil=
e *m, void *unused)
         for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
                 struct amdgpu_ring *ring =3D adev->rings[i];

-               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;
                 drm_sched_wqueue_start(&ring->sched);
         }
@@ -1916,8 +1916,8 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 =
val)

         ring =3D adev->rings[val];

-       if (!ring || !ring->funcs->preempt_ib ||
-           !drm_sched_wqueue_ready(&ring->sched))
+       if (!amdgpu_ring_sched_ready(ring) ||
+           !ring->funcs->preempt_ib)
                 return -EINVAL;

         /* the last preemption failed */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1a04ccba9542..7ff17df7a5ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5042,7 +5042,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_devi=
ce *adev)
         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];

-               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;

                 spin_lock(&ring->sched.job_list_lock);
@@ -5181,7 +5181,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];

-               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;

                 /* Clear job fence from fence drv to avoid force_completio=
n
@@ -5648,7 +5648,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];

-                       if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+                       if (!amdgpu_ring_sched_ready(ring))
                                 continue;

                         drm_sched_stop(&ring->sched, job ? &job->base : NU=
LL);
@@ -5717,7 +5717,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];

-                       if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+                       if (!amdgpu_ring_sched_ready(ring))
                                 continue;

                         drm_sched_start(&ring->sched, true);
@@ -6072,7 +6072,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta
                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                         struct amdgpu_ring *ring =3D adev->rings[i];

-                       if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+                       if (!amdgpu_ring_sched_ready(ring))
                                 continue;

                         drm_sched_stop(&ring->sched, NULL);
@@ -6214,7 +6214,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];

-               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
+               if (!amdgpu_ring_sched_ready(ring))
                         continue;

                 drm_sched_start(&ring->sched, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 45424ebf9681..9ae386e9d41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -634,7 +634,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
                 DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
                               ring->name);

-       ring->sched.ready =3D !r;
+       if (!ring->no_scheduler)
+               ring->sched.ready =3D !r;
         return r;
 }

@@ -717,3 +718,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *rin=
g)
         if (ring->is_sw_ring)
                 amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE=
_DE);
 }
+
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
+{
+       if (!ring)
+               return false;
+
+       if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
+               return false;
+
+       return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index bbb53720a018..fe1a61eb6e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
-
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
 #endif
--
2.42.0


--_000_BL1PR12MB5144C965BBBD655E8F722A8DF77E2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ping?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 25, 2024 11:15 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;; Deucher, Alexander &lt;Alexande=
r.Deucher@amd.com&gt;; Prosyak, Vitaly &lt;Vitaly.Prosyak@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix the warning info in mode1 reset</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
<br>
Fix the warning info below during mode1 reset.<br>
[&nbsp; +0.000004] Call Trace:<br>
[&nbsp; +0.000004]&nbsp; &lt;TASK&gt;<br>
[&nbsp; +0.000006]&nbsp; ? show_regs+0x6e/0x80<br>
[&nbsp; +0.000011]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
[&nbsp; +0.000005]&nbsp; ? __warn+0x91/0x150<br>
[&nbsp; +0.000009]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
[&nbsp; +0.000006]&nbsp; ? report_bug+0x19d/0x1b0<br>
[&nbsp; +0.000013]&nbsp; ? handle_bug+0x46/0x80<br>
[&nbsp; +0.000012]&nbsp; ? exc_invalid_op+0x1d/0x80<br>
[&nbsp; +0.000011]&nbsp; ? asm_exc_invalid_op+0x1f/0x30<br>
[&nbsp; +0.000014]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
[&nbsp; +0.000007]&nbsp; ? __flush_work.isra.0+0x208/0x390<br>
[&nbsp; +0.000007]&nbsp; ? _prb_read_valid+0x216/0x290<br>
[&nbsp; +0.000008]&nbsp; __cancel_work_timer+0x11d/0x1a0<br>
[&nbsp; +0.000007]&nbsp; ? try_to_grab_pending+0xe8/0x190<br>
[&nbsp; +0.000012]&nbsp; cancel_work_sync+0x14/0x20<br>
[&nbsp; +0.000008]&nbsp; amddrm_sched_stop+0x3c/0x1d0 [amd_sched]<br>
[&nbsp; +0.000032]&nbsp; amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]<br>
<br>
This warning info was printed after applying the patch<br>
&quot;drm/sched: Convert drm scheduler to use a work queue rather than kthr=
ead&quot;.<br>
The root cause is that amdgpu driver tries to use the uninitialized<br>
work_struct in the struct drm_gpu_scheduler<br>
<br>
v2:<br>
&nbsp;- Rename the function to amdgpu_ring_sched_ready and move it to<br>
amdgpu_ring.c (Alex)<br>
v3:<br>
- Fix a few more checks based on Vitaly's patch (Alex)<br>
<br>
Fixes: 11b3b9f461c5 (&quot;drm/sched: Check scheduler ready before calling =
timeout handling&quot;)<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 8 ++++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 12 ++++++------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 +++++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;5 files changed, 25 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
index 899e31e3a5e8..3a3f3ce09f00 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
@@ -290,7 +290,7 @@ static int suspend_resume_compute_scheduler(struct amdg=
pu_device *adev, bool sus<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.num_compute_rings; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.comput=
e_ring[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(ring &amp;&amp; drm_sched_wqueue_ready(&amp;ring-&gt;sched=
)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* stop secheduler and drain ring. */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index e485dd3357c6..1afbb2e932c6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_fil=
e *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ring || !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_sched_wqueue_stop(&amp;ring-&gt;sched);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_fil=
e *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ring || !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_sched_wqueue_start(&amp;ring-&gt;sched);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1916,8 +1916,8 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 =
val)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D adev-&gt;rings[va=
l];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;funcs-&gt;pree=
mpt_ib ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !drm_sched_wq=
ueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring) ||=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !ring-&gt;fun=
cs-&gt;preempt_ib)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the last preemption fai=
led */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 1a04ccba9542..7ff17df7a5ce 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5042,7 +5042,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ring || !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
@@ -5181,7 +5181,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ring || !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Clear job fence from fence drv to avoid force_comp=
letion<br>
@@ -5648,7 +5648,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !dr=
m_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring=
_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_stop(&amp;ring-&gt;sched, job ? &amp;job-&gt;base : NULL);<br>
@@ -5717,7 +5717,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !dr=
m_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring=
_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_start(&amp;ring-&gt;sched, true);<br>
@@ -6072,7 +6072,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci=
_dev *pdev, pci_channel_sta<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !dr=
m_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring=
_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_stop(&amp;ring-&gt;sched, NULL);<br>
@@ -6214,7 +6214,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ring || !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_sched_start(&amp;ring-&gt;sched, true);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c<br>
index 45424ebf9681..9ae386e9d41d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
@@ -634,7 +634,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_DEV_DEBUG(adev-&gt;dev, &quot;ring test on %s suc=
ceeded\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;name);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready =3D !r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;no_scheduler)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;sched.ready =3D !r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -717,3 +718,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *rin=
g)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;is_sw_ring)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET=
_TYPE_DE);<br>
&nbsp;}<br>
+<br>
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;no_scheduler || !drm_sch=
ed_wqueue_ready(&amp;ring-&gt;sched))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index bbb53720a018..fe1a61eb6e4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,<br>
&nbsp;int amdgpu_ib_pool_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_ib_pool_fini(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_ib_ring_tests(struct amdgpu_device *adev);<br>
-<br>
+bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);<br>
&nbsp;#endif<br>
-- <br>
2.42.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C965BBBD655E8F722A8DF77E2BL1PR12MB5144namp_--
