Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27136C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 12:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C3A10E51B;
	Mon, 25 Mar 2024 12:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FiWYCEko";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5295710E51B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 12:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0tsIuaQbsuI1/fZc/82H+RVdqUI6uKtgtiH+nnfVo2p8sXNGGaPzVQoSVlQyXRFJ1FM12HILOjEw3WkXa//5jr24PuB93OYnoY8Y+/KQWgyiDerVbYnkfkol5M/qt4r5zxgq9l3PIKH29vlSyUTYOpERgoNlGBFMrBl+31D8G5nIOLcevjVB1ZKu87MPxjaxQ716yHBZKz/peQfsJD3ynDbdnsmJyo0nnTJ8MfhZqmZRUnrv7hTEnuq44aeibqee9l6BGY0nwRahZi5yOWNtLYVDQ73/y6RVrkt0hFfK+bXpsDAdExAcaRX7Ndc96OW8xPML/thdk+HQAXtMpJCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQVquMWC9Ct+aSN4eBOv9P4BWe5hWhnDiAf4GPizzSc=;
 b=DeoK+HZ5XrrbYxOZ2cry0T8CNismHayzE9+4gMxw4TWzwgE3m7S7eCIvMi1CF8wZfCmBYRAp2EprMpv/amFNsMUwIw3rO9qMBHK7hQ0+rcm0Be+6ZH1bSKK3eln5L75XJh/JdyKdJ++hbF2orOSprtGW5bhu6vYdrhhTToyXuaQDiDP7WKbo43hCmCvNcZPx7YstVPvewJK1NleklFoLx5lVTX+31WeF7v9viy3eb2Fg5kNYy7AQIP68ymlwZ5crDZ6i25rEykpR1d7gyL+U3lntGvnNunnVAhcOkvel9UrI7CClyhPXaOU8+GZ75ESRQPOXEYO8Ld8mJ8L7e1iFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQVquMWC9Ct+aSN4eBOv9P4BWe5hWhnDiAf4GPizzSc=;
 b=FiWYCEkoOqibiHi6RIQK2MG7tp222J27BpiAbUoohdbQ0ccJpWtqmSi4FFYIFOEKjZ22FjpBZKxYG6rkTfNEUtHaw8TgliwzV87HNljCXvwwiGcHJuxbrSurBH6pvvo4EBZHcGX+MFu3xTQFwS/Ibu7LK+bLnCGc/dDVY5he5cw=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 12:51:18 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:51:18 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature
Thread-Topic: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log
 feature
