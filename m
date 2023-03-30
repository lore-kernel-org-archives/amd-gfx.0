Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC2C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B7910EFE3;
	Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F38910EFD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzVSd13IuZRaUoY/26plfrSnzds2OAafMvl1nex6rfXmB//fjob28SSSNUBiTgJQy/3wTgPu2dSvdlaoH0cUXfpB3oR9boURUwqj9OdqN+3nMdWJz1D+0WUkZByAiPIgPTv3Unb/AYH6nZlgqWhvyDiLXS4TTgHD6KMSxM65fN953f7a/BhVQOJpT78A8UaBCojH4Rh9k9tP9yL9j2m6rKUwuitfYQ2hvTBEKbYZZwteHGLt8mIqgvrGe/VH1tuYZ/fckxtbglmnD6NNp4E9uRRrH2Bb35lJUiXqFQnx9xZbKExSD0UpcUYPZNaDAcQXCBYm++5BjhsIC3PmFPCNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxVH0PoOmXYFVQ4bIkQBrlTHQiBzcantdqW5TjvD5yA=;
 b=E3OksUVNVWniMIrIVjGasNBOQB9tBOvmKA0gKl+3l2lNcVUILa3sspAci1yBUoE5KeaoIZwwXI16FdWJ/ZFHJP8gohGrTvnSZtaMtK+AJV6KmUcPd0JVpHOdGZAa/kCU5FA7m3x5T5OSkXqx9kWs7nzeTzd+3vQH1IyVgk/zw66QfqCbe9iCC/J9+ncz8XGt/6kBEKi4E5Fuqh8Xwm2MvWLUEN1ApeNZ85fOFiKzkc57yowfo/RDnNU0k9ypH0wjykWzGwwTi8amlFuaa/2fmPBolQ2fTg42MqYL0Ng4RbSkY8LsKE6mFHnGlhrdCNI0VefzlS6La8uQx0kNOMtgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxVH0PoOmXYFVQ4bIkQBrlTHQiBzcantdqW5TjvD5yA=;
 b=bmcAfvnJdrQHgtHCMimczi6G8W+pEdUfxrZxI7MQ69Yr9Mamg30LXDj1ivdgLaOre2/ZtwW6A/z9PAV5XEMTVhtZ0rGDKn3xuIK49RSQZHAWjtVEht48TX4Z7zYzTJZ28LI60m3P+GD3twAq4Sh+jKjnyu+px7DW92/PpHgquMM=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:32:24 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::f3) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/10] drm/amdgpu: Add GFXHUB v1.2 XCP funcs
Date: Thu, 30 Mar 2023 15:31:55 -0400
Message-ID: <20230330193158.1134802-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc560f0-710e-44ed-d5ce-08db31557cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61DmTCpUW9UbPmapnpEvWV2nKPnX3V6V3M5X3jxMBzaJtqXSSrbwRb1+E9Fzge93VV+Mn4rXFhiHmJ7X+614yUWPkNS3XQoG8NE1F8if/u+fQfZRwlLjTfZpk5AaJp9/d1nTWJBCJbdpjGTB7lkvUx0Bn0Eno4I/+TelZA1nDHZaRyLg+3CJV4GeTwAidCxBO9hKTFIV5dFM02/102dl2AiS5FAA/Di6bQQ/14dQlwUwYRFgwAPpe0SFX89iHi7jd3E+EZno8LtYJBJY0MiAnacbXZOifQvpQs/WCu3KCaq37Md1YbpD59ecskXkJ93PxLnBq1Iyu+rXBNVW+86P1LI7qHKkGuceCSpQq6LskV5iVyAQU8mZwhSATXmAdL87gjVZrG5XeuVGbsBWcDVOy3LURi1Hx+Ib/UmjMdtRV2mLsI2Gt7ekoZy8/AQf+1N9Jt57q/L8glnSNowLiaAZqmp14N7DmX4qeg2Xtu/9lvYUjUly6X6Z1XA0zAXataLzW9+ePykto6Ph6hgxHx8WKF8/7kRZHpHz63NvlEESgvC2lhE0LHOmhMjAxcl1K6BCJmIilXddcA8iyGGJ/GDHVcqDQVvXgp+j+LMtGHeDjA5w0S81DPRMmi4cEy20pSxzWP9fp7T9z+k2TUWj54hgJmdw3/Uw1eL16rh+LuasYFM6bMv44EDyy/UGvy/nc2/Xmkxo8tOSrhuWBXWS+Zm9tHOjE1p4+SIo1rZ3xJ6e4po=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(26005)(6916009)(1076003)(478600001)(54906003)(316002)(70586007)(186003)(36860700001)(16526019)(47076005)(336012)(83380400001)(8676002)(2616005)(70206006)(41300700001)(2906002)(8936002)(4326008)(81166007)(426003)(356005)(5660300002)(40460700003)(82740400003)(86362001)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:23.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc560f0-710e-44ed-d5ce-08db31557cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add functions required for suspend/resume of GFXHUB instances which are
part of an XCP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index b9316bfb7263..8ba59ffe0e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_xcp.h"
 #include "gfxhub_v1_2.h"
 #include "gfxhub_v1_1.h"
 
@@ -638,3 +639,37 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.init = gfxhub_v1_2_init,
 	.get_xgmi_info = gfxhub_v1_2_get_xgmi_info,
 };
+
+static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool value;
+	int ret;
+
+	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
+		value = false;
+	else
+		value = true;
+
+	gfxhub_v1_2_xcc_set_fault_enable_default(adev, value, inst_mask);
+
+	if (!amdgpu_sriov_vf(adev))
+		ret = gfxhub_v1_2_xcc_gart_enable(adev, inst_mask);
+
+	return ret;
+}
+
+static int gfxhub_v1_2_xcp_suspend(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v1_2_xcc_gart_disable(adev, inst_mask);
+
+	return 0;
+}
+
+struct amdgpu_xcp_ip_funcs gfxhub_v1_2_xcp_funcs = {
+	.suspend = &gfxhub_v1_2_xcp_suspend,
+	.resume = &gfxhub_v1_2_xcp_resume
+};
-- 
2.39.2

