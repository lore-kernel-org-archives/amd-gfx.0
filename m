Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D13C282D6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C724110E645;
	Tue,  4 Mar 2025 16:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSNE2pm9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B6110E635
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9EPk9DUzmVkvHkn5LUve3WV3DpXqsT6n3hDliY5kEREmnvIM1mBUx+R/49q3CZaz3zmiEcNimzwq9IK5N+RMRYzOtHtowach20WGIJlNLWOUo7kOLYCOoTrrODBIRHPxNQ2X9dw2TerXrBJ3fmu6GTlE+1ymnEjJTbvmOVVCp0RinB0WoT7ZD9Tn59CD9r1physcdz4x6cqreAoWr03Cy7Nz1Imd3+kQkKcX6y0o/6xIKZPjClkx+hkebLfqY2y1YFaNGHZ87U3mxD8VCpOi3usSIgqkK54IQ0Kgho+5HC88nkEpeeMK1Hs/Dz2v8akBWCwlXNjwt3Eocs/qvW/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpRlF07OVnUFvyIcNyx+tZ/Uv4ks70+qHbnM75k5N3Q=;
 b=LML54MrWR8g+GdgWXeKZ0Alxp86Zka5DJXNHRmSH0PjlubIgkeI9M8uKHpBvf72OmaCsnvZajLrSr19XcwzdRcxtkYbi0WRq4peY6sEibvPV0Hl8OnDIP+uZgHM5eQpXezOELuDWUWUodyizknrl4+h6p449s3Rc58sfoVKpccHUI0lSGOyGzCBpIP/H9hCwAz5wgKfZkn8XwL82V7Uaiu/HvBRoZi1nbf15GWD6z9zamNb4igmGDHGRJ1zwEVgHniXxwIlad3pX0gd4iI9WIlh51v95dQfRymr/8lHmmib6lgj89y95UGk2PYSsgRNWIZncdKvwEM1yeN0UVI7gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpRlF07OVnUFvyIcNyx+tZ/Uv4ks70+qHbnM75k5N3Q=;
 b=QSNE2pm9vkZX1uGvpkc+MUz+qQawmEaCqThPtIB2Es23f4xVP8VyolvdE/xy0sQY4u/ad32W16o0N8hMXCGwv0q/LHuVnf1kvaOEXI4UmIi+VRw/lGm15395W8YKkcYwv+SRdO+YTFePDXmqmjUtSRLdsStQ6CUJ7Ohbb01uC6g=
Received: from PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 16:22:43 +0000
Received: from PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4]) by PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 16:22:43 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: flag per-sdma queue reset supported to
 user space
Thread-Topic: [PATCH 2/2] drm/amdkfd: flag per-sdma queue reset supported to
 user space
Thread-Index: AQHbiJEhE2MJCk/MuUqDtfnTn+oj3rNjMffQ
Date: Tue, 4 Mar 2025 16:22:43 +0000
Message-ID: <PH8PR12MB71124C3489367274B303C4338CC82@PH8PR12MB7112.namprd12.prod.outlook.com>
References: <20250226205734.3108512-1-jonathan.kim@amd.com>
 <20250226205734.3108512-2-jonathan.kim@amd.com>
