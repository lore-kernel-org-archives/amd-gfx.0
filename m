Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E6C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40AB61220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D40AB61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686E489E69;
	Tue, 24 Aug 2021 06:12:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4054C89E69
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT3BqgnpADqpjgCxA+1OagAeIYI6tSKy8hHwyB+aS6Zy7WlMWCkixbG5alp1wG0u+dk1HQ3upUMm4K7QdQDjbYdvjlnpUlcSH6/yRfHdQu9K5xv8tqcg6bkHaNXEBGzpt57R0B2nJ2YRXMH0Z9OgHYjMppvwKFZuM7OeuONVoSu8V+IjKh19BYGAcLUShkv0v8IY32gXXXRImOxna+h7Y2xmmwyM7rWw7nI2LwASxkzqH6UkK48is8/f4aWD4C3MdOahUNdaiSVdG30NUGZXuyIGAsgy6EkwQPnqe8OQJVKIZ0Hve/aK4iC//GEKYb6dkXWFCD+pypWjXnH9H1KRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXIzfSTqSJUzFjtPzK2dOKqy8V96SmO5YW5adje8Dc=;
 b=jpjVEmFMvLjh/K3wEXzDe9XfHC63jD+P2csIY89VP6amxFUbF24r21agNh7GFODiS/XbvBHgvIsjuquOTzyE0AVKUezS3XGDMnA1Bk5XccOvS3FyUe+RRrbcvBUx6i+54S2+dv4ROd1b7xu+LzUWCZsSWPxa9C5WNtstizFpiV/mzjgS7Z9PzhVrtzYjp3n+/7kEFBecTy4dTYUIyrAy5iP4ZnV9t5lPp/0943sSh7hDdhUCz25nAY68eEzGJd8+573/dsyl5h5Gl6LOSm1mHvYzaVFbxImoCO2KpaTJF27wBOkNYieUoWmV5EgnR2P9701YBiCFepYdbOrqxZtljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWXIzfSTqSJUzFjtPzK2dOKqy8V96SmO5YW5adje8Dc=;
 b=qDs+ASQtHcDeLUfrZGmeosrLUENmjWlD3v7Ry2owOFVK+tt+tiRvcWSIUI5c9PYrhifEbtvSh5p7XN7wCZsIhyxuuY0F908AA+u/PqNYrOgcDdPiiNLd9sX3MmNRxPoI2Xk1YK7YnIdXYabm1yojQ+TGrx4fWFC+VlaPBbgSq/A=
Received: from DM5PR19CA0005.namprd19.prod.outlook.com (2603:10b6:3:151::15)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 05:56:10 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::a) by DM5PR19CA0005.outlook.office365.com
 (2603:10b6:3:151::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 05:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:56:09 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:56:06 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/vce:set vce ring priority level
Date: Tue, 24 Aug 2021 11:25:08 +0530
Message-ID: <20210824055510.1189185-3-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824055510.1189185-1-satyajit.sahu@amd.com>
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db61419-1696-4927-e8de-08d966c3df0d
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5422:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB542214F1D253F9AE80AE9925F5C59@SJ0PR12MB5422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Loyj0/RZuyxTv6Gxrl5bKmjHlPmsl1A17cb8BAZmuHK6Yxjf5IUzsBHRNaDfgax5hg1/adMBkbRSBoRJ/Sr12CGQUZxKo+Ul8o0B+AXq0+JmAMJozNT6HxOfujM2A7hJCLNeEDvUMEmQwc7Ia6TN5D9N3uAAE+8xreJFUQUc66/DtcG+SZWStC+hrEyUtUTWqnGV8g/qdVQpdGGr7mO9qQAJCkzs2KKYkRKHUuUhNVCiq8PnpF/7RkuFt7h3IWKHF9gV1jZFlAgQ+LERg/8N8xBpDFbfHnHSXuPa7HVAiHsUc9oa7MtysnMlvZ+65oA3Iy+BdM3PmAZXK6VW5/vqSZ6AS+2JhM+oNUhjYqMRq7mbEmvgMjjhnjuOz0OKEszl83JwfU7y5jg5DFqjubnDW4B95ManAVzOCmffN5FIVnV1DQqhPK8utYpuRVyDUvAwFtyQivELnhQ52uM+wyVVgGrT7K5c8iSynhJlHuZz76dh/pWKtx8YzZxtmSbdXoJXbN+f6tpfXXTsyBdxcHdQCc7mKHh2Gs69y6ugSk78v0g/vs5OBS1/xgVhhFg+lhFFhH2dqCfM6K37KbT0xi+MjMK5S5HrrbeIggcFkoCv5eYN5MIlLDWYx1lDI05M/zBT5cr4SQzIK2qYOA2TZvfqR+yHwNkU4ZzOyxy+TGeH1VgsQ/KMcHxLeCOGudX3lmuZkOhpBnrXmXZ9qElfvpeDrN9wMj9xfjr7C8Aa05Cse54wLw7l3NXu2uHdearZ2E69Fm+DVLkB26Pvrk0evJFW1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(478600001)(70206006)(70586007)(47076005)(356005)(86362001)(336012)(54906003)(6916009)(5660300002)(316002)(44832011)(81166007)(186003)(82740400003)(8676002)(2616005)(26005)(82310400003)(8936002)(16526019)(34020700004)(36756003)(7696005)(426003)(2906002)(36860700001)(1076003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:56:09.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db61419-1696-4927-e8de-08d966c3df0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
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

There are multiple rings available in VCE. Map each ring
to different priority.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1ae7f824adc7..379f27f14b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
+
+enum vce_enc_ring_priority get_vce_ring_prio(int index)
+{
+	switch(index) {
+	case AMDGPU_VCE_GENERAL_PURPOSE:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	case AMDGPU_VCE_LOW_LATENCY:
+		return AMDGPU_VCE_ENC_PRIO_HIGH;
+	case AMDGPU_VCE_REALTIME:
+		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index d6d83a3ec803..3cb34ee3e4b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -32,6 +32,19 @@
 
 #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
 
+enum vce_enc_ring_priority {
+	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCE_ENC_PRIO_HIGH,
+	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCE_ENC_PRIO_MAX
+};
+
+enum vce_enc_ring_type {
+	AMDGPU_VCE_GENERAL_PURPOSE,
+	AMDGPU_VCE_LOW_LATENCY,
+	AMDGPU_VCE_REALTIME
+};
+
 struct amdgpu_vce {
 	struct amdgpu_bo	*vcpu_bo;
 	uint64_t		gpu_addr;
@@ -72,4 +85,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
 unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
 
+enum vce_enc_ring_priority get_vce_ring_prio(int index);
+
 #endif
-- 
2.25.1

