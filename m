Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81379C7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 06:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B676910E1D6;
	Fri,  9 Jun 2023 06:38:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5697610E1C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 06:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFcTxOZe+RMVC94dKylkJjGpPYmZpoRHWuB7MDHacHGhJeQ9SKlLUD4JDmf61HFcOgfK0Q8ttHcqvs4bFcYwD9KcXWF8LmHfzfOj23NUIS6E+P+N+K3EDmuzbTel9xy5XEuWi+XmARdmTdD8U60wxJXH4+wIpIRwwFBVV/wu14q1GDlwVRPvMFiht9v++vpl+1GwfikrF2Ht2c8niA56JXgTGcf4ehdlekPAjXWRRKjMX1wz2jaH+tiAFcT2jPAqqOF7TEWqnmtwcz+rkoLivQJdc5E2TVG46YgDKkbuJ9VAiSWR0Rm5OTDYcmNRIV4azf1aXwBd0GzNaY5f6ZB5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSXwXdTY++d01Wuzjqz6V6FTX35eAgCykeA9UE57NwE=;
 b=ayElQUzLLFWV9YjuJbB1KDl271HOsctFv+neUzRSXt9j/0O4VwvS8+r0U5Hgp/Tcb85D/yVpOTKLws+L5djRLxm5wwkp+Bsi2gkCCSZ6UzaGaFukjyYUpRfJZs78QjhsdByNqvlFKRwOjFt7nct2lh22+lnCe4yFs++jBzQrebsIi/aiw43Lk0dLfDTN7qQxNwcM7N78tJQZJUaxV9ALROmu61S4+wvAu+kjpwjyYeVofusZPjyCQoCT08z9d+KM66xVBai6eMe37umYN++L4te2MPz+hoI2FyKY0KYperaJWlEWlAIrYbXdyrKlz+OFnD1QQTpwqJeEPUQgesB7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSXwXdTY++d01Wuzjqz6V6FTX35eAgCykeA9UE57NwE=;
 b=vc3FMpUTBN2IaRVOxbozBehbLzz9e2ui4jkmeCmVBRcklNehssRcbgD5OlpRiLfm/L1pFalv/+Z7rx060Q21Wrlp9vJQYuyhxIhMX4nJexejiHa03dvPK5FVViBM14bRmmIkvDBCqAkYLG2dBkMWl9OmB/9Rw99TpAHtqQCP0Ag=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 06:38:41 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::87) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44 via Frontend
 Transport; Fri, 9 Jun 2023 06:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Fri, 9 Jun 2023 06:38:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 01:38:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 23:38:40 -0700
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Fri, 9 Jun 2023 01:38:39 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: workaround for compute workload type on some
 skus
Date: Fri, 9 Jun 2023 14:38:34 +0800
Message-ID: <20230609063834.4184499-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2e9cf6-4300-4ac4-69f2-08db68b42a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7oLszGUSEaaA2RVtl+HyByAgblJTATY0OFHs3zs5Kwfi4hl0+/sUtjH+9CVPM4hQJgXc+pvYs7V25HLU+U0Y5fwDPayP3rqstYSFYYvpPU8TiRVoJDeFVACoh9qc1B7fi/iQ0XCVI8U61D0g2UybkMRUqkYqu38U+vxLJv5I3Hkuld6OkL0Y30pa/I5O2Qnkjk+JGNN9mY2iHTbK0fAuDiYoIw94vCHM4REasoqrSZ34AqnMtlSFMIzXzi6jXnMwiJSlkuIV4bEdbqSwCF0Y6xvd+sS9wP+53ngM10DLoB9U/FA6bpceWRFkXkMJqhXwg8wYkvJkIMA0pErd7KJfsqefJkm4WICurIqlKTGWerjc3YBaHKIdSfDLGhkwKkJu49FwpPtHaZdg84VWc7kg3w4E7NgG4R7jIQlmseQdwTwVtdYvwyCP2pZcF4+lzq1wt7rhBUcs3nrpvKe/JiEZWR8ZjiMPxDpC35J+5hJJQIBKvXe89gIe1gRA5npmjleuCCfw9yB0uSKvLaJnGJFVbtV7OhPuI8aSSepfYeIVJKL9iX9A7KxQcASZKqUuDOfZ27fP73nLq6q0IJGULOmXVKSophFUe5KOqVFXo1j9T92cAQmwyn3g7FMso03JJt7bcvVEPiSpZneQb2toO5qf66/hsivvxXiMm+Q4gxTHZGmk/t50V7yn3rYke+xjcQTz8DTSpdefEQLfgr15g6dVMjThySTJLA9sjeUkBJYBYginTTI+jYNVWE+flP0SY5wGn2OZkV2ppaRANPO+tEHWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(6916009)(54906003)(478600001)(4326008)(86362001)(70206006)(316002)(70586007)(7696005)(6666004)(40480700001)(5660300002)(82310400005)(8676002)(41300700001)(2906002)(44832011)(8936002)(82740400003)(81166007)(356005)(2616005)(426003)(1076003)(26005)(186003)(336012)(47076005)(36860700001)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:38:41.3433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2e9cf6-4300-4ac4-69f2-08db68b42a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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
Cc: lijo.lazar@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On smu 13.0.0, the compute workload type cannot be set on all the skus
due to some other problems. This workaround is to make sure compute workload type
can also run on some specific skus.

v2: keep the variable consistent

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e2265f50bacc..5e9e507a710e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2179,10 +2179,39 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+		(((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xC8)) ||
+		((smu->adev->pdev->device == 0x744C) && (smu->adev->pdev->revision == 0xCC)))) {
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_COMPUTE_BIT,
+					   (void *)(&activity_monitor_external),
+					   false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		ret = smu_cmn_update_table(smu,
+					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+					   WORKLOAD_PPLIB_CUSTOM_BIT,
+					   (void *)(&activity_monitor_external),
+					   true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       PP_SMC_POWER_PROFILE_CUSTOM);
+	} else {
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       smu->power_profile_mode);
+	}
+
 	if (workload_type < 0)
 		return -EINVAL;
 
-- 
2.34.1