In-Reply-To: <20250226205734.3108512-2-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7d8d950c-f7e6-462b-af29-0d12fd55a65a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-04T16:22:13Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7112:EE_|SJ1PR12MB6243:EE_
x-ms-office365-filtering-correlation-id: 10ea27fa-7045-410b-14e5-08dd5b38caa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IfSPW1eAowm2TTZ7ZIDpQsb9kb/LwpIguMPGtGPpsS26aUjqVUOPB3GtWoBj?=
 =?us-ascii?Q?P3Fahog2rOdSgd2kUdVD67KxsZ1qCHoyeT70aJC01v+IoeraMMoHecz6w6i7?=
 =?us-ascii?Q?R3rCskNRfSs+qCKlc+tYuWY5OlVajN+qX9wzBij0NRR7zKBOAmo2DoXFYlHO?=
 =?us-ascii?Q?MNFwDBQm1imxMyU+R2Ej5liZflho4JZRGXkchpdBEJLgpZdPyHn43vhAVUSl?=
 =?us-ascii?Q?+1CZxLE5y5tsUIsOEpOIMcIEmHocYgcKw6H3RjjHU0aATcB47/xMIlFCeRyZ?=
 =?us-ascii?Q?8UBOsxxoNZRWBMjKVgwxtO04is/lWOPvasoNWNqKfiNV4IO7zB1yI8PClp5m?=
 =?us-ascii?Q?apr/H+IM5CuhkawgWLiM9evk1Eg31YiGNInNs2Dzz05JowKiPoXp5DyVRuz7?=
 =?us-ascii?Q?JNhi2vO2BXHWitBtNVyG+6+v4Wuk7phwL8JW8wsvt72BXuBmukOcknlUHRSi?=
 =?us-ascii?Q?XyR5dWr9o3GrswJWZn63yvYEkFbrJPHxqv0d1Xhxu73yAxMAtemgVKsxpJt+?=
 =?us-ascii?Q?u+F4RascddVDJBa80WTb/Duqw0J5YtWI5z9W+k8upBNZjIIKqb6hwnDVVbyy?=
 =?us-ascii?Q?7yJEi9MLX+2TvEgPQ0l08nQWAMtuy+uRgdMunA3x+dft1pxYkksLQPWwvPKv?=
 =?us-ascii?Q?cCoX9NwbZZlHxdnE6zjKkHZKA4xVxMFufEfALLqEpNlTlYxR/ijy+B5t3gwD?=
 =?us-ascii?Q?Bj34fP6l4Bxe6de+B3Owmrg+zMBGXo9kvaZcMXNE1AGaiSyPi5e6jLEiJg4K?=
 =?us-ascii?Q?adIEvaot91jIqsi7OY5k8H5RjmnsuUqQwrLuQQ0n7GEYX97MlvIqhc5ZN4ew?=
 =?us-ascii?Q?CILJ1CeJeLADk+GzoehcIM3sogBeCllo6G/1QNJoBPBOyD2r3CWJga/bCMg5?=
 =?us-ascii?Q?GP4uwJKmhNjsvQpQIG+Llwq6UGqAtkZDKunfP+3uqU9XN/Eg2T1Bi2NFY7Be?=
 =?us-ascii?Q?j98aL2HIcTCes/QPwfqLtrCw9AZOL9DoXdKl1Qi0G+CJGwr74S4AW8VZs079?=
 =?us-ascii?Q?ft3q9zh4DKe6AyYqCtuYeX1sOAGIc7TYI8oPwbQ7WrrbmBeh22bTZ6i0PTe9?=
 =?us-ascii?Q?xl9iXTt/zDkJrm2frA4onldBmrb74oqZhuVfk/LbkKoaoU7VpiM/5AZMJDuZ?=
 =?us-ascii?Q?Y333jCHFzr4rQfcS+wMVdNpo/m40p1yLCaRzXJQomA5BiKoUEYtribcs9p7S?=
 =?us-ascii?Q?DCQxQQ38WaTn+lmF4Cxq60SIGxl1anG5lnl7Pp08jeloddRTBzxms1OiHtCD?=
 =?us-ascii?Q?jp4AlOacUEJ+3Ve3c7RjY8zJ799CoYRGPdB4DSkyEGiC2uHU+qAdYIF2AzwC?=
 =?us-ascii?Q?TX4HOrm8l8hi1H5XsmlLBAdwUvhkemrWT66xU4DTloG9v3Qh3ApwDPhvxzct?=
 =?us-ascii?Q?lLcvIXDdX9cntx0imrOmgxO3JTzSzdXeAg5o3uId2yGA9XjpIw4MnP3P4hdy?=
 =?us-ascii?Q?8sh7yJRj2BMd28kxo2TzRvQCSYGzuWyL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?egKAtPZudpAcvnH/q+gndKm5Hdsv9X4woTV2Nk5qQqskF2NQY4Gk46Cq0vcW?=
 =?us-ascii?Q?dQ+MQ09mOdNfcCTT6P7z4O+7CFpWSuYOi8av57sjct582ouhwJq3hJYB5uiF?=
 =?us-ascii?Q?z1fseJgTrTfsO6auwa6ysf/2d5kacE9HFjJBBOvQuaMxAD129y84OdM/DZg/?=
 =?us-ascii?Q?PLNbiBbXPESe4iPLBGZ0MHkrwyUBeIadv6WZxg9AIIY5o+9BRp8mqJJIvOfj?=
 =?us-ascii?Q?tMZCMTTtif/LrUXkw7NuvXXEGyFHxdSpeUO4csPv22eiB4t1dSw9w1PrhWrP?=
 =?us-ascii?Q?n9Jh6AFC/OgUU+9ucjJZxJUAOejMd5VydCsnrVSgvaPyDvTO+J/3btvaXNKC?=
 =?us-ascii?Q?sixM1S/varR6z1bGVaNuAoed7wvsH/hVi3lnJ7E0xzV54ZUaIRincCh37rGb?=
 =?us-ascii?Q?B9kd4yFviLl7hg6oVjx74r7/M26Zilku9l6EYUbya4DjWaAn3hqvSx2whXlf?=
 =?us-ascii?Q?BsL8nypQ4x2ylkGo0aHkdSHJK0Ca1A3pVfSs4uGTMg3+5XDePqzvyLjVrBhK?=
 =?us-ascii?Q?Y8wShiQG7E/ROQg3zDZqqnubm8ppPJbg3VCg/7I9P13EAWqHxEBoGSi2LxUj?=
 =?us-ascii?Q?QUZYNrUWWkqLvTRSr/RKiguvrPRoQmQYPzR5WVBLLuDWqjfI7phOyf7WwHgX?=
 =?us-ascii?Q?tD1tTkwN1fYzHNKasOtAKzY8eTjNkEzhdzKaF3o4ZIlCAmlQsWuYeBl4GNbY?=
 =?us-ascii?Q?enFRWL9QzoWFKgtwc/MnXqnFMd8UsUsVM940mCavhoNVx9iUoxhu6vaWaHvD?=
 =?us-ascii?Q?9Qz5psOOnEutffcKwyabyws10weg/o7O5H7It/KHBAnioYwE2UCaYM2tOq5n?=
 =?us-ascii?Q?pUle+rUVXoxJ6ukPzFlWKAuKeS+EN1YJyd8Jjpk4MvGl7T3UcFZWJjK4Nwsg?=
 =?us-ascii?Q?TnYQ+cB6JVfO13oWu6zjCiJ1UYAqVNt/4waoof2v3AbkMWyd1VQ0iiXHVkTy?=
 =?us-ascii?Q?V8TYJ3abkzoK5XCYK86WlKymeggSsV21PBqwY7u4MVMaJDYfRp2ShNNqqZW5?=
 =?us-ascii?Q?7fUlmBeJPGU3teyxDpsiY+Q15L2Mm4L8Nf8m3uwesivSFWQcVqCYDH/39fnc?=
 =?us-ascii?Q?rVRtoghVKONnIOkgM5jx61qYT/jBUqYksp8maFG4uhpRM2Jvm+ZyXMQKYuXO?=
 =?us-ascii?Q?2j8T0wwRWQwIjqtAr/Hge7kdT6ReiOHPY1B+lBtM29goKKQP75HlOVAKJoRZ?=
 =?us-ascii?Q?b8YY7T8h+bpgpOmUesMfus8H9ymI2mmpnynxLePfajAsO8oMWTDJ//Sue4Nl?=
 =?us-ascii?Q?hZrOSviCuFKPg6jN0uEi7N8xK3+YSW/QMvMAU2Lm1haOeu8DP9dvzsxNX2Qf?=
 =?us-ascii?Q?g/tfTDmuF/JJPIGdFQzi5F5FMx0ZJNieCn9txuPuufxpwK0n+qW46sws1kNw?=
 =?us-ascii?Q?9DlVvwRGAiyiIer/KCsXSS4q2EKjcnmWZ9ITJlhLMsBJOBIi5EHFQ8GdM6Pa?=
 =?us-ascii?Q?0UaKq6Eg74G+c07D8IjWfJo0lKX7bF8v6ePF3pv2lCZddhzmT0uytSQVztx7?=
 =?us-ascii?Q?V8WfZNtuMtgFHizTd0xSVjhT49RRWw0k2yEn5XBQmmNh1CUMbY6MycZIRskY?=
 =?us-ascii?Q?JbY/JIO+VBxTobbTvYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea27fa-7045-410b-14e5-08dd5b38caa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 16:22:43.2260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXNO6jbbNfInkXdIK85Y8JCh1tnFUgmdlBnGCntEQQIvxnemJP9crcHKNZOCX/DoKQlLu0KIK5z133p6zot/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

