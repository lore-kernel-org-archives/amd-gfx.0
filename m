Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF294C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E51910E6BB;
	Tue, 14 Jul 2026 13:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7p7/D5u";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7002E10E6BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4o+bPescHA80p1DbpDd14di4xkWQbTW0FrTriB01IgzEw4PlmCXNMjDY2nELGZWJoY8xoGkxeNaUcNHlhznTMmlZDgTlJzSQm8cvk4d2MKgUO8NXCfgiFbo48R+nnfZAUqiRCxeB9+Ey8zoLUge8UPgun0JIcNjVX2oD8Wf0BBR23+HjbfP3h2DG6wXGTDt4WsP2qnfItTawpCpj3yHkf+Pf8QwnLXIPlRzlyRcTdTBYp5/zxF+jnrnmdTqOB/zh5H2gbEjFP/AO8bYIsryDO0QFID6PhfCYba/odj52oVv4OSshXOfXNpm9yEOp2u6uFjTuE65rQk3U2/bUEmNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1isqV7+SXchcjhBCS5uc+FcigBheodzRIYdGz3ABII=;
 b=SQr3fRTR0CL9BcVGfUB/AmE8iVuntDyXwjzMmQNrRXVPF7vREVxGhP0PxwsbMmtVx37dT98Xl4WuXxKMqC/Kfg7PEUqAekxQtc6r48J5lyod6BWk/hirIXxKU+LcXD2fdTeeWEwidAv9Jg5xSBTkhNsewNGuWbKZv3Mf70zCq7DobHy9siID/2zO1Poce+0eT9XCoRVc1L3nJY4c32iA8bO45XFKV4qhEf6AoyHfJnZbreyO6dcPad/Ge+f3nZ9gClrBzB6JKQjdSG5TirKg2GTkmkxnA4GidyG3Aw0PTU0Hjat3wK4+RVH14UjzLXLtKLCZeC7LEyXwGh0meOOFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1isqV7+SXchcjhBCS5uc+FcigBheodzRIYdGz3ABII=;
 b=a7p7/D5uzt7elU8D39Nv7KOVSx3/mwa5GPgaN3mfYsD3RTrUFByUt+le3kLxluFzBcgFKat5T6JtOarLhdEe8FWwe38sf9t1EZbnGn+zMiz6gpk3FjBYRMm8fGcwRiL+l8+TDpF1yW94fkU9ICotRjyl/AdO55CpYyE7s23oKxw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 13:21:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 13:21:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Topic: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init
