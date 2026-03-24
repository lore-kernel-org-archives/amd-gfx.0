Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD3FEC0ED
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F2510E608;
	Tue, 24 Mar 2026 17:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lf5CeFmk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9F710E60F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImqeU0ip9yFotNES3sZEujre/ooHqyMs0HvafVi3TAcVeYmbiARaZyatPuddNQAXrb4PF+fbdIFiPVX1IZJHhaLGQnoL0rqS2y//wGfqB1aHNyPr9fzZLudskuxulEL74VgbW3f1189jLnuG8LhcmIdsEQiqjKLop3RbmeG/8KzP+ByDDcsE3fNg8uZW4whT2LpcC8xVQntWYPX/MJnuMBq26R3eXacY8iHZ3KOG53+tOMPEdrtjAhSN/HEWecZ3BCzn4kKSuvFp0YqRi0ZTqEqnxtT1wpMp2hQ0iCCdMiHjLnnWGTppFppIrN68FQT1xu7LeSlrcyu35UGBvEAZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhJ/b7pVfLUXTkGJrA/3wtRPUyEGbrEc22ifuQQlZcw=;
 b=XZKN+6QAUeyYF0iiixVXZz9ujK16IaGaSyLKh9hKXgJq767oYhdLFh+Va+PUYeh3Cz68odTSAc5bTbaf08r4In3hg0JDf6+Xm2zEKUe+exWxxCsnjeXuiS2Dgg4IkXMVb7om9FK2jerJmH0wGChmYMqTQm6GclWBMAc3yniNPEegUPCf9I96ZkP+ObQGjb1lA0sMiPy+WG+rXFzdBdsP4CyzETQoo8hT6UEtqfYw7EZrQ6pXBwlKuZbVHX06PC+GVuezEqd96byKFpoR7DL0CKlSUA3U+cPs6H3QZaEGvQ06MbdxKPmiJ18OqD4MPi0m4YY9e4qWviKyrnHwYeDiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhJ/b7pVfLUXTkGJrA/3wtRPUyEGbrEc22ifuQQlZcw=;
 b=lf5CeFmk/nbBTiyB0bPFeQtoayAQS3ODZGoyiGEgdDUhFAuFoqjJbB8KTfYx06+CdTAGl1jgPReJoS08N4LTLJ2foDUzjJ4GYHT2EZ6YySUzImLfj4hAhGhotM6TPWiHAGlA685CiTiPDvbA4BeA9Ic4lDANq8lkIh//dZmcW4w=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:44 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::52) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:43 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:40 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2 03/10] drm/amdgpu: Fixup detect and reset
Date: Tue, 24 Mar 2026 13:56:45 -0400
Message-ID: <20260324175653.1325754-4-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: ed09097d-50a0-419b-ecd0-08de89ced982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jdoxaLSevEwx9T4VVUFIr5FfymbHTdxRB6hWQ8/WndCuyLqtwmV/6p9qu7XcOMAldkUCbuBFAf6DSQTNuUtML2YMfiLegBdvjKlI/iuElZTozuChVqY9fKytgbhc0CbVvl3tU2bhJJHl5mmbDMDfHES28+7BSNuv28uM2LKecH1jo7dnBMp7oovfXJSQZuc2E1RpRsT/nDq7j01g3EOY3fi2MZ9wcBJPVUtmCJCStZto8ZaBTMm6TXjMlX9nxa99kSRzDvPX9Yn9PbNK8HczWash/pfw81lO3FCoydOKySOzrdH2IdnB0Co7qQZaLKQaezc6M5UCq+MDAL7tRVj6Qb0LkdvhMgU0yHWaAZ+iAUsAqyT1sABjhbVVOAEwFGO0Aho5t6UyHAmGHUvU3HP4p9x5hUS+Mz46q8xiL1JhkDM043uBEYIHmkAaSjROpzUidJ60PwIAao8GRO7R9KvczB/4diOJvdTNOcsLbJySW0JztqkT4cUqUx1FMzUJHVG30m3NjGUZGIvx4lCmlL9ipQPXYKH3hexjcANMEP337w0T8lgOGXae2j6Xri81UwbH/aeUkuDrzVEYw1EJYPLZDsQ7z5NnsO7eS/g7yH7TeLu8KOdtDMCYo4xCysixAlExJWvpqfO7AvxOfJXc4oIuhW5riSOQmr3MSXM/ayrCXGqj0LoX6zEKE68zS7stXR5glMt06uZGxVafFCOyHnEfChyUCbIHNw1JxQXM7cl/bl2kO3csB20OK1fpa9Q6dLh1MUwqeBhWCse1Ei+I24OQoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W05IdjLhUkvVt/o/N4BIXUqi0KGXQO69AGfnCIhldKc2JRMxHfyElwwNDgNAtyIJZGB3opoy5D1fQskNUSY+ZMtvgXvYWNmZtvYvNLNfkcoq24k08IVBcYUqhdjmTD0pLygwLDwNKoHh2LT/qmL4IPttK3kwX3M6GnrdDRrQth/+dFY5Lsmr8hpkiBe0tB4oUI68AO2AfCVnQK3ad7K6wq968yUA6CISW+6aLcxvbp2R3HsWXakoSVyit8TCJIJFZ/36XmqOportkhfgN2Pl+QkUS3xNyTYlb5sk2I1Gusklofh7T94pLdU4EPMxKcCUV/teNHAjZqLtdtA2xYBJGiHrrDE9PlKSgnctv+V4Llcc0irvQx2TsspXu1aMB4OlnzUmBESJUc4pR9g9Tc4qh6nsvDKJ0Mdf3t/dOutNDMI8zKid2agY+i9Abotuqg7d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:43.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed09097d-50a0-419b-ecd0-08de89ced982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

Identify hung queues by comparing doorbells shown in hqd_info from MES
with doorbells stored in the driver to find matching queues.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 38 ++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e639d6c329e9..f1f8bbfc31e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -465,23 +465,35 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
 							  &input);
-	if (r) {
-		dev_err(adev->dev, "failed to detect and reset\n");
-	} else {
-		*hung_db_num = 0;
-		for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
-			if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
-				hung_db_array[i] = db_array[i];
-				*hung_db_num += 1;
-			}
+
+	if (r && detect_only) {
+		dev_err(adev->dev, "Failed to detect hung queues\n");
+		return r;
+	}
+
+	*hung_db_num = 0;
+	/* MES passes hung queues' doorbell to driver */
+	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
+		/* Finding hung queues where db_array[i] is a valid doorbell */
+		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
+			hung_db_array[i] = db_array[i];
+			*hung_db_num += 1;
 		}
+	}
 
-		/*
-		 * TODO: return HQD info for MES scheduled user compute queue reset cases
-		 * stored in hung_db_array hqd info offset to full array size
-		 */
+	if (r && !hung_db_num) {
+		dev_err(adev->dev, "Failed to detect and reset hung queues\n");
+		return r;
 	}
 
+	/*
+	 * TODO: return HQD info for MES scheduled user compute queue reset cases
+	 * stored in hung_db_array hqd info offset to full array size
+	 */
+
+	if (r)
+		dev_err(adev->dev, "failed to reset\n");
+
 	return r;
 }
 
-- 
2.43.0

