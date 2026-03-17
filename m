Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704C4FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CBD10E63B;
	Tue, 17 Mar 2026 20:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0WxJWqhN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0CA810E62E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0Do/UXu03D0wAbXasIm7+dfWGuKY5IBlG9NyIS0CS5rGsS50lcAyPUG5vksHIYTfguepeHliViQBDIN7o8ah/3LPXaxOHbCLzyveYABiAusmf9i/hyLwobBM7vr6mNK3LOxexOeEgLSTAw6mDb8OOA13xf/GJFcgs3TZQ8lYvqKuQpoXafcKOQFmZ3oAz2xtmEUugO5QTNJgUc+Ig81zPeou9egeXnRXbGzYdRg5LjhsC3JVHGQDx9NTIDG/50NiCrqLa2ukOVrlZtbR6gLwzN1RyPpk3a0JwnF9aPG+I9hCW+0M8416Gua26+glDBI/mv/bx6XUTvKxc3muTzxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukMYdU0sra44oFs9CjQfp1XTq+Mpu2lKL2sYMvavefg=;
 b=dTRZQ4UL06g3YlWtX8mnvD2yR6bL7gwvYWt7zmTJ+RPO+oiu4SPaBHN8cDOd5HUxS6heIO3LEqGW5Z9L7NIfSgW1T0mgItfz2dzeA2s/CdwcLHWVbmtDdXrVcoWsHqiunJdU2PF0frJ+ZfbOBIKAV0lbXalqF3LPQTytC1uzIRQQ/Ka465CyEUGAejJaO8FNVYPGKXTd9HAz/2c2lB/OpfaVL1gCmvl0K/LFt2bXjt1fj02V7RXkMUXtbn00qkt0k0WAhXuwB5ODlVqJWVHhGhbEz7C6XkraAjGxxS84JFK83oLC5kmeIFgKUN16+BV09/sdZMrZ24hGNhK/viJmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukMYdU0sra44oFs9CjQfp1XTq+Mpu2lKL2sYMvavefg=;
 b=0WxJWqhNVFEtK9xak2WLNzzJHIukDkviaqQmukYI2t0VFxu1uhJHqYuoA+AUvAkmAMslGEKgyNMvroZhtcM77ln/KbTqDbSDPc9dN107UB3Mw/SBZm3qq+9hv36nEptllxnbZ0OnsOjxqO4lMlxVYqjs8l3jNUlNSy8UhAUnI18=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 20:13:00 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::73) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 20:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:12:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:12:59 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 06/25] drm/amd/pm: Add static metrics support
Date: Tue, 17 Mar 2026 16:12:22 -0400
Message-ID: <20260317201242.3808136-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 362d9e4b-faec-49f7-2e33-08de8461965e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6fD7jcY6V8ubAXW/10sLOPoLQc6K6jQVVXE8yhGWN7BxUDulCPIIevUAVWYfbo7J7WgwWBWYvEmFhlk/IXD1VeRLDbfXbS8FoLFrM8uMhjDsIo7LE4uMqJ7K+uMQlWtzdzmnwQij3tb+YBd9zGeJWSZ35Y65hsdLbl4QD1yHcZg4hIEHPfYYvHBsbXNzJkNKqzsTDaSmlN1aTa2agMaCn6NE3RswSJ2TthxHUjJ0d5Ji8xPUdw9tZHwGOUN3s6QnVvMA3xYRmuLKt7VPeptpuHCJiEQeJ46nJJgkQFyuwnUPgYg6Xtdr7nznY1ufZAYnlL2PiUUdSFd+iNq1H2zi6mRFlZZiYEF4koxQcecqriZfemYYS3PaJTxsQbVa5dkwCVRj0KVnNWkyyMjk0EkuDZmOKXBLXHAVFmc82BR2TqLoX2/ggrKWov4eGF3ww9pvCk/itKEIevJHevZMnCif3daJAIZg6c84JX9gunShlXgGmR84yw74+zogrEYbin4+C0i3lO4DlSWxd1EwfjmaisZ4rVLyggFWSOwQKdfBKrgRuo64Knr0U8tBV1TPammUEa3o5WKpj9qcNyDj7b14pWOqNB4tDGMryUBm5inLLHJNbKRPrrUvTFWqsV/l2XhYBSHOIGZZHVE2J+2CqGpaCGu2fqVDrPSFLnabepvOb2nhJyk0VrdXVdXX1fZsQWdUrBB1Uan9srxdocwAx4rPDrVR7Y3mD2Bp1MG1d4/2536vCOtAR/zW5sqRsNtkWvoBLy5K6IfKK6MJlcY2RN/1PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tt24oSgmZx00HXw2Ao9QRnpdt+P6DiF3ezWdCA/85Jrzgz/7P9eAWzfD0pcV10d/SW6pe1Mq4FbdJYyDbTyrdJEGawtyMAWDVO42dRrbktpJXpKkQ1faO2SxwCqFL2fm1q0eCdNflUQ/nrp6VKo0J5XCe850YgveSqbGyi7JOg0yRgQtvSsvQA0Ne/rZXnTGLWL+6bGj9ME9AsiA74DlZlNsHnDJdiLdOJRtuzHsWIhDW5Y0eNh6klpI0Alku6ZVVT0BNzp06JpVdjTBqnOsdDQ1sBkZw5QOv7P4tQHenWy4VsQzUax1JC5w5tK/6b5H9KgePGkqyrb4xB5eoRev0k5YrYXE8YEhB4WLnxKU8oICtugIbZ4YPkITsW62Tn4PvjM4ItSdq4YmpyNLMR3y5wcB+dZycQeoCx5yCC/yj1+oeexSmMmreV/dYbG5v++n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:00.0743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362d9e4b-faec-49f7-2e33-08de8461965e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

From: Asad Kamal <asad.kamal@amd.com>

Add static metrics support for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b3dc04ea5e713..ae2e0d44b1da1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -238,6 +238,26 @@ static int smu_v15_0_8_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
+static int smu_v15_0_8_get_static_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev,
+			 "Failed to export static metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_hdp_invalidate(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+	return 0;
+}
+
 static int smu_v15_0_8_irq_process(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
-- 
2.53.0

