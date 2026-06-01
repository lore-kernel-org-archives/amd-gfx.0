Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85581CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCBD112DC7;
	Mon,  1 Jun 2026 05:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7/Sjhxt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A14112DC7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hb5Bw5SyGd+eUb68x1TK0g0gaTPvlpQ0AvsmugXokgjRyRXjN+bnFsyXUHf1AtFhs86HZJtt3TMx4mXjJuEzG24d8kUEwmcerwgTHooqHF/b/3z1OOuAx7PiDVJ4Xs27NYosQSU3G7lkSgkVeTN1JlJUItH9PN7aET6tBX/xTmvpMn2FUpJmtAmZdK4zeAYzt8eBl+oy9UsGloirNRiEmWpDFd2HREj+ZsX6OgXlq4mWbi3EoR5l/cHb0s9QLIumNoUzhr2AMwRe6jbnbHIQStWUlKLQ/rtQhqdXWBjParAtRcGh8qJV46r/EPeRLvn8qC0IPz8NNvVqGeM/l/YdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7mY/cmCaNqDw7AflzHGYOTFOuNxdmQRwlHgCDd/Nno=;
 b=b/ykctWLxxjbwIuv7xtwoR2sH976tjEamigUHSbbNYXm9R00bHoehHi5197orVsuDgbMs7q729u6/ti/hKTaNY3BwpeL0xy+/Lgl2IUH8XgkOYujJOzMllNm7Z45Osgrik3G/CgdgXg3xRJACcIEqWj/KOx8HTitxCH0GZ1G5OZH0fOCjiGAXPuEW31B7r+Gie0IYC00OPd4REmpEmDpm3X4MC2LKlQqNKcc6I+pD9o3xagfGN4E2r3DgDbactzkRZdT3aVBwEs4R0JAwzI+fwGl4MJe2ndDXfOUnC7wwLAgpoFypsaHOSads5gqr8XNBGQ+BtDXDywZUIR1vK7vXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7mY/cmCaNqDw7AflzHGYOTFOuNxdmQRwlHgCDd/Nno=;
 b=q7/SjhxtLTcr9QB4fa+sGVldfKx4ECiKoylcXoLeuQK0sOqj42f7VFFBsD+2yPhYaeKodZ8nZBmv4dFRBgDB3O5fu/W/1MC8RJO2UlU2QJoSNTCbjrDvqlnYaw+fgo7drlY1Wsd2XHSVeIBujqiHrpJ7o6a/EIxQMdcibZLShSc=
Received: from LV3P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::29)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:52:59 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::29) by LV3P220CA0007.outlook.office365.com
 (2603:10b6:408:234::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:52:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:52:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:52:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 18/42] drm/amdgpu/mes: add a MMIO queue reset helper
Date: Mon, 1 Jun 2026 13:49:04 +0800
Message-ID: <20260601055034.3700921-18-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ebe956-6b27-426c-7b94-08debfa208fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1yTt+m7JE01zuqyOC14sqvEozZ3JBkJaItKqjTbe9CJi8maVH1e8On1mJFFCTsr8m8UHptzp0ANftKY7X56ucZ4sNv09ou+ge2YhU2QIOaSpmVnDpqGvEVjpc/FVDCaekHxv+3ItoqfNJAsqlbNFCuAOP77LSIwwb8LFOF63oGlsIUDKMfZSxJZUudKuBwpc3dT2KxvKsBqrA+c+cG2/bHXZ1u098wSbiy89uycB2Sfw3YznteaGGKY7pbQZUwWvunWUHYMwl02A52JzcOxVqjd+ntLTSSwmjxWiTwO1wrLDnmouPCCtUQXLliVfSTev4jHxHT5hpd5EqgmicqCXipDcs4PDvmIHJ9gZTHmqGl9aXrAWlZFVyIWghsY0nE3wwq/QOc+CDSMHbvKCEB3mhb6BIDnsOghelYmc9HLAg5C1P6oTl4ZaF3aIyadoD1/G/VwzHxHGF68pn5w3gYRfr86xTCmoVztDnzpHUiFK+XRp9QE8d6nOPxpjsUwAIBWcXZmzGimtV5pqZ7ywEm6ziMUtBJi1E+Bg8CYcV17jHFF8giL+uxkOOFHrw4T8k87vfu6Cd9Q5paAcdWStMy2a12OcxHSlW3J6UzUkm01LAfIOFCgJJ5HpnFIdnzvDqKwep6XRtek8iCtXOB3kvRtQyuhHrgDyHFEP228X/ryG/uwTJpBPk9Tv9hzzJhkWjoTZ5r9P3oqEnJmpIwa1VKH8oQlu5GjRhLjdtGqVfm+AMzo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bH9pgVB9TqewTuAr0q8TMQPrQxbtzm6QQoBwIwEegs6zGl1xupzIq5+KCRN1UXR2T6JAm/pBAqwaqFOM2Jvlx1vV+sOE/x7M8a7uOnNyha5iWThUeLxcs5gD+VD59LONOeIm46zpIxfBBWFwn6DQkzhdxBPdi85Yse7MAVMzxId6WZwpQmxhHluHOoMl2KpodCSyNhMhNfbiE+vuvQGMrSIJvx+Tn6yLi8nMmf+WaFzDrxs8i5TPlKGLqmr9a2Q1TQUhLeA9GVAsaLcrjT4bo41YawrFV5+siAGINcq2B/msR/jKAhGWHYT7QWOKZXLlbVlqFfyYkcwpy8zogvgS9a3CxqFyCOE26WU/QMd1iDjbccjCEmMQB363k1RZHa73kjQ6Gzs/Asr1Q0rfiEZqab+bmlyV774HyoKGlAc8S2M/Cc4AzzLrvfNTDIssh7fv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:52:58.9234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ebe956-6b27-426c-7b94-08debfa208fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

From: Alex Deucher <alexander.deucher@amd.com>

Will be used by KFD for MMIO based resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  7 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 00682bcf4019..ad1b620230a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -439,6 +439,36 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_reset_queue_mmio(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int vmid,
+				unsigned int me,
+				unsigned int pipe,
+				unsigned int queue,
+				uint32_t xcc_id)
+{
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.me_id = me;
+	queue_input.pipe_id = pipe;
+	queue_input.queue_id = queue;
+	queue_input.vmid = vmid;
+	queue_input.queue_type = queue_type;
+	queue_input.use_mmio = true;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to reset legacy queue\n");
+
+	return r;
+}
+
 int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
 				int queue_type,
 				unsigned int doorbell_index,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e0d4abfeb27b..de7307ef60c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -458,6 +458,13 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  unsigned int vmid,
 				  bool use_mmio,
 				  uint32_t xcc_id);
+int amdgpu_mes_reset_queue_mmio(struct amdgpu_device *adev,
+				int queue_type,
+				unsigned int vmid,
+				unsigned int me,
+				unsigned int pipe,
+				unsigned int queue,
+				uint32_t xcc_id);
 int amdgpu_mes_reset_user_queue(struct amdgpu_device *adev,
 				int queue_type,
 				unsigned int doorbell_index,
-- 
2.49.0

