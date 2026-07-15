Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47312C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 17:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C7D10E1EE;
	Wed, 15 Jul 2026 17:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJMW/pXv";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63610E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 17:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY/HdFbAHoybdsSLosExS04/6DWbF4h5rgPrtopOU7ymNsAg8fJSKJBr279sYquKX83nZRCCCIMfz4bcwUe4P6y3TTDi4hIJsuzAxtT5alNxnKXLu2q1ne4a1giEc0dRk0RXFebaLrG4siqC5NtHO7NtXG/rMb/mup4pBQ+uef9mU8RgtD7xsiJYMSXiqwYrzX5SBGX2kjDmFuj7ZLHzWSS0phor5Z6XFLcExV5ojKgHNkzGaMFvd8BtGprgZS8AotQjEhmVdNKb0npDJA5VqLsvyyG+q4ErmSVkh9zGqkCZEom2kFls+dHsVjblktLyoFBYnZJrbv/+AwD0NuNVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBPH8rlu8U4nBaY6t2SjorZvckZge4KfFVtdCWniOoI=;
 b=fuqc2srCBPrDmVe/ERr5f25jo/gJuQa87XD4/6Ws7DiTEiRUl9kwXpFz4pbSh3bwJLPm2X9FDKoper9Ys/Hb2Dmyb7aASel8Ur0J81X+8gCt4Cwlw2H9ggOplGEOhOixEZqgvdd69mQCQE3TsR6RIAPnleGLUiruoB/zodYOJQl+7rtgloUogIQACh1BQAlTt/yFvMomRJXiu0arw/VbBmtSuSdQemMBXWe4odzg8q5+MdCxtMfsTUSIFZFjgeqn+65Tn4CvGBuHl/04CvyETNs0AThSnsiakfbcWA7VCWRyHLbZ+HgoakpoYMA/Qtur3V0AsbwWK/Xd8kaCSjbKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBPH8rlu8U4nBaY6t2SjorZvckZge4KfFVtdCWniOoI=;
 b=JJMW/pXvd+ELv80jAAVNB+aX6LpFkef6c4Vl1UMiAO7C44b2b+hedmRd/pjqoe//0r/4N1Kmaq1EOZZGsIjlor9gMApBTUVBGnyCM6RJYEU0PdudKylLftPMInJj7WUUL/h4rJ1LhObEhUyO0ZI0XuADBGgUuk2XKLCzotLH+5c=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 17:25:01 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:610:4c:cafe::80) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Wed,
 15 Jul 2026 17:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 17:25:00 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 12:24:59 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: Display SPX partition mode for MI3xx VFs
Date: Wed, 15 Jul 2026 13:24:47 -0400
Message-ID: <20260715172447.2250-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a2e11e-75e9-435c-36b7-08dee295ffc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: FeKltCZ6d6OX7aTa3Ev5FoUt0lt/UX43JDUOGvUDIXXS6K738mDTqWPBA154qpLRRdF4segfnYbpNWLGPYF5Bzk+nK2k7n63tw1GO2GH446LBDVbfoAalG0+bMVkjE6kStGhjToScief21Uogq5sBebvx6MnOY5O03lkJQPM+L4LomlQzaiCKGQhsqtVkqWWxzMEZ7eddBnyqdA5NH2SocvbnN8+Gmua1dZEjaTef/EE9sGLSVQ1xPyaUC5lSUrvPP83Nnhf2RI9o1/m231/PYYQgmhisbSSmS54WM/9mxUmj2LKNHmhh7JR0uZPti0aPx0BmNi/vom0b8jyAKUuamnonUjJsdKqYreMHGFiImN7XLwnW53v1StgGMtn2f8F96NqSn1IOdodPsoRBXYwbBr4IUU+vLZ2V8n1P4mh3Z8L2EDQGsO0mPeoZiUCtlz0ZBXd/MW98nTiK2gUDkrAPplm0McDM24Zh6tz4kLIHPImiWi9e6xIiXCiahuk4UpmNU7uzWtNZXzGEzlxB1Xrwit3U++FtxsKrpuQtMJcgCa0AyoVlkF5DWLH2cV0jtgv5AssJ4rmhPQChlhgXDDMgGZX1yH5UvLEIQMGUNhR6Gd3TfUghUCpTndQzTfOjqL3UnXgBNMppNpvglM3fnmIS0K8lPyWnpx/u7J+lvwo3GTzkQoN+99KnnJHbgxJJtleOCM7mKkqXnjcuRw10tJ+ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hAE+LYXT3pbUVg0IAzsBYjeUqybt3ZsGwfliK5wZhW+vY72Qs/lqCzZPlI9zEk9gCIuWv0i3RWmdg5gXstb0XnWKBnc/BdIN5vBs0i2FqUWvsUcgfgNAGgQ6Mg5TQ+JeDpxgWDlCJg8bHujCztggX3/FARg0+vruOKYIVRvxszIgLFcC+x2xFrsDZaHdItZ3LsG5sSSuC7VBy+sUhB4VjitsHSp92Hh2Pc2+50rlIRIeUKbnjWGdJdr2UPlz+WrwpjtZw9oo6bucDJTNv/scFmZPwOU07f5rMZpzZtjH6IYath65C9Fm5PGxBWf15gfrCUBi9DNK2q1mCT9tPFROuatDxV+gIyW0FXuuzZPQuUlqtKL932Tj7AskIxBYDKdgtubCkPgxbAbx58hz0pLYtVTscxhCjZ4OALiWTFvNhbTJ2T2m92unzsAz4L6HbmQv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:25:00.1806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a2e11e-75e9-435c-36b7-08dee295ffc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6
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

VF's accelerator partition mode does not reflect that of the host.
For consistency, return SPX mode when accelerator partition mode is
queried if running on a VF.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index cddfe4015f53..a558dffa4062 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -95,10 +95,10 @@ static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 		mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
 	struct amdgpu_device *adev = xcp_mgr->adev;
 
-	derv_mode = __aqua_vanjaram_calc_xcp_mode(xcp_mgr);
-
 	if (amdgpu_sriov_vf(adev))
-		return derv_mode;
+		return AMDGPU_SPX_PARTITION_MODE;
+
+	derv_mode = __aqua_vanjaram_calc_xcp_mode(xcp_mgr);
 
 	if (adev->nbio.funcs->get_compute_partition_mode) {
 		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
-- 
2.34.1

