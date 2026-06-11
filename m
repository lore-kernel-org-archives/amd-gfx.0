Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FFFCD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 813AC10EF69;
	Thu, 11 Jun 2026 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U4N6GnJS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5123110EF7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVGAdPeCewc/BiaTa0O46aX8qO/rudF89VHIvrca33hWLGEmFOSiSw/iLD4AyzVErUY5NEtm7YFi1avlXabZg37zM5eZiP+4AMq2smKbpO7W8603COEwtMBak7agtqAhCHTFdnFx1/XXDQdhk/ar+BbGmQ8IBm3OE1cdRVp7D7NhIGW0sNU+CGbqoqZgo39PPgUqJ9AWTfq/aginfH2RyLRkFKz/ANSUf7MyA//ifTmgTekmr/duh288S7SmhdVL2la/bYAYbTkTJAHu3cqeMsnh7j9mlLlSCUU5S5bMRu3MmVCnrRJKz3EFm6JYEY5KYq2fHim+0jyTr4gKmYJ6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=BFL4X3nvxT/w1mGA5WjnEiF9bSXDZxSCUkfZoEDPXEQxTbOM2wB8xV1kRJBnyRhJIdB5TXp8yVbtIGCPxcyP44wWjl5CqZ5oszZ9cRwTH/QxhOcugaFgrcV1dz4YcpRRoOeyfzTycHdflS0vxjWA5DpQmbP4+UiLeLYXp6/5/yhKLVOWcsMu1fbY/b5RHSVGkNgVHDzWgtONV0VH9bN1kDSoGjWLCr9QeFtqFV/eOz/cwsXHiNRHaxHUfr0SZ4a6116K6HzWnxuCBfSJtitbw4gDn95Aj+6M0R+hgTheZ4t09fBSsrlOxcJCrb6NWyZyXm2X9+ens3j5OgdvCz3XgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCHTPmkxU9doroRvnQemzAEp7jNTl8KCCXEux3w8eww=;
 b=U4N6GnJS7nVAU2WK2brGTY/+Qi5hNAsOeIictEAkWsZe6mMtAPjbcv146/ccTXzIYOJ6ypgHtTYQPIwTKWu6+kWTxG8qPeX7BC135hsB9mNNpU7L4sNymLUm/bsQwRXxrVsz6qVLdCMSSva1rQhOqIhjC4Vh1G8bMjnnGPmSaQc=
Received: from BY3PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:217::35)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:34:13 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::95) by BY3PR04CA0030.outlook.office365.com
 (2603:10b6:a03:217::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:33:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 2/5] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Thu, 11 Jun 2026 20:03:23 +0530
Message-ID: <20260611143326.2870571-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2410fd-689d-4364-8fff-08dec7c681d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DWTo5aohaHZ2jejp/mHTxt56ZH3uEb9JSwc92PqdsFGZWerXBUSi1zOsUGwLTcIJ+FAJK0VfjVpv/02+kcTeBHuklsD6gDdNlDlrbLcRIR6SuUBSzLlz3WzKlsorBCrnUR0iZ4VtBxS8ZlyXbxyrVepKBl/WJVWDgMEWn7WCJEyAwDpysjvxY0vWu2UERWSXFk5j05Gy5+9cnq8ySI5Xj5X5W7fGDWq4qqivuTpy8Wm0+CHp/+wxT29VDWS7Rz1hu9RTW7dnc90XVA/8lq8PmFl0N/YauYF48nbMqqBVV3+9j/a+ZWz4xC6ll8HRe1vKXlU6SBJRofVP/7TD+2d7UJazXRJtNETgaq4OqbRTLkSaFuOfVOmZHmqSnHqs7G0Q3rnzAceiJSbMLoqfAIu65wVbfjd81R2EtVG8oPkjsrmFPwYp6ZYU5yCsiP6C661nTbD2Bu9GWzxoxQwAUu56v6Gx0X9LMe7exEctpGrPSGfQtWEFKU6Z/Z+Cnn+vjmCgX5KPIYXKbTiEJnRrsBLGIldl9o02Va9nYVqoo6Emo+dm2re1W3wxKIyqAHOUfADyekgJ+uaGTuOPeMuG9DzqnAkITkrAO4BQ5cFYtbY4TdZ7kQJHAPEOZ6YBVJM3eKHLyC8yOgallC8h97MhhsSRX4hlikwmOPRTXoOFof+TsLTz/YAt6wEf+fXl3LHcwuj3V3Qv8SvS1salQQpahAfTwfF+B0pFwKG7OagjU26Y9fE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zQTAVoeq9n7mcUeG2zX6S/2yH1ZmrrjevJJKZ61k1Hef9LCrF1wfTXzVCjNdJJwHRbfQHaU7JXmy57SkrcAR+Z+GdInmJvySPOOc6LAPZmrn9i5ES6o1XsmP4oNwqjjWpnyweM590HOn3TENSf2uOzRW/Oge8JA2g4CmpDlhslr/74UAB54WTZzR/lV0NgwhEn15OfD7tBALaHPSPbBnyMJLe4WrdzvySwmLQV+o+VOZj77KzCVfMW66kip8AuC/Ri6uY4QniWIpuFShRcZ3XxRt9DUvA+ZgLAGrD4dK3Mg4ZhN6BigqFRV+MVyvv0EzYbCvdeJKMBVbVcL+HYHpLIKPhi7V3/A1pU0YLMAXqML1DHWcpibRMjZsxljuaeITzM6rMLMQG8gTpenJhuBJ/hgNMfXWxDabPJ6g5MD5VZckxHXZJTSMXMlszyGoRfIt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:12.7617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2410fd-689d-4364-8fff-08dec7c681d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
by embedding the manager instead of storing a pointer.

This removes the need for reference counting and avoids destroying the
manager from IRQ context

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..a75c68195df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -455,6 +456,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..f5719500527f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1460,6 +1460,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1556,6 +1558,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

