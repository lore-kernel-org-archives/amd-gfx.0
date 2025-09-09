Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7E0CA1016
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 03:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C18410E229;
	Tue,  9 Sep 2025 03:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YV+VsVPi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4829C10E229
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 03:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK4+/NndFS+eFt7P3BV/T7fVyUqtzPzPbHGIMRH3YDuwyfFeMOXUfE+Al0fGCpVq3OOX2bARDEHwlorm1Wgjp06HxqRjZyZgccaI8MKFT7GNkmeVREDoefsjFRsxCIOsuntGwIOjm5mi+4P7lADgQOcOVdu+s9KtZWWfRFcUmNK4XDDSjZ0dsxTH6y5qPbJlmMD0NZ+Q2rjF/t4OlTsRlvkdLxvJv+NsiyVsw2RFdUF8XL/5Ze7xjEF3kvdqtlK3KPkXm/df/o7WTSoHhWe5AVLH1cJKSe2AIBrIQISVy2GlQwH4l0laLopIl7vh93V9rkP4pAe2mUVqycHskq7tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsT4Mh8WyVOVGOXKOGyhAn5VXsrsf7uzVpRqehrtDJA=;
 b=VHBcvkM2rTr6l9/Sbc9oqgTuNXXcQY5un3bI7i/w802uLpoFfOrrisq2u1G3lpbiDqKogCkcgRx4o38edbuFn7HTZ2V0aOqXZQn/GCEbHZIoTWha2wFM5q0qrJSvrSIPh3bW/OxX/egezs23ie/hHhYZnSAnK4Jvvxp+nLvwQ7ItvfsXGun9NBEh0eM0C6VoB2Ru9j42SxYjmI5m1mBKh+0PGb825tBHcIbYDJtw8ramfQGHHOQCJYTMicHDwvrlCSTBLQ7dzjxoes5eAo6/KfFf4dPwVe/Z8nyiFephauPsNQK1PckDmYqjWfDNQrRmc0FG1RE0EE8CH13sNc43Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsT4Mh8WyVOVGOXKOGyhAn5VXsrsf7uzVpRqehrtDJA=;
 b=YV+VsVPilyYuJ91wc0JJ1fYZsYoyZU/K+TD9t/jWUuvLKFFtmfvRceoGw0dbQ1PRYWwko3z2z0sufQXT+y/lKsRLw25PWWAm6Bl/AuD5TsElw8S2wPEnfhiOVRqcmABW3CKe7o5vrpLLB0dfovFRkxxPAfB+5L+IFoFfau26B70=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 03:10:44 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:10:44 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality
Thread-Topic: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality
Thread-Index: AQHcHhQXNYN0CVd7RUWjCfmYuIVonbSKMiqQ
Date: Tue, 9 Sep 2025 03:10:44 +0000
Message-ID: <DM4PR12MB5152F37A6D4CFF75DF1EC461E30FA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
 <20250905032026.3256999-3-Jesse.Zhang@amd.com>
