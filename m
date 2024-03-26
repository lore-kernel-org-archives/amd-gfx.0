Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379B9C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 15:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C4910F08B;
	Tue, 26 Mar 2024 15:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RyByT30";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698AC10EC6D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 15:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHfOHHdSrE+KkDL4jhzud2Dhgx/HPz22Mh18XN0udumufgtCbR5bb3aqA3mnHN2fyIZag+Pl/rw2z0h1S8vDNfuePoMGOd6Sn1f9N2wXcFi6Ea2MUt6Wh3yW1bcNz6BRaRbw1redkVvfzXY5ber5PqinIO0TC2KZgXG63rmteluP7fVoUf6CFgjITNmX5twEBCXnpNzew2xcIPhbv08z3USTnHsBCCwdIx6TAWYlZvmpxr44H9r20H5csw9AGmA9UYD6aJn67Jo+n5rJjLSUsb1cBprtbB6mSZJqogb5hyCj1pwOvP7BzvXUCF2OIotq84zJNLt8VFCmdu4N8jRTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bq4rMZDXsDod9nw/NzIj2vEkLqMqGSfVrQBHWTLELqM=;
 b=DLuuE5MrSqU+apLrnXMnwwPG1Dj+1bZNkpT34rN6LTttI6izLegC9RC0T5N5ShESTXn0RbqmZpMvnFuyfTaerK5W1nTLR06Mp0CJWZPQYOINveNsChRpY6edlfOXG6bA++hhY5neikHvuFmtWasmeKuWqRcaeXfDjIHTd/gO6ga1OEJ6x5rNPcr/YPW+qC0CCPTONf5mLzQSlumY9VTPSlT0kBbFPJWzQJVXbaXNzddkJ4CP4ZFk13Pszgd6cji5I/3Osjnp61u+VSuL1vUTX6H7TBmJJc0LNfjRgGycmejsjxA1GXsZqjAZVbNWI4IYrP3PfHRDOTyHI6UFRowUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq4rMZDXsDod9nw/NzIj2vEkLqMqGSfVrQBHWTLELqM=;
 b=4RyByT301a5aYs52ZUkV1vfBp1vudN5H79HNUo5n+e+TlsZPpp5HF8Tw949hrHiPa3FKXgo3LVzmIc9en2VyMHAg8Kz+HuTct5+nYTOt1GabzlOOtQIF2nlMmcx+pTe8mekovR2Zv7557/X1FOw3NUrYpPgD6cm/sL8ccqpoJok=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:51:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:51:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature
Thread-Topic: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log
 feature