Thread-Index: AQHdE42tB7BuX7pEt06c7YEEiMQl57ZtABOw
Date: Tue, 14 Jul 2026 13:21:31 +0000
Message-ID: <BN9PR12MB525756EA24FB966923ECEEC4FCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260714123721.105472-1-xiang.liu@amd.com>
In-Reply-To: <20260714123721.105472-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:20:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7293:EE_
x-ms-office365-filtering-correlation-id: b90b00fc-1b1c-4d9f-c401-08dee1aad1be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|3023799007|18002099003|22082099003|56012099006|6133799003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info: NGP6+UpQuM6QhNEZuu9Kf1Lzh5snA6vAZAIqH4arBakPoTng37LfbGD4XTqr66Vn0/9Wr8PHdJfs/5bpv1neZ6/0qO5LiVveeDjur1I7v0e05Sl6UqisPwDNK/9FCQH51OtBgJotby0piZXHezRTo4hOQa+IeQ5LR8d0aESdOiFnOY0qTVpsmcdjs/e7DaPm3lUwhWm/UFSrMxHggUvpd6lc4fvThBpJ98QmnqbjIXb4sQy3lwcXXw7acxzsAHHxd+NgTnRX0XKARe2u2Rmd19VUkObjMPOdx4+qDRA+dz/OplDe23mWP/Haxh+MPrqsbEvg6+lDQ5yOLa9N55APYBZ9SunbLnWVZZ36wHsjynvEPItAiWE5emrfEleO8IaHRcYzcFoANB51bxoRet//JkUw+no4Kp5Qh0s7N8ITNO3Eev5HVDOLdd0fFRkVMirEL8xtfXok9hkXatNis/b33m4f8zetpd6Hq6bkuHI8SwOGdMD4s49AvzrcjaLcb6rbpy73XbFp45VUTGSLcc+oIIigRWN1K1RVS5t6n3zSN/ZGiTn6lq3F/psdiFt/IjZOjRSotPPD/IiLd2l0SrIsFTjBmrUqkZTll7qNXcwpSxDjKONHL7FKFQbXL3QhfgDrq810HPCD81ekL8YYaMuyUlJ2VW3jQKQtzbUxnb9hzxaujcO4EBeOumBVR5A0X2kr/jsazhubzjxwCSdjcyof2AX/RDdRucwbicmH0x/wr7Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/sPYWSs4PzCCHhsHSah3eviIIwGt8xc0lY1sRMw3ux6E4tVneXsESNiGLW8?=
 =?us-ascii?Q?zR2Q/ag7T9H0TWQFWwZwNOFslihDC5YyJQf13daeS7B5PV9jSoIr2glORHLY?=
 =?us-ascii?Q?J6hMXh0i0tK+k9SBvPV/NGdesKDqyerIBkHTmmM0iSmg0SNdXRetXU9+dqYm?=
 =?us-ascii?Q?zPC5lJ4DHvaoXneLsJjj2tr31wY3mSKtLjkowT57WDC1qRG1ctLWwqwatM9e?=
 =?us-ascii?Q?L2xrKvKGLQk5gB/iA6oqOLUHMy7h9bTIiv9POyxDk9rkWWwThfZCumupa6ud?=
 =?us-ascii?Q?s6za+s5zPufBiGwwddtekSPEBe5vfv+36ouZwDRPMzjRMKD+R8a/Q7ZHFX9a?=
 =?us-ascii?Q?wt5z2HgpE/yYm0EuWbVftlQmMVr46NMxK/M9sfJShDl1KYlJVjxXxQyLEKxt?=
 =?us-ascii?Q?KRVO9Ls21kZnZYG/451kquRiEW93A8E5NY8JwCpaBjtYuxUfO7voCu5psEZf?=
 =?us-ascii?Q?Htgpz8lL+Pq2ckIR2QJoArg6whDnT/WjvHtdQXAzojskVDDVE+dnGPxa48Nt?=
 =?us-ascii?Q?fHSQ3wfayQoTMWF1FPmrng6HhPdQsgrnd5dvGjgy9/nZZvFDU+hCmIG7XXrJ?=
 =?us-ascii?Q?gooXlxVOGhW/t6VkXgKch0WkDX5j6XGENaR0eiFWFbBnLFw4jYkqZpA6ZV0c?=
 =?us-ascii?Q?T5Th7AnJiTzzJtZQ6oiWq3MNa5WjUY4XDulyzW6wUm6a6ggAminNw6zVZQ9c?=
 =?us-ascii?Q?1Mg5asF1jaHg17xQnB4BQcoWNhJFFJYwW/BXC8lVB4SYWWBx3E4yKQB1rYZ6?=
 =?us-ascii?Q?xJeLwiY34kLls9X4IlQqFACufvfSP2d0hQHC5OFqwfK2h7p/JOtQOI4M1qUh?=
 =?us-ascii?Q?SJC2YqFCt7nBL+44lN0zeeJbriosbA7PUCdkqhURmKsRuzocbXiXsmuY1waq?=
 =?us-ascii?Q?68Xh1uHY6De/GkTV+iaiQR+4Op3kBO3zqdoOhVp5p3HHap8hhPsjLg30+7Jh?=
 =?us-ascii?Q?Mmvow9722G7afxmZ6uCHM8BM41085tV0wpPF3xWFM7a2Z4BGaVXOSgAnhlIh?=
 =?us-ascii?Q?DCgQxZiofNOroHETzKhhOBta3w0bGbHYEd/KXV5K9nBjSltxSVGqvriZ1P8v?=
 =?us-ascii?Q?uZlB9yfM8i4wFMsvHly1N63rkU3NcjXSmjzS4zA2awYhbsIpL4XfQeptSdw+?=
 =?us-ascii?Q?xpC3lh2mHFxrm2tIK6N6Y0nO4ZM+mSYklQ6Y7Zf8AWbU3oAtbhTYnL282798?=
 =?us-ascii?Q?cY3qvDHT6wzv6SpBLx0c6n4BeB90IW6W7+23h+ejZ9zqK+W8fV9AxhceA66g?=
 =?us-ascii?Q?+tzi0fpZeBwjkIrynaKF+owvjEIC5UZFiDRJIo5tap9YlPwWrQq3EtY6Atvx?=
 =?us-ascii?Q?fK7HrUnBt9SHvK7u4eYPqPp4bC2MQp00M6PIpBtqW8qdXVJM/tGT7hCDitof?=
 =?us-ascii?Q?Vwboj03A7fhhqAsvQwECh60oQMj9tvgbUY0BpBoQAvRmNlI+ozox86w9lXOD?=
 =?us-ascii?Q?6JXdOaaWNARG81Letb/o2HvkM1ChrsyUaQa5pmQLSgZ+CLA0/9t1x1/JyQLB?=
 =?us-ascii?Q?ojUe1udvjRpw4W05mgT9/fJCKunjY2PqYRRb2zxQmfV8IDGDTJWFS/cZTIJ8?=
 =?us-ascii?Q?IQp1lwvpnFl6wfl8iV1+InpC1veaajtG4eXzh/+5UxrQ22dUZKuBjYH7AAhx?=
 =?us-ascii?Q?GhAr3Wna+czSMLeWbmwYu0HNi/pFhRSckkNgC1eKPMLGrYuyQIOWYB/Ros8E?=
 =?us-ascii?Q?KalJx37DRvBrhSmqCYl3SOLgRpP/tdNipzgO3/Nkq9PBp7kx?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525756EA24FB966923ECEEC4FCF92BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b00fc-1b1c-4d9f-c401-08dee1aad1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 13:21:31.2596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/F5H7tta9j5Q/0388O25aJfq7FDMmiWwFlJWwbILB83Zto8tqOJ6os8XKUFL4npPkG+VhAID8SqLbqu7eMfuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

