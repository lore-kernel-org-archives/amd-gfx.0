Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB052C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 21:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FF761213
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 21:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72FF761213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E066E1BE;
	Wed, 10 Nov 2021 21:02:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A296E1BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 21:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DshJVsa67cllKqAwyPHJDBavvnd7KlqzvyBkwCq6YDDz3kVrgraJVyw8h8obpkqNhI7nKd2xXiYZfY4HpVB69J63AZsnRs/E3bNm+erRA5Yo1ahsGjj9UgIicK3uJ63mU825HLRZjUEqfF6jg62QArqpc4e64Ey4UxY4XlZ9gi2VlLzmSh4WRV98YAAJSWvItGQbAQIO7eBkraZpLkvROzOFzOxqBmZAeXNJRpb3wrblTqQ0cS1PcG04d51mpn9CxYwNmlNHJff99nbnXiIDD+KNDj4YHmFxdRQiC8xjy8zHWuP1WbIypXm5sCUMGKuIOTaYAs6dMNcscB/qrjfpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvFiKujJIyehMFskzD9CJsKTc/Vp+xK2pptA5j7Lo1Q=;
 b=LGk+p/MX1rQYz9fGzjPSi1I14A2vgTw6l3HD3ZEKhW/jGD++vBHLZh/TYDcrLu+VJDG0afKmBxmCxaubZ25bX0x+7PeN9Quk2BcryzxHaV4Zgr/tcbNGgvdvolBCL8WXy0LkXvKobcAj5QJ7nFNMtj8bNCk+CpB/SBFHRhnasbBaHRThwnm4kMtHAYnW1MTj1KuZAt4g+5pvYPCyKKrfAcV0GG4Ms5C+dAiDaiJCwClmb23Lesy4UK8WVg/I7w98UNA/7sMyFq1CkF4TiRmL+9Epey65FGqbXYQ3UKDCqJT3gaU/yPeXlcNBDjLX2KCDkaZ0OcF9jYeAWhsv2W4eZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvFiKujJIyehMFskzD9CJsKTc/Vp+xK2pptA5j7Lo1Q=;
 b=BE4AcDWbZKkwJ0mqi109VDTkebkW8jIldm0FiRrW8dwZKvi6PYygyeNN0JPLr/s9fb77KaiaHPR8gwkff5nxMDFzk8KwpME5czDISVobUIB7h7facvUQcGEdtLX5zFyOM5KChak74l1wDT0cbtdf4OAeeAxktmJeQLzA6V2t1iw=
Received: from MWHPR17CA0096.namprd17.prod.outlook.com (2603:10b6:300:c2::34)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 21:02:43 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::6d) by MWHPR17CA0096.outlook.office365.com
 (2603:10b6:300:c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Wed, 10 Nov 2021 21:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 21:02:41 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 10 Nov 2021 15:02:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enhanced reporting also for a stuck command
Date: Wed, 10 Nov 2021 16:02:21 -0500
Message-ID: <20211110210221.125336-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1282ca64-dd3b-45b5-0d8e-08d9a48d6f8f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4962210434F0BDBE035D179499939@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhNq+aziBAsRf4LNFDpO732ivl/jTeDBAMA+E1FfBkIkn3aqu0kkPong2NmyBLzeeSMbpydbZarb+DyzkaT9W5N90ZJtoVPSxpY8dGmf0V4LAFeNLlXPhwycapS0zI0oZh7uKSPsL1XCjqN3Gi6QkEwYzOu0PST28rncVSYjXA/3LKZ2fk468WOdHSRgSJv+3nJjdUrA5vIiAQKqV33IvnUkHpH9ZVLLk/BYwyw43wNyix0ellmTJz2BL9rtxxTE6gTJZbFSlbSqgsdHfpibf/nWLViNxViIzzUZ54YUnSlDKi9khDWP3bRN1Czf62H/Q1wcBUFBiFKd+IVJbXwrfwZacec1XbYpZsAD22IZvTcDSh9drcEiyfOyji7UFZvV8QbUwK2e464YH6op4o6SOnMMNtl5ugwSiepgskVXHY4yCncoYqJ2cElwWwZzec2hUaZ3RPEb9TzKn+kJmspFQhbXFAbZxT1MJi5ysyX0UVs42LJkwvzmC78XAfFpvLLNn+/b6xH87wPYVF+rhxsubrVLQgUqptX5RZugq6hYRhdEN2iv73mGjcGlCs3IA9G6zWKHVuyxWpW7nMF/KufilQzat2EMnJ6hYsI8/oFuWxpDk2YwNglj5ntEllcj6heARPIbNvvbJqRPjV/sURIX1JotX61XHoSHqaHyFlsvVMm5+6rlhcAn2o7Q3LC34Z+/GC8Xonxk+gboHklPENwsELzdueW3allAv0WHPwkT96k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(70206006)(36756003)(70586007)(86362001)(508600001)(6666004)(81166007)(82310400003)(356005)(6916009)(1076003)(83380400001)(26005)(16526019)(54906003)(186003)(44832011)(316002)(47076005)(2616005)(8936002)(8676002)(5660300002)(4326008)(7696005)(2906002)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 21:02:41.6986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1282ca64-dd3b-45b5-0d8e-08d9a48d6f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also print the message index and parameter of the stuck command.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 843d2cbfc71d4c..ea6f50c08c5f3b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -139,9 +139,13 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 	const char *message = smu_get_message_name(smu, msg);
 
 	switch (reg_c2pmsg_90) {
-	case SMU_RESP_NONE:
+	case SMU_RESP_NONE: {
+		u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
+		u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command!");
+				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
+				    msg_idx, prm);
+	}
 		break;
 	case SMU_RESP_OK:
 		/* The SMU executed the command. It completed with a

base-commit: 14271bc7f5e7ec276c58927ea87af9e81d97fdf3
-- 
2.33.1.558.g2bd2f258f4

