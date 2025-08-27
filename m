Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A065CCA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 14:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4247510E139;
	Wed, 27 Aug 2025 14:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COS2rfgd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0466610E0AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 14:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmQh8ebF5m/lEUoCDfFIFqEydNteW3yizKLvkxmpgXnGDTMsyn3F6U9rXmoPaG5Tle+OSUN/AfCHXtOe213WRaqzaeschlx1NVH5YNOD5O9FKusKnPOxxL3PuvYY+K40ALEwvU8E3n14nWpCZYINvvEhKkrn6bj2qnm6KPyfh+ZuN30qqX6Ohlms4VXvZSlhewfktArFfBhGRkwgUr2ZtMMLhEGFOcoptOmxywbTq/u0K6nd4xeE8bknScqwyP+4fK4DU4K2eTm75l2Z2toyLkVrzMeeF4C0gQdsVOJBqq3i/miaSPLu8QFrLhgvVNV6sXl0U38dBfTO1m9fZGjqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1NOIr/Z7b4oHql3BTAmfPIDU9HmoGMc/xQYsDlROrQ=;
 b=oWCj8cfMQm2HEEmpsNn4skLARYok7MKjJNJxqGYBZtJJWN/bjvyr3EKXNVOjSOCxCXN+Y6sI0QV5MWOF6GPVv+eCoSC5mGUfDLC0DXiWZ8EKSV0PS/rKSsaapahnDN67EqiYu6b2/FhXxleVuiLbADHXlsJINxu3tXbWsu3Zpsm48NNRMlg3TqdRUQJ5y2Rx/3ND8FpW5BzpSu9mUTj2ZsTCetFyurgP2hhcyeBr7SrDiJxIGDtNyhxnaCpH8324BAN9ZRbojCgH8cBEuU5F5jRk/nn76HuSk+dZyCF5B+ny0ajJe8FOTsxSfTAtFZmkuTnz4AbaMU7C2X+idJN9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1NOIr/Z7b4oHql3BTAmfPIDU9HmoGMc/xQYsDlROrQ=;
 b=COS2rfgdMsFfzT2HKPRkRdKk+9wKwpXjdMjpxzj4ryG7NAjFxToRLF/0PLnuZke5px/oyXMQk/tQSvjSmUfE+ngXNtD8JDqAte0a0vCXNX9X2Bw+CY7taABpnDluLzAqt+Jhbngqns7BaFQYzpxXQe/5K30YCFjS2XcdmsrJEpE=