Thread-Index: AQHafILXmpsmjScwgkGdOTCvpp8pJ7FIbTFY
Date: Mon, 25 Mar 2024 12:51:17 +0000
Message-ID: <CH0PR12MB53727B34030F966B79075C51F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240322180021.391680-1-shaoyun.liu@amd.com>
In-Reply-To: <20240322180021.391680-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T12:51:09.0581670Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM4PR12MB6421:EE_
x-ms-office365-filtering-correlation-id: 55e3dcd6-e71b-4e51-1167-08dc4cca4379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uN8ExViFkoCtK54RZlDrrJ+3flg8MrJUaQZMnyquk5zVG8zCFx/TV956VLCyR6Njp9W1vEkezvpHv7921VDJ7jyOUbJqoO1LodB3+NjIVKlNWFgcJuVcmeU/es+x1pQlpQjFYhfoJ5SKgHBn2K2d4/l5NxFWdtazKID3mFybvuzEJvqDJFSVksXXJFkPV36RxKFxAH77Mw/HYzvCNjr/SgXfQMrjMc8rahYZeUvCE7t1cxcmslQJqT+3xt0ePlMo9MZX6qIcnFL6f0B2iDQ6ASyyE4gUNGpn3J2S1YC7/crMFOuEnXn9qPLuuULnWM1FGQC16M0zDRUuTBal9XU51ek4CqIc5abVvw2KBcUcdQZJ1LGVBQQt11xRpZte1TE3FKEig3MiWkkpxfpOE7cuXRPNYwObszPAp4CYoGL+MJHUvVWd37BN2mh6obkZRCRzwOPIAwKFDAjAfAV4d4Mmle4AYxwqlm7iyDW4vHokH4hAHk+xplXoC0ai2h0Vtyw4nhJKTWtIdgobBEAVXZhDXQ9DS0rsEgpldWFxMlZ5Qpv5uxEvk/ryA8tkG9j/DV29rWfHpH1CSxPlo9GQSc7g6LB/TJStatetRzOrg5Hy8ASMVBIavbpQFyvYgqauINOXLvG14ZMxCSYLK1shOevp7cVz6xBLoZs26xXuuSFOsPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3JamCnVTGZGWhxw1zx03w4NkgNdKvZNiMYADj+vScLiJDBLO4jw0cGlqjYEE?=
 =?us-ascii?Q?hMBleX8NAiYJz+FS+CYMzzkTkYDxqq+KK30t1AaMn4Zh40qw/5TKRG0ojFsA?=
 =?us-ascii?Q?OVwHYTl2A64KqKQovZVu3onB7dTCaWl14SbmWZ/Qmoinr+gI0gWXyQXZhPiN?=
 =?us-ascii?Q?gMlg1IvdH45f9BytCijYFrepC9y3by8sNyEN6Wu8uCHFfbEnpK3QWsd81Jbk?=
 =?us-ascii?Q?UYM+BGSXmSNRGTFOa/kDnkkN+1j9WRT5DLvOcexDac9atE3EKwajPDLw77U1?=
 =?us-ascii?Q?1ng2D+vsTTq/7th6DEBoyx23SrGyl6FzP1sWShKZcJTX9v2QGIPOWo6nHTpK?=
 =?us-ascii?Q?7b+k2wzA3ha0NTwbbi1HWIZL/Gi1VOX68N9XZr24IFvwqb206jjvc8UMj704?=
 =?us-ascii?Q?JJpO+q7KWZnvVbBZAO4rgstdG+5LFekEPXISf4LA8mLF6hlZ3K1Zj8Uz/eC1?=
 =?us-ascii?Q?cFGbSeTRBU8vCPALhEq3oCO9B/wuXVUtXfBb00srwxpX4b2Bo33M65GvidS2?=
 =?us-ascii?Q?b/eCamcPqFRz/FCgZakTNQ0fFFwq3QtNZY3Ts8iYOf+p7gHPxIYyU2g7wkNh?=
 =?us-ascii?Q?pPv/wJvqyhN7ncIYJu0Bp2CHIyS+T5RipTH4/Z4w9dlSMup3eJFEA8JxI9B1?=
 =?us-ascii?Q?EklGrUpIYTLeHOLH4bZvvCMu0K3fTSx6g8ZXA22d8/kuRiCOiGgvJoHPt0Cb?=
 =?us-ascii?Q?Oa6IzIjzXpRwo0g5SaFCB8eZ3wIsSn0mdj1Cih0huM3AQ6fJY9pu1O5mRUP9?=
 =?us-ascii?Q?0nINrhCfrQb3ZpSq30Y/8orwbWALiv/2AYNwhfFwo3BZ42N6lt1v17rLJSQl?=
 =?us-ascii?Q?xx6bpQJ3KpNZ3PyArBiYL0+qhZWDBab6/DiAMB7eR134Opu24RzRxHo1Er5I?=
 =?us-ascii?Q?V1uIGwN1qh0X3xbhgFKe8+1x59b2ZcM+8bDiKL402xWZiXHky9urvG/j2V/y?=
 =?us-ascii?Q?Cu93NVR8J6QP4cQnxiZai8prT3Z99bWzA3BYRZZhqmZzXhxFhxtxx9INNAP5?=
 =?us-ascii?Q?Fa7MZnBp0BXsvURhNLV5I/4HDt/8r4Iq2pHFFw4v6wqHYQNgE0b33EXgzpcd?=
 =?us-ascii?Q?/2IwvC/wuUQYWVnZKmdbvKA3xOoMzGxczXWdESlx5aRKsNho9kM3J8GXVWZs?=
 =?us-ascii?Q?ib8NaDV5veyqbw8kQlaSAJAxuVdGPbX7zxJ6hC51HSyI8tH7+3gh8e6JrjY0?=
 =?us-ascii?Q?aSa/SMXNRRcqLJJT0aPAMVYj2v4s6zJ7jtB7GF8CoUdddK6/71W554ZCbo3z?=
 =?us-ascii?Q?emjXm18kNKrhcX+R/pSIyp/8zd4lAlaCRvXr0WMokARduQHTRA/4RdKkjFB2?=
 =?us-ascii?Q?ZBFKxb1jaOHr1fCqYmuWTdfyMYvn1ZidLTe5VUWLhmvw+SF/4qyhQHfsZpRa?=
 =?us-ascii?Q?YMvwSskgvtA0d6sz/7NXEvIEbXpfl2boVgaekgFtahxzLnjtLMTil3Ecxu8D?=
 =?us-ascii?Q?YuzQT6KeujdMsTaGRk6JI0u76yn4GVJRbGCbfF//Kb31DoPzXqS1WKHKHg71?=
 =?us-ascii?Q?hKpOUMaexzaT5JnX0+tAaCSeLiL3S2mjwbGyDfd5rDQ+2RplCoiQmJPUK8n5?=
 =?us-ascii?Q?24nXgyMnpQfsv97Edqp5N9kll2mYS+PFzCo7jDwG2G4nE9rwWXstLmk7i9eG?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53727B34030F966B79075C51F4362CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e3dcd6-e71b-4e51-1167-08dc4cca4379
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:51:17.8700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ckB3QBbEXZrSHKgqpfw/Fgp5IBloglsz3K49jQm/2QSB6IseAslsLGiBXggBVLYa2BnKp3mUh/neT7gLp0KiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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