Thread-Index: AQHafILXmpsmjScwgkGdOTCvpp8pJ7FIbTFYgAHEkNA=
Date: Tue, 26 Mar 2024 15:51:03 +0000
Message-ID: <CH0PR12MB53728065D73B07D089A9AB6AF4352@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240322180021.391680-1-shaoyun.liu@amd.com>
 <CH0PR12MB53727B34030F966B79075C51F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53727B34030F966B79075C51F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T12:51:09.0581670Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|PH7PR12MB7425:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibwF5nijj7u8agjD3fu6Ojs1EvCPM94UmnptqOFDJ4qLUSsuE4jH94WBgW16z3OPfG3+LN0azlfrZdsedD9dqn1yLTvUmZ5O2eIgwkBd5X3J9z1ZGWWyYkh5MV57F+7TUM+zaU1lZRiR/VaWjD6P+BZb8hr7wNzPBurQnixOTpSCthWv5WM7sNE1GNv4k6wVmsqrGCqlDYXPJpksdZVZ36I07exOv3WZjLUsNIHRLzJ/cQYLcmNAin2MOT+yqgSPt2kHB1d2zkXw41Tpz4Mj/cBns+PHBkYmPYmzoYaTLJ+KPcacepgevtbOGzltgTO6NsVjVmu0ThYin5rZiRW46aJU8jwBxpwWefXkHkIGd03dd0uWPVGD04kW7lCtjMMXmBOuKwRybgPYflVQVPx6Pn1HDUTpZKKSb1AV13hdiNwfk8yHjl5m3NkJ+5NfY1SArm2TR5Z0xM0iDsW6AQUvpovaDl8oy4g/POuO+3P++oU2AYwFqPogdUgUuM2q7BjlLg+iVGivd3tBI8y9N+EVwP5SOH7I+Fij3ufYdUko7XeGiGPmEb0t+G2+NY/+YqH6VFCGKVnSMyB9dCM/3V3VCShQWvuaWvfcAF75KYaglVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q2+I3P0WYD4PnWC/Ey0HxpKk1vnYQGkvp9aF+E9KdBXs7103d7Fb0jYhY24n?=
 =?us-ascii?Q?Wm1lLM/PSchC+k9bJPza92Iy4bUXxktxpibR7f0QuCjR15KdStfBvI5zl1L9?=
 =?us-ascii?Q?OvIsmIazYzEJXxjdvrOS+G4tXEK9ezUDPPPPrx4X43qNPB2uu44fdjvtu5yn?=
 =?us-ascii?Q?+fl+CJiXGLpxA+mIVMnqi7KFvGwK4/NzDzhm3uGTYTrZaTV9ECBVvqskt1B2?=
 =?us-ascii?Q?qY8t0c9qnm5NtC+HxFYHx+0Je5ga0Jc64xuDUZiVpZbKN7Er3hGIYE/pw5xp?=
 =?us-ascii?Q?sFmxrCn3iuItB5ZxOgcPjvBiLXiBSjKOCTiGWjtWmZcF6BxKqB69hXV4JzPi?=
 =?us-ascii?Q?Ne/MziGkJTkMIRc+H16OvUN7blKSH0FRKdfaA8IfoWTtqDlK/LSO/vihVRH/?=
 =?us-ascii?Q?w+p3m5sDunCw+ZrAWnNF8T3xCuaUn+Xz8zXsM8UVjK4/89BIozrTHgM81cW2?=
 =?us-ascii?Q?bBMPlgL4pg96vmKaOsqwinpS8Yn3wDe/HY4kP01k2RVetAGKDL6/59iA6Ymz?=
 =?us-ascii?Q?lap9rHTPYr/VFaoddBHRLf05kix6LcwaznNYK6pOm+f3qka+pf5uZHJSXi+F?=
 =?us-ascii?Q?x9GloyK1XXZ+IWlSDafA7pm4BlC7Bycgt3o3Vv/yw9gJSt93crhA9uP8FsmS?=
 =?us-ascii?Q?3VmJud1x/OXGW1qMhTZjYbtu+SiqRPwn4yYfjwWhqxsE38YAYFQ8zz7iYWa7?=
 =?us-ascii?Q?JKeMDiFIQp5THp1Ut/dbKOoMqwD+wI7l/IuDeenpZa3Zp7rH6rXibtVZKbUx?=
 =?us-ascii?Q?22b35r2Fy0y8JFKuhBeoyYVe5DkfXeTqYUYJjekOyGocF4d72OsbpQDk1wVm?=
 =?us-ascii?Q?BLCm9CmxUM1jnM86y9NS1vTSWwNjLSEbU5G3FLVeLh5VdFFPNxOn8S/P84dZ?=
 =?us-ascii?Q?2i+UQ9fRjHEr39g8SKaWSkHc3qHy3JxhmeiwtbaieXMY+ShvdWQHg9ZZCVmV?=
 =?us-ascii?Q?oGvS3kahtYqz7UM6yOhfNJpj5HAbq5SqI7TS8tt9P59aHgzDSbIgll0Cw5jb?=
 =?us-ascii?Q?wx1mjcO0T8C5YL65xFvu8vgf1B3slmsRv9A4dEpUgkquK4wy/7UdZL+8czre?=
 =?us-ascii?Q?aFKW7Xrt5GfRSPotc9/eiO7V67g65k6X4dInJDSN1nC0pAue+9Jz8L4jldUr?=
 =?us-ascii?Q?vfUV5zqJjjjm79CL4Ed8X8lMzSjxA7CIGa3iGVZVYlbTussnvbnAoVt384oc?=
 =?us-ascii?Q?9CNG7F27wjiLDMvwbsCNXicNmdMvhYxqbssg4j9ZcG/3u2pN2/h30vWwA8K+?=
 =?us-ascii?Q?tKj0BTVWgPUelnh9J/5QpbgmaKVRA0on7DBtQ9IGf6kBxIyzRiwpnNrj/Jsu?=
 =?us-ascii?Q?ZVwMgJftqXk9TF7svaPboeqAR3/vwVPAj5hsEjBA3RWkXzCpBTszq0ydw+Ba?=
 =?us-ascii?Q?CW0KI2HqifD3CQ+6is1FIIHGCEeRKOSGBpDgY8+oro3DhKDaEIIsKszQjrsH?=
 =?us-ascii?Q?KczOX7NL8zSUyrhMFR4CMtSJ4f9r9Xmz48dEy0lG6TeHSn/k57BytFczjm78?=
 =?us-ascii?Q?DAkjXac+rZLPnxubXfhjHGdRfZMqLFQndRZ3qJiU0N/sqgZ3RrBXjVSvcH2g?=
 =?us-ascii?Q?FKHB+gPpMVLovT67gjc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53728065D73B07D089A9AB6AF4352CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc37c46-68eb-4634-db83-08dc4dac8a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 15:51:03.4112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSuvT7cSfDQfoRO98tAUxNdxY5BUFtY4gNJsejvAURROpk6MlS8ukcsmYGAeDKa9U5mV6ouQGmTk2ncHFSa8MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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

--_000_CH0PR12MB53728065D73B07D089A9AB6AF4352CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

ping

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Sha=
oyun
Sent: Monday, March 25, 2024 8:51 AM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log fea=
ture


[AMD Official Use Only - General]


[AMD Official Use Only - General]

Ping

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, March 22, 2024 2:00:21 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature

The MES log might slow down the performance for extra step of log the data,
disable it by default and introduce a parameter can enable it when necessar=
y

Signed-off-by: shaoyunl <shaoyun.liu@amd.com<mailto:shaoyun.liu@amd.com>>
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

--_000_CH0PR12MB53728065D73B07D089A9AB6AF4352CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">ping<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Liu, Shaoyun<br>
<b>Sent:</b> Monday, March 25, 2024 8:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu : Add mes_log_enable to control mes =
log feature<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">Ping<o:p></o:p></p>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Get <a href=3D"https://aka.ms/o0ukef">Outlook for iO=
S</a><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.=
com">Shaoyun.Liu@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, March 22, 2024 2:00:21 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu : Add mes_log_enable to control mes log =
feature</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">The MES log might slo=
w down the performance for extra step of log the data,<br>
disable it by default and introduce a parameter can enable it when necessar=
y<br>
<br>
Signed-off-by: shaoyunl &lt;<a href=3D"mailto:shaoyun.liu@amd.com">shaoyun.=
liu@amd.com</a>&gt;<br>
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
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB53728065D73B07D089A9AB6AF4352CH0PR12MB5372namp_--
