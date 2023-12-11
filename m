Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBB5C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F47510E112;
	Mon, 11 Dec 2023 17:54:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D57110E112
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 17:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J90lQ60uMtqm/sJ0h9BDCilZC83R3J8DcCRdwOdVXOi9+APhAP/QXjJZbwyky/IIbRduSxQbBjOFtV4r5r+hPQaRR6AIUMWRsB02obippUUdTA48NQkFQX961r8u8QbL9GIW6QL5xQe2UwVspXC27r7agW0kcqCDLcPNPTB3kCt27h37jbxO1c63vZpNX4YZLpgNlp3RayOTGj5lnPy8gE2NbazFozy1MEhAuddLzLvavVB3Orol+jqQs8d9VkGSD+ZkkWxSzx/Vegpx2of6TeIiu6NzPLKAruqPxAftfhLonz5BmVo+elTU43IqDE78c/baoYNOpiaMzGVLKDD7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFfItEXFOf5uTA693on8Sa111ktWMS5FyIf0OIzIPjo=;
 b=KY6k902jrPkp7QZLfnzpfLYhCBcJB9yB/iojfYZPPrey3UALUoiBt2qVNckVO2GVEM7blNkiohrqXPSScpAgxYyJZFxSRsc80rr2MdTt6QyG6CZhqbS86MPfYr4XgAEt8CWt2sEtBWB24xWbMfR/QtQS79VCwXUiWxFJxfLA4wQmXop6vfu3vAj0yLKup34tA5IFnUgUkLuiVdK8s7a9lXSOXjQDV9e7crn76UQPo/5bvDhVXJaHroQhyQB0uozCcpoCV3IF5Q95fP67F7kOHBElU03zX9pTMBvFhi2cQFN4aBITCia4dVMDLLswk4PdizKih+LB94pe8UOSfwNksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFfItEXFOf5uTA693on8Sa111ktWMS5FyIf0OIzIPjo=;
 b=bYW0Om2SZkn1HUmf01D+CqwRwww9WrOW7aj+1Uns4qnARHIiaGDl0uvkGFEi7tFkmm9bIdnhgyTEnQeTT/cZpe5wIcknf1kbfDxebdSwFmjH3B//QvIN+gDXvubqlVRuCPbIg6X+ZyCH2Mes2AXhU44stMNXxL18NW4Kipz682M=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 17:54:18 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::f9) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 17:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 17:54:18 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 11:54:17 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 07/23] drm/amdkfd: check pcs_entry valid
Date: Mon, 11 Dec 2023 12:54:04 -0500
Message-ID: <20231211175404.761612-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-8-James.Zhu@amd.com>
References: <20231207225422.4057292-8-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH2PR12MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 56634ba2-43f3-40dd-014c-08dbfa723258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AA2v+UBxvQoJ5ncsL4FNgaGhNbjCzaU5+nYeXlgUqLSqaZUfG9A2sMPLzR1Afg+/Hp4BZPEk0eWrG3y3yzQkLwQD95eA5vEVMvo+7vJHaPvQapGCZdYYLOlNb13DPK+ZRlJU/wHT3DhcmtiKKu6ZmJu+9lb9YRSUNc7Udwl6YENXqU5G/TCvnc9cd4aQ5xM6TQxE8z7wF8gQkeHrWC7BVj8u46pOh4n08ruaEEpDdsjyK3rBRtTBKfkAgrPTdPDTzAUZByLgzpJolkBqGlfaEDHxBO84ZPOBifZyrwE06ZIx3ePALceFqESSGqKckwxm/S8VjcygE3QFHxMS3WxgoYqppr2+S8J7iVdtwVOnroiqpLSfJaoHayWzyBx5EMDW8R8oY3TpJcNMMmtN8m2axCOXCumXZJyzt70ZJCOQBI1gFVi4kJX9qxj1E1ned3FoEQZUYLBE1Rd3Vww3cb3FOlYnjnMAX5Ngek3zS+TYD8CfaEsJ6vxd2U/ZvZh/13d9u8bUJbt8c9J2IkhHDt+Vi4wvWwviH6tauojROPkXkib+hp2b4vlwVGCFovnXVpAgeh7+dDNzBCzbPMT7AzokMdXyeDKsC9p4M1q0E9byVz8Xebkj+pD6nP4WnWkzO3A9b6s+SEvTsrkmfnXottL/cCemj55x0tfpElUT89MkZCmLPIdFPUWSv1QlbjhX7pLCBNxn59fgFGdvR8iKgcC6b2sVTGvzCcfSgFZGMcDfYgm2vJHIviVXQD24iwy3BiKY84L6jQ9hKoKqmzjbM6KWdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(5660300002)(1076003)(47076005)(16526019)(26005)(336012)(2616005)(36756003)(426003)(40480700001)(54906003)(70586007)(70206006)(6916009)(2906002)(83380400001)(82740400003)(41300700001)(81166007)(356005)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:54:18.0119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56634ba2-43f3-40dd-014c-08dbfa723258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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

Check pcs_entry valid for pc sampling ioctl.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 33 ++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index b44dfea15539..e5aa87b2da4f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -178,6 +178,24 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
+	struct pc_sampling_entry *pcs_entry;
+
+	if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
+		args->op != KFD_IOCTL_PCS_OP_CREATE) {
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pcs_entry = idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				args->trace_id);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+		/* pcs_entry is only for this pc sampling process,
+		 * which has kfd_process->mutex protected here.
+		 */
+		if (!pcs_entry ||
+			pcs_entry->pdd != pdd)
+			return -EINVAL;
+	}
+
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
 		return kfd_pc_sample_query_cap(pdd, args);
@@ -186,13 +204,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		return kfd_pc_sample_create(pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
-		return kfd_pc_sample_destroy(pdd, args->trace_id);
+		if (pcs_entry->enabled)
+			return -EBUSY;
+		else
+			return kfd_pc_sample_destroy(pdd, args->trace_id);
 
 	case KFD_IOCTL_PCS_OP_START:
-		return kfd_pc_sample_start(pdd);
+		if (pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_start(pdd);
 
 	case KFD_IOCTL_PCS_OP_STOP:
-		return kfd_pc_sample_stop(pdd);
+		if (!pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_stop(pdd);
 	}
 
 	return -EINVAL;
-- 
2.25.1

