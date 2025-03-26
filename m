Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322FCC3601A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6732410E782;
	Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/vQ32na";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB7F10E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqBN5zYiWrxrHy/WQm6foyhue+EjB5SMdiVWjLhYqd538vW/GWp8NRwMrnwSQ6gua0h0vWoFpL67znnhhpusJWmbK4ZExGt/HLJw7jXJygITwEewx+9Ed594Vwt8JMj5w5uzucbzmZ25f+sddRTWI8/vwxjjCdn+/HMJabHciU6X3rhL+qdou68N4Vt16z3SjwqD4+xyr2Tkz901jMT2ttrljrpaPWTLtPE1fhhFYFdiX9euflRCg/opueG3t2L39tW+2Qu1/A35Z2CQyoc1Ss85EV1cbfEna9cnPM50qoQyk3H7JKuqMlxFFsBZ3OD0b6bs6mVxf7fAQpbon7nb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJk+0MkLlYxFARyQ/1I9VYTSXezN5KZyF+KD8zva+RY=;
 b=XgpaGQSSWoAkFjsHm1dAZOUF/IZ5ujT6MLEEqCqlgcSDOxkSXg9NiyQxjUkGGXINs4xbyzwKOnV5wVFqAJL3eYVr2TocJ55kyOE/c6Av3+mF05g+1QgDndDVnEdFKv1ZGNh42P9BBGEXjVFhIrTXM0PS5iWp1F+aBE6NxU+oWZ8W9XWzHjy+W9uCrbQuqFIzi/fQEzlgVwurBTMFiNn632PaQFaw+naPkgWCp7+cNBUYjLaNc1bPn77BXTZXszcG+oe1M1W4N5viuWWZl2jho3ufQdnaagq1Uaqu/y+xuZ11TejncJ6V3tphzSoP6/QzFd6xS45txYkQENZ/F+elyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJk+0MkLlYxFARyQ/1I9VYTSXezN5KZyF+KD8zva+RY=;
 b=x/vQ32naZL6AyNLMxgBvpUJLraKAPlUpPFKPJh0xkcWgKPlymtdsFzQ6FzBZ5tk8UfjO4an/a9T49WJFUeC/A0OCng3d+IdI5gvSVVg8JdMOIYu9AxflOd40Rj6Zz8jGwn3EpHMPKMGYoSOX95ENc8GP+G0ahl+e7SbKgbz883o=
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:53:09 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::cf) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.27 via Frontend Transport; Wed,
 26 Mar 2025 19:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:08 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:07 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 02/17] drm/amd/display: use drm_err in hpd rx offload
Date: Wed, 26 Mar 2025 15:48:59 -0400
Message-ID: <20250326195202.17343-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: e04da68b-845b-4f47-97c9-08dd6c9fd53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ULPGeY9VDroIFkeXUjl8aslvLruI2rt59u8NL3OFBQNeWrQ17Oe/8g5zoVP?=
 =?us-ascii?Q?2MSqkCqGacA3loC2lGE5fPFykYllkwCspMT2X8TEkS1JkvMQ8cTG2yyOvC0R?=
 =?us-ascii?Q?vy6hrFwxun0PvzQYlNzJHwMZdxTEUqzUPxd+bpl40P+vKHw6PfGjKjfzK/i+?=
 =?us-ascii?Q?CweqsrqdrzPaN6ZGZGJqHeILca+W1qC4SPIDv33pXnpSV4SQqJswAtM21rRG?=
 =?us-ascii?Q?i9wnImZ/ms1cQIZWCkeOTAL5eErWRKLkK1MCMaJjCEbEyExSlHK2MPKgmk9/?=
 =?us-ascii?Q?2Fw/JwuTUSdcgxHqec6Lq9NFPuMobsNv+eaeffpj+OmARVr6ULnpFP3S2et/?=
 =?us-ascii?Q?dA8iz6iDa3Wha4M4zsKJobiPK+6tkaBJmBukuER2uAFoZtVivDGp6PuMMsDN?=
 =?us-ascii?Q?lBP1DvQAW82iLtvQJgePA/sczaD5fUpWx40IjdxZsPw2u8owU4jqWN+RfCIE?=
 =?us-ascii?Q?BzTGt0byiwe2sw42XPMPWWJmlRgZeRdAkrumE6kzg0P1iY5YMVm5jH1K5N1A?=
 =?us-ascii?Q?AvXzqLeHFQaop81mB90CT6hEYAxt6M7db2heZfiDG1MmbtI8fsE0IgreaRcr?=
 =?us-ascii?Q?BoQue1s4pKFg80gYa7//8x4rUU8DlAxZCPmK9uXSw4QTlEYuV9v1lAuMW/i6?=
 =?us-ascii?Q?66BvRBM5uRLPaPoP4XbehMUpGuj1w0n52cCzhBbDJxxmUKf4eUnUGvKjZBzj?=
 =?us-ascii?Q?guzQr/OE3Pw/RuO3fY8b0pAP64Dw8tgAD2XanV4k7NvYEsezRe1UzZa/6uUT?=
 =?us-ascii?Q?SQg/zY8lVAb5GFlIwJG7j9XM6Td7X6r1vOc7zXh8JLa9+YslyxdiiLYpTbPB?=
 =?us-ascii?Q?AaYsqrhMVKtp0BTq4KLQr151bHO6wDQV4OaA+lAs+FyNp9Lhnp5C5I0osnBe?=
 =?us-ascii?Q?2Kg+Nh1Mmxs9T/a7jLQRB9acYquau8ZrgW35LFkuTopdsQizhGHkc0ZlqAZO?=
 =?us-ascii?Q?KJoFHCoRllMLtXHgs8DTiDKT+5brhGuKeGBnm2uYwHHvqiwX4hT6DXMUjNGM?=
 =?us-ascii?Q?P4aDOKNpfpPwM3jPilFZ5SDeRhdc6H3ICcLX58Wt/AoTSEbVKXjFcReNc+54?=
 =?us-ascii?Q?LCt+MDQ95Z+EWQdzzR6Z4/tDmNs7TwwN4EkDUWbrNUSLnqqCURumRQcr148F?=
 =?us-ascii?Q?ItqHPRxQDUPUEXeIcgmHZ0v1Zfapv5NpdT37sOGtFuXzPCn5fJvpyQj9rwNS?=
 =?us-ascii?Q?qV4SxmqmzP+x5M7Y1zO6/v3UYsDGtwzM5oSZA7a1CT3auOyKmA3/GY5SZcHj?=
 =?us-ascii?Q?XBuVpTOLg+X8wfBk76v37Y6ZvO1/g5W/qJpRyoMOtqD64BOsPSPFoXzPPfm4?=
 =?us-ascii?Q?mjIRISopsYKkRT0TMgNmyqTTIZgwA2YTveOunmSaa1WbbHcvxrrFgeVMAWdf?=
 =?us-ascii?Q?b6Pt6T/jbH5NrLyfnJ5LgMe9ihoyFrAgV9VD9yVSUD9Br7EWTXbTYU1TOt4o?=
 =?us-ascii?Q?gTcYc87Tl6et++0jLtJ00S9siUQSVTAB7cIQo8R1l9MCBmhhmRGED6fUTrmk?=
 =?us-ascii?Q?rMTF3znsg+qZfWI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:08.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04da68b-845b-4f47-97c9-08dd6c9fd53c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