--_000_CH0PR12MB53727B34030F966B79075C51F4362CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Ping

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, March 22, 2024 2:00:21 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature

The MES log might slow down the performance for extra step of log the data,
disable it by default and introduce a parameter can enable it when necessar=
y

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  7 +++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9c62552bec34..b3b84647207e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -210,6 +210,7 @@ extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
+extern int amdgpu_mes_log_enable;
 extern int amdgpu_mes_kiq;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 80b9642f2bc4..e4277298cf1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -195,6 +195,7 @@ int amdgpu_async_gfx_ring =3D 1;
 int amdgpu_mcbp =3D -1;
 int amdgpu_discovery =3D -1;
 int amdgpu_mes;
+int amdgpu_mes_log_enable =3D 0;
 int amdgpu_mes_kiq;
 int amdgpu_noretry =3D -1;
 int amdgpu_force_asic_type =3D -1;
@@ -667,6 +668,15 @@ MODULE_PARM_DESC(mes,
         "Enable Micro Engine Scheduler (0 =3D disabled (default), 1 =3D en=
abled)");
 module_param_named(mes, amdgpu_mes, int, 0444);

+/**
+ * DOC: mes_log_enable (int)
+ * Enable Micro Engine Scheduler log. This is used to enable/disable MES i=
nternal log.
+ * (0 =3D disabled (default), 1 =3D enabled)
+ */
+MODULE_PARM_DESC(mes_log_enable,
+       "Enable Micro Engine Scheduler log (0 =3D disabled (default), 1 =3D=
 enabled)");
