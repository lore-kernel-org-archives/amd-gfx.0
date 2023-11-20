Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DFAC2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 15:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BFD10E078;
	Mon, 20 Nov 2023 15:55:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDDA10E06F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 15:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQdub3rFfeQt6ce3Fiqa0OOb7wpyV/9ldPOffIi9/K2vzfuHdqedjQ0R1Uzkkmz3xgo8/pnLzsDc84kc2obhdfbRrIe7g2pIn2eVtNI4LFq+zZoAmd9i4ORaKYLAPcUS2mrO244VKS1SPs1P0dlYr/gk6W2Q0awgKwcyzvw99awkVIHftsVaBlUMknbkj1aTzJnNSWx9waHbwdALP3mpsEUwOfffu6JRK24uRrFfTcicaq/5D3EOKLfYvZJkfmEQSWix0hEqE6GREcswtWbUc0m7CToHG09N1v5Ap6TnxJeiJNpdm+MIhA3KWbTzVV5W5a66Yrk5GoJjxyaFSFt08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8bwJT49m27cYY03dSQj/tBtYrBLwL4qe6QWOzjW21M=;
 b=IrLLgkkTNZgh0xbZ0HQ2O+4wG7DUkA8/Gc3Y3jo9dSwOBstfjBoC9TgzNAPxea2GqX/gqf/gA5zoCFptnB6RKOgkdpCUiPDkQiCvv9e+uM9lIukzdQDuW0Xx23eTCmDu+PZBnp6v2Qhryvw94O+t34A44W1FVIZ2GlsuPpE4mjpDIDGm9ZrWte/u9yup/MsZ9/DW8Ph8PYshMbhPAbt2H/eBXVAZ05JGnZXGavjAs2vQDazZ8AHXJazpNHKIpbfqBqXdO47jZs17KTstZMBtrB6jsR0mczybQo6dCTeEmOepSsUla7KDsSLi5LIu2Hu5och8deZu0pJxllmf/c+/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8bwJT49m27cYY03dSQj/tBtYrBLwL4qe6QWOzjW21M=;
 b=qDfqQIAiWyXqMf5Jc0UqAlgSkvuByVtRyal5p+zjh9ldQ10riYbqXLaQ3mPE3P2ImwgWk5gtckt1g0n3+WFSEAOKLNcYe0K/zib+4ePb6go5/xSAMBk83pKiCDCYiB046naaMuys+ZXtAgb8qOgKnMcqqGFPB8h8d2HJkNIdxEk=
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.27; Mon, 20 Nov 2023 15:55:50 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::2a) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Mon, 20 Nov 2023 15:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 15:55:50 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 09:55:49 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/24] drm/amdkfd: check pcs_enrty valid
Date: Mon, 20 Nov 2023 10:55:15 -0500
Message-ID: <20231120155515.2523038-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-8-James.Zhu@amd.com>
References: <20231103131139.766920-8-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a99c35-814b-4a32-5505-08dbe9e12b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJ38yYUozw3nzI6/Yf/AM9f2YwGKxO2R3Shy4Z7CZMSitQbyKfvA3wDXBC41LBuUiKpPfAZDOGdC/AxjnpdhxX9PVQ73yoaiRGR55sBGWgFDK9FbVyIwO7BXfRsC3aDeguLl/sQBVnKBtZFFWx1qUQduK3H1905jPyA6yEga5iIGW7kJESuJMhbXYron1YBOILef4IXUYLTkBIQHWKk6mtboxOIka0JjLQ5tw4kF+Xnba2cyh0znmQbMHQpLFy6z/OnQwkXduHL/iwRGZsN+PXcwYelONRgTeMkFnIt5+76hbjhn7qNwQ8pRjRaBLVkuE47V4CaYSUsA3nbEbTOmigwB/RKBGmXYVhyEEDWzUheXpFB8zQYk/QWNudeqm78UqDWJUyd2jLUBNEQJw3uVskSpJpwOChtZyqYgXxGRzQ6lknA1d98TX905mZPv5bBQBQ2QD1H+C+NdCkweUHHcLYfzxiEonBjB6IR/7JR8pVwYbA7gwAqHPxdZGHGCYpsiXfInACgVeaETDM+elUQOyqJMzp+w0QeDIPKlo1HwFDTKT4Nv8pNq/lTn89OOxiW8Sosnxw2CzqeeGyj6JUAQRcoeGL2oROutSxmS3dCE6vim/L5lgSd4/c3ylffdgI3rPK+MTTC30UWcOLdR5X8I9+uOH/yJt5OO/3JItBzdrcfMRBc484jsw0PvIGHkHeNlL00nKQnh7+acUZA0WYbRmTmXGdt2V826AT2zGwsn+qYbfHQcUZxBuUmWVZZxWUBioaR3QpFNJbQf4e+pDRQGAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(82740400003)(83380400001)(336012)(426003)(16526019)(36756003)(86362001)(40460700003)(36860700001)(81166007)(47076005)(356005)(6916009)(70586007)(70206006)(54906003)(316002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(2906002)(1076003)(40480700001)(7696005)(2616005)(26005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:55:50.4659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a99c35-814b-4a32-5505-08dbe9e12b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 4c9fc48e1a6a..36366c8847de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
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
+		if (!pcs_entry ||
+			pcs_entry->pdd != pdd)
+			return -EINVAL;
+	}
+
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
 		return kfd_pc_sample_query_cap(pdd, args);
@@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
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