In-Reply-To: <20250905032026.3256999-3-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-09T03:09:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH0PR12MB8125:EE_
x-ms-office365-filtering-correlation-id: 2687e74a-6354-40c0-2fad-08ddef4e7743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zicXYx3CM+9Ma0NdOOVZtUMwf2Hj/iBm92PzaL1qFZeoQYHnrombu6/EyJdu?=
 =?us-ascii?Q?Ga96Ldw43R4iwZ9On2AVixLoYPPzs2KZmftnD4IocXE4JKbb9gKgs9XPKtph?=
 =?us-ascii?Q?R0mIOtyAKLHzco3qh35UED305N1iwgvop3hbc7Z2Oa+WsYklQvNrnlGa06WO?=
 =?us-ascii?Q?3mtbHu4K1n6VKS5oO43X13fehPhJB99OCMp3kZ21ZeJlq2XyMHx0g6pzuJx9?=
 =?us-ascii?Q?/2D+9UI92DqjsQRunH2TJ1Of/BgKa3hBRpt2ArajNfBU4FKaDTeO8NBr51aZ?=
 =?us-ascii?Q?rTjQx7oyhlVuq1DGLofr2Wf0MWt1f9LdM6kSwrS9wKNlUDVuS24ajZxkryrN?=
 =?us-ascii?Q?0rhuAWaLMBjfwdoXJB6CjeW3aPwA9eSOOjifV+7IBVToA/FAICQ7RfPi6qHJ?=
 =?us-ascii?Q?D/vFXnHF2CvdR29XVLq0x1zl5AiBKOCSSkVJwSxz9k849g/He8hQSKMUFEOy?=
 =?us-ascii?Q?a5CYy5Ebf93KXWO1vE62YrjJ/3q/zROrax3GYGHrGsrHZ5CvL6Y7qeeUii5W?=
 =?us-ascii?Q?p8SsWJoCO4NbYnkD2iHOrvJYz/L/+YARbymUyVBotIncYUcjVhsiDuSr35d+?=
 =?us-ascii?Q?KvEg2yw6dIGL1CCKZNwQ5z7r8NvN+MFAAMiQxWcoE3La7PEz9BCflewNkiP4?=
 =?us-ascii?Q?EEKzgW17bXYbSt06CkFmhR2wThXmPN9/zzoD+wi8xZYFFnA4SHMtfXmqYY6O?=
 =?us-ascii?Q?8ksS9nIkwzVt8e2luH+Iz6s7xQcgZyezSUL4ix0eBSjg8UmyBmmvsmvhqwB/?=
 =?us-ascii?Q?tvwqw52Wgy/L/+ulmkGCho7m0Y1oWvUSeYvL96NeBT/R49Gcfpd2keU8ALvE?=
 =?us-ascii?Q?Y2fWHYO3Fk1IHPVaqrNs3CmlCLgZwkSNnSMatChyaTc2ah95i66q4hid2nUA?=
 =?us-ascii?Q?YYtYRxslbBTyy4QFi2KICEajOYQIrBxsxh/5ZrQrQf7m4NPN066AZhv5xMFz?=
 =?us-ascii?Q?7Df93ohWZbX5O+u3jS1MfbEKSXS5q1UVojYCbzS5aR4OQALCeSAOpQ9tio5x?=
 =?us-ascii?Q?GmMg/FoasUfIqJAovu3kO9q1h2y54iwN/MqtN72UzH69iMQQFlTlUZ2bULo5?=
 =?us-ascii?Q?ogI4qhiyJ2dwssqm93ezMs2Hop0mUG7HefmmOGGkf+s9IWOXcQ6AEZXojpqe?=
 =?us-ascii?Q?Wm5UeXy9mWK8sqAMTeuM3E9DIsMwDokjZ2N2/kz+PM/9r5H34O99s1f56oiq?=
 =?us-ascii?Q?rgmTPnJPCcu8NJKa5RGzlvcydk9cEAlmrs+14u7dkWu7Lz0TbqwixlUWWKLO?=
 =?us-ascii?Q?dPh8udlx78bugeNP6Vf0NgpQJG29xUAO6xuo0YLzdF4bezL1ail2VJ7OMzK0?=
 =?us-ascii?Q?cuF24WT/Gg5FTeCn2d//40wiHkNK5J0mCuDvH/e/0LUZBUxG/T8M9Ci195xg?=
 =?us-ascii?Q?JV2m7Dvjq4ykSpOEZB8lmH4awSnX7wNdtPwbClquYvRgJ0HDU4oR9yKN44E8?=
 =?us-ascii?Q?5wkLcKYSOi+WPH4dRaF+NE2+IHvHfVTfiPp7isEW8jIG6g1QLYga1oKaTt3A?=
 =?us-ascii?Q?I16j0g+zo7hh27k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EEbTv3PIkSqIbtqJ09VMf791b1RLMM/uQoo3UcCsqA8MiwXwJx2H48osNl91?=
 =?us-ascii?Q?wrWCVeOCSWmfOMDz6pomLJoYx0HnwMXGf2smriQkNcD2Y7szQWS9q8emJWib?=
 =?us-ascii?Q?sH2B8XCVkECy5zc0eNaCtI+JQUDN+WYjdaVIwx8fLU9N7W1KxxMQxzUjE0ne?=
 =?us-ascii?Q?uJ2a3ocjiib2WG/dVJ8FUmRxxTxEnAUzMZ1Jj+lWvh8C5pjqolCnd/TAFNfI?=
 =?us-ascii?Q?Q5kku4gCC2kXGyABgImGrNOiS60Hkris7kKpLIz6BvlSaxnpjXnzSlQohKXn?=
 =?us-ascii?Q?3d/Lpxhn6T69wZeZkWKUXkvAMKwxRKSdNCy+J8V4gO9C6c8SOtyly6WKA6/b?=
 =?us-ascii?Q?1MwI42WVmALHQN88SByz3GY0DipCdrIojNz++ew8nBFx/sai5p8Um05A0ZxY?=
 =?us-ascii?Q?wC3dvU7bEXx0O2MNxjCgBvmV0Ra3yg7fA+8nna2L4PZ1d31ut5VUwKxbOD5c?=
 =?us-ascii?Q?BNOccWnO1fh7W4GdLhcxQ1BYrs9sWH5wKL+EshIP5mLiCoNEFcxMc63FMDFa?=
 =?us-ascii?Q?30LlQJJdzLs0r7b/uL8mNxu/BjTxlwUVjCsU/uDuhjfjhP2egF/3ABzpfHyz?=
 =?us-ascii?Q?CiMgym4/S1k0AjYy0+9qiE6GtMvO3+zwHXDm20dCRghlodBrVSXWJCZ+dyaH?=
 =?us-ascii?Q?QaS+baZ8HvCAkXyLd9+4AGJbOCjccVaw9beFH6jT0qA3dvTlPcc9aWdBxXP1?=
 =?us-ascii?Q?r7k3uc/AyJkTdqwmRXHlvSRisY+bNtMCvdxngEcwShloo9EubwrxUWmkHsLh?=
 =?us-ascii?Q?90KtH49b9mPh9Xy0nLB4HX11Yf9WAjDqw+LmMSfjtfVBr02y2o5GjKA63gRb?=
 =?us-ascii?Q?WJSuMzRVASzD7HId/yuhveCobARiUk1HHTnr3oIOTXMX88XQT2sx2f4tm7q0?=
 =?us-ascii?Q?ir/hutvHZoTp0GVv8GPSpXXxKwkjeZ1ndpShxPMSjERsNiBAH92X9RWtWpxp?=
 =?us-ascii?Q?YBGG6jso7Wa/UCqbM35X+R+nIYh2QRJorykgZc8iRUo1JdsO1ftTN43R6fZ3?=
 =?us-ascii?Q?mIZfbfMy3UIwAy0o8r3jzzOvZ35Dq0ZTX6MTcFqVkQi09chjBsMtWSN8VF8B?=
 =?us-ascii?Q?yVxBDRAGIrNfk+6u8ef676PXzdpAyiQ81CkB+cTPNWTLYiyDMDS4Us/eSD1A?=
 =?us-ascii?Q?rpl4whGunHHuNgpXZAaFSWcXj0JgjGOMOr1N9F9o5j8+qe4u2bK1UMJcEF2k?=
 =?us-ascii?Q?UlmOTI+e3pYpoSEpcIasbAIbkajDpgGG8HYE5FJexEME8vzlWrPNcHG8JOXb?=
 =?us-ascii?Q?brbNyf3IC1eQrcR1lA2iONc62DL+K8ZXJQ1X37Vh+r+geJMg1yPMuINkqlJl?=
 =?us-ascii?Q?4L288hKEqCfbfYoWm/FAolp+4xY+eeUFAEMuoSSxzb2h87e4zoZ8NOTmuy0X?=
 =?us-ascii?Q?L94+OCEoACOOzE1qwrPllywmjvwe3kUUXp8xBVbFQt2IBp2VFdUQgVCusgfs?=
 =?us-ascii?Q?WyDK6K2Z7iU+FH1HAtUMB19FmmTu3OsTWQxzaXskcKv/7fy/NhJ9Wowwc01Q?=
 =?us-ascii?Q?TcuLGCLNNfq5wQL7/Zzj6U4YExF07UEHSJXggiJJFDjBfiWt88og7ImYMoRe?=
 =?us-ascii?Q?FfCzD6UO9zdSzFbgTgI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2687e74a-6354-40c0-2fad-08ddef4e7743
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:10:44.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC/FKytXtM72gc46daRcVX67cv1oHQwbXmeMb7KH1xYFn931tXARfVezuGGwOmUwzdTg0nRmFse0t2gXCgdB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

