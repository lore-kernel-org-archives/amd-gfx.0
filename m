Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF073FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA7610EA01;
	Tue, 28 Apr 2026 03:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IjeM+UbI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AE910EA01
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfmQ4SdPH5uLWAx7zrfH73ok6dRCIXQREhEe8BY67rKqHm8IHdxOgE3zjKeG2jMhVgAR8KSmoS+nQyjsGGHbG1288cZWFsmd7ZFs634MpGOe4IVAQcbTYtB/xJbYRR6333ioxRAEqpuYZgg10QzyXEwQLqsPFX78SSdLMujY9cjPyVdFd7KrHm8OOV+ZYs+fjLJDXzY3sa7cBK4aqqe4l96TdZGsfWZAg278xm4CeA+2oVUKYjdrG3hZDChGSNDnFQh7bqodaHZHg8o2Yka3MPQaurEmMA3UoWSTD2OLwb3rwgd9FIubSQvSb/f7Xfc5eJz4c0bOFgVJzT/7pxVjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTYNenm3LGSzw6EZuxk8I7rBkZ+BDR61WZf8SvW+XPo=;
 b=RLWv8081uk7/79RQvO1ZPEX/760O8hc7LHW1GogHfpQzroAeqQX8BEmMSvHvgKciWLV7hzlxWMbC+zoiahJuD/NKn+A+uyc4OH/QII9C+4bCjNlnsScuh6U5ARRbzfknBYXjNwODfLMVacEf58Q8Cohnu3Ditbe9xZc7aD1jd6NYHRciSpBRQUTnDsDB6cjaF6M19HtV4KejOXCb2+/HingDYb6Ii/f06sVNAGNNiEluEI44eQ3zKeZ9kJoJBb4tIN1RdZei4pyLCzFpTUeEBI1sdRwcnVJ6hwzukYhMbCWj7NJvNlXO737pPKKpXF46D6S32tDudiUMzs3n+BoL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTYNenm3LGSzw6EZuxk8I7rBkZ+BDR61WZf8SvW+XPo=;
 b=IjeM+UbI67jPKBbEWQKJTHr0ZbsrF63t5O/GKABB2IZ96FEhgfkM1k3b/gUX8LfgCAlII/Z8itLm5QyE2eAJOjmDgkBjX8IM9rmf31GADqWgIgvzvHeeui2OITX7/cOUw8beXaZvNYLeSiznCu7F/My8axfT6oigvfGqRbTzSbk=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:10:48 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:10:47 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 01/17] drm/amdgpu: add UAPI to support profiler
