Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F35FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCF010E6D0;
	Thu, 27 Oct 2022 18:41:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF11E10E6D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP0y4EppoW/F0rtSNlIQ2kNkumw5i0dYUnsfKzEdMtM/BhpxuxgFkLnxNi6cjMO+/H3iYPzlM5qkgyN09ZH9jxuZBNzc9BfBSOdHs9ZRmuexUHO7TilIyOK+SYAmSRW9dGO52aznpvLMy5FWAF2LvbkC3/+9k9ypm6EX0kim804oXg5UHqy26Mmnswg8q/Ln5lhdJRU+TrxstX13f/6uLQs3n4yAR5X7lOMysgBbxLeKQ5QViGChQuIb+/bsxr7dREakZEHe+UTNgp3VpuODHe1qqHUN1XCt7OV+9Sf+/+D3KUd+k8Pb/bnBDSVyzvv0oHcKsw8qI9nk5MWGwCnvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWhY0QCReFGjboTEeWrLaJ8qyQDan91CmjEaLFLI+H8=;
 b=ctT48opUp+r0zZunJss2pJXCzaoKyN/LyIZvSeCBsY6Fdqqs56P6oAWkyXRKfWdysmhzBPjEC1iiAqvIt/hHkBM2by6bQX+OIvMNbENVEu2/UMndQNwVu2BFdyiBkbFeq+0b4FC3pA9tqLMgF7X/BtJ9//P19s8eQn73Yjc6PSMku90Y9JJND8bP4Bu7i/XIyViQE9FCiRwVYta5FdhqsHKAsuGLdFTR7wuGfbuApxt9HNJSlJJjgD9ZbPJxl3U5RWz7w2G3AoJPabANgmqLCrtQsz04cTwwFEy98m/r5yf8vvsrGQm8WfvyQiZdj7ueJKSVkYW/h9syyudpu8GiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWhY0QCReFGjboTEeWrLaJ8qyQDan91CmjEaLFLI+H8=;
 b=XsYPvzjPRDz1p5rNAOfJC15vCqt2AF1Pd7wici6ofKj4/HmhZ5U+Yk+ePm8NLcrADPaCNev0ByedFxi3A7KeorZzb+/x8diQqhXLxJWvLL97RlQ8EULBO8ZGaZpEPRMAVKe4qUNyE3RVqU6YXdohxawh4hAbl264QjB1gK5DwCo=
Received: from BN9PR03CA0121.namprd03.prod.outlook.com (2603:10b6:408:fe::6)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:40:59 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::8e) by BN9PR03CA0121.outlook.office365.com
 (2603:10b6:408:fe::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 18:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:40:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:40:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/18] drm/amd/display: [FW Promotion] Release 0.0.141.0
Date: Thu, 27 Oct 2022 12:35:35 -0600
Message-ID: <20221027183543.1117976-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fd5501-1b85-4bae-7029-08dab84acac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nvH8sP0gU4sYrUkuJCW/pMYV6kqLrfXXIPu/NCDN9lQbEmyvaEyd89EnZGJpJM8o0IvbB5p4UUFSMSWG3f9ntbqf/POvsIugRVJ2Ende91v7eTpCyfwDuJQNxOsx+4v0l/aYA2eQyYmYJ8AeTQnxv/myCUkm84xDph0/lmtDVYU3VqHjQHFU4pUafajqRw054//Tl8+eE51Cy7q+W4+cgyY0fZDmEhD6UfFMy97RC6SF+xuLa1oWtgE2Hhn+XS5PJzZIbw3gJKEGlOxIcq6KBFa+9e9u6hf3Re2H2362u0scRaJINIGj8BZVdj+mrrYUCGYcazirCG3EF1beR15elG6w0NVwtJyHHTqPW/tTem3Z+T+aAK1QbZr7EzyVAYaJmF0g+QFLXPo+6cQw+CHiYpG8VnWHmNRrUcqxAMRPxUzxHoo7yaWWNkuOpiQCBGyaG0ByfAZ9cBBkfC1Amr6yMw9BkUl4oKNVZStEEaNNClpCjqCNGkFxTVarln7yyu9NwYX6dBdupPQjcluw9Hf16Y5tf4bJUdLRq9Lx4gWBysfBSS7M46f4ejmCWTBQIm5+xnfCf36lIUNQZVwNzbqh8fApB7JAD6OK2ydhUOlb1BxZLa6iMmlUetue03JU0P2TWjmWrr214f7Leg39HukR18RHGzVe0OgHJdhkTnji/MI4mqm5iYY8zBodjYyR1wmjika283WOTymFTG0xJR53mS1hUdcWu7+EeznCvfSYZ5OAOA++NA8AQkXR6kw4t1HImoR7bDLDmfz6JgnXlGmokGZaxhTiAV4kO8uGa9yM7gSjhptZ7iTITDhTthla1zV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(478600001)(40480700001)(8936002)(4326008)(5660300002)(83380400001)(81166007)(41300700001)(2906002)(36756003)(8676002)(70586007)(44832011)(70206006)(316002)(186003)(54906003)(40460700003)(16526019)(2616005)(47076005)(426003)(1076003)(4744005)(6916009)(36860700001)(82740400003)(26005)(336012)(6666004)(356005)(7696005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:40:59.5102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd5501-1b85-4bae-7029-08dab84acac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

 - Add flag as a status read back that indicates back to back
   flips detected during psr.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index bc9344af1995..9df330c86a55 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -225,6 +225,12 @@ union dmub_psr_debug_flags {
 		 * Use TPS3 signal when restore main link.
 		 */
 		uint32_t force_wakeup_by_tps3 : 1;
+
+		/**
+		 * Back to back flip, therefore cannot power down PHY
+		 */
+		uint32_t back_to_back_flip : 1;
+
 	} bitfields;
 
 	/**
-- 
2.38.1

