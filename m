Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E786EC531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4C810F1E7;
	Thu, 23 Jul 2026 20:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBDKD3uE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29BF10F1E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjZgdtFFoFhatCOYyG2rFqsi8/1JVdSF6iicTTb0ulPviRxcjDvqEP1JnH3B4OO+oeYkDIqb8aJsuosNPbzJqPT83rvAz0SQVJbz2feqFHrkTLu5rSruJFDXoWa0pcDwAFdBqUUC6Wd/pPwmDxRGHVPh6fu9N95ol5HkZZ6/XYHzKz0QkSJCyQAyhJypy6vwkLkDIQEF1OJfOjDe2NECM/ldB63pqYz5x8wnbOUKRy5YfrgMK324RpoJO8IfEA/sJxCicXiMrXJS35bwx7TdVJ0ciHspDpo1SfDECVHXm331XaEOiKIpqTRFFO9ktkguolKfW2njVxG+QbahxE7v7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMhujcV4+9ER5hMTuKbFJcSjbQrnzqtmSPXs1iqwuP0=;
 b=h9FvAC6tXnaKSKL1xFCKZIS3O5McVEkKgE2r1EY4ir2l4eOp0CeUKeWEcUR7XLsBqlL+r1bX6/xHgIEpxFtqkHcAArNy1w8LUtmxHPquvthZAGupweBbilP7gTQLrsSozxDP7L7gFqDaWqqaehHm+kIRSI0yj1clFbW7Bg/CBicPPgj3A0q2czIwnu7JL530xBuYf4P3z3qdEYmZirGo9GX+5KOv/uUG9YMp+gt5cEkS4Yp2FbMVr+eHy38QMY0HT+WhUCziJIElgYsCNIvpObVDDx27JdUND8OEgaMbmoNy74Gk/sGHpPoIBpU220dG4h/JxZmbRvmq7piyWe44aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMhujcV4+9ER5hMTuKbFJcSjbQrnzqtmSPXs1iqwuP0=;
 b=SBDKD3uEveHLvfSKvSBy8RXKafCNcwmoikJUA/Ljv83NbeR+2mNe9/zqClqvvaBeUOoYPvPjJKd5fpkrGbWD925yyXMFXUzXzKhjBsYb2XH1MFmXXswGyzz49xsFM8FXJWhpzc3/R53n1jk1tRn5ev1rb08Qoy7sjDpGOVyAedk=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:33 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::60) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:32 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:13 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 34/49] drm/amd/display: Add initialized-branch test for
 psp_set_srm
Date: Thu, 23 Jul 2026 16:13:42 -0400
Message-ID: <20260723201908.373300-35-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9404d83a-6f52-42b0-b970-08dee8f7b539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J7kKX5E4FuL6ePUErBEkQscVl66iJvq40gwBHBdjnExzzcS6ZBmT5io1unw93gTq3KkzU10uGktCN+TwcdF7Ry71gfTgcFyyoAMBeDeGuwERpFCxxgRhrWPybnxLI9IQ3aSTQw/ATVj/+Umum+5BaJuJW/flWPUGcVOpyUFXG6hM3Jz+gDsmc9bNeEu9hcLdlEqVP9cITH4oR8LPFlemO/EuzhpMDed4PK8gegQ9ZBZM8BmboKSj02RJo4Nfn6y+h1ozCA5ty0EUx2J2kfzQt8FFbCSEzBohx8QfOixxW0gaHrITV+nW/rSIfeljIxOdpgvjQvKrV3gJjeXNe1SnEPV3mVmYo1/kjNyyvzSgyEAeCd4mQn1Ez0cZlzBAFotZ66WUWF668jWad0GmPehcyYg1Y71ACWfEerCDpmYSy4ElJMAfZNNfKuMYsIB5jmdDRsMtDYOgRziL8mg5sw5Ckp/Rebwle/RTsCbL5gJV2gYJ/NPI2V+3vNfynY2kOYHtP+qR7aO9y2UZal729wZIFMVuLVT/c6aG9/6W4MjWCMJyN5dXC7jAyto/1Jebjk0BZfyDWGZhv1NG+FZgIcpuRdBKRH8+F+H2ckwHp4RC9Wjeht8St2S9W21GbmKfX6abhQO9Inqi/ejdpiokpGOisOcYx2pdDsxB73XDesiaEgD/aTNG3hApsa23Td1Jq70FYg2oT7BfaRGQeQxHKP+xfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZoU3uuv8intpKREbYqGeLdhwtcyO4J4Ri53PKtO+ktiQFiM2HDQkb5hTUMMvQGEd0MzNC3paG5l0VtOt8ukYzEltTbQ2gOvXE7yl2TwKvof/YG9+CKzU27+XA2jWTfJVZqQRmkDDny6NWacdNJrhUvaS8CXGyL7dm+c4a2+wIIwDxpoe1xPqbwJ78XieWY1M6p5vQPV3OITJWkeH6xv6+RKTveOJFA6in6qYnLYcX4yxUgicgWRVdOCseBNL25bWV2K09zKrcOgAv37OhI41IKx+yxRVyuBND+rrLAYdbOUt6VDAUWy+IzrRQkgdLOuC/9G3bd99/XVHVk2iWx73F+5UQeTnIUn5xwuIANWr/UTMPSwDrRHbWWVYv3adVp5ze8mTw8uzKY9/0TnUPT/rHne9bxlwRoyeYxUW3Sxo36JselNIn1Mp71B6J1iF3Sbh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:32.7752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9404d83a-6f52-42b0-b970-08dee8f7b539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Cover the initialized path of psp_set_srm() using the SR-IOV VF bypass so
psp_hdcp_invoke() is a no-op. The test asserts the SET_SRM command is
staged (cmd_id, srm_buf_size and the copied SRM bytes) and that response
validation fails on the zeroed reply, returning -EINVAL without updating
srm_version.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index 838826d274c2..b359ba5d524b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1349,6 +1349,52 @@ static void dm_test_psp_set_srm_uninitialized_returns_einval(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, srm_version, 0xdead);
 }
 