Ping on series


-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Friday, September 5, 2025 11:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality

This patch adds robust reset handling for user queues (userq) to improve re=
covery from queue failures. The key components include:

1. Queue detection and reset logic:
   - amdgpu_userq_detect_and_reset_queues() identifies failed queues
   - Per-IP detect_and_reset callbacks for targeted recovery
   - Falls back to full GPU reset when needed

2. Reset infrastructure:
   - Adds userq_reset_work workqueue for async reset handling
   - Implements pre/post reset handlers for queue state management
   - Integrates with existing GPU reset framework

3. Error handling improvements:
   - Enhanced state tracking with HUNG state
   - Automatic reset triggering on critical failures
   - VRAM loss handling during recovery

4. Integration points:
   - Added to device init/reset paths
   - Called during queue destroy, suspend, and isolation events
   - Handles both individual queue and full GPU resets

The reset functionality works with both gfx/compute and sdma queues, provid=
ing better resilience against queue failures while minimizing disruption to=
 unaffected queues.

v2: add detection and reset calls when preemption/unmaped fails.
    add a per device userq counter for each user queue type.(Alex)
v3: make sure we hold the adev->userq_mutex when we call amdgpu_userq_detec=
t_and_reset_queues. (Alex)
   warn if the adev->userq_mutex is not held.
