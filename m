Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81184C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50643206D4
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="imYfOKhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50643206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46D389E65;
	Mon, 27 Apr 2020 03:35:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9986D89E65
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 03:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haU+2rpzy2PjUUqM5BZJ5wK0zvBSTcSOHUw9G2tdrjS5tloNPv2grAByXGwQ0uLC2J0Bv3ItRQiwYI+hoHZIcOP1I2OZD7vDYLh8PH5rIbyG8CO89r8WF9ZzmomykdcbzxlTYrw5I75nhi9p1+WfvpufwPDqzWUMxl4r7lA0nHRS5T6Q/kiRT3a52YFMzUbjJeKFKzRQrwVg2PfIcGX8F8NuT3Z8JU078LNcgI+QZrZf5ORs5fQB3YBMTTrrS46MZG8YynjeGKWexau5DE1qwgx83LSLJz2M3XwgShuxp1ActgPYh+7WgllEYX3F+VqOhHcWbtSLm2dgVXV3ceiKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0mZm1C5OfFV1mJ4/oYA01VNF25hRlYXp5kgj6IIqmA=;
 b=JmCx7OQC1lwV+LzBF4pux4gjpD9GedGxc5mHas6uvJk1M11WaATtF1AncCb6fbMxWnTsUU6vM95U6faBOwkJnxXNSGTTQHyEwFoQ7TM7dcFspLtTRgQxKqxwKGL+U4Y8xAipgNlXf2jZUL+YFnT7IkYbDahEyK+F5zuMb31MCbAotHsi+ziBjufr7FQwsxBFsAABf/MzBWwnsstv/rr4uso1TuA1HTHDiT+MAwSIgq7jDWcWTp2+7ZEatUYS5oLb17mNQlP+UzrOOvIiyBbl6xPAmopE+ukmXeTbJEn4WSlBKr67dJ9tH+qB4uS2Z5X6zAdWfCRZJt5gyf6pVeehbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0mZm1C5OfFV1mJ4/oYA01VNF25hRlYXp5kgj6IIqmA=;
 b=imYfOKhjLVPFNNyRmuYebnmvD2rIxzY1LG7hzul+oIYO0zN5iy7AblN2waljuVurgbxZzS0ych9MhcJt00eGB48OtW0ucnC5QjFy6FRqgrkS//K0RnH2J5IZCkbu8NTJzTQvGLDprdG2bX8AdoCe8YETcIoVQ2ICmKgGXb7ejdQ=
Received: from MWHPR22CA0004.namprd22.prod.outlook.com (2603:10b6:300:ef::14)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 03:35:16 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::64) by MWHPR22CA0004.outlook.office365.com
 (2603:10b6:300:ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 03:35:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Mon, 27 Apr 2020 03:35:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 22:35:06 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 22:35:05 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix one vf mode
Date: Mon, 27 Apr 2020 11:35:02 +0800
Message-ID: <1587958502-10638-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(46966005)(47076004)(86362001)(82740400003)(336012)(81166007)(82310400002)(478600001)(5660300002)(36756003)(356005)(70206006)(70586007)(316002)(6666004)(426003)(2906002)(8676002)(7696005)(8936002)(81156014)(6916009)(26005)(4326008)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e365329c-7bed-46dc-1443-08d7ea5bffc1
X-MS-TrafficTypeDiagnostic: CH2PR12MB3816:
X-Microsoft-Antispam-PRVS: <CH2PR12MB381609E4306C79322F8891A184AF0@CH2PR12MB3816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0386B406AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbtKA8HYb5L5RX+AfrIjXmWz4iaLParLFKZv0tNaghWEWY+3PQtM0P0T54dVtKWqNBPnhplvkcqi7QMWSvRC+aAgJgl46lNilwT8qbxYnkdHQm5+flGkHzsQ93bhRTLEaCaMYqtO1rx/s7kxClzUsywjt8xHd22Pye9y2p0fUSe/YMJaEI7tcltqQVPQ9+P3QwmDQ138fDv45eYHm2cxgCf+W/E6SZAtw9GoQM3Ox+Ph9sSpUY4uUDpMG12IhcGO0FiFuYQiotOilOTCDndDmbAkmBtfBHTxq8Hi4KslDgbjvnIW9aG4CCiIXbW6+SO4b3Sw8CnsbfL8EXUy0TmBn7nN/G+yzTcjP3x+8pyLtC/dKgtw59RcVt+CWT5GPkouZkL8dvkAnZ16ihpfUCI//QJ5Lff2W0r3AYiFQNwCybRYcRowVmIU399d/xXg+Qg2w6N43SLVPRQISXSBsK2OzIOnYQTGYHKo2DbvbKb/iubFOj8KbyzyI3sMLvNOMj9QtvHKwn0QxR8IXTb3vhQpUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 03:35:14.8352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e365329c-7bed-46dc-1443-08d7ea5bffc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

still need to call system_enable_features for one vf mode
but need to block the SMU request from SRIOV case and allows
the software side change pass in "smu_v11_0_system_features_control"

by this patlch the pp_dpm_mclk/sclk now shows correct output

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Singed-off-by: Rohit <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  8 ++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5964d63..bfb026c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1183,7 +1183,15 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 				return ret;
 			}
 		}
+	} else {
+		/* we need to enable some SMU features for one vf mode */
+		if (amdgpu_sriov_is_pp_one_vf(adev)) {
+			ret = smu_system_features_control(smu, true);
+			if (ret)
+				return ret;
+		}
 	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3e1b3ed..6fb2fd1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -764,6 +764,9 @@ int smu_v11_0_write_pptable(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
 	ret = smu_update_table(smu, SMU_TABLE_PPTABLE, 0,
 			       table_context->driver_pptable, true);
 
@@ -922,10 +925,12 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-				     SMU_MSG_DisableAllSmuFeatures), NULL);
-	if (ret)
-		return ret;
+	if (!amdgpu_sriov_vf(smu->adev)) {
+		ret = smu_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+									 SMU_MSG_DisableAllSmuFeatures), NULL);
+		if (ret)
+			return ret;
+	}
 
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
