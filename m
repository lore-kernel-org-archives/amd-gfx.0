Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F5D70DE6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFBF10ED09;
	Thu, 28 Nov 2024 16:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5s0yNMj";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEFF10ED09
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tngBkf/BU474xyIulGM3EgDECxN9o8jElwdzGoO7GtYrEwcxl9ef4caGUgCMRnrv/H7SGVfAuqz7+JLpXW9fbZLJIcAkL6izSXQOSmMG7hsoSOQVEZ9+UK2K6V2QE2TuvWVpUj4IUsXzsGhswXCRuq99r/ZSBsiwJyTx9tzS6jd++UiL/TUBI/S/L7gQ1aSf8mC7ydPwgrKol+LxPFKw+b5mCWgflaK2HIsplBwfH0GplngeQZfOIuJ1WVDVSFq1xA+v28wPrXI93nOCZoDNWxEWLCAhldiv7hsobomR3h/ePeEflDWUAqa+/nC006Xq2gTMZPBk4N6fx8rEPpL7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShEggHCv/sI+c64KNaVv1xz1nKqQa2vwyUiRx+ctXRY=;
 b=vhV2hdP2YLB5EJbecMIEPcVvaqfnDPJcxCmGiRYCx0VPOatgrUVZ1iHZ+SkZ+W3a6tECaVvqznJ6ODcnedKmTg9Xrse5umDcL/8vpNWDQaMqZLa2ggcHR1Dfw4Im53SodoJYiw1LPJ45C/Fe8fvaD64/kU2NLNFLyOnrwkBXXMgTXrh2azX5ypg0qGTcGPdRWUiugltBerGo/U8OgH++aYhBk1OQwVqKw2lJMocgHv4VhsWJ/Rq5zNYxoOsvLPNAvV0QwrAit4iXsCYE6/i0W/biEGQOUt7008wIrowV8MI5jFMP9WtTMPcRxxuMxipKBGNxajm+uxMqcsp5PiDeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShEggHCv/sI+c64KNaVv1xz1nKqQa2vwyUiRx+ctXRY=;
 b=R5s0yNMjKv4FRtYdCabmcsv46h/VIwwB20BcoGJb1vjPykudtikZqMWBki969TY7F84WR6WokuvDOnIJWMkmyKf+96sSp8iBqmEhBLH/p78/h5243ypppIFLwtubaiU/B6trwFVA96j81g/49kpaQqMCO9FxV1HIxrQr1hVEZk0=