+module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
+
 /**
  * DOC: mes_kiq (int)
  * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 78dfd027dc99..9ace848e174c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -100,6 +100,9 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)
 {
         int r;

+       if (!amdgpu_mes_log_enable)
+               return 0;
+
         r =3D amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
                                     AMDGPU_GEM_DOMAIN_GTT,
                                     &adev->mes.event_log_gpu_obj,
@@ -1561,7 +1564,7 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_=
device *adev)
 #if defined(CONFIG_DEBUG_FS)
         struct drm_minor *minor =3D adev_to_drm(adev)->primary;
         struct dentry *root =3D minor->debugfs_root;
-       if (adev->enable_mes)
+       if (adev->enable_mes && amdgpu_mes_log_enable)
                 debugfs_create_file("amdgpu_mes_event_log", 0444, root,
                                     adev, &amdgpu_debugfs_mes_event_log_fo=
ps);

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 072c478665ad..63f281a9984d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -411,8 +411,11 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_me=
s *mes)
         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
-       mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
-       mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes->event_log=
_gpu_addr;
+       if (amdgpu_mes_log_enable) {
+               mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
+               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
+                                       mes->event_log_gpu_addr;
+       }

         return mes_v11_0_submit_pkt_and_poll_completion(mes,
                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
--
2.34.1


--_000_CH0PR12MB53727B34030F966B79075C51F4362CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">Ping</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu@amd.com&gt;<br>
<b>Sent:</b> Friday, March 22, 2024 2:00:21 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu : Add mes_log_enable to control mes log =
feature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The MES log might slow down the performance for ex=
tra step of log the data,<br>
disable it by default and introduce a parameter can enable it when necessar=
y<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1=
 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |&nbsp; 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; |&nbsp; 7 +++++--<br>
&nbsp;4 files changed, 20 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 9c62552bec34..b3b84647207e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -210,6 +210,7 @@ extern int amdgpu_async_gfx_ring;<br>
&nbsp;extern int amdgpu_mcbp;<br>
&nbsp;extern int amdgpu_discovery;<br>
&nbsp;extern int amdgpu_mes;<br>
+extern int amdgpu_mes_log_enable;<br>
&nbsp;extern int amdgpu_mes_kiq;<br>
&nbsp;extern int amdgpu_noretry;<br>
&nbsp;extern int amdgpu_force_asic_type;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 80b9642f2bc4..e4277298cf1a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -195,6 +195,7 @@ int amdgpu_async_gfx_ring =3D 1;<br>
&nbsp;int amdgpu_mcbp =3D -1;<br>
&nbsp;int amdgpu_discovery =3D -1;<br>
&nbsp;int amdgpu_mes;<br>
+int amdgpu_mes_log_enable =3D 0;<br>
&nbsp;int amdgpu_mes_kiq;<br>
&nbsp;int amdgpu_noretry =3D -1;<br>
&nbsp;int amdgpu_force_asic_type =3D -1;<br>
@@ -667,6 +668,15 @@ MODULE_PARM_DESC(mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Enable Micro Engine =
Scheduler (0 =3D disabled (default), 1 =3D enabled)&quot;);<br>
&nbsp;module_param_named(mes, amdgpu_mes, int, 0444);<br>
&nbsp;<br>
+/**<br>
+ * DOC: mes_log_enable (int)<br>
+ * Enable Micro Engine Scheduler log. This is used to enable/disable MES i=
nternal log.<br>
+ * (0 =3D disabled (default), 1 =3D enabled)<br>
+ */<br>
+MODULE_PARM_DESC(mes_log_enable,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Enable Micro Engine Scheduler l=
og (0 =3D disabled (default), 1 =3D enabled)&quot;);<br>
+module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);<br>
+<br>
&nbsp;/**<br>
&nbsp; * DOC: mes_kiq (int)<br>
&nbsp; * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for k=
iq.<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 78dfd027dc99..9ace848e174c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -100,6 +100,9 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_mes_log_enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_ker=
nel(adev, PAGE_SIZE, PAGE_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_G=
EM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ade=
v-&gt;mes.event_log_gpu_obj,<br>
@@ -1561,7 +1564,7 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_=
device *adev)<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_minor *minor =
=3D adev_to_drm(adev)-&gt;primary;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *root =3D mi=
nor-&gt;debugfs_root;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_mes &amp;&amp; am=
dgpu_mes_log_enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;amdgpu_mes_event_log&quot;,=
 0444, root,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &a=
mp;amdgpu_debugfs_mes_event_log_fops);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 072c478665ad..63f281a9984d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -411,8 +411,11 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_me=
s *mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_=
reg_active_poll =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_=
level_process_quantum_check =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.oversub=
scription_timer =3D 50;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_mes_event_i=
nt_logging =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.event_intr_history=
_gpu_mc_ptr =3D mes-&gt;event_log_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_mes_log_enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mes-&gt;event_log_gpu_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mes_v11_0_submit_pk=
t_and_poll_completion(mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB53727B34030F966B79075C51F4362CH0PR12MB5372namp_--
