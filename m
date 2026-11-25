Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8521606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xn/OTjEO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630B410F74A;
	Wed, 25 Nov 2026 06:58:29 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23B310F743
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUmSbGOMkBmorszsZbh/8JAvN54wLJsTL75+hJtU0h6c8rNBO57aMwBuqJsCw3rbN/St/a28gcflT3uzZ9HY2EfNLXrkzFvK5CBsRQ73vccrqeL1dUrYE6ehr0eTlgp1UpDYJ6Zwghx4xqtZ06nQ9GiNmjHEbBFPCmO3ZwUzIm4PNrrhngRj64Dcqa/2esSxy/x6wrTkOSZvt9nr6CqlmbupCyottJZ8hL8opZJyr/CEH8C8gQoUIso+/jaNx5F2aFifHvpUbIOHKYC8zhZfSyx6PYwAQOWe5RdE9RoWWwTvXjkReI6zK+g8783KYm+GilmK5Fr7b3wGzvbFBktEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnbNeAscJBEHG47dupFwei6FltPGiZpYIsaTF/+MOu4=;
 b=L8gCzAFuid5ZxHODhn/TWHmKdyTomGI905STRM3aYj6qCDM9S2bBuoV8Wcj1W/td7R3AyPOnHwQT/MipsFg42luza/A2mc0j06/Ba4vR+Db4LRn/VJgJOnpkIZ5mMviPaC18TwfoI6HYucHY7YJQbFKImAupG0iVF9UDUCpZa6kRgVHQYCWxlqQmjXOgfHBFrzQmgDszmwb4Y5utFWyUWbab1A96BVy/uO6vfPQIhxWNozhXSJMhTqjZtps3JHwNpS6Ymn1J2B80ZpvkpYXimGoGDsUK0e9h5H+w9irERUI8MOMwqOx96u29aveAXWhyqcX5q11JI1R8tBZyjUYwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnbNeAscJBEHG47dupFwei6FltPGiZpYIsaTF/+MOu4=;
 b=xn/OTjEOqGM1XYoPODn3bqqp46ErJzykVzBv64fUpM9ixUqPVrkxUJJ0aIMBWANXK/8TnJQFw260a4KgqStTwBUfdKH/hy8FIBpQfZENW1CSiaqnL2VIXFbMFep2QznMI0r2rF3kXJnYnZCEkj0h5mXNob+dYLzPijDi4c5NHlo=
Received: from SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::11)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:58:18 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::75) by SJ2P220CA0004.outlook.office365.com
 (2603:10b6:a03:5da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:58:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:07 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:59 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 19/27] drm/amd/display: Test amdgpu_dm_dmub alt-ch apertures
Date: Wed, 25 Nov 2026 14:55:08 +0800
Message-ID: <20261125065631.3889665-20-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e37eb6-1d47-4b0d-ffb5-08df4ac17c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O+h8ucO4bqcWIslAc/VFXK5r5MgWqALPDV4kung+RHPNwWUXalimv62s0t2zQju04ODA5bPu/UrHLjPR8FAPsREitb+Nts19kE9PvRSOqq45LPWaD5s4fIwl0nvTLtRxoqkQYC7J86TtfAzgHX7LqjUSeS8rkdf+GY8my3hlYVUyvZQdsjIVIRofarqtzV2tizqCYsZHIoL3OJGj6tYOoxCuspJzlOQ/ygosqFAvNfp+OxtbA4kO784OPgA0UeXHMXrpNRDflVOhPA2zfV+360NXa4qqCkajWAaZC3rkDmxHNSYHLV/sYKhct9HXCYQ5Vrfm/QjndwtxXP43RkffkeCDJfxeuQ4IdElxVWROZ32UmCSG1/nYPjp4D8bTLY9HoSeoE0BiF5PhlRqngA/VzXnajDbQuKcbySmqolv7tfOa5lNAoMPYfPgUGphka47RGwKon/tpjfm/dY8VDwjza2zPmAxyKZxSqk6/x4AibqNLu72mGwCuyDdY+EadFra9C4A5rEeKIKdx7dYGZF0ts/p2FULXM9lq2Ve5+knv4dLUQBDSWr2GSr8JQJdJEM36aU846D8CQcfFDFUMR2HML7EacgS+Y4atadDCW4rTTQ2LXaL3mEsrXpwb/lJN6jsEREF5Vo1VCnhv9DZxmfGg79vqncwnd3wiMf8irdXPpWppjTcHfR4NAFoQT1sBhGhXsV2G6l8NKv86z5d6JzE35A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9/mLT3ECiw0vS1h2RW67LUy5v971Dl+YOT+weO2XKZtw5lkZVYFQXlt+FLBBwVR3INvOMAjzkhjHQ1g7CnNwCxcv24OywnReN/SjW7Oc/EjN7bdI0/5Zd05kz8gt2FwEgwIcpySzs2MmtIZ+/9+9PVCQLQepWofpWr/M+u2mf0cRFIkbTWLld835GuvRwLix8cIILK3YCLUWliSCjIrQS+/+ZRfkDPM7BgfYLQbY1blmVuTcjWvtcQFPI0MuKbrTbHa4kZAwRG2fp/YoUD+65Ra9Wo+w0Tj4MWzlIwftcO32eD1s/ZeNqGyfngoJPCUhOvM8RTZEMlwgfGU+cwsK9/eSgp6xyk950kTIWavoJ9zC9e+7XB8e4gxQTBJPqZmfMRLegJ784LFRX8E6xJWAlTNto8QTpUO0y52xRe49202cM9BrVeV+xTvgZ/W8AOPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:18.7584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e37eb6-1d47-4b0d-ffb5-08df4ac17c8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for dm_dmub_hw_init() covering the alternate-channel
p-state apertures: both apertures published to DML2, and a missing or
invalid-size aperture leaving the feature disabled.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 595a7dcb57ad..1a4fa8c7e00c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -835,6 +835,96 @@ static void dm_test_dmub_hw_init_dmcu_abm(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, abm->dmcu_is_running);
 }
 
