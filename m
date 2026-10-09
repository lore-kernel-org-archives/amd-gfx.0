Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC0CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F35310FFB4;
	Fri,  9 Oct 2026 09:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i6a0hQbl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1B510FFB4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEFm6rJ93Lgax7h4Dt0xOPCOLDMMEB1W4JdWH04FXPoAQsS0X8DDLEvpPYZOaSHFdxsJkkfBnQF4hbc0Wa/NzjXtOoOYWtyL3wfWHTB3lmz8ndghX2Gm5Z9KrShidyLbFrp4oZPZk5QgeyMoVmDRcNu6HNcn2uxmrrBi3m1R0PvCNfpEGI+oeOa3vxS6T31tpGGw4AfTriaAoh+1aoow/s3kFa6QQwVFSoy8NmWrMIvikEi4ZGcBk7LmADKIbCGVhlDE0l8kdMHAaiL7O+r5nibLVCDNStHyDD4FsRwxK6DqE595dQ4KqtlvjfALG5Z4Ubef97FVmyKb557EHZW3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sERFl88q7yR7QFOoh+WHZgYJBJTlzClb6pdJH6U+JFI=;
 b=yhfEzRZjj4RQjh0GcxAqq25srndMV9CaTORqeS88aroeFmzMqJTUuTISyw+P2y1D/gXt0hMqOxx1O6NQ0htTVtmDjkmF+//7MSmgDh4VIIFTXpPl0YaimC46YxTJVX4urnDueq6w/QJAGmDdm0gyx5K59YdaKNzZ3WKBRyi4Sgr7WFBg2982nN1hhml5neSkz7QDE5FJ/Eh/m1rcwohnyd4WCO9+jGHWMlLskn59b/ZRlidqif+glLZdkOBzt+6u7lvmP2tdTUu1rd9W50r/GUPn7RH0xNb6bs9Tkl+ZeUeSaiQLzJqY1h0/Ed74QmVQzR8eaOZEVW/AvDbEmrSMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sERFl88q7yR7QFOoh+WHZgYJBJTlzClb6pdJH6U+JFI=;
 b=i6a0hQblYOxDm/0+pwxuiV74kglKfC5cH0iizz0qDnVUhEdS0A09zdNM8bzc2xduoV8Imph+f6NuqDvqWOIVcSubxt8pVXw1jnRcHbawXBa6u8a8IL1K/iExt11udAcJA7uOe2PqqJswFajYBSB3KWx00pYbr7HX9LwQ2bJv+40=
Received: from PH7P220CA0108.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::27)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:08:45 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:510:32d:cafe::1b) by PH7P220CA0108.outlook.office365.com
 (2603:10b6:510:32d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 09:08:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 09:08:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 04:08:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 04:08:25 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 04:08:24 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <prike.liang@amd.com>, <sukhatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: return -EFAULT from AMDGPU_INFO_UQ_FW_AREAS
Date: Fri, 9 Oct 2026 17:07:38 +0800
Message-ID: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fc0219-cb95-420b-2ed6-08df25e4e9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SFbXP/a+L/xCrMJejYpuuzRKBsWklfwq0DyM062JozE1zDhimY5zpvI5dyfTc7BlHHiH96mdta+9FmiIoEhSC67V45pYLKYbko8oe9+1lZvTyyfTAG4P2yfenQIIHj9CjRE1S6sw7SGzCi0Vd+3KbJ1+7WDx74Y6J00+iMikxddmECfXfZ5hx9YPaP9Tt/f6J893DMOU+j8S0QhcjMcvPUP5kxDqWpyR9CEhFL9FXDcojPsZ8c0AOkndTK8MoNFhxUscBqw99LxwlvvdhdL8/5GVacuWPMWqm2C4oTe1YdvPHoe2TvBB2QL8Yqb1MOYC1X+nGw/EYwh1Eh60sM5WLPVof+KUdHYZKu/pT85D1tVMf21h7hLejNE8qHnR3vAf8t25U7qEJi/nJDnEUGh3g9R/m9K2YjoXlcRcvimbDSKclaP5cDK7M7y4QGwMUAjkm7YfYCYTqAszry+yg0NIUQMtdbRu3+SoP5rHeGrV+rND4ZTvgYfwuGHyyk9dcJVaUIcNTXiVY8HtO8DfmSZTX316B4dZORTdNqRy78YaAwyibisTiR2xIdc5YG4kOd843pByFouSJvUMQLNfafAZhwLlWhrf9jxGJClHT04nQsaniJqGr7cyvlLIEqRf299JYLyhOlT1Yvy6gG0aVMQbweqJuugt8s3LTZgEGs4RsqeRPBlcaGEcFWJP5qgBe+m4msoEQ9B0Dso5scega/KuQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q2OLXe+wLfa1gsu8tvADnp+uzRheBnbjHEUJrbfM63in6A1cZAeSFuTA5HffFZuq9U9fFg12BWL+suXchK0ztrowD5wEf1xqa8y//K+NQwWHGmqQFQ5RonRJ/fqxf5NzF6ABHRGfF1+XGZTcTrs7bW/eT/HK4Vja+KlNPAI08/P0gTJL7qmHIz0TJLzWZ70iejQBGd4VxzK0rOqbVBnqIrnBT1flNsjhG9uCieoD5jBw+3EV58FV17MQQOiMz5dqBr5qSl72i8W7R8CYDkZ9TZZU703zBvcaIPmSczLQnFma+/LWQpZvuZ3sbUZ8BDfZbyERXBuRLBEZRzcu/bUPlHVP+XoQaxXLdwdSGdZ4LFnH+e9mctEvUGgAtGEIsSO25vLg7k4x2dPl9ZnB43Sx8ohQKm8ZeN+0ukdK3aEuob/BCA0oRffuTXD9CytCtH8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:08:41.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fc0219-cb95-420b-2ed6-08df25e4e9db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
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

The UQ_FW_AREAS query computes the copy_to_user() result into ret and
then returns 0 anyway, so userspace never learns that the metadata was
not written. With an invalid return pointer all three IP types (GFX,
COMPUTE, DMA) report success on Navi31.

Return the copy_to_user() result like the other INFO queries do.

Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for compute")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1589b6a6575f..b98091f31dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1430,25 +1430,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (ret)
 				return ret;
 
-			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return copy_to_user(out, &meta_info,
+					    min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 		case AMDGPU_HW_IP_COMPUTE:
 			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
 			if (ret)
 				return ret;
 
-			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return copy_to_user(out, &meta_info,
+					    min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 		case AMDGPU_HW_IP_DMA:
 			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
 			if (ret)
 				return ret;
 
-			ret = copy_to_user(out, &meta_info,
-						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return copy_to_user(out, &meta_info,
+					    min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
 		default:
 			return -EINVAL;
 		}
-- 
2.50.1

