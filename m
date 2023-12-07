Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC133C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3955E10E148;
	Thu,  7 Dec 2023 22:54:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB4110E0DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR3m1a6jDdR2qmXh0IpKKE/dFn3bbm5RiSuisDz4940alQZoAlvds6GV2GkSyoJd2f0q68D8jVYy4eQQX7KQiH6cgpExI06WCPBmUfRflVMWswYthT4yw0oiASd2Z+6d7O0MlYJSOeS2m2xb1Dek3C5FaxxmXZs6UZUaNT4koMONTa1dlHsg0dHqWShculGv9BWb2UWjQTxNSbEu4Fb9D0larsc/MLLXmIbC3AVwaI3msPhnCiMWNLnJxpu7TUQiKfwtVl9r4MWcF3n9uHXHcWyL1vK7CU+urgz6bVLOg3b/810IjE40UaY0xdk4W2NL/JvqKsipzfQPk0rFZn3Hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h4Eay5tq3jjBamZJYJmgeud/Ru9QvSd2klNaWgkB+o=;
 b=bbA2nBUahMzK/CyuZ6H4ltxrxtTfJh/nQUFe6bCrQRMuWuDZvzO0Q4RXeHK15wpAT03KqIJKBb5QJrOWt7PpP5TpBWiKQoAJeEKjuzOBBElMV/RWrC88lKB06aSoyFvHvUKZNTFOlkCfK3f1M4x2foydjpCP+kHVAGgpfPg5xIUkAi4qlHl2LJfLeUfaNnOqFFkKwA+Z05y+ddI2L6IsYupdVyRBcQxQYY9jwEgcCFhKQWCpjrvAsmLLD6OF65xVLpgcvw9r9eaGRBwczC7jroBuZ1xXuU9y7V2ioixD2GwQtdGrBsJKnn4A+mXqTxWSBuwMCnfDz8oFWAYnhFOW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h4Eay5tq3jjBamZJYJmgeud/Ru9QvSd2klNaWgkB+o=;
 b=p4ysLajj6UK2XbqYQ93f90XNngsllS4PNY6NoIg1T9wXAkzqH3IDWMy7s574Vb1a/mKIqhGVdNOcSgyW8B36ZHduVPPVEZMvY7l5v1ytH9uzpUX8S4y75iCWLiSqaX/6cLEQViUCmVzPh/oQH09TgrC8a/FKCt2MBKK5zu1PrTc=
Received: from CH2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:610:58::30)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:41 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::6f) by CH2PR20CA0020.outlook.office365.com
 (2603:10b6:610:58::30) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 16:54:39 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 08/23] drm/amdkfd: enable pc sampling destroy
Date: Thu, 7 Dec 2023 17:54:07 -0500
Message-ID: <20231207225422.4057292-9-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 643a7b6f-6ab2-4dc7-0bac-08dbf7777f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qe6VWMgO7K77U03OvkURtEETsLk84tDLzQ+oTuBwO5tG1aHTsIm9iOVeMNd9Y57lZO3acDZ1Nf8K4iECDPZfbMDQOr3YM/HwHF09mhfXkVJM5yUeeUc3ReTjoL2oCs0akzoV60EsMvdE+hJFgfIiE4E+aeuoXK1JWFFF7zSi0chFhIS7ADOzR5jqNbokpQc43HbKU9Qe3Nax91+1dNuX45bdItTefLCycNtBsgvTCNE5qCLRKDS3x4CUTkcmRRW47RdwLRs4SkxVLEbCGgidvb73vrATGjaG7/59vFymI7+4SCND7Bhk97KjMqJs9GRZPFnaFS8NNZLwC8NgpVEfvdmDwJgQalNYN6c+xaI7cbK+yzJi9O7CrMk7nmGluP8gfIi7iMAvvGQdHMCdw8/sXfJidtTzdj4Yy2T58CQ0wV1NAXgBoc7vulh7c/cr/AaevUeaMVc4g7yDRKhH8IR+BrXEPXo+6+6Vj6eS3/FU7YDB4xcRr2KUnw8BQj43/crj+TD+nTXAFRzCyjdACj4RjnIVbtNuwX2A+0vRaNXfqBbgesxhbFAifsy0z4/7tV2H2A/qXVGwVCWTqZiFH6L7PPTyB9y3uyWpnDam84CASTSw2vi5bOJ4XSEQc4H3xc/34j6sdqeYzeb8hlSxFhY8lbzNnFF/7jj9p5yXEX8/h6j1SjSwwNyhvuOt0jsskioTeHPA8Sho42aw5BfuovgpvQG7ZUJ1mCHKmWc3NzmZsOk/6pVpX0nzYOuecTIidJAoCPGcRhzD7zYoroAGwqHSww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(6666004)(83380400001)(36860700001)(16526019)(7696005)(8936002)(8676002)(336012)(26005)(426003)(2616005)(1076003)(40480700001)(47076005)(478600001)(40460700003)(6916009)(70206006)(316002)(54906003)(70586007)(41300700001)(86362001)(36756003)(5660300002)(356005)(82740400003)(81166007)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:40.8120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643a7b6f-6ab2-4dc7-0bac-08dbf7777f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
index e5aa87b2da4f..18fe06d712c5 100644
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