+/*
+ * Fake discovery MEM_RESERVED_INFO table: the real lookup in
+ * amdgpu_discovery_get_mem_reserved_region_by_id() walks this cached table.
+ */
+
+#define DM_TEST_VRAM_START		0x8000000000ULL
+#define DM_TEST_VRAM_BASE_OFFSET	0x40000000ULL
+#define DM_TEST_APERTURE1_START		0x10000000ULL
+#define DM_TEST_APERTURE2_START		0x30000000ULL
+#define DM_TEST_APERTURE1_SIZE		SZ_16M
+#define DM_TEST_APERTURE2_SIZE		SZ_32M
+#define DM_TEST_MC_BASE(s)		((s) + DM_TEST_VRAM_START - DM_TEST_VRAM_BASE_OFFSET)
+
+static void dm_test_set_reserved_regions(struct kunit *test, struct amdgpu_device *adev,
+					 u32 num_regions, u64 aperture2_size)
+{
+	struct mem_reserved_info_table_v1_0 *table;
+
+	table = kunit_kzalloc(test, sizeof(*table), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, table);
+
+	table->list_num = cpu_to_le32(num_regions);
+	table->list[0].reserved_region_id = cpu_to_le32(G7_PSTATE_APERTURE1_ID);
+	table->list[0].reserved_region_size = cpu_to_le64(DM_TEST_APERTURE1_SIZE);
+	table->list[0].reserved_region_start = cpu_to_le64(DM_TEST_APERTURE1_START);
+	table->list[1].reserved_region_id = cpu_to_le32(G7_PSTATE_APERTURE2_ID);
+	table->list[1].reserved_region_size = cpu_to_le64(aperture2_size);
+	table->list[1].reserved_region_start = cpu_to_le64(DM_TEST_APERTURE2_START);
+
+	adev->discovery.mem_reserved_table = table;
+	adev->gmc.vram_start = DM_TEST_VRAM_START;
+	adev->vm_manager.vram_base_offset = DM_TEST_VRAM_BASE_OFFSET;
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+}
+
+/**
+ * dm_test_dmub_hw_init_alt_channel_apertures - Test hw init publishes both p-state apertures
+ * @test: The KUnit test context
+ *
+ * With both G7 p-state apertures present in the discovery table,
+ * dm_dmub_hw_init() should translate each base into MC space and hand bits
+ * [47:16] and the size to DML2.
+ */
+static void dm_test_dmub_hw_init_alt_channel_apertures(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+	struct dml2_soc_alt_ch_info *cfg = &adev->dm.dc->dml2_options.alt_ch_cfg;
+
+	dm_test_set_reserved_regions(test, adev, 2, DM_TEST_APERTURE2_SIZE);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_EQ(test, cfg->region_base_addr_47_16[0],
+			(u32)(DM_TEST_MC_BASE(DM_TEST_APERTURE1_START) >> 16));
+	KUNIT_EXPECT_EQ(test, cfg->region_base_addr_47_16[1],
+			(u32)(DM_TEST_MC_BASE(DM_TEST_APERTURE2_START) >> 16));
+	KUNIT_EXPECT_EQ(test, cfg->region_size_bytes[0], (u32)DM_TEST_APERTURE1_SIZE);
+	KUNIT_EXPECT_EQ(test, cfg->region_size_bytes[1], (u32)DM_TEST_APERTURE2_SIZE);
+}
+
+/**
+ * dm_test_dmub_hw_init_alt_channel_rejected - Test unusable apertures disable the feature
+ * @test: The KUnit test context
+ *
+ * A missing aperture 2, a zero-sized one or one of at least 0xfff MiB disables
+ * the feature, and dm_dmub_hw_init() must not publish the valid aperture 1.
+ */
+static void dm_test_dmub_hw_init_alt_channel_rejected(struct kunit *test)
+{
+	static const struct {
+		u32 num_regions;
+		u64 aperture2_size;
+	} cases[] = {
+		{ 1, DM_TEST_APERTURE2_SIZE },
+		{ 2, 0 },
+		{ 2, 0xfffULL << 20 },
+	};
+	struct amdgpu_device *adev;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		adev = dm_test_alloc_adev_with_dmub(test);
+		dm_test_set_reserved_regions(test, adev, cases[i].num_regions,
+					     cases[i].aperture2_size);
+
+		KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+		KUNIT_EXPECT_EQ_MSG(test, adev->dm.dc->dml2_options.alt_ch_cfg.region_size_bytes[0],
+				    0, "case %u", i);
+	}
+}
+
 /* Tests for dm_dmub_hw_resume() */
 
 /**
@@ -1958,6 +2048,8 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_hw_init_sanity_checks_dcn31),
 	KUNIT_CASE(dm_test_dmub_hw_init_sanity_checks_dcn314),
 	KUNIT_CASE(dm_test_dmub_hw_init_dmcu_abm),
+	KUNIT_CASE(dm_test_dmub_hw_init_alt_channel_apertures),
+	KUNIT_CASE(dm_test_dmub_hw_init_alt_channel_rejected),
 	/* dm_dmub_hw_resume() */
 	KUNIT_CASE(dm_test_dmub_hw_resume_no_dmub_srv),
 	KUNIT_CASE(dm_test_dmub_hw_resume_initialized_dmub),
-- 
2.43.0