Received: from SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::16)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 14:19:47 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::cd) by SA1P222CA0079.outlook.office365.com
 (2603:10b6:806:35e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Wed,
 27 Aug 2025 14:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:19:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 09:19:44 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: unified amdgpu ip block name
Date: Wed, 27 Aug 2025 22:19:33 +0800
Message-ID: <20250827141933.626717-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e4855b-1da2-4f99-d41a-08dde574c646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8c0X/UMM98ktY2VktP0HmYv63tFaCV854yvicN7jdqxRqXo0+KvG4B27iXq1?=
 =?us-ascii?Q?NWddJ+KEa6si8C3WZQpa/jBtY5s/UlS0wdrbuK8mhx2Xh3o/NvYLAyI1yE9H?=
 =?us-ascii?Q?sr1MBi2j/UAZKKh37H794hWjwUdl4wJydWxrP8L5DI7CVdWecYhlPzn+rYPr?=
 =?us-ascii?Q?YewQZsB9wm0dbi+dguTGOeuSG6E+k0xb7KJAmnaakhNI+agOAcRA8X7eytpg?=
 =?us-ascii?Q?Va11eRdt6p4BPXHsKav6RtimO94PGk06/8RoZYK76oo7ui+A5Ws5IRcqU8q5?=
 =?us-ascii?Q?Jv0jEyy/WrluNiSyeyNkQmZ2XAefxQB06HPZNkFWCP0hXIsZklCx9z6I0EPK?=
 =?us-ascii?Q?rE+GnBb0Q9daUQaIto/zMkTnKv65IPP+siikSIJ3tWBpWws3le+Ad8PIUgkK?=
 =?us-ascii?Q?KZOdIDXvVTPpqW/9CTvBs8zETwO1lttBQ5RPD4spIUhIIomMIZIbaNZkcJmh?=
 =?us-ascii?Q?VU4CKih3g7e0271niooglXHaMbf6crnQlPE791wETZEywv8D5HX0824Oav5z?=
 =?us-ascii?Q?dkU9XmNpeSO/sn1ormTkU+c7lE8To+CBA9THfDkPzI25loMQP4Xd0yLkvk0f?=
 =?us-ascii?Q?urcinEsCEysdcKx9VRkhW8w3sNB8JcSEzEIGccGcvUARWw8vb89grL0fKawg?=
 =?us-ascii?Q?/38mGxubsL8QO/9eoyLjDxTTCQToKw126FUxTmngHvReLNwBMM7pIYzxg4ml?=
 =?us-ascii?Q?7oFHnHajCeMKJVq3nn/1Ujxa3acUWD1r7QvfwEK7T5F4IqYC1F48Udz81oFU?=
 =?us-ascii?Q?8XR+xoAvhlCuDVBHeAmdDbOmj1SdB94sPoRI40gnd+oMl0RQ2pS61/EmJMAw?=
 =?us-ascii?Q?FDZkl47zS/lhzKBLL9PfOO7ZxJ+vCa1Ph3YTNmCwF1hdZ0qm0qfjBwAIWwt0?=
 =?us-ascii?Q?G8mosPT5p0Uv9fqiVa+cYX5UiXmiCV7Y2sgkLP6gvcDbz5LwrxUFviZQEd8/?=
 =?us-ascii?Q?wtVpTaJtahy7Io7+B1+Vm2W+Mp/MgjAkek+km8TZGJ2v8XdPHnbD0Jpx7Jud?=
 =?us-ascii?Q?Mq8UXJKAHw/xbp8wCJjgAh1CXW3MJcJl9Dnm+vYHGiEP5EDbi8DXt+Zu/skb?=
 =?us-ascii?Q?iGlIWY4GvUGkyYZMo7McObxy+2Fq+7MsrDTGdrjUWAQVcdHsBtIfyXkH49mM?=
 =?us-ascii?Q?RLkZwu95Ua3LmECHestILl8IugqltVbYkpSVmx+apkbeNj0bjXuxSm2XMMpX?=
 =?us-ascii?Q?G4GG6x11OKaZyBtet5eark6VmN4Pu6oXiKHYkCU3j2mBue/6yXqQQoqe4ZTs?=
 =?us-ascii?Q?y30Dll5zKvGIEgnC+GseQUHpSdHgdyQolCP0uC/2DzMhlNKhf1TUAySPEgRt?=
 =?us-ascii?Q?LluAUBVlllhVRjXPwGs62UKx3QAacmyHf4RyOOY9A2C4m/iJmCIqnPwAsysh?=
 =?us-ascii?Q?GkCdomHlAOVoUjomIvBep6NNILTcGEPVZhEsAf+2ElRkStgE8cWi/hrCjea+?=
 =?us-ascii?Q?7k1EVidQVPsyNEs+ZF6d7U7W5jS5lp0yylF0nof3BImTIcUuvJMuAXDz+oBJ?=
 =?us-ascii?Q?2srsbh9/q6uT9e9A3WFjGjSCefKYAvaaHUQ4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:19:46.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4855b-1da2-4f99-d41a-08dde574c646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
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

v1:
1. Unified amdgpu ip block name print with format
   "{ip_type}_v{major}_{minor}_{rev}"

2. Avoid IP block name conflicts for SMU/PSP ip block

v2:
Update IP block print format to keep legacy IP block name (Alex)
"{ip_type}_v{major}_{minor}_{rev} ({funcs->name})"

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e117494e8054..d869226b2fa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2447,6 +2447,33 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
 	return 1;
 }
 
+static const char *ip_block_names[] = {
+	[AMD_IP_BLOCK_TYPE_COMMON] =  "common",
+	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
+	[AMD_IP_BLOCK_TYPE_IH] = "ih",
+	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
+	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
+	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
+	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
+	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
+	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
+	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
+	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
+	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
+	[AMD_IP_BLOCK_TYPE_MES] = "mes",
+	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
+	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
+	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
+	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
+};
+
+static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_block_type type)
+{
+	int idx = (int)type;
+
+	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] : "unknown";
+}
+
 /**
  * amdgpu_device_ip_block_add
  *
@@ -2475,8 +2502,13 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		break;
 	}
 
-	dev_info(adev->dev, "detected ip block number %d <%s>\n",
-		 adev->num_ip_blocks, ip_block_version->funcs->name);
+	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (%s)\n",
+		 adev->num_ip_blocks,
+		 ip_block_name(adev, ip_block_version->type),
+		 ip_block_version->major,
+		 ip_block_version->minor,
+		 ip_block_version->rev,
+		 ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
 
-- 
2.34.1

