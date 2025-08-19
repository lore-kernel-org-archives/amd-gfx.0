Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC66DCA0EE4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 02:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DE510E0D5;
	Tue, 19 Aug 2025 02:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWcntL2c";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5158810E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 02:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSucCpEutnJK3EBWW5znYy+MLaffyVLHaTXXnT2P8RH4oPspsBZXFUzXNtUF/GAddi6moNbdRBD23cWEYtDANhkhM63M9GJcGV2dt1tiusM6BycHPWBTY9fFmy+GYW9SjQ4+S2iGWp0I7YzS5pWEaAzG1m/h5ec4w4+PZ26uP5FUz9WFIar9GWoEma7Tbo6bSKmJM5tqCUKKC4JtTJTTcwUYXZegzaul/3gqrCHyyeDXmcnNW+rlhTv/UygSbfByL/hGMeGo+8Wf625kskXiH5AFWJwewkSovwnGu78KgB1xBy47G5aCESlHyvFcXQWTxw2JGi1E6ZP2MoRi/LjoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0rWo1o5cPbsmelM1z+gYkxKZW9Ap7VhVCCUntpsmiQ=;
 b=D60TGRb+HTAwRWG/0q5ZTpm9AXjXu6Q0jbkKqUsbctLqq2sDzmfLPQ0ejRnIql2scRVQcQQajoBF2xjv2h0TDDIv5wqpxF2zMtZesB0rWq7Bo0RYlXsQAur6FHni8pNVz3TVppBHow5f3B/R+Dpe+qO5Tc8vlTJ6PbC1L4OQomfWlIUqj/isotvdK0cfWu6dAhgXGSUXztXWuG7MitOdAD4CcYOy3iGmkYARj/JucWvfD4XrIebFW8VAstMUDeQHEbOAq8ruAEdaVlPmxi4UKpk9eUwoHG2ZTfV7NwaTMAlpbJ0+eotJEG2F+IB3BM7QQaaNyVXiL2MlhznJDmpU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0rWo1o5cPbsmelM1z+gYkxKZW9Ap7VhVCCUntpsmiQ=;
 b=PWcntL2cE6bsKFyzpxFpjFn7JDi6acWT2YxK7CCa00PdExSHQ/9pK6VypXK4/8/5xPxuYOri8XWOe8gKkJhFw7YQOZF2qLUAcm5JvxxGkChDlc89czRaawXfvqGGQ7ZAH/UksqhV/PGUS12rDu/mJ+n7XS3XpmZ5KI/a/m+zhls=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Tue, 19 Aug
 2025 02:48:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Tue, 19 Aug 2025
 02:48:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [v8 11/11] drm/amdgpu: Implement user queue reset functionality
Thread-Topic: [v8 11/11] drm/amdgpu: Implement user queue reset functionality
Thread-Index: AQHcCqbWfRJJqIgqdkOhXY5qzKTYILRpUdXg
Date: Tue, 19 Aug 2025 02:48:02 +0000
Message-ID: <DM4PR12MB515227DAFA41BB91F87A3A0DE330A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
 <20250811095937.1978747-11-Jesse.Zhang@amd.com>