v4: make sure we have all of the uqm->userq_mutex held.
   warn if the uqm->userq_mutex is not held.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 219 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +
 5 files changed, 223 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 17848ce65d1f..707a1fb4a061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1310,6 +1310,7 @@ struct amdgpu_device {
        struct list_head                userq_mgr_list;
        struct mutex                    userq_mutex;
        bool                            userq_halt_for_enforce_isolation;
+       struct work_struct              userq_reset_work;
        struct amdgpu_uid *uid_info;

        /* KFD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index bdfb80377e6a..82f01c7a06ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        }

        INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);

        adev->gfx.gfx_off_req_count =3D 1;
        adev->gfx.gfx_off_residency =3D 0;
@@ -5951,6 +5952,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_r=
eset_context *reset_context)
                                if (r)
                                        goto out;

+                               r =3D amdgpu_userq_post_reset(tmp_adev, vra=
m_lost);
+                               if (r)
+                                       goto out;
+
                                drm_client_dev_resume(adev_to_drm(tmp_adev)=
, false);

                                /*
@@ -6173,6 +6178,7 @@ static inline void amdgpu_device_stop_pending_resets(=
struct amdgpu_device *adev)
        if (!amdgpu_sriov_vf(adev))
                cancel_work(&adev->reset_work);
 #endif
+       cancel_work(&adev->userq_reset_work);

        if (adev->kfd.dev)
                cancel_work(&adev->kfd.reset_work);
@@ -6293,6 +6299,8 @@ static void amdgpu_device_halt_activities(struct amdg=
pu_device *adev,
                    amdgpu_device_ip_need_full_reset(tmp_adev))
                        amdgpu_ras_suspend(tmp_adev);

+               amdgpu_userq_pre_reset(tmp_adev);
+
                for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                        struct amdgpu_ring *ring =3D tmp_adev->rings[i];

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..4471e4c388ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -107,7 +107,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct=
 *work)
        struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
        struct amdgpu_eviction_fence *ev_fence;

-       mutex_lock(&uq_mgr->userq_mutex);
        spin_lock(&evf_mgr->ev_fence_lock);
        ev_fence =3D evf_mgr->ev_fence;
        if (ev_fence)
@@ -118,13 +117,11 @@ amdgpu_eviction_fence_suspend_worker(struct work_stru=
ct *work)

        amdgpu_userq_evict(uq_mgr, ev_fence);

-       mutex_unlock(&uq_mgr->userq_mutex);
        dma_fence_put(&ev_fence->base);
        return;

 unlock:
        spin_unlock(&evf_mgr->ev_fence_lock);
-       mutex_unlock(&uq_mgr->userq_mutex);
 }

 static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f) di=
ff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_userq.c
index 7772de16f12b..566a26c05262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,8 +25,10 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>

 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +46,67 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_dev=
ice *adev)
        return userq_ip_mask;
 }

+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev) {
+       if (amdgpu_device_should_recover_gpu(adev)) {
+               amdgpu_reset_domain_schedule(adev->reset_domain,
+                                            &adev->userq_reset_work);
+               /* Wait for the reset job to complete */
+               flush_work(&adev->userq_reset_work);
+       }
+}
+
+static int
+amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr) {
+       struct amdgpu_device *adev =3D uq_mgr->adev;
+       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
+                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
+       const struct amdgpu_userq_funcs *userq_compute_funcs =3D
+                       adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
+       const struct amdgpu_userq_funcs *userq_sdma_funcs =3D
+                       adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
+       bool gpu_reset =3D false;
+       int r =3D 0;
+
+       /* warning if global mutex or process mutex is not held */
+       WARN_ON(!mutex_is_locked(&adev->userq_mutex) ||
+!mutex_is_locked(&uq_mgr->userq_mutex));
+
+       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+               dev_err(adev->dev, "userq reset disabled by debug mask\n");
+       } else if (amdgpu_gpu_recovery) {
+               if ((atomic_read(&uq_mgr->userq_compute_count) > 0) && user=
q_compute_funcs->detect_and_reset) {
+                       r =3D userq_compute_funcs->detect_and_reset(adev, A=
MDGPU_RING_TYPE_COMPUTE);
+                       if (r) {
+                               gpu_reset =3D true;
+                               goto gpu_reset;
+                       }
+               }
+
+               if ((atomic_read(&uq_mgr->userq_gfx_count) > 0) && userq_gf=
x_funcs->detect_and_reset) {
+                       r =3D userq_gfx_funcs->detect_and_reset(adev, AMDGP=
U_RING_TYPE_GFX);
+                       if (r) {
+                               gpu_reset =3D true;
+                               goto gpu_reset;
+                       }
+               }
+
+               if ((atomic_read(&uq_mgr->userq_sdma_count) > 0) && userq_s=
dma_funcs->detect_and_reset) {
+                       r =3D userq_sdma_funcs->detect_and_reset(adev, AMDG=
PU_RING_TYPE_SDMA);
+                       if (r) {
+                               gpu_reset =3D true;
+                               goto gpu_reset;
+                       }
+               }
+       }
+
+gpu_reset:
+       if (gpu_reset)
+               amdgpu_userq_gpu_reset(adev);
+
+       return r;
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
                          struct amdgpu_usermode_queue *queue) @@ -51,17 +1=
