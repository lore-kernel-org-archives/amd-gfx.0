Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50883606A330
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VslNHCKZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C864210F8B9;
	Tue, 17 Nov 2026 19:24:41 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574B510F8B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3r6ho7pTC1hCx+mEpdo9H//nrw65jztR2BEnUwhIxdJWNldVrfxWe1WQ9c4LBp/pSyLu+Pw/nbMXExX16gIMJJVKRZ6n/Zu3EsyrcOc/gOiuRox82cVffg0JuRhdupPgFI+FyiIpaeV/aWwFvfY184dOyGxqYdvCs+AK0hldnOo+S3oHlTfdbRa9cpRD8wtu1MQTnQeWw2Iql3LepoqRsbBfXsCVlLsGUNZ5OuSusGZqqlwLbfc5Z2iwDo3fDm9uq+HZWTZCx6MpiCX+Kts2u4KcBRaKnaDdOoHgIb0Kbr5JmMMXC8N7WkWON7a1ljj+zqfH+zclzcvQ7xSrKPK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlRTFo1dR6bhq3Wv2DK1fLgLuIRJkSGNMEBzJ6EJzfE=;
 b=L5Dq04UEH7s5ApT1yTqEBFAvlv1yn9glHmBntm5BEr4Z7oEwwKFpjb98mGr8MUBm3pA89V8p8c02oWnHEP3n1zHdMZTfZudbwv5bnKV+TaStd681nOm9JmHLJlbBQ34vneqbUkzDL3A1G6Cj0aHUB/kRL+9IrZVDdWNAuLBZsVkIOHv4cnZZFEMfaxn/rJdjqnJ8TFHvHJuoJ+5d56d8DBOlrm8PkjR667/QE+XwM7nytXVQfKSqO4GPOxBtQSF6SV8ma2YOoalxLJo0YYsI35/GcMfl7veP41vPcA54kNZN0Glu8Rb/Pb/U19JGli7da5ZV+QEvtr8Jcki9Pifgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlRTFo1dR6bhq3Wv2DK1fLgLuIRJkSGNMEBzJ6EJzfE=;
 b=VslNHCKZAafhlKsKc8YB+GbLe0o0wF8nrYW39wzzzzZOOfauh1xsKLq3Yr+Ybc2rxwizHxrSP04K7YuhbulfTUFtuzbZ5m9D/URTbi4RD+lvobOwEtQx+bn2ROF4EOxrrHwsAeLoC9i9qtOmQh2LLf+/V7DdBgniqRIXZ+pReIg=
Received: from CY5P221CA0150.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::6) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 19:24:28 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::a2) by CY5P221CA0150.outlook.office365.com
 (2603:10b6:930:6a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 19:24:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 1/9] drm/amdgpu/mes11: add API for gang submit
Date: Tue, 17 Nov 2026 14:24:07 -0500
Message-ID: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 924cc5f7-078c-42d6-39c6-08df44e06596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261022075727099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 73Z7HyifbTlU+QFTWcL6VGZKf1jUFHDhhiB7fXk8DzUbtwifYCvN+UDGdw8jnP/2vIoM2otS1ohsEpSSMrYLIzwfBPpsyrVSitqEwLNja21NVsJkN1Sq9s1xKEn0k90Jeq/CbjZX15izSpkrmGS5UspqHFQN+8R2eW+bZ/RFIyujuS6DXYRsEQI7PdKMk7XktxVwSZnPr0Zw6R5PCbwtb7T+nEuNTJP2mzpRd06012UhM9MxRH3Zvtlu7qYadcjt9nK7lG0A6EuRo5HwH0n95KRc8V6m9Z5f/ZtYTzRxlPsh2A5zAM6EjdhDSZzTmXBEpmygNHDT61myUAGqrNarPHpfe/cA7ofqWpGSwrYcv5cw1HdNbKLYWWMsVWhr6xSaOvBmVwMYaK5JsqCOshIDav2YS2KutYwpytuvRFUGD7IPOa2BSdn5aA3Gc9qXFgBkJD1dQ25IVpD+hvnIqY6r7W/pQZIGOcpxNSrXxGcPz0pv3iDsE5qTQC5xKlWABXhXB3t+lHqZb2wSO2+kIhJh4nXUv9mSwIlwTDVz+V3IEMWtaxBLuLijIbdPQ48Qr0p6PLctK3DoYBNIc3mYYDwBCDJn2Dco96ypJu3CNfR5671rkZBoEULOUqpVMSh73aqQuC2dN5ioZo/NBIQCMFuvR9NFwLo7zq2eG6dYmb5o4qGt9ftlTeGg1QsAlCvvx7xhJ/RENPSf891j88/V3a0YDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /t+IuQopuEjT7B8vKSbWbYmt+OrUGoeZ95mvQ6wuQ2U5cw3Dpe4Yn+JQU8lEl+DCe44KzgyV8E/4xb+DGbfGTWdT6S9Lg6A0ASSdGYFCZnJujrIPJEJuZwnkU9aJTXEQ3Pz9Z8v+quhDoMO1Tr1MnYY5YEIcYqZ2O0kILs+m+tQr8nry2vPXockNw2T2y+ng6stCWwjfOw3nLeGqqikH1N5sjtdUu0QD56H/5mYCyle9pJPMy47UpjTvwUPmJmEjpxARyOzDn/JMyf8NCfv3o4D9FPcGELOZkUoKtFDudjxcP41qVjZARDTdXLvdRHzlcYadDgzjlOWD/aZCfJkx5w/BhJu69jNCeplYwsN7vTDQth/atGtA43X0PCQvT997oy0sr3df0rq8z12YW84KyiVP3Dwe5JUQZl69RU9TgLo3qYNzD2+fr6ghJ/mHhdpI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:27.6289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924cc5f7-078c-42d6-39c6-08df44e06596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add API for setting up a gang.  Gangs schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 30d3d25d59842..0242fe8135374 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -147,7 +147,7 @@ static const char *mes_v11_0_opcodes[] = {
 	"UPDATE_ROOT_PAGE_TABLE",
 	"AMD_LOG",
 	"unused",
-	"unused",
+	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
 };
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 6d67d015a74fb..bf2161b2328ad 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -64,6 +64,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MISC			= 14,
 	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE      = 15,
 	MES_SCH_API_AMD_LOG                     = 16,
+	MES_SCH_API_SET_GANG_SUBMIT             = 18,
 	MES_SCH_API_SET_HW_RSRC_1               = 19,
 	MES_SCH_API_MAX				= 0xFF
 };
@@ -688,6 +689,13 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t process_context_array_index;
 };
 
+struct SET_GANG_SUBMIT {
+	uint64_t gang_context_addr;
+	uint64_t slave_gang_context_addr;
+	uint32_t gang_context_array_index;
+	uint32_t slave_gang_context_array_index;
+};
+
 enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
@@ -775,5 +783,15 @@ union MESAPI_AMD_LOG {
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+union MESAPI__SET_GANG_SUBMIT {
+	struct {
+		union MES_API_HEADER    header;
+		struct MES_API_STATUS   api_status;
+		struct SET_GANG_SUBMIT  set_gang_submit;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
 #pragma pack(pop)
 #endif
-- 
2.56.1

