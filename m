Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2541FEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A642110E5AD;
	Wed, 12 Jul 2023 17:13:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5841C10E5AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxMuI0dd9a0OySjlK5xrtup6jn0IoUnP6XyWjRq61pl2QLeirso3UPXnC2dido+kMn0dwhU0DBr0teKtGMh7RJIl8EGkrfV0ibOL6yYDMN3VrANozTPLWPjF0a8h+uGyQCpT4Q+LwO9Eu0s9agNz6a5zKrmIN/dLRfqvnctK+6wTjM8zaHEupazyFLPIjq2WZe8RZIOXxykEKSUA393ssIfO33/i5hHTB289yga5IFrdzsliJTEpxUSV5jekgQfRyh8q/X0zLiKp1Xg0r2fljhoYvc9YETqwK25FsnTsikAis1L8whItAIRmd7/Ethz/Ta2Nc8kQiKHdn+DiPnF59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aQPUhBX28dtyBE1sXAi9Io/M4ZDsJsiAkGcdXQL4LI=;
 b=id+yD87KHnFCmv1rsBEHW+4kDLKBTkj8ECJVSaFfP8CEX3o72Az8ddLYSbD4Gk37itEtH+7cP3uAQ65FfBJiGUYY6PmhC1GdAcdupeCCD4oB9GBTsljhbVNTUuMYu4XrkaUn4N+fPk6s3LnPI8gh9ExsCNYdCAOm6q9omNUT2r33Q8bP3AmNpeCjFmrNw9o07eKqPKvGXp249JRxa9s/xeNXrGIyiI+ADWjeVXBEim9IctaG7zzh48ULMTK2hz/XjnIt7OPUqmYn46lJnzDvO2OQcXV/sxJyzYVsTIJmY0yuzZs/qs3DWiQIKdj7fOU0BQbGpEORXDgKWyJHHQzQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aQPUhBX28dtyBE1sXAi9Io/M4ZDsJsiAkGcdXQL4LI=;
 b=Dft0eCsws9kHrV5qBb3x8MWHfmkNftkXaLSHGjtduKIkiRAH2eLQN4mNIZkWe0hTD5rVLJ2+QRdESudW523dcRMo9xp6iNHW/0J7uShrugqVugloDdU2yPUxyAXMDhAKkpAiEYuWwo/ZFxy5dsPlWJuV6+LxcH6LxfcHqEgssNQ=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:13:30 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::a9) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:13:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:13:29 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:25 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: Update 128b/132b downspread factor to
 0.3%
Date: Thu, 13 Jul 2023 01:11:19 +0800
Message-ID: <20230712171137.3398344-16-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: c9709b04-518f-44d9-98a9-08db82fb507c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KaAub+2dptFlvl1DNDgFENcxsqDa/1PU19QCmZT4SzgcYlP4Aa2bpRm5qVFGk6yhHNK/0hwSsnHqP6e2xZWsEICKErFQa5o43MCJaL5/CvhoTFAjsZGeiPzGyhD4zYZ5iazmnIDGwCSXt7IWkCtVErVWcnDBsoZiz0dF5yCQWdaoTN7zyUBGxiUjeo2bpAP67hvfi/qYe7MyDTp4l2jN9+xhnZOT7xEw4WZSxIm0GFlF4X11UzATh0/SS+OPhz5FTtpVO8RMmxnhf5ZNum/MLKFqIfokTFi13BPLufsadFlD0HbSybU7ilgAb08YXatQskBSrq5ZzKcISx2rzKRSGVTpNLUOBSKZqQjb6tggC5Uj/SXfIBASeJGXiVcZY/93emumWAu8wHvoczkjSBOFL58WScQO4Vh3rD5K/8mqh3grO5wN4VIfWO4z6QzTeGcr2amQkPaeTGkrX+GmmOcNcveZkFWcmKdu8No2x/CN7NqhVYqOrjc3XP48p+FRYSIVxAQUNTeXRd4sEvAEIvfoHB0xbtaoJLQD32GJRl8vkgdjuzFapGNa050k4MoRLhr6eYekmnMPY3g/tKJROFyyLX9u70szZnxJPoyw1KJOwOa4vALc794jLRucApBZARNK4r85OdJkSjoJiWrJn82H41NbvcMsohzSYpSmzYYcwWVDrkZzZIWGFpOXtUUxe0KF/IV8a1Lc3imgc0m7WTpUdy+gNAI3I4xhg9CZf+rZMaR7r1rTMcf0SzH9i6V152wLski/9XQWtx2SuQHErLDKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(40480700001)(186003)(15650500001)(5660300002)(2616005)(2906002)(26005)(1076003)(83380400001)(336012)(426003)(36860700001)(47076005)(6666004)(478600001)(54906003)(41300700001)(316002)(8676002)(8936002)(70206006)(70586007)(6916009)(7696005)(4326008)(82310400005)(86362001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:30.1333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9709b04-518f-44d9-98a9-08db82fb507c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Updating downspread factor to 0.3% to add additional margin to account
for potential link rate deviations (up to 300ppm as per the DP spec).

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/include/link_service_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index cd870af5fd25..1b8ab20f1715 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -53,7 +53,7 @@ enum {
 	BITS_PER_DP_BYTE = 10,
 	DATA_EFFICIENCY_8b_10b_x10000 = 8000, /* 80% data efficiency */
 	DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100 = 97, /* 97% data efficiency when FEC is enabled */
-	DATA_EFFICIENCY_128b_132b_x10000 = 9646, /* 96.71% data efficiency x 99.75% downspread factor */
+	DATA_EFFICIENCY_128b_132b_x10000 = 9641, /* 96.71% data efficiency x 99.7% downspread factor */
 };
 
 enum lttpr_mode {
-- 
2.34.1

