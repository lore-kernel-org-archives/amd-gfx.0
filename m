Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED5C47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFAE61153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFAE61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB756E8CF;
	Mon,  7 Jun 2021 13:45:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFA96E8CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOC/DpVpAMG3DiqVcc9Lug3jE+LJ0YBAcRJ0HYeeWbaoOAsmhRvj8WXWIJSVV2/F5LRoPz3AAQZjP9MgHnIZzfg0FBYOJ8E5hWfwGP5jSfX7iTZhP+BTBamgeniTSTCsVEofA1Q6+mLgurd41ju2zF/CRAUgE1pmONbvVlCPHIeVmoR9V+1+F2sPmfBILeIV6+naXlWdrYDH/lq9aTEPnaElEG8NeO2aCl1jYcE9+L2DIxf5cbMkwZjne7Fdz/RSzpnJ9lJWoL8oBlt4kgmlju5eGDCs72J061OdFufLryn+c80CTS2+vSWFz9I/Wi28yMgJl2NReqNtG3IRyQX35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=O79Eg7+0HCNPrXrera8DcrQhcg1/lmhDRh1DVzwuFxsJcDU/7fCB3pt1ZbtOstGIEVT37mbO4uhmc0/rmdP5RweX9/zaxfhjTa2UadvSMfzJQAie8ugsvGJqlvKAmZ8vdST+voXrtMzOOSX7eB+Jj0sqC1XlMCKTU2bvkvn02AxVk53nZzUpePVnWk3J9YmB55JcjlJ1Io/vySe2zBOWfVn/fZYhE7Sw2+29x4/ackB5PhguqUVbq780aZ/XVBGaAJToc5TcmxUlCclTIL+t9NTBJqrMQc4rv7KDk8I6sx83SmoWMWXEUxUSmFja9RUZOwlt1y9K6IsWqNb5dOuN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8Gy02qq1onN84XVK6IHMIqmtrPyWtmH4ZEGOrWC0os=;
 b=o61Mc46NwE5ipyKt62wVZtLjwSftI5Xyu9wneondC+LcKEfvKo5EbnQwuxVrXKhqDIhgV40Rkjdv8Yiucz0SL/nuK0d6FuCJ8//WQeln4x67G8P5tGvFjzSRDea0FJjJiUe+5+j857DFXs+ghNmkSHHl64T803jrXf8f69bMj3Y=
Received: from BN6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:404:121::15)
 by BYAPR12MB3349.namprd12.prod.outlook.com (2603:10b6:a03:ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Mon, 7 Jun
 2021 13:45:17 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::f7) by BN6PR18CA0005.outlook.office365.com
 (2603:10b6:404:121::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:16 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:14 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 3/9] drm/amd/pm: Add common throttler translation func
Date: Mon, 7 Jun 2021 09:44:33 -0400
Message-ID: <20210607134439.28542-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b8e445-edd1-4450-b990-08d929ba7bbd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3349B7A97FAFE4E73B86F8808A389@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1QwtNKDkVUQ5xWPcTEAtljdtNcvEUjDBjKse0sLSADYtkMb+zuNuRw/zbyiLc5wXEay076OzKC7cdvfj0j7I0t/2kRRu3qFZkRhJKN3EM7X8uklVCPL4afKGaYs57N85rXOXcSqaNVDjo0q0uwEY3BYyCJBMUMo51AfpwyF1zxj92dcni73lHyqhPng9775F9LMjsp3L4BlPL97wrH7YRwFTywkK9hVUmvgJDXz6eC0tv/LmiOcYI455qbrBGiuVl0fJk1M3IlI2/HjHTEdT6hmQN8tj4Bhn0XweYK29NEOe5ck/MyyEyVmkWS5WxrzKAdaDf+2CIoje5wrCgRhllIt93nin4XekN+/PL2VrO5n+ERHBl7VMZJu2ivDljjRbXrT/ONXITVnMge4HAlsE2h2Xm+yqHl4LOkTu+A3ydPFr+KAv9yTCBZQZJKY3fBNAHzadjaI/Vj+09NXqEx0QueGRsjBI1c80UEKyn5LxyfYW/ANHPxplQqh4Ydkqqda7wHBfNHd6+5M//4QXCIWR32mEG0PYk2OEwzIsVHYieXhLiiz89c+YA9LrkC2mAaO94SXohVK1UWLwutQMCktogwBf6R+tlVmaVudg6YesgVac7qmtJ/s/Eez43mGPreuJNoTPZgf5Q6QQeoHDRNH3oFX77ic08MURCnJkJzCq5zXsK2hic8GahkdrD7ymVVS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(16526019)(82310400003)(26005)(186003)(47076005)(5660300002)(81166007)(356005)(498600001)(70586007)(6666004)(8676002)(36756003)(426003)(54906003)(336012)(83380400001)(6916009)(86362001)(2906002)(7696005)(8936002)(1076003)(70206006)(2616005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:16.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b8e445-edd1-4450-b990-08d929ba7bbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Defines smu_cmn_get_indep_throttler_status which performs ASIC
independent translation given a corresponding lookup table.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 13 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 01645537d9ab..269a42c0536a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -398,6 +398,19 @@ int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
 
 }
 
+uint64_t smu_cmn_get_indep_throttler_status(
+					const unsigned long dep_status,
+					const uint8_t *throttler_map)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= 1ULL << throttler_map[dep_bit];
+
+	return indep_status;
+}
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index da6ff6f024f9..c57ce2b2cdc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -60,6 +60,10 @@ int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
 					uint32_t *feature_mask,
 					uint32_t num);
 
+uint64_t smu_cmn_get_indep_throttler_status(
+					const unsigned long dep_status,
+					const uint8_t *throttler_map);
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