--_000_BN9PR12MB525756EA24FB966923ECEEC4FCF92BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


+#if defined(CONFIG_DEBUG_FS)
+       if (adev_to_drm(adev)->primary->debugfs_root)
+               amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf);
+ #endif

Feel free to remove the #if defined protection when committing the change, =
since it is already handled within amdgpu_debugfs_ring_init.

With above fixed, the change is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang Li=
u
Sent: Tuesday, July 14, 2026 8:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init

The XGMI reset-on-init path can run while the device is still at the minima=
l init level, such as during an NPS memory partition switch. In that flow t=
he normal RAS IP block hw_init is skipped, so unified RAS is not enabled wh=
en the early CPER initialization is attempted, leaving CPER disabled for th=
e rest of the device's lifetime.

Resume RAS after the XGMI reset-on-init completes. Once the RAS manager res=
ume succeeds, the RAS resume wrapper performs deferred CPER initialization,=
 keeping the path a no-op for devices where CPER was already initialized.

Keep the deferred CPER retry and its debugfs registration together in the C=
PER helper. The normal debugfs ring walk skips the CPER ring until CPER is =
enabled, so the ring debugfs entry is created either by the deferred helper=
 when debugfs is already available or by the normal debugfs walk.

Signed-off-by: Xiang Liu <xiang.liu@amd.com<mailto:xiang.liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c    | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c    |  5 ++++-
 6 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 6fb129025761..0af8b7be326e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
        return 0;
 }

+int amdgpu_cper_deferred_init(struct amdgpu_device *adev) {
+       int r;
+
+       if (adev->cper.enabled)
+               return 0;
+
+       r =3D amdgpu_cper_init(adev);
+       if (r || !adev->cper.enabled)
+               return r;
+
+#if defined(CONFIG_DEBUG_FS)
+       if (adev_to_drm(adev)->primary->debugfs_root)
+               amdgpu_debugfs_ring_init(adev, &adev->cper.ring_buf); #endi=
f
+
+       return 0;
+}
+
 int amdgpu_cper_fini(struct amdgpu_device *adev)  {
        if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.h
index d12c98077d9d..eea30be91b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgp=
u_device *adev);  void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
                        void *src, int count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
+int amdgpu_cper_deferred_init(struct amdgpu_device *adev);
 int amdgpu_cper_fini(struct amdgpu_device *adev);

 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 3d1ede5f8de2..fd349eed820f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

                if (!ring)
                        continue;
+               if (ring =3D=3D &adev->cper.ring_buf && !adev->cper.enabled=
)
+                       continue;

                amdgpu_debugfs_ring_init(adev, ring);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 0eb440e4ca1a..8bf3fd015a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5002,7 +5002,13 @@ void amdgpu_ras_post_reset(struct amdgpu_device *ade=
v,
        }
 }

-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
 {
-       amdgpu_ras_mgr_resume_after_reset(adev);
+       int r;
+
+       r =3D amdgpu_ras_mgr_resume_after_reset(adev);
+       if (r)
+               return r;
+
+       return amdgpu_cper_deferred_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 23bff7a0f35b..c53f911d5729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -980,5 +980,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
                                          struct list_head *device_list);
 void amdgpu_ras_post_reset(struct amdgpu_device *adev,
                                          struct list_head *device_list);
-void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
+int amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index b265b68e0f37..87cefa1e22bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1399,7 +1399,10 @@ static void amdgpu_xgmi_reset_on_init_work(struct wo=
rk_struct *work)
                 * no-op for any other reset path where RAS is already
                 * initialized, and for non-uniras devices.
                 */
