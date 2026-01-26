Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5661C88E43
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7ECE10E013;
	Mon, 26 Jan 2026 03:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1r8LRDF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D53410E013
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuCnIEDIpJGQJzPjGGukBGGZvxij2E4l2LzN7NOotxQGNyN6DfcdeSjznJExqJgnTmlThDgLvTqIa9Xlxulf0ZQDHjsC53YnIT3foY2sS+VtBh0aBP5yPl3I5RVfk682SNyjYBzYJ6BjKxUqB2yTClZdP2Ehs3Ivu56bTqykOlRSET/G5e4xbCXz61bGrJu7nq9sp1c98WIMA0iFjA5ek2/6/cUTO4WHntHmu0EQAb5s6Xy1SBs6FAwZIm9W5oFhPPuNsqsmvqdd66fmEBbxYNJP3ldZ/nYHEHCuCqnOvagO5kiiSVmAZXFps22uqNY1ISXHTc0+vg09z/NWYLZcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goxz4lhDCpr5nUGC8w6o2nuhiu4Fi/9Q95aPRCrK3Zg=;
 b=ABpCLDDYgy5z2v2WVRnNTjVndML/zfKRyveopPqjLogDJYlHD/m+6zy+5bhA9+H71jRJzIzczZifLgb2bFKIQM8ffDMEP0zAobszCHYErt4eWvbsOiiWQ4rlOpTntR3OYkV9bZQmC+Yn4k544sS9I6wVi0F/KPn1yoU3gwPBi4WwlBUvZfYSH70k8o+yZtxGa5JHzXhmR47XqtZfvn+WIhbrqZObV4vG47EsJoxd13KxS1gGs9iCBY7jt0JBJ1ASWjBuhfFfTW3vC6M/qVggyG0dVpO4pFHH0hXX6nvroNIwRXZ9g5eUxn4pGp3XGw0Ky5MSQt5PhLaiC22H2eKxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goxz4lhDCpr5nUGC8w6o2nuhiu4Fi/9Q95aPRCrK3Zg=;
 b=h1r8LRDFbYB1gVmRVg/J7Zg4QIbc3vDKA/gYsJnCH6Cm5ihCWyJWNWrNmqA3MPKqivI8w+3lph/63OSMBCbs1rHExq29Wx0N0ioNSW+POkw7SrHu0qJBcP4cvnNQQG8ZQQ5J8ueODd/P+u2TN/7hZQRn5ZPzAXLy0vWLDAUG62o=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:46 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::e0) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 03:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:45 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:43 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 01/14] drm/amd/pm: add pmfw eeprom messages into uniras
 interface
