Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2D6C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DEF10F074;
	Wed, 15 Jul 2026 13:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXraecvg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC8410F070
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE/n4i2tp3yf8ey/LRuMEVykdzMOAbVS17MrBWmyaC3svMNjS8VdJzWBhqGc0rlAYggzwtELC2aKDoTMA+MxnT4hw2L6bInZCLBQPH7U4zlZDiymjkdAT2GqmMtHE0xfWSINPeLkwujS3tnuWpwqn9yx1ObNmgupMbvx/RrzTIhoiohL7G9pJr5Lj+y7k7e0PlBns5tk4V2q1nR8WNaxt8IBwOeJUcS1hDmZzJ4cdIedJUjfHuIxncZU0wabgIbWMs9sp3LRj9gjk7pxqIRuDK+q1DIT16vgmnIoTpZx/Mo0vdTJiiGD1ZEQfzcCaH0HMVLUi+w4TnfQ90whGeNAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51nedmKWXH69Xh/tWBdDANuHuHca4tv+rocZeKrL3TU=;
 b=det//aBSkr2lc09+/5h1Mko+qsN/4nkCC0A9JHMVRGRD2lTPrSjRoLUad7eOOG7qio6IBwzOXc/AxgtNFzh4hZS9MhhRJpEQ7lWvdBCna6di6PvoNdPN9/NBA+ramWAcTNrUNjkdqOcGmRzEIGSJNV6dqZ4e0uABU6E4M8owx+Bre+YyLgnKGjBE4+J0d0MfkSatJQ/4Atc4ha8Uoix0f/QxEL4BlC/He/oZ2tz0YcrNKB96m4xjAmQNrRK9fC8VrSAspiH7RBwuhzIXMjwn1Ut5qOEba0gCalq1/ZxvfMJsbDmyp35PXWU4rT05DSEHqS45iBMfqiBZqq4oGcuChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51nedmKWXH69Xh/tWBdDANuHuHca4tv+rocZeKrL3TU=;
 b=KXraecvgmdVRVuyfQXtfqH41p6v613O5ztoH+AO/qE5Jypvo/8yGJPjxHx7aetyANylk6c6JX9GR/brr9rvhcTFno2uVaFktvfOwPEwwLi00La8l3I5AMu6zZk874yKdL5aaO/quiF/2v6kUUfFatidtQKRfgt4NF0OmkLcdXlY=
Received: from PH1PEPF00013302.namprd07.prod.outlook.com (2603:10b6:518:1::11)
 by CH2PR12MB9496.namprd12.prod.outlook.com (2603:10b6:610:27e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:45:41 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013302.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:26 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 09/70] drm/amd/display: add VBIOS bounding box KUnit test