In-Reply-To: <20250811095937.1978747-11-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T02:47:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW6PR12MB9017:EE_
x-ms-office365-filtering-correlation-id: 2986bdce-53a1-4539-418b-08dddecad0e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JzJ4iT+A4BMsbg2xuHGatnqOTbA29KH9u1ry9wGb4K+61J7GANZxeoRSfpcu?=
 =?us-ascii?Q?8+8t38/zYPVGCadn78FbiuhavL5NVNOnF7y5QprY0ut0hFMbC+v0pLvagge4?=
 =?us-ascii?Q?8e1QgNW8m1KseMXMydQq0enMcHObGNVug0FxK3snpV0vgu2FruX6/0u4lNV4?=
 =?us-ascii?Q?jieXsBuD0WKGS2l2ed9TRxk0agGKrEwV5tXRbBkMGPw9Qyh77uIa9Wbc7+i7?=
 =?us-ascii?Q?ZOJIwdAyZHBV3WVtoMZcKF/wOLEyxw48SKRtq6tnguaU6z7oUYqlRP2USc4p?=
 =?us-ascii?Q?M4yNwAG8tdzt023FuZm5zrOvjT+HSkkM9GzRJJ68oj9hIjHiQ9fsFQ1W4GDO?=
 =?us-ascii?Q?8eX8Oc83SgmECRXG12Al8ZDS8SjA/RTp/t6MD+/RyP4Tvn4WpSARI6qOBBIl?=
 =?us-ascii?Q?eHLu9nw6Mn/F7OhQPLpdam79XrRfDVprrFd78EZ6IATwFScCKqm4W6HoP6ek?=
 =?us-ascii?Q?dffktyct6m/9dUHpnIrcbV2X1Z82Eglz0yK/seIFpGzJTMlzBJCPrx83ZuTN?=
 =?us-ascii?Q?qI2iPHx7WH/EXIwYTUfGfCcEikNgO5WKIrbWI/AcfedG1HEBUnTKIP6jLvQw?=
 =?us-ascii?Q?wOlNqReTv7aRKKkF2UE5Ipe9K0PDHOQnLK8N89n67+B0TESxmyaZVu0Rp7TZ?=
 =?us-ascii?Q?+p0p+dcXKT5yk2mGMTLsbdnKHOztecS3OyTyi2TheNZUSXyC8Fi0VSXJ4vM1?=
 =?us-ascii?Q?3uM9P82gQdH1ny69al6TKSRSfd6/qvETs7FKAD+aF6kqNRU5aFYZMGs4uLKQ?=
 =?us-ascii?Q?Dy9o7/68805EIajrK5MdHoCDw1TM/k+sYhZdXcCM1UwUBKDxBPhrFlXU3S0f?=
 =?us-ascii?Q?NuVE1o+sJkf6nhXILZL4r704PxAdsHroHr+g2FuEyiXraI50MRgSGQVSMuOP?=
 =?us-ascii?Q?5bqtymGDrMPadxPx17vgyiURFfsVw2FHnRILb2xomGOAi6kvfExwC9iTm07d?=
 =?us-ascii?Q?p6T1x8TBdhj8fkbTj7w8/20sjeYfXhQMcx0z5P4hgGwZg69H3M4grzd0ys4S?=
 =?us-ascii?Q?3Wf+O1J3zcxnymLmzvsDjcfw90VNpUJ/SELp+nTwrTzV0JW/TI3BS1Mldj7T?=
 =?us-ascii?Q?9VE9qBHv1m521wdXR0wd9uKPFJNjdpPw/Mc+PSHMo9n9exoZlGUZFZeWLy6W?=
 =?us-ascii?Q?MQVlXAnhhWUxy+VfHUc3RfOu6aOxgNZj3BYhqkl41a8HSe9VwR8XnHMQKYC+?=
 =?us-ascii?Q?MCQadjX/j/A7QMfsacbZd85b30z2vVCJ0FoF1BHYsrQBLKxNzQGohMdzfxua?=
 =?us-ascii?Q?clo2T9inCRLHZzjeIdOz3UuGZJsKciCo42DMatMdxNSSPQi87WmG/Vg8HLK0?=
 =?us-ascii?Q?lHvNBXlJXCFwCNgDQhDhHUsRaKHxtkbFoK31Q2lqPnIb82pJ9+5f5NkyG4qg?=
 =?us-ascii?Q?erIkkSWEdsSNOsnGcu+la2A2TtpwTVcQuVcZ57ln6ZAzWJTvujjCCaVhSj7T?=
 =?us-ascii?Q?EcJ7kLikLovXcKSPva1ASvPZLGUeMkI97LEw4wu2+ehWw6LUEsuBWA3QbUVS?=
 =?us-ascii?Q?mqy1ussLR3n+srQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rR/fM1ppXI0pIJSk5KcXtZGui5uZsUMjAOa4whh3uSBIaPps8FAsGPfkYICj?=
 =?us-ascii?Q?mdslb8SzdC43O+lQZkMfTm+w0UxpWkr0N4aCABZB5zYkLqBilWPnWyRB2GZz?=
 =?us-ascii?Q?PsFKPPeWQYQLhOv2XpjxfCE/Edh2gxrKanEpKlBLrIBKvmopR/z7UQxzbwVQ?=
 =?us-ascii?Q?57dDixf6Asajf5O8d5PBEisWsEQH6rD7/JUrfruf2Ou+wN/JHfptLmqAev4x?=
 =?us-ascii?Q?/dVzSNNWcsz9oHZsQypV8qt7g5fjfWSeQo9R6zoeIqpCjqMnfSV4mYBo4NW9?=
 =?us-ascii?Q?yLsqFFnYxDxnr5Xs4n/BCo1+4XHPia82c5yN4Mz0yFgtyvRhsw+TYiE/IIy4?=
 =?us-ascii?Q?Zy5lFacOC709D/OlQVeeHOo0cpIdPaPNf2yibUB+ANmybURLJB8DQW1RSzGw?=
 =?us-ascii?Q?h/zmjb6YI8c+6C/vfxqMRTLA7DfT3k7YQiWUe4VfcsOwYCYLcBupBdaPwcrT?=
 =?us-ascii?Q?tRXs9drE3AWpYB+/hsMNOacZcF+kUCAoo4QAgIBJGMSx6G0oQdRE4KgN2EJI?=
 =?us-ascii?Q?AoYHUbRUKyc7m1FphUiAv+O8HkODBoyQqlLo+K5eOSklvi+Y2NFXM1JcWNW7?=
 =?us-ascii?Q?xEy1Z15TcM7At4BjM2NEZKoNhbm1dNI2/eollGdW34tQt8+KeGyuAj22A05J?=
 =?us-ascii?Q?JmSrEJrN75pwr3UYkKVOpzy4ZZpMw28+IoBJwyWGEaySrl8+2qUQlhAIitIq?=
 =?us-ascii?Q?+3xnnCGdqcx0ZIkc+z6vObOAj/TjSQpsZfVBMGVC7kBAXi99istn37I5e+im?=
 =?us-ascii?Q?LVcAF6i8i7XatCo7VHM68mTiLw+bOjoMRHvMZg/Ga6hJiLHE7ptHK2SVWJCK?=
 =?us-ascii?Q?VXaMm0J/z4/XpOYt6ESAdB20rweb2C4Z8aDQQD2FXvAjfv7NIMUWsnV3QmYS?=
 =?us-ascii?Q?0AD1U58/HxCgQHYo47hiBP/QCXFR7O7ZxVr3nSawFwhPJqNSkH5coEkCctEZ?=
 =?us-ascii?Q?hDEnRojbnxGjs3TyPC1hDq6kbpKmjYfpUu/T6lLyZTwbGLnrpfvsZvBbWXqU?=
 =?us-ascii?Q?eyXRxr0aQcuDY11ReRpwHzBPdzBECULUOqK/FYta4KIOgba6xQx8RrSG9mI8?=
 =?us-ascii?Q?LrDugnfJTuEkqchMEorkabPu4DlBbSJeMiZx69lFB9DAeCp7aioUu1t1rbSZ?=
 =?us-ascii?Q?CBNfGBcQKV8KQeaqvHQ+irMpv/4sc9EDCV4cW36jZjSuMdDqwGy7/X5Ums+S?=
 =?us-ascii?Q?yrFM1fAhH0BU2zpfeEjFzeC/B9K4/3DDGybTK30jyyGLCORopYty+VIotz33?=
 =?us-ascii?Q?ZP2+hkL7VfDtcExvJXnndQZzXTfRC7Mm+9srxrTzEGeZIhU2x7QB5y8ftYFR?=
 =?us-ascii?Q?p3j866zayBWDPBdK4S2CFzo+k51z5e3Dwx9thQJoDF+U/8jd4mozvYLahx+V?=
 =?us-ascii?Q?PuWcNpPnB+KSc09iJpfkx5k1IyBn20COFiYNoV+ACkCszF4DpPo/rutrUX6g?=
 =?us-ascii?Q?xEDpjW00rJk+ti8tFTBwvhTRO+w8wbcv/2RhlhnRUuaqdR1LWAtRwt9XSyk7?=
 =?us-ascii?Q?6m8XbRNJZFTefjsxmjtgqHrw8xY/vg1QqhjIjmYEFPo8bZyQ8tbwdkdq8WDF?=
 =?us-ascii?Q?6zF138MHiX6KCtLYWBQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2986bdce-53a1-4539-418b-08dddecad0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 02:48:02.5960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jkvqx56HzIAmWdr2Ei+Eip1+RQu2aeqMVyT8R/MBiP0CAZxLn9YPdxxd+VgU0oPOdLQltoTkOWLpcXoFuuO05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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