+/**
+ * dm_test_psp_set_srm_initialized_stages_command - initialized path builds the command
+ * @test: KUnit test context
+ *
+ * With an initialized TA and the SR-IOV VF bypass, psp_hdcp_invoke() is a
+ * no-op, so the shared command buffer keeps the values psp_set_srm() staged.
+ * The function must copy the SRM into the SET_SRM in-message, record its size
+ * and command id, and then fail the response validation (the zeroed reply has
+ * valid_signature == 0), returning -EINVAL without updating srm_version.
+ */
+static void dm_test_psp_set_srm_initialized_stages_command(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct ta_hdcp_shared_memory *hdcp_cmd;
+	struct psp_context *psp;
+	uint32_t srm_version = 0xdead;
+	u8 srm_buf[4] = {0x1, 0x2, 0x3, 0x4};
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	psp = kunit_kzalloc(test, sizeof(*psp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, psp);
+	hdcp_cmd = kunit_kzalloc(test, sizeof(*hdcp_cmd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdcp_cmd);
+
+	psp->adev = adev;
+	psp->hdcp_context.context.initialized = true;
+	psp->hdcp_context.context.mem_context.shared_buf = (uint8_t *)hdcp_cmd;
+
+	/* SR-IOV VF makes psp_hdcp_invoke() return early without firmware. */
+	adev->virt.caps |= AMDGPU_SRIOV_CAPS_IS_VF;
+
+	ret = psp_set_srm(psp, srm_buf, sizeof(srm_buf), &srm_version);
+
+	/* Response validation fails (valid_signature == 0 in the zeroed reply). */
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, srm_version, 0xdead);
+	/* The initialized path must have staged the SET_SRM command. */
+	KUNIT_EXPECT_EQ(test, hdcp_cmd->cmd_id, TA_HDCP_COMMAND__HDCP_SET_SRM);
+	KUNIT_EXPECT_EQ(test, hdcp_cmd->in_msg.hdcp_set_srm.srm_buf_size,
+			(uint32_t)sizeof(srm_buf));
+	KUNIT_EXPECT_MEMEQ(test, hdcp_cmd->in_msg.hdcp_set_srm.srm_buf, srm_buf,
+			   sizeof(srm_buf));
+}
+
 /* End of tests for psp_get_srm() and psp_set_srm() */
 
 /* Tests for srm_data_write() and srm_data_read() */
@@ -2356,6 +2402,7 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	/* psp_get_srm() / psp_set_srm() */
 	KUNIT_CASE(dm_test_psp_get_srm_uninitialized_returns_null),
 	KUNIT_CASE(dm_test_psp_set_srm_uninitialized_returns_einval),
+	KUNIT_CASE(dm_test_psp_set_srm_initialized_stages_command),
 	/* srm_data_write() / srm_data_read() */
 	KUNIT_CASE(dm_test_srm_data_write_uninitialized_ta_keeps_srm),
 	KUNIT_CASE(dm_test_srm_data_read_uninitialized_ta_returns_einval),
-- 
2.53.0

