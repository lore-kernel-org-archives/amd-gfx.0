Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F103C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C14860527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C14860527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21886EAA6;
	Tue, 21 Sep 2021 18:08:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22506EA92
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxGBNZLpKIwvyGWQ3d79Y7uS9QYM7FnTveefuQoeB/4okPwLY8s3ZsN/jbwA7uF0Se/bKJLfb5MUfASYZPB9BoGLr+GBEMVg9f9EyP4FAvg6fJZCvQlSUXSCIZctr5QuRRkteWzJlqMdX/3O+Rt0BO2iG732n6gge7s2UpANmKaa9ameFN0igW1VklQ7rsGZ468+k7C/AOv5QhLudnnSZP+CXhrg70s7Dcuq3fnadJTIbknYtcePBsU58w9SXmo+cXLgJo0ytD+T1pmncIv++RohSszJcfb/iR7OowqkI/Qb+9H5ihMymsNOVW39ABrBB7ZQ9Zpe2ifd2AsPFccuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/EnQ5kZL2UlSzrnl0NDuYRAvZsIHWlvByxfi1jBYbs0=;
 b=hJPlyX2c12Gcs90FthQ8Se5A4YdzMQD2DQC4oETyBbobLXsp4FbzZLvnZmlEGFSsd5EwAr8GHbMBUO5vbPAY1mtts21WH36PbahRZ84fVX1eQ6ZVsqq8QtpC+G9tvWEkK+TRiqSRLhTgHZfw9kv/9QU/BFiRmaAytx5YUgOgEwvcOLG8mhg54wDFbZFf8JZjzaSMSyhYeZqA1t+reUDM6fQzYRT9v6MfwtnZ3sqJHd81CfdsvCJ97jHKqyxF+4LG9yiLBFctuOo0x1CSxT9TgOURYDMC/U2KV5E+q4lrFlF2GubSTsbwq2wp0HT+ayRWQawksTBx2lix8VazS9NDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EnQ5kZL2UlSzrnl0NDuYRAvZsIHWlvByxfi1jBYbs0=;
 b=YuVDsOev2xBDlB9V15VadxVsKuIE7HzuopZSxIxBK+IJX9DmUW4DiepLtXpAtP/QyfiJarwAgaRcg75Wy2MVlniMXTD//+3ESVuvNLOGgJUZD5OF1yzmWZrbKf+bfKBaPqOeFHreQVhDPemkFc4laHXpwRhDDC2RJa9p+bX0yEM=
Received: from DM3PR14CA0140.namprd14.prod.outlook.com (2603:10b6:0:53::24) by
 PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:07 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::7f) by DM3PR14CA0140.outlook.office365.com
 (2603:10b6:0:53::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 54/66] drm/amdgpu: get VCN and SDMA instances from IP
 discovery table
Date: Tue, 21 Sep 2021 14:07:13 -0400
Message-ID: <20210921180725.1985552-55-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3200a01-eba7-4d5e-968f-08d97d2ac3a9
X-MS-TrafficTypeDiagnostic: PH0PR12MB5497:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5497683498574A79A26EDC3BF7A19@PH0PR12MB5497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDg44iZzijG+sd+mEtsgouKWqWNi+q04GeJHySRbEOebJhE7NzHFPQUQXsHGQDtJLE31vDU2cBMi5Cja9L/QoGwL7mdX0OExzjXiAKZEEAGZ6POs22DDS08I69aqwfH5IVB+hwDViFR5ZuMoFbLXXKKf7C1qjXA6wqQsof/CVy69erCAbTtXX6PdsSA/+EcplyS2S7pVwqA+F4MDhYezmJT4izPLOUN+Xzh5sbwab0tCRUJzcuOtsn2+5gfkdGZwACJOy7TYcxZiVGAr9FE2vcIP/tKjYnN9fsIBqYoS2VxX1Tobik6AAcxYHLGBEF4OefCCFNQYN21qIAPRDUh+QHLTCAwls1W+Yg60ilSuN+uJkQCe2nWFL/Sx9S1s81BgwLTbIxM4T/DMiCQBJYSxaSNsUerwjGZOL+QggbYJux6A7jPUF6R/rg1RceQalq2Br9vZqioJbQZNIBH5EZ8gQQXqpFP5jddKjPTli7K9cRfqPy4/GNwWvU9xjDzKijSqU70qL32hw8ofVnT6uFpzj1OCd+Z5es35XENh5Y2Fgn8WaZHU7I9zP3LeVsJU4x5Sz/NJkhcqvl7XIZrfDdTxwbjb5A8+00AI7RY1P4OipWKTQXmdhnVMyiGuRSQCUso5PCgSjTUTy98wtmetU3vY/Cq7QZTs2kWikOvaGN1aAJidBoNHsr9nP+55KhspSW5m9FpzV+pdNVBTKS+fm8OJUqNwUDeFny6oDYpJFl0IVys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(36756003)(83380400001)(186003)(5660300002)(7696005)(508600001)(2906002)(316002)(356005)(82310400003)(47076005)(86362001)(8936002)(426003)(8676002)(26005)(2616005)(4326008)(36860700001)(6916009)(81166007)(6666004)(1076003)(70586007)(70206006)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:07.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3200a01-eba7-4d5e-968f-08d97d2ac3a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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

Rather than hardcoding it.

v2: squash in checks for SDMA3,4 (Guchun)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 572a634f7a1e..9e59fb792643 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -348,6 +348,11 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
 				adev->vcn.num_vcn_inst++;
+			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
+				adev->sdma.num_instances++;
 
 			for (k = 0; k < num_base_address; k++) {
 				/*
@@ -515,6 +520,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
@@ -534,6 +540,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_VEGA12:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
@@ -553,6 +560,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_RAVEN:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 1;
+		adev->vcn.num_vcn_inst = 1;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
 			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
 			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
@@ -589,6 +598,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_VEGA20:
 		vega20_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
@@ -608,6 +618,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_ARCTURUS:
 		arct_reg_base_init(adev);
+		adev->sdma.num_instances = 8;
+		adev->vcn.num_vcn_inst = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
@@ -625,6 +637,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_ALDEBARAN:
 		aldebaran_reg_base_init(adev);
+		adev->sdma.num_instances = 5;
+		adev->vcn.num_vcn_inst = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
-- 
2.31.1