Ping.. on this series.

-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Monday, August 11, 2025 5:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhan=
g, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [v8 11/11] drm/amdgpu: Implement user queue reset functionality

From: Alex Deucher <alexander.deucher@amd.com>

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

The reset functionality works with both compute and graphics queues, provid=
ing better resilience against queue failures while minimizing disruption to=
 unaffected queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 199 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ef3af170dda4..9db05cdc7304 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1302,6 +1302,7 @@ struct amdgpu_device {
        struct list_head                userq_mgr_list;
        struct mutex                    userq_mutex;
        bool                            userq_halt_for_enforce_isolation;
+       struct work_struct              userq_reset_work;
 };

 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_device.c
index 3757634613c3..1dc88b0055dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4475,6 +4475,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        }

        INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);

        adev->gfx.gfx_off_req_count =3D 1;
        adev->gfx.gfx_off_residency =3D 0;
@@ -5880,6 +5881,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_r=
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
@@ -6102,6 +6107,7 @@ static inline void amdgpu_device_stop_pending_resets(=
struct amdgpu_device *adev)
        if (!amdgpu_sriov_vf(adev))
                cancel_work(&adev->reset_work);
 #endif
+       cancel_work(&adev->userq_reset_work);

        if (adev->kfd.dev)
                cancel_work(&adev->kfd.reset_work);
