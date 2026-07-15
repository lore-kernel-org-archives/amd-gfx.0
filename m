Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF28C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770D410F05F;
	Wed, 15 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrJ55tgb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C8510F04D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rf5c2lFgVMIbqdxcgxWUUEgKKXq7iC1uQtW66hvBUVbx87DZCWm/C3s7loQR1QNBchhFQcPT6HSHVH/QAO+1EIPV9mm4v1qUX/+ImFpmpYaFWb759di+tJU60T71hl5PgzSXi1G3eSkHuqDQc7aGP23VfFbHYJEZIqpY4wpPSHLI7NHV+ZJeTGGyfHMFbW9rT2GQ72PPcDtYr0sWJ0mSmcTGA8pInRe6HJ3STcdWcrc5EwldOfxLcnvNV7caYiuyqgC2sL+g46DCsOHSQgBtcEjheFDB3tcsb9PhqHt3wYoBw7imBCpFS/jKyJZ/CBIERPG5Scn/dokWW+L5EPNEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzijzAIaf9uAfhkTx3KMr0j+ymL/H5EVu02mQzpG0M=;
 b=iLZRfzkrTJDRU2/57u/JJ6r5jjs9XyPHamnUbdGL5HqtBpH8qgnlsLAiwkwPI5qjHD/ccYAY5QIoZcdAkmXITDbysFHUHSIE2tvelApt9QOWxSTbqlPgRB8VC+GRPS6qrvBuLX13ueaCuwW1mrswlzlVHwg5NnSDm10Iuw/mhsh29gnpknuolGKdXr2xk3DgdAumxJhmL/DkABMcBKt7bzFGK/InwcBMl2YkQP35JRScLdrjsdcj74K1jzmMwypEAeJoEdGKcxWaik+8Qw6g+dGH76VYcTvMmhTWQIJD0XpWrqMpedBNAjU9aQofKK8cLU+clQY7AP0TjJJinzyufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVzijzAIaf9uAfhkTx3KMr0j+ymL/H5EVu02mQzpG0M=;
 b=rrJ55tgbZFy+y8deM6Y6brOU8Wh6tJLjuNvM9BJ9mybLPFc7nnoyjxEd/6h57DtdX+RF1rZrWfC/2cBoW08xmIc1fiPBR8Vh40NCVUDK133Gir3UHSBHLkLyzYsqilckXbv+Is88smJZ09XVtPQQny5MgiN72MGF3okDKieoBbM=
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:42:30 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::19) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:42:29 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:42:29 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Alysa.Liu@amd.com>, William Palacek
 <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length
Date: Wed, 15 Jul 2026 09:40:04 -0400
Message-ID: <20260715134004.163459-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 735f6d0e-8d34-4e4c-91cc-08dee276ea4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: t2ZEJYfLs0eXcv8YL/H0Dp63vsV9GeCrBgXDdp4faf7JHq6mcmfa2BPjSbEFsD2q+fHRLkLTEfhUW+7jTZfISnQUqJuCw8+XmBRUIGPRMp6LZDhRUHhDddqBt2tlcQaB5au29clER0jBKe9JuFDeHGUHZktVVj/uO+XqqOQDcPjnSrlf/2iKT82U8CzP4PYchTJaa5gsgOh+RBOTYPqegrP45QmytF6Qcy0Z1EV2ThclgXWnTxJRs6Jx/h8fspvdsnx0SuJ/Z0ngI9uHCJN7q7K6/FF4ahczJ4IoCUj9sRF35ne+X9XSmbDM7ZTFicZwgVC2dPXqOm3UqLbtx19uqAap62oEK6ekDEzNMwHh+EDEA/I6UIOFG8lRNU+/Od3XXLVP/DFDuAk7zFwvVfwDUrTzlobkTL4mB4HhH9b1Rs6r/HrtM0QquCiATzXi37PZhZdNbp/EAsAvqDwe+Piau6nnO0m+15uTp2PQuF/uIBsxL2gG5Mi41CT2JQwqIk6YEH1SSvyY073LQSHdV+aVPPL/voo8uNNN5vq0dlOb5D43gIZx+h/33k3mW3GFjEpJDH7xJybXMCy0meCxkneGSS+l65z7pk4LmgaIuoe8Ad7F1yOA9R4fWAi7nMJzOqlfNstx2NJrIarx69urFBhrt62OQliKyxRWbtkHb0S2TTSy9oFWSE6ld8HjzdNyoUoRObQ1uy/4ksQZNSU3fTXb2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PDUuir5J2lItlyYj4Mj2vO/SEvz0bGaQ7VzYfibupowCPApNLHGyq8abtbYDbLoU+ZbdYkjpNWG0lvkRdGDzck6KbAltSiRT3js4rt6L+DtlP3s365Aj3EgS0Ud2RB5JwnfvUyo2ZaNS7IvNjIVUE/GTEueRp03bswQazlr+8G4b1HVgY3ogbGuaty1YS/4cYoSCUKTvX0rTGk7MYTKxqRCD+99iHT7nzdE+l4ZzgkqH6TXI7vWt+vaC3Ce0XpplxchdSl1imPGKXt3xJX2So6dPnEAWMeSuTYoQUChUqoyjFzzf/MA++UUL8fUuzKJcesh7aUiJx4n/mhfOYtpXhlMvGUdbXvk4c1DyUItHRiPspPiPzfGqFGOgP311AvFPKHcRwOJPQUGPGOZQ5FlTr+jITo1KcJ+1zCYMAMgkGL2eEk8vBneDn9K7P5QSIPN5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:42:29.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 735f6d0e-8d34-4e4c-91cc-08dee276ea4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The CRAT parser validates that the subtype header fits within the image,
but does not verify that the advertised subtype length fits. A malformed
CRAT table with an oversized length field causes out-of-bounds reads when
kfd_parse_subtype() casts the header to specific subtype structures.

Add validation that sub_type_hdr + length does not exceed the image
boundary before parsing the subtype contents.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2a239f45fc24..6e0df685503d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1412,6 +1412,15 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 			break;
 		}
 
+		/* Validate subtype fits within remaining image */
+		if ((char *)sub_type_hdr + sub_type_hdr->length >
+		    (char *)crat_image + image_len) {
+			pr_warn("CRAT subtype length %u exceeds image bounds\n",
+				sub_type_hdr->length);
+			ret = -EINVAL;
+			break;
+		}
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)
-- 
2.34.1