Date: Mon, 26 Jan 2026 11:55:14 +0800
Message-ID: <20260126035527.1108488-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bad2e9-5ba4-44ca-640e-08de5c8ec897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/khfy9tJTm+sQKnjrp2fPkcPWddNSFnzaaA267sK6/3h8GKZzf0Bwk6A4aC?=
 =?us-ascii?Q?EObqEUKAgaecTDm+CQf6clUj6Gq3JuKaxv88+elNI4a6OEshJWdSSyi35UtS?=
 =?us-ascii?Q?QQku4KC1GObaBMZL2bGLo8QR75WLC9DNxoTyoai4/qf0cf3fOjFfvq62FSof?=
 =?us-ascii?Q?sNqHhCce9aVCHhK68pScF8d1duTz9JbM3Qh2LAvxTQETl8u18DiHbBrKHMF6?=
 =?us-ascii?Q?8JLbOKA3PE3QYVO6ceOpFDl6B7M3mHOVoej1YuRnsZNfSOHJJ4dnIQ7gX+NF?=
 =?us-ascii?Q?D4YJio7RBsLl6DYcerhxfa7DG7huYTcHrUTEuRP1rfpKL3OmpNiPCpYWmhGz?=
 =?us-ascii?Q?9KFurqr13OOW1TtK+daXqYILlFPh57rjb63eI8RA7RnJdjNAUpuR++b1Ckne?=
 =?us-ascii?Q?9rumBPuu4YIueVsHTaKNzE1acbpc1Qtmrv6z+AKClUWLG+poeCXtxX8hIGyJ?=
 =?us-ascii?Q?idCNwRPxF27vmc4yaUe4B+KOk5EcR1N9SGrzcabAfPXQc5LEcQXMVMNZiQlE?=
 =?us-ascii?Q?zD3GbWt5BwRUQpYHKUTLMzebc96AnPfkcF/1Qn5WV4fgpNxnjWP0jLNr+ram?=
 =?us-ascii?Q?7Ml/PIn94zo56CUWPLiBNdKLL58j0BqyvuC7NsDAtKGDlLQ0sscsZu2ThwYf?=
 =?us-ascii?Q?7FeoEzyd+Wls2L/d60+9mc5bw3ctY3m7qcbP4uBMFUCQykiiPmPlHc3AKVxd?=
 =?us-ascii?Q?q2tl2pDebMPqRRKjSEP913y42XWHpo9BTRrltLeUavhryIPEeY4bwkn9gSGJ?=
 =?us-ascii?Q?89n50aaTnbvcRkwitbCyOmExMqalZ+Yo8z9rS68AZXZ4KQUenMKmkkkrfFVy?=
 =?us-ascii?Q?kIflfhY+TNuNvh5rtuX1WHB/NzllKQtcoyILrN+ZeIWV1L5fAaKRsJgQFa+r?=
 =?us-ascii?Q?fHJgsmlpHPLQiKcrPbl7YQUQjbKKsnGV3Iu4DkVMOK/s9/nXfhc+hgwkfr6m?=
 =?us-ascii?Q?4H4E4bBUmTbOxWpwjVJyopBrg7j1BaJbkRm2VZlBCUvgp+YCAfGSCXNOpIKF?=
 =?us-ascii?Q?O6aoPEr/1nGaDBtApBg9LVz/w33AGYAMl5GuYNWrt/PI3e4Ir8eAO+VmiSUy?=
 =?us-ascii?Q?8s2yV/uE0ddx+hCfjo5P5yiy9VOjp1RtUkN3AtEkA9owA6MwiT8H9tVMnHwl?=
 =?us-ascii?Q?UE6iOjo9J6xeJmspopWIpYHcS8bejbAWvO+3xqYiJNtlx11TnYQDyIMI2EXC?=
 =?us-ascii?Q?3cN3YbhwXzZNt/8T8I2zdRAH91Bj4FxwYYYfthuLiUdAJyKIWcIr149lukeE?=
 =?us-ascii?Q?HdM27D54LVk5WwX0ctr0Szmo+xQxlpFRaa9Qzfy2JwWhZJc/yYSeY1PpatK+?=
 =?us-ascii?Q?FEoP4XQaaocYZJ1uS2VFyJubJkcEk2q9RT+tvhAFCEhKeyPuFZ06ISSzFtLH?=
 =?us-ascii?Q?UDwqtQYHa2mm/NEtLfqvHoVWU/DDtiiA2wqPihHbLn0ZBmKKQrtBMlyVlrox?=
 =?us-ascii?Q?YLDbqD9gMbwnhPeCeA2/7m7I4//JPUli17qchc+mMA7Ocsv9A50FJ46Hjp5H?=
 =?us-ascii?Q?37TLGzWwDLs7zB3d9HPOFAwzqxw5Nevk4Vma8su0gSyrTkIpcm2tDZmV+iwU?=
 =?us-ascii?Q?bzWm113EOAOwrmAX0buO5Y4ygjifApllA2R+tLBeFfvLDecTuqjcvE+xPN1B?=
 =?us-ascii?Q?IIXp2mXPw7x/PlXUHiBGi94ZhWqijzPSNCNdNWS46m1+sAxYANFvqU+eyh0a?=
 =?us-ascii?Q?P+LU6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:45.2928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bad2e9-5ba4-44ca-640e-08de5c8ec897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
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

add pmfw eeprom related messages into smu_v13_0_6_ras_send_msg

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 57f4069bc827..81b7fafa1817 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3505,6 +3505,13 @@ static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_ty
 	case SMU_MSG_McaBankDumpDW:
 	case SMU_MSG_McaBankCeDumpDW:
 	case SMU_MSG_ClearMcaOnRead:
+	case SMU_MSG_GetRASTableVersion:
+	case SMU_MSG_GetBadPageCount:
+	case SMU_MSG_GetBadPageMcaAddr:
+	case SMU_MSG_SetTimestamp:
+	case SMU_MSG_GetTimestamp:
+	case SMU_MSG_GetBadPageIpid:
+	case SMU_MSG_EraseRasTable:
 		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
 		break;
 	default:
-- 
2.34.1