@@ -6232,6 +6238,8 @@ static void amdgpu_device_halt_activities(struct amdg=
pu_device *adev,
                      amdgpu_device_ip_need_full_reset(tmp_adev))
                        amdgpu_ras_suspend(tmp_adev);

+               amdgpu_userq_pre_reset(tmp_adev);
+
                for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                        struct amdgpu_ring *ring =3D tmp_adev->rings[i];

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index decedf8057ac..028de887df26 100644
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
@@ -44,6 +46,88 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_dev=
ice *adev)
        return userq_ip_mask;
 }

+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev) {
+
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
+
+       bool has_gfx =3D false, has_compute =3D false, has_sdma =3D false;
+       struct amdgpu_usermode_queue *userq;
+       bool gpu_reset =3D false;
+       int id, r =3D 0;
+
+       if (idr_is_empty(&uq_mgr->userq_idr))
+               return false;
+
+       /* Detect which types of queues are present */
+       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
+               switch (userq->queue_type) {
+               case AMDGPU_RING_TYPE_GFX:
+                       has_gfx =3D true;
+                       break;
+               case AMDGPU_RING_TYPE_COMPUTE:
+                       has_compute =3D true;
+                       break;
+               case AMDGPU_RING_TYPE_SDMA:
+                       has_sdma =3D true;
+                       break;
+               default:
+                       break;
+               }
+       }
+
+       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+               dev_err(adev->dev, "userq reset disabled by debug mask\n");
+       } else if (amdgpu_gpu_recovery) {
+               if (has_compute && userq_compute_funcs->detect_and_reset) {
+                       r =3D userq_compute_funcs->detect_and_reset(adev, A=
MDGPU_RING_TYPE_COMPUTE);
+                       if (r) {
+                               gpu_reset =3D true;
+                               goto gpu_reset;
+                       }
+               }
+
+               if (has_gfx && userq_gfx_funcs->detect_and_reset) {
+                       r =3D userq_gfx_funcs->detect_and_reset(adev, AMDGP=
U_RING_TYPE_GFX);
+                       if (r) {
+                               gpu_reset =3D true;
+                               goto gpu_reset;
+                       }
+               }
+
+               if (has_sdma && userq_sdma_funcs && userq_sdma_funcs->detec=
t_and_reset) {
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
 amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
                          struct amdgpu_usermode_queue *queue) @@ -56,6 +14=
0,7 @@ amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
        if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
                r =3D userq_funcs->preempt(uq_mgr, queue);
                if (r) {
+                       amdgpu_userq_detect_and_reset_queues(uq_mgr);
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
                } else {
                        queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED; @@ -=
72,17 +157,21 @@ amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *u=
q_mgr,
        struct amdgpu_device *adev =3D uq_mgr->adev;
        const struct amdgpu_userq_funcs *userq_funcs =3D
                adev->userq_funcs[queue->queue_type];
+       bool gpu_reset =3D false;
        int r =3D 0;

        if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
                r =3D userq_funcs->restore(uq_mgr, queue);
                if (r) {
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
+                       gpu_reset =3D true;
                } else {
                        queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
                }
        }

+       if (gpu_reset)
+               amdgpu_userq_gpu_reset(adev);
        return r;
 }

