Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BD606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=juSxInLN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F87510E377;
	Fri, 13 Nov 2026 03:34:50 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ECF10E377
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 03:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmM0NAXLJ18GPSUcV6GaOfgrRBFR7uRAQMqyGKWUFZOfmTLB8et9+vdUxbiZdfE3NQSFS3lxQVQ4tPBj3JOoi5ATSdsqi5hIoE2ruocvCnAVAul96vWH67WqxstZbAx/aQYkK4jjGU5rPnale4lBHQZVrDqXWD9fo9+DsQ1zMtP+Y4KkWoWgwzsU2nljGkuF4JhX1DQYFFl9yYzW8uk/5waDW+KU76wYKSeim4H6dx8QoNW2AP9gbFbTEZp1+29GUkSJRxhzARsJpM4wigrqI3mJgGJiPeIYXyQkw5r0JHlXhPQkyLHpP1y/PVdB6KIl4NlP1avBCf+eBD+J8+oRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=pbLoZF1VXWbnz08w2b+ExAFNBsksYqOXsbwSQgDGkt5bFcP0jjWheEKQpgjaTcLmFP1VMsqS9D7u4s8Mv1HG/pN4UVbqe2lGdr3jTleds9EJj8MMcILrJgkKk7vuKD4M8IBYS7kCSO6iwQmvftsy1JuWuV7Hhbk8iScNI4QYVWIdCxc0cBdDBkm2lYoty2vlQ1cJu8srYeccOSXoh9thCqY6PIfdqVs8ECzV/qUIisp56sfXau1IBZsqb7hJGLX2e6DIbOeZk6/YyN4DjtJl3PW02j2Gn57FBpb8czcKt4ji02WUr6CJFfncNwaeb1+kPT/3WaBs9GUWMM/PxYTYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfJ0fv3W7P49Tbm2JYCiR/mt4H/dj+afhtgpjF8AelI=;
 b=juSxInLNyxeBDVrHC4Lm98uLt22cNtS33/PO9z5RbsTqPDp4L9FZHC0ZX9J67SCWcBHFxwk9vSh4JTfUmenRC68bIl6eFrlwNfsV77X4Un2NnWNTJGqOClK0JL4XUXQZn++XtZVUimDeMZ2bv42h5N0+GXRPzCHxsBRv4zgTZBg=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR04CA0368.namprd04.prod.outlook.com (2603:10b6:303:81::13)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 03:34:40 +0000
Received: from DS8PEPF000000E1.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::71) by MW4PR04CA0368.outlook.office365.com
 (2603:10b6:303:81::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 03:34:39 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E1.mail.protection.outlook.com (10.167.23.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 03:34:18 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 21:28:27 -0600
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Date: Fri, 13 Nov 2026 11:28:13 +0800
Message-ID: <20261113032813.352632-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E1:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb03a21-40c5-4c1a-07c7-08df4136ffae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|11063799006|10067099003|56012099006|261102123227099003|261009223027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: zlsDNtd2Tt1WxkdqfdaByqQen9PTT5uGGWSkQh5iZ467xSRUr9oHJ/vGXd/vdJ/RCrWaONcgtEnx4mskWe63uZa/gpJLDlTF7clYT4t4NiGQUhgTxYkcd49dOuBiO/fbhJVLtCaZfUnCmvMz1AQq6jvBRRfdhA1AzbIvbtL2Oewbt9IbylIGWm9SmQGuI/bD+2BZMz2TRbTDqtQl7u7kVahdJmlP7tdNxLgmEhlb4zhD/MBUl2i/kCUxD+xoRIfZKPBMIQm5SYikVFZQlSk17qoOvXeimYMQGhGZ+4PaCRSCxLuifCho2FGpgaEwNsKdZIHUfUtJPergCj/wQku+CEq9trJ22PG3o/hkTAjNj+9TAeUUBY2+B+bQdkZn7bZ6p4ljSvwrH9qN+dZwyHVzDWFzcfQPGbcQkt3ZaGMhXuzjYJY0hgTwdz9VRkYMrC5EE7nnKVCIdnBfqcFxmhElP48mRYT8/zS8cxImHvtTYt2cNDp+QuOLLan+vpHsLKr2VidQEiSlXZU7q8HywnQKYbV5t0zCOT8xavQ5PSbfGMPIlVHbhkhDIpjSzpVZDcmSUDHAvmbEyWcPzCRaN96Dcam4qQOcl+RgozlNKW1rCsNkib6ZK4buUYGhqlvdaTadMFj3cSqP+imX+QQ5lJIU0HXCUtO+iGud7hmyMCS3bdI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IUaLYLZs4V1NKEqlTvlSHiBeUHqS7l/fdzaX5oK8mfwD1S5VCyV3YMEebLtnrCVM27jgp2kFR0rILqB21GkTTJlDJv7V3IDPcaGxWLUNDKn4EOtBEm/9iB+L57WeiqghKEcf+gV5ZhYw/TWFTqmhHyv+7rSouCNMlZ0h9Kgobanvz/jnzg+lB7nqR79eX9DlhbJvxc6HU05zsmRwCb2Vs7Ebc4J+HXFYjXbWDdObLsupLguqiIoIGcoCztf9Wct4bBFh5XLNBwi5IO25icbcfxsc5J2dcGe2/TSlBvOHeh8Cw1Nj25WMuC8AO3RowFlYBrSu+Wwi7h1my1dGQk+FkXW7ROpiest1wI4WbCnKKA/wPk+rKrWj2NrebV1MiVgY5kEgnhaa3zj4mvpYEUbKFwZYnKwNq9yWUlDBCMtUSG4kJK0b5ERLMh8L5edyCL87
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 03:34:18.2747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb03a21-40c5-4c1a-07c7-08df4136ffae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642
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

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset.

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		return 0;
 
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+	     amdgpu_uniras_enabled(adev))
+		return 0;
+
 	if (amdgpu_ras_query_error_status(adev, &info) != 0)
 		drm_warn(adev_to_drm(adev), "RAS init query failure");
 
-- 
2.34.1