14,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
        struct amdgpu_device *adev =3D uq_mgr->adev;
        const struct amdgpu_userq_funcs *userq_funcs =3D
                adev->userq_funcs[queue->queue_type];
+       bool found_hung_queue =3D false;
        int r =3D 0;

        if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
                r =3D userq_funcs->preempt(uq_mgr, queue);
                if (r) {
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
+                       found_hung_queue =3D true;
                } else {
                        queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
                }
        }

+       if (found_hung_queue)
+               amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
        return r;
 }

@@ -93,16 +161,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_=
mgr,
        struct amdgpu_device *adev =3D uq_mgr->adev;
        const struct amdgpu_userq_funcs *userq_funcs =3D
                adev->userq_funcs[queue->queue_type];
+       bool found_hung_queue =3D false;
        int r =3D 0;

        if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
                (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
                r =3D userq_funcs->unmap(uq_mgr, queue);
-               if (r)
+               if (r) {
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
-               else
+                       found_hung_queue =3D true;
+               } else {
                        queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+               }
        }
+
+       if (found_hung_queue)
+               amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
        return r;
 }

@@ -113,16 +188,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
        struct amdgpu_device *adev =3D uq_mgr->adev;
        const struct amdgpu_userq_funcs *userq_funcs =3D
                adev->userq_funcs[queue->queue_type];
+       bool gpu_reset =3D false;
        int r =3D 0;

        if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
                r =3D userq_funcs->map(uq_mgr, queue);
                if (r) {
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
+                       gpu_reset =3D true;
                } else {
                        queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
                }
        }
+
+       if (gpu_reset)
+               amdgpu_userq_gpu_reset(adev);
+
        return r;
 }

@@ -346,12 +427,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
        int r =3D 0;

        cancel_delayed_work_sync(&uq_mgr->resume_work);
+       mutex_lock(&adev->userq_mutex);
        mutex_lock(&uq_mgr->userq_mutex);

        queue =3D amdgpu_userq_find(uq_mgr, queue_id);
        if (!queue) {
                drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id=
 to destroy\n");
                mutex_unlock(&uq_mgr->userq_mutex);
+               mutex_unlock(&adev->userq_mutex);
                return -EINVAL;
        }
        amdgpu_userq_wait_for_last_fence(uq_mgr, queue); @@ -361,6 +444,18 =