This series Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>


-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Wednesday, February 26, 2025 3:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonathan=
 <Jonathan.Kim@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: flag per-sdma queue reset supported to use=
r space

Similar to compute queue reset, flag SDMA queue reset capabilities to
user space for safe testing.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 include/uapi/linux/kfd_sysfs.h            | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index dbc5595e999a..27e7356eed6f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -519,6 +519,8 @@ static ssize_t node_show(struct kobject *kobj, struct a=
ttribute *attr,
                                      dev->gpu->kfd->mec_fw_version);
                sysfs_show_32bit_prop(buffer, offs, "capability",
                                      dev->node_props.capability);
+               sysfs_show_32bit_prop(buffer, offs, "capability2",
+                                     dev->node_props.capability2);
                sysfs_show_64bit_prop(buffer, offs, "debug_prop",
                                      dev->node_props.debug_prop);
                sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
@@ -1981,6 +1983,9 @@ static void kfd_topology_set_capabilities(struct kfd_=
topology_device *dev)
        if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
                dev->node_props.debug_prop |=3D HSA_DBG_DISPATCH_INFO_ALWAY=
S_VALID;

+       if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QU=
EUE)
+               dev->node_props.capability2 |=3D HSA_CAP2_PER_SDMA_QUEUE_RE=
SET_SUPPORTED;
+
        if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
                if (KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 3) ||
                    KFD_GC_VERSION(dev->gpu) =3D=3D IP_VERSION(9, 4, 4))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.h
index f06c9db7ddde..3de8ec0043bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -51,6 +51,7 @@ struct kfd_node_properties {
        uint32_t cpu_core_id_base;
        uint32_t simd_id_base;
        uint32_t capability;
+       uint32_t capability2;
        uint64_t debug_prop;
        uint32_t max_waves_per_simd;
        uint32_t lds_size_in_kb;
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.=
h
index 859b8e91d4d3..1125fe47959f 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -63,6 +63,9 @@
 #define HSA_CAP_PER_QUEUE_RESET_SUPPORTED                      0x80000000
 #define HSA_CAP_RESERVED                                       0x000f8000

+#define HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED                        0x0=
0000001
+#define HSA_CAP2_RESERVED                                      0xfffffffe
+
 /* debug_prop bits in node properties */
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_SHIFT    0
--
2.34.1