Date: Wed, 15 Jul 2026 21:37:19 +0800
Message-ID: <20260715134432.1975118-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH2PR12MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a0a192-f492-4146-b3f5-08dee2775c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|3023799007|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vmqdi9GUVHm2ffGmVWcGZuhw+ayGwGB9RxGHGC/M4YGpSiSO8HBxekIvbyrQ0fUrFONv8rLBzycrJN0UUoYvXm7nag982FsIOFMU+9he2hovWJa+0Vj9xchSdhAeItxl1IVLI2r41S2gN/SWfVnX3s8Bd/yydz491nDqtUsCPwKBD4JT1O6lZwMhWaRdFrEI4QpIl4RkbZ4FvvG87AGze7FwhrKaehFiY/3ha5OgRp0f79pyC37WALFAYpnIZhO9eAJ0CylblGc9FnS7jLNxnS8fdVyS8qIKTv43Xs1jHlcAjfnYoRkz7PSsTaf12TbxEIv8vCj8YW+TZXVOD9pVBqyTzf5Xo93Z8iuxqmqMpfkx5Q862cavqE/DiT5r3kGTzT0rn22me2Uoh72dGJA35bfb6DtN8vj0mR0tOHHi6QNTLI7s1tkhYiB5Pb1NDCZre6dYvhNUUzIKBtW4s6aH4JfvAu7xsO2jcaMMMKgS1pFwnHwzNoWdPjGSy26549nIVusD26BvkvCqeRAnLbPbN3bhNJr2bQForRS0M63WxV1laeaQZGZ3vwjpq5cYj7hT9EIajq9948H4828DZTaEr4RlUbS9qqiStqV+qJ/PCzEdlaaplYlT2WnC8uu9qpeTNY84xaeGwv1UNlHQo7ZlQ82iMNJ1KYPg4+Kd8wPohsjgcUxgaqEIfYN23lHPslhwdqbByK6Cypq0HNZzGVtB4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bNf4CUioWjv9RZSSA8pHBfwOS6uQ/WDvKlJBiEBUC5wY8c/GJK0QuqC+AJuIiqWMW+t/kR+yTx2zONFtFE/73mU0vkPYFDJHTX2nNDx0HoXWdGcLsELQRMuhA1cTsMMFJCuClCIjhv+cpjc2IzOTXsy0NM4rQWcY6tqM2z9lgtD53QXe+nbEBWFgiafO+0BTs/Id+JMwtRrlsqPTX4BzmoS9oPb7926AOLizQ2X5mKXCgyE0pTTiTrTI19cbyilJG5mvdSqXUbbb2WshPS/RxLrpAWrXWLqtpKoQusp5RNwQJmigVLMroEUKdHIk6S90DBWUgIoVM+oZRD8nMaJ9TKCfErAI60daEX+lOPO6jLSoFO1EXs1Hf5EDI5Lm8uedcnaTs/0sTzJhv8qPipUJjJKkb2A9RVRU1fERwpyq5sRpv7BeX/2y95R04/uV85LI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:40.7604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a0a192-f492-4146-b3f5-08dee2775c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9496
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add a KUnit test for dm_dmub_get_vbios_bounding_box() covering the
default IP-version path that returns NULL without allocating GPU memory
or issuing GPINT commands.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  3 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 24 +++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 992d9f525ffc..21f6a01840ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -385,7 +385,7 @@ dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 {
 	void *bb;
 	long long addr;
@@ -440,6 +440,7 @@ static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 	return NULL;
 
 }
+EXPORT_IF_KUNIT(dm_dmub_get_vbios_bounding_box);
 
 enum dmub_ips_disable_type dm_get_default_ips_mode(
 	struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index ba50e1af80c1..c53728d1c131 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -69,6 +69,7 @@ int dm_init_microcode(struct amdgpu_device *adev);
 struct dc_context;
 struct dmub_cmd_fused_request;
 
+void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev);
 void abort_fused_io(struct dc_context *ctx,
 		    const struct dmub_cmd_fused_request *request);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index d75ee1c930ee..ead43eeb38c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -932,6 +932,28 @@ static void dm_test_init_microcode_unsupported_asic(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), 0);
 }
 
+/* Tests for dm_dmub_get_vbios_bounding_box() */
+
+/**
+ * dm_test_dmub_get_vbios_bounding_box_default_null - Test default IP version returns NULL
+ * @test: The KUnit test context
+ *
+ * For an IP version without a bounding-box size mapping, the switch falls
+ * through to the default case and dm_dmub_get_vbios_bounding_box() returns
+ * NULL without allocating GPU memory or issuing GPINT commands.
+ */
+static void dm_test_dmub_get_vbios_bounding_box_default_null(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+
+	KUNIT_EXPECT_NULL(test, dm_dmub_get_vbios_bounding_box(adev));
+}
+
 /* Tests for dm_execute_dmub_cmd() */
 
 /**
@@ -1369,6 +1391,8 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_sw_init_unsupported_asic),
 	/* dm_init_microcode() */
 	KUNIT_CASE(dm_test_init_microcode_unsupported_asic),
+	/* dm_dmub_get_vbios_bounding_box() */
+	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_default_null),
 	/* dm_execute_dmub_cmd() */
 	KUNIT_CASE(dm_test_execute_dmub_cmd_null_dmub_srv),
 	/* amdgpu_dm_process_dmub_aux_transfer_sync() */
-- 
2.43.0

