Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21E1C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1D310EC22;
	Wed, 29 Mar 2023 20:10:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD7510EC11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odj/6rWbOy+uKuOw2YNHLVwyaSZFgKvG8q8c50ehXlVl5TovEcGdOPk4DCkhY55fqu04aB6bT9n+cVkwJ34XLSMXCS1KsfCq3MV8Y7yCdcr3dI2rG2Iewe2obzZuC9QbrRAPBItR5AbdJOhWLZzb4UqJc5SERW+CMKZQHrAQaoH6ePXpyWr5ZVEi4Nw/lJV+EQY3UCGaXSw0aCd0MAnOukdDoW1A5EJjnge3weN5uqriXmk4UQ+I0vOM0OU/bE1Ie/LpvdqNARPDjmaD/3NEUdsvLiyuAsxFsCTM8ZK6eGvGg37vpSVLUUZZ4S6o/KwSwqcqkk6IvxPCEl+fakiCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcsnCpHumW2LhxRso/McN23UVRdCvFVzOp9Qfd1o1b8=;
 b=UI9kahdulXdqY98VD4yTLP//hvQU5a1aH4bhS1CCAbOasB9rb2/Vuhgooy40K2sQqaV7P1MUkL5tDlFq3jRemEP32S6WwW+TbxEweKxHrB3yN/9hjFPV4wvlKVJUVKstPTepH9y+ErTe/tm5aoTEvmmntHdtT60badLfvXc9deD8yRZCro0EADvflE4DBKAuR5j1wa/GQXb4zqrF2mysZldFs7Bv2spf6GxdLVyjd9xnXfDh9O4/WHnf005LUPOsI7m8Z60F17N0gLB+N7HXL19hh+5UE30sYVlXH8cQVtqMxu9Zio0ZqRmjsFr6P+drvCds40zJBnKPtu2w+oJ/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcsnCpHumW2LhxRso/McN23UVRdCvFVzOp9Qfd1o1b8=;
 b=MrWEofMu9y+EVb5jFT+reeFC6PPpAEtUXWiUCCnMeyW2HljHRNT9jzrPu+KElSxU+Kl/MtCFmgMvBg7xVEl5xG/CATFUOPFCfQLIeWE4aKIZ2mbhP/5+0UL5SfLGxbjMfuhFh6J/zrQqLn8XzupoBIP9VuXsPXvqUkpbKMSVEhE=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 29 Mar
 2023 20:09:58 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f2) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu/nbio: add vcn doorbell multiple AIDs support
Date: Wed, 29 Mar 2023 16:09:30 -0400
Message-ID: <20230329200930.1982035-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb60562-6131-440f-4995-08db30919259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSggp/JfUOPRLQRliuriJaYbfTvRPrVJ6PFEphLyF1HRgqADArwHMESQ9rw7u4Oir9m4w3LlR9AqjFtE3ADJH4dKHyXpBdY3IdBuIeaZ9h5JnE0aKsuyNbiRKCgy6JHKN/KawH0wsn1maOheLlIjKT9IVPl84G1CEJ8wGgV70zrFGiFR43LiG3i25o/412SVjmqqaA8sITwfzCYZGEjy7YjC+GtxAuPCjPJl578uaYAwOzckFnpI7lGy4uUmuhX4MVaH2UmLhDQHQXsXvvuPE2ouIXetX3O1Gz12P5DZuUKxHktsdZOizZEKipdJ6deK+YtAGOj1kRsfFjfjYoQslI4siHO0pmdju1Ntqm0bOkIXi3GIojElPtPBHovassoNGyTiXxYxw9HI66X6ccxkKyXrPMpI9dsP00tcfDANyUUtRmqhgcLtui/gkWPxoqNL8yYZ3A19y6+EfeuivAZA//eH7DrMEOnZgRUlO9ygUon6BK5szZ8DrD6mumJcVQwaBfGl7rc1XwQqqLj3QYRJjwIqA9XO9P6hUqy/W4OuTreY8G0QlxD8EiRsf1abf/cxcdQSVYfCMCxdXOn7QIAIhUqH+TWD/S2Bj0U3GCyKpO18bRpe0VF6U5HWsmX7Mb4kkP+3WRQnirrpaPdW0+XItsQZDS+wDbZg0/cFphA0m6sOYT3JFtvIKgUYuRtQPJkFYFpIQe9UzK/Vzq+geqwHROX6No5qJQMGZejOXAcSco39GSgSK7f7R0W+JCn4mBjD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(6666004)(36860700001)(426003)(70586007)(5660300002)(54906003)(7696005)(2906002)(82310400005)(8936002)(478600001)(82740400003)(316002)(336012)(26005)(1076003)(40480700001)(41300700001)(47076005)(6916009)(36756003)(70206006)(40460700003)(8676002)(356005)(81166007)(4326008)(16526019)(2616005)(86362001)(83380400001)(186003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:58.5992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb60562-6131-440f-4995-08db30919259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Update vcn doorbell range to support multiple AIDs.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 70a5f030d5f7..22483dc66351 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -42,6 +42,7 @@
 #define regUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET				0x4043
 #define regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET			0x4094
+#define regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET			0x1bffe
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index dfbf5973efed..b3e1eefe260d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -202,6 +202,7 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 					 int doorbell_index, int instance)
 {
 	u32 doorbell_range = 0, doorbell_ctrl = 0;
+	u32 aid_id = instance;
 
 	if (use_doorbell) {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
@@ -212,6 +213,11 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
 				0x9);
+		if (aid_id)
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+					DOORBELL0_CTRL_ENTRY_0,
+					DOORBELL0_FENCE_ENABLE_ENTRY,
+					0x4);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
@@ -228,6 +234,13 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
+
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17) +
+					aid_id, doorbell_range);
+		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL) * 4
+				+ AMDGPU_SMN_TARGET_AID(aid_id)
+				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+				doorbell_ctrl);
 	} else {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
@@ -235,10 +248,11 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
-	}
 
-	WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17, doorbell_range);
-	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL, doorbell_ctrl);
+		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17, doorbell_range);
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL),
+						doorbell_ctrl);
+	}
 }
 
 static void nbio_v7_9_enable_doorbell_aperture(struct amdgpu_device *adev,
-- 
2.39.2

