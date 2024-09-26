Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8DBCCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A9610EB22;
	Thu, 26 Sep 2024 09:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YEQrejOQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E5F10EB22
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePPccSD3Zyu06IwqEXnDwq4Yai5Y/2H3nKQ5oWQX52TidXp2ol/u6SE53VY2WYMBzeLndH3ZsXzTq/fJWZ/VT9ugYB9odeOTz78C/RDxus/d6VjMVjSTxYXtmyUzoZMb7Uyw7QDpK+xuvjBkYhWb5UO8O9aRNToo9inkqZu1sLUMpTVw651S5HvWHGl4e43qfoOiDsRpTDr7aTvAh6Lxh9mXVDL0VoJFg80hsvtgh32RAeeOjW3uquU0stoenN5/DVzAmLY/BidxWFhhdjM7CRA8tWes4IK+9RjKSprlU2nJTRMRhltSnqFaNpvQqSyoArXEYwMUqK3A5Kqth2Q57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9OijqDEnDDj2l1Xxrn1bdguPveELQ516SRQDYiTOsQ=;
 b=SiLoCOFvPOQtaOcWd4Rg0+k0HnwMOdvPV99BO+oPAmNU/9OYtDMzN6GuzV5RVJ7+oXtPEDlurnHQA0QkCYSQrkP1VVqbE0tisHJxUfiI6A0khdTi1kOFbT+NWvC16hoNp4Cldo4Kt1BQbK5CUj/ch+wSh0zH1ccL54niP+E++ReP43OEC5CPh6MsRRtUm+Sr+3g4kR2oBZRcxsNJULKxRJHcQWzVp9g5PBGNxuPTEy1Ma4qbMrerclv4PHAfyP2ZoqWUVF/EL91lwBtyxbc6/O6azd9nn+dhhDL2YvajeFPrmB3cByQkP0cSPmabIdjM9lnZKdImjAeKpLt9vN/muw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9OijqDEnDDj2l1Xxrn1bdguPveELQ516SRQDYiTOsQ=;
 b=YEQrejOQIi1afxVG7AHIS/jTzi/zU50OpR8c4OQseHot0bxIKBBvkSu3g8ZqB3MM96ioUHI+W0/WtDVEDFf027EPcneACktptVen4BR2AH7djICxa6OointZBIzhkrO+KWrtdhzw4PFvO3JOBKYnuEPtmW5hq4Pd5LQb6A+L8ec=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:08:44 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 09:08:44 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu: Add gmc interface to request NPS mode
