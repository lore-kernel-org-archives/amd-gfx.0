Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0CAF94CA0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5AD10E742;
	Tue, 21 Apr 2026 17:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vh64kMjy";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D7C10E1F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDOCWCvBCJgfZ56D36yqF8wfH+/L0G7whPaCcoHZvSoglOtpNGFq0ihFO4qokML03dp3Xb2E1NyGu/o0+ANr6Xyex+8SiUis2suSBzCi2fBZhkS2FpTjFoKhZuWd+Ms/NXx4f3DyNp1EISUQIexIlU50Gq+WpCjUOyfKBJnehdHzLzoAKHSgZ0di2yRQamTX4nXfJHVZttSBADyphAqP+Qal5mXz51E31/Zu8mD5AT/bTDfIvgDvvDSLQF7Cbt+f1oHhnfUxf6JgGusbAUk1ZZ3QsM/Wdm1t9jMzVPdBiF5u8Z+EsWypYOi7vj5eLgfuiApIz8Ceiz637nAnKcuLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+rQ+RC/FFQZ3lPnOhtKcg1QBPlQ/DwEcia5YNTd5Mk=;
 b=tsHFMBM23JhNWuRpQt4LPbCZJn4Nf0ss5bOW7OqMOQpLbxslTWDxMCnXTPS+QZwVDWSPwnVM5aJAHugrRu2L6voHW0eFuk+egfeB4CxslVSANAyXbhEnHXdOj8IDl6el5i1M9hb/gINXbGCeK8+V+JU4vzon+9WMpoWh3TUF/OvSxzjXD1iwaJRZYDjE9KwzJuLnSLCMY1EGRMWjsHwhKnyedZSpgttMrYZrraemsYhf5W3k421ih4o4ERbTVpfQfFohlMbphUASeqYTIu3RGZXXfWWxBQrAVEsRpuBdrtOWW2Jyj0l/JI0WQ684Uve0+AFEn2yxvoxUo/9dFGdMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+rQ+RC/FFQZ3lPnOhtKcg1QBPlQ/DwEcia5YNTd5Mk=;
 b=vh64kMjyG9/RKUCxmxWBT8an8jAxo+2SQzGzBxmT3hVh9y+7B95vOIVygGJwlT8JCJVKGv+gi/YYp4w47t4CXc26NDhjR/zSj2r2bdVfLqQJWJuv9Vi+he+C8i1kzZ8X7rspsV+Q/nLnGBJFE0YijSfSrG59evwxF4km2MBQ3dQ=
Received: from CH2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:610:4f::20)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 17:59:32 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::16) by CH2PR18CA0010.outlook.office365.com
 (2603:10b6:610:4f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:27 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 02/11] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Tue, 21 Apr 2026 23:28:59 +0530
Message-ID: <20260421175908.2402019-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7d1122-e698-408b-079d-08de9fcfbd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pVIhiLTb8m2f21Zc0IxuHzlJnrcHprDi7VTxu+9eURo9gbPbzW138yJxv3ePO7u6V7fkz+xhMEK2bE/ZDEfPfKjSDfd8SK0Si1ddRqmn5NcfLXxXpeTIMlENTw5LQP/E3qqzIXplix44k97LwnPCwNeWJFcn8TqPDJ9U+L7koUF70nG2mwaYqW2BVpNS3QQeNWd/ZveyjktwJtLf2dciGacY74HZuUlHV6o3oyxkOED9JqFXK+el5cMJYI9Ol6D+p8fHtNJkMmqcgVsYsONxLDNgYTVukjm79ohWhwZk4e2UG5uKBrsAoS+gItfo//fURR1FMytjwlu4XrSOIgcATLxcUj/FrygV3cZCi1dAB/AjTEtBYu4HSEvn6bMA+lf8g4/n7+CMEz2nPpRHpep+T686aYjEyylgIa2CnKyhv5qaWQp/q+7rlZnccZkD9qrXW+nTWyzaXBUbeyN6aU1a+lRgodeloRfjTybF8W0grZgyGUl89b/ToXrcMF0tKblrXkDXV4JhyG2xL3BY7tSF4dqnUbS6zVJspBpyqwwIf/f3mU1W7at9c+hsRR+wkyKOltRBzv2PfEBIb5ehV55gkq55BbsfGsIQOKt3J53MhfXB7y8jOnlWbyo2WYkcTO8nhbDqzMhG1/Vf5BBeNvcRCU1PNBxvSQTSWZZKjhHovee4mmDYu1AjdqHYtQMm6uuBXfVUeyERm3ELU53IQRaBOr2dFfakiHZahw8sE3eOGO31R8fmgTpXPx9EdHkPu5PB2JQmBEZL/2LMXMVvvEKhJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NvuPWzWIbQCJcpYqH1GWruo+c051m7FzkCpSr1eC1QBErB8iiXqFj3TJJVzXJiYyah8opKLvbV8HVTNEyhTKdfwMPb2PQsIju+4QTC8wxQgm3QDNf6b+BtJnx0IZQbB9yYyJ8buUfDDFIi/xicyvbr5gZ8vsmM8/PSxxY5iTOSgqcrFwGLvw9Ryo0QnW2tLhJV8hJNAyF5ReQ4T/xHBGimC6l5GaYY+LrkGrKXCogElKrP0QlQAAL3gTDlF7BpjfPvx7X/9Oz75SfDckWEmn3imyIVlRRjHbKr7vuK6kQ5eoYoUfZNOKAtU1vCITNAM7Z9SsphMEPMkK6svyoBleGi2TH/+4SvcvIbxdNJdBmJcqb0ywYpriro2sV9AF4ApdHz+hKMkbPUFG+pQocZEh53m7klU4V3viSWDRHI8VTpEP87xRIOB2t7fZS9pgt3jb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:31.1184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7d1122-e698-408b-079d-08de9fcfbd0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..a48f8c214699 100644
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
index d88e4994c8c1..7df0e7fb2864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1469,6 +1469,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1565,6 +1567,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

