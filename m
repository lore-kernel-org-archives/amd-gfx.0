Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74025C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 06:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E1660F9B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 06:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33E1660F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A196EB82;
	Wed, 28 Jul 2021 06:10:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7CF6EB82
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 06:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G69JZ7B3YCy+SMFFoADjk2NYcbpbyxQyugn5VKZgkLBGXsBNUK3foRKF9hjFgXMwlOqv9GbluDbkrMhmU4KSZur35OV/scs609A6wwHYwhgmSqYiSn9fXn2wHufTJrnNDgre06ETylShzdIs+evcT9GekXwHOKzMB/nphAHxePczDif4Ejug4u9HCNu7/W8mvkRyOCo/0Xn10PEwQJNLtDdNuhcofdsquOcfC6PQJncO9YLPJ0g9mlmdgSmkc/KbUMeJpASYMo7Y6d8pNfxtHZEHnPz2b21wmLVJ4N6YzTLMRsxf5uO9lKz9I/zGwTl8SV3YUVdjQZabug40I4Fe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp0np/8ANqSTBfuJndtg2KsAyr8/IX1t2RNOiU199q8=;
 b=byotct29jgv3oRbee3M5T/gd64iC5tSOl6K9MHyraJu6IlCEeL8u6PbBX9B6rUfPRsrtUPb7F6Kh6rP9elSnFcw1vOPBcadWfmAzfMRezUvTiOJLkBkeSzXhyr3/N3Cs6FGF2t8W40SDu2BUJMzP5du1lUDbeDfmTTTgXnoQj2eOJeHcVQb8EdWGWLV1W8h16PMc8w79txc0L81RwJUlraJf5K88CWIqZMPj5/xGTX+yX5ZVs4CARSLOpNQQLJtgF9B+QVMbrygJz+JsUgPKM3FzwtFb3J7ahl0kqm0QxKDF0IrH1OHL1EP1jzmP+tWbr4gfnQm527J2Hy7ClFYGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp0np/8ANqSTBfuJndtg2KsAyr8/IX1t2RNOiU199q8=;
 b=4sUQzV7DYceXVngP8z3qDKh9U4YHZZN7xJphdYjQzVpQETu8oFzsCFTfEdJFIKT+YWzt0onoAMHzXm1hXpJ+kU04azwZ1pxFe55QCj2xoupIGItch4T+2UgToEN7kauJv2cUh7WNZmEZP7VUaEh5Uu2qpl99j/LPFvyeyTYzyB0=
Received: from DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26) by
 DM6PR12MB3644.namprd12.prod.outlook.com (2603:10b6:5:118::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Wed, 28 Jul 2021 06:10:25 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ec) by DM5PR10CA0016.outlook.office365.com
 (2603:10b6:4:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Wed, 28 Jul 2021 06:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 06:10:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 28 Jul
 2021 01:10:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 28 Jul
 2021 01:10:24 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 28 Jul 2021 01:10:23 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG issue
 for renoir.
Date: Wed, 28 Jul 2021 14:10:18 +0800
Message-ID: <20210728061018.2512047-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903f8112-c1e3-4364-bd0a-08d9518e63d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3644:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36443129ED303E9D0D57CF27C1EA9@DM6PR12MB3644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKpbPpawQKsoGjS9lqqcuL26krLvIWevmXd9CyZJx6q7lvJQgbUY2IWVFT67mvx9mqs0q58OnkEu7oLzQYvXCiVDK5+JHy7tEG8h6HDworSxHPyve/VmghUsp6Y24KRNtOJxqRxxaC23sjVzLoE56gzD14jwvIvDvBFnqbz6PTN4pwvTX84qk8yDI0jWHhzwBbEXBt4rRNTR++6D/VS7Nvv45WnQ3HNSxuMa2xd/BBhk/u//uFrWjNZLdoKSUhfnemGZhZM+phsHcFxMPBkkwR+9uGlrn6LeAPYxRzd9s3B9D+YaUkQsUy+GnySV2QPd+z9Tb8rUjP2STt/zYcv/rEcBuk6cmpOyuuPxWx/G7QQH4lioJ6KZrvEdfSVb+HRZB1FYcnwzJtubPCERLVSys2/SIiPQqkxxGNiQxJcNcVBshsGed7mSobeNXrdkXXNj/v7P3KRFMemdIyVRgoeSGzD/BjgPzGWZU0voU75WydVhbK3x2dUqhJnZd+Yd2lGXCfTgIcGNecBi8JtOz0b/0ssp2P4UhRVGiKanUDT8IN4EUypADsh425hL3v3E7wS7tMbsfyFo72sY9wu6aD0RxgwVN1rZT3Mp92GWO1F1sR3dBtRT3fl0dibjtvdBPDwN6u1GAkMTib6T1e73lgne/zOpchmZuVmnWA6+9tqkcRbUDlzdx9cdc/bER/YlKS+mUDCPwv2cWYjeROdV7H2Jx7n3geokPwzLa2jBdjp+nI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(1076003)(86362001)(7696005)(2616005)(478600001)(356005)(6666004)(336012)(70206006)(47076005)(82740400003)(426003)(186003)(2906002)(36756003)(5660300002)(36860700001)(316002)(8676002)(83380400001)(26005)(81166007)(70586007)(4326008)(8936002)(6916009)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:10:25.1076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903f8112-c1e3-4364-bd0a-08d9518e63d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3644
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 03acc777adf7..70b64b510743 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,7 +3675,15 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		/* In renoir, if GC has entered CGPG, ringing doorbell > first page
+		 * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
+		 * workaround this issue.
+		 */
+		if (adev->asic_type == CHIP_RENOIR)
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+					(adev->doorbell.size - 4));
+		else
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 					(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
