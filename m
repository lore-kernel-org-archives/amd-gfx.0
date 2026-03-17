Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9039EFD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7D210E6A8;
	Tue, 17 Mar 2026 20:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XNzbOe5A";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D2D10E647
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpK7/acLRXsVfnKxk9HB8vUjeHngW0yJ2Rk51CvFVHshuCy53oLISs+ZQ4UakvGmNDvoJR4BGUzBy67B4d4nLSuqzs3lcDicrwOxHF+cOBPQMH9AopT4jeOMhidZL9Y0MM1KSTjyqkttoSZKu7H5p5/hIOgtdSgg8oeRVPbYqExrV/Xx9tMw9limdyq7SxNX9e3PTxBO3b7dTZP7UC094ngSsLuCrw4PAh6yYNAC+Nr0lp+aA5ZSgejTZ4LVDSPyeYrrZNdn8+4C1+tSjQSG8SyHk6391XwUP7VDd3c8ANk6agEYIp2Gs1DwK3uVp0ojAQsbGApVbRFfF53L7AL1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFBmgHB8EavstVfFoM2W0eQyivWGO8BscRjgBQ5C3xU=;
 b=Dl7G7vM6ZFv1PXzt1VPPe+3+DzoNpy/+0cEWfBh2wHzLB+6ZKpr2NFB6H0Nt9fZBubJ13ejsIa9LiiELSUVh85A604SedsMCYwIK2yFB4LiTsLllOIj+/e019qlSBcXhFh86L7cTWTTo5z+KXBG1xIzCOpPlEn86y0DlHkyFG30hLOv0rwLdYSkL/L36o1W3ysqwTHNe2axL7TOBggS6WVTQCDIgs5mdAM6mRzWxuU8Ck15i0ZfOCQnI3GfvAqKzKJCMf3QqiQlD0LglJEhbqgKDNQUfm42ViksXOeS6LXS36w5Ep+FbSmV2FlXM/Hp9iRuRwcPfzyDiNbxCR63jBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFBmgHB8EavstVfFoM2W0eQyivWGO8BscRjgBQ5C3xU=;
 b=XNzbOe5A9+Jd3gUhhtnONI+UzKdxD1z6ZXUnrXZNffIsiA0QLz5+scOf/i0joKG4SLiUYyK1TwISSJF3WOLLGn3p46giNhqAPLmtoY/dlHiO/u5ASulClu9yUMDyZeEZfg9WtzUMUGDZipqe2w7tmBm8wkTYJqU1DCMAkvS4THY=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:27 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e8) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:13:10 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 23/25] drm/amd/pm: Add NPM support for smu_v15_0_8
Date: Tue, 17 Mar 2026 16:12:39 -0400
Message-ID: <20260317201242.3808136-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: f95ac0b7-b7b2-4be4-f462-08de8461a64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 11h83yOM4a8fUhqMOUSjlmKzwiULZI+IBOMLnVPHlIYwpnNvJ9UOYcJhkM98sIz1TSRUGUJFTJ8sUJVD2F/XKmEmrUV+n4/hRigf62mMdtL/Z+aekxGQtL8oStM5QQcEcfNNHlNfwXXunAN7AGltS5rYrRuzZsy5oR67Joiie39ixTP0TNWAGv4P2cEf+SFhMyn2Zg5FWj33238/ocJV+dijBJKOxf/yysHQZdZNZ6EMO3/2BCdvZH//Dy2F5WkUGuPaxTILFUYEUi5IUH+5WnRbSg1tkm39GxFTXflVjQ/NUe/BpGvuSHmdUNIBNUyXiKYsDH53UjLBqBRx/MjhlbERyp8tROPEXuPGtaD94vMTH/tSIZSncCj/KF6XLDRtIJ8QjB+x9p53wSRI0qy4PCmd0J+TeHr0zVRA1/767b3VTaUJt0MKfBVz4rr7vzY+4bmcELdQAD5PMb/v7YhtGSk0jtJShOW8hxqdBRn/i/1iy0K1IwvXoPPXqQEtFCVUpDXN58QdFQsXdxmt1QZjYfTw1j85pAdl+CsvLEDfv92sXauLNMVGeE/AI8twNNs1IQ9i09eV+4wie32JMkPpiSnNuSmzuu7aChO8vH876+HBiPNt7EzICQySGuUfmx8LdNVzejs6N/Wr1PfpcMJVLolVUcLM6jyLjXmjMXaeHGe1VH9+paf1IvhlpQ2aDDcX0c0QjtDlI80OAR1HbU9f3Sqn7nWiLtgD3rTCZ1Jd77KsFIUJQvLJxxqMsWvr8SoTz+1JmKk5Fib2mmz3WwK4Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZp/QxWZ7vqrbbacj/rR8OenN74Jyy3Vx/kz0ENMrdm7Co5j0p5FKkqapV7cZjptYYWu5VG3j979HN9er0vWB2GS+DvMo40pMC6fNyatpj3Cv6/giA6erLibLiwxWXMN0i/iByXCCFdMyFQ3DyPm1xoDYNPkKE714bhNrZdAwxjQMnui1pPJlWepANEZWpiQd/VPkRsKMDEqYIcHDAar29bFmu+tWRtOGHgZYQVkxEyORvw5s2n9/pJyKh8q80Xd6cOrNsH/r4PGOxWq7qxAclifbXdlT7M8EeK648TFSHwVF6KQHO1RJgwT9TgYwiI3msbFj/GqDOkEPIKtyXKXE/UFypNVF7C3Vaup4rjXzyyEhrPaEu4Hsk6uLPCyX/GlEJ60OCd+fXxwRpzF9ewl13qewRlB+ii79kCbKsxVqS5iNZjjs4khhor9lfgYV9LK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:26.7957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95ac0b7-b7b2-4be4-f462-08de8461a64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

Add node power management support for smu_v15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index aec0b6872f924..c8c9784c99241 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -558,6 +558,46 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v15_0_8_get_npm_data(struct smu_context *smu,
+				    enum amd_pp_sensors sensor,
+				    uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	SystemMetricsTable_t *metrics;
+	struct smu_table *sys_table;
+	int ret;
+
+	if (sensor == AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
+		/*TBD as of now put 0 */
+		*value = 0;
+		return 0;
+	}
+
+	ret = smu_v15_0_8_get_system_metrics_table(smu);
+	if (ret)
+		return ret;
+
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+		*value = SMUQ10_ROUND(metrics->NodePowerLimit);
+		break;
+	case AMDGPU_PP_SENSOR_NODEPOWER:
+		*value = SMUQ10_ROUND(metrics->NodePower);
+		break;
+	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+		*value = SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu_v15_0_8_read_sensor(struct smu_context *smu,
 				   enum amd_pp_sensors sensor, void *data,
 				   uint32_t *size)
@@ -607,6 +647,15 @@ static int smu_v15_0_8_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data = dpm_context->board_volt;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+	case AMDGPU_PP_SENSOR_NODEPOWER:
+	case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+	case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+		ret = smu_v15_0_8_get_npm_data(smu, sensor, (uint32_t *)data);
+		if (ret)
+			return ret;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 	default:
 		ret = -EOPNOTSUPP;
-- 
2.53.0

