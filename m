Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8330C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C1F10E093;
	Tue, 16 May 2023 05:04:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D0010E093
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZpDdICtIQ8PQb8FEo86MXlr70Tr2tetNEmrpeMdoN1vsrcJ2lr/aiXpW/wSxO7SYVX3rqcyYWCSCOSxxLjAHhlU8M/OzgbOzxT3gHBgTAGcDsf6s9Uk+8sDVBXDs+LPrjSe9xKy+blpKoucYJL1NWoFsptFFqsdyELug464sxDS7iBe32+XKS5gMX5OLJYXyTxdsWTi7u5HlYFGK4h3V9h8uGcgI/uRiVMKnxKAGXZC7UMjFHYPphHNdlED5LVibaTavdVYaLo5p8OQAygNC95YKbOU6rXXEdhwSyOYjVsVQ26jyZ6dS9L9AAjGhPt2ljB74kXhoGwwEf0u0k5AIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfq0MEt07sAhUWfO67J3i+KZ+4gAmFV2PuSzgleuG3o=;
 b=V9MvyaIl+107Aio1nvuBWSWG3yqhejZNHIwmQi0v1aGEBQBfCMGu0cXcd1bpTVSF9t5UNw2A99pLHvlWAJr9vEY19u0AyT1VSWk0g7BzQ/gL+4jXx0PJbjJ17/XZKCDVvb6jO2z5WF857XTwdnVMa+F+cjYCs7SVwTPJWAjqYhcdMZBnKEZPHLrjThUl17Pqj4aBSAykEVVgZDakMrOWNIUxlLaWo2XkfgOTAcITk4TLCwoJBKfPdSgAlzIf6QDsOmmCx7ojT9fAGrA61oL4kzUnvCFcRgHghzNjkJFUQ5acE7x9uw3k5gIJuISCMGFiFUwiQkQnyMr/iBjfnZoEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfq0MEt07sAhUWfO67J3i+KZ+4gAmFV2PuSzgleuG3o=;
 b=S9GKt3g/G0IEfTTLlJHSohu8yDEvC0rxaze0jG9EpC4clXe4OdpryKY+Yq5r+u2EhlaCzWSPyjpUNjWh9Czc3iLnTUm7K0EyObgmqPpQ/ykgUYV5pB9LSjvYhQshb5JymzC3nC04/gxTJGeYXZnCX054AydorPn0b4avaxQt8ow=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Tue, 16 May
 2023 05:04:27 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f3) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 05:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 22:04:01 -0700
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:03:59 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/6] drm/amdgpu: separate ras irq from vcn instance irq for
 UVD_POISON
Date: Tue, 16 May 2023 01:03:53 -0400
Message-ID: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 335ff38c-fc3e-44e2-cdd7-08db55cb05e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kBORgL2JrlpMAHxfFYfP035t9tRJx6qOdDNiWESwTfttfYdJSz5ucUzh+00yTMhqFnzEOOfIH8+uuJNYD6XjPkCWdnrBJ+m736R0ZWOXkcbS9sQSiwUhLATVfvq8m54JVft7TAKggx10T0xXVK/giX5zQXjRYy4p8Enrt6ImcKBR8EDYH20qcFUX6kiauNPhINdEyD1q2GCeI+vzASBgt77xDFvuCD6Ov1xR38fSgJoIxOOX21RfsqIdo1wXWT1QbcyoOTRYOdNorKcyu9WXcVO+CFKPJ+h24S11TG52M6PoJCc1er2aep6sZLRsrdwP4g/MdXiSl6c0oEvol8YkF+PZjW+s9NQ9eCDATMFT/uBcx3jLPkZM6KLs/o9fferMjKRGPQVVn6tUa1LPypBSum8rtux8T0YiwdcYdFRsuFN9H93BejG55ufguZNO+pfTHTjVto8RdQ15ZhnfU1/WvPCbGSInaU0jc4YtgQoE1yALDmyip6NOdwaxG6H7xHHk+fknZvKkYwKrVZQtVCGdJ7VUwrxR3ZVedqZb9pe47YR0MdXMMHr3ZEsiaVbE5cnUI6kknmSMBFGweXMj/MHKnrBrP5csc0j1+QKRKxbCJxBcQOpjJ+zSuVR7Aktty27aTcYKaZlTjN2S1AJITEYxGg16Qo9IuLRxrp7egt+h3+EuPKXkYL9YIbRtxDn1jZh6Vpo1+X2/X7JIZT59QAkqHDOfOJ63HV8KntyWg8Y2ccEq7uOAjFcSyw4LEFA8NjOBKtIOb4BqIasM9HQ+8KO8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(2616005)(40460700003)(8936002)(83380400001)(426003)(47076005)(336012)(6666004)(2906002)(70206006)(36860700001)(316002)(4326008)(6916009)(70586007)(41300700001)(186003)(26005)(7696005)(1076003)(8676002)(478600001)(5660300002)(40480700001)(86362001)(82310400005)(81166007)(36756003)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:26.7425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ff38c-fc3e-44e2-cdd7-08db55cb05e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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
Cc: HaoPing.Liu@amd.com, bob.zhou@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, feifei.xu@amd.com, tao.zhou1@amd.com,
 Sonny.Jiang@amd.com, Mario.Limonciello@amd.com, Leo.Liu@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate vcn RAS poison consumption handling from the instance irq, and
register dedicated ras_poison_irq src and funcs for UVD_POISON.

v2:
- Separate ras irq from vcn instance irq
- Improve the subject and code comments

v3:
- Split the patch into three parts
- Improve the code comments

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 06ec2dc55857..38f6ba281853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1189,6 +1189,31 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+			if (r)
+				goto late_fini;
+		}
+	}
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+	return r;
+}
+
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -1210,7 +1235,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_vcn_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 1eb9ccd1d83d..92d5534df5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -239,6 +239,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
 	atomic_t		sched_score;
 	struct amdgpu_irq_src	irq;
+	struct amdgpu_irq_src	ras_poison_irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
 	struct dpg_pause_state	pause_state;
@@ -409,6 +410,8 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
+			struct ras_common_if *ras_block);
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.34.1

