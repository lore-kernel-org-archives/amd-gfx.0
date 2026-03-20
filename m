Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA071099B3A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3127F10EC1C;
	Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZfrmCvcr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A462E10EC14
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubctGmdTeB+Wpzz+qRoWvyiIKZDfjxec3kWNnt0RBLHNnYtmxdKWAes8Qlqe5Wxtkx9HkACAtd1Rw/NEToQ3eNaprTSfD3Qcxv4e94akRiwWJwXZ29/igx6Rq8lIVfWeHF3od3uBJpu8iW/cAw706eOoicImUlhGsP3Mjy/UJuUfTdpKkHSri1slKwzCCi+gvU3p2vtR9ok7GuaVpFXZhgK0FlZE5wjvy9wXAjqyXYKCG2m4+TLuPsOazoCz3iCFRo3FDUFIOuG9h3r5uOhzw+x9n9dMqweTROy2nMOOj/ufrmP/YzEylvAAtrLuUvaS73mLpoaULXhzQHhhGv8sEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOjQAdCNHwcKDiS+Vmi8Mz9Sgv3ySw9PFp3A7ZsTbo8=;
 b=GIvbk0/PGT4gC1CRu2bV1ZtmLiI6AqDG21HkblJ5YeU8TXif8MC3DXaYmZLpJ+6ConUQJMTZQ6K0AgCLGOg9u1agJVytL5tZGfK1565unrVfY39JV5GN9At+3Ufj5qqw8J47rCR2n6USi3i/vP8qXaJ+EhWgYCGl3tL8J3VLX2LSKZuM2zv+sgr9D7hc/JK7p8S865bPop6yJNdvtBqS3OoQHe/cDyE4Zu6wEuBtnFd3toHYNB7orufeDxSVO6uxGamV8omFB4Wc3w7MvnCb/huFOwxyTeWrcUma0qN49xcGTxnHvcrtlUFP/ZPUFTJSKJ1yUIzPFZNfVafqJz6fdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOjQAdCNHwcKDiS+Vmi8Mz9Sgv3ySw9PFp3A7ZsTbo8=;
 b=ZfrmCvcrf6kzq/u71VjvYqi3UBmdyrEjnd3SVq1XN3y/xo/qLiadAYmvHCTplwcpvze6iS0qKtPJOTgIHroVhQQTXXwSpI2Ng6wlUMJbqRffy3KU34yesGzspUbTZjSSKRgx5TfwkijGV5MhbrGbJi/SPx1h+uUba7NSl8YtZ1A=
Received: from CH2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:4e::13)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 20:02:38 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::5c) by CH2PR02CA0003.outlook.office365.com
 (2603:10b6:610:4e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 20:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:37 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:36 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: Fixup detect and reset
Date: Fri, 20 Mar 2026 16:02:03 -0400
Message-ID: <20260320200208.1188307-4-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320200208.1188307-1-Amber.Lin@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 293cfe9d-f211-4cf3-d168-08de86bba2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +jUiMKB8eF8V2KPtKC7M3wS9Xzhu75KLeYFjuRIFzJAn1HUZPNxDXBJmDikisaZZX8QgArHqAv5XjUgunojAdBUzG7ttUyCOZgS3Ctf8bZw0xD0PCvkN2gu9jGocJbdpHeimo1NZJmXEGM1iWB/R1gtVWbC33UzCHUVcKpLUd7NjvCRoUAvrrCO9144J6Js72BY4r3oJIM96sW06H6UzGGdv3zQ/aD727V4vjiU1Xc3IW9lC1YQvHjobc3himO8VseDhkvbe1nkYBVqiIhIgjfQK4P0pZi+zJK8eFv0gOPrdNNOsCAqRot7YhGTKM8y1S1YxWKA8Rh60mmPhyalWSI+L7iyX85B4EdjKaKP1jY+ticwZQ6mBF+Vxm2+79+zCODcwfNsTyzBsQe4e71NcnPqzCJb7/lR8uxOzfUSV6vFssOb3q9XQDUXpnQAWR4vKGbWGg/u4QzSeHb73Hpxfzyn9TSMSJa5huZi1SPnbS0bCPWJ3OTtCkdqKdOcB8fGJMTPr31Pylx580wxuYvv12g58Hjhg2/SiwpyTckW+eNeIh+zUaAy5AV9SP/A3EdnZUskjZrR9a3VP+c0oJR46mHluH7lm90WcgXhVUz5d75fXlv8uD+xkzUnTtMKjtZm/g55QPNhZX7zPZnUBOHKcUMSeBUuWsMLpuPs7HKJi8iXPjCgvrgApS8meqnDz6YsK1h5dXc0UnHtd8hALRizkZavaquwZSanyncqXUWY/ffxJsskPSr3J4flUOKiDtQlAnS/rw4Gr5x2v/ergDGnrKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iXKjSoIzL+9iRL2YFkgDvSb2yCGQE1BdiUZaF+psIWvLXQCajnT7xn5EG2EP+Dt7HFZqnfGlIaKYGp8T7z3H20vo2Tu42sJEilTtTCXf6ecIFc6AYVltg7/NKEyfgysp8V5cB4td98Pur2iKWh5ZAD82/z3NHWrm5Z7A51k1wPAyQz0v/OWfYZVYi6/SdjuDvR4LdYvl+wVFSQ2KPh/yYiE/8xXhjOU/egN0RA+ZruQLNf9ApiLs5UrTFMg0Bh1z+gVQ2x8lci8bQoaYKd83nuN56i/M2KM5AqpFLACJ2BtyGRo40XhIcFEwTN2XRAiW0VJbQZd9GInjUx9inzu8zuRwIqWt4jXrOIzboVugseZubbfFp4b+A7Sdqoy5rQMQLjow03altt8GE3nq2VI7IgCGZEUGjwv5ojTD1OJ9FfWDNvgvMLD8VX75U182t4Q4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:37.9605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293cfe9d-f211-4cf3-d168-08de86bba2b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 38 ++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b68bf4a9cb40..bea509f6b3ff 100644
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

