Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC3DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDF610E2A5;
	Tue, 25 Jan 2022 10:46:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20B110E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqz8uDDEFJLRo4unsdHLqmT8z5uSbkY68c05wXQ6+K1rH0ZxUPD88vR08y8ahqg4m8rIF8XQ7l+YIZAXcu3ZGBmN8H2UoTl6Rlu4za28aClD+EWtZhd+ukPY1rFm6CxNe72s8XJXJ/UYvo4w27fEIXE6Iv9k1bRtqGcU/0vjSqRdlzyrv5QNsOUhafMDwQyBFFp41Q1MrryuxneeCocrNZg8LFO9g+YFvo6nstfEgXTNnURVSQeI832JaUPBQl9ianLUbBOVr1LIGsgNnKgISw0PK4tZ7Q0oM4jPKbXbxKUQTQZPaKynUkVQhaxvF7ABwOpT2BOL7G74PeCioCX7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2Ym69Qs/rAeypV1KJfppXBg26+/tY3x/9W5RmkpcpU=;
 b=DqyU/lGqZnMDPV/hjlv8CnSR4+j6aFn6XxDLQlK9eegzgj0cUGsUXJV+ZbTx/AHsie4nOb5kEluO1vPNmDCK7ILmtC3owSBQWkUueQqAkJlDFTdm4nnOtJXh8tmErwH6sZ/50qkMTDthnYIPS2aMktaMnxCqBKP3pn9C8Z1YxfoONrjvqiYK8ddBWDdHa28OfNzZrs/RUJR2hy4meW+4p/AUp1q8QqM0p7h/7fLDBwe5VR0XY1Nh8+Bz6zc57AzbyCs0RgmPWQ6Du2RH2eIXT06KwcZ8mU8ak6q0vUNGNqdyQXCNI6lkOpN+8XAYADYcozNWK3H69R8sFBZrljNOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Ym69Qs/rAeypV1KJfppXBg26+/tY3x/9W5RmkpcpU=;
 b=oNumhw2kOB3T1J1qBzhqVyC8Edcz+PQhFSRoJQw/F3qdKwAr8Nqhb7beXHq8lmRKK3wAnvj2QQS/U9eIyTBxxbaFtlm4wWeBkdI+6/dmDmN870dBmnpAUkI6QwstRpmikogGGI7r/cAOIdjuAt6hIPRcFqQ43T3FCKl7gjFoHXU=
