Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ABDC10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C1D10E227;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8868210E227
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMIFhUjRxKItNh0s7Q8BHZ3/vyH1Ii1S7NFqNpX681Jdw26a+fgNAgHP909gwUJyM1IRWXWzgM+NSVxq897zJu1FCLxohT7d2eL1R9FXRlmPJpcuodCcPFbxjQUQmi8/x/MhisWlQQSu02iZuW8q4O3p4+q/NIKeoCaLLvjTBnMbqyQ3bEbfEKismCgjiXYeFXfvsc+hS+pF+Brm9jPP/RZAQUDKii6gkG0+QrVLWbsGC9lEAf+zM9Ffb0gItmn7SeSKBblW2Vj6rRbFUmrNtj56SBACt+eITBupjaxv5jcPJvkcixKZZyGgJMuJDXdXIOQ1qPc8W06tN+QpAPmaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZOZlhAad9ch0Qk/Rx/GBC0AiUecTqLid9/sv3qIV18=;
 b=d0sjmDT/x2P8JX3df6Z/OeeSe/O6Ywa3AoqyrqgT5cL3WxRmiPrrgq+gkOwIsXrEe9I8vGvSDSHliOrTBqmLUn/rH8fnKNEgVZ2ovexBfjwv57ostGHBDGcrYrUu62d3AH1xH2Ru0rf0LD6VBcm8i4LbrKucQ6mp+d/yGygy8TylSVC4xHOUQCFTbIcl6Wavn3Xm6PXDY2zNsmEKOlCQSXNiVHP+lIBjp5buvw/gHRlUKLQD1S1+PgUukaFQO0qY2Vn5JhDELNmnnlEo6sEbGE5wDmr9JlDI2mVbpK9sLGAZ5ZhF1kCHABDSxKpjyHrRm9Z7V3pH4lCtUEJbP8yqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZOZlhAad9ch0Qk/Rx/GBC0AiUecTqLid9/sv3qIV18=;
 b=J7C8CBhWtsXkf0VFPYRx4exv0njC9AzsAhwTQbBX+hpIsw1DFKDxrJ9lNqfbaW+UaiobwADu3c+e5v8G9NDfTbtMhgh+rTAWJT8lKLmRdF9+lfB4U/A+9IT1ugZ5mnmtrXWhbHU8GSMtKxQyaU8KeUUZziIIFLjvggznX+l63AM=
Received: from DM6PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:40::25) by
 LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:48 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::f0) by DM6PR03CA0012.outlook.office365.com
 (2603:10b6:5:40::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:47 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:46 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 20/23] drm/amdkfd: enable pc sampling start
Date: Thu, 7 Dec 2023 17:54:19 -0500
Message-ID: <20231207225422.4057292-21-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f1e0b1-7ae5-4cfb-bc12-08dbf777834f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g83mI3I7FW6CEhIvIykP1VfABcUWRNdPcFE3pCrN47nm1WjA4XgrDeDO9IPWzh3IVk3Nd/6wn5fmuRmsTd7U5NhiFcyQILlUt+8YiIfnUkcMJUMsRDW0EFCL41E5xfUp+qCmrU+gjtLYh748yG75X5Xl6G7cmd0EMhAvx5G53AIE7YOpQYm/hmt6Kaae2HZLd6w9JiJmBy96jzJIcPdTM8FlNCYdoHXkgfehN6ILWRR4n4p7fyYtL7OztCeOYSxu2Y12JH3e0pfJnktflY1DABxhQjlt+PJw/tX69cBOnFMRYL02c/O/EfXErQ/3EaF54iTOTi96Y/VAoikQI7at8yz2siR8RfY+76u4RQcdksnrcmId37LmGBvzmXd+wqQqqAb6ic982cg7kCdQNVDQ90DNG++WV0kQ+jFS0ffqxUkcnDCTyDjfmm5tU2UfQ5BOHO1VjiXFEuLsn6ALufDVuc9CSTTraxQHniRcgwZTFgQLouf4rvSOzGHKVbgniwcVRRHkfGsdbv7ThASUwaZoFhi/949k8pRNvSODpbQZl4Jg8IZ8tCBEMixqth9T6qi3lvz1VLesQbpFSnwQcDO8B2Z9th/0izLEtx62JA0JUZzrd07N8sCLz6uZtDo4RjwV6e6N33n6Ol3da6muKU+N74yMBZcI+vatEqxl/DIr36NBNMS5qyIl46+O0PzbZKhT9bsGVcXiMyNOEAOc3COcCKRgEo4KdULNWmVf/taKBLGMAXiQwaCqffFs5oYOvp6H/c7RK1Kp5oWt2DXmBpKDFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(4326008)(2906002)(8676002)(8936002)(86362001)(5660300002)(40460700003)(36756003)(41300700001)(426003)(16526019)(336012)(83380400001)(82740400003)(47076005)(40480700001)(6666004)(7696005)(1076003)(2616005)(26005)(356005)(81166007)(36860700001)(54906003)(316002)(70586007)(70206006)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:47.8485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f1e0b1-7ae5-4cfb-bc12-08dbf777834f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable pc sampling start.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 +++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 7d0722498bf5..49b5d4c9f7e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -84,9 +84,29 @@ static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_start(struct kfd_process_device *pdd)
+static int kfd_pc_sample_start(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_start = false;
+
+	pcs_entry->enabled = true;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count)
+		pc_sampling_start = true;
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	while (pc_sampling_start) {
+		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
+			usleep_range(1000, 2000);
+		} else {
+			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+			break;
+		}
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
@@ -252,7 +272,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_start(pdd);
+			return kfd_pc_sample_start(pdd, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_STOP:
 		if (!pcs_entry->enabled)
-- 
2.25.1

