Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE560A382C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Nz3LaXRL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0ED1112098;
	Wed, 18 Nov 2026 22:37:37 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E02710E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEvbsonbn4xHubkd72OLzyJr+L/8l5MP3qbq8r8PnMWJrqmET2/l5oNwH8C3FompT2kjsm+30SWkB7j3IPx6C/G/81tpdwxMIYtdSGfc9j1EbkK6eefFOBBdZZx9k8AM6dTliSCec/yvu8VgqKvn4/ixN7u03yGXL+wcMRXC6sSEaP/vpklPBmjwVpvXqXt2tPSUvTqIyiU1/O59Osbufvf/P+WrvFJ8l9Ynn9R+rNWGCeVH2UZ7ZuwM+Kp+91o+CILp7gjv8+bPuls6hq4r8s5yod2+uFxclm23TFMZhUVKWIDbQFrYpOiVu19jeQxbNB/8MT01vZok9OO65O9b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlRTFo1dR6bhq3Wv2DK1fLgLuIRJkSGNMEBzJ6EJzfE=;
 b=xMUvEFDES2l2eoxG2Zd3ey7eRmPuHafA/q2tNq3k0yE8CbeMH1KcvRR+vu4RH9+WSYenLjfGD+HtC6CtS16ru8SkwyBdU/mi+O2pi1sHlSRVadomAt/E/t7kY3RFezc/iP3PjENScXRAUcjmJnMgP3pSjYCVNWdwyZ+TlvjQmsHvixhArmruyRi5Xmd/rSgsQ/1w12+hO7kYWUqCgbt+MGWgishpNWwlXWb7k93R5XzwZ7wy06lgBmVoUyLZpwLc6oQXTSLK6xigGo0/FxhyE+6QKnIzVDY51aRdrQK67Wh7SvjZZKzphAGSMXyZh2IdG/92tG08KvvJT30VmN56dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlRTFo1dR6bhq3Wv2DK1fLgLuIRJkSGNMEBzJ6EJzfE=;
 b=Nz3LaXRLBlQWC+soJn1FMfrM4bf93Rm+4IpxXqduSiOAlh9vrihmUgSdXnByCt/lhEcuMsHcxWdVKj9QCx8SGEIwTz0nqWu2bT2yLkjUEzh21dxGsQpJqH8hJt7kziDyiu4GX1/XAtnVZ3ujicgHyCd9Ujch+LMXgUyOoMEvUD0=
Received: from CY5PR15CA0130.namprd15.prod.outlook.com (2603:10b6:930:68::21)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:27 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::aa) by CY5PR15CA0130.outlook.office365.com
 (2603:10b6:930:68::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 22:37:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 18 Nov 2026 22:37:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:25 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 02/11] drm/amdgpu/mes11: add API for gang submit
Date: Wed, 18 Nov 2026 17:37:03 -0500
Message-ID: <20261118223712.2518580-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8978d4-baea-4b6d-3bf9-08df45c485c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|261102123227099003|261026140227099003|261028144727099003|11063799006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: MB/8fv5bglE93dHRkrBo6l4rhY1FIxN7PjFvGP4BuGal2VtOFRH4BzWD9kbifRDZKXG8s/nYtfMER/O+TxP89PuBk/afr4FAxIVTVpy4gAIcpg7gUHLIAGhZWJeHtNlajq1cqfwRMEpzqoLPWdoZqrwf/KA586fjS0wUioaAqhQR1CKh+3OQb1KmapDjiFJvNtBJnxkDTcpYfPeKxDIPcdrKfmZQxgGeNw1jyWLo0ztqyhShaepXcclKHJHnTlw4SKK4RWR2+HyiTRTwBW/9BMYuuLjKUfsDiHELrnUt54CYKnIvZEO89Q3GRD1obmCndfKJd+r7m/IwKx/Y/c+TrzD2ULlvUK0oQyH9zxv7Vh92K5nfghY6OMXpQRFrrANhZkKedsq9w604++i1MRCM+QQsdXxqnQkDlDWVUzqLJazyQonx7rhEdaF49AOj6rUHMOD4JgsGxtUXn+7p1Y38lkn9/SR1bjZbq9K5/oQv3QdA6nFuwZq7zYqOb8um6PLHDLKAXdThk9sthvsw8kfhFfuwWZOyDAZ4g+vZchTPnfSwbWjuUr+mlxcindOJJNpPtBzhxI0OlLPVn1/oOahLZD5pnAGqOlkjl29e7KB6ObEfQ0ylWaTfxj9c4qEEnCOu3ldmIrAXEkkiZQJzeUTUnGgBiTTFX7tUXMcXHZOKBLK74ILGzwXTpXQk/JI6CFehQyWEsEgvg5p/ORP1gsz7VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261028144727099003)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m6tV+JoFdZz1wrDtheTEuYjE3FxBmkh19v0fQHQYcBsqBjjxpO7p+nkT3sK9TN9/lfggD7t8+q+n+g8cxIRj8nWCIl3YgeHuQVzDfwIR431jgp6Jxj1ob11xQx9yiKNnrJq/lb280d4mVKoWapFEagv7BtDQU5HiPRij96iQwZ6QiQILPs+/FP9E8UdKqCc0QN1cCm/VJkrjARO4jSJ2oUs2RjcfwHz6AQpthTjnSSMY4ZCenyVTQjKuTbm6bmPHnvYeBjOjJp/I2kfqTu8di1x8bXACWcjne7rWSRIQf+YDdK3Ey64fgfKlgugoW8aZHbNJCpBXbvilMbOOvRNtOW2uqivx105xKUJWAJBfiCK9+Tv2H6uCWVnrCBkdue+hM/3mydZXJD/P7+5fUE6cytf68UEZhbU3D0UlOdo9i6THTAZwVEd8yAPW6zdZh2e6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:26.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8978d4-baea-4b6d-3bf9-08df45c485c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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