@@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
                amdgpu_bo_unreserve(queue->db_obj.obj);
        }
        amdgpu_bo_unref(&queue->db_obj.obj);
+       switch (queue->queue_type) {
+       case AMDGPU_RING_TYPE_GFX:
+               atomic_dec(&uq_mgr->userq_gfx_count);
+       break;
+       case AMDGPU_RING_TYPE_COMPUTE:
+               atomic_dec(&uq_mgr->userq_compute_count);
+       break;
+       case AMDGPU_RING_TYPE_SDMA:
+               atomic_dec(&uq_mgr->userq_sdma_count);
+       break;
+       }
+       amdgpu_userq_detect_and_reset_queues(uq_mgr);

 #if defined(CONFIG_DEBUG_FS)
        debugfs_remove_recursive(queue->debugfs_queue);
@@ -368,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_i=
d)
        r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
        amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
        mutex_unlock(&uq_mgr->userq_mutex);
+       mutex_unlock(&adev->userq_mutex);

        pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
        pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -576,6 +672,19 @@ amdgpu_userq_create(struct drm_file *filp, union drm_a=
mdgpu_userq *args)
        kfree(queue_name);

        args->out.queue_id =3D qid;
+       switch (queue->queue_type) {
+       case AMDGPU_RING_TYPE_GFX:
+               atomic_inc(&uq_mgr->userq_gfx_count);
+       break;
+       case AMDGPU_RING_TYPE_COMPUTE:
+               atomic_inc(&uq_mgr->userq_compute_count);
+       break;
+       case AMDGPU_RING_TYPE_SDMA:
+               atomic_inc(&uq_mgr->userq_sdma_count);
+       break;
+       default:
+       break;
+       }

 unlock:
        mutex_unlock(&uq_mgr->userq_mutex);
@@ -789,6 +898,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
        int queue_id;
        int ret =3D 0, r;

+       amdgpu_userq_detect_and_reset_queues(uq_mgr);
        /* Try to unmap all the queues in this process ctx */
        idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
                r =3D amdgpu_userq_preempt_helper(uq_mgr, queue); @@ -801,6=
 +911,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
        return ret;
 }

+void amdgpu_userq_reset_work(struct work_struct *work) {
+       struct amdgpu_device *adev =3D container_of(work, struct amdgpu_dev=
ice,
+                                                 userq_reset_work);
+       struct amdgpu_reset_context reset_context;
+
+       memset(&reset_context, 0, sizeof(reset_context));
+
+       reset_context.method =3D AMD_RESET_METHOD_NONE;
+       reset_context.reset_req_dev =3D adev;
+       reset_context.src =3D AMDGPU_RESET_SRC_USERQ;
+       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+       /*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+       amdgpu_device_gpu_recover(adev, NULL, &reset_context); }
+
 static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)  { @@ -827,3=
1 +954,33 @@ void  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
                   struct amdgpu_eviction_fence *ev_fence)  {
-       int ret;
        struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
        struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
+       struct amdgpu_device *adev =3D uq_mgr->adev;
+       int ret;

+       mutex_lock(&adev->userq_mutex);
+       mutex_lock(&uq_mgr->userq_mutex);
        /* Wait for any pending userqueue fence work to finish */
        ret =3D amdgpu_userq_wait_for_signal(uq_mgr);
-       if (ret) {
-               drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout=
 waiting for work\n");
-               return;
-       }
+       if (ret)
+               dev_err(adev->dev, "Not evicting userqueue, timeout waiting=
 for
+work\n");

        ret =3D amdgpu_userq_evict_all(uq_mgr);
-       if (ret) {
-               drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
-               return;
-       }
+       if (ret)
+               dev_err(adev->dev, "Failed to evict userqueue\n");

        /* Signal current eviction fence */
        amdgpu_eviction_fence_signal(evf_mgr, ev_fence);

        if (evf_mgr->fd_closing) {
                cancel_delayed_work_sync(&uq_mgr->resume_work);
+               mutex_unlock(&adev->userq_mutex);
+               mutex_unlock(&uq_mgr->userq_mutex);
                return;
        }
-
+       mutex_unlock(&adev->userq_mutex);
+       mutex_unlock(&uq_mgr->userq_mutex);
        /* Schedule a resume work */
        schedule_delayed_work(&uq_mgr->resume_work, 0);  } @@ -866,6 +995,9=
 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct dr=
m_file *f

        mutex_lock(&adev->userq_mutex);
        list_add(&userq_mgr->list, &adev->userq_mgr_list);
+       atomic_set(&userq_mgr->userq_gfx_count, 0);
+       atomic_set(&userq_mgr->userq_compute_count, 0);
+       atomic_set(&userq_mgr->userq_sdma_count, 0);
        mutex_unlock(&adev->userq_mutex);

        INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_wor=
ker); @@ -883,6 +1015,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_m=
gr *userq_mgr)

        mutex_lock(&adev->userq_mutex);
        mutex_lock(&userq_mgr->userq_mutex);
