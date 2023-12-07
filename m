Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C2C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A7710E9B3;
	Thu,  7 Dec 2023 22:55:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A6F10E226
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCB1g0Kt0ZlEvNyWU9B/gWma/TxQ62eV+Z7ZhD7hb7RF/dYTxrm36SXXDPAbIpM9jcsmaWxvhZmJBnyGHU+eUJu8Jk3x3N7jVdQndnBH+IOYb9qLSOPHmTia3K5DFpl41rT8CAm++aUHnkQfDDp519+x6aAPiSoeRfdri50NcLJuJLzKLJkTC0SvN0dEO6ef95Yma25tcJtZh91DhYMwhHxtX6w1ZDf8Rjrskxu+tmr0TCG+2jo2kqo5DEmrSUsA9IN3tJiL0BzohO93UcO7ro46aGbm9O4FXCb+lUpgHDLvQv2XX0sWCy0Cx7T1RonMGOws1cvnR8hP8dkcz242AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK6O9ihwfZojaYjOVgh/IKbx5ohmN9Xr1nT9P96ss5I=;
 b=dPEvObo/fp9bD9tEZV/GCFlCCgys01hrU9C0kN20v0QvOlLdbq3F+2lRNhtbPkl7yc+Onec85WTEDJ5mSPEKY+YsuwG93p47UXbKj8i+R/YLscKp/pkgAUyv+L9892kriUWqNFwBs/HR73fMcqezThmcfZJabWd4hEDh5/fMtIiOcrSN284bmlQKx6Ne901YYHyDD39K5UdybYtSdLwjoenoNSzd8N8akrl5k1PVVgGDRQkddWrGlKt3xbJuBUFnrDH40qKiM5cXHpm16XmVtKHfLA0vv+ZTBnboR+Dm1kqWbQ9zkBlWWHEHFSndTN9FT4HGvoW5vbs8OuueANacrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK6O9ihwfZojaYjOVgh/IKbx5ohmN9Xr1nT9P96ss5I=;
 b=Dcm65PEjXq0tUb7YukjJGWWRa3rJqxq40pZVtcWKugzj0BOP7y5L42q6I/JMinm1bEHgRGJkjCPJwSRMfikhQHoLMf1yok2GmevnOE4joGcaOZo+3NdHtUmtX+SCFIGJ6JEVvdgA/DC0BwHeIZqMLmx/L0SC0fDtBRGDfndhnXM=
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:50 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::92) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:49 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:47 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 22/23] drm/amdkfd: add pc sampling release when process
 release
Date: Thu, 7 Dec 2023 17:54:21 -0500
Message-ID: <20231207225422.4057292-23-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: d18c1338-1c7a-472a-4ad3-08dbf7778483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMVieNI4TPWZLoZdxBzpLPT1peLXdz4LTZkMEFiLE5YIaZPl0F0woy7OKyV3zv47QAgomaRlnNQcC/RqONxuGW0LoTKasiTyJRtsd3+HZKfANf1tKrPofe0KtV79Zws+tAyJEmkKVufdCUccmFYysJpgg+z3DJBGWiLHV7TyByHqSstbdsvJiHO8yFoWZ52xeAdw7Iuy+Abis5WBP6co9PCsIe+xgKlrljtwD2ODfj5+d8XcTYSQ4G+PaeoDrY71nOAvSsIPWGN5V6hxh6SADkt4F/6l7GPdTQszIK+7nfmpJi+UrRAVJaGmBll0RtyfyNZRsUWa2euI1vzFhk8gO2D+nY+wbubpUsIAxu7yhGQpL5tXVPLG2BGPnsmk4RyYU8GmOzKEK/mdlhqPCJeA+gTUGqSZX57P9LoYHFetFEmRQXso8MhkaFfYJB+q5GisSs1Ff5/JXXyo7OHTCaWuaddKEG9GVWIhwOxaGx5Zv3TUCRU6dq8EnlPMoK9B2bqjpBb+u3ozGyew+X3KJ3rrQjjlFjQVTN1AEmBUvvyw15iC0V/t/wjmXG18VGxRvOS2FXLfiGlLJKanfSPFOt90q9gvvykKRfIvnSPEQ75enxwxsKdF35mLQ0gBhOB/04pFAwVLejCIP/ClkgeASTSqPTGOKBfj39wfmcu50ZGq+p+cB4m4krmCX7fP/7uaq13I2F2Wr1LWAP7eVNdyUQRatiTSgeTiR5SmV2XfRhSs1lKR3k6jWCAH+vcIkgRZLtR8FfNtzfshz5c7hKiUbNkcWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(40470700004)(46966006)(82740400003)(6666004)(7696005)(81166007)(426003)(1076003)(2616005)(336012)(26005)(316002)(16526019)(54906003)(8676002)(6916009)(4326008)(478600001)(40480700001)(70586007)(70206006)(36860700001)(356005)(8936002)(83380400001)(47076005)(41300700001)(36756003)(40460700003)(86362001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:49.8641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18c1338-1c7a-472a-4ad3-08dbf7778483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

Add pc sampling release when process release, it will force to
stop all activate sessions with this process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 21 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 04cc25c79a76..a05dd8b1a7da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -300,6 +300,27 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	return 0;
 }
 
+void kfd_pc_sample_release(struct kfd_process_device *pdd)
+{
+	struct pc_sampling_entry *pcs_entry;
+	struct idr *idp;
+	uint32_t id;
+
+	/* force to release all PC sampling task for this process */
+	idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	idr_for_each_entry(idp, pcs_entry, id) {
+		if (pcs_entry->pdd != pdd)
+			continue;
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		if (pcs_entry->enabled)
+			kfd_pc_sample_stop(pdd, pcs_entry);
+		kfd_pc_sample_destroy(pdd, id, pcs_entry);
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 4eeded4ea5b6..6175563ca9be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,5 +30,6 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6bc9dcfad484..1f8d6098dfb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "kfd_pc_sampling.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1021,6 +1022,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_pc_sample_release(pdd);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-- 
2.25.1