Received: from DM5PR1401CA0017.namprd14.prod.outlook.com (2603:10b6:4:4a::27)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 10:46:32 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::8d) by DM5PR1401CA0017.outlook.office365.com
 (2603:10b6:4:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Tue, 25 Jan 2022 10:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 10:46:32 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 04:46:29 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: get hash bit for CH4 in umc channel index
Date: Tue, 25 Jan 2022 18:46:12 +0800
Message-ID: <20220125104612.27050-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125104612.27050-1-tao.zhou1@amd.com>
References: <20220125104612.27050-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7886731-4509-46b9-d9b0-08d9dfeff349
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2574098A61F9A4C8B0D9CB09B05F9@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78aF4AaXYPJ6ETntgjv8B6GytxqQOL2hnGfXLvx7lepNAh4ltZVEGUnBhIS8mAtJm4ffiyBqCUUWDhoEFvgboLodhcguUGX7559BOXbjn++AbzihfE4b/Q0GAfZEgecU/O/M7BgnNNj3rb6aKYrJWYpEetoc4CqAzWpJRcmTO2616798JBCs5eCsyXxeUoMCV4+4KQjhCP32kaGU0rv4Ot2tlZ5gjhk6MQIOsZy4xT/Qpg0k0plOAZP+BTwMc/hP1RDWtBZ+G1kOaG+MYK1Y5lnnVHSTYYVxySWO7Vs8i1q+6OnxWpL3rZBu9S8gl1G11hNmNElteIqIbt+INGetpIuupwyfY3C7hCV1DhxCpfZMs0cUaGRP2ZmiefpqupR6ZI06aN/L0OEfQ6ZiJbrWBq0Wl34nGOOcd7oZuiws0Pc2pdtYNmYuPJMs1SyuE7WekxxDp4qrj+XiwP4R1lR6mXaD3VVl2DtLwt8WI8A8WVlHmikwpN2wncoUIeI/QvGDmulXPv6m4BGiN1rFBdiX3iDToRxOgu+AwpjbsnlC8zQDYvXbaeU7gIrTl9qLIxKVYFt8+3t4j99yMTS9Ix+k/9TT+vaNJVC4psj/KuvX1ppU8z6ixCNVGAhYZnXxJF8j9+OwiAr+m5XAyq6Kcc3GSsx0ahh/u9USMC8QNRy9HD9ek4OsOjrWdRfQuvb+qL3FT9mCoS8ZX7BWcd7giNacx6qbZTNY8/nnkSEHLjZbYaRXG0YWxx3uo9G9GcEM4vopRVPbwpJLeFC0SDiWhj8Nlpwn5s1lcLsPd1XZyr4LfBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(26005)(110136005)(2616005)(508600001)(47076005)(2906002)(5660300002)(6636002)(36860700001)(336012)(16526019)(8936002)(4326008)(316002)(8676002)(81166007)(1076003)(6666004)(186003)(7696005)(70586007)(70206006)(356005)(40460700003)(83380400001)(36756003)(86362001)(82310400004)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:46:32.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7886731-4509-46b9-d9b0-08d9dfeff349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On ALDEBARAN, the umc channel bits are not original values, they
are hashed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 1ecba7b5df1c..47452b61b615 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -148,6 +148,10 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
+
+		/* The umc channel bits are not original values, they are hashed */
+		SET_CHANNEL_HASH(channel_index, soc_pa);
+
 		/* clear [C4 C3 C2] in soc physical address */
 		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
@@ -379,6 +383,10 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
+
+		/* The umc channel bits are not original values, they are hashed */
+		SET_CHANNEL_HASH(channel_index, soc_pa);
+
 		/* clear [C4 C3 C2] in soc physical address */
 		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index b67677867b45..e50f7692bd03 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -45,12 +45,27 @@
 #define UMC_V6_7_NA_MAP_PA_NUM	8
 /* R14 bit shift should be considered, double the number */
 #define UMC_V6_7_BAD_PAGE_NUM_PER_CHANNEL	(UMC_V6_7_NA_MAP_PA_NUM * 2)
+/* The CH4 bit in SOC physical address */
+#define UMC_V6_7_PA_CH4_BIT	12
 /* The C2 bit in SOC physical address */
 #define UMC_V6_7_PA_C2_BIT	17
 /* The R14 bit in SOC physical address */
 #define UMC_V6_7_PA_R14_BIT	34
 /* UMC regiser per channel offset */
 #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
+
+/* XOR bit 20, 25, 34 of PA into CH4 bit (bit 12 of PA),
+ * hash bit is only effective when related setting is eanbled
+ */
+#define CHANNEL_HASH(channel_idx, pa) (((channel_idx) >> 4) ^ \
+			(((pa)  >> 20) & 0x1ULL & adev->df.hash_status.hash_64k) ^ \
+			(((pa)  >> 25) & 0x1ULL & adev->df.hash_status.hash_2m) ^ \
+			(((pa)  >> 34) & 0x1ULL & adev->df.hash_status.hash_1g))
+#define SET_CHANNEL_HASH(channel_idx, pa) do { \
+		(pa) &= ~(0x1ULL << UMC_V6_7_PA_CH4_BIT); \
+		(pa) |= (CHANNEL_HASH(channel_idx, pa) << UMC_V6_7_PA_CH4_BIT); \
+	} while (0)
+
 extern struct amdgpu_umc_ras umc_v6_7_ras;
 extern const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
-- 
2.17.1

