Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83260A5BC4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sbgIIFIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F901120A8;
	Wed, 18 Nov 2026 22:37:44 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AF91120A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twp/kr9mTHF4Ti6UE4IcaYT2LNIM796QMYHbehIWSaVPZdM/KwUVJ4Q0C8TqVsYqpHpLwsGbZ4+vHvFwp7EtvK2wWk1njTSl+w65ws9mLARa3Pyt8rT45vTqiZ5eamp4qSLHsPH38L8cGe9VECCIuTZ+pwVFz541F7Pm7fyWu9M4VXXm10oF3S3JL/REceV2zbrz93P2s7Yov1FsuFoBRxLrgF5A992E90jfIVP+KgtwlB0RyoxtWBQSMFjaUndZHLa3edFXfxJhChrokKlr3QKmrLn1mKKSZabirVIPtQWn/PVE1IGX06wcUGx/s9j4VRs5d+9p5P4Qc7DlOFbBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D/OQbZVQCGt4gPZ9QqGuaYqJpCfo6fZlk0fP4Ch844=;
 b=nADtmMu/iSXmTqNAYj5HX9xEfNxv+Br8L1NdVoFJHjDU8RE4fc4y/fXCvZ5OELZRwN4tq/KWa/HeWf1Fcz+/UxCDwwqtqlzI+Ky2QSBG//EVGfIG0khazsjnw7wLPHZQgJmZgyAgfdFTOhNn9UdzM2PwGWK2GUSsyYD8vd5lDpconMBs2tsjmpdWbpGmHgXJ2vWJvkSzU723rkjDM9GKJDKsqlX6w0btsSaehczfSd9X9Y4bjWEOIEM8krRHruR+p20G7OcSH10R4zas0wwhQC3hztJU8Gy4qK56kl4y0C7wken3vP0MKt6/0TPcd4O/I4A35Q6LKO82Zq7Ooi5L+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D/OQbZVQCGt4gPZ9QqGuaYqJpCfo6fZlk0fP4Ch844=;
 b=sbgIIFIJo4P9WPLYfnlKUgrtkdChg99BsNOcEFGQvVD3Ky3orcC14UqJPKXYTC6i78Tp6y1o6TpzbXBcTI220gzHVZCg5ENPJMZ455fnPwS7gnygSW3R2IBFLe7yP6JIFm6deZ9w2QFXsO/R9zewRwRn9xs/dRZ8nbQSXltgUBk=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:30 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::97) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 18 Nov 2026 22:37:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs
Date: Wed, 18 Nov 2026 17:37:10 -0500
Message-ID: <20261118223712.2518580-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: e760609b-b052-42e8-f019-08df45c487a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|261026140227099003|11063799006|56012099006|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XgdH2GYl9m26B2CYCQBab/4huk5WK9QAzxS2IiidzPYjwESWcYrJ/5QjKNXEmUlWPjbKtaJCt6vD86Ij1a9TbiiphFQnq9bWHJQKNkVfnQskOT8MaZtswSWX+j30BpHFpqcfPrXPYo39aa5lPzf755CWZULP4nPEdHBHrbi4gzWy6Wm83OrFfnWnuFgC01nFEgwGyZwd1K3C+xDiq+g6CXEmFS9FId76oAC3TsqKoMF6vcvUMqMMouaqwQrEFDc+SyZpzOyfdl7UoocQsSLc8mfkVgZhN31hL4GKDgbHAfI9x77vqdQ/K8i+1gm9Aamc7fmL+R9uIFMKSalHZmVTY80rJ41+6ovHJS3vWe8xZ6ejnB0TQkZD4NoxXaKbjBg6DCjIoJID7qhv6mziS10JRR+Lk2FDcZWcCfWxNYWzcrmzeLNGkqxUuX/lFXjqLOiYTcv+Gps3qOr4JA5jqEXzrfY6cS7IkPfUmAzaFFBMH8L3BIHr8cJGB23WO1wr1sS7skEk3swoXCbVyKa03FjoThF/fJO6lhw10kpq7OTEMMmzlmxgN5BJxtp7YuL5vO9bQ4cuWFZCdQal4fxgqoWTQXaKih8gMRmpnCNjby2NtAJtOC4orwpI8zjngdAkhvIOrPY/tZD69qPlm0N0cwTjzZ0UmLbJZahfMyuvc3Oexeoujc5+vb3/6/S3y+UF4odbbX6dqccVikm6Kr4jesRKXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(261026140227099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZxUIAqNChqtPKgjew+TbmCmIjdNhiQK8PVSY8UBxLEndS8KyPB29AspDU3ni1lrkCv06wQLARJP5V95pmwKurjOsSGhlZrHseGEfjcDzVg8rBOeHkDOsNUGLu+INTkCDhm9GWS1xbx3lCgC6AahNnExDNkFpRAMyI+OQE99h8I8RxwKEINPyqzCdhFFCVCUGSy7zewqEzcmZPSnQc4G/OFKiU6UKmTf5BA/D5JiIpgVCU0gOcDwQWBm2/oW1r94TVO2jmMh+8iKcCMkNlzCOXmhBtfGSmRgkRrrrZDka9emNE3H2d3bdHvghOlaIj/qtSaDS4EGMtQtbxVxkn9uaY/iThphD8V8bLXRG2HciU/TpgTK9Z4qLN9MFW1wTOPkORv/5tyEHQwR+Dj97Ep+3i2iGVXG2WwygQl6UsPbL58Uphwn1OZw16INwtYUNfiAG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:29.9953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e760609b-b052-42e8-f019-08df45c487a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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

Queues in a gang will schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 86d42a5d683c0..bfb982f1d1757 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_CREATE_GANG	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -422,6 +423,15 @@ struct drm_amdgpu_userq_in {
 	__u64 mqd_size;
 };
 
+struct drm_amdgpu_userq_in_create_gang {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	__u32	pad;
+	/** Queue ids passed for operation USERQ_OP_CREATE_GANG */
+	__u32	primary_queue_id;
+	__u32	secondary_queue_id;
+};
+
 /* The structure to carry output of userqueue ops */
 struct drm_amdgpu_userq_out {
 	/**
@@ -435,6 +445,7 @@ struct drm_amdgpu_userq_out {
 
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_in_create_gang in_cg;
 	struct drm_amdgpu_userq_out out;
 };
 
-- 
2.56.1