Thread-Topic: [PATCH v2 01/17] drm/amdgpu: add UAPI to support profiler
Thread-Index: AQHcu9QVASLot0K76UW2rBwKiGYyRbX0AUTA
Date: Tue, 28 Apr 2026 03:10:47 +0000
Message-ID: <BY5PR12MB41799CC8BD26C5CAC3755BFDFD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-2-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-2-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:09:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 8bf51b73-205d-4f05-4693-08dea4d3be91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 0aGe7JV3kyxQHXv4dX5E+dn3cQ5GTOpIT5UiU5QK/u/RHmK/7/IMTUabx+BWD9d1pYPik/4n0aYJs0tnGWg0KGMveTytDlG5a6CevoUie1IQxHt7pZ/E83G8n9OnkDf7BK/eWOVJtRtOt0B/Sd1GMT+AkEsDMCxGFa/qQSIQUbaVGEW3KvgVDQGofZBnXc9YcsKjz5jy8CiWM5UMbbpMMvMvdyTIDGYSE0/xLixIpPBOgXsSj5ANzjp5pmGqVddu/bNE7LE/17Ax89+xGPAvFVcAxAuCB8KpQ41xqQ1TdqFOVxMbKY+KRmDP0272Q7jBlYLrwuaw8Xut5kW3icopI4mDqOBc5uQIVV3I8HXa8MVWtR8i3B4ygDsJnoBs8TnjrzRRFt4UaaADwT/ABRTKPUetP3nwbo6A6EkKeyQkV4/sLC5/+kULWLRhI6Rmt2RqUD0N3KsWL1iKtgKoiXY2VlqAXXjpFkWkX4COU4e24sObi+oazbxBfBV70uaU3WvRywB+qcX7kBXcOOStduiIOSrRB77W2HmqMmBlBNyAUfzk35NuIMJIKMPkXp1FwgQNIdROQsGEGWyhlDevNkPEUqn3AY35haHwq2hBeDpNrOQcM+RvNviAvoTE5z2upL5Qiw63ED9JVIfq85JmBfNCq1B0+b5m3F34w64804ixyNLh5wFFoK+zIRsbBix5krs7h8SJbtKjW/vOj11RdYSiz6yMP55AM0YJdsInfbyPZY/Phsp+6ib6cUbCyHrQPXXAuGjODMMphRTZrzX6Wp42LMLmk62flML4UoL9T5sM/H0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NOvpDwYYk5hYANp39Ns46+z30XcUK4DlwsvpG3d8C5shN/stw6kyKh3YEDIi?=
 =?us-ascii?Q?KV5hh9C9tjdI5lE69lAOM284K4xgQj9seg/Fp9q8vg8v/ctdAsKEaQqcZu0O?=
 =?us-ascii?Q?9id63rJr12G+9F0K6amZogndOfK49P3SoJwReUwq3iOFwbi897Wau6JSyJEc?=
 =?us-ascii?Q?PeDTmfWUjJMAK4txjcFGschR7sfwDcojnSgMfYYH3CZ1QzIezMn+kD1EpsSl?=
 =?us-ascii?Q?sLqyIxVxe9r+RWaovr5uzDHpM4p7dVb7WL+Bf9TVoSrvHEgEf7l5SRLM0c0r?=
 =?us-ascii?Q?IdhSMIaFz3S9TecGTFBlz15bCgiTJ0zytXRJ75K8KeqW1CrypiGS/w/CcRsx?=
 =?us-ascii?Q?qqmBJou03dcJvjraJNfLrAsojtm0M3EuRapnTfCmNjdhmmgRwbvQv8sDqDs9?=
 =?us-ascii?Q?VgmO48ZB8I95R7tF/ZWZ3pS5mx50ZdwgbzodRwFWVKOQwrEmNkc1kFL0xFEO?=
 =?us-ascii?Q?+Sid+XkPbVMHWcT9gdmLw5VbGLxbZ5IwalP3TYH/r7zUAZa5lfyeNd3CZuSQ?=
 =?us-ascii?Q?X6GXGgqt4lYR7s6MrTBYX08w7Qi7wjA5inq/e2fe/hl6HQvuoMKDp04mglgZ?=
 =?us-ascii?Q?MMNqhFvr8q4z5ABeNrxrCWosSPBPXKnf0LWNlgUfEu6TLN2agicPRvygtgVc?=
 =?us-ascii?Q?wECCkqndpyN8LvF2kIXbO0CA8dUHfYINcCcJd/ObTW7KDS/Q4natrcFWktmZ?=
 =?us-ascii?Q?f6mJvM/2WQYdvyColqy0Hho0zTpitrZY+Q3J1ia5zALLkZ7cvo33ePZBg0X1?=
 =?us-ascii?Q?TflNk6Iz2nVqmKUUQYUKXDRmkf/WI79wtZ4/nXjP9w22DremPxejJcS/pzE5?=
 =?us-ascii?Q?U49awSi9VA/trJLAiRwQnyEGpNcs/5ti4d1Kf7dARZJAaV9pVHzt64f/qrXy?=
 =?us-ascii?Q?lGW9Oe0IgkJTfe3ThZY+Qep9WVU+kCQwiDAYm3zOEkood/PZOIHVkN3LWO4o?=
 =?us-ascii?Q?9BFb29p3/hz01Genji3uLPTP5+7LeqE67YtlgDUzGb6jJeYFmNnEsk4fEKa1?=
 =?us-ascii?Q?oFpHil2BXUo0+1uv2mWsekeyANpc//8JK2kab60At7y8FIC/Da2x5a7UVWCD?=
 =?us-ascii?Q?6+qMSlMmhIpXb3brm7rFuP532NVTJC6qnTYGDw1YVeLbrLFhDOhIyHGIFrlj?=
 =?us-ascii?Q?qis2W5+fcNvmUrfS3viH15RxSNHr4I6R7+Mf656pjxeBXBoafNRNVpRXELRX?=
 =?us-ascii?Q?TQOqI6smV5x/4v5bgmbSTiS/pwV49lc+miORTvNK99qoqz61+kBWY0SvuOfh?=
 =?us-ascii?Q?Gfv/5/8RjfvdETLU2o9uuw1lOG+HTCoc7AMY1WVLmop7QLCo/CAPxflGUIbE?=
 =?us-ascii?Q?b1jU+IU4RcrO0omkziDhHhoZkUlwA6jgMBMEkWM6PIOWt1oQ41ws07NTcAnI?=
 =?us-ascii?Q?QU/lHklC15236t3lE7fnI/2agT1Bs4fAZqWrEpJtN9SSeUOp1YqKUnGeSrKx?=
 =?us-ascii?Q?KbH5C8DnaeQrQKd05LazWsB3UQ1TW/eRRbCPTosn8wUQBiN3nV4Cr0SBSqVs?=
 =?us-ascii?Q?Q2sciUjbl/BrU1a9FWSOikc37z2HM+6JX/smnqtlr6Qt9owoj7TpnhER/p0n?=
 =?us-ascii?Q?J3QD6ThfD4Fhh/CMz0WubNJ0yfzESQvkgc94cUtHj/8jD0028/Rdjap5esfd?=
 =?us-ascii?Q?BJ1Y99D+r2Fa4s5Lj/9IY9vRqUAn8KwV3myWdFXGigYqi/xvDpTlC1A4aZ1D?=
 =?us-ascii?Q?I9u43LTo1xF9oxaGygPOet1fuJtstIB+G+OkUeNmlMBVO1vw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf51b73-205d-4f05-4693-08dea4d3be91
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:10:47.5260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTfJiELWgfcOF0Md18Lz3+z5eiu8gqLwkijO7lSAM+Fsbwd7nP2SWwj1NzpCKdhxEKdEyGpICq6fQqkUGlOEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 01/17] drm/amdgpu: add UAPI to support profiler

