Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83747ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD3910EB4A;
	Sat, 27 Aug 2022 02:27:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A14F10EB4C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPQ/h5pOlPI3aSDqmJpPT6jqf5r1zReGhqfEGfSa4Br68FfmQohpFRThFISlHQW8wxiMMRYrCMkdSJsIq5C1bCB6Q4otqxhQBDiv5n03ZRA1PCYiWQO6rqWqlYWImsE2+Onc2zvBiYlhwJ5YbQ0gSu0Eh1U6sNpGlFPcKOKMEJm06ZD67iYPtrcK7s/t0lT/CfSeuc+SI+tNMjCB65uSyFEpi3tSFT2XTqxQfeFi0sDVeA+WZxkAgGtX1+pspaFNOJ0lNrjDQlrXe8zUAYopoV8hvvPYJZFfX13S5k1sQqmIXUzmqSUjW5yls/bANm+KRP4/aBhAVtieAbuFwENn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vkgJQoCw+jRQnQ7aBe8dy2imaG26MYgxQseyo4gvXY=;
 b=a1SKeoPq7rJDmMZKN70FobU8SC5xvkvB3cFPYDM8wd/Jts6kp9EOHGd17sfAzQxK84sq7DTypuFT0MoSzefGx5anratHibbWOPDCAGsHIprrOjmut2CrwIX1l0EflKjjJtkXBDkYh1oKS/WsahWGEDCdjmBMj7m3FEsdvBICTa47VyZWkkEt5aNDKOQVdJ+bqhVSANvthDBJH8MgM/DcSPgANVUnLMVIAyalbjNIHWWoM9Tit9MMsoIkzWdFgVx9CdBCSY5Lm9LON9crLzfecxD1lvoWAVutmd6GJsb30oU1Yvp5ij6qnfZ9jGQfKSB/YaloSqk8cBQcfG9qYB72eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vkgJQoCw+jRQnQ7aBe8dy2imaG26MYgxQseyo4gvXY=;
 b=N8LLy8Oz8LM7iSwjXII1Q+ty/mKnkMIjfvzNWlSZIreLMbYODR7Sq2XKEO64rvq8KdKgPKUKNMJV8lSSTAboAoXxzHEmeQ6EoR7kuWWcNi9bLgcXoAGFzTJtAqn2d2SSjbfIALazYnL2FbtITaNR874Rb1zj4LAETC61uC6U+EU=
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:27:23 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::a6) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:05 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:27:02
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: set dig fifo read start level to 7
 before dig fifo reset
Date: Sat, 27 Aug 2022 06:26:56 +0800
Message-ID: <20220826222722.1428063-8-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809b7495-9a88-4c64-5172-08da87d3acf8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQmypI2BnZ6Eck6MGD1s76gjEDrNSA/1Jp9WUDe7AojPMrDpykSH7zHIyDHrJqAGw3MolohFmWR1cNEFrkZQnbLAP9U6J/iDFED8OcFs3M7beg3lkCo6TjKNO0bteeuH7jHEwpQSku07ug5U9pH5989iXtSl5wZCm3FWqIys7zHeuWYmMtUx9bB4fAMMmr+u6VmKFiCsgWDZAfAXd2YXumiGwQe8/0Q6cFia+pQXL+WpVBIRuGqsBEUFR48PXQmd4usVktwWzyfR0Qis7zf/MfMuxzK0Zp+JNjfq3fFcKQAmjxBss895CsAajDlAcDg00+qVeQcN1fTF+RqFz6sD1/Eb110tkalUdLMsSZGAN6yDD8ZlIIQQiXY79zVspFAcRzoHeFfdfzntlyvvuSMF1wVuDafG+MIhvGbgctzf5KKXJcwEI4cTC2m/VgY0IQkt8R7mqWZ4Qv8cBT+DUGCTrG6ebj+xY8o9Nv1j5t8sORY1sn1e3wIRnk9yueOfqFCI0UK0tui2DucQPqroC4jRtLg9/0zZmCbsNNv8d4xOxwEhErs0cTIIHhoqoMNVjpWrhhHA9XcW6aqJd5OjFoJyOYv961rTWL4lcjVE7DZjGgN5GWCNK3uR3kKmx38Z1IiGFHWH0E9zMjD172pPC1c1GZ5RWVswnq+vO+PHXAY0g16e3WQwC9taK3xYRUffB+hYGyIoaHKfALPSRt9eKKK+Na+IXNZE5KY/QCD2Dy/RbEuCPoj8AzFHsuFWovlAbhzDs2TO42z6tOCxNUYZUK2CnBkfhazxX+RdiKxzB0wLDTqio9LoFHio2tgM16li8wQZuAkqQn4wb7l7Lxd+RucDAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(2906002)(8936002)(82310400005)(2616005)(83380400001)(36860700001)(478600001)(5660300002)(40460700003)(36756003)(8676002)(47076005)(186003)(426003)(70586007)(7696005)(70206006)(6916009)(54906003)(40480700001)(1076003)(336012)(82740400003)(4326008)(86362001)(6666004)(356005)(81166007)(41300700001)(26005)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:23.5056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b7495-9a88-4c64-5172-08da87d3acf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: stylon.wang@amd.com, Wang Fudong <Fudong.Wang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wang Fudong <Fudong.Wang@amd.com>

[Why]
DIG_FIFO_ERROR = 1 caused mst daisy chain 2nd monitor black.

[How]
We need to set dig fifo read start level = 7 before dig fifo reset during dig
fifo enable according to hardware designer's suggestion. If it is zero, it will
cause underflow or overflow and DIG_FIFO_ERROR = 1.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Wang Fudong <Fudong.Wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 26648ce772da..38a48983f663 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -310,6 +310,11 @@ static void enc32_stream_encoder_dp_unblank(
 	// TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON
 	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
 
+	/* read start level = 0 will bring underflow / overflow and DIG_FIFO_ERROR = 1
+	 * so set it to 1/2 full = 7 before reset as suggested by hardware team.
+	 */
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
 
 	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
-- 
2.25.1