Thread-Topic: [PATCH 3/7] drm/amdgpu: Add gmc interface to request NPS mode
Thread-Index: AQHbDkamW/y0a5QmlUOuBsXo8DcIzLJpysiA
Date: Thu, 26 Sep 2024 09:08:44 +0000
Message-ID: <CH2PR12MB41528F6071FDF23AA5E5CC43FE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-4-lijo.lazar@amd.com>
In-Reply-To: <20240924055652.2678433-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3e020a85-8c23-4e1a-8c4a-85f93bc16b2a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T09:08:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 995f867d-22d7-4754-bc22-08dcde0ad2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2FkBNp3oR47tirpv22qgY3PH2cNbUqb6D44uWmzyIOHYAtQOX68dQ8g3FrU4?=
 =?us-ascii?Q?3YCQ6so/DlRnluXZW2MJc6YwckB0uonbnuXwRJ79ERGYp7uC3hd/K+HEuGVw?=
 =?us-ascii?Q?jPX+GfpigssTPQyjU5vgxJbl/MQxCqQAa3qbH9TQaWnH0TFMh6IWP7v0IbM0?=
 =?us-ascii?Q?iFrsxxy71CzZnPd9D+3GsrQTWljl72DY7slL4oV2eIjbAa4bqKwJVPqmkCMG?=
 =?us-ascii?Q?98H64d3SsmrHE1Ha5QrOBTEdOXvhvF3kXTiB51CxeeFQEMrz/vx89BGWp2AT?=
 =?us-ascii?Q?0vTTSKtoyHPA8bMOPSulX/jhoMpQhVKk7PatFS87ZOefdhSYdIgyudQ5eL12?=
 =?us-ascii?Q?Eziz7RGRDYanosevrq8zShJ7Z8PON3U99GHA74dqMbkvLk0JZpgkt36cJS+4?=
 =?us-ascii?Q?Q3NMwAse/m6gddS3ZNmua7WfgdWASC4Rka5EUn+czeVlnN1EBWOzUa0p0M+Q?=
 =?us-ascii?Q?VfRCAZU4UiWl8Qj3m/T29GeKKnRFmvbl8B7Z2gTrqwLVMXM48UqYZAxSHJuD?=
 =?us-ascii?Q?gj+Ls2dSAhjtGe/WQcpDEpnwdYIP5C5+g/r/mcDf24RZrrscguhk4qVsB/Gt?=
 =?us-ascii?Q?FBXjo/3LEyoa3c9whvh4ztu4Q6O6gYxu1XEzzCVL5OvOzmTxi88+LA8PKOv7?=
 =?us-ascii?Q?sN/S6Tb7xt+PmmBrVHy494/2jAbZaHiB/Hi9ml4joFYCzls3bK5WY1uhlsli?=
 =?us-ascii?Q?uO9PjL9LtUiXxZjgdaV+pujTm/npV1WTtweNmuSfDlt0E9011/yO1B8ypo47?=
 =?us-ascii?Q?kmYww+Dhb4q50W/76dxjtYrMY4O1DJHCUlPuS/xXTuZF4v7T2d8Lp5EbM5Nn?=
 =?us-ascii?Q?T/5jnG7ByEpp+qmI7Y40cDesBnVpBGidIJZ0i9b1wi8k+FMM4Xs0gDqrSqa/?=
 =?us-ascii?Q?dQVMLpz8iAkme5PRfsAbV1PPSI7FuN9k90aLJiOJ1dEradIhevqvCyE4flAw?=
 =?us-ascii?Q?Ct5I6krWYmGnUc220y0BAHqb+oKu6u38gBOsFdQPlr9k3DqNh2YHmM2IMh+t?=
 =?us-ascii?Q?XP7cOM8rblPg+tsEW5DBDP+ELv1el0iirH+BFaHzHm8B03E02P703T0jcQFl?=
 =?us-ascii?Q?r/F4UMxmsNwAkO52XibXHmmjn31K0RtCFnk9U/CP6gwrDPG4o/2G08e/o1MB?=
 =?us-ascii?Q?dBo1+wNPUglRzHmXKG2n/z5IIppALSq2SXwgTLqXuUVfepdfASdzr/fPc3lm?=
 =?us-ascii?Q?hQZgz2S28xN/Ck7L+dYjRrgPjy10gZo4coZYZoeJidET61ddGshhGPhz7TDM?=
 =?us-ascii?Q?WAFieyTN/QJE3yi352skoTtjNZppS7AHMB9kRdxmYSqW4ivIewvL+QOPyLut?=
 =?us-ascii?Q?BpOAT7nnFcrG+3xEtOX1nL0HqVHfi+V/0lBUxjxW73Z1YSNoBLgIge5J3qk7?=
 =?us-ascii?Q?WN30t5X1uenGpS7b7RGAqW8Nu1RW+1GGxS+YFbs4zDzljs1o8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txff9+f4UxuwJg9Gr3sfbi1K/4F9EX89zgPfvSYPjbkThEJOawDA+w5cPsIz?=
 =?us-ascii?Q?CxcV6p2H//Rxfe5jOgI1s2/9LhkxoKkkhgbI1HFdyHomHLd8VfYkJ87E32ls?=
 =?us-ascii?Q?HQN1ByHb97AGKbgqo+wWIz3CkC3Tt2fEUQ11dbbEsQVWH2Z+oBhrfuWcFh4N?=
 =?us-ascii?Q?6Kp9b5G2auwoG/odZd653XhqRdEg6+ENPfKOurzZD9YPg9ZCPPih7m9tGG/v?=
 =?us-ascii?Q?TxFtvqes30jacZ6Rz1mLLhrKb6GmUyN6RvdssDgQkeoqSSi5oU9PZSi5+Ssc?=
 =?us-ascii?Q?GIvP3IsLSnaCtyQB1VZnnFiSXyaVcQ97erqkjAPTLCHW8f1gmUFhZ2AsxqSP?=
 =?us-ascii?Q?BhlKsLA2KXyRDAyg0J8XBcCPUMY4Fj+33oNnAb9aBXFl6HJW9KnVMl2xIBgT?=
 =?us-ascii?Q?SrHpo0focH9GolXXn+0iGBi3DkwWjQoM+bJFc+5FXNMN1zaJgkfvs3hCCe53?=
 =?us-ascii?Q?MqS0wiU0YIckc1JLwtpb8tFCFV6MrjSPfZprP2YqclJEH5sh/CfoNeFcKmPp?=
 =?us-ascii?Q?7QpesQqhV0VVqkdAyWW3XuMKCAQ9S1ZHIKviLvBw1BWG1JEPh8AYa4BRRiC0?=
 =?us-ascii?Q?Kh7o7/HLMItnZYCkmokIYffujft+8AITq2vx2RjCFAoFy85VX2bibwc8fxxT?=
 =?us-ascii?Q?i9sMuUNslqi52oApuoNqOwJGvmy91RqUPcxG0hmEocyTKyYEt4Q8HRX4rLyr?=
 =?us-ascii?Q?buQUBtjoUCWYG6uf9nXqdfvZOSOtRTrfPSmCLZi5ts4kygbJYvUIY4Khjljr?=
 =?us-ascii?Q?AuYFGiLZfgg0YeLJX6Mk8+LVw45hamCpCSFzwxxK6xSDpqT5FaKxKBsib7eA?=
 =?us-ascii?Q?ALOhGzK6SvJIrJKEE3surwsSUpFXchOHVYuurTi0Imu6loDG1CEQKxNg75vP?=
 =?us-ascii?Q?NVNV4q5iga+8I7yakfhSQ69SwKv5caYsfqNmGx6ck8oXWkbKtV6K1DKhA6hQ?=
 =?us-ascii?Q?ke97KDRFtToyGNCErDSA6MpaiAcrKgRcsHhtp2fmyX2eSyOoeK5nmk19v+Bk?=
 =?us-ascii?Q?72bVk3LZ+JC2WBvBf5WMm2KVN9Z2OPhT8gS7PB8zmDEdikfvIPM6AE4cR3JE?=
 =?us-ascii?Q?5Ft4rCOJiBVOKq/5PmMwtl/djBC5lR1so5yEY+SJqG0gs+f0vFs3dsFuZYtz?=
 =?us-ascii?Q?ij666sGvKrmKGCJ/KzYXJHf84SYtsvRV0OyT9xLsoCbVviBRtjf79cPsssMe?=
 =?us-ascii?Q?XfaK2YgFbtCG/nHdhORBgjUsDdcEXK+COEEbn6k8Ha8ZxW6zSXv36xLlQKxa?=
 =?us-ascii?Q?nuVzMwTCCRPIs8JT7c0GMT+uqDnR8tpS/uidl3+JNvpotJgkDjNZ65f1AR5k?=
 =?us-ascii?Q?HdId2XAIMBd4EuHYJ5K+oxbz/jtm5XWawIss36UXNW7yndo4/YLmk16XyngS?=
 =?us-ascii?Q?RpH1RXi+Xw5vKs5o54Q6pEJMQHuC0gTIkvI2IkdksoHzs7kKrCRgeJzG9xR6?=
 =?us-ascii?Q?2yqI0oqevDe103B92fgWqExJBnHJrvvCLH1A7HGammPF6XizEekziLxG5ovC?=
 =?us-ascii?Q?OJl+P/UAnVQgcUDoawGFqImSUNZMXBeRTbp1rI/rZvP4fkVT0qr5hUWBq0mx?=
 =?us-ascii?Q?XjBtWA8cUMNKiVWt4Cg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f867d-22d7-4754-bc22-08dcde0ad2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:08:44.5372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBmX3ru4yAdtC0qkHJJAPq/g2pxL4mooqCST+Fv2c383b3OTn1RAXyC7gagSWJlm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 24, 2024 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Ra=
jneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.c=
om>
Subject: [PATCH 3/7] drm/amdgpu: Add gmc interface to request NPS mode

Add a common interface in GMC to request NPS mode through PSP. Also add a v=
ariable in hive and gmc control to track the last requested mode.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++++++++++++  drivers/gp=
u/drm/amd/amdgpu/amdgpu_gmc.h  |  6 ++++++  drivers/gpu/drm/amd/amdgpu/amdg=
pu_xgmi.c |  1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 4f088a5368d8..758fda4e628f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1247,3 +1247,19 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devic=
e *adev,

        return ret;
 }
+
+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+                                       int nps_mode)
+{
+       /* Not supported on VF devices and APUs */
+       if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+               return -EOPNOTSUPP;
+
+       if (!adev->psp.funcs) {
+               dev_err(adev->dev,
+                       "PSP interface not available for nps mode change re=
quest");
+               return -EINVAL;
+       }
+
+       return psp_memory_partition(&adev->psp, nps_mode); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 33b2adffd58b..f5be5112b742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -161,6 +161,9 @@ struct amdgpu_gmc_funcs {

        enum amdgpu_memory_partition (*query_mem_partition_mode)(
                struct amdgpu_device *adev);
+       /* Request NPS mode */
+       int (*request_mem_partition_mode)(struct amdgpu_device *adev,
+                                         int nps_mode);
 };

 struct amdgpu_xgmi_ras {
@@ -304,6 +307,7 @@ struct amdgpu_gmc {
        struct amdgpu_mem_partition_info *mem_partitions;
        uint8_t num_mem_partitions;
        const struct amdgpu_gmc_funcs   *gmc_funcs;
+       enum amdgpu_memory_partition    requested_nps_mode;

        struct amdgpu_xgmi xgmi;
        struct amdgpu_irq_src   ecc_irq;
@@ -455,4 +459,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *=
adev,
                                 struct amdgpu_mem_partition_info *mem_rang=
es,
                                 int exp_ranges);

+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+                                       int nps_mode);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index b17e63c98a99..5d721ccb9dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -667,6 +667,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct am=
dgpu_device *adev)
        task_barrier_init(&hive->tb);
        hive->pstate =3D AMDGPU_XGMI_PSTATE_UNKNOWN;
        hive->hi_req_gpu =3D NULL;
+       atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE=
);

        /*
         * hive pstate on boot is high in vega20 so we have to go to low di=
ff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_xgmi.h
index d652727ca565..67abadb4f298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -46,6 +46,7 @@ struct amdgpu_hive_info {
        atomic_t ras_recovery;
        struct ras_event_manager event_mgr;
        struct work_struct reset_on_init_work;
+       atomic_t requested_nps_mode;
 };

 struct amdgpu_pcs_ras_field {
--
2.25.1