add amdgpu_device pointer to data associated with the work struct
such that hpd handlers has access to the drm device for use with
drm_err()

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 ++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5117f5cac67d..16e2823f83b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1480,18 +1480,18 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 
 	offload_work = container_of(work, struct hpd_rx_irq_offload_work, work);
 	aconnector = offload_work->offload_wq->aconnector;
+	adev = offload_work->adev;
 
 	if (!aconnector) {
-		DRM_ERROR("Can't retrieve aconnector in hpd_rx_irq_offload_work");
+		drm_err(adev_to_drm(adev), "Can't retrieve aconnector in hpd_rx_irq_offload_work");
 		goto skip;
 	}
 
-	adev = drm_to_adev(aconnector->base.dev);
 	dc_link = aconnector->dc_link;
 
 	mutex_lock(&aconnector->hpd_lock);
 	if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-		DRM_ERROR("KMS: Failed to detect connector\n");
+		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 	mutex_unlock(&aconnector->hpd_lock);
 
 	if (new_connection_type == dc_connection_none)
@@ -3912,20 +3912,21 @@ static void handle_hpd_irq(void *param)
 
 }
 
-static void schedule_hpd_rx_offload_work(struct hpd_rx_irq_offload_work_queue *offload_wq,
+static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
 							union hpd_irq_data hpd_irq_data)
 {
 	struct hpd_rx_irq_offload_work *offload_work =
 				kzalloc(sizeof(*offload_work), GFP_KERNEL);
 
 	if (!offload_work) {
-		DRM_ERROR("Failed to allocate hpd_rx_irq_offload_work.\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate hpd_rx_irq_offload_work.\n");
 		return;
 	}
 
 	INIT_WORK(&offload_work->work, dm_handle_hpd_rx_offload_work);
 	offload_work->data = hpd_irq_data;
 	offload_work->offload_wq = offload_wq;
+	offload_work->adev = adev;
 
 	queue_work(offload_wq->wq, &offload_work->work);
 	DRM_DEBUG_KMS("queue work to handle hpd_rx offload work");
@@ -3967,7 +3968,7 @@ static void handle_hpd_rx_irq(void *param)
 		goto out;
 
 	if (hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
-		schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+		schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
 		goto out;
 	}
 
@@ -3989,7 +3990,7 @@ static void handle_hpd_rx_irq(void *param)
 			spin_unlock(&offload_wq->offload_lock);
 
 			if (!skip)
-				schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
 
 			goto out;
 		}
@@ -4006,7 +4007,7 @@ static void handle_hpd_rx_irq(void *param)
 			spin_unlock(&offload_wq->offload_lock);
 
 			if (!skip)
-				schedule_hpd_rx_offload_work(offload_wq, hpd_irq_data);
+				schedule_hpd_rx_offload_work(adev, offload_wq, hpd_irq_data);
 
 			goto out;
 		}
@@ -4016,7 +4017,7 @@ static void handle_hpd_rx_irq(void *param)
 	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
 		if (!dc_link_detect_connection_type(dc_link, &new_connection_type))
-			DRM_ERROR("KMS: Failed to detect connector\n");
+			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 		if (aconnector->base.force && new_connection_type == dc_connection_none) {
 			emulated_link_detect(dc_link);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 85b64c457ed6..53e49c1d0ce0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -276,6 +276,10 @@ struct hpd_rx_irq_offload_work {
 	 * @offload_wq: offload work queue that this work is queued to
 	 */
 	struct hpd_rx_irq_offload_work_queue *offload_wq;
+	/**
+	 * @adev: amdgpu_device pointer
+	 */
+	struct amdgpu_device *adev;
 };
 
 /**
-- 
2.43.0

