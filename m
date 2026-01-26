Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070D9C88E42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747EE10E3A0;
	Mon, 26 Jan 2026 03:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xX0iv1Cx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E7410E399
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR7OHPfGFNqb7mCzVqlsJPBjHzDebooRNh4HjJFcq3RyW3CkJgEE2/bQEEs9rjCyuDoMLx0iPS+LKemq8rm19XDZ1a6ZGSwoBDCMerT/JpKrPH+WoKRKGyhMqx+M4o4jR2m2DTr3lQap8qb5mjltU5LNZQJ/XnkUVxLmnXaIKFggmlQc35MOdCI2NuXsChX5WAQrwhPlSCENHwzrCLiLgYvzMaPhunzaBLtBpF84AOLRsh3umH3vBlTS61PwSMRu3bqj//3XNdNLoUtUJUGEDCgV0mmWAIMeoIx4jdDvyNZWPt4qOZ+PAfURG0WJsu+njtdQ0POswmGUsmYofB+FnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckN8FfJV2lMD6/qa2otQpH88eu5ymZFJZvOH9oqAc8c=;
 b=tUS04UHn6Ii7bLP4LeXX1oaeJE4R5Aun/hCjTh1G8LKmsP0FbmkiOjRBCLxv11urZ27y1fGGXvnO9uuvjHXLUAZAzPkKrJQs3eML6rwYvCmm6fIG1CFsA7xFDfWTF7mYWCDjaI9H7CQLB6F9ERI4HLCFXb+bTI/uH5wbBM1Q+IQD6CHQmaLOqkPlq4P0QGB2YCGhiR4/e00VUnApy7v4aRXKZ5KI99mMlaC+DKFosRrDiuDJ981666HqbhFaDEIZktLs2talwSW1p3mF/jUXBKqD7lIyoIB5DBr3/rjI1vtCy459IJXKPMSW8tCV3CCtjFZG5QC39FjmYTxp1U/QDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckN8FfJV2lMD6/qa2otQpH88eu5ymZFJZvOH9oqAc8c=;
 b=xX0iv1CxZsuEEqVcjTwrRtsW3LlI3Qownl7zthCJ1qq3Y00LX7LfIWC0wwuIL+T2J0LNtqq3m1MUS25P2d8IJhGto8NsstlZu6JMeNlz9082d/S3ZJsNvreUHOE1LedoqdXSXbp22Ymz5/gYIjaCwwiaSatFp0n68p4KEozE8eY=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:15 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::9f) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:14 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:13 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 14/14] drm/amd/ras: adapt syc info func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:27 +0800
