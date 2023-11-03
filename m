Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A51C001B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E1610E9C3;
	Fri,  3 Nov 2023 13:12:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2202D10E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btAnB0KGTTpfoKlr8qhUe4e331/LHNzxkOEfT7JAwGGe9BhheP3xUynwRolELp+KH7i4ZkAozHtghNs1FqAfWT7yr6hyan/gYCjNNw8YCZb1sT7VJ/JXM98EH5XodgVCtDN0cHOR5Ze2dO2vkAQco8r2RNMBGIwytk3yqbOXgvKpvKBDsHDSV/dfUlurEgWHXR1C9Jrr8B2oAk7+0wwhNJKfKwP/gZL4T5RFecPAJSpCnagnHv3moSPQ1pvxTMjEHiylZowAZ32NpdS23/E/UjmoTGh5GkAircPAFs68xPqQlaBejY4HyDj6tb98nquYJGuHk/gRgEqO2ZoxW3nIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zjNeAQ8Rxc6qkoIG43uI6kZSRsD9CWskb5OxobKE1E=;
 b=HbLjtGsOLLgu6sCzu8urwSrN3rjDJReqwYAIUhQx5v4w7H7QwKC5BSPxm4iIVWSVvlDS/tX8iCas2hOTj2smnBdzmMOn4sN5MM3ATIAo0dl2UfQUAXkoDqt0WuoCfrC+WDD7hA6sdZq4qe1WFx/PsAeUFIv0ri5Uuvqnbb6s4HLKP7A8ky+ox2B3LTUz5CYBym7viiYAy+Snc5WfrfDZRlgHAptO6LAi6eatzwA3fPCQrVYTFGdCVsES0IzP62+mkC7Z+WnQ8vEMRzD8H2SOyxYb82WD4vYv4VnE0iR4vN45zChkWxbhX746ha/IQvrH70Ww4yBL5ThkvPU/ckoMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zjNeAQ8Rxc6qkoIG43uI6kZSRsD9CWskb5OxobKE1E=;
 b=pAYglIabs+7XfBUFpsxNOoHgNr8VV1wXCfPH2n2UKrDKVSNcAGQjtR2HEntpeDPXqv1eXFy3Zqww5c/+7y/E+hdm+7BR8TuBl/9y9MGzdBCzyYgnR0mSSl4SgoRTwXXWnfCr4//7fr+K0BbSAplFiNuZvz4PnQ5Hf0iZnUrV/Kc=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 13:12:03 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::41) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:03 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:01 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/24] drm/amdkfd: enable pc sampling destroy
Date: Fri, 3 Nov 2023 09:11:23 -0400
Message-ID: <20231103131139.766920-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b821e5e-f597-441d-2027-08dbdc6e78f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XprmKsK8NaMiAVAvSEln1vco7+nvtlXTW6eK99eNLG91WiOAAwft/oGTxft7q6tvOYzWDU4gfi3s/pnFtGLSz3IsKu2iAPFNUkw0kdWA3g6wj1oXOT6lFEwNXg1oN840FJ/kvmyOTZJt8ePuFPl/Nex/pNbXSWQD6or8JgyQnrhToUpb6tWiHnzOneC2uwxbKD6sNAWL/7aeuDC8xoLTtTc+9Pb30JNnPzFWmwpq39n7Ow/p5KwtYzuQ6lHPDNEN5n3jYUc+CesAQukaiAFq0ScnQFmyDB0N1CuJCHoc5yjMpgy3zymktymLaYYsyhOFntkuVn/k60wimH5L7grkFi8UZ21pOPIiu+4lW4v50YW7kIfe95hmTYcXePUuzPVogTLyzyaU8ArpcTIVY3NzoKTFPUxqbxn/ppAINomJ3N0Gd6QEnSkFNq1kooyl8m426NViuRZUSbuq9bAqy4RV4i7d5uRXAwr+DoMrIwqnr9S29E76JSJxdb1a53JlQ+fV0cFjOnjRERjqlQb3mDDpOO2VLmDe7ypxsJJLe+LpjBwI5c0bWolYs7208kJ54KwKHBdCFPKZMpSppjC2/adBsiZU6+26m54xx7V7ako6gi7u6PdEFvR1cHNt37pxwd0V/nQrpVpUWv4B3D0OKKC6Nu2R1R7T8buTkBQZHhqd93QuqyFRnoxUK5Hx0QqFDguevx10Ix3aZlW1CNYowJ37DD9aWyej/y+d2YMRJ9JHa9aemnJW44CnAT6pQeMqyN9toPbiWJ2ACQ084w7kfvzgXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(2906002)(47076005)(5660300002)(81166007)(356005)(40480700001)(82740400003)(2616005)(1076003)(36756003)(6666004)(8936002)(7696005)(4326008)(83380400001)(41300700001)(8676002)(86362001)(26005)(70586007)(16526019)(478600001)(336012)(6916009)(316002)(70206006)(54906003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:03.4829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b821e5e-f597-441d-2027-08dbdc6e78f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

Enable pc sampling destroy.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 36366c8847de..60b29b245db5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -170,10 +170,24 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
+static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	pr_debug("free pcs_entry = %p, trace_id = 0x%x on gpu 0x%x",
+		pcs_entry, trace_id, pdd->dev->id);
+
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.use_count--;
+	idr_remove(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, trace_id);
 
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
+		memset(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info, 0x0,
+			sizeof(struct kfd_pc_sample_info));
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	kvfree(pcs_entry);
+
+	return 0;
 }
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
@@ -205,7 +219,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EBUSY;
 		else
-			return kfd_pc_sample_destroy(pdd, args->trace_id);
+			return kfd_pc_sample_destroy(pdd, args->trace_id, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_START:
 		if (pcs_entry->enabled)
-- 
2.25.1

