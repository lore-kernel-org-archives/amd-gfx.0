Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB5EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A22210E45F;
	Fri, 30 Jun 2023 11:56:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5940410E45E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbFNuxsAjkmChBrJ0M4kyNHfJG1c9NP6Wh3x4Jk1t481U/nEHVoeOBSGS/V8zMkDPMicuZ1uoODVMEUUP8eZLVImV47p1iRFJ4eWFe6eBDkXLTyFiCIGiVhR8qOny3jDh7NdJwwen4m/dTySjUpzosbCunBGYgsFg350n8YXGf3XVY6uf9Q4ZCLUuh9LEvshmsI4j2KOXeTBmAyB5hAcob5HKJrgknJ5YKNUV7Bv9uxsRK8V/cNBuMmT6QumLlQhXAtbEiFIiYkrXyNQeTjpEi9x+NPlGZD95+oZpB1g6I8IgjnCoKc3HOG2F4Rc3j/NC1j8mPWd9ggHhosbpjQ1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIR4R54IIWtX98nbb7NLqkznMwFWk7DVZ5CwCI0wEOU=;
 b=RShR16VoYbfSCMU5Yfc12C9/I7H28YCS6TvUW8vr4l3+58WuBUqScSeF2YVF/Vgf27k0u/jDPluKZJVXEoLfbHH3sjjNzygam8DZgPq9oLBqPb2/ujnlLL1N4FvxVqVDJILWS81614zOw3umYT540eOHqRwxhv+HbR17x/05b1ZCxZkLSGS5hKHwgz/puDxpZ7P2f0Gt55gJvzP/I0rOYS+BEpmNB56VvVoSHG/E6ZfK3bpR22Fn6NKy8esmY8YoBZRv8bXlDw1cOrKy2JwGwwLl+yD6Vho57bwzbw3cDWTiC5+fNVVIKidC4jmxwrMzf5qHOSA/+mpO3HcYE9BIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIR4R54IIWtX98nbb7NLqkznMwFWk7DVZ5CwCI0wEOU=;
 b=NEUn1XBLUhM02jyj1I08m3Bx0UrQubjs0ZP8B90y4YxBK6zr+QzKIE5MFFTyD4QOw/BWhZPRTTApXe32EmRhEvI0/cyI93Z821j4l1hAxJBqSv+W33oHh+JrchQ+6l1OcNDIKSNm3RmIuBISyHcvEq/SriBi8lW1Pp3T3Wully0=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 11:56:45 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::9a) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 11:56:45 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Remove else after return statement in
 'gfx_v10_0_check_grbm_cam_remapping'
Date: Fri, 30 Jun 2023 17:26:18 +0530
Message-ID: <20230630115618.2855618-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4df21f-15ec-43fd-b763-08db796113e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goYvUPQMuw93KEnBfpHXaTsgxHUop/lgMr3EMYrkTeYb8yXpMtfo0AWQcsTOg2vXrHv+a8rgkrkW9OpK1m3lr/vbq1sR8W7fNjgTcz/WY7ZWwibsHtsHgmPrGYSzl6pxz559vNSww73CA+8iajuBJyWh3/kdC+AQS7tPvFq5jJNVeLYJuywmozELU7Cxv0+0SnJNvw9CNmzUkiItJpO3I1XsNjdzshp8Y0iAN1876BxikRX+Ab1KKHdbO99xQSmjg7jmsgVTxXw1a0XrAoYwfdw83PQe5e3zjLuB5CUiw7STIdbyIrInse/wS67jjClhOZuZwjVGynrq9jVcx6hGcz4yK7FGQ+IoPUKU3QdhlmxyvzlzIY3rFVF0c9vAL8ENXm5mF9DhM+hah6c1YVL02sWh9gW9DkpB8xT89lRA4adF+GTlXZ+8dt0s3XPO585G0PH7SOiDEnFJwFWuYOKM13ieh12i1VHNQ5b1aGLixxgHKQoOU8YKl66VNE57PEbpcECeLPqVyrOU19P0059EgYjFQCUYdbNIMcz5rX30YzJlw8hPUUr8WXVEWdJEQKBDo38AN9S+V+PY6gQ15nTiM8SyVf2w/FHhoFAIQC5I+eNeKHrLJGAZkxrWXqtQOlA/aetfNP2QfxAGOLqP3eBGVLyaIW3X9wpBZRulMKA6ldsFmLuhLhKFPD3Wx9/BME4ZYXFuwlKRBCMEXIspHFgSt0/gUb9Q64CYvXDFEIyX9/FRDZhQ7G3ejmW+ltuJ5q2FFOFlscIrNHye+VO29BXjqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(36860700001)(26005)(4326008)(82310400005)(82740400003)(44832011)(40460700003)(47076005)(70206006)(66574015)(86362001)(41300700001)(8676002)(6636002)(316002)(81166007)(40480700001)(5660300002)(70586007)(110136005)(36756003)(356005)(2906002)(6666004)(16526019)(83380400001)(186003)(1076003)(7696005)(2616005)(478600001)(54906003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:45.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4df21f-15ec-43fd-b763-08db796113e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch warnings:

WARNING: else is not generally useful after a break or return
+                       return true;
+               } else {

WARNING: else is not generally useful after a break or return
+                       return true;
+               } else {

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 157dd33ec43a..19db20e24761 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6940,10 +6940,9 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) == pattern) {
 			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
 			return true;
-		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, data);
-			return false;
 		}
+
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, data);
 		break;
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
@@ -6958,12 +6957,13 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
 			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
 			return true;
-		} else {
-			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
-			return false;
 		}
+
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
 		break;
 	}
+
+	return false;
 }
 
 static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
-- 
2.25.1

