Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576B0C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4518F10EA61;
	Fri, 15 Dec 2023 16:00:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF25710EA5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODGnrrhd6qNLBsLcP85JhglByWAAD5qkynQJ0sMbCS/a8QACGLROf7oKRyLJa4FbeQrCFb4gDi6Y+lPy7icNimC9lJysoVjr7bSBNzU4pLBGOk42IqovO0OFbQUejFysVdeGasTGsLPx2ScSeBB8DPD9eKQkG+IV2b/KXXewY/eQxifItzlt280qu1vQpjzEcr5QSou8RrfmaNbr38h9M0ITuAOpd05P+Z6ek6/3/LN0sFDhRLC+BNxOKr/n4Rq2CFNzzBY8xKntr1vGH5YnnOPPqDAYLq9sQHHSfmY4sntcgID3ZbNQYlGzU+BaQmE9jwC8prciUnSHZ1nkMTJrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O7JTBWI7+4eeAcpWzOaJq2hLCQy+6EPHHG36LHlbts=;
 b=F/2FkCcFfPtmWI7Lf2lcfr8CK3CNTcohUIy+Xq9XsTm/6wbg2lX6TOh5QQLkD03lhJcSLvHNQNbWOlB0W2ix97Z56N8PqQaRvwAGzWq2o9OrixSxiz6ERAOZokGDOgXEexLHuUZb5KiJTMqBCX1J6aIDkdyhkEmZvKDFsw5WOqFYoRdT6+J5/PQCOBwFtM2JcQ5Vos5tK/8Kb/Ub1t1rwBcDoBonDi60nIQChMSthxtNZLA8oF09s+OdSXMgTnLg3LIAgSKCpA/MSdOZSt0F3PNOW10faXm+8usLwQArwpRrZXJOfYlSNp1J1Vr7yoARMQtrXmIuRfKgqRAMBPjteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O7JTBWI7+4eeAcpWzOaJq2hLCQy+6EPHHG36LHlbts=;
 b=5gV3cT/vm3Mp3aQnN+4O7XIuhXezuwS3KJ0PVzapMa1fDtBiNcxqBMfUKAJuWeXIOSW2McRgUYjgLrIoc5fRQtmzvMMBgFFM6bCRTGxDUXOB1ZiQtShhYuezvLprRal/0h/c9j7ljiJfCLk9qUOzNR2JvbPZLL84q7aherxKl00=
Received: from DM6PR06CA0018.namprd06.prod.outlook.com (2603:10b6:5:120::31)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:44 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::39) by DM6PR06CA0018.outlook.office365.com
 (2603:10b6:5:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:38 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 08/24] drm/amdkfd: enable pc sampling destroy
Date: Fri, 15 Dec 2023 10:59:35 -0500
Message-ID: <20231215155951.811884-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 056178ec-99fa-4692-e99e-08dbfd86fe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MW6jQ6zFg2rI3pq6NU+IqUoAVcG6NukA6cws/3BvmfVm2mbj4BUj3dCx7GozCdLgjfHtkbp0BWnOllR/ZywbgW3cHu0lmQbYB0tCYp+0b5VvZiAYOQPPOAy7Lc4XSNj5Nz0llRwrfVlyK3vDitiMNr4qY88GOy1sHdLdj7j6TDsOXChr/vIEPm6QzeN2dXi8oKD1n5NkE/m163hMM4jmfds2645rLuFCwKt1wMTaoVAzAgFlLPZ1MuoLT+eeGnf4b0T620Bj2zq5Br8NwPurb6UwVzNuCQAVDa5RQumk9Z1OEKnsNOI4GoIHw0gLwJ8A4RF+JTzGLeuwY4NV+sBrASHskWt7C8xqSSWPp1qEsAKoHEnjQrGPVqGglVvcd6elCsxKZTGoBEN4+wRGSgghhzOSxyFDgsnx439chQN074t8tpsdEdhy8fvAA11vY6htXUrz3bn8e5uyP5wVhot5z7qruqUu5FqroXyhFx9nWu6Z6vwOL09q6xM8ZGtbSyhjBSRwAWrvVdSSrsvEZXKPgEYGgaJOOX7of/tvkW6MvJguMmcMoL8FEngQ0Q9oUp4GPs80Pf1JflAsbYW6faBoSZajAfn7RPOeXNk5Uo4C0Vg6/irU1XJR5ipBuX4s/Otl2x+v1a2fhBhm7fhctlIIMSqk5Iz+ziKiFKSJhaoONwdKbM5m/m55OHdBWqqTTWHSotGW+5LxwXWuB9c20DjWTVajhJBaPJZHlknmifwMhj80Rcdgj83vvbIUSmMUGXliDwvJYSdKKrKa+ll+U75eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(356005)(36860700001)(70206006)(54906003)(41300700001)(8676002)(6666004)(40480700001)(426003)(83380400001)(2906002)(336012)(8936002)(6916009)(4326008)(40460700003)(5660300002)(70586007)(81166007)(316002)(86362001)(16526019)(7696005)(478600001)(1076003)(2616005)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:43.7696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056178ec-99fa-4692-e99e-08dbfd86fe68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
index 193a8aa94d52..07e4c4a32e7b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -169,10 +169,24 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
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
@@ -207,7 +221,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (pcs_entry->enabled)
 			return -EBUSY;
 		else
-			return kfd_pc_sample_destroy(pdd, args->trace_id);
+			return kfd_pc_sample_destroy(pdd, args->trace_id, pcs_entry);
 
 	case KFD_IOCTL_PCS_OP_START:
 		if (pcs_entry->enabled)
-- 
2.25.1