@@ -93,16 +182,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_=
mgr,
        struct amdgpu_device *adev =3D uq_mgr->adev;
        const struct amdgpu_userq_funcs *userq_funcs =3D
                adev->userq_funcs[queue->queue_type];
+       bool gpu_reset =3D false;
        int r =3D 0;

        if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
                (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
                r =3D userq_funcs->unmap(uq_mgr, queue);
-               if (r)
+               if (r) {
                        queue->state =3D AMDGPU_USERQ_STATE_HUNG;
-               else
+                       gpu_reset =3D true;
+               } else {
                        queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
+               }
        }
+
+       if (gpu_reset)
+               amdgpu_userq_gpu_reset(adev);
+
        return r;
 }

@@ -113,16 +209,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
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

@@ -361,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_i=
d)
                amdgpu_bo_unreserve(queue->db_obj.obj);
        }
        amdgpu_bo_unref(&queue->db_obj.obj);
+       amdgpu_userq_detect_and_reset_queues(uq_mgr);
        r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
        amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
        mutex_unlock(&uq_mgr->userq_mutex);
@@ -746,6 +849,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr=
)
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
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)  { @@ -772,2=
2 +892,19 @@ void  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
                   struct amdgpu_eviction_fence *ev_fence)  {
-       int ret;
        struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
        struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
+       struct amdgpu_device *adev =3D uq_mgr->adev;
+       int ret;

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
        amdgpu_eviction_fence_signal(evf_mgr, ev_fence); @@ -828,6 +945,7 @=
@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)

        mutex_lock(&adev->userq_mutex);
        mutex_lock(&userq_mgr->userq_mutex);
+       amdgpu_userq_detect_and_reset_queues(userq_mgr);
        idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
                amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
                amdgpu_userq_unmap_helper(userq_mgr, queue); @@ -861,6 +979=
,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
        list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
                cancel_delayed_work_sync(&uqm->resume_work);
                mutex_lock(&uqm->userq_mutex);
+               amdgpu_userq_detect_and_reset_queues(uqm);
                idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
                        r =3D amdgpu_userq_unmap_helper(uqm, queue);
                        if (r)
@@ -917,6 +1036,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(stru=
ct amdgpu_device *adev,
        list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
                cancel_delayed_work_sync(&uqm->resume_work);
                mutex_lock(&uqm->userq_mutex);
+               amdgpu_userq_detect_and_reset_queues(uqm);
                idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
                        if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
                             (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
)) && @@ -965,3 +1085,60 @@ int amdgpu_userq_start_sched_for_enforce_isolat=
ion(struct amdgpu_device *adev,
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
index 9fa0d1a88d71..e68bb144b26f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -138,4 +138,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struc=
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