-               amdgpu_ras_resume_after_reset(tmp_adev);
+               r =3D amdgpu_ras_resume_after_reset(tmp_adev);
+               if (r)
+                       dev_err(tmp_adev->dev,
+                               "failed to resume RAS after XGMI reset-on-i=
nit\n");
        }
 }

--
2.34.1


--_000_BN9PR12MB525756EA24FB966923ECEEC4FCF92BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#if=
 defined(CONFIG_DEBUG_FS)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev_to_drm(adev)-&gt;primary-&gt;deb=
ugfs_root)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_debugfs_ring_init(adev, &amp;adev-&gt;cper.ring_buf); </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ #e=
ndif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Feel=
 free to remove the #if defined protection when committing the change, sinc=
e it is already handled within amdgpu_debugfs_ring_init.</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">With=
 above fixed, the change is</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Xi=
ang Liu<br>

Sent: Tuesday, July 14, 2026 8:37 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Liu, Xiang(=
Dean) &lt;Xiang.Liu@amd.com&gt;<br>

Subject: [PATCH v3] drm/amd/ras: initialize CPER after XGMI reset on init</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
XGMI reset-on-init path can run while the device is still at the minimal in=
it level, such as during an NPS memory partition switch. In that flow the n=
ormal RAS IP block hw_init is skipped,
so unified RAS is not enabled when the early CPER initialization is attempt=
ed, leaving CPER disabled for the rest of the device's lifetime.</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Resu=
me RAS after the XGMI reset-on-init completes. Once the RAS manager resume =
succeeds, the RAS resume wrapper performs deferred CPER initialization, kee=
ping the path a no-op for devices where
CPER was already initialized.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Keep=
 the deferred CPER retry and its debugfs registration together in the CPER =
helper. The normal debugfs ring walk skips the CPER ring until CPER is enab=
led, so the ring debugfs entry is created
either by the deferred helper when debugfs is already available or by the n=
ormal debugfs walk.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Xiang Liu &lt;<a href=3D"mailto:xiang.liu@amd.com">xiang.liu@amd=
.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_cper.c&nbsp;&nbsp;&nbsp; | 19 ++++++++++++++=
+++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_cper.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |&nbsp; 2 ++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp; | 10 ++++++++-=
-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++++-</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 6 f=
iles changed, 35 insertions(+), 4 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6fb129025761..0af8b7be326e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
498,6 +498,25 @@ int amdgpu_cper_init(struct amdgpu_device *adev)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_cper_deferred_init(struct amdgpu_device *adev) {</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cper.enabled)</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cper_init(adev);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r || !adev-&gt;cper.enabled)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#if=
 defined(CONFIG_DEBUG_FS)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev_to_drm(adev)-&gt;primary-&gt;deb=
ugfs_root)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_debugfs_ring_init(adev, &amp;adev-&gt;cper.ring_buf); #endif<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_cper_fini(struct amdgpu_device *adev)&nbsp; {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x d12c98077d9d..eea30be91b47 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
92,6 +92,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_de=
vice *adev);&nbsp; void amdgpu_cper_ring_write(struct amdgpu_ring *ring,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *src=
, int count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_cper_init(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_cper_deferred_init(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_cper_fini(struct amdgpu_device *adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 3d1ede5f8de2..fd349eed820f 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2184,6 +2184,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!ring)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (ring =3D=3D &amp;adev-&gt;cper.ring_buf &amp;&amp; !adev-&gt;cpe=
r.enabled)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_debugfs_ring_init(adev, ring);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 0eb440e4ca1a..8bf3fd015a45 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
5002,7 +5002,13 @@ void amdgpu_ras_post_reset(struct amdgpu_device *adev,</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_mgr_resume_after_reset(adev);<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_mgr_resume_after_reset(a=
dev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return r;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_cper_deferred_init(adev);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 23bff7a0f35b..c53f911d5729 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
980,5 +980,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> voi=
d amdgpu_ras_post_reset(struct amdgpu_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; struct list_head *device_list);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-voi=
d amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amd=
gpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x b265b68e0f37..87cefa1e22bd 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1399,7 +1399,10 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_s=
truct *work)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * no-op for any other reset path where RAS is alrea=
dy</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * initialized, and for non-uniras devices.</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_ras_resume_after_reset(tmp_adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; r =3D amdgpu_ras_resume_after_reset(tmp_adev);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(tmp_adev-&gt=
;dev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed to resume RAS after XGMI reset-on-=
init\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB525756EA24FB966923ECEEC4FCF92BN9PR12MB5257namp_--
