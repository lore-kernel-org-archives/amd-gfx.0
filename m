Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FB5C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 05:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92ECE10E56B;
	Fri,  5 May 2023 05:29:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2ED410E56B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 05:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USERbw/P5QDoTO+c30QhQXN9844knZJZLMN+X7bkuYl1ev5YjumIoFDYLVj6ymhRrT6CttJbpQygxpARVBDqPVRVrWU7wgkoPOo3HgutAvwPMPezoY4VGb3VU8109Ck0uX4wyG05DvQS1u/cz9n9qsAUwW6uh6FoPyTjAP4SZqgc86Jc86r54NDm13qcCBMeZlzvW5tnnBhyFFsMS35XQ7/Q9Ao+yvwF3bi2QH/NpctfJ8cPvUp42IW3wlVFpQ+4f2o3AeVlgl5xpL7vpYq8XDIcXtjKwYRG5Ky0YJWpONXNGpcS+3oqB4+uo3oaxPaWICcSlMwQ61Umalpvh0Jadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ILl6m9h8hrGBVbimoPmIzRGbyhdRQyDizDxPKKtzYQ=;
 b=cGtb7Gi8srJ6XZlTrZk2sZbqzdKaN+khjc0JFspdN7pHApzgSjarXV/wVOnZnuSa8fbim77hEef7VL3Pp/0yn9ZI4q1AowRA/seum6BQ20xGx69ubqnDV2HplWzrG90jan1+3UdCYUv+mGKeg0AzYVRZfFQGyfPGrklm/Q9LyHyvsjBLq9WMgtcmq9Mcm0vNNdw0iFM7n4tkEJ1RG04K/kBm4SAEZGK9/6Ct15m3PNgqz0C8tNSlCT4Qe9OLkTOXWwegyQdc3bUul1oGxzZgD5dHT/bY3OoaLhE6C9xNtGpLCK4JTlDvQiV+3Q4Y0RgnySpCrvdLjHN1HQeo6gySWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ILl6m9h8hrGBVbimoPmIzRGbyhdRQyDizDxPKKtzYQ=;
 b=u2tOGhIrGiplssA1+Vc16y3fv6nxK+0zuQ7IWX6gthzEoJJ6es6Qvp/mjaX3DPdH3E6leQ9d3BJg0kfkby+dTC7EkHwRKzCF//mP5aI1pdxQkmHq8hDRb9FRkNZmiQCRCL5DjsnwvyOXyEiGkTquO40jr+Rr67+KK9UpYFRt8l0=
Received: from DS7PR06CA0011.namprd06.prod.outlook.com (2603:10b6:8:2a::6) by
 DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 05:29:39 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::86) by DS7PR06CA0011.outlook.office365.com
 (2603:10b6:8:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 05:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 05:29:39 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 00:29:36 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: enable vmhub bitmask on gmc11
Date: Fri, 5 May 2023 13:28:45 +0800
Message-ID: <20230505052846.1489935-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230505052846.1489935-1-yifan1.zhang@amd.com>
References: <20230505052846.1489935-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e946bf-7fa7-410d-eb9e-08db4d29b8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQHI9KtZDBuj0p7sEobZPniFohfgUuP0SUhWyGaFgLOSHff8HNs+PiHeoyG5Yp3+S2QosOMofAvNln3L0IKvF8zLz+ELGu0f7tNgxITIbPmsjb8jfkLB2f9s9HI+h0rodJHvYKrfK6Cgy2in/C909RS9Gob0WV0Czw1oOerDxdMXqOPX2vouS1kVcifPG65SdaFBNwcPY+qMNgBbO0gPGWgh+Y0skbpZ5FiqwzXEd9+E9wfQapmN0rZ/c43MFkjQL1A+ZEbwJFTbydhqOn5s4TgmbVU4GFCUy+1HHx8kgMD9i4sIRARh4VFv7cRyhpqrHgaCK5HwGNH4vMJRmXUMbV9UGYSYaXjNCGI/hf5UfGe2z3Cnpm8NpecrnSww1/gWbH9u4Fo9x11IDxPm7OKQcqS8XBl8lTYT8XQGVAS4B2j1fFZIEKGA4sMVtIFher0PQjLisDxXv0QUNY1v4PyNVJmL0aEr7dy4rfsmfsWZl8parKheF8piXsBTZ4uVcmKdlNwuLsnTan0khWfhMSOWOJk3sL0SEb81fdIDUEnnXZf/1VQlX69t7/N8koCymMcCdO/WZFC+Uo5ytyfIvolxmro9wDq9PMgcRnwXhKnHZstSkBnFw1vPWJW1qrv8vjBwUUCpnYZLq8xn1+oH3igaTpuwb1LDUTy2XJIpIzOEUt7mYd7C3d95XPhSCkVY5jNF4GZCjUhPIXA4Bryy0zHa58JVqZPHDDiZqGvJqcuDYu0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(54906003)(316002)(70206006)(6916009)(4326008)(70586007)(7696005)(478600001)(6666004)(41300700001)(40480700001)(82310400005)(8676002)(8936002)(5660300002)(2906002)(82740400003)(81166007)(356005)(16526019)(186003)(2616005)(1076003)(26005)(36860700001)(47076005)(426003)(83380400001)(336012)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 05:29:39.4201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e946bf-7fa7-410d-eb9e-08db4d29b8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lijo.Lazar@amd.com, le.ma@amd.com,
 Alexander.Deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to enable vmhub bitmask on gmc11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 90cf79f8ddde..b669409e92a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -362,7 +362,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-				for (i = 0; i < adev->num_vmhubs; i++)
+				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 					gmc_v11_0_flush_gpu_tlb(adev, vmid,
 							i, flush_type);
 			} else {
@@ -760,7 +760,8 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
-		adev->num_vmhubs = 2;
+		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
+		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
 		 * To fulfill 4-level page support,
 		 * vm size is 256TB (48bit), maximum size,
-- 
2.37.3

