Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EF606B636
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OZ1oxR/F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591051120B8;
	Wed, 18 Nov 2026 22:37:49 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD6610E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g92yMR+gl7ZPSMAHp8eOrLsIbhsIIvCPXVMTfdAVc4wHIs+KnP5ZryWxcgNGW8+3fXFRsKkXy2vSsD6l8zC0SLBCnvhJvf+R0lHn/qELgDyX23lLT4OlRFuc1eCjI7VkSt9sB5tu6DV29sOs7/G4DVv8Y+p2XbXDfOoy9+OU+X6ByzOvmQEw6k/DgdQ2fXbSA5KOCYiOtx1tzo+jmG1T45POukSnmZZmMeAu0pRAcGfMKBBEt8W1t2VuOHxegXrKTcWkwwfoYtcspoNd3M1BEOPwWtrFYuF+McQ8k1LTRJcr9ScKu5ASHnOLV+A7JSKFQy4FiDgRCMNxdQKkS5qPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8LHWwWqs762dIZMJ7arebdjXm1gXseYGetYqr0hwo4=;
 b=iGYfNEPyyMwdhPh23KaXpyEZ5+0W3bvwdrFvp6BPY11NeKqNnE7/wEvMniYHpIaATmbC6EuBKlEX63RkA4rTY+01zhY1ARt0g650BTZ7K2vxaEqAqIzfXdEKlV7RqBQ6AfBTaLNcXR0wnQ4RATGusOJZ6xd1Vi8QUR1PYfCdfQzn4tQKeG5+IvLmJmfIPU2GuTRwsjYYI4H1FoxJg1D9p4RDnmJLOQaWhTsXhzo9l2dYbjYn5UHNLPxi/bNfqYbO28UYNY1kxp8iLRTNyGqklb7/NEfOanJNQgtGcvhV83nd/G+LgXcpRyy7NBJOLI11UaRMS+yfHlhn46e1X2HqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8LHWwWqs762dIZMJ7arebdjXm1gXseYGetYqr0hwo4=;
 b=OZ1oxR/FffvNP6YuroGR3b9v+IiOcRkaQN6WoE0BkMBtk4X2UG8EwSKBgaZOgUM5w+gqSiKQX6dGz+KGunkpntMH1fk/cYMB8HmNuRMcdRBLOV/0Vuia9X8fTfQKCcnF9Cr5wwq+LENU6EdX1pQyrJqTOlXru/5Ub527olIEd1A=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:31 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::aa) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 22:37:31 +0000
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
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/11] drm/amdgpu: bump driver version for userq updates
Date: Wed, 18 Nov 2026 17:37:12 -0500
Message-ID: <20261118223712.2518580-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: dff59b0f-564c-422d-a5cc-08df45c4881d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022075727099003|261021123027099003|10067099003|56012099006|11063799006|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4RFjnweuOPkSCcuvsZGBYkFAETo5JDZ+OMD10voJ1LQf0UFeX68+ltNYY3K29mKIkFR3VXGujXRgtVj4LWsuwZoJLY5atc5/gbl3ZgyPN2aAZczXGr+zl2mjqAflEcn8UjOnAZDEdGhUi884N9QW/f01iFnfTGJxT6gYQdT8SfLVm29sMyuCmIZ2qomgLkuZEKjOCh9d6AiqQCAHnPjdKWNpCoYnqI+NnY6erD8G3YYjB2UcehYScWHynVWMRAVcNm09YuNeQWeAO3fSFhWKHZwF+Adutd66IWKmflLOV0rDXRIDZei3cGTcEeVS9q0AVrvkLz7WVMlG772qJvkm5ubHVi53mSXi1GPGIWoO6rHumYqpO18BvDMk1wmYKV0peKrxh5KsREehAIMPLsAorCa/d2p46nhNrxyYiSxZJHWSIl6jzDD2Y+47M93igLVh7mUO8c233V5M8f6oZVlh4EP1JaFo0O17+3DB/4dTzmQV8izRq6g/BBWQxa4HfeMJXa6FmyV6AshymBi26baATycLWD2DkBbAM7JRA0d2OzmJUEaXZXGQwiKFuoNynspmAOvOGyiX+QJ9s0O4W14NH/ihrWiqJnfaGBp6iFBMbY50YL0r34ky9D6431oq8UAEVfXh6f+08RZyHSE5m+rQx0UG/AaMm+gz8g8l2zLs4R3WynwANYu2MhvNNsC1DdbFpyYnPqz+Itf8mok+jp4QPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gTXMCa3t+duP9gk1x54W2FbSUaF5BUnUi5FzhbFxQ1476fHmlD2W6A5RfU/COTO0kmC5YQKC8AKbruh8qQkTdXazqRc1Shc+AOSlFQTz6yO0DQHRNjNOnKhFsR5LiLsCJfagDzgDYaDz+zxgS16m3rlkBZdIEpL4Gt0Ejq6v15ItCEari2zo8MbRgrCTFRkxf/5JL4qg4jbNRgUmjBCoSp/200k2yYX7SY3AB2+d9nUXJqshA6lHlR4zeSUMgcIFBegfok+JBpHtzY04cEB5fLzPtaUposBjkwxr8gddmecuNX1DUduEyJ4+Sk7clL0fZaIWM0lvi3F1JfHj/uv0tNdG6TNSWDZKkklr+aJT4eq8mQmFEpPhrZ8qrJvG+QFqUAemM9BbLf6r55mkr2C0A9o19YbIqelnCUHn1J+2TF+jQrbordG1dG+cXzSDTy3y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:30.8108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff59b0f-564c-422d-a5cc-08df45c4881d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Support for ganging userqs and doorbell offset queries.
Ganged userqs are guaranteed to schedule together and
the new doorbell offset query allows the UMD to query
what offsets in each dorbell page get routed to which
engine.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d2db20c172c69..b1d7f9332b55d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -129,9 +129,10 @@
  * - 3.64.0 - Userq IP support query
  * - 3.65.0 - Add userq syncobj timeline signaling support
  * - 3.66.0 - Allow jpeg type 4 packets and VCE SEI command
+ * - 3.67.0 - Add userq gang support and doorbell offset query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	66
+#define KMS_DRIVER_MINOR	67
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.56.1

