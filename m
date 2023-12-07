Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40831C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75EB10E14E;
	Thu,  7 Dec 2023 22:54:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20A610E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+u/O7u1pZ43u8vwnVJAWylrqhet2HmPiUfi5XuCGJN33Uo8MLKXO1jJcdYWTthSgYY5U/vnEhYdJtmOlLboP3SCHRZrYMG++QIQuNGADXuyKc/3rPQQXY1AF1yO9qjJYjzSJbO6EK9ip46NaVm4GLf1k25X8njFl2759OO3havyJXUJ37KptfHM2CVWPq/vSnAEXgaheaoQVbF79yUlxmXgUZRQsPLCHSfk35slAGzxCUhoo3g8OCL3TBhm+dn+sL2DOcNYb5ViRCG66udhRGR3kG2461UroRM1xnXPj5izzKPn5Qb6p9OZG5/1euQ0L9zuc0s0Cvu9mrA8KNIFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFfItEXFOf5uTA693on8Sa111ktWMS5FyIf0OIzIPjo=;
 b=LXBz6FFeNt4rf7I2geInFWGcSshAr3R8F0yqmmvT6NxJ8UJcTC3duB4UQ3huGFm7tEbuLp6vTk4HelneS3/hhibC2ncgMObQ8BEJcg+NHfX1EqBJ5x7qpw94j7GPmGkIQONgndF/KNkqzIrR2ZOood285YsNxbE5RpsFU0slGDgRFEbqjcTlmATwq+8o1vGjXGk8vslgTJH3MRb7MIf4ptOyxotY4KGkI0QwBHYEXRMJh4hYfv9UuzGuB7bqcDjPPIT/5pJGgVdLMGcZovloj6K4lHe6i58z09fHb84c5vfH2hLgx08rHrP+b1+Onc0odoHFkO27Q7eaS47m3zHrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFfItEXFOf5uTA693on8Sa111ktWMS5FyIf0OIzIPjo=;
 b=vtRrgRcNomox3AEr+uY1Ojz2iD+s+tGlGTMLMMUSrGohAKhHWzTn1VepPVQOWnhkWa+M3RKulmnhcE0wntbqftm3DDRexJF3plqwkPq0guZrf9agFg+V6imM5j4SRMjXcpt7FQOU16QA30HhEbAgDJPEpxlgHXbvJAfIHYdlFT8=
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:40 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::4a) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:40 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:38 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/23] drm/amdkfd: check pcs_enrty valid
Date: Thu, 7 Dec 2023 17:54:06 -0500
Message-ID: <20231207225422.4057292-8-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5bd992-3d5e-4a1c-36e2-08dbf7777ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wD8hKD9+v8ViSelcSLftcEba7yUD9/CUfvrbl9/mhtiaTt+1as9R8/8LEioJ18rCtdijZR1prr9NSRle4JWpWjaKSTBybyTiinw74oVCbpYkEto+yOXLXGtvAmBFa8Z3dYDhQwAGGd/kIYUQLQQ7LOy+5/eFClxsX6XyxXeGgGoFoKBdmPcZwPUm8qY5Fvcct//1nMcTmuOvVQgot2Pi6WEonxOkf3k6O/lWHsC6m8VxRpUWJuycPoqI8tvBpA2cgUNDdiTDBrIzWf+fQF7W7rEPKilhXN3VoWJjtFPDCaIOs+lhJV6582cwUDPo4QPHzaQcV6G2ABIQPLAWDs2hI13X9ERXmqlo3qTt4nxjnEqpIYVDTzSH2/3YozFlHQ68kGMoLhERmna39JQyCqNTtTZZ17H7qZyAutZBrUVQZ/CusNOPvP95ZLR6Le2CbfXWHp2U47GGgUuDvxiVl7t41G9q3RExAE1Zd4FoMQkXvAiaG3QM9SiEvn/5kK/WDcS+aSBnHl6DSedPgC8nJitZIbwJNU+w3B6DKijdQRlRimXrNmC3kfsH+2ws3B9Dms2jA2qRfwXPdTJ1b73oUd8R5EUlZz3+MyF4XTYYld+CWofAxD+dRsPInA95z43AE0q3scAYrwVe4IGyA6cTTQh9WuyZpjMYQTxdNWYtsjxN/e/Pgm+xSiWTThAYPclYHDRfIKqX87dDJu/51W+d8ZfphdgUBwls7orRXfVP3ysjhRx/7TuyKDr+nNKUsw/91jJmXl8NrHaAEY97po22DhaVrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(26005)(16526019)(7696005)(426003)(6666004)(2616005)(1076003)(336012)(36860700001)(83380400001)(5660300002)(54906003)(47076005)(8936002)(41300700001)(4326008)(8676002)(2906002)(478600001)(70206006)(70586007)(6916009)(316002)(86362001)(82740400003)(356005)(81166007)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:40.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5bd992-3d5e-4a1c-36e2-08dbf7777ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
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