Received: from SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::29)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 16:26:28 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::80) by SA1P222CA0069.outlook.office365.com
 (2603:10b6:806:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 16:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 16:26:28 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:26:27 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <andrew.martin@amd.com>, Andrew Martin
 <Andrew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Dereference null return value
Date: Thu, 28 Nov 2024 11:26:04 -0500
Message-ID: <20241128162604.966580-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 422d20a7-8e20-4c98-1b1a-08dd0fc96913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0Q+ZRR2F4sBmJpSoXH4oCDBs0PWfXMfOtmfWGtDFcu5LE7qhV5OvJ0mL6JX?=
 =?us-ascii?Q?kuOUJ0LOdD/kp1Nnwmw7GB6SB/Aep+VjCD8kWXzE11N2A1ywUUf2HIWDdEZa?=
 =?us-ascii?Q?y6/EsnGD99v+rDc7mf/15iLWvVQlm6dIGbO/+OpJLs2zUdBIIO8JUpWmyO4X?=
 =?us-ascii?Q?VmS1j56jQxxvNl2ly68J2/AWWMioZvN/MMm1lV/yAekRWIvywmJk1xxWPhq8?=
 =?us-ascii?Q?B8WunF71g4IQdwY+mbHofBfZaH3ColtgVaJdXpNXmG2dWk/J2M6yX5Lc4GM8?=
 =?us-ascii?Q?5rP0dqg8P2+QrsoH6lnR11zWrIJ9MoUzVx6UZ9WwzWiXSuF94ax8HSFBL37P?=
 =?us-ascii?Q?DsCT0yYkDtSkKxMH6/RxJfGs+YMSlxsgdHJu0mObGQ8ZxkezHIlutUbTLrub?=
 =?us-ascii?Q?7mM4I9WzIbqyRRumN2OybUIswHmQiXWuzYZ1F1E7cwxJ8KSX4itTuqdU6IHa?=
 =?us-ascii?Q?+q3I7t/4241aMlh7LCWjxZuCXOLcQhhurra0alBQuHuWRRttpl3s3LN71Ckk?=
 =?us-ascii?Q?r1BrUDP2GsTfdwcIdDhY9LVogORm9+z6byT+rBFy0HdzmRpgKA64du9w6/Od?=
 =?us-ascii?Q?IA7UCAdDlhkjo0Jh333opotBmEoJusQtK8Hir9We7Dc5w9ocjUE3eUM6egs2?=
 =?us-ascii?Q?ga5Y4vutJJ0H8Ggj8+YQRPMJ0GpIV59ZWDiNm4kcIq+yz6vNsQl7zkDTcza0?=
 =?us-ascii?Q?tH4Yk5q+2Fr+Dw3+njvyWKdxsdpiTfrxXuI7ycXNS7myxabQ1On6pE18MS2+?=
 =?us-ascii?Q?dTBN2x6zXj5zkRZaTYKYOgK6cXyW8ZRMQ/qOLImEXFeCKXoTs1p+8NO8qXi4?=
 =?us-ascii?Q?EU5FHPHJ6xrRtTYmw8axj4ESqiByxVj+BpmG83PXSZGdMnoRGLO0302ZrfLx?=
 =?us-ascii?Q?cGbX+IvBdiW2soJH2xmdSNEKrdeVmuBjQAldl5HbI2+G799wZYK2TNeXacek?=
 =?us-ascii?Q?154PrYshluOIrqoBJkDDVMVb9JKTz51WfNSFIlZjguQHtdns+obNP86vGHEV?=
 =?us-ascii?Q?MJcqyxWn69iRfGsRKgjV4jOBSZ9X8yXSc+rfggow5yfZh/Dwjjurd8TA5mPM?=
 =?us-ascii?Q?g0Izja4dvqUjHpyRGopJpH/XfQ2fBPUjJvx8U3jqhGIQuAJXuaxt2yGPFSCo?=
 =?us-ascii?Q?oqB8NZYAjwTQ3nI7LwWMvERpLzJvbxDd8gguKvzN+5jMqVXoJXj9M47Fu0Fx?=
 =?us-ascii?Q?DSzF5HzYyl2x1YIRPuGO6PZ8bCHxH6win2W0So2dmLDOJkxT0ykUz30zx/Rc?=
 =?us-ascii?Q?C3MiwiMRlnxpB58grCPjmxXFxlj9Rh70ksVNLW93jY0SazjhKGNsXqon6XF7?=
 =?us-ascii?Q?7pb4/5HLdblJBEHi+NalyFcQd0wrgIVKe1zBUDIAy9Ma4eE5OR9t4QM/r/gA?=
 =?us-ascii?Q?525ed/E/YHc4AIWGJmLDKXCuH+SEwPZhNlWp2RNONhfu4AlHImqwFeJsNFLO?=
 =?us-ascii?Q?7853uip3rDTEC5+jYsOqDyNGxFmXGF6P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:26:28.1400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422d20a7-8e20-4c98-1b1a-08dd0fc96913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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

In the function pqm_uninit there is a call-assignment of "pdd =
kfd_get_process_device_data" which could be null, and this value was
later dereferenced without checking.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 .../drm/amd/amdkfd/kfd_process_queue_manager.c   | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..808c447879c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -212,13 +212,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
-	struct kfd_process_device *pdd;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q) {
-			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
-			kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
-			kfd_queue_release_buffers(pdd, &pqn->q->properties);
+			struct kfd_process_device *pdd =
+				kfd_get_process_device_data(
+					pqn->q->device,
+					pqm->process);
+			if (pdd) {
+				kfd_queue_unref_bo_vas(
+					pdd,
+					&pqn->q->properties);
+				kfd_queue_release_buffers(
+					pdd,
+					&pqn->q->properties);
+			}
 			pqm_clean_queue_resource(pqm, pqn);
 		}
 
-- 
2.43.0

