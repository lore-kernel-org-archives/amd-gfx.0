Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40937C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 08:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18DB10EAD8;
	Thu, 27 Apr 2023 08:03:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B112710E8FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 08:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYKPXdoD3yfUiAC/Tli7VUbye99dRfmJHvecvj4Qxm8hD/QZQ1ss3Suw6t4cUUEOyk5mXWV1GcLe6+cBUG6QySeWtE5PhdcTjzfkdaHipQSkXWVcPz0nlQQoc+0ofdXk1MT+KFfwwkgDFj5SyPt3R/MRh/30Jp25wkZekIGuGhnR6fedh70PcTmw9Lh76mwQwEDNFTeoWMkvquc8tOe6KtS15s2C3d8slGiy8V5s20OhhpQ/IpVpQ76atmdKYzi34ZRQ3qzPyFNpe3soe8rnKzDTmXEsg2AlZykXTq2SN0KGCNz7RmSVzHtQ11/q1WrSugJWD0lHF+Yti4U3jlNowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L2GlqReIIz3eYcVX+o1sWNCcLH1TzoOw3v+LgPUE8E=;
 b=IR0K4SIQj03y7OJgq3XlUeWIp6xrMtV8Y23fjsD+BnrnOJ5XMXr86EztQw4zHdRW77yZYeYpNxIrLJYCpmYvA9qcL9Y9ZX5kl2M6GRPLy1o/SPuvILPproN10u+zVRqkc7XSlBGLarJwCRc7Q33Qix9wtjtHtyVAo+0smdiBQ3a+S2hsfVcvGwhl0B3xbiNBAfFJX2QQEoPmdHqkqIItalo5wSoDRXgnIrlFMjd3JemnDcMSUtZLltEPm8UFYz6nP9Zb+xyHFFkKNcP7asIxZAow3K/4vQCbXbaJ+aA0wKM6bD3xWUJwhnX/GtSdFxSlOvqC7mnWVIVXmFxNkHqzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L2GlqReIIz3eYcVX+o1sWNCcLH1TzoOw3v+LgPUE8E=;
 b=OBnWX0hnWT+LGZnksZ4Gq72RrU4ZUtw4iydKAJEHyn1sfZJlkXtnobp9eQTxRbFeSRCNV1dgwKTsoZTAya2bi5dU7CzadyXFHwlTMPjW8tOVhvRK5OW0bR12AHQ9TcM7h+FnsWnk6mylj88sBZrO/b1YITi+dTVCEuMJ4N5GaOA=
Received: from DM6PR02CA0066.namprd02.prod.outlook.com (2603:10b6:5:177::43)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 08:03:47 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::96) by DM6PR02CA0066.outlook.office365.com
 (2603:10b6:5:177::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Thu, 27 Apr 2023 08:03:47 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 03:03:44 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: adjust gpu reset sequence for gfx v11_0_3
Date: Thu, 27 Apr 2023 16:02:19 +0800
Message-ID: <20230427080219.374815-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427080219.374815-1-YiPeng.Chai@amd.com>
References: <20230427080219.374815-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5fd03e-6cb6-426b-02a8-08db46f5edd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owBAE57Uu+GZ31xI6W9JNyFho2Q3Zn07P6PIgJq/JMAfEKeZgszKjXp6sBb4Z8YwmofR3Etl8DQYcnuXwkd6zcKu9vvNq/T2nVioFOR0+/8h8HgoXZa9n+9HYoFD1hb0HJHlx1fBR7aDBhhDfTRS6FRBrLlljcGS8d6bHX51+l5ZPP0q08Nayy5jNEp6lo/T+vu5lOWwu76aYDX/BZ5624CAzP3ekEsL+X//RFDXIcUGbH3A+3LSCl4VsnnUOB8ow6MES5cb3wcKejUmdxiypduQgaBYwTWBxU+l6ViXSeodrUTsgTFmStERV2KwnlPUDUtLZ1cj+UcdkyUe2KQ/kfqS4a0hiOSFqCrsIhkYRdXfjnCHlNbm0QmMraGi5G2OeJxhbnXTiztasPyyfUDAOrCP+52fcvz7/w3S+5EA4rWbD3zFbWTBwhRSwWlYMFFoQJkYhGrosp2epT0111yuHxs52jEURYrdjf+tU+wUwD8sTM7kM/1ZGdg5/ghvkurTzBevYiXIfpmwmAPR535ZX9hUmY3f32qHdEUqvoyE26DaaAsYX9mXC4/AjM4dO9b8Yq23nfq2w3TueoOmTxhiM4Q0sLaHD0h3Rrb6jocnX+apBulPCs0Ov0NMYGclVam7QPbk9+LDB0IvX9ppTpzG8M83bS/2VOyQgqxHDrvTuB/6hjhe7mICwAewGpCeQQBKviElcA+UyLpXheQyLDjPwB+AP15Iky4LBb7eD6uaWck=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(1076003)(83380400001)(26005)(336012)(426003)(186003)(2616005)(40480700001)(16526019)(70586007)(70206006)(7696005)(86362001)(6666004)(2906002)(36860700001)(47076005)(316002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(54906003)(40460700003)(82740400003)(478600001)(6916009)(356005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:03:47.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5fd03e-6cb6-426b-02a8-08db46f5edd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When gfx ras poison consumption causes gpu reset on gfx v11_0_3,
the sequence of gpu reset is "soft reset -> mode2 reset -> mode1 reset".
If the previous reset fails, fall back to the next reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a5086be4d7dd..c8d2a281098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4770,13 +4770,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	if (job && job->vm)
 		drm_sched_increase_karma(&job->base);
 
-	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
-	/* If reset handler not implemented, continue; otherwise return */
-	if (r == -ENOSYS)
-		r = 0;
-	else
-		return r;
-
 	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
 	if (!amdgpu_sriov_vf(adev)) {
 
@@ -4789,12 +4782,23 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			r = amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
 			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
-				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
+				struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+				if (ras->reset_by_gfx_poison) {
+					reset_context->method = AMD_RESET_METHOD_MODE2;
+					dev_info(adev->dev, "soft reset failed, will fallback to mode2 reset!\n");
+				} else {
+					dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
+				}
 				need_full_reset = true;
 			}
 		}
 
-		if (need_full_reset)
+		/* IP suspend will affect mode2 reset, so ip suspend is skipped
+		 * when mode2 reset is enabled.
+		 */
+		if (need_full_reset &&
+		    (reset_context->method != AMD_RESET_METHOD_MODE2))
 			r = amdgpu_device_ip_suspend(adev);
 		if (need_full_reset)
 			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -4803,6 +4807,11 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				  &reset_context->flags);
 	}
 
+	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
+	/* If reset handler not implemented, continue; otherwise return */
+	if (r == -ENOSYS)
+		r = 0;
+
 	return r;
 }
 
@@ -4892,7 +4901,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
 		r = 0;
-	else
+	else if (!r) /* Mode2 reset successful, return */
 		return r;
 
 	/* Reset handler not implemented, use the default method */
@@ -4904,6 +4913,17 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
 			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
+	/* If mode2 reset is enabled, ip suspend is skipped in previous
+	 * amdgpu_device_pre_asic_reset function. but for mode1 reset,
+	 * ip suspend must be called.
+	 */
+	if (need_full_reset &&
+	   (reset_context->method == AMD_RESET_METHOD_MODE2)) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+			amdgpu_device_ip_suspend(tmp_adev);
+		}
+	}
+
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
-- 
2.34.1

