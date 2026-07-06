Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85DCC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 14:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C33510E3A3;
	Mon,  6 Jul 2026 14:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aL935ela";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185C210E3A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 14:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqeJUV+rlLKnivk70F8bV+bZT1rdwaNwWJ4V78Ek/31gNV4/stl9801pAHP441WqwpXELIUqbHINoVBI2eC4++BM8W9xLSD40j5W8/eGhBC34l0b2m3bJ1LNZS2V+5qdtRej+uNpyd3Gcn9FYGjpoRtwdGx/GTAy1/pyYMRhoxbfPfjO/6gQWDHxWdb2UR+dyRxIoGsSkEBrY/Ftpp45JgkgQkMWQQVg/ddI5Ei9nFk55DNlVWCdVWx008lsrRJiz8bPyL2eLjLKEjgl1yus4jsKskeMTzL0M0xHFdwdsB/0HWo0NFI0ruwIT+4w0KkRzF3aC9q3WqxoYKuOh1ApAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzijzAIaf9uAfhkTx3KMr0j+ymL/H5EVu02mQzpG0M=;
 b=IrvmdOoK9pxD9o0QQwGLB4qYMD/DeyJy8wsjRVVBu9/dosE1sy1vJWCl7YV987xz53gjzZ6WLYlJkux7YYtdyu04754mVtxby3DwKqOobM09c3NlKC6N94/9BvzkrDdML01E2OWDJdBeN9ec1JTxoZnA+UTgLVWx4EYiGWwkaLBACFPOeuonGXrudGfBZaBZBjtbzFDZiSrJNs0BZFcqH5bXIdik7OrBV2Jf5/di/BkuOjWBDZ+kGyvoSYERNXX2KwNWM4/TEarOCDx5nG3mKzS8otJSd+CluJuqMdbyHzv0Og2UEDgMiMdy0ML4wz3iXXApVYiHpvtxkXnOkB0uwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVzijzAIaf9uAfhkTx3KMr0j+ymL/H5EVu02mQzpG0M=;
 b=aL935elaATvlqs72rppIlKXdJ89ysZ9sJKEHmgHlLyjvrNUwtFZHM5CWb0hnNf7ro9lwBFjcXaoVGTUgkyA6o4a64e7KxEUXuFOT/kHKHpdYVOphpTApZ0mpe5jMNuMTYHYQBXU/KEQggKrgDiGLbaqtLmlN11l7HAlrJrXRClM=
Received: from BLAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:32b::9)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 14:35:58 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::9a) by BLAPR03CA0004.outlook.office365.com
 (2603:10b6:208:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 14:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 14:35:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 09:35:57 -0500
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 07:35:57 -0700
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Alysa.Liu@amd.com>, William Palacek
 <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length
Date: Mon, 6 Jul 2026 10:35:44 -0400
Message-ID: <20260706143544.133714-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f7fe04-4828-497e-8a68-08dedb6be4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: N07liVfsOskOpmiesDNI7tmIux7A5/ykYOkSf93+7OV/KkBGXdtcGl58zJeMnmO1iFobf4nrwoUlnDudHgk07lt+j/oboKio68u2i/1MyuRNMww6XUTB+Ce50XJ6srtYphYunvU5lwF54Y6w7dmnAwobnSW9Rf/m9JhhH9MTmWGENLPDwfsqgOeMP+WGWmDIBxtauPa1oVPVLx0cW+yTG/xQ8vGMIaUXrKl9aj8DK+TxkdCi6NJzfDpqFmsQ8mRG3lJMsQMQnCfEyzP8zeajsoE7Kg+lypAChbOsUtDD2N99vEIHf31nn0a/Jn3sPrTwQ/foX9yVKNQEICpD7UDRrG/HrNoRIlseLP8zgh+wDOQynYzekRXe3QXlATAcQUchhMsuxbmT+WBoF5tPmoweOX7RJWLHz1pu+df5kWpcju83AFsvK2hvuY3TVyAPFAwovz+CXCY34BoML7gslZ6XkZ01BBwJQ/XDTcIA4X2+VGbNfu84q1HLB7R4tn/6WuMBJAyTP4BsI7o4sKOBO69RnHdRzn5C64Hbacd4QJKUI1vWtCJHDVi2ygailWzYHsMbzKMebkhAJWHHPmypc0pIrC4UOwxUuRVwbkh1UUMwm5v5gd1bdR4KvUFvOuwdCu3TAHpUfqpAl77VCsX0K+ZAIp9BZO9be33KZkTutlBrAR0/n8+Oqz/3MvfwaXpX7ODBEtU1qburSNndXVhUlMzazA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EWlzbjbNxGtZi0Nn4ZWriEQV7u44bmlEPLfQNoEgBV+26jLXlgPinw2A9pksKGgDvdgUcWtghgA0GH6czK5HVd19ZdiHw+61+9/eUdN1refVa2Gjq7/RNYvkhM6khhCwIxfisqQyOsAv449haqKrhJFfmKr+nFddpcyYt/OhQTmKPd0/wo6RMIUlTJb7HGDI8/MDDVcIPtft3RkZOveYTWg6JPGXcfMO/OVNZ1jzE/nes4pZ0T44rOgxi7fPsWxuZb1L/9tVG+htasF14Ee2tSzdf3gqHejHwxADL7jSHc9gfXmJ2dDyPqTz1PpkXXCMnK9yxyyu2/4lfvk3KEHc9pye2dLtdZVDWDrfXQDsJiubWsnGjmPeZhyRGSZonnLguEkrth9S040o3u3i8ki2plWZjONICW67mrQIgwo+cWAeKGMXR9peEegF9jiW6Bkq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:35:57.7708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f7fe04-4828-497e-8a68-08dedb6be4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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

