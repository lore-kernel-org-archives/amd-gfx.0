Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC300C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DED10E138;
	Thu, 20 Oct 2022 15:47:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D79B10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhDojqFpuUvDxPZJPDn0iqdHBq4SfM3sIbvhZB5ACaBKedj946OPaIe+ZuUg9R4IZpjNoofq9qa8P/Z0oNjLfc5bzEm5n/sQ2l+uIWm9rQtGjEEFavDZ+eBeOgtRlhKWzFqcTK+lxdZXj7ZZ5DzUO28ZmzHoKCO85SNwXyM5s6UU0wv0YEKwCbXgonIkgBPgwuFKfipEeDkcnlAMqMp60TRxSbhsGhMfd4CaHedUif4KZ7P4ppWkxWRihyuQvqJdgBRPfEG3Q+BeaU7njtmM6Ze2RRJF8Zpl5++gnDvQrqOQx5quWMSAiBd9byvigJWUMZxjv1AoWztRxUrX2eqVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl18Mcwx30BOWK7Ulqcmivp5QSc55p5MHoGwveO4XWE=;
 b=IUnqLfpHQq4Ups+hCS9zIxjXNtRkYvYZ54mOUO8xwkPOYQ75b9+LokBGk/mDj0DjVds1qwwqSCh59kATHueSl/+WHoC7a/mNaU3mPU5fwz1I0ldLP/BHQ0pF2YhddO7VxjxF0zurObTzGQVAbZCxRL2kgpbNurib6D/6HpiIlMzxEa8Oa0pjAnkMBc0DEyfcqkTD2m2MLR55Gg+wLqbFZnl121zojFPkZ3g6wNm1H54h8J9sKu67Gzg6vZQpAEC0AkMhTZl61cZxinjhYic9hL3lM17Hz2R5+iP13cQSjQNUhhWda33K4eUiUjbENbui/XniFHFDskP6sImPgTGVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl18Mcwx30BOWK7Ulqcmivp5QSc55p5MHoGwveO4XWE=;
 b=lmUq3No+BkIF8NSGeDctjVJ6GFRLLIx6aMFL1swl/9TDYybt1sV3H4eC5JLhuXj4n+taajAoTfpHbOHrmIzimj2A9bgeieTdYZnyhQ5DXcLX/yqCIvFiVSsYr45wBoByDGvBdUMHnKYm63M4eJcT+KQhLy1/MUzmxpzU5BOLQd8=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 15:47:32 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::6f) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:32 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Add UHBR135 and UHBR20 into debugfs
Date: Thu, 20 Oct 2022 11:46:30 -0400
Message-ID: <20221020154702.503934-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4fbe15-4062-42bf-57c0-08dab2b266a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeMjFazOuKzWKUV26/ZOCslpdJHMMr0fC52mn0j0vyPpJkaPDL744ARxF4B/Ipq/QZ7iyDpyLAyjOJUYg1QVatK/ZhxZElmfyWLz+Xg1ig9ngA9gjcDJuAIGialMwq3gunVKZLjuKnLEj/nj0uILkNlY0Qs1WXSJqW0ofuBF9Wt6kW9F5BaOwKV3UBqTXZ9c4oBLkv/bpaqbHwUNpQgzxmUTrREKIsxCmTu3eCgyhcn1ZLef1dgH9I8j7LTRxJykUsFFhxF/dlpBZH+UZwadpOn3z6YsdxM5vXGgve9Y11xotMZa5tzHRswmEC2c0Q6urxFigE05YnbAbtSKHiJm1iDmpigQNTfmZXR2A3znDEyenU3vp7LlzI5PX9kPp/ow5t+M5wOyhshcToJglhylFaCdrgUlMq1hMD91cfrNDks20dB7uvVzsUc1MNHL63/dtF21WtLLprH44vovpeyii+4v7rQvYHiitCN0pnY33mWOJOFTIa7yHr225q93JIBUsBHdCyg7SLhCF1GwWzG+BrdD6ft9NIGcCgQ6TGWtuNpTq3NBEJpKY5k+4F7rolRM87b6sEA/nIIgQP5xUXz8EmK76VY8aizLsd4KmnZ1bX3v350Ux+lQo7g6W3nRVR6S0cjI37h99m1WflXzNCZbMJKWj2qxmKc2HqG3eGUNXuYs/n288r5PQQ4yCmqHviOAX8DxyUV2qAzk4fJ5vs2I3LlPWizKn8VlXsxUaOWC3gQzhONBFRfcasA2Pm9V1FGiEXgKJYiOzynKjs03vRN80eB1SPCdWFT8i/NflQWr+C5eWRthwxuuhzQFLZWBT4Do
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(6916009)(4326008)(8676002)(4744005)(70206006)(5660300002)(82310400005)(70586007)(36860700001)(2906002)(86362001)(478600001)(36756003)(41300700001)(8936002)(47076005)(7696005)(316002)(54906003)(186003)(16526019)(1076003)(426003)(82740400003)(40480700001)(336012)(356005)(81166007)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:32.1428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4fbe15-4062-42bf-57c0-08dab2b266a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Add support to manually force link rate to UHBR135 (0x546) and UHBR20
(0x7d0).

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9f66b0ed7ead..007d283fef46 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -299,6 +299,8 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
 	case LINK_RATE_HIGH2:
 	case LINK_RATE_HIGH3:
 	case LINK_RATE_UHBR10:
+	case LINK_RATE_UHBR13_5:
+	case LINK_RATE_UHBR20:
 		break;
 	default:
 		valid_input = false;
-- 
2.35.1

