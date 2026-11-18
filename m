Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FB60A5BCF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KAMy2x3D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40B31120A5;
	Wed, 18 Nov 2026 22:37:50 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72C91120A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIj8n+eB0iX2SX/z4Re/J++X2oDvRzkQGelXeSEr1VqvP7uA4jyFOYTYM6s3etulUITqHHC0BaesNkZA2e+Vr1Et8P4qaWLlXqbLpNaDqV1QNtdxDffbIJll75zg4d7d8AiLHj4E/t+9mIWQZFB6OzufbSjj7uQxGqYX89qXBQvSnhxMg4NEvKCkQZplHeJcPMC3g+SYwVVbc/ynyojnMTfuswBwB49H1OKx5dFFk0wNjBnnDm66wAuymfGZpJer9ffHlKNHmQgzyo8N/iJW0jMDL7KvCLPUZZrE9dK9rMxN9+QJeweoTrnAiEAAY6Nh2DYS3AulzYVU/luHUzVDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dPeIzahMwe/H1G2RFCKpUWO08/qG802ks0+tfJcUcM=;
 b=XMrToPFsNdIodVBfgWt4XDZpjCEWYk+dv+D8ZN49+YqeaJcoZTvi6HhowR84Ih9u52fRRMIptz3Imk+ZYxf4ftIK6WfYtu3KpENlfOKieTpObGHSsrviVue6MKVE5x9+dwdaotA6A2Peo0kx/WFVR09J+Xe/6y4i7SwJLn16+bpZeHD5E1GbgBgS9AOh5PxhyDB5kcJTQdBIiV75ATPbUjr0GMaZ8nnMqwYCaOCZ2jEAhQCNcKpQZwC3En4hHldgf5scOSQv3PR4G/ieVHhjDCk72hgXsVXVj5Sf2ORxa08aieMhs41K2TB60IUTJK8lKQQO6odtf528KPg3lLocpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dPeIzahMwe/H1G2RFCKpUWO08/qG802ks0+tfJcUcM=;
 b=KAMy2x3DkCjMAB0tqpb6vZ9oq7abtR3TX897Eu0orPJV8gufCBnUqK5CvKufDoWEUDh31CrEZEbfpFFf8/PvEZU+CwmcxzvFz+aKwoKo1YFg46e1xc3NWb9tOmyfzIERi3OxLHPs5AjFRhTScNdQlv5KJwbeaR4llTVLh1vI9uU=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:26 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7d) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 22:37:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:25 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/mes: add callback for gang submit
Date: Wed, 18 Nov 2026 17:37:04 -0500
Message-ID: <20261118223712.2518580-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5c1d4e-c4b8-4bc5-64c2-08df45c48567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|261102123227099003|261021121427099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: pYHqBnMSXhCiQw1IQzHGjpU0jux8f8QbPmCxZCf5tGgJ1rcie7CNF2JLqBaIVtaIkSD+1s38OdSM9n6lmO0reYDWn1/M3X+VmuWgp5OoQUlSv/gmaCvhYj4TozCkyrToq9gfJxV2jwNEkhhfu3cAPavVH325xw579khU6EsAW0CGL3ZRNZ6O4EAgch68VQsywddYk1IOEHO7UVVn4+fLvP9popzZUmI07Rfyrci4crjMTqinJTN0xi7ogjyWxesD4r8b2md8KgmmDma5WffGRqZsbizJn+B2udI6lZehtwkQV+layHwsKUHVNqrVYHiPaOMGR2hvRNhQN/Z7FKhHFpq+YZRlm3I6jvsD9VkyRjO6pTJaFEVE3dZ2miC5o/VgGi5c0qHGK/xoBV1Y9SdF5lp/8UZdVNM7YfH16JNyW1IYXDS27TDM1ZjEw+hihCzgVQuoZa5jO+xXLSWgItAUAw/L8v+u8KM+Zj5ape+wCYxb+EOEfDtMlQcP+Qf7iuOJrl6v2wxFBLFHZCVLXffYqyBcpy3wsFd/ucEWUVxJ+4Glq4c4QNxcfp5F+3J6TM+xvTWNn1ZN8qzPxJQ0sZlL+9H5+DnMr8lkXutlbtja8jveLD9tYPaXVyPruz7XKWJGIAjMuAwtLE9AIwPNy+/rbuqM+P3To1tKkGEDUQnsyOdROFngYanAU29mdpZqHv13a5PRUXFetmZ3L/61mmmS4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021121427099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 71IjWfRxZlag6pt2pfm4faMBNUQk41H797KVokP0cfs/mWq8jX0yc4Ix4b5NsT8KfIKjAdcjKtuJ0JOrXNtmUUdx2+/ew0IckHG4xTXRN8FSndkPj25je28hsglht5EAnYP1/EfsiyCtrwst19Uai8+IqoAk2+49xDuBaMo/TAzRYFJxG+0OMwf01UCyL03poudhYI79hwJICt7C5NxZ16GuASjrrAr6gcmq+d36JAKdPOaaEiGbP8z+gsrjmfAryDnB4aIA1R4prd0EcM+V3EYjQmI6NOVFYBhC1Xt7q3zV/c8U2qOvD7RAK2uOb91Y1kuTaJmapeSuyUqvVJm9nJNiabTRcabOQlAtW5GXL8QhxMSuEO1ywxcg+jItqvJDEgZH4fgPg+9aqDensjp/69b1OagDZL7RzWOO7mHTeGrxpFaeQ0ta04ml//CYGwCV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:26.2606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5c1d4e-c4b8-4bc5-64c2-08df45c48567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

Add function pointer for gang submit setup.

v2: handle array indices

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e5dbcf8ef890a..43733037a762c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -401,6 +401,13 @@ struct mes_inv_tlbs_pasid_input {
 	uint8_t         flush_type;
 };
 
+struct mes_set_gang_submit_input {
+	uint64_t	primary_gang_context_addr;
+	uint64_t	secondary_gang_context_addr;
+	uint32_t	primary_gang_context_array_idx;
+	uint32_t	secondary_gang_context_array_idx;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -520,6 +527,9 @@ struct amdgpu_mes_funcs {
 
 	int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
 			      struct mes_inv_tlbs_pasid_input *input);
+
+	int (*set_gang_submit)(struct amdgpu_mes *mes,
+			       struct mes_set_gang_submit_input *input);
 };
 
 enum amdgpu_mqd_update_flag {
-- 
2.56.1