+       amdgpu_userq_detect_and_reset_queues(userq_mgr);
        idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
                amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
                amdgpu_userq_unmap_helper(userq_mgr, queue); @@ -916,6 +104=
9,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
        list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
                cancel_delayed_work_sync(&uqm->resume_work);
                mutex_lock(&uqm->userq_mutex);
+               amdgpu_userq_detect_and_reset_queues(uqm);
                idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
                        r =3D amdgpu_userq_unmap_helper(uqm, queue);
                        if (r)
@@ -972,13 +1106,15 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
        list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
                cancel_delayed_work_sync(&uqm->resume_work);
                mutex_lock(&uqm->userq_mutex);
+               amdgpu_userq_detect_and_reset_queues(uqm);
                idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
                        if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
                             (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
)) &&
                            (queue->xcp_id =3D=3D idx)) {
                                r =3D amdgpu_userq_preempt_helper(uqm, queu=
e);
-                               if (r)
+                               if (r) {
                                        ret =3D r;
+                               }
                        }
                }
                mutex_unlock(&uqm->userq_mutex);
@@ -1020,3 +1156,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
truct amdgpu_device *adev,
        mutex_unlock(&adev->userq_mutex);
        return ret;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev) {
+       const struct amdgpu_userq_funcs *userq_funcs;
+       struct amdgpu_usermode_queue *queue;
+       struct amdgpu_userq_mgr *uqm, *tmp;
+       int queue_id;
+
+       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+               cancel_delayed_work_sync(&uqm->resume_work);
+               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) =
{
+                               amdgpu_userq_wait_for_last_fence(uqm, queue=
);
+                               userq_funcs =3D adev->userq_funcs[queue->qu=
eue_type];
+                               userq_funcs->unmap(uqm, queue);
+                               /* just mark all queues as hung at this poi=
nt.
+                                * if unmap succeeds, we could map again
+                                * in amdgpu_userq_post_reset() if vram is =
not lost
+                                */
+                               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
+                               amdgpu_userq_fence_driver_force_completion(=
queue);
+                       }
+               }
+       }
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+       /* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+        * at this point, we should be able to map it again
+        * and continue if vram is not lost.
+        */
+       struct amdgpu_userq_mgr *uqm;
+       struct amdgpu_usermode_queue *queue;
+       const struct amdgpu_userq_funcs *userq_funcs;
+       int queue_id, r =3D 0;
+
+       list_for_each_entry(uqm, &adev->userq_mgr_list, list) {
+               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG && =
!vram_lost) {
+                               userq_funcs =3D adev->userq_funcs[queue->qu=
eue_type];
+
+                               r =3D userq_funcs->map(uqm, queue);  // Re-=
map queue
+                               if (r) {
+                                       dev_err(adev->dev, "Failed to remap=
 queue %d\n", queue_id);
+                                       continue;
+                               }
+                               queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
+                       }
+               }
+
+               /* Restart resume work after reset */
+               //queue_delayed_work(system_wq, &uqm->resume_work, msecs_to=
_jiffies(100));
+       }
+
+       return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h
index 1bd84f4cce78..391c510b025b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -94,6 +94,9 @@ struct amdgpu_userq_mgr {
        struct delayed_work             resume_work;
        struct list_head                list;
        struct drm_file                 *file;
+       atomic_t                        userq_gfx_count;
+       atomic_t                        userq_compute_count;
+       atomic_t                        userq_sdma_count;
 };

 struct amdgpu_db_info {
@@ -139,4 +142,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struc=
t amdgpu_device *adev,  int amdgpu_userq_start_sched_for_enforce_isolation(=
struct amdgpu_device *adev,
                                                   u32 idx);

+void amdgpu_userq_reset_work(struct work_struct *work);
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev); int
+amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 #endif
--
2.49.0

