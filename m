Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5E606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gCtkKgx0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF58210F75A;
	Wed, 25 Nov 2026 06:58:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A837F10F74D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq1ItvmZChQ8hDH4EQXsFVJuzURg6opr8WBP21FqUMdRw/ww2+FcEtZG8N6FOuUFJcpcso53wXxBbr/35+QJuGoajTGAG/l4WN0nMwaIIrQhqu8qdN0L0bPqP/dASDIMWzdIH2mU7wFz1Oz5bSPZTQ3IBHlYgY04AuS3Fuc52oOJnE6kvLl3tJ6k0tF3lZJy0UXBKztOJItTKonxqjteQ0bNdkLrsRmL0/HQWeCuUQMto1Nud4XcEPW14Bwvz4VjFjcn4NEl5NT5r+i4Ro49E5DiagzQsjpbV9XIJKaLHShlYPXNRK6KLbo2ty2gBTf/zYDoh6MK2ZDFGo6uE12zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJXqUdlHJPgEj7/rkjjkVF/HUnfk9bMwlGsPQaWXxB8=;
 b=yXgH665ZCFfAjFwBNOWQ9hCOoi5BYaN3pdYh1JpXpPd1xPzkcSzMd109/FRr7A/UHwUt2tlwermftofA9nkgX3QE0t4oqiESVOSLlGWOKdEmaA6ibx1yzPXdo7phiiC8J/9CM+V+hsihVAPuFhIhSqIajhKWEsDh8x3DKom0Igktbo+FsyNPLMpRMiwW4P+unB0gp6WJ9OF5lpByDwozhBep1qt0Ikbc/lY8ukxge8HB3Sure9yZtwuGKDUBejEyZzGn+3IDOT/lkHSVDQ5M9NIjJlq23/LAESiB5fgj+sH5Z92u69Qa2+SCkKPi7FUI6r6PsDaSpD4+18lpAj42kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJXqUdlHJPgEj7/rkjjkVF/HUnfk9bMwlGsPQaWXxB8=;
 b=gCtkKgx00acFm2mqFSElDYhsAZBNEeIeCxu8eVwftPoSayvRaFh6DjgNbVKQTn15ANmEG/Qiy6w1QMvQ3/HqJkUokQ3o01iPpDzdtpx/EKyRPNjM4phhLaBk+xRUZ0hSLVd5bMwur2i12WjYSC1LHhRfWqx4Np4ZxWxXEIFoyqE=
Received: from SJ2P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::15)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:58:27 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::38) by SJ2P220CA0011.outlook.office365.com
 (2603:10b6:a03:5da::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:58:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:25 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:17 -0600
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
Subject: [PATCH 21/27] drm/amd/display: Test amdgpu_dm_dmub AUX transfer
 timeout
Date: Wed, 25 Nov 2026 14:55:10 +0800
Message-ID: <20261125065631.3889665-22-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d036618-b55f-4e52-8a32-08df4ac18122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: MK5bICRHKv+nCMFteNfCd86koV1LU84/kSGXKfipAP/Z9sI8d9T2Ne2M2Ey4z3kHN9mQlLcNLhK/xgtAKUHjvGMFxY8n3Sj/iot9tHIHA80xsDp+9PLi6ctcAMDPZeR8b8r2mU0SD5confTTZZOdKowtX6BXZYmFV3MQJEFyA/2YqVeFQQviQ1dK8cWTNhUvJ68FM8tS2SYDkm9+w+fzE46D0IuEX1m2P7BVTw5AbDKJqQrFHXOKbv+Pqe7BpufqqxVoGq8W8tEtdA5fd/s5ZTB7kxJbrIXLzA9Yze8+XBab/UQCx8Ddzgm3BPbQH+/HCtKMkD4FdWdm1VZjY28C+Drb4gBAd2FnJL+VtwqAlmPHntH0PIV3V3qkH2F9BYuPQkZIEy9wvCmJnLA4ciugxzcdwO/1Ye4Mi7+gqqeJO5CHCc4O987FIk+Mcio2yLjf3DC1XGbgq90guZNaJVlZ5PSwVli4aVEHhQCuiahDuQlJZVTOKXq6BQuBAYZ/CKvFF2tLZRtBsIoPcpMnkKFDs8YGxt151ygFBUviGW5Pxq4NkR0NZevG0oulnUAHtT1P18QMYfM4bgMehb2kTrcXNNbkRsP0abzgfaOGUfk+1K8GFaLnV8TN/qfgp8Lup/16Y41Ue5eeGoIfd/KSccbJqRLJUPwuutbamrL7nTqEAC41ysBujq2SUjBay+Wp54Org0AbM9Ig9Sm0kJDLV8MjAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v2DjxW6NTTfZOmuXkLRDp2/H1aZWrRMTILNEtKqmBWAKJfRQimN96/TEqZpw6Jc42qUlnX8q6910R7B/RdQJLeS6olI9kxNxkIFtUTkYKc/HvMfrgFyKft+JUUCdUncafWwIEKfRNIRaUBe90Qu2ZIbPcz0FSaB2VHj3nwIFJf5oupQmGu5hZuxVWrURkHjPMikyjMa9sXENf/Lb0WeZ447TgAdVGZ0NG39Z/Sv4UkCpKkZY097XmR/7haXfYjw9lqa89NPgD4z8Hs428mLBJeHvvMSslB3DGMcCEnNGQp2M9yOEHB69OPNKcx/sFLgInvE0wTf+g7SjBksXLWBIj4Llez4BLmFottEtIhfUXDMCtr2FqBBS5MOlCs35Zf6szcapv6rdCO9Gi9Klk+tseGVSZPeicBbDNQKrwKn3WMrw54z2WtD8Z75TCmKhvZOx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:26.4557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d036618-b55f-4e52-8a32-08df4ac18122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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
Add a KUnit test for amdgpu_dm_process_dmub_aux_transfer_sync()
covering the AUX reply timeout.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 164071f39731..8117ae4a2aef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1536,6 +1536,26 @@ static void dm_test_process_dmub_set_config_sync_timeout(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, result, SET_CONFIG_UNKNOWN_ERROR);
 }
 
+/**
+ * dm_test_process_dmub_aux_transfer_sync_timeout - Test AUX transfer reply timeout
+ * @test: The KUnit test context
+ *
+ * When DMUB accepts the AUX request but never signals a reply within the 10
+ * second wait, the sync helper returns -1 with AUX_RET_ERROR_TIMEOUT.
+ */
+static void dm_test_process_dmub_aux_transfer_sync_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_link(test);
+	struct aux_payload payload = { 0 };
+	enum aux_return_code_type result = AUX_RET_SUCCESS;
+	int ret;
+
+	ret = amdgpu_dm_process_dmub_aux_transfer_sync(adev->dm.dc->ctx, 0, &payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, result, AUX_RET_ERROR_TIMEOUT);
+}
+
 /* Tests for abort_fused_io() */
 
 /**
@@ -2164,6 +2184,7 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_protocol_error),
 	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_copies_data),
 	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_zero_length),
+	KUNIT_CASE_SLOW(dm_test_process_dmub_aux_transfer_sync_timeout),
 	/* amdgpu_dm_process_dmub_set_config_sync() */
 	KUNIT_CASE(dm_test_process_dmub_set_config_sync_unknown_error),
 	KUNIT_CASE(dm_test_process_dmub_set_config_sync_pending_notified),
-- 
2.43.0