Message-ID: <20260126035527.1108488-14-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 256923b3-dd08-4290-653a-08de5c8eda48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wRMXQRIhQoupffX1pPAtXqSfk3kC3VwkY2EakCW3x7StvUTtGMN1zWh1sFPQ?=
 =?us-ascii?Q?CxpeoaMvmrEVAzm0awUy8k8FHiVStYayEx7fpooHRY7mW4BHy6tbL+b9+71G?=
 =?us-ascii?Q?aJJgOd5VN14Ei/ePBdM4lgPfru2WogzH+nn6wXFMRvGGYu4Yp051Dr7Hk21D?=
 =?us-ascii?Q?cjztaYLJP8DmjBOwjo35sJ1a1nA49qknsq7rR7QsjUYF6ihfnmyJ6cdFski+?=
 =?us-ascii?Q?ZwTGK9cCe2aH8VzL7MdV2m+AGE1fpaITQBUNTp/faRsncHEt5o8pMVBGhlY9?=
 =?us-ascii?Q?VK0VwfGZCtHcTlAQuK3V1ltrlqBkrZW0KKVTfe1T51896OF42anL8Jjg4GUn?=
 =?us-ascii?Q?9YdHZXZc7h8dKNx2nFA3vPrEzEANmL0P3ZFTl/wGfCmv/CSgDgGc/XODfMND?=
 =?us-ascii?Q?Hje+IkpdHeBWuf3vFjE0YgM0ZKeqfuWR9cu/T9C/8y/mADhdJ+9pF2Iky1V8?=
 =?us-ascii?Q?Ots6FYtRVz8oPcLR49qAGkiQdP0ugVP/ulw+jUniqWdiaacQN3N3P7gOO4a5?=
 =?us-ascii?Q?CVQXbB5ltDXtMGNXq3Hm33xko/+BzisLv/o5KT6i+fi9/d9OzEJl5rdw1vKt?=
 =?us-ascii?Q?Pe9gTz+Mq0t6L8LDPxj/CkAYlXlW4JOGmO7JSNMJjfF7OqZ9KaJfRuNhxtEe?=
 =?us-ascii?Q?ow1caESClQHsM3C9HTEL/4KXC4Pp4P/JoCsKJrjlQ20ieeXFHlK2RsbO5p01?=
 =?us-ascii?Q?3RdfaCiRdG2ACfijHSM2M1bQKql3nbT4zIlz8qXfCyhsYYkrLJuUNS4hAsv/?=
 =?us-ascii?Q?eWwB6DaB4uGFjUwcxmmC9RJ6hZHBTlJMF8jYtsWzRg48XuzdLYAuS5+YRTOl?=
 =?us-ascii?Q?cG+xIKOCWd2dw17gWJDNQDJFLBXfUTbftqPjB/DOrGLY4d4ckboXqPevwZ1H?=
 =?us-ascii?Q?BxhXsD72kgURiZs8yyySGvHBhEpwXbDOa4LMiZAh2zcv4wy6OSMB7/LqCmQL?=
 =?us-ascii?Q?zISjb5Wc1eCw+v2PRLaBw6AG83FyghR60Rc73DQttuY6IqHvLJJuQhMGv2iT?=
 =?us-ascii?Q?f8GnnCADYGClnKRsfCg5gyz+WzmpbOeuiS255jNZ2AJH6xhlyoH68kCi9fX0?=
 =?us-ascii?Q?lq178/r54y2sZMZodfDuqG50jfJHDgVu82Zz3GZWJH8zWEJul9mHC/gTfPIS?=
 =?us-ascii?Q?9OeOx2ZvmvQsVjDMNPgv3rKzhgNrMXLD6D44ttlF4QfL6ZBsazzG7kvkbvKx?=
 =?us-ascii?Q?Xm/LpBIAJBlA7Yup+cQk0Ug+0vQ6Q+vozn7OWOhJR0udvt13DJPJk2aNT5r1?=
 =?us-ascii?Q?T9Om35jv8n/3fS9cn9ZBTAPBtGQoB/+YV7f3rFC9SzCVh2YxtUCTimsknOcu?=
 =?us-ascii?Q?ErXvFYsXI9b20fkwW1PDEyYr4rIC9T2T4LRVW+5G7H24Ms1CjLChFWYKk2MS?=
 =?us-ascii?Q?b42TpmhIyIfS5XwrN4WFd0mO4yInkFoGMhCrQVijMCA2X+KWwUCDNs2805mG?=
 =?us-ascii?Q?pHS089lPwaF7A0Lu7MFu8CWEkYFE7jI3VFXKYA/mdM+brMgUjgfJCVkoY285?=
 =?us-ascii?Q?XfE+oCTWTchhawdwd9O3lmqq1e5b1M6GGWFGo0hOtMzwX7siNV9+R3H9+fHK?=
 =?us-ascii?Q?dDVDild4/lhPy7iCPHIjQvD1fhzTvLpInBXZuo7uPlvWpez5MeE5k9RyRMrS?=
 =?us-ascii?Q?gTulr+o6OZphYPLuz2AujKro9iSNhN4UD/u29e3M8ODXH4e10IFph5DOfvVm?=
 =?us-ascii?Q?J504iA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:14.9658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256923b3-dd08-4290-653a-08de5c8eda48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

adapt sync info func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c      |  5 ++++-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index a4e2ad6a159f..6a39e5499c5d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -256,7 +256,10 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 		return ret;
 	}
 
-	ras_eeprom_sync_info(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_sync_info(ras_core);
+	else
+		ras_eeprom_sync_info(ras_core);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index f7a71ea797df..5a02ec2d69f7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -504,3 +504,17 @@ enum ras_gpu_health_status
 
 	return RAS_GPU_HEALTH_USABLE;
 }
+
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return;
+
+	control = &ras_core->ras_fw_eeprom;
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+		&control->ras_num_recs);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+		&control->bad_channel_bitmap);
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index a0301e228863..dbffd3ce34f7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -82,5 +82,6 @@ int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
+void ras_fw_eeprom_sync_info(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

