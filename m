Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40886EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A6E10E147;
	Wed, 14 Jun 2023 17:58:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC0710E141
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMfNyHMSoLqCdg6Oglq1XTw9ruPPmbJZPMrUMLzEOeRh7TH/D6O+sJYoCwsOL3xWM/NOd0/tDqn6b/GidPGwfZCH3yx7erZW4HvI3fVwt7UkA4TVkVUsq4wBcss3ZSb/CLUVAYdRyX69Feil9XdImkKmYYe+dTL6E7j4Iby7j7t2DpSzEXSC6QygKmZ0tquMaIBIDwqSJ7psw5UHQ4YKOBwCKag6G2N47K5KfBo2+u3eTmGYpiaVIVIJi6ZeDVd1jty8xF/lMmVuPlUrNdZm3LWGrQ1KIUJrZ6Sh+Jmg8i5cciOl3tcW/+sB1FZHphEI+YDhcfbwg9zLFnctemh7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYSNs4wvR0EOJAZ5wfyzPQInxhNiWsf1i5UWDT4/yQI=;
 b=eaX2t3QU9k3CjF8KoyPOZcVDwh5cQVGWrxX4aeHR3Fe3oDEmTT8RZEk06M9HbT/6JvSMAYYv58bYnAbbDIwb6QGftDN+LHUHBZueJ/4MOP2or1W3N18CkMQSidRqSbkmK5/j7Qp8pMnM1xfGLhbcp0871brNIJTzMRU1mOM1FQ3tf8Eb10q663lJu61ODR6puR1G3S6YYYsYHX2UUfpIdkLPwdcVy7Jj/Ai+JpT0SkSnT3YQ4/+aixB/l2aeSKGUMV2QXiWduJlau1ROgx5jNgXJH0v5DMo7t2Xz9qkXe0Zd9tbeCO2Y5kAf6CYcJXkaHTSK7iscLBELQmOcKnZcqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYSNs4wvR0EOJAZ5wfyzPQInxhNiWsf1i5UWDT4/yQI=;
 b=UZ54mndB6VmJU/7lOjmF8uYAbx83qSqqR8oD6e8c3ZDVBSwJDb+4i27jpcqmD+QDxl/6IhkMe5ZhvEf+AFy3Eu7lvk+cVDnyQFfi9YeOahGqh8jIe8WCPu/uuGpSq9NxYNA3ZXHHfZ8IzdIxBYlZni9EXkpjEyFBU7ubM+8lG9c=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 17:58:09 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d8) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:09 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:07 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/17] Partially revert "drm/amd/display: Fix possible
 underflow for displays with large vblank"
Date: Wed, 14 Jun 2023 13:57:34 -0400
Message-ID: <20230614175750.43359-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b7352f-6bf1-406a-8e2b-08db6d00e9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lSYtjM0xxCNF6LtiXUqD1SHYvh/9lcdcTcptkiZ76F0EDvGx92vjpmOP1kEmjagSfGRKKv+5VzwlyiEg7thdRQH1EahHqQpis5KjmO9oVlXOvrBoPhwM5xElozp03rverwNFjUyu9myMH88kWyUQxd+fcKtj5ygMn4eX9Z2lGhtofGz+kgTp8hy42c7EMFqmR7CT6vpx5POWAiDqPIbTXLVqN1P1WTX/cBWk1RrXndnVUAAnbWuiqoY5NVkHha7G+oTVockXwsmvrHAdpG7EcpKkYsPvq0XplopcQZ1bBss2HboBuCiyUbrrSYjMRhzxl2K11qWaQA9KX/Dz/JzFe4+9rEGj3E2stoO7Y3NI+1ciPlkCucMfDQtTJ0Wg+Lk0Bgvd36nDjEabbADwTQbOpQvNAeHEvhj5HtWytQsOwxiD2CwWnHWAVtpUwIWMqpW7zD2GkM2PrWp6GgEkZ7ZE5nckLN83LQGvVo0LJUe2ScRuZBToA0pxnmKRHWQP8FlEpCDYrO2yUbEQTJCYo/h7PIpsUJ/Aefv5mJMeKt/fTOVqT/YHVdqjTPYC4C2tARFBaWv/xJzMQL6reGoBiOZXxzs2pnvihJKhV46deA/j/TEVDcEWvTmZp83fbDXxjSmJtMJf/6OlCDr/YJdZnwVouJGVWixsXFpL40HQvG5ppsXXajtLl3+VAxVqZJCofJV4PJVe3/cqaTM2MxaW3FM0J2WZFkWTQUWm5OA2/uV5q/mkzY1SjVI/wjox67FYC1ggV2h24gF0gkfbUtMp2hG0uVE84Qcpjg8llDZcm8x1Nw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(40460700003)(36860700001)(336012)(426003)(44832011)(478600001)(8676002)(8936002)(36756003)(40480700001)(86362001)(70586007)(82740400003)(41300700001)(81166007)(70206006)(316002)(356005)(4326008)(6916009)(5660300002)(6666004)(2906002)(54906003)(82310400005)(186003)(1076003)(16526019)(26005)(2616005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:09.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b7352f-6bf1-406a-8e2b-08db6d00e9f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

This partially reverts commit 94bea120b3f5 ("drm/amd/display: Fix
possible underflow for displays with large vblank").

[Why]
The increased value of VBlankNomDefaultUS causes underflow at the
desktop of an IP KVM setup

[How]
Change the value from 800 back to 668

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index c9afddd11589..d9e049e7ff0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 800,
+	.VBlankNomDefaultUS = 668,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
-- 
2.40.1