introduce a new DRM ioctl DRM_AMDGPU_PROFILER as a unified entry point for =
GPU hardware profiling features. The ioctl takes a drm_amdgpu_profiler_args=
 structure which carries an operation code and a per-operation payload unio=
n.

The initial operation defined is AMDGPU_PROFILER_VERSION, which allows user=
 space to query the profiler UAPI version. The version field encodes the ma=
jor version in the upper 16 bits and the minor version in the lower 16 bits=
.

Subsequent patches will extend this ioctl to dispatch sub-operations for SP=
M (Stream Performance Monitor) and PCS (PC Sampling) profiling.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 98528d81d3ec..2f9a5ddfe658 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT          0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
 #define DRM_AMDGPU_CWSR 0x20
+#define DRM_AMDGPU_PROFILER                    0x21

 #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -82,6 +83,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_=
AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)  #define DRM_I=
OCTL_AMDGPU_CWSR \
        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMD=
GPU_PROFILER, struct drm_amdgpu_profiler_args)

 /**
  * DOC: memory domains
@@ -1795,6 +1797,21 @@ struct drm_color_ctm_3x4 {
        __u64 matrix[12];
 };

+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+       AMDGPU_PROFILER_VERSION =3D 0,
+};
+
+struct drm_amdgpu_profiler_args {
+       __u32 op;                               /* drm_amdgpu_profiler_ops =
*/
+       __u32 pad;
+       union {
+               __u32 version;          /* lower 16 bit: minor. higher 16 b=
it: major */
+       };
+};
+
 #if defined(__cplusplus)
 }
 #endif
--
2.34.1

