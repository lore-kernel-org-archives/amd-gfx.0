Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71238F433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDD910E808;
	Thu, 16 Apr 2026 03:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Puqc7NLA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D74A10E7FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX4GMSflgHUOTiecDbh17EkjmzZmGpC0JbEdxx53EiQGhuUECy6McXi5KhPSGaZevnmP2EE2b8TCbxMR3WVZIweNOGwOULG7U7dkEurCzSSELW+20syT4nxPkM2TuMwQLTANXYBMd735C1n4HT06pxi3idcgk0HSqy/w9KzwwemkVkRlxIM3OkT39X5IHcHbHJcD33vsdeQopHPYaaHvG3piECMGIHMw8u765ri31sT0Ia4US4PXPCRDAP3JWeY6006cCqeqK/hZnpNlUVHnGy5SahLhp5htavCKJfA5RLFmXmdhWTdu2uZXC64crUqksrLJzJcA4q8S3Vr9Dm3PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=HBsAe8scyfcnrd7fx5CzkEM6lq/r9RQ6ysCZCIxmQYMxpj+qdnXvyBydA6yJXcwrhRiqyelG7V3Tk3namftF5MK8+tMEI8U/mIg3nCnuGkD4JC4Wp93QmVjcvPaw+eEV14+UCoJY2/aHzp/mKtOvl3Pqry/arZk4t9hWK5IBDxSFkdJ4Prb4jIpeP9/LHFwPO+CiLnGzXTQEKHwrzTp/EBAtPo1NLoE/NNJ5PUotiw0tItVq7efdnNMTTVjdfu1EbEZHPP8S3uOjJFDzX7JgFilfgROkRW68Av8Uwmolyy1/rbnBU1B58FqJURwHxvcZRtrrYkpBBWmnvha67s+I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=Puqc7NLAXKUniUJWv97unNBy2T1cVBGl4ieTyPwxdQ1VJw73DKot7qi24DmUNs+H9CqR60YMaznko2wCR6zcsAIoChJAAL2z/YxYszkn3Sxn3wYk0TIopTakZBMAaRWtU+U294ZzsXmB74fDVKtbJWtekffOuzd/fRpOGMupw1g=
Received: from BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 03:44:54 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::28) by BL1PR13CA0420.outlook.office365.com
 (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 07/11] drm/amdgpu: document WAIT_EVENT condition
 semantics
Date: Thu, 16 Apr 2026 09:14:16 +0530
Message-ID: <20260416034420.2368152-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8789bb95-62a9-402b-2b30-08de9b6a85ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d1bnRJQIVdKN6wzdpodjwrmiQuA8PqEeHI5PlqJ+WSpxKeOfXEVYDJ81E6kJwZXQ75qsvDZ0BGaDMIPYIbUDkr8WK3AynAJKZPJvgNz3Qy9xX6pMfw+eOGZBne7NPwwL69J3lGUKGjk4MsJlPkHU/ekv9FaAhqypCoWR2DQRx8tt/mNIEzCzGQ4U4zdu/ETJrGnAnX5J2sb5VtRsOdYzX2D2l3UZag8pGI+/YvWZvWpK/7eK+VtxvR+rsxcl4pe6ty1SbYBoI7FsYJR69suTbS4k+tH7wvnU6R/bs2vr+wCEwEnFa9dQ1OK7dADtRrpcOYu1UmXowZ6xBZ+GuKS5vFFdbjaSfWEyJP6bCD+MthRWP2GyKvfrJuvbKUlUFwkSDWD9MJt6OdxF2AMI9HPDnAypfw68QZngCcasDpkia4j3WE57g4fpywC1itmOdH1E5IYI2cfoweG+Bz6Fvo8dyD10YSpTMl6Q6ahFRGSO9ZFLqmPfMMe2g4UFBCqsJIxWeHiGcAtV4uY2PceWtDvc4gmFDnIpeoz0y2iwVDxGYGA3RM18ThDNyXUATOYgDnoesyl17u3JEEid64p8384LWpIKbwxiQ7kvTnVJXbaQQpMhqME8gIGreKLOREUxGt3mHVsgJsNhA3K6Oh+kMtP1SaBWms4v5rzR/mOSu50hgeSZVjWHN/9TskDSM7ZBpdA4rFfEuLx+k8KBjOcEw69Yg8M7wq0hWz5JAifmPL0X9o1J6wUXbmeYVnHy/CCky3wNwvjv6sk+0wdsQFNN3cZLFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A0hj9H4ENprctIEWzX7PyYCZqbjouvXoCVpge5rTNhBMy3LSlrdacWvyUWC9AGHECVRrh/ADTCFAV5SsMqyNpvzVVe24e5TOYsmeYqlFBv0eAarzYXBnHprnsm+8grVYZ7U+IC9jHfP3336wyQsG1BXPw42AiK935cuhQsOF1x3O1iCJv+zhjmGs1BRyMJbYeXn4kcT7SGpINEw79HfxzDRSnhDqkFgEUJarSioWA/zG0jmvHl2fSb6NtSiZlyS6XIwojhH/SOe8DE1nRGdtA806l3UEdKK2iNhtCBvjAFFJYwtWmsXcrqxXChpS9z93PjpOQS6sJ01xgOYYA3+p1CbgJzHZeuKNIcrFkNRXoxff7lhEmgbq8/3YWJv7PaQ0+5cVv4A4vnpBeQx4dL6jehagNBWpUQSpFF67a3U4iXabHLdnmHTU9pKoqV8J3dup
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:54.4369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8789bb95-62a9-402b-2b30-08de9b6a85ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

Document the optional condition semantics of WAIT_EVENT.

When condition fields are provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

Matching records are consumed only on successful completion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index 67de685647c7..3cccc652360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -45,6 +45,16 @@ struct amdgpu_wait_event_mgr {
 	bool dead;
 };
 
+/*
+ * WAIT_EVENT semantics:
+ *
+ * - WAIT_EVENT matches pending records by event type and optional queue id.
+ * - If cond_op is DRM_AMDGPU_WAIT_COND_NONE, a matching record completes
+ *   the wait immediately.
+ * - If cond_op is set, WAIT_EVENT completes only when both the record
+ *   match and the userspace memory condition pass.
+ * - Matching records are consumed only on successful completion.
+ */
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
-- 
2.34.1

